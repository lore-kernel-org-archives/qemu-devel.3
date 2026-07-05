Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA42C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNxB-0008JC-7f; Sun, 05 Jul 2026 10:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNx9-0008FI-9e
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNx7-0001Uv-BL
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZZw+mxBnJsNRobqBTA/GyoILVLgdQGiI4YFVDcGE1Qk=;
 b=DyZr+GmbcwvXJv8bYIOPsUvheq8pAObPY+HYLZeF0uW0NGKdJuNW0vYgGm/3aG5jj3Dcwy
 2MoxI1oxRKtP93TLRGg31W7bvF4HuHhMN0SqyU7j2XBfYqCh8NKkcJhWav3J8GC3KBMvJd
 49qdbT9ln4L0hTogBIPWStQLLFU222E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-CVk_r9JsPBOSmdGKMqQqdQ-1; Sun, 05 Jul 2026 10:36:11 -0400
X-MC-Unique: CVk_r9JsPBOSmdGKMqQqdQ-1
X-Mimecast-MFC-AGG-ID: CVk_r9JsPBOSmdGKMqQqdQ_1783262170
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-470cb859d96so1069052f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262170; x=1783866970; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZw+mxBnJsNRobqBTA/GyoILVLgdQGiI4YFVDcGE1Qk=;
 b=GgBQgtFANxffI9nJsgUocSRaocF6Zo10E+9Hgr05irYXLd5AU8ASUPKvCSRi3eWObd
 IIR97FCM5kIiLWeiqZu9W1VIaWK77fihYyMGp1fysC4gpRalaTMIl5EucVBRpD7NhTEQ
 B78v0cZBBQjsYL8KwvAe8iBmmaZQ3MvF279OwZjVekUFtfGecSaWG+48MyIYH6dJJ/Mx
 GdjmLGnLieeS+9ssTKHdgK9a8oeU0WHgr6GOYhfF1sakqn5LvwLE2cAeOiow5WbbyGy6
 FmQ3EEzSi803Xd8P34+uNPQqpgTqQsls0oXmm/VV2MwIlXKsjZhZxpB+5YUOHO60n247
 uVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262170; x=1783866970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZw+mxBnJsNRobqBTA/GyoILVLgdQGiI4YFVDcGE1Qk=;
 b=cuf1wmdfxbf0uWheL2YqzUEJaJBpWp8/16mfhkzEgO0axRA9NsxERgmUG9+clr1qvI
 x9U3tI9VwHX1ERVp/HJIg2AgKpfhSV1njr80S6+IWVR2N57s/0OrxR6+zdfbp83vQovG
 5i96K5UUFWdcP/USFxlrWXKpX9KUWMQhoL+ZO/GqypylYt25a6LYQd2hERNxS8sQtusE
 oHDa1Bz9XOngQMbB042lAPRd8PXPJ3FUFNM+eoJVcUm2Ms/PPoV1Ykb3l5wqPhrErEqD
 r/sG+lrExuUzQHO8oYEqk/crs/JMu25OLzPzf2SY5WKWBfcMWgx6jy+7/jtwfgVNt/hb
 lgJw==
X-Gm-Message-State: AOJu0YyViitWpy0emPPnBK/hxFythcweq6ORh1yWMFmWXTfSjMloB6vH
 x5G74yKJtOP6WMhvngpaL339TuGzV2LeVmHKQck0lNM9gxx997SY9k3UxsJfSbA5TSf1q4OnSdt
 0VH7m4Au2E5kruxN5BcJgVWqOeVDUdKET1fFY/WjCGFf/eGQZOP56qzrhdVRZHediedVBajlw54
 BWRsBCG5pS4Rn5JIKEJVpsO9pMBH+C0EjBnw==
X-Gm-Gg: AfdE7cl00xKqt08QX69KIxuCmv1l/7zLx0B8wSJ/I3/fZMeVBsDN2BFMHTBoMYT0aXV
 v6F2Na5Ai97lSvchGWdEd1l+w0wku71T7SdlXSmrKtUtipETwHg2UXPqVkF/F6rd+x8BYN3ujMI
 NHuFnsmNK69DFbbdwIE7DtYLERr7mYT1uEYP3ek9I6l1uIoRvfHyfOyKlCfZn1fjYq3VmMnVa+W
 EgZ1zc1bc0y79r076AiSuNrRzB51fytGGdSxhrxrh+VFUIlzDXKYF/FtrTQ9BLKomdotVtdraZs
 m4EBRkP/MLaSHtejJvdZYCWNmxPVdqGDIvNlElqOo8CeJfXdPQpqlo3IxWXFJgPO7r5J8+Gzr7F
 yVa3iQR7xwTySRNRn5wM/iYDP4OYepfW2
X-Received: by 2002:a5d:438e:0:b0:473:d65d:49c1 with SMTP id
 ffacd0b85a97d-47aac4ecd02mr5560127f8f.32.1783262169962; 
 Sun, 05 Jul 2026 07:36:09 -0700 (PDT)
X-Received: by 2002:a5d:438e:0:b0:473:d65d:49c1 with SMTP id
 ffacd0b85a97d-47aac4ecd02mr5560111f8f.32.1783262169331; 
 Sun, 05 Jul 2026 07:36:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9b4d850dsm17396573f8f.0.2026.07.05.07.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:08 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 36/44] tests: acpi: arm/virt: update expected WDAT blob
Message-ID: <e84210642ce5b5f8eb528a5b6d86e29445f701de.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

replace blank table with a new one:

  [000h 0000 004h]                   Signature : "WDAT"    [Watchdog Action Table]
  [004h 0004 004h]                Table Length : 00000104
  [008h 0008 001h]                    Revision : 01
  [009h 0009 001h]                    Checksum : 3B
  [00Ah 0010 006h]                      Oem ID : "BOCHS "
  [010h 0016 008h]                Oem Table ID : "BXPC    "
  [018h 0024 004h]                Oem Revision : 00000001
  [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
  [020h 0032 004h]       Asl Compiler Revision : 00000001

  [024h 0036 004h]               Header Length : 00000020
  [028h 0040 002h]                 PCI Segment : 00FF
  [02Ah 0042 001h]                     PCI Bus : FF
  [02Bh 0043 001h]                  PCI Device : FF
  [02Ch 0044 001h]                PCI Function : FF
  [02Dh 0045 003h]                    Reserved : 000000
  [030h 0048 004h]                Timer Period : 00000001
  [034h 0052 004h]                   Max Count : 000927C0
  [038h 0056 004h]                   Min Count : 00001388
  [03Ch 0060 001h]       Flags (decoded below) : 81
                                       Enabled : 1
                           Stopped When Asleep : 1
  [03Dh 0061 003h]                    Reserved : 000000
  [040h 0064 004h]        Watchdog Entry Count : 00000008

  [044h 0068 001h]             Watchdog Action : 08
  [045h 0069 001h]                 Instruction : 00
  [046h 0070 002h]                    Reserved : 0000

  [048h 0072 00Ch]             Register Region : [Generic Address Structure]
  [048h 0072 001h]                    Space ID : 00 [SystemMemory]
  [049h 0073 001h]                   Bit Width : 20
  [04Ah 0074 001h]                  Bit Offset : 00
  [04Bh 0075 001h]        Encoded Access Width : 03 [DWord Access:32]
  [04Ch 0076 008h]                     Address : 000000000C001000

  [054h 0084 004h]                       Value : 00000001
  [058h 0088 004h]               Register Mask : 00000001

  [05Ch 0092 001h]             Watchdog Action : 01
  [05Dh 0093 001h]                 Instruction : 02
  [05Eh 0094 002h]                    Reserved : 0000

  [060h 0096 00Ch]             Register Region : [Generic Address Structure]
  [060h 0096 001h]                    Space ID : 00 [SystemMemory]
  [061h 0097 001h]                   Bit Width : 20
  [062h 0098 001h]                  Bit Offset : 00
  [063h 0099 001h]        Encoded Access Width : 03 [DWord Access:32]
  [064h 0100 008h]                     Address : 000000000C000000

  [06Ch 0108 004h]                       Value : 00000001
  [070h 0112 004h]               Register Mask : 00000007

  [074h 0116 001h]             Watchdog Action : 06
  [075h 0117 001h]                 Instruction : 03
  [076h 0118 002h]                    Reserved : 0000

  [078h 0120 00Ch]             Register Region : [Generic Address Structure]
  [078h 0120 001h]                    Space ID : 00 [SystemMemory]
  [079h 0121 001h]                   Bit Width : 20
  [07Ah 0122 001h]                  Bit Offset : 00
  [07Bh 0123 001h]        Encoded Access Width : 03 [DWord Access:32]
  [07Ch 0124 008h]                     Address : 000000000C001008

  [084h 0132 004h]                       Value : 00000000
  [088h 0136 004h]               Register Mask : FFFFFFFF

  [08Ch 0140 001h]             Watchdog Action : 09
  [08Dh 0141 001h]                 Instruction : 82
  [08Eh 0142 002h]                    Reserved : 0000

  [090h 0144 00Ch]             Register Region : [Generic Address Structure]
  [090h 0144 001h]                    Space ID : 00 [SystemMemory]
  [091h 0145 001h]                   Bit Width : 20
  [092h 0146 001h]                  Bit Offset : 00
  [093h 0147 001h]        Encoded Access Width : 03 [DWord Access:32]
  [094h 0148 008h]                     Address : 000000000C001000

  [09Ch 0156 004h]                       Value : 00000001
  [0A0h 0160 004h]               Register Mask : 00000001

  [0A4h 0164 001h]             Watchdog Action : 0A
  [0A5h 0165 001h]                 Instruction : 00
  [0A6h 0166 002h]                    Reserved : 0000

  [0A8h 0168 00Ch]             Register Region : [Generic Address Structure]
  [0A8h 0168 001h]                    Space ID : 00 [SystemMemory]
  [0A9h 0169 001h]                   Bit Width : 20
  [0AAh 0170 001h]                  Bit Offset : 00
  [0ABh 0171 001h]        Encoded Access Width : 03 [DWord Access:32]
  [0ACh 0172 008h]                     Address : 000000000C001000

  [0B4h 0180 004h]                       Value : 00000000
  [0B8h 0184 004h]               Register Mask : 00000001

  [0BCh 0188 001h]             Watchdog Action : 0B
  [0BDh 0189 001h]                 Instruction : 82
  [0BEh 0190 002h]                    Reserved : 0000

  [0C0h 0192 00Ch]             Register Region : [Generic Address Structure]
  [0C0h 0192 001h]                    Space ID : 00 [SystemMemory]
  [0C1h 0193 001h]                   Bit Width : 20
  [0C2h 0194 001h]                  Bit Offset : 00
  [0C3h 0195 001h]        Encoded Access Width : 03 [DWord Access:32]
  [0C4h 0196 008h]                     Address : 000000000C001000

  [0CCh 0204 004h]                       Value : 00000000
  [0D0h 0208 004h]               Register Mask : 00000001

  [0D4h 0212 001h]             Watchdog Action : 20
  [0D5h 0213 001h]                 Instruction : 00
  [0D6h 0214 002h]                    Reserved : 0000

  [0D8h 0216 00Ch]             Register Region : [Generic Address Structure]
  [0D8h 0216 001h]                    Space ID : 00 [SystemMemory]
  [0D9h 0217 001h]                   Bit Width : 20
  [0DAh 0218 001h]                  Bit Offset : 00
  [0DBh 0219 001h]        Encoded Access Width : 03 [DWord Access:32]
  [0DCh 0220 008h]                     Address : 000000000C001000

  [0E4h 0228 004h]                       Value : 00000004
  [0E8h 0232 004h]               Register Mask : 00000004

  [0ECh 0236 001h]             Watchdog Action : 21
  [0EDh 0237 001h]                 Instruction : 82
  [0EEh 0238 002h]                    Reserved : 0000

  [0F0h 0240 00Ch]             Register Region : [Generic Address Structure]
  [0F0h 0240 001h]                    Space ID : 00 [SystemMemory]
  [0F1h 0241 001h]                   Bit Width : 20
  [0F2h 0242 001h]                  Bit Offset : 00
  [0F3h 0243 001h]        Encoded Access Width : 03 [DWord Access:32]
  [0F4h 0244 008h]                     Address : 000000000C000000

  [0FCh 0252 004h]                       Value : 00000004
  [100h 0256 004h]               Register Mask : 00000004

Raw Table Data: Length 260 (0x104)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260702145856.1539572-11-imammedo@redhat.com>
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
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..d5adacf9114637d8803d08906ff1e29ac61f5fe0 100644
GIT binary patch
literal 260
zcmZXOK@NgI3`O4vF`x@byg*$Mjv=^kCkZBU9awQJZ&p(1B&bcAwm<K;ecx}dG(f1E
zXZz@-8M;<PBmmZ16+lr{z~)btGhbi?GEanrk^*Op%cs@+r=JYk@zHbs;iGQ%_k0R#
Y9+OSa{H}$nYB)I0_dnOT-}Sg>0T&h&0RR91

literal 0
HcmV?d00001

-- 
MST


