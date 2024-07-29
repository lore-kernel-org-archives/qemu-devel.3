Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B84C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZX-0006qK-Rd; Mon, 29 Jul 2024 13:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZQ-0006Hd-8r
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:54:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZM-0000PV-NQ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:54:04 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d1d818c42so2115940b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275639; x=1722880439;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLdx4AZXHbpEMxw/S18/9QimvuhK4hPq7UuREWO1i7w=;
 b=AxcNr6CTMWlI+Cs7fVd2dxcaQojw/0Yh4V/nkrvHm3c++QIcR8hbtub1MPgujKX7/O
 XLyYdGsMNDMRLTdqjRIbIOken5p5YW7kjWUrbONF+gx+ANpWBdRsmli15CRx0QWjIcol
 3C2Ty4Kr3k0+G9yOzB/ctVIX70cuvu8+lHqCv4pELK0Ngl9ZQMEKB6DBmYXEi/hDmKaf
 Pbndl0rTQadfbIA7mdoFH9bBLMJ/etG84elMYlpdM+jBxRFcbF1bQF/bd/h3IQ0zkTjd
 QVY2awcI4Q/6LAVCyuAlnLljeEHM04zwDNCzSmHvtkE4Q1/LYtqa5UqPwSr27Q6Kyx65
 9Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275639; x=1722880439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLdx4AZXHbpEMxw/S18/9QimvuhK4hPq7UuREWO1i7w=;
 b=cWDNNAJuiNqSK6s8rbyDjzkJ2yjPFROvGL1bhHBLZlKeKnOfy8YWXQ6JmgBgaG5BTT
 6npTWoRMoWNBcb6WZj4grDtGdeQohkK89z9kCS/V4qd6zi6nEbW7dGnVqMx22Kxysrvx
 Es8EAWte5wPN0ygCq4/qyeSKXEzyYAQnbPVoWMOeb9Mxzg2OEnU0HLoLg55cRhcYWlhT
 Vi7CsHc5t4GO1gKIPIgVoyn8s9E3aPJM8SUoYdTezsgRWWkYckE1e5Lyqzvb/ViCYA00
 H+fpjk0jaXmYHeNOmcuxjvuqw27Ju+B8QD6DEuxbCgcU/rf+h8IDVBamGRM7K//FU0dc
 6kYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB/OWkFdbBT0iLJMU7oTtq9wY2kRHrp403EHZ5fPvM4+NEYMJRxgz1leTE15G6I9HmLCxLT/svpG06kgSAh6bYsa1z9Ws=
X-Gm-Message-State: AOJu0YxSUl8GD05WZC2+NMJlD0Dy3BqRdzOahP6/ucvCtNZo8J54pME2
 /CgQQehjhRqnrhbcthJk+pvTFos90PSm0P+Wbxb+rg1WZ/i4rVLGr9325075MUI=
X-Google-Smtp-Source: AGHT+IHeHWKLJYpABBBI9IQcd/WVDBlP3mFmzx1JskVZ4SD0srql6HA5QQVPGd6UEK4LTE1RVzAvew==
X-Received: by 2002:a05:6a20:3d88:b0:1c3:aec6:7663 with SMTP id
 adf61e73a8af0-1c4a13afd68mr7286492637.39.1722275638861; 
 Mon, 29 Jul 2024 10:53:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:58 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 23/24] linux-user: Add RISC-V zicfilp support in VDSO
Date: Mon, 29 Jul 2024 10:53:25 -0700
Message-ID: <20240729175327.73705-24-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, LOTS_OF_MONEY=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

Add zicfilp support in VDSO. VDSO functions need lpad instruction
so that userspace could call this function when landing pad extension is
enabled. This solution only works when toolchain always use landing pad
label 1.

Otherwise, If extension is not enabled, lpad instructions will be lui
instructions with rd=x0 (which is nop). Prebuilt VDSO is still
compatible with RISC-V core w/o zicfilp extension.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 linux-user/riscv/vdso-64.so | Bin 3944 -> 4128 bytes
 linux-user/riscv/vdso.S     |  50 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/linux-user/riscv/vdso-64.so b/linux-user/riscv/vdso-64.so
index ae49f5b043b5941b9d304a056c2b50c185f413b0..cd7f2fa7bdb811af6be2dcc3fb9601b66e3d1c81 100755
GIT binary patch
delta 1345
zcmah}O=uHA6rRa8*`3W#v-vSWgUvy(QL#}%mV&j76iPuQBHAj2(ng|zmM)E!P>`g>
ziy+eQP!K%yD2kv2Jb7q5_;(V#<f8T>2zrPIp$E0T*_|nLFFu%g^L_K)%k2BfxBcts
zwSKzU%uIMvDl|QN=xp<WSxBkG7O6?t!5&mSxH{CqZapIS5in@ND0&^M9SwtYn2kCl
z8HHvbTIYee+1S|&oZsNl6@EhD=NK-I`TfVcovANRA6MVpdHd;BIWn<tz;C}Zg!f#o
zJIeOs$1M@)*Wc|0j<Y-<ig*^WdPuKL`0SmKqyiq##X<Z^OE9+jz3uoXh2tNAc{aFo
z1twr<QCRm}!4()%@Eu+GDUKoG>4}g4*$}@d(n<~qepB*LP!3)Siz)<!cU)L~kXC{}
zEqLOxKPmXG%f8cUD^<!G_?jY`yo4d|;kbMX*GF*m<L!yoO|MGplL+N?0uP|A=~d*e
zHVAQWSlx}&F5K8<AH_U!-zdg#{GVyuzc7Q_Vx?MIB6I?e-o>SSu5ui{`}Ri4l{qVG
z<))V_rE;ZO#UoHP&Zd{==Wom%v$EK`eUMXAv;*hV1Wm$<8dtCYs1tO{Mm~~-=ZGxa
z<BEpgVQ6uMk)*A4Qbe7gH5*}xprDP>jpj-e9%`|fX?zbQKeuJaBedlj?wn7H+zXnl
z+6N3On@wEY6ZY=Tcmf7X)L-B&?+<q+-wWQ|H=hOXuJ8}RyE}+CAdkP(XK2SI=J0*Q
z-CCqns+~DMS-yO9fgGs8S6}+Sm1w<YuP7ab3>M^(KWxa1Nj(DZ`~!MYOa>phK%U8T
zbfFM1nH*fK8zMQjS!g4|p|!;V8Z`BtS@y!IU|yFKn)JeIFwbQ2i_i|5tR_lP0~#_7
pnM$drU_4|p`G+?Pw?igvKsz+7r*-ESGZggRJRA2r@IJ6$-#>;G!0Z43

delta 1236
zcmZux&1(};5TBP#+z*pYV+<*_)IAj1YN_?B+bY<^rnX2aRgfZHEGbA2QZyn~#MXa6
z69zo>Q1McbLL?%ocu2)V4jv*F!CQ|xnnMLet@AeXqAU))otfYJy|4M$HK*Q{?-jj;
zzFD!24I_@VKv0a~RwP*{I_d3w;EB@E*7O6Uf;7sa>HGB{<AWFz$(R#rvRWEP#3-gj
z=kh_C&}d9dUxAJB?DWLN7i-UF5AA;Y{Ap&b@ba}>XUh-Cou=~6m1b2gB-#DFx9A!2
zLL__`q}b;tKwVy%#A+&d0)Qt2<9$E(n(OP#|HVGj;Vb(!Jnn^O9`m|=HV73ypSJ_~
z<O2|fJRcb5i6e}!D;#fWJy$=lXD}<ltX0Kge2VdkkAIHwS3Z8Z)X;Lmd_cFEA<8=5
z3>{6VtH|v2)99wz{?bNB7jqeM)ifG;D@Xo~6$*{frvJ5_f9#bOCr+W3+&Ha4qi9He
z`aFGZFXXa!K@5`_!U4;{c`Jrnfi7ItJ4G3v>4^@ll@B7dM5F9h@S~p4LQq9vBn42^
z6PgYw(n%q6kkCx1d)fjA=g8j=lUShHyjQ?)jZ>c0vk;|y1vK_lb*f|98Q<a9Dg1<I
z(5|Y4cw(IS{)}HEJVyHiUb5rMGWY&0-6zKXYT_~D{_L$X?yrs_<E<JZU&?zLa(}9t
z4i8YNglu-<^o7ju<$*=$zE^r^y%V@%J9s_Z7E|F+dJrFlk6Efc>H&Nc9x~NiEBHO^
znyS~TI1+KqRtw@1d8*G+xEXP+8h24Gh(97jmTIbc5YN~{ri!eCOSWrHa-1h|({^L3
qZ<NlUh`Ofw^Ne9S>WX$;ijJCP(|ap?q2JVD+=;fE1#ar668QsJ{<Wt7

diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
index c37275233a..d0817c58ce 100644
--- a/linux-user/riscv/vdso.S
+++ b/linux-user/riscv/vdso.S
@@ -14,6 +14,52 @@
 #endif
 #include "vdso-asmoffset.h"
 
+/* GNU_PROPERTY_RISCV64_* macros from elf.h for use in asm code.  */
+#define FEATURE_1_AND 0xc0000000
+
+#define GNU_PROPERTY(type, value)	\
+  .section .note.gnu.property, "a";	\
+  .p2align 3;                       \
+  .word 4;                          \
+  .word 16;                         \
+  .word 5;                          \
+  .asciz "GNU";                     \
+  .word type;                       \
+  .word 4;                          \
+  .word value;                      \
+  .word 0;                          \
+  .text
+
+/* Add GNU property note with the supported features to all asm code
+   where sysdep.h is included.  */
+#undef __VALUE_FOR_FEATURE_1_AND
+#if defined (__riscv_zicfilp) || defined (__riscv_zicfiss)
+#  if defined (__riscv_zicfilp)
+#    if defined (__riscv_zicfiss)
+#      define __VALUE_FOR_FEATURE_1_AND 0x3
+#    else
+#      define __VALUE_FOR_FEATURE_1_AND 0x1
+#    endif
+#  else
+#    if defined (__riscv_zicfiss)
+#      define __VALUE_FOR_FEATURE_1_AND 0x2
+#    else
+#      error "What?"
+#    endif
+#  endif
+#endif
+
+#if defined (__VALUE_FOR_FEATURE_1_AND)
+GNU_PROPERTY (FEATURE_1_AND, __VALUE_FOR_FEATURE_1_AND)
+#endif
+#undef __VALUE_FOR_FEATURE_1_AND
+
+#ifdef __riscv_zicfilp
+# define LPAD       lpad 1
+#else
+# define LPAD
+#endif
+
 	.text
 
 .macro endf name
@@ -29,6 +75,7 @@
 
 .macro vdso_syscall name, nr
 \name:
+	LPAD
 	raw_syscall \nr
 	ret
 endf	\name
@@ -36,6 +83,7 @@ endf	\name
 
 __vdso_gettimeofday:
 	.cfi_startproc
+	LPAD
 #ifdef __NR_gettimeofday
 	raw_syscall __NR_gettimeofday
 	ret
@@ -86,6 +134,7 @@ vdso_syscall __vdso_getcpu, __NR_getcpu
 
 __vdso_flush_icache:
 	/* qemu does not need to flush the icache */
+	LPAD
 	li	a0, 0
 	ret
 endf __vdso_flush_icache
@@ -181,6 +230,7 @@ endf __vdso_flush_icache
 	nop
 
 __vdso_rt_sigreturn:
+	LPAD
 	raw_syscall __NR_rt_sigreturn
 endf __vdso_rt_sigreturn
 
-- 
2.44.0


