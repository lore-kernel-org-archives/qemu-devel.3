Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DEBC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVig-00053Q-L3; Mon, 26 Feb 2024 02:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reVid-0004zS-SX
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reVic-0006Zi-7i
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708933689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YBcvQEH2jGAVGu31FKNyyeqkHxIfXZQXIbmP2jzG+F0=;
 b=TOzQ9fv/kR/9mHbH8DUJpn4YnwlyFQMdBQXeV875mW5oU3iyivCR+tR27gO9V0zFP+Xx1s
 FMWQm+ymzHeYZ31Nw/XGG0isUpEqdO+28J+Yy5maHH0RSTFmoHrGBmrYGps2l52zvyqtAb
 b1+L7LbOxWsl3sJGTfp19LPP1CnGQ0g=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-P6-qHNxBPGi8VQGwo-EVYg-1; Mon, 26 Feb 2024 02:48:07 -0500
X-MC-Unique: P6-qHNxBPGi8VQGwo-EVYg-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5a09744e5d3so63843eaf.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 23:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708933686; x=1709538486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBcvQEH2jGAVGu31FKNyyeqkHxIfXZQXIbmP2jzG+F0=;
 b=RJ2prk94mAYeXj6fAFR48Hr1ZN2HlORtmT1Zj1s0/WMTd+yVFgk7LbS+O5woaMpo8+
 6OjG95iy7ypqz5h9nKS9HsmX78XoG+6KuHyuvuUUQo9Mj4zFfxPpdTDJeyK0rrCYSd6H
 NBs82basRtRf2Boq2DsMQEONK0qsDaMBI0qY07Xg6Zyml4fC17HWsxLYZtCuRkDLjtFV
 bNgLqE0IqCuSIrdrawIBjoSGNZXXquDP4m3utw5BcyeGyL2OpqA6866NwdZl+uoYi4oD
 mwcSY+ojELHmIqjcTfl4XpC/GtcKThJDLUp+g/dnucqxOak3mv5lD8b54pbNt7WRs9zF
 1cIQ==
X-Gm-Message-State: AOJu0YwHWMhBy0lxh5a36U2qBpdOYCrshQM1MlWTTgyikcUy7X/FWJ64
 sQ7cNLjuJcfcgvKMHMnmMRHyIZ5+nq5JvS1WgKqkoHZV12MM8pXoRDthHyDHJjzxy7QNOHfchoQ
 yBG0+KPwEMfMPdxpqeHWUot+nvrzcrdpoutJPAboF64Jm1kZbgjOd
X-Received: by 2002:a05:6358:e4a3:b0:178:f482:6e59 with SMTP id
 by35-20020a056358e4a300b00178f4826e59mr4833216rwb.3.1708933686673; 
 Sun, 25 Feb 2024 23:48:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRaLqUWS+Gg6dD8UDDHGXtDKAZaZNFbnMzV9qjXUNqgxVoE7G+DjZOiE522z1mEwsNHQOwHg==
X-Received: by 2002:a05:6358:e4a3:b0:178:f482:6e59 with SMTP id
 by35-20020a056358e4a300b00178f4826e59mr4833201rwb.3.1708933686335; 
 Sun, 25 Feb 2024 23:48:06 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 j7-20020aa78007000000b006e02da39dbcsm3484508pfi.10.2024.02.25.23.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 23:48:05 -0800 (PST)
Date: Mon, 26 Feb 2024 15:47:58 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 22/34] migration/multifd: Prepare multifd sync for
 fixed-ram migration
Message-ID: <ZdxCLmKFirsXPia-@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-23-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-23-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
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

On Tue, Feb 20, 2024 at 07:41:26PM -0300, Fabiano Rosas wrote:
> The fixed-ram migration can be performed live or non-live, but it is
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
>   With fixed-ram we want to maintain the sync on the sending side
>   because that provides ordering between the rounds of dirty pages when
>   migrating live.
> 
> MULTIFD_FLUSH
> -------------
>   On the receiving side, the presence of the MULTIFD_FLUSH flag on a
>   packet causes the receiving channels to start synchronizing with the
>   main thread.
> 
>   We're not using packets with fixed-ram, so there's no MULTIFD_FLUSH
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
>   For fixed-ram we only need to synchronize the channels at the end of
>   migration to avoid doing cleanup before the channels have finished
>   their IO.
> 
> Make sure the multifd syncs are only issued at the appropriate
> times. Note that due to pre-existing backward compatibility issues, we
> have the multifd_flush_after_each_section property that enables an
> older behavior of synchronizing channels more frequently (and
> inefficiently). Fixed-ram should always run with that property
> disabled (default).

What if the user enables multifd_flush_after_each_section=true?

IMHO we don't necessarily need to attach the fixed-ram loading flush to any
flag in the stream.  For fixed-ram IIUC all the loads will happen in one
shot of ram_load() anyway when parsing the ramblock list, so.. how about we
decouple the fixed-ram load flush from the stream by always do a sync in
ram_load() unconditionally?

@@ -4368,6 +4367,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             ret = ram_load_precopy(f);
         }
     }
+
+    /*
+     * Fixed-ram migration may queue load tasks to multifd threads; make
+     * sure they're all done.
+     */
+    if (migrate_fixed_ram() && migrate_multifd()) {
+        multifd_recv_sync_main();
+    }
+
     trace_ram_load_complete(ret, seq_iter);
 
     return ret;

Then ram_load() always guarantees synchronous loading of pages, and
fixed-ram will completely ignore multifd flushes (then we also skip it for
the ram_save_complete() like what this patch does for the rest).

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/ram.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 5932e1b8e1..c7050f6f68 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1369,8 +1369,11 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>                  if (ret < 0) {
>                      return ret;
>                  }
> -                qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> -                qemu_fflush(f);
> +
> +                if (!migrate_fixed_ram()) {
> +                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> +                    qemu_fflush(f);
> +                }
>              }
>              /*
>               * If memory migration starts over, we will meet a dirtied page
> @@ -3112,7 +3115,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>          return ret;
>      }
>  
> -    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
> +    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
> +        && !migrate_fixed_ram()) {
>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>      }
>  
> @@ -4253,6 +4257,15 @@ static int ram_load_precopy(QEMUFile *f)
>              break;
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
> +            if (migrate_fixed_ram()) {
> +                /*
> +                 * The EOS flag appears multiple times on the
> +                 * stream. Fixed-ram needs only one sync at the
> +                 * end. It will be done on the flush flag above.
> +                 */
> +                break;
> +            }
> +
>              if (migrate_multifd() &&
>                  migrate_multifd_flush_after_each_section()) {
>                  multifd_recv_sync_main();
> -- 
> 2.35.3
> 

-- 
Peter Xu


