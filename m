Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0B6CD4F32
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 20:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slwt2-0003wY-9X; Wed, 04 Sep 2024 16:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1slwsu-0003rp-3o
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:45:52 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1slwsr-0005tY-Bx
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:45:47 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4fcfcdcb4acso32498e0c.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725482742; x=1726087542; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jtXdsMOg/xAj+P4pJWCCQy0FiEWmXvMewc4Pe9+UKPM=;
 b=hT4ArOsm+h1dVWSLJjweiOhRdgWNrLowolEUYkgqaO6m4XFLqj56LXL5hyMY/+SOPg
 /rsTyMKA4UzwNfJZSf4a5acZFgt1Ru3P0IEmMtNtmtbcS3yagJitJs/CYneOC0GCxDD8
 ArJ2JmY1P6S468oYkG2pAx2nRERg1SDbu0ftzzMx6ywp/ip4opLSAQvX54LXCrfcXvmT
 qIL7drjt06hs6dKlj4HzxowYG9bVMjyeyEMHtZaAihA8xqlbRTArg0zgfLImIj3wiORr
 6qMcJCHS5wu5jkgTAADLVys3LKRotbBrqxD+JcckCvW8Fcft00yKKBoUckenf8HpX4lL
 UxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725482742; x=1726087542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtXdsMOg/xAj+P4pJWCCQy0FiEWmXvMewc4Pe9+UKPM=;
 b=HohrcleqdsofgsKXjHAm3EumACYmj63ZNMo3hr7d+OEJ5kCC5JwUSu8MqxCdq+tu+1
 9NCcZr0vMs2AOXxiLTLdKhD3h5NXcqAMgSixqA38pa65f2WnsLilALMj8aVfMa8hEuTj
 Kz+eot8OFPO8hB+g2UvFwNh1AWiKh1BDPyvHzXAsbF3h9MWM4WPbYo+yRZNK1hKUvToA
 tWWiowYJaSM0iiW06UvCiyImtqtAhD/ILNBTCY5G3OWzEdB4A/Z8fjqG9VLSd1UI5ddB
 QWRFG7HZNZlUhz7TAJQdL/HSRIZ6J0SYlQesh8bK0H1aIqDj/pVu0dmk7XYJL6EDPN1w
 uw0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQmsO5SGRMrhKxL+2RdHxS9K4GgLheF8YgSquxz42FjQncNIKpdNcpJKhEk611oeGUh9zvh5+CUeKF@nongnu.org
X-Gm-Message-State: AOJu0YzX0RD/kx+oSV1Sh4lUDvupzMeTpFNKtqa74mUIAUyGqs7tMuYH
 vumvsX3ux4OQm6FX4YO8XaCqlwppEf0BFFMTliXzEVZvxTWRrR3nFsNz8A/mLVQ/QNRmCCpI6De
 6fNfEOK9GQ2gVnUpwSmiwXujQoYM=
X-Google-Smtp-Source: AGHT+IEnK4hLTDJItBPxt0na8JniuEtSmuVxkBch89kuW5xdjtYo72cBMJzCO96FU27mBh+jncHfGbIw6XaMscja7Zc=
X-Received: by 2002:a05:6122:1312:b0:4e4:e90f:6749 with SMTP id
 71dfb90a1353d-500de23ed70mr8291817e0c.10.1725482741861; Wed, 04 Sep 2024
 13:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
 <20240822150849.21759-6-dorjoychy111@gmail.com>
 <20240828122221-mutt-send-email-mst@kernel.org>
 <CAFfO_h5URpD4qnC5Cqh9tG49ijzRGpWqezdPDeaSMAOHnzFF9g@mail.gmail.com>
 <20240828151005-mutt-send-email-mst@kernel.org>
 <CAFfO_h66g138yVwufKY_C22Aiu8XctzyyjqsBYM4wdYN77JLuQ@mail.gmail.com>
 <20240903162013-mutt-send-email-mst@kernel.org>
 <CAFfO_h4B6jt7QvBBk-Axf9btCm6sg8hao_o+Q_4+X=+86H6Pcw@mail.gmail.com>
 <CAFfO_h4EnF5q0p2n4a4U2-gi+GxYfem0B6GKhOaJFOpDL48KFw@mail.gmail.com>
 <20240904162456-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240904162456-mutt-send-email-mst@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 5 Sep 2024 02:45:29 +0600
Message-ID: <CAFfO_h4=8wudzoUmCjn23vuc0Bqj+rix876T2F324WJHM0yCMg@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000e519d706215141f5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa2b.google.com
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

--000000000000e519d706215141f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024, 2:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Sep 05, 2024 at 12:30:07AM +0600, Dorjoy Chowdhury wrote:
> > On Wed, Sep 4, 2024 at 2:47=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@g=
mail.com>
> wrote:
> > >
> > >
> > >
> > > On Wed, Sep 4, 2024, 2:32 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> > >>
> > >> On Wed, Sep 04, 2024 at 01:58:15AM +0600, Dorjoy Chowdhury wrote:
> > >> > On Thu, Aug 29, 2024 at 1:11=E2=80=AFAM Michael S. Tsirkin <mst@re=
dhat.com>
> wrote:
> > >> > >
> > >> > > On Thu, Aug 29, 2024 at 01:04:05AM +0600, Dorjoy Chowdhury wrote=
:
> > >> > > > On Thu, Aug 29, 2024 at 12:28=E2=80=AFAM Michael S. Tsirkin <
> mst@redhat.com> wrote:
> > >> > > > >
> > >> > > > > On Thu, Aug 22, 2024 at 09:08:46PM +0600, Dorjoy Chowdhury
> wrote:
> > >> > > > > > Nitro Secure Module (NSM)[1] device is used in AWS Nitro
> Enclaves[2]
> > >> > > > > > for stripped down TPM functionality like cryptographic
> attestation.
> > >> > > > > > The requests to and responses from NSM device are CBOR[3]
> encoded.
> > >> > > > > >
> > >> > > > > > This commit adds support for NSM device in QEMU. Although
> related to
> > >> > > > > > AWS Nitro Enclaves, the virito-nsm device is independent
> and can be
> > >> > > > > > used in other machine types as well. The libcbor[4] librar=
y
> has been
> > >> > > > > > used for the CBOR encoding and decoding functionalities.
> > >> > > > > >
> > >> > > > > > [1]
> https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
> > >> > > > > > [2]
> https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> > >> > > > > > [3] http://cbor.io/
> > >> > > > > > [4] https://libcbor.readthedocs.io/en/latest/
> > >> > > > > >
> > >> > > > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > >> > > > > > ---
> > >> > > > > >  MAINTAINERS                      |   10 +
> > >> > > > > >  hw/virtio/Kconfig                |    5 +
> > >> > > > > >  hw/virtio/cbor-helpers.c         |  326 ++++++
> > >> > > > > >  hw/virtio/meson.build            |    6 +
> > >> > > > > >  hw/virtio/virtio-nsm-pci.c       |   73 ++
> > >> > > > > >  hw/virtio/virtio-nsm.c           | 1638
> ++++++++++++++++++++++++++++++
> > >> > > > > >  include/hw/virtio/cbor-helpers.h |   46 +
> > >> > > > > >  include/hw/virtio/virtio-nsm.h   |   59 ++
> > >> > > > > >  meson.build                      |    2 +
> > >> > > > > >  9 files changed, 2165 insertions(+)
> > >> > > >
> > >> > > > [...]
> > >> > > >
> > >> > > > > > +static void handle_input(VirtIODevice *vdev, VirtQueue *v=
q)
> > >> > > > > > +{
> > >> > > > > > +    g_autofree VirtQueueElement *out_elem =3D NULL;
> > >> > > > > > +    g_autofree VirtQueueElement *in_elem =3D NULL;
> > >> > > > > > +    VirtIONSM *vnsm =3D VIRTIO_NSM(vdev);
> > >> > > > > > +    Error *err =3D NULL;
> > >> > > > > > +
> > >> > > > > > +    out_elem =3D virtqueue_pop(vq, sizeof(VirtQueueElemen=
t));
> > >> > > > > > +    if (!out_elem) {
> > >> > > > > > +        /* nothing in virtqueue */
> > >> > > > > > +        return;
> > >> > > > > > +    }
> > >> > > > > > +
> > >> > > > > > +    if (out_elem->out_num !=3D 1) {
> > >> > > > > > +        virtio_error(vdev, "Expected one request buffer
> first in virtqueue");
> > >> > > > > > +        goto cleanup;
> > >> > > > > > +    }
> > >> > > > >
> > >> > > > > Seems to assume request in a single s/g element?
> > >> > > > > We generally avoid this kind of thing.
> > >> > > > >
> > >> > > > > Applies equally elsewheree.
> > >> > > > >
> > >> > > >
> > >> > > > Thank you for reviewing. I think I did it this way (first
> virqueue_pop
> > >> > > > gives out_elem with out_num =3D=3D 1 and the next virtqueue_po=
p
> gives
> > >> > > > in_elem with in_num =3D=3D 1) after seeing what the virqueue
> contains
> > >> > > > (using printfs) when running in a VM and sending some NSM
> requests and
> > >> > > > I noticed the above. Can you give me a bit more details about
> what
> > >> > > > this should be like? Is there any existing virtio device code =
I
> can
> > >> > > > look at for example?
> > >> > > > Thanks!
> > >> > >
> > >> > >
> > >> > > Use iov_to_buf / iov_from_buf
> > >> > >
> > >> > > there are many examples in the tree, I'd look for some recent
> ones.
> > >> > >
> > >> >
> > >> > I am a bit stuck at this and I would appreciate some help. I looke=
d
> at
> > >> > other "iov_to_buf" and "iov_from_buf" examples in QEMU and in thos=
e
> I
> > >> > see there are known request and response "structs" associated with
> it.
> > >> > But in the case of NSM, the request and responses can be arbitrary
> > >> > CBOR objects i.e., no specific structs or lengths associated.
> > >>
> > >>
> > >> take whatever you want to access, move it to a buffer with iov_to_bu=
f
> > >> then access the buffer.
> > >>
> > >> reverse is even easier. put in a buffer, copy with iov_from_buf.
> > >
> > >
> > > I guess I will just need to copy the iov buffer (whatever the length
> was in the out_elem's out buf) to another buffer using iov_to_buf and the=
n
> pass it to the processing function and then copy the response to the
> in_elem's buffer using iov_from_buf, right? Wouldn't the copying be
> redundant in this case as we could just instead pass the original buffers
> (like the iov-s are passed right now) to the processing function?
> > >
> > >>
> > >> > So I am
> > >> > not sure using "iov_to_buf" / "iov_from_buf" makes sense here.
> > >> > And about the request response being in a single s/g element, I
> think
> > >> > it's because of how the NSM driver is in drivers/misc/nsm.c (see
> > >> > nsm_sendrecv_msg_locked function)in the linux kernel tree.
> > >>
> > >> yes but driver is free to change this.
> > >> Isn't there a spec for this device to consult?
> > >> Sending that to virtio tc will be needed before we add this to qemu.
> > >
> > >
> > > I think this is the spec for this device (also mentioned in the commi=
t
> message of this patch)
> > >
> https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
> > >
> >
> > Hi Michael. Did you get a chance to look at the NSM device spec above?
> > I am not sure but from the description there I think the request
> > response being in a single s/g element makes sense, right?
> > So the
> > current implementation of first checking out_elem with out_num =3D=3D 1
> > and then an in_elem with in_num =3D=3D 1 should be correct. Please corr=
ect
> > me if I am wrong here and if I should change the implementation to
> > something else.
>
> This is not what the spec says. The spec says it's a single
> buffer, and in virtio longo buffer can include any number of
> s/g elements. how many - up to driver. device does not get
> to decide.
>

Understood. Thanks! I remember seeing other virtio device code in QEMU
where only one element was popped from the queue (virtqueue_pop) and out_sg
and in_sg were from that single popped element. But for NSM I saw that the
first popped element didn't have any in_sg. Instead the second popped
element had this. Can you give me some input on how to handle the in_sg?
Right now I just assume that I need to get another element from the queue.

Regards,
Dorjoy

--000000000000e519d706215141f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Sep 5, 2024, 2:27 AM Michael S. Tsirkin &lt;<a=
 href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">On Thu, Sep 05, 2024 at 12:30:07AM +0600, Dorjoy=
 Chowdhury wrote:<br>
&gt; On Wed, Sep 4, 2024 at 2:47=E2=80=AFAM Dorjoy Chowdhury &lt;<a href=3D=
"mailto:dorjoychy111@gmail.com" target=3D"_blank" rel=3D"noreferrer">dorjoy=
chy111@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Sep 4, 2024, 2:32 AM Michael S. Tsirkin &lt;<a href=3D"ma=
ilto:mst@redhat.com" target=3D"_blank" rel=3D"noreferrer">mst@redhat.com</a=
>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Wed, Sep 04, 2024 at 01:58:15AM +0600, Dorjoy Chowdhury wr=
ote:<br>
&gt; &gt;&gt; &gt; On Thu, Aug 29, 2024 at 1:11=E2=80=AFAM Michael S. Tsirk=
in &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank" rel=3D"noreferre=
r">mst@redhat.com</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; On Thu, Aug 29, 2024 at 01:04:05AM +0600, Dorjoy Ch=
owdhury wrote:<br>
&gt; &gt;&gt; &gt; &gt; &gt; On Thu, Aug 29, 2024 at 12:28=E2=80=AFAM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank" rel=
=3D"noreferrer">mst@redhat.com</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; On Thu, Aug 22, 2024 at 09:08:46PM +0600,=
 Dorjoy Chowdhury wrote:<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; Nitro Secure Module (NSM)[1] device =
is used in AWS Nitro Enclaves[2]<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; for stripped down TPM functionality =
like cryptographic attestation.<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; The requests to and responses from N=
SM device are CBOR[3] encoded.<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; This commit adds support for NSM dev=
ice in QEMU. Although related to<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; AWS Nitro Enclaves, the virito-nsm d=
evice is independent and can be<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; used in other machine types as well.=
 The libcbor[4] library has been<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; used for the CBOR encoding and decod=
ing functionalities.<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; [1] <a href=3D"https://lists.oasis-o=
pen.org/archives/virtio-comment/202310/msg00387.html" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">https://lists.oasis-open.org/archives/virtio-com=
ment/202310/msg00387.html</a><br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; [2] <a href=3D"https://docs.aws.amaz=
on.com/enclaves/latest/user/nitro-enclave.html" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://docs.aws.amazon.com/enclaves/latest/user/nitro=
-enclave.html</a><br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; [3] <a href=3D"http://cbor.io/" rel=
=3D"noreferrer noreferrer" target=3D"_blank">http://cbor.io/</a><br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; [4] <a href=3D"https://libcbor.readt=
hedocs.io/en/latest/" rel=3D"noreferrer noreferrer" target=3D"_blank">https=
://libcbor.readthedocs.io/en/latest/</a><br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; Signed-off-by: Dorjoy Chowdhury &lt;=
<a href=3D"mailto:dorjoychy111@gmail.com" target=3D"_blank" rel=3D"noreferr=
er">dorjoychy111@gmail.com</a>&gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; ---<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01=
0 +<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 hw/virtio/Kconfig=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 5 +<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 hw/virtio/cbor-helpers.c=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 326 ++++++<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 hw/virtio/meson.build=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 6 +<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 hw/virtio/virtio-nsm-pci.c=C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A073 ++<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 hw/virtio/virtio-nsm.c=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1638 ++++++++++++++++++++++++++++++<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 include/hw/virtio/cbor-helpers=
.h |=C2=A0 =C2=A046 +<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 include/hw/virtio/virtio-nsm.h=
=C2=A0 =C2=A0|=C2=A0 =C2=A059 ++<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =
2 +<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 9 files changed, 2165 insertio=
ns(+)<br>
&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; [...]<br>
&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +static void handle_input(VirtIODevi=
ce *vdev, VirtQueue *vq)<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +{<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 g_autofree VirtQueueE=
lement *out_elem =3D NULL;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 g_autofree VirtQueueE=
lement *in_elem =3D NULL;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 VirtIONSM *vnsm =3D V=
IRTIO_NSM(vdev);<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 Error *err =3D NULL;<=
br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 out_elem =3D virtqueu=
e_pop(vq, sizeof(VirtQueueElement));<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (!out_elem) {<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* noth=
ing in virtqueue */<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;=
<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (out_elem-&gt;out_=
num !=3D 1) {<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_=
error(vdev, &quot;Expected one request buffer first in virtqueue&quot;);<br=
>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cl=
eanup;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; Seems to assume request in a single s/g e=
lement?<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; We generally avoid this kind of thing.<br=
>
&gt; &gt;&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; Applies equally elsewheree.<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; Thank you for reviewing. I think I did it this=
 way (first virqueue_pop<br>
&gt; &gt;&gt; &gt; &gt; &gt; gives out_elem with out_num =3D=3D 1 and the n=
ext virtqueue_pop gives<br>
&gt; &gt;&gt; &gt; &gt; &gt; in_elem with in_num =3D=3D 1) after seeing wha=
t the virqueue contains<br>
&gt; &gt;&gt; &gt; &gt; &gt; (using printfs) when running in a VM and sendi=
ng some NSM requests and<br>
&gt; &gt;&gt; &gt; &gt; &gt; I noticed the above. Can you give me a bit mor=
e details about what<br>
&gt; &gt;&gt; &gt; &gt; &gt; this should be like? Is there any existing vir=
tio device code I can<br>
&gt; &gt;&gt; &gt; &gt; &gt; look at for example?<br>
&gt; &gt;&gt; &gt; &gt; &gt; Thanks!<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; Use iov_to_buf / iov_from_buf<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; there are many examples in the tree, I&#39;d look f=
or some recent ones.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; I am a bit stuck at this and I would appreciate some hel=
p. I looked at<br>
&gt; &gt;&gt; &gt; other &quot;iov_to_buf&quot; and &quot;iov_from_buf&quot=
; examples in QEMU and in those I<br>
&gt; &gt;&gt; &gt; see there are known request and response &quot;structs&q=
uot; associated with it.<br>
&gt; &gt;&gt; &gt; But in the case of NSM, the request and responses can be=
 arbitrary<br>
&gt; &gt;&gt; &gt; CBOR objects i.e., no specific structs or lengths associ=
ated.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; take whatever you want to access, move it to a buffer with io=
v_to_buf<br>
&gt; &gt;&gt; then access the buffer.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; reverse is even easier. put in a buffer, copy with iov_from_b=
uf.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I guess I will just need to copy the iov buffer (whatever the len=
gth was in the out_elem&#39;s out buf) to another buffer using iov_to_buf a=
nd then pass it to the processing function and then copy the response to th=
e in_elem&#39;s buffer using iov_from_buf, right? Wouldn&#39;t the copying =
be redundant in this case as we could just instead pass the original buffer=
s (like the iov-s are passed right now) to the processing function?<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; So I am<br>
&gt; &gt;&gt; &gt; not sure using &quot;iov_to_buf&quot; / &quot;iov_from_b=
uf&quot; makes sense here.<br>
&gt; &gt;&gt; &gt; And about the request response being in a single s/g ele=
ment, I think<br>
&gt; &gt;&gt; &gt; it&#39;s because of how the NSM driver is in drivers/mis=
c/nsm.c (see<br>
&gt; &gt;&gt; &gt; nsm_sendrecv_msg_locked function)in the linux kernel tre=
e.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; yes but driver is free to change this.<br>
&gt; &gt;&gt; Isn&#39;t there a spec for this device to consult?<br>
&gt; &gt;&gt; Sending that to virtio tc will be needed before we add this t=
o qemu.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I think this is the spec for this device (also mentioned in the c=
ommit message of this patch)<br>
&gt; &gt; <a href=3D"https://lists.oasis-open.org/archives/virtio-comment/2=
02310/msg00387.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html</a><br>
&gt; &gt;<br>
&gt; <br>
&gt; Hi Michael. Did you get a chance to look at the NSM device spec above?=
<br>
&gt; I am not sure but from the description there I think the request<br>
&gt; response being in a single s/g element makes sense, right?<br>
&gt; So the<br>
&gt; current implementation of first checking out_elem with out_num =3D=3D =
1<br>
&gt; and then an in_elem with in_num =3D=3D 1 should be correct. Please cor=
rect<br>
&gt; me if I am wrong here and if I should change the implementation to<br>
&gt; something else.<br>
<br>
This is not what the spec says. The spec says it&#39;s a single<br>
buffer, and in virtio longo buffer can include any number of<br>
s/g elements. how many - up to driver. device does not get<br>
to decide.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Understood. Thanks! I remember seeing other virtio device code in=
 QEMU where only one element was popped from the queue (virtqueue_pop) and =
out_sg and in_sg were from that single popped element. But for NSM I saw th=
at the first popped element didn&#39;t have any in_sg. Instead the second p=
opped element had this. Can you give me some input on how to handle the in_=
sg? Right now I just assume that I need to get another element from the que=
ue.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards,</div><div d=
ir=3D"auto">Dorjoy</div></div>

--000000000000e519d706215141f5--

