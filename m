Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B823C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 11:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkM5D-0004Ki-OU; Tue, 18 Feb 2025 06:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1tkM59-0004KO-Lx
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:48:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1tkM57-0001fC-5V
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739879281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=l831b+PuQ49WrKVSkDwL2sq+JXKyuCEqvs4wy8LI+Pk=;
 b=fUUm509rCJRgCwxNu6z8m2fJA+t7pQssjJPDhxZIqOGflzC3PGwkm60YNyAueZiFo1wzpi
 pUNHUeLGhVR1Wcc8lNh9xVoz3dpCxUPtTBYE1SrhSGet+ujc4Tz5nYhSmz5Ydq1VkJJgpi
 Se2Qa+00+BmPCRK4JpsMrXiTrH/R3p4=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-G260kZAiOWOKiW6Hk-QKpw-1; Tue, 18 Feb 2025 06:45:58 -0500
X-MC-Unique: G260kZAiOWOKiW6Hk-QKpw-1
X-Mimecast-MFC-AGG-ID: G260kZAiOWOKiW6Hk-QKpw_1739879157
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3d2abf82a21so10865475ab.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 03:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739879157; x=1740483957;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l831b+PuQ49WrKVSkDwL2sq+JXKyuCEqvs4wy8LI+Pk=;
 b=n8L9JpC8mGgIMyGYT+JMpZHCFuQ0Qu0tp/QGIho4ogKyIS9f+8kJd1XE/WALVlJDP1
 SX5a4eQ2+Um2rKmVsFQz8eFUEvmVlZefoaRqQsnKnrUMHHDlmJQmgmCmzUlSxstbSZka
 h534V7mTNlUPtxC1dUHmTFTwD8RVsS6ZkuT084AQetEvCgF9fdE4hxuE5q0fckziSgf8
 PuxTgYSynVFtmSiy9TiE5ssoE9OtvpNbJJq57VETvUccXWn+DWbbpTD/5fC6hnX7GPWH
 ejwiJwDwcFxTB51eme4IHDg9lcB8jBkDJ0ly/Oj3fTBm7s1AwA4TzaZxWeoW9fqYiAnU
 nTnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM88FkvTt7pi4U2nOS0wNhR0SHk7zYbhi3kcm8ZW33JzoGpwM5kAoOtJzk7ZUVTAL8tkbcI+xhS7ZH@nongnu.org
X-Gm-Message-State: AOJu0YzScvAY1lbyTtiKdU3wzeAqBhJ7PxOV30vDylK5CrI8TrrHYIQM
 X/Z20bS/gZ3pN97tUUexsbdY/F/2KtE4HpevW57l4bc7etBqKmk4S18sSuB08pNAXEmiKENNPSq
 WRsPhQfoDlaaehUMMyop06VQupc224Q1vN+w8tEOJ8tssuXXX4MuxiySS7eshQdz86bUXm0H0xV
 CMNf/56AgmbVdP57cvnhQc0KDgN1s=
X-Gm-Gg: ASbGnctKRKUpMv85YCufxT6FHTmiaYqJKd4VEbwi/vpk8x8Vsbk1dqbVl41NUIoNxk9
 RPaO1fHyfQZGK8kHGrXgPrvudiU0bqZXmccucd2nGkb5AI66Rpg+tlczMdpfDYmI=
X-Received: by 2002:a05:6e02:1384:b0:3d0:17d2:a03e with SMTP id
 e9e14a558f8ab-3d2809d97dcmr127089705ab.21.1739879157399; 
 Tue, 18 Feb 2025 03:45:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnhDhCosgc5Q8bWj6DqYeun2/PC098exFUyQuG6VkBgS1DTgggiWBJw8XlwhJOAu2QrRo76WyKoXYSzMEvAzc=
X-Received: by 2002:a05:6e02:1384:b0:3d0:17d2:a03e with SMTP id
 e9e14a558f8ab-3d2809d97dcmr127089565ab.21.1739879157102; Tue, 18 Feb 2025
 03:45:57 -0800 (PST)
MIME-Version: 1.0
From: Dorinda Bassey <dbassey@redhat.com>
Date: Tue, 18 Feb 2025 12:45:46 +0100
X-Gm-Features: AWEUYZkdSfGHRJDk1cJKrdrEDJfE1QVRCjeccT47bKywCKa6UN_79uiKR_W-P5U
Message-ID: <CACzuRyzQ-hiaw+6bPHAzkfm5mhEwWwyt4w4cum3SuCxdXdNsOw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-user-snd: correct the calculation of config_size
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: alex.bennee@linaro.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Tsirkin <mst@redhat.com>, philmd@linaro.org, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001c97ce062e692f9a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dbassey@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--0000000000001c97ce062e692f9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Use virtio_get_config_size() rather than sizeof(struct
> virtio_snd_config) for the config_size in the vhost-user-snd frontend.
> The frontend shall rely on device features for the size of the device
> configuration space. The presence of `controls` in the config space
> depends on VIRTIO_SND_F_CTLS according to the specification (v1.3):
> `
> 5.14.4 Device Configuration Layout
> ...
> controls
> (driver-read-only) indicates a total number of all available control
> elements if VIRTIO_SND_F_CTLS has been negotiated.
> `
> This fixes an issue introduced by commit ab0c7fb2 ("linux-headers:
> update to current kvm/next") in which the optional field `controls` is
> added to the virtio_snd_config structure. This breaks vhost-user-device
> backends that do not implement the `controls` field.
> Fixes: ab0c7fb22b ("linux-headers: update to current kvm/next")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2805
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> ---
> Changes in v2:
>  - Addressed comments from Stefano Garzarella about commit msg and the
>    property name.
> ---
>  hw/virtio/vhost-user-snd.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Dorinda Bassey <dbassey@redhat.com>

--0000000000001c97ce062e692f9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div><div>&gt; Use virtio_get_config_size()=
 rather than sizeof(struct</div>&gt; virtio_snd_config) for the config_size=
 in the vhost-user-snd frontend.<br>&gt; The frontend shall rely on device =
features for the size of the device<br>&gt; configuration space. The presen=
ce of `controls` in the config space<br>&gt; depends on VIRTIO_SND_F_CTLS a=
ccording to the specification (v1.3):<br>&gt; `<br>&gt; 5.14.4 Device Confi=
guration Layout<br>&gt; ...<br>&gt; controls<br>&gt; (driver-read-only) ind=
icates a total number of all available control<br>&gt; elements if VIRTIO_S=
ND_F_CTLS has been negotiated.<br>&gt; `<br>&gt; This fixes an issue introd=
uced by commit ab0c7fb2 (&quot;linux-headers:<br>&gt; update to current kvm=
/next&quot;) in which the optional field `controls` is<br>&gt; added to the=
 virtio_snd_config structure. This breaks vhost-user-device<br>&gt; backend=
s that do not implement the `controls` field.<br>&gt; Fixes: ab0c7fb22b (&q=
uot;linux-headers: update to current kvm/next&quot;)<br>&gt; Resolves: <a h=
ref=3D"https://gitlab.com/qemu-project/qemu/-/issues/2805">https://gitlab.c=
om/qemu-project/qemu/-/issues/2805</a><br>&gt; Reviewed-by: Philippe Mathie=
u-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>=
&gt;<br>&gt; Suggested-by: Stefano Garzarella &lt;<a href=3D"mailto:sgarzar=
e@redhat.com">sgarzare@redhat.com</a>&gt;<br>&gt; Signed-off-by: Matias Eze=
quiel Vara Larsen &lt;<a href=3D"mailto:mvaralar@redhat.com">mvaralar@redha=
t.com</a>&gt;<br>&gt; ---<br>&gt; Changes in v2:<br>&gt; =C2=A0- Addressed =
comments from Stefano Garzarella about commit msg and the<br>&gt; =C2=A0 =
=C2=A0property name.<br>&gt; ---<br>&gt; =C2=A0hw/virtio/vhost-user-snd.c |=
 18 +++++++++++++++++-<br>&gt; =C2=A01 file changed, 17 insertions(+), 1 de=
letion(-)<div><br></div><div>Reviewed-by: Dorinda Bassey &lt;<a href=3D"mai=
lto:dbassey@redhat.com">dbassey@redhat.com</a>&gt;<br></div></div></div>

--0000000000001c97ce062e692f9a--


