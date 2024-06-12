Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76354C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 05:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHGmS-0002Eq-TF; Wed, 12 Jun 2024 01:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sHGmQ-0002EO-SN
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 01:44:18 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sHGmO-0004vt-HP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 01:44:18 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-44051a92f37so5524171cf.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 22:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718171054; x=1718775854; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jsc9zoEQ8hO5ey3ZY0D1UQ1aGkr7iTnFI4s55DtTZJs=;
 b=QV/hKDVuV82hi9LbWfBUgTcxqlrIadNuXI65WkM1MkUVI2B1aDww/aUrLWcEX+v9ZC
 z3yuM+vAD1PJWD22VXL7d2xN6EFgUgNwFm4qEhB9SZI0lZv0fxQc1e27pxKFXE4wd26h
 9qNO7pEYa4lR8jYN8aIVm9BhUpEiQn8ue0cp+jtR6WPE6lLQwOw7tRuahKmWipQRoRYz
 Ml+3Zp4bCBisbejxH1QasUaVyjmJloV4/HOFKYQua6jBv2e5C27ynb+l9kp6EHZJAYjo
 u+TIGkOadTS8TgHtbNCOPVMXZ24meGawqva2qxyqwhTmpkwb+ddAUT6qH/FGrfdeC3Yb
 DTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718171054; x=1718775854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jsc9zoEQ8hO5ey3ZY0D1UQ1aGkr7iTnFI4s55DtTZJs=;
 b=A0jN7ZocRZnaY/WmtdeZTDOoSAnQD6kJxiqmn4piPUZS5k/U0XYsJrRaOU4gKn/ojm
 P2UAkzkvLX1t0+ZyNQhql7+sXBuft2STHgEhAIYJTOb4G7ZtNWOgFFGuwGEYSv6/2NNw
 z9ia7RkSjz2T7VPwgAnOGb6s/pXcZn5g/R4Hn5Ke5ylPgRpoiPx35LJvd+0GKXWmMb2R
 86T4eZUP5gS18swUpQo8GqU2eF5M1WSoAEeE3DroBOf0bEY2JKzXeoVUAhoqvAx1nEPS
 +ZEliKqydbK2/yTzZDqND0nzyviXGgP4sXy8mKI9gBU6N0n5GPry2ma2UYgJJhLyCgbi
 1GJg==
X-Gm-Message-State: AOJu0Yy0MgcZz6kZAeTgvKYqqrpDblm7x8qjn/oCeklW9X4oS4x2vAU+
 4Ss+6UhJjXsr67nB1IdfYORGvKG2Pro2CJDPYNksalSW5XDibT0bPLFZYEWuiD8PBXDVnmwIoOF
 4UajYUUkt58yAa912DVtP9YJzm5Q=
X-Google-Smtp-Source: AGHT+IHhP93EER3drBfvcggzOd3NxLrfvfBzpisBTp/iymmqAIsCj8ZGUN04Yh1V2M/UTmQn9sOH+Ma74IStjgm2ojQ=
X-Received: by 2002:a05:622a:34f:b0:440:5361:a83b with SMTP id
 d75a77b69052e-44159ab4bb1mr22583491cf.8.1718171054544; Tue, 11 Jun 2024
 22:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240529224252.80395-1-dongwon.kim@intel.com>
 <CAJ+F1CJFWRtyXvpCJuSVPssJcBx8ecP1HCkWCJ=HBWxXovj+Dw@mail.gmail.com>
 <ed6a1963-b079-4fdc-a6ca-6ba98b95c0de@intel.com>
 <CAJ+F1CJW3b9D4nU3x4XSjpG=KrBpJMLWqdR3tpdipObODZRvgQ@mail.gmail.com>
 <PH8PR11MB68796CDE59AA75FD1D6089A1FAC02@PH8PR11MB6879.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB68796CDE59AA75FD1D6089A1FAC02@PH8PR11MB6879.namprd11.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Jun 2024 09:44:03 +0400
Message-ID: <CAJ+F1C+L=5cSPhEXrAczfN27sXEH_2Xwohk7Bt2r4KmhteDguQ@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Wait until the current guest frame is rendered
 before switching to RUN_STATE_SAVE_VM
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005e9d68061aaadffe"
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

--0000000000005e9d68061aaadffe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 12, 2024 at 5:29=E2=80=AFAM Kim, Dongwon <dongwon.kim@intel.com=
> wrote:

> Hi,
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
> Sent: Wednesday, June 5, 2024 12:56 AM
> To: Kim, Dongwon <dongwon.kim@intel.com>
> Cc: qemu-devel@nongnu.org; Peter Xu <peterx@redhat.com>
> Subject: Re: [PATCH] ui/gtk: Wait until the current guest frame is
> rendered before switching to RUN_STATE_SAVE_VM
>
> Hi
>
> On Tue, Jun 4, 2024 at 9:49=E2=80=AFPM Kim, Dongwon <mailto:dongwon.kim@i=
ntel.com>
> wrote:
> On 6/4/2024 4:12 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, May 30, 2024 at 2:44=E2=80=AFAM <mailto:dongwon.kim@intel.com
> > <mailto:mailto:dongwon.kim@intel.com>> wrote:
> >
> >     From: Dongwon <mailto:dongwon.kim@intel.com <mailto:mailto:
> dongwon.kim@intel.com>>
> >
> >     Make sure rendering of the current frame is finished before switchi=
ng
> >     the run state to RUN_STATE_SAVE_VM by waiting for egl-sync object t=
o
> be
> >     signaled.
> >
> >
> > Can you expand on what this solves?
>
> In current scheme, guest waits for the fence to be signaled for each
> frame it submits before moving to the next frame. If the guest=E2=80=99s =
state
> is saved while it is still waiting for the fence, The guest will
> continue to  wait for the fence that was signaled while ago when it is
> restored to the point. One way to prevent it is to get it finish the
> current frame before changing the state.
>
> After the UI sets a fence, hw_ops->gl_block(true) gets called, which will
> block virtio-gpu/virgl from processing commands (until the fence is
> signaled and gl_block/false called again).
>
> But this "blocking" state is not saved. So how does this affect
> save/restore? Please give more details, thanks
>
> Yeah sure. "Blocking" state is not saved but guest's state is saved while
> it was still waiting for the response for its last resource-flush virtio
> msg. This virtio response, by the way is set to be sent to the guest when
> the pipeline is unblocked (and when the fence is signaled.). Once the
> guest's state is saved, current instance of guest will be continued and
> receives the response as usual. The problem is happening when we restore
> the saved guest's state again because what guest does will be waiting for
> the response that was sent a while ago to the original instance.
>

Where is the pending response saved? Can you detail how you test this?

thanks


--=20
Marc-Andr=C3=A9 Lureau

--0000000000005e9d68061aaadffe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 12, 2024 at 5:29=E2=80=
=AFAM Kim, Dongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim=
@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi, <br>
<br>
From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.c=
om" target=3D"_blank">marcandre.lureau@gmail.com</a>&gt; <br>
Sent: Wednesday, June 5, 2024 12:56 AM<br>
To: Kim, Dongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_bl=
ank">dongwon.kim@intel.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a>; Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"=
_blank">peterx@redhat.com</a>&gt;<br>
Subject: Re: [PATCH] ui/gtk: Wait until the current guest frame is rendered=
 before switching to RUN_STATE_SAVE_VM<br>
<br>
Hi<br>
<br>
On Tue, Jun 4, 2024 at 9:49=E2=80=AFPM Kim, Dongwon &lt;mailto:<a href=3D"m=
ailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt=
; wrote:<br>
On 6/4/2024 4:12 AM, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Thu, May 30, 2024 at 2:44=E2=80=AFAM &lt;mailto:<a href=3D"mailto:d=
ongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:mailto" target=3D"_blank">mailto</a>:<a h=
ref=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.co=
m</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0From: Dongwon &lt;mailto:<a href=3D"mailto:dongwon.=
kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> &lt;mailto:<a hr=
ef=3D"mailto:mailto" target=3D"_blank">mailto</a>:<a href=3D"mailto:dongwon=
.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Make sure rendering of the current frame is finishe=
d before switching<br>
&gt;=C2=A0 =C2=A0 =C2=A0the run state to RUN_STATE_SAVE_VM by waiting for e=
gl-sync object to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0signaled.<br>
&gt; <br>
&gt; <br>
&gt; Can you expand on what this solves?<br>
<br>
In current scheme, guest waits for the fence to be signaled for each <br>
frame it submits before moving to the next frame. If the guest=E2=80=99s st=
ate <br>
is saved while it is still waiting for the fence, The guest will <br>
continue to=C2=A0 wait for the fence that was signaled while ago when it is=
 <br>
restored to the point. One way to prevent it is to get it finish the <br>
current frame before changing the state.<br>
<br>
After the UI sets a fence, hw_ops-&gt;gl_block(true) gets called, which wil=
l block virtio-gpu/virgl from processing commands (until the fence is signa=
led and gl_block/false called again).<br>
<br>
But this &quot;blocking&quot; state is not saved. So how does this affect s=
ave/restore? Please give more details, thanks<br>
<br>
Yeah sure. &quot;Blocking&quot; state is not saved but guest&#39;s state is=
 saved while it was still waiting for the response for its last resource-fl=
ush virtio msg. This virtio response, by the way is set to be sent to the g=
uest when the pipeline is unblocked (and when the fence is signaled.). Once=
 the guest&#39;s state is saved, current instance of guest will be continue=
d and receives the response as usual. The problem is happening when we rest=
ore the saved guest&#39;s state again because what guest does will be waiti=
ng for the response that was sent a while ago to the original instance.<br =
clear=3D"all"></blockquote><div><br></div><div>Where is the pending respons=
e saved? Can you detail how you test this?</div><div><br></div><div>thanks<=
br></div><div>=C2=A0</div></div><br><span class=3D"gmail_signature_prefix">=
-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lu=
reau<br></div></div>

--0000000000005e9d68061aaadffe--

