Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F20E7FDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn14A-0004we-6C; Mon, 02 Feb 2026 16:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13S-0002ai-Kx
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:55 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13Q-0004W4-4h
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:54 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-435a517be33so2942236f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770066110; x=1770670910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUBS5merpy0OaooqaAt7ei1cIBqyFwJU+awi87nIq2M=;
 b=CbJPkx2ard7nXrJsg0SS7DUVJUILOmlXVGHfbsaHJV1777GB4IHqfXtKsHyspAWGby
 DFXnM4+zRciHVrdZbeMAPVju3vWi3Jg87lGx4wCg0xY7BBgjn1pe5Zom4jmZyTIWmJ64
 ZILGSq9woaWyan2FP5lp5iNfaOkGQZk3GlHjAKwYmgPdi0S2u2oWyVgB/V9VbCvvuNVN
 C8t7lCpAH52k32X2bVvBu+Q54WoMa79f/nj37vMDcSXtw2DFw5oitJZFscnuZiHKrzkr
 VSdMfaba/G2NSApetJb5UlwwmoIrxtUdTItoktuiTjIlWQpfdhWrOIGXiAqhVjMB8Av+
 FUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066110; x=1770670910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TUBS5merpy0OaooqaAt7ei1cIBqyFwJU+awi87nIq2M=;
 b=Zu4101Qs+vKyTWlV/JeW33xu8LVigHOo/8EG1zPLqgX4cqChchuHXNE1385YJ76Bet
 R0wOMCDqQOp09t9ao/SwIF3jNk17n9yyadmYG57vUOSqte7wZ8yKf6cz1WRo29g+As8E
 hyIcl45QjIOCNEHVy4kikSf9hhjSCdnjroOzsFo1ibyQQYlJdVtv0YDaLbzDC5F/9Ny3
 9QBx+5ug+wQNNPXuFo/Wvq8CjJ0eKMHWKEFZxZV+Fk3h9itCe2kwNrELMkloR+WVRFc4
 WPuDNJJOQz/DiECG5GaHomY0o4Vzmw7JkE908z/+jifgvB/VOTj7+jQ7MnH2iK5GDys4
 wC7g==
X-Gm-Message-State: AOJu0YzMpJz5gpvL353mD15a+ydfyeupHivXCv31yDsQqXoGw7C0vjP+
 TDTWNDGTzngkQXn9/Ivmd47LEWUL+tjUb6RTB5a1jUaJMJdKd+YlvFkqo3BLEF5/6tnR2PGJCBn
 Euv/Rhh0=
X-Gm-Gg: AZuq6aJgkIHmoJWEnus0tkXsmEoeodbE695vAYobOhV0lqfuaj45BEbrM6tAWVLMDd7
 gtVra8KLZu824lGBqG88eSvQSYYvkqY9u2lOjdVvb90VWCF8pLp6rys08Fk00EhWh/nMwe4BkPA
 KAbx/W5JMjPyyI/TLlffUt2MeW2nzckB/EgoCtwUUd3kSOHwc52a2/vU19+oGarEJyCuuE2rkGI
 b9Hinvxll7junpFTobPiNpBhcNGEHP5T6iq2yoTWgiAebwRIMGqVNPJHGLz2zLoItwpLu7OdX70
 KFQ6zqGCIxBVCgCGNLh6fbFnBKhK9/8qrUyavR/RH6oau8dRPpB+Ylyc+K0f/JNJD4gNcEdFph2
 RBf6mnKRjY5H8EbEncNlC4eY+5IIsOPeWuqZjQg/bN0c2sxlUgIWJd33k9RPbejnyfOUK8oEYyk
 MUQtatcgGMHgqkLOI3tFW9sfMOVmu0ysbCnaMN2McUZHKhc609lba/XDCaqzq6
X-Received: by 2002:a05:6000:114e:b0:435:a647:a3b8 with SMTP id
 ffacd0b85a97d-435f3aa91eamr13134697f8f.36.1770066109982; 
 Mon, 02 Feb 2026 13:01:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4824sm48579216f8f.1.2026.02.02.13.01.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:01:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 06/11] target/ppc: Introduce ppc_code_endian_dc() helper
Date: Mon,  2 Feb 2026 22:01:00 +0100
Message-ID: <20260202210106.93257-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202210106.93257-1-philmd@linaro.org>
References: <20260202210106.93257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Introduce the ppc_code_endian_dc() helper which returns the
MemOp endianness for the CODE path.

Use it in need_byteswap(), removing one TARGET_BIG_ENDIAN.

Note, the target MemOp endianness can be evaluated as (see
commit 5c43a750b67 "accel/tcg: Implement translator_ld*_end"):

    MO_TE ^ (do_swap * MO_BSWAP)

For PPC we use the DisasContext::le_mode field to swap the
default (big-endian) order, so to get the PPC MemOp endianness
we can directly use:

    MO_BE ^ (ctx->le_mode * MO_BSWAP)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/ppc/translate.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 17e6d07c8c2..e1753ce19ce 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -214,14 +214,21 @@ static inline bool is_ppe(const DisasContext *ctx)
     return !!(ctx->flags & POWERPC_FLAG_PPE42);
 }
 
+/**
+ * ppc_code_endian_dc:
+ * @dc: the disassembly context
+ *
+ * Return the MemOp endianness of the CODE path.
+ */
+static inline MemOp ppc_code_endian_dc(const DisasContext *ctx)
+{
+    return MO_BE ^ (ctx->le_mode * MO_BSWAP);
+}
+
 /* Return true iff byteswap is needed in a scalar memop */
 static inline bool need_byteswap(const DisasContext *ctx)
 {
-#if TARGET_BIG_ENDIAN
-     return ctx->le_mode;
-#else
-     return !ctx->le_mode;
-#endif
+    return ppc_code_endian_dc(ctx) != MO_TE;
 }
 
 /* True when active word size < size of target_long.  */
-- 
2.52.0


