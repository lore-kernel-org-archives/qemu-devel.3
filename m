Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8158C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 08:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbHC-0006o0-RG; Tue, 15 Jul 2025 04:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubbHB-0006nH-2C
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:44:37 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubbH9-0006Mw-08
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:44:36 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-606b58241c9so8667775a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752569072; x=1753173872; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDJK2SKlKfUzs3hqSLVxlvx9aHG/VR5G+iFAWBvQxAM=;
 b=Knk0c4jomitxnPZ5XHXvskxcJ1qpdXfUQ3AfZg7aXhLB1w1SYqrDvZMmOVAhUYYivg
 wlNwUNcniroOO0YICUV7+VMGv3w+UE7cJbgL5UK3ydsGUmIHFumf1JZvyFVNWYoAW4dh
 B6ztacPvraZu/DoHQpphZQTndnVQZhESZhOziRyHa1JGYMizdjvAWwXXiDk2p6WjGtAF
 9cVqNdz3VQpWKjdyVcj7LM9o56i54gjZ0MVCNlHvEVZwTvwwwVUwcYs3HDeNU1g9BE0Q
 4FP8+7ab8WK7Zs9eo2siNjuRo6oXmzDZ1GEU47ElEO4h1QhEZyhGrJJhLxP6OMjl27Ks
 54UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752569072; x=1753173872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDJK2SKlKfUzs3hqSLVxlvx9aHG/VR5G+iFAWBvQxAM=;
 b=sVOApFYl/11rJoY2FjBS3Q0YQw5BxqXcTZRG3YBEn8b/TrSn7djJGlMw4eqYD9HSAM
 ga4NvRUIv6CcdhA/KTh7heUG9mvMlKjbzjuw4GuPYadgPp6XEA++RKGLCo46RcQ8cQ/Z
 RSrI1uK2gIILWEc3GFFtGE4oUNEo8xpcb0AEHb9/xU+/JKVEWY1WQGK3wXrRsyxWFV6J
 CgZv9VmVRzoyR7f1E55Te+2WHl0MgsKLHME5hyrUpjWHN41/aygZaCFbidE7X/c9NzWY
 OiPMLHqplss1bTALOvFSPZBbpotZX6p6uAMAj9Z6aNthJscdBnM540oeBgJuSKTJ2xhj
 MILg==
X-Gm-Message-State: AOJu0YzIsPLpfg8qZeCzgMUjshd8bOnVRQh7RqtC8BgqoFH2Xn1OETgF
 xRA2PgUG4qwolYNch9etAVXVD62TUaPIimTe4WfpnPkq9QSa7KiSBMvT6n1TNVQJXQv2U3vR0VA
 LN1JXWMSYf8hr348nn5LkZrEqpQ/yOOHx4JHg5Cn4vg==
X-Gm-Gg: ASbGnctXudps6YtM/KPwM6MZaOgB2kaORbP61EWx3RL2mjj67B1AaSt4WUNzMgm6s/C
 CofaZ1cDrBq03Qh5ZnN3xE2fRwQqbkQrGbLl2kxT31vkzXLFDCwMkZ/Dylj4OYGrV5f/Bkfk1yO
 BDafF9kdE5qeOHkd5h9wdB3vMUPvAW9y6Yo8EO7LkrFGGYMBA2Sh4UYc4QcK/TVEutnKnTp3gE2
 e/WiQs=
X-Google-Smtp-Source: AGHT+IEr7vdWjK2sbfcJqLBP+6SRi78vWGv49aF26hfWz+CRCNICT5wQjUdxoSCzGvHYV2pXKSlPIrEyF0tO7JT8Ud4=
X-Received: by 2002:a05:6402:b8c:b0:60e:9e2:585f with SMTP id
 4fb4d7f45d1cf-611e84cf7f4mr12273069a12.27.1752569072250; Tue, 15 Jul 2025
 01:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250715083517.47556-1-philmd@linaro.org>
 <20250715083517.47556-3-philmd@linaro.org>
In-Reply-To: <20250715083517.47556-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 15 Jul 2025 11:44:05 +0300
X-Gm-Features: Ac12FXxw8ntwfMMK2mWNcrsyFwgc-InXyaeR_LOFMrEzZbnPEvLviWjwEfhiUgo
Message-ID: <CAAjaMXZn-CHdTHfS_tv763ZcR8XHMQ3T6OVUCd51bLiw5a0ypg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] system/os-win32: Remove unused Error** argument
 in qemu_socket_select
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Jul 15, 2025 at 11:36=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> @errp is always NULL. Remove it, as unused.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/system/os-win32.h |  2 +-
>  util/aio-win32.c          |  2 +-
>  util/oslib-win32.c        | 13 +++++--------
>  3 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> index 40712a948c3..47882bc2f49 100644
> --- a/include/system/os-win32.h
> +++ b/include/system/os-win32.h
> @@ -170,7 +170,7 @@ static inline void qemu_funlockfile(FILE *f)
>
>  /* Helper for WSAEventSelect, to report errors */
>  bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
> -                        long lNetworkEvents, Error **errp);
> +                        long lNetworkEvents);
>
>  bool qemu_socket_unselect(int sockfd);
>
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index 6583d5c5f31..9c2f0fb86e7 100644
> --- a/util/aio-win32.c
> +++ b/util/aio-win32.c
> @@ -121,7 +121,7 @@ void aio_set_fd_handler(AioContext *ctx,
>
>          QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, node, node);
>          event =3D event_notifier_get_handle(&ctx->notifier);
> -        qemu_socket_select(fd, event, bitmask, NULL);
> +        qemu_socket_select(fd, event, bitmask);
>      }
>      if (old_node) {
>          aio_remove_fd_handler(ctx, old_node);
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 7ac3482d449..fed5ab14efb 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -292,21 +292,18 @@ char *qemu_get_pid_name(pid_t pid)
>
>
>  bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
> -                        long lNetworkEvents, Error **errp)
> +                        long lNetworkEvents)
>  {
>      SOCKET s =3D _get_osfhandle(sockfd);
>
> -    if (errp =3D=3D NULL) {
> -        errp =3D &error_warn;
> -    }
> -
>      if (s =3D=3D INVALID_SOCKET) {
> -        error_setg(errp, "invalid socket fd=3D%d", sockfd);
> +        error_setg(&error_warn, "invalid socket fd=3D%d", sockfd);
>          return false;
>      }
>
>      if (WSAEventSelect(s, hEventObject, lNetworkEvents) !=3D 0) {
> -        error_setg_win32(errp, WSAGetLastError(), "failed to WSAEventSel=
ect()");
> +        error_setg_win32(&error_warn, WSAGetLastError(),
> +                         "failed to WSAEventSelect()");
>          return false;
>      }
>
> @@ -315,7 +312,7 @@ bool qemu_socket_select(int sockfd, WSAEVENT hEventOb=
ject,
>
>  bool qemu_socket_unselect(int sockfd)
>  {
> -    return qemu_socket_select(sockfd, NULL, 0, NULL);
> +    return qemu_socket_select(sockfd, NULL, 0);
>  }
>
>  int qemu_socketpair(int domain, int type, int protocol, int sv[2])
> --
> 2.49.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

