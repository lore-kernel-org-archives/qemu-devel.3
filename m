Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6FAD1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84KM-0002Jw-S7; Mon, 04 Nov 2024 16:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84KK-000255-Pp
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84KJ-0005Y2-6W
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6x+Legev3Cp2GqMVGf/goAaVdwIyT9f6UX5WvCHt0Bs=;
 b=gFTjbQVenfc+MCGxsnQBlK1LzIhcfKEZPfMVgorX3UvShAPFd3EyS5Aurp0pxMvJuUlQJD
 FZzVMT6qRYWJ/uLeN1NAaXrAL2Ki34FHZjwUsVZM1Bnp4/AZps2HUgzxdMh4SgpCP0z9yx
 Aas9Q9vYviyuQybhabnDcVfNeGff9RM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-KSDLAMRPMOG9zs0rmt4jEQ-1; Mon, 04 Nov 2024 16:09:29 -0500
X-MC-Unique: KSDLAMRPMOG9zs0rmt4jEQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431604a3b47so29806865e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754567; x=1731359367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6x+Legev3Cp2GqMVGf/goAaVdwIyT9f6UX5WvCHt0Bs=;
 b=sWAiO6xwXHHwrXWjA3fuzKaS+BoGfWwAs8tAfh1pqM+ta53GsPnvEYIPaNSjD7c1va
 4NCPkGnu0MiwJGaonLkY7XMp27aqMKLHV7rDZ3RNwivIcr52kxf6xNVzxlf9bGzGEJyG
 PXqzj96pZklT0bvz4BI6J370kk6Hr32vEJ7EbJKF72ZOvWEllVSwXP9ND8evcGO2Dmy+
 M+n3NxvTHmdCWqaLyrwz9jYP74kZcrbSh61kqpEobZQNh4Bd3KQ9/4zGN9KiNmw7pecN
 aXkVsGgMJMvpfrVJfBMiG/2Yk0pipTcI47xyrrnrDuiLdZvR7B7wwH/PVMHkRth0vbuN
 XRIg==
X-Gm-Message-State: AOJu0YzBUJ9IYLVbPJyLPy2O8UtJz6ry+8f0A35l6eZ6q7nzJ+PMjZ1A
 1nfwQ1ze2FtdxQ+0vAo+yfJP8dXlO2KunaQZva9rosHrf8eSZECjqbE4FmFSk+WpBheeWhS3Vl5
 yxxX2flZAjImMRQoodWlrE/qyZyJqNv9LeX3bcqQRSmZXnDbvAunZgXRQmZ71Is1bgIf9ACa7io
 e1ICxPqtIDrE5K9jMNVLRsQXc3ti88ig==
X-Received: by 2002:adf:cc8f:0:b0:37d:52b5:451e with SMTP id
 ffacd0b85a97d-3806118aa34mr24572871f8f.33.1730754566768; 
 Mon, 04 Nov 2024 13:09:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb/huLCOED1Mr63dAZfR2IURCjoh90EA7yGtOd0mhUxxiWmrHjOkmtwur/UtwThtJJgkiBHw==
X-Received: by 2002:adf:cc8f:0:b0:37d:52b5:451e with SMTP id
 ffacd0b85a97d-3806118aa34mr24572851f8f.33.1730754566334; 
 Mon, 04 Nov 2024 13:09:26 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e7c51sm163221465e9.25.2024.11.04.13.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:09:25 -0800 (PST)
Date: Mon, 4 Nov 2024 16:09:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 59/65] qtest: allow ACPI DSDT Table changes
Message-ID: <e98411c2cbbac24ff49992a09226a2662726a031.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Salil Mehta <salil.mehta@huawei.com>

list changed files in tests/qtest/bios-tables-test-allowed-diff.h

Reported-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Message-Id: <20241103102419.202225-3-salil.mehta@huawei.com>
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


