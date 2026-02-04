Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8BBE8B39E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHy-0007oh-3A; Wed, 04 Feb 2026 00:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHw-0007mw-LU
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:52 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHv-00085R-29
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:52 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3545cf80e1dso1643312a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182330; x=1770787130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATVqaM7ZW01f8u/zPmOMSZFgIAA3aDS5ix/aVxS3Tys=;
 b=MXzeEd+gqqh8huFmYKlPzf5K9qkE6vdn761tvPhzitjApVbeYqW1JXnIYMVvXUfoRB
 fW1l4mWGFd/bTAocu/l+gDpsgEati4PV6SMCICgwlxYODiel2SuUBOBev9D+Gr2B3MzU
 QYIPqktM/zq+gHbPVsSc7KVMnT0z9IVKVbOoJlkPozwZxaDnD/K0dWwynI9iHR3mvXcT
 c4IgyaUdIxL5F6v1fdOhmnO73BBDlNdPasO/cbMHlRIwZIOb0tgU9tWVWRRD6NBrE4iQ
 fXn8K+bro4CiBAgCubdlwtnYAflM5iMhuN8u+vYfBlnxo5yhL2MZ6G4apLU7/zC9Zyq9
 r5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182330; x=1770787130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ATVqaM7ZW01f8u/zPmOMSZFgIAA3aDS5ix/aVxS3Tys=;
 b=fQiag02O6WZJq2UyvyUWET3MeFShBaXZz+1gi4gkA7YavvkS3qZhnwBzyqD3iRXwst
 1L2CRVvNBvspVs18Bgnq1XuNynqQuW4NMRPUrJJZ7EJkdtjjHC8KejDDnqiMmQ6WxSWL
 leyEr7JS0bP7WJpy4OW8IDtxuqa8fT/f6A+7smer9/yHs6ayh2p4xAbMSZgRRwMSCjdG
 qtPuuPH5Yx1Z72b8KeDNBLbqtnJ2jBuLszC/6nJbcZUideuM3sBK4Fw86ncBedDSGKAo
 myAV9qDsnP1PSIVca5y59zBW6teK9bSMCoeag9DiTKoByzazW+mMdB6lvMXtr6iqUfRN
 XzBQ==
X-Gm-Message-State: AOJu0YyROadkLGOeMP4lGAiTyIFEBGMElBCZWSBg8Ge0Bykqp+gCvU3b
 DkpOvuWA/tZ/10py+CiLSuI4eVSIQEJ0RVsFWyiglR5Cmf+yqsDHHL39DBxGoALIlbS1Nx8ag4m
 cLLKqpbIGHFs1s9Hz/3Vj312J4imcTDXivEfSMy82lPr5EEXNGen8hSZRip7vcqyNM8/nW3UbhG
 7bS4vOFkLhOFtkj3J2c9CQZK9iyQsnnygYOetWJcerQY9/
X-Gm-Gg: AZuq6aK2KMb1zK0bG6DD3lRLi/uWCPIOi7P9iK49fCu5tbQQrnYdxxu1tI7kyLYJo8r
 8XKjoeomMam+R6/6QPc6WXCgCJmik5AsBwn3u3YobfTIxl0qMfUkhBqHq6aDaOeeNzi5kR+WA8e
 ZK/RYEub5w8NgwUIOczGHXslzZH2xSFk+4/ml1UdHH+HsyOCEooaYKvw8OTeOrp99wQBasV1MCB
 hL4EfV1V551Q2yPOdUwutVf2qyWABsJtdv1xLdDaKBO1vVFteL7o9TkH25HvVsM87N8ZYufWvm7
 69qpMjwETo/FHqPLWBwtrVuW7VO1VzXc1hBvUlAW8stmVCtlfqTIipB9xW39rpPfzRrPiX2tYcp
 +uLI37WSyNWcj30rZ8HRe/fzG9ojbnXX+ffL/j6cXpoH0WCiDkluTm+e8ZVevwj4EbcDttphuvp
 yslwd/ssIT+1Crn5oSpQHJJXTnMW0waiutD06ScmmCGXTthowFSz/4y77aR7A1ZzvacGBchL2jd
 nL368GJyi3W+MI=
X-Received: by 2002:a17:90b:2742:b0:354:56fc:b71d with SMTP id
 98e67ed59e1d1-35487117592mr1567214a91.11.1770182329598; 
 Tue, 03 Feb 2026 21:18:49 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:49 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 15/19] target/riscv: Add cfg properity for Zvfofp4min
 extension
Date: Wed,  4 Feb 2026 13:17:51 +0800
Message-ID: <20260204051756.667397-16-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1033.google.com
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

According to the ISA spec of Zvfofp4min extension,
"The Zvfofp4min extension requires on the Zve32f extension."

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c8cb3d021d..7823508615 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvfofp4min, PRIV_VERSION_1_12_0, ext_zvfofp4min),
     ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 59302894af..353a932c36 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvfofp4min)
 BOOL_FIELD(ext_zvfofp8min)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ba89436f13..b1097e55a3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -715,6 +715,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfofp4min && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfofp4min extension depends on Zve32f extension");
+        return;
+    }
+
     if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
         error_setg(errp, "Zvfh extensions requires Zfhmin extension");
         return;
-- 
2.52.0


