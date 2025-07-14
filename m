Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46074C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSIM-0002ek-U2; Mon, 14 Jul 2025 19:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHe-0007D8-50
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHc-0005iX-Fr
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJT1WNX9x5yUAyAqjvE4oJoegL0vp/Icnnrd7gTuHFs=;
 b=SErng7NPq5sdZb31tqD5Pb1RhXeEaU1ybOC8m0sYmLOxMwvD628Rh34xh696IiEduAUjia
 XK2jIstOHwWqgzOPpKLOQmiQ5N8t8eKFCvdiSHHVrVKgiOcSeDSjtwDR7DIafMr2n/00M5
 BLl6P1NQ/nEVgY6iOCF82OYHpDzxgeU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-unK_XWmbORS8YD4hmxhFpQ-1; Mon, 14 Jul 2025 19:08:26 -0400
X-MC-Unique: unK_XWmbORS8YD4hmxhFpQ-1
X-Mimecast-MFC-AGG-ID: unK_XWmbORS8YD4hmxhFpQ_1752534504
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a50816cc58so1639107f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534504; x=1753139304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJT1WNX9x5yUAyAqjvE4oJoegL0vp/Icnnrd7gTuHFs=;
 b=BnR/Hq6A2EtQKO5VV+8rrmB5c9xUn+qeGg8W+XPO72ZdQBGM4uRmwQj3uMiA4ejxNE
 2vwxlJJBc1OTEFGY2wDTtOh3z7ejndWLmuQqyQKUr0PigMHvIoiBwJ/CQUOUJGTtgR11
 mJVuZwTHKI3WoevoDHeWgu9vh37US5tAPErYsWmtJlTmlBEMUWResaCt5EBf6pJWHod5
 Cn9RPOlMS8WoS8D7UqsyCAyFKw8iaRH16t74TCEmrIrAf4Mm9Dyw1mc4+YsHGBSBDP9T
 V2/yxduw5IWPoBL+LW3NOvOtbZhtDAzzMZb/NdikCvJQa/I6Y09TXE9Ibr5aA8oOgmP/
 yhfg==
X-Gm-Message-State: AOJu0Yw3bfDwZ8vlk6vvQxsGJ2+gUSG1yIghnROiXqhdfDRvnzomPYdV
 W77MpqwobfofGP9GLKviWYNlK3xdYAAacs+ErU0GlDkLe6DeGPU9ldS0L2uqGf798iWAhmefL0+
 /jpggbWtFKTBj8jLmQRkWuobw4UhwMGoZM+eF6Q2J5D4ofzDULZNB+yE/sPecDAgkVjJdTQwQhb
 GfXqRKgMW27IbEcDd4D6MRfJdAwFDpUBrmzQ==
X-Gm-Gg: ASbGnctzKsLjN3ox64qOScjh6hRp5dlbqIIb227xYlUXhFJLmu3261Euif87FesLzsn
 L42AD+0e26ApKiADyI2R0jvTFbmEiYL35VtKLrWtW8WkZzO6J/S9aJWd2ZOYh06qNiLR2JWxmbo
 NClhRqPg3npkbNTsea22f5Wvw8DVMLZPNlp97ClWPiDYfeyLYt8rPQ9tD5Yf3vEsfSM/ne1b6+q
 3y2sg6RIidx6lhKZ8GzAT5QAS8Iw9iWN4AEQX7p3jQ3JzfhtM+mhZFUe0WhDl9R+JlLnVro/BFE
 ZnJ67/IL90iHmnwEuGJW2+utC570P61Q
X-Received: by 2002:a05:6000:3ca:b0:3a1:f5c4:b81b with SMTP id
 ffacd0b85a97d-3b5f188e6demr11854241f8f.23.1752534503777; 
 Mon, 14 Jul 2025 16:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVrW9fQiE3mgxHGGRHnXBLCFJE7Egt7JpJyOVIAfcQFr0jF/PqWr0Iy7VF0tsoK+mzHkpXPw==
X-Received: by 2002:a05:6000:3ca:b0:3a1:f5c4:b81b with SMTP id
 ffacd0b85a97d-3b5f188e6demr11854213f8f.23.1752534503244; 
 Mon, 14 Jul 2025 16:08:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1784sm13431907f8f.5.2025.07.14.16.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:22 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 50/97] tests/qtest/bios-tables-test: Prepare for changes in
 the DSDT table
Message-ID: <0c6b596140b82ac6b3204bf0c491a6f05f24c658.1752534227.git.mst@redhat.com>
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

This commit adds DSDT blobs to the whilelist in the prospect to
allow changes in the GPEX _OSC method.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-5-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..8d9673cb5d 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,12 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
+"tests/data/acpi/loongarch64/virt/DSDT.memhp",
+"tests/data/acpi/loongarch64/virt/DSDT.topology",
+"tests/data/acpi/loongarch64/virt/DSDT.numamem",
+"tests/data/acpi/loongarch64/virt/DSDT",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
+"tests/data/acpi/riscv64/virt/DSDT",
-- 
MST


