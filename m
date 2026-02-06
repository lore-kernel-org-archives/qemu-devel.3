Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF61EE20A2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voLlg-0007C4-B5; Fri, 06 Feb 2026 08:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1voLlI-000768-UR
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:20:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1voLlG-0005g5-I7
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770384036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OXuss0BgAHi09ltJLjDt0QMiXvX47zpTxxxC3R00SM=;
 b=XvApLOiKiKIWcOlkTgtlow9Lno+sfx6GHo6/ZwNTnwepj6NQikuHifNbIT2It5rEW/7T/s
 XCaPxEdP6Adpq4CVXDKpwdVRb90dR+yfffhW8z6zRHuEvNYd1nkMW8har1+A4+Q6ICia2U
 W1eFLGyN8Vv12xmgUIuoTdNqZSyzEJw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-tup0UNbuMxWYq2b0LWn-hQ-1; Fri,
 06 Feb 2026 08:15:26 -0500
X-MC-Unique: tup0UNbuMxWYq2b0LWn-hQ-1
X-Mimecast-MFC-AGG-ID: tup0UNbuMxWYq2b0LWn-hQ_1770383724
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D97C21830310; Fri,  6 Feb 2026 13:15:15 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8997518003F5; Fri,  6 Feb 2026 13:15:13 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Subject: [PATCH 11/11] tests: acpi: arm/virt: update expected WDAT blob
Date: Fri,  6 Feb 2026 14:14:38 +0100
Message-ID: <20260206131438.1857182-12-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-1-imammedo@redhat.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

replace blank table with a new one:

[000h 0000   4]                    Signature : "WDAT"    [Watchdog Action Table]
[004h 0004   4]                 Table Length : 00000104
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : EB
[00Ah 0010   6]                       Oem ID : "BOCHS "
[010h 0016   8]                 Oem Table ID : "BXPC    "
[018h 0024   4]                 Oem Revision : 00000001
[01Ch 0028   4]              Asl Compiler ID : "BXPC"
[020h 0032   4]        Asl Compiler Revision : 00000001

[024h 0036   4]                Header Length : 00000020
[028h 0040   2]                  PCI Segment : 00FF
[02Ah 0042   1]                      PCI Bus : FF
[02Bh 0043   1]                   PCI Device : FF
[02Ch 0044   1]                 PCI Function : FF
[02Dh 0045   3]                     Reserved : 000000
[030h 0048   4]                 Timer Period : 00000001
[034h 0052   4]                    Max Count : 000927C0
[038h 0056   4]                    Min Count : 00001388
[03Ch 0060   1]        Flags (decoded below) : 81
                                     Enabled : 1
                         Stopped When Asleep : 1
[03Dh 0061   3]                     Reserved : 000000
[040h 0064   4]         Watchdog Entry Count : 00000008

[044h 0068   1]              Watchdog Action : 08
[045h 0069   1]                  Instruction : 00
[046h 0070   2]                     Reserved : 0000

[048h 0072  12]              Register Region : [Generic Address Structure]
[048h 0072   1]                     Space ID : 00 [SystemMemory]
[049h 0073   1]                    Bit Width : 20
[04Ah 0074   1]                   Bit Offset : 00
[04Bh 0075   1]         Encoded Access Width : 03 [DWord Access:32]
[04Ch 0076   8]                      Address : 00000000090D1000

[054h 0084   4]                        Value : 00000001
[058h 0088   4]                Register Mask : 00000001

[05Ch 0092   1]              Watchdog Action : 01
[05Dh 0093   1]                  Instruction : 02
[05Eh 0094   2]                     Reserved : 0000

[060h 0096  12]              Register Region : [Generic Address Structure]
[060h 0096   1]                     Space ID : 00 [SystemMemory]
[061h 0097   1]                    Bit Width : 20
[062h 0098   1]                   Bit Offset : 00
[063h 0099   1]         Encoded Access Width : 03 [DWord Access:32]
[064h 0100   8]                      Address : 00000000090D0000

[06Ch 0108   4]                        Value : 00000001
[070h 0112   4]                Register Mask : 00000007

[074h 0116   1]              Watchdog Action : 06
[075h 0117   1]                  Instruction : 03
[076h 0118   2]                     Reserved : 0000

[078h 0120  12]              Register Region : [Generic Address Structure]
[078h 0120   1]                     Space ID : 00 [SystemMemory]
[079h 0121   1]                    Bit Width : 20
[07Ah 0122   1]                   Bit Offset : 00
[07Bh 0123   1]         Encoded Access Width : 03 [DWord Access:32]
[07Ch 0124   8]                      Address : 00000000090D1008

[084h 0132   4]                        Value : 00000000
[088h 0136   4]                Register Mask : FFFFFFFF

[08Ch 0140   1]              Watchdog Action : 09
[08Dh 0141   1]                  Instruction : 82
[08Eh 0142   2]                     Reserved : 0000

[090h 0144  12]              Register Region : [Generic Address Structure]
[090h 0144   1]                     Space ID : 00 [SystemMemory]
[091h 0145   1]                    Bit Width : 20
[092h 0146   1]                   Bit Offset : 00
[093h 0147   1]         Encoded Access Width : 03 [DWord Access:32]
[094h 0148   8]                      Address : 00000000090D1000

[09Ch 0156   4]                        Value : 00000001
[0A0h 0160   4]                Register Mask : 00000001

[0A4h 0164   1]              Watchdog Action : 0A
[0A5h 0165   1]                  Instruction : 00
[0A6h 0166   2]                     Reserved : 0000

[0A8h 0168  12]              Register Region : [Generic Address Structure]
[0A8h 0168   1]                     Space ID : 00 [SystemMemory]
[0A9h 0169   1]                    Bit Width : 20
[0AAh 0170   1]                   Bit Offset : 00
[0ABh 0171   1]         Encoded Access Width : 03 [DWord Access:32]
[0ACh 0172   8]                      Address : 00000000090D1000

[0B4h 0180   4]                        Value : 00000000
[0B8h 0184   4]                Register Mask : 00000001

[0BCh 0188   1]              Watchdog Action : 0B
[0BDh 0189   1]                  Instruction : 82
[0BEh 0190   2]                     Reserved : 0000

[0C0h 0192  12]              Register Region : [Generic Address Structure]
[0C0h 0192   1]                     Space ID : 00 [SystemMemory]
[0C1h 0193   1]                    Bit Width : 20
[0C2h 0194   1]                   Bit Offset : 00
[0C3h 0195   1]         Encoded Access Width : 03 [DWord Access:32]
[0C4h 0196   8]                      Address : 00000000090D1000

[0CCh 0204   4]                        Value : 00000000
[0D0h 0208   4]                Register Mask : 00000001

[0D4h 0212   1]              Watchdog Action : 20
[0D5h 0213   1]                  Instruction : 00
[0D6h 0214   2]                     Reserved : 0000

[0D8h 0216  12]              Register Region : [Generic Address Structure]
[0D8h 0216   1]                     Space ID : 00 [SystemMemory]
[0D9h 0217   1]                    Bit Width : 20
[0DAh 0218   1]                   Bit Offset : 00
[0DBh 0219   1]         Encoded Access Width : 03 [DWord Access:32]
[0DCh 0220   8]                      Address : 00000000090D1000

[0E4h 0228   4]                        Value : 00000004
[0E8h 0232   4]                Register Mask : 00000004

[0ECh 0236   1]              Watchdog Action : 21
[0EDh 0237   1]                  Instruction : 82
[0EEh 0238   2]                     Reserved : 0000

[0F0h 0240  12]              Register Region : [Generic Address Structure]
[0F0h 0240   1]                     Space ID : 00 [SystemMemory]
[0F1h 0241   1]                    Bit Width : 20
[0F2h 0242   1]                   Bit Offset : 00
[0F3h 0243   1]         Encoded Access Width : 03 [DWord Access:32]
[0F4h 0244   8]                      Address : 00000000090D0000

[0FCh 0252   4]                        Value : 00000004
[100h 0256   4]                Register Mask : 00000004

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/aarch64/virt/WDAT.wdat      | Bin 0 -> 260 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 135186b40b..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/WDAT.wdat",
diff --git a/tests/data/acpi/aarch64/virt/WDAT.wdat b/tests/data/acpi/aarch64/virt/WDAT.wdat
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..bac7a101c3d349e0b9555963526d5e497af27c67 100644
GIT binary patch
literal 260
zcmZ9GK?=e^3`O5`itQ+Z;05B!bJ)6Yr=XzMv8x`d_vs-bX){<F2uVIKpZ~sIUS)tV
zHuv`Sl;-njMMMH%yG;QURR!!G&WZjAU!e9zh#d9_XN(KQ^c>-@SHLFDdhNWGs%q+-
cU-@heSom9+|8B)+-SRH^5~e<7-t%Pr2hLL!0RR91

literal 0
HcmV?d00001

-- 
2.47.3


