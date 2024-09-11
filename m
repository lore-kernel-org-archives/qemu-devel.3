Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67850EE49B7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOKD-0000Vd-7q; Wed, 11 Sep 2024 10:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOJR-00079e-Ti
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOJO-0003NK-3q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726064832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iEUY6iNItmilx4GQ008agO3v3YGH5P6LxKz939t7m08=;
 b=K4bUneE59c19ooa5tkGnHmgw2y1zGKa6q6umzd/YW2L7qqaazPvTbwMD1AXdoSyRTnBFEG
 jlH0ZRMWv/QK2CpNugmNvrxhfHai7ev+MrVR+g4DECgF8+Vi3t17Fdk3IMpqgtGhLd9H6R
 mP1gKOVCpk2izKy3SJ0BG1xVqXK7GiE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-BgIOjzUWOwmXZs7R1SCXDA-1; Wed, 11 Sep 2024 09:51:47 -0400
X-MC-Unique: BgIOjzUWOwmXZs7R1SCXDA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a870f3a65a0so490947966b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062705; x=1726667505;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iEUY6iNItmilx4GQ008agO3v3YGH5P6LxKz939t7m08=;
 b=tHxZcFXGiE7zWYXFZUFjCKqkzvDwoZeJhuJh3QXy51m0ysyfDV7SYPAJrK9AKh4Ae/
 oS8mk0Dmd77cgcqcaaVAQqotkzqEnqc425yPCcV1ui1y4MXzeTCnYXpWj3f52i2RItJu
 IgYlAK0/6PCWx/1Ju8r4Y7GssDgF8A53MUKMOCaaRsHEGa9ol1mJzClhscAzy5/M3s+q
 1pTTbzh7zv3b8OwM7+zn62AviZSU4w1g4D9N4It/OadbiFlofg2Ki/8Q7+AIM1sDfuak
 kzk4YaIyVkaW+MJbosN462ZCYracsnbSipJzJNI4E0CVwH7AXsEszZ0ukEvrhXnUHglf
 loWA==
X-Gm-Message-State: AOJu0YyHv+kRkIJdNvB1CVapv4/zqeRYMxufEJTmCzuDGIqGgfMQNymu
 zlLDTEZrSbRskz84oxWrKPvKYljQ5yD9oM6i2Mp2c35JWZd1mVyopfvOunZyZCgc6YHX5sZywkQ
 a3Ww9lBRID8R9p9IGozyt/UkPDy/fi95oY0xL2hESehtg17nL7cuTNcm5YoYTy9YBwgxcjKjS1x
 YPuCpNO8NuLTEb7Cs/6K/s0j9+Azo2Eg==
X-Received: by 2002:a17:906:794f:b0:a86:91c3:9517 with SMTP id
 a640c23a62f3a-a8ffab70902mr459445666b.35.1726062705417; 
 Wed, 11 Sep 2024 06:51:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXPDKKnMF35RBQtFeyBFrrESbl4FumZQ7bj7lit8s9FtDwIrT3ZqdsFp8v83Z6DooXPauh/A==
X-Received: by 2002:a17:906:794f:b0:a86:91c3:9517 with SMTP id
 a640c23a62f3a-a8ffab70902mr459442066b.35.1726062704829; 
 Wed, 11 Sep 2024 06:51:44 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2593dbb7sm616986366b.56.2024.09.11.06.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:51:44 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 06/18] hw/pci/pci-hmp-cmds: Avoid displaying bogus size in
 'info pci'
Message-ID: <aa37616fb4eed38f3fc26507faf2433c998e0073.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When BAR aren't mapped, we get:

  (qemu) info pci
    Bus  0, device   0, function 0:
      Host bridge: PCI device dead:beef
        ...
        BAR4: 32 bit memory at 0xffffffffffffffff [0x00000ffe].
        BAR5: I/O at 0xffffffffffffffff [0x0ffe].

Check the BAR is mapped comparing its address to PCI_BAR_UNMAPPED
which is what the PCI layer uses for unmapped BARs.
See pci_bar_address and pci_update_mappings implementations and
in "hw/pci/pci.h":

  typedef struct PCIIORegion {
      pcibus_t addr; /* current PCI mapping address. -1 means not mapped */
  #define PCI_BAR_UNMAPPED (~(pcibus_t)0)
      ...

This improves the logging, not displaying bogus sizes:

  (qemu) info pci
    Bus  0, device   0, function 0:
      Host bridge: PCI device dead:beef
        ...
      BAR4: 32 bit memory (not mapped)
      BAR5: I/O (not mapped)

Remove trailing dot which is not used in other commands format.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240801131449.51328-1-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci-hmp-cmds.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index b09fce9377..fdfe44435c 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -83,15 +83,25 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
         monitor_printf(mon, "      BAR%" PRId64 ": ", region->value->bar);
 
         if (!strcmp(region->value->type, "io")) {
-            monitor_printf(mon, "I/O at 0x%04" PRIx64
-                                " [0x%04" PRIx64 "].\n",
-                           addr, addr + size - 1);
+            if (addr != PCI_BAR_UNMAPPED) {
+                monitor_printf(mon, "I/O at 0x%04" PRIx64
+                                    " [0x%04" PRIx64 "]\n",
+                               addr, addr + size - 1);
+            } else {
+                monitor_printf(mon, "I/O (not mapped)\n");
+            }
         } else {
-            monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
-                               " [0x%08" PRIx64 "].\n",
-                           region->value->mem_type_64 ? 64 : 32,
-                           region->value->prefetch ? " prefetchable" : "",
-                           addr, addr + size - 1);
+            if (addr != PCI_BAR_UNMAPPED) {
+                monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
+                                   " [0x%08" PRIx64 "]\n",
+                               region->value->mem_type_64 ? 64 : 32,
+                               region->value->prefetch ? " prefetchable" : "",
+                               addr, addr + size - 1);
+            } else {
+                monitor_printf(mon, "%d bit%s memory (not mapped)\n",
+                               region->value->mem_type_64 ? 64 : 32,
+                               region->value->prefetch ? " prefetchable" : "");
+            }
         }
     }
 
-- 
MST


