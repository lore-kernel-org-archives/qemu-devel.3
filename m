Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55521C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkIRA-0004rm-UR; Wed, 13 Mar 2024 02:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkIR7-0004pn-HH
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkIR5-0000KR-Ru
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710312599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=C0DcxDO3m2vtxwdKzv4jUJfjIm4ktk+IdMc2OXd8j08=;
 b=c0M1uaxXZs0JgVPhhu5uTGQQNNEYW88OxvrXSQcGMgMpoPfbv+5bEZm4hSdFwbFKA5FU/b
 +ys+1AgnWFo0xTLEmFkrF50vCUs9+53aQSGnIN83aa9hVAVjOC800hWbtqp5ICuSWrSbbm
 +B6VWS8Kkw2bp1kltEjcgYDSLMS5l9o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-0Sa1751WODyC7inV2y-kdQ-1; Wed, 13 Mar 2024 02:49:57 -0400
X-MC-Unique: 0Sa1751WODyC7inV2y-kdQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33e8b93b4efso1974062f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 23:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710312595; x=1710917395;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C0DcxDO3m2vtxwdKzv4jUJfjIm4ktk+IdMc2OXd8j08=;
 b=hhbgYNPD/odgcG4uQSIHHuxPPEjebbTOIDHsJ/WXO15OhPwWqGHK/yNIi2gOLv6pGz
 rs1/I0UvSM+7Fz126JvsRfDise7uADnQXP/8/NZZng6hmeligD/3sjOe6DhJGRrAaskv
 fgioMm662S/g3L/CQ7Boz8GOPJcdFpAwfYVya1A2yVbEqFsHcsndTRXanw2kG5JIiR2J
 fjC8osFZsi46bgdAm9S6WfZZryvIBHUeNujt92E70XucYdf6UsvjFTVqMjrW7eXUAxi0
 bl6Bzfc1+0pDpiJroF/5cWM3CNqqTwQtjrHtnfrMt9TowO0bx/DePplDp5Md5PFVyyKv
 JImw==
X-Gm-Message-State: AOJu0YwFx29oi4wxELEjJ2r8Iv+BE49WEzfh3mvYV8RGiSv/YIxjGF1K
 fgBmWiF0j9jU26dxfF5nJz+v0goz1cdvIVBl/JH4vbLw16EpkLln+/B4+Evy7gJ2f05M/4+djvK
 cNexqFmakFrVJJ2n+Fy1r2VrfqUm21gCPNKnQrNqDO7fIxKLpHXJJL9KV6GB9+yGIyntWxdDOc/
 qbQwpYKMhJV6Ik54Lp8oc6htIgic33GA==
X-Received: by 2002:a5d:4a08:0:b0:33e:a04a:ccca with SMTP id
 m8-20020a5d4a08000000b0033ea04acccamr943887wrq.30.1710312595671; 
 Tue, 12 Mar 2024 23:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJzkDe5Zid9gEgain8RTbig0QzuJeMfXDxt9w4qLQ9029heCjRPlNC38IW7FDmr237EyCsKw==
X-Received: by 2002:a5d:4a08:0:b0:33e:a04a:ccca with SMTP id
 m8-20020a5d4a08000000b0033ea04acccamr943873wrq.30.1710312595184; 
 Tue, 12 Mar 2024 23:49:55 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 ay2-20020a5d6f02000000b0033d9f0dcb35sm563104wrb.87.2024.03.12.23.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 23:49:54 -0700 (PDT)
Date: Wed, 13 Mar 2024 02:49:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Felix Wu <flwu@google.com>, Nabih Estefan <nabihestefan@google.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH repost] SMBIOS: fix long lines
Message-ID: <d62c5fcd4df119ecfb64a17753de75ca920c78d3.1710312575.git.mst@redhat.com>
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

Fixes: 04f143d828 ("Implement SMBIOS type 9 v2.6")
Fixes: 735eee07d1 ("Implement base of SMBIOS type 9 descriptor.")
Cc: "Felix Wu" <flwu@google.com>
Cc: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
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


