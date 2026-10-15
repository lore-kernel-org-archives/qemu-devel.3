Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5188CCA466
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBo-0000J0-IU; Thu, 15 Oct 2026 15:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBg-0000B5-Le
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBf-0000bF-2Z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:24 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3N7U405986
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MWUDL2EYovqQ39WsAn/7cCflrE9pj+Iji0RnzjA0uu0=; b=nD7ENniIhu+C6x7R
 2Eu51jYoc4RK0ytXPvZzwRog+UuUOVXIpyZQ5QfiE15oQXEjK51yyhPCAWU7Z9Ph
 UADDkJDSIU/+eBy1xtQPBQwGBkSE/7wixj09sIikZlnaP9NR7hZDKtWgu1E6w2xt
 kYgXv6gcYZdnyg1Np4VokyG0aOxY32BtZnLTUEGAzPKufXY8nhCF2Dlxi9Bnn4sE
 RfKGsLlK5XP69RYhnQyw8NzFsbPvenr0KjWNEAJC96o87YMqNqnOLTLZnHDWAa+H
 4iI2t8yY/YY3WQXDrzxc6obSYkuhCo1K7EkBiNbyy5DAABmeEPFdVDLMhgM6Q6jI
 pTKNlw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa09t6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c3c370b17so6556505eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092730; x=1792697530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MWUDL2EYovqQ39WsAn/7cCflrE9pj+Iji0RnzjA0uu0=;
 b=KByeZt+n1FCyMd6WEs5S4Hoq3BuiSFXzqUXO62Ew8RVXPNl9HOY76poGpQhfoGbpXh
 DpHatguV0qckCCIr7GgTKX9wf1Cnz0isdh2NykCd8xO6s98xIcAdZeB5fQzBkFmY7GtG
 u4M0V7b2QlPzOqfQJRzq4GlX1+GOvqdsVRG3G66jtHGMjzaEWoxtCpChhMasOvAjT8nM
 MdmY6YuEsopKKJFYxA8YskjUghtdQzmXNS3/h9MAJDhMoi0AuRdat8bVAww0Uja0IUtN
 Nk83YwrYXVxSpGMS5ygLB62hPHVrOTtqK7/Xb0Xk823ZBz/quLVG/w6VpFxZFGtsGdWu
 Uy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092730; x=1792697530;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MWUDL2EYovqQ39WsAn/7cCflrE9pj+Iji0RnzjA0uu0=;
 b=Ff9wH+vf+HRocTBv5rS0vfZLC60aHVDkTmRe3b8k6HYFZ07rxZaPCfXTwTqZq9Um22
 dfeqv2ihb33+x+4HihSURqmY+ZhmI0m9qizrOW8R2zg2zV8guEohveYhxcxYcP3LGxYV
 ReJ+VNG3kbN/6XFR1H193H5nKQfudjRTwqez1vpwM1EYXecb473Dxjynlmn1+tUmCPXt
 6D3qtFUIHxycH7oJAjxEEchCk4qbYFhfdAx9xL70wlOAeP0jOVedE580nEvFcX1kWNLi
 KMX8391jvNKp4GKsEC9ufoZj/QRVSHDEKHsYFLSs2DciU3f8iUnhu7s5ltwjySsQzHYi
 Nikg==
X-Gm-Message-State: AFq9FYIJDkN1dln1r1AvgUNLs2WhPr9yp8RZW3E+YDbkNxEOiwcuHbQ+
 FXGk3QIZqTKDEOI8ZUKjPhAnfFc+vc19W6DWa0BYVg51HWjz8QGrkgzAoGzxGUZty0zN3fd29/q
 GSy354yzmkVRjFFcCGLZU7tsXNNHlM21vsinJ7uYyb4ad79tXcjUboQuGlcnDF0fr1A==
X-Gm-Gg: AYBFou19uIJOrkPAyNffZqVPaI//q03uoHeeBI6iBxBwhh7xfwkpycP101fYfBAaHtL
 OBIcEH/ZmaYaaNf9z0A5dlX9I2vq4FahPi9ehMZLffkBgNWswPZAhs9iYaaQhM0vj2C7RabBia6
 8sq8MLMkAiJNzEMaOL3+tBPwAA/Cf0sM9/u2MnBbdsq40kZAFnotDNvTdQcM8ZV3FdFDvcy5FTG
 NsRT1wT54YODl1nvP2HI2HVybpUWuXLrOlVDeIZnzQoOjI6GECCDpfWTAaNXoqspH+b0kEa9aaC
 mzpa/AxRH3SWC4TISr7teZnPnMmZV9sPQJV0IgLxJGp5O3v+wQdaqaDan8n6gD5wqY0/uhRSi7v
 6lsoxFBauwqAWMir+eOrA6yNj54LFdHuTiYfisFCg+Ctdq6ZiSnG6zEFaLQHT
X-Received: by 2002:a05:693c:4097:b0:358:8bd2:fda1 with SMTP id
 5a478bee46e88-3588bd2ffb0mr31817514eec.30.1792092729773; 
 Thu, 15 Oct 2026 12:32:09 -0700 (PDT)
X-Received: by 2002:a05:693c:4097:b0:358:8bd2:fda1 with SMTP id
 5a478bee46e88-3588bd2ffb0mr31817081eec.30.1792092725258; 
 Thu, 15 Oct 2026 12:32:05 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:32:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 19/20] target/s390x: rename qmp_query_cpu_definitions to
 qmp_query_s390x_cpu_definitions
Date: Thu, 15 Oct 2026 19:31:11 +0000
Message-ID: <20261015193112.145326-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX8kyag7pp6Z26
 bNUXexR8CjPvSROjHuunsKcyqrfzjW07rmewt/Qde+pMNsAbwhZ04QfVsqHoEtQStSErPe1RI2C
 KMPOHUoFqG3woXG7zMORel9xmS3J0Xc=
X-Proofpoint-ORIG-GUID: SBDHC3ztXWhMoN-y5soj0bx6R-L2KScv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX+7qBtOQcimuA
 +iL3E3ZO5tDsmqBVz7NTZzzafkF2jKY9/JkiUI9eMYNmkwVa0oUINNcJXonhhpfv+bdeqEtHlMa
 NPDiuDQshx6FAaw5a44/Dy+JgePgHEOVpHnDC/6BvB1ZdgoN2evopo/8kj0yEgV5ME9Gky0WBpA
 aBVUb+RuZMz1czCLvuSkLTjrmpNXFKtSnEmkO5ck7dLasTFq27Vdq7TLjk7HuVSmAPRgEwwzgOb
 Jf3OqO7OYDnmgw9ErzWW9LZNXF1pM2i4MJcu2CH+cGusyxHyzdCV3D31MdD55BHxTX77bt5fjom
 VIbGeUzbmAx/8v2UMLoxHlqOsjd2uqpKSnQ1kCg1Y1RB5RVV62khrp3oF83jpIezGIjrOu061F6
 hUMQLCG60ZJwMuACupS6knqHhrWGoI+PvxoTjS5I0ryFC+kFnWMfK/ZzMmXY6YG5L7HnGIbYPWf
 +CewdwFIQtDZ2pNr5mw==
X-Proofpoint-GUID: SBDHC3ztXWhMoN-y5soj0bx6R-L2KScv
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad12a3a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=3nHxi3XF_WlAm1CjsxMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
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
Link: https://lore.kernel.org/qemu-devel/20261015005355.62406-8-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h         | 1 +
 target/s390x/cpu_models_system.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index c1bfdd679e2..f0e0d427e3b 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -15,5 +15,6 @@ CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_mips_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_ppc_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_riscv_cpu_definitions(Error **errp);
+CpuDefinitionInfoList *qmp_query_s390x_cpu_definitions(Error **errp);
 
 #endif
diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index 5b846048675..f963ca5248a 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -20,6 +20,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qobject/qdict.h"
 #include "qapi/qapi-commands-machine.h"
+#include "system/qmp-cpu.h"
 
 static void list_add_feat(const char *name, void *opaque);
 
@@ -82,7 +83,7 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_s390x_cpu_definitions(Error **errp)
 {
     struct CpuDefinitionInfoListData list_data = {
         .list = NULL,
@@ -96,6 +97,11 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return list_data.list;
 }
 
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    return qmp_query_s390x_cpu_definitions(errp);
+}
+
 static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
                                 const char *info_arg_name, Error **errp)
 {
-- 
2.43.0


