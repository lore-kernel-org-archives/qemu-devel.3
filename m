Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C12606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WwElQyl5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UjVXl5gx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNRW-00009v-Cu; Mon, 26 Oct 2026 12:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRT-00005O-RO
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:20:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRR-0000TC-LJ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:20:59 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvwRC2707737
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Zs6RZhPdyo3pYWE/+og7gnQUB8PEStvVgCx6GiDstg=; b=WwElQyl5TS7PrFXG
 OjTaZ124NcwBjDF4Mrmj0eiJ7dl0huig/Idj2oHLZpCOe84gKMAap1flRNJ5EBuF
 JUgyTu6c4u3ZeTbwtL02lK2ZMD7neIJBu4wlY2kXB1yQ7LxzI5+0KwnLP5iaGb4H
 jrBuD22ie74WYWgwaB8QJZvUZ+pxoRPorlLYy3bAqGO8QEsQhN1IEXHt6eF8rT6s
 OZbFnhtHf7frsIIAbla47XkT/TyrN7rGryxGzJ6NDJevniUu495z/OIMllB2F/mM
 8vxqjWc4ulb61DylK95+QSg2X2uQrgpwcErAEa567V4kLjeWTI3aYVEb9fRq0bbN
 TtZV1w==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u61p40-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:20:53 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5eafa385ef0so351945e0c.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031653; x=1793636453; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Zs6RZhPdyo3pYWE/+og7gnQUB8PEStvVgCx6GiDstg=;
 b=UjVXl5gx5jpur6LetJTPDAABAPQDqoMKkba1R7EuCs/WTJlBG9Eoox7dQ70enUUSYP
 yKQaJMEBpGMA/lTF+eGGEJPN4NsijV9lrqH7u3GAmPLY6KmFiXsRwxJi8yk5t238LMNM
 n4ot1Wh25R6SqHgHKPMoDlb1REgQAvGlpOj0khXyVdL+82AwJtDbzCf40y8nUb8ZGu3P
 vPnoMh2H2VEiV+uU5GzVMtQHNEPLXxF/pumiuUoov1MCu3rWDNbXqfXx0sj51BfO/Ukr
 c2569B5yLN05IknfpaL2WxtSfGdvRBZ+RQHJZLJukK/0r3fV0PxdcyEkdeIWU6HzqteI
 gHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031653; x=1793636453;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Zs6RZhPdyo3pYWE/+og7gnQUB8PEStvVgCx6GiDstg=;
 b=dzk+PX9C/88Q8d2wpA7YeK7L7lppPg0B6b6iSMRI76ohz6oHwpiE1ZJSSIlL90t/J+
 hjGggTN7ws3XxwrQKrumhgECYfy9JUrsGPpWNUNB0PfNnHGsZkxyGiHjZgaUH6aq3e7e
 bQ/ACxPk2Zq45OtzbaeMcqto04gKghYAmWwIWetRBrw+YsC6puuKJaiLf7tZ0HE73sfC
 XXOSlK5XKGLQxumbF3IEJ1b3qZRGeMYNLrOEs+0uPU0Y8kYu82MsjZM5ZBsQ73INgOMX
 +oxsNTisVHa0RHpl82dQrqEFGyzA/mJqc2/NH6xKrOjVBU9v8kcnY7bMO7Kqpe/SOEMk
 qKTA==
X-Gm-Message-State: AFq9FYJGlhZYo79e1DflM9Mv5YhPaOoCwyyqdrW9Jp1MiZ1rcTm8SY3L
 HP0UHSg82BxfkDmiJVmIv6Y8VBqodjuAfdSwoFL/L0R8+GtcD+BEliaQoRBxF96W6DXKTZ0Gh5j
 iYqktAqzz1q/U7DybOcYtDwoV1Wb31F/438ETQUeNrAFQVElbNh/SS5tixgqT52vYEw==
X-Gm-Gg: AYBFou3/bURhvnG7QngB1Ut1dc2Uzbg2lHlVzI6ap68G7HvOMszAfYEPIqkz12OQxOs
 k9KLDk+U6S6bfMhDENgyzsHDFbbrBviQXThn5Sn6J1z4DAmp6eMGm5DSiBDOwq8C5m4/1KAThAR
 F4Zy4P8GU7pNDv0jmKy4t+98GeE8LJyOue1sffx0cPPYci0yRYk+Z4vVhPTx0+ROAGx6y1D4ETy
 1G4KhBDhCk96tFJIMkM4/BLq1laqggBObQyX99Gwu9XvWzacQDTJVWokXHHC91/C1dBJWPMeqH5
 CwMPQ/8/Zcx8mdww6/rKyRmi7hVbypemLXbg7RqPgXBHul+uFp4nXK/MKT0CmSt3C+UBNFun7Uj
 zQKG+e/UTgeUTNd/UZJ6Bs5xIAC5jEkFv65evyTOZ
X-Received: by 2002:a05:6102:14a3:b0:7cc:28a6:ee1c with SMTP id
 ada2fe7eead31-7ce5ca1e4bbmr2470046137.2.1793031652588; 
 Mon, 26 Oct 2026 09:20:52 -0700 (PDT)
X-Received: by 2002:a05:6102:14a3:b0:7cc:28a6:ee1c with SMTP id
 ada2fe7eead31-7ce5ca1e4bbmr2470023137.2.1793031652099; 
 Mon, 26 Oct 2026 09:20:52 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0cc374sm211934205e9.9.2026.10.26.09.20.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:20:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 02/14] target/mips: Decode LSA shift amount using
 decodetree function
Date: Mon, 26 Oct 2026 17:20:21 +0100
Message-ID: <20261026162034.32711-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X1jMJL_TjSAbuDfB1GwGgh6RJfogVaTC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX99jQjJHurYBn
 1Mu15XcJYbY+YZZ4X6RlCbAa3b6zoOWJ3FnfYk8ivse3fxb4zJm6sXzWUFev3xyTLcnE/r71f74
 tk+2QAkd6slk0mHuzmSNUyeaINLVpT3Qvowdk0SQ3MD+c0BIiiV+/C0sg0sFSlKyVxAkG1/mX7z
 eB9B/xMyBqDUr5ta1RKhAAtzM0HZHvX4nePmlv4t2IG49By02Jd3T6wm7JvS3PtMKfQ1l7TIXER
 sc2YVyqtdDCJioCUAixml4g6o65CmMxrsHhF1y7c2zDuMqFnudNAlWgyXuLwkz5DTlvBKApjSH9
 9V1dYEk5Xu4G+il/BxaouASiYRSv/SE6R1Bra5osrg1y8NfCsSIJ+Bm1T4OGljU2LDObUcSPMG6
 oePLOnSR+GOvTh5HaboTNidqmI1oCslkY0KGIhmPBu6emHmkTui5rFzHu0QWSOiFO6mzRzeHVcg
 7XvXY13y6K4/TNmA3XA==
X-Proofpoint-ORIG-GUID: X1jMJL_TjSAbuDfB1GwGgh6RJfogVaTC
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf7de5 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=x4_-s2iMgZ9CwUFeJM8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX+KuPoV2NouCt
 6avHYrxGjqWPs5aDSzy+0Nq6QYziwbuCQ46xG4eHr6+UbcOb5P/Y0jL9ZM7698aGyzMQyusymdd
 nv1+a60sRm0pHdz8nQAEMcrXsISpNTs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260065
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241112172022.88348-5-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Since v3:
- Rebased on top of CRC32 support
- plus_1() no longer declared inline
---
 target/mips/tcg/msa.decode       | 3 ++-
 target/mips/tcg/rel6.decode      | 5 +++--
 target/mips/tcg/msa_translate.c  | 4 ++--
 target/mips/tcg/rel6_translate.c | 9 +++++++--
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/msa.decode b/target/mips/tcg/msa.decode
index 4410e2a02e16..798e8c401aba 100644
--- a/target/mips/tcg/msa.decode
+++ b/target/mips/tcg/msa.decode
@@ -21,6 +21,7 @@
 &msa_elm_df         df  wd ws       n
 &msa_elm                wd ws
 
+%lsa_sa             6:2  !function=plus_1
 %elm_df             16:6 !function=elm_df
 %elm_n              16:6 !function=elm_n
 %bit_df             16:7 !function=bit_df
@@ -29,7 +30,7 @@
 %3r_df_h            21:1 !function=plus_1
 %3r_df_w            21:1 !function=plus_2
 
-@lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
+@lsa                ...... rs:5 rt:5 rd:5 ... .. ......     &r sa=%lsa_sa
 @ldst               ...... sa:s10 ws:5 wd:5 .... df:2       &msa_i
 @bz_v               ...... ... ..    wt:5 sa:s16            &msa_bz df=3
 @bz                 ...... ...  df:2 wt:5 sa:s16            &msa_bz
diff --git a/target/mips/tcg/rel6.decode b/target/mips/tcg/rel6.decode
index 7fbcb109b4e5..aa22a7e7b266 100644
--- a/target/mips/tcg/rel6.decode
+++ b/target/mips/tcg/rel6.decode
@@ -15,11 +15,12 @@
 #       (Document Number: MD00087-2B-MIPS64BIS-AFP-6.06)
 
 &r                  rs rt rd sa
-
 &special3_crc       rs rt c sz
 
-@lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
+%lsa_sa             6:2  !function=plus_1
+
 @crc32              ...... rs:5 rt:5 ..... c:3 sz:2 ......  &special3_crc
+@lsa                ...... rs:5 rt:5 rd:5 ... .. ......     &r sa=%lsa_sa
 
 LSA                 000000 ..... ..... ..... 000 .. 000101  @lsa
 DLSA                000000 ..... ..... ..... 000 .. 010101  @lsa
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 82b149922fa1..75cf80a20ed4 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -780,7 +780,7 @@ TRANS_DF_iv(ST, trans_msa_ldst, gen_helper_msa_st);
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
 
 static bool trans_DLSA(DisasContext *ctx, arg_r *a)
@@ -788,5 +788,5 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     if (TARGET_LONG_BITS != 64) {
         return false;
     }
-    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
+    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
diff --git a/target/mips/tcg/rel6_translate.c b/target/mips/tcg/rel6_translate.c
index 4c056621c977..ba7dc45b6354 100644
--- a/target/mips/tcg/rel6_translate.c
+++ b/target/mips/tcg/rel6_translate.c
@@ -11,6 +11,11 @@
 #include "qemu/osdep.h"
 #include "translate.h"
 
+static int plus_1(DisasContext *ctx, int x)
+{
+    return x + 1;
+}
+
 /* Include the auto-generated decoders.  */
 #include "decode-rel6.c.inc"
 
@@ -23,7 +28,7 @@ bool trans_REMOVED(DisasContext *ctx, arg_REMOVED *a)
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
 
 static bool trans_DLSA(DisasContext *ctx, arg_r *a)
@@ -31,7 +36,7 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     if (TARGET_LONG_BITS != 64) {
         return false;
     }
-    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
+    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
 
 static bool trans_CRC32(DisasContext *ctx, arg_special3_crc *a)
-- 
2.55.0


