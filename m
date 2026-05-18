Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007C8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYx-0007rH-AY; Mon, 18 May 2026 01:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY2-0006ts-5u
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:50 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXw-0003Ur-EH
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:46 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-484cf882ce5so645327b6e.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082181; x=1779686981; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iuj4JdpZLmXTc1kgrNvcSV4XFs0TVnqAu5WOyeILiJA=;
 b=mn/pIYpIshlohPvRt1e1+T0vLmhs9S9XFQz3x1sNC4ScDToNEc0SMN/QNR5e6kYJv7
 EiLyCf4apv64t60Q8LoCIRsu1fGmluBaLlc4SwJQ8KYoGmw/VNB4sCWqcI3aB2M76UYa
 9e5MOD8zmHtVlZGRtk7NObJTufR3gcjwl1vkgWXlIzDLU0M/5JoOIrhP1ZGXa9ec7WJV
 1rBoKxGREQmFVPUCUCvDBJKhMMohARTa401dHZIfXa9d51Zek9R80MF0vhQBuzfpjyxa
 5Cr28AMzJBydrceqLAWCobeYageFrj85ejl44fDotzmn4iuYFiAjWTLFYZfK8l2ZHsJg
 gmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082181; x=1779686981;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iuj4JdpZLmXTc1kgrNvcSV4XFs0TVnqAu5WOyeILiJA=;
 b=VjZDcX0fBUw+/G2fWT9wAQ4XEOCnUktOFmC6q3YPQcUr84SYgIGbXDTEmKC3+ihWH/
 L3ABkFhcjq5wUOmHnNbGJFVcFWZddqRg/dTLw/CZ2pbxIbbK5CbGQguf9PHAZxUrCQUP
 unsVLKqzaigA7H1qo2fNpoK4AZXD0eNMUsBJDEzNmR1TJrWCOICAOth6S01Yi6ZNG99i
 HXiibQbwhSNC0zL7XBDwkNy2HpVG7K9+Hv4LDiIyP3ktOzJoU3wws/JVBwEe10d1uU6y
 hx4+xw1dc1Ua+XvuatSb0Le3UJXFtxBizRcSLgfuLNL/5jd0alb865LE2ipx25YNKfyR
 A5fw==
X-Gm-Message-State: AOJu0Yxth5hYlr9wbrg5HhJOy0zSXLheEk+mRQuJM9sMj1AIO0x7ohe1
 wP0HHu+b+jN2QPUgCO1unAGJwSVLQ23dbrnW7vIRFAWvRYTYgYC3hKh6
X-Gm-Gg: Acq92OEu8cWN9R+NqQYIX2jV4IG0Oc03XncIr80pcOC5P8Y6QsVx2gnfnCbgTNBT78w
 +L45wQYJNxvhpa+cksnw2D2uhzOY7XX83VYRGV/e0N9VxDClP/5+Yd6mrey7nKzjzwTef0d8MB9
 GFp1q/Tqb0nhrJv0xReXBKHM5OxgwijbqNsa2wOqMzDU8IX+R03wfgZ3OZ0ioC1vIiImmFSWTXu
 2KzLf1ZUgnX1rUmXTn1ixW3mILVrHsFZG5JFzJynXiwYu6kAO8P7IACDGZMfQSCVgnzds1xAj/6
 8lrzde3AKwojfVTXjj7OKLTVp4QswVzt4MFG4CMV3buHWQ2zQjjCMm4RCcse7nWCdXT0mw3asgw
 0LL6GJhzx3/zXfII7IU1+ZirHGeHmNS08CgXRmDudtYEpMJ8P+wH5Sbe7L70g1buuZarf9StEUl
 iMqb6hFDEHKM6aKJYJhVUylIKnS0reyfdlxQPpKkh+wpPlQsrCF7pVBDz7CWEuyz0f2MtQRIAwh
 1io7Pq+A9AdEaRmeaixCNSxTOWTTnRld76Y+8ximdshW53QSN6RS6fgT0VzcpgfkyR/v6c=
X-Received: by 2002:a05:6808:4fc8:b0:479:477f:559c with SMTP id
 5614622812f47-482e56067bamr8331106b6e.14.1779082181275; 
 Sun, 17 May 2026 22:29:41 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:15 -0600
Subject: [PATCH v8 18/35] target/mips: add Octeon VMULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-18-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22e.google.com
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

VMULU multiplies the active Octeon multiplier state by rs, adds rt and
queued partial products, returns the low result, and advances P[0]/P[1]
with carry limbs.

Expand the two-limb accumulator operation inline with TCG so the result
and partial-product state stay visible to the optimizer.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v2 -> v3:
  - Split VMULU out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v5 -> v6:
  - Rename the translator helper callback typedef for clarity.

Changes v7 -> v8:
  - Use Richard Henderson's v7.5 inline TCG translator with
    tcg_gen_addN_i64.
---
 target/mips/tcg/octeon.decode      |  2 ++
 target/mips/tcg/octeon_translate.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index bb0a9f1d99..36ced0bb33 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -55,6 +55,8 @@ MTP0         011100 ..... ..... 00000 00000 001001 @r2
 MTP1         011100 ..... ..... 00000 00000 001010 @r2
 MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
+VMULU        011100 ..... ..... ..... 00000 001111 @r3
+
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 472b81dd70..20ceab68f8 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -265,3 +265,38 @@ static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
+
+static bool trans_VMULU(DisasContext *ctx, arg_VMULU *a)
+{
+    TCGv_i64 x[3], y[3], z[3];
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    z[0] = y[0] = tcg_temp_new_i64();
+    z[1] = y[1] = tcg_temp_new_i64();
+    z[2] = y[2] = tcg_temp_new_i64();
+    x[0] = tcg_temp_new_i64();
+    x[1] = tcg_temp_new_i64();
+    x[2] = zero;
+
+    /* Z = rs * (mpl1 : mpl0) + rt */
+    gen_load_gpr(tmp, a->rs);
+    gen_load_gpr(y[0], a->rt);
+    tcg_gen_mulu2_i64(x[0], x[1], tmp, oct_mpl[0]);
+    tcg_gen_mulu2_i64(y[1], y[2], tmp, oct_mpl[1]);
+    tcg_gen_addN_i64(3, z, y, x);
+
+    /* X == (0 : p1 : p0) */
+    x[0] = oct_p[0];
+    x[1] = oct_p[1];
+
+    /* Y == (p1 : p0 : tmp) */
+    y[0] = tmp;
+    y[1] = oct_p[0];
+    y[2] = oct_p[1];
+
+    /* (p1 : p0 : rd) = Z + (0 : p1 : p0) */
+    tcg_gen_addN_i64(3, y, z, x);
+    gen_store_gpr(tmp, a->rd);
+    return true;
+}

-- 
2.54.0


