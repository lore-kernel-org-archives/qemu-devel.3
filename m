Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A73C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJy5-00068r-6D; Wed, 29 May 2024 10:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJy3-00068g-9g
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:07:51 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJy0-0005iH-TO
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:07:51 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-529682e013dso2497104e87.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716991666; x=1717596466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfQU3CIk8oi6JUEGcx9QZf/9+B1Oq0qqW+7JWEaNpUQ=;
 b=Iaay3tqJUP8MRoVNmOZFyTmUHOtEFJ9Zpamgnvhx6bK9CxAHtBkPlRo3sfi8/xGrHe
 d/ca0vPWKSBlApR8r8Nxm3kEnGY22zqaZxcMOMoQTVhc2JL0c2sBSbgPP/ySwwWrfDB3
 sPmE0raFHxnrq9rzuwWR6lUDOWYaQJZYaqniJ1GGGfYHuH2wuljaaT6OAOZ0Lz3HRqIt
 BPr9prqSmxzPv7I7rWPscZT9v81SBQGo89/CjROTPRGUKO5tppsXsFfWhHWQJR83887B
 OjIL1mIGRjxuSNYcLJFrTFYuEiZSxOD+9XUIsvuNjTLP8GdHNEOIzjndOJjtnP2wfUXz
 828g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716991666; x=1717596466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfQU3CIk8oi6JUEGcx9QZf/9+B1Oq0qqW+7JWEaNpUQ=;
 b=CtAQmpknFGktCuATWjDLw7XYPUaTaHDfA2kbv1trzf91tVdFjDfhCy1FKaKjpZekNv
 oUvFoEt7iBzFaeAMhKDtbLVelXRtdXC2e2sDFH7/OQ+3Ou3IanWHcZvKl+daKYsyVWCa
 paiJjx5Jdz/FdDcf+bzHC2Ab7ySIQgvgp+mmSyZNYode9K4L91YXD+dQn0HtgBMXWkM/
 iywrVX79dBJ+OrcSyevKiFPYAvllkKk3sHoUMrr/h7aQvJRqMc0m9WhNnUEIJFhiGh3p
 G/4lbIw+t7Soy1WMKl85hk+QcDACCig5x3gvCBLlA9EN9nqKle3eUa1r/ZJnVcx6Dfpj
 eLRA==
X-Gm-Message-State: AOJu0YzVnjdYznrCgGulTz5xRThpf6S1pJsJWh4lf3aXru6psprjg1Ag
 ytNPSnSST7lk0r+DcwFTkBqOi7HMxf0gnePSh3gNdVJVmo4/17Z3hkLvIEmg
X-Google-Smtp-Source: AGHT+IGzkXOYSImMOV6N87l6JZQ270Dpu6VtX1s3RWgHcPsFkFEwPwb1/bHSmEc0ivZv+7V/GBf3hw==
X-Received: by 2002:a19:2d48:0:b0:526:92d7:52d4 with SMTP id
 2adb3069b0e04-529bea19e84mr2711966e87.61.1716991666190; 
 Wed, 29 May 2024 07:07:46 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-529715e57c1sm1333816e87.286.2024.05.29.07.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:07:44 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v8 3/8] xen: Add xen_mr_is_memory()
Date: Wed, 29 May 2024 16:07:34 +0200
Message-Id: <20240529140739.1387692-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
References: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-hvm-common.c | 10 ++++++++--
 include/sysemu/xen.h    |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 2d1b032121..a0a0252da0 100644
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
index 754ec2e6cb..3445888e39 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -49,4 +49,5 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
 
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
+bool xen_mr_is_memory(MemoryRegion *mr);
 #endif
-- 
2.40.1


