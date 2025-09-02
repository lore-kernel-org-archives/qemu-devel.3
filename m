Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D9BCA100D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzl-0006mQ-GG; Mon, 01 Sep 2025 23:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzj-0006ig-Ed
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzh-0004SP-Q6
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:43 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SO4c013850
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xLE71cBXm8KNE7yfwMNI6Ijpz/GKHOMZSorV6Otlvr8=; b=Zrp0wpPARLuCM8xJ
 L1lKxu+dokJ/fV59pClbXfYKKlONQ6/vDs741U6jCppS0Ge8uAelvVSXM6kEutyT
 EtyIQiMBcFk1OGcHHXb6ntxMuQjgEiKv71XcUan+MEY6hjxrf62bxwhOe6JTvt1K
 UELLbhBOTL7n5yviBoegBtm2cREoywcEBIw2QPBhVXNx4zVGKyIq7coEm1mqGh02
 QQ3yZhop4NAV2g+hs8fuiyIoIsRnsmUGIWH/PR/K23vxRqJ9EHp9NDAeXPMsY+RC
 7UdsIiZus8zCVPNBPsi5RJcIorsQ943RKawU2CpX30r2hJRM8yJErFUYQ5EdLhoP
 EBJwAQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eej54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b4c724d27f8so2848832a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784858; x=1757389658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xLE71cBXm8KNE7yfwMNI6Ijpz/GKHOMZSorV6Otlvr8=;
 b=E+oRMzqm88J/sf5a4KwNFo9ZouXohBzTespH9Dx28C4GxRWGzCmRMYIn6/eyN6+Iah
 e6yWvr6Cpm71XtuTa3lWF2q1k1DOZN2C0L2TFUtxfPfAjs5Hd0WEkHdsI+fa0laRpwg0
 4GEPAHVn9aw7/eqZm8NxmbUANIWx3Q65BrIPtrsOL2js/b4Ehjg8/qYkkcdf9ZQUar8y
 GzRu3ahMu2YygkQvoWt2umEa4XqeEclrT929seCY0BzUe3shxhdSB27C45RqFd+DEZfj
 vcoN3XnCPbZzgODSo2XA3sIE/LCKIRNg1Uv6OQage3/0Tswan75PVE/IE8qg3ehQfYBh
 00gQ==
X-Gm-Message-State: AOJu0YzStZKN/n0xyIm+KfggO04q67TFj/DNW7XSl5DAEjmZf+HEDlVo
 IhUIKuPgGwgtg/TbZjLZ2jHjpskkQNETtAZ4pnrkcDsLNC82TaHZMyBYMba3hoAWbnsV3qGT6y3
 upx9ppHljX6zj3I6VGZbF+pdvHOUcIAcpmkMxnYaB7HOKFX0PHKrMOZTmsoauD1PgP+MM
X-Gm-Gg: ASbGncuTNnMwsXvpxxV7ps6QrtaPiICex/oL0KqHl+GAbGxp/vROhgrsAkMU2Fn6Ya/
 eafvuhYyDVhndAGbKh2L1Ai5KElnn87k3fjeI1xHTd9cJNqxvQrOLZGDsvhfELIWrPaetg+QG2F
 O8QdUTfEhpxj/O9o9Ce1uhgpSL3NRGF+0gYxMH/IInL5dB1VayK2IGM4LIX6Kyxsxo23x8kgyE4
 ziJlAYc+8V+S0TCys/gyxuORGern7byVzVi/AKRWuJNULsmGRT0GpHXv+LoYlsvoH9oGPGRGydI
 BLCFRMWUniwzrfEGkZl3BgAzSvzDJyqeR9uxhoVoFpWk8WYsOiFf2pqE6KeaJFLG0iiCKYzwqnu
 Ql7GJi6WkESs5
X-Received: by 2002:a05:6a20:938c:b0:243:d562:21e2 with SMTP id
 adf61e73a8af0-243d6f7eb58mr12780258637.60.1756784858379; 
 Mon, 01 Sep 2025 20:47:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyrTl/G60oZ3xWZeMKNSlABXYcSi3d5PzCvrTuN5EVtBlldk+01NQklkVR2KVVB3kg/eYFgA==
X-Received: by 2002:a05:6a20:938c:b0:243:d562:21e2 with SMTP id
 adf61e73a8af0-243d6f7eb58mr12780223637.60.1756784857921; 
 Mon, 01 Sep 2025 20:47:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 13/40] target/hexagon: Add guest, system reg number state
Date: Mon,  1 Sep 2025 20:46:48 -0700
Message-Id: <20250902034715.1947718-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tPIJ6KMrPXozgoNHlC55om58NBTq0XTq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX3+tGebEQILQ9
 nb8v8Kxz0o3XJMSgTKA3KYtviheFQGj5zPNlFn1qeWP3pUDXdQdDcs/PZt1t7idJt6V2rKkNuMf
 J06x+kf/EqpH0jPkLYEeH06zVI+1eskbmPujInqijxwuKV4j7pHsSgsY1Evl5H3KWX9bGze7nTt
 laz+JEE9dhpC0vEOIfU4O4BaNesq2ZkduB43Pmnk7VqnHtwDhFvkXcnSiOMmAMQ+67SBCnnZSHd
 ECK+BqmIqHiww82ES9lWXUj3IxFrEP+EVFeO68cbLKjm8mVw9ANpFgG/7X0P2Q/2yBhQTeb1bFq
 cvyrQGhtlVEOl7Q7PoB5jyPb1PvWVLBaumKe8WGavgW/sf+xx/XXBVuSgghdGj3SLmuQmCeKMCN
 HGyPRhek
X-Proofpoint-ORIG-GUID: tPIJ6KMrPXozgoNHlC55om58NBTq0XTq
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b668db cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=XLwm3O5UTDZd0TI6FywA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
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
 target/hexagon/cpu.h | 7 +++++++
 target/hexagon/cpu.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 46e0dc9d0b..42b877a04c 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -97,6 +97,13 @@ typedef struct CPUArchState {
     target_ulong stack_start;
 
     uint8_t slot_cancelled;
+
+#ifndef CONFIG_USER_ONLY
+    /* Some system registers are per thread and some are global. */
+    target_ulong t_sreg[NUM_SREGS];
+
+    target_ulong greg[NUM_GREGS];
+#endif
     target_ulong new_value_usr;
 
     MemLog mem_log_stores[STORES_MAX];
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index c9dfdd7864..fa52ad7453 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -298,6 +298,10 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
     /* Default NaN value: sign bit set, all frac bits set */
     set_float_default_nan_pattern(0b11111111, &env->fp_status);
+#ifndef CONFIG_USER_ONLY
+    memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
+    memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
+#endif
     env->cause_code = HEX_EVENT_NONE;
 }
 
-- 
2.34.1


