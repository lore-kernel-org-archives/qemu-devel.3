Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CBFC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 14:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUjd-0008B0-NC; Tue, 04 Jun 2024 10:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEUja-00088l-EL
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEUjW-0008Pv-E0
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717509705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8JcBLTS/0XWvXrHGHJk1vqRXL1q+7K7VrzMy2BA33g=;
 b=EeuiVOE9UI+jvXxdJMHkt2yFRRHDtZuXheJwrn3L9I0CMrBbzofdWxwGSRLLRgj67FNOVi
 WMZuT22lKaBtx9eg04rIOzjddgampUkT4u/ScZJjjn21UmsUc6AkJq5nZUd4Ie4Jws6OkF
 n0J9dwReq2EYAsMVOOEBaw+yTZt+pkE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-Qsgp4s6vMvyvVEbrxKIEbA-1; Tue, 04 Jun 2024 10:01:40 -0400
X-MC-Unique: Qsgp4s6vMvyvVEbrxKIEbA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ea9aeae4e6so33446961fa.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717509698; x=1718114498;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D8JcBLTS/0XWvXrHGHJk1vqRXL1q+7K7VrzMy2BA33g=;
 b=ejBpj4jlVxYWusmpzFeS+c6YOAhoGll0k8tCavwwIoQJXHCwUMvtdr9McB4FY5L15I
 V55wClI7kf3CFqOevxHqDddlRtFnMm36yHCGgfyLgciY46cMW0J/tvNnQl9dIw8jxoPd
 F0vwSMlaKElcPMljOZBiKDrkbNh/OUgnkBI2cZvZ6CQXgCr8251UOYQcD+VSDxvacmHW
 wn0DBTUH0hsfVHIPzNMwEIO3N9R5HBi3o0yCLhzWsjiwfIeCCbMBwLrIJtKxdnRXSEA8
 iqSQBDTt5WNceUeHJbqDUlnzB5S22cdSEGORXrKDlBXuriQudSP/O1f/3P5pbqmcMxfV
 AfQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWIARQZxsetu+eEFBB1i+zuHdjs/FjkBjLhaDw5rInlOS5Rv1OIQGEQa5DtUkO2/MYsrwk8yYEK9dRL+vnzGM0ttRTZSM=
X-Gm-Message-State: AOJu0YxSdM5f0zvTPEClzFI6y8FzUSTBVKS7PXIuH6QFXwkAzXT8gofH
 Wdms1HLQduphM+9wz/prjSUsPAV9lkWCrrBk5YLdOBQ8ol2WIcESp0QRWbKSHZyBH4wT8+fRYrS
 an18Ti9cMiZY8ha42KY7qR8MF7q2Xcb677FYGZaqMpGfQLptOEkx2
X-Received: by 2002:a2e:3202:0:b0:2ea:83b1:bf70 with SMTP id
 38308e7fff4ca-2ea951df832mr100334771fa.37.1717509698373; 
 Tue, 04 Jun 2024 07:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT1hBdn/5KK3fauTXAXGHe2swfXEXy0HhgitZNzAlAgSOd7NUqRTXQz/usCnY1dttJ3lJAcA==
X-Received: by 2002:a2e:3202:0:b0:2ea:83b1:bf70 with SMTP id
 38308e7fff4ca-2ea951df832mr100334391fa.37.1717509697759; 
 Tue, 04 Jun 2024 07:01:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421535bc543sm17291135e9.43.2024.06.04.07.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 07:01:37 -0700 (PDT)
Date: Tue, 4 Jun 2024 10:01:31 -0400
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
Message-ID: <20240604100020-mutt-send-email-mst@kernel.org>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228-reuse-v8-0-282660281e60@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> 
> [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>


Applying these:

pcie_sriov: Register VFs after migration
pcie_sriov: Remove num_vfs from PCIESriovPF
pcie_sriov: Release VFs failed to realize
pcie_sriov: Reuse SR-IOV VF device instances
pcie_sriov: Ensure VF function number does not overflow
pcie_sriov: Do not manually unrealize
pci: Rename has_power to enabled


Triggers a CI failure:

https://gitlab.com/mstredhat/qemu/-/jobs/7013886604


qemu-system-ppc64: ../hw/pci/pci.c:276: pci_bar: Assertion `!pci_is_vf(d)' failed.
Broken pipe
../tests/qtest/libqtest.c:204: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
(test program exited with status code -6)
TAP parsing error: Too few tests run (expected 127, got 41)


Pls fix and repost.


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


