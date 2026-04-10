Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D1FE99049
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB6QJ-00061D-8z; Fri, 10 Apr 2026 03:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wB6QH-00060u-Kn
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wB6QF-0008Ky-O1
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775806618;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubV0vkvEAomTpEkTf6CuJhHEwYGUPp0mMDoCQtn74pA=;
 b=fu3fVjAkj8nGMngc0WEoBJBC+v5Ho5i/naZyLjc71jQPITWWJ3bzD96FB2myfpj2cHpPyh
 EVsvXVVvuMXeDbjrYYQ3r/ZJ0uEheFKvqB5MLUvNDTyA1wRVKiw+BKbgVeNW/Rf0io5K4b
 UYkoPRLZpT2qh0IG5D/jVpY/jNc3tgg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-JDiZkCQBO6yduLDgavIiDA-1; Fri, 10 Apr 2026 03:36:56 -0400
X-MC-Unique: JDiZkCQBO6yduLDgavIiDA-1
X-Mimecast-MFC-AGG-ID: JDiZkCQBO6yduLDgavIiDA_1775806616
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488a75d674fso11889265e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 00:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775806615; x=1776411415;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubV0vkvEAomTpEkTf6CuJhHEwYGUPp0mMDoCQtn74pA=;
 b=kESzckjKOVFtSIEDX6WJ1C3zoWZlDDZazwrp/DiqZtybrotNUZd1mPS5XeCOsRzbKn
 0xcZ6xeijBUttsH36mdZRcwFMS2Sfuo+O7cIBdSk7NSckBJSMX+RZxsnDSXhtWtbgeOH
 z46KeCHNNxQzCkfXIf4DmphFYaabNf2CGGKRhVmC8VJMzDElSImPJkKj1ZLnAsdGtfNF
 S5Izbk1ql49wtrwSjOYCRI2PBObfleFmZPcSQ6aBysuuDqIScMn06zxlp+8wW6VkWuBc
 yfqD9HLWt98tUoyz3oFKooK6uOj+0rEJ0tSXJ7a+Zfg1XT65flyHr6oxcw8DX6zdM5qr
 yowg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdfaEgUK3NbI6xLH78H+E+wOMwX7k3eSZy5rydGzJ7TIph3kgKFC18lTxi7r+1JYFLICaJjhuDUpZD@nongnu.org
X-Gm-Message-State: AOJu0YxGKXdMw6R6nl03O/BPzWTuajJ0ZhChYoGs8jK+Y/IHtTAbMkZz
 zwEqAd6+qbL+xKW8WIQk5jvXyGAi5QBjPRudUgbhKoGIzL8WoZtGDJY9lB8YTTFHTIgftNUrqCY
 N7fAJ3vCkUGbKnIZxtsO4/mZumgmcV5Hem/7T+1BhHMIOJZjCt17FzQtc
X-Gm-Gg: AeBDieukFPQfOrRsrVZBUGC7frKoKxTpKtRml5qR/HURyjboBfbCW+WdjG3b+vsP70m
 DvmYU6HAQffIKO083d07jCWqeM0T7l/RL1ZARj41SJUir9UYXq296+I1AfcKXp0VUhqFdQgFEyG
 LhJeWbGQaUDunIQtghItQidBNWXiwNe4tFdL9phKwNzspwPczSn4Wb774NH/wPpAwizxaIOXn3u
 uryPJ5pO33z/t+4iK1uj39AdoJKpPYiDBk0chLgP2wPa8zLzB4gLM4705V2y5BsGiMSnr5XvJ/z
 WB2d4kuM1cCGcN04KYTFKnaY+N/JkszUPeMxC0YCawMTmqzPfcyS3o0wu3A06RCcallVxDWDkDU
 nGCjKRYawweCLOYSZqVcTGxm4glXjMXggrQ4mDUqRB6YSQ1garLh+DpdYVuq3cCAWu0/7zQ==
X-Received: by 2002:a05:600c:c088:b0:486:f9d0:aac8 with SMTP id
 5b1f17b1804b1-488d6843187mr16116385e9.18.1775806615465; 
 Fri, 10 Apr 2026 00:36:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c088:b0:486:f9d0:aac8 with SMTP id
 5b1f17b1804b1-488d6843187mr16116055e9.18.1775806614974; 
 Fri, 10 Apr 2026 00:36:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d681ed50sm14090595e9.15.2026.04.10.00.36.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 00:36:54 -0700 (PDT)
Message-ID: <46116b64-c7a7-4d9a-bd99-a6b81fd45fed@redhat.com>
Date: Fri, 10 Apr 2026 09:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "ats"
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
 <20260401010231.4166776-3-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260401010231.4166776-3-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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



On 4/1/26 3:02 AM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Allow accelerated SMMUv3 Address Translation Services support property
> to be derived from host IOMMU capabilities. Derive host values using
> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 10 ++++++++++
>  hw/arm/smmuv3.c       |  7 +------
>  2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index a0146c8d31..a835c8f220 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -44,6 +44,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
>          return;
>      }
>  
> +    /* Update ATS if auto from info */
> +    if (s->ats == ON_OFF_AUTO_AUTO) {
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
> +                               FIELD_EX32(info->idr[0], IDR0, ATS));
> +    }
> +
>      accel->auto_finalised = true;
>  }
>  
> @@ -938,4 +944,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>      s->s_accel = g_new0(SMMUv3AccelState, 1);
>      bs->iommu_ops = &smmuv3_accel_ops;
>      smmuv3_accel_as_init(s);
> +
> +    if (s->ats == ON_OFF_AUTO_AUTO) {
> +        s->s_accel->auto_mode = true;
> +    }
>  }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 09ea08eb18..f3603554e3 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1973,10 +1973,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>      }
>  #endif
>  
> -    if (s->ats == ON_OFF_AUTO_AUTO) {
> -        error_setg(errp, "ats auto mode is not supported");
> -        return false;
> -    }
>      if (s->ril == ON_OFF_AUTO_AUTO) {
>          error_setg(errp, "ril auto mode is not supported");
>          return false;
> @@ -2196,8 +2192,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "is not supported.");
>      object_class_property_set_description(klass, "ats",
>          "Enable/disable ATS support (for accel=on). Please ensure host "
> -        "platform has ATS support before enabling this. ats=auto is not "
> -        "supported.");
I would explicitly mention that auto value is supported.
Maybe:
Set ATS support. Valid values are off/on/auto. If set to on, make sure
the host platform supports ATS.

You have examples in hw/arm/virt.c. For instance msi option.

Also note that the doc in qemu-options.hx must also be updated. 

Eric
> +        "platform has ATS support before enabling this.");
>      object_class_property_set_description(klass, "oas",
>          "Specify Output Address Size (for accel=on). Supported values "
>          "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "


