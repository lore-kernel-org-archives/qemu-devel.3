Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7161FCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkkO-0007pg-Uf; Fri, 16 Oct 2026 12:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkM-0007oP-Jj
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkJ-0002dI-FJ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5jwJ3506108
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZyoEVCOEZAx
 RA5S0ipJNw+uw+xZwEpxCTt1XfwzYEdM=; b=cdTGep5gfQJx3/EP6ZEWIBg9sy0
 JBxsKZrDAlZM1C04ZyFKyP7urJye6h5HIauamS8iKKE3aaWTGEn+5XJUXKHKlgUf
 5xjAgX7SvFyCCEyRBAvFu/wfirj0MW9BFieQTDHKTsA7e5Hgjw/deB9NAuTTQ8hl
 pGVRti3AYke5lY9vKem3UUGACrq/YgtlFPBMeQikRzfwLUM/PswAhoIMh4m7dGz0
 ymPtpD6Xf9aVENhRc2sdpr70NxrVU2zQvTap5ahcTH4v6vrVnIwuCY10DTqIixYU
 UnPJ8pxQEcUb71WJ+v0TFBXP2kK7Y9fVEMgKuQ6y0M/J5EpsebKaXb96x0w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8r13efp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab67ff8ec3so136407a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792167919; x=1792772719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZyoEVCOEZAxRA5S0ipJNw+uw+xZwEpxCTt1XfwzYEdM=;
 b=NpYR60b75Q0UPpx/75cqauV+saOcqGPfs2H+EYUv1FvmqqHsJQmRCPuXslIQMhMIjN
 pkPBUawSkYimaKfU1xGg8yq1pXL9rjtXXs0pnsU3unux5hnYyRtW4vi/Nip4CdDM0iCf
 V2gwyv+tPEKf2nZejIbV5FQF/xeGxUlzYMUVDIgrsepyQQbDyZqrM2g5xqICgvyKq8jG
 b+k1g2BpOS9wPejkMwSOT417MReQMdPYfaO5uH3OfwrImmI4Q7xReOJeFIxGqONE6YME
 wcnQlJv22EjfW0O+BL8t9MlrXHQ3B1PJoIvQx8KhhSmfPZ6jNweL00iqC4H2lK29KdKr
 BTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167919; x=1792772719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZyoEVCOEZAxRA5S0ipJNw+uw+xZwEpxCTt1XfwzYEdM=;
 b=1wm4rx3IW6r78UBZr9gyKYpkET7YJgCFE//vMo00gIViZwoKNRZnz22SAODHELVIqw
 2RFPZYdPnPhl7VMoM9xMXKByzjgQh6YCuoBZNFcQdQWmyrjcPFgqOKHahbZlLpy1o29R
 cQqw/15qAuiLWK71tPApV9TDvQMraVu6OoCQ0xCPgBNMqrTkxOmYWp/PO8KcEngjWF2L
 33VaqgY/SJBYXCaRIVQBPt/w5AKq4Ih0O9khhRzcuVSH0FBKipQdRZ3u+MCtQTWk3ulN
 JsE2rhjwi1YnvL8A696kZwI/SYahiHQf5s3lQ+0MWU4zeqfZgSlLZIRLc6RNx2rFsXXl
 iTzQ==
X-Gm-Message-State: AFq9FYKS4+3eNVIegVWTiO/y52x34ZjrK1sBjcpHHZH64nJNq1pv9+7l
 Kd3W22EDWjicRwEhsdBAxRsSt6Cl8gQMTQWNgkJK8sKDaeUMNP1/yi1JxaOGhjoriqiMM19bZz2
 Z9UsQGubPFNavlJI0vHAg0QdJi9D0oHSnDgzYB54to3lqtn2vFKnk1mGHvqEUF21RFw==
X-Gm-Gg: AYBFou0241vT0cnQKn2bSVvUh2Vxnauq1VxJP7AQ9oln02vNUPEb8M+ZQaJiZA65tIS
 ZkKuaTje2/FyZPLBylhfTnofyJ9QvpZAYp8jpmVqWb9g1NTKA38kfqEJeOSD21P9l+isdujA0rS
 O2Vv3RQpXKYK0HWb011Wt2XcSf5gGAua7YYTE4PqcEmY5tt6vqGuecmNp2ryKw/JWMavIDRbnBm
 AEm3p3DyA+mAaaWBsDGr7ZtJgYJY7u7aY8DREF2dVXnhGePntvQWyXjFKU9p+Q2BD3BuYeMxhOO
 V733umUmcPCgHgBXvYuC5G0hciVxxuuyMFmkewdIz3bc2v0wtHhib3HMi2XhRnOu9EhyjqBTqb/
 TuZN286UPkWLEiH1Cwi9xzdbSdL+bB1Z3nFGKjtcqvwwwTwsMWLEV/9JBE5w+m3A=
X-Received: by 2002:a17:90b:3a4d:b0:3a4:9a7a:360 with SMTP id
 98e67ed59e1d1-3acef29e7d9mr306066a91.29.1792167918427; 
 Fri, 16 Oct 2026 09:25:18 -0700 (PDT)
X-Received: by 2002:a17:90b:3a4d:b0:3a4:9a7a:360 with SMTP id
 98e67ed59e1d1-3acef29e7d9mr306044a91.29.1792167917900; 
 Fri, 16 Oct 2026 09:25:17 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc4872861sm5246143a91.7.2026.10.16.09.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:25:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 2/6] target/i386: rename qmp_query_cpu_model_expansion to
 qmp_query_i386_cpu_model_expansion
Date: Fri, 16 Oct 2026 16:25:05 +0000
Message-ID: <20261016162509.24854-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: I1gV3sslkImvoVX30jqZhr5-ZZjefCML
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX3mCIy9RdIL2M
 UU9THflDCXcElzHzhpUJzDXKHpe/HyhRw5x15ve9PK4iW+TExjtGwikq8KvqQ9qon68pTrDb8iI
 Ur1Tn/zk6WCqW7JKHc1v63hE7FBISv0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX+h2e15kMbjrY
 K2jmMxmoBSMw4csaZb0/O3wDV3jlmd8+2REsZZmhTRDzWVdNF855wVaJuYPWrANjvnshLxRc2vM
 eAculCNVYhPkV4nbGVhJ1J0ue/ePLafOY2YCVZ8hQxQLA5+qAW9Oh5qzWYRKvp8Hp/iw19I+sUg
 O0i/liE4WiRvPxzORAczT4aASpAzwzoOdgaEio0+/EZaNnXOb0sVmW3+mu9IU2sJvNXnnYZMPu4
 amSMOGdB+JUuv7zuMf4LDZvq/lyXSSbDKhGzT0caY6KkMetHKPhIg14OjxHX4GaMAVlLjglayeU
 xkEQkHblOYgpHlueGKWNzYNt2iVWz+NfE82SFjGGal6iKSZT6E+caraHRwSlVDItinmt/oDlZyT
 4RGqv2ABuedf6w2Hg6AfYkzPr9vzs4iEfmStS9a0uTpkUgj1dVGiyT99ptdhN6wAS9OA8xDi8ul
 ScPCcxVQhVQCv09HmSQ==
X-Proofpoint-GUID: I1gV3sslkImvoVX30jqZhr5-ZZjefCML
X-Authority-Analysis: v=2.4 cv=L/CI0OT8 c=1 sm=1 tr=0 ts=6ad24fef cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=nTQWxAd7QHvWKPlqegIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160065
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
 include/system/qmp-cpu.h |  4 ++++
 target/i386/cpu-system.c | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index d2e7c76ca25..cbf8ae7867a 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -21,5 +21,9 @@ CpuModelExpansionInfo *
 qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
                                   CpuModelInfo *model,
                                   Error **errp);
+CpuModelExpansionInfo *
+qmp_query_i386_cpu_model_expansion(CpuModelExpansionType type,
+                                   CpuModelInfo *model,
+                                   Error **errp);
 
 #endif
diff --git a/target/i386/cpu-system.c b/target/i386/cpu-system.c
index c8bbf0cbafd..f85dc4a7036 100644
--- a/target/i386/cpu-system.c
+++ b/target/i386/cpu-system.c
@@ -27,6 +27,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
 #include "qapi/qapi-commands-machine.h"
+#include "system/qmp-cpu.h"
 
 #include "cpu-internal.h"
 
@@ -189,9 +190,9 @@ out:
 }
 
 CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                      CpuModelInfo *model,
-                                                      Error **errp)
+qmp_query_i386_cpu_model_expansion(CpuModelExpansionType type,
+                                   CpuModelInfo *model,
+                                   Error **errp)
 {
     X86CPU *xc = NULL;
     Error *err = NULL;
@@ -241,6 +242,14 @@ out:
     return ret;
 }
 
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    return qmp_query_i386_cpu_model_expansion(type, model, errp);
+}
+
 void cpu_clear_apic_feature(CPUX86State *env)
 {
     env->features[FEAT_1_EDX] &= ~CPUID_APIC;
-- 
2.43.0


