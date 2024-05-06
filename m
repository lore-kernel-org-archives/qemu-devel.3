Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95079C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tSa-0005tW-8j; Mon, 06 May 2024 04:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tRv-00052C-9z
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tRJ-0002b5-3L
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJJcPATEqcNx1rmphKygqS4v8IIkau6GIO8BNLhpHtM=;
 b=KvHjr4AO5hKGmB7iDLBsEk6/tYX51cTdEp1cUrQPo/0V0yDxe6ZrQvrwvWjnmZ6iF7zuN1
 91RJAZho/vJ9Gp3VxDJU9nGYtT0cEHDeE0G2CYLIK7cz2jFlPPZ6zBt6E/+z0Z2jT2wxW4
 FQfVE3eMLD9/NOt4GGLY3EYlor/Pv4E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-8f_Pv6HJPDmzBEaPVv0I2g-1; Mon, 06 May 2024 04:11:11 -0400
X-MC-Unique: 8f_Pv6HJPDmzBEaPVv0I2g-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-572cd3a3687so205788a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983069; x=1715587869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJJcPATEqcNx1rmphKygqS4v8IIkau6GIO8BNLhpHtM=;
 b=VzeKZ+aHvuP19xqCfPMcqo4RbwzTGokQbEfeR70vmFnZibZ6aHNwUbdlrFLuwKpG6l
 ppWqzzZGOVq4DiZTIo+B3fK5tLxaiY5it/NgX/0Vy/QX1l3FjVHidKXCOi8qAs6Xv0rL
 pfg7tbrvMy8EyVOvDZj5LHrALCiKpEUOzf+Ndm42Gy2rl/yDPx/XiLA72tloE7cGW6TS
 wR3MVpiM4vAevsiQ7+wCeVXMBWrKeqtxEMVsnaM+utKRcehziqWjis5VgaMXK35ecEnl
 XYh9FIBJguIX0A5XThuNbumcGMwbfE3I72YRkUe0wQ5ux0vOlMNI5PU5e1ahyzyUWUt0
 bGAg==
X-Gm-Message-State: AOJu0YxY5KKrP/04ZYb65XVuUMIbv9pNkziq5zYt4SigTlu0C4kfcqXK
 WRsR/l3Cbbk++LWHhHsA9GA6kCFR+YG76oqA7oSCOSySTUXpiokirizVo3jM4CsN2sda30I++wJ
 Jt0ORxO7wyrvH6jjOOlyE/QYX9UzA0r3OiuQ3n6Y54YDTUcIwiFlSgSO4FX+ywb0C+CSuYw8G3q
 9aQCMBL6gC/ovq1Qkm19Tdvj0kjwU3OyWcqnWP
X-Received: by 2002:a17:907:2d2a:b0:a59:d1c0:3df with SMTP id
 gs42-20020a1709072d2a00b00a59d1c003dfmr1732120ejc.24.1714983068845; 
 Mon, 06 May 2024 01:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9fyUEfOeWB2coO6BiBmCvBZ/gdE2e+FyVnP7K6j+G+zpt7h3i369QxSUZ11TDP5gC1vECFQ==
X-Received: by 2002:a17:907:2d2a:b0:a59:d1c0:3df with SMTP id
 gs42-20020a1709072d2a00b00a59d1c003dfmr1731997ejc.24.1714983067110; 
 Mon, 06 May 2024 01:11:07 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 ww1-20020a170907084100b00a59cb8c93f3sm1194969ejb.58.2024.05.06.01.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:11:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 23/25] target/i386: decode x87 instructions in a separate
 function
Date: Mon,  6 May 2024 10:09:55 +0200
Message-ID: <20240506080957.10005-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These are unlikely to be converted to the table-based decoding
soon (perhaps there could be generic ESC decoding in decode-new.c.inc
for the Mod/RM byte, but not operand decoding), so keep them separate
from the remaining legacy-decoded instructions.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 1120 ++++++++++++++++++-----------------
 1 file changed, 566 insertions(+), 554 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 634b162ae97..e077fdd8c71 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2552,6 +2552,570 @@ static void gen_cmpxchg16b(DisasContext *s, CPUX86State *env, int modrm)
 }
 #endif
 
+static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
+{
+    CPUX86State *env = cpu_env(cpu);
+    bool update_fip = true;
+    int modrm, mod, rm, op;
+
+    if (s->flags & (HF_EM_MASK | HF_TS_MASK)) {
+        /* if CR0.EM or CR0.TS are set, generate an FPU exception */
+        /* XXX: what to do if illegal op ? */
+        gen_exception(s, EXCP07_PREX);
+        return true;
+    }
+    modrm = x86_ldub_code(env, s);
+    mod = (modrm >> 6) & 3;
+    rm = modrm & 7;
+    op = ((b & 7) << 3) | ((modrm >> 3) & 7);
+    if (mod != 3) {
+        /* memory op */
+        AddressParts a = gen_lea_modrm_0(env, s, modrm);
+        TCGv ea = gen_lea_modrm_1(s, a, false);
+        TCGv last_addr = tcg_temp_new();
+        bool update_fdp = true;
+
+        tcg_gen_mov_tl(last_addr, ea);
+        gen_lea_v_seg(s, s->aflag, ea, a.def_seg, s->override);
+
+        switch (op) {
+        case 0x00 ... 0x07: /* fxxxs */
+        case 0x10 ... 0x17: /* fixxxl */
+        case 0x20 ... 0x27: /* fxxxl */
+        case 0x30 ... 0x37: /* fixxx */
+            {
+                int op1;
+                op1 = op & 7;
+
+                switch (op >> 4) {
+                case 0:
+                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                        s->mem_index, MO_LEUL);
+                    gen_helper_flds_FT0(tcg_env, s->tmp2_i32);
+                    break;
+                case 1:
+                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                        s->mem_index, MO_LEUL);
+                    gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
+                    break;
+                case 2:
+                    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
+                                        s->mem_index, MO_LEUQ);
+                    gen_helper_fldl_FT0(tcg_env, s->tmp1_i64);
+                    break;
+                case 3:
+                default:
+                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                        s->mem_index, MO_LESW);
+                    gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
+                    break;
+                }
+
+                gen_helper_fp_arith_ST0_FT0(op1);
+                if (op1 == 3) {
+                    /* fcomp needs pop */
+                    gen_helper_fpop(tcg_env);
+                }
+            }
+            break;
+        case 0x08: /* flds */
+        case 0x0a: /* fsts */
+        case 0x0b: /* fstps */
+        case 0x18 ... 0x1b: /* fildl, fisttpl, fistl, fistpl */
+        case 0x28 ... 0x2b: /* fldl, fisttpll, fstl, fstpl */
+        case 0x38 ... 0x3b: /* filds, fisttps, fists, fistps */
+            switch (op & 7) {
+            case 0:
+                switch (op >> 4) {
+                case 0:
+                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                        s->mem_index, MO_LEUL);
+                    gen_helper_flds_ST0(tcg_env, s->tmp2_i32);
+                    break;
+                case 1:
+                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                        s->mem_index, MO_LEUL);
+                    gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
+                    break;
+                case 2:
+                    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
+                                        s->mem_index, MO_LEUQ);
+                    gen_helper_fldl_ST0(tcg_env, s->tmp1_i64);
+                    break;
+                case 3:
+                default:
+                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                        s->mem_index, MO_LESW);
+                    gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
+                    break;
+                }
+                break;
+            case 1:
+                /* XXX: the corresponding CPUID bit must be tested ! */
+                switch (op >> 4) {
+                case 1:
+                    gen_helper_fisttl_ST0(s->tmp2_i32, tcg_env);
+                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                        s->mem_index, MO_LEUL);
+                    break;
+                case 2:
+                    gen_helper_fisttll_ST0(s->tmp1_i64, tcg_env);
+                    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
+                                        s->mem_index, MO_LEUQ);
+                    break;
+                case 3:
+                default:
+                    gen_helper_fistt_ST0(s->tmp2_i32, tcg_env);
+                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                        s->mem_index, MO_LEUW);
+                    break;
+                }
+                gen_helper_fpop(tcg_env);
+                break;
+            default:
+                switch (op >> 4) {
+                case 0:
+                    gen_helper_fsts_ST0(s->tmp2_i32, tcg_env);
+                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                        s->mem_index, MO_LEUL);
+                    break;
+                case 1:
+                    gen_helper_fistl_ST0(s->tmp2_i32, tcg_env);
+                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                        s->mem_index, MO_LEUL);
+                    break;
+                case 2:
+                    gen_helper_fstl_ST0(s->tmp1_i64, tcg_env);
+                    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
+                                        s->mem_index, MO_LEUQ);
+                    break;
+                case 3:
+                default:
+                    gen_helper_fist_ST0(s->tmp2_i32, tcg_env);
+                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                        s->mem_index, MO_LEUW);
+                    break;
+                }
+                if ((op & 7) == 3) {
+                    gen_helper_fpop(tcg_env);
+                }
+                break;
+            }
+            break;
+        case 0x0c: /* fldenv mem */
+            gen_helper_fldenv(tcg_env, s->A0,
+                              tcg_constant_i32(s->dflag - 1));
+            update_fip = update_fdp = false;
+            break;
+        case 0x0d: /* fldcw mem */
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUW);
+            gen_helper_fldcw(tcg_env, s->tmp2_i32);
+            update_fip = update_fdp = false;
+            break;
+        case 0x0e: /* fnstenv mem */
+            gen_helper_fstenv(tcg_env, s->A0,
+                              tcg_constant_i32(s->dflag - 1));
+            update_fip = update_fdp = false;
+            break;
+        case 0x0f: /* fnstcw mem */
+            gen_helper_fnstcw(s->tmp2_i32, tcg_env);
+            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUW);
+            update_fip = update_fdp = false;
+            break;
+        case 0x1d: /* fldt mem */
+            gen_helper_fldt_ST0(tcg_env, s->A0);
+            break;
+        case 0x1f: /* fstpt mem */
+            gen_helper_fstt_ST0(tcg_env, s->A0);
+            gen_helper_fpop(tcg_env);
+            break;
+        case 0x2c: /* frstor mem */
+            gen_helper_frstor(tcg_env, s->A0,
+                              tcg_constant_i32(s->dflag - 1));
+            update_fip = update_fdp = false;
+            break;
+        case 0x2e: /* fnsave mem */
+            gen_helper_fsave(tcg_env, s->A0,
+                             tcg_constant_i32(s->dflag - 1));
+            update_fip = update_fdp = false;
+            break;
+        case 0x2f: /* fnstsw mem */
+            gen_helper_fnstsw(s->tmp2_i32, tcg_env);
+            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUW);
+            update_fip = update_fdp = false;
+            break;
+        case 0x3c: /* fbld */
+            gen_helper_fbld_ST0(tcg_env, s->A0);
+            break;
+        case 0x3e: /* fbstp */
+            gen_helper_fbst_ST0(tcg_env, s->A0);
+            gen_helper_fpop(tcg_env);
+            break;
+        case 0x3d: /* fildll */
+            tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
+                                s->mem_index, MO_LEUQ);
+            gen_helper_fildll_ST0(tcg_env, s->tmp1_i64);
+            break;
+        case 0x3f: /* fistpll */
+            gen_helper_fistll_ST0(s->tmp1_i64, tcg_env);
+            tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
+                                s->mem_index, MO_LEUQ);
+            gen_helper_fpop(tcg_env);
+            break;
+        default:
+            return false;
+        }
+
+        if (update_fdp) {
+            int last_seg = s->override >= 0 ? s->override : a.def_seg;
+
+            tcg_gen_ld_i32(s->tmp2_i32, tcg_env,
+                           offsetof(CPUX86State,
+                                    segs[last_seg].selector));
+            tcg_gen_st16_i32(s->tmp2_i32, tcg_env,
+                             offsetof(CPUX86State, fpds));
+            tcg_gen_st_tl(last_addr, tcg_env,
+                          offsetof(CPUX86State, fpdp));
+        }
+    } else {
+        /* register float ops */
+        int opreg = rm;
+
+        switch (op) {
+        case 0x08: /* fld sti */
+            gen_helper_fpush(tcg_env);
+            gen_helper_fmov_ST0_STN(tcg_env,
+                                    tcg_constant_i32((opreg + 1) & 7));
+            break;
+        case 0x09: /* fxchg sti */
+        case 0x29: /* fxchg4 sti, undocumented op */
+        case 0x39: /* fxchg7 sti, undocumented op */
+            gen_helper_fxchg_ST0_STN(tcg_env, tcg_constant_i32(opreg));
+            break;
+        case 0x0a: /* grp d9/2 */
+            switch (rm) {
+            case 0: /* fnop */
+                /*
+                 * check exceptions (FreeBSD FPU probe)
+                 * needs to be treated as I/O because of ferr_irq
+                 */
+                translator_io_start(&s->base);
+                gen_helper_fwait(tcg_env);
+                update_fip = false;
+                break;
+            default:
+                return false;
+            }
+            break;
+        case 0x0c: /* grp d9/4 */
+            switch (rm) {
+            case 0: /* fchs */
+                gen_helper_fchs_ST0(tcg_env);
+                break;
+            case 1: /* fabs */
+                gen_helper_fabs_ST0(tcg_env);
+                break;
+            case 4: /* ftst */
+                gen_helper_fldz_FT0(tcg_env);
+                gen_helper_fcom_ST0_FT0(tcg_env);
+                break;
+            case 5: /* fxam */
+                gen_helper_fxam_ST0(tcg_env);
+                break;
+            default:
+                return false;
+            }
+            break;
+        case 0x0d: /* grp d9/5 */
+            {
+                switch (rm) {
+                case 0:
+                    gen_helper_fpush(tcg_env);
+                    gen_helper_fld1_ST0(tcg_env);
+                    break;
+                case 1:
+                    gen_helper_fpush(tcg_env);
+                    gen_helper_fldl2t_ST0(tcg_env);
+                    break;
+                case 2:
+                    gen_helper_fpush(tcg_env);
+                    gen_helper_fldl2e_ST0(tcg_env);
+                    break;
+                case 3:
+                    gen_helper_fpush(tcg_env);
+                    gen_helper_fldpi_ST0(tcg_env);
+                    break;
+                case 4:
+                    gen_helper_fpush(tcg_env);
+                    gen_helper_fldlg2_ST0(tcg_env);
+                    break;
+                case 5:
+                    gen_helper_fpush(tcg_env);
+                    gen_helper_fldln2_ST0(tcg_env);
+                    break;
+                case 6:
+                    gen_helper_fpush(tcg_env);
+                    gen_helper_fldz_ST0(tcg_env);
+                    break;
+                default:
+                    return false;
+                }
+            }
+            break;
+        case 0x0e: /* grp d9/6 */
+            switch (rm) {
+            case 0: /* f2xm1 */
+                gen_helper_f2xm1(tcg_env);
+                break;
+            case 1: /* fyl2x */
+                gen_helper_fyl2x(tcg_env);
+                break;
+            case 2: /* fptan */
+                gen_helper_fptan(tcg_env);
+                break;
+            case 3: /* fpatan */
+                gen_helper_fpatan(tcg_env);
+                break;
+            case 4: /* fxtract */
+                gen_helper_fxtract(tcg_env);
+                break;
+            case 5: /* fprem1 */
+                gen_helper_fprem1(tcg_env);
+                break;
+            case 6: /* fdecstp */
+                gen_helper_fdecstp(tcg_env);
+                break;
+            default:
+            case 7: /* fincstp */
+                gen_helper_fincstp(tcg_env);
+                break;
+            }
+            break;
+        case 0x0f: /* grp d9/7 */
+            switch (rm) {
+            case 0: /* fprem */
+                gen_helper_fprem(tcg_env);
+                break;
+            case 1: /* fyl2xp1 */
+                gen_helper_fyl2xp1(tcg_env);
+                break;
+            case 2: /* fsqrt */
+                gen_helper_fsqrt(tcg_env);
+                break;
+            case 3: /* fsincos */
+                gen_helper_fsincos(tcg_env);
+                break;
+            case 5: /* fscale */
+                gen_helper_fscale(tcg_env);
+                break;
+            case 4: /* frndint */
+                gen_helper_frndint(tcg_env);
+                break;
+            case 6: /* fsin */
+                gen_helper_fsin(tcg_env);
+                break;
+            default:
+            case 7: /* fcos */
+                gen_helper_fcos(tcg_env);
+                break;
+            }
+            break;
+        case 0x00: case 0x01: case 0x04 ... 0x07: /* fxxx st, sti */
+        case 0x20: case 0x21: case 0x24 ... 0x27: /* fxxx sti, st */
+        case 0x30: case 0x31: case 0x34 ... 0x37: /* fxxxp sti, st */
+            {
+                int op1;
+
+                op1 = op & 7;
+                if (op >= 0x20) {
+                    gen_helper_fp_arith_STN_ST0(op1, opreg);
+                    if (op >= 0x30) {
+                        gen_helper_fpop(tcg_env);
+                    }
+                } else {
+                    gen_helper_fmov_FT0_STN(tcg_env,
+                                            tcg_constant_i32(opreg));
+                    gen_helper_fp_arith_ST0_FT0(op1);
+                }
+            }
+            break;
+        case 0x02: /* fcom */
+        case 0x22: /* fcom2, undocumented op */
+            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
+            gen_helper_fcom_ST0_FT0(tcg_env);
+            break;
+        case 0x03: /* fcomp */
+        case 0x23: /* fcomp3, undocumented op */
+        case 0x32: /* fcomp5, undocumented op */
+            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
+            gen_helper_fcom_ST0_FT0(tcg_env);
+            gen_helper_fpop(tcg_env);
+            break;
+        case 0x15: /* da/5 */
+            switch (rm) {
+            case 1: /* fucompp */
+                gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(1));
+                gen_helper_fucom_ST0_FT0(tcg_env);
+                gen_helper_fpop(tcg_env);
+                gen_helper_fpop(tcg_env);
+                break;
+            default:
+                return false;
+            }
+            break;
+        case 0x1c:
+            switch (rm) {
+            case 0: /* feni (287 only, just do nop here) */
+                break;
+            case 1: /* fdisi (287 only, just do nop here) */
+                break;
+            case 2: /* fclex */
+                gen_helper_fclex(tcg_env);
+                update_fip = false;
+                break;
+            case 3: /* fninit */
+                gen_helper_fninit(tcg_env);
+                update_fip = false;
+                break;
+            case 4: /* fsetpm (287 only, just do nop here) */
+                break;
+            default:
+                return false;
+            }
+            break;
+        case 0x1d: /* fucomi */
+            if (!(s->cpuid_features & CPUID_CMOV)) {
+                goto illegal_op;
+            }
+            gen_update_cc_op(s);
+            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
+            gen_helper_fucomi_ST0_FT0(tcg_env);
+            set_cc_op(s, CC_OP_EFLAGS);
+            break;
+        case 0x1e: /* fcomi */
+            if (!(s->cpuid_features & CPUID_CMOV)) {
+                goto illegal_op;
+            }
+            gen_update_cc_op(s);
+            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
+            gen_helper_fcomi_ST0_FT0(tcg_env);
+            set_cc_op(s, CC_OP_EFLAGS);
+            break;
+        case 0x28: /* ffree sti */
+            gen_helper_ffree_STN(tcg_env, tcg_constant_i32(opreg));
+            break;
+        case 0x2a: /* fst sti */
+            gen_helper_fmov_STN_ST0(tcg_env, tcg_constant_i32(opreg));
+            break;
+        case 0x2b: /* fstp sti */
+        case 0x0b: /* fstp1 sti, undocumented op */
+        case 0x3a: /* fstp8 sti, undocumented op */
+        case 0x3b: /* fstp9 sti, undocumented op */
+            gen_helper_fmov_STN_ST0(tcg_env, tcg_constant_i32(opreg));
+            gen_helper_fpop(tcg_env);
+            break;
+        case 0x2c: /* fucom st(i) */
+            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
+            gen_helper_fucom_ST0_FT0(tcg_env);
+            break;
+        case 0x2d: /* fucomp st(i) */
+            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
+            gen_helper_fucom_ST0_FT0(tcg_env);
+            gen_helper_fpop(tcg_env);
+            break;
+        case 0x33: /* de/3 */
+            switch (rm) {
+            case 1: /* fcompp */
+                gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(1));
+                gen_helper_fcom_ST0_FT0(tcg_env);
+                gen_helper_fpop(tcg_env);
+                gen_helper_fpop(tcg_env);
+                break;
+            default:
+                return false;
+            }
+            break;
+        case 0x38: /* ffreep sti, undocumented op */
+            gen_helper_ffree_STN(tcg_env, tcg_constant_i32(opreg));
+            gen_helper_fpop(tcg_env);
+            break;
+        case 0x3c: /* df/4 */
+            switch (rm) {
+            case 0:
+                gen_helper_fnstsw(s->tmp2_i32, tcg_env);
+                tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
+                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
+                break;
+            default:
+                return false;
+            }
+            break;
+        case 0x3d: /* fucomip */
+            if (!(s->cpuid_features & CPUID_CMOV)) {
+                goto illegal_op;
+            }
+            gen_update_cc_op(s);
+            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
+            gen_helper_fucomi_ST0_FT0(tcg_env);
+            gen_helper_fpop(tcg_env);
+            set_cc_op(s, CC_OP_EFLAGS);
+            break;
+        case 0x3e: /* fcomip */
+            if (!(s->cpuid_features & CPUID_CMOV)) {
+                goto illegal_op;
+            }
+            gen_update_cc_op(s);
+            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
+            gen_helper_fcomi_ST0_FT0(tcg_env);
+            gen_helper_fpop(tcg_env);
+            set_cc_op(s, CC_OP_EFLAGS);
+            break;
+        case 0x10 ... 0x13: /* fcmovxx */
+        case 0x18 ... 0x1b:
+            {
+                int op1;
+                TCGLabel *l1;
+                static const uint8_t fcmov_cc[8] = {
+                    (JCC_B << 1),
+                    (JCC_Z << 1),
+                    (JCC_BE << 1),
+                    (JCC_P << 1),
+                };
+
+                if (!(s->cpuid_features & CPUID_CMOV)) {
+                    goto illegal_op;
+                }
+                op1 = fcmov_cc[op & 3] | (((op >> 3) & 1) ^ 1);
+                l1 = gen_new_label();
+                gen_jcc1_noeob(s, op1, l1);
+                gen_helper_fmov_ST0_STN(tcg_env,
+                                        tcg_constant_i32(opreg));
+                gen_set_label(l1);
+            }
+            break;
+        default:
+            return false;
+        }
+    }
+
+    if (update_fip) {
+        tcg_gen_ld_i32(s->tmp2_i32, tcg_env,
+                       offsetof(CPUX86State, segs[R_CS].selector));
+        tcg_gen_st16_i32(s->tmp2_i32, tcg_env,
+                         offsetof(CPUX86State, fpcs));
+        tcg_gen_st_tl(eip_cur_tl(s),
+                      tcg_env, offsetof(CPUX86State, fpip));
+    }
+    return true;
+
+ illegal_op:
+    gen_illegal_opcode(s);
+    return true;
+}
+
 /* convert one instruction. s->base.is_jmp is set if the translation must
    be stopped. Return the next pc value */
 static bool disas_insn(DisasContext *s, CPUState *cpu)
@@ -2908,560 +3472,8 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         /************************/
         /* floats */
     case 0xd8 ... 0xdf:
-        {
-            bool update_fip = true;
-
-            if (s->flags & (HF_EM_MASK | HF_TS_MASK)) {
-                /* if CR0.EM or CR0.TS are set, generate an FPU exception */
-                /* XXX: what to do if illegal op ? */
-                gen_exception(s, EXCP07_PREX);
-                break;
-            }
-            modrm = x86_ldub_code(env, s);
-            mod = (modrm >> 6) & 3;
-            rm = modrm & 7;
-            op = ((b & 7) << 3) | ((modrm >> 3) & 7);
-            if (mod != 3) {
-                /* memory op */
-                AddressParts a = gen_lea_modrm_0(env, s, modrm);
-                TCGv ea = gen_lea_modrm_1(s, a, false);
-                TCGv last_addr = tcg_temp_new();
-                bool update_fdp = true;
-
-                tcg_gen_mov_tl(last_addr, ea);
-                gen_lea_v_seg(s, s->aflag, ea, a.def_seg, s->override);
-
-                switch (op) {
-                case 0x00 ... 0x07: /* fxxxs */
-                case 0x10 ... 0x17: /* fixxxl */
-                case 0x20 ... 0x27: /* fxxxl */
-                case 0x30 ... 0x37: /* fixxx */
-                    {
-                        int op1;
-                        op1 = op & 7;
-
-                        switch (op >> 4) {
-                        case 0:
-                            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                                s->mem_index, MO_LEUL);
-                            gen_helper_flds_FT0(tcg_env, s->tmp2_i32);
-                            break;
-                        case 1:
-                            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                                s->mem_index, MO_LEUL);
-                            gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
-                            break;
-                        case 2:
-                            tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
-                                                s->mem_index, MO_LEUQ);
-                            gen_helper_fldl_FT0(tcg_env, s->tmp1_i64);
-                            break;
-                        case 3:
-                        default:
-                            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                                s->mem_index, MO_LESW);
-                            gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
-                            break;
-                        }
-
-                        gen_helper_fp_arith_ST0_FT0(op1);
-                        if (op1 == 3) {
-                            /* fcomp needs pop */
-                            gen_helper_fpop(tcg_env);
-                        }
-                    }
-                    break;
-                case 0x08: /* flds */
-                case 0x0a: /* fsts */
-                case 0x0b: /* fstps */
-                case 0x18 ... 0x1b: /* fildl, fisttpl, fistl, fistpl */
-                case 0x28 ... 0x2b: /* fldl, fisttpll, fstl, fstpl */
-                case 0x38 ... 0x3b: /* filds, fisttps, fists, fistps */
-                    switch (op & 7) {
-                    case 0:
-                        switch (op >> 4) {
-                        case 0:
-                            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                                s->mem_index, MO_LEUL);
-                            gen_helper_flds_ST0(tcg_env, s->tmp2_i32);
-                            break;
-                        case 1:
-                            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                                s->mem_index, MO_LEUL);
-                            gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
-                            break;
-                        case 2:
-                            tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
-                                                s->mem_index, MO_LEUQ);
-                            gen_helper_fldl_ST0(tcg_env, s->tmp1_i64);
-                            break;
-                        case 3:
-                        default:
-                            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                                s->mem_index, MO_LESW);
-                            gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
-                            break;
-                        }
-                        break;
-                    case 1:
-                        /* XXX: the corresponding CPUID bit must be tested ! */
-                        switch (op >> 4) {
-                        case 1:
-                            gen_helper_fisttl_ST0(s->tmp2_i32, tcg_env);
-                            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                                s->mem_index, MO_LEUL);
-                            break;
-                        case 2:
-                            gen_helper_fisttll_ST0(s->tmp1_i64, tcg_env);
-                            tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
-                                                s->mem_index, MO_LEUQ);
-                            break;
-                        case 3:
-                        default:
-                            gen_helper_fistt_ST0(s->tmp2_i32, tcg_env);
-                            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                                s->mem_index, MO_LEUW);
-                            break;
-                        }
-                        gen_helper_fpop(tcg_env);
-                        break;
-                    default:
-                        switch (op >> 4) {
-                        case 0:
-                            gen_helper_fsts_ST0(s->tmp2_i32, tcg_env);
-                            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                                s->mem_index, MO_LEUL);
-                            break;
-                        case 1:
-                            gen_helper_fistl_ST0(s->tmp2_i32, tcg_env);
-                            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                                s->mem_index, MO_LEUL);
-                            break;
-                        case 2:
-                            gen_helper_fstl_ST0(s->tmp1_i64, tcg_env);
-                            tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
-                                                s->mem_index, MO_LEUQ);
-                            break;
-                        case 3:
-                        default:
-                            gen_helper_fist_ST0(s->tmp2_i32, tcg_env);
-                            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                                s->mem_index, MO_LEUW);
-                            break;
-                        }
-                        if ((op & 7) == 3) {
-                            gen_helper_fpop(tcg_env);
-                        }
-                        break;
-                    }
-                    break;
-                case 0x0c: /* fldenv mem */
-                    gen_helper_fldenv(tcg_env, s->A0,
-                                      tcg_constant_i32(dflag - 1));
-                    update_fip = update_fdp = false;
-                    break;
-                case 0x0d: /* fldcw mem */
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUW);
-                    gen_helper_fldcw(tcg_env, s->tmp2_i32);
-                    update_fip = update_fdp = false;
-                    break;
-                case 0x0e: /* fnstenv mem */
-                    gen_helper_fstenv(tcg_env, s->A0,
-                                      tcg_constant_i32(dflag - 1));
-                    update_fip = update_fdp = false;
-                    break;
-                case 0x0f: /* fnstcw mem */
-                    gen_helper_fnstcw(s->tmp2_i32, tcg_env);
-                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUW);
-                    update_fip = update_fdp = false;
-                    break;
-                case 0x1d: /* fldt mem */
-                    gen_helper_fldt_ST0(tcg_env, s->A0);
-                    break;
-                case 0x1f: /* fstpt mem */
-                    gen_helper_fstt_ST0(tcg_env, s->A0);
-                    gen_helper_fpop(tcg_env);
-                    break;
-                case 0x2c: /* frstor mem */
-                    gen_helper_frstor(tcg_env, s->A0,
-                                      tcg_constant_i32(dflag - 1));
-                    update_fip = update_fdp = false;
-                    break;
-                case 0x2e: /* fnsave mem */
-                    gen_helper_fsave(tcg_env, s->A0,
-                                     tcg_constant_i32(dflag - 1));
-                    update_fip = update_fdp = false;
-                    break;
-                case 0x2f: /* fnstsw mem */
-                    gen_helper_fnstsw(s->tmp2_i32, tcg_env);
-                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUW);
-                    update_fip = update_fdp = false;
-                    break;
-                case 0x3c: /* fbld */
-                    gen_helper_fbld_ST0(tcg_env, s->A0);
-                    break;
-                case 0x3e: /* fbstp */
-                    gen_helper_fbst_ST0(tcg_env, s->A0);
-                    gen_helper_fpop(tcg_env);
-                    break;
-                case 0x3d: /* fildll */
-                    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
-                                        s->mem_index, MO_LEUQ);
-                    gen_helper_fildll_ST0(tcg_env, s->tmp1_i64);
-                    break;
-                case 0x3f: /* fistpll */
-                    gen_helper_fistll_ST0(s->tmp1_i64, tcg_env);
-                    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
-                                        s->mem_index, MO_LEUQ);
-                    gen_helper_fpop(tcg_env);
-                    break;
-                default:
-                    goto unknown_op;
-                }
-
-                if (update_fdp) {
-                    int last_seg = s->override >= 0 ? s->override : a.def_seg;
-
-                    tcg_gen_ld_i32(s->tmp2_i32, tcg_env,
-                                   offsetof(CPUX86State,
-                                            segs[last_seg].selector));
-                    tcg_gen_st16_i32(s->tmp2_i32, tcg_env,
-                                     offsetof(CPUX86State, fpds));
-                    tcg_gen_st_tl(last_addr, tcg_env,
-                                  offsetof(CPUX86State, fpdp));
-                }
-            } else {
-                /* register float ops */
-                opreg = rm;
-
-                switch (op) {
-                case 0x08: /* fld sti */
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fmov_ST0_STN(tcg_env,
-                                            tcg_constant_i32((opreg + 1) & 7));
-                    break;
-                case 0x09: /* fxchg sti */
-                case 0x29: /* fxchg4 sti, undocumented op */
-                case 0x39: /* fxchg7 sti, undocumented op */
-                    gen_helper_fxchg_ST0_STN(tcg_env, tcg_constant_i32(opreg));
-                    break;
-                case 0x0a: /* grp d9/2 */
-                    switch (rm) {
-                    case 0: /* fnop */
-                        /*
-                         * check exceptions (FreeBSD FPU probe)
-                         * needs to be treated as I/O because of ferr_irq
-                         */
-                        translator_io_start(&s->base);
-                        gen_helper_fwait(tcg_env);
-                        update_fip = false;
-                        break;
-                    default:
-                        goto unknown_op;
-                    }
-                    break;
-                case 0x0c: /* grp d9/4 */
-                    switch (rm) {
-                    case 0: /* fchs */
-                        gen_helper_fchs_ST0(tcg_env);
-                        break;
-                    case 1: /* fabs */
-                        gen_helper_fabs_ST0(tcg_env);
-                        break;
-                    case 4: /* ftst */
-                        gen_helper_fldz_FT0(tcg_env);
-                        gen_helper_fcom_ST0_FT0(tcg_env);
-                        break;
-                    case 5: /* fxam */
-                        gen_helper_fxam_ST0(tcg_env);
-                        break;
-                    default:
-                        goto unknown_op;
-                    }
-                    break;
-                case 0x0d: /* grp d9/5 */
-                    {
-                        switch (rm) {
-                        case 0:
-                            gen_helper_fpush(tcg_env);
-                            gen_helper_fld1_ST0(tcg_env);
-                            break;
-                        case 1:
-                            gen_helper_fpush(tcg_env);
-                            gen_helper_fldl2t_ST0(tcg_env);
-                            break;
-                        case 2:
-                            gen_helper_fpush(tcg_env);
-                            gen_helper_fldl2e_ST0(tcg_env);
-                            break;
-                        case 3:
-                            gen_helper_fpush(tcg_env);
-                            gen_helper_fldpi_ST0(tcg_env);
-                            break;
-                        case 4:
-                            gen_helper_fpush(tcg_env);
-                            gen_helper_fldlg2_ST0(tcg_env);
-                            break;
-                        case 5:
-                            gen_helper_fpush(tcg_env);
-                            gen_helper_fldln2_ST0(tcg_env);
-                            break;
-                        case 6:
-                            gen_helper_fpush(tcg_env);
-                            gen_helper_fldz_ST0(tcg_env);
-                            break;
-                        default:
-                            goto unknown_op;
-                        }
-                    }
-                    break;
-                case 0x0e: /* grp d9/6 */
-                    switch (rm) {
-                    case 0: /* f2xm1 */
-                        gen_helper_f2xm1(tcg_env);
-                        break;
-                    case 1: /* fyl2x */
-                        gen_helper_fyl2x(tcg_env);
-                        break;
-                    case 2: /* fptan */
-                        gen_helper_fptan(tcg_env);
-                        break;
-                    case 3: /* fpatan */
-                        gen_helper_fpatan(tcg_env);
-                        break;
-                    case 4: /* fxtract */
-                        gen_helper_fxtract(tcg_env);
-                        break;
-                    case 5: /* fprem1 */
-                        gen_helper_fprem1(tcg_env);
-                        break;
-                    case 6: /* fdecstp */
-                        gen_helper_fdecstp(tcg_env);
-                        break;
-                    default:
-                    case 7: /* fincstp */
-                        gen_helper_fincstp(tcg_env);
-                        break;
-                    }
-                    break;
-                case 0x0f: /* grp d9/7 */
-                    switch (rm) {
-                    case 0: /* fprem */
-                        gen_helper_fprem(tcg_env);
-                        break;
-                    case 1: /* fyl2xp1 */
-                        gen_helper_fyl2xp1(tcg_env);
-                        break;
-                    case 2: /* fsqrt */
-                        gen_helper_fsqrt(tcg_env);
-                        break;
-                    case 3: /* fsincos */
-                        gen_helper_fsincos(tcg_env);
-                        break;
-                    case 5: /* fscale */
-                        gen_helper_fscale(tcg_env);
-                        break;
-                    case 4: /* frndint */
-                        gen_helper_frndint(tcg_env);
-                        break;
-                    case 6: /* fsin */
-                        gen_helper_fsin(tcg_env);
-                        break;
-                    default:
-                    case 7: /* fcos */
-                        gen_helper_fcos(tcg_env);
-                        break;
-                    }
-                    break;
-                case 0x00: case 0x01: case 0x04 ... 0x07: /* fxxx st, sti */
-                case 0x20: case 0x21: case 0x24 ... 0x27: /* fxxx sti, st */
-                case 0x30: case 0x31: case 0x34 ... 0x37: /* fxxxp sti, st */
-                    {
-                        int op1;
-
-                        op1 = op & 7;
-                        if (op >= 0x20) {
-                            gen_helper_fp_arith_STN_ST0(op1, opreg);
-                            if (op >= 0x30) {
-                                gen_helper_fpop(tcg_env);
-                            }
-                        } else {
-                            gen_helper_fmov_FT0_STN(tcg_env,
-                                                    tcg_constant_i32(opreg));
-                            gen_helper_fp_arith_ST0_FT0(op1);
-                        }
-                    }
-                    break;
-                case 0x02: /* fcom */
-                case 0x22: /* fcom2, undocumented op */
-                    gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-                    gen_helper_fcom_ST0_FT0(tcg_env);
-                    break;
-                case 0x03: /* fcomp */
-                case 0x23: /* fcomp3, undocumented op */
-                case 0x32: /* fcomp5, undocumented op */
-                    gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-                    gen_helper_fcom_ST0_FT0(tcg_env);
-                    gen_helper_fpop(tcg_env);
-                    break;
-                case 0x15: /* da/5 */
-                    switch (rm) {
-                    case 1: /* fucompp */
-                        gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(1));
-                        gen_helper_fucom_ST0_FT0(tcg_env);
-                        gen_helper_fpop(tcg_env);
-                        gen_helper_fpop(tcg_env);
-                        break;
-                    default:
-                        goto unknown_op;
-                    }
-                    break;
-                case 0x1c:
-                    switch (rm) {
-                    case 0: /* feni (287 only, just do nop here) */
-                        break;
-                    case 1: /* fdisi (287 only, just do nop here) */
-                        break;
-                    case 2: /* fclex */
-                        gen_helper_fclex(tcg_env);
-                        update_fip = false;
-                        break;
-                    case 3: /* fninit */
-                        gen_helper_fninit(tcg_env);
-                        update_fip = false;
-                        break;
-                    case 4: /* fsetpm (287 only, just do nop here) */
-                        break;
-                    default:
-                        goto unknown_op;
-                    }
-                    break;
-                case 0x1d: /* fucomi */
-                    if (!(s->cpuid_features & CPUID_CMOV)) {
-                        goto illegal_op;
-                    }
-                    gen_update_cc_op(s);
-                    gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-                    gen_helper_fucomi_ST0_FT0(tcg_env);
-                    set_cc_op(s, CC_OP_EFLAGS);
-                    break;
-                case 0x1e: /* fcomi */
-                    if (!(s->cpuid_features & CPUID_CMOV)) {
-                        goto illegal_op;
-                    }
-                    gen_update_cc_op(s);
-                    gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-                    gen_helper_fcomi_ST0_FT0(tcg_env);
-                    set_cc_op(s, CC_OP_EFLAGS);
-                    break;
-                case 0x28: /* ffree sti */
-                    gen_helper_ffree_STN(tcg_env, tcg_constant_i32(opreg));
-                    break;
-                case 0x2a: /* fst sti */
-                    gen_helper_fmov_STN_ST0(tcg_env, tcg_constant_i32(opreg));
-                    break;
-                case 0x2b: /* fstp sti */
-                case 0x0b: /* fstp1 sti, undocumented op */
-                case 0x3a: /* fstp8 sti, undocumented op */
-                case 0x3b: /* fstp9 sti, undocumented op */
-                    gen_helper_fmov_STN_ST0(tcg_env, tcg_constant_i32(opreg));
-                    gen_helper_fpop(tcg_env);
-                    break;
-                case 0x2c: /* fucom st(i) */
-                    gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-                    gen_helper_fucom_ST0_FT0(tcg_env);
-                    break;
-                case 0x2d: /* fucomp st(i) */
-                    gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-                    gen_helper_fucom_ST0_FT0(tcg_env);
-                    gen_helper_fpop(tcg_env);
-                    break;
-                case 0x33: /* de/3 */
-                    switch (rm) {
-                    case 1: /* fcompp */
-                        gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(1));
-                        gen_helper_fcom_ST0_FT0(tcg_env);
-                        gen_helper_fpop(tcg_env);
-                        gen_helper_fpop(tcg_env);
-                        break;
-                    default:
-                        goto unknown_op;
-                    }
-                    break;
-                case 0x38: /* ffreep sti, undocumented op */
-                    gen_helper_ffree_STN(tcg_env, tcg_constant_i32(opreg));
-                    gen_helper_fpop(tcg_env);
-                    break;
-                case 0x3c: /* df/4 */
-                    switch (rm) {
-                    case 0:
-                        gen_helper_fnstsw(s->tmp2_i32, tcg_env);
-                        tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
-                        gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
-                        break;
-                    default:
-                        goto unknown_op;
-                    }
-                    break;
-                case 0x3d: /* fucomip */
-                    if (!(s->cpuid_features & CPUID_CMOV)) {
-                        goto illegal_op;
-                    }
-                    gen_update_cc_op(s);
-                    gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-                    gen_helper_fucomi_ST0_FT0(tcg_env);
-                    gen_helper_fpop(tcg_env);
-                    set_cc_op(s, CC_OP_EFLAGS);
-                    break;
-                case 0x3e: /* fcomip */
-                    if (!(s->cpuid_features & CPUID_CMOV)) {
-                        goto illegal_op;
-                    }
-                    gen_update_cc_op(s);
-                    gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-                    gen_helper_fcomi_ST0_FT0(tcg_env);
-                    gen_helper_fpop(tcg_env);
-                    set_cc_op(s, CC_OP_EFLAGS);
-                    break;
-                case 0x10 ... 0x13: /* fcmovxx */
-                case 0x18 ... 0x1b:
-                    {
-                        int op1;
-                        TCGLabel *l1;
-                        static const uint8_t fcmov_cc[8] = {
-                            (JCC_B << 1),
-                            (JCC_Z << 1),
-                            (JCC_BE << 1),
-                            (JCC_P << 1),
-                        };
-
-                        if (!(s->cpuid_features & CPUID_CMOV)) {
-                            goto illegal_op;
-                        }
-                        op1 = fcmov_cc[op & 3] | (((op >> 3) & 1) ^ 1);
-                        l1 = gen_new_label();
-                        gen_jcc1_noeob(s, op1, l1);
-                        gen_helper_fmov_ST0_STN(tcg_env,
-                                                tcg_constant_i32(opreg));
-                        gen_set_label(l1);
-                    }
-                    break;
-                default:
-                    goto unknown_op;
-                }
-            }
-
-            if (update_fip) {
-                tcg_gen_ld_i32(s->tmp2_i32, tcg_env,
-                               offsetof(CPUX86State, segs[R_CS].selector));
-                tcg_gen_st16_i32(s->tmp2_i32, tcg_env,
-                                 offsetof(CPUX86State, fpcs));
-                tcg_gen_st_tl(eip_cur_tl(s),
-                              tcg_env, offsetof(CPUX86State, fpip));
-            }
+        if (!disas_insn_x87(s, cpu, b)) {
+            goto unknown_op;
         }
         break;
 
-- 
2.45.0


