Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E302CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 09:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqr0W-000860-89; Wed, 18 Sep 2024 05:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sqr0S-00084x-3z
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 05:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sqr0Q-0004Va-Cb
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 05:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726651789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ezzSZ7Dx5LUEDd6UbDX6MNPcXpgVwJjwGGHnw97NCU=;
 b=VJWmy+HI0i7rGsOQe+WnvRZ7zF+ibsjV77UPCKuuUdBlODrJ8boyT0YSmZ8iS4Op2WCX76
 rbLdMw5aGx+ExItGaExAuY6I8vRPWyYr+/qAs4e7IH6kdSjX2lnX4LaO705+21RSeeUxkO
 j9gB9hnCOO4X8BbasB5ZAFASFJ0qQ3g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-f9MX-wNFMFGKly1jmzGM2Q-1; Wed, 18 Sep 2024 05:29:48 -0400
X-MC-Unique: f9MX-wNFMFGKly1jmzGM2Q-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a99d13efafso1511949885a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 02:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726651788; x=1727256588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ezzSZ7Dx5LUEDd6UbDX6MNPcXpgVwJjwGGHnw97NCU=;
 b=Y6JHIgZ3mFd55mNI7JNNu3Evq8kHkCVT4U70By26CxA6N3HGNYdIhJSyq8QAoxxeSO
 gZA9HhBOk3pL8JcxgbpIS/HsZqz+wDnV1pgIzyEpyIuLcDy/5lmfjhs8NGhDVmf99ZIt
 cNXpVAJrZQRbJBKG9xOwtrwZTulPYPgmeXP5/oWd1tYgtaj4TUBYjEgjIuaZCuaFQZhJ
 iDlsjZt/07OG17KxLCrBo8+2AU6UdmWUbeS8xlPbTZ4RitTb/ryv6cLopq78yzWFXhH8
 HF7LAwviBjElZaH+6MlYQB866gpCvwjEmsi6X06P24DrKp4WLDJZPQ2a9mV+wsju/Gg6
 W2Lg==
X-Gm-Message-State: AOJu0YxxF41IAHxEIuK4vwgvLRgdchHY5HlHJelWuCTBnycpC6PZnpHX
 sowT5tBCji46MoE0DtZjQSueIt4Yo09Pys7Ny5+Rjaz6jARD5q/MLAO0kszcDuALNtaAoZXU71Z
 xUwSi2F25dcDEzyVfEvtalzF6JHqMeNGIP1JY5TZgX6W90wHzyo5xjn3R0wp/wQrupmYl2O36gp
 eNUokBbGHRc7MrlpaOUqKDM9elF4o=
X-Received: by 2002:a0c:ef0f:0:b0:6c5:9307:ef6a with SMTP id
 6a1803df08f44-6c59307f140mr158011786d6.18.1726651787765; 
 Wed, 18 Sep 2024 02:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs/dxEDRNOjEHUoBE4cxrzBbpnItlJGzTwTc80xNdX363qWWMzGQaZKuHfYI4/vvr8ExsomuvVRl+pWJO3CMA=
X-Received: by 2002:a0c:ef0f:0:b0:6c5:9307:ef6a with SMTP id
 6a1803df08f44-6c59307f140mr158011636d6.18.1726651787407; Wed, 18 Sep 2024
 02:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <3a78811ad5b0e87816b7616ab21d2eeef00b9c52.1726647033.git.mprivozn@redhat.com>
In-Reply-To: <3a78811ad5b0e87816b7616ab21d2eeef00b9c52.1726647033.git.mprivozn@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Sep 2024 13:29:36 +0400
Message-ID: <CAMxuvay3s1XS7xEOoAr8HnrO087H_3H+GMWb-cVoC0+Dm0feuQ@mail.gmail.com>
Subject: Re: [PATCH v2] audio/pw: Report more accurate error when connecting
 to PipeWire fails
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 18, 2024 at 12:17=E2=80=AFPM Michal Privoznik <mprivozn@redhat.=
com> wrote:
>
> According to its man page [1], pw_context_connect() sets errno on
> failure:
>
>   Returns a Core on success or NULL with errno set on error.
>
> It may be handy to see errno when figuring out why PipeWire
> failed to connect. That leaves us with just one possible path to
> reach 'fail_error' label which is then moved to that path and
> also its error message is adjusted slightly.
>
> 1: https://docs.pipewire.org/group__pw__core.html#ga5994e3a54e4ec718094ca=
02a1234815b
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>
> v2 of:
>
> https://mail.gnu.org/archive/html/qemu-devel/2024-09/msg03485.html
>
> diff to v1:
> - Dropped duplicated S-o-b line
> - Fixed typo on error message (s/PipeWite/PipeWire/)
>
>  audio/pwaudio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 3b14e04fbb..8e13b58286 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -769,13 +769,15 @@ qpw_audio_init(Audiodev *dev, Error **errp)
>      pw->core =3D pw_context_connect(pw->context, NULL, 0);
>      if (pw->core =3D=3D NULL) {
>          pw_thread_loop_unlock(pw->thread_loop);
> -        goto fail_error;
> +        error_setg_errno(errp, errno, "Failed to connect to PipeWire ins=
tance");
> +        goto fail;
>      }
>
>      if (pw_core_add_listener(pw->core, &pw->core_listener,
>                               &core_events, pw) < 0) {
>          pw_thread_loop_unlock(pw->thread_loop);
> -        goto fail_error;
> +        error_setg(errp, "Failed to add PipeWire listener");
> +        goto fail;
>      }
>      if (wait_resync(pw) < 0) {
>          pw_thread_loop_unlock(pw->thread_loop);
> @@ -785,8 +787,6 @@ qpw_audio_init(Audiodev *dev, Error **errp)
>
>      return g_steal_pointer(&pw);
>
> -fail_error:
> -    error_setg(errp, "Failed to initialize PW context");
>  fail:
>      if (pw->thread_loop) {
>          pw_thread_loop_stop(pw->thread_loop);
> --
> 2.44.2
>


