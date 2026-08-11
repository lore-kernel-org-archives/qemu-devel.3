Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA57C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrJm-0007oT-UA; Tue, 11 Aug 2026 14:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrJc-0007V7-AH
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:35:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrJW-0002Yp-8r
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:35:08 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGO5461169712
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5h3eobnHT1X8C7Hj3fqDLl59b1w5d8j9Pcc2IV1gHOo=; b=BAItJ/rkJoC3tO2Z
 RQ4sLUo2IKcJ/WricJz/XlLXB6gHPJ5DmKBgt0/wstMbNYFg0scuUMpPc4Xee/hu
 oQFVBnHmoT3/EaUiB8LM8ir25GnS6DrbJBjAPFWmZ7Go3RdtiCGyG7I8GAKXi8Y0
 ZyNj/WaLcGZg+6Ogs90awsL5d2BStxuwK1rSJUGya9sqaiGfRjkz7fksbNMCseIF
 NRiqAovN+vHab9/YkAs11ZiEO13DO/o1FtKa/X2xGxHx2TrhH5rCSMt3zAGd5/0s
 vtPhvlndsNu24yzY5OHr44LgtaWh0Y1Yc5hOBSoEVVUI4tArz4O43x5pU15foEHM
 q5t8hA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc23g5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:34:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso3235771cf.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 11:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786473291; x=1787078091; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5h3eobnHT1X8C7Hj3fqDLl59b1w5d8j9Pcc2IV1gHOo=;
 b=YFv5qe23TMJkRa4/0MzPNttyHDkmiP7XrzBL+wj+ILfDxxirsQyhqbjnY/7tQe492X
 swd8jSlfxcnZLcUyRwuDoGkgXZBTFiAk6XS27yVV9oD5H6z7qcrHE1MoumuZ3WSjhvH/
 pNFWaZHUfFse48zKDhf46698Mw6hCS1WBwNAYuMELaNRz+UdOW6Uya0kkCxGAo9uqFMP
 gR2QnrlNLE8fWKFxeq3ekApQa09WhA0lr5dRAuwHqmM/nz5/Wen0k5cZwRczCU1kvlcB
 bnxCxmDO8Y48NQ7+faVs1rFkX2pn563ZLWhA/jUtNzH3lsBI1/p1ZNZg/LOzKqsR199Z
 3qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786473291; x=1787078091;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5h3eobnHT1X8C7Hj3fqDLl59b1w5d8j9Pcc2IV1gHOo=;
 b=aaA0sSFguOb5lJ7/9s2zXAkEvZ/v12TIZGtCn40FQagHHaaU1ero5oht5DpR5I0wce
 idNLwHXI7TX94Y1MzCYYx+ihc0k7EJDaUfEIrrB5mnEGd1iLsHMRSE0tds9Wex6XbgE2
 fhnHW4v05flKgBPodZkVtFCPEGT2HL09psQZYWzd1D03/KDKFxFNbBsWajU49qKMVj4G
 ohM6+5XVrTuP5z8Xuj9hLDfcvr2gG9iR+in/FbVPzmjWr58YcnuNfrHAbc+c1OE9El9A
 chCoezk/5FtiLqgXRZlButkGR7HHuGYudh2daL9ZTSVUppFP1WZ6/WZgbYLhFDRmIxXm
 lcPQ==
X-Gm-Message-State: AOJu0YxmVxFHLbuDdmcoykXplWMCsNgm5L9ZrlTt4Eiv5eEbvXfvBKjc
 7ZfzoxJwK0zlVncm2bXUXoa0uC4p3FZQILlzHGo0rjzAuSHQjmoID372PAJtCD5O/+6D5tWUBPd
 jFqBoBwpdl9c16cbexFPm8afYQKAzvZD3xDjS0aTfwcfgj6mLDHaShMfbzWEILjJnEA==
X-Gm-Gg: AR+sD13k3s8rGR3C/ycNElPqVonBtbkUgTLDLEf6UJQwLhLwKXRHzidGBfdrPjoyBlY
 RmnxLs9GftiAI794QZ6H+7F8gyFpOOKLRWqvw3gu/792GUKkdHanOKVEafpFKEyGN5d/fFmvAjy
 LKqBAe3DpYaHeYG1g8GIMx95Cy+d2ZrTX+DahlhaG6l7iR/Y4tLnjhR77nxBVqz3wKQPD8LSrx5
 j8ef0Yb4yKqbJXogf6CJ4D9m9TlU5V89hE5m7EN9vyUVjvUDHWvRcYy4un6aosHlovqpk/PCbYD
 mXah+n6xpFxbRTdyg6erPFaNbYNHlw/6AjrMrpfAE/DGfLdN2NrfGr6c5ZJb8sb9OwG9vEpvISH
 uoCIStP8pNJ4F/l9FaBlt05pl+6fKwY46GMGfeXL1EA==
X-Received: by 2002:a05:622a:579a:b0:51c:ace:de6a with SMTP id
 d75a77b69052e-52d5852c5efmr57869941cf.18.1786473290433; 
 Tue, 11 Aug 2026 11:34:50 -0700 (PDT)
X-Received: by 2002:a05:622a:579a:b0:51c:ace:de6a with SMTP id
 d75a77b69052e-52d5852c5efmr57869311cf.18.1786473289936; 
 Tue, 11 Aug 2026 11:34:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150c08982sm346738f8f.14.2026.08.11.11.34.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 11:34:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 5/8] hw/cpu: Rename cpu_exec_realizefn() ->
 cpu_common_realize()
Date: Tue, 11 Aug 2026 20:34:07 +0200
Message-ID: <20260811183410.22428-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811183410.22428-1-philmd@oss.qualcomm.com>
References: <20260811183410.22428-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX7tE1pYgwzUMb
 WLQaLTx/63tMXjVQnKDPDHGVvqm5VDo+gEBDEXaZUFBMwZOGN925ZW039DwNhysz5ODn/UiJ4AQ
 yEUm4Nz7y3WncMXEb5POpI/PjkpAkVk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX+XTSIPE2l07h
 m4sj6+JIeov+Jx8PhTDlg7//w/mvu8M1OuGg6LAUA+pQFLFDOAYZSErcxn9DAxtaWgn2s9jUbpX
 vOzuLU35sj+6u7+xbfy1yfjPeDbEjQDJdnLYd3bdmJiRRUjTYS821b3fAFXTdBmLYl42AetGxnT
 2HKogxLmA19HfN7hokasBf8izOdpwri/zcUZ/x3SKi/whLkQK/K5loDfWlCs9ewACbZ1bvLdVqU
 3w27MTDXY8UWheY5YWnwPkJIfisTE/r3eB0InQDBBAt0idgjYLbB/k+rAUSrKUhCsQ1KtkBeJJX
 +T+SoNKgXD7oxJmjKO/qzRvFHvtz6K8ChQpUpodqyhnUZ8N3+DwAE2wxptiz9SFs57zs+SJdAjo
 oPtbms6s7t5odLoDH7rr57VDNkesZ/0Fp+AGPJ5C9BcW7wF42Be93p9Fk6/EUFLWFG6EcVIuUJO
 isQ1+Y5Fj9K+kHk1rBQ==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7b6b4b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=V_ZmIUVNQuF7PYEw5wMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ZbC9YOKIQh3yaTANJAW-dU0U-Zi4PSPc
X-Proofpoint-GUID: ZbC9YOKIQh3yaTANJAW-dU0U-Zi4PSPc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Keep cpu_common_*() pattern for publicly exposed common methods
used by target code. Use cpu_exec_*() pattern for internal ones,
mostly to distinct between system / user mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h      |  3 ++-
 hw/core/cpu-common.c       |  2 +-
 target/alpha/cpu.c         |  2 +-
 target/arm/cpu.c           |  2 +-
 target/avr/cpu.c           |  2 +-
 target/hexagon/cpu.c       |  2 +-
 target/hppa/cpu.c          |  2 +-
 target/i386/cpu.c          | 10 +++++-----
 target/i386/kvm/kvm-cpu.c  |  2 +-
 target/loongarch/cpu.c     |  2 +-
 target/m68k/cpu.c          |  2 +-
 target/microblaze/cpu.c    |  2 +-
 target/mips/cpu.c          |  2 +-
 target/or1k/cpu.c          |  2 +-
 target/ppc/cpu_init.c      |  2 +-
 target/riscv/cpu.c         |  2 +-
 target/riscv/kvm/kvm-cpu.c |  2 +-
 target/riscv/tcg/tcg-cpu.c |  2 +-
 target/rx/cpu.c            |  2 +-
 target/s390x/cpu.c         |  2 +-
 target/sh4/cpu.c           |  2 +-
 target/sparc/cpu.c         |  2 +-
 target/tricore/cpu.c       |  2 +-
 target/xtensa/cpu.c        |  2 +-
 24 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6490fb070f2..7b7cf330cde 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1178,7 +1178,8 @@ G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
  */
 void qemu_process_cpu_events(CPUState *cpu);
 
-bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
+/** cpu_common_realize: CPU DeviceRealize common handler */
+bool cpu_common_realize(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 33e349d4402..732e32fade2 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -230,7 +230,7 @@ const char *parse_cpu_option(const char *cpu_option)
     return cpu_type;
 }
 
-bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
+bool cpu_common_realize(CPUState *cpu, Error **errp)
 {
     if (!accel_cpu_common_realize(cpu, errp)) {
         return false;
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 0c35067b202..12e86021663 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -117,7 +117,7 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
     cs->tcg_cflags |= CF_PCREL;
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 787e4dc7ab2..77aa78f00e2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1891,7 +1891,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 35912192126..f8409f32ab9 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -131,7 +131,7 @@ static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
     AVRCPUClass *mcc = AVR_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 12d27ce1381..8e3b900e8d9 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -450,7 +450,7 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
     HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index a68152f9682..07b49e51326 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -181,7 +181,7 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
     HPPACPUClass *acc = HPPA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab92..9b2aa178062 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10164,7 +10164,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * These may be set by the accel-specific code,
      * and the results are subsequently checked / assumed in this function.
      */
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
@@ -10179,7 +10179,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     if (cpu->guest_phys_bits == -1) {
         /*
          * If it was not set by the user, or by the accelerator via
-         * cpu_exec_realizefn, clear.
+         * cpu_common_realize, clear.
          */
         cpu->guest_phys_bits = 0;
     }
@@ -10188,7 +10188,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         /*
          * The default is the same as KVM's. Note that this check
          * needs to happen after the evenual setting of ucode_rev in
-         * accel-specific code in cpu_exec_realizefn.
+         * accel-specific code in cpu_common_realize.
          */
         if (IS_AMD_CPU(env)) {
             cpu->ucode_rev = 0x01000065;
@@ -10201,7 +10201,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * mwait extended info: needed for Core compatibility
      * We always wake on interrupt even if host does not have the capability.
      *
-     * requires the accel-specific code in cpu_exec_realizefn to
+     * requires the accel-specific code in cpu_common_realize to
      * have already acquired the CPUID data into cpu->mwait.
      */
     cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
@@ -10230,7 +10230,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * Note that this code assumes features expansion has already been done
      * (as it checks for CPUID_EXT2_LM), and also assumes that potential
      * phys_bits adjustments to match the host have been already done in
-     * accel-specific code in cpu_exec_realizefn.
+     * accel-specific code in cpu_common_realize.
      */
     if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
         if (cpu->phys_bits && cpu->phys_bits < 32) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index e164cef2036..da8d77ade06 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -57,7 +57,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *
      * x86_cpu_realizefn():
      *   x86_cpu_expand_features()
-     *   cpu_exec_realizefn():
+     *   cpu_common_realize():
      *      accel_cpu_common_realize()
      *        kvm_cpu_realizefn()
      *          host_cpu_realizefn()
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fb03424ffa8..cb07f15110f 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -704,7 +704,7 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9ad3057d91c..ce2707dee5a 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -389,7 +389,7 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
 
     register_m68k_insns(&cpu->env);
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index a97c92a7b68..389a5124b12 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -251,7 +251,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
     int i = 0;
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d72044aef61..669c7d99bb7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -544,7 +544,7 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     }
     mips_cp0_period_set(cpu);
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index ea29b2e01fa..66c00c0930c 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -170,7 +170,7 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
     OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f404c7e549d..b07e9c3ff9c 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6921,7 +6921,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a82e6563bf..23b5023dd37 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1226,7 +1226,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 495cb42dc89..97069bf597a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -2006,7 +2006,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
  * We'll get here via the following path:
  *
  * riscv_cpu_realize()
- *   -> cpu_exec_realizefn()
+ *   -> cpu_common_realize()
  *      -> kvm_cpu_realize() (via accel_cpu_common_realize())
  */
 static bool kvm_cpu_realize(CPUState *cs, Error **errp)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4af5cd9c731..9e3cc87f8a3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1304,7 +1304,7 @@ static void riscv_cpu_set_profile(RISCVCPU *cpu,
  * We'll get here via the following path:
  *
  * riscv_cpu_realize()
- *   -> cpu_exec_realizefn()
+ *   -> cpu_common_realize()
  *      -> tcg_cpu_realize() (via accel_cpu_common_realize())
  */
 static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 20b188c24cd..9b8473d71cf 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -147,7 +147,7 @@ static void rx_cpu_realize(DeviceState *dev, Error **errp)
     RXCPUClass *rcc = RX_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index c074e12ba2d..641ea96c8ea 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -249,7 +249,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    cpu_exec_realizefn(cs, &err);
+    cpu_common_realize(cs, &err);
     if (err != NULL) {
         goto out;
     }
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 763424695c6..ad2ec28c1b7 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -250,7 +250,7 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
     SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 13ebb122a38..1bc14b586bb 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -892,7 +892,7 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     /* Default NaN value: sign bit clear, all frac bits set */
     set_float_default_nan_pattern(0b01111111, &env->fp_status);
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 472c24ae32d..96e2817dee7 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -99,7 +99,7 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUTriCoreState *env = &cpu->env;
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 2015a4e3d0d..7c25b9ab707 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -257,7 +257,7 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
     xtensa_irq_init(&XTENSA_CPU(dev)->env);
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
-- 
2.53.0


