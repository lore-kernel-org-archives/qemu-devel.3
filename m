Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B982110F92EB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 19:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ej0-0006vs-F1; Tue, 31 Mar 2026 15:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7eiX-0006p9-9C
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 15:25:53 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7eiV-0006G1-BD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 15:25:37 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c76b994f7a8so269008a12.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 12:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774985130; x=1775589930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=M5+MUSintDXcTjCN6QxiaosbQff20SwE6XZahJi7es8=;
 b=vpj311cejoJicl6EY2fixT9KC9ASLeyTVi1W5Yjg7/eJaqcQYWfISI9W6G1z9AP0YY
 PWaGdK0erRtiO8roMY6cSOpE5BlZ8yS07cK/uGpgEZL1YcL8H5ubYyJv0J6kxbQewqHX
 4/k6qYO/yFPe+eJATnR4NMhgERn3fl9Boe9r4riOIoaHUIoAw9+/+5vkmsTYojVo9pzo
 uh4t7jOJ85BKTBY13QQ6dvJcdURiq0rEQttfOTCR9MDoEmBkknNyBJeg+xeH+GsNOsUY
 oB+7sWTWbnQfacL/Hur970V3OeIpaRR0E2hYCB5l1arWdk2ciJs5It0fN3eOK2TaaLKZ
 n8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774985130; x=1775589930;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5+MUSintDXcTjCN6QxiaosbQff20SwE6XZahJi7es8=;
 b=WokhdxMTJ0ZvbuegM2bZKXLivIyPqXP9vcKUhUN15kIIZUNQZkcW4FBCrTUCzD+Tvc
 fx6Bsal62ScdBsOHC2ztDCfLpu2voNnifmq/4qUzt7biVMKHt6hcxKxqmT6xY8943SIE
 nboH69LOwkBP2X1KcHdLHekKa8KKT3V3evyhnyLHvDXmj0uvRLZdtVeiTZo8t1Api4+I
 TJSJ87MR2rsLg7R/REBL1dzT3ZnBw8p8MHdxAhOHIkanxITW6zVTeU39bjmxj1/PoS5e
 Gn+t9xJ+HwoHu8Y1bAfDFdbFwm9yeTDapRmfxwOG1fCkRgS3rS3ULEbTK++IJ+Ud/w4l
 C1+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9fcM388hgLCNV0Hs+rE6GSgy+21TRjoN9g/pfzmwxN1SHy3ttTBxovCmhfbT4umZOGG4bLg/xuh+q@nongnu.org
X-Gm-Message-State: AOJu0YwKUPrnDXK+DDLRTueSgTAwsmKLkmrvSRO3rAnx8/bphjLOKAkh
 rifut9PnCMLnIFn0YzbMbdE50cIh3O34sI9sf7ZY5r665vidZ+yXY1WLnL/n58LO9bw+pi0APYR
 2uFfLu3g=
X-Gm-Gg: ATEYQzxHOiiUWyww1rvyUd8MjIF3K83ZuETkNIEqN5aiHk3TCifbP0E0RCRAUJys7Rn
 XOMlXlM9K9bqK+gCT07kfUx23hGNSFI/IUUnl3lWJMbBLLoQKgyDLUMzpIFv9cqSG1A/PXW2Q1Y
 Ig4K5P50FNfN82Z6J56NrG2gt0+bajUU+4UTRKyvwECIliE5E+x1/FaV7DWPmHeNZol0RzLgakB
 wYGNSCojSHj0Xw7j0XRMAJihe8JveQqr/KjS/+mkAaFQWA/3k3qYfX0BPUxflxD+LKT8wDftL3J
 ooeHZprmwgN8NTpAF9Dh7JJtxEOxKYmBmoED9vJtIzvXecQmK+wAiBmuytL87lX5CSo2gXcq+sW
 KSkUiOejraNWfpxfTUE3W0z0YrupcZ7Vc/HBYkPr5Ot7eRVKbwdQpvrg5plCC1RffYgbRrPdOSK
 6plR/lA+vosUEsdEzZYUBmlH/Vz11uFbaZ7tJnMJzPNGrJg9XxKIN5Ud68d5WJhJEISWuU
X-Received: by 2002:a05:6a20:94ca:b0:398:7913:8543 with SMTP id
 adf61e73a8af0-39ef7791083mr398448637.60.1774985130322; 
 Tue, 31 Mar 2026 12:25:30 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca85d60c3sm10363499b3a.32.2026.03.31.12.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 12:25:29 -0700 (PDT)
Message-ID: <22d61791-ea24-4e35-8c68-a67c0acb6aca@linaro.org>
Date: Tue, 31 Mar 2026 12:25:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v5 05/12] target/arm/tcg/translate-vfp.c: make compilation
 unit common
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-6-pierrick.bouvier@linaro.org>
 <b6895297-c24b-4605-8d2a-a8566dfd3604@linaro.org>
 <1c34141c-7b26-4e15-885e-27c15382ac07@linaro.org>
 <8e71cd16-7938-487e-91b9-2863f1eef15f@linaro.org>
 <c94c2f42-812d-48fc-a971-fe5bb7379a06@linaro.org>
 <67a38c39-ac5f-4243-b3d3-fb6c1a02f346@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <67a38c39-ac5f-4243-b3d3-fb6c1a02f346@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

On 3/30/26 10:20 PM, Richard Henderson wrote:
> On 3/31/26 01:38, Pierrick Bouvier wrote:
>>> If you want to share these, do we need one invocation, storing the file object in a local
>>> variable?  Akin to
>>>
>>> vfp_d = decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp')
>>>
>>> gen_a32 = [
>>>      ...
>>>      vfp_d,
>>>      ...
>>> ]
>>>
>>> arm_common_system_ss.add(
>>>      vfp_d,
>>>      ...
>>> )
>>>
>>>
>>> r~
>>
>> Yes, your idea works. It will still result in duplicated .c.inc though.
>>
>> We can't have a single invocation of the generator, since the result will be private to a
>> specific binary/library.
>>
>> You can see it by inspecting build.ninja directly:
>>
>> $ grep 'decodetree.py.*decode-vfp.c.inc' build/build.ninja
>> ... -o libsystem_arm.a.p/decode-vfp.c.inc
>> ... -o libqemu-aarch64-linux-user.a.p/decode-vfp.c.inc
>> ...
>>
>> As you see, the output folder is releated to the final library (or executable) that will
>> include it, and not to where we are in terms in source folder.
>> build/libsystem_arm.a.p is only included for common-system-arm code while libqemu-aarch64-
>> linux-user.a.p is only visible for arm-user code.
> 
> Before:
> 
> $ fgrep decode-vfp.c.inc buildlog
> [2638/6697] Generating 'libqemu-aarch64-linux-user.a.p/decode-vfp.c.inc'
> [2719/6697] Generating 'libqemu-aarch64_be-linux-user.a.p/decode-vfp.c.inc'
> [2830/6697] Generating 'libqemu-arm-linux-user.a.p/decode-vfp.c.inc'
> [2904/6697] Generating 'libqemu-armeb-linux-user.a.p/decode-vfp.c.inc'
> [4070/6697] Generating 'libqemu-aarch64-softmmu.a.p/decode-vfp.c.inc'
> [4174/6697] Generating 'libqemu-arm-softmmu.a.p/decode-vfp.c.inc'
> 
> After:
> 
> $ fgrep decode-vfp.c.inc buildlog
> [2504/6701] Generating 'libsystem_arm.a.p/decode-vfp.c.inc'
> [2651/6701] Generating 'libqemu-aarch64-linux-user.a.p/decode-vfp.c.inc'
> [2732/6701] Generating 'libqemu-aarch64_be-linux-user.a.p/decode-vfp.c.inc'
> [2843/6701] Generating 'libqemu-arm-linux-user.a.p/decode-vfp.c.inc'
> [2918/6701] Generating 'libqemu-armeb-linux-user.a.p/decode-vfp.c.inc'
> [4085/6701] Generating 'libqemu-aarch64-softmmu.a.p/decode-vfp.c.inc'
> [4183/6701] Generating 'libqemu-arm-softmmu.a.p/decode-vfp.c.inc'
> 
> You're still building in libqemu-{arm,aarch64}-softmmu.a.p.
> Which you say above you aren't.
>

Even though the libqemu.*softmmu are generated, they are not used since 
libsystem_arm is included instead. This is because gen_a32 is included 
in all targets.

I'll go with your suggestion to have a variable per decode file, and 
include it in system and user targets only, which will reduce 
duplication to the minimum we can.

> 
> r~



