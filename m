Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9393DC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJq-00019q-GD; Wed, 16 Sep 2026 09:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJZ-00011z-4z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:42 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJX-0000JG-CU
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:40 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b1ae736c64so718179eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563878; x=1790168678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eVb5akhAgJSlhXNrTi2U40ggtT1EL3qh8SU+BCGHO7o=;
 b=izONwQKz/cDFH6cUYAz1zpFsWOMqrurDsLMTg+p3aXcPY2kUfYm2/t4MCkog6Vd/Sy
 gov8E6uWl58ijt2MIiKnANxQqI3MSo56f/XHWZihYnztSU9wpqRPVFI3V6ikQJq3997m
 qAsiCteUP1Cl76FQCGV3muCz2+Pa68dyngKMYLmQju0IdgHXEDVYrFczyyEXQ5fD1hnM
 AMi2klsfP25kOkuVXoQtM640UuOqOTj8OTtf3trSEPCoCMso8k6Z6ftjBHVKLIonAhHH
 hA99JSHGJJ93hkHlPIvx7u8z+X97ck526BvcP5pnloPUQBOMl+LvoVYsWVWy7LsG827S
 i20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563878; x=1790168678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eVb5akhAgJSlhXNrTi2U40ggtT1EL3qh8SU+BCGHO7o=;
 b=25lLmmuDxhueWKEOOw6SfRTIECXOisyDPHl9FM/tRF6ZtCQoMR+GvcfhEZWDNiURn2
 6CH9ZCamaMZX8peLXcijzBtYhvKDK072r+igRh9qK8LpyWt7mRQqJZUBs2qTQkjadRQh
 crzo+JhTNx9rbvlLRp7eu0GsrRKZnVdtvtuR39Qrp43spHKv9sTwpI2mIs57J/7rBTlo
 HMkh7DHF5dV19neuhzGbJsv98klXg8NQqiNMGvY5+QLNFl8wznuRMq1xlZBH8JDwXZcM
 EJNOqN6rMIG59RuzOjfEy93XwahGNkWD64E7DsLju+RiE+n7MctrQeZ/j3lQEx4QSIvK
 XLaw==
X-Gm-Message-State: AFuF++nKdYLWRPghP955WzODtux6xYFwqcJkcK8KivKmWpqEpC51VpiJ
 SfFkbCbRzrZ3Tt2NO6MH1IbCYsyD25dtf/psybA6MX1nopgRg+AzntDu0bpWnZX+cWMrRWkJuWw
 nKr0UmYg=
X-Gm-Gg: AYBFou3tTVDe44dKibsrWj1AE/y3ChBug+c1PkXfoExblj/XphzI620zPXfkiBWQIr/
 0vIQdhLy/Db5oIrOwMdkLTwwyRGm6LZUERctIKKhJyVQ8sMhvausjql4mxwFb6483G7fUTbUnZa
 OBaj9tDpjnvqoM+tR6wcAsEZEOHiVJVmU+UddQie8bOi+poxQP3VPrwKngvNCAOdG9GrWDUTUTP
 ORuOfB6V27R67bstWMuEf+4ZGR7OdWBCdEiWxxeQmOsq5EYYSA4rGRAFy8JMffu7XYUiwZwTRSs
 i99spI8UPuYEYQ3QAxTEiyaiHwiKytsSo0R+0tdEv7Jf6npyZvoAZ4N86DgQKqMxmlfdRl5iBXT
 7egFUQBDIayJSRLf9Skr1TYMKU0InpPlI1slxvbrhAgrSVVvLJOT6FBvgNfOIGXSwvq4wm+ooxG
 hKiWlfBj2o1seKQ8va5mzI9HXQrpIoMDMmBmUhB4DlAB7imsrIPKPAuoTNuzKwakPwWx2mDyfF5
 fhOWZc=
X-Received: by 2002:a05:6820:2d0b:b0:6bf:70ee:7e85 with SMTP id
 006d021491bc7-6c7d0ee2fcdmr2268770eaf.27.1789563877960; 
 Wed, 16 Sep 2026 06:04:37 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/92] tcg: Generic expansion of tcg_gen_or_*
Date: Wed, 16 Sep 2026 03:02:51 -1000
Message-ID: <20260916130409.3382710-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 80ee29ee4d3..4d61eaba122 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -316,7 +315,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a2ae864ac17..513505e35fa 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
+DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ad7a70b575f..0b7fe14c7a9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -438,6 +438,11 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -489,11 +494,6 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_or, ret, arg1, arg2);
-}
-
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
-}
-
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
-- 
2.53.0


