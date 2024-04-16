Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D930C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 12:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwhpX-000585-9q; Tue, 16 Apr 2024 08:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwhpV-00057g-Mn
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:22:29 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwhpT-0008S2-Pb
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:22:29 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2dac77cdf43so13165741fa.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713270146; x=1713874946; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6Yhr+Ohk/AD3RKmAt5+G0M6SctMsd2O74f1TeTspDk=;
 b=T2p5CfUodvOkOk0uGedwJuSQ2EbJani2DBMmkZ5flK/zJxnSTjxa/G3+hD21PomnFE
 pHG0emb0rlR3oSHGsjAn52I2TeH7trpSmK2QTAZDBXq3iC9ZcGkRf+m5CigZx0mwk4sk
 YkZklMqhMBEotZt5iSN+RuxlMTLxHjI3yd5vXqS2pDW/fg6XLQFBNu+Vt+4LZnKoRFIU
 jLaOzIcAE7QyuC/urJwrprens0jlNHVHbHuIeN8X5HB4UOTlGTnvmyOswDJ6klVUPWGW
 urh5o8NHzbtGVyTLEGqMMnN/feIgGN7Fqrv12rmlSEaGx9rcmYWxcmRRM3Iub5sdmD0L
 7aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713270146; x=1713874946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6Yhr+Ohk/AD3RKmAt5+G0M6SctMsd2O74f1TeTspDk=;
 b=OimtyuzMjJ9BC0FkK17vGkmLqTymZsv2XtK3Gu+uOnhTPWxWgr/7fu+qxdggMMxPst
 CN+SLIidqcOpVZOZCYmQdAINFr3D8qfOtfg7Wo69N9GV/WIsaJThKrMFtAVxai1AkiAc
 etYXI2kXvggMpulIWTuImkbDjtJtt4eSbojfy+bu0kcFYpElz4JmJS4jJ0Z6gyckkQmC
 yV/tirtVwJWgN+P+C5C7herX5CYXH8dqIh5L2uOMrqYr/DpwSnoFneQNwyEtpLmao5gZ
 ZWbA4DOTxJPVIfdjSaM4doB09AwLCJWhm29KzasWCgPoPJk9RoPMugKD0NkCrRVOAcxN
 qX1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwz+3W6ToILsJIXD1Yd6+3mk2dvckwaMsTYAkj5/i0UZuybW7e++ByJDmYGQ+MdUxp7CEgY4BIX1sc7FRh0LqHfmlWQN0=
X-Gm-Message-State: AOJu0Yx3jvId8VHn/NstIsyCG+63HzUVsldbqVQqTPNiPhB2UIYVbFVz
 DFw59RezoK1YF7K9uxdAYszk46g/VMjdwAk3+dXYv2HEA8HZJN5urOomOgLvRoQdeq3pUHt3ybS
 CKQd6byzhReCYqtfqd8yK60p24uQpiultBteHiw==
X-Google-Smtp-Source: AGHT+IFOOzbyY+bwtXBjnLZf/cvbNQlTTK8SQQnVlPV3etuAUR1J6SSFh2Ztbhnv3olJVVsYQiguIwzB7x9lvuSTa+A=
X-Received: by 2002:a2e:9dc5:0:b0:2d9:f7f8:3e87 with SMTP id
 x5-20020a2e9dc5000000b002d9f7f83e87mr8976870ljj.32.1713270145512; Tue, 16 Apr
 2024 05:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1713178348.git.mst@redhat.com>
 <2ce6cff94df2650c460f809e5ad263f1d22507c0.1713178348.git.mst@redhat.com>
 <CAFEAcA9Hs+05ux3SkJqZQ5RyAkwbgmDGMm5gn+GYZL76CJCYkQ@mail.gmail.com>
 <CACLfguX73rN77rK92xboF6hxERoO2F7kdqUgBohrURt7-38C2A@mail.gmail.com>
 <CAFEAcA_WxhOpjtZ5r-CfoOaf1aiKeaEV9eX=drb1JaBCiBoDKA@mail.gmail.com>
In-Reply-To: <CAFEAcA_WxhOpjtZ5r-CfoOaf1aiKeaEV9eX=drb1JaBCiBoDKA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 13:22:14 +0100
Message-ID: <CAFEAcA_AcKdOXO3+ez6J+hQ4NmGoUa+fBUNK3XL_YSvRk09Gcg@mail.gmail.com>
Subject: Re: [PULL 1/1] virtio-pci: fix use of a released vector
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 16 Apr 2024 at 12:50, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Tue, 16 Apr 2024 at 12:05, Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Tue, Apr 16, 2024 at 6:01=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > > Hi; Coverity points out what it thinks is a problem in
> > > this commit (CID 1543938):

> > > Here we pass that through to kvm_virtio_pci_vector_use_one().
> > > In kvm_virtio_pci_vector_use_one()'s error-exit path ("undo")
> > > it does
> > >     vector =3D virtio_queue_vector(vdev, queue_no);
> > > and in virtio_queue_vector() it does:
> > >
> > >     return n < VIRTIO_QUEUE_MAX ? vdev->vq[n].vector :
> > >         VIRTIO_NO_VECTOR;
> > >
> > > where 'n' is an int, so if we can get here with queue_no being
> > > VIRTIO_CONFIG_IRQ_IDX then we'll index off the front of the
> > > vdev->vq[] array.
> > >
> > > Maybe this is a "can't happen" case, but it does seem odd that
> > > virtio_queue_vector() only bounds-checks the "too big" case
> > > for its argument and not the "too small" case and/or it
> > > doesn't have a special case for VIRTIO_CONFIG_IRQ_IDX.
> > >
> > > > +    }
> > > > +}
> > > > +
> > >
> > hi peter
> > I think we can simply remove the part
> >     vector =3D virtio_queue_vector(vdev, queue_no);
> > the vector is get from virtio_pci_get_notifier() and don't need to get =
it again
> > I will send the fix soon
>
> The error handling in kvm_virtio_pci_vector_use_one() looks
> a bit odd in other ways, too. The only bit of "undoing"
> it does as far as I can see is calling kvm_virtio_pci_irqfd_release(),
> but there is no code path that gets to there where the
> main codepath's call to kvm_virtio-pci_irqfd_use() succeeded
> and needs to be undone. So perhaps the entire "undo" code
> block should be deleted, and the "goto undo" lines
> replaced by simple "return ret;" ?  (The codepath
> for "kvm_virtio_pci_irqfd_use() failed" already does the
> "kvm_virtio_pci_vq_vector_release()" by hand there.)

In any case since the error handling in kvm_virtio_pci_vector_use_one()
isn't new in this commit (you can get the same problem via
kvm_virtio_pci_vector_config_use(), which is CID 1468940
first detected in 2022), I think this is not something we need
to rush to fix before we release 9.0. If anybody disagrees now
would be a good time to say so :-)

Paolo's comment on CID 1468940 was to suggest "virtio_queue_vector
should check VIRTIO_CONFIG_IRQ_IDX just like virtio_pci_get_notifier",
incidentally.

thanks
-- PMM

