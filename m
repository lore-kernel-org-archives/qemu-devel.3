Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D748DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeBV-0006BX-0l; Mon, 11 Mar 2024 07:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjeBR-0006AZ-Dc
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:51:09 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjeBJ-0002V7-MS
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:51:05 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-568107a9ff2so4663363a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710157858; x=1710762658; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gqXuoKBXSvC/YtNYmDJS8kBZEOOdWxXHQNiKMIsloUg=;
 b=xA0vrUwhVL9n0ymkA9VqRG3A/t8Np8F5w20r8VuIU6yPF6V5esE/7QnBt9N1DnJbNC
 2zxAi2jM7AbpdkFR0TABMU+/yIQEAhXC3wjs4sY4rnrStvKEiO9Gp8FHfzdiUpGqYLzx
 bEQI7U2lzVKTGPnmKA+j6oLkaNvkpE7LjFxoUa4tqj9pLA8Le2xVmPpZxtxdQcp5TijK
 YSrHjNTxhBToEZvH3l0zpzMASWgjr87uJ7TzHzkGcBE7BXMTaaCKNYIaMTZ9DfXAGWbI
 +9WIpdvdfB2Fnvq5GFvKrhqPvsuKhhwboVqk+OcdH0AoRV1oIlXD97ahkwC85CsvOWZb
 GbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710157858; x=1710762658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gqXuoKBXSvC/YtNYmDJS8kBZEOOdWxXHQNiKMIsloUg=;
 b=M6tZn1rabuaP1S5Dn3C0QPa6fzXVRA8M2R6FaoDTJ4dTJpUBe+MIJSnWCgbbTXCtZK
 aJ1grUp4w36p4KZVjFkJOkKLGjjdIOqvgYcWoiEyADrIVwwpZh+w1YVxz/4aJcpX2Go+
 cRlmVieAbKDMphrfjWuiRBRITzdKgbHTQb+PHdX4NKbC2RJQKvuRU0Bzpkjw1UWUfYq9
 R0NQfRltLryWhjpafemZm+7izkopW5tBIuje6mgdo6facszzKVVckT953iFuzck2xBO5
 A/n/5AXo56vNntVY6wLpPTnjk4sCXY+GuhuF6ERLLMcBWefnxbM4Owmtpcb1oQgM4uVs
 zhHw==
X-Gm-Message-State: AOJu0YxVblOdDpSWFVHvaNE0GZjB7SnYlXqUrVTd24DY0pWu24afQelG
 71/Yv01QYqjvwqaKe0JBNXi/p4rVoVcF9uGuAG+zPVgWdaFrdIxnPar4rSo58khlW/2Y5gOC8z9
 5agxpcK7iz5Y3+v7zD+PgGGpYMCE+1LzuntJVDA==
X-Google-Smtp-Source: AGHT+IGuMaMYimCuE1ZkkIcPxPXASyDXhWtPk4vfBej+tqppK35Zwdar1HqNlXHFukgR0dEf6Lzs81XACUL5g34LovA=
X-Received: by 2002:a50:bb4c:0:b0:568:a18:2eb3 with SMTP id
 y70-20020a50bb4c000000b005680a182eb3mr4637871ede.11.1710157858193; Mon, 11
 Mar 2024 04:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240304012634.95520-1-peterx@redhat.com>
 <20240304012634.95520-26-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-26-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2024 11:50:47 +0000
Message-ID: <CAFEAcA-nfqP3LyGyvoeCSUce4OX5t_N_VcDc07Wa_GMEs4B5dg@mail.gmail.com>
Subject: Re: [PULL 25/27] migration/multifd: Add mapped-ram support to fd: URI
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 4 Mar 2024 at 01:28, <peterx@redhat.com> wrote:
>
> From: Fabiano Rosas <farosas@suse.de>
>
> If we receive a file descriptor that points to a regular file, there's
> nothing stopping us from doing multifd migration with mapped-ram to
> that file.
>
> Enable the fd: URI to work with multifd + mapped-ram.
>
> Note that the fds passed into multifd are duplicated because we want
> to avoid cross-thread effects when doing cleanup (i.e. close(fd)). The
> original fd doesn't need to be duplicated because monitor_get_fd()
> transfers ownership to the caller.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Link: https://lore.kernel.org/r/20240229153017.2221-23-farosas@suse.de
> Signed-off-by: Peter Xu <peterx@redhat.com>

Hi; Coverity points out some issues with this commit (CID 1539961, 1539965):


> @@ -73,4 +98,23 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
>                                 fd_accept_incoming_migration,
>                                 NULL, NULL,
>                                 g_main_context_get_thread_default());
> +
> +    if (migrate_multifd()) {
> +        int channels = migrate_multifd_channels();
> +
> +        while (channels--) {
> +            ioc = QIO_CHANNEL(qio_channel_file_new_fd(dup(fd)));

dup() can fail and return -1, but we don't check for failure
and pass the return value directly to qio_channel_file_new_fd(),
which will call lseek() on it, which isn't valid.

> +
> +            if (QIO_CHANNEL_FILE(ioc)->fd == -1) {
> +                error_setg(errp, "Failed to duplicate fd %d", fd);
> +                return;
> +            }
> +
> +            qio_channel_set_name(ioc, "migration-fd-incoming");
> +            qio_channel_add_watch_full(ioc, G_IO_IN,
> +                                       fd_accept_incoming_migration,
> +                                       NULL, NULL,
> +                                       g_main_context_get_thread_default());
> +        }
> +    }

> @@ -53,15 +54,20 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
>  {
>      QIOChannelFile *ioc;
>      int flags = O_WRONLY;
> -    bool ret = true;
> -
> -    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
> -    if (!ioc) {
> -        ret = false;
> -        goto out;
> +    bool ret = false;
> +    int fd = fd_args_get_fd();
> +
> +    if (fd && fd != -1) {
> +        ioc = qio_channel_file_new_fd(dup(fd));

Similarly here.

> +    } else {
> +        ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
> +        if (!ioc) {
> +            goto out;
> +        }
>      }
>
>      multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
> +    ret = true;
>
>  out:
>      /*

thanks
-- PMM

