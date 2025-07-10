Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FF9C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsFF-0007Bw-4j; Thu, 10 Jul 2025 10:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZs5u-000706-JK
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:17:51 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZs5r-0006wQ-UN
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:17:50 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e812c817de0so838288276.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752157066; x=1752761866; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/S9uJdAR6BPyYxDoKo+lXs/5hE64QsKXfbFXTwXq1R8=;
 b=u+KLIspzhtyYVF/c8/XekfV6zjrSABduebz2FslYZssGVJnLSyW9OTjZ/kXTPklbXf
 26sqpbNzawuFQO7NnyyVpw3v+UNXp/ZxBsAkVfdXgKxj/I8EXP3j9k77/E32TaOZstaO
 AAk/qneBoJT5GOQmMof6lBhl2h57A1O214BU+vMq+pTFHRCep8lL74mfVkW2gZr5DeR8
 /sMPj9NeT2hgCk4DnmFaJHQ5TNk0x2wrW0hSUsbGtYLNkgJSKGxDB+omh1IOujCXkekp
 u/oaFfwf1J9FZ9CJ2j0hOSC2YSk/2BF0CyYT/OrTaCPFMIE2YICGFKvgvbogVoflyfie
 7H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752157066; x=1752761866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/S9uJdAR6BPyYxDoKo+lXs/5hE64QsKXfbFXTwXq1R8=;
 b=Hhax90rUufMsNkwOFdhSVCt/BpFQ8EyGFAJQ33T1v2GNQkqEWtEqVsoLQQckswwn2h
 q/KyYb6uCvk9LHuIXZmikIfTgdVdLc+0WR3AsesaSLdrdTXH+0F3qufwMWHq7NWlcybg
 sFbG772guK3wPgg1BnOBMXA72gGfD+HSByLuVaVeIuqfx5oovyfZqcV/d2gEU2PFZ/h2
 vn6NquM08o4F205RFRdhsVQoyeQvyQ4S+3Qm6N/cxRQaY1nZxvLpOw3syb0WG3jAaZ8l
 YqGtHOnXXuoodmoUeMdIFAj2FDotDbHYlX5sM/SM6yWMp1LN2oQh/zB7rN+HoZO/Dxno
 57pg==
X-Gm-Message-State: AOJu0Yzp8Dj6o++TZ+XASeyyk2DCxU2gxph85ZIBDxNpUD0i1rpbWkfI
 qYfC2eEBjE74dNMN94UJ3omWFSAlyFLsRG4bFJJcSH6kqFU8o5ts5VXbDnlieL/KNeXfS8adjHs
 t8CJc3ogPRmgMZeC5UGbdJFxXtPsntG2w6O1501mNag==
X-Gm-Gg: ASbGncsCyw9bJbblxIj+4AOjUPcEU/pjROofiBnTMaiKzkz6FWGEbe0+yD8KCYFciNd
 1mytu3uotgIjaY5Lo4B7zGX4hSOw4ynRkOTZGXkSjrI7MQMt4G2vqetAzXuvJVlDMaCTjsofyY5
 0L+vvH8JGrso/vDgUyGV0AzcR+anpgpn/ikqB2ZOGclSkD
X-Google-Smtp-Source: AGHT+IH+Fvln78iXupr1df6Ftnl5dyuWvfmAj+30yxjEl2Qs3mAFemMzf4/LQwNNLNrICx95bJPvdSGZ8MiFTllofu8=
X-Received: by 2002:a05:690c:7343:b0:712:d70b:45f0 with SMTP id
 00721157ae682-717c47ea62dmr40832447b3.32.1752157065741; Thu, 10 Jul 2025
 07:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
 <4719a2d59176a6c850e2b4f1af44cecd25430fce.1746438650.git.qemu_oss@crudebyte.com>
 <CAFEAcA8Sc7t25KNzwnEAi=n8SNCAYDsFbs8P8hUKwWRxWzx_QQ@mail.gmail.com>
 <1956976.W3UK9cqU4Q@silver>
In-Reply-To: <1956976.W3UK9cqU4Q@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 15:17:32 +0100
X-Gm-Features: Ac12FXzHnu29B0wZDPInhEnJ7LTueF51Z8aB7_nY_maEyq9KxafQ8nMWbyik0tA
Message-ID: <CAFEAcA93EtnZcurP4u_z5qpX4xwhCPPDPCb5uOLMin9OtpoUqg@mail.gmail.com>
Subject: Re: [PULL 7/9] tests/9p: add 'Tsetattr' request to test client
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Thu, 10 Jul 2025 at 15:11, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Thursday, July 10, 2025 3:30:22 PM CEST Peter Maydell wrote:
> > On Mon, 5 May 2025 at 10:54, Christian Schoenebeck
> > <qemu_oss@crudebyte.com> wrote:
> > >
> > > Add and implement functions to 9pfs test client for sending a 9p2000.L
> > > 'Tsetattr' request and receiving its 'Rsetattr' response counterpart.
> > >
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > Message-Id: <20250312152933.383967-6-groug@kaod.org>
> > > ---
> > >  tests/qtest/libqos/virtio-9p-client.c | 49 +++++++++++++++++++++++++++
> > >  tests/qtest/libqos/virtio-9p-client.h | 34 +++++++++++++++++++
> > >  tests/qtest/virtio-9p-test.c          |  1 +
> > >  3 files changed, 84 insertions(+)
> > >
> > > diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
> > > index 98b77db51d..6ab4501c6e 100644
> > > --- a/tests/qtest/libqos/virtio-9p-client.c
> > > +++ b/tests/qtest/libqos/virtio-9p-client.c
> > > @@ -557,6 +557,55 @@ void v9fs_rgetattr(P9Req *req, v9fs_attr *attr)
> > >      v9fs_req_free(req);
> > >  }
> > >
> > > +/*
> > > + * size[4] Tsetattr tag[2] fid[4] valid[4] mode[4] uid[4] gid[4] size[8]
> > > + *                  atime_sec[8] atime_nsec[8] mtime_sec[8] mtime_nsec[8]
> > > + */
> > > +TSetAttrRes v9fs_tsetattr(TSetAttrOpt opt)
> > > +{
> > > +    P9Req *req;
> > > +    uint32_t err;
> >
> >
> > Hi -- Coverity warns (CID 1609751) that this function
> > passes by value an argument which is a 184 byte struct.
> > Is this intentional?
>
> Hi Peter!
>
> Yes, that was intentional. It follows the same coding pattern of the 9p test
> cases to hack named function arguments into C:
>
>   someFunc({ .argC = 3, .argH = "foo", .argX = 1 });
>
> That saves a lot of code and makes callers better readable, because some test
> case just needs to pass a value for argument A and C, another test might need
> to pass arguments H, X and Y, and so on.
>
> Before we had numerous function variations for the same thing, just with
> different argument permutations. Now it's only one function per purpose.
>
> > Can we instead pass a pointer to the
> > struct?
> >
> > This is only a test program and 184 bytes is not super
> > enormous, so if this would be painful to avoid we can mark
> > the coverity report as a false positive.
>
> Well, it would be possible to change this to a pointer, patch below in any
> case. Personally I would just mark this as a false positive though. It's not a
> bug and the resulting binary would probably be identical. No hard opinion
> though.

OK, I'll mark it as a false positive.

thanks
-- PMM

