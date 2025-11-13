Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DA1CD98E2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 20:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJeLt-0002Io-09; Thu, 13 Nov 2025 15:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vJeAL-0002Cy-KQ
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 15:43:37 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vJeAJ-00041U-AY
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 15:43:36 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7b8bbf16b71so1472518b3a.2
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 12:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763066613; x=1763671413; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tjPcuT5UpejYoPDmNEcWvBzL3CoKzY+9HWbHP6ctQh0=;
 b=FAC9R6e8fiOfbmK55nrXro7KsJD8ZxVL+ERQzjX/m4Mu3I6CzUBRF5EXeTKjNKD+fk
 lzwxI5iGloXvjTRiPCKomtnBz1JfOvaLTxgojTNcxv+AhuGxpeHO3Twknira5/6P1F1w
 qa9tcCeY0OK3ri+hMffNunhx8PZAQO3OtDBPFiwm/3pxBdU5eWUpgwbNipPvrWJnpQG6
 +Diy7/RnA1q8L1f4fyUS+3hMgHjQowLVQDjRIwyz3Gy4OJ/JX/9ypnJhvCpHLW5RNCIj
 LFFm2HzcAgdzRqQYhn3ifE4CsdMZIlSIOzOI5nQlmWmRtpin8yDZJpf10M8Wgm0l5k0u
 of9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763066613; x=1763671413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjPcuT5UpejYoPDmNEcWvBzL3CoKzY+9HWbHP6ctQh0=;
 b=Lfsh1jEDqbjFe4sbEO3z1ZHprdUdEWNRzFXrhjaSdP37VMn0L+kBd4LZkirWaq7IVe
 vkyu0xUsnmurNNOVDDUruHl62+Gs1vFNAba5abHjEc0PsZOZtPZNzM0Ja7ltt7Vigpk7
 3SMi1A6pI1Zw4LAv74xtgDJT7BX56BTqB2/Sr/I0lzpNxt6OGRhp1GqYiomjbh7mWhUs
 bzCK83EgP77vtgnYny9AQGPz+l+qIreQZW7YavOym8I+X4RcF9f36e8N80rIccjZ583/
 rSX7G4wFjNnarsMn+yAbGN0kZZ09/RDMBQTqTOoIER6HVhaywVo6iUtCM7wgAVKIwHUJ
 kd0A==
X-Gm-Message-State: AOJu0Yz77ty52M5F0JESCm9Y2pjmgkzHZCgnvfauQagIHTzJ5mmP5g0n
 yfUs11NIdB+NaHosCFP5SSzVrWidslVKFgDRyRcJovE6iS/zdyKgC5Ea+jKDs4aSGf5fKuUp6nf
 /znWZ+bjKTB2uq/GDKeYR/EcqIwuArlU=
X-Gm-Gg: ASbGncs8fRCtByKqawjnRr1TEbZ9py76s6jrcACpv4gG5t1K7+UcxDcLh8ZK0bFNRCK
 VjPHwhlALnm/YXp2/Aq5JdISgOBw6WOXVshduQcHcyRJboTaP8cRC6eOMMrddFVa0dMb9gR5Tai
 QtwGpdXTjpvrC8xk6vcW5E+xvncPijBkFBB3R2DxmEaB/zQ47pQC0cgZnZYvZ6wiDUJoVwAAz4t
 A1laIUTgw7WqNsftxhC7Uzj6RGIQYlEKi1fclgOtnV9m/Mmw5oOUVTt7UqO
X-Google-Smtp-Source: AGHT+IH1pgmbK5+tO5Ouyp0DPvUcnvWGO7ujMNGXwYnMwg9FdV7kli7NBO4KZG2RIy6z4PPIfN0qyzd46F5SWwRHGIg=
X-Received: by 2002:a05:7022:43a6:b0:119:e569:fb91 with SMTP id
 a92af1059eb24-11b40b29675mr413195c88.0.1763066613191; Thu, 13 Nov 2025
 12:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
 <20251028152351.1247812-2-edgar.iglesias@gmail.com>
 <87bjlgvemk.fsf@draig.linaro.org>
In-Reply-To: <87bjlgvemk.fsf@draig.linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 13 Nov 2025 14:43:20 -0600
X-Gm-Features: AWmQ_blXtLhPCYp7qI_p_j3IK8Sads20qcSkItiIVkAqOqUJm32fi3hzJvarUPM
Message-ID: <CAJy5ezozbawVnB1vHZRtr35N5+VK903B72dqk4NusxWSFbqchA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] virtio: Introduce notify_queue
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 bill.mills@linaro.org, edgar.iglesias@amd.com
Content-Type: multipart/alternative; boundary="00000000000031db8c06437fefe5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-pf1-x431.google.com
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

--00000000000031db8c06437fefe5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:38=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> "Edgar E. Iglesias" <edgar.iglesias@gmail.com> writes:
>
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >  hw/virtio/virtio.c             | 7 +++++++
> >  include/hw/virtio/virtio-bus.h | 1 +
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 153ee0a0cf..8a53fb5f93 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2700,12 +2700,19 @@ static void virtio_irq(VirtQueue *vq)
> >
> >  void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
> >  {
> > +    BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
> > +    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> > +
> >      WITH_RCU_READ_LOCK_GUARD() {
> >          if (!virtio_should_notify(vdev, vq)) {
> >              return;
> >          }
> >      }
> >
> > +    if (k->notify_queue) {
> > +        k->notify_queue(qbus->parent, virtio_get_queue_index(vq));
> > +    }
> > +
> >      trace_virtio_notify(vdev, vq);
> >      virtio_irq(vq);
> >  }
> > diff --git a/include/hw/virtio/virtio-bus.h
> b/include/hw/virtio/virtio-bus.h
> > index 7ab8c9dab0..043dbeb4cf 100644
> > --- a/include/hw/virtio/virtio-bus.h
> > +++ b/include/hw/virtio/virtio-bus.h
> > @@ -39,6 +39,7 @@ DECLARE_OBJ_CHECKERS(VirtioBusState, VirtioBusClass,
> >  struct VirtioBusClass {
> >      /* This is what a VirtioBus must implement */
> >      BusClass parent;
> > +    void (*notify_queue)(DeviceState *d, uint16_t index);
> >      void (*notify)(DeviceState *d, uint16_t vector);
> >      void (*save_config)(DeviceState *d, QEMUFile *f);
> >      void (*save_queue)(DeviceState *d, int n, QEMUFile *f);
>
> The code looks fine but we could do with a little outline of why we need
> this is the commit messages. Why do we have notify and notify_queue? Are
> they mutually exclusive?
>
> Not specific to this patch but we should strive to document the
> individual methods in each class to give a clearer idea of what they do.
>

Thanks Alex,

Actually, I can do without introducing this new callback.
Thanks for the other comments as well, I'll fix those up for the next
submission.

Cheers,
Edgar



>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--00000000000031db8c06437fefe5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 5, 2025=
 at 6:38=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lina=
ro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">&quot;Edgar E. Iglesias&quot; &lt;<a href=3D"=
mailto:edgar.iglesias@gmail.com" target=3D"_blank">edgar.iglesias@gmail.com=
</a>&gt; writes:<br>
<br>
&gt; From: &quot;Edgar E. Iglesias&quot; &lt;<a href=3D"mailto:edgar.iglesi=
as@amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@=
amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 7 +++++++<br>
&gt;=C2=A0 include/hw/virtio/virtio-bus.h | 1 +<br>
&gt;=C2=A0 2 files changed, 8 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
&gt; index 153ee0a0cf..8a53fb5f93 100644<br>
&gt; --- a/hw/virtio/virtio.c<br>
&gt; +++ b/hw/virtio/virtio.c<br>
&gt; @@ -2700,12 +2700,19 @@ static void virtio_irq(VirtQueue *vq)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));<b=
r>
&gt; +=C2=A0 =C2=A0 VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 WITH_RCU_READ_LOCK_GUARD() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virtio_should_notify(vdev, vq))=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (k-&gt;notify_queue) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 k-&gt;notify_queue(qbus-&gt;parent, virti=
o_get_queue_index(vq));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 trace_virtio_notify(vdev, vq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_irq(vq);<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio=
-bus.h<br>
&gt; index 7ab8c9dab0..043dbeb4cf 100644<br>
&gt; --- a/include/hw/virtio/virtio-bus.h<br>
&gt; +++ b/include/hw/virtio/virtio-bus.h<br>
&gt; @@ -39,6 +39,7 @@ DECLARE_OBJ_CHECKERS(VirtioBusState, VirtioBusClass,=
<br>
&gt;=C2=A0 struct VirtioBusClass {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* This is what a VirtioBus must implement */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BusClass parent;<br>
&gt; +=C2=A0 =C2=A0 void (*notify_queue)(DeviceState *d, uint16_t index);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 void (*notify)(DeviceState *d, uint16_t vector);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 void (*save_config)(DeviceState *d, QEMUFile *f);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 void (*save_queue)(DeviceState *d, int n, QEMUFile=
 *f);<br>
<br>
The code looks fine but we could do with a little outline of why we need<br=
>
this is the commit messages. Why do we have notify and notify_queue? Are<br=
>
they mutually exclusive? <br>
<br>
Not specific to this patch but we should strive to document the<br>
individual methods in each class to give a clearer idea of what they do.<br=
></blockquote><div><br></div><div>Thanks Alex,</div><div><br></div><div>Act=
ually, I can do without introducing this new callback.</div><div>Thanks for=
 the other comments as well, I&#39;ll fix those up for the next submission.=
</div><div><br></div><div>Cheers,</div><div>Edgar</div><div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div>

--00000000000031db8c06437fefe5--

