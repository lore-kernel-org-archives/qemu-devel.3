Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3414C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 11:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukKy1-0002s7-CV; Fri, 08 Aug 2025 07:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ukKxv-0002pN-3V
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 07:08:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ukKxr-0007Xs-GE
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 07:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754651325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqFbHnKRIRFJltmMETKWH6B3/lkGqma8lEd+JfTH330=;
 b=hhsY1bMDcdvS1PvDJaIKwheOG92biEk8KLwUnitS9pYcDkG0neSAapKQCSHbgAIpIbFuMg
 uydh4nvgMg/Xbi/jJIJ+CRXEzHLne011P2y2ZUfxUKgGDFA3ekRBf6YxQ3vV04Xatwsl5y
 ++jjE1Zl3xVXxMeKv4WLPjWSBD0Uupo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-WXwN7GElN1OTnqnU-j125g-1; Fri, 08 Aug 2025 07:08:44 -0400
X-MC-Unique: WXwN7GElN1OTnqnU-j125g-1
X-Mimecast-MFC-AGG-ID: WXwN7GElN1OTnqnU-j125g_1754651324
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5bb68b386so644943885a.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 04:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754651324; x=1755256124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TqFbHnKRIRFJltmMETKWH6B3/lkGqma8lEd+JfTH330=;
 b=omTDTqVbPAR+otmYVToXrH/tyDD/aPyFu4jyjyOFzzJP9m00qE2kasAM/6pA7voblU
 I6WIB0FZ4P2G1ssa/X267/Uel9ruBGmCmnctIZ9rDPMHVnhYSJSNK1wwrG7HUWv42wYK
 MThwB09twcWZnFqvE053tUTSMiJG03Fm5SDanWkiMtHFAwmnMB9tBqc2IAhqE41gSX0Q
 8HbAUE68T2p9LPWF63vTyKRlhmUwz5hQtiQvUGBdbKLS1bKQDWdZ+9q+i0ltk58cFmC7
 vYZrUfMUr3jVxMowd9fgf3ttqWffQkHgNfetAF0caiY91dcVkZ49oSTO+BwS/h+oi0Z8
 vNSg==
X-Gm-Message-State: AOJu0YzXXXm2rCXA4LygWFUlENQhwJ1SGYrW9AHft80d0mj0ur7YP29y
 jqlbib+uSLbwrUEvSkEO7tvL80EZPI7OhY9g4rfyNZc/VH9uoWSioHBZJVl7afRKeg7zw32ArUX
 T/z9rthQfWheQgUqPBglYq2TqttZoSLblSBpBWIuMnon4hF+7aBl6zmxx
X-Gm-Gg: ASbGncuZKYpHNvc0YssDS84/PjpMDU2UeLpEOXo9INMazfccS+USnbQoU45IqlcJ4Nv
 XT2LEGLQxA3L0sfDGvGftuynk0q8x53OVav6iWhtfvDww9V9/1Mj+xSIuhLUUKJMQPemzdQFjt/
 Ha8DgqCMu7Mj9X0RHBF43q1gnB+JgzPXeqtX4v56nL29OVFxBRoLCV6fw3ZnT2fE3JRMCBDJB4B
 67FE0HF4niIzcDs0ucEZl8a4+VZXHBvrXIXaiDkne7XgpPAj45fKb/2q+3Y3SnFiq//svG3kYnR
 Bd0esKfbtSfCr6Q/NVJsRE1PG+2/
X-Received: by 2002:a05:620a:c50:b0:7e6:211b:217a with SMTP id
 af79cd13be357-7e82c78f592mr299096485a.43.1754651324042; 
 Fri, 08 Aug 2025 04:08:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL8izLLZ6+oU4+5q7dbMnAwzHF96Flo1TJDWAuE2pI6T3vMpEzWZJAHVRvv8EbhD9Rz145tQ==
X-Received: by 2002:a05:620a:c50:b0:7e6:211b:217a with SMTP id
 af79cd13be357-7e82c78f592mr299092185a.43.1754651323444; 
 Fri, 08 Aug 2025 04:08:43 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e7fe61c778sm677808885a.20.2025.08.08.04.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 04:08:43 -0700 (PDT)
Date: Fri, 8 Aug 2025 13:08:39 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 3/4] migration: Make listen thread joinable
Message-ID: <2svq64am2z4dr7q7x2jozlgzhiwluzi3je3f4acjylxqyzbxml@mnqscmlofjro>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <20250807114922.1013286-4-jmarcin@redhat.com>
 <aJUTO0n9NyIWaFNj@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJUTO0n9NyIWaFNj@x1.local>
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

Hi Peter,

On 2025-08-07 16:57, Peter Xu wrote:
> On Thu, Aug 07, 2025 at 01:49:11PM +0200, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > This patch allows joining the migration listen thread. This is done in
> > preparation for the introduction of "postcopy-setup" state at the
> > beginning of a postcopy migration, when destination can fail gracefully
> > and source side then resume to a running state.
> > 
> > In case of such failure, to gracefully perform all cleanup in the main
> > migration thread, we need to wait for the listen thread to exit, which
> > can be done by joining it.
> > 
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> >  migration/migration.c | 1 +
> >  migration/savevm.c    | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index e5ce2940d5..8174e811eb 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -901,6 +901,7 @@ process_incoming_migration_co(void *opaque)
> >               * Postcopy was started, cleanup should happen at the end of the
> >               * postcopy thread.
> >               */
> > +            qemu_thread_detach(&mis->listen_thread);
> >              trace_process_incoming_migration_co_postcopy_end_main();
> >              goto out;
> >          }
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index fabbeb296a..d2360be53c 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2217,7 +2217,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
> >      mis->have_listen_thread = true;
> >      postcopy_thread_create(mis, &mis->listen_thread,
> >                             MIGRATION_THREAD_DST_LISTEN,
> > -                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
> > +                           postcopy_ram_listen_thread, QEMU_THREAD_JOINABLE);
> 
> This is good; I actually forgot it used to be detached..
> 
> Instead of proactively detach it above, could we always properly join it

However, after the main thread finishes loading device state from the
package, process_incoming_migration_co() exits, and IIUC main thread is
then no longer occupied with migration. So, if we should instead join
the listen thread, we probably should yield the coroutine until the
listen thread can be joined, so we are not blocking the main thread?

> (and hopefully every migration thread)?  Then we could drop patch 1 too.

If I haven't missed any, there are no detached migration threads except
listen and get dirty rate threads.


Thanks,

Juraj Marcin

> 
> >      trace_loadvm_postcopy_handle_listen("return");
> >  
> >      return 0;
> > -- 
> > 2.50.1
> > 
> 
> -- 
> Peter Xu
> 


