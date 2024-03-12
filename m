Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6696FC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAeF-0006T8-V5; Tue, 12 Mar 2024 18:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcx-0004Wk-CU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcw-0004h0-24
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=9rpR2mubP+HGapvPEtzweij3vxVaeaCtxnw4CpB2h9c=;
 b=VsE6TvgrbFSwFYi5Mh6vbPuajF0PNbYK0yB3DmUitI5ZNsGUmE0yn+i7fW0lDQ9uXkRuO2
 Of3yzKwQMFUAkfQP0Zn1xyW4YPP1DQV7Lx12Z/YvF3n6rmGlc2WdaVIW07fGBTf+YOYrXd
 YK9isQWsfP/txG8NQrnPWYNOtnb6/8U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-8weMgKyqOCm16VEHX3g5Fw-1; Tue, 12 Mar 2024 18:29:38 -0400
X-MC-Unique: 8weMgKyqOCm16VEHX3g5Fw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-568653cff80so1460550a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282576; x=1710887376;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9rpR2mubP+HGapvPEtzweij3vxVaeaCtxnw4CpB2h9c=;
 b=BwEPOAWUZXhU6wlkkUok9bejTLxpwowT0scuExmLultETcHvodogF6k7vhvxCzZW5q
 fDs6s/HqBfYCOgQJrdmGxGQ3ZFg89kgBupSJsya/64DDQTZoBTGuzjEatsDAn3l7huQL
 WpLnQ5VYcwsiDrVzOcfkhluk+PmZZHZ9bK50mv0thPGG9Rcp/IdcgRNc2AnQ9UbTvlZ0
 5aKjloWCTtl8QkeGyLoL6sSlGjWtVDzDrQ8G5cvRWwsjG5lxWYt7ZDp9vEF1xppSTHuW
 m06USqjlh+ooTUne6+Dl1bVdfvW1GC8mnUSKL+C1awzdhpWGsYasJYz/CR57WQ9MY72P
 Kp3w==
X-Gm-Message-State: AOJu0YzVcp8BvLz/S+QAlR1+dysJNQU5vM6Vurg5TQcRbGqn3cKghHVe
 PwknQGsUUysg1bR2Y1SdXAlC/ejUvZKZ2TMcEjLVVZz8jZOiCzu/+wxBRkubBgLqfPDXXRl0+Kw
 fT7CScdbywm9OpW20FvMcGb5N8deRzKhDNIEbux7/jy0lzNFzHeaTX2MmErnhahNQY1+9+NBipS
 0QMnYnKaoomV7z4B/oc8lLVsmlxrzhzBQv
X-Received: by 2002:a05:6402:5c4:b0:564:5764:a5d8 with SMTP id
 n4-20020a05640205c400b005645764a5d8mr7410126edx.25.1710282576227; 
 Tue, 12 Mar 2024 15:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNwcoC1wlbA8vogIh3AblChCVBZlWTNhCTai/iAie5NblNY1vE0LjGN87M3A6dOOoe9jB21g==
X-Received: by 2002:a05:6402:5c4:b0:564:5764:a5d8 with SMTP id
 n4-20020a05640205c400b005645764a5d8mr7410109edx.25.1710282575742; 
 Tue, 12 Mar 2024 15:29:35 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 ev19-20020a056402541300b0056742460f68sm4271821edb.66.2024.03.12.15.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:29:35 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:29:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH] SMBIOS: fix long lines
Message-ID: <9bce53c4f7ffda8e4a49353902626702fa01e5a6.1710282571.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Break up long lines to fit under 80/90 char limit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index e3d5d8f2e2..949c2d74a1 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1592,12 +1592,15 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             t = g_new0(struct type9_instance, 1);
             save_opt(&t->slot_designation, opts, "slot_designation");
             t->slot_type = qemu_opt_get_number(opts, "slot_type", 0);
-            t->slot_data_bus_width = qemu_opt_get_number(opts, "slot_data_bus_width", 0);
+            t->slot_data_bus_width =
+                qemu_opt_get_number(opts, "slot_data_bus_width", 0);
             t->current_usage = qemu_opt_get_number(opts, "current_usage", 0);
             t->slot_length = qemu_opt_get_number(opts, "slot_length", 0);
             t->slot_id = qemu_opt_get_number(opts, "slot_id", 0);
-            t->slot_characteristics1 = qemu_opt_get_number(opts, "slot_characteristics1", 0);
-            t->slot_characteristics2 = qemu_opt_get_number(opts, "slot_characteristics2", 0);
+            t->slot_characteristics1 =
+                qemu_opt_get_number(opts, "slot_characteristics1", 0);
+            t->slot_characteristics2 =
+                qemu_opt_get_number(opts, "slot_characteristics2", 0);
             save_opt(&t->pcidev, opts, "pcidev");
             QTAILQ_INSERT_TAIL(&type9, t, next);
             return;
-- 
MST


