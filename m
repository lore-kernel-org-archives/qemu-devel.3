Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75ACC35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 07:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvWoq-0002oZ-Ub; Fri, 21 Mar 2025 03:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tvWop-0002oM-3Q
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 03:29:27 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tvWol-0005tz-EA
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 03:29:26 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-601b6146b9cso817546eaf.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1742542160; x=1743146960;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eIRNPv4rLRBFV+cFFWkneGzqFU5TbFs2kSwtwegpb10=;
 b=lQdCfalATqRDkfw/WlRBRNBwRBVsqnaqtYeDLDRD5Y36xhdqVAlX4Ed7QIbaqAalDZ
 wuzgZjCHAV1DZ5NObcE/QiGdFYeqEFc46A2/BoW1gL3mC2CKyz50m+Su6Rj8Y6m01nN3
 z50ymlaihElYcrfDdp+LHy/iLpttYVVZd6L4vHIlGgK50oXMtVzbRQqZBzODTD0mWMFg
 Xose3bIFA/Sf9wxtrz5WGT5HVs0gm4HMmBLhomGqTW2e8YeauzfE/xn/K2ud8lOdtP+3
 6W2WgONWX9Xa/9TTe6IWqjcIVjlKag3sr5g8swLhiGGWFxLzY8ibEzs4tq4i8RI6BKIV
 YICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742542160; x=1743146960;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eIRNPv4rLRBFV+cFFWkneGzqFU5TbFs2kSwtwegpb10=;
 b=aP4MBhjbWqeL4RJin7t5RjpPhyDiTzx1Bs2DulSRRBTxORsuWzShUcvEEJ75qQg/RG
 LQ+taDhIpo+BQi4BAvM8uNnd/6xO03lM7ceUdnN5WimrKoB+ft0f92YmCYgYZuq9qEMr
 Mn7dyLNvIV3vF0cCXV9fRIvQAzVJaKdHi9MAt0BVghOwK10LNnSsjoCuTpIxA786xsEj
 wHwhrqHkC+L5qybaR7SYJEAmOqYkLJMqIrFn/S9EfHRf+PugNwM9aXLAYZtEkFYskp8y
 LgXnfgX3NU+ecHvQxKjtZxZpqtd5PUDkXc/DM0UbJNnVGm4Y16E5Rsc348NNJuGxYe6S
 yLPg==
X-Gm-Message-State: AOJu0YwbDb0LVCcGtICI94YQHEn7fioab4KgRkndrWWthLLNxn1P5r5a
 tKjlaFr3aqG5KcyddBvpvwG/6sTskDnD3P+Z0pGRxKH7kJVGUbCcry93iuXuVqyO2+YKX4zksY7
 jUGbMAELSDnlz3TkU8t2twWa7D3vq7ot2yncg7w==
X-Gm-Gg: ASbGnctyPaTVJN3vM4NQPggFW2QK9hAJywYfAavPWghjKvyU8fLvmOUMa3qKQozLdjx
 UFiybOXcWjQZ2arHknygO2bGFqDT6Yc+5DCibhy5BeU93YrOF/aW9AF/v3PcX9bBz99rwmSauD4
 8O+ALPrjbtRt2/2aLWfXsJZ4w/DbCsfSzKD5Ir
X-Google-Smtp-Source: AGHT+IF5V30Inu60CIc2sm4j4j8OIY3APXMpCIVdkPRmrN+S4MRV+Ri+ictyLk4+pwF97UPtIG900RxGkNNQ3s6afCU=
X-Received: by 2002:a05:6870:40ca:b0:2c1:c10e:3230 with SMTP id
 586e51a60fabf-2c780351832mr1367685fac.18.1742542160418; Fri, 21 Mar 2025
 00:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1742527956.git.yong.huang@smartx.com>
 <CAMxuvaxorJD=Vnyuh6-3Ezdt0_6o_py8XhJuo3Dwfxu+zEWJWA@mail.gmail.com>
In-Reply-To: <CAMxuvaxorJD=Vnyuh6-3Ezdt0_6o_py8XhJuo3Dwfxu+zEWJWA@mail.gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 21 Mar 2025 15:29:04 +0800
X-Gm-Features: AQ5f1JoAc4w2B-wWsNMwyPMmmCdaiTuKLPbIgD2MvXBCum_u0ZM-OpIadV58jnY
Message-ID: <CAK9dgmb2sD6faxFhkgB7Fq9HLu6dpSHW4sCmu9=HFmubmvemAw@mail.gmail.com>
Subject: Re: [RFC 0/3] Support live migration for qemu-vdagent chardev
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, dengpc12@chinatelecom.cn
Content-Type: multipart/alternative; boundary="0000000000007a75580630d536f4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000007a75580630d536f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 2:42=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Hi
>
> On Fri, Mar 21, 2025 at 7:40=E2=80=AFAM <yong.huang@smartx.com> wrote:
> >
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > Our goal is to migrate VMs that are configured with qemu-vdagent-typed
> > chardev while allowing the agent to continue working without having
> > to restart the service in guest.
> >
>
> I sent a more complete series last week: "[PATCH for-10.1 00/10]
> Support vdagent migration"
>
> https://patchew.org/QEMU/20250311155932.1472092-1-marcandre.lureau@redhat=
.com/


Thanks for your reminder, indeed, it migrates the qemu clipboard content
as well, more complete.

Thanks for the work, we'll pick your patchset and try it.


>
>
>
> > Let's justify which fields should be taken into account for struct
> > VDAgentChardev.
> >
> > struct VDAgentChardev {
> >     Chardev parent;
> >
> >     /* config */
> >     bool mouse;
> >     bool clipboard;
> >
> >     /* guest vdagent */
> >     uint32_t caps;
> >     VDIChunkHeader chunk;
> >     uint32_t chunksize;
> >     uint8_t *msgbuf;
> >     uint32_t msgsize;
> >     uint8_t *xbuf;
> >     uint32_t xoff, xsize;
> >     Buffer outbuf;
> >
> >     /* mouse */
> >     DeviceState mouse_dev;
> >     uint32_t mouse_x;
> >     uint32_t mouse_y;
> >     uint32_t mouse_btn;
> >     uint32_t mouse_display;
> >     QemuInputHandlerState *mouse_hs;
> >
> >     /* clipboard */
> >     QemuClipboardPeer cbpeer;
> >     uint32_t last_serial[QEMU_CLIPBOARD_SELECTION__COUNT];
> >     uint32_t cbpending[QEMU_CLIPBOARD_SELECTION__COUNT];
> > };
> >
> > parent:
> > No dynamic information is generated. skip migrating.
> >
> > mouse, clipboard:
> > The mouse and clipboard should be set up identically on both sides.
> > Skip migrating.
> >
> > caps:
> > Store the negotiated caps between the client and the guest.
> > Should migrate.
> >
> > chunk, ... outbuf:
> > The spice agent protocol's message transportation between the client
> > and the guest is implemented using all of these fields, however the
> > message loss can be tolerated by guests because the issue may occur
> > in the real world as well.
> > Could skip migrating.
>
> It's part of the host/guest state, data will be lost and it's likely
> the communication will break if it's not migrated.
>
> >
> > mouse_dev, ... mouse_hs:
> > The mouse state can be reset after a live migration since the agent
> > working inside the guest does not heavily depend on them.
> > Could skip migrating
>
> same
>
> > cbpeer:
> > Since the cbpeer would lose the data it references to if the qemu
> > clipboard data was not migrated, this field can also be initialized
> > after live migration.
> > Could skip migrating
> >
>
> We should migrate the clipboard content too, to avoid having to
> request it again, or have a noticeable effect.
>
> > last_serial, cbpending:
> > It is necessary for the agent to function after live migration.
> > Should migrate.
> >
> > For the last_serial, saving & loading its value to make ensure the
> > client receives the most recent clipboard data from the guest after
> > live migration.
> >
> > For the cbpending, saving & loading its value aims to inform the
> > guest that the clipboard has been released and is now empty in
> > case that the guest acts strangely while supposing that the
> > requested data can be properly retrieved.
> >
> > To summarize, all we need to do is migrate the caps, last_serial
> > and cbpendings fields of the struct VDAgentChardev,
> >
> > Please review, thanks
> >
> > Yong
> >
> > Hyman Huang (3):
> >   vdagent: Wrap vdagent_register_to_qemu_clipboard function
> >   vdagent: Set up mouse and clipboard after live migration
> >   vdagent: Drop blocker to support migration
> >
> >  ui/trace-events |   1 +
> >  ui/vdagent.c    | 102 +++++++++++++++++++++++++++++++++++++++---------
> >  2 files changed, 85 insertions(+), 18 deletions(-)
> >
> > --
> > 2.27.0
> >
>
>

--=20
Best regards

--0000000000007a75580630d536f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Fri, Mar 21, 2025 at 2:42=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;<a h=
ref=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-colo=
r:rgb(204,204,204);padding-left:1ex">Hi<br>
<br>
On Fri, Mar 21, 2025 at 7:40=E2=80=AFAM &lt;<a href=3D"mailto:yong.huang@sm=
artx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;<br>
&gt; Our goal is to migrate VMs that are configured with qemu-vdagent-typed=
<br>
&gt; chardev while allowing the agent to continue working without having<br=
>
&gt; to restart the service in guest.<br>
&gt;<br>
<br>
I sent a more complete series last week: &quot;[PATCH for-10.1 00/10]<br>
Support vdagent migration&quot;<br>
<a href=3D"https://patchew.org/QEMU/20250311155932.1472092-1-marcandre.lure=
au@redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QE=
MU/20250311155932.1472092-1-marcandre.lureau@redhat.com/</a></blockquote><d=
iv><br></div><div><span class=3D"gmail_default" style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif">Thanks for your reminder, indeed, it migrat=
es the qemu clipboard content</span></div><div><span class=3D"gmail_default=
" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">as well, more =
complete.</span></div><div><span class=3D"gmail_default" style=3D"font-fami=
ly:&quot;comic sans ms&quot;,sans-serif"><br></span></div><div><span class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">Thanks for the work, we&#39;ll pick your patchset and try it.</span></di=
v><div><span class=3D"gmail_default" style=3D"font-family:&quot;comic sans =
ms&quot;,sans-serif"><br></span></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;border-left-color:rgb(204,204,204);padding-left:1ex"><br>
<br>
<br>
<br>
&gt; Let&#39;s justify which fields should be taken into account for struct=
<br>
&gt; VDAgentChardev.<br>
&gt;<br>
&gt; struct VDAgentChardev {<br>
&gt;=C2=A0 =C2=A0 =C2=A0Chardev parent;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0/* config */<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool mouse;<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool clipboard;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0/* guest vdagent */<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t caps;<br>
&gt;=C2=A0 =C2=A0 =C2=A0VDIChunkHeader chunk;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t chunksize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint8_t *msgbuf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t msgsize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint8_t *xbuf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t xoff, xsize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Buffer outbuf;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0/* mouse */<br>
&gt;=C2=A0 =C2=A0 =C2=A0DeviceState mouse_dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t mouse_x;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t mouse_y;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t mouse_btn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t mouse_display;<br>
&gt;=C2=A0 =C2=A0 =C2=A0QemuInputHandlerState *mouse_hs;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0/* clipboard */<br>
&gt;=C2=A0 =C2=A0 =C2=A0QemuClipboardPeer cbpeer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t last_serial[QEMU_CLIPBOARD_SELECTION__COUN=
T];<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t cbpending[QEMU_CLIPBOARD_SELECTION__COUNT]=
;<br>
&gt; };<br>
&gt;<br>
&gt; parent:<br>
&gt; No dynamic information is generated. skip migrating.<br>
&gt;<br>
&gt; mouse, clipboard:<br>
&gt; The mouse and clipboard should be set up identically on both sides.<br=
>
&gt; Skip migrating.<br>
&gt;<br>
&gt; caps:<br>
&gt; Store the negotiated caps between the client and the guest.<br>
&gt; Should migrate.<br>
&gt;<br>
&gt; chunk, ... outbuf:<br>
&gt; The spice agent protocol&#39;s message transportation between the clie=
nt<br>
&gt; and the guest is implemented using all of these fields, however the<br=
>
&gt; message loss can be tolerated by guests because the issue may occur<br=
>
&gt; in the real world as well.<br>
&gt; Could skip migrating.<br>
<br>
It&#39;s part of the host/guest state, data will be lost and it&#39;s likel=
y<br>
the communication will break if it&#39;s not migrated.<br>
<br>
&gt;<br>
&gt; mouse_dev, ... mouse_hs:<br>
&gt; The mouse state can be reset after a live migration since the agent<br=
>
&gt; working inside the guest does not heavily depend on them.<br>
&gt; Could skip migrating<br>
<br>
same<br>
<br>
&gt; cbpeer:<br>
&gt; Since the cbpeer would lose the data it references to if the qemu<br>
&gt; clipboard data was not migrated, this field can also be initialized<br=
>
&gt; after live migration.<br>
&gt; Could skip migrating<br>
&gt;<br>
<br>
We should migrate the clipboard content too, to avoid having to<br>
request it again, or have a noticeable effect.<br>
<br>
&gt; last_serial, cbpending:<br>
&gt; It is necessary for the agent to function after live migration.<br>
&gt; Should migrate.<br>
&gt;<br>
&gt; For the last_serial, saving &amp; loading its value to make ensure the=
<br>
&gt; client receives the most recent clipboard data from the guest after<br=
>
&gt; live migration.<br>
&gt;<br>
&gt; For the cbpending, saving &amp; loading its value aims to inform the<b=
r>
&gt; guest that the clipboard has been released and is now empty in<br>
&gt; case that the guest acts strangely while supposing that the<br>
&gt; requested data can be properly retrieved.<br>
&gt;<br>
&gt; To summarize, all we need to do is migrate the caps, last_serial<br>
&gt; and cbpendings fields of the struct VDAgentChardev,<br>
&gt;<br>
&gt; Please review, thanks<br>
&gt;<br>
&gt; Yong<br>
&gt;<br>
&gt; Hyman Huang (3):<br>
&gt;=C2=A0 =C2=A0vdagent: Wrap vdagent_register_to_qemu_clipboard function<=
br>
&gt;=C2=A0 =C2=A0vdagent: Set up mouse and clipboard after live migration<b=
r>
&gt;=C2=A0 =C2=A0vdagent: Drop blocker to support migration<br>
&gt;<br>
&gt;=C2=A0 ui/trace-events |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 ui/vdagent.c=C2=A0 =C2=A0 | 102 ++++++++++++++++++++++++++++++++=
+++++++---------<br>
&gt;=C2=A0 2 files changed, 85 insertions(+), 18 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.27.0<br>
&gt;<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div></div>

--0000000000007a75580630d536f4--

