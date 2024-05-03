Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E15C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s57am-0001k9-CC; Thu, 09 May 2024 13:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s57af-0001iC-MM
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:29:59 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s57ac-0003dS-Lq
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:29:56 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2df83058d48so14151731fa.1
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715275791; x=1715880591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8CWrR8s0gYDS+czdwwl88oUb1Zx/cHo9QTV6MX+PdaQ=;
 b=l8G2ZldDPR3sMTe1OG0CaTqt+cJor058RUWIuj73m2B0xi9aNzRpwVInyqkw0+kIvt
 R/sDfPgQXItrXF7wBu4pgqZyiYaabuO5szB37owpKSbdp/SOP3V7hCcW12GOxN4qYGZD
 0pRdOIqM4wntOrmyqpiSLc6eTJpjB41NUfgSTkJkWQphKCNxalQfyIqruyFOuNoZt+qP
 5MZThjK5jBL9yfYCDrJSVaz9ca1XLb/o+hsJCuSZJ+4O4VbDG3Yepfp7sjUl6VktSNCU
 K4RTar5T1U0rcpbyCtAW9lmG8QWUU/UNXHDB+7dqMoP9AU/kT0W9pk13ppcfZU9u91K2
 qw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715275791; x=1715880591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8CWrR8s0gYDS+czdwwl88oUb1Zx/cHo9QTV6MX+PdaQ=;
 b=xLAGQh/qC8VfmsCWbNI7DdNgd2mGBRK5L+57swp4YrIhWHXSfHZ9hQ98u5ruOLWzXl
 ReqP/mHCq4oQlC8ZrdBlFDUumZVEbqcK3uGnwkyksan+v6AFSyNoMnb+8+PvLv/vsDA1
 XXGhQhgSxhZkdTYknjSTwxHFh3GIrDpNKjjz5xqAYZxyFs+z3cZRRHfw9bKZqxvpZoRo
 5CncEaU1JDywunO4oh/ZZVItUk/QDDAD8Y2HKMebY70wqT2dwUn299ntIxNcOj2ADGI2
 c9mgggF5yNn1x7jJoKfsX2XcAaQJEzLgrOuJpSIjSvhbja1wkX3PUt1xw/50KIiIr9Ks
 +I6Q==
X-Gm-Message-State: AOJu0Yz2kcWkvH1jRqkzDsFCBYdLSOjZkdUm1zOoseezVse6aWAM2VZ2
 kpVBGd5aCZPmJvX99Tgpb25qnNc2uv4hiD9OtobQ6F3W+Kokv0aBmxEuAZx8
X-Google-Smtp-Source: AGHT+IEqPcOqKJgEtzLBhZogEkbqeGe1tWfxm6fA+Z6yvRB5yQwN2WVk6iss6MyCzgHI/1kn9iQ+GQ==
X-Received: by 2002:a2e:be13:0:b0:2de:25e2:6187 with SMTP id
 38308e7fff4ca-2e51fe57b06mr778381fa.23.1715275791414; 
 Thu, 09 May 2024 10:29:51 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e4d0ef229csm2555471fa.66.2024.05.09.10.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:29:50 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v5 3/8] xen: Add xen_mr_is_memory()
Date: Fri,  3 May 2024 03:44:44 +0200
Message-Id: <20240503014449.1046238-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
References: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add xen_mr_is_memory() to abstract away tests for the
xen_memory MR.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 hw/xen/xen-hvm-common.c | 10 ++++++++--
 include/sysemu/xen.h    |  8 ++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 1627da7398..c94f1990c5 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -12,6 +12,12 @@
 
 MemoryRegion xen_memory;
 
+/* Check for xen memory.  */
+bool xen_mr_is_memory(MemoryRegion *mr)
+{
+    return mr == &xen_memory;
+}
+
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
                    Error **errp)
 {
@@ -28,7 +34,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
         return;
     }
 
-    if (mr == &xen_memory) {
+    if (xen_mr_is_memory(mr)) {
         return;
     }
 
@@ -55,7 +61,7 @@ static void xen_set_memory(struct MemoryListener *listener,
 {
     XenIOState *state = container_of(listener, XenIOState, memory_listener);
 
-    if (section->mr == &xen_memory) {
+    if (xen_mr_is_memory(section->mr)) {
         return;
     } else {
         if (add) {
diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 754ec2e6cb..dc72f83bcb 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -34,6 +34,8 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
 
+bool xen_mr_is_memory(MemoryRegion *mr);
+
 #else /* !CONFIG_XEN_IS_POSSIBLE */
 
 #define xen_enabled() 0
@@ -47,6 +49,12 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
     g_assert_not_reached();
 }
 
+static inline bool xen_mr_is_memory(MemoryRegion *mr)
+{
+    g_assert_not_reached();
+    return false;
+}
+
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
 #endif
-- 
2.40.1


