Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA09C5B543
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 10:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLJ4y-0001Gf-MY; Sat, 31 May 2025 06:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uLJ4x-0001GT-4i
 for qemu-devel@nongnu.org; Sat, 31 May 2025 06:04:39 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uLJ4v-00063Y-BK
 for qemu-devel@nongnu.org; Sat, 31 May 2025 06:04:38 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70e75f30452so19944007b3.2
 for <qemu-devel@nongnu.org>; Sat, 31 May 2025 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748685876; x=1749290676; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tfXIXFdHGUQGwku63bRepUws+6PEsmX2q+ojMOkTPyo=;
 b=NDwOVQZTGDBM3m0ggjUXtZuSf0RRmDwzu0EQaALPrK9RgkVYILeyyhstW2g3r4iVfV
 SA1W6Eqjk0FYB3Q5uRgRGEZ1CL5iRTRGivT/AUPRjXP/ayiSw/0QbQIBT6UOffsXa4kd
 H0m5Np6P4PnzefFGrnxcczbrGF63wKrSw2HTkNrNvTzuKLtZv8qQptHvhyHloA0P6LpP
 /1S3tR8Ti5HOzKPJSkayJvFNS7JlxFiprtllcjZY6o4Aam1CLu5794fIVEunY4C02vZo
 KGam/9oixcek+2QU018soCjJ3g28GkfaaWTZoTS1PvCqd6SWc3egM5VHS18sVRVu3ijV
 LTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748685876; x=1749290676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tfXIXFdHGUQGwku63bRepUws+6PEsmX2q+ojMOkTPyo=;
 b=wg9GCOLiLRWF4GY3KRvZoZpO1QZQYgnVbVLS8F2bOT+lWgGyzlr13/3cwUtcD+XzQg
 2CPRrF6Vr4PtFAPbxD3KqDahGwbX1CvS7SG5QxHOJq/S+/2I59fZTVDDyBx4H6mbAp5i
 mX923ujbr5beNnAEQQu4hx8x+9VgKHhHZLUzRlqlpYGK4fHP9b6KQCxwMX9rcG09p5rU
 oYSrtjdjOML0I5AeJabcJ88xUAnDXaAMCgOyEieyAwy+SOwHz+H0mMntV2D2GkMPG4nP
 6+iaznCzZTk9ID/Gw5V+9YlKgkrggBG7t8hQoVblfq3ay7TeG5vbjQ5JrfTw9ng20qEf
 L1Aw==
X-Gm-Message-State: AOJu0YxYAe2iCcc7mQbKYZaGRrMetM9oT2RBbqq5HOUWfqEcNXlXgQSD
 AJYNErWnuNyyMDUgBil9EQMl36HCSoZ6SIKxtnZH8YYXs6N/bg5rvSkROUGm5gWcMwnhS5MqZTO
 /ed4PzAASdkrxQ0DLDajG4swBYPxOS5A=
X-Gm-Gg: ASbGnctFeyBsYvl23YiEQmn00XWj9b5oUwORe6hMwmgu5yRhk54ZoBSRpRiSZ8u95y6
 WF5ttTQzYb/aM8jjnI026IbdtuFKG0HFTsXcH36Efz5+P8Gmu7n+C+WYQ2d//NtDDY8Q5qpScuF
 L3viUvvwZ7a6ZG0vzDFXrcjcvkdVVavzxOIvu19pfLxZ8PXv1cL/ushdE9AdtV56UyLA==
X-Google-Smtp-Source: AGHT+IE7XINVPkdhK9DYmULJVro2cWP3MXup03o01cgdy57HjASB57TCM56Gt83tHg+CmPyfewt4vzGYDcXSC7VFRSw=
X-Received: by 2002:a05:690c:998c:b0:70e:128c:301f with SMTP id
 00721157ae682-70f97f13d58mr94034517b3.30.1748685875738; Sat, 31 May 2025
 03:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250522092622.40869-1-conte.souleymane@gmail.com>
 <CAFEAcA-QQXg-EbeUNZEWUFkgA_zcDxWRPv9u8nOpVOsO1Bd=uQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-QQXg-EbeUNZEWUFkgA_zcDxWRPv9u8nOpVOsO1Bd=uQ@mail.gmail.com>
From: =?UTF-8?Q?souleymane_cont=C3=A9?= <conte.souleymane@gmail.com>
Date: Sat, 31 May 2025 12:04:24 +0200
X-Gm-Features: AX0GCFvUOgZNEHpSu-mIrYv1dLmLmCPOxcEHV1XZJH56PFRtktDwXCc4KXhwgnc
Message-ID: <CAOw3OrG0++zyT8gQMvQLx0YbM_EdrdkjiTiQHfth3e0T=gX2Mw@mail.gmail.com>
Subject: Re: [PATCH v3] docs/interop: convert text files to restructuredText
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jsnow@redhat.com
Content-Type: multipart/alternative; boundary="000000000000727de906366ba8cd"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=conte.souleymane@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000727de906366ba8cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for applying the patch and your adjustments!

I'll now continue with the conversion of docs/interop/qed_spec.txt.

Best,
Souleymane

Le jeu. 29 mai 2025 =C3=A0 17:12, Peter Maydell <peter.maydell@linaro.org> =
a
=C3=A9crit :

> On Thu, 22 May 2025 at 10:27, <conte.souleymane@gmail.com> wrote:
> >
> > From: Souleymane Conte <conte.souleymane@gmail.com>
> >
> > buglink: https://gitlab.com/qemu-project/qemu/-/issues/527
> >
> > Signed-off-by: Souleymane Conte <conte.souleymane@gmail.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Thanks; I have applied this to target-arm.next and it should
> appear upstream in due course. (I switched a handful more
> words to monospace that I thought better that way, and
> updated references to qcow2.txt in MAINTAINERS and some
> other parts of the docs to point at the new file.)
>
> -- PMM
>

--000000000000727de906366ba8cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for applying the patch and your adjustments!<br><br=
>I&#39;ll now continue with the conversion of docs/interop/qed_spec.txt.<br=
><br>Best,<br>Souleymane<br></div><br><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 29 mai 2025 =
=C3=A0=C2=A017:12, Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro=
.org">peter.maydell@linaro.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On Thu, 22 May 2025 at 10:27, &l=
t;<a href=3D"mailto:conte.souleymane@gmail.com" target=3D"_blank">conte.sou=
leymane@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Souleymane Conte &lt;<a href=3D"mailto:conte.souleymane@gmail.co=
m" target=3D"_blank">conte.souleymane@gmail.com</a>&gt;<br>
&gt;<br>
&gt; buglink: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/527"=
 rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/=
-/issues/527</a><br>
&gt;<br>
&gt; Signed-off-by: Souleymane Conte &lt;<a href=3D"mailto:conte.souleymane=
@gmail.com" target=3D"_blank">conte.souleymane@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.=
org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt; Reviewed-by: Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com" targe=
t=3D"_blank">eblake@redhat.com</a>&gt;<br>
<br>
Thanks; I have applied this to target-arm.next and it should<br>
appear upstream in due course. (I switched a handful more<br>
words to monospace that I thought better that way, and<br>
updated references to qcow2.txt in MAINTAINERS and some<br>
other parts of the docs to point at the new file.)<br>
<br>
-- PMM<br>
</blockquote></div>

--000000000000727de906366ba8cd--

