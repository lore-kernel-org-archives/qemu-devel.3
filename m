Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F9AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 15:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwl0D-0007A8-0W; Tue, 16 Apr 2024 11:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rwl0A-00077x-F1
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 11:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rwl08-0004jy-9u
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 11:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713282338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfcwtyepsIHaTuh6vym4Xo0wlmsk6hlXkxxmY1fgLBo=;
 b=cBpevChqYtlh2VSb95x1Q+SG0jmLZFraboB/ksKei95hfCnt+NceSEtvuCCtGBU3W9rorc
 D4V006UxBRwvv0KDA+4ByJ1YDOzjhHTR3SNr7Ngmqk/9BkZ4VVZ3qV1HoD54oByFA6v1Tg
 JA3RaIUut4e/j3y9GnVxizorhRFDRd0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-OEviaK-0NJC7_JKJlNRTZw-1; Tue, 16 Apr 2024 11:45:35 -0400
X-MC-Unique: OEviaK-0NJC7_JKJlNRTZw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343c86edeb7so2981186f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 08:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713282334; x=1713887134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HfcwtyepsIHaTuh6vym4Xo0wlmsk6hlXkxxmY1fgLBo=;
 b=VgNL1eXwgY5yabGAJTB8OiWYLOrqLfwqfaYMLr+YVS1Oe1bXzNETd5NFFEQhmAf9aI
 0VC3XoMYW9mYCDLk1xlBbsimRlOY5GdWi/6a6ygxc5xQ2e/NbgOnSNy9aifuOfq95w/H
 sGm6tN2ZQF7Nmpc0zLPQtATxsirZXxGIiyR6ntvKayqeuUj/CQ2K13jb4H52BgJNsnRu
 /ayNhS2/gLuI1rwT3S2AjXL+l3LlpACUdFdgP5DX/so+zLu83aXffwZ5mZ/ESz863Xx+
 IfKGnHwvT2ZO/YOGmscjf5LohSiPSMF1ZmKdm8qcFrjuN1aesJKct+uaohH/LJqclu81
 yVGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW30d8PXtA45m9NBvUvz29rWSgbwGh9ALt+OQDVeMZqxwj//ojBhcCRzdq+0BzWAZ539x26HkJHQ7p4V01JJJ4tMhwF2ws=
X-Gm-Message-State: AOJu0YwZyO9aD6kqdGIOCP79D5GvGYsr1R0nR7aDeVh6xRB2iA8tTRfS
 8XQohGqz3yGebWqmp632htbgBBlZPRUxdL7NMfZQWsSoD/a/XIx9FC6mtxT0/kYNp6CpELDey3P
 zpj85ITU80JT6/X4ODq8NFrsPlhDKkIoJDBLpvOQBr1w6UU1+gGw3
X-Received: by 2002:adf:f90d:0:b0:348:4519:15b8 with SMTP id
 b13-20020adff90d000000b00348451915b8mr1606943wrr.40.1713282334528; 
 Tue, 16 Apr 2024 08:45:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELztI1pGgiMUQC/0li9Nfrwed3KZ2gelKZLdr9peaZaeWkqmn4SgozwXXngkpeRQcXo/iQSw==
X-Received: by 2002:adf:f90d:0:b0:348:4519:15b8 with SMTP id
 b13-20020adff90d000000b00348451915b8mr1606926wrr.40.1713282334114; 
 Tue, 16 Apr 2024 08:45:34 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 s4-20020adfe004000000b00349a6af3da5sm131962wrh.51.2024.04.16.08.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 08:45:33 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:45:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>, Jason
 Wang <jasowang@redhat.com>, Huang Rui <Ray.Huang@amd.com>
Subject: Re: [RFC QEMU PATCH v9 2/2] virtio-pci: implement No_Soft_Reset bit
Message-ID: <20240416174531.6573af25@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240416070127.116922-3-Jiqian.Chen@amd.com>
References: <20240416070127.116922-1-Jiqian.Chen@amd.com>
 <20240416070127.116922-3-Jiqian.Chen@amd.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 16 Apr 2024 15:01:27 +0800
Jiqian Chen <Jiqian.Chen@amd.com> wrote:

> In current code, when guest does S3, virtio-gpu are reset due to the
> bit No_Soft_Reset is not set. After resetting, the display resources
> of virtio-gpu are destroyed, then the display can't come back and only
> show blank after resuming.

Just a high level question.
Typically when system goes into S3 all devices (modulo RAM) loose context
(aka powered off), and then it's upto device driver to recover whatever
was lost.
So why should we implement hw(qemu) workaround for a driver problem?

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
> index a1b61308e7a0..82fa4defe5cd 100644
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
>  static void virtio_pci_bus_reset_hold(Object *obj)
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
> +     * for safety, set this false by default, if change it to true,
> +     * need to consider compatible for old machine
> +     */
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


