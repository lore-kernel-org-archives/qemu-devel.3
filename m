Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E32B606A32D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bmWciJQ/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=acoyis5K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNpgE-0002d9-K4; Mon, 02 Nov 2026 05:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xNpgC-0002cS-QI
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:54:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xNpgA-0000Y6-7U
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793616856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8JkwIqtkAhoMQdYs++jS79KeypxabwClZzrDxuxhq6c=;
 b=bmWciJQ/zo8coHqjT3RMDHVnULzQqIsagzq0CyNq9L1wFfeJEJpDocUKCf3iOueR9wZO5z
 VUjOoelsJ0+1PQmmRe9dQtVk3Hskm1OTP1eVqv2YCaqlRF62BcCmzp8jHfxPq7q4kXrfTa
 udTtgycvLvtegyWj6ddvP+5FqlsachY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-yo5bu1HkMYSOSyaoKbR8eA-1; Mon, 02 Nov 2026 05:54:14 -0500
X-MC-Unique: yo5bu1HkMYSOSyaoKbR8eA-1
X-Mimecast-MFC-AGG-ID: yo5bu1HkMYSOSyaoKbR8eA_1793616854
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5338ff2cf14so55188071cf.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:54:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793616854; cv=none;
 d=google.com; s=arc-20260327;
 b=ZRXZN0TPnVRgha2mGmafiU2duHYbJWQp5/j6pX3xd2rINtrMxwzvkrLfX7BzP8xUqa
 I94zfego8JQpsaxhNPEf+r1hfZD09f4ZGlNO7h2aE9WbRFZhuGdtDJzWZgj2PqoshYsP
 X4JxpowStHWZeNDF8Jqz3UKRCbSfJ0QvxjDMDAzp2CpeyvMjCfLUOFnrE16UTPCCW+gP
 vNtG2Vv7elSbr6DzQvq2anzt0fYdxm0A+UutfLpQLYtXY6oE3ygOF6q10+qzWD0+Si5w
 xn4o1QduU20FLmrd+al0aO1sKD6JWkbYSSOCBQuFNA8MsCzeNs81F0BMtKyJH41pYWf8
 /IFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8JkwIqtkAhoMQdYs++jS79KeypxabwClZzrDxuxhq6c=;
 fh=dhVLTACs/0z46fBiuuYrRB2JLlT6RmU3fdORTj8ZpBQ=;
 b=HvWl823eHNYZigfUM0qNXKsn3jU6OMuRMxAskOXVjfppvCWBhnXUthwrNFT4tieRbI
 JH1/R5EBtQY967l7UXuFwfi8Ps40LLQgrX3W2CAx/IKyAtzP84R2VZa5vAaHAwQJFys8
 bFxf/CdRCi4OTQGQayzEfRaxgeRp9J7v8IqpkR46wUmxxpv2b6g20wiOKK3yDcrDxLvS
 2Ztw5p7DxE+4zPtGd28rfnTHlB40CjkAW0clo7D5eTjNs55QSlYxEQZ7538QTmrM+mdw
 rTEz4njxsUUO0DKxuPXlCm1JfUCAy+wCuiajZcqc+v9Zb8DGrttLk8qU+YdS4p5AyYgR
 veTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793616854; x=1794221654; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8JkwIqtkAhoMQdYs++jS79KeypxabwClZzrDxuxhq6c=;
 b=acoyis5KqQI2X/Iq3gE4VsMpxS+mqXnjkVKtgqwDeEZdhGqUdi532P9FKH7JnXlqOk
 9vsy6IesQIyNSbYPj71nph+A5T9lzKhHicCZ8bISuGPglKH+DA776pSqJLTBaXJI4O5U
 Lm+KznUXWPQjbudO0dJOvkD2KA3fX947Ku5gGoFLWGWNadVuIc85J8thVoLZ76ze/YHm
 UzkTB85CYu5iN05xaqjZgRHRM3x2K854FuUQLEJZJy0xJdHTHZ0DQ68i2+QGL2KQzkCj
 FtqD8kKUJEInLoh9OK04g4AIMtRIku5LwwbzwOuZqqStkR/pVdRl5s/t6/uM59/jmX2u
 HU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793616854; x=1794221654;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8JkwIqtkAhoMQdYs++jS79KeypxabwClZzrDxuxhq6c=;
 b=IUVdsmP9K9EEpPWt4tHZiDWyKNPU13fG5ZjfwCBqMPFwUKzLvvWY+6uE0HD5n6Kd+u
 v9QqMRroZGNcKJKrsdSDE4mN5NN6leoVnv5JOWemb+FqivULXvmw6m4RhlvkH9w1ossX
 pJYEHm0JunssQrGd7gtAQXYgKowpQ1yfmjIWnttmB0U7u74iDDgn13tF7T+HTjzfJ409
 WeFR4O3frXS/ukdytPxyoY04VOFJw6HvyISYCulKuXnEeTLwOxPC1BppfueAUWRqlKob
 BU+M//xKZxwFloB7MDFTMmRucFFODCc6aa8fgVAj11MdS93EK+LsH983yFkvSldB7SnH
 MjKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8L2Hi5fHYWJrSw/u/8JLeq8A6GNHJcQHhmA+oxhwSpfNLS+s4Lxyd6Oz3gld1NE3rCgrkbcVNrkvl@nongnu.org
X-Gm-Message-State: APuU4Z8p9tQ4PNWbU5oITLmep4Wi52cmAoMNu4zFAd6wfzt7JhyNaNuG
 RzmPt3WuJ4nJTnHCGBQEB/AUVXU1CNZQRq026Cc3HEfmBzI/GmzZJhWYEEOTxcEUnx3NyUKKjPP
 GJGbrkxB1etJH2gZk/gmIRsVmQ3mbvV8aaUkPXTp2V32Rud3WFHfuxReJqjMK8P54qfhrPprfis
 JoJ7vFyIsjTbZMsOZuRGt0hSdVYxPcpjw=
X-Gm-Gg: AYBFou1K2HlY5rtXbJyhE8mjvuJ/flCxx1gjW8WIO+v9uXIaHrR95E5rSaYgL7gdWK2
 XdRzedrlAEOTaly2p40JRuVeNRkCBQ7CCw8AWb+R4qUreBdueofqgqGWH6PUrmF9luTMxJyt2WZ
 Cx/6jyLHtxbLPj522QJfOtdju6pihbqvm8Gz+NAVGiYFK/lTw9ObHGz2lnbRm0EmOd7Jj5zTLj7
 EjMEHni1+SUdVMvqAV60r7SlfmwvTOiGioLbghr453lTTeBWh96xQUBmyycgSS54NUsSo8lBDh8
X-Received: by 2002:a05:622a:1394:b0:536:5a1a:e5c0 with SMTP id
 d75a77b69052e-542b7d07747mr158511001cf.53.1793616853883; 
 Mon, 02 Nov 2026 02:54:13 -0800 (PST)
X-Received: by 2002:a05:622a:1394:b0:536:5a1a:e5c0 with SMTP id
 d75a77b69052e-542b7d07747mr158510861cf.53.1793616853423; Mon, 02 Nov 2026
 02:54:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261017201905.12211-1-samm@net-art.cz> <auhhZxsqfkPNt8T7@tulp>
In-Reply-To: <auhhZxsqfkPNt8T7@tulp>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 2 Nov 2026 12:54:02 +0200
X-Gm-Features: AclHuK8Vul5uO1v2ygHtXACKUh9XDZyw49JxKnJQdY07kMKFQPFy-5tGQmunX2s
Message-ID: <CAPMcbCrW+cA+orBL232Gv6_Jpb0BuYU=eS5M31M_9Tzq5Jo5aQ@mail.gmail.com>
Subject: Re: [PATCH] qga: set FreeBSD virtio-serial channel to raw mode
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: Oleksij Samorukov <samm@net-art.cz>, qemu-devel@nongnu.org, 
 Michael Roth <michael.roth@amd.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000696d0e065f48f700"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000696d0e065f48f700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

As this is a bug fix, we can merge it during the soft freeze.
I will pull this patch.

About the illumos build fixes, as it touches root meson, I want to see any
comments from maintainers of the build system.

Best Regards,
Kostiantyn Kostiuk.


On Mon, Nov 2, 2026 at 12:10=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gmai=
l.com>
wrote:

>   Oleksij Samorukov wrote:
>
> > On FreeBSD the virtio-console port is a tty, unlike Linux's
> > /dev/virtio-ports which is a character device.  It defaults to canonica=
l
> > mode with echo and software flow control enabled, so the QGA stream
> > protocol does not work: the initial guest-sync handshake is held in the
> > line discipline and the host eventually times out.
> >
> > The existing FreeBSD-specific code only clears ECHO.  Configure the por=
t
> > the same way as the ISA serial path: disable canonical mode, echo and
> > software flow control, and set VMIN/VTIME.  Use TCSANOW instead of
> > TCSAFLUSH so a handshake that arrives between open() and tcsetattr() is
> > not discarded.
> >
> > Tested on FreeBSD 15.1 aarch64 under UTM/QEMU.  Before the change
> > utmctl ip-address timed out and the guest received zero bytes; after th=
e
> > change QGA commands and guest-set-time work.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: c6cd588bb3a29a831c862780631a7d2145ade5de ("qga: Add initial
> FreeBSD support")
> > Signed-off-by: Oleksij Samorukov <samm@net-art.cz>
> > ---
> >  qga/channel-posix.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
>
> Hi Kostiantyn,
>
> Sorry to pester you, but is there a chance to pull this in while we're
> still
> in a soft freeze?
>
> Possibly along with the illumos build fixes [1].
>
> 1: https://patchew.org/QEMU/20261015173250.65942-1-bogorodskiy@gmail.com/
>
>

--000000000000696d0e065f48f700
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Roman,</div><div><br></div><div>As this is a =
bug fix, we can merge it during=C2=A0the soft freeze.</div><div>I will pull=
 this patch.</div><div><br></div><div><span class=3D"Asgive ng" style=3D"bo=
rder-style:none;background:none">About the illumos build fixes, as it touch=
es root meson,</span> I want to see any</div><div>comments from=C2=A0mainta=
iners of the build system.</div><div><br></div><div><div dir=3D"ltr" class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv>Best Regards,</div><div>Kostiantyn Kostiuk.</div></div></div></div><br><=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Nov 2, 2026 at 12:10=E2=80=AFPM Roman Bogorods=
kiy &lt;<a href=3D"mailto:bogorodskiy@gmail.com">bogorodskiy@gmail.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=
=A0 Oleksij Samorukov wrote:<br>
<br>
&gt; On FreeBSD the virtio-console port is a tty, unlike Linux&#39;s<br>
&gt; /dev/virtio-ports which is a character device.=C2=A0 It defaults to ca=
nonical<br>
&gt; mode with echo and software flow control enabled, so the QGA stream<br=
>
&gt; protocol does not work: the initial guest-sync handshake is held in th=
e<br>
&gt; line discipline and the host eventually times out.<br>
&gt; <br>
&gt; The existing FreeBSD-specific code only clears ECHO.=C2=A0 Configure t=
he port<br>
&gt; the same way as the ISA serial path: disable canonical mode, echo and<=
br>
&gt; software flow control, and set VMIN/VTIME.=C2=A0 Use TCSANOW instead o=
f<br>
&gt; TCSAFLUSH so a handshake that arrives between open() and tcsetattr() i=
s<br>
&gt; not discarded.<br>
&gt; <br>
&gt; Tested on FreeBSD 15.1 aarch64 under UTM/QEMU.=C2=A0 Before the change=
<br>
&gt; utmctl ip-address timed out and the guest received zero bytes; after t=
he<br>
&gt; change QGA commands and guest-set-time work.<br>
&gt; <br>
&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-s=
table@nongnu.org</a><br>
&gt; Fixes: c6cd588bb3a29a831c862780631a7d2145ade5de (&quot;qga: Add initia=
l FreeBSD support&quot;)<br>
&gt; Signed-off-by: Oleksij Samorukov &lt;<a href=3D"mailto:samm@net-art.cz=
" target=3D"_blank">samm@net-art.cz</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/channel-posix.c | 22 +++++++++++++++++-----<br>
&gt;=C2=A0 1 file changed, 17 insertions(+), 5 deletions(-)<br>
<br>
Hi Kostiantyn,<br>
<br>
Sorry to pester you, but is there a chance to pull this in while we&#39;re =
still<br>
in a soft freeze?<br>
<br>
Possibly along with the illumos build fixes [1].<br>
<br>
1: <a href=3D"https://patchew.org/QEMU/20261015173250.65942-1-bogorodskiy@g=
mail.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/20=
261015173250.65942-1-bogorodskiy@gmail.com/</a><br>
<br>
</blockquote></div>

--000000000000696d0e065f48f700--


