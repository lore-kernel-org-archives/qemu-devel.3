Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CDDCFC28D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 11:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0fkx-0005Yy-CM; Tue, 15 Oct 2024 07:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t0fkq-0005Y5-Lw
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 07:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t0fkl-0004EG-Lc
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 07:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728991814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MaRKN1kHntchFFmkQZ38W2nYmASUOefauZ+iX7KC2Xc=;
 b=KptAsSm0Cn2ssiwFGDuE75jLkteLPzFTo8AQiV5qhEfOkH1JPl1x0r+v0CGWxKbQPTeYTD
 BDzHm4yQW3a/i2aEdt/SNkKhthYeoLoC4uNGh+BsHOtq97STlOuD4n/zNvJjf2PNaXLdBq
 vc82/e//rAsBDbIYfsNXYQjzinzBLTQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-tVJKbx4_ObWC1INBVcfkMg-1; Tue, 15 Oct 2024 07:30:12 -0400
X-MC-Unique: tVJKbx4_ObWC1INBVcfkMg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b11c9a9249so443964185a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 04:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728991812; x=1729596612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MaRKN1kHntchFFmkQZ38W2nYmASUOefauZ+iX7KC2Xc=;
 b=CFmbk8bwDWtykwovuqAdrrmWGswRihGu7Vhqc/ZxNAOPBZs7daUgbYvsxq7GwmPoUq
 xglZyVfhBRj1YNa03qhPT6MeuiXbV88K2YWJfR1bsDRxbwVzn2paNp3abFqlPRVY29ec
 Y7T23vEvauK2Z8NoC8RZZuAFZCd+vYpYqpJXpGD6bDX19fybSj27b4kubn+SNz3vB647
 aIAKAz1iY5ehTWNGANEPXYzaeCbzdkFwIJZPm9IYWf5ibdE+mfw1TnsxAVTJlFH9POeZ
 o/5rW7QSzIHSjdh1nq3AejB0I4namMAJy3eZa2KsBRDwDC93uBRrNy+SDUpzUA9Neo89
 nLeQ==
X-Gm-Message-State: AOJu0YymxKBupICYg7W+T1I/1wArtYMudYwUbPOQ6DYF0LDMLwWfrOH1
 kLb1G7XSciKb0+9rWGcGAjXsY31dfWq2ZURXA1ZNVmG5JvDJB7gEisB2Epqwj5kebcgQ60buRVf
 ZiAsmcZo+y08EbmJfbprC34OaHdZPEx+fn+0wcoKg77YBHK5hddicmmQ8lVQDt/iIBFzq1MleHm
 0r/8na84Bvr6DExHMfKRUzLZRPpp8=
X-Received: by 2002:a05:620a:1a19:b0:7b1:1013:c27e with SMTP id
 af79cd13be357-7b1418a04fbmr2979685a.60.1728991811844; 
 Tue, 15 Oct 2024 04:30:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA+h/FM3ua5qo5ZVbTaH3HmSx/KufISb/DTV0KFjurPcXGVJSY6QwBRLa1/fKo3O/vAhFi6MPiKMOmLK86Glo=
X-Received: by 2002:a05:620a:1a19:b0:7b1:1013:c27e with SMTP id
 af79cd13be357-7b1418a04fbmr2976985a.60.1728991811522; Tue, 15 Oct 2024
 04:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241015112510.412471-1-thuth@redhat.com>
In-Reply-To: <20241015112510.412471-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Oct 2024 15:30:00 +0400
Message-ID: <CAMxuvazGYBHJuNkYHMxcGZNMOzcVjehdXu9t8rbhb3xSGR1iGw@mail.gmail.com>
Subject: Re: [PATCH v2] ui/console-vc: Silence warning about sprintf() on
 OpenBSD
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 15, 2024 at 3:25=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> The linker on OpenBSD complains:
>
>  ld: warning: console-vc.c:824 (../src/ui/console-vc.c:824)([...]):
>  warning: sprintf() is often misused, please use snprintf()
>
> Using g_strdup_printf() is certainly better here, so let's switch
> to that function instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  v2: Use g_strdup_printf() instead of snprintf()
>
>  ui/console-vc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 8393d532e7..53fcee88f4 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -648,7 +648,7 @@ static void vc_putchar(VCChardev *vc, int ch)
>      QemuTextConsole *s =3D vc->console;
>      int i;
>      int x, y;
> -    char response[40];
> +    g_autofree char *response =3D NULL;
>
>      switch(vc->state) {
>      case TTY_STATE_NORM:
> @@ -821,7 +821,7 @@ static void vc_putchar(VCChardev *vc, int ch)
>                      break;
>                  case 6:
>                      /* report cursor position */
> -                    sprintf(response, "\033[%d;%dR",
> +                    response =3D g_strdup_printf("\033[%d;%dR",
>                             (s->y_base + s->y) % s->total_height + 1,
>                              s->x + 1);
>                      vc_respond_str(vc, response);
> --
> 2.47.0
>


