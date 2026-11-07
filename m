Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C3606A326
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XvU03+kf;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SGVoQx0n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPgDZ-0006w0-78; Sat, 07 Nov 2026 08:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xPgDX-0006vj-4p
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 08:12:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xPgDV-0005Sc-DU
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 08:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794057138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9SBh09YC7/cdHa/r5rOXEnQb/SS5ArZJv/6FrvHwF8=;
 b=XvU03+kfUJJERz4TshXDOQU9petCqka77dyLG8yRAhlclPZJoxrqHzS+gaZHVqxkP9++bl
 2GbvJYI1YSJlin2hEAtAwR5rNXVs6uAbtNVXeixKiEdEyj57MonInSbkB/n1u4h5kpv1Rv
 zeF5AJ+LE80IlWcJV3bs47KGR8RVINU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-1Bb0mmt0OTiVGv05qLUYuw-1; Sat, 07 Nov 2026 08:12:17 -0500
X-MC-Unique: 1Bb0mmt0OTiVGv05qLUYuw-1
X-Mimecast-MFC-AGG-ID: 1Bb0mmt0OTiVGv05qLUYuw_1794057136
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4b8b3cd61a5so269185e9.1
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2026 05:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794057136; x=1794661936; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q9SBh09YC7/cdHa/r5rOXEnQb/SS5ArZJv/6FrvHwF8=;
 b=SGVoQx0nsEFgroyfB7oo8FwEVSxP+vwAVzqvEIzB8zd+j3eDaKNtRMbS6/DXoDPQnW
 cTZ2iWdnQBwFg3nDIRTrZVD5yJ1Au0FTsFf931bXjwlFK525R+gAy7/n5x2Ie5b0k187
 gFzBzS5T9uWqD6WhFmprh+dFS+Zr97u7PBtyA5ekCp4aIwO2vrpkc9MoaLtvVPomVhov
 2YReQL9thhk51XSgPz0xCl2h6DUSjdkT63HphbOJVGr+yNYex05Zk4Ex4SNJy+AQQ57g
 Ihj2Vc6fzzV5VrpyZHKJq4FhLc9aQFEQ6sc3SPMjgxYRUXIZZIkcZHLa2Y4bRBfcdeTm
 X4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794057136; x=1794661936;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q9SBh09YC7/cdHa/r5rOXEnQb/SS5ArZJv/6FrvHwF8=;
 b=sDz2jzsI+w9+tefY5Pci1uE/gTwogeAD0b7XNgFacRFb80HoT1IyLa2svsB3KPO3Pm
 NA5UqgFBSY0TSJchzZR+L00t30PPLA5CXYtIJOS71ESI8b7x7iEIRYqt5Qzv1Z6Q3m2m
 3Ab3cuPieWjcQOrXbgXkHYOn1yvYG6YoQEPoEbJ1QMgvZ2ZdjE272k07DAlLER6IZwiy
 pkFokL2plOEr38gired5kv2tWvU0frrWdpiXbLJGhJr/OboVsFQrOPr2a5bU1AAKecxg
 mRDubjZgWgzhZiRANsVeULsPIGi2ZLBD2u7jU5r2nlJPMJMAjIdKnEWg71lAkusGItvi
 IEDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEEvT2aSTkRmiwY2kqaG1BtUNpxdF8Jq5yi6yPOHeoUy/TSfxmG1DQUYMKbO4uVA7z9FRF2GaW2rLj@nongnu.org
X-Gm-Message-State: APuU4Z8wpK05qgON2uJrXTcQiThpPOl6ZhGUvU4FvbmqP+5QloHj6g2O
 Wo57LWVTnN6GblzgNL8WHmiI86WSypejim0Gmft6Mv2K1qOyrpPMtjotFiO4CWfIMlbZYh2m7nj
 qfaZYN45GUHX9Q/Zxp4jGtZPHCf3tClCjJLjCSGKBOXWFSwFR3tHHCQEF
X-Gm-Gg: AYBFou2p2QZg8z4A/Emyh2Km194/9jfHfxXCrc9W7gfbmTnlyuoqVaDGuV09ni8xjsY
 bgZqvTZUGP9A24KFQ2fPllnxqnunGwdJwgeHjPwKDxJJE2RMKY+GQzXI/QtFFK7sej6sXmUm64U
 uTIsV/68sB7k80bAkj509kb/c1xcDgTE57dZaH4f5ziBjFd2wDT0Do3v18BN1PTA314rmeU2ECF
 zVugTsZX92eDhXpLf411FxzHD+xcZyluUVGiW+PchB1Qipxw1e368Eu0a8uxIgLRgJsFUn6Zppe
 7YhJSMSz8M/PAOC6YQ6iwESOjHVuWzyE1GuNjJbqoMzvYS0F79g1B8B0E/AXSZbn5jtYb2vCfBk
 J531+XLh7iaQg42U0OMSTgkphuVfoofCEYEMMYXCHSj8=
X-Received: by 2002:a05:600c:8115:b0:4a2:10f9:37db with SMTP id
 5b1f17b1804b1-4b8190f468amr35634725e9.7.1794057135837; 
 Sat, 07 Nov 2026 05:12:15 -0800 (PST)
X-Received: by 2002:a05:600c:8115:b0:4a2:10f9:37db with SMTP id
 5b1f17b1804b1-4b8190f468amr35634155e9.7.1794057135307; 
 Sat, 07 Nov 2026 05:12:15 -0800 (PST)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b795024730sm54789555e9.4.2026.11.07.05.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 05:12:14 -0800 (PST)
Date: Sat, 7 Nov 2026 08:12:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] x86: mmap kernel for direct kernel boot
Message-ID: <20261107080917-mutt-send-email-mst@kernel.org>
References: <20261021063105.102520-1-kraxel@redhat.com>
 <CAFn=p-anhY5nzcjqeVjqvmVkbi1c3=SeUYxJoFqDhCXmbRM4VA@mail.gmail.com>
 <CAFn=p-ZKX81fjQH8OdGAq7ErJ9bc2BsLtn2jEicUmgwWdjQYEA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-ZKX81fjQH8OdGAq7ErJ9bc2BsLtn2jEicUmgwWdjQYEA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 06, 2026 at 01:02:33PM -0500, John Snow wrote:
> On Wed, Oct 21, 2026 at 12:02 PM John Snow <jsnow@redhat.com> wrote:
> >
> > On Wed, Oct 21, 2026 at 2:31 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Reduce memory footprint by mapping the kernel into memory instead of
> > > reading into allocated memory in the common case (no -dtb $file on the
> > > qemu command line).
> > >
> > > Cc: John Snow <jsnow@redhat.com>
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > Tested-by: John Snow <jsnow@redhat.com>
> >
> 
> Ping, is someone going to pick up this patch?
> 
> --js

ok

> > Using this patch, I shifted about 19MiB of resources from RssAnon to
> > RssFile. This theoretically allows sharing resources between multiple
> > QEMU instances in the trivial case using -kernel and -initrd. This
> > matches how we already load initrd.
> >
> > --js
> >
> > > ---
> > >  hw/i386/x86-common.c | 25 ++++++++++++++++++++-----
> > >  1 file changed, 20 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> > > index fa18bf1aeceb..25e141aa8537 100644
> > > --- a/hw/i386/x86-common.c
> > > +++ b/hw/i386/x86-common.c
> > > @@ -911,16 +911,31 @@ void x86_load_linux(X86MachineState *x86ms,
> > >      }
> > >
> > >      setup  = g_malloc(setup_size);
> > > -    kernel = g_malloc(kernel_size);
> > >      fseek(f, 0, SEEK_SET);
> > >      if (fread(setup, 1, setup_size, f) != setup_size) {
> > >          fprintf(stderr, "fread() failed\n");
> > >          exit(1);
> > >      }
> > > -    fseek(f, 0, SEEK_SET);
> > > -    if (fread(kernel, 1, kernel_size, f) != kernel_size) {
> > > -        fprintf(stderr, "fread() failed\n");
> > > -        exit(1);
> > > +    if (dtb_filename) {
> > > +        /* read kernel into allocated memory, so we can realloc for the dtb */
> > > +        kernel = g_malloc(kernel_size);
> > > +        fseek(f, 0, SEEK_SET);
> > > +        if (fread(kernel, 1, kernel_size, f) != kernel_size) {
> > > +            fprintf(stderr, "fread() failed\n");
> > > +            exit(1);
> > > +        }
> > > +    } else {
> > > +        /* mmap kernel */
> > > +        GMappedFile *mapped_file;
> > > +        GError *gerr = NULL;
> > > +
> > > +        mapped_file = g_mapped_file_new(kernel_filename, false, &gerr);
> > > +        if (!mapped_file) {
> > > +            fprintf(stderr, "qemu: error reading kernel %s: %s\n",
> > > +                    kernel_filename, gerr->message);
> > > +            exit(1);
> > > +        }
> > > +        kernel = (uint8_t *)g_mapped_file_get_contents(mapped_file);
> > >      }
> > >      fclose(f);
> > >
> > > --
> > > 2.56.0
> > >


