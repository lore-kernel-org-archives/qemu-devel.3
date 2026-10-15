Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B37CCA466
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBf-00009w-AG; Thu, 15 Oct 2026 15:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBY-0008Vm-1v
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBT-0000Zp-H5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3iD33902274
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0pGOnYm1CvphJSik496+NXeflBhXtpwHXBfLKrJSw08=; b=McScRrpJDLau6ORL
 H9lmsTz+88ZZTTpI1KwEDSaSV5brrQZdWnB6JMcHs0T1e81CA7PtY+50c5hIp/9c
 HfBNMNbvKWdRtzm+nWUHOtLkCYQJNTkRKy6WyDxUl1SbrxCdGRyFZMpn3TIWK7I9
 RjnzWtUSWEIYB3yLUrH5Lq9zKbfORuB6NS37gih7TMEGz+SmoJZ+ysk4FPboZEnT
 eVbJI7DzVYueTOmee3R3xIncqpz6nrGSygLLJXC3Ua89YhwceQPvpUo+5egW3ugM
 5RPC3YC6+XArsV2AFx1P9drNyiFSbxj8nmutGb2sBkEPteLrwa/hjxLDf6/z/BR1
 jVggXg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3ser9r4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c3c370b17so6556294eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092721; x=1792697521; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0pGOnYm1CvphJSik496+NXeflBhXtpwHXBfLKrJSw08=;
 b=P+yflTg8Rv0pbheQdceH3O/LRGsQyqDl5KXlCj/ZnU5fFQRxha0d76V985Np0mvRzW
 ZrycRrD9avTBvhjdEw8Og2bBtmfWUTByXwcsRcRRKxP2d1lqdznLlmkdxwl+LsoLJVPs
 2IIsYAXdCy8iti7CUssCbMJEiLFOkgOlz+7P8zSFLi2pw9YAbEM03LFRndf+Ewbc2s3z
 CKUZ5qtM4ThvQFzuWKI4vvWmN1gZf5qqbwZTqA2UJ9irXwPGD/Hk4AavhN1rrzmNWE7D
 lwr6/KfLSpHDoo9jF5DYpbiGUc6V8UFyqyXEaI9r4+rRF9srBnxJQAINYIJ1vAml2NJT
 8/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092721; x=1792697521;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0pGOnYm1CvphJSik496+NXeflBhXtpwHXBfLKrJSw08=;
 b=Ib7wItBlaGmgTt7Vv7fGa7kWWFpWJVHE/rTv9tiLZOCJbxWZzqpHWiR8LY088QXWah
 3m7lY86QRlaaWaT+57CPJ60vRX3iKkbeh1ZjGlxG/RvtP/WrrpB+icMYzmDbiaQY+4e+
 lZjsaD1GxXswWUh2RKURgQMRLsjqDZJ/XzHrYF6rckR/tefJKI7hwp/b7km9LpHSw9/O
 Aw4QDfCleYeWj9hvPLHcAMuSyCizMTSgM0hGipPX+I8/WAd2CdYeg5dMR2kUgkt/qQtj
 6QLGYqJGUlM6pqkFAW/3RCBRNpROAoGnIBGiAn6vKlfYOoIPFAmxSNGij9OAg8ehUDSl
 DjrA==
X-Gm-Message-State: AFq9FYJN+/Vl+/7U/Q0zixYYbKT1CjdhJVw44z46B7gdglHvapP3sRRj
 Pbx7M3HW/9atoSw0M0Q8HzkzxcKRQCtB7g4S1HSf+1UU6pRzyBDIiIbLa41a4mLG4Pc/0kIoJHL
 VMUoxKMeCdnHoeAN81JF3tC3pjxM1R+YgcDfeD9+7kursjOYFmw0mxMJ76W/kpxbOyQ==
X-Gm-Gg: AYBFou0BWVmhOfqcge/mXLUt09y0VAgz1CsuIU2i+Ksd/IEK2mWvcBbIg76E9IJQPfy
 fwdtkXgO8bpI3SgMwv00AHMPM4/g2Pr8OglJnK165d61ADtTPbZKKY/tlHlUK7zeHr8b6NQbVwN
 9PrRgXqP9F84k6mHUP7BvfCrGBU12IF31gYwEpf2TjDfFVagUY2BrA5+Pj0RrsiNXwSO7lJkZkW
 xDl4g7k1NR9mpNR56fiOfNjGshdIqlvla71wxRWOLKnrfREPqylYuDY8KGmydmg2CPxe/ViIKMA
 aHgsw1lZMOCarXpG0/zZJf9hJoGmNeiy5EYt+moImSF9juZTecTnGGguLa0hw2IsLAiAH5BsMYo
 udkMTD9fjgZ1p2Mr86SY0WUxdqtPfNJxmOw4nNZs5EHhiiEpLmBqx5o7JWa60
X-Received: by 2002:a05:7301:fc18:b0:341:2466:2d68 with SMTP id
 5a478bee46e88-3537e0cf2a1mr26289032eec.38.1792092720990; 
 Thu, 15 Oct 2026 12:32:00 -0700 (PDT)
X-Received: by 2002:a05:7301:fc18:b0:341:2466:2d68 with SMTP id
 5a478bee46e88-3537e0cf2a1mr26288990eec.38.1792092720230; 
 Thu, 15 Oct 2026 12:32:00 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 15/20] target/loongarch: rename to
 qmp_query_loongarch_cpu_definitions
Date: Thu, 15 Oct 2026 19:31:07 +0000
Message-ID: <20261015193112.145326-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ARAC9nk09i8Chg30BemOgEC3pD1zG2qx
X-Proofpoint-GUID: ARAC9nk09i8Chg30BemOgEC3pD1zG2qx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX1IAeMZc9kfh3
 QCoN0vjVipdrVrpUlmjmx08jKZAq6FSE2xZVByiDBXZzAEYJFfLaRZ/oN0wdYhQwABEQ61/5Iuj
 pVfM40tyJYCyL/MNmU0DqqY/Ws2rYr4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX/0NRn0+sbnAg
 F+VbHQpiE4yB0+klayP7DEh0jKcE2dnbIcDTKGnbRsLWe56jLD2g09qm7n+f0jkO0yZ+E/ks4P3
 KmEay2yBovU4f1KdNHV+ABeILUFxQrFdZ3smNuMMu5BR1Hf44HFzo6joEz9/1NU5X3VD8txMcNV
 qUC0H2ind6hKKe4OXYTHEcBzW6D+qMy/F4wmxiXUcpMJ7LLHRdkWqXHU2yu7iCB32dqrlixcfHg
 3P8TCBXPh/1cqP83NgCaZKK1hzwS2HtqDwxMtX8l1rBZJd+Ayr2mhWZWJtA9i8rKh0rK3H3og/I
 Yo79Rh7gXVaAkzhcfrMrMVQuCitkbsmlI4Mm/4UAGn0GaIx4g/cm7OP9OfEjzgsqx88i+qMPTC3
 rMUwneWk+S0xbuR7doonkpMVtqZHln32loaNjPW6QRrLhfjNAAR3bu/ibglkAp5DuM5tDkxsYjt
 rQLltYttWvXxT2sBzsg==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad12a32 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=atfll7LQcP_PdtnzAJsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
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
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Link: https://lore.kernel.org/qemu-devel/20261015005355.62406-4-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h              | 1 +
 target/loongarch/loongarch-qmp-cmds.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index 84b78c3a097..dbca230ac6f 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -11,5 +11,6 @@
 
 CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp);
+CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp);
 
 #endif
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index f053f22bb8c..dadf5de889d 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -10,6 +10,7 @@
 #include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
+#include "system/qmp-cpu.h"
 #include "cpu.h"
 #include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
@@ -28,7 +29,7 @@ static void loongarch_cpu_add_definition(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
@@ -40,6 +41,11 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    return qmp_query_loongarch_cpu_definitions(errp);
+}
+
 static const char *cpu_model_advertised_features[] = {
     "lsx", "lasx", "lbt", "pmu", "kvm-pv-ipi", "kvm-steal-time", "msgint",
     "ptw", NULL
-- 
2.43.0


