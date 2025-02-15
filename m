Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5291AC021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 06:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjBcJ-00051k-EF; Sat, 15 Feb 2025 01:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tjBcF-00051T-TV
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 01:25:27 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tjBcB-0006ba-DL
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 01:25:26 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fc042c9290so4458225a91.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 22:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1739600721; x=1740205521;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mEiMg41rLTQe7udEciztU7PNbMI4x2FVUDijNjjCUqo=;
 b=HllktzC7mqjlvjG+L4PQCyqy2/b2pc8UJZ7fPKNs2rUsMQ7MAUSj3I7ZXOps4hTFd5
 fbK1oo5pFbN5MTomT752vIc4D0QFTq6QLh+2cE0l7HzHU1gr5Ppg1C8gG3cLLp8v0JUv
 Z3BxrHgOFlKcznxl0jhZxXICorKH4mdCnvyInUbRYW/H9C+m6pnH9UzVU4VBbwarKOzY
 OZpAJitTjSk/LP5OyT55A+GlaNr+TlzypAaJggZ0PgXN9Orke9M3/Q9Y8zD/KkRtSHeW
 bKrLSMSn/PFc0IjZz8Ns0FMMOJ6blv1HgYlbuhkEuESeOmBMBIOvAbi4Tta9O/tiWSkZ
 dHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739600721; x=1740205521;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mEiMg41rLTQe7udEciztU7PNbMI4x2FVUDijNjjCUqo=;
 b=H5Ibdo1ElhOaDjP+jaOMVTYtpkehvXwDIvlvitB2p25PZ2ll7HLpK1g16iIW9WxXFc
 p7E1uHwLbSz6SV4qgSg2HyUAL7bG2tvY7VxIZQigd9m9m1bb663TMCOebPWoS0pbdOZS
 ha93LpjnpSZ0hd74yitodH1bEwhcwYGCGbK0TiDTmsF12a9N91T56IRNJnLEvKiY1uIk
 FMER++qXAEA9io1DfyYAWhzcARBOuQqiy8ezC6dh3x3dmkfo2dhf07EX0b0DRNnnPooa
 fURZsUWW3NnOhYIvz3aj6Iis/i/TIxFeF9rAOsolV5L9Ey5U1g1i0XFXHk1g1noyI+tu
 M2WQ==
X-Gm-Message-State: AOJu0Yz2SWmrIJW858b68RKklYWp23HADrm2Um8aj7WjAhc+pmYYl9pE
 dJTptZ9XPaaLxADR5xjdCW2G0bOtQST13JGw00z3NtSP+wLAvk0YHeJcgcqC2QA=
X-Gm-Gg: ASbGncufW1LErti2zINOqqgcBLQwaf3/LTqh+qnBTt9FQUnsbWfAUA8wvh+ejZ2vgWd
 cgQZjiB1IAj6bFRXpTYI5wDbHSceXjw9FTgL2E6Wrv/RGO11NzuQiv50vuGsCAW/Th/sGIcdVz2
 DlSaUd2Txt1ng2h8L+jt5E+bRZnMQ7Y4Te89YwzYlRslL0l4Acrtd1fR5vkFjces0IV/5tFUw4E
 h7Rd3uyZxtuYGy/YyAw+4mH4zpqlxe54DAWw1O4X/uhoLArKLsBFO77EiKuwmN6iTUY6LaQqCtL
 fKQNkH6zPfZkWO8CHehVOrer+q/R
X-Google-Smtp-Source: AGHT+IHF4G41cMqu+NVk3RpgxDdD1AgrViZ2anortT5rJTR7fA0MZfph04E3YlHZ49ubeAdFAqsS+w==
X-Received: by 2002:a17:90b:3805:b0:2ee:ad18:b30d with SMTP id
 98e67ed59e1d1-2fc40d14c79mr3002833a91.6.1739600720663; 
 Fri, 14 Feb 2025 22:25:20 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98f4f62sm6262779a91.26.2025.02.14.22.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2025 22:25:20 -0800 (PST)
Message-ID: <fe8e5df1-6dbe-4ecc-9096-d4b504f81c66@daynix.com>
Date: Sat, 15 Feb 2025 15:25:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 00/11] hw/pci: SR-IOV related fixes and improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
References: <20250116-reuse-v20-0-7cb370606368@daynix.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250116-reuse-v20-0-7cb370606368@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Michael,

It has been a while since this series was reviewed by maintainers of 
relevant architectures. Can you check if this series is ready to pull?

Regards,
Akihiko Odaki

On 2025/01/16 18:00, Akihiko Odaki wrote:
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
> Changes in v20:
> - Use qdev_is_realized().
> - Link to v19: https://lore.kernel.org/r/20250109-reuse-v19-0-f541e82ca5f7@daynix.com
> 
> Changes in v19:
> - Avoided inling pci_set_power().
> - Link to v18: https://lore.kernel.org/r/20250104-reuse-v18-0-c349eafd8673@daynix.com
> 
> Changes in v18:
> - Rebased.
> - Link to v17: https://lore.kernel.org/r/20241022-reuse-v17-0-bd7c133237e4@daynix.com
> 
> Changes in v17:
> - Added patch "pcie_sriov: Ensure VF addr does not overflow".
> - Changed not to link VF with sPAPR DRC.
> - Asserted pci_is_vf() when zpci is not found. (Cédric Le Goater)
> - Link to v16: https://lore.kernel.org/r/20240913-reuse-v16-0-d016b4b4f616@daynix.com
> 
> Changes in v16:
> - Added patch "s390x/pci: Avoid creating zpci for VFs".
> - Added patch "s390x/pci: Allow plugging SR-IOV devices".
> - Link to v15: https://lore.kernel.org/r/20240823-reuse-v15-0-eddcb960e289@daynix.com
> 
> Changes in v15:
> - Fixed variable shadowing in patch
>    "pcie_sriov: Remove num_vfs from PCIESriovPF"
> - Link to v14: https://lore.kernel.org/r/20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com
> 
> Changes in v14:
> - Dropped patch "pcie_sriov: Ensure VF function number does not
>    overflow" as I found the restriction it imposes is unnecessary.
> - Link to v13: https://lore.kernel.org/r/20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com
> 
> Changes in v13:
> - Added patch "s390x/pci: Check for multifunction after device
>    realization". I found SR-IOV devices, which are multifunction devices,
>    are not supposed to work at all with s390x on QEMU.
> - Link to v12: https://lore.kernel.org/r/20240804-reuse-v12-0-d3930c4111b2@daynix.com
> 
> Changes in v12:
> - Changed to ignore invalid PCI_SRIOV_NUM_VF writes as done for
>    PCI_SRIOV_CTRL_VFE.
> - Updated the message for patch "hw/pci: Use -1 as the default value for
>    rombar". (Markus Armbruster)
> - Link to v11: https://lore.kernel.org/r/20240802-reuse-v11-0-fb83bb8c19fb@daynix.com
> 
> Changes in v11:
> - Rebased.
> - Dropped patch "hw/pci: Convert rom_bar into OnOffAuto".
> - Added patch "hw/pci: Use -1 as the default value for rombar".
> - Added for-9.2 to give a testing period for possible breakage with
>    libvirt/s390x.
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
>    to fix abortion with wrong PF addr.
> - Link to v8: https://lore.kernel.org/r/20240228-reuse-v8-0-282660281e60@daynix.com
> 
> Changes in v8:
> - Clarified that "hw/pci: Replace -1 with UINT32_MAX for romsize" is
>    not a bug fix. (Markus Armbruster)
> - Squashed patch "vfio: Avoid inspecting option QDict for rombar" into
>    "hw/pci: Determine if rombar is explicitly enabled".
>    (Markus Armbruster)
> - Noted the minor semantics change for patch "hw/pci: Determine if
>    rombar is explicitly enabled". (Markus Armbruster)
> - Link to v7: https://lore.kernel.org/r/20240224-reuse-v7-0-29c14bcb952e@daynix.com
> 
> Changes in v7:
> - Replaced -1 with UINT32_MAX when expressing uint32_t.
>    (Markus Armbruster)
> - Added patch "hw/pci: Replace -1 with UINT32_MAX for romsize".
> - Link to v6: https://lore.kernel.org/r/20240220-reuse-v6-0-2e42a28b0cf2@daynix.com
> 
> Changes in v6:
> - Fixed migration.
> - Added patch "pcie_sriov: Do not manually unrealize".
> - Restored patch "pcie_sriov: Release VFs failed to realize" that was
>    missed in v5.
> - Link to v5: https://lore.kernel.org/r/20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com
> 
> Changes in v5:
> - Added patch "hw/pci: Always call pcie_sriov_pf_reset()".
> - Added patch "pcie_sriov: Reset SR-IOV extended capability".
> - Removed a reference to PCI_SRIOV_CTRL_VFE in hw/nvme.
>    (Michael S. Tsirkin)
> - Noted the impact on the guest of patch "pcie_sriov: Do not reset
>    NumVFs after unregistering VFs". (Michael S. Tsirkin)
> - Changed to use pcie_sriov_num_vfs().
> - Restored pci_set_power() and changed it to call pci_set_enabled() only
>    for PFs with an expalanation. (Michael S. Tsirkin)
> - Reordered patches.
> - Link to v4: https://lore.kernel.org/r/20240214-reuse-v4-0-89ad093a07f4@daynix.com
> 
> Changes in v4:
> - Reverted the change to pci_rom_bar_explicitly_enabled().
>    (Michael S. Tsirkin)
> - Added patch "pcie_sriov: Do not reset NumVFs after unregistering VFs".
> - Added patch "hw/nvme: Refer to dev->exp.sriov_pf.num_vfs".
> - Link to v3: https://lore.kernel.org/r/20240212-reuse-v3-0-8017b689ce7f@daynix.com
> 
> Changes in v3:
> - Extracted patch "hw/pci: Use -1 as a default value for rombar" from
>    patch "hw/pci: Determine if rombar is explicitly enabled"
>    (Philippe Mathieu-Daudé)
> - Added an audit result of PCIDevice::rom_bar to the message of patch
>    "hw/pci: Use -1 as a default value for rombar"
>    (Philippe Mathieu-Daudé)
> - Link to v2: https://lore.kernel.org/r/20240210-reuse-v2-0-24ba2a502692@daynix.com
> 
> Changes in v2:
> - Reset after enabling a function so that NVMe VF state gets updated.
> - Link to v1: https://lore.kernel.org/r/20240203-reuse-v1-0-5be8c5ce6338@daynix.com
> 
> ---
> Akihiko Odaki (11):
>        hw/ppc/spapr_pci: Do not create DT for disabled PCI device
>        hw/ppc/spapr_pci: Do not reject VFs created after a PF
>        s390x/pci: Avoid creating zpci for VFs
>        s390x/pci: Allow plugging SR-IOV devices
>        s390x/pci: Check for multifunction after device realization
>        pcie_sriov: Do not manually unrealize
>        pcie_sriov: Ensure VF addr does not overflow
>        pcie_sriov: Reuse SR-IOV VF device instances
>        pcie_sriov: Release VFs failed to realize
>        pcie_sriov: Remove num_vfs from PCIESriovPF
>        pcie_sriov: Register VFs after migration
> 
>   docs/pcie_sriov.txt         |   8 ++-
>   include/hw/pci/pcie_sriov.h |   9 +--
>   hw/net/igb.c                |  10 ++-
>   hw/nvme/ctrl.c              |  22 +++---
>   hw/pci/pci.c                |  21 +++++-
>   hw/pci/pcie_sriov.c         | 159 ++++++++++++++++++++++++--------------------
>   hw/ppc/spapr_pci.c          |  20 +++++-
>   hw/s390x/s390-pci-bus.c     |  42 +++++++++---
>   hw/pci/trace-events         |   2 +-
>   9 files changed, 187 insertions(+), 106 deletions(-)
> ---
> base-commit: 7433709a147706ad7d1956b15669279933d0f82b
> change-id: 20240129-reuse-faae22b11934
> 
> Best regards,


