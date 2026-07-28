Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53963C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 20:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wooNr-0008Sm-Ky; Tue, 28 Jul 2026 16:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1wooNj-0008Rg-06
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:26:31 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1wooNh-0006Ww-5U
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:26:30 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-699fbcd23ccso283288a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 13:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785270387; cv=none;
 d=google.com; s=arc-20260327;
 b=Zplx1FhCLwFTzBYNGoZH27p4Qd/F8pLa6w6UFSgryaWt+WetGhkZMU/E9+m+G1T8C5
 xZC3IOPYcQz/UxIImGmhnFiKUfTFdV+cGusG9emfGLIWaeUjw//RfqPyTjYDQcYoJil0
 zqKmh45iP3IcGRzln0D2ptqDZ0Ba496fBSLH2Fcqr+A6ZkG1y4+CEIu70Y9fLyJ4eWpK
 Wyb7rINYIN5Qqb3GqMi/p7IcrIm996+/IkBojEsGKjzceJFtDvAVpXj7awhJY0LM071H
 cZNbkFUG7rZ5wU/kEe/33owF9XvPiwA+tDbVTnQZM8KBhGx61h9Nk4dZrY56H4IsRU1Y
 fTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XTH2xTnZRF3KJ3NbZC4KzsLFu+02WjK7oASp8zgRBuE=;
 fh=KnxVq+/dNMGR5XtbHr3cm7WMCtMcRbEU6z8PkW8LG2I=;
 b=Y3ae+zgi4jnY7t/se/SG/w2/qWiv+BxXAprH2PmLnUw8iza1BQH5P7k35CrxxmYhDi
 rmiDH0UEsVpbN1yXS2s/ZbslZWg7iELBUr1z4RKNZoE2RZro/8S9RGOtPkrQATWfB11S
 o36DafUF7IH63Yb0yMpmbjzcaf9KY0H+kzNAkBTu4PyXYbfFMMid/zHUXip4ygQ6bIqG
 3uw/NhbW8fsckdhaA3Hz+jCyo332yE0e3WISJuUmxMPCx2v74tWl1gS2Eoi/wv0N324K
 OFGUnjxAUN0wVMDOq1OQv4eZxDHPgQoHICzoRBYppgiNvETwoLBXXb7bHzw9dSKepPyD
 KhFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785270387; x=1785875187; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XTH2xTnZRF3KJ3NbZC4KzsLFu+02WjK7oASp8zgRBuE=;
 b=C1B5P+4IeG12adG9XEmiV+KyD5mGKFnYNKc8Y3GiUsl4xRQViSzSVA2nRWXbLx+2oD
 oSW3Kce+91wgizD/c8WyZyc5R3HTZpfCcRiwMchATz78cnMCwkndt4qWkvA3gfFQd3fB
 J3DJ7RRUPgUakPkt9lgBBUV9e6XAkwm9VYjLLLsrNbuhH5QwUuzZ55ChEzl2EJjjtdLH
 RUkMO4Hjxu2U1Ah9RgSPd1TIANNIeRA/MFt6cE+xcjkASYIa+cevvxF3qnAznegSqw5u
 xMzLxlG+k2gC8AKi/aerNjDTOgkg3GCTOWizax7wt5Jb04hadq3YDUFmwJ5i+YAZy4Ye
 Cuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785270387; x=1785875187;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XTH2xTnZRF3KJ3NbZC4KzsLFu+02WjK7oASp8zgRBuE=;
 b=YZtHbs31j95AKLxmnUxCUtxzupsKKTDH6xDwYqocvMd7pE/KFCJYq5kkYzRZXmSECL
 BbrbxAXFVrNBRNLSMltg/lsM15c1jEiM134iRi0MQY7BBjb4OtjL1Vz6OPl+rde0Gn4b
 ai79TOodtxGROgj91QltSxvoMbMSjQ1yG/g+orNBHbKuOrJdpZ/gfkJkkGP4tUswT/3a
 fD6nOGI13iETBAEwxlPdeca5SmnIHOT3p1Qz7Dl4HbAGZETBdRvoaK7Qgv/Kht4vKfRR
 Cc1afcetsiNt9sGSULu6yQGkFzN0RF5Pt0BrDC5/mXEuLkAy5oUbXSKPMbYdjqcuEZsQ
 R9Mw==
X-Gm-Message-State: AOJu0YzhelMVoNiuQH8ASYbkk2iQsYJoTaHAXGNGLVXIwAl1klnm774l
 jME8yHF6U1wNdC2W37f5Vp8WK3NoZMgq6pfb7zZ1ZlaLWKGD3lDlfxH56BzHftXCc/f5btHtVZ5
 27BBQi/FPXAAZQqQWUMjE4bfjmRibP/8=
X-Gm-Gg: AR+sD11PMLcmQhd0yNAyKso4aLBP31lj7MmFCAFDre7/JC8rm0Sh2wZ6g6b1+fhLY4t
 oDKgkNdXc0/RFHTNv4P4kKrhoNDKst/+53kEBLsk8kb+/Aiay7qHURMyaC0zn7fZ5lskvqcjSZs
 zurYUSRGOC8Q6hF0cSkwStdLiUB61u3TkgJ0/IIVmUvnzxFkWExNw583o1XCO6sHr7Oj2EY5ARf
 XU1WwhiT4MCD787lZ3xqvLWPnlHMhgjSxr1EBOj8mb/tUX6j1uWbzWM78184D6Cc44jkybJqaoh
 mRoGQpDXxF5cAzR1+eCr
X-Received: by 2002:a05:6402:28c4:b0:697:decc:7f9a with SMTP id
 4fb4d7f45d1cf-6a0349bcab4mr1805093a12.9.1785270386523; Tue, 28 Jul 2026
 13:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-virtio-gpu-short-header-v1-1-af19a00b100d@gmail.com>
 <0d877012-ea43-4f5b-ab85-16b0a733b5e5@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <0d877012-ea43-4f5b-ab85-16b0a733b5e5@rsg.ci.i.u-tokyo.ac.jp>
From: Ankur Saini <ankur98saini@gmail.com>
Date: Wed, 29 Jul 2026 01:56:15 +0530
X-Gm-Features: AUfX_mziWnXmszeTfD3Y3b2JWKAQl5YbYnwrSDwmqA6zaUb5Y6bcpSUzIEYxpDo
Message-ID: <CAE+rwONJvzJnxrrkz9Wi_5E+M6-Vq=-45B7T+guF_iJMzoza9A@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: reject requests with short/truncated control
 headers
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000378e060657b1a7dd"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=ankur98saini@gmail.com; helo=mail-ed1-x530.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000378e060657b1a7dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. I found the similar path in contrib/vhost-user-gpu and will include
a minimal fix for that in v2.

On Wed, Jul 29, 2026 at 1:22=E2=80=AFAM Akihiko Odaki <odaki@rsg.ci.i.u-tok=
yo.ac.jp>
wrote:

> On 2026/07/28 23:16, Ankur Saini wrote:
> > A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr
> > partially initialized. If the supplied bytes set the fence flag, stale
> > fence metadata may later be returned to the guest.
> >
> > Validate the common header length before dispatch. Clear cmd_hdr and
> > complete malformed requests with ERR_INVALID_PARAMETER so stale fields
> > cannot reach the response.
> >
> > Fixes: CVE-2026-18054
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4094
> > Reported-by: Ankur Saini <ankur98saini@gmail.com>
> > Signed-off-by: Ankur Saini <ankur98saini@gmail.com>
>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
> Please also fix vhost-user-gpu.
>
> Regards,
> Akihiko Odaki
>
> > ---
> > A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr
> > partially initialized. If the supplied bytes set the fence flag, stale
> > fence metadata may later be returned to the guest.
> >
> > Validate the common header length before dispatch. Clear cmd_hdr and
> > complete malformed requests with ERR_INVALID_PARAMETER so stale fields
> > cannot reach the response.
> > ---
> >   hw/display/virtio-gpu.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 4d46a4eb10..15a845eff6 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1105,8 +1105,14 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
> >               break;
> >           }
> >
> > -        /* process command */
> > -        vgc->process_cmd(g, cmd);
> > +        if (unlikely(iov_size(cmd->elem.out_sg, cmd->elem.out_num) <
> > +                     sizeof(cmd->cmd_hdr))) {
> > +            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
> > +            virtio_gpu_ctrl_response_nodata(
> > +                g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
> > +        } else {
> > +            vgc->process_cmd(g, cmd);
> > +        }
> >
> >           /* command suspended */
> >           if (!cmd->finished && !(cmd->cmd_hdr.flags &
> VIRTIO_GPU_FLAG_FENCE)) {
> >
> > ---
> > base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> > change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7
> >
> > Best regards,
>
>

--000000000000378e060657b1a7dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks. I found the similar path in contrib/vhost-user-gpu=
 and will include a minimal fix for that in v2.<br></div><br><div class=3D"=
gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Wed, Jul 29, 2026 at 1:22=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"mailto:o=
daki@rsg.ci.i.u-tokyo.ac.jp">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2026/07/28 23:1=
6, Ankur Saini wrote:<br>
&gt; A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr<b=
r>
&gt; partially initialized. If the supplied bytes set the fence flag, stale=
<br>
&gt; fence metadata may later be returned to the guest.<br>
&gt; <br>
&gt; Validate the common header length before dispatch. Clear cmd_hdr and<b=
r>
&gt; complete malformed requests with ERR_INVALID_PARAMETER so stale fields=
<br>
&gt; cannot reach the response.<br>
&gt; <br>
&gt; Fixes: CVE-2026-18054<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items=
/4094" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project=
/qemu/-/work_items/4094</a><br>
&gt; Reported-by: Ankur Saini &lt;<a href=3D"mailto:ankur98saini@gmail.com"=
 target=3D"_blank">ankur98saini@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Ankur Saini &lt;<a href=3D"mailto:ankur98saini@gmail.co=
m" target=3D"_blank">ankur98saini@gmail.com</a>&gt;<br>
<br>
Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.ac.=
jp" target=3D"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br>
<br>
Please also fix vhost-user-gpu.<br>
<br>
Regards,<br>
Akihiko Odaki<br>
<br>
&gt; ---<br>
&gt; A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr<b=
r>
&gt; partially initialized. If the supplied bytes set the fence flag, stale=
<br>
&gt; fence metadata may later be returned to the guest.<br>
&gt; <br>
&gt; Validate the common header length before dispatch. Clear cmd_hdr and<b=
r>
&gt; complete malformed requests with ERR_INVALID_PARAMETER so stale fields=
<br>
&gt; cannot reach the response.<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/display/virtio-gpu.c | 10 ++++++++--<br>
&gt;=C2=A0 =C2=A01 file changed, 8 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
&gt; index 4d46a4eb10..15a845eff6 100644<br>
&gt; --- a/hw/display/virtio-gpu.c<br>
&gt; +++ b/hw/display/virtio-gpu.c<br>
&gt; @@ -1105,8 +1105,14 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* process command */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 vgc-&gt;process_cmd(g, cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(iov_size(cmd-&gt;elem.out_sg=
, cmd-&gt;elem.out_num) &lt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0sizeof(cmd-&gt;cmd_hdr))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;cmd-&gt;cmd_hdr=
, 0, sizeof(cmd-&gt;cmd_hdr));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_ctrl_response_no=
data(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g, cmd, VIRTI=
O_GPU_RESP_ERR_INVALID_PARAMETER);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vgc-&gt;process_cmd(g, cmd)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* command suspended */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cmd-&gt;finished &amp;&am=
p; !(cmd-&gt;cmd_hdr.flags &amp; VIRTIO_GPU_FLAG_FENCE)) {<br>
&gt; <br>
&gt; ---<br>
&gt; base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95<br>
&gt; change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7<br>
&gt; <br>
&gt; Best regards,<br>
<br>
</blockquote></div>

--000000000000378e060657b1a7dd--

