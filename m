Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E825CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 22:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIDeI-0005Lb-Un; Sun, 09 Nov 2025 17:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vIDeG-0005K2-0n
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:12:36 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vIDeE-0007Dm-AE
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:12:35 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-640860f97b5so3931394a12.2
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 14:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762726353; x=1763331153; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0GlaxmB0WY42IvF603m3zWB/5Z0qrdNnmheBYFz5DkQ=;
 b=DS6+yknNHQqwei3zikHI+/8QSR7F6eu2jmIh312V+w8Fzq5q5q86lcyr9J8M0YEgSD
 2qGc8CFq5XSBaATOk9knEMpUxyqGyal1Ir6ozt5Rth2R9huGt+aYY92XlfBc1qbJazJp
 FrmgcoAEQirxCtrbAZQjUyXMXt3nDL+gFiaR93rI7E7JzmHt61HmSkjToEQeIfrnhFMU
 YRwpBWsNGs7C8ynx39g1ZpvlRKOzffdFbd0ILvLN2dcNpIR4TRbXivcPlYkfdH6811q+
 1R5mR8+2edTqg8WS6u4nRCspSJTq0zP/5uGxRuODk+xXp9v8FtngLgVDfe+xYlaTjvaE
 1V1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762726353; x=1763331153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GlaxmB0WY42IvF603m3zWB/5Z0qrdNnmheBYFz5DkQ=;
 b=VgmcnrThP8SE8jQ3nypR8mbP+D9el0yeSQXIEsG3QJECWmm3cRPawprmYphUMC4/Mw
 D9DzfZs3C8yuOaxO5TYe6kbF4vpLA6iRG/bNXHqaYx9IfWHBPGRYpLaVBC1h20uM7a7/
 YuDRcu3Vjygv9EZmC+WlyhjCGBfQhGn7oaEOST+GbAJQLQRtR/vIGNl+/UotCSqkcbsY
 rZ8sjs8L1X9Nhkg9kyEI0HlNk9+9q59zoI1gPlBJcvgYgdLEX/el/xc5D1xWqEWtPUC5
 z1CvHvVqNpT3u/WFJRR0PbqnYTvNb3VjaDfb79WIr18NHbQvcjHB0fgEe2m4N9ScBPmx
 1Tjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcGJEzWx3oT6BsTvnBZwhQQUvNfiwPE072IfGs0DDQA17wHkQZKnlBF2HR0Vv+6a7g+bQYb5nrKDss@nongnu.org
X-Gm-Message-State: AOJu0YxgEnfLGOJIt8qSk+NxsFF+5alu1a8Ei2sxwlTPS6exTx3zTAGw
 U81AM+u6h/hHnk0RSlVBCQ9mKIIjngNOtkV9c8DR/lgvcNg8AfWoL5MTbHVMXDM6iJozF5kdb7l
 CKgxTOKy1yA21rfIt5smV5fVjhUxzNVM=
X-Gm-Gg: ASbGncuEHMiKOV8Co5nGhYLAYuAY0BWOSg29M0anJnBXkMYuutCfTHOU8aHI0Kb2E3N
 eONeGTaBofmyrhyZbY8cCI4Sng9DIPioyAORURXGxVuI+YIhE1vU7xxM5Cr51BhOX+Oj9LEPB5O
 zfJCraFUPIT03qJo/7s1fG/pSrTl8ZxaK6daTgZZP9qJKXcSyihClNMgfv/Qz7XKB/LH03pNSak
 h1PB9I+UTumNssZExlnP+EIuYJhWD8OAapl5xMRY39zy+LFOU6jQYds5Fa/5ut0KU86bNLmAg==
X-Google-Smtp-Source: AGHT+IHaVdPbLtUjMjv8jzHBwZ4ATtk1/uHxeswf4ESitpf+cYP/qo8xyefRgxiSndYzyIAsvfTeNoD4o/xI/XJGbNI=
X-Received: by 2002:a05:6402:13c2:b0:641:3d42:99b8 with SMTP id
 4fb4d7f45d1cf-6415e5d7946mr4291423a12.9.1762726352340; Sun, 09 Nov 2025
 14:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20251103184031.22118-1-soumyajyotisarkar23@gmail.com>
 <CAJSP0QW4Egf2iJMjUVBi9iNPvGtEUMN=ULwM4+ntsFLDC3otHA@mail.gmail.com>
 <2717ec21-25ce-4aeb-8dab-2ae1069cbcdc@gmx.de>
In-Reply-To: <2717ec21-25ce-4aeb-8dab-2ae1069cbcdc@gmx.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 9 Nov 2025 17:12:22 -0500
X-Gm-Features: AWmQ_bk5w_dVYmImmHjAdK-KJ1niNkJf4tM73KDY-_Gjyok0VToy8R4u-caXbwc
Message-ID: <CAJSP0QWn8S=oyi-KCAc98teRzWdC+cTKuHb1KaCLF3kt4z3o7A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] HP-PARISC: LASI's NCR710 SCSI Controller
To: Helge Deller <deller@gmx.de>
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, sarkarsoumyajyoti23@gmail.com,
 Peter Maydell <peter.maydell@linaro.org>, zhaoguohan@kylinos.cn, 
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="000000000000114bec064330b6ec"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
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

--000000000000114bec064330b6ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025, 17:08 Helge Deller <deller@gmx.de> wrote:

> On 11/9/25 21:57, Stefan Hajnoczi wrote:
> > On Mon, Nov 3, 2025 at 1:40=E2=80=AFPM Soumyajyotii Ssarkar
> > <soumyajyotisarkar23@gmail.com> wrote:
> >>
> >> Fixing Defects reported by Coverity Scan for NCR710 SCSI Controller in
> QEMU.
> >> QEMU runs the Coverity static analyzer to identify potential bugs in
> >> code that has recently been merged.
> >>
> >> In view of the above these issues came to light.
> >> I would request you to please review the fixes for the same.
> >>
> >> Reported by: Stefan Hajnoczi <stefanha@gmail.com>
> >> and GuoHan Zhao <zhaoguohan@kylinos.cn>
> >>
> >> Soumyajyotii Ssarkar (2):
> >>    hw/scsi/ncr53c710.c: Fixing null pointer dereference issue.
> >>    hw/scsi/ncr53c710.c: Fixing Incorrect expression
> (IDENTICAL_BRANCHES)
> >>
> >>   hw/scsi/ncr53c710.c | 8 +-------
> >>   1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > I am not familiar with the device being emulated, so I have only
> > reviewed this for C issues:
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> Thanks!
> Btw, I just sent out a pull request which includes those patches.
> (but in it I missed your Reviewed-by)
>

Great! No worries about missing my R-b.

Stefan


> Helge
>

--000000000000114bec064330b6ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Nov 9, 2025, 17:08 Helge=
 Deller &lt;<a href=3D"mailto:deller@gmx.de">deller@gmx.de</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 11/9/25 21:57,=
 Stefan Hajnoczi wrote:<br>
&gt; On Mon, Nov 3, 2025 at 1:40=E2=80=AFPM Soumyajyotii Ssarkar<br>
&gt; &lt;<a href=3D"mailto:soumyajyotisarkar23@gmail.com" target=3D"_blank"=
 rel=3D"noreferrer">soumyajyotisarkar23@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Fixing Defects reported by Coverity Scan for NCR710 SCSI Controlle=
r in QEMU.<br>
&gt;&gt; QEMU runs the Coverity static analyzer to identify potential bugs =
in<br>
&gt;&gt; code that has recently been merged.<br>
&gt;&gt;<br>
&gt;&gt; In view of the above these issues came to light.<br>
&gt;&gt; I would request you to please review the fixes for the same.<br>
&gt;&gt;<br>
&gt;&gt; Reported by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.=
com" target=3D"_blank" rel=3D"noreferrer">stefanha@gmail.com</a>&gt;<br>
&gt;&gt; and GuoHan Zhao &lt;<a href=3D"mailto:zhaoguohan@kylinos.cn" targe=
t=3D"_blank" rel=3D"noreferrer">zhaoguohan@kylinos.cn</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Soumyajyotii Ssarkar (2):<br>
&gt;&gt;=C2=A0 =C2=A0 hw/scsi/ncr53c710.c: Fixing null pointer dereference =
issue.<br>
&gt;&gt;=C2=A0 =C2=A0 hw/scsi/ncr53c710.c: Fixing Incorrect expression=C2=
=A0 (IDENTICAL_BRANCHES)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0hw/scsi/ncr53c710.c | 8 +-------<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 7 deletions(-)<br>
&gt; <br>
&gt; I am not familiar with the device being emulated, so I have only<br>
&gt; reviewed this for C issues:<br>
&gt; <br>
&gt; Reviewed-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;<br>
<br>
Thanks!<br>
Btw, I just sent out a pull request which includes those patches.<br>
(but in it I missed your Reviewed-by)<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Great! No worries about missing my R-=
b.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Stefan</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Helge<br>
</blockquote></div></div></div>

--000000000000114bec064330b6ec--

