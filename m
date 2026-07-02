Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF78C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfIt9-0005YV-9U; Thu, 02 Jul 2026 10:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wfIt8-0005WJ-LJ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wfIt7-0004Sf-57
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783004376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4iQ/5rn+WmQNXMNztjv9K91ycXFphWBg9nehTmrLyM=;
 b=YKvASojClEboYfHuwL2w1xNjRN5LeapfjKBy3oiKyqpyXTzs38XM2PJipsq5XItjZ5ACpf
 27n/ZoQsHvjX8P8suMxURPoJyCnIkca2CJFQUbviRdgQbdG9uJu7rvkye8WdQRbP8TTr4/
 p2VwdI5yr6HsxqL/YG0QL9HsxuMAWfM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-vwrwqU-5MDyVqTJAI8mDGw-1; Thu,
 02 Jul 2026 10:59:33 -0400
X-MC-Unique: vwrwqU-5MDyVqTJAI8mDGw-1
X-Mimecast-MFC-AGG-ID: vwrwqU-5MDyVqTJAI8mDGw_1783004372
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F7A31944A85; Thu,  2 Jul 2026 14:59:32 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 526D1180056E; Thu,  2 Jul 2026 14:59:30 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, eauger@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v4 13/13] tests: acpi: arm/virt: update expected GTDT blob
Date: Thu,  2 Jul 2026 16:58:56 +0200
Message-ID: <20260702145856.1539572-14-imammedo@redhat.com>
In-Reply-To: <20260702145856.1539572-1-imammedo@redhat.com>
References: <20260702145856.1539572-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Expected diff from base GTDT is an addition of watchdog
timer block:

   [000h 0000 004h]                   Signature : "GTDT"    [Generic Timer Description Table]
  -[004h 0004 004h]                Table Length : 00000068
  +[004h 0004 004h]                Table Length : 00000084
   [008h 0008 001h]                    Revision : 03
  -[009h 0009 001h]                    Checksum : 93
  +[009h 0009 001h]                    Checksum : 39
   [00Ah 0010 006h]                      Oem ID : "BOCHS "
   [010h 0016 008h]                Oem Table ID : "BXPC    "
   [018h 0024 004h]                Oem Revision : 00000001
  @@ -48,17 +48,30 @@
                                      Always On : 0
   [050h 0080 008h]  Counter Read Block Address : FFFFFFFFFFFFFFFF

  -[058h 0088 004h]        Platform Timer Count : 00000000
  -[05Ch 0092 004h]       Platform Timer Offset : 00000000
  +[058h 0088 004h]        Platform Timer Count : 00000001
  +[05Ch 0092 004h]       Platform Timer Offset : 00000068
   [060h 0096 004h]      Virtual EL2 Timer GSIV : 00000000
   [064h 0100 004h]     Virtual EL2 Timer Flags : 00000000

  -Raw Table Data: Length 104 (0x68)
  +[068h 0104 001h]               Subtable Type : 01 [Generic Watchdog Timer]
  +[069h 0105 002h]                      Length : 001C
  +[06Bh 0107 001h]                    Reserved : 00
  +[06Ch 0108 008h]       Refresh Frame Address : 000000000C000000
  +[074h 0116 008h]       Control Frame Address : 000000000C001000
  +[07Ch 0124 004h]             Timer Interrupt : 00000090
  +[080h 0128 004h] Timer Flags (decoded below) : 00000000
  +                                Trigger Mode : 0
  +                                    Polarity : 0
  +                                    Security : 0
  +
  +Raw Table Data: Length 132 (0x84)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/aarch64/virt/GTDT.gwdt      | Bin 0 -> 132 bytes
 2 files changed, 1 deletion(-)
 create mode 100644 tests/data/acpi/aarch64/virt/GTDT.gwdt

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 3e9be28cc4..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/GTDT",
diff --git a/tests/data/acpi/aarch64/virt/GTDT.gwdt b/tests/data/acpi/aarch64/virt/GTDT.gwdt
new file mode 100644
index 0000000000000000000000000000000000000000..44e6f2b18d2848f595a8c69bdb54a59e1becaffd
GIT binary patch
literal 132
zcmXwwyA6Oq3`5@udZ_s+HDlZ%K?f37Fam?H1k-{Nf(yUca^^hc3n=cmre&9SY)M2U
h0D3DQ7eKED3_uCAo*U=C)xXm_Rp<<rdHr#;057;f7y$qP

literal 0
HcmV?d00001

-- 
2.47.3


