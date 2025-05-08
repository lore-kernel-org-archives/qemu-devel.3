Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DE8C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 09:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCxxl-0003QH-M7; Thu, 08 May 2025 05:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCxxj-0003Pw-9d
 for qemu-devel@nongnu.org; Thu, 08 May 2025 05:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCxxh-0001Hb-Kx
 for qemu-devel@nongnu.org; Thu, 08 May 2025 05:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746698080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Iibwwyi5W0D6zz6AXlnAP/ozqACug8CvhufUCjgPp3w=;
 b=CjEyJQNUaft5RrZP6kOmDmpL0EqDE5lMhcJVMvejlxzmYISxpGjKM3xkJV1F/nqOFrMHER
 BBYUYHbMDb6m6oHStSPmeeFWI7AQds+bvOt+soPcuCD55JUt1j61YIIhFQH1NpHAPyaMz5
 h9scLFhDb6ZXIaPkFK+JPzs5nkr2rVM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-HcUoE7xnOMWHG6L5jPnpEw-1; Thu, 08 May 2025 05:54:39 -0400
X-MC-Unique: HcUoE7xnOMWHG6L5jPnpEw-1
X-Mimecast-MFC-AGG-ID: HcUoE7xnOMWHG6L5jPnpEw_1746698078
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442d472cf84so411785e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 02:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746698078; x=1747302878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iibwwyi5W0D6zz6AXlnAP/ozqACug8CvhufUCjgPp3w=;
 b=pH0nr8yRWbKyuukqbAU0yCHoDXjWpp2Q/rkCMduHs1R+8/M/Q2CBnSbORnu2CgfGTH
 rdbt8i338de252JV0U3AAw1oac8YgYoIxoNGTrvdwxAz0CaA4E2xS2jb0kd4DyxMgqtj
 7PIHiAqy/tymt3KWpHwDvI3ok6TYL3L6xn7caWe5T5JLsaxopmJr7aHFbxLoyctn+sjj
 Vsd6qu8fH+JC5nz4n34MKfH1IN92nksG3Q7R8VzgCbZgpNgz+jMl1s9dXS5msC7yKkG1
 kQAHnYG+anXCfBlRvx9cp/LlVcedqKrVlr7dOA+teDpP5N8cZTaswESKmnsSjLmg47oc
 dg4w==
X-Gm-Message-State: AOJu0YxSXXWpp6+/9ZsI0XkIE/NyUoRzUGjzwpO+XbI81CyVHWCzWnaq
 qFcU4/JodDFGEmG3uovodqeO5oWnPv5VCBQyp9cUtV0W05hONnx0ezcErsXj+RVxzbV5CQ7gL+M
 wISf4iZlsW1lpn9kASNV88g4Uuz/CzLY+s1SyKqP0gdDMcBS0/yRwdPXrde8crdY2IECCYbkDrQ
 XvreYndsL3TDy0Yn0re5OiVr7rkSsVqtYPcyKH
X-Gm-Gg: ASbGnctSEMU7MBKfEgNei5BO2RV6285Un9B3bWbDOubQSXib5GYzk183FjSazsd6iDt
 Kff7j8nCxqAtgQLFBWTAi3G7oiZwqFjPkZoraaTMwz5BuESCAibVRDZyxdK2tdvUzdM2bUJgf35
 g7ldJdsumWVE5pC0gM5j/EsYB0qSdrYya/r//wZD9VaFiB/S2HIx2i4TTJPeXA0PnhXT5sxZLxk
 Ux1oDK6SY9t2F2g5O7jhUNJun/0IF99YCMsMLsC2k2hInjSNybMwDR5TpBqHcWWPgSTx5bqQK/j
 GqPBkXpZlGpOXJQ=
X-Received: by 2002:a05:600c:8714:b0:43d:8ea:8d7a with SMTP id
 5b1f17b1804b1-442d034f74amr19052555e9.28.1746698077786; 
 Thu, 08 May 2025 02:54:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWFw0EYXejcsu+Rukw39+u6L0yaRTwH/bZ0DQFVtRnqFFbBjYZ+Ps6pO66eEAHLf1fPcWbJw==
X-Received: by 2002:a05:600c:8714:b0:43d:8ea:8d7a with SMTP id
 5b1f17b1804b1-442d034f74amr19052355e9.28.1746698077397; 
 Thu, 08 May 2025 02:54:37 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeb6esm31581075e9.25.2025.05.08.02.54.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 02:54:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: ignore misplaced REX prefixes
Date: Thu,  8 May 2025 11:54:36 +0200
Message-ID: <20250508095436.471819-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 36 ++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index cda32ee6784..55216e0d249 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2542,7 +2542,13 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     s->has_modrm = false;
     s->prefix = 0;
 
- next_byte:
+ next_byte:;
+#ifdef TARGET_X86_64
+    /* clear any REX prefix followed by other prefixes.  */
+    int rex;
+    rex = -1;
+ next_byte_rex:
+#endif
     b = x86_ldub_code(env, s);
 
     /* Collect prefixes.  */
@@ -2585,13 +2591,12 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 #ifdef TARGET_X86_64
     case 0x40 ... 0x4f:
         if (CODE64(s)) {
-            /* REX prefix */
-            s->prefix |= PREFIX_REX;
-            s->vex_w = (b >> 3) & 1;
-            s->rex_r = (b & 0x4) << 1;
-            s->rex_x = (b & 0x2) << 2;
-            s->rex_b = (b & 0x1) << 3;
-            goto next_byte;
+            /*
+             * REX prefix; ignored unless it is the last prefix, so
+             * for now just stash it
+             */
+            rex = b;
+            goto next_byte_rex;
         }
         break;
 #endif
@@ -2618,10 +2623,13 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
             /* 4.1.1-4.1.3: No preceding lock, 66, f2, f3, or rex prefixes. */
             if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ
-                             | PREFIX_LOCK | PREFIX_DATA | PREFIX_REX)) {
+                             | PREFIX_LOCK | PREFIX_DATA)) {
                 goto illegal_op;
             }
 #ifdef TARGET_X86_64
+            if (rex != -1) {
+                goto illegal_op;
+            }
             s->rex_r = (~vex2 >> 4) & 8;
 #endif
             if (b == 0xc5) {
@@ -2661,6 +2669,16 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
     /* Post-process prefixes.  */
     if (CODE64(s)) {
+#ifdef TARGET_X86_64
+        if (rex != -1) {
+            s->prefix |= PREFIX_REX;
+            s->vex_w = (rex >> 3) & 1;
+            s->rex_r = (rex & 0x4) << 1;
+            s->rex_x = (rex & 0x2) << 2;
+            s->rex_b = (rex & 0x1) << 3;
+        }
+#endif
+
         /*
          * In 64-bit mode, the default data size is 32-bit.  Select 64-bit
          * data with rex_w, and 16-bit data with 0x66; rex_w takes precedence
-- 
2.49.0


