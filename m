Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A301C61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1I1x-0007mT-Iw; Tue, 01 Sep 2026 02:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1I1w-0007mL-7l
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:31:36 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1I1u-0007Da-Gd
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:31:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48442ea8f59so253403f8f.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 23:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788244292; x=1788849092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jMrLylJNFrZqaFlEHGQ8xlsSHei5L2/Yx8Phu3TbySY=;
 b=p/wRbf3CNxhr97PU4BRCF8jyExn2EuNIXrgqe2DHkv6WX7sfmjbWQoGpzuoC/X7aB/
 V9D8s0ndIwDaP5b4fq9sP0YZHd88BbjeT2V1fS/y7mvulslaK3B4nrVpkz3QkJomhvq+
 Lms4apIuRgRmKGkdBMaD0QYiidFjgvIqN548J4D4/14gJsO7dNzdas6vpCBhCDj4M72d
 FXDd9oIleO95Mg2xjHxWSqwvKiwg7wwxO8SYZYT1FWiNv5P1XwuJS78+sXJ1vZJOKu1s
 kk4hDounrBwv/d2z0HVYeSUL7ivD6u9nb1WQKx0fTqmu9I0m0Tl6EMYQCNmvGY4TxQL+
 Xz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788244292; x=1788849092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jMrLylJNFrZqaFlEHGQ8xlsSHei5L2/Yx8Phu3TbySY=;
 b=GUcfKd6IghIGVhoyOGnIBtfYoP74CdSVnP0ZM8sDubQfnDdtB0uRYaeD/jlWk2Uayd
 irEPkYvuobwv4PpcJNoLPt/ttgYWSPniD0reN8AQHVM+DtlWDIdySAv/mLMsUz8ttjN8
 k6kcR8xKDgMH5mSsVmkw4YkSOb5WMH/onnG/dH3kL8CWr4ixzDazw4J1roQos3VGR1Us
 vExy3NUxQ3+Vl7XzM8zY4bCDodNTHZ/WYg8JqAZfqgd7CMAKI1N/V2e+aYy955XhFZQb
 7Hd5+JqMiTEYDhzzNzsRHjqDhxLd86tawMoCFaI0GF72NGu5UF3jDVNcT3Ng2yeli8jb
 wr5g==
X-Gm-Message-State: AFuF++k6N3OR7FX0q1cnEgRV/LiGvzEo8mPR/j8EZGhhbwFo8gfYHM99
 opbFvjclhoclCpnjvW8yDZ9Ojy3v/lhOjyclZOzv8bOxf/AQo6KyosAZzNGnKjKOvoY=
X-Gm-Gg: AYBFou3JeU+YSPvEDiyHmEXDn/87gqbWFN5Ah8z1vgEa1s/f+3a5/9CSc1OBpPzV4le
 hxynsm2PV6MLF5do1VgfY2jUurAHd+V6jMBvxm3eui73FPnMnFg7/LCbp2cBJkN7JZ8LMP243W4
 tiSaDY++dwZrOKBSP51xFD2xMAg9/i65nzBHnDrovqBX5qbwgLW/k88uj6gu+/baR6rooi5al00
 jV5tIQtAhsdxRl98g2nx3a3sh7GeE7Mf+Hp4LRoQXFABpRv1ZxFswkcHrBlWtRZVqS0tLgQL0yV
 HrkKGk7ZyTas3w48cWEBK9nEmI0HAMR2/TIYjydVd6gbRuwCv8toJqc6sF8qbO0hW3QSMhqCBRL
 lt2OIyAJwXJ7aydHHIz+OnQGzgkAn3H+9gcI4yxE9anYRBvEJUa+HWSd9RPrJRlL+TKcrvjRWCH
 GuE+VPT0bSbTiqm5VDZMOp9yA5ls4/F/ovTYUDBhkXBvTnGSAjMQhLBeOLgmdBRLyL2ot2Xi8TY
 QoUdCimaeG9CJkytIkNbDf+rgv+TioIrDOFChDjISY84RYoToZ8704xJelKDSB9TD48ANY9cXF+
 Wy/0klZ82hgYI6xJPOq8jyUsw8Kxm5w=
X-Received: by 2002:a05:6000:4b16:b0:481:50ae:df9a with SMTP id
 ffacd0b85a97d-484421d4083mr5598482f8f.9.1788244290537; 
 Mon, 31 Aug 2026 23:31:30 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-225-161.tugraz.at.
 [129.27.225.161]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d787b8sm2809338f8f.29.2026.08.31.23.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 23:31:30 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH] target/i386: Do not switch to MMX mode for CVTPI2PS/CVTPI2PD
 with memory operand
Date: Tue,  1 Sep 2026 08:31:27 +0200
Message-ID: <20260901063127.60866-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Per the Intel SDM, the CVTPI2PS and CVTPI2PD instructions
cause a transition from x87 FPU to MMX technology operation (the x87
top-of-stack pointer is set to 0 and the tag word is set to all
valid). CVTPI2PD's own description scopes this to the "xmm, mm"
operand form only, explicitly excluding "xmm, m64". But CVTPI2PS's
description states the transition unconditionally, without the same
operand-form distinction.

Testing on real hardware shows CVTPI2PS actually behaves identically
to CVTPI2PD despite the SDM wording: neither instruction performs the
state transition when the source is a memory operand, only when it is
an actual MMX register. This matches a similar Valgrind bug report
and fix, see https://bugs.kde.org/show_bug.cgi?id=357059.

gen_CVTPI2Px() currently calls gen_helper_enter_mmx() unconditionally,
regardless of the source operand's form. Only call it when the source
operand does not have an effective address, i.e. is a real MMX
register.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4394
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
 target/i386/tcg/emit.c.inc | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index c83ab80940..72c08beb2a 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1919,7 +1919,15 @@ static void gen_CRC32(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_CVTPI2Px(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_helper_enter_mmx(tcg_env);
+    /*
+     * The x87->MMX transition only happens when the source is an MMX
+     * register, not for the memory-operand form. Confirmed on real
+     * hardware, contradicting the SDM's CVTPI2PS text. See
+     * https://bugs.kde.org/show_bug.cgi?id=357059.
+     */
+    if (!decode->op[2].has_ea) {
+        gen_helper_enter_mmx(tcg_env);
+    }
     if (s->prefix & PREFIX_DATA) {
         gen_helper_cvtpi2pd(tcg_env, OP_PTR0, OP_PTR2);
     } else {
-- 
2.53.0


