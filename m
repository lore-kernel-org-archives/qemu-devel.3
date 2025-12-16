Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE6BD609BB
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVXgJ-0003Ha-U7; Tue, 16 Dec 2025 11:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVXgH-0003GX-P7
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 11:13:45 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVXgG-0004yH-83
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 11:13:45 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so4053884b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 08:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765901623; x=1766506423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=10oyi9nDKeNlIVFMrauOe0l7R48MzuLinYpojqAXQkQ=;
 b=VXmt1a8p4hnpo0GhFnbpjXMO1y/hw3j005UXTga9iieh+lmPnfxWnfFx9qjXtZG1F4
 vxyPEs9aM9Q8VLrDes1xJnPa+f8k0Z7wvFFPeVHzTF6LdOjCrlmIemScUH1lY5epMU0y
 hVlbts4Eukvsnf3ANpAmJQMjoUx58GJmnKSp0xPCIWwcItfHAQB+vw/9+lMU8Z5i9Qon
 VlybhKNpznqB3aNCouhM6x14FVZISgGHd5igIo2yb+KIgqUAyBO86oyT5x8jRrCLtYxI
 Qx3brcu4yQndt3bA+HDIBNWcN9JC9gZ1ZEMGpWGOfDRrB+Tg8WPDf21bmDwzWdmP96iz
 MwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765901623; x=1766506423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=10oyi9nDKeNlIVFMrauOe0l7R48MzuLinYpojqAXQkQ=;
 b=naexQAjbSVpXrUhYAmI5W9OwvhQrRJyqjAA+reKFWl/t0P54WEapxP/EhbEDvzD6BD
 En7oz64x4USClxj03jrhfcRNh+XSQPgpG0WWs2DFN0w2f0IhKHC0nJpveZFZkaZ2oZpg
 9mF2isPJqqKLzHYiVt39bvtDFMR1fl/he8M1CGFIyutXrHOB6Yriq7FPT+8RShAentRK
 DRfrlHtcWfBqLg/UdUnTObDRiLcJUNZUWbDpJSF/Qf5QfWM9bEB1QayZnbNap8X17Yfs
 EeAh7WvgvV+yVxeIkd3cfKFrLSjX2XUnXS3VjfMsqE6vzOuM7Yi3byixctzp9zVQ+wef
 S7GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKMQ6RBtMsWLF/U0q8okoHgVMvTcS1ooH6dDJhYOfdc+0dFRRmueyU8JmtUh34s+KPUkJAwk/Ss8+W@nongnu.org
X-Gm-Message-State: AOJu0YxE7sDmd+Jzhzgn964rK8YJRTADgCc8g4jBnXTtsEkKKTLprG9e
 f6tNjdtshdvR6FGuu9vh16Vy79VzvBcxY5YBFX8XbMPzfOS6iOEI/nLnuxBocpi0g7I=
X-Gm-Gg: AY/fxX76ZFVr3RNwiT4ZCFtkg0lGY7oPPGaMEmnopKdAYgUwjoZ1UrmugwDQw0jWbXc
 SroKkDlf5vecc4hp0/j73REq71GWuVx1JwUBCBXGqwSusXxk93PsHY+VsoJDQcDOoFg634gYlDj
 OpDYq6c4d/h4ZeCow48Gd9fOlUXSr4G+f3Ej2ZYYtDugRmgHJO7knFDjOgYGKlxe+eU3LfTUYcE
 3/11hVmyF7vkfh++xLmEdJXNxsaMK9M7muDnylopa+vrdYYFmUbXNzvNAxHQfEs4IMiNramwhZw
 OLH9FmYbu285Q2pKLTK8bGNHaqgw1SmS36IqA6frAtBXatySLeXncGdkmITkNdiT/XtCnfTypIc
 speZGwbqMSlQgB+d1UybtQLJXIwmiBOeP2pwD3upChFwTa37lQTc1qTM/mX7nG1qe/d4GDyhRsS
 T2tg21KVF32brDJfhxYr5bB1VVHIiBVPlW7CmMpNkKDfW8tEDcDCqLA1U=
X-Google-Smtp-Source: AGHT+IGdhdUD1Gvz5OHJoWKZGVaPp+eEGeO/hBoftTPwXmyyLgkno5vg3k+FtLmOC3TB6jF26hIsHQ==
X-Received: by 2002:a05:6a20:3d86:b0:366:815a:b3a5 with SMTP id
 adf61e73a8af0-369b04ca160mr14367502637.74.1765901622319; 
 Tue, 16 Dec 2025 08:13:42 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34abe3de37asm12286091a91.9.2025.12.16.08.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 08:13:41 -0800 (PST)
Message-ID: <f214e8d4-8864-4806-a3ba-207aa3f67714@linaro.org>
Date: Tue, 16 Dec 2025 08:13:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/arm/ptw: make granule_protection_check
 usable without a cpu
To: Tao Tang <tangtao1634@phytium.com.cn>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
References: <20251216000122.763264-1-pierrick.bouvier@linaro.org>
 <20251216000122.763264-3-pierrick.bouvier@linaro.org>
 <05c30ad2-2836-4f78-9c79-ad03eee2ce00@phytium.com.cn>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <05c30ad2-2836-4f78-9c79-ad03eee2ce00@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 12/16/25 5:39 AM, Tao Tang wrote:
> Hi Pierrick,
> 
> On 2025/12/16 08:01, Pierrick Bouvier wrote:
>> By removing cpu details and use a config struct, we can use the
>> same granule_protection_check with other devices, like SMMU.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/cpu.h | 34 ++++++++++++++++++++++++++++
>>    target/arm/ptw.c | 59 +++++++++++++++++++++++++++++++-----------------
>>    2 files changed, 72 insertions(+), 21 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index efbef0341da..5752e1f58fb 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1216,6 +1216,40 @@ void arm_v7m_cpu_do_interrupt(CPUState *cpu);
>>    
>>    hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>>                                             MemTxAttrs *attrs);
>> +
>> +typedef struct ARMGranuleProtectionConfig {
>> +    /* GPCCR_EL3 */
>> +    uint64_t gpccr;
>> +    /* GPTBR_EL3 */
>> +    uint64_t gptbr;
>> +    /* ID_AA64MMFR0_EL1.PARange */
>> +    uint8_t parange;
>> +    /* FEAT_SEL2 */
>> +    bool support_sel2;
>> +    /* Address space to access Granule Protection Table */
>> +    AddressSpace *gpt_as;
>> +} ARMGranuleProtectionConfig;
> 
> Would it make sense to add brief comments explaining how the fields in
> ARMGranuleProtectionConfig map to SMMU registers? This could help
> clarify that arm_granule_protection_check() is intended as a shared
> abstraction for both CPU MMU and SMMU.
> 

I'm not sure it's needed.
If we search for GPCCR/GPTBR/FEAT_SEL2 in SMMU spec, it will 
unambigously give the answer of which register holds it or what it is.
I would consider the comment is here to map local name to spec name, but 
not further than that.

Concerning finding which are the callers of this function, code 
completion tools or grep does a great job at it.

That said, if we want to add details about SMMU using this, it's 
definitely worth waiting for the patch using it on SMMU side.

> 
> That said, I’m also happy to defer this until we actually add the SMMU
> RME support.
> 
> 
> Regards,
> 
> Tao
> 

Thanks,
Pierrick

