Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2330C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 13:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjfjV-0005mn-Ai; Mon, 11 Mar 2024 09:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjfjT-0005lI-DC
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjfjR-000678-JY
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710163820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+H5YYMjIVZBSfMFh1LcHfcpjI+8vhercDgLYUV4wJk=;
 b=IP1CktjyfoTJoj95K/gNPym75wCSxVi7W1Z+JxkWjB0OSxd8ikan8WwGHHwllsuwOdlS0i
 JKJIESbR6eNK5YStbasOkIwoFxyAblpKpfehWIo2FA7kspxuvz7nZ3/zDkktT6aySycmFk
 PX29XdUhGElXxDiVjQ/q5ha4ZTdHCCY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-MjhsH6itONiHo9sFMB1ixQ-1; Mon, 11 Mar 2024 09:30:19 -0400
X-MC-Unique: MjhsH6itONiHo9sFMB1ixQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-690b5ad0e61so14149726d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 06:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710163819; x=1710768619;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W+H5YYMjIVZBSfMFh1LcHfcpjI+8vhercDgLYUV4wJk=;
 b=o/bixfgzq5IgvZAOu6k3INyinCg/r0ev0FDfLyulsGt8UUfQUmH3Sg94ON2Ved3nu4
 KN6ytLyQabalamT5QWSeFUlVvXpDDoSGAhauPeXkiqQFgW3pMlj0iADHHYa3L/ixYUCY
 qWaqp/3eB06OfpdwXYlScMsGeaNygpIZ0Oh18lt/vrQLH4r0OkqzuXvkLiE5Rp3dEhg/
 p016Vr4HegwlB3J/l8A9PjgAYwSjV/GvDTIcnSgtN325VGgIAdy/puyDXzHl0WCe4t63
 Ta7wHlDEW6KBofQ9p+lU/97XgYdL6z5t6I2WEWSmi4vJiF/+j0oTayIY33BdXUgu7389
 PLCA==
X-Gm-Message-State: AOJu0YyBFsBKSBt47nmEK0/rps6gtub6e1AXIBQb2gJj14M/A7Pn92X8
 79DNrN5aTeGMbxzkqt+9NHvY9RGsaeWa5wWBqSQRre48LyFk/qVAzYfXbF24j6Nye/jyrmvurEb
 apphefvzmGKR+KAPJXwFemYXWglTYZ1zPKTdQWAPnZbfkVR/cXy9a
X-Received: by 2002:ac8:5c02:0:b0:42f:30d1:f7e5 with SMTP id
 i2-20020ac85c02000000b0042f30d1f7e5mr8999564qti.2.1710163819054; 
 Mon, 11 Mar 2024 06:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF42GVVOS3XJT9z2FZQWrqkEo4XtVZsBNnpyeaLPzjqNP4sq1pjm/pXa6Pnem5GklVqyBoIzQ==
X-Received: by 2002:ac8:5c02:0:b0:42f:30d1:f7e5 with SMTP id
 i2-20020ac85c02000000b0042f30d1f7e5mr8999546qti.2.1710163818722; 
 Mon, 11 Mar 2024 06:30:18 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 a8-20020ac81088000000b0042efc6ad5a9sm2691687qtj.23.2024.03.11.06.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 06:30:18 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:30:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 25/27] migration/multifd: Add mapped-ram support to fd: URI
Message-ID: <Ze8HaelZE3Ccljq8@x1n>
References: <20240304012634.95520-1-peterx@redhat.com>
 <20240304012634.95520-26-peterx@redhat.com>
 <Ze7zHaHBaCRO8qKu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze7zHaHBaCRO8qKu@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 11, 2024 at 12:03:41PM +0000, Daniel P. Berrangé wrote:
> On Mon, Mar 04, 2024 at 09:26:32AM +0800, peterx@redhat.com wrote:
> > From: Fabiano Rosas <farosas@suse.de>
> > 
> > If we receive a file descriptor that points to a regular file, there's
> > nothing stopping us from doing multifd migration with mapped-ram to
> > that file.
> > 
> > Enable the fd: URI to work with multifd + mapped-ram.
> > 
> > Note that the fds passed into multifd are duplicated because we want
> > to avoid cross-thread effects when doing cleanup (i.e. close(fd)). The
> > original fd doesn't need to be duplicated because monitor_get_fd()
> > transfers ownership to the caller.
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Link: https://lore.kernel.org/r/20240229153017.2221-23-farosas@suse.de
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/fd.h        |  2 ++
> >  migration/fd.c        | 44 +++++++++++++++++++++++++++++++++++++++++++
> >  migration/file.c      | 18 ++++++++++++------
> >  migration/migration.c |  4 ++++
> >  migration/multifd.c   |  2 ++
> >  5 files changed, 64 insertions(+), 6 deletions(-)
> > 
> 
> > @@ -73,4 +98,23 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
> >                                 fd_accept_incoming_migration,
> >                                 NULL, NULL,
> >                                 g_main_context_get_thread_default());
> > +
> > +    if (migrate_multifd()) {
> > +        int channels = migrate_multifd_channels();
> > +
> > +        while (channels--) {
> > +            ioc = QIO_CHANNEL(qio_channel_file_new_fd(dup(fd)));
> > +
> > +            if (QIO_CHANNEL_FILE(ioc)->fd == -1) {
> > +                error_setg(errp, "Failed to duplicate fd %d", fd);
> > +                return;
> > +            }
> 
> I'd suggest that Peter's comment about failure checks be fixed
> by introducing a new constructor that handles the dup + error
> reporting.
> 
>    QIOChannel *qio_channel_file_new_dupfd(int fd, Error **errp;)
> 
> so we're not repeating the error reporting multiple places.

Indeed that looks cleaner.

At the meantime, I just noticed there seems to have an IOC leak on incoming
side..  file_start_incoming_migration():

    do {
        QIOChannel *ioc = QIO_CHANNEL(fioc);

        qio_channel_set_name(ioc, "migration-file-incoming");
        qio_channel_add_watch_full(ioc, G_IO_IN,
                                   file_accept_incoming_migration,
                                   NULL, NULL,
                                   g_main_context_get_thread_default());

        fioc = qio_channel_file_new_fd(dup(fioc->fd)); <-------------------- here

        if (!fioc || fioc->fd == -1) {
            error_setg(errp, "Error creating migration incoming channel");
            break;
        }
    } while (++i < channels);

Fabiano, would you send patches to address these issues (split if both
issues exist)?

Thanks,

-- 
Peter Xu


