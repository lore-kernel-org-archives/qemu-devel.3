Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DF1C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGG0-0007C2-FF; Fri, 24 Jan 2025 04:45:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFd-0006oI-DP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFb-0003sb-Kb
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQbZtmBk+g/IDUiWwXjwX0V2l1jb0mb1+mhwT99ZFxk=;
 b=U6N1v+Mva24wDgt5n7pJPN3m2gKNO7PWyN1AN+3oAFxoICJ2KzoTIMFidenkZsCGDMVNKI
 SnESFxLIRjceGzoYxDLcRD5An4gonD6+6gG9Nv5EyWQtdI/tWESII56p2ZD9eQ0m1HEQdA
 Ax3yb8YUHAi29FzZpLwo0V4DVdemaJc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-XmCPt4zCNN-UwiXuP5b6ZQ-1; Fri, 24 Jan 2025 04:45:14 -0500
X-MC-Unique: XmCPt4zCNN-UwiXuP5b6ZQ-1
X-Mimecast-MFC-AGG-ID: XmCPt4zCNN-UwiXuP5b6ZQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38629a685fdso688610f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711913; x=1738316713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQbZtmBk+g/IDUiWwXjwX0V2l1jb0mb1+mhwT99ZFxk=;
 b=e+3lP+uptpnxn3c58c4A+xstm0477paxxUCzOi+RRNdsSdWgEUq6X907SUUDNOWDUU
 O9O/d8RtwvlgnSllAJ1baB9euzVSZhIArSKDBT3T7J85earrRVUMzzFU7nycQ1/c7KND
 KbIhkboksRmI0wZBoikZB4QYZ5xAWe+j8BclsWQvndQg4V52wW53GFhUnZSTknrVtxr7
 IUC7o3afLXaEgn1JFKR5JR28O2l6DqqnfmrYQtp08lM6jjbiFO4Dnf47eEfFkiV+XxFL
 Qj72QCWZaaMo/lKvVXgrtTY1mxawD8LVU2r+Yw6wUoaFmPI0at1l4kBOs9aivhtn2gTN
 BoxA==
X-Gm-Message-State: AOJu0YwRQiIX5m3kq+/hDjf8nuAh+ea9rjWzSPhOLmfmwdTBTKD4lFOD
 0FtaYykS4JqeTrUnG4Zr8XlPNk+2Y1JIqM0sD+gb5ZN6NYdk4VGoPjZJYoiZHkgse+rdQle2M/N
 0MCBaqpSvTlL0kguCrvQ/T/uY1ushB9CaxT+HgQBvJnJfKox++nLuKcBkPffFYXQDCryRxqbpxS
 Eg8CblgsspH5+M8cirqktNMGQHJTLW9AQaX6jEpRo=
X-Gm-Gg: ASbGncuWSjvpVNJe9qY+RbYPFBsF+OKSHB8W24JKwowpPrGg9km0R3CSdUksN+Cd1qp
 w+RHQkzGvdDxHuokalWHAtkHpKfYS67XsA+R/axk+mX1hGo8/XlHdNpMpogmq95Q/Geq1qS2vEk
 R/dTYKU2i5Cx9PbiUDmttmpaQn9/yq5Zu6Oss6lGVoO0aR1tIXY0NAwo2KfT1AUvUlBc5Ld0Z4Z
 qTgjqNd6lrZ5s13t751UaCwEveQltv01YcwiFeAhRVoWg5oZiLF6Uenwzq44XczSBHcyosqcw==
X-Received: by 2002:a05:6000:4026:b0:385:e8b0:df13 with SMTP id
 ffacd0b85a97d-38bf57a9569mr31670661f8f.40.1737711913175; 
 Fri, 24 Jan 2025 01:45:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMzipNrHGdnQIs+B16qWtOmja0hWoou5S5KefICZC9WqQktUsHoPPNuNt7OLhGt4/YC43TOA==
X-Received: by 2002:a05:6000:4026:b0:385:e8b0:df13 with SMTP id
 ffacd0b85a97d-38bf57a9569mr31670624f8f.40.1737711912754; 
 Fri, 24 Jan 2025 01:45:12 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa599sm20988735e9.7.2025.01.24.01.45.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/48] target/i386: avoid using s->tmp0 for add to implicit
 registers
Date: Fri, 24 Jan 2025 10:44:09 +0100
Message-ID: <20250124094442.13207-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

For updates to implicit registers (RCX in LOOP instructions, RSI or RDI
in string instructions, or the stack pointer) do the add directly using
the registers (with no temporary) if 32-bit or 64-bit, or use a temporary
created for the occasion if 16-bit.  This is more efficient and removes
move instructions for the MO_TL case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241215090613.89588-14-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 9b2fde5eb28..a8935f487aa 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -505,17 +505,24 @@ static inline void gen_op_jmp_v(DisasContext *s, TCGv dest)
     s->pc_save = -1;
 }
 
+static inline void gen_op_add_reg(DisasContext *s, MemOp size, int reg, TCGv val)
+{
+    /* Using cpu_regs[reg] does not work for xH registers.  */
+    assert(size >= MO_16);
+    if (size == MO_16) {
+        TCGv temp = tcg_temp_new();
+        tcg_gen_add_tl(temp, cpu_regs[reg], val);
+        gen_op_mov_reg_v(s, size, reg, temp);
+    } else {
+        tcg_gen_add_tl(cpu_regs[reg], cpu_regs[reg], val);
+        tcg_gen_ext_tl(cpu_regs[reg], cpu_regs[reg], size);
+    }
+}
+
 static inline
 void gen_op_add_reg_im(DisasContext *s, MemOp size, int reg, int32_t val)
 {
-    tcg_gen_addi_tl(s->tmp0, cpu_regs[reg], val);
-    gen_op_mov_reg_v(s, size, reg, s->tmp0);
-}
-
-static inline void gen_op_add_reg(DisasContext *s, MemOp size, int reg, TCGv val)
-{
-    tcg_gen_add_tl(s->tmp0, cpu_regs[reg], val);
-    gen_op_mov_reg_v(s, size, reg, s->tmp0);
+    gen_op_add_reg(s, size, reg, tcg_constant_tl(val));
 }
 
 static inline void gen_op_ld_v(DisasContext *s, int idx, TCGv t0, TCGv a0)
-- 
2.48.1


