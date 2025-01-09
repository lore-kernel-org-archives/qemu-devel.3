Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8296E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVv3z-0003eH-Qh; Thu, 09 Jan 2025 11:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tVv3o-0003ZR-Ux
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:07:06 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tVv3l-00056I-6V
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:07:04 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaf3c3c104fso191879866b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 08:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1736438818; x=1737043618; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2ZxKJHt4USamZY7CSfghkQfPog5+4zXIN2+IyM4b7Rk=;
 b=FmoQc8GLZEc9lhZXD6t98XijKx1hVkQa1kTR/UrY0CdNwiuXguXPypmxu1ActTqt6o
 pjyo+PiFvmxJqE7clHPzlc7RAYT/KmgPLWYdzd1c/R6AMEKz02RKlF/MW2MwdkhTYi24
 EoucI2jdCO8wsetpituDDybbDP3N/eZErVZHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736438818; x=1737043618;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZxKJHt4USamZY7CSfghkQfPog5+4zXIN2+IyM4b7Rk=;
 b=UwpuBm7nO/jNKR5HyuURr2yWivAKS2t7VHzxPTumvgyFb8wdG5AM+DbuG1PdnDROiT
 NsUOyxVaz+rDfOoU91XQ9ik+wtHmk7YU8vcpirPIJnmGlnZeMGAAtmEhpi4fjqfe8yI6
 O2NuOwhVGpmBRF8zdOt5j0d3XLEKEDyGZ2DpFBFYK12NXN7er8mNdUgTF+bRiDHF0Bbp
 FlF2rn4lwYWTk/vmC9u8GWH1aRRHWhBIrjjRerizGzkdvai1hrugBZ7ijDrtu9lkWxW7
 fj7eHje2IDW5PHSk7sLAsGn0E4nYVvfWQXc0eAkf15yqv/mOx+BDQMLqIR8Wf1ISpPi8
 PWvQ==
X-Gm-Message-State: AOJu0Yzk0BRdYDRfibo1M7bwD4eMB2sNWV8MS82h9sc64IB+NZlgRbKn
 12iBs7MDzM4NvSGqoRKQoTwcLmzEiv0bEbTQ4mwUwA7Jr8BDUflW5lRBIsOAeKM=
X-Gm-Gg: ASbGncuxsg2SFyVDHGqyADbEg2d4yCRm+lLSI/mitH43gwEuncmhE9QngMq9Yi7rx+v
 letnluJY9DHKajd5H1DB0RXFPFdq2ZsINFtFAGrnS1Ub89TpNgKBpSUvCpKqOsSTgPhYyXbEaEr
 cTE3SUks2ZQ/Ql6NO98GxS6kqdd0ARroUg/eXATVmYdaMp4kX2KK0b4T8Od6lw8gIzh/i1939m2
 629vzEu+bvn4NgMTT8SldlM6YPZzILP5iOlGvw5gyPaK1N30j6i58iom8vhhA==
X-Google-Smtp-Source: AGHT+IHQCbfJqFT4KaXgnMxTnLcFPSKLuLtytVYJU6DTW8em42L3L0fV3PFS9oWX2MaUMz24eWnApg==
X-Received: by 2002:a17:907:2d94:b0:aa6:7de9:2637 with SMTP id
 a640c23a62f3a-ab2ab6bfe70mr614603966b.46.1736438816006; 
 Thu, 09 Jan 2025 08:06:56 -0800 (PST)
Received: from localhost ([84.78.159.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90d9a7dsm85367866b.50.2025.01.09.08.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:06:55 -0800 (PST)
Date: Thu, 9 Jan 2025 17:06:54 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Anthony PERARD <anthony@xenproject.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/2] xen/console: fix error handling in
 xen_console_device_create()
Message-ID: <Z3_0HpmfpSM3Xw5Q@macbook.local>
References: <20250107093140.86180-1-roger.pau@citrix.com>
 <20250107093140.86180-2-roger.pau@citrix.com>
 <Z3-hWRLyMldV4ZZD@l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3-hWRLyMldV4ZZD@l14>
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=roger.pau@cloud.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 09, 2025 at 11:13:45AM +0100, Anthony PERARD wrote:
> On Tue, Jan 07, 2025 at 10:31:39AM +0100, Roger Pau Monne wrote:
> > The usage of error_prepend() in some of the error contexts of
> > xen_console_device_create() is incorrect, as `errp` hasn't been initialized.
> > This leads to the following segmentation fault on error paths resulting from
> > xenstore reads:
> > 
> > Program terminated with signal SIGSEGV, Segmentation fault.
> > Address not mapped to object.
> >     fmt=0x15c4dfeade42 "failed to read console device type: ", ap=0x15cd0165ab50)
> >     at ../qemu-xen-dir-remote/util/error.c:142
> > 142         g_string_append(newmsg, (*errp)->msg);
> > [...]
> > (gdb) bt
> >     (errp=0x15cd0165ae10, fmt=0x15c4dfeade42 "failed to read console device type: ", ap=0x15cd0165ab50) at ../qemu-xen-dir-remote/util/error.c:142
> >     (errp=0x15cd0165ae10, fmt=0x15c4dfeade42 "failed to read console device type: ")
> >     at ../qemu-xen-dir-remote/util/error.c:152
> >     (backend=0x43944de00660, opts=0x43944c929000, errp=0x15cd0165ae10)
> >     at ../qemu-xen-dir-remote/hw/char/xen_console.c:555
> > 
> > Replace usages of error_prepend() with error_setg() where appropriate.
> > 
> > Fixes: 9b7737469080 ('hw/xen: update Xen console to XenDevice model')
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> >  hw/char/xen_console.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> > index ef0c2912efa1..af706c7ef440 100644
> > --- a/hw/char/xen_console.c
> > +++ b/hw/char/xen_console.c
> > @@ -551,7 +551,7 @@ static void xen_console_device_create(XenBackendInstance *backend,
> >      }
> >  
> >      if (xs_node_scanf(xsh, XBT_NULL, fe, "type", errp, "%ms", &type) != 1) {
> > -        error_prepend(errp, "failed to read console device type: ");
> > +        error_setg(errp, "failed to read console device type: ");
> 
> According to error_setg() doc, *errp must be NULL but xs_node_scanf may
> set it. Looking at the implementation, error_setg() seems to simply
> discard this new error message if *errp is already set.
> 
> Currently, when there's an I/O error, we get something like:
>     failed to read console device type: failed to read from /xenstore/path: doesn't exist
> and when the format scan failed:
>     SEGV
> 
> With this patch, when there's an I/O error, I think we get something
> like:
>     failed to read from /xenstore/path: doesn't exist
> and when the format scan failed:
>     failed to read console device type: 
> 
> 
> So I think we'll want to distiguish between IO error from
> xs_node_scanf() and format error, first one returns EOF (like vsscanf)
> and second one returns a value >= 0 but we expect exactly 1.

The call to xs_node_scanf() will go away in the next patch replaced by
qemu_xen_xs_read(), at which point errp will never be initialized.

I can change the order of the patches if that makes it easier.

> 
> >          goto fail;
> >      }
> >  
> > @@ -582,7 +582,7 @@ static void xen_console_device_create(XenBackendInstance *backend,
> >      } else if (number) {
> >          cd = serial_hd(number);
> >          if (!cd) {
> > -            error_prepend(errp, "console: No serial device #%ld found: ",
> > +            error_setg(errp, "console: No serial device #%ld found: ",
> >                            number);
> 
> This change looks correct, ableit we could remove ":  " from the end of
> the string since they shouldn't be anything after it.

Thanks, Roger.

