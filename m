Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6279DEE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOjv-00078Q-Mu; Wed, 11 Sep 2024 10:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhk-00079M-P3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhc-0007Dw-N9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726066332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hje9oGIw2otX3n3e6GR0YuFJNQxqhspv7J1M4mo3f28=;
 b=iXgLLhbpWthxegEe79bIE076DuOoVSiaWIJ62txPcBAK90mTl+aCUgEiqmnU+KJwmPhhMX
 bNPKmCznPjS5y1nv1/S5PD1Co1DThT02fJTVnw5JuKIwYXQd8LmU/U3NvNXe+Q1lgLEG2t
 cUEtIISt7Pik0cnZLY6APkPnDuMxzt0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-VH3gesR8PkCYoMjLDScvAw-1; Wed, 11 Sep 2024 09:51:40 -0400
X-MC-Unique: VH3gesR8PkCYoMjLDScvAw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a8a877c1d22so330361966b.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062698; x=1726667498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hje9oGIw2otX3n3e6GR0YuFJNQxqhspv7J1M4mo3f28=;
 b=SGUB0kLBwIocZ/v9yq5xJXf4XGzAMZu74r5STeebOySSnTGBZMhv6/nyl5CTgk6PE7
 oGdTWh+PlTYT8maeUxrkOBgjZduXMveW2HhCP5xmcA332onxg3zLoDiBEzWyZG85WYg9
 L/j+AVdpAROd3ikFJH6t49dHF//rMunqTrsUwfrEiMiPuMEf8iQo8xlRrKTkIWCZMKcE
 A0isqGjjSMJjjcEhiroShtOccqY7TUI8b4uq8DR38fb3Qbe/BaF0rUsHSbRFOiCtnD+y
 0egNrQyFEqgzs6JoO9/v3V2xBClxoGMAM65zfl65lEVRnKB0QZWNGA8z7jKayjoKuctq
 mc4w==
X-Gm-Message-State: AOJu0YwjVcjebpPGkLDmbbWNJPMJQXeR2Gakrynm3pH0T7VZQUUkV5q+
 aBrrsQ/yOjQiYEcs02/f8MNAq9Oatg+z/b2UI6or0UQFT/5p18N09vQ0iuMXb9fLxkhJf/WhNOo
 V23D2kzsLh5BUPxzB2Ky3ovjGtNeeqZKjznlzTDPBBOzgdXtuHOGleARVH4PgqQtjG/HCRUH9Tn
 TbIDnjvfhj6Ud287gkK04DqSz/rh87PA==
X-Received: by 2002:a17:907:6d0e:b0:a8a:835f:4cb9 with SMTP id
 a640c23a62f3a-a8ffadf04ffmr336003966b.46.1726062698536; 
 Wed, 11 Sep 2024 06:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6bD5XcAmB/xGWz6Ei3wFwoAeoEQsyQsfXaF1vCQ+x21OsHGZC9dt/pUD5oEbtl1oNshF04w==
X-Received: by 2002:a17:907:6d0e:b0:a8a:835f:4cb9 with SMTP id
 a640c23a62f3a-a8ffadf04ffmr336000366b.46.1726062698036; 
 Wed, 11 Sep 2024 06:51:38 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a073b1sm612326266b.82.2024.09.11.06.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:51:37 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 04/18] hw/isa/vt82c686.c: Embed i8259 irq in device state
 instead of allocating
Message-ID: <2225dc562a93dc191c3b2a43f273639bebad5d9a.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: BALATON Zoltan <balaton@eik.bme.hu>

To avoid a warning about unfreed qemu_irq embed the i8259 irq in the
device state instead of allocating it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <b70b9e72063b4dd4005bf4bc040b84f2bb617bf4.1719690591.git.balaton@eik.bme.hu>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/isa/vt82c686.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 505b44c4e6..82591e3e07 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -592,6 +592,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaISAState, VIA_ISA)
 
 struct ViaISAState {
     PCIDevice dev;
+
+    IRQState i8259_irq;
     qemu_irq cpu_intr;
     qemu_irq *isa_irqs_in;
     uint16_t irq_state[ISA_NUM_IRQS];
@@ -715,13 +717,12 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     ViaISAState *s = VIA_ISA(d);
     DeviceState *dev = DEVICE(d);
     PCIBus *pci_bus = pci_get_bus(d);
-    qemu_irq *isa_irq;
     ISABus *isa_bus;
     int i;
 
     qdev_init_gpio_out_named(dev, &s->cpu_intr, "intr", 1);
     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
-    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
+    qemu_init_irq(&s->i8259_irq, via_isa_request_i8259_irq, s, 0);
     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
                           errp);
 
@@ -729,7 +730,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
         return;
     }
 
-    s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
+    s->isa_irqs_in = i8259_init(isa_bus, &s->i8259_irq);
     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
     i8257_dma_init(OBJECT(d), isa_bus, 0);
-- 
MST


