Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81177C636EE
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 19:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjO4w-0004hZ-P6; Wed, 28 Aug 2024 15:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sjO4v-0004gX-EZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 15:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sjO4t-0005mS-0a
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 15:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724872293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+o30uOu3yu8clIzhSx3mbcgi7TsX0CQj9bTDzfAFrWY=;
 b=JzUBUUeuAU3cgD9i8psQ/ymtjA76jdfljX0SaQl64+tSyHKbY6HVBh2VxI9+il7iMspQge
 vkZ84WHQKV2V8CGfw0YFRRF073TJ7tOrz0OiUDP8r1keUKUCQ0ceWizB8CNqwlnnryfYuJ
 uc6bJ/YvCARVnz9kB9w4cX/8VVqAzrA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-Ie_qipiBPhaaLHDyYOAnCg-1; Wed, 28 Aug 2024 15:11:31 -0400
X-MC-Unique: Ie_qipiBPhaaLHDyYOAnCg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5343808962cso6874017e87.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 12:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724872289; x=1725477089;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+o30uOu3yu8clIzhSx3mbcgi7TsX0CQj9bTDzfAFrWY=;
 b=mwTf0A9e5wi+OD5wmLQAhjGqMtMPJsas4a56BOcgtUtC+PxcP18qhk/EYoxjQrziUP
 Fo3LNW0O67u7+rlIHFXQDsisuScNeKwRWcWW3hYJsmzk7WKadBdbhJTm14+22D5pSSov
 irs56lx1SuPXwFrhFaZDryB/v6bCraMDD+cHTMPa+dCzsMTx8dTdCKB1L+2vcSQ2J3pp
 bgOJNeocC4qqUq7+YncySDajYtT+KN2yONaLnkdJZd8l9XQI88lU61v9vPamoXLhGCQx
 EqMLkKYptHIW8GRNbuG0RbIiBqzqb1YXGC6Be/UsJGN7p/SLhrbDH3wB4F5UMCn7V7TK
 Olsg==
X-Gm-Message-State: AOJu0YwtV1fahr0sEFUxyZARPYgDMbGhYs12KRiYhHJOq6kMPWyXuipf
 tAF6DNthMtL4taRZsxuCBS1KqR35H4nxDoWEWcXtnaX+xD5WXwF5VYYOTp8wMtwmzZytOv0Dhg7
 qrWm2dz0PW8gKL3AoIiPvFrpe7myfwj6uIwhVGtbFkHX5KFlsXqr7
X-Received: by 2002:a05:6512:2356:b0:52f:c24b:175f with SMTP id
 2adb3069b0e04-5353e54b64bmr141351e87.20.1724872289363; 
 Wed, 28 Aug 2024 12:11:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyjPwSR3cgQSmKHjRdHX39owlFBZ6eiYCvxjSfCrdbYmYjYvDsYuHFalfP0R5VvAeyKMAaug==
X-Received: by 2002:a05:6512:2356:b0:52f:c24b:175f with SMTP id
 2adb3069b0e04-5353e54b64bmr141317e87.20.1724872288312; 
 Wed, 28 Aug 2024 12:11:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:a269:8195:851e:f4b1:ff5d])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e5878239sm275518166b.150.2024.08.28.12.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 12:11:27 -0700 (PDT)
Date: Wed, 28 Aug 2024 15:11:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, berrange@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v5 5/8] device/virtio-nsm: Support for Nitro Secure
 Module device
Message-ID: <20240828151005-mutt-send-email-mst@kernel.org>
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
 <20240822150849.21759-6-dorjoychy111@gmail.com>
 <20240828122221-mutt-send-email-mst@kernel.org>
 <CAFfO_h5URpD4qnC5Cqh9tG49ijzRGpWqezdPDeaSMAOHnzFF9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFfO_h5URpD4qnC5Cqh9tG49ijzRGpWqezdPDeaSMAOHnzFF9g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Aug 29, 2024 at 01:04:05AM +0600, Dorjoy Chowdhury wrote:
> On Thu, Aug 29, 2024 at 12:28 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Aug 22, 2024 at 09:08:46PM +0600, Dorjoy Chowdhury wrote:
> > > Nitro Secure Module (NSM)[1] device is used in AWS Nitro Enclaves[2]
> > > for stripped down TPM functionality like cryptographic attestation.
> > > The requests to and responses from NSM device are CBOR[3] encoded.
> > >
> > > This commit adds support for NSM device in QEMU. Although related to
> > > AWS Nitro Enclaves, the virito-nsm device is independent and can be
> > > used in other machine types as well. The libcbor[4] library has been
> > > used for the CBOR encoding and decoding functionalities.
> > >
> > > [1] https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
> > > [2] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> > > [3] http://cbor.io/
> > > [4] https://libcbor.readthedocs.io/en/latest/
> > >
> > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > ---
> > >  MAINTAINERS                      |   10 +
> > >  hw/virtio/Kconfig                |    5 +
> > >  hw/virtio/cbor-helpers.c         |  326 ++++++
> > >  hw/virtio/meson.build            |    6 +
> > >  hw/virtio/virtio-nsm-pci.c       |   73 ++
> > >  hw/virtio/virtio-nsm.c           | 1638 ++++++++++++++++++++++++++++++
> > >  include/hw/virtio/cbor-helpers.h |   46 +
> > >  include/hw/virtio/virtio-nsm.h   |   59 ++
> > >  meson.build                      |    2 +
> > >  9 files changed, 2165 insertions(+)
> 
> [...]
> 
> > > +static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
> > > +{
> > > +    g_autofree VirtQueueElement *out_elem = NULL;
> > > +    g_autofree VirtQueueElement *in_elem = NULL;
> > > +    VirtIONSM *vnsm = VIRTIO_NSM(vdev);
> > > +    Error *err = NULL;
> > > +
> > > +    out_elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> > > +    if (!out_elem) {
> > > +        /* nothing in virtqueue */
> > > +        return;
> > > +    }
> > > +
> > > +    if (out_elem->out_num != 1) {
> > > +        virtio_error(vdev, "Expected one request buffer first in virtqueue");
> > > +        goto cleanup;
> > > +    }
> >
> > Seems to assume request in a single s/g element?
> > We generally avoid this kind of thing.
> >
> > Applies equally elsewheree.
> >
> 
> Thank you for reviewing. I think I did it this way (first virqueue_pop
> gives out_elem with out_num == 1 and the next virtqueue_pop gives
> in_elem with in_num == 1) after seeing what the virqueue contains
> (using printfs) when running in a VM and sending some NSM requests and
> I noticed the above. Can you give me a bit more details about what
> this should be like? Is there any existing virtio device code I can
> look at for example?
> Thanks!


Use iov_to_buf / iov_from_buf

there are many examples in the tree, I'd look for some recent ones.


> > > +
> > > +    in_elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> > > +    if (!in_elem) {
> > > +        virtio_error(vdev, "Expected response buffer after request buffer "
> > > +                     "in virtqueue");
> > > +        goto cleanup;
> > > +    }
> > > +    if (in_elem->in_num != 1) {
> > > +        virtio_error(vdev, "Expected one response buffer after request buffer "
> > > +                     "in virtqueue");
> > > +        goto cleanup;
> > > +    }
> > > +
> > > +    if (!get_nsm_request_response(vnsm, out_elem->out_sg, in_elem->in_sg,
> > > +                                  &err)) {
> > > +        error_report_err(err);
> > > +        virtio_error(vdev, "Failed to get NSM request response");
> > > +        goto cleanup;
> > > +    }
> > > +
> > > +    virtqueue_push(vq, out_elem, 0);
> > > +    virtqueue_push(vq, in_elem, in_elem->in_sg->iov_len);
> > > +    virtio_notify(vdev, vq);
> > > +    return;
> > > +
> > > + cleanup:
> > > +    if (out_elem) {
> > > +        virtqueue_detach_element(vq, out_elem, 0);
> > > +    }
> > > +    if (in_elem) {
> > > +        virtqueue_detach_element(vq, in_elem, 0);
> > > +    }
> > > +    return;
> > > +}
> > > +
> > > +static uint64_t get_features(VirtIODevice *vdev, uint64_t f, Error **errp)
> > > +{
> > > +    return f;
> > > +}
> > > +
> 
> [...]
> 
> Regards,
> Dorjoy


