Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30234C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7AX-00050D-9c; Mon, 03 Jun 2024 08:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE7AV-0004zL-MA
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE7AT-0001Dn-Pt
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717419125;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+FkCkeLrHkFhJHxEbqLktxXAresWl4gcSfXK7hPNcs=;
 b=hN27/ZzZ79DmO2D02nKKZKWlLVx3GJ6BTzLf27nZjFIE8z5/GEAsjXnjjuH5G3blBog6CS
 HvLMBG5sDDEQp6omC64WEnpDeQ37MqybO/m6WpU9d5A8MdRM9oyasJdTps4S2gXwd9F6T3
 FE0E653v46jKOZtwc5jvbdsU+ahzjVQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-e8vR6jaPOF2zryzCxT9TzQ-1; Mon, 03 Jun 2024 08:52:03 -0400
X-MC-Unique: e8vR6jaPOF2zryzCxT9TzQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-792bd1dc658so721234385a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717419123; x=1718023923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n+FkCkeLrHkFhJHxEbqLktxXAresWl4gcSfXK7hPNcs=;
 b=N2MhEgxqgVsiDCKoYoj6JFLqaXIZ84leTHqy35aCL2F6jjUol59zuWs51IIO1i+wDi
 izUkkV0+1DX3c5KA4nWnYA3qQFKEQL+d/30gjSJdMpvV/cTsmLJsLeHiIcHzDOa84euc
 4k7sOKqk69ux732BAkDTDiYGJU0s0vS6+UQM+f/Mk0YHA/431t25jBN2cSZw8UW4iZib
 bw041NtX0fa1Ox6SYbWsvV/D/VHxdLKk/a0e2d9gg4pzv/zFa8QKNKG8/eVbghKd1FSC
 tfhrLFNTQnhWKUWovwVUnp8I2hzOA3bImoPQoLMPYG7A9WkaaqXYc0xtxipTowu0aKK4
 9WOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdzyHO2TEOVueji/U2SyEMv/rcy7CBxagfSv9EwAWjnz0EStrN93y3eYJLZDtubpRQ+BKH/jaUW6qcoaf5GV3SZl8WA50=
X-Gm-Message-State: AOJu0Yxx2I5lkQosd5kTIqqfbOtq+Vn6quPg18q847VRfSvhUxuYtLAT
 4XsBce/MjKSakAdPiCsXhXvzXifDckEJn7gPWCYX+JQMz66lTTAPUAQv/ZYNzdhUi9adbMiypMk
 /zDFFFcx8HQdRBfP0pEi27Qnbro/E0c9nYGPDl5DAyYjWD549ruwF
X-Received: by 2002:a05:620a:809:b0:793:24:ef45 with SMTP id
 af79cd13be357-794f4f489f3mr1499964085a.6.1717419123326; 
 Mon, 03 Jun 2024 05:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6DhDTLaJmT1+B2Y2JqdVhm+4Q+lUAJVSEwJpxaAhXAInWRBU3UUMDsXFBHxXNMtXKYtBk3Q==
X-Received: by 2002:a05:620a:809:b0:793:24:ef45 with SMTP id
 af79cd13be357-794f4f489f3mr1499960885a.6.1717419122932; 
 Mon, 03 Jun 2024 05:52:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f301975fsm280582785a.64.2024.06.03.05.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:52:02 -0700 (PDT)
Message-ID: <e490a18b-e703-4e61-8f4c-dcc78e68c58d@redhat.com>
Date: Mon, 3 Jun 2024 14:51:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/19] backends/host_iommu_device: Introduce
 HostIOMMUDeviceCaps
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-6-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On 6/3/24 08:10, Zhenzhong Duan wrote:
> HostIOMMUDeviceCaps's elements map to the host IOMMU's capabilities.
> Different platform IOMMU can support different elements.
>
> Currently only two elements, type and aw_bits, type hints the host
> platform IOMMU type, i.e., INTEL vtd, ARM smmu, etc; aw_bits hints
> host IOMMU address width.
>
> Introduce .get_cap() handler to check if HOST_IOMMU_DEVICE_CAP_XXX
> is supported.
>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

I would either squash this patch into patch 1 or if you prefer ti keep
it seperated, add it just after.

Eric
> ---
>  include/sysemu/host_iommu_device.h | 37 ++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index 2b58a94d62..d47d1034b1 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -15,11 +15,25 @@
>  #include "qom/object.h"
>  #include "qapi/error.h"
>  
> +/**
> + * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
> + *
> + * @type: host platform IOMMU type.
> + *
> + * @aw_bits: host IOMMU address width. 0xff if no limitation.
> + */
> +typedef struct HostIOMMUDeviceCaps {
> +    uint32_t type;
> +    uint8_t aw_bits;
> +} HostIOMMUDeviceCaps;
> +
>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>  OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
>  
>  struct HostIOMMUDevice {
>      Object parent_obj;
> +
> +    HostIOMMUDeviceCaps caps;
>  };
>  
>  /**
> @@ -47,5 +61,28 @@ struct HostIOMMUDeviceClass {
>       * Returns: true on success, false on failure.
>       */
>      bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
> +    /**
> +     * @get_cap: check if a host IOMMU device capability is supported.
> +     *
> +     * Optional callback, if not implemented, hint not supporting query
> +     * of @cap.
> +     *
> +     * @hiod: pointer to a host IOMMU device instance.
> +     *
> +     * @cap: capability to check.
> +     *
> +     * @errp: pass an Error out when fails to query capability.
> +     *
> +     * Returns: <0 on failure, 0 if a @cap is unsupported, or else
> +     * 1 or some positive value for some special @cap,
> +     * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
> +     */
> +    int (*get_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
>  };
> +
> +/*
> + * Host IOMMU device capability list.
> + */
> +#define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE    0
> +#define HOST_IOMMU_DEVICE_CAP_AW_BITS       1
>  #endif


