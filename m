Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD92606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=emiKVQXE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOXwT-000295-Q4; Wed, 04 Nov 2026 05:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOXwQ-00028X-9a
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 05:10:03 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOXwM-0004iA-P3
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 05:10:01 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b305312e4fso3730937b3.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 02:09:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793786997; cv=none;
 d=google.com; s=arc-20260327;
 b=SwXrsWi+34Wc4LCsyphJ6xOVZc7C0ip+sOax8T7mPSISo7VykB1lqXgWhc5YgxvqZN
 /PLIJIiSdFBKAsRzMbU2s2fZYP8SVT/s2ADUTQvevt100v225VFimWMsWh1brdoQXOaC
 ytEWjMMkA3MInGjSVDIUJJSNN8cuDY5uQj5VusG0OG9xnaCwYBPZbdTPoWJ7svd6ydGl
 GfHHedsmf0OIflUzJVzGSvFIM4WIXe4aEewkynn9f0TRDnQASgnBN8y0Co6pSgpjmZ2Z
 BN8BgxmDLpPBQZ/f0F6ZMafubUp6DyCQr/KBmlnwQQYI0BcnvSpFvb0h6C1F3jopKNGU
 ukdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H5IZSgWMigLUY2VoHDxtElM6kmMiiYW0xRn7FAZdL1E=;
 fh=SlDoQItQG4p7LdqrQL3c7WvqMiQdiz//f6Mq3ioTtkQ=;
 b=gvz/v6r+Fn+wjRH7edsJeJuKzAQe9u3vfTIAVoeghWJSQ4Jk20+csUI1WICOlyvVNA
 a5YC0O2EVCCh9svixteaFVkHk6TuxR6vhkeHx89Et2IvotUN5Er6r+nzNGC0aOOMhqg3
 35p4ZNHCaUA0qo07Nn4usc+9i02YNYddNWbPeQPVPpl8rQcIALN2inFt8pVjGrNF16YY
 2JP4MQVoGgQUcYXV9nq8WunFPCHwxdHwLf8ejBdU6ZXgqzcuGCALZx45m4fQXWkh0ax6
 LLUzWdrVPUbhkszgItupo+NrdN33xvqJPw09CXdh6FXMK/5M7Eek1x4DKRYNQr1baoUN
 wmcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793786997; x=1794391797; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H5IZSgWMigLUY2VoHDxtElM6kmMiiYW0xRn7FAZdL1E=;
 b=emiKVQXEsF3ZcKm5M1DKvKrihdJ+e0SJlsfBJV5E5isB2WOsu9hv5Q9S2PEw3zhkYK
 N/vyT4GXBzMG35EIwD+842utBrD+XUXbyWlVi7Qh9IxBhI5OC5YEF5eO1LRnktGhWGbu
 4aEvwKMtWBialXYLaZoDZgdExb4Wrik+hl1SljCHvtivDgTYu9JbPNEaSH2K2rRaWCY0
 gLhWwzdxzn7Cvf9EmTKSZIUkMiVz0D4apEf1S4huadBuRMB6bFDoenbZmE0o6thk3JPg
 ddCiDZMIZzUOwH1Griw9AifrwHwnIg6VShYr3CWGJ0Jw0IRoMcuYBPIji7xsb/Rfi83Q
 oekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793786997; x=1794391797;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H5IZSgWMigLUY2VoHDxtElM6kmMiiYW0xRn7FAZdL1E=;
 b=KTIfG8nBbgoU4/RJHT4w8pG4OgXvv84NWeLI1HZhg31HiKRcqefa4unEUs4ceos96o
 kcrtmdsTNxWgnGMThq4aUV5QqbcNRFc9D3U7ayCL+X6mFEKgapVqtLbBGeNOY2mpw16s
 VKTEjLXmyCXLnCjHltvxeMgYp0ZuET33NpRdKO0pXuGDlS7h6Qo9dOXn0OLdloGsYYO0
 rhMjl+2iRDuwAZayS3r5dTKgYn9qgP5Pn1v+quMKYQoVN6rTJep7WPg8pjqJAOMb/E/3
 WRXku09uPK44D9QFrOqDBjgKY+LT0FWaSnPS+3KbJApmDDf64VUBgtJNIU0ka0zvk2Y9
 ihcw==
X-Gm-Message-State: APuU4Z/AQIMGDfz1vUSFXJ/ak4hIFvd6iYHFvMo/quw9Y+NpWFAWKeq4
 2TqHRdz6s6LFRnM1tBY1THqFbLzfUBRUrRejH/lHcqP7YN6tZXnqT+Soc3bDKudm7hH3c0v15/n
 4NFbbt6xIn6SQ4hgAyiVL/TXzvHZdRfS3zshfUHLuqQ==
X-Gm-Gg: AYBFou30FukKsq7AMxmr3B28mOTRwjJXCuvpN/TvKjUSWYOPHl6QQIiLuN/vDlQ6jTn
 YkwOZaMbkxhTteftFXgzhPo+0GflPNRb4nA21NY8OqgG+/2zmTzA+OvoDFXaIkWp8uTZmwAQXw0
 x3tW2iGTkvdLSjOq2ThkuRLpPjixXxNHAIQbDFTYuEqdChXSjYS9YXvuqJav4mMp5d+9gbAJChI
 WE8Bwdok74dDT961BqHD0Ae4M1LXdUpMaNnPLo6hzQ1LFmbGWz90NyRxmrUrITsO12O2maE+yXw
 c1iICPVl3NXCH9jVsc2uYBoUBwDBhW9v43uW+YpAw58n6WajdM1k2xut0mer51l4aent5RmrgNc
 04+MMqZIbTiUUXpY0hux7qbhzMeyQTrrFvfW4r68C3bPfufFiiqfAS8jMr+yAoaLSEL7N+HfCk2
 WoLjirABwurC1UjkSV+0v0JoSx7UGknWdGAN14m8u5iw==
X-Received: by 2002:a05:690c:8683:10b0:8b0:dabe:cf3e with SMTP id
 00721157ae682-8b2b6774760mr70595887b3.49.1793786997007; Wed, 04 Nov 2026
 02:09:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260920-eth-v1-1-ddd05ce24843@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA-C1c=sH+E8_4GfN5u-+66OANDrLXyBotQkzveOM7pbkg@mail.gmail.com>
 <472f5ab9-336f-4175-b4d6-53e19793d26b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <472f5ab9-336f-4175-b4d6-53e19793d26b@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2026 10:09:45 +0000
X-Gm-Features: AclHuK-FX_yue2YDQUgN2QjwC8pi_LxRowcLItc6PIwjl0lpurX_8Lvb3WWYjQI
Message-ID: <CAFEAcA8PXeFboGF0jiKjfbDpFu8oEU2hpcPJwk9y772V1E1srQ@mail.gmail.com>
Subject: Re: [PATCH] net/eth: Add missing L4/L5 header bound checks
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, qemu-stable@nongnu.org,
 Lazymio <mio@lazym.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 03:42, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/11/04 0:59, Peter Maydell wrote:
> > On Sun, 20 Sept 2026 at 11:52, Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> We already have some L4/L5 header bound checks but they were not
> >> comprehensive. Add the missing coverage.
> >>
> >> The IPv6 header parser incorrectly derives L4 offsets greater than
> >> actual values. Adding a bound check without fixing it would reject
> >> valid packets while fixing it without adding a bound check can result
> >> in an out-of-bounds access, so fix it along with the bound check
> >> addition.
> >>
> >> One fixed problem of the IPv6 header parser is that extension header
> >> size is not properly computed for the Fragment Header and the IP
> >> Authentication Header.
> >>
> >> RFC 8200 "Internet Protocol, Version 6 (IPv6) Specification" section
> >> 4.5. "Fragment Header" says the Fragment Header has a fixed size.
> >> The byte represented by ext_hdr.ip6r_len is reserved and "ignored on
> >> reception".
> >>
> >> RFC 4302 "IP Authentication Header" section 2.2. "Payload Length" says
> >> it specifies the length of AH in 32-bit words (4-byte units), minus "2".
> >>
> >> Another fixed problem is that the parser continues parsing extensions in
> >> noninitial fragments.
> >>
> >> RFC 8200 "Internet Protocol, Version 6 (IPv6) Specification" section
> >> 4.5 "Fragment Header" says the noninitial fragment packets have the
> >> Fragment Header containing "the Next Header value that identifies the
> >> first header after the Per-Fragment headers of the original packet"
> >> followed by "the fragment itself."
> >>
> >> Therefore, the data following the Fragment Header in the noninitial
> >> fragment packet must be treated as a fragment instead of another
> >> extension header, regardless of the Next Header value the Fragment
> >> Header contains.

> >> +        case IP6_FRAGMENT:
> >> +            bytes_read = iov_to_buf(pkt, pkt_frags,
> >> +                                    ip6hdr_off + info->full_hdr_len + 2,
> >> +                                    &buf, sizeof(buf));
> >> +            if (bytes_read < sizeof(buf)) {
> >> +                return false;
> >> +            }
> >> +
> >> +            info->full_hdr_len += 8;
> >>               info->fragment = true;
> >> +            subsequent = extract16(be16_to_cpu(buf), 3, 13);
> >
> > I don't understand what this is doing. I guess this is the
> > "don't parse extensions in fragments" change mentioned in the
> > commit message, but I don't see why this is the way to determine
> > that. This is testing the "fragment offset" field for being non-zero,
> > isn't it?
>
> Yes. A nonzero offset identifies a noninitial fragment. Its bytes are
> fragment data, so we must stop parsing extension headers there. For
> offset zero, we can continue parsing the headers present in the
> first fragment.

Ah, right. I should have scrolled further down in RFC8200, it
has some helpful diagrams of what the fragment packets end up
looking like. I understand what's going on now.

> > Otherwise the eth_parse_ipv6_hdr() changes look good to me, but I
> > think they're complex enough to be worth having in their own
> > patch separate from the eth_get_protocols() changes.
>
> That makes sense. The changes inside eth_parse_ipv6_hdr() need to be in
> one patch, but it can be still separate from the eth_get_protocols()
> changes.
>
> We can use your patch for the IPv4 change, as it also adds overflow
> safety and the additional sizeof(*iphdr) check.
>
> A separate patch should be written for the TCP bounds check and precede
> the IPv6 parser fixes. Correcting the AH length can make a TCP header
> reachable in cases where the old parser's incorrect offset caused the
> header copy to fail. Without the TCP bounds check, an oversized TCP data
> offset could then reach igb's header-splitting path as an out-of-range
> L5 offset. Keeping that ordering avoids an unsafe intermediate state.
>
> I plan to send a patch series featuring a patch for the TCP bounds check
> and another for the IPv6 parser fixes, while dropping the IPv4 change.

Thanks. Feel free to pick up whatever of my series makes sense
in that if that helps.

-- PMM

