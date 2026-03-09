Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C48F417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv3-0001QG-2k; Mon, 09 Mar 2026 10:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuq-0000yL-Q5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbun-0005Gs-KC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EAUAb1249036
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hjdqw7ViUHZY/mO/JrPBTjkTU8B404aXzmagcFLQRi8=; b=iRhsyFQ+5Yduzmvz
 wPyK23ySzmMuHl0CiGCEcUmzEEBwzoau5dBNuGlPG35xQ0hfAUjvaGUnR47D2VZf
 LO9N/VeQtZgaeDjNYY8Y2lD5mD3Br49emP0qQTP9/YNmxWoK9mHC7lnACwCpZjR+
 wU6fVDUK6OIgybdsjYzLTAG/7nosAjWG5BXfimmc+d1Y+1NTj/7DA97tbxmNM9Um
 DCqKaNgTJn3LkEsQIuBgqQ4oPJAgnppuxZ0Konklt78Q7ybndYFEeJ42Ibywc4S7
 FN+6Zryta6H5PMhFziZY8s4qvhrYDqVBPWOGz3w9rQSWypIdr66hJRsHjZmABzY6
 kCHPYA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyr403t1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdff07d8f4so12962361eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067729; x=1773672529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjdqw7ViUHZY/mO/JrPBTjkTU8B404aXzmagcFLQRi8=;
 b=Gd8kKHQ29eLWh7wXsggfaeuQqTHYWOWwKLf9yIjqJme20WtbaAhV1KcYAUkiRaHqhj
 liGgg8knvRFIcJ7ieJiZHEIYJbR3WZfhuhoMVlRjQ7hqqn/yICm24j3pkFCNf+/zNrfc
 30bzFSvJtHVEYyLy5rK0enSjUVk2STXiRikKY9VdMge73019G5sxkiE45/OFV1uJcJU/
 77T33sPS4pUajuS3g2hHxbaZGwr411O3vZsFuYAwJovIxDbY2E6VVos293R0Ijiapm+0
 BUytjGN6rZSg5Mv+zV178mFr8jwEcXB/UzRLFs6h0mPjwap/fw2x5smkUK8tuAwJerc+
 SFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067729; x=1773672529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hjdqw7ViUHZY/mO/JrPBTjkTU8B404aXzmagcFLQRi8=;
 b=bObaaiCa+/7fp0k38S/aFQC2Ij2PdriMuyLYfdZ10WctVIElDWQBAJBilq+wbtoaqX
 KzejhCeaf5ka3bjQhs3HBe2oToWbrhd6Ve3K1NaZPTBad4zrY9FdCem+9KhVo1UqNYgV
 V77PhBnEGH3eHEcWMdJ0ii4cqyhSZJsnpku6iWMJv8lXJLeZ+WPYsvLnXLAb0013CUii
 jywKeKr2gBPuv45nHAn+gogEXVHsISBIktS7aHlO3z/RkbV2VYnTQq/Hjk0yt9mLladP
 wcNWW8fNvs6CdJEakhVz2RT8d0yekHA0O1hsJyB4pV8ApPYpjySwE03lr/dnJBWp0c0J
 JvZA==
X-Gm-Message-State: AOJu0Yx4U6bNVRfCwbZVwtkPzC5rRcOgmgLUQ6rGiTs660iklQSB2+ap
 O2yiJQq4cVE1CgtDCxMySuuDyijGUzlw/wrSc0e4ghTQ0XJrJkNvn6y9NQ/Za3lxB1Dt9qW301O
 Kl2wd5TyYZjMxiWEKtnYKADtKUEpXcl6aPtN4lagpRc6Cg/uAhZQ3cloZvBBMzdw1nw==
X-Gm-Gg: ATEYQzwrWSOdhFANIrzxB3kFIaOfbYULoUvQI93kSHIOjqGQekDzs0S54CHmdUUJD2E
 0nS3wszlgpXJyaPJfD7KO4YRfm8072FwQzFdWMqXNLLQsPM2RSCkbG1ZNVToegwJJ5w/EZeQYW8
 tQ0SfEJ/2VgOsMd7jq5sBCYdjehJo8eO7i31k34kW6YX78XFBtgoP3ctI/Tl8t5KhECzQLZQlMY
 kjj5uHMnIEc/x68xmMMRnkuLIKCy8NgCFhL3o8Dxw6roGwrp9ymPXFs3cE4IVyWgSc9l1kxugTK
 mFDx2G7biSusUfN6Z1mp2E/SmR4NUJJ/tYy44PPYKT6TVFFGeLi8SDhdu3Mps8G19TDcXJnnsVO
 MK55RMd82Jabwv34q9NwyFiEPg+cacSt47vp4agyNXc3Z+eHupxqe/x0c2L36Wy0M1L92cQ==
X-Received: by 2002:a05:7300:cd90:b0:2ba:7863:f0a8 with SMTP id
 5a478bee46e88-2be4e0d3a1cmr4278243eec.36.1773067728680; 
 Mon, 09 Mar 2026 07:48:48 -0700 (PDT)
X-Received: by 2002:a05:7300:cd90:b0:2ba:7863:f0a8 with SMTP id
 5a478bee46e88-2be4e0d3a1cmr4278227eec.36.1773067728025; 
 Mon, 09 Mar 2026 07:48:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 19/35] target/hexagon: Add vmstate representation
Date: Mon,  9 Mar 2026 07:48:06 -0700
Message-Id: <20260309144822.877695-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX4f2tr1oYQWtg
 Vzq8YBJpVzWbVK2WMmdW3cFOf9l9CMUo0zh9XwzejG2RdVybtfUnmFZAhda0fX8shCtXdKDY86v
 N3Zd2GdwSyZSshDKOq7ZRrfu4O1QGakUKu74lrz6PqK1NwXnKhMhMgkkDBqwJRBKD/W//2lsY9t
 ToY3xcy+Z+ec7cnDLSUp/7j5X60HmY1ZdeJLXJ5O1e/ueoVoRaGPk7R3XRqBOoUXFRxjvuM5N9r
 W2TQFL3OhoBGLLO7a5Zz4X+U/9Z7tUjC2VFAN4VaeWwMhcWxJtfe0vwGOaSGjdfRTl0CyNRIBBc
 Q6s25dSNu10njq4kJc0SIMpNA19McoV6jzwy0ZXR/7PZQZyM/8q2ULVwVL931Nq0g4hVw49Ocxo
 +7/fn51/yPqU1Ae7YSKlfayBnXPXf7XIJsYoThLsdZip0c5pJDtLnugAEryZZZ0mHHsf02WRk7o
 wBOV7x8exDv0lnVj79w==
X-Proofpoint-GUID: 8m0XR6S89EHFFcm_clcxKzYI_2rNB_7v
X-Proofpoint-ORIG-GUID: 8m0XR6S89EHFFcm_clcxKzYI_2rNB_7v
X-Authority-Analysis: v=2.4 cv=KNRXzVFo c=1 sm=1 tr=0 ts=69aeddd1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=zFM9_BfjGYtbIq66ZkUA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
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
 target/hexagon/internal.h |  4 ++++
 target/hexagon/cpu.c      |  3 +++
 target/hexagon/machine.c  | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 target/hexagon/machine.c

diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 5fc837ae229..cd06ff41d4f 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -31,4 +31,8 @@ void hexagon_debug(CPUHexagonState *env);
 
 extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
 
+#ifndef CONFIG_USER_ONLY
+extern const VMStateDescription vmstate_hexagon_cpu;
+#endif
+
 #endif
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 6fabfaad6d2..38d605b06ba 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -387,6 +387,9 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
     cc->gdb_stop_before_watchpoint = true;
     cc->gdb_core_xml_file = "hexagon-core.xml";
     cc->disas_set_info = hexagon_cpu_disas_set_info;
+#ifndef CONFIG_USER_ONLY
+    dc->vmsd = &vmstate_hexagon_cpu;
+#endif
     cc->tcg_ops = &hexagon_tcg_ops;
 }
 
diff --git a/target/hexagon/machine.c b/target/hexagon/machine.c
new file mode 100644
index 00000000000..d6dcd07dd4a
--- /dev/null
+++ b/target/hexagon/machine.c
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "migration/cpu.h"
+#include "cpu.h"
+
+const VMStateDescription vmstate_hexagon_cpu = {
+    .name = "cpu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(env.gpr, HexagonCPU, TOTAL_PER_THREAD_REGS),
+        VMSTATE_UINT32_ARRAY(env.pred, HexagonCPU, NUM_PREGS),
+        VMSTATE_UINT32_ARRAY(env.t_sreg, HexagonCPU, NUM_SREGS),
+        VMSTATE_UINT32_ARRAY(env.greg, HexagonCPU, NUM_GREGS),
+        VMSTATE_UINT32(env.next_PC, HexagonCPU),
+        VMSTATE_UINT32(env.tlb_lock_state, HexagonCPU),
+        VMSTATE_UINT32(env.k0_lock_state, HexagonCPU),
+        VMSTATE_UINT32(env.tlb_lock_count, HexagonCPU),
+        VMSTATE_UINT32(env.k0_lock_count, HexagonCPU),
+        VMSTATE_UINT32(env.threadId, HexagonCPU),
+        VMSTATE_UINT32(env.cause_code, HexagonCPU),
+        VMSTATE_UINT32(env.wait_next_pc, HexagonCPU),
+        VMSTATE_UINT64(env.t_cycle_count, HexagonCPU),
+
+        VMSTATE_END_OF_LIST()
+    },
+};
-- 
2.34.1


