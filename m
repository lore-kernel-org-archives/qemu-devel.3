Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074BE606A331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JEiz+zwN;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fimnfTLz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPgPE-0001gc-Mn; Sat, 07 Nov 2026 08:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xPgPC-0001gN-Ie
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 08:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xPgPA-0007Mu-Li
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 08:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794057862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2qxZDqWXbn79WPjPe5/1Jeaz3pcLf78WoBAumxUxBI=;
 b=JEiz+zwNkk9kFgo7lzJKGcZ9Kxwy/gx2SfqyrmZUb7K2cjwCiaoPWCKaKBKzc2fb9LJszn
 V9WgogQ527HlbAvuueohQTEqug3Uz46YsgMR5dxbSPtYCCXEoSreQEX0Sjd92apXEejZz8
 z9zrEzCnSs1xujoJt6BIMe3kpzX5E5k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-SIZtGm0yPP6r92LFY3VwMQ-1; Sat, 07 Nov 2026 08:24:20 -0500
X-MC-Unique: SIZtGm0yPP6r92LFY3VwMQ-1
X-Mimecast-MFC-AGG-ID: SIZtGm0yPP6r92LFY3VwMQ_1794057860
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a359b714f8so12453735e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2026 05:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794057859; x=1794662659; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y2qxZDqWXbn79WPjPe5/1Jeaz3pcLf78WoBAumxUxBI=;
 b=fimnfTLzCPHmHVc0/RLrBtpxDhmmiy9amwppKAFZyMpDlQKq3yREZVLT3KYxXe0POw
 xyjYXtqFwXyQbkuvKcbe/BU9ujCfhjbdOgTVgLmcWR5ymgeSL5ijTJDfNHyqxmoOZ6Q9
 hx7JZEYtwMXkNzvmQTkFNy/HI3T/8Dzks4H1RBAZV9Gd9xuUn5ENbO3Qg7CxWiI6dQlh
 iVqDNXKrvl6Vr2GXPJah4YR7T3AjXy0o7agpH9xRjs/B4kWjhdK50DnMq+IgNYpIUNpd
 iM2ssafFqWb+28EQhDJso78S75n9gClw3J24jD6mnukfYLfH98DRkNIDtnHyZP/jHZDK
 nPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794057859; x=1794662659;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y2qxZDqWXbn79WPjPe5/1Jeaz3pcLf78WoBAumxUxBI=;
 b=sOUPPaClouLAYVHsy9zqdyiYZdiHFkUgVmUoQhzwuE0GQ59Mzji6D18gBJhKXR60ce
 QEP3SesTM8mt9SOChN+aYCZwqbc6kYtb4ByP2pXUYlIYyLPKPxk4BJdlKH1qRgoXs0sE
 N7+S2cGa7+2sdTtanaRF/CyyP27/chmj3uNqwewo2lE+EhFaGMT7N8qXgWzs8gAeriyV
 F5oiojQo6pQTNVvZmykGFGO2Ko1fOoWSJpE1SPaHrq7Mchceeens5rPL92auSY6fi9iL
 jEt46DTCzWY6O0XzVcPDTA14OgyQgfk7Cv/QaG5F6Dv5cYT4qwavZW5w+YZPmPhts3iW
 QhZA==
X-Forwarded-Encrypted: i=1;
 AKwUvByj4JQCPXhICljRYoL2QAi6crqpWtCi6aWzxlS+xdCb6qELTn56CDfacm8hhP+aBwmjTORUlOeuEM8k@nongnu.org
X-Gm-Message-State: APuU4Z9cjXv+eNGo8q3eD3uG2bnBGChBtINvMsqbAZnAsIslJe3mM8ZS
 tqVujyG8J3+ls92OiF5tPa7Oh8LUpXs32kXXKrU+hUaHGaxYmtkF6b/OJQ5TjlT6y9TmSygzVVb
 1/Ain+/DK2Vh0WNQCqUmoRbxlmKucJUQ/Jzf0fz0Or+hkT+UCiO0n2pOe
X-Gm-Gg: AYBFou1se9P+7Zx3zko1RORIohNwiG26M4/enh/HG2xCfhr2wS7vxd7x133kqkuOC3e
 F58Eb/cdJ5sr/faaz6reHFt5N7OdcOaX+glrS5oNkTzptEc5OcDgJfTmcN9RVeYQai+iouOCyV3
 xEj57H4W4g6LyGbJmM/4c+xEFTak74u/TG/YY1ZFqGkOx4oU6EDNb+I6/QFuSbpjFQfB8GQtSw/
 xNlYMD3lI3JP4nTBULqj6UnhyHwJ6d1IfOrxjeiMwlE/+RkEH0nRE5/h+Ci/yovj+sG2VxJ5DsR
 sBmXUqbHiETglhktoFOv/JHNVxAytjpjr73yUG0KBTMI0c8VGk+kkniyXUCt670aVVSpwxt5mHK
 a63Zh72ay73pOOytaN9t9kBA2Z6YM0x5yskwBlRUq9UI=
X-Received: by 2002:a05:600c:c491:b0:4a4:de70:2ad4 with SMTP id
 5b1f17b1804b1-4b6dff83dc4mr102570845e9.22.1794057859303; 
 Sat, 07 Nov 2026 05:24:19 -0800 (PST)
X-Received: by 2002:a05:600c:c491:b0:4a4:de70:2ad4 with SMTP id
 5b1f17b1804b1-4b6dff83dc4mr102570315e9.22.1794057858804; 
 Sat, 07 Nov 2026 05:24:18 -0800 (PST)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7efb1b64esm71363015e9.13.2026.11.07.05.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 05:24:18 -0800 (PST)
Date: Sat, 7 Nov 2026 08:24:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] x86: mmap kernel for direct kernel boot
Message-ID: <20261107081647-mutt-send-email-mst@kernel.org>
References: <20261021063105.102520-1-kraxel@redhat.com>
 <CAFn=p-anhY5nzcjqeVjqvmVkbi1c3=SeUYxJoFqDhCXmbRM4VA@mail.gmail.com>
 <CAFn=p-ZKX81fjQH8OdGAq7ErJ9bc2BsLtn2jEicUmgwWdjQYEA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-ZKX81fjQH8OdGAq7ErJ9bc2BsLtn2jEicUmgwWdjQYEA@mail.gmail.com>
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

First we are in freeze. So no rush.
Here's some ai based review - the arguments make sense to me.

1. No length validation on the mapping. kernel_size comes from
get_file_size() (fstat at open time), but the patch never checks
g_mapped_file_get_length() == kernel_size. If the file shrinks between
the stat and the mmap (or is a weird file), you get an OOB read / SIGBUS
instead of the old clean fread() failed exit. Further, if the
file is truncated later (QEMU running, guest hasn't read the kernel
through fw_cfg yet), guest reads hit SIGBUS and kill QEMU. fread copies
up front, so this race didn't exist before.

2. Files that are readable but not mappable. fread works on anything
stdio can read; mmap fails on some FUSE mounts, files with outstanding
mandatory/lease locks, etc. g_mapped_file_new failing exits QEMU, so a
previously booting config on such a filesystem stops booting.

3. Windows share modes. stdio fopen("rb") opens with permissive sharing,
while gio's file mapping opens the file with a more restrictive share
mode. A kernel image that another process still holds open for writing
(download in progress, installer, antivirus scanning with exclusive
handle) currently boots and would now fail to map. Windows is a
supported platform, so this counts.

4. Torn reads on concurrent modification. With fread you snapshot the
file once; with a private mapping, pages faulted after an external write
see new content, so a guest could get a mix of old and new kernel bytes.
Only matters for someone rewriting the image under a running QEMU, which
is already dubious.


I would not worry about torn reads too much. But failure seems
theoretically legit.  It's hard to know this does not break any existing
configs.  It might be safer to just add an option.

Also, pls include the observed gain in the commit log.


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


