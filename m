Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7D6CAC5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyurJ-0007ej-2I; Wed, 17 Sep 2025 12:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1uyurE-0007dm-Eh
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:18:12 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1uyurC-000158-9g
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:18:12 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-424195ca4e6so235995ab.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758125889; x=1758730689; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KkSRrD2Vhi7UUxEnEGAuJ1qBlHEHh+ZdL1mQ/DECAU=;
 b=niUnkzo1KbiCniyfFQdi6oZqc2nGYsv/0u/l6uCQ/dTxLkXx9V8hyAHQVjTQGrFKvO
 zhmqXaA/44T1A4YbpAjVnWa5jEKvDaQodLN4/BeUHmuKmbq/2A8XGNR6cjOepq1hFL5R
 r0zvMnZcY8JI8pJ1+RS9B/BBPzmUSwI2QhLRIEbqfidi0fflT8HAQJL6MyWdLlavThjT
 knKNcpouP2XLeClvBzC3CXk7WlWWjOTnR/6HwMUhoBTci6bILexOYh4wk9XzIpKIwU1j
 ekt7l9PwOwQcYIn/02J3q1/XcKaXpdlH+WWJGnBKdqQ1PS8pWxEAywL33Du3Iip4ciUo
 zRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758125889; x=1758730689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7KkSRrD2Vhi7UUxEnEGAuJ1qBlHEHh+ZdL1mQ/DECAU=;
 b=bSgTOE/sVzH3FbCBUi9q/5mJGW0HPEFsITBJsRTwKZW53fyRHcwPAwsR7r2ekTOWWw
 V9q2KxDcujWkAFRQx6vEwHu3Kjz0XmxwmYR4Pm/1CMfSrXnrU71W7U92HgqDZ8C5HWah
 YnFkWfWbxrmeI29e3nnLZAWo4FLybkJtBJ1m2iHCkfOkk/QeGywiUh6LstjuF/RsH7DK
 MY+tlh6TXWNlGdmqN47FX7a5D910ubBxaOl2TfjtxF8cjHYuI1NRQ/t+SWPSP4skfz0Q
 d2xam+nO2fNNF4gJRo/Hu3lkuHK85wRjY5nwRS4R4SzGpqXqO/g5RWxlNfdRliHkfhWs
 JL3g==
X-Gm-Message-State: AOJu0YxKvCRUX8rUorcbyUFRb92SkiTK8TUcuoQtWELpAwcNBfMcaeM+
 4oahfc0liKhlcX9ELeqitVfHhqYsJMNXKOOgV8z/x4/49HpKTY8XCNT/+Veg2d6kUxkHTVCvRjt
 sxH9Jz5vk4pa7T018/xIH2rOD+BMoDaEAP73Xa+00
X-Gm-Gg: ASbGnctrG+R9VCNIfZAshr72UcjC5wG1y7+jx7PeUnVtxuEFiIfQSmyvMQthfAAiEky
 MSQvn6hij76FmRJCOPPTgp59hyYyUI9du4Mf8mtIpx/msUiNlOK8bQwpmgyYAgBX/1oP6HHckh5
 AnyefVAln3Ljbcb1OdifqVWZshya/Ihz3XIoH3CDCZvf1psAtAvLf9nLLFhpmMuxBiEYS9slcdl
 788nn/+4Z0I8Z6gVi3JKy0tgFQtOVqv94EekXoXNGyqhGMfApAKMXI=
X-Google-Smtp-Source: AGHT+IH1dPXZsUbN9ZIeZYflY44WCPUMCicqhBxPtNfY8r5EPIMeZl6G5stSiPTJ3RPsUg1MB5DW1Dze2tBFNj4l+Fw=
X-Received: by 2002:a05:6e02:1aa1:b0:423:fabc:67b3 with SMTP id
 e9e14a558f8ab-4241973f96cmr6685245ab.17.1758125888434; Wed, 17 Sep 2025
 09:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250916165928.10048-1-nabihestefan@google.com>
 <aMp-MzBE19NORy4Y@redhat.com>
 <CA+QoejWaM+K895k=WcRndq=BNe1kNfJ4L5APKyk4+GHhmQLD0g@mail.gmail.com>
 <aMrcTg0J-dQuPkhI@redhat.com>
In-Reply-To: <aMrcTg0J-dQuPkhI@redhat.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 17 Sep 2025 09:17:57 -0700
X-Gm-Features: AS18NWCcYG6nsON-cU91uS36Pc9mHmf_jtcWn9MoRb_-WxoQBd_l2JP-wgXwbnE
Message-ID: <CA+QoejUbyre_ePvhDZ=t7hnLkrHrSAJPBRjfob22dx-DOO_u-g@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Ignore removed lines in license check
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=nabihestefan@google.com; helo=mail-il1-x135.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Sep 17, 2025 at 9:05=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Sep 17, 2025 at 08:16:53AM -0700, Nabih Estefan wrote:
> > We ran it against an internal patch that we were updating, so I can't
> > show you the patch.
>
> If you can't share that private patch, perhaps you can create a
> dummy patch with the same type of diff structure that shows the
> problem ?
>
The patch looks something like the following:

```
Subject: [PATCH] path/to/fake/file.c: Fix unacceptable license

These source files trigger the following error in ./scripts/checkpatch.pl:

ERROR: Saw unacceptable licenses 'GPL-2.0', valid choices for QEMU are:
GPL-2.0-or-later
---
path/to/fake/file.c | 2 +-
1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/path/to/fake/file.c b/path/to/fake/file.c
index a7604f014e..043ead35 106892
--- a/path/to/fake/file.c
+++ b/path/to/fake/file.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
/*
* Header of Fake file

```
It's just changing the file from an invalid  to a valid one, nothing else i=
s
being done, which is why I'm confused how it's triggering this.

> > However, the difference on it being affected might be in how we're
> > running it? To check
> > against just the changes being done in the specific patch, instead of
> > the whole file, we
> > trigger it by running `./scripts/checkpatch.pl --branch HEAD...HEAD^`.
> > Could that be
> > why it's triggering against existing files?
>
> I don't think that's a problem. It is just a different way ot getting
> a list of git commit hashes to analyse - it'll still operate against
> a patch diff IIUC.
>
> FWIW, I use   'checkpatch.pl master..' and/or 'git show| checkpatch.pl -'
>
> >
> > Thanks,
> > Nabih
> >
> > On Wed, Sep 17, 2025 at 2:24=E2=80=AFAM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 04:59:28PM +0000, Nabih Estefan wrote:
> > > > When running the license check, if we are updating a license it is
> > > > possible for the checkpatch script to test against old license line=
s
> > > > instead of newer ones, since the removal lines appear before the
> > > > addition lines in a .patch file.
> > >
> > > While we match the "SPDX-License-Identifier" text in any context,
> > > the "file must have SDPX" validation is only performed against
> > > files that are entirely new:
> > >
> > >   # Called at the end of processing a diff hunk for a file
> > >   sub process_end_of_file {
> > >         my $fileinfo =3D shift;
> > >
> > >         if ($fileinfo->{action} eq "new" &&
> > >             !exists $fileinfo->{facts}->{sawspdx}) {
> > >              ...raise error ....
> > >
> > > > Fix this by skipping over lines that start with "-" in the checkpat=
ch
> > > > script.
> > >
> > > A new file cannot have any "-" lines present, so there isn't any
> > > bug that needs fixing AFAICT.  Can you show any patch or commit
> > > where this would have made a difference to what checkpatch.pl
> > > reports ?
> > >
> > > >
> > > > Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> > > > ---
> > > >  scripts/checkpatch.pl | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > index 833f20f555..c57a423f9f 100755
> > > > --- a/scripts/checkpatch.pl
> > > > +++ b/scripts/checkpatch.pl
> > > > @@ -1813,7 +1813,8 @@ sub process {
> > > >               }
> > > >
> > > >  # Check SPDX-License-Identifier references a permitted license
> > > > -             if ($rawline =3D~ m,SPDX-License-Identifier: (.*?)(\*=
/)?\s*$,) {
> > > > +             if (($rawline =3D~ m,SPDX-License-Identifier: (.*?)(\=
*/)?\s*$,) &&
> > > > +                     $rawline !~ /^-/) {
> > > >                       $fileinfo->{facts}->{sawspdx} =3D 1;
> > > >                       &checkspdx($realfile, $1);
> > > >               }
> > > > --
> > > > 2.51.0.384.g4c02a37b29-goog
> > > >
> > >
> > > With regards,
> > > Daniel
> > > --
> > > |: https://berrange.com      -o-    https://www.flickr.com/photos/dbe=
rrange :|
> > > |: https://libvirt.org         -o-            https://fstop138.berran=
ge.com :|
> > > |: https://entangle-photo.org    -o-    https://www.instagram.com/dbe=
rrange :|
> > >
> >
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

