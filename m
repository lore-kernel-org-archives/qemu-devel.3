Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEF1C25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVaZ-000892-1N; Mon, 27 May 2024 04:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sBVYk-0007cz-J9
 for qemu-devel@nongnu.org; Mon, 27 May 2024 04:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sBVYi-0000FB-Jk
 for qemu-devel@nongnu.org; Mon, 27 May 2024 04:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716797899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9yqg/r/Ckc/rXqyQUWGDMI2hHKNOJqwoxhEv+pi0gw=;
 b=AmluKoIR7YjphCNvzpJ5hjpzqMkCHdnTnwrHQza9U3c4NDoJosfZr22+JjZlPhyKq8xayv
 I7v+qYSuJqqa+Awd6BPoYhVRZd6/eNpxE5Uw/FkQ487KY2xJ3N+UnRjdshyfAZaGXUaiwi
 44Z6yXahyhW5Mz05dKKph/v7+rJMTvw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-SPGv0-7KNaWRAbSpv7z-Wg-1; Mon, 27 May 2024 04:18:17 -0400
X-MC-Unique: SPGv0-7KNaWRAbSpv7z-Wg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-420fc4241ccso15756445e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 01:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716797896; x=1717402696;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/9yqg/r/Ckc/rXqyQUWGDMI2hHKNOJqwoxhEv+pi0gw=;
 b=QvNYCKk4/kIXk6WEG64kwVIlQY7X+iwDY1yqMnYf8c+Ud4CHuUJkxzsDifssUf6ZA9
 NCjY4NC+e1JRyy9IGQteknKFGd7wdESdPz09/8MUsMLz6bmcVcHBFOZQfXR6jAJt/uKA
 2vnqp2l8DerDe3ri1I2dwviGDsrfvTu7T3lLAAhPrSumCL+XqTB20LLRIlQxdD64cfqU
 Ne+i9MbHAWz/XPlLWVPnIE2XSov8WOreTZxurqW02nJfPx3ycIFJlCzkvV6wCTabXxlq
 umaJpjN3UGLGx2smIifwV/KPCKRU+R2j5hibnS6M488AUziBTVVQHTTCxNJmAJFL4iLB
 b+RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcP95iFGw0VfWLOjfbsGlNR0vwwxhuwHw2BKwMzvAwb6ldS4uCVSpDEPbSgYx4nyUBmcgY+hk4DYqN71OBGJpWArstCTU=
X-Gm-Message-State: AOJu0YzwtWPTWQfy1b3G4I+LTpLbD6+WcLPaiG314460bgiv0PczEUGG
 NcZoIaMJhEhfWXV0/Yv7BKbhL0xFmQgCpQ7QgM6n3y1OcOojfAhutxN7KPd4WoT5ve4xfEnKouF
 gHHzGLdrHW65ux9y2Y8rTURUpJXOHl5NQ07WAO970D9B7+KNw45wz
X-Received: by 2002:a05:600c:228b:b0:41f:ef1e:7314 with SMTP id
 5b1f17b1804b1-42108aa74efmr69414585e9.33.1716797896550; 
 Mon, 27 May 2024 01:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEloVGt6oXHScudvdU0L1xuu3lGqx9I99vbIIfO0OG41FlKhyMA2/0H7S8eY8r7RiHp28aBBA==
X-Received: by 2002:a05:600c:228b:b0:41f:ef1e:7314 with SMTP id
 5b1f17b1804b1-42108aa74efmr69414235e9.33.1716797895896; 
 Mon, 27 May 2024 01:18:15 -0700 (PDT)
Received: from redhat.com ([31.187.78.238]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fad7ecsm133372255e9.36.2024.05.27.01.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 01:18:15 -0700 (PDT)
Date: Mon, 27 May 2024 04:18:10 -0400
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
Subject: Re: [PATCH for 9.1 v9 00/11] hw/pci: SR-IOV related fixes and
 improvements
Message-ID: <20240527041637-mutt-send-email-mst@kernel.org>
References: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Mar 15, 2024 at 12:57:47PM +0900, Akihiko Odaki wrote:
> I submitted a RFC series[1] to add support for SR-IOV emulation to
> virtio-net-pci. During the development of the series, I fixed some
> trivial bugs and made improvements that I think are independently
> useful. This series extracts those fixes and improvements from the RFC
> series.


I picked 1-8 but still see no point in 9-11.
Actually checking whether value was specified seems cleaner
and more robust than tricks using a special value.
I would like to actually see it generalized so we do not
need to use special hacks like on/off/auto.



> [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v9:
> - Rebased.
> - Restored '#include "qapi/error.h"' (Michael S. Tsirkin)
> - Added patch "pcie_sriov: Ensure VF function number does not overflow"
>   to fix abortion with wrong PF addr.
> - Link to v8: https://lore.kernel.org/r/20240228-reuse-v8-0-282660281e60@daynix.com
> 
> Changes in v8:
> - Clarified that "hw/pci: Replace -1 with UINT32_MAX for romsize" is
>   not a bug fix. (Markus Armbruster)
> - Squashed patch "vfio: Avoid inspecting option QDict for rombar" into
>   "hw/pci: Determine if rombar is explicitly enabled".
>   (Markus Armbruster)
> - Noted the minor semantics change for patch "hw/pci: Determine if
>   rombar is explicitly enabled". (Markus Armbruster)
> - Link to v7: https://lore.kernel.org/r/20240224-reuse-v7-0-29c14bcb952e@daynix.com
> 
> Changes in v7:
> - Replaced -1 with UINT32_MAX when expressing uint32_t.
>   (Markus Armbruster)
> - Added patch "hw/pci: Replace -1 with UINT32_MAX for romsize".
> - Link to v6: https://lore.kernel.org/r/20240220-reuse-v6-0-2e42a28b0cf2@daynix.com
> 
> Changes in v6:
> - Fixed migration.
> - Added patch "pcie_sriov: Do not manually unrealize".
> - Restored patch "pcie_sriov: Release VFs failed to realize" that was
>   missed in v5.
> - Link to v5: https://lore.kernel.org/r/20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com
> 
> Changes in v5:
> - Added patch "hw/pci: Always call pcie_sriov_pf_reset()".
> - Added patch "pcie_sriov: Reset SR-IOV extended capability".
> - Removed a reference to PCI_SRIOV_CTRL_VFE in hw/nvme.
>   (Michael S. Tsirkin)
> - Noted the impact on the guest of patch "pcie_sriov: Do not reset
>   NumVFs after unregistering VFs". (Michael S. Tsirkin)
> - Changed to use pcie_sriov_num_vfs().
> - Restored pci_set_power() and changed it to call pci_set_enabled() only
>   for PFs with an expalanation. (Michael S. Tsirkin)
> - Reordered patches.
> - Link to v4: https://lore.kernel.org/r/20240214-reuse-v4-0-89ad093a07f4@daynix.com
> 
> Changes in v4:
> - Reverted the change to pci_rom_bar_explicitly_enabled().
>   (Michael S. Tsirkin)
> - Added patch "pcie_sriov: Do not reset NumVFs after unregistering VFs".
> - Added patch "hw/nvme: Refer to dev->exp.sriov_pf.num_vfs".
> - Link to v3: https://lore.kernel.org/r/20240212-reuse-v3-0-8017b689ce7f@daynix.com
> 
> Changes in v3:
> - Extracted patch "hw/pci: Use -1 as a default value for rombar" from
>   patch "hw/pci: Determine if rombar is explicitly enabled"
>   (Philippe Mathieu-Daudé)
> - Added an audit result of PCIDevice::rom_bar to the message of patch
>   "hw/pci: Use -1 as a default value for rombar"
>   (Philippe Mathieu-Daudé)
> - Link to v2: https://lore.kernel.org/r/20240210-reuse-v2-0-24ba2a502692@daynix.com
> 
> Changes in v2:
> - Reset after enabling a function so that NVMe VF state gets updated.
> - Link to v1: https://lore.kernel.org/r/20240203-reuse-v1-0-5be8c5ce6338@daynix.com
> 
> ---
> Akihiko Odaki (11):
>       hw/pci: Rename has_power to enabled
>       pcie_sriov: Do not manually unrealize
>       pcie_sriov: Ensure VF function number does not overflow
>       pcie_sriov: Reuse SR-IOV VF device instances
>       pcie_sriov: Release VFs failed to realize
>       pcie_sriov: Remove num_vfs from PCIESriovPF
>       pcie_sriov: Register VFs after migration
>       hw/pci: Replace -1 with UINT32_MAX for romsize
>       hw/pci: Use UINT32_MAX as a default value for rombar
>       hw/pci: Determine if rombar is explicitly enabled
>       hw/qdev: Remove opts member
> 
>  docs/pcie_sriov.txt         |   8 ++-
>  include/hw/pci/pci.h        |   2 +-
>  include/hw/pci/pci_device.h |  22 ++++++-
>  include/hw/pci/pcie_sriov.h |   9 +--
>  include/hw/qdev-core.h      |   4 --
>  hw/core/qdev.c              |   1 -
>  hw/net/igb.c                |  13 +++-
>  hw/nvme/ctrl.c              |  24 ++++---
>  hw/pci/pci.c                |  31 +++++----
>  hw/pci/pci_host.c           |   4 +-
>  hw/pci/pcie_sriov.c         | 149 ++++++++++++++++++++++++--------------------
>  hw/vfio/pci.c               |   3 +-
>  hw/xen/xen_pt_load_rom.c    |   2 +-
>  system/qdev-monitor.c       |  12 ++--
>  hw/pci/trace-events         |   2 +-
>  15 files changed, 172 insertions(+), 114 deletions(-)
> ---
> base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
> change-id: 20240129-reuse-faae22b11934
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


