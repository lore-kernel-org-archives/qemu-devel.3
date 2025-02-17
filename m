Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DD6C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwKU-0002Es-VR; Mon, 17 Feb 2025 03:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwKS-0002Bo-Cm
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:18:13 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwKP-00011k-TE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:18:12 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6e67f377236so5729076d6.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739780289; x=1740385089; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CIOoUkbjk51N51acNzDriCfyDC8X79FyXFjaBdinybo=;
 b=fqX7TDd+On4XSKBsKIVBgrG7w7ssHrSo+jj2zIRXaxfhRB29xtqt9Al8yH7a5UvZNw
 eqMsbT/y0J4cT89O7XbwR9idbtH9+K/9MC28pJkfVlP7lzy7Xd8xgtMolOJil3ocrRb0
 RLA3JVdHbfx8bMINoT+B4oB91mQzRARfolGGoolz2Z1nGedkLbgxRknr0oLh0d10CJ5V
 XTZolUOdY0LwFK9/KFqkmw+UyCD9D2tPGj8pDB8y/EPgddMYsTvmDc+3hjG7GHXnqQ3e
 FOBMaOsQTT9XEL6ncNGWeV2wcFN28BGvuDJ+221zzmdMycJjDzMqJ6dhzVWZgArfnL5K
 x1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780289; x=1740385089;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CIOoUkbjk51N51acNzDriCfyDC8X79FyXFjaBdinybo=;
 b=VaWuvTaKRCxxpBJzKmFO3zz72ItZyK/cEIDb7Km+ldAimqfd/botrqqxbGTu/2SYDf
 jC8XckcX7pPu0uQPXq3v0ogrIsFlLs1kGN657HUrWP3aN1K7ph9HgAsndI59+lL0y/AF
 giNqoFOzpLA1GVUMM6HXNXGio+kSWnh9MDNIQP40ubsK4+H09WDeD28CC0wKFjHgzLFV
 t2sxn/oPstopKQBcdT1TrdDgr/J8xI9sEbCavNH7RmMx9IwI5vrCMEe8UL37ldaBte9Y
 n6zCWs0DEh2zb0Gmrk6YZrDV8w5CuLJsIomvD+19zL1AYviarrWP9QEl9sHvs+saTf2f
 0LYg==
X-Gm-Message-State: AOJu0Yx6meCu6mQUJZaKUr7vm1Vhr/dEehx2dHYHHRR0CXMdXXZh7Ow/
 g6Nw1o0oPpNrCcV27+40Fv3AGe64cULOk4y1ReJd7g1TFJ2hI+eKR9fbI09Pw8MSt2sdVsERQBv
 jYsxWu+pcgBW2KDjk69/bFPvidAzxLHmUTYEvvm3HEIkbXtY2z0d+sIjqi+eIbg2Rg2Mp/v8Xoc
 QtYBezQerIQ0LQUdEicFInR1ZJr566MXxwtn/rN+1P2w==
X-Gm-Gg: ASbGncuq9novyPLsoKpxSbi69CDWJ7cwRj51/sYcmzanHFe/U6jBmb2g90ywrLPVh/9
 ARSAvtXjZLCZ5kZzZbDOGmGfJARSA/QHCB1py0OJ5I7QDPo3EMWuoorKhr9dzLkxQLXyr/r6QTe
 m+f6vTgyxFuOAzRZ+bVpwf5rrxmZTmYXcI7tC35G3EAeyGuxoBl50fcMnt/t7hoSnKAKQ+flnil
 0W0aYWNL4Iib94vJDAxQjAf9RpYxa29hGu36tqZzbSxrGGvObKIBIUoQ/OkZD6B5tnkgW3cUwMa
 0hs7kloQn8kfjfBf6p306jh+nsUVZwKMlB4MQdaE3UnSrA==
X-Google-Smtp-Source: AGHT+IEfZANQhcZDUv0bTis6sSavH9H1aY3LSqVQvrgPQLJ8aH649IbHLwd7nLcMsDV/2jlrYwF8Gw==
X-Received: by 2002:a05:6214:262c:b0:6dd:d317:e0aa with SMTP id
 6a1803df08f44-6e66cc85b7emr143122026d6.8.1739780288589; 
 Mon, 17 Feb 2025 00:18:08 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65d9f38absm49673346d6.88.2025.02.17.00.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 00:18:08 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 4/8] target/riscv: add helper to get CSR name
Date: Mon, 17 Feb 2025 16:17:24 +0800
Message-Id: <20250217081730.9000-5-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250217081730.9000-1-yongxuan.wang@sifive.com>
References: <20250217081730.9000-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-qv1-xf29.google.com
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

Add a helper function to get CSR name from CSR number.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 target/riscv/cpu.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 616c3bdc1c24..133d1852ee1e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -920,8 +920,12 @@ extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
 void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
 
-void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
+static inline const char *riscv_get_csr_name(int csr_no)
+{
+    return csr_ops[csr_no & (CSR_TABLE_SIZE - 1)].name;
+}
 
+void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 target_ulong riscv_new_csr_seed(target_ulong new_value,
                                 target_ulong write_mask);
 
-- 
2.17.1


