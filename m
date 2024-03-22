Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215CECD11BF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 07:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnYwv-0007Al-Ha; Fri, 22 Mar 2024 03:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rnYws-00079W-0A
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 03:04:18 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rnYwm-0004Ej-Vt
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 03:04:17 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6e50e8dcc72so673319a34.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 00:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1711091047; x=1711695847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q7neNI4OXUjIQ5rL9BmGxx5XZjsprNGi1CqpvhfOJ5A=;
 b=Xx7KtoBrUYODVuZXsEhhGtcFAEM/Q5mF2E7GBx+es8mEeiAhTjehjvqqL5Th5BJbZn
 wHCOSAY4xXuX51AlpiDRrxj24d6lrajWGiw9/TXRISoIbWVZOELTaRbmt0OIdqX8H29K
 yLtszRT0eAvaO9arnbMeI8qvcGr0aSLwkvU71L36A4W9cATB2OE4oTdsed7ssmOh+5Ro
 Sd1Mj15bUFOKXW0T52UwKGCO8a+IW0v6ZjcDiaUqqdXmEiWnCsWSNk+JKzeLeuspESfz
 OnTfvxr8ei4NibSSF+Yn4S9QTpa9s61O013FkrdFJuV2CCVVAvcKg1lQXDafikN928ko
 IvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711091047; x=1711695847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q7neNI4OXUjIQ5rL9BmGxx5XZjsprNGi1CqpvhfOJ5A=;
 b=jrlxFItIPbDH4kXMygk6KS4YGGnQFhBfE3523PnJKGn/FsSKQF0fq1yTmUEiAjfXFW
 OOOuGVWq9uG+c0TbCshBEB2AGyiNjDuLaGQlUZhgpHLmm/gpqx1VEs3D3U36P3h5fyXU
 OVAuJPXtYN2XafDbipiHCY27IDlvRSzkhlzkVNV6gtv4W3FBDQT1GXcJSmefhjEft5Je
 kKrmB17auM4mFusTNPIs4y6/16IQmzurwMucsHFr0KtcscpsoVA3/Fj3IUEntdCSzdmn
 Wp7RAPU/byQAtEYgoSTcFGJRc+kl9M21mboFAJSW90SMllPUZnr/jtCyt7HTXdtrxMJV
 r8ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqR/d8MMsFKrnsjqQ1e6kl4ryGnbwo91eC8XSj1TGNLEDaiya3oACGeVZENlA8FmZATssT5F+U6VV7UkOis8WT2qBE4v4=
X-Gm-Message-State: AOJu0YxBvu5pXDshxShINF8rgE2K8prAx88E6FfmS/C/lPLUC543SSnv
 WRStZcflTgq9HqRIcYGn8+Qbx+177nr9oVG/J4lDFfE0Aj5+Ovix2LiCOYvl7+A=
X-Google-Smtp-Source: AGHT+IGDL07edZqKGbxe2OTitulABo89PW1+afEDf8VZk/5xbSmUkIHDwnIlESs+qhqPqacblb6/Pg==
X-Received: by 2002:a05:6830:87:b0:6e6:7b48:b801 with SMTP id
 a7-20020a056830008700b006e67b48b801mr1669775oto.16.1711091047143; 
 Fri, 22 Mar 2024 00:04:07 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.215.108])
 by smtp.gmail.com with ESMTPSA id
 k1-20020ae9f101000000b00789fc794dbesm553974qkg.45.2024.03.22.00.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 00:04:06 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Fri, 22 Mar 2024 07:03:53 +0000
Message-Id: <20240322070356.315922-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=horenchuang@bytedance.com; helo=mail-ot1-x330.google.com
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

-v4:
 Thanks to Ying's comments,
 * Remove redundant code
 * Reorganize patches accordingly
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

 drivers/dax/kmem.c           |  20 +------
 include/linux/memory-tiers.h |  13 +++++
 mm/memory-tiers.c            | 105 +++++++++++++++++++++++++++++++----
 3 files changed, 110 insertions(+), 28 deletions(-)

-- 
Ho-Ren (Jack) Chuang


