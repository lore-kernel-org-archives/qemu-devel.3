Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B4BCC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9jj-0005sw-Dk; Wed, 14 Oct 2026 20:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jh-0005sQ-LF
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jf-0002rF-MS
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:21 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EMF2up500312
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=w32uqNgH9If
 Hj6DBIncg232to+oUBb+wslNFzeB5nEE=; b=Zv+n19Top10daoa1NYYrEahY9y6
 GBd4VO0KstupedkQezsLWQzarN5zC5NBL/xBvHBEvnQUycop2LsH1XHc60hggwce
 1IgKcs7fuSXhQNGQRbnkwYw8ZIoLSoDJmdY1fiA3OiX07AuDalNqxoKFFkK23SPh
 GbtxjQxPyDoVMAKEHu2C5aoQe2wVUqUtUz67WsMB844ZH1KDfX8QG90CSjdp0Ky3
 e6j2itGA5j1ZDnDl67Mlvvdll5fe/rSs4iL7z/I2QWPD0tukBP6MEgftA6I55gts
 6j7hQzkFY/G9pravf8oiRtFYE/Y+PsvzY3bdomy39O0PfTeQZDCVlh4okpA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf2ep0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so9628604eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792025657; x=1792630457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w32uqNgH9IfHj6DBIncg232to+oUBb+wslNFzeB5nEE=;
 b=JNBDkx6ZDtNo5rub0ztCGsI69ZC40Irfg06o5oRYki5QIfV3IKZX02GUzGKlYt7DdP
 ro0jyTEN5OBzDA/TaeONvV8SIB+rzWPF/Mc1txVQujBcnsxe65FGHYaYn5B4F212qMsP
 Yvx16TH5cTK7IFoVWt5NA27MaEZR2F8+G8zXsenkwrwITBO26NWY8+gvb+6RKz5VTc7d
 huYIdCNSigx/Aalcpgtod2KLQFybYpfAl3BwjUjJYQKv323mUCMbeZIIMhD5IlDK6ijm
 A1xT1WZ84yP86SsNBJ0Fe+vZ+Q8PNiRiPxJq8STxk3HOL3V4AE3/pQBC1v04ehcNlXBI
 hAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792025657; x=1792630457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w32uqNgH9IfHj6DBIncg232to+oUBb+wslNFzeB5nEE=;
 b=ASayHBh8/vlgfJrEovI0HmFzDe+uQcAAyEDqx9sw+B645mwxg1E5Lx5mBAs4GRij4A
 qa+qNILDTEp/LYJ0n1gCwDrDyVQxzftxF4fakfK9e6vW7xfhhrVkf4Wjrbw4qj7OloZS
 zMorPUmL3PdCE4eHp3UIRWqTcZO7owA4sSqJfCqBAR70G6VdT9d0gDrlADnKoRCn9Y12
 ozKuvXYUBMSMC0za3s92f4/lNzofm578MnWzUd9WZ3pxdNkPXLieiMNJeh03bk+VEiy1
 RQot6Yl5IOJlSacpjawGC9z+RdvGFy6pUkTEqwsdbsf7Y0aLNBas7nDK9Nd0s0u7yT2R
 EYHA==
X-Gm-Message-State: AFq9FYKf9/rTP6Pf5FtUH8ZIY648tS9++hEIS0+d2ekBqcwVZhMBZkLm
 K9wU7uoYYtIkMi6Pz8Bx/sC8ajzVcaYufwy/mDHTCCTQ0d3BFzAZGyRCeA1CKCJudtLNWnsXuQm
 LtWSg8OYdtUGsIREOoD1/Y7Jr9RGDxx33Zun1bJh+YRkkKSMwq/rixwkmuCfJqB9B/g==
X-Gm-Gg: AYBFou2Z3LRk/WoyNVIT6LULoDtnn4xI6V3LWrtJOvnYBdMZF0c3dghvGVNTY/D/OD8
 S3KgtNv8iP1HW705WROC6VNBxAA0l2zB6F5/x8KBYLhnDcxpVgWMFH+EwDOcdWbu/V1+0074P+2
 7r8g8hTQGDUuGD6n/9ylsQTNdlVXWUBOHxctV89lcxSXy/u7ZoXBVN4AF0qfEVzt7dy0QahmK4n
 1+madW2nro5Dlkw/3ICbwsX99F99XzswitIKNa/fFXoZWCMfLXlQ9UCHq3YCzTFOGzvEIgBLVy+
 mLNrPFu/BnuMTbSKs1nYVz0ZiYzMhxOfbE8aOoM4FA3jdoyH3oJfQnCZnDsTebfcVDW4yZEBK9T
 2MvMnRX3iQM1muvTrG/SACrR+igwQG0aSEpEXszLsyfcEYiNq1ZX6gd2ICWlY
X-Received: by 2002:a05:7301:f24:b0:351:595:750b with SMTP id
 5a478bee46e88-3537e2964f7mr25641084eec.36.1792025657328; 
 Wed, 14 Oct 2026 17:54:17 -0700 (PDT)
X-Received: by 2002:a05:7301:f24:b0:351:595:750b with SMTP id
 5a478bee46e88-3537e2964f7mr25641055eec.36.1792025656787; 
 Wed, 14 Oct 2026 17:54:16 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cacb61asm60487033eec.21.2026.10.14.17.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:54:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/8] target/i386: rename qmp_query_cpu_definitions to
 qmp_query_i386_cpu_definitions
Date: Thu, 15 Oct 2026 00:53:49 +0000
Message-ID: <20261015005355.62406-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX8eLHjU6GCjYK
 kVcIM2vXHRbmzXdKqwtoNITehlIb41fxhbfRMyBxhZHdFv2AOLG6m4vJdEYqPxWtcutL2YGFV8a
 hA7rWyusGRfb3d0bPDDZXGZABv8W12ACWz0t2GPl15E2GVWwga84ndEuGnHTMoNgQxeeIsUDsE4
 ldbS0moyRx9cwMWMwpTHVeveFv+lxe3LSdc5CyL8S3U2OF9E+NosICMTmSBcG1EUZmROS+siQ6g
 HkcMGCnFVuC6TEEQfvXIx+rJG1mz0zW2a5rkb+C7jy1BDus8SwEOq8leOmcWZQO8C3ltPgW1WLy
 8p/b9dLPMR40nM1eFSLNxa6Z+m4I7vP55lmh6KxyvGR7492lN7wH3r8s+5gMWLy/73TSrTpY9JT
 KoCeWvtoX385fFaFQ9h1o970gjS5HDd7zhdyXqFHtTrLVrxM9oQiA+EFU1rDgqurWddT0ozxpS5
 SpWPznv/GG+lCGHh+/A==
X-Proofpoint-GUID: a_CGoBYfA-vM9m0cMGoVbMSKVNP_5J5J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX1y5Xpp/y2i1I
 SIESeHrKcSzNJIgmls4m7XGJ85JdCu50nSyuHyGm12OjqjRllmbLuBt0N6TIxz7D3pTmKoRj9pw
 Auhuszbw2KOWsvIskDYZdi++d3uWG/8=
X-Proofpoint-ORIG-GUID: a_CGoBYfA-vM9m0cMGoVbMSKVNP_5J5J
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6ad0243a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=MS-RIRMcFKpjuoZhfecA:9 a=bBxd6f-gb0O0v-kibOvt:22
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
 include/system/qmp-cpu.h | 1 +
 target/i386/cpu.c        | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index e969aec667a..84b78c3a097 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -10,5 +10,6 @@
 #include "qapi/qapi-types-machine.h"
 
 CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp);
+CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp);
 
 #endif
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 74eebeabd7a..dc762b802e1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -45,6 +45,7 @@
 #include "monitor/hmp.h"
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine.h"
+#include "system/qmp-cpu.h"
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
 #include "hw/i386/sgx-epc.h"
@@ -8191,7 +8192,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list = get_sorted_cpu_model_list();
@@ -8200,6 +8201,11 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    return qmp_query_i386_cpu_definitions(errp);
+}
+
 #endif /* !CONFIG_USER_ONLY */
 
 static uint8_t x86_cpu_get_host_avx10_version(void)
-- 
2.43.0


