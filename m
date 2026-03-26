Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9E710A88C1
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5mQJ-0006oQ-Qc; Thu, 26 Mar 2026 11:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5mQG-0006nV-Na
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:15:01 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5mQE-0003Xi-Uf
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:15:00 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so12800175e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774538097; x=1775142897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YE9+h2i4RvzR3onivFp5H4aWHHi4GJ5Xkoix8IA7nG4=;
 b=Gkm8hfVRGbgsoZoT9g3sm1hDGFssFvrsZKOGCB5yx79xodMzOTvFxR9kl7aUhAYiKn
 aSA8DpMVM3vMz+zlR1WGP7uHowmCHVm+Q9qPD3wtOlwfGyEzDTIEeKmem0OPDAN1eEsC
 FfGWLl7OHpTGaaGfbty+OW+0Yf7FIfAda0YR6JBhg0Ede5CQ3HgRDAZFl0pN8ciVyu8z
 ATrzqQ9huTSjR8O2XMkCV99NrlyVvnrGm7VXmnyjHdiUe0KiMxZdCuyXfsuDmWtVlDiO
 rMMbbWCKJhulrer7rmbRVcQdXPbm59zuRzsrrTVuiXJjCnykeIilndEL/OJYlRpdHJU3
 YWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774538097; x=1775142897;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YE9+h2i4RvzR3onivFp5H4aWHHi4GJ5Xkoix8IA7nG4=;
 b=B+d4ACgy0UMvuERnSDWBlZizr+AI5k0P7qLbp5NhY2lvNDEkuyTw0FPXIpZKcbd1+9
 kTHSZ2B2pV9RiRbiY0ZB1dl3t8ZF6tGpBjftXZC45qVEIg9bmz3QqgMlGt4LPC3sNxU3
 3+T6N80a3hwOheoRkNA52WV90l/vZ3544J1OF0a9K/GToXHm5LqHGIQ4VIk9nCyum7Wf
 zvUAYAYBYFqAdJhHY6d97N7f92FrVIQZjzsWhVdQ8sGyTH6bFLX3wCuQb+1hC7fJT2qu
 KDTeAmE/mk5CIX5QQRzdbH5pONugxCzf6sY8jg3pfNJAZaIDKNYRAWV/GrzDggZaancG
 k4Aw==
X-Gm-Message-State: AOJu0YzWvjUmqLCvnaAL2FVAZmvHzl8UVHhmJ8A5GyDNPxlQL72+YyM+
 xKSXpqdJKkL86UgFApfInqcPDkY06j+qoL3D/QXjQ/Ryx/FNgNxiDfpBe3UCE8OTRJI=
X-Gm-Gg: ATEYQzzCB4BmiNYlEw+my7GcFLi5kPe7lJGuOdP2dKrr/p4NlYc1rvyWQlLGfgUUkE3
 DcyETf/OlXwsvreMWVEsQVd4gnFEZvYb/Og6ByH1eBj0g9knMVOftg/7wW6Rep2M/Ag6OGwc2y6
 KXEuyriJWsDgAfvpkAAiibhO3Rld64ySPdnn+8wFyh4qVZAJppSki1gHaLdOkVfU3oP1NAl4J7F
 8GUWTJkfDH0wlDOUVx5TyHPOwqWNHCxSmXX9MqzodyRDAfJ0MugMBKANPm7AuTHl3zzWuO6oA/n
 kQL+VN38yqSVvSyfnfsL+N9kqUKlNZcmC8R9VhdQFuQXtidBCf/i47c2eG78j+e3KyZvfHcsHAd
 JP9w7G6fiM1dnZjVehJjaihVq7YPAK/wVj16N0wMdtDTU41bMVvjKqp3jXNSsEXJGXi6J2f/OKG
 QLeTWcMSpGFRdbwDFvxL1bcndoeXPFB8XtK1T2VsfW4MkDMcUQwYhWyJrK
X-Received: by 2002:a05:600c:524e:b0:486:d76c:fa51 with SMTP id
 5b1f17b1804b1-48716071a07mr125115425e9.27.1774538097058; 
 Thu, 26 Mar 2026 08:14:57 -0700 (PDT)
Received: from [10.202.147.66] (87.171.88.92.rev.sfr.net. [92.88.171.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722cb5845sm35632195e9.15.2026.03.26.08.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 08:14:55 -0700 (PDT)
Message-ID: <9228e6ff-0f05-40c1-8feb-8321efa46639@linaro.org>
Date: Thu, 26 Mar 2026 16:14:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 00/16] target/riscv: Forbid to use legacy native
 endianness API
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Warner Losh
 <imp@bsdimp.com>, =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>,
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
References: <20260318103122.97244-1-philmd@linaro.org>
 <CAKmqyKMs2km=xn3SH7-D1VqNDrJVhxgO9JxQ5c9rEGH7t7gpVw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <CAKmqyKMs2km=xn3SH7-D1VqNDrJVhxgO9JxQ5c9rEGH7t7gpVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/3/26 03:28, Alistair Francis wrote:
> On Wed, Mar 18, 2026 at 8:33 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> Thanks to Frédéric patch on 128-bit registers, we can now
>> remove all legacy native endianness API uses of RISC-V.
>>
>> Djordje: You should (re)base your "Add RISC-V big-endian
>> target support" [*] series on this (after addressing the
>> review comments) before posting your v4.
>>
>> [*] https://lore.kernel.org/qemu-devel/20260311115910.564481-1-djordje.todorovic@htecgroup.com/
>>
>> Djordje Todorovic (1):
>>    target/riscv: Use MO_LE for instruction fetch
>>
>> Frédéric Pétrot (2):
>>    target/riscv: Make LQ and SQ use 128-bit ld/st
>>    target/riscv: Remove MTTCG check for x-rv128 CPU model
>>
>> Philippe Mathieu-Daudé (13):
>>    hw/riscv: Mark RISC-V specific peripherals as little-endian

(Note the first single patch is now commit cf430fa1f1b)

>>    target/riscv: Use explicit little-endian LD/ST API
>>    target/riscv: Explode MO_TExx -> MO_TE | MO_xx (again)
>>    target/riscv: Conceal MO_ALIGN|MO_TE within load_acquire /
>>      store_release
>>    target/riscv: Factor tiny ldn() helper in gdbstub
>>    target/riscv: Simplify riscv_cpu_gdb_write_register()
>>    target/riscv: Expose mo_endian_env()
>>    target/riscv: Have gdbstub consider CPU endianness
>>    target/riscv: Replace MO_TE by mo_endian (MIPS extension)
>>    target/riscv: Replace MO_TE by mo_endian (Zilsd extension)
>>    target/riscv: Replace MO_TE by mo_endian (Zalasr extension)
>>    target/riscv: Replace MO_TE -> MO_LE
>>    configs/targets: Forbid RISC-V to use legacy native endianness APIs
> 
> Thanks!
> 
> Applied to riscv-to-apply.next

Thank you!

Phil.

