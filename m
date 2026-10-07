Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29219CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOXt-0005RC-A2; Wed, 07 Oct 2026 06:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEOWj-0005FT-DG
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:05:43 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEOWZ-0003hL-Sx
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:05:29 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CC29D7A0248
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2026 06:05:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 07 Oct 2026 06:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791367521; x=1791453921; bh=1ElQgkgTnRrbfU+LPnajfIpKhzbTjZaq
 CVJDX71zB7U=; b=SickJmIefC0g7m5ohcYFV1HPmLZpG7KIYMpTdWrwviQoNjFR
 7G4UfuEPNf3w2S+QSYQqo27zprHkTUXv9zckr3Hgj1wyAv2zF7NIF6T2oME7uaAL
 j9VofwAdBYq8kiwDb6mmwajkDH8ZTcZLTdFDUoASdRop9k6+v5jh6fDbrqL9B4dg
 kcH4HIDral/9bC0NKDqIXTDzKi3ljyyteSE9G6if1yQNbS5lDUx7b2ompclTnu/9
 RXN7u1dv7Qsif3NicNWTZQsW5A0adqceUmIDgCOxnXGv1hArWI8KBFdGDqa9GExK
 yVEr+Sp9PyUvSjh3mTPlIaKHKqKKgWp/ZRAxNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791367521; x=
 1791453921; bh=1ElQgkgTnRrbfU+LPnajfIpKhzbTjZaqCVJDX71zB7U=; b=X
 p39Wl7rqr2+rl452cbJuSZa86EwjrPzsR82b83zjikayv59GG5Z5APc9rQhRAGDL
 TJ+W6wYGCxEaf9xkQ0BFq+FYrZ1b31spVEgQqoBzVIILgZaCQVpBbGerHvN1alWc
 HH9R0lueyat8b8xDbajwPVx7x+6EYPrXWFA5UUxAgpihDvJnEiLpB/l55KZgfvqa
 w3YkBWjTiRziosAlB2ShHiDKuf2ARGo8jhuogmtU0Hy6MsLlLeRfJYZuLKnfYe9K
 jHv/PAF+coWIMr3kFZ1ocNutckMXF1LrEdxb2oOZw6UxyTQcVUSLIXpFYKaSXLlO
 Qna8pCVDFoscOWkEkUQHw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791367521; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:jn44nDxD3aB6H/p0bunImRfdeNrjaOMnlr6yk1KdHcp8g62
 RU5qmJ0tAKomc4uvFPR1s9+J017XBDXtOWjfI8SPou4FDJggfaY6pWQICmNXjFsA
 mh2jWY9ZUOxr6J1q+x0JI/a0W9tVsUvOg7NddBvk2mIqaZtu6hY89cCTucueNswE
 nYHu13curK6nKwrnpBWpW22NfAwDTVfqtanjtN2HDOMwaNu2KiZU3K24PjO59QpP
 zbEbNvXDKjCEZg0oYheh/vyMELqR5VbDu64/hrh0PW6NJUApkQeZA52jixsLPA9P
 DqP2RiWNhN4UYs8fYH7a6is26A9FRHuWvADhNWA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:uNN55SAwG0HvRWssl5S8vMepdWWS4OnZPp1skukjnQw=:1ElQgkgTnRrbfU+LPnajfIpKhzbTjZaqCVJDX71zB7U=;
X-ME-Sender: <xms:YBnGavLmZ9joZ_EkvWkw3x1Q700mkiSABfMgO1puoH7j8x41tiOWJA>
 <xme:YBnGaiHG_dTCZucu1-h7YWOJzgv62cFs3rrfW1PDWTTpsHbF0SQ_YQcrPzJ0W28R6
 HdzghwNakfVIsDRwobcVopWS8QzHmbTZp-1P3i5I0wZI1hJA_UZQ1PE>
X-ME-Received: <xmr:YBnGajx1JShv8Og81AjaJZI6CuTVjKGzYdsCzCQlUUIUInp1zPJK0-hgOtI_-yMRj-x9WC89Hlty>
X-ME-Proxy-Cause: dmFkZTERQ3z818WTsXAmxJqTaoEOe6PosnZrz+nQYEGtCgjpTZc4BArGD/57VGZGkop1MX
 0tQKdFAN5py1t4DXITuAG/dyuCZ383bF4v/ee3CpiuPROZKb08IH85guO4KlJe4yGfWs7i
 FzXgNlSCyGJHtaIhfjncoU+2CiUpTNzgl5iiz1orB1kQsAq4ZsE3iXb/rf3aXPsLe37+09
 09KqYHfVeyzVCZ+HZyy5NE4ixSsuqT5MkVU9s7GjNBEmlgC0kRjzGQWkDhLrtb89JtZu2i
 au64gJ6BkaYREqEDspepFUxwOk/BUwgqArkje2/nA2CFyg8CcYdHj7TpDb61KTo3QiCFpF
 IkQEFVThjkozD8qbg2dA6gtlbKvJtZiJHYk8m//x77ljRpYUZzGcjse8I7pQqZBEle3Wji
 cXollIbvGtUwvrsOz2LnycFuNsXGfZrtDHRXTVkd9gAiSyKhfQI/wNz96dc0jxAgOkb0jw
 dQm/r/7CEEa/O3wTjWwYV4eW4IG21OSzZYLI4U5X+Laz4o0S/+0ZPdk/iEWHbtr55FY2aO
 Qex0qCtBH9YkK7fH8DY1AjOtn0hye1c28EZUkbk+ANbv+zwqpLoWxsvpS7g4g2Z6erno5M
 UmJdzOTLQx1Nx7bbdH1Tkx2HSRDQlpetlP+lRvEpdgXmzIDNyYmmFYSyLMnQ
X-ME-Proxy: <xmx:YBnGar5Cejt957OCghVb_c5HjqO-Tom8rmIm_W7pNJ6szF9SVgVtiA>
 <xmx:YBnGaofuvswZ2Zr7J2k0UODYpucXK0Rttp074ztMniUOVfZ9YfbC6g>
 <xmx:YBnGaiHkt8gsMaJff4PGGpZkY57lZG11VeW4VTidxMsX86FdDSrVTQ>
 <xmx:YBnGao4nYU0CmRSZBgFK0up35oGhcK_XzFd37uklIx9dCfvycwdvvw>
 <xmx:YRnGauJgNuLZUZ-WPwTxyYcsXltUq5WTl1l2jvfgYt_nbED8wZAKLYCv>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 06:05:10 -0400 (EDT)
Message-ID: <ca89932e98ad61ca4f4baff2add53558ed6eb712.camel@alistair23.me>
Subject: Re: [PATCH v4 0/3] Add Model for Tenstorrent Atlantis PRCM
From: Alistair <alistair@alistair23.me>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman	 <mpe@kernel.org>, Portia Stephens
 <portias@oss.tenstorrent.com>, 	qemu-riscv@nongnu.org, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu	 <chao.liu@processmission.com>
Date: Wed, 07 Oct 2026 20:05:03 +1000
In-Reply-To: <20261001-atlantis_prcm-v4-0-95d33c470eeb@oss.tenstorrent.com>
References: <20261001-atlantis_prcm-v4-0-95d33c470eeb@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.159;
 envelope-from=alistair@alistair23.me; helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Thu, 2026-10-01 at 08:52 -0500, Anirudh Srinivasan wrote:
> This series adds a qemu model for the PRCM blocks present in
> Tenstorrent
> Atlantis. This block controls clock, reset and other misc
> functionality
> in the SoC. Linux support for the Clocks/Resets served by the RCPU
> PRCM
> was added in [1]. This PRCM model has been tested with a linux DT
> that
> enables the PRCM and sets the UART clk to the one provided by the
> PRCM.
> This DT will be sent out shortly.
>=20
> [1]
> https://lore.kernel.org/linux-riscv/20260306-atlantis-clocks-v8-0-6c9b14a=
4aa8e@oss.tenstorrent.com/
>=20
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes in v4:
> - Addressed style comments from Joel's review
> - Added error handling for sysbus_realize calls
> - Dropped redundant realize/ops setting lines for PRCM subclasses
> - Updated PRCM min_access_size to allow byte accesses
> - Added back clock-frequency prop to UART node to allow linux boots
> without clk driver
> - Added back bus clock-frequency prop to I2C node
> - Link to v3:
> https://lore.kernel.org/qemu-devel/20260904-atlantis_prcm-v3-0-8bf20795a3=
81@oss.tenstorrent.com
>=20
> Changes in v3:
> - Rebase on top of Joel's socify series v3
> https://lore.kernel.org/qemu-riscv/20260903055131.257903-1-joel@jms.id.au=
/T/#t
> - I2C and UART now use clk provided by PRCM, and periph_clk is
> dropped
> - Addressed style edit comments from Joel (comment about clk IDs
> coming from DT bindings,) and Alistair (drop size from trace prints,
> move decalartions to top of function, use PRCM_DOMAIN enums)
> - Link to v2:
> https://lore.kernel.org/qemu-devel/20260817-atlantis_prcm-v2-0-ffba0b9444=
19@oss.tenstorrent.com
>=20
> Changes in v2:
> - Coding style edits based on Chao Liu's feedback
> - Changed prcm to use Resettable inferface instead of legacy reset
> - Edits requested by Daniel related to tracing, pll_en logic and
> unnecessary switch/case statement
> - Added comments to some of the magic numbers in the reset values for
> PRCM registers
> - Link to v1:
> https://lore.kernel.org/qemu-devel/20260729-atlantis_prcm-v1-0-502882933e=
51@oss.tenstorrent.com
>=20
> ---
> Anirudh Srinivasan (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/misc: Add Tenstorrent Atlantis PRCM mod=
el
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/riscv/tt-atlantis: Add PRCMs to tt-atla=
ntis model
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/riscv/tt-atlantis: Update UART and I2C =
to use clk from PRCM
>=20
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0docs/system/riscv/tt_atlantis.rst=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0hw/misc/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0hw/misc/trace-events=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0hw/misc/tt_atlantis_prcm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 428
> +++++++++++++++++++++++++++++++++++++
> =C2=A0hw/riscv/tt_atlantis.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 125 ++++++++++-
> =C2=A0include/hw/misc/tt_atlantis_prcm.h |=C2=A0 51 +++++
> =C2=A0include/hw/riscv/tt_atlantis.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 28 +=
++
> =C2=A08 files changed, 632 insertions(+), 8 deletions(-)
> ---
> base-commit: b23a62773a7856299cbb3782e64968b6a92c792f
> change-id: 20260727-atlantis_prcm-b642cfb37d57
>=20
> Best regards,
> --=C2=A0=20
> Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>=20

