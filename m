Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1365C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2uL-0005gt-Mv; Wed, 15 Jan 2025 07:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tY2uH-0005Hr-9S
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:54:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tY2uC-0007Ci-Sm
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736945635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXhSPhqlWWjuvuFpvz5PPp/lZKH/a7uwaO2Bzwi8WUk=;
 b=ccF6aCIuico3n6zxkzNwZRWkRPQBZQflRevpJxd8LhcCHdzuuogkOTwrdBTHAKFU9RBY9/
 g4CHE1bbsYZ+/w2UoQDVwgJvAS/jOxCqJHw+pPz/jEO2L3gorKiDSAvn+q5xlQjTihILRF
 AKPIQVWNAVxrdHUK8i++aEgsLNXuwe4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-AqoyXIiKNqanBhzrLhJnpA-1; Wed,
 15 Jan 2025 07:53:54 -0500
X-MC-Unique: AqoyXIiKNqanBhzrLhJnpA-1
X-Mimecast-MFC-AGG-ID: AqoyXIiKNqanBhzrLhJnpA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9457F1954203
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 12:53:53 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43E6719560AD; Wed, 15 Jan 2025 12:53:51 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	anisinha@redhat.com
Subject: [PATCH 3/3] tests: acpi: update expected blobs
Date: Wed, 15 Jan 2025 13:53:42 +0100
Message-ID: <20250115125342.3883374-4-imammedo@redhat.com>
In-Reply-To: <20250115125342.3883374-1-imammedo@redhat.com>
References: <20250115125342.3883374-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

_DSM function 7 AML should have followig change:

               If ((Arg2 == 0x07))
               {
  -                Local0 = Package (0x02)
  -                    {
  -                        Zero,
  -                        ""
  -                    }
                   Local2 = AIDX (DerefOf (Arg4 [Zero]), DerefOf (Arg4 [One]
                       ))
  -                Local0 [Zero] = Local2
  +                Local0 = Package (0x02) {}
  +                If (!((Local2 == Zero) || (Local2 == 0xFFFFFFFF)))
  +                {
  +                    Local0 [Zero] = Local2
  +                    Local0 [One] = ""
  +                }
  +
                   Return (Local0)
               }
           }

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/data/acpi/x86/pc/DSDT                   | Bin 8526 -> 8544 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8437 -> 8455 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9851 -> 9869 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15397 -> 15415 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 8990 -> 9008 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10180 -> 10198 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8477 -> 8495 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8598 -> 8616 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9885 -> 9903 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8384 -> 8402 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8532 -> 8550 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12319 -> 12337 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8373 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8390 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9698 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12565 -> 12583 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8652 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8419 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 11986 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 12931 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33788 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 8837 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13146 -> 13164 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10027 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8448 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8461 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8390 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9732 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9503 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13226 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8231 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8379 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8474 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 12931 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33788 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 8979 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 9005 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18607 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14612 -> 14630 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35736 bytes
 40 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index 8b8235fe79e2fa08a6f840c8479edb75f5a047b9..7fcbecc7991c9230cf2ab2ad7e33e2285655e2a1 100644
GIT binary patch
delta 89
zcmX@-^uUSBCD<h-L6L!hQEDRB113MwiEnl=xo}Nh#+YqlJ~@kvy};4aC8D__hk*e|
rFft?+2r)4wERdQsadHyF<RqT|Kv0m>k-)%Ez{}8)z_{6%Nm?EN8897b

delta 71
zcmaFhbk2#(CD<jzPmzIvF>@l<112AliEnl=IdM*2#+a?7IysAry+DYSiGi0Pp}^78
aC8D__hk*e|Fft?+By}V(Y<6XmmInX<(-dg{

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index 06829b9c6c6d726d955dc7c99bc9f42448e22aeb..5fb2b6376fdef3e9a8ce8861f8b333de01c154a8 100644
GIT binary patch
delta 89
zcmezB*zUyT66_MfuE@Z^m^6{=0h6ET#5X&bT(~ALW6U-&pPa?TUf}5I64Bg|!@vL}
r7#WfZgqWBT7D!E+I5~-7auUyfASg)cNMK+n;AQAYVBBoXbVv>W0=*r}

delta 71
zcmZp7`s&E#66_N4Re^zlannSu2TVR96W{D$a^jr4j4@kDb#fLLdw~!u69X?pLV=^F
aOGI-=4g&*_U}Q)tNa{#n*zC%5NDcrkCKby7

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index 2fe355ebdbb858fa9247d09112e21712e3eddc45..51c70746c6c8ae33c48bf46e49a6f4ec2278feb4 100644
GIT binary patch
delta 89
zcmezE)9cIS66_MvtH!{<czq(*113MwiEnl=xo}Nh#+YqlJ~@kvy};4aC8D__hk*e|
rFft?+2r)4wERdQsadHyF<RqT|Kv0m>k-)%Ez{}8)z_{6%$wLJITN@sE

delta 71
zcmeD6{q4i$66_LEt;WE>s5X)70h5o&#5X&boH!>hW6V}kot(wRULeHE#K6mtP~hn4
a64Bg|!@vL}7#WfZk~$I?HoG!;r~m-^6%=^@

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index 4d4067c182a6625db1e877408eb7436113884b50..ec920896faf05c5415ef4e485696a26a10d06d80 100644
GIT binary patch
delta 89
zcmZ2lvAu%JCD<jz+=hXHQDY+4113MwiEnl=xo}Nh#+YqlJ~@kvy};4aC8D__hk*e|
rFft?+2r)4wERdQsadHyF<RqT|Kv0m>k-)%Ez{}8)z_{6%>60Y@BO4xc

delta 71
zcmdm9v9yBACD<iI)rNtAv3w%e112AliEnl=IdM*2#+a?7IysAry+DYSiGi0Pp}^78
aC8D__hk*e|Fft?+By}V(Y<6Y(WC;KX>J@YV

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index 045a52e75b7fcd4e5f840a758c548231498b96e4..b4d0f151ce4c21d7dd93d02aad29643d3cf3aea5 100644
GIT binary patch
delta 89
zcmbQ|w!w|dCD<jzK$(Gov2G&Q113MwiEnl=xo}Nh#+YqlJ~@kvy};4aC8D__hk*e|
rFft?+2r)4wERdQsadHyF<RqT|Kv0m>k-)%Ez{}8)z_{6%>9qm?3v(VA

delta 71
zcmdnsHqVXACD<iIPMLv$@$5vd2TVR96W{D$a^jr4j4@kDb#fLLdw~!u69X?pLV=^F
aOGI-=4g&*_U}Q)tNa{#n*zC&mS^)s|YZVv(

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 205219b99d903555125c4b07fc047c42993eb338..4a0a7a14e262ac85b402e3719608cb93c408c35d 100644
GIT binary patch
delta 89
zcmX@&f6brECD<k8nmPjmqt`^P2TXpV6W{D$a^af1j4|89d~y~Sdx4{;OGI-=4g&*_
rU}Q)t5Mp9VSRgfN;^ZWT$w@r_fuJC%BY}aTfR~{ofpN1j(?nGOP~sk!

delta 71
zcmccSf5e~5CD<k8h&lrU<IIU%514#JCcfFh<it678DqAR>f|gg_5vYRCI()HgaSuT
amx$($90mp;!N`zQkkpaDu-TPqqACC_0Tq`3

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 8fa8b519ec65bd5099c45f4e1c85b11b47a23845..8a410533d48ec34b174dcfe487b1fcb33cbc27b3 100644
GIT binary patch
delta 89
zcmbR1wBCu!CD<iIUy*@<(QhKx113MwiEnl=xo}Nh#+YqlJ~@kvy};4aC8D__hk*e|
rFft?+2r)4wERdQsadHyF<RqT|Kv0m>k-)%Ez{}8)z_{6%>6IJ+`1&2#

delta 71
zcmZ4QG}npCCD<iIR*`{$aqdK}2TVR96W{D$a^jr4j4@kDb#fLLdw~!u69X?pLV=^F
aOGI-=4g&*_U}Q)tNa{#n*zC&mN)7<%OBC1u

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 0ca664688b16baa3a06b8440181de4f17511c6b0..20b1263496affb0e514a9d16ed75a59c0238ccd8 100644
GIT binary patch
delta 89
zcmbQ{yuz8wCD<iog(3q3<Ftuf519N!C%)Oi<ia(18DqAI`Q$7v_5w#wmx$($90mp;
r!N`zQAjHI!us~|k#K}nvlaqM<13^JjM*;&w0WU*G0^??5ret{lF2WuM

delta 71
zcmZ4CJk6QQCD<ionj!-O<I{;;514#JCcfFh<it678DqAR>f|gg_5vYRCI()HgaSuT
amx$($90mp;!N`zQkkpaDu-TO<SsnlpSrrEW

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 03ff464ba4e72082fce0921815cfc09ca20b561a..a9ccae14e3a7111384a73bd92e49c2da9b52a96d 100644
GIT binary patch
delta 89
zcmbR1yWW?}CD<ioy&3}pBhN&x2TXpV6W{D$a^af1j4|89d~y~Sdx4{;OGI-=4g&*_
rU}Q)t5Mp9VSRgfN;^ZWT$w@r_fuJC%BY}aTfR~{ofpN1jQ<e$<6}}y}

delta 71
zcmZ4QJJ*-XCD<iot{MXaWAsF>2TVR96W{D$a^jr4j4@kDb#fLLdw~!u69X?pLV=^F
aOGI-=4g&*_U}Q)tNa{#n*zC%br2+u{z7)3r

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index b081030f0ed171e52b13e28cfdc8770a04c2806e..c1aa156a877f171b072aba51e82d38d11ad20f2f 100644
GIT binary patch
delta 89
zcmX@$c*&8=CD<k8k^%z*<CBS8519N!C%)Oi<ia(18DqAI`Q$7v_5w#wmx$($90mp;
r!N`zQAjHI!us~|k#K}nvlaqM<13^JjM*;&w0WU*G0^??5rd~M!ZbTmU

delta 71
zcmccQc)*d%CD<k8fC2*pqwz$p2TVR96W{D$a^jr4j4@kDb#fLLdw~!u69X?pLV=^F
aOGI-=4g&*_U}Q)tNa{#n*zC&GD+d4x-4yo#

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 2c98cafbff5db04410b35a1151eaf18723a4dad7..d207b18c7620965313a5aaf2398e745254619ab2 100644
GIT binary patch
delta 89
zcmccO^vsFNCD<h-O_70t@yJB32TXpV6W{D$a^af1j4|89d~y~Sdx4{;OGI-=4g&*_
rU}Q)t5Mp9VSRgfN;^ZWT$w@r_fuJC%BY}aTfR~{ofpN1jlcGETQ3@U_

delta 71
zcmaFnbj69wCD<h-M3I4kQFtQP112AliEnl=IdM*2#+a?7IysAry+DYSiGi0Pp}^78
aC8D__hk*e|Fft?+By}V(Y<6W*lm`IwW)v#`

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index da018dca9e3102e811107994248719ab5278c505..947a9613303ffb5445a02aea586bd4a13b78ff50 100644
GIT binary patch
delta 89
zcmbQAurYzlCD<jz(13w~aoI$!2TXpV6W{D$a^af1j4|89d~y~Sdx4{;OGI-=4g&*_
rU}Q)t5Mp9VSRgfN;^ZWT$w@r_fuJC%BY}aTfR~{ofpN1j(;Hm?E$JST

delta 71
zcmdm(Fh7CICD<iI-hhFD@#{pc2TVR96W{D$a^jr4j4@kDb#fLLdw~!u69X?pLV=^F
aOGI-=4g&*_U}Q)tNa{#n*zC&mMi&4PSQU~0

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index fb89ae0ac6d4346e33156e9e4d3718698a0a1a8e..3223604f7d9aa1e8df84826aa614b55a2ab91941 100644
GIT binary patch
delta 91
zcmZ4NxYd!%CD<ios{#W9<BN@43mKXGL?^Fh+`;6+H94Ir+r)fw78iSgqo+$mb4LyX
t1CU^3NGcFwVoF#bHEH7HB!<aJJpX~9AgLpPfuVqxp(BBD^B1P|vH(309_|1D

delta 73
zcmdn$xY&`)CD<iou>u1FqxnXzg^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
c(bFZOxg&>x0Z1@1Bo!oeBrt4dV_q){0OOhy?*IS*

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index 46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b..88dd156d9532100d2f9003c06077cc399a84d5f0 100644
GIT binary patch
delta 91
zcmdnuc+8Q@CD<k8m;wU>W5-6Wg^WyoqLbG$?qG7^nw-v*ZDKw-i;KO$(bFZOxg&>x
t0Z1@1BozoTF(oXJnly2862s&qp8r5lkkpaDz)--;(2>Bn`3utlSpYG(9?}2+

delta 73
zcmX@+xW$pnCD<ioivj}!<MoYP3mKVwL?*9g+`;6;IXRsvTS;|t78iSg5GxY{FGE6s
cqo+$mb4LyX1CU^3NGeF`NMP8^#(Y2)02X@`(*OVf

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index 61c5bd52a42242e85090934e8e45bf01642609d6..fe708b4403e9a0600f7562c9ce6a98ceb0168aae 100644
GIT binary patch
delta 91
zcmccM{m7fkCD<k8ktzcN<I;^>3mKXGL?^Fh+`;6+H94Ir+r)fw78iSgqo+$mb4LyX
t1CU^3NGcFwVoF#bHEH7HB!<aJJpX~9AgLpPfuVqxp(BBD^B1N&N&sKqAAJA-

delta 73
zcmaFleZiZ{CD<k8f+_<8<Cl$G3mKVwL?*9g+`;6;IXRsvTS;|t78iSg5GxY{FGE6s
cqo+$mb4LyX1CU^3NGeF`NMP8^#(YN!06Oj!egFUf

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
index 497706c9742a9ea5396d6c9c4cc1cc2a4a530339..cc6e0a338540a90b6d2e4398a73db07483f79836 100644
GIT binary patch
delta 91
zcmbQ5v^<H+CD<iI-H?HSF=8XvLPjP((aCEWcQCndO-^UZHZh-^#l>FW=;;#C+>yh;
t03;Y0k_v>Fm=YF9O`144iD7aQ&wn5&Na{#nU?|{a=tyAP{DnzT4*>P09f|+|

delta 73
zcmZ3UG&PCKCD<iI)R2LJars8Bg^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
c(bFZOxg&>x0Z1@1Bo!oeBrt4dV^-7y0Ox!YivR!s

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index 3aaa2bbdf54a0d0cade14421e84c6ec5a42f96fa..a9a7cec8d7e2830275bfc1b69fb4fa116ecc884b 100644
GIT binary patch
delta 91
zcmdnxe8!o}CD<k8j3NUAW8Oxtg^WyoqLbG$?qG7^nw-v*ZDKw-i;KO$(bFZOxg&>x
t0Z1@1BozoTF(oXJnly2862s&qp8r5lkkpaDz)--;(2>Bn`3uuAIRG)t9@YQ=

delta 73
zcmX@(yvv!(CD<iomm&iL<KB&23mKVwL?*9g+`;6;IXRsvTS;|t78iSg5GxY{FGE6s
cqo+$mb4LyX1CU^3NGeF`NMP8^#(Yc;02aj**8l(j

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index 944209adeaa5bbb722431161c404cb51b8209993..bebf7d716c85d677c34ad0d4a4cd5377d52e4052 100644
GIT binary patch
delta 91
zcmccU_}G!lCD<k8u>u1F<Bg463mKXGL?^Fh+`;6+H94Ir+r)fw78iSgqo+$mb4LyX
t1CU^3NGcFwVoF#bHEH7HB!<aJJpX~9AgLpPfuVqxp(BBD^B1POvH)kWAC>?B

delta 73
zcmaFtc+ru|CD<k8q5=a0qxwd!g^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
c(bFZOxg&>x0Z1@1Bo!oeBrt4dW4<d300p%amjD0&

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index d9938dba8fa5d405f7696c0dbdc24f3ae42ec934..74b8553af453b157ebc041bf9a1cf77d9751ca2e 100644
GIT binary patch
delta 91
zcmX>QdnuO7CD<k8k{$yCBg;mvg^WyoqLbG$?qG7^nw-v*ZDKw-i;KO$(bFZOxg&>x
t0Z1@1BozoTF(oXJnly2862s&qp8r5lkkpaDz)--;(2>Bn`3ut-Z2&G<9?}2+

delta 73
zcmcZ<dmxs}CD<k8fF1(_WAH|<g^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
c(bFZOxg&>x0Z1@1Bo!oeBrt4dV?Lt|02J>O(*OVf

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index a24b04cbdbf09383b933a42a2a15182545543a87..d893781416b83305c3b0becc553f54fb04672fda 100644
GIT binary patch
delta 91
zcmeyE(wxfW66_MvY{bC8n6Qy+AtRHY=;XDGJD6O!CZ{uHo0w0|;$kmw^mK`6?#N+a
t01}K0Nd-boObH95CQY22#4tID=RXh>By}V(Fck1IbR;lt{=!tN4*)ER9*F<|

delta 73
zcmZop{g}e#66_LEXvDz4xPBwoLPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
c=;;#C+>yh;03;Y0k_wVK5*RkKG1uw?01^KbiU0rr

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index 3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8..ac87bc5db07e46285f4e42ca1d884905c8050cf6 100644
GIT binary patch
delta 93
zcmaFW&h)39iOVI}CFD;t0|Voxja&;Enfyd2uVvi9<ia&MohjSId~y~Sdx4{;OGI-=
v4g&*_U}Q)t5Mp9VSRgfN;^ZWT$w@r_fuJC%BY}aTfR~{ofpPN}rf&@Z%sC+{

delta 75
zcmey<&h)CCiOVI}CFE5z0|O)DMy`d7Og<u$*D~&4a^jqv&XldBIysAry+DYSiGi0P
ep}^78C8D__hk*e|Fft?+By}V(Y-VHr)&KxjpcX3t

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 20955d0aa30120553da35d5a6640055d26255cf9..6b8eca2586b874bb514fa400776006ae9a74fc25 100644
GIT binary patch
delta 91
zcmezD((20P66_Mvs>Hy+=(CY)AtRHY=;XDGJD6O!CZ{uHo0w0|;$kmw^mK`6?#N+a
t01}K0Nd-boObH95CQY22#4tID=RXh>By}V(Fck1IbR;lt{=!r*4*(4|9vuJx

delta 73
zcmZp5{p`Z!66_LEti-^;IC~@4LPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
c=;;#C+>yh;03;Y0k_wVK5*RkKG1toj0Qoo+9smFU

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index 3c34d4dcab16783abe65f6fa5e64eb69d40795fb..6d71a26fab6cc0b55675b65835232a562c5ee32d 100644
GIT binary patch
delta 91
zcmcbW_9l(XCD<h-$C!bEQD!68LPjP((aCEWcQCndO-^UZHZh-^#l>FW=;;#C+>yh;
t03;Y0k_v>Fm=YF9O`144iD7aQ&wn5&Na{#nU?|{a=tyAP{Dmpa001sL9&P{t

delta 73
zcmaEpb}Nm`CD<h-%9w$HF?%D|LPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
c=;;#C+>yh;03;Y0k_wVK5*RkKF{c>-02K)oZvX%Q

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index 228374b55bd544116e359f659e546fc66cf8a895..5a0ff97b9e1a680ab0bcde0cce4272b15cb6c214 100644
GIT binary patch
delta 91
zcmbQ~x7v@(CD<iITb+S{QG6rULPjP((aCEWcQCndO-^UZHZh-^#l>FW=;;#C+>yh;
t03;Y0k_v>Fm=YF9O`144iD7aQ&wn5&Na{#nU?|{a=tyAP{DnzX1pw6?9UTAw

delta 73
zcmZ4OH`9;HCD<iIQk{W;F>NE)LPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
c=;;#C+>yh;03;Y0k_wVK5*RkKF{`Qo0M0QJ9smFU

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 45f911ada5645f158f3d6c0c430ec1d52cadc5d8..a7e79e498335f3ffa1eb63c56b4a3bd9bcd5eed4 100644
GIT binary patch
delta 91
zcmaFo*x<zF66_Mfpvb_$D7}$uAtRHY=;XDGJD6O!CZ{uHo0w0|;$kmw^mK`6?#N+a
t01}K0Nd-boObH95CQY22#4tID=RXh>By}V(Fck1IbR;lt{=)Q2768uK9nSy&

delta 73
zcmZp0dgsXH66_N4PJw}eF?%D|LPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
c=;;#C+>yh;03;Y0k_wVK5*RkKG5?YU00{FG&;S4c

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index e5d6811bee1233d74236453c49060390d74d4416..075ac613d2ba1348775c2ac6c38c5e85221b577b 100644
GIT binary patch
delta 91
zcmezE*z3gQ66_MftH{8>*t3yqAtRHY=;XDGJD6O!CZ{uHo0w0|;$kmw^mK`6?#N+a
t01}K0Nd-boObH95CQY22#4tID=RXh>By}V(Fck1IbR;lt{=&pA2LSv(9d!Tz

delta 73
zcmeBm`t8W&66_N4TY-Ur@y<rBg^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
c(bFZOxg&>x0Z1@1Bo!oeBrt4dV`i5F04u2!b^rhX

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index 46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b..88dd156d9532100d2f9003c06077cc399a84d5f0 100644
GIT binary patch
delta 91
zcmdnuc+8Q@CD<k8m;wU>W5-6Wg^WyoqLbG$?qG7^nw-v*ZDKw-i;KO$(bFZOxg&>x
t0Z1@1BozoTF(oXJnly2862s&qp8r5lkkpaDz)--;(2>Bn`3utlSpYG(9?}2+

delta 73
zcmX@+xW$pnCD<ioivj}!<MoYP3mKVwL?*9g+`;6;IXRsvTS;|t78iSg5GxY{FGE6s
cqo+$mb4LyX1CU^3NGeF`NMP8^#(Y2)02X@`(*OVf

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index 5ce081187a578ba7145a9ba20d30be36c13b7663..812ed0fd18be86004ee4cb76222e8601909ecd46 100644
GIT binary patch
delta 91
zcmez5-QvUL66_MfqQ=0$cylAyLPjP((aCEWcQCndO-^UZHZh-^#l>FW=;;#C+>yh;
t03;Y0k_v>Fm=YF9O`144iD7aQ&wn5&Na{#nU?|{a=tyAP{DtYC5&#su9=iYl

delta 73
zcmZqi`Q**z66_N4NtJ<tQF9~LLPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
c=;;#C+>yh;03;Y0k_wVK5*RkKG5=En00Yq!yZ`_I

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index bdf36c4d575bfc4eb2eac3f00c9b7b4270f88677..3d5131761ced4fdb018671a363fd805a10251e8e 100644
GIT binary patch
delta 91
zcmeD6n(xKs66_Kpugbu{IBO%<LPjP((aCEWcQCndO-^UZHZh-^#l>FW=;;#C+>yh;
t03;Y0k_v>Fm=YF9O`144iD7aQ&wn5&Na{#nU?|{a=tyAP{DnzU2>|T39b^Ci

delta 73
zcmbR5)$7IO66_MftIEK@_;MrHLPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
c=;;#C+>yh;03;Y0k_wVK5*RkKF-s}|0N>IRWdHyG

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 1db43a69e4c2affd8bd678bbef4d3c228380288e..a98567b923e88bdd400ac1acd32fdb169e7e77ca 100644
GIT binary patch
delta 91
zcmbP{zABx|CD<iol`#VY<KK;33mKXGL?^Fh+`;6+H94Ir+r)fw78iSgqo+$mb4LyX
t1CU^3NGcFwVoF#bHEH7HB!<aJJpX~9AgLpPfuVqxp(BBD^B1Ni1^`%#A4vcJ

delta 73
zcmZ3LJ|msWCD<iohA{&Jqt8aJg^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
c(bFZOxg&>x0Z1@1Bo!oeBrt4dV_sqa0Qo-@N&o-=

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index c13e45e3612646cc2e30f00b3b7e53335da816ea..a550cf23c0de681b6afdd7998872d9165b1c5dee 100644
GIT binary patch
delta 91
zcmbR0u-t*mCD<iIU4emtapOj=g^WyoqLbG$?qG7^nw-v*ZDKw-i;KO$(bFZOxg&>x
t0Z1@1BozoTF(oXJnly2862s&qp8r5lkkpaDz)--;(2>Bn`3sYxECBOV9en@*

delta 73
zcmZ4PFx7#}CD<iIRDpqkkzpg(LPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
c=;;#C+>yh;03;Y0k_wVK5*RkKF)PXf0IA~=egFUf

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index ba6669437e65952f24516ded954b33fe54bdedfb..22b2a21705762f7afab457e7dd2d5fd06f8d7c84 100644
GIT binary patch
delta 91
zcmZ4KxZ9D-CD<iow*mtL<D`vT3mKXGL?^Fh+`;6+H94Ir+r)fw78iSgqo+$mb4LyX
t1CU^3NGcFwVoF#bHEH7HB!<aJJpX~9AgLpPfuVqxp(BBD^B1PAvH&S!9<Tra

delta 73
zcmdn(xYCi!CD<ior2+#3<HL<y3mKVwL?*9g+`;6;IXRsvTS;|t78iSg5GxY{FGE6s
cqo+$mb4LyX1CU^3NGeF`NMP8^#=KP)01v|yu>b%7

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index 6ad42873e91c80cef5a42224cb4d31936dad59b4..c26f9b1ba6f0c949e509c0028c7888ca6e4a768a 100644
GIT binary patch
delta 91
zcmeBhn&rgh66_KprO3d*IBO%<LPjP((aCEWcQCndO-^UZHZh-^#l>FW=;;#C+>yh;
t03;Y0k_v>Fm=YF9O`144iD7aQ&wn5&Na{#nU?|{a=tyAP{DnzG4glb{9XJ30

delta 73
zcmbQ`)ZxVC66_Mfp~%3%_;MrHLPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
c=;;#C+>yh;03;Y0k_wVK5*RkKF^k9n0M<woIRF3v

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index a24b04cbdbf09383b933a42a2a15182545543a87..d893781416b83305c3b0becc553f54fb04672fda 100644
GIT binary patch
delta 91
zcmeyE(wxfW66_MvY{bC8n6Qy+AtRHY=;XDGJD6O!CZ{uHo0w0|;$kmw^mK`6?#N+a
t01}K0Nd-boObH95CQY22#4tID=RXh>By}V(Fck1IbR;lt{=!tN4*)ER9*F<|

delta 73
zcmZop{g}e#66_LEXvDz4xPBwoLPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
c=;;#C+>yh;03;Y0k_wVK5*RkKG1uw?01^KbiU0rr

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index 3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8..ac87bc5db07e46285f4e42ca1d884905c8050cf6 100644
GIT binary patch
delta 93
zcmaFW&h)39iOVI}CFD;t0|Voxja&;Enfyd2uVvi9<ia&MohjSId~y~Sdx4{;OGI-=
v4g&*_U}Q)t5Mp9VSRgfN;^ZWT$w@r_fuJC%BY}aTfR~{ofpPN}rf&@Z%sC+{

delta 75
zcmey<&h)CCiOVI}CFE5z0|O)DMy`d7Og<u$*D~&4a^jqv&XldBIysAry+DYSiGi0P
ep}^78C8D__hk*e|Fft?+By}V(Y-VHr)&KxjpcX3t

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index e381ce4cbf2b11f56a2d0537db4d21acc97450c9..0a91b7ba857d508113c7df8e9c8072ff73c3d6c3 100644
GIT binary patch
delta 91
zcmZp4o9xEr66_Kptjxf`D6x@iAtRHY=;XDGJD6O!CZ{uHo0w0|;$kmw^mK`6?#N+a
t01}K0Nd-boObH95CQY22#4tID=RXh>By}V(Fck1IbR;lt{=&qo006bo9HsyO

delta 73
zcmbR2*67CN66_MfsLa5?n7)x~AtRHI$mF$*JD8j}C#N%IE2&P-;$kllVr63BWk@J+
b^mK`6?#N+a01}K0Nd-wA2@IRrn0XZdwM-JH

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index a09253042ce4a715922027245de8a2ab7449c5b7..b9c83bea1fb891eea31ab63f175a8898408ef596 100644
GIT binary patch
delta 91
zcmbR3w$_cyCD<iISDAr<@zO@Fg^WyoqLbG$?qG7^nw-v*ZDKw-i;KO$(bFZOxg&>x
t0Z1@1BozoTF(oXJnly2862s&qp8r5lkkpaDz)--;(2>Bn`3sY}0ssi29moIx

delta 73
zcmZ4MHrtKMCD<iITA6`?QE?;JLPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
c=;;#C+>yh;03;Y0k_wVK5*RkKF{>*80J?q>$p8QV

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index edc23198cdb47a981bcbc82bc8e392b815abb554..16b46775879d9a28090220e2ecd93fcba20a9c1b 100644
GIT binary patch
delta 93
zcmbO`k#YS*MlP3Nmyq=y3=E7t8@U!TGWm&4Udy<H$%SijI#afZ`Q$7v_5w#wmx$($
v90mp;!N`zQAjHI!us~|k#K}nvlaqM<13^JjM*;&w0WU*G0^{Z{Oe<XhWAz_w

delta 75
zcmZ2Kk#X)sMlP3Nmyo$03=E97H*zgxWbzT2yq0kXlN0CUbf#=2)yY|0>;*!sObomX
e2?dUxE)mTgISdRyf{`JqAgLpPVKW=^N>>0sC>3o0

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 4c93dfd5c4b362714d3f9aa606a838d4625b3369..7cdde13b45d322855cfbb3894165d5c60dd20fa7 100644
GIT binary patch
delta 91
zcmbPIw5*8BCD<iI&60tEao0w!g^WyoqLbG$?qG7^nw-v*ZDKw-i;KO$(bFZOxg&>x
t0Z1@1BozoTF(oXJnly2862s&qp8r5lkkpaDz)--;(2>Bn`3sYR82}&F9vA=s

delta 73
zcmZ2hG^L2kCD<iI#FBx5k#i&0LPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
c=;;#C+>yh;03;Y0k_wVK5*RkKF)Nq>0L>s182|tP

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index d4acd851c62c956436a436f9fa6d08fc5f370fa7..5a6310f45371c734fb03ac27bb864457eaeee7ad 100644
GIT binary patch
delta 93
zcmZph&NO2>6PHV{OUR6F1_s7?8@U!TGWm&4Udy<H$%SijI#afZ`Q$7v_5w#wmx$($
v90mp;!N`zQAjHI!us~|k#K}nvlaqM<13^JjM*;&w0WU*G0^{Z{Op`hQYsnwB

delta 75
zcmbO+ovCd)6PHV{OGsNc0|VpRja&;EnS4YhuVvi9<it5Sohe&Mb#fLLdw~!u69X?p
eLV=^FOGI-=4g&*_U}Q)tNa{#n*v!T}sRIB+;1#z3

-- 
2.43.0


