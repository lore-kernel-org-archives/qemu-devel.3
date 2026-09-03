Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB92C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24wC-0001kA-He; Thu, 03 Sep 2026 06:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24w9-0001Xn-2i
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24w4-0007AF-TP
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:52 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHB4q3203946
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HA+XJSWbjcHb7R4u/tuv/6HM6wdwZlyrREk/MyyWZfM=; b=Bu3OIJvMRIL+Lkdv
 nVcuXEpRwPAUmm5NwKzIL4yWb2yi4J5SbQWUERpelJUsK4BlH+lBSgwDRi/CwdC8
 0a33cX128/e4wKMRr7k0Q1U43un0pmDDSaCYS1bMPJxKeGSK8WNOzRafARVzd5jU
 Yhv2lKGgOIc+UjojIDJ7in6ypJ27HLGoGoAukEwg4XQzeRmTxDv24PNK6FTWKCRK
 z/GzHips79qfeXLFsdiRnyixH/lbkSu/yeCfmE67pSlEJxlbsvPIKzJhVzD0wTrq
 bfmBe1XHpQQjc8opn5VtaCDnINkzvhjR6FThmE5ROfQwJILWvi7CcFPRyYvB2QLz
 dfltdg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d10hn7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:44:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e820609d9so447692085a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432285; x=1789037085; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HA+XJSWbjcHb7R4u/tuv/6HM6wdwZlyrREk/MyyWZfM=;
 b=eS2BqGa3cLULd6OJCTyblzJeqhsRnC7iyhfZ6POuOygHBtviqw2GEFX+c4/+vNY39S
 4HTkHqKgNv90YmAIdGPb3ujndszoLul88SMksF4P+2UWbhZLODyX9orqlXByqwFNcX1E
 m2ax0w/p30h7JTX/Be7p6YvwQtQmRHohNs5qge4xe85gh/kMVC5ysH4mHx9WLD/tmAMv
 H/y5r+zxAdR5wTvX6IuELGDdEeIjo4bCT+h1RC9X8cBnWRee1SOHkmrJ29mq3z2JOSEG
 57/kLIzThSWhZV/OrR1Ns06R5o9u1OF35jSjUL3fVecsnr+BtO2V5sFkTQe2Zzox0x6T
 ij7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432285; x=1789037085;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HA+XJSWbjcHb7R4u/tuv/6HM6wdwZlyrREk/MyyWZfM=;
 b=CTtIYx/ppAWiSfVbFyi5QS+3JgTWKiLcXswmSf5dzOhyhjftIKRU3N6jCbUFQgT9+v
 KYmtERyEISbWPoJO4K623mMBMrwl1TouKoUMgKP7HNU1DfefLRcWU8IBjZAXLCROc7Ue
 ZafQskJR2q6ZeZ3T6uWl3LDLmYmXWJ9pMGfc0JmhwLCiiHdwrryA7zy5NQ3gBrK6R38W
 E+IIO60j4fvQ1o12LKmp5hqTiJaJth/Mj6kckrPWaPjxlYRGy8m+LUPyAHB1XvXRFNSq
 0JoLNJWRqIikNe6kssQsCNbc6+WHwre0pZxXRPxOpvRoERMlP4KUoqdyNEkzVzThpKYG
 7HSg==
X-Gm-Message-State: AFuF++m87SoxYb+Smj+nBZaOpZ+lEqVTtGjx8wnlqXDv8oYHt1dA2bvK
 +MaduIpWIc5qDB3VfmXLTfJ2zyv7WvX/0FgY6Fio9wbsXGwt+CTdScrSa1oZtRm51XcY/0ZNg/i
 U2GciJJejrMmSZnc5tlYiKoegcjQIbluNC4R+FK9KwZ6q/G3XRM9KLZZJTzOqbf+kyw==
X-Gm-Gg: AYBFou2RdoQBmcAxC69yQWP2d4+9F0tYM6Cp1OArB/cIaPQgXzAZqbAfu5mojyqaq/V
 2nuPvz4gaJ/zsefcw9xN9muW0WhHKY151Xyze5I/BmIZ4LEnjeQWDZHBI/J1/WhVDBslLP405OD
 z0QUXc0uUDxkyx/gb5qsdGprwW36gZizaot7VFLBl+cOxHRRFZ9NhnYs+W7zrt+p+NdrH/Y6OJs
 MwNV1HKYnvOP1yhwntbYMUK0HzynnI05HTAQcfFKZrprjDdyW5n7GWoE5tkQGCLJWw8YHl8yRQP
 kplZHEeApEQun3NjEoKgkiAOABzmCs8GEKxuQxvhe+CmRVmnWOLzcWraOlxpsnv+GYCqBthgv+6
 GnQzm3msPW66iXA8SlnFJyZWkxQa/sTh38TllTx9/
X-Received: by 2002:a05:620a:916d:b0:939:6de6:9515 with SMTP id
 af79cd13be357-9396de696dcmr513869485a.44.1788432284817; 
 Thu, 03 Sep 2026 03:44:44 -0700 (PDT)
X-Received: by 2002:a05:620a:916d:b0:939:6de6:9515 with SMTP id
 af79cd13be357-9396de696dcmr513862985a.44.1788432283916; 
 Thu, 03 Sep 2026 03:44:43 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492cdbfbsm12900853f8f.33.2026.09.03.03.44.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:44:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/51] hw/arm: remove {arm, arm_aarch64,
 aarch64}_machine_interfaces
Date: Thu,  3 Sep 2026 12:39:25 +0200
Message-ID: <20260903103936.62355-42-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXzk2eB1Y2CStg
 Ywcfi5GJXd+TUb4zOP9q1HCXLwBzQxNDMSead2DVCduxbf565pdzEwNL6kbH13rpEnr1qDpJPWb
 /vSdb+Q+wQSUlXR8xo9UggpjclpXvkYFEd8Ib1VEEPa7w+EwkyNOLPP4xxfMzS3HPCbGRLOUkVI
 ra+aga3Srgg53+dC+mksm4qhJUwcDGA8rnBJ7RQJ4hBW93z7A1bsjbJCWpHxWF4mV4TFAobnH9u
 QwYDvJTzNt+U7FSPzRCXNnQIXUtTG5pNwbHc1/lhU9O8IWqidypBjcsO4dpqtILvWNzB/4fdiUu
 +x1/tXzsmwacpgizl9OlXNokGTN5b/75R8WrOra9k+xAYdwdca363Nyb8xAQO5QEK19cWc9EAZ2
 GVojB6i8f0BsX94Jz/IPvocqQkir3ObdESdTYl7DysyNn4O05mp77J4BQ+4nje2S0ZtbYxVMF2Y
 qTpe4x/ZEmGAQKRZYkw==
X-Proofpoint-ORIG-GUID: NtNJbiWVhK-kTChrnoD84QfehyFMIxuO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX2xuaevbZQVZT
 wHhQbPnxYf4s+wCzYJZ5sj3/V5FbtlSDHbTckXCo/zCO5dpdgc+lavqos3bcbDxNflV21/ERx3i
 6IxrP5LGoUMWYAjXlrAhTE9KGXSTZmw=
X-Proofpoint-GUID: NtNJbiWVhK-kTChrnoD84QfehyFMIxuO
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a994f9e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=zJ6Mc8Ub0I0eiHxM4GwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

We can now remove those arrays.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260901202043.26532-9-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/arm/machines-qom.h             | 16 ++--------------
 hw/arm/aspeed_ast1040_evb.c               |  1 -
 hw/arm/aspeed_ast10x0_evb.c               |  2 --
 hw/arm/aspeed_ast2400_palmetto.c          |  1 -
 hw/arm/aspeed_ast2400_quanta-q71l.c       |  1 -
 hw/arm/aspeed_ast2400_supermicrox11.c     |  1 -
 hw/arm/aspeed_ast2500_evb.c               |  1 -
 hw/arm/aspeed_ast2500_g220a.c             |  1 -
 hw/arm/aspeed_ast2500_romulus.c           |  1 -
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |  1 -
 hw/arm/aspeed_ast2500_tiogapass.c         |  1 -
 hw/arm/aspeed_ast2500_witherspoon.c       |  1 -
 hw/arm/aspeed_ast2500_yosemitev2.c        |  1 -
 hw/arm/aspeed_ast2600_anacapa.c           |  1 -
 hw/arm/aspeed_ast2600_bletchley.c         |  1 -
 hw/arm/aspeed_ast2600_catalina.c          |  1 -
 hw/arm/aspeed_ast2600_evb.c               |  1 -
 hw/arm/aspeed_ast2600_fby35.c             |  1 -
 hw/arm/aspeed_ast2600_fuji.c              |  1 -
 hw/arm/aspeed_ast2600_gb200nvl.c          |  1 -
 hw/arm/aspeed_ast2600_rainier.c           |  1 -
 hw/arm/aspeed_ast27x0-fc.c                |  1 -
 hw/arm/aspeed_ast27x0_evb.c               |  2 --
 hw/arm/ax3000-boards.c                    |  1 -
 hw/arm/b-l475e-iot01a.c                   |  1 -
 hw/arm/bananapi_m2u.c                     |  2 +-
 hw/arm/collie.c                           |  1 -
 hw/arm/cubieboard.c                       |  2 +-
 hw/arm/exynos4_boards.c                   |  2 --
 hw/arm/imx8mm-evk.c                       |  2 +-
 hw/arm/imx8mp-evk.c                       |  1 -
 hw/arm/integratorcp.c                     |  2 +-
 hw/arm/mcimx7d-sabre.c                    |  2 +-
 hw/arm/microbit.c                         |  1 -
 hw/arm/mps2-tz.c                          |  5 -----
 hw/arm/mps2.c                             |  4 ----
 hw/arm/mps3r.c                            |  1 -
 hw/arm/musca.c                            |  2 --
 hw/arm/npcm7xx_boards.c                   |  5 -----
 hw/arm/npcm8xx_boards.c                   |  1 -
 hw/arm/omap_sx1.c                         |  2 --
 hw/arm/orangepi.c                         |  2 +-
 hw/arm/raspi.c                            |  5 -----
 hw/arm/raspi4b.c                          |  1 -
 hw/arm/realview.c                         |  4 ----
 hw/arm/sabrelite.c                        |  1 -
 hw/arm/sbsa-ref.c                         |  1 -
 hw/arm/stellaris.c                        |  2 --
 hw/arm/versatilepb.c                      |  2 --
 hw/arm/vexpress.c                         |  2 --
 hw/arm/virt.c                             |  1 -
 hw/arm/xen-pvh.c                          |  1 -
 hw/arm/xilinx_zynq.c                      |  1 -
 hw/arm/xlnx-versal-virt.c                 |  2 --
 hw/arm/xlnx-zcu102.c                      |  1 -
 target/arm/machine.c                      | 12 ------------
 56 files changed, 8 insertions(+), 107 deletions(-)

diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index 81ffa434303..449592beda0 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -11,18 +11,6 @@
 
 #include "hw/core/boards.h"
 
-/*
- * A machine filtered with arm_machine_interfaces[] or
- * arm_aarch64_machine_interfaces[] will be available
- * in both qemu-system-arm and qemu-system-aarch64 binaries.
- *
- * One filtered with aarch64_machine_interfaces[] will only
- * be available in the qemu-system-aarch64 binary.
- */
-extern const InterfaceInfo arm_machine_interfaces[];
-extern const InterfaceInfo arm_aarch64_machine_interfaces[];
-extern const InterfaceInfo aarch64_machine_interfaces[];
-
 /*
  * A machine defined with the DEFINE_MACHINE_ARM() macro will be
  * available in both qemu-system-arm and qemu-system-aarch64 binaries.
@@ -32,9 +20,9 @@ extern const InterfaceInfo aarch64_machine_interfaces[];
  */
 #define DEFINE_MACHINE_ARM(namestr, machine_initfn) \
         DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            arm_machine_interfaces)
+                                            NULL)
 #define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
         DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            aarch64_machine_interfaces)
+                                            NULL)
 
 #endif
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
index 2b93d4dfbc5..dd68f9e25c7 100644
--- a/hw/arm/aspeed_ast1040_evb.c
+++ b/hw/arm/aspeed_ast1040_evb.c
@@ -81,7 +81,6 @@ static const TypeInfo aspeed_ast1040_evb_types[] = {
         .name           = MACHINE_TYPE_NAME("ast1040-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_machine_ast1040_evb_class_init,
-        .interfaces     = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
index c19563d1f0a..f377e955adc 100644
--- a/hw/arm/aspeed_ast10x0_evb.c
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -119,12 +119,10 @@ static const TypeInfo aspeed_ast10x0_evb_types[] = {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("ast1060-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1060_evb_class_init,
-        .interfaces     = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
index 776aa43a45d..f4918683c3d 100644
--- a/hw/arm/aspeed_ast2400_palmetto.c
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -73,7 +73,6 @@ static const TypeInfo aspeed_ast2400_palmetto_types[] = {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_palmetto_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2400_quanta-q71l.c b/hw/arm/aspeed_ast2400_quanta-q71l.c
index 42ad2a2303f..e1ddf682315 100644
--- a/hw/arm/aspeed_ast2400_quanta-q71l.c
+++ b/hw/arm/aspeed_ast2400_quanta-q71l.c
@@ -79,7 +79,6 @@ static const TypeInfo aspeed_ast2400_quanta_q71l_types[] = {
         .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_quanta_q71l_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
index 88cdb01fc76..86d49fd1dee 100644
--- a/hw/arm/aspeed_ast2400_supermicrox11.c
+++ b/hw/arm/aspeed_ast2400_supermicrox11.c
@@ -74,7 +74,6 @@ static const TypeInfo aspeed_ast2400_supermicrox11_types[] = {
         .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_evb.c b/hw/arm/aspeed_ast2500_evb.c
index 8b5cb67be9b..5f616252e0b 100644
--- a/hw/arm/aspeed_ast2500_evb.c
+++ b/hw/arm/aspeed_ast2500_evb.c
@@ -60,7 +60,6 @@ static const TypeInfo aspeed_ast2500_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2500-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2500_evb_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_g220a.c b/hw/arm/aspeed_ast2500_g220a.c
index 3f979a78e57..3c654c62dd6 100644
--- a/hw/arm/aspeed_ast2500_g220a.c
+++ b/hw/arm/aspeed_ast2500_g220a.c
@@ -85,7 +85,6 @@ static const TypeInfo aspeed_ast2500_g220a_types[] = {
         .name          = MACHINE_TYPE_NAME("g220a-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_g220a_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
index 91b660e74bb..b2ed623f680 100644
--- a/hw/arm/aspeed_ast2500_romulus.c
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -55,7 +55,6 @@ static const TypeInfo aspeed_ast2500_romulus_types[] = {
         .name          = MACHINE_TYPE_NAME("romulus-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_romulus_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
index a2450aa9623..77fa028b096 100644
--- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
+++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
@@ -70,7 +70,6 @@ static const TypeInfo aspeed_ast2500_supermicro_x11spi_types[] = {
         .name          = MACHINE_TYPE_NAME("supermicro-x11spi-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicro_x11spi_bmc_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_tiogapass.c b/hw/arm/aspeed_ast2500_tiogapass.c
index 186dbc1da30..1771f376480 100644
--- a/hw/arm/aspeed_ast2500_tiogapass.c
+++ b/hw/arm/aspeed_ast2500_tiogapass.c
@@ -83,7 +83,6 @@ static const TypeInfo aspeed_ast2500_tiogapass_types[] = {
         .name          = MACHINE_TYPE_NAME("tiogapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_tiogapass_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
index 28d437fec08..4cc349c3236 100644
--- a/hw/arm/aspeed_ast2500_witherspoon.c
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -105,7 +105,6 @@ static const TypeInfo aspeed_ast2500_witherspoon_types[] = {
         .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_witherspoon_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_yosemitev2.c
index eaa75bcccbb..48c813f3c8f 100644
--- a/hw/arm/aspeed_ast2500_yosemitev2.c
+++ b/hw/arm/aspeed_ast2500_yosemitev2.c
@@ -84,7 +84,6 @@ static const TypeInfo aspeed_ast2500_yosemitev2_types[] = {
         .name          = MACHINE_TYPE_NAME("yosemitev2-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_yosemitev2_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index 65d6b0faa2d..e82f5c98f26 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -368,7 +368,6 @@ static const TypeInfo aspeed_ast2600_anacapa_types[] = {
         .name          = MACHINE_TYPE_NAME("anacapa-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_anacapa_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index b7e84db1438..9dda83ad4c0 100644
--- a/hw/arm/aspeed_ast2600_bletchley.c
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -90,7 +90,6 @@ static const TypeInfo aspeed_ast2600_bletchley_types[] = {
         .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_bletchley_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index f714c9d1b32..f91e0635908 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -675,7 +675,6 @@ static const TypeInfo aspeed_ast2600_catalina_types[] = {
         .name          = MACHINE_TYPE_NAME("catalina-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_catalina_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_evb.c b/hw/arm/aspeed_ast2600_evb.c
index c43d2687c1c..404083b61dc 100644
--- a/hw/arm/aspeed_ast2600_evb.c
+++ b/hw/arm/aspeed_ast2600_evb.c
@@ -58,7 +58,6 @@ static const TypeInfo aspeed_ast2600_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.c
index f6244270704..6bcda0ac630 100644
--- a/hw/arm/aspeed_ast2600_fby35.c
+++ b/hw/arm/aspeed_ast2600_fby35.c
@@ -171,7 +171,6 @@ static const TypeInfo aspeed_ast2600_fby35_types[] = {
         .name          = MACHINE_TYPE_NAME("fby35-bmc"),
         .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
         .class_init    = aspeed_machine_fby35_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 37db252e276..cf49149fe9a 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -133,7 +133,6 @@ static const TypeInfo aspeed_ast2600_fuji_types[] = {
         .name          = MACHINE_TYPE_NAME("fuji-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fuji_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_gb200nvl.c b/hw/arm/aspeed_ast2600_gb200nvl.c
index ad9a10110b8..705561afe39 100644
--- a/hw/arm/aspeed_ast2600_gb200nvl.c
+++ b/hw/arm/aspeed_ast2600_gb200nvl.c
@@ -104,7 +104,6 @@ static const TypeInfo aspeed_ast2600_gb200nvl_types[] = {
         .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_gb200nvl_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
index 8f0a412ddcf..6e5debc8bc1 100644
--- a/hw/arm/aspeed_ast2600_rainier.c
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -191,7 +191,6 @@ static const TypeInfo aspeed_ast2600_rainier_types[] = {
         .name          = MACHINE_TYPE_NAME("rainier-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_rainier_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 54230aa92e6..ccfa4ade265 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -236,7 +236,6 @@ static const TypeInfo ast2700fc_types[] = {
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
         .is_available   = target_aarch64,
-        .interfaces     = aarch64_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 2b767808e12..0deb3127c21 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -77,14 +77,12 @@ static const TypeInfo aspeed_ast27x0_evb_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
         .is_available  = target_aarch64,
-        .interfaces    = aarch64_machine_interfaces,
     },
     {
         .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a2_evb_class_init,
         .is_available  = target_aarch64,
-        .interfaces    = aarch64_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index 4b8deec15cf..c7248f9f52b 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -48,7 +48,6 @@ static const TypeInfo ax3000_machine_types[] = {
         .instance_size = sizeof(Ax3000MachineState),
         .class_size    = sizeof(Ax3000MachineClass),
         .class_init    = ax3000_machine_class_init,
-        .interfaces    = aarch64_machine_interfaces,
         .abstract      = true,
     }
 };
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index ee789c8df94..04dce2d19ce 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -132,7 +132,6 @@ static const TypeInfo bl475e_machine_type[] = {
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(Bl475eMachineState),
         .class_init     = bl475e_machine_init,
-        .interfaces     = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 0079aa1dd2b..15c878d1636 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -154,4 +154,4 @@ static void bpim2u_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
-                        bpim2u_machine_init, false, arm_machine_interfaces)
+                        bpim2u_machine_init, false, NULL)
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 01d74ad38cd..4b930e6ba12 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -85,7 +85,6 @@ static const TypeInfo collie_machine_typeinfo = {
     .parent = TYPE_MACHINE,
     .class_init = collie_machine_class_init,
     .instance_size = sizeof(CollieMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void collie_machine_register_types(void)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index d59c1ebba7f..511b71fbd7e 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -135,4 +135,4 @@ static void cubieboard_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
                         cubieboard_machine_init, false,
-                        arm_machine_interfaces)
+                        NULL)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index b7decdb2c7f..62f7cbe875e 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -169,7 +169,6 @@ static const TypeInfo nuri_type = {
     .name = MACHINE_TYPE_NAME("nuri"),
     .parent = TYPE_MACHINE,
     .class_init = nuri_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void smdkc210_class_init(ObjectClass *oc, const void *data)
@@ -190,7 +189,6 @@ static const TypeInfo smdkc210_type = {
     .name = MACHINE_TYPE_NAME("smdkc210"),
     .parent = TYPE_MACHINE,
     .class_init = smdkc210_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void exynos4_machines_init(void)
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 019c609c542..ffe8e494a57 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -136,4 +136,4 @@ static void imx8mm_evk_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("imx8mm-evk", MACHINE, Imx8mmEvkMachineState,
                         imx8mm_evk_machine_init, false,
-                        aarch64_machine_interfaces)
+                        NULL)
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 16e9722d146..389e7c86d21 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -162,7 +162,6 @@ static const TypeInfo imx8mp_evk_machine_types[] = {
         .class_init = imx8mp_evk_machine_class_init,
         .instance_init = imx8mp_evk_machine_init,
         .instance_size = sizeof(FslImx8mpEvkState),
-        .interfaces = aarch64_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index f8bcf42c615..25ecd931e76 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -706,7 +706,7 @@ static void integratorcp_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE, IntegratorcpMachineState,
                         integratorcp_machine_init, false,
-                        arm_machine_interfaces)
+                        NULL)
 
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 22fe1fa932f..cb4536faadd 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -88,4 +88,4 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE, Mcimx7dSabreMachineState,
                         mcimx7d_sabre_machine_init, false,
-                        arm_machine_interfaces)
+                        NULL)
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 9d5c4898469..85285861c5f 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -75,7 +75,6 @@ static const TypeInfo microbit_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(MicrobitMachineState),
     .class_init = microbit_machine_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void microbit_machine_init(void)
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 41dfb185353..3a384d3cdb9 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1631,35 +1631,30 @@ static const TypeInfo mps2tz_an505_info = {
     .name = TYPE_MPS2TZ_AN505_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an505_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps2tz_an521_info = {
     .name = TYPE_MPS2TZ_AN521_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an521_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps3tz_an524_info = {
     .name = TYPE_MPS3TZ_AN524_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an524_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps3tz_an547_info = {
     .name = TYPE_MPS3TZ_AN547_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an547_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps3tz_an555_info = {
     .name = TYPE_MPS3TZ_AN555_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an555_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void mps2tz_machine_init(void)
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index ac9366d8447..b13b7bc55ec 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -568,28 +568,24 @@ static const TypeInfo mps2_an385_info = {
     .name = TYPE_MPS2_AN385_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an385_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps2_an386_info = {
     .name = TYPE_MPS2_AN386_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an386_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps2_an500_info = {
     .name = TYPE_MPS2_AN500_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an500_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps2_an511_info = {
     .name = TYPE_MPS2_AN511_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an511_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void mps2_machine_init(void)
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index caad820d3bc..d6f4c1640ab 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -635,7 +635,6 @@ static const TypeInfo mps3r_machine_types[] = {
         .name = TYPE_MPS3R_AN536_MACHINE,
         .parent = TYPE_MPS3R_MACHINE,
         .class_init = mps3r_an536_class_init,
-        .interfaces = arm_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 75d82eebcac..1b161487e7e 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -658,14 +658,12 @@ static const TypeInfo musca_a_info = {
     .name = TYPE_MUSCA_A_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_a_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo musca_b1_info = {
     .name = TYPE_MUSCA_B1_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_b1_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void musca_machine_init(void)
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 4f14d257465..025de42dac6 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -550,27 +550,22 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm750-evb"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = npcm750_evb_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gsj"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gsj_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gbs-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gbs_bmc_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("kudo-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = kudo_bmc_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("mori-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = mori_bmc_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index f462369bea3..2a04cf4f2c9 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -249,7 +249,6 @@ static const TypeInfo npcm8xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm845-evb"),
         .parent         = TYPE_NPCM8XX_MACHINE,
         .class_init     = npcm845_evb_machine_class_init,
-        .interfaces     = aarch64_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 3b628d13cbc..c3fe4187b8b 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -226,7 +226,6 @@ static const TypeInfo sx1_machine_v2_type = {
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v2_class_init,
     .instance_size = sizeof(Sx1MachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void sx1_machine_v1_class_init(ObjectClass *oc, const void *data)
@@ -247,7 +246,6 @@ static const TypeInfo sx1_machine_v1_type = {
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v1_class_init,
     .instance_size = sizeof(Sx1MachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void sx1_machine_init(void)
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 0e149ed6c98..3f06716c364 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -135,4 +135,4 @@ static void orangepi_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
                         orangepi_machine_init, false,
-                        arm_machine_interfaces)
+                        NULL)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index bbaa20bd630..7ff3e8400e6 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -392,29 +392,24 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi0"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi0_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi1ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi1ap_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
         .is_available   = target_aarch64,
-        .interfaces     = aarch64_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
         .is_available   = target_aarch64,
-        .interfaces     = aarch64_machine_interfaces,
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 2ad561fdcfc..08fcdf58c9f 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -127,7 +127,6 @@ static const TypeInfo raspi4b_machine_type = {
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
     .is_available   = target_aarch64,
-    .interfaces     = aarch64_machine_interfaces,
 };
 
 static void raspi4b_machine_register_type(void)
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 0c2daf5c01f..aee7d05c3e6 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -437,7 +437,6 @@ static const TypeInfo realview_eb_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_class_init,
     .instance_size = sizeof(RealViewMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void realview_eb_mpcore_class_init(ObjectClass *oc, const void *data)
@@ -460,7 +459,6 @@ static const TypeInfo realview_eb_mpcore_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_mpcore_class_init,
     .instance_size = sizeof(RealViewMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void realview_pb_a8_class_init(ObjectClass *oc, const void *data)
@@ -481,7 +479,6 @@ static const TypeInfo realview_pb_a8_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_pb_a8_class_init,
     .instance_size = sizeof(RealViewMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void realview_pbx_a9_class_init(ObjectClass *oc, const void *data)
@@ -503,7 +500,6 @@ static const TypeInfo realview_pbx_a9_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_pbx_a9_class_init,
     .instance_size = sizeof(RealViewMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void realview_machine_init(void)
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 140b2ecb9e2..ec307388f45 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -152,7 +152,6 @@ static const TypeInfo sabrelite_machine_init_typeinfo = {
     .instance_init = sabrelite_machine_instance_init,
     .instance_size = sizeof(SabreliteMachineState),
     .abstract      = false,
-    .interfaces    = arm_machine_interfaces,
 };
 
 static void sabrelite_machine_init_register_types(void)
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 56d08f605c8..6ba353341a1 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -946,7 +946,6 @@ static const TypeInfo sbsa_ref_info = {
     .instance_finalize = sbsa_ref_instance_finalize,
     .class_init    = sbsa_ref_class_init,
     .instance_size = sizeof(SBSAMachineState),
-    .interfaces    = aarch64_machine_interfaces,
 };
 
 static void sbsa_ref_machine_init(void)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 56ecc828f4f..f634918868b 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1428,7 +1428,6 @@ static const TypeInfo lm3s811evb_type = {
     .name = MACHINE_TYPE_NAME("lm3s811evb"),
     .parent = TYPE_MACHINE,
     .class_init = lm3s811evb_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 /*
@@ -1450,7 +1449,6 @@ static const TypeInfo lm3s6965evb_type = {
     .name = MACHINE_TYPE_NAME("lm3s6965evb"),
     .parent = TYPE_MACHINE,
     .class_init = lm3s6965evb_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void stellaris_machine_init(void)
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 520af79c800..1db9bc1eb24 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -438,7 +438,6 @@ static const TypeInfo versatilepb_type = {
     .parent = TYPE_MACHINE,
     .class_init = versatilepb_class_init,
     .instance_size = sizeof(VersatileMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void versatileab_class_init(ObjectClass *oc, const void *data)
@@ -461,7 +460,6 @@ static const TypeInfo versatileab_type = {
     .parent = TYPE_MACHINE,
     .class_init = versatileab_class_init,
     .instance_size = sizeof(VersatileMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void versatile_machine_init(void)
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f26d8c6f8d1..1e29fe0f09c 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -850,7 +850,6 @@ static const TypeInfo vexpress_a9_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a9_class_init,
     .instance_init = vexpress_a9_instance_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo vexpress_a15_info = {
@@ -858,7 +857,6 @@ static const TypeInfo vexpress_a15_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a15_class_init,
     .instance_init = vexpress_a15_instance_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void vexpress_machine_init(void)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d738b95c726..eae4f0fe413 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -133,7 +133,6 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
-        .interfaces = arm_aarch64_machine_interfaces, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 10cac28a910..b47dd9efd81 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -96,7 +96,6 @@ static const TypeInfo xen_arm_machine_type = {
     .class_init = xen_arm_machine_class_init,
     .instance_size = sizeof(XenPVHMachineState),
     .instance_init = xen_arm_instance_init,
-    .interfaces = arm_aarch64_machine_interfaces,
 };
 
 static void xen_arm_machine_register_types(void)
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index f3148975406..8ebd8e5ccd5 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -479,7 +479,6 @@ static const TypeInfo zynq_machine_type = {
     .parent = TYPE_MACHINE,
     .class_init = zynq_machine_class_init,
     .instance_size = sizeof(ZynqMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void zynq_machine_register_types(void)
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 2b04513ba2e..e06a0c55549 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -402,14 +402,12 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL_VIRT_MACHINE,
     .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .class_init = versal_virt_machine_class_init,
-    .interfaces = aarch64_machine_interfaces,
 };
 
 static const TypeInfo versal2_virt_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL2_VIRT_MACHINE,
     .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .class_init = versal2_virt_machine_class_init,
-    .interfaces = aarch64_machine_interfaces,
 };
 
 static void versal_virt_machine_init_register_types(void)
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4e489702743..da8b3ede873 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -303,7 +303,6 @@ static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
     .class_init = xlnx_zcu102_machine_class_init,
     .instance_init = xlnx_zcu102_machine_instance_init,
     .instance_size = sizeof(XlnxZCU102),
-    .interfaces = aarch64_machine_interfaces,
 };
 
 static void xlnx_zcu102_machine_init_register_types(void)
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 42a1427fa16..61106f9def6 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1346,15 +1346,3 @@ const VMStateDescription vmstate_arm_cpu = {
         NULL
     }
 };
-
-const InterfaceInfo arm_machine_interfaces[] = {
-    { }
-};
-
-const InterfaceInfo arm_aarch64_machine_interfaces[] = {
-    { }
-};
-
-const InterfaceInfo aarch64_machine_interfaces[] = {
-    { }
-};
-- 
2.53.0


