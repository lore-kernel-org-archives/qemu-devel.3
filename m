Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1708DC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8C2-0001g4-40; Tue, 12 Mar 2024 15:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk8Bz-0001fe-K0
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk8Bw-00068G-GT
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710273219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YPce8+PUPJlFhGHUdxA77BN+a2S6zQKvoy4P0HGC2oo=;
 b=KskywSy8gNl0ujLpoke9ZetqjTFLc5Ns08XrMSIxerLKa6z/Jxein6Lq4VZ2+tdkaX4pDf
 wKhbRGeiU8Y/3EbfC/Agu7oZ42NtzJfzrAYfBANs1cyP+HIrkWyIXbpXpkLUd6s4tkSNr7
 HFyk24jGBYjrYjwr3Lv3g4m0HC5EkU8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-yvM5XZG0NW2ROAYGsmBoKg-1; Tue, 12 Mar 2024 15:53:38 -0400
X-MC-Unique: yvM5XZG0NW2ROAYGsmBoKg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a448cfe2266so485241566b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 12:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710273217; x=1710878017;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPce8+PUPJlFhGHUdxA77BN+a2S6zQKvoy4P0HGC2oo=;
 b=RcS/zuEZ0uYLLpVb0vVGc7MDgBi53GWmuWgge2J3MH+eLvB9w6mqyIF8sSbzErClJZ
 98+WN01bTEBn7e5Iq+VwnL4w+s9YCwTA2Zop+HPICZOiKMw04re3SIX7W+I8th4pb00r
 gEdjseG9J6CVJhY5e5W2tR7adAIiaZcflHNDddwpeJWgxUma6qf3je8qBlrM4x2y9Msc
 gpbBMy7eehDCKMb3rYJOLBM1PuG5FZIBvynZn0E1gX1mVgB0LLU3zqd2OcEHEFIXX0Jq
 dHjSHCpVXzDdtyzo3A+9fjiRT4zOLZ8aH1Upva1BsY9/k/J2gvKCjHbGWteNe1D+tzA7
 p59g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq9D7YKhsg9B2IjNGudMy+AtGO2gGraf5oKAI2TtYrqnP/mEDY5BTfuZBXROjgNFMK6LhlE2ooES80qi+LvFNvGeXXF7E=
X-Gm-Message-State: AOJu0YzzksZF4T0BH+1jUVMaLCqW3lTqjWQeWvODSJufj/418P3GpXkx
 yD0914VmpSU+O7J4xXQy09i96wAYZe9X6a/IDzEqL8LY3NEPHBfrxWw7uGZJFIs5WlhVlZfZ3Dl
 7JMznm/beUTOe/J0XGw0ncBh1gETE3O3q6Pb7w8Gt+PzAypfcoZu/
X-Received: by 2002:a17:906:3c4c:b0:a46:329b:d569 with SMTP id
 i12-20020a1709063c4c00b00a46329bd569mr3719778ejg.8.1710273216682; 
 Tue, 12 Mar 2024 12:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/aFfHq8kiLgR1YXU76eHM9WBFRtO4KeDh1On8EdnMyZamgCju+q9FC7DZntApDYICSjrPLw==
X-Received: by 2002:a17:906:3c4c:b0:a46:329b:d569 with SMTP id
 i12-20020a1709063c4c00b00a46329bd569mr3719757ejg.8.1710273216217; 
 Tue, 12 Mar 2024 12:53:36 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 fx3-20020a170906b74300b00a4380e85e5csm4128030ejb.202.2024.03.12.12.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 12:53:34 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:53:29 -0400
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
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v8 00/15] hw/pci: SR-IOV related fixes and improvements
Message-ID: <20240312155304-mutt-send-email-mst@kernel.org>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228-reuse-v8-0-282660281e60@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Feb 28, 2024 at 08:33:11PM +0900, Akihiko Odaki wrote:
> I submitted a RFC series[1] to add support for SR-IOV emulation to
> virtio-net-pci. During the development of the series, I fixed some
> trivial bugs and made improvements that I think are independently
> useful. This series extracts those fixes and improvements from the RFC
> series.


I picked 1-6 the rest will have to go in after release.

> [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
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
> Akihiko Odaki (15):
>       hw/nvme: Use pcie_sriov_num_vfs()
>       pcie_sriov: Validate NumVFs
>       pcie_sriov: Reset SR-IOV extended capability
>       pcie_sriov: Do not reset NumVFs after disabling VFs
>       hw/pci: Always call pcie_sriov_pf_reset()
>       hw/pci: Rename has_power to enabled
>       pcie_sriov: Do not manually unrealize
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
>  include/hw/pci/pci_device.h |  22 +++++-
>  include/hw/pci/pcie_sriov.h |  13 ++--
>  include/hw/qdev-core.h      |   4 --
>  hw/core/qdev.c              |   1 -
>  hw/net/igb.c                |  15 ++--
>  hw/nvme/ctrl.c              |  54 +++++++-------
>  hw/pci/pci.c                |  32 +++++----
>  hw/pci/pci_host.c           |   4 +-
>  hw/pci/pcie_sriov.c         | 170 ++++++++++++++++++++++++--------------------
>  hw/vfio/pci.c               |   3 +-
>  hw/xen/xen_pt_load_rom.c    |   2 +-
>  system/qdev-monitor.c       |  12 ++--
>  hw/pci/trace-events         |   2 +-
>  15 files changed, 194 insertions(+), 150 deletions(-)
> ---
> base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
> change-id: 20240129-reuse-faae22b11934
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


