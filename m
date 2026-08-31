Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA05AC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0xJd-0007on-4s; Mon, 31 Aug 2026 04:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0xJQ-0007nG-8X
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0xJO-0008DR-PB
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788164654;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8HguE2tO0ppIM7b/8zF7gN80KiHnxhpnh7ekrmt7A0=;
 b=Ay9oVXL8HiQHt+nl8AtFLvLk1EM5K9NyW+xDTBUlCsoEK4pDI3ONAD91t2sVGVnrzchWnN
 M6Ug839BrolMUyhF1fOAMo67EK8XU9pEKOooeOMTWTNV3HPOzbXiXtV9HJ/o3w93aN7nwl
 aSja6AWjooYoPrg/6rH0ytVjdXr6+rg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-hRd5aveUOzaWcPX8aVmFig-1; Mon, 31 Aug 2026 04:24:11 -0400
X-MC-Unique: hRd5aveUOzaWcPX8aVmFig-1
X-Mimecast-MFC-AGG-ID: hRd5aveUOzaWcPX8aVmFig_1788164651
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f726186c4so1522702f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 01:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164650; x=1788769450;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n8HguE2tO0ppIM7b/8zF7gN80KiHnxhpnh7ekrmt7A0=;
 b=AxcD7BoNrsOz1jjTrgHq8bnYwwxMqExUvRXTSdjlPB911qfHGJW5hJxxA0ssSOwgxy
 oXJ6yvXs41fXQB0M37UA/ob8ayagUB6zEO6/mWmWTEE07yq4UtzsMOK92qlFLyZi0XBl
 HpHRm5ws+3aUL1WuHebUX9kVMTYdfq7haGgASBIYRgrout7SD3OO19/zqHtxxPH7FXGf
 j/nStzrOt/MjmQLsWWjGR6V5EDAgWWEnMDQutgnBPC0P/JWQaM6uIR1J9AKlDNP8jQWU
 418vPn0Lf3p7qJqhsuSdwy0843wltn45YrgNiQmS2ZcDm+j0LmKGnMRudAkftDDAMpLC
 Ik7A==
X-Gm-Message-State: AFuF++mMuh/AzSkKMncX2v6/yCqhbG/T7ocPlgkKBi0tGNWOr7BMKnMM
 LwGqBeTEdB6izGtpzCAs3vx93u+OBWTFDO0UPmkYZd09FS5+604Y5rFW3OMFWgZWoeM/rPQ6sMq
 ikjxGVC7GZiiJBGIHBYZygLZOS3DPvhc1n4bGYcWd/XC5cIxmN7RHBppF
X-Gm-Gg: AYBFou0G/gbFAVyfqWwJWlLdEIO3tmaREJoznfK8sPyZ3EgSVIZv6lUSxRU6lfGbAKi
 MwUEf2vXSs9lqRNd1T0nlqzMH+p3eYpigvUfTIMiFD+ORnp9tsfcYcoGdY+fISqtPRyUZFK2bTW
 YwsBPU/j52RNp2x00uHI4gQM0/ThsHPw1iQS9cUfeKQRgahQH3Oq0ow+DEE+vs4oYDTuTgWZDA6
 pzmwa47rYgMujTyakr0jGhty/ny9IyoGsO8T06MV/7JNiNXPfyB+rWlVsKdrV/iMdFFGmdi/gl+
 opJUVhw2sTdqOWeTGVWBNSPOT9PyCKJTpfMrJy0FeOlan+F5pzxxzQnOtfoN1zNFt+bteK76ZXR
 QyFLd4mlJnXiWCG+zMbkIUdEEFS49cV1MDPx7bC4jtpwwC9C2
X-Received: by 2002:a05:6000:607:b0:484:3313:77a1 with SMTP id
 ffacd0b85a97d-4843ea0b47fmr3255781f8f.28.1788164650648; 
 Mon, 31 Aug 2026 01:24:10 -0700 (PDT)
X-Received: by 2002:a05:6000:607:b0:484:3313:77a1 with SMTP id
 ffacd0b85a97d-4843ea0b47fmr3255698f8f.28.1788164650207; 
 Mon, 31 Aug 2026 01:24:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb33070sm21829774f8f.36.2026.08.31.01.24.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 01:24:09 -0700 (PDT)
Message-ID: <c6469ddd-f9f6-4e4f-aad5-29c61d0a93ce@redhat.com>
Date: Mon, 31 Aug 2026 10:24:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 25/28] hw/arm/smmuv3: Reject IOMMU notifiers for non-NS
 devices
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162624.2809349-4-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162624.2809349-4-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/13/26 6:26 PM, Tao Tang wrote:
> VFIO and vhost IOMMU notifiers currently support only the Non-secure
> system-memory path. Reject notifier registration for non-NS devices
> instead of allowing an unsupported configuration.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index a755f1ebd69..2375b7a17a0 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2932,6 +2932,13 @@ static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>      SMMUv3State *s3 = sdev->smmu;
>      SMMUState *s = &(s3->smmu_state);
>  
> +    if (new != IOMMU_NOTIFIER_NONE && sdev->sec_sid != SMMU_SEC_SID_NS) {
> +        error_setg(errp,
> +                   "SMMUv3 does not support IOMMU notifiers for "
> +                   "secure devices");
> +        return -EINVAL;
> +    }
> +
>      if (new & IOMMU_NOTIFIER_DEVIOTLB_UNMAP) {
>          error_setg(errp, "SMMUv3 does not support dev-iotlb yet");
>          return -EINVAL;


