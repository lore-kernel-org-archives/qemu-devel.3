Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B00C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmpA6-0000GO-Vg; Wed, 20 Mar 2024 02:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rmpA3-0000Fy-Op
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:10:52 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rmpA1-0006R2-Ip
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:10:51 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-789e5021703so261748485a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 23:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1710915045; x=1711519845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xCZgkB2SZu0i/tSjRR46WOtj0M+sNHf+HRU976J1PX4=;
 b=k6gTqRoZcj9LplZrxV7jAfQpFolGVsgTOAve3LQtRRR89i+IJhT6smzxFgJ6k0O3N7
 CXNUQ8kd/kTj49MsJf+s9lV9B2X4KL2GHcWxLSDmdHpvM16gvVZEUEjfKfEzqQE4/JWn
 aQYayVSz4Q5pYNdpiR2fKAHUMeTPDuw7vCfj0aDb2PhRTbwCjgPNgb/Z5tKY4Vz+WAZJ
 YbigYcaHe6/WoAsaKoA/hA0zGetUcN79mgf7gxVRAmJQAxlbglEP4EFKX0UnXwXU2Ij1
 FXM7vYi2dpcIDfhEyABrvrWssHSQ3doXAdAopOKVh/7M/M7H3jvCw9odYYNoqzuQ26BR
 MXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710915045; x=1711519845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xCZgkB2SZu0i/tSjRR46WOtj0M+sNHf+HRU976J1PX4=;
 b=nN3xrg9AkBNMXI6oDRZdouv7blFnyc0qWSoQKyLp5OL8pL4f0OMeudn8Rv+G/D9sX4
 3Sc3AKdsGWHqm+45tq4ii+pZeqHUTFRkpThO1InMYqYSa4E87Iq3yFmwLdtDEnpBmx73
 9Elk5+gmEJ4+lsCA8Rkvbg343SqgDmXWfMZ3JxC0Al5+e3MmXO6bTQrDZ8y2znDqHib1
 EHcq76I+p1zSoRJ3GYIj+fQ+LKIhg6h14Y0Vxv5dnLmrdWTJctfRYSqmlEcctJMJOd7m
 Q53xwOniRW/uz/pGDJM2G6au6jZ33iuk2OiMjWg5wkSs8UoHOe86A1Rli4EXiq4W2GN4
 x76g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrol8ZU2i1wz5f04cpRG9jiQJO3AxFp5mGj9P4ceyh2JJaWCTz6y00wHeRtsPv2/imzkZ6qSUn8UO/EVLUHkbu3zYaBYM=
X-Gm-Message-State: AOJu0YzYt6g8dbV5QIENmAugHll5BUHRAxGBBSl6oj9Ieu8Z2oegW7PZ
 /5sVIXzWZFN4wivVWBuKLdni5xGPkQBInKD8fD9cC7XcO9kyuxfu095Ir9/FtGQ=
X-Google-Smtp-Source: AGHT+IFa111kisVq1eXAsilnKhEWjB1FxneYVefed7MzhMngJVWVGZbwSa2ElD7e4aapqGZS/vkJjQ==
X-Received: by 2002:a05:620a:5d8b:b0:78a:1c41:ac4e with SMTP id
 xx11-20020a05620a5d8b00b0078a1c41ac4emr2285040qkn.5.1710915045498; 
 Tue, 19 Mar 2024 23:10:45 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.215.123])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a05620a03cf00b0078a042376absm2295914qkm.22.2024.03.19.23.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 23:10:45 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Wed, 20 Mar 2024 06:10:38 +0000
Message-Id: <20240320061041.3246828-1-horenchuang@bytedance.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

-v3:
 Thanks to Ying's comments,
 * Make the newly added code independent of HMAT
 * Upgrade set_node_memory_tier to support more cases
 * Put all non-driver-initialized memory types into default_memory_types
   instead of using hmat_memory_types
 * find_alloc_memory_type -> mt_find_alloc_memory_type
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
  memory tier: dax/kmem: create CPUless memory tiers after obtaining
    HMAT info
  memory tier: dax/kmem: abstract memory types put

 drivers/dax/kmem.c           |  20 +------
 include/linux/memory-tiers.h |  13 +++++
 mm/memory-tiers.c            | 106 ++++++++++++++++++++++++++++++++---
 3 files changed, 114 insertions(+), 25 deletions(-)

-- 
Ho-Ren (Jack) Chuang


