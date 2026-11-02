Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C37606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dUz5cU7y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNp0F-0007Cd-1f; Mon, 02 Nov 2026 05:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xNp09-00073Y-Be
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:10:54 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xNp07-0005Hj-1j
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:10:52 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c2e8c710847so375272266b.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793614249; x=1794219049; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=muR8E2ydyvBE0liuNworDRr29WgHGm3mbnv5oXsv97U=;
 b=dUz5cU7yuVj9grM1O9Uy7yPOFp2Qt8xtbB1xG4XlM3w/iKS4nawwqSSaGlAKJKpzEN
 gcBL0JXVrMuyPinHAtc3Aj54JV1u6A0RTdCg5akAgtQn7ztahEw5N2IB4dOvb4ledFOa
 g1L5j2l4I1X2ojE0AFN6BHxQo+Mw/ePi/OpN9jeGe03Qh4d4GGen6igSNTs+mXVXcX6x
 VaYev0ZKIbSRIYq7a8UUBgIYl4pnWcQWKxX2RAyZuKBKL2epBzeJ5FTLwshpwsJC16uN
 SJzVVbBhgjFQZy3KhXZrfIAoRqZss/xcxCzu0avNY7VyLEMkpmzLweFXBCSi/iUjl7Wb
 Ef7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793614249; x=1794219049;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=muR8E2ydyvBE0liuNworDRr29WgHGm3mbnv5oXsv97U=;
 b=LyHSLq4bHvTtV/AhBM76ndUG16yn2/23AOsdzrvd5Zma3N/icbcrX2qG5I9vUe45fm
 QoT59r6GinNu5z73T6AeFLnbmuXyiAChThlv3CsAa02uVPdyN1vcoRyam7ioqQS/N532
 2ZuVY/9TiPn9mWmYImES4tm1k7DWSfJPjgq45m9k6UxFGFcK+0Kxe9PTDk9HL0tR+Kv4
 ZMfI61X7U4HjCXoZAIbHVzEn24atnJGJzxsi0cUpkEfuxsyXc/FMadHmcmIG0i5RnKuG
 2IU3/Grnq/Kvpl8XPMYVvaDvjtnlOWfM4ecMZRAUCAXCNzcJQEBpbP3fL34d+gQG48bw
 0LZw==
X-Gm-Message-State: AFq9FYItRNOjpYGzofv71QlOOFkl6I4Iyhg9iR8jEDma4ysPe+6tIvUY
 KOkdyfR3naMLQ86B7r3MGeLkZxbai5kDqBQhSPbq1zvPBlMSZOWO/THb
X-Gm-Gg: AYBFou1MO0k4DvHWflIqoNBnxtuInqnrehLycJVusndWvIb4yDvlPirXl9I0+pK5YsA
 LBkr54FbFzSaRHoQb2mEd3qrN9WsmMRV99jkeDMHH+mE4mT/GLHPv72uiRyhryqxxhk/7nRxaKH
 h17Ayds9IeUUtJ73XpPdtiww8laclRqhICVsVjqa4A+oAp63ePT8Qv5ietrszN/oKLYzWpTKBVg
 gKf8NZg6TRY2jLzG7OEzaGL1z0mgfeUSwnzeEN45WAPkN+p8p6Wiq8oEN8Rg//In/oQcH4Uyt6P
 qVNLgQt0moVMIAe090URhytZJrmEbAckgdM/OQbPBZie0HDDOyJfor6/fH0fRMfhTv15u/Rs90o
 qjwzqIAh4wY8dl+LUOxFVDbIn77l1mkqkwskjy2511kZYIALr1jo8U9fiTm87GaTWv1hRN+2uQu
 TQa7QT0ZNwNw/inF7E5sejxFX0btVKCtkLtk7B6eKDdJtMHZeq1vBgLPUSuUVpINQ/opB2asn4K
 D4bzaUw50x3LVBUINVT2t8UaXkw91aFyasWzSRRsq34Lo9v/d5nAvlqWkmU4izYVBS5E7qkrUzl
 Uy+4el28HlDdsd0kPQLhK6vRkLRY/Tc6qFhcjfrq0++MbpqiPF2ROrcv+XpOmvHPWCR1kVrDkfY
 u3l2KFPI/tIKvxPH+C2hwS6Fj
X-Received: by 2002:a17:907:3e22:b0:c40:5ee3:8698 with SMTP id
 a640c23a62f3a-c4ca7a9ec9fmr770735866b.31.1793614248312; 
 Mon, 02 Nov 2026 02:10:48 -0800 (PST)
Received: from tulp
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4ec9eebb0sm3009828a12.8.2026.11.02.02.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:10:47 -0800 (PST)
Date: Mon, 2 Nov 2026 11:09:43 +0100
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Oleksij Samorukov <samm@net-art.cz>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] qga: set FreeBSD virtio-serial channel to raw mode
Message-ID: <auhhZxsqfkPNt8T7@tulp>
References: <20261017201905.12211-1-samm@net-art.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017201905.12211-1-samm@net-art.cz>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Oleksij Samorukov wrote:

> On FreeBSD the virtio-console port is a tty, unlike Linux's
> /dev/virtio-ports which is a character device.  It defaults to canonical
> mode with echo and software flow control enabled, so the QGA stream
> protocol does not work: the initial guest-sync handshake is held in the
> line discipline and the host eventually times out.
> 
> The existing FreeBSD-specific code only clears ECHO.  Configure the port
> the same way as the ISA serial path: disable canonical mode, echo and
> software flow control, and set VMIN/VTIME.  Use TCSANOW instead of
> TCSAFLUSH so a handshake that arrives between open() and tcsetattr() is
> not discarded.
> 
> Tested on FreeBSD 15.1 aarch64 under UTM/QEMU.  Before the change
> utmctl ip-address timed out and the guest received zero bytes; after the
> change QGA commands and guest-set-time work.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: c6cd588bb3a29a831c862780631a7d2145ade5de ("qga: Add initial FreeBSD support")
> Signed-off-by: Oleksij Samorukov <samm@net-art.cz>
> ---
>  qga/channel-posix.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Hi Kostiantyn,

Sorry to pester you, but is there a chance to pull this in while we're still
in a soft freeze?

Possibly along with the illumos build fixes [1].

1: https://patchew.org/QEMU/20261015173250.65942-1-bogorodskiy@gmail.com/

