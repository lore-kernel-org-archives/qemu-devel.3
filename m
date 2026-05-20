Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B29CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmZR-0005ci-4u; Wed, 20 May 2026 15:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZI-0005G7-EV
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:27:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZG-0002kP-J3
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:27:00 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso36807135e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305217; x=1779910017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9zyGeupsFi5w4Kk0zhf/ZzdmhgHd6jR1EYAUkg4DGbU=;
 b=yDKu8AMhMDJjSTWfuQba4weDm7cC1tI+axwPzSpByInKnjoFGq0g3QOw5aKogdj0jS
 WR0JX0as2jZYnIx5uOzbUZsJF56XyKYKrKRtdtMOFSPIUk2FIqZ+MKqUin/75RHzS1hx
 zlQNYF0bs/pfUX7bV2l6KCHE8/WUMwQaizL7cXL88yGKZ3MB8mE8ZHS4rhmMk4+90W5s
 nsMLUBGbTxkGIVZqFTArL9+VtpSsOMah56zGaPPDfhaDES1qabWrVsmquaqCwZuPOplt
 MydwFJvOhPhq0JS/3vAkc4fPfRUfoLigM6Np4YXaRYgQIiPSULn7XDgZvNejuMqXnz6V
 0VNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305217; x=1779910017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9zyGeupsFi5w4Kk0zhf/ZzdmhgHd6jR1EYAUkg4DGbU=;
 b=RES2eGJYhXAIVGq3rxqXTdOiPqqpn7BxStObKLw+8P5VLhENJU1iWJP82yTbRCV/te
 RX/PpSBhGFKhPFy1CYoFjb0LTEC3DG6cT03ojQTt5mQpthoc56LsY59gOrqbOQUAQt2k
 xgvPwu8HPszHF7hl0/oFmzsDNM6lTnPUo1S8MKFc+MDXK49yiAdP6VHOfeuMowCyqUW8
 ouiwrW9zh4LOztXM/bXJ8mJOmQvwoTiW+GhNLUG/TBvGT4hyLu++zbW8oDfxvNhy7BY3
 E3W3gp6OJMpJ5W2cCjyFyLLRLp/baIFpfMUQU0NMckwaey0uqvwMmCnpAvl/M73RY3YU
 DTwA==
X-Gm-Message-State: AOJu0YzalIZHC3Au9E5yEtQMtkfz6gVq9bh2whisCHj2yLiPBVQDpauP
 8PwqbjHFIWzPe/IbELVbEoweiiDksCfUo68c1IALymQUHnYlXomyLdhDYl/3+ldA/mBBD2gc1PX
 1zpOwnuA=
X-Gm-Gg: Acq92OGYaG9CznRzbuHPklsHe1bLQ5pe/YRtO1tl0NtfbtRpBc0mQtNffmTUHhmxP2t
 n2DtpmP73wquu3w70w9IXwC+a1LnTVhASZWxJFlQcCt/vHFPuGgwDLiw/IDkoCWt3HSFFW8igIE
 K2u9XE7PaOF/Lg9zVfxf2/z/+tUSKkq4xvaASwcT+4ai2cz9ve4+IBX5CPzLwThhaVuSVR6ZT07
 pK4ZAUW4gz/BihWeBp865oOdnr+e6PpogZmKd7z70ItEEiqobZCigfeUtp3J6DJ7Q7v9WTphWyw
 QGOPDqSmM2fe1X+/fKPstV+HmFky/LB5Iar+UrxEgZbhTzAeenjtmfrFdc0Mwx7T06HZCbwJx9A
 NYfWIZM+9OGMTAYqchy8m2H2rZF8knV96pjQe+eKSdg1RJoB5iqx8majDGbmLRh1E3hHvCEAiJ2
 EC6NHrsk3bJ0uo9DNSywSKDBIT5f+CWKUIhMywhGYwLs64v28TSO5yWmyiBewUEMFWOVM7bi+6M
 gqnNe/pat8=
X-Received: by 2002:a05:600c:3b26:b0:490:261d:7dfe with SMTP id
 5b1f17b1804b1-490261d7e2bmr93093665e9.6.1779305217026; 
 Wed, 20 May 2026 12:26:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d8e24bsm11914915e9.10.2026.05.20.12.26.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:26:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/33] target/mips: add Octeon MTP instructions
Date: Wed, 20 May 2026 21:23:33 +0200
Message-ID: <20260520192338.40036-29-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Add the MTP0, MTP1, and MTP2 forms. MTP0 loads the low Octeon3
partial-product pair from rs/rt into P[0]/P[3], MTP1 loads the middle
pair into P[1]/P[4], and MTP2 loads the high pair into P[2]/P[5].
For MTP0, also set P[1] to zero for backward compatibility with
Octeon2 VMULU.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-20-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 5139543b153..bb0a9f1d99a 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -51,6 +51,10 @@ MTM0         011100 ..... ..... 00000 00000 001000 @r2
 MTM1         011100 ..... ..... 00000 00000 001100 @r2
 MTM2         011100 ..... ..... 00000 00000 001101 @r2
 
+MTP0         011100 ..... ..... 00000 00000 001001 @r2
+MTP1         011100 ..... ..... 00000 00000 001010 @r2
+MTP2         011100 ..... ..... 00000 00000 001011 @r2
+
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 26b918d649a..10c7d18ad4f 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -241,3 +241,26 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTM1, trans_mtm, 1);
 TRANS(MTM2, trans_mtm, 2);
+
+static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    /*
+     * Octeon3 two-source MTP forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(oct_p[index], a->rs);
+    gen_load_gpr(oct_p[index + 3], a->rt);
+
+    /*
+     * Octeon3 clears P1 with a write to P0 so that VMULU sequences remain
+     * backward compatible with Octeon2.
+     */
+    if (index == 0) {
+        tcg_gen_movi_i64(oct_p[1], 0);
+    }
+    return true;
+}
+
+TRANS(MTP0, trans_mtp, 0);
+TRANS(MTP1, trans_mtp, 1);
+TRANS(MTP2, trans_mtp, 2);
-- 
2.53.0


