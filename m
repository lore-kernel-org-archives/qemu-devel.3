Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC58C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 19:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmIUI-0001kx-AZ; Mon, 18 Mar 2024 15:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rmIUH-0001ko-0g
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 15:17:33 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rmIUF-0006sK-4b
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 15:17:32 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-429de32dad9so30147651cf.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710789450; x=1711394250; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uvCuaTulmkw/4RJTvN/0eKVq69C4CrXjNljs0myPnc=;
 b=U/Vb/CkvtPK9213lNb5W/PZ5q+18XTQe865ge8IJw3evlek8E/LeqJt4xDNSR0qTcE
 mHThBV5GdmgWmVhpB4q4rfYSFdR7Jxdp1TeLiZ8c1D3pddQlgDDtdAgW6uKrcq/1dKOW
 a64R00tv/uMrRqn4i72F62Tu5Q4Rud8ud6YZjYdOcaGolZVrCov1A7pl0YNortYWnr82
 B1znuUIaxH2i52/ug2f14GdkSC2RV6IpDAxBrp07QBRygXNM4Fw68sFT2znPlzCfSX50
 QeRwJNt2S2omJ92+ymJJRSgAXyBLCpELc6frtzr2OcRZiLYkl0u9aZcBACax9lTss3AN
 SKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710789450; x=1711394250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uvCuaTulmkw/4RJTvN/0eKVq69C4CrXjNljs0myPnc=;
 b=Ft7IxyPCi5El//uIi5zEscIsruEcyME8Hl3a+KzUUIz4+RuCq+1FW793lhouIfHLOE
 5JxEypfXjPq99BUiZvjPM5UqmBLNP6KYpycfXqO1Q8OMd8QMQDGY5Ftp0XSbuOIHeFFK
 v8KLX3hO694XCx665+SxOZ1LWkIDyN/9COp/EbbppdaXU0OWGkuKSEA+ecSRn6m6fIbm
 OPJJATSlWXjY0HQDM5nQbNdSoz+EkEnZAkMjt2rXUqlXUJ1eJno8gcNVLha3tbzvmv8T
 2m+CMhJHl4LHj2vuUCfGid1iXYsb2Qnm3ItrB+pAJqu1sJRjDWFQSCWkl24Vk/Emckyt
 IbWw==
X-Gm-Message-State: AOJu0Yyu3ZIU/h9ORZsEkDWHTf7HTRKU+od4ex+tyTjjDQfkzEChvHM8
 daKxZiULQU/zRfhP/vw+Xd/IlyN2Rk74ZwdpXXs2LEj7KH9vc9yfWhz9GzOQTFnoSVbQGaHOEwv
 Ts7TF4j8riqNm5RVstkKeK7TF5+M=
X-Google-Smtp-Source: AGHT+IF10Xj5llWnL4ooqWVcFM3zSxJOP5SRsechUPmcC/VX/23wR0kEKt1iYnYX/N6KHcktRnt2uwrqAxaBKPyukQ4=
X-Received: by 2002:ac8:5f07:0:b0:42f:200b:450c with SMTP id
 x7-20020ac85f07000000b0042f200b450cmr255458qta.64.1710789449694; Mon, 18 Mar
 2024 12:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240318182330.96738-1-berrange@redhat.com>
 <20240318182330.96738-2-berrange@redhat.com>
In-Reply-To: <20240318182330.96738-2-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 18 Mar 2024 23:17:17 +0400
Message-ID: <CAJ+F1CKVnSckG-R2wK5YXNUvMgqmk3VgMY2e5C6FvOLohVD0kA@mail.gmail.com>
Subject: Re: [PATCH 1/3 for 9.0] chardev: lower priority of the HUP GSource in
 socket chardev
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Mar 18, 2024 at 10:25=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> The socket chardev often has 2 GSource object registered against the
> same FD. One is registered all the time and is just intended to handle
> POLLHUP events, while the other gets registered & unregistered on the
> fly as the frontend is ready to receive more data or not.
>
> It is very common for poll() to signal a POLLHUP event at the same time
> as there is pending incoming data from the disconnected client. It is
> therefore essential to process incoming data prior to processing HUP.
> The problem with having 2 GSource on the same FD is that there is no
> guaranteed ordering of execution between them, so the chardev code may
> process HUP first and thus discard data.
>
> This failure scenario is non-deterministic but can be seen fairly
> reliably by reverting a7077b8e354d90fec26c2921aa2dea85b90dff90, and
> then running 'tests/unit/test-char', which will sometimes fail with
> missing data.
>
> Ideally QEMU would only have 1 GSource, but that's a complex code
> refactoring job. The next best solution is to try to ensure ordering
> between the 2 GSource objects. This can be achieved by lowering the
> priority of the HUP GSource, so that it is never dispatched if the
> main GSource is also ready to dispatch. Counter-intuitively, lowering
> the priority of a GSource is done by raising its priority number.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-socket.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 8a0406cc1e..2c4dffc0e6 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -601,6 +601,22 @@ static void update_ioc_handlers(SocketChardev *s)
>
>      remove_hup_source(s);
>      s->hup_source =3D qio_channel_create_watch(s->ioc, G_IO_HUP);
> +    /*
> +     * poll() is liable to return POLLHUP even when there is
> +     * still incoming data available to read on the FD. If
> +     * we have the hup_source at the same priority as the
> +     * main io_add_watch_poll GSource, then we might end up
> +     * processing the POLLHUP event first, closing the FD,
> +     * and as a result silently discard data we should have
> +     * read.
> +     *
> +     * By setting the hup_source to G_PRIORITY_DEFAULT + 1,
> +     * we ensure that io_add_watch_poll GSource will always
> +     * be dispatched first, thus guaranteeing we will be
> +     * able to process all incoming data before closing the
> +     * FD
> +     */
> +    g_source_set_priority(s->hup_source, G_PRIORITY_DEFAULT + 1);
>      g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
>                            chr, NULL);
>      g_source_attach(s->hup_source, chr->gcontext);
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

