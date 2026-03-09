Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CC8F417EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbuv-00012u-9w; Mon, 09 Mar 2026 10:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbub-0000s0-5D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuX-0005Fx-Sf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629Dr5U54027525
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l1Wa3QP/BsqwVLqinVEWhK+P/IYu74zTONu3xGLJHlQ=; b=CbJHgUYGSH92kqhO
 5RF0YM0Ai8KrLC6qVVHi9W1WTef9LZX+3505dEHhCMrTxuJWcy/HUbiZGKMwkpWI
 TYjAzFGQIi0csaGg81dbuqWHflcQADjNXUTuXUi4zAdCmns0JwCbX1G7CKKXiMi2
 5sDsgw4A4imla53zGDGxPeDIaBjEbmK7AXH6Nm2qfNIAGmtQ/fMbtf8JEaPu3687
 5Xh1zPjw8p1Gak2H0mLMLhQjsqke5AVV4MlkQhVJKgQILKOpNfKATJ77OdyjI7ld
 /mLHnFpucxEY81d6hkCOXhJsqDvzU1eQa7kd17cgYLy4YdZh5xRUaKSZwWBUzepn
 8OmBHA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyfy06hw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2be27d4e3e5so79010588eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067723; x=1773672523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1Wa3QP/BsqwVLqinVEWhK+P/IYu74zTONu3xGLJHlQ=;
 b=jQMQK0CYovKRIo6QMpI8DJgRqRxAfTmNpDVJzAlbbwiDZ3YNszN12t7kWwgMEogYGq
 IDLwwmptGD7VT2VPpxOozNLqzwyEibOz/n3yNL8Cy+R0o/jtuwpX+HB/8SdkjorrsfBx
 X9yedEVfy3+VQtba8o8XVMrJqs9TpRNGPy8kckLIbA2ZNzLsUwGXOMHM0UfCNcHt2PPl
 gvPBvw6gm3wp5sxGKqxsaLv1rchrCDHQ1/MVxq3Sdq0Q+3kDTldlGOC1kZBlrwsNoD2/
 wPgsvAir42IlU+4jit5dFVFUZWvPf6GaaM3ZChG+/NFkHkJZ+pMPc810/j9modU3mm51
 tK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067723; x=1773672523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l1Wa3QP/BsqwVLqinVEWhK+P/IYu74zTONu3xGLJHlQ=;
 b=aIz0O9boYcb3dO0/IzDqiEFZxfTLksroAUkc2YEjrSPEGNGYsVeLGs7w+hWZAepAj1
 jtdTe+LWSKuiDFoOS/KAiZz9pAI91K5zR49tJda0mBDO91rmv/W4gGC2UT3NZQ/d91m2
 ogBe+5zj0nKvB4l8jsp9KzQI7Yc+AkHs6d4+JaPOLnaxVQBS37LZatnfaVPzAtGlgwED
 x/luAz47nypW3rJyAU23cKMmdznD+l3B1VUpFfr09VVfILVwuFPQ/Nea96gkRMVVVWIC
 nITb2E/OAUy/sSZBedHh+IT43lPi1dYi/pKGcZo8T/ineoZYMmf+LD59Y3y1w2KqfyP0
 9ROg==
X-Gm-Message-State: AOJu0YzBd3gPxGPS/MSRcMRCQISmL0Samx9xUYOG9wVd78VaOGaeUPtZ
 XqzMxXAkVIorTWaP80W3kZ896xOX05yG04QbWeMIh9gc2ivP3crzxnERE7OrKYqEkaGT97e3EFp
 QbLMp2VbDP5USFARkuTS/LK13h0xEko1XPJJ0JKBnUV8ifs4p0D4E8TGkQToss6u3FA==
X-Gm-Gg: ATEYQzwH3Mi5Mg7Ze/PMtZHefw06PLIRvo3OS/yHslwEqVVve2bpJqCqZb/BhG2FF6C
 J0ToC+Cl7JlDsEy5oX9tB8ZRyu1VGpuLim7zoWSdqcO3eboBY5TlAtnpkkn/FRYTTibqGWncVRq
 R5Sx8Fi9xv4PVx/CnbS9Kqthp8PHfDloQc1Wl3YE8U5thi1dU9GpyVPJ94fxTwEKlesugSmdF5f
 9HyCFXNklgDx7wVmRd5kP0hbKJ2/bkPIdr6GhGoanT5Q6iSOYQTOdwTFaCeVEKqXZtTXJEqtbjk
 SpA4XZp9258O2Ywt5RKCMjThMKQwXaoSFVe07TMBPuXNIyze3xGbBnJ057XzJACjUMGCw0+kKgz
 42nD8oJ4ce4hXMi+pqT9nMN8PIFaGptcLtMhFD2+M1RRpDafJzKrXUhpVgHd6EfvFj6JeOA==
X-Received: by 2002:a05:7300:1486:b0:2be:2e4c:209c with SMTP id
 5a478bee46e88-2be4e02c4f2mr4819502eec.20.1773067723110; 
 Mon, 09 Mar 2026 07:48:43 -0700 (PDT)
X-Received: by 2002:a05:7300:1486:b0:2be:2e4c:209c with SMTP id
 5a478bee46e88-2be4e02c4f2mr4819485eec.20.1773067722447; 
 Mon, 09 Mar 2026 07:48:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 14/35] target/hexagon: Add guest/sys reg writes to
 DisasContext
Date: Mon,  9 Mar 2026 07:48:01 -0700
Message-Id: <20260309144822.877695-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXxQ0iEVH4sy2y
 mGZDcJ2Gu7psnw3b8c+I0mW1bhCtrzfmm49aPtoTNjbBcMHjeiuHvvYrIR8W9IIwiDFKAqN4uPS
 UcxF5BIHVHuTMDHbjqvl8jB1IACjfD/ZLn8Ynr9xGsSufrAoRADAwf2vc4J8LDOIGscfP4rmkNU
 C6T2TLuqmMF3G52NsjoBgRn/Onu/459plrFFi0zv66COqly7QWR3VA6/VXYTeMTnYYHLeDaR3eq
 zTX/6wr2jyr/amWLDiW/T2IQM//MrYXLupSx8a6jDkXhe8i6+ZxEpaxCBrCIuHaI4ekMxTz84PU
 ow8W7exQoqcLyAUBkAGDaeIcmPtWKS6E01T+UT6k0lZJRxOU+dAc+krankYweHaw2leB3BevarB
 O+2jTjfNY45R8J8P5bcHqPwqBAwoinPcy5iDh4F6rwLJQQSR14x/6usEsc95N7aMsYDJJ0RHYGz
 ST0cYgBYsTn7/nd3jZg==
X-Authority-Analysis: v=2.4 cv=OcmVzxTY c=1 sm=1 tr=0 ts=69aeddcb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tdgd3nfel_K54e3JQaMA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: AXq1vxhkztnEEJ7Uu35JwV1d1hX04uHs
X-Proofpoint-ORIG-GUID: AXq1vxhkztnEEJ7Uu35JwV1d1hX04uHs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/translate.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 40d365f4250..7e528379db6 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -40,6 +40,14 @@ typedef struct DisasContext {
     DECLARE_BITMAP(regs_written, TOTAL_PER_THREAD_REGS);
     DECLARE_BITMAP(predicated_regs, TOTAL_PER_THREAD_REGS);
     bool implicit_usr_write;
+#ifndef CONFIG_USER_ONLY
+    int greg_log[GREG_WRITES_MAX];
+    int greg_log_idx;
+    int sreg_log[SREG_WRITES_MAX];
+    int sreg_log_idx;
+    TCGv_i32 t_sreg_new_value[NUM_SREGS];
+    TCGv_i32 greg_new_value[NUM_GREGS];
+#endif
     int preg_log[PRED_WRITES_MAX];
     int preg_log_idx;
     DECLARE_BITMAP(pregs_written, NUM_PREGS);
@@ -80,6 +88,34 @@ typedef struct DisasContext {
 
 bool is_gather_store_insn(DisasContext *ctx);
 
+#ifndef CONFIG_USER_ONLY
+static inline void ctx_log_greg_write(DisasContext *ctx, int rnum)
+{
+    assert(rnum <= HEX_GREG_G3);
+    ctx->greg_log[ctx->greg_log_idx] = rnum;
+    ctx->greg_log_idx++;
+}
+
+static inline void ctx_log_greg_write_pair(DisasContext *ctx, int rnum)
+{
+    assert(!(rnum % 2));
+    ctx_log_greg_write(ctx, rnum);
+    ctx_log_greg_write(ctx, rnum + 1);
+}
+
+static inline void ctx_log_sreg_write(DisasContext *ctx, int rnum)
+{
+    ctx->sreg_log[ctx->sreg_log_idx] = rnum;
+    ctx->sreg_log_idx++;
+}
+
+static inline void ctx_log_sreg_write_pair(DisasContext *ctx, int rnum)
+{
+    ctx_log_sreg_write(ctx, rnum);
+    ctx_log_sreg_write(ctx, rnum + 1);
+}
+#endif
+
 static inline void ctx_log_pred_write(DisasContext *ctx, int pnum)
 {
     if (!test_bit(pnum, ctx->pregs_written)) {
-- 
2.34.1


