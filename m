Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AE0C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 17:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnM1T-0004uH-7Z; Thu, 21 Mar 2024 13:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rnM1N-0004nH-Vj
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:16:09 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rnM1K-00070u-Iy
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:16:05 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-42e29149883so5040421cf.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 10:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711041361; x=1711646161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bfRzyaQbdVM7LhhFkyg6noUZevlysrBjTZmd0VuOsCc=;
 b=CPfcDfZLNex+G20fSkCzrMPdEGqHB/IyZa4x8WhYWlOs3XHw3XT6xqJzYVcas/MKjz
 m50wdB6sY9s5RLkTo/MW+rWwh6fQFv9sJWvuFcyMoShSuJw3UQxux++Zfhau4W+zHyh+
 dMOJcPePJb5+MVyrUa1B2mdmP+zOk27Hws9oFvCS0Ios+eZUd1HuztuRZhPIp0ksUNhW
 LrhpS4sE0nNcaumzEggGRCqLeSXTZqp1nx3GB7lLTTvXFIfye0O1oYHIkb0aiexZf3yQ
 70duJatLp3rVI0FSdmzC+jL5+ntnjUx19h3UenX1Zp5uVUxPElg2nNWJTD/MB2hQFfH5
 LQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711041361; x=1711646161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bfRzyaQbdVM7LhhFkyg6noUZevlysrBjTZmd0VuOsCc=;
 b=Re24Q0eqtMXtjZZmvJPJWRODWrdSmNTMbv2xsfYDz0Kgeo1MI0OGMAu3lfJu1sriJI
 cJGxAcvPCAncTesNS9gN2vS78h18qSb/S53x8FnQalxEsnIekzSrvoD2dMWMhwJkauIz
 WsnqdFSIyv33o7qI9oVvJuMNsK0m8FIv2uDXc41iIyBfZKldEeP7dhvdZtJmtQQE/tyq
 6vO4P62DK1chD6w3mRNdhYK55bQkhVBel6lDj10lub1p8agENURpP7M2EMLvRStQPHLz
 /XpE7wUBgNz3qGtqfpJ0npZ0IPoIhS7a8sZD9Gehhi8PcJg0XuAkzn4nzDnJ6i72LVxw
 o5aw==
X-Gm-Message-State: AOJu0YyKsUkNCCujmOmFG23jRi/8WiUDSeeYFIdKHYvIKcK80TQZU25C
 U4fIJ3/6/bgSDo+XVjgwewVVAT3TySagB0sQzQI/mYpLaj/PegKe0GwF1ft+oI7hkkDjyYvtc65
 mykcKiC739GQesCfJI2AbSLZfYwAAksf+4T77Aaxvp9qj5JSvmTtXEpWqwheRwzOOyFR1uTuaC9
 67L1WSqYKGhSSNHF4stEocMVYZZv+H2snOddC9NQ==
X-Google-Smtp-Source: AGHT+IGxhclYz6XBiZKxlGAdH/UcoyCas7f4Uej4apIuOP+hyptjdNpNk40e4Jxg9EN3dhOfdKhoVA==
X-Received: by 2002:a05:6a20:1581:b0:1a1:510e:7673 with SMTP id
 h1-20020a056a20158100b001a1510e7673mr102552pzj.46.1711040976517; 
 Thu, 21 Mar 2024 10:09:36 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 k26-20020aa79d1a000000b006ea790c2232sm74028pfp.79.2024.03.21.10.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 10:09:36 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH] target/riscv: rvv: Remove the dependency of Zvfbfmin to
 Zfbfmin
Date: Fri, 22 Mar 2024 01:09:27 +0800
Message-Id: <20240321170929.1162507-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=max.chou@sifive.com; helo=mail-qt1-x82d.google.com
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

According to the Zvfbfmin definition in the RISC-V BF16 extensions spec,
the Zvfbfmin extension only requires either the V extension or the
Zve32f extension.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/tcg/tcg-cpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 63192ef54f3..b5b95e052d2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -530,11 +530,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zfbfmin) {
-        error_setg(errp, "Zvfbfmin extension depends on Zfbfmin extension");
-        return;
-    }
-
     if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zve32f) {
         error_setg(errp, "Zvfbfmin extension depends on Zve32f extension");
         return;
-- 
2.34.1


