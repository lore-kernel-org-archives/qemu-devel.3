Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DA6CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0U-0007K7-Da; Mon, 01 Sep 2025 23:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0B-0006wO-Tb
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI09-0004Vn-8t
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:11 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RmGT012352
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EAl365lPLknZnw8mUPhbXE8Onwu5SXWupHDGh49GdfY=; b=exhPkl4ndFRzaqPF
 BRqqV67u/7/cYe3JvFr6C1ZRLiBGmv0jNv/UMPNKblaB9bFPp6KRH2/Y3kDY98xD
 Hru0jFb5gBuyDum2fEypBrRPbT/azyWTFHAtqQ0rpbSnP0ib+X++WC+sJWFoBBYt
 Szia0ErQ4xj9taSsjetjthZFgZtgiNX9c0YHqlbr6twG/OyHtTNsbbeXkuYvkksq
 fYJu4GW1V42RfpHlgFXEidsq87P5FaSI/mvE4EG1F2glEbDUfLGX8KceHKYGEdsL
 5XreqVxSY8fwH8BU3cm1x9rwYurDvLIxydMQ3Sn4UujFMzahWsGSt02/XVC8A4rk
 +HfynQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:57 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b47156acca5so4015760a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784877; x=1757389677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAl365lPLknZnw8mUPhbXE8Onwu5SXWupHDGh49GdfY=;
 b=aUE7HyHi3E7coSAccHNCEAhiTrAfaYFPRmaPTJQ4l0P81uLNebhPevR9xu+EUONSeb
 +Q4m6Eec4LoZtOfiXQb5IoZri1a0Dl4Z8++x8kbTCk64sl67XGMFhIf+tPW4k9dFkzze
 QXUiLkyLzNfYEQw/op6zsf4yNiKeAUe4kV7EPIKzONRv8bXVjRcRhDxzZ26EmNfoQ3Mf
 tLRxmL244iEWckqks+xnQWQliWFf4MjSmY8hD756/brHu+uTMaoQ0+eWKI9KZg8HA088
 CayTUsQ/oKgOX6MI/sq83rvWerHwRG4KkS0lVD+fLh9KWLH2bXzVZx5/suvN9CPmPV14
 qvOg==
X-Gm-Message-State: AOJu0Yx8TuUdtS44bgExlr1v7KUBlfLzsaUh15IZTOBtdvf0I5PKl7gX
 KwOa/b/AVLJhgfjG0sYVKxB4dMGK2Z9js0DVVaREj0TK3CRc8IYuPWo6JZ/alvEqyNxKxQTWbTO
 BnMtLUesYeT8F3HlOQnsE8mmOcs1A098HoyLwIyluIjR/hdCsJvBXPkLUq4p5/tPVqJQe
X-Gm-Gg: ASbGncuFXJYuT5tdXiiXyJuMGgLUV3c7Sb6N06qq7+gO27K3diWeWrjC3F7ly8SGtHy
 061blQuaQEmEbOGAKp+z4RNOT1InK/YxpKPpYqIR9VrzxIu0r+s3/afLAhbSenCrrQQekgr0EVv
 y93My6GQ9s4VmRJSjopk/OYs+OebnNYFpoLAXSn95B0s4itZ6xLHFAhn39gUdGGwGMDivXRuMZG
 u1brJuZ6j9wkN290xQIc/dFtGdxe+7MDDOHTf1hMcghOR0sug7VpuutZbKCuTSlpyBgmfkxKKyF
 ZzWB1kiNsh14twyTgGuZ/PU4HAmr1gOw9NhQuZLWhqBfgV5Isvm2gYJ5MF5ut7/QSMhd1wEnB9f
 9m8yPtrFO3R1w
X-Received: by 2002:a05:6a20:431d:b0:245:fc8e:ef5b with SMTP id
 adf61e73a8af0-245fc8ef17amr628022637.5.1756784876560; 
 Mon, 01 Sep 2025 20:47:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcsYVoEySEVnZxUGQaRgJyR4dNs3yHxAl+Fs1CUndUE6iwzUVUXvz3HbettHzgyBsuXXTW1g==
X-Received: by 2002:a05:6a20:431d:b0:245:fc8e:ef5b with SMTP id
 adf61e73a8af0-245fc8ef17amr627982637.5.1756784876069; 
 Mon, 01 Sep 2025 20:47:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 29/40] target/hexagon: Add TCG overrides for thread ctl
Date: Mon,  1 Sep 2025 20:47:04 -0700
Message-Id: <20250902034715.1947718-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX6lzz0XOTyU1r
 vrB9Y9Q5pNTYwGvntNjmaY09nhO+frSiYDmC9iP9I59V7Sv2KM43fxDo8+1BvOstGaOPj5TmvZK
 o4DRyz8WmAh5zaH4tDnl49c7laoF7g3Bu5BrFVf5SmmZb5l2DEgi7vxiPLB83d0EJ4ow7XXdNUO
 nXuTYsfFyIz972/Bp8XmLR2URJ2K6fSqiohD7PqwCJ6ok36FmGvV9bXN/Ws32SZlR2Wt8tFUvIx
 R+iW5SNDwiJ/Xkrz8sPG58VtjTuWG+8O/rKoMGO8+aMhPh71I9XIw3Vu7aRgCPaZBE8WM3XgFDE
 E4xY3B33RB4PYOio6TDHZM9QK5BkN1yU+5v34kifmoCHBjI6Z5h8Wn1XtpItrLxaPFer0i1iE2Y
 918l+Qf5
X-Proofpoint-ORIG-GUID: Huc4x_WMZ8rqJVfHP5InYGUAlZGAu6vV
X-Proofpoint-GUID: Huc4x_WMZ8rqJVfHP5InYGUAlZGAu6vV
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b668ed cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=t9Y8JitlK4h6-XB8aEcA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
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

Define TCG overrides for start, stop, wait, resume instructions.


Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_tcg_sys.h | 18 ++++++++++++++++++
 target/hexagon/helper.h      |  4 ++++
 target/hexagon/op_helper.c   | 20 ++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index 642ca3d3ff..942d07b401 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -63,4 +63,22 @@
         tcg_gen_extrh_i64_i32(ctx->t_sreg_new_value[HEX_SREG_SGP1], tmp); \
     } while (0)
 
+#define fGEN_TCG_Y2_wait(SHORTCODE) \
+    do { \
+        RsV = RsV; \
+        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt->pc)); \
+    } while (0)
+
+#define fGEN_TCG_Y2_resume(SHORTCODE) \
+    gen_helper_resume(tcg_env, RsV)
+
+#define fGEN_TCG_Y2_start(SHORTCODE) \
+    gen_helper_start(tcg_env, RsV)
+
+#define fGEN_TCG_Y2_stop(SHORTCODE) \
+    do { \
+        RsV = RsV; \
+        gen_helper_stop(tcg_env); \
+    } while (0)
+
 #endif
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 2fe4440ddc..ada520bd52 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -124,4 +124,8 @@ DEF_HELPER_2(greg_read_pair, i64, env, i32)
 DEF_HELPER_3(sreg_write, void, env, i32, i32)
 DEF_HELPER_3(sreg_write_pair, void, env, i32, i64)
 DEF_HELPER_3(setprio, void, env, i32, i32)
+DEF_HELPER_2(start, void, env, i32)
+DEF_HELPER_1(stop, void, env)
+DEF_HELPER_2(wait, void, env, i32)
+DEF_HELPER_2(resume, void, env, i32)
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 01e2677a62..57d8e8305b 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1367,6 +1367,26 @@ uint32_t HELPER(iassignr)(CPUHexagonState *env, uint32_t src)
     g_assert_not_reached();
 }
 
+void HELPER(start)(CPUHexagonState *env, uint32_t imask)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(stop)(CPUHexagonState *env)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(wait)(CPUHexagonState *env, target_ulong PC)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(resume)(CPUHexagonState *env, uint32_t mask)
+{
+    g_assert_not_reached();
+}
+
 uint32_t HELPER(getimask)(CPUHexagonState *env, uint32_t tid)
 {
     g_assert_not_reached();
-- 
2.34.1


