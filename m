Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F6DC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 01:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Bv8-00034M-Sz; Tue, 22 Sep 2026 21:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Bv7-00034D-Iq
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 21:37:13 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Bv6-0003CT-14
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 21:37:13 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66c9995ca60so921421d50.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790127430; x=1790732230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cEWYnH3TMMK5zE9hOM2D/f9Ix86X/hO+O6crdyJWTDs=;
 b=nkSKSd2eljo6fHe6YfH4W7gpsI7KQIQHe4D/JFcAfAxu/ZBZUiR2MInZZs7NG7NcST
 Ce1f+5AsEL+8kiik5IEVByvvPLbc+xw1vlMshetJnuwMIu6pcy3hxHad+kWfr0DvwaqW
 Kbz22jJ7gDtQOwoYjZWrk1MC4Ba2tIpMUDhhZIwLPKs22Ju4cKrnXtgZhRmsZie9Gik4
 5bHyT4UCnLNa5HpNLj0wQvGrtCuzzjrrtxWkKI6vFVTtZP6MXt9TFZSqWaO/HduijdBg
 mHXrRL9XbwChxtZMf8R3YwgTkl0MZ2liI+KMML3z2v5waOeUHiZiRXeIRX1Z0oLNwPVL
 Xmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790127430; x=1790732230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cEWYnH3TMMK5zE9hOM2D/f9Ix86X/hO+O6crdyJWTDs=;
 b=mshUzdNkPFJ/pOwtSVez+uv7/Xo+eYodsVnh77IPfkLOmBwywTqED4NGlx5K3C7zGn
 4lPDmLXVPSKXsl5wx9ZprPsL/PgJCXennMYlRs7qT3y79gXiuYcmEO4p892eeEATeg9l
 YoWbbPrdLEdBk52WwZO6j+m0V2uv7po5Lgw56E0ugMFfoIt1J1veZ1ygt6fpelXBIByg
 AOmwpAC6F14VW8YDerojKfoAIj6nX3fVR2m/wuopLuQQXIb2MMQlxLFucRFzjWzSddiG
 taHUypjXRVemB9y9Em0EYdu5fdu+9pGYldshetKV3v6ZmGX+iw0VoPIPC7W5kwv7Dmqc
 7Wsg==
X-Gm-Message-State: AFuF++kNcWBwc6EPv3gSdtqEgM9U41QSQorjEC+Hb2UYcXuIPhhQWIfY
 gutyxEThjVcY8WTkm52s2bQwnYSGmCPPhx9G37U80PgcBOzwWLqKvmzGDm9nbbxl
X-Gm-Gg: AYBFou0aeedPlQ7enBwoMhYwGzCarhBxh0y5mOQQP3+bLn0dcmWjaasih2A0IGBw+3B
 BlpEsP8PeZAI+9iQVQGOZdxSvAm2p3kn5FhCSlVZt9d5UT5z3lyZLNSe9RxyiW0e+xA1el0v+5t
 /iZIJS/RWYpT1A7MrwiaEY9d1+Bvced1n8PBNB3MFfK9rKhiTMAbu3LriGa8uA9Fc9wwlHHTeWI
 j/NiSRV9d+F05Vcb+iK3JnK2yn4zZDV3FzGP3F8HUntaMhNP2vhCekiQzRvAz/3+f/MKXK6coM1
 RirMNB1KKVoXoGUWsZcBQzIp45PLJP4/aX/2A0qY4UdDiip41QlzwU9u5ughGm6XlKNPGxgJIwX
 gjrTIyuoaH+AtPAv6vkes/eENHILaWQ5M9CmD0jyD2aSF5Bm+NhXA8DLON4u4VUSAMgLzuwhbYD
 /5S9YLd0LNmmrtuuDBF8tn17U8TePStVSDtzxZl6BRztGAqnhZSZnw/3Gh0BP1Gx/VUkn7XPY=
X-Received: by 2002:a05:690e:144b:b0:66f:c1bc:4060 with SMTP id
 956f58d0204a3-672c2b37d92mr2446644d50.40.1790127430431; 
 Tue, 22 Sep 2026 18:37:10 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d81e4978sm367110d50.20.2026.09.22.18.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 18:37:09 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH 3/3] linux-user/sh4: align the vdso sigreturn trampolines
Date: Tue, 22 Sep 2026 21:37:00 -0400
Message-ID: <20260923013700.1505113-4-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923013700.1505113-1-mattst88@gmail.com>
References: <20260923013700.1505113-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb133.google.com
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

libunwind's unw_is_signal_frame() reads the trampoline as 32-bit words,
but __kernel_sigreturn is only 2-byte aligned. Align both trampolines
to 4 bytes, as the kernel's vsyscall-sigreturn.S does (with .balign 32).

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/sh4/vdso-be.so | Bin 2720 -> 2724 bytes
 linux-user/sh4/vdso-le.so | Bin 2720 -> 2724 bytes
 linux-user/sh4/vdso.S     |   2 ++
 3 files changed, 2 insertions(+)

diff --git a/linux-user/sh4/vdso-be.so b/linux-user/sh4/vdso-be.so
index df9fa22efab46bffbb9957af078199639998ea43..d74a2d78e869d7bc6c531c36d82d6c2b1315287b 100755
GIT binary patch
delta 192
zcmZ1=x<qt>GNZ~w6=&8z3=AxPCgxO#9C@_r)US}NFAa~om)?|aoD?HG|JB4F*9C7d
zFfa%RF);7|=?tLaH=7?Y?q*`vVDOqekHtcSfpaqJVF3kh7-T31iacZa3DyVH0@kMt
zvSjiH)_le{lM~qNg%D;YCnuUj7$)Xz-pH25%os6Qf=ik4&tw}eb;dQ5Q@GSc=K@V=
L0T}}Yj362SBc3ya

delta 172
zcmZ1?x<GV-GNZyo6=&8T3=AwkCgxO#M6Q#1zh>Q;(|ew7YO+;`jbwinsW|b+b-`;4
z3=9H73=BL#Is>Tq#pVZ$yP23(7(6G>W3dpJ%z9Wrfg1)H$|t{K`3cqoR1Vgo46<PI
z7uI~n7n4)i?1d2KB`5p&Sep7dZ{Et5#>^NpS%yoQ@yBEbE_KEglQV$i%*hkDL;yZI
BF{c0k

diff --git a/linux-user/sh4/vdso-le.so b/linux-user/sh4/vdso-le.so
index decd674202260f045b646b318ebb0b6daf416651..a59c9e5244dbebd709f187028831f0a51a8b0706 100755
GIT binary patch
delta 200
zcmZ1=x<qt>0;9@AMQ7GOEDQ{PCT3QPWaXVH&gBv-40~8xYBG;6g<=1u`xAd$5xfCZ
zAi%)DAjH7KkO8FMY`)95n~6;W$Yk)EJdedfn3I8ZvcO?(1sE)6;GF!F<vUm>NEHK6
zr!tWIGx;rRKI5Cov26CD$fhzRCr3v37Y1c)-pH2B%os6QluMcM&tyw3b;dQ56S>qS
Q=CU&|w15qQ5R6bZ00y`)E&u=k

delta 193
zcmZ1?x<GV-0;9r2MQ7F@EDQ`kCT3QP{0T|D+C1g@<*pwKXS>-y?_bLI+hO95D}vX6
z3IrG!7=##j7&3tLi_Lc#cQdi60GSM)ljpHm@Uu=9ILxg8gXNQ7vU~^Y0;ymC>QV-h
zKPG=<&1ZZuIg!m?6xl?E<m9ple~)1Q&0E=$nHfVSCvpf+*5MLh{4v><OPzHE8w10~
U$$^~0lWVvHSZA^`FtmVp030MX^8f$<

diff --git a/linux-user/sh4/vdso.S b/linux-user/sh4/vdso.S
index 290eb498ae..a66cac7439 100644
--- a/linux-user/sh4/vdso.S
+++ b/linux-user/sh4/vdso.S
@@ -135,6 +135,7 @@ vdso_syscall __vdso_gettimeofday, __NR_gettimeofday
 	.cfi_offset		24, SC_FPSCR
 
 	nop
+	.balign	4
 
 sigreturn_region_start:
 __kernel_sigreturn:
@@ -144,6 +145,7 @@ endf __kernel_sigreturn
 	/* rt_sigreturn frame layout; nop for the same reason as above. */
 	.cfi_def_cfa_offset	RT_SIGFRAME_SC_OFFSET
 	nop
+	.balign	4
 
 __kernel_rt_sigreturn:
 	sigreturn_tramp __NR_rt_sigreturn
-- 
2.54.0


