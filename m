Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222A606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J2xsczy4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXHp-00077p-PI; Wed, 21 Oct 2026 10:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGZ-0006IU-45
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:07 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGX-0002XJ-AX
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1682bff3cso4367565e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592763; x=1793197563; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3UVUMo+T/OBTj3kb5bAvKfvNqABTzBk4oQWpNMpOE4E=;
 b=J2xsczy4auVt+5cJ60UvaQgWpTOYg2z1kekMOeNSrqWZHfcie6B3C6Za+hqHAF6jp3
 4e0lDPc4B0B2CwLCbK34B/lxaIx9rg06z+UWEbDkPxaS0+VYJwiljHy9jvUMHeqgm5hJ
 zjUK2YG1k0vnYDBZ8l6IQot9s9vM2FPbiD/zoj5Vx7dhk2Hf5ZvSIr7IJNcVrCxh7yoe
 1UQ9RTeQTVX3q58pWSE3IqwOA5PaDEdv2gXeoyJrYz8K74P4DAihKCF1XjweNnruuAHR
 1Y0vqXnKMuyC6S/f/PAlziWoe7ahATy5viAxDD51OMCudEyOVCkctzwHje1/gaCURhDg
 tG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592763; x=1793197563;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3UVUMo+T/OBTj3kb5bAvKfvNqABTzBk4oQWpNMpOE4E=;
 b=W58a1HoQU/yTUW3HgO1r2owEr2csWfgsloB7gPTaI29VPkfDQWsBxbrA/OqiBKZub7
 zPAVUNuvb6+ssfYvl5Kk/TyQwszU0X3Vjpm4jyZ45PCIYejscg9AForzeelVFdMV0iGT
 mBJPwhXukZK8yYffBSTuwLQ31wc9cJqw/GrC48O7pQAOeWrhD39LxTNYc5GTl0zYEpKY
 yXS4RYHsCd5dzRG9xZRmUW3JYqpY1xDKp87PAmLUNr/TOWAnyKKDAlaE+wMXzkdS5zU8
 FALric4yx3MTPyQc523nZYzWQ9//QklsgBxhuZD/sUiqzYFeor8kyqZxU6nl5sb5GSQC
 VCcw==
X-Gm-Message-State: AFq9FYIPAg0GtRG69J/BOzTnELTHRL5Ea57g7c9QrMuqCC7odHY67wg7
 ZVwLe3FBZOFKM3d4iN7uK5TmMQcAY0BKzuh3tH8r9y5fzoqrsqZ+CHH+JlVtf5OSXGBVKETiKGZ
 uADfQHXs=
X-Gm-Gg: AYBFou1g8LDjF+NAxYvQb7WJpVw/YqcYCuDhsDYinhP1TAse/PnLIAtR4OPdOVKhyfg
 hh0VECruIApGifPFjBil2PLoHkAJyc6j/YWP0NGz0F4xFpCpH2akfa7F8adatuzC5ppWKtSdUus
 M9qnfBmu0fSzw8vnOUAcBlPfQj3YkBMV2+37d3BjFP++F7VDar5f09ucEI53gZ+tZ6ZM8IT90my
 ky7Br6iF/TJsbF/YSXvGq56KDzAkYzwTvBGsh4FKNM4KftP2EswS1d40MDf8SPtvvettlEBJXpI
 7kbjVWdaZn0vwWjSKZR+TgtIGHAwJbIAL6xwPUlZuAPXdD0CKlmiOwR0f4TG7oWCRNjG1CXDPfC
 cyKfoEQ1VGw5fZgTM3ps37ocHiSFB0MHhKfdWF3ydC3E6eNx3bThtjGfRyDY08fkv34oXVP2mou
 sTjTvXxSFJ8l75CjeBwYkXkIhDapwf57+oQxhbBwdcw2tdTLr/otuLJr9PX/xGQuUskiremh1iy
 vHBOqqRDqn5COg2zod1hv4GqjiJ2VoqhsHfKIbGOwFl7oMF8aexUipq5SIS0XwLw0ke9Dt7af8H
 A6QB38nkxmMerksUNLONvugW2W0=
X-Received: by 2002:a05:600c:8a09:10b0:4a0:4a8:d444 with SMTP id
 5b1f17b1804b1-4a1fdd39ed0mr36818885e9.33.1792592763498; 
 Wed, 21 Oct 2026 07:26:03 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 083/100] tcg: Use unsigned for flags for bswap and revbit
 operations
Date: Wed, 21 Oct 2026 16:16:35 +0200
Message-ID: <20261021141652.363109-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 8 ++++----
 tcg/tcg-op.c                | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d3271c5a66..9f5cae36c5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -133,7 +133,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
+void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -158,13 +158,13 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
+void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 94befedb69..c3a8a04a4d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1302,7 +1302,7 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
+void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1503,7 +1503,7 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1546,7 +1546,7 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1613,7 +1613,7 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_rotli_i64(ret, arg, 32);
 }
 
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-- 
2.53.0


