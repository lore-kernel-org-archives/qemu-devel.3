Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C23CC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 06:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjvSh-00071Z-Pj; Tue, 12 Mar 2024 02:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rjvSe-00070e-Rm
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 02:18:04 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rjvSc-0004WG-EU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 02:18:04 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78822e21a9dso173252085a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 23:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1710224276; x=1710829076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fgGl/GezxVhRISLyx8tZ9PTH8m4h7yDB3m04Y7JMT5Y=;
 b=OysCTXZLDyQqNKu3m39ObIfuVikK4NMulP7ZWlddX9mZnf3aIgooUSB+wNe5UPMZNb
 1TVa1c7zlyq6xE664mSWvSkn4QX6/yLhffVwATqaxC3x4zzgHIMIJSXxCbuerCH6YCLX
 KbjtZD5cux42LO9lX65m4jswyYqkdYN49PFieUy66VeNRiJ7jMbu/tl/kIxA4LyUYCWh
 Sb6dP0DWnq98KzaJKwx2m2BHA07Su5QMBmpjs8qciwlFIvYWfbtL6LwUX+ESOUkbWic7
 cXLfEKVVe/pBKZxo4sNaEAFRyFprPpGIobWW585tUIBaU/jMTwIhiJ28e7h5CZyyWnbb
 xuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710224276; x=1710829076;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fgGl/GezxVhRISLyx8tZ9PTH8m4h7yDB3m04Y7JMT5Y=;
 b=m9wNa2ug4VBLxytWhS2Vjgz1ApbnYQ1JdBostqOj0NtrruhwLX1wd8qAc94DZhOM94
 zCoUbsnXiZi2zzR23pZHyXr9KzNcp9N/FKIapjig1yGgE9M4WiKMPpyKPGEhCrnKMJaP
 SeeZAcMh43J30IQtC9FuDVJcObOEGngQEKo/mDSibQC9F4C7Sw3hGk0BXu1GUBDbqW5C
 31bpfOVbk747ZPva4EToECkdqk6JGsh3zn9lyk68k7U85I3/e8mxzkbmMfPAzk9cnfB+
 dvjp3JNhuulDBczWXqljUKKiAybDIjiAX1/JlLNfWEEA+kz885C+VufNuHVXLw0NaaQG
 QgRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvRtNrZqgDI8yR5UbCAOHb1dVuhgR3FTEpq41Yz53zTkSyCC+c0LAP2sJQBlk0c28Euk2cfCpEKJJZXso6fCNCEHGpvpI=
X-Gm-Message-State: AOJu0YzKx9B3kt3SneukhZqrXhG1/UDzyRsqLZvezn7Miw0TEFt9ITyt
 Hnx587qAunCLacI19CzoTO3E8m1H/Rgz58vA4PYWfXrgrmeLv7M3BFGnoQf0zNA=
X-Google-Smtp-Source: AGHT+IGQVjf55XaSaA7QRv11XERHDa0ikizCRigRPLUcQWIpU3ODAYNJ7IKwN9aaMW4bZrAoONZoqw==
X-Received: by 2002:a05:620a:4494:b0:788:7dc5:cf8f with SMTP id
 x20-20020a05620a449400b007887dc5cf8fmr499319qkp.35.1710224276179; 
 Mon, 11 Mar 2024 23:17:56 -0700 (PDT)
Received: from n231-228-171.byted.org ([147.160.184.133])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a05620a221200b00787b93d8df1sm3394396qkh.99.2024.03.11.23.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 23:17:55 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Gregory Price" <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, tj@kernel.org, john@jagalactic.com,
 "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
 "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huang Ying <ying.huang@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Tue, 12 Mar 2024 06:17:26 +0000
Message-Id: <20240312061729.1997111-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=horenchuang@bytedance.com; helo=mail-qk1-x735.google.com
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
at boot time, eliminating the need for user intervention.
If no HMAT is specified, it falls back to using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance attributes
through QEMU, and the guest now sees memory nodes with performance attributes
in HMAT. With this change, we enable the guest kernel to construct
the correct memory tiering for the memory nodes.

-v2:
 Thanks to Ying's comments,
 * Rewrite cover letter & patch description
 * Rename functions, don't use _hmat
 * Abstract common functions into find_alloc_memory_type()
 * Use the expected way to use set_node_memory_tier instead of modifying it
-v1:
 * https://lore.kernel.org/linux-mm/20240301082248.3456086-1-horenchuang@bytedance.com/T/


Ho-Ren (Jack) Chuang (1):
  memory tier: acpi/hmat: create CPUless memory tiers after obtaining
    HMAT info

 drivers/acpi/numa/hmat.c     | 11 ++++++
 drivers/dax/kmem.c           | 13 +------
 include/linux/acpi.h         |  6 ++++
 include/linux/memory-tiers.h |  8 +++++
 mm/memory-tiers.c            | 70 +++++++++++++++++++++++++++++++++---
 5 files changed, 92 insertions(+), 16 deletions(-)

-- 
Ho-Ren (Jack) Chuang


