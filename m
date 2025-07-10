Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA5DC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqIO-0001pI-20; Thu, 10 Jul 2025 08:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqIL-0001S6-5E
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:22:33 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqIF-0004cW-Hl
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:22:32 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70e75f30452so6865737b3.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 05:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752150145; x=1752754945; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0haGJFu5+wyEyv4QSDDJ6M+SI2YKa0kb52ErISKqq8=;
 b=VtjJRBKvAQVbqnodd8udrwc5eW+cLtxuRK+j0hMwuY4FFi9xC8GbJegGQLqcE7ShTv
 lU8v5+/79XuBted6x0Tx9y4uWkIliTffPKgBar556gQVj7ELHaQANaj8+np6ZeCbBh+Z
 e9SD/TH4xVnJ82mrY5kGEKxKvNke6tiquG4WdRTqUCIN8VmGISUVS8MxvXethiTt8yZQ
 PM6g4TZ+seoiQ4K0t7KBGlOc8P1Ws6+9N2S1IXbGmKyYIC4f9fl0zuUg30oen5nM36Hw
 BuFm7Y3KRG4EwhAVyHtheRLi4dx6Gue+ICx0QlyP//8i4xUOf68vj4j/EAJCquJ+qDeQ
 dLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752150145; x=1752754945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0haGJFu5+wyEyv4QSDDJ6M+SI2YKa0kb52ErISKqq8=;
 b=kBSy1nIh2lPrq9z3wTLamqQCuXGOO0tEfoSPE6DgeCZ/e/E4JRT8jdpd4I8aSfAUS5
 9Jon70VGfxT2OSn4yL9+HyllEKrqThlgCaFqa36ULyrux4fqTfo2ddVW4pLDBupAgXCC
 Pd4euqGR+XBLsck3ImOR8RtV1CneECjOaUMbAQPuXpkCg/FBFDPQLrS2gxGU9ODOpARq
 PbASSeacvowUaYqL654AUvHyI6Godi2Hob+LKZGlNknsemSg0VlLh9wWU/KhsdvA7kTU
 e8Vx0bCtb45HBLZ9KEvJ8kgPQamw+zEQ+Zcv2bvDtwB/nEmorBznlqOEOQQ0wGfm/jia
 n6gg==
X-Gm-Message-State: AOJu0YzjJd7yjhDVFbqfluSht5DXKJSLt6hUTO/YQ44hyOJMojztIRNg
 gmsmb8awbWAdUxNMS3yC0oJ0PFh7kdmG7ReUQgZeZbKG93C4qbdb+eq5Vue6bSWsbAmmWlRC3sI
 uIcM13nDIYXTAI7+3YPY81XnBoFYhQqbYGtJfLl0Cew==
X-Gm-Gg: ASbGncu8KSr9vyWJ3Yj4ZY+VahDSmUnK2enuDHjmVWmB8bKVulBipMpEkt20IktzkIp
 UtYo04sgtKVM0IXhSkQwytMmeSROp53jngt0GgaCf+fXk5admPBvuPYqWINIemf+DnmvLH8I8ZX
 rcP+OAXQF798+Z6nKQMzqppACFpLRu2vC50zqXm0yz9m6IUCoBhk5w6GI=
X-Google-Smtp-Source: AGHT+IGctHPUOqKUAgIFpTd5/En0iEllzJEFNgrsv/dE2Rbx9XS7w4yR5pRLI79dAh9F3/oDrZgJgYCMFqFZfNRzpKs=
X-Received: by 2002:a05:690c:3806:b0:70c:b882:2e5 with SMTP id
 00721157ae682-717b167728cmr96060247b3.2.1752150144994; Thu, 10 Jul 2025
 05:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
 <20250524173514.317886-15-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-15-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 13:22:13 +0100
X-Gm-Features: Ac12FXz3khhijJNCqV9w_3lImdVrOYN5GEEmRXpTBXABjRawPIAURihFcD7USPQ
Message-ID: <CAFEAcA_WKw124t-92KLSq_GT2wVWU9QtiF_qEHxPqjkXJSDAGg@mail.gmail.com>
Subject: Re: [PULL 14/19] ui/gtk: Update scales in fixed-scale mode when
 rendering GL area
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 Weifeng Liu <weifeng.liu.z@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sat, 24 May 2025 at 18:37, <marcandre.lureau@redhat.com> wrote:
>
> From: Weifeng Liu <weifeng.liu.z@gmail.com>
>
> When gl=3Don, scale_x and scale_y were set to 1 on startup that didn't
> reflect the real situation of the scan-out in free scale mode, resulting
> in incorrect cursor coordinates to be sent when moving the mouse
> pointer. Simply updating the scales before rendering the image fixes
> this issue.
>
> Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> Message-ID: <20250511073337.876650-5-weifeng.liu.z@gmail.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Hi; Coverity complains about this change CID 1610328):

> @@ -50,8 +52,14 @@ void gd_gl_area_draw(VirtualConsole *vc)
>
>      gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
>      gs =3D gdk_window_get_scale_factor(gtk_widget_get_window(vc->gfx.dra=
wing_area));
> -    pw =3D gtk_widget_get_allocated_width(vc->gfx.drawing_area) * gs;
> -    ph =3D gtk_widget_get_allocated_height(vc->gfx.drawing_area) * gs;
> +    fbw =3D surface_width(vc->gfx.ds);
> +    fbh =3D surface_height(vc->gfx.ds);

Here we now unconditionally dereference vc->gfx.ds at the start of
gd_gl_area_draw().

But towards the end of this function we have a NULL check:

        if (!vc->gfx.ds) {
            return;
        }

Either vc->gfx.ds can be NULL, in which case we need some
kind of guard on these surface_width() and surface_height()
calls; or else it can't, and the NULL check later is dead code.
Which is correct ?

thanks
-- PMM

