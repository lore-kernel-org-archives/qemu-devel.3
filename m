Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5299C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjef-0006d5-7d; Mon, 06 Jul 2026 09:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjeS-0006UE-5s
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjeP-0006Ip-LG
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:23 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxDm8238262
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ydw1wznZXSAB0x9OfCcI5F+1RiZNU1iwVhUsvHWYtEQ=; b=ZP4vQymQvbSNw3Cc
 0L5a9jofDXwNqMeQYoLsbPRlc38nmONlhXXstI/vQVrWNArmM1mk11A57UJ8xOtQ
 5ZRwBcTFrGf0fnIfWDyJS8EkbwuT1XrtkVkYP/D3yFO3y4bC9lOAJJgktVfw7x3o
 VibloAZoaHnxruSqeP8KV/K6bBC/FhIDPI5dq0KOqpnZWbTxQDXK/DkyWUpN2gRS
 JuF9U/Jqx9h5XokPlgWqOq22r9PB79irPvHTpKWRMRtW6qarUGrW2ABWF0dpKmHr
 t+u8CKWQ24qKLKIICPEyH3Z3qTCnTZFMOt1iEhGm0+Uv6fm3dZ8q0v3APFhcMtZ+
 vLaGOg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t898md-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:46:20 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5bdad49fe15so3102450e0c.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345579; x=1783950379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ydw1wznZXSAB0x9OfCcI5F+1RiZNU1iwVhUsvHWYtEQ=;
 b=V98FEMcw3B+gFV59WuT6sV+I5O7UmWZq9TWVAuxC6MmhFrHhHAicaGJZ5mGujU1JqA
 xNejEBwUkxQbY8dAXeNKD2DAAHpkD4eLkwIfrSZknBmiFRFTcY0Trnnwz+xo/4f2deka
 eppFyHOZToRB2GAsCy3y6zgybHLm97R5BaztYqqYSIHVe8a47R08MJpGle7gAYNkR14E
 swJhsAHMmn/SjCilsuMbotTYgtHl/Zhk4up0fBz3NFdk8fSg/2BlhsTi7Qy5LbdS5Lb/
 tM+No87OpPQLIujjjgAcf1DoodaBl1p00V+DXU3I8isGSDIrcCWbrvJafuKhYrXzWza9
 6poA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345579; x=1783950379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ydw1wznZXSAB0x9OfCcI5F+1RiZNU1iwVhUsvHWYtEQ=;
 b=Azr1y7zojgdS8BBa6fAuL1VT6Zqx5jJaLjFE3yaCrZsDE4sSwvDN5FTGZiUR1t7ltU
 u+dd/fw3Q1TEkamI3OrI+55oN+S402ijEDLL1xG8Q5nNVN/ubpGzv9baFNTXnSmlN1Mg
 3MQWdNFso2RxdtYaIlS9P9gM/iErWD/I1YI31ELGqyGVHFsYkaIy+M1ESbJuKhBMtfKJ
 9hNOrFoxUI42KTczfFtDHLjNyQN0j4NGoso13SBVr8s36k40exRxXy1oF30D16d2gglG
 VuWMUgI6hRoCZWZHCW2EtCx270PlHccIUhtijkY0AEpoI8yfN9Cf0R0bmwC9n6bNpVt0
 UNmA==
X-Gm-Message-State: AOJu0YyDwT0G2ByL6zvnmlbAI92LZuDowlPoB3lybiREZ/AdkpH+KF7c
 KlFrygGMpC3Uqs0mC54N6hPneV2S8DMNTUgu+yTl2pDCa2u/khHzIxhAp7nD+mZzcBAZ2RvPt6m
 7A1dLHzSULbgYuur3qnhRf5lKRDxBk5BuUh/Tfr3iKlQq2CLmV3pUbya8MCJdWefS9w==
X-Gm-Gg: AfdE7ckl+VpnjjjHf3KVdqSHBfsvEu7bjxffucRv5+PKsoOBVQMh3dzbXHS23KAhr6A
 87x9nbwL1sdZQTKbTR+6Cvvz8KVNXcDht4jqFtFI8FbY9GSXM9EFv8WxRQFs4fggllW85tZnmMs
 pJX4d2cxMV4p3s5D/FB/GVaOX4WOMtkO05QSiGDOTMWE56aWFamQQ4MNjgooL3IAg+3qtwkcdeg
 kVnOLdZ00qZ/bGZnlTEOfTmzfENQSfA7LA4y8zTYgGKguwLU1JuTWxff6knDJgyswfSnWPBCtF4
 C2PQprhHNWCRl0wSrGzrpBB6D5RWUxWdGaeZfNwJgSjZ62QRwDjt9nzPKQWmXCa6Mk5/YHFinM0
 KQlpZGmXU9JLCztbtclDh+z3CBOp7TDuU6wnUkVMH5DMfR14AcIBQIR5G+A==
X-Received: by 2002:a05:6123:161:b0:5be:bea:6ed with SMTP id
 71dfb90a1353d-5be90720aaamr353455e0c.4.1783345579248; 
 Mon, 06 Jul 2026 06:46:19 -0700 (PDT)
X-Received: by 2002:a05:6123:161:b0:5be:bea:6ed with SMTP id
 71dfb90a1353d-5be90720aaamr353404e0c.4.1783345578626; 
 Mon, 06 Jul 2026 06:46:18 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63ba971sm618972245e9.13.2026.07.06.06.46.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:46:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/32] accel/mshv: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Mon,  6 Jul 2026 15:45:00 +0200
Message-ID: <20260706134527.84808-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX4r/ZqpWU4WhW
 qCaxPJ1tfA+Rr4nRSwYuP3gGe/AEsamfCQKu7P6gAn1FbCwrBm9q4QKwprIUZzLsYajERRZM5bg
 TfODmrckplDtRSWMgdTUA9vDjTb+0aw=
X-Proofpoint-GUID: fw1QdA3ax92oHrCV84MKWV2-IcV74i-P
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4bb1ac cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=yMhMjlubAAAA:8 a=KKAkSRfTAAAA:8 a=lTdEn7Fablbk7hdpwAcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: fw1QdA3ax92oHrCV84MKWV2-IcV74i-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX/OkFpPAUat0d
 7rRfdT6dB+8cS2Z+uuLoQFSK48vCAlCbOArYzDF8iFZi7HLqP1aW+3Ox1onmLLkPvCFL5wrfDFg
 AWuQhrGYbU8w2SOXWRQPDTZDVA9l+CqeTnjOwN/7sUFbU5EvsJONwxQKfi9dZdEP5WjHUmOseQq
 cGfb63qGo3UX7Iw1mLcLGrquhvOYrVM7W+I854cogvbZbkqrBDPsQwJF3ZqJwBvSjGOXATeAiTL
 J3yNLfEUeXXdi764y7H+NxkH51ulzZhJbnGTB96f3feRtq9EfaG33dLaM6/LouRnM8Lcb7DCTi5
 KnH+V4QFWbhoVojeVTr68EgH+Qi91DFmb6eF7kwP2ntxUqS19/gi9nax2uZremxL5fciRgPSTOW
 vzILvGCOqiqdyaKjsbXJsMWSPU6OO9Pq1N7bp0DVb26E6b2EixPlyLTQfdFR6F2juXnVcVLfFOf
 jAkApPbZKWf5xz+IsIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060140
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

No need for accel-specific @dirty field when we have
a generic one in CPUState. (Other accelerators already
did that in commits 6f13a0ada01..36ab216b81d).

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-6-philmd@oss.qualcomm.com>
---
 include/system/mshv_int.h   |  1 -
 accel/mshv/mshv-all.c       | 18 +++++++++---------
 target/i386/mshv/mshv-cpu.c |  6 +++---
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index ba3073888ac..b91c4d661a3 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -43,7 +43,6 @@ typedef struct MshvHvCallArgs {
 
 struct AccelCPUState {
     int cpufd;
-    bool dirty;
     MshvHvCallArgs hvcall_args;
 };
 
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 9452504ac28..1959baf6672 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -531,7 +531,7 @@ static int mshv_init_vcpu(CPUState *cpu)
     }
 
     mshv_arch_init_vcpu(cpu);
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 
     return 0;
 }
@@ -617,7 +617,7 @@ static int mshv_cpu_exec(CPUState *cpu)
     cpu_exec_start(cpu);
 
     do {
-        if (cpu->accel->dirty) {
+        if (cpu->vcpu_dirty) {
             ret = mshv_arch_store_vcpu_state(cpu);
             if (ret) {
                 error_report("Failed to put registers after init: %s",
@@ -625,7 +625,7 @@ static int mshv_cpu_exec(CPUState *cpu)
                 ret = -1;
                 break;
             }
-            cpu->accel->dirty = false;
+            cpu->vcpu_dirty = false;
         }
 
         ret = mshv_run_vcpu(mshv_state->vm, cpu, &mshv_msg, &exit_reason);
@@ -746,7 +746,7 @@ static void do_mshv_cpu_synchronize_post_init(CPUState *cpu,
         abort();
     }
 
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 static void mshv_cpu_synchronize_post_init(CPUState *cpu)
@@ -763,13 +763,13 @@ static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
         cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
         vm_stop(RUN_STATE_INTERNAL_ERROR);
     }
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 static void do_mshv_cpu_synchronize_pre_loadvm(CPUState *cpu,
                                                run_on_cpu_data arg)
 {
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -779,7 +779,7 @@ static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
 
 static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         int ret = mshv_arch_load_vcpu_state(cpu);
         if (ret < 0) {
             error_report("Failed to load registers for vcpu %d",
@@ -789,13 +789,13 @@ static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
             vm_stop(RUN_STATE_INTERNAL_ERROR);
         }
 
-        cpu->accel->dirty = true;
+        cpu->vcpu_dirty = true;
     }
 }
 
 static void mshv_cpu_synchronize(CPUState *cpu)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         run_on_cpu(cpu, do_mshv_cpu_synchronize, RUN_ON_CPU_NULL);
     }
 }
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 126ca40b481..1c433c408c8 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1692,7 +1692,7 @@ static int pio_write(uint64_t port, const uint8_t *data, uintptr_t size,
     return ret;
 }
 
-static int handle_pio_non_str(const CPUState *cpu,
+static int handle_pio_non_str(CPUState *cpu,
                               hv_x64_io_port_intercept_message *info)
 {
     size_t len = info->access_info.access_size;
@@ -1748,7 +1748,7 @@ static int handle_pio_non_str(const CPUState *cpu,
         return -1;
     }
 
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 
     return 0;
 }
@@ -1909,7 +1909,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
         return -1;
     }
 
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 
     return 0;
 }
-- 
2.53.0


