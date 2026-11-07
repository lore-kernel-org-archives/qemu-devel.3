Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8FC606A326
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XI+Pa21P;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QE2oywDw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPldU-0004kQ-9I; Sat, 07 Nov 2026 13:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xPldR-0004jt-Q6
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 13:59:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xPldP-0006Ay-Ib
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 13:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794077965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brdtO5vmQW9ZlpJkab/dXkzfDbmp0tHTx9nBzbRRF4s=;
 b=XI+Pa21PXt/PeEIajnVMsDiAxMK/srXt+MFlZj3kZzJoT1Iz7u07Ye69UJRUeLfl3lCxB/
 v55fllOsOnqwQwvWolPLr9FCrReGe9cixT46sY53/OJ2ty5cXI0bhvX5DFXFbcI+q0qXEC
 wEFXbVEDPK6rqWZQuzpb2u+RbmdlfUQ=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-Wti4EP41MNuS0nkYwIBgAw-1; Sat, 07 Nov 2026 13:59:24 -0500
X-MC-Unique: Wti4EP41MNuS0nkYwIBgAw-1
X-Mimecast-MFC-AGG-ID: Wti4EP41MNuS0nkYwIBgAw_1794077964
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-6756044f260so1240386d50.0
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2026 10:59:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794077964; cv=none;
 d=google.com; s=arc-20260327;
 b=j0EEMMfNTGhqAiY4IZAGruGaD927tdq4drAToIKsoBdYFahuRFSMd1kfdYTBC8BMma
 XoHg3WPbDzZUSWMeXx8ZUDnIAtyvAOUTnb8BcZBKkC3rNP8B8M3Qd3QQNPFuFBRF2GeQ
 l0SwEYSeoSx24tKwNZzfL4XdNEusU2J7xmBEwIXeX2KSGaQKjtfT8ZhpDL/9V4d/trnD
 TgLWYOtnpW/KglQ5PRv7l7vxxIn0mkzDeCauhHS08DXSeBzJWd7bHe/hmeJR4j5IsKqR
 og0kSaAqVK2S1xBQRb2QZ4aMQJBlbH+56kAMEC4uElrWuD97L3zEw5RNGILtlega7C5C
 7sEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=brdtO5vmQW9ZlpJkab/dXkzfDbmp0tHTx9nBzbRRF4s=;
 fh=y8VSIZOGF1XQ3e5EZm3FE12GzDQpPOxOsgYEJ9MNHYk=;
 b=dFUWf5cogIDEnExByeWDlni+gejHtNvcW8W4svERDKOEoXDXH1QDVF5VMdWJkQbcDS
 NIuWFJnBmKWi1TmyAjCNbQL4hhGruE+Ef3HDax1EdGRoRXpwpI4xwZN2Phk8Dldgllmo
 90SPUqA0zZSuhIV9C24ITKfj2ukmma+i5YdaYT9ih4W8fk2112CJUH4WaQVgdkC4Hwrl
 Teu812P/d0w2wAFILsFCaYtNAbCv9K+NB49ISbwFrIx2tJnPEkKy/DF0BlpG6baHXph7
 KBDzjbIyuWvOAFsnmOfwmG3RrQdTtoppbgvEOKplu+Bpi5NFOPuIoElXoL1C227FeL1z
 5vWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794077964; x=1794682764; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=brdtO5vmQW9ZlpJkab/dXkzfDbmp0tHTx9nBzbRRF4s=;
 b=QE2oywDwlfzoiBz0+Kppp2tinIgVlHQRcnzv/8DpPCPrP0NvBo5yXuRMdSXuBx5KBG
 xbfe8L/+hi1SHQ57bMME9rd4T6GO3zgssODDiPA9TsNN9l3yygp6dMc8pGO/OLeUc4bJ
 e/YVWQ3eYVSQ67h1jZFPPfDzieYFICfObrJXJCkN/jgsmd0DoFF8r24G2Ky1xYPR6dBQ
 C3AmddY/d/nMEgt73ZyPJpVGh6ZgCDYuumALyiBEbIv+h0QCy+ZKKOMdW+vMviCSo/vu
 4BXbXwWwa+6YsDlx6bGZKWejPKQLQE7ZI023mh7MNsU9llFxX9beicQHqprGMtwK4VUZ
 WZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794077964; x=1794682764;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=brdtO5vmQW9ZlpJkab/dXkzfDbmp0tHTx9nBzbRRF4s=;
 b=c5Kc3QWlvRhAID2AvjIDtMbgjMClTHQ7D4yKUqKAnJK+u0BwDjE8XJ0+O/naOSPMsj
 CsPkI3ytk7V+ZrTotN/R8zkh0C9ZTRj/Uci8V9aRzSeoN1G6W9p6d4JuWpdm55xJNMHc
 UMC0Z90d5CBB61kpmntZx+dKW5pRy9lo4CH0u3JmVU6eHxrbeKvrNg2ufzIHHi7ATKHW
 nRv2Y5IBcIkWEDXiF8jMKVE8HN98UqInXoe6ZbW3D7/NyvMcz1qdQSneNl+aJj1WnbdR
 WmZjAR8y1xSAqSq27VlVzgtIIgJOmmbC/W7HkdM7/UtrjR14n9X7Ccx9TKhW/5oJHusl
 Xw3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHcTWWFyAPd1IxUaSJk/jKi+MhrRtEtLd3k90oHwI75PAdfV0akIIg+deGmXkQFLpVQCkWFvKY2TnT3@nongnu.org
X-Gm-Message-State: APuU4Z87p/EwA90HgHeLgj/zVqK4VeY6N3lnvkcj4jWM20QqmlZjPWmw
 CVruekIvLAdvCr/dr9FfBA5NXJhfx53V3rMvx7/cJhybOHrk9J8spGuq9wfmBA5ff8vmBoREa/Y
 wJZLxy1zLjRJ/wHyhQYdcYKARWQxqnomPpQXoYmBdiRxpXkl5pgWZgfyjIUzEpUY5862uFnHe29
 zMfKoYEs+U43ac80sh67hKtf1AyNJCYV0=
X-Gm-Gg: AYBFou3tNFW6GEpduajtKr53m86mrVOzHiIkEn86ws/uyYShVSkkxsOH0GSvUhe0UlJ
 gazcPX7X+RoqNH79SwFWnXzOKHwFzJw+DJvtBQNObnx1sOU5ExYkdG5/PpwMH8FsYhbd4p14wLP
 bVZYxbUZnRt9woWQwC4XX/TOHZJ78NgacnzrO1QP6O2/bLDeImq+ZCu7gu/dQa/yeFdj3rt+xFr
 2I6/hS6dfsOJ+zn
X-Received: by 2002:a05:690e:11cb:b0:677:eb7b:c701 with SMTP id
 956f58d0204a3-67c29d44916mr1443715d50.39.1794077963546; 
 Sat, 07 Nov 2026 10:59:23 -0800 (PST)
X-Received: by 2002:a05:690e:11cb:b0:677:eb7b:c701 with SMTP id
 956f58d0204a3-67c29d44916mr1443705d50.39.1794077963049; Sat, 07 Nov 2026
 10:59:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021063105.102520-1-kraxel@redhat.com>
 <CAFn=p-anhY5nzcjqeVjqvmVkbi1c3=SeUYxJoFqDhCXmbRM4VA@mail.gmail.com>
 <CAFn=p-ZKX81fjQH8OdGAq7ErJ9bc2BsLtn2jEicUmgwWdjQYEA@mail.gmail.com>
 <20261107081647-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261107081647-mutt-send-email-mst@kernel.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 7 Nov 2026 13:59:12 -0500
X-Gm-Features: AclHuK_czdV2CcAtYC2R0249v_gttg3h1GhK63OBgrYwAQmkCVlhFHwDO-eNgxk
Message-ID: <CAFn=p-bjiXj_0FPLHAiFdQRzUkHTfAxkRE6cKM4pRhANND3hgQ@mail.gmail.com>
Subject: Re: [PATCH] x86: mmap kernel for direct kernel boot
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 7, 2026 at 8:24=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Nov 06, 2026 at 01:02:33PM -0500, John Snow wrote:
> > On Wed, Oct 21, 2026 at 12:02=E2=80=AFPM John Snow <jsnow@redhat.com> w=
rote:
> > >
> > > On Wed, Oct 21, 2026 at 2:31=E2=80=AFAM Gerd Hoffmann <kraxel@redhat.=
com> wrote:
> > > >
> > > > Reduce memory footprint by mapping the kernel into memory instead o=
f
> > > > reading into allocated memory in the common case (no -dtb $file on =
the
> > > > qemu command line).
> > > >
> > > > Cc: John Snow <jsnow@redhat.com>
> > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > >
> > > Tested-by: John Snow <jsnow@redhat.com>
> > >
> >
> > Ping, is someone going to pick up this patch?
> >
> > --js
>
> First we are in freeze. So no rush.

Patch was on-list well before freeze.

> Here's some ai based review - the arguments make sense to me.
>
> 1. No length validation on the mapping. kernel_size comes from
> get_file_size() (fstat at open time), but the patch never checks
> g_mapped_file_get_length() =3D=3D kernel_size. If the file shrinks betwee=
n
> the stat and the mmap (or is a weird file), you get an OOB read / SIGBUS
> instead of the old clean fread() failed exit. Further, if the
> file is truncated later (QEMU running, guest hasn't read the kernel
> through fw_cfg yet), guest reads hit SIGBUS and kill QEMU. fread copies
> up front, so this race didn't exist before.

Looks like we do use this function when loading the initrd, easy
enough to fix here.

>
> 2. Files that are readable but not mappable. fread works on anything
> stdio can read; mmap fails on some FUSE mounts, files with outstanding
> mandatory/lease locks, etc. g_mapped_file_new failing exits QEMU, so a
> previously booting config on such a filesystem stops booting.
>
> 3. Windows share modes. stdio fopen("rb") opens with permissive sharing,
> while gio's file mapping opens the file with a more restrictive share
> mode. A kernel image that another process still holds open for writing
> (download in progress, installer, antivirus scanning with exclusive
> handle) currently boots and would now fail to map. Windows is a
> supported platform, so this counts.

OK, if 2 and 3 are valid, it sounds like we just want a fallback to
fread. Mind you, we already use this technique for initrd images, so I
don't think we are doing anything fundamentally wacky here that QEMU
doesn't already do.

>
> 4. Torn reads on concurrent modification. With fread you snapshot the
> file once; with a private mapping, pages faulted after an external write
> see new content, so a guest could get a mix of old and new kernel bytes.
> Only matters for someone rewriting the image under a running QEMU, which
> is already dubious.

I wouldn't worry about this; it's the same as "Well, what if you
modify a .qcow2 under a running QEMU?" Well, don't do that.

>
>
> I would not worry about torn reads too much. But failure seems
> theoretically legit.  It's hard to know this does not break any existing
> configs.  It might be safer to just add an option.

I think matching initrd loading behavior is all the justification we
need for treating the kernel identically.

>
> Also, pls include the observed gain in the commit log.

Observed gain is that if you are loading a 19 MiB kernel, this change
allows that memory to be mapped and allocated as RssFile memory
instead of RssAnon memory. This means that if you run multiple QEMU
instances using the same kernel, that memory is shared and excluded
from USS instead of being charged per-instance.

>
>
> > > Using this patch, I shifted about 19MiB of resources from RssAnon to
> > > RssFile. This theoretically allows sharing resources between multiple
> > > QEMU instances in the trivial case using -kernel and -initrd. This
> > > matches how we already load initrd.
> > >
> > > --js
> > >
> > > > ---
> > > >  hw/i386/x86-common.c | 25 ++++++++++++++++++++-----
> > > >  1 file changed, 20 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> > > > index fa18bf1aeceb..25e141aa8537 100644
> > > > --- a/hw/i386/x86-common.c
> > > > +++ b/hw/i386/x86-common.c
> > > > @@ -911,16 +911,31 @@ void x86_load_linux(X86MachineState *x86ms,
> > > >      }
> > > >
> > > >      setup  =3D g_malloc(setup_size);
> > > > -    kernel =3D g_malloc(kernel_size);
> > > >      fseek(f, 0, SEEK_SET);
> > > >      if (fread(setup, 1, setup_size, f) !=3D setup_size) {
> > > >          fprintf(stderr, "fread() failed\n");
> > > >          exit(1);
> > > >      }
> > > > -    fseek(f, 0, SEEK_SET);
> > > > -    if (fread(kernel, 1, kernel_size, f) !=3D kernel_size) {
> > > > -        fprintf(stderr, "fread() failed\n");
> > > > -        exit(1);
> > > > +    if (dtb_filename) {
> > > > +        /* read kernel into allocated memory, so we can realloc fo=
r the dtb */
> > > > +        kernel =3D g_malloc(kernel_size);
> > > > +        fseek(f, 0, SEEK_SET);
> > > > +        if (fread(kernel, 1, kernel_size, f) !=3D kernel_size) {
> > > > +            fprintf(stderr, "fread() failed\n");
> > > > +            exit(1);
> > > > +        }
> > > > +    } else {
> > > > +        /* mmap kernel */
> > > > +        GMappedFile *mapped_file;
> > > > +        GError *gerr =3D NULL;
> > > > +
> > > > +        mapped_file =3D g_mapped_file_new(kernel_filename, false, =
&gerr);
> > > > +        if (!mapped_file) {
> > > > +            fprintf(stderr, "qemu: error reading kernel %s: %s\n",
> > > > +                    kernel_filename, gerr->message);
> > > > +            exit(1);
> > > > +        }
> > > > +        kernel =3D (uint8_t *)g_mapped_file_get_contents(mapped_fi=
le);
> > > >      }
> > > >      fclose(f);
> > > >
> > > > --
> > > > 2.56.0
> > > >
>


