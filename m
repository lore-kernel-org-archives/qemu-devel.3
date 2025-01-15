Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A53C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7sM-0007JQ-37; Wed, 15 Jan 2025 13:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7r6-0000lS-7u
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:11:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7r2-00077i-PQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6M1jFL2vf83U/NINHWTEDkBtidr72+vppnl6seODX1A=;
 b=OxANHmxL6hAk1XCiV/sw895StfFS5hbr/r9zAU6gPcF2vZ4GkmeGqznd9iXNDF4vKCF23f
 urYfgOyd+gZfwxj42VhUgycDf2BnmPf4yfDXW+I6cC3h8Tbq/FKZ0RfrOiMUylr21FiL25
 JhYRkEGy6lmBMOP/LoUAjIeEvpPj9MI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-oAAZAO3NPD61ZBt855R_PQ-1; Wed, 15 Jan 2025 13:10:58 -0500
X-MC-Unique: oAAZAO3NPD61ZBt855R_PQ-1
X-Mimecast-MFC-AGG-ID: oAAZAO3NPD61ZBt855R_PQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436379713baso33394815e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964656; x=1737569456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6M1jFL2vf83U/NINHWTEDkBtidr72+vppnl6seODX1A=;
 b=WXjmh0tp2WhLe/fFH8NCLluA8MliFPxFnU38v6v2wlZGdEnNRj05oA/djuKz6gpncD
 n7VjK1/bUkY28GhWpj0KObF1EY/yO8NbuOGuBf4lmXOb3BFdS8qJo1CJsG9jLg3vYwLw
 mEKSK0HQWv0hW73zPuUIWwo0PLA59jB1F0UWP1nnYq6f7SziTYQTGEWA2dSc8/ctu4To
 k5PJwptNqCGI8jmX5SmRexyK+FciF7DbWjZG4nhMbVgiGK7vIKJfkwsH8+wcKYJFJJwf
 U0xWvBGTaNrwWbC7WA+Au7vW54Os+5Q+BDt1B7xrr0zNANpWXElpmTc6ETy4aPXkeyb9
 +8cw==
X-Gm-Message-State: AOJu0YznaWCJtfF3ZRd9dZ5GqCfip+GCEZYkbYg/txYy6MXhTd+YTLp7
 AZQC9o6FPprGbuq9pzaPv/OvtJh/OtlkBXAKqgr+ccI/qtperVKnCjWyzlKLoDZfr5FCYACdi2S
 KARmcQ5ynMIKaVkXTj8sCkkE7/AC3xFfqheS0AKNEvW9uFte8seXSDXsjjCrW8YmIVD4SBkxG9Z
 K+IlnrpLGdjKN1l0mDYvnJlTvmGbjQag==
X-Gm-Gg: ASbGncv1bOLwucHmCyXLnfWJCI3ODdNckpcMMa8S85dodfuvVEi1639qbrw4eXYNhxX
 Cl3V9iSZU4DMGHCltBL+4crxY5C7G9yWBTB6SlqNUhRLneq4nbI5EJ1FnJyotjJCg0x4mu7vrdY
 mWP1q/B5/HE7LU6YjgZLvL7hC6N6rF1h57m7pH1SYuoOdSV2elKw6Ly4ipaUi4JmbfZEbSmSiHT
 U5QGdD2HYC8nMlEGF1vxsYiRbbR5PuQ9yjow1G7N/GvxDnI7ZIJ
X-Received: by 2002:a5d:6d8a:0:b0:386:4034:f9a8 with SMTP id
 ffacd0b85a97d-38a8733693fmr30766786f8f.38.1736964656070; 
 Wed, 15 Jan 2025 10:10:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxDl94D+zJ48WlTFfVRrBG5yMAiAx1htNhBZy3G7SpDqQHryWVsbB6M3Ez/dDf9wT8uBR5lA==
X-Received: by 2002:a5d:6d8a:0:b0:386:4034:f9a8 with SMTP id
 ffacd0b85a97d-38a8733693fmr30766748f8f.38.1736964655491; 
 Wed, 15 Jan 2025 10:10:55 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d0bdsm18163484f8f.3.2025.01.15.10.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:54 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 45/48] tests: acpi: update expected blobs
Message-ID: <9fb1c9a1bb26e111ee5fa5538070cd684de14c08.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

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
Message-Id: <20250115125342.3883374-4-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h   |  40 ------------------
 tests/data/acpi/x86/pc/DSDT                   | Bin 8593 -> 8611 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8504 -> 8522 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9918 -> 9936 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15464 -> 15482 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9057 -> 9075 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10247 -> 10265 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8544 -> 8562 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8665 -> 8683 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9952 -> 9970 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8451 -> 8469 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8599 -> 8617 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12386 -> 12404 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8422 -> 8440 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8439 -> 8457 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9747 -> 9765 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12632 -> 12650 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8701 -> 8719 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8468 -> 8486 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12035 -> 12053 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12980 -> 12998 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33837 -> 33855 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8886 -> 8904 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13213 -> 13231 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10076 -> 10094 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8497 -> 8515 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8510 -> 8528 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8439 -> 8457 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9781 -> 9799 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9552 -> 9570 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13275 -> 13293 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8280 -> 8298 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8428 -> 8446 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8523 -> 8541 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12980 -> 12998 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33837 -> 33855 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9028 -> 9046 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9054 -> 9072 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18656 -> 18674 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14679 -> 14697 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35785 -> 35803 bytes
 41 files changed, 40 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 085dfa9ff4..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,41 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/pc/DSDT",
-"tests/data/acpi/x86/pc/DSDT.acpierst",
-"tests/data/acpi/x86/pc/DSDT.acpihmat",
-"tests/data/acpi/x86/pc/DSDT.bridge",
-"tests/data/acpi/x86/pc/DSDT.cphp",
-"tests/data/acpi/x86/pc/DSDT.dimmpxm",
-"tests/data/acpi/x86/pc/DSDT.hpbridge",
-"tests/data/acpi/x86/pc/DSDT.ipmikcs",
-"tests/data/acpi/x86/pc/DSDT.memhp",
-"tests/data/acpi/x86/pc/DSDT.nohpet",
-"tests/data/acpi/x86/pc/DSDT.numamem",
-"tests/data/acpi/x86/pc/DSDT.roothp",
-"tests/data/acpi/x86/q35/DSDT",
-"tests/data/acpi/x86/q35/DSDT.acpierst",
-"tests/data/acpi/x86/q35/DSDT.acpihmat",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
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
index 60d50b088a362556fd54395cb15364d6c0936be5..4beb5194b84a711fcb52e3e52cc2096497d18442 100644
GIT binary patch
delta 89
zcmV-f0H*(uL!(0qL{mgmqagqQ0q~Iu-~vt+k?gnvL<*Cp0c$ijlWGbFa6w5#Sc8ac
v004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;GXh>8L>3-R

delta 71
zcmZ4NJkgoUCD<ioq9OwWqy0p#2TVR96W{D$a^jr4j4@kDb#fLLdw~!u69X?pLV=^F
bOGI-=4g*7TM-C%HQbAHj0>frkrZ{;3=vWj@

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index 4c434c25c0b1602f22128e352781df498fa69ddf..abda6863b64c5dc8ba5aba1a286cbfa76772a1e4 100644
GIT binary patch
delta 89
zcmV-f0H*)ALdrr4L{mgmN+AFM0XUHg-~vt+k?gnvL<*Cp0c$ijlWGbFa6w5#Sc8ac
v004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;GXe!43(g%c

delta 71
zcmX@*w8M$ZCD<jzLXm-iv3(-f112AliEnl=IdM*2#+a?7IysAry+DYSiGi0Pp}^78
bC8D__hk>EFBZrY8sUWE%fnl>N6RSJ`_UaTb

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index 61b7d5caa55c44dbf69d649110c6b14bb4c3fdf5..d081db26d7ba504b3344fad130d5812419291ac0 100644
GIT binary patch
delta 89
zcmV-f0H*)GP0&pWL{mgm&?W!?0j-e=-~vt+k?gnvL<*Cp0c$ijlWGbFa6w5#Sc8ac
v004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;GXjewW-A`t

delta 71
zcmccMyU&-)CD<iopBe)L<DZFK514#JCcfFh<it678DqAR>f|gg_5vYRCI()HgaSuT
bmx$($90rEwjvPjYq=KZ51cuG7Ox-E~Jn|LX

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index d43e148bed19160f39d88ccf3364544150a3f87f..e16897dc5f0fbb3f7b4de8db913884046246cc3b 100644
GIT binary patch
delta 89
zcmV-f0H*)wc=~t>L{mgmdOQFC0sfH+-~vt+k?gnvL<*Cp0c$ijlWGbFa6w5#Sc8ac
v004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;GXga_qf{SP

delta 71
zcmexW@uGsuCD<h-!-j!@(RU)(112AliEnl=IdM*2#+a?7IysAry+DYSiGi0Pp}^78
bC8D__hk>EFBZrY8sUWE%fnl>Nlc^N|GxZf$

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index 9fda0b56638e02097e58dd4536c9c5955986e88e..e95711cd9cde5d50b841b701ae0fed5a4b15e872 100644
GIT binary patch
delta 89
zcmV-f0H*)pM)O7rL{mgmb0Yu%0b`L0-~vt+k?gnvL<*Cp0c$ijlWGbFa6w5#Sc8ac
v004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;GXgFlMG+nf

delta 71
zcmezD_Rx*XCD<h-QJH~(annSu2TVR96W{D$a^jr4j4@kDb#fLLdw~!u69X?pLV=^F
bOGI-=4g*7TM-C%HQbAHj0>frkCOt&}Bit1V

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 5b6471c8db9003b39bf5e20af34061f3e71cdbd5..90ba66b9164f9a958d5a3c4371b1eec03e922828 100644
GIT binary patch
delta 89
zcmV-f0H*(kP?=B)L{mgm87Ke%0T7W2-~vt+k?gnvL<*Cp0c$ijlWGbFa6w5#Sc8ac
v004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;GXm5l+*loK

delta 71
zcmbOk&>q0$66_MfuED^-7(bEg0h5o&#5X&boH!>hW6V}kot(wRULeHE#K6mtP~hn4
b64Bg|!@$tok;BN4RFKq>z_8hs>53`<(lZon

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 67fe28699fbb261cfc7a52b2291f9965ab93c6a8..0eafe5fbf3d73719c9c3e6e26371863bfb44ed2f 100644
GIT binary patch
delta 89
zcmV-f0H*)oLh?ciL{mgmav=Z!0VI(M-~vt+k?gnvL<*Cp0c$ijlWGbFa6w5#Sc8ac
v004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;GXgCiE<zo<

delta 71
zcmez5^uUSBCD<h-L6L!hv3Mfa112AliEnl=IdM*2#+a?7IysAry+DYSiGi0Pp}^78
bC8D__hk>EFBZrY8sUWE%fnl>Nlde1f5@i&-

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 9b2e81a7bcefb5c0e2dfbd2bbc5b6ea501f86306..8d465f027772f9c59b0c328c1a099e374a6d2a90 100644
GIT binary patch
delta 89
zcmV-f0H*)hL+e8dL{mgm>mdLD0c?>9-~vt+k?gnvL<*Cp0c$ijlWGbFa6w5#Sc8ac
v004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;GXka`W%?fJ

delta 71
zcmaFueAAiBCD<k8rXm9a<L-%E514#JCcfFh<it678DqAR>f|gg_5vYRCI()HgaSuT
bmx$($90rEwjvPjYq=KZ51cuG7Ov~f}J!2K=

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 9c66ccf150af1622d1b788a1ae04a6e5136cff9e..e3b49757cb7abd7536ee89a6824967d2cb2485cf 100644
GIT binary patch
delta 89
zcmV-f0H*)oP4Z0&L{mgm@+JTP0mP9C-~vt+k?gnvL<*Cp0c$ijlWGbFa6w5#Sc8ac
v004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;GXkw7k1QX1

delta 71
zcmez5`@omWCD<k8ff@q?qwqwo2TVR96W{D$a^jr4j4@kDb#fLLdw~!u69X?pLV=^F
bOGI-=4g*7TM-C%HQbAHj0>frkrnM>nBq<ep

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index 28dbd8d8949d1421da9312cf0440d7ae3b64916e..9e772c1316d0ea07c51717466c4c7e383553f345 100644
GIT binary patch
delta 89
zcmV-f0H*(gLX|=aL{mgm6(Ils0lAS1-~vt+k?gnvL<*Cp0c$ijlWGbFa6w5#Sc8ac
v004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;GXl^a{vRFN

delta 71
zcmbR0)a=CN66_MftjNH?$T5-Y0h5o&#5X&boH!>hW6V}kot(wRULeHE#K6mtP~hn4
b64Bg|!@$tok;BN4RFKq>z_8hs>4F>pvSt(8

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index e256bbce790152f045247db631d9f1da81f90499..9bfbfc28213713c208dfc38a85abb46fb190871d 100644
GIT binary patch
delta 89
zcmV-f0H*(!L#aawL{mgmsUZLW0eq1P-~vt+k?gnvL<*Cp0c$ijlWGbFa6w5#Sc8ac
v004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;GXi8EC?*~8

delta 71
zcmZ4KJl&bgCD<iox*`Ju<LQZ9514#JCcfFh<it678DqAR>f|gg_5vYRCI()HgaSuT
bmx$($90rEwjvPjYq=KZ51cuG7OeyjJ3|kcO

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index 0557810ddc18dc280d039163c72b25428a2486c1..efbee6d8aa5c62ff4fcb83e6c5cff59542977850 100644
GIT binary patch
delta 89
zcmV-f0H*)qVDw-LL{mgmbT9w_0eq1P-~vt+k?gnvL<*Cp0c$ijlWGbFa6w5#Sc8ac
v004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;GXgIzV<H}P

delta 71
zcmey8@F;=HCD<h-$$)`@@$^Kl2TVR96W{D$a^jr4j4@kDb#fLLdw~!u69X?pLV=^F
bOGI-=4g*7TM-C%HQbAHj0>frkCVf2sJ7X1f

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index 51ad37a351bffae8fbc9ba17f72c25ef61822f59..e5e8d1e041e20e1b3ee56a5c93fe3d6ebd721ee6 100644
GIT binary patch
delta 91
zcmV-h0HpusLHI!mL{mgm_#glP0lu*cp#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1@*Q=CAJ6~*

delta 73
zcmez2_{@>ZCD<k8nF0d?BkxA8g^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaK_KSpX366wv?x

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index dbd4f858354df0f4c050fd0b914581154f340ee8..072a3fe2cd17dfe06658dfd82588f69787810114 100644
GIT binary patch
delta 91
zcmV-h0Hpu-L5V^NL{mgm2_XOg0bQ{Qp#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ110L!89X0>}

delta 73
zcmeBl`tHc(66_N4U4emtaqUK~g^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaECr8~`1R6gL0>

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index 952752e30e9dfc9e2085e8fceaa0740dda6db89c..2a4f2fc1d5c5649673353186e67ff5b5e59e8d53 100644
GIT binary patch
delta 91
zcmV-h0HptuOr=Z;L{mgmB_;p>0eZ0tp#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1A0z7h9by0g

delta 73
zcmZ4LGuemBCD<iISdD>!@#IFXg^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaIwKG63GX6Jr1X

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
index e95258cbd8681103a642f8973bd1ac9ef229cff7..7911c058bba5005d318b8db8d6da5c1ee381b0f1 100644
GIT binary patch
delta 91
zcmV-h0HpueV(MZFL{mgmYB2x+0Uxmnp#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1WG*SE9$f$c

delta 73
zcmaErbR&t&CD<h-!jOT1F>fQ+LPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
d=;;#C+>yh;(A<&3$dFW!)RDljnT<I`4*(Hf6kY%T

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index ba2a7d0004be7cd7220716dc7e8594be87197b98..580b4a456a20fc0cc0a832eaf74193b46d8ae8b1 100644
GIT binary patch
delta 91
zcmV-h0Hpu@LytrXL{mgm4<Y~n0W`4+p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ12_NN+9V-9;

delta 73
zcmeBo`RmN(66_N4SCN5%v1KFILPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
d=;;#C+>yh;(A<&3$dFW!)RDljnT?rK9sn9)6f6J$

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index b6cb840953ea539092f601e08b7122fc999b3e1b..5e8220e38d6f88b103f6eb3eb7c78dfa466882dc 100644
GIT binary patch
delta 91
zcmV-h0HptvLZ(6rL{mgmCLsU-0j;qLp#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1ARhA09eV%(

delta 73
zcmZ4HG{uR_CD<iIM3I4k@y|xCg^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaIvl9025j6MO&w

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index 1939fda2507cde6fcb6f7a093897f9bd2cb987ef..ee039453af1071e00a81ee7b37cf8f417f524257 100644
GIT binary patch
delta 91
zcmV-h0HpteUX@-7L{mgm6)yk)0okz%p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ14=e_S9k&1g

delta 73
zcmbOl*Br;?66_Mftk1x}sIif2AtRHI$mF$*JD8j}C#N%IE2&P-;$kllVr63BWk@J+
d^mK`6?#N+aXzs{iWJoGV>PTSN%*M>G0|2<Y61V^W

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index 41c0832ab5041ff5361598813ec28fe7442b191b..7ebfceeb66460d0ad98471924ce224b7153e87ef 100644
GIT binary patch
delta 91
zcmV-h0Hpu4WyWO+L{mgm#xei^0XDG;p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1z%Mu29_#=B

delta 73
zcmX?>x+Rs%CD<ioixC3@W9vq)g^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaK^(eE=K{6zu>2

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index 153b45f0f7443d25cecc2a752fb6dbd921160e78..d0394558a1faa0b4ba43abab66d474d96b477ff3 100644
GIT binary patch
delta 93
zcmV-j0HXh`hyuTe0t!S^L{vY70004pu?nF90!|f^tpT_KL<*B<0&6rklWGbFa6w5#
zSc8ac004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;^a447R<a)t

delta 75
zcmdnr!L+u6iOVI}B}BJ{fr0VbMy`d7Og<u$*D~&4a^jqv&XldBIysAry+DYSiGi0P
fp}^78C8D__hk>EFBZrY8sUWE%fnhTnvt=UyG{+SX

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 231bc23d932e832ffa12dd253bcf54245b5ef88f..a055c2e7d3c4f5a00a03be20fd73227e322283a4 100644
GIT binary patch
delta 91
zcmV-h0Hpu6MaV@8L{mgm$RYp$0Wq-(p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1!XF(89*+P3

delta 73
zcmX@%y3Li#CD<ion-T*9W5Y(Sg^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaK_Ec>o5=6p#P_

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index 0f1ccdfcc3ffbf151c172015cc4bf18bc4ead218..20843549f54af1cb0e6017c4cfff7463318d9eb7 100644
GIT binary patch
delta 91
zcmV-h0Hpt&XRl`pL{mgmuQLDu0rIg5p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1sW4h(A5s7S

delta 73
zcmZ3VJ~y4qCD<iot}z1xqvJ-dg^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaK_t0|5Ha6jJ~I

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index eb5b6e9f52107d9c95e38e94a67a6b5001beafc1..664e926e90765550136242f7e3e0bdc7719c1853 100644
GIT binary patch
delta 91
zcmV-h0HpuiPVP<$L{mgmZYKZ$0p76+p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1Xe3r19`FDF

delta 73
zcmaFocgK&*CD<h-MxB9yQFkNPLPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
d=;;#C+>yh;(A<&3$dFW!)RDljnT<I^1pxR26Y&55

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 524fc9f4ee09fd7a5bec62818fd87b6ec300dee8..4066a76d26aa380dfbecc58aa3f83ab5db2baadb 100644
GIT binary patch
delta 91
zcmV-h0Hpu1Lc>A|L{mgmLm>bF0r9a4p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1Jsu@F9y0&{

delta 73
zcmX@?w9$#nCD<jzP?3Rw(P1OkLPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
d=;;#C+>yh;(A<&3$dFW!)RDljnT^?24gk>i6Epw-

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index d04d215a1d0fbc77739084d100a35af47a1c1a62..6d0b6b95c2a9fd01befc37b26650781ee1562e2a 100644
GIT binary patch
delta 91
zcmV-h0HpuELeN4AL{mgmP$2*S0b;QVp#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1N*)KE9oPT>

delta 73
zcmccMw9kplCD<jzPLY9uapOj=g^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaIv)902vK6WIU&

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index dbd4f858354df0f4c050fd0b914581154f340ee8..072a3fe2cd17dfe06658dfd82588f69787810114 100644
GIT binary patch
delta 91
zcmV-h0Hpu-L5V^NL{mgm2_XOg0bQ{Qp#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ110L!89X0>}

delta 73
zcmeBl`tHc(66_N4U4emtaqUK~g^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaECr8~`1R6gL0>

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index f73ade9bf6e4545f9912ed654a282884a54cec79..4f2f9bcfceff076490cc49b8286380295a340004 100644
GIT binary patch
delta 91
zcmV-h0Hpu5Ovg+LL{mgmM<xIO0g<r^p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1K_e9h9svLV

delta 73
zcmX@^v(<;oCD<jzRE>dw@xex}g^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaIv`G64VU6aoMM

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index f0ddb4c83cdc9afdf4f289a66ed6bf0d630fd623..0fb6aab16f1bd79f3c0790cc9f644f7e52ac37b1 100644
GIT binary patch
delta 91
zcmV-h0HpuWO5#ciL{mgmVkH0o0aCFFp#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1Tp}Dc9w-0+

delta 73
zcmaFlb-|0vCD<h-K$U@kap6X;g^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaGY^5&#B26e$1z

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 3ad19e3f5e480db1c449b838c83833f7665186cd..f6afa6d96d2525d512cc46f17439f7a49962b730 100644
GIT binary patch
delta 91
zcmV-h0HpuhXYFSSL{mgm?K1!X0n@Pxp#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1=P;20AS(a>

delta 73
zcmaExemkAZCD<k8wlM<(qtZsMg^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaK`B0{|wL6)XS%

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index c089b5877a0f4d808abd4d8d9396ee7d2a9a78e5..99ad629c9171ff6ab346d6b4c519e77ca23e5b1c 100644
GIT binary patch
delta 91
zcmV-h0HpueK<YpWL{mgmY9Igr0f(^)p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1WF0Hn9$x?e

delta 73
zcmaFmaKnMiCD<h-LV<yS@!CeNg^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaGY?EC3QZ6kq@V

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index 2867f5b44498d788fc0effd0bf616317821be88e..fd1d8a79d3d9b071c8796e5e99b76698a9a8d29c 100644
GIT binary patch
delta 91
zcmV-h0HpuyLH<DsL{mgm{vZGV0ZOq7p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1_#If%A9Mf!

delta 73
zcmez8_{NdTCD<k8jRFG$<IIg*3mKVwL?*9g+`;6;IXRsvTS;|t78iSg5GxY{FGE6s
dqo+$mb4LyXLvu$CBSTU_Qbz*AW;W&@vH&(A6?Fgr

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index 02cc07f010f880684216ba8925c8f3f55cfd80aa..89032fa0290f496be0c06c6382586541aa1118a8 100644
GIT binary patch
delta 91
zcmV-h0HpuRLft|NL{mgmT_FGf0dTPjp#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1R~{KW9vT1u

delta 73
zcmccXblQo_CD<jzTakf*asNiHg^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaGZb8~_8K6dM2l

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index 41c0832ab5041ff5361598813ec28fe7442b191b..7ebfceeb66460d0ad98471924ce224b7153e87ef 100644
GIT binary patch
delta 91
zcmV-h0Hpu4WyWO+L{mgm#xei^0XDG;p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1z%Mu29_#=B

delta 73
zcmX?>x+Rs%CD<ioixC3@W9vq)g^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaK^(eE=K{6zu>2

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index 153b45f0f7443d25cecc2a752fb6dbd921160e78..d0394558a1faa0b4ba43abab66d474d96b477ff3 100644
GIT binary patch
delta 93
zcmV-j0HXh`hyuTe0t!S^L{vY70004pu?nF90!|f^tpT_KL<*B<0&6rklWGbFa6w5#
zSc8ac004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;^a447R<a)t

delta 75
zcmdnr!L+u6iOVI}B}BJ{fr0VbMy`d7Og<u$*D~&4a^jqv&XldBIysAry+DYSiGi0P
fp}^78C8D__hk>EFBZrY8sUWE%fnhTnvt=UyG{+SX

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index d0330d26a54b89c02a17b06ef5f55c72e28e406e..f2ed40ca70cb13e733e39f4bad756be8688e01fe 100644
GIT binary patch
delta 91
zcmV-h0HpuKM%G3OL{mgmRwDoa0q(I1p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1P#`;29*6({

delta 73
zcmccScEpX#CD<jzMVWzt(RL%(LPjPZk;!WrcQ83|PEKdaR#Kgu#l>DA#LC3L%aBmu
d=;;#C+>yh;(A<&3$dFW!)RDljnT<I>0RZBZ6Nvx-

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index b05563deedc65df50f35b2399862d9ee8d4d1e0e..5c975d2162d0bfee5a3a089e79b5ba038f82b7ef 100644
GIT binary patch
delta 91
zcmV-h0HpukM({=oL{mgma3cT!0jRMGp#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1Y9K)v9;yHU

delta 73
zcmez1cF&E=CD<h-PMLv$@%u)ug^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaGZ30stb_6srIL

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index 00807e7fd4d758bc2ab9c69ac8869cf6864399f7..3194a82b8b4f66aff1ecf7d2d60b4890181fc600 100644
GIT binary patch
delta 93
zcmV-j0HXikkpc3N0SZJ@L{#!f0003~u?nF90!|f^tpT_KL<*B<0&6rklWGbFa6w5#
zSc8ac004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;^aAWfn6V%~

delta 75
zcmV-R0JQ(|kpbY50SZJ@L{#8N0004^u?nF90!$Q>tpT_KLJ5;+0&5~AlWGbFa1sRq
h01W_Oa6w5#Sc8ac004uCYykjbaAJsH0J8=I>_utB7C-<1

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index c3d83e67660ee3fd59f6fae6242270bed4a567f1..129d43e1e561be3fd7cd71406829ab81d0a8aba0 100644
GIT binary patch
delta 91
zcmV-h0Hpuda_MpkL{mgmX*mD@0g$l@p#cI;6_c$2xB^59lV<{JG&hrK3I}jONkmwK
xh-?4=gNSSa0Ag?w0s>&58j_KdVgQq34FCWC|8Qc6U;qGc4FHH>0kiZ1V>Vb!9{K<P

delta 73
zcmaD^biIhnCD<h-+>(KT@%~1xg^Wx-B9qrL?qG7_oSe>-t)x0Ri;KNLh?R+fmm#6R
d(bFZOxg&>xp}8Z6ks+xdsUv}5GaGZV82~kR6#D=G

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index 227d421f16ed1824a87e8a91da734828f8b48cbf..b37ab591110d1c8201575ad6bba83449d7b90b21 100644
GIT binary patch
delta 93
zcmV-j0HXiNmjc_D0t!S^L{!_00004lu?nF90!|f^tpT_KL<*B<0&6rklWGbFa6w5#
zSc8ac004uCYykjba1sInV4xb3k&|KolVS}2|NsARVu)Y>0B{Weh+qM;^a9n0sf!?|

delta 75
zcmV-R0JQ(xmjcO`0t!S^L{!O(0005fu?nF90!$Q>tpT_KLJ5;+0&5~AlWGbFa1sRq
h01W_Oa6w5#Sc8ac004uCYykjbaAJsH0J8=I)rfXx7N`IK

-- 
MST


