Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69F1E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvC7-0006Gs-AG; Thu, 09 Jan 2025 11:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tVvC3-0006GP-EB
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:15:36 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tVvC1-0006Zw-FU
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:15:35 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so210323766b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 08:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1736439331; x=1737044131; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k02q0uVqEedz6OethSIEqDgrfhFBHQS0vlrPrSFQJPw=;
 b=Oirq9D5Fk6ujBPTO1u5swVrIDzVmGAyFrkpTR84TWKpoBEk22+IpoVlbWOk2Vlgzt2
 ePpXOlpLdvZRlmYN32ByZRE1raL/8GDDNp0h/o8LccbnPlpG2ifHKKxwzKssyc7aKwSI
 3cA2n/IsoGHQmTtx4eRmpeBUfVE9CVEAeqJdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736439331; x=1737044131;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k02q0uVqEedz6OethSIEqDgrfhFBHQS0vlrPrSFQJPw=;
 b=mpmJou5oFRBaXRgG6BpZ77XAir8xNqD95wgTioAOenKCXVPI9tT7PPNnaYDaweZNWa
 DeK9Z0m6w2D13nIb2A3STRJJcBDhh6OBSfSPB30X3NUzaH2ExwApIZAnEVi0UTwd+Jcl
 1vD08nhhETHm3i/xEXU1vUEg6R4IE0LzTGYTl9fBA1xaej7pQHpxnCuS2zqUPYtnx3ku
 XKYPIKsVv3QXqHsMnXJePG9fmlBxM5p1+1N4C/56WYY2O5nYqQZKwy7qGPsdkD+OnnbT
 MEexwkuuTxdNJM14vynFDXikw4vNgtcGD7Rnh+AIXS10ZQtgU9tZwaoPhfZTNMN3KpRH
 GrkQ==
X-Gm-Message-State: AOJu0YzYpRJ5X0i20OoHx8bOihLpXfmVl3TSwXzRfye0DbXAmRuwBTQJ
 m3x8AsAVyQcGCBr6bbNZeVNsKs7bC/SLiC8dSQSJQziYSQm2De7PkPKFvDSEGus=
X-Gm-Gg: ASbGncviBgwRZWhz00cvGa0zymJpqfqJCjaFbmi6tJWrTa53DkAfPw/SUbupTkshlsw
 ZcnoAfIyyNdqNiKYw0vNA/jIbr3jgDQUq+RjEz1V0asRYngcmlTWuPGKzC4psUMVG7u0PqYIKGs
 6xYJsPJEkTV18Ddjz13b5NVKm3sNxI7ObuV8Vnss1I5XXV9CqhrZloS2IbhBvF5k+UINCgfsBz6
 EYg6lefyRUSeHidKOe1I+MAf77Ppqgz3G53edjPjTLiFbR9nXaExXMUWqQsmw==
X-Google-Smtp-Source: AGHT+IHtOa0K6VX3BliPmhDS5BYi81wa3891u/ccPf61M2Pph9hCJc33gfh7s/tmPgj+pMUjlYaTKA==
X-Received: by 2002:a17:907:d9f:b0:aac:180e:b1d4 with SMTP id
 a640c23a62f3a-ab2ab6fe016mr651317366b.27.1736439331372; 
 Thu, 09 Jan 2025 08:15:31 -0800 (PST)
Received: from localhost ([84.78.159.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9645fddsm83988066b.169.2025.01.09.08.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:15:31 -0800 (PST)
Date: Thu, 9 Jan 2025 17:15:30 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Anthony PERARD <anthony@xenproject.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/2] xen: do not use '%ms' scanf specifier
Message-ID: <Z3_2IhGZvpF-5IiX@macbook.local>
References: <20250107093140.86180-1-roger.pau@citrix.com>
 <20250107093140.86180-3-roger.pau@citrix.com>
 <Z3-sJMXpiFUoATHz@l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3-sJMXpiFUoATHz@l14>
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=roger.pau@cloud.com; helo=mail-ej1-x62c.google.com
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

On Thu, Jan 09, 2025 at 11:59:48AM +0100, Anthony PERARD wrote:
> On Tue, Jan 07, 2025 at 10:31:40AM +0100, Roger Pau Monne wrote:
> > The 'm' parameter used to request auto-allocation of the destination variable
> > is not supported on FreeBSD, and as such leads to failures to parse.
> > 
> > What's more, the current usage of '%ms' with xs_node_scanf() is pointless, as
> > it just leads to a double allocation of the same string.  Instead use
> > qemu_xen_xs_read() to read the whole xenstore node.
> > 
> > Fixes: a783f8ad4ec9 ('xen: add a mechanism to automatically create XenDevice-s...')
> > Fixes: 9b7737469080 ('hw/xen: update Xen console to XenDevice model')
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> >  hw/char/xen_console.c | 11 +++++++++--
> >  hw/xen/xen-bus.c      |  7 +++++--
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> > index af706c7ef440..18afd214c2f6 100644
> > --- a/hw/char/xen_console.c
> > +++ b/hw/char/xen_console.c
> > @@ -531,6 +531,7 @@ static void xen_console_device_create(XenBackendInstance *backend,
> >      const char *name = xen_backend_get_name(backend);
> >      unsigned long number;
> >      char *fe = NULL, *type = NULL, *output = NULL;
> > +    const char *node_path;
> 
> Is "const" correct when we are changing to which string `node_path` is
> pointing at? Also, why "const"? Also, compiler complains that we can't
> free a "const something*".

It's my understanding that the proposed const signals that the pointer
value can change, but the contents of the pointer cannot (iow: the
string cannot be modified).

My build seem to be fine, but I see that g_free() doesn't seem to take
a const pointer.  Will adjust.

> >      char label[32];
> >      XenDevice *xendev = NULL;
> >      XenConsole *con;
> > @@ -550,7 +551,10 @@ static void xen_console_device_create(XenBackendInstance *backend,
> >          goto fail;
> >      }
> >  
> > -    if (xs_node_scanf(xsh, XBT_NULL, fe, "type", errp, "%ms", &type) != 1) {
> > +    node_path = g_strdup_printf("%s/type", fe);
> > +    type = qemu_xen_xs_read(xsh, XBT_NULL, node_path, NULL);
> > +    g_free(node_path);
> 
> I feel like we want "xs_node_read()" which would be similair to
> xs_node_vscanf() but would simply return the result of
> qemu_xen_xs_read(). This would avoid the need format of the node path in
> several place in the code. But it's OK like that as well.

I was about to introduce such, but didn't end up doing.  I can do.

Thanks, Roger.

