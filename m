Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2E8CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9jn-0005uh-CZ; Wed, 14 Oct 2026 20:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jl-0005u8-RR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jk-0002s2-Au
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F0986A1672580
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HSdUY2jVoRP
 iSyIZzFREqWdYbl7B0feSleXWVWmuHAg=; b=Z4A9AOG8KZ+9oLvTAe+1QQrpjsd
 Yrp5yrL3tugzKZOEmrrxgJ+oQTQ7uLUcxua1Lnf7yBA7mFC02qdimGZadduQF7nK
 scYIaZiWZ8482dEJMTp8VyYcnej6uuoFopIkmkAcCsR4xqgYC6CJzLgL9DMwGrOl
 q8duJ6Iw9wrFKH5+XRL1fZg+J8EWWRM/S40gsWitqhZzisUTafJOnOkASA/EVsxY
 iGJFIpuWhS6t9WQpxLxmKej6BrXiRhSkqTYAxXXI5BBeI4/m5blPUMs1VUqr2CCE
 baCORetGC5R/pJQRdm3npZr8KSwtjcXkosJHOWcP1Mxp86RUUE3rgyT8dVg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacrh9sh9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso7538883eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792025662; x=1792630462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HSdUY2jVoRPiSyIZzFREqWdYbl7B0feSleXWVWmuHAg=;
 b=T+EkJpMs/17yNGXNxXuTfWlIz+arlMQYKSj+w5znUbX0dZECCXztUOBDVTpGPWyDf0
 W4Yrs84tr0f8SPxlGOgXF+ugQ4kbVyfkSmbkjLZrCEfp2tiko8O/Z1a8FOgsNH1KoSig
 jx+15ZAfpQH0ozBtnW3RZJr/c8/85MV/JxiQC89nISJC8/oYYN91GkFhuJHR6fjE2CVA
 FQIMvgqLjCEBVybdbxJBbxyuGf9tlTlQRmnc9uKzXdRUvPSYyWMsYXNGwj8dJCMJoF92
 +CusGZZTQy2erOhM8QzW0X2MpKwFDHH62aHGKwPLhjqXq/GUCm+plFar+dSa5h89/61x
 1Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792025662; x=1792630462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HSdUY2jVoRPiSyIZzFREqWdYbl7B0feSleXWVWmuHAg=;
 b=z1CQe01iTjb1SqDMPhXSUcdLvZzu1TuVHifGTMET0u4uVmy2TuiXPcQOqLiAt7hAB/
 4W0a/YJLWfUEW6wbTPfeCOdQ03g02X0yQpfXza574dxekazOdvAGFZ+Xad5toKtO97e4
 dcR/MHl08P1+sunIwvSvGb8+2lbqLJE2l7JA4iEACELa5/2+AaVq8A+0jyvRgE2a7TuN
 PGD3Y5x7uFppO6EKFF0PJB37/wOdamDR+Wp7WVTNVM8kbffgKlVoA4hjsprqacmvAzxF
 L+OwJJ6z7RFN5oh68GLr2kITlflJKRDwnqLnyG4SRq0Fyejq9nnFvGCT11YA7fircQUg
 HY1g==
X-Gm-Message-State: AFq9FYLpcd/berM2Mn4am7CWCobU/eIy018zAMhyVlQ0hIBk5CVEx7Ip
 Me1imFVQ1aBCBEkPQ4cSQx/mt+dg88fCTeZ+tvQ7zabw4vlC/FT/K7WI7J2LOrZNU75mqa1g0Z+
 8gv6X6jt86IDNg+/31im4XUgURjelbFJZCNUYZisK0AguP5C0OkVn35w4II9gt6DYpw==
X-Gm-Gg: AYBFou1IocDrtb8mCAa8MgU0XsrwGVU5SuckA1yFbPbDmaMET0JkNE3cEIOrOWnmGcl
 iBvHe+LDH+qq2bAs2F6Ls5DSkcjWzg0z9lbpcZNCEiUXyHwPLYqrX/XhaF7rGD/BHuk52a265/p
 7B0j6ApeRJAVbPNRd4MzblTP0zsWOiqKNb50WqTae2kUKTOuldzM3XaxNrCa6+v79qbQqhW1EvQ
 SSNKmFyVRecoZagxvuFUNvHWNRDNCaX5VW1q+AhQDeYDiCNk8ycyE+1IcgXWUgx2teUAC0Ez99c
 ZRALUnKShDAAw+v8ZpDhkTWn4S15xU47VRE0LO1yU4dVUeQkRvuDZQQRwrXjf5LwuiIzoVQuWtp
 WmnIAQ4vm3MgYKXR74M7bP0lSakQilvcMi5yZ8b6nX0Yy4yMXV268ajlvWrvk
X-Received: by 2002:a05:693c:2a0e:b0:34e:9923:e372 with SMTP id
 5a478bee46e88-3537dff9325mr24244754eec.29.1792025661661; 
 Wed, 14 Oct 2026 17:54:21 -0700 (PDT)
X-Received: by 2002:a05:693c:2a0e:b0:34e:9923:e372 with SMTP id
 5a478bee46e88-3537dff9325mr24244726eec.29.1792025660920; 
 Wed, 14 Oct 2026 17:54:20 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cacb61asm60487033eec.21.2026.10.14.17.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:54:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 5/8] target/ppc: rename qmp_query_cpu_definitions to
 qmp_query_ppc_cpu_definitions
Date: Thu, 15 Oct 2026 00:53:52 +0000
Message-ID: <20261015005355.62406-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bV5ykD9Knc1mFhyapt1eHl8hW4s7n0e1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX1NHXBuHlnztJ
 VPAQl5X/W5uOOR835zPccqSUlPaMmeD/2B/foJPQfAhWTeDnuhb8SwlZeQR5Wqjrj76VPYOJLnR
 4JYLidvHqNJKcSWky8vC8VSzHD/E8ww=
X-Proofpoint-GUID: bV5ykD9Knc1mFhyapt1eHl8hW4s7n0e1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX/YDD7XzWfcx3
 82s2ys6DOZ+QF4TPacOxFNUcbX35MfmxzVMIsVs6EAfNMHMAYaqA5Q1MdKQKXIGJFyYBlWBXuAY
 t/P07A0JhKtfcbjHrG+nu/bllsU3Uxmwzh9umoWnmovsriwhdx71u/5QLAB1VKb/81wlCFF2OOX
 cR3nRAgbLCvtO5fDdsG01vEfUXNttICnQUBPw6cvkrgXdheJH4FrbxvtVvs/zp5JBpwxVQzQX+5
 +/liRqQEVAUN/Hemd0pqgYIJaNpQple5V5SHfV1nkwvbx2zrAALEXu8Ei0ltTQxi0s2/GYTbNXr
 Rc4+/sAEHMmTC9vEtXk7htVJP8K1EH5awmc/yrHC1mokvMI9XRnoyzwotR/9mrfN40bcFw0jb34
 LI7IDVOB9imLz4ZYFzo9Ri9OAXrIgTJ5lY7WoHWd9+vFZrZG1scVJdy0YpDU+R1Iw9ncWUJJhvi
 hdMtEv/5saAn172/OWQ==
X-Authority-Analysis: v=2.4 cv=SYZi5fRu c=1 sm=1 tr=0 ts=6ad0243e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Drpi8JZk3zr7esNuAscA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150003
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


