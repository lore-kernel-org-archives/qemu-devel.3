Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B451C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqdT-0006EU-Cc; Thu, 10 Jul 2025 08:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqdQ-0006Ck-74
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:44:20 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqdL-0003sZ-9p
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:44:19 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-710bbd7a9e2so9387527b3.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 05:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752151451; x=1752756251; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Kp8bu4jTkRUGbz9b2auc9VSysdtk/0LiI528N49pmI=;
 b=Cz6cczA72xL5neVG6gBn6+0NVlixGjCg3TonJ/Tbj+Hyp/lerR2Rdoca2QzuzMu1e1
 wfg3pA7nRc4C/huSzaemkovU5f0oP9rhTIYtXJlFayaEPcLp7zLfBWMW7SABhT6RpqVD
 SbSlP0JTzgpObLzd7iZODIY5laZq9njxU7GloKHouzPrRf6wGcl/5t1VM8BolBO3Swhu
 tc2ujih2bwgy1h0hf+ijYbDNkOGN7QSBwe8UavXwvnSdlPKugyUmiY1udHcrk9v9Unhj
 m1Ad5wHlq+/CGxrUvE34ozHSWyIfJnqCw/NkG/gTqecQNHwxGhXfsRBhU6GtrrQnyQGi
 1Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752151451; x=1752756251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Kp8bu4jTkRUGbz9b2auc9VSysdtk/0LiI528N49pmI=;
 b=HRAh5N16BFhs9xMBurz2TMb5eUqIS+PlTroTI6uYqfjtV4IKYVHxR/w5UFROm7pStR
 XVRHjoF/vbjWpZ2+wNOAFFBVcnF7xSZeHZ6Zne7lGpgdiqrSS0CoeApTQJ8UOVDo/LLj
 fg2zPE/1UJZSva9SfAb1o7RyePln1NESK2xaMs3mWrkN2qomgS68UYSP6eW5PXG50I/b
 +ZEP8P1M4r6HuyH1sDwVNKZkmZIbvAyrf8t9txP0Lqr4W9AWKVb0tAbM/fchSGChfJp0
 syijAkF5FiO0KkPCpBQKF4y/DzHDOIHoaxL2wyg55YSFi63rk6q5vvjfku8rCMeJQdrD
 onNA==
X-Gm-Message-State: AOJu0YyCcbIR9kP/yEqqrPXkH3v/Rpe4syYkA7UF7qpUbsl5A6ViFj26
 mnD3KXbl6S1dBUIHF6T7GRLfGfiKI/D+NtNrFtvCG3lvitcf/MUoKiGk/n5Mw/vgOLVX1g+mtrr
 i2Iz6xqx52u2PA7RoBWrtb6ggrbjxHd3i+5wnkxdgOQ==
X-Gm-Gg: ASbGncuAeWMDMBslHkLrzVgLoi8mP9kkpwboWayc/oUQ9ccgYLet+JBZ+xj4bWGHUHS
 x78TMepvLZaej4qChKabN0/LfkwOFic9gw/oIZAWn73bMADQ80HphErAGOdccpfuQbtLgtXoWQj
 8htys73tuP0bWJFE/wFskQbJ/T5NuiATAyA4P+pWga9UBh
X-Google-Smtp-Source: AGHT+IGmxYKfIoa0JfHEvGj2x5+JqUl6Pe/netVqCOMw67k8ivNG/FTdRy1JaisTuKoj5kGVlu+PmHVHTZBa07dsOUc=
X-Received: by 2002:a05:690c:6ac7:b0:710:e7e3:ff6 with SMTP id
 00721157ae682-717c46618dcmr35977207b3.12.1752151451468; Thu, 10 Jul 2025
 05:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250626074529.1384114-1-clg@redhat.com>
 <20250626074529.1384114-10-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-10-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 13:44:00 +0100
X-Gm-Features: Ac12FXzlL4s9XP3hSRu1qt_jiqYlIPiGw4aK-aQ83_eDLQ3dbqPbYSXIDTLP4n8
Message-ID: <CAFEAcA9+EyeWE0QSUhgd7+i3din8J76jnhTuDB7i9hu3x-urOg@mail.gmail.com>
Subject: Re: [PULL 09/25] vfio-user: implement message receive infrastructure
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 John Levon <john.levon@nutanix.com>, John Johnson <john.g.johnson@oracle.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Thu, 26 Jun 2025 at 08:47, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> From: John Levon <john.levon@nutanix.com>
>
> Add the basic implementation for receiving vfio-user messages from the
> control socket.
>

Hi; Coverity suggests there are some issues with this code
(CID 1611807, 1611808, 1611809):

> +/*
> + * Receive and process one incoming message.
> + *
> + * For replies, find matching outgoing request and wake any waiters.
> + * For requests, queue in incoming list and run request BH.
> + */
> +static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
> +{


> +    /*
> +     * For replies, find the matching pending request.
> +     * For requests, reap incoming FDs.
> +     */
> +    if (isreply) {
> +        QTAILQ_FOREACH(msg, &proxy->pending, next) {
> +            if (hdr.id =3D=3D msg->id) {
> +                break;
> +            }
> +        }
> +        if (msg =3D=3D NULL) {
> +            error_setg(errp, "unexpected reply");
> +            goto err;
> +        }
> +        QTAILQ_REMOVE(&proxy->pending, msg, next);
> +
> +        /*
> +         * Process any received FDs
> +         */
> +        if (numfds !=3D 0) {
> +            if (msg->fds =3D=3D NULL || msg->fds->recv_fds < numfds) {
> +                error_setg(errp, "unexpected FDs");
> +                goto err;
> +            }
> +            msg->fds->recv_fds =3D numfds;
> +            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
> +        }
> +    } else {
> +        if (numfds !=3D 0) {
> +            reqfds =3D vfio_user_getfds(numfds);
> +            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
> +        } else {
> +            reqfds =3D NULL;
> +        }

Here we allocate memory into reqfds...

> +    }
> +
> +    /*
> +     * Put the whole message into a single buffer.
> +     */
> +    if (isreply) {
> +        if (hdr.size > msg->rsize) {
> +            error_setg(errp, "reply larger than recv buffer");
> +            goto err;
> +        }
> +        *msg->hdr =3D hdr;
> +        data =3D (char *)msg->hdr + sizeof(hdr);
> +    } else {
> +        buf =3D g_malloc0(hdr.size);
> +        memcpy(buf, &hdr, sizeof(hdr));
> +        data =3D buf + sizeof(hdr);
> +        msg =3D vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
> +        msg->type =3D VFIO_MSG_REQ;

...and here we allocate memory into msg...

> +    }
> +
> +    /*
> +     * Read rest of message.
> +     */
> +    msgleft =3D hdr.size - sizeof(hdr);
> +    while (msgleft > 0) {
> +        ret =3D qio_channel_read(proxy->ioc, data, msgleft, errp);
> +
> +        /* prepare to complete read on next iternation */
> +        if (ret =3D=3D QIO_CHANNEL_ERR_BLOCK) {
> +            proxy->part_recv =3D msg;
> +            proxy->recv_left =3D msgleft;
> +            return ret;
> +        }
> +
> +        if (ret <=3D 0) {
> +            goto fatal;
> +        }

...but here we may take an error-exit codepath to the 'fatal'
label...

> +        trace_vfio_user_recv_read(hdr.id, ret);
> +
> +        msgleft -=3D ret;
> +        data +=3D ret;
> +    }
> +
> +    vfio_user_process(proxy, msg, isreply);
> +    return 0;
> +
> +    /*
> +     * fatal means the other side closed or we don't trust the stream
> +     * err means this message is corrupt
> +     */
> +fatal:
> +    vfio_user_shutdown(proxy);
> +    proxy->state =3D VFIO_PROXY_ERROR;
> +
> +    /* set error if server side closed */
> +    if (ret =3D=3D 0) {
> +        error_setg(errp, "server closed socket");
> +    }
> +
> +err:
> +    for (i =3D 0; i < numfds; i++) {
> +        close(fdp[i]);
> +    }
> +    if (isreply && msg !=3D NULL) {
> +        /* force an error to keep sending thread from hanging */
> +        vfio_user_set_error(msg->hdr, EINVAL);
> +        msg->complete =3D true;
> +        qemu_cond_signal(&msg->cv);
> +    }
> +    return -1;

...and in this error handling codepath we don't do anything
to free either msg or reqfds.

Coverity also wonders if you have missing locking because
the call to qemu_cond_signal() here is the only place
that touches msg->cv without holding a lock. But this one's
a heuristic that may be wrong.

thanks
-- PMM

