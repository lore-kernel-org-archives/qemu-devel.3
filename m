Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA7DD3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SLg-00065Y-Tf; Tue, 05 Nov 2024 17:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLb-00062l-6d
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:27 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLZ-0004EE-Ha
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:26 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d4d1b48f3so3455138f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846904; x=1731451704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yO4H0PQU46poZcawdHKCxAwWzKVbcu49KDTCodEmFUE=;
 b=G5uXkCnQPKSLSTaocfWms1jF1mt8gdTBQ1WY24u9uQ+VYuHSEKhgMVSzmdLLxfzmsv
 rbMF6+mcnRz4iiUkw06zwBKEx8+yUvx0fs0bDOzyz6iztKJDH0VDV0carm7VnuMX9HAK
 kVheJNI3TxmWS1/aqCrcQH9vfN4ufTCae2FP/pc8sZo3by6lTk59vSZyVuVpY4rrUXfO
 RQpii4peuAQq8xQvkXreRE+zo818S8UhFwpt1j1hu5e/dz2A1krNQLu/m7pjGHjjwIlH
 QgK6eXUFZjSjBOc0X737CfgeETCUerg/knnLcCRbhUf1t3ouubiG3zNhUUMW6M12baF3
 9X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846904; x=1731451704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yO4H0PQU46poZcawdHKCxAwWzKVbcu49KDTCodEmFUE=;
 b=PMZmggsd8Jwa5rsePdeSq8f5dEErTKdVknh8MhbVxWCf9NmUVUeS5RnOBMhejHiPRv
 XrDSzODRzbKRSDv6jgGAVaestu+ESnw4XGil+iktBol2GAtmXGqAhOBcDpFjSrEsLJVt
 LtO0X1pTBQAUfWUmPfbHUvyW6T4rLl9ZcPxkNep13xueXPS3E3MPMn7c5LOmeUxj/7Uc
 xO7sQimNFMCztMNd9NFvcku+kqFwZrn6AV2CcgRpKhejArFxtL8i1aXo5kKBv3JSwPyE
 EZNhjXFa9cPtrM5cobycGUjKopmRF6eKQaUs1W9KGw+GVWLvZAxzU76/oL8GzRKuYImw
 Q0Ow==
X-Gm-Message-State: AOJu0YxCGTMhVoP6yUEGf2deNDfz6uoDDDre2/97Yoyl4CKIfntT5Jxk
 QdZ6zd+OxVmSrfEFTZadAb4bymCKEiUmHzb2XefXh8LcHZlk/pozhxI35dOMnjjsMhj1LAfV4Ho
 4yKx9/Q==
X-Google-Smtp-Source: AGHT+IHvN25WsBvfZJLyuxKIT55PHYhNcg4cTWo/PSDGzc0icZfRcaZzGZFHe1JfYMi5TT58x1bE7Q==
X-Received: by 2002:adf:ec4f:0:b0:374:c614:73df with SMTP id
 ffacd0b85a97d-381b710f3f4mr16151267f8f.57.1730846903726; 
 Tue, 05 Nov 2024 14:48:23 -0800 (PST)
Received: from localhost.localdomain ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d4983sm17248159f8f.33.2024.11.05.14.48.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:48:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/29] hw/core: Check smp cache topology support for machine
Date: Tue,  5 Nov 2024 22:47:08 +0000
Message-ID: <20241105224727.53059-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

Add cache_supported flags in SMPCompatProps to allow machines to
configure various caches support.

And check the compatibility of the cache properties with the
machine support in machine_parse_smp_cache().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <20241101083331.340178-5-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h   |  3 +++
 hw/core/machine-smp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index b3a8064ccc9..edf1a8ca1c4 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -153,6 +153,8 @@ typedef struct {
  * @books_supported - whether books are supported by the machine
  * @drawers_supported - whether drawers are supported by the machine
  * @modules_supported - whether modules are supported by the machine
+ * @cache_supported - whether cache (l1d, l1i, l2 and l3) configuration are
+ *                    supported by the machine
  */
 typedef struct {
     bool prefer_sockets;
@@ -162,6 +164,7 @@ typedef struct {
     bool books_supported;
     bool drawers_supported;
     bool modules_supported;
+    bool cache_supported[CACHE_LEVEL_AND_TYPE__MAX];
 } SMPCompatProps;
 
 /**
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index c6d90cd6d41..ebb7a134a7b 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -261,10 +261,32 @@ void machine_parse_smp_config(MachineState *ms,
     }
 }
 
+static bool machine_check_topo_support(MachineState *ms,
+                                       CpuTopologyLevel topo,
+                                       Error **errp)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    if ((topo == CPU_TOPOLOGY_LEVEL_MODULE && !mc->smp_props.modules_supported) ||
+        (topo == CPU_TOPOLOGY_LEVEL_CLUSTER && !mc->smp_props.clusters_supported) ||
+        (topo == CPU_TOPOLOGY_LEVEL_DIE && !mc->smp_props.dies_supported) ||
+        (topo == CPU_TOPOLOGY_LEVEL_BOOK && !mc->smp_props.books_supported) ||
+        (topo == CPU_TOPOLOGY_LEVEL_DRAWER && !mc->smp_props.drawers_supported)) {
+        error_setg(errp,
+                   "Invalid topology level: %s. "
+                   "The topology level is not supported by this machine",
+                   CpuTopologyLevel_str(topo));
+        return false;
+    }
+
+    return true;
+}
+
 bool machine_parse_smp_cache(MachineState *ms,
                              const SmpCachePropertiesList *caches,
                              Error **errp)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     const SmpCachePropertiesList *node;
     DECLARE_BITMAP(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);
 
@@ -283,6 +305,25 @@ bool machine_parse_smp_cache(MachineState *ms,
         set_bit(node->value->cache, caches_bitmap);
     }
 
+    for (int i = 0; i < CACHE_LEVEL_AND_TYPE__MAX; i++) {
+        const SmpCacheProperties *props = &ms->smp_cache.props[i];
+
+        /*
+         * Reject non "default" topology level if the cache isn't
+         * supported by the machine.
+         */
+        if (props->topology != CPU_TOPOLOGY_LEVEL_DEFAULT &&
+            !mc->smp_props.cache_supported[props->cache]) {
+            error_setg(errp,
+                       "%s cache topology not supported by this machine",
+                       CacheLevelAndType_str(node->value->cache));
+            return false;
+        }
+
+        if (!machine_check_topo_support(ms, props->topology, errp)) {
+            return false;
+        }
+    }
     return true;
 }
 
-- 
2.45.2


