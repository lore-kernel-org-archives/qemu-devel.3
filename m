Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96595606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WSosxVMG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWf-00073x-SQ; Sun, 25 Oct 2026 03:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW3-0006By-DN
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:39 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVz-0003gt-VX
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:37 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so319689f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912774; x=1793517574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KQ+Ui1uX6+IzPsAa1F3FSF/Y5f9s+iKidopbfsOrAuM=;
 b=WSosxVMG/xHuGUPDSgx89zc8yjy7vT3sbezcJciYyYvSPUJ4GYtEpN4GW/OsCyxADj
 VUPiXds1C384irosbw04HaTRr2WcSukCYZlgn++G88ROffZDi1I/7tNYnCqW1sWYWwVS
 FSRXUEPGaanm+PrVCV8bnpE5xQTnoDNLvJ352dlr6fmonm9xsq1EsEP5WIMo/pzetMgH
 20/BohU9TJ4WPE41r6/QbINqyv1XmcygoPuvYPbhmGPfiz7GlNj3Po3kNk4xZXJEnOkD
 0hTS6I7RZhFgkv6kIXJ/iMee8MwhjS7HI3fv9LEx76OKVbzV9fciwkQdxDiB4Xv/h11p
 Tg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912774; x=1793517574;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KQ+Ui1uX6+IzPsAa1F3FSF/Y5f9s+iKidopbfsOrAuM=;
 b=nUm7j7ms2/mjpcE/Rwz2sk6sejUNjNlyQcWpWkaMYsmOTMnFfJswG5m6grTjoloUfr
 tIDC6toDuEpHw11VbMuc8AMYJRUfbaXhv5fND3se17GZ/ocYgxiMTjsQ97TjFBRN+3qN
 44LD2VcGs/Girl2B68HBKgPvj2PtL9Q1ZDgIofRGi/IgxoJuXZd+VwDX1C84WsxcvBTL
 y5i8D1g1dGe6sLeTV/KJs+ci5EvA67azhSLSWW+GSIn/CJEYfgKzFEe7iiyeNRvEEcXM
 VtuHKzRPtr5UuVfOVjy9pGhIZm9c5SUMuAM2YLIMN4fV4qOvKoZywYUmcmuVukars+DM
 OL3g==
X-Gm-Message-State: AFq9FYJqfD40wJww/OC2FZljNdyGw/GqDVfVN7e8uOCE35nESTnVjYSv
 p2ZNa+gVU2rs0tw4NIPTowTeJPh7noUVMJmCKhX0QTLMkhRNu5LMFrwjnMSROyncwKr0LTHWboN
 aZBxrBlE=
X-Gm-Gg: AYBFou1tcPquw0SGH4OFGP1GLvJd91phcC/+IAdWub43tMZZPzmwBrpf3Xbs4ddLzFC
 MOWeQ7EPV5JOR0ROnpZHa7qJ0cDolqWegYCShlhD1nb+zpiQsOm+XafYuOxjD03riUlckvSGtKH
 mn/1BISlGdsG8YB4GSZAtlWD6U3nx+PMlt4SjxMbyPBZZjRmLjoBYR4E0WdiQSO2L+3i994xmwd
 oGDtTbO6vdnU8WjdqQZsJ4OhJu9LEZ3gt05SxBcSM/lx4yPZa30SJTDd+ygzy6/Yj3LUuLqYxGh
 sOOR5zQJxGFJNSQxMUIA4Tb4Ut0CibcXQCpM/tSW+y0TPF8se95VTwvnCJvZfc0Dvgn7wM2fpCn
 QYnpxJUisc/5Mp8e06zFuX47e12Ja4w0RnWfvKMtA/dGWtnWKsgTJAW6m/SHkz2ZAQoG5J/wzFQ
 GwcjPODNMKzDuu7WhyQgYRmJKikPD6YvBfasT0u3R1j9Rn5bt8Btut+kzbDYKMGikUEo8wwj22p
 MXHBKxsBFVTLqlYxRVUpNGip1JpI5Yz9ZOe4acU/915jyoh8aWx49xlag==
X-Received: by 2002:a05:6000:a90:b0:48e:349c:af4a with SMTP id
 ffacd0b85a97d-48e3eb9a2a3mr4270119f8f.50.1792912774523; 
 Sun, 25 Oct 2026 00:19:34 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 013/100] tcg: Generic expansion of tcg_gen_subi_*
Date: Sun, 25 Oct 2026 08:17:48 +0100
Message-ID: <20261025071915.1123867-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e2e8c66d01..372be70504 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -124,7 +124,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -225,7 +224,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* 64 bit ops */
 
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 51d5ec6e06..55249c4dd6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,3 +7,4 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(sub, TCGV, TCGV, TCGV)
+DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 563c3bb038..4239219279 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -399,6 +399,11 @@ void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
 }
 
+void tcg_gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_gen_addi(type, dst, src1, -src2);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
@@ -410,11 +415,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_addi_i32(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
@@ -1537,11 +1537,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_addi_i64(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-- 
2.53.0


