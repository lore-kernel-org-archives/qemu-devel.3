Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68069606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KCNeQKwI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J1/BwM1e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRpr-0005cl-M1; Thu, 29 Oct 2026 11:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRpV-0005Gx-K5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:14:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRpT-0002zo-3a
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:14:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCe2Oa1176948
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ktOeY/JZlF6kNtycIZiL7JgIZNxaouon3Do+WObFDo0=; b=KCNeQKwICRb7LUZd
 tGA4ecBKqZ035MO+2hOks90StvjszQBlqCrCAfLK6QXzABwS67wpL84/aaw1j3TF
 Vy6LPnZMzDEoG1bgFyZR7BjHu2hsDrFOhdgjO7Nt24nUJ1vWHUF+KC08jH52phM2
 t6zn1IdSnBInFH6J5tq05GxF0N6q0xMiSJDKR7axZ1ULgnMIn9PgETAVu7qcBIB+
 AFBxFsalzsrIqMPCFk9J8dcIhGHFL/hA1PdqE9OKTD/4HPxG/v5vtY6WgIH+GES4
 QmxcE8h53yRzGEJdtQDO93ooT77eEM50XuBCOLt1n0Lt30K/9D6W+tNh684RGDvk
 d9mXyA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a213bj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:14:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1e62510cso538926585a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793286849; x=1793891649; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ktOeY/JZlF6kNtycIZiL7JgIZNxaouon3Do+WObFDo0=;
 b=J1/BwM1eaHOhhUqRC6riavNGontH/LBpnvziJI6WDXYj1Tz2BFkEeqq+MX3IfEbOD3
 ltEbiFd56xLXN7fnGsMbuXDHUSYUx9f9fawOH71X16LEuN6vluQczQBmDczoqD/LbWp7
 lwDsV1l73Cf6+n1GaRHyplGMwnkZDkNZbPrLwxoPa0DnTR6qbO36NryCeXI+OZXo4W2M
 ipR/KT+8Xz2UEu9YOG1+vxTocTg179O2/bx/xYK4KyDgXDuBiCsAgd9SJkfnjBqnpsYD
 WpnsslOwrCuxvNgBr1bPXs+hDFjJWowFD0t6pTJuYWhRXophtQ+BYZhnOWMaUJ7bgqZR
 BEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286849; x=1793891649;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ktOeY/JZlF6kNtycIZiL7JgIZNxaouon3Do+WObFDo0=;
 b=EgOgLzPt4g0DZVyBCj3CBJwi5rtz2QeRwNDuLGmRUoFdFTS4zqDu8+IF07xFruUho/
 6NOtoqacHr3DFwSCG8rFCp+7UrvouEj0JkQE6p7EL6qyHTWGsO5v+iIMRt7qZu8xcHDn
 K+5LtfcfY9VLf7g0n6/2l+sBSFEi7NHLC9b0abF2ov7c6bMOmAT64g1vUoRHvbRTSWh9
 solXVQckAd+yZwayz4drxJQzWL9pZwx3Cj9YQTQuCwNxH0zdtFHAz/V/MKCgWwk4CpTV
 KIPDbv28kk1rYbs1OV3lsSP3RjygRs9cBocYjrU8CNIWhBGfXrhs1tEGmTYp5nhUNGgY
 y34A==
X-Gm-Message-State: AFq9FYKeJoFuaatC9cMgTu9vOYsvkfXmZ6XGIOTBFqlYrOZzVvwh1aZR
 yKGmeUnA4f1C8iKuU/1SEy9tUbwEQU6DGUoNy+/p4MOa4GPBELkcz9BzlIWaU5l774Q45omGk08
 lztYX2Tu1gypt5OaJBLrf8XGnTWWQ26PCTP0RXoyzX6oRIwUkYgkUL/QAlUfsG5fau99y
X-Gm-Gg: AYBFou3Dl81Sjy083HToEzoiHwSHdImYqij5IAxy+nAOcrieyRgoKjlpiy9wRwD0muA
 rbGLpPJx7XqiWrllIr7NUhdYCtv7YVXNUazdhxjhUWvbA0PxREju/OIRX/zSWobpVvLNA701dcm
 nFDOegxxVLb6MFbgiqxEWeginrOjKiVYa2TlkS+mcLQlVDMMyckjP0uDY5OUTBCJSp99A6FNQqs
 tjiY+xl6lY19IwB0UAkuYNpY3bEPO6Q9LcD+BtWlUsRwOV1deDu93oxJgOa2oIBVM1uSleHIyTh
 jwUZH+HpEaQaSepLIzT5pR2kEt78cMU5OPqvJb0JbQIL5GuR8BCNHNSGZf3MgS/OW2V5IxnZppO
 /noMuR5g1JfyUJeliMWan3ua737IvfJLzVTrpbHpi8LbOupOBK0fzV6fToTINcLcv37+9hk8th9
 HZGx77KHzf6DOMzK6jPq31VKIxAvU3ug==
X-Received: by 2002:a05:620a:4724:b0:93c:6417:f9c8 with SMTP id
 af79cd13be357-94408a71215mr910775885a.29.1793286848672; 
 Thu, 29 Oct 2026 08:14:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4724:b0:93c:6417:f9c8 with SMTP id
 af79cd13be357-94408a71215mr910747985a.29.1793286846362; 
 Thu, 29 Oct 2026 08:14:06 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a96a8f28a1sm84312785e9.4.2026.10.29.08.14.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 08:14:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 5/6] target/mips: Convert MSA LD/ST.D (Doubleword Vector)
Date: Thu, 29 Oct 2026 16:13:15 +0100
Message-ID: <20261029151317.19170-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029151317.19170-1-philmd@oss.qualcomm.com>
References: <20261029151317.19170-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfX7vR5IabrTtW1
 CdTn1CHFH4sfDj48GuFMnQgH+4N17gLJ2mHmbAIl2SMeiGpAeWQpYipn1BQ54RQD4iB0Sq/0fDD
 oRzPVgrJXtbkW72byZ7Qv4Pa6HT+jzIBAZX+ti1Z37cIWMm19F0D1lEoJjgzD9/qidiCw5YJGYH
 SXXcM4xeuh2WrsDxniSZQn0aEa5j2lhxJtnQU/o1lHbmB1ngyLOeaKfiWUIhkRzZ3EKzkt96GbJ
 AeyFE7EcWdO0bSfCN0Q7tWJ1lV4y5DAAIS+Dviymv4t1vQgoogenKks63XoQqk8/BycNjpkAwRp
 9DRIIasUYgxvlk5xEyHJlGZud0I4jlt/qTdHv2gg/ZqSsLAgCOdV4N1lidMeEpXxh2NFCbvU7ZG
 n6ribnQ/Sv3uj/fmR3FF5DwkSpNjXgZulhH6opNGGffETD9YuwIBVm6VxcBHjbtabxOoGkzhKDf
 Lp8S82jNc1x4/++3hOw==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae362c1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=d8cwAk7nIhr6DB5JJpUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfX9ooiQT0L573S
 9swFai2PzZOWozfXgxOKYcvtKR0SvtzmgwrnfyCaRMtbMJsh3hVWc/YqsUDWZW1bz9TgcERuKxs
 avg2gYh3yE4VKxwXNW3JNSHlInpDas4=
X-Proofpoint-ORIG-GUID: w_FQWkZ1zMqXGj4D7ABMdIZEzj0rr5dv
X-Proofpoint-GUID: w_FQWkZ1zMqXGj4D7ABMdIZEzj0rr5dv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace runtime helpers by translation.
BE LD.D/ST.D now uses MO_BE with exchanged half handles;
no explicit D swaps or store-copy temporaries.

Replace the legacy cpu_ld/st*_data_ra() calls by tcg_gen_qemu_ld/st()
which allow to respect atomicity.

Remove the ensure_writable_pages() hack and MSALDST_PROTO macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/msa_helper.h.inc |  6 ---
 target/mips/tcg/msa_helper.c     | 63 --------------------------------
 target/mips/tcg/msa_translate.c  | 28 +++++---------
 3 files changed, 10 insertions(+), 87 deletions(-)

diff --git a/target/mips/tcg/msa_helper.h.inc b/target/mips/tcg/msa_helper.h.inc
index f0d31ceef291..e994353056f7 100644
--- a/target/mips/tcg/msa_helper.h.inc
+++ b/target/mips/tcg/msa_helper.h.inc
@@ -432,9 +432,3 @@ DEF_HELPER_4(msa_ftint_s_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ftint_u_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ffint_s_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ffint_u_df, void, env, i32, i32, i32)
-
-#define MSALDST_PROTO(type)                         \
-DEF_HELPER_3(msa_ld_ ## type, void, env, i32, tl)   \
-DEF_HELPER_3(msa_st_ ## type, void, env, i32, tl)
-MSALDST_PROTO(d)
-#undef MSALDST_PROTO
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index afd9cca09604..9ef63b0e197e 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -21,11 +21,8 @@
 #include "cpu.h"
 #include "internal.h"
 #include "tcg/tcg.h"
-#include "accel/tcg/cpu-ldst.h"
-#include "accel/tcg/probe.h"
 #include "exec/helper-proto.h"
 #include "exec/memop.h"
-#include "exec/target_page.h"
 #include "fpu/softfloat.h"
 #include "fpu_helper.h"
 
@@ -8219,63 +8216,3 @@ void HELPER(msa_ffint_u_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
 
     msa_move_v(pwd, pwx);
 }
-
-/* Data format min and max values */
-#define DF_BITS(df) (1 << ((df) + 3))
-
-/* Element-by-element access macros */
-#define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
-
-void HELPER(msa_ld_d)(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    if (mips_env_is_bigendian(env)) {
-        d0 = cpu_ldq_be_data_ra(env, addr + 0, ra);
-        d1 = cpu_ldq_be_data_ra(env, addr + 8, ra);
-    } else {
-        d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
-        d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-    }
-    pwd->d[0] = d0;
-    pwd->d[1] = d1;
-}
-
-#define MSA_PAGESPAN(x) \
-        ((((x) & ~TARGET_PAGE_MASK) + MSA_WRLEN / 8 - 1) >= TARGET_PAGE_SIZE)
-
-static inline void ensure_writable_pages(CPUMIPSState *env,
-                                         target_ulong addr,
-                                         int mmu_idx,
-                                         uintptr_t retaddr)
-{
-    /* FIXME: Probe the actual accesses (pass and use a size) */
-    if (unlikely(MSA_PAGESPAN(addr))) {
-        /* first page */
-        probe_write(env, addr, 0, mmu_idx, retaddr);
-        /* second page */
-        addr = (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-        probe_write(env, addr, 0, mmu_idx, retaddr);
-    }
-}
-
-void HELPER(msa_st_d)(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = mips_env_mmu_index(env);
-    uintptr_t ra = GETPC();
-
-    ensure_writable_pages(env, addr, mmu_idx, GETPC());
-
-    if (mips_env_is_bigendian(env)) {
-        cpu_stq_be_data_ra(env, addr + 0, pwd->d[0], ra);
-        cpu_stq_be_data_ra(env, addr + 8, pwd->d[1], ra);
-    } else {
-        cpu_stq_le_data_ra(env, addr + 0, pwd->d[0], ra);
-        cpu_stq_le_data_ra(env, addr + 8, pwd->d[1], ra);
-    }
-}
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 7a3c2390cfca..2d6f3d6070ba 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -785,8 +785,8 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
         MO_ATOM_NONE,
         MO_ATOM_SUBALIGN, /* Slightly stronger than required */
         MO_ATOM_SUBALIGN, /* Slightly stronger than required */
+        MO_ATOM_IFALIGN_PAIR
     };
-    TCGv_i32 wd;
     TCGv_i128 t16;
     TCGv_va addr;
     MemOp mop;
@@ -801,33 +801,25 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
     addr = tcgv_va_temp_new();
     gen_base_offset_addr(ctx, addr, a->ws, a->sa << a->df);
 
-    wd = tcg_constant_i32(a->wd);
-
-    if (is_load) {
-        switch (a->df) {
-        case 3:
-            gen_helper_msa_ld_d(tcg_env, wd, addr);
-            return true;
-        }
-    } else {
-        switch (a->df) {
-        case 3:
-            gen_helper_msa_st_d(tcg_env, wd, addr);
-            return true;
-        }
-    }
-
     t16 = tcg_temp_new_i128();
 
     mop = MO_128 | MO_LE;
     mop |= mo_atom_df[a->df];
 
+    if (a->df == 3 && mo_endian(ctx) != MO_LE) {
+        TCGv_i64 saved_d0 = d0;
+
+        mop = (mop & ~MO_BSWAP) | MO_BE;
+        d0 = d1;
+        d1 = saved_d0;
+    }
+
     if (is_load) {
         tcg_gen_qemu_ld_i128(t16, addr, ctx->mem_idx, mop);
         tcg_gen_extr_i128_i64(d0, d1, t16);
     }
 
-    if (mo_endian(ctx) != MO_LE) {
+    if (mo_endian(ctx) != MO_LE && a->df != 3) {
         if (!is_load) {
             TCGv_i64 temp_d0 = tcg_temp_new_i64();
             TCGv_i64 temp_d1 = tcg_temp_new_i64();
-- 
2.55.0


