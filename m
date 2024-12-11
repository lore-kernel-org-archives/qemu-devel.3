Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3A5E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZQ-0004De-0E; Wed, 11 Dec 2024 11:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZL-0003ca-DQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZI-0000PK-C8
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCv89ZfoHZZZqkAW0Dj5w3dxVYgBc6W+jr38uHvg65c=;
 b=h6GfCTbMMpTc5cGOWeRxI6q7ihnfkxZy87uy0iXlmcxzcFWoj+9X3EhE1zEkxWuUHG/LOE
 ncyn2wZuSCaWoI2ZO8IDJu/OW9wZ0I76OldU0GfQcaqJDW7LDk1YXR/0Jtg2OzNzqzcnIe
 SSy+JF4xcg4RWxfvS5oeO+KiO5BzXQE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-HInfmtxIPkeHztmLDToxlA-1; Wed, 11 Dec 2024 11:28:05 -0500
X-MC-Unique: HInfmtxIPkeHztmLDToxlA-1
X-Mimecast-MFC-AGG-ID: HInfmtxIPkeHztmLDToxlA
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5d40c0c728aso2481671a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934484; x=1734539284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCv89ZfoHZZZqkAW0Dj5w3dxVYgBc6W+jr38uHvg65c=;
 b=wyPIh7a2e4tTj5eWB4BMhCSUUUcDDwW8HhjEckHOHiyJITu1MyFsivyBLtWLSRUjXc
 hXifhEY10HjExFz1UDRei8XsnLDcTvIQ4PjksCgmpdbaQiTWkjEwa0O7G1ckqi4NKr8S
 /hcaD5GTb1jQQGJxfksqin5Mzyj+afR7IrFyHrdQrQzlc0EY4sKdNSEOzVpL5sdlpLAV
 BgX9RXcl08TAcXxfeRNVVUNm7BgymizsLq2aVbbLYYtjTyKrarbuiDw0wvGNoiLnTAGl
 njqyvHooNnCzL890wcfVboVUxXjwGYMiG1YEdVnCbD1wl9yrmOUXlYfzJjBw+hJC5v3c
 SWMw==
X-Gm-Message-State: AOJu0YzAXV6gi4rYIT9Lh4WNeB/9r1j+H8oJitOUjvNgiGE8p9/l8ugi
 eLYZeCjkh3qWd1WRlNFJqlkN4A/rPf51Yu3A87zimZSxLEV788wKvqIhAsZu3L/P9eq5FvxgooX
 2qD5rHWB8eFhpI8rbS2GwSpBndEtlGXV0Ea6Y+vo6KgMN6qeuQPzlXWyseSGq6xETmGBzwBM1PT
 fXixmwMcuyy0aWCaFWEcCHCrJRT/2DxdYGbJvN
X-Gm-Gg: ASbGnctn6X/jD1VSdW1e1mZ5C5qHUAota8XMSWAAUeBfs17LZRVVwpb9jmGFVCMljoi
 4DDWPDPyyURRfotDmTz+1vgBtmfmx1dva0qs9IlstjE2ANFPykMUva5FYN7u/P7GHZuY97cGOP7
 T1VOqUiZ5OONTnmvUFy4C738ZdymtOWgTUteOwo1xLeB49J5kV6Ets+R/qr29rqpXYJ8qCcFrVY
 lBUPUPQojTv67SeIpcyg9Hbi725h0MrDt9Ut9oppsD8n8g4xOSt7fb0
X-Received: by 2002:a05:6402:2807:b0:5d2:7270:6128 with SMTP id
 4fb4d7f45d1cf-5d43314cf97mr7828196a12.25.1733934484020; 
 Wed, 11 Dec 2024 08:28:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUtC2+/Wx3qfxjhswpuOMWQKWdituT50dTL3K3ZOBNrtdiGdhr+r2NZ/g/OHHz5DwxH7mFxw==
X-Received: by 2002:a05:6402:2807:b0:5d2:7270:6128 with SMTP id
 4fb4d7f45d1cf-5d43314cf97mr7828086a12.25.1733934483079; 
 Wed, 11 Dec 2024 08:28:03 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3ebbd67c0sm5836516a12.46.2024.12.11.08.28.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/49] clock: treat outputs and inputs the same in
 NamedClockList
Date: Wed, 11 Dec 2024 17:26:46 +0100
Message-ID: <20241211162720.320070-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev-clock.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index ca65685c04e..2f9d6cb7579 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -48,14 +48,6 @@ static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
     if (clk == NULL) {
         clk = CLOCK(object_new(TYPE_CLOCK));
         object_property_add_child(OBJECT(dev), name, OBJECT(clk));
-        if (output) {
-            /*
-             * Remove object_new()'s initial reference.
-             * Note that for inputs, the reference created by object_new()
-             * will be deleted in qdev_finalize_clocklist().
-             */
-            object_unref(OBJECT(clk));
-        }
     } else {
         object_property_add_link(OBJECT(dev), name,
                                  object_get_typename(OBJECT(clk)),
@@ -84,7 +76,7 @@ void qdev_finalize_clocklist(DeviceState *dev)
 
     QLIST_FOREACH_SAFE(ncl, &dev->clocks, node, ncl_next) {
         QLIST_REMOVE(ncl, node);
-        if (!ncl->output && !ncl->alias) {
+        if (!ncl->alias) {
             /*
              * We kept a reference on the input clock to ensure it lives up to
              * this point; it is used by the monitor to show the frequency.
-- 
2.47.1


