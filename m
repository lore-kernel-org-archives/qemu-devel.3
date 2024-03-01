Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8349BC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfyBt-0002lO-8E; Fri, 01 Mar 2024 03:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rfyBr-0002l8-Ha
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:24:24 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rfyBb-0001Gr-PH
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:24:23 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-68fb71fc886so7511656d6.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 00:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709281440; x=1709886240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jbrAz4lnEz25kwMLB527PTKTo91cgL6BvX6RpZZhxe0=;
 b=duoFQ3s1xmRK6EG5DfxWFp36kYZwCUZqaoH3eG81ObmxWKeJqk7FVjDpNE+NAidMyU
 LrQkco4stSzVCWhidMVBiVAc+NLWTGD0IVLoHe4dlVxvcAEqKoSJT6vak3hlN5IEqZUg
 SncU0xmsdO3nsAsIiey7rYlQ4E6m6uGX6HdA1g2/qgF08RfA7QEG7vV0MJ+LSsdBVs0d
 tj+2t57Krf9lQt7y13K+3WxlLHxcsxAWuV6puz8aPfxn/9CYXe6IcdvFJfowXAq8YPRZ
 dK1psF+qucRLTYkJm+Lbum3hLrui+sXXI3TiObw5cfrUiGJTxpAlYrhte7rCvkxvmJXI
 01kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709281440; x=1709886240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jbrAz4lnEz25kwMLB527PTKTo91cgL6BvX6RpZZhxe0=;
 b=nAPfFz8vKKou32VsEu/4ZfqWCzez7AXsH3KMwAbTOmNCf0Y6diSy3zuq+J2Np1JfyY
 Z8VtAmIHpGgLqipNVC6C3xjBUDVjzGTTguh96YqXfcDqgZI4ZETPLBG2AKfDtJMe7O/I
 6iZS9Hra6Yj311kkMhjnG+MwKceHiwyjfw6ioUOsHtom3vmvmkvYv+DB/tZRxCTL6U5r
 tw/0ZwaAyg3Zzi91/3L/Wu61+Z4BxX2M6nZ7hOSlpP+sPQIMVE1qGKQ9jdUJw9QyPZ2V
 sJ3BypT/KwYTixQy8Zs1SwVhcHPAZg6kk2wA0PpvtPX6KW6ubC8plC15HaR3qNPtf+qs
 fyXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSjv7u8+jhrn4XVUGY0wGG21mjSevxUU06rxsDm6+sGD3DT32VY2Ttwu941Gj+WMlblRDLmVrixWCSjkbzClpL3xtKU70=
X-Gm-Message-State: AOJu0YyY1TyZ4+qPqvWO0wCYD0MwuP77IzOLNs60dKv4aXQPBTI8zIRB
 yo5F1npbgLjXQv6KEN0xgIzJNxqYFGj1q8XJO0QXs2HANP84iha7bHzGBoh5zpQ=
X-Google-Smtp-Source: AGHT+IExEjh1BdqSl2OFFVnciy2m2VKRizXJqjFfRMSkTbsdSsINER9CoqawxtN38k6ZkAj5ZjelYw==
X-Received: by 2002:a0c:c20a:0:b0:68f:43f6:4834 with SMTP id
 l10-20020a0cc20a000000b0068f43f64834mr990776qvh.26.1709281440109; 
 Fri, 01 Mar 2024 00:24:00 -0800 (PST)
Received: from n231-228-171.byted.org ([130.44.215.123])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a0cd993000000b0068fc392f526sm1631907qvj.127.2024.03.01.00.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 00:23:59 -0800 (PST)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Hao Xiang" <hao.xiang@bytedance.com>,
 "Gregory Price" <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, tj@kernel.org, john@jagalactic.com,
 "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
 "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huang Ying <ying.huang@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Fri,  1 Mar 2024 08:22:44 +0000
Message-Id: <20240301082248.3456086-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=horenchuang@bytedance.com; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The memory tiering component in the kernel is functionally useless for
CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the nodes
are lumped together in the DRAM tier.
https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

This patchset automatically resolves the issues. It delays the initialization
of memory tiers for CPUless NUMA nodes until they obtain HMAT information
at boot time, eliminating the need for user intervention.
If no HMAT specified, it falls back to using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance attributes
through QEMU, and the guest now sees memory nodes with performance attributes
in HMAT. With this change, we enable the guest kernel to construct
the correct memory tiering for the memory nodes.

Ho-Ren (Jack) Chuang (1):
  memory tier: acpi/hmat: create CPUless memory tiers after obtaining
    HMAT info

 drivers/acpi/numa/hmat.c     |  3 ++
 include/linux/memory-tiers.h |  6 +++
 mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
 3 files changed, 77 insertions(+), 8 deletions(-)

-- 
Hao Xiang and Ho-Ren (Jack) Chuang


