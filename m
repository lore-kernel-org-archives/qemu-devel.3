Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306A8F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbut-00011B-La; Mon, 09 Mar 2026 10:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbun-0000wX-SJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbul-0005GR-7f
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6298WAJh3773176
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OqE5bWyqVOMH2287utgcd5+0zOoEy0K6PwtAnHO2baM=; b=cdaJRyh86QuxAPgk
 GqxYrGW8r/ehrfKPdobgtnytzyVBpf1U56vt82+CcG6rJ86gHHLMV6tYtdVQSwEE
 CX+Vyy4n6JDLyLVzPeOkH8RIRKkk5GekokeZT9G470lQiVqf75PR0HrjPoOcbII4
 cABQKt3+0FlRyS0ti4Cgp2WRJootxJ8wUl7AhjsU+CguOCv38ku9K8wcQa4Bz+fL
 RxPHexhDFqrcpfpESjfXkzmCsvc+AJWk9uqcSj7oiSIJYerHhTWCbhp5ncanMxkc
 fPDeyRzvRRMDKQbk18qcv29nXVPNPDQhkmzMXMjIQu1B+R02mpoD4Q2wqMSJeZfK
 iYI6zg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cstsa98eg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2be47f2899aso47129340eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067727; x=1773672527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqE5bWyqVOMH2287utgcd5+0zOoEy0K6PwtAnHO2baM=;
 b=ejlQsbD2jVhvn1m0B7yYNTo6kxqaI9m7Y5PHnveSd6QiVQBv7d51uylCSpGRtdtQEv
 tx0JPGFT01JULWNoH3JtvkFU6h8ZJHhU1XO2AESWxgFogrEWn6xCm1wqnK9dIV+myiEe
 xgTaO4Ty0D9KxU96Fg+qV6vkZoTWECnMDNHWm57dG+5tqt78/U1CFxFwSbjQ2pqK+oLw
 9+Ki3UZhostxC2WSk5Yx9Vz/LoVjJtmps7iZO3Gd3FxYipP33K+6eHPFECPdysBqUxoM
 IJMHoesywq2/v+yvxBkS06d0ni4YxeZ5ovJTGFq4RQ6xWVHzVxgoTprtP4ghjQu9jCpG
 e+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067727; x=1773672527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OqE5bWyqVOMH2287utgcd5+0zOoEy0K6PwtAnHO2baM=;
 b=B3ewhPAEag4rvedTtkGguTovVQrxEcnqfa9WP03h4MOVddAGo4djHAg/SBLDbKy6bm
 BDiw++iGdekasnfLAf+DzHajMx6s3FiWcX38exwuKAG7wIi0XZNBuBCn2m6TrNbqm0PP
 9u8MdbXjRXoHpnOw9/j0vycs5+bZWvp3Uj0m3gc/02cZmcLWSOh6WiAX2/qjVaRV3vt+
 BW94in9vgfl3tEJuaFg04VMCfihEfrR3litWosLdM+2SykHM0k87emyap/+9pnzZ796T
 8ORBSlK+o/P2QVrKxPj6Nyh5yOSdaleh874V3NhKxMX5pqhyaaZ4gtIm2STOFge2n4tP
 Ld9g==
X-Gm-Message-State: AOJu0YwzYkEbM2hXVBRaR6S2e4Cgn6Zq0dusKrkAg5V6e8vYRE8oo+l7
 IVAn/Rn2dGegm1ljX4fXDKsXU4NrvqP27wtygj3INhMxNh8pyvXBqHvPjr3nrs/M+VuRGH7AQVE
 3IigTU0MAybwgTsvqm5TLMC3Mv7BzfWKJ+V1AOLmOnXkTP6wr2U5X33ZUa0Yw/eUIBQ==
X-Gm-Gg: ATEYQzxs7N8QlcEz1iIrjQ6Iq9U3q+TDIKMknnZ7Lnnk06hvp2DhlBLWYYUNgFeQq7S
 Xea4tAwGhw0jV7xtl4AnqbWY4E0S6Asd7n2/n01fuMg01qD9uG0F/T+ismIugeeb6HgfbB2zzaz
 5riqV6F47aibZwNAQS+7FPS2XjSjWZV1GRaR9YOpWiT3bKHJoC2vZsyQEQoOqWEzGlnJSUXO97y
 e7OkSYuzbrYZ2cifKXykxgJcp3J0n5HKHgWhNoNbrnbLnq+LM9dK9HEBS6235LLotAsJsrC4oQl
 KfSw9e1YHykrYkYTJOPtQrZwjMcfZfrrrvEPdiKKNmceKW7NcIYTylhjmzrcrrCkW1QTbEm21ic
 wCczpEjMRGV5ByHKoBcwA5hJtDv96aQXpFzY33IEEzflfB+Mc0R9QFE9M4aJo1r67c6GHVw==
X-Received: by 2002:a05:7301:3f07:b0:2be:fe8:8afc with SMTP id
 5a478bee46e88-2be4e05bb27mr4566674eec.27.1773067727165; 
 Mon, 09 Mar 2026 07:48:47 -0700 (PDT)
X-Received: by 2002:a05:7301:3f07:b0:2be:fe8:8afc with SMTP id
 5a478bee46e88-2be4e05bb27mr4566650eec.27.1773067726609; 
 Mon, 09 Mar 2026 07:48:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 18/35] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Mon,  9 Mar 2026 07:48:05 -0700
Message-Id: <20260309144822.877695-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Gs_9TiqMpRG0Zg4GmuKc92jHZw8WEpu3
X-Authority-Analysis: v=2.4 cv=I+Vohdgg c=1 sm=1 tr=0 ts=69aeddd0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wA0rHRt5QP8iJxr38i8A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXzyzNjdpphfxw
 Ap8varo+KQyvGLt18Ggdw74N7NFzwtp0KiCLRtRB0jg4XxEtNtdElVN1Z1rL1XJk3g8e7eaReb3
 1OmFnpCYA/3/XTY8lo1Vdf9zK1GU2R0xXoBP9r4BKAsSmH3xDyZiZ7tMlCgl1KJ3vj77RceDk3H
 ATe7enyzDwxTtUPJ0R5XOYCk8BSbfO+XX0ZeeeOTIu3ClKBVXsAHCIAsuHbaQmIkXU5dcRzd47U
 vVwSstbwgduaGedy0eobe6l8pOagG+4yB8H05MqK15+IwynGHcwa5lW0wQ1bI9s3gKcBEicJttC
 6xtaRywU98CuGb04LTs9ptJUnCDzeA43iOh+Il3XjZI2uv1MVEovZBIjDi8bRyKXMojHT57XVd4
 dJVju24RCCVl0STbPcaGhkbKsrP5Mm29C7cumZha/YjvOw8m1hLjwCpMZ61HsdAttKCaLOJnKI5
 tklF5k5yCQrV+DOZRlA==
X-Proofpoint-ORIG-GUID: Gs_9TiqMpRG0Zg4GmuKc92jHZw8WEpu3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/helper.h    |  8 ++++++++
 target/hexagon/op_helper.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 64456822bc1..28b9b59e0f2 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -107,3 +107,11 @@ DEF_HELPER_4(probe_noshuf_load, void, env, i32, int, int)
 DEF_HELPER_2(probe_pkt_scalar_store_s0, void, env, int)
 DEF_HELPER_2(probe_hvx_stores, void, env, int)
 DEF_HELPER_2(probe_pkt_scalar_hvx_stores, void, env, int)
+
+#if !defined(CONFIG_USER_ONLY)
+DEF_HELPER_2(sreg_read, i32, env, i32)
+DEF_HELPER_2(sreg_read_pair, i64, env, i32)
+DEF_HELPER_2(greg_read, i32, env, i32)
+DEF_HELPER_2(greg_read_pair, i64, env, i32)
+DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
+#endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 39f0c0445d6..4db38d8eff2 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1370,6 +1370,34 @@ void HELPER(vwhist128qm)(CPUHexagonState *env, int32_t uiV)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+void HELPER(sreg_write_masked)(CPUHexagonState *env, uint32_t reg, uint32_t val)
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


