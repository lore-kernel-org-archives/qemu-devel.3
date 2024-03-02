Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE68C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHk6-00032Q-TM; Sat, 02 Mar 2024 00:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk4-00031h-Uy
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:00 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjy-0007au-32
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:00 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5cddc5455aeso2321780a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356613; x=1709961413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqTaay3vfX0RnU8kn+fHbm8BSG9uRWmoUVyFSKJHkDQ=;
 b=nse4cjAT+V7HxyGYYUpkHV42Bk35Oy4NRdkhR+mzIH2CENBVZZVwILoi8MHDgF8lVO
 s3ScieCtn8MSieYsjboX3iXPOe9m6VgNO4el/olRPkXn5y0H9/4ZbxBhEzzI/QsaYm13
 Fom5xk6vFbpawbbzAA2xX/L+GBqYdmR6Kc3wREUlIIyrD2sw/W4+p/rHIlRtjc1wDTBf
 MbAfDSigkSYl7Wyl8nCW1x49Ofl5DYf8olECy197JwXiZUNCU01sCdAnm+45RhwuLOM9
 5SzdIzCiBDkxipSDh0OYphmal05Ltl7iv0qtj6f64i5/IhpQ0bVhgFCv3DYL0UUjUiq6
 eJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356613; x=1709961413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqTaay3vfX0RnU8kn+fHbm8BSG9uRWmoUVyFSKJHkDQ=;
 b=dzLPWB1vVh1dy4WRSI3CZZcboqWVVFVyXziVtfYkHWweuMdheK4ckxiTYOBbRTdGdD
 l42ftTAa1rXSyvx1Ui+7aZJmvsHg87IPOFDSigY1Ly0XzLpZxIUS6BdBflhGfwifByCH
 4LM+Vfgd80vFLTXRt0F+BwyyY7zdogtHgzmw+JxdPEQL1NT8YrQF/baFPQQd3yMuYpyi
 A5JEtzd/4zqGCJyZFn2Y0UoHksTB1UACI3KBv5af73n3y/K8nzMEoc1mg0w0HL7o+P+I
 0he0E/fGwdTlC6ChuuNqtyWRTRCyj5f7t094GHPe5E8MZi+IEx6CFHHuVevO6PdQNV60
 qn3g==
X-Gm-Message-State: AOJu0Yxk29FtBEiuI3AgUDDlKWpRZPDDT+TPwlebRo8XdU4uNjozxQ35
 i0kcmFiaa8BjU/QMt7fQyKh5l+sluiS4tKMvG96cH5mAZe73Vas+hDiud2R60mRDlL4qqb8zlpq
 m
X-Google-Smtp-Source: AGHT+IF3Pr1OSre258T4/tRgkOI6twc/vHz7N9uMD7a/0CRS8y8yVy/f684YV1q8WPcBTOMKEGDoMw==
X-Received: by 2002:a05:6a20:4328:b0:1a1:47ff:81f4 with SMTP id
 h40-20020a056a20432800b001a147ff81f4mr167825pzk.20.1709356612840; 
 Fri, 01 Mar 2024 21:16:52 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 30/41] target/sparc: Implement XMULX
Date: Fri,  1 Mar 2024 19:15:50 -1000
Message-Id: <20240302051601.53649-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 ++
 target/sparc/translate.c  |  4 ++++
 target/sparc/vis_helper.c | 11 +++++++++++
 target/sparc/insns.decode |  2 ++
 4 files changed, 19 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 56daf2ad01..9b642fd74b 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -130,6 +130,8 @@ DEF_HELPER_FLAGS_2(fcmpeq8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fcmpne8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fcmpule8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fcmpugt8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(xmulx, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(xmulxhi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #endif
 #undef VIS_HELPER
 #undef VIS_CMPHELPER
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2d697d2020..f8db98c32f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -91,6 +91,8 @@
 # define gen_helper_fxtoq                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_xmulx                ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_xmulxhi              ({ qemu_build_not_reached(); NULL; })
 # define MAXTL_MASK                             0
 #endif
 
@@ -5081,6 +5083,8 @@ TRANS(FPCMPULE8, VIS3B, do_rdd, a, gen_helper_fcmpule8)
 TRANS(FPCMPUGT8, VIS3B, do_rdd, a, gen_helper_fcmpugt8)
 
 TRANS(PDISTN, VIS3, do_rdd, a, gen_op_pdistn)
+TRANS(XMULX, VIS3, do_rdd, a, gen_helper_xmulx)
+TRANS(XMULXHI, VIS3, do_rdd, a, gen_helper_xmulxhi)
 
 static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 8675ac64b3..387acb3855 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "crypto/clmul.h"
 
 /* This function uses non-native bit order */
 #define GET_FIELD(X, FROM, TO)                                  \
@@ -492,3 +493,13 @@ uint64_t helper_fslas32(uint64_t src1, uint64_t src2)
 
     return r.ll;
 }
+
+uint64_t helper_xmulx(uint64_t src1, uint64_t src2)
+{
+    return int128_getlo(clmul_64(src1, src2));
+}
+
+uint64_t helper_xmulxhi(uint64_t src1, uint64_t src2)
+{
+    return int128_gethi(clmul_64(src1, src2));
+}
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0cd1cffe18..54ba329440 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -391,6 +391,8 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     ADDXCcc     10 ..... 110110 ..... 0 0001 0011 .....    @r_r_r
     UMULXHI     10 ..... 110110 ..... 0 0001 0110 .....    @r_r_r
     LZCNT       10 ..... 110110 00000 0 0001 0111 .....    @r_r2
+    XMULX       10 ..... 110110 ..... 1 0001 0101 .....    @r_r_r
+    XMULXHI     10 ..... 110110 ..... 1 0001 0110 .....    @r_r_r
 
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
-- 
2.34.1


