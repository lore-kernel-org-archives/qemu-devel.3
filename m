Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BDC606A335
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtoM-00055C-4X; Thu, 05 Nov 2026 04:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtoK-00051J-2U
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:31:08 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtoI-0007OR-Ex
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:31:07 -0500
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3ac91ac8924so1136645a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793871065; x=1794475865;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fz3AwyDwDLGgj59/0W5LxrO61Dz9+aqIkiPGR2ZoG4M=;
 b=wOeNmojNTcac6449eKuX07wy6Ji2At9pwhGrnSSymFzOKM8nLocf7oYtMV8YctbKPG
 9DsPsb5B3dfB7IV2VYBxzl8Ne54W3E0P1auf/gLGqPG6VoPPwH2ioMHn7lUQTfLffrxc
 pQeFWcFe3xsQgdHZtR0zUcpy63zBBOUm7ci7LWVW6mmwUiBTd0f1cpOpemmKVg+PIEXg
 vtd4Gy7zjTwCgbjpES21cekU6MELtN8ubhTjnPGx2r61eb+WRxrBfb5z15kocNr2AwDg
 J/AbXPjmRvShzkYaxDHntQXj/DKB5MGatYCR6Gc7RiLzT72GdxI1WaKIvBKLqSpUJiHN
 dxfA==
X-Gm-Message-State: APuU4Z9iaWaXxBOC9Uhzu1GahjqXDNvgVX3Hu2OOKplO9ybyxGuHrpxT
 bCAX51IoLAz40ssyv70RxRiy18w1wBaML/9dk2oOjZidP+63lX/mBy6zSTyNEExvkRQ=
X-Gm-Gg: AYBFou1e/2rfNPCxdjf8bL8RjA7HBzqIiznxHTKntUsw8k+lcltQTqddS5pcGvu2KjG
 zWepq5iZmNJRr+KM98Xy9tFKOjrBLU5K5AlBnpjYf3B+vF8AjT8tBHHjcy3fBhbfcL7YBG9I/dp
 cBTI+HF1dJ3p2KLG+T+sb0WMoMy7iOBw/OkEyYoaIL9jotjo6EhE95lYvBcMtGpGY5j20M088W9
 ocWF1Lkj8pe5slTtVOkDtIS4YJEFljfXv2abX7VEwC1kKAtroKqcwiNqccqJpmEYqqRYSkL39IJ
 yUMWTUN02g3Pc7WSCHSUQKmN12MIgDCLs/boYL/erxhcL7eRls0alY/bN5rx1chf68gMVTSzlID
 p9Qtd867T9WlwFRioFWtQE9QNzrzdPmQLR62kVURuXCavFzWYFuqkshhEWF8zAkasQNRmLIGibo
 BJZSH1rU/si/RZJQCQEmpNk5jgGpz931bHKuFTzS/KccKWFeEGAMNX9W0MACOxmtTeB2wZAwqc9
 yAJE+bAnkG46aYP4D0sWxBk+G/1Xof07jPhC8Bva7NNyh7Y8RqfXtmlJNl4gfZXBcHRA2U1dUx7
 Mpva0R76MfeT+IEXIE1T5070sb5mRI7kUVIli5riIdI57WIDiGc/QRHz9yqSnaIo+0ackKb1tsH
 9
X-Received: by 2002:a17:90b:574e:b0:3aa:ff61:9504 with SMTP id
 98e67ed59e1d1-3ae897c94f6mr14560008a91.20.1793871065065; 
 Thu, 05 Nov 2026 01:31:05 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b2cf80c9sm3158612a91.0.2026.11.05.01.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:31:03 -0800 (PST)
Subject: [PATCH 0/4] hw/sensor: add the TMP1075 temperature sensor
Date: Thu, 05 Nov 2026 17:25:52 +0800
Message-Id: <20261105-sensor-tmp1075-v1-0-d2ee5da0b880@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDVpq0hcRSxaBiNR0kEk4u6K5
 Vv8fwFjIGSokgsCHsS0+AiVJtCO1g8oqIsGLXWhlMwFo+cliG1elSxzYWxptC4y6ZyBGK0Bezq
 /Yd385t1N2G7vBe77ARZmCZdyAAAA
X-Change-ID: 20261105-sensor-tmp1075-4a7422630bb4
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870754; l=1007;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Hx9Q5VCHYaNGSbcANjrkwl2qZijEGGKlzzmP5LeL8c4=;
 b=snym7kV679LVLmuQjjB8PtX6bN3OjUner72Y2f1q7iTfCbX6nU1R1EBWUddJx59+9zX653T9t
 umV9lDuv4VTCh5eDrmTesfQsvaT4QZ+DonBh2AvS82gBSYCJkxqyFkL
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.43; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f43.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Based on master, at:
  f29ccc287a

The TMP1075 is a TMP105 with a 16-bit Config register and a read-only
device ID.

New TMP105 qtest cases for the TMP1075, checking a migration round
trip.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
Emmanuel Blot (4):
      hw/sensor: tmp105: add the TMP1075 variant
      tests/qtest: tmp105: cover the TMP1075 device ID and reset defaults
      tests/qtest: tmp105: cover the TMP1075 config register width
      tests/qtest: tmp105: cover the Config low byte across a migration

 hw/sensor/tmp105.c              |  85 +++++++++++++++++++++++++++++-
 include/hw/sensor/tmp105.h      |   2 +
 include/hw/sensor/tmp105_regs.h |   5 ++
 tests/qtest/tmp105-test.c       | 111 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 202 insertions(+), 1 deletion(-)
---
base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
change-id: 20261105-sensor-tmp1075-4a7422630bb4

Best regards,
--  
Emmanuel Blot <emmanuel.blot@free.fr>


