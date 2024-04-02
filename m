Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4054DC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraLM-0000RV-23; Tue, 02 Apr 2024 05:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rraLK-0000Qi-4Q; Tue, 02 Apr 2024 05:22:10 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rraLH-00011G-CT; Tue, 02 Apr 2024 05:22:09 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-432c96955dcso9666351cf.0; 
 Tue, 02 Apr 2024 02:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712049674; x=1712654474; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUCPFGSSMTA+DarJHpERwBBK4zdwceb2Xz8Osuan5WU=;
 b=MAL3wpcxpaSabc8DJTPgJ58VWQ4QXetx7nPpNeh/+25pht7YuTYcwFjhC9rZjRMaAK
 uPSnd56Elt/4OCtpXJTGhBTbRSO0fjd5HyK7hHtlQFkM53mLshXk7oHGdwlfX3YDueOP
 WeuVo/2A178XrSQKAO4tP9I1Mk6PKpnUlHRdfDDvRfiBTJSXgYus1bwWx5bWoZsiqDVX
 61P6QIavh1scr0hM859/uxOVbK+25yf4BKiii207kb+LZh7JwXW3gAuAyseoWVS73s27
 1Vaj1knsUnuNmBjsNZYho67YlHFBH4XtJniUL474Wjv3fYcp90Nl8/AzZAWFcduveyow
 mtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712049674; x=1712654474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUCPFGSSMTA+DarJHpERwBBK4zdwceb2Xz8Osuan5WU=;
 b=EARB+Rr6xMAkWIB+Q/bgRft02ngWTLYc35w4tI9awNoAug7+La4IA9TzrIrLe1XMtx
 s3yVfEG586+85c1TkwT90yV7LRhjB3qCXqh3w1zodTJf6qLu2IjUVe3gCMG+eNGSkwGR
 rjTX0vVpKF2WQc21WipmDmtWwRZZzXXmhlpk9wENDE6AWqjaRx/DjH/5sv2V6c8Ksxbe
 1WBuBJFhz7ViCYk8gvERv4+n7+vNW9dJupXE7ev+UGJdfE+5A8t+PprgzHczBlC0jqnD
 FFwlxrRdm6aerJ6FTlIpDgywjmAerIyzkKY19dzMqSQMx16QAr5wC5AOcfWyK5sBmwFc
 nK8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUITyvCgbaw2w31XXd5M+Zf/y7WQG76JxrGF+tFD4Av0TRWB/4rCe4zO+dkuZ1wyzyCWhArsK8mda8lzUDC99MexCV6874=
X-Gm-Message-State: AOJu0YwVrfDjdbkrPj1HEHX5CS86+uHb9zJgum2+I7FzKgI+KRbRGDLV
 t8l/heMo+X4RNbQ/99oO6qyDY3tOXvneDHMSTYKtqTtXXzc0KJ1/wYNT3GwH1XkSGr5T/NZ9MsT
 vXu/b7cCnUjA+i1Tm1HidLlo7dec=
X-Google-Smtp-Source: AGHT+IFrd3j/otevBya5R/wM1hn2ysy1WdTa0FBJUC5AmNPw3KFjMxrNgPl+DmupnHKOIfdA/2Bcdy7HQF0d1jI013k=
X-Received: by 2002:a05:622a:5288:b0:432:bfdc:9066 with SMTP id
 dr8-20020a05622a528800b00432bfdc9066mr13016437qtb.63.1712049674035; Tue, 02
 Apr 2024 02:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-10-marcandre.lureau@redhat.com>
 <13373de8-57ba-4b6c-9a8f-bdff88283bb4@linaro.org>
In-Reply-To: <13373de8-57ba-4b6c-9a8f-bdff88283bb4@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Apr 2024 13:21:03 +0400
Message-ID: <CAJ+F1CKJaFKgPvSxnR3iz1Lbvb_OFJk4Go2WihWf3kdgUCUDDg@mail.gmail.com>
Subject: Re: [PATCH 09/19] hw/sdhci: fix -Werror=maybe-uninitialized
 false-positive
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, 
 Klaus Jensen <its@irrelevant.dk>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>, 
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
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

On Thu, Mar 28, 2024 at 3:31=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 28/3/24 11:20, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > ../hw/sd/sdhci.c:846:16: error: =E2=80=98res=E2=80=99 may be used unini=
tialized [-Werror=3Dmaybe-uninitialized]
> >
> > False-positive, because "length" is non-null.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/sd/sdhci.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> > index c5e0bc018b..da5351d4e5 100644
> > --- a/hw/sd/sdhci.c
> > +++ b/hw/sd/sdhci.c
> > @@ -745,7 +745,7 @@ static void sdhci_do_adma(SDHCIState *s)
> >       const uint16_t block_size =3D s->blksize & BLOCK_SIZE_MASK;
> >       const MemTxAttrs attrs =3D { .memory =3D true };
> >       ADMADescr dscr =3D {};
> > -    MemTxResult res;
> > +    MemTxResult res =3D MEMTX_ERROR;
>
> Something is indeed odd here. Due to the for() loop, the variable
> initialization should be moved after the SDHC_ADMA_ATTR_ACT_TRAN
> switch case.
>

Moving the variable initialization? What do you suggest exactly?

thanks

--=20
Marc-Andr=C3=A9 Lureau

