Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCFFC44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUqv-0004Ds-AF; Sun, 05 Jul 2026 17:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUqr-0004Be-AU
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUqp-0008PD-KD
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:13 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HiYZf2169693
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VHVn6ka+QtlPwP926qTrHJauvq/1ZaQUcESPY4KgNsc=; b=G2g4RPBRdRBHAQzr
 mKFjqssxPfBc2n2nbRlVFTPa9K0vWApzyUkE3moyud2BZ5eqkIof20RK31ppadKv
 /coUa13CnlPtZopdbGYM/yOpbkcmILmlOn0T5W3nH1fHj7puSFkg/AAMYr94ZprR
 EWR4Roe4gJgMP/DbW+vT0u+eN2SdbD/JM6NDUJrHtACWExL7li2kY9Xd3klMD9AM
 V1tf9FOQWsFX0X+jNLD1ReKFxf4J2n+6RuxWugl8nXP6l8ieZtapYB+fc7OYRKwL
 WA36r5JNIYy/2ZxAhVaitC7IP0XcJjrnGZ8DplVTnAkv1QMujRwqPvso1Hm/qMoZ
 jkX2Lg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6tj8kfde-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:58:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e934385db1so29575736d6.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288690; x=1783893490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHVn6ka+QtlPwP926qTrHJauvq/1ZaQUcESPY4KgNsc=;
 b=S1hqEm63bdJniikHRTerlkEQEW69v0znfHIzJT4f1DTTfvcX6zc96B3SIduCYnGVLM
 3ehOLR3SUsD2mG6m0+lu8S0swOEWKnuCzM4JPIgaW5p2GW/qSw3moG7Sk3mKU1mwGAEl
 cUxLtFVz7lLaonSWJC1lkj0hCYxZJPIxre/F0865FhTiJg12O5s0mn8lSS7X5I9OEcgp
 yu+1o1Tus5T+ukJx7ehGouLFWahOhXMqhJ5TZt+9+7UttbPV1k83s+qKeXJEDlACwXTr
 SeOaz2QPJRblqsv9feaTGuNa8J+PsjbcV6rdv5Gj4oc1W6obFZ2u02ChtrcCTcC/zLNj
 Oy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288690; x=1783893490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VHVn6ka+QtlPwP926qTrHJauvq/1ZaQUcESPY4KgNsc=;
 b=ifnlhDuO6Kx5k4v/hAeYvgb1tpV8zuX3cCno7jjqx0qpQKODzYf0+6DqLgbn2/plcD
 QRrAtCJGLwlrTKkUewEYQu3PehgXzU2vyytgqTPqCFpzbizW4r0gAOTD9WFg8UVOzPdS
 xIcWJzN7ZzGPJHtCi6XFdESjvp5zDEwODVLAxp34ykJxC6tsKocYIOTokZ6jLJPz2Pkm
 Fsj7PIxBOAXjM7/efeaY+JSlDyjBdeC1BYkMuf8BCLO8PLNmJGsZV+OdrEyYRTaaCfTP
 zLXhZ2ghe/9M6bTLNALLwYpQgWjoCMKhCMuc+xRxvF7nl94EhPR04+5zghXPAlU0ju2L
 mBRQ==
X-Gm-Message-State: AOJu0YzP+JWUxPq/EGkvhpC6mIlq+TyH8Fkrebx8542IDvh1QBjWHU44
 Wf80WXBQJUd4l/U6nlHtA/m1LxkKuU7o32s0YfP3w9xKTOYRUmxDXBz21eC18xaPhKxMlbnf7mn
 Cv3mg1aLyHq4xcOFnE7Hd5Y5Lf6DvXBZLZ96AbiXgoqAbtS2Rn/AT9bpRhYz56VFZ0A==
X-Gm-Gg: AfdE7cnVw94SC/+wbWOv4cDoZnvPT1rclRg1p/+2woPhQvBoMoEErwtTPAk2XNcl+Zt
 LS5RKqDb+N3HlJghfMjoZGMRrw3YiBGbw4+qjOszp2cVptr8F7zIX2MbTpFs2Dpts8FzkTzTKeg
 /pONtc0jQiva/snNInnkezs/kGmHJiT/JKRfUOlZs97PYZRY72pjQ9A57Erve0YlWdoz9/wjYNw
 NWIvOKKjHHLxryTbydCrTrEb9hL8iuN5OGarunLnIQRe+RK/nyh2dIG8QDv2jOxwdEjZgjEHEV0
 JZpLhmB0nbAcA6LqdfmddegILjpUOmTV1NQUo70S0UmgKNShU1pF/FjNiZn8c+v00J6/R8hEIme
 O9uWypxNC8WG71PBgsLtXLkEoOu4c6/rTyLjCErPpAfCdDEnXYgd/MGXBPOdOoYw5nsgk
X-Received: by 2002:a05:620a:3189:b0:92e:745c:6c5a with SMTP id
 af79cd13be357-92e9a312a1amr1169715785a.14.1783288689928; 
 Sun, 05 Jul 2026 14:58:09 -0700 (PDT)
X-Received: by 2002:a05:620a:3189:b0:92e:745c:6c5a with SMTP id
 af79cd13be357-92e9a312a1amr1169712385a.14.1783288689463; 
 Sun, 05 Jul 2026 14:58:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d7801sm19629646f8f.16.2026.07.05.14.58.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:58:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 05/32] accel/mshv: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Sun,  5 Jul 2026 23:57:01 +0200
Message-ID: <20260705215729.62196-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX6sSlJu9iiuPH
 EPhpXSu2pIQLFl571Cv526cTzKsSke+ONFCwn0seN7KjeUXHwuyC90Kbi2Swr8nHklvb761Xcp3
 3mwky1D76QdxzdFC2gJOYOKEp7+3W+ALnXZkvjQnpInShVT9HqPRUqEJ578MLXdJC0XCEEoG0lj
 xYH0D3SvbxhkTYhx+XojJKYBR92s4vk8vS5+ikPsrIHOopZjvmmhj4z+ABWP1K90JHaQKUptQqG
 fhzajr8GLXKgo8SvtwZFAWoH94lSFOc4gkL2A0uIwFMNxSx4cLNIfb/lOi3A2QIuOptj4p3Tt1y
 0w4TldpvwOjURG/c03JxubKpcH5XcVxMiEUbfFx+XqZ5ph4058FR3l/fGcUy6oyMjdqy8CFyU+q
 zCVafNxxC6QIK7DZPtZOVmkXcg+PaI5n62DZyNe6uuAY0TjifHQPsKeSWfL7CT5O5mo4UizGa8E
 Yqmw9d2G5oszJg2AQVA==
X-Proofpoint-ORIG-GUID: q8Kh0VEDOxLqlNnv-ebK4K99p6OiljiC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX5wRQPlVDktyi
 A4X7vB0bqWVMEmkMgPkNqh5qnTP0srPjxkXq2fPDr0TjMsBgLKMgwNFAhiFylwWlfb9oe5QSCns
 roUoFYcuGMHLljV/8ZtUebfk/vwKb6A=
X-Proofpoint-GUID: q8Kh0VEDOxLqlNnv-ebK4K99p6OiljiC
X-Authority-Analysis: v=2.4 cv=H6TrBeYi c=1 sm=1 tr=0 ts=6a4ad372 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=yMhMjlubAAAA:8 a=KKAkSRfTAAAA:8 a=lTdEn7Fablbk7hdpwAcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050237
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


