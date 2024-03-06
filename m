Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4C7C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhum9-0006RU-1o; Wed, 06 Mar 2024 12:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rhum2-0006PX-EP
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:09:47 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rhum1-0004Ip-0A
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:09:46 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so9404955ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1709744983; x=1710349783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/18wfbLvamCXsunSuACFEdx2geExvEp/XalCaIzNx14=;
 b=eD5YUdp2sq3+5wew2ofqRO6w7WX5fUpKv5pBPvUbS+ataOmRq8c09pAEt1BwSdARbC
 Dif+ijlu9RQ7unafF6j8CKP3DP+Sx3ts6zrrPD/DN8ZM5ZrmWnUmqLmomZ5/gDhGq0os
 xTpIyu21BxTPRCeOxBs0vI2bcdtjafW6R4jyluMq7vkPjJiQDLSCEM07ivqCMZbXL70+
 OEFMgcgirNFhwa97Ll0mHudyC4RRN3rZvgl9VLBkdgKn554cRXlYGV6rTbb8vBYVoDtg
 weF9t7oQCI7jh5A7WbNjkzVp+8j521bbpxFBI9JNgIezEzAJpIvMwMRzv63Mo7+fVYMz
 5xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709744983; x=1710349783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/18wfbLvamCXsunSuACFEdx2geExvEp/XalCaIzNx14=;
 b=Lu+9R/FRidxDO1N4tu2CgWt/O2PeZXA7VEFk6wwlbrUiWXZ4HhHqnAKtITaTi38w/Y
 N3+iSndzflpLsNUsfgBoI04Pkz0ja/8OykDHPOW1tqsyZnh8hTsBXWlISv87Xzr9Dfw7
 +dfPVbXji/0sl/hnjs71X8/+YgQK7HGW5zpCK4eDBfB+9v6ftcXwCsXTsZxq5p5zlmvS
 cEiueX5SxC42nx1B8Uakz+s1rHdfIJUTxQJHFFFLCNCj3vskAUIQifDfOvKQtkK0gjJr
 snev2sDCujqpruY4JvWXM4OTZJDNNs5HjLOh48oV7cAgE+p5TFVipR9d3PYMwbcLmMXS
 Hs/w==
X-Gm-Message-State: AOJu0Yy7jdf/UD09ha59EF4PECfGaAjwdD+g50PmpTzt+vRPapSFCg6Y
 ZtqSfpBMd/FuyDaX9pZQ2iSMBgIUxhyam3s1amzFUo0aKbyv2Wl6Bb7U4mcmP5XCE0K93A10aee
 fwwLzdBYKjgHiQhSum1GtF071lxseySLCnE9gX2JMZcMHAjO7bSAAo0bok9O/JAX6C+m2FHV8ZB
 wIgbZC+eAy1S17reo63hnGBbQ3AMgkwYMZ6BI5Mk8=
X-Google-Smtp-Source: AGHT+IG0SUuaRRRGWt2fisLMaJXjOzQihzgOLLYJIYRd59zRq54mwv8UJSO4SHfO4O+u5qibT/YbGw==
X-Received: by 2002:a17:903:190:b0:1d9:a15:615d with SMTP id
 z16-20020a170903019000b001d90a15615dmr843103plg.1.1709744982503; 
 Wed, 06 Mar 2024 09:09:42 -0800 (PST)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a170902e74800b001dd091cbc4esm7230076plf.181.2024.03.06.09.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 09:09:42 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 5/5] target/riscv: Relax vector register check in RISCV gdbstub
Date: Thu,  7 Mar 2024 01:08:38 +0800
Message-ID: <20240306170855.24341-6-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306170855.24341-1-jason.chien@sifive.com>
References: <20240306170855.24341-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In current implementation, the gdbstub allows reading vector registers
only if V extension is supported. However, all vector extensions and
vector crypto extensions have the vector registers and they all depend
on Zve32x. The gdbstub should check for Zve32x instead.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index ca9b71f7bb..f30de083e9 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -323,7 +323,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
                                  32, "riscv-32bit-fpu.xml", 0);
     }
-    if (env->misa_ext & RVV) {
+    if (cpu->cfg.ext_zve32x) {
         int base_reg = cs->gdb_num_regs;
         gdb_register_coprocessor(cs, riscv_gdb_get_vector,
                                  riscv_gdb_set_vector,
-- 
2.43.2


