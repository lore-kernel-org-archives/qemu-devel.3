Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0A4CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1M-000238-1Q; Mon, 01 Sep 2025 23:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1H-0001fm-SH
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1F-0004bx-WE
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rtat015204
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DeCqlDgJAXTo+PaUiPidkJbRyZUMTQWsHiSFXAV1d2g=; b=AUMeTXN2bgsnxt35
 LHRVQ6snY7TuDg6lrn1LeV/vh+MIrActZ0Hc5Zh+dsXM8HE6wiiDIjiHW0j51kxg
 jHhjWm2bdIiAGS/etpzKqcP7Og5O/ithGgPUwIV2NOOyuqXcHhZHPSC+9XEUK1rD
 0r67IoP3lAeukJyc0SqEHKoUpfsYynAOPcYBdQVoyFkf06b4ma1by1d35nTsIBLp
 IZcfPajJhz+AixdAgDCbVGLhqwhsfdBhm2xapJXTZm/GqFNfLaQit9aoiMXwWtoT
 DVlcxps2mxBj6H6IoqwhnyT5rHpNYZ/lDQijdu+lQuQv5bJFpEPJfAnJ53alNAH5
 uXdN8g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxdjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-325ce108e16so7459106a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784945; x=1757389745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DeCqlDgJAXTo+PaUiPidkJbRyZUMTQWsHiSFXAV1d2g=;
 b=v/078aJ/qlIUzf71nJjPMcEA0BZg3lZDS4YsKx6RmRvecmQrKi5D5jC6geffXMYyug
 zlLTj4mVg2FiYY1vRGfNjQnL2UdFgNDm3sjd59X3m+QnPnI6DeslxbNU0OyfARVWhppJ
 d/QdoC70KNzTulu51IJdMMaLpUWDbh47jw1kpku72pFGUxjLJemauRX4LYnmcQTGOwQm
 mC+CdWfygW6XUiU9yleCNJzK8btw1pI51rg9pIdoAEpemnySKgk99NRnK209leknpGCl
 00gmBtLW6AJmBY3ywuGgZfV6lmlCBztz7yQ86GOIoyRhmnk1mwZZ0UrbtOcYDcE216Ug
 elFw==
X-Gm-Message-State: AOJu0Yyb7Lm7FG2jep5Jt/FU5Y4+N2JOarARN3quXNgASby8/DGYSMvE
 Tzp6/3ALd3lq97fxsYKQY1iaaiwo3m+iKrDSBgGtwyU+g5f4AoPgiM49cPWhnr24PvGpM0ZbaRY
 WtwGTsAB5h5QX+YAan6lFZm0OBh37A5D7mH6xSrM0ho8sh8QsuJ/JxmXhf8msbzXQzVh0
X-Gm-Gg: ASbGncuaDghIyLNkcnC/0KWw74N8Z63dlzY9DDlaqPUhS4DcrhlQnJurdgdxR/Vbpgw
 GKVqj25zD9hpHmzdNJNnYUYNrPDfL4fgjfdjoVUSFr6qMez/ZRAg+qy/Cv2jaTg6EAE6KOhfW7q
 N6zaC0v94Yn28ArNU77zrsI8KQfGrdah1l8o35tHFh/N0O1aGgdKS7TFqpL+tCRn78Bue22dc5P
 pFpS7Sel4Xn3BWLhPpdIVhFtUD7KoGQwnssQ/FiIC+VQsig29WPAQfjYYG+ZwCrz6eVyR+86tQz
 89+GcKQJlTAVNG85GxTUg2Jl3A1CNxa3j3WIqr+Ib+xQrZGpgc5KdAqzEuZNd5nrlH8AtxM1lfz
 l9VAgU7ALLMjE
X-Received: by 2002:a17:90b:3148:b0:327:5360:5b1a with SMTP id
 98e67ed59e1d1-3281570ba17mr15276046a91.37.1756784945584; 
 Mon, 01 Sep 2025 20:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj4Z5U+aPlc7Bz4dugjyzvyP/RtsoSvrM0+mWWq+CCfXGmw1ZNZDkCz/dA6ZykvE8bMfBkww==
X-Received: by 2002:a17:90b:3148:b0:327:5360:5b1a with SMTP id
 98e67ed59e1d1-3281570ba17mr15276011a91.37.1756784945100; 
 Mon, 01 Sep 2025 20:49:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 11/39] target/hexagon: Add representation to count cycles
Date: Mon,  1 Sep 2025 20:48:19 -0700
Message-Id: <20250902034847.1948010-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: m6CFTEvJpAnmQxJIPJ5dVrGnLI4r39wb
X-Proofpoint-ORIG-GUID: m6CFTEvJpAnmQxJIPJ5dVrGnLI4r39wb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX2LoNYQdQP/8f
 qJISL7IKs4bIPiElPC9ts0zWzT8B+VcbV7IGbJatFUlvOHRxP6a1ksNi9Nv2AuLr33jLa55ELF+
 YnSsFyAh8ti84w7X3ZTCkJTcptTpHxWXfR6LJ5/MGfPKeQeBuJYvBR0Lzmb+2lwHYhmOSwU48Kr
 33Nou5XPLiirDMs5SecNI+sgcYnQlHGLkoeQtbytXvypZ44ibHsuK+6zzzEAdpiTOv5GklwHr+y
 7oKRuFH6/2AG2789m1N0Sd39ri+lWRoA4ipBYoG+OeeaLIyRouq6Vd4vVTJeYqW0U1QW5yw3q8N
 dgI2A5OJsigAJvdrcdr2G4xB+dzr348FC7jTBrxehdTCHzVoGLlZ/Thl31TRybHNeCYeKFwIYkr
 c5pbbL//
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b66933 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ZWj4HUzx-Y95D6cr9toA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027
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

The PCYCLE register can be enabled to indicate accumulated clock cycles.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h     | 2 +-
 target/hexagon/machine.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index a0448eba44..8046f7bff0 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -128,7 +128,7 @@ typedef struct CPUArchState {
     target_ulong stack_start;
 
     uint8_t slot_cancelled;
-
+    uint64_t t_cycle_count;
 #ifndef CONFIG_USER_ONLY
     /* Some system registers are per thread and some are global. */
     target_ulong t_sreg[NUM_SREGS];
diff --git a/target/hexagon/machine.c b/target/hexagon/machine.c
index f3d2bdf41d..7c471d1f3b 100644
--- a/target/hexagon/machine.c
+++ b/target/hexagon/machine.c
@@ -35,7 +35,6 @@ const VMStateInfo vmstate_info_hex_tlb_ptr = {
     .put  = put_hex_tlb_ptr,
 };
 
-
 const VMStateDescription vmstate_hexagon_cpu = {
     .name = "cpu",
     .version_id = 0,
@@ -56,6 +55,7 @@ const VMStateDescription vmstate_hexagon_cpu = {
         VMSTATE_UINTTL(env.wait_next_pc, HexagonCPU),
         VMSTATE_POINTER(env.hex_tlb, HexagonCPU, 0,
                         vmstate_info_hex_tlb_ptr, CPUHexagonTLBContext *),
+        VMSTATE_UINT64(env.t_cycle_count, HexagonCPU),
 
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


