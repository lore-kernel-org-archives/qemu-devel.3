Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B77C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 23:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNKEG-0000LW-CE; Thu, 05 Jun 2025 19:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEF-0000LF-8m
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:35 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKED-0004fr-8S
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:35 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so1391987b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 16:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749166951; x=1749771751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aS7/2pgQjaGIOkdRt5swxrbQrIIOnIX9dYGmTh+yU1s=;
 b=czD3QTMeSpNL1vzzqGVNejwplppT3c0E/CcRL2Duda+uxRk7LwoQFQx7Ft3FQ2sWO7
 sJv3rW8O6jVbymCXSng3GjmxSfuZCzCvWU2qCI3LbmlPiiv3hf92gWocLVdG+Ic7rw5J
 jW7RpF2dNwGA9mzU3xOkd2z/WhAeRc46jZVCzz8kdreOdlWVE1c/kTsCIOCowIJJCq7h
 rZMDsEEXRiUmBlSNGx6/JwvjJnrfQYfIhDMRAyQnNm9yjCD5dhFFpBHTelomPIBOmScM
 N22QtGj3bRzJ0BTd0ayaEmJe0wEvxz+Qm4Mm9KBZFuxnuFyvlotNO2oZh/PBBP+YwiGu
 i3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749166951; x=1749771751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aS7/2pgQjaGIOkdRt5swxrbQrIIOnIX9dYGmTh+yU1s=;
 b=nIL2aBo2AbbpVyoDWFXkiR7V20li9e62PI4RhGwwWY+U4W0YDd3AX812VxM7m3X+jt
 f8mbjBi2S/hTfJBvqjLjKAE0zvJXUD2i9V5r4DkIPuxhfZt4QynVNBsax5rTbcDRnEp8
 4qCMLUEw9IA0gdj0neQ7EXYVwS+hsmIS6vrRxS/ncA4C6IlBPO2MwpJtf2OJAQxU43hC
 9e1qfYhIQWlA+08ff3K/S82JxkXHgtI/1nhpPTSwb9OG+h3wnJP7keGaNkyAZdB1xcIW
 YziJ4At/osniVruCS+bfF3f4hzgJgYRrkMaCVlV+FfleYgqNG4Ovvg897UcqzoL5Tnl9
 IlIQ==
X-Gm-Message-State: AOJu0Yw8hxkDMNsXrDfXJMoXoakv8rC/65skoP1BCmu3u6TpFCoTDXpz
 baulUl2k/l1bHH9+wpQZNQG+sV0fKZMXUKNIwSDpPktYsIKB7djf9KxdvWfdGg==
X-Gm-Gg: ASbGncvBbty/v/pOqBm1CQHTPGfc0IUIgEYk6eBG/FqOnqjnQc/7E8lnNI/ag9se6NZ
 rzYjaSJDabZkxTfwigKtCM4YGmX/qtqsno7bASPYiipbftfw5lFSmJrYTIPhZDozh/L3Iy3QhT4
 31g6q4T4Jh6D9KQcgGiR6oC+UAUmSLYmJWVjaVpohFBH14EFj2vhJEKoJ1IYEI3IqmrjNcuuNKh
 aOGFNr1N3YQp3eBLbyxSPea3wjKbehfJmsfevtx8j3gyALH1rgqUNKzfdxt+ySG66Q/ciNJVTJY
 lErM/8Eqx8h9f+t5bHIgz32FV13+igSg+4+1JgJMXyTkr3X8OTv7mIGt0gdrXt5znlZR7TRF0lj
 OxMEbBJs=
X-Google-Smtp-Source: AGHT+IHZ5xV0NBtOLkefRKfzjrVkVLrS4cyy5U4ejLxEHSBXWHnD8axXX9s1pLp01wCrkTiA5MD/uQ==
X-Received: by 2002:a05:6a00:1ad4:b0:742:aecc:c47c with SMTP id
 d2e1a72fcca58-74827fcd87cmr1950563b3a.7.1749166950952; 
 Thu, 05 Jun 2025 16:42:30 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 16:42:30 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v3 0/9] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Date: Thu,  5 Jun 2025 23:42:14 +0000
Message-ID: <20250605234227.970187-1-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

This patchset adds support for 6 FM API DCD Management commands (0x5600-0x5605)
according to the CXL r3.2 Spec.

The code was tested with libcxlmi, which runs in the QEMU VM and sends 56xxh
commands to the device (QEMU emulated) through MCTP messages over I2C
bus. To perform end-to-end tests, both MCTP and DCD support are needed
for the kernel, so the needed MCTP patches are applied on top of Ira's DCD
branch https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-12-11.

For the tests of commands 0x5600 (Get DCD Info), 0x5601 (Get Host DC Region
Config), and 0x5603 (Get DC Region Extent Lists), DCD kernel code is not involved.
The libcxlmi test program is used to send the command to the device and results
are collected and verified.

For command 0x5602 (Set DC Region Config): device creates an event record with type
DC_EVENT_REGION_CONFIG_UPDATED and triggers an interrupt to the host
if the configuration changes as a result of the command. Currently, the kernel
version used to test this only supports Add/Release type events. Thus, this
request essentially gets ignored but did not cause problems besides the host
not knowing about the configuration change when tested.

For the command 0x5604 (Initiate DC Add) and 0x5605 (Initiate DC Release), the
tests involve libcxlmi test program (acting as the FM), kernel DCD
code (host) and QEMU device. The test workflow follows that in cxl r3.2 section
7.6.7.6.5 and 7.6.7.6.6. More specifically, the tests involve following
steps,
1. Start a VM with CXL topology: https://github.com/moking/cxl-test-tool/blob/main/utils/cxl.py#L54.
2. Load the CXL related drivers in the VM;
3. Create a DC region for the DCD device attached.
4. add/release DC extents by sending 0x5604 and 0x5605 respectively through
the out-of-tree libcxlmi test program
(https://github.com/anisa-su993/libcxlmi/blob/dcd_management_cmds/tests/test-fmapi.c).
5. Check and verify the extents by retrieving the extents list through
command 0x5603 in the test program.

The remaining 3 commands in this series (0x5606-0x5608) are related to tags
and sharing, thus have not been implemented.

v1: https://lore.kernel.org/linux-cxl/20250317164204.2299371-1-anisa.su887@gmail.com/
v2: https://lore.kernel.org/linux-cxl/aD3jkRBHmbdc9QmD@deb-101020-bm01.eng.stellus.in/T/#t

Changes v2 --> v3
================================================================================
1. Rebased on ToT master branch + applied Fan's patch fixing DC extent tracking
(https://lore.kernel.org/linux-cxl/20250529163925.2916725-1-nifan.cxl@gmail.com/)
2. Picked up Fan's review tag on several patches. Still need review tag for the
following:
- cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
- cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
- cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
3. Changes:
- 0x5602: Deleted redundant function cxl_mbox_dc_event_create_record_hdr() and
replaced calls to it with existing function cxl_assign_event_header(). This
is done in the below patches as well, which also add records to the event log.

- 0x5604: Deleted redundant function cxl_mbox_dc_prescriptive_sanity_check() and
replaced calls to it with existing function cxl_detect_malformed_extent_list(),
which was originally added by Fan for the DCD Add/Release Response
commands (0x4802 and 0x4803), which needs to check for similar errors.

Deleted helper functions to count # of pending/accepted extents because Fan's
fix for dc.total_extent_count to correctly track pending and accepted extents
means we don't need to add them up separately.

- 0x5605: Similar to above, uses cxl_detect_malformed_extent_list() and
additionally, reuses existing function cxl_dc_extent_release_dry_run() to
detect additional errors that can occur in the case of releasing extents, which are:
    - extent to release is not actually block backed
    - releasing extents would cause the device to exceed max. extents supported

Because these patches have been rebased on upstream QEMU which is missing I2C
MCTP support, I have retested them in a manner similar to what is described above
but hacked to add the FM commands to the general T3 mailbox (initialized by
the cxl_initialize_mailbox_t3() function). Then libcxlmi is used to send
the FMAPI commands via ioctl instead of MCTP and the output is verified.

Anisa Su (9):
  cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
  cxl/type3: Add dsmas_flags to CXLDCRegion struct
  cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
  cxl_events.h: Move definition for dynamic_capacity_uuid and enum for
    DC event types
  hw/cxl_type3: Add DC Region bitmap lock
  cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
  cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
  cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
  cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release

 hw/cxl/cxl-mailbox-utils.c   | 538 +++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |  45 ++-
 include/hw/cxl/cxl_device.h  |  24 ++
 include/hw/cxl/cxl_events.h  |  15 +
 include/hw/cxl/cxl_mailbox.h |   6 +
 5 files changed, 605 insertions(+), 23 deletions(-)

--
2.47.2


