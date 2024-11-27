Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5638ED6ACD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 14:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIY5-0003fF-MN; Wed, 27 Nov 2024 08:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIY0-0003eO-5v
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIXy-0007hY-K9
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EHliCKGIV0A4mTHvD8Vp0gNJsTqr7mAyIUNPjljDA4U=;
 b=LLHahnzd7fH18scFRPH//YvQhfn/9Ayf93ng4EMgQeQjqk/zNL3T0r1cBy25WTlUi3rq6a
 BBASQGZLGgEkGRqb2Ieda/3b5T6n97HUF+rx8qxcnsXNAgqdGz40bHhdQTrGjnlgJsZg2D
 0MJ2tjazbpJ9PfO3V3FIIDxqJ3yVk/c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-UpfmxzluPEu5ipnY1TgijQ-1; Wed, 27 Nov 2024 08:57:36 -0500
X-MC-Unique: UpfmxzluPEu5ipnY1TgijQ-1
X-Mimecast-MFC-AGG-ID: UpfmxzluPEu5ipnY1TgijQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38240d9ed31so4052271f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715855; x=1733320655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHliCKGIV0A4mTHvD8Vp0gNJsTqr7mAyIUNPjljDA4U=;
 b=tItsSTCHJSfZaFNJ4hDClaUK1TIwNrrJpNlBntH59zAcKJLcsFthrNAs4iTn1gMQz9
 n5y5ZmJVf4RPFsMXCXwsI2SAUzGtXf+CZ7kGVOYcXuZhwvVksad0o1b0cQRuFphWRHlR
 p3+hPvG31DktRUL53wn9mSUZJLS+npjA6KcM++HYK7vjyA9AE4Uaqu77dx9l/aHqXchI
 vLlis9ry92bkn+4XoitrG7Yx1iYYz1PdliGXnGCfsDjjf27bBQqqX7snCX1l5QuMGWiV
 QioCxVHoTKNX5f9a/WM5+0ggtoeK/8Usji3N4TL0nRAg3yC+3HoZJErRRj4ALtEH6H5V
 TOew==
X-Gm-Message-State: AOJu0Yy0yVFpl1aeLvKgnxY2QBZQAFq+zcVwCm/Sa8ZvhIR2JgmuXPhE
 lc0X4VuuNiNQTkS/VOsESDwy7XiJFHfbLt5O5P0AsejqDytSKRU5dMRs5IK9ma/fAzOy3t7C2zm
 56GdcmxVqd+oAoH0KynpAoe2xu/uyiBNmORiYfisIqQTETf6ZQSkH3TxDB6Hq1n8hlDr3duzVYF
 Mg28tqcEudhrV9vOeVFm8IH3V9mplPRtYR
X-Gm-Gg: ASbGncuuz65U6BPqYaL9mRADCgbW7D3nBq/xW9TVczHtSZDux2RD8S+/Snuzq8wL4YK
 B/o8EyQgd1fx0t7f9Q2SSsp2J1jQTnCpAwxpOlr6Ldu8egjj9fbItj7qh6oIhHO1qp4lPXSxBlN
 FcKY2iqSrKOLW35VRwewV7T0aiKAOdL2lpZmZHGc76tshuf36rmgMrQzBGJSGLMpGuUx4TNKfxR
 nuXpoN72EBiUPso7/DYJYNFlLl8eEbedduEVnMpaHo5
X-Received: by 2002:a5d:5f52:0:b0:382:4e57:48e7 with SMTP id
 ffacd0b85a97d-385c6eb58eemr2268052f8f.10.1732715854978; 
 Wed, 27 Nov 2024 05:57:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqwMJrrUGS/D6SdJy43XgOsUdKIbwq69vAoCNe8GS+KbbEELU0Zba47aNtqI2v7RsrQrodrg==
X-Received: by 2002:a5d:5f52:0:b0:382:4e57:48e7 with SMTP id
 ffacd0b85a97d-385c6eb58eemr2268031f8f.10.1732715854565; 
 Wed, 27 Nov 2024 05:57:34 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafe207sm16447042f8f.36.2024.11.27.05.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:57:33 -0800 (PST)
Date: Wed, 27 Nov 2024 08:57:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 02/13] qtest: allow ACPI DSDT Table changes
Message-ID: <ef5e7aeaa6e7a258798c1eff2f5c726504116609.1732715823.git.mst@redhat.com>
References: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

From: Salil Mehta <salil.mehta@huawei.com>

list changed files in tests/qtest/bios-tables-test-allowed-diff.h

Message-ID: <20241106100047.18901c9d@imammedo.users.ipa.redhat.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20241112170258.2996640-2-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 41 +++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..512d40665d 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,42 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/q35/DSDT",
+"tests/data/acpi/x86/q35/DSDT.acpierst",
+"tests/data/acpi/x86/q35/DSDT.acpihmat",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
+"tests/data/acpi/x86/q35/DSDT.applesmc",
+"tests/data/acpi/x86/q35/DSDT.bridge",
+"tests/data/acpi/x86/q35/DSDT.core-count",
+"tests/data/acpi/x86/q35/DSDT.core-count2",
+"tests/data/acpi/x86/q35/DSDT.cphp",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.dimmpxm",
+"tests/data/acpi/x86/q35/DSDT.ipmibt",
+"tests/data/acpi/x86/q35/DSDT.ipmismbus",
+"tests/data/acpi/x86/q35/DSDT.ivrs",
+"tests/data/acpi/x86/q35/DSDT.memhp",
+"tests/data/acpi/x86/q35/DSDT.mmio64",
+"tests/data/acpi/x86/q35/DSDT.multi-bridge",
+"tests/data/acpi/x86/q35/DSDT.noacpihp",
+"tests/data/acpi/x86/q35/DSDT.nohpet",
+"tests/data/acpi/x86/q35/DSDT.numamem",
+"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
+"tests/data/acpi/x86/q35/DSDT.thread-count",
+"tests/data/acpi/x86/q35/DSDT.thread-count2",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
+"tests/data/acpi/x86/q35/DSDT.type4-count",
+"tests/data/acpi/x86/q35/DSDT.viot",
+"tests/data/acpi/x86/q35/DSDT.xapic",
-- 
MST


