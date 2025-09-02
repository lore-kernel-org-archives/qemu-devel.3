Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F34CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0Z-0007WV-Sm; Mon, 01 Sep 2025 23:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0C-0006wZ-D4
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0A-0004Vr-Gg
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SH30013393
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8ILxhE7h+hfFtn6G2LTlIYVWHdjTowwoUi5sWps9JkA=; b=QsGO1zTTWiPlJy7Z
 LXHI+kpUF4hmpKgi9UvacPVbyfyMUDFLDDLgXKSqmxjxOEiGjCvKH00UDnLxO9eN
 /VRp6VNT2nFxfi24g2rw1DXBjIdLBYQdzgJR29bvm0ukfSW+Yx5jQVaDbb1ICQfq
 Wgbqe09o3Nx+Y/saEO33kNNiL3vpHaVWJczEG9uJhn1AgU7YrQ7HMykVgE+7QeYv
 rTW6ipNnr1DFj38FkB/Rnu9+R3AgcCOBPjgGQkKuULFBZFZloH4Ap9wB4AHXoBGi
 ts6vQjvkg/FjVOIJlSaEtbwtOGT3mUbC2kWVBkUuS/xMQcUcNPUcrfVbQ8Ft0JT8
 DYUGvQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b47253319b8so3865267a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784878; x=1757389678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ILxhE7h+hfFtn6G2LTlIYVWHdjTowwoUi5sWps9JkA=;
 b=SGF7jWeytFlruL4OB8Mzw45EP6tbCH5pCE3/DGUWASSKCNCJ+8W8tuH6/Z8sCHQWKu
 C1zqYc6BIj5Aj4Df4KqVYH2k/qOvlrELHTn1xthxDMoeqvQ5ONMMrkFwgtDLPCtGUTiv
 ONVqElX6aoWBSbfpsErljT4RKeUxXCQQxgHuwCB/6crjAJyf0YEBDiFYzhNIWLh8BjNE
 Ls/yKCmLqSXbKnuJmyNVeW/SMJd4rkXn4pagXQQoAH1TPIri90YxTzjRfG2W7IxQRYo1
 khbgR7M6sAQV7XjUPk6HBOMYulWId7F+zfzOC5as4ZAxekTeYAhkdry0ZPTxgR6f7nL6
 UuNg==
X-Gm-Message-State: AOJu0YwW7XOyhcDHNzFV/69C0uUEUiBHgVxjF0ie9qGj1hL9KUxDFCrh
 E5a/6Lyg0ckq237YzTqgb2N6mGwCkANAjSllvfI207v4xJz0u/Y/YdAcriph67NgBqZVXpLbIAh
 diuTp3UWgZulTNDDiYXAaFyvFzXQGb/HQOiO9W8Hubba9zPG1olVxPliQnyj4VYdAS66M
X-Gm-Gg: ASbGncuMs1ixmJuGid3VwumtL3Yerv4twQhkx7jb1HprtT67SSy8vm+Z63aHZRuH1C3
 Vy2uydctjTNYi6tXHk7eKEbWCuVUYPNM9s4jKmKGHLw4o6ErjhO+T4IZtTnEzF1RDmQv/0pJIaN
 mXf1T+yh9te/eh+zuCIdjz6bfZ9HjyJv0M5ytNc1r50seWKDSx5HEdfAbY9eCDzkSYowkL6KlCL
 5xl/1dzW4AhpuyEpsiU+NR/lGSlOTMU3X4D7eVbXdNR9wX/+X8Lj6PUjH867EEU7x8Db5tG4Hcu
 9axyVH2/LRXzJL5R15koQAqT/PZqEjzopod1wdSjFeXDogIJQgL11CJWP0KLWItQ9nfa5Ycayy/
 FuxwEt9Cn6096
X-Received: by 2002:a05:6a21:3286:b0:243:ab0c:f0ed with SMTP id
 adf61e73a8af0-243d6dff541mr14843299637.20.1756784877743; 
 Mon, 01 Sep 2025 20:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlDIbhBhh1xjVF+rXFcNaNYoJ4GK4GW1qwDln9OCLjUtYFO7wcQZRo9yYI0hxqPE5X9fR88w==
X-Received: by 2002:a05:6a21:3286:b0:243:ab0c:f0ed with SMTP id
 adf61e73a8af0-243d6dff541mr14843276637.20.1756784877298; 
 Mon, 01 Sep 2025 20:47:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 30/40] target/hexagon: Add TCG overrides for rte, nmi
Date: Mon,  1 Sep 2025 20:47:05 -0700
Message-Id: <20250902034715.1947718-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX80F1SB/FafWb
 GjhVX7cwhtXJLzBYkr07bZV9qn0FnzNGNztF/z0YNEHCyS+SX8GPfYCLK4cWN4W8G/Wbkx2OO/i
 e079/BiD+7bAf2GV7sTLniRvyde2DUSeCZiChIkAUXZZRgEersW9oNMPQct6RJBjcjcrof6tWA2
 pLIf50kCFaRGazE7/CJ72d1Hr2x8HRf1+2aemuxWEFQjd0dWQj2TmmmFesARp32aua0RD3Tkhca
 oPDpr30YMojBEyzTrJfKr5GualzVTMfs+Ja5lYSbSmvP/ZvMF0JRIRoWX5/gGgM7SvkVKjCOQz0
 OG+2eLyWj1fwhpNTc84YV8OXQ/Pb0SH5RoIMdF0f1O0gfwaX4AQtcftIP5bNv3EfplqzlLks/La
 l4M948Gx
X-Proofpoint-ORIG-GUID: KwgErWzRVqGCmF1qlvnGw6plbRtrhEsy
X-Proofpoint-GUID: KwgErWzRVqGCmF1qlvnGw6plbRtrhEsy
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b668ee cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=lxLFxpUPbXRnogNa7PoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
 target/hexagon/gen_tcg_sys.h | 19 +++++++++++++++++++
 target/hexagon/helper.h      |  1 +
 target/hexagon/op_helper.c   |  4 ++++
 3 files changed, 24 insertions(+)

diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index 942d07b401..6d73a18db4 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -81,4 +81,23 @@
         gen_helper_stop(tcg_env); \
     } while (0)
 
+/*
+ * rte (return from exception)
+ *     Clear the EX bit in SSR
+ *     Jump to ELR
+ */
+#define fGEN_TCG_J2_rte(SHORTCODE) \
+    do { \
+        TCGv new_ssr = tcg_temp_new(); \
+        tcg_gen_deposit_tl(new_ssr, hex_t_sreg[HEX_SREG_SSR], \
+                           tcg_constant_tl(0), \
+                           reg_field_info[SSR_EX].offset, \
+                           reg_field_info[SSR_EX].width); \
+        gen_log_sreg_write(ctx, HEX_SREG_SSR, new_ssr); \
+        gen_jumpr(ctx, hex_t_sreg[HEX_SREG_ELR]); \
+    } while (0)
+
+#define fGEN_TCG_Y4_nmi(SHORTCODE) \
+    gen_helper_nmi(tcg_env, RsV)
+
 #endif
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index ada520bd52..730eaf8b9a 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -128,4 +128,5 @@ DEF_HELPER_2(start, void, env, i32)
 DEF_HELPER_1(stop, void, env)
 DEF_HELPER_2(wait, void, env, i32)
 DEF_HELPER_2(resume, void, env, i32)
+DEF_HELPER_2(nmi, void, env, i32)
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 57d8e8305b..0aa9b91f85 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1433,6 +1433,10 @@ void HELPER(setprio)(CPUHexagonState *env, uint32_t thread, uint32_t prio)
     g_assert_not_reached();
 }
 
+void HELPER(nmi)(CPUHexagonState *env, uint32_t thread_mask)
+{
+    g_assert_not_reached();
+}
 #endif
 
 
-- 
2.34.1


