Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217CEC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlx9-0005e4-8X; Thu, 27 Jun 2024 06:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlx4-0005Np-E5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:04 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwz-0001gs-Uu
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:01 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-706627ff48dso4166230b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482515; x=1720087315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aUCnalnUbISmCX7rnd1hepHfDNLqfkxy2lbhGVkz3Q=;
 b=QBw05HWo76t7Mcq4WaakuBCVs2IMnNTG+50nnqaqY0XH4aKHnkz1gO2VHQzWXNzsm9
 2fy6EnsFj3Ro8tnM4MxBzh6l5rXjn15MaSC+V+51uBbH648XTrkCa3JoyVve4bG2dEdI
 1ZMs13m+720/JvQqc2W+RSsuEkTP5e29fVoZdby9gvl9x8suqN3IDK1WRZsSVPdoz9fH
 EeZ+0EcE8XaxEmcAo7ncfPUXnktw3TopmK6ZmtLgD3bPLG/ZnyHZsNE+5dcP+PHqP17f
 K+lhiNj8SmTuYYZ2kAy+00/sO/ynj9v0SIw8qmC//GKtxPKoonu0n2LS3jRlW3U6GErs
 yRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482515; x=1720087315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9aUCnalnUbISmCX7rnd1hepHfDNLqfkxy2lbhGVkz3Q=;
 b=JrK4CrssR0YHx/Vab+u6/1NFpp0X8IpFYMxTa1gxHmjvS9gLqOn8hfcjjmgOxEwovY
 a+A//ykbPzvWVP0DveUxK8VNLI8yu/j3Rr0mZaeMJaKhv2pBl70uCHSCF4kvSsSDYqS7
 fCYwceOc6vyjlJz3Yc6R8B7SalVrzu50s219vCqwsmF2lEvCzTT5DFzccyBFa7QTJpA0
 EqyW7XdglHBWJrEcQYsrhAW9tIu9aQE3q8mk7FLewlLIWg+6lE2mmAca+yX1jKP0DxDU
 UAkm5y5+3HG9cAMJEJTmXkzYoftqyMp61NrhEousHzsSplOZauHei9M7rdyun7V3Dqc3
 YJ7Q==
X-Gm-Message-State: AOJu0YxoxejxQC5Yn1Hh6ANDR/qE4GX6xBLXO5kqyEOPIRoD3xk5q6T1
 ODDl8zqYB4b5QbHTtA47C14rNYaTUXQIhhenVYiKU/o8MaVWEIopaBTOxJQH
X-Google-Smtp-Source: AGHT+IGInls2vv1jQdzTlwg9kn3sxblXT56o/xLZlxbKYxUsJWCMiMOQYlfHt2Kbjq2JsuOaAAOOKg==
X-Received: by 2002:aa7:9d11:0:b0:706:6525:611f with SMTP id
 d2e1a72fcca58-70674751f13mr14066320b3a.31.1719482515558; 
 Thu, 27 Jun 2024 03:01:55 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:55 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/32] target/riscv: Define macros and variables for ss1p13
Date: Thu, 27 Jun 2024 20:00:37 +1000
Message-ID: <20240627100053.150937-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Fea.Wang" <fea.wang@sifive.com>

Add macros and variables for RISC-V privilege 1.13 support.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Weiwei Li <liwei1518@gmail.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240606135454.119186-3-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     | 4 +++-
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b4c9e13774..90b8f1b08f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -96,12 +96,14 @@ extern RISCVCPUProfile *riscv_profiles[];
 #define PRIV_VER_1_10_0_STR "v1.10.0"
 #define PRIV_VER_1_11_0_STR "v1.11.0"
 #define PRIV_VER_1_12_0_STR "v1.12.0"
+#define PRIV_VER_1_13_0_STR "v1.13.0"
 enum {
     PRIV_VERSION_1_10_0 = 0,
     PRIV_VERSION_1_11_0,
     PRIV_VERSION_1_12_0,
+    PRIV_VERSION_1_13_0,
 
-    PRIV_VERSION_LATEST = PRIV_VERSION_1_12_0,
+    PRIV_VERSION_LATEST = PRIV_VERSION_1_13_0,
 };
 
 #define VEXT_VERSION_1_00_0 0x00010000
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e1e4f32698..fb7eebde52 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -136,6 +136,7 @@ struct RISCVCPUConfig {
      * TCG always implement/can't be user disabled,
      * based on spec version.
      */
+    bool has_priv_1_13;
     bool has_priv_1_12;
     bool has_priv_1_11;
 
-- 
2.45.2


