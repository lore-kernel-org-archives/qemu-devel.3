Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12484C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7rE-0001Pb-6i; Wed, 15 Jan 2025 13:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7q2-00079U-SY
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7q1-0006hf-HH
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RHTNE/Bc8eGdf6kTlbv87G0muLfR26JlONo5ZPM2ySM=;
 b=A7I/1W398D1gxSxPk7oxBofdauRcq0exxRnWtsDhZLbjV4JWz+IsZ4+whJn/s2lysbbfxD
 scHF+nYONM7F6WELih1Tcj8vX1pitFtM9pCl/Ty+XvfJTu3oKV8oLTyEq1kKmuUTvXbZDM
 C2rV40mtfo3GNrwd4MByLhxAlxQtAL4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-lEuWqYc3OXSqYVMRTbmrxA-1; Wed, 15 Jan 2025 13:09:55 -0500
X-MC-Unique: lEuWqYc3OXSqYVMRTbmrxA-1
X-Mimecast-MFC-AGG-ID: lEuWqYc3OXSqYVMRTbmrxA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361efc9d1fso55873745e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964594; x=1737569394;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RHTNE/Bc8eGdf6kTlbv87G0muLfR26JlONo5ZPM2ySM=;
 b=OtrCq0XZ598evEWM2BJQ9Fgb2G0un5G05QIx1oQYsS1EiXGMVz0vxU9KStCzpCyT2I
 ZqcCOMMYM6jCjZTAt5ozf+M9LYT7yXBLXQ+yS81s2vjDsd+14oqVPxHgofpCLvgJCen7
 DhxYjTvQBZRfY+DC0b61KWmhOeJ8QHmBarl2SbFR3+gEeTNiEUW3cPhgwfagdfZ4GBzc
 jp/puVN14Pc+l8onscAgfUKh6HG58RGU4kMTy6U6IbaOIwiWQPPOj6m4LK1N1/WdbkEt
 GjBvqs2mbyDqJplH6MPtaj8lHm5hG81pQopdxmM05wM0mx3GuCzrjcuedF++go9ITSwp
 ceyQ==
X-Gm-Message-State: AOJu0YxxxPCfn/Xtshb87PqnF1DdMJ0p1nJwdXt5snNWWdWXeSfdyXJt
 0c2n5l5GDiOJltLW5D2kgijqMO8+kviSe770mttg2QOEs3fh7C8q/teIN0h/qAAtqTZEhDy+B76
 lFYJfjxeA9E1SgHgS3YWmJzTe858ks/DI0jSQoOJyxIiNQtnDGBHHJOElXuKATG+Y7xD7UdOV5F
 9EC8P/VOUVmA8AiurGwCzIqFAfna+U3g==
X-Gm-Gg: ASbGncuFaXKDfk56l9C83KslISNa/4lQiNxwM252hjWcLXqHk66WITF2tS1IDtUgzWv
 0xgT3Nd8hxigXF6P8N4yCFeGnU3ZfBO/o+VDrzPGtMkgUiGCMvPZHUnyDaXgHyujY4E2kmuuvVr
 CLegwTp9oIUITj64SDozplrDge57veSmHCvpjEevdjPns2LA4wXOP3V+s0AIAZt49b41SVbmV7d
 wLtf6q7S7xGtYSCmbYBC3zCfL5Jc8oHqVl1lmaeIqCufaet396w
X-Received: by 2002:a05:600c:348c:b0:436:ed33:1535 with SMTP id
 5b1f17b1804b1-436ed3316a4mr238301515e9.12.1736964593895; 
 Wed, 15 Jan 2025 10:09:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN0d0m/M2vuGpz4hpXzBa17IvDvti49mrimxefrd8mrPQ/jlMC4AkPI3JweRJ1mPlBP24UBw==
X-Received: by 2002:a05:600c:348c:b0:436:ed33:1535 with SMTP id
 5b1f17b1804b1-436ed3316a4mr238301275e9.12.1736964593479; 
 Wed, 15 Jan 2025 10:09:53 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753bee8sm31945585e9.34.2025.01.15.10.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:52 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 26/48] pci/msix: Fix msix pba read vector poll end calculation
Message-ID: <42e2a7a0ab23784e44fcb18369e06067abc89305.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

From: Nicholas Piggin <npiggin@gmail.com>

The end vector calculation has a bug that results in polling fewer
than required vectors when reading at a non-zero offset in PBA memory.

Fixes: bbef882cc193 ("msi: add API to get notified about pending bit poll")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20241212120402.1475053-1-npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/msix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index d8a55a6474..57ec7084a4 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -250,7 +250,7 @@ static uint64_t msix_pba_mmio_read(void *opaque, hwaddr addr,
     PCIDevice *dev = opaque;
     if (dev->msix_vector_poll_notifier) {
         unsigned vector_start = addr * 8;
-        unsigned vector_end = MIN(addr + size * 8, dev->msix_entries_nr);
+        unsigned vector_end = MIN((addr + size) * 8, dev->msix_entries_nr);
         dev->msix_vector_poll_notifier(dev, vector_start, vector_end);
     }
 
-- 
MST


