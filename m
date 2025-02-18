Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AC9C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkIny-0000FO-Oz; Tue, 18 Feb 2025 03:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tkInx-0000F9-3G
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:18:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tkInu-0000eQ-IB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739866684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyr1Th+AZhXNEnzRoSww1Kztm72rQ8icw2TNOJaGX+Y=;
 b=b6W6b3Wrw9RmBKGD2PvZ4mgFqx0huvsMJXvBjFkX4zYqaj47LJfwJxIPIHGMc6DctsxKN0
 7GiMnW6naeBVunOIRK+YobTzL4NIykT9hAbnIOECNmxjA2XZKsZzimNpH2LaZLsUx79CMh
 dF2TIiMP3E7sxBjYE4dB9ZhE+rKdlz4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-odYEN20fNu60VXuRI0tagA-1; Tue, 18 Feb 2025 03:18:02 -0500
X-MC-Unique: odYEN20fNu60VXuRI0tagA-1
X-Mimecast-MFC-AGG-ID: odYEN20fNu60VXuRI0tagA_1739866682
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43961fb0bafso26319815e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 00:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739866681; x=1740471481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gyr1Th+AZhXNEnzRoSww1Kztm72rQ8icw2TNOJaGX+Y=;
 b=jk7E5R8gO2z9GyhKBhUchbcRITIxJQjsPmQ501bTZpUZQBI5rFSoj8GPRxk2EkX9Gv
 v/4Qe0PYGu6/hHJ1KA6LKHjGZQDwSMpujzhQt1nce0z+DyFKbcUnFu3A06ZEPgWey2xB
 Hki24oJL9lCNZBHxtdjh6gHJiMZpMpqPtvlbApaLSbc/kS3XG6v15UsOnSmkfeudThPC
 ep0v1AIMa9vlITh92dkfE7NMfabw47jVJ+8N/D2Id9D0xPYQvQIUKGNOspwuFu/ytANx
 KZQV0cLSxUpE9eKzL1fBKa8/ol6sB93eyqcAalXgml+nVgjx0NdXCGWIFg2BtvcKZREY
 /k1A==
X-Gm-Message-State: AOJu0Yzfe25lu4xQbaw5Xc6jCEfBVWmq1+IsQnHykbt7vO+LjImvEI7o
 esLIwXSkLzwYDkp7ItkIQeVXnUjMHaPSCNM8eVXqMnMv8X4cKzTPyeObJaoH6/wB4LqvVu/bImX
 qoVcoKJ7EOKXzyJ//WUsb7LS6M41Ev7auf6T8NYX6ZJ7EnwJV7idKyXzGsLWqMhH/wKg5hxYjUI
 Jgycb0NxbBDZEXPhrqQ3o/kbL2HVQ=
X-Gm-Gg: ASbGncvQMgenK7PuwjQV9q5eFlbd8TIvFUBv+23DKOV8bpzibNlDc4539XipoZ28npQ
 r5UN0lAv39QB9f7hAHgKduVn1HhIuknpc++qjZVD3vQ5RvLu+ShLN3pYm0FRFA7l/
X-Received: by 2002:a05:600c:4ecd:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-4396e750885mr94485215e9.26.1739866681361; 
 Tue, 18 Feb 2025 00:18:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH9twl6v2islD9zMRzfmcPUoEZyuw5ucIPojDQ7b3ohe3Mv6XNvyNbEWnDNtZc/L8eBNwyB9rLOxU6cc6UEpo=
X-Received: by 2002:a05:600c:4ecd:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-4396e750885mr94485025e9.26.1739866680961; Tue, 18 Feb 2025
 00:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-3-ppandit@redhat.com>
 <87y0y4tf5q.fsf@suse.de>
In-Reply-To: <87y0y4tf5q.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 18 Feb 2025 13:47:44 +0530
X-Gm-Features: AWEUYZluINzzamuIO63tVQAfDFo3u-0w4S8AJBBErFcMAYsHFfGQ8CzO-UtbDB8
Message-ID: <CAE8KmOxYE=10+xjMjH5ZhbMmRJHgxJKHj2wH-nB-qiBSHEVh1w@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] migration: enable multifd and postcopy together
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hello Fabiano,

On Tue, 18 Feb 2025 at 03:20, Fabiano Rosas <farosas@suse.de> wrote:
> > -static bool migration_should_start_incoming(bool main_channel)
> > +static bool migration_has_main_and_multifd_channels(void)
> >  {
...
> > +    /* main channel and all multifd channels are established */
> >      return true;
> >  }
>
> How will this avoid peeking the preempt channel? You're assuming preempt
> is mutually exclusive with multifd it seems. Otherwise you could get the
> preempt channel creation racing with multifd channels creation.

* IIUC postcopy preempt channel is created towards the end of the
migration when the Postcopy phase starts. At that time, the 'main' and
'multifd' channels are already established and working. Having the
'main' and when multifd is enabled 'multifd' channels in place is a
requirement for starting new migration. So when both the 'main' and
'multifd' channels are established, the new incoming connection is
seen as the 'postcopy' one; And it falls to the 'else' block of the
'if' conditional ->  if (!migration_has_main_and_multifd_channels()) {

* When does postcopy preempt channel creation race with the multifd
channel creation?

> > @@ -989,13 +983,12 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
> > +    if (!migration_has_main_and_multifd_channels()) {
> I'm not entirely sure we need these checks here. They will happen anyway
> later. Could this be replaced by migration_needs_multiple_sockets()
> instead?

* migration_needs_multiple_sockets() => return migrate_multifd() ||
migrate_postcopy_preempt();

* That logical OR should have been AND, no? It returns true even when
one of them is true. That's not multiple types (multifd/postcopy) of
sockets. I don't think it helps much.

* Let's try this:
    - First differentiation: peekable Vs non-peekable channels
    - Peekable channels
         - Main
         - Multifd
    - Non-peekable channels
         - Postcopy preempt
         - TLS
         - File/mapped_ram

    if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK))
    {
            if (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC)) {
                channel = CH_MAIN;
            } else if (channel_magic == cpu_to_be32(MULTIFD_MAGIC)) {
                channel = CH_MULTIFD;
    } else {
            if (!strcmp(ioc->name, "migration-tls-incoming")
                || !strcmp(ioc->name, "migration-file-incoming"))) {
               channel = CH_MULTIFD;
            } else {
               channel = CH_POSTCOPY;
            }
    }

* With above, the 'main' channel shall have to send 'magic value' even
for reconnection during the postcopy recovery phase. If all channels
were consistent and sent a magic value, this code would be much
simpler and we may not have to care/worry about the _order_ in which
these connections are made.

   if (channel == 'main')
       process_main_channel()
   else if (channel == 'multifd')
       process_multifd_channel()
   else if (channel == 'tls')
       process_tls_channel()
    else if (channel == 'file')
       process_file_channel()
    else if (channel == 'postcopy')
       process_postcopy_channel()

> And I'd put this whole channel discovery business in channel.c since
> it's encoding several assumptions about channels. Some helpers used here
> might need to be exported, but that's ok.
>
> Also, please make a separate patch, we need to be really confident that
> changing the discovery code around won't introduce any regression, and
> if it does, we'll want it separate from the postcopy+multifd
> enablement. It's ok if you have the patch assume that multifd+postcopy
> will happen later in the series.

* TBH, I think we have complicated this whole thing with multiple
channel types, their inconsistent behaviour and dependence on the
_order_ in which connections are made. Do we really need channel
types? Could we consider rationalising them?

> > +        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> >          /*
> >           * With multiple channels, it is possible that we receive channels
> >           * out of order on destination side, causing incorrect mapping of
> > @@ -1006,42 +999,58 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
> >           * tls handshake while initializing main channel so with tls this
> >           * issue is not possible.
> >           */
>
> This comment block needs to be indented properly.
>
> > -        ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> > -                                          sizeof(channel_magic), errp);
> > +            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> > +                                              sizeof(channel_magic), errp);
> > +            if (ret != 0) {
> > +                return;
> > +            }
> >
> > -        if (ret != 0) {
> > -            return;
> > +            if (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC)) {
> > +                channel = CH_MAIN;
> > +            } else if (channel_magic == cpu_to_be32(MULTIFD_MAGIC)) {
> > +                channel = CH_MULTIFD;
> > +            } else if (!mis->from_src_file
> > +                        && mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
>
> The usual style is to keep the && on the previous line.
>
> > +                /* reconnect default channel for postcopy recovery */
>
> s/default/main/

* Okay, will fix these.


> > +                channel = CH_MAIN;
> > +            } else {
> > +                error_report("%s: unknown channel magic: %u",
> > +                                __func__, channel_magic);
> > +                return;
>
> This needs to set errp instead of reporting.

* Okay.

> > +            }
> > +        } else if (mis->from_src_file
> > +                && (!strcmp(ioc->name, "migration-tls-incoming")
> > +                || !strcmp(ioc->name, "migration-file-incoming"))) {
> > +            channel = CH_MULTIFD;
>
> This is quite misleading. These channels are used without multifd as
> well. For instance, file-backed fd migration goes past this because
> !mis->from_src_file but it still uses the file channel.
>
> I agree with Peter that checking for channel names is not ideal. I don't
> see an alternative at the moment (hiding the assumption is of course not
> a fix). Maybe check migrate_multifd() here and explain in a comment that
> at the moment, the non-peekable channels happen to be used with multifd
> only.

* The first paragraph says these channels are used without
migrate_multifd(); And the second paragraph says they are used with
migrate_multifd() only....??
===
} else {
        /* Multiple connections */
        assert(migration_needs_multiple_sockets());
        if (migrate_multifd()) {
            multifd_recv_new_channel(ioc, &local_err);
        } else {
            assert(migrate_postcopy_preempt());
            f = qemu_file_new_input(ioc);
            postcopy_preempt_new_channel(mis, f);
        }
===
* IIUC in the current code, when migrate_multifd() is true, these
channels get processed via - multifd_recv_new_channel(). And when
migrate_multifd() is false, it falls to postcopy_preempt_new_channel()
part. Not sure if/how that works really. It is possible that currently
these (tls/file) channels are used only with migrate_multifd() enabled
and so are processed with multifd_recv_new_channel() function. The
current patch handles them the same way.

* About checking channel names, in the non-peekable category above,
how do we differentiate between 'TLS', 'File' and 'Postcopy' channels?
Without magic values, we don't have much choice really.  And seeing
those names in the code also tells the reader that 'TLS' and 'File'
channels are processed as CH_MULTIFD via - multifd_recv_new_channel().

> No else clause here and in the rest of the patch makes this is as opaque
> as the previous version, IMO. We need to define what's supposed to
> happen whenever the conditionals don't match. Is it an error,
> g_assert_not_reached(), a fallthrough? Better to set CH_MAIN explicitly
> wherenever that's the case.

* I'd say let's treat unmatched conditions as an error and return.

> > -        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
> > -    } else {
> > -        default_channel = !mis->from_src_file;
> > +    } else if (mis->from_src_file) {
> > +        channel = CH_POSTCOPY;
> >      }
>
> Same here.

* Here final else means the main channel (mis->from_src_file) is not
established, so it defaults to CH_MAIN.

>
> You could check CH_POSTCOPY first in the block above this one and return
> early.
>

* Okay.

* My request is the same - let's think about having consistent channel
behaviour. The restructuring and overhauling of the channel processing
part could be done separately, outside the current scope of enabling
multifd+postcopy together with this series. Let's not try to fix
everything in one go, in one series.


Thank you.
---
  - Prasad


