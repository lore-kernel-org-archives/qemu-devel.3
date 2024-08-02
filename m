Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B828C52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 12:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZrrZ-0000dm-GK; Fri, 02 Aug 2024 08:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZrrY-0000aM-0P
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 08:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZrrV-0003Jx-Qk
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 08:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722603503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtGXJbBx3GqDGvsxCP5jmAZa7OEsPI8M70kMvBw1uK8=;
 b=TKOrPhgzrOTguIpKrigW3CNPno/oAI+oQzNpjbtOfXtx7a9bwbvGQf6N1qA+pEUAZhRQyt
 uRljuUYBlT93g7Xxcf1DJRQROysWryJZueQQLUE7U2cyuxIsSbe/BMVygCNnSW7SRM1cfZ
 ih06nsoAfrRXgD3gKLSfXTM7eNeFMM4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-6NL8ImGPO7admCIuVRPz4g-1; Fri, 02 Aug 2024 08:58:17 -0400
X-MC-Unique: 6NL8ImGPO7admCIuVRPz4g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36848f30d39so3850871f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 05:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722603496; x=1723208296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtGXJbBx3GqDGvsxCP5jmAZa7OEsPI8M70kMvBw1uK8=;
 b=fOKJ4AMJQw2Zr8DanEdfwrFyOPv32sOiFTS8cGB0X/UWGFL0cf3NMdO4QXuDNYXJXK
 Xx/iy0T0t88bf/ELo/N/ENHy0IFVmiHfwn38XAIGt9FqxE2vqxejArw56xLYVLEmfkB/
 pn7fUZW9xKkr/DeXBiVQ/zpVQgR780fJZfx6Jd30hnPBiPH2g8kubG3tmEXN/y2RQiHA
 YwuFEI9N1wodbaD74ehUTzCiYfpXu/5tVFmXaSfv9Xe8QW7QLnIUfHB31g3Lfz4zGpge
 QFAH08oq+nbkC9ciTZvKcQHw8bdmRcevLadOsJrj1eYNibcWm1MUR4kOsxC6MlSeJeeP
 0tEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2XOY9U3dtKLxa/Wj2I7EuqLY5njJs/uJWgzWOUQwd+TfH6ABA21YMxOETgoe0WsXKgXPTSLPeAOOfJ8AsY0xIpOLGD8o=
X-Gm-Message-State: AOJu0YyIW9pygElWhfXEajY/j309bEhzqOmyOOVTtJfmaG2l0ckIGG6e
 QnnjDTsaU+p/hzlHaHr2D28CkufYOKnTtfD2lwcR7LLMWltbIDPV+mrMiCGVMasIDIeWV765ERM
 s09+/7BUcSRAEzQXPvctyByDLSc/+x6m/EynECaSWXvmXMPgCjIh7
X-Received: by 2002:a5d:5912:0:b0:368:8007:e26c with SMTP id
 ffacd0b85a97d-36bbc10c125mr2202441f8f.29.1722603496004; 
 Fri, 02 Aug 2024 05:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjhNvenGIDXsVYhMzL3OK8ufxkADIKEpH49xjJVhZZ0nDFam9fnzHcXKdJ4Ff9CAMOqOYzBg==
X-Received: by 2002:a5d:5912:0:b0:368:8007:e26c with SMTP id
 ffacd0b85a97d-36bbc10c125mr2202405f8f.29.1722603495088; 
 Fri, 02 Aug 2024 05:58:15 -0700 (PDT)
Received: from redhat.com ([2.55.39.123]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0261c2sm1911716f8f.57.2024.08.02.05.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 05:58:13 -0700 (PDT)
Date: Fri, 2 Aug 2024 08:58:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH for-9.2 v11 08/11] pcie_sriov: Remove num_vfs from
 PCIESriovPF
Message-ID: <20240802083911-mutt-send-email-mst@kernel.org>
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
 <20240802-reuse-v11-8-fb83bb8c19fb@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-reuse-v11-8-fb83bb8c19fb@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Aug 02, 2024 at 02:17:58PM +0900, Akihiko Odaki wrote:
> num_vfs is not migrated so use PCI_SRIOV_CTRL_VFE and PCI_SRIOV_NUM_VF
> instead.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/pci/pcie_sriov.h |  1 -
>  hw/pci/pcie_sriov.c         | 28 ++++++++++++++++++++--------
>  hw/pci/trace-events         |  2 +-
>  3 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
> index 70649236c18a..5148c5b77dd1 100644
> --- a/include/hw/pci/pcie_sriov.h
> +++ b/include/hw/pci/pcie_sriov.h
> @@ -16,7 +16,6 @@
>  #include "hw/pci/pci.h"
>  
>  typedef struct PCIESriovPF {
> -    uint16_t num_vfs;   /* Number of virtual functions created */
>      uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
>      PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
>  } PCIESriovPF;
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index 9bd7f8acc3f4..fae6acea4acb 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -57,7 +57,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>      pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
>                          offset, PCI_EXT_CAP_SRIOV_SIZEOF);
>      dev->exp.sriov_cap = offset;
> -    dev->exp.sriov_pf.num_vfs = 0;
>      dev->exp.sriov_pf.vf = NULL;
>  
>      pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
> @@ -186,6 +185,12 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
>      }
>  }
>  
> +static void clear_ctrl_vfe(PCIDevice *dev)
> +{
> +    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;

space here, after definition

> +    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
> +}
> +

Pls use pci_word_test_and_clear_mask


>  static void register_vfs(PCIDevice *dev)
>  {
>      uint16_t num_vfs;
> @@ -195,6 +200,7 @@ static void register_vfs(PCIDevice *dev)
>      assert(sriov_cap > 0);
>      num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>      if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
> +        clear_ctrl_vfe(dev);
>          return;
>      }
>  
> @@ -203,20 +209,18 @@ static void register_vfs(PCIDevice *dev)
>      for (i = 0; i < num_vfs; i++) {
>          pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
>      }
> -    dev->exp.sriov_pf.num_vfs = num_vfs;
>  }
>  
>  static void unregister_vfs(PCIDevice *dev)
>  {
> -    uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
>      uint16_t i;
> +    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
>  
>      trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
> -                               PCI_FUNC(dev->devfn), num_vfs);
> -    for (i = 0; i < num_vfs; i++) {
> +                               PCI_FUNC(dev->devfn));
> +    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {

Why PCI_SRIOV_TOTAL_VF not PCI_SRIOV_NUM_VF/pcie_sriov_num_vfs?


>          pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
>      }
> -    dev->exp.sriov_pf.num_vfs = 0;
>  }
>  
>  void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
> @@ -242,6 +246,9 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
>          } else {
>              unregister_vfs(dev);
>          }
> +    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
> +        clear_ctrl_vfe(dev);
> +        unregister_vfs(dev);

So any write into PCI_SRIOV_NUM_VF automatically clears VFE?

Yes writing into PCI_SRIOV_NUM_VF should not happen when VFE
is set, but spec does not say we need to clear it automatically.
Why come up with random rules? just don't special case it,
whatever happens, let it happen.

And what does this change have to do with getting rid of
num_vfs?

>      }
>  }
>  
> @@ -304,7 +311,7 @@ PCIDevice *pcie_sriov_get_pf(PCIDevice *dev)
>  PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
>  {
>      assert(!pci_is_vf(dev));
> -    if (n < dev->exp.sriov_pf.num_vfs) {
> +    if (n < pcie_sriov_num_vfs(dev)) {
>          return dev->exp.sriov_pf.vf[n];
>      }
>      return NULL;
> @@ -312,5 +319,10 @@ PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
>  
>  uint16_t pcie_sriov_num_vfs(PCIDevice *dev)
>  {
> -    return dev->exp.sriov_pf.num_vfs;
> +    uint16_t sriov_cap = dev->exp.sriov_cap;
> +    uint8_t *cfg = dev->config + sriov_cap;
> +
> +    return sriov_cap &&
> +           (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) ?
> +           pci_get_word(cfg + PCI_SRIOV_NUM_VF) : 0;
>  }
> diff --git a/hw/pci/trace-events b/hw/pci/trace-events
> index 19643aa8c6b0..e98f575a9d19 100644
> --- a/hw/pci/trace-events
> +++ b/hw/pci/trace-events
> @@ -14,7 +14,7 @@ msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d mask
>  
>  # hw/pci/pcie_sriov.c
>  sriov_register_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: creating %d vf devs"
> -sriov_unregister_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: Unregistering %d vf devs"
> +sriov_unregister_vfs(const char *name, int slot, int function) "%s %02x:%x: Unregistering vf devs"
>  sriov_config_write(const char *name, int slot, int fun, uint32_t offset, uint32_t val, uint32_t len) "%s %02x:%x: sriov offset 0x%x val 0x%x len %d"
>  
>  # pcie.c
> 
> -- 
> 2.45.2


