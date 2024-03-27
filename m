Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4151C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 07:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpNhR-0006lU-Iw; Wed, 27 Mar 2024 03:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rpNhJ-0006kS-K3
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:27:47 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rpNhE-0003Db-Fe
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:27:43 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78a01a3012aso439236285a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1711524451; x=1712129251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IldNgoyaPcCzFmZ/bstRqOq1SS9MI1jIO9UfiXXSAU4=;
 b=Usmz6QsZ5v1rz3sIOiHc3WgEkLO44TlSnEB9SFjY3ZScSWak6o0ahXu9XdNvXFCmuK
 5qOeiCwn8QVC4tv0x86VAji+q4iUyTkj4PqRcP1Zd7zUphah6SiFN5K8/O6BnAzOS0TH
 GMbbrZYw3YRjDkdE2bAMyJtJdliW22snMIqJXrSw8Kbo0Fjg20BI5nRTyP47GXDZ3Jqd
 07beLD70GjcfPHoLWCBjEvOda3ZGAo42gg6grr93RkVWeDKEy+b5VWaWIzgT2DAY1fY5
 P9QtdqnoojMC7nuN+J9kUUtapaA2r3vjFcnFa7e5azNyBulRJAaILbyJDrGedBWcgWXd
 c+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711524451; x=1712129251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IldNgoyaPcCzFmZ/bstRqOq1SS9MI1jIO9UfiXXSAU4=;
 b=GJFQjocyNgCaouBTzT3eMXhhoYRXrTgvRnJ1sw6DswWnJeKxBQR2pzcIhKg3fdX25i
 RqpMJVBkS/MPNPJTp72+SVsD7RogxrNY8rT25RS9+tau35mumSHZVn9WJP+w6Mi2txKa
 xGFBeuDWyh8CLaBQD+Knu5cPfP/Js92D/OhLo4mIHM8PNWeKrcOWWGk1f3bWTzritvT2
 YD3FMimeOiUE6VJwXaNtYCAMwfzqw5rEcPNIKYVWhEpZQYeOw6UwUE+ao+7+1wrmf9Q7
 65qN6jb38iXPJV4dK8vVq9Y409hAOK3je85Yk6Kk/tc9tG4cRG8/LXCLY3mTFVcNBTVR
 SV9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyuUNVHztHudLHME+qcM+Rl81NW06MREbkWPi5O3alTIe508RtfsFUfNNNk/Og6+t6kBtPcpYd35r6egJ0SuHnW430+1s=
X-Gm-Message-State: AOJu0YyUcRwxJUzL025dZvT83zWDszj+VAzE9qu/EEn2yDJjbf9C1GwU
 RTCW2dRfUmBtDz5w4oVWpe4e27NV6liA+VBEbwpsRR2wqp/MlSFA7cqKd8/Bmzo=
X-Google-Smtp-Source: AGHT+IGtqBvkGEFUH7xveuxcSGh3Y9WoJxG4fW6RKgQd9gCeDvnBocFndsK1ZVijAA2duJEKfAsBiA==
X-Received: by 2002:ac8:7f8e:0:b0:431:5f0e:bfa9 with SMTP id
 z14-20020ac87f8e000000b004315f0ebfa9mr5633221qtj.34.1711524451618; 
 Wed, 27 Mar 2024 00:27:31 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.102])
 by smtp.gmail.com with ESMTPSA id
 bq15-20020a05622a1c0f00b00431604af3c1sm2383555qtb.20.2024.03.27.00.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 00:27:31 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Huang, Ying" <ying.huang@intel.com>,
 "Gregory Price" <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, tj@kernel.org, john@jagalactic.com,
 "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
 "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,
 "Srinivasulu Thanneeru" <sthanneeru@micron.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Wed, 27 Mar 2024 07:27:26 +0000
Message-Id: <20240327072729.3381685-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=horenchuang@bytedance.com; helo=mail-qk1-x733.google.com
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

When a memory device, such as CXL1.1 type3 memory, is emulated as
normal memory (E820_TYPE_RAM), the memory device is indistinguishable
from normal DRAM in terms of memory tiering with the current implementation.
The current memory tiering assigns all detected normal memory nodes
to the same DRAM tier. This results in normal memory devices with
different attributions being unable to be assigned to the correct memory tier,
leading to the inability to migrate pages between different types of memory.
https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

This patchset automatically resolves the issues. It delays the initialization
of memory tiers for CPUless NUMA nodes until they obtain HMAT information
and after all devices are initialized at boot time, eliminating the need
for user intervention. If no HMAT is specified, it falls back to
using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance attributes
through QEMU, and the guest now sees memory nodes with performance attributes
in HMAT. With this change, we enable the guest kernel to construct
the correct memory tiering for the memory nodes.

-v6:
 Thanks to Ying's comments,
 * Move `default_dram_perf_lock` to the function's beginning for clarity
 * Fix double unlocking at v5
-v5:
 Thanks to Ying's comments,
 * Add comments about what is protected by `default_dram_perf_lock`
 * Fix an uninitialized pointer mtype
 * Slightly shorten the time holding `default_dram_perf_lock`
 * Fix a deadlock bug in `mt_perf_to_adistance`
 * https://lore.kernel.org/lkml/20240327041646.3258110-1-horenchuang@bytedance.com/T/#u
-v4:
 Thanks to Ying's comments,
 * Remove redundant code
 * Reorganize patches accordingly
 * https://lore.kernel.org/lkml/20240322070356.315922-1-horenchuang@bytedance.com/T/#u
-v3:
 Thanks to Ying's comments,
 * Make the newly added code independent of HMAT
 * Upgrade set_node_memory_tier to support more cases
 * Put all non-driver-initialized memory types into default_memory_types
   instead of using hmat_memory_types
 * find_alloc_memory_type -> mt_find_alloc_memory_type
 * https://lore.kernel.org/lkml/20240320061041.3246828-1-horenchuang@bytedance.com/T/#u
-v2:
 Thanks to Ying's comments,
 * Rewrite cover letter & patch description
 * Rename functions, don't use _hmat
 * Abstract common functions into find_alloc_memory_type()
 * Use the expected way to use set_node_memory_tier instead of modifying it
 * https://lore.kernel.org/lkml/20240312061729.1997111-1-horenchuang@bytedance.com/T/#u
-v1:
 * https://lore.kernel.org/lkml/20240301082248.3456086-1-horenchuang@bytedance.com/T/#u

Ho-Ren (Jack) Chuang (2):
  memory tier: dax/kmem: introduce an abstract layer for finding,
    allocating, and putting memory types
  memory tier: create CPUless memory tiers after obtaining HMAT info

 drivers/dax/kmem.c           |  20 +-----
 include/linux/memory-tiers.h |  13 ++++
 mm/memory-tiers.c            | 126 ++++++++++++++++++++++++++++++-----
 3 files changed, 125 insertions(+), 34 deletions(-)

-- 
Ho-Ren (Jack) Chuang


