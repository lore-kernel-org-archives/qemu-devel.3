Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066DDCDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkNj-0000d2-UP; Mon, 22 Jun 2026 15:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNi-0000cE-IF
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNg-0001q1-Gk
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:30 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVxlR1010525
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4HJO01tRdn5
 3xAdLjKeS39dTf9kvVhP9MmTvHhoHe8Y=; b=NOpYjdbBBFlIbUW2rbz4CKYmpCq
 y4ZuJn3LXsheihTS6CMmhD0GfXbFfgrNSTc964WmXm0LrjXMzVdsu7LEMnfMqTCQ
 /sFgl6CfPz6CTkWK/N74NqIc+PDqcCagunle64J3uI4y8Wo39jdD037sfTk6SOLf
 Yro50ei55YNQ3/hMGHHeQU+prF9EsVsn2ABJu+3WnjpapYGAmYuywsy6G4VDec6O
 vUf7O42LMuqzSQtLDKEp9MgnUDQPpVoKmExAOVFfnbcqN7PE7s6JR4TT9Hj9Hjsh
 tA0E880IqiITUCGH5BQilDnRwhmlP0w+zX1EPg7oW0LVNsagof03R5iKdlg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3a0sypr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9157f453a27so753355585a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156736; x=1782761536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HJO01tRdn53xAdLjKeS39dTf9kvVhP9MmTvHhoHe8Y=;
 b=WyOFEuTmufdKqRv/ERHWKv9Hj/jgQL9b59zT2DhuOVS6Lc5IwEkRp6d4U/CzeXM5OX
 84lnNC+KZw4GTKE4tppskOphQaLPdPI14Flnrgkug5WHCccb0Wl4C+T6T8gm6WRa4vN0
 tpQ0/drTfrr969PPAtNrQ8SGbFHCYJmQ8l/2qjbMC7SYLnEQuEorcFEwO/YpwM4w02n/
 WI+gKcy8dRef7lqW11Y/HUdQEdFB9Sz41REegKqoWSh2McPtE8UJvmLFJ1fSddnf9rm/
 qWkOifz07jrEz++yEZ9q4sxkg84a/SX35ubHOFi//8EHgnQ49mTTfFFsNU1AfthxuAih
 ykAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156736; x=1782761536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4HJO01tRdn53xAdLjKeS39dTf9kvVhP9MmTvHhoHe8Y=;
 b=a+1wp7oeaXgX36gamRCgy0IcogJhH68BJXZjoKu513hrmblx4AgkjQcnbjtyIEdxnH
 3ay5LlCCtkDAFkX5yYf68dpvaxgJAMuUK1xoJeDeHh4ExR34io6tfK/U1ikON9xD6mkF
 FJUABiIZtWoGYEjcptWMKst7AFkSK4gtskoEQf4KUWj1ZC4kh6uIRl2pzouJji++3x0A
 xE4bC3G1zIj7JWkCxIjJ7X1rzl7k0ig6luXvK+8Y0JH/5GXpSlDPChQpzW6+ktogjg8B
 Eecwhsd/bWGDIpSfTuRYX9Opnfp/KQRgTLHb9CCXJijs4sCVQEHpzrPPY5ynUOaP34ew
 kj0g==
X-Gm-Message-State: AOJu0Yyx4xlc/YIDOiCEuYMSeGdq6dXS9jsf8kOrLgrQjGBSo6ahuPpJ
 eB0/9w9IRyjnN4yrESwNFDbSRdn9Etu4pd3cukivsIfzOo5A4X/0T49Syw7npugnvLNxrT+z0Ih
 gPREIo1wKV58cgDxBH/1gF5rbz/qwjmksUWPUPPaX3oGF3RXHbWF5mD3xtasprWSBzA==
X-Gm-Gg: AfdE7cnm5i+5lZ+9paTya/xxtvxwmRIEIi/YLqC2y/6E48aRW1uj6etniaiLJFvU3O4
 0t308l/XWTOC5OTveYFq70gbVkIYaL/Wsfj4qcsvd74VV8uW+DFrwSC56Oki0qPCDcLemEyc1U1
 HPxz21/EuX5bHb/jPbVJDHw0zqRxLGRIVu2YTevV8b0wZ6v7z9/lDkMbbVDwo3lfULfdaRbLFaJ
 RcQE6wnIKEjFQWAY2i20TAp0DqXCWBsGFI9RUceR/p0CulnMpDjFKxpiOlR5lPuzVnNpSzGnuOT
 W95iEc6q3va+uX6Fq0RDb2F/2n+qhPkdTApsh7nl5/8nSq+QMu6oopBS+/wtutEYyiskavenf28
 pYscKN70louP+7CDPlV9ntrMAtUjfxsAGtw216DJT4g2+TQ==
X-Received: by 2002:a05:620a:4046:b0:920:56af:cef2 with SMTP id
 af79cd13be357-920d1cea613mr2390769085a.25.1782156735732; 
 Mon, 22 Jun 2026 12:32:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4046:b0:920:56af:cef2 with SMTP id
 af79cd13be357-920d1cea613mr2390761485a.25.1782156735015; 
 Mon, 22 Jun 2026 12:32:15 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:14 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 08/24] target/riscv: remove csr.h from kvm-cpu.c
Date: Mon, 22 Jun 2026 16:31:24 -0300
Message-ID: <20260622193141.1449724-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX9PHgp0AyQLaP
 aMTiMKDMQHdvsacc19dH2ig+pgisDcrqfykpoOuPWjWp1KeTzn2R6dlAumkuKw7TnXj2TOwShyR
 33myKifvghvoa2zAhSuhcdAnG/g1GFw=
X-Proofpoint-GUID: Ym4KnlELTIpIJX4SMj57qI3xRgE-drpa
X-Authority-Analysis: v=2.4 cv=UJ7t2ify c=1 sm=1 tr=0 ts=6a398dc1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=iaHOtbHYuYo96Khm3VgA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfXxzjRWpkb37FP
 AKaT/mARYDS7YbnW4FPFkCvFLL2T7/wo7WRctGMX3Z/tajnDupoU2BFkW+nUV2bg25j0HSMff22
 3UQyQianJlN/i6m1BV2kSYFxH0MQuMUDVSLhpGrKavpWLrpe7Ret55GFdL6i6CeOLlaN2Egx3Se
 3uNNk1ZgRQi2z+gauQajWMSalWA81jGxWqynr3AujkYFf6qbsLksMFSZUUXp52L72YGDf2wm7NT
 +D2F82YYkH4CjGH3r0tsul0eU06bDt8sh23u3eTWRh5d1fkWsbOS0jN3GPYy9b0hk+BAetTVgkY
 xwT60WUk6z/zvlN4U9wGO2XHHlD0PHwCV2m46kr6osZR4DExjndlrLcAhrOp4VV4Y9+Ihs3SrAf
 jz9FfqTS8D/amsspyZKrsQja9qIgqGSjUeaiXW5o8maVruxU4jU+JyG+8m6nQbJsLHbD6FMyS/0
 HcmQ0FaQyeCGe28Pw2Q==
X-Proofpoint-ORIG-GUID: Ym4KnlELTIpIJX4SMj57qI3xRgE-drpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220189
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
---
 target/riscv/cpu.c         | 30 ++++++++++++++++++++++++++++++
 target/riscv/cpu.h         |  3 ++-
 target/riscv/csr.h         |  3 ---
 target/riscv/kvm/kvm-cpu.c |  1 -
 target/riscv/tcg/csr.c     | 29 -----------------------------
 5 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f999042178..8fe524be21 100644
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
index f0c78c1474..4fc82d2477 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -971,7 +971,8 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
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


