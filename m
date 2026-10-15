Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F62CC6B2D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9jo-0005vI-PY; Wed, 14 Oct 2026 20:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jm-0005uZ-VO
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jl-0002sH-E9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EGZiki3468853
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bXzjab3ZQU4
 6hv60v+ru7wxBVGlk7Tam+gv7K5TR0v0=; b=Sb3szfXmSV4j0CZ/FFutoal177c
 9z56C8jhlWS4G8OueTJ90C+jEIqMKKHhUVrc7cWQkh4w6edd6izdxSalNx0RJe0x
 5xqu9aco1MxBOZ+X3hzZBWpHOEp++9OqxzRwWhB9LfKff/ZCy65h2b8wGXFaJt7m
 x14MDhcz+A3ugsdaTUuKGVepLB4LSrrwJ+6VWsGupIP98mVDTiXaldux7X2jtB/N
 g+nAepLFEOv0trdsS7g65JEu79h5ZdyWlNImJGxb2Gs8Wg7WQJyFxaPbAm+s9mqw
 FMN1zEwB8CtjsSEwPvgHPM5OMA8oIKymJ1fOyA2lICiwBQUIMqMUZnjQVRQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd79mp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so4967627eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792025663; x=1792630463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bXzjab3ZQU46hv60v+ru7wxBVGlk7Tam+gv7K5TR0v0=;
 b=Jpg0YuCtNwSpzvh3Ny+jCQif7Ezzyq+9/MJWAbrV6EdbaVtCQwX6dc5VgoD3IGkCJL
 3BjfBOeIK3gexgC9HNmpbfUQGNJ2fhDOJembprzDQVCD/cKsA8EKKC7GDzustPvBs61v
 cifRXroBZhbX8WbpPSDsYyHBtgUNFNsNR9EAHqI2BXx3R1JPyOb+fyyD6yP/2IP7CpVO
 9M+B49D6Fy6KoAl5hPGLC1BpdFDWDAcnLk6tIZPNVxrBywNl9vQXRAc/rbuKO9xR6/f7
 2XGzPn7MCk4OhiCrxNhnJqLAr65AaEH84Y1ihuUSeyeDPzhN4R+fo3ySP1xPdI32veVr
 nwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792025663; x=1792630463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bXzjab3ZQU46hv60v+ru7wxBVGlk7Tam+gv7K5TR0v0=;
 b=xRiqi+Sfcq4Yw5P9KUj+R7m1kVr9ERwd05WhjAsTi6/UzlUg339J0mBtCCo5QBrXIB
 qBl9IFVCmtjZqtbza1HC6tURoo6Rui0lib9KolVxFqJu87InSQfZs/tVoWiBALWibb1r
 p7jiTFFwWg++AmaznFdfbXFhsaT/8xWnhmuQxbIIetzVjj6PAWE/zJQny3Owl9AQ+vn/
 KCSRkPYiy1bZribykwgg0fXfLOuQlDX5ubZIWHV8j9NwFIebqlMDsqKTGCChqOw9NleZ
 KFLetYHcsV2dDQZtuFwZqtLEE0scnxZSp+uf5TFdbNGYc9v9ktxFM+xorMEO2uEaJGu5
 FIzA==
X-Gm-Message-State: AFq9FYLsQQLYwqIPGpGVufZkAK9DiKK+TWWCylGMonvFYwcVdR6/Hmn/
 yU1vCvvhqORkZWp8DiMgLPh4UNzDHb5rqWtFvPq0SnurYMJ1B7fiUCIYzuqofjXGWnvXUf+Rgyh
 UjuHvAU7xSBBbfsKmkpzQ6NDgSiWzxRU//mmP8nu6Nt4aSHzm6ZmQtgF4zyZ44uxaYw==
X-Gm-Gg: AYBFou2csLJeIbf0/gcwFZTIEh6Ih8/OVQRw2h6Ubf30WTxvHVs+eDlEhzdoJQXRMdd
 egY83AuViv3hL9kz3x0uwUUO/EJAcyId24ofZs6u+/jc3Gb86cesmqHWV5M8LXQE9gmk1eX1i6i
 RWbsfbYaqp1j6UvupWg0unS2FHTwpi7NZVJAkVhTPcaOM6mUWxSg/Da11nCEZSmumfUm08PNMmi
 1bQX6h8ZutfDdgHUJqLp1AUjfB69xfmF0byGwI3Z+qgs8lK/GlrRcyG2o5foiX1hzM9FuvBuvWO
 ZHAbPQ33aUgodaK4Fi8KU2qHMe+aFXZDCfomuzR8SyQ00rM7qe8sacQobUluMMfjptnHVNZC/vw
 dO2MFdG+fMsNjoQDJn8HMYSrC+085pXLcJfekGw9jE+X9lZqABxz4qfLf2fEp
X-Received: by 2002:a05:7300:8803:b0:353:7b46:4819 with SMTP id
 5a478bee46e88-3537e032905mr28052254eec.8.1792025663008; 
 Wed, 14 Oct 2026 17:54:23 -0700 (PDT)
X-Received: by 2002:a05:7300:8803:b0:353:7b46:4819 with SMTP id
 5a478bee46e88-3537e032905mr28052217eec.8.1792025662278; 
 Wed, 14 Oct 2026 17:54:22 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cacb61asm60487033eec.21.2026.10.14.17.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:54:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 6/8] target/riscv: rename to qmp_query_cpu_definitions to
 qmp_query_riscv_cpu_definitions
Date: Thu, 15 Oct 2026 00:53:53 +0000
Message-ID: <20261015005355.62406-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6ad02440 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Drpi8JZk3zr7esNuAscA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: EE_yw1Qsi_Jl82HN_1mOwxgBEHb7Lvfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfXyQX+2kYIf1HK
 xD46hIYLeWNSr884YKx11NZDCtsOmNgGJWHHmzED2B6DxNcknsAlktUk67e/ZyO0IczLjrXMyWW
 rILj876bGOFccSTqYa/XgNc0/W5ghAgopuL4cbP0Heb1YQJ7+DgpB9OeUTBegKDZ/RsUoP7YTM4
 VYNI5773nI9SWyWBl/+eL+XKB9SRsV54dtbjZuu0fZC+eEKne5rAOU2s/bRYqrUvTsFnrqQSHMm
 q7qGVopn7NTlhU5QVkHXJG2n3DIsoqilNePBnkJqWh4TqAftgTGWyA4HSSNu7Q/MMrvmiWO1Kmp
 aDIPDIDXOLsU77UnfNqPFecOAaNDJrVP6fzHWaduc7JjkUDEEub4cB8npZXWgq8cOGeFTAtQssR
 ltHQQR1MwWFa8Tw9xska0JQ8nh2+o7RWL4ftO4vdY4z6+KhYsonLJIanCEwIhQqdUFw2giRrIfF
 Q7gizEsQ8GRpwNgJaJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfXzJTHULwypZgr
 KSaZghnZhTT0eX6KH9pfJ99d/mc7Wz5HBHM4zTJ6X0+W7SoTo8NR/omWCEgEj4Lt1/g79Jm6ht9
 eCQwEuRN9g+I8V7ebN5e6a79RR8NJ0E=
X-Proofpoint-ORIG-GUID: EE_yw1Qsi_Jl82HN_1mOwxgBEHb7Lvfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
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


