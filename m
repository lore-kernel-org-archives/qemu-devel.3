Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9727606A331
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sdkhv+L9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXDU-0001dB-5z; Wed, 21 Oct 2026 10:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXCw-0001AO-RG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:26 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXCu-00026p-G4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:22 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso607443f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592538; x=1793197338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GkRggKwLLJ+j+cFoIEkA+3aK46zR60aXy39uFgfLpes=;
 b=sdkhv+L9PcUAT1j3jrAl/E1lg8BDCbsIzEBqjme9cur7VPW8/sh0pAvnU92glqgu+j
 GSUOdqSju74hd5j3P6gBKlNxxyZrGkPXCiitSwkihpghWiYgZv5PRl4ictuams4EO/T1
 fn45O9+r1COcthWvTOW7HngRmJpG960pKKvMsbgjMJHWsOlIMtqI7gamaXcsilGATYof
 Qt/i96nFkxfcohZ/fa5juhqC2QkAlwoP4gs0gUMACsTJZ3rrS0h0dCYMTG9oWRiWhkZf
 t3gCxveBD9Aj/96IHhHL3kzdwsizxBAlAq9oHb+bUPFXwlO2ZQcDg/bl5u1utf3tdShq
 R8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592538; x=1793197338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GkRggKwLLJ+j+cFoIEkA+3aK46zR60aXy39uFgfLpes=;
 b=Bz3RRCAkptUILbVl0M7WWkKfIUZA7vAUj5mfClIFxBb/BFXd+z1oxsDsDFNiSgfako
 7FbvHPq9+MVspoDJaGsthfElvIQAZT+o9msM0Z+jjwj2i6VABtJ4Euz39Q5S9dw6RQpV
 wa3T/xbPlpNRBL8jA0e0OzB2EjqdMSWXmSShsEvslvjXu9CyV49rzuq7xKy1XqS9whfY
 DylH7PqmQ/3eChj5NSLtfDQvPP0F2OiLenEuayLrVIzbF3WxMRjdg61FBw7w/jHAkBWy
 BLwJyWuweVRNV3DnCYs85RpdrYHQ1fmxhzTlXWcU/G+Tk4glkQElisMsd9KrYf+t3xOM
 BP4g==
X-Gm-Message-State: AFq9FYLVy7CLPL1pcX5o0vVDN9kRg6SD+pAajuatiA31p6iSutnpgIZ5
 S00crvddfpNGxl9YcaTT4vpAJjqDhQd33zPjuptbDAkIiKDgzT6paB1uGMLhFNBpjQw5rw6cDRV
 m0wf0vZc=
X-Gm-Gg: AYBFou0Pztbh/TDD9HqWesw89S1j2TDBwwBN52qdi5K1j5nLXgqwaD+UQJqbVGquahc
 ekVdbNafDZpmgHyZ+gc9z1yz1JPl5I6NhNt9+QpuoAz6loqWsz1kZtgJJJ2A67FMW8Ky45781O3
 tu1Eu8ZTTx1QizYB97gPJiP+n+D05SiINDRVVKyyokO0NVFei8xkc8KRmitLWyJkC58ypm3mUIw
 VeSKjdRT1tPaXgYIcGasR4LZevx36aAZuHdK9F6g0U+sMN6W4R72ZXbALR75yOsJDunnYS3DYZH
 UIR/PSTn4OCeDPW4UO+1j0sJL91LPEzL0UDcWi3acbCBilAXwzPb9froX+vVVFfrP8kK2OJOOCo
 SA+ywsh5GB1bSMppIOSNuQ+in0Hc6T9RLRI8yaayuxKyT6Bu8tFoR9xJjQ1h01QnTIC1I6tbd5F
 WwlJ2aH5Lkc+4JRTR0VzZpVUl4sXd+vBT0jJpbe9LAC+y1wWSDtg2Qp4f86TbQdri0lllbdvcEw
 w3NtG655J44xKxp1fjUsQk0q7WGQfMmIWhzVJIk8oYZ18Czu7LJlXg7W+MvR0gfbgztY90a95Fe
 KVTwBKh6M7s9VVttpGpUav4VhtA=
X-Received: by 2002:a05:600d:8652:10b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-4a1fdd26fe8mr34722195e9.21.1792592538273; 
 Wed, 21 Oct 2026 07:22:18 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 040/100] tcg: Generic expansion of tcg_gen_orc_*
Date: Wed, 21 Oct 2026 16:15:52 +0200
Message-ID: <20261021141652.363109-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f959f82e08..e62459b5f0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
@@ -197,7 +196,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7d94e0cdfe..fa33d41e3d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -20,6 +20,7 @@ DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
+DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1ec1cc1e97..8fb04d3c6e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -526,6 +526,18 @@ void tcg_gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_orc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_orc, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_orc, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_not(type, tmp, src2);
+        tcg_gen_or(type, dst, src1, tmp);
+    }
+}
+
 void tcg_gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rems, type, 0)) {
@@ -705,18 +717,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_not_i32(t0, arg2);
-        tcg_gen_or_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    }
-}
-
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
@@ -1722,18 +1722,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_not_i64(t0, arg2);
-        tcg_gen_or_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-- 
2.53.0


