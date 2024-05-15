Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076FDC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79NE-0007V5-IN; Wed, 15 May 2024 03:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79NB-0007AE-NG
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:48:25 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79N8-0000Jl-Ui
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:48:25 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f10092c8c7so1966293a34.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715759301; x=1716364101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBqdliMEnz302NXVukyGkGL9Vj4A6ULArkG/4ozIHhk=;
 b=UPuJNt69txfk3//ElcALCwR1z1xR+2uJABB6yEV4VOn808hvJtSFQ8H2QPrlIZdHUK
 HSHBTtYbJPP7k+trB1kcD+TQdlQCT4mHyQJY8qXMWr11ks13VxSWz36XaTUTVdfPPKek
 Ee6LDvCtYq5ZZceCUtN0OhlQwSnZlhG7BxXh4P7HeT40aB1jzHzndNzuxseQkwV0o3AZ
 ZTRwOc2+7iOAGppD7zMDWHbaAyfMeRHdtmRaFG8R8nB6393oEIt7CR0B8LF845Ojv3Dn
 Ub5pJzX4Bmi7lJ+n3jPYm+YpNCi18WiXc+Gg83lHRTeGI3OzQ3uUN3rpponvK4iPlV0C
 v64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759301; x=1716364101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBqdliMEnz302NXVukyGkGL9Vj4A6ULArkG/4ozIHhk=;
 b=of719KcEcq3hsjZfNHk2RUyXix94+9PH8mRb9GUUcOLj5zadI+CQ/ldDwGdO7dmI5g
 KBhHXrMR1Kw4khIXEbk+zu29zlFmMumaBjpRuwSSblsJriO5aDnyTIshlquH+NbXlUlH
 c8I91RsEVF2cLqRTC5p8L9VkZYPAt6ta84mbkhrtuYSvY/O1k5HEmhHFGlI7MMmNMu0D
 Xhzass8oU6Pt9NXrm4qeoivmqL7kGKqM+rK/Snz2zApYWdznhwuTzNQ0/+vhZvmDkvNN
 quqSDu9qPQXi5r+N7Ij38JgjhGRj11pmRGZpKsF7LVd9nj+YDYIY1Depu169cuuQBUYx
 4Tcw==
X-Gm-Message-State: AOJu0Yz8Z0FPqnpJvJcfFCFAUY8FDMy6TI3qG8ur6pH7t1OKYTa0I/rn
 C9oQgxVXYNrqZoiqCP8zdnmwABrCmfzRCd4Xw70hTDiOf9GaEXrZZ+ZTS1smmXt2LEUAI0/pw09
 T69web4Uh/ZT4ZQ6sPAZgfr1D74Rf3nT985ZkX/FX82I7jyxd5P+7vDXHgxnn8MLmvSuDn3AHYh
 ArDg+FhQmV6uBFXhEfcB3Bm5OaFF7GINHLszY=
X-Google-Smtp-Source: AGHT+IHHE0Bkwlhu6ny7kOieP8CgJis1/nbAsd8Kup02DhpHOypjCBL0yQ9LoJdd4ex7x3sQY9eBNA==
X-Received: by 2002:a05:6871:891:b0:23c:3afb:eceb with SMTP id
 586e51a60fabf-24172a4d896mr23336795fac.1.1715759301109; 
 Wed, 15 May 2024 00:48:21 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm10389060b3a.162.2024.05.15.00.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:48:20 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 3/5] target/riscv: Add 'P1P13' bit in SMSTATEEN0
Date: Wed, 15 May 2024 15:53:34 +0800
Message-Id: <20240515075340.2675136-4-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075340.2675136-1-fea.wang@sifive.com>
References: <20240515075340.2675136-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=fea.wang@sifive.com; helo=mail-ot1-x335.google.com
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

Based on privilege 1.13 spec, there should be a bit56 for 'P1P13' in
SMSTATEEN0 that controls access to the hedeleg.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by:  Weiwei Li <liwei1518@gmail.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 74318a925c..28bd3fb0b4 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -315,6 +315,7 @@
 #define SMSTATEEN0_CS       (1ULL << 0)
 #define SMSTATEEN0_FCSR     (1ULL << 1)
 #define SMSTATEEN0_JVT      (1ULL << 2)
+#define SMSTATEEN0_P1P13    (1ULL << 56)
 #define SMSTATEEN0_HSCONTXT (1ULL << 57)
 #define SMSTATEEN0_IMSIC    (1ULL << 58)
 #define SMSTATEEN0_AIA      (1ULL << 59)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6b460ee0e8..bdbc8de0e2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2248,6 +2248,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
+    if (env->priv_ver >= PRIV_VERSION_1_13_0) {
+        wr_mask |= SMSTATEEN0_P1P13;
+    }
+
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -2283,6 +2287,10 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (env->priv_ver >= PRIV_VERSION_1_13_0) {
+        wr_mask |= SMSTATEEN0_P1P13;
+    }
+
     return write_mstateenh(env, csrno, wr_mask, new_val);
 }
 
-- 
2.34.1


