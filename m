Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F13F60D1875
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=RPpmUArS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtr-00057X-7L; Wed, 04 Nov 2026 14:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtl-0004cN-5l
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:53 -0500
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtj-0002dX-Aq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:52 -0500
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-3514b90bb89so2071046eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821430; x=1794426230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RYdE0Ffc0rrUlTKJNgRYuD3EifMicwHIr8Kk4+NSUFs=;
 b=RPpmUArSAW+Z3DSTokt3tQ/2QHCP2wvUsjV7ArlB3z52d7kBuybbtLnLdRa7cShN4T
 GB6h0FMLcFP3I7zmRkWCujdnLOLHL28+okc1iSd0+4MKqMgYHK6y0YedfRHxKQLyScM1
 NqJRS9W8lOaBAeM1MVXJKr8Y655z6TS0+IGvbsLBuEpIzIMCK+80RvgXDzJoTjDbxgaN
 5qo5P/lKUPGWfdyV2mq8dJT1u46w/X1uZQHyv1Wa2NAvjhnlCBIdgBaCR70w1LkmclVo
 G0doTpaHu0q5MN42emuH7b89u4WLXCele2QyDco8cmYP/cKikim6Pk/Pskoj+mDsn1xR
 MK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821430; x=1794426230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RYdE0Ffc0rrUlTKJNgRYuD3EifMicwHIr8Kk4+NSUFs=;
 b=i5dTOskshprPpMAw/ycit9qA135PRc+KfcPftidJldg3oE3k/NcgS8mQ9fsIJfp1mo
 Mw470R820KWncjcsIPc4TC0hfxAwcPGdtJDQqloRnUBnmeWbOh+t1AMlhLeJ1ebHYK9j
 w1pzV/Jmizbc8R4+ObW4M3Ql6ume3N+np4lBHiGns5CQcxo70fnQgE98Go+X76Pi0zIZ
 52TfPfDy7bcnwBcfGbd5LiTqMH7P2NBodvMb45nBWChwjJMRMVASVkM5nFlmW5xwdeDe
 q3smU96Mm28+33pfetamDx9eCoJvwrjl34xtONzkxWSiMOn0cbZfFhADW6Bfj2gmyb4V
 1owQ==
X-Gm-Message-State: APuU4Z8ChdtAKjIXUWDuaqUvB1BGkBaunAMZn+G58aOIYyCau97YWcDA
 h6ggGSeKNuRosTxueVUhTsix+fG8fZobBxJLYAZPwk5Z/ewAWn5e2ZyAfuVBGbQYUeJFtpv6MqS
 pmnsPhlJ2Mh9icLTTnpSOOqkVXpcEfH+37Uk26gURjCb7FUd5FgN7kTlQy79AawxLtwZ9yLBEtt
 tJgOktLtmjuy35h555xM64QnvStBc/rnorqo9a176IDQ==
X-Gm-Gg: AYBFou28e0jmtEWVnBFCrPsM/dNkcukVTZTyjeDhTbXWhqpN11NcFGmpm336EXNqydQ
 AAwdKxB8A8wlQiyKeGXfXFebtaqtmxi5e3pULZgkwbYq0Aiczs9sEbwESQtX39fAGkZi/uNt57z
 q51eoZUsEH9LkGHy/UWRr2yNv5DQiy5m5YyalGNQEzDKs8e3tKF1VkygJjO7Ynedm2t9foOf5Z3
 S/mccolf8gUzkWasWclQZgStCIHI6B0eZ5u6KSHu5Gbkg125W5SCzyP81vs4u70slA+K3icAZmC
 y5YwSJEwXMTLrpD2Vkfykqd//EiBEnv+Jja+g16Jl5LLLMgk2/3vGjsj690orQzaaL42emTe9AW
 tldlUBaoiGPB1m7XzLs5YpJuJGt8i9AlD+X52DWXHQMZ3G/D+Gh7V69r8coJIuRmVSgOZod/DEt
 J4Bb5hLSvlKRLVxmKk1zyB5mFrXl6kwROrOPCanZrOlJZCJ4L+v3E3DYtYbTF1Akyhypclr+DMr
 S0xWWTZ9XERVQ8e+wZZrTENd2GpoCxlDT4Ycu1WB1r1CdHOZTpR11oAN8WmMDjB6oIL2Pt1jAzq
 M9qlXJvltkPvW4oTo5VCC6fXFX7/tt3/JNxkUjLQMt1g4gKD9TEvlkOzOCy+F/FJGHfL1s+f6Z+
 WyaZa8jtmEgKCA1G8MIv4QZ20Ut2b
X-Received: by 2002:a05:7301:2a24:b0:36d:48e:82de with SMTP id
 5a478bee46e88-36d049e0895mr5102515eec.12.1793821429660; 
 Wed, 04 Nov 2026 11:43:49 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:49 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 30/38] target/riscv: Add cfg property for Zvfqwbdota8f
 extension
Date: Thu,  5 Nov 2026 03:41:45 +0800
Message-ID: <20261104194155.679241-31-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x132f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add CPU configuration property of Zvfqwbdota8f extension which depends on
the Zve32f extension per the specification.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 2 ++
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 target/riscv/tcg/vector_helper.c  | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 566e2e835ae..b4a9f2c3e30 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -236,6 +236,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfqwbdota8f, PRIV_VERSION_1_13_0,
+                                    ext_zvfqwbdota8f),
     ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfqwdota8f, PRIV_VERSION_1_13_0,
                                     ext_zvfqwdota8f),
     ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfwbdota16bf, PRIV_VERSION_1_13_0,
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 80750db1ccd..0385b58de0a 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvfqwbdota8f)
 BOOL_FIELD(ext_zvfqwdota8f)
 BOOL_FIELD(ext_zvfwbdota16bf)
 BOOL_FIELD(ext_zvfwdota16bf)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8684e4c709c..a52637f5ca9 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -726,6 +726,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfqwbdota8f && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfqwbdota8f extension depends on Zve32f extension");
+        return;
+    }
+
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
         error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
         return;
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 51170625aad..6f3b666784e 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -40,6 +40,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     target_ulong reserved = 0;
 
     if (riscv_cpu_cfg(env)->ext_zvfbfa ||
+        riscv_cpu_cfg(env)->ext_zvfqwbdota8f ||
         riscv_cpu_cfg(env)->ext_zvfqwdota8f ||
         riscv_cpu_cfg(env)->ext_zvfwbdota16bf ||
         riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
@@ -96,6 +97,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     switch (vsew) {
     case MO_8:
         ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
+                        cpu->cfg.ext_zvfqwbdota8f ||
                         cpu->cfg.ext_zvfqwdota8f ||
                         cpu->cfg.ext_zvqwbdota8i ||
                         cpu->cfg.ext_zvqwdota8i);
-- 
2.56.0


