Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D135C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 11:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSb4X-0000fO-Lr; Wed, 24 Jan 2024 06:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rSb4T-0000f0-Oc; Wed, 24 Jan 2024 06:05:31 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rSb4S-0004XL-1p; Wed, 24 Jan 2024 06:05:29 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-686a92a8661so6253776d6.0; 
 Wed, 24 Jan 2024 03:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706094324; x=1706699124; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u36/nsLr5X1D0ttTCt/NuhcyEuMauru3wBo/q1oYkUY=;
 b=nJsKvwYzZBFglX2jZnbFf9yb66pqbo25wIaQJuyQ52h9Ju5AU06C2Y1eKK5uk8J6Pg
 h8Bhm989asD4dc5lGeWmU0YSmGh1JT3e/Xnbr/W4G0yk+OgkTe9kYYfQa2jYO6T7476Q
 ZZgezppRe4AB/zzWuzyVj0Ez2n4hFmlw3iM5L9OaONCrL/kka87hkoADE0gPaE7mUauL
 GfAd5cOPFTgN0wc7BI3TcsCn+ooYgw1mYQSQzmln3kapsyEMevWT1tbKJp7eU1qqgezz
 01rWMOxtY9AaYNhAo4pDIgXjfDntYMNxGqtGu5E8LKfXKtSDQ20/1ExpEuQItJNlaEb4
 9Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706094324; x=1706699124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u36/nsLr5X1D0ttTCt/NuhcyEuMauru3wBo/q1oYkUY=;
 b=WV/UkV+5ZLbryatU6muNSN1CJpRN9eoYcpD8LLRA6elgzPrDjxVQeraD9nQLQy64ZC
 IChyG1oApP6ayE6Kx5yHFUj0Y3omyv+gFuoQ5rElaj1HMWiSDA732MNo+XeKCe+mcTli
 tTSdcckg7Q5wzveVtKVfStynblPfnd1Nih2ndzjFacUL3LUHYEPK/QRQXUx0c1Mgl5dp
 Bz8aRUVvurHYMbzy0Ye5Wmln2cLmrNLmC+Ykopcl/wEheLeQqjis4+Pa3S3ByO2yUJ9U
 l/SKfZ7HCWZnJHj6sDIl3APoVgFlRhadcNlCRd3rfvFZ6Igo5OS9NaEfHaJuQv1WJpXn
 kpdQ==
X-Gm-Message-State: AOJu0Yw/jYShQK0U+9rSuM8SO1hJ8RrenxSIKByG4yoOCcveD+dAabP3
 LxGdwms1B5tBEkMIGDubydBNIrjtyfg7z0yXRcAu0zX9SRsbBZB5hPo13hUGYUP7xvANkmC1Zau
 KY0+HG+nlPuoiVCNgCuj0xLiMX0Y=
X-Google-Smtp-Source: AGHT+IFfxiapwuoW0ZGVsup1YrpwMPv3YL/C0gfpR/2dYeD9OZkSw9opptBabrnS08CV0H4CPXBpChakszLK1RFwU20=
X-Received: by 2002:a05:6214:1d07:b0:67f:feeb:e034 with SMTP id
 e7-20020a0562141d0700b0067ffeebe034mr2847131qvd.129.1706094324318; Wed, 24
 Jan 2024 03:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20240124105749.204610-1-f.ebner@proxmox.com>
In-Reply-To: <20240124105749.204610-1-f.ebner@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 Jan 2024 15:05:12 +0400
Message-ID: <CAJ+F1C+4c4B5hRmbQRYnhvEtTJgbmxDTz1es+ovDeRPWdpr+Pg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ui/clipboard: mark type as not available when
 there is no data
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com, 
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf31.google.com
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

On Wed, Jan 24, 2024 at 2:59=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> With VNC, a client can send a non-extended VNC_MSG_CLIENT_CUT_TEXT
> message with len=3D0. In qemu_clipboard_set_data(), the clipboard info
> will be updated setting data to NULL (because g_memdup(data, size)
> returns NULL when size is 0). If the client does not set the
> VNC_ENCODING_CLIPBOARD_EXT feature when setting up the encodings, then
> the 'request' callback for the clipboard peer is not initialized.
> Later, because data is NULL, qemu_clipboard_request() can be reached
> via vdagent_chr_write() and vdagent_clipboard_recv_request() and
> there, the clipboard owner's 'request' callback will be attempted to
> be called, but that is a NULL pointer.
>
> In particular, this can happen when using the KRDC (22.12.3) VNC
> client.
>
> Another scenario leading to the same issue is with two clients (say
> noVNC and KRDC):
>
> The noVNC client sets the extension VNC_FEATURE_CLIPBOARD_EXT and
> initializes its cbpeer.
>
> The KRDC client does not, but triggers a vnc_client_cut_text() (note
> it's not the _ext variant)). There, a new clipboard info with it as
> the 'owner' is created and via qemu_clipboard_set_data() is called,
> which in turn calls qemu_clipboard_update() with that info.
>
> In qemu_clipboard_update(), the notifier for the noVNC client will be
> called, i.e. vnc_clipboard_notify() and also set vs->cbinfo for the
> noVNC client. The 'owner' in that clipboard info is the clipboard peer
> for the KRDC client, which did not initialize the 'request' function.
> That sounds correct to me, it is the owner of that clipboard info.
>
> Then when noVNC sends a VNC_MSG_CLIENT_CUT_TEXT message (it did set
> the VNC_FEATURE_CLIPBOARD_EXT feature correctly, so a check for it
> passes), that clipboard info is passed to qemu_clipboard_request() and
> the original segfault still happens.
>
> Fix the issue by handling updates with size 0 differently. In
> particular, mark in the clipboard info that the type is not available.
>
> While at it, switch to g_memdup2(), because g_memdup() is deprecated.
>
> Cc: qemu-stable@nongnu.org
> Fixes: CVE-2023-6683
> Reported-by: Markus Frank <m.frank@proxmox.com>
> Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>
> Changes in v3:
>     * Yet another new appraoch, setting available to false when
>       no data is passed in when updating.
>     * Update commit message to focus on the fact that non-extended
>       VNC_MSG_CLIENT_CUT_TEXT messages with len=3D0 are problematic.
>
>  ui/clipboard.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/ui/clipboard.c b/ui/clipboard.c
> index 3d14bffaf8..b3f6fa3c9e 100644
> --- a/ui/clipboard.c
> +++ b/ui/clipboard.c
> @@ -163,9 +163,15 @@ void qemu_clipboard_set_data(QemuClipboardPeer *peer=
,
>      }
>
>      g_free(info->types[type].data);
> -    info->types[type].data =3D g_memdup(data, size);
> -    info->types[type].size =3D size;
> -    info->types[type].available =3D true;
> +    if (size) {
> +        info->types[type].data =3D g_memdup2(data, size);
> +        info->types[type].size =3D size;
> +        info->types[type].available =3D true;
> +    } else {
> +        info->types[type].data =3D NULL;
> +        info->types[type].size =3D 0;
> +        info->types[type].available =3D false;
> +    }
>
>      if (update) {
>          qemu_clipboard_update(info);
> --
> 2.39.2
>
>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

