Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DCDCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0R-0007H8-45; Mon, 01 Sep 2025 23:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzq-0006qC-TE
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzo-0004U5-QR
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S5IE013610
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7mkT0uW2+g6NjzQdWPYa1vk3J4PvrH9XyEQZ24VJRdg=; b=Hlh3B8/XXjG86LqB
 zEk3rfyU0PjyxwVJvf7DFIWaohNGluV4e4B9J7PzrEsVuQLWpmKVyTmpD6BCCi2s
 Y+NGf03etzrWrys++7V6wcuVeR9F3RNZm5rzW3bqCt2DWHoS12Z5atAJ3BQvzOjF
 UWuGK+gL/XxZSRIvrenxrjhRsN0iygH/hsVWzM65h8NKcDjB9V6By36SECGWL9Op
 fN1Xd+9mOobMLRE5BaVeFQsQLc2cWfw3mUMoDk3sZgHvooYspqWvEuLsWP3OpqcI
 XaS3gtvBN5tsOF5ZUT58b9lpGrvp+CPMVk1fUKGrmjXGwIkSxHh7PuViMtfd76b1
 3Wj0EA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eej5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b4c949fc524so3228723a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784866; x=1757389666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mkT0uW2+g6NjzQdWPYa1vk3J4PvrH9XyEQZ24VJRdg=;
 b=iEmQQUmRELCcRDAWxK7SaZAAIvX0VgdXEd++qs4sEgWZemCzkgVVbnDPPMxTuyogvx
 Zglj6BEIB9c1IMF06tLn6zyn1esULhRatlmfa4QLfjD0YEhmLbiTbkxvBgLJTo1ARGCB
 SwHoLQD7SDEBRmiIvPOI4OitykdcWGfJi2YBhzCUGlQv03hXwFYphuimEXrbKJhD50Sy
 nN0NCYmVqTViI96URion4HsziRY8T3/1THtnriyr8AoenzXr67reQWblgJtZ111FrepY
 UJn+5EBqwLfgus6Tsaws+QqaDktKStDSSdgALoV0+ZHSBlfxp4r3vOQaEZkpuQbdpoQd
 Npiw==
X-Gm-Message-State: AOJu0YydcUgVN3ZYWRlNNe8zV6P9NiI2PEBvQHyX98U2CrR90w6BJgKj
 xNd6DL/2WehUAvUQABrPi9laAsgQudPSeVOiHc9b0urVesDEhssCl30ft4kWoj3pj0mxlbezWCF
 W6KlHyxm158hWKmKwyjnSXnKn2eRotZLDyyMJq5+8Oi6G6bPMaV17/wyT49BHCT4zfh/S
X-Gm-Gg: ASbGnct9XM5RmUA18zarTdGAiZ3qiGEBi0OmlPAV2eAr7/3Tmbr63zExKChzMvUrUhn
 G5hpCb8B/rACq0W2pMtmAByswsmoMSlESmPbfbpdRTU8mXgqD3zd3NCaRYUpfsm7Q3E5umSKNdS
 8En4UbnXcXfwWmXeuhAJPNV5kbJTAPIjA/z2jJSE66QmgNd3MHvI2I09vCi8VanT+fRqIl5fZ38
 q5XIdZaky112if2T8JOjYlHxktM4iB0cGctn9TnKIGmnh16DwcrPAVR74XhGag2tHEVLGNbuH1j
 5/upgCgdpqm/y48UN/eKrJEriezbbA5oaTIj7SLXEYGs/Stqb1hdP4ioN2CWjZpNhIsn/C12Q7Z
 WG178ydzvYI3g
X-Received: by 2002:a05:6a21:328e:b0:243:99c8:c0d5 with SMTP id
 adf61e73a8af0-243d6dc8985mr14713418637.10.1756784866342; 
 Mon, 01 Sep 2025 20:47:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpqu2KaFNEPtydo0I6yXdgUseyT2mhe+PvCbMOgtULVHGeRck0BJOsJhzrpPxLnRtEmN4x3Q==
X-Received: by 2002:a05:6a21:328e:b0:243:99c8:c0d5 with SMTP id
 adf61e73a8af0-243d6dc8985mr14713390637.10.1756784865892; 
 Mon, 01 Sep 2025 20:47:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 20/40] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Mon,  1 Sep 2025 20:46:55 -0700
Message-Id: <20250902034715.1947718-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sGlwY-zztWe0X03cLtr8HEI70vh4WuIP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX89Cx3MZtJEW2
 YMZEtvIKrBa8+NHj+4L8bZ8CmjGM+OQjtF6nuLlQxYrtQsxRelnlZKi21tMXsviuicNKPgRJ96W
 lFgv+sQoVfCVuKMWKWND+aPEGMSte7abHFKZ0nW5TAnUVGuIuvM3Ii8k32bMXK7Jfo/2EpVrmx1
 w2UDsb3eIL32ivotVskJ8pWQXWzO6kH2mgMXt3ismbIhuUhmAav70CXHe8IP38ItjBVzXvftJ5N
 061rcyKsr25oiQZpfWlRNX+Buo2m0q4PRyAHNbmN3JrB4oUsJvV4DmPHeFqtT55CNOwBKxm5U1K
 AKZ+nJf8XJ75p4RRr0y3SgtU4jd9yBf1l1XDw8VPOVWTuSmKPWCs303TB4qdl/ukB/q5yYFUOdw
 8ANJvFiU
X-Proofpoint-ORIG-GUID: sGlwY-zztWe0X03cLtr8HEI70vh4WuIP
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b668e3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=oSs-Am0MwCqMoGAbxz0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004
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
 target/hexagon/helper.h    |  9 +++++++++
 target/hexagon/op_helper.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index f8baa599c8..fddbd99a19 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -107,3 +107,12 @@ DEF_HELPER_4(probe_noshuf_load, void, env, i32, int, int)
 DEF_HELPER_2(probe_pkt_scalar_store_s0, void, env, int)
 DEF_HELPER_2(probe_hvx_stores, void, env, int)
 DEF_HELPER_2(probe_pkt_scalar_hvx_stores, void, env, int)
+
+#if !defined(CONFIG_USER_ONLY)
+DEF_HELPER_2(sreg_read, i32, env, i32)
+DEF_HELPER_2(sreg_read_pair, i64, env, i32)
+DEF_HELPER_2(greg_read, i32, env, i32)
+DEF_HELPER_2(greg_read_pair, i64, env, i32)
+DEF_HELPER_3(sreg_write, void, env, i32, i32)
+DEF_HELPER_3(sreg_write_pair, void, env, i32, i64)
+#endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index c3140b97bd..72bb75a878 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1315,6 +1315,40 @@ void HELPER(vwhist128qm)(CPUHexagonState *env, int32_t uiV)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+void HELPER(sreg_write)(CPUHexagonState *env, uint32_t reg, uint32_t val)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(sreg_write_pair)(CPUHexagonState *env, uint32_t reg, uint64_t val)
+
+{
+    g_assert_not_reached();
+}
+
+uint32_t HELPER(sreg_read)(CPUHexagonState *env, uint32_t reg)
+{
+    g_assert_not_reached();
+}
+
+uint64_t HELPER(sreg_read_pair)(CPUHexagonState *env, uint32_t reg)
+{
+    g_assert_not_reached();
+}
+
+uint32_t HELPER(greg_read)(CPUHexagonState *env, uint32_t reg)
+{
+    g_assert_not_reached();
+}
+
+uint64_t HELPER(greg_read_pair)(CPUHexagonState *env, uint32_t reg)
+{
+    g_assert_not_reached();
+}
+#endif
+
+
 /* These macros can be referenced in the generated helper functions */
 #define warn(...) /* Nothing */
 #define fatal(...) g_assert_not_reached();
-- 
2.34.1


