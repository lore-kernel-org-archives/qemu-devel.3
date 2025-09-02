Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD148CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1f-0003me-4Y; Mon, 01 Sep 2025 23:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1c-0003WY-PK
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1b-0004ee-27
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:40 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S9g0030176
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PV4iW4lWrufS2Wd6cGIX4QwBDeoO018DLJefWyOeZgg=; b=GXacjumFRcu3kurk
 v6sizDE1htHwKdHRWafGdootVwG8kGTqOGFMzs88oeRKBAno10DOph92SwtdwAXk
 XomJD0m7ZPcFPM9PuaZszkDL0+H3A+90rkQ4Rvq2UqXmgLqHCsjuotxvLvO5WRHe
 EvxkCNmsqRbVPRRsYISLDlimMvJ5CvWrtTz2iUeNei/u9NM+ukKImlkfHGrWO4Ps
 HQbyu1GbKv4I2BjRz9n7EPjjFIhsjMfcrV/TAhYOYRUYQD8Mn7HJ9s3dqs2y1UJP
 haE/hEhIxhgagMhBoKCumR2tmTvUCAlJ9s0HjYsZnt0IHbTbEybMZKWUOnv8btFb
 h7xWuA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy26t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-329e1e3b25bso318456a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784966; x=1757389766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PV4iW4lWrufS2Wd6cGIX4QwBDeoO018DLJefWyOeZgg=;
 b=ZiV4W+4yRqalbl5qmkf2LfQxJsMJL1JQEbOiRpwrQBar7i3ciV557F+g3VaN/5YGxf
 k0u180c+u7aKGuDrc8AT/ohIzoi34hSrXbMr8wYAe1+yh+01yqcksK6FHk+dWdyGQ/7K
 pBVXZ4D0oXnaQHEDu1+HRh30nvJlaxoZ3bMpMG3V1Q+M/diUUDecUNLEinGteVdNlryW
 OpbLBa1MHzcrHyHdktKB9ZfZATZ4fZ0iUkb/cr9pHH4ueH1RWBXvN/qCtbK2aOVZq3XG
 jX777iy/fsS5lQCyC+odXziBk453aClOf9uaq63VSWLuNPj6t+VidHpLkIgrQn7mU+Sy
 LgtA==
X-Gm-Message-State: AOJu0YxGFlpuSKbDAEA6gryaUlS3UXC4JZ7lV50j1txbOydncVW68FAA
 ZakcXD7tUxUahWLL/4yVwFBL7T2RwBrmgIImujhTwLc1+YvKr6NhXLAQfTP8Wxloc+yv3SC6Fjb
 r2YZ2AxE9C5J5Ds4AbeMw25UFReS+ePlfddKNAGNWHbuob+/s/pX6whUz3f4/bj1KHzeC
X-Gm-Gg: ASbGncvsTaHvJ1L7Sj5B0HGfx6R7KBYL2nqoszOaWPUsMFXgvOsXKPz/yu4CiGkEhMs
 V8t9GBLyQA+yHATUAVBM8mg3Pk6zZsIchGs/eWkqTAj1lm3zaEPOe49nFXp0oJYLFziQ3Yq/VI9
 /wyA3D2S1gd/oSC1MOTlq1fd3MnbgvmnN0P0d7EGgy0aJABWk3fKZKsjuc4+581lnTcdT4s2GiC
 DHU6wizY844okmvVFVG+d7ih2IeZW5KAKC6FqaZXIwZkCnQXg9wsyj5DxsoRMdxLhc2hVz8KMuS
 R6ictGeDDDixCnChHibQxIgqvWiXbuB4Oo0i6uomD4bmtaFSUgNQ/dR/6eEYs6gdfrYTo5EnVF9
 nfYMMOHhYfCU2
X-Received: by 2002:a17:90b:3148:b0:327:4d3b:fc46 with SMTP id
 98e67ed59e1d1-328156b9261mr16019538a91.17.1756784966365; 
 Mon, 01 Sep 2025 20:49:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbvw8midtoHXzul8d4qPx6mM/0Vvc2t1/zHwW8c4ELwlYuBaD9mQzKx0mmJyxJs8SKPj4O9g==
X-Received: by 2002:a17:90b:3148:b0:327:4d3b:fc46 with SMTP id
 98e67ed59e1d1-328156b9261mr16019478a91.17.1756784965646; 
 Mon, 01 Sep 2025 20:49:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 28/39] target/hexagon: Implement modify_ssr, resched,
 pending_interrupt
Date: Mon,  1 Sep 2025 20:48:36 -0700
Message-Id: <20250902034847.1948010-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b66947 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=w_Ktf-yQGdqK2aTfpWsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VDb6T2Ku0K6T0fOBcqG6Z5CDkDM_3MVW
X-Proofpoint-ORIG-GUID: VDb6T2Ku0K6T0fOBcqG6Z5CDkDM_3MVW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX/eae60zKazzg
 mudt90RZgp2Joe+NtbNtISQSbgpq3p/Qn9RqcAzTD+kyJUSkgsLyKDQblt06saS8F+qPcizbf58
 1lyqVUR9scN0UasqGqp5in+Bf2+PsQ0UMDIY8wJGhQ55+e2Bay+Rx3NLqnbJOF2KbsklRSIh2So
 g9W3+dXkdAD13Ww0fw3IPAwIvuzy0Zgamik8Eq/lbzRFsLU3ZDqDTbLoYnyLRiL+1EQ3J5gRyxC
 k8ymqQQJf99BpWv4SJ8CB5EDJHU1qnjso1oAQBK2NUwFm6sSYzYneLldhnogRanXoGjS6gBXues
 dRgfzIrikLt6XmyKnhWHFO0QINEjvFDlcwR2roxNlynSqL8knK2jZ4V6uPr2iRwZYfCGsBtvltX
 Ril3giT6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
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
 target/hexagon/helper.h    |  5 +++++
 target/hexagon/op_helper.c | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 730eaf8b9a..e107d74609 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -129,4 +129,9 @@ DEF_HELPER_1(stop, void, env)
 DEF_HELPER_2(wait, void, env, i32)
 DEF_HELPER_2(resume, void, env, i32)
 DEF_HELPER_2(nmi, void, env, i32)
+DEF_HELPER_1(resched, void, env)
+DEF_HELPER_3(modify_ssr, void, env, i32, i32)
+DEF_HELPER_1(pending_interrupt, void, env)
+DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
+DEF_HELPER_3(sreg_write_pair_masked, void, env, i32, i64)
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 5196226f02..e283c5c809 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1180,6 +1180,15 @@ float64 HELPER(dfmpyhh)(CPUHexagonState *env, float64 RxxV,
     return RxxV;
 }
 
+#ifndef CONFIG_USER_ONLY
+void HELPER(modify_ssr)(CPUHexagonState *env, uint32_t new, uint32_t old)
+{
+    BQL_LOCK_GUARD();
+    hexagon_modify_ssr(env, new, old);
+}
+#endif
+
+
 /* Histogram instructions */
 
 void HELPER(vhist)(CPUHexagonState *env)
@@ -1523,6 +1532,11 @@ static inline QEMU_ALWAYS_INLINE void resched(CPUHexagonState *env)
     }
 }
 
+void HELPER(resched)(CPUHexagonState *env)
+{
+    resched(env);
+}
+
 void HELPER(wait)(CPUHexagonState *env, target_ulong PC)
 {
     BQL_LOCK_GUARD();
@@ -1844,6 +1858,12 @@ void HELPER(nmi)(CPUHexagonState *env, uint32_t thread_mask)
 {
     g_assert_not_reached();
 }
+
+void HELPER(pending_interrupt)(CPUHexagonState *env)
+{
+    BQL_LOCK_GUARD();
+    hex_interrupt_update(env);
+}
 #endif
 
 
-- 
2.34.1


