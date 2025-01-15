Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1E1C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 14:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY4Tj-0000HL-3T; Wed, 15 Jan 2025 09:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tY4TY-0000Ge-Hs
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:34:34 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tY4TW-0006A3-1d
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:34:32 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa6b4cc7270so972277766b.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 06:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1736951666; x=1737556466; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7++nirqBdRkMi+YWr9wvpdbbsVplcj+nbvkw0Rns88Y=;
 b=ND3nqSvC1aL8rn1t2sKTxG9N9zhrNBoKtax0It885sYP6DVFsGuHg8Pj61OVWFT8HF
 9JKZfGc99tzjQVuQ0mGgKkmT4Sw5IscVmchPW5/DTwKiBEDqfe0UOQux6gK3uFBd0Pwk
 slnt7TbawUfSpzPZNvIp+IN4G3jLtbG59/xKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736951666; x=1737556466;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7++nirqBdRkMi+YWr9wvpdbbsVplcj+nbvkw0Rns88Y=;
 b=pcogojiGIfSmlaRkxeI552tDtxO7mIKGLj4eheC2gM8qJUuQrdLhFOVIWNWaNYtLyA
 au4IChe58l0XKMnniKO5q93zpwCU94KXG/z59AaqUvoWr/6IlmKg5KhQToLBSefAYgLR
 gz2CXkPQTRl1FEKkEowRr2l7S1CE3XSxY7TvQysVIR4FCTWJSDqAjbMixVf3Mhhx+4D8
 kJHievbZpA9oVZCAQHb27WsroxvwnjeE/G5AHCr5SggtBtvXXZt+1ChKeEmvOkU+Efzc
 hld65gYNfw3MypBJOfsjacktt9mjJlQT/zIIh0aHOYmEGZm+/BJJoyjQ7aTqsBgDJPn0
 plLA==
X-Gm-Message-State: AOJu0YwbB46AE3577Fz1fh/rqBE8zXapLQrWqvlHbDY/DpwrW7lxT6bs
 R0C1x4jojeq332TvSMHOnZbrCjZ3/AcAcK+pDCU6bc7xlh7MbktkFZswHKdh5p4=
X-Gm-Gg: ASbGnct+NpLfgpQIXrcSv+LExdpZxalrS9vTm9pfEe3gkYoa6azDihJL6+CyCAEmoc7
 b+2SYzkZd9ukhS6ISDPskKNWPrDScyZbCceS+Y0rjeeJIr21m+ZfAYgolKg7GKoy75aUWM1hLdu
 h1elyQJliEAYwAYXM3c8tI/ETt6uidXyTQVdMGhcMqyQCnujgFeO4P7dM37YvggseGmJBknqqYZ
 zYw1Q2BDaLvqf7jOlO+bIbSMhjmsCV2+UjXmitwCvUm+K8wD1mJsrVN2DIxuQ==
X-Google-Smtp-Source: AGHT+IEROnS06Is+yJ/NYS7Lbm9RMq3n6vCGKiNQG/awRliXEYcSaYzplNZMMZfLGBtWkxyV4wv/kg==
X-Received: by 2002:a05:6402:2746:b0:5d0:c697:1f02 with SMTP id
 4fb4d7f45d1cf-5d972e1c54emr74030348a12.17.1736951664916; 
 Wed, 15 Jan 2025 06:34:24 -0800 (PST)
Received: from localhost ([84.78.159.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95624ccsm758876866b.126.2025.01.15.06.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 06:34:24 -0800 (PST)
Date: Wed, 15 Jan 2025 15:34:23 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/2] xen: error handling and FreeBSD compatibility fixes
Message-ID: <Z4fHbzgSmV9E5DR4@macbook.local>
References: <20250110093531.23221-1-roger.pau@citrix.com>
 <fc9b22c55eaaa79a3ef9829c270bc4b4e93be7a0.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc9b22c55eaaa79a3ef9829c270bc4b4e93be7a0.camel@infradead.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=roger.pau@cloud.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Fri, Jan 10, 2025 at 10:02:53AM +0000, David Woodhouse wrote:
> On Fri, 2025-01-10 at 10:35 +0100, Roger Pau Monne wrote:
> > Hello,
> > 
> > First patch from David introduces a new helper to fetch xenstore nodes,
> > while second patch removes the usage of scanf related functions with the
> > "%ms" format specifier, as it's not supported by the FreeBSD scanf libc
> > implementation.
> > 
> > Thanks, Roger.
> 
> Thanks. I've got a handful of non-bugfix cleanups to use the new
> xs_node_read in my tree at
> https://git.infradead.org/users/dwmw2/qemu.git/shortlog/refs/heads/xs_node_read
> 
> David Woodhouse (4):
>       hw/xen: Use xs_node_read() from xs_node_vscanf()
>       hw/xen: Use xs_node_read() from xen_console_get_name()
>       hw/xen: Use xs_node_read() from xen_netdev_get_name()
>       hw/xen: Use xs_node_read() from xenstore_read_str() instead of open-coding it

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

> I'm slightly dubious about the last one; xen_pvdev.c didn't previously
> use anything from xen-bus-helper.c and even hardcodes zero for
> XBT_NULL. And I look at the way it deliberately reallocates the string,
> and wonder if we should be doing that in qemu_xen_xs_read() for the
> true Xen case. And does it even matter anywhere except Windows?

I would take the opportunity to use XBT_NULL instead of 0 on
xen_pvdev.c for the transaction.

Thanks, Roger.

