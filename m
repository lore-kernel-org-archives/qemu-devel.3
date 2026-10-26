Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D8606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SuHW5ZtS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLDDq-0004F1-V0; Mon, 26 Oct 2026 01:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paulsheer@gmail.com>)
 id 1xLDDp-0004Eq-4Z
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 01:26:13 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paulsheer@gmail.com>)
 id 1xLDDn-0000nT-Ei
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 01:26:12 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-91b813ac020so39792706d6.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 22:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792992370; cv=none;
 d=google.com; s=arc-20260327;
 b=l6/G4gnNZ7n3xauZRNaJGtk+WSZEegjtg7iXRKIhQ8L/e69Ub8ou9r/Uwg4KWVtwW6
 Bq1Np+JrncPdK3VWtaNvH9+YkLTTqmnn07uUlCzLqms8WbvWgZLg6aK1+gkzizeej2t5
 6h3m+OiahHJDKGw9N9k7Fk2rQDvuuSrbn+kHeoaUuOXWV2bxfE5std7vjgvKBNeQeSKA
 xgSRfySs6sAYABuJH0sRrLn1LAM/Eer7iB0ktfQEs8yGK1/XtkdOv9cQVUP+o+nDaiy4
 0euVyNpNNKu9bEuJj6eDuQeqk0JOfdGet/KO9MLTiB9MIEXW9adJenyeUC4TDwYIy7YY
 CknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=6LBFonPAF+acjLh8mfC+I9luIbsvLbB81bph/9wg5Dg=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=pJhAAJ7RZtTDG5QEqhA0akbfKDxfES4WiBdFalZ+HKZekm4odoA3qA2pecT4K/unBZ
 ARsWkiYkEVAIv5HtcOuABXFlwdLFpr16wtGcUpjkL/JhbEhNNTr9TXagetPdu5PbeTZW
 oQ70QintWTes26FKdaHcFBBaVqfyKMm5RAClTsnO11fmSsCjrwVN3mQjhqAPrOyg+9/I
 pgunU1G9IfcOzFnCm0/UjQIBuae43uDvtPEdInQH3/rCWUiCV7odt+yFc6RcGnGmzGl6
 X7tDO1ETiNCk7Dubr8F3y6ZPnZHqeANRxl8auesJ5NViHhfPoR7Osdvjb8yIdSEmKZAR
 N/WQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792992370; x=1793597170; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6LBFonPAF+acjLh8mfC+I9luIbsvLbB81bph/9wg5Dg=;
 b=SuHW5ZtSgegu2uPAZb+y2eDRl1lm4rOJU+8Fp4WSKi9u6m5H/3UIMpgDRtuAsJR8W4
 BysVEamLlZe6Fifj3pQh7AP3WgHbJoqQ/xhmKtBI+Y1HTxoN9BKTstCuS8LxYLpsUPY/
 gLgGfk9CE6Djpndyo4SZJhXm/gTRKSA8l+q993V51qdoy0AXL4c1rIL0J7UCzAX7LzLY
 Ry5/hX/qbH853zUc+96UJcgajjFkS9NLKFxsFsZeb+6MzSaBWEKEjAT04wjcv6GrP4kR
 yxRrYNTw7L78RUBbyjVUFminRX+UAFUgFc/m3W2032Bse9KlSc2e6tE5X9uJfN971voc
 UCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792992370; x=1793597170;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6LBFonPAF+acjLh8mfC+I9luIbsvLbB81bph/9wg5Dg=;
 b=EeGYTXKag6f59hEjNoi8UKnGfn0vgG+iiBtnfjssGkYGXL9fDwc5RFncGtzty6jpaa
 TJyC/ikLVrIL4bc+SQYkTXZIuKwzLKSY1/B5d0Yfu/nquPs/zM1PaGIK0uTlMVEZpvXB
 6iJaF5WGdL2XQyMu0ZInvEQRbqv5E6ScerTYzX6MWlCKJWX+Gw2deNEO1nWhlfmXSfHD
 rJ8mWBwZKhv+oS7PnfWvGGeKD6We9s/2+OeI5xrxEuE8g22/F/RTDvR457ZQgsoCheq9
 9ky2g090XVsQcFQk+y6mZ008IloJpNY8796PgWuq8SZpG5IfA8KQcFMP9TbxPdeXXj9Y
 J51w==
X-Gm-Message-State: AFq9FYKjwclAOvgeLXfpO5DXdOU5+uUkVBtdDUqPOf9t7PJan6/8NHEi
 bhvUR5NQMQ3R6DdzcIcYcq9V2eIPfz5pVS0iPrNbZA5bczA7IzBwV0zDJid9RMny0zBiqeYZyW5
 0Lji2WYkRVZNzVaupT3GPK871FAWilA9amEu2wmQ=
X-Gm-Gg: AYBFou0Eyw7z/5LBhwmAhUSWKhdoFIeRO7OFZZ3OwIkzNPBVWqtcOqDzZsdmtjfTo6j
 ipGxuRlcbyP/tid9YliNKpEJiMZxqNUYNEcM6LEP1dqYem2zvEoSfFVZj56IaGelKbj1ggWFsF0
 p/r7TPwp9ZzgHHzOMEKQpH6C7ryB/CNBxHZSZe32hvScyBgFbQo4Wnhi9u5QnTBoObWevfmlKus
 IqI7W9o7umkh/YQ5FauTqdP+y9P8EI7ZKK0XlahV1x+7n8vbDypQFgxueksZUurh0gJuO0uJxQM
 gagwTCo4KycgRUrvX0/vQ+ORn/G8cgp7Fs7njYCxxX1zAzUiOZin2ZroKQd56GdI6KLkA4szBCL
 8k7s9ZRWidJFFvowZ/qL69cwETtFhOW10FJuf/GGd4hlfhTCEWgdaOwdC/S+0bAZOOnY=
X-Received: by 2002:a05:6214:5701:b0:917:98b6:51ff with SMTP id
 6a1803df08f44-91c48e36ae6mr93306336d6.32.1792992369965; Sun, 25 Oct 2026
 22:26:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Paul Sheer <paulsheer@gmail.com>
Date: Mon, 26 Oct 2026 00:25:57 -0500
X-Gm-Features: AclHuK_dk4w2wRg5EIRngr2dCqcbb3JJnWSyT6qmn8_6fEd3yqVrYazxLkqz3jo
Message-ID: <CABxOuY-6JxS1+HcR0t-yteY2+S7saB8ogjxkqa7bedwKu2Xw+Q@mail.gmail.com>
Subject: Solaris 10 on SPARC 64 running, but not stable
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004bfc9e065eb791ef"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=paulsheer@gmail.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000004bfc9e065eb791ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I dumped the entire disk of a real Solaris 10 V210/V240 box into a qcow2
image on Linux,
and then tried to boot it with qemu.

The list of patches/fixes I needed to apply is very long --- beside a bunch
of code changes, there is also changing from SCSI to IDE and from hme0 to
e1000, getting the device mappings to work, and so on.

It finally boots all the way through and starts its services and I can ssh
into it.

However it doesn't seem to be stable. Within an hour it silently stops.

Is anyone interested in this kind of work?

Has anyone got this to run stable and under load?

[[The only reason I keep this V210 around is to occasionally test some
software big-endian (not that easy these days with big-end boxes
disappearing =F0=9F=98=82). But I panicked when I had to replace the mother=
board last
week "...what if this box one-day becomes unrepairable?" -- hence my
experimenting with qemu.]]

If anyone is interested then contact me directly on paulsheer@gmail.com and
I will share all the changes I made.

Kind regards,

Paul

--0000000000004bfc9e065eb791ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div>Hello,<div><br><div>I dumped the entire dis=
k of a real Solaris 10 V210/V240 box into a qcow2 image on Linux,</div><div=
>and then tried to boot it with qemu.</div><div><br></div><div>The list of =
patches/fixes I needed to apply is very long --- beside a bunch of code cha=
nges, there is also changing from SCSI to IDE and from hme0 to e1000, getti=
ng the device mappings to work, and so on.</div><div><br></div><div>It fina=
lly boots all the way through and starts its services and I can ssh into it=
.</div><div><br></div><div>However it doesn&#39;t seem to be stable. Within=
 an hour it silently stops.</div><div><br></div><div>Is anyone interested i=
n this kind of work?</div><div><br></div><div>Has anyone got this to run st=
able and under load?</div><div><br></div><div>[[The only reason I keep this=
=C2=A0<span style=3D"background-color:transparent">V210 around is to occasi=
onally test some software big-endian (not that easy these days with big-end=
 boxes disappearing=C2=A0</span>=F0=9F=98=82<span style=3D"background-color=
:transparent">). But I panicked when I had to replace the motherboard last =
week &quot;...what if this box one-day becomes unrepairable?&quot; -- hence=
 my experimenting with qemu.]]</span></div><div><br></div><div>If anyone is=
 interested then contact me directly on <a href=3D"mailto:paulsheer@gmail.c=
om">paulsheer@gmail.com</a> and I will share all the changes I made.</div><=
/div><div><br></div><div>Kind regards,</div><div><br></div><div>Paul</div><=
div><br></div><div><br></div><div><br></div></div>

--0000000000004bfc9e065eb791ef--

