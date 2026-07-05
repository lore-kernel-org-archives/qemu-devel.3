Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F08C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwp-0005ym-Hk; Sun, 05 Jul 2026 10:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwo-0005xY-3a
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwm-0001SC-QV
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D9F4wIuw/hWCTmZxs9cVla3JXisKf8d26stym2rmfd4=;
 b=homFobUpgZj0GjPBot+Mp2WJVgbHvUGwm7dbffZrGrZLFnCr9IT4J1HhE9++eZb3RtusqH
 g8hiorSIRWTogDDFdV9nRUw7xgTdkTI81nSYTGzC9larrrQwR9v1pL92L3Mz61lijTGz+0
 fTHus+rvrjy6Z5YeJalZYf3g52nazmc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-HlJiBkieMraTv3I7h7KarA-1; Sun, 05 Jul 2026 10:35:50 -0400
X-MC-Unique: HlJiBkieMraTv3I7h7KarA-1
X-Mimecast-MFC-AGG-ID: HlJiBkieMraTv3I7h7KarA_1783262150
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47127ee7e07so1397663f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262149; x=1783866949; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D9F4wIuw/hWCTmZxs9cVla3JXisKf8d26stym2rmfd4=;
 b=VTDMhpjg3HfjpGQ3VUK0OAX66aBgNVNmQIkyg+b9eY9/B1um1fu7t5awZabWOp4zd3
 7oBkX4UP5uFOrFsENKScMFW5IRhU9HyOIE8LRfryWcHDJJo/ubDhP1q9O2CYnmpJ89pf
 fHDA5UQJmg3l5gbL4Ost0E33Mki9YCyY1akn838jBpjsAs3hym2iDH6/yLGW85oISUMY
 NaVNkw7MmdjV7nwKZnvK+7KGUkjyPRq8Fmw3XHncjg4lfMw0tQUs6zp925a0N9lFTP7R
 5EnSCCDOWmlHCOW9Rqdh52BsNhqkR3lCK+vnafkfZ/yQrrKnxLjCxYxO/h5q/6dpqBJS
 4NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262149; x=1783866949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D9F4wIuw/hWCTmZxs9cVla3JXisKf8d26stym2rmfd4=;
 b=r6feRvOii9K0yCBlQbZjCZfUEpauliLBXxH29U+zReS3PigZUkoBap7bdL0UDbxeNo
 GWqdvhrxpQ49QE6iglxZdd2ZkqKuHNMaPgLEvx7yqLUM6L9lGU+us/R4bxd/gYOXxRbK
 FI/1h1dbq5g6J9QW95WEWcYu/DuNchuWyTOS1ZsbF19xWL0dZWOE/dkwIzI57QiVmke7
 ARKDopo+FFCaVTYcVP7VK+rk3RQblMq2rKAsc6bWd6N1Upnq4Hl/EWByVFWZSZPZTev9
 nRntjE5YOzfCimP68bLdttmyuDdyaECqevVT7YjBIkQfZlVAbumxI0y4Qpw/9nBrBu3Z
 XHPg==
X-Gm-Message-State: AOJu0YwZFHJwGVkNi3Uj5n+8MaSFbOjtibGAmhgs6AtbplECjlnJQfKb
 s4ilLdia3XKnkk/Rvl+NXKbScrS8cpm11Va8SEv+p9wzGLp2kAt4zD80PDg5oebeVaPTLZ/Itli
 cew13Q7Y/YQmIksd8hk47g1vFYzX1OhMNvNStKskq5hCst2RBw3Pz/ifcbjW94b9fKcjEaH/f4S
 Kz7t79SbDr6oiYDEeauO4EbLkgBo/Oz53Q9Q==
X-Gm-Gg: AfdE7cnZpiJFpP3dZuFgQcSKwqe412lRebwaRwkuo8LElQfmu5jzkubjT1DAPYsFOdd
 vRsi+uv3zcZzCGZvMa6TlqxxoNSrqBifH2OV4Aw8Pg+1vUWe49BLgqtS/H6fyYErbsxVG41qb0H
 +j3RIeVB/y/r83Dp2/0Y0WrqNLKmgPPL+AwPvG+IryxL0Dqq49aADl80vi2X9274tEM0g4g5Pom
 AgyMUcAN2Q1JcGXgpCXqj6BY6O2ZDR4cY7iKCjLH0mKSK0BU+LWYDZHmvE4lcSiC4FC9N7SDRlr
 FakjdDjzQHXyWHj7U9vyA2Z8FYkuRkWz2xQ17aaVwtMYCP6DL/wGDfA8WhOcjd7lnyv4GZVVI5m
 EBdLuUcPMVY9HtX/NZADk8hl4GGaswm4P
X-Received: by 2002:a05:6000:4203:b0:464:8d68:618a with SMTP id
 ffacd0b85a97d-47aaaec0251mr7609422f8f.32.1783262149483; 
 Sun, 05 Jul 2026 07:35:49 -0700 (PDT)
X-Received: by 2002:a05:6000:4203:b0:464:8d68:618a with SMTP id
 ffacd0b85a97d-47aaaec0251mr7609392f8f.32.1783262148931; 
 Sun, 05 Jul 2026 07:35:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f21328sm16705681f8f.32.2026.07.05.07.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:48 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PULL 27/44] arm: sbsa_gwdt: fixup default "clock-frequency"
Message-ID: <8e1aee6db42122cd1f781bf6048103fc76436c41.1783261895.git.mst@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Comment about keeping legacy freq, is wrong to begin with
(should be 62.5MHz), but that value also doesn't make
sense anymore as the watchdog is used only by un-versioned
SBSA board and the later has hard-coded it to 1GHz.

Other potential user (arm/virt) also has system clock at 1GHz.

Drop misleading comment about legacy and set default to 1GHz
to match both boards. (not that it does matter, since users are
setting frequency to match CPU's one explicitly)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260702145856.1539572-2-imammedo@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 7ade5c6f18..b739a3ce3c 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -264,11 +264,10 @@ static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
 static const Property wdt_sbsa_gwdt_props[] = {
     /*
      * Timer frequency in Hz. This must match the frequency used by
-     * the CPU's generic timer. Default 62.5Hz matches QEMU's legacy
-     * CPU timer frequency default.
+     * the CPU's generic timer.
      */
     DEFINE_PROP_UINT64("clock-frequency", struct SBSA_GWDTState, freq,
-                       62500000),
+                       1000000000),
 };
 
 static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
-- 
MST


