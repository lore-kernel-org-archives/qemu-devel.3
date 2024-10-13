Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F7ECF2579
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 17:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t02ZI-0001Og-2X; Sun, 13 Oct 2024 13:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t02ZE-0001OP-44
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 13:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t02Z5-0003yR-Mj
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 13:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728841170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U9UH8lHFLdUluk5UqoRduYxJ28K1zsnUr27H4Z/taQg=;
 b=iI/HaHLveOq/0OCoiAm7lQJpQ0pUSiqJWGRy2sm892TAU4+PUGBNWMamt4WO3z+sEcQizX
 AFKCa2W/3YEAWzxPFjknf541YJz+XEwQzNpvArOTSP5FWdUTzHeIW+zKdTv2+SrfMINVPa
 6hWgOIxnghbTSlXRdodJbDGSrb6WUak=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-IbjpaBXoPtK1AkWUTE6Fkg-1; Sun, 13 Oct 2024 13:39:21 -0400
X-MC-Unique: IbjpaBXoPtK1AkWUTE6Fkg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43123d8a33dso11743425e9.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 10:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728841160; x=1729445960;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U9UH8lHFLdUluk5UqoRduYxJ28K1zsnUr27H4Z/taQg=;
 b=u7u1CMuf4sHI4us1/hqMvu5/m/gidfV+G5YOmjxD9BlWrsQW/p4vbl5xIRyniifja7
 2AvCszgTxdxrDvPRI/510Y+syKJ5yYxCCw2ZXrEJaN/xgNRYQjSZTZv5FjvNHFTUBfed
 V7Rkm3FNyTnpSlMGeiKhW4eIIQT1RoF9n/eQN3KsjUzFYBOLlZqz6ixhYLJsII2T/alo
 5MscsOIk0+u/JIzfgQKogwKN9J9WGrmJS2wml9PPDzh1I16/QDKuKqE++29hYyT8ikw2
 QQb5IjFywgD+AAP6E8mKSEC9CYEbSPYRqPO5zzNWBebfrWH7h1ls3TB5DUUs19YlDiix
 1S5A==
X-Gm-Message-State: AOJu0Ywl+ISpHluXg7Oy4ZAuJLpM+jJZdbB86PQUhMbq15Xi9gKTYMKZ
 77JOuOA40XYB/NXjRqBXm6kAtdTAYhopKFX074r3B1YSjrnDUcZttz5IEvBo9KlNtBBxFH1rH9N
 3lSE0d+VTtd/FOgeiyhibJE6xcwDqn3cZUDXFV7yt2MTBP55i/OXo1V6EJ3oV/7JEAPckM6gHhe
 5JuiAUiZVLZWgrsP0c7JG6ynNM/X4=
X-Received: by 2002:adf:a395:0:b0:37d:4fe9:b6a7 with SMTP id
 ffacd0b85a97d-37d5529effamr6605951f8f.36.1728841160074; 
 Sun, 13 Oct 2024 10:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdE67I80cTc4Zvi6oFXfOIjGG5MxjbzyT1RoN9UGS0T9m11GI/G2WOIdj3mmfyfhSgnjylk5OkkF3/S1YvuTk=
X-Received: by 2002:adf:a395:0:b0:37d:4fe9:b6a7 with SMTP id
 ffacd0b85a97d-37d5529effamr6605945f8f.36.1728841159777; Sun, 13 Oct 2024
 10:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241011153227.81770-1-pbonzini@redhat.com>
 <CAFEAcA88y9gV-YMNxvQPdGR2tA-sjsaFYr_TiG=GmQGr8+QkKA@mail.gmail.com>
 <CAFEAcA9vXEexRC4kZWEXoyMHQm_M33NRuZnSi7hq2wdPyCVGNQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9vXEexRC4kZWEXoyMHQm_M33NRuZnSi7hq2wdPyCVGNQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 13 Oct 2024 19:39:08 +0200
Message-ID: <CABgObfbdt+1VfdeFHx_06GLjcA7gPJ+ARpznfH7s2UaTnH1EBw@mail.gmail.com>
Subject: Re: [PULL v3 00/18] Rust initial PoC + meson changes for 2024-10-07
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000033c02a06245f33cf"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000033c02a06245f33cf
Content-Type: text/plain; charset="UTF-8"

Il sab 12 ott 2024, 16:02 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> Deleting the whole subprojects/unicode-ident-1-rs/ subdirectory
> seems to have fixed this -- it then realised it needed to
> do the download and put it in the right place. I guess that was a
> leftover from trying to build the previous version of the pullreq.
> But it suggests that something is missing in the dependencies,
> since it thought it had already downloaded it even though
> the directory it needed to put it in wasn't on disk...
>

That seems like it would be a meson bug (whether intentional or not); it's
unlikely that it's an issue here since the wrap files are not particularly
special. I can try to reproduce, but in the meanwhile I didn't understand
if you're going to stage and apply this pull request or not.

Thanks,

Paolo


> thanks
> -- PMM
>
>

--00000000000033c02a06245f33cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 12 ott 2024, 16:02 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Deleting the=
 whole subprojects/unicode-ident-1-rs/ subdirectory<br>
seems to have fixed this -- it then realised it needed to<br>
do the download and put it in the right place. I guess that was a<br>
leftover from trying to build the previous version of the pullreq.<br>
But it suggests that something is missing in the dependencies,<br>
since it thought it had already downloaded it even though<br>
the directory it needed to put it in wasn&#39;t on disk...<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">That seems like i=
t would be a meson bug (whether intentional or not); it&#39;s unlikely that=
 it&#39;s an issue here since the wrap files are not particularly special. =
I can try to reproduce, but in the meanwhile I didn&#39;t understand if you=
&#39;re going to stage and apply this pull request or not.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--00000000000033c02a06245f33cf--


