Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC56CD129A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 00:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsX78-0006Bp-BQ; Thu, 04 Apr 2024 20:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rsX76-0006BN-Od
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 20:07:24 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rsX6y-00025h-AI
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 20:07:18 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-789f00aba19so104620485a.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 17:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712275630; x=1712880430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=borPtC2Lw74++f4OJFhInHLKkc0dmWJsVuLGMvV8fMY=;
 b=eHYAIkOX340KIKxtFyWJbCIR62QGPPCuRlfdpKtrpGxxr/+yyH2I/6hF66VGjwY3yL
 Fta+7+fms002M7HAbXz7cqjVV7xRe5vTdPozd1yzgkDet/I5367ips/3qh9WV2evbQJP
 302nHAej10X0XahI1pa3ZL2gbD5qtP54p1Pw+BDgU2jjo9IJs08lja8FG0MBOA90jL7q
 2Y0rzgxliGsnw1N/opB8fow08PjRLO5Eiy8mJC5iFn6DK4VXzijBmdELCbDKRJqM4J/N
 kcUDr8N2g/EGYNOcIPmxZbEtWZsv0wM/w8BKMKZ5RpPREaYirCnXe5+arQAzXgSQ9wgY
 lF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712275630; x=1712880430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=borPtC2Lw74++f4OJFhInHLKkc0dmWJsVuLGMvV8fMY=;
 b=CouUSpAOMRQ0qHYJC444IrE0bUFvLE3URhO8gSrr+8/g/Cm8tOxW3gowgDAJbm2lRg
 rK0WBwLj4TG7esJ4uICMZ6CnJSHhh+XgAWrv1rPts2qoSoOTmuiLcnoQ0vriCoE/0J61
 BbNVOipX4V8v79UBTaLOSeF1SGZQc2PnAja7KoGPmh//clTdwOjRxPFMD2wn4ZXu2ko/
 OLgM51f5yIz3eFlb0Qs18Z1N0c0NIaJEIJUoO7LWqi3cOrrTs/vQDNl4KwfgYTjyHO+X
 HaHhw7ANBLsLg0WOcZkUSts3DDFNsG/blsSD1q5+0J5V+DgcQ+9FSR6ec9hWrvMMTG4K
 /ajg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaLb59aBwHrzUWQ4103N6Jytpz+8jdAM5I9Nt4W8zssOEu5Ceb9WaYUcLDSVMiOetZ6GOHR01o/cQqBHIYGpjHJH0mhKs=
X-Gm-Message-State: AOJu0Yxs1iskqPjk2lz2WRDBlNh+R4vIwhvCutmhTfLEWZY+cYKLfyus
 vw/wG1JwYGC0ZBRVXd7S5lAPulTLKXP9vnn8eSD7uTGOCq4UvoRLF/GP7y3Vh7s=
X-Google-Smtp-Source: AGHT+IEZxsVQpcVtfVYtGZzcm88UlnMi4FCOp8lekdMsqoU3bR6MAdrGWYFbzpWmRgOIJsDUml+1Gg==
X-Received: by 2002:a05:620a:136e:b0:789:e524:933b with SMTP id
 d14-20020a05620a136e00b00789e524933bmr3831084qkl.31.1712275630015; 
 Thu, 04 Apr 2024 17:07:10 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.118])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a37c404000000b0078835bfddb8sm191433qki.84.2024.04.04.17.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 17:07:09 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
 "Huang, Ying" <ying.huang@intel.com>,
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
Subject: [PATCH v11 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Fri,  5 Apr 2024 00:07:04 +0000
Message-Id: <20240405000707.2670063-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=horenchuang@bytedance.com; helo=mail-qk1-x730.google.com
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

- v11:
 Thanks to comments from Jonathan,
 * Replace `mutex_lock()` with `guard(mutex)()`
 * Reorder some modifications within the patchset
 * Rewrite the code for improved readability and fixing alignment issues
 * Pass all strict rules in checkpatch.pl
- v10:
 Thanks to Andrew's and SeongJae's comments,
 * Address kunit compilation errors
 * Resolve the bug of not returning the correct error code in
   `mt_perf_to_adistance`
 * https://lore.kernel.org/lkml/20240402001739.2521623-1-horenchuang@bytedance.com/T/#u
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

 drivers/dax/kmem.c           |  30 ++-------
 include/linux/memory-tiers.h |  13 ++++
 mm/memory-tiers.c            | 123 ++++++++++++++++++++++++++++-------
 3 files changed, 116 insertions(+), 50 deletions(-)

-- 
Ho-Ren (Jack) Chuang


