Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5985CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9I-0007VU-VR; Tue, 23 Jun 2026 20:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9C-0007ST-SU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9A-0003Cm-Jn
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK04Lc1191161
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F0Isirr0MlsSsKy41gDn9B8vpEig/F5As+5NVwCdPXU=; b=RnDuMRzyOlPS0Bfv
 O5JpzpIN1Xxnk7jznjIbND7sVJLvqnbChCSe7tl2VtV6dJZF1BWaNb9YICa5vO+W
 GmErMSNZOP2TrURlqu58FrCdPs3khQzemd+VoIiDWM2PwckxYFIvb3DG5CNXh0RT
 bqRS4T2JoUKV8BfiTmVYh2ucGhUVHJ4b30fWh3G9bpwIecqNSR2HKLp6JjdyxMly
 G1bO6pyVtfzsEuGa0W7hN9J67u3kD971XP+SECJ0FD1jlcfuvXv+EPZoK3BklUEX
 xnoke7s/YXMwVjYBXRsu/8erozCosPM7xBnbGhFXSuT5EqcRJuu7Zeu7XZcYp0mh
 VDlC9Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eytvh2evp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:05 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8db6a7471baso10844626d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259625; x=1782864425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0Isirr0MlsSsKy41gDn9B8vpEig/F5As+5NVwCdPXU=;
 b=HAsf9tD9PFZiL1sLyAcmxOZlkH8BUheTnxDWLEcyoVI9ecwLzAqH1VTy2rH56d1EQL
 QNduFl4IRSEv9CKNyyQjBHobdaOFdd0Hnw9x65eclr9Wnk3Zx8vNPzAUvLLrUKKOQQiV
 zpevYtuavKBYtlYpYhvCLNT5HMVObychf4Wu9g0XOsv7apTm3fLFqXrQq5MAW/DC1dat
 cfytducqdtsnJsuxUPaW40My60bYxI4uIc2V4Gl7+2LBBUePdqOhGqv7zc/Qo0V+sSJI
 PYxBQwfY4I5GIzPOgCVckIzwHdcbzt5BjpbvyjbBMZ8uhh04AyBUWBMZwEbOssnT92TZ
 DmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259625; x=1782864425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F0Isirr0MlsSsKy41gDn9B8vpEig/F5As+5NVwCdPXU=;
 b=jHeM/CMio0ZP7f5mP8wy66EcehSfmOuTqjZ4Kkl51tds1nFxyg/dT3sPWXsNnnAM0j
 F3244AMI+LiMHRQ5gqPdRqpEh6ZFWmvdE82gBgFrHpfkil57G2VOtv0Tb/+U4MdHjf/j
 KT+Zds+Gg3UmlHa7ApvDjmjZqODheLpEQtK3W6gp8QNty6neGWwuRIS3HdAodpwHmjhi
 mL005mi1tYfu4Z5YkrnLmt14CTPN7FOaHJyoeEAUYj3celFtOkF8qqn07jignWUsoEGl
 1jJ607RbF4JDlA3VyPMAo3NzCdiURY3aeIZNKVQLPadVo3r6x4KQR15jTvDUbnXN/FH+
 hU7A==
X-Gm-Message-State: AOJu0YyC9Tav+upEa8ZQcsogUA78K1encDN5Nf/F4/Kn7zIu+b5DoBPE
 ltnud9nryaDe47aquvpSvec+Ox1VmR1Z5exsUNcFoF9VmztdvXP60Ilqj8VOMkoKGNYQltQYPPl
 A7oGbwV+Ku+49aIDFlgeikObkgHAbPZUHDnT4uHRfWN1ytPLoLbImxOFcULiqrRI97A==
X-Gm-Gg: AfdE7cm25EgpoumQltQ6RE6K1ybBuX2jSDqH7Lv70NE0a2LSalbpO/HUWE43nV3gbZK
 r1jwQ5xe81QbVzVYPZ417ZCX0wcK62RK2XqzsGNi+c1Wj+tMLEnOdKKn+WVIV11WSHB3ssXQKUc
 dGAwtiTxo4gWXWQlW782YRxQssR3BkKDJlNGg8TeqGXwZFaxe6bWdSQzm+uy3LdCooyrN0zlxF8
 f/e7Rjd961ZuQEvOKYPfJ/ckWIrbmAhMqZFo/v9S9qz81iDuBYazRDXEPSqektY8HFnmrXA2k7M
 xZs1hepComAknPlV4UspTyJPllSFNwGCnHBpxsYklo0qvAoNFWz0siQe69bEm5PUSV/76TlQ6V4
 0WU4lqFBaU29Sc2d9o3OwY5XXN7W2l7yNnVnLfr0XBOPK2Q==
X-Received: by 2002:a05:6214:2429:b0:8cc:2a92:48e4 with SMTP id
 6a1803df08f44-8e535cfea4amr22373856d6.32.1782259624980; 
 Tue, 23 Jun 2026 17:07:04 -0700 (PDT)
X-Received: by 2002:a05:6214:2429:b0:8cc:2a92:48e4 with SMTP id
 6a1803df08f44-8e535cfea4amr22373366d6.32.1782259624543; 
 Tue, 23 Jun 2026 17:07:04 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:04 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 08/24] target/riscv: remove csr.h from kvm-cpu.c
Date: Tue, 23 Jun 2026 21:06:15 -0300
Message-ID: <20260624000632.2149359-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXzrI8RwkLAom5
 ga0LU2RT5w0zWQlpQVYU1GDoPttERbOIGbR4i6SJA2tCSAfRMxROwQ1FZ9CmO6l2xt3ffa7AXZT
 tnN+rHFJZ2Gs27G4PE9bPewj9WZxC52RGaAH9l7LkaYtm8xEOpNWGJKndJ32kAjfkq0yIFzsPG0
 MPLDmEOqF92l/f3p8tPa3b0kvuBkd3+R982hLzCZfyBy18/LQRwdGrUZrVzVTKnPXvGN/BXOpiP
 gl5/3WHpWkoYk9WkIhIGREVFHvZT5uswJ+NcjLrAfVlzFUDbuRYYMZ8o2I6hCjrXfDg4UV0biaI
 1vxuNgR9xGQS+NqiziyYNKHb2lQh51E6n3HS/Fc+ABZtHhUB9CAzytUgHDHU9ZD4OMnwIGLgSai
 PZSckRX31QMvzLA4eCARSLAlgmJr6NO55LM0zwyy+Ld+WE9P7Gt95gYqtNS1wTNeEhMjK+zKOxQ
 dRi02JhCTBp+VuImWCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXz0qL6emN0vKF
 +8oD3Gv/WZ9FWjn7Y7GiHjvd+sr14yaV1EJIIsAgGdEtzH7EX8xVJ9Z4Ss7RWK5V+wGD3y9+L2m
 DP+mfEt2mirxlsRpeHGXAbmg6+DBEIw=
X-Proofpoint-GUID: dmn-EkQe61vxui_N8cAb9wm716Sp5Qz_
X-Authority-Analysis: v=2.4 cv=AJDhMgPs c=1 sm=1 tr=0 ts=6a3b1fa9 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6BMwLXxoa7YWeqrhhxoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: dmn-EkQe61vxui_N8cAb9wm716Sp5Qz_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230199
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

Move riscv_new_csr_seed from csr.c to cpu.c since this function is
shared with KVM.  With that we can remove the csr.h from kvm-cpu.c.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.c         | 30 ++++++++++++++++++++++++++++++
 target/riscv/cpu.h         |  3 ++-
 target/riscv/csr.h         |  3 ---
 target/riscv/kvm/kvm-cpu.c |  1 -
 target/riscv/tcg/csr.c     | 29 -----------------------------
 5 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fe47ae64c9..5d44f993e4 100644
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
@@ -536,6 +537,35 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
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
index 70b8729bd7..c0e9098728 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -972,7 +972,8 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
-
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
 const char *priv_spec_to_str(int priv_version);
diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index c791260f83..73d874ee98 100644
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
index b460860409..d447204721 100644
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
@@ -5577,34 +5576,6 @@ static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
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


