Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAF1C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNy2-0000rH-LG; Sun, 05 Jul 2026 10:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxI-0008Sg-O0
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxH-0001Vu-AU
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CnVUHm1T3f9cs33jF9PmuVsxOvS2TEhc45aVXWGfqyQ=;
 b=QYqD5vxl/rAd3bZeBBDEsdl82lx+OgMG8sC8J1ttcMsHb0Lyyb8xpDxSPBMqebz7X3Afnu
 z3eiLEmY+bYl7bPAtZ/gQJGVNgTvF7IKiDABQOM5t//y9F+deTQYYPGYb+bi3tJ0yaf917
 Hlzh+Hllof4LG9veKXCzxUma4ESeD0M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-vttm9YEBO5GG7hKAXgDvdg-1; Sun, 05 Jul 2026 10:36:17 -0400
X-MC-Unique: vttm9YEBO5GG7hKAXgDvdg-1
X-Mimecast-MFC-AGG-ID: vttm9YEBO5GG7hKAXgDvdg_1783262177
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47345535410so1824947f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262176; x=1783866976; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CnVUHm1T3f9cs33jF9PmuVsxOvS2TEhc45aVXWGfqyQ=;
 b=Bc/eVO3R8/Zy0ZCsk1haJ4bsSqn6dtglxra8LO8I0s+DLtwwRVibLyTtr6RBzSxd9j
 i2nfqDyEdktt6JfGqoIgsSpVkf8FbtNjcj0kK05cqie0rCZESImH/Xq4j6gsRRoa8oSH
 tEa0rKVdd7sRmnVfwGfm0JD9Zf7srSEwxFzjEal7uVAXWV5aIy9gpQhIMcy/gEJroSmv
 kNcIG06OTqixUOXgAkoLBptJoW5ssp6cHNmRWnCvfCezEnYq1o2zFQCQKgXUexDd3otS
 93fkQyZv8D0zI9WMG3EbAZJgjI4cV5uU8dXjN27ITQK/QYLLzy++i2lLDiDodCJ0Nujk
 pmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262176; x=1783866976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnVUHm1T3f9cs33jF9PmuVsxOvS2TEhc45aVXWGfqyQ=;
 b=awaxm8mIWrQtzuTbRKppsoYtSM8PcW2uY6IbMcHhZj9jDjQj3AvTcaZDztIZCcepHr
 7Faz6hlc4j4dbfUcmjDq1D0xcGq035EP0PmHdpQT9pQhfyRt53+99ZNV72DmxACOrsRl
 4rDpUmvOnL+50iRtPuSaNgfBeTLRiJREMcCq0IbNAGgWyAwd2w2lOMYW4fJnnTfNIUPT
 E8gScj0gRyRDA0IfVj45MLxxfu2AQLiiOeRm9S2iVx0uXZ+61u4pHSx7kScMI4uPimg1
 t524g6ctvvcInj09nzI0KPKu9RvUwFf4nmNnkNtl2X7CqC3s5fdNbdIDi7wImCiUB5ix
 LPdA==
X-Gm-Message-State: AOJu0Yz0qvzKkmMuAbnZJXzWMjLktY+47rpN/2N0wKLx0zsXNR/AT250
 T6+JmV6P+rbkoP2RQFE9TlSlBhxYkEunI0RMpQzvCBjIG4XAKSS8upQnU+bswXKOKIwQ19XFGs7
 y4ByMAeRfwzYPhJd4TrMN52fq2lsXQ8pBe7RMFXEKsUzwSAkFCqkDj2sRdFRU31+DTnIhLXOyiz
 GR+68dO5KS284TV3pq6unSh9SGbwSlKnuHeQ==
X-Gm-Gg: AfdE7clzfSbs1qXM6xGCmDw+sYlHALobPvHV0eP1rC3M4ZMXHv8fx5+jrxLD9fKE3Dk
 MHn2SUeXY3HHmLeNYd5eqyzX2WC3nDcqcfVlN8wqTaBW1A9iS8ebAXke2GcH660DK71SKHGybJp
 7rJsnu75uAHah1KMec1OfFzaFMVmI8lRXuTN0+4ooKMV3sGLzl0fm7ORay1tGNNr1t1oBosb8U9
 VAgyxl25IM+WJRo+nplYqKtdw8ssjkS+MXUC1h63ZRU9B2MqivMkLZVC8UbcNAKb4nLNKOGK4xv
 a1eWosEeX+lBTRyKWrxShVdUXBogVJLi0XvnbB/Sbdj8nisUmAU43+w0I0stn21Iezde2xyUwCd
 NJiPMoqSUeTB86WF8jtn4hUGlpDnycXFh
X-Received: by 2002:adf:f0c5:0:b0:474:6a5b:8606 with SMTP id
 ffacd0b85a97d-47aac5e2f9dmr6129549f8f.21.1783262176447; 
 Sun, 05 Jul 2026 07:36:16 -0700 (PDT)
X-Received: by 2002:adf:f0c5:0:b0:474:6a5b:8606 with SMTP id
 ffacd0b85a97d-47aac5e2f9dmr6129508f8f.21.1783262175751; 
 Sun, 05 Jul 2026 07:36:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d91bsm19513666f8f.4.2026.07.05.07.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:15 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 39/44] tests: acpi: arm/virt: update expected GTDT blob
Message-ID: <7205b8ffb6566465af0628c2fd5258e26dca6b41.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260702145856.1539572-14-imammedo@redhat.com>
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
MST


