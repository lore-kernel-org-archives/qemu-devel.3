Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA5EC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiZuY-0007vq-Eh; Thu, 13 Feb 2025 09:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikrant1garg@gmail.com>)
 id 1tiWjv-0006mw-AP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 05:46:39 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikrant1garg@gmail.com>)
 id 1tiWjt-0004Mc-KQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 05:46:39 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fbfe16cc39so1447278a91.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 02:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739443596; x=1740048396; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lKqt/aWtAZjId1Pfu193puqbyjM/WI9iSlYagyYHAj8=;
 b=DWbaKJLOeak7qKlURJGiq/kQOciZBqA0rY8BD2Ex8Fqeydt4H+DIWDillHNfw9crb3
 ywF7uVtJYe94iMY5HqiBWstXaD2y5jvqQtDysFFj2kchd0EnFrYMAw80tNWUOPu0/ge2
 6vYArLC2gb77zm39RnnZNBLO64nQJ0VYeut3GRIhwfhMb753e1psTarln35jNh38pR5T
 J08MHBLsUvk2EDdbdHPEStfNnvO09T7kg1UbuIYno3QJJpveu24LbSJ0vAai1r7MrZ76
 uSqIi3vxXhceu/Plw4H7ICcALo/BXgJeSdxDLyB8n32+DcTomJAkXcIgztm1BiooOBig
 5VzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739443596; x=1740048396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lKqt/aWtAZjId1Pfu193puqbyjM/WI9iSlYagyYHAj8=;
 b=l1DA5HZoFAtQum6ADbJCOD151iUNpJT7LWf9xslKom9g8nMzl5sVihzwLuPUJuGes2
 ZOJx72EjoSmKdWfO3aPCsdR4YQ5tZEuUHcqCMdT1LgHJ9No5h7QRvW3CITWINZluM+9r
 XkG/D0GISEqTyUUopt+Y6rDy2jzERpZpoBkRSzYgopiHJcFnfq0oVJ7x+kyQHSTyYG1O
 xfRLayRNl2TmcZ1U+DDIr39wI0tQ2PO3f4x7hgoBkxcxopvsFdgOsC8Dk3m6VdWwReBU
 FAtStXqF9qNcseyo7wPgSVizBQSdf9M+jApSKKwoJu9+M076vsXC/VZNM094ix9Zkpqz
 OB1Q==
X-Gm-Message-State: AOJu0YxFnHp05TPAWQD/YspOIrafs9+RIXxPrx5iUyfq2NLQRTp4UMEU
 0DdryoC4UxkUgeiBY8+GaI7bZ4OPIvNLmkixVvawfNYlxylCL0WFN65cFuX6UAwkQeZIw4FY8eh
 V4ga2LIcpXGCDVtZ31/TQg4YK9KQ=
X-Gm-Gg: ASbGncthewmCdHy2e7W+5wEr+R7O8XTxbJnhlgjkrfD45c/mSCLDBZqChYp4lCfvr3Z
 jVL0A2sskatqG+S2b0YlzY2dDQWp9dSRgfcbPYCsgFfOh/KkGQoZtcIIAT8ToAATvTW6Ldfu7Tg
 ==
X-Google-Smtp-Source: AGHT+IGhsjFkJGbsS42Y1hPnTeaH66VJXd9wZPkRv1l4sEVtOwLpfrdp72QsDYZZMbWOJq+LrGQyWKI9I3wLsLNv9Jw=
X-Received: by 2002:a17:90b:2e4f:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-2fbf5bb1cdcmr10274257a91.5.1739443596020; Thu, 13 Feb 2025
 02:46:36 -0800 (PST)
MIME-Version: 1.0
References: <CAKXOwk1_zPNBaQZyiHb8A5D+3euZuvjW__Cqi3_PKgad95rDKg@mail.gmail.com>
 <6e184a9b-32f2-403b-b499-5d3b618e0bd8@amazon.com>
In-Reply-To: <6e184a9b-32f2-403b-b499-5d3b618e0bd8@amazon.com>
From: Vikrant Garg <vikrant1garg@gmail.com>
Date: Thu, 13 Feb 2025 16:16:24 +0530
X-Gm-Features: AWEUYZloLuO7H-sbabc9ut81kME0V3-I2svscctyMyd07arMAO7evAtt9xANVUo
Message-ID: <CAKXOwk2Eba8qnqKQqCN+=2+N=WRPzAwx3LkoccEwR-3xgt32uw@mail.gmail.com>
Subject: Re: [Qemu Nitro Enclave] NSM virtio attestation response is always of
 size 0x3000
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, Dorjoy Chowdhury <dorjoychy111@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a5d451062e03c507"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=vikrant1garg@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 13 Feb 2025 09:09:45 -0500
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

--000000000000a5d451062e03c507
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot, Alex.

You got the right fix. This is working for me. Expected length of response
is being returned now.

Vikrant

On Thu, Feb 13, 2025 at 4:00=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:

> Hi Vikrant,
>
> On 13.02.25 11:01, Vikrant Garg wrote:
>
> > Hello All,
> >
> > I am using the QEMU for emulating nitro enclave images. In my enclave
> > image, I have an attestation service implemented in Rust. This
> > application fetches attestations using IOCTL command. I have noticed
> > that response from the nsm virtio device is always of length 0x3000
> > (i.e. maximum NSM response size). Instead, it should be the actual
> > size of response bytes. Same case is also happening with the
> > attestation service implemented in python. On the other hand, the same
> > Rust attestation service is working with AWS nitro enclaves. It looks
> > like an NSM emulation issue.
> >
> > I would like to confirm if this is the expected behaviour and need
> > help on further debugging.
>
>
> Thanks a lot for the report! Does this happen with all commands or only
> the Attest command? The NSM emulation code attempts to trim the response
> size to the actual payload, but there may well be a bug in that logic.
>
> I do have a hunch on what the problem may be. Can you please quickly try
> the patch below?
>
>
> Thanks!
>
> Alex
>
>
> index 098e1aeac6..b22aa74e34 100644
> --- a/hw/virtio/virtio-nsm.c
> +++ b/hw/virtio/virtio-nsm.c
> @@ -1596,7 +1596,7 @@ static void handle_input(VirtIODevice *vdev,
> VirtQueue *vq)
>       g_free(req.iov_base);
>       g_free(res.iov_base);
>       virtqueue_push(vq, out_elem, 0);
> -    virtqueue_push(vq, in_elem, in_elem->in_sg->iov_len);
> +    virtqueue_push(vq, in_elem, sz);
>       virtio_notify(vdev, vq);
>       return;
>
>

--000000000000a5d451062e03c507
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks a lot, Alex.</div><div><br></div><div>You got =
the right fix. This is working for me. Expected length of response is being=
 returned now.</div><div><br></div><div>Vikrant</div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Thu, Feb 13, 2025 at 4:00=E2=80=AFPM Alexander Graf &lt;<a href=3D"mai=
lto:graf@amazon.com">graf@amazon.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Hi Vikrant,<br>
<br>
On 13.02.25 11:01, Vikrant Garg wrote:<br>
<br>
&gt; Hello All,<br>
&gt;<br>
&gt; I am using the QEMU for emulating nitro enclave images. In my enclave =
<br>
&gt; image, I have an attestation service implemented in Rust. This <br>
&gt; application fetches attestations using IOCTL command. I have noticed <=
br>
&gt; that response from the nsm virtio device is always of length 0x3000 <b=
r>
&gt; (i.e. maximum NSM response size). Instead, it should be the actual <br=
>
&gt; size of response bytes. Same case is also happening with the <br>
&gt; attestation service implemented in python. On the other hand, the same=
 <br>
&gt; Rust attestation service is working with AWS nitro enclaves. It looks =
<br>
&gt; like an NSM emulation issue.<br>
&gt;<br>
&gt; I would like to confirm if this is the expected behaviour and need <br=
>
&gt; help on further debugging.<br>
<br>
<br>
Thanks a lot for the report! Does this happen with all commands or only <br=
>
the Attest command? The NSM emulation code attempts to trim the response <b=
r>
size to the actual payload, but there may well be a bug in that logic.<br>
<br>
I do have a hunch on what the problem may be. Can you please quickly try <b=
r>
the patch below?<br>
<br>
<br>
Thanks!<br>
<br>
Alex<br>
<br>
<br>
index 098e1aeac6..b22aa74e34 100644<br>
--- a/hw/virtio/virtio-nsm.c<br>
+++ b/hw/virtio/virtio-nsm.c<br>
@@ -1596,7 +1596,7 @@ static void handle_input(VirtIODevice *vdev, <br>
VirtQueue *vq)<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(req.iov_base);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(res.iov_base);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtqueue_push(vq, out_elem, 0);<br>
-=C2=A0=C2=A0=C2=A0 virtqueue_push(vq, in_elem, in_elem-&gt;in_sg-&gt;iov_l=
en);<br>
+=C2=A0=C2=A0=C2=A0 virtqueue_push(vq, in_elem, sz);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_notify(vdev, vq);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>
<br>
</blockquote></div>

--000000000000a5d451062e03c507--

