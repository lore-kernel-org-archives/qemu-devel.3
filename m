Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12F9D185C7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnUt-0003TA-96; Thu, 08 Jan 2026 05:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdnUp-0003Si-8j
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:44:03 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdnUn-0005D9-Jz
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:44:02 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4ed9c19248bso27785641cf.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767869041; x=1768473841; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgYotXXtObFxgCVFHPqJttcufA+Um/2+QnysSMYb0mo=;
 b=DmG4Rfs3rdJDT9AOh0Y2FT3aQw66EuqyQfiM7BnNSAWi4NJXEjuihGnNZmcYnEM8MN
 jFBgAmRvBJSEGmrF2iESFee4bPlBBH1FeL0w8mrCfeNINUiBJRpb5ki14WbKf8x6YjKR
 CXvsYWVdg833+0IPeJJ0bdsXplEQ40ne5YxNBtPkuU2NW03x2m9NycwNx32wzOT4Dpe8
 pb4a/C/87t4trZ87migPLxQ2/VCt5hqSOvxjg4emiEiCOtFtmbqZLpVqHA+bbBB4ajQX
 HjjVSaU21YUz1K3/AaDWDSuQ/3w8HvK0heLCrmTW5gGaKCByd/pK/XfUbI/LA1FUxMeI
 MF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767869041; x=1768473841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dgYotXXtObFxgCVFHPqJttcufA+Um/2+QnysSMYb0mo=;
 b=WYFK6vrWQNkpmv+6q+LUcEOrbsL0fREtdXYktywDT7X99WRksCxjLv3pqK8voAswdN
 dP89u4KXJDdZ55mGPcetc+kA9n1ZYe83Kv0BxESoJZWixWRL1KPb9/JHUkI7YeXnyQEe
 ERrPj3ADnN34xzza5tYQLCS2XjmzYEJ2yz/joIwpobcrQ3RJ7TIgtTyqXEkKdYNxJeHx
 LjFD9sDIklmZNskrPUdMmP3wvu+LZc8RGd0uEUQGUm47WaRaSFiWaj6+cV7u0nIOk4Qj
 LDK0yg+0qSE950UmE0FV7FiasL2lW+WWexDHybMOS83kuXXHgQaMbZAytISPC6cqp/ZK
 tdJw==
X-Gm-Message-State: AOJu0YxHKEOlcxbnDO9Q+gHY9WPeN596MrOadsQyqJoyltuXtMTTYx/H
 s6ZrtbJWmpZPQi7raOvs7kSAcRbQfTMkNzJ1rTWJPbecJOmjhL7v2lyrFOD0J67chNBKAt6gn5x
 6nILsFS0+k2Nrd23J8yyMrfMBU/LRRyM=
X-Gm-Gg: AY/fxX5ZLmTBdc9LgfY4Cu8ipXANg8b3byLTAvL/Fbng3dZ9D9078IarPcrRV+jHiD1
 U+9yTiqfbrDTv1gc/s1qEe3ugh5GZkZEzYwQXqoP4+ECRiWrXUiSa2aIZnpS3IZowuf2oFMItu9
 J011ef4TmXRTRvqWdAUPFFniePnn9OeIv0/0uyNcAX8p0WVeunL9B4RLjbGyDDhAn5pulTr8Qts
 lzk6v1KyEmeKxzaQN0MF+f31UfUxuAG34/WjAMv2ES4OnQ7nU1K4/w0ZMShiML3GaYiojXzH7Bu
 XTR+nPkDSLclsyvWsn30nlfrBx9YwxP4XmyOQA==
X-Google-Smtp-Source: AGHT+IGtNPmN3+OgGiTfsoSAfYB+Z5T0j1fZb6J/smenKckzfMuy0dLNtdmCSA8Wa8gjtwAqQSHtnl4ShHi2tqQrcBk=
X-Received: by 2002:ac8:7d47:0:b0:4ed:67bc:50de with SMTP id
 d75a77b69052e-4ffb4958b63mr78277801cf.24.1767869040557; Thu, 08 Jan 2026
 02:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20260107153442.1832957-1-berrange@redhat.com>
 <20260107153442.1832957-4-berrange@redhat.com>
In-Reply-To: <20260107153442.1832957-4-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Jan 2026 14:43:49 +0400
X-Gm-Features: AQt7F2r6SLUDn88dz_-XQeKYBNrY-JLZL-n0AXweBpd730PTraO9AuoJTFLlPtE
Message-ID: <CAJ+F1CK5cPXWhLhspPDFKRsxGPAG4TB_12hqmdaJ6PSMmFEQ2Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] io: fix cleanup for websock I/O source data on
 cancellation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, zoudongjie@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jan 7, 2026 at 7:36=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> The websock code will create a GSource for tracking completion of the
> handshake process, passing a QIOTask which is freed by the callback
> when it completes, which means when a source is cancelled, nothing is
> free'ing the task.
>
> Switch to provide a data free callback to the GSource, which ensures
> the QIOTask is always freed even when the main event callback never
> fires.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3114
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  io/channel-websock.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index b4f96a0af4..6d92be4fa1 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -545,7 +545,6 @@ static gboolean qio_channel_websock_handshake_send(QI=
OChannel *ioc,
>          trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(e=
rr));
>          qio_task_set_error(task, err);
>          qio_task_complete(task);
> -        qio_task_free(task);
>          wioc->hs_io_tag =3D 0;
>          return FALSE;
>      }
> @@ -562,7 +561,6 @@ static gboolean qio_channel_websock_handshake_send(QI=
OChannel *ioc,
>              trace_qio_channel_websock_handshake_complete(ioc);
>              qio_task_complete(task);
>          }
> -        qio_task_free(task);
>          wioc->hs_io_tag =3D 0;
>          return FALSE;
>      }
> @@ -590,7 +588,6 @@ static gboolean qio_channel_websock_handshake_io(QIOC=
hannel *ioc,
>          trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(e=
rr));
>          qio_task_set_error(task, err);
>          qio_task_complete(task);
> -        qio_task_free(task);
>          wioc->hs_io_tag =3D 0;
>          return FALSE;
>      }
> @@ -918,7 +915,7 @@ void qio_channel_websock_handshake(QIOChannelWebsock =
*ioc,
>          G_IO_IN,
>          qio_channel_websock_handshake_io,
>          task,
> -        NULL);
> +        (GDestroyNotify)qio_task_free);
>  }
>
>
> --
> 2.52.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

