Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695AACD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdp9-0005rh-Gu; Mon, 11 May 2026 23:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdp7-0005pz-VG
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:30:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdp4-0000XT-4v
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:30:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6mFH2519102
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AnrB1xbrFro
 OjcufJeN1FfC26ygJUrrhjKXChoooHK8=; b=aXtMef4BzWaxafrtjM1qtUP08p2
 a6GrKnmDq0JiFWryxkclw02x21rmasgEwuqz6dTAYMGesE7VWOz/372M8OiL3+h0
 6lFRpSWIxw3k03Io0U0ZNV/587ppqnUmQnp2l+f6IiJpDsxHfMIy8PoBz9CMRQhP
 cM+QemlHqW3hBd1E3hIASvm/CJNYkqXcEXpTCjIAzcwHosY+KX2qQRETBR6TSC+S
 m3HiYM5Ui/Dz7LBHlNvbMLpkDf3l1EI2xuZyc9jkXh5CR/Mz/WzRCAEbNrOcK0NB
 zx7ghq1PwRZjBAosl8I/2993ZMVZUY8PHBxF0VDgNsBJn/8ztj6sjlzRk9w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1h8xa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:30:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ee34588671so7265534eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556604; x=1779161404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AnrB1xbrFroOjcufJeN1FfC26ygJUrrhjKXChoooHK8=;
 b=CZmhMjDpEkN5kzYxO1eUd2GHWMOMERrWJEC02mjysOcqoqIqPFzrjN8DHjMDu2gIkB
 iu10JV+AHTnKUCQWkZP+DNPngYoeM5ikOkanFLT6r3EgMsBweZbgKW3P+mWY9QHtunDN
 WONgqSjBXk49Q+V2TG3dzjHM23gr9hSwTvQeNwetFTg/PXyf0KVkOu524Y8H2eYjMYcX
 80abQkMw2oJs/evBRRyBeGDpM8gqvJ51kg2t5rX5A+ds8mqW8mk9W6gM+cG9XdrwXBZp
 fWZ0Ji31p4UNQIS4n/Xb2YlkPrr7Cd2JqnmUh8CJWYQhQiFUoDWQG7bYgOn30xcEMZfj
 2YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556604; x=1779161404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AnrB1xbrFroOjcufJeN1FfC26ygJUrrhjKXChoooHK8=;
 b=SnIEIWeuKIWM7vi4wjF9IzlEB7bCYt3+/M3ErWg4QTe2IZIAsvU1fqAvP1h08ifdQo
 zwQ8ozYO0dOcBrX5s0m5UMyxeTY7bzQriticNxLIUOVGIxDJTqzolvS6aDd6/wvZlfiK
 Txg38ixWDQqa3Z+HP4fIK6ZunoOAKQOaS40sNCYrjXlx0S4FW0JioUnkWI33vqjuoLw7
 irYEcDkUUkRKvVkrHcBcqvVSnd4+BhN0BqqmBiL7Sk7gWVqLroVJSEjKy+S1krOYwBuk
 zPN1RoMDEtyoGVY1iSy1ezkaWC26N/iY2/68Dkjaxa9IoZBIUjpusm4ysnT/KL9PW5Ls
 e6cA==
X-Gm-Message-State: AOJu0YyAj7ITr2FE0/zKMehxwfgXVB4pF1Tfj0gTEpAmReCDQsb3DqB1
 sZGLBpvAy1aNzscaqQV0oTcqXgC1SXk0Y2t7aJFsKX+NublytqtbcSmQxICEALWcjP7w46yhDWo
 aHCFUtGmgI/b4x2uEAehhtB/SqTm09u7ugfMAFRdQJmffRVxnfzrgkXuSJaC+yqmeWA==
X-Gm-Gg: Acq92OHM+vQ5+dzvAMSXR92z6N/xTTEb4mp3/ICe3KdGJS1mDsdhkfG3cum+7qELafd
 W2Mcb6En+Hwsi52gAppA7b3psr2xiGmTvOz1gRGbUTxSCWqx8adLuGRQSl2JC3+Tss6/FoRYfi4
 +4Gk+khq5efMf7ZDS/jJ4+uXmKuRGD5srxR9adORIGEr0SqsNk9SMEMrKz+R1AhjtnAenm7Or2H
 Hp7CG+cKfs+ZJkypAZ5VsN2VeXzYRM3T8LGcJeILbdH82D2yIwaIXzFaxju2YHiOfxGXWMv0TFF
 d0wil1Vug0BUX3HdZSWbYDFXJtd5d+QEgEkhOvLNR6GN5o3LXYeNB9HUxHQszs11z93CGGF2Awd
 zx5t302b8t+SZl+qN9knyjxpu0W3kxOd9Qe/CMZOZEqhvOiwKaQTM6hy6jvsA
X-Received: by 2002:a05:7301:198b:b0:2ea:4228:ab11 with SMTP id
 5a478bee46e88-2ffd51d55bamr740812eec.3.1778556603862; 
 Mon, 11 May 2026 20:30:03 -0700 (PDT)
X-Received: by 2002:a05:7301:198b:b0:2ea:4228:ab11 with SMTP id
 5a478bee46e88-2ffd51d55bamr740798eec.3.1778556603267; 
 Mon, 11 May 2026 20:30:03 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:30:02 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 13/14] target/riscv/tcg: use isa_edata_arr[] to create user
 props
Date: Tue, 12 May 2026 00:29:25 -0300
Message-ID: <20260512032926.1978818-14-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WcTjUSysPufVzYUClv0aqyrdUr-e23Lz
X-Proofpoint-ORIG-GUID: WcTjUSysPufVzYUClv0aqyrdUr-e23Lz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfX9RHQ4JiCPare
 KqaNOlG+sSkGs2eR22uHcbUjJjsUrPXaBBb/Aw6HcDKTJsQIWl8ne0Rl/r6FhzwcTU/SDbOTesv
 BoeaNwM1J9sDZFK3N8NGi5SXZi/AGZqgPT0MP9U6TlAK2WIDBs/m5bv8MXTwHNxbmb5vwafo/Ah
 GaIvNyud2BPop4d/V8rvoDVYDYLxVT6IEpaoLWnl5k/ZtfNRD+R3Cs0mffHN08t/ujtYvZVQ4EM
 RzIGMU9TT8I3HALH4vKaNxn64DqJWRyWeI/7CHaAN+AZAymsOS4kBRQawDarleb0jZY/zGjsvoL
 WwX/svq0f3LrCfVqkQCHUPxKJi0ZavnFOPHgpHo+rD+0DdxKqVfYyAeWTEIL0eBimUYvCtlfecx
 2NLYKq7Nc5Wt6JlLqFZ1ess7i0h3bjPoXemT3TiMZg0l98afpaYJIoBuemHmiXwlfptpMbnmdCw
 2cQ6/P1upV3+cEKfcmA==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a029ebd cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=09xACSZT9nARZ3l9mYoA:9 a=PxkB5W3o20Ba91AHUih5:22
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

This change has been done twice now: one in riscv-qmp-cmds, another in
the KVM.  We're now ready to do it for TCG.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7575884d7e..3e22e7ed53 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1550,27 +1550,6 @@ static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
     visit_type_bool(v, name, &value, errp);
 }
 
-static void cpu_add_multi_ext_prop(Object *cpu_obj,
-                                   const RISCVCPUMultiExtConfig *multi_cfg)
-{
-    object_property_add(cpu_obj, multi_cfg->name, "bool",
-                        cpu_get_multi_ext_cfg,
-                        cpu_set_multi_ext_cfg,
-                        NULL, (void *)&multi_cfg->offset);
-}
-
-static void riscv_cpu_add_multiext_prop_array(Object *obj,
-                                        const RISCVCPUMultiExtConfig *array)
-{
-    const RISCVCPUMultiExtConfig *prop;
-
-    g_assert(array);
-
-    for (prop = array; prop && prop->name; prop++) {
-        cpu_add_multi_ext_prop(obj, prop);
-    }
-}
-
 /*
  * Add CPU properties with user-facing flags.
  *
@@ -1579,15 +1558,22 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
  */
 static void riscv_cpu_add_user_properties(Object *obj)
 {
+    const RISCVIsaExtData *edata;
+
 #ifndef CONFIG_USER_ONLY
     riscv_add_satp_mode_properties(obj);
 #endif
 
     riscv_cpu_add_misa_properties(obj);
 
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_extensions);
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->prop_name) {
+            object_property_add(obj, edata->prop_name, "bool",
+                                cpu_get_multi_ext_cfg,
+                                cpu_set_multi_ext_cfg,
+                                NULL, (void *)&edata->ext_enable_offset);
+        }
+    }
 
     riscv_cpu_add_profiles(obj);
 }
-- 
2.43.0


