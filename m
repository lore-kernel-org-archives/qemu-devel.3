Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345F9D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84ID-0007iT-8o; Mon, 04 Nov 2024 16:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84IA-0007O6-V0
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84I9-0005NY-DB
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1MI5dfaWHJA3BO6melGD3KT8KGOimCWraUvc5kNsY4=;
 b=SS9bXXHUm/4YhM7W7ztiYHncGSyf4XNinuMHs2NrwyLV237H1VDFNuhYLWMQf0fmJM45x0
 GTKFDZOJc39BcdIgzF7195uS/VaDNdCW82hA9r8XcmtZvR+3kxXpWBHCavW+f+zoZf1MxK
 JXywOQaPpZeW7vXomNk3g2RhwwPtb24=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-rf57GuzCN72w1tSdMy5ffQ-1; Mon, 04 Nov 2024 16:07:15 -0500
X-MC-Unique: rf57GuzCN72w1tSdMy5ffQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d5a3afa84so2327306f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754434; x=1731359234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1MI5dfaWHJA3BO6melGD3KT8KGOimCWraUvc5kNsY4=;
 b=YgCeYRwwit5SZalimsOy6nSewv3OsC+AQu6nG9tq4crPMIb/OlaBDZpAHINbylCIt/
 UvExkcmELpGA4H3vkJhlF/3oCUC9dvJQ+/yMFmMkbOGD+jEcF3dBLb0vW9gvHA9HN2mQ
 O6NO4iNo/bo2Pe32MdUxl3bGMvMD2KSEQfwsSibOqDO+LWK5dCaDJGwScavtWExfTFKZ
 0NSFk50H9jbcvU9NeYMv2IpFYuO5cWtAd+ouLKu3NfI+DNjCqvOmuk/895KhJIOmNQve
 dPLUGoIxo0qj2kOiBhwJzBdPgH/UC0oiKfJ64vygJg92EHNeNlHGSXoCHYC/Ur5trakU
 +EbA==
X-Gm-Message-State: AOJu0YzTQk64yp2yj/MmuR+ca8mJkYNGYRlxDwTYqs8w/JxdQx2+8D5x
 weR6Xkyn+s6bhwHoP1anYeD7gdKUYqDCV19M7EpA+7H4IZOq898nE+dt7r/jO4hC5kmz0CE1ltR
 D42Djq9OZUIBhJYXRGa+x4N8q5xnN9qAC16j2gyPEAG18eqmzgsTec/VbJE/aSCeSIoAdM673bq
 sxLaLRn/ALg1+M5W4OT5VDWnDq63dIhQ==
X-Received: by 2002:a5d:5c01:0:b0:37d:461d:b1ea with SMTP id
 ffacd0b85a97d-381c7ab30b1mr11789044f8f.48.1730754433815; 
 Mon, 04 Nov 2024 13:07:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBBv6P2WdADcM4FRlqc4uwtAXrJxj/k1/pIzNCcGxac9zjNsWn0zB/jP1y8+T5aBQlEdQoRA==
X-Received: by 2002:a5d:5c01:0:b0:37d:461d:b1ea with SMTP id
 ffacd0b85a97d-381c7ab30b1mr11789025f8f.48.1730754433301; 
 Mon, 04 Nov 2024 13:07:13 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e67csm14147402f8f.75.2024.11.04.13.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:07:12 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 25/65] tests/acpi: pc: allow DSDT acpi table changes
Message-ID: <d944497b5519cdefe2d38cf68317b93e14dd388a.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Ricardo Ribalda <ribalda@chromium.org>

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-Id: <20240924132417.739809-2-ribalda@chromium.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..6fef8e558b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,17 @@
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
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.viot",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
-- 
MST


