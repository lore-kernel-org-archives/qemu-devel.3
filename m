Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FB7C71136
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Jun 2025 02:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQGKu-0002qv-Of; Fri, 13 Jun 2025 22:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQGKt-0002pf-6t
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 22:09:35 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQGKr-0006aj-Me
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 22:09:34 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 8A0C52806
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749866940;
 cv=none;
 b=FoepIYZXbB90bZburMfKQZC0YhulBgDbM6A67wdwTJ2dhjyagK7IVLFalw0mFy5w8h6SJKX0JP/IT25aooc3DiGXBnNgfVj5zN1a0i5s6J2HFoPmC6gA5yPJI3f91kssRT5GhmiSq7qfsWAOFADMbh32NMgxi/cBYOjSJmHxEAP0BQFr8Wc5wFFVpNZQueiyqU6UNgznIuEEbh34rYCqQJBRHTf0Xq1Pm+hjiZ/5o3AlQA1rW9/JJ0Gx0bIkH2Bou77Ge7tGNv1eNJUFkp29AEluBFDj+7+5K+1duRRlJuw+m+1kX3LpOmrOU+itcSUkMHJseATp5RjbPWDmUMXhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749866940; c=relaxed/simple;
 bh=OFgiAYNFhF4Pa/5z/yEOAjYoeD4iuxqzyU+5fqONaLQ=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=bDMJviHBmWGxj2vZ8EPePzDqu63SCeIeMI1wSyWOp6ss3wV0Lz3svQIKRiIPUHUqTOdUaieUbG0SuBBvivaFsrPVNnKor69TrhnL/qq+1XlO97Qxb79oAurGDXgIQMhnMZx8vJVSLxgt4S4XFG7a68tE6QSm7T8UajSYNsTZhAmbMrjfwgq/DNZGoWwrS3oXp0KdIqsTC3vZ6WaU5MQq3q13bijeVKnxcAD2v1w51IWXSxbQ4eSE5cjPJMvZ3B+xLq+W4AXC8wk8jUb/hFkuFex7B0M0MUxswGX/YNh1yppiRef76bgrzRVE41e5eUrdrl1JNsx5/UK0yOBx3rxvhw==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749866939;
 bh=OFgiAYNFhF4Pa/5z/yEOAjYoeD4iuxqzyU+5fqONaLQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0Md08k+b47vGppahMK/Voly0TpeBN3dDi36fPqz+G9HNBhxNkZjNA7drcNsV8I7TC
 AzWz4WVgQLF5MDfDMKFDb1uNcZPeLKXsRg1w+47cVNU2o8HfoI6p09YWU5ck4FQG/z
 44lXjD6CU20uOG4gRTBi86DAeb7rQ5igZmanJQK4tGMcNiGJcUZU9eaBiBK3GKvWD4
 yd4RRzjh4gGt69bTY0YOxxZ0uvzje+gsQiireeULSM9GefZUFvJyHklKikGuKaoit5
 8xgwoFKT1dNgQShoZ5uYXmFsp4nCTmwJJoCCrsLLCHSs0T2sdIPmiXvDTawj3dtehm
 kP7BqJzh7dqAA==
Received: from Mac.home.lla.com (unknown [207.191.242.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 8A0C52806;
 Sat, 14 Jun 2025 10:08:57 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH 1/2] fsdev/9p-marshal: move G_GNUC_PRINTF to header
Date: Fri, 13 Jun 2025 22:08:40 -0400
Message-ID: <20250613.qemu.9p.01@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613.qemu.9p@sean.taipei>
References: <20250613.qemu.9p@sean.taipei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v9fs_string_sprintf() is annotated with G_GNUC_PRINTF(2, 3) in
9p-marshal.c, but the prototype in fsdev/9p-marshal.h is missing the
attribute, so callers that include only the header do not get format
checking.

Move the annotation to the header and delete the duplicate in the
source file. No behavior change.

Signed-off-by: Sean Wei <me@sean.taipei>
---
 fsdev/9p-marshal.c | 3 +--
 fsdev/9p-marshal.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fsdev/9p-marshal.c b/fsdev/9p-marshal.c
index f9b0336cd5..3455580703 100644
--- a/fsdev/9p-marshal.c
+++ b/fsdev/9p-marshal.c
@@ -27,8 +27,7 @@ void v9fs_string_free(V9fsString *str)
     str->size = 0;
 }
 
-void G_GNUC_PRINTF(2, 3)
-v9fs_string_sprintf(V9fsString *str, const char *fmt, ...)
+void v9fs_string_sprintf(V9fsString *str, const char *fmt, ...)
 {
     va_list ap;
 
diff --git a/fsdev/9p-marshal.h b/fsdev/9p-marshal.h
index f1abbe151c..e8c0ef0e11 100644
--- a/fsdev/9p-marshal.h
+++ b/fsdev/9p-marshal.h
@@ -76,7 +76,7 @@ static inline void v9fs_string_init(V9fsString *str)
     str->size = 0;
 }
 void v9fs_string_free(V9fsString *str);
-void v9fs_string_sprintf(V9fsString *str, const char *fmt, ...);
+void G_GNUC_PRINTF(2, 3) v9fs_string_sprintf(V9fsString *str, const char *fmt, ...);
 void v9fs_string_copy(V9fsString *lhs, V9fsString *rhs);
 
 #endif
-- 
2.49.0

