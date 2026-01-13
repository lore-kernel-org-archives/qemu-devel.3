Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CE6D29DFE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 10:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfbFS-0000qf-T3; Tue, 13 Jan 2026 05:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vfbFJ-0000os-2A
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:03:32 -0500
Received: from mout.kundenserver.de ([212.227.126.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vfbFG-0006qV-0B
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1768298601; x=1768903401; i=laurent@vivier.eu;
 bh=U2ZUQMrbQNfSyQjK/+McwlZk747na2cO7PCOXdssNBw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=vKLz35QpWXhcBvvT6NYqjjzH/wzSdUygeFWV3Y8uwINXGhhlsA28RQag2ZcpKm3i
 f0KHPKoXsiVVwSqPhRWpggoyYC64u+e+VyPHZcZDCVX/gO0C5zg9MAHQEuOHbRiRx
 YuKVxklcViQLTXY37w+8HUDs6fZpwtnC1yi0CsTqbJ663aIqwe3kmGYVUZZ06hirC
 07lyIOim4TrvVp86oe4Ws8jYkGuxUkVBCjkbWI7//ao4XrZ0n0CVMS3ImvlN8Rrre
 IaB4D4st0hejqv1tK6J+6NmkI6/gh8JTWpnFfI2SVr7BmgB6ucyA3GAr0NjLvAhcB
 Zqhoj9kBrRzpGZTJpg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MEmMt-1vd8Ww1K3v-00AWJk; Tue, 13
 Jan 2026 11:03:21 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 William Hooper <wsh@wshooper.org>
Subject: [PULL 2/3] m68k: link.l is only available with 68020+
Date: Tue, 13 Jan 2026 11:03:19 +0100
Message-ID: <20260113100320.1009608-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113100320.1009608-1-laurent@vivier.eu>
References: <20260113100320.1009608-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:avMvrqW+E0aMR2npoP7pUqMIK2R3jvBp6+XXfwyoEDLEsE+zBO8
 BgUvLvQ3UXiSn1NMRLLAh6Zf8g/wFqh/vjbvyUedXtZernxwdqHdE0llFn8ZuY6Z6aClSN0
 P/ccOrtfNMfwxepbyONtlHaBpCeXjfWWSretalezbNtvXy99tXRWsSkecg5JnDJtKZFKrQ3
 7XjgRherX7qKxRuXoOPPA==
UI-OutboundReport: notjunk:1;M01:P0:N0FFXPXRdOI=;1aBPGFI/kSczUf+Lsa7SDQcy8nP
 CiWrevx7811CTNqkooXyx06ulQzV6Y7pGU+KDi/zjUTXhmsPxxWPQC9yBbz1z/eYULAKJjuYj
 2+5FshMJJfATSeqXUMDYVl1NqtiRMhWmF7jAib2ejdHRp+0uRg7qMjmRNeyyDtC9YZgOb6V/T
 j6l5bIr3u7SLbwymxTeVyeUwVfqdWPNaqK6xo/hoATWmbKQuvhkDr/O8nTIWB9QrKUdruFVsS
 Y+naBp9AjKv1I8YB9QvicOoEQW64pRQm2mHSquqZahaH6MiCoCwg+CQHcsr5G2EPEGNW/nCOm
 4BhTM2u5RCnJjn7NY5iwEN6L3EuUPb6USc+2Fqt7jV4wwtaJ5jrqNtgmI1ObsBgzNghxaNa5z
 jvyPi4aoYi1o+1rP9+mzAGjormlKUFqq7OGuBLDys621lY95YzXoeK4F2mjFWD3jawSLCZdnX
 wDGTmBpugiKj5PKI3V7Ndf+zpVCpQSE3EuHPBjijoJS6i0FyOsqe3J/lmvD2W9xIbSteNIOX/
 KIwrtZwNSmUEhgAh6n9EEJkKvi66cKYw01AxfeUuZn0DwapvwakdP1gku7Fd2a3vXjlk4UR7F
 hH/IT3EW7zJJaJXhKehn0LxBI7hoqisMdgWdJL6tk3junxaibe3WsVCMXjZ25WlMAdu4Q8ZJe
 2DZ0zXJDEIqn/BANzgPLtUROxgu4nAVPTl/ALa+IEyliWMJ8nzHX9wpfywaKdaZBf3Jn3Gomk
 SDwGM2AFLW7ULGw23ZIPvDlNmv2yzh5pCsi3HDqxTO5j9zdR1JNQmZL0ykoI0Kt+CvnAD2gdi
 tO1P7wjmKmxuTEHzkwnz6BetaMyzT3svjX/Ir9rI3w5pQaBm6aFxiff205bm0GDwO1H7zgqyu
 MgrfTwGEqL/SzmmERyVt6jNFbyDp1PwgHCD0pPf9X7DgrtzfGsmZvGFwZBvmUYBvTkOI1biYm
 7MRm3mJ70hML5yuVqlhu55r8ewPOnonMbOYpyRgVjgDUMmGxe1f5aIppZl+IHmYvNbfP7P+9H
 +0XlWdT9ateGgc7W4jQhNKz05bY8Ul4RnbSZ9rGwUcZoOaSCWQ8m3rlntMoJc+VG3bjDgmyDF
 n70kATMAAtGvYfIV/dCgxDe9JWZJJ9Mesx+aoKTIhHmyotCtqwRdV+NlzeLsuppbBONJ9Xmfo
 gys8Wr9XLqESPe1DwoaeY05CSjdHqjRq6X+BDMxzTcWQDavRDHIQA9CS9lyzkgaDsbtnCPpSw
 UUdIn0XdMBdlOx/mCH9MYsNwbQ/C3qsjANyWa6sVi2i6FA6Vyt7vaI59Qb6jnsgG9mZ1pQz76
 LHuMPBF0MOuScDGsIlDz7b6OWM7GOb1A98nwG9aYi1EtZ05R44vKJWT3fuNIK5MPlfnv9KcTU
 ERAHhyWraw3/8LW811nnRYaEn43vJC3nUCEfaS2K+4D/EUFjayBvSEobe9uNKrBY7ivcGgbQ4
 Q/4bQ26Bh33n2KnNKmMFxNAV0vbi6hhNzzGSVIR30AxNHD2DY0WKUQI+8HtdVMdEoiQ7FaFWC
 cZW3773FLAvjCPlcBzL7/jxyCEw6LCaKb2baMdu3vkFzq1hrsZRwwyDq6xhw+HGTNIHCnfQmc
 bn7rzF/mpjQCHhVvxB8vMJA2IDYWoMnjq3IRWjftvDxO7WC1GtLBuyxE1rnXEIH/4MTWBH4VT
 axFdxdRvhLxRrRZD4WpKZZCHPxftDLeP8wla8a5OYzouJE4aAgM7ZV2HztCzn2KlkyxcPOwvn
 4TB1C6uUW3X2DRT3LzmPhDUPJwHAjD8F5LNXxY5cEFy37qFgVdvpwM/E=
Received-SPF: pass client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Base 68000 only supports word size.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: William Hooper <wsh@wshooper.org>
Message-ID: <20251227210250.411882-1-laurent@vivier.eu>
=2D--
 target/m68k/cpu.h       | 2 ++
 target/m68k/cpu.c       | 3 ++-
 target/m68k/translate.c | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d9db6a486a80..7911ab9de30a 100644
=2D-- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -555,6 +555,8 @@ enum m68k_features {
     M68K_FEATURE_MOVEFROMSR_PRIV,
     /* Exception frame with format+vector (from 68010) */
     M68K_FEATURE_EXCEPTION_FORMAT_VEC,
+    /* LINK.L (680[2346]0, and CPU32) */
+    M68K_FEATURE_LINKL,
 };
=20
 static inline bool m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f1b673119d6b..b55e604b11d1 100644
=2D-- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -235,7 +235,7 @@ static void m68010_cpu_initfn(Object *obj)
=20
 /*
  * Adds BFCHG, BFCLR, BFEXTS, BFEXTU, BFFFO, BFINS, BFSET, BFTST, CAS, CA=
S2,
- *      CHK2, CMP2, DIVSL, DIVUL, EXTB, PACK, TRAPcc, UNPK.
+ *      CHK2, CMP2, DIVSL, DIVUL, EXTB, LINKL, PACK, TRAPcc, UNPK.
  *
  * 68020/30 only:
  *      CALLM, cpBcc, cpDBcc, cpGEN, cpRESTORE, cpSAVE, cpScc, cpTRAPcc
@@ -260,6 +260,7 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_MSP);
     m68k_set_feature(env, M68K_FEATURE_UNALIGNED_DATA);
     m68k_set_feature(env, M68K_FEATURE_TRAPCC);
+    m68k_set_feature(env, M68K_FEATURE_LINKL);
 }
=20
 /*
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index eb1ba150745e..78efa3e597c4 100644
=2D-- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5829,7 +5829,7 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(move_to_sr, 46c0, ffc0);
 #endif
     INSN(nbcd,      4800, ffc0, M68K);
-    INSN(linkl,     4808, fff8, M68K);
+    INSN(linkl,     4808, fff8, LINKL);
     BASE(pea,       4840, ffc0);
     BASE(swap,      4840, fff8);
     INSN(bkpt,      4848, fff8, BKPT);
=2D-=20
2.52.0


