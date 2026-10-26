Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866D606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HJT/hCHi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLGqp-0005oQ-22; Mon, 26 Oct 2026 05:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xLGpy-0005lN-JA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:17:57 -0400
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xLGpw-0004oL-1w
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:17:50 -0400
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-36661f953e4so5276812eec.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 02:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793006265; cv=none;
 d=google.com; s=arc-20260327;
 b=JQQMeTumnbl56lqtNNS+rAqjZ/4VMoJlEjDG/f4YX3KMakthvebdcyUXnN1Gv+1MwE
 I59/+qY2TZHiBFuUpVIpNSODbOH30XUVTOl8icunjXHN4yJYH/JUoJKQnbqA7HzJxlaC
 vuKJoSLpMM5V/rmHFYFraeBMCfGYX+eoM49fKyUQdjcPwOfUmyGBDhBHaKba4s2OVNuR
 5FqgZ/53aNCsn9HjZoPQOH2lxq62KBZnWPHybYSVZB0fxGF11NEyYy70g7y2Rah+jp2g
 U6ZgD4/zpqgZKJUmaxob7y3wSNDgnx6ZSMRzv5djDAsPnetgsswgUY1INK8a9JFFt8sn
 exYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W6rvK67moC6hyQUbtHGWpff68w7w4FCM6nIJYnM3ahw=;
 fh=Xs7UDclMpig/LHrW8E8AqtL+L3vnLZ534+RVhLm6KD0=;
 b=Rp+Y2oHOLP0p0/xG6KETaCpdnH6w3dGwTyHd/yJ3pIMKxklgU9PEE8rooXUY4pkAHb
 TRYswd9LTiOznXQaOmvOq1sJB6xcG+yBJ7lQmkE5mVrKJOBU5awrtqFv/UmygGCQNdZ2
 9uTXnZvizb8DpJUBlhfauTMsajxtJ/McR6RleFeFhHRkdP3jvPiSeQ/hRX8tOC2bkcDW
 oPc6U694O84p7Qh3gX6k1pFtyJ9X6Hp3yMukREHFGNlmUX2yUV6dfHyIfBhxlBeTW4S7
 HV1vEfDoZb2D2qgqwaDE/5+/Ea1tpvpxwTVoyo5vDcFzuiD/PZ4lQoL2LnRLTt2cJimN
 7OiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793006265; x=1793611065; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W6rvK67moC6hyQUbtHGWpff68w7w4FCM6nIJYnM3ahw=;
 b=HJT/hCHi7rMUms9AsJUqVtrwsmlokswBaabBobIdNdlzlNxCpgR9CHDhxu/KLv1jsO
 D/GmL3EbtyHKjT9HSegyaRMefN9lmj1AVCqgiBu1MlKHutLfJyhvufy1gw6JwdxT3t2m
 geVl9YEaX2BzScNtxWbdebOrYlALKquyPJWyckFmGmIc5F7/adGjjF0i6xLrXJc38Il+
 rgLIHHtW42pAwZXJUEJAEvVZ3J2SFbIGoMqFEstyBCV3hoNYjq0hewbNWtrQQFWHyzuH
 MROme3KfRTych5COScLzjL+5+nGzgAZVddS4fffUQ7bVVJhQz/qqqou6YXuR98YAwfvT
 1S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006265; x=1793611065;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W6rvK67moC6hyQUbtHGWpff68w7w4FCM6nIJYnM3ahw=;
 b=K2X56MI6IvAl31W0LbvkVG3V1ll2KjGOrxiSWT63fdQy9WNuLoC44QL/Wt96giLFf7
 3VWlHROf4gwoxteoOYDSAYDcUL98QdjcubQaUEI6pcP4Gz56b4vboGjUqlmvERtAssIz
 V83fGYeDx4av7M8MhKXw8AgoDWXxLP09OhPJdiLLlVpTuQB1Jz+ccVkM5Br7Qh2X1aFt
 NyhV0+sEBjLj7YRLHDkD0V/GgawXiXj0BSujzCJyNRKM7tk8z1XmodZdRvJyOtpZRNzy
 ramvagcUZBro2AmSx7Qz+lsyeVnBVFWhcPyMcYx/F8ODl23JdrUDA9LUvQbnE7Rehe+k
 jgKA==
X-Gm-Message-State: AFq9FYIrvplc6MD6aZXtFvzuk2e2KoWMPqPhMLNn9dnvn3CCg1u9jAPY
 fnQ08bQort0BWW1pYTvQg/HTt2UcCn73EObibCx6CY3vxa8QMK+BThapg0oTdUcTUUvTEcM13Xr
 eh5Tz/MvVlSAocvtmkM3wAfB6RsWII04=
X-Gm-Gg: AYBFou0aSS1SDFi8iYcCgVcnRs60vZj5fv1/cljmBREOwRKkPh5a2GGJ8Al0Lkmsg0Y
 JCjIpjo+XLR2a9AeWvbl46ZOhDuLEF+3gU8w91JTJAK33QwAcfNvX19OP3u3Yc3390Z3k6p5Biz
 yIxiwrdurEhjfZuMumOJMWVjee6RqJcrRRbUbwg0MR6MlEckj3EsQZVh0vp6sQ676deNLTANZWn
 EZidym2D8PXajMJhoQVAEUnSckvfzNssqXGWiavmFl1tyr7K3g/u6W3TkWph6hyLruUXQ7KNmf5
 hvKZpXArhUXr86d7SUnRy1yPTCQEZNRonEvvB7ywRj/I+zJvFYil4F+ytdAUFu5KamPR9ZtQHJF
 iinFp/T3jVBb2FUH/CK4tn41bjK4nKZw/p/pytgK97unZkU+YCS9mvkjiJ9a/GDp1NS9PxSJ7dS
 TYM6XegRU2ioKhIinJUQ==
X-Received: by 2002:a05:7301:1530:b0:35e:da0a:75b0 with SMTP id
 5a478bee46e88-369e84e94a7mr9821475eec.25.1793006265084; Mon, 26 Oct 2026
 02:17:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
 <CAGxU2F7nP2jOTiod1bu4Ao1XgNL7fVz_Dk2hnY32TMnCgpYT=w@mail.gmail.com>
In-Reply-To: <CAGxU2F7nP2jOTiod1bu4Ao1XgNL7fVz_Dk2hnY32TMnCgpYT=w@mail.gmail.com>
From: Tim Pambor <timpambor@gmail.com>
Date: Mon, 26 Oct 2026 10:17:32 +0100
X-Gm-Features: AclHuK83V-2ZsURGraKjp9YlMkP9anaRYXC_NCbFCZSdBaUsx1PWgKsIRHfkERg
Message-ID: <CAOX+r5-9SHjsHZqwiH925ATh4WA5cO0G3V8V6k23=kF6KcoR8g@mail.gmail.com>
Subject: Re: [PATCH 0/8] vhost-user: another try at supporting any POSIX system
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-block@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>,
 Brad Smith <brad@comstyle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=timpambor@gmail.com; helo=mail-dy1-x132a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stefano,

On Fri, Oct 23, 2026 at 6:01=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Thu, 22 Oct 2026 at 15:48, Tim Pambor <timpambor@gmail.com> wrote:
> >
> > This series continues the work started by Stefano [1] to add support
> > for any POSIX system to vhost-user.
>
> Cool, thanks for doing this!
>
> >
> > Three patches from his original series were never applied due to failin=
g
> > tests [2]. I was able to reproduce these test failures on current maste=
r.
>
> Oh, nice, I'm curious, how did you arrive at the fix?

I was only able to reproduce it under high CPU load, so I looked into what
changes with load. Looking at the trace of a failing run, QEMU sat in poll(=
)
waiting for an event from the moment of the disconnect until the test faile=
d.
Only then did it notice the disconnect, because the test=E2=80=99s other so=
ckets,
e.g. the qtest control socket, were closed when the test died. The vhost-us=
er
chardev had no reader, so before the fix its only poll interest was G_IO_HU=
P,
which does not wake poll() on FreeBSD. The qtest chardev has a front-end
that reads, so it was also polled with G_IO_IN, and that close did wake the
loop.

I also checked why it passes under low load. There, the disconnect coincide=
s
with the DRIVER_OK handshake (virtio_net_setup -> qvirtio_set_driver_ok).
That access wakes the event loop, where the already pending hang-up is
reported in the same poll() return, and the disconnect gets processed in ti=
me.
Under high load this no longer lines up: the status read-back is already ov=
er
when the close happens, and nothing is left to wake the event loop.

>
> >
> > Patch 4 contains a fix for this problem. Patches 1-3 fix further issues=
 I
> > identified on macOS. Patches 5-7 are the three unmodified patches from
> > Stefano's patch series. Patch 8 contains another bugfix I came across
> > while testing.
>
> Great, I'll review next week.

Thanks,
Tim

