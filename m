Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AE8C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24vc-0000Q9-GF; Thu, 03 Sep 2026 06:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24va-0000I5-TW
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vZ-00076F-5Q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:18 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHAtv212404
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pzUcGy0V1UtYmJH5fdlplTX3XLz53u46+IIgjzDeWHs=; b=Nnky2ku2sMVj7Ddr
 NfhV9IWqJHKHowQgDBuRgsjpq7HWFHTWTwI0gqkZ09wTofUXDQ352+zSaqheSMmL
 1RYWtobmSLxicL7RCvzRJnE17WdWlvVLzG03kk6Rk4zY5aRHGnN/RCCLqpEFahW4
 bnJZ1Tax11pqjwlMElsk8WYhjEOOib4t3HNNPhtVtsU6B8O8wG85ev+FpMQQ2Y4u
 DFgJmboKMNZoMJWxJzS5hI3QDOl2qGSETg9c4Ep4nReRBUwa9Pp5ieeeHq3VBGMN
 dVR35fAqNpbltiPkwgLNP5HEE29KZ/NP9wXZfnqusPb2EwWFYod8yK21tLDXs1U+
 Se3kZg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyhg1v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:44:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9375d92d8cdso491321485a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432254; x=1789037054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pzUcGy0V1UtYmJH5fdlplTX3XLz53u46+IIgjzDeWHs=;
 b=BC4kmtxZbc7+ormqZmvvOuqayZXNyFD7i2Qiv1kkry6/pUEkqJnajW80XQD0s8VJSM
 JXKueC92dN7+uHqJLckwdZ1vsQ6B2CTi/91N4hvngyz0VcfBwckHbMtgwsmtlUWNUuSE
 Ul1D4taV2em8NTXc3RbkdLsu9KSxACm1KBg2rRX1gzNZbeZdzXww+/rj+qSW0hUWV0sd
 L00bgKZ8NKRWWuTX/BPdHVarE5EeP8Q5nrXn2Lxz0jEDHTbuZvcQI4tgFhOLm1q7DCLi
 Opg7yTAw7JSpOBXHhNsXEv0KMoB+ogCOBnvruuI6V6WoWKXfl4FFh0dHi6YzWtNGtJrt
 leOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432254; x=1789037054;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pzUcGy0V1UtYmJH5fdlplTX3XLz53u46+IIgjzDeWHs=;
 b=GtGrsmBcabuSpnLncwTKTcpGHHXsGGMFf6mOi69xXHlr2kpn1KHzPsWZG6TGcYzWxc
 yHSPhlP/OWdi9jA6AqHdfdL0bA12XDYLm7Udro+b7Xp/DEp1SGm6LHIBzc8sMnUz1Rwr
 Ic+/8QDd7qInRhquayv+bhdWMsyHyTGYQ1lh2m5GGqY5YQGQrNehSfwrKzcKvR7kEvcA
 CFf//K6SepjRanhLRRgaotBdBJ0Kgbqy+cBMq484sx13miB2csR2bBC6UHuXz2Ygi5Xp
 E2rAgi/FphyjGB6YcAZZ89ipIGknVaJX315t30LV1ZaKWVlDm3nIyn1h44GI/wW5HVfv
 XS1g==
X-Gm-Message-State: AFuF++l4WCRJZBh01VYNnWl2EoOhLhRWPVBXIp0vSlyfp4OZbPB9nJmr
 V8de0pqpI19Z465tIZKK122gW5EeGfgXW2W9jBwkADPtdtefUfuGwJyvJyUQvPm93r03opaMG76
 L4lM5V2nW8oCPoLO1sGMy0z3MBTBtkBGyj9P9+q2v2yxM1+2MvsKkuEGJQSozwoVsow==
X-Gm-Gg: AYBFou30OQCVMFwIRCdo4SPhJsdOeysBvk0lZ7g3Lz+3/JEY5GhLQMNugIJP4PPRImI
 5JhPQEgd68EBT8FbLMOM3usyPXotNi4cG82SXbTcmNssBLfcvtXAD0yFdJwIqlfjkv4MASMFTtY
 Js9VLJmmlVpyLyg1A3+7CNQlAH1CijT3K+q7DcorzFrYi7VD0rbqjmQo6D24ayBzA5GVQtsnw6O
 /BIMtwfBfkoS8UZkbIqDSXFi0f2ARpiKH+/3FRpS7t3rKzhZC/MdLeHYZhOo5rlfLrdki6iQrkI
 IS90vq6XxLyjxn5fHDbKuq91dgUjD4CYcyTEsKYZRAbwmBDYe9spnwjgQRQbZQcXIfR20xdxkun
 L15DN8QWCTCR4liANHRr4BuCGbs6m/E1kxV5yb9mx
X-Received: by 2002:a05:620a:27d5:b0:939:6dfa:4a7d with SMTP id
 af79cd13be357-9396dfa4c5emr584891685a.52.1788432254550; 
 Thu, 03 Sep 2026 03:44:14 -0700 (PDT)
X-Received: by 2002:a05:620a:27d5:b0:939:6dfa:4a7d with SMTP id
 af79cd13be357-9396dfa4c5emr584888185a.52.1788432254059; 
 Thu, 03 Sep 2026 03:44:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee3acf2csm58833575e9.0.2026.09.03.03.44.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:44:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/51] hw/arm: filter minimal set of machines
Date: Thu,  3 Sep 2026 12:39:21 +0200
Message-ID: <20260903103936.62355-38-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX5p0z336hPv/F
 6EH02sY2H7N3mdoLrMVZ2rLnRk/ifUowYW+23qg3x0x41O7ufWC1Gpj32Jm+389wqr7zSiRcGWP
 Of7bKOOliXmcRmB0P8OxIjcTKOkyhwx0V23gAsz22axhjpdcOLrSKxVdaa0QG51vLosUax+fDOO
 qWBsM48QEGa+815pSkLgELMtqw38HNIxJKH2BU461VD2go9LpjiwqgIUoNbGMfSTXIJ+XpJCb+u
 /ye49+9NuyakbOvqzsjOoPQAxzH5QLjqy9+p8dM1IvG6/HNezW9C96/SBuWjVnfmC1U3MyXIMKa
 7BHx5+Ah89AzzAqSk+tGlCyCWPaw3Dcz2dkiQAe4vAvXCsj3eyBLYv0NZ4Xm9vc75x0pVRD2oEA
 P7oP8gGwO1Op9ofoNv+fIrtd54adNjHEhEKUt0ViR2QBPgwmpzNTAlwBgIerOpJ2T4x3se+kAty
 +wMGNA1ScGH40ezklQg==
X-Proofpoint-ORIG-GUID: bP-lbqtAJuo5o7ZC_zgYlx6iZ75XUmbR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX+OiwSHJ3q5AF
 orkOpd2d3EXcdMK1bpZugCJRrDDuXdfN4qjqG2h5Ny8llDlxkkzbS+O+FK29hiatGVNeOKgEPXo
 CmtsowXHeoDgBJp6o1xarR0j5sXhGwg=
X-Proofpoint-GUID: bP-lbqtAJuo5o7ZC_zgYlx6iZ75XUmbR
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a994f7f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=h_r1GPaHZSNDaGzxDFMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
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

We are about to change the filtering logic for machines. These boards
are impacted and already are conditionally available. To not break
existing binaries, we need to filter them accordingly with new mechanic.

From there, we are free to remove the previous filtering mechanic
without changing any existing behaviour.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260901202043.26532-3-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/aspeed_ast27x0-fc.c  | 1 +
 hw/arm/aspeed_ast27x0_evb.c | 2 ++
 hw/arm/raspi.c              | 2 ++
 hw/arm/raspi4b.c            | 1 +
 4 files changed, 6 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index ceeae336df1..54230aa92e6 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -235,6 +235,7 @@ static const TypeInfo ast2700fc_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
+        .is_available   = target_aarch64,
         .interfaces     = aarch64_machine_interfaces,
     },
 };
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 0ff1bebeb0e..2b767808e12 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -76,12 +76,14 @@ static const TypeInfo aspeed_ast27x0_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
+        .is_available  = target_aarch64,
         .interfaces    = aarch64_machine_interfaces,
     },
     {
         .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a2_evb_class_init,
+        .is_available  = target_aarch64,
         .interfaces    = aarch64_machine_interfaces,
     }
 };
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3f99e87428c..bbaa20bd630 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -407,11 +407,13 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
+        .is_available   = target_aarch64,
         .interfaces     = aarch64_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
+        .is_available   = target_aarch64,
         .interfaces     = aarch64_machine_interfaces,
     }, {
         .name           = TYPE_RASPI_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index e1595a875fe..2ad561fdcfc 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -126,6 +126,7 @@ static const TypeInfo raspi4b_machine_type = {
     .parent         = TYPE_RASPI_BASE_MACHINE,
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
+    .is_available   = target_aarch64,
     .interfaces     = aarch64_machine_interfaces,
 };
 
-- 
2.53.0


