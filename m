Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3719AEE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqY6R-0001S8-Dv; Thu, 12 Feb 2026 09:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqY6K-0001PB-St
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:55:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqY6I-00013z-Ec
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770908125;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ruwqeror+Sw96vUtLNAXeFD41KFyFfjG6+3eKywQLB0=;
 b=dKjv0WxFyxseFIyJfR0WlKeKv0ZZUj05EuGNwkYKuU6Y7kA5ZuYXP8+aRRcTT08G9tq91N
 hGibgkQLLLZOJo+wEgH39sYVkCcHI1NPpyeRiwnYBFw1r/1C2E1R/BxPZY0pXbnKwc1oDG
 QNbEOjQeoq4qV4NUyFO2ypcCP7YJt9M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-5MojBf1HMlWwWpqYRjdnyA-1; Thu, 12 Feb 2026 09:55:24 -0500
X-MC-Unique: 5MojBf1HMlWwWpqYRjdnyA-1
X-Mimecast-MFC-AGG-ID: 5MojBf1HMlWwWpqYRjdnyA_1770908123
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48057c39931so83343705e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770908123; x=1771512923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ruwqeror+Sw96vUtLNAXeFD41KFyFfjG6+3eKywQLB0=;
 b=IqJ6ljW4gLUnlw9I0VLjT8Q4DrO3FPqiFEEtG5aEwaTBRdamQfhqB0kSQ8Z6lXY45T
 5X6QEs0tTtB8JNbCGOl7pe7X/FeBlUHSdYAlJlfPLZKDjtEDxfbdjeY2EUZzQa6VskEA
 RY8RBpE39twZkR0QMLfgdatvlb8aFn8KEz/nJJ6hCalsD7PnkTB5crhO1q+3BEfSK/kS
 qOAnEqv5sbrLtUAEFi/hZwad3+qAIl9M00XWMAPf5gBumAplithCMsvV9xoizNXLvSsQ
 iVyJXnuqVkSAybsQ7m8AJVilYSA+WTwH5xsQubgBBIeTJznYvi91vcczYhC79vHXHwSa
 iHBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7we9lLQ4qX26gRAg3M1mknJLmL9iO2pb+OwjBPMEwCB6kwpSnG5FQTR0VC7ohh1AFNbY5ZEL2hDrI@nongnu.org
X-Gm-Message-State: AOJu0Yx8KaWhlKpbysSi9D/EkFJV+scX/qXpqy5KBcTAtRya7rByTxxV
 cSIvAi++vakOV5SYuwqeLVQf8hPfUxU/b74TaPCKRecNt3Q6dOX8mBgbb8/DlRhZpF3GF0Y4BnM
 Kk5FGjItCF5iRVhxcWh5lSKSkZDC1r68UmUglXo4ue5hmEimZ8z5xoYKb
X-Gm-Gg: AZuq6aITGQpYrnHQijQfN2+T/oC69oxEg1w6QPX1jEVU+p+kbRoFU7Mya7kcKjlE/7y
 N+WP4VuRPlAKh1xM3zGgqrAVjw7BGEbm2asnslYgea80zUeQnR2nrKuvzq0FowH7poSErt2Plif
 60ctWEc/koIa+jz+7VFU/kSOQd1OZBe7huQE0JKPHtYstRzNpbgoZ6r3mbGR814R4H9w1Cmzy3a
 ps5bYSGKFLYKZIedGy0Aa08SKl0NI/aiq4Pvrc0VK2dbLFbBMUIlrNJHCcf9kSDCryZ2gkeh/v1
 tl+uMPQGwhQ8S8NoS6B6YOLZKJTZnTZ4sfQhIkxhXukvmiNLT5s2WI6P86BeLfLu8lRUdNmxBNz
 cMzKngYtfsTD5ejGTWqozybwfCdWv/F9dipsJMiv1gtt7LNYVG027Xl9MD9RDxSnVn38Czw==
X-Received: by 2002:a05:600c:458c:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-483656c60b8mr38185405e9.11.1770908123173; 
 Thu, 12 Feb 2026 06:55:23 -0800 (PST)
X-Received: by 2002:a05:600c:458c:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-483656c60b8mr38184755e9.11.1770908122637; 
 Thu, 12 Feb 2026 06:55:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a5bf1efsm94069085e9.0.2026.02.12.06.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 06:55:22 -0800 (PST)
Message-ID: <f8a3488a-0c9b-4b0e-99bd-ba9f4cac416f@redhat.com>
Date: Thu, 12 Feb 2026 15:55:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260206144823.80655-6-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 2/6/26 3:48 PM, Shameer Kolothum wrote:
> CMDQ-Virtualization (CMDQV) is a hardware extension to SMMUv3 that enables
> virtualization of multiple command queues (VCMDQs).
>
> CMDQV support is a specialization of the IOMMUFD backed accelerated
> SMMUv3 path. Introduce an ops interface to factor CMDQV specific
> initialization and CMDQV vIOMMU/vEVENTQ allocation behavior out of
> the base implementation. The ops pointer and associated state are
> stored in the accelerated SMMUv3 state.
>
> No functional change
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index c9c10e55c3..ca087240e5 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -16,6 +16,23 @@
>  #endif
>  #include CONFIG_DEVICES
>  
> +/*
> + * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
> + * support multiple VCMDQs with virtualization capabilities.
> + * CMDQV specific behavior is factored behind this ops interface.
> + */
> +typedef struct SMMUv3AccelCmdqvOps {
> +    bool (*init)(SMMUv3State *s, Error **errp);
> +    bool (*alloc_viommu)(SMMUv3State *s,
> +                         HostIOMMUDeviceIOMMUFD *idev,
> +                         uint32_t *out_viommu_id,
> +                         Error **errp);
> +    void (*free_viommu)(SMMUv3State *s);
> +    bool (*alloc_veventq)(SMMUv3State *s,  Error **errp);
> +    void (*free_veventq)(SMMUv3State *s);
> +    void (*reset)(SMMUv3State *s);
> +} SMMUv3AccelCmdqvOps;
> +
>  /*
>   * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
>   * Holds bypass and abort proxy HWPT IDs used for device attachment.
> @@ -28,6 +45,8 @@ typedef struct SMMUv3AccelState {
>      uint32_t bypass_hwpt_id;
>      uint32_t abort_hwpt_id;
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> +    const SMMUv3AccelCmdqvOps *cmdqv_ops;
in my original thought this was not AccelCmdqOps but AccelOps. This
should be squashed with the patch that turns existing accel impl into
those ops implementation.
> +    void *cmdqv;
Sorry I misread the purpose of that field. This aims at storing cmdqv
data. But until this is actually used, I think it is useless to
introduce it.

Eric
>  } SMMUv3AccelState;
>  
>  typedef struct SMMUS1Hwpt {


