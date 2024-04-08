Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EC2C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtk1G-00007w-CD; Mon, 08 Apr 2024 04:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rtk1A-00006b-TK
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:06:18 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rtk18-0006f0-RF
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:06:16 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7e3b3e33ae2so1113454241.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 01:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712563573; x=1713168373;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiuxiaqveYBw5xy8KHGsa2gLNpLFMZqH5jitkUrw8f0=;
 b=vHks/Cc32QK98QuHgh9OLWAsf9/560yEjiT793YnLM9nkE1u9Yb8czI2ACEj0TdCVw
 n40U9ggJbNmyZGc6eQhq9UA9aYTaa9Rikb3Ec3rs3y6uBh7nFYv6X7WmaiOTOWosIudb
 o0LG+J2jb4+TBMVMurfZpc1IP0qw9q1OPqf0U5D1L1TeojxaVDLrSB9eWQNDDeXA5mdd
 hgl0eRo9PkSQ7UmjBETimtxBUMFmdDuy5C+zjg4GlsKPNwhyB/0qu6cXiovzlK8R5zJA
 JfzxY+fNfOQWw6EBwn9qJbgE/fF5oVcH37OrnWUs8GIkrykBdInoggsoAyEMesdsPhdq
 11uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712563573; x=1713168373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiuxiaqveYBw5xy8KHGsa2gLNpLFMZqH5jitkUrw8f0=;
 b=XbRjETA6/pRMnCWH7tbtDinmeDjdLdXS+lj1rLaNuLGt2cT5hqzMdTnTB58bUjg/dA
 ljE0+VI7lLiIdBut/Y0pkV8at7FaSRpTj/rDAe5lSJWeGNHsWR4xpsi4j2blyOJS0Wkd
 OWGKXxHyLsDri3H59UC+eDLKIP5XTh15wpEDfvNC660FegpT7mFkrEYBL7b9WgA8LwT/
 z3sAcCawxct0WhNzcIFinHA1gG2wPwPvUuU5dbM7aU2pkVxH3LJWXMB84CEbs/Xt0rlK
 pA5YOXbEy1cLk4JFulQ8Iwh0QWM+QHyX52UkRtmlDqMNiHA5bIYsa0qToRJu6GGNZugX
 gHdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjAXKlUJ3GKthCw7DH5CRNUiFXS6y5DNfgQsZcIUlqULJ3G9YjaQT5ek8cRJ0oeWMYhBFibvKjf165cKwty0nMtugW3lA=
X-Gm-Message-State: AOJu0YyfhEbKvxo4sYAzo19qlNRB4A2Ah5E+pD6s3S1xGHT0YhXEENWG
 mRGQU1CKCjESMxo6ocQrYPtDRY8Tx2dvuQBqELF1hfZg02KcAm5JF4NRGmw0pYBr9jS+fxT7Jpu
 iJ+u9qCPfHtO+p2gKJES2qzUU1dd6yGdtfHijRQ==
X-Google-Smtp-Source: AGHT+IE8z/wClf4ROoRCHME3Ue8QPrKfg1voqPgcS3m7o18NgL9Zt1Twofc73uX6z46kPE0i0KymIYgzbYuMYEEP0Jo=
X-Received: by 2002:a05:6102:3c90:b0:47a:6c2:e5a4 with SMTP id
 c16-20020a0561023c9000b0047a06c2e5a4mr918786vsv.17.1712563573110; Mon, 08 Apr
 2024 01:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-16-c6d87e69d38b@daynix.com>
 <CAOEp5Od=KUTHnikVBA7iWfdFPJ=T7hbJrSu4zwCiB_Q1P-Sz+Q@mail.gmail.com>
 <8010b335-4b46-456e-bf6e-c191cdc34964@daynix.com>
 <CAOEp5OeHJR=EeZ=yLovSD9vUPt-zRNKLo2k_fNZPP3W-eX4Fiw@mail.gmail.com>
 <d2213191-9b16-4716-a311-97751ba670ad@daynix.com>
 <CAOEp5OcNkBr4aRzjFQhgsOTmMmO3aPQH2tQLvGcs__=jUVa5sA@mail.gmail.com>
 <ad692cbf-1963-4051-9b24-50c3599c3f7f@daynix.com>
In-Reply-To: <ad692cbf-1963-4051-9b24-50c3599c3f7f@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 8 Apr 2024 11:06:02 +0300
Message-ID: <CAOEp5OeNHRdvJ7U2TFs4ZQaNFZHzDg5+_84AfLfb2kDFrfYPGg@mail.gmail.com>
Subject: Re: [PATCH v9 16/20] virtio-net: Do not write hashes to peer buffer
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::92a;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 8, 2024 at 10:57=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/04/08 16:54, Yuri Benditovich wrote:
> > On Mon, Apr 8, 2024 at 10:42=E2=80=AFAM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2024/04/08 16:40, Yuri Benditovich wrote:
> >>> On Mon, Apr 8, 2024 at 4:30=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> On 2024/04/08 7:09, Yuri Benditovich wrote:
> >>>>> On Wed, Apr 3, 2024 at 2:12=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>>>
> >>>>>> The peer buffer is qualified with const and not meant to be modifi=
ed.
> >>>>>
> >>>>> IMHO, this buffer is not so 'const' (although the prototype states =
so),
> >>>>> it is allocated in net.c
> >>>>> btw, another procedure in this file also modifies the buffer
> >>>>> (work_around_broken_dhclient)
> >>>>
> >>>> Right but it has a FIXME comment.
> >>>>
> >>>>>
> >>>>>> It also prevents enabling VIRTIO_NET_F_HASH_REPORT for peers witho=
ut
> >>>>>> virtio-net header support.
> >>>>>
> >>>>> Does it mean _this commit_ prevents enabling VIRTIO_NET_F_HASH_REPO=
RT
> >>>>> for peers without
> >>>>> virtio-net header support? Where?
> >>>>
> >>>> No, but I meant that this patch fixes such a problem.
> >>>
> >>> No, it does not. Such a problem does not exist in the master, the
> >>> hash_report feature
> >>> is silently dropped in such case:
> >>> https://github.com/qemu/qemu/blob/master/hw/net/virtio-net.c#L816
> >>
> >> Well, silently dropping VIRTIO_NET_F_HASH_REPORT is not different from
> >> preventing enabling VIRTIO_NET_F_HASH_REPORT, is it?
> >>
> > But how is your patch involved in it? Should this line be removed from
> > the commit message?
>
> In the master, VIRTIO_NET_F_HASH_REPORT is silently dropped, but this
> patch will change to work without dropping it, which is worth to mention.
After applying this series of patches the VIRTIO_NET_F_HASH_REPORT is
dropped _the same way_ as in the master
>
> Regards,
> Akihiko Odaki

