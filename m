Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4534ECC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9jl-0005u5-RF; Wed, 14 Oct 2026 20:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jk-0005t2-30
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9ji-0002rk-F3
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ENJahU500328
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4OtXcfE2RQn
 ISyEelrwyIngLXcbGbCsl/Yq/lOI93RQ=; b=RmD2j8fxfJxN14Ba3vnKmMrajOL
 o65pfQFQciYuFOM/+VCv+EXmV8BS3r0ez0TYAnwA2Hou54JDqmGepYSL9vsHhJQw
 sKep9J5kcNlBCGhGcAICeeXUl9nz2kZnO0vdQ2ZQkf8OsnCE++3VxdjbbphSgNMs
 tzDqer/s2NHnR8h23vKVzPJwi5M/hXVOfPhN8Yo5F86MCmbKTfADeyJbOtZu36lK
 PcPQt/oGQWpp8L4n1E1W4JoHDLxzu9bIwjlKN0VXIO3xQlO/naSvL1tFbrizVhTK
 sbf4cNGYn+fuLzwEOqv+2BxwYTGsg0FJRNYmOFuwi2OPi8/LyXqdkeNIqfQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf2ep2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso9958404eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792025660; x=1792630460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4OtXcfE2RQnISyEelrwyIngLXcbGbCsl/Yq/lOI93RQ=;
 b=NqESiv/mNyGIhIbKKYJ9/0tJLaZCEEDHaUqZ3GHm5R0OsU7aZAeiqxHBLQ+2nLWWL1
 hxTTUWPqbpDLdJ/3RJBUZoXszQl7GoGd1yUVDRSQjSdVpFNm32spGH1vjyTBeNkv3tNp
 jLN/kFEPAQV2w35GEYEy/5+Bcwh1gdbHvZlXHvZr/CU3p59DKI4bHbIGnmExfsKiPFsx
 ixQ5spvrqQ2JBA+vDvvMk0rwyMZD5AVEA6hD6Gcux+IrtiaU9R6NMzEOzyMrC1Ylpd8M
 ShqYXCO6pfKPLBU2JASkjf1uTaPIMLZFvL6J56CotfX60bYJ2F21Jro9sFVzLExE0Nl/
 VSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792025660; x=1792630460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4OtXcfE2RQnISyEelrwyIngLXcbGbCsl/Yq/lOI93RQ=;
 b=E3KI9iG9XVl04iv8xfuErVHqRFpDZ6+qFAFaZYtF0G9v7q8wXDXYuaScjh9PXWlzB8
 RQKtA/oM0GYy1lOiXyJPfSrCAqAd/XbufC/ivAF9Lu2+VdZo9BPSW/NzN9VYuklx152d
 oR/WGlxvXBsHZoOVlNJojU/bYOX8a7gkwSDTfc8GzyAvRMwJdlE8vf8Va1S2/YO2whnE
 pl33NeiRwnR+78iM8R9Gwlp6c1eKpwCxa0EpiWhetlZpgQQziZcPg51bXrWb18nzCx6M
 OZ6X/h6eE0lQNYYmekNCNis5k1ylbdVs3Nk60gRG9oDYhNTcfW/0V2tncPEpgRo48HUK
 qhng==
X-Gm-Message-State: AFq9FYLhxsXheUEjFUybCIwv3PiLpWkgqxRg7feWV5pgZIQAYCIWJ4+O
 VsR+WdXAHvnAxBtIZaQBdgm+0r5BM2YQEI970f9HL8h3DrZSKVwaVSV6Q2PDNQ5YDqoysRejvkt
 nggM7l+teiTJ8J386L+GzSszZIS7NTQhl7yY8Xpiqdqi6kxP+Rn4MUHpvswq/lkYFkA==
X-Gm-Gg: AYBFou3QdxsOS31qKPh0V1KsgebAqfqVC2jDe/3lOFghzR+6FXoYffBDxEQ+WZ3miZX
 9AEJj4jSUJP3ZHrFbfIgpN7FwW8m146xXL0fw1AfAsBNOrLoqB7Bg22ZjHESThI0tJdGF9vGBpb
 akLjl4ukkQqRvgE7aTrFM8mBGj1TfuTUDVaB/XfyusMOLInZ7qWLFEffnqK6c8qOqVQW8Fo+utS
 GjomjMyoD4Sz2OuL2MO6xR1KgPlz61e6AxeFeh4n5Wvec0gvoWh2SkBxUOCPWQUvKAo8akhcNt6
 hfRKYNgkYlNZVrxKlK+2zC1tkSvLu06vN8B58/mvlMIBnrmIeUqbV7yOZ44L38bZDH6RAsd+FMx
 JGz7nrBSx48o32rcVUAh/v0xY0Khhx8dtbUczpDIlBtBVILumh53y2UYnklkh
X-Received: by 2002:a05:7301:90a:b0:34e:c001:1486 with SMTP id
 5a478bee46e88-3537e042911mr22337454eec.8.1792025659632; 
 Wed, 14 Oct 2026 17:54:19 -0700 (PDT)
X-Received: by 2002:a05:7301:90a:b0:34e:c001:1486 with SMTP id
 5a478bee46e88-3537e042911mr22337389eec.8.1792025657834; 
 Wed, 14 Oct 2026 17:54:17 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cacb61asm60487033eec.21.2026.10.14.17.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:54:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/8] target/loongarch: rename to
 qmp_query_loongarch_cpu_definitions
Date: Thu, 15 Oct 2026 00:53:50 +0000
Message-ID: <20261015005355.62406-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX2tLUEypKcY2J
 VADU9vEhFjEPM9mW7pLFMgFIDLVEXF9KImX4gP16R4NzGLLy4LwlFsdpqlHPpenWSRzpkl58FoC
 E6Bcmy4kqcxPhg4tiEjzLME7kYyN/nqZHAHBrKhcc4Zt9VxBfFwnva8sH5pEhWfM+RvnUUwrDbw
 /+4Q+EVWiPxeHZhmy/SYJLBSvqigp1R3vxUPPZwLRszCAeAKigMt6QcIr7mawPxtau8/NEiPwr/
 72YZHvIW1rMZMjvvPuSeYfoT8lLQJ4Q5Vqm8ytjGoGdICfeuH9yhP1d6AeKpIfM6hIalzqv5QXI
 ZFL9N0m05rFF51yDQ+QnoLDWATll9apxRdE5wo8kMviBticMit04xXBhRBQ+KJc9I4YB2J7eQ28
 j9a/wHJF7ENASxeyOFmFDTLG5ZSJfzQ0zdn0ryWd2SUsYcnR+Jc1vHHIFSunF8Ipm7Hkul50nxu
 0dkCD/w3lwStYVMYukw==
X-Proofpoint-GUID: spUgYHDmOi_Y9XRzwgTt9iYsE6VYSL4n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX0GiJ72fx3Rnr
 8Q4KoAnXuMRuX2JMhF+cR4vYKewpCnsyomWjrTcZYiQ8y0BdoaHnpGZSLwWVvvd06QDQp4c5b4F
 zJ8YJOeZ94W4sg4bfioG6Hfz/mqvGT4=
X-Proofpoint-ORIG-GUID: spUgYHDmOi_Y9XRzwgTt9iYsE6VYSL4n
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6ad0243c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=kW4jeXrm8ddfkYLm61sA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150003
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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


