Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB335CD484D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQi5-0001e2-Ah; Mon, 11 May 2026 09:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhk-0001Hv-Uf
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhj-0007ld-6a
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:52 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B9757B653932
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PrJV1kIhbQx
 fvl8dDUbJbHI0i88J/2u2VYghUPDctas=; b=OMzCv/2V+600SFNj4uTSbHDSeKP
 nK1zKpl/bwDLMwQzOu4A/A5Z82m0xKWN3Pa+vAJPtSMFMLxO9NAQWKTndP1ygYiG
 sUHR4WkG+WNmK1HxBDVL+yNgNl4UN6NK4GT5ov6fvQhfcHNUsOOU8EzZ+KGSWYqo
 YZHI7OnQin6np86zbamgp8pE6N9B99JYn5tQM08yy12kIOZ4wXh3VV7mIOKEAM5W
 7I/aucFGKkE+Pd1yEsXt2QyRl2P06ksvijonzGSvWaI6hnomfHQVoEQbijvtM0dk
 beMZxsZCxxezOpOgWFRq9TbN+2PZyTbTmxrJrWO055fdOvuQ9thZlsIUOLw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xu9vnv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b7e68098dcso100711516d6.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506179; x=1779110979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrJV1kIhbQxfvl8dDUbJbHI0i88J/2u2VYghUPDctas=;
 b=hMsDvWBptPydXm/UVSzDpebiDtytrus6R28tmuRV0gLGHdtaz/QPW+qh1Ep80mQ2R7
 qhAyo0ZegIOcjvfibhujOd+YOcqFzsM6fFpChnbdwKmlGm+8Jec9YejzLmWEXn89Y5v6
 PpMyFUIuxqq20j5zHiZXRpWdFt/OUvJ6icLBrklXPvbVcI/uA/nojGxNM6aAguv3gmcU
 ZLICIpJTA3EtBmVnF3AkkL1wX5jaXF3LbgBtG86Q/XmfBWbqAwJm6bgEG9KLgzfZq65M
 3x88IOLGAw6SexPOyb5u7ldewJAD0U8lM/temzOP0adSBhshMk/uoSM4YJHmnPsdhaPu
 159A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506179; x=1779110979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PrJV1kIhbQxfvl8dDUbJbHI0i88J/2u2VYghUPDctas=;
 b=ajTzOBrlwHUDtB3q4ML9jxLDnTJArcBFV97ndLSQMm1F828rwj2wrjk1dNXPoeAG//
 vNlPWPG0ARaEDY8tQmVqKwDDNBoJZxs1vLjM2KVkr8BLiKcalQiyYajvYLcCum+P/fAC
 lzKOkVYazITk4y+6RRSHpWJRrFijFVWkaEYTSjE8oiysJL/Rakn5cDFb3Zn32SIbRdcL
 KqOlj23KFEjkrqG90/v1j/CiCFNXHTNGVHHg3XDUKA2yxX+YtmNuvqtgQUv2GXezO/ul
 zcGG5+HEwrWdocJ7ns8kL2fA/+Im9sZwKfmsFVw3MIi/j4dLnzPozfExqxrfnVznGxHy
 4bbA==
X-Gm-Message-State: AOJu0YzqUOOmdJN5yZG5WoGj0/6ptKWc6zL0Y/8U68dWjMPuCCDGg5lL
 OqotWuUvuLy3/39zIBT/XuePFVQdbCZHFhybOf6UGITQlkS/9djo4eDNJE2csWGQEeUM5kkeNcO
 PJF81D06S+rzKHu3Ps9hAfR06/DECANxgmq9rv4bHFMamC5YneCS7noQrXkYsc1TKpw==
X-Gm-Gg: Acq92OGVMiBn3oXVk6aIzJSjoFVtw464oK/zg7MOQ9jG/96KC12gYpzaRDNbCGYWJwm
 KCO8oJNKkjExUUFxa5qUS53K2SJ3t+Ahz4Ps0KJYXxbR4esDnsCp3kp/Os0Hhcth5CA5ECG0Ptm
 iTkcywYanurUCaMo14udHLOlKV/CCy6lFzPxiCgE8FeBYFCS/j6oMBUrZbzQms+Cb+wIEDfhKwr
 bgwTk5v+M37r33YWrXhGst37LYim4u2u4Axkz2ku04fVIANRgbZTolojwqfiV0SUMhCyid7Pj/s
 kIPWYlY8tEK1gM9jD55cyKT3ARUgrBA+27RMXST/Bbk9ORcbAXqOrj+gS+OPSSfPoKtjcUy64wI
 MBANYgXgDL+DIC9bWVGVtiaucWr+ytQwNii0k7oytcWZqpA8macsAlYCkj30B
X-Received: by 2002:a05:6214:2243:b0:8ac:a6f7:8a6c with SMTP id
 6a1803df08f44-8c1af6d6336mr168300786d6.36.1778506179127; 
 Mon, 11 May 2026 06:29:39 -0700 (PDT)
X-Received: by 2002:a05:6214:2243:b0:8ac:a6f7:8a6c with SMTP id
 6a1803df08f44-8c1af6d6336mr168300116d6.36.1778506178598; 
 Mon, 11 May 2026 06:29:38 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:38 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 11/13] target/riscv: do not set defaults in cpu prop callback
Date: Mon, 11 May 2026 10:29:08 -0300
Message-ID: <20260511132910.1738069-12-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EcL4hvmC c=1 sm=1 tr=0 ts=6a01d9c4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=_ksROKcViFXmtGbZ1joA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfXwhYFSxrZItcz
 H/2CO/Zo0PITeP1kJK/zAl6B1HGq5doB4D8apTwPP0MKRjtOctYlQQhC5r0OT/6iGAofpu2AiRx
 9pNdhtlSf2ktvP9lAEftkvy6S7VidfbEWn+bwmliQrUI8CXRS/2AAsJibU6Smkk6wleancy/tR+
 /gQWwqaQhfCQ2F38neSlWWQ1ny9sHL/HO9WaCNN5GzTtBfmxHub4V/2VVkLkFUAT1w+SfNvgltN
 VhjX7rhk/TeGNt1KGgkZfv2eA3J7jQuyHnd7irIbGjjfBmMxphJJ+yDDa5Tx+KtZ6gZ7nUjJdJt
 0NwIc89mkB1GLAUXL4JZbvJZVvPHX0XDX9kbfw7SiYJvy+EGCB7RNFR+jr+MPX4lrruGjMoybZS
 3x0xVOkLid4QcuD0XlVBX4+DEp1/Nj6TfHB6+eaZM5/dst98gU1i9uNrSi2SmCSjLuUiI3bAh/G
 WbK2pWXhBqfMeRsAC6A==
X-Proofpoint-ORIG-GUID: lJ9r-wz1P4YoELbZ1eMfJXhStl1k_MHP
X-Proofpoint-GUID: lJ9r-wz1P4YoELbZ1eMfJXhStl1k_MHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Do not rely on riscv_cpu_* arrays to set rv32/rv64 CPU defaults - add
them to the CPU definition like we do with all other CPUs (aside from
'max').

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c         | 40 ++++++++++++++++++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c | 14 -------------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4940596ffa..6dd05597e8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3072,6 +3072,26 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV32,
         .misa_mxl_max = MXL_RV32,
+
+        /*  Default extensions as of QEMU 11.1.  */
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicbop = true,
+        .cfg.ext_zicboz = true,
+        .cfg.ext_zicntr = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zihintntl = true,
+        .cfg.ext_zihintpause = true,
+        .cfg.ext_zihpm = true,
+        .cfg.ext_zawrs = true,
+        .cfg.ext_zfa = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svadu = true,
+        .cfg.ext_svvptc = true,
     ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
@@ -3124,6 +3144,26 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
         .misa_mxl_max = MXL_RV64,
+
+        /*  Default extensions as of QEMU 11.1.  */
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicbop = true,
+        .cfg.ext_zicboz = true,
+        .cfg.ext_zicntr = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zihintntl = true,
+        .cfg.ext_zihintpause = true,
+        .cfg.ext_zihpm = true,
+        .cfg.ext_zawrs = true,
+        .cfg.ext_zfa = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svadu = true,
+        .cfg.ext_svvptc = true,
     ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index db311118b0..a12115df4d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1498,24 +1498,10 @@ static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
 static void cpu_add_multi_ext_prop(Object *cpu_obj,
                                    const RISCVCPUMultiExtConfig *multi_cfg)
 {
-    bool generic_cpu = riscv_cpu_is_generic(cpu_obj);
-
     object_property_add(cpu_obj, multi_cfg->name, "bool",
                         cpu_get_multi_ext_cfg,
                         cpu_set_multi_ext_cfg,
                         NULL, (void *)&multi_cfg->offset);
-
-    if (!generic_cpu) {
-        return;
-    }
-
-    /*
-     * Set def val directly instead of using
-     * object_property_set_bool() to save the set()
-     * callback hash for user inputs.
-     */
-    isa_ext_update_enabled(RISCV_CPU(cpu_obj), multi_cfg->offset,
-                           multi_cfg->enabled);
 }
 
 static void riscv_cpu_add_multiext_prop_array(Object *obj,
-- 
2.43.0


