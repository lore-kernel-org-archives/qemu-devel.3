Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199DFC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 17:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP40R-0003N5-02; Wed, 03 Jul 2024 13:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP40A-0003Iw-Hf
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:42 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP400-0005LJ-LS
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:38 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c983d8bdc7so496334a91.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720028551; x=1720633351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=De3e0JkeF4KrU8mLyYHH4oWICuiNeCJT2yMY2MkLLPg=;
 b=lI0wgVBbdL/OkbCQcICAWcRfrbJ7YWtCZHPrcQ/j6lPob9O5sunqiZpttDePhRiGRl
 aowGQ3837CC1oKgXl9hediY795a8xOgd8lWTQMHbMl5DL+TOejFDiUS2ZphUiRN/FO4b
 JVtYmp3RN5oKAHLg7XIXc36VRqZHuCj+3RuzN6XziqQ4zFR9uNvcWPBsrHTO7WATiDLC
 GfLmUtEjm66MfcAQxnXa1JBToxN1MJZAUcGhalp2cna3ORwsKr6XveoF84WXUAsZP6rL
 DV1duOPnRbLVBUZaRsdbV3MVTbwpUk76+AqLVFw9TV5gW87V4zPzYH2q34rkoJu2OesS
 DCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720028551; x=1720633351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=De3e0JkeF4KrU8mLyYHH4oWICuiNeCJT2yMY2MkLLPg=;
 b=LVoo44MGadxGTd0kvCEUPc4rqtWP1osafdUR1MPjexqCLxpqe5bbu+hKH8GN3dI8Y0
 SmYWGaRDL+Eks6Gtj+F9AgKTQBAA1cEFoaIku47cuDTGcJARJXTVonn2Kx9OPuYZN8T9
 9J6tPsqiH4tfbZFg4WS/uvCEHOum6Kg5LwlJkyYlH1TcZiFOr1NuWKzqkulT6s6TIMfy
 Ww4ZJ+qabP+aOp/0LeJTwyT+Sy3rWE6LPFTAu1OSYM3yuJCAbnf1kgqYGB/6stNcsmM8
 y/N4n7N0/Or9QGD8ltMyFZE2+M+qVSde0aqLQxfz1USwSKkx55nIhDftAT5SWVDzWze4
 +djw==
X-Gm-Message-State: AOJu0YwmFCTJ2nucvKVPPXdMPYwBezpcPkqRDoqSq8a/nIqQzLQnvfnd
 l9Nwcip8Yw/nwlcGifN9Wize+MX+BJihzEpI8F9Tae8KYlnozaLaH1B3Ymo8+C8kAPtg+HlPB1h
 B
X-Google-Smtp-Source: AGHT+IFAzLW0FTyy1OFK0j6qIrp2qOU7JkCx9E3tvEwgoZbw5vq5GZnDQ4rlx6rq5X6FA4mZa8Fxyw==
X-Received: by 2002:a17:90a:4e4f:b0:2c9:75a4:cc71 with SMTP id
 98e67ed59e1d1-2c975a4cf19mr2066075a91.32.1720028550686; 
 Wed, 03 Jul 2024 10:42:30 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7d7bsm11070030a91.47.2024.07.03.10.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 10:42:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>
Subject: [PULL 3/7] util/cpuinfo-aarch64: Add OpenBSD support
Date: Wed,  3 Jul 2024 10:42:22 -0700
Message-Id: <20240703174226.2117169-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703174226.2117169-1-richard.henderson@linaro.org>
References: <20240703174226.2117169-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Brad Smith <brad@comstyle.com>

Signed-off-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <ZneEh51XKhxgZKpp@humpty.home.comstyle.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/cpuinfo-aarch64.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 4c8a005715..8ca775a14b 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -20,6 +20,12 @@
 #ifdef CONFIG_DARWIN
 # include <sys/sysctl.h>
 #endif
+#ifdef __OpenBSD__
+# include <machine/armreg.h>
+# include <machine/cpu.h>
+# include <sys/types.h>
+# include <sys/sysctl.h>
+#endif
 
 unsigned cpuinfo;
 
@@ -72,6 +78,36 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     info |= sysctl_for_bool("hw.optional.arm.FEAT_PMULL") * CPUINFO_PMULL;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
 #endif
+#ifdef __OpenBSD__
+    int mib[2];
+    uint64_t isar0;
+    uint64_t pfr1;
+    size_t len;
+
+    mib[0] = CTL_MACHDEP;
+    mib[1] = CPU_ID_AA64ISAR0;
+    len = sizeof(isar0);
+    if (sysctl(mib, 2, &isar0, &len, NULL, 0) != -1) {
+        if (ID_AA64ISAR0_ATOMIC(isar0) >= ID_AA64ISAR0_ATOMIC_IMPL) {
+            info |= CPUINFO_LSE;
+        }
+        if (ID_AA64ISAR0_AES(isar0) >= ID_AA64ISAR0_AES_BASE) {
+            info |= CPUINFO_AES;
+        }
+        if (ID_AA64ISAR0_AES(isar0) >= ID_AA64ISAR0_AES_PMULL) {
+            info |= CPUINFO_PMULL;
+        }
+    }
+
+    mib[0] = CTL_MACHDEP;
+    mib[1] = CPU_ID_AA64PFR1;
+    len = sizeof(pfr1);
+    if (sysctl(mib, 2, &pfr1, &len, NULL, 0) != -1) {
+        if (ID_AA64PFR1_BT(pfr1) >= ID_AA64PFR1_BT_IMPL) {
+            info |= CPUINFO_BTI;
+        }
+    }
+#endif
 
     cpuinfo = info;
     return info;
-- 
2.34.1


