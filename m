Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B674C54E4A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 21:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reLe1-0000Uz-Gg; Sun, 25 Feb 2024 16:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zi23GS=KC=fysnet.net=benlunt@eigbox.net>)
 id 1reL2O-0000gd-CP
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 15:23:52 -0500
Received: from bosmailout06.eigbox.net ([66.96.187.6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zi23GS=KC=fysnet.net=benlunt@eigbox.net>)
 id 1reL2M-0004jh-PY
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 15:23:52 -0500
Received: from bosmailscan06.eigbox.net ([10.20.15.6])
 by bosmailout06.eigbox.net with esmtp (Exim) id 1reKWf-0001CM-7v
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 14:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fysnet.net; 
 s=dkim;
 h=Sender:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CTgUnaLsCihC8z32cJNR5EDENJWs83hTcEYvtrdlE6g=; b=nbKi/sMD3EZjXxmtV2Kh1MMoDL
 AS03orwX9WrTc73kfBM7OrOrki4owqHuJsfW2/RlMDRmhrVkhGCmSBZoa8yOQuEYqWAk81uoD3pPJ
 L2T/833GZ7N7enpUmXLHv+T3nB6zmQ8zC2VDoMCY5FWboJ7TwMu4EzgalMhtTVXr+mPoKIg+xa6sT
 JnjpO7f1wzXrPABUIxUe2tY48knby6P+7224PCzE412jvDYYg6pgtW/8TjCP3qBH8q2Kmducw1/AO
 WH0ymFb/yWqZPb4FpF2RYQQAOWgNGiOLR0ZXUQItezjy2VypDGWE6aRK4igs/L+jwjpnH4Lo4BnO+
 M8T4OuBg==;
Received: from [10.115.3.33] (helo=bosimpout13)
 by bosmailscan06.eigbox.net with esmtp (Exim) id 1reKWd-0003Y2-22
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 14:51:03 -0500
Received: from bosauthsmtp10.yourhostingaccount.com ([10.20.18.10])
 by bosimpout13 with 
 id rXpu2B0010D2CUy01Xpxu8; Sun, 25 Feb 2024 14:50:41 -0500
X-Authority-Analysis: v=2.3 cv=Q6tJH7+a c=1 sm=1 tr=0
 a=Kpo39fPXdbgqDwiI3/AEUA==:117 a=S3MT/dRO/ryrFfNS2TKYag==:17
 a=kj9zAlcOel0A:10 a=k7vzHIieQBIA:10 a=danhDmx_AAAA:8 a=03UIiu-VAAAA:8
 a=jPOicQp0w2Md6mnQZXQA:9 a=CjuIK1q_8ugA:10 a=P4VdviVPEcjfz_PVVggX:22
 a=TDsaGBozw4ymKzHYph0x:22
Received: from 72-24-79-116.cpe.sparklight.net ([72.24.79.116]:51211
 helo=Fys64) by bosauthsmtp10.eigbox.net with esmtpa (Exim)
 id 1reKVW-0005gC-3g
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 14:49:54 -0500
From: <benlunt@fysnet.net>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] hw/us/bus.c PCAP adding 0xA in Windows version
Date: Sun, 25 Feb 2024 12:49:51 -0700
Message-ID: <000101da6823$ce1bbf80$6a533e80$@fysnet.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdpoIjhwSpNg4Nf3TrCXeVbHYOrrTQ==
Content-Language: en-us
X-EN-UserInfo: 0be0d87d7bf3726c278d97b9639d48f5:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: benlunt@fysnet.net
X-EN-OrigIP: 72.24.79.116
X-EN-OrigHost: 72-24-79-116.cpe.sparklight.net
Received-SPF: pass client-ip=66.96.187.6;
 envelope-from=SRS0=Zi23GS=KC=fysnet.net=benlunt@eigbox.net;
 helo=bosmailout06.eigbox.net
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Feb 2024 16:02:42 -0500
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

Resolves: https://bugs.launchpad.net/qemu/+bug/2054889
Signed-off-by: Benjamin David Lunt <benlunt@fysnet.net>
---
 hw/usb/bus.c | 2 +-
1 file changed, 2 insertions(+), 2 deletions(-)

diff -u a/hw/usb/bus.c b/hw/usb/bus.c
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -273,13 +273,13 @@
     }
 
     if (dev->pcap_filename) {
-        int fd = qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY |
O_TRUNC, 0666);
+        int fd = qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY |
O_TRUNC | O_BINARY, 0666);
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



