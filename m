Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075F0F417EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv2-0001Pz-W9; Mon, 09 Mar 2026 10:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuq-0000yJ-NA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbun-0005IL-Ki
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:04 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629AWYlW1587840
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gUINCeXk0f+4i5ESaB5IxLA3D7qCDKEuyBi75iUr5Eg=; b=PnPdLWKdqTYk+dpA
 i+urhs/h6VIqdadVFl0SMfxC2T1qOpX1+j8iFaSCfdZsyzH/mOdKS+9Ev3sALC0R
 3cFoGwZE8RA3oZGrpSDEqHV28iZ4YPID+SNIBxMtPehFwbOMVEsZxuoJfjO0hkcI
 gmJEE0J/ZbVAaPZI7YAIZlYJY43/QhBm0geenWcaqNYdZ6Z2YlAwV+ZNGht93OTK
 Pu+M67She7gtwoEZVyS1W8uBZqbjKkaHd/TY2RUCkXklVux8zMtiGIlmDB2si1ka
 L6QOG2sqVuTAiaTly3iVqLg5LPsCIThSxpo43IRl6W16tL0IdTpWVn1ulGWA00z3
 qNMiBQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csqcy9y4d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:58 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bda35eab74so4833899eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067738; x=1773672538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUINCeXk0f+4i5ESaB5IxLA3D7qCDKEuyBi75iUr5Eg=;
 b=XAugWLYAGiSc4x/L3G43eO5Hv8WIyPWn0IM5i6J7HJ9KtwkWcesK20+GL/hhObqvNl
 PYyVnjq8GxJlsX22KzQg9u6rC2vd/pXRO59BXGk+dnRi8/Mz88rlVjEmVCvefFlHdpcO
 9dW5DLjPCK88gW4bSo/Hkk4t9nT0JL4qOG4Aif0t0XJE6Me8nRSSKoWpTZudGsqruUWg
 5IB5g3Eiaxb/VhA529sPBtf4cpjkHkGG390WLFrA0+oOdMop49p3BDVyJNyvqniFVcEM
 pKCfB3OkEPejanbYXuuul7H0bCAI0X/S4dBDxDGKefxM8PA2vD5bhjh5oU32/AOigLPj
 AYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067738; x=1773672538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gUINCeXk0f+4i5ESaB5IxLA3D7qCDKEuyBi75iUr5Eg=;
 b=hDEE3DJVHGzZvvpItLqvTwxdWOVNeDAG+16K2efEqdjndk8s6rEXzPVJoaKrMqzVvU
 1qtQbTDIOX0cu5q6qjbH+sF/9TU0edHAOcbi2Q09uALV+mGNWfLITxOOfG/c1TRdxpmk
 qF+2Ux9hCjs+PLDXtG4BcwmfH0LajrduSORlnAtJor2Rp1lVonRI+pbifeXG2S6ex7y/
 TmtAy4MpSTMOjNVvAjDL3FaSmnh9NzZTlV0CknCPlIGf7mRoDLFLLxLLD8kig5R4MHyf
 AS24fhVSa67CPpzidDXA6A52cDmJIKOW3qXLIfymOGQ7qWeoxuI0JrldBQxDihUgWuuP
 eULQ==
X-Gm-Message-State: AOJu0YykYtLELRcU32tdt08ila25W8OkkIKCzyKs45kOHT9/ADFIwPot
 PZC4BUxeVCZ5kDeMjVYGbVyn8jzyonI9U5u0GO5AVup5HYCjrsNRjIm9zZkYmx9ruTHb41Atc7x
 S0KXl9SCzxUdOtq9YqipSM6mHH+eycVNRC0QBYWNItX1RK4UrqYdX+TTi+LspoZq9Dg==
X-Gm-Gg: ATEYQzxm192kzgkxSEug4N85q+xrtm8F/iJRenTsiC1ELgTB5bJaPMGCVkGASn3MhyH
 J9VbnB56aDzGkgUGJGNPRsr/pmz6zOJNZKoX+d+DOU1X/GPcHKlwmL5JvlubvGhOIh1nxsRdy6Z
 0dGXgsQYts7/xMVsF39Xw8x3YdWwa429O8RFfWayEr2T8hKRr1c3labVx5bVd8Dh5nxaU/8g1tj
 BoIRS22O6EfBtG7/6yLIHLRBU021oyifTg6SBtFkBm3mBvxx1ioT8zZbSb3NM3P9cJyp32WbZSU
 EY39NBO3Sm9N+fR7eyXVdz9whjgZ2EJT2OalDrL2U1foeWUB0rlBQWf3qmN3HH30CwE/4Of1wC3
 If8mgHOk13wEDwR3mDZRjPO9oOAgQrqAT/3eDAEUgjKYbaMflDtVh+m0QjR77kn/NFSAysQ==
X-Received: by 2002:a05:7300:3720:b0:2ba:9cc4:aebb with SMTP id
 5a478bee46e88-2be4e693c27mr4078003eec.10.1773067737319; 
 Mon, 09 Mar 2026 07:48:57 -0700 (PDT)
X-Received: by 2002:a05:7300:3720:b0:2ba:9cc4:aebb with SMTP id
 5a478bee46e88-2be4e693c27mr4077966eec.10.1773067736651; 
 Mon, 09 Mar 2026 07:48:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 27/35] target/hexagon: Add TCG overrides for thread ctl
Date: Mon,  9 Mar 2026 07:48:14 -0700
Message-Id: <20260309144822.877695-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXzWM0V8R7NxMO
 UAWT7TUQcd5cZ+nGIPKB9fbP8XWRNoAPVp/9rmSYv9E62QDLhU5EzsIYaWC5lwELMEEVTx1JfuU
 ChN3dGHNEZyZqT42rdTfMsDf1ax52zgob4zEZ1QIixe4giOWY45oWx5cCjJyb0nngIj2ADctvl0
 T1RLYlm/+rPd0Wecyj0cMsSWJxIZkKo7tYVgXf/RhNyUMIAxCod3CrWe+TaLnxUNcTrPy+FFJkG
 EbtlxDzcvGk8zTa+P9xDLpaK7zo3z1upvhrFOcORjwUSDSEZjVxGV0j8E7AGE5nKT0aIoXZ5c0i
 19diUCn4NK1rsUN+trgSSKYVd16UXAt3E/oj+FFTFClm13J0UiAOsZwiPlddC3KAnYnPJYtAu1S
 eIfxnU/FKdjUCC0y5ZXP1BA3vXboWK+b1sVbfeFYSn7YbYaI5OHIUydJXAR3GrxR63vt6M5nojG
 mr4UyTQONM8n0oI9dJg==
X-Authority-Analysis: v=2.4 cv=QJtlhwLL c=1 sm=1 tr=0 ts=69aeddda cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t9Y8JitlK4h6-XB8aEcA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: miz1_d91mJuuRNLhV99ICQf0TDg1_6dZ
X-Proofpoint-GUID: miz1_d91mJuuRNLhV99ICQf0TDg1_6dZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090133
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

Define TCG overrides for start, stop, wait, resume instructions.


Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_tcg_sys.h | 18 ++++++++++++++++++
 target/hexagon/helper.h      |  4 ++++
 target/hexagon/op_helper.c   | 20 ++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index 7f223ff3884..0453e3bb2c4 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -62,4 +62,22 @@
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
index 955287133e4..682f0c6c26e 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -123,4 +123,8 @@ DEF_HELPER_2(greg_read, i32, env, i32)
 DEF_HELPER_2(greg_read_pair, i64, env, i32)
 DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
 DEF_HELPER_3(setprio, void, env, i32, i32)
+DEF_HELPER_2(start, void, env, i32)
+DEF_HELPER_1(stop, void, env)
+DEF_HELPER_2(wait, void, env, i32)
+DEF_HELPER_2(resume, void, env, i32)
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index bb47b090113..69b41ef1196 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1417,6 +1417,26 @@ uint32_t HELPER(iassignr)(CPUHexagonState *env, uint32_t src)
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


