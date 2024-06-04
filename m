Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FD0C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENZA-00075W-Li; Tue, 04 Jun 2024 02:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENZ9-00075N-K7
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:22:39 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENZ8-0006dt-3G
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:22:39 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so6237985ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717482156; x=1718086956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjK9w4dqjAkqFbNC+54zCtsFUYuidAUsOJ629MgVBnU=;
 b=EFWUEwVYick/V1DdyIX0TkpmlPMmjlQ0L6wte8OiRLfl1Y5gb5N2XcKgqykAvS/8oM
 ih1+jcg/GqvpEBYx9fIDJnj0j/sGcQadLw+B4G+xRf+pDF8wonx9lEXuwkAhOUScAIyY
 gJXE5ev6ffykHVdPfLFgfb0Uyr15TttNyvCcu5pxKpcLrRJvfALNCNfXO4qaclScwYRz
 OOUeCTM18KH1AsW5zqqqS4UsXWQ6yKJb4fIKs8NydZYhvbTCE8xY1hWkFWQEtjblRhop
 pDNv0qwxpzewGHXhYVSC7SgiMfM5t6rnGJt68zSzye+IorlQsRcyLF+VxYN5rttfPnk9
 oQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717482156; x=1718086956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjK9w4dqjAkqFbNC+54zCtsFUYuidAUsOJ629MgVBnU=;
 b=mMPvx1PrVkXM3cpWRcTo+jDckCRB7fceT7I1RUF8jJs8ee3N5OQkKzVgQoryt9uE52
 EBp/I5jFV4O6/5VR0yb4m6kOCxHkgVgj4aP1aVTCN3Yl1mxBZTCfxluyYC3XFFEFvirb
 DmUPgvw3BVxYyAVUPyPs1ETVTSLiZKthlV/cv2rUn0UcWtjNfymYBt5Qbr1v/z8ebssE
 AEWvQknZpjUc5iM2oKKSN6l/v0Gzp3F8stzH5FwI8N1VapXC+nuR2QNki2yJkoL20TyW
 HrzoL3lPMheIeyYZrFU7hGqhRpscF5KRldIPAYCELESZI+c8U6XqTMbzZDKtjuEJ7JXN
 PFCw==
X-Gm-Message-State: AOJu0YyP2wx9gIxlQqBMZPavJdUG1d0vteAHMj3y8ZaqlLOa1VIeSMy4
 ZqSxrcCLhak3g1ae6zvjI9ox8i3+NP/o+nW13ed7AsJTw2sdlQOiZrWfZW+kX++OCeVfpZ0FdjU
 Vs+/9kVgUkOiOfO26CWdZ0NVX1Ecs0qUypT69NchxnmK8JReHb9E29C0F69JDIopK/Q2bpxPF5D
 hpMgGXVpHteVg2E2QHTY8a/8/9SEWfovwJwvU=
X-Google-Smtp-Source: AGHT+IEpxCWsnqHJ3JU4zZqgzja9LurmvDnkE1Xp7m6V2es63sIYon7WTc65lp7mYXVEKPLrHufFLw==
X-Received: by 2002:a17:90a:df96:b0:2be:b9:da18 with SMTP id
 98e67ed59e1d1-2c1dc560b85mr9587083a91.2.1717482156182; 
 Mon, 03 Jun 2024 23:22:36 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1dcb56014sm7115617a91.25.2024.06.03.23.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:22:35 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>,
 "Fea . Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 1/6] target/riscv: Reuse the conversion function of
 priv_spec
Date: Tue,  4 Jun 2024 14:27:42 +0800
Message-Id: <20240604062747.9212-2-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604062747.9212-1-fea.wang@sifive.com>
References: <20240604062747.9212-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Jim Shu <jim.shu@sifive.com>

Public the conversion function of priv_spec in cpu.h, so that tcg-cpu.c
could also use it.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         |  2 +-
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 13 ++++---------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cee6fc4a9a..e9e69b9863 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1786,7 +1786,7 @@ static int priv_spec_from_str(const char *priv_spec_str)
     return priv_version;
 }
 
-static const char *priv_spec_to_str(int priv_version)
+const char *priv_spec_to_str(int priv_version)
 {
     switch (priv_version) {
     case PRIV_VERSION_1_10_0:
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 12d8b5344a..94600b91fa 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -829,4 +829,5 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 /* Implemented in th_csr.c */
 void th_register_custom_csrs(RISCVCPU *cpu);
 
+const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 683f604d9f..60fe0fd060 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -76,16 +76,11 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
 
 static const char *cpu_priv_ver_to_str(int priv_ver)
 {
-    switch (priv_ver) {
-    case PRIV_VERSION_1_10_0:
-        return "v1.10.0";
-    case PRIV_VERSION_1_11_0:
-        return "v1.11.0";
-    case PRIV_VERSION_1_12_0:
-        return "v1.12.0";
-    }
+    const char *priv_spec_str = priv_spec_to_str(priv_ver);
 
-    g_assert_not_reached();
+    g_assert(priv_spec_str);
+
+    return priv_spec_str;
 }
 
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
-- 
2.34.1


