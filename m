Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AF6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9t-0008Bx-UN; Mon, 06 May 2024 03:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9q-00084K-19
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9o-0001nE-CP
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZowvef2Ajk61rQN0cGeoX5jJiq28YAn+xqA2isy+TU=;
 b=XC7LjFbXrva0/CtKVdU663I4uZYLXzAHhyU1qdPxbiroZSystC5A5usT8Dk9sC/7mRnUYb
 m+3pwYIAkTSJrw5SImcraUbH1Z2607403xuVE+v/2s/NWiG7etynPCwlBiaqS74KJ5ttVS
 IoBqFSi35RkwaIlO3SEAIh8pisqgBHY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-wpsv7GntNHK8PUBvyWqI9A-1; Mon, 06 May 2024 03:53:06 -0400
X-MC-Unique: wpsv7GntNHK8PUBvyWqI9A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59a212d874so128376166b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981984; x=1715586784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZowvef2Ajk61rQN0cGeoX5jJiq28YAn+xqA2isy+TU=;
 b=j5i+zSZzXyNv8UedAYPaGEvgV5Jwhlj182eQeoRQfhiTcsUkHyyCAEuPeRpHYfjmIB
 HA9ZIGfkiD2D0914BoSCVQnXK8LKpfQJGLMy/BCw9Yr2JcZy8ipaib1JkZ3VvuTBxK8M
 UNLH8wPl6NMoZ1rOB87Qk2j/dEZASg91Xu5MIEdq2/HDdj5mMpHLoi6N8xby4Q8e1Rey
 TLOx3fFo6NI9yfR4/1HD8aQt616FTrshZrz4+a/LmtYRRfhUPewk6l+7IVFpfQDjfcau
 rncxebR8ETKCiDB5DzRAgWXiAnhj36CcMj7MijD928HF9cgn/IY6ok+OCxEk/KPTjEPb
 roLQ==
X-Gm-Message-State: AOJu0YxAVDUIbw9rMhnJn2USho2EaMpgia3dWgroK9DJQOBE+UrXS5MJ
 1x1skY0sw46bMRBBuMH6xzkk++bVw0qgxBG2IPr/nelTMhkMFi7ZXF6U9CXmacYo2Ki1JqT3LyV
 2YNRrDbKcTwR5nT+X1e6DKXR0+Hq0neVzVmcGRWVPNNBjHcLUStlytQhQONosSt5y5nZymIyuIA
 h5cyGreMQVQ3zbQ7bjlJbWzvNEpge0hOPU94Cl
X-Received: by 2002:a17:906:f8e:b0:a55:358f:783c with SMTP id
 q14-20020a1709060f8e00b00a55358f783cmr5028644ejj.24.1714981984383; 
 Mon, 06 May 2024 00:53:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz8jijY3KIwFE9AHjVKGyPY1wMHJ0IBWd5o4GEl6R4JfEFXzujyUM8Ij2/jnmIi14sjGo6GQ==
X-Received: by 2002:a17:906:f8e:b0:a55:358f:783c with SMTP id
 q14-20020a1709060f8e00b00a55358f783cmr5028631ejj.24.1714981983983; 
 Mon, 06 May 2024 00:53:03 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 md1-20020a170906ae8100b00a534000d525sm4916791ejb.158.2024.05.06.00.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:53:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/46] monitor: remove MonitorDef from typedefs.h
Date: Mon,  6 May 2024 09:51:18 +0200
Message-ID: <20240506075125.8238-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

MonitorDef is defined by hmp-target.h, and all users except one already
include it; the reason why the stubs do not include it, is because
hmp-target.h currently can only be used in files that are compiled
per target.  However, that is easily fixed.  Because the benefit of
having MonitorDef in typedefs.h is very small, do it and remove the
type from typedefs.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/monitor/hmp-target.h | 11 +++++++----
 include/qemu/typedefs.h      |  1 -
 stubs/target-monitor-defs.c  |  3 +--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index d78e979f053..b679aaebbff 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -25,11 +25,10 @@
 #ifndef MONITOR_HMP_TARGET_H
 #define MONITOR_HMP_TARGET_H
 
+typedef struct MonitorDef MonitorDef;
+
+#ifdef COMPILING_PER_TARGET
 #include "cpu.h"
-
-#define MD_TLONG 0
-#define MD_I32   1
-
 struct MonitorDef {
     const char *name;
     int offset;
@@ -37,6 +36,10 @@ struct MonitorDef {
                              int val);
     int type;
 };
+#endif
+
+#define MD_TLONG 0
+#define MD_I32   1
 
 const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 2b1948a19ac..b71a36d02b2 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -75,7 +75,6 @@ typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
 typedef struct MigrationState MigrationState;
 typedef struct Monitor Monitor;
-typedef struct MonitorDef MonitorDef;
 typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
diff --git a/stubs/target-monitor-defs.c b/stubs/target-monitor-defs.c
index ac07b19064c..35a0a342772 100644
--- a/stubs/target-monitor-defs.c
+++ b/stubs/target-monitor-defs.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
-
-const MonitorDef *target_monitor_defs(void);
+#include "monitor/hmp-target.h"
 
 const MonitorDef *target_monitor_defs(void)
 {
-- 
2.44.0


