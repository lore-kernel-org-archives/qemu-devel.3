Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7691A1125856
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0NIG-0002Lc-SS; Wed, 11 Mar 2026 13:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0NI8-0002Kw-U7
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0NI5-000733-8N
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773249850;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3PGEfEthfcHz+yTe8YoN1R7vXnpfQac5AKzVL4Sx/U=;
 b=cNXGndzjjCZJzu9EN/6rXm+O2FSy08H8MibtptnBJaKCKSS6bFxxEkwuaI3CLN6oOnir1s
 a9X6+gTv0oaPU2hevqQdCZAMsem9/+Z2CK/W2T+5kI+XzwdeQbaylm5wmgTj/6bJcsA44S
 bbDzRLj8Nshau0BaWMXziFi0iw4Qnd0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-b4gj2PbSMFKebWGogzz9wA-1; Wed, 11 Mar 2026 13:24:09 -0400
X-MC-Unique: b4gj2PbSMFKebWGogzz9wA-1
X-Mimecast-MFC-AGG-ID: b4gj2PbSMFKebWGogzz9wA_1773249848
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-485390246c8so1345115e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773249848; x=1773854648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3PGEfEthfcHz+yTe8YoN1R7vXnpfQac5AKzVL4Sx/U=;
 b=Y2/34/ipIrAuGQsjxnQ5WqzyktoV5iVBu5QD/tfcfMqPpF9qtiONlnOi+17eQbAySg
 3r5lYC00IUCVGxSMCNsdEnltZjeDrZFYan9tZHqxUkxJ6O34oTWw1v/aRVnTglO9BrX3
 Lnm4H8cnuDiCF7tM56GmBDvJTQD//ihvu9R5yRsWWqkQKtubVU7shfJ7zI2qEGZaQPSR
 7ACULUoyl/GnTkvWVggLvNHRv7MQ574MAP1DcXjMJdHGWHm+ejNjMKPmE3EQlmLQ0Wa2
 hY80quAoS6g282DbuGzNyMxbZEFf6DEaAjl64t7FIiVfTS6ruSrekvrqc7B0DnVVwnEh
 JZ5g==
X-Gm-Message-State: AOJu0YzSZTfuSS3GwDoXi0PBaKCyYGQqEfdAFckN+dOD0iYOkiU4ZYow
 0eHHlGAkqP+zntDhF32OxQEsh1uw7MAGBP2Cx/EsR0sJXsk9QRZjInB7MOWr1mL8/cExTJAyFwK
 eopayjqvSphDBKbSPOrp979TgBLucA/OyWSmlZ68OwtAJ18FbClo1eW+H
X-Gm-Gg: ATEYQzz/EnYWsEWjZJ1adQjaK9d280wc+8SsCcDMsmWFlYGglAgUEygy6/y+1VhEvkH
 ISdKGE5EzUZoORWIQirXoeC0asD75RHgzudWwIDgaNMmWdzRFIZYWUPuvx8bmTsGY5BhVw1JoM4
 vUfWl0ZNYpdQonzEmO1k+8O76RgeaX077vWOUXWtb+nAHFxsumtrT+BqtCspy9manU++/ulGGpp
 hcyKoQPrADFYf2yuqW9K06rrdkGgLPDw8iX1H54VeFWs/DSRmgrVv69V39Et4VfBvcbyDACXyWl
 0jz0lxflEAxDQZ/fsii9XDVZ6XvyyEtR7Hlv5irAS1oPPepxbSZNth5LHEy/gkB3b+gx6piXAr9
 h+Gp+pQN5QXniUdaVBj/crz2kPZ4k2SwCf/wLR5vJNYuX+riP7R3UfHalt8lmb1o9YFXI7g==
X-Received: by 2002:a05:600c:348c:b0:485:3025:162 with SMTP id
 5b1f17b1804b1-4854b13e0d8mr53624165e9.35.1773249847591; 
 Wed, 11 Mar 2026 10:24:07 -0700 (PDT)
X-Received: by 2002:a05:600c:348c:b0:485:3025:162 with SMTP id
 5b1f17b1804b1-4854b13e0d8mr53623745e9.35.1773249847070; 
 Wed, 11 Mar 2026 10:24:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541acea11sm194946165e9.7.2026.03.11.10.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 10:24:06 -0700 (PDT)
Message-ID: <83b8acf0-309b-432a-b7c1-3bbd5ea82e3c@redhat.com>
Date: Wed, 11 Mar 2026 18:24:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] hw/arm/smmuv3-accel: Introduce _AUTO support for
 ATS
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-3-nathanc@nvidia.com> <87pl5cnp06.fsf@pond.sub.org>
 <98e7dd71-6669-4a82-bec8-f1dae2d861c3@redhat.com>
 <0bdcf7d7-136e-42f4-9fa9-d31f6ae6e19f@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <0bdcf7d7-136e-42f4-9fa9-d31f6ae6e19f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/11/26 6:08 PM, Nathan Chen wrote:
>
>
> On 3/11/2026 8:31 AM, Eric Auger wrote:
>> On 3/10/26 8:05 AM, Markus Armbruster wrote:
>>> Nathan Chen<nathanc@nvidia.com> writes:
>>>
>>>> From: Nathan Chen<nathanc@nvidia.com>
>>>>
>>>> Allow accelerated SMMUv3 Address Translation Services support property
>>>> to be derived from host IOMMU capabilities. Derive host values using
>>>> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
>>>>
>>>> Set the default value of ATS to auto. The default for ATS support used
>>>> to be set to off, but we change it to match what the host IOMMU
>>>> properties report.
>>>>
>>>> Add a "ats-enabled" read-only property for smmuv3 to address an
>>>> expected bool for the "ats" property in iort_smmuv3_devices().
>>>>
>>>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>>>> ---
>>>>   hw/arm/smmuv3-accel.c    | 25 +++++++++++++++++++++++--
>>>>   hw/arm/smmuv3.c          | 12 ++++++++++--
>>>>   hw/arm/virt-acpi-build.c |  2 +-
>>>>   include/hw/arm/smmuv3.h  |  2 +-
>>>>   4 files changed, 35 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>>> index 617629bacd..8fec335557 100644
>>>> --- a/hw/arm/smmuv3-accel.c
>>>> +++ b/hw/arm/smmuv3-accel.c
>>>> @@ -52,6 +52,12 @@ static void
>>>> smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
>>>>           return;
>>>>       }
>>>>   +    /* Update ATS if auto from info */
>>>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>>>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
>>>> +                               FIELD_EX32(info->idr[0], IDR0, ATS));
>>>> +    }
>>>> +
>>>>       accel->auto_finalised = true;
>>>>   }
>>>>   @@ -124,6 +130,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3State
>>>> *s,
>>>>                      smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5,
>>>> OAS)));
>>>>           return false;
>>>>       }
>>>> +    /* Check ATS value opted is compatible with Host SMMUv3 */
>>>> +    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
>>>> +                FIELD_EX32(s->idr[0], IDR0, ATS)) {
>>>> +        error_setg(errp, "Host SMMUv3 doesn't support Address
>>>> Translation"
>>>> +                   " Services");
>>>> +        return false;
>>>> +    }
>>>>         /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation
>>>> granules */
>>>>       if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
>>>> @@ -844,8 +857,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>>>       /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has
>>>> disabled it */
>>>>       s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
>>>>   -    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by
>>>> property */
>>>> -    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
>>>> +    /* Only override ATS if user explicitly set ON or OFF */
>>>> +    if (s->ats == ON_OFF_AUTO_ON) {
>>>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
>>>> +    } else if (s->ats == ON_OFF_AUTO_OFF) {
>>>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 0);
>>>> +    }
>>>>         /* Advertise 48-bit OAS in IDR5 when requested (default is
>>>> 44 bits). */
>>>>       if (s->oas == SMMU_OAS_48BIT) {
>>>> @@ -923,4 +940,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>>>>       s->s_accel = g_new0(SMMUv3AccelState, 1);
>>>>       bs->iommu_ops = &smmuv3_accel_ops;
>>>>       smmuv3_accel_as_init(s);
>>>> +
>>>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>>>> +        s->s_accel->auto_mode = true;
>>>> +    }
>>>>   }
>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>> index 068108e49b..197ba7c77b 100644
>>>> --- a/hw/arm/smmuv3.c
>>>> +++ b/hw/arm/smmuv3.c
>>>> @@ -317,6 +317,12 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>>>>       smmuv3_accel_idr_override(s);
>>>>   }
>>>>   +static bool get_ats_enabled(Object *obj, Error **errp)
>>>> +{
>>>> +    SMMUv3State *s = ARM_SMMUV3(obj);
>>>> +    return FIELD_EX32(s->idr[0], IDR0, ATS);
>>>> +}
>>>> +
>>>>   static void smmuv3_reset(SMMUv3State *s)
>>>>   {
>>>>       s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
>>>> @@ -1971,7 +1977,7 @@ static bool
>>>> smmu_validate_property(SMMUv3State *s, Error **errp)
>>>>               error_setg(errp, "ril can only be disabled if
>>>> accel=on");
>>>>               return false;
>>>>           }
>>>> -        if (s->ats) {
>>>> +        if (s->ats == ON_OFF_AUTO_ON) {
>>>>               error_setg(errp, "ats can only be enabled if accel=on");
>>>>               return false;
>>>>           }
>>>> @@ -2128,7 +2134,7 @@ static const Property smmuv3_properties[] = {
>>>>       DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>>>>       /* RIL can be turned off for accel cases */
>>>>       DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>>>> -    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>>>> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats,
>>>> ON_OFF_AUTO_AUTO),
>>> Is property "ats" accessible via QMP or JSON command line?  If yes,
>>> this
>>> is an incompatible change: JSON values false and true no longer work.
>> So what do you recommend to extend the property values. I guess we had
>> some existing scenarios happening in the past. What is the best way to
>> proceed?
>
> Is it a requirement to ensure boolean values are still supported when
> switching to OnOffAuto? I found that the x86-iommu intremap property
> had a change from DEFINE_PROP_BOOL to DEFINE_PROP_ON_OFF_AUTO [0].
>
> Should I add a custom property setter that accepts both boolean and
> on/off/auto for backward compatibility, or is following the intremap
> precedent acceptable? I'm happy to implement either approach.
>
> [0]
> https://github.com/qemu/qemu/commit/a924b3d8df55a395891fd5ed341d0deb135d9aa6 
For the notice, this happened in 2020:
a924b3d8df55  (HEAD) x86-iommu: switch intr_supported to OnOffAuto type

and the previous bool properties was introduced in 1121e0afdcf (in 2016)

By the way I don't say this is something that is good ;-)

Eric
>
> Thanks,
> Nathan
>


