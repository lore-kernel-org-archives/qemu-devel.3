Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1B8CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAX-0007rG-NV; Sun, 14 Jun 2026 15:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAW-0007gw-2Y
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAU-0001mY-Gc
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hS7nfdNFVWuvnYCHiHQhQ2fflaXhUNWx6WQgE1DrUx0=;
 b=Zvb3oVpVhqYM4D5fCjwd5c3t9gnLMvoixCKxS+3Ulr4RfpDUCQu7LB4SLSZ4ycMH1hz9LX
 8OGP6bY9NaUnX0pPBRFtVsMcCxwHCmBVc2+RyZQngOKsFuf6iNJCtsdmJ2I46EvXtvHwj5
 NiH1Qkmihyiil4nnuI4z1TEOIO2uZ1I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-XvzuJRBrMP2NnIM9rDT4xA-1; Sun, 14 Jun 2026 15:06:46 -0400
X-MC-Unique: XvzuJRBrMP2NnIM9rDT4xA-1
X-Mimecast-MFC-AGG-ID: XvzuJRBrMP2NnIM9rDT4xA_1781464006
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490abeb7298so29282355e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464005; x=1782068805; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hS7nfdNFVWuvnYCHiHQhQ2fflaXhUNWx6WQgE1DrUx0=;
 b=oS9rSmWVsuk+aC1PiIRpoWLtlbUc3Tlh6kDx2kuTqcrX4DT5wpr+3mE1ph7bTCVM97
 53srDj/PlVmZeXYpuXBySRXIhEm7ronkvXGhVwKywljWEq+3nW/Zfh+Fckig+Mn18gWL
 GBBekKA2Xd7ErdbZ5jd5LaiRazPLowqo6xl2hJglcVHcghZJkR+hMNMjZiPi1ScRvuLh
 TknWC6MnRan2/114oK+ogC8yI8s92jtaDj54076Arqjnje/c4S71h7E4F7dynDc9mm4C
 d33WLQjnsLlfXo3259jX33FLHaA28e+i1raoVRhuKgTBAvKM7Y7HR/tJTjHDMQB8lD73
 R+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464005; x=1782068805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hS7nfdNFVWuvnYCHiHQhQ2fflaXhUNWx6WQgE1DrUx0=;
 b=pJSlTbwNYsGc9PkWrcVSaFJKiWiNdBLHost4VQaanqhbTkCJKH1LxBhKKSY2IzvX99
 Ic2tzUDLDNIqyaaCJVYB2sOdC5FH1q3vxZzRj71ZiBRsze1HF7LXA7EJYWUi60b9PpbI
 NfrG0lLFE0R6TY2kzbHi8JT8rnuuSk2Wknp6sYwGCgwGWjcL2kHSNnG4VN3bXLukaVS6
 4T0wkf4XXuXw2eILRv5zGkEOMAvK8tROmKJVkim2uBfJTzO9nCrdR/CFS/CjN7xqYoeo
 JTilkG0+rC9nRbp+AoJMdCgtW/df3boSH7zujeG0VC+31HUJ0jc1eZumAigfRpa+aRWK
 zCGg==
X-Gm-Message-State: AOJu0YzkUBbyxhqgi/4JOI3X96PDXA4uLOvC1pbfz5L3vUL0ymQiD7B6
 E0OreYssuWePaTzh3O7sqUDJEIIfvXlrfoSrGVTjAYqsobZh94L7gEYqasn4gicJRy31ksyYUzN
 t3U7VLlwNh+F4QS6RTwy99S/guKN2qvyLnDz6Z2+jfK0oq6VXGEtnDTyUkMdh4Dm4aO+rWbmBkx
 DeF4j6QytXeEdoN1xx4MG8wjWOXhoRd5ss3w==
X-Gm-Gg: Acq92OGor/+EWET5sbhyiKaUWfyCBNFAwW/PlgR9ke8JvCn9LIwwLoAZNB/Us5/By9h
 YHSsvuQJBSSBBMKSgwAvL9WyPuHoZhiBZKIK7ooaGwSbR7vJ/aAOtIJM6s72kBPZhVSK3+IoxmL
 +GAy5aLqP/RV4Jkmils86IaiEdzgW4Ep8zQK8KZ+SFLVIiuykbDFRA7YZLWiaxDYhgBGf1ChlJz
 CV7jTevoqcWsa04zXhHwM7pEUR0wkZCVvHK05yC5u/V3liqGriGQVRKjcMhB7NfKlRvXnoRk8bi
 pka33Hi1xzcaMQKBC+iFui/6tQ6rhcS13yRU130k1xFaRcVDGsJEpg6H3z7VZeeKQ5ocx/7Imlv
 D6TebVRLN9MxPrcosQ1A6ZZ/oqXifgDY46R4c1x5T0Qk=
X-Received: by 2002:a05:600d:8446:20b0:492:1e36:4271 with SMTP id
 5b1f17b1804b1-49220149873mr65779865e9.37.1781464005442; 
 Sun, 14 Jun 2026 12:06:45 -0700 (PDT)
X-Received: by 2002:a05:600d:8446:20b0:492:1e36:4271 with SMTP id
 5b1f17b1804b1-49220149873mr65779565e9.37.1781464004794; 
 Sun, 14 Jun 2026 12:06:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220372ed0sm163955265e9.14.2026.06.14.12.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:44 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 024/106] tests/acpi: allow DSDT acpi table changes
Message-ID: <6d40788bfd8f8b7b39d489bda1a61fa0a2ae9951.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Acked-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260515150634.2637533-3-mark.caveayland@nutanix.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 47 +++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..cef44135bc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,48 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/q35/DSDT",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
+"tests/data/acpi/x86/q35/DSDT.bridge",
+"tests/data/acpi/x86/q35/DSDT.noacpihp",
+"tests/data/acpi/x86/q35/DSDT.multi-bridge",
+"tests/data/acpi/x86/q35/DSDT.ipmibt",
+"tests/data/acpi/x86/q35/DSDT.cphp",
+"tests/data/acpi/x86/q35/DSDT.numamem",
+"tests/data/acpi/x86/q35/DSDT.nohpet",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/DSDT.memhp",
+"tests/data/acpi/x86/q35/DSDT.dimmpxm",
+"tests/data/acpi/x86/q35/DSDT.acpihmat",
+"tests/data/acpi/x86/q35/DSDT.mmio64",
+"tests/data/acpi/x86/q35/DSDT.acpierst",
+"tests/data/acpi/x86/q35/DSDT.applesmc",
+"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
+"tests/data/acpi/x86/q35/DSDT.ivrs",
+"tests/data/acpi/x86/q35/DSDT.type4-count",
+"tests/data/acpi/x86/q35/DSDT.core-count",
+"tests/data/acpi/x86/q35/DSDT.core-count2",
+"tests/data/acpi/x86/q35/DSDT.thread-count",
+"tests/data/acpi/x86/q35/DSDT.thread-count2",
+"tests/data/acpi/x86/q35/DSDT.viot",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.ipmismbus",
+"tests/data/acpi/x86/q35/DSDT.xapic",
+"tests/data/acpi/x86/microvm/DSDT",
+"tests/data/acpi/x86/microvm/DSDT.usb",
+"tests/data/acpi/x86/microvm/DSDT.rtc",
+"tests/data/acpi/x86/microvm/DSDT.ioapic2",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
MST


