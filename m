Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874D3C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkq2-0005Ge-0f; Mon, 24 Mar 2025 12:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkpy-0005GE-8j
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:39:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkpu-00009f-Kr
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:39:40 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39127512371so3037349f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742834377; x=1743439177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WgVbp1q6BtpFIlzw4KgGi7m4xNxleG7LhCIBbsDtjVY=;
 b=dLBqbkwIPw5dOOvPcJ6kSNkY4neNwOym0uuXPYGcuVSMT3fssc62khjE1y7Ql4Gtt3
 B012HA56CSNT+B/2h7o31Of+jEJ+tuWPO4hwPKI0QmBQ/bVfpbknAnmXrfKw5RZh00N4
 FLVnaqlOG6uTCDRwrFssDezuUlVUeduRBM9doNnhJIkpVbORHgHN+8MKlVXA/G7sg29W
 K4UCx6dbdgnO9A0XEY0A/lJC+3TFF2815JpQejacS6IyyHm2KxySExKeYir7QEcTI/1r
 hQ/IoROiDJwkpELeGFsINzODV62xQI7qp1VRwu8rueJlz7UM2JBQLD+heRzYkzy28geM
 AD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742834377; x=1743439177;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WgVbp1q6BtpFIlzw4KgGi7m4xNxleG7LhCIBbsDtjVY=;
 b=HrrWBNThPMi7FO5k9kF1KB3/sn+pAqbBGS8vr4TnSN/vxdH2YkfBRa0p3gsISkVA/d
 3VMkya+3gJn3ht3KyVig00W/bGQ/qcbOFmRmg4L66UbJBTSgfhxou0hxOjs3e0HiLreH
 WP/ak29/lvkTLA/ydPiyYJd7NYLqduRrg6PRrgw9Rseo6HT4hd3DT7QmpzWOQOKDckfD
 TL8RWddRHSKD3KACOmjXSIBhtdFgVE1gdnpjSVv0OXiXRvWjD75D1Qb9VgvO9B4Ro8fl
 PGQ3wt6pvvBxyq1sowMfxrS4/EWG39ALcQZs0T1EEK3xhZhP9F3xce2nn7zYJhyl1L8q
 SqDw==
X-Gm-Message-State: AOJu0YwXPY5OmgEBcJl4PuuPyRR7q6vd5JV9eOrGPArElwV92ghIgzsr
 OFKNNnd4bs3qEIAjHJp/eHeDXHJ2kkAwOObj+aw0B6HdtmZ7qTc8hhgWynGDZkE=
X-Gm-Gg: ASbGnctY998mlGHyo++hBFM8hsKQhOif/0A+Rx//Oa8l9qS4DLSw/MpCN14kzYQqJ8L
 fR71ep/rihR2XcoA/T16YOLI0PvwGemDF4b4QGzD4J4ZnS1ceh7DPaMSvwHczArFULFDoib5DIy
 95xb+5OBKX+FySpi/MuEGm2G7NqwV1g8ZL0CwzaFKuZ35nQjiSyV9T+mE6mSPrkUGLa8lWh4kqX
 6t91r9Mi4LI7Eq1ecXnnV3ZkGqFym5BbUUv7H4tMzEqHFT27PSOQGOXDftvCqdAAemuyz8yw2eU
 dJyMnbm6qb777fiNUYNLd4a2qTARyaAMA2M+qZnIkKgGxIduO4/U74cbA4SB1iFnAnmWgJtzlqk
 11gYQZgYEd/UMQfEv5g==
X-Google-Smtp-Source: AGHT+IHCoH3f7eGtcf0EdkuBJI5yKtR7pmUbPHz3++PY5QLf0a4oWFNgXYsaZDObSy9SiP3itJCFag==
X-Received: by 2002:a05:6000:184b:b0:390:d796:b946 with SMTP id
 ffacd0b85a97d-3997f932d65mr13544698f8f.44.1742834376936; 
 Mon, 24 Mar 2025 09:39:36 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b5939sm11670228f8f.60.2025.03.24.09.39.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 09:39:36 -0700 (PDT)
Message-ID: <8a81f554-dcb5-4086-88cc-d1c099a05761@linaro.org>
Date: Mon, 24 Mar 2025 17:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 4/4] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-5-philmd@linaro.org>
 <8cc6f6a4-b868-4dc8-bc14-25b438ad62a5@linaro.org>
 <5bd8498c-b5ff-4fb1-94d7-a2efa2f20fd9@linaro.org>
 <cc7d5557-0e0a-b7df-1eab-8f9d86444d2b@eik.bme.hu>
 <fd7ecaa3-5995-4124-a7bc-8393dd4e6d7b@linaro.org>
 <4e569101-042f-e0a6-23be-e4fbeb79c3b7@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4e569101-042f-e0a6-23be-e4fbeb79c3b7@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/3/25 23:49, BALATON Zoltan wrote:
> On Sun, 23 Mar 2025, Richard Henderson wrote:
>> On 3/23/25 15:13, BALATON Zoltan wrote:
>>> On Sun, 23 Mar 2025, Philippe Mathieu-Daudé wrote:
>>>> On 23/3/25 20:07, Richard Henderson wrote:
>>>>>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>>>>>> index 28fbbb8d3c1..ed79cc1a6b7 100644
>>>>>> --- a/target/ppc/cpu_init.c
>>>>>> +++ b/target/ppc/cpu_init.c
>>>>>> @@ -7490,6 +7490,7 @@ static const TCGCPUOps ppc_tcg_ops = {
>>>>>>     .translate_code = ppc_translate_code,
>>>>>>     .restore_state_to_opc = ppc_restore_state_to_opc,
>>>>>> +  .mttcg_supported = TARGET_LONG_BITS == 64,
>>>>>>     .guest_default_memory_order = 0,
>>>>>
>>>>> Similarly.  I'd be surprised if ppc32 can't use mttcg, really.
>>>>
>>>> Per Cédric on IRC our ppc32 implementations are single core,
>>>> so never tested for mttcg.
>>>
>>> We're just trying to implement more CPUs for G4 mac99 and tested it 
>>> with -smp 2 and it seems to generally work but we need to implement 
>>> more of the Mac hardware for this but we could already run Mac OS X 
>>> with two CPUs and mttcg and Linux too if we add a delay on boot when 
>>> second CPU is started (it may need implementing timebase control as 
>>> done on the G4 Mac to avoid that but if it gets past that it seems to 
>>> work). So please leave this enabled. Not tested does not mean it does 
>>> not work so only disable if there's a known problem.
>>
>> MTTCG is not enabled for qemu-system-ppc right now.
> 
> I could use -smp 2 with qemu-system-ppc after this:
> https://lists.nongnu.org/archive/html/qemu-ppc/2025-02/msg00377.html
> It complains about not tested for the board but works nevertheless. I 
> don't remember if I've enabled mttcg or not so maybe it only ran with 
> single thread which was enough for testing but others did test mttcg:
> https://lists.nongnu.org/archive/html/qemu-ppc/2025-02/msg00455.html
> although could be that with qemu-system-ppc64 which also includes 32 bit 
> machines. But then it should work the same with qemu-system-ppc so it 
> could be enabled there as well.
> 
>> Phil's patch does not current change behaviour.
> 
> Then what does the line do at all? In any case we may want to enable 
> mttcg in qemu-system-ppc in the future so maybe there's no need to 
> restrict it here.

In the future you can enable it posting this patch:

-- >8 --
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
@@ -7492,6 +7492,7 @@ static const TCGCPUOps ppc_tcg_ops = {
-  .mttcg_supported = TARGET_LONG_BITS == 64,
+  .mttcg_supported = true,
---

which is equivalent of today's:

-- >8 --
diff --git a/configs/targets/ppc-softmmu.mak 
b/configs/targets/ppc-softmmu.mak
@@ -5 +5,2 @@ TARGET_XML_FILES= gdb-xml/power-core.xml 
gdb-xml/power-fpu.xml gdb-xml/power-alt
  TARGET_LONG_BITS=32
+TARGET_SUPPORTS_MTTCG=y
---

I'll let you write the commit description.

Regards,

Phil.

