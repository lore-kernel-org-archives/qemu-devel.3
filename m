Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21C6C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLfe-0002jB-LW; Fri, 07 Feb 2025 05:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tgLfX-0002iO-Ey
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tgLfV-0003Mi-O9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738924385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvWFizoz9pJGHnfDdSO1CR7ZlUrvUtkaOixb6rFsBNA=;
 b=b6iwGbHqapQwvp/+Sa3Ay04GZHnlho8VZ/nQEyoW2IHki74Nb9/de/ahYuCmdax+T5PcEg
 h4Y3FFqPRXDx0QYVbyiSKkioxCQkOfghnUZTu/MxZV6MWx4DKcXpr31vx7PLlgVsjoZ41n
 2fdxdxsR8g1u5p+3s9TXbqeOAlMP4/U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-NtjUAF4gM92YLOyi4Y5eCg-1; Fri, 07 Feb 2025 05:33:03 -0500
X-MC-Unique: NtjUAF4gM92YLOyi4Y5eCg-1
X-Mimecast-MFC-AGG-ID: NtjUAF4gM92YLOyi4Y5eCg
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dc88ed7caso386038f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738924382; x=1739529182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pvWFizoz9pJGHnfDdSO1CR7ZlUrvUtkaOixb6rFsBNA=;
 b=ajf6XwPeQat6GwQF8C9yk/pOMiuTkB2DckZyCRde9JwM/LpYAqD/gKFV76lqHr5LVF
 Eh915ztwD7Vy6jwI41uYq/HX/7yfp9EyBp7vFcwPm68rvOpB/YRR9v/3q1b7BMyQsfvW
 Zdae/KizYKxPW/SP8ZlZzMeYm5bBzE6gHbqxb9Hi7dKgsxVEQ2OQSQXvN9caK00wnGvg
 NxArd5NvBcFf4w02fZsfaLrCqNR25SQgPFZ1Apwac4v0qY90z23NguExph0HMFxfqi6b
 1jtXfBiB6pfuSLocj1Vu4r4FL5UA3bpugTcrPUiL83JQLjSSd7FWpMB6+6bfHseCaCYF
 8s5Q==
X-Gm-Message-State: AOJu0YykazjHuFyGO+wv+1jQWNYUtRR81586Xk481vdJtx+qxcx+72md
 0PqzfnIUGrfbxLEb3TI9tkupBfT50gF+VUrJbddrLvH9+jlErUOwtT7lCzPN65/iTgzAmkW0VHY
 okazorqykgF/9bXMKf7ghjjp6uCKPhKDPDLX4E0LGjfKj711YUDgXzWwyCMA5GaNur/tXFLd2yN
 9Za1Thy2StTIyAoekj2ETE5BlEOl8=
X-Gm-Gg: ASbGncshC1ntooD0zWlKsVWoQvVg9nF8qve44iHUJmyfPHolXMPOP5kk7dSyrCaLifi
 zo2uY8BsTpcjts/7pWMnIHlnD+6MJIRlNTDZjaIXXoxBtQfwuYQIIFbDVa2a40g==
X-Received: by 2002:a5d:5986:0:b0:38d:cf79:20a2 with SMTP id
 ffacd0b85a97d-38dcf7924f6mr455305f8f.35.1738924382381; 
 Fri, 07 Feb 2025 02:33:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/D4kx2CNFqPlPETolNxfwpBOLKksXIPC3hCnfeFOO3jdEHT1OecECXiVxUFu3iszamjFPokMUdtpX1eeaZPc=
X-Received: by 2002:a5d:5986:0:b0:38d:cf79:20a2 with SMTP id
 ffacd0b85a97d-38dcf7924f6mr455284f8f.35.1738924381992; Fri, 07 Feb 2025
 02:33:01 -0800 (PST)
MIME-Version: 1.0
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-4-ppandit@redhat.com>
 <Z6VCxEKxn6-_okRx@x1.local>
In-Reply-To: <Z6VCxEKxn6-_okRx@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 7 Feb 2025 16:02:44 +0530
X-Gm-Features: AWEUYZmQCEw7HiJYBIqjttDo1vqQDGMumhp7FiNmrJ3xqFX4UNgqXsP50u-lEpQ
Message-ID: <CAE8KmOwJSYq2Ok38_sq29cr7JhbLLh1ZEncP13QpDdnYKOAheQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] migration: enable multifd and postcopy together
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
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

Hi,

On Fri, 7 Feb 2025 at 04:46, Peter Xu <peterx@redhat.com> wrote:
> > +/* Migration channel types */
> > +enum { CH_DEFAULT, CH_MULTIFD, CH_POSTCOPY };
>
> Maybe s/DEFAULT/MAIN/?

* Okay.

> > -    if (migrate_multifd() && !migrate_mapped_ram() &&
> > -        !migrate_postcopy_ram() &&
> > -        qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> > +    if (!migration_should_start_incoming(channel)) {
>
> This says "if we assume this is the main channel, and if we shouldn't start
> incoming migration, then we should peek at the buffers".
> Could you help explain?

* New migration starts only when the main channel and if 'multifd' is
enabled all multifd channels are established. So, if 'main' and
'multifd' channels are _not_ established then migration should _not_
start. And in that case, incoming connection is likely for one of
those channels and so we should peek at the buffers, because both
'main' and 'multifd' channels send magic values.

* migration_should_start_incoming() function returns 'true' only when
'main' and 'multifd' channels are being established. For 'postcopy'
channel it returns false.


> > +            } else if (!mis->from_src_file
> > +                        && mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> > +                /* reconnect default channel for postcopy recovery */
> > +                channel = CH_DEFAULT;
>
> This is still in the big "peek buffer" if condition.
> IMHO we can skip peeking buffer when postcopy paused, because in this stage
> the channel must be (1) main channel first, then (2) preempt channel next.

* It is in the big 'peek buffer' condition because the 'main' channel
(= CH_DEFAULT) is being established here. Ideally, all channels should
send magic values to be consistent. The 'main' channel sends magic
value when it is established before starting migration, but the same
'main' channel does not send magic value when it is established during
postcopy recovery, that is an inconsistency (a bug) here. Ideal fix is
to send a magic value every time the 'main' channel is established,
irrespective of when it is established.

* Adding conditionals to check if it is _POSTCOPY_PAUSED state then
don't peek will only lead to complicated 'if' conditionals. This
channel handling code is already complex and non-intuitive enough.

> > +        } else if (mis->from_src_file
> > +            && (!strcmp(ioc->name, "migration-tls-incoming")
> > +                || !strcmp(ioc->name, "migration-file-incoming"))) {
> > +            channel = CH_MULTIFD;
>
> Confused here too.  Why do we need to check ioc name? Shouldn't multifd has
> the headers?

* Because they are not 'multifd' channels, tls/file channels don't
send magic values, but are still handled by
'multifd_recv_new_channel()' function.
===
    ...
    if (default_channel) {
        migration_incoming_setup(f);
    } else {
        if (migrate_multifd()) {
            multifd_recv_new_channel(ioc, &local_err);
        } else {
            postcopy_preempt_new_channel(mis, f);
        }
===
In the code above, if 'default_channel==false' and multifd() is
enabled, all incoming connections are handled by
'multifd_recv_new_channel()', irrespective of whether it is a
'multifd' channel or not. While creating multifd channels, there is no
check for channel type like: if(channel == CH_MULTIFD).

* IMHO, if we make all channels behave with consistency, ie. either
they all send magic value or none sends magic value, that'll simplify
this code a lot.

> > -        assert(migration_needs_multiple_sockets());
> Could I ask why removal?

* Because that function returns migrate_multifd() =>
migrate_multifd() || migrate_postcopy_preempt();
* And the very following check is also migrate_multifd(), as below:

> >          if (migrate_multifd()) {
> >              multifd_recv_new_channel(ioc, &local_err);


> It might be better to avoid such "ret && XXX" nested check.  E.g. do you
> think below easier to read?
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 74c50cc72c..9eb2f3fdeb 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1064,12 +1064,14 @@ bool migration_has_all_channels(void)
>          return false;
>      }
>
> -    if (migrate_multifd()) {
> -        return multifd_recv_all_channels_created();
> +    if (migrate_multifd() &&
> +        !multifd_recv_all_channels_created()) {
> +        return false;
>      }
>
> -    if (migrate_postcopy_preempt()) {
> -        return mis->postcopy_qemufile_dst != NULL;
> +    if (migrate_postcopy_preempt() &&
> +        mis->postcopy_qemufile_dst == NULL) {
> +        return false;
>      }
>
>      return true;

* Will try it.

> > -    if (!migrate_multifd()) {
> > +    if (!migrate_multifd() || migration_in_postcopy()) {
> >          return 0;
> >      }
>
> [1]
>
> >
> >      if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> > diff --git a/migration/ram.c b/migration/ram.c
> > index f2326788de..bdba7abe73 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1295,7 +1295,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
> >          pss->page = 0;
> >          pss->block = QLIST_NEXT_RCU(pss->block, next);
> >          if (!pss->block) {
> > -            if (multifd_ram_sync_per_round()) {
> > +            if (multifd_ram_sync_per_round() && !migration_in_postcopy()) {
>
> If you have above[1], why need this?

* True, I tried with just [1] above first, but it was failing for some
reason. Will try again.

> This patch still did nothing for multifd in postcopy_start().  I'm not sure
> it's safe.
>
> What happens if some multifd pages were sent, then we start postcopy, dest
> vcpu threads running, then during postcopy some multifd pages finally
> arrived and modifying the guest pages during vcpus running?

* ram_save_target_page() function saves multifd pages only when
(..!migration_in_postcopy()) not in postcopy mode. Case of 'multifd'
page arriving late on destination and 'postcopy' starting before that
is strange, because if multifd page is getting late, that network
latency should affect 'postcopy' channel too, no? But still if it is
possible, do we want to call - multifd_ram_flush_and_sync() before
postcopy_start()? Will that help?  I'll check if/how it works.

Thank you.
---
  - Prasad


