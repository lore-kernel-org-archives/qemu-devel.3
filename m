Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66A1D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t81CS-0003n6-MN; Mon, 04 Nov 2024 12:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t81CM-0003mb-4s
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:49:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t81CH-0002Yg-P2
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730742540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TB0B9/H4+SCYpocGOjjrxkSQWt5gX5v0PtUhSyTLyCs=;
 b=QTodL8CgLyeK04p709kdP1RzaRACY5ZDNK0MFfORNcn9oDdOhuY0ZPzOn+TrReAXhbVoYT
 u0kpAUzsJ0whQy3w2rbbdtCv9FraS7jItDCf24ddNOjeugzlDnExCKdH1iSwwJUtnsE5aX
 L1jlZ7q1uxgqI6p3dLQmKcBKpMZcYDc=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-iDCuo-PBOc6mfa56eP1g8g-1; Mon, 04 Nov 2024 12:48:58 -0500
X-MC-Unique: iDCuo-PBOc6mfa56eP1g8g-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5eb969bcfc9so3581156eaf.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742538; x=1731347338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TB0B9/H4+SCYpocGOjjrxkSQWt5gX5v0PtUhSyTLyCs=;
 b=Fph+aIQgH8PJpuHWEqDVkV7B2YX8/yvCj5wgydx23154XJWjSGEeHp8kil45qcgPEt
 wv83CiMSwGpIB9/dD3YWE0e9VvC4BPn+yCoWnLe+Ywnl5ry7rYjOmcH/JtFUQspU9HFa
 GJ21LdsZyDAMK6y0rEloU/4gr85V5Wx7ED1i9jslJJiuRsrLA6CNVOzMdBHDBloBderK
 Lr3VvyXYHdP8Cdzhr7qUbw04oxNgEq8oyxsGn6yJW8tUCpnj6eC/IBvoPpTgcYz8VM0p
 SWzDnsS+W6CiqSYoS29UQqjUgoO+6LK1y/6ONHFXneoBPFyXRTIyliZIZsSke+KhUmFS
 neVw==
X-Gm-Message-State: AOJu0YyhqtKkpzVjEEldV6cLp/SXlVgUnGwI5+GJJKRxriR3SunEqKnZ
 2k4kYzfkTUsI+ru/28my225UTpxwUfS2egS5E+tHSuqmzhmSMOPB2NxfMVKjWX6J8ya+kmP3Rvd
 pwK39wJQxuRt4XbtSB+YBgnZgdT4HtejtkJGiIbChtAT92DSA/9Eo
X-Received: by 2002:a05:6820:1b94:b0:5ec:5eb6:1acc with SMTP id
 006d021491bc7-5ec6db9a003mr9370956eaf.5.1730742537560; 
 Mon, 04 Nov 2024 09:48:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/ufnwBs5ZCpBiWUkME3Q/GQ/GPa6HlDQNWLmVf0FQBcIm7Wrxvb1r7eAyrfQxxbcjWgHWDg==
X-Received: by 2002:a05:6820:1b94:b0:5ec:5eb6:1acc with SMTP id
 006d021491bc7-5ec6db9a003mr9370940eaf.5.1730742537107; 
 Mon, 04 Nov 2024 09:48:57 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ec7060762bsm1896876eaf.37.2024.11.04.09.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:48:56 -0800 (PST)
Date: Mon, 4 Nov 2024 12:48:54 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 5/5] migration: enable multifd and postcopy together
Message-ID: <ZykJBq7ME5jgSzCA@x1n>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-6-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029150908.1136894-6-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Oct 29, 2024 at 08:39:08PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Enable Multifd and Postcopy migration together.
> The migration_ioc_process_incoming() routine
> checks magic value sent on each channel and
> helps to properly setup multifd and postcopy
> channels.
> 
> Idea is to take advantage of the multifd threads
> to accelerate transfer of large guest RAM to the
> destination and switch to postcopy mode sooner.
> 
> The Precopy and Multifd threads work during the
> initial guest RAM transfer. When migration moves
> to the Postcopy phase, the source guest is
> paused, so the Precopy and Multifd threads stop
> sending data on their channels. Postcopy threads
> on the destination request/pull data from the
> source side.

Hmm I think this is not the truth..

Precopy keeps sending data even during postcopy, that's the background
stream (with/without preempt feature enabled).  May need some amendment
when repost here.

> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/migration.c | 73 ++++++++++++++++++++++++++-----------------
>  1 file changed, 44 insertions(+), 29 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 021faee2f3..11fcc1e012 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -92,6 +92,9 @@ enum mig_rp_message_type {
>      MIG_RP_MSG_MAX
>  };
>  
> +/* Migration channel types */
> +enum { CH_DEFAULT, CH_MULTIFD, CH_POSTCOPY };
> +
>  /* When we add fault tolerance, we could have several
>     migrations at once.  For now we don't need to add
>     dynamic creation of migration */
> @@ -919,16 +922,15 @@ void migration_fd_process_incoming(QEMUFile *f)
>   * Returns true when we want to start a new incoming migration process,
>   * false otherwise.
>   */
> -static bool migration_should_start_incoming(bool main_channel)
> +static bool migration_should_start_incoming(uint8_t channel)
>  {
> +    if (channel == CH_POSTCOPY) {
> +        return false;
> +    }

Please see my other reply, I think here it should never be POSTCOPY
channel, because postcopy (aka, preempt) channel is only created after the
main channel..

So I wonder whether this "if" will hit at all.

> +
>      /* Multifd doesn't start unless all channels are established */
>      if (migrate_multifd()) {
> -        return migration_has_all_channels();
> -    }
> -
> -    /* Preempt channel only starts when the main channel is created */
> -    if (migrate_postcopy_preempt()) {
> -        return main_channel;
> +        return multifd_recv_all_channels_created();

I think this is incorrect.. We should also need to check main channel is
established before start incoming.  The old code uses
migration_has_all_channels() which checks that.

>      }
>  
>      /*
> @@ -936,7 +938,7 @@ static bool migration_should_start_incoming(bool main_channel)
>       * it's the main channel that's being created, and we should always
>       * proceed with this channel.
>       */
> -    assert(main_channel);
> +    assert(channel == CH_DEFAULT);
>      return true;
>  }
>  
> @@ -945,13 +947,11 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      Error *local_err = NULL;
>      QEMUFile *f;
> -    bool default_channel = true;
>      uint32_t channel_magic = 0;
> +    uint8_t channel = CH_DEFAULT;
>      int ret = 0;
>  
> -    if (migrate_multifd() && !migrate_mapped_ram() &&
> -        !migrate_postcopy_ram() &&
> -        qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> +    if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
>          /*
>           * With multiple channels, it is possible that we receive channels
>           * out of order on destination side, causing incorrect mapping of
> @@ -969,35 +969,49 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>              return;
>          }
>  
> -        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
> -    } else {
> -        default_channel = !mis->from_src_file;
> +        if (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC)) {
> +            channel = CH_DEFAULT;
> +        } else if (channel_magic == cpu_to_be32(MULTIFD_MAGIC)) {
> +            channel = CH_MULTIFD;
> +        } else if (channel_magic == cpu_to_be32(POSTCOPY_MAGIC)) {
> +            if (qio_channel_read_all(ioc, (char *)&channel_magic,
> +                                sizeof(channel_magic), &local_err)) {
> +                error_report_err(local_err);
> +                return;
> +            }
> +            channel = CH_POSTCOPY;
> +        } else {
> +            error_report("%s: could not identify channel, unknown magic: %u",
> +                           __func__, channel_magic);
> +            return;
> +        }
>      }
>  
>      if (multifd_recv_setup(errp) != 0) {
>          return;
>      }
>  
> -    if (default_channel) {
> +    if (channel == CH_DEFAULT) {
>          f = qemu_file_new_input(ioc);
>          migration_incoming_setup(f);
> -    } else {
> +    } else if (channel == CH_MULTIFD) {
>          /* Multiple connections */
> -        assert(migration_needs_multiple_sockets());
>          if (migrate_multifd()) {
>              multifd_recv_new_channel(ioc, &local_err);
> -        } else {
> +        }
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    } else if (channel == CH_POSTCOPY) {
> +        if (migrate_postcopy()) {
>              assert(migrate_postcopy_preempt());
>              f = qemu_file_new_input(ioc);
>              postcopy_preempt_new_channel(mis, f);
>          }
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
>      }
>  
> -    if (migration_should_start_incoming(default_channel)) {
> +    if (migration_should_start_incoming(channel)) {
>          /* If it's a recovery, we're done */
>          if (postcopy_try_recover()) {
>              return;
> @@ -1014,21 +1028,22 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>   */
>  bool migration_has_all_channels(void)
>  {
> +    bool ret = false;
>      MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      if (!mis->from_src_file) {
> -        return false;
> +        return ret;
>      }
>  
>      if (migrate_multifd()) {
> -        return multifd_recv_all_channels_created();
> +        ret = multifd_recv_all_channels_created();
>      }
>  
> -    if (migrate_postcopy_preempt()) {
> -        return mis->postcopy_qemufile_dst != NULL;
> +    if (ret && migrate_postcopy_preempt()) {
> +        ret = mis->postcopy_qemufile_dst != NULL;
>      }

IMHO it's clearer written as:

       if (migrate_multifd()) {
           if (!multifd_recv_all_channels_created()) {
               return false;
           }
       }

       if (migrate_preempt()) {
           if (mis->postcopy_qemufile_dst == NULL) {
               return false;
           }
       }

       return true;

>  
> -    return true;
> +    return ret;
>  }

I don't yet see how you manage the multifd threads, etc, on both sides.  Or
any logic to make sure multifd will properly flush the pages before
postcopy starts.  IOW, any guarantee that all the pages will only be
installed using UFFDIO_COPY as long as vcpu starts on dest.  Any comments?

The most complicated part of this work would be testing, to make sure it
works in all previous cases, and that's majorly why we disabled it before:
it was because it randomly crashes, but not always; fundamentally it's
because when multifd was designed there wasn't enough consideration on
working together with postcopy.  We didn't clearly know what's missing at
that time.

So we would definitely need to add test cases, just like whoever adds new
features to migration, to make sure at least it works for existing multifd
/ postcopy test cases, but when both features enabled.

Some hints on what we can add (assuming we already enable both features):

  - All possible multifd test cases can run one more time with postcopy
    enabled, but when precopy will converge and finish / cancel migration.

    e.g.:

    /x86_64/migration/multifd/file/mapped-ram/*

    These ones need to keep working like before, it should simply ignore
    postcopy being enabled.

    /x86_64/migration/multifd/tcp/uri/plain/none

    This one is the most generic multifd test, we'd want to make this run
    again with postcopy enabled, so it verifies it keeps working if it can
    converge before postcopy enabled.

    /x86_64/migration/multifd/tcp/plain/cancel

    This one tests multifd cancellations, and we want to make sure this
    works too when postcopy is enabled.

  - All possible postcopy test cases can also run one more time with
    multifd enabled.  Exmaples:

    /x86_64/migration/postcopy/plain

    The most generic postcopy test, we want to run this with multifd
    enabled, then this will cover the most simple use case of
    multifd-precopy plus postcopy.

    /x86_64/migration/postcopy/recovery/*

    These tests cover the fundamental postcopy recovery (plan, fails in
    handshake, fails in reconnect, or when using TLS), we may want to make
    sure these work even if multifd cap is enabled.

    /x86_64/migration/postcopy/preempt/*

    Similarly like above, but it now enables preempt channels too.

It will add quite a few tests to run here, but I don't see a good way
otherwise when we want to enable the two features, because it is indeed a
challenge to enable the two major features together here.

You can also do some manual tests with real workloads when working on this
series, that'll be definitely very helpful.  I had a feeling that this
series could already fail some when enable both features, but please give
it a shot.

Thanks,

-- 
Peter Xu


