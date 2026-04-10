Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC34E9904F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB6Uw-0000Zw-Uq; Fri, 10 Apr 2026 03:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wB6Uu-0000ZH-AA
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wB6Ur-0000eN-1x
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775806904;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCf7g8F9KxcApSEA2qC2s65YlgaHMhK3MANE2ANARdQ=;
 b=GUFqcsxNxeFaB7moeDfnVsTunhOCZPhse2y02pphlEQrFQW7q0LmENJEfakADL/8DW/qk8
 3iBrsI7RiEtJIBXJHJn7CJVw1kF+/yyWrHyPXQfCYf7b5egAD7JotjRMXjSV8BlpDlCDNw
 zaY5jwGzrRLcL8Aidi5QX+Cbw/MknCE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-_1bkbvxeNOGrmlu_zlo_0Q-1; Fri, 10 Apr 2026 03:41:43 -0400
X-MC-Unique: _1bkbvxeNOGrmlu_zlo_0Q-1
X-Mimecast-MFC-AGG-ID: _1bkbvxeNOGrmlu_zlo_0Q_1775806902
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d1dea12aaso1221993f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 00:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775806902; x=1776411702;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCf7g8F9KxcApSEA2qC2s65YlgaHMhK3MANE2ANARdQ=;
 b=JzIp/E1ZxWUXKJKnDMFHSBCutKWFidTdWUbqM33w5BOoWiyCZZpvALdUuqbJ6JtPDJ
 tA/d/Wpy/8aDgiIOkLvo8v2OUYR7iZ8xnRC4wrOkFPIgF+nYsUIwP/PygrVyws5jOpeM
 rYQTEntTnh2FN2lYAbP5rbJXXt4TEjQ0ZEg2A7Y6PSBdsZkflM5TNlPy5vLQPCzb7/Ge
 XC4nJ7KOQcymGb46To7e8Ze27lRi9yTxA3/fbjB3L+Ihc9M281znnwMOrmI9Qgohh3z2
 pr3ZvsL5HdO9vWuO+Sz0JbO5WhzmaKYyqrXpBStF80aRWHHylNJyVm1542RfnjpymW/m
 3eig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTjL1h8oQJmvN+MrQ3yKDyuT8guREikZ4cgnTVyur2CaSr69hiKHvDDcOqkcknP1BPYohtRqQkAKrD@nongnu.org
X-Gm-Message-State: AOJu0YyxrdW/nmgpYDkwODjE2QY6zy4L8xvloUJmpFtBZQtNW1EOts8E
 +J75meD0YyTddGvwLcpUD7i1IcTPNhe6eBXh9QSSzEcQaRwkTOhX03jhJY14OrMu77cSbbotsnL
 azbCHuQPR/VjSrReu/cxrB4/XvAFxUq+MVleJ1R/9R5+5PYAe5X7rA2Il
X-Gm-Gg: AeBDieue+Rosl5KSt8wb4krr5HFY4Dm/QvxqZiTQ/rkmH2pdzes80+TlvpmUSj4JlUo
 MnMZESAmesQjkK9m0kW5zxNWizgdmKRKOOe0dFH65PIJLKsz5JooCorBxrS3efroffbrHG6LJQH
 Nehog98jmPXezIl5geIoo/hPLkg9q8GhWw0IAuLuyRy1i+vVjfa+HQEpxNtbnd0hUCY8Bq8MV+S
 o6aDUuqije8QQHiEnr5NNHLCD6atwKLeh1SwTIcNWge7CWwLN2w1Js8xbnqk35F4tnuyz/TZpLY
 9Vb3fDtCwHwF1lr1AkbmnlZ0LzTlx31vbS3JEtrYuAHpG+To4KOHiDQICI4PEEdmoBZaRomqr4B
 GVInVYtepYSHh00Qa+Aa/SMh+FPQorgE6+eDMnsGQA3Hz3IE/2NK8jLZHLHfRfXyXJAcWgA==
X-Received: by 2002:a05:6000:26c2:b0:439:ddf9:a205 with SMTP id
 ffacd0b85a97d-43d6427b793mr2884384f8f.10.1775806901745; 
 Fri, 10 Apr 2026 00:41:41 -0700 (PDT)
X-Received: by 2002:a05:6000:26c2:b0:439:ddf9:a205 with SMTP id
 ffacd0b85a97d-43d6427b793mr2884330f8f.10.1775806901260; 
 Fri, 10 Apr 2026 00:41:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63de2a53sm5506192f8f.5.2026.04.10.00.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 00:41:40 -0700 (PDT)
Message-ID: <a8cece25-47ff-4210-8962-cbc39ba7646e@redhat.com>
Date: Fri, 10 Apr 2026 09:41:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] hw/arm/smmuv3: Change the default ril support to
 match the host
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-7-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260401010231.4166776-7-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Nathan,

On 4/1/26 3:02 AM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Set the default value of RIL to auto. The default for RIL support used
> to be set to on, but we change it to match what the host IOMMU
> properties report so that users do not have to introspect host IDR3 for
> Range Invalidation support. Include the previous default for ril in the
> 11.0 compat.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3.c   | 2 +-
>  hw/core/machine.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index a2d2f0e3bc..74cc81ae32 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2153,7 +2153,7 @@ static const Property smmuv3_properties[] = {
>      /* GPA of MSI doorbell, for SMMUv3 accel use. */
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>      /* RIL can be turned off for accel cases */
> -    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
> +    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 6796ab63cc..8f8c26bbe8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,6 +41,7 @@
>  
>  GlobalProperty hw_compat_11_0[] = {
>      { TYPE_ARM_SMMUV3, "ats", "off" },
> +    { TYPE_ARM_SMMUV3, "ril", "on" },
I wonder if you shouldn't squash all the patches that change the default
values of accel props to auto mode into a single patch, at the end of
the series.

Eric
>  };
>  
>  GlobalProperty hw_compat_10_2[] = {


