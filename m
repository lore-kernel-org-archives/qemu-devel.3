Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F141FCA16D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzezZ-0003AR-Lq; Mon, 09 Mar 2026 14:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzez6-0002r0-R8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzez3-0006PI-6T
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773079535;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RSkhSt4Fb9nP3/k9VvA+YUoAEvUs0VhexEQbV3lRDCc=;
 b=eyymcv3Su+cM5Gf+LcSt7UNLi0u55dSqp5icfSBSOjILx1nUVYZ+NUQVY0GGNEjRWu4KDY
 xC2KSCprQO3svWpdgbfQCBGnC3D0BHkFFa4B0A9WlIr6P/hfUq4PFxRdkjr1hTcewp/WIR
 xWlQ/rD7lDmrsJfsT1pfaZwNxP3F8Yk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-p20qIK32NPW6a4jH6xPxpA-1; Mon, 09 Mar 2026 14:05:32 -0400
X-MC-Unique: p20qIK32NPW6a4jH6xPxpA-1
X-Mimecast-MFC-AGG-ID: p20qIK32NPW6a4jH6xPxpA_1773079531
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48532df52c5so20774835e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773079531; x=1773684331;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSkhSt4Fb9nP3/k9VvA+YUoAEvUs0VhexEQbV3lRDCc=;
 b=ikY2gDUOeuGHa19/H1UC05uheYQxrjIezcDzNFUZMOi2w2rmFLIAp4AqsX7Garzja1
 1AMazwgd7N2sqf/dn1ITWVoPpzlEwYyeIDcIvarZpf1rOAe3WrBEEz74QF8xUaeQhvE4
 OgRLwcn44AX7+rsApGzlE2ywBxtLCI4robnj5EbiVBYKTY71Hud4UBA466X4/IHc2HoO
 yJgjnEaAJxDkYg1v2qGOipzWiIpEsOM18MS0vBJA+mSJNVCeGYLIZ4zZvJ3gP7qRDmK+
 4uyCCaSOnFYFbf+CS3gE0sRGS1Zwt2jp1wUDyPziVe8RxBOIXxD90M/YDMKPNY+owihS
 O3zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHFa+yOZRJeigBnTFMGtE34d2yNEKPQPfqZV4woCpfHX0jH2ZeZehA10dOjKUOHrUFg+ww+vodATAJ@nongnu.org
X-Gm-Message-State: AOJu0YyQgKZbxsHA2x3rDhAH7mGnukTcqXuWxQ4BESA1lb8AlnDLQiko
 zTcXdUktZBi93O/QjxekIConhttdLPReX6JHydF9Q4/3oDd9Bxt2/rtX5/byldKPPLQVWoHolrB
 JvOMAKNAYtMI4mhFrowRHDevbaBRL60+g8472u+ziAVMQSYx7tLwvT1no
X-Gm-Gg: ATEYQzwL/YaSO8NWZpp7KjORHoNTRjqE2lDwWGb3Qk5F90+kQoJaGSwgdcKELShkWhD
 5C/8QKgA5QZ1hay7LqEIsGEkEoohA5wuHMzzjyO31vooU+hSnItTytS8hBasOQOPkKtYcmJllNw
 W6WCgrDfn2uZRqq6RaOfNfFDic0RpI07BRzA3vPSYt0gXt4U3CFpD5aC/RTyiq8YxpBvAEyiedi
 AYlp6+VDOe2AegP55714/XBis9nY7l5czdyHZJh6aqdhjiLtRdIxolMD/qsQtsVNYU7fFzu+OLz
 m1aCh8uujsEvc7TJtvgBI+rFv2pOGfttXHPJJ9HtJqEt7otRTW6H4HmtKk+SLABUhUmsqHZozaP
 ig0Cnz+bdJ3Axr8Jo/zRK3jUhxW6wwg6vYMtpXS6Gr9E3R0ZgyVyLKwyRRxIen0klL8/JLw==
X-Received: by 2002:a05:600c:4510:b0:485:3c8f:e4ce with SMTP id
 5b1f17b1804b1-4853c8fe68amr54455415e9.18.1773079530708; 
 Mon, 09 Mar 2026 11:05:30 -0700 (PDT)
X-Received: by 2002:a05:600c:4510:b0:485:3c8f:e4ce with SMTP id
 5b1f17b1804b1-4853c8fe68amr54454965e9.18.1773079530257; 
 Mon, 09 Mar 2026 11:05:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246fd127sm140956635e9.6.2026.03.09.11.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 11:05:28 -0700 (PDT)
Message-ID: <3cd7007b-b57f-4e4d-a354-75aab41eddeb@redhat.com>
Date: Mon, 9 Mar 2026 19:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/32] hw/arm/smmuv3-accel: Introduce helper to query
 CMDQV type
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-31-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-31-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> Introduce a SMMUv3AccelCmdqvType enum and a helper to query the
> CMDQV implementation type associated with an accelerated SMMUv3
> instance.
>
> A subsequent patch will use this helper when generating the
> Tegra241 CMDQV DSDT.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-accel.h       |  7 +++++++
>  hw/arm/smmuv3-accel-stubs.c |  5 +++++
>  hw/arm/smmuv3-accel.c       | 12 ++++++++++++
>  hw/arm/tegra241-cmdqv.c     |  6 ++++++
>  4 files changed, 30 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index c349981e79..6d21788006 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -15,6 +15,11 @@
>  #include <linux/iommufd.h>
>  #endif
>  
> +typedef enum SMMUv3AccelCmdqvType {
> +    SMMUV3_CMDQV_NONE = 0,
> +    SMMUV3_CMDQV_TEGRA241,
> +} SMMUv3AccelCmdqvType;
> +
>  /*
>   * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
>   * support multiple VCMDQs with virtualization capabilities.
> @@ -30,6 +35,7 @@ typedef struct SMMUv3AccelCmdqvOps {
>      void (*free_viommu)(SMMUv3State *s);
>      bool (*alloc_veventq)(SMMUv3State *s,  Error **errp);
>      void (*free_veventq)(SMMUv3State *s);
> +    SMMUv3AccelCmdqvType (*get_type)(void);
>      void (*reset)(SMMUv3State *s);
>  } SMMUv3AccelCmdqvOps;
>  
> @@ -73,5 +79,6 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
>  bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
>                                        void *buf, size_t size, Error **errp);
>  void smmuv3_accel_reset(SMMUv3State *s);
> +SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj);
>  
>  #endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
> index 1d5d3bb10c..5ca94d605f 100644
> --- a/hw/arm/smmuv3-accel-stubs.c
> +++ b/hw/arm/smmuv3-accel-stubs.c
> @@ -55,3 +55,8 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>  void smmuv3_accel_reset(SMMUv3State *s)
>  {
>  }
> +
> +SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj)
> +{
> +    return SMMUV3_CMDQV_NONE;
> +}
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 9a570b8af9..585b460943 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -998,6 +998,18 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
>      address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
>  }
>  
> +SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj)
> +{
> +    SMMUv3State *s = ARM_SMMUV3(obj);
> +    SMMUv3AccelState *accel = s->s_accel;
> +
> +    if (!accel || !accel->cmdqv_ops || !accel->cmdqv_ops->get_type) {
> +        return SMMUV3_CMDQV_NONE;
> +    }
> +
> +    return accel->cmdqv_ops->get_type();
> +}
> +
>  bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index a379341c0a..42d7dbfde7 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -736,6 +736,11 @@ static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
>      return true;
>  }
>  
> +static SMMUv3AccelCmdqvType tegra241_cmdqv_get_type(void)
> +{
> +    return SMMUV3_CMDQV_TEGRA241;
> +};
> +
>  static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                                   Error **errp)
>  {
> @@ -778,6 +783,7 @@ static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
>      .free_viommu = tegra241_cmdqv_free_viommu,
>      .alloc_veventq = tegra241_cmdqv_alloc_veventq,
>      .free_veventq = tegra241_cmdqv_free_veventq,
> +    .get_type = tegra241_cmdqv_get_type,
>      .reset = tegra241_cmdqv_reset,
>  };
>  


