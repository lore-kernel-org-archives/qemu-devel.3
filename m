Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE388C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu3g-0000iM-AJ; Sat, 22 Jun 2024 02:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3P-0000Tb-Uz
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3O-0006Ui-D5
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719037009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyxEzNGqoXJbFXc5PayVB6u8Z/13e83iLysZlGsVNCM=;
 b=BUqRNG2p40UFt0RIA6fbfMaXaoACX3f5KBxzlIMvUUuIRNv6O3ThEKqM/Uky/oAo/j2op4
 YjhF5xRuCsvjkuBG065cRk4xhZ1y9ZwtUeUb8Is8nBWh8ogZWmwT+g4w7Q9IDe3ogk2rHO
 V9k58TsfNgNsCfgW5181QJeLkWp/tzg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-wx9eeHWoNKWAiKsczlwtuA-1; Sat, 22 Jun 2024 02:16:46 -0400
X-MC-Unique: wx9eeHWoNKWAiKsczlwtuA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7194d0fd53so3487066b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719037005; x=1719641805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyxEzNGqoXJbFXc5PayVB6u8Z/13e83iLysZlGsVNCM=;
 b=LP5t4CLAztgskgYAQRjPPMhpAgxh8JGJgd08CEhYtxFl9MhOUgLL7uKNDhQonMJ466
 /rGvht2rOia460229tFkJ4q+Q4t4Pf8hTI8B1HBeYYzjEEbL93XY1mks/HgTHcpEoW0N
 rLmLOenD1lpPpsxTX2jVI9wqaAIx76/KGVPAL6l8zuhuZNT+iKqCTXaZKfc0nbe4h04B
 Zwxr11p1GvXogYMSfVN9q/e/arEgXDKWs+VihYoH5GJUKKMm/6FOgLjwWIIsCXYLe/nL
 M3gJatfExWhn+SP3niJM0J/A0oP7Q0lg0fbN2D6YggCq3LVEX1zLLj6k7sgTHISYqltd
 Bpjg==
X-Gm-Message-State: AOJu0YzlrqVn2phcXE47/X1ZWHEzkKpYUrhfe8yhndGyj1F+yJ+mta8s
 joacBBk6vNq0JSl65pwH+RAwhUGSgSpP3AJASl4Wc+AhfE4pPBRiYfu6zIUcmVAl2A+q2YwNNBr
 dVcnYxE5BeF4/irMrr7bte/8EMZ9Xl/Ghzht0gkVqOhB5CHN2bC0hgogTZ3zkqX087duBfciCjr
 DGhROcMPC8xD67IHPVXkusaTfp4/wDiKc2/E7+
X-Received: by 2002:a17:907:8011:b0:a6f:11c9:f349 with SMTP id
 a640c23a62f3a-a6fab61c1f4mr562543866b.23.1719037004830; 
 Fri, 21 Jun 2024 23:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe9iBnRfv+ZELgaBbFnDqCv5mH6beg7rw3nilMQTrWV+HHH9G72Cwy273p4x/SZSVftn/nxA==
X-Received: by 2002:a17:907:8011:b0:a6f:11c9:f349 with SMTP id
 a640c23a62f3a-a6fab61c1f4mr562543266b.23.1719037004387; 
 Fri, 21 Jun 2024 23:16:44 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf4ba61asm157646166b.91.2024.06.21.23.16.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/23] block: do not check bdrv_file_open
Date: Sat, 22 Jun 2024 08:15:53 +0200
Message-ID: <20240622061558.530543-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The set of BlockDrivers that have .bdrv_file_open coincides with those
that have .protocol_name and guess what---checking drv->bdrv_file_open
is done to see if the driver is a protocol.  So check drv->protocol_name
instead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 69a2905178a..dd14ba85fc3 100644
--- a/block.c
+++ b/block.c
@@ -926,7 +926,6 @@ BlockDriver *bdrv_find_protocol(const char *filename,
     int i;
 
     GLOBAL_STATE_CODE();
-    /* TODO Drivers without bdrv_file_open must be specified explicitly */
 
     /*
      * XXX(hch): we really should not let host device detection
@@ -1983,7 +1982,7 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     open_flags = bdrv_open_flags(bs, bs->open_flags);
     node_name = qemu_opt_get(opts, "node-name");
 
-    assert(!drv->bdrv_file_open || file == NULL);
+    assert(!drv->protocol_name || file == NULL);
     ret = bdrv_open_driver(bs, drv, node_name, options, open_flags, errp);
     if (ret < 0) {
         goto fail_opts;
@@ -2084,7 +2083,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
         }
         /* If the user has explicitly specified the driver, this choice should
          * override the BDRV_O_PROTOCOL flag */
-        protocol = drv->bdrv_file_open;
+        protocol = drv->protocol_name;
     }
 
     if (protocol) {
@@ -4123,7 +4122,7 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
     }
 
     /* BDRV_O_PROTOCOL must be set iff a protocol BDS is about to be created */
-    assert(!!(flags & BDRV_O_PROTOCOL) == !!drv->bdrv_file_open);
+    assert(!!(flags & BDRV_O_PROTOCOL) == !!drv->protocol_name);
     /* file must be NULL if a protocol BDS is about to be created
      * (the inverse results in an error message from bdrv_open_common()) */
     assert(!(flags & BDRV_O_PROTOCOL) || !file);
@@ -5971,7 +5970,7 @@ int64_t coroutine_fn bdrv_co_get_allocated_file_size(BlockDriverState *bs)
         return drv->bdrv_co_get_allocated_file_size(bs);
     }
 
-    if (drv->bdrv_file_open) {
+    if (drv->protocol_name) {
         /*
          * Protocol drivers default to -ENOTSUP (most of their data is
          * not stored in any of their children (if they even have any),
@@ -8030,7 +8029,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          *   Both of these conditions are represented by generate_json_filename.
          */
         if (primary_child_bs->exact_filename[0] &&
-            primary_child_bs->drv->bdrv_file_open &&
+            primary_child_bs->drv->protocol_name &&
             !drv->is_filter && !generate_json_filename)
         {
             strcpy(bs->exact_filename, primary_child_bs->exact_filename);
-- 
2.45.2


