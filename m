Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB86606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P29OeYw6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XeTVAytW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCxM-00043e-H2; Wed, 25 Nov 2026 08:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCwL-0002vl-Bf
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:40 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCwI-0000j6-Md
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:37 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mOr1555534
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PyhQpuwM0IP
 ykhWF7SgHdLBgTu76xd17WxT3KhGnN9I=; b=P29OeYw66ZB8y9HyGaA5CtufH/k
 6qJr65HuzUxhP6Sw2NAql9zLMtK5UfPdYcDn7wiHHcDA25MwspQiMsU7YcICsj4o
 rnBcY8pq0fqJNpvka17ydLTIhczeP+z9N5Ov+CMkt0iWJReRMGsaJ7OFsSZLc87y
 gg6ZC422Qkn3v4MnDK8N/dj8IkBZzlhKTg3M5iCt6GHik11SamlOb+Cm118PMO1z
 H1SyLrjeAAL4jXjjfUjKwhqKVFGpVThbZcsQ6IcxawES/oFNH/l7uyTUxo1LJRVR
 v1krEGe+A2K/G+GQqvHMYSonaXEBPl778LxWgQPQAnSZdezSJNlsgmP5CuA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnryn5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:21:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9212b76b1f9so74913996d6.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795612883; x=1796217683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PyhQpuwM0IPykhWF7SgHdLBgTu76xd17WxT3KhGnN9I=;
 b=XeTVAytWNMe9sC2Bjuz+IsqGcTlqvoTKvaXGAdoWapbYyPJRCDd8ygr2PDBAvzZ7eA
 4wKP1Rb76c+wpMrAuTTDfdyDohTuum/Cn4ExgF5xPkAD04T5AXvU9ou3hh8A3BFsjFAK
 2f2yIllmBtVfhRcHPDKCvJEFA93TOtJpuEizmlK/xfwuJglqfW6I1SGtwPyCDQyoLWXX
 Rn4c2+3+zua+801ul0/uuRBNGiplg6/cAEscMa+K5cxSgx8ThjRob3c0RMuQ3uFd4L3O
 krulVyTHLQN4fn6ltlhXWkw7ucy0zrYELDnlZu8JkFDN7+NDOZk/fhclgx5Yzk15/91B
 tiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795612883; x=1796217683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PyhQpuwM0IPykhWF7SgHdLBgTu76xd17WxT3KhGnN9I=;
 b=V49Autja8jrMk1JAiZ4ebW7SaErFRtlcS27lxpBcm+fb1+kdQ/MNUxIDZ5xKaJGNTa
 89GUaA2PLRVC9He0qW3kmyJzkzsovHJRmm5woCkzGy3CYa4/R0SEcbC90/xwoRKUuZCi
 39gDWlHPE2gQ1rMyahFky0mHt9wwpDZqKY+vBsdq6gHmgdY/bBtZnNKs3ZwMqEIOkD2B
 k+Px2bPdWrqK93UAzUOdiBCv5o+TpjK6ocrWLFviiyZEISP0eA1Ywt1HfL52mf1n2kRO
 Bkuv1R2qz9ZsxBG+FiWz4kJk547QK1SirjLsy4ADjuBPrGmUVpBeZz/ETfA6TQKd0CPu
 b/XQ==
X-Gm-Message-State: APuU4Z8LFfb6X9or2KvXlzwHaII6DxAXxxmGAknVLD0tXyRClltOXuYm
 r0lUwFyaaCmp3t1W/mmpnpikjjSavGKbb7Nm10rMfqHRhIXc9WSq0lXtTjBDrweOwTZ/ruHpeUb
 fIxHPO/WK2liaNR/XhgSut55AS421KI38vXtCWiZwVCo1NOC0uiChc/yHckraKfnRFQ==
X-Gm-Gg: AZFdTZdf+OGx6Qijam71Hhjx89/BWLgMn+Mwr6mhxbQMD5WIaaA+XP/oHNO/WuKVZVV
 IoQ6LsOVU6JQVteNUfb+7bFWDhOmMDIWCLk8MHcC224HGuymJPVhbvs6sTI3oiQIPgcRvCNC4/M
 mUkKLzDHuzjmfAlXKr9lWy1KA4KYe+pW3bYAcQYldDAZcxfTVcfPYGbliscZEG3xhsl8TwrrArV
 SWiA0E+by4Y6x94Uz9UxfYqDBuERE2a6w2UPuiDtSgdInFlAW2FSlheI/DOZMzyNpzixahjiyHS
 lPB7giFAOa7g2bYYR/OudVDFwzVR8ImOghHTska0ROn2gSgeE/JDJLuXytyMCY4cTg9y+kmGSVN
 NJgUaUVJ6Kvzat0SFR9ld+P9BzetDdEuqxFzK0MxR0MywXLmItme8ghG5pFUi5Qx2no6q2JR6pu
 jNfbyY1ga+uQ==
X-Received: by 2002:a05:6214:5686:b0:91f:2e32:b536 with SMTP id
 6a1803df08f44-92134a9bea1mr230743336d6.32.1795612882595; 
 Wed, 25 Nov 2026 05:21:22 -0800 (PST)
X-Received: by 2002:a05:6214:5686:b0:91f:2e32:b536 with SMTP id
 6a1803df08f44-92134a9bea1mr230742806d6.32.1795612881804; 
 Wed, 25 Nov 2026 05:21:21 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm160836946d6.34.2026.11.25.05.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:21:21 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 14/15] target/riscv/tcg: refactor mseccfg_csr_write()
Date: Wed, 25 Nov 2026 10:20:13 -0300
Message-ID: <20261125132015.229955-15-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
References: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfX505OD/I2ytq/
 RT5PEcGDAE9imh9zQ75uZJiF23cECOnDjT6hzNF0iQ5nMUSMl3W2HXL2qFREi2eNgQwu3OrLPsu
 GEMkzsLMpJ6Nh/Txeo1nqFXBJps2kDgXK2q4B1B71LktOITjpKKTKuLhP4uYWs+5hR8CTeofs3h
 go7f2O3DCY02kvtqw9GpwuHZcqlr9xBETu14shvSshDPtVueIUKqTDJKFUc+dZVhgqNJZ1AmeaK
 R5YGqx5MOTXAGli2GMn2nxN6rRrlQdSJmZv5Z9kP8bLt+KLJY7PFy0cHUROTccjhD0H2o4tKhiB
 Gle4SskDq85he/C1OqnHkp3G/zeF41juXKKImv/beHWiSAubR9eeWdiLZ2GqVG3a2gKtikb5LWL
 NozDZJcz8IBNJ7ESKboEy1kiJf91o9b5QW3XbE7MjdyO1aKkU6/qI2vKS2UM6YO7Kdr4/znBJKG
 uA6aZ7V/r7UhiKUf1Mw==
X-Proofpoint-ORIG-GUID: MjwcWCpas2tD0axQF1HSSbdNlbZsS04m
X-Proofpoint-GUID: MjwcWCpas2tD0axQF1HSSbdNlbZsS04m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfXx45FIZqm3Sor
 ub8Bj40Pbk3WGr+HO/rxuDPpj58TCtePOQA5Tkm8RIqpwap7D1/A0Es+U7+1gsFnwcnStXby3U8
 UfgznO2jJffMQVj9zFW6D8IIu/vcYRw=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b06e0d3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=JqaN9GvD_FBDy7hsbu0A:9 a=xzXrWhTA25ICRMUC:21
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250053
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We have a couple of Gitlab issues that lands on mseccfg_csr_write().
Both are related to bits that are WPRI/read-only being written, bits
that are supposed to behave as usual being considered sticky and so on.

mseccfg_csr_write() is in a weird shape.  We have a 'mask' variable that in
theory is a write mask like write_mstatus() and others use, but then
we're clearing 'val' directly using 'mask' in certain conditions.  The
sticky bits check is also using 'mask', which includes bits that aren't
sticky, and then all sorts of fun and games happen (see [1]).  And in
the end we're doing 'env->mseccfg = val' and writing whatever is left in
'val',  which can and will include WPRI bits.

The function was introduced by 2582a95c3c46 and it already had problems
with the WPRI bits being written since there were no write mask concept in
it.  Commit 33ca99a111b4 introduced a 'mask' variable that isn't exactly
a write mask, or even a clear mask, and it has sticky bits mixed in
middle.

I tried to do minimal code changes to address these bugs, but with the
current structure it can't be done without making things even weirder.
So I decided to rewrite it as follows:

- 'mask' is now a classic write mask variable, like write_mstatus() and
  others use;
- a new 'sticky_bits_mask' variable is added.  Sticky bits aren't
  handled the same as regular bits and we're now making a clear
  distinction between them;
- env->mseccfg is calculated by writing the writable mask and
  IORing the sticky bits;
- there are no bit clearing of 'val' if there's no smepmp present.

These changes are enough to fix GL4818.  Tests for a second gitlab bug
(GL4680) are added as support for the refactory.  We'll solve the latter
in the next patch.

Fixes: 2582a95c3c46 ("target/riscv: Add ePMP CSR access functions")
Fixes: 33ca99a111b4 ("target/riscv: Add new CSR fields for S{sn, mn, m}pm extensions as part of Zjpm v1.0")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4818
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/pmp.c                        | 61 ++++++++++++------
 tests/tcg/riscv32/system/meson.build          | 20 ++++++
 tests/tcg/riscv32/test-mseccfg-bits-1.S       | 56 +++++++++++++++++
 tests/tcg/riscv32/test-mseccfg-bits-2.S       | 56 +++++++++++++++++
 tests/tcg/riscv32/test-mseccfg-bits-3.S       | 56 +++++++++++++++++
 tests/tcg/riscv32/test-mseccfg-bits-4.S       | 55 ++++++++++++++++
 tests/tcg/riscv64/system/meson.build          | 10 +++
 tests/tcg/riscv64/test-mseccfg-pmm-clear.S    | 63 +++++++++++++++++++
 tests/tcg/riscv64/test-mseccfg-pmm-reserved.S | 63 +++++++++++++++++++
 9 files changed, 421 insertions(+), 19 deletions(-)
 create mode 100644 tests/tcg/riscv32/test-mseccfg-bits-1.S
 create mode 100644 tests/tcg/riscv32/test-mseccfg-bits-2.S
 create mode 100644 tests/tcg/riscv32/test-mseccfg-bits-3.S
 create mode 100644 tests/tcg/riscv32/test-mseccfg-bits-4.S
 create mode 100644 tests/tcg/riscv64/test-mseccfg-pmm-clear.S
 create mode 100644 tests/tcg/riscv64/test-mseccfg-pmm-reserved.S

diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 17ec81f028..5ea52d55a8 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -687,9 +687,11 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
  */
 void mseccfg_csr_write(CPURISCVState *env, uint64_t val)
 {
-    int i;
-    uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
-    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
+    uint64_t sticky_bits_mask = 0;
+    uint64_t mask = 0;
+
+    trace_mseccfg_csr_write(env->mhartid, val);
+
     /* Update PMM field only if the value is valid according to Zjpm v1.0 */
     if (riscv_cpu_cfg(env)->ext_smmpm &&
         riscv_cpu_mxl(env) == MXL_RV64 &&
@@ -697,30 +699,51 @@ void mseccfg_csr_write(CPURISCVState *env, uint64_t val)
         mask |= MSECCFG_PMM;
     }
 
-    trace_mseccfg_csr_write(env->mhartid, val);
+    if (riscv_cpu_cfg(env)->ext_smepmp) {
+        bool rlb_writable = true;
+
+        /*
+         * RLB cannot be enabled if it's already 0 and
+         * if any regions are locked.
+         */
+        if (!MSECCFG_RLB_ISSET(env)) {
+            uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
-    /* RLB cannot be enabled if it's already 0 and if any regions are locked */
-    if (!MSECCFG_RLB_ISSET(env)) {
-        for (i = 0; i < pmp_regions; i++) {
-            if (pmp_is_locked(env, i)) {
-                val &= ~MSECCFG_RLB;
-                break;
+            for (int i = 0; i < pmp_regions; i++) {
+                if (pmp_is_locked(env, i)) {
+                    rlb_writable = false;
+                    break;
+                }
             }
         }
-    }
 
-    if (riscv_cpu_cfg(env)->ext_smepmp) {
-        /* Sticky bits */
-        val |= (env->mseccfg & mask);
-        if ((val ^ env->mseccfg) & mask) {
+        if (rlb_writable) {
+            mask |= MSECCFG_RLB;
+        }
+
+        sticky_bits_mask |= MSECCFG_MMWP | MSECCFG_MML;
+        val |= (env->mseccfg & sticky_bits_mask);
+
+        if ((val ^ env->mseccfg) & sticky_bits_mask) {
             tlb_flush(env_cpu(env));
         }
-    } else {
-        mask |= MSECCFG_RLB;
-        val &= ~(mask);
     }
 
-    env->mseccfg = val;
+    if (riscv_cpu_cfg(env)->ext_zicfilp) {
+        mask |= MSECCFG_MLPE;
+    }
+
+    if (riscv_cpu_cfg(env)->ext_zkr) {
+        if (riscv_has_ext(env, RVS)) {
+            mask |= MSECCFG_SSEED;
+        }
+
+        if (riscv_has_ext(env, RVU)) {
+            mask |= MSECCFG_USEED;
+        }
+    }
+
+    env->mseccfg = (env->mseccfg & ~mask) | (val & (mask | sticky_bits_mask));
 }
 
 /*
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
index 79ad7b89ac..44388af101 100644
--- a/tests/tcg/riscv32/system/meson.build
+++ b/tests/tcg/riscv32/system/meson.build
@@ -37,6 +37,26 @@ tests += {
     'cflags': cflags,
     'qemu_args': ['-cpu', 'max,smdbltrp=on', qemu_args],
   },
+
+  'test-mseccfg-bits-1.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'rv32,u=off,h=off,s=off,zkr=on,zicfilp=off', qemu_args],
+  },
+
+  'test-mseccfg-bits-2.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'rv32,smepmp=true,zkr=false,zicfilp=false', qemu_args],
+  },
+
+  'test-mseccfg-bits-3.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'rv32,zkr=false,zicfilp=true', qemu_args],
+  },
+
+  'test-mseccfg-bits-4.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'rv32,zkr=true', qemu_args],
+  },
 }
 
 if 'qemu-system-riscv32' in emulators
diff --git a/tests/tcg/riscv32/test-mseccfg-bits-1.S b/tests/tcg/riscv32/test-mseccfg-bits-1.S
new file mode 100644
index 0000000000..ffa88f5f2f
--- /dev/null
+++ b/tests/tcg/riscv32/test-mseccfg-bits-1.S
@@ -0,0 +1,56 @@
+/*
+ * Verify mseccfg bits USEED, SSEED, MLPE and WPRI.
+ *
+ * With "rv32,u=off,h=off,s=off,zkr=on,zicfilp=off" we expect no
+ * bits being written in mseccfg.
+ *
+ * Based on Gitlab 4680 testcase.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define CSR_MSECCFG 0x747
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	li	t0, -8		// all ones except bits 2:0
+	csrs	CSR_MSECCFG, t0	// mseccfg
+	csrr	t1, CSR_MSECCFG
+
+	/* WPRI fields are always read-only zero.  */
+	li	t2, 0xfffff8f8	// WPRI bits 31:11 and 7:3 (RV32 low half)
+	and	t3, t1, t2
+	bnez	t3, _fail
+
+	/*
+	 * USEED: read-only zero if not zkr or no U-mode.
+	 * SSEED: read-only zero if not zkr or no S-mode.
+	 * MLPE: read-only zero if no Zifilp present.
+	 */
+	srli	t3, t1, 8
+	andi	t3, t3, 7	// USEED, SSEED, MLPE -> bits 1, 2, 3
+	bnez	t3, _fail
+
+	j	_pass
+
+trap:
+	j	_fail
+
+_pass:
+	li	t0, 0x100000
+	li	t1, 0x5555	/* FINISHER_PASS */
+	sw	t1, 0(t0)
+	j	.
+
+_fail:
+	li	t0, 0x100000
+	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
+	sw	t1, 0(t0)
+	j	.
diff --git a/tests/tcg/riscv32/test-mseccfg-bits-2.S b/tests/tcg/riscv32/test-mseccfg-bits-2.S
new file mode 100644
index 0000000000..acc022784d
--- /dev/null
+++ b/tests/tcg/riscv32/test-mseccfg-bits-2.S
@@ -0,0 +1,56 @@
+/*
+ * Verify mseccfg bits USEED, SSEED, MLPE and WPRI.
+ *
+ * With "rv32,smepmp=true,zkr=false,zicfilp=false" we expect no bits
+ * being written in mseccfg.
+ *
+ * Based on Gitlab 4680 testcase.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define CSR_MSECCFG 0x747
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	li	t0, -8		// all ones except bits 2:0
+	csrs	CSR_MSECCFG, t0	// mseccfg
+	csrr	t1, CSR_MSECCFG
+
+	/* WPRI fields are always read-only zero.  */
+	li	t2, 0xfffff8f8	// WPRI bits 31:11 and 7:3 (RV32 low half)
+	and	t3, t1, t2
+	bnez	t3, _fail
+
+	/*
+	 * USEED: read-only zero if not zkr or no U-mode.
+	 * SSEED: read-only zero if not zkr or no S-mode.
+	 * MLPE: read-only zero if no Zifilp present.
+	 */
+	srli	t3, t1, 8
+	andi	t3, t3, 7	// USEED, SSEED, MLPE -> bits 1, 2, 3
+	bnez	t3, _fail
+
+	j	_pass
+
+trap:
+	j	_fail
+
+_pass:
+	li	t0, 0x100000
+	li	t1, 0x5555	/* FINISHER_PASS */
+	sw	t1, 0(t0)
+	j	.
+
+_fail:
+	li	t0, 0x100000
+	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
+	sw	t1, 0(t0)
+	j	.
diff --git a/tests/tcg/riscv32/test-mseccfg-bits-3.S b/tests/tcg/riscv32/test-mseccfg-bits-3.S
new file mode 100644
index 0000000000..2c0501bf96
--- /dev/null
+++ b/tests/tcg/riscv32/test-mseccfg-bits-3.S
@@ -0,0 +1,56 @@
+/*
+ * Verify mseccfg bits USEED, SSEED, MLPE and WPRI.
+ *
+ * with "rv32,zkr=false,zicfilp=true" only MLPE should be set.
+ *
+ * Based on Gitlab 4680 testcases.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define CSR_MSECCFG 0x747
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	li	t0, -8		// all ones except bits 2:0
+	csrs	CSR_MSECCFG, t0	// mseccfg
+	csrr	t1, CSR_MSECCFG
+
+	/* WPRI fields are always read-only zero.  */
+	li	t2, 0xfffff8f8	// WPRI bits 31:11 and 7:3 (RV32 low half)
+	and	t3, t1, t2
+	bnez	t3, _fail
+
+	/*
+	 * USEED: read-only zero if not zkr or no U-mode.
+	 * SSEED: read-only zero if not zkr or no S-mode.
+	 * MLPE: must be enabled since we have Zifilp present.
+	 */
+	srli	t3, t1, 8
+	andi	t3, t3, 7	// USEED, SSEED, MLPE -> bits 1, 2, 3
+	li	t2, 4
+	bne	t3, t2, _fail
+
+	j	_pass
+
+trap:
+	j	_fail
+
+_pass:
+	li	t0, 0x100000
+	li	t1, 0x5555	/* FINISHER_PASS */
+	sw	t1, 0(t0)
+	j	.
+
+_fail:
+	li	t0, 0x100000
+	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
+	sw	t1, 0(t0)
+	j	.
diff --git a/tests/tcg/riscv32/test-mseccfg-bits-4.S b/tests/tcg/riscv32/test-mseccfg-bits-4.S
new file mode 100644
index 0000000000..952c4bb964
--- /dev/null
+++ b/tests/tcg/riscv32/test-mseccfg-bits-4.S
@@ -0,0 +1,55 @@
+/*
+ * Verify mseccfg bits USEED, SSEED, MLPE and WPRI.
+ *
+ * with "rv32,zkr=true" we expect USEED and SSEED to be set.
+ *
+ * Based on Gitlab 4680 testcases.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define CSR_MSECCFG 0x747
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	li	t0, -8		// all ones except bits 2:0
+	csrs	CSR_MSECCFG, t0	// mseccfg
+	csrr	t1, CSR_MSECCFG
+
+	/* WPRI fields are always read-only zero.  */
+	li	t2, 0xfffff8f8	// WPRI bits 31:11 and 7:3 (RV32 low half)
+	and	t3, t1, t2
+	bnez	t3, _fail
+
+	/*
+	 * USEED and SSEED: present.
+	 * MLPE: read-only since we don't have Zifilp.
+	 */
+	srli	t3, t1, 8
+	andi	t3, t3, 7	// USEED, SSEED, MLPE -> bits 1, 2, 3
+	li	t2, 3
+	bne	t3, t2, _fail
+
+	j	_pass
+
+trap:
+	j	_fail
+
+_pass:
+	li	t0, 0x100000
+	li	t1, 0x5555	/* FINISHER_PASS */
+	sw	t1, 0(t0)
+	j	.
+
+_fail:
+	li	t0, 0x100000
+	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
+	sw	t1, 0(t0)
+	j	.
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index d91e28a4d2..c6968dc37a 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -166,6 +166,16 @@ tests += {
     'cflags': cflags,
     'qemu_args': ['-cpu', 'max', qemu_args],
   },
+
+  'test-mseccfg-pmm-clear.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
+
+  'test-mseccfg-pmm-reserved.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
 }
 
 if 'qemu-system-riscv64' in emulators
diff --git a/tests/tcg/riscv64/test-mseccfg-pmm-clear.S b/tests/tcg/riscv64/test-mseccfg-pmm-clear.S
new file mode 100644
index 0000000000..c03dbb01ff
--- /dev/null
+++ b/tests/tcg/riscv64/test-mseccfg-pmm-clear.S
@@ -0,0 +1,63 @@
+/*
+ * Test if mseccfg.PMM is cleared correctly.  From Gitlab 4818:
+ *
+ * "Smmpm: mseccfg.PMM (bits 33:32) is a WARL field whose legal
+ *  values are 00, 10 and 11.  Write 11, then clear it with csrc:
+ *  it must read 00 (00 is the reset value, so it is supported).
+ *  Pass (exit 0): PMM reads 00 after the clear."
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define CSR_MSECCFG 0x747
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	/* Write (11) to PMM (bits 33:32).  */
+	li	t0, 3
+	slli	t0, t0, 32
+	csrs	CSR_MSECCFG, t0
+
+	csrr	s0, CSR_MSECCFG
+
+	/* Clear PMM.  */
+	csrc	CSR_MSECCFG, t0
+
+	/* Read mseccfg again.  PMM must read 00.  */
+	csrr	s1, CSR_MSECCFG
+	srli	t1, s1, 32
+	andi	t1, t1, 3
+	snez	a0, t1
+
+	j	_exit
+
+trap:
+	# Any trap is a fail code 1
+	li	a0, 1
+
+# Exit code in a0
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
+.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
diff --git a/tests/tcg/riscv64/test-mseccfg-pmm-reserved.S b/tests/tcg/riscv64/test-mseccfg-pmm-reserved.S
new file mode 100644
index 0000000000..88764f24fb
--- /dev/null
+++ b/tests/tcg/riscv64/test-mseccfg-pmm-reserved.S
@@ -0,0 +1,63 @@
+/*
+ * Test if writing a reserved mseccfg.PMM value reads back a
+ * legal value. From Gitlab 4818:
+ *
+ * "Smmpm: write the reserved value 01 to mseccfg.PMM. It must
+ *  read back a legal value (00, 10 or 11),  and an M-mode load
+ *  must then work. Pass (exit 0)."
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define CSR_MSECCFG 0x747
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	li	t0, 1
+	slli	t0, t0, 32
+	csrs	CSR_MSECCFG, t0
+	csrr	s0, CSR_MSECCFG
+
+	srli	s1, s0, 32
+	andi	s1, s1, 3
+
+	li	t0, 1
+	beq	s1, t0, _fail	// 01 stored: fail
+
+	li	a0, 0
+	j	_exit
+
+_fail:
+	li	a0, 1
+	j	_exit
+
+trap:
+	# Any trap is a fail code 1
+	li	a0, 1
+
+# Exit code in a0
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
+.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.43.0


