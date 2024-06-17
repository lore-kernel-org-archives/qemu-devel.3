Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2210AC2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 13:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJCm0-0002AA-0p; Mon, 17 Jun 2024 09:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sJClx-00029s-Kz; Mon, 17 Jun 2024 09:51:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sJClv-0005lZ-FK; Mon, 17 Jun 2024 09:51:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4218008c613so33388835e9.2; 
 Mon, 17 Jun 2024 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718632306; x=1719237106; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c28mHYw5xfDhTn1H7rpMiBM1Ge3t2t9bRtHVIajFd9s=;
 b=R/9KoPDg5vqnyNY+l3KCq9ipAiSVF7T4235R7+bZ2eoT0003q0OW5cNNyWq+CGNYhL
 Zx2dY6tHXMeRwyQT37Z8n4JQQMyyJCFga1850GGRggflV3ROEB7DmYijnDZsnC0L8iYv
 l1qAvaWEqDbpr69ts/20qmcIfXBpEr9CLVQz52F+5epsVdxqYn5y21O+VTd4xUcBBFjB
 M/28HxSBGqMMBDjiYFBKqFFnH0hHddhNxnuiLQ2EazITaJVADHHKuziqANvuep4Lhrka
 tSMp6pB38bMJotMBm5SvMui0yrz9Sq7lKJwk4UQ5YrsnV4ZsOifGwHf6zKcMvIGyFl7u
 3qWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718632306; x=1719237106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c28mHYw5xfDhTn1H7rpMiBM1Ge3t2t9bRtHVIajFd9s=;
 b=CByoayA3yI/KyjwDWbfALboWVDCVKK2fY3Ly6d6NlRmlFxhpv+TEoZo9DGwFHir5eB
 1HuWS/aB2FxD5TDKvxYcwiP8npI2g2MoXPYpLIUNyTCzoRt2Anj2L1vIHsaVNMI1OUAU
 05ESfzAEMduzr15U6ZIcp0itXLrhzFFIbcZtwyiVleckg7cLI5oqf5NkoRrq0SfuGuz7
 iS/ufTpRtRIc1tOuFx1mN84/++3GIefT3n68hZUUFfnMCDNdnCdccGriSxhFN3AaqZBO
 otM0evrs+9dpMQJ8K9qwSwzW07rLewUIwaSLGlC83UO2g0xfQhMz2tbLlKfIcYzfxPhm
 YXSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9KxVzXhX/ikIBok8+AeGUPAkkhzkcIJmGf5q8cR+xP+ePsHJnznThYIAMzILwvE50xfsv81mFf9xmgX4XNKFz+NwtocS/
X-Gm-Message-State: AOJu0YyNlSiMU3j5+qtTftJyn1mQ8mVfFTjFDjlkzp8mJt2qYWney2da
 scHWJfIEtdJD+rpDBY3Jf5LdHUS21Jngu+p+2I6/p5VWRMfjIl934ZTP0I54EMKHSsJLQMDGx0Z
 YGCIWLOQMpeWJChUq3nUaWFyHJNA=
X-Google-Smtp-Source: AGHT+IFX2rALWPnue2biN7KWxLFQ0Dny22Wurax5SdafKVKgv0z9ZJ0cfdloaLtnyXDu8LCVpmfJH+18XoSfhAJTor4=
X-Received: by 2002:a05:600c:c88:b0:422:9e15:3ff6 with SMTP id
 5b1f17b1804b1-4230482fc06mr88039025e9.22.1718632305452; Mon, 17 Jun 2024
 06:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240613022147.5886-1-east.moutain.yang@gmail.com>
 <20240617065455-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240617065455-mutt-send-email-mst@kernel.org>
From: Yang Dongshan <east.moutain.yang@gmail.com>
Date: Mon, 17 Jun 2024 21:51:33 +0800
Message-ID: <CALrP2iV14404dq+5xO8Ziq4fEuacvkU=SjJLT=FJGLAq1Xanhg@mail.gmail.com>
Subject: Re: [PATCH] Update event idx if guest has made extra buffers during
 double check
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000010eeb8061b164408"
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000010eeb8061b164408
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi,

subject should list the affected component, and be shorter.

ok, I will rewrite the subject:
"update the latest available idx seen by the host to event idx"

Fixes: 06b12970174 ("virtio-net: fix network stall under load")

this should come at the end.

I have submitted v2, it's at the end now.

and what exactly does this refer to?
>
Commit 06b12970174 double-checks whether the guest has made some
buffers available after the first check,  it will be lucky if the available
buffer
size can satisfy the request.

did this commit cause a regression of some sort?
>
No regression. If the buffer size still can't satisfy the request even if
the
guest has made some buffers.  this commit doesn't notify the latest
shadow_avail_idx seen by the host to the guest. Similar to the first
check, if the available buffer is not enough, notify the guest with the
updated shadow_avail_idx.

what does "double check" refer to?
>
it refers to the second nested if condition judgment in
virtio_net_has_buffers().

which makes sense why?  And which changes the correct behavious of what
> to a new behaviour of what which is better why?
>
Similar to the first check, if the buffer size still can't satisfy the
request, notify the
guest with the updated shadow_avail_idx, it's better than the old one.

On Mon, Jun 17, 2024 at 6:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

>
> Thanks for the patch!
> Yet something to improve:
>
>
>
> subject should list the affected component, and be shorter.
>
> On Thu, Jun 13, 2024 at 10:21:47AM +0800, thomas wrote:
> > Fixes: 06b12970174 ("virtio-net: fix network stall under load")
>
> this should come at the end. and what exactly does this
> refer to? did this commit cause a regression of some sort?
>
> > If guest has made some buffers available during double check,
>
> what does "double check" refer to?
>
> > but the total buffer size available is lower than @bufsize,
> > notify the guest with the latest available idx(event idx)
> > seen by the host.
>
> which makes sense why?  And which changes the correct behavious of what
> to a new behaviour of what which is better why?
>
> Pls review docs/devel/submitting-a-patch.rst and follow the
> process there.
>
>
>
> > ---
> >  hw/net/virtio-net.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 9c7e85caea..23c6c8c898 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -1654,6 +1654,7 @@ static int virtio_net_has_buffers(VirtIONetQueue
> *q, int bufsize)
> >          if (virtio_queue_empty(q->rx_vq) ||
> >              (n->mergeable_rx_bufs &&
> >               !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> > +            virtio_queue_set_notification(q->rx_vq, 1);
> >              return 0;
> >          }
> >      }
> > --
> > 2.39.0
>
>

--00000000000010eeb8061b164408
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>hi,=C2=A0</div><div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">subject should list the affected component, and =
be shorter.</blockquote><div>ok, I will rewrite the subject:=C2=A0</div><di=
v>&quot;update the latest available idx seen by the host to event idx&quot;=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fixe=
s: 06b12970174 (&quot;virtio-net: fix network stall under load&quot;)=C2=A0=
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">this should =
come at the end.=C2=A0</blockquote><div>I have submitted v2, it&#39;s at th=
e end now.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">and what exactly does this refer to?<br></blockquote><div>Commit 06b1=
2970174 double-checks whether the guest has made some</div><div>buffers ava=
ilable after the first check,=C2=A0 it will be lucky if the available buffe=
r</div><div>size can satisfy the request.=C2=A0</div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">did this commit cause a regressi=
on of some sort?<br></blockquote><div>No regression. If the buffer size sti=
ll can&#39;t satisfy=C2=A0the request even if the</div><div>guest has made =
some buffers.=C2=A0 this commit doesn&#39;t notify the latest=C2=A0</div><d=
iv>shadow_avail_idx seen by the host to the guest. Similar=C2=A0to the firs=
t<br></div><div>check, if the available buffer is not enough, notify the gu=
est with the</div><div>updated shadow_avail_idx.</div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">what does &quot;double check&qu=
ot; refer to?<br></blockquote><div>it refers to the second nested if condit=
ion judgment in</div><div>virtio_net_has_buffers().=C2=A0</div><div><br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">which makes sense why?=
=C2=A0 And which changes the correct behavious of what<br>to a new behaviou=
r of what which is better why?<br></blockquote><div><div>Similar=C2=A0to th=
e first check, if the buffer size still can&#39;t satisfy the request, noti=
fy the</div></div><div>guest with the updated shadow_avail_idx, it&#39;s be=
tter than the old one.</div><div>=C2=A0</div><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 17, 2024 at 6:58=E2=80=AFPM =
Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Thanks for the patch!<br>
Yet something to improve:<br>
<br>
<br>
<br>
subject should list the affected component, and be shorter.<br>
<br>
On Thu, Jun 13, 2024 at 10:21:47AM +0800, thomas wrote:<br>
&gt; Fixes: 06b12970174 (&quot;virtio-net: fix network stall under load&quo=
t;)<br>
<br>
this should come at the end. and what exactly does this<br>
refer to? did this commit cause a regression of some sort?<br>
<br>
&gt; If guest has made some buffers available during double check,<br>
<br>
what does &quot;double check&quot; refer to?<br>
<br>
&gt; but the total buffer size available is lower than @bufsize,<br>
&gt; notify the guest with the latest available idx(event idx)<br>
&gt; seen by the host.<br>
<br>
which makes sense why?=C2=A0 And which changes the correct behavious of wha=
t<br>
to a new behaviour of what which is better why?<br>
<br>
Pls review docs/devel/submitting-a-patch.rst and follow the<br>
process there.<br>
<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 hw/net/virtio-net.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index 9c7e85caea..23c6c8c898 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -1654,6 +1654,7 @@ static int virtio_net_has_buffers(VirtIONetQueue=
 *q, int bufsize)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (virtio_queue_empty(q-&gt;rx_vq) =
||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (n-&gt;mergeable_rx_bu=
fs &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!virtqueue_avail=
_bytes(q-&gt;rx_vq, bufsize, 0))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_queue_set_notificati=
on(q-&gt;rx_vq, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -- <br>
&gt; 2.39.0<br>
<br>
</blockquote></div></div>

--00000000000010eeb8061b164408--

