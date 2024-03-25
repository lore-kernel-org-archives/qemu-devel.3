Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11CECD11DC
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropcQ-0000p7-IR; Mon, 25 Mar 2024 15:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropcM-0000ob-W6
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:04:23 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropcK-0004lF-TM
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:04:22 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6b729669bso3882708b3a.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711393459; x=1711998259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y5Zto9K7udTq5AQPakgTtPCJCOiPmQtEfYiG7fTXVFs=;
 b=UZunfXKeRMJIOAWTh1CDGrDeyMcXUH0o8EgBp+UAhIs5Hhq3tgkn/C+RvVGfLAL40W
 jtOfQ/SSS5f9MLdsM1zPbGwWprqIZaBbbU4E0mGg7kOWdX/ZWz9ku9v4VLMhSnIA1+O5
 WEdtwM1CzNS4hIHh1XPeCs7Z7x6N3O4mSh/f6a8bp86THWGJJ86Y5Kl1pT0qSImcceM6
 bG8n85UXHbWJ4jRjyKXtIAuZMbJWuqcrsuWR75fL8NNt/fdncGhuvbn825rEGdCwHtGb
 3tjVWx1CP5MnD+NUp7fXVmxc0GW2wZGSzdDqH8aZEZtFB6CTPMM32dwbJmci5TNgRD9C
 msAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711393459; x=1711998259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y5Zto9K7udTq5AQPakgTtPCJCOiPmQtEfYiG7fTXVFs=;
 b=bd0KWNbpoPw3wos3dC8M/e+qv5PZXj8Xdi1FW4YNT4RgTeLnfBy5Ex5IIDkWuryP/o
 3fbxnA3sWWFDrLEI1kxO3xk5tTHierbZ3U1Q6LInlvZyTPzIcv4E562RVhqi+NqJoM4V
 +cri21nl0bhZ1o37NOVG8OR97JGcE6/GK3KRgblJuGSBIwiG5AlokI0Ntwb2UzCgkEFu
 LhToNHczE+tkIJwumqyipTIRNLLktMKzKq42tYevja+/DsXo0vXOLErwrTmoYUVeLzSS
 92J3X+AJxVd2PHgP6y5JIJPOCT1NZSEb+SeuCXQzAFwvh4jT3KVYRUwDi4wrYs3/8Lcy
 lIfg==
X-Gm-Message-State: AOJu0YyhJdeExoEjHBnTdugbMz8vz4SEhUb7HO26RFSMjNIXp1z0zt0i
 kMqh8higMe+8vNsdVWZOUai8TZ4atYGI+6gf0u8Bw7WBXiZGkdTqFVWykIrp
X-Google-Smtp-Source: AGHT+IGZShujGwOKxQ+nptAm5/rMbK7nM5xmkrnfnyDFXq5KsYB7EKXYKiCNBZkCJq9HAY7FI/XqIw==
X-Received: by 2002:a05:6a20:9147:b0:1a3:bdd6:efef with SMTP id
 x7-20020a056a20914700b001a3bdd6efefmr7683199pzc.50.1711393458627; 
 Mon, 25 Mar 2024 12:04:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 12:04:18 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v6 00/12] Enabling DCD emulation support in Qemu
Date: Mon, 25 Mar 2024 12:02:18 -0700
Message-ID: <20240325190339.696686-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Fan Ni <fan.ni@samsung.com>

A git tree of his series can be found here (with one extra commit on top
for printing out accepted/pending extent list): 
https://github.com/moking/qemu/tree/dcd-v6

v5->v6:
1. Picked up tags;
2. Renamed start_region_id to start_rid; (Jonathan)
3. For get extent list mailbox command, add logic to adjust returned extent
   count based on output payload size; (Jonathan)
4. Use Range to detect extent comparison and overlaps; (Jonathan)
5. Renamed extents_pending_to_add to extents_pending; (Jonathan)
6. Updated the commit log of the qmp interface patch by renaming "dpa" to offset
    to align with the code. (Gregory)
7. For DC extent add response and release mailbox command, we use a 2 pass
   approach. The first pass is to detect any potential errors, and the second
   pass to update the in-device data structure;
8. For QMP interface for add/release DC extents, use 2 pass approach with the
   first pass detecting any faulty input and second pass filling the event log.
   Note, based on sswg discussion, we disallow release extents which has DPA
   range not accepted by the host yet;
9. We enforce the in-order process of the pending list for DC extent release
   mailbox command, and the head of pending list is handled accordingly.
10. The last patch from v5 has been removed from this series.

Note: we do not drop the DC changes in build_dvsecs which was suggested
by Jonathan, the reason is that during testing, we found in the current
kernel code, when checking whether the media is ready
(in cxl_await_media_ready), the devsec range registers are checked, for
dcd device, if we leave dvsec range registers unset, the device cannot be
put into "ready" state, which will cause the device inactive.
The related code is below,
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/drivers/cxl/core/pci.c?h=fixes&id=d206a76d7d2726f3b096037f2079ce0bd3ba329b#n195

Compared to v5[1], PATCH 8-9 and PATCH 11-12 are almost re-coded, so need more
care when review.

The code is tested with similar setup and has passed similar tests as listed
in the cover letter of v5.
Also, the code passes similar tests with the latest DCD kernel patchset[2].

[1] Qemu DCD patches v5: https://lore.kernel.org/linux-cxl/20240304194331.1586191-1-nifan.cxl@gmail.com/T/#t
[2] DCD kernel patches: https://lore.kernel.org/linux-cxl/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com/T/#m11c571e21c4fe17c7d04ec5c2c7bc7cbf2cd07e3



Fan Ni (12):
  hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
    payload of identify memory device command
  hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
    and mailbox command support
  include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
    type3 memory devices
  hw/mem/cxl_type3: Add support to create DC regions to type3 memory
    devices
  hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
    size instead of mr as argument
  hw/mem/cxl_type3: Add host backend and address space handling for DC
    regions
  hw/mem/cxl_type3: Add DC extent list representative and get DC extent
    list mailbox support
  hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
    dynamic capacity response
  hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
    extents
  hw/mem/cxl_type3: Add dpa range validation for accesses to DC regions
  hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
  hw/mem/cxl_type3: Allow to release extent superset in QMP interface

 hw/cxl/cxl-mailbox-utils.c  | 644 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 580 +++++++++++++++++++++++++++++---
 hw/mem/cxl_type3_stubs.c    |  14 +
 include/hw/cxl/cxl_device.h |  67 +++-
 include/hw/cxl/cxl_events.h |  18 +
 qapi/cxl.json               |  61 +++-
 6 files changed, 1334 insertions(+), 50 deletions(-)

-- 
2.43.0


