Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3CEC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QwP-0000hn-TZ; Tue, 15 Sep 2026 07:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6QvY-00005B-A7
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6QvU-0005Bc-Mw
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789470131;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJ4zAho7UuxkU6bHAfbi9QAuVvdRjYnhPNLwXzdTOtA=;
 b=FlJEzmhAt3OMRuOFNsBnZ3bOazoUJ8zCQzqG/mUW40A0l7wTLR3Bopi6H6Sq6OTG00i08c
 DhbYlv1qGyTX18p94kpbuwKNtLvKEC15CFm7WMOefXRnlf97nDVA/PLROW+G9iNa3eVK0P
 mLkTHiEAx1z/a2+TmxD8k22k91iunDE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-R1gOtLFsN1qLF7JjQCUe4A-1; Tue, 15 Sep 2026 07:02:10 -0400
X-MC-Unique: R1gOtLFsN1qLF7JjQCUe4A-1
X-Mimecast-MFC-AGG-ID: R1gOtLFsN1qLF7JjQCUe4A_1789470129
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c2939e341f7so497934066b.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789470129; x=1790074929;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sJ4zAho7UuxkU6bHAfbi9QAuVvdRjYnhPNLwXzdTOtA=;
 b=agkGpSZ3LhKDX7pR9UIbMZ4F8Q2q/6CgLWJpA7qPB7RcHMVzXOb8hoUMD4z6dubd/l
 +jv0BiLpEo+z7raTaigYj0Z4GfV7o0TzBDTVa5CN9jAgTu/uadi7SIRh2M044IGbyCcQ
 eGcNO9HaDhgPVsHS7zqyK46TXCgfsow+Q90Y+sc2ppQC1CL1jUq2vPBdwUGn0a5kzCip
 hmiZUFBAEl7H3+kXHFYRq0mAKyg2RTi850BKFhwdCTdwE9g7s1PRWeAjFROLEpQMV2i/
 bpyyvLeC4ovKon8oP8Vp3L/fOWeQ8oTo+J32o21b+4P6XrB5Q2WETnoznErtRMggFzLv
 UYOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwF2Lfn65mxyKdj7M2UynJWGKZ7yE3hm4fIQniFpAlgCANyi2gJM0cFicTlacoTHMIO/4Gf65lyjeMQ@nongnu.org
X-Gm-Message-State: AFuF++lZucdwJsQoXL21Da2AFOqK6EJs669IVJI38dd6LYbfiC88UJpf
 /SNgsscUKjU11P6NCdRGaNrH4J7QtkrkQmgVewuiXpsDcsCA/mw/s9V+u6oh7MxxGSWN1Bvd8IX
 PNAR89ULDXscYFXDicTJNQIqNwwFrSrJ5wh0RFnaHKNPp8n/kiXxcHDij
X-Gm-Gg: AYBFou2TUHrqC35gODR4MIvhAGxT5bNuLQZvoxaF7S+7S1bZwvs3lHKJx/GEP8IYld9
 Cc0oamxUXfe2iYbLcHMLjej/6SEg9RjdHr/iJP0YGdWR5Nled8gSGRqcwC1+cClbnm/qIPK3esE
 EDUbUxNx30m4knsUAvxjHnPzLuKV/07fyTS7TAjS7cuyWeIcvHkBMc489ixnqt8HH7GRyBmBRma
 xk3JvRrdspySg+3cTVse9r7bIaxEzfgZP/lrp65GeDCGcUWI/8ufpubnL48FgUUZZITq4kTufYa
 UAj2tXvRW17HvdOgtyr21/QsAkY7vbe3bqntrM7LZS3gFmOzsKkTF+k1ca5X4RnZ+QuzAS0Epdp
 Rh3TRHnmLhiVJowb7pMUwX7cuYAe8KnNhFAsIN9c6hGaaojyy
X-Received: by 2002:a17:907:a088:b0:c1c:2173:d412 with SMTP id
 a640c23a62f3a-c29d773374dmr48824666b.1.1789470128821; 
 Tue, 15 Sep 2026 04:02:08 -0700 (PDT)
X-Received: by 2002:a17:907:a088:b0:c1c:2173:d412 with SMTP id
 a640c23a62f3a-c29d773374dmr48821166b.1.1789470128302; 
 Tue, 15 Sep 2026 04:02:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9b594f0fasm5722322a12.25.2026.09.15.04.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 04:02:07 -0700 (PDT)
Message-ID: <934e0f8b-0e20-40c9-84b7-0785ecfcd786@redhat.com>
Date: Tue, 15 Sep 2026 13:01:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] hw/arm/smmuv3-accel: Request dirty tracking on
 the nesting parent
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com, jgg@ziepe.ca, ankita@nvidia.com,
 aniketa@nvidia.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
 <20260904180513.248396-7-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260904180513.248396-7-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/4/26 8:05 PM, Shameer Kolothum wrote:
> With accel=on the guest owns Stage 1, so the Stage 2 nesting parent is the
> only page table the host can track guest writes through.
>
> VFIO only asks for IOMMU_HWPT_ALLOC_DIRTY_TRACKING on the nesting parent
> when the vIOMMU sets VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING, which
> smmuv3-accel does not, so the parent is allocated plain.
>
> Set the flag.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-accel.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index b653f3f4ce..3f83b505d0 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -1037,6 +1037,12 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>      SMMUState *bs = opaque;
>      SMMUv3State *s = ARM_SMMUV3(bs);
>  
> +    /*
> +     * The guest owns Stage 1, so the Stage 2 parent is the only page table
> +     * the host can track guest writes through.
> +     */
> +    flags |= VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING;
> +
>      if (smmuv3_pasid_supported(s)) {
>          flags |= VIOMMU_FLAG_PASID_SUPPORTED;
>      }


