Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7E606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rw0uwYR9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYz0-00058j-JF; Thu, 12 Nov 2026 12:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1xRYyy-00058H-Ja
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:53:08 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1xRYyv-00022r-JI
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:53:08 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-483a66818edso23724fac.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794505979; x=1795110779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F2YnP0s7EXjVFhqc1+OhYJjUXanL7Ulcltk2cgVR7UY=;
 b=rw0uwYR9CsBeBTEN5foML1cHY9Vr7ywJfxvPDugVOTxnTCzP3NtUs5XXg1uxU9aCbA
 IP9TQRXsKJ6A/ZviRCIw4klmo+b+ARFk35oeFd2V9ZN+Td+zdW+lKaBC919rhB7tnm30
 yDc8R/xqn4LetHXjh0iMrDFohZPb4c0thY2qA+uY5yxHzCDot3Jy/4DrrE8+LAozvZl5
 9J01TqJukRNHqQgd7VzWNMml6n+TG1zQDXJqV7nLRDIF2sCQqInajDR/L3aU++cVQogI
 bR5Y6daPMJNiP6+44f07uZCEdc2Ltqnzlqt1j6ftCPhpP99azv2B18WuR3ein9uk8FSg
 mMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505979; x=1795110779;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F2YnP0s7EXjVFhqc1+OhYJjUXanL7Ulcltk2cgVR7UY=;
 b=fq1hhGmZbADVFu68/TB83Rnv2zRD/aAEEi97CFYPDy25kdwR5LeftqsItZGkz/kKgb
 NUiPBJvTyeXpJPGeX9Ej1pc0KGChvoGUa4FHaFUvAKvSrM5cZ1kmbq+tGcE1ZKdOlfxH
 IiQ/5DeiVC8yo+wIR8wmmlLaziEuttx6dlx4yMn6XN+5ZJyGEFMhp++QfejwrwrDTuLf
 ejv22Lj1NMZMFaqf02chBCpWdxm++sPp53hzuE0XaVFNInkC0TAyDrXWaRyNvHOFe+qm
 JBoP8eKBn1E5VNqOl/gbPzGgJKXkQUzXduL5xbH0KaOJb4WhqqhMjnJA6iPpA4ww1j8p
 YaYQ==
X-Forwarded-Encrypted: i=1;
 AL+hErESIq02hofK62BafVCI3m6o+m6Y4R3LRZ53cacbeeazQ/bJAZmib8Q8+XhPuRPe3s/pptpPiBuFeE9A@nongnu.org
X-Gm-Message-State: APuU4Z/1YCPACrg/s+yG2VMv3+EepU1TVq27FdlZP2YfMSi6mCUVixD3
 uylipTYD8iGLsLOSm/p0BxxOL2XvfT+KlFHHsA3AOUw8aKRTPG2T7vY+
X-Gm-Gg: AYBFou0qghDx+CDKEqXTvGPdVnERz2GDmLX+UGvK3tzVGEYDb+n0TzdrOwnK+MmBRjH
 qaghyVKpPHKMh4FGAVzkiDbhcIsYPerWM47zAyyVNKSs1vFi7aJS3oZbaqiDfAAtFFux6nyAjtC
 9E9Qq8pZv5mA5+eB8g6xyDGo0apUauUvMYPmlf5jfSGc50oEZ1v8REsc3AjysfeFWGNIHjOazeU
 NA8kQrTZQ3uuJmDbDj3Gh7vD/mjLsvGHGfOlGmsXotMQnQX6wgE1N+SJanlc567zrxsZOFw34iP
 HMUhbNlURWwxqwD7R5tO33QZkrnG9G+3W3j06n9HZ1OFivaROElHRAxHV/VsED0VwbdCYbKuaCu
 sYs1P5y3JdDMb+24eo20lRLNiWYYSTq1OWqkh0t4oE3CISmOweeXAzZ54b+/xUJcrn6JdO+7jDT
 2L17yUX5JL4g3Qv+n0PDufZ2RSEknKzZwocxF76DHDwtE5XxAtMxb9cOUV6Nvw+whX6syuQ9cYD
 xr5cha21MqWyrhULttsA5Pt329hr3bBSgLvFKPARUXaMhylLFPjMpL5/PBXVcyumCgcm5RM7reU
 d20JU6k6awYfWZ91NN++DyQnAjXilgp1PpEk
X-Received: by 2002:a05:6870:9f11:b0:494:76db:2aa8 with SMTP id
 586e51a60fabf-4afdf191441mr400506fac.5.1794505979154; 
 Thu, 12 Nov 2026 09:52:59 -0800 (PST)
Received: from [172.31.11.98] ([209.52.143.85])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae22f6a1aesm6023059fac.4.2026.11.12.09.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 09:52:58 -0800 (PST)
Message-ID: <fd4eaf33-363b-4f14-88d6-9723d1bf0f16@gmail.com>
Date: Thu, 12 Nov 2026 10:52:54 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/18] hw/cxl: Add a CXL Type-2 device
To: mhonap@nvidia.com, jic23@kernel.org, alwilliamson@nvidia.com,
 clg@redhat.com, xueshuai@linux.alibaba.com, ira.weiny@intel.com,
 zhiw@nvidia.com, mst@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 junjie.cao@linux.dev, anisa.su@samsung.com, pbonzini@redhat.com,
 ankita@nvidia.com, vsethi@nvidia.com, skolothumtho@nvidia.com,
 mochs@nvidia.com, Weqaar Janjua <weqaar.janjua@packetfive.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: cjia@nvidia.com, kjaju@nvidia.com, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
References: <20261106035911.1280066-1-mhonap@nvidia.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20261106035911.1280066-1-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/05 20:58, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> Hello,
> 
> This series adds cxl-type2, an emulated CXL Type-2 device with volatile
> device memory. It is emulated in such a way that all the Linux checks
> are satisfied so that CXL passthrough using vfio-pci (vfio-cxl) can be
> developed and tested in a guest without Type-2 hardware.
> 
> This series builds on the Type-2 model from Zhi's series (carried in
> Cédric's tree) and carries one fix from Shuai's tree. Shuai's tree also
> set up the decoders through device properties and stubbed CXL Reset; the
> firmware setup and CXL Reset here are new code.
> Carried patches keep their authors, with a note for each change.
> 
> The device:
> - PCI ID 1b36:0017 and the processing accelerator class 0x1200;
> - PCIe DVSEC for CXL Devices with CXL.cache, CXL.mem, one HDM range,
>    cache write-back and invalidate, CXL Reset and Mem Clr; Register
>    Locator and Flex Bus Port DVSECs;
> - CXL.cache advertised but not modelled. The device sends no CXL.cache
>    requests, and its memory is host RAM, which is coherent already. A
>    cache write-back and invalidate completes at once. The capability is
>    set because vfio-cxl takes a device as Type-2 only when it reports
>    both CXL.cache and CXL.mem;
> - component registers with one HDM decoder;
> - slot 0, function 0 below a CXL root port of a pxb-cxl, memory in one
>    fixed memory window selected with fmw-index, cold plug only (no
>    hotplug or unplug), not migratable.
> 
> No Linux driver claims the device on its own. cxl_pci does not bind to
> the accelerator class, and sfc, the other driver that calls the CXL
> core Type-2 interface, matches only its own devices. A guest binds
> cxl-type2 to vfio-pci, which hands it to vfio-cxl. Testing the CXL core
> Type-2 interface without vfio-cxl needs a driver for 1b36:0017 that
> calls it. There is none yet.
> 
> QEMU has no firmware that commits the HDM decoders of a CXL route at
> boot, and Linux attaches a Type-2 device only to a committed region
> (devm_cxl_probe_mem()). So QEMU does that step itself. cxl-type2
> registers its range with its pxb-cxl at realize (patch 13). At every
> reset the pxb-cxl commits HDM decoder 0 for it (patch 12), and the
> device commits its own decoder with Lock On Commit and enables
> CXL.cache, CXL.mem and HDM decoding (patch 14). A pxb-cxl with a
> registered range keeps its HDM decoder even with a single root port,
> where it would otherwise pass accesses through. Type-3 devices, and
> pxb-cxl without a registered range, are not affected.
> 
> A CXL Reset keeps the locked decoder committed, as RWL fields are not
> affected by CXL Reset once locked (CXL r4.0 Table 8-1). DVSEC Control,
> the range bases and HDM Decoder Global Control return to their
> defaults, which leaves Mem_Enable and HDM Decoder Enable at 0. While
> either is 0 the device drops CXL.mem, so guest accesses to its memory
> fail until software sets both bits again. The CXL.io part of the reset
> is not emulated. CONFIG_LOCK makes the RWL DVSEC fields read only until
> a system reset.
> 
> Patches:
> - 1-7:   Shared CXL code: read-0 ops for the CXL.io range of the
>           component registers, helpers from Zhi, an HDM decoder count,
>           DVSEC bit names, a device-neutral view for the direct mapping
>           code, PCI IDs;
> - 8-17:  The device; patch 16 also exports the default component
>           register write handling, so the device can check the enable
>           bits after a write;
> - 18:    Docs;
> 
> Left for later series:
> - The CXL device registers with the mailbox, event logs and MSI-X, and
>    the CDAT;
> - Direct mapping lifecycle fixes for Type-3 and switch topologies, and
>    Lock On Commit in host bridges and switches;
> - Fixes for guest-triggered aborts on 1 and 2 byte mailbox writes and a
>    repeated DOE Go;
> - Software-programmed decoders, for Linux-created Type-2 regions;
> - A Type-2 device below a CXL switch, and migration.
> 
> Testing:
> - Build every commit for x86_64 and aarch64, checkpatch for style.
> - vfio-cxl selftest (vfio_cxl_type2_test) in an Arm L1 guest on KVM,
>    with the device below a CXL root port and an SMMUv3: 19 of 19 pass
> 
> - Not tested: x86_64 L1, a build without CONFIG_CXL_TYPE2_DEVICE.
> 
> The Linux vfio-cxl series(v5) this was tested with:
> https://lore.kernel.org/r/20260916183540.3813685-1-mhonap@nvidia.com
> 
> Sent as RFC to get comments on the series structure and to request
> 1b36:0017 devid for cxl-type2 device allocation.

Note: that device ID has already been requested for a device called 
CnuasNIC:

("[PATCH v3 0/6] hw: Add Cnuas virtual devices")
https://lore.kernel.org/qemu-devel/20260929202358.725310-1-weqaar.janjua@packetfive.com/

Regards,
Akihiko Odaki

> 
> References:
> [PATCH RFC 0/5] hw/cxl: Type 2 Device RFC
> https://lore.kernel.org/linux-cxl/20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com/
> 
> Type-2 emulation trees:
> 
> [1] Zhi Wang
> https://github.com/zhiwang-nvidia/qemu/commits/zhi/qemu-type2-emulation-for-review
> 
> [2] Cédric Le Goater
> https://github.com/legoater/qemu/tree/cxl-type2
> 
> [3] Shuai Xue
> https://gitee.com/axiqia/qemu-kvm/tree/cxl-type2-test
> 
> Manish Honap (12):
>    hw/cxl: Make HDM decoder initialization count-aware
>    hw/cxl: Define the CXL Device DVSEC capability and control bits
>    hw/cxl: Find the memory of a CXL device through one helper
>    hw/pci: Add PCI IDs for the CXL Type-2 device
>    hw/mem: Require a CXL root port of a pxb-cxl for cxl-type2
>    hw/pci-bridge: Add firmware HDM decoder state to pxb-cxl
>    hw/mem: Bind cxl-type2 to a fixed memory window
>    hw/mem: Commit the cxl-type2 HDM decoder at reset
>    hw/mem: Add CXL.cache with cache write-back and invalidate to
>      cxl-type2
>    hw/mem: Implement CXL Reset for cxl-type2
>    hw/mem: Clear the cxl-type2 volatile memory on a CXL Reset request
>    docs/cxl: Document the CXL Type-2 device
> 
> Shuai Xue (1):
>    hw/cxl: Give the component register .io sub-region read-0 ops
> 
> Zhi Wang (5):
>    hw/cxl: Factor out cxl_host_addr_to_dpa()
>    hw/cxl: Introduce cxl_component_update_dvsec()
>    hw/cxl: Introduce CXL type-2 device emulation
>    hw/cxl: Add the CXL type-2 DVSECs and component registers
>    hw/cxl: Map the CXL type-2 device memory through the fixed windows
> 
>   MAINTAINERS                             |   1 +
>   docs/specs/pci-ids.rst                  |   2 +
>   docs/system/devices/cxl.rst             |  68 +++
>   hw/cxl/cxl-component-utils.c            | 227 +++++++++-
>   hw/cxl/cxl-host.c                       | 130 ++++--
>   hw/mem/Kconfig                          |   5 +
>   hw/mem/cxl_type2.c                      | 580 ++++++++++++++++++++++++
>   hw/mem/cxl_type2_stubs.c                |  20 +
>   hw/mem/cxl_type3.c                      |  68 +--
>   hw/mem/meson.build                      |   2 +
>   hw/pci-bridge/pci_expander_bridge_cxl.c |  27 +-
>   include/hw/cxl/cxl.h                    |   1 +
>   include/hw/cxl/cxl_component.h          |  26 ++
>   include/hw/cxl/cxl_device.h             |  27 ++
>   include/hw/cxl/cxl_pci.h                |  31 ++
>   include/hw/pci/pci.h                    |   1 +
>   include/hw/pci/pci_bridge.h             |   6 +
>   include/hw/pci/pci_ids.h                |   3 +
>   18 files changed, 1102 insertions(+), 123 deletions(-)
>   create mode 100644 hw/mem/cxl_type2.c
>   create mode 100644 hw/mem/cxl_type2_stubs.c
> 
> 
> base-commit: f71afb409a87c4ecd0f9d63a5963eb645dfab780


