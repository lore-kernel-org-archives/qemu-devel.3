Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24C7E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkad-0004gR-PM; Sun, 15 Dec 2024 04:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkac-0004gA-3A
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:07:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaa-00070L-PX
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+7Q/7tH4enxnwW3OhOEz+YJTZLRmROVofkNsXBKXZhI=;
 b=L+/Ue0PXpGuNgljytng42cNOTd6hMga0/4IjsyBu4/fg1WMAOYspgUlK417ZTDK6xBUshe
 GgqxL2iEoNrR7MJgBC9VQQXcCuLLwy+S6k5sYLBQwVbl6qwDdiRaZpekF+EZW23no/rHeq
 8TQMO31DMmK5WEGaozEuBX5uQS7Dj2I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-26Vaq9NLNMCU3kJH_D8Ifw-1; Sun, 15 Dec 2024 04:06:55 -0500
X-MC-Unique: 26Vaq9NLNMCU3kJH_D8Ifw-1
X-Mimecast-MFC-AGG-ID: 26Vaq9NLNMCU3kJH_D8Ifw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso345635e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253613; x=1734858413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+7Q/7tH4enxnwW3OhOEz+YJTZLRmROVofkNsXBKXZhI=;
 b=GwLlw+skLZyHO8onAN5SM2nNl5HIDtwhldLnUsQtRGN/RDi9E9JSSrDBIaoOXK6s8J
 +2xeLFYPEe7Z1xY7qrcRDSXwUf2Ao+4lq7oxWNBC4mv4NNRyA314mmCAvooa1Q84o/De
 kUUUuQFCat/yMBuQxTm1ohoqJx/mGcC2y3GCdJteA/75URj5EyqJL27bLbpgYR31SG4/
 KfmbySPeyM1xDoiMGmMnTaPYX1WcOw4sOPpjzLcdKGgA11lLkiVKr2D9ALFt52rUUg2I
 9JiwjyBiiZnyXtDtYXVfQjIEVD6NFyXoF6T2r3aKp2BbHfj3ved0PeUf7t6bsa6cw5mG
 VPWA==
X-Gm-Message-State: AOJu0Yx4tQwe+SlNLKxWOZc+G6FDd5USgvLHT4sa4m1NBqdGuJ7EJU3P
 LkAw1avYhVJfWs6MTbPmIvg5dvRFVREJ41xQutRoKSIh97NV7ubUKov6z8zgNP37JiL8Dftiq5M
 iU6eyIAt1zUc6w4rC3DrVhwnvtccILbVtVXtRinMnhL20rOJNB8oqzity/jLQsGWMYzzezfCQ6r
 //ShkYTG2DpdsxjX7thzw+wVhuDTjJuS2kHGPX
X-Gm-Gg: ASbGncvKekOkogxaKIe+TBClxXA0+TYw6AiV1iowmcS7A+4J9S1blegYS4wnUFlbb/w
 DpjA9oyDbErGtDIPxPQ/PVn05OEeDzEezeNEze5Tt+0fkPOBjZDzkwVVduBRZjcxVnypBOh61qj
 wpaC1bRXjc03o7gpb4IOIHp4ROPuadrleKrFUM1SYW03Gi+Dtd8REuY/7aDVj/XQj1cxkBPNpMo
 kl02vV37Z0T47GYdpUyeHo2Ug1UHrL+6dus62VakGnk+rXN4cGy0M7jksM=
X-Received: by 2002:a05:600c:1e0b:b0:434:feb1:adcf with SMTP id
 5b1f17b1804b1-4362aa9d2afmr66978665e9.25.1734253613026; 
 Sun, 15 Dec 2024 01:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKptYqJeAQcw0foSrC6OnVaqP26dUMYCfohyYkKVH+u0m3f7ySM+QiB6JZPiv6s6jwCia/Ww==
X-Received: by 2002:a05:600c:1e0b:b0:434:feb1:adcf with SMTP id
 5b1f17b1804b1-4362aa9d2afmr66978315e9.25.1734253612585; 
 Sun, 15 Dec 2024 01:06:52 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625553234sm105815575e9.3.2024.12.15.01.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 13/13] target/i386: avoid using s->tmp0 for add to implicit
 registers
Date: Sun, 15 Dec 2024 10:06:12 +0100
Message-ID: <20241215090613.89588-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215090613.89588-1-pbonzini@redhat.com>
References: <20241215090613.89588-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.292,
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

For updates to implicit registers (RCX in LOOP instructions, RSI or RDI
in string instructions, or the stack pointer) do the add directly using
the registers (with no temporary) if 32-bit or 64-bit, or use a temporary
created for the occasion if 16-bit.  This is more efficient and removes
move instructions for the MO_TL case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4b652cc23e1..8de506927b0 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -504,17 +504,24 @@ static inline void gen_op_jmp_v(DisasContext *s, TCGv dest)
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
2.47.1


