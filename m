Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF001C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfguZ-0004wV-Nh; Fri, 03 Jul 2026 12:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfguY-0004vk-8z
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfguW-0007nW-ED
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:41 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIdRS364518
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VHVn6ka+QtlPwP926qTrHJauvq/1ZaQUcESPY4KgNsc=; b=LiauA0YqWc5zbo9X
 k/F3BT9btgvutc5gD318xmjCxRBlmNDPvAx5yqIs9lmUQL6syDX+pdDn8JGKmNAT
 Gy2BX73j303YqUcopXVuzEd56qckeZxtsFVUjl5Qpa+peDR9l2edIT5TynCpnKJZ
 CtKgJq3o9/vCjns7+6t2IdVCnjheJIMgh4kcTgA6CrQhX4duPRgEaCMuhSrqqXs2
 cvPXA8zCoo1q03wvRsa40mZu1y0/CtcecCJ0CDyyIzBvPeI+mB2WWwRhkD7b93Sf
 hyDcDbxqMG4ZJ3nDIAMFeZHRLMsPbjXB2ssn9PbZExjWGfGyFV7j4If8AfQ5bl0H
 z+g0IQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j02ac1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:38:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e663c29f2so84021985a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096718; x=1783701518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHVn6ka+QtlPwP926qTrHJauvq/1ZaQUcESPY4KgNsc=;
 b=GRH6iJ3ObzW312CpNb4ejqhtm6zg+Vxub0uIgqZ0wikbndmoTiuYCWSxKLuSkSEytY
 KAQP+wEce7F5kt/+nmIt3ucT3G8l/wp86maW+FCYOLkYE7svTJS0l0uwNCEj/Rgtaj/C
 BivCROMgfS64OJLvnfJCETZ1EyDnxm+YUSBPuPX5qWmD8r9AI/StxxYh126h0+1xgKFE
 3cOGGEpn0SZlowFEhqTpPHoC8OBqfRPTZCjCO4zBV7SPtc3oLAWq9dcmPUQaJ0L0PiQu
 AVhinPOB064adgiwNa3XvMLlWDmFGc5o9NemrcKF3sYRBijczBgXFiA77X4XzXC4v/bi
 qqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096718; x=1783701518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VHVn6ka+QtlPwP926qTrHJauvq/1ZaQUcESPY4KgNsc=;
 b=mYmmTuCOS/lT6+2E6NmqjyZH4tTUXK3KtBU8WJXKOmpV6jmU5txMoXMl9POW8OGKRO
 UOpwB2rtbm71DSJ3YAVliXL6lGWQZmtYNBAN4bhjiyIt43QOVNFaOHNmzMvuPTkPq0xD
 d3iw9EjlN4HmisF6lcD98XOtMpMoH/6o+p1XNjWM/4azQ91P6aErfp5D8B1oc4dTqhV2
 4V/iEWaDyG3T4pz6gB9B0ok1OxhtXn7E/E8p4cZiDiynN4U3jIWDkNHpfh8/jLU1bRBR
 srtEpZ10ZFErmufArshaHagM6JO4VxgAXPyviwtQ78rMEwWGRSGgfOVHTGUn241QdX74
 0dgw==
X-Gm-Message-State: AOJu0YxsRgKSq7cND/wXYBGZd1P4xeb2wzt7ScMZlkPPLpQNfK+S8tGW
 eOjznUPGt8cyko3qsv0r4qUP5TAlr+tTPC8vmDekZQGEXvx3w5X3KMvOQOz35LO87ymDoPCdlEp
 ABD6Z3K3vwA4A0K5ktmmv8HSzXgh3/B49+ZHvpuvzEo4m76hhlaHuUSOdHwmi+a0/xA==
X-Gm-Gg: AfdE7clDCHtV4Hp/A1n4bDtSn7lwPxihzwf4a3uTuk2dmV4BYRz2O5V1QkuSJWxhgAl
 oT+vcPGnP0dJ5Zy329C1Yl5/VqKvkqN6Lecmw6MfhzLSw5qgfLrBaVaselW/bKywl6sjrTJBWqp
 rt4pA7hnTr4FvzhrI3Hc4tkQq1KQPcQTteyOmVF0TJ8bX/UQXy3f7/rBTtpBYRNUDx+Y3YZUmne
 SSnUuhNMfH99BuZJSrs+cOGWOjWBsrvG3GmcU427/neHAFjp8wHW4BNBTuBNZhM5doNZZ3JvCBf
 zr3V73JYpYoKBHvuLUtn8lOs9UbCseyYQ9hvLyoVtV9plxY7PjARbYjAQC8/C+/ta7CCsaHeG+u
 G1QgOj0+6w7Ndi6QgRD/2VORC3s55Xt+N40+TVWjyhzeFfIXJk8T/ocIthCX9GYom0EFp
X-Received: by 2002:a05:620a:1a0f:b0:915:8e2b:e5de with SMTP id
 af79cd13be357-92e8b25e83dmr565244485a.7.1783096717795; 
 Fri, 03 Jul 2026 09:38:37 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0f:b0:915:8e2b:e5de with SMTP id
 af79cd13be357-92e8b25e83dmr565239885a.7.1783096717238; 
 Fri, 03 Jul 2026 09:38:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm567118f8f.13.2026.07.03.09.38.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:38:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 05/33] accel/mshv: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Fri,  3 Jul 2026 18:37:28 +0200
Message-ID: <20260703163757.55500-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: u4DMNTCkIKaq5MfW9LRFn_JCcnAifmMa
X-Proofpoint-ORIG-GUID: u4DMNTCkIKaq5MfW9LRFn_JCcnAifmMa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXzOWzXiNH5wOc
 zOEHrESbDvBg+CPhiDlXT9apYE5KGSnAbEfeDo4MoLs6B3aZJFvjGaLcTKCEZ8FfoG43pm/0jFD
 GNAW0PGS3zbYESNNkNnZr7RYqxuiJ/w=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a47e58e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=yMhMjlubAAAA:8 a=KKAkSRfTAAAA:8 a=lTdEn7Fablbk7hdpwAcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX3GDrOiNtzBxx
 qdogSekViSDoLPFc5hndHiLJwL+tQufwEFRxhQ3+3qDlb4ry4m8BpXcvmD2ipnbe1VaLfnds9el
 kOwlfif3cc5uanI2/gg6/gtq4ZeI9KJU6BSYZUxQ/Mzw0Al6edNpXgWpQ9+ErFAV3fdMgz1acDd
 Wh9x9/tHLqPhu97aVmeYgf9gHen/ywCPCxrXHvJyeFpf+Lg1xKz7GWQh61vRZ4mWcALUYpwCMGc
 x0iO99I7Ui21jUMmrBFxGTUQ3vRM2gAQfpXcby4FUEyyRoiJ3aJbEdjbxYRSVQ4zYghvk1GCRAA
 uoRmq+jjGTyvyct2l7tWLs1fadBCaxCdbl/o/6TobGrCdgjrX7QZwMnUIy2xae2x1hSQk86OId3
 zttQvAUY7kOamEMCg6spWMnK2QtXehHktglmgp68WZ8ICP16RiQEZ8JxlaD6KK3bsPlURc7GcEV
 TlhaBeLidWY+wEwzm9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


