Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E155CD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdp5-0005mh-Le; Mon, 11 May 2026 23:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdok-0005Xa-0b
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:30:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoi-0000JW-5G
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:57 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK81N62172875
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=W099VahclOU
 5qOAugYqR+hKsc8FjL1ROzYvzOkD4n+0=; b=UA5G4AP0BxXuEpFtlTqEoxpTl5X
 BUciaLTyhppZ3TjMRQeHhIvWD80+Usr4a/CuVdd8OH1570G0PMiKC+wK6uCQw5EA
 noQ9AnWD8ZF+4II3kO1zmN0Y06l/n2vrgJh/AF+XfWn+tzSUsJxmcAL1Z5Ch0q5c
 8A8pc6jwTyH4ZN1mYuJ1NMKcsK2Gz+i+n7YHc9pCeMqivI0YclEhKSo2xlaTKJQ9
 E4a8G9zSRPMhy+1SkqFV9h3FkhcCVKwxeAcvRd44GW/FtGecFvf7ExhJMKaK63J7
 OkJr8XUb5oNIAUDHVdLwWM2Eg972ypuH9z1jln9uz3HvvrFcGXGen8leGaA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nvj9946-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bdd327d970so2973248eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556594; x=1779161394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W099VahclOU5qOAugYqR+hKsc8FjL1ROzYvzOkD4n+0=;
 b=OC1/24q1cXe5g9CcVbxyKQwatDjuovDcp4nw4wwgi+2bEOusAsSULcKh/7FTC3r50g
 fLTkmX4IE1TG2XhVJQ8XUpmIXjvb/d/GlV6wa1DHMq+hV6OcBCnyCSCmdV7vpn6JB2XL
 KfiTm59g4XTznnln8Y3YGnZG2ptK2UIbS5aZY5CQ2oAMW9UqzUEIbnhKBdmG/vSGgzDX
 UCrx0l0TZXgFHcZunc1i5I25tzttS1BPC9RVJKqFDY/fwm6ZSbEfQpSWxMWhiuQDpFdG
 xlrpinB/FbG62PsTcH4urgk78LbZZ3Tv3+F22SLVbaBfkP5O2PKXVP7FAOZcQ/TX5eB2
 kDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556594; x=1779161394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W099VahclOU5qOAugYqR+hKsc8FjL1ROzYvzOkD4n+0=;
 b=qN+G95U6oCsrG1fv1/G99rPB1vpRaw49sPJDK78TfAfF21J8xz0nrMQA1FTm99QIes
 g81gevGljNPVuUYgVIIX6p1pln8YhlOxYh/iOcFrOkMeyku1kV2xW60cM+r6L6PqjaMy
 v/3ted6EWf3VVPMDoIWnAbsVf2Folg+gfK7CH5WpFgImzIWm+89qITZ/ZiL+X7VrCvQw
 twAdvJXGje7m3YVgHyLWt6342KWN+ZHNF99m+vEQKj4j1Hq2kfrpoNIe6hcs5pXxNEVo
 Pd6fwe2sznT6YUrLcrKujYaSI0EawCxadofG/XIpL1mJoRntSus8SulRGo5kvOvQzqff
 tr8A==
X-Gm-Message-State: AOJu0YxWku0UQdUNfH/WNCrt0FaLf7+nrodwT1PUJZtZXTnueYPwgzoS
 NRXgLo2OvOIU2gMZyMFZBwzKCfGLI07nsZogbJsC4InwA4E85v8pNqlexCkWrqfp4zGYgCKltm9
 EUF4zVcxemPdLASLZtG4hIYURO2sGxmiQw3I2D7xYk89Cl1GYgigAFBgygtmpuJCUVA==
X-Gm-Gg: Acq92OEVKen/6KJgXUPWhE+6pYtBAFU9XQUre6vpizukwdig+CCa/AHzVPjPhmnGke6
 KAw90r/VE8Sgz0pCnG7Fw+wSm5Supi5sNQV539FsMaDHVB3AO00l8MWGpGVBYSn2qYcjTkytCW7
 GmusZUZmWYbWn0IaTlYkxTxTlhx/Q1tlDalVG8P/0e7zyuci7TtzoTMPHIermIxIlxC2kYsMmzs
 ZFcH1zakcVho8S/xZIMDaMqhdahKcUXwuPOpuvW89gE/+qNEqiT60yyRAu0gZ6Osgvg849on9ap
 smyHK8ta+fLEhpTef7biJWdwZAeFUgtF2feqQr8DSWS6HZaUY/FrMlELviUIglodqZyIQfh7esy
 oRvwQB29Ub9fQ6aEKinEaUOY5OMyi1low5G3+V/muXXv6EjdFFgTfso3XpFgP
X-Received: by 2002:a05:7300:8c9f:b0:2ef:1d11:18b0 with SMTP id
 5a478bee46e88-2ff95d64cc0mr1062922eec.17.1778556593663; 
 Mon, 11 May 2026 20:29:53 -0700 (PDT)
X-Received: by 2002:a05:7300:8c9f:b0:2ef:1d11:18b0 with SMTP id
 5a478bee46e88-2ff95d64cc0mr1062912eec.17.1778556593161; 
 Mon, 11 May 2026 20:29:53 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:29:52 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 09/14] target/riscv/kvm: use isa_edata_arr[] for
 unavailable props
Date: Tue, 12 May 2026 00:29:21 -0300
Message-ID: <20260512032926.1978818-10-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: goshm5ybWs6FAFRgbaAA7x0ZSM7qXZ7K
X-Proofpoint-GUID: goshm5ybWs6FAFRgbaAA7x0ZSM7qXZ7K
X-Authority-Analysis: v=2.4 cv=H8brBeYi c=1 sm=1 tr=0 ts=6a029eb2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=rmwbAOuY7PkRKRYIosgA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfX93hkBsQq9AXs
 nsVlK9Ta1S1nz6pvvAi+N0K+s/mOO+oN2bYfA9whYCaK8I7wLSXhjvxlxTO5KxJQX1HYOtxA8SY
 Lh+DKJo3hxEqdo9if1QL6nNQwX+LYaKhtBi95tmF1zwYfpwCCAHDGXJzkA6sgcXpWnnv5bjZTkj
 fdEW6qnonXRNsvMeobj5nh0DKZXAdNht9FqI2TkJrabO6V9gsiAeBtVYUBEAx7TgSaRN5vak5S6
 K1F1yfhdlo2QuZTmroK6FECci7AbwUMlhJYToI4aAWYC+/Y/t42ob/WQcYLJtkxL7c6/LzWvc9Y
 TZqhkny6D3a+T/KvB6CQjFINX47SGUEJBt9znG1DW6PJlDcZ8V3m/yg2uqrFGygBmH86+f/bww0
 Cu5+Eg5W+PP+DjPqf6rbVgRODjrwdi+WaSPtYLuRBzqOM33zczq/Lns6GyqnREJSNSEqgso/wAb
 v8EZgYLqarKjwXUK2gQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120028
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use isa_edata_arr[] directly instead of going through 3 different arrays
to populate the unavailable KVM properties.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/kvm/kvm-cpu.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b047ffa9c0..7f56f64d79 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -525,20 +525,9 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
                         NULL, (void *)prop_name);
 }
 
-static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
-                                        const RISCVCPUMultiExtConfig *array)
-{
-    const RISCVCPUMultiExtConfig *prop;
-
-    g_assert(array);
-
-    for (prop = array; prop && prop->name; prop++) {
-        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
-    }
-}
-
 static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
 {
+    const RISCVIsaExtData *edata;
     int i;
 
     riscv_add_satp_mode_properties(cpu_obj);
@@ -572,9 +561,15 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
                             NULL, multi_cfg);
     }
 
-    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_extensions);
-    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_vendor_exts);
-    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_experimental_exts);
+    /*
+     * Mark all isa_edata_arr properties that collides with
+     * a KVM property as unavailable.
+     */
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->prop_name) {
+            riscv_cpu_add_kvm_unavail_prop(cpu_obj, edata->prop_name);
+        }
+    }
 
    /* We don't have the needed KVM support for profiles */
     for (i = 0; riscv_profiles[i] != NULL; i++) {
-- 
2.43.0


