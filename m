Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB0CCC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBq-0000JR-PD; Thu, 15 Oct 2026 15:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBf-00009y-6s
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBd-0000a1-Hi
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:22 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3OM8406042
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 drdhI8/BYH7s5ZRYsHjkbzOio0btctLOigDxnqVeoNQ=; b=ZeBqBoUgDTk13T13
 0fbBVDQ2AAEnLUx8AB78txbC+I6CKMq6qW+sh/L5kKNB+OiCgwM7xh1CADYHLQ6D
 Y2xE2FntkHOQ3LCTcI+dd8szMTLfzHFUnoQZiwzoYkWfQGTuJzfuJsfTUZepuraq
 OJO6nkMDT6pslDQRqoxPt0YTrPTibAFyYRG3yZqiTYocbjmVEQOCrQsJ1xGUqhti
 Dwk6Zzn5A+ePjwppUVVRHJVZJyy30w3Mc2OgoxrVZSQuqabJ6ET0rlgQCxDsHVLq
 OaDULsR8nVPJAA5ON1G3VcR3BpiH+D3MXZz75aPdnsmomsLt9oS7waufeSqq7ZTE
 2AQavA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa09sx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35cbea41088so3557281eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092725; x=1792697525; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=drdhI8/BYH7s5ZRYsHjkbzOio0btctLOigDxnqVeoNQ=;
 b=hiDxaPjDWAHRMr6GIMhF7HH++ZdSWiIpkPbHghv2rtn1gQPTu0T0NxeJP0qDtvWr+q
 SZAGZNKykM1yoHcB0YEAsnilOkIhe9XNQkP6+8c4WlsSZXzFNRyI+VaweKduc0NCjRFr
 8Eq1Yuxa/e/qjxk7qn4QbITx+Lodm2LPfBoci1RMgBIkWoGX60QJYPJAHb8xhjyToGr0
 wQZndMSTGRfygpngNSA3yu7RmQkEuLXeCkvONH/AjPhTePGtZb3pceNOpnBaBNITJyOn
 vCkwqa3iPEm5EgJ4c5nQWgCLuEh5OHtzeArZjZa8KY26VeQT36E7AcdNFW2iTRWVg6ul
 eNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092725; x=1792697525;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=drdhI8/BYH7s5ZRYsHjkbzOio0btctLOigDxnqVeoNQ=;
 b=iMu7ib4qqluphRJAt/IbA6R8oJMc6VgNLGD3oIkql8Jzbnu51AkRkmSA1gw9dRsrId
 zWOvwe7jQJjwU9i86U2jpTLBwoPv01Do8VpQ8cf1AAi/Rvciv9HhT2akQFbcc/oa+zlM
 iNIhBrKNStQzv70uUkZKZwy61VUMJG8NK9b/589cn9cr7s2FB+0OF9gOGLHFnzqVC5ZN
 JnlwT3IpnA6DmgZBjSjoQHamvpbaw1AcFVoABJN613a7q8zva9hCC71rxgY8i+tsAtFw
 rByGl26c4l/SYHhfXn3cCwpovY8X9Hux9p6bXd1caVE0gvyTDYtUQFE6Xu1awnI9mPiE
 Z+1w==
X-Gm-Message-State: AFq9FYLlS+mvBpsPaNUlw5sVVP9YIFdcFPCWKLghRprd5cG6MAGkL1zI
 64Y4MBGdSZfWIhlBGXE18M/dyYvVEncmXgTA9Md6Yh2uTZdDGRA2pTC+o1RgTY8/Bn9RPdyyRzA
 vX5h21dABrSilEqToFvN9/V1Y3qUXpEbb6iJvLuhHCtV16km64KOmvk3H2RnRSMYZkQ==
X-Gm-Gg: AYBFou3bJo5wIFtJoYl4LvlAnWTmmLbqznWE5hiU/FoUvINydFsJUyaL5kzp3ogUn1v
 nT7to8jyY2RklViEyIf71lwD75kOIGnLV8mVHLmZc66avfKFGCfl2HJZ/nhWHb2Sm5Aw0r9n2Ob
 r7A20qrbZUE83wQzcmLICGw2ELzvpBvCjtnlytqpg4zOR0T2tcJ9wsAOXx9IXvaqmy8zrrhUuhA
 mlS6BNNNXkxIlJth5B740wVSkfsZijekBv7MglNSb9g11x1I/LpIXAdJyAOkdKHwctGlkF/82Xr
 nNbg/hF8jI+OhpZaG8b6DsALyp9orScxgPRHo96chc2evv+CQHdT1Tx6x1yqFkcuBPy5q90L0aW
 x6rqDaaonKwTWl7pKbRsnFR35quBjSvuMoMAAmclVxAfjcv2NiY9+sY7lLUd2
X-Received: by 2002:a05:693c:6382:10b0:360:58a9:2704 with SMTP id
 5a478bee46e88-36058a927a3mr546139eec.6.1792092724509; 
 Thu, 15 Oct 2026 12:32:04 -0700 (PDT)
X-Received: by 2002:a05:693c:6382:10b0:360:58a9:2704 with SMTP id
 5a478bee46e88-36058a927a3mr546107eec.6.1792092723950; 
 Thu, 15 Oct 2026 12:32:03 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:32:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 18/20] target/riscv: rename to qmp_query_cpu_definitions to
 qmp_query_riscv_cpu_definitions
Date: Thu, 15 Oct 2026 19:31:10 +0000
Message-ID: <20261015193112.145326-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfXyqg67y1M3gK3
 O14O5fIDk96uqNCXo7qWSG81C7DkFirxfoUQXENt9G55UGHa4M6pp/+0aM7GOliXge5mK/WRPcK
 TM9RH2ftl4qyEkQ4oQkq48sW5Zf8gzY=
X-Proofpoint-ORIG-GUID: PC2as57aEJWYsMQgWtvl5_-zVNjpgjNZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX75R/ChQ6ATeO
 LjVZDvTFi9qMDFelEM6ZikJ6hrZTeK8eaqumI48cJTrM/j6g53Z7ZQoIpemMu3VM1EEy1xt73eO
 SfpZQfWSZsYyRFV01V0mX67h0ZGKMSKotmFFyAnMvaR2U3p5iy+b4uICIqira6TARkBNNHm3aV9
 XKIShWUu4dD94+cEwxRcoDqSg62Pa4DRriT0QCV+mkRt//r2zJ/7ZeXYAfGjRqZkNwMYf1iPLPA
 +w+kSzZ5GyCCKknNgQPPJYDX3Gc3uDp8hywpBwE6v1t/FCmcjyDuFATd+K6gU0cbhgdH2dtBuJf
 j9qu0HyEP6qgzxdKtG45Y7uqeagR7dz6Vst/rdwERmWj9hO5U+JwbmKui+4jCflcRZL30JxYmve
 tlqBqg42QQ79q3zxdv0rtn3evP2FEbpvnV8jPHjmfUsETCjSSIfufnzC2ytdfM0jPxHBN90xchn
 FOi7Jp8s+fRLdo8ABHQ==
X-Proofpoint-GUID: PC2as57aEJWYsMQgWtvl5_-zVNjpgjNZ
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad12a35 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=q1tw9LKXY6zF2k3L-N8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015005355.62406-7-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h      | 1 +
 target/riscv/riscv-qmp-cmds.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index fba0e11d5e2..c1bfdd679e2 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -14,5 +14,6 @@ CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_mips_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_ppc_cpu_definitions(Error **errp);
+CpuDefinitionInfoList *qmp_query_riscv_cpu_definitions(Error **errp);
 
 #endif
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 2647deef916..ccd6ae1d5cf 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -26,6 +26,7 @@
 
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
+#include "system/qmp-cpu.h"
 #include "qobject/qbool.h"
 #include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
@@ -54,7 +55,7 @@ static void riscv_cpu_add_definition(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_riscv_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list = object_class_get_list(TYPE_RISCV_CPU, false);
@@ -65,6 +66,11 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    return qmp_query_riscv_cpu_definitions(errp);
+}
+
 static void riscv_check_if_cpu_available(RISCVCPU *cpu, Error **errp)
 {
     if (!riscv_cpu_accelerator_compatible(cpu)) {
-- 
2.43.0


