Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BAAFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwrR-0001iX-Ml; Wed, 29 Apr 2026 00:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrP-0001hR-MZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:19 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrN-0008OL-ID
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:19 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b2589c26e3so112391385ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438156; x=1778042956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYaCpLhM2B+aL5Il3mvnrndYFUZT3mEw0ylxbbpyQAA=;
 b=TPWDjjfkr2zuU2q+9BI7fBZehBNJMeijBzGxxmWrzok0cvLxRIaoZGRyXJkAD7xfjJ
 PicVZiCjW3kAQaP86ISgFZE8aWG7gbS8hG9jtMGxcMBaR4MLmdCkoiKW10lOo/SdaFPl
 qeVNMMq/GsvGjepRWYbbbfYYsjw6F2NU9wDyDYp9Ug5qSu9W/9f5TzVJQAr7oJLXIqHY
 /7SyY29roNbNVanH2TXibae/XXOnfWA9Q5qBbTPNkSmV0okbwdAFCWTox0S1G/uGlZVe
 uyWQXcclZJwuG2UetavekXuz5AxzPqRPgVrNjpNaK9FUJ2kDqo88f0MzvSXi4ZDC/IPK
 klKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438156; x=1778042956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VYaCpLhM2B+aL5Il3mvnrndYFUZT3mEw0ylxbbpyQAA=;
 b=fcgS5UpFz/zvJjJGMs/W8a0RUf9Ox+HUl7I28sA4VCy0SxH/nkPrsxtsYxM9qIydTJ
 tcmcQ1jwOLtfKHF99AeAC4CqFrkTxX6slVl91vDMhbmayN02m/+AXp5dlgogDk9X0ZVs
 qwmd8ituTsXUeZRlsNuFGTX8ZFgmGHqyc80MbV8wlDhwEspU1/cgw1vHKpYO8jRVqn/o
 MeKWcWcMjoEmjglPel0O3AOFJfib3zS2xOaMTatoGfSd1fyudA6K4zDvE5zGnFQ3PCNB
 4mlOmVxcCnT2L9XDm9VcNUXJj2OmNbhIUne/9vEOgp7Q6Hd4CzAref+Xcl8nrv9xACd8
 PCuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BZHGF2QRhNAuVn+cKooYXM4RnDhNdjocvtYSMipUbUvL9hMjYof27QmuIOQ675ZRrNUMtdKHfUk5h@nongnu.org
X-Gm-Message-State: AOJu0Ywq57+zyGl6/u18UaHjsQo8Lvj1KCOeYXwqcamST5TAQB3OErVU
 ldbiFcodvoXeIYXE2FbYCL3MUd0s3ODu9umG7mBmLbOdUdFBONbE1hz1
X-Gm-Gg: AeBDieuMT8xra1K6d6EDugdcz/1hqx30bv/XKG2yKSF0NGU0A/sOHYRG8P7jkNs1Nzg
 ZC3a1jG4WN5SnCfsEZTHr0PPOa2SJtJs0fUMw/c8WTaLWbezjNibI5iEcNGNpl42aPHF2GL3Yc3
 o3J4xpOIVEkFJoPlhGo/PcIiAS9O9iiqroK6EcJRKeMgZIquRvMQqvSL+od5Rt7BnnUeHf5fAZu
 6baBS+PSZ3Oiv6gK57tgKAtkImImqeneDq+yY56zpgpI/VIPqn/TsS/k+cMaQPB7a3aHzaDSAgd
 SoMcohCGpjHDwRiMDN6I8mb4n0ZVvWNHImPdoYZZqQ1Pz/VQjA5/BnG2CDHh05+EwbJO2kOs+Jp
 2DizraKAc+DK+I2iAd56B/R3H6k6SgkvsSZ6A6YQ1lt8UGhmCtyHaSPa1153IwxsmKzb77YZPtM
 e9ZuZ3P6xiPwEMMzROKHu0Q7TpNdqAfCyAI7eKlUAPzXOGIVnJy3XW
X-Received: by 2002:a17:903:3bcc:b0:2b9:87e0:1f80 with SMTP id
 d9443c01a7336-2b987e02b8emr20731155ad.24.1777438156061; 
 Tue, 28 Apr 2026 21:49:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:49:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/51] target/riscv: Have gdbstub consider CPU endianness
Date: Wed, 29 Apr 2026 14:47:14 +1000
Message-ID: <20260429044752.4176397-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Consider CPU endianness when accessing registers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-11-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/gdbstub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index a5c1263878..2c6ccd4761 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -20,6 +20,7 @@
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
 #include "cpu.h"
+#include "internals.h"
 
 struct TypeSize {
     const char *gdb_type;
@@ -49,7 +50,7 @@ static const struct TypeSize vec_lanes[] = {
 
 static uint64_t ldn(CPURISCVState *env, uint8_t *mem_buf, size_t regsz)
 {
-    return ldn_p(mem_buf, regsz);
+    return (mo_endian_env(env) == MO_LE ? ldn_le_p : ldn_be_p)(mem_buf, regsz);
 }
 
 int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
-- 
2.53.0


