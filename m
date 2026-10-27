Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FAC606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lb8OcDVn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaSz-0006lN-Vd; Tue, 27 Oct 2026 02:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLaSy-0006ki-7C
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:15:24 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLaSw-0007If-IH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:15:23 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-35b2c599f43so2328671eec.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793081721; x=1793686521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kvgVTHS4oUEIV4ErChzaNlj22uaMiM4VXxQneYOKsCI=;
 b=lb8OcDVn2rbYbiTeVjhTVKrbgzx0hvWWEebVURcXHxU8OKxaIAK5h3Zy5xeTRwffhl
 A/25qjmGvM6xD+QkCOsoexzW2E4R/XvD6LXlXl5dqZHCyXt6496sme76DBPztkr+uryT
 HlDbiPPbrE5AOeugMlIXMH9n42pO49e4ocn4ZZ8Xusfp1nBjxifQAesD2L+JpBYGo9Qg
 /NePB44UDc9Y7ZVT4UE9PW1+d3ysW7y5c8eLoQwJznvS7UZKLYADZy8H2WW3BzKO38wV
 NmJJ8CzSy98QoGgbwXdu/B5MylQYd0uJH8hOJyXm/u7jfv2OA4aeCjavdr8ZIN9Dl3IZ
 Wydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793081721; x=1793686521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kvgVTHS4oUEIV4ErChzaNlj22uaMiM4VXxQneYOKsCI=;
 b=mhGNzWhYemLK1ouV635EKFxyBXJY6Ma6Lc90lIADBX17q/FwYPm80H1TzJJNljT/ca
 5XlrHB+sAL6dHk45NbnE2jIWmCl7UjoweUT0UCjBqnzp8lDxWRH9IhEJPIpcrGrznnwf
 JamBMaZyFZoj3KNgo/hXrUUfHJvvUx0V0hkVeaGTu3BZQOPuFub7cqBfzAnsZEl0GfTu
 yp3mDxwaxOQSXn1NoCdOYvx3vMYJuI5OCjzp43C7UP/4vSn98J3lNOfsEnlv8/QTSAut
 0gi/JEN+sAz9LEdCC/8jvL8Mnzp9SdYdq5ZOFrWMu3Ca8/HBFErhw68D6qJKDe50Gjv0
 cfPw==
X-Gm-Message-State: AFq9FYIx80SzJ6ItsW2HxNJJNEadpwXLeZqbWdzlKIJLZ8OX5oQaVx9R
 anADHO3tkCIzoqji/2W2qq0vHs09tWcHSuYCqcq+/7BA2AtBZWMTMwEA0X1xBaBe
X-Gm-Gg: AYBFou2bPxHjArh8n8zLqznvaCTGQpPGGQe4YfxufGLtn5N5d6aEDxN3m6XDPrNk3Ye
 0s8S5Qa4naeKMV9Vvo6onZySX2QA0IjVuESYSJGmorEbVBKfVOKT4QuZocqYfho0RmOP1Ulem+8
 pZfXKh88+NoOKzHCHaAoyK3shVt4RqR4IeDj8Lzr7RnkbfclpGZjf4PSkxN2wGhSPF7SkbvcDCS
 s2xdxkzHtc26X5ZdjpXUCpBDWdLvT/ou+qAA58EGmQVfFF0tsTsQHLKM5CqYD8HJim+VSeATuGD
 DdFIi22PMobbdGoOkLPlVgY6qD182UNwpu4CbUhUJHYg3Iv9aoo3KxpInvbMT99TmViHy+6xdEI
 Cx5bOij2xMsnkOE1Gw91HPXvgIgWYbdhHsjURORc6PjKY03/EC9Y+JV9euAY7JXQWqODMVu+hMn
 wBRo/IZPvtdt6wWI3B2w8qbQm6Kth2oggFew4EOEVHIuiTNz8zQ7fUJEwEU6bl6nZXpfM/gdXLY
 PagljIEzBWUf+RXTQ/LzrxQibrxSbXXMAYUs71rPl34MTaD4U0YLlHDdQjBfCUk/DQO+nHo5Da9
 68hvwC0svuuUSCguZNwF
X-Received: by 2002:a05:693c:42d0:b0:35d:4185:5395 with SMTP id
 5a478bee46e88-369e845b094mr14078901eec.16.1793081720864; 
 Mon, 26 Oct 2026 23:15:20 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-369e8ec864fsm37346980eec.24.2026.10.26.23.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:15:20 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] qemu: increase width of QEMU_ARCH_* masks enums to be 64
 bits
Date: Tue, 27 Oct 2026 14:15:03 +0800
Message-ID: <20261027061504.2213-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261027061504.2213-1-luoyonggang@gmail.com>
References: <20261027061504.2213-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SYS_EMU_TARGET__MAX is already 29, nearing the 32-target limit.
So increase width of QEMU_ARCH_* masks enums and related types;
So that we can add needed Linux user-mode targets to EmuTarget;
And also enabled the possibility add more system-mode targets in future.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/base-arch-defs.h  | 7 ++++---
 monitor/monitor-hmp-internal.h | 2 +-
 system/arch_init.c             | 4 ++--
 system/qdev-monitor.c          | 2 +-
 system/vl.c                    | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/qemu/base-arch-defs.h b/include/qemu/base-arch-defs.h
index a6478c2d3ff..f2e3bc54203 100644
--- a/include/qemu/base-arch-defs.h
+++ b/include/qemu/base-arch-defs.h
@@ -9,7 +9,7 @@
 
 #include "qapi/qapi-types-machine.h"
 
-#define QEMU_ARCH_BIT(target) (1UL << (target))
+#define QEMU_ARCH_BIT(target) (1ULL << (target))
 
 enum {
     QEMU_ARCH_ALPHA =       QEMU_ARCH_BIT(SYS_EMU_TARGET_ALPHA),
@@ -44,7 +44,8 @@ enum {
     QEMU_ARCH_ALL =         QEMU_ARCH_BIT(SYS_EMU_TARGET__MAX) - 1,
 };
 
-QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 32);
+/* Keep target-specific masks within qemu_opt_set_number()'s int64_t range. */
+QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 63);
 
 /**
  * qemu_arch_available:
@@ -52,6 +53,6 @@ QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 32);
  *
  * Return whether the current target architecture is contained in @arch_bitmask
  */
-bool qemu_arch_available(uint32_t arch_bitmask);
+bool qemu_arch_available(uint64_t arch_bitmask);
 
 #endif
diff --git a/monitor/monitor-hmp-internal.h b/monitor/monitor-hmp-internal.h
index 4e2430551ab..b61d2717076 100644
--- a/monitor/monitor-hmp-internal.h
+++ b/monitor/monitor-hmp-internal.h
@@ -69,7 +69,7 @@ typedef struct HMPCommand {
      *     Allow to restrict the command for a particular set of
      *     target architectures.
      */
-    uint32_t arch_bitmask;
+    uint64_t arch_bitmask;
     bool coroutine;
 } HMPCommand;
 
diff --git a/system/arch_init.c b/system/arch_init.c
index 1ad2f3d6f78..b8362b12a6d 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -26,7 +26,7 @@
 #include "qemu/bitops.h"
 #include "qemu/target-info-qapi.h"
 
-bool qemu_arch_available(uint32_t arch_bitmask)
+bool qemu_arch_available(uint64_t arch_bitmask)
 {
-    return extract32(arch_bitmask, target_arch(), 1);
+    return extract64(arch_bitmask, target_arch(), 1);
 }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 8185822daa7..b3ca619f3c9 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -54,7 +54,7 @@ typedef struct QDevAlias
 {
     const char *typename;
     const char *alias;
-    uint32_t arch_mask;
+    uint64_t arch_mask;
 } QDevAlias;
 
 /* default virtio transport per architecture */
diff --git a/system/vl.c b/system/vl.c
index 468a9fc247a..fbe580746d3 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -928,7 +928,7 @@ typedef struct QEMUOption {
     const char *name;
     int flags;
     int index;
-    uint32_t arch_mask;
+    uint64_t arch_mask;
 } QEMUOption;
 
 static const QEMUOption qemu_options[] = {
-- 
2.55.0.windows.3


