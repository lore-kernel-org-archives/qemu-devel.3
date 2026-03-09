Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB431EFCD83
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzY6L-0001Vz-5b; Mon, 09 Mar 2026 06:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzY6J-0001Va-EH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzY6H-00088m-0n
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773053075;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZhNTp7Pq5smz8lIyXcFwu9623lVgzRVHSfXCB2lwpTY=;
 b=gSBKQLFM7eVQDwFoYGBnewxBv/dKbRF1yqvW2bjXN+aKPmhx56CJLzSSumMU1cvJ69J3yV
 EFXimBW1sAKT3+8LDzBnooZ53TJly9vbi57mIX9/1cAWG4n0ufA74/+7cLi2ABRxVHBsPt
 0/2BS796ncfjJdMuiwBfx3z0BQrWl/c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-eULO9YGqP1m82DEjJlg34Q-1; Mon, 09 Mar 2026 06:44:32 -0400
X-MC-Unique: eULO9YGqP1m82DEjJlg34Q-1
X-Mimecast-MFC-AGG-ID: eULO9YGqP1m82DEjJlg34Q_1773053072
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so1361965e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 03:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773053071; x=1773657871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhNTp7Pq5smz8lIyXcFwu9623lVgzRVHSfXCB2lwpTY=;
 b=NJ9QPNCK3DGhTS09PxUhIFGV3YO2ftIdSkp3vGpo5OTHphxLVoNWMh76zRKZJgLJy8
 +e9vSib4fvVQRUVLZlwI7oV23Z5z0hVB24mBsQyOfd13X6ERyeCxbpq2D93YjJXrVe6N
 XiefTJqz3g1fwi/c49bE0TmZy4UCSTLk+UyYn3WTPE8T3fBbtMM+D5oK2sFrExiSizLa
 pvYYtaVrJO4cQfQPGxrBQCUZ2jt5JT0GsN8WMqw7bIigZCoYb2xmbmNVfqfk/g1vyySA
 DB2S99Dp7ChQwfDXLHfKEKlhsFatMb19pnMqi2bhw3zQdQr/Ayy4UEVr00QDb9O7ZsG3
 zulA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8jNGqsufGtHl5i80BM0qcXW/o6sd7DHnDBydiSR8WlIg6zOA4ZaLr9v+rMJPFbxqjEGRVtw8PoKXk@nongnu.org
X-Gm-Message-State: AOJu0YwJYGnnzmnbjWlqlVFeXFAwAn9Zi3tz58wX0GsrPey5UifZZ90G
 FX1vVK/nRkPwdTibUbouSTS6tYgI+W8QL29aTAfhngahhQxucUvlOrxBc6839g1eRm2BGXxxwKi
 ciwsSCLBcIqcp6STSLFSUw/EiNAcCY2rnEpMAOcLCGbV3Fs1rsAmg5Fij
X-Gm-Gg: ATEYQzysG26hyzvA2wcK2bTRev/4AKzXJ5tryBlNG8ccOmwydyBQPkFDK74USOtz8nx
 Dro/XckKoBVpwM5QaV7zm+0+9uQJIu47ZyE+I/NQB04saTcjmyB5jyx2WPZ4DoePv8PMa0LtfE9
 /+iH2OFPG9ftsL+y0YJ8jOUsu/Vp8zx2nSUrqn0ZFns0D3Mbi7U5XIrMYJSUs/Z2jX1SuivrXAQ
 c9z4jEpK0ATPFuJkKzGwvxS8cp/653kRrgFE5vJ21admWTsC67rSML+IwpDz5OJiCoTLhyuloYp
 uwAWD4gQDyxKCxPFcBuSBu7SH2Vkty5XyyigKSf73hfYWj6YtjYznqVeJBEDG4adUOF3W3x5KBC
 Kfx+eyWDHXW2Qz9yJDrxggXs+/uxN/30VZYkxzB+FsW4dXsxlh4nE52Fgafgx0oa3zAR6OA==
X-Received: by 2002:a05:600c:1908:b0:480:3a72:524a with SMTP id
 5b1f17b1804b1-4852695943emr193456355e9.19.1773053071430; 
 Mon, 09 Mar 2026 03:44:31 -0700 (PDT)
X-Received: by 2002:a05:600c:1908:b0:480:3a72:524a with SMTP id
 5b1f17b1804b1-4852695943emr193456005e9.19.1773053070948; 
 Mon, 09 Mar 2026 03:44:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853ebab1a2sm33513055e9.1.2026.03.09.03.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 03:44:30 -0700 (PDT)
Message-ID: <75434356-b105-4f37-a157-86e595bfb688@redhat.com>
Date: Mon, 9 Mar 2026 11:44:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/32] hw/arm/tegra241-cmdqv: Implement CMDQV init
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-12-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-12-skolothumtho@nvidia.com>
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
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Tegra241 CMDQV extends SMMUv3 with support for virtual command queues
> (VCMDQs) exposed via a CMDQV MMIO region. The CMDQV MMIO space is split
> into 64KB pages:
>
> 0x00000: Global CMDQV registers
> 0x10000: Global VCMDQ registers, Page0
> 0x20000: Global VCMDQ registers, Page1
> 0x30000: VINTF0 logical VCMDQ registers, Page0
> 0x40000: VINTF0 logical VCMDQ registers, Page1
>
> This patch wires up the Tegra241 CMDQV init callback and allocates
> vendor-specific CMDQV state. The state pointer is stored in
> SMMUv3AccelState for use by subsequent CMDQV operations.
>
> The CMDQV MMIO region and a dedicated IRQ line are registered with the
> SMMUv3 device. The MMIO read/write handlers are currently stubs and will
> be implemented in later patches.
>
> The CMDQV interrupt is edge-triggered and indicates VCMDQ or VINTF
> error conditions. This patch only registers the IRQ line. Interrupt
> generation and propagation to the guest will be added in a subsequent
> patch.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.h   |  1 +
>  hw/arm/tegra241-cmdqv.h | 18 ++++++++++++++++++
>  hw/arm/tegra241-cmdqv.c | 30 ++++++++++++++++++++++++++++--
>  3 files changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 5bdd01afb5..7d6e4c6b76 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -42,6 +42,7 @@ typedef struct SMMUv3AccelState {
>      uint32_t abort_hwpt_id;
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
>      const SMMUv3AccelCmdqvOps *cmdqv_ops;
> +    void *cmdqv;  /* vendor specific CMDQV state */
>  } SMMUv3AccelState;
>  
>  typedef struct SMMUS1Hwpt {
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 312064a081..46aa9e8a9f 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -15,6 +15,24 @@
>  #define TEGRA241_CMDQV_MAX_CMDQ            (1U << TEGRA241_CMDQV_NUM_CMDQ_LOG2)
>  #define TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2 4
>  
> +/*
> + * Tegra241 CMDQV MMIO layout (64KB pages)
> + *
> + * 0x00000  TEGRA241_CMDQV_CFG    (Global CMDQV configuration)
> + * 0x10000  TEGRA241_VCMDQ_PAGE0  (Virtual CMDQ page 0)
> + * 0x20000  TEGRA241_VCMDQ_PAGE1  (Virtual CMDQ page 1)
> + * 0x30000  TEGRA241_VINTF0_PAGE0 (Virtual interface 0, page 0)
> + * 0x40000  TEGRA241_VINTF0_PAGE1 (Virtual interface 0, page 1)
> + */
> +#define TEGRA241_CMDQV_IO_LEN 0x50000
> +
> +typedef struct Tegra241CMDQV {
> +    struct iommu_viommu_tegra241_cmdqv cmdqv_data;
> +    SMMUv3AccelState *s_accel;
> +    MemoryRegion mmio_cmdqv;
> +    qemu_irq irq;
> +} Tegra241CMDQV;
> +
>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
>  
>  #endif /* HW_ARM_TEGRA241_CMDQV_H */
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index a270fa7ce4..6959766129 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -13,6 +13,16 @@
>  #include "smmuv3-accel.h"
>  #include "tegra241-cmdqv.h"
>  
> +static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
> +                                 unsigned size)
> +{
> +}
> +
>  static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
>  {
>  }
> @@ -29,10 +39,26 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
>  {
>  }
>  
> +static const MemoryRegionOps mmio_cmdqv_ops = {
> +    .read = tegra241_cmdqv_read,
> +    .write = tegra241_cmdqv_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
>  static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
>  {
> -    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> -    return false;
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(OBJECT(s));
> +    SMMUv3AccelState *accel = s->s_accel;
> +    Tegra241CMDQV *cmdqv;
> +
> +    cmdqv = g_new0(Tegra241CMDQV, 1);
> +    memory_region_init_io(&cmdqv->mmio_cmdqv, OBJECT(s), &mmio_cmdqv_ops, cmdqv,
> +                          "tegra241-cmdqv", TEGRA241_CMDQV_IO_LEN);
> +    sysbus_init_mmio(sbd, &cmdqv->mmio_cmdqv);
> +    sysbus_init_irq(sbd, &cmdqv->irq);
> +    cmdqv->s_accel = accel;
> +    accel->cmdqv = cmdqv;
> +    return true;
>  }
>  
>  static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


