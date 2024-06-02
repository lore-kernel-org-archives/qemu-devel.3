Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56468C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 02:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDxsk-0001Ar-AT; Sun, 02 Jun 2024 22:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDxsi-0000uk-Pl
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 22:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDmGm-00088l-VH
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 10:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717338791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/CObo0s+s8jPacHzhwSX97NHLRv4gDKKHQbdv15AlTw=;
 b=SMExOWGaxia3RziwrVxf19KE4bmRU202vGBJJhU7y+3AygRZ0JQKUfAQyWDlqmNl1x81Mz
 2AfzUv2z5QlhTC+RbIQIKByd1NQsyqlDD7olFhbjuM+3f50N/6pnIBoAt6b6H9hImTxeXZ
 vJzyzn6H9/+oTMsBZw8NoaqqvKZ32jA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-nla_UGe2PeaGQYH_TjQyuw-1; Sun, 02 Jun 2024 10:33:06 -0400
X-MC-Unique: nla_UGe2PeaGQYH_TjQyuw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42135f60020so6457765e9.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 07:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717338785; x=1717943585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CObo0s+s8jPacHzhwSX97NHLRv4gDKKHQbdv15AlTw=;
 b=dB/gORokDZEWljmK0uFVlbEFmDIap9JqYtk/k66SeIUYMzfb1syDy233qiN97SfMyn
 M//ApBMnnFfTK2Hcx/s12PEnn82lBLvi+WqacTC1tUh4BWt8rUgQ/3Q/azkee3lty2j+
 km+qbt0+H9cR+E+/A7jey9ai/PdRaOJJXHeBzc9UOZrfU3rEllZFGaTt1Byz/HFdjdWa
 x+ovvv+1xpQe4AF0pQ2bKe52MNllAatW6P1MxxLzyxGwTXglguZtLeg1VFboSOZ9naeQ
 2BASIUK7kOB+OHEIYCRQK/ZquVhvp0Dc5dOiMfQMuOgdFsFm002kBYOSzfcaqJqGyL0T
 q1Jw==
X-Gm-Message-State: AOJu0YwSmdhXiCioTxTtBcJuN7FbyUu8uVe0PSWCIs38Vj/ecDe3pcI1
 /7Lp+k5H/5wSVw+/oJhHFQE0E0Y7yYurnaqXEvh2a/w65zM+ul7DGlwkHWa9osm0jkPrRS8TXyZ
 9rVjATIuZIgiQ7ynsn/+04fpJqJxrbdP/v0fj8jfehnlJPSjKrUP5
X-Received: by 2002:a05:600c:4f46:b0:418:4841:162a with SMTP id
 5b1f17b1804b1-4212e05dd18mr48911785e9.15.1717338785484; 
 Sun, 02 Jun 2024 07:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbVReYqVcdosY3060HuGxF2/ym1wbxiPycSXwoxpxCslVqIIO4LlxpNYOV+f+QTe89T4y+tg==
X-Received: by 2002:a05:600c:4f46:b0:418:4841:162a with SMTP id
 5b1f17b1804b1-4212e05dd18mr48911705e9.15.1717338784965; 
 Sun, 02 Jun 2024 07:33:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212eb6ddf6sm76773505e9.45.2024.06.02.07.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 07:33:04 -0700 (PDT)
Date: Sun, 2 Jun 2024 10:33:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: qemu-devel@nongnu.org, Huang Rui <Ray.Huang@amd.com>
Subject: Re: [PATCH v10 2/2] virtio-pci: implement No_Soft_Reset bit
Message-ID: <20240602103033-mutt-send-email-mst@kernel.org>
References: <20240515073526.17297-1-Jiqian.Chen@amd.com>
 <20240515073526.17297-3-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515073526.17297-3-Jiqian.Chen@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 15, 2024 at 03:35:26PM +0800, Jiqian Chen wrote:
> In current code, when guest does S3, virtio-gpu are reset due to the
> bit No_Soft_Reset is not set. After resetting, the display resources
> of virtio-gpu are destroyed, then the display can't come back and only
> show blank after resuming.
> 
> Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can check
> this bit, if this bit is set, the devices resetting will not be done, and
> then the display can work after resuming.
> 
> No_Soft_Reset bit is implemented for all virtio devices, and was tested
> only on virtio-gpu device. Set it false by default for safety.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  hw/virtio/virtio-pci.c         | 37 ++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-pci.h |  5 +++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1b63bcb3f15c..3052528c0730 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2230,6 +2230,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>              pcie_cap_lnkctl_init(pci_dev);
>          }
>  
> +        if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
> +            pci_set_word(pci_dev->config + pos + PCI_PM_CTRL,
> +                         PCI_PM_CTRL_NO_SOFT_RESET);
> +        }
> +
>          if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
>              /* Init Power Management Control Register */
>              pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
> @@ -2292,11 +2297,37 @@ static void virtio_pci_reset(DeviceState *qdev)
>      }
>  }
>  
> +static bool virtio_pci_no_soft_reset(PCIDevice *dev)
> +{
> +    uint16_t pmcsr;
> +
> +    if (!pci_is_express(dev) || !dev->exp.pm_cap) {
> +        return false;
> +    }
> +
> +    pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
> +
> +    /*
> +     * When No_Soft_Reset bit is set and the device
> +     * is in D3hot state, don't reset device
> +     */
> +    return (pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
> +           (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3;
> +}
> +
>  static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
>  {
>      PCIDevice *dev = PCI_DEVICE(obj);
>      DeviceState *qdev = DEVICE(obj);
>  
> +    /*
> +     * Note that: a proposal to add SUSPEND bit is being discussed,
> +     * may need to consider the state of SUSPEND bit in future
> +     */
> +    if (virtio_pci_no_soft_reset(dev)) {
> +        return;
> +    }
> +
>      virtio_pci_reset(qdev);
>  
>      if (pci_is_express(dev)) {
> @@ -2336,6 +2367,12 @@ static Property virtio_pci_properties[] = {
>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> +    /*
> +     * For safety, set this false by default, if change it to true,
> +     * need to consider compatible for old machine
> +     */

I think you should do exactly that, and make the name start with
"x-". It's not reasonable to tell users "set it to true, conduct your own QE 
testing". Neither do we want to double the amount of QE work with
each bugfix.

If for some reason you want this true only for the gpu, you can do that too.


> +    DEFINE_PROP_BIT("pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index 59d88018c16a..9e67ba38c748 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -43,6 +43,7 @@ enum {
>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
>      VIRTIO_PCI_FLAG_AER_BIT,
>      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> +    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT,
>  };
>  
>  /* Need to activate work-arounds for buggy guests at vmstate load. */
> @@ -79,6 +80,10 @@ enum {
>  /* Init Power Management */
>  #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
>  
> +/* Init The No_Soft_Reset bit of Power Management */
> +#define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
> +  (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
> +
>  /* Init Function Level Reset capability */
>  #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
>  
> -- 
> 2.34.1


