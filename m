Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87876C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 03:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWREo-0000BP-VK; Mon, 30 Jun 2025 23:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uWREl-0000Aq-Pg
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 23:00:48 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uWREc-0003Rx-Bp
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 23:00:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-234d366e5f2so33943505ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 20:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1751338835; x=1751943635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLHPoqlgGFTwjTolk2Arh7C0UBrzj9GZbdLJ3xnnHEQ=;
 b=HDpbHLpLOevj4RYKO0NTU9LyLSnnjkXxcWInSwH1ee/b7zMO122mTJFQc4/M0q8/86
 2RZ7/kHu8qtWO2q0Yujk9EZTPLRBUcqqctZ9tWTjQEaWQ+6W9gldC3sFhoUHOXdf2/rZ
 GA8/4X493aBpiiEp8EvfC9p0U9iR0jDlYyMeLBH9sxQGQJ2ziHazsWf/C4mJHRSEklf3
 ssCrsqqLXZyk2GibHJiC2vWkuc2nR0/2v+2qV7G+l8qB8+l5JxZ3hD52z/XUDs98Z8SS
 bNMWO22MXEVsuRp3yZYGutEEwYK53lIxRBKHyvr90gFykj0aGpvGv228HC67EWR66eK2
 XYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751338835; x=1751943635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLHPoqlgGFTwjTolk2Arh7C0UBrzj9GZbdLJ3xnnHEQ=;
 b=fYZYM1WfOT8QqK3ucQpdkBVu1Bro7tvqPLkzuL1OgVIjNeJ98g/uOfhqN6WjcFU2fb
 CG67XFBxt1y8MQKHpDb/dbCYl0vaMHe6aFVs35KyDuyrimm3fEbU9hGdjwZ+ZsaGkx3C
 YeQet22fUsGxg+bnlAsti3o3SYq/Gges0Y8zYdxtyy4FJDT4liO+UImvvW715lZwj93x
 +e4qLVosgfGtjUN0gO2GYgWL1/b0USllXWqVhqS+jz/WJ8dtux8ircUIFnb6SmIvC4rP
 yI5tRI5HyJx6ZBJdFA4fXSxW1mcjsB5sTNGlYvbg4YG4pjNd6rtjN4w0g053E2RtbN/h
 0EXQ==
X-Gm-Message-State: AOJu0YzZ2ZHHuhMtPaXFQqMZVL272MfiwOlzmjbIIz6x8jOPI+TX+Szm
 zO3vyD5P9gjEwfMgS//gStiLmwwhFJDXfCZQBd3zqwm+lO/0KwyWmZwWm/1JC/L9K/kDX50vl57
 c9X67CJYlH+wj4QzmtPyc559/S0IQWUtfJCp2sNL461YjobkNn9fwYBbeTbkbINnZaLNu1vYTri
 e51diX+zFOnC9pPMJKgurte+FVgK+RdjRY7InNobzVtUs=
X-Gm-Gg: ASbGncs440hlKqVkvCXezAK+K9y9B/zdPYdkNKOhVv2D+o4M+Fm+OJinPxlP4W056ib
 ViQO2PUhZWWyNZkhT5pzpv120mq/EwcYRuJtupd1oY0xGPJBHNeKgU/biv+mcWxESWMuZczin0i
 M4f8H30psD8qfl/mQZ2CtGKk6WyiCR0wRJJJmz3axaCmeNI/s8n/YVrde2SmkC4c139HfuMVyND
 rCkxwkzEV13UbKEgnvNoITaXLn6lWXbWgJBdGbBYO/xw5wVOSGm0oApCVbPcc0fA0ytH5D+H/HX
 VJ9fO2PPcpTWwaG8D9pbNYKvtIeefLQUrA9wmrlUDwmpjcLub4uFWZqSrM8byP1lKjoDXbkEzNx
 L71yHAA4kz4hJ/pWULtDYG3E8+g==
X-Google-Smtp-Source: AGHT+IHKoBoC/g8VpOnseI0712lhr0SFVcxdXokMQBf0cOnT19OFykNrc/vygcwvV2tBgEBxssLM8w==
X-Received: by 2002:a17:902:f64f:b0:223:619e:71da with SMTP id
 d9443c01a7336-23ac4880725mr234753815ad.49.1751338835311; 
 Mon, 30 Jun 2025 20:00:35 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.187])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3bf1f6sm95966565ad.204.2025.06.30.20.00.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Jun 2025 20:00:34 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 2/2] target/riscv: Restrict midelegh access to S-mode harts
Date: Tue,  1 Jul 2025 11:00:21 +0800
Message-ID: <20250701030021.99218-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250701030021.99218-1-jay.chang@sifive.com>
References: <20250701030021.99218-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x62a.google.com
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

RISC-V AIA Spec states:
"For a machine-level environment, extension Smaia encompasses all added
CSRs and all modifications to interrupt response behavior that the AIA
specifies for a hart, over all privilege levels. For a supervisor-level
environment, extension Ssaia is essentially the same as Smaia except
excluding the machine-level CSRs and behavior not directly visible to
supervisor level."

Since midelegh is an AIA machine-mode CSR, add Smaia extension check in
aia_smode32 predicate.

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/csr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0e0ad37654..74ec0e1c60 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -374,8 +374,11 @@ static RISCVException aia_smode(CPURISCVState *env, int csrno)
 static RISCVException aia_smode32(CPURISCVState *env, int csrno)
 {
     int ret;
+    int csr_priv = get_field(csrno, 0x300);
 
-    if (!riscv_cpu_cfg(env)->ext_ssaia) {
+    if (csr_priv == PRV_M && !riscv_cpu_cfg(env)->ext_smaia) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    } else if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -5911,7 +5914,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MVIP]     = { "mvip",     aia_any, NULL, NULL, rmw_mvip    },
 
     /* Machine-Level High-Half CSRs (AIA) */
-    [CSR_MIDELEGH] = { "midelegh", aia_any32, NULL, NULL, rmw_midelegh },
+    [CSR_MIDELEGH] = { "midelegh", aia_smode32, NULL, NULL, rmw_midelegh },
     [CSR_MIEH]     = { "mieh",     aia_any32, NULL, NULL, rmw_mieh     },
     [CSR_MVIENH]   = { "mvienh",   aia_any32, NULL, NULL, rmw_mvienh   },
     [CSR_MVIPH]    = { "mviph",    aia_any32, NULL, NULL, rmw_mviph    },
-- 
2.48.1


