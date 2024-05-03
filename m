Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18EBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2xeu-00067e-Ul; Fri, 03 May 2024 14:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2xes-00066e-Os
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2xeq-00031T-Md
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714760959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1rPIRY9vGjfDPXkI8Qu0uuiDGjnCGWXY3SIOL/D3DmI=;
 b=iXMXBEpDh2VAuup5iBq8Lz1YDdKDEorUg1IEV0CHpo9PWWgv3xdPrYXPl5FHmLDTlQJTOb
 aStYPpTmst/TY9zuc9MNh0iLm/FguNjM6YkZ2V+wjexAkpWe2MGfCBfIgiXoIsufitAO1i
 Bs5M0eX6/vyMcghgqX2S7JIWawW7jJ0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-RN4DUGhlPUq-PF8yrFNIGw-1; Fri, 03 May 2024 14:29:18 -0400
X-MC-Unique: RN4DUGhlPUq-PF8yrFNIGw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6a0dd73810bso6203826d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 11:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714760957; x=1715365757;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rPIRY9vGjfDPXkI8Qu0uuiDGjnCGWXY3SIOL/D3DmI=;
 b=a9ltrBCxHZW4S1ZwW1CvMcWXgiwiSDHNzNqGe6vLpw7S0b/2/9rS2rq77nEnxlo97q
 Ph9tH5uwiy46E65ydOuedB35B8kyekAy5qJcZ+HFHunXd7UQllJVbOYrRu8N7I96Bcbv
 jOpEetPcF5E5HVUiiuVRpPh2QwJdtq9DyBrf3quODI2PVBP62D+u4NqO6FiARszRHXTk
 fwSL+GbzsgbLJlrRsf3gZGfjorv/NxxEPRYylEl1UJTb+71u9B5W7p8ixDggiNfTZtH4
 qn2i5Q+Xgq8Ka1xh8PNtBkuSUEefDaQPVec89vjMEgibVLZon0+Y06O+YAfoLIvCZfP2
 SREQ==
X-Gm-Message-State: AOJu0YzFZDss6mOL2I3Zq9/tnfM0Jc1Xwz8YnOAYkb/w52E4NTnjKrw3
 lJikZ3tlKdtgjud/7Kk8IlsIYTlqUb6Za4aCewcjcArEqvC7qz4+gsEI4FpPoQQHTeCj85NRTT4
 Aciaitlyy7AccnQvmW1RPRz3uD4rraZ1D9zQhNbasmuLoWrHL43JN
X-Received: by 2002:a05:6214:5185:b0:6a0:87e5:210c with SMTP id
 kl5-20020a056214518500b006a087e5210cmr3565664qvb.5.1714760957388; 
 Fri, 03 May 2024 11:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeWgnXEFaBdn4Q6Em639jjKUhI3QFgjKaPuzu3ph5PbJhzoDUPv6Rq/zcG7HZnpkUkdVvVLA==
X-Received: by 2002:a05:6214:5185:b0:6a0:87e5:210c with SMTP id
 kl5-20020a056214518500b006a087e5210cmr3565639qvb.5.1714760956769; 
 Fri, 03 May 2024 11:29:16 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 pp21-20020a056214139500b006a0affc7c6esm1401730qvb.63.2024.05.03.11.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 11:29:16 -0700 (PDT)
Date: Fri, 3 May 2024 14:29:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 5/9] migration/multifd: Add direct-io support
Message-ID: <ZjUs-2mhVDrPd3Kl@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 26, 2024 at 11:20:38AM -0300, Fabiano Rosas wrote:
> When multifd is used along with mapped-ram, we can take benefit of a
> filesystem that supports the O_DIRECT flag and perform direct I/O in
> the multifd threads. This brings a significant performance improvement
> because direct-io writes bypass the page cache which would otherwise
> be thrashed by the multifd data which is unlikely to be needed again
> in a short period of time.
> 
> To be able to use a multifd channel opened with O_DIRECT, we must
> ensure that a certain aligment is used. Filesystems usually require a
> block-size alignment for direct I/O. The way to achieve this is by
> enabling the mapped-ram feature, which already aligns its I/O properly
> (see MAPPED_RAM_FILE_OFFSET_ALIGNMENT at ram.c).
> 
> By setting O_DIRECT on the multifd channels, all writes to the same
> file descriptor need to be aligned as well, even the ones that come
> from outside multifd, such as the QEMUFile I/O from the main migration
> code. This makes it impossible to use the same file descriptor for the
> QEMUFile and for the multifd channels. The various flags and metadata
> written by the main migration code will always be unaligned by virtue
> of their small size. To workaround this issue, we'll require a second
> file descriptor to be used exclusively for direct I/O.
> 
> The second file descriptor can be obtained by QEMU by re-opening the
> migration file (already possible), or by being provided by the user or
> management application (support to be added in future patches).
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/file.c      | 22 +++++++++++++++++++---
>  migration/migration.c | 23 +++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index 8f30999400..b9265b14dd 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -83,17 +83,33 @@ void file_cleanup_outgoing_migration(void)
>  
>  bool file_send_channel_create(gpointer opaque, Error **errp)
>  {
> -    QIOChannelFile *ioc;
> +    QIOChannelFile *ioc = NULL;
>      int flags = O_WRONLY;
> -    bool ret = true;
> +    bool ret = false;
> +
> +    if (migrate_direct_io()) {
> +#ifdef O_DIRECT
> +        /*
> +         * Enable O_DIRECT for the secondary channels. These are used
> +         * for sending ram pages and writes should be guaranteed to be
> +         * aligned to at least page size.
> +         */
> +        flags |= O_DIRECT;
> +#else
> +        error_setg(errp, "System does not support O_DIRECT");
> +        error_append_hint(errp,
> +                          "Try disabling direct-io migration capability\n");
> +        goto out;
> +#endif

Hopefully if we can fail migrate-set-parameters correctly always, we will
never trigger this error.

I know Linux used some trick like this to even avoid such ifdefs:

  if (qemu_has_direct_io() && migrate_direct_io()) {
      // reference O_DIRECT
  }

So as long as qemu_has_direct_io() can return a constant "false" when
O_DIRECT not defined, the compiler is smart enough to ignore the O_DIRECT
inside the block.

Even if it won't work, we can still avoid that error (and rely on the
set-parameter failure):

#ifdef O_DIRECT
       if (migrate_direct_io()) {
           // reference O_DIRECT
       }
#endif

Then it should run the same, just to try making ifdefs as light as
possible..

> +    }
>  
>      ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
>      if (!ioc) {
> -        ret = false;
>          goto out;
>      }
>  
>      multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
> +    ret = true;
>  
>  out:
>      /*
> diff --git a/migration/migration.c b/migration/migration.c
> index b5af6b5105..cb923a3f62 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -155,6 +155,16 @@ static bool migration_needs_seekable_channel(void)
>      return migrate_mapped_ram();
>  }
>  
> +static bool migration_needs_multiple_fds(void)

If I suggest to rename this, would you agree? :)

I'd try with "migrate_needs_extra_fd()" or "migrate_needs_two_fds()",
or... just to avoid "multi" + "fd" used altogether, perhaps.

Other than that looks all good.

Thanks,

> +{
> +    /*
> +     * When doing direct-io, multifd requires two different,
> +     * non-duplicated file descriptors so we can use one of them for
> +     * unaligned IO.
> +     */
> +    return migrate_multifd() && migrate_direct_io();
> +}
> +
>  static bool transport_supports_seeking(MigrationAddress *addr)
>  {
>      if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> @@ -164,6 +174,12 @@ static bool transport_supports_seeking(MigrationAddress *addr)
>      return false;
>  }
>  
> +static bool transport_supports_multiple_fds(MigrationAddress *addr)
> +{
> +    /* file: works because QEMU can open it multiple times */
> +    return addr->transport == MIGRATION_ADDRESS_TYPE_FILE;
> +}
> +
>  static bool
>  migration_channels_and_transport_compatible(MigrationAddress *addr,
>                                              Error **errp)
> @@ -180,6 +196,13 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
>          return false;
>      }
>  
> +    if (migration_needs_multiple_fds() &&
> +        !transport_supports_multiple_fds(addr)) {
> +        error_setg(errp,
> +                   "Migration requires a transport that allows for multiple fds (e.g. file)");
> +        return false;
> +    }
> +
>      return true;
>  }
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu


