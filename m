Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008FAC25B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 10:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sASWz-0006Y4-Bq; Fri, 24 May 2024 06:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWr-0006Rh-7V
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:05 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWp-0007e3-IF
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:04 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e564cad1f1so98622171fa.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716547921; x=1717152721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YP28Iks2aCd2MOvUAbQc4yYuz/leCz2VtuKFu0fMfns=;
 b=ZwHKbq3LDOHkEFAlX7VFhqlOjB5h6uB5MhgEmvbGUA4OvEq3DW2Ca6DMDsxcaCcmji
 r90N8/OK+nB3wolEs2IQBJcgl94PKiYlyBp4Z+uJyv4tOniqqKFLrwk8R3soN9udgyX3
 r+YJU0tPo5MKRvk5CufTKSYmJpkencQ2zGx1c7HxG3P7j+6/+IKQgwkWlL3bXyulor2x
 5ge4l0bWcY3UwE2MS888OvogZm+ZOJgPvaEhZVkLziHNjL29k7eJHuSNYR8BHAj9W5Um
 FkY8q2roh1P2+8uipCTL1hob238Qm3p3nBuGK2H2KnqhaC1xVYjDjnbx6mLg06OQ4msE
 tCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716547921; x=1717152721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YP28Iks2aCd2MOvUAbQc4yYuz/leCz2VtuKFu0fMfns=;
 b=GYkcbBx5NJ7LRBGbX+r2S1v3JAPrXNqHy8mJQFBc90z8aOCpPaVoVbYtTbVGBkeUbA
 lam/LfAEZBSBw5YPVEOabpBw6P3F3uqxVGnrnFqfyFu4LeO1reQ7tvXzOogNEvxOJWU/
 1H4//vt3pK991SiXQZUdzvFBfso9x9Y9KQUqO2fKQwOIv+MA0q2NI9onrxYwgYC24nVP
 WnSVGkw/WjdMVioSR9pZPiA0rC+7+USCZvCNjH4EM6pwQLozkQ64DMCjvH7WrP32x7er
 wp+gVGkGIbnF1D3TjG5miPVLmasxFkuAQiAWbxhcnCpoTMi1d4KUmIaWS/nt6b02NwnR
 oLEw==
X-Gm-Message-State: AOJu0Yz0O5pFmlcmDk2JvPpwLH1/ZYrzatxQYBTpPKbl7zPu2PEm7D6D
 n9e6r9JabwAunOFgP4caE7/xXQPNSdXPRG1KQFDMzUL0UJiiJnc3JbIdQ2V5
X-Google-Smtp-Source: AGHT+IHxf48OGn9vlQXF6Pl1G+8i2NXaRVtBjeCMc7C8+mcWr77Zr/it24OxvWZYA9xQzmTZ7G5dGA==
X-Received: by 2002:a2e:6802:0:b0:2e5:67a8:2e6b with SMTP id
 38308e7fff4ca-2e95b04115amr13608211fa.8.1716547920962; 
 Fri, 24 May 2024 03:52:00 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e95be00a9esm1417431fa.103.2024.05.24.03.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 03:51:59 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v7 3/8] xen: Add xen_mr_is_memory()
Date: Fri, 24 May 2024 12:51:47 +0200
Message-Id: <20240524105152.1301842-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
References: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22d.google.com
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


