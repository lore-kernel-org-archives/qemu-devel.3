Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6110DCD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRXDZ-00079z-ST; Mon, 25 May 2026 11:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRXDZ-000770-0G
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:27:49 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRXDX-0007MK-GO
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:27:48 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7c307937816so85529977b3.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779722866; x=1780327666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uv/TiZUvtyttpHRh/qTef49+TQHy7ozcPAECKYs4dNI=;
 b=YvYDdRwITYJWJUtUxhRHWfdM0f9sycIRJiDoY5+fb/aOxdy3PqJvKYrRxA+b2/wfz2
 wUGeU6EO4FW7nFH+7Wdj8GchyDeBT3oitJeQowc1lKeSDEWDBtjLvTLdwttdPTiQE2r1
 aviyDEhX/imXmFAGQqQJow7Lo+WxyvWiam4Vx1ORxWcOQKhAQinoA4PUqM9xgjmcIhvW
 hvtVe9KhPNW8e80qgaO6MI5n12sLWVxWk8aey+EJv9DGcwoxFxDPHOL3Z+baBDMT7PCo
 TthCze0bP7zZN/0zN/qHMTM/jh8c5EBB5WsUZxNwy7phynMfhugpvx167zLekXmxd236
 zHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722866; x=1780327666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uv/TiZUvtyttpHRh/qTef49+TQHy7ozcPAECKYs4dNI=;
 b=HWEvCaf9F/n+eDd0QqCJBRdm9VgEwScZirC2lNpt03ZKIndDHEx08+lMA0hMWpWvGO
 v+oku/5DmR93NMBnf+e9grtH+QrjvMC8Y8qCgw/CifRdyi837RDnzKMkIG8HDZuAWeJB
 ZxMq3QsspWf4t4WKIvWwuqBLZ101S4T/BfzWawJG3bna2tx9C2FBWCH8yWwgDmDgnwtl
 u5cdU51VJb8lE41IpbbChuQPQ9LyequvJB3vgY6HAzYVob+XrFyJ7iTC6PgLWyYJtUDo
 dgqZS8p8iCkogKLYPBDYLdGP2EtWxcVCmn9fcvbHr6zygGMaWPgt/zJrevmg2LqEgEPc
 0YLw==
X-Gm-Message-State: AOJu0Yw1+DRubAqCTHBAuk0E/o+h+wuRRy986cHvXjxDBCjeTU4Akeyf
 w2a+jymeTcZ9i5EwR6YO8SC+cnubYB+0o28RXiwCphaArsuqCm64s5E/JPsqSoGH
X-Gm-Gg: Acq92OGlM9qiFiZHAaLyn3fqcHmdGtXGGQ+oBh6dkYZ+QE7Mm3vn9DUFYRqbs3hSlq2
 nkZ8xRC1Pv+m4hbKfEIQTXXBdFoKYPkdEzb+mejx58QapsbSBMiOH/nEN+ryryAn+HPc+fb4eKm
 ToJ/VPJF+VJO7O36lofIBbxu2IZxtt8Po7+ORu8f9OqzbRyM4jHXhYIeWHmRsCZBp47Lw5jYoSj
 hjap0s6fL3hNRaANRuzV4AZf1k5PldvVE7j4krXl7sMTp9Hz74a/AzK95aseIs2kOcpMTYgNVX+
 UGQ8hvw4ofIOaj+6Eghxve/IcHC2DlBLNKWj1l6YU2HUD2lrB2+D10ZyzGMyCjXCPmZpy1VkcF6
 stzrIjjypM3hb6Poay0aQ7LEYoNfU2ETFg9cYvGLhhhu6BUDXiIc1xrMlfsHkvYgVxCVFRUoO6x
 rkhHosKnTlCkTGxsA2B40lGZvG0KeVJkiDjD95J81PFhvB3JCMAYK0oJkFyG1BMIcUdbWdbaRPm
 FQ=
X-Received: by 2002:a05:690c:c52d:b0:7d1:d41a:5722 with SMTP id
 00721157ae682-7d3357d5b45mr154551597b3.24.1779722866149; 
 Mon, 25 May 2026 08:27:46 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d389d173eesm47624787b3.15.2026.05.25.08.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:27:45 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH] target/sh4: decode_gusa: recognize add#imm with prior mov Rm,
 Rn
Date: Mon, 25 May 2026 11:27:39 -0400
Message-ID: <20260525152739.4122267-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1132.google.com
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

The gUSA pattern matcher rejected `add #imm, Rn` whenever any prior
`mov Rm, Rn` appeared (mv_src >= 0), forcing a fallback to
cpu_exec_step_atomic for sequences like:

  mov.l  @r2, r3      ; load
  mov    r3, r7       ; save old value (mv_src == ld_dst)
  add    #1, r7       ; increment copy
  mov.l  r7, @r2      ; store

When mv_src == ld_dst the move merely copies the loaded value to
preserve it -- exactly the situation already accepted for the
`add Rm, Rn` form. The immediate form can be handled identically with
tcg_gen_atomic_fetch_add_i32 + tcg_gen_add_i32, so translate it inline
instead of taking the slower single-step atomic fallback.
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git ./target/sh4/translate.c ./target/sh4/translate.c
index 5adf650744..d38a6bd352 100644
--- ./target/sh4/translate.c
+++ ./target/sh4/translate.c
@@ -1974,7 +1974,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         break;
 
     case 0x7000 ... 0x700f: /* add #imm,Rn */
-        if (op_dst != B11_8 || mv_src >= 0) {
+        if (op_dst != B11_8 || (mv_src >= 0 && mv_src != ld_dst)) {
             goto fail;
         }
         op_opc = INDEX_op_add;
-- 
2.53.0


