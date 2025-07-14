Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA37C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMH-000227-GB; Mon, 14 Jul 2025 19:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIy-0004ow-D8
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIv-0005wm-0f
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8rbTdW4vVYGZlsb7/OLzoGiSk0uauCtBaQnEm6Xd5k=;
 b=Rf5fddYBk5w4CCtKFoswAwEJNyToppcEVkRk0dKmW/rYoNs53FVU2qzxfELmTDlaF1qj7y
 57AqlFxkpEMr7ope+xakBIw2uCurIQQDti8APCs4sJ9kkf2wt0Zj8XghUBIz4ZiDIDMm+/
 nu3epWYGBwgy3DnZU04GcSJPN4UFHM8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-EfkY5_irPYazVrO36GFRsA-1; Mon, 14 Jul 2025 19:09:45 -0400
X-MC-Unique: EfkY5_irPYazVrO36GFRsA-1
X-Mimecast-MFC-AGG-ID: EfkY5_irPYazVrO36GFRsA_1752534584
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f858bc5eso3632449f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534584; x=1753139384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8rbTdW4vVYGZlsb7/OLzoGiSk0uauCtBaQnEm6Xd5k=;
 b=CzGCIiylQataetXGFX8RyYstQTw3EjJaKrVtvSyQkWylBHaKCCUsHRdsV8cBb841p5
 NTM02eSUljdK/HywbCd6tmx/z8+VV++yQ2/W36D2P/pmTVph0MWyEry8uVxINxZX60nJ
 M6SuoHN7X+I6j1bSWlLnLgMe24w95Zy+AkaSOUn7t2XiKYCI8PukZRrsKg5ARw47cg7a
 mbFddxSbG8fY+CF4oUyqHeyB4w7npbJHk4W1AK2odN1SXvSyaw+UcJ/EeJtVlJTmClPi
 Hit57nGEac57mx1P2HIlaENa/fIY4HSkYnOJdpAf7HqWsK7wAquyM4ynEB3uMOMg2GSK
 P87g==
X-Gm-Message-State: AOJu0YwudFEBRmzbsepIH1VC9Sz+rHQfYLgFEMeiokZrOILVHq7tMbl+
 LTJZoT5P0CIHysbxrIxC/aJYagH7C/Vm5liEBa09gBqmQiOgELgb6oLmvgGZEidHAzeNhpy967W
 bIg7PopdkMNXKs2DdenT6TEfPUeJHh7/kX+Xy2viy+dPnYWBKoE7lgyIrDnBVjNsTEQGvc+81So
 DhZWdFHXygy3NFxI4vDR536ZvvMTo61dLqlg==
X-Gm-Gg: ASbGncvlsREQKEP9wRQb4C+egf5fpnYy55BYVxWGlvzb/f/MAWo9E6dIQtLcKZeXbrB
 UmXe5ZQNvLkVSHMBojfPCGUBoRv6sZV8n3/vUq0y/H5yXjRbK1gHNB+jjt+mEvuSIAbB60aiOyb
 IuDjOyw6uZAWLpCw0nvBULL/mldeXL+qjzeSO9FJ1MwPb7APuMYuHhkskVS4rZwFOi7D56gYhkK
 Y0e6Dh8D8/VjfK0ZJKQ3u9YeEoLic5uzstAkDBZbA14xbyGW+IgdtkOnvxQcNXvEQT+nmgMQ+ao
 T+/b0JcmRm1OzBHV9U2CxxJdZa7I/Snc
X-Received: by 2002:a05:6000:40ca:b0:3a4:f038:af76 with SMTP id
 ffacd0b85a97d-3b5f2e45b2emr11328389f8f.53.1752534584126; 
 Mon, 14 Jul 2025 16:09:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz5DS0AKNLyPF2+V76FGDsY21ZHRCkuivsc3TkfhJXNqmuLXmDPjCYKG5eCWh8vJ44hoxwSw==
X-Received: by 2002:a05:6000:40ca:b0:3a4:f038:af76 with SMTP id
 ffacd0b85a97d-3b5f2e45b2emr11328371f8f.53.1752534583674; 
 Mon, 14 Jul 2025 16:09:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14ce6sm13747213f8f.68.2025.07.14.16.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:42 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 79/97] tests/qtest/bios-tables-test: Prepare for addition of
 acpi pci hp tests
Message-ID: <4c73cbc859fe6db82be35fcc1480cbf5dc779dc2.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Soon we will introduce new tests related to ACPI PCI hotplug and
acpi-index that will use a new reference blob:

tests/data/acpi/aarch64/virt/DSDT.acpipcihp
tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-34-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h      | 2 ++
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp      | 0
 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex | 0
 3 files changed, 2 insertions(+)
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.acpipcihp
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..02f4f0b29f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
+"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


