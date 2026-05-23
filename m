Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541A8CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 11:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQkji-0001VW-4v; Sat, 23 May 2026 07:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wQkjg-0001Tj-AJ
 for qemu-devel@nongnu.org; Sat, 23 May 2026 07:41:44 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wQkjd-0002Nm-2Y
 for qemu-devel@nongnu.org; Sat, 23 May 2026 07:41:43 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7bdaa68cf81so76025257b3.3
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779536498; x=1780141298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Msc5LSWizU6tH7NqZcqe7tCVPrgnN5d20AzGgpeCpac=;
 b=cCOnAexoI3d420nUXFPCmWqx4OlWi/+/gu9JSw9HVncHQ14iP8KWG9eSRwyQt53yRk
 ZS40c/+xmtyB1rGGMbX4109sGrs7k0LlzE1aXxlrL7jJtoMTC/rvyB7awBjdONDR3ij1
 40Mb2CafZ43Vi1cAosfcgJhdWFriFbGianB6DWSj2Ylvdb0w3aQFSO7imUQLcWfu5zhO
 VW6HR8YUth+Evig5oswAgcnATRSv1n9JYrCUGZJwfxV/jKm3nGevI7fFeShA9VkbekKA
 J096n1PVIh5lLGNTSAl72ufuaoxl9GLyHS3SX4V1SQZlihf45Rgvf1qbBcG3VH/m9TC3
 6EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779536498; x=1780141298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Msc5LSWizU6tH7NqZcqe7tCVPrgnN5d20AzGgpeCpac=;
 b=LE66hbZk8RfSLfX7bbiTCCfWtRrP4eC+WwNILJ3t3qYJmifpRWfwo6tZgEwXqVEXvI
 ota7jWw6753d5y14otJHRKIvKlTqTQEbZ4C+V5D+FlzYOQTbQnxIhhLwghiJBDl30ErF
 s8gleKyq251RuXh91VjsGjI7lwf5wOXaaI0Jzob4W/t+ENDJr/DZgJBH7PZPkTBje/V9
 VEdHNk/fJ2JvA6B1sUe43K6vDnAVLdmUMjv/HpaJtmczyhvVxQYrMnfNnMPZd2vAql7U
 b0fl3uh8PQxZwZnlxAxrTQ2MPz8OnzVyRfpRlKAUSekeG1duXV4+oY7EowmvKK1Ze2UM
 I77A==
X-Gm-Message-State: AOJu0Yz6R4lhymLbKBxlIPjQULiV9dxf8Jiu77ibyGwfa8HmxnUTksYZ
 rVMRBPsUhlWvoIspVH5g7LSrJ7RLr7utZYkjZb+Mx7yG1EQ8ZRALUWBxax8gKUpd
X-Gm-Gg: Acq92OGe8L37vUvL7wqTxHISaooIzZkpKmHtA5/qJH9w7CYXJfaJT5TRF33e+D4h1lL
 LLcPnpv48UOBIKMhSi+Cdwvj3B82tpS9JIYyGXaNRqX4GRJ4lVgU8oqBdnImUxYL5bio3Nr6J+l
 RCLwq0wgQmh6SI+VduzCE/GDGzeWMypvY/toi/hB3crbW5jvCgLB7sVwfzC7z7aUqLAgysOF31S
 Ch16fvOnzGIHQ0Js8dihfQRfgcFiYeoooC4E6bxwlJHfpnlSrvGkWUfvlMkl+P7af7L1mVk940F
 exkAmn+UDpxbBw0msX46CQg/7fUc8A+LVopd62pSmMzkuKSxVhkW+8/0An8I+ubv++Wy0T+cKGT
 +Z1z2UbS7p7z+cz4yFQVUgsmz2n1uW5gKGSfZ68nFVJoAZEFotxKFdmmZxpNyVR60CB1h6R1/Nb
 M79NhnN1/Y6+rQ9suAFKDDpJtPlokxNwRDkgb6RvCDQgGobVKk/olzR61esciKlhqIf21LoF824
 fduFz78dQOE4/qjBnqR3EqY
X-Received: by 2002:a05:690c:6d08:b0:7b2:64f4:a2c0 with SMTP id
 00721157ae682-7d337fa02ecmr82972977b3.5.1779536498194; 
 Sat, 23 May 2026 04:41:38 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d389e1291asm20807517b3.12.2026.05.23.04.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 04:41:37 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH] linux-user/sh4: add VDSO support for sh4 and sh4eb
Date: Sat, 23 May 2026 07:41:28 -0400
Message-ID: <20260523114128.2468754-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Provides replacement VDSO with sigreturn trampolines
(__kernel_sigreturn, __kernel_rt_sigreturn) and syscall stubs
(clock_gettime, clock_gettime64, clock_getres, gettimeofday).

Both LE and BE blobs are committed and selected at compile time via
TARGET_BIG_ENDIAN. The BE variant requires an sh4eb-unknown-linux-gnu
toolchain; sh4-unknown-linux-gnu does not support -mb.

CFI register numbers follow GCC's SH_DEBUGGER_REGNO:
PR=17, GBR=18, MACH=20, MACL=21, FPUL=23, FPSCR=24, FR0-15=25-40.
---
 linux-user/sh4/Makefile.vdso    |  18 ++++
 linux-user/sh4/elfload.c        |  14 ++++
 linux-user/sh4/meson.build      |  12 +++
 linux-user/sh4/target_elf.h     |   1 +
 linux-user/sh4/vdso-asmoffset.h |  45 ++++++++++
 linux-user/sh4/vdso-be.so       | Bin 0 -> 2704 bytes
 linux-user/sh4/vdso-le.so       | Bin 0 -> 2704 bytes
 linux-user/sh4/vdso.S           | 142 ++++++++++++++++++++++++++++++++
 linux-user/sh4/vdso.ld          |  67 +++++++++++++++
 9 files changed, 299 insertions(+)
 create mode 100644 linux-user/sh4/Makefile.vdso
 create mode 100644 linux-user/sh4/vdso-asmoffset.h
 create mode 100755 linux-user/sh4/vdso-be.so
 create mode 100755 linux-user/sh4/vdso-le.so
 create mode 100644 linux-user/sh4/vdso.S
 create mode 100644 linux-user/sh4/vdso.ld

diff --git ./linux-user/sh4/Makefile.vdso ./linux-user/sh4/Makefile.vdso
new file mode 100644
index 0000000000..272c5d262d
--- /dev/null
+++ ./linux-user/sh4/Makefile.vdso
@@ -0,0 +1,18 @@
+include $(BUILD_DIR)/tests/tcg/sh4-linux-user/config-target.mak
+
+SUBDIR = $(SRC_PATH)/linux-user/sh4
+VPATH += $(SUBDIR)
+
+all: $(SUBDIR)/vdso-le.so $(SUBDIR)/vdso-be.so
+
+LDFLAGS = -nostdlib -shared -Wl,-h,linux-gate.so.1 \
+	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
+	  -Wl,-T,$(SUBDIR)/vdso.ld
+
+$(SUBDIR)/vdso-le.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC) -o $@ $(LDFLAGS) -ml $<
+
+CC_BE = sh4eb-unknown-linux-gnu-gcc
+
+$(SUBDIR)/vdso-be.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC_BE) -o $@ $(LDFLAGS) $<
diff --git ./linux-user/sh4/elfload.c ./linux-user/sh4/elfload.c
index ddf2aaaed7..f03ce49e7d 100644
--- ./linux-user/sh4/elfload.c
+++ ./linux-user/sh4/elfload.c
@@ -5,6 +5,20 @@
 #include "loader.h"
 #include "target_elf.h"
 
+#if TARGET_BIG_ENDIAN
+# include "vdso-be.c.inc"
+#else
+# include "vdso-le.c.inc"
+#endif
+
+const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags G_GNUC_UNUSED)
+{
+#if TARGET_BIG_ENDIAN
+    return &vdso_be_image_info;
+#else
+    return &vdso_le_image_info;
+#endif
+}
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
diff --git ./linux-user/sh4/meson.build ./linux-user/sh4/meson.build
index 3bc3a6924a..611bce050b 100644
--- ./linux-user/sh4/meson.build
+++ ./linux-user/sh4/meson.build
@@ -3,3 +3,15 @@ syscall_nr_generators += {
                    arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                    output: '@BASENAME@_nr.h')
 }
+
+vdso_le_inc = gen_vdso.process('vdso-le.so',
+                               extra_args: ['-s', '__kernel_sigreturn',
+                                            '-r', '__kernel_rt_sigreturn',
+                                            '-p', 'vdso_le'])
+
+vdso_be_inc = gen_vdso.process('vdso-be.so',
+                               extra_args: ['-s', '__kernel_sigreturn',
+                                            '-r', '__kernel_rt_sigreturn',
+                                            '-p', 'vdso_be'])
+
+linux_user_ss.add(when: 'TARGET_SH4', if_true: [vdso_le_inc, vdso_be_inc])
diff --git ./linux-user/sh4/target_elf.h ./linux-user/sh4/target_elf.h
index d9e253d425..3fcb63d409 100644
--- ./linux-user/sh4/target_elf.h
+++ ./linux-user/sh4/target_elf.h
@@ -15,6 +15,7 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_CORE_DUMP      1
+#define HAVE_VDSO_IMAGE_INFO    1
 
 /*
  * See linux kernel: arch/sh/include/asm/elf.h, where
diff --git ./linux-user/sh4/vdso-asmoffset.h ./linux-user/sh4/vdso-asmoffset.h
new file mode 100644
index 0000000000..8ca96dce16
--- /dev/null
+++ ./linux-user/sh4/vdso-asmoffset.h
@@ -0,0 +1,45 @@
+/*
+ * Offsets into target signal frames for sh4 vdso.
+ *
+ * From linux-user/sh4/signal.c:
+ *
+ * struct target_sigcontext {
+ *     target_ulong oldmask;           //   0
+ *     target_ulong sc_gregs[16];      //   4
+ *     target_ulong sc_pc;             //  68
+ *     target_ulong sc_pr;             //  72
+ *     target_ulong sc_sr;             //  76
+ *     target_ulong sc_gbr;            //  80
+ *     target_ulong sc_mach;           //  84
+ *     target_ulong sc_macl;           //  88
+ *     target_ulong sc_fpregs[16];     //  92
+ *     target_ulong sc_xfpregs[16];    // 156
+ *     unsigned int sc_fpscr;          // 220
+ *     unsigned int sc_fpul;           // 224
+ *     unsigned int sc_ownedfp;        // 228
+ * };                                  // sizeof = 232
+ *
+ * struct sigframe    { sigcontext sc; ... }
+ * struct rt_sigframe { siginfo info[128]; ucontext uc; }
+ *   ucontext = { flags[4], link[4], stack[12], sigcontext mcontext; ... }
+ *   => mcontext at rt_sigframe + 128 + 20 = rt_sigframe + 148
+ */
+
+/* Offset of sigcontext within sigframe (CFA base for sigreturn). */
+#define SIGFRAME_SC_OFFSET      0
+
+/* Offset of tuc_mcontext within rt_sigframe (CFA base for rt_sigreturn). */
+#define RT_SIGFRAME_SC_OFFSET   148
+
+/* Offsets within struct sigcontext. */
+#define SC_GREGS    4
+#define SC_PC       68
+#define SC_PR       72
+#define SC_SR       76
+#define SC_GBR      80
+#define SC_MACH     84
+#define SC_MACL     88
+#define SC_FPREGS   92
+#define SC_XFPREGS  156
+#define SC_FPSCR    220
+#define SC_FPUL     224
diff --git ./linux-user/sh4/vdso-be.so ./linux-user/sh4/vdso-be.so
new file mode 100755
index 0000000000000000000000000000000000000000..4f50143f8284ab63693c1117e68f3efa886155e3
GIT binary patch
literal 2704
zcmbtWO>9(E6uxh!?MzF5=8~dd5nHK98krQ*5Qr=~r7cq}#gsM(qK{$bb!KQgQ{TLn
z77@B2rp81-jbUMohHf#9D@{mTm?#=!OlVvfV_0Y;h6OG(CjQj#yYJrV>(9n`Cf}U%
zoqOK>Kj*!RJ^j5_$P#4<i#FKC(IG@Mrg(>F7L{VBh=~U9DgbR|ya$`8&@j(~QY!BH
z5E0#T2+ltOxB{C{&u6@!o)IFPTSj>t(?9iM0IjfzV0$BY_|U+xn0WixMEBD(pM3Xz
zYX0+AKHj~*?%ojE>VXUXGoi-f(m%fm5lVtrLeD{CjTUtca1Gc1#EMHxf1%rU=)b|a
zj%`2`{7+~L`aas5VgFxAU^%zYN$o}edKdW30Dk~{A;5>hzXh++@j382;8D$SCKdC6
z_}5`8kz(mr7(5RnVHi<>`$^$>Qz8J*mg{B=1^cCh+_Y7-L^nldqtQ<7V@zbB=}VDo
zzdTs?(KlUh%zpLr)#=N>6b@eBvg5P1*Mx0PWlBXmJyuMQ+F8f*^5f3B&b=LL+^$nH
zKK*2IB$JwfZ`5%M&X`@wXI;mebPLNa*9&;Z@`cIiUD=f9#7o8aZqeU2F#N2&C%zZc
z##)0v3v0x$;p_WX(Z)Nr72rKGtGB`*O#TkWHj3J3t10{>>~;WqVI6=@LIdI?H1FdC
z^eN~|&|^R=>=+=dbAuvuURq7HOg-h>41Evay`V7e3E)Q{=<5XkewB}7Ee3pZusOz2
z3=&g=NO4hG7i8#V89py7UXqpPWYvs}Ov~t5Sv@6dCglcC)|O<QE9+mB4HGg}l(HZ<
zj>*PRx#^7Dl9vzVWK&jd9gz<^a$80|l9tV<WlKsvdP;7$W$O#_vFGKElk)NB<jxcF
z!KB>W$62U7y8_**?B4pfc%g1vpT>}V)tF^<z<x7e*DTv&K=@IJ7iVt^JS)TvU_IeJ
z@FH^<ipl|S-fxJ?f41{(Lqg065}g;JM$L5&sQSTnoiD16kTY)};b!&k=N5Up=A0{p
zHBa@=nnUXy_3zgnm@0qSAJ5p#8Iw`@3!ln=KEn3x;CD$N=1wT0<M)B6^;-V(2{S(Y
z93S_@U$1UIqaMbet`{EqzXfXQ(;WC6a8qyI1-}_+{}6m3z`p>W5AYwrm+MzL?Vi|w
zJd=$VMLBzI*U9FK1-s;>TyL%0DP)A*eS9EsxbGkm9i`vyN!q=GiNig1vU^b2hx(6n
zCHn0ny}d_!hU}q4SAUNk$aP(U)-NF|>c#3}6(~R}3fMZeO4qeDg-OIqGvi+BG_>dX
zI%ljx(Q`yRGgC;7=hMnSEOg3CiFmd!8PBCkIp6QOzGupDOW3Lv#LkGgle0(M)VO2k
zGKe%x#64#k=lP$c3DLaQ%#}qA)+{4BM??!8%m-ZC@;je7u5&`=QWU%m;5!!mG4E9F
z&4QbE4*O#+?*VxC(I4-px}(AS%{bx!z`R6%%u|)C9pIb?#l-EyJDc^IaY-Md6MS`C
zm-aCZ^HaHf4L&0#AD=>hOK>7C-0VZm+w=!N+r%-%>2C<u0aXi_lV(pjKgtNezS&>S
zhx#638^y%&{7f9`25X0f{V9uy<GYG+I1}cd%E9h()N+5iFVn(WVljXD-Gu#A<MKRM
dyUf~PR&h`GJz<3XP$UqDi@XYci49s*+`neGdi4MR

literal 0
HcmV?d00001

diff --git ./linux-user/sh4/vdso-le.so ./linux-user/sh4/vdso-le.so
new file mode 100755
index 0000000000000000000000000000000000000000..c41cb5831b9e5883a64564da8b2149a33e199f4f
GIT binary patch
literal 2704
zcmbtWO-x)>6u!einE?uO8mg_d6)e_<*a<e+nAinF`579ZhJseDzD{QzGsDkJee;F_
z)|N#V7!%v73l@#h=*C4G;=;Iar!i`bF|oQbrimJV;-WRNG4Th#@7;ItQD$M{As^>_
z=brn2&v|pMZ>T>M3MnID)u9aQf-@FT9`91Esz&WqG1a6t!Ou2>*I*OXK1_d5PkuxL
zQR}ggs)GJKfQzsR)Bln0-Apd5l!2MYv{PRTpdB_5Y;Oj~5Ncp#T$Qi1?|kR#>kHqO
zejS$ap9bFg@`Ij6w4L?)G-E-({k>XDLf62z1kF7zVIy_W%RoI41O8lHEp}qyzo5B~
zT>y?q{Q=H>-+*rA#Q#$g=>HKm)BwE&|Mx+^7vOh*uLSrw_*dXuFXMC2*TK0qa<1*o
zK>Ul~Mnv6Q<$W08^4SmJp71Ovyg!b^eVZ-vyeQ<Rjq$ZxBW>N0$Rd4=@$UYUmX*;9
zow=UR-`)Jfr;9KBd|~d=_BRd{Ug-F6kFu=UOsQz4r;F(+D{H%Me#WloJkYhl?bs#b
z^LrL2GO2m^rfjERPg|vY*0J5PQ~1~AxB>5UzEGaqmrc2Lyi|-opoRuV#*bP1;|H+v
zs&#)M?2><%ZhY3nH?{-dJEG|Qht#d|)iB#A=A1(<;fFiHc@_r|n1oJ3ABP@;J_UUO
z`aJYBbUVQJMhPv9s;V;*YH4WleB0pr1>oDDFz$ZfJ0R%m2LJjt-x&C{fNu#l1#=w5
zBr$IiQRgIdR;r$p@ENIoR%#Yx)4bHqN#wLdXQi$z^{zCOWV0iU&q&iLi4{c(vSnJD
zr)2A-Y|qPGIcdqtjtSXm%dU*votD;<(w35YPRMRc+MkwtpOQVt<-R9n?-O!oQnn2$
z#WTAIbOYY`^*6qPV^E<lV(-_hsEUFZ`{jUL7qCYVAN8W5>NISHzE`L#2+x5M_HIts
zB+dE4b^dFvUwcHm5wA0Ybwju7EMWc6TxSgHh~~QTwfadD_OeSU))Czv^)&09=FDQH
zF0XM`ADzF{VLzW~Q>u}_ym#immIk#O25YY2#-e8YL(nGYL*NN;Ge4`y7`WLl+b6+|
zuwJ+z!TQ8^bRF}tZm{0G3LUIhZ-WQx)yLq$dh`u=uzsm@dj9Z(#~z)G7u8z!T8^E~
z7YkO&O*!sHw_V66tM~Dd#PHxDBsxmJ)t9vTM-#(+R<d_gSp!2ydJ;p{k^cUpePh;G
zqGzbj3go(9f-0Agb@k%*VihPr>k3$fTIJWZ4TVX?OY<{s>Lj%5Xq_`wq3GHwo|!MC
zX7XvzKrD31O{sXcP>$zPrJVM=j`qyjP6<b~j#wELw{zBnlbW%uTn3Sbskm#;@k;-*
zv>=kNnopd0M6?4&%+qUwgW15R%=bnx$8|>NZw%i|2f$a(@%Y^(7GX0ECf=;BbNhYH
z@%TOoQ}f{R;uw1nU{-QG<|)wy+fS*rIOf4E|686!4AEU7uE+PG+53I41Y;St5w4MP
z7+CekW4;rt&t_isCmsXLZwS@_f@?8nYR+#0K90>k!QVrmo|rgZo{3}KAR=Z_XftvA
zR?*EnVg3=lu#K2FGnVnQmaM?Z-%ZT`<G3$YE=;v1%NY3P8q;%;3J{EY9veMhA?_a}
CxqF)c

literal 0
HcmV?d00001

diff --git ./linux-user/sh4/vdso.S ./linux-user/sh4/vdso.S
new file mode 100644
index 0000000000..4fb5ee9d31
--- /dev/null
+++ ./linux-user/sh4/vdso.S
@@ -0,0 +1,142 @@
+/*
+ * sh4 linux replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+#include "vdso-asmoffset.h"
+
+	.text
+
+.macro endf name
+	.globl	\name
+	.type	\name, @function
+	.size	\name, . - \name
+.endm
+
+/*
+ * SH4 syscall convention:
+ *   Syscall number in r3 (caller-saved, so no save/restore needed)
+ *   Arguments in r4-r7
+ *   Return value in r0
+ *   Syscall instruction: trapa #0x10
+ */
+
+.macro vdso_syscall name, nr
+\name:
+	.cfi_startproc
+	mov.l	1f, r3
+	trapa	#0x10
+	rts
+	nop
+	.align	2
+1:	.long	\nr
+	.cfi_endproc
+endf \name
+.endm
+
+vdso_syscall __vdso_clock_gettime, __NR_clock_gettime
+vdso_syscall __vdso_clock_gettime64, __NR_clock_gettime64
+vdso_syscall __vdso_clock_getres, __NR_clock_getres
+vdso_syscall __vdso_gettimeofday, __NR_gettimeofday
+
+/*
+ * Signal return trampolines.
+ *
+ * For sigreturn: r15 points to struct sigframe; sigcontext is at
+ *   offset SIGFRAME_SC_OFFSET (0).
+ * For rt_sigreturn: r15 points to struct rt_sigframe; sigcontext is at
+ *   offset RT_SIGFRAME_SC_OFFSET (148).
+ *
+ * A single CFI region covers both trampolines.  The CFA is set to the
+ * start of the relevant sigcontext; all register offsets are then
+ * identical for both trampolines.  Between the two trampolines we use
+ * .cfi_def_cfa_offset to update the CFA base for the different layout.
+ */
+
+/*
+ * Start the unwind info at least one instruction before the signal
+ * trampoline, because the unwinder will assume we are returning
+ * after a call site.
+ */
+	.cfi_startproc simple
+	.cfi_signal_frame
+	.cfi_return_column 16		/* return column is PC */
+
+	/* CFA = r15 + SIGFRAME_SC_OFFSET = r15 (sigcontext base, sigreturn). */
+	.cfi_def_cfa		15, SIGFRAME_SC_OFFSET
+
+	/* Integer registers r0-r15: sc_gregs[n] at sigcontext + SC_GREGS + n*4. */
+	.cfi_offset		0,  SC_GREGS + 0  * 4
+	.cfi_offset		1,  SC_GREGS + 1  * 4
+	.cfi_offset		2,  SC_GREGS + 2  * 4
+	.cfi_offset		3,  SC_GREGS + 3  * 4
+	.cfi_offset		4,  SC_GREGS + 4  * 4
+	.cfi_offset		5,  SC_GREGS + 5  * 4
+	.cfi_offset		6,  SC_GREGS + 6  * 4
+	.cfi_offset		7,  SC_GREGS + 7  * 4
+	.cfi_offset		8,  SC_GREGS + 8  * 4
+	.cfi_offset		9,  SC_GREGS + 9  * 4
+	.cfi_offset		10, SC_GREGS + 10 * 4
+	.cfi_offset		11, SC_GREGS + 11 * 4
+	.cfi_offset		12, SC_GREGS + 12 * 4
+	.cfi_offset		13, SC_GREGS + 13 * 4
+	.cfi_offset		14, SC_GREGS + 14 * 4
+	.cfi_offset		15, SC_GREGS + 15 * 4
+
+	/* PC (return column). */
+	.cfi_offset		16, SC_PC
+
+	/* Control registers. */
+	.cfi_offset		17, SC_PR
+	.cfi_offset		18, SC_GBR
+	.cfi_offset		20, SC_MACH
+	.cfi_offset		21, SC_MACL
+
+	/* FP registers fr0-fr15: sc_fpregs[n] at sigcontext + SC_FPREGS + n*4. */
+	.cfi_offset		25, SC_FPREGS + 0  * 4
+	.cfi_offset		26, SC_FPREGS + 1  * 4
+	.cfi_offset		27, SC_FPREGS + 2  * 4
+	.cfi_offset		28, SC_FPREGS + 3  * 4
+	.cfi_offset		29, SC_FPREGS + 4  * 4
+	.cfi_offset		30, SC_FPREGS + 5  * 4
+	.cfi_offset		31, SC_FPREGS + 6  * 4
+	.cfi_offset		32, SC_FPREGS + 7  * 4
+	.cfi_offset		33, SC_FPREGS + 8  * 4
+	.cfi_offset		34, SC_FPREGS + 9  * 4
+	.cfi_offset		35, SC_FPREGS + 10 * 4
+	.cfi_offset		36, SC_FPREGS + 11 * 4
+	.cfi_offset		37, SC_FPREGS + 12 * 4
+	.cfi_offset		38, SC_FPREGS + 13 * 4
+	.cfi_offset		39, SC_FPREGS + 14 * 4
+	.cfi_offset		40, SC_FPREGS + 15 * 4
+
+	/* FPUL, FPSCR. */
+	.cfi_offset		23, SC_FPUL
+	.cfi_offset		24, SC_FPSCR
+
+	nop
+
+sigreturn_region_start:
+__kernel_sigreturn:
+	mov.l	1f, r3
+	trapa	#0x10
+	.align	2
+1:	.long	__NR_sigreturn
+endf __kernel_sigreturn
+
+	/* Update CFA base for the rt_sigreturn frame layout. */
+	.cfi_def_cfa_offset	RT_SIGFRAME_SC_OFFSET
+
+__kernel_rt_sigreturn:
+	mov.l	2f, r3
+	trapa	#0x10
+	.align	2
+2:	.long	__NR_rt_sigreturn
+endf __kernel_rt_sigreturn
+sigreturn_region_end:
+
+	.cfi_endproc
diff --git ./linux-user/sh4/vdso.ld ./linux-user/sh4/vdso.ld
new file mode 100644
index 0000000000..3a6cb65d08
--- /dev/null
+++ ./linux-user/sh4/vdso.ld
@@ -0,0 +1,67 @@
+/*
+ * Linker script for linux sh4 replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+VERSION {
+	LINUX_2.6 {
+	global:
+		__vdso_clock_gettime;
+		__vdso_clock_gettime64;
+		__vdso_clock_getres;
+		__vdso_gettimeofday;
+		__kernel_sigreturn;
+		__kernel_rt_sigreturn;
+	local: *;
+	};
+}
+
+PHDRS {
+	phdr		PT_PHDR		FLAGS(4) PHDRS;
+	load		PT_LOAD		FLAGS(7) FILEHDR PHDRS; /* FLAGS=RWX */
+	dynamic		PT_DYNAMIC	FLAGS(4);
+	eh_frame_hdr	PT_GNU_EH_FRAME;
+	note		PT_NOTE		FLAGS(4);
+}
+
+SECTIONS {
+	. = SIZEOF_HEADERS;
+
+	/*
+	 * The following, including the FILEHDRS and PHDRS, are modified
+	 * when we relocate the binary.  We want them to be initially
+	 * writable for the relocation; we'll force them read-only after.
+	 */
+	.note		: { *(.note*) }		:load :note
+	.dynamic	: { *(.dynamic) }	:load :dynamic
+	.dynsym		: { *(.dynsym) }	:load
+	.data		: {
+		/*
+		 * There ought not be any real read-write data.
+		 * But since we manipulated the segment layout,
+		 * we have to put these sections somewhere.
+		 */
+		*(.data*)
+		*(.sdata*)
+		*(.got.plt) *(.got)
+		*(.gnu.linkonce.d.*)
+		*(.bss*)
+		*(.dynbss*)
+		*(.gnu.linkonce.b.*)
+	}
+
+	.rodata		: { *(.rodata*) }
+	.hash		: { *(.hash) }
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }	:load :eh_frame_hdr
+	.eh_frame	: { *(.eh_frame) }	:load
+
+	.text		: { *(.text*) }		:load
+}
-- 
2.53.0


