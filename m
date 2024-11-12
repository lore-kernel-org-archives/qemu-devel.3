Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605EDD42BB3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuKx-0007Ol-Tt; Tue, 12 Nov 2024 12:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAuIf-0003gO-VX
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:03:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAuIb-0001aw-Nl
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731431008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7Sw80feYdIpNPWhJFT98AEQYKPUwDpvCYX/S1i4AcA=;
 b=fMfFsvQNhoOiCe44d9E/+wG8LMQxLS98XvH+NM0vs+4umb6bN7xFNSxzvstchRGEDKUU9x
 Oj/0lViDcOMj9Q8EVQi8LiWnIlL3ozc9s0l4T5XUiwras4TLgo2TVpd3otgS15kUFxdmJM
 Pn169YMzOOGqUJmbJkNNRY9jDpdJFLg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-b8dcXkPSP8eR-BgMdi7veQ-1; Tue,
 12 Nov 2024 12:03:21 -0500
X-MC-Unique: b8dcXkPSP8eR-BgMdi7veQ-1
X-Mimecast-MFC-AGG-ID: b8dcXkPSP8eR-BgMdi7veQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9863119560B2; Tue, 12 Nov 2024 17:03:18 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5F03195607C; Tue, 12 Nov 2024 17:03:15 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: salil.mehta@huawei.com, mst@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com, anisinha@redhat.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, gustavo.romero@linaro.org
Subject: [PATCH 4/7 for-9.2] tests/acpi: update expected blobs
Date: Tue, 12 Nov 2024 18:02:55 +0100
Message-ID: <20241112170258.2996640-5-imammedo@redhat.com>
In-Reply-To: <20241112170258.2996640-1-imammedo@redhat.com>
References: <20241112170258.2996640-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Expected AML return to the state before
  bf1ecc8dad606 (w/acpi: Update ACPI `_STA` method with QOM vCPU ACPI Hotplug states)
droping not needed CPRS and _STA logic that broke cpu hotplug

	@@ -2887,7 +2887,6 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
			 CRMV,   1,
			 CEJ0,   1,
			 CEJF,   1,
	-                CPRS,   1,
			 Offset (0x05),
			 CCMD,   8
		     }
	@@ -2922,16 +2921,9 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
			 Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
			 \_SB.PCI0.PRES.CSEL = Arg0
			 Local0 = Zero
	-                If ((\_SB.PCI0.PRES.CPRS == One))
	+                If ((\_SB.PCI0.PRES.CPEN == One))
			 {
	-                    If ((\_SB.PCI0.PRES.CPEN == One))
	-                    {
	-                        Local0 = 0x0F
	-                    }
	-                    Else
	-                    {
	-                        Local0 = 0x0D
	-                    }
	+                    Local0 = 0x0F
			 }

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h   |  41 ------------------
 tests/data/acpi/x86/pc/DSDT                   | Bin 8560 -> 8526 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8471 -> 8437 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9885 -> 9851 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15431 -> 15397 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9024 -> 8990 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10214 -> 10180 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8511 -> 8477 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5067 -> 5033 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8632 -> 8598 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9919 -> 9885 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8418 -> 8384 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8566 -> 8532 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12353 -> 12319 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8389 -> 8355 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8406 -> 8372 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9714 -> 9680 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8668 -> 8634 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8435 -> 8401 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12002 -> 11968 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12947 -> 12913 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33804 -> 33770 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8853 -> 8819 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13180 -> 13146 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10043 -> 10009 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8464 -> 8430 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8477 -> 8443 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8406 -> 8372 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9748 -> 9714 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9519 -> 9485 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13242 -> 13208 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8269 -> 8235 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8247 -> 8213 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8395 -> 8361 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8490 -> 8456 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12947 -> 12913 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33804 -> 33770 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8995 -> 8961 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9021 -> 8987 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18623 -> 18589 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14646 -> 14612 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35752 -> 35718 bytes
 42 files changed, 41 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 512d40665d..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,42 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/pc/DSDT",
-"tests/data/acpi/x86/pc/DSDT.acpierst",
-"tests/data/acpi/x86/pc/DSDT.acpihmat",
-"tests/data/acpi/x86/pc/DSDT.bridge",
-"tests/data/acpi/x86/pc/DSDT.cphp",
-"tests/data/acpi/x86/pc/DSDT.dimmpxm",
-"tests/data/acpi/x86/pc/DSDT.hpbridge",
-"tests/data/acpi/x86/pc/DSDT.hpbrroot",
-"tests/data/acpi/x86/pc/DSDT.ipmikcs",
-"tests/data/acpi/x86/pc/DSDT.memhp",
-"tests/data/acpi/x86/pc/DSDT.nohpet",
-"tests/data/acpi/x86/pc/DSDT.numamem",
-"tests/data/acpi/x86/pc/DSDT.roothp",
-"tests/data/acpi/x86/q35/DSDT",
-"tests/data/acpi/x86/q35/DSDT.acpierst",
-"tests/data/acpi/x86/q35/DSDT.acpihmat",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
-"tests/data/acpi/x86/q35/DSDT.applesmc",
-"tests/data/acpi/x86/q35/DSDT.bridge",
-"tests/data/acpi/x86/q35/DSDT.core-count",
-"tests/data/acpi/x86/q35/DSDT.core-count2",
-"tests/data/acpi/x86/q35/DSDT.cphp",
-"tests/data/acpi/x86/q35/DSDT.cxl",
-"tests/data/acpi/x86/q35/DSDT.dimmpxm",
-"tests/data/acpi/x86/q35/DSDT.ipmibt",
-"tests/data/acpi/x86/q35/DSDT.ipmismbus",
-"tests/data/acpi/x86/q35/DSDT.ivrs",
-"tests/data/acpi/x86/q35/DSDT.memhp",
-"tests/data/acpi/x86/q35/DSDT.mmio64",
-"tests/data/acpi/x86/q35/DSDT.multi-bridge",
-"tests/data/acpi/x86/q35/DSDT.noacpihp",
-"tests/data/acpi/x86/q35/DSDT.nohpet",
-"tests/data/acpi/x86/q35/DSDT.numamem",
-"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
-"tests/data/acpi/x86/q35/DSDT.thread-count",
-"tests/data/acpi/x86/q35/DSDT.thread-count2",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
-"tests/data/acpi/x86/q35/DSDT.type4-count",
-"tests/data/acpi/x86/q35/DSDT.viot",
-"tests/data/acpi/x86/q35/DSDT.xapic",
diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index f68a32e6068788c3fdfaff139206b725ba2bf1d1..8b8235fe79e2fa08a6f840c8479edb75f5a047b9 100644
GIT binary patch
delta 76
zcmez1bk2#(CD<jzPmzIvF>@o=P99EwyZB(I_~<5&$!B=t7&Rtq^C~bgFi#HR)nM{9
go?OFg#^%B1930{}*^W<-i6LR~e_rX$3VZ>=07R=4p8x;=

delta 125
zcmX@-^udYCCD<jTK#_rgao0w!ojjb5j`6`x@zG7blh5$PG3rj%=2c*K4hRZnWMG=?
z%d5fUWjeW>*Nn-PWAb`lQ#13)G5RbZ4FS%c1_42?!C<8eq%ehD{TK_l_!Abg7I5)y
J{>vLE3;@@vBVGUi

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index 0fd79699ebbfb650a5bbe49faecbebf2fc13a86c..06829b9c6c6d726d955dc7c99bc9f42448e22aeb 100644
GIT binary patch
delta 76
zcmV-S0JHy>LiIrkL{mgm^&kKM0kW|QxeN(UK3`KpUt5AmlgtcW0VtCz4Ilyl1Cvq>
iC<0A0lY9*}21o`&Q&d5dJ`OGd0AQ2<4I8r{4)+pssulqN

delta 125
zcmezBINgcMCD<iIT#<o+k!d5>P99E2$M|5U_~<6z$!B=t7<DIW^D3}A2LuH(GB8c{
z<<(&FGM!w`YsTctF?l_&shRoY7=0Fyh5%<zgMc8{V6f5!QkcT7evAcN{0R$L3%GbU
J|K<H51OP~<BESFu

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index a4dd09e5ef71a47c31be0d9a57e93767f5d15b3c..2fe355ebdbb858fa9247d09112e21712e3eddc45 100644
GIT binary patch
delta 73
zcmV-P0Ji^~P5Vp=L{mgmdnNz?0Vc5uxeN(TL|;=vUt5AmlgtcW0VtCz4Ilyl1Cvq>
fC<075lY9+90!RjvzYR5$3l18Skq{NLKn`6P2n`eu

delta 108
zcmezEGuM~PCD<iot{MXaWBEp|ojjZl?(xA+@zG7blh5$PG3rj%=2c*K4hRZnWMG=?
z%d5fUX+61|*OAGUWAZLuQ!(?&G5RbZ4FS%c1_42?!C<A6-|<SbEo3d=;!T)*kzaJP
I9AB&i0HJIifdBvi

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index 7ef58152d281c1e2c8da5b15bd30f23e61439d69..4d4067c182a6625db1e877408eb7436113884b50 100644
GIT binary patch
delta 76
zcmX?Jv9yBACD<iI)rNtAv3w)fP99EwyZB(I_~<5&$!B=t7&Rtq^C~bgFi#HR)nM{9
go?OFg#^%B1930{}*^W<-i6LR~e_rX$3ViB%082#_s{jB1

delta 125
zcmZ2lalC@dCD<jz-G+gI@x(^1ojjb5j`6`x@zG7blh5$PG3rj%=2c*K4hRZnWMG=?
z%d5fUWjeW>*Nn-PWAb`lQ#13)G5RbZ4FS%c1_42?!C<8eq%ehD{TK_l_!Abg7I5)y
J{>!VO2LR(fBWeHu

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index 1079ff81c1ab05f0d5991835b3a0b014687924f4..045a52e75b7fcd4e5f840a758c548231498b96e4 100644
GIT binary patch
delta 69
zcmV-L0J{IcMxI6rL{mgm9wPt%0nM=rxeN(UTVGQ`Ut5AmlgtcW0VtCz4Ilyl1Cvq>
bC<0ATlY9+w0!Rjv@C`MSJPsPOTn^+E!a5Wv

delta 108
zcmbQ|cEF9xCD<jzL79PpQEnsGP99FjxcFeF_~<6z$!B=t7<DIW^D3}A2LuH(GB8c{
z<<(&F3YuKbTg2qbG5IyGshIiX7=0Fyh5%<zgMc8{V6f83@_f>43t0=ecoQZs5D?w$
I&v#w~08Tv}v;Y7A

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 34fe3fcad9dc245eb173ca5a9655d17f15bd42ef..205219b99d903555125c4b07fc047c42993eb338 100644
GIT binary patch
delta 96
zcmaFnf5e~5CD<k8h&lrU<IIg*XL&e10^)<6;-i~9CO_bbW7L>z&#S=1z&tsPSA)sT
zb@Bw>NG1=q$**}$rKBdu=(B*-1~_{f1O&MTI|sP>F&1#~Crp+X5Z#=^S0xDmhw>Y!

delta 103
zcmX@&|IDAuCD<k8nK}al<L!-HXL&fig5ran;-i~<CqLkcW7M5&&#S=h91s-D$iOr?
zkynGs*?n?1ZzPi|$K+?crefxkWAs@-8Uma>4FZB(gTYECOYupwE@Um>;@xb*H$f5r
Dad91&

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 33c7529f5c8a6ec651f979b3cebadb18774a781f..8fa8b519ec65bd5099c45f4e1c85b11b47a23845 100644
GIT binary patch
delta 76
zcmdn*G}npCCD<iIR*`{$aqdR0ojjcWcJaYZ@zG5llh5$PF=|ZK=2c)~V4fVrtHI=J
gJh_I~jLn11IXJ{|vK^lu6GOt}|Gd(h75L<Z0Vh}#4*&oF

delta 125
zcmbR1wBL!#CD<jzUXg);@!dwQojjb5j`6`x@zG7blh5$PG3rj%=2c*K4hRZnWMG=?
z%d5fUWjeW>*Nn-PWAb`lQ#13)G5RbZ4FS%c1_42?!C<8eq%ehD{TK_l_!Abg7I5)y
J{>!T%3;?JoBF+E+

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
index 2661170c833e23ae1985d31512a81a29afc858bd..01719462a72fd6d40ce433dac601e4b94eae574c 100644
GIT binary patch
delta 98
zcmX@DzEYjbCD<ior7!~nWA8?;9Bxj3yZB(I_~<5&$@ScEj2e^gaVsz}Fi&RX(O~j5
zo~+Mf#^%B1930{}`6G{>3`4>KsmU?=EFdib&YlJVL9W5h0j_?G1zh}_FY)|j0{}jp
B8;bw{

delta 131
zcmZ3fep;Q&CD<k8v@in$<GqbsIozC%j`6`x@zG7blk2(T7<DJ#<5pmI4hRZnWMG=a
zqrv25I$4XyjLnt9IXJ{|@_8OTONN96=96ReSwPwXoIMQ!f?R{a8Wu=l3cLC-7I5(=
PEMzU<;@!M~=O-HgoMa_l

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 688faf83cbd7395e1112ba04303d66e11934bf8d..0ca664688b16baa3a06b8440181de4f17511c6b0 100644
GIT binary patch
delta 76
zcmV-S0JHzNLzY7dL{mgmmLUKD0p+m@xeN(UK3`KpUt5AmlgtcW0VtCz4Ilyl1Cvq>
iC<0A0lY9*}21o`&Q&d5dJ`OGd0AQ2<4I8r{4ww^F-xWOo

delta 125
zcmbQ{yu+ExCD<iohav+5quEBTojjb5j`6`x@zG7blh5$PG3rj%=2c*K4hRZnWMG=?
z%d5fUWjeW>*Nn-PWAb`lQ#13)G5RbZ4FS%c1_42?!C<8eq%ehD{TK_l_!Abg7I5)y
J{>wX47yyb?BK!aV

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 6ede4361f4b7bf18c496d7ca117310675126bbbf..03ff464ba4e72082fce0921815cfc09ca20b561a 100644
GIT binary patch
delta 76
zcmV-S0JHzUO`S~&L{mgmohASP0b8*OxeN(KKVMTqUt5AmlgtcW0VtCz4Ilyl1Cvq>
iC;~$?lY9*}21o`&Q&d5dJ`OGd0AQ2<4I8r{4xbo4h!ooZ

delta 125
zcmbR1yWf|~CD<iozZwGr<J^s0J9#+W9pi(Y;-i~<C!gVoW7M6j&8xuf91s-D$iOt&
zmsf+y!EACluNjjo$K>_Are@}oWAs@-8Uma>4FZB(gTYD{NMQ=Q`Y{%8@h2=~E#Tta
J{Firu1OUv#BbopJ

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index 9d6040733f57f243056ee8f7601af84dd3cf2fa2..b081030f0ed171e52b13e28cfdc8770a04c2806e 100644
GIT binary patch
delta 76
zcmV-S0JHz%LBK%@L{mgmz#sqs0W+}*D+~!wK3`KpUt5AmlRgYy0VtE53?Kpk1CzuI
iC<0A0lkN;Q21o`&Q&d5dunjH(0AQ1G4I8tP4Nwz7&=p4j

delta 125
zcmX@$_{fpVCD<k8kpcq)W6MS^Z5~cX$M|5U_~<6z$#y((jJlKO@+h!72LuH(GB8cv
z&!fTQWjgsKj~SCI$7DrbQ#13)G5RbZ4FS%c1_42?!C<8eq%ehD{TK_l_!Abg7I5)y
J&gTsj1^~BOB9;IE

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index aa9986f74bbd9f20ea9c886901a34122700f33b2..2c98cafbff5db04410b35a1151eaf18723a4dad7 100644
GIT binary patch
delta 76
zcmez7bj69wCD<h-M3I4kQFtTQP99EI`}km|_~<5&$!B=t7&Rtq^C~bgFi#HR)nIZq
gnOwtb#^%B1930{}*^W<-i6LR~e_rX$3VdP005SR$PXGV_

delta 125
zcmccO^v#LOCD<jTOp$?sF?1u>P99Eo$M|5U_~<6z$!B=t7<DIW^D3}A2LuH(GB8c{
z<<($vFq>S?YsTctF?l_&shRoY7=0Fyh5%<zgMc8{V6f5!QkcT7evAcN{0R$L3%GbU
J|K$xA1^~2IBMtxn

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index 86c2ae11dc601008cd4dbbbd34d4e5adcb9236cd..da018dca9e3102e811107994248719ab5278c505 100644
GIT binary patch
delta 76
zcmX?@Fh7CICD<iI-hhFD@#{veojjcWcJaYZ@zG5llh5$PF=|ZK=2c)~V4fVrtHI=J
gJh_I~jLn11IXJ{|vK^lu6GOt}|Gd(h75EgD08^tB$p8QV

delta 125
zcmbQAa4><(CD<jz(SU)0(QPBwP99E2$M|5U_~<6z$!B=t7<DIW^D3}A2LuH(GB8c{
z<<(&FGM!w`YsTctF?l_&shRoY7=0Fyh5%<zgMc8{V6f5!QkcT7evAcN{0R$L3%GbU
J|K(Lu0sw`~B8UJ0

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index b0bbff7686c9a56129bfa3408e62f142cc482713..fb89ae0ac6d4346e33156e9e4d3718698a0a1a8e 100644
GIT binary patch
delta 76
zcmX@=xY&`)CD<iou>u1FqxnWIc1ccuyZB(I_~<5&$x@PWj2e?GB^8($m?tlg)L`;8
go_tEujLn11IXJ{|a*vcA6GOseUn%L$c~aqQ02K=qHUIzs

delta 108
zcmZ4Nc+`>0CD<k8r~(56W5-4=c1cc0$M|5U_~<6z$x@PWjJlI6B^B761A>AX8JH%|
zmegSKGM#)>(u~QKWAa}~Q!(?&G5RbZ4FS%c1_42?!C<A64W*>n7P1y_@g_{(C?mQ#
IQOb!80A}|c$^ZZW

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index f91cbe55fcfeea319babf7c9a0c6a6ccdc3320d1..46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b 100644
GIT binary patch
delta 76
zcmccSxW$pnCD<ioivj}!<MoYP?2?@RcJaYZ@zG5llcgl%7&RtWN-8ihFi&0}slnuH
gJo%KQ8Jh>2b8v{`<Q^$KCWeH`zEaYg^Q1D^07_OB8UO$Q

delta 108
zcmdnuc+HW^CD<k8ngRm@qsB%qc1cc0$M|5U_~<6z$x@PWjJlI6B^B761A>AX8JH%|
zmegSKGM#)>(u~QKWAa}~Q!(?&G5RbZ4FS%c1_42?!C<A64W*>n7P1y_@g_{(C?mQ#
IQ7V`X09c|Ot^fc4

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index 0949fb9d67c70dc882e50501ece421114ad8080b..61c5bd52a42242e85090934e8e45bf01642609d6 100644
GIT binary patch
delta 96
zcmez5eZiZ{CD<k8f+_<8<Cl$G?2?>*F7d%m@zG5llcgl%7&RtWN-8ihFi&0}slnu9
zIr)^NBa;W)WL_y#DXGaZ`Ya%|0nVNV0YR?8&H=7|j0If$36mXVL^t<IrEmiPOXnKE

delta 122
zcmccM{mGllCD<k8lPUuPqw7X4c1cbL_xNC^_~<6z$x@PWjJlI6B^B761A>AX8JH%|
zmegSKw4Qua(vj1Z!#Oy_kuzF(vZ9Re<ZdYmNrr?4=96ReSwPwYoIMQ!f?R{a8YkOG
WNwY0vE#Tr!m@F?Nx;aNGg&P1RK_K`5

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index 0fa4daa35cf95f93ba8c15f478460fe4e14e6d9e..3aaa2bbdf54a0d0cade14421e84c6ec5a42f96fa 100644
GIT binary patch
delta 76
zcmV-S0JHzxL%Kr>L{mgmx*-4n0ll#b2N?-QP+wC*Ut5AmlNuRb0VtDs86W}x1CyW`
iC;~)9lgb%c21o`&Q&d5duNp1_0AQ1F8XL2b8cPRMBNdqd

delta 125
zcmdnxe8-u~CD<k8jv@mC<Nu9Z?2?=wLGi&(@zG7blcgl%7<DICN-D5B2LuH(GB8b^
zEvdoe=sx+VWF(U-$7BU5Q#13)G5RbZ4FS%c1_42?!C<8eq%ehD{TK_l_!Abg7I5)y
J&Xe+C2LRVvBHRD~

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index a5d032b7d96113c9393036b2ba831adb6d584142..944209adeaa5bbb722431161c404cb51b8209993 100644
GIT binary patch
delta 76
zcmezDc+ru|CD<k8q5=a0qxwcJc1ccuyZB(I_~<5&$x@PWj2e?GB^8($m?tlg)L`;8
go_tEujLn11IXJ{|a*vcA6GOseUn%L$c~Y%x062vd-T(jq

delta 108
zcmccU_}P)mCD<k8vjPJHW5q@;c1cc0$M|5U_~<6z$x@PWjJlI6B^B761A>AX8JH%|
zmegSKGM#)>(u~QKWAa}~Q!(?&G5RbZ4FS%c1_42?!C<A64W*>n7P1y_@g_{(C?mQ#
IQL2Cq0GY8KasU7T

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index 3464f552974672bde25eb15f1c93c309c57ef5cb..d9938dba8fa5d405f7696c0dbdc24f3ae42ec934 100644
GIT binary patch
delta 76
zcmaD9dmxs}CD<k8fF1(_WAH{Uc1ccuyZB(I_~<5&$x@PWj2e?GB^8($m?tlg)L`;8
go_tEujLn11IXJ{|a*vcA6GOseUn%L$c~T`J07!fl8UO$Q

delta 108
zcmX>Q`zV&nCD<k8ksbpB<C2YB?2??0j`6`x@zG7blcgl%7<DICN-D5B2LuH(GB8b^
zEvdoeWjgt&q#2Vd$K=0~refxkWAs@-8Uma>4FZB(gTYEC8%jyDEo3d=;!T*mQATug
IqEx&H0I`T3t^fc4

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index 08f5d5f54bcb61235b98fc85bb814046dd038c13..a24b04cbdbf09383b933a42a2a15182545543a87 100644
GIT binary patch
delta 71
zcmV-N0J#5?W$|PRL{mgmaWVh^0k5$N2N?>DTLE8FLSI{gNRt~GUI8eRdKn-B00Wbu
d87KmZP_xS!vjPH029tmsHIvL78nf&irxpI;78U>i

delta 110
zcmeyEGC7sYCD<iovJnFV<HwC$?2=slv5fJ-PVv!AzLTXT;}~@(S4k?cI|l>>Gcqtu
zo+GKj)E>0?nB-<ACRdKh)iS1H=96ReSwK1hoIMQ!f?R{aYA3Ikk!D-STENAdFxfy}
Kbn|_gNumG_&>%qo

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index d29a7108f82110ce9f9b4e006501215d41c5420a..3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8 100644
GIT binary patch
delta 100
zcmeC_V0zWg#N`s~67s5<fq{{6BNw|QS6eY#e6Uk|bd$$qX~{T7jmcG#3QP>llNU;A
zFg0gvJ}nu~!{os>Sx3!ON@{Y9J_|^3fU~DTK#*&&bAYQKV*wX`!sJ8^(ames;$s1w
CTO4Nq

delta 126
zcmaFW&eYSv#N`s~62jBMz`*FVk&9iDtD}@HKG-Qfy2*F4v}7Ek?&K;-1$O6vpkPJ@
zrpa?8HJBQ*HXoCW=izkaa1IV}<cwCH?5H6;d6k-kBtyai^T{##EFk>>&YlJVL9W4I
aos*;0q}dj-7I5(<Ot#k$-Q2Af9}57JAR_hv

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 7fd59bf6702c04a622f05ae356a2ea37312ab403..20955d0aa30120553da35d5a6640055d26255cf9 100644
GIT binary patch
delta 73
zcmV-P0Ji^?Me{@oL{mgmb0Po$0h_T32N?-ZTVGQ`Ut5AmlNuRb0VtDs86W}x1CyW`
fC<0ATlgb%#0!RjvJ{mQXiW(Y|5FHh>zZ%vD0Bsc$

delta 108
zcmezDGS!vKCD<iosuBYO<C~3K?2??0aq+=U@zG7blcgl%7<DICN-D5B2LuH(GB8b^
zEvdoe6*T#%WD%1q$7D+>Q!(?&G5RbZ4FS%c1_42?!C<A6bETx&7P1y_@g__TkP+QH
ISLzx&0Ea9dh5!Hn

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index 613a40b957dab99fd97b465bd89f6afac3a5b047..3c34d4dcab16783abe65f6fa5e64eb69d40795fb 100644
GIT binary patch
delta 76
zcmey9b}Nm`CD<h-%9w$HF?%ByyCkQ-U3{=pd~}n?WGTrwMvcjpk_t==%##;LYB2d4
gPd+7S#^%B1930{}xkpNmi6LRKuaxxWJSjd&07#7#wg3PC

delta 108
zcmcbW_9u<YCD<jT#+ZSDanD9Bc1cc0$M|5U_~<6z$x@PWjJlI6B^B761A>AX8JH%|
zmegSKGM#)>(u~QKWAa}~Q!(?&G5RbZ4FS%c1_42?!C<A64W*>n7P1y_@g_{(C?mQ#
IQR=4z0JAtBNdN!<

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index 1db0bf454a203006f866e6752d06422ae675cbd3..228374b55bd544116e359f659e546fc66cf8a895 100644
GIT binary patch
delta 91
zcmdn(H`9;HCD<iIQk{W;F>NE4v?QlTKzy)Md~}n?WIf3^Mvck6k_t==%#*iBYB0IE
tPQE7@$>hN{*;2|>QfhLHJ_|@~fU~DTK#*&&bAYQKV*wZc<|R_oc>rS!7_9&R

delta 132
zcmbQ~x7&})CD<jzTAhJ`am7Y1X-Q76p!i^?_~<6z$$FA;jJlJ1B^B761A>AX8JH%o
zm(*Z#cAtDxGLp@e!#Oy_aq>bbJxhj!1?H1u^jSdq0-QY!0)kwF!8#U5VG6tYF&1#~
QCoE(w;NsofBsHA}0HD?-HUIzs

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 25f43ae8efb55364a739e6b5e3cb4e71e61862b0..45f911ada5645f158f3d6c0c430ec1d52cadc5d8 100644
GIT binary patch
delta 76
zcmbQ>^v;pXCD<k8odN>`WA;Wac1ccuyZB(I_~<5&$x@PWj2e?GB^8($m?tlg)L`;8
go_tEujLn11IXJ{|a*vcA6GOseUn%L$c~Xnm06Z5J7XSbN

delta 108
zcmaFoIKhd_CD<iIK#_rgarZ_pc1cc0$M|5U_~<6z$x@PWjJlI6B^B761A>AX8JH%|
zmegSKGM#)>(u~QKWAa}~Q!(?&G5RbZ4FS%c1_42?!C<A64W*>n7P1y_@g_{(C?mQ#
IQL2{>06xVXs{jB1

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index 32bcd25bda9e9d2775790385f8da6a11e9d5cb46..e5d6811bee1233d74236453c49060390d74d4416 100644
GIT binary patch
delta 76
zcmV-S0JHy{Li<4qL{mgm`yc=S0o<_)2N?-ZK3`KpUt5AmlNuRb0VtDs86W}x1CyW`
iC<0A0lgb%321o`&Q&d5dj2bQi0AQ0%8XL228m|Uoloh-H

delta 108
zcmezEIM<2GCD<iIR*`{$QD-9;yCkQhV|=hvd~}oVWGTrwM%~Gkk_zn30YSlx3`~<}
zOKLEAnNB_`X~yKrG5N2gshIiX7=0Fyh5%<zgMc8{V6f83hEmdO3t0=ecoQaXlo8#W
IC^d@>02)FaPyhe`

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index f91cbe55fcfeea319babf7c9a0c6a6ccdc3320d1..46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b 100644
GIT binary patch
delta 76
zcmccSxW$pnCD<ioivj}!<MoYP?2?@RcJaYZ@zG5llcgl%7&RtWN-8ihFi&0}slnuH
gJo%KQ8Jh>2b8v{`<Q^$KCWeH`zEaYg^Q1D^07_OB8UO$Q

delta 108
zcmdnuc+HW^CD<k8ngRm@qsB%qc1cc0$M|5U_~<6z$x@PWjJlI6B^B761A>AX8JH%|
zmegSKGM#)>(u~QKWAa}~Q!(?&G5RbZ4FS%c1_42?!C<A64W*>n7P1y_@g_{(C?mQ#
IQ7V`X09c|Ot^fc4

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index be90eb71d8dda8fe54c79ffffe103986ee06ae3a..5ce081187a578ba7145a9ba20d30be36c13b7663 100644
GIT binary patch
delta 76
zcmbQ@^U0gbCD<k8lPUuPqvl2~c1ccG`}km|_~<5&$x@PWj2e?GB^8($m?tlg)L?Qp
gnS4spjLn11IXJ{|a*vcA6GOseUn%L$c~Z-`0W+Tz@c;k-

delta 108
zcmez5J;jI1CD<iIM2&%gF>50iyCkQ(V|=hvd~}oVWGTrwM%~Gkk_zn30YSlx3`~<}
zOKLDVm`y$^X~yKrG5N2gshIiX7=0Fyh5%<zgMc8{V6f83hEmdO3t0=ecoQaXlo8#W
IC^eBA05Cxvg#Z8m

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index 01f276a6aff38a1d4f58640a9e6d120fc9a04b61..bdf36c4d575bfc4eb2eac3f00c9b7b4270f88677 100644
GIT binary patch
delta 76
zcmZ4Q)$7IO66_MftIEK@_;Mo`yCkQpeSEM}d~}n?WGTrwMvcjpk_t==%##;LYA`vQ
gOg<%P#^%B1930{}xkpNmi6LRKuaxxWJgI|R01#LdnE(I)

delta 108
zcmeD6TJOc>66_M9ugbu{sJ)SkU6Rw?F+SKSKDx<wvXo>TqweHNNd<Q2fS_PT2Byig
zB{i5F%qAa|G-Gn*nEY4LRLp#Gj6MrULx8iVK|qjeFj(niLn&#tg{%c!ya|&x%7|`G
Ilv=|D00OujEdT%j

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 1bd2ee8d2ebd3c9e0ed89a86478691f2e06f2590..1db43a69e4c2affd8bd678bbef4d3c228380288e 100644
GIT binary patch
delta 76
zcmdm$J|msWCD<iohA{&Jqt8Yzc1ccuyZB(I_~<5&$x@PWj2e?GB^8($m?tlg)L`;8
go_tEujLn11IXJ{|a*vcA6GOseUn%L$c~U--04u2!kpKVy

delta 108
zcmbP{zAK%}CD<iomoWna<J^s0?2??0j`6`x@zG7blcgl%7<DICN-D5B2LuH(GB8b^
zEvdoeWjgt&q#2Vd$K=0~refxkWAs@-8Uma>4FZB(gTYEC8%jyDEo3d=;!T*mQATug
IqLjHL0EhJ+B>(^b

diff --git a/tests/data/acpi/x86/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
index 45cc2bcffa42d73db110afd5075556dcfe5d9936..8bc16887e1c963c61aaecf71712a09c0554f6d67 100644
GIT binary patch
delta 75
zcmX@>u-bvkCD<iITY-Ur@zh4HUE-YncJaYZ@zG5llh2CBF=|ZKkx*b_V4fT-p~2*9
fJh@iFjLn11IXJ{|vc04p6GOrzN$Jgsk~-`FEX)(a

delta 125
zcmZ4OaMpp#CD<jzSAl_nQF<fSE^$sr$M|5U_~<6z$!Epm7<DJ>NGPy72LuH(GB8c{
zlh9!DGM!u@VaDXjF?oZ8shRoY7=0Fyh5%<zgMc8{V6f5!QkcT7evAcN{0R$L3%GbU
J|C7*V2LN@gB6R=&

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index f110504b9c813aa07802fc17d2869596a2eeca6f..c13e45e3612646cc2e30f00b3b7e53335da816ea 100644
GIT binary patch
delta 76
zcmdn)Fx7#}CD<iIRDpqkkzpfOr39zHU3{=pd~}n?<Q|DQMvcj@B@~z#m?sNKYB2d4
gPqvXXWAk8h4i0gg{7+Jki6LR~eo5)g4<y6c00jRO-2eap

delta 125
zcmbR0u-$>nCD<jzT!DdsF>oVSr39y=V|=hvd~}oV<Q|DQM%~G;B^2151A>AX8JH&X
zN@_59nNBvBG-Gn*n4B+ZYGyt;MxO<wA;8(wARx#!7_4-G6sEANA7cR*f5Jl60xsUo
IdnF^-07yk4(f|Me

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index 6090958f39875f5806e72e23f32cb4b3ae840627..ba6669437e65952f24516ded954b33fe54bdedfb 100644
GIT binary patch
delta 76
zcmX@@xYCi!CD<ior2+#3<HL<y?2??W_VK|^@zG5llcgl%7&RtWN-8ihFi&0}slnuI
gGWnFG8Jh>2b8v{`<Q^$KCWeH`zEaYg^Q2<g06<z4<^TWy

delta 108
zcmZ4Kc-oQ6CD<k8v;qSIqw+>Bc1ccm$M|5U_~<6z$x@PWjJlI6B^B761A>AX8JH%|
zmegQ!Fq?c-(u~QKWAa}~Q!(?&G5RbZ4FS%c1_42?!C<A64W*>n7P1y_@g_{(C?mQ#
IQObi207+UMdH?_b

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index 7a8e568315a43f1fa98068d8e78995c98064fb91..6ad42873e91c80cef5a42224cb4d31936dad59b4 100644
GIT binary patch
delta 76
zcmZ4G)ZxVC66_Mfp~%3%_;Mo`yCkQ-U3{=pd~}n?WGTrwMvcjpk_t==%##;LYB2d4
gPd+7S#^%B1930{}xkpNmi6LRKuaxxWJgGfw010Fie*gdg

delta 108
zcmeBhTIIy$66_M9rO3d*Xtj}xU6Rw$F+SKSKDx<wvXo>TqweHNNd<Q2fS_PT2Byig
zB{i75OeY_eG-Gn*nEY4LRLp#Gj6MrULx8iVK|qjeFj(niLn&#tg{%c!ya|&x%7|`G
Ilv>UP0Qtck6951J

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index 08f5d5f54bcb61235b98fc85bb814046dd038c13..a24b04cbdbf09383b933a42a2a15182545543a87 100644
GIT binary patch
delta 71
zcmV-N0J#5?W$|PRL{mgmaWVh^0k5$N2N?>DTLE8FLSI{gNRt~GUI8eRdKn-B00Wbu
d87KmZP_xS!vjPH029tmsHIvL78nf&irxpI;78U>i

delta 110
zcmeyEGC7sYCD<iovJnFV<HwC$?2=slv5fJ-PVv!AzLTXT;}~@(S4k?cI|l>>Gcqtu
zo+GKj)E>0?nB-<ACRdKh)iS1H=96ReSwK1hoIMQ!f?R{aYA3Ikk!D-STENAdFxfy}
Kbn|_gNumG_&>%qo

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index d29a7108f82110ce9f9b4e006501215d41c5420a..3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8 100644
GIT binary patch
delta 100
zcmeC_V0zWg#N`s~67s5<fq{{6BNw|QS6eY#e6Uk|bd$$qX~{T7jmcG#3QP>llNU;A
zFg0gvJ}nu~!{os>Sx3!ON@{Y9J_|^3fU~DTK#*&&bAYQKV*wX`!sJ8^(ames;$s1w
CTO4Nq

delta 126
zcmaFW&eYSv#N`s~62jBMz`*FVk&9iDtD}@HKG-Qfy2*F4v}7Ek?&K;-1$O6vpkPJ@
zrpa?8HJBQ*HXoCW=izkaa1IV}<cwCH?5H6;d6k-kBtyai^T{##EFk>>&YlJVL9W4I
aos*;0q}dj-7I5(<Ot#k$-Q2Af9}57JAR_hv

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index 29a416f0508655d2bfde01fff4d25ad7f89581d9..e381ce4cbf2b11f56a2d0537db4d21acc97450c9 100644
GIT binary patch
delta 76
zcmZ4N*67CN66_MfsLa5?n7)yVU6Rw^E<V^PKDx<cvXo>TqsHV)Nd+bb=E(~rHJE&j
gC!dluWAk8h4i0gg+#{vO#E>xAS4w(wp43(j0Oqn2?EnA(

delta 108
zcmZp4TkOW=66_M9tjxf`xML$1yCkQhV|=hvd~}oVWGTrwM%~Gkk_zn30YSlx3`~<}
zOKLEAnNB_`X~yKrG5N2gshIiX7=0Fyh5%<zgMc8{V6f83hEmdO3t0=ecoQaXlo8#W
ID7AnC03(eZfdBvi

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index 59288f02c43cf2efc1555599131fde05dbbaa1cd..a09253042ce4a715922027245de8a2ab7449c5b7 100644
GIT binary patch
delta 76
zcmdn%HrtKMCD<iITA6`?QE?*|yCkQ-U3{=pd~}n?WGTrwMvcjpk_t==%##;LYB2d4
gPd+7S#^%B1930{}xkpNmi6LRKuaxxWJgM^>0PFk|4*&oF

delta 108
zcmbR3w%3izCD<jzR+)i;v1lU~yCkQhV|=hvd~}oVWGTrwM%~Gkk_zn30YSlx3`~<}
zOKLEAnNB_`X~yKrG5N2gshIiX7=0Fyh5%<zgMc8{V6f83hEmdO3t0=ecoQaXlo8#W
ID7A|N04diUqW}N^

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index eaca76e8e61eb62f75dbdf093e803eea34330deb..edc23198cdb47a981bcbc82bc8e392b815abb554 100644
GIT binary patch
delta 106
zcmdl#k#X)sMlP3Nmyo$03=E97H*&E{a&_)wiVt>*k8bjqEG-$ws4=-pQh|wqdGbO@
z4W_oun@>xgW@Yzaa}Ex1<ec27AU;V+Ookz0fz;#}eHM_u0B28wfFRdk=Kxnf#sV(>
J&CCjWGytMf9?Ad!

delta 135
zcmbO`k#YY-MlP3NmyrD)3=E928@bpexw;Q9#RogZM>qLSmX?fT)SX-<sle_W5ERVF
zz%+S|qy|&-*3HKxPqVVQaySQvI8IW~vt&qEU_LoUp9Q2Zz}eFvAjmZstYd)`rm(9Y
UV*wX`!a~*pF5b-#<@aa+0B74LfB*mh

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index de0942a13dc65b75e78e66ee8df904b31bf6079a..4c93dfd5c4b362714d3f9aa606a838d4625b3369 100644
GIT binary patch
delta 76
zcmdm1G^L2kCD<iI#FBx5k#i##yCkQ-U3{=pd~}n?WGTrwMvcjpk_t==%##;LYB2d4
gPd+7S#^%B1930{}xkpNmi6LRKuaxxWJgF0M0RLeWUjP6A

delta 108
zcmbPIw5^ECCD<jz%#wkDF=`_hyCkQhV|=hvd~}oVWGTrwM%~Gkk_zn30YSlx3`~<}
zOKLEAnNB_`X~yKrG5N2gshIiX7=0Fyh5%<zgMc8{V6f83hEmdO3t0=ecoQaXlo8#W
ID79G*07YCK^8f$<

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index 9059812b5892ba7ac5c9bd312fd9f45a4f59f105..d4acd851c62c956436a436f9fa6d08fc5f370fa7 100644
GIT binary patch
delta 107
zcmZ26ovCd)6PHV{OGsNc0|VpRja=-KTupD;;)9*yqnkV?OH0NvYD}(@RA6FYp1e>}
zgQ@@F=F^g=dD%VKoP$FgIVU%2h)=fC5R+j@SRgeyMxO<wF~Hf=ARx#!*g3$}kFkJ@
Ke>1bj(qsVVzaPi|

delta 135
zcmZph&a`4W6PHV{OUR0D1_nm`ja=-KTrKa};)9*yqnmsuOH0Nv>Q1hbRA6@w2nuFo
zV46HfQiG}I@#bTar+L|2Ih=z-94Be$Su!LnFrOTw&jQjH;OuD-5ab#R*0DeeQ`psy
Tv4D#|VIgY)7w_hW>PwRWojNEz

-- 
2.43.0


