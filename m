Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA08C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQrGd-0001OS-00; Mon, 08 Jul 2024 12:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQrGZ-0001Ng-Th
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQrGW-0004eb-SA
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720456258;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjGbYZ9SL0+r3c1nWTC603usckRgPGn71L4n803ns+c=;
 b=I4Uwt7XqwSguGeHpo/I/W48qbWYRYvNRnNTiSasiHjkcDta/8YeDyFu5GOkaYuYf8JEFV1
 dPyA6ElzRx3n/y3SZ1DurnWPY7rNSm7Nf9drxcXiXfyvWlhei6C4/S/H4NSG75m3HpJaeq
 BpCK5w/OM5J4pXQcR5J49TRtRgU8zG8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-1JIvakRRPfi0NryhWy9SqA-1; Mon, 08 Jul 2024 12:30:52 -0400
X-MC-Unique: 1JIvakRRPfi0NryhWy9SqA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36796a0687bso3200372f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720456251; x=1721061051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HjGbYZ9SL0+r3c1nWTC603usckRgPGn71L4n803ns+c=;
 b=xR2nKVAFqmsnCmyEFWQfJ5/B2vjgl/5GcZ887nt6PcdtKduDN61Tkxh6syWx1F5fgJ
 4qOKjxFuZtYEfLYr5rt4DRQecuPDNqAuQLTGLqK1/iHVtPKGvY32BzAUrhey1C7WF/S4
 4o+7avELf+AV/sbME97l2QvIWrdWZzEv0Fuy65Xbk09CopiqZ8KgaHfE+OjFR5z8vWp4
 I0IN/C+Xwf4kJWtI1uWTCS8Ps17GbpiiwpGuxwIZdJcKG6FVUVfxuSOYHPLKYGOkOfaf
 o1OEnqDNQ2C+et6cahjB6y/5nzZzlwi2P0ytE5aJHiXcpknKOSNizOpnDPhzxktwuKel
 0beQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4dn5Hm2kPeGb9jft66i86LZ11VC1krPg5fexI4Ckc/Yr8BTs6JeZNe1pipyjKcPYsys3rHHHR35S/+atgsPUKOkVfk40=
X-Gm-Message-State: AOJu0YwJfWj5dlbEuXpx21C1muy54JL0ydYDuM3KdHtH3RLGQiNLaUlM
 39yois/FPBSNGog1XlUjzSf7QBBSDmRfWzRV+KUVcDxPyMgMU8J+sTME2ev5NRZ/wD6w6eEMzDE
 Q+OB5bKAvQNo/TbvaKPs08lbX3DQA/2R9rOgKRk9cpkaeBbnwyRhe
X-Received: by 2002:a5d:5552:0:b0:367:4354:52c2 with SMTP id
 ffacd0b85a97d-367cea6b825mr93347f8f.22.1720456251619; 
 Mon, 08 Jul 2024 09:30:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn+A3eNt90pJEup33A0PTIKiT4GQx+hVbbSfM0fyxZL0lRDA7BNRkXwUa+wThOBde6zEXWew==
X-Received: by 2002:a5d:5552:0:b0:367:4354:52c2 with SMTP id
 ffacd0b85a97d-367cea6b825mr93325f8f.22.1720456251238; 
 Mon, 08 Jul 2024 09:30:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde7df53sm215934f8f.14.2024.07.08.09.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 09:30:50 -0700 (PDT)
Message-ID: <4cc94a1f-4328-4bec-aa66-fc2d88701a16@redhat.com>
Date: Mon, 8 Jul 2024 18:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/19] hw/arm/smmuv3: Handle translation faults
 according to SMMUPTWEventInfo
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com, julien@xen.org,
 richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-17-smostafa@google.com>
 <20240704183621.GM1693268@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240704183621.GM1693268@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/4/24 20:36, Jean-Philippe Brucker wrote:
> On Mon, Jul 01, 2024 at 11:02:38AM +0000, Mostafa Saleh wrote:
>> Previously, to check if faults are enabled, it was sufficient to check
>> the current stage of translation and check the corresponding
>> record_faults flag.
>>
>> However, with nesting, it is possible for stage-1 (nested) translation
>> to trigger a stage-2 fault, so we check SMMUPTWEventInfo as it would
>> have the correct stage set from the page table walk.
>>
>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>> ---
>>  hw/arm/smmuv3.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 36eb6f514a..6c18dc0acf 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -34,9 +34,10 @@
>>  #include "smmuv3-internal.h"
>>  #include "smmu-internal.h"
>>  
>> -#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == SMMU_STAGE_1) ? \
>> -                                 (cfg)->record_faults : \
>> -                                 (cfg)->s2cfg.record_faults)
>> +#define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
>> +                                        (cfg)->record_faults) || \
>> +                                        ((ptw_info).stage == SMMU_STAGE_2 && \
>> +                                        (cfg)->s2cfg.record_faults))
> I guess this could be simplified as "(info.stage == STAGE_1) ? s1cfg : s2cfg"
> Anyway:
>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>
>>  
>>  /**
>>   * smmuv3_trigger_irq - pulse @irq if enabled and update
>> @@ -919,7 +920,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>              event->u.f_walk_eabt.addr2 = ptw_info.addr;
>>              break;
>>          case SMMU_PTW_ERR_TRANSLATION:
>> -            if (PTW_RECORD_FAULT(cfg)) {
>> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>>                  event->type = SMMU_EVT_F_TRANSLATION;
>>                  event->u.f_translation.addr = addr;
>>                  event->u.f_translation.addr2 = ptw_info.addr;
>> @@ -928,7 +929,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>              }
>>              break;
>>          case SMMU_PTW_ERR_ADDR_SIZE:
>> -            if (PTW_RECORD_FAULT(cfg)) {
>> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>>                  event->type = SMMU_EVT_F_ADDR_SIZE;
>>                  event->u.f_addr_size.addr = addr;
>>                  event->u.f_addr_size.addr2 = ptw_info.addr;
>> @@ -937,7 +938,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>              }
>>              break;
>>          case SMMU_PTW_ERR_ACCESS:
>> -            if (PTW_RECORD_FAULT(cfg)) {
>> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>>                  event->type = SMMU_EVT_F_ACCESS;
>>                  event->u.f_access.addr = addr;
>>                  event->u.f_access.addr2 = ptw_info.addr;
>> @@ -946,7 +947,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>              }
>>              break;
>>          case SMMU_PTW_ERR_PERMISSION:
>> -            if (PTW_RECORD_FAULT(cfg)) {
>> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>>                  event->type = SMMU_EVT_F_PERMISSION;
>>                  event->u.f_permission.addr = addr;
>>                  event->u.f_permission.addr2 = ptw_info.addr;
>> -- 
>> 2.45.2.803.g4e1b14247a-goog
>>


