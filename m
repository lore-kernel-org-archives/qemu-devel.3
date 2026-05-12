Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550DFCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdp7-0005pb-Qw; Mon, 11 May 2026 23:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoy-0005bI-B1
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:30:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdou-0000LL-27
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:30:10 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6fS12519063
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Dn4HjuhGp8L
 CUPwsHFZVHJbyMpEiyM78/+1bEt1A1fU=; b=CkX5KhmvKtt9PVgA94s9mNZYa14
 P5YOkrj1QkpiercoVdJBxgCiOlrhmPrpcd6q8zvmvEN7Wy6sJY6chl2Z7iIP0f3k
 HGbURhveqYfCZ4aR3hkk0WUfNjE8IKQtQ0bdyq03D8rESf0de3ehd75BJoD/DimQ
 Tuw/QuIsIsl56ovNV+60lMnIdifs7jNwUgsS9wfs1pjSqj6BHcqyw8TC7WL9TbhQ
 vPM+HR+UL63hqvTuNPqpibDPohzeUqUFy7z3O237OGXRyPu0EmnkfA8u740EknE3
 RW+5dGHjPobuWSKTjFreeA+nAmeW6r/f/qYJXxOSzZEeCYI/lq5GR8DpOvw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1h8x2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:30:02 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ee34588671so7265517eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556601; x=1779161401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dn4HjuhGp8LCUPwsHFZVHJbyMpEiyM78/+1bEt1A1fU=;
 b=gbaFMVhYuk5+df2aaEIH2+pEbgsMKtbu9bGQB4nxbak4jll1fJOWEnnUoAs/aclyZY
 DXEGW2by9SaA8VXYfXBPXt3TyQ+akfOaH87lUZLhL1CEW0lhQ8JbiX3TJL3dhtjjYoT0
 F8nOkOtVZoWeHE51izI3WOaOveXfNLRgC7yL9246U2KkFhngp8G72DNv3LYFAB7aH9dP
 IS+sOXRmCLu/yCv7/2YQKY4P8mA2kkRXHUBkqfDJ8gT3Rw802YnMo/GSht4dmmV2rBv2
 VQGDZsGe5xRRbvjoMWAT+ytSOiMNXZkifWVqyg4bKzelEyR63xf/kzWCP8m0e/oiSXG/
 aMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556601; x=1779161401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dn4HjuhGp8LCUPwsHFZVHJbyMpEiyM78/+1bEt1A1fU=;
 b=hfIF5fmY0QVMs7Xud2xEaPSGmSkDR7Or6VnjifaIxOxkRu3XgEfKt5wLH+vJHZffi/
 P7osDifXFGZRgYivhOQ5yVrYmxnrjFfXIyEb9P9wu54+0GRQVjjF/IblsIuNBf7pJmAg
 8ZGDoON+J+HcF1kZyr9dphKmTH69CP1kNhG9A7XcfrNy4O9neLX4/DvsRmOmkmdabb1M
 2CRd5jRo2d6Q004hvWjBJNCMfiT7GHLe640qIJQgtvbcLJiyaIbrs+K8jB8a1myFXQsS
 kfJjl8qxJephca0la9rVLlCDvSoJrwHSI/mI7mVeD9u57OehetZNTv09vRy4j6UOiIdW
 258g==
X-Gm-Message-State: AOJu0YxkZQhqUmlIHuECQ67R0PU0i7CrTU/O5ngoV8MCPXo2AXivF5x9
 353hQLHnksWzr9I9HLQRqQvqdFQ3JCUMtzQ809y83/TonKpCmvFj46minhYBjIRMQaQDPRWjdPb
 oT4RB2WgCTKzrh1TZxrpuqV0D5Nl0Gr+n+Q9dmlHyMK3BzWsX45jgIvZagA1PQqU40A==
X-Gm-Gg: Acq92OHlWIPDNx2YpblCjVfx2F4ltc31ztB9tu+PnPbnkg2zM3RO05wQcGIm4KtSEUE
 4IigAc7IPp2yGE1K5KSN5BAYpEh8T6ny8go3SGitUITe5I05iubFjjdBUsN6MSuH5v91JyzW4JQ
 Iunj3PVZidCLgaChzi4thdxVdlvhbWJDqZKXlghcvB3Fldop28FwdM7dANGrdzYnfUHJI3EOxaF
 w/biAO90V1flB/VKpq1qEBXcMOU2D87bhjOJbQtgiADPNZePZPU2HMEiSCy4ds/XJ1F+qIDdFQG
 vlcTNGdmuG4EzoZyCklblsnwyIlwKZA39CzAcufXPW1yOai0BLVwOs4SPKjJyy/bv9FuOoYPAHd
 ZbATVCg4b5LRCvYvA8QRmFExukTPKybXQlWgaYZd1GOJVqN+IzORp6lObd6eI
X-Received: by 2002:a05:7300:214f:b0:2ed:f791:3417 with SMTP id
 5a478bee46e88-2ffd7be2cc0mr675703eec.25.1778556601286; 
 Mon, 11 May 2026 20:30:01 -0700 (PDT)
X-Received: by 2002:a05:7300:214f:b0:2ed:f791:3417 with SMTP id
 5a478bee46e88-2ffd7be2cc0mr675692eec.25.1778556600785; 
 Mon, 11 May 2026 20:30:00 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:30:00 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 12/14] target/riscv: do not set defaults in cpu prop
 callback
Date: Tue, 12 May 2026 00:29:24 -0300
Message-ID: <20260512032926.1978818-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: i7odv5Q8kbljcgH8WiJAzM-36rBm6v1W
X-Proofpoint-ORIG-GUID: i7odv5Q8kbljcgH8WiJAzM-36rBm6v1W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfXyuYwO8FzbDhR
 N+xAcGlAjMs8PYZCexvvuaJ+YW95CkXN5ZWh88IHqYqesA8tBBdRvuzGrjr8xsPgZgMAYrBti8z
 T31R/VUdIizO6TMXmWu9DWAPioJ/oyszU3/4OBDHUzBCQ02UfKIfmjKzNhHdSQkWGmXyPaRX4tf
 KvRFU4yS1rWTvydwfKsOyWQCmu3K3Bp4n2tOHWUZ7aDgfn+lzVrYmDmWOufLK1FZbNpv4xdj/Zk
 ss2/b0jYlvdPOkOmj+4d7XHtmze78epD2uuoTd8RKJ6N8i5ftmB8lK6373QdECNdAMY4wuj3Xcz
 UkidaWVVxEXaKjPd5q0AGYWgpmN3mJIcCvWfGkikMylL2YrmC9heD2G0Zgfj9gP//xDjGFr5yfE
 mO1bdOYDl6HlWxpkJX/qFXOYacYcJfNImJ4FRa3aqfVGkpgJrMdw0+UwvglVCaOGu6tkFUpykei
 iykkWhb94ubGc5qDW2g==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a029eba cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=o9SgzkDkeAGfuexMaLYA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120028
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
index 50d9218a75..7575884d7e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1553,24 +1553,10 @@ static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
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


