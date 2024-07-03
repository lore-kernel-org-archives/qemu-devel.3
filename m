Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFCAC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8nG-0006c2-6Y; Wed, 03 Jul 2024 18:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nD-0006RF-98
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8n9-000791-Gz
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0nP2DrQRonjaFy24Ds+EPs3WzJvfgKW/1tcH3BUQFDo=;
 b=dZ6A20N6+2ueXAY7jCtpasqdpU6CRXSdEbxqlAllAxhXxHTCMjE3jeq3NibteJ5fUFm2eM
 bWxjh3vOCBfY7KD8pjbH3tbecj2Gs+rlW3IyVcykreMaN7pLIV0FZy99DJ8ZkgaPbbfCQV
 uis/FMyRemFu7e/NaGTKN7GKl25jXaM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-G-FwGl3uPUacUO6d5kq_8Q-1; Wed, 03 Jul 2024 18:49:33 -0400
X-MC-Unique: G-FwGl3uPUacUO6d5kq_8Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-425739141c2so5985e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046972; x=1720651772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0nP2DrQRonjaFy24Ds+EPs3WzJvfgKW/1tcH3BUQFDo=;
 b=Rp9bQKgKG7KtaBdeO57cOR2O/uo4G2TTkqc/WgLhH288ngeRHrB13jqrwpQXFo58Ml
 NMN1bZa5OskaZCBK5J60xpDEirBH1kAbGBLHjivnTokzYdbLW4rzJlROKg3La+vw+VOE
 MTnrZsv2Bl4dIzNjla+0a71u0fSUnpgzH1tuZiAA3Yu2t9WVWGg7dx5YlkishEOJNHuh
 ruTpIkQzrd+O9v8ax9AuCu5JBYIJj80WgIxsqVwjEIBgxZh8L3OZ+bKhmHYYPXFsP24J
 bjn72erzEvVdXrnTQABDxhPxUvlU942oH2ghiQByo/tg6CPggmL9yv11H8uDBclNBM94
 XBWw==
X-Gm-Message-State: AOJu0YwsMmET0wZKHSNbDA828+RxXU2YxVPj/ypBngQNqBKNW7BsEYQe
 /IyxzYesX/nkfTSk6BtAe9j3N6bQCLhrMCmx65WZlH4ZpwB2hYFSyibsErs2W1dR6nDEc1CJcjF
 oMseo30tkHVFxvymB7Bg2N4QKFcVca4OJIF7UbW+VGJaj3LwICEPUgL72G4FCo+qF9BDUfinDhD
 I4M72WR1sFo/ZOHYkCnzLxOq0oewtxfA==
X-Received: by 2002:a05:600c:4811:b0:426:4659:12d2 with SMTP id
 5b1f17b1804b1-4264a3e72a8mr387695e9.17.1720046971351; 
 Wed, 03 Jul 2024 15:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlLONosuYN+9btSoNf0DwATSWUfuaJbopIG6f8z7OFNvIWJYz7HACu/KIZCib+XuD6AYOk+A==
X-Received: by 2002:a05:600c:4811:b0:426:4659:12d2 with SMTP id
 5b1f17b1804b1-4264a3e72a8mr387555e9.17.1720046970635; 
 Wed, 03 Jul 2024 15:49:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d6133sm1241415e9.13.2024.07.03.15.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:49:30 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:49:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL v3 67/85] tests/data/acpi: Move x86 ACPI tables under
 x86/${machine} path
Message-ID: <7c08eefcaf6588b80bd8ce027fab748db3c53f11.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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

From: Sunil V L <sunilvl@ventanamicro.com>

To support multiple architectures using same machine name, create x86
folder and move all x86 related AML files for each machine type inside.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-10-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/{ => x86}/microvm/APIC              | Bin
 tests/data/acpi/{ => x86}/microvm/APIC.ioapic2      | Bin
 tests/data/acpi/{ => x86}/microvm/APIC.pcie         | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT              | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.ioapic2      | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.pcie         | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.rtc          | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.usb          | Bin
 tests/data/acpi/{ => x86}/microvm/ERST.pcie         | Bin
 tests/data/acpi/{ => x86}/microvm/FACP              | Bin
 tests/data/acpi/{ => x86}/pc/APIC                   | Bin
 tests/data/acpi/{ => x86}/pc/APIC.acpihmat          | Bin
 tests/data/acpi/{ => x86}/pc/APIC.cphp              | Bin
 tests/data/acpi/{ => x86}/pc/APIC.dimmpxm           | Bin
 tests/data/acpi/{ => x86}/pc/DSDT                   | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.acpierst          | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.acpihmat          | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.bridge            | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.cphp              | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.dimmpxm           | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.hpbridge          | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.hpbrroot          | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.ipmikcs           | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.memhp             | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.nohpet            | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.numamem           | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.roothp            | Bin
 tests/data/acpi/{ => x86}/pc/ERST.acpierst          | Bin
 tests/data/acpi/{ => x86}/pc/FACP                   | Bin
 tests/data/acpi/{ => x86}/pc/FACP.nosmm             | Bin
 tests/data/acpi/{ => x86}/pc/FACS                   | Bin
 tests/data/acpi/{ => x86}/pc/HMAT.acpihmat          | Bin
 tests/data/acpi/{ => x86}/pc/HPET                   | Bin
 tests/data/acpi/{ => x86}/pc/NFIT.dimmpxm           | Bin
 tests/data/acpi/{ => x86}/pc/SLIT.cphp              | Bin
 tests/data/acpi/{ => x86}/pc/SLIT.memhp             | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.acpihmat          | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.cphp              | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.dimmpxm           | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.memhp             | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.numamem           | Bin
 tests/data/acpi/{ => x86}/pc/SSDT.dimmpxm           | Bin
 tests/data/acpi/{ => x86}/pc/WAET                   | Bin
 tests/data/acpi/{ => x86}/q35/APIC                  | Bin
 tests/data/acpi/{ => x86}/q35/APIC.acpihmat         | Bin
 .../acpi/{ => x86}/q35/APIC.acpihmat-noinitiator    | Bin
 tests/data/acpi/{ => x86}/q35/APIC.core-count       | Bin
 tests/data/acpi/{ => x86}/q35/APIC.core-count2      | Bin
 tests/data/acpi/{ => x86}/q35/APIC.cphp             | Bin
 tests/data/acpi/{ => x86}/q35/APIC.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/q35/APIC.thread-count     | Bin
 tests/data/acpi/{ => x86}/q35/APIC.thread-count2    | Bin
 tests/data/acpi/{ => x86}/q35/APIC.type4-count      | Bin
 tests/data/acpi/{ => x86}/q35/APIC.xapic            | Bin
 tests/data/acpi/{ => x86}/q35/CEDT.cxl              | Bin
 tests/data/acpi/{ => x86}/q35/DMAR.dmar             | Bin
 tests/data/acpi/{ => x86}/q35/DSDT                  | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.acpierst         | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.acpihmat         | Bin
 .../acpi/{ => x86}/q35/DSDT.acpihmat-noinitiator    | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.applesmc         | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.bridge           | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.core-count       | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.core-count2      | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.cphp             | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.cxl              | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.ipmibt           | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.ipmismbus        | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.ivrs             | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.memhp            | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.mmio64           | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.multi-bridge     | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.noacpihp         | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.nohpet           | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.numamem          | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.pvpanic-isa      | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.thread-count     | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.thread-count2    | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm12        | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm2         | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.type4-count      | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.viot             | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.xapic            | Bin
 tests/data/acpi/{ => x86}/q35/ERST.acpierst         | Bin
 tests/data/acpi/{ => x86}/q35/FACP                  | Bin
 tests/data/acpi/{ => x86}/q35/FACP.core-count       | Bin
 tests/data/acpi/{ => x86}/q35/FACP.core-count2      | Bin
 tests/data/acpi/{ => x86}/q35/FACP.nosmm            | Bin
 tests/data/acpi/{ => x86}/q35/FACP.slic             | Bin
 tests/data/acpi/{ => x86}/q35/FACP.thread-count     | Bin
 tests/data/acpi/{ => x86}/q35/FACP.thread-count2    | Bin
 tests/data/acpi/{ => x86}/q35/FACP.type4-count      | Bin
 tests/data/acpi/{ => x86}/q35/FACP.xapic            | Bin
 tests/data/acpi/{ => x86}/q35/FACS                  | Bin
 tests/data/acpi/{ => x86}/q35/HMAT.acpihmat         | Bin
 .../acpi/{ => x86}/q35/HMAT.acpihmat-noinitiator    | Bin
 tests/data/acpi/{ => x86}/q35/HPET                  | Bin
 tests/data/acpi/{ => x86}/q35/IVRS.ivrs             | Bin
 tests/data/acpi/{ => x86}/q35/MCFG                  | Bin
 tests/data/acpi/{ => x86}/q35/NFIT.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/q35/SLIC.slic             | Bin
 tests/data/acpi/{ => x86}/q35/SLIT.cphp             | Bin
 tests/data/acpi/{ => x86}/q35/SLIT.memhp            | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.acpihmat         | Bin
 .../acpi/{ => x86}/q35/SRAT.acpihmat-noinitiator    | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.cphp             | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.memhp            | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.mmio64           | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.numamem          | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.xapic            | Bin
 tests/data/acpi/{ => x86}/q35/SSDT.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/q35/TCPA.tis.tpm12        | Bin
 tests/data/acpi/{ => x86}/q35/TPM2.tis.tpm2         | Bin
 tests/data/acpi/{ => x86}/q35/VIOT.viot             | Bin
 tests/data/acpi/{ => x86}/q35/WAET                  | Bin
 117 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/data/acpi/{ => x86}/microvm/APIC (100%)
 rename tests/data/acpi/{ => x86}/microvm/APIC.ioapic2 (100%)
 rename tests/data/acpi/{ => x86}/microvm/APIC.pcie (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.ioapic2 (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.pcie (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.rtc (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.usb (100%)
 rename tests/data/acpi/{ => x86}/microvm/ERST.pcie (100%)
 rename tests/data/acpi/{ => x86}/microvm/FACP (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.acpierst (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.bridge (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.hpbridge (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.hpbrroot (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.ipmikcs (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.memhp (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.nohpet (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.numamem (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.roothp (100%)
 rename tests/data/acpi/{ => x86}/pc/ERST.acpierst (100%)
 rename tests/data/acpi/{ => x86}/pc/FACP (100%)
 rename tests/data/acpi/{ => x86}/pc/FACP.nosmm (100%)
 rename tests/data/acpi/{ => x86}/pc/FACS (100%)
 rename tests/data/acpi/{ => x86}/pc/HMAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/HPET (100%)
 rename tests/data/acpi/{ => x86}/pc/NFIT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/SLIT.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/SLIT.memhp (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.memhp (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.numamem (100%)
 rename tests/data/acpi/{ => x86}/pc/SSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/WAET (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.core-count (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.core-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.thread-count (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.thread-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.type4-count (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/CEDT.cxl (100%)
 rename tests/data/acpi/{ => x86}/q35/DMAR.dmar (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.acpierst (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.applesmc (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.bridge (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.core-count (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.core-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.cxl (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.ipmibt (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.ipmismbus (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.ivrs (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.memhp (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.mmio64 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.multi-bridge (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.noacpihp (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.nohpet (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.numamem (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.pvpanic-isa (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.thread-count (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.thread-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm12 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm2 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.type4-count (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.viot (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/ERST.acpierst (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.core-count (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.core-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.nosmm (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.slic (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.thread-count (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.thread-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.type4-count (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/FACS (100%)
 rename tests/data/acpi/{ => x86}/q35/HMAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/HMAT.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/HPET (100%)
 rename tests/data/acpi/{ => x86}/q35/IVRS.ivrs (100%)
 rename tests/data/acpi/{ => x86}/q35/MCFG (100%)
 rename tests/data/acpi/{ => x86}/q35/NFIT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/SLIC.slic (100%)
 rename tests/data/acpi/{ => x86}/q35/SLIT.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/SLIT.memhp (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.memhp (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.mmio64 (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.numamem (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/SSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/TCPA.tis.tpm12 (100%)
 rename tests/data/acpi/{ => x86}/q35/TPM2.tis.tpm2 (100%)
 rename tests/data/acpi/{ => x86}/q35/VIOT.viot (100%)
 rename tests/data/acpi/{ => x86}/q35/WAET (100%)

diff --git a/tests/data/acpi/microvm/APIC b/tests/data/acpi/x86/microvm/APIC
similarity index 100%
rename from tests/data/acpi/microvm/APIC
rename to tests/data/acpi/x86/microvm/APIC
diff --git a/tests/data/acpi/microvm/APIC.ioapic2 b/tests/data/acpi/x86/microvm/APIC.ioapic2
similarity index 100%
rename from tests/data/acpi/microvm/APIC.ioapic2
rename to tests/data/acpi/x86/microvm/APIC.ioapic2
diff --git a/tests/data/acpi/microvm/APIC.pcie b/tests/data/acpi/x86/microvm/APIC.pcie
similarity index 100%
rename from tests/data/acpi/microvm/APIC.pcie
rename to tests/data/acpi/x86/microvm/APIC.pcie
diff --git a/tests/data/acpi/microvm/DSDT b/tests/data/acpi/x86/microvm/DSDT
similarity index 100%
rename from tests/data/acpi/microvm/DSDT
rename to tests/data/acpi/x86/microvm/DSDT
diff --git a/tests/data/acpi/microvm/DSDT.ioapic2 b/tests/data/acpi/x86/microvm/DSDT.ioapic2
similarity index 100%
rename from tests/data/acpi/microvm/DSDT.ioapic2
rename to tests/data/acpi/x86/microvm/DSDT.ioapic2
diff --git a/tests/data/acpi/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
similarity index 100%
rename from tests/data/acpi/microvm/DSDT.pcie
rename to tests/data/acpi/x86/microvm/DSDT.pcie
diff --git a/tests/data/acpi/microvm/DSDT.rtc b/tests/data/acpi/x86/microvm/DSDT.rtc
similarity index 100%
rename from tests/data/acpi/microvm/DSDT.rtc
rename to tests/data/acpi/x86/microvm/DSDT.rtc
diff --git a/tests/data/acpi/microvm/DSDT.usb b/tests/data/acpi/x86/microvm/DSDT.usb
similarity index 100%
rename from tests/data/acpi/microvm/DSDT.usb
rename to tests/data/acpi/x86/microvm/DSDT.usb
diff --git a/tests/data/acpi/microvm/ERST.pcie b/tests/data/acpi/x86/microvm/ERST.pcie
similarity index 100%
rename from tests/data/acpi/microvm/ERST.pcie
rename to tests/data/acpi/x86/microvm/ERST.pcie
diff --git a/tests/data/acpi/microvm/FACP b/tests/data/acpi/x86/microvm/FACP
similarity index 100%
rename from tests/data/acpi/microvm/FACP
rename to tests/data/acpi/x86/microvm/FACP
diff --git a/tests/data/acpi/pc/APIC b/tests/data/acpi/x86/pc/APIC
similarity index 100%
rename from tests/data/acpi/pc/APIC
rename to tests/data/acpi/x86/pc/APIC
diff --git a/tests/data/acpi/pc/APIC.acpihmat b/tests/data/acpi/x86/pc/APIC.acpihmat
similarity index 100%
rename from tests/data/acpi/pc/APIC.acpihmat
rename to tests/data/acpi/x86/pc/APIC.acpihmat
diff --git a/tests/data/acpi/pc/APIC.cphp b/tests/data/acpi/x86/pc/APIC.cphp
similarity index 100%
rename from tests/data/acpi/pc/APIC.cphp
rename to tests/data/acpi/x86/pc/APIC.cphp
diff --git a/tests/data/acpi/pc/APIC.dimmpxm b/tests/data/acpi/x86/pc/APIC.dimmpxm
similarity index 100%
rename from tests/data/acpi/pc/APIC.dimmpxm
rename to tests/data/acpi/x86/pc/APIC.dimmpxm
diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
similarity index 100%
rename from tests/data/acpi/pc/DSDT
rename to tests/data/acpi/x86/pc/DSDT
diff --git a/tests/data/acpi/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
similarity index 100%
rename from tests/data/acpi/pc/DSDT.acpierst
rename to tests/data/acpi/x86/pc/DSDT.acpierst
diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
similarity index 100%
rename from tests/data/acpi/pc/DSDT.acpihmat
rename to tests/data/acpi/x86/pc/DSDT.acpihmat
diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
similarity index 100%
rename from tests/data/acpi/pc/DSDT.bridge
rename to tests/data/acpi/x86/pc/DSDT.bridge
diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
similarity index 100%
rename from tests/data/acpi/pc/DSDT.cphp
rename to tests/data/acpi/x86/pc/DSDT.cphp
diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
similarity index 100%
rename from tests/data/acpi/pc/DSDT.dimmpxm
rename to tests/data/acpi/x86/pc/DSDT.dimmpxm
diff --git a/tests/data/acpi/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
similarity index 100%
rename from tests/data/acpi/pc/DSDT.hpbridge
rename to tests/data/acpi/x86/pc/DSDT.hpbridge
diff --git a/tests/data/acpi/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
similarity index 100%
rename from tests/data/acpi/pc/DSDT.hpbrroot
rename to tests/data/acpi/x86/pc/DSDT.hpbrroot
diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
similarity index 100%
rename from tests/data/acpi/pc/DSDT.ipmikcs
rename to tests/data/acpi/x86/pc/DSDT.ipmikcs
diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
similarity index 100%
rename from tests/data/acpi/pc/DSDT.memhp
rename to tests/data/acpi/x86/pc/DSDT.memhp
diff --git a/tests/data/acpi/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
similarity index 100%
rename from tests/data/acpi/pc/DSDT.nohpet
rename to tests/data/acpi/x86/pc/DSDT.nohpet
diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
similarity index 100%
rename from tests/data/acpi/pc/DSDT.numamem
rename to tests/data/acpi/x86/pc/DSDT.numamem
diff --git a/tests/data/acpi/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
similarity index 100%
rename from tests/data/acpi/pc/DSDT.roothp
rename to tests/data/acpi/x86/pc/DSDT.roothp
diff --git a/tests/data/acpi/pc/ERST.acpierst b/tests/data/acpi/x86/pc/ERST.acpierst
similarity index 100%
rename from tests/data/acpi/pc/ERST.acpierst
rename to tests/data/acpi/x86/pc/ERST.acpierst
diff --git a/tests/data/acpi/pc/FACP b/tests/data/acpi/x86/pc/FACP
similarity index 100%
rename from tests/data/acpi/pc/FACP
rename to tests/data/acpi/x86/pc/FACP
diff --git a/tests/data/acpi/pc/FACP.nosmm b/tests/data/acpi/x86/pc/FACP.nosmm
similarity index 100%
rename from tests/data/acpi/pc/FACP.nosmm
rename to tests/data/acpi/x86/pc/FACP.nosmm
diff --git a/tests/data/acpi/pc/FACS b/tests/data/acpi/x86/pc/FACS
similarity index 100%
rename from tests/data/acpi/pc/FACS
rename to tests/data/acpi/x86/pc/FACS
diff --git a/tests/data/acpi/pc/HMAT.acpihmat b/tests/data/acpi/x86/pc/HMAT.acpihmat
similarity index 100%
rename from tests/data/acpi/pc/HMAT.acpihmat
rename to tests/data/acpi/x86/pc/HMAT.acpihmat
diff --git a/tests/data/acpi/pc/HPET b/tests/data/acpi/x86/pc/HPET
similarity index 100%
rename from tests/data/acpi/pc/HPET
rename to tests/data/acpi/x86/pc/HPET
diff --git a/tests/data/acpi/pc/NFIT.dimmpxm b/tests/data/acpi/x86/pc/NFIT.dimmpxm
similarity index 100%
rename from tests/data/acpi/pc/NFIT.dimmpxm
rename to tests/data/acpi/x86/pc/NFIT.dimmpxm
diff --git a/tests/data/acpi/pc/SLIT.cphp b/tests/data/acpi/x86/pc/SLIT.cphp
similarity index 100%
rename from tests/data/acpi/pc/SLIT.cphp
rename to tests/data/acpi/x86/pc/SLIT.cphp
diff --git a/tests/data/acpi/pc/SLIT.memhp b/tests/data/acpi/x86/pc/SLIT.memhp
similarity index 100%
rename from tests/data/acpi/pc/SLIT.memhp
rename to tests/data/acpi/x86/pc/SLIT.memhp
diff --git a/tests/data/acpi/pc/SRAT.acpihmat b/tests/data/acpi/x86/pc/SRAT.acpihmat
similarity index 100%
rename from tests/data/acpi/pc/SRAT.acpihmat
rename to tests/data/acpi/x86/pc/SRAT.acpihmat
diff --git a/tests/data/acpi/pc/SRAT.cphp b/tests/data/acpi/x86/pc/SRAT.cphp
similarity index 100%
rename from tests/data/acpi/pc/SRAT.cphp
rename to tests/data/acpi/x86/pc/SRAT.cphp
diff --git a/tests/data/acpi/pc/SRAT.dimmpxm b/tests/data/acpi/x86/pc/SRAT.dimmpxm
similarity index 100%
rename from tests/data/acpi/pc/SRAT.dimmpxm
rename to tests/data/acpi/x86/pc/SRAT.dimmpxm
diff --git a/tests/data/acpi/pc/SRAT.memhp b/tests/data/acpi/x86/pc/SRAT.memhp
similarity index 100%
rename from tests/data/acpi/pc/SRAT.memhp
rename to tests/data/acpi/x86/pc/SRAT.memhp
diff --git a/tests/data/acpi/pc/SRAT.numamem b/tests/data/acpi/x86/pc/SRAT.numamem
similarity index 100%
rename from tests/data/acpi/pc/SRAT.numamem
rename to tests/data/acpi/x86/pc/SRAT.numamem
diff --git a/tests/data/acpi/pc/SSDT.dimmpxm b/tests/data/acpi/x86/pc/SSDT.dimmpxm
similarity index 100%
rename from tests/data/acpi/pc/SSDT.dimmpxm
rename to tests/data/acpi/x86/pc/SSDT.dimmpxm
diff --git a/tests/data/acpi/pc/WAET b/tests/data/acpi/x86/pc/WAET
similarity index 100%
rename from tests/data/acpi/pc/WAET
rename to tests/data/acpi/x86/pc/WAET
diff --git a/tests/data/acpi/q35/APIC b/tests/data/acpi/x86/q35/APIC
similarity index 100%
rename from tests/data/acpi/q35/APIC
rename to tests/data/acpi/x86/q35/APIC
diff --git a/tests/data/acpi/q35/APIC.acpihmat b/tests/data/acpi/x86/q35/APIC.acpihmat
similarity index 100%
rename from tests/data/acpi/q35/APIC.acpihmat
rename to tests/data/acpi/x86/q35/APIC.acpihmat
diff --git a/tests/data/acpi/q35/APIC.acpihmat-noinitiator b/tests/data/acpi/x86/q35/APIC.acpihmat-noinitiator
similarity index 100%
rename from tests/data/acpi/q35/APIC.acpihmat-noinitiator
rename to tests/data/acpi/x86/q35/APIC.acpihmat-noinitiator
diff --git a/tests/data/acpi/q35/APIC.core-count b/tests/data/acpi/x86/q35/APIC.core-count
similarity index 100%
rename from tests/data/acpi/q35/APIC.core-count
rename to tests/data/acpi/x86/q35/APIC.core-count
diff --git a/tests/data/acpi/q35/APIC.core-count2 b/tests/data/acpi/x86/q35/APIC.core-count2
similarity index 100%
rename from tests/data/acpi/q35/APIC.core-count2
rename to tests/data/acpi/x86/q35/APIC.core-count2
diff --git a/tests/data/acpi/q35/APIC.cphp b/tests/data/acpi/x86/q35/APIC.cphp
similarity index 100%
rename from tests/data/acpi/q35/APIC.cphp
rename to tests/data/acpi/x86/q35/APIC.cphp
diff --git a/tests/data/acpi/q35/APIC.dimmpxm b/tests/data/acpi/x86/q35/APIC.dimmpxm
similarity index 100%
rename from tests/data/acpi/q35/APIC.dimmpxm
rename to tests/data/acpi/x86/q35/APIC.dimmpxm
diff --git a/tests/data/acpi/q35/APIC.thread-count b/tests/data/acpi/x86/q35/APIC.thread-count
similarity index 100%
rename from tests/data/acpi/q35/APIC.thread-count
rename to tests/data/acpi/x86/q35/APIC.thread-count
diff --git a/tests/data/acpi/q35/APIC.thread-count2 b/tests/data/acpi/x86/q35/APIC.thread-count2
similarity index 100%
rename from tests/data/acpi/q35/APIC.thread-count2
rename to tests/data/acpi/x86/q35/APIC.thread-count2
diff --git a/tests/data/acpi/q35/APIC.type4-count b/tests/data/acpi/x86/q35/APIC.type4-count
similarity index 100%
rename from tests/data/acpi/q35/APIC.type4-count
rename to tests/data/acpi/x86/q35/APIC.type4-count
diff --git a/tests/data/acpi/q35/APIC.xapic b/tests/data/acpi/x86/q35/APIC.xapic
similarity index 100%
rename from tests/data/acpi/q35/APIC.xapic
rename to tests/data/acpi/x86/q35/APIC.xapic
diff --git a/tests/data/acpi/q35/CEDT.cxl b/tests/data/acpi/x86/q35/CEDT.cxl
similarity index 100%
rename from tests/data/acpi/q35/CEDT.cxl
rename to tests/data/acpi/x86/q35/CEDT.cxl
diff --git a/tests/data/acpi/q35/DMAR.dmar b/tests/data/acpi/x86/q35/DMAR.dmar
similarity index 100%
rename from tests/data/acpi/q35/DMAR.dmar
rename to tests/data/acpi/x86/q35/DMAR.dmar
diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
similarity index 100%
rename from tests/data/acpi/q35/DSDT
rename to tests/data/acpi/x86/q35/DSDT
diff --git a/tests/data/acpi/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
similarity index 100%
rename from tests/data/acpi/q35/DSDT.acpierst
rename to tests/data/acpi/x86/q35/DSDT.acpierst
diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
similarity index 100%
rename from tests/data/acpi/q35/DSDT.acpihmat
rename to tests/data/acpi/x86/q35/DSDT.acpihmat
diff --git a/tests/data/acpi/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
similarity index 100%
rename from tests/data/acpi/q35/DSDT.acpihmat-noinitiator
rename to tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
diff --git a/tests/data/acpi/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
similarity index 100%
rename from tests/data/acpi/q35/DSDT.applesmc
rename to tests/data/acpi/x86/q35/DSDT.applesmc
diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
similarity index 100%
rename from tests/data/acpi/q35/DSDT.bridge
rename to tests/data/acpi/x86/q35/DSDT.bridge
diff --git a/tests/data/acpi/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
similarity index 100%
rename from tests/data/acpi/q35/DSDT.core-count
rename to tests/data/acpi/x86/q35/DSDT.core-count
diff --git a/tests/data/acpi/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
similarity index 100%
rename from tests/data/acpi/q35/DSDT.core-count2
rename to tests/data/acpi/x86/q35/DSDT.core-count2
diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
similarity index 100%
rename from tests/data/acpi/q35/DSDT.cphp
rename to tests/data/acpi/x86/q35/DSDT.cphp
diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
similarity index 100%
rename from tests/data/acpi/q35/DSDT.cxl
rename to tests/data/acpi/x86/q35/DSDT.cxl
diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
similarity index 100%
rename from tests/data/acpi/q35/DSDT.dimmpxm
rename to tests/data/acpi/x86/q35/DSDT.dimmpxm
diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
similarity index 100%
rename from tests/data/acpi/q35/DSDT.ipmibt
rename to tests/data/acpi/x86/q35/DSDT.ipmibt
diff --git a/tests/data/acpi/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
similarity index 100%
rename from tests/data/acpi/q35/DSDT.ipmismbus
rename to tests/data/acpi/x86/q35/DSDT.ipmismbus
diff --git a/tests/data/acpi/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
similarity index 100%
rename from tests/data/acpi/q35/DSDT.ivrs
rename to tests/data/acpi/x86/q35/DSDT.ivrs
diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
similarity index 100%
rename from tests/data/acpi/q35/DSDT.memhp
rename to tests/data/acpi/x86/q35/DSDT.memhp
diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
similarity index 100%
rename from tests/data/acpi/q35/DSDT.mmio64
rename to tests/data/acpi/x86/q35/DSDT.mmio64
diff --git a/tests/data/acpi/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
similarity index 100%
rename from tests/data/acpi/q35/DSDT.multi-bridge
rename to tests/data/acpi/x86/q35/DSDT.multi-bridge
diff --git a/tests/data/acpi/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
similarity index 100%
rename from tests/data/acpi/q35/DSDT.noacpihp
rename to tests/data/acpi/x86/q35/DSDT.noacpihp
diff --git a/tests/data/acpi/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
similarity index 100%
rename from tests/data/acpi/q35/DSDT.nohpet
rename to tests/data/acpi/x86/q35/DSDT.nohpet
diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
similarity index 100%
rename from tests/data/acpi/q35/DSDT.numamem
rename to tests/data/acpi/x86/q35/DSDT.numamem
diff --git a/tests/data/acpi/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
similarity index 100%
rename from tests/data/acpi/q35/DSDT.pvpanic-isa
rename to tests/data/acpi/x86/q35/DSDT.pvpanic-isa
diff --git a/tests/data/acpi/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
similarity index 100%
rename from tests/data/acpi/q35/DSDT.thread-count
rename to tests/data/acpi/x86/q35/DSDT.thread-count
diff --git a/tests/data/acpi/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
similarity index 100%
rename from tests/data/acpi/q35/DSDT.thread-count2
rename to tests/data/acpi/x86/q35/DSDT.thread-count2
diff --git a/tests/data/acpi/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
similarity index 100%
rename from tests/data/acpi/q35/DSDT.tis.tpm12
rename to tests/data/acpi/x86/q35/DSDT.tis.tpm12
diff --git a/tests/data/acpi/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
similarity index 100%
rename from tests/data/acpi/q35/DSDT.tis.tpm2
rename to tests/data/acpi/x86/q35/DSDT.tis.tpm2
diff --git a/tests/data/acpi/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
similarity index 100%
rename from tests/data/acpi/q35/DSDT.type4-count
rename to tests/data/acpi/x86/q35/DSDT.type4-count
diff --git a/tests/data/acpi/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
similarity index 100%
rename from tests/data/acpi/q35/DSDT.viot
rename to tests/data/acpi/x86/q35/DSDT.viot
diff --git a/tests/data/acpi/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
similarity index 100%
rename from tests/data/acpi/q35/DSDT.xapic
rename to tests/data/acpi/x86/q35/DSDT.xapic
diff --git a/tests/data/acpi/q35/ERST.acpierst b/tests/data/acpi/x86/q35/ERST.acpierst
similarity index 100%
rename from tests/data/acpi/q35/ERST.acpierst
rename to tests/data/acpi/x86/q35/ERST.acpierst
diff --git a/tests/data/acpi/q35/FACP b/tests/data/acpi/x86/q35/FACP
similarity index 100%
rename from tests/data/acpi/q35/FACP
rename to tests/data/acpi/x86/q35/FACP
diff --git a/tests/data/acpi/q35/FACP.core-count b/tests/data/acpi/x86/q35/FACP.core-count
similarity index 100%
rename from tests/data/acpi/q35/FACP.core-count
rename to tests/data/acpi/x86/q35/FACP.core-count
diff --git a/tests/data/acpi/q35/FACP.core-count2 b/tests/data/acpi/x86/q35/FACP.core-count2
similarity index 100%
rename from tests/data/acpi/q35/FACP.core-count2
rename to tests/data/acpi/x86/q35/FACP.core-count2
diff --git a/tests/data/acpi/q35/FACP.nosmm b/tests/data/acpi/x86/q35/FACP.nosmm
similarity index 100%
rename from tests/data/acpi/q35/FACP.nosmm
rename to tests/data/acpi/x86/q35/FACP.nosmm
diff --git a/tests/data/acpi/q35/FACP.slic b/tests/data/acpi/x86/q35/FACP.slic
similarity index 100%
rename from tests/data/acpi/q35/FACP.slic
rename to tests/data/acpi/x86/q35/FACP.slic
diff --git a/tests/data/acpi/q35/FACP.thread-count b/tests/data/acpi/x86/q35/FACP.thread-count
similarity index 100%
rename from tests/data/acpi/q35/FACP.thread-count
rename to tests/data/acpi/x86/q35/FACP.thread-count
diff --git a/tests/data/acpi/q35/FACP.thread-count2 b/tests/data/acpi/x86/q35/FACP.thread-count2
similarity index 100%
rename from tests/data/acpi/q35/FACP.thread-count2
rename to tests/data/acpi/x86/q35/FACP.thread-count2
diff --git a/tests/data/acpi/q35/FACP.type4-count b/tests/data/acpi/x86/q35/FACP.type4-count
similarity index 100%
rename from tests/data/acpi/q35/FACP.type4-count
rename to tests/data/acpi/x86/q35/FACP.type4-count
diff --git a/tests/data/acpi/q35/FACP.xapic b/tests/data/acpi/x86/q35/FACP.xapic
similarity index 100%
rename from tests/data/acpi/q35/FACP.xapic
rename to tests/data/acpi/x86/q35/FACP.xapic
diff --git a/tests/data/acpi/q35/FACS b/tests/data/acpi/x86/q35/FACS
similarity index 100%
rename from tests/data/acpi/q35/FACS
rename to tests/data/acpi/x86/q35/FACS
diff --git a/tests/data/acpi/q35/HMAT.acpihmat b/tests/data/acpi/x86/q35/HMAT.acpihmat
similarity index 100%
rename from tests/data/acpi/q35/HMAT.acpihmat
rename to tests/data/acpi/x86/q35/HMAT.acpihmat
diff --git a/tests/data/acpi/q35/HMAT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/HMAT.acpihmat-noinitiator
similarity index 100%
rename from tests/data/acpi/q35/HMAT.acpihmat-noinitiator
rename to tests/data/acpi/x86/q35/HMAT.acpihmat-noinitiator
diff --git a/tests/data/acpi/q35/HPET b/tests/data/acpi/x86/q35/HPET
similarity index 100%
rename from tests/data/acpi/q35/HPET
rename to tests/data/acpi/x86/q35/HPET
diff --git a/tests/data/acpi/q35/IVRS.ivrs b/tests/data/acpi/x86/q35/IVRS.ivrs
similarity index 100%
rename from tests/data/acpi/q35/IVRS.ivrs
rename to tests/data/acpi/x86/q35/IVRS.ivrs
diff --git a/tests/data/acpi/q35/MCFG b/tests/data/acpi/x86/q35/MCFG
similarity index 100%
rename from tests/data/acpi/q35/MCFG
rename to tests/data/acpi/x86/q35/MCFG
diff --git a/tests/data/acpi/q35/NFIT.dimmpxm b/tests/data/acpi/x86/q35/NFIT.dimmpxm
similarity index 100%
rename from tests/data/acpi/q35/NFIT.dimmpxm
rename to tests/data/acpi/x86/q35/NFIT.dimmpxm
diff --git a/tests/data/acpi/q35/SLIC.slic b/tests/data/acpi/x86/q35/SLIC.slic
similarity index 100%
rename from tests/data/acpi/q35/SLIC.slic
rename to tests/data/acpi/x86/q35/SLIC.slic
diff --git a/tests/data/acpi/q35/SLIT.cphp b/tests/data/acpi/x86/q35/SLIT.cphp
similarity index 100%
rename from tests/data/acpi/q35/SLIT.cphp
rename to tests/data/acpi/x86/q35/SLIT.cphp
diff --git a/tests/data/acpi/q35/SLIT.memhp b/tests/data/acpi/x86/q35/SLIT.memhp
similarity index 100%
rename from tests/data/acpi/q35/SLIT.memhp
rename to tests/data/acpi/x86/q35/SLIT.memhp
diff --git a/tests/data/acpi/q35/SRAT.acpihmat b/tests/data/acpi/x86/q35/SRAT.acpihmat
similarity index 100%
rename from tests/data/acpi/q35/SRAT.acpihmat
rename to tests/data/acpi/x86/q35/SRAT.acpihmat
diff --git a/tests/data/acpi/q35/SRAT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/SRAT.acpihmat-noinitiator
similarity index 100%
rename from tests/data/acpi/q35/SRAT.acpihmat-noinitiator
rename to tests/data/acpi/x86/q35/SRAT.acpihmat-noinitiator
diff --git a/tests/data/acpi/q35/SRAT.cphp b/tests/data/acpi/x86/q35/SRAT.cphp
similarity index 100%
rename from tests/data/acpi/q35/SRAT.cphp
rename to tests/data/acpi/x86/q35/SRAT.cphp
diff --git a/tests/data/acpi/q35/SRAT.dimmpxm b/tests/data/acpi/x86/q35/SRAT.dimmpxm
similarity index 100%
rename from tests/data/acpi/q35/SRAT.dimmpxm
rename to tests/data/acpi/x86/q35/SRAT.dimmpxm
diff --git a/tests/data/acpi/q35/SRAT.memhp b/tests/data/acpi/x86/q35/SRAT.memhp
similarity index 100%
rename from tests/data/acpi/q35/SRAT.memhp
rename to tests/data/acpi/x86/q35/SRAT.memhp
diff --git a/tests/data/acpi/q35/SRAT.mmio64 b/tests/data/acpi/x86/q35/SRAT.mmio64
similarity index 100%
rename from tests/data/acpi/q35/SRAT.mmio64
rename to tests/data/acpi/x86/q35/SRAT.mmio64
diff --git a/tests/data/acpi/q35/SRAT.numamem b/tests/data/acpi/x86/q35/SRAT.numamem
similarity index 100%
rename from tests/data/acpi/q35/SRAT.numamem
rename to tests/data/acpi/x86/q35/SRAT.numamem
diff --git a/tests/data/acpi/q35/SRAT.xapic b/tests/data/acpi/x86/q35/SRAT.xapic
similarity index 100%
rename from tests/data/acpi/q35/SRAT.xapic
rename to tests/data/acpi/x86/q35/SRAT.xapic
diff --git a/tests/data/acpi/q35/SSDT.dimmpxm b/tests/data/acpi/x86/q35/SSDT.dimmpxm
similarity index 100%
rename from tests/data/acpi/q35/SSDT.dimmpxm
rename to tests/data/acpi/x86/q35/SSDT.dimmpxm
diff --git a/tests/data/acpi/q35/TCPA.tis.tpm12 b/tests/data/acpi/x86/q35/TCPA.tis.tpm12
similarity index 100%
rename from tests/data/acpi/q35/TCPA.tis.tpm12
rename to tests/data/acpi/x86/q35/TCPA.tis.tpm12
diff --git a/tests/data/acpi/q35/TPM2.tis.tpm2 b/tests/data/acpi/x86/q35/TPM2.tis.tpm2
similarity index 100%
rename from tests/data/acpi/q35/TPM2.tis.tpm2
rename to tests/data/acpi/x86/q35/TPM2.tis.tpm2
diff --git a/tests/data/acpi/q35/VIOT.viot b/tests/data/acpi/x86/q35/VIOT.viot
similarity index 100%
rename from tests/data/acpi/q35/VIOT.viot
rename to tests/data/acpi/x86/q35/VIOT.viot
diff --git a/tests/data/acpi/q35/WAET b/tests/data/acpi/x86/q35/WAET
similarity index 100%
rename from tests/data/acpi/q35/WAET
rename to tests/data/acpi/x86/q35/WAET
-- 
MST


