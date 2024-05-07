Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E06C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4MSd-0008Cs-UW; Tue, 07 May 2024 11:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4MSY-00088Q-KJ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:10:27 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4MSU-0002bM-RW
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:10:26 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-79290c53456so258880885a.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715094621; x=1715699421; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWHuVnCCkQKPESKufEmzl8C4FMwlVEZ1kdhcDns1uxQ=;
 b=hJVsafZtS7Cr5hXp0tFw9oeVhJ8e2K19+JFtBk6/qt4ZmEnqMQTYkYAjdgFPGXyA8A
 HUCVRkitpFhlSV/ngnMsojP4dqi9glU8anrEcO0APKCMvBdCBw8k6Ete5YO6seeF0E8y
 wsCsVXPLuZalr9K3tV3dS4T8Ak9+Qrb3JPSmzHbZbqd2hJO7uTK4BGEXApgX7h5DKVXO
 wiI2a/RAkAEbHDPBEW3Xrx60NDC4zE16zBM21iz/TPZ+ME9f8fKVKIe2hR+vzzJTjaki
 OCGh4UyJEDwASfOOyRm0vxaWc6OVKroC23UuKEO0AkMymMH3U4Eb1x5G33utKltz52+5
 jCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715094621; x=1715699421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWHuVnCCkQKPESKufEmzl8C4FMwlVEZ1kdhcDns1uxQ=;
 b=nVrd8DTNpm8cedpjmsylddH9M+AHK/HtsLMzTpDvtd5AurSotXanXns7iw/8H2BYA8
 xYfT6MfFiC5SP6AODcVzpI5V6w/7jF36r7AGeHykuWdieiZGXXgT83b4AppiSzTlld4S
 E5KFq1hLehMi4vZ3xhPHbbpu9OET3XpQyOtsExc8Njr5jDySS9ktmzegnNlNUpO5+Mz3
 0G+Cfbui231rg7jVAZxftaY16RbiS4FekfdLMZXKZu7xnGmmpSYb+0TsByNFtqtXlrEM
 GMz7Pf6Tv4VhKlfKR6ZwY6AkapcDQno6WAbiaMMwWhW1nL411vCgsNCgks9RQCqNdr5X
 bsEA==
X-Gm-Message-State: AOJu0YyAchXvY2yQuuBdUZLptCsIwo4O+sl59NiyzJ5ynMF2bYiQylW7
 iS8S3bcxh4EYTcE4nff5Ny35P5Me/bbD8cMFbeyL28PcVOZTqT3gFXoVQdSlneTPnYb2nWeda8L
 HhOTHVohTI/hzKiV1ndI2kgL21hs=
X-Google-Smtp-Source: AGHT+IGkyJtA7Gd+DDR5ZMzvW5uW0rfo3NhKIpl04y6TSl+uzU6KEgzVjmXXGf76wJjdMDQMnmXv/33GnywjIC5B2Zs=
X-Received: by 2002:a05:622a:198c:b0:43a:b1bf:4762 with SMTP id
 u12-20020a05622a198c00b0043ab1bf4762mr16168934qtc.5.1715094621552; Tue, 07
 May 2024 08:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240501034133.167321-1-dongwon.kim@intel.com>
In-Reply-To: <20240501034133.167321-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 May 2024 19:10:10 +0400
Message-ID: <CAJ+F1CKxB5CGkR=xvgR8X7sm2X+qW0sd3VE=uf01JRZcgOkyRg@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Explicitly set the default size of new window
 when untabifying
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x734.google.com
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

Hi

On Wed, May 1, 2024 at 7:47=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> When untabifying, the default size of the new window was inadvertently
> set to the size smaller than quarter of the primary window size due
> to lack of explicit configuration. This commit addresses the issue by
> ensuring that the size of untabified windows is set to match the surface
> size.

From a quick test, I don't see a difference of behaviour after the
patch. Could you help me reproduce the issue?

I also don't think it is correct for two reasons:
- the inner display widget should cause a window size reconfiguration
- the window size !=3D display size

thanks

> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 810d7fc796..269b8207d7 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1395,6 +1395,9 @@ static void gd_menu_untabify(GtkMenuItem *item, voi=
d *opaque)
>      if (!vc->window) {
>          gtk_widget_set_sensitive(vc->menu_item, false);
>          vc->window =3D gtk_window_new(GTK_WINDOW_TOPLEVEL);
> +        gtk_window_set_default_size(GTK_WINDOW(vc->window),
> +                                    surface_width(vc->gfx.ds),
> +                                    surface_height(vc->gfx.ds));
>  #if defined(CONFIG_OPENGL)
>          if (vc->gfx.esurface) {
>              eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

