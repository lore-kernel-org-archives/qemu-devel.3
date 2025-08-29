Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D180CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNHD-0000Q9-U3; Sat, 30 Aug 2025 11:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryj0-0001KM-By
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryix-0008UL-2n
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PB8Kdz4Nrxog6Sfp7mK37/CRD+JP3mh8G1Sat8ExiCM=;
 b=bT4dPDCC6IhhpgBzqIYfoMhUTJ3KkZmYnYRcVFEv4WqqtEqG0gygO5aQxQnr8uovOPXjHu
 LFuAZeYh3Tavx17RhoBU3grsyG2zymAT95c4PA0GuDrGI0g9xj/yJ9rXBQj8NoWzVZJcLO
 HnR87eFGvSM/cVLUiPm0onLRr6Mvyq8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-jKls3dVzM1efA7WNxX-fNQ-1; Fri, 29 Aug 2025 09:00:55 -0400
X-MC-Unique: jKls3dVzM1efA7WNxX-fNQ-1
X-Mimecast-MFC-AGG-ID: jKls3dVzM1efA7WNxX-fNQ_1756472454
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0071c1so9717495e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472454; x=1757077254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PB8Kdz4Nrxog6Sfp7mK37/CRD+JP3mh8G1Sat8ExiCM=;
 b=v8zYHbg361OhRXowApa6VidJ02owLA4Lj9sQuvVIjZzuPoqB5fbEfOYgsA+MBdu+w3
 LBXHFnfEugvAs57DmSMpRlLp+pAZ42Qouu9fTfjk/X+imRlNATtwT10Ubhr+Lp1xOetS
 eL6nA/wVYCAWHmL2MnndMmmNitVW72zY8GRyT/QOVywMDLhQR45/Vx0tVxyKML5u18fU
 94GA4LeKrexEiZnTV8n32GuZTrey+29JJzeLx8DoMxjajYLwPRF4bSkmbskJ1b6feqrM
 sAtUT8ciyXu1BmY1/vv9Nd82nOxLM0n+DQHEHvRSRcusT1zphk3hhbC+wG8Cv3DXMqsx
 Puog==
X-Gm-Message-State: AOJu0YyfL9DsMiA14Hhq5ac1yte2BJJxw3f7baX9UNFjQ1mDOGUcsgu2
 sKaEJCUVaqaA3SFoi1WA5b5jO0M1RBa3XRhf88/mWhucR4UXHvAMriDMIGfYBKs6ZtUPfAAOEZ/
 U3MDlKYe9t0Bbn0nh9Y6LFFkRPcdF/co0TyI6EiW1QVW0o+JS4GD5AUrk2Gc/tCBSaHwWbtQIqe
 ed3rXnJB678U8geZ2Bu9yKgQB30p9OIvnuWBwuODpu
X-Gm-Gg: ASbGncs9tRzhsAtVk3rquZpR47+vVX3Er0CVZ//W0p0AQN44k0xLmExcTme9kDbZyhi
 0leC9thcvPwQjmTrZF3V7SOaKiwSjAfwWyPTKGjBjkiOpA6CpzESpxL8CsdMwsmo9JARN/sg+bZ
 bF9oDK4tYXOAucfSww1IFHvtZEdSKkuITC1eiPcWv+DcAaHWu4is337/z33Fl4mObvZC5AN5l92
 u6nesVhyYGZ7LF5nN5KNrzgU7oYdja/n9ec70r2b0N457x08imCWPSNA5DXl/ezQOagIQlVc18w
 0HCAMBPm/ym9HGV/uUE9t0QACA42fFdOD2P8LplqsN9k+lTlWSlQglkYQa7O2/88IZmOxWkrK+I
 i4L29X0Mpyb5EMoqGEV1T/Qe0c+miMccA2VrveSj2pSE=
X-Received: by 2002:a05:600c:4f12:b0:459:dde3:1a37 with SMTP id
 5b1f17b1804b1-45b66343ea2mr120077215e9.25.1756472453990; 
 Fri, 29 Aug 2025 06:00:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdGjxsOOQTmODX/yZn9S7o0GsDaexHFAVVO/87hJ0D90AUqtnb/U2S1+h/BoufocZvx4EpZw==
X-Received: by 2002:a05:600c:4f12:b0:459:dde3:1a37 with SMTP id
 5b1f17b1804b1-45b66343ea2mr120076775e9.25.1756472453487; 
 Fri, 29 Aug 2025 06:00:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f30fe02sm115179505e9.18.2025.08.29.06.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 23/28] acpi: mark PMTIMER as unlocked
Date: Fri, 29 Aug 2025 14:59:30 +0200
Message-ID: <20250829125935.1526984-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

Reading QEMU_CLOCK_VIRTUAL is thread-safe, write access is NOP.

This makes possible to boot Windows with large vCPUs count when
hv-time is not used.

Reproducer:
  -M q35,hpet=off -cpu host -enable-kvm -smp 240,sockets=4 -m 8G WS2025.img
fails to boot within 30min.

With this fix it boots within 2-1min.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/r/20250814160600.2327672-3-imammedo@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 58f8964e130..ff165828033 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -547,6 +547,7 @@ void acpi_pm_tmr_init(ACPIREGS *ar, acpi_update_sci_fn update_sci,
     ar->tmr.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, acpi_pm_tmr_timer, ar);
     memory_region_init_io(&ar->tmr.io, memory_region_owner(parent),
                           &acpi_pm_tmr_ops, ar, "acpi-tmr", 4);
+    memory_region_enable_lockless_io(&ar->tmr.io);
     memory_region_add_subregion(parent, 8, &ar->tmr.io);
 }
 
-- 
2.51.0


