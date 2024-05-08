Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5550AC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gS5-0005bD-SN; Wed, 08 May 2024 08:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1s4gS3-0005Zv-7U; Wed, 08 May 2024 08:31:15 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1s4gS0-00039d-OV; Wed, 08 May 2024 08:31:14 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2b5f3e20615so1259351a91.1; 
 Wed, 08 May 2024 05:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715171471; x=1715776271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1lsDAQRXh7yx6cHADQ4jcz0kpWjTe153NCu8REQVIjQ=;
 b=MMey56Z8MfaL9JySvJMiy91W9xLLGzVU5YQWdBeTdvlNda3zGPOfH69OfDDkFj3lV+
 Y9Kxog9gY2+G7y9uNmwSjxVt9WgGJe7Fnc+HkC5PnTXdMB4bmufF0SxUxzieW/wXK/aI
 yRi7AgPrq3/KzE7ji9qlGmC9Ze8iP3H2P9YjlzuQm3yHlcyrxum0JR9OpHBqcdE4ICLR
 v7y2FasOJgIyLTA5DtJACGf+J/gUIxN7luY2kTBJ2tFPdeQVurnoNtnRLy/7Mwdarm8C
 kILUY4t3U23wYpckk4zyxgIgwjPlcjVtXT/JHOV3nbGL4S2Rwq2+FKHizQODuEcGZvOl
 mMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715171471; x=1715776271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1lsDAQRXh7yx6cHADQ4jcz0kpWjTe153NCu8REQVIjQ=;
 b=Eb/p0TPxUGvN7q/g5CaM2ZYK7u1nYXuMFuacrO43SVnfuHvByJdY2G0FzR+3P7mNMo
 zeVuj+8zy2aZG3dYHYZfKRxRTnf2Z+0ZJyqPr/Pzez98DLVa3pqFp2asWm/ylb/zjzOE
 W2vFAIB6aDYIS4Pybb48hm/K+NwwI4z4zt7DPLinJchRicOLTJPmz9OcJCz9ViiUHE+A
 G5Aw9hremyggKl8RIKmnS5nzwqszCun7xnDLhWz08QCNSsFOu1LTiWWHNMo8ugm0ejlL
 E8vDHRPmTi42bV3N20g/vC+Eo6xR3rKK16VwjNIL97xDs5NzATEY8iawy5TxLnMeFfJH
 lxxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG/cth88Vn0Mkd9oDWv0WQCw8bispDwYP8yJ888FZHNZlH9gh4XUG/lOA0ZKwDBxCJWLfPeoP1pD9pQ5uTvRxt5MCRmSM=
X-Gm-Message-State: AOJu0YxaZq6X3Crpa+AoK11tTyJoOIOoEY5S2eoZpxNHsLO5yYZXecCl
 lOQFz+knFKtQHhyQaoQcyMU+bWOmerSBTWDEosAicKefS8gowxVT
X-Google-Smtp-Source: AGHT+IERRKvlt4f/29ek77AzCX6pmv4lyPX0eGjM/YSzIf7pA+1BQmUbWOx+jcKr3GE2wEDMxGppwQ==
X-Received: by 2002:a17:90a:a90:b0:2a4:e9d:9888 with SMTP id
 98e67ed59e1d1-2b6165a3afdmr2333754a91.16.1715171470950; 
 Wed, 08 May 2024 05:31:10 -0700 (PDT)
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 y12-20020a17090a134c00b002b62079c52fsm1310984pjf.26.2024.05.08.05.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 05:31:10 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v3 0/4] hw/nvme: FDP and SR-IOV enhancements
Date: Wed,  8 May 2024 21:31:03 +0900
Message-Id: <20240508123107.87919-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pj1-x102e.google.com
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

Hello,

This patchset has rebased on the latest master and replaced 3rd patch
to one which allocates a dynamic array for secondary controller list
based on the maximum number of VFs (sriov_max_vfs) rather than a static
size of static array as Klaus suggested.  Rest of the patchset are the
same with the previous one.

This patchset has been tested with the following simple script more than
127 VFs.

	-device nvme-subsys,id=subsys0 \
	-device ioh3420,id=rp2,multifunction=on,chassis=12 \
	-device nvme,serial=foo,id=nvme0,bus=rp2,subsys=subsys0,mdts=9,msix_qsize=130,max_ioqpairs=260,sriov_max_vfs=129,sriov_vq_flexible=258,sriov_vi_flexible=129 \

	$ cat nvme-enable-vfs.sh
	#!/bin/bash

	nr_vfs=129

	for (( i=1; i<=$nr_vfs; i++ ))
	do
		nvme virt-mgmt /dev/nvme0 -c $i -r 0 -a 8 -n 2
		nvme virt-mgmt /dev/nvme0 -c $i -r 1 -a 8 -n 1
	done

	bdf="0000:01:00.0"
	sysfs="/sys/bus/pci/devices/$bdf"
	nvme="/sys/bus/pci/drivers/nvme"

	echo 0 > $sysfs/sriov_drivers_autoprobe
	echo $nr_vfs > $sysfs/sriov_numvfs

	for (( i=1; i<=$nr_vfs; i++ ))
	do
		nvme virt-mgmt /dev/nvme0 -c $i -a 9

		echo "nvme" > $sysfs/virtfn$(($i-1))/driver_override
		bdf="$(basename $(readlink $sysfs/virtfn$(($i-1))))"
		echo $bdf > $nvme/bind
	done

Thanks,

v3:
 - Replace [3/4] patch with one allocating a dyanmic array of secondary
   controller list rather than a static array with a fixed size of
   maximum number of VF to support (Suggested by Klaus).
v2:                                                     
 - Added [2/4] commit to fix crash due to entry overflow

Minwoo Im (4):
  hw/nvme: add Identify Endurance Group List
  hw/nvme: separate identify data for sec. ctrl list
  hw/nvme: Allocate sec-ctrl-list as a dynamic array
  hw/nvme: Expand VI/VQ resource to uint32

 hw/nvme/ctrl.c       | 59 +++++++++++++++++++++++++++-----------------
 hw/nvme/nvme.h       | 19 +++++++-------
 hw/nvme/subsys.c     | 10 +++++---
 include/block/nvme.h |  1 +
 4 files changed, 54 insertions(+), 35 deletions(-)

-- 
2.34.1


