Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAA1CCA465
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBY-0008Vk-DI; Thu, 15 Oct 2026 15:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBW-0008QW-Ls
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBT-0000Zx-ET
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3MDd405911
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gRNfK5JRBAeAcrkbuAKj96iNyPwSX5PPd2JsrnVfZ9M=; b=fIKZS7OgoXsvApko
 wQyfstjLDOzz7/yN12WnQVieWYZt3KSvksHhWn5huoiV2MbWko4erXNXAmANuvDN
 g4XQa0LdFN94LCZemMCtqNxqyzJRcBHLzbwK/8JiYTltPFu7zPXjdn7gUzfBiN4c
 INwnLOWj9dZIj5rg11UMoKkEvIDdufwjXFZKjvRXzuK8bY95KNKOa/+VW4Pv7Mhl
 Wdq0we7+fE8K2mxNAzDWYFVqCj6gwbr4kOUjvO8eCeH/RWX9gApY8WkpVlDF/yi/
 N+ouyQJQnJtwjfcLOR48ivqsc5Vj8y+nlFg1TruH/RorEostavqTC/VDsFMHLsLc
 4l1jcA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa09su-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a04491c56so265819eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092723; x=1792697523; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gRNfK5JRBAeAcrkbuAKj96iNyPwSX5PPd2JsrnVfZ9M=;
 b=Ttwj9BSH0w4IC0uZIhSU2mM4wSPiUJVZAnS+PDLEBPkrXqGW8xxEdRK9IO0Yqqrd2a
 XQNkzqxmPttm0NtufslQEis9khVhIy9ND4vMycu5vs5Yg0usayu7Lsd7pU4pueMVgaXp
 owgVIFQ8CKa9BmJO1leJ63oWG6RDG33rcD8QnG7UDbjvm67SidkLt43wrYlLOdSDGCqN
 55vgxf+YbjeXHrmqdXmjMb9lwlxtyApE6R5rg9POeAq4IUf7igWUVJOhGd/p853grGIx
 7mJUFA/QKIYmTqu0thrkAfSby/2R2okcc3X9zj9Yh3HtkDwdqCbdtkH/bs/V1gnUv7W6
 9UUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092723; x=1792697523;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gRNfK5JRBAeAcrkbuAKj96iNyPwSX5PPd2JsrnVfZ9M=;
 b=QWhAkBGTUgxhSN4Q1wT+VC4GOiWdiN/Dj9qgyUMaJ7lkFa3AGucyLBDvANcIa6dK+3
 W3Na/3qrzeqIhwRwOgmd0JLOjIN//kJ9RaYLCiW5oTZXuOOXDb6IS9eoQoIRfhdPmYle
 O+HpbaKElpxIk1tvlPTtxdfYo7AumalIzYClkh5BkHsLlMtNXt2aTc8Wu2BMzqawRuoT
 THKWjcXumH+YFj1WK8+oJ+Z+UrB0qldj2nKr56Ih2IJi7mqpeRt5JUItVHTDzkHNuyXw
 vF3triJy/07sliFC6bx8ZyqWWiXq85cPXM0X0Z3qE2+gxnRRzZROfIqfBdDZWAIZbSGe
 eNsQ==
X-Gm-Message-State: AFq9FYK+i6TPTL05J3hq6ed3Duj0HgY44oo0Z9qvugG4bYNw1yYoX62K
 VRYnUppSsdKX1GBQPlFwhNdwMMr8GesOLjLbaVDUYnIKlmzhg8WYYIHOWlXX8+nYSo9WZTRcIPz
 RcMSgeGkaW06UQzwRNWtHJhhvOO9+m/mBA0nzEIwxLMKExWnNQtwyN0voY7ibNA9hiA==
X-Gm-Gg: AYBFou1Q+RthbTr8Izfp91TDWNv9yjPeAL5uO6Ac6oRXC8TeJknFVnKRkLFZihc+AmE
 uY2DdXdHlVaIOn2zeAFntXZgaUJpMeHvGAn78imCvGMK6JKhTkBQofgwhgVeQbPhRLs6ldoUXsj
 p6WBgwrlDmO7u4ElhE/kX5UE37xYIvtNkhUY5HgaeYaSDbRDIepXnMikjsKgesmk6uB05K3DzNG
 loQRd2ULeLrqMOGgvtmuTVQS0wIqJMoH4wqHDoKRdSd8wf1sPTccZLodMvuKVHeYKvfeeqsZCDZ
 4Exx9NPvRhUUpdFaMacPSNpm6+y0kZ+dqu1IoFKgBv5u2jW68KEnjOA/pHudmqPy/QKzeVIR8VO
 FOXgakPvtn4rttrIBI2pF/+SJA9JmpytfuqR4cyOo4fWBy/fMOz4EwNu3A1Dz
X-Received: by 2002:a05:693c:87c4:20b0:353:e390:e395 with SMTP id
 5a478bee46e88-3602f36b878mr917544eec.24.1792092723455; 
 Thu, 15 Oct 2026 12:32:03 -0700 (PDT)
X-Received: by 2002:a05:693c:87c4:20b0:353:e390:e395 with SMTP id
 5a478bee46e88-3602f36b878mr917524eec.24.1792092722842; 
 Thu, 15 Oct 2026 12:32:02 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:32:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 17/20] target/ppc: rename qmp_query_cpu_definitions to
 qmp_query_ppc_cpu_definitions
Date: Thu, 15 Oct 2026 19:31:09 +0000
Message-ID: <20261015193112.145326-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX9eFB9eTj/cUN
 JHLGZtS/YK15L7jiBoLrDyfh9f46tl6aHnBKeX9q99PhqrtchfUpik0JuCl+6OBcEfQGajGIYqf
 6ktKTp/yPjQ8rvq8WkxU+txMqXYVrKQ=
X-Proofpoint-ORIG-GUID: BgR35X7kQ0YBwldYu-t9nvYMnLHL1qSI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX8R6IOPlPubIG
 OOXavMugI+TgfI6lGJTYRrOidl3MCf6vLiJp5hd3RrtcdSrqStDUr8Rq6cgUQpBBD7oJ6erQzKv
 GoAzOLMYjV3VVdxUPbGYfxLoa7RnnotCUGAV9580WLlll+9vdS1n2wUqK53IxDaEFBJmz2CVhNC
 ZHVplTu0aGZ5oKavMpPqKS4RybGRt6Hdi8wzmcTnVpMDILFjHSqoWA2HE2MDN0WSGr+f/nwE8QY
 e2fbGQ8dz+7hk9j+4NXXn3TJrL7AOt6AI893d6BGwV6ezxI+fY9zGCe7fxZZa3XK8qJFwFqbZxl
 BqMuqg6qr2pRD9ul84kF6ric35Ku/m6BYqiKHPSqw/zb7Qf1kFBV1FJop8AqsFGVZZkSGHTuNuB
 Oruhx3Ki5CkMGZWR9C2mW0dUHjvU/jHxw997OK28NdG6V653boHPxLClWp7K1sEGo577AA+R7zs
 ro2Z60AWVAGRqUUibag==
X-Proofpoint-GUID: BgR35X7kQ0YBwldYu-t9nvYMnLHL1qSI
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad12a34 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=Sd2LGMzgzO9WI1_litEA:9
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
Link: https://lore.kernel.org/qemu-devel/20261015005355.62406-6-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h  | 1 +
 target/ppc/ppc-qmp-cmds.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index 4267adfdc03..fba0e11d5e2 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -13,5 +13,6 @@ CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_mips_cpu_definitions(Error **errp);
+CpuDefinitionInfoList *qmp_query_ppc_cpu_definitions(Error **errp);
 
 #endif
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 96228919966..fe35ae1ac04 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -27,6 +27,7 @@
 #include "qemu/ctype.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
+#include "system/qmp-cpu.h"
 #include "cpu-models.h"
 #include "cpu-qom.h"
 
@@ -53,7 +54,7 @@ static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*first, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_ppc_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
@@ -82,3 +83,8 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 
     return cpu_list;
 }
+
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    return qmp_query_ppc_cpu_definitions(errp);
+}
-- 
2.43.0


