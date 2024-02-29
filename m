Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE83C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 03:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfWuI-0007g7-0o; Wed, 28 Feb 2024 22:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfWuE-0007fM-HA
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:16:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfWuC-0003G7-QP
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709176578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HYUG9CpoanHxHNY5VaNpDDXU+kaUHhD02RcUgHHGqtg=;
 b=cNx3AiNocdrT8D2jTf18NSyHbLkyFuOdjfMHesV8iUqYKaohsdha6VRFnQ6Wuuf5i3CCI4
 Acsw2wuqCfOD7g3RLzh7XvjaxEqH0MyyAD+hS5Sak77/heHT+olRVIN6pNymtjk5iMzPsr
 JQl/c3k6blUE6y09O+CrxpIho9odXdk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-kLInEPaHODeazOyH-JZaiw-1; Wed, 28 Feb 2024 22:16:16 -0500
X-MC-Unique: kLInEPaHODeazOyH-JZaiw-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so27773a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 19:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709176576; x=1709781376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYUG9CpoanHxHNY5VaNpDDXU+kaUHhD02RcUgHHGqtg=;
 b=oInMgz0nn1ywWHkFK+FuCyyHKBhpJ5/Xtdn2Bu7wV/s86o2/MDI3k68+J5/iAxbym8
 lG8vdA0QlOPq+Qpy8X9+p9nmtSR5kuvH6m/9RxWvSvWWCWkmrY5wW6mvVulKtHn+zlzq
 lxSAE+7kMD44PoGgyUO9kL68Fh+ExH/hSTyv2Cc2571TOPoRMbYMWkeE0CDZ2ZoN1eOY
 zypU6+vdwJQOE9c4fSJfRh85mi/D9Zp0yKvg7TR2eJkevgcVG7N/OzrHlJxiBEjSjqNb
 fHeaq5M4VIqY1aHX9h2Cn8R2jCimtCrRPovGxqh1VooB4r1PXdg04gRpqutuQXxIpR/2
 nRpQ==
X-Gm-Message-State: AOJu0YzZxnFYI3JD4DvFVV4XOqq9YYIHlqrrtGZxEoje4wNb8nbCiouF
 isyB8o1WaYVviIbcthiYoQeK0iSUclmCfM4V01CyIMZ9yNyXAlEj0M7R6eXGk3d6F0gi6D8R1TE
 rZdOY0EEsAgR2Dush35iXF1rgOzRManvvLNhRD67xF4wQ6yB67LSS
X-Received: by 2002:a05:6a20:8e28:b0:1a1:1e8e:3bb7 with SMTP id
 y40-20020a056a208e2800b001a11e8e3bb7mr1166598pzj.5.1709176575705; 
 Wed, 28 Feb 2024 19:16:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOCwlRaKGKcBBwv0xpeookTat03d1c2Jn6OqJnEmrBNklQPCxD8AHELbRSnyoc2f5dt2HKng==
X-Received: by 2002:a05:6a20:8e28:b0:1a1:1e8e:3bb7 with SMTP id
 y40-20020a056a208e2800b001a11e8e3bb7mr1166576pzj.5.1709176575193; 
 Wed, 28 Feb 2024 19:16:15 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 lh6-20020a170903290600b001dc23e877c1sm192821plb.265.2024.02.28.19.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 19:16:14 -0800 (PST)
Date: Thu, 29 Feb 2024 11:16:02 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 19/23] migration/multifd: Prepare multifd sync for
 mapped-ram migration
Message-ID: <Zd_28lPa5Uq9Kaw2@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-20-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228152127.18769-20-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 28, 2024 at 12:21:23PM -0300, Fabiano Rosas wrote:
> The mapped-ram migration can be performed live or non-live, but it is
> always asynchronous, i.e. the source machine and the destination
> machine are not migrating at the same time. We only need some pieces
> of the multifd sync operations.
> 
> multifd_send_sync_main()
> ------------------------
>   Issued by the ram migration code on the migration thread, causes the
>   multifd send channels to synchronize with the migration thread and
>   makes the sending side emit a packet with the MULTIFD_FLUSH flag.
> 
>   With mapped-ram we want to maintain the sync on the sending side
>   because that provides ordering between the rounds of dirty pages when
>   migrating live.

IIUC as I used to comment, we should probably only need that sync after
each full iteration, which is find_dirty_block().

I think keeping the setup/complete sync is fine, and that can be discussed
separately.  However IMHO we should still avoid the sync in
ram_save_iterate() always, or on new qemu + old machine types (where
flush_after_each_section=true) fixed-ram could suffer perf issues, IIUC.

So I assume at a minimum below would still be preferred?

@@ -3257,7 +3257,8 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 out:
     if (ret >= 0
         && migration_is_setup_or_active(migrate_get_current()->state)) {
-        if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
+        if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
+            !migrate_mapped_ram()) {
             ret = multifd_send_sync_main();
             if (ret < 0) {
                 return ret;

> 
> MULTIFD_FLUSH
> -------------
>   On the receiving side, the presence of the MULTIFD_FLUSH flag on a
>   packet causes the receiving channels to start synchronizing with the
>   main thread.
> 
>   We're not using packets with mapped-ram, so there's no MULTIFD_FLUSH
>   flag and therefore no channel sync on the receiving side.
> 
> multifd_recv_sync_main()
> ------------------------
>   Issued by the migration thread when the ram migration flag
>   RAM_SAVE_FLAG_MULTIFD_FLUSH is received, causes the migration thread
>   on the receiving side to start synchronizing with the recv
>   channels. Due to compatibility, this is also issued when
>   RAM_SAVE_FLAG_EOS is received.
> 
>   For mapped-ram we only need to synchronize the channels at the end of
>   migration to avoid doing cleanup before the channels have finished
>   their IO.

Did you forget to add the sync at parse_ramblocks() for mapped-ram?

> 
> Make sure the multifd syncs are only issued at the appropriate times.
> 
> Note that due to pre-existing backward compatibility issues, we have
> the multifd_flush_after_each_section property that can cause a sync to
> happen at EOS. Since the EOS flag is needed on the stream, allow
> mapped-ram to just ignore it.

Skipping EOS makes sense, but I suggest do that without invalid_flags.  See
below.

> 
> Also emit an error if any other unexpected flags are found on the
> stream.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - skipped all FLUSH flags
> - added invalid flags
> - skipped EOS
> ---
>  migration/ram.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 18620784c6..250dcd110c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1368,8 +1368,11 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>                  if (ret < 0) {
>                      return ret;
>                  }
> -                qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> -                qemu_fflush(f);
> +
> +                if (!migrate_mapped_ram()) {
> +                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> +                    qemu_fflush(f);
> +                }
>              }
>              /*
>               * If memory migration starts over, we will meet a dirtied page
> @@ -3111,7 +3114,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>          return ret;
>      }
>  
> -    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
> +    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
> +        && !migrate_mapped_ram()) {
>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>      }
>  
> @@ -3334,7 +3338,8 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          }
>      }
>  
> -    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
> +    if (migrate_multifd() && !migrate_multifd_flush_after_each_section() &&
> +        !migrate_mapped_ram()) {
>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>      }
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> @@ -4137,6 +4142,12 @@ static int ram_load_precopy(QEMUFile *f)
>          invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
>      }
>  
> +    if (migrate_mapped_ram()) {
> +        invalid_flags |= (RAM_SAVE_FLAG_EOS | RAM_SAVE_FLAG_HOOK |
> +                          RAM_SAVE_FLAG_MULTIFD_FLUSH | RAM_SAVE_FLAG_PAGE |
> +                          RAM_SAVE_FLAG_XBZRLE | RAM_SAVE_FLAG_ZERO);

IMHO EOS cannot be accounted as "invalid" here because it always exists.
Rather than this trick (then explicitly ignore it below... which is even
hackier, IMHO), we can avoid setting EOS in invalid_flags, but explicitly
ignore EOS in below code to bypass it for mapped-ram:

@@ -4301,7 +4302,12 @@ static int ram_load_precopy(QEMUFile *f)
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
             if (migrate_multifd() &&
-                migrate_multifd_flush_after_each_section()) {
+                migrate_multifd_flush_after_each_section() &&
+                /*
+                 * Mapped-ram migration flushes once and for all after
+                 * parsing ramblocks.  Always ignore EOS for it.
+                 */
+                !migrate_mapped_ram()) {
                 multifd_recv_sync_main();
             }
             break;

> +    }
> +
>      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>          ram_addr_t addr;
>          void *host = NULL, *host_bak = NULL;
> @@ -4158,6 +4169,13 @@ static int ram_load_precopy(QEMUFile *f)
>          addr &= TARGET_PAGE_MASK;
>  
>          if (flags & invalid_flags) {
> +            if (invalid_flags & RAM_SAVE_FLAG_EOS) {
> +                /* EOS is always present, just ignore it */
> +                continue;
> +            }
> +
> +            error_report("Unexpected RAM flags: %d", flags & invalid_flags);
> +
>              if (flags & invalid_flags & RAM_SAVE_FLAG_COMPRESS_PAGE) {
>                  error_report("Received an unexpected compressed page");
>              }
> -- 
> 2.35.3
> 

-- 
Peter Xu


