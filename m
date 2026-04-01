Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37A8107639C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w81gc-0007t3-O9; Wed, 01 Apr 2026 15:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w81gZ-0007qO-G5
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:57:07 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w81gX-0007ej-Us
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:57:07 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2aaed195901so450765ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775073423; x=1775678223; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nsPAwPvlxYEGgMuILp86KWxfvXBJ8UtdIwq4FTF0TeA=;
 b=YMTd9Xq1Or1QAN9ICRf6tJMo52nIkf0Q0LTMCAAnGgy1CJ71HRhMubF6bj4h0oyinG
 3mY7S+SWHtrsrp8dmCL1KZYXstKBNksRl4w1NL5kPp8mhaJncuuf1zsMsmjJ5fXk0J6q
 blOAsTu/gOEhIlE5/o9zjwBYhrHhJv37mlPfJ+DpZaH5LkHVKvjW2wtSEAU9W5iluIMh
 DJko3b65WJ6YSZO1wdueNYLmKEDIvDyEiGeXdJ9r+CYn/NWcAxTIaDnYnTXe20nWZxpn
 Dzhi36lbtV/F9YwIuExwsCJzcxz/yVazTH44ATMEDkKJQpJNAJbvxM+LTP1u0a3xO9v+
 cA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775073423; x=1775678223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nsPAwPvlxYEGgMuILp86KWxfvXBJ8UtdIwq4FTF0TeA=;
 b=mjnmcvYOOu34VTjcR+wckJGDjeEeX2KFGRGD8AxgjmBrsRIzMHUl0FN2LbEwls9F1S
 VqY/aWJND/jM9rg9uoWUkpenThnNikhZAYlGCQenmkCfGroz4R6xEVMaq8Al7Z7sSaWP
 2sSxhkngv4GAVqCEmXQc/Dq5fegEsxj2hSA7NKYkSV6Gp7GqsZRFBcKRaIKmTvxU8lu7
 F3dW8sRUDc7l5j2iMmBaR+jdXycYNLxF47JoRh7rXYIVzrYER6BKz7/iYqnk3bCRO1/+
 K0BldPYp+P2fgCBySqwBb8Csh07HjJv6qbJDYGul1tXT2H1mZG5KkB1DqLu6L3whE83m
 xevg==
X-Gm-Message-State: AOJu0YxdAgS8l6vYzrmu22Ftgm8i7Ade+5Y97QemqiDuUmqYTWdbkajS
 6aDattDuIcb+djpIp6nDVuuEX60j5ZtXvmDjvsUWWsA6nmsTbRxbPsVj
X-Gm-Gg: ATEYQzyHVx3+76u01536ho0mlkgXm7NooYHHNB9hl5mvsZfkOLaHfFajBB+4KpanN69
 DmRLt9rHS+KKSPqfPq69eBNKnU0j3/u/lFiUMfEDyqXWhOcH0u8B7FLICEYW6Gbx5MD3/qeylLL
 FsyBg27ULIxs2kTZ61DcAhfMYpwEjyxuJTxlrGV0vI6Bdmf5UXPIFJYR+TywQxJEJ2SI7UuluFo
 WEZGnJR1lqeVv0Z0HGFUGOttL5/91hGEs5nXePbK6lVUU6GwRLX2UE7WmPv73ivcWsTVIHtyUsO
 xQF3dGLV6krvSYxJxbVvMJrp6WTfWq4ij7s6GRH2/X3kpbsWGEdOi8zWjXa1cJY3Kx5RNpbRw4Z
 esZexEYl8Kt+G+WFyAvNh7MzErJqZNS71nFKf3ig7VFH315NR3vFabynmtzZ+vvyyR06bxekKGA
 ROqKXvPiuGKYQOP34Sg+cZAHdTvSiyke0hC3RNUa2QHw==
X-Received: by 2002:a17:903:1a2f:b0:2b2:420a:b48a with SMTP id
 d9443c01a7336-2b275b6d39amr4951895ad.32.1775073423441; 
 Wed, 01 Apr 2026 12:57:03 -0700 (PDT)
Received: from localhost ([42.118.191.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbc58sm5463855ad.78.2026.04.01.12.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:57:02 -0700 (PDT)
Date: Thu, 2 Apr 2026 02:56:57 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] migration: fix QIOChannelFile leak on error in
 file_connect_outgoing
Message-ID: <z7dm2dku7soyuadyudp2uhe7ekssnugowwl6pzyp33o42b5m6g@5t7gb4z35fj6>
References: <20260328121215.159532-1-vikingtc4@gmail.com>
 <acrimq2TDEs6KHuE@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acrimq2TDEs6KHuE@x1.local>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 30, 2026 at 04:52:42PM -0400, Peter Xu wrote:
> On Sat, Mar 28, 2026 at 09:12:14PM +0900, Trieu Huynh wrote:
> > Commit 03a680c978 changed g_autoptr(QIOChannelFile) to a plain pointer
> > but failed to restore the necessary object_unref() calls on error paths.
> > Previously, these were handled implicitly by the g_autoptr cleanup
> > mechanism.
> > 
> > Two error paths currently leak the QIOChannelFile object and its
> > underlying file descriptor:
> > 
> >   1. When ftruncate() fails (e.g., on character or block devices).
> >   2. When qio_channel_io_seek() fails after the channel is created.
> > 
> > In environments that retry migration automatically (e.g., libvirt),
> > these FDs accumulate until QEMU hits RLIMIT_NOFILE and fails with
> > EMFILE (Too many open files).
> > 
> > Add the missing object_unref() calls to both error paths to ensure
> > resources are properly released.
> > 
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> 
> Good catch.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> I'm just curious, how did you find it?
> 
Thanks, just by change, while researching the codebase and blame
some locs :)
> -- 
> Peter Xu
> 

