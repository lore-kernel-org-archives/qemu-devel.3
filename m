Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D97BC27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3Bc-0004YW-Fn; Fri, 14 Jun 2024 05:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sI3Ba-0004XO-VM
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:25:31 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sI3BY-0005g3-Hf
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:25:30 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-43fdbe0f072so10477961cf.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718357127; x=1718961927; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QYZ/dLvXfErN899MI8PBxz0bYbiHFAx7ShcZxbF8Q/w=;
 b=WFeK8G8r51HOfi3UorzitiayQr7Nf/+d0rU0oMcH9MVGJGSmBbBHaU3VxDIqFh+ul0
 +8aKX2Ime4NfE/xvkMkc38LpoSYDIyB/Y9Queh+kyflWSKhmz5fzrQ0oiWzLJyiyoCs+
 LlTzGxh3XV5e9lKhMUMKJ2Fag/c2OO2OmnJzv7q20UrISONpt7oNumx5TeeXakSSa9kX
 MGTfd98yXV9BndSKYD6d6lcp0TOzqr4mgrpaKftcdrMGjELe2NO80axvLlIWvbF0tjkw
 LR+WZCb8CqBXzQBogrGRQnYeh/kAKPORfkqtUtPg3tDp+w48/DCKpfLddxQgpUkLoYCz
 Uaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718357127; x=1718961927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QYZ/dLvXfErN899MI8PBxz0bYbiHFAx7ShcZxbF8Q/w=;
 b=U0PueHOXetNZ2unznwSN7fxMYlxz3oY5e/b+6ct3Sue1KahQ9V1caRAflzkpi/79Mm
 oTbqcgrQhiRXQxz22huwfhzaQwXwVK0tx1J97ZnUP6DuXetAW1P3HLKeouzIRMCSpfzA
 lNQW7EzG68P0N+C2uKlcVzXX3cUWKhZmaD9azLGkiO1PKhmCPBDjbVxAog54R+rZdirn
 bWHywugmGqZVGp2c37bPmWlDi3NW3XHnt3by62xM6VC5M61UltxeFv3w+eZWewWjVNbE
 1rApd8nPECdirc9J774jZQhasrCyvP+UEQZGT+7lEKreJFIxflyiu4ao2jD59KBsDVs5
 iB+w==
X-Gm-Message-State: AOJu0YxhZBp/wFAD5HE5SOkakhHSzeY5Irh8JtCZG/vJ3ySc/wKVQKag
 lah9YzqWY8mZz8bZztK5Fkt4TYENVebjobm1cHDqIvUE3iEbFUQVaOfzB4J1J1f+pFveH/wZ3c7
 DJOhiOYP2fAtZw8aSModiZAKsR9ckLxI7
X-Google-Smtp-Source: AGHT+IFIMK5Dg9w/gtpcEVc82CGECID7aCJPD0JDb8EutAuurlOlmi43uNh+8+ATM8e8F3XgwEZa2c6F0tkK+s70FPU=
X-Received: by 2002:ac8:5d4b:0:b0:441:56b5:9c8e with SMTP id
 d75a77b69052e-442168ada7dmr21994881cf.30.1718357127204; Fri, 14 Jun 2024
 02:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240529224252.80395-1-dongwon.kim@intel.com>
 <CAJ+F1CJFWRtyXvpCJuSVPssJcBx8ecP1HCkWCJ=HBWxXovj+Dw@mail.gmail.com>
 <ed6a1963-b079-4fdc-a6ca-6ba98b95c0de@intel.com>
 <CAJ+F1CJW3b9D4nU3x4XSjpG=KrBpJMLWqdR3tpdipObODZRvgQ@mail.gmail.com>
 <PH8PR11MB68796CDE59AA75FD1D6089A1FAC02@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAJ+F1C+L=5cSPhEXrAczfN27sXEH_2Xwohk7Bt2r4KmhteDguQ@mail.gmail.com>
 <d1534c51-bb11-4439-afc9-0a95f2dc4cf5@intel.com>
 <CAJ+F1C+kYEHrCGKcwxyGiaiHhRyN7+uKvEj4yWBDxEK2nKUOdA@mail.gmail.com>
 <200c1b14-0439-484e-8681-d525a73929bb@intel.com>
In-Reply-To: <200c1b14-0439-484e-8681-d525a73929bb@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 14 Jun 2024 13:25:14 +0400
Message-ID: <CAJ+F1CJdL20CMLx2w4BA0xxWh9Pq_2+4puXSxN8BECs-wyROTQ@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Wait until the current guest frame is rendered
 before switching to RUN_STATE_SAVE_VM
To: "Kim, Dongwon" <dongwon.kim@intel.com>, Peter Xu <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000002a19da061ad63218"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
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

--0000000000002a19da061ad63218
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 13, 2024 at 9:27=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.com=
> wrote:

> Hi Marc-Andr=C3=A9,
>
> On 6/13/2024 6:16 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Jun 12, 2024 at 10:50=E2=80=AFPM Kim, Dongwon <dongwon.kim@inte=
l.com
> > <mailto:dongwon.kim@intel.com>> wrote:
> >
> >     On 6/11/2024 10:44 PM, Marc-Andr=C3=A9 Lureau wrote:
> >      > Hi
> >      >
> >      > On Wed, Jun 12, 2024 at 5:29=E2=80=AFAM Kim, Dongwon
> >     <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>
> >      > <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>>
> wrote:
> >      >
> >      >     Hi,
> >      >
> >      >     From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com
> >     <mailto:marcandre.lureau@gmail.com>
> >      >     <mailto:marcandre.lureau@gmail.com
> >     <mailto:marcandre.lureau@gmail.com>>>
> >      >     Sent: Wednesday, June 5, 2024 12:56 AM
> >      >     To: Kim, Dongwon <dongwon.kim@intel.com
> >     <mailto:dongwon.kim@intel.com> <mailto:dongwon.kim@intel.com
> >     <mailto:dongwon.kim@intel.com>>>
> >      >     Cc: qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>
> >     <mailto:qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>>;
> Peter Xu
> >      >     <peterx@redhat.com <mailto:peterx@redhat.com>
> >     <mailto:peterx@redhat.com <mailto:peterx@redhat.com>>>
> >      >     Subject: Re: [PATCH] ui/gtk: Wait until the current guest
> >     frame is
> >      >     rendered before switching to RUN_STATE_SAVE_VM
> >      >
> >      >     Hi
> >      >
> >      >     On Tue, Jun 4, 2024 at 9:49=E2=80=AFPM Kim, Dongwon
> >      >     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>
> >     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>>
> wrote:
> >      >     On 6/4/2024 4:12 AM, Marc-Andr=C3=A9 Lureau wrote:
> >      >      > Hi
> >      >      >
> >      >      > On Thu, May 30, 2024 at 2:44=E2=80=AFAM
> >     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>
> >      >     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>=
>
> >      >      > <mailto:mailto <mailto:mailto> <mailto:mailto
> >     <mailto:mailto>>:dongwon.kim@intel.com <mailto:dongwon.kim@intel.co=
m
> >
> >      >     <mailto:dongwon.kim@intel.com
> >     <mailto:dongwon.kim@intel.com>>>> wrote:
> >      >      >
> >      >      >     From: Dongwon <mailto:dongwon.kim@intel.com
> >     <mailto:dongwon.kim@intel.com>
> >      >     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>=
>
> >     <mailto:mailto <mailto:mailto>
> >      >     <mailto:mailto <mailto:mailto>>:dongwon.kim@intel.com
> >     <mailto:dongwon.kim@intel.com> <mailto:dongwon.kim@intel.com
> >     <mailto:dongwon.kim@intel.com>>>>
> >      >      >
> >      >      >     Make sure rendering of the current frame is finished
> >     before
> >      >     switching
> >      >      >     the run state to RUN_STATE_SAVE_VM by waiting for
> egl-sync
> >      >     object to be
> >      >      >     signaled.
> >      >      >
> >      >      >
> >      >      > Can you expand on what this solves?
> >      >
> >      >     In current scheme, guest waits for the fence to be signaled
> >     for each
> >      >     frame it submits before moving to the next frame. If the
> >     guest=E2=80=99s state
> >      >     is saved while it is still waiting for the fence, The guest
> will
> >      >     continue to  wait for the fence that was signaled while ago
> >     when it is
> >      >     restored to the point. One way to prevent it is to get it
> >     finish the
> >      >     current frame before changing the state.
> >      >
> >      >     After the UI sets a fence, hw_ops->gl_block(true) gets
> >     called, which
> >      >     will block virtio-gpu/virgl from processing commands (until
> the
> >      >     fence is signaled and gl_block/false called again).
> >      >
> >      >     But this "blocking" state is not saved. So how does this
> affect
> >      >     save/restore? Please give more details, thanks
> >      >
> >      >     Yeah sure. "Blocking" state is not saved but guest's state i=
s
> >     saved
> >      >     while it was still waiting for the response for its last
> >      >     resource-flush virtio msg. This virtio response, by the way
> >     is set
> >      >     to be sent to the guest when the pipeline is unblocked (and
> >     when the
> >      >     fence is signaled.). Once the guest's state is saved, curren=
t
> >      >     instance of guest will be continued and receives the respons=
e
> as
> >      >     usual. The problem is happening when we restore the saved
> guest's
> >      >     state again because what guest does will be waiting for the
> >     response
> >      >     that was sent a while ago to the original instance.
> >      >
> >      >
> >      > Where is the pending response saved? Can you detail how you test
> >     this?
> >      >
> >
> >     There is no pending response for the guest's restored point, which
> is a
> >     problem. The response is sent out after saving is done.
> >
> >     Normal cycle :
> >
> >     resource-flush (scanout flush) -> gl block -> render -> gl unblock
> >     (after fence is signaled) -> pending response sent out to the guest
> ->
> >     guest (virtio-gpu drv) processes the next scanout frame -> (next
> cycle)
> >     resource-flush -> gl block ......
> >
> >     When vm state is saved in the middle :
> >
> >     resource-flush (scanout-flush) -> gl block -> saving vm-state ->
> render
> >     -> gl unblock -> pending response (resp #1) sent out to the guest -=
>
> >     guest (virtio-gpu drv) processes the next scanout frame -> (next
> cycle)
> >     resource-flush -> gl block ......
> >
> >     Now, we restore the vm-state we saved
> >
> >     vm-state is restored -> guest (virtio-gpu drv) can't move on as thi=
s
> >     state is still waiting for the response (resp #1)
> >
> >
> > Ok, so actually it's more of a device state issue than a UI/GTK. We end
> > up not saving a state that reflects the guest state. My understanding i=
s
> > that the guest is waiting for a fence reply, and we don't save that.
> > Imho, a better fix would be to either save the fenceq (but then, what
> > else is missing to complete the operation on resume?), or have a wait t=
o
> > delay the migration until the fences are flushed.
>
> The second method you are proposing here - 'have a wait'. I understand
> you mean delaying the start point of migration but don't you think the
> current patch is basically doing the similar thing? Assuming egl wait
> sync is what we need to use for a wait, do you have any suggestion where
> that should be called other than 'gd_change_runstate'?
>

It should be handled at virtio-gpu side. I am not sure if runstate handler
or pre_save are the right place.

Peter, what is the correct way to delay migration until the host finishes
some work? (in this case we would need to wait for the rendering/UI, to
signal pending fences)

thanks

--=20
Marc-Andr=C3=A9 Lureau

--0000000000002a19da061ad63218
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 9:27=E2=80=
=AFPM Kim, Dongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim=
@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Marc-Andr=C3=A9,<br>
<br>
On 6/13/2024 6:16 AM, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Wed, Jun 12, 2024 at 10:50=E2=80=AFPM Kim, Dongwon &lt;<a href=3D"m=
ailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> <b=
r>
&gt; &lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">=
dongwon.kim@intel.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 6/11/2024 10:44 PM, Marc-Andr=C3=A9 Lureau wrote=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Wed, Jun 12, 2024 at 5:29=E2=80=AFAM Kim, =
Dongwon<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:dongwon.kim@intel.com" target=
=3D"_blank">dongwon.kim@intel.com</a> &lt;mailto:<a href=3D"mailto:dongwon.=
kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:dongwon.kim@inte=
l.com" target=3D"_blank">dongwon.kim@intel.com</a> &lt;mailto:<a href=3D"ma=
ilto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt;=
&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0From: Marc-Andr=C3=A9 Lure=
au &lt;<a href=3D"mailto:marcandre.lureau@gmail.com" target=3D"_blank">marc=
andre.lureau@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:marcandre.lureau@gmail=
.com" target=3D"_blank">marcandre.lureau@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:marcandre.lureau@gmail.com" target=3D"_blank">marcandre.lureau@gmail.com=
</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:marcandre.lureau@gmail=
.com" target=3D"_blank">marcandre.lureau@gmail.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Sent: Wednesday, June 5, 2=
024 12:56 AM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0To: Kim, Dongwon &lt;<a hr=
ef=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com=
</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a>&gt; &lt;mailto:<a href=3D"mail=
to:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Cc: <a href=3D"mailto:qemu=
-devel@nongnu.org" target=3D"_blank">qemu-devel@nongnu.org</a> &lt;mailto:<=
a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongnu=
.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:qemu-devel@nongnu.org"=
 target=3D"_blank">qemu-devel@nongnu.org</a> &lt;mailto:<a href=3D"mailto:q=
emu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongnu.org</a>&gt;&gt;; =
Peter Xu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:pete=
rx@redhat.com" target=3D"_blank">peterx@redhat.com</a> &lt;mailto:<a href=
=3D"mailto:peterx@redhat.com" target=3D"_blank">peterx@redhat.com</a>&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:peterx@redhat.com" tar=
get=3D"_blank">peterx@redhat.com</a> &lt;mailto:<a href=3D"mailto:peterx@re=
dhat.com" target=3D"_blank">peterx@redhat.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Subject: Re: [PATCH] ui/gt=
k: Wait until the current guest<br>
&gt;=C2=A0 =C2=A0 =C2=A0frame is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0rendered before switching =
to RUN_STATE_SAVE_VM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Hi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On Tue, Jun 4, 2024 at 9:4=
9=E2=80=AFPM Kim, Dongwon<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> &lt;m=
ailto:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.ki=
m@intel.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a> &lt;mailto:<a href=3D"mailto:d=
ongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt;&gt;&g=
t; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On 6/4/2024 4:12 AM, Marc-=
Andr=C3=A9 Lureau wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Thu, May 30, 2024=
 at 2:44=E2=80=AFAM<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a> &lt;mailto:<a href=3D"mailto:d=
ongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> &lt;m=
ailto:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.ki=
m@intel.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=
=3D"mailto:mailto" target=3D"_blank">mailto</a> &lt;mailto:<a href=3D"mailt=
o:mailto" target=3D"_blank">mailto</a>&gt; &lt;mailto:<a href=3D"mailto:mai=
lto" target=3D"_blank">mailto</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mailto" target=3D"_bla=
nk">mailto</a>&gt;&gt;:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_=
blank">dongwon.kim@intel.com</a> &lt;mailto:<a href=3D"mailto:dongwon.kim@i=
ntel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a>&gt;&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0F=
rom: Dongwon &lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"=
_blank">dongwon.kim@intel.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> &lt;m=
ailto:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.ki=
m@intel.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mailto" target=3D"_bla=
nk">mailto</a> &lt;mailto:<a href=3D"mailto:mailto" target=3D"_blank">mailt=
o</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:mailto" target=3D"_blank">mailto</a> &lt;mailto:<a href=3D"mailto:mailto=
" target=3D"_blank">mailto</a>&gt;&gt;:<a href=3D"mailto:dongwon.kim@intel.=
com" target=3D"_blank">dongwon.kim@intel.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a>&gt; &lt;mailto:<a href=3D"mail=
to:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a>&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0M=
ake sure rendering of the current frame is finished<br>
&gt;=C2=A0 =C2=A0 =C2=A0before<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0switching<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0t=
he run state to RUN_STATE_SAVE_VM by waiting for egl-sync<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0object to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0s=
ignaled.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Can you expand on wh=
at this solves?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0In current scheme, guest w=
aits for the fence to be signaled<br>
&gt;=C2=A0 =C2=A0 =C2=A0for each<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0frame it submits before mo=
ving to the next frame. If the<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest=E2=80=99s state<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0is saved while it is still=
 waiting for the fence, The guest will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0continue to=C2=A0 wait for=
 the fence that was signaled while ago<br>
&gt;=C2=A0 =C2=A0 =C2=A0when it is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0restored to the point. One=
 way to prevent it is to get it<br>
&gt;=C2=A0 =C2=A0 =C2=A0finish the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0current frame before chang=
ing the state.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0After the UI sets a fence,=
 hw_ops-&gt;gl_block(true) gets<br>
&gt;=C2=A0 =C2=A0 =C2=A0called, which<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0will block virtio-gpu/virg=
l from processing commands (until the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0fence is signaled and gl_b=
lock/false called again).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0But this &quot;blocking&qu=
ot; state is not saved. So how does this affect<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0save/restore? Please give =
more details, thanks<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Yeah sure. &quot;Blocking&=
quot; state is not saved but guest&#39;s state is<br>
&gt;=C2=A0 =C2=A0 =C2=A0saved<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0while it was still waiting=
 for the response for its last<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0resource-flush virtio msg.=
 This virtio response, by the way<br>
&gt;=C2=A0 =C2=A0 =C2=A0is set<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0to be sent to the guest wh=
en the pipeline is unblocked (and<br>
&gt;=C2=A0 =C2=A0 =C2=A0when the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0fence is signaled.). Once =
the guest&#39;s state is saved, current<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0instance of guest will be =
continued and receives the response as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0usual. The problem is happ=
ening when we restore the saved guest&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0state again because what g=
uest does will be waiting for the<br>
&gt;=C2=A0 =C2=A0 =C2=A0response<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0that was sent a while ago =
to the original instance.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Where is the pending response saved? Can you =
detail how you test<br>
&gt;=C2=A0 =C2=A0 =C2=A0this?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0There is no pending response for the guest&#39;s re=
stored point, which is a<br>
&gt;=C2=A0 =C2=A0 =C2=A0problem. The response is sent out after saving is d=
one.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Normal cycle :<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0resource-flush (scanout flush) -&gt; gl block -&gt;=
 render -&gt; gl unblock<br>
&gt;=C2=A0 =C2=A0 =C2=A0(after fence is signaled) -&gt; pending response se=
nt out to the guest -&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest (virtio-gpu drv) processes the next scanout f=
rame -&gt; (next cycle)<br>
&gt;=C2=A0 =C2=A0 =C2=A0resource-flush -&gt; gl block ......<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0When vm state is saved in the middle :<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0resource-flush (scanout-flush) -&gt; gl block -&gt;=
 saving vm-state -&gt; render<br>
&gt;=C2=A0 =C2=A0 =C2=A0-&gt; gl unblock -&gt; pending response (resp #1) s=
ent out to the guest -&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest (virtio-gpu drv) processes the next scanout f=
rame -&gt; (next cycle)<br>
&gt;=C2=A0 =C2=A0 =C2=A0resource-flush -&gt; gl block ......<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Now, we restore the vm-state we saved<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0vm-state is restored -&gt; guest (virtio-gpu drv) c=
an&#39;t move on as this<br>
&gt;=C2=A0 =C2=A0 =C2=A0state is still waiting for the response (resp #1)<b=
r>
&gt; <br>
&gt; <br>
&gt; Ok, so actually it&#39;s more of a device state issue than a UI/GTK. W=
e end <br>
&gt; up not saving a state that reflects the guest state. My understanding =
is <br>
&gt; that the guest is waiting for a fence reply, and we don&#39;t save tha=
t. <br>
&gt; Imho, a better fix would be to either save the fenceq (but then, what =
<br>
&gt; else is missing to complete the operation on resume?), or have a wait =
to <br>
&gt; delay the migration until the fences are flushed.<br>
<br>
The second method you are proposing here - &#39;have a wait&#39;. I underst=
and <br>
you mean delaying the start point of migration but don&#39;t you think the =
<br>
current patch is basically doing the similar thing? Assuming egl wait <br>
sync is what we need to use for a wait, do you have any suggestion where <b=
r>
that should be called other than &#39;gd_change_runstate&#39;?<br></blockqu=
ote><div><br></div><div>It should be handled at virtio-gpu side. I am not s=
ure if runstate handler or pre_save are the right place.<br></div><div><br>=
</div><div>Peter, what is the correct way to delay migration until the host=
 finishes some work? (in this case we would need to wait for the rendering/=
UI, to signal pending fences)<br></div></div><div><br></div><div>thanks</di=
v><div><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div =
dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div=
>

--0000000000002a19da061ad63218--

