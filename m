Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5911C7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 22:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUv4z-0006KV-KY; Thu, 26 Jun 2025 18:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv4x-0006KD-U2
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv4o-0000sE-5g
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:23 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-236470b2dceso17376985ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750976889; x=1751581689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XBvEswFRBQqL5L/YGfeRisUGWo6c5sSXSxbxfcjgW8Q=;
 b=nSg8kJ4a2RUmSte1fO5hJ8cdJrjQoAvG73dvHnlX11HraP4+sOtj9e431Wuej/yiGV
 Km5MjyaU5BXlh+l0bdg/TXnHqtdbNo76wrzqEGd5IZ99EgAMOWzlc64NzhPOoWtjn+5l
 CccrU5ZWMtPqQ+MhVtvtHcreIqB0buCy7vrAVqsBhNtaNeZZ/YmKlszONtMya5VKp/rn
 iR2nVYmR5jcM/9y6Ne++RvLXbinri1BOZiowDGtD/iVSjEQW/NOnksDLrvDPjUnbSgcJ
 1ngfAyl0x92tRnWqjFPk3yM1zRgeblzZzUDxq2Q0BkVHP2RiZNoPq5bPK7ow0XOvP5I0
 T/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976889; x=1751581689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XBvEswFRBQqL5L/YGfeRisUGWo6c5sSXSxbxfcjgW8Q=;
 b=FebawPLkvKPnYT7AHPvJKU0XuBFjTKT7zfHCMAIVMGdzsZ3F6UFFC14avQW5j+Ecu6
 EL2/tJwnF73V3+DSzzVMgj7mG8eQlR9IikEy4mIHfglARFBMH//5DV/y3JLUsfURADQ5
 kZW4raxNRSCPppf4BFQlF+Ms4iANF+MXLuWC7T7KAk9yjoRDccd/yEu2NUptO3sT7vK5
 pyO8WqNliYwls8zAZTN+B4xnOcQACcIeBLO8gylCHgLx6uEeWvDtTgXD54oqgrmNPbPS
 UsUvH8D4tmT+FynSPfN7v1i+35WwWeJp9E9unBX+baXn+grr2pLCK1iR9VUGV4nh65xd
 msag==
X-Gm-Message-State: AOJu0YxKhPq8bdLXip5u95+Rpai60QnPNsoI8dPF38+vhHGL6e5RDE53
 M+hvfEHFA5unILrWbZB/uxVegLL4xLXtFg/by6X+rwCMFODpQPjW+bZLj8yniw==
X-Gm-Gg: ASbGncurGAUhMrfFsZ8vHhKa4BCCBK30O6JujVpaT2SeYOzh79owiR+6PE3tM0F3Hol
 jr92Pg9t0E5SGNItXP6ePzjmWWXWX58MHPqJDNkyO7iLTWNAisdV1M8nznH0gKnFXYIyVEEkwyM
 ElbO49hBTBfDyupnZPvhIduBbgIEDn16vYe6wRWOakA5xEY2A5K3if92qqL71riuDVAzWesNpvR
 Jn7WKOD8igkAepEZ9Ayk+3Rmx2DLs8MRYjQMHlQOJGRxhTOoUAivqmQ6ebYCizgWtW3qZO/8Bfn
 QRwZAFIQEF/DgIwenCXpyrF4aEUC8X8ynvuJT18vQaszFNbXwijxqnav97WLneir4dvXh8hYgl8
 KycH5FNI=
X-Google-Smtp-Source: AGHT+IF1iODfHE8fzSjYQHYGuvuHvcDNhOO3OqdyuwV7o34VK7Drc2bBOMI0nsIntVIGfCzv0pMHDg==
X-Received: by 2002:a17:902:f90c:b0:234:f182:a735 with SMTP id
 d9443c01a7336-23ac45e24a2mr9349075ad.34.1750976889205; 
 Thu, 26 Jun 2025 15:28:09 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:28:08 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 alok.a.tiwari@oracle.com, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v4 00/10] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Date: Thu, 26 Jun 2025 22:23:23 +0000
Message-ID: <20250626222743.1766404-1-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
commands to the device (QEMU-emulated) through MCTP messages over USB.

Test Configuration:
 - Kernel:
To perform end-to-end tests, both MCTP and DCD support are needed for the kernel.
The kernel version used is Ira's latest DCD branch which is based on 6.15-rc2,
which includes the upstreamed support for MCTP over USB:
https://github.com/weiny2/linux-kernel/tree/dcd-v6-2025-04-13

- QEMU:
To enable MCTP over USB in QEMU, Jonathan's RFC patches are applied on ToT master branch
(https://lore.kernel.org/linux-cxl/20250609163334.922346-1-Jonathan.Cameron@huawei.com/T/#m21b9e0dfc689cb1890bb4d961710c23379e04902)

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
code (host) and QEMU device. The test workflow follows that in CXL r3.2 section
7.6.7.6.5 and 7.6.7.6.6. More specifically, the tests involve following
steps:
1. Start a VM with CXL topology:

 '-device usb-ehci,id=ehci \
     -object memory-backend-file,id=cxl-mem1,mem-path=/tmp/t3_cxl1.raw,size=4G \
     -object memory-backend-file,id=cxl-lsa1,mem-path=/tmp/t3_lsa1.raw,size=1M \
     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
     -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
     -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
     -device cxl-type3,bus=swport0,volatile-dc-memdev=cxl-mem1,id=cxl-dcd0,lsa=cxl-lsa1,num-dc-regions=2,sn=99 \
     -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=us0 \
     -device usb-cxl-mctp,bus=ehci.0,id=usb1,target=cxl-dcd0\
     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k'

2. Load the CXL related drivers in the VM & configure MCTP endpoints:

3. Create a DC region for the DCD device attached:

cxl create-region -m mem0 -d decoder0.0 -s 1G -t dynamic_ram_a

4. Add/release DC extents by sending 0x5604 and 0x5605 respectively through
the following libcxlmi test program:

https://github.com/computexpresslink/libcxlmi/blob/main/examples/fmapi-mctp.c

5. Check and verify the extents by retrieving the extents list through
command 0x5603 in the test program.

6. Create a DAX Device from the extents added:

daxctl create-device -r region0
daxctl reconfigure-device dax0.1 -m system-ram

The remaining 3 commands in this series (0x5606-0x5608) are related to tags
and sharing, thus have not been implemented.

v1: https://lore.kernel.org/linux-cxl/20250317164204.2299371-1-anisa.su887@gmail.com/
v2: https://lore.kernel.org/linux-cxl/aD3jkRBHmbdc9QmD@deb-101020-bm01.eng.stellus.in/T/#t
v3: https://lore.kernel.org/linux-cxl/20250605234227.970187-1-anisa.su887@gmail.com/

v3 -> v4 Changes
================================================================================
1. Rebased on upstream ToT and retested with MCTP-over-UCB

2. cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
 - Move condition to return success if new block size == current block size
 after bitmap checks because list of what should fail with unsupported doesn't
 allow an exception for a noop request according to the spec
 - Picked up Fan's review tag

3. hw/cxl: create helper function to create DC Event Records from extents
Based on Fan's feedback on the FM Add/Release patches from v3, reuse code from
qmp_cxl_process_dynamic_capacity_prescriptive() to use in both qmp interface
and mailbox commands.

Created helper function to create DC event recs and insert into log from
qmp_cxl_process_dynamic_capacity_prescriptive().

4. cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
- Fix local tmp array (CXLUpdateDCExtentListInPl *list) to be declared with
 g_autofree/g_malloc0
- Use helper method from refactored QMP code to create/insert DC Event Records
 remove previously defined helper method cxl_mbox_create_dc_event_records_for_extents
- Remove previously defined helper method cxl_mbox_dc_add_to_pending() because
 it is not used by any other methods.
- Removed unreachable return statement after default case in switch statement

5. cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
- Fix local tmp array (CXLUpdateDCExtentListInPl *list) to be declared with
 g_autofree/g_malloc0
- Use helper method from refactored QMP code to create/insert DC Event Records
- Fix CXL_EXTENT_REMOVAL_POLICY_MASK definition to be 0x0f instead of 0x7.
The removal policy should be bits[3:0] per the spec. 0x7 only covers bits[2:0]
- Add missed check for if extent in the list covers a pending extent if Forced
Removal Flag is not set
- Removed unreachable return statement after default case in switch statement

Status:
First 6 patches have Fan's review tag
(cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info ^.. cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists)
Last 3 still need review tag.


Anisa Su (10):
  cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
  cxl/type3: Add dsmas_flags to CXLDCRegion struct
  cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
  cxl_events.h: Move definition for dynamic_capacity_uuid and enum for
    DC event types
  hw/cxl_type3: Add DC Region bitmap lock
  cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
  cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
  hw/cxl: create helper function to create DC Event Records from extents
  cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
  cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release

 hw/cxl/cxl-events.c          |  38 +++
 hw/cxl/cxl-mailbox-utils.c   | 494 ++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c           |  82 ++----
 include/hw/cxl/cxl.h         |   1 +
 include/hw/cxl/cxl_device.h  |  28 ++
 include/hw/cxl/cxl_events.h  |  15 ++
 include/hw/cxl/cxl_mailbox.h |   6 +
 7 files changed, 604 insertions(+), 60 deletions(-)

--
2.47.2


