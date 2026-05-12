Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDBECD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMe0Y-0005jJ-Is; Mon, 11 May 2026 23:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMe0X-0005iw-0j
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:42:09 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMe0V-0007Jk-AQ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:42:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45297094718so3979489f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778557325; x=1779162125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fMVmnHgCwSMvKC4AadpHd88uFaK7gXkr9Go+ow59TF0=;
 b=yURX6UoxENOll1F85/Iqy5VvajSpo+WMkkEB1iYnildAZa+B3dEG5zc6XvtpwH57ym
 GR9NWUkGaAT+qOUXkZ6bWJBEepfuC0LhyQharQ7WzM8+LPLIZPPlNynN2JbM/dmudwqj
 3Z/J9pIQRZIuUONWdX3aGzR8GbNXw+DmCXCDyA6jF3m7vs4uS5VisW6Vm8e0V75swGnq
 Dc0HgqQKYP+c70GCUn+HeaI1jsY2qu1gz+cml/4KFBKW1tyzZPK8rr9Jzma2Cg/ipAtp
 9WiG2Q+cPHsetuSsu54qwaUQTte2b6ota9K4Y8jRtZlGgAvWEzteBdzS7UAOcKMXp96r
 kY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778557325; x=1779162125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fMVmnHgCwSMvKC4AadpHd88uFaK7gXkr9Go+ow59TF0=;
 b=C4c0fQobtk0QZ0JRI/cAwYgVn/y0K8pfRUPQDalM2gNc5WSW5TpTv3nOC3A5PbILPB
 0YbbInLa59HnFCKbzzUHjizeirUA2FQ9RIDoNhLxxxMR/mj11OQx6mjz/zQ4RkmFxoT+
 yuhUoQX9ekBsKT8c4JHZAloY7XCF64+MVcx4uaYrBhG5Hil3uhJc4Pji/KUzUOqPWU/D
 3scRToWxaj4S3w4fj5U8QLicQq5tjKaMatGKa0ND+u2+w752evushU/neQEH403Qrssb
 4AACUczknlh2q9KEWfRsVhyFbVca5z7gAOmXJ6xG4SwYXyEkaFp/fptdI12nmULj77fy
 z8oA==
X-Gm-Message-State: AOJu0YyyZ62qq6oG/WrbPZJqNUHHLeMsubjTn+pAPSaCCuGQt00NxwZu
 gPkwp4EiRxBYRCklrJJqnexEUot94b9me+/fyJLXEXo0eE27m0KxuQoLh0pOqbWN9yI=
X-Gm-Gg: Acq92OHQlxzbd+82MGZNUYFCssCsKys6aok/HRowYIUdIImps8sRWrpYMfMWo0qs59j
 F7ySMe3oEt6z+aCEbQejC+CR5/Xt4VCpeEFGcC1LnsEqL8UNJDO7SRMADyOe8I1Z9G2y4/LiQ6F
 52GpGeZoP5MFyaH+oeExbqoHgisb2gTnXFwIUSM49iq3EU8zD1zTNT/seK4JnqWGyHRouwl0j1q
 Mr7bcKTTzwkkSmauv+14HTMppJaLuIPLhSToROKv6TYle8FvmLa32AMZSgm2s5tW+jbQmx1QkPs
 VmD5Er8n4fGjj1cYF2HqTx1m/JKE4td2f2WhgAn7UNGbGVYU0JYPkJlI4wC02JeYeavnncV0tMC
 kBwvFGQkkjK+TUXv0I90rRDJ4EJUJDVXSxZ8YBVLFrjxbm1f8iOFv3RfJ9cWlurotQm9u+w36Bh
 w+Zs9vYwzBqSy2nRCOEwYnXVawp5igbugzd84ZjEGa7hRgaC//6Ryb6jcnOASNaYetSjxkltBu/
 CHx
X-Received: by 2002:a05:6000:2308:b0:43e:a70d:7622 with SMTP id
 ffacd0b85a97d-45b137909famr1334836f8f.22.1778557325342; 
 Mon, 11 May 2026 20:42:05 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120f1f9sm29873609f8f.24.2026.05.11.20.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 20:42:04 -0700 (PDT)
Message-ID: <9a6f4a8a-9917-4384-b36e-9eafe2461725@linaro.org>
Date: Tue, 12 May 2026 05:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: target/riscv: rdcycleh problem
Content-Language: en-US
To: Antony Pavlov <antonynpavlov@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-riscv <qemu-riscv@nongnu.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <CAA4bVAFS4aRjW7On7C0Y5MQH94TmLfXMwcD+8dWzKBD4JZL3Fg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAA4bVAFS4aRjW7On7C0Y5MQH94TmLfXMwcD+8dWzKBD4JZL3Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cc'ing qemu-riscv@ list

On 12/5/26 02:50, Antony Pavlov wrote:
> Hi!
> 
> I use qemu-system-riscv32 v11.0.0 for running this code:
> 
>      15258:    c80025f3    rdcycleh a1
>      1525c:    c0002573    rdcycle  a0
>      15260:    c80027f3    rdcycleh a5
>      15264:    fef59ae3    bne      a1,a5,15258
> 
> The code is recommended by riscv specification for reading 64-bit
> cycle counter on 32-bit system (see
> https://docs.riscv.org/reference/isa/unpriv/counters.html#7-1-1-zicntr-extension-for-base-counters-and-timers
> for details).
> 
> When running on qemu-system-riscv32 both the rdcycle and the rdcycleh
> instructions read low 32-bit of the cycle counter so the branch
> instruction always go to 15258.

Interestingly I'm having similar 32/64 bit conversion issue with
the set of CSR functions in my single binary prototype due to this
target_ulong use.

> 
> This quick and dirty patch fixes my problem:
> 
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1389,8 +1389,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState
> *env, target_ulong *val,
>        */
>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
> +        uint64_t t;
> +
> +        t = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
>                                                       ctr_prev + ctr_val;
> +        *val = extract64(t, start, length);
>       } else {
>           *val = ctr_val;
>       }
> 
> Have you any suggestion?
> 


