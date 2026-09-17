Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865A2C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jo7-000364-PB; Thu, 17 Sep 2026 17:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jo3-0002lS-3t
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:11 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jo1-0007mc-HL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:10 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2cso5261a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681088; x=1790285888; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RRfikRhWXH6MGbqtQCCkb6hs2QWMGrTi9iztStOarmw=;
 b=F2i2EfCV7P7Aa5uzxrKz+iMRcnJnVjrHjuNvJPGYIpn4WxmqtF0JV0etQEPuSXuCvf
 4icwyYfRKwnzvchIzxcMyGw018DldS83wzUbHWRNkPdkc+LFkTPBV+SA9F8dT+KISfVx
 /58tV+3Y3zuXxIXRoVxl3gonOJ6S+Y/xQn91RA3PnUUeGKCXIjELgdcOIzzvrBwkdycv
 PXc0xf94rIp6Kpv6So610pYAd80lOakxc2SG8Qd285QWSdL3dgnJV6LP4gVpxgI4YK9l
 jbByFLDcnR6deQqMESBbti1/S27dbaF4a8cUB+V+4GhF3FgScq//DGFjvDOjpw+LAYfb
 wm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681088; x=1790285888;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RRfikRhWXH6MGbqtQCCkb6hs2QWMGrTi9iztStOarmw=;
 b=pgjj+EWm99cgS1vsRHZnZqdf40foKLuWOIm6o4wA6XZzHqOr7m1KOirz3id9JL4vJs
 GOTAqodb6CIZUtgklTyePdQ6pCdC8uk4Gy7Ondjp5OZwZoPa7olTquxerTklNmi1TCr/
 3Dff5djpD7wuxWqUnkJ3AQbkklsmHe5m4T6jBpYO5OUo3fer/42V4fcvMhi+BnqvlTi8
 Jp1+ONn9khpiuGeLzQgLg6hrGhL00fzXH5mpLJf6AuUKI9nilpOpA+YpQRbPZcXoSJ54
 sb0h6nJ7p8KHhjcKq1LinVxqcVH3XzONoSP8XUBZBDGlhq394NSO4irsPG0RbcOpbQSS
 5Dmg==
X-Gm-Message-State: AFuF++mi8TT8RyWRya/Y4L7Y/rdasii8PfL7eebaqJWmFsdZfqH41wKI
 lS/4mLa3cpADkcI7SXZlfDjwJNeWCIfr2Q2xIl/piA08lcUo2NtV8LxbtECM/GZovBy6TobAlM6
 +g2FQumw=
X-Gm-Gg: AYBFou2sjqGhesMOCmVLA6R4r9AW6+jaFbM8nMkrnmnbYXiDgV3nL6k3ESIoE369K0Z
 6NFjECIr04TISdnbEjjNhPf4ac+/d50PjshBgOcTX+o+QaVQMe5fvW6F+pJUpGD1L+R2j4SFpv5
 ikDr0/cUM0P9r34kosLs2lxu9wXIY7Rm0ENEt0BWgHMiQbspfgY0j15qT8TWrKXXPWBA3Yhz1Q5
 ZufhOUtjhcE/Ub+cuhrJxoSDXc8tBWHB1vO47AYMywNhx/iMgxcCh7VQLjCytU//vgMYBeBy/vW
 g5+j2dSTO1CCpHRr79l+oeyn1pHnkR4eDRi4M4Uin1+6lPmQXTZeE2+COLD/luBskcCIWqzf1sh
 aRoN1zfdv3VjMt+VHUpCIAWlztZKj8Pr/Fh+rAwD9buSOEnCBLhIiEVQKUkC90qEEq1AusYiGQm
 Tv6JIyv0jhHGU6icw/1+sFBVn87/v0vwKFKyyolFablfhGPzgyQ0MViYk/4PsigSz74X5LkwC1K
 aqeGCW/Gta4dYgp2w==
X-Received: by 2002:a05:6300:4049:b0:3da:c10c:6aa6 with SMTP id
 adf61e73a8af0-3dd8c2dc837mr616209637.1.1789681087874; 
 Thu, 17 Sep 2026 14:38:07 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:38:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 13/15] target/s390x/tcg: Use op_st for STORE REVERSED
Date: Thu, 17 Sep 2026 11:37:47 -1000
Message-ID: <20260917213749.36756-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Use the MemOp parameter to op_st to directly perform a
little-endian store, rather than a separate byte reverse
before the store.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-14-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc |  6 +++---
 target/s390x/tcg/translate.c     | 13 -------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 64711855f3d..854ec37d306 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -882,9 +882,9 @@
 /* STORE HIGH ON CONDITION */
     D(0xebe1, STOCFH,  RSY_b, LOC2, 0, 0, 0, 0, soc, 0, 2)
 /* STORE REVERSED */
-    C(0xe33f, STRVH,   RXY_a, Z,   la2, r1_16u, new, m1_16, rev16, 0)
-    C(0xe33e, STRV,    RXY_a, Z,   la2, r1_32u, new, m1_32, rev32, 0)
-    C(0xe32f, STRVG,   RXY_a, Z,   la2, r1_o, new, m1_64, rev64, 0)
+    D(0xe33f, STRVH,   RXY_a, Z,   r1_o, a2, 0, 0, st, 0, MO_LEUW)
+    D(0xe33e, STRV,    RXY_a, Z,   r1_o, a2, 0, 0, st, 0, MO_LEUL)
+    D(0xe32f, STRVG,   RXY_a, Z,   r1_o, a2, 0, 0, st, 0, MO_LEUQ)
 
 /* STORE CLOCK */
     F(0xb205, STCK,    S,     Z,   la2, 0, new, 0, stck, 0, IF_IO)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 1250b2dd7f4..0449fc2cee2 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3713,12 +3713,6 @@ static DisasJumpType op_rosbg(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_rev16(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_bswap16_i64(o->out, o->in2, TCG_BSWAP_IZ | TCG_BSWAP_OZ);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_rev32(DisasContext *s, DisasOps *o)
 {
     tcg_gen_bswap32_i64(o->out, o->in2, TCG_BSWAP_IZ | TCG_BSWAP_OZ);
@@ -5545,13 +5539,6 @@ static void in2_r1_o(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_r1_o 0
 
-static void in2_r1_16u(DisasContext *s, DisasOps *o)
-{
-    o->in2 = tcg_temp_new_i64();
-    tcg_gen_ext16u_i64(o->in2, regs[get_field(s, r1)]);
-}
-#define SPEC_in2_r1_16u 0
-
 static void in2_r1_32u(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-- 
2.53.0


