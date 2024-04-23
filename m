Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DA1C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 01:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz5G8-0005IS-Td; Mon, 22 Apr 2024 21:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rz5G6-0005IK-70
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 21:47:46 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rz5G3-0004cG-7G
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 21:47:45 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2a526803fccso3308736a91.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 18:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1713836739; x=1714441539;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SAp0UxNsst5qxLvg7CxbhsUkT1S71gf24H1Rqo80J88=;
 b=3ZWKmiWmV294HEbxL02Unq0dQ5dsfydDe3yvtQ2jnBdcUQgeBtHbUyXGp7vRF2VqTk
 lrvHJc0e8JVgLFg8F0aKhFnQABW+hFRXBOP9+6y7+2EFNLTFh9p40wSLjdTLuZG4ikVx
 XpZIaeubYx6WYjZolRW69ylcokOfjczJRPu8MlS0GRviLyaAFzWt4QLrkjweTULKkjIF
 e+COBaotDrM7Y8FVBg4PRF7+Z2WenxPLidFfPa+QsJII79gYrIiFuLeqKm7J6Q0fRm4Z
 5CV7HhvEv+gx14JAo8TEnqqeVuhHCh8DBq1xQIyq4JItNgjkRkZZv0uW2Q3ddUKyxRTl
 HJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713836739; x=1714441539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SAp0UxNsst5qxLvg7CxbhsUkT1S71gf24H1Rqo80J88=;
 b=nGljz7MRa4aPAXneofIaN/8rPo0Tv9ZaRUy1pTpFXgt3/7sAl9uM0FLJ3qMPYLlEI/
 SYpWzmnqNwssiHTYCtx/8C5YIeT7lBG3iHXUyYuPyFImjIrwylif0cpmvYKEtfBiN6jG
 MLMlP5bUkR61J8uoJAYYK9PE3DWSgib5LnlIUUtxjHh3N/KRrGCYv34XwjuiXHAqGwvI
 mDz0xqck9AC79TLhnR0S6tOm4dU/i3RyewzPyLSbr51m3mD89CFc0OzADahJU65Xz7/n
 8W62X/fTYRYoQSB3ejegXWyfuQ1i7R/iArF08K/98bCFeSazPgCw2XcKkRKBfAvciVPN
 Dkfw==
X-Gm-Message-State: AOJu0Yz0N5SJpJvVabSGQuPdIG403+y3HEfHT/vMnwNwZRux0bClZpM4
 cbRy3L6SRr6VGjOkvcH7vgyiQyTYBngZyi3JHFLwf3F4fYrksGvrnJ2Q3XisZENjd6Lql1PP1Y6
 b2L++l/8nzTR2vZvbuS08xDDyblvzEfdR7gtyk1oXx8n3beZZcqrM8qNz
X-Google-Smtp-Source: AGHT+IFS+2yVjSBiyW9ClQN2h4A2qBZj77e+uAg0TzOkDe/pcF0LkeVe3Zx5WtmvvbOFMZSeQkxfSVz3mG6GQq1g6Aw=
X-Received: by 2002:a17:90a:5784:b0:2ac:7a71:9a26 with SMTP id
 g4-20020a17090a578400b002ac7a719a26mr8560953pji.47.1713836738745; Mon, 22 Apr
 2024 18:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1712577715.git.yong.huang@smartx.com>
In-Reply-To: <cover.1712577715.git.yong.huang@smartx.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 23 Apr 2024 09:45:22 +0800
Message-ID: <CAK9dgmaHJF-JWSRww1raYFYxCZ4b19ydH3nWQzv1-VqzqiJuDA@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/2] Fix crash of VMs configured with the CDROM
 device
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="0000000000000433bf0616b9b6b2"
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000000433bf0616b9b6b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.
I would appreciate comments on this series. Thanks,

Yong

On Mon, Apr 8, 2024 at 8:08=E2=80=AFPM Hyman Huang <yong.huang@smartx.com> =
wrote:

> This patchset fixes the crash of VMs configured with the CDROM device
> on the destination during live migration. See the commit message for
> details.
>
> The previous patchset does not show up at https://patchew.org/QEMU.
> Just resend it to ensure the email gets to the inbox.
>
> Please review.
>
> Yong
>
> Hyman Huang (2):
>   scsi-disk: Introduce the migrate_emulate_scsi_request field
>   scsi-disk: Fix crash of VMs configured with the CDROM device
>
>  hw/scsi/scsi-disk.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> --
> 2.39.3
>
>

--=20
Best regards

--0000000000000433bf0616b9b6b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:comic sa=
ns ms,sans-serif">Ping.</div><div class=3D"gmail_default" style=3D"font-fam=
ily:comic sans ms,sans-serif">I would appreciate comments on this series. T=
hanks,</div><div class=3D"gmail_default" style=3D"font-family:comic sans ms=
,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:co=
mic sans ms,sans-serif">Yong</div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 8, 2024 at 8:08=E2=80=AFPM Hy=
man Huang &lt;<a href=3D"mailto:yong.huang@smartx.com">yong.huang@smartx.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-lef=
t-color:rgb(204,204,204);padding-left:1ex">This patchset fixes the crash of=
 VMs configured with the CDROM device<br>
on the destination during live migration. See the commit message for<br>
details.<br>
<br>
The previous patchset does not show up at <a href=3D"https://patchew.org/QE=
MU" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU</a>.<br>
Just resend it to ensure the email gets to the inbox.<br>
<br>
Please review.<br>
<br>
Yong<br>
<br>
Hyman Huang (2):<br>
=C2=A0 scsi-disk: Introduce the migrate_emulate_scsi_request field<br>
=C2=A0 scsi-disk: Fix crash of VMs configured with the CDROM device<br>
<br>
=C2=A0hw/scsi/scsi-disk.c | 35 ++++++++++++++++++++++++++++++++++-<br>
=C2=A01 file changed, 34 insertions(+), 1 deletion(-)<br>
<br>
-- <br>
2.39.3<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div>

--0000000000000433bf0616b9b6b2--

