Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C028ACA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEaj-0001PW-69; Mon, 12 Oct 2026 07:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xGEPb-0007f4-Tp
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:41:52 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xGEPZ-00088r-Jn
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:41:47 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3ab62a8250aso972704a91.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791805304; x=1792410104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1QQMQiwRgYcOfCN7A3nlXGLbY/lAWd+zsDPblZLgUHY=;
 b=aKcI6HEuTrOrmBlk/syLmgLRn+5v0mcfYxt49PL/+HsHvsrTlPaOQ8IMlRmvJcyDtP
 +W+pnlG78dbM9uNAyYFLV+ggyhE0vnNtVnPBFRaOMsy5lO9ANrsc1jn4PKBJ+S4pOgMV
 co8FkP15AczESOBv+givimVafizL6tit2ishdWAw2kxOSY3IDe60P2lgb9/tHAVqI307
 4ItiVLTwotoqPEWSmFSHy/2z8mRz8bRwTQxXwH6qDt+KW8vf5CvWuuX+dE70L1et+Dto
 isX1duMHbwGbMcrUlxE2MTgPOLx43bQXUKbGI210iS5zNpmWOWCASdmqHmofOeC3xDVV
 22wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791805304; x=1792410104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1QQMQiwRgYcOfCN7A3nlXGLbY/lAWd+zsDPblZLgUHY=;
 b=CLdpRMww5ktgJ17LTuDRHY6EgKt9KZiJboaFvp/pICnZ7lqEqCRTwQGBT6yPCX3b5y
 OnYPEiOke/Nq019WMbSHLRZgu7/7Pf6maPGklYbQPGe7gs8ou6hLrCQFLJXxK6rHU6xf
 m3I8gxPov+k+EgyQx46Qd1zjdHj/klOsizJ/dY2Y6tr2I/OoOLQtze6uEfICyJCuFFOq
 Nt6l6YRPjTco98xLsMbYdPW/3q/MSplOE43qugC/DUpi+V9scJP3eUxOpufPKXjZkQPC
 BkpLnckOO9Nr8eKQ8tBDeLl/wPQbatNR4NEGkV0+OqRCF/3sSOTcmKcY1DpzNMsQyLUT
 6BAQ==
X-Gm-Message-State: AFq9FYJyLq77eq8cVrFY6yj8GiQD7qSfzAVd9+OZH5Dbg6UyKvp4d8GD
 feblwKpZSt7FqU8gi/4opInoyatGRrgnwMGFsBfQUP1AOJ9bDznTy4SNXGf8csFx
X-Gm-Gg: AYBFou2CF0wDeQZ5dnTw7KRVr2xAftgTBREHgN6fW1W8Jfz5owjbCPLtR5FED+hP8fD
 b8nOV5m+G9t7dSJsbdr2bo2aJCJgBBlF3KlYB/qrp1TXJ8755Pa1eQpfFifdjHkF+s6oDQnC7Mc
 NhSyZPR3zAsxKUi27D+8emHeBiw6V7CIr6PvS9H1MV89KOYwZLh94/noE9N4z47VqOfonXOuMfF
 GTRzu2L+sS4GMFVv9ASWBUoidqi/YJcq5Iw9ghIj84oNUp5nDb+r3RNDk+MELNV0JSPbthdA65N
 N89gN5j88oj4c/ygTCMpMKoazuXgFOu/DwcmsNGHLAR9bZFCDZ+yDRUJjlK1ApCMb8NLIFlsAXK
 rlKh+wV8RQRIrHly7DY4Vi+FPuZmbgmj6t7sNZ7lXNs6cGDb2CmYwbe2L5w6fqbvvK8aJp/y5yW
 Spdz3JWTrbQKB3wg8gqSYSPsH7gaMGL0GIgmZtyV97NDYMmw1lnLOrzVeu/7iPvfi0deSKLTJBJ
 g==
X-Received: by 2002:a17:90b:5346:b0:3a6:f90b:20cc with SMTP id
 98e67ed59e1d1-3ab3ac9dc3bmr6616376a91.61.1791805304050; 
 Mon, 12 Oct 2026 04:41:44 -0700 (PDT)
Received: from archlinux ([2409:8949:4c50:eb:9b22:b05b:94dc:7aa0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab421566acsm8614008a91.3.2026.10.12.04.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:41:43 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pillow <waysorrypub@gmail.com>
Subject: [PATCH 3/3] tests/data/acpi/loongarch64: Update expected DSDT.*
Date: Mon, 12 Oct 2026 19:39:58 +0800
Message-ID: <10e19c87d137f2e4db9ce0f23e1fcf83020ab6de.1791803914.git.waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791803914.git.waysorrypub@gmail.com>
References: <cover.1791803914.git.waysorrypub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=waysorrypub@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:53:15 -0400
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

    --- DSDT (before)
    +++ DSDT (after)
    @@ -23,18 +23,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Scope (_SB)
         {
    @@ -59,18 +59,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Scope (_SB)
         {
    @@ -95,18 +95,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Scope (_SB)
         {
    @@ -131,18 +131,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Device (L000)
         {
    --- DSDT.memhp (before)
    +++ DSDT.memhp (after)
    @@ -23,18 +23,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Scope (_SB)
         {
    @@ -59,18 +59,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Scope (_SB)
         {
    @@ -95,18 +95,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Scope (_SB)
         {
    @@ -131,18 +131,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Device (L000)
         {
    --- DSDT.numamem (before)
    +++ DSDT.numamem (after)
    @@ -23,18 +23,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Scope (_SB)
         {
    @@ -59,18 +59,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Scope (_SB)
         {
    @@ -95,18 +95,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Scope (_SB)
         {
    @@ -131,18 +131,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Device (L000)
         {
    --- DSDT.topology (before)
    +++ DSDT.topology (after)
    @@ -23,18 +23,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Scope (_SB)
         {
    @@ -59,18 +59,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Scope (_SB)
         {
    @@ -95,18 +95,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Scope (_SB)
         {
    @@ -131,18 +131,18 @@
                 })
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                     Package (0x01)
                     {
                         Package (0x02)
                         {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    +                        "clock-frequency",
    +                        0x05F5E100
                         }
                     }
                 })
             }
         }

         Device (L000)
         {

Signed-off-by: pillow <waysorrypub@gmail.com>
---
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4599 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5820 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4605 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4901 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |   4 ----
 5 files changed, 4 deletions(-)

diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index 09aa903c4e875f541223e36f59b28e101599df20..9040b02efa416565e3591fcecf5fea685e831be9 100644
GIT binary patch
delta 222
zcmeyZ{9T#LCD<k8yC4Gtqs~MwX-+4u_+Y2_=q9g;dg+WtlkYQ%sY){nNigvy=j116
z>!uZ@7M7;wC08==Fg*OqDu7Ua394KRpK@oY>E4{q{=P<&6_`XO_cQtvVGms6WND@h
Ph<a%}7H!_f<jM~KweUh|

delta 217
zcmeya{9BpJCD<k8w;%%pW6VS@X-;RZ_+Y2_=qB%pdg+YDlN*`D)MOZiB$;>^9)4xz
zP0q<r&elyUO3f=QP0dTLWDr28zetpN7pVC@lS>#gh_L{nL4paYK?a|THg95b<p%(F
Cm_Y{s

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
index a069d6878fb45fa6b0e6342eedb0eb3d25eb20da..0220f6abc21f6b1fc4d68a159fa3e332a84be7dc 100644
GIT binary patch
delta 222
zcmX@0yGNJHCD<ioj~D|3qv1p@X-+4u_+Y2_=q9g;dg+WtlkYQ%sY){nNigvy=j116
z>!uZ@7M7;wC08==Fg*OqDu7Ua394KRpK@oY>E4{q{=P<&6_`XO_cQtvVGms6WND@h
Ph<a%}7H!_f#3cd%H|{~8

delta 217
zcmdm^dq9`VCD<k8fEWV<W8y?EX-;RZ_+Y2_=qB%pdg+YDlN*`D)MOZiB$;>^9)4xz
zP0q<r&elyUO3f=QP0dTLWDr28zetpN7pVC@lS>#gh_L{nL4paYK?a|THg96$5&;1G
CW<Wjw

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
index 78ece52f57a383db128c7d1a08526e15ab911bb7..274d4ebdfed4b700103b0f7b79c877b02d217c85 100644
GIT binary patch
delta 222
zcmZov`K!$366_N4SCD~$amPe1X-+4u_+Y2_=q9g;dg+WtlkYQ%sY){nNigvy=j116
z>!uZ@7M7;wC08==Fg*OqDu7Ua394KRpK@oY>E4{q{=P<&6_`XO_cQtvVGms6WND@h
Ph<a%}7H!_f<joHN$n!#u

delta 217
zcmeyX+^E9k66_MfD8#_P_<SOlG^aCHe6Uk|bd&c)y>v$7$&E~6YBG#Ml1w}d55KbV
zCg<cQXX~aFrREiursgGAG6*2lUnEMs3)Fm{$t8>##8`mPAi)IHAcN0En>R6e^8*07
C^FS;B

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
index 7ab23f47cc82dd7bc1975e17893a8cd61039e66d..07a0cdc05fffbb7e96bfd3ca39d1589a913d1be1 100644
GIT binary patch
delta 222
zcmZ3fwp5MFCD<iIRhWT+asEUuX-+4u_+Y2_=q9g;dg+WtlkYQ%sY){nNigvy=j116
z>!uZ@7M7;wC08==Fg*OqDu7Ua394KRpK@oY>E4{q{=P<&6_`XO_cQtvVGms6WND@h
Ph<a%}7H!_fR4f1h-Y`L(

delta 217
zcmZ3gwo;ADCD<iIQ<#B)@%%(CX-;RZ_+Y2_=qB%pdg+YDlN*`D)MOZiB$;>^9)4xz
zP0q<r&elyUO3f=QP0dTLWDr28zetpN7pVC@lS>#gh_L{nL4paYK?a|THg94o761UG
Czd$<x

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 2ed837f..dfb8523 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/loongarch64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/DSDT.memhp",
-"tests/data/acpi/loongarch64/virt/DSDT.numamem",
-"tests/data/acpi/loongarch64/virt/DSDT.topology",
-- 
2.56.0


