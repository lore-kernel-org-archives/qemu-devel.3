Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7D2C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MxL-0007aA-Au; Wed, 23 Sep 2026 09:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Msc-0000lx-1M
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:19:25 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MsY-00072s-JG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:19:21 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-328664ef783so542419eec.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169557; x=1790774357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZoknbnXiPKVvZXfcQ8PLlr7Gz40KHcVsCzqNeg5MeQU=;
 b=ETxkjmHR0BtnXT523JVTxQPtPabSHlZ6FvVVbjOtzqN1ysvl4U7szvt5Sd9SvX5YbK
 s3GA4uk6nXh4uOtH8bvlJlt0tUvYq8bA+sXHRsJvLQq3FnfCrRMtF2iJf4Ht/aP90BBh
 UhwXWAeLYlvNZQTBiWQbSPIUtp637Wj7Nn6M0ufKHH1+c5Q/DhaptAliM4clKmy9GPcZ
 Ir5oNUObSFGTJflqE0LJjAiaDjNRincsD3oqOAabiW2GBs2ISPzVYHVl1kYPr9v/mOdN
 Sm84gvy8h15hmpbikf7ltYXQgUk05nHESkRAonDQ1pIFeGvfwrdcBxjH9565OtTI386c
 +vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169557; x=1790774357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZoknbnXiPKVvZXfcQ8PLlr7Gz40KHcVsCzqNeg5MeQU=;
 b=QjmSDgbxy73BudJ452oHNPLH43d4Uq3Ulm5NjWNLyzomKnNFAo7R+idFh0yXYmbU4e
 7u+vff47E5aEJKj4kVKbNA24W6faq1Jt6KilDv8xE8Q9BF5rH6cnPITcY++7KpwhvHzR
 a183A7jePSg2gjeYBS86TWUO5aQtqRjjXg+xrLBA76gua2uLAbyCqNv1PU9OSkKqpMjE
 DjOFitI1OOch3G93wsp/jcsN+fQR70jONyaHgg6R+AM9Lsyl/aP4AKmXR+oTk4B1310D
 JSgvY5vP9G38aSrYDIMYhFN77ClbxN4uw1DlrW7bAEdlrt+gmn3Ra4ubWoFwnjvkUPs3
 /RZw==
X-Gm-Message-State: AFuF++mMynKLrLjXnIYGlf7d7FhTLbZp5vE/XCB95zQwGGVxbp1yc/oY
 GIMKb+YDMdmOxRmrmHQQocXOpLKYTDLJ5avJZKGwEYNVxgaqysv20AceWoxP7kD7/ZA=
X-Gm-Gg: AYBFou0VyevD3rUICZt/GJ9jnCE2cC7gYRbKKsIFERRUzveiCZpmbkXyka9PX72a5rK
 qBT71YeyTbl9yNv288JcscOaQyNSzlAFepKTyT3NQasJMRs9Yxdxr4wOCWNF/X99Z2qFJIAYvB8
 YfuQkbksSzfJSFoIItHVYINxNFopaSHRQlgS15QRuUuIhqZXxF/tANxFRHPzBZz9Eu4YnaNhO6q
 KnasKzROauePw2v/ojLpiLVNgq3Cbpz/2qIls9oSZtPp0TF57O0pZ7sKRHY4+HSDVnF90Aa1v/6
 nnrzbwO3gJBwm75gdPkESpiDcIpxCzqHpTuzRUTCCSrYMRlzrz9rh9TTXim3KscqnQE8tp9FP1b
 kW6zVyhtgRISAwLbA+BMjxLhLnwO/5zXOVho/4Ce6xAvGsmRbMZCyrvU7BRitLofZXx4uCvOQMy
 38mMj45Y7X25uDUtr8sLgqEvThAd0ClGYDyjmoSUxD8kyTb87ORxatz+Va9OZcQrfO7CcqGJ/xn
 R/Tt0E+Emxrtex8Vj2cJejkGpz+iTsCOECJQBdQdQ==
X-Received: by 2002:a05:7300:dd05:b0:33b:eea2:cbfe with SMTP id
 5a478bee46e88-33e8dec5b02mr2370454eec.32.1790169556543; 
 Wed, 23 Sep 2026 06:19:16 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:19:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 014/114] target-info: add i386 and x86_64 helpers
Date: Wed, 23 Sep 2026 21:14:48 +0800
Message-ID: <20260923131635.1894-15-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is added for latter use with is_available.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 45 ++++++++++++++++++++++++++++++++++++++
 target-info.c              | 36 ++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 89656da1ca4..440da63e6cf 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -98,6 +98,51 @@ bool target_is_aarch64(const TargetInfo *ti);
  */
 bool target_aarch64(void);
 
+/**
+ * target_is_base_i386:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is i386 or x86_64.
+ */
+bool target_is_base_i386(const TargetInfo *ti);
+
+/**
+ * target_base_i386:
+ *
+ * Returns whether the target architecture is i386 or x86_64.
+ */
+bool target_base_i386(void);
+
+/**
+ * target_is_i386:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is i386 (32-bit, not x86_64).
+ */
+bool target_is_i386(const TargetInfo *ti);
+
+/**
+ * target_i386:
+ *
+ * Returns whether the target architecture is i386 (32-bit, not x86_64).
+ */
+bool target_i386(void);
+
+/**
+ * target_is_x86_64:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is x86_64.
+ */
+bool target_is_x86_64(const TargetInfo *ti);
+
+/**
+ * target_x86_64:
+ *
+ * Returns whether the target architecture is x86_64.
+ */
+bool target_x86_64(void);
+
 /**
  * target_is_base_ppc:
  * @ti: TargetInfo to inspect
diff --git a/target-info.c b/target-info.c
index 6d57cad5d33..36f75ece36f 100644
--- a/target-info.c
+++ b/target-info.c
@@ -132,6 +132,42 @@ bool target_aarch64(void)
     return target_is_aarch64(target_info());
 }
 
+bool target_is_base_i386(const TargetInfo *ti)
+{
+    switch (ti->target_arch) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return true;
+    default:
+        return false;
+    }
+}
+
+bool target_base_i386(void)
+{
+    return target_is_base_i386(target_info());
+}
+
+bool target_is_i386(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_I386;
+}
+
+bool target_i386(void)
+{
+    return target_is_i386(target_info());
+}
+
+bool target_is_x86_64(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_X86_64;
+}
+
+bool target_x86_64(void)
+{
+    return target_is_x86_64(target_info());
+}
+
 bool target_is_base_ppc(const TargetInfo *ti)
 {
     switch (ti->target_arch) {
-- 
2.52.0.windows.1


