Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A995CC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiHX-0001WG-8N; Fri, 03 Jul 2026 14:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHT-0001Ov-Ao
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHP-0002Bg-Ce
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiIAl683668
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IeIVqfyiCml9jzA9XTGftIehzVboREdHFkrVcUeQF4o=; b=bFwX+lJsyljMqr0A
 usElowFY9/FP/9T9OeDA0D8qOlwLb24jZQXGCDznb1s1aTTWKzmceh/o5R6sS/QO
 ZxLGEW9cfACeEG6GdgPVdLHt4ZX18JBvJQMlcrk3LzzlsYStTC30wYMzEKoQb/h7
 BIvTnqyxalqcTiBrvV4hyCBBOyNEtX9ZwbXEpsePjUDGI7B3/ZZvy/aoPkIF0ogU
 ZzrKZb1unuUqAoqxbz3ke5usceSkytTvbmu0LZFt+is8EZWC52j8CLVWAhH+D2oY
 marbb2T5m8Kx4mfYokVe6hOoUkeGRHp+0x0pUfdB1O4EMJXwb1x+HA6dedXavn9f
 L3DXFA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5bfhg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174a23afcbso7563501cf.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101971; x=1783706771; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IeIVqfyiCml9jzA9XTGftIehzVboREdHFkrVcUeQF4o=;
 b=ZiwmiyfhKS92CH3vDfTBMgAGCF++ThBIQ9q2qeRYjSuiG+b7iA57k2kvDS6TX7adYb
 jN20b4trO28KEATo7o8Uiu8imUhctoAX0D2WZDTKswoDMVQznLedzNxo0sAFmlnOxXDH
 ZnrOqpHY42if8dv/WWFEI2AJvHiS7yg/vKMGHIIIA0NrqaSNDl8HgCCIbWQwMrc6n/V4
 XiqborCV/IT6vk4kQUlu2BXugnBNVkcxVX9djauWJf8y/qUUIfRkRvoEXYD1KRMVqdi0
 VcRIv7YgVhTsYlpuhnEYUAFzFKvxayECpKtar7DPWjOaWTkU8z+8023Kaayd0P6er1Co
 lGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101971; x=1783706771;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IeIVqfyiCml9jzA9XTGftIehzVboREdHFkrVcUeQF4o=;
 b=FBjoVgzjzhAR3pIUajKbpthV62dqCMXxmaokPwJ/w3/bUYiUEeW/eVI3EuI63bbG4+
 u+KNYgGx6R5AqeZhlDIYyk9LOLDQwJyEFqmPqssQL7qXd0yzEqlC04CxfaERMJZsWANX
 2E9MwxoizitSIr2qew3hdyeUX/GXnn7Kl6C2DZgu8IZcrJf40hIdq+twE0kaItT3xkie
 gwwbu/LVnTYAMMb/ugJbbjLSfeKiKsq6b8KAQpEHBBtCzBd/RFuzVA0KLyf9HBiErEot
 uhW+JXopCAx6q15FaB+uzwsMCfxycGtJNFtamx+QB4cLL7uv4gJk9tVhmEGnua25UX9j
 I9xw==
X-Gm-Message-State: AOJu0YzwXcltTmo12ivXUykJsby6GL7uC10AANXGeoWrDd7Lk2cGafnz
 kf30bnRIoBYQOhwvkCGoty01dglIlC0iNbMKogVe6TWCwk+I+we3JArY0hlUZgIaCc2OJ9omzuP
 6SFstkO63EQf4Qlj8+T+Bevsyx3ijT0wx+f/Pi/QhPdkd8OkrsdkCSeIv0wQOCFNU+g==
X-Gm-Gg: AfdE7cn26Bk6WiUD6kLDXRkUd+dhB7qMjKzhxk7ANfVt/gJdVfK7QSvLhzzBWa+Nkvn
 8rjwOyOQWvue3NbreRje9+AswiaMQTsZs9F2VMIh9vzpFphneg/JfhF6esash0SRHheov5ko+0j
 WhpXjSabPX+kK3MDG+aSIRypQDE8IFhhDiHpI5X6XLlQ0OA1X6NtoDtTfzY1KlZrgQvf+0zs23G
 3b15w9VfupdXlDxMMYy160D+zFYcApdSttuyHKI2E2H3j2XrADR8pTpU5GibXfq7qR2mPorcYVh
 k6PhiM0/R1GAJLzOnxJq6w9cKER6fF/5VrZ0YCMtGV3o4Wz8HD94TOvSnMahdf4XRqPL8eoMtp4
 kxKZ4OsGQR8+4Cwj8m6RA7lDDEedHVKARMB96RptNK0o/Wg==
X-Received: by 2002:a05:622a:590e:b0:517:6d82:9aec with SMTP id
 d75a77b69052e-51c4c0971dcmr10268021cf.0.1783101970753; 
 Fri, 03 Jul 2026 11:06:10 -0700 (PDT)
X-Received: by 2002:a05:622a:590e:b0:517:6d82:9aec with SMTP id
 d75a77b69052e-51c4c0971dcmr10267311cf.0.1783101970208; 
 Fri, 03 Jul 2026 11:06:10 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:09 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 09/24] target/riscv: remove csr.h from kvm-cpu.c
Date: Fri,  3 Jul 2026 15:05:21 -0300
Message-ID: <20260703180538.3346781-10-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX+r3k81NkuLxd
 20AwVKVeA1upd65iike8zEa3dFRHHZciY5fXqyZ7pALo7CBBkdr6jtJ18J+aqPifzzSoJy94NMs
 y0H5Q9HPeUU9Q6FzmaRySYoM2A4VLr0=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a47fa14 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=KJWeSTv_TiI39BqBT3cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: KA9FqUY3Wp9Gybq5o5KVtPy9L_1s3dJ1
X-Proofpoint-GUID: KA9FqUY3Wp9Gybq5o5KVtPy9L_1s3dJ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX0Ck6Wh064jr1
 mM26Jwqh6jcv0OlMQveODa+hB3fAR+huO+0InYc5Y34Y8HjRBKs1SiWop8fIGGSILNOAWXLqwhs
 V6lFmEVpPPCr7fXCdgxuzBjFp5jHOdvj+20LwUGXU3FJCF6ndh1M3Dd2qgyuL3rX5pSGp1ohJNo
 cvjGjUBMDNgn4BlhFZpg230rgzcZu8o/b6If7uCRc46fpnOjKak17Av6vC1NHwcl0Lr72RKgZT+
 0DdggtT1vqc/ESF1sKdtE90VLCU+BJ5IXOTonzL6JAzHYxRZxHwo9dRbXsyTFrz/lCpl3DEWt9d
 VfGePSMfJppSDlGNgwZc1bIHlAAr/vkNZaVAvrjI+HSxoxHe8WhiEQ0Y61OCKFwdMSmCfHxPKlL
 jxQlmeSzfgZQUQtiOw+t1Jna9lskb3bCsKgnEv5uWvG9U8lF0ZiJZ4HiH6KxymgqR8I1ZM//CnZ
 uWm/gCMr7CWZKAApaIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Move riscv_new_csr_seed from csr.c to cpu.c since this function is
shared with KVM.  With that we can remove the csr.h from kvm-cpu.c.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 30 ++++++++++++++++++++++++++++++
 target/riscv/cpu.h         |  3 ++-
 target/riscv/csr.h         |  3 ---
 target/riscv/kvm/kvm-cpu.c |  1 -
 target/riscv/tcg/csr.c     | 29 -----------------------------
 5 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a2887adf16..ba75c0de39 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -21,6 +21,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/ctype.h"
 #include "qemu/log.h"
+#include "qemu/guest-random.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
 #include "target/riscv/csr.h"
@@ -556,6 +557,35 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
 }
 #endif
 
+/* Used by csr.c and the KVM driver */
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask)
+{
+    uint16_t random_v;
+    Error *random_e = NULL;
+    int random_r;
+    target_ulong rval;
+
+    random_r = qemu_guest_getrandom(&random_v, 2, &random_e);
+    if (unlikely(random_r < 0)) {
+        /*
+         * Failed, for unknown reasons in the crypto subsystem.
+         * The best we can do is log the reason and return a
+         * failure indication to the guest.  There is no reason
+         * we know to expect the failure to be transitory, so
+         * indicate DEAD to avoid having the guest spin on WAIT.
+         */
+        qemu_log_mask(LOG_UNIMP, "%s: Crypto failure: %s",
+                      __func__, error_get_pretty(random_e));
+        error_free(random_e);
+        rval = SEED_OPST_DEAD;
+    } else {
+        rval = random_v | SEED_OPST_ES16;
+    }
+
+    return rval;
+}
+
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 18fbd4edb6..a8c7e21bec 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -970,7 +970,8 @@ void riscv_add_satp_mode_properties(Object *obj);
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
-
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
 const char *priv_spec_to_str(int priv_version);
diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index 66ec9546ed..53ba3b4a4d 100644
--- a/target/riscv/csr.h
+++ b/target/riscv/csr.h
@@ -12,9 +12,6 @@
 #include "exec/target_long.h"
 #include "cpu_bits.h"
 
-target_ulong riscv_new_csr_seed(target_ulong new_value,
-                                target_ulong write_mask);
-
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
                           target_ulong *ret_value);
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 39d48a9db4..dcdaf7f2b3 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -31,7 +31,6 @@
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
 #include "trace.h"
 #include "accel/accel-cpu-target.h"
 #include "hw/pci/pci.h"
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 36d12b6a51..9c7e9d0e4b 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -29,7 +29,6 @@
 #include "exec/icount.h"
 #include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/getpc.h"
-#include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include "tcg/insn-start-words.h"
 #include "internals.h"
@@ -5572,34 +5571,6 @@ static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
 #endif
 
 /* Crypto Extension */
-target_ulong riscv_new_csr_seed(target_ulong new_value,
-                                target_ulong write_mask)
-{
-    uint16_t random_v;
-    Error *random_e = NULL;
-    int random_r;
-    target_ulong rval;
-
-    random_r = qemu_guest_getrandom(&random_v, 2, &random_e);
-    if (unlikely(random_r < 0)) {
-        /*
-         * Failed, for unknown reasons in the crypto subsystem.
-         * The best we can do is log the reason and return a
-         * failure indication to the guest.  There is no reason
-         * we know to expect the failure to be transitory, so
-         * indicate DEAD to avoid having the guest spin on WAIT.
-         */
-        qemu_log_mask(LOG_UNIMP, "%s: Crypto failure: %s",
-                      __func__, error_get_pretty(random_e));
-        error_free(random_e);
-        rval = SEED_OPST_DEAD;
-    } else {
-        rval = random_v | SEED_OPST_ES16;
-    }
-
-    return rval;
-}
-
 static RISCVException rmw_seed(CPURISCVState *env, int csrno,
                                target_ulong *ret_value,
                                target_ulong new_value,
-- 
2.43.0


