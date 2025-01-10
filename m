Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817F8E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK32-0001PN-5A; Fri, 10 Jan 2025 13:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2K-0000H6-BE
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2E-000196-VP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYLEPuXNZY1l/qQd9EilKn0wQkuhUcyTj4C8X86e2cE=;
 b=HAqVZyGH47CVIwfZDf2EgAe0wxmw54k6rVGXdlBVkj81bfTqCkb2jH7fs/FjAL2M9YQCBv
 AZU1prPkwXv85uJfv873MTSXc7wHLrOc4iYPUAPmF7bNmU8Uy+rC032qlQF0FQxR4bwcrm
 Fz6ARKrz6ccSzBCDAXzA7c2FrZoQ0c4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-meoc3DHmM5Kic8U8sQB2-Q-1; Fri, 10 Jan 2025 13:47:04 -0500
X-MC-Unique: meoc3DHmM5Kic8U8sQB2-Q-1
X-Mimecast-MFC-AGG-ID: meoc3DHmM5Kic8U8sQB2-Q
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d3f3d6a999so2400783a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534823; x=1737139623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYLEPuXNZY1l/qQd9EilKn0wQkuhUcyTj4C8X86e2cE=;
 b=h7xJg922dGuT6GWCAmyM4e1MGQJZjeGxAx5vLTjN/Q+brvYjspfA+HFwcJKnxcrqEC
 85zl7aNryxnKHkvm+XmEnv/BghE/WVetmFiCpcbpXSUNevAkWJQLcGbbsQOqlSJC1uGa
 NuFkkmCkJ2Skdm7YJ9M8pkzTinbTI9zfEDmYdSI2srq7Hyjje/Z228XZ7PoRQmi0U6BR
 Ss9o9UoldGxaD9pjEWvL2fSTQImykSkjSWWhCI6Pk2sqtv8DiCP2D5uHw5onK5mh1Tc2
 pJKKn0Vgsu3xhaSHYwvfvisfu56gzOrrJzC+S/qfWcSFJURjTK/eZWiURlBouZHhNgim
 d+hg==
X-Gm-Message-State: AOJu0YyugtawXOGV6dBAJ3/8JfMctyq8lLkrzlvV/pXrmIjdZxSchw5n
 yH+yOmBZA9qfpzMJOlqhyBXj7gPPNRsrzvyzLByjYCM5eCSXrg+7SIxD0o0Yfjmm+QoMayvdLKH
 SDhaGWpVK2oxfQ7olhiP0CVIBrXQtJO13GyVPkdt30nSux4nIF7aa4XyLwcLodJ/mZp2b78thIc
 WeV7HvYebyhMm9DxT1yOrIagXrb2Al34OGlvOVsEA=
X-Gm-Gg: ASbGncvj225eZmFqos3W5BFraHvDF7nDub4vSAGBLna1/+Gelm6msOUtl3PTIgZO0+7
 hGjdKM4nWToXyCsuOrzNL3YUGej4W4MReTPqQ7zejSqtZwpJ9g0ns/4c7JzJFeY/x2kYmR4Es/X
 nUZ84TTgFmuj7RbJzweh1rGvroKqAD3hp4UgZPYiKNFX90HGAMliGZOVLEq0GmgHOsBATW9992e
 H8sFWgU0OkuSBjbdvGn2k0Ej7qFkO9x7N+R1IDj5GkjzOBKnvmna+cighk=
X-Received: by 2002:a50:c88a:0:b0:5d9:856c:9a08 with SMTP id
 4fb4d7f45d1cf-5d9856c9cf3mr6506074a12.18.1736534823174; 
 Fri, 10 Jan 2025 10:47:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOsqO8JlZaq2DPQWxNrok5ro3KK/a+wrybrkqbAUV+iWCUJOuxOCPgd/bbuqjLNW+r2fLmrw==
X-Received: by 2002:a50:c88a:0:b0:5d9:856c:9a08 with SMTP id
 4fb4d7f45d1cf-5d9856c9cf3mr6506058a12.18.1736534822753; 
 Fri, 10 Jan 2025 10:47:02 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9903c32absm1971106a12.41.2025.01.10.10.47.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/38] target/i386: use shr to load high-byte registers into
 T0/T1
Date: Fri, 10 Jan 2025 19:45:59 +0100
Message-ID: <20250110184620.408302-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Using a sextract or extract operation is only necessary if a
sign or zero extended value is needed.  If not, a shift is
enough.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c |  2 +-
 target/i386/tcg/emit.c.inc  | 23 ++++++++++++-----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 834aea1e594..dbc9d637c4b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -486,7 +486,7 @@ static inline
 void gen_op_mov_v_reg(DisasContext *s, MemOp ot, TCGv t0, int reg)
 {
     if (ot == MO_8 && byte_reg_is_xH(s, reg)) {
-        tcg_gen_extract_tl(t0, cpu_regs[reg - 4], 8, 8);
+        tcg_gen_shri_tl(t0, cpu_regs[reg - 4], 8);
     } else {
         tcg_gen_mov_tl(t0, cpu_regs[reg]);
     }
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 5c115429350..c4cc5f48d83 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -286,24 +286,25 @@ static void gen_load(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv v)
                 gen_op_ld_v(s, op->ot, v, s->A0);
             }
 
-        } else if (op->ot == MO_8 && byte_reg_is_xH(s, op->n)) {
-            if (v == s->T0 && decode->e.special == X86_SPECIAL_SExtT0) {
-                tcg_gen_sextract_tl(v, cpu_regs[op->n - 4], 8, 8);
-            } else {
-                tcg_gen_extract_tl(v, cpu_regs[op->n - 4], 8, 8);
-            }
-
         } else if (op->ot < MO_TL && v == s->T0 &&
                    (decode->e.special == X86_SPECIAL_SExtT0 ||
                     decode->e.special == X86_SPECIAL_ZExtT0)) {
-            if (decode->e.special == X86_SPECIAL_SExtT0) {
-                tcg_gen_ext_tl(v, cpu_regs[op->n], op->ot | MO_SIGN);
+            if (op->ot == MO_8 && byte_reg_is_xH(s, op->n)) {
+                if (decode->e.special == X86_SPECIAL_SExtT0) {
+                    tcg_gen_sextract_tl(v, cpu_regs[op->n - 4], 8, 8);
+                } else {
+                    tcg_gen_extract_tl(v, cpu_regs[op->n - 4], 8, 8);
+                }
             } else {
-                tcg_gen_ext_tl(v, cpu_regs[op->n], op->ot);
+                if (decode->e.special == X86_SPECIAL_SExtT0) {
+                    tcg_gen_ext_tl(v, cpu_regs[op->n], op->ot | MO_SIGN);
+                } else {
+                    tcg_gen_ext_tl(v, cpu_regs[op->n], op->ot);
+                }
             }
 
         } else {
-            tcg_gen_mov_tl(v, cpu_regs[op->n]);
+            gen_op_mov_v_reg(s, op->ot, v, op->n);
         }
         break;
     case X86_OP_IMM:
-- 
2.47.1


