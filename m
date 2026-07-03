Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9404CC43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfYxC-0006qn-LN; Fri, 03 Jul 2026 04:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wfYxB-0006qe-UI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:08:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wfYx7-000465-LP
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783066127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AQqLvN1K5Wdx8+KMImMvFdBuSSb/COCau+9Px6I6qc8=;
 b=AmeCi6JxCjGingMgtxdWsnVJT0C0XR6LgDZCkFPphFF1+9h/n0CdK8JsQD7RqjihWjbG7O
 vWTCKvECLjNPDx2eI1OsVQt0IZNq1ry+5dee5HOcr7l70EgmDvMxuMTdPPmOlGD4ebkOsA
 STRdop1niGgFhbwlJaGS9rky/AsAPLc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-0v_uu92OPXK93pWJatx3kg-1; Fri, 03 Jul 2026 04:08:46 -0400
X-MC-Unique: 0v_uu92OPXK93pWJatx3kg-1
X-Mimecast-MFC-AGG-ID: 0v_uu92OPXK93pWJatx3kg_1783066125
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493bab443f7so3500445e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783066125; x=1783670925; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AQqLvN1K5Wdx8+KMImMvFdBuSSb/COCau+9Px6I6qc8=;
 b=IKgA0/O7sKLdwGeEydO7jf5FTuuWo2LlJIiJmdqCihbYLIWyBOURkIToHZSZJuN8zB
 +Hrsm+Z/XENK1sl4eLOCR0ruB3tEqbLWKLmYyEfP14hYn0Lg7CYiRSSecM2VVlijPAZ4
 5Wp7atF46ERwAdAuonGvGtvy09NlT01b12A53r8KItB2Ut1cIWpJvn9fOqAxtY6IJtJt
 Lm6syA6VNeGjPSYQ+GuWi5yeS2IgJD/U86DIX3g/uyaAo4PUUZBFqeOon87EaoktrZ/z
 Grhs1707gs1M7fZ9W0JZYS31xz15LbJxFpjY9q7cHBJ5pFN/LEBggOZWti/ILKjFkcMS
 MmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783066125; x=1783670925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AQqLvN1K5Wdx8+KMImMvFdBuSSb/COCau+9Px6I6qc8=;
 b=leNNLM7CRo54rUCXBkNN2mdKhxVrNDhIfpGiD0EqMUVN5joyGfQwvcnCyt20j6plwd
 oJKYY21SfZQc5kf2kmvw2ZyO3FJqyN+NpYXbHXv8QH6nwGH0eEEstJNQWEqhyOlQBHCB
 VEPZjgRruEXbCKMp3EYvLs/YgQWaGck05MFlJKfroCoNrYej/ulg6pRBcEZB13sD26h0
 hJtv49ow+pef930smX6/qASRnw+mBKXZvGQgF9PkRhI0pDeOlP1VS2X69JeTiMbtEAbx
 DQXj9S1bzzgqE3GM2xsHjPFacXcGZMt/te/s81pBW0CLMTZtrnYxu71yqdHz5/zCGIvv
 0d0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Kx+QA94yh/NLjWCyLlX5AIVBeOq2uXGbgA63sLvRWj3nsxizm8RPcgbCbEcEsfY3/FMOJPCC/If7e@nongnu.org
X-Gm-Message-State: AOJu0YylPPzzmBFxQV+/52JRmHsl8clynxbth96HxrvoOE4g0kWVN9lY
 IfpNS4KNwuBKDtQpIs0WnY+RsVQcQewAqHHSWFlmiWzHrP3M2al7dPbrtd0xZtZhmzNkEVh8oE1
 oumwaG9peBzdOOszs9ZMo3EE6rTMO9fYZaK8BwpWpP0/EEiiOudhBUfn2
X-Gm-Gg: AfdE7ckGeqCvZIaVORXbS401G/t37dIpcDE0uzGHfswn0oiFefQNFpDYUBWaEX3eYhA
 a7W2vHlq0jjrl+t6et4c6kpUA6n+hODnjJ8oXZzKi3ZaOiHjaPlj3tuM4dE042O0wUPmZpovSL5
 vAvXBJtRX1LFjdKZgLkih8cQE6GuAS2G0WPV37IXnXUBatqwP+YNde7GmIaL+atiULyEq8BHeDi
 AhmHth6S5WT6DGOy29PxDP5jjZaAVVvO2TIrG49Usv6f5JT7r01/HNbf0rhZGl2eEIHHQB3Klv/
 cxY8H5kzaWHSx4Em9sgnYCE6rHrWrLyLX6GRFJ89zS2Moh/I8P9BoaZ6sIVX1srxwR5UGYOFYM3
 PckI=
X-Received: by 2002:a05:600c:a4a:b0:493:c991:8e56 with SMTP id
 5b1f17b1804b1-493c9b44867mr41538145e9.4.1783066124528; 
 Fri, 03 Jul 2026 01:08:44 -0700 (PDT)
X-Received: by 2002:a05:600c:a4a:b0:493:c991:8e56 with SMTP id
 5b1f17b1804b1-493c9b44867mr41537615e9.4.1783066123948; 
 Fri, 03 Jul 2026 01:08:43 -0700 (PDT)
Received: from redhat.com ([64.238.204.142]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef11338sm184044795e9.1.2026.07.03.01.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 01:08:43 -0700 (PDT)
Date: Fri, 3 Jul 2026 04:08:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 david@kernel.org, gourry@gourry.net, philmd@mailo.com,
 berrange@redhat.com, peterx@redhat.com, Zhigang.Luo@amd.com,
 Lianjie.Shi@amd.com
Subject: Re: [PATCH v14 00/10] hw/mem: add sp-mem device for Specific Purpose
 Memory
Message-ID: <20260703040821-mutt-send-email-mst@kernel.org>
References: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
 <20260625163444.23b168ac@imammedo>
 <2117d301-4f7f-4f5a-a744-ec2422aacc7d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2117d301-4f7f-4f5a-a744-ec2422aacc7d@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 03, 2026 at 10:28:06AM +0800, Huang, FangSheng (Jerry) wrote:
> 
> 
> On 6/25/2026 10:34 PM, Igor Mammedov wrote:
> > On Tue, 23 Jun 2026 15:50:41 +0800
> > fanhuang <FangSheng.Huang@amd.com> wrote:
> > 
> > > This series adds a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
> > > SOFT_RESERVED guest memory, following the direction from the v7
> > > thread [1] and the v8 / v9 / v10 / v11 / v12 / v13 reviews
> > > [2][3][4][5][6][7].
> > 
> > review is done at this point,
> > I guess Michael will take it via his tree.
> > 
> 
> Hi Michael,
> 
> All patches now carry Reviewed-by / Acked-by. Would it be possible to
> queue this for the 11.1 soft freeze (7/7)?
> 
> Best regards,
> FangSheng Huang (Jerry)


Working on it, thanks!

> > > 
> > > Background
> > > ----------
> > > 
> > > This series targets coherent CPU + accelerator shared-address-space
> > > systems, where the accelerator's HBM is not a device-private
> > > framebuffer behind a PCIe BAR but a tier of host system memory:
> > > visible to the CPU in the platform physical address space, shared
> > > coherently with the accelerator over the platform fabric, and bound
> > > to a NUMA proximity domain set by platform firmware at boot fabric
> > > training.
> > > 
> > > For such a region to function correctly in the guest, two things
> > > must hold simultaneously: the CPU memory subsystem has to see it in
> > > the system memory map (so the CPU side can address it), and it has
> > > to be reserved exclusively for the accelerator's driver (so the
> > > kernel's general allocator does not hand SPM pages to unrelated
> > > workloads). The SOFT_RESERVED memory type in E820 plus a matching
> > > SRAT memory-affinity entry is the mechanism that delivers both: a
> > > firmware-produced topology that the CPU memory subsystem honors and
> > > the accelerator's driver consumes for its own range.
> > > 
> > > Approach
> > > --------
> > > 
> > > The series introduces a new TYPE_MEMORY_DEVICE subclass `sp-mem`.
> > > Each instance binds one host memory backend to a single NUMA
> > > proximity domain and is boot-time only; placement, mapped-state
> > > enforcement, and QMP introspection come from the existing
> > > memory-device framework.
> > > 
> > > Testing
> > > -------
> > > 
> > > Verified end-to-end on q35 + KVM, with both SeaBIOS and OVMF, for:
> > > 
> > > - single sp-mem instance
> > > - two sp-mem instances on different NUMA nodes
> > > 
> > > Guest observations: /proc/iomem shows one SOFT_RESERVED entry per
> > > sp-mem device, dmesg SRAT parsing reports the matching
> > > memory_affinity entries with correct PXM, and the umbrella
> > > HOTPLUGGABLE entry covers the remaining hotplug-memory window
> > > without overlapping the sp-mem ranges.
> > > 
> > > In-tree coverage: a bios-tables-test case validates the SRAT
> > > partition for two sp-mem devices on distinct nodes, and an e820
> > > fw_cfg test checks the SOFT_RESERVED range.
> > > 
> > > Changes since v13
> > > -----------------
> > > 
> > >    - qapi: note that SpMemDeviceInfo's @size is in bytes.
> > >    - pc: fix the indentation of the pc_sp_mem_plug() continuation line.
> > >    - Collected the Reviewed-by / Acked-by tags from the v13 review.
> > > 
> > > Previous versions
> > > -----------------
> > > 
> > >    v1: https://lore.kernel.org/qemu-devel/20250924103324.2074819-1-FangSheng.Huang@amd.com/
> > >    v2: https://lore.kernel.org/qemu-devel/20251020090701.4036748-1-FangSheng.Huang@amd.com/
> > >    v3: https://lore.kernel.org/qemu-devel/20251208105137.2058928-1-FangSheng.Huang@amd.com/
> > >    v4: https://lore.kernel.org/qemu-devel/20251209093841.2250527-1-FangSheng.Huang@amd.com/
> > >    v5: https://lore.kernel.org/qemu-devel/20260123024312.1601732-1-FangSheng.Huang@amd.com/
> > >    v6: https://lore.kernel.org/qemu-devel/20260226105023.256568-1-FangSheng.Huang@amd.com/
> > >    v7: https://lore.kernel.org/qemu-devel/20260306082735.1106690-1-FangSheng.Huang@amd.com/
> > >    v8: https://lore.kernel.org/qemu-devel/20260527074215.229119-1-FangSheng.Huang@amd.com/
> > >    v9: https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/
> > >    v10: https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/
> > >    v11: https://lore.kernel.org/qemu-devel/20260611100637.2460507-1-FangSheng.Huang@amd.com/
> > >    v12: https://lore.kernel.org/qemu-devel/20260616090808.3047939-1-FangSheng.Huang@amd.com/
> > >    v13: https://lore.kernel.org/qemu-devel/20260619111136.3481329-1-FangSheng.Huang@amd.com/
> > > 
> > >    [1] v7 thread closeout:
> > >        https://lore.kernel.org/qemu-devel/666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com/
> > >    [2] v8 review:
> > >        https://lore.kernel.org/qemu-devel/20260601105057.2d764e55@imammedo/
> > >    [3] v9 review:
> > >        https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/T/
> > >    [4] v10 review:
> > >        https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/T/
> > >    [5] v11 review:
> > >        https://lore.kernel.org/qemu-devel/20260611100637.2460507-1-FangSheng.Huang@amd.com/T/
> > >    [6] v12 review:
> > >        https://lore.kernel.org/qemu-devel/20260616090808.3047939-1-FangSheng.Huang@amd.com/T/
> > >    [7] v13 review:
> > >        https://lore.kernel.org/qemu-devel/20260619111136.3481329-1-FangSheng.Huang@amd.com/T/
> > > 
> > > fanhuang (10):
> > >    hw/mem: add sp-mem device for Specific Purpose Memory
> > >    qapi, hmp: introspection for the sp-mem device
> > >    i386/acpi-build: partition device_memory SRAT umbrella for sp-mem
> > >    hw/i386: hook sp-mem into the pc machine plug path
> > >    MAINTAINERS: cover sp-mem under Memory devices, add R: tag
> > >    tests/acpi: add empty expected blobs for sp-mem SRAT test
> > >    tests/acpi: add bios-tables-test case for sp-mem
> > >    tests/acpi: generate expected blobs for sp-mem SRAT test
> > >    tests/qtest: add e820 fw_cfg test
> > >    tests/qtest: cover sp-mem SOFT_RESERVED e820 entry
> > > 
> > >   MAINTAINERS                        |   3 +
> > >   qapi/machine.json                  |  43 +++++++++-
> > >   hw/i386/e820_memory_layout.h       |  11 +--
> > >   include/hw/mem/sp-mem.h            |  33 ++++++++
> > >   hw/core/machine-hmp-cmds.c         |  11 +++
> > >   hw/i386/acpi-build.c               |  96 ++++++++++++++++++++-
> > >   hw/i386/pc.c                       |  36 ++++++++
> > >   hw/mem/sp-mem.c                    | 128 ++++++++++++++++++++++++++++
> > >   tests/qtest/bios-tables-test.c     |  21 +++++
> > >   tests/qtest/e820-test.c            | 129 +++++++++++++++++++++++++++++
> > >   hw/i386/Kconfig                    |   2 +
> > >   hw/mem/Kconfig                     |   4 +
> > >   hw/mem/meson.build                 |   1 +
> > >   tests/data/acpi/x86/q35/DSDT.spmem | Bin 0 -> 9910 bytes
> > >   tests/data/acpi/x86/q35/SRAT.spmem | Bin 0 -> 384 bytes
> > >   tests/qtest/meson.build            |   1 +
> > >   16 files changed, 508 insertions(+), 11 deletions(-)
> > >   create mode 100644 include/hw/mem/sp-mem.h
> > >   create mode 100644 hw/mem/sp-mem.c
> > >   create mode 100644 tests/qtest/e820-test.c
> > >   create mode 100644 tests/data/acpi/x86/q35/DSDT.spmem
> > >   create mode 100644 tests/data/acpi/x86/q35/SRAT.spmem
> > > 
> > > 
> > > base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> > 


