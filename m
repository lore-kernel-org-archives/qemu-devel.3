Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9D606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jn7IMZJw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNB08-0006j8-W2; Sat, 31 Oct 2026 11:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xNB02-0006il-OO
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 11:28:06 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xNB01-0001Ny-5z
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 11:28:06 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso2133249a12.3
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793460483; x=1794065283; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EpTmCyMTHPJAs5oBCdZCY6DKr8jrslst61DcyAcdLXs=;
 b=jn7IMZJw/bpbB9U6Jvtp/uh38UYWEeeec7VWVjaMLBBous11RkpbOeDiEx7Jp/dqwL
 qKRGDCe4cT0e638wHG771d9h6wzq+y9jS42hPNM+LZErBmH5oU0eUtOmllaDmjQXK2vF
 AqxDqMPcAR422Pya0QuCBmcl5rSC2ChIBOdbLpOMYoC1627dRbuvapOtDgIbSRI51jtP
 5HqMbQiXq5YdxQN4C2nw9BNvWzP6Lm7N+PmtJQyDACNVtbSNEBfvY5yo1+0F0ej7jFR8
 G+wAcQXF8thxp1BXWfFFxI4ngWRYJn9pzHWSl5t67JleFSfmXcrPv0nzRSgBPIuETHW0
 0WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793460483; x=1794065283;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EpTmCyMTHPJAs5oBCdZCY6DKr8jrslst61DcyAcdLXs=;
 b=xB/Hy9UvfyaJS9S7+joBxF23kQdKq1o20WThUJ4LT1JpBRQqn9PvgNJK5TtdJWHgzM
 Jyc427QSgLujyZCbra01BmxKmDaYoMEbQhPv0cEtW7ve4JiPzGjPj3+ZQO7YShHnTBxI
 h/xNBHqoz8cBQhqYo9JCDALWUy1h4rFRmsuGosjXDnHZek9IqpIHsq+aPxdPbgIYe9H8
 VrSOrAB0UWV8WyXCVdGGiicNf1BnRmRuWrzuS2VpE7eJgvfY8rypLeVXDWh6px++Smte
 uQPiUOfrGl43F74Y2GGYLVJR7mlQFV92FjopG0oMA/x+4wS5lr+a8MIKc0AKVR69ndV5
 xGiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjDTTOsFGAPNMBii+aoRlWM0ZdEhEYxpWxjcxmKF6Z51+T3fM3avsf1hIF4f89FxG0NYYRnuSNK48L@nongnu.org
X-Gm-Message-State: AFq9FYKfImsqYAHcADkSadr1pa4mdDKi8Ubgu3de6UslErN/HhhMhAE0
 ROQccrd6hYgWAN11UG+IyqEF+oQlrckhY5DXcvIRhOpL3dMwNsBqdyR4
X-Gm-Gg: AYBFou3MufjuMOo50JJTfcPMXR0grPJDaxFvCXOyuUaLjvtb0HMS3L5/3LFJraf3LCO
 QnxaGk1pDdoT6IhzRQNr4A5lA1zql39u1KFgaJOvtFFpaI4ZZPZ1rrsC6gglovlaI3pHvYIH6KL
 4/1U5iYcyejEcgnFLgYqnGr6I6V549p5mvBzI7fylyMlhVwsgKEhg7IiljLKixsu3OL03crhaxz
 H5XHsAKH8Rj33W2a62paZHR2RTBHolGUl8NgfYnQV+vT2ZUTxafE9eXDaq1l7GRGTt/48+Gm7qD
 2n7jFaDKuXxdeHGyfF1u+ayJe11ZbfiNf2QJ2qIFBQPihtHpfqXqJW5N65yKAGZJ4OErPmKGoot
 Vg8wg/jfnQcuLub6V1VEkfoT7yHRsMbltmsQh7Xvi5iwZzZnFHJS5niFXk/wXF4ku1OPAuARRM6
 zfZ2fuMeMNPovEZVS6OWAnG2oC9++j3pnXYEoZdP9gsC7Np6+w9bN6CMU8ew2xblB6ru+wxqQIZ
 mnW9nff6AuR+I3kJ1lofUlOKArQdiNlrilVlnYF6dGNYe1DlX7R9LGOUgXOAewAPn6fznR6lzXI
 9HfEXK/up/vHcEBiWPv+5CyS3yiqR+3IU+YtZq1giArkp6pAi1ythtwnKu6g98JuqIRf+E+afWa
 fUhlKMhgl8p1aFZZTJ+g6ldWXxS8=
X-Received: by 2002:aa7:d647:0:b0:6b3:c382:364a with SMTP id
 4fb4d7f45d1cf-6b4d4d859bdmr2950758a12.35.1793460483082; 
 Sat, 31 Oct 2026 08:28:03 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4eca2080bsm1102667a12.31.2026.10.31.08.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 08:28:02 -0700 (PDT)
Date: Sat, 31 Oct 2026 16:27:03 +0100
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qga: implement 'guest-network-get-route' for NetBSD and
 OpenBSD
Message-ID: <auYIx1A9V6Ucbi-d@tulp>
References: <auVz7XxhHqAn3QEW@humpty.home.comstyle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auVz7XxhHqAn3QEW@humpty.home.comstyle.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Brad Smith wrote:

> qga: implement 'guest-network-get-route' for NetBSD and OpenBSD
> 
> Extend the FreeBSD routing table implementation to NetBSD and
> OpenBSD. All three dump the table with the NET_RT_DUMP sysctl and
> walk rt_msghdr messages, but differ in a few details:
> 
> - Locating the sockaddrs: OpenBSD places them after rtm_hdrlen
>   bytes and pads each to sizeof(long). NetBSD uses RT_ROUNDUP() and
>   FreeBSD SA_SIZE(). Add RT_FIRST_SA() and RT_SA_SIZE() macros to
>   cover these.
> 
> - The sysctl MIB: NetBSD rejects the trailing routing table ID with
>   EINVAL, so use the 6 element form there. FreeBSD and OpenBSD keep
>   the 7 element form and dump table 0.
> 
> - ARP/NDP entries: OpenBSD and NetBSD return neighbour entries in
>   the routing table dump. Skip them via RTF_LLINFO (OpenBSD) or
>   RTF_LLDATA (NetBSD, which renamed the flag).
> 
> - IPv6 scope: NetBSD and OpenBSD return link-local and scoped
>   multicast addresses with the KAME embedded scope ID in bytes 2-3
>   of the address. Move it into sin6_scope_id before calling
>   getnameinfo(), so these print as fe80::...%iface as on FreeBSD.
>   This is a no-op on FreeBSD, where the kernel already does this.
> 
> Also use ARRAY_SIZE() instead of nitems(), which NetBSD lacks.
> 
> Tested on FreeBSD, NetBSD and OpenBSD, comparing the output
> against netstat -rn.
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>

Reviewed-by: Roman Bogorodskiy <bogorodskiy@gmail.com>

