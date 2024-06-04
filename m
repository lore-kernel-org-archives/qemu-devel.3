Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6908C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZW9-0006eL-I6; Tue, 04 Jun 2024 15:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZW7-0006Qa-8d
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZW4-000116-5r
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UJLPmNVvDv5Deu6MVO7hyMXSZqetvvQChosK81S0Ks=;
 b=YZcho69rzTkFXo4zlzTcDZykHYXN7v+glsKslzBu2xYzCGMgcQJ7e+PqJRmMolja/NzmC4
 XGYQ4PONq8SkBptvaNDlFBAlNhf59VbQaF/L5CYw6L0wabNbYMY8BJbdC7+8VqbmmLgsi7
 11Tkf3LcWZP0p5kDut2xGEFJAwdvZnU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-MYlgkjtXNCec6_B53rx8xw-1; Tue, 04 Jun 2024 15:08:14 -0400
X-MC-Unique: MYlgkjtXNCec6_B53rx8xw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dced40d17so1015634f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528092; x=1718132892;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7UJLPmNVvDv5Deu6MVO7hyMXSZqetvvQChosK81S0Ks=;
 b=i43LXkVPw1jG5hQ5KkqHCeE/PWTRVzUnZz4BdjDxS8BSGFKlVcqyydPYENfHreqA6k
 6Tb40Vb7ciQYBO5U0Cps77pf54rVtNX0XPkwYzlfY5ubeZ3CQqLY3O/0Ljv/1FOfeMSz
 AjORe7f9VmYmjQegXLse0A/b5xO862HNbTs/SmsJjwXcUcd4/3dWQmGCrZt52ZW76KKy
 ICrj5p1yP3zlMrcDRF3C6gunHCNA2mxIE1HsXFtQFBPeUx5EPTWLdpgkApMATyHVxP0i
 3SL4Om0+0F0ixq2uxdPyEP01AZ3v1VNyvO00FN88fU2AZ20wExutexP4nSu8i7/ZRVBL
 dddw==
X-Gm-Message-State: AOJu0YwkfKsB8JIKBwn85klNA2Sya9yGutfmzinHk8X8ywMqG0k0/iLn
 VsTjsIzHubfkX3Wgg6GbGIeIcOe4G86LqKSYgNgdn0+AWFJ/fZIYaS4VDrPYyUUqtjBsuzDgUDh
 we06BUuYEn2cKhTX8xkvtWowi1Xe+fp9NTvwMtXLycJth1VFCXqdxVzmF2Zu70uCX6EYVM/ozHW
 fXkx5JsOVH768wtrZQDhwKnS8F7+iZpA==
X-Received: by 2002:a05:6000:112:b0:357:5051:2a5c with SMTP id
 ffacd0b85a97d-35e8ef9a3b2mr221105f8f.67.1717528091878; 
 Tue, 04 Jun 2024 12:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEFcrWoaUTM54nNtkE/cgltR7QF0A6VrrLMMQeOi9P9klc7UpEGTwPbOeERT4sZwWsKuMa+g==
X-Received: by 2002:a05:6000:112:b0:357:5051:2a5c with SMTP id
 ffacd0b85a97d-35e8ef9a3b2mr221083f8f.67.1717528091210; 
 Tue, 04 Jun 2024 12:08:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d6e5asm12344537f8f.45.2024.06.04.12.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:08:10 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:08:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 36/46] bios-tables-test: Add data for complex numa test (GI,
 GP etc)
Message-ID: <61cbf56ef1c5dd9dbe6bd6625f6c8d2a82c5697f.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

=46rom: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given this is a new configuration, there are affects on APIC, CEDT
and DSDT, but the key elements are in SRAT (plus related data in
HMAT).  The configuration has node to exercise many different combinations.

0) CPUs + Memory
1) GI only
2) GP only
3) CPUS only
4) Memory only
5) CPUs + HP memory

GI node, GP Node, Memory only node, hotplug memory
only node, latency and bandwidth such that in Linux Access0
(any initiator) and Access1 (CPU initiators only) given different
answers.  Following cropped to remove details of each entry.

[000h 0000 004h]                   Signature : "SRAT"    [System Resource A=
ffinity Table]

[030h 0048 001h]               Subtable Type : 00 [Processor Local APIC/SAP=
IC Affinity]
[032h 0050 001h]     Proximity Domain Low(8) : 00
[033h 0051 001h]                     Apic ID : 00

[040h 0064 001h]               Subtable Type : 00 [Processor Local APIC/SAP=
IC Affinity]
[042h 0066 001h]     Proximity Domain Low(8) : 03                          =
                                                                           =
                                                                           =
                                                      [043h 0067 001h]     =
                Apic ID : 01

[050h 0080 001h]               Subtable Type : 00 [Processor Local APIC/SAP=
IC Affinity]
[052h 0082 001h]     Proximity Domain Low(8) : 05
[053h 0083 001h]                     Apic ID : 02

[060h 0096 001h]               Subtable Type : 01 [Memory Affinity]
[062h 0098 004h]            Proximity Domain : 00000000
[068h 0104 008h]                Base Address : 0000000000000000
[070h 0112 008h]              Address Length : 00000000000A0000

[088h 0136 001h]               Subtable Type : 01 [Memory Affinity]
[08Ah 0138 004h]            Proximity Domain : 00000000
[090h 0144 008h]                Base Address : 0000000000100000
[098h 0152 008h]              Address Length : 0000000003F00000
[0A8h 0168 008h]                   Reserved3 : 0000000000000000

[0B0h 0176 001h]               Subtable Type : 01 [Memory Affinity]
[0B2h 0178 004h]            Proximity Domain : 00000004
[0B8h 0184 008h]                Base Address : 0000000004000000
[0C0h 0192 008h]              Address Length : 0000000004000000

//Comment in hw/i386/aml-build.c on why these exist - not part of
//ACPI requirements.
[0D8h 0216 001h]               Subtable Type : 01 [Memory Affinity]
[0DAh 0218 004h]            Proximity Domain : 00000000
[0E0h 0224 008h]                Base Address : 0000000000000000
[0E8h 0232 008h]              Address Length : 0000000000000000

[100h 0256 001h]               Subtable Type : 01 [Memory Affinity]
[102h 0258 004h]            Proximity Domain : 00000000
[108h 0264 008h]                Base Address : 0000000000000000
[110h 0272 008h]              Address Length : 0000000000000000

[128h 0296 001h]               Subtable Type : 01 [Memory Affinity]
[12Ah 0298 004h]            Proximity Domain : 00000000
[130h 0304 008h]                Base Address : 0000000000000000
[138h 0312 008h]              Address Length : 0000000000000000

[150h 0336 001h]               Subtable Type : 01 [Memory Affinity]
[152h 0338 004h]            Proximity Domain : 00000000
[158h 0344 008h]                Base Address : 0000000000000000
[160h 0352 008h]              Address Length : 0000000000000000

[178h 0376 001h]               Subtable Type : 01 [Memory Affinity]
[17Ah 0378 004h]            Proximity Domain : 00000000
[180h 0384 008h]                Base Address : 0000000000000000
[188h 0392 008h]              Address Length : 0000000000000000
// End of strange empty Memory Affinity structures.

[1A0h 0416 001h]               Subtable Type : 05 [Generic Initiator Affini=
ty]
[1A3h 0419 001h]          Device Handle Type : 01
[1A4h 0420 004h]            Proximity Domain : 00000001
[1A8h 0424 010h]               Device Handle : 00 00 10 00 00 00 00 00 00 0=
0 00 00 00 00 00 00

[1C0h 0448 001h]               Subtable Type : 06 [Generic Port Affinity]
[1C3h 0451 001h]          Device Handle Type : 00
[1C4h 0452 004h]            Proximity Domain : 00000002
[1C8h 0456 010h]               Device Handle : 41 43 50 49 30 30 31 36 40 0=
0 00 00 00 00 00 00

[1E0h 0480 001h]               Subtable Type : 01 [Memory Affinity]
[1E2h 0482 004h]            Proximity Domain : 00000005
[1E8h 0488 008h]                Base Address : 0000000100000000
[1F0h 0496 008h]              Address Length : 0000000090000000
[1FCh 0508 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0

Example block from HMAT:
[0F0h 0240 002h]              Structure Type : 0001 [System Locality Latenc=
y and Bandwidth Information]                                               =
                                                                           =
                                                       [0F2h 0242 002h]    =
                Reserved : 0000                                            =
                                                                           =
                                                                           =
                                   [0F4h 0244 004h]                      Le=
ngth : 00000078                                                            =
                                                                           =
                                                                           =
               [0F8h 0248 001h]       Flags (decoded below) : 00           =
                                                                           =
                                                                           =
                                                                           =
                       Memory Hierarchy : 0                                =
                                                                           =
                                                                           =
                                                                     Use Mi=
nimum Transfer Size : 0                                                    =
                                                                           =
                                                                           =
                                                  Non-sequential Transfers =
: 0
[0F9h 0249 001h]                   Data Type : 03
[0FAh 0250 001h]       Minimum Transfer Size : 00
[0FBh 0251 001h]                   Reserved1 : 00
[0FCh 0252 004h] Initiator Proximity Domains # : 00000004
[100h 0256 004h]  Target Proximity Domains # : 00000006
[104h 0260 004h]                   Reserved2 : 00000000
[108h 0264 008h]             Entry Base Unit : 0000000000000004
[110h 0272 004h] Initiator Proximity Domain List : 00000000
[114h 0276 004h] Initiator Proximity Domain List : 00000001
[118h 0280 004h] Initiator Proximity Domain List : 00000003
[11Ch 0284 004h] Initiator Proximity Domain List : 00000005
[120h 0288 004h] Target Proximity Domain List : 00000000
[124h 0292 004h] Target Proximity Domain List : 00000001
[128h 0296 004h] Target Proximity Domain List : 00000002
[12Ch 0300 004h] Target Proximity Domain List : 00000003
[130h 0304 004h] Target Proximity Domain List : 00000004
[134h 0308 004h] Target Proximity Domain List : 00000005
[138h 0312 002h]                       Entry : 00C8
[13Ah 0314 002h]                       Entry : 0000
[13Ch 0316 002h]                       Entry : 0032
[13Eh 0318 002h]                       Entry : 0000
[140h 0320 002h]                       Entry : 0032
[142h 0322 002h]                       Entry : 0064
[144h 0324 002h]                       Entry : 0019
[146h 0326 002h]                       Entry : 0000
[148h 0328 002h]                       Entry : 0064
[14Ah 0330 002h]                       Entry : 0000
[14Ch 0332 002h]                       Entry : 00C8
[14Eh 0334 002h]                       Entry : 0019
[150h 0336 002h]                       Entry : 0064
[152h 0338 002h]                       Entry : 0000
[154h 0340 002h]                       Entry : 0032
[156h 0342 002h]                       Entry : 0000
[158h 0344 002h]                       Entry : 0032
[15Ah 0346 002h]                       Entry : 0064
[15Ch 0348 002h]                       Entry : 0064
[15Eh 0350 002h]                       Entry : 0000
[160h 0352 002h]                       Entry : 0032
[162h 0354 002h]                       Entry : 0000
[164h 0356 002h]                       Entry : 0032
[166h 0358 002h]                       Entry : 00C8

Note the zeros represent entries where the target node has no
memory.  These could be surpressed but it isn't 'wrong' to provide
them and it is (probably) permissible under ACPI to hotplug memory
into these nodes later.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240524100507.32106-7-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   5 -----
 tests/data/acpi/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
 tests/data/acpi/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
 tests/data/acpi/q35/DSDT.acpihmat-generic-x | Bin 0 -> 10400 bytes
 tests/data/acpi/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
 tests/data/acpi/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
 6 files changed, 5 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios=
-tables-test-allowed-diff.h
index a5aa801c99..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,6 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/APIC.acpihmat-generic-x",
-"tests/data/acpi/q35/CEDT.acpihmat-generic-x",
-"tests/data/acpi/q35/DSDT.acpihmat-generic-x",
-"tests/data/acpi/q35/HMAT.acpihmat-generic-x",
-"tests/data/acpi/q35/SRAT.acpihmat-generic-x",
diff --git a/tests/data/acpi/q35/APIC.acpihmat-generic-x b/tests/data/acpi/=
q35/APIC.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..317ddb3fbed94e4f49a87976fdc=
7f23b1a6c3fdc 100644
GIT binary patch
literal 136
zcmXxb%Mn0O3`XITcnlXkq!sRl6*D%L%2Ae5RD#JhHu=3DutPrpp@0J43U<G9+eEz!(O
p0B;wrJ6XY}$fv3+t#8iTuLjWcqk*CTI<LC^D}=3DwACRJWOATL<W3;_TD

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/=
q35/CEDT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..31c9011663639b4a0f4816f3b2b=
06398f94682f7 100644
GIT binary patch
literal 68
zcmZ>EbqR4{U|?Xhb@F%i2v%^42yj+VP*7lGU|;~TK{Nw{0)qoc4VVoE6CiAe2mn)-
B2LS*8

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/=
q35/DSDT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..a04451374d1b95764d34fbda1ec=
791a89ffdcc46 100644
GIT binary patch
literal 10400
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
DTa5vi

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/=
q35/HMAT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..0e5765f6ee4c07638c70647ae14=
5e968718b67cd 100644
GIT binary patch
literal 360
zcma)$u?oU46h%)`E5*sdrCT<g^9Qy|7pb6wAJD;1aP;%?S#r}?8U(=3D$A@?0_a^G+{
z-=3D7Zr*p2;g3*F<|hY*4T<aIAP0p<Kl%1LivWByzE=3DVeftt@-_NO)66XwIR*knBIts
t?eaMgjn%}QYk&q{c(?Xe^KMITx#vH<336X#q6H=3D((dJuwh>OiW@d0Cl4*>uG

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/=
q35/SRAT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..cbf45a31ba6d2c06f2bb0e203d4=
b40100522ac08 100644
GIT binary patch
literal 520
zcmWFzatz^MVqjoQbMklg2v%^42yj+VP*7lGU|;~TK{N=3D%fdD$6nGsc<l?j>8r~%gr
z1za!&in$1N0#Nx6%rJ$h=3DCQzpVGJ0JrVgeIKS0=3Dv9}JW_Rs{xV_`<>k0$^dnroh0!
i#K6Gd=3Dp5i_U|?wGfF{qV!3y^nRL=3DyM06c&h7#IL5atr|g

literal 0
HcmV?d00001

--=20
MST


