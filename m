Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EBFF417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbuu-00012O-Qz; Mon, 09 Mar 2026 10:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuY-0000qs-3g
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuW-0005Fe-Ec
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:45 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EXm7r830357
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 if4CEig/W9qr3T+70sM54RDPXSz54C4WbpChDpD4mU4=; b=hHDRs29qGByw7Dz/
 vYCTte9YTYXkXLxz+f81HTuNPADs5WEc76Dc4N3l6WCFiheleGiPI2a4khrCRxE9
 MHxFpDkAqhNYgYah4QQMKhNFeYGS1AoGLACQ2v4UHddaIqMlkddtOcWJNPOlF/7e
 eDApOJAJRsW7KSrO3PyD9qc9pCNkMoQk9lschou21wynaupBo19dlizR/N6dTZNv
 wFTCTMmxL7mITmhXdUk3mrv1ScCrbqXYZHYYIY0TJrY2YzLtE94wMe1/pw6yhEu5
 VvOPaDczl+HSMxzuqfbOLMXTreVzgGIpdnxgUQ5FIz1g9iN/yBcmg42ZwnglfwYu
 gii72A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct03282b7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so11044350eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067722; x=1773672522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=if4CEig/W9qr3T+70sM54RDPXSz54C4WbpChDpD4mU4=;
 b=HAPy/zUsHKXUA0zZRYxPD4KLAYcENJmmrjzmMXhJ5y3NwQ2FEeE1SpHwjscjTjc7iq
 LomwYT7r2ZZ6viRQnAXhQHcltDD8/RBZHP/DZCWrL1Hotlh/1AdxRrnbYkA+ZnICHGIU
 sh5m7/jG6KJcmCGexk1Nivk+Z5/cpJiSZWRkZtiszKLpem+u5PPo1xnDP/gApBlOLkeP
 Z7ExJpxZ8swvJIxdaUQ6DGPGAUrP6NPCOX6MsS57UYGdlfExJU8RsXznoSkKwOlsE9ru
 7sRXMBDccEvrnee/DJD/xMBkcTrIymmEhaSrva1S3/t/vwEZywtpn2jEqFU1NFPKrEhb
 SbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067722; x=1773672522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=if4CEig/W9qr3T+70sM54RDPXSz54C4WbpChDpD4mU4=;
 b=hrHa/yGIJHF7AXd62a4aYDw0vBL0g88HduWvCX1GbRhN57yXPbq7ch0XBdSfzp56gA
 4R5k4kAXFjzYoxYorMJkekFef+1RPBxPX1W9mnytIk42e4jjsX+s/k1gWDl2X8vUJgi1
 c0l/iCo0lXF8AKAhKvxg2gSbJ2K7VOLmkV7MEJ83ZmEAtrpUiUKHi9uvtPvAAFuGyHCL
 H8TsDQzCukvn6gqgFtbB/gQpqAG6ZSNUVDouC5dB6+kxD3F+nNY7bXrGNSi/7SUmEUN7
 emW+COmjbLQfzwg3WOPICcouEiBch+bbboyIYAfL9xig2b7LsdJVnVWp16c1ZCjfMsq6
 tLDw==
X-Gm-Message-State: AOJu0YxPb1KXmN5fUZ5+5GGBZCS3snbwcRTF38ObxC/8jP7CfkoRAfKj
 xs7x5FS6QrTQvPvwZkdKAUJL5HzTH791vp48WFlKS8UKh2LELd8Z7eMrXLMBUoObaf9+wx1zSZc
 6QHtEwcoXSgs2iQrrBjqkx7TuQ9H3BDEQ6e0QqyaL6hF8mUTE8t0atgsTN9SdQzrLuw==
X-Gm-Gg: ATEYQzyWRPn7tn6WZ/tYZ8MNwvnDSZoXnrF3BbvVJi3vnmzfHOlYrW/2mHvqfYgyK3l
 cuKtqrNRsScQ0hr7eTPvYI+DvQIc5pSGDpiT4/XCvuk7s6f3w81MI3bWbukJocIroh/ITYPteHJ
 t27/8q2eYhbtoazz+drvqZ4iEYtTH4x7gjKtj50fJpq3XT8EqyDgJI1zE+ALLd9INGtPFLN2If5
 hk8Og4N9jqaW7Hvbh0MF5ToOlWjWA3JK3HvjhX14LGYxRan9DSMu4G2okBO8UdL4HXMX0ZVd2PU
 ajgAHRTu3K62Bahb8G4/zS1h3L6ofd5EQGlSXRadxr+8JM1LHDMzpszX8JSEwEpqRAX6Z5vobRs
 5b+HtYPWNWyB/g2/xoEbY2JsGKL+lLycU1YZ99uSoEpvFZrNY4r2A5SSC0INoHjRyC85f1g==
X-Received: by 2002:a05:693c:2b04:b0:2bd:fbc6:4134 with SMTP id
 5a478bee46e88-2be4e027480mr4308249eec.23.1773067721412; 
 Mon, 09 Mar 2026 07:48:41 -0700 (PDT)
X-Received: by 2002:a05:693c:2b04:b0:2bd:fbc6:4134 with SMTP id
 5a478bee46e88-2be4e027480mr4308233eec.23.1773067720898; 
 Mon, 09 Mar 2026 07:48:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 13/35] target/hexagon: Add TCG values for sreg, greg
Date: Mon,  9 Mar 2026 07:48:00 -0700
Message-Id: <20260309144822.877695-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX6LducXVDFYH8
 t1ZY8gVgEmmzQFk+LRmQnSRjqEc7ey8XlRJlmNJ3yglXSjE/Ay+8CMO5Jocxhk5lrcWNDpt4mbS
 P8xsiCmcxmKKTV+oEsv9+kegEJQ8MiCeG1cN4WNRXYLOzQC85SLU1tS3WcZopHa7ErRUJgTV+oN
 Ma5p2Pe06bJ+Uz+bCzHMIpH3VNia9lr+lWHzTeaMd1lMPTOEVxXpxv541E07geLxv5wzTbha2IC
 gHN6tbx4dcugEeOLvAVUMefB0//rHQqOvZy/KdhCpsLbEcpWKeygJpsNeldBsQkC4y8uCaSv5EK
 j71AWaWsyt6/3okZbRT9QiVwtVWX9ugVm5cPdGqtS20rYAHYgSfhT1Z+JjgeidvyBLsu15phZcL
 6pv9dDxB7l2l7cGyFEbQxnZiWPNX+NovmsAIQONElH/i4lMgS067hMQ9mACFktzHprJYxYKuLyr
 IFXhXTB8+2o9T0/wd+w==
X-Proofpoint-ORIG-GUID: 5GRPT6phIMxImrl_fYeh8WdkOQUpJgaz
X-Proofpoint-GUID: 5GRPT6phIMxImrl_fYeh8WdkOQUpJgaz
X-Authority-Analysis: v=2.4 cv=WtEm8Nfv c=1 sm=1 tr=0 ts=69aeddca cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=md9odPwznpFxaQMInv8A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/translate.h |  5 +++++
 target/hexagon/translate.c | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 2804e08ce57..40d365f4250 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -281,6 +281,11 @@ extern TCGv_i64 hex_llsc_val_i64;
 extern TCGv hex_vstore_addr[VSTORES_MAX];
 extern TCGv hex_vstore_size[VSTORES_MAX];
 extern TCGv hex_vstore_pending[VSTORES_MAX];
+#ifndef CONFIG_USER_ONLY
+extern TCGv_i32 hex_greg[NUM_GREGS];
+extern TCGv_i32 hex_t_sreg[NUM_SREGS];
+#endif
+
 
 void hex_gen_exception_end_tb(DisasContext *ctx, int excp);
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 571ba9cae41..cd6affa2f49 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -66,6 +66,8 @@ TCGv hex_vstore_size[VSTORES_MAX];
 TCGv hex_vstore_pending[VSTORES_MAX];
 
 #ifndef CONFIG_USER_ONLY
+TCGv_i32 hex_greg[NUM_GREGS];
+TCGv_i32 hex_t_sreg[NUM_SREGS];
 TCGv_i32 hex_cause_code;
 #endif
 
@@ -1099,6 +1101,20 @@ void hexagon_translate_init(void)
 
     opcode_init();
 
+#ifndef CONFIG_USER_ONLY
+    for (i = 0; i < NUM_GREGS; i++) {
+            hex_greg[i] = tcg_global_mem_new_i32(tcg_env,
+                offsetof(CPUHexagonState, greg[i]),
+                hexagon_gregnames[i]);
+    }
+    for (i = 0; i < NUM_SREGS; i++) {
+        if (i < HEX_SREG_GLB_START) {
+            hex_t_sreg[i] = tcg_global_mem_new_i32(tcg_env,
+                offsetof(CPUHexagonState, t_sreg[i]),
+                hexagon_sregnames[i]);
+        }
+    }
+#endif
     for (i = 0; i < TOTAL_PER_THREAD_REGS; i++) {
         hex_gpr[i] = tcg_global_mem_new(tcg_env,
             offsetof(CPUHexagonState, gpr[i]),
-- 
2.34.1


