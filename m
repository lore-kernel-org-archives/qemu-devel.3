Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C139C3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Am-0001eg-QI; Thu, 25 Jul 2024 19:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Ai-0001OP-W2
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:57 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Ah-0005Qr-2R
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:56 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7044c085338so246709a34.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951213; x=1722556013;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLdx4AZXHbpEMxw/S18/9QimvuhK4hPq7UuREWO1i7w=;
 b=iicy5b5Y0h2tdbI3oFkOgOxX5dcB/BJTzunDfeqZCSvnBkGwW4A5PuwRVdZNmIuASa
 urlT+owMBvQPcFFezq61oPQll4Vh+fTakgl2C61sq+B9FNYEJJ1MpEdnPzG0OQebvU18
 MgYfz0orTz+z16R5Zu+fnI2yyHkPckI3by3fq0Z7/J27BAfnZTRcJutiPL5sIdZlhyKu
 AJfLSjnCI3guSf/M1BR9keryZ2nM01HuwsBDcLnoh0m0z81M2g2oxgRs0coRxxqtwZdD
 D6tLYxU+XYRjpS0CYBTdr1a8P9/CDobeYa2gdfxwlhL5+i81DYEtXKVqw+kZ4P71NQSf
 h4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951213; x=1722556013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLdx4AZXHbpEMxw/S18/9QimvuhK4hPq7UuREWO1i7w=;
 b=rOzU2hVion2I36hibT4+U9or3PPlWXd6pYL5fTcQ7ErwfZdtOiq7tTscu/SfwZYb3T
 zwkMd4uppxQCJwbtQEQktyFHfZ7msKhBOw0X9Ps5m9+4qotEcffLuSBDRs7h5lcRlxa9
 G5Sn1FhnKHQx2Cf1qZHAhWJy8tb2+dO0GxrnIKc8zsXgHt9DzU8rFqyvdtKk4XE2Q0JD
 L0FQyyEkcDn+2Tb3905fITs8uiByyuVsAoiYa2/QBVtPsKJIgYQZk7fXmGQmMf1/OdRo
 W9+rjIQqG/jhWhJBNWMx3w2DDvyAVr+YjxAAleuekKPjqDVlSSEdYY7S010nWZznbiOV
 BDng==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3Mro5yG+ZPO8OMGNAAS5OjF1ucZ92SFZcO3Lx3LMDT8Ch7gMXK9ybzCP1czBZDdKH0lz6LWi8kpztp0af0VQwuUJs2cw=
X-Gm-Message-State: AOJu0Yw9tLScZ0UYK8fo9PTr8vag//Tfrq6Qlau/irYPGULjmJP6iebY
 uQGlaf0bkDb5EjNrU4K+TjKZnBkcCXNYRmwM7n3uEkxtCVmvUp2y+dAoa6L+zFQ=
X-Google-Smtp-Source: AGHT+IHBqbzaE/MygE0CtW+tBZcsHjx9D7UsoT15uKwL8AL0fqgUxcff+xVuSnNUZP9cYqfeejzsyA==
X-Received: by 2002:a05:6830:631a:b0:703:64c6:305b with SMTP id
 46e09a7af769-70932117059mr5277601a34.2.1721951213574; 
 Thu, 25 Jul 2024 16:46:53 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:53 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 23/24] linux-user: Add RISC-V zicfilp support in VDSO
Date: Thu, 25 Jul 2024 16:46:12 -0700
Message-ID: <20240725234614.3850142-24-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=debug@rivosinc.com; helo=mail-ot1-x332.google.com
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


