Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB247606A326
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WdghduZw;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eHp2qwAC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPqTV-0007SR-Vt; Sat, 07 Nov 2026 19:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xPqTT-0007S5-L0
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 19:09:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xPqTR-0008IU-Bf
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 19:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794096567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRcFn12wGmfa4fbWdvFRwKazGV20PnwHv9dKI5iAr94=;
 b=WdghduZw0qOJZaDnTH5DASfWilVFU6Dnc3fadREhx24X1XFaat5B6skG0biwccpgd+NEyi
 f0o8fzG4Z9jRLL2B2ZjA1m96VFaL2sum4vbtDCh5tTeEYY1qiHo8yx4R4zt7R3UMDDi/8p
 cu6MZNgNzTp4rpb2raLCTAgJ1riVbKw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Lfh6BrvpOEuMXeBuWVN9FA-1; Sat, 07 Nov 2026 19:09:26 -0500
X-MC-Unique: Lfh6BrvpOEuMXeBuWVN9FA-1
X-Mimecast-MFC-AGG-ID: Lfh6BrvpOEuMXeBuWVN9FA_1794096565
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a4654add56so586195e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2026 16:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794096565; x=1794701365; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VRcFn12wGmfa4fbWdvFRwKazGV20PnwHv9dKI5iAr94=;
 b=eHp2qwACOnCd3rN7UvHzMj+6gzsU3hvomn6nEts+LifKrcWpwGDlJv1YwwOg0P5qJ+
 7S/enwZvC90eMkZn/xRu3j4tffvbzxYGszGlESiCc3ltTI1AGCi3faGYzXD0qe9LXtDS
 cZcxnj2o2ZDGpemL9ShFo+3Vsqk7CHk7hDHtGWCpqg+WQu4ua040qkTk7QVqnud0Q6k5
 Qd9HeXUr7ElhYHwdKAKTBep2nDiKQLpPNfxFxPikZCx4d5itk42ViJJqt0BGhkceTshU
 zMLSkZr+k6KIufUJjWCam+VYjCcWQbEAiF4ImhLhDXau2ZwbU3FdQ83XMbXhXz20Dg0N
 OAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794096565; x=1794701365;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VRcFn12wGmfa4fbWdvFRwKazGV20PnwHv9dKI5iAr94=;
 b=uHmW/4TO0pd6YQtqW5FsIh20oSeKV1r/vO9oGi10SabafGqdX9SifODDIUDtNWViZk
 cGOtaWXDx1iNxq9CNSLAUH4/rljn6uYIAI2ADfrY+XJHiGzx8N+6evjbrcrILaaJc6EJ
 CUMCHSBg8f7OcaNrhJWLTWOwHBkshpZUMLg5x1/OhUtYMFU1d8/RTNpIjTXcfteSV/oK
 D/+JocCp690WMcqK/VS+VFiG1ABJqFIUuiNKlVTE/oIjf7wthyYtFtgic3Rvu9YdwwEE
 W3tjTPxHVkNgm2oxBvrVlp4TT/dui/TlQ8rIeqjoZqAXDHtQhslILRpEeKHuumxNhULE
 bnvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzH6L8YBb6s3dYaH0WoNsM/ZCPcxP0qYdkLof+EIkgtAY4dnBsMtDQXgvSbB5KRscecRsdGXbz06bsZ@nongnu.org
X-Gm-Message-State: APuU4Z8dv0JbJmOYrdJ97njvoXKPzuUNR69ETt2g4561FBshg2OuVryC
 7/egN0BzzwN8r/wY5Y1OQ8d3XGNXzfCVXiZpzzDZxpdGsEPYa9DjgpCQzzjO8FEslES8Wnj58Zi
 TdWODE4g1gxjY5S6fTc7MOv7IvqaNnRMhC9Lu0u97t4KJ5VOirA1qVhGu
X-Gm-Gg: AYBFou2LxsJDpl3wgSI9ICzYZ/t2Yg9FK08bFOM4mtJNS46yytJJMoMs3fgJipXAexH
 b01jVgJ1zIBofpltmrp1xOyaCtF6IR1ZGZu6zj+gclI83A/2/OMIuWglGVb3w2wZCtfng4WlYF7
 vHDqzQWQYN9QEVjWKwqNfZmk7HKUH8U5E6hUlfKnNc7Tbpzv3OJb3gYQpxP67zMUceRE6SdJidR
 6Pbma42TVPgVjGbVRV1ZYWfEfYQYWdifbmMGHT+wE7FS/agWVFVKxBGgjL5ouibv4Nv0OSk5GDP
 ICRK4ccOhwhynjeYzd0jWII4vz+kxLCG8o16hJ3vpb3et0REyD+Kvlpnlxr2nXq3GVZBbAXbnt7
 FGtArdIzBDq1PX4X350lm5c3FrbWmduqZGtd9zCOCmDc=
X-Received: by 2002:a05:600c:608a:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4b94d76329cmr4556775e9.1.1794096564628; 
 Sat, 07 Nov 2026 16:09:24 -0800 (PST)
X-Received: by 2002:a05:600c:608a:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4b94d76329cmr4556545e9.1.1794096564081; 
 Sat, 07 Nov 2026 16:09:24 -0800 (PST)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90ee249d3sm17872015e9.7.2026.11.07.16.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 16:09:23 -0800 (PST)
Date: Sat, 7 Nov 2026 19:09:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] x86: mmap kernel for direct kernel boot
Message-ID: <20261107190556-mutt-send-email-mst@kernel.org>
References: <20261021063105.102520-1-kraxel@redhat.com>
 <CAFn=p-anhY5nzcjqeVjqvmVkbi1c3=SeUYxJoFqDhCXmbRM4VA@mail.gmail.com>
 <CAFn=p-ZKX81fjQH8OdGAq7ErJ9bc2BsLtn2jEicUmgwWdjQYEA@mail.gmail.com>
 <20261107081647-mutt-send-email-mst@kernel.org>
 <CAFn=p-bjiXj_0FPLHAiFdQRzUkHTfAxkRE6cKM4pRhANND3hgQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-bjiXj_0FPLHAiFdQRzUkHTfAxkRE6cKM4pRhANND3hgQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Nov 07, 2026 at 01:59:12PM -0500, John Snow wrote:
> On Sat, Nov 7, 2026 at 8:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Nov 06, 2026 at 01:02:33PM -0500, John Snow wrote:
> > > On Wed, Oct 21, 2026 at 12:02 PM John Snow <jsnow@redhat.com> wrote:
> > > >
> > > > On Wed, Oct 21, 2026 at 2:31 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > > >
> > > > > Reduce memory footprint by mapping the kernel into memory instead of
> > > > > reading into allocated memory in the common case (no -dtb $file on the
> > > > > qemu command line).
> > > > >
> > > > > Cc: John Snow <jsnow@redhat.com>
> > > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > >
> > > > Tested-by: John Snow <jsnow@redhat.com>
> > > >
> > >
> > > Ping, is someone going to pick up this patch?
> > >
> > > --js
> >
> > First we are in freeze. So no rush.
> 
> Patch was on-list well before freeze.

Yes but it has to be in a maintainer tree with pull on list, not just
patch on list.

> > Here's some ai based review - the arguments make sense to me.
> >
> > 1. No length validation on the mapping. kernel_size comes from
> > get_file_size() (fstat at open time), but the patch never checks
> > g_mapped_file_get_length() == kernel_size. If the file shrinks between
> > the stat and the mmap (or is a weird file), you get an OOB read / SIGBUS
> > instead of the old clean fread() failed exit. Further, if the
> > file is truncated later (QEMU running, guest hasn't read the kernel
> > through fw_cfg yet), guest reads hit SIGBUS and kill QEMU. fread copies
> > up front, so this race didn't exist before.
> 
> Looks like we do use this function when loading the initrd, easy
> enough to fix here.
> 
> >
> > 2. Files that are readable but not mappable. fread works on anything
> > stdio can read; mmap fails on some FUSE mounts, files with outstanding
> > mandatory/lease locks, etc. g_mapped_file_new failing exits QEMU, so a
> > previously booting config on such a filesystem stops booting.
> >
> > 3. Windows share modes. stdio fopen("rb") opens with permissive sharing,
> > while gio's file mapping opens the file with a more restrictive share
> > mode. A kernel image that another process still holds open for writing
> > (download in progress, installer, antivirus scanning with exclusive
> > handle) currently boots and would now fail to map. Windows is a
> > supported platform, so this counts.
> 
> OK, if 2 and 3 are valid, it sounds like we just want a fallback to
> fread. Mind you, we already use this technique for initrd images, so I
> don't think we are doing anything fundamentally wacky here that QEMU
> doesn't already do.

Better safe I guess.

> >
> > 4. Torn reads on concurrent modification. With fread you snapshot the
> > file once; with a private mapping, pages faulted after an external write
> > see new content, so a guest could get a mix of old and new kernel bytes.
> > Only matters for someone rewriting the image under a running QEMU, which
> > is already dubious.
> 
> I wouldn't worry about this; it's the same as "Well, what if you
> modify a .qcow2 under a running QEMU?" Well, don't do that.

OK.

> >
> >
> > I would not worry about torn reads too much. But failure seems
> > theoretically legit.  It's hard to know this does not break any existing
> > configs.  It might be safer to just add an option.
> 
> I think matching initrd loading behavior is all the justification we
> need for treating the kernel identically.

I'd say the reverse, let's fix initrd loading)

> >
> > Also, pls include the observed gain in the commit log.
> 
> Observed gain is that if you are loading a 19 MiB kernel, this change
> allows that memory to be mapped and allocated as RssFile memory
> instead of RssAnon memory. This means that if you run multiple QEMU
> instances using the same kernel, that memory is shared and excluded
> from USS instead of being charged per-instance.

So do this? Run many QEMU's and measure a practical gain?

> >
> >
> > > > Using this patch, I shifted about 19MiB of resources from RssAnon to
> > > > RssFile. This theoretically allows sharing resources between multiple
> > > > QEMU instances in the trivial case using -kernel and -initrd. This
> > > > matches how we already load initrd.
> > > >
> > > > --js
> > > >
> > > > > ---
> > > > >  hw/i386/x86-common.c | 25 ++++++++++++++++++++-----
> > > > >  1 file changed, 20 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> > > > > index fa18bf1aeceb..25e141aa8537 100644
> > > > > --- a/hw/i386/x86-common.c
> > > > > +++ b/hw/i386/x86-common.c
> > > > > @@ -911,16 +911,31 @@ void x86_load_linux(X86MachineState *x86ms,
> > > > >      }
> > > > >
> > > > >      setup  = g_malloc(setup_size);
> > > > > -    kernel = g_malloc(kernel_size);
> > > > >      fseek(f, 0, SEEK_SET);
> > > > >      if (fread(setup, 1, setup_size, f) != setup_size) {
> > > > >          fprintf(stderr, "fread() failed\n");
> > > > >          exit(1);
> > > > >      }
> > > > > -    fseek(f, 0, SEEK_SET);
> > > > > -    if (fread(kernel, 1, kernel_size, f) != kernel_size) {
> > > > > -        fprintf(stderr, "fread() failed\n");
> > > > > -        exit(1);
> > > > > +    if (dtb_filename) {
> > > > > +        /* read kernel into allocated memory, so we can realloc for the dtb */
> > > > > +        kernel = g_malloc(kernel_size);
> > > > > +        fseek(f, 0, SEEK_SET);
> > > > > +        if (fread(kernel, 1, kernel_size, f) != kernel_size) {
> > > > > +            fprintf(stderr, "fread() failed\n");
> > > > > +            exit(1);
> > > > > +        }
> > > > > +    } else {
> > > > > +        /* mmap kernel */
> > > > > +        GMappedFile *mapped_file;
> > > > > +        GError *gerr = NULL;
> > > > > +
> > > > > +        mapped_file = g_mapped_file_new(kernel_filename, false, &gerr);
> > > > > +        if (!mapped_file) {
> > > > > +            fprintf(stderr, "qemu: error reading kernel %s: %s\n",
> > > > > +                    kernel_filename, gerr->message);
> > > > > +            exit(1);
> > > > > +        }
> > > > > +        kernel = (uint8_t *)g_mapped_file_get_contents(mapped_file);
> > > > >      }
> > > > >      fclose(f);
> > > > >
> > > > > --
> > > > > 2.56.0
> > > > >
> >


