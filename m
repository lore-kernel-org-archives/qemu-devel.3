Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C0DD31765
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8MqB-0003Sn-FA; Tue, 05 Nov 2024 11:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8Mq9-0003SK-52
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:55:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8Mq7-00055J-6s
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730825732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a5EuQKpvCopFWQzod/Tjj97jvWWJXPydJFuWGsOu3Ts=;
 b=f6a6Q7UoEPv16+acUv4fu32IBpkeMl10ht00hJM+KekZm/BaLQkEJ/cJcPS4t+880jx/CQ
 r8O5PjWQ1VqqHL9nPkzXlDrgpwz1CUYWb3wIlaYkFEqeY4MsKlnLAmU43MZ0Ka3BqX5iEb
 Gfwpdh9EzLAPNixZugJ7lbqpHvkGYig=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-m1PiLfBaNkenkjP_4NrExg-1; Tue, 05 Nov 2024 11:55:30 -0500
X-MC-Unique: m1PiLfBaNkenkjP_4NrExg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-460d76f1d7eso110669751cf.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730825730; x=1731430530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5EuQKpvCopFWQzod/Tjj97jvWWJXPydJFuWGsOu3Ts=;
 b=Eh2HKf4MDS2aKqJDQFFI1XzP/JoyvulbN6QAVhF71c60VNuyYskCYxoJTDN7y5H+N9
 kWLMXTE10xKVBaFv9PR8qlCzbSPEIKLC7n4f9IjHaybQ1Dtyz1+nUx4woy7Okg+lDKGE
 Qz42wxoXdsL7KoYqgnI5RtB+efi7hcAl0pwDdle99L6Gsv0Re77E87Ml1XA5Cr8tg3qQ
 vGWhvHciMSAU2kE1GRGo6lU4cPQSMrhC3jgwBDNsRbep+wKWHUorQTzOzU9nhXGR5wP6
 6BK2tROhAqvnhDEkpXg6vmIpeuYIbGSGPx6EoIGoMzLWSwintmnW1529xSRMkHsMWzC0
 yDyg==
X-Gm-Message-State: AOJu0YycRqRq6afKy/r6xBHuHWfd6hgsiBSVNLnkJnrQQoAlNr1xsm8O
 uPCYncwW6E9xQht2l6oBnqg+G2EhxUJK9KnjXbTkgtjFwP//fK6NTDQWiCb1whRGl7Gs5ucVxRK
 +Xp07raam3q09zfVjAYK921JmE5KWmRav0BUsv9wiQsyxM1QBD0OE
X-Received: by 2002:a05:622a:1790:b0:460:e633:556e with SMTP id
 d75a77b69052e-462b86a7c3bmr269694101cf.30.1730825729906; 
 Tue, 05 Nov 2024 08:55:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZkDSn+lOiZxy0HI+Mf7LiWbVOmwUpeappn+fQL3bZhL8nKr2fUPxKmTzUEYMyxYPTP6xauQ==
X-Received: by 2002:a05:622a:1790:b0:460:e633:556e with SMTP id
 d75a77b69052e-462b86a7c3bmr269693821cf.30.1730825729479; 
 Tue, 05 Nov 2024 08:55:29 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0d1e37sm61042561cf.54.2024.11.05.08.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:55:28 -0800 (PST)
Date: Tue, 5 Nov 2024 11:55:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 5/5] migration: enable multifd and postcopy together
Message-ID: <ZypN_icZsyS_8BPK@x1n>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-6-ppandit@redhat.com>
 <ZykJBq7ME5jgSzCA@x1n>
 <CAE8KmOyz9gWfKZmVkXLvj-NMo_=QB42sZhTyVGLqkOjU1GCXfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOyz9gWfKZmVkXLvj-NMo_=QB42sZhTyVGLqkOjU1GCXfg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 05, 2024 at 05:24:55PM +0530, Prasad Pandit wrote:
> On Mon, 4 Nov 2024 at 23:19, Peter Xu <peterx@redhat.com> wrote:
> > Precopy keeps sending data even during postcopy, that's the background
> > stream (with/without preempt feature enabled).  May need some amendment
> > when repost here.
> 
> * Okay.
> 
> > > +    if (channel == CH_POSTCOPY) {
> > > +        return false;
> > > +    }
> >
> > Please see my other reply, I think here it should never be POSTCOPY
> > channel, because postcopy (aka, preempt) channel is only created after the
> > main channel.. So I wonder whether this "if" will hit at all.
> 
> * It does. migration_ioc_process_incoming() is called for each
> incoming connection. And every time it calls
> migration_should_start_incoming() to check if it should proceed with
> the migration or should wait for further connections, because multifd
> does not start until all its connections are established.
> 
> * Similarly when the Postcopy channel is initiated towards the end of
> Precopy migration, migration_should_start_incoming() gets called, and
> returns 'false' because we don't want to start a new incoming
> migration at that time. Earlier it was receiving boolean value
> 'default_channel' as parameter, which was set to false while accepting
> 'postcopy' connection via => default_channel = !mis->from_src_file;

Hmm yes, it will happen, but should only happen after the main channel.

> 
> > > +
> > >      /* Multifd doesn't start unless all channels are established */
> > >      if (migrate_multifd()) {
> > > -        return migration_has_all_channels();
> > > -    }
> > > -
> > > -    /* Preempt channel only starts when the main channel is created */
> > > -    if (migrate_postcopy_preempt()) {
> > > -        return main_channel;
> > > +        return multifd_recv_all_channels_created();
> >
> > I think this is incorrect.. We should also need to check main channel is
> > established before start incoming.  The old code uses
> > migration_has_all_channels() which checks that.
> 
> * Okay, will try to fix it better.  But calling
> migration_has_all_channels() after checking migrate_multifd() does not
> seem/read right.
> 
> > I don't yet see how you manage the multifd threads, etc, on both sides.  Or
> > any logic to make sure multifd will properly flush the pages before
> > postcopy starts.  IOW, any guarantee that all the pages will only be
> > installed using UFFDIO_COPY as long as vcpu starts on dest.  Any comments?
> 
> * There are no changes related to that. As this series only tries to
> enable the multifd and postcopy options together.

In short, qemu_savevm_state_complete_precopy_iterable() is skipped in
postcopy.  I don't yet see anywhere multifd flushes pages.  We need to
flush multifd pages before vcpu starts on dest.

As we discussed off-list, we can add an assertion in multifd recv threads
to make sure it won't touch any guest page during active postcopy.

Maybe something like:

diff --git a/migration/multifd.c b/migration/multifd.c
index 4374e14a96..32425137bd 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1182,6 +1182,13 @@ static void *multifd_recv_thread(void *opaque)
         }
 
         if (has_data) {
+            /*
+             * Now we're going to receive some guest pages into iov
+             * buffers.  If it's during postcopy, it means vcpu can be
+             * running, so this can corrupt memory when modified
+             * concurrently by multifd threads!
+             */
+            assert(!migration_in_postcopy());
             ret = multifd_recv_state->ops->recv(p, &local_err);
             if (ret != 0) {
                 break;

> 
> > The most complicated part of this work would be testing, to make sure it
> > works in all previous cases, and that's majorly why we disabled it before:
> > it was because it randomly crashes, but not always; fundamentally it's
> > because when multifd was designed there wasn't enough consideration on
> > working together with postcopy.  We didn't clearly know what's missing at
> > that time.
> 
> * Right. I have tested this series with the following migration
> commands to confirm that migration works as expected and there were no
> crash(es) observed.
> ===
> [Precopy]
> # virsh migrate --verbose --live --auto-converge f39vm
> qemu+ssh://<destination-host-name>/system
> 
> [Precopy + Multifd]
> # virsh migrate --verbose --live --auto-converge --parallel
> --parallel-connections 02 \
>      f39vm  qemu+ssh://<destination-host-name>/system
> # virsh migrate --verbose --live --auto-converge --parallel
> --parallel-connections 04 \
>      f39vm  qemu+ssh://<destination-host-name>/system
> # virsh migrate --verbose --live --auto-converge --parallel
> --parallel-connections 08 \
>      f39vm  qemu+ssh://<destination-host-name>/system
> # virsh migrate --verbose --live --auto-converge --parallel
> --parallel-connections 16 \
>      f39vm  qemu+ssh://<destination-host-name>/system
> 
> [Postcopy]
> # virsh migrate --verbose --live --auto-converge \
>     --postcopy --postcopy-after-precopy f39vm
> qemu+ssh://<destination-host-name>/system

I'd suggest we try interrupt postcopy with migrate-pause, then go with
postcopy recover.  I wonder how the current series work if the network
failure will fail all the multifd iochannels, and how reconnect works.

> 
> [Postcopy + Multifd]
> # virsh migrate --verbose --live --auto-converge --parallel
> --parallel-connections 02 \
>     --postcopy --postcopy-after-precopy f39vm
> qemu+ssh://<destination-host-name>/system
> # virsh migrate --verbose --live --auto-converge --parallel
> --parallel-connections 04 \
>     --postcopy --postcopy-after-precopy f39vm
> qemu+ssh://<destination-host-name>/system
> # virsh migrate --verbose --live --auto-converge --parallel
> --parallel-connections 08 \
>     --postcopy --postcopy-after-precopy f39vm
> qemu+ssh://<destination-host-name>/system
> # virsh migrate --verbose --live --auto-converge --parallel
> --parallel-connections 16 \
>     --postcopy --postcopy-after-precopy f39vm
> qemu+ssh://<destination-host-name>/system
> ===
> 
> > So we would definitely need to add test cases, just like whoever adds new
> > features to migration, to make sure at least it works for existing multifd
> > / postcopy test cases, but when both features enabled.
> ...
> > It will add quite a few tests to run here, but I don't see a good way
> > otherwise when we want to enable the two features, because it is indeed a
> > challenge to enable the two major features together here.
> >
> 
> * Thank you for the hints about the tests, will surely look into them
> and try to learn about how to add new test cases.

Thanks,

-- 
Peter Xu


