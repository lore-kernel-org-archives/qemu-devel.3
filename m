Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD477C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 17:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTPFJ-0006Bd-NB; Mon, 15 Jul 2024 13:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTPFI-00066o-FQ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:12:16 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTPFF-0007UF-Mw
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:12:16 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so2630911a12.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721063531; x=1721668331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dq7QFPQUVP3Ynbd/KPSkrs4w0szD0VlYjXKC1M1eAR0=;
 b=LC/TD+kzFirDQ+PiOmTZ1v7EnYMQrZ8GFgSfmcF/JlkED9IHespsa2EXGJ/a6JCk3m
 WKDzeshO7a2CRai3qNbCbV7rGY9ElDkhOlkRFO7SIVJJQndSSLHCL68pcdLSTtAkkms+
 /ODcviwKGtifk6oMT/CgV8jgBSvDEbK6AcElDjHhN/W9lhST0jqMsSRTITprdjd85Vi+
 SUcmOWXwFxY6iKwBn7R74SqUi2Nw7+GzvDMo6ItdXdYkK21tTWR4rvW9YtDHjZcEu+yQ
 SGiTgoOA2d2RWETymbNRQ9zg0izL4Iz/qYWLe6kKYMJOgeNK5qcagfopFPIsqvbttwHW
 XVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721063531; x=1721668331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dq7QFPQUVP3Ynbd/KPSkrs4w0szD0VlYjXKC1M1eAR0=;
 b=PeUIvqkWL+1e/fiekqlnGowE197DfN1/2GehttUcYrWQbArfDsrhIEcbeC9PZB9GiR
 wrZH+/C2AwGIy9FW1objPoNKrlavDqi1iSJHcxpU50weEefrn3KOdj5iI7KEtiEYSIKC
 NRIVxvBpA5ql3NtcHBzSQYpBP13S4S7Yg24NDNCHdpv8GFQ6BTgSJF604LoySN5oRnQJ
 ILAsQqxji6AN4Bq/YiDpy/NWHMp3QSoLw+SX1tYMUOQXM/EM3aMdcEOLN2FltINTWX9R
 hwrNaxNhFN64REEGJ5JrMNO/s7K1Ph2jZhFkYKJA8i9Obg45XTet3ECqDTFs6upQZMV8
 ghkA==
X-Gm-Message-State: AOJu0Yxri8RCQDWdaN4VSIdMBo+QaSKEtOWmOIYObJ0tkAgWXnAtyvoi
 GY1gF3SoZsIS0wNC2AZyWAcB+SB0TjCG2f+jBqPt0kF4AlfI5zNrifkN/GwaocUhSvLunp/eosP
 O2ZQ=
X-Google-Smtp-Source: AGHT+IGKOUvdXbpNewQq+zGdjeonHCkT3Ako0JWQtnhQjm0KkJ0iwZ4Xs2ph9A0576FXjSgHdr1tbA==
X-Received: by 2002:a05:6a20:3944:b0:1c0:f33e:aaec with SMTP id
 adf61e73a8af0-1c3ee6548ffmr644604637.49.1721063531163; 
 Mon, 15 Jul 2024 10:12:11 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca85ccsm4752618b3a.178.2024.07.15.10.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 10:12:10 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 9/9] tests/acpi: Add expected ACPI AML files for RISC-V
Date: Mon, 15 Jul 2024 22:41:29 +0530
Message-ID: <20240715171129.1168896-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
References: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As per the step 5 in the process documented in bios-tables-test.c,
generate the expected ACPI AML data files for RISC-V using the
rebuild-expected-aml.sh script and update the
bios-tables-test-allowed-diff.h.

These are all new files being added for the first time. Hence, iASL diff
output is not added.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/data/acpi/riscv64/virt/APIC           | Bin 0 -> 116 bytes
 tests/data/acpi/riscv64/virt/DSDT           | Bin 0 -> 3576 bytes
 tests/data/acpi/riscv64/virt/FACP           | Bin 0 -> 276 bytes
 tests/data/acpi/riscv64/virt/MCFG           | Bin 0 -> 60 bytes
 tests/data/acpi/riscv64/virt/RHCT           | Bin 0 -> 332 bytes
 tests/data/acpi/riscv64/virt/SPCR           | Bin 0 -> 80 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   6 ------
 7 files changed, 6 deletions(-)

diff --git a/tests/data/acpi/riscv64/virt/APIC b/tests/data/acpi/riscv64/virt/APIC
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..66a25dfd2d6ea2b607c024722b2eab95873a01e9 100644
GIT binary patch
literal 116
zcmZ<^@N_O=U|?X|;^gn_5v<@85#X!<1dKp25F13pfP@Mo12P{Zj?R|`s)2!c7=s}J
I#NvT*0o0BN0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..6a33f5647ddd6de3a0f000f718b58f6fff44f0fd 100644
GIT binary patch
literal 3576
zcmZvfO>Y}j6o&8Elh_%5#CDu-Cr+Uf3sh+w6Os)g_Bd%=*~#E>8YCmRQk04kR6;38
z1tF>|_=woFL2TFrkzaw3Kw`y?9SFpd4SxW3<~{d%%sFI6^31%~=e+kk*Z0mHH-bj@
zpNvwm2lYK~Cs?V!>U%3VETt6P(>3S)@mfEq_j{*1w&%KTvcJ=8WNMz@gjiR}{(iH8
zbGz2fKj&PZyKX7U;>Z7W?{s7Pz}q%PuWYsVVYCX1pj&fN$-d{+ESx(*KJR2do*=ti
zZVrZzRPS`Xi5g61C-80~vob2-W>CkyNK|R1?&w4>;qA3$W_6TFISbCL=}hIQ%g@G@
zWjVUnWWNzK3ahdFl#?s|I{59|`=7VZo_zP!_qV>W3X4`@E|xib^R2_<8+RWZz5VXd
z{liD-c5?&O*6iDzu-w*eXAkAB{nzP;GweEtu5-h#Y0wB*TT~3Ow4gz{VzI(3Vnd5M
zRk0dn;l!dmT;>ty9@R*Xc$CK`^RT(c3y~gnl!wne#<<5?q{mp4#~tP|&OKg?^cauw
zIAI<M?y(-}k%;nm%si4qkEY$igfJfduJ3y8_GohWn2}j0rDx%aj)&`&w&Hj{=mb{p
zR9g*aiLk;X;a1lotW4X;>K0WsoGrqNCJXm^Cc?|KNw49okzSZI-0Rs0FVi;iYJK5*
zO*UFJcY{_to<-zbb7?gPTQ_m8*LO$b7<4=NvQzSvr<&?Wttc0t2JYTd_tYV-icIt}
z@;lwB);rGQLds4J28w<gW$rE9S5zTQ?M{q_Clqmrsw!mc^k85q%0b*vQ5FKT<~yB-
z&`?q){B<lAs)-#c$_zteN@pTeXF^hD*bA1YiPf2LMVVn}++-qDXF^gYD$=o7lqPnl
zhKxGYHko1Zkem}s5t(5HW4g~Ubj)Oi#Y1vVEI?KP9<Weh=(yyB<eXS`CRSIQ5S$6g
z3CTIJ*pL~HbW&%ALz0x7keqWuaAF@awd)a@kera56WfM~)zvzJ(~+EzoHHdjQ-U)k
zIUzYGHaf<c7My9x3CTIJ|06T}Ju`wcBRL^CXI5}#1!q=rLUPVY!8s{7CnYB&=fwWV
zII&fm+V!uJlbn#8GcP#vf-^5UAvtG3a25n-L2^QJ&MCn;B{-)fCnV=A3eKY7EJ{vD
z&N(eOrv>M<<b>p$GlFwQaL!0hNX|JcIA;attmK5`oOrQgzvrCboRgf8oO51q&I`_Y
z$qC6h7X;^m;9QWLkeqW-a4rhYMac=tIZJ}GBsfcw6OwZ-3C<<Kxg<FuIp?zATo#<m
zk`t11mIY^7aF!(}q~R>4`(C}KF7YH%*r(}jWhdc0{4}Ft)TGpaPSz)wD{1VN`q&%{
z1|Nm@_{K`p3#UG?1=9g-sk7%<j&7!RO5_gceT*OGT{9W%`@Twg-A+ptw<r30foGo`
zE3a`-x!6gZzfN!Rz4q_bzsse~FApBpet7AZyJyFajeu2Llekt-NRSWRRLSZCIyq%J
zU*w*i-?Ki%Hx(USxtMu+9>$sG9DR90!PI_v{B_o}Qzw<n<Khkct7zL7*Gx4(umALC
zu=alY$?RY4`5(RZ#l-m=>M|d<EIQ$TK-=zY1?=_5(|?(0kgJY+Wqe#36AaJGd~9%!
Jrzicb_!p&=*&hG^

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/riscv64/virt/FACP b/tests/data/acpi/riscv64/virt/FACP
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..a5276b65ea8ce46cc9b40d96d98f0669c9089ed4 100644
GIT binary patch
literal 276
zcmZ>BbPf<<WME(ucJg=j2v%^42yj*a0-z8Bhz+8t3k1-OV?`GjD1M-;Zz#xa0OIBc
A0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/riscv64/virt/MCFG b/tests/data/acpi/riscv64/virt/MCFG
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..37eb923a9320f5573c0c2cdb90bd98409cc7eb6f 100644
GIT binary patch
literal 60
rcmeZuc5}C3U|?Y6aq@Te2v%^42yj*a0!E-1hz+8VfB}^KA4CHH3`GY4

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4f231735abad925435c3cd052e6641b1b4187278 100644
GIT binary patch
literal 332
zcmXAlu};J=42E3}oe;y#j3;Kss=E2Q+<*iE2DT_kQ#GPVt0XN_CY}QEe2l!r@jGY9
z{(f6docQI`zCBh%)$aJzo?iFI_vdyGLy1^3*}lGi3a=3lMg37lzZBM{wodk)7TM~i
zRtz<{3+4+lLrXWwB5YqU#?qxjG@Sbs7?ERdyfzkMus+RlDILR%e&?1^WZBdq0=N=!
z3=z}&!C5b|#thwwtU!g=DD-_K5u?^KCV<o8lL^LuB1x+pWud{LxXR8TT8}a~E0^%g
ZTR3fLdqp>_=zP8dH)RXFi+dCw;Qyc2X#oHL

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4da9daf65f71a13ac2b488d4e9728f194b569a43 100644
GIT binary patch
literal 80
zcmWFza1IJ!U|?X{>E!S15v<@85#X!<1dKp25F12;fdT`FDF9*%FmM4$c8~z`e;@#f
G!2kgKJqrN<

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 70474a097f..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,7 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/APIC",
-"tests/data/acpi/riscv64/virt/DSDT",
-"tests/data/acpi/riscv64/virt/FACP",
-"tests/data/acpi/riscv64/virt/MCFG",
-"tests/data/acpi/riscv64/virt/RHCT",
-"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.43.0


