Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCADC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSI6-0002Bc-7i; Mon, 14 Jul 2025 19:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHB-00068V-4g
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSH9-0005cv-8Q
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DCXoXH19gfUig4lVOGC7ZRvMR0X5CUGZ6lLZHnPrrw=;
 b=Kez5/JRhgMTXpKhpGsgFpMvcdX87by7IuEgQArkwg/9JKFYo+R2l6OpfO95nB0TMbxJQuv
 5AFuoGa4fnmE4Wm+J39+mq+Q0AioSYW1FWvreiOCsU43Rj8IM3ukS2U4eWJ3r5xY8Aw007
 Kf7JB15CN75uHdvqVgn19TzIOXMlEJc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-4y-s-VuqOX6pVcnr_HCytQ-1; Mon, 14 Jul 2025 19:07:57 -0400
X-MC-Unique: 4y-s-VuqOX6pVcnr_HCytQ-1
X-Mimecast-MFC-AGG-ID: 4y-s-VuqOX6pVcnr_HCytQ_1752534476
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-453817323afso30140345e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534476; x=1753139276;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/DCXoXH19gfUig4lVOGC7ZRvMR0X5CUGZ6lLZHnPrrw=;
 b=lT3dAk3gkWaBZS5DQfw3jw+LjVRklv24tRZbbMNwbuNcGqFLRxn1P6IFv/sVQrtu9a
 M5grx0aBE4rFhuEyLp4t3oZphFq/FHfnERxB8xnoF9V+vyI4trkjA6xjJMutr0RJpCKJ
 AmDMajQ5S6A8RvGF9ucIWZGAg1N5jKvPHtGBvjdYceRqLfYOenJxQHAYIcOFDrQfIe7h
 s2xF5OLP0+W5gyXMA0GhWR2JWjp2bwAYk/O0zbj69WO7fMW6thFvmIWOwoOp2EbwfTRV
 I2UMN6mGAPNe2S16UarMSnlxZzsp/VHyaB/H2ZT7rem3Y5kqBlz30KUuhwPe8QkzvnZC
 42QQ==
X-Gm-Message-State: AOJu0YyxJoayScmee/pEVv1YDkPD7gGMet2ms8b/0NqiZxNgmnrAL8Vv
 ywY65lvXLmXU/IUgRrXwVlFSMZYcsxkO1jbeZIYZGs0S/XFHCeMLFWodYmJoiLA+tDhbkKdLyub
 RXSeYfSwCL9sJJeR3BOeEYL7l9z+tlFzaqFI0faqt/QiQn5GUI4Ay6tvRRTjSqPqUvp6gXPovcn
 o4Yiiju8A8yYA9OqEOoUgxY9M9poyoKmEF6Q==
X-Gm-Gg: ASbGnct5opp1AJpwIw12L5RG4CrkR9qbKWRRUXR/+LixUwmO3vw+ByW9+i4u7TrY6yk
 JrPuWyWpJpIxi33RRP7bKq/pt71/MqP/fRTfaP2dzu9GPZihdJHWTbdtq1LeH37WKKrdkfpcmvW
 0Z/TvAhVaOnfhaCbL5yxqCAGlGR4HCt2AUsTsyr/m8s0mGRSXKa8ay40/UqG2a+ZgGEl7xaOgBT
 sBCvaM876J3anHeqWRRmbw7uUSdYgBbjpQEa8IoNBZ48VDIvHcrVqk+A6wg9oRGxkkLD5LPVKEt
 r7aJ4WyXdkuvi2eoTC2iGXum4FN5v0Tf
X-Received: by 2002:a05:600c:3513:b0:456:f85:469b with SMTP id
 5b1f17b1804b1-4560f854858mr69338845e9.25.1752534475979; 
 Mon, 14 Jul 2025 16:07:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/hvhp3+Lc4SCDYGY1djJZvTqk84QAxmDoG0bJVlXqiTSEhPm93Mwt5v091pG+91JnXtqwIQ==
X-Received: by 2002:a05:600c:3513:b0:456:f85:469b with SMTP id
 5b1f17b1804b1-4560f854858mr69338605e9.25.1752534475541; 
 Mon, 14 Jul 2025 16:07:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d719sm13688185f8f.54.2025.07.14.16.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:55 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 39/97] target/qmp: Use target_cpu_type()
Message-ID: <877f7c5a419ed48b0bff3833156e23921764280d.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20250708215320.70426-2-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 target/arm/arm-qmp-cmds.c             | 3 ++-
 target/loongarch/loongarch-qmp-cmds.c | 3 ++-
 target/mips/system/mips-qmp-cmds.c    | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index cefd235263..d292c974c4 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -21,6 +21,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "hw/boards.h"
 #include "kvm_arm.h"
 #include "qapi/error.h"
@@ -241,7 +242,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
 
-    list = object_class_get_list(TYPE_ARM_CPU, false);
+    list = object_class_get_list(target_cpu_type(), false);
     g_slist_foreach(list, arm_cpu_add_definition, &cpu_list);
     g_slist_free(list);
 
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index f5f1cd0009..1d8cd32f5f 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "cpu.h"
@@ -32,7 +33,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
 
-    list = object_class_get_list(TYPE_LOONGARCH_CPU, false);
+    list = object_class_get_list(target_cpu_type(), false);
     g_slist_foreach(list, loongarch_cpu_add_definition, &cpu_list);
     g_slist_free(list);
 
diff --git a/target/mips/system/mips-qmp-cmds.c b/target/mips/system/mips-qmp-cmds.c
index d98d6623f2..b6a2874f2d 100644
--- a/target/mips/system/mips-qmp-cmds.c
+++ b/target/mips/system/mips-qmp-cmds.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "cpu.h"
@@ -40,7 +41,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
 
-    list = object_class_get_list(TYPE_MIPS_CPU, false);
+    list = object_class_get_list(target_cpu_type(), false);
     g_slist_foreach(list, mips_cpu_add_definition, &cpu_list);
     g_slist_free(list);
 
-- 
MST


