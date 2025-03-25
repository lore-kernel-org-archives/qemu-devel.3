Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D25CC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 18:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx8hk-0008SI-S3; Tue, 25 Mar 2025 14:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tx8hd-0008R4-Fn
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tx8hZ-0005hC-Ou
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742926116;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQeqxyFjZDfP8tiyt1ayO1EtZZ59B7aWgMm9xLmFc9Q=;
 b=VAziw9V/XPm2Pbx9WhRl59DGYvM6CRTFIPs6gg/wcAP1+bGw76MSeS5obqcZAIywbPFva7
 6lcz5f9up6NVq8U5Ch9ssU42Y4wCdGzSvspbKkp1GOHCehJZ2eiCOJ1Ctxsu3w5sDjzA0w
 U+VouoJjHTi0gcqPlBxfYOHI8uO/kcM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-viJlB7XROR6QimooO8K4ig-1; Tue, 25 Mar 2025 14:08:33 -0400
X-MC-Unique: viJlB7XROR6QimooO8K4ig-1
X-Mimecast-MFC-AGG-ID: viJlB7XROR6QimooO8K4ig_1742926112
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-399744f742bso1447670f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 11:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742926112; x=1743530912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eQeqxyFjZDfP8tiyt1ayO1EtZZ59B7aWgMm9xLmFc9Q=;
 b=IGKHMbFk2kUbD785wnlEI7QSwYghOvlPyNYn0MtXI2Sj2/Ps4XcNQ+jt22oipffb+o
 2FS7DZQZB5ai4WAAebZodpeGe2PtKLe/azQToeh7ThThyc91iN/G/QYHNr6VH8vcohNa
 2nxCs/1T4/wveCtVjag89wL0vnH9sIf49+y3SYicy9FN9YK8g796TWYm0t7ROowXnGKq
 gW1N1IJ8/vVz72SXFawaZpOg+A0bnKod2PtdOrjbzZwJGFVPazMkZNku561bQTnTibTt
 IhcPk34jwovjGqLLhpRtL973s2oXfQbe4oB5x/+qJ7OcZk1cMPHP+BIjIToQPtBGLh4O
 p7Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVNX9LT8MW2ZD9qWfqcgmkdBGM/0T555isWKk0bKHhup/fLQ1DGM+LXcpoqikfoiidEEkx0PNpr7dX@nongnu.org
X-Gm-Message-State: AOJu0YzcMYmf53XcvwtiS/Md6wogB32/SErbS7uhE/bsYuXnVUzo0rXp
 No0epkNayE1aGXjWP3+C3odG0ze7gFuFcqnNot/RPanFsTjzFPtPO+nY0Jbx5uOza3ssYIbS6It
 1DkgAQX3MYKJsTqiqOJH/apDPfj3X2qL/y6yGDYorYjnqjMyw9UU2
X-Gm-Gg: ASbGncuWTqXZIHz15hkE8YHO7Uas90cMKMZxXPznqBD5bnFnPf5h81WbrnacMt8sarq
 W/J7yQ3vT5Qk/gmgD2NTBN19sovQliOpDTwGuZvBTLVPqxb26QiyM1k3WQUoUEM8fFsyzlsWARc
 lkFS/xjzpdo4Y1XqU7KExFDkPRseLurJUn6Jh03Ev7Vko7qYmafh6x2QO86bByowjpdktyNSiJC
 SH0R6du5AnjV2lHgoUBDZ3nPYkDgsk7cqY5ykLxAQE1vogVEn/9UiLeP1D570AyJ43v5lRTa3+Q
 IepllEm0kzQ4lavq+vw3ghlsVh3JHhdXrMWUliMSL6OI9tBXvLasbBejdDIg1kA=
X-Received: by 2002:a5d:59ad:0:b0:391:39fb:59b4 with SMTP id
 ffacd0b85a97d-3997f903a71mr15996186f8f.27.1742926112282; 
 Tue, 25 Mar 2025 11:08:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERKytj53Q/YEPBw9wqib83+mHGlipYIoVnbYH0kKsY2skD+0gYj1H6QafhSdwmmoI7+APJpQ==
X-Received: by 2002:a5d:59ad:0:b0:391:39fb:59b4 with SMTP id
 ffacd0b85a97d-3997f903a71mr15996150f8f.27.1742926111762; 
 Tue, 25 Mar 2025 11:08:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a345fsm14186253f8f.24.2025.03.25.11.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 11:08:30 -0700 (PDT)
Message-ID: <4333965f-f5bc-412f-ae23-46544d7dc919@redhat.com>
Date: Tue, 25 Mar 2025 19:08:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 10/20] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-11-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-11-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Allocates a s1 HWPT for the Guest s1 stage and attaches that
> to the dev. This will be invoked in a subsequent patch when
> Guest issues SMMU_CMD_CFGI_STE.
CMD_CFGI_STE ...
or CMD_CFGI_STE_RANGE
>
> While at it, we are also exporting both smmu_find_ste() and
> smmuv3_flush_config() from smmuv3.c for use here.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c         | 111 ++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-internal.h      |  13 ++++
>  hw/arm/smmuv3.c               |   5 +-
>  hw/arm/trace-events           |   1 +
>  include/hw/arm/smmuv3-accel.h |   6 ++
>  5 files changed, 133 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 1c696649d5..d3a5cf9551 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -13,6 +13,8 @@
>  #include "hw/arm/smmuv3-accel.h"
>  #include "hw/pci/pci_bridge.h"
>  
> +#include "smmuv3-internal.h"
> +
>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
>                                                  PCIBus *bus, int devfn)
>  {
> @@ -32,6 +34,115 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
>      return accel_dev;
>  }
>  
> +static void
> +smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool abort)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
> +    uint32_t hwpt_id;
> +
> +    if (!s1_hwpt || !accel_dev->viommu) {
> +        return;
> +    }
> +
> +    if (abort) {
> +        hwpt_id = accel_dev->viommu->abort_hwpt_id;
> +    } else {
> +        hwpt_id = accel_dev->viommu->bypass_hwpt_id;
> +    }
> +
> +    host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, &error_abort);
> +    iommufd_backend_free_id(s1_hwpt->iommufd, s1_hwpt->hwpt_id);
> +    accel_dev->s1_hwpt = NULL;
> +    g_free(s1_hwpt);
> +}
> +
> +static int
> +smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
> +                                    uint32_t data_type, uint32_t data_len,
> +                                    void *data)
> +{
> +    SMMUViommu *viommu = accel_dev->viommu;
> +    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +
> +    if (!idev || !viommu) {
> +        return -ENOENT;
> +    }
> +
> +    if (s1_hwpt) {
> +        smmuv3_accel_dev_uninstall_nested_ste(accel_dev, false);
why do you choose abort = false?
> +    }
> +
> +    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
> +    if (!s1_hwpt) {
no need to test the result.

"
If any call to allocate memory using functions |g_new()|
<https://docs.gtk.org/glib/func.new.html>, |g_new0()|
<https://docs.gtk.org/glib/func.new0.html>, |g_renew()|
<https://docs.gtk.org/glib/func.renew.html>, |g_malloc()|
<https://docs.gtk.org/glib/func.malloc.html>, |g_malloc0()|
<https://docs.gtk.org/glib/func.malloc0.html>, |g_malloc0_n()|
<https://docs.gtk.org/glib/func.malloc0_n.html>, |g_realloc()|
<https://docs.gtk.org/glib/func.realloc.html> and |g_realloc_n()|
<https://docs.gtk.org/glib/func.realloc_n.html> fails, the application
is terminated. This also means that there is no need to check if the
call succeeded.
"

https://docs.gtk.org/glib/memory.html#title

> +        return -ENOMEM;
> +    }
> +
> +    s1_hwpt->iommufd = idev->iommufd;
> +    iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                               viommu->core.viommu_id, 0, data_type, data_len,
> +                               data, &s1_hwpt->hwpt_id, &error_abort);
> +    host_iommu_device_iommufd_attach_hwpt(idev, s1_hwpt->hwpt_id, &error_abort);
> +    accel_dev->s1_hwpt = s1_hwpt;
> +    return 0;
> +}
> +
> +void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
> +{
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
> +                           .inval_ste_allowed = true};
> +    struct iommu_hwpt_arm_smmuv3 nested_data = {};
> +    SMMUv3State *s = sdev->smmu;
> +    SMMUState *bs = &s->smmu_state;
> +    uint32_t config;
> +    STE ste;
> +    int ret;
> +
> +    if (!bs->accel) {
> +        return;
> +    }
> +
> +    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +    if (!accel_dev->viommu) {
> +        return;
> +    }
> +
> +    ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
> +    if (ret) {
> +        /*
> +         * For a 2-level Stream Table, the level-2 table might not be ready
> +         * until the device gets inserted to the stream table. Ignore this.
> +         */
I am confused by the above comment. Please can you describe the
circumstances when this happens and why this should be an error
> +        return;
> +    }
> +
> +    config = STE_CONFIG(&ste);
> +    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {
you fully bypass the logic of smmuv3_get_config/decode_config. Couldn't
you reuse it. Originally we used the s1ctxptr and disabled/bypassed info.
> +        smmuv3_accel_dev_uninstall_nested_ste(accel_dev, STE_CFG_ABORT(config));
> +        smmuv3_flush_config(sdev);
> +        return;
> +    }
> +
> +    nested_data.ste[0] = (uint64_t)ste.word[0] | (uint64_t)ste.word[1] << 32;
> +    nested_data.ste[1] = (uint64_t)ste.word[2] | (uint64_t)ste.word[3] << 32;
> +    /* V | CONFIG | S1FMT | S1CTXPTR | S1CDMAX */
> +    nested_data.ste[0] &= 0xf80fffffffffffffULL;
> +    /* S1DSS | S1CIR | S1COR | S1CSH | S1STALLD | EATS */
> +    nested_data.ste[1] &= 0x380000ffULL;
> +    ret = smmuv3_accel_dev_install_nested_ste(accel_dev,
> +                                              IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                              sizeof(nested_data),
> +                                              &nested_data);
> +    if (ret) {
> +        error_report("Unable to install nested STE=%16LX:%16LX, ret=%d",
> +                     nested_data.ste[1], nested_data.ste[0], ret);
also print the SID
> +    }
> +    trace_smmuv3_accel_install_nested_ste(sid, nested_data.ste[1],
> +                                          nested_data.ste[0]);
> +}
> +
>  static bool
>  smmuv3_accel_dev_attach_viommu(SMMUv3AccelDevice *accel_dev,
>                                 HostIOMMUDeviceIOMMUFD *idev, Error **errp)
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index b6b7399347..46c8bcae14 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -24,6 +24,8 @@
>  #include "hw/registerfields.h"
>  #include "hw/arm/smmu-common.h"
>  
> +#include CONFIG_DEVICES
> +
>  typedef enum SMMUTranslationStatus {
>      SMMU_TRANS_DISABLE,
>      SMMU_TRANS_ABORT,
> @@ -547,6 +549,17 @@ typedef struct CD {
>      uint32_t word[16];
>  } CD;
>  
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> +                  SMMUEventInfo *event);
> +void smmuv3_flush_config(SMMUDevice *sdev);
> +
> +#if defined(CONFIG_ARM_SMMUV3_ACCEL) && defined(CONFIG_IOMMUFD)
> +void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid);
> +#else
> +static inline void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
> +{
> +}
> +#endif
>  /* STE fields */
>  
>  #define STE_VALID(x)   extract32((x)->word[0], 0, 1)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index b49a59b64c..ea63731d61 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -628,8 +628,7 @@ bad_ste:
>   * Supports linear and 2-level stream table
>   * Return 0 on success, -EINVAL otherwise
>   */
> -static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> -                         SMMUEventInfo *event)
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
>  {
>      dma_addr_t addr, strtab_base;
>      uint32_t log2size;
> @@ -898,7 +897,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>      return cfg;
>  }
>  
> -static void smmuv3_flush_config(SMMUDevice *sdev)
> +void smmuv3_flush_config(SMMUDevice *sdev)
>  {
>      SMMUv3State *s = sdev->smmu;
>      SMMUState *bc = &s->smmu_state;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 17960794bf..cd2eac31c2 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -61,6 +61,7 @@ smmu_reset_exit(void) ""
>  #smmuv3-accel.c
>  smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
>  smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
> +smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t ste_0) "sid=%d ste=%"PRIx64":%"PRIx64
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
> diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
> index aca6838dca..d6b0b1ca30 100644
> --- a/include/hw/arm/smmuv3-accel.h
> +++ b/include/hw/arm/smmuv3-accel.h
> @@ -35,9 +35,15 @@ typedef struct SMMUViommu {
>      QLIST_ENTRY(SMMUViommu) next;
>  } SMMUViommu;
>  
> +typedef struct SMMUS1Hwpt {
> +    IOMMUFDBackend *iommufd;
> +    uint32_t hwpt_id;
> +} SMMUS1Hwpt;
> +
>  typedef struct SMMUv3AccelDevice {
>      SMMUDevice  sdev;
>      HostIOMMUDeviceIOMMUFD *idev;
> +    SMMUS1Hwpt  *s1_hwpt;
>      SMMUViommu *viommu;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
Thanks

Eric


