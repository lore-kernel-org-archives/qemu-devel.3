Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39217CAC596
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 19:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqdkL-0006EH-VO; Tue, 17 Sep 2024 15:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqdkJ-00069D-BS
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 15:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqdkH-0003oX-0S
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 15:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726600816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OxGnRkjYkqGnblnXtwZEOEsiAvAnyjc6PlNzyYf7dQk=;
 b=AyzFIXThmMGmphgwFt0u7PmbnAbygiHMLzc+ckevGX29uTu5tRnzRePxlH/AoRwfKeW/im
 p2UIBMUyaIH1YBVtf86DKejHYNdufdtcTAeHEFEFhQ6urtiyaXdfCMfTNy4f3kU8b0JdGl
 /svkUEBSmS1LfeFBFQo/frvz6wG8ggg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-h8KnvUtBNZ-wRNY8E3MYEA-1; Tue, 17 Sep 2024 15:20:14 -0400
X-MC-Unique: h8KnvUtBNZ-wRNY8E3MYEA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7ac9b08cb77so257694085a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 12:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726600813; x=1727205613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxGnRkjYkqGnblnXtwZEOEsiAvAnyjc6PlNzyYf7dQk=;
 b=d9hMYjkhmrG8ENRA+lD9xbUzpJ0m3H1Sv20oKUcSD++O3TVxampsgZgb4SjkP+vl9z
 H5Cg5D1rj80/Eea8W5U1M+8dGuB5GJYupBx1jkfUzTZApA/yirYntAndOgoYMS15BaJV
 avaSzfl0aplwCvu+HdHknqH47MrMZZ9Fo+i+hNaRaoocUB9otjvXEzJsOdYSkB69YPYK
 o0mE6o4yr9ywFTcWve17ReQVnVbvOWRo3zC2bOchatEJVHJOb0xEUFwRYYcPlTEk8T4h
 cO1PgRzgHc5kZNhm0rBGOjj/On/EUugJfwRHEiuj+Ji4Qj5NIZHo5FVBzA4ggxUE+N2U
 lCzQ==
X-Gm-Message-State: AOJu0YynIaArXHDbsSgwqpcRA++heLG0LfEcSSadt0i30M0DOJ2sNrOO
 ER0w8pD7JKa+EiF+cHT2+67lQBIdrHh0dIYkJX/YIKpzPNf60v3J4DAYFnyUl3g5RoX8Vql4IOX
 rbghcAmMyUiXlYRyHY/BHaQRp5uf0jWClLaipJZYQcHXdAGLE/FAWQuZhUyDbEv0=
X-Received: by 2002:a05:620a:251:b0:7ac:a077:6a3d with SMTP id
 af79cd13be357-7aca0776c90mr291515985a.10.1726600813423; 
 Tue, 17 Sep 2024 12:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrWm/mSyddpXyImcGnp2hAKLlppOI+X/ESUjvwXAsdxop1XBEFPiHOPojXTFK69BbnOeRCww==
X-Received: by 2002:a05:620a:251:b0:7ac:a077:6a3d with SMTP id
 af79cd13be357-7aca0776c90mr291512985a.10.1726600812972; 
 Tue, 17 Sep 2024 12:20:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3eb65f9bsm390275185a.120.2024.09.17.12.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 12:20:12 -0700 (PDT)
Date: Tue, 17 Sep 2024 15:20:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 2/2] migration/multifd: Fix rb->receivedmap cleanup race
Message-ID: <ZunWarI8toCsqAVL@x1n>
References: <20240917185802.15619-1-farosas@suse.de>
 <20240917185802.15619-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240917185802.15619-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 17, 2024 at 03:58:02PM -0300, Fabiano Rosas wrote:
> Fix a segmentation fault in multifd when rb->receivedmap is cleared
> too early.
> 
> After commit 5ef7e26bdb ("migration/multifd: solve zero page causing
> multiple page faults"), multifd started using the rb->receivedmap
> bitmap, which belongs to ram.c and is initialized and *freed* from the
> ram SaveVMHandlers.
> 
> Multifd threads are live until migration_incoming_state_destroy(),
> which is called after qemu_loadvm_state_cleanup(), leading to a crash
> when accessing rb->receivedmap.
> 
> process_incoming_migration_co()        ...
>   qemu_loadvm_state()                  multifd_nocomp_recv()
>     qemu_loadvm_state_cleanup()          ramblock_recv_bitmap_set_offset()
>       rb->receivedmap = NULL               set_bit_atomic(..., rb->receivedmap)
>   ...
>   migration_incoming_state_destroy()
>     multifd_recv_cleanup()
>       multifd_recv_terminate_threads(NULL)
> 
> Move the loadvm cleanup into migration_incoming_state_destroy(), after
> multifd_recv_cleanup() to ensure multifd threads have already exited
> when rb->receivedmap is cleared.
> 
> Adjust the postcopy listen thread comment to indicate that we still
> want to skip the cpu synchronization.
> 
> CC: qemu-stable@nongnu.org
> Fixes: 5ef7e26bdb ("migration/multifd: solve zero page causing multiple page faults")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

One trivial question below..

> ---
>  migration/migration.c | 1 +
>  migration/savevm.c    | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 3dea06d577..b190a574b1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -378,6 +378,7 @@ void migration_incoming_state_destroy(void)
>      struct MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      multifd_recv_cleanup();

Would you mind I add a comment squashed here when queue?

       /*
        * RAM state cleanup needs to happen after multifd cleanup, because
        * multifd threads can use some of its states (receivedmap).
        */

> +    qemu_loadvm_state_cleanup();
>  
>      if (mis->to_src_file) {
>          /* Tell source that we are done */
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d0759694fd..7e1e27182a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2979,7 +2979,10 @@ int qemu_loadvm_state(QEMUFile *f)
>      trace_qemu_loadvm_state_post_main(ret);
>  
>      if (mis->have_listen_thread) {
> -        /* Listen thread still going, can't clean up yet */
> +        /*
> +         * Postcopy listen thread still going, don't synchronize the
> +         * cpus yet.
> +         */
>          return ret;
>      }
>  
> @@ -3022,7 +3025,6 @@ int qemu_loadvm_state(QEMUFile *f)
>          }
>      }
>  
> -    qemu_loadvm_state_cleanup();
>      cpu_synchronize_all_post_init();
>  
>      return ret;
> -- 
> 2.35.3
> 

-- 
Peter Xu


