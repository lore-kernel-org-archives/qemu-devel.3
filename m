Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE11C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENZR-0007Ac-DE; Tue, 04 Jun 2024 02:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENZQ-0007AF-NR
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:22:56 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENZP-0006gs-6v
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:22:56 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6c8c880f526so1806571a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717482173; x=1718086973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mVeGIiMOTpViZqT/i0mT5bp2ZCtBNFV+Qcrg20yga8=;
 b=QivG5cvmXuJL9p4pIeiZXPYRQruydaVEWU+IfRDBHGX9RLCzJTvb0SKYrm6lYB5ljJ
 qNAWrYS8kVaE3Vktw24JqXmDkx+WKMjmn30cknXko/rCBAfhW8yLHSWKl1xf2VYsj4bV
 UYiOcuveQw8eNrQlkPr4a+8B50wBEptwxB4i8ATs3oSOX/VGExfewYQo41Bs5NCQU9ST
 n5nZB/5yLMc41Jt9kO1GlmvsobBs6lClbUIBkRtUNz7N90zpgve71g4gWu5i4hoWZz04
 rxjjba75b8Pl9Hm0EsBQql2kaFAJUERCxLF8OYjBDgSvJyaQwSwNfuXt1C1sV95JSAeN
 056Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717482173; x=1718086973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mVeGIiMOTpViZqT/i0mT5bp2ZCtBNFV+Qcrg20yga8=;
 b=Qhm6OdGRyQ6oOGA2kNAci2Py8fvBZvcVN5ATAvtjmnoL9LYMHiwqLIROVxxXzChyxS
 w9ziBPq+WBKlxq0dESJ/rgses6/+/s3mRlcd3lYSbE22codz6A95LaFqVcKmzjjHqHPl
 WyvLCCTEBCl3lZLl3z5Z0BWun+pVKoPFiTNgElhFPaaqhSszWTzJxeJDa25jNVclWQgz
 X1vDGN9M795VfjUx5PQ3Z/qvo5bmFgY44YA1X4WiJ8UMxtw6as+ijkMm6dlP/gaxnoMj
 HKjHUb04IWyyoqsUwkHcz4svp6jtnpeJCjMBfYeb8FfL7ZKM6gx0yI8hzwG8CZqMo4YE
 t/9Q==
X-Gm-Message-State: AOJu0YylQKgAKC/2GgoH1Gp0XGGXwnZ65uxnrVRbhrATvBGR8Klbs5ph
 0dKfDq5MSAxS7oziXRapYfJAtx23GSTOX5VPojDa5ptoeQJtoCvYpKE5Gku2TOWDefknWqZ0N1y
 jhX/WS6pB/TKPSZrbzYnUXmvkX1UUHXai0V23XBGXgDfRoPBsSbDSwRLClrbr/bFKujYLw+HAy3
 Ed1hZe80aBP7sCK3TDmAtyEFiurCjo9HVipr4=
X-Google-Smtp-Source: AGHT+IHmJQVRTWRwonwVjH66PT6OM0HAUviYRMBDy8jVXUmYQ1zD5KaUFC+XA1WSKYV5PFsPr/ZMqg==
X-Received: by 2002:a17:90b:245:b0:2c1:c648:14d2 with SMTP id
 98e67ed59e1d1-2c1dc55ff68mr10378867a91.1.1717482172624; 
 Mon, 03 Jun 2024 23:22:52 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1dcb56014sm7115617a91.25.2024.06.03.23.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:22:52 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 6/6] target/riscv: Reserve exception codes for sw-check and
 hw-err
Date: Tue,  4 Jun 2024 14:27:47 +0800
Message-Id: <20240604062747.9212-7-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604062747.9212-1-fea.wang@sifive.com>
References: <20240604062747.9212-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x52c.google.com
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

Based on the priv-1.13.0, add the exception codes for Software-check and
Hardware-error.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index f888025c59..f037f727d9 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -673,6 +673,8 @@ typedef enum RISCVException {
     RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
     RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
     RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
+    RISCV_EXCP_SW_CHECK = 0x12, /* since: priv-1.13.0 */
+    RISCV_EXCP_HW_ERR = 0x13, /* since: priv-1.13.0 */
     RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
     RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT = 0x15,
     RISCV_EXCP_VIRT_INSTRUCTION_FAULT = 0x16,
-- 
2.34.1


