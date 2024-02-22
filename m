Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D11C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 10:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd61z-0006u1-5n; Thu, 22 Feb 2024 05:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd61t-0006sW-WD
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:10:15 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd61p-0001I9-6Y
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:10:13 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-512b4388dafso5166862e87.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 02:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708596607; x=1709201407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MpRQRvPMdTz33T7Nn52zSwd0okxqNSiTPY20Y4YiyDw=;
 b=Cc2cq064id9+h/nB1gAeieR/2SUI+/Lj3v1jg9DtFiCIte5iNFgkNhnTSnPWP4b5vo
 5f/Y2B435FTLUCj2qYmjgcrmWMo2OTwxvJlK2NbN4ocRwaBUjZ4wm3hRDEJB7FTaff6z
 AzLu9eZAxF/6M1Aa8l9GZZ0lY1Z1p+3Awqk2Mz8e6B2j+DXNyBZr913ioVgMSXNtTxIL
 VfOQWzP5Y3NbX3YzmYBLdr9hcbz8twV0kL3K0w9Vfilf8RpnWNod7LeoDUIlDfVs7lG8
 zRnZURHMboC5tNfdyRwmVuZuK5Fa1k/TNeIdH/U82YY/TGxvStWHSK7hVE7LPFWJDreB
 KdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708596607; x=1709201407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MpRQRvPMdTz33T7Nn52zSwd0okxqNSiTPY20Y4YiyDw=;
 b=pCgeLPEMddnepG8koDvzMTN+ArwBr9fEEOpKyaiL/ydwM4ZxIObv4QbrWdhfieunJn
 ZJQRD4AB/6P3Cd2+6lU8EsB1unq3mXHO/y24vMyRRTNAaFiHgFi9RhY+N4QwEaUlMBaG
 p0zmJH5PtkSFvU42NwVlVkm2mN5up7qskeLnseG6zDTyd4EoyLPR3Z0yFkrqjLxc56HW
 uykLkuGrMLLl7HWDzEG4JH6qKAr6qVs9Qbij7ApLUlQOg4QJ9tQ2x6ajKrMYyQkpzc6W
 wrAOEbOEXUwo8P7m9XuV82Dvh8mCtr6bnLswMlIv1AGvsvosevApqNU+Irk3Zr9p6Dk7
 wWHg==
X-Gm-Message-State: AOJu0YxYkGqhNV00xZTww+dZpoNSl3DKc6xHOEZSCMk2iW/Z3XnG5Ic0
 Vp/Uy0JFM7yeB4n6BJ53Hk+9fyVnZhPT7i2IV6/9kM7v62EBiIZNh/evZvP8rbQ=
X-Google-Smtp-Source: AGHT+IGUHB79ncU7QcKsdC0a0ggzrkUAHIDmgTPg/Gaqejy79ETPKbtfkv8wJWCo8cqJANORovkOzg==
X-Received: by 2002:a05:6512:398f:b0:512:dde1:2226 with SMTP id
 j15-20020a056512398f00b00512dde12226mr911157lfu.47.1708596607205; 
 Thu, 22 Feb 2024 02:10:07 -0800 (PST)
Received: from [192.168.247.175] (41.red-95-127-32.staticip.rima-tde.net.
 [95.127.32.41]) by smtp.gmail.com with ESMTPSA id
 f21-20020ac25335000000b00512d86c2c78sm375667lfh.88.2024.02.22.02.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 02:10:06 -0800 (PST)
Message-ID: <caa10a96-729a-4ee8-93f4-9bfd2b032e2b@linaro.org>
Date: Thu, 22 Feb 2024 11:10:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] hw/i386/pc: Do not use C99 mixed-declarations style
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-2-philmd@linaro.org> <ZdcP9A7n5w7RJqii@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZdcP9A7n5w7RJqii@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22/2/24 10:12, Zhao Liu wrote:
> Hi Philippe,
> 
> On Fri, Feb 16, 2024 at 12:02:52PM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Fri, 16 Feb 2024 12:02:52 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH 01/21] hw/i386/pc: Do not use C99 mixed-declarations style
>> X-Mailer: git-send-email 2.41.0
>>
>> QEMU's coding style generally forbids C99 mixed declarations.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/i386/pc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 196827531a..3c00a87317 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1227,6 +1227,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>>        */
>>       if (pcms->hpet_enabled) {
>>           qemu_irq rtc_irq;
>> +        uint8_t compat;
>>   
>>           hpet = qdev_try_new(TYPE_HPET);
>>           if (!hpet) {
>> @@ -1238,8 +1239,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>>            * use IRQ16~23, IRQ8 and IRQ2.  If the user has already set
>>            * the property, use whatever mask they specified.
>>            */
>> -        uint8_t compat = object_property_get_uint(OBJECT(hpet),
>> -                HPET_INTCAP, NULL);
>> +        compat = object_property_get_uint(OBJECT(hpet), HPET_INTCAP, NULL);
>>           if (!compat) {
>>               qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
>>           }
> 
> "compat" is only used here to check. So, what about getting rid of this
> variable?
> 
> if (!object_property_get_uint(OBJECT(hpet), HPET_INTCAP, NULL)) {
>      qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
> }

Ah yeah, I didn't noticed, thanks!


