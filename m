Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02F8CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzo-0006oD-Ko; Mon, 01 Sep 2025 23:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzl-0006mF-2X
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzj-0004T9-Cc
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rtah015204
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zsP3KJXn+vIt1wXWneNsLolV/MTmvzd2xYq4f/SUkJQ=; b=Y+niY+fe9OvZeO/P
 ACO3qpVdNsTcHNOBAYp/sfWuN0UFpmaQ5PQLNpBVi6hK/yR5FfI52udzSfiNZq1y
 eKkVwioJCAPdXZf6DA8gTqEciGlXnsKliq+SOYd5tgMUT7Oel47wll9aaPNnkHqm
 UCl0JWxpxUhnJH7lOhXRiVP7PQBcOvMuQNfjLGMyHLoaPutDau3xPbeFtmd+G1Se
 1nMrUF6WqWqXOgaQuhfLlUVF/7TipyMdy0AjUjCTGyjwQqV9acTzC99wzzQOUKsz
 RFgr8GZ9BUdycZ00hqzljCbtO1iSGAAHkuAr80IbtWRhyjDxSTHLgeghLZgmATZ7
 oP9dMQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxded-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:42 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-77267239591so1184212b3a.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784861; x=1757389661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsP3KJXn+vIt1wXWneNsLolV/MTmvzd2xYq4f/SUkJQ=;
 b=OAP9SZuy6+rx46d8PPz/mSV3SFrvcmuisVC7Gr+m8CTwRshhG082KxzcLG5IOpdRRP
 pHvZl1lIvGQcVWuDJfw/3zaeNDR+hBo+hAx8hld+A2s7MnOlGm3gJPjkCwkjeuFAV81+
 dl2vI072DFGrFPAYeWS+e+2EKDZc9jUKKcc3cKB+khva9X+dQ+2Wkykps17o5XQ2LTzy
 pI6zCGPUgitaj03XOryykuMGM41WEjlmr6L5aLhxWcZ4dwHk50UovTjWk+o0ASH79D7Z
 rcH3Ev5CwNcjhUi+5N0mg/xv8K7kOvDAfC22lxDbN0wN16eQ8mkfDaef1tlTmYZQraqj
 EXlw==
X-Gm-Message-State: AOJu0YydTjzulRFx40avzZN16bVgB11JHlECc6pbVgxAZDKlLc4xpbD2
 77iLax8E5D5TE40/HBnR12UryOfnMkS4EfqQr/E8Um+TIhOgl+CCEvREMPoLQSyCQJgSES/26Rl
 BB0/kxC+d3x5PiwWiifSaIufK/Fb4s3vMuBlLT4R02vueCTfvMlHvskkelTlUUZ0hdLHv
X-Gm-Gg: ASbGncsJae977TnfV///7rx3dW1Rx5hFdQcyF5zz4S2B1MlNLWIOK5Gca4bX/316SMf
 QP0XLlJYSXPCBIlTlyce4IWwakct1kB9rqE3E8BQKOd0kp/0YkrsQrftvmerULLlZ3UkYaRVwUm
 ibXRJRj7RTtY+89LdPxc2I5sKmJeidgLzZW2K7Ceg+U2nm9Gy4bp9Xe/swDI1flY/LG/GoZRgqH
 KQIIvKwUOn16K7Kt3VaBcsnzGDSeCEbVm2fX/ZCr2TQTKb2iaOJiY+5pq3XUmuSiF+q2zfaFGU6
 SWEPaiLPIuEvZl275IIMmQb5kohWPnIjzfowS3cTCc2QQvu1cLNDaoFMFWqYC3yq9+8jbLtJI5B
 Txi9L9NKnP6sH
X-Received: by 2002:a05:6a20:7f8d:b0:243:c081:b4a7 with SMTP id
 adf61e73a8af0-243d6f85b56mr13854719637.59.1756784860571; 
 Mon, 01 Sep 2025 20:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb+gsVef9zlT334jFaj+DG/O8z8wy8PZnAOTgmpVFevreK/ZDTC12A2GRX8uzE6OMUpbPiag==
X-Received: by 2002:a05:6a20:7f8d:b0:243:c081:b4a7 with SMTP id
 adf61e73a8af0-243d6f85b56mr13854694637.59.1756784860121; 
 Mon, 01 Sep 2025 20:47:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 15/40] target/hexagon: Add guest/sys reg writes to
 DisasContext
Date: Mon,  1 Sep 2025 20:46:50 -0700
Message-Id: <20250902034715.1947718-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DfItcM8dLrBlpYhva5NdQDoJIpNMjvTc
X-Proofpoint-ORIG-GUID: DfItcM8dLrBlpYhva5NdQDoJIpNMjvTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXw5RblBf+1dZ5
 7A7m2BF4mqIecji8+UmURN2rV0MTNiGekRndjvKIz0cZwI2rwX6kZjOlJ0G4jFqPJZKPHkq5YWx
 Ggb0xvaL4I2SFwHYd7tvItau7nQUSp92VWuBcWjz2dVQ8kuamkO05IwDOEACE7PJvovp9kCxIzt
 I2k1ffcWgaHgqkS1tFBt1t6SN6cmO+qD0Q2sizSf5Mmq8WoSXoaHF63bSSJjPIQNH4mJE7l2/ZU
 NV/CTV5Jw7ly8aPDkak0hGgZ6Te9KMYarVJSpZbzkEIizznuaZo03RyuGP6Gw6FK0KKf5kioRPy
 CSalyQRgTbX/uMpI6LSZrrqqEKpZZg59q/YDdtgGTh03w6k0ELrANSO+6bcooSmOlze0TzFAm4w
 DT6O6XyI
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b668de cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=tdgd3nfel_K54e3JQaMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/translate.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 4c1868369a..c3806fe068 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -39,6 +39,14 @@ typedef struct DisasContext {
     int reg_log_idx;
     DECLARE_BITMAP(regs_written, TOTAL_PER_THREAD_REGS);
     DECLARE_BITMAP(predicated_regs, TOTAL_PER_THREAD_REGS);
+#ifndef CONFIG_USER_ONLY
+    int greg_log[GREG_WRITES_MAX];
+    int greg_log_idx;
+    int sreg_log[SREG_WRITES_MAX];
+    int sreg_log_idx;
+    TCGv t_sreg_new_value[NUM_SREGS];
+    TCGv greg_new_value[NUM_GREGS];
+#endif
     int preg_log[PRED_WRITES_MAX];
     int preg_log_idx;
     DECLARE_BITMAP(pregs_written, NUM_PREGS);
@@ -79,6 +87,34 @@ typedef struct DisasContext {
 
 bool is_gather_store_insn(DisasContext *ctx);
 
+#ifndef CONFIG_USER_ONLY
+static inline void ctx_log_greg_write(DisasContext *ctx, int rnum)
+{
+    if (rnum <= HEX_GREG_G3) {
+        ctx->greg_log[ctx->greg_log_idx] = rnum;
+        ctx->greg_log_idx++;
+    }
+}
+
+static inline void ctx_log_greg_write_pair(DisasContext *ctx, int rnum)
+{
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


