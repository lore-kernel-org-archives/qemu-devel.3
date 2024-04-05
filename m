Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DB8CD1284
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 00:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsX79-0006Bq-64; Thu, 04 Apr 2024 20:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rsX76-0006BO-Or
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 20:07:24 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rsX6y-000260-9v
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 20:07:20 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2228c4c5ac3so924557fac.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712275631; x=1712880431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6McIYZbsLclE8SOPWcjX3CynsQ0RAlONuKXKFdsbWI=;
 b=OAfG6uaTum1iswV6AKvaj2SYALq/C35pOFdNzVTLsePKshBH4alkH/puwh7+r49W87
 +YH+CElgUICGkJ57WBiO6VLP6O1i21twKjcrt9HBboGecqPwMYfUcU8PbaQQA5or7Ewy
 BUpHdYwxjYsVRQJar9BHKOfJYiDRRAUwzc5/VxybHrDjZXH0XlMsiOC8lCFFGw/yYLDj
 xHKe/C6gfgHzY6qfK/QPyLcOsTDH6WZpc4I9+9sWXLBJN1Jp/9/djD7r4IP8t69ZmTnZ
 vFDEOyvlZIMJt0T3mrKyB1OtWap7/fB4p5UTkcwXyCRzGlAA2OnizZx40k1+b/e6RKX2
 4XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712275631; x=1712880431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6McIYZbsLclE8SOPWcjX3CynsQ0RAlONuKXKFdsbWI=;
 b=uL5EY5cvcR2pi+L/oAY5/yMDC6PWn76lRxWBKeE9+i01D++pBy3fRZDX6wR050sw/L
 46xBNF48bXeMmVq/P/VH/JtE7mNTTM7euCwk+B9mJIX5YfmUxqjbrq5LPLgDhcO6ZH2+
 XP3n0JpSTC/g6bvCFToAdVmC5VfSGHeEB9ilavlUTaowcUtBYw1TgsAvV8Q7DvAZ7zBI
 LHMHDhxFz/Is9wErc9do9vLaKQnqs06xXYHXwEMKEWI8wDC7P4Iaw0lIZOTcXdBoVg7E
 2q3nJfBIZqZIMVkrgh3sOlCL4dRI3kOXvBF9/a+bxo6XNxL34Phc/ovxeLa5N96IAXHq
 E6yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYYjtBiAb4bewnefbsci22lBnqRYv2ypJfOy5FGHDusHM6KFKpAX61Go3V/q2CUpaZ9vjPvSlYAzo3/+NwYiTRFMIiKs8=
X-Gm-Message-State: AOJu0YwVX8v5mcqXdTXbNb5pBAzkwHTe2WkrxgWsBHktmEbUukFvi2r9
 4GcHcZVpIh/nhhLlwRG08U1gaVpj3Gi5RNOYPor4EYnEB2xtbuclAAzSVqtpS7U=
X-Google-Smtp-Source: AGHT+IETdG/JDjD1LulGxhxX7zA4HNJ1/USqVA9s7rf27ac8j8DzM+mrGRQqRxmrtXI7tO369pGm5Q==
X-Received: by 2002:a05:6870:80cc:b0:22e:8fe3:a9f3 with SMTP id
 r12-20020a05687080cc00b0022e8fe3a9f3mr4500124oab.17.1712275631507; 
 Thu, 04 Apr 2024 17:07:11 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.118])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a37c404000000b0078835bfddb8sm191433qki.84.2024.04.04.17.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 17:07:11 -0700 (PDT)
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
Subject: [PATCH v11 1/2] memory tier: dax/kmem: introduce an abstract layer
 for finding, allocating, and putting memory types
Date: Fri,  5 Apr 2024 00:07:05 +0000
Message-Id: <20240405000707.2670063-2-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240405000707.2670063-1-horenchuang@bytedance.com>
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=horenchuang@bytedance.com; helo=mail-oa1-x2b.google.com
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

Since different memory devices require finding, allocating, and putting
memory types, these common steps are abstracted in this patch,
enhancing the scalability and conciseness of the code.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 drivers/dax/kmem.c           | 30 ++++--------------------------
 include/linux/memory-tiers.h | 13 +++++++++++++
 mm/memory-tiers.c            | 29 +++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 42ee360cf4e3..4fe9d040e375 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -55,36 +55,14 @@ static LIST_HEAD(kmem_memory_types);
 
 static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
 {
-	bool found = false;
-	struct memory_dev_type *mtype;
-
-	mutex_lock(&kmem_memory_type_lock);
-	list_for_each_entry(mtype, &kmem_memory_types, list) {
-		if (mtype->adistance == adist) {
-			found = true;
-			break;
-		}
-	}
-	if (!found) {
-		mtype = alloc_memory_type(adist);
-		if (!IS_ERR(mtype))
-			list_add(&mtype->list, &kmem_memory_types);
-	}
-	mutex_unlock(&kmem_memory_type_lock);
-
-	return mtype;
+	guard(mutex)(&kmem_memory_type_lock);
+	return mt_find_alloc_memory_type(adist, &kmem_memory_types);
 }
 
 static void kmem_put_memory_types(void)
 {
-	struct memory_dev_type *mtype, *mtn;
-
-	mutex_lock(&kmem_memory_type_lock);
-	list_for_each_entry_safe(mtype, mtn, &kmem_memory_types, list) {
-		list_del(&mtype->list);
-		put_memory_type(mtype);
-	}
-	mutex_unlock(&kmem_memory_type_lock);
+	guard(mutex)(&kmem_memory_type_lock);
+	mt_put_memory_types(&kmem_memory_types);
 }
 
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 69e781900082..0d70788558f4 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
 int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
+struct memory_dev_type *mt_find_alloc_memory_type(int adist,
+						  struct list_head *memory_types);
+void mt_put_memory_types(struct list_head *memory_types);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
 {
 	return -EIO;
 }
+
+static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist,
+								struct list_head *memory_types)
+{
+	return NULL;
+}
+
+static inline void mt_put_memory_types(struct list_head *memory_types)
+{
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0537664620e5..516b144fd45a 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -623,6 +623,35 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
+struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
+{
+	struct memory_dev_type *mtype;
+
+	list_for_each_entry(mtype, memory_types, list)
+		if (mtype->adistance == adist)
+			return mtype;
+
+	mtype = alloc_memory_type(adist);
+	if (IS_ERR(mtype))
+		return mtype;
+
+	list_add(&mtype->list, memory_types);
+
+	return mtype;
+}
+EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
+
+void mt_put_memory_types(struct list_head *memory_types)
+{
+	struct memory_dev_type *mtype, *mtn;
+
+	list_for_each_entry_safe(mtype, mtn, memory_types, list) {
+		list_del(&mtype->list);
+		put_memory_type(mtype);
+	}
+}
+EXPORT_SYMBOL_GPL(mt_put_memory_types);
+
 static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
 {
 	pr_info(
-- 
Ho-Ren (Jack) Chuang


