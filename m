Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EE6C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7G9x-0002a6-4o; Thu, 17 Sep 2026 13:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x7G9u-0002VX-0Z
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:44:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x7G9k-0001bE-2P
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:44:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH5fDg2170994
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GkCRYrqoeka
 52Y8rKYAZUDFWuolJT/VyJY3a3J+f6c4=; b=VI7HoPEvdCqZzjKU5SYHrJEU+pU
 anozfCOpdiUnJF9I0113LvCMnOj1UeUkw6dmMFdDVuqCiBc97gX+7fIzO0Wlnr4t
 /39cs88Jvv21eXb+7UFAuHjq+bEjDhjkT82h9pGmx4XDKqXvTkDTgtaNHqb3ca/4
 BgCUHQzLwmJtni4bSgayNpOIcmEv7/BdQlf2g+UKO6W59Tx8tsgh6zsfx2lsjBYY
 EgLzlQ/eS/cfVR5KmhXMsNdlplCGmBybuFh43FPYoHk5j5X4kNVi9Koh6NY//uj9
 u7jpApD7XHgXoHGuNyMpGnorWegQrZhDPS+QsFQsBRyI1jZLCxpaOi75iZw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grk97rj7m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-912351b220bso25470636d6.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789667056; x=1790271856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GkCRYrqoeka52Y8rKYAZUDFWuolJT/VyJY3a3J+f6c4=;
 b=A+AyS3/buGoPOdvC+rCPQN/neZYXX92B9hv5Y/eDB/iCDc5N6j8zy1v8r2ZKV+duTD
 e0Ue0ienwqejsvxjhXLy2giB55lgGn155jfL93Wi1vPkDSHYj5hyRWbrwkXtE0+3RJ/M
 ZDWeRnpM3lT+VJD8iHoLwzoMKxE0k/+UwUex7dmPNuZyiwQGli/1+WPS+jD74F/lGDj2
 jq+2COZx4TYWA2EHKfAos9H7gQPGZ5x1Pw5uDcLhXsSxjwQE4DTH3mozyhr+sr6dhhYu
 euFlGm+f6Ucp8QeZNqKnzUjCy3b3hSP87b/We3dwycwJs9IFD5YsbV4tW0sVflBuzmXE
 sDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789667056; x=1790271856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GkCRYrqoeka52Y8rKYAZUDFWuolJT/VyJY3a3J+f6c4=;
 b=PHc+2W+TuZLxdTadDumt1+KJW/SGbFAIa06QGcEb+CygjtNMu2Q66z5qr5AXuhO/QO
 waurFHWTUmbp+hDWCF0YrmUAJC7Uo6H6dyn9N2dsPovX0rkybqSrw7EeuPpottrcIeJ1
 oUMKz+rSk38SA5ogQ4Djq2HY4gMvq/rCeSyGNSqhlVHTcTXN4woI0wFlc1Ie+ctBmL6K
 4CRmSLAKoD1XnUJ4Zp37iNEEtYlQyPOnf1s1Mw3mvsblLzNF9/JaGLHt/9x0pz2akV4G
 z5piCnsZU4gBDQVflDhiNhT1Mq1RBS4VguHvlIKEXxhDranDFsu2tCPqMnGXIV5q7F7N
 mbLQ==
X-Gm-Message-State: AFuF++nJnJFWwtj1Zfaa9qfqNyEa96KRTlXzW9I80O/kvk2Dx1O0f9/w
 lpAm3I1wujQf1/qmUKmSLpuLYcShpnBoBT1NpvKkAZZ5S4BLESkl+ao0gZcwdHV69+f9fqccM09
 kj7yqzRVKEYoPMDwqTW4TQkbkdyiFuqSgmjxU4nsRs4XPuOZCaifj4amwBb/r1vrc8A==
X-Gm-Gg: AYBFou1SY7sMhdK8owYmm1DoleCzWWBnmiVvO9iO/vSRhVCuiehrCefVy360kk/dr+O
 AJgvjD19qrG30tVv0eL4A+IcYnsR9AilIiyNPPFhoem0hmEH2UsiSlxxqhSrhh+OdagfPJU1S76
 ej9hoUAZe1x0Xar0ktHtZ81ZCiAphfu/xcBGPWyv8Oq/0iNpXbB00mByfdoggLr2sjSKo32E60A
 QxQf8nOa5K0Har/+O4paiDlCLUEVVnVHFdoYObaiTElagV75gZ/sfpfHIoq4vzEXcmpzhPA6QYP
 xiXEvWlKci7J61YK0OV2DWCvy1agZVUu+NZlTAjuATPd2M5A/4f6RZum7xFlcx8DsuKVK3s0hof
 jcapLpcxJrXmyvpVStVqiWeLadlTXy8cgIu6iosY=
X-Received: by 2002:a05:6214:20e1:b0:910:3923:cc73 with SMTP id
 6a1803df08f44-9125240c2dfmr11076216d6.28.1789667055873; 
 Thu, 17 Sep 2026 10:44:15 -0700 (PDT)
X-Received: by 2002:a05:6214:20e1:b0:910:3923:cc73 with SMTP id
 6a1803df08f44-9125240c2dfmr11075886d6.28.1789667055452; 
 Thu, 17 Sep 2026 10:44:15 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.170])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252c56d73sm3118136d6.13.2026.09.17.10.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:44:14 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Icenowy Zheng <uwu@icenowy.me>,
 Matheus Ferst <matheus.ferst@eldorado.org.br>,
 Sunil V L <sunilvl@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v12 2/5] target/riscv: add riscv-server-ref CPU
Date: Thu, 17 Sep 2026 14:44:01 -0300
Message-ID: <20260917174405.3471736-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
References: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LOzz05W9 c=1 sm=1 tr=0 ts=6aac26f1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=arNgJ3JLhM/z8Vk/iMOFgQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=V1jnuoLLAAAA:20
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=PXcuKL70AAAA:8 a=FRSEYCzRAAAA:8
 a=zLUtPzHEVTZWnbMtJKMA:9 a=OIgjcC2v60KrkQgK7BGD:22 a=xVlTc564ipvMDusKsbsT:22
 a=1qLaeP4TCVy2vqIEy19U:22 a=H4N_Y-AU75W7NKDNhZlT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1MyBTYWx0ZWRfX9buwyi0TNMs2
 wDh41DSaBKDG+PfpslGGEuZ2za1G1S/M33HrKAwnd+Eo+DUIv6K5U3SvYHzrFk7BFq1bfLeXRm+
 rp/hwQRCu9wPsvqxds4nS86zsphy3Wws1uZQuSA9mFm6e6FDaZsqUZtfiIBaVedo7H0xtiRp3qp
 8RCyICKjpXCygS9lSWgsbcPe7gnR8EwGYj7VUSNlP08knFJC6wt7ZV3geN6uo3vifsYi7Te65uf
 ucFeGFOvtAISN3vN6JJfxtO5b/EGtwC9IXDcp7G4O3OKu7jWGBful80Mc9NiOJOgEZy8KltGZ2Z
 uAT2BbYRydKG/YbIc39rRqFa099RqpdFLMVmPcZ6O7oxHJhrG1K7FBTyELL7PI1XmJGzR1XnrTv
 EuKdO0kP5kRxZkSQYbExmEJg6sA5hvjTeYlaiqridXtot8P0ALDlMOfFBXXFx4Sk+Vx1lpsQXw/
 ouMHUJX9At+ja92kUqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1MyBTYWx0ZWRfX8Gf97UZYzrJO
 yM6GsoCzXnQhDGwOcbT/IrGcFofLQn9QSUlcv9wV52hLw0Z5ivF4CqKQAEZqTm+pNOWcqh6M/Hz
 xkFdgMM7lu9F0ATAUUHCwOpLIJ6QIWA=
X-Proofpoint-ORIG-GUID: 3H6wFkGvIT45iaJlBuVDGgpxW5ZxYa-Q
X-Proofpoint-GUID: 3H6wFkGvIT45iaJlBuVDGgpxW5ZxYa-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170253
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

The harts requirements of RISC-V server platform [1] require RVA23 ISA
profile support and others.

We're going for a profile-based implementation, instead of a regular CPU
that can inherit RVA23, to allow future CPUs to use it internally as a
starting base for their own extension sets.  There's also a new
'rvserver-ref-1.0' flag that can be used to set the extensions in the
command line for other CPUs, which can be used for testing/debugging
purposes.

Note that for all intents and purposes "riscv-server-ref" is a regular
CPU and no, we're not trying to set a precedent of calling the riscv
server platform spec a profile.

[1] defines in rule SEE_020 that we must support at least 11 debug
triggers (4 for insn address, 4 for insn load/store, 1 for icount,
one for int, one for excp).  We're going for the minimum.  If more
triggers are needed users can set any trigger amount (N <= 1024)
with:

-cpu riscv-server-ref,num-triggers=N

[1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc

Suggested-by: Icenowy Zheng <uwu@icenowy.me>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1a28f1369c..61234842e3 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -42,6 +42,7 @@
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
+#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 41e52431ed..336f596915 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2425,11 +2425,37 @@ static RISCVCPUProfile RVA23S64 = {
     }
 };
 
+/*
+ * This riscv-server-ref entry isn't a profile per se but its
+ * CPU definition can be modelled as a profile that extends
+ * RVA23, with additional things on top of it, and allowing
+ * future CPUs to derive from it via
+ * ".profile = &RVServerRef1_0;".
+ */
+static RISCVCPUProfile RVServerRef1_0 = {
+    .s_parent = &RVA23S64,
+    .name = "riscv-server-ref-1.0",
+    .satp_mode = VM_1_10_SV48,
+    .priv_spec = PRIV_VERSION_1_13_0,
+    .ext_offsets = {
+        CPU_CFG_OFFSET(ext_zkr),
+        CPU_CFG_OFFSET(ext_sdext),
+        CPU_CFG_OFFSET(ext_sdtrig),
+        CPU_CFG_OFFSET(ext_ssaia),
+        CPU_CFG_OFFSET(ext_ssccfg),
+        /* ssstrict is always enabled for PRIV_VER_1_12+ */
+
+        RISCV_PROFILE_EXT_LIST_END
+    }
+};
+
+
 RISCVCPUProfile *riscv_profiles[] = {
     &RVA22U64,
     &RVA22S64,
     &RVA23U64,
     &RVA23S64,
+    &RVServerRef1_0,
     NULL,
 };
 
@@ -3767,6 +3793,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
+        .profile = &RVServerRef1_0,
+        .misa_mxl_max = MXL_RV64,
+        .cfg.max_satp_mode = VM_1_10_SV57,
+        .cfg.pmu_mask = MAKE_64BIT_MASK(3, 6),
+        .num_triggers = 11,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.43.0


