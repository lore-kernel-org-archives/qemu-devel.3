Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9A8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarNT-0002J6-NI; Mon, 05 Aug 2024 02:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sarNN-0001zg-Kr
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sarNL-0002z8-5a
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722839960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MExdmSlSZtUh+fm/UPvtQcxGaOCyqRbIbnRAOdn/BXA=;
 b=BAQgNLN1idh/S3iKgNOEfcEdd+2SKY7IMx66cPInaEDuJas7LarimP/8W7+KnLOKSP5Soj
 LGVo23R0HiJweN2Lsz2wKl8PmUhpIeosUVwflwb19w7EONJZKt8cj3HHribtfjnfCLRpO8
 JRTmhfTH/Egt5CQsq9c4w3Jy9sOIoSI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-j78XzPyyOaaqWe4856Mp2w-1; Mon, 05 Aug 2024 02:39:17 -0400
X-MC-Unique: j78XzPyyOaaqWe4856Mp2w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42807a05413so66603495e9.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 23:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722839954; x=1723444754;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MExdmSlSZtUh+fm/UPvtQcxGaOCyqRbIbnRAOdn/BXA=;
 b=D9LO3BZ9kcPCEP/rsj3xqIzyBWvgBue3kMneyaSQMPeEuhK+V5EWCv5AKvDuK9MFAe
 yScBa/3/bOvOl8m6FU8GtFRbmtB7zGN3ejuwTpAHTo/LrvffpBZZEnGYcK5kBL8Odbif
 QShJ+TRKxsogsk3KlGIi1XYk01zDz0bMPlrxuUpmW8BZ/KpIorvKXFre4LtbKNUHdvAH
 TkR8wD78nGR7UmZESx082tSfrnvITruPzzK4uAbXwkkyDqCeyw2LBmsj4vkox5ccjd4u
 WXEekWTr1w9p8BvKs6msc+OlOTvTknt0bSfhZJBx7ihDUHVzeTJH7hAS0n33TBzdgdjM
 s0pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1HTvvt27QoNAsyVphxAUtBmTsQq640CbyLqGIoiA2ldG9oOtpMzQ9+8OdJbmrlqBcqzClYW2DoU7gfBPgTEC46bkbjwc=
X-Gm-Message-State: AOJu0YyN0zKPkIRyk6dCm4bQ4XqSwVI00kppstix11SZF4YzXFCj9hVP
 c4fUiA9wPCR5AictZt1wWyRe9Rp0AGD7hDxjVnvu17NkHmIKDRiQDAWJD+nuTPj78BnV2uqDr2A
 d9tF9xCbz5eUGbkKxUYk1e6WwAi4YDm9dgl+70z1V4YaLbtIiNXrs
X-Received: by 2002:a05:600c:a0b:b0:426:549b:dd7a with SMTP id
 5b1f17b1804b1-428e6b93992mr63960545e9.36.1722839954327; 
 Sun, 04 Aug 2024 23:39:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRyLBItmjb4VhevynqnM3Gt4IKcRcsUrb4x9HWpGabUuxc5zDzba+NwvOEXBujEJrc00GNyA==
X-Received: by 2002:a05:600c:a0b:b0:426:549b:dd7a with SMTP id
 5b1f17b1804b1-428e6b93992mr63960335e9.36.1722839953484; 
 Sun, 04 Aug 2024 23:39:13 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:dd95:f049:da1a:7ecb:6d9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e7d57asm124792965e9.33.2024.08.04.23.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 23:39:12 -0700 (PDT)
Date: Mon, 5 Aug 2024 02:39:07 -0400
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
Subject: Re: [PATCH for-9.2 v12 00/11] hw/pci: SR-IOV related fixes and
 improvements
Message-ID: <20240805023719-mutt-send-email-mst@kernel.org>
References: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Aug 04, 2024 at 06:01:36PM +0900, Akihiko Odaki wrote:
> Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
> ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
> 
> I submitted a RFC series[1] to add support for SR-IOV emulation to
> virtio-net-pci. During the development of the series, I fixed some
> trivial bugs and made improvements that I think are independently
> useful. This series extracts those fixes and improvements from the RFC
> series.
> 
> [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v12:
> - Changed to ignore invalid PCI_SRIOV_NUM_VF writes as done for
>   PCI_SRIOV_CTRL_VFE.
> - Updated the message for patch "hw/pci: Use -1 as the default value for
>   rombar". (Markus Armbruster)
> - Link to v11: https://lore.kernel.org/r/20240802-reuse-v11-0-fb83bb8c19fb@daynix.com

The igb issue is still with us, is it not?


> Changes in v11:
> - Rebased.
> - Dropped patch "hw/pci: Convert rom_bar into OnOffAuto".
> - Added patch "hw/pci: Use -1 as the default value for rombar".
> - Added for-9.2 to give a testing period for possible breakage with
>   libvirt/s390x.
> - Link to v10: https://lore.kernel.org/r/20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com
> 
> Changes in v10:
> - Added patch "hw/ppc/spapr_pci: Do not reject VFs created after a PF".
> - Added patch "hw/ppc/spapr_pci: Do not create DT for disabled PCI device".
> - Added patch "hw/pci: Convert rom_bar into OnOffAuto".
> - Dropped patch "hw/pci: Determine if rombar is explicitly enabled".
> - Dropped patch "hw/qdev: Remove opts member".
> - Link to v9: https://lore.kernel.org/r/20240315-reuse-v9-0-67aa69af4d53@daynix.com
> 
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
>       hw/ppc/spapr_pci: Do not create DT for disabled PCI device
>       hw/ppc/spapr_pci: Do not reject VFs created after a PF
>       pcie_sriov: Do not manually unrealize
>       pcie_sriov: Ensure VF function number does not overflow
>       pcie_sriov: Reuse SR-IOV VF device instances
>       pcie_sriov: Release VFs failed to realize
>       pcie_sriov: Remove num_vfs from PCIESriovPF
>       pcie_sriov: Register VFs after migration
>       hw/pci: Use -1 as the default value for rombar
>       hw/qdev: Remove opts member
> 
>  docs/pcie_sriov.txt         |   8 ++-
>  include/hw/pci/pci.h        |   2 +-
>  include/hw/pci/pci_device.h |  19 ++++-
>  include/hw/pci/pcie_sriov.h |   9 +--
>  include/hw/qdev-core.h      |   4 --
>  hw/core/qdev.c              |   1 -
>  hw/net/igb.c                |  13 +++-
>  hw/nvme/ctrl.c              |  24 ++++---
>  hw/pci/pci.c                |  23 +++---
>  hw/pci/pci_host.c           |   4 +-
>  hw/pci/pcie_sriov.c         | 165 +++++++++++++++++++++++++-------------------
>  hw/ppc/spapr_pci.c          |   8 ++-
>  hw/vfio/pci.c               |   5 +-
>  system/qdev-monitor.c       |  12 ++--
>  hw/pci/trace-events         |   2 +-
>  15 files changed, 181 insertions(+), 118 deletions(-)
> ---
> base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
> change-id: 20240129-reuse-faae22b11934
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


