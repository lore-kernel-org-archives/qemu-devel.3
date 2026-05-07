Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F96CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 17:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL2X3-0003c1-2D; Thu, 07 May 2026 13:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wL2X1-0003bk-DY
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wL2Wz-0003u1-OS
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778174940;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvyZQBi5+VF0x5WnGKoVz73+0vHimVl/rdI7ML5BtJI=;
 b=S7SjxVvsAtEujxKE8RDD8mnOnVdotCWCGYxqRfZHVAvgeB2eoxCYCTjniiGGMTI75AoUZU
 eWhlIwvVsmgzkNmmrxSOvETbWSE8Sxl0co0zv5j5ju/BeKEtYtN07YS4+uwt9djKp4O9Su
 8MRVPnObPucKx+MJPQOg3FEfMLU/vk8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-IALikegdMEO1Pj8dIvYFYw-1; Thu, 07 May 2026 13:28:59 -0400
X-MC-Unique: IALikegdMEO1Pj8dIvYFYw-1
X-Mimecast-MFC-AGG-ID: IALikegdMEO1Pj8dIvYFYw_1778174938
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488bd1ee9e7so10046885e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 10:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778174938; x=1778779738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvyZQBi5+VF0x5WnGKoVz73+0vHimVl/rdI7ML5BtJI=;
 b=NgLy49t5vFr+7j6FOy9YnI8Fn55+kpK4jfgdguf7t9WmkYBO0NLNrCelvataCud5+q
 pgZTaCd+hdYNOdXH4umovR3JKuLocf9jYyt+FE5cYlbRMPOGwSdqGGir7d1HKmjjNoPs
 B/90hIkqVooI3qbVhHqeGti2J4LI/r3L2PGxLC6KvEXtZcSlvv/i05XUhl8qLg1gpqit
 SGh9GcTbSREHhx9ZDbMQ132sf0QvvAAUc+Aq+TbyVYNm2LWiD92x8+KEPAgi192/mu7I
 WF65r7SvAlQMrC4RTnAyTVomDMPewbFtqwcNe3hPBMNqtSDZaKaXG1e6dGtR1KUddlDs
 zkOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ubXNpQz96Z8jyCETe5uFRmx68jCAIR1oLrI1suPTHDdqC9U/Drh4ZE9JFY/4Ngl5BLOr38xniasMJ@nongnu.org
X-Gm-Message-State: AOJu0YwGNk3d4/NbVTzYajShBl14ax3nUci5kLcTxmRtx0d5n3rvaSDq
 tPd5CocVKf7TBOcPRYSK2OYxXHiqwhbxoH17iLLCEcRDEzYU85DuWP8lC112K5I9SIHyljRKB7O
 KaUDj34O99h0aKXe0iltauyFV4Sf5hkf9yXvRbelxh3OQqXssRLqorvMf
X-Gm-Gg: AeBDieuJke/Vx0+rbqXn2tFQOedFjpflzaTbBZNnnTQAWgbhhkodhDed6nTpXIhbR4Y
 v5wXumay/ZTN+GQtbFzIGmhancEHPOtNMfZ4dcTtGqFjBq4CxqZGCwrp6SLFxCSlwXPAeUqXs3M
 WxBl1KwKZidT3trzZ1WU6WaVmtg5JaGYuSxxRtqYCsT8DPe3hkjd75TNi0as1MY4YQ6+FxdfNvj
 6Ztcub1ZeIYchwxgvPDk3hfH6JPYtDgc9zcempP6oq5nWZKUgZTRjWVvz59ZQZe9045vs7KNYgF
 C9UcXTpPWYkaiqFPUknNrX0p06jM8xQuLDHWRki3tpjTPjZZORve1fSgPf8MamZFCMoeaobRVSb
 3Dsj9KBdXCLxLnxpopcdcREe4NLU0YcOGGv/T6kh0fYtBcay/pD5SsDA=
X-Received: by 2002:a05:600d:b:b0:48e:5d91:cffb with SMTP id
 5b1f17b1804b1-48e5d91d240mr54976385e9.10.1778174937909; 
 Thu, 07 May 2026 10:28:57 -0700 (PDT)
X-Received: by 2002:a05:600d:b:b0:48e:5d91:cffb with SMTP id
 5b1f17b1804b1-48e5d91d240mr54976045e9.10.1778174937487; 
 Thu, 07 May 2026 10:28:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45412de42aasm525961f8f.13.2026.05.07.10.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 10:28:56 -0700 (PDT)
Message-ID: <f6c4ad16-9f2d-4b97-958d-f2f92addaaee@redhat.com>
Date: Thu, 7 May 2026 19:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 31/31] hw/arm/smmuv3: Add cmdqv property for SMMUv3
 device
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-32-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-32-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/15/26 12:55 PM, Shameer Kolothum wrote:
> Introduce a "cmdqv" property to enable Tegra241 CMDQV support.
> This is only enabled for accelerated SMMUv3 devices.
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index c9ff6298f5..51b7d01da5 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1993,6 +1993,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "ssidsize can only be set if accel=on");
>              return false;
>          }
> +        if (s->cmdqv == ON_OFF_AUTO_ON) {
> +            error_setg(errp, "cmdqv can only be enabled if accel=on");
> +            return false;
> +        }
>          return true;
>      }
>  
> @@ -2161,6 +2165,7 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>                                SSID_SIZE_MODE_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO("cmdqv", SMMUv3State, cmdqv, ON_OFF_AUTO_AUTO),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2200,6 +2205,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "Valid range is 0-20, where 0 disables SubstreamID support. "
>          "Defaults to auto. A value greater than 0 is required to enable "
>          "PASID support.");
> +    object_class_property_set_description(klass, "cmdqv",
> +        "Enable/disable CMDQ-Virtualisation support (for accel=on)");
s/CMDQ-Virtualisation/CMDQ-V
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
qemu-options.hx also needs to be updated

Eric


