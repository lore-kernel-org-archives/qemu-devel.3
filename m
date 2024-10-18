Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACB6D30019
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 16:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1pbQ-0003mb-L7; Fri, 18 Oct 2024 12:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1t1pbL-0003kw-DH
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:13:19 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1t1pbF-0004OD-GV
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:13:19 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b15416303aso113206985a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1729267990; x=1729872790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ngioInjflIeuk03TT5q8AniH0tXIsTkJB53uyQo/6Qo=;
 b=R1lwODvKwEAp34HIhJjG1DLtDJpcQnvYmPy4qdE/6Ob7M+JtYWHonr5YerDM2I/YRK
 tusnV8t4Z+ZMsZrrPGGw4LVsveTU9MyxYjX3NRAT9DU+1e5G3PvLsEBmXa2qDU8l2azl
 XkAza2q4o3lrHCfNW+3MEWYydW9DewvCRz1g8gDS4FBPcpZR/XzH5XhiB5F+z5oOUjHz
 W+jihOMXp5OyfpFcnnaybL+zy/waucz1ZDUrpcP7WpAX4xB/9JvN9MQSHHJYMoDOmYAn
 S7yRfl0g2UKzbtK9SsRuVPl9gQi/+U/AkCEbCzPrj7fVOo/UOdVpYRV2jO8v2eLyu41g
 V8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729267990; x=1729872790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ngioInjflIeuk03TT5q8AniH0tXIsTkJB53uyQo/6Qo=;
 b=kdLJTP+hGFfT0nSet57CR3CHdhYZM+EW1xCrTndeNSEDxgoAFvkHMgg8OGpVDwQB/F
 U3eTLkhHi4ZVSYodFPhi21/hgTVqOwjKT86EAaXqdyRpKTP9q/hhjvqDwSkuWDjPDQcM
 awv5UgHiGgzAIVgG3IgW9/O5xCDPVpdlC4YfDlHgDB7Zx+4TCHGy5F65hVDCL68HrFB/
 GrBzlWSSvdvDDgOURzTOhbH4zJ8Zvl4MUKEoGbl64TewZio280ssaR+SIj82RNBC9xoy
 uGD6IXB+izWvGWf7Rc0UDbbi0i2DL0otJH2u3fZcP6rEIXjXg20iWsUGXQ1InlUJmZoB
 m2XQ==
X-Gm-Message-State: AOJu0YyIzp+dH5DYFVxm84eojewH3xi9ufe/2tbOXcdgtUWNIgDxOxGM
 c2Rc90ReQxam5tldeDqRkmwt1qlgghGlde/Nncqc95XLY/iUjJjHyp1HA4iFHLY=
X-Google-Smtp-Source: AGHT+IHY5SQOsi749VokI/SC5N20+Gor9GxNzD5XoMRkvXOZrmI5mdWm1kkZQ5dxDrcjzVVApCxXdg==
X-Received: by 2002:a05:620a:4614:b0:7b1:4073:e8c9 with SMTP id
 af79cd13be357-7b157b5aae0mr360782385a.20.1729267989507; 
 Fri, 18 Oct 2024 09:13:09 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com
 (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b156fa55cfsm81677385a.67.2024.10.18.09.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 09:13:08 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, svetly.todorov@memverge.com,
 jonathan.cameron@huawei.com, nifan.cxl@gmail.com
Subject: [PATCH RFC v3 0/3] cxl: Multi-headed Single Logical Device (MHSLD)
Date: Fri, 18 Oct 2024 12:12:49 -0400
Message-ID: <20241018161252.8896-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

MHSLDs allow multiple hosts to access dynamic capacity on a single
backing device. This complicates DC management because adds,
removals, and accesses need to be vetted such that hosts don't
stomp on each other's data.

This patchset proposes a set of hooks to be called in cxl_type3.c
when each of the above events happens. The results of the hooks
can be used to prevent illegal DC operations in the corresponding
cxl_* functions. 

It also proposes an implementation for MHSLD emulation. The device's
state is stored in a shared memory-backed file (on Linux, under /dev/shm).
Extent ownership is tracked in a bytemap, wherein every byte acts
as a set of flags showing which host ID can access the extent at that
index. Blocks in an extent are claimed via compare-and-swap. Failure to
claim the entirety of an extent is treated as a failure; the host will
parse back over any blocks claimed so far and mask out its corresponding
ownership bit. Operations on block states are done via atomics. This
allows claims on unrelated extents to be serviced concurrently.

Block state is relegated to a u8 to conserve space.
Therefore only 8 heads are currently supported.

The MHSLD device inherits from the CXL_TYPE3 class and adds the following
configuration options:
--mhd-head=<u32>
--mhd-state_file=<str>
--mhd-init=<bool>

--mhd-head specifies the head ID of the host on the given device.

--mhd-state_file is the name of the shared-memory-backed file used
to store the MHD state.

--mhd-init indicates whether this QEMU instance should initialize
the state_file; if so, the instance will create the file if it does
not exist, ftruncate it to the appropriate size, and initialize its
header. It is assumed that the --mhd-init instance is run and allowed
to completely finish configuration before any other guests access the
shared state.

The shared state file only needs to be intialized once. Even if a guest
dies without clearing the ownership bits associated with its head-ID,
future guests with that ID will clear those bits in cxl_mhsld_realize(),
regardless of whether mhd_init is true or false.

The following command line options create an MHSLD with 4GB of
backing memory, whose state is tracked in /dev/shm/mhd_metadata.
--mhd-init=true tells this instance to initialize the file as
described above.

./qemu-system_x86-64 \
[... other options ...] \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
-object memory-backend-ram,id=mem0,size=4G \
-device cxl-mhsld,bus=rp0,num-dc-regions=1,volatile-dc-memdev=mem0,id=cxl-mem0,sn=66667,mhd-head=0,mhd-state_file=mhd_metadata,mhd-init=true \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G \
-qmp unix:/tmp/qmp-sock-1,server,nowait

Once this guest completes setup, other guests looking to access the
device can be booted with the same configuration options, but with
--mhd-head != 0,
--mhd-init=false,
and a different QMP socket.

The first patch in the series moves the CXLUpdateDCExtentListInPl
struct to a shared header. This allows DC-management code outside
of cxl_type3.c (like mhsld.c) to see which extents have been
accepted by a host in its DC-add response.

Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>

Changes in v3:
- rebase on 10_15_2024 branch, handle renaming issues
- dc->reset to legacy_reset update 

Changes in v2:
- remove explicit init_mhsld script
- implement remaining DC add/remove logic

---
Svetly Todorov (3):
  cxl-mailbox-utils: move CXLUpdateDCExtentListInPl into header
  cxl_type3: add MHD callbacks
  mhsld: implement MHSLD device

 hw/cxl/Kconfig              |   1 +
 hw/cxl/cxl-mailbox-utils.c  |  44 ++--
 hw/cxl/meson.build          |   1 +
 hw/cxl/mhsld/Kconfig        |   4 +
 hw/cxl/mhsld/meson.build    |   3 +
 hw/cxl/mhsld/mhsld.c        | 456 ++++++++++++++++++++++++++++++++++++
 hw/cxl/mhsld/mhsld.h        |  75 ++++++
 hw/mem/cxl_type3.c          |  17 ++
 include/hw/cxl/cxl_device.h |  24 ++
 9 files changed, 608 insertions(+), 17 deletions(-)
 create mode 100644 hw/cxl/mhsld/Kconfig
 create mode 100644 hw/cxl/mhsld/meson.build
 create mode 100644 hw/cxl/mhsld/mhsld.c
 create mode 100644 hw/cxl/mhsld/mhsld.h
---
base-commit: c4f85d1b04caf0a2baeccb13790da5e2a42fb0d9

-- 
2.43.0


