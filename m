Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C31CDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 17:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqyGO-00071f-3q; Wed, 18 Sep 2024 13:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sqyGG-0006p3-Dy
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:14:41 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sqyGE-0001rd-87
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:14:40 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7c6b4222fe3so4597060a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1726679677; x=1727284477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gLczlRjPI9o0y3XIHKzhobqyXKG8O1cfEkc+jreqI0=;
 b=TQm1WYqMRqmwT9sSvxmFIqoQUFOWbsnW+cTz1dI6pocDHIEHsjsvT9wSOHwGKLLExN
 gd/pc16hdxTRZGsbl3wFcO3AbRNWCymFVOrm9/tD/etVmjDOVztA38u6BlFvefF5So1l
 OPbvYRp4uN9KF9wR9tscFd1OzL2Y/aORS85wsMBdYqKX1Ni9hYl1wlRB1mglXyZ/FsZN
 Y8t7GWB+zxenQsgEgbNl4PDU/wMbXs3shbD6q6/NVpz/CpUe++Bou6OzNE26XEZXXjPb
 ZJqxmIjfZg/SXMTtpKZjXA3kQtQZNeqbJyqm/ZD14xB/OwCO0ZcAKn7StCD2Tc9yOpdD
 Fwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726679677; x=1727284477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gLczlRjPI9o0y3XIHKzhobqyXKG8O1cfEkc+jreqI0=;
 b=PJeziWSkA1Kc+bix8IBRIQTRInp/FoPlWOFdtaIcYOZptPvIn//oqrMIEFcoJ4HhqX
 HNJFetj/fHGjxm1GMhzgDEXd64FzHe5AtObiJST+f0k5/MvnVxo7dlfl0olrieARp2EW
 qHDVbjRw72CLY/aGULWbJjtwxt678vGnMnBpiM0d6IVxZGlCtbPa0CT3ID/piQKO24RZ
 rZPGz4gQBBUw0AA0uIoNmaeIqF/58vFPlIEWU3v4CuUIkKuEukkKotc9ORbIZaqQ4zO5
 q0XG5bKXTRp2VdHRJYVPDmRsI7A7dPq7J2rvEP2+i/jcyO5UZ52hx4N4apaQTPslZhCq
 nNxw==
X-Gm-Message-State: AOJu0Yxscrt4Az0NXO7Jnlk3fL41ng/gA6ENhklAHyQAVYFG/MmmiSuw
 xUocVlNjL5q7vrJTd6Im61Ee1zd4GLvlf6T1JOn36fbplvrPhBSapljEigJVY5dbVIBXhDJhIuW
 Ltq/vSbVpmZIsS6RBOollqvd9xsVxOfGgHelpouA8t7gCHo1GvUuL0Sb4/wwSU2QsLcmg3KEJku
 FaDIvl2r0LJdvINAYA+h2ShUJCfwEmt0XS4liQqg==
X-Google-Smtp-Source: AGHT+IG9fL0f4YjbvrVsmY4IypiDn4mL9Xw7TrF4Zx852mj7hIWgHSy74hJgkAau6piqxzNL2tnLNg==
X-Received: by 2002:a17:90a:6d27:b0:2d8:8a04:1b16 with SMTP id
 98e67ed59e1d1-2dba0080957mr27383325a91.33.1726679676530; 
 Wed, 18 Sep 2024 10:14:36 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dd608e2318sm1914577a91.32.2024.09.18.10.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 10:14:36 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 negge@google.com, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 2/7] target/riscv: rvv: Replace VSTART_CHECK_EARLY_EXIT in
 vext_ldst_us
Date: Thu, 19 Sep 2024 01:14:07 +0800
Message-Id: <20240918171412.150107-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918171412.150107-1-max.chou@sifive.com>
References: <20240918171412.150107-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52a.google.com
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

Because the real vl (evl) of vext_ldst_us may be different (e.g.
vlm.v/vsm.v/etc.), so the VSTART_CHECK_EARLY_EXIT checking function
should be replaced by checking evl in vext_ldst_us.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 87d2399c7e3..967bb2687ae 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -276,7 +276,10 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    if (env->vstart >= evl) {
+        env->vstart = 0;
+        return;
+    }
 
     /* load bytes from guest memory */
     for (i = env->vstart; i < evl; env->vstart = ++i) {
-- 
2.34.1


