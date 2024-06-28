Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C92C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPa-0005c2-Nb; Fri, 28 Jun 2024 13:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPY-0005aC-EM
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPT-0002BA-1K
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyxEzNGqoXJbFXc5PayVB6u8Z/13e83iLysZlGsVNCM=;
 b=WPtVen55qqrwatJ+4xL5pFhAK+A0NakJw74tfiduBDjLwpzi/GGkhApdRouqfD+aoVcLz5
 5cLv3fitwsAigPYlsyo++N7aglBy60ZAAnf8aRCoVu2Qqh44f21S3szyaEeapufIsl2Owd
 J/YqIA1dxyBZOSjFsle7BC2OmXsx1hY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682--F-wRyZHMbCgr62368sGDg-1; Fri, 28 Jun 2024 13:29:15 -0400
X-MC-Unique: -F-wRyZHMbCgr62368sGDg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-584ef6c00c0so2653961a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595754; x=1720200554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyxEzNGqoXJbFXc5PayVB6u8Z/13e83iLysZlGsVNCM=;
 b=s1r6bm25TzHHF/EYIWsaReLt+s/T3zOSPzPCFpZ+25AZCH4XP5bxqFTUFVl4tTHSen
 rEnF8khqjUNEGMn7dUcuTPbniUpDbMI/+S+iDrdRzFpmOXp3QGJhgEmX2Owgj+c8VXXI
 7W4HCfcHEEl1ZMcgJMPezoMxRIky8f77OrYtlmtWO/ryswJwoTRkFbTmxVnNS4AjUpSW
 2bnROAR6ZkYXtdVdOFFHorG4usAneNSbLebdqiBLRdKA+LX0NPB8FLpcS5P0bDU5QoRk
 2MtMwz1uQsy3ikuEXsY9GWc5cno6ETt6jcclbpDOFOzy0S3AEKH67LGOg5ngD0yEmbX5
 dtZw==
X-Gm-Message-State: AOJu0Yz0/OPaoyaN7+ZSxl6bxwWZrZ6qWEJCN6xsVBv9dNx2Ub6Otaet
 NP7nxRbAICH38KLKng9FnpgX/TTiFctl07IurrVwSyHiad9R30aFwFWyILhE8D1YM3YZlah5Ge8
 h6YrX5e1OkKOpka2e7QEIGqBrO87YgrGvodt3NvALQAF61f09sZxvy/0yvECqnpE9y+nju8wrXZ
 67PRZHtSxNZYWf3WCgvrG4OqK4rDD14x4OrVVG
X-Received: by 2002:aa7:d7c2:0:b0:57d:4396:6085 with SMTP id
 4fb4d7f45d1cf-5865da42a99mr1622900a12.19.1719595754131; 
 Fri, 28 Jun 2024 10:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJfpDZOPsxn2eXDHKA1scV4PS31pnXZO508MLJNHaZr2sVPtrWV+cG0q4Q+IHSseHG8zHuaA==
X-Received: by 2002:aa7:d7c2:0:b0:57d:4396:6085 with SMTP id
 4fb4d7f45d1cf-5865da42a99mr1622888a12.19.1719595753842; 
 Fri, 28 Jun 2024 10:29:13 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861012371esm1294794a12.0.2024.06.28.10.29.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/23] block: do not check bdrv_file_open
Date: Fri, 28 Jun 2024 19:28:40 +0200
Message-ID: <20240628172855.1147598-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


