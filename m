Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F097AC9831E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMU4-0007Qb-HF; Sat, 26 Sep 2026 03:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRL-0004IL-7J
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:19 -0400
Received: from mail-dy2-x1d.google.com ([2607:f8b0:4864:36::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRJ-0000bm-49
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:18 -0400
Received: by mail-dy2-x1d.google.com with SMTP id
 5a478bee46e88-328664e061cso1770080eec.2
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406195; x=1791010995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jzZaAkkKnBmPcCjdhFCa0BO5hawVQDowSY7mBjvBRFI=;
 b=HC/Cfw9OHCYoHRTwyJ2xgIMEmcD34TUmhb31mdAm7Mv0LfuIvfrXc/koaSpemLngyO
 gJyycHZSJOQfxK8vUdUbXnA+igZhtDV4V7ZyuLn85/oxeny9AKWw+aR13pLb7hcjRUbn
 nm7pTsgNkx+M6y4ZZvt9a515UYDs1pBhvFkF6ElMrienaD4zsecE1HR2Kr6UFWiN8O/k
 Hf3eyQe835en6a5U6DPC+Yz3yi53hRekf9hdDds4SwdMnJZvYavdH9kxzXuBAQBv3GHu
 XzbPziGAGQePq1b/Ux8ddz11PomFM+2qXNuJlGLlaixoIc38dtL4XzBIcU8vetAgBYgc
 k43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406195; x=1791010995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jzZaAkkKnBmPcCjdhFCa0BO5hawVQDowSY7mBjvBRFI=;
 b=a6OWzU0rax3QMY0ECnNAd9efu4Pw2a0tUyQTiUA3ysK4duyVB1zDfcsfrb9W4nnshI
 mZX1jkcsnrvQNs5oSo27s4Ehs48ktmCGbfHhyMprmfuABpii5pNbxx/jyrISnlTEgliw
 0dakdkhOEHfx1yVZQwINC3BZyHBGxWA3KdwHRzFNvPysVsycmccdQltKPCKFWcxrsX8j
 I5fyfAURqU68tQ87I6kuH8dNcYdZ/UgpdsPxO7INxNZh2T0gO3rJw0MKyLupp9VxiU5Q
 IrtqcvWtDRMR6GG+GTqsFlxbqS6kfhGpmoKU/1NTxedtYawkqMn/Y/oNeODkUeD6r62u
 OWWA==
X-Gm-Message-State: AFuF++lAsuB7hNapY/xo01Y02v+BbImQsiZViqy3M/k9vKMCanOetgfA
 Cii5AfP2610MDtM4xr/Rrs9IvT9mkc7ymRhp0YHNwVYhjVQe4Mxh0b9B5zYK2JxX
X-Gm-Gg: AYBFou19tj8mhHjQWA6PBy99BnfT2qs4x0yyAF6X0QBH5vSwuaobMgSp6IQami+D7PZ
 sVyvrxQJotMw+bhFZZpHu1Xv5J5/zzmSrqSul+xfPzeJ0enOLnkltRpg53GBfPuNxeaZFmkVqDx
 QvIGCpYtBojyqeM4/JdveOARJ7zzsZ7l8TFYU69txkdOFzeNXtJMlos6vHXL0CM9V0gYKc3jQE6
 lFBklkQLSjJTqx2ewVrVAu3BGXrgDHuSPBs9EWCHf1X4QheGgB7+FSYQCNOzoE3G2ytGW3ziCGO
 PdqqHzfbQIkuHqmC8bcjgiEZZwWUJft6WBL+zMA1s/kFiNif1DSNGtjvyvvgqV5AU9++ydbC4Nh
 quYJ7XwYbCHMBpWErP/CLRF08pn3k8IE4iY8lO6d9ocCHt5vzlFmYA6RnERPGd+ESPk2VGZXYsY
 xNZI/jvNLZXvkQ83iV0wNg2O41x4tkEakaHqDq3CF2zt7MifpIKDpqxb1A8Ga0v7JmV+/fmpT1f
 JoVn7ubW8BwwJ34h2iDMtHOL8Vmmn0=
X-Received: by 2002:a05:7300:6810:b0:334:2bee:348e with SMTP id
 5a478bee46e88-3427236f2bbmr2301957eec.22.1790406195371; 
 Sat, 26 Sep 2026 00:03:15 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:03:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 33/55] target/arm: fix A64 guest address width at 64
Date: Sat, 26 Sep 2026 15:00:32 +0800
Message-ID: <20260926070057.1234-34-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::1d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x1d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Define TCG_ADDRESS_BITS 64 in translate-a64.h so A64 qemu_ld and
qemu_st take a 64-bit address, matching TCG_ADDRESS_BITS 32 in
translate.c.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/tcg/translate-a64.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 35f8d4f82e3..d4265de9dcb 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -18,6 +18,9 @@
 #ifndef TARGET_ARM_TRANSLATE_A64_H
 #define TARGET_ARM_TRANSLATE_A64_H
 
+/* A64 qemu_ld/st addresses are always 64-bit. Set before tcg-op.h. */
+#define TCG_ADDRESS_BITS 64
+
 TCGv_i64 cpu_reg(DisasContext *s, int reg);
 TCGv_i64 cpu_reg_sp(DisasContext *s, int reg);
 TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf);
-- 
2.52.0.windows.1


