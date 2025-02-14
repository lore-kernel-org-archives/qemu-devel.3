Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E64C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwLH-00024f-Qg; Fri, 14 Feb 2025 09:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tiwLG-000243-Cz
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:06:54 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tiwLE-0003DL-ME
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:06:54 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d9837f201aso6272437a12.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 06:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739542010; x=1740146810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RniCZssL9pffGfBo+RPe/3GWO4hvBh/ZCIhD+h+/Nk=;
 b=fsiRKZW7KNzcTH/qjEgQQPKjInCdFPsU844RkHWp8YOXmnsl3Kq708MW8iTQtRROA0
 wcYXxPzzkGS2MMgu5NRtYbx0RW7ZW+Aov2hJ/xJrpnrUGQ2OVT2c+vg5lpv6Y3J/OdT9
 8g+fcJHDGibZ4Xnv6XaUEYN38r7/ntNHwrvGZIWqQtZQv2dGzGfOOhJSTEgdPH+bGVII
 B1rnwDU7eaN6KSFxVDbivIzS36pOHabNOhU8uTIyS7REUDijXJDhaUgnXTRTe/e21TEu
 qn3PPvJUWVyLdriwwfc0ldihf304QxdBhIFOluJlphtBTrCPn02HQwfoip+pJtCUpocO
 irOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739542010; x=1740146810;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5RniCZssL9pffGfBo+RPe/3GWO4hvBh/ZCIhD+h+/Nk=;
 b=PYXAfL/Z0/pMbkX5Nd7QQhlgZR5eRxbDMpJ7GaQkDJ4EHlauNfaEXc7IDvDlq9IHQK
 Tis5wF8tP+f7g5DcFyrSqaE+DBRTwYi6/OyMFNXXN2T6QYt2x22lsNJTg4TcCG900LTI
 VgmrT+Z7ommu+BhQqVJr1z7UNv1Lby0KFZn7vBrxsod4CVKEoDO+568eK5n9ipF38fgW
 S2nhb5dctL969wn6GcT8VOYjAyGeq29+6N78IWAIIIcj2XbFRCtAA0O1VrMuF6ZCYfyY
 qND2KMN61BNr331jaTdK9MWfrQUhVw+7i9rkbnxS3jtNgpi+nEIccaCn5Sb2w+8gjcO6
 99Lw==
X-Gm-Message-State: AOJu0YxAqKbXJ2cPH/JLXLzf4QE8w5geAsQzN5Z9GPHjGdNJarycbdOz
 i0S8qipkDWRAaKQVOPXnDfdBxDxhQUCLxXeJOOx94eOWTgKBpEzotwnsoL4Eg9I=
X-Gm-Gg: ASbGnctJIYNPOoNYJ2ILTyeY69pd8Z3b3IzB+YfmV8sPq9qvxtNpXC6XF3PLYm4c+A3
 yMj8RiPKwmjI8CbQiPJK6RJgG0o4L4myrYYP7KX7I6guxUreWUbOAksv0vuh9bZkPdj3VaxJtlT
 nHTp3DCsnKf/OcCbgIqUexK6S/FAwJeNbjvg+Wts8SZPOxwb+6suzy7GN+JRCTWTOADJAzdviGT
 Tg4mUDtuYWeUzzVye6duig3TeLY9haq8NYQYooWea8VEeRUUUybcwimCMOJo2KWCmFnMMfbwDl4
 ZaxjRpDdu0D15cCcFQ==
X-Google-Smtp-Source: AGHT+IENcSKBgbSYRp2ThmO4FAEmswAXd7S8SjCtZ2Lo10fUCZK6hYWRFxrYCFd5/QjGbKAY+8w8Lw==
X-Received: by 2002:a17:907:a0d1:b0:ab7:f853:1445 with SMTP id
 a640c23a62f3a-aba5152d515mr669669466b.26.1739542005386; 
 Fri, 14 Feb 2025 06:06:45 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba532588dfsm353758666b.61.2025.02.14.06.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:06:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CA24A5F8FC;
 Fri, 14 Feb 2025 14:06:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH] ui/gtk-gl-area: Remove extra draw call in refresh
In-Reply-To: <20250206225304.1739418-1-dongwon.kim@intel.com> (dongwon kim's
 message of "Thu, 6 Feb 2025 14:53:04 -0800")
References: <20250206225304.1739418-1-dongwon.kim@intel.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 14 Feb 2025 14:06:43 +0000
Message-ID: <878qq8pqmk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

dongwon.kim@intel.com writes:

> From: Dongwon Kim <dongwon.kim@intel.com>
>
> This partially reverts commit 77bf310084dad38b3a2badf01766c659056f1cf2
> which causes some guest display corruption when gtk-gl-area
> is used for GTK rendering (e.g. Wayland Compositor) possibly due to
> simulataneous accesses on the guest frame buffer by host compositor
> and the guest.
>
> Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>

This certainly fixes the corruption I was seeing while testing Dimitry's
native context patches and doesn't seem to affect the venus test modes.

So:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  ui/gtk-gl-area.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 2c9a0db425..9f7dc697f2 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -129,7 +129,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>=20=20
>      if (vc->gfx.guest_fb.dmabuf &&
>          qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        gd_gl_area_draw(vc);
>          return;
>      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

