Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EF8C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAH-0007Q5-Fa; Fri, 08 Mar 2024 06:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAE-0007HO-FJ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:22 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYA9-0001gv-RI
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:22 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e622b46f45so623493b3a.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896395; x=1710501195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rg5zcz1pyZPOD6sLHMHsSTVGrMgwOii+Qfy0M4CkoBA=;
 b=J2qUlXwAtKeIjff6x3fyY+4f1hb1LItd7+huo9YzUKX8+NK0RrkAL4ysvClIfS6VUR
 IDT86wIbccMzBX1/xNmjvBMXt8qYLTcTzo1SiTK4EtiWYLVzd5F+u/52gcOrydfmv50t
 yKLoTttyvl8JvbCothe8B83hr+oGdTJuoZRdC0Z5hPPqR8cVkjUPP8CY0OgkW4j8im01
 8CdMG3CNwtIdrh47imBTJKV//+goQ4R62WS7xku9GU5/hrsc6sXeevAB7bVH3LKS++Us
 hIRu45/LcXWP2KyWR64hIqNO7YvlDgHfA3tUVJtIN2dxtSQoNq+5DanfCNAIXjly0Rhf
 aN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896395; x=1710501195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rg5zcz1pyZPOD6sLHMHsSTVGrMgwOii+Qfy0M4CkoBA=;
 b=cK+KU2WPaBnXTGeoX+gWuTfOfUszTPmeUfM10wKihdnjLQu7SCZ5XyQnLyk07T7GcM
 VP7hkL3KWwZnUY5zmNzc3qoeXuV8uLOGK7XzTPeObhWd1wOIesaNF46EAXyuO4ggXjre
 ZdSpkV5r/bdgU2kPo0sRpmBgNXjrPa53FVUK2PG3bNOsxAjdw6Tlw1yBhH/xKwe6oKyR
 mdlgXZ6FxafJ2NaGqAl3sYDtlZ5/VYpdZzUFGfnk1gnvsQ7p5lLbl8Lg3lZs5NYBj8ae
 yZqhKcgXj/44ICcvRDRt9oRMiyaz5H8zY/JyBgXxxVflzr/QS2qV2lbbx0maTualwRtH
 NbUg==
X-Gm-Message-State: AOJu0Yy35G7o+q5lA1Jo49kp08tEzXrC69HjvthQlsEao2m1QZjuER6O
 DA4/Xq+2he4HEuR/eN/qOKkCu+GsFTrW1kWpSnVNgxzjjursp3pJJ/Y4dSnv1sFTBQ==
X-Google-Smtp-Source: AGHT+IGrFeMWYH2rmVZ65B3XXGZV6BUjSKTrxKb1a34dq/xTTQCAVKucQVWyN5rnUe6mJ14YvqEE1A==
X-Received: by 2002:a05:6a21:398a:b0:1a1:511b:eca0 with SMTP id
 ad10-20020a056a21398a00b001a1511beca0mr11915673pzc.32.1709896395486; 
 Fri, 08 Mar 2024 03:13:15 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:15 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/34] linux-user/riscv: Add Ztso extension to hwprobe
Date: Fri,  8 Mar 2024 21:11:40 +1000
Message-ID: <20240308111152.2856137-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

This patch exposes Ztso via hwprobe in QEMU's user space emulator.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240207122256.902627-3-christoph.muellner@vrull.eu>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 09239d2288..597bdf0c2d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8842,6 +8842,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define     RISCV_HWPROBE_EXT_ZVFH          (1 << 30)
 #define     RISCV_HWPROBE_EXT_ZVFHMIN       (1 << 31)
 #define     RISCV_HWPROBE_EXT_ZFA           (1ULL << 32)
+#define     RISCV_HWPROBE_EXT_ZTSO          (1ULL << 33)
 #define     RISCV_HWPROBE_EXT_ZACAS         (1ULL << 34)
 #define     RISCV_HWPROBE_EXT_ZICOND        (1ULL << 35)
 
@@ -8956,6 +8957,8 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
                      RISCV_HWPROBE_EXT_ZVFHMIN : 0;
             value |= cfg->ext_zfa ?
                      RISCV_HWPROBE_EXT_ZFA : 0;
+            value |= cfg->ext_ztso ?
+                     RISCV_HWPROBE_EXT_ZTSO : 0;
             value |= cfg->ext_zacas ?
                      RISCV_HWPROBE_EXT_ZACAS : 0;
             value |= cfg->ext_zicond ?
-- 
2.44.0


