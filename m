Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9495AC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udxwS-0002NV-02; Mon, 21 Jul 2025 17:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1udxvY-0001c9-8G
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:20:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1udxvU-0002lO-4S
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:20:03 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIgnjV009627
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=quBf6+qafXN
 iiCaOvzF+sfk90rHFXzWXhh7oqA1VxTk=; b=b+HQ5OLZYCoDbysJVGtUDCOVJ5u
 BgnPCO+9jSwww2RDEnNhWfsrE6b7m9dm9nQ+U2q7hN3NePWHwVjR6d0uFmi4CUwA
 M9mmXnhS+qeLDyYuHI6q5teicqtSU9XAQM90gio0EF0X80ytX9K/vXPiBkR30cb1
 VtZLysCEaJvFwZel21sL3qR+RVnxn+ZaN6xmXCqc/e9ws9FsmEjZH01ZMa0F9vBD
 M7ui3WropqWANPYfoRqheW3CWtfyxSUwR85UCO121EYX41nw6eh4oDI+kAISTi27
 djaLZg/BUuxk78FRXsxyBS5EkvQJV5Zj03UOvplymGSoYueae0WziHa5Iig==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vwhw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:19:56 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-74ad608d60aso3857584b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 14:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753132796; x=1753737596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=quBf6+qafXNiiCaOvzF+sfk90rHFXzWXhh7oqA1VxTk=;
 b=Y9cxgxBacPGLJs/ODO8E7xRSdjqNee21Mqp1ZfTDst/8lFPqOBemfKb6Sl3Gef1sZA
 uXSIDIVlkhAleL2VmeIWfau4JC5Lg2SyHhB9Lv+8/ZVT2YYbFCfVTOsmx/c+mhy7xRmd
 zl89TSIrph2euobc3x/x5E4tA7GbyVkOkOqeydYhEhFK/jJoqr3lzeDqXzOfj+kGLMPd
 Uxq5Zj1aRbGvDxFMl4YU3yad+OLMUs8NYxkTZBD76ldhf9jhc+lPrXguNl4TmzvVJhDk
 FoXtfLIKxEmiwqHVFcfUOT0vlsgg/wH2jJa0rNp2aljtFD6xzvDLSiFXg2jrWfE52G4P
 DqTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQYniOiTqjaC+AEld7Ey9jTMdUigYF0N8sqLEgSWxmWBPTuqGbbm3RKRM6Qh0Y1cu850DJhSfzbPVu@nongnu.org
X-Gm-Message-State: AOJu0Yw9w3ITbnvYLtUqo55hCt2VOW6Qxg3Jj3UXGCVz9FV59ZYj1yxV
 o+VXGM7TOhuDQjbzOWRf0DSfNqdYfmFNa8unJZ/GF7SaWLmt0E2JlF5LxhCXxewF9Afx7zBL3qu
 Fnxpy32peH+3E3xehzp7bhQO2sCtIFOoQ+ZcZ+nL5Go80O6U0RxH03k8KZA==
X-Gm-Gg: ASbGncsG5pZZf2ujBdf653eM2bvm4IQ0fBELAmuuCFBF74zGr4Jt9mLcthqB9JjRLcE
 U7mYkURligsq1CqLrFP2tKmvfaQ2WsN19ym+VUI+Xl5S2TAlM93Tu8R5iFpeyMKY9+t5lGOCGXV
 FjxeS8xMnS5V65Z+73Gw5KIXxkiwj4fdulpg16MtRv/M4CM2tuN2lazowV5EoG9nWRFr1Fdpql1
 WMPwxtk1nHDuX1kAvAANUxx4xOzQP+tNbBzCoN7NNqvifEjNQ3o3Z7EfGUYzQ/ezUFOYcpF4cO4
 n7+kqLyaaCWIMRbRDwkDACnfaq1jN3ZRJhw7TwZZUDWSGvgok67i4+uU7+wbFc14d2OpaLUCgsk
 M6ajEmIZFg4a/o3Q=
X-Received: by 2002:a05:6a00:b56:b0:742:4545:2d2b with SMTP id
 d2e1a72fcca58-75722282709mr34169309b3a.3.1753132796027; 
 Mon, 21 Jul 2025 14:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGao6jtDJMN8q51fFyNRafSdhP/qARxjHpbJKcygYXSgDUaBKw1yGlxJthyaf3KRi5OVUM2fg==
X-Received: by 2002:a05:6a00:b56:b0:742:4545:2d2b with SMTP id
 d2e1a72fcca58-75722282709mr34169285b3a.3.1753132795547; 
 Mon, 21 Jul 2025 14:19:55 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cbc680absm6338808b3a.144.2025.07.21.14.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 14:19:54 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: vacha.bhavsar@oss.qualcomm.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 1/2] target/arm: Fix big-endian handling of NEON gdb remote
 debugging
Date: Mon, 21 Jul 2025 21:19:51 +0000
Message-Id: <20250721211952.2239714-2-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250721211952.2239714-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250721211952.2239714-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687eaefc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=GM_HUT_K9c-Ogac251IA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: Ua75U8c2Srpk_e2ut9oaoE_cepSLxvbs
X-Proofpoint-ORIG-GUID: Ua75U8c2Srpk_e2ut9oaoE_cepSLxvbs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MCBTYWx0ZWRfXw6BE5cOvFbQH
 HfzgtSW3bdIMyJEFZu17s5b3ZKTwDEDIEUyQJQW+dnHcbOsUqSeXyzyCFO/FF7mroFyRUZQQ6ns
 hvBA3Pe0z8xu3xzDyY00XRijxnQ61c3U4iSzhG/8k2ApZZNIx331L9Lp8JVYS51qtqUSvilv/lp
 bXScFeLjocmT95nildz/2mYRB/n3/6DANDnwGyL0yISee/PukNi41TLZHdgVG4UzEfhS362AKCy
 iGxwh4KeDu3BniNPjPoXxApGaoHXTByVsKDD8zee/9BqPtIJ5bK1PYDpnJGg3pns/oOQ4JGVUBd
 mLL5Dvw8NbDgjVCTtfVVN5ySWhoZCt1IopsUu79SJj5XnEw31RA5oAtMx2D+aeGXViXd+3tTmdx
 B+XYb/UyWi4uEPbGDfmk+QuXe+F5YSUxypAH0O/gsua3l0nQ9Wlkx7hJwNFarLWphhPpTWfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=659 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210190
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch adds big endian support for NEON GDB remote
debugging. It replaces the use of ldq_le_p() with the use of ldq_p() as
explained in the first part of this patch series. Additionally, the order in
which the buffer content is loaded into the CPU struct is switched depending
on target endianness to ensure the most significant bits are always in second
element.

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
---
 target/arm/gdbstub64.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 64ee9b3b56..8b7f15b920 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -115,8 +115,16 @@ int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg)
         /* 128 bit FP register */
         {
             uint64_t *q = aa64_vfp_qreg(env, reg);
-            q[0] = ldq_le_p(buf);
-            q[1] = ldq_le_p(buf + 8);
+
+            if (target_big_endian()){
+                q[1] = ldq_p(buf);
+                q[0] = ldq_p(buf + 8);
+            }
+            else{
+                q[0] = ldq_p(buf);
+                q[1] = ldq_p(buf + 8);
+            }
+
             return 16;
         }
     case 32:
-- 
2.34.1


