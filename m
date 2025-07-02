Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19730C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2dk-0007Cl-Gf; Wed, 02 Jul 2025 14:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dM-0006CP-4s
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dI-0002V7-An
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so48441905e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482592; x=1752087392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ShL4sT3CKcvffos/mYfFqk7qnaBIZqn7K5GJ3zuDgto=;
 b=op4LTWoy0zztnXF8jmZ6exKDy2M1OHEDrp+lSWrR8IBBO4kEiCPYJat5Rqy0gytJbx
 yckMDQ9mKzrMSpT4stZKg6y+MtWQvz25axuhN75NmQxCAMGUv6EPc8GwP8mUplsAyAWH
 mVU1sZUuR8U5EFua6rpxMVSB9IuQraMDRpZLR8fRxxz2o9KwkymM7DHLO/gTlSmp8pxZ
 3xj5z7bOwW3iPxNpppeLA7hPwBbYPt9A9J1CMDqYQdnvLxN/JV+xExEFE7hhX97ERxoK
 lj1bdZVFWXvBoKm9z8/344uyaCqnuA6zulwjlEwBIETgtAf+YIes36X+arofwjxxYLdj
 bK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482592; x=1752087392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShL4sT3CKcvffos/mYfFqk7qnaBIZqn7K5GJ3zuDgto=;
 b=CRlhJwCWRt4HDcC0qFmpgJEBP2MrxddbhaaWZDk7ZxP5jE4RVvArOHYm/KwYjoDug8
 kdN+v3wv4WCj6iGD4/CowwVRUJAFKFlfzWMJiAYWDARHKwWFbP9XOHlMBUnIfpDmut76
 RnZqInNCNcn0vf+lx1ZbtXl2+YiCKWildWQyZ128CqkQH1LEPLzZk4PTCWatPDAvNjvn
 efI4IniFN8NM9ypZKp2olELDSTcHIxlf7LmZmKpyFxlGv8iXG84VqKo4LRMBsNZ7pNCM
 VStx9+ZlMPssJ9Iv11FX1OmuzCN5H0vPBMg1pchOmFbRov4LLhgEKP/HlaWqC/n2BmP5
 H5Yg==
X-Gm-Message-State: AOJu0Yz1FlCm/epPRs2Y5BEpD0HfahKCNxzLWMG0X94szptpFvJ/pco8
 z5/ml3ZoTbb+yLiEG1HDW4gRCO4xMhFCQd9d+7Dgfc7RATW1VVjMPwvJgr/xfO7b/EJwfMe89AE
 5YUYP
X-Gm-Gg: ASbGncuSd9p8IiYhJlniQe4XjeTV9UIQaxktGo848cCK4p2DMjY5B7b67UcVqoJxKdn
 Ak8W7x6vFRAkjfAuqOzl2vMric4TxMopCRny7DS3n0T9Ruv4v8RwRuh+zdoUNCPEvpRSYG6YLes
 PfsjXDt1HW/sKIMP1yjqI+3eMx180RBQ8J/VCWKeaeGNdo94cY92oSEFeFDEIQnHKq2v+jHDVsg
 Neng46NkyQTqttg5iUM3npimPwjLJoswYnPJ7KvvgTc2vtVs5kD3TPoYNfMeyDTvxDN7iVOHO9X
 EKkKCVn6YBhA5o+ReiKeBYaAyR/jfT6Pg2rvW/OBih8wZh6cDxsXuF838i5D1yWfgZYxkABt5Tl
 81+XKe4oY9p6E8XEMMic9TEI9CRlHLDkHjIs0op9SRVsD7Jg=
X-Google-Smtp-Source: AGHT+IEAVgQQxwvmqX3+tsH6VynoKvLFEkT4fNSM+VuXZjq490LyYmmEx91jgBs2ZgpO7IMmeNIpEg==
X-Received: by 2002:a05:600c:1388:b0:450:d00d:cc with SMTP id
 5b1f17b1804b1-454ab368e3bmr50675e9.2.1751482592330; 
 Wed, 02 Jul 2025 11:56:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9989423sm5633385e9.19.2025.07.02.11.56.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:56:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v4 24/65] accel/system: Add 'info accel' on human monitor
Date: Wed,  2 Jul 2025 20:52:46 +0200
Message-ID: <20250702185332.43650-25-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

'info accel' dispatches to the AccelOpsClass::get_stats()
and get_vcpu_stats() handlers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/accel-system.c |  8 ++++++++
 hmp-commands-info.hx | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index 246ea55425f..6cdfe485c29 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -25,6 +25,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qapi/qapi-commands-accelerator.h"
+#include "monitor/monitor.h"
 #include "hw/boards.h"
 #include "hw/core/cpu.h"
 #include "system/accel-ops.h"
@@ -112,11 +114,17 @@ void accel_init_ops_interfaces(AccelClass *ac)
     cpus_register_accel(ops);
 }
 
+static void accel_ops_class_init(ObjectClass *oc, const void *data)
+{
+    monitor_register_hmp_info_hrt("accel", qmp_x_accel_stats);
+}
+
 static const TypeInfo accel_ops_type_info = {
     .name = TYPE_ACCEL_OPS,
     .parent = TYPE_OBJECT,
     .abstract = true,
     .class_size = sizeof(AccelOpsClass),
+    .class_init = accel_ops_class_init,
 };
 
 static void accel_system_register_types(void)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 639a450ee51..0496be6abfb 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -281,6 +281,18 @@ ERST
         .cmd        = hmp_info_sync_profile,
     },
 
+    {
+        .name       = "accel",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show accelerator info",
+    },
+
+SRST
+  ``info accel``
+    Show accelerator info.
+ERST
+
 SRST
   ``info sync-profile [-m|-n]`` [*max*]
     Show synchronization profiling info, up to *max* entries (default: 10),
-- 
2.49.0


