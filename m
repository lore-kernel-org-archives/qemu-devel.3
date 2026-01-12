Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D8EC9EC94
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfK5i-0001Js-O2; Mon, 12 Jan 2026 10:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vfK5f-0001F6-O4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:44:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vfK5d-0002Ev-Rd
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768232660;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MaAQbrB1F1h4vV74DnTU8Wozi2Qvnh6xelY2kHN3sCc=;
 b=TR6J1j6nDL+RLHln1kIO6tPs3K+I73GNRUZ39i4u7TwkzjtFAbHQYksBO2JR8oSqPYO5Ft
 2PxHCTDgJep545cO+zCFoS0yUf+JcxcOA4rfBq0Om/RWQhQPWP00ZO1nTSVv/CHzrJHE0R
 bv2GXgo1BzvoY8JpZqh5/Bo/Zdc0/aI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-nkdoP9IRNQC6I9gNcbVI8g-1; Mon, 12 Jan 2026 10:44:15 -0500
X-MC-Unique: nkdoP9IRNQC6I9gNcbVI8g-1
X-Mimecast-MFC-AGG-ID: nkdoP9IRNQC6I9gNcbVI8g_1768232654
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso51341225e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 07:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768232654; x=1768837454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaAQbrB1F1h4vV74DnTU8Wozi2Qvnh6xelY2kHN3sCc=;
 b=ayzB16zsm9hv3sz9J9OgfvSyVP3bbsVmtOCHeF6xNH6qq27W3/UiAilXfs3yNR7jTP
 3UQ2EukPRNlvOi/ZXicUsIWHdqPnDQzYMtoSM8HSuf+m7tUDJcgVS3wyzQ9Cs2Kei695
 P9MHEhXH+339MHfchctBAi2X0AbZ5LLFSPzBwYr5gFcjSRDvctYKQF/k6QFGTBHcu1d8
 CAj69ZOSjw7P/B+lK5wXBz4FR0RNEwcqKV5M7gAAZFcmlhE5MTzq7D9RUqn6644/8HnC
 9/WZXXDSuWHqtaSl73MADBKLMAwhn1cx4hMLfFV+d1RxUoGbQyzJv2rPmRXABXN9MSxh
 +8JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQXNmX0iXYZXF/+IAalRxPVpqmtn2k/caV0D2mxeiVAAUwfdqBddGsbGIxB9dzVAuRj8yJotiebc6W@nongnu.org
X-Gm-Message-State: AOJu0YymbnvFYjPoZ04BNG7Tz+Yi02IDj20Qyf3B/TlkHmBoKWi9m8sA
 Y98cRzLtVhbNlZVyl4wUtOuyHHLoei4mdSjPqlAjWZz8A8oO+lgRcTCnUEgm5UyQ9DU2eh3S5xU
 B5IRvnX08LVYEuCseRqW9kfSW7Qw6RdbkIduho6Z0BlCQDazvv3jw2NWI
X-Gm-Gg: AY/fxX6ziPFNS1JHdhrOGxVHPXq2XxmeYtWa7xJ2YXcZR/U/85FOOMMuQ3qaui5S9Ka
 J6z8+dY8Rz3VeOXa1eoohEiQGg4CBOlI3vQ+TTTg54NYtrvTcTUKj1sajXGbxki3LMcgq9a3s57
 IknUhCvO5TLbE+nF0X/TcbRnE8YIkPonj4CgafDtDzcvQxhAflpnUOEsmURuxh4hKpwhTMX2FgR
 eE0xCvjknO/iY3tuc2lvKIPQlGcVo5RD4Gbgxd17/DIW/QZPJ8U/SBottK0ezmRAt8FF0W4NqMD
 EpdioeULMasqaLgiV2lQ/ILTUTogayz+ysH6WqmjvpP49B7xP1fA6fF4BT3gMmB2wsY2WkRsXVR
 zmuMljfdiPPOt5F7dBGF+9MbhKysRSK6Jv8rV3hoHMr3637sEAjJXHHHSBw==
X-Received: by 2002:a05:600c:4ed0:b0:477:fcb:226b with SMTP id
 5b1f17b1804b1-47d84b1a29fmr193619745e9.2.1768232654198; 
 Mon, 12 Jan 2026 07:44:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl2Zy6zC9mXwnZ5WytaKepvXYh/+Eq7JLfczR1nTe0VtgRcWdg3CoiLHYuuZcI74DWMfDy1Q==
X-Received: by 2002:a05:600c:4ed0:b0:477:fcb:226b with SMTP id
 5b1f17b1804b1-47d84b1a29fmr193619395e9.2.1768232653715; 
 Mon, 12 Jan 2026 07:44:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm40298505f8f.22.2026.01.12.07.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 07:44:13 -0800 (PST)
Message-ID: <2a68c364-a046-4c5d-a2d1-2f02b1b89abf@redhat.com>
Date: Mon, 12 Jan 2026 16:44:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] hw/arm: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> Hi,
>
> This RFC series adds initial support for NVIDIA Tegra241 CMDQV
> (Command Queue Virtualisation), an extension to ARM SMMUv3 that
> provides hardware accelerated virtual command queues (VCMDQs) for
> guests. CMDQV allows guests to issue SMMU invalidation commands
> directly to hardware without VM exits, significantly reducing TLBI
> overhead.
>
> Thanks to Nicolin for the initial patches and testing on which this RFC
> is based.
>
> This is based on v6[0] of the SMMUv3 accel series, which is still under
> review, though nearing convergence.  This is sent as an RFC, with the goal
> of gathering early feedback on the CMDQV design and its integration with
> the SMMUv3 acceleration path.
>
> Background:
>
> Tegra241 CMDQV extends SMMUv3 by allocating per-VM "virtual interfaces"
> (VINTFs), each hosting up to 128 VCMDQs.
Can you add a reference to some specification documet please?
>
> Each VINTF exposes two 64KB MMIO pages:
>  - Page0 – guest owned control and status registers (directly mapped
>            into the VM)
>  - Page1 – queue configuration registers (trapped/emulated by QEMU)
>
> Unlike the standard SMMU CMDQ, a guest owned Tegra241 VCMDQ does not
> support the full command set. Only a subset, primarily invalidation
> related commands, is accepted by the CMDQV hardware. For this reason,
> a distinct CMDQV device must be exposed to the guest, and the guest OS
> must include a Tegra241 CMDQV aware driver to take advantage of the
> hardware acceleration.
Do I understand correctly that this Tegra241 CMDQV aware driveris
enabled by the CONFIG_TEGRA241_CMDQV on guest? Is it fully supported
upstream?

Eric
>
> VCMDQ support is integrated via the IOMMU_HW_QUEUE_ALLOC mechanism,
> allowing QEMU to attach guest configured VCMDQ buffers to the
> underlying CMDQV hardware through IOMMUFD. The Linux kernel already
> supports the full CMDQV virtualisation model via IOMMUFD[0].
>
> Summary of QEMU changes:
>
>  - Integrated into the existing SMMUv3 accel path via a
>    "tegra241-cmdqv" property.
>  - Support for allocating vIOMMU objects of type
>    IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.
>  - Mapping and emulation of the CMDQV MMIO register layout.
>  - VCMDQ/VINTF read/write handling and queue allocation using IOMMUFD
>    APIs.
>  - Reset and initialisation hooks, including checks for at least one
>    cold-plugged device.
>  - CMDQV hardware reads guest queue memory using host physical addresses
>    provided through IOMMUFD, which requires that the VCMDQ buffer be
>    physically contiguous not only in guest PA space but also in host
>    PA space. When Tegra241 CMDQV is enabled, QEMU must therefore only
>    expose a CMDQV size that the host can reliably back with contiguous
>    physical memory. Because of this constraint, it is suggested to use
>    huge pages to back the guest RAM.
>  - ACPI DSDT node generation for CMDQV devices on the virt machine.
>
> These patches have been sanity tested on NVIDIA Grace platforms.
>
> ToDo / revisit:
>  - Prevent hot-unplug of the last device associated with vIOMMU as
>    this might allow associating a different host SMMU/CMDQV.
>  - Locking requirements around error event propagation.
>
> Feedback and testing are very welcome.
>
> Thanks,
> Shameer
> [0] https://lore.kernel.org/qemu-devel/20251120132213.56581-1-skolothumtho@nvidia.com/
> [1] https://lore.kernel.org/all/cover.1752126748.git.nicolinc@nvidia.com/
>
> Nicolin Chen (12):
>   backends/iommufd: Update iommufd_backend_get_device_info
>   backends/iommufd: Update iommufd_backend_alloc_viommu to allow user
>     ptr
>   backends/iommufd: Introduce iommufd_backend_alloc_hw_queue
>   backends/iommufd: Introduce iommufd_backend_viommu_mmap
>   hw/arm/tegra241-cmdqv: Add initial Tegra241 CMDQ-Virtualisation
>     support
>   hw/arm/tegra241-cmdqv: Map VINTF Page0 into guest
>   hw/arm/tegra241-cmdqv: Add read emulation support for registers
>   system/physmem: Add helper to check whether a guest PA maps to RAM
>   hw/arm/tegra241-cmdqv:: Add write emulation for registers
>   hw/arm/tegra241-cmdqv: Add reset handler
>   hw/arm/tegra241-cmdqv: Limit queue size based on backend page size
>   hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in DSDT
>
> Shameer Kolothum (4):
>   hw/arm/tegra241-cmdqv: Allocate vEVENTQ object
>   hw/arm/tegra241-cmdqv: Read and propagate Tegra241 CMDQV errors
>   virt-acpi-build: Rename AcpiIortSMMUv3Dev to AcpiSMMUv3Dev
>   hw/arm/smmuv3: Add tegra241-cmdqv property for SMMUv3 device
>
>  backends/iommufd.c        |  65 ++++
>  backends/trace-events     |   2 +
>  hw/arm/Kconfig            |   5 +
>  hw/arm/meson.build        |   1 +
>  hw/arm/smmuv3-accel.c     |  16 +-
>  hw/arm/smmuv3.c           |  18 +
>  hw/arm/tegra241-cmdqv.c   | 759 ++++++++++++++++++++++++++++++++++++++
>  hw/arm/tegra241-cmdqv.h   | 337 +++++++++++++++++
>  hw/arm/trace-events       |   5 +
>  hw/arm/virt-acpi-build.c  | 110 +++++-
>  hw/vfio/iommufd.c         |   6 +-
>  include/exec/cpu-common.h |   2 +
>  include/hw/arm/smmuv3.h   |   3 +
>  include/hw/arm/virt.h     |   2 +
>  include/system/iommufd.h  |  16 +
>  system/physmem.c          |  12 +
>  16 files changed, 1332 insertions(+), 27 deletions(-)
>  create mode 100644 hw/arm/tegra241-cmdqv.c
>  create mode 100644 hw/arm/tegra241-cmdqv.h
>


