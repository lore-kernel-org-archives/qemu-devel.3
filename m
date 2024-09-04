Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EAACD4F21
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 18:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slum4-0007J7-RV; Wed, 04 Sep 2024 14:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1slulk-0007Hb-K2
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 14:30:20 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sluli-0000mF-A0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 14:30:16 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-49baa3d3855so399476137.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 11:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725474613; x=1726079413; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cvn8931hTeay8ENsGXKglXpxzLpUTOOw0VmOIbww3FI=;
 b=XZHjBxOhOJ8zVXpZBb+D57zkyYZGXI2Je93BLLVTwUfqDcR3J50rSTUmbnjM3tmJY6
 nJogWJ8TNvioftMG7T1Vkr7fZJe23eg95nSpmAOzDFdXsBehbRU4bTFBsYjCaWXTkGWe
 Lu99CGzBE/EHDIASPe7N+LFaKplRWJScL36v5mCZvthjj108RKaRo6Wo9Rblr5xhQbUw
 EnUveKcqF4L1L1faiUaXCWpVvwtC0r/UD8BR/HeWdub+tTFaOqj9MYrtc22bExeuWw6R
 M8dd8UpemN6BR0K50OBdmRqDvfKnSml+6Lhf8EK0ADMoMnOlA65xdRsajYioHHGRR305
 G9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725474613; x=1726079413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cvn8931hTeay8ENsGXKglXpxzLpUTOOw0VmOIbww3FI=;
 b=l55622yH2MOyAlukaNL0I24Yg4rKFxEHu4+cdynuxkL5qtPXFI02NksdtzQ7jTsyfs
 vFBEO+PZAWmoNozcPhlIynutgwgOD5mQJlGMLUeQLPv+kzvSVJqAeG3Q9lz1T+1fb1zb
 As5iYZW3V5AAkxcp3mmBaVCDOMDmXVugzHSiffJdLX53v2CfOBgjHliK84fX+2L//lTV
 JGEHRPnfqNVhnAMuJK0y7RAVtgUcOPTuFOGjC5FU+kvPIxrgrPX1NGggLB/pLRXket79
 CdbJaCnFao4iY/cecfgNujxXDmjt8QDt7H/goJYXW/z3JJ1HFjq5j5vtfNCIvcYPBNpL
 WmPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkzg7jYdFYT46Ks6zCStRuHNKtBx1btxjtVbPAbd9fQxHj/F5hXcaF5GAKz2wEaiJScei3ewvbXXYr@nongnu.org
X-Gm-Message-State: AOJu0Ywakpf97f0VA7J/UeuYGZzyDc55QY5fN0jlBPNrfqtlDYlxtw5N
 EkqooWNMM2hTtbbrUuXnJ4wLEWpbmXsz04rOcF4ASVFXcY8+JZVKnqYNBBZLHS/KYP0aJNt39KQ
 SX3dEPJ9mOPufBsHLMknz5OtUOec=
X-Google-Smtp-Source: AGHT+IEZjidjd/RgLzYWVGHONFo4L4asMcMrGgYO0oxE9lB8Yzg/VxDFCRY+RAvuohrZkObDN1dOtEnQXW7Xyl15XXA=
X-Received: by 2002:a05:6102:3907:b0:498:dd44:32c with SMTP id
 ada2fe7eead31-49a5af81969mr24929291137.28.1725474612875; Wed, 04 Sep 2024
 11:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
 <20240822150849.21759-6-dorjoychy111@gmail.com>
 <20240828122221-mutt-send-email-mst@kernel.org>
 <CAFfO_h5URpD4qnC5Cqh9tG49ijzRGpWqezdPDeaSMAOHnzFF9g@mail.gmail.com>
 <20240828151005-mutt-send-email-mst@kernel.org>
 <CAFfO_h66g138yVwufKY_C22Aiu8XctzyyjqsBYM4wdYN77JLuQ@mail.gmail.com>
 <20240903162013-mutt-send-email-mst@kernel.org>
 <CAFfO_h4B6jt7QvBBk-Axf9btCm6sg8hao_o+Q_4+X=+86H6Pcw@mail.gmail.com>
In-Reply-To: <CAFfO_h4B6jt7QvBBk-Axf9btCm6sg8hao_o+Q_4+X=+86H6Pcw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 5 Sep 2024 00:30:07 +0600
Message-ID: <CAFfO_h4EnF5q0p2n4a4U2-gi+GxYfem0B6GKhOaJFOpDL48KFw@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Sep 4, 2024 at 2:47=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gmail=
.com> wrote:
>
>
>
> On Wed, Sep 4, 2024, 2:32 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Wed, Sep 04, 2024 at 01:58:15AM +0600, Dorjoy Chowdhury wrote:
>> > On Thu, Aug 29, 2024 at 1:11=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
>> > >
>> > > On Thu, Aug 29, 2024 at 01:04:05AM +0600, Dorjoy Chowdhury wrote:
>> > > > On Thu, Aug 29, 2024 at 12:28=E2=80=AFAM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
>> > > > >
>> > > > > On Thu, Aug 22, 2024 at 09:08:46PM +0600, Dorjoy Chowdhury wrote=
:
>> > > > > > Nitro Secure Module (NSM)[1] device is used in AWS Nitro Encla=
ves[2]
>> > > > > > for stripped down TPM functionality like cryptographic attesta=
tion.
>> > > > > > The requests to and responses from NSM device are CBOR[3] enco=
ded.
>> > > > > >
>> > > > > > This commit adds support for NSM device in QEMU. Although rela=
ted to
>> > > > > > AWS Nitro Enclaves, the virito-nsm device is independent and c=
an be
>> > > > > > used in other machine types as well. The libcbor[4] library ha=
s been
>> > > > > > used for the CBOR encoding and decoding functionalities.
>> > > > > >
>> > > > > > [1] https://lists.oasis-open.org/archives/virtio-comment/20231=
0/msg00387.html
>> > > > > > [2] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enc=
lave.html
>> > > > > > [3] http://cbor.io/
>> > > > > > [4] https://libcbor.readthedocs.io/en/latest/
>> > > > > >
>> > > > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
>> > > > > > ---
>> > > > > >  MAINTAINERS                      |   10 +
>> > > > > >  hw/virtio/Kconfig                |    5 +
>> > > > > >  hw/virtio/cbor-helpers.c         |  326 ++++++
>> > > > > >  hw/virtio/meson.build            |    6 +
>> > > > > >  hw/virtio/virtio-nsm-pci.c       |   73 ++
>> > > > > >  hw/virtio/virtio-nsm.c           | 1638 +++++++++++++++++++++=
+++++++++
>> > > > > >  include/hw/virtio/cbor-helpers.h |   46 +
>> > > > > >  include/hw/virtio/virtio-nsm.h   |   59 ++
>> > > > > >  meson.build                      |    2 +
>> > > > > >  9 files changed, 2165 insertions(+)
>> > > >
>> > > > [...]
>> > > >
>> > > > > > +static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
>> > > > > > +{
>> > > > > > +    g_autofree VirtQueueElement *out_elem =3D NULL;
>> > > > > > +    g_autofree VirtQueueElement *in_elem =3D NULL;
>> > > > > > +    VirtIONSM *vnsm =3D VIRTIO_NSM(vdev);
>> > > > > > +    Error *err =3D NULL;
>> > > > > > +
>> > > > > > +    out_elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
>> > > > > > +    if (!out_elem) {
>> > > > > > +        /* nothing in virtqueue */
>> > > > > > +        return;
>> > > > > > +    }
>> > > > > > +
>> > > > > > +    if (out_elem->out_num !=3D 1) {
>> > > > > > +        virtio_error(vdev, "Expected one request buffer first=
 in virtqueue");
>> > > > > > +        goto cleanup;
>> > > > > > +    }
>> > > > >
>> > > > > Seems to assume request in a single s/g element?
>> > > > > We generally avoid this kind of thing.
>> > > > >
>> > > > > Applies equally elsewheree.
>> > > > >
>> > > >
>> > > > Thank you for reviewing. I think I did it this way (first virqueue=
_pop
>> > > > gives out_elem with out_num =3D=3D 1 and the next virtqueue_pop gi=
ves
>> > > > in_elem with in_num =3D=3D 1) after seeing what the virqueue conta=
ins
>> > > > (using printfs) when running in a VM and sending some NSM requests=
 and
>> > > > I noticed the above. Can you give me a bit more details about what
>> > > > this should be like? Is there any existing virtio device code I ca=
n
>> > > > look at for example?
>> > > > Thanks!
>> > >
>> > >
>> > > Use iov_to_buf / iov_from_buf
>> > >
>> > > there are many examples in the tree, I'd look for some recent ones.
>> > >
>> >
>> > I am a bit stuck at this and I would appreciate some help. I looked at
>> > other "iov_to_buf" and "iov_from_buf" examples in QEMU and in those I
>> > see there are known request and response "structs" associated with it.
>> > But in the case of NSM, the request and responses can be arbitrary
>> > CBOR objects i.e., no specific structs or lengths associated.
>>
>>
>> take whatever you want to access, move it to a buffer with iov_to_buf
>> then access the buffer.
>>
>> reverse is even easier. put in a buffer, copy with iov_from_buf.
>
>
> I guess I will just need to copy the iov buffer (whatever the length was =
in the out_elem's out buf) to another buffer using iov_to_buf and then pass=
 it to the processing function and then copy the response to the in_elem's =
buffer using iov_from_buf, right? Wouldn't the copying be redundant in this=
 case as we could just instead pass the original buffers (like the iov-s ar=
e passed right now) to the processing function?
>
>>
>> > So I am
>> > not sure using "iov_to_buf" / "iov_from_buf" makes sense here.
>> > And about the request response being in a single s/g element, I think
>> > it's because of how the NSM driver is in drivers/misc/nsm.c (see
>> > nsm_sendrecv_msg_locked function)in the linux kernel tree.
>>
>> yes but driver is free to change this.
>> Isn't there a spec for this device to consult?
>> Sending that to virtio tc will be needed before we add this to qemu.
>
>
> I think this is the spec for this device (also mentioned in the commit me=
ssage of this patch)
> https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
>

Hi Michael. Did you get a chance to look at the NSM device spec above?
I am not sure but from the description there I think the request
response being in a single s/g element makes sense, right? So the
current implementation of first checking out_elem with out_num =3D=3D 1
and then an in_elem with in_num =3D=3D 1 should be correct. Please correct
me if I am wrong here and if I should change the implementation to
something else.

Also I had another look into using iov_to_buf and iov_from_buf. If I
wanted to use iov_to_buf here, I would just be copying the
out_elem->out_sg->iov_base to another buffer (by malloc-ing the same
length) and then passing it to the processing function
(get_nsm_request_response). And if I wanted to use the iov_from_buf
then I would probably just make another buffer the same size of
in_elem->in_sg->iov_base and then pass it to the processing function
(get_nsm_request_response). The function tries to put the response
CBOR object in the response buffer but if it is too small, it then
tries to put the error response BufferTooSmall if it fails then it
returns error. I don't see how using iov_to_buf and iov_from_buf makes
any difference here other than passing in the original iov structs to
the processing function instead. Seems like doing so would just be
doing some unnecessary copying.

Please let me know what you think so that I can better understand
this. Sorry for the back and forth a bit on this one.

Thanks.

Regards,
Dorjoy

