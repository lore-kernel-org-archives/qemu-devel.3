Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B675C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 13:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHkJu-0000zF-TH; Thu, 13 Jun 2024 09:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sHkJt-0000xI-8o
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 09:16:49 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sHkJr-0007T1-1x
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 09:16:49 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6ae093e8007so2627846d6.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718284606; x=1718889406; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gs4uQdtqFlxYzu/Itfn5LPo8ZtT6N9QCr1Lolb7Yi78=;
 b=QGffnnOuhzAoRM/iY2hHrMY3/WbtTLVAwaHi2mnW8ObbThJ/1bSTaXlLTRBk6yRpKL
 Q9v2r2C5kNrX0ArZXmkkvp+ZQP+Ncb1D38Az+0r1BvQgyUahiZ8gKkOkjoq5ccAetTer
 pg7UhXTjeuBrwVn4yOcHpj0Ehe/l/aL2Y2Z5roVa8mJIwDsKqd5+dFjOw6Z1uyDWVbnh
 eYnv4TOrvLb73H/PVwBPur+mOSlkBL515OB0SS+XUSK+JmzcqG2b0FYPvCubb9tRfm6f
 RWNy6ml73aAHSgJFu1LIVGvTkX3nOU7wQmHP/bWFMXSQ8kayZDpE7kSXkQrrl/8tVDV7
 xemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718284606; x=1718889406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gs4uQdtqFlxYzu/Itfn5LPo8ZtT6N9QCr1Lolb7Yi78=;
 b=GUTk0RuEe2LsgcdANOw8eAvk7qkhE8yzu2RGSl/ewQi+phJpgAlXVqoRk/UZZ2AVMV
 LIXSMvGKaWhqAf2f3nxfcyX3Sln2DBiq6zQfU4YWTw8Xdk6OdrwIoKRT+Qk9TQ1QMSkD
 YGgkFMT8W0QUJoWQgkxp3o3ev7ODs24RnKjxoaYlXpH0DxzSC/PdzmdY37XSg1mCNOJ9
 phkxf5VhxNjtvAzOAKH/0bHKcsDwGBBuhYOM0MpTDyQ7/IDkGIF7RAYeZ8uaV6s3lGvx
 GAWtNfiNo7O/YPHibpvX+0w5EBrtVlX66kD7Z9v7c0hV12zdDCx06hi3jxZCaO2GsrLZ
 FYRA==
X-Gm-Message-State: AOJu0YwZvQtEipvM6wYmj91xuW0zwRumXQ0jcEyX0si/2xWnYYT7IMhb
 SXDwYdC7xVc09wDvCKMOYDpbqg/mLVmKM4kZdqlTlswpYfjFfGXfymS+yIcIBKZuxc/5S69DvoH
 4OzBblyWhlHCw4AYQKmuodnNyA8geNfp1
X-Google-Smtp-Source: AGHT+IElO1ALCKWlxiPeFFMZLlOZdt60P+P9ysYeQp9MXu3umqSzXvm0c113K8TnDP43ZjopKOytQc9Lx95biCN0t+E=
X-Received: by 2002:a05:6214:448b:b0:6b0:732f:b92b with SMTP id
 6a1803df08f44-6b1910c226amr52142676d6.12.1718284605664; Thu, 13 Jun 2024
 06:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240529224252.80395-1-dongwon.kim@intel.com>
 <CAJ+F1CJFWRtyXvpCJuSVPssJcBx8ecP1HCkWCJ=HBWxXovj+Dw@mail.gmail.com>
 <ed6a1963-b079-4fdc-a6ca-6ba98b95c0de@intel.com>
 <CAJ+F1CJW3b9D4nU3x4XSjpG=KrBpJMLWqdR3tpdipObODZRvgQ@mail.gmail.com>
 <PH8PR11MB68796CDE59AA75FD1D6089A1FAC02@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAJ+F1C+L=5cSPhEXrAczfN27sXEH_2Xwohk7Bt2r4KmhteDguQ@mail.gmail.com>
 <d1534c51-bb11-4439-afc9-0a95f2dc4cf5@intel.com>
In-Reply-To: <d1534c51-bb11-4439-afc9-0a95f2dc4cf5@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 13 Jun 2024 17:16:33 +0400
Message-ID: <CAJ+F1C+kYEHrCGKcwxyGiaiHhRyN7+uKvEj4yWBDxEK2nKUOdA@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Wait until the current guest frame is rendered
 before switching to RUN_STATE_SAVE_VM
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008b363f061ac54f6a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2a.google.com
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

--0000000000008b363f061ac54f6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 12, 2024 at 10:50=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.co=
m> wrote:

> On 6/11/2024 10:44 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Jun 12, 2024 at 5:29=E2=80=AFAM Kim, Dongwon <dongwon.kim@intel=
.com
> > <mailto:dongwon.kim@intel.com>> wrote:
> >
> >     Hi,
> >
> >     From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com
> >     <mailto:marcandre.lureau@gmail.com>>
> >     Sent: Wednesday, June 5, 2024 12:56 AM
> >     To: Kim, Dongwon <dongwon.kim@intel.com <mailto:
> dongwon.kim@intel.com>>
> >     Cc: qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>; Peter Xu
> >     <peterx@redhat.com <mailto:peterx@redhat.com>>
> >     Subject: Re: [PATCH] ui/gtk: Wait until the current guest frame is
> >     rendered before switching to RUN_STATE_SAVE_VM
> >
> >     Hi
> >
> >     On Tue, Jun 4, 2024 at 9:49=E2=80=AFPM Kim, Dongwon
> >     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>> wrote=
:
> >     On 6/4/2024 4:12 AM, Marc-Andr=C3=A9 Lureau wrote:
> >      > Hi
> >      >
> >      > On Thu, May 30, 2024 at 2:44=E2=80=AFAM <mailto:dongwon.kim@inte=
l.com
> >     <mailto:dongwon.kim@intel.com>
> >      > <mailto:mailto <mailto:mailto>:dongwon.kim@intel.com
> >     <mailto:dongwon.kim@intel.com>>> wrote:
> >      >
> >      >     From: Dongwon <mailto:dongwon.kim@intel.com
> >     <mailto:dongwon.kim@intel.com> <mailto:mailto
> >     <mailto:mailto>:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com
> >>>
> >      >
> >      >     Make sure rendering of the current frame is finished before
> >     switching
> >      >     the run state to RUN_STATE_SAVE_VM by waiting for egl-sync
> >     object to be
> >      >     signaled.
> >      >
> >      >
> >      > Can you expand on what this solves?
> >
> >     In current scheme, guest waits for the fence to be signaled for eac=
h
> >     frame it submits before moving to the next frame. If the guest=E2=
=80=99s
> state
> >     is saved while it is still waiting for the fence, The guest will
> >     continue to  wait for the fence that was signaled while ago when it
> is
> >     restored to the point. One way to prevent it is to get it finish th=
e
> >     current frame before changing the state.
> >
> >     After the UI sets a fence, hw_ops->gl_block(true) gets called, whic=
h
> >     will block virtio-gpu/virgl from processing commands (until the
> >     fence is signaled and gl_block/false called again).
> >
> >     But this "blocking" state is not saved. So how does this affect
> >     save/restore? Please give more details, thanks
> >
> >     Yeah sure. "Blocking" state is not saved but guest's state is saved
> >     while it was still waiting for the response for its last
> >     resource-flush virtio msg. This virtio response, by the way is set
> >     to be sent to the guest when the pipeline is unblocked (and when th=
e
> >     fence is signaled.). Once the guest's state is saved, current
> >     instance of guest will be continued and receives the response as
> >     usual. The problem is happening when we restore the saved guest's
> >     state again because what guest does will be waiting for the respons=
e
> >     that was sent a while ago to the original instance.
> >
> >
> > Where is the pending response saved? Can you detail how you test this?
> >
>
> There is no pending response for the guest's restored point, which is a
> problem. The response is sent out after saving is done.
>
> Normal cycle :
>
> resource-flush (scanout flush) -> gl block -> render -> gl unblock
> (after fence is signaled) -> pending response sent out to the guest ->
> guest (virtio-gpu drv) processes the next scanout frame -> (next cycle)
> resource-flush -> gl block ......
>
> When vm state is saved in the middle :
>
> resource-flush (scanout-flush) -> gl block -> saving vm-state -> render
> -> gl unblock -> pending response (resp #1) sent out to the guest ->
> guest (virtio-gpu drv) processes the next scanout frame -> (next cycle)
> resource-flush -> gl block ......
>
> Now, we restore the vm-state we saved
>
> vm-state is restored -> guest (virtio-gpu drv) can't move on as this
> state is still waiting for the response (resp #1)
>

Ok, so actually it's more of a device state issue than a UI/GTK. We end up
not saving a state that reflects the guest state. My understanding is that
the guest is waiting for a fence reply, and we don't save that. Imho, a
better fix would be to either save the fenceq (but then, what else is
missing to complete the operation on resume?), or have a wait to delay the
migration until the fences are flushed.


> So we need to make sure vm-state is saved after the cycle is completed.
>
> This situation would be only happening if you use blob=3Dtrue with
> virtio-gpu drv as KMS on the linux guest. Do you have any similar setup?
>
>
No, further details to reproduce would help. Even better would be having
some automated test.


--=20
Marc-Andr=C3=A9 Lureau

--0000000000008b363f061ac54f6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 12, 2024 at 10:50=E2=80=
=AFPM Kim, Dongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim=
@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 6/11/2024 10:44 PM, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Wed, Jun 12, 2024 at 5:29=E2=80=AFAM Kim, Dongwon &lt;<a href=3D"ma=
ilto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> <br=
>
&gt; &lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">=
dongwon.kim@intel.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:=
marcandre.lureau@gmail.com" target=3D"_blank">marcandre.lureau@gmail.com</a=
><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:marcandre.lureau@gmail=
.com" target=3D"_blank">marcandre.lureau@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Sent: Wednesday, June 5, 2024 12:56 AM<br>
&gt;=C2=A0 =C2=A0 =C2=A0To: Kim, Dongwon &lt;<a href=3D"mailto:dongwon.kim@=
intel.com" target=3D"_blank">dongwon.kim@intel.com</a> &lt;mailto:<a href=
=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</=
a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=
=3D"_blank">qemu-devel@nongnu.org</a> &lt;mailto:<a href=3D"mailto:qemu-dev=
el@nongnu.org" target=3D"_blank">qemu-devel@nongnu.org</a>&gt;; Peter Xu<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:peterx@redhat.com" target=3D"=
_blank">peterx@redhat.com</a> &lt;mailto:<a href=3D"mailto:peterx@redhat.co=
m" target=3D"_blank">peterx@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Subject: Re: [PATCH] ui/gtk: Wait until the current=
 guest frame is<br>
&gt;=C2=A0 =C2=A0 =C2=A0rendered before switching to RUN_STATE_SAVE_VM<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Jun 4, 2024 at 9:49=E2=80=AFPM Kim, Dongwon=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a> &lt;mailto:<a href=3D"mailto:d=
ongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt;&gt; w=
rote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 6/4/2024 4:12 AM, Marc-Andr=C3=A9 Lureau wrote:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Thu, May 30, 2024 at 2:44=E2=80=AFAM &lt;m=
ailto:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.ki=
m@intel.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:mailto" target=
=3D"_blank">mailto</a> &lt;mailto:<a href=3D"mailto:mailto" target=3D"_blan=
k">mailto</a>&gt;:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank=
">dongwon.kim@intel.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a>&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0From: Dongwon &lt;mailto:<=
a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel=
.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a>&gt; &lt;mailto:<a href=3D"mail=
to:mailto" target=3D"_blank">mailto</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mailto" target=3D"_bla=
nk">mailto</a>&gt;:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blan=
k">dongwon.kim@intel.com</a> &lt;mailto:<a href=3D"mailto:dongwon.kim@intel=
.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Make sure rendering of the=
 current frame is finished before<br>
&gt;=C2=A0 =C2=A0 =C2=A0switching<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0the run state to RUN_STATE=
_SAVE_VM by waiting for egl-sync<br>
&gt;=C2=A0 =C2=A0 =C2=A0object to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0signaled.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Can you expand on what this solves?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0In current scheme, guest waits for the fence to be =
signaled for each<br>
&gt;=C2=A0 =C2=A0 =C2=A0frame it submits before moving to the next frame. I=
f the guest=E2=80=99s state<br>
&gt;=C2=A0 =C2=A0 =C2=A0is saved while it is still waiting for the fence, T=
he guest will<br>
&gt;=C2=A0 =C2=A0 =C2=A0continue to=C2=A0 wait for the fence that was signa=
led while ago when it is<br>
&gt;=C2=A0 =C2=A0 =C2=A0restored to the point. One way to prevent it is to =
get it finish the<br>
&gt;=C2=A0 =C2=A0 =C2=A0current frame before changing the state.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0After the UI sets a fence, hw_ops-&gt;gl_block(true=
) gets called, which<br>
&gt;=C2=A0 =C2=A0 =C2=A0will block virtio-gpu/virgl from processing command=
s (until the<br>
&gt;=C2=A0 =C2=A0 =C2=A0fence is signaled and gl_block/false called again).=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0But this &quot;blocking&quot; state is not saved. S=
o how does this affect<br>
&gt;=C2=A0 =C2=A0 =C2=A0save/restore? Please give more details, thanks<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Yeah sure. &quot;Blocking&quot; state is not saved =
but guest&#39;s state is saved<br>
&gt;=C2=A0 =C2=A0 =C2=A0while it was still waiting for the response for its=
 last<br>
&gt;=C2=A0 =C2=A0 =C2=A0resource-flush virtio msg. This virtio response, by=
 the way is set<br>
&gt;=C2=A0 =C2=A0 =C2=A0to be sent to the guest when the pipeline is unbloc=
ked (and when the<br>
&gt;=C2=A0 =C2=A0 =C2=A0fence is signaled.). Once the guest&#39;s state is =
saved, current<br>
&gt;=C2=A0 =C2=A0 =C2=A0instance of guest will be continued and receives th=
e response as<br>
&gt;=C2=A0 =C2=A0 =C2=A0usual. The problem is happening when we restore the=
 saved guest&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0state again because what guest does will be waiting=
 for the response<br>
&gt;=C2=A0 =C2=A0 =C2=A0that was sent a while ago to the original instance.=
<br>
&gt; <br>
&gt; <br>
&gt; Where is the pending response saved? Can you detail how you test this?=
<br>
&gt; <br>
<br>
There is no pending response for the guest&#39;s restored point, which is a=
 <br>
problem. The response is sent out after saving is done.<br>
<br>
Normal cycle :<br>
<br>
resource-flush (scanout flush) -&gt; gl block -&gt; render -&gt; gl unblock=
 <br>
(after fence is signaled) -&gt; pending response sent out to the guest -&gt=
; <br>
guest (virtio-gpu drv) processes the next scanout frame -&gt; (next cycle) =
<br>
resource-flush -&gt; gl block ......<br>
<br>
When vm state is saved in the middle :<br>
<br>
resource-flush (scanout-flush) -&gt; gl block -&gt; saving vm-state -&gt; r=
ender <br>
-&gt; gl unblock -&gt; pending response (resp #1) sent out to the guest -&g=
t; <br>
guest (virtio-gpu drv) processes the next scanout frame -&gt; (next cycle) =
<br>
resource-flush -&gt; gl block ......<br>
<br>
Now, we restore the vm-state we saved<br>
<br>
vm-state is restored -&gt; guest (virtio-gpu drv) can&#39;t move on as this=
 <br>
state is still waiting for the response (resp #1)<br></blockquote><div><br>=
</div><div>Ok, so actually it&#39;s more of a device state issue than a UI/=
GTK. We end up not saving a state that reflects the guest state. My underst=
anding is that the guest is waiting for a fence reply, and we don&#39;t sav=
e that. Imho, a better fix would be to either save the fenceq (but then, wh=
at else is missing to complete the operation on resume?), or have a wait to=
 delay the migration until the fences are flushed.<br></div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
So we need to make sure vm-state is saved after the cycle is completed.<br>
<br>
This situation would be only happening if you use blob=3Dtrue with <br>
virtio-gpu drv as KMS on the linux guest. Do you have any similar setup?<br=
>
<br></blockquote><div><br></div><div>No, further details to reproduce would=
 help. Even better would be having some automated test. <br></div></div><br=
 clear=3D"all"><br><span class=3D"gmail_signature_prefix">-- </span><br><di=
v dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></d=
iv>

--0000000000008b363f061ac54f6a--

