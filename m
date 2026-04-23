Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98697F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtR-0006Jl-4R; Thu, 23 Apr 2026 06:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtK-0006IG-Kg
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtH-0001t3-Op
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so4400704f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938553; x=1777543353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e4SVw6/0iy8VqNnBZElqRdTaBGFeTVDwu9oinIEbAL0=;
 b=Q3YQHn/HubgLxujEtJmWVdy33TL/Lv8+zGGZ/JqOPDS5Znbj5kHJQXK/zc6KIbTxvv
 fJ6hucKX6cF4pUnsrvdxuiwbpdGlDeDytL8drbr69mLP1iR0dERiKQ3Ze0gpV4fRxPfI
 rhXYRE+NGrl0VvPAlegNg4o9APTWPWvdkx9BlwcpqAIgnb0PFeXW9BvjEtBMaDsAmmHa
 /IBHUqzTPZiw1Rfee4u1WTP98PljsNoy2qt88RMdXhXhHNl+4mVIZ+YVCXgIjZpAtvAN
 VYTmFOZlpmovHHsh+WsP+ax/BE6Jt72JcoC8kr/iScDoX0kBHq9YcDKwZc79P+XCN2Yn
 USZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938553; x=1777543353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e4SVw6/0iy8VqNnBZElqRdTaBGFeTVDwu9oinIEbAL0=;
 b=ewaqwmrU9xZGEP7VQzau2ebFcbziNtsJfUe188NAexF9BwpiiL6O9gh2SUBRxtV/Bz
 s+vUg/JTCBLZ194joXD1clGpOCMi4NfjwTeP3mN1U69NjNjfXO8EZkR2uuVms4VSmBOx
 Wyz+V/aTHTtih+kkDwCAXIOngW4odskEG3ricjP8jfAdeHpsppK2RFxExOu5Ko4+OBld
 GGAvsLfFPVs9ZpY5XqcbKas5W+R61Gv+439JkzdwrplkZnpc9nDduqhSPBXYNLGyN4W4
 fFujUcXX9Jb2jWzEAKj+05VLKuiUrpdfP9m9lGOJDbARX1ykJYBWDxCtUAW8i2bgsN3y
 Jz7Q==
X-Gm-Message-State: AOJu0YwQKiw0o/uEnEaPHR2lThRHsQh7wOp1/BYBuOSMUYuF2w/aafkI
 i70079WrmpLv5T3tFg4/kP5O4EDIOYvxFqD8VFr3bZNwkBnVM7r+NDexzHy9iO7qFo6+lfpmb+r
 zVlVf
X-Gm-Gg: AeBDieuesy7Rov4G8F8UlnYgQpeu1zspGET2RNEf3/f7+EbA3bjVfgmd7HrQZC0R+A3
 iyVuZpxeEs11uu1TJA891jsa8Wr4EX2NWCv0P3M33oXpto2DCoJC+V3jObuIS4GD3qOk0D5OCZT
 2kdKvQouAv4uTl+65eHM9Hao5iB3uBz9rQD7TWISQlXXeyVcGl1B/EihSyMPqkZGgnn8EwQ+D3v
 CjAFcf4Zdgby/r0NNMtZWe4V60TZQ3qeB6pf+GCRFU96RE58Chlq4weN9TGn/feaJ4rtyOgfmBy
 Y/B5OUG4IaGh0g8t9QlS+P5tBndSHVac5QCUX8D9KcHRkVqfbr8RZn1Ezcw9huvFCf/mVR3OyKo
 jGHSVOlHotjImEcRQPTIze+qJ29teAB33+sZs6eVA/qtLCD5sPUspUAFF7gWz04jLTrJ6z1+asr
 bljwBGV/yS9y8VmleGAR2sEhGj0hjAWFNE8unk1wfNvCV2bxoAobKODBOeI+mWIGo5FsFy5tzov
 9Ols/TS2s7Gg4EucW+fOO5CTnMDwsMZE+YKeQiBGQ==
X-Received: by 2002:a05:6000:144d:b0:43c:fe0e:5bbc with SMTP id
 ffacd0b85a97d-43fe3dc59a6mr39049155f8f.19.1776938553227; 
 Thu, 23 Apr 2026 03:02:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/59] hw/core/machine: topology functions capabilities added
Date: Thu, 23 Apr 2026 11:01:32 +0100
Message-ID: <20260423100229.2941820-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alireza Sanaee <alireza.sanaee@huawei.com>

Add two functions one of which finds the lowest cache level defined in
the cache description input, and the other checks if a given cache
topology is defined at a particular cache level

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20260311160609.358-3-alireza.sanaee@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/machine-smp.c    | 52 ++++++++++++++++++++++++++++++++++++++++
 include/hw/core/boards.h |  5 ++++
 2 files changed, 57 insertions(+)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 189c70015f..bef04aa2d7 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -406,3 +406,55 @@ bool machine_check_smp_cache(const MachineState *ms, Error **errp)
 
     return true;
 }
+
+/*
+ * This function assumes L3 and L2 have unified cache and L1 is split L1d and
+ * L1i.
+ */
+bool machine_find_lowest_level_cache_at_topo_level(const MachineState *ms,
+                                                   int *lowest_cache_level,
+                                                   CpuTopologyLevel topo_level)
+{
+    enum CacheLevelAndType cache_level;
+    enum CpuTopologyLevel t;
+
+    for (cache_level = CACHE_LEVEL_AND_TYPE_L1D;
+         cache_level < CACHE_LEVEL_AND_TYPE__MAX; cache_level++) {
+        t = machine_get_cache_topo_level(ms, cache_level);
+        if (t == topo_level) {
+            /* Assume L1 is split into L1d and L1i caches. */
+            if (cache_level == CACHE_LEVEL_AND_TYPE_L1D ||
+                cache_level == CACHE_LEVEL_AND_TYPE_L1I) {
+                *lowest_cache_level = 1; /* L1 */
+            } else {
+                /* Assume the other caches are unified. */
+                *lowest_cache_level = cache_level;
+            }
+
+            return true;
+        }
+    }
+
+    return false;
+}
+
+/*
+ * Check if there are caches defined at a particular level. It supports only
+ * L1, L2 and L3 caches, but this can be extended to more levels as needed.
+ *
+ * Return True on success, False otherwise.
+ */
+bool machine_defines_cache_at_topo_level(const MachineState *ms,
+                                         CpuTopologyLevel topology)
+{
+    enum CacheLevelAndType cache_level;
+
+    for (cache_level = CACHE_LEVEL_AND_TYPE_L1D;
+         cache_level < CACHE_LEVEL_AND_TYPE__MAX; cache_level++) {
+        if (machine_get_cache_topo_level(ms, cache_level) == topology) {
+            return true;
+        }
+    }
+
+    return false;
+}
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index b8dad0a107..f38b3f5f78 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -60,6 +60,11 @@ void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
                                   CpuTopologyLevel level);
 bool machine_check_smp_cache(const MachineState *ms, Error **errp);
 void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
+bool machine_defines_cache_at_topo_level(const MachineState *ms,
+                                         CpuTopologyLevel topology);
+bool machine_find_lowest_level_cache_at_topo_level(const MachineState *ms,
+                                                   int *lowest_cache_level,
+                                                   CpuTopologyLevel topo_level);
 
 /**
  * machine_class_allow_dynamic_sysbus_dev: Add type to list of valid devices
-- 
2.43.0


