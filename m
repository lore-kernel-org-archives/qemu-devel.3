Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92054C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEC-0005mb-BY; Tue, 02 Jul 2024 10:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDY-000591-LT
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDW-0000PP-Ls
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwYyD/KUkbkxSb1TRAT8zXkqiqU7/n4SuhkILToxS/w=;
 b=inb+kMW00R0INDllmf6N7KLCff+ba8m3EkYFQoZ+WxyS++4Fvs3nZi0OP0cWhnQsV67NYp
 LnBFWHxWnhk1xsfCT9jYo+fy8UoePXQeCTI0PrAtKfrbNczHnr+6q9RSL/ZCJ/KO8IuOGc
 ItTzIucxIuePxHYNgHaVxKe48KzzIAs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-6im5TGkkMvSxz5-XfeEpoA-1; Tue, 02 Jul 2024 10:10:44 -0400
X-MC-Unique: 6im5TGkkMvSxz5-XfeEpoA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7246c24b00so303413266b.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929443; x=1720534243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwYyD/KUkbkxSb1TRAT8zXkqiqU7/n4SuhkILToxS/w=;
 b=M1VOM3WXAMEbi6kpT/CyPskxpWjgQyhMk38oz+C9ol/PjqZ5K+lfCFINZxtrVv0xNe
 ROmUIzMh4N0s6VFGWIwi3l4lyUZhYu/U6Ri9IW1xcH0/iHAxfxwxtkzSa1nRVxjkyZxy
 GSTUF1uBEWeaMK0vJSybufSxQhUbvNJ+R1KTabn6nyF0WLDTVqTNhLWos2oK2yS6+GAY
 pnu2OkgTUMeG6ATzYnNS3e4FTGMEAli98I1Gz7JJTcqDfE0VOq0b5dYlnP1ULB11dUBL
 Pb2sgH1nuqEWvTYrYGiPOcFF8QjMX4P6q3HvX3bjLUDCM651pdefBhbwU2rIeNdpydNB
 +yvw==
X-Gm-Message-State: AOJu0YwGF7HeELpIxcdWEWvnvyY2jFusjmifDdQ75yRX3ICsiICG4vpA
 XmLUj4uYD/s1IwZJbF0QOOi+EPehdNoilevc23cJPQYFDdo9lbD+hIMNAvsehZXgYJy6KfJ2Oss
 WF6+bWHGxGlodZvG9WVhmTSxyL8hWddZlBIzCM15RZu/fVuuTbc3YrlbW/rvnOuYHl9j2ETQVjX
 qufdLK+qSYkYbgZvONAZGAcS57LUt2jA==
X-Received: by 2002:a17:907:a0c9:b0:a6f:bc02:a008 with SMTP id
 a640c23a62f3a-a7514402354mr697862966b.4.1719929442942; 
 Tue, 02 Jul 2024 07:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1nClnaKFBznZ8WsfWDFFXO+jDuQWsI1e1WL3+Vzz9e7LBO5rK0uzrwQHqe016UjeGBPGU1g==
X-Received: by 2002:a17:907:a0c9:b0:a6f:bc02:a008 with SMTP id
 a640c23a62f3a-a7514402354mr697857166b.4.1719929441901; 
 Tue, 02 Jul 2024 07:10:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf60476sm426463566b.55.2024.07.02.07.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:41 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 71/91] tests/data/acpi/virt: Move ARM64 ACPI tables under
 aarch64/${machine} path
Message-ID: <8654b3eb9ea725160667be2ff093a0448f3073e3.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

Same machine name can be used by different architectures. Hence, create
aarch64 folder and move all aarch64 related AML files for virt machine
inside.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-11-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/{ => aarch64}/virt/APIC             | Bin
 .../data/acpi/{ => aarch64}/virt/APIC.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/APIC.topology    | Bin
 tests/data/acpi/{ => aarch64}/virt/DBG2             | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT             | Bin
 .../data/acpi/{ => aarch64}/virt/DSDT.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.pxb         | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.topology    | Bin
 tests/data/acpi/{ => aarch64}/virt/FACP             | Bin
 tests/data/acpi/{ => aarch64}/virt/GTDT             | Bin
 .../data/acpi/{ => aarch64}/virt/HMAT.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/IORT             | Bin
 tests/data/acpi/{ => aarch64}/virt/MCFG             | Bin
 tests/data/acpi/{ => aarch64}/virt/NFIT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/PPTT             | Bin
 .../data/acpi/{ => aarch64}/virt/PPTT.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/PPTT.topology    | Bin
 tests/data/acpi/{ => aarch64}/virt/SLIT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/SPCR             | Bin
 .../data/acpi/{ => aarch64}/virt/SRAT.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/SRAT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/SRAT.numamem     | Bin
 tests/data/acpi/{ => aarch64}/virt/SSDT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/VIOT             | Bin
 25 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/data/acpi/{ => aarch64}/virt/APIC (100%)
 rename tests/data/acpi/{ => aarch64}/virt/APIC.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/APIC.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DBG2 (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.pxb (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/FACP (100%)
 rename tests/data/acpi/{ => aarch64}/virt/GTDT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/HMAT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/IORT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/MCFG (100%)
 rename tests/data/acpi/{ => aarch64}/virt/NFIT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SLIT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SPCR (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.numamem (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SSDT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/VIOT (100%)

diff --git a/tests/data/acpi/virt/APIC b/tests/data/acpi/aarch64/virt/APIC
similarity index 100%
rename from tests/data/acpi/virt/APIC
rename to tests/data/acpi/aarch64/virt/APIC
diff --git a/tests/data/acpi/virt/APIC.acpihmatvirt b/tests/data/acpi/aarch64/virt/APIC.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/APIC.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/APIC.acpihmatvirt
diff --git a/tests/data/acpi/virt/APIC.topology b/tests/data/acpi/aarch64/virt/APIC.topology
similarity index 100%
rename from tests/data/acpi/virt/APIC.topology
rename to tests/data/acpi/aarch64/virt/APIC.topology
diff --git a/tests/data/acpi/virt/DBG2 b/tests/data/acpi/aarch64/virt/DBG2
similarity index 100%
rename from tests/data/acpi/virt/DBG2
rename to tests/data/acpi/aarch64/virt/DBG2
diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
similarity index 100%
rename from tests/data/acpi/virt/DSDT
rename to tests/data/acpi/aarch64/virt/DSDT
diff --git a/tests/data/acpi/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/DSDT.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
similarity index 100%
rename from tests/data/acpi/virt/DSDT.memhp
rename to tests/data/acpi/aarch64/virt/DSDT.memhp
diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
similarity index 100%
rename from tests/data/acpi/virt/DSDT.pxb
rename to tests/data/acpi/aarch64/virt/DSDT.pxb
diff --git a/tests/data/acpi/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
similarity index 100%
rename from tests/data/acpi/virt/DSDT.topology
rename to tests/data/acpi/aarch64/virt/DSDT.topology
diff --git a/tests/data/acpi/virt/FACP b/tests/data/acpi/aarch64/virt/FACP
similarity index 100%
rename from tests/data/acpi/virt/FACP
rename to tests/data/acpi/aarch64/virt/FACP
diff --git a/tests/data/acpi/virt/GTDT b/tests/data/acpi/aarch64/virt/GTDT
similarity index 100%
rename from tests/data/acpi/virt/GTDT
rename to tests/data/acpi/aarch64/virt/GTDT
diff --git a/tests/data/acpi/virt/HMAT.acpihmatvirt b/tests/data/acpi/aarch64/virt/HMAT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/HMAT.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/HMAT.acpihmatvirt
diff --git a/tests/data/acpi/virt/IORT b/tests/data/acpi/aarch64/virt/IORT
similarity index 100%
rename from tests/data/acpi/virt/IORT
rename to tests/data/acpi/aarch64/virt/IORT
diff --git a/tests/data/acpi/virt/MCFG b/tests/data/acpi/aarch64/virt/MCFG
similarity index 100%
rename from tests/data/acpi/virt/MCFG
rename to tests/data/acpi/aarch64/virt/MCFG
diff --git a/tests/data/acpi/virt/NFIT.memhp b/tests/data/acpi/aarch64/virt/NFIT.memhp
similarity index 100%
rename from tests/data/acpi/virt/NFIT.memhp
rename to tests/data/acpi/aarch64/virt/NFIT.memhp
diff --git a/tests/data/acpi/virt/PPTT b/tests/data/acpi/aarch64/virt/PPTT
similarity index 100%
rename from tests/data/acpi/virt/PPTT
rename to tests/data/acpi/aarch64/virt/PPTT
diff --git a/tests/data/acpi/virt/PPTT.acpihmatvirt b/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/PPTT.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt
diff --git a/tests/data/acpi/virt/PPTT.topology b/tests/data/acpi/aarch64/virt/PPTT.topology
similarity index 100%
rename from tests/data/acpi/virt/PPTT.topology
rename to tests/data/acpi/aarch64/virt/PPTT.topology
diff --git a/tests/data/acpi/virt/SLIT.memhp b/tests/data/acpi/aarch64/virt/SLIT.memhp
similarity index 100%
rename from tests/data/acpi/virt/SLIT.memhp
rename to tests/data/acpi/aarch64/virt/SLIT.memhp
diff --git a/tests/data/acpi/virt/SPCR b/tests/data/acpi/aarch64/virt/SPCR
similarity index 100%
rename from tests/data/acpi/virt/SPCR
rename to tests/data/acpi/aarch64/virt/SPCR
diff --git a/tests/data/acpi/virt/SRAT.acpihmatvirt b/tests/data/acpi/aarch64/virt/SRAT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/SRAT.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/SRAT.acpihmatvirt
diff --git a/tests/data/acpi/virt/SRAT.memhp b/tests/data/acpi/aarch64/virt/SRAT.memhp
similarity index 100%
rename from tests/data/acpi/virt/SRAT.memhp
rename to tests/data/acpi/aarch64/virt/SRAT.memhp
diff --git a/tests/data/acpi/virt/SRAT.numamem b/tests/data/acpi/aarch64/virt/SRAT.numamem
similarity index 100%
rename from tests/data/acpi/virt/SRAT.numamem
rename to tests/data/acpi/aarch64/virt/SRAT.numamem
diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/aarch64/virt/SSDT.memhp
similarity index 100%
rename from tests/data/acpi/virt/SSDT.memhp
rename to tests/data/acpi/aarch64/virt/SSDT.memhp
diff --git a/tests/data/acpi/virt/VIOT b/tests/data/acpi/aarch64/virt/VIOT
similarity index 100%
rename from tests/data/acpi/virt/VIOT
rename to tests/data/acpi/aarch64/virt/VIOT
-- 
MST


