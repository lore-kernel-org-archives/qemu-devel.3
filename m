Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4098CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAg-00005h-ER; Sun, 14 Jun 2026 15:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAd-0008NZ-Ok
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAZ-0001n1-5T
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dxfCgK7j9ZVkDQGa2uadefxrlsgf/dJnDsBtamRXMlM=;
 b=IUzaxOQ0R5fud0X3Jlqm2bXRuR3pZvHOK9PzrXpWS1umGKwTFxgQeVDsjx87QfBNY68p5+
 qPsk+Wi4yLU6kxdmzqcSM7/yuSeWwKSIOc5qHguhx3qj7kII3FEjvY9749h0HL1FuVoMft
 d71nioctsgs7eFv195ze68U7DH/EhO4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-A59-as7TOAq_V2Bui9d_yA-1; Sun, 14 Jun 2026 15:06:53 -0400
X-MC-Unique: A59-as7TOAq_V2Bui9d_yA-1
X-Mimecast-MFC-AGG-ID: A59-as7TOAq_V2Bui9d_yA_1781464012
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b7959b9fso25351685e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464012; x=1782068812; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dxfCgK7j9ZVkDQGa2uadefxrlsgf/dJnDsBtamRXMlM=;
 b=C1RiroInPkxczYTByhMZN/ghbF8yhzhM/m7O6n/g73FveMkCVFOJTaFUmEQTukts8j
 ZCrrOuBM1lREE6zgx46zOsMrBgPHsQLNOPrryxINPefeZnR/WVk6QszNgi363qwGx+Lj
 4eSapQxLvI7HyQNPIkxv3SVLc25lnlBLisQyTyIb4PU4AxWK6MQBclc3DM1uG1uJxb4d
 D6ntIjJax9WsTxY5g0CYDZaOrniWBnJuieFalnPcMKwmKpVTYC4wCps/bJUzRnzLrFDw
 uJTw8g+z4Qo5lUR2wSWXdOzFVeXeCMKgMz8FXXE0qQ6vEhW6RLvc/HxKnhY6e6W48nGo
 00Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464012; x=1782068812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxfCgK7j9ZVkDQGa2uadefxrlsgf/dJnDsBtamRXMlM=;
 b=X2/DTXVN4K8r4vJX4Uw+M1CTjjR2YYo/4Y9+vVq6XaSL6xGuXPYoVMVJw94W43DWUp
 QZc1T0sKKClzkSiJ+AdtrHvRuqT/MFUPsIcoWCe734PJH4jCu2DZ4VGdd6rYrFrlQ3f1
 5dK8TInB+zUurP03zsxd5fG8GYzx0LBsP1gYTqDBtlBd/zbBLjYLfrMGd11XYp5wHIVs
 7aKtSWWbjHkZKjpNIbpvMw4osy8/qVF8wNr7+5YXAsnpt2kUQJfcfZyR55rlx7K/Jp9b
 fUgkgmtqscUGUj6HkdB75AL1s9tNNACQha/Z5jM+ZdShAkVRUGWWTuabNhqlOw8Q6d8S
 Hc9A==
X-Gm-Message-State: AOJu0YzCJc2w2B80uP4yKRBCDDnKVHCSkwAc44djMoB5vRTNVx36HJvH
 PBFcPPzl0UgYVVkqlVYdFszzBppSRnvozyacH9gy39KayvLW0syJC1vQSahBpOSGqN/MivZZtS6
 rpjA94QgWCNu8fSAhCOkQhUryn2VES3x+RnAdMPNUhjseKh1oKMffNA6dh5Eivm9+kg9OsZS8Bz
 mCK212gvy7CBSaOOqaKOCAcRIc1utw1S/trg==
X-Gm-Gg: Acq92OGygSoE5xVtXaTrT5+S8Mrm+GETwmsTbBec9nYvEABK9/1ULsoOzX7J11NBSKw
 cpUBQIwL67Hqf66ZY1H3tMq63CnmYtHfG6Q4I5fT3Dl/hGW+BCXG/ZRK/b3vW43/01UA4Z4lkf5
 wg6TuoE1viW2vBOnlFUZFB0iE9u92T4JwNqSM6RqJiz58fgyy9vgz27BE0ODOw5sCGpNCJDZe9g
 eJwD6eIuFG0z4Qhpr3sUwEQ+tdFDg0XRekJ496L9Uq+/EQocJEm5nYIvlo3byPJhAO3GTpH6ih1
 VpC4GxR/TKCKLxMSANj9KPH/j7uvMnrknpg2HX71l8uh2KMan/RlN0sdWWgPgkBvRi2Hgxjq4Mp
 QED92qgfYyyuSM8FX+BI3TGvHcR88XXtOBC2qzMhISI8=
X-Received: by 2002:a05:600c:c4ab:b0:48f:f64c:c2fe with SMTP id
 5b1f17b1804b1-490ec4f8090mr159054925e9.22.1781464011530; 
 Sun, 14 Jun 2026 12:06:51 -0700 (PDT)
X-Received: by 2002:a05:600c:c4ab:b0:48f:f64c:c2fe with SMTP id
 5b1f17b1804b1-490ec4f8090mr159054375e9.22.1781464010856; 
 Sun, 14 Jun 2026 12:06:50 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea94f5b0sm187748255e9.1.2026.06.14.12.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:49 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 026/106] tests: data: update x86 ACPI tables
Message-ID: <c549dca2f27e163b7bf7284e34d5b945a8ed47a6.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Update the x86 ACPI tables to reflect the IRQ descriptor changes for ISA serial
ports:

     Device (COM1)
     {
         Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
         Name (_UID, One)  // _UID: Unique ID
         Name (_STA, 0x0F)  // _STA: Status
         Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
         {
             IO (Decode16,
                 0x03F8,             // Range Minimum
                 0x03F8,             // Range Maximum
                 0x00,               // Alignment
                 0x08,               // Length
                 )
-            IRQNoFlags ()
+            IRQ (Level, ActiveLow, Shared, )
                 {4}
         })
     }

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Acked-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260515150634.2637533-5-mark.caveayland@nutanix.com>
---
 tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 366 bytes
 tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 366 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2986 bytes
 tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 405 bytes
 tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 415 bytes
 tests/data/acpi/x86/pc/DSDT                   | Bin 8598 -> 8599 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8509 -> 8510 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9923 -> 9924 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15469 -> 15470 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9062 -> 9063 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10252 -> 10253 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8549 -> 8550 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5087 -> 5088 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8670 -> 8671 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9957 -> 9958 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8456 -> 8457 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8604 -> 8605 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12391 -> 12392 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8427 -> 8428 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8444 -> 8445 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9752 -> 9753 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12637 -> 12638 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8706 -> 8707 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8473 -> 8474 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12040 -> 12041 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12985 -> 12986 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33842 -> 33843 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8891 -> 8892 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13218 -> 13219 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10081 -> 10082 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8502 -> 8503 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8515 -> 8516 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8444 -> 8445 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9786 -> 9787 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9557 -> 9558 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13280 -> 13281 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8289 -> 8290 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8285 -> 8286 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8433 -> 8434 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8528 -> 8529 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12985 -> 12986 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33842 -> 33843 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9033 -> 9034 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9059 -> 9060 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18661 -> 18662 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14684 -> 14685 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35790 -> 35791 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |  47 ------------------
 48 files changed, 47 deletions(-)

diff --git a/tests/data/acpi/x86/microvm/DSDT b/tests/data/acpi/x86/microvm/DSDT
index f477668f2ee80241e47b340ad4a30f5480df2049..5d03103170c7e22f903f3ccdb3d32be0a4405498 100644
GIT binary patch
delta 47
zcmaFM^p1(kCD<h-kCB0a>GMP`X-1EUYUYf_6XO*51-ba#8GkVUU}oS@7GRK=*!utg
DFN_Rz

delta 46
zcmaFI^p=UsCD<h-myv;iNpK>UG^6`OHFHLziE)a20$jZAj6axvFf(u{2{26TdjJ3k
C0}FKk

diff --git a/tests/data/acpi/x86/microvm/DSDT.ioapic2 b/tests/data/acpi/x86/microvm/DSDT.ioapic2
index e5924a49962e0cff4228bcfc77ebcf48cb4a2219..b48db019ffec202fb93a5cdd834581f5e8bdba66 100644
GIT binary patch
delta 47
zcmaFM^p1(kCD<h-kCB0aY3)QVX-1EUYUYf_6XO*51-ba#8GkVUU}oS@7GRK=*!utg
DCWZ_z

delta 46
zcmaFI^p=UsCD<h-myv;i>GVV{X-4;nYUYea6XO*51h{zJ8GkVUU}oS@5@49v_W%GN
CLkuqf

diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
index b646a05551c1ed902413a462442346ce246f8675..b92fb08532a24eaf5cfe0e6039e80688be3fffa7 100644
GIT binary patch
delta 48
zcmZ1}zDk_SCD<io6*mI|)2)eI(u^(>)yx@<C&nrA3v%(fGyY)y!OXy+EWjYKu~&v0
E05Eb3rvLx|

delta 47
zcmZ1_zEYgaCD<ioB{u^D(~pT<(u~d%)yx@<CdMi932^bcGyY)y!OXy+B*3t-Plg)+
DDIN=_

diff --git a/tests/data/acpi/x86/microvm/DSDT.rtc b/tests/data/acpi/x86/microvm/DSDT.rtc
index e375473b5f033d374dd2a64a9f814fd16c3e262f..c101332010f058824c8e11c7a1f844c752816f63 100644
GIT binary patch
delta 48
zcmbQjJe8TtCD<ioDkB2})4_>c(v1ES)yx@<C&nrA3v%(fGyY)y!OXy+EWjYKv6r0@
E02-DH2><{9

delta 47
zcmbQrJcXIdCD<io3L^sp)BTBD(u{r+)yx@<CdMi932^bcGyY)y!OXy+B*3t-kDU<!
D6Tu4!

diff --git a/tests/data/acpi/x86/microvm/DSDT.usb b/tests/data/acpi/x86/microvm/DSDT.usb
index d63fd84620a2689120b32262f964e6a098d71632..9261b67dc055d4cb2194892bc20bd869c7a467d1 100644
GIT binary patch
delta 48
zcmbQoJfE4%CD<ioJ|hDI6Z1qaX-3b9YUYf_6XO*51-ba#8GkVUU}oS@7GRLr*el2g
E00r_2Z2$lO

delta 47
zcmbQwJdc^nCD<io9wP$-lj1}!X-1EUYUYea6XO*51h{zJ8GkVUU}oS@5@6WaC&&l@
D|FjBi

diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index 6ea2d36d138daffb59a8636759078500adc58f24..e30e7091ddcc00fef2171918f0f5fd69aba72f95 100644
GIT binary patch
delta 82
zcmbQ{Jl&bgCD<iox*`Ju<MoYP+lA!3p2frmJH-n)JqvL5G>C5E4mL1|=ZJT731WzD
ma^HMkD29>Ic(RR%BEKLPpF86Z<{!)q9LfR=5}UI{w0Qv-eisS=

delta 81
zcmbR4Jk6QQCD<ionj!-O<M)kR+lAyjpT)!nJH-n)J_~U6G>C5E4mL1|=ZJT731WzD
la@%}gD29>IXtIrnBA);kuRG%p<{!)q97+NVn{!08c>xKT7YYCX

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index d8c173aa613f51b1c76ea7b9dee19e899cba240d..4e044bb4eb2048a8ae15df102b78c6ebf0cd8f13 100644
GIT binary patch
delta 82
zcmdn%w9kplCD<jzPLY9uQGO%Wb|E>(hcWTNPVoYs4+5M$4WgU4gAEMgIpQ5%f*7Kk
m+&AABieY3lo@^tc$S=sn=g#<p`3Exthq3^J#O7>~OFRJNW)|K6

delta 81
zcmdnzwAYEtCD<jzR*`{$(S9S>b|E>3hcWTNPVoXB4+5M$4WgU4gAEMgIpQ5%f*7Kk
l+&14AieY3lnrtJY$S1(X>(2Ot`3Exthmrup<{XhrJOI{H7Ty2=

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index ba363d6af76af728b7c88bbaf47f7e0ea3dcb41f..54ce2df998b10a9c88efe8b76c7b2d533460d432 100644
GIT binary patch
delta 82
zcmX@?d&HN^CD<k8h#CU}<CKkDPsHWCp2frmJH-n)JqvL5G>C5E4mL1|=ZJT731WzD
ma^K7&5yQx6JULTRkzbID&z<oH^ABbQ4rKubiOn-4wRr(B>lZKp

delta 81
zcmX@&d)SxDCD<k8uo?pc<CcwFPsHUspT)!nJH-n)J_~U6G>C5E4mL1|=ZJT731WzD
la@))!5yQx6G&xgJkxzh&*PZbP^ABbQ4kZDG%`+vnc>y947cc+-

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index b68302363cb24181988d6e3dceb04a0946838d5e..957e12c296d76ef63877691947c94176ab40b08d 100644
GIT binary patch
delta 83
zcmaD`@vef)CD<h-&xV14@##jc?LrEDy-YFj!A|i4t-VYE&YlL*P29l-2Jsy6jxIqA
n(M|4~9}2}VG8#{|6H(+B<l=K@{K5Q#nSn!DfI(t$u80NzWKb95

delta 82
zcmaD?@wS4?CD<h-*M@<Ck#!^2b|Hn{UZ$A%V5fM2mR_a+XHSFZChlMZgLsa3N0%Um
m=q9(#4~1eF8I2~}i74_3aPhh`{$T#W%)p@}z_2(^L<0a2uNLC~

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index 20688edf2da41146ece4faa4141517408a42870c..64e1b6693d67138e6d6c58c43bbcef0dcfd215b4 100644
GIT binary patch
delta 82
zcmaFn_S}ujCD<h-U73M_(Q6}DyNI0EvzYi`r+5LUX93Qh2GLF2!3GBL9Py4WK@8DN
m?wi+(#4s`%Pv#L*<QL@Pb7%a){DYZ+Ls@`9VzafFHZK4K8WueO

delta 81
zcmaFv_RNjTCD<h-O__m#F>51NyNI0UvzYi`r+5L!X93Qh2GLF2!3GBL9Py4WK@8DN
lZkyMO#4s`%P393(<P+fHb!Ys+{DYZ+LrH*PvyGTGF97w$7Cis}

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 8d4be05d2c71ca8de6d732d3e48e0e323143160c..3c27fd0d1ec7469b4cc2efbf2e476b3345c3d86d 100644
GIT binary patch
delta 95
zcmeAP=ndd<33dtL)nH&?{JxP(SCZ4~SxkJeQ@nuFWCuwRM)%F3k}-^i#?Jn}h8*!8
zo-RC&7g!lN;zK=M7&+pDLmavIIpUpzf&~S+_}m$PF#lj?;7}G|kl6fCN}Cq|t_~Nb

delta 75
zcmeAT=n3F*33dtL(O_U;6yM0DE6M5kEG9nKDPF*FvV)`uqub_C$rwg{BWHhKLymY4
fPZu7?3#^Qjd!!^de=z@GX5df~VA%XfN}Cq|+i4SC

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 2b5b885b862a2fe8bc4a24446400dccf685dab85..89c4df716af921f4dac0c8ba1f7968ef1f93f717 100644
GIT binary patch
delta 82
zcmaFr^vsFNCD<h-O_70tk$WT8b|E>>$1(B2PVoYcj{}@N4WgU4gAEMgIpQ5%f*7Kk
m+&AABieY3lo@^tc$S=sn=g#<p`3Exthq3^J#O7>~UpxQ>h8J%D

delta 81
zcmaFn^wf#VCD<h-Rgr;#QF|lTb|E>B$1(B2PVoW`j{}@N4WgU4gAEMgIpQ5%f*7Kk
l+&14AieY3lnrtJY$S1(X>(2Ot`3Exthmrup<{Xh<JOK9l7jFOn

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
index cc6f26a3f8fe85f34a8acb5432bab3cf4d3ab1f6..8cd0d2a4cf82d9fedbee74671e8ff5ad820a5c77 100644
GIT binary patch
delta 82
zcmcbw{y?3}CD<k8fiMFDqt`|*9zi)TotXGwr+5J;od9P~gXkviU;~4Aj(A6xAcp8B
m_su4PF^r7HlP3x(@(XhDxikJ?{=v+^p)9~4vH5_IJR<;>Fcj1P

delta 81
zcmaE$eqWu-CD<k8zAys=W7bA49zi)zotXGwr+5KJod9P~gXkviU;~4Aj(A6xAcp8B
lx6LMkF^r5xlP3x(@(FP9x-<S@{=v+^p(Mbt`Jj+IBLIoK6x09!

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 052a84e294eee4ecef9a36341493f841caf887a5..97bfbf74ef1d00aaadfac066032677d72f2bc054 100644
GIT binary patch
delta 82
zcmV-Y0ImPtL*GLRL{mgm-yr}10aLLGw-O#g>s((`LSGO{>QF;TFk6BPQ!p@J2wy=&
oQUF_mPqW_=qyYgllY|r@4-pCuM*;W)_yYh4BM<->v$GT{4N6-WM*si-

delta 81
zcmV-X0IvVvL*7FQL{mgm-XQ=00duhmw-O#f>s((`LSGO`>QF;TFk6BPQ!p@J2wy=&
nQUF_mPP5+<qyYgklY|r@4iE|rM*;W)_yYh4A`k$xv=l21I)NBR

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 7efc12a46cb87c0684b7d880b2cc94d302744e03..b2c4c70d9cbdf74ab07983f69b0315191a7ee142 100644
GIT binary patch
delta 82
zcmaFr`^=ZiCD<k8nHmEF<LZrEY!Y%_&tl?(o#F+Yo&`928bmj72OAi~bHqEk1TjQ6
mxo_5!h+$+jp4=^|$S=sn=g#<p`3Exthq3^J#O7U++PnZI^%ph(

delta 81
zcmaFn`_z}qCD<k8sTu<V<LQlDY!Y&w&tl?(o#F)?p9MI38bmj72OAi~bHqEk1TjQ6
lxoy^yh+$+jn%pg^$S1(X>(2Ot`3Exthmrup=G~IoyZ{$C7d8L@

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index 7eedfcd64ebd0193744864b4f6cbead35c7c3ab2..f762b83ee7a5001f5a92a73c201b814f7007afd5 100644
GIT binary patch
delta 82
zcmeBh>U83A33dtLRAgXaT(FT#Q%KJ1SxkJeQ@nuFvjAsLgXkviU;~4Aj(A6xAcp8B
m_sxMqF^r7Hlh+9=@(XhDxikJ?{=v+^p)9~4vH7mBHZK6K_Z95`

delta 81
zcmeBl>Tu$633dtLP-I|WJg|{VQ%KJ9SxkJeQ@nuVvjAsLgXkviU;~4Aj(A6xAcp8B
lx6Oe<F^r5xlh+9=@(FP9x-<S@{=v+^p(Mbt`JS*gF94yS73}~3

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 910b4952a0757025cfed1c60416d16054e70846f..a215ea995a2f5a2bd4c7876fd79011b7ce5beabc 100644
GIT binary patch
delta 95
zcmbQ^JlC1aCD<iot|9{iWAa9>y+WK`&tl?(o#F+YCSMQ|VRYa8R49hg(Ae4E*N`LL
z!_$Sw@d7I&M|`NK3nNE-aEK!pKS#WCP_UpN7oR)h59S}t3>?Y=3=*3QMYMSV8UYx_

delta 75
zcmV-R0JQ&|L!3hjL{mgmoFM=J0fVs$y%GsY=3HM>LSGO;lh6_r0Y<as5?lcfGDA;I
hF$iBsNkj}m&;<dL926J{_yhO@00<%w0JCxwD-B#;6$k(T

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index 45d3dbe1b69143a956b4f829913ca47f07134741..6a1557bfd816c061c317e5fd35c417543d668050 100644
GIT binary patch
delta 84
zcmaE!@FIcBCD<h-!+?Q-F?l1`b|HnP^Nca^!A|i4o#z+>oIMSqo4A7w4B|QB9bJML
oqMO_|KNN~#WHg>^C!)wN$i?T*_=EWeGXsaR0E5KlT#;YW09}<Bi2wiq

delta 83
zcmaEn@H~ObCD<h--GG6Cv3Vocb|Hnv^Nca^!A|i49p@MWoIMSqo4A7w4B|QB9bJML
nqMO_{KNN~#WHg#=C!)wFz{Ts%_=EWeGXsZ`0K?`ykzdjPPD>bx

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index 377e880175f6f11101548c0c64da61b5aee00bd9..55b44cfa70f33986aff4eb2332248486689e13ec 100644
GIT binary patch
delta 65
zcmaFu_{NdTCD<k8jRFG$<I;^>^75Q+(lPPDPVoYMla1sZ7`-PK%YR@ro}8kf$S=sn
V=g#<p`3Exthq3^J#N^2e5dehL5)A+V

delta 64
zcmaFk_}Y=nCD<k8wE_bJ<I#;=^75Rn(lPPDPVoZ1la1sZ7`-MJ%YR@rnw+Ab$S1(X
U>(2Ot`3Exthmrup<S7af0C`ao4FCWD

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index 026bfdfebf66c1803f158ac8c115eb5f49b5cb19..50691d93ed45b697290ca32d0f56765fc3a77379 100644
GIT binary patch
delta 65
zcmez4_}7ukCD<k8uL1)Dqw7X4d3jEEnV9%sr+5MX$wu;ljNX%5<UcSPPcBtZ<QL@P
Vb7%a){DYZ+Ls@`9V)7D&2mpja5+?uv

delta 64
zcmezC_{WjUCD<k8j{*Y&W9mjOd3jDZnV9%sr+5Ls$wu;lj9!yl<UcSPO)gbX<P+fH
Ub!Ys+{DYZ+LrH*P@=}Ee0C=_%CjbBd

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index f1b8483d8da21dd57f3e5e7a1e4eb787df2c38ac..6b1b87699e96f06f315df529ee6306633d7fad0b 100644
GIT binary patch
delta 65
zcmbQ?Gt-C5CD<iIQjLLuF>xc8j|!)obWD7(Q@nuR<aiYaM(@cBR6Z~oPoAi%$S=sn
V=g#<p`3Exthq3^J#N-325dc9i5oQ1Y

delta 64
zcmbQ~GsB0=CD<iILXClev2i1pj|!)&bWD7(Q@nuh<aiYaMz6^WR6Z~oO`fQ#$S1(X
U>(2Ot`3Exthmrup<b$da05*jYW&i*H

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
index a7731403f460a235bf705770a1547dafeee069ab..833e55273ca2e72c7fe047d1c2e593a6169b8dca 100644
GIT binary patch
delta 66
zcmcbcbT5g^CD<h-&X9qDQFJ5MI$cgDqnP+$r+5Lc%?EYYFfw{i&eQ+EXgoRIK#^aN
Wi_e|$2lEeR1`cHb28qdi2Im2*XcLqG

delta 65
zcmcbYbT^61CD<h-){udL(R3r%I$cgjqnP+$r+5L+%?EYYFfw{g&eQ+EXf!$AK#@;?
Vi`Sj;2lEeR1`Z_whROW~=K-Gm6O;e|

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index cb4995de7e33cd9f2d134ec96651d217873d6944..4bbff971ec2edd32f58272c0381c383839b75248 100644
GIT binary patch
delta 65
zcmZp2X?Edq33dr#R$^dal-|f?roibY9TOky6ffX6*;B!R(R*^2!Usm<$<>OA{DNG3
V?u<W}e=sv}C<`!1OkSlJ0RRxO5J&(3

delta 64
zcmZp6X>#Fm33dr#Qet3WwBE>Nroibc9TOky6ffXA*;B!R(Q9&-!Usm9$<>OAd;(m&
U?u<W}e=sv}C<!o3Uac4b00#>YNB{r;

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index 92c8fdb6cbb8ae8bdf5ede9679eea92486eaf372..01834e412bbc52e5a62364df94f5e1dbb637ef72 100644
GIT binary patch
delta 94
zcmbQ~G|P$0CD<iIN|Awqamq$6d3jD3xtRE1r+5LM$wu-HjGmi|<>eR+jh+2{4LRaH
yJY9GkFR(Il#D{viFml8Phd6TabHqCb1q%vt@wqepVE)0(z@aR_ATjx%LIeOoMiy-V

delta 74
zcmbQ`G}DR8CD<iIQjvjyamz+7d3jD}xtRE1r+5MH$wu-Hj2@ed<>eUpjhy{`4LRaH
eJY9GkFR(IB&QXxy{K5Q#nSnz|fMN0>g$Mw{l@kj9

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index 957b3ad90c787616eac212865bce0a19a5ac1e6e..e379a9be89a34551b2a5016ebcc24c08a28a3625 100644
GIT binary patch
delta 66
zcmeB(>x|=a33dtL)MsE|Jg|{VUY^tEYfOBwQ@nu7W+VA$yo}zHC3QbA8c*iZQ{)%q
W;&W&G!Tf`nfkRn<L1MC{-gy9XToMET

delta 65
zcmeB->xkoW33dtL&}U#^e6W#AUY^tYYfOBwQ@nulW+VA$yo_FxC3QbA8cpWXQ{)ri
V;&o^I!Tf`nfkR1vVX~Fpc>riC5(EGM

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index 50ca91b065d9a2ba95f97d01856865f0e7c615f6..50d6eac8ba070bf381aacd13ced47115f0897ebe 100644
GIT binary patch
delta 92
zcmdm)x+|5-CD<iomk|R4qwGemw+5VU(lPPDPVoYMlMEdgy(c>welRq4_V+d9i1+Yx
w;c>jc%E%EP>gmGB5g#1l$i>eQ?;I2?D9FX<&iI4*2QveQvH*j`<V2$g0Lv>FF#rGn

delta 72
zcmdm$x-*r_CD<iorx61KqwPknw+5W9(lPPDPVoZ1lMEdgy(T*ve&9E9_V+d9i1+Yx
c;c>jc$~c+FNP_bR^ABbQ4kZDG$w@{L03N6mfdBvi

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index f460be2bf74ae512db8f24418b42e8cf2a56202d..69b31da613663a58f9adef8d3981d9ed7c824a28 100644
GIT binary patch
delta 67
zcmdng!L+%9iOVI}CB(Refq^k^BUf4zr<-(4e6UlzfZycGCI?3E$-A09Fd9!@-K@wj
X$i?T*_=EWeGXsaR0E5KjTg?#w%efTu

delta 66
zcmdno!L+G^iOVI}CB&$Ofq}7aBUf4zr>k^Ke6UlzfbZnWCI?2Z$-A09Fd9u>-K@wb
Wz{Ts%_=EWeGXsZ`0K??l%@F{-`xNs4

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 7c87d41d03fcfd2b5b82f2581f16de6bc0bb10bf..d46bac4e257162b5ecc98c7c130c1654de192192 100644
GIT binary patch
delta 65
zcmdn(y2q8vCD<ioj}ij|qr^t8_X?bD(lPPDPVoYMlbIA97`-PuD}G=!o@}C|$S=sn
V=g#<p`3Exthq3^J#N=e92moK65fcCa

delta 64
zcmdnvy4#h@CD<iow-N&bqs2z9_X?b@(lPPDPVoZ1lbIA97`-MtD}G=!nrxz^$S1(X
U>(2Ot`3Exthmrup<P@a{095A@6951J

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index da86b25f51b550ab20771111cb0a2bc49e713186..9517048a5776d4668b2bc31a13da69865225f171 100644
GIT binary patch
delta 66
zcmZ3KzBrxBCD<iou`vS!<BN@4TMW58WMkrko#F)?WGA06Ol0()tY!3p(Ri}7u_C`9
W7oR)h59S}t3>?Y=3=)&Qj3WTAH4?S}

delta 65
zcmZ3Sz9^l`CD<iokud`U<Ijy;TMW6}Wn<!lo#F-jWhS36Ol0($tY!3p(P*-?u_B)U
V7q2_x59S}t3>-=V43oW$BLJcw61D&U

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index a2d812e5a23a3ce7739789246b342e703f8c96c0..e817aa6d91c5ee9355787b3d1cc7a126a7620b23 100644
GIT binary patch
delta 65
zcmV-H0KWg>PU21qL{mgmVkZCq0mZQjl_d#A8(d#gLSGP0lc*&?0ZWtVCGY_=liDUB
X4-pCuM*;W)_yYh4BM<->lL;qSucs3o

delta 64
zcmV-G0Kfm@PT@`pL{mgmVJ83p0p+m@l_d#98(d#gLSGO~lc*&?0ZNnUCGY_<liDUB
W4iE|rM*;W)_yYh4A`k$R3MW{ikrN#N

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 43ac1bd693d1b3f67d2a9e89ccaf8a56656df22d..e004d4e385bedcae95c7c76f4f7bcbb9f3e8c015 100644
GIT binary patch
delta 66
zcmdnywB3ozCD<jzT#<o+@y13jd3jDpg_!tYr+5L+$wu-HjBcBY<*gYRjVG^HP~;cn
W;&W&G!Tf`nfkRn<L1OYfg$MvoRS_Hj

delta 65
zcmdn)w9SdjCD<jzOp$?s@yA9kd3jC;g_!tYr+5L6$wu-HjINuD<*gYRjV7;GP~;Qf
V;&o^I!Tf`nfkR1vVe);22mnPY5gY&j

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index 1b998820d46e522b3129e42a867ed691c1f83e8f..3cc9625a9b6020fd3008c16f4f8df6bfc609e337 100644
GIT binary patch
delta 65
zcmX@?bi|3vCD<jzMUjDl(Q_l0yga9$LQH(HQ@nuNWFvV8M(@eR@*fzDC#NVV@(XhD
VxikJ?{=v+^p)9~4F?q7W1^_$h5g7mg

delta 64
zcmX@&bl8c@CD<jzS&@N(F>@oAyga9`LQH(HQ@nudWFvV8Mz6`m@*fzDCZ{MU@(FP9
Ux-<S@{=v+^p(MaCd5XdY05P%=82|tP

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index 026bfdfebf66c1803f158ac8c115eb5f49b5cb19..50691d93ed45b697290ca32d0f56765fc3a77379 100644
GIT binary patch
delta 65
zcmez4_}7ukCD<k8uL1)Dqw7X4d3jEEnV9%sr+5MX$wu;ljNX%5<UcSPPcBtZ<QL@P
Vb7%a){DYZ+Ls@`9V)7D&2mpja5+?uv

delta 64
zcmezC_{WjUCD<k8j{*Y&W9mjOd3jDZnV9%sr+5Ls$wu;lj9!yl<UcSPO)gbX<P+fH
Ub!Ys+{DYZ+LrH*P@=}Ee0C=_%CjbBd

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index 7346125d23fb3174c0ce678a2cdf2fdc77c4a9fa..0dd16e8455912836401786a89eeaa04b803124f1 100644
GIT binary patch
delta 65
zcmdnxv)hNuCD<jzT8)8$v0@`vo(iX%bWD7(Q@nuR<VF<-M(@doR6Z~oPu{Gm$S=sn
V=g#<p`3Exthq3^J#N<b+5dd(A5{&==

delta 63
zcmV-F0KosdOu9@8L{mgmIwk-B0hqB0ZX^js8(d#gLSGO~lYt~a0ZNm?B=7+;ld~lu
Vlb|I93HSr}0{{pj5CD_oC0J)56LtUq

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index 15a291dbfb62e6ceb0249e02eb25b319744e351f..0f436d68fc5852d4a282e26eb1b729d434c0aad2 100644
GIT binary patch
delta 65
zcmccWb<K;*CD<h-OqGFw(Q+eKg)*nROiX;RQ@nux<Zk6aM(@dYl|L{VPd=xj$S=sn
V=g#<p`3Exthq3^J#N@v!5deW@6Al0X

delta 64
zcmccSb=8Z@CD<h-RF#2&F>)hUg)*m`OiX;RQ@nuR<Zk6aMz6_tl|L{VO+Kfh$S1(X
U>(2Ot`3Exthmrup<bNs=0Ci6j4gdfE

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 889a9040d950dd08980408d57f1037a5fc20c961..1e3f17690f8719f50adcbc4c9f11a8dc9075cf92 100644
GIT binary patch
delta 96
zcmaEm{xF@(CD<k8p)msk<F1Wd^733QI*c*#!A|i4-J6Z&eFYi4CpQ{=Ff?}d_ci2*
z_waP#alF9F$Ppjv>B7hn9~|Py#m^D%926`l$i?T*_=EWeGXsaR0E5Klg@*P_0A|@4
A-T(jq

delta 76
zcmaEu{ve&pCD<k8fiVLE<E@Qc^735GI*c*#!A|i4U7L;NeFYi4CN~;<;5Tyi_ci2*
g_waP#alF9FIN8Tgg7XLS4`v1qB>{%biwy0V0H1mmZ2$lO

diff --git a/tests/data/acpi/x86/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
index 780616774f97a2d7305faf9e9a9d12afeb0e2fa2..2138ef2cad454ef202bfa2097e1c24a0603eb240 100644
GIT binary patch
delta 66
zcmaFp@W_G7CD<h-Nr8cZv3(;~i7cm!UQB$jQ@nuB=62aUMn><+-{d|p8c%*MugEXR
W#pllWgZT$D1BbEzgT!Pp1#bYROcKoi

delta 65
zcmaFl@X&$FCD<h-QGtPhars8B5?M}Xy_oo5r+5MH&F!*zjEr8BzsY@IG@ATeUXf3L
Vi`Sj;2lEeR1`Z_whRNaz-T;}L63qYr

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index 0f862ab2938e0e11aa8335630fad389095b37edd..20468b6b00431fad96dd158744c337821a37a1f9 100644
GIT binary patch
delta 65
zcmccXaL<9uCD<h-PJw}eF>fQ+L^)13>6rLnr+5Ls$xGxM7`-PymHWVGJo%cuBEKLP
VpF86Z<{!)q9LfR=5|ddKA^?p-5?}xT

delta 64
zcmccTaMyv$CD<h-R)K+mv2P>SL^)1Z>6rLnr+5M1$xGxM7`-MxmHWVGH2IpmBA);k
UuRG%p<{!)q97+NVli3s^0D#^SU;qFB

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index df8edc05b69ecd1331973b16e534b44616b50f58..c24caffd8dae778b3f37381834f528737849248d 100644
GIT binary patch
delta 65
zcmez9_{ovWCD<k8lL7++qv1v_Re4S~>6rLnr+5Ls$rkbsjNX$g<v%bQPtH<M<QL@P
Vb7%a){DYZ+Ls@`9V)9Id2mp0N5y=1m

delta 64
zcmez5_|cKeCD<k8qXGj1W8g+ERe4TV>6rLnr+5M1$rkbsj9!x~<v%bQP0mtK<P+fH
Ub!Ys+{DYZ+LrH*P@+^f20BQ>n$p8QV

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index da3ce12787c28e555b6ba5eacb26275bdd4587f1..9355f161aaf04b2a7af3064502868802d313e679 100644
GIT binary patch
delta 67
zcmccMbkT{+CD<h-P?3RwF>NE4ygaA3VoZFnQ@nulWFvV8CI{)wCGsJRjK-5sDk$;`
Xa`Cw{{$T#W%)p^6z#uXChe8AZU5yc8

delta 66
zcmccUbis+sCD<h-K#_rgv3w(!yga9uVoZFnQ@nuFWFvV8CV#2TCGsJRj7F1BDk$;^
WaPhh`{$T#W%)p@}z%cozLIeO(C=p=*

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index 50ca91b065d9a2ba95f97d01856865f0e7c615f6..50d6eac8ba070bf381aacd13ced47115f0897ebe 100644
GIT binary patch
delta 92
zcmdm)x+|5-CD<iomk|R4qwGemw+5VU(lPPDPVoYMlMEdgy(c>welRq4_V+d9i1+Yx
w;c>jc%E%EP>gmGB5g#1l$i>eQ?;I2?D9FX<&iI4*2QveQvH*j`<V2$g0Lv>FF#rGn

delta 72
zcmdm$x-*r_CD<iorx61KqwPknw+5W9(lPPDPVoZ1lMEdgy(T*ve&9E9_V+d9i1+Yx
c;c>jc$~c+FNP_bR^ABbQ4kZDG$w@{L03N6mfdBvi

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index f460be2bf74ae512db8f24418b42e8cf2a56202d..69b31da613663a58f9adef8d3981d9ed7c824a28 100644
GIT binary patch
delta 67
zcmdng!L+%9iOVI}CB(Refq^k^BUf4zr<-(4e6UlzfZycGCI?3E$-A09Fd9!@-K@wj
X$i?T*_=EWeGXsaR0E5KjTg?#w%efTu

delta 66
zcmdno!L+G^iOVI}CB&$Ofq}7aBUf4zr>k^Ke6UlzfbZnWCI?2Z$-A09Fd9u>-K@wb
Wz{Ts%_=EWeGXsZ`0K??l%@F{-`xNs4

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index 67ebd7c158759221b801ecb67d8562d92fa219d5..a16d232e61f64876cf0eddd9cf6c1d3a5141ce73 100644
GIT binary patch
delta 78
zcmX@<cFK**CD<jzOPPUz@ySLmZFw#ahnV<ar+5JehspNx_Kd!p>*bx8`Hh|ZeGNI{
iJv?1_951jkPJS;h#^cWTgZT$D1BbEzgT&;IN)Z5K*cF%n

delta 75
zcmX@*cG8W@CD<jzQ<;H*@#{t|ZFw$thnV<ar+5K>`^on5_KZH8>*bx8`Hh_YeGNI{
fJv?1_951jkPM)JA!TE#v2QveQk^sZxPf8I0DiRd}

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index c6b58472157d575e2625557d1346586be06b927c..96e4b7b731c5d3142765979166a4ee8148e98490 100644
GIT binary patch
delta 66
zcmaFt_QZ|LCD<h-MVWztv410%wmhekQ%roYQ@nuJWIK5WM)%G2@-fVe#*^<TDe?<)
W@wqepVE)0(z@aR_ATgO+IRXH6I1w)Z

delta 65
zcmaFj_SlWfCD<h-S($->as5UvZFx>dr<nL)r+5L+$#(J%jBcCj<ztu`jV9kwQsfih
V;&o^I!Tf`nfkR1vVKR?$1ORF(5ibA$

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index 17a64adb2055ad3168754ca121bf29851d2ee496..dd0a3a7581a0d2f532c3bd4145f16a4d782ef2d6 100644
GIT binary patch
delta 67
zcmaDlk@49?MlP3Nmyl;33=E7`8@VLiIo+gV;)9*y1^g!KxH~X<PtJA!z-T-<&O?!3
Xkc-cq@dxt{W(E#r0S1Z5y&e$&v6~YF

delta 66
zcmaDhk@4w7MlP3Nmyo9(3=E7>8@VLiIbEe=;)9*y1$-y#xH~X<P0n@yz-Tl%&O?z;
WfQ#3i@dxt{W(E!=0fxza9uWYgL=yx6

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 6eb30e8f4b2c54e4789c649475adff356c8c58a4..e00340c95587db1ed1a17b42ad4036f5fc51d06e 100644
GIT binary patch
delta 65
zcmcapbhn7hCD<h-){=pNv3w(!k2$B8d`x_>Q@nuF<aqNIM(@c_%s((1PrhoQ$S=sn
V=g#<p`3Exthq3^J#AFuB2mq@i6B7Uc

delta 64
zcmcaxbf<{RCD<h-#*%@7ar#CsA9GGm`Iz`%r+5L!$?@hbj9!zUn15h2ntatlkxzh&
U*PZbP^ABbQ4kZDG$*h(U0G=ch6951J

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index 111bb041dc0d114351add07c040dde61643d157a..50780e37eecd2f8bc328c3290b4cd0ce3427d8a7 100644
GIT binary patch
delta 67
zcmX>%o$35^CN7s?myq+_3=E7}8@ZUeINhXU;)9*y1^gz9b~!M5PY&z)z-T<#y<3rA
Xkc-cq@dxt{W(E#r0S1Z5W!(_~(y<gA

delta 66
zcmX><o$1_kCN7s?mymPa3=E828@ZUeI9;V<;)9*y1$-xqb~!M5O%Ch&z-Tnty<3q_
WfQ#3i@dxt{W(E!=0fx!t-4OuAZWJ5<

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index cef44135bc..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,48 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/pc/DSDT",
-"tests/data/acpi/x86/pc/DSDT.bridge",
-"tests/data/acpi/x86/pc/DSDT.ipmikcs",
-"tests/data/acpi/x86/pc/DSDT.cphp",
-"tests/data/acpi/x86/pc/DSDT.numamem",
-"tests/data/acpi/x86/pc/DSDT.nohpet",
-"tests/data/acpi/x86/pc/DSDT.memhp",
-"tests/data/acpi/x86/pc/DSDT.dimmpxm",
-"tests/data/acpi/x86/pc/DSDT.acpihmat",
-"tests/data/acpi/x86/pc/DSDT.acpierst",
-"tests/data/acpi/x86/pc/DSDT.roothp",
-"tests/data/acpi/x86/pc/DSDT.hpbridge",
-"tests/data/acpi/x86/pc/DSDT.hpbrroot",
-"tests/data/acpi/x86/q35/DSDT",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
-"tests/data/acpi/x86/q35/DSDT.bridge",
-"tests/data/acpi/x86/q35/DSDT.noacpihp",
-"tests/data/acpi/x86/q35/DSDT.multi-bridge",
-"tests/data/acpi/x86/q35/DSDT.ipmibt",
-"tests/data/acpi/x86/q35/DSDT.cphp",
-"tests/data/acpi/x86/q35/DSDT.numamem",
-"tests/data/acpi/x86/q35/DSDT.nohpet",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/DSDT.memhp",
-"tests/data/acpi/x86/q35/DSDT.dimmpxm",
-"tests/data/acpi/x86/q35/DSDT.acpihmat",
-"tests/data/acpi/x86/q35/DSDT.mmio64",
-"tests/data/acpi/x86/q35/DSDT.acpierst",
-"tests/data/acpi/x86/q35/DSDT.applesmc",
-"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
-"tests/data/acpi/x86/q35/DSDT.ivrs",
-"tests/data/acpi/x86/q35/DSDT.type4-count",
-"tests/data/acpi/x86/q35/DSDT.core-count",
-"tests/data/acpi/x86/q35/DSDT.core-count2",
-"tests/data/acpi/x86/q35/DSDT.thread-count",
-"tests/data/acpi/x86/q35/DSDT.thread-count2",
-"tests/data/acpi/x86/q35/DSDT.viot",
-"tests/data/acpi/x86/q35/DSDT.cxl",
-"tests/data/acpi/x86/q35/DSDT.ipmismbus",
-"tests/data/acpi/x86/q35/DSDT.xapic",
-"tests/data/acpi/x86/microvm/DSDT",
-"tests/data/acpi/x86/microvm/DSDT.usb",
-"tests/data/acpi/x86/microvm/DSDT.rtc",
-"tests/data/acpi/x86/microvm/DSDT.ioapic2",
-"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
MST


