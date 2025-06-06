Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597FFC5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNYbq-0002VE-5U; Fri, 06 Jun 2025 11:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNYbo-0002UE-MF
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNYbl-0005d4-UQ
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749222228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r87iIoHCj+uPpvMRVjqA6ckhLdJfscRFr6C1qLT91lY=;
 b=fajLNOxJZukHFihjOWb74VRz4udvYQOAmKQDSEiwpyGlL2EXciYO1ZZ6Me915OSKeYtnxs
 /TJlDCJofs9P7ANra1eVRcDen+FWi1nNgNFyPkYyRMq9cSdVY+gR5zxkabIlLvQNcjIm11
 l1PtSiRq74fA1KvrkxxgJPF9PpGn6I0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-kretdHDFO2GKa5lQRPD1Wg-1; Fri, 06 Jun 2025 11:03:45 -0400
X-MC-Unique: kretdHDFO2GKa5lQRPD1Wg-1
X-Mimecast-MFC-AGG-ID: kretdHDFO2GKa5lQRPD1Wg_1749222225
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a43c1e1e6bso42012511cf.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 08:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749222225; x=1749827025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r87iIoHCj+uPpvMRVjqA6ckhLdJfscRFr6C1qLT91lY=;
 b=idfHeJ/wFiZmsnAMzVji3I7CZy5SDWAPPqqq9u6Ebedeiq3dwntOY6daS7lVzLasxh
 SV96yfx2yrJmzw+7LD2FulbLsG5DAM6CDvZf7pG+NpA4+rqHdSlSrnKYBFwdgoupCXmT
 G3P8CNt/KgxRKNretG0xJMin/QQxsk6to96xKrZinU0LaqeuTgeXyM/sFgadqtw6Q0lq
 Z9JpUFUeOE7U+9Jcwm91cx7Pi0558pINyRshyAwBz2p5fX8kOpLl7wAmrprEfG5Y8lbl
 eulsfamcajeYox0kPw6saoV7Th6hduebrVYZdzBs2z3n7REnajob1jqSrRVlOP67MzRS
 cgqQ==
X-Gm-Message-State: AOJu0YwOMDhHaYn/WUT9+LWvb2gcqYumlZWgFKlDwseFDKhYbdjSHtjA
 6vKLNUbr9kPMWg0nAlW6hAsRhsM+rdAYG0o4t4vSbz2aDKktKH+zlDuANscP9ojLJn6NC6YgrPa
 sO2DOOF8MmiEe5n56lTI+R38JNVmjyL2xfO0SVNu/L7O2k3itTmhNFaEb
X-Gm-Gg: ASbGncs7nIlX32gUv5nkU4q81hX+ncVm8X4tDhrnDzO515ZKOeOz3Cy0iFtxNcPr22f
 pUwcPmFzpGDw0xi3F62mh1tt8Qu3VW8k1f5ZE4gRaiIXDd/gLcD6/QdcPMcX61e1Kqc8QdlskSB
 QV6s1jEhTXUOzfyFVJ9/Nmui6rLk6Yci2ZWYWmN/arGMB7ODEt12uY4Puw9ueHdt/LM+9CMM9ds
 tbYh8o/jdwnGSx4Sk8JycOwrOt7qFmPzfreN/Qew4KD4Z66tQnNSb2zxEHIB5xgVRVwohJdg1NW
 3tm1H06WZnVr7A==
X-Received: by 2002:a05:622a:400e:b0:4a4:2d36:51d8 with SMTP id
 d75a77b69052e-4a5b9e38af4mr61585471cf.22.1749222225257; 
 Fri, 06 Jun 2025 08:03:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/EFqWNbhBmG8KuA3jL9uaJdJgX3slmR30bLVOd9ljYg8b5VdGfnlioLU3dDWaR1YgB5LlDA==
X-Received: by 2002:a05:622a:400e:b0:4a4:2d36:51d8 with SMTP id
 d75a77b69052e-4a5b9e38af4mr61585061cf.22.1749222224795; 
 Fri, 06 Jun 2025 08:03:44 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a61117dc98sm13878791cf.35.2025.06.06.08.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 08:03:44 -0700 (PDT)
Date: Fri, 6 Jun 2025 11:03:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 05/21] migration: Add a flag to track
 block-bitmap-mapping input
Message-ID: <aEMDTl7yaDGSv33I@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 02, 2025 at 10:37:54PM -0300, Fabiano Rosas wrote:
> The QAPI converts an empty list on the block-bitmap-mapping input into
> a NULL BitmapMigrationNodeAliasList. The empty list is a valid input
> for the block-bitmap-mapping option, so commit 3cba22c9ad ("migration:
> Fix block_bitmap_mapping migration") started using the
> s->parameters.has_block_bitmap_mapping field to tell when the user has
> passed in an empty list vs. when no list has been passed at all.
> 
> However, using the has_block_bitmap_mapping field of s->parameters is
> only possible because MigrationParameters has had its members made
> optional due to historical reasons.
> 
> In order to make improvements to the way configuration options are set
> for a migration, we'd like to reduce the usage of the has_* fields of
> the global configuration object (s->parameters).
> 
> Add a separate boolean to track the status of the block_bitmap_mapping
> option.
> 
> (this was verified to not regress iotest 300, which is the test that
> 3cba22c9ad refers to)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.h | 7 +++++++
>  migration/options.c   | 6 +++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index d53f7cad84..ab797540b0 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -510,6 +510,13 @@ struct MigrationState {
>      bool rdma_migration;
>  
>      GSource *hup_source;
> +
> +    /*
> +     * The block-bitmap-mapping option is allowed to be an emtpy list,
> +     * therefore we need a way to know wheter the user has given
> +     * anything as input.
> +     */
> +    bool has_block_bitmap_mapping;
>  };
>  
>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
> diff --git a/migration/options.c b/migration/options.c
> index f64e141394..cf77826204 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -685,7 +685,7 @@ bool migrate_has_block_bitmap_mapping(void)
>  {
>      MigrationState *s = migrate_get_current();
>  
> -    return s->parameters.has_block_bitmap_mapping;
> +    return s->has_block_bitmap_mapping;
>  }
>  
>  uint32_t migrate_checkpoint_delay(void)
> @@ -989,7 +989,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->has_announce_step = true;
>      params->announce_step = s->parameters.announce_step;
>  
> -    if (s->parameters.has_block_bitmap_mapping) {
> +    if (s->has_block_bitmap_mapping) {
>          params->has_block_bitmap_mapping = true;
>          params->block_bitmap_mapping =
>              QAPI_CLONE(BitmapMigrationNodeAliasList,
> @@ -1469,7 +1469,7 @@ static void migrate_params_apply(MigrationParameters *params)
>          qapi_free_BitmapMigrationNodeAliasList(
>              s->parameters.block_bitmap_mapping);
>  
> -        s->parameters.has_block_bitmap_mapping = true;
> +        s->has_block_bitmap_mapping = true;
>          s->parameters.block_bitmap_mapping =
>              QAPI_CLONE(BitmapMigrationNodeAliasList,
>                         params->block_bitmap_mapping);
> -- 
> 2.35.3
> 

This is definitely unfortunate, and I'm still scratching my head on
understanding why it's necessary.

E.g. I tried to revert this patch manually and iotest 300 passed, with:

===8<===
From a952479805d8bdfe532ad4e0c0092f758991af08 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 6 Jun 2025 10:44:37 -0400
Subject: [PATCH] Revert "migration: Add a flag to track block-bitmap-mapping
 input"

This reverts commit fd755a53c0e4ce9739d20d7cdd69400b2a37102c.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 7 -------
 migration/options.c   | 4 ++--
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 49761f4699..e710c421f8 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -510,13 +510,6 @@ struct MigrationState {
     bool rdma_migration;
 
     GSource *hup_source;
-
-    /*
-     * The block-bitmap-mapping option is allowed to be an emtpy list,
-     * therefore we need a way to know wheter the user has given
-     * anything as input.
-     */
-    bool has_block_bitmap_mapping;
 };
 
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
diff --git a/migration/options.c b/migration/options.c
index dd2288187d..e71a57764d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -765,7 +765,7 @@ bool migrate_has_block_bitmap_mapping(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->has_block_bitmap_mapping;
+    return s->parameters.has_block_bitmap_mapping;
 }
 
 uint32_t migrate_checkpoint_delay(void)
@@ -1376,7 +1376,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
      * params structure with the user input around.
      */
     if (params->has_block_bitmap_mapping) {
-        migrate_get_current()->has_block_bitmap_mapping = true;
+        migrate_get_current()->parameters.has_block_bitmap_mapping = true;
     }
 
     if (migrate_params_check(tmp, errp)) {
-- 
2.49.0
===8<===

I'm staring at commit 3cba22c9ad now, looks like what it wants to do is
making sure construct_alias_map() will be invoked even if the block bitmap
mapping is NULL itself.  But then right below the code, it has:

static int init_dirty_bitmap_migration(DBMSaveState *s, Error **errp)
{
    ...
    if (migrate_has_block_bitmap_mapping()) {
        alias_map = construct_alias_map(migrate_block_bitmap_mapping(), true,
                                        &error_abort);
    }
    ...
    if (!alias_map) {
    ...
    }
}

Looks like it's also ready for !alias_map anyway.  I'm definitely puzzled
by this code.

Even if so, IIUC the question can still be asked on whether we can always
assume has_block_bitmap_mapping to be always true, then here instead of:

    if (migrate_has_block_bitmap_mapping()) {
        alias_map = construct_alias_map(migrate_block_bitmap_mapping(), true,
                                        &error_abort);
    }

We do:

    alias_map = construct_alias_map(migrate_block_bitmap_mapping(), true,
                                    &error_abort);

After all it looks like construct_alias_map() takes NULL too..

-- 
Peter Xu


