Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11234C87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 13:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulSB9-0002l7-H1; Mon, 11 Aug 2025 09:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ulSAl-00026H-9t
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ulSAh-0005y0-1w
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754917355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CB9Fp17VbM9IJuCixfnk/+GdwDgh1BERwJojw1nqQ3k=;
 b=EFY7Xz1UjvEDC4tsLbbxHV/CtZtPLcE0qaOqknaemqH8ElzHY6yBs5AiqCjjD/hx5lagM9
 sVmHbpXTwmyBgouapkjTIM2lJTrYGlsEQqth4HR6nWYKLREdL21BiHrPRdhYrXiFJuoLen
 /6pjwda3hTD7qfHv5IvS1swYnkfhut0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-kf5VQcb9NtOe189gvd6TqQ-1; Mon, 11 Aug 2025 09:02:34 -0400
X-MC-Unique: kf5VQcb9NtOe189gvd6TqQ-1
X-Mimecast-MFC-AGG-ID: kf5VQcb9NtOe189gvd6TqQ_1754917353
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-7075d48a15bso88320816d6.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 06:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754917353; x=1755522153;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CB9Fp17VbM9IJuCixfnk/+GdwDgh1BERwJojw1nqQ3k=;
 b=oyFYaXwGBIqJL9K6BuUVeV2npOHDzi9QsRTrTjIzAUTSlmTp01yLk0iOyROqEx3RK7
 fbVovTa473M4N5LhsxA5Yi0WmjTrrCBHOy0zhsIEjd3HRgBbSKaWeeFpubNbJzEOnPUA
 t09aXmKxJ4kLFgi/vU80264F18MkXdwWmJO9nldlCjKASRaY1vtbsDOpylaEcs3sz8wJ
 ayWDtdckASwzw9Z8c007ix+ZXm82gCM/EFmeLCTRVYy29brHoGKCZK2GVVL+NjE2pVEb
 +M8EjjEJfPVC/HT+WRvND/nJQL5ePF7gnNv/58VNYMAUHIvAk1nBozyVh9Ed+AAp+smH
 t0/w==
X-Gm-Message-State: AOJu0Yx6kt0l92CxvjMjZMBFLp38wpEK1c79PGozxKQfBp35YWhyHFrc
 mFb0eMBPZBjkedLFJB+4SFTGMOaZnYLqHOQIjBSXIg9/q/7OYh5h/uoxXzWUSxv4haEDHQpc6Er
 aF9OIu10OKSTnL+3fE7EWM6vcHlqOcwXLyGFd4ZZEcqhpNtvDYdKKXCbv
X-Gm-Gg: ASbGncs4SIRjBvtJhzYmdY/bfnaLvThIqIWn+EN6r8FirkqGld5NdY71RoRe7ieifNi
 MkjR/Aqs9YdoE4jenVY2orvhKJ6+SHJESMOV10jg3hBUAbf5LuY7cvcHFlqeTfBnvBh4vRKBGnq
 Co+slpa87bX3r8eXB1yluSKE+qNUoHgd4TEP9JeDg4XiMBcqMluCOBA8dyluT/zSEFCxKLZd3tX
 WeZqUP3UGQ/EmFGK9W8ekXvTgzT3GqvkhjwUVn24GAec+guHNaaiLIz4J7T/roDgNwf06EDwf8Q
 EcapwlQEGvv02PbfOEPCRrs4pXHVX204Bvnohd70Q7maj5sedtd5WmRfgQ==
X-Received: by 2002:a05:6214:2aaf:b0:707:49ae:cd47 with SMTP id
 6a1803df08f44-7099a332e69mr145704016d6.30.1754917353102; 
 Mon, 11 Aug 2025 06:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+HfdEVOQDC0UUmsSxtSHy/VQitGHz+Oupya0T4OcCtbqCt3iK1XyZNfwb/Y/RMndsblkXVw==
X-Received: by 2002:a05:6214:2aaf:b0:707:49ae:cd47 with SMTP id
 6a1803df08f44-7099a332e69mr145703266d6.30.1754917352419; 
 Mon, 11 Aug 2025 06:02:32 -0700 (PDT)
Received: from fedora (78-80-81-60.customers.tmcz.cz. [78.80.81.60])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7094e245309sm116609696d6.1.2025.08.11.06.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 06:02:32 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:02:28 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 3/4] migration: Make listen thread joinable
Message-ID: <4hfdomtaolsdjodyqbrvnoit4gpcizvbiv54psnk4sxuwp4zpu@t74oeypruhli>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <20250807114922.1013286-4-jmarcin@redhat.com>
 <aJUTO0n9NyIWaFNj@x1.local>
 <2svq64am2z4dr7q7x2jozlgzhiwluzi3je3f4acjylxqyzbxml@mnqscmlofjro>
 <aJYuWKjb8ij7NRx6@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJYuWKjb8ij7NRx6@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter

On 2025-08-08 13:05, Peter Xu wrote:
> On Fri, Aug 08, 2025 at 01:08:39PM +0200, Juraj Marcin wrote:
> > Hi Peter,
> > 
> > On 2025-08-07 16:57, Peter Xu wrote:
> > > On Thu, Aug 07, 2025 at 01:49:11PM +0200, Juraj Marcin wrote:
> > > > From: Juraj Marcin <jmarcin@redhat.com>
> > > > 
> > > > This patch allows joining the migration listen thread. This is done in
> > > > preparation for the introduction of "postcopy-setup" state at the
> > > > beginning of a postcopy migration, when destination can fail gracefully
> > > > and source side then resume to a running state.
> > > > 
> > > > In case of such failure, to gracefully perform all cleanup in the main
> > > > migration thread, we need to wait for the listen thread to exit, which
> > > > can be done by joining it.
> > > > 
> > > > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > > > ---
> > > >  migration/migration.c | 1 +
> > > >  migration/savevm.c    | 2 +-
> > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > index e5ce2940d5..8174e811eb 100644
> > > > --- a/migration/migration.c
> > > > +++ b/migration/migration.c
> > > > @@ -901,6 +901,7 @@ process_incoming_migration_co(void *opaque)
> > > >               * Postcopy was started, cleanup should happen at the end of the
> > > >               * postcopy thread.
> > > >               */
> > > > +            qemu_thread_detach(&mis->listen_thread);
> > > >              trace_process_incoming_migration_co_postcopy_end_main();
> > > >              goto out;
> > > >          }
> > > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > > index fabbeb296a..d2360be53c 100644
> > > > --- a/migration/savevm.c
> > > > +++ b/migration/savevm.c
> > > > @@ -2217,7 +2217,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
> > > >      mis->have_listen_thread = true;
> > > >      postcopy_thread_create(mis, &mis->listen_thread,
> > > >                             MIGRATION_THREAD_DST_LISTEN,
> > > > -                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
> > > > +                           postcopy_ram_listen_thread, QEMU_THREAD_JOINABLE);
> > > 
> > > This is good; I actually forgot it used to be detached..
> > > 
> > > Instead of proactively detach it above, could we always properly join it
> > 
> > However, after the main thread finishes loading device state from the
> > package, process_incoming_migration_co() exits, and IIUC main thread is
> > then no longer occupied with migration. So, if we should instead join
> > the listen thread, we probably should yield the coroutine until the
> > listen thread can be joined, so we are not blocking the main thread?
> 
> Or could we schedule a bottom half at the end of
> postcopy_ram_listen_thread() to join itself?  We could move something over
> into the BH:
> 
>     ... join() ...
>     mis->have_listen_thread = false;
>     migration_incoming_state_destroy();
>     object_unref(OBJECT(migr));

That sounds like a good idea, I will certainly try that, thank you.

Best regards,

Juraj Marcin

> 
> > 
> > > (and hopefully every migration thread)?  Then we could drop patch 1 too.
> > 
> > If I haven't missed any, there are no detached migration threads except
> > listen and get dirty rate threads.
> 
> Yep.
> 
> From mgmt pov, IMHO it's always good we create joinable threads.  But we
> can leave the calc_dirty_rate thread until necessary.
> 
> -- 
> Peter Xu
> 


