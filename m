Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FE5CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1y-0005iA-G9; Mon, 01 Sep 2025 23:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1n-0004mB-Eg
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1l-0004gh-0W
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S5W9022217
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bQNP/pyEYOz75w7E6mG0hPIz4XTTqxmaqbupKpuY34k=; b=MhjtE4kwMcZ5tsmP
 JRNtScuzx2MQAY9yQ0uZGIF2yk8pu4gjsWK14rdz4w5b/e8RoNkJhVEwk9XGG6N5
 IzZTY8zKNyqaKA5Wc+CMA6AnmL5BpE6ADHSsFvnbyybsqMrjlH9qHtP6gPcAXqtd
 jP724O07/raBzRLT7f39N1EYs+W3gJhGb73kfbvtTtac2V59Szz1epQHNz2vLCLJ
 +HDfBrTq1NuILW40RPD7UksodhJI3IZ2+TSrDzca/Mg73uq5DiddoMDFczcTPm/n
 ybMcTYq8WFS98usY/Hd9R5K+6PnODQgokL7Pxh/SjklEfHixntJmTXGoHxyiGJRt
 +X+eTA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6hvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4f736195daso1339392a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784976; x=1757389776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQNP/pyEYOz75w7E6mG0hPIz4XTTqxmaqbupKpuY34k=;
 b=Hm7RbHMGyz0G3CLqFTIXtBhhcIluyPxMlDzzVQ9JYuBVz4EAro3HrumK0r9cf6oAST
 xXpcZ+QF8VNlQgGFuvskgOXSS7I7HFI+AgFnmJ/RuHZEO87K3qwJuhzwwfNyNFbU+Xjx
 efgxUEYC3IJEo4k1dhj8Y5hHaDHczw3M5p9eJOiDgT2oIHdfPoeENVrXEDYRPe5aL8pk
 1oG7uyN8QTF/VeLHGnUB/p6QI7eemcrPqYcGJKig+0PRyR35YMnUbZ/JIzQi7s9EriVk
 dnySER4aaaiWjENkc1VELP85+mslh0saurb0Gb+jvEGgoMC7cf7+s6gJIcFK3WF+FqVU
 UXQg==
X-Gm-Message-State: AOJu0YzmJOD2SwqaYuRoV6I2HdNOM/g2GROPJFrf02B6/GFHso4uRgad
 KEIRu54wPzhDnGGcc06DU7+wzvF7lKvnc1VpECCniWKuqUXl1Lr+JW1XB3mA8/CGzc7I6lpvMos
 Chp5EaPG1C9iNwjNZW4be5JSgi3QKTs2oh9+QguDL5o77WNF1UiEadg8Hme6/GrQ9CY8e
X-Gm-Gg: ASbGncv4i9ZUwWNyK1j/tBaEGCwtrY8uvVOHSsA7dAx0IGNkejLe/rfvuJIJew/vL/6
 P23TZX6dYjMHlsyh7SOp6jsn1oxIscGhI//Vq6ehPBOBH6Whp+j1Nbo8B57+J8Z9qJLsdeo1KiY
 lHYc+2iQh3ZDDtscnF137XW9WE+VllJ9nyz+LTYq9B4swXACkSca71wa/I8GiA6sKQS9YKylGRR
 rWwLlgISs0Ho78tay5OVTC+4rSRwfqpTvoprIPylT8qcfryUld0JmE7ISOkDU9qy56oajIm4wfo
 arNXbxraXb8cmda4+S/WM7sjrLlIG7UjvjuJ+OxIux10WVg0tuoVtMdKv0KAHzkYwE+e0lC/7Sg
 elJKPyTW4e/be
X-Received: by 2002:a05:6a20:3944:b0:243:be7c:2d62 with SMTP id
 adf61e73a8af0-243d6dd4decmr12522496637.11.1756784976012; 
 Mon, 01 Sep 2025 20:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmcIrPb4loqcV9t3CUxKNVzsRGuy7JrYwDXe0xRBFg9brUG9qeG4dhejwa4r3XXhO5CKu3oA==
X-Received: by 2002:a05:6a20:3944:b0:243:be7c:2d62 with SMTP id
 adf61e73a8af0-243d6dd4decmr12522474637.11.1756784975545; 
 Mon, 01 Sep 2025 20:49:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 36/39] target/hexagon: Add TCG overrides for transfer insts
Date: Mon,  1 Sep 2025 20:48:44 -0700
Message-Id: <20250902034847.1948010-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IdDi4R-_g5SJ9QNGNFlCLxz-YqdQNunK
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b66951 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=LN73x9Sj_Gq4gUX8wwYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: IdDi4R-_g5SJ9QNGNFlCLxz-YqdQNunK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX/Wqj6X+oVV2q
 GxIW0+gXxVeysaHuiU+op1zjm2pNXHNqsd4kZt2ibz21nzrPwDxUJqmVPlk4q4GwDBcLZCCAd49
 u4jY8cAi3dwR3yrpY+4ZeXO/tPud0hfQLk/JHLfKN3GgtDnD4Lr+iv9CngZ0CebJ8gj2gsFbzaq
 8tZZI0B+V5nmuY5vZU3EDJIFxUClo+FBzzanG8Bwag4S1UzcQxnpwIdyxhAj9NTl0WKJwMb83wP
 L4Q4powDZfywhJsduBFN7cyJguApnvKZEVyqGe6WHd1U40eYOxI8ger/IkZKPPLXDtO5AUtilNV
 zIJ68Ges2xLNCiYvZSb9ESnMifh9OXoS/3mQPOgZSb7d44elC48vJ6WF4MCOu1YLkoE5NxRkyEp
 WBetLAve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001
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
 target/hexagon/gen_tcg_sys.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index 6d73a18db4..e56553462f 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -81,6 +81,31 @@
         gen_helper_stop(tcg_env); \
     } while (0)
 
+#define fGEN_TCG_Y2_tfrscrr(SHORTCODE) \
+    tcg_gen_mov_tl(RdV, SsV)
+
+#define fGEN_TCG_Y2_tfrsrcr(SHORTCODE) \
+    tcg_gen_mov_tl(SdV, RsV)
+
+#define fGEN_TCG_Y4_tfrscpp(SHORTCODE) \
+    tcg_gen_mov_i64(RddV, SssV)
+
+#define fGEN_TCG_Y4_tfrspcp(SHORTCODE) \
+    tcg_gen_mov_i64(SddV, RssV)
+
+#define fGEN_TCG_G4_tfrgcrr(SHORTCODE) \
+    tcg_gen_mov_tl(RdV, GsV)
+
+#define fGEN_TCG_G4_tfrgrcr(SHORTCODE) \
+    tcg_gen_mov_tl(GdV, RsV)
+
+#define fGEN_TCG_G4_tfrgcpp(SHORTCODE) \
+    tcg_gen_mov_i64(RddV, GssV)
+
+#define fGEN_TCG_G4_tfrgpcp(SHORTCODE) \
+    tcg_gen_mov_i64(GddV, RssV)
+
+
 /*
  * rte (return from exception)
  *     Clear the EX bit in SSR
-- 
2.34.1


