Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB2FCD37AA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 19:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZfY-0004P0-2y; Tue, 03 Sep 2024 15:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1slZfV-0004NG-Lq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 15:58:26 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1slZfT-0002rh-Ao
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 15:58:25 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-846c452898cso815241.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 12:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725393502; x=1725998302; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNXCbW8zSUexYNqaq28AxiNnWDgtOEmwJTTEdxpCwfc=;
 b=U0xvqUPNTxraUEy3NxEVWChGrrwWRSSSyysTaZiLNEx4h08NgtJud9JDRwPRsJzJ0C
 hQu8rPt3/1swqjB2Ie8joAX8reqAVLHk6kjQ1/TDaHboxDxySs4jGUXcK7gQrgJnVNtx
 QEyuWLI/XqoLG9G4XvdW4IbfFuatTPujh1HRuFnwhHfE9aWLNCQAaeMwNG+3VQLteRGy
 DoRMShEFoFZDBttRI13nQ3jDjGBOvGopUWvisrM5waZKy83lCmz3HoaIi/yYFLIxiR70
 gPFVMXp/KG8Xj6dbows/T1EWnow1azHyycr44umXAlUxs8kxBq1guRsFseSKrM2/Hq8k
 VUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725393502; x=1725998302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QNXCbW8zSUexYNqaq28AxiNnWDgtOEmwJTTEdxpCwfc=;
 b=A1iUE/KckhQQsYB0TJcJ3DCrcGqx80vRzVLK9HwO54LqZ/ioBOaaG5qfvzpWR6lnOX
 2Ps9oK9+zRJSXlWaS1dSANfIFmOK9N2s/YBqIhDCpJ0D+5Sha3q/nCTGlQfgFLnAAnYx
 ZPwF/Z52oL5oRpkp1cSZ+qIDeImoqxx5dGA0KqqGiZAwD93gCJ4zVypxgoPqj/LOvq+G
 +ZeOG8Hy3uVNnbH+9nX9FvJXIdOTxn1ygQqNSDrkxBarFwmyH7ln1dH5UySqiSIE9XAk
 tR5FNx8vyPAqtJPh4b28bMtlwPHHrPdprlUnBnY0eCgk3jiZke2OjJGzwfoB0FJiogQs
 FtCQ==
X-Gm-Message-State: AOJu0YxP1YEv+R5tdhaVO08bRoeuhxF0KcdpibzpmjDz7pxdSIVq0AbN
 tFLnqmoUhVKguwjr18mgScdasKyjrfWoHE6hJNqPnoSljVLnw2FHZH3HH2VXQ5mXZiZDt8fhL6X
 xZa/9L+WE8qGFFa5fu//YrmRGhKk=
X-Google-Smtp-Source: AGHT+IGmvxrFjUyvvIetBuBYapJnkaXd3NXWDA5vZZ7KfLF6aWrLl4HDrQr+IMfapdhb0IdzkOO1vYV3H5brBr6yaZE=
X-Received: by 2002:a05:6122:3c47:b0:4f5:1f34:15d5 with SMTP id
 71dfb90a1353d-5003caaef88mr19494168e0c.5.1725393501586; Tue, 03 Sep 2024
 12:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
 <20240822150849.21759-6-dorjoychy111@gmail.com>
 <20240828122221-mutt-send-email-mst@kernel.org>
 <CAFfO_h5URpD4qnC5Cqh9tG49ijzRGpWqezdPDeaSMAOHnzFF9g@mail.gmail.com>
 <20240828151005-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240828151005-mutt-send-email-mst@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 4 Sep 2024 01:58:15 +0600
Message-ID: <CAFfO_h66g138yVwufKY_C22Aiu8XctzyyjqsBYM4wdYN77JLuQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] device/virtio-nsm: Support for Nitro Secure Module
 device
To: "Michael S. Tsirkin" <mst@redhat.com>, graf@amazon.com
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, stefanha@redhat.com, 
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, berrange@redhat.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ua1-x92b.google.com
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

On Thu, Aug 29, 2024 at 1:11=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Aug 29, 2024 at 01:04:05AM +0600, Dorjoy Chowdhury wrote:
> > On Thu, Aug 29, 2024 at 12:28=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Thu, Aug 22, 2024 at 09:08:46PM +0600, Dorjoy Chowdhury wrote:
> > > > Nitro Secure Module (NSM)[1] device is used in AWS Nitro Enclaves[2=
]
> > > > for stripped down TPM functionality like cryptographic attestation.
> > > > The requests to and responses from NSM device are CBOR[3] encoded.
> > > >
> > > > This commit adds support for NSM device in QEMU. Although related t=
o
> > > > AWS Nitro Enclaves, the virito-nsm device is independent and can be
> > > > used in other machine types as well. The libcbor[4] library has bee=
n
> > > > used for the CBOR encoding and decoding functionalities.
> > > >
> > > > [1] https://lists.oasis-open.org/archives/virtio-comment/202310/msg=
00387.html
> > > > [2] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.=
html
> > > > [3] http://cbor.io/
> > > > [4] https://libcbor.readthedocs.io/en/latest/
> > > >
> > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > ---
> > > >  MAINTAINERS                      |   10 +
> > > >  hw/virtio/Kconfig                |    5 +
> > > >  hw/virtio/cbor-helpers.c         |  326 ++++++
> > > >  hw/virtio/meson.build            |    6 +
> > > >  hw/virtio/virtio-nsm-pci.c       |   73 ++
> > > >  hw/virtio/virtio-nsm.c           | 1638 ++++++++++++++++++++++++++=
++++
> > > >  include/hw/virtio/cbor-helpers.h |   46 +
> > > >  include/hw/virtio/virtio-nsm.h   |   59 ++
> > > >  meson.build                      |    2 +
> > > >  9 files changed, 2165 insertions(+)
> >
> > [...]
> >
> > > > +static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
> > > > +{
> > > > +    g_autofree VirtQueueElement *out_elem =3D NULL;
> > > > +    g_autofree VirtQueueElement *in_elem =3D NULL;
> > > > +    VirtIONSM *vnsm =3D VIRTIO_NSM(vdev);
> > > > +    Error *err =3D NULL;
> > > > +
> > > > +    out_elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> > > > +    if (!out_elem) {
> > > > +        /* nothing in virtqueue */
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (out_elem->out_num !=3D 1) {
> > > > +        virtio_error(vdev, "Expected one request buffer first in v=
irtqueue");
> > > > +        goto cleanup;
> > > > +    }
> > >
> > > Seems to assume request in a single s/g element?
> > > We generally avoid this kind of thing.
> > >
> > > Applies equally elsewheree.
> > >
> >
> > Thank you for reviewing. I think I did it this way (first virqueue_pop
> > gives out_elem with out_num =3D=3D 1 and the next virtqueue_pop gives
> > in_elem with in_num =3D=3D 1) after seeing what the virqueue contains
> > (using printfs) when running in a VM and sending some NSM requests and
> > I noticed the above. Can you give me a bit more details about what
> > this should be like? Is there any existing virtio device code I can
> > look at for example?
> > Thanks!
>
>
> Use iov_to_buf / iov_from_buf
>
> there are many examples in the tree, I'd look for some recent ones.
>

I am a bit stuck at this and I would appreciate some help. I looked at
other "iov_to_buf" and "iov_from_buf" examples in QEMU and in those I
see there are known request and response "structs" associated with it.
But in the case of NSM, the request and responses can be arbitrary
CBOR objects i.e., no specific structs or lengths associated. So I am
not sure using "iov_to_buf" / "iov_from_buf" makes sense here.
And about the request response being in a single s/g element, I think
it's because of how the NSM driver is in drivers/misc/nsm.c (see
nsm_sendrecv_msg_locked function)in the linux kernel tree.
I am not sure what changes are needed in the current code if any. Do
you have any suggestions on this?

Regards,
Dorjoy

