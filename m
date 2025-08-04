Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DD3C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 10:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uisSg-0005Zk-Qw; Mon, 04 Aug 2025 06:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uisRf-0004jp-Az
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:29:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uisRa-0001H2-Sj
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754303362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAFowDSiTVp6dt6ByEPilQXFBgAMSV6CJyHpv/qTMug=;
 b=bjOw1BH4kA2u8/9WgCaRn+1N9R0SOM34ss9QFyqqB7+TP7V7e6ra9f8HJ4vD+bd3A9nnT3
 T/QPbfuczLUs3yPLM8H91BEDELoXCVCBCMvpUIFQqaqGZNOc/jGVHjvy2uSeELn1xmY//l
 b2Qy6HPP79pxjzBhmM8vitBCX7wJu4A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-n_bNmWilObGVyPXR_k11Dw-1; Mon, 04 Aug 2025 06:29:21 -0400
X-MC-Unique: n_bNmWilObGVyPXR_k11Dw-1
X-Mimecast-MFC-AGG-ID: n_bNmWilObGVyPXR_k11Dw_1754303360
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b7931d3d76so1578343f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 03:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754303360; x=1754908160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAFowDSiTVp6dt6ByEPilQXFBgAMSV6CJyHpv/qTMug=;
 b=BFrVeGwCmmdmJuVFL6rE4c7IYCWBBJLdo51ea6uUvyrGWy7ohjUvc11LYspHyWt8We
 bx0s8+i0khMevWE3PyPkToXuwzqRiJf3m+cowIPuRmRlfSTLseiP/wkmFrhAgBx2Wbyp
 XV/viFswN3m1kWVFsnfPWMjbF07ManQhgJJtnYRPzF8ujpgREg4YqyzEUsiUgHoXH5/h
 alj+igbNNS1lsVLOmWX5nsGor1pksbzpnaIBv+O6rgPtrerWDWMFkSJpGK3c2FvXbwc6
 X0/lZ4LePlwfFcBOJFGnPmbafzGH+V5I5DmDMtBtBeh+k0zMPP3Z4lKvnINhGoTm2J9b
 Nd5g==
X-Gm-Message-State: AOJu0YzUUDL1EcP8Y1xhu0LG5vplyfnoLRqxfPE/Als1vb8RxYUb8zB3
 RUA3GN7fM1zg2ZTIvPpAyiWCx6bmF0Uo+wxZ9sLMj2lpeQkKWRwPfoOt9iR0K+xRltOIO7nutyZ
 jIQFfqOxhnCD4jEe6LPgPNROyzj+RG0TEv7KLQ5QrR3o7qHfGZ63phoDwMT/4hYTglCOOB5ND73
 3RikDUXyUoaGGT7P5iIAxe8yxUaCx6oHk=
X-Gm-Gg: ASbGncsNI8kDBL/lKv8+tFO7WBma+lBZpvSiHgCf5rNe4mcpUxKu7jKicqD/n99Rqdb
 dIRCVgq0GpctFddrZak3ESypPULz13i8GRiI4UUorlNIDBIl3fv+wHtMLSMf52b1ZBBPHXudR1W
 pPDIXfrV1WyvvzTuhHil7q18E=
X-Received: by 2002:a05:6000:4027:b0:3b7:7ded:ddb1 with SMTP id
 ffacd0b85a97d-3b8d94bc7ccmr6567697f8f.33.1754303360050; 
 Mon, 04 Aug 2025 03:29:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjFB/pAYYbTcZBOWg8DBM/bYjkDgqgBoSjXE8HC3VPuFkVCXairqDuXPxY3gi4nBH8e6xvLSARBSz3GCAhn8I=
X-Received: by 2002:a05:6000:4027:b0:3b7:7ded:ddb1 with SMTP id
 ffacd0b85a97d-3b8d94bc7ccmr6567682f8f.33.1754303359531; Mon, 04 Aug 2025
 03:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250801170212.54409-1-berrange@redhat.com>
 <20250801170212.54409-3-berrange@redhat.com>
In-Reply-To: <20250801170212.54409-3-berrange@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 4 Aug 2025 15:59:03 +0530
X-Gm-Features: Ac12FXxUkikm1RCJzz8T0J8ZwaX7sjgtT27bmMrQbDcIy6ufC428JifUaV1tX4c
Message-ID: <CAE8KmOyTu4Z5MZORjJ-zBQ+=nnMpYNeVeBsMFBNCY_Yx6XY0rA@mail.gmail.com>
Subject: Re: [PATCH 2/2] migration: fix workaround for gnutls thread safety
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, 2 Aug 2025 at 00:09, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>   eb3618e9 migration: activate TLS thread safety workaround
>   edea8183 io: add support for activating TLS thread safety workaround
>   24ad5e19 crypto: implement workaround for GNUTLS thread safety problems
>
> an attempt was made to workaround broken gnutls thread safety when
> TLS 1.3 rekeying is performed.
>
> Those patches acquired locks before calling gnutls_record_{send|recv}
> but temporarily dropped the locks in the push/pull functions, in the
> mistaken belief that there was a race inside gnutls that did not cross
> execution of the push/pull functions.
>
> A non-deterministic reproducer mislead into thinking the workaround
> was operating as expected, but this was wrong. Juraj demonstrated
> that QEMU would still see errors from GNUTLS as well as crashes.
>
> The issue is that a pointer to internal state is saved before the
> the push/pull functions are called, and after they return this
> saved pointer is potentially invalid. IOW, it is never safe to
> temporarily drop the mutexes inside the push/pull functions. The
> lock must be held throughout execution of gnutls_record_{send|recv}.
>
> This would be possible with QEMU migration, except that the return
> path thread sits in a blocking read waiting for data that very
> rarely arrives from the destination QEMU. This blocks ability to
> send any migration data in the other thread.
>
> It is possible to workaround this issue, however, by proactively
> calling poll() to check for available incoming data before trying
> the qio_channel_read() call.
>
> Reported-by: Juraj Marcin <jmarcin@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  crypto/tlssession.c   | 16 ----------------
>  migration/qemu-file.c | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> index 86d407a142..7e11317528 100644
> --- a/crypto/tlssession.c
> +++ b/crypto/tlssession.c
> @@ -95,19 +95,11 @@ qcrypto_tls_session_push(void *opaque, const void *bu=
f, size_t len)
>          return -1;
>      };
>
> -    if (session->lockEnabled) {
> -        qemu_mutex_unlock(&session->lock);
> -    }
> -
>      error_free(session->werr);
>      session->werr =3D NULL;
>
>      ret =3D session->writeFunc(buf, len, session->opaque, &session->werr=
);
>
> -    if (session->lockEnabled) {
> -        qemu_mutex_lock(&session->lock);
> -    }
> -
>      if (ret =3D=3D QCRYPTO_TLS_SESSION_ERR_BLOCK) {
>          errno =3D EAGAIN;
>          return -1;
> @@ -134,16 +126,8 @@ qcrypto_tls_session_pull(void *opaque, void *buf, si=
ze_t len)
>      error_free(session->rerr);
>      session->rerr =3D NULL;
>
> -    if (session->lockEnabled) {
> -        qemu_mutex_unlock(&session->lock);
> -    }
> -
>      ret =3D session->readFunc(buf, len, session->opaque, &session->rerr)=
;
>
> -    if (session->lockEnabled) {
> -        qemu_mutex_lock(&session->lock);
> -    }
> -
>      if (ret =3D=3D QCRYPTO_TLS_SESSION_ERR_BLOCK) {
>          errno =3D EAGAIN;
>          return -1;
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 8ee44c5ac9..cf6115e699 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -338,6 +338,22 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(Q=
EMUFile *f)
>          return 0;
>      }
>
> +    /*
> +     * This feature triggers acquisition of mutexes around every
> +     * read and write. Thus we must not sit in a blocking read
> +     * if this is set, but must instead poll proactively. This
> +     * does not work with some channel types, however, so must
> +     * only pre-poll when the featre is set.
> +     */
> +    if (qio_channel_has_feature(f->ioc,
> +                                QIO_CHANNEL_FEATURE_CONCURRENT_IO)) {
> +        if (qemu_in_coroutine()) {
> +            qio_channel_yield(f->ioc, G_IO_IN);
> +        } else {
> +            qio_channel_wait(f->ioc, G_IO_IN);
> +        }
> +    }
> +
>      do {
>          struct iovec iov =3D { f->buf + pending, IO_BUF_SIZE - pending }=
;
>          len =3D qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
> --

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


