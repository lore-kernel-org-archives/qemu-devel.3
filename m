Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB640CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0R-0007HL-5V; Mon, 01 Sep 2025 23:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0F-00073W-FS
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0D-0004WY-K5
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:15 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RmGU012352
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jy5idaKhQlhRz9SImrU9PvAGI/IEG3MQHB3N9+s1ybg=; b=gTTFqA9/KYcXCrUu
 WlGODeFttEt/SZv89uLTq+hWlP0VSR99yqxpHoDOTBYHdIDPjhvyCvOD/y1+dX+x
 8DZ2u3a9eF2fwyG3b5fV1jIGTkboOBD//2vWEYYgm+JRPyrU8YxCWOrtmYuofMU4
 Rf6ahcvZZJu7SWrHbZirjLGQQIZXFvrF0c/P04Mnv9/sECKAjR5W7nqerIpS00/3
 8Vr7+WgpS8ONt0+KqubIODFBSgigW2xmf2EqBD0Zy5YijSpxC9aISVqe4RC73KH8
 9mKy+EDFppoh7j1yyaaBjH8gTnlyksVCdfhaW6AW21EFu3WE23BIxcL+nJg1OJfx
 MGluMQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b4f736195daso1338553a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784881; x=1757389681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jy5idaKhQlhRz9SImrU9PvAGI/IEG3MQHB3N9+s1ybg=;
 b=RDw8oQTMY+I90IlKLs6SQITjaeD8JpH08ZRcPm7yZIXdtgwjyDnFRaoN/AfVcmJIhq
 qUUxOfKtEypOD62NpYqUI2ndTsiE8GOVvu39NL1yJjCx469JDOk9UFPRl9KzvH0zpNNp
 ar1SMxkFa1N5lpIQeEpeXKBhRURSoVXzEKI1V2yXkPkn8BosDbb59J/+jpoeUkw6ufrL
 eeo5xFIpeXk8X5naMLWHwglMFDUa7WbpTq2nsTNnKksiix9+u3PTobSlz44l/pP5GZvh
 z6yn7SrQOXN41QqxPc5hY18WKrXO5adkX4dum9eeJ9n8ylwQK/aVeptr8Lyujr90Dvot
 E3ng==
X-Gm-Message-State: AOJu0YxzpftABRfVOWPECb+CCeDM/z4DUiPAs5i/XUKSn0gmfkhTiXYu
 fTZZi1eIVScd5yQhR38c42Os6UBd0ThWouSBHjLXexM1iw3ZNHlb2s4EaloLrNTCbfNv5WysSyW
 qlHxODvaLHGpJt/tAbBlCy3m4ozkgScNYRE27nY6BZf0ceJVwG9E29+ZxawjsSULMRrqY
X-Gm-Gg: ASbGncsieH4UmtyOS8mSoOvrrOKseK16UPUkIlXqvfFKqiwdunH+nZTjXs8x1wdpSAO
 IqUg3KkiOGzX1ffXi+jcRLbowwUXXuIME5UlQl0td926nH+C3140s/k+zTW0zoqX/Hjg+vf+t3p
 IQdH2gHkj8qLipguSmKZyppdpbKf8xciz5DC+BL9/IdjvcSlCnAaMOHTBWn78sy3rT+K4GdsBnZ
 iQFaWrYS6bJXE0V3y/uoqyxL5b4/y21AEQCwgduXnUAzfq03x9wykE40obR1C6Y5Nt3PTZg3GD7
 2csfAZEUutyGIVw4PlwZ+egogX3ao7BIRDfMWv/OMUk3xyZ7zoWIiTIK4bdy3h+MgsoJlQ6b7Oz
 ga32BsEm9iggT
X-Received: by 2002:a05:6a20:734a:b0:243:9312:4fab with SMTP id
 adf61e73a8af0-243d6dd0cdcmr13683170637.3.1756784881101; 
 Mon, 01 Sep 2025 20:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE35IZ2rM+EJLGVsbOzSugdY671GhWnpX6/BxWiMTPTDWeLh3zFO8xWfOGcS6gR/kji8cprSA==
X-Received: by 2002:a05:6a20:734a:b0:243:9312:4fab with SMTP id
 adf61e73a8af0-243d6dd0cdcmr13683148637.3.1756784880668; 
 Mon, 01 Sep 2025 20:48:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 33/40] target/hexagon: Add a TLB count property
Date: Mon,  1 Sep 2025 20:47:08 -0700
Message-Id: <20250902034715.1947718-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfXwnlETXH40XQJ
 EqMB4zq6XEOir0XX9o7fusQ7KFHnhmmFq7h68+0uqpU/q58HNYhVSKaIT/j+m0TimvqUwIEn0al
 ZQLeBI8HEK0aEmjQdNq7vkI7qcbTGoSolUaqpqHZE5wPTeUHIZ7GqL5P6i3giG4Br4tLoZ/Da3S
 E+Of9DfHmQKNC7KpBoamjJqeoB/MK3ft6NAdZAhdDfqH390UgydAIyVX40ewY6e7q5gR5J18qP1
 qnTCOxyKiOz3RDfPYnJ+qsp+nyuTbtZ11IAme7cJ+6uEJR6IhKYTei/WCso6OFZ7xmXUCn27OER
 ku1WZjVyFqaSlaVdvcI7ezGJqE6ROBT3FEXsSI2wZY/TYH9RvQesXKZCKYQug5bvj28nI/A0vmW
 FeLbIkKA
X-Proofpoint-ORIG-GUID: 7yj2groJ94XFRnlkveHqTB8P3LFUTZDc
X-Proofpoint-GUID: 7yj2groJ94XFRnlkveHqTB8P3LFUTZDc
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b668f2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=IGJoV4xj_D2vbx-RUiUA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
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

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h | 2 ++
 target/hexagon/cpu.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index fc6552e64c..8b1ff23c01 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -44,6 +44,7 @@
 #define REG_WRITES_MAX 32
 #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
 #define VSTORES_MAX 2
+#define MAX_TLB_ENTRIES 1024
 
 #define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
 #ifndef CONFIG_USER_ONLY
@@ -181,6 +182,7 @@ struct ArchCPU {
     bool lldb_compat;
     target_ulong lldb_stack_adjust;
     bool short_circuit;
+    uint32_t num_tlbs;
 };
 
 #include "cpu_bits.h"
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index a508f27fe4..56098b4c55 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -50,6 +50,9 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
 }
 
 static const Property hexagon_cpu_properties[] = {
+#if !defined(CONFIG_USER_ONLY)
+    DEFINE_PROP_UINT32("jtlb-entries", HexagonCPU, num_tlbs, MAX_TLB_ENTRIES),
+#endif
     DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
     DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
                          qdev_prop_uint32, target_ulong),
-- 
2.34.1


