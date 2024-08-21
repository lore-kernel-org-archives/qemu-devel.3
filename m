Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21202C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 10:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgij5-0007Kx-7H; Wed, 21 Aug 2024 06:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1sgij2-0007Ik-KO; Wed, 21 Aug 2024 06:38:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1sgij0-0007Wm-9b; Wed, 21 Aug 2024 06:38:00 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-201e52ca0caso49048495ad.3; 
 Wed, 21 Aug 2024 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724236676; x=1724841476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=px/pXCwhVdp2NbvOVohqvlSUvPtuBUcZ1ZEKYCcfzS8=;
 b=YLgS2vpdVNthV/UzcxRTAGo27zPTGptrYXEy5rF5N9w2FBU3kflp6PBQthJLCwbJS+
 mHNwKBOXoFVcUt9ORmTZ6Hr4d3MeZvzcdhSnYB4JF8H6TixrwVLT4C+AUyN62/BDLypL
 Oi2ZYWaBDaBssYWb2G9Vq3Aq1ExX5c5U5XOMwOIRpC6GCd6BznqNS794xajdB6F9+9Cs
 C76vjylpRAtdf3O5yEBAU5bHaUux91UVsl11xBOj21q0av8cn9rlItjE3Ya4zKKH02uw
 rnl1xXPoC4Tuz36jn8WobmsQ/huc+mDticpfqGKBz/jzWQkQEgUsrat89EJwOj39fLaQ
 rVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724236676; x=1724841476;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=px/pXCwhVdp2NbvOVohqvlSUvPtuBUcZ1ZEKYCcfzS8=;
 b=IVMEkZ6Je05ey579xodr5yiqGp6piSnKUZFAdznR6uuUR1bt6CWmOyrmtiM6P9hF1g
 RcilfCx6kwD3GEeuo7wbeP4J0yjap41VJAg1FiZmIA5jxF0cWBnMUMSWX8od2YFi68Pu
 xnINI7s53YspoBNkJxpByY97xrFCCQs1vfHqjVAvpk13IrleI7DEVwRs41UJKIG7QGdH
 gm3TdLuwy5IdM9leQdFyrmToM8d6X9suKBJPjEWMd+XKTrH7AZV1iZM3ImyKcuJtAz27
 q95ohpOEbaQ0J+zgUq8nsH3m5mQavsLRMGx6WKDUDLQLoO0TlRL7gFYlC5qRti1Pfvet
 3cYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8+PviAKbKJhOVRmmzKI07dQHp431n/k21TFsNeMUBY3jmSYlVVmX1QxQIB7cKkpuYynUFh1f/tzus@nongnu.org
X-Gm-Message-State: AOJu0YzkGXZYVMnTljG0quoajGC0xN9E1to6dp1OgqtGmwXV6G01jfFq
 wKdK12HxTvb13YBkUEgj8wGs4HwJkPPnHRRz0wxd3gUQaJAScQSh
X-Google-Smtp-Source: AGHT+IH8myHEKIkXaRLwuV9scyJIQRZhhFIHC4ZgZvCCYEN1s2XCq+1azMU4bTUh1U6K+6yLN08YYA==
X-Received: by 2002:a17:902:c401:b0:202:174c:b2b5 with SMTP id
 d9443c01a7336-20367d3f246mr26451595ad.3.1724236676276; 
 Wed, 21 Aug 2024 03:37:56 -0700 (PDT)
Received: from [172.20.149.24] ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03030a3sm91291815ad.18.2024.08.21.03.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 03:37:55 -0700 (PDT)
Message-ID: <0c1fedc6-1666-40fd-af62-4ab8b33b1a51@gmail.com>
Date: Wed, 21 Aug 2024 19:37:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v14 08/11] pcie_sriov: Remove num_vfs from
 PCIESriovPF
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com>
 <20240813-reuse-v14-8-4c15bc6ee0e6@daynix.com>
Content-Language: en-US
From: Yui Washizu <yui.washidu@gmail.com>
In-Reply-To: <20240813-reuse-v14-8-4c15bc6ee0e6@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=yui.washidu@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 2024/08/13 15:14, Akihiko Odaki wrote:
> num_vfs is not migrated so use PCI_SRIOV_CTRL_VFE and PCI_SRIOV_NUM_VF
> instead.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/hw/pci/pcie_sriov.h |  1 -
>   hw/pci/pcie_sriov.c         | 38 +++++++++++++++++++++++++++-----------
>   hw/pci/trace-events         |  2 +-
>   3 files changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
> index 70649236c18a..5148c5b77dd1 100644
> --- a/include/hw/pci/pcie_sriov.h
> +++ b/include/hw/pci/pcie_sriov.h
> @@ -16,7 +16,6 @@
>   #include "hw/pci/pci.h"
>   
>   typedef struct PCIESriovPF {
> -    uint16_t num_vfs;   /* Number of virtual functions created */
>       uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
>       PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
>   } PCIESriovPF;
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index ac8c4013bc88..91e817617238 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -45,7 +45,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>       pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
>                           offset, PCI_EXT_CAP_SRIOV_SIZEOF);
>       dev->exp.sriov_cap = offset;
> -    dev->exp.sriov_pf.num_vfs = 0;
>       dev->exp.sriov_pf.vf = NULL;
>   
>       pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
> @@ -182,29 +181,28 @@ static void register_vfs(PCIDevice *dev)
>   
>       assert(sriov_cap > 0);
>       num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
> -    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
> -        return;
> -    }
>   
>       trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
>                                PCI_FUNC(dev->devfn), num_vfs);
>       for (i = 0; i < num_vfs; i++) {
>           pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
>       }
> -    dev->exp.sriov_pf.num_vfs = num_vfs;
> +
> +    pci_set_word(dev->wmask + sriov_cap + PCI_SRIOV_NUM_VF, 0);
>   }
>   
>   static void unregister_vfs(PCIDevice *dev)
>   {
> -    uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
> +    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
>       uint16_t i;
>   
>       trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
> -                               PCI_FUNC(dev->devfn), num_vfs);
> -    for (i = 0; i < num_vfs; i++) {
> +                               PCI_FUNC(dev->devfn));
> +    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
>           pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
>       }
> -    dev->exp.sriov_pf.num_vfs = 0;
> +
> +    pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0xffff);
>   }
>   
>   void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
> @@ -230,6 +228,17 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
>           } else {
>               unregister_vfs(dev);
>           }
> +    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
> +        uint8_t *cfg = dev->config + sriov_cap;
> +        uint8_t *wmask = dev->wmask + sriov_cap;
> +        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
> +        uint16_t val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;


"val" is already used as the name of an argument
in the "pcie_sriov_config_write" function.
When I tried to build QEMU after applying this patch series,
the following error ocurred:
../hw/pci/pcie_sriov.c:422:18: Error: declaration of ‘val’ shadows a 
parameter


> +
> +        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
> +            val |= PCI_SRIOV_CTRL_VFE;
> +        }
> +
> +        pci_set_word(wmask + PCI_SRIOV_CTRL, val);
>       }
>   }
>   
> @@ -246,6 +255,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
>       unregister_vfs(dev);
>   
>       pci_set_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF, 0);
> +    pci_set_word(dev->wmask + sriov_cap + PCI_SRIOV_CTRL,
> +                 PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI);
>   
>       /*
>        * Default is to use 4K pages, software can modify it
> @@ -292,7 +303,7 @@ PCIDevice *pcie_sriov_get_pf(PCIDevice *dev)
>   PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
>   {
>       assert(!pci_is_vf(dev));
> -    if (n < dev->exp.sriov_pf.num_vfs) {
> +    if (n < pcie_sriov_num_vfs(dev)) {
>           return dev->exp.sriov_pf.vf[n];
>       }
>       return NULL;
> @@ -300,5 +311,10 @@ PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
>   
>   uint16_t pcie_sriov_num_vfs(PCIDevice *dev)
>   {
> -    return dev->exp.sriov_pf.num_vfs;
> +    uint16_t sriov_cap = dev->exp.sriov_cap;
> +    uint8_t *cfg = dev->config + sriov_cap;
> +
> +    return sriov_cap &&
> +           (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) ?
> +           pci_get_word(cfg + PCI_SRIOV_NUM_VF) : 0;
>   }
> diff --git a/hw/pci/trace-events b/hw/pci/trace-events
> index 19643aa8c6b0..e98f575a9d19 100644
> --- a/hw/pci/trace-events
> +++ b/hw/pci/trace-events
> @@ -14,7 +14,7 @@ msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d mask
>   
>   # hw/pci/pcie_sriov.c
>   sriov_register_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: creating %d vf devs"
> -sriov_unregister_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: Unregistering %d vf devs"
> +sriov_unregister_vfs(const char *name, int slot, int function) "%s %02x:%x: Unregistering vf devs"
>   sriov_config_write(const char *name, int slot, int fun, uint32_t offset, uint32_t val, uint32_t len) "%s %02x:%x: sriov offset 0x%x val 0x%x len %d"
>   
>   # pcie.c
>

