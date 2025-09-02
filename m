Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A020CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1p-0004xx-KW; Mon, 01 Sep 2025 23:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1l-0004cs-HP
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1i-0004fz-76
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rv3P029695
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AH6fpokvciXoPtKOjc0f6fIGfoz3joRI6xzaLDYXcGI=; b=HVPjAzDsAm6d2ECs
 ZMGHhe8PqSqcYW82yp6kggIO85+bFdFlTEaGMaQWNnjbq8la+HWN40X44m0aQTPj
 tQuDytsBtUJYCB3+t7d6N9QnCGJu+h7IqSSC6u7WZglazhsbM6ofWdH+uFiHVY8P
 RTK/FEgxzX2vSC8r1/lH8tO+agCWWjap/b3VGBT8H5Z9ELvYo4k++CnJHDQr3Msb
 gi6BYAY2Uhz53lC/BWyfoueLsbfe1ZXKKb9GCHgze9M8PYXhOAdbhGymdvqqkLNG
 E5Gyd5zeJx7/S0lYM4+/UYie164EUeN7d4ZXvx1PkNKw/LduH4fjNlaNQumluEhA
 dqijqQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8pc43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-248981c02cfso53818505ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784973; x=1757389773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AH6fpokvciXoPtKOjc0f6fIGfoz3joRI6xzaLDYXcGI=;
 b=ht3E9yYQbRgnNLc5NMTUaH1U+mTKo0GBP0yMRjpL/OAt0LQfFJmBLGhn0nKd1cKrGX
 QHX5jB+N2kiDBVVOiEOqIGWBsnjB26RjTU3tl+TdjA1FxFcFOoZZcJlIoMS7EhvLdJ4c
 rnwoS81Orl5Ljeo90fk571tLxBwSqMWeEDf8Bm4gZONhvBpdTr8Ngz9pW9olG2W9N4Nv
 5DZW3WbTxu/XR+gA0ilUSB28j8WKBfoB/0RwRPq9drwijmXuzepcVP9DDrNQN0Og3SV8
 nIjfH3HSTa9Gr4Qd3w91x0kblY9YTNXDwCYVC5F/J7NdVqYjSahOMyt8y/S5SGaAIlL4
 5bSw==
X-Gm-Message-State: AOJu0YxmRyrpmdx+/luQuK8vyqz78mJ2c/NNOZllrhk7RUguvKkjaN7t
 wYl2UJJHDGMG8/UAz9RDAcL31Juagu9QMyA8BmccaqCYuvJwde6Ya6WEQdMPIqYb5vdIX88DQ8r
 10Dz9BOU8xZW203KqwMVD6Op/fwUIvJoepQrgV/QoL8DC9tXae/V8GkYSLWfwxqWFNyp4
X-Gm-Gg: ASbGncsTbGJnOdGRV2nZ8iIRMvOUG02KLDqI/hhr5/Kvdd1nMdDbZYB4ZDsiH9h+f/C
 enQKjCsfSJI3urPOCe6Mbqnsn6MRda8WjPEcoj3zdgZH5W9nbOSjc9a+6nuSW6jVgoUNuSTGYvQ
 GCa+ysbWbbDVu1sh+4RfTQhalYXWNswlZ/EGHo2UPUNBSdS8bqfwci4KtmB6B8tthqRD1InP3Aq
 ierpMY04Kkj9Hb4dQSOzYh18SYP0LhEDmQmtOjl/8S5QLRILwsRSbefIsw39md7E5A/D9o87qFy
 JUJZK10GNlLvseaK7Jdi1QP+2Rfe7IWLFxSgOPmO4t5+gbru0MUxAbmw/41jNgSCEjwo67sID0J
 OlSc/lPMW07MG
X-Received: by 2002:a17:903:1d2:b0:246:22e3:6a2a with SMTP id
 d9443c01a7336-249448ad91dmr138386655ad.15.1756784972758; 
 Mon, 01 Sep 2025 20:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5QoMsunnYH4fu8IowCMn/GAqlddIHrIyI3yeqcwnG3Ov1z6RXjTAEzquFscr05TxlqcR+Dg==
X-Received: by 2002:a17:903:1d2:b0:246:22e3:6a2a with SMTP id
 d9443c01a7336-249448ad91dmr138386445ad.15.1756784972327; 
 Mon, 01 Sep 2025 20:49:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 33/39] target/hexagon: initialize sys/guest reg TCGvs
Date: Mon,  1 Sep 2025 20:48:41 -0700
Message-Id: <20250902034847.1948010-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OnUtbNHz8gdQSdpiL9S6lvKqvbNv_Xsf
X-Proofpoint-GUID: OnUtbNHz8gdQSdpiL9S6lvKqvbNv_Xsf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXw/iUOOagKI6Q
 pqubgcUnlx7rFIUdgQt0IYGozGeEgvAlPC3419aAV5xAwKvlTu8N3UJI0hOlxv0tloCYHXagf3D
 mUa+Tqg8ZGSl5KQ36IxQWKHm3UEKbBXgspqm/4EgI1DMjJDSYIuzf/kWfVDVFjnwkY/jHq68WhK
 8XualGCBczgFtFLS0Ff9hPnvvjIVHEYwXffueN4wGQCVf5L0PUucoMsgCoudDmdCD4YlsNGf40e
 tddzCBKOsaQmaQUxGf8IbY7Mh/UK3bGUl0Y6TW9oPuXgTBsFRVoyZwk63l2HjVHWDebq3ReLmYz
 Wn6BAS6SclFk9pwp/mEGBnB8aPkkZphdU9UiXHIeV5npopeyBq1NC7J47lHzCMmcE8t54P/ItNx
 VOkU5skk
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b6694e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=XKwcXZh5TvB60uggK-cA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020
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

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/translate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 743c96e6e1..01a236d108 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1287,6 +1287,20 @@ void hexagon_translate_init(void)
 
     opcode_init();
 
+#ifndef CONFIG_USER_ONLY
+    for (i = 0; i < NUM_GREGS; i++) {
+            hex_greg[i] = tcg_global_mem_new(tcg_env,
+                offsetof(CPUHexagonState, greg[i]),
+                hexagon_gregnames[i]);
+    }
+    for (i = 0; i < NUM_SREGS; i++) {
+        if (i < HEX_SREG_GLB_START) {
+            hex_t_sreg[i] = tcg_global_mem_new(tcg_env,
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


