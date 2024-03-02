Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151ABC54E49
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjh-0002Td-9Q; Sat, 02 Mar 2024 00:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHje-0002T0-PN
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:34 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjc-0007WQ-V4
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:34 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e5a50d91b4so2350560b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356591; x=1709961391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPAeEx8+OxTe6Jw89kVULRnihVdAWVU7ziAjkLxIIcU=;
 b=Rewhh8jATkwe3MmbhIAEZeGwUG+QYxDULpq7S1SoXR1QX7HSJgKprkG6IJ4ioGI6Mc
 DbEoNY0fdqUcwg3LncyJ9Y4TMItbpHasounK9yon0ptKU0V43QNkYg4ApgQSA5s71Fvl
 Pi0xF05ii3nHWjX7dKFBGk9SPOo7uxA5MI/Q/ZO79V0WTPG7Bk+F3YELCLG36Fg7CRpI
 ZkX/eHQmNO3NQofb9VGSWv8w5NEjFQ7lNwA461g6+zY8qY1Eu8UkplO1FilIGO8fSAXo
 TTAIjlBLrjRUQT9pdIe11ttU3ZbLAqizahabKtXF8W1oB2dgaQjlOmLlr54GzrDjS34S
 RFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356591; x=1709961391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DPAeEx8+OxTe6Jw89kVULRnihVdAWVU7ziAjkLxIIcU=;
 b=So+6M52zx2IizpPruyau8zZE36OgqkJOYCVYlZ183JkYuAt92gFOyNsz5OcUf2ORq3
 PgW0E2/k226HYsWvc4Gn+l4Br5COfGa43AFkt+bOmQGXz71ZOwrPkWrb/VrlXTSqcfJS
 9gvIz6ZE660axWezx5HM5i2EU7EpDMJO57Ol+agsG8H99I2WhtGInIKsnSA9RrIJSaze
 v8Ajw2jPPQRmUQslbnSIiyTkrNUM8Ne5Q+OGDC5dN9XuLb7n1JSuH8TybrywzEpWPtNC
 gpe8jhEdYf6EuE/5EijSh17xGkCPDT2ABBhyq8eH6mSzGKLOPFv6SPoQcM7QSyKCN8Su
 2/iA==
X-Gm-Message-State: AOJu0YxFVUgwHPXsqDbSpQrwxojpVaCTOsmN11tmg7J5js9FTWFLIFqy
 NRuTcaBqXOkgtgXwJ3lf8GDukmh5D4+Zt+vkJ0Rik0nax5g0/9jqs/yvifPnvO3Ct6HBXxA04OZ
 m
X-Google-Smtp-Source: AGHT+IH4/LvON+qaBt8P/yFglfCt75hTAgv4Il8nQKqV2schSUz6MugNF+VJhRg/sl778QPNwb8MDg==
X-Received: by 2002:a05:6a20:7d84:b0:1a0:ef1e:a658 with SMTP id
 v4-20020a056a207d8400b001a0ef1ea658mr3780731pzj.11.1709356591535; 
 Fri, 01 Mar 2024 21:16:31 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 15/41] target/sparc: Implement CMASK instructions
Date: Fri,  1 Mar 2024 19:15:35 -1000
Message-Id: <20240302051601.53649-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 target/sparc/helper.h     |  3 +++
 target/sparc/translate.c  | 13 +++++++++++++
 target/sparc/vis_helper.c | 38 ++++++++++++++++++++++++++++++++++++++
 target/sparc/insns.decode |  4 ++++
 4 files changed, 58 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 63ae398841..9cd9a81f03 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -104,6 +104,9 @@ DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
 DEF_HELPER_FLAGS_3(fpack32, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fpackfix, TCG_CALL_NO_RWG_SE, i32, i64, i64)
 DEF_HELPER_FLAGS_3(bshuffle, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_2(cmask8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(cmask16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(cmask32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #define VIS_CMPHELPER(name)                                              \
     DEF_HELPER_FLAGS_2(f##name##16, TCG_CALL_NO_RWG_SE,      \
                        i64, i64, i64)                                    \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0b6d92d0a8..fd85fd3e97 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -62,6 +62,9 @@
 # define gen_helper_write_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_wrpil(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrpstate(E, S)              qemu_build_not_reached()
+# define gen_helper_cmask8               ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_cmask16              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_cmask32              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq32             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpgt16             ({ qemu_build_not_reached(); NULL; })
@@ -3729,6 +3732,16 @@ static void gen_op_bmask(TCGv dst, TCGv s1, TCGv s2)
 
 TRANS(BMASK, VIS2, do_rrr, a, gen_op_bmask)
 
+static bool do_cmask(DisasContext *dc, int rs2, void (*func)(TCGv, TCGv, TCGv))
+{
+    func(cpu_gsr, cpu_gsr, gen_load_gpr(dc, rs2));
+    return true;
+}
+
+TRANS(CMASK8, VIS3, do_cmask, a->rs2, gen_helper_cmask8)
+TRANS(CMASK16, VIS3, do_cmask, a->rs2, gen_helper_cmask16)
+TRANS(CMASK32, VIS3, do_cmask, a->rs2, gen_helper_cmask32)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index e15c6bb34e..0278caa25d 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -334,3 +334,41 @@ uint64_t helper_bshuffle(uint64_t gsr, uint64_t src1, uint64_t src2)
 
     return r.ll;
 }
+
+uint64_t helper_cmask8(uint64_t gsr, uint64_t src)
+{
+    uint32_t mask = 0;
+
+    mask |= (src & 0x01 ? 0x00000007 : 0x0000000f);
+    mask |= (src & 0x02 ? 0x00000060 : 0x000000e0);
+    mask |= (src & 0x04 ? 0x00000500 : 0x00000d00);
+    mask |= (src & 0x08 ? 0x00004000 : 0x0000c000);
+    mask |= (src & 0x10 ? 0x00030000 : 0x000b0000);
+    mask |= (src & 0x20 ? 0x00200000 : 0x00a00000);
+    mask |= (src & 0x40 ? 0x01000000 : 0x09000000);
+    mask |= (src & 0x80 ? 0x00000000 : 0x80000000);
+
+    return deposit64(gsr, 32, 32, mask);
+}
+
+uint64_t helper_cmask16(uint64_t gsr, uint64_t src)
+{
+    uint32_t mask = 0;
+
+    mask |= (src & 0x1 ? 0x00000067 : 0x000000ef);
+    mask |= (src & 0x2 ? 0x00004500 : 0x0000cd00);
+    mask |= (src & 0x4 ? 0x00230000 : 0x00ab0000);
+    mask |= (src & 0x8 ? 0x01000000 : 0x89000000);
+
+    return deposit64(gsr, 32, 32, mask);
+}
+
+uint64_t helper_cmask32(uint64_t gsr, uint64_t src)
+{
+    uint32_t mask = 0;
+
+    mask |= (src & 0x1 ? 0x00004567 : 0x0000cdef);
+    mask |= (src & 0x2 ? 0x01230000 : 0x89ab0000);
+
+    return deposit64(gsr, 32, 32, mask);
+}
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 07796b8fe2..8f298ca675 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -384,6 +384,10 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
 
     BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
 
+    CMASK8      10 00000 110110 00000 0 0001 1011 rs2:5
+    CMASK16     10 00000 110110 00000 0 0001 1101 rs2:5
+    CMASK32     10 00000 110110 00000 0 0001 1111 rs2:5
+
     FPCMPLE16   10 ..... 110110 ..... 0 0010 0000 .....    @r_d_d
     FPCMPNE16   10 ..... 110110 ..... 0 0010 0010 .....    @r_d_d
     FPCMPGT16   10 ..... 110110 ..... 0 0010 1000 .....    @r_d_d
-- 
2.34.1


