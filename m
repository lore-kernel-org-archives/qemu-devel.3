Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AD3CD37B1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slaRc-0001qm-JB; Tue, 03 Sep 2024 16:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1slaRb-0001pd-7o
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:48:07 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1slaRY-0008TB-P2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:48:06 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-498c4d5a912so2128668137.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725396483; x=1726001283; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R86XYK+Tfl2nLFncXM0zgkqo7jP/tNY3vcKfo3FOsqc=;
 b=TZUzctY/CtippCwB25ggvyDVjRRNAUYHSj/ScddqHeWUvmnN7ad/8F3GUXoZiXKeUq
 jEA/SzvRTdAgYYuK3YQm4wJJ9w4P2CZTVkBcDTsCQMW+dMUk6lLDGKNS5NrABm3fai7V
 xsOwi6u9M+F09Q57o/9lr+LUuDfPJrBkVCjKxJmHnncdTp19vw8ctxlPvkVGm/uUnpGF
 ot0Gv0UkZOW3SN53RDjmgB5Oz/nIFlKOCq5kJC1JHKaRZwV/bwJjdDYF+WyR+Egy/Epg
 jGxvIeVZtL8xJ1Q5q10+xIdR6MCnXC9pW5ZhorzaK+T/ZMS6ukiycx+Bhvf/dJu+IDwO
 uLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725396483; x=1726001283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R86XYK+Tfl2nLFncXM0zgkqo7jP/tNY3vcKfo3FOsqc=;
 b=SgCDlz+fC6+XGpbQLtQ8o9WTBvXrm7Jj5CiiMNi7HiZGOPSVJTDIK6eu6dJsf+CygL
 9suIOgKJnUuMbg+dx9tU+NwM9BdknBe6wr/wtSGXl+kFDgpryJDTd1ibE6/oT87iTKA6
 btyLmzn7NDNCclBkp4dWqABwnJydJJxPptIzlM00n13KJeRe+pp0FfPcMejEaH+ukVDC
 65I5/ReB0ecWIbJB9FrxQpY/q5y8ZkXRyzwmfxGEvRHn8sO5OYIqFpJQbIB2lp05byN+
 J7m7V7268I+ThilRw+O0QGlWtce4Cm1k3EB+3nRIDelFz2M4xWkDRXa+SM21Ij9CR7o/
 luJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPX8VMFONYNB+96AaKqaMC261r/PXMcoBAiMcpvYwDmvgLakIQQ3XFG2SE7+w/X1hrMan/iva4Vylp@nongnu.org
X-Gm-Message-State: AOJu0YzdGnmAGZ5o3+oaICH4qffDU81BjD9SPptLWkSwqp807EHOzWh6
 Uxvj+Fz1QqUK4GuNk/jGe7YxJ4Qrpyrs+WdWzB4SoShCeeQBgtML4gu2Z0KblXhapkSWFqs3MjF
 /12bGOSqIvUWDo4/nS+VopwsPjBk=
X-Google-Smtp-Source: AGHT+IGn5MNfoFDOZl2Rwoy0cxQpc3V8Y6VDXLmAvVaBSpunNwEmELCPqrNI7y992GZfFtbf21+wtCuVqenclU0HVVM=
X-Received: by 2002:a05:6102:292b:b0:493:b9ae:31ea with SMTP id
 ada2fe7eead31-49ba89b532emr5412070137.6.1725396483400; Tue, 03 Sep 2024
 13:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
 <20240822150849.21759-6-dorjoychy111@gmail.com>
 <20240828122221-mutt-send-email-mst@kernel.org>
 <CAFfO_h5URpD4qnC5Cqh9tG49ijzRGpWqezdPDeaSMAOHnzFF9g@mail.gmail.com>
 <20240828151005-mutt-send-email-mst@kernel.org>
 <CAFfO_h66g138yVwufKY_C22Aiu8XctzyyjqsBYM4wdYN77JLuQ@mail.gmail.com>
 <20240903162013-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240903162013-mutt-send-email-mst@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 4 Sep 2024 02:47:51 +0600
Message-ID: <CAFfO_h4B6jt7QvBBk-Axf9btCm6sg8hao_o+Q_4+X=+86H6Pcw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] device/virtio-nsm: Support for Nitro Secure Module
 device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, 
 slp@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007d6bfb06213d2c6b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vs1-xe2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000007d6bfb06213d2c6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024, 2:32 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Sep 04, 2024 at 01:58:15AM +0600, Dorjoy Chowdhury wrote:
> > On Thu, Aug 29, 2024 at 1:11=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com>
> wrote:
> > >
> > > On Thu, Aug 29, 2024 at 01:04:05AM +0600, Dorjoy Chowdhury wrote:
> > > > On Thu, Aug 29, 2024 at 12:28=E2=80=AFAM Michael S. Tsirkin <mst@re=
dhat.com>
> wrote:
> > > > >
> > > > > On Thu, Aug 22, 2024 at 09:08:46PM +0600, Dorjoy Chowdhury wrote:
> > > > > > Nitro Secure Module (NSM)[1] device is used in AWS Nitro
> Enclaves[2]
> > > > > > for stripped down TPM functionality like cryptographic
> attestation.
> > > > > > The requests to and responses from NSM device are CBOR[3]
> encoded.
> > > > > >
> > > > > > This commit adds support for NSM device in QEMU. Although
> related to
> > > > > > AWS Nitro Enclaves, the virito-nsm device is independent and ca=
n
> be
> > > > > > used in other machine types as well. The libcbor[4] library has
> been
> > > > > > used for the CBOR encoding and decoding functionalities.
> > > > > >
> > > > > > [1]
> https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
> > > > > > [2]
> https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> > > > > > [3] http://cbor.io/
> > > > > > [4] https://libcbor.readthedocs.io/en/latest/
> > > > > >
> > > > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > > > ---
> > > > > >  MAINTAINERS                      |   10 +
> > > > > >  hw/virtio/Kconfig                |    5 +
> > > > > >  hw/virtio/cbor-helpers.c         |  326 ++++++
> > > > > >  hw/virtio/meson.build            |    6 +
> > > > > >  hw/virtio/virtio-nsm-pci.c       |   73 ++
> > > > > >  hw/virtio/virtio-nsm.c           | 1638
> ++++++++++++++++++++++++++++++
> > > > > >  include/hw/virtio/cbor-helpers.h |   46 +
> > > > > >  include/hw/virtio/virtio-nsm.h   |   59 ++
> > > > > >  meson.build                      |    2 +
> > > > > >  9 files changed, 2165 insertions(+)
> > > >
> > > > [...]
> > > >
> > > > > > +static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
> > > > > > +{
> > > > > > +    g_autofree VirtQueueElement *out_elem =3D NULL;
> > > > > > +    g_autofree VirtQueueElement *in_elem =3D NULL;
> > > > > > +    VirtIONSM *vnsm =3D VIRTIO_NSM(vdev);
> > > > > > +    Error *err =3D NULL;
> > > > > > +
> > > > > > +    out_elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> > > > > > +    if (!out_elem) {
> > > > > > +        /* nothing in virtqueue */
> > > > > > +        return;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (out_elem->out_num !=3D 1) {
> > > > > > +        virtio_error(vdev, "Expected one request buffer first
> in virtqueue");
> > > > > > +        goto cleanup;
> > > > > > +    }
> > > > >
> > > > > Seems to assume request in a single s/g element?
> > > > > We generally avoid this kind of thing.
> > > > >
> > > > > Applies equally elsewheree.
> > > > >
> > > >
> > > > Thank you for reviewing. I think I did it this way (first
> virqueue_pop
> > > > gives out_elem with out_num =3D=3D 1 and the next virtqueue_pop giv=
es
> > > > in_elem with in_num =3D=3D 1) after seeing what the virqueue contai=
ns
> > > > (using printfs) when running in a VM and sending some NSM requests
> and
> > > > I noticed the above. Can you give me a bit more details about what
> > > > this should be like? Is there any existing virtio device code I can
> > > > look at for example?
> > > > Thanks!
> > >
> > >
> > > Use iov_to_buf / iov_from_buf
> > >
> > > there are many examples in the tree, I'd look for some recent ones.
> > >
> >
> > I am a bit stuck at this and I would appreciate some help. I looked at
> > other "iov_to_buf" and "iov_from_buf" examples in QEMU and in those I
> > see there are known request and response "structs" associated with it.
> > But in the case of NSM, the request and responses can be arbitrary
> > CBOR objects i.e., no specific structs or lengths associated.
>
>
> take whatever you want to access, move it to a buffer with iov_to_buf
> then access the buffer.
>
> reverse is even easier. put in a buffer, copy with iov_from_buf.
>

I guess I will just need to copy the iov buffer (whatever the length was in
the out_elem's out buf) to another buffer using iov_to_buf and then pass it
to the processing function and then copy the response to the in_elem's
buffer using iov_from_buf, right? Wouldn't the copying be redundant in this
case as we could just instead pass the original buffers (like the iov-s are
passed right now) to the processing function?


> > So I am
> > not sure using "iov_to_buf" / "iov_from_buf" makes sense here.
> > And about the request response being in a single s/g element, I think
> > it's because of how the NSM driver is in drivers/misc/nsm.c (see
> > nsm_sendrecv_msg_locked function)in the linux kernel tree.
>
> yes but driver is free to change this.
> Isn't there a spec for this device to consult?
> Sending that to virtio tc will be needed before we add this to qemu.
>

I think this is the spec for this device (also mentioned in the commit
message of this patch)
https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html

Regards,
Dorjoy

--0000000000007d6bfb06213d2c6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Sep 4, 2024, 2:32 AM Michael S. Tsirkin &lt;<a=
 href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">On Wed, Sep 04, 2024 at 01:58:15AM +0600, Dorjoy=
 Chowdhury wrote:<br>
&gt; On Thu, Aug 29, 2024 at 1:11=E2=80=AFAM Michael S. Tsirkin &lt;<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank" rel=3D"noreferrer">mst@redhat.=
com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Thu, Aug 29, 2024 at 01:04:05AM +0600, Dorjoy Chowdhury wrote:=
<br>
&gt; &gt; &gt; On Thu, Aug 29, 2024 at 12:28=E2=80=AFAM Michael S. Tsirkin =
&lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
mst@redhat.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Thu, Aug 22, 2024 at 09:08:46PM +0600, Dorjoy Chowdh=
ury wrote:<br>
&gt; &gt; &gt; &gt; &gt; Nitro Secure Module (NSM)[1] device is used in AWS=
 Nitro Enclaves[2]<br>
&gt; &gt; &gt; &gt; &gt; for stripped down TPM functionality like cryptogra=
phic attestation.<br>
&gt; &gt; &gt; &gt; &gt; The requests to and responses from NSM device are =
CBOR[3] encoded.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; This commit adds support for NSM device in QEMU. A=
lthough related to<br>
&gt; &gt; &gt; &gt; &gt; AWS Nitro Enclaves, the virito-nsm device is indep=
endent and can be<br>
&gt; &gt; &gt; &gt; &gt; used in other machine types as well. The libcbor[4=
] library has been<br>
&gt; &gt; &gt; &gt; &gt; used for the CBOR encoding and decoding functional=
ities.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; [1] <a href=3D"https://lists.oasis-open.org/archiv=
es/virtio-comment/202310/msg00387.html" rel=3D"noreferrer noreferrer" targe=
t=3D"_blank">https://lists.oasis-open.org/archives/virtio-comment/202310/ms=
g00387.html</a><br>
&gt; &gt; &gt; &gt; &gt; [2] <a href=3D"https://docs.aws.amazon.com/enclave=
s/latest/user/nitro-enclave.html" rel=3D"noreferrer noreferrer" target=3D"_=
blank">https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html<=
/a><br>
&gt; &gt; &gt; &gt; &gt; [3] <a href=3D"http://cbor.io/" rel=3D"noreferrer =
noreferrer" target=3D"_blank">http://cbor.io/</a><br>
&gt; &gt; &gt; &gt; &gt; [4] <a href=3D"https://libcbor.readthedocs.io/en/l=
atest/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://libcbor.rea=
dthedocs.io/en/latest/</a><br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Signed-off-by: Dorjoy Chowdhury &lt;<a href=3D"mai=
lto:dorjoychy111@gmail.com" target=3D"_blank" rel=3D"noreferrer">dorjoychy1=
11@gmail.com</a>&gt;<br>
&gt; &gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A010 +<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 hw/virtio/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 5 +<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 hw/virtio/cbor-helpers.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 326 ++++++<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 hw/virtio/meson.build=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 6 +<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 hw/virtio/virtio-nsm-pci.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A073 ++<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 hw/virtio/virtio-nsm.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 1638 ++++++++++++++++++++++++++++++<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 include/hw/virtio/cbor-helpers.h |=C2=A0 =C2=
=A046 +<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 include/hw/virtio/virtio-nsm.h=C2=A0 =C2=A0|=
=C2=A0 =C2=A059 ++<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 9 files changed, 2165 insertions(+)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [...]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; +static void handle_input(VirtIODevice *vdev, Virt=
Queue *vq)<br>
&gt; &gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 g_autofree VirtQueueElement *out_el=
em =3D NULL;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 g_autofree VirtQueueElement *in_ele=
m =3D NULL;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 VirtIONSM *vnsm =3D VIRTIO_NSM(vdev=
);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 Error *err =3D NULL;<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 out_elem =3D virtqueue_pop(vq, size=
of(VirtQueueElement));<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (!out_elem) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* nothing in virtque=
ue */<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (out_elem-&gt;out_num !=3D 1) {<=
br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_error(vdev, &q=
uot;Expected one request buffer first in virtqueue&quot;);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Seems to assume request in a single s/g element?<br>
&gt; &gt; &gt; &gt; We generally avoid this kind of thing.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Applies equally elsewheree.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thank you for reviewing. I think I did it this way (first vi=
rqueue_pop<br>
&gt; &gt; &gt; gives out_elem with out_num =3D=3D 1 and the next virtqueue_=
pop gives<br>
&gt; &gt; &gt; in_elem with in_num =3D=3D 1) after seeing what the virqueue=
 contains<br>
&gt; &gt; &gt; (using printfs) when running in a VM and sending some NSM re=
quests and<br>
&gt; &gt; &gt; I noticed the above. Can you give me a bit more details abou=
t what<br>
&gt; &gt; &gt; this should be like? Is there any existing virtio device cod=
e I can<br>
&gt; &gt; &gt; look at for example?<br>
&gt; &gt; &gt; Thanks!<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Use iov_to_buf / iov_from_buf<br>
&gt; &gt;<br>
&gt; &gt; there are many examples in the tree, I&#39;d look for some recent=
 ones.<br>
&gt; &gt;<br>
&gt; <br>
&gt; I am a bit stuck at this and I would appreciate some help. I looked at=
<br>
&gt; other &quot;iov_to_buf&quot; and &quot;iov_from_buf&quot; examples in =
QEMU and in those I<br>
&gt; see there are known request and response &quot;structs&quot; associate=
d with it.<br>
&gt; But in the case of NSM, the request and responses can be arbitrary<br>
&gt; CBOR objects i.e., no specific structs or lengths associated.<br>
<br>
<br>
take whatever you want to access, move it to a buffer with iov_to_buf<br>
then access the buffer.<br>
<br>
reverse is even easier. put in a buffer, copy with iov_from_buf.<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I guess I w=
ill just need to copy the iov buffer (whatever the length was in the out_el=
em&#39;s out buf) to another buffer using iov_to_buf and then pass it to th=
e processing function and then copy the response to the in_elem&#39;s buffe=
r using iov_from_buf, right? Wouldn&#39;t the copying be redundant in this =
case as we could just instead pass the original buffers (like the iov-s are=
 passed right now) to the processing function?</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
<br>
&gt; So I am<br>
&gt; not sure using &quot;iov_to_buf&quot; / &quot;iov_from_buf&quot; makes=
 sense here.<br>
&gt; And about the request response being in a single s/g element, I think<=
br>
&gt; it&#39;s because of how the NSM driver is in drivers/misc/nsm.c (see<b=
r>
&gt; nsm_sendrecv_msg_locked function)in the linux kernel tree.<br>
<br>
yes but driver is free to change this.<br>
Isn&#39;t there a spec for this device to consult?<br>
Sending that to virtio tc will be needed before we add this to qemu.<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I think=
 this is the spec for this device (also mentioned in the commit message of =
this patch)=C2=A0</div><div dir=3D"auto"><a href=3D"https://lists.oasis-ope=
n.org/archives/virtio-comment/202310/msg00387.html">https://lists.oasis-ope=
n.org/archives/virtio-comment/202310/msg00387.html</a></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Regards,</div><div dir=3D"auto">Dorjoy</div>=
</div>

--0000000000007d6bfb06213d2c6b--

