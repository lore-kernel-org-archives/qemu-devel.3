Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0679C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 18:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTmMG-0001KP-Q4; Mon, 23 Jun 2025 14:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uTmMB-0001J3-BO
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 14:57:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uTmM7-0003SP-IM
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 14:57:25 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-607cc1a2bd8so6866818a12.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750705042; x=1751309842; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IePmnhFWPzfq70LYD7TQTuQEBHLP9rp9SgpYyu0g/4I=;
 b=OS0CULiCxgkuKpr7lfmumBi6EO71Pqs1CoHp7qCYAnSvJBK+ubikRwewRpOMPuumN/
 FZe1fhoCW8P3q5GWB3G9tZT4a66X2Npk0fytWjnCMsALrNTOzYjTv060exojm/1vzV1y
 oiYaJkpA7yhITtezThkx0oQ/BzyJjqKltLGOjfybtQPZ6m6utZGdWnIY8xHZ9xvfeHO7
 8WaqAOYV0c5m6iaJninACt6KqPk7dmRxN/6ThQ53n9JC6PCc/tPFsHumy3EqLN9VdRvh
 /sCpQVyfCHVtVUHecVFgZnVtPJ5jfyXTdYU42mirm0flKqc9vL7L6YPsTNbn8dtefOdy
 qgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750705042; x=1751309842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IePmnhFWPzfq70LYD7TQTuQEBHLP9rp9SgpYyu0g/4I=;
 b=QOAmYttsBgqHcMjTAT+4rJdzzo+5pt1G9CGES9KNkxg70oeMY88SrRYGrFMRZIdQJ/
 aTazGPfI89D1PdWYiKlxCco8TNgdlspuxkqpzTkMjIG4G7+9yWg3AlcXIPojeZme18DR
 rrXvo34TyBL6EOOnHtvHTeixr0Pu+OUlZ4td0Z8+UmbnVvqplJZeMzD8mUOdGqlKJzgR
 9MYEOCEwaZvlTmLJ7+wKjM8e+79mdLHME7R+LNd5WrR0q4YbChm+40P+3pc2QOvu9ZEx
 rztUAR9GSsldzUemJmESuXrVhbIDMXG9bvO+Dc3tA8Jvcb8zcnY1OUTRcQjvGKSNIvJc
 3jaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2+CnjiGe0EBt0vCLxCLCTtqRrdKEsHXuMLIMbvhL6lsG5x8gcWLqHj/AxtKuUilwvAN8QOdbgRBEm@nongnu.org
X-Gm-Message-State: AOJu0YypLUTjnez/sStQOobfEAGoI5YY0zuJkuogZ5gja6XLvd9ICi8D
 imCVowLB0vYeA766bUdotRH96fbIZ2uYKAm96j9uMGK7JWj/OkCrQEsd9HEdwVvUxfoAc/HJT7O
 FOHynnpOwkdl6LQlcbFin1Zc0b5iuzvI=
X-Gm-Gg: ASbGncvILUkQxfqfl03HwLWZpxvYfRqI92OurV3EfJJrocv7Wa22qyH1g2opBX/jxtw
 66LuivuEu3QUbe1YVVW6kDqtMn8Hm1w42c2Pk0eYNMy0bV4xM0/kmRgOw72SKydm6T8vb9WgT1w
 g2LKegwblwx6AHvR1R7MIJCu+pd9JgP2vzRDxlAveNuA==
X-Google-Smtp-Source: AGHT+IER0Kq4o15DIo2Kht0Je1loxzol3aJ1FjSntSWDqGbeQRbHlsmSvjUuKrRmJy69UnlU8+LbKqtP81g1duXaUCE=
X-Received: by 2002:a05:6402:2692:b0:604:a869:67e9 with SMTP id
 4fb4d7f45d1cf-60a1cd2bdd5mr13254267a12.22.1750705041972; Mon, 23 Jun 2025
 11:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250620164053.579416-1-pbonzini@redhat.com>
 <20250620164053.579416-25-pbonzini@redhat.com>
 <b8171c39-6a92-4078-a59a-a63d7452e1e9@kaod.org>
 <4ffdb62b-8fe4-4b34-9efa-aecff7f8e77b@intel.com>
 <aFkKL-TQTcrBtXuK@redhat.com>
 <CAJSP0QUgirgNX71MwGgYbdDhVUrd3MWsetx66_+GsER8BfoSbg@mail.gmail.com>
 <aFlR6CTLRzSpS1fr@redhat.com>
In-Reply-To: <aFlR6CTLRzSpS1fr@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 23 Jun 2025 14:57:09 -0400
X-Gm-Features: AX0GCFsi_MTZBVOxjtkB3HS5PlSAa98W4GH3s18uI3imZaaRa4fVP9OT4_CtqkI
Message-ID: <CAJSP0QUVuXRK9nyXw=HcEV6Qi5HaE+TzVp1QOiGp7c7pX=Z=Hw@mail.gmail.com>
Subject: Re: [PULL 24/24] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
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

On Mon, Jun 23, 2025 at 9:09=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Jun 23, 2025 at 09:04:33AM -0400, Stefan Hajnoczi wrote:
> > On Mon, Jun 23, 2025 at 4:04=E2=80=AFAM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > On Mon, Jun 23, 2025 at 03:03:19PM +0800, Xiaoyao Li wrote:
> > > > On 6/23/2025 2:43 PM, C=C3=A9dric Le Goater wrote:
> > > > > Hello,
> > > > >
> > > > > On 6/20/25 18:40, Paolo Bonzini wrote:
> > > > > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > > > > >
> > > > > > Add property "quote-generation-socket" to tdx-guest, which is a=
 property
> > > > > > of type SocketAddress to specify Quote Generation Service(QGS).
> > > > > >
> > > > > > On request of GetQuote, it connects to the QGS socket, read req=
uest
> > > > > > data from shared guest memory, send the request data to the QGS=
,
> > > > > > and store the response into shared guest memory, at last notify
> > > > > > TD guest by interrupt.
> > > > > >
> > > > > > command line example:
> > > > > >    qemu-system-x86_64 \
> > > > > >      -object '{"qom-type":"tdx-guest","id":"tdx0","quote-genera=
tion-
> > > > > > socket":{"type":"unix", "path":"/var/run/tdx-qgs/qgs.socket"}}'=
 \
> > > > > >      -machine confidential-guest-support=3Dtdx0
> > > > > >
> > > > > > Note, above example uses the unix socket. It can be other types=
,
> > > > > > like vsock,
> > > > > > which depends on the implementation of QGS.
> > > > > >
> > > > > > To avoid no response from QGS server, setup a timer for the tra=
nsaction.
> > > > > > If timeout, make it an error and interrupt guest. Define the th=
reshold of
> > > > > > time to 30s at present, maybe change to other value if not appr=
opriate.
> > > > > >
> > > > > > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > > > > > Co-developed-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > > > > > Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > > > > > Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > > > Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > > > > ---
> > > > > >   qapi/qom.json                         |   8 +-
> > > > > >   target/i386/kvm/tdx-quote-generator.h |  82 +++++++
> > > > > >   target/i386/kvm/tdx.h                 |  10 +
> > > > > >   target/i386/kvm/kvm.c                 |   3 +
> > > > > >   target/i386/kvm/tdx-quote-generator.c | 300 +++++++++++++++++=
+++++++++
> > > > > >   target/i386/kvm/tdx-stub.c            |   4 +
> > > > > >   target/i386/kvm/tdx.c                 | 176 ++++++++++++++-
> > > > > >   target/i386/kvm/meson.build           |   2 +-
> > > > > >   8 files changed, 582 insertions(+), 3 deletions(-)
> > > > > >   create mode 100644 target/i386/kvm/tdx-quote-generator.h
> > > > > >   create mode 100644 target/i386/kvm/tdx-quote-generator.c
> > > > >
> > > > > These changes broke the build on 32-bit host.
> > > > >
> > > > > Could you please send a patch to avoid compiling TDX in such envi=
ronment ?
> > > >
> > > > Paolo is on vacation.
> > > >
> > > > I would like to help, but I don't have 32-bit host environment on h=
and. Do
> > > > you know how to set up such environment quickly? (I tried to set up=
 within a
> > > > 32-bit VM but the 32-bit OS is too old and I didn't get it work to =
install
> > > > the required package for building QEMU)
> > >
> > > You should be able to use QEMU's docker containers to get yourself a
> > > Debian i386 container, on a x86_64 host.
> >
> > The cross-i686-system (Debian) build CI job succeeded:
> > https://gitlab.com/qemu-project/qemu/-/jobs/10423776600
> >
> > I wonder why the CI didn't catch the issue?
>
> It didn't build the x86_64 target:
>
>   --target-list-exclude=3D"arm-softmmu i386-softmmu microblaze-softmmu mi=
ps-softmmu mipsel-softmmu mips64-softmmu ppc-softmmu riscv32-softmmu sh4-so=
ftmmu sparc-softmmu xtensa-softmmu $CROSS_SKIP_TARGETS"
>
> so in turn didn't build any TDX code

Here are the targets that were built by the CI job:

  target list : avr-softmmu m68k-softmmu microblazeel-softmmu
or1k-softmmu rx-softmmu sh4eb-softmmu tricore-softmmu xtensaeb-softmmu

64-bit targets are not supported on 32-bit hosts since commit
acce728cbc6c ("meson: Disallow 64-bit on 32-bit emulation"). I don't
think the x86_64 target can be built on 32-bit hosts.

But notice that i386-softmmu is missing from the target list. That
could be why the CI job succeeded.

C=C3=A9dric: What were your ./configure options?

Stefan

>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

