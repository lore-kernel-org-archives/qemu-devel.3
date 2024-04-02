Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4459CD1288
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 00:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrRqX-00016e-Ok; Mon, 01 Apr 2024 20:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rrRqV-00016F-Ku
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 20:17:47 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rrRqT-0006zK-In
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 20:17:47 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-69185f093f5so32638066d6.3
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712017062; x=1712621862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gW68csmOvBMTYM9kf5jTmocSt+5Cfpv4k9wOl9BtKJ0=;
 b=kuLzHfonpmOMOY+sGf6MgbjRYtFone7R3JVlXbvPNLUkn8viss4FHUn2MVVtBXfofC
 RCEVLfOjy6LrG3+ndTSCLkwwgjG7YlNy6FSh8OUC0YUIbMzkMoqMC8eyADgSXgnpWBog
 EX+ReWWJ3IVIfIQgr5uZBY71Zdg4NmyDuNHFf3OuuAHuJXTm3Bg2m/riyXFigN58rjhS
 nKYXP+2uHOidLEpVKP8BWL4B1vKItnviYMaXBaj2Gezc3PCDr0TbqB4Fdrx4xj6msO7X
 qKs0P43vRerRPlz3QmUcs+ZtzyGeIvqVtNulS1Z/9517Yk0EmH3XSKRetX7M/zjackWW
 VkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712017062; x=1712621862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gW68csmOvBMTYM9kf5jTmocSt+5Cfpv4k9wOl9BtKJ0=;
 b=KV3ggm2ueR0DxM79TGSINsgu05s6rDVbvR3Nn8elVtL+3T3IlmCtSnL9q3lUUM0yZa
 GQdHwDbVPG0nQbSbQNuhe69+5bhFoXtOzimCkCakqH5mhiR9y044VeMffe63yFFB9orB
 Kb9VzOZ0fS3+fvT9xZo2NAZ2TehT7N1WwWBhfvJE05wvs8QmxT5RzlroDVaNINefmTF+
 IrJURq74QswTd68gN7F8qRfAA3nUdFOSmeFr2wilCU5GYo9icfpV37CgW3o8omf58ntv
 fY/gWpGKFftjPhXPf5hqiFjHst0nMqe3aOXr2IVmCOBET1Iz2wZkn4vHfzGc7x7ereuM
 ySTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCWyc3O8SwSYfpnNggMDbrRgPV3J5Mfg/eqqaNCeyYEQxcwTm33NvzRaS7i9t5m3AE0aXw3TzYlWUPQ1HbAZ1mTEkn61A=
X-Gm-Message-State: AOJu0YzW9/tbJijJzt34JZFH3jQlwlDT5qixNVrLvZzWWdtuVB0RlpEK
 BlU5GTZDS2EKmRNBaW1/ZoGQFCwewH2eZQQThT+jW30BMnZSYI8e9gigZNVbWLY=
X-Google-Smtp-Source: AGHT+IHI1NovuRSzlyW3MYabIw0PVUmZGVgQf3UfVLAx8wFoGSl+V+dNtBDwUZKth1SSmnW9MKt4eA==
X-Received: by 2002:a0c:f707:0:b0:699:bbd:7976 with SMTP id
 w7-20020a0cf707000000b006990bbd7976mr3538796qvn.22.1712017062196; 
 Mon, 01 Apr 2024 17:17:42 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.125])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a0562141d0a00b00698f9771822sm3013112qvd.83.2024.04.01.17.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 17:17:41 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Huang, Ying" <ying.huang@intel.com>,
 "Gregory Price" <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, tj@kernel.org, john@jagalactic.com,
 "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
 "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,
 "Srinivasulu Thanneeru" <sthanneeru@micron.com>,
 "SeongJae Park" <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v10 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Tue,  2 Apr 2024 00:17:36 +0000
Message-Id: <20240402001739.2521623-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=horenchuang@bytedance.com; helo=mail-qv1-xf36.google.com
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
normal memory (E820_TYPE_RAM), the memory device is indistinguishable from
normal DRAM in terms of memory tiering with the current implementation.
The current memory tiering assigns all detected normal memory nodes to
the same DRAM tier. This results in normal memory devices with different
attributions being unable to be assigned to the correct memory tier,
leading to the inability to migrate pages between different
types of memory.
https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

This patchset automatically resolves the issues. It delays the
initialization of memory tiers for CPUless NUMA nodes until they obtain
HMAT information and after all devices are initialized at boot time,
eliminating the need for user intervention. If no HMAT is specified,
it falls back to using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance
attributes through QEMU, and the guest now sees memory nodes with
performance attributes in HMAT. With this change, we enable the
guest kernel to construct the correct memory tiering for the memory nodes.

- v10:
 Thanks to Andrew's and SeongJae's comments,
 * Address kunit compilation errors
 * Resolve the bug of not returning the correct error code in
   `mt_perf_to_adistance`
-v9:
 * Address corner cases in `memory_tier_late_init`. Thank Ying's comments.
 * https://lore.kernel.org/lkml/20240329053353.309557-1-horenchuang@bytedance.com/T/#u
-v8:
 * Fix email format
 * https://lore.kernel.org/lkml/20240329004815.195476-1-horenchuang@bytedance.com/T/#u
-v7:
 * Add Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
-v6:
 Thanks to Ying's comments,
 * Move `default_dram_perf_lock` to the function's beginning for clarity
 * Fix double unlocking at v5
 * https://lore.kernel.org/lkml/20240327072729.3381685-1-horenchuang@bytedance.com/T/#u
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
 include/linux/memory-tiers.h |  14 ++++
 mm/memory-tiers.c            | 127 ++++++++++++++++++++++++++++++-----
 3 files changed, 126 insertions(+), 35 deletions(-)

-- 
Ho-Ren (Jack) Chuang


