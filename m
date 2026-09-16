Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFFFC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJS-00010b-G4; Wed, 16 Sep 2026 09:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJJ-0000zh-Cq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:25 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJH-0000HA-Rv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:25 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466ccdd76a9so854392fac.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563862; x=1790168662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EyvfVIpbqiYFMjTw3EigaFciwRRnh2+tfSMPM9zFtlc=;
 b=xGFQrsI9sOQg3QFVzWSxy2GcnwejIPrISkQceKqTopxKdwcFplTeWMj6Zew6L3uct3
 QtCN8EOqgSkzf7qLIAFoDluTeilIHsOn32q5THBsQt0syLo3y3ke0kRVuF6ySlxZMlJ1
 WImlDkZ/OYiy+I12c/ZhVqqhbYsiGAYxeVTpWJqgCZX33PqFJqIywCd43yjY2IERr6Kc
 0k/Mj7AwqxXheeseyn6Iqhjng9OGivk14GI7XMMc0jojEYA4nX2QKJs9R93Ie1xGrnTQ
 08dbXM6q897FP5sgqrDsooopgMovY6mIwJD8sQvOK35ZavmWKSnXRS2emKHrgUsHkKI1
 DPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563862; x=1790168662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EyvfVIpbqiYFMjTw3EigaFciwRRnh2+tfSMPM9zFtlc=;
 b=ab5K/lP7a1PAMkUNJgS9m5VkMlYp1yhmgepAOKnTmduC/Id3YSstQ4VC90Xsc0upHG
 F4y1C82asilJ57TeLXzeJK9W+sdKrhBFdNihUS4QRrHyiyEYOCL/G00mkL9FtmiLPd0y
 i40b/Q1hPWiK6QHPd/J0ey2DyLBhAkpMvqwlDHicvodZfShLA3AeYFUAVAbVJIYW1meN
 OMMBkmMJXFQvv7kXrZ8kpPkk5jcJ73TuLagMY8atDTHMdNHl/Q5R/JceALbaGM85zSF6
 n8casJUgV31heCCaT+mx2r+/hFE+V2kGxBKa9IuksOr/ffONpPPQporHZpNJ6yoJO1Cb
 6j5Q==
X-Gm-Message-State: AFuF++mHcQb3f4XCWlDB9Ceh18Gw42mRpUEIxQTD3Y41XQ5tm/KtWZ8E
 Hs3ihUyo1+YZJd6kPzbEONgQHzii9gu/lIyvNjYqpmMqtY9xy283zwsJ3K/1yVmtjb8xvyuWu3r
 uAUdcPqY=
X-Gm-Gg: AYBFou0ZnUWHfQlW7cPK+FEJGSi9FLRnrC0NU9UTKN4AS/EeeOrizJodHVF2hSkmxcT
 xjixX3iQ1No2y+/TuqEeyrusrPKITprakE8+//1Ahe2Cnop9JjvzMoXDKypbIGbJwhHLv1puev2
 Wi4AWzXszl3d+vPOUt0iRxIAdHn9Soxobi1m5K9jFyfuuCSZoFNv+N6gjyVTjPIkaBmhUf41NIX
 b63O7Qej9fpr4Qhmxp1cHGay0ELTnQGVtUntnX38LEGDOmAPTkMucNjbGKxP3WDALVXXFreGHud
 EPzsVJVg07Y3d3uBE0+YgKCoHI5lCvvtRALnopBqSykaqErAITnml8MCGOIjvFNdCgsDS5fErSO
 bAdQDOSp92rKUBb/jPhviIMTcgl1lEBsGb1Z0ssLEVrECURvHY+qjrMb7zxWd9mKIy4hJRrIW6o
 2GvuW6NcbVUIjhjhyqmyO5ccvKJCOiXF9peLEtdEdgWUxzbLqRzv9fn21d05g/GJxNo7dohe8jR
 dfRUjM=
X-Received: by 2002:a05:6820:1799:b0:6c7:af50:b2f6 with SMTP id
 006d021491bc7-6c7d4ef0189mr2303590eaf.65.1789563862252; 
 Wed, 16 Sep 2026 06:04:22 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/92] tcg: Use QEMU_*_NONULL with all tcg_gen_*_ptr
Date: Wed, 16 Sep 2026 03:02:40 -1000
Message-ID: <20260916130409.3382710-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa2-x10.google.com
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
 include/tcg/tcg-op-common.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1e826b62574..888f00d5f24 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -497,22 +497,22 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 
 /* Host pointer ops */
 
-TCGv_ptr tcg_constant_ptr_int(intptr_t x);
+QEMU_RET_NONNULL TCGv_ptr tcg_constant_ptr_int(intptr_t x);
 #define tcg_constant_ptr(X)  tcg_constant_ptr_int((intptr_t)(X))
 
-void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
-void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
+QEMU_ARG_NONNULL void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
+QEMU_ARG_NONNULL void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
 
-void tcg_gen_discard_ptr(TCGv_ptr a);
-void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
-void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
-void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
-void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
-void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
-                         intptr_t b, TCGLabel *label);
-void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a);
-void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a);
-void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a);
-void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a);
+QEMU_ARG_NONNULL void tcg_gen_discard_ptr(TCGv_ptr a);
+QEMU_ARG_NONNULL void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
+QEMU_ARG_NONNULL void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
+QEMU_ARG_NONNULL void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
+QEMU_ARG_NONNULL void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
+QEMU_ARG_NONNULL void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
+                                          intptr_t b, TCGLabel *label);
+QEMU_ARG_NONNULL void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a);
+QEMU_ARG_NONNULL void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a);
+QEMU_ARG_NONNULL void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a);
+QEMU_ARG_NONNULL void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a);
 
 #endif /* TCG_TCG_OP_COMMON_H */
-- 
2.53.0


