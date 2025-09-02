Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15596CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1w-0005Zd-Ot; Mon, 01 Sep 2025 23:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1o-0004uE-SF
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1n-0004h5-1L
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:52 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SMPO021885
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LKbDsVtkNa9fudbo/M95wP/WPuYwdkcECdTm6exGrug=; b=ZnPZy1iN/BQriJsk
 dFNq0wlDURXKKtzfqY8bBgIVSXjVcnz7C9RT2nAVCQYS1Vmi9U75zTGvraqCct0W
 4yQY4u8gDZjBoPJ+BfkSEWBZr+B0A2cvn6jdTEczF4H1sl827KHRCjWNOizgCbzS
 X8pT5vcG/F6Xj1n41CiAX3pd0hF8dgpxbpXDoHJjmONWfl4pYTNzW+6JKZNapmZq
 jVHqWieZ0inTkMVdExK78hdg9oysSdSJ6W55xpZysl2J4Q0zo1B2EuvoGXwCFEAY
 iCYfXrI6+61/I5MC44ro7dyaQHekllOP+Ea8h50aR7A845FqQfZtSXXnDh4mTYIh
 soQzQw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8rxf6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-329745d6960so2489720a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784978; x=1757389778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKbDsVtkNa9fudbo/M95wP/WPuYwdkcECdTm6exGrug=;
 b=hbd6LzcNGI14kBee3q86cbLWPhuXIgmXQkb2auAoouJF6UT1rdSrXRDhlr+ojthCPO
 pyjmP9iKitNrgb/zqMWMW1Y+tnXSO6A7bz84IJw/UbQBhmV0eZYXHgZxLfGlS6F0ha+e
 RRUgV4uiBrh/HEHrItlJctlWPTll9CLiivzzWOso7ZqO14CBiILTjl//U7kWy5uhJlvV
 MMW+rO+GXcWYTEAOOjFG1Y47YAOSZru/+iwVmgHLRE9+h0SlSsQF+3e/pq0KYcOA/F5a
 qVwK12sdkw+Pu2WTYvFGij3DSEA0nVNa4+6OxsP3gxbDLmEUPsUMaFvB6jtTu1TaTA7y
 3U/w==
X-Gm-Message-State: AOJu0YzaX9A5JoWhpWQQSobFqRTmAZPL3oMuHjgyKsVodWlUy4HWiIOz
 gg2aT/VbGbEvZZXsvo5GpW/jazyt5zEBJzAiyoS8uTt5Hh+TyRDSkCbo5N7biBtnLR69JaFNa/E
 vR+cO84jUOyx+eNMDdwDpv9GWr/PzCalLGPQ+WNn9ZY9AJBZu/PAumNq9BnXuQTPf0L3C
X-Gm-Gg: ASbGnctq6Fu5TY/fUZP8Wwyvf9dfBiMRNbqitfo1p650LVE8U3rqn4Gt6iNX7jOyeoQ
 WR/KmJO/Hq/n/LtqeamK3ZQHfi+rAUhfraoPUgZ5ybI7RvekP7FaqVKfZQk1dcCeBgIvr8lkQKx
 wFkPGEjqHij9LF0FQm1p4LOcYsE2eWwz9EReLzS+eDslmaAslOz2zUjEejqRuU5daYGqWe10DQP
 dozIiBFClcRAWcX8KAb0EskDLD52vglOlGtCBvelKgyg5/P2O+PnVhzIsUk/Bf7LseLWPyYVc/g
 s1R8oihzvhpCyEWEceKriZhCtVH5OwfTFuaSEPKmPX6g0L53nLxQEW88WwwWydu3TxKX5zOCeDP
 ZPbqJxPjTmIPY
X-Received: by 2002:a17:90b:5865:b0:313:1c7b:fc62 with SMTP id
 98e67ed59e1d1-328156c62c2mr11299070a91.22.1756784978408; 
 Mon, 01 Sep 2025 20:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG90l+nDW6UzaW4w3jnpMjo21OvrdSmm41pPQvOJ9m13Cill9c+EBeQc7owo6hB7cgwc3UF7A==
X-Received: by 2002:a17:90b:5865:b0:313:1c7b:fc62 with SMTP id
 98e67ed59e1d1-328156c62c2mr11299047a91.22.1756784977922; 
 Mon, 01 Sep 2025 20:49:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH v2 38/39] target/hexagon: Add guest reg reading functionality
Date: Mon,  1 Sep 2025 20:48:46 -0700
Message-Id: <20250902034847.1948010-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX5UjOvxtXq3x2
 pmeA+gfniydDGRhvHffSAocDLLoEwPqiVOkztJ/qBUcrhR0c8BwXo5bTQG0KdG9+AF4kDWZrrZ9
 IwJ4wbBlULV0RlOv/nbi4Fsmbgii+bcplS/Y7TBfZD3qd7XzzPEEQ21U1usIyC37knnKKepg7gU
 usaJJMAeSf4jcBaXCFPmHt5fPx7S6vjs0qMY++rHNCDaUaBHJjJuxmmW04GEofRCyAcdcCX9mns
 YHaOcTERSjFXmIdJo09hPxWRsp6nCe2bYJjilUbf2Nxnpjbk7Xmhz+HOlAEmFyX/jeNr+pSPgqo
 5X1wq8SKemjIoDm6J1hlFzkP/CVtT8zuMPwPn/JNT5+UfzIMDWON1cAKXbyMD/DHeCSZqAfSbnT
 TBuPeVXF
X-Proofpoint-GUID: ukp_NONtHRSRORgf9hpa2ddxiGoixv1X
X-Proofpoint-ORIG-GUID: ukp_NONtHRSRORgf9hpa2ddxiGoixv1X
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b66953 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=R0ySI1B19UU8Iy5bGTEA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019
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

From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 target/hexagon/cpu.c       | 19 ++++++++++++++++++-
 target/hexagon/op_helper.c | 19 +++++++++++++++++--
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 122761e657..751ba613cc 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -778,7 +778,24 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
 #ifndef CONFIG_USER_ONLY
 uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg)
 {
-    g_assert_not_reached();
+    target_ulong ssr = arch_get_system_reg(env, HEX_SREG_SSR);
+    int ssr_ce = GET_SSR_FIELD(SSR_CE, ssr);
+
+    if (reg <= HEX_GREG_G3) {
+        return env->greg[reg];
+    }
+    switch (reg) {
+    case HEX_GREG_GPCYCLELO:
+        return ssr_ce ? hexagon_get_sys_pcycle_count_low(env) : 0;
+
+    case HEX_GREG_GPCYCLEHI:
+        return ssr_ce ? hexagon_get_sys_pcycle_count_high(env) : 0;
+
+    default:
+        qemu_log_mask(LOG_UNIMP, "reading greg %" PRId32
+                " not yet supported.\n", reg);
+        return 0;
+    }
 }
 #endif
 
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 6783e1e7d1..1bc32769c6 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1927,13 +1927,28 @@ uint64_t HELPER(sreg_read_pair)(CPUHexagonState *env, uint32_t reg)
 }
 
 uint32_t HELPER(greg_read)(CPUHexagonState *env, uint32_t reg)
+
 {
-    g_assert_not_reached();
+    return hexagon_greg_read(env, reg);
 }
 
 uint64_t HELPER(greg_read_pair)(CPUHexagonState *env, uint32_t reg)
+
 {
-    g_assert_not_reached();
+    if (reg == HEX_GREG_G0 || reg == HEX_GREG_G2) {
+        return (uint64_t)(env->greg[reg]) |
+               (((uint64_t)(env->greg[reg + 1])) << 32);
+    }
+    switch (reg) {
+    case HEX_GREG_GPCYCLELO: {
+        target_ulong ssr = arch_get_system_reg(env, HEX_SREG_SSR);
+        int ssr_ce = GET_SSR_FIELD(SSR_CE, ssr);
+        return ssr_ce ? hexagon_get_sys_pcycle_count(env) : 0;
+    }
+    default:
+        return (uint64_t)hexagon_greg_read(env, reg) |
+               ((uint64_t)(hexagon_greg_read(env, reg + 1)) << 32);
+    }
 }
 
 void HELPER(setprio)(CPUHexagonState *env, uint32_t thread, uint32_t prio)
-- 
2.34.1


