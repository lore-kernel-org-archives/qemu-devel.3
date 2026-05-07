Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CF6CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1mu-0002UB-Pu; Thu, 07 May 2026 12:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wL1mm-0002RT-1i
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wL1mk-000888-2G
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778172073;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iOlKtit/qozPXQ5+RoX+OUd/AE5V5PEzirN4+4PP5lA=;
 b=QBuqa9FRTe+8rzSPeK7MVcpe91Rxbk5tA1bL81ZFrew1rcZczlyzZop+DaJAmcPgp6ilfi
 5UFqu+0O6bZpRDpi4/6WXTfChFE06SihXf4+Ebfv7l6yhAbqDuefaZdpxK9erspSoBVgXb
 Eem587Z9PLP7iniaDObjfywxiS/9s2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-xJHI0AHQN4ykoO1qZCQbLA-1; Thu, 07 May 2026 12:41:02 -0400
X-MC-Unique: xJHI0AHQN4ykoO1qZCQbLA-1
X-Mimecast-MFC-AGG-ID: xJHI0AHQN4ykoO1qZCQbLA_1778172061
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48d0889c1ecso7593065e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778172061; x=1778776861;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOlKtit/qozPXQ5+RoX+OUd/AE5V5PEzirN4+4PP5lA=;
 b=CFA2peiK1DQFiKY2XkrvfB40UilutVbNHTAtd3vZOki5LdsKg7eY6B8f+Xsza55obi
 16rL1qLTTUTo5qJaueVCFtBgyHFhZOf/sgDefrm27UjYIOSsMBoM45CFizlFt6I79HM9
 JqI5L8kK6ZvQcUJCtm152gJPoI480geQ1IHlsqQlJA+aiF+E7D5OSPYu1+KtDFKF5mRM
 bu4N0veyWfkiH40BfUMT2kG3mqyso4IhGa1uM6S0rXN/PeCOVn8qFof4ladauBXIIgzF
 h+WKFUZ4kJUQfpcgYoMsml7O61yW8pJ0rdN4co4sYHaxLNK6t4ZHHBdwZFqY17+WMwgw
 MyvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ++J8iaYihhZeGaFBlTNde7p1NipF0BeeFHe72CspId2tc0Y/HODrOPA/5o+bwo396JirWSWkk3WJrO@nongnu.org
X-Gm-Message-State: AOJu0YzZ90eoYHNBTh8yMlVVMLJ/uWwjNsDcvXbKg1XlNLBUD7BBQZqf
 /t4QbVXI3j1bvm2QP2SH8AuckYZY6CQixNNbBCa5hwrn3bNuG2jwPjQXH0+AaBUg8XoquzMLag7
 5tqg5Z7VUB2E/+e3C6ecTz+Omnz9RZD0SkiCxN54pwSMOf5A53rdYAtMo
X-Gm-Gg: AeBDievkYoVeldC75uj1U0ONHFC6PhDpD68Dvqv1nTfA5+ZUbnjNMujEkn2wK7SND0n
 owT4DVtrGsi3c5cnxhiApnxEZt8P68M+YaBvTjE88/NRMhvod+NmBZ12GdHxr4LI4yT+3R0rFWo
 4EkPg6jskrTlKGKuGMwhH7ta6odfjQvnTDY3DfRAbSvi2eKGj01/eK0zkdQbDjFepY0tZ4ODxsi
 3rEF0/+GSdDLp5mgpo0U2seNtxgPqcwJ01GvdDIpv0jgzsz30rZZcgKlbTN0EGoUf4JEgvfgngC
 I2LSTOh41AoQ+iAhTFDv7BxITUbyNci67jWQE/Gy8fCoij5Y00eC93q4VM3OdNZ2D6JpV5bIMoD
 1K9DlNb4KrhiVAjUPL6UWnT+V/2XuYB5/Xpwcy2D740QLUy0QDTKJxE4sEde4OGOB/Xf0xg==
X-Received: by 2002:a05:600c:b8a:b0:48a:56de:d620 with SMTP id
 5b1f17b1804b1-48e51f32ac3mr145742575e9.14.1778172061129; 
 Thu, 07 May 2026 09:41:01 -0700 (PDT)
X-Received: by 2002:a05:600c:b8a:b0:48a:56de:d620 with SMTP id
 5b1f17b1804b1-48e51f32ac3mr145742135e9.14.1778172060638; 
 Thu, 07 May 2026 09:41:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e642e5805sm173905e9.7.2026.05.07.09.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 09:41:00 -0700 (PDT)
Message-ID: <188a2717-2f2f-486c-a559-a3dd3bba5ebc@redhat.com>
Date: Thu, 7 May 2026 18:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/31] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-25-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-25-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Shameer,

On 4/15/26 12:55 PM, Shameer Kolothum wrote:
> Install an event handler on the CMDQV vEVENTQ fd to read and propagate
> host received CMDQV errors to the guest.
>
> The handler runs in QEMU’s main loop, using a non-blocking fd registered
> via qemu_set_fd_handler().
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 55 +++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events     |  1 +
>  2 files changed, 56 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index bf989dd51f..9c2fc02b92 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -11,6 +11,7 @@
>  #include "qemu/log.h"
>  
>  #include "hw/arm/smmuv3.h"
> +#include "hw/core/irq.h"
>  #include "smmuv3-accel.h"
>  #include "tegra241-cmdqv.h"
>  #include "trace.h"
> @@ -534,6 +535,43 @@ out:
>      trace_tegra241_cmdqv_write_mmio(offset, value, size);
>  }
>  
> +static void tegra241_cmdqv_event_read(void *opaque)
> +{
> +    Tegra241CMDQV *cmdqv = opaque;
> +    IOMMUFDVeventq *veventq = cmdqv->veventq;
> +    struct {
> +        struct iommufd_vevent_header hdr;
> +        struct iommu_vevent_tegra241_cmdqv vevent;
> +    } buf;
> +    Error *local_err = NULL;
> +
> +    if (!smmuv3_accel_event_read_validate(veventq,
> +                                          IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
> +                                          &buf, sizeof(buf), &local_err)) {
> +        warn_report_err_once(local_err);
> +        return;
> +    }
> +
> +    if (buf.vevent.lvcmdq_err_map[0] || buf.vevent.lvcmdq_err_map[1]) {
> +        cmdqv->vintf_cmdq_err_map[0] =
> +            buf.vevent.lvcmdq_err_map[0] & 0xffffffff;
can't you use extract64() here and below?
> +        cmdqv->vintf_cmdq_err_map[1] =
> +            (buf.vevent.lvcmdq_err_map[0] >> 32) & 0xffffffff;
> +        cmdqv->vintf_cmdq_err_map[2] =
> +            buf.vevent.lvcmdq_err_map[1] & 0xffffffff;
> +        cmdqv->vintf_cmdq_err_map[3] =
> +            (buf.vevent.lvcmdq_err_map[1] >> 32) & 0xffffffff;
> +        for (int i = 0; i < 4; i++) {
> +            cmdqv->cmdq_err_map[i] = cmdqv->vintf_cmdq_err_map[i];
if the cached regs are same to we need to have both?
> +        }
> +        cmdqv->vi_err_map[0] |= 0x1;
> +        qemu_irq_pulse(cmdqv->irq);
> +        trace_tegra241_cmdqv_err_map(
> +            cmdqv->vintf_cmdq_err_map[3], cmdqv->vintf_cmdq_err_map[2],
> +            cmdqv->vintf_cmdq_err_map[1], cmdqv->vintf_cmdq_err_map[0]);
> +    }
> +}
> +
>  static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
>  {
>      SMMUv3AccelState *accel = s->s_accel;
> @@ -545,6 +583,7 @@ static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
>          return;
>      }
>      if (veventq) {
> +        qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
>          close(veventq->veventq_fd);
>          iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
>          g_free(veventq);
> @@ -560,6 +599,7 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>      Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
>      uint32_t viommu_id, veventq_id, veventq_fd;
>      IOMMUFDVeventq *veventq;
> +    int flags;
>  
>      if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
>                                        IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> @@ -577,14 +617,29 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>          goto free_viommu;
>      }
>  
> +    flags = fcntl(veventq_fd, F_GETFL);
> +    if (flags < 0) {
> +        error_setg(errp, "Failed to get flags for vEVENTQ fd");
> +        goto free_veventq;
> +    }
> +    if (fcntl(veventq_fd, F_SETFL, O_NONBLOCK | flags) < 0) {
> +        error_setg(errp, "Failed to set O_NONBLOCK on vEVENTQ fd");
> +        goto free_veventq;
> +    }
> +
>      veventq = g_new(IOMMUFDVeventq, 1);
>      veventq->veventq_id = veventq_id;
>      veventq->veventq_fd = veventq_fd;
>      cmdqv->veventq = veventq;
>  
> +    /* Set up event handler for veventq fd */
> +    qemu_set_fd_handler(veventq_fd, tegra241_cmdqv_event_read, NULL, cmdqv);
>      *out_viommu_id = viommu_id;
>      return true;
>  
> +free_veventq:
> +    close(veventq_fd);
> +    iommufd_backend_free_id(idev->iommufd, veventq_id);
>  free_viommu:
>      iommufd_backend_free_id(idev->iommufd, viommu_id);
>      return false;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 8c61d66a26..fd6441bfa7 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -75,6 +75,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
>  # tegra241-cmdqv
>  tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
>  tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
> +tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
Eric


