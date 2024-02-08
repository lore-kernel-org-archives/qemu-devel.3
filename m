Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A21C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 05:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXxPr-0005UL-DU; Thu, 08 Feb 2024 00:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXxPp-0005TO-DW
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 00:57:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXxPn-0006dv-UM
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 00:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707371858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+IXZevLaE5d3VyF4Xin/W28CUVntYLooa1ohuFSylo=;
 b=DEQGlgoXfzbKA5YrFw5NGsSBubr5st30kz6fsM9+BpK6NWORAt7l2HEAZLfbyqrdxfCogu
 l/5HXyqIYE05QLEVGzl8+L/bhbAHXAUy6KulLPNimCTkYr4m0E1qFpnIf99VX8K0PC2OFW
 ZyAtSp2pefymJ5RtEWV8+MHwXt8/BFg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-uqS1TW8iMD6YCTx7mETseg-1; Thu, 08 Feb 2024 00:57:36 -0500
X-MC-Unique: uqS1TW8iMD6YCTx7mETseg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2961d20fe78so468617a91.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 21:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707371855; x=1707976655;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X+IXZevLaE5d3VyF4Xin/W28CUVntYLooa1ohuFSylo=;
 b=BHa2IGs7pGczt89cxJ6vF5UxoSON0S9KQ6mJobGzzQlaPdfc49ROTDB/Tq+UZx2Q9w
 QsIwv92FdlSsRz6hKzEpZJYEUCgr52Lw+2PHdI+ZdihxTQemV/NfIKC+OWhZUCEqF0m5
 8JHVRGHNPFm2X/zZ174KHO4USsuNELexpzzIiWKQ6zyO1WOvVqAOZfi/ON5lm6PmWQrY
 vHu19YewvpVfqE/67VdphqS37JvVxzHJ3ApOv5yf62F+JIEZSTKiGaSu7OQ9GjAKA55L
 QpAJgaLvZikXB3mgnflPVI2BTcLphlH9b7A816G/a+s1/OLLYo6KYjA0Sx1FuXCbnKlM
 3uKg==
X-Gm-Message-State: AOJu0YzrqdF+6lhCMUhcEMDT5zcG0LfcYuqeDzhyIwuXVg2/pFfVT4Wo
 lMXp14imrJVLfWsS5Z9MW4k8+B9Rt7JH7yR+Tr9aJvfarZNKcdcTtny54/2RUMKA0KuzZXSAJ0W
 6wo0J2fB0TjEjV6Z0W4SyQazDMZQi51ZblS/ThnnQo36cVNom5Wjj
X-Received: by 2002:a17:902:d505:b0:1d7:1480:6538 with SMTP id
 b5-20020a170902d50500b001d714806538mr8568025plg.1.1707371854724; 
 Wed, 07 Feb 2024 21:57:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnTgYbVE+zNI2qxtB/zrT1zu8T7UMKj7YXxCezBuVY3woioGJKWaBj4J9qjorNXmciTegUbA==
X-Received: by 2002:a17:902:d505:b0:1d7:1480:6538 with SMTP id
 b5-20020a170902d50500b001d714806538mr8568009plg.1.1707371854329; 
 Wed, 07 Feb 2024 21:57:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV3UGzFeJqX9AGVuCj19smp62uKsg9ad5ftJo8rxOzg8aD8/0NOwBCFBuqjYNnLqYpmVuejtwBQ7/9qxA0I3fLUioEJs3UzRyU3zM+IooqvCR/VM0OhnZlVcYmO+B5AsKElrx2/a4uHfmZKzimH+AxO
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 j19-20020a170902f25300b001d9c1d8a416sm2484979plc.130.2024.02.07.21.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 21:57:33 -0800 (PST)
Date: Thu, 8 Feb 2024 13:57:29 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 14/14] migration: Fix return-path thread exit
Message-ID: <ZcRtSdInpBGgWhk0@x1n>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-15-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207133347.1115903-15-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 07, 2024 at 02:33:47PM +0100, Cédric Le Goater wrote:
> In case of error, close_return_path_on_source() can perform a shutdown
> to exit the return-path thread.  However, in migrate_fd_cleanup(),
> 'to_dst_file' is closed before calling close_return_path_on_source()
> and the shutdown fails, leaving the source and destination waiting for
> an event to occur.
> 
> Close the file after calling close_return_path_on_source() so that the
> shutdown succeeds and the return-path thread exits.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  This is an RFC because the correct fix implies reworking the QEMUFile
>  construct, built on top of the QEMU I/O channel.
> 
>  migration/migration.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5f55af3d7624750ca416c4177781241b3e291e5d..de329f2c553288935d824748286e79e535929b8b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1313,6 +1313,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
>  
>  static void migrate_fd_cleanup(MigrationState *s)
>  {
> +    QEMUFile *tmp = NULL;
> +
>      g_free(s->hostname);
>      s->hostname = NULL;
>      json_writer_free(s->vmdesc);
> @@ -1321,8 +1323,6 @@ static void migrate_fd_cleanup(MigrationState *s)
>      qemu_savevm_state_cleanup();
>  
>      if (s->to_dst_file) {
> -        QEMUFile *tmp;
> -
>          trace_migrate_fd_cleanup();
>          bql_unlock();
>          if (s->migration_thread_running) {
> @@ -1341,15 +1341,14 @@ static void migrate_fd_cleanup(MigrationState *s)
>           * critical section won't block for long.
>           */
>          migration_ioc_unregister_yank_from_file(tmp);
> -        qemu_fclose(tmp);
>      }
>  
> -    /*
> -     * We already cleaned up to_dst_file, so errors from the return
> -     * path might be due to that, ignore them.
> -     */
>      close_return_path_on_source(s);
>  
> +    if (tmp) {
> +        qemu_fclose(tmp);
> +    }
> +
>      assert(!migration_is_active(s));
>  
>      if (s->state == MIGRATION_STATUS_CANCELLING) {

I think this is okay to me for a short term plan.  I'll see how others
think, also add Dan into the loop.

If so, would you please add a rich comment explaining why tmp needs to be
closed later?  Especially, explicit comment on the ordering requirement
would be helpful: IMHO here it's an order that qemu_fclose() must happen
after close_return_path_on_source().  So when others work on this code we
don't easily break it without noticing.

Also please feel free to post separately on migration patches if you'd like
us to merge the patches when repost.

Thanks,

-- 
Peter Xu


