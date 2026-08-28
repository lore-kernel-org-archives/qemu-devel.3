Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF7AC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YQ-0001Al-KE; Fri, 28 Aug 2026 19:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YE-0000fn-Ab
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YC-0005p8-Ln
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTEVd501634
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8qJP0WUIKum
 vhNB6y8r27scL/w5mIWitjEjQIjp2rBQ=; b=aqUvI+paQJg2Bt2hXsva0y+lakf
 ZyMgf2Eokp2gEqmFG1wi4bMJtEP2gxeYvKOJBnw7kj4xI1WqWMCxzEOr+JzKr2Hn
 tgN/8StNbQmTodcVEfsUP+Hd7/SfRav1l3dhxdLk75orpeb2W4IcLuAwpgCokxzg
 TqgginzOaJDoQFu/icCOsjWMKjDTncuR2ejWbSuFgusLnC3UymS4cznC0jQwvqJw
 GCkTHJavWmvQyvzlVkNEBFqB/P8Fr453OmOEQe1wswP7DEpUTnyg6Sgwp5e8xJl/
 8yPpMeJFesq4DUtyF9NGHsaTMekT4b+JTPVTg/oCw6v//KIrtXoc1KXnhZw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbgpc0gre-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d7151120d6so28374775ad.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957995; x=1788562795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8qJP0WUIKumvhNB6y8r27scL/w5mIWitjEjQIjp2rBQ=;
 b=IRVKqIvPp/v1LmcMssqHhoJ/f4avS8gB7UkejDY3+XdlvzTmY/1fpdfpfZYUnFRHfx
 +KOHOysrjojULJDbPkYWH0PY6vowra/1om10dmcjT6fysqcEh7VyjNWyggErOVCyoRdV
 9fS12omR5RjgjyQTZXAieaYYnNO/pr38k0xBOBdp2NqhVVNzCka4DDseOltltZ24m2aO
 e+fCc3nE2dqCpmgRaHjmgyEP3/t6JeED3YCsT1THyZoqf9tjQ3RzyreJp4SXvJ4f8v4O
 fGXfNrWnkLQAm8hTwkMrSAQdoyJmqW8vCkpL27G/JS4soGag8p/Jp2j/UMbNlUiE4id8
 zC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957995; x=1788562795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8qJP0WUIKumvhNB6y8r27scL/w5mIWitjEjQIjp2rBQ=;
 b=SL/ywzLx3KiC30eSMwUQ48BJ8tZhL+QRDN6uWUTxghvHXX9GtLnFcavb4L5jhJCKkn
 YB/NMLGs5KD82X9lq1QmMKxVqZd1IqOaiNnK/ehxZ/9Q1glhdtsGJQcMlmixEhez9ZUt
 Xqjhjb5ObwvekD6IHGD2xvcSe8CDuw0kGtJNF5DFvgzXD3sX51gvWjlo4PYUx5lgf2Xh
 5XSR/oZH4eU0NgLRnPcS8tdaqoDwlZ4kiButSylot+Vm9Iic12TyrVE8YdNKoRJQDQiK
 DbFjcukqXjBvXan33c5ociLVYhTphcglYj2v59KMKwkGjEGzwqTCYdUCrDb7cdG44VSq
 bmwA==
X-Gm-Message-State: AFuF++m7zy4UrHYjtmwtqDkQBFJYmvACoHtGSUWDwb7LzDr0N6tdR9Nb
 ckMrN8qDYFw0ClcMAwJWslMHd/kmYoMGMmxrvbu7HTSNIXzEA9qF3LGwhKVqepGkVyjXpKiVDeN
 SNTJT0t3OB4CbFu2GqKSwWouRglcCHj5uJgOLCFyRmjnCy+NntL9qzxXtymK1MqQC2A==
X-Gm-Gg: AR+sD13arikxKGqlyX6LJG/gOAuZw45YtYj6kVNvIo+DVZce91hysSvdJv/+ebXWihL
 YO7MAh8mrs8jF81JY3qC2x/mrj/yOspACCUrYOKCj5/KLsiwz8R5hddQfah+bdPRRErapLIdmkN
 C7vN2PI1oasTAl2X+jUJv+ePJiolBaOCMbQkb/A28x1PIhOH8inbdZNtxhlxTflbGTAmIwwrCIZ
 6CBEmH+hHzWFS6tkO2HoVdXk72tluQE0HaBE/xHCoFlWeLjQAQ3O5xFElm0WpoEcxMd1yba0Uys
 flDGBfo9JGNJPfCUGNF/Ry37PXSTykb02Aq0GYRLmVQ3+iBbyhxEsjAXs37B8kiRkZrPM2CU53g
 TBjY+osOsVYXWfm2IuY63GhjBy7yBZdHgzvfsUxnX+ZTHph12nv8nWUVDlyY=
X-Received: by 2002:a05:6a21:e58d:b0:3d1:af47:5f74 with SMTP id
 adf61e73a8af0-3d266eb83ffmr21263834637.6.1787957994699; 
 Fri, 28 Aug 2026 15:59:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:e58d:b0:3d1:af47:5f74 with SMTP id
 adf61e73a8af0-3d266eb83ffmr21263801637.6.1787957994297; 
 Fri, 28 Aug 2026 15:59:54 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 37/47] hw/core/boards.h: add available callback to
 DEFINE_MACHINE_EXTENDED
Date: Fri, 28 Aug 2026 22:58:51 +0000
Message-ID: <20260828225901.367438-38-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bmEusbFsg9LxRkeNkflPFlLnxq80lroP
X-Proofpoint-GUID: bmEusbFsg9LxRkeNkflPFlLnxq80lroP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX4Q72x8GmaIoD
 08NDaqss8ygM7SMuT9v6Q4FbmFGSo7smEUl/kNMS+9BBw1MvoXpwnZ7fwORPBbo9xIXPvNsILIB
 mHj7jZFVovP4MwfOrYRduoDXt3zXKrQ=
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a9212eb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=E4SIj56ecO4WXdA6mQYA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXw3BFaNmXHhpN
 sgyuE9wZqhd+l3hxuMW2URugKfAmg95ZXKL9NpNEAxTxjS64M53O5eNGX8B8jrTHag1mczfapcN
 dseY3C4x2qnnbO5XG28vbasCIkxKiv/meUmXUxIWI8EjorhViwdShM3q4X3TxpfsIhcZyjj+mNf
 LITelyqGoyRaUqquHZeuk0mhxK3fcM714A4KKu+dIr4y9pEqQqmcZNIU/aMNp/ZlJDHMfq1/yeu
 mJaZYurSQP0qaj54ieQ//IzK7sJxo7ucWBsxM77em/6XlzgrZVUa5s6iPbj9EbUaq26fjGQPWO6
 r9xWAX4vZuJhvbQPHhnfr6dx8zXkmJjy2tc6V/nI55DMvD/l7vVmQHX0r/efjwdkhwG4iuI5Xpc
 tuimKYBX2kYHw3uN23vqqXNFW6iZhSjL/PgnQn7+2NGFDRWPM0fVSTs72WQUCC6IeZO7CJ1RCri
 Vl6kWRI26N8U8v4aDWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/arm/bananapi_m2u.c    |  2 +-
 hw/arm/cubieboard.c      |  2 +-
 hw/arm/integratorcp.c    |  2 +-
 hw/arm/mcimx7d-sabre.c   |  2 +-
 hw/arm/musicpal.c        |  2 +-
 hw/arm/orangepi.c        |  2 +-
 hw/ppc/pegasos.c         |  2 +-
 include/hw/core/boards.h | 10 ++++++----
 8 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 8f59111fd4e..7b86986efb1 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -153,4 +153,4 @@ static void bpim2u_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
-                        bpim2u_machine_init, false, NULL)
+                        bpim2u_machine_init, false, NULL, NULL)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index ae27056938f..da45bb2be52 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -134,4 +134,4 @@ static void cubieboard_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
                         cubieboard_machine_init, false,
-                        NULL)
+                        NULL, NULL)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 382ea7850d8..6314bbb6c13 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -705,7 +705,7 @@ static void integratorcp_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE, IntegratorcpMachineState,
                         integratorcp_machine_init, false,
-                        NULL)
+                        NULL, NULL)
 
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index db8a62e5f6c..2c884b5c78f 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -87,4 +87,4 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE, Mcimx7dSabreMachineState,
                         mcimx7d_sabre_machine_init, false,
-                        NULL)
+                        NULL, NULL)
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index e1a336e861a..52805e41892 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1365,7 +1365,7 @@ static void musicpal_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("musicpal", MACHINE, MusicPalMachineState,
                         musicpal_machine_init, false,
-                        NULL)
+                        NULL, NULL)
 
 static void mv88w8618_wlan_class_init(ObjectClass *klass, const void *data)
 {
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 7a19732f5df..87ed2ef4b69 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -134,4 +134,4 @@ static void orangepi_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
                         orangepi_machine_init, false,
-                        NULL)
+                        NULL, NULL)
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 9d7e279123b..ad8aca85ab3 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -788,7 +788,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
 }
 
 DEFINE_MACHINE_EXTENDED("pegasos", MACHINE, PegasosMachineState,
-                        pegasos_machine_init, true, (const InterfaceInfo[]) {
+                        pegasos_machine_init, true, NULL, (const InterfaceInfo[]) {
                         { TYPE_PPC_VIRTUAL_HYPERVISOR },
                         { TYPE_VOF_MACHINE_IF }, { } })
 
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index a436d48c8e5..2e2acdb6867 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -514,7 +514,8 @@ struct MachineState {
  */
 
 #define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
-                                machine_initfn, ABSTRACT, ifaces...) \
+                                machine_initfn, ABSTRACT, available_cb, \
+                                ifaces...) \
     static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
@@ -526,6 +527,7 @@ struct MachineState {
         .class_init = machine_initfn##_class_init, \
         .instance_size = sizeof(InstanceName), \
         .abstract = ABSTRACT, \
+        .is_available = available_cb, \
         .interfaces = ifaces, \
     }; \
     static void machine_initfn##_register_types(void) \
@@ -536,14 +538,14 @@ struct MachineState {
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
     DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
-                            false, NULL)
+                            false, NULL, NULL)
 
 #define DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, ifaces...)\
     DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
-                            false, ifaces)
+                            false, NULL, ifaces)
 
 #define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
-    DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+    DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, NULL, \
                                         (const InterfaceInfo[]) { __VA_ARGS__ })
 
 /*
-- 
2.43.0


