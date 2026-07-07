Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1427EC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAMR-000607-2P; Tue, 07 Jul 2026 14:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAM7-0005T8-4P
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAM4-0006Tk-Nt
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:14 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTQ6j003131
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q2z1hY3rQKQjFwS9f9L+Ux5n2oQB5lboTjombKC6sJk=; b=QrN3pB+zseNqFggE
 NbKrJqE1JXrQFXWeFZXcNcRWYiYH+/NjHTltGZwpUhp4+nhUryi+1Ju0Non7yFKx
 DQsMPkNlFgRq1+t7fiyckN/KkTW86xCL2D6blWj7h01jzb3Utfj1soeiaQMAT8cw
 7hQksxQnoHRl/MKqUk8chrgCb8VG5qUy1Fvk8ARqWntBEDMRI/mWvxz4k7nKfS8h
 epb7GHhkElRGm3GUUcNhQY84A8/LAYEv8mdZo9XpBdCAHjxDZjKdvqgi+8erb/P/
 /VK/rC9xbMtVJwMdnSX38dE/Ww91xAvjXui0ENJ/WDU35CrRznP+JZ+7miGwBolB
 m4yxvQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0j4fj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:17:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso78452061cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448230; x=1784053030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q2z1hY3rQKQjFwS9f9L+Ux5n2oQB5lboTjombKC6sJk=;
 b=heJN0c4rfNvTRHoIo04L5+Cty8deTLzj3mOlbTrKYIGa9d/QlUXlwgSdB57fJwqHuv
 o4Ke/QD8HODoq1Ku6OoO7+n0pK5SdrIqTmtZaWz5MJ/F3Xk0tEGXWd3mWORAjSVU/4Tu
 iRm2e/eqynQxzqAqA4GiwPK6GmF4xrkWB6sPemIrJD5w62UTuM5wgxkKuTspztPQMCzC
 z3KbuguaoSphlxfD91hs87feAzclAUm3opa/TVK541XWR0dd352Ip3OVIrUon7Lac4ru
 dRjKLEBmNheccp23YU1ojwRUegS7SwPlyIPVIw24m43T62zG39ZQiI+fJToCZdPNS1In
 gqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448230; x=1784053030;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q2z1hY3rQKQjFwS9f9L+Ux5n2oQB5lboTjombKC6sJk=;
 b=YTccsDOGiAKLEIeadwSFfktWvbOkbVmLHhYVDI1FNkiuZbAz5VFigJ663Sdjq5v/Qm
 XFvt1LwL53Y4CWQTaqxunh3aKfsr2WQAM8QRX/x7kA+OthCFXaYKQEvUQUscjyMMqNbu
 kkcZMNkV8rjB+iKwAmAy+SMXPZqIj7NbCXKxQYkIToY5ZVTpSqkF9cQHUcZCxwhXDdc6
 WsZHafVsyCrcwsXpMY0Fl24nzVgdyrZg8CrNJ4LdYA36rF4Zzb8aKSr6klAiR80lTYrd
 87cB7QLDwgOShwlRnd5OJY9kGrV2ehK7SzmMCBciYgJhaXqXLhrMWopqd5DxpY1ZPxcS
 LPSg==
X-Gm-Message-State: AOJu0YxYA2HKzp8jn/YD7W2ABY9GL5rvdV90LW+9q2yjr0Si1jUbmM/P
 zOEEWOuAYmkODBaW4DsdfpnsaYEvJpJ8Jo1mZK8qLZdRUUGOwgTcY6ag2diTcQn4fBcxTcXGD6X
 7dgWr3/cb7EUOyJ/2kfW8jDFavzN9oUclyZI5TLTkUqmjgLCVGaKqVO+ME7EEVBJYpQ==
X-Gm-Gg: AfdE7clKlWzW5vMVi1zscr8k6zeHIcD/zQannpzWAj7ugEbVnLzBs2M72eqWz7UERRR
 vIfjyYeC9sZ+KgFFf+vgEaLGN5Of9GgRdumNG/b3C/YieJ0wBkSQq0p8ZIub8JvylOaKgly6Uu3
 lvSscrBnhyafPNMYNe4Rvz43z4MtxbrxvB3wCpHhhpVbKXdG40jBKV9ntxRRM5qxqLO14Wf+VG6
 KXFxmnV0bv7WHvGQiZSSsA0CSu802gZpdctiwaCtuGfGfPpxIRj8hU/NKiHONHv6GMd7FwSyj0D
 e9SMtHPHlBAsOm1HVFWQgDhdyAkobDJMHqTJJCK00VBpZfv5zQgfcOt8v5kwAf063i2vcksM/Mi
 ZIvpQE86d1HBdwmGDdz4BqUGLD/G9silk0NllMpHLeonQKfGxvHEfOImMZKpWpVSgZ7ZA
X-Received: by 2002:a05:622a:1f96:b0:516:ed02:c85d with SMTP id
 d75a77b69052e-51c747c33admr66604961cf.3.1783448223725; 
 Tue, 07 Jul 2026 11:17:03 -0700 (PDT)
X-Received: by 2002:a05:622a:1f96:b0:516:ed02:c85d with SMTP id
 d75a77b69052e-51c747c33admr66604411cf.3.1783448222978; 
 Tue, 07 Jul 2026 11:17:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0faee30sm61925005e9.10.2026.07.07.11.17.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:17:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/23] target/mips: add Octeon CHORD and LLM COP2 helpers
Date: Tue,  7 Jul 2026 20:15:18 +0200
Message-ID: <20260707181529.60191-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZWEs-NS_M67b8Cy6-DomTAY0l_xohHUm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX1txDaDRr2XSs
 CGeA6FX9pK00qmDEgUJItNTK9yZEuHqg7Ts4FOisLz+POVUsxm8EViKBLEWnm+8VcGNRH1Nb3Ps
 s647wyH4iAq6rPpHnEHAV/E974zkBXc=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4d42a6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=pXy8MzuH-9m_VKUK6bUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: ZWEs-NS_M67b8Cy6-DomTAY0l_xohHUm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX2qH3RB6uWnbt
 PIFY5Q8mUaxh/cEcZ9uRTjwTIl5c3NGnJvFeMr6sn/XlyOJbnPbcPqz9T4zZRTsVvS1LwTaxbs9
 jMf8pcMDptINp+yf2SXKzTs+bnVqWoUzo3oPXYYOrKn1HjKosxLKsApvi87RZci6cbEF8Jpugf/
 0OUbTwfVmGMuuhOpKN8g7IvMDkiMKGn6ZRtQ0dPWZksQVlaiiNATg+DeZ4UkwpmVWo1TVosF2AS
 KdHl1dzxaMXouoVjux1VL2hGpmRZDJW4B0KAmCEuKUcAzCICQD9hjB5P7G+ya4tW860XR7e4aFp
 vdGfoN9ziaf7kKovL3oeoyDc5nLnxKW4AzTlE2MYBuytBDFfTsppgn3pAf0E9l1Fhey9UpPJYb0
 spmUZawqmVtXS9fKG70U8LN5ypWTwRMfQkv3O45vcT69ftE1k0df20Ej3uarDqHmes7ykRFp+/9
 RnEUqRqp2eReHgzyjww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070179
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

From: James Hilliard <james.hilliard1@gmail.com>

Add the Octeon CHORD hardware register access path and the LLM 36-bit
and 64-bit read and write windows. Model both CHORD access forms,
including the RDHWR $30 path and the legacy DMFC2 alias.

Implement sparse backing storage for the two LLM sets so user-mode code
can save, restore, and probe the architectural state without allocating a
full hardware-sized backing array.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-13-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/cpu.h               |  5 +++
 target/mips/helper.h            |  9 ++++
 target/mips/internal.h          |  3 ++
 target/mips/cpu.c               | 67 +++++++++++++++++++++++++++++
 target/mips/system/machine.c    | 67 +++++++++++++++++++++++++++++
 target/mips/tcg/octeon_crypto.c | 76 +++++++++++++++++++++++++++++++++
 target/mips/tcg/op_helper.c     |  6 +++
 target/mips/tcg/translate.c     |  8 ++++
 8 files changed, 241 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3df71adf9bd..319147a948c 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -11,6 +11,7 @@
 #include "fpu/softfloat-types.h"
 #include "hw/core/clock.h"
 #include "mips-defs.h"
+#include "qemu/qtree.h"
 
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
 
@@ -559,6 +560,10 @@ typedef struct MIPSOcteonCryptoState {
     uint16_t gfm_poly;
     uint8_t aes_keylen;
     uint8_t crc_len;
+    uint64_t chord;
+    uint64_t llm_data[2];
+    QTree *llm36;
+    QTree *llm64;
 } MIPSOcteonCryptoState;
 
 typedef struct CPUArchState {
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 834f2d07690..e210e406f9c 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -74,6 +74,14 @@ DEF_HELPER_2(octeon_cp2_mt_hsh_startmd5, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_hsh_startsha256, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_hsh_startsha, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_hsh_startsha512, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_read_addr0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_write_addr0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_read64_addr0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_write64_addr0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_read_addr1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_write_addr1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_read64_addr1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_write64_addr1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
@@ -245,6 +253,7 @@ DEF_HELPER_1(rdhwr_cc, tl, env)
 DEF_HELPER_1(rdhwr_ccres, tl, env)
 DEF_HELPER_1(rdhwr_performance, tl, env)
 DEF_HELPER_1(rdhwr_xnp, tl, env)
+DEF_HELPER_1(rdhwr_chord, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
diff --git a/target/mips/internal.h b/target/mips/internal.h
index aab77b1b257..c5c286872eb 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -93,6 +93,9 @@ extern const int mips_defs_number;
 
 int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+QTree *mips_octeon_llm_tree_new(void);
+uint64_t mips_octeon_llm_load(QTree *tree, uint64_t addr);
+void mips_octeon_llm_store(QTree **treep, uint64_t addr, uint64_t value);
 
 #define USEG_LIMIT      ((target_ulong)(int32_t)0x7FFFFFFFUL)
 #define KSEG0_BASE      ((target_ulong)(int32_t)0x80000000UL)
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index fccc7a711d3..b223b767c9c 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -26,6 +26,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "qemu/module.h"
+#include "qemu/qtree.h"
 #include "system/qtest.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
@@ -181,6 +182,57 @@ static bool mips_cpu_has_work(CPUState *cs)
 
 #include "cpu-defs.c.inc"
 
+static gint mips_octeon_u64_tree_compare(gconstpointer a, gconstpointer b,
+                                         gpointer user_data)
+{
+    uint64_t av = *(const uint64_t *)a;
+    uint64_t bv = *(const uint64_t *)b;
+
+    return (av > bv) - (av < bv);
+}
+
+QTree *mips_octeon_llm_tree_new(void)
+{
+    return q_tree_new_full(mips_octeon_u64_tree_compare,
+                           NULL, g_free, g_free);
+}
+
+uint64_t mips_octeon_llm_load(QTree *tree, uint64_t addr)
+{
+    uint64_t key = addr;
+    uint64_t *value = tree ? q_tree_lookup(tree, &key) : NULL;
+
+    return value ? *value : 0;
+}
+
+void mips_octeon_llm_store(QTree **treep, uint64_t addr, uint64_t value)
+{
+    uint64_t *key;
+    uint64_t *stored;
+
+    if (!*treep) {
+        *treep = mips_octeon_llm_tree_new();
+    }
+
+    key = g_new(uint64_t, 1);
+    stored = g_new(uint64_t, 1);
+    *key = addr;
+    *stored = value;
+    q_tree_replace(*treep, key, stored);
+}
+
+static void mips_octeon_destroy_llm_state(MIPSOcteonCryptoState *crypto)
+{
+    if (crypto->llm36) {
+        q_tree_destroy(crypto->llm36);
+        crypto->llm36 = NULL;
+    }
+    if (crypto->llm64) {
+        q_tree_destroy(crypto->llm64);
+        crypto->llm64 = NULL;
+    }
+}
+
 static void mips_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -192,6 +244,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
         mcc->parent_phases.hold(obj, type);
     }
 
+    mips_octeon_destroy_llm_state(&env->octeon_crypto);
     memset(env, 0, offsetof(CPUMIPSState, end_reset_fields));
 
     /* Reset registers to their default values */
@@ -246,6 +299,9 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     env->active_fpu.fcr31 = env->cpu_model->CP1_fcr31;
     env->msair = env->cpu_model->MSAIR;
     env->insn_flags = env->cpu_model->insn_flags;
+    if (env->insn_flags & INSN_OCTEON) {
+        env->octeon_crypto.chord = 1;
+    }
 
 #if defined(CONFIG_USER_ONLY)
     env->CP0_Status = (MIPS_HFLAG_UM << CP0St_KSU);
@@ -262,6 +318,9 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
      * hardware registers.
      */
     env->CP0_HWREna |= 0x0000000F;
+    if (env->insn_flags & INSN_OCTEON) {
+        env->CP0_HWREna |= 0x40000000u;
+    }
     if (env->CP0_Config1 & (1 << CP0C1_FP)) {
         env->CP0_Status |= (1 << CP0St_CU1);
     }
@@ -417,6 +476,13 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
 #endif
 }
 
+static void mips_cpu_finalize(Object *obj)
+{
+    MIPSCPU *cpu = MIPS_CPU(obj);
+
+    mips_octeon_destroy_llm_state(&cpu->env.octeon_crypto);
+}
+
 static void mips_cpu_disas_set_info(const CPUState *cs, disassemble_info *info)
 {
     const MIPSCPU *cpu = MIPS_CPU(cs);
@@ -645,6 +711,7 @@ static const TypeInfo mips_cpu_type_info = {
     .instance_size = sizeof(MIPSCPU),
     .instance_align = __alignof(MIPSCPU),
     .instance_init = mips_cpu_initfn,
+    .instance_finalize = mips_cpu_finalize,
     .abstract = true,
     .class_size = sizeof(MIPSCPUClass),
     .class_init = mips_cpu_class_init,
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 77f576a25b1..bd1e4002cfd 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -131,6 +131,69 @@ static const VMStateDescription vmstate_octeon_multiplier_tc = {
     }
 };
 
+typedef struct OcteonLLMTreePutData {
+    QEMUFile *f;
+} OcteonLLMTreePutData;
+
+static gboolean put_octeon_llm_tree_entry(gpointer key, gpointer value,
+                                          gpointer user_data)
+{
+    OcteonLLMTreePutData *data = user_data;
+
+    qemu_put_be64(data->f, *(uint64_t *)key);
+    qemu_put_be64(data->f, *(uint64_t *)value);
+    return false;
+}
+
+static int put_octeon_llm_tree(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field, JSONWriter *vmdesc)
+{
+    QTree *tree = *(QTree **)pv;
+    OcteonLLMTreePutData data = { .f = f };
+    uint32_t nnodes = tree ? q_tree_nnodes(tree) : 0;
+
+    qemu_put_be32(f, nnodes);
+    if (tree) {
+        q_tree_foreach(tree, put_octeon_llm_tree_entry, &data);
+    }
+
+    return 0;
+}
+
+static int get_octeon_llm_tree(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field)
+{
+    QTree **treep = pv;
+    uint32_t nnodes = qemu_get_be32(f);
+
+    if (*treep) {
+        q_tree_destroy(*treep);
+    }
+    *treep = mips_octeon_llm_tree_new();
+
+    for (uint32_t i = 0; i < nnodes; i++) {
+        uint64_t addr = qemu_get_be64(f);
+        uint64_t value = qemu_get_be64(f);
+
+        mips_octeon_llm_store(treep, addr, value);
+    }
+
+    return 0;
+}
+
+static const VMStateInfo vmstate_info_octeon_llm_tree = {
+    .name = "octeon_llm_tree",
+    .get = get_octeon_llm_tree,
+    .put = put_octeon_llm_tree,
+};
+
+#define VMSTATE_OCTEON_LLM_TREE(_f, _s) {                         \
+    .name = stringify(_f),                                        \
+    .version_id = 1,                                              \
+    .info = &vmstate_info_octeon_llm_tree,                        \
+    .offset = vmstate_offset_pointer(_s, _f, QTree),              \
+}
+
 /* MVP state */
 
 static const VMStateDescription vmstate_mvp = {
@@ -301,6 +364,10 @@ static const VMStateDescription mips_vmstate_octeon_crypto = {
         VMSTATE_UINT16(env.octeon_crypto.gfm_poly, MIPSCPU),
         VMSTATE_UINT8(env.octeon_crypto.aes_keylen, MIPSCPU),
         VMSTATE_UINT8(env.octeon_crypto.crc_len, MIPSCPU),
+        VMSTATE_UINT64(env.octeon_crypto.chord, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.llm_data, MIPSCPU, 2),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm36, MIPSCPU),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm64, MIPSCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 82ad355d56f..b24533e03df 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -16,6 +16,42 @@
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 
+#define OCTEON_LLM_NARROW_MASK ((1ULL << 36) - 1)
+
+static uint64_t octeon_llm_pack_narrow(uint64_t value)
+{
+    value &= OCTEON_LLM_NARROW_MASK;
+    return value | ((uint64_t)(ctpop64(value) & 1) << 36);
+}
+
+static void octeon_llm_read(MIPSOcteonCryptoState *crypto, unsigned int set,
+                            uint64_t addr, bool wide)
+{
+    uint64_t value;
+
+    if (wide) {
+        value = mips_octeon_llm_load(crypto->llm64, addr);
+    } else {
+        value = octeon_llm_pack_narrow(
+            mips_octeon_llm_load(crypto->llm36, addr));
+    }
+
+    crypto->llm_data[set] = value;
+}
+
+static void octeon_llm_write(MIPSOcteonCryptoState *crypto, unsigned int set,
+                             uint64_t addr, bool wide)
+{
+    uint64_t value = crypto->llm_data[set];
+
+    if (wide) {
+        mips_octeon_llm_store(&crypto->llm64, addr, value);
+    } else {
+        mips_octeon_llm_store(&crypto->llm36, addr,
+                              value & OCTEON_LLM_NARROW_MASK);
+    }
+}
+
 static uint32_t octeon_crc_reflect32_by_byte(uint32_t v)
 {
     return bswap32(revbit32(v));
@@ -2225,3 +2261,43 @@ void helper_octeon_cp2_mt_crc_write_var_reflect(CPUMIPSState *env,
 
     octeon_crc_update_reflect(crypto, value, MIN(8U, crypto->crc_len & 0xf));
 }
+
+void helper_octeon_cp2_mt_llm_read_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 0, value, false);
+}
+
+void helper_octeon_cp2_mt_llm_write_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 0, value, false);
+}
+
+void helper_octeon_cp2_mt_llm_read64_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 0, value, true);
+}
+
+void helper_octeon_cp2_mt_llm_write64_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 0, value, true);
+}
+
+void helper_octeon_cp2_mt_llm_read_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 1, value, false);
+}
+
+void helper_octeon_cp2_mt_llm_write_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 1, value, false);
+}
+
+void helper_octeon_cp2_mt_llm_read64_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 1, value, true);
+}
+
+void helper_octeon_cp2_mt_llm_write64_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 1, value, true);
+}
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 4502ae2b5be..3e586e3049e 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -255,6 +255,12 @@ target_ulong helper_rdhwr_xnp(CPUMIPSState *env)
     return (env->CP0_Config5 >> CP0C5_XNP) & 1;
 }
 
+target_ulong helper_rdhwr_chord(CPUMIPSState *env)
+{
+    check_hwrena(env, 30, GETPC());
+    return env->octeon_crypto.chord;
+}
+
 void helper_pmon(CPUMIPSState *env, int function)
 {
     function /= 2;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 123d2c89c3d..1f449328825 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -10925,6 +10925,14 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         }
         break;
 #endif
+    case 30:
+        if (!(ctx->insn_flags & INSN_OCTEON)) {
+            gen_reserved_instruction(ctx);
+            break;
+        }
+        gen_helper_rdhwr_chord(t0, tcg_env);
+        gen_store_gpr(t0, rt);
+        break;
     default:            /* Invalid */
         MIPS_INVAL("rdhwr");
         gen_reserved_instruction(ctx);
-- 
2.53.0


