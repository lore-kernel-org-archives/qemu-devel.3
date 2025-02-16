Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF444C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 12:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjdjL-0003Lx-Eu; Sun, 16 Feb 2025 07:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tjdjK-0003La-2J
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 07:26:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tjdjH-0002i0-7p
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 07:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739708793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTSvq11qD/XGsnDzZdhln0UAUP3zO6YcT/fCidQIq0Q=;
 b=XNtZBegMunPg0FQEW0RSaWutII51pod4G4AWfFbCbhYHHWJj9wJw/kSDU9hjVlppi7u9xr
 P6lFVTaABtjQUUuYY229M0jt0qnhOIn0kI83qhc492A6TLR2Y0LjW4XTHfzl2tcrGa1pWp
 8Oi0M3X58n41JRDTjjBmQs9hNERoSR4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-UZ0fcMS5PGG91xMCpeuKBg-1; Sun, 16 Feb 2025 07:26:30 -0500
X-MC-Unique: UZ0fcMS5PGG91xMCpeuKBg-1
X-Mimecast-MFC-AGG-ID: UZ0fcMS5PGG91xMCpeuKBg_1739708789
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab7f0964bc3so379328166b.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 04:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739708788; x=1740313588;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xTSvq11qD/XGsnDzZdhln0UAUP3zO6YcT/fCidQIq0Q=;
 b=rIGkZ89/HKAd7DFObVQCm0PBy00eycuWsmJ6TgcSnexp0Jy2aPc7N6nssbvr6NBPYV
 BYLXhQY/IqJg81xabelZ1vuo0Oeyl/m4GTzlmItMcMmfeiielA95JhfrU2ja4HkwcR/D
 fwkbtRiszD7oog5ChOlWqpJJ7Wzw+iVvT1AQp3936uLeGXpxSJuVyo1ojnkZXoqm2WSe
 6aT89PrjMmOd5g5af4W++jCj/w5kzaB5nf+GXtch+tEF+aTlTFIBsMC7q3b3RqhzQHDy
 tUFtMZjuhR5Hscmn/2xgSgWgzsoHOTGIpaqnuDsiyiyv6U76ympBKmWqE6deV3wajzhe
 PacA==
X-Gm-Message-State: AOJu0Yzdh8hafdmDbNhlCx/rcEKXri/pR8IvBPyr+G6y5xnvz2bCpnuf
 H9bXabTmytH2CClbN2ri2y0Jo5GObtY+vjvUCp/BXfeKY/a40Q00LkO3MWpRGIRFDc9LrsnywE0
 5wD9nZXPY+gGtXaXCgTMMYONOP06Yu0r+cEGSM86COAmRDskaBCAs
X-Gm-Gg: ASbGnctz4DcnfWeJ125cf/drg8o8XjonKTTgabrRV+Dlu5MFhR0pTfgTa2f5RT2cycj
 xY1C3OgQwTB4h+iEajQyydyM7OW1uh/8loR3k4v5TjYEiEY5mi6wLhkjLslzyADcIuQ3kdBpAgX
 fMjTtT0Mh+mWVW/e7HxXxo0/zQGm7G2drUlSqL4vxprmI+bVTh3lGE8gc5yciD1fi9CvNOq3FCr
 JJqjmtZtFuOuPGWujPOfzWKzN2miECnCanyKpgglW9ZU2VE0k6iZ3wED/oyNDkz+Eg75ODeopQ=
X-Received: by 2002:a17:906:4fd5:b0:ab3:4b0c:ea44 with SMTP id
 a640c23a62f3a-abb7091d9e1mr580585366b.9.1739708787667; 
 Sun, 16 Feb 2025 04:26:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOsDUvrzF0xCDhs7LMZVKiyVE8VUHIO3cJ79d8Wg6AU8swiXVdMM+L2kwYMMZokhAwH1W9gg==
X-Received: by 2002:a17:906:4fd5:b0:ab3:4b0c:ea44 with SMTP id
 a640c23a62f3a-abb7091d9e1mr580581766b.9.1739708787144; 
 Sun, 16 Feb 2025 04:26:27 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:64db:30cf:6f71:2385:1e86])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb9723a559sm55182566b.96.2025.02.16.04.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 04:26:26 -0800 (PST)
Date: Sun, 16 Feb 2025 07:26:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v20 00/11] hw/pci: SR-IOV related fixes and improvements
Message-ID: <20250216072602-mutt-send-email-mst@kernel.org>
References: <20250116-reuse-v20-0-7cb370606368@daynix.com>
 <fe8e5df1-6dbe-4ecc-9096-d4b504f81c66@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe8e5df1-6dbe-4ecc-9096-d4b504f81c66@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, Feb 15, 2025 at 03:25:14PM +0900, Akihiko Odaki wrote:
> Hi Michael,
> 
> It has been a while since this series was reviewed by maintainers of
> relevant architectures. Can you check if this series is ready to pull?
> 
> Regards,
> Akihiko Odaki


Yes, it's tagged, will be in the next pull.


> On 2025/01/16 18:00, Akihiko Odaki wrote:
> > Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
> > ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
> > 
> > I submitted a RFC series[1] to add support for SR-IOV emulation to
> > virtio-net-pci. During the development of the series, I fixed some
> > trivial bugs and made improvements that I think are independently
> > useful. This series extracts those fixes and improvements from the RFC
> > series.
> > 
> > [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> > Changes in v20:
> > - Use qdev_is_realized().
> > - Link to v19: https://lore.kernel.org/r/20250109-reuse-v19-0-f541e82ca5f7@daynix.com
> > 
> > Changes in v19:
> > - Avoided inling pci_set_power().
> > - Link to v18: https://lore.kernel.org/r/20250104-reuse-v18-0-c349eafd8673@daynix.com
> > 
> > Changes in v18:
> > - Rebased.
> > - Link to v17: https://lore.kernel.org/r/20241022-reuse-v17-0-bd7c133237e4@daynix.com
> > 
> > Changes in v17:
> > - Added patch "pcie_sriov: Ensure VF addr does not overflow".
> > - Changed not to link VF with sPAPR DRC.
> > - Asserted pci_is_vf() when zpci is not found. (Cédric Le Goater)
> > - Link to v16: https://lore.kernel.org/r/20240913-reuse-v16-0-d016b4b4f616@daynix.com
> > 
> > Changes in v16:
> > - Added patch "s390x/pci: Avoid creating zpci for VFs".
> > - Added patch "s390x/pci: Allow plugging SR-IOV devices".
> > - Link to v15: https://lore.kernel.org/r/20240823-reuse-v15-0-eddcb960e289@daynix.com
> > 
> > Changes in v15:
> > - Fixed variable shadowing in patch
> >    "pcie_sriov: Remove num_vfs from PCIESriovPF"
> > - Link to v14: https://lore.kernel.org/r/20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com
> > 
> > Changes in v14:
> > - Dropped patch "pcie_sriov: Ensure VF function number does not
> >    overflow" as I found the restriction it imposes is unnecessary.
> > - Link to v13: https://lore.kernel.org/r/20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com
> > 
> > Changes in v13:
> > - Added patch "s390x/pci: Check for multifunction after device
> >    realization". I found SR-IOV devices, which are multifunction devices,
> >    are not supposed to work at all with s390x on QEMU.
> > - Link to v12: https://lore.kernel.org/r/20240804-reuse-v12-0-d3930c4111b2@daynix.com
> > 
> > Changes in v12:
> > - Changed to ignore invalid PCI_SRIOV_NUM_VF writes as done for
> >    PCI_SRIOV_CTRL_VFE.
> > - Updated the message for patch "hw/pci: Use -1 as the default value for
> >    rombar". (Markus Armbruster)
> > - Link to v11: https://lore.kernel.org/r/20240802-reuse-v11-0-fb83bb8c19fb@daynix.com
> > 
> > Changes in v11:
> > - Rebased.
> > - Dropped patch "hw/pci: Convert rom_bar into OnOffAuto".
> > - Added patch "hw/pci: Use -1 as the default value for rombar".
> > - Added for-9.2 to give a testing period for possible breakage with
> >    libvirt/s390x.
> > - Link to v10: https://lore.kernel.org/r/20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com
> > 
> > Changes in v10:
> > - Added patch "hw/ppc/spapr_pci: Do not reject VFs created after a PF".
> > - Added patch "hw/ppc/spapr_pci: Do not create DT for disabled PCI device".
> > - Added patch "hw/pci: Convert rom_bar into OnOffAuto".
> > - Dropped patch "hw/pci: Determine if rombar is explicitly enabled".
> > - Dropped patch "hw/qdev: Remove opts member".
> > - Link to v9: https://lore.kernel.org/r/20240315-reuse-v9-0-67aa69af4d53@daynix.com
> > 
> > Changes in v9:
> > - Rebased.
> > - Restored '#include "qapi/error.h"' (Michael S. Tsirkin)
> > - Added patch "pcie_sriov: Ensure VF function number does not overflow"
> >    to fix abortion with wrong PF addr.
> > - Link to v8: https://lore.kernel.org/r/20240228-reuse-v8-0-282660281e60@daynix.com
> > 
> > Changes in v8:
> > - Clarified that "hw/pci: Replace -1 with UINT32_MAX for romsize" is
> >    not a bug fix. (Markus Armbruster)
> > - Squashed patch "vfio: Avoid inspecting option QDict for rombar" into
> >    "hw/pci: Determine if rombar is explicitly enabled".
> >    (Markus Armbruster)
> > - Noted the minor semantics change for patch "hw/pci: Determine if
> >    rombar is explicitly enabled". (Markus Armbruster)
> > - Link to v7: https://lore.kernel.org/r/20240224-reuse-v7-0-29c14bcb952e@daynix.com
> > 
> > Changes in v7:
> > - Replaced -1 with UINT32_MAX when expressing uint32_t.
> >    (Markus Armbruster)
> > - Added patch "hw/pci: Replace -1 with UINT32_MAX for romsize".
> > - Link to v6: https://lore.kernel.org/r/20240220-reuse-v6-0-2e42a28b0cf2@daynix.com
> > 
> > Changes in v6:
> > - Fixed migration.
> > - Added patch "pcie_sriov: Do not manually unrealize".
> > - Restored patch "pcie_sriov: Release VFs failed to realize" that was
> >    missed in v5.
> > - Link to v5: https://lore.kernel.org/r/20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com
> > 
> > Changes in v5:
> > - Added patch "hw/pci: Always call pcie_sriov_pf_reset()".
> > - Added patch "pcie_sriov: Reset SR-IOV extended capability".
> > - Removed a reference to PCI_SRIOV_CTRL_VFE in hw/nvme.
> >    (Michael S. Tsirkin)
> > - Noted the impact on the guest of patch "pcie_sriov: Do not reset
> >    NumVFs after unregistering VFs". (Michael S. Tsirkin)
> > - Changed to use pcie_sriov_num_vfs().
> > - Restored pci_set_power() and changed it to call pci_set_enabled() only
> >    for PFs with an expalanation. (Michael S. Tsirkin)
> > - Reordered patches.
> > - Link to v4: https://lore.kernel.org/r/20240214-reuse-v4-0-89ad093a07f4@daynix.com
> > 
> > Changes in v4:
> > - Reverted the change to pci_rom_bar_explicitly_enabled().
> >    (Michael S. Tsirkin)
> > - Added patch "pcie_sriov: Do not reset NumVFs after unregistering VFs".
> > - Added patch "hw/nvme: Refer to dev->exp.sriov_pf.num_vfs".
> > - Link to v3: https://lore.kernel.org/r/20240212-reuse-v3-0-8017b689ce7f@daynix.com
> > 
> > Changes in v3:
> > - Extracted patch "hw/pci: Use -1 as a default value for rombar" from
> >    patch "hw/pci: Determine if rombar is explicitly enabled"
> >    (Philippe Mathieu-Daudé)
> > - Added an audit result of PCIDevice::rom_bar to the message of patch
> >    "hw/pci: Use -1 as a default value for rombar"
> >    (Philippe Mathieu-Daudé)
> > - Link to v2: https://lore.kernel.org/r/20240210-reuse-v2-0-24ba2a502692@daynix.com
> > 
> > Changes in v2:
> > - Reset after enabling a function so that NVMe VF state gets updated.
> > - Link to v1: https://lore.kernel.org/r/20240203-reuse-v1-0-5be8c5ce6338@daynix.com
> > 
> > ---
> > Akihiko Odaki (11):
> >        hw/ppc/spapr_pci: Do not create DT for disabled PCI device
> >        hw/ppc/spapr_pci: Do not reject VFs created after a PF
> >        s390x/pci: Avoid creating zpci for VFs
> >        s390x/pci: Allow plugging SR-IOV devices
> >        s390x/pci: Check for multifunction after device realization
> >        pcie_sriov: Do not manually unrealize
> >        pcie_sriov: Ensure VF addr does not overflow
> >        pcie_sriov: Reuse SR-IOV VF device instances
> >        pcie_sriov: Release VFs failed to realize
> >        pcie_sriov: Remove num_vfs from PCIESriovPF
> >        pcie_sriov: Register VFs after migration
> > 
> >   docs/pcie_sriov.txt         |   8 ++-
> >   include/hw/pci/pcie_sriov.h |   9 +--
> >   hw/net/igb.c                |  10 ++-
> >   hw/nvme/ctrl.c              |  22 +++---
> >   hw/pci/pci.c                |  21 +++++-
> >   hw/pci/pcie_sriov.c         | 159 ++++++++++++++++++++++++--------------------
> >   hw/ppc/spapr_pci.c          |  20 +++++-
> >   hw/s390x/s390-pci-bus.c     |  42 +++++++++---
> >   hw/pci/trace-events         |   2 +-
> >   9 files changed, 187 insertions(+), 106 deletions(-)
> > ---
> > base-commit: 7433709a147706ad7d1956b15669279933d0f82b
> > change-id: 20240129-reuse-faae22b11934
> > 
> > Best regards,


