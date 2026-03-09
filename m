Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF130F417F1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv5-0001VT-2I; Mon, 09 Mar 2026 10:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbux-00013i-5j
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuu-0005Hp-51
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:09 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629A6eqr2195118
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kN2NFQkaBUPmKruiN92EEV3fkDFU3ht5CFn5RR7/Sbo=; b=kXRG7nOksmXoa1iV
 CFuZ5o33pWbiYikffCuScuC6+YVHkfg5pMx0dBzGWEbKGn1VZOb8yoyARYl5mkO+
 7p+FdioEe/cTseQxBmeAFTtPOkIicaCQpE4DslKqSgiS2/uruJRnnjOB/Lb6LIvv
 qphFE7FJ/Y+sKPOoDiOupGbxv0tgg1kXaFoiz+U2S+r+6G1w0A2xsZjeIZ4OwHRL
 hccF7jOTLus4Uu+JNDtRi1FT+7OXZxYARLF32Jzg1LCxVAGWxK0uUR8OLzFIZezZ
 LBptfus4qp59CfG5o977R7+zIkTrfnbD/aey2N+0K3MP9ujORC7KoiVsqoqFGCPu
 ekWUIw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csv5u8vku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso9277766eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067736; x=1773672536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kN2NFQkaBUPmKruiN92EEV3fkDFU3ht5CFn5RR7/Sbo=;
 b=iUwfyyJgijdR5JohHtYG3+pTKi2vPZvgkdVUZF4tRoNj9M9FGI2Wq6HUfRr+bDL+iY
 tJ670G3qNPhCaKrUmSNspSbB9pZPO+B1a1AhLH3PArTo6ZJ9XUuCsSA/0qStX7qYy7It
 V2i1muSfj/hqO+D2OA7LMJ5vRisvKfGSFlVRZ/eMLLIYZPm2uL8JD/kBaCdX5GVpDXoK
 X3FUn335s/LH9gKZVKVuzxXfQwyUfYOVoTk8r6k2/fL999g1ka8gHdGXJWrCs+V+TVvW
 F2/Pv7MUkx7+RdD3U1OBIHIdsyw+AwZFexCC8XrkJ4h9g+NiWDW1xfS00K8bKkucHqLC
 oV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067736; x=1773672536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kN2NFQkaBUPmKruiN92EEV3fkDFU3ht5CFn5RR7/Sbo=;
 b=RQqg0qDd7hCK1XVelU3Bbp7ldj47L8CBfUrYc0fxpA+/1EOsyjNWoqLJTR5cb+6w13
 5DoS47CU2JipQCCoGenVYahWtUaDMqN3tidP785qAxe+IP0HFOR6R86nmbC7EOKyt9l6
 xLQsanld6MGhWOdaqNDkaZKZXMzT48Ervz9DCM9htupZ/DdqwjjBWfTPKRzew8ycA0Wi
 eBFRzSx2kyL/8BVpS+xuvON5HW1ceLDU7D0+ydzm6EZfmHoPUje1KIUYD7cU4VUvdIAd
 CmsTn/KNczNNbHRMe+LxqZB+eYZivpGA099iVIoesZqODDu6ID4kRlrtmJmG4AfL9c+y
 JBdg==
X-Gm-Message-State: AOJu0YyPqjzED+aBPDpcfDuNjtQHPYmVGiLAA7UOdS3eWhn6mMjtgHXi
 PpeRS00nAMsq7o+D4JQivYD0Um5mWVeApxIJzhm/D/o0yxpGhl+MNMtzftrzHuP/Ro1g5OZrcoy
 b1PJqH+S10K5F3UojG77OPsmcF/VXHQ9u0EjV+Y2LeR5qa8WWBO714csZosjHFExFvw==
X-Gm-Gg: ATEYQzx/gZQMGch9I+ubFnJr0JvWoLFGqRPsmqkWZtS7uL//LkXGXWWfW4Gue0DFgQQ
 X6IfGDWXyBZKovj183Gj0WRI5GxzKicebXRhZ8UuKfNsxGCpaLXkP27/PW2rQ9RBprMwSwHN+nD
 uNIgxh5AN8gMVdsxyxuZa7mBKUbEaVb3DkueY4BUj8c9QGZhrvnwE1yuAS+YnMO5rcDMnM8G5v9
 C3fimaI70FNWe/0sOLEouctZwD5RjhnwoeB811JGCqN3GyFdmLuuSX9u5rsQEJE3TdBfPilYTvP
 fh2nBoyReVGtCy6y6xtSWQV5gfhq0g+lNvzLTXS3YyGBa4yxzjVX8KdZafCJOcRjV21qsGbxnBK
 ZYnAMzgfJLZoi7edngRHFiYlNGLUHNidRosvL38QqP+SjmT88llDIbNC1wJz1O9L7pcR+zg==
X-Received: by 2002:a05:7300:6da4:b0:2ba:a60a:15e6 with SMTP id
 5a478bee46e88-2be4dfca833mr4004545eec.16.1773067736111; 
 Mon, 09 Mar 2026 07:48:56 -0700 (PDT)
X-Received: by 2002:a05:7300:6da4:b0:2ba:a60a:15e6 with SMTP id
 5a478bee46e88-2be4dfca833mr4004528eec.16.1773067735485; 
 Mon, 09 Mar 2026 07:48:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 26/35] target/hexagon: Add TCG overrides for int handler
 insts
Date: Mon,  9 Mar 2026 07:48:13 -0700
Message-Id: <20260309144822.877695-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hJMu_hNOcGXJvWuz5_kYxZD-XZjedr6n
X-Proofpoint-ORIG-GUID: hJMu_hNOcGXJvWuz5_kYxZD-XZjedr6n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX9ejEE7PhEj9o
 R7CDtxKUASO4DSdnVsc26jdYYoxyaMnFrBELZnMAor98YIzTcjNJt3HBB6cw0L1j9d18EJntfKe
 xD9EaQ77DK336SdLtFut0pe1aa169xKmekuKpve4mwqQJR+kHgfGYlXuHGMh2mss1SRVhRMbcpE
 YxyNbiLHB7/TDbnFjHe5efojWtWVMT/d+82W8XNiAZbn1l7HuhYZuTZ2mi5LluSTvCna6wXSJiv
 lzt6uq+JOFD9Yb2B232GgkBlgWvYy/YOb+MgK6uH9wuKeXinmjOj8hgW8m3dqX7GH9Vz8xXmHWX
 D/xC/dAnqhMbKygLNjLyI5YyxPs8ki3rEqACi6436fOh5MyOyayHkLGHvBcGrS67nDHeQMJq2gM
 gCN/Lg34hC7N+PjBKY5ENRhx7KdxPbNRxERVKcsXmtMrT6kXequsHKzQej+yT88kYyy7hisAAZ/
 2rLWjL7Li7zMQNR2A2Q==
X-Authority-Analysis: v=2.4 cv=Xr/3+FF9 c=1 sm=1 tr=0 ts=69aeddd9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ncxFUDX8U6Z2rYVbhVQA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Define TCG overrides for {c,}swi {c,s}iad, iassign{r,w}, {s,g}etimask
instructions.

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_tcg_sys.h | 25 ++++++++++++++++++++++
 target/hexagon/helper.h      |  8 ++++++++
 target/hexagon/op_helper.c   | 40 ++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index 2410ac82c96..7f223ff3884 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -7,6 +7,31 @@
 #ifndef HEXAGON_GEN_TCG_SYS_H
 #define HEXAGON_GEN_TCG_SYS_H
 
+/* System mode instructions */
+#define fGEN_TCG_Y2_swi(SHORTCODE) \
+    gen_helper_swi(tcg_env, RsV)
+
+#define fGEN_TCG_Y2_cswi(SHORTCODE) \
+    gen_helper_cswi(tcg_env, RsV)
+
+#define fGEN_TCG_Y2_ciad(SHORTCODE) \
+    gen_helper_ciad(tcg_env, RsV)
+
+#define fGEN_TCG_Y4_siad(SHORTCODE) \
+    gen_helper_siad(tcg_env, RsV)
+
+#define fGEN_TCG_Y2_iassignw(SHORTCODE) \
+    gen_helper_iassignw(tcg_env, RsV)
+
+#define fGEN_TCG_Y2_iassignr(SHORTCODE) \
+    gen_helper_iassignr(RdV, tcg_env, RsV)
+
+#define fGEN_TCG_Y2_getimask(SHORTCODE) \
+    gen_helper_getimask(RdV, tcg_env, RsV)
+
+#define fGEN_TCG_Y2_setimask(SHORTCODE) \
+    gen_helper_setimask(tcg_env, PtV, RsV)
+
 #define fGEN_TCG_Y2_setprio(SHORTCODE) \
     gen_helper_setprio(tcg_env, PtV, RsV)
 
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 5405342f798..955287133e4 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -109,6 +109,14 @@ DEF_HELPER_2(probe_hvx_stores, void, env, int)
 DEF_HELPER_2(probe_pkt_scalar_hvx_stores, void, env, int)
 
 #if !defined(CONFIG_USER_ONLY)
+DEF_HELPER_2(swi, void, env, i32)
+DEF_HELPER_2(cswi, void, env, i32)
+DEF_HELPER_2(ciad, void, env, i32)
+DEF_HELPER_2(siad, void, env, i32)
+DEF_HELPER_2(iassignw, void, env, i32)
+DEF_HELPER_2(iassignr, i32, env, i32)
+DEF_HELPER_2(getimask, i32, env, i32)
+DEF_HELPER_3(setimask, void, env, i32, i32)
 DEF_HELPER_2(sreg_read, i32, env, i32)
 DEF_HELPER_2(sreg_read_pair, i64, env, i32)
 DEF_HELPER_2(greg_read, i32, env, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 22dbe8c85ec..bb47b090113 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1387,6 +1387,46 @@ void HELPER(vwhist128qm)(CPUHexagonState *env, int32_t uiV)
 }
 
 #ifndef CONFIG_USER_ONLY
+void HELPER(ciad)(CPUHexagonState *env, uint32_t mask)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(siad)(CPUHexagonState *env, uint32_t mask)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(swi)(CPUHexagonState *env, uint32_t mask)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(cswi)(CPUHexagonState *env, uint32_t mask)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(iassignw)(CPUHexagonState *env, uint32_t src)
+{
+    g_assert_not_reached();
+}
+
+uint32_t HELPER(iassignr)(CPUHexagonState *env, uint32_t src)
+{
+    g_assert_not_reached();
+}
+
+uint32_t HELPER(getimask)(CPUHexagonState *env, uint32_t tid)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(setimask)(CPUHexagonState *env, uint32_t tid, uint32_t imask)
+{
+    g_assert_not_reached();
+}
+
 void HELPER(sreg_write_masked)(CPUHexagonState *env, uint32_t reg, uint32_t val)
 {
     g_assert_not_reached();
-- 
2.34.1


