Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31942C54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxyE-0003Kh-38; Fri, 01 Mar 2024 03:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxyB-0003Jm-6B
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:10:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxy9-0006xr-Bw
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709280612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNck2xyehKoHLhViWPMpAF6u63kWeiEmGEvih2IAe2w=;
 b=QvbHYC1A5ZeqCSesp/nheppLro60Z6hHLQvopz5IjlttEUApAZS5QxkZdHC9RV+TpVJo3u
 gZ8nj73enrY6ICABdxyWDpXSawd4VuLPxC7hoDSX5dEV7ZdOoD8D23S0miCDjZUN9RCiij
 N6t/ToR/Ns3DCp+r9HOsEQ9oBVqi92k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-j53_f3L4OqKyewFloYvhiA-1; Fri, 01 Mar 2024 03:10:06 -0500
X-MC-Unique: j53_f3L4OqKyewFloYvhiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDB4A84AF11;
 Fri,  1 Mar 2024 08:10:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBF1B2017D3E;
 Fri,  1 Mar 2024 08:09:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Benjamin David Lunt <benlunt@fysnet.net>, qemu-stable@nongnu.org
Subject: [PULL 4/6] hw/usb/bus.c: PCAP adding 0xA in Windows version
Date: Fri,  1 Mar 2024 09:09:51 +0100
Message-ID: <20240301080953.66448-5-thuth@redhat.com>
In-Reply-To: <20240301080953.66448-1-thuth@redhat.com>
References: <20240301080953.66448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Benjamin David Lunt <benlunt@fysnet.net>

Since Windows text files use CRLFs for all \n, the Windows version of QEMU
inserts a CR in the PCAP stream when a LF is encountered when using USB PCAP
files. This is due to the fact that the PCAP file is opened as TEXT instead
of BINARY.

To show an example, when using a very common protocol to USB disks, the BBB
protocol uses a 10-byte command packet. For example, the READ_CAPACITY(10)
command will have a command block length of 10 (0xA). When this 10-byte
command (part of the 31-byte CBW) is placed into the PCAP file, the Windows
file manager inserts a 0xD before the 0xA, turning the 31-byte CBW into a
32-byte CBW.

Actual CBW:
  0040 55 53 42 43 01 00 00 00 08 00 00 00 80 00 0a 25 USBC...........%
  0050 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00       ...............

PCAP CBW
  0040 55 53 42 43 01 00 00 00 08 00 00 00 80 00 0d 0a USBC............
  0050 25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 %..............

I believe simply opening the PCAP file as BINARY instead of TEXT will fix
this issue.

Cc: qemu-stable@nongnu.org
Resolves: https://bugs.launchpad.net/qemu/+bug/2054889
Signed-off-by: Benjamin David Lunt <benlunt@fysnet.net>
Message-ID: <000101da6823$ce1bbf80$6a533e80$@fysnet.net>
[thuth: Break long line to avoid checkpatch.pl error]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 796769fadb..bfab2807d7 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -260,13 +260,14 @@ static void usb_qdev_realize(DeviceState *qdev, Error **errp)
     }
 
     if (dev->pcap_filename) {
-        int fd = qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY | O_TRUNC, 0666);
+        int fd = qemu_open_old(dev->pcap_filename,
+                               O_CREAT | O_WRONLY | O_TRUNC | O_BINARY, 0666);
         if (fd < 0) {
             error_setg(errp, "open %s failed", dev->pcap_filename);
             usb_qdev_unrealize(qdev);
             return;
         }
-        dev->pcap = fdopen(fd, "w");
+        dev->pcap = fdopen(fd, "wb");
         usb_pcap_init(dev->pcap);
     }
 }
-- 
2.44.0


