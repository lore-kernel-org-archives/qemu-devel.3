Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE3AC25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENZH-00078A-7v; Tue, 04 Jun 2024 02:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENZF-00077R-FS
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:22:45 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENZE-0006f8-0e
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:22:45 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-681bc7f50d0so3717802a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717482162; x=1718086962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmHsMUz/pX/ZNVmgFEjShgDAW9pA0BGkng6p8nimz/0=;
 b=MJ8XF/eGIPxYDh1V8+dwOdTcUeGIpv9jWZjs2mTM7ctMsSD0BTB++W6TNjI8RwuFOj
 W8qoFktr1vGx6jezCZmVYp2PZYofLv820n6FNVSqTtHbuLKQv24D6GwV9aHTcwUpg3UU
 1QJRP5NEjO4oOwZSPn0UmFCLsufH/ZtO+aChK+IY4/v7eWYmVtpk3G2WUHBfcBE46Uu+
 seK4zGvkA8/5/G10l2jHOB5hmMKmqd06/rjca4hvm+MELR215+ZhvmtgkEFlm6CEadUo
 xHQioChB3kvJsgbUyPRAHnzHoNg1bxw5AFB1GsfDK8WeutRcYkhlDbRzUcinhJq/c+uQ
 yhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717482162; x=1718086962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nmHsMUz/pX/ZNVmgFEjShgDAW9pA0BGkng6p8nimz/0=;
 b=J6DEt3BzZgwHn31Aw9G5tSWAXIHaAmgedUzad6dyPZAMCkFDe//aWviBeDFWvaQsIx
 psyMJhG38o45Uj1KK77cqTtsBiXBbAsCsCt7fcN7RFlrGe3vkFiHK6+Kh+SCwgnP7koo
 wvEJ7e/5nSZDmuxyJlpGSj5Lwj05dCSLjYuautBpvcb2a+it6kqm2KTT77YZMJBkHou0
 2uzbUZExvpfOuxX9i5SSwtsXXurAHzm+Wiq/3b3VJvBRsePAjVqaNeqtxSLze8Ht3vPu
 WBgEFxvkH4R/W5squ6sW12vM7OQgaSIeiPx+/lyzeu1h1uvucLzbmdmLtI9Nm25NW8dJ
 I3Mg==
X-Gm-Message-State: AOJu0YxcvajESobokmI4sNDQLlev8uWWIzC8tssTB7eN9NTD1VUwnAWa
 sKNPWi73e4+3cG3fjMEUb2i3Xb0shLvLegTLuIKQyF+dB9zUDown8dRUQQzPAkueBK+XGzzBXch
 RvqcOryNN8TpfTZNy4zQbq6qu0WrfMErbfdxQj5TllQcOf8Irr3Gl37NAZexTZGRYemMH13UiZs
 VydXtRFIYFgqmG8Bx47ouv66Jj0mu2ibJ8+04=
X-Google-Smtp-Source: AGHT+IHwrIBPeu8ZA4jxr+7tSS0LNAvYWM8ligKABX8KT4oNDKXAocPojh0HibtDWbkvHKCqGGk+zQ==
X-Received: by 2002:a17:90a:d150:b0:2c0:93e:df44 with SMTP id
 98e67ed59e1d1-2c2530b584emr2600172a91.17.1717482162127; 
 Mon, 03 Jun 2024 23:22:42 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1dcb56014sm7115617a91.25.2024.06.03.23.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:22:41 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 3/6] target/riscv: Support the version for ss1p13
Date: Tue,  4 Jun 2024 14:27:44 +0800
Message-Id: <20240604062747.9212-4-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604062747.9212-1-fea.wang@sifive.com>
References: <20240604062747.9212-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x535.google.com
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

Add RISC-V privilege 1.13 support.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Weiwei Li <liwei1518@gmail.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.c         | 6 +++++-
 target/riscv/tcg/tcg-cpu.c | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e9e69b9863..02c1e12a03 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1775,7 +1775,9 @@ static int priv_spec_from_str(const char *priv_spec_str)
 {
     int priv_version = -1;
 
-    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
+    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
+        priv_version = PRIV_VERSION_1_13_0;
+    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
         priv_version = PRIV_VERSION_1_12_0;
     } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
         priv_version = PRIV_VERSION_1_11_0;
@@ -1795,6 +1797,8 @@ const char *priv_spec_to_str(int priv_version)
         return PRIV_VER_1_11_0_STR;
     case PRIV_VERSION_1_12_0:
         return PRIV_VER_1_12_0_STR;
+    case PRIV_VERSION_1_13_0:
+        return PRIV_VER_1_13_0_STR;
     default:
         return NULL;
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 60fe0fd060..595d3b5b8f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -318,6 +318,10 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
         cpu->cfg.has_priv_1_12 = true;
     }
 
+    if (cpu->env.priv_ver >= PRIV_VERSION_1_13_0) {
+        cpu->cfg.has_priv_1_13 = true;
+    }
+
     /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-- 
2.34.1


