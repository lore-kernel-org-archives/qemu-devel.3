Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3C0C6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 17:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnLlY-00068H-TV; Thu, 21 Mar 2024 12:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rnLlW-00067n-Ps
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:59:42 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rnLlV-0002cx-2q
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:59:42 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-222ba2a19bdso698947fac.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711040380; x=1711645180; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvltbHtxnGPKJomEjS9/8uZca9RxiIuHjuGvHnW0uwk=;
 b=nioOSo8FzuDfctKJ4FgRCLZmXMB73dN6csZcej3FE/WWPB97dj2HamV9enYCHRJJ9L
 lqfTolcWdKdZJLBiykGQmajNhGgeaK3Gjkz2ViXMvVrzs+xC0WcRKi1ivvPi48r05quD
 SE+2mzsbwhR8Z4EdifJ+ow72vkb7iqQYpJZCHFehgVUASkytY+J6yQL2lXXXR4R31n1h
 66iJPdWVAe3h80tiqFLXKX8Z/gUEZtejcXm3PxXIoj7TfjjPyrgx1hbbhvip4jEIW3t6
 R679K8gzCCu1musQEW9k/8qnZTpUG69jhTuMKmC23XPpqKzfWctwK+We5I95SE+xyW8q
 hCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711040380; x=1711645180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvltbHtxnGPKJomEjS9/8uZca9RxiIuHjuGvHnW0uwk=;
 b=rq3PVutpJCgW1dLXoW/3gsiwct3X6DoXJAM5vRrxqPCwOhpOE57iCBfXdNsPHkIBV5
 pcWx2da1DGPKTDlMM19ZXwDnImoc3y1Ikm1iKgOt2pFw5WQN3RhtpYqYdmNB+KJSHYiT
 CGyU0WS4p60UPLDg5qLvNSLAM9TaoYjv54fvsX00ivmL8EZhYEsWFRuBrpY+AHUEHf1u
 TCZPgpdgqwrxx8vwDGUbBvEe/dT025mOZrmLfYeR3iqN0zf/LnRNbBeLjCyyH+kVfHgC
 SNSatYwMtk1/SVyrNEffuV+lNbPM3bL2T4DCXwRoA1VcSzL+MRVcL1eXt6Fo5TaThvyD
 DNag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSeW/LMYME2+Jg4LNoJfHaRhZV4mzQhCEEkb9p1OumYdBwT/7QbRZOLcYfcdODS6sQptIw2mF9Y082GQQbVHW5E1PR6nA=
X-Gm-Message-State: AOJu0Yyn2P/lRUtkU+2+7mFyJWpeIMxMImouIZXpU0LB4SWi4wVVSJP/
 L+lc3nyTe9/1cGFObWt1ZKtTWGF40OLt0mkzUrPWr0Mvo0F3EAYmuuSud83U1abUQqwdemeoDsr
 FwdSLxioB+PBmfbBSPpE030ZnACc=
X-Google-Smtp-Source: AGHT+IEGxpkEuYT1ioubNQ0vterEiuU4fLdw7/dglh2E/IWjOpMGXEb2idWJVSF/wXaCTgpQOSHpNrmB0pOhB63Y4B8=
X-Received: by 2002:a05:6871:28c:b0:222:bbb5:83f5 with SMTP id
 i12-20020a056871028c00b00222bbb583f5mr2863205oae.46.1711040379487; Thu, 21
 Mar 2024 09:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240318183429.1039340-1-stefanha@redhat.com>
 <ZfmWhDaG5mN-GCeO@redhat.com>
 <20240319175510.GA1127203@fedora> <ZfnxSd4lseZuWoQ5@redhat.com>
 <20240320133539.GA1190824@fedora> <ZfruHHh9tEr-1zI6@redhat.com>
 <ZfwmWmwI_ApQSdNi@redhat.com>
In-Reply-To: <ZfwmWmwI_ApQSdNi@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 21 Mar 2024 12:59:26 -0400
Message-ID: <CAJSP0QVLt5ESXPOLF3XqPe_JBGnADgbjhX0nPfPs3WffZhQ9gg@mail.gmail.com>
Subject: Re: [PATCH] coroutine: cap per-thread local pool size
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Sanjay Rao <srao@redhat.com>, 
 Boaz Ben Shabat <bbenshab@redhat.com>, Joe Mario <jmario@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, 21 Mar 2024 at 08:22, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 20.03.2024 um 15:09 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Wed, Mar 20, 2024 at 09:35:39AM -0400, Stefan Hajnoczi wrote:
> > > On Tue, Mar 19, 2024 at 08:10:49PM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> > > > On Tue, Mar 19, 2024 at 01:55:10PM -0400, Stefan Hajnoczi wrote:
> > > > > On Tue, Mar 19, 2024 at 01:43:32PM +0000, Daniel P. Berrang=C3=A9=
 wrote:
> > > > > > On Mon, Mar 18, 2024 at 02:34:29PM -0400, Stefan Hajnoczi wrote=
:
> > > > > > > diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> > > > > > > index 5fd2dbaf8b..2790959eaf 100644
> > > > > > > --- a/util/qemu-coroutine.c
> > > > > > > +++ b/util/qemu-coroutine.c
> > > > > >
> > > > > > > +static unsigned int get_global_pool_hard_max_size(void)
> > > > > > > +{
> > > > > > > +#ifdef __linux__
> > > > > > > +    g_autofree char *contents =3D NULL;
> > > > > > > +    int max_map_count;
> > > > > > > +
> > > > > > > +    /*
> > > > > > > +     * Linux processes can have up to max_map_count virtual =
memory areas
> > > > > > > +     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM be=
yond this limit. We
> > > > > > > +     * must limit the coroutine pool to a safe size to avoid=
 running out of
> > > > > > > +     * VMAs.
> > > > > > > +     */
> > > > > > > +    if (g_file_get_contents("/proc/sys/vm/max_map_count", &c=
ontents, NULL,
> > > > > > > +                            NULL) &&
> > > > > > > +        qemu_strtoi(contents, NULL, 10, &max_map_count) =3D=
=3D 0) {
> > > > > > > +        /*
> > > > > > > +         * This is a conservative upper bound that avoids ex=
ceeding
> > > > > > > +         * max_map_count. Leave half for non-coroutine users=
 like library
> > > > > > > +         * dependencies, vhost-user, etc. Each coroutine tak=
es up 2 VMAs so
> > > > > > > +         * halve the amount again.
> > > >
> > > > Leaving half for loaded libraries, etc is quite conservative
> > > > if max_map_count is the small-ish 64k default.
> > > >
> > > > That reservation could perhaps a fixed number like 5,000 ?
> > >
> > > While I don't want QEMU to abort, once this heuristic is in the code =
it
> > > will be scary to make it more optimistic and we may never change it. =
So
> > > now is the best time to try 5,000.
> > >
> > > I'll send a follow-up patch that reserves 5,000 mappings. If that tur=
ns
> > > out to be too optimistic we can increase the reservation.
> >
> > BTW, I suggested 5,000, because I looked at a few QEM processes I have
> > running on Fedora and saw just under 1,000 lines in /proc/$PID/maps,
> > of which only a subset is library mappings. So multiplying that x5 felt
> > like a fairly generous overhead for more complex build configurations.
>
> On my system, the boring desktop VM with no special hardware or other
> advanced configuration takes ~1500 mappings, most of which are
> libraries. I'm not concerned about the library mappings, it's unlikely
> that we'll double the number of libraries soon.
>
> But I'm not sure about dynamic mappings outside of coroutines, maybe
> when enabling features my simple desktop VM doesn't even use at all. If
> we're sure that nothing else uses any number worth mentioning, fine with
> me. But I couldn't tell.
>
> Staying the area we know reasonably well, how many libblkio bounce
> buffers could be in use at the same time? I think each one is an
> individual mmap(), right?

libblkio's mapping requirements are similar to vhost-user. There is
one general-purpose bounce buffer mapping plus a mapping for each QEMU
RAMBlock. That means the number of in-flight I/Os does not directly
influence the number of mappings.

Stefan

