Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E79E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvoc-0000ji-O7; Thu, 09 Jan 2025 11:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tVvob-0000jW-Bo
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:55:25 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tVvoZ-00054e-F1
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:55:24 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3cf094768so1843990a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 08:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1736441721; x=1737046521; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cAZUAQvOu49U0hMeCh88veBnObf9ztRSpbDykRVZvls=;
 b=MZq/wlDtzNKxyfLrdFTJRqa/CXIkceyfcLc4t6va90r6/uGLr6RhCUgr1WTUtfpb1D
 XRqlQpXiLjVPAGaFqLdWUyv0PnS1h95y18phA3XfyHK8gO6nqZSJTZd+ZY/gHguTQLa9
 UtmRp/v5VrSkKKQFuII/IjbvyDRIsHD7doBD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736441721; x=1737046521;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cAZUAQvOu49U0hMeCh88veBnObf9ztRSpbDykRVZvls=;
 b=b4Qu3b2qNBG9bcgDHqb6MeiGX1k/QzasugigyOoUKxzGXXEnCgn19/IeFyHmHd8Kmg
 HYWo6nUjJLq7lVJmLKFKFSATW+R6Vlui1BrSDl5G3DDZzOK1XlvqWcV3I++rKwYt9PSJ
 7FeQ7HBVdCDGgp8w9RU5CZ08JvxFw8+IOf88sQvVtQjKOoOsWmMcmJccFZNjQjtZ+oFX
 pAhVS/eNs/+m336FBnrgIKdsk0tFvAQkURgNEoDA9NuElnnnAjLep7DqNK9F9/I/frOJ
 pU2bN6qEAaJSfDGgeDAUyZCd9B0rbe6GlOjIjK0HfgeAhOTxuyVDP3XTaB/RddYKR/zP
 EHsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUADUo/htPvyjG3/VqNhXON+Oq6FritPzTSzdw7lnT9h5xA76RRaDYnOHO5qHGPpDhlxZ/sctD8ecfk@nongnu.org
X-Gm-Message-State: AOJu0YyO/s+AWlDRnGa07+0g58kebp1lf5HTr0ncw0+3N9Obwd4FKzB3
 xszXrw7SSWh+7lAv0pMzhMmu6b3IahAHH5V2lOWuQQ2dunRjMPM8D5HHwF7P6ww=
X-Gm-Gg: ASbGncuBSIaCQvZBIi1yAtP6DvFZLahiBDxrPguvzbuplPKqau7Mpmg30Qdj7IDneiK
 iJyOAsOJ7xkvHvHrPG5eTOVDianwxrspazG3YFYkjTe089mw7uFzcsrt4dKn5aURhbmIKokz3+o
 GsrpxrkKOprEBCJJKLNPH55rVO10aoMg0e+8XvxHEGupdOkA2AX5md6VUXpcTpYO8ytNAyri2ug
 AUt8Rz9TsQ74dAEJgMpJe3QaMKmzEz9RLx2t4qrgPHIPQb2S+fBFyDV5yzsmvlH9xA=
X-Google-Smtp-Source: AGHT+IEPfaoIteOnCS1BZkrnCp2XmLg4coGnDJ6lEs9RhKv2NEsZx36bQjMcFZH/VY0iyaYox8xY1g==
X-Received: by 2002:a17:907:1c24:b0:aa6:85d0:1492 with SMTP id
 a640c23a62f3a-ab2abc6d423mr636122966b.37.1736441721609; 
 Thu, 09 Jan 2025 08:55:21 -0800 (PST)
Received: from localhost ([84.78.159.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9060bccsm87855766b.22.2025.01.09.08.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:55:21 -0800 (PST)
Date: Thu, 9 Jan 2025 17:55:20 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Anthony PERARD <anthony@xenproject.org>, qemu-devel@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/2] xen: do not use '%ms' scanf specifier
Message-ID: <Z3__eDp4hShe79Pl@macbook.local>
References: <20250107093140.86180-1-roger.pau@citrix.com>
 <20250107093140.86180-3-roger.pau@citrix.com>
 <Z3-sJMXpiFUoATHz@l14>
 <974ab6743d168d34babd458fe5e2e7766bb280b4.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <974ab6743d168d34babd458fe5e2e7766bb280b4.camel@infradead.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=roger.pau@cloud.com; helo=mail-ed1-x531.google.com
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

On Thu, Jan 09, 2025 at 11:25:13AM +0000, David Woodhouse wrote:
> On Thu, 2025-01-09 at 11:59 +0100, Anthony PERARD wrote:
> > 
> > >       char label[32];
> > >       XenDevice *xendev = NULL;
> > >       XenConsole *con;
> > > @@ -550,7 +551,10 @@ static void xen_console_device_create(XenBackendInstance *backend,
> > >           goto fail;
> > >       }
> > >   
> > > -    if (xs_node_scanf(xsh, XBT_NULL, fe, "type", errp, "%ms", &type) != 1) {
> > > +    node_path = g_strdup_printf("%s/type", fe);
> > > +    type = qemu_xen_xs_read(xsh, XBT_NULL, node_path, NULL);
> > > +    g_free(node_path);
> > 
> > I feel like we want "xs_node_read()" which would be similair to
> > xs_node_vscanf() but would simply return the result of
> > qemu_xen_xs_read(). This would avoid the need format of the node path in
> > several place in the code. But it's OK like that as well.
> 
> If you look at the other callers of qemu_xen_xs_read(), it looks like
> the majority of them create the path with snprintf and then pass it in.
> Or with g_strdup_printf(), pass it in, then free it afterwards.
> 
> So perhaps qemu_xen_xs_read() should be a printf-style function too,
> with its last arg(s) being the node name.

I just went with Anthony suggestion and introduced xs_node_read(), as
I didn't want to play with qemu_xen_xs_read().  Not that I think the
suggestion is not valid, just seemed more work than what I wanted to
do right now.

Thanks, Roger.

