Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03388C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4MN1-00060F-QK; Tue, 07 May 2024 11:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4MN0-0005zW-Ia
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:04:42 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4MMy-0007Om-Vg
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:04:42 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-43ad398f164so13913651cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715094280; x=1715699080; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUH43TrzI6NN+G4ahGgZmgbCZ5yK8D3pkjeS7AU2Skk=;
 b=DnLYoEoCyfNaCocirUGWVeZtwG7A/z3lTx3YmZjt0NL4NKunxUAB7aRNHRvOU9+sH2
 VP+9xyg9eMYPS89U3GsgLrEcsFXeYWjMrTLp3UgkcUPKT1ZyZUIlsY7IYt5m6A6h47Jq
 aba94gGR5seLfADxQa5oB28gIxqQbT0ZQnJJ8jo2FyBA90BCj2aAp04ZgwzVPz691kON
 RIvwy31YiHQKq9G/hnwVA7QqfpiKjK/wXJQfD7x8JQdDu7TcCc6TPIkJ1tJJT6UbL9is
 h5QxYH7+a2Op1RIXivY+GBoKwNvIsF/tkcRaoenuXN6NEggpRH9rDB7VhkqkZnPN8l+9
 R1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715094280; x=1715699080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wUH43TrzI6NN+G4ahGgZmgbCZ5yK8D3pkjeS7AU2Skk=;
 b=oPlPyBMyCC0H7YjfWAvj0RCuhbFiKmMNwH/ohLFvbvz8oY0k6OUF5gkUR1z6NWvhZd
 qYVIodP9mkF/U/VD+ZrKKc7Pe/+dEcN5v+tOIH7MHoqwyWdb6RpxytGZLdiAADJz5/t+
 V39AGqOPRbfQYGYFYrXmFf4l8uJMhEfTX35nxduLh3CRrahg5v28MSUyj5/Zh7tk22cp
 A0JqiIeIc59LFrmZ5VtYPj5j5oPLTMDorkOw8kFjc3HCe5wd4/68uh5xW2wd9SsAsFh9
 g81R6Mycjr/hk48xVA1gvif6LY3DGfdsNaux2a3PQBjWGQ1thWMfzk5oRAWF0KkubaI5
 rw8Q==
X-Gm-Message-State: AOJu0YwnOh6LtL5WJ07h7U1JfzdN48c3CgeWO0p5mDwN+p4CYlVw0VCO
 9fX2bls4sQfVfypyCTKviNSCzJAYwfCQhCsXmskDR7NPG5w92r4a2k904fMoBUIWz4FSjP4/iQv
 mOMaPZkptU0S0lVdRImUVE6fycJ0=
X-Google-Smtp-Source: AGHT+IGKy2O0kcwqO/6O5kPOcB5v7Zqv+H/i/gKUqa3UBfoB0d6ny7eEwVeHieljV4tQEto1s+AhDw1E24iF9RWXBj4=
X-Received: by 2002:ac8:7f05:0:b0:43a:db0c:e7f0 with SMTP id
 f5-20020ac87f05000000b0043adb0ce7f0mr17116937qtk.29.1715094278944; Tue, 07
 May 2024 08:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240426225059.3871283-1-dongwon.kim@intel.com>
In-Reply-To: <20240426225059.3871283-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 May 2024 19:04:27 +0400
Message-ID: <CAJ+F1C+JZ+vLWuY8QxvzPqFqY5neTYrjK6xnYN2b1weR_GPwZQ@mail.gmail.com>
Subject: Re: [PATCH v2] ui/gtk: Draw guest frame at refresh cycle
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

On Sat, Apr 27, 2024 at 2:56=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> Draw routine needs to be manually invoked in the next refresh
> if there is a scanout blob from the guest. This is to prevent
> a situation where there is a scheduled draw event but it won't
> happen bacause the window is currently in inactive state
> (minimized or tabified). If draw is not done for a long time,
> gl_block timeout and/or fence timeout (on the guest) will happen
> eventually.
>
> v2: Use gd_gl_area_draw(vc) in gtk-gl-area.c
>
> Suggested-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/gtk-egl.c     | 1 +
>  ui/gtk-gl-area.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 3af5ac5bcf..75f6b9011a 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -150,6 +150,7 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
>              vc, vc->window ? vc->window : vc->gfx.drawing_area);
>
>      if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitt=
ed) {
> +        gd_egl_draw(vc);
>          return;
>      }
>
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 52dcac161e..4fff957c3f 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -126,6 +126,7 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>      gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx=
.drawing_area);
>
>      if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitt=
ed) {
> +        gd_gl_area_draw(vc);
>          return;
>      }
>
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

