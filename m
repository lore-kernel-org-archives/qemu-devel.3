Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFE5E99050
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB6bo-0004OR-TV; Fri, 10 Apr 2026 03:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wB6bn-0004Ns-Dk
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:48:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wB6bl-0000x4-Lz
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775807332;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBGZ6JM/BSa0w7YId9FU+Qo7pHR2PL+YRxE/T8f8nNM=;
 b=Y31FSIthi8RR67o8ggfVyorlZ9el2T8hMpH7Vk9/8IOM1CUW6rCfbbyYJkvgAy/RIyXPF/
 OGA9o6ORjW3ekNV794YNx95TLIDCiVllJUTYpYDYxDh0rgePgI11gwKb5y/vCyDdnM3Fq3
 wisgSt65sETwpp0LNlcd91LcjI+O8kg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-A_C6LYCAOJOXwTZWPc5q-g-1; Fri, 10 Apr 2026 03:48:51 -0400
X-MC-Unique: A_C6LYCAOJOXwTZWPc5q-g-1
X-Mimecast-MFC-AGG-ID: A_C6LYCAOJOXwTZWPc5q-g_1775807330
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488c2a4e257so12439515e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 00:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775807330; x=1776412130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBGZ6JM/BSa0w7YId9FU+Qo7pHR2PL+YRxE/T8f8nNM=;
 b=deWJfzOfSK+coj0o2EXZSIfta0lK2pa6KX3kjbOm6hYPTXkxOwkDkdreKQT9yQ5Dhy
 nZwJE/nYhnSEFaTL52eGzZo0XXhffK3i9+u8bI1pPHL1N6tQ/FoiQrdakfPqxv/+BdcE
 WAQvyRE69Eopw+rTSokJbLkLs8ZSI+JlNXHWg7eaxKZRTGu9kvrnAKcV5VlWQqr0np4V
 mn4TJ+/HHv8T5EaYoBm3sOLPg69cfO6PEkcrMEt3VerztBepS6o2ovwiVn80vhXPYJ6y
 x0mwWSC2K9+Xs4gg2RsYgqGmkqhqirT7+P/QFlzDnRktMr1ysnBqueIaj46H6pAFcJaI
 A84Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf5FFcF9jyZWkLUjzG2q75B1s2pWBwiS469Z7v2zx/GCEOgjregxfFKW3AhXKf+6chZGPCNYEjrpHy@nongnu.org
X-Gm-Message-State: AOJu0Yy2WUCu636nf5i37yCHaU8Wkzd6kYAljk9+GqvSuKVCysoPd6DP
 DsSywSZPGBa9WRHn+eQmBQbNdNPBDN+fUdWxM99wS4P0Q7A9WgkMvOMaf5a+cklJcUlsUZfsMw1
 Yq3MeQPYv1n8Ens9ptLG50FFbtYzY9H3gNed4/Nnc5WBl3F5SI2gEUBkl
X-Gm-Gg: AeBDieu6ZNID2Ij+4POqg5iZkuGYanST5h0Jchn7xSApdwIVnYzWQbx8aHGAu6GoMRi
 3BKJ1DGjprkdFgiC6/PzCD8adCKV80rin80MNWhFi2bAU2gdy1/0jwLcJL6Q3/VEl6uQf9nnjRD
 mYxoi3d4VVhlzDZnU70KBsoV979ZbsuXQY/jVch4fuwzg1P4VC1QJKYB1UjRjFBuwiEiwkUk5BW
 q3IjlpPUKvN6pWWIL51H94uXaO45YJ7v3O2GdNkIyLLfXegLr2kclV3cvT7zbIojMZZYp96ViwP
 +Stru0V+IAJfwHNZnfkuT5POSQsw8f6FCE4IKeLgBUGyAhFRdw+xN1aHfNJGlcNDm1TK07dtWCU
 ljWpUBmVr945rVA2M57/gmgo0NKP0tCn9tWwieaP8kuwDj8NivEWVgx+vWMraVJDkmI3fFw==
X-Received: by 2002:a05:600d:d:b0:485:4eaf:eb54 with SMTP id
 5b1f17b1804b1-488d684b88amr18688705e9.20.1775807330015; 
 Fri, 10 Apr 2026 00:48:50 -0700 (PDT)
X-Received: by 2002:a05:600d:d:b0:485:4eaf:eb54 with SMTP id
 5b1f17b1804b1-488d684b88amr18688415e9.20.1775807329583; 
 Fri, 10 Apr 2026 00:48:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67ced32sm18454905e9.7.2026.04.10.00.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 00:48:49 -0700 (PDT)
Message-ID: <c7b98752-c626-46fc-9aea-6f0c182e9940@redhat.com>
Date: Fri, 10 Apr 2026 09:48:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "oas"
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
 <20260401010231.4166776-10-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260401010231.4166776-10-nathanc@nvidia.com>
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



On 4/1/26 3:02 AM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Allow accelerated SMMUv3 OAS property to be derived from host IOMMU
> capabilities. Derive host values using IOMMU_GET_HW_INFO, retrieving
> OAS from IDR5.
>
> This keeps the OAS value advertised by the virtual SMMU compatible with
> the capabilities of the host SMMUv3, so that the intermediate physical
> addresses (IPA) consumed by host SMMU for stage-2 translation do not
> exceed the host's max supported IPA size.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 9 ++++++++-
>  hw/arm/smmuv3.c       | 6 +++---
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 03393fd7ba..105f6d26bf 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -63,6 +63,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
>                                 FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
>      }
>  
> +    /* Update OAS if auto from info */
> +    if (s->oas == OAS_MODE_AUTO) {
> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS,
> +                               FIELD_EX32(info->idr[5], IDR5, OAS));
> +    }
> +
>      accel->auto_finalised = true;
>  }
>  
> @@ -962,7 +968,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>  
>      if (s->ats == ON_OFF_AUTO_AUTO ||
>          s->ril == ON_OFF_AUTO_AUTO ||
> -        s->ssidsize == SSID_SIZE_MODE_AUTO) {
> +        s->ssidsize == SSID_SIZE_MODE_AUTO ||
> +        s->oas == OAS_MODE_AUTO) {
>          s->s_accel->auto_mode = true;
>      }
>  }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index cb14a08a66..0ab6d1e762 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1976,7 +1976,8 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>      }
>  #endif
>  
> -    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
> +    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48 &&
> +        s->oas != OAS_MODE_AUTO) {
>          error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
>                     "OAS; other OasMode values are not supported");
and auto mode
>          return false;
> @@ -2189,8 +2190,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "platform has ATS support before enabling this.");
>      object_class_property_set_description(klass, "oas",
>          "Specify Output Address Size (for accel=on). Supported values "
> -        "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
> -        "supported.");
> +        "are 44 or 48 bits. Defaults to 44 bits.");
see previous comments

Eric
>      object_class_property_set_description(klass, "ssidsize",
>          "Number of bits used to represent SubstreamIDs (SSIDs). "
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "


