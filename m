Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515F606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 01:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=Tqr3nR3a;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p1TXd0qk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJGN-0002Il-0U; Sun, 22 Nov 2026 20:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xVJGH-0002I7-N6
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 20:54:29 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xVJGF-0006IK-O2
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 20:54:29 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6158F7A03DC
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 20:54:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sun, 22 Nov 2026 20:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1795398866; x=1795485266; bh=9nIBKR2E1w0/MisCOlhfnME2Gm+f+Ssf
 68pbQbqpYlI=; b=Tqr3nR3aS88DwAkQZo0Ttq6FnUIDUsJDNyuln29c4s16CiuM
 psA7ei2KHqmpRaiOjFePRgm0BoXe8ARpMjTfwl9UIqvGgsEGg+U4JlhCbV8ad0Yi
 O3/Gd685CyVFBSvW0v5SXm4FBuz3G3e8cVYjRs7uKBcrx6IhS1rzw9wZZwAUEGg9
 7XOoYoOXj2e+KoHEMA2dKEIJHVd9BzRKzMvNjYs52wOOwfd8gueA3GL78feGqRRk
 ok8hW9XCdzDd8AKlMoCBNkN5n795n/zUBNY8lRx6DT/O8RhUMbS1QCdKZ5qdikZM
 dicSbxGvES0p+PWxEHrTSFn72KbBMSozs0Mz0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795398866; x=
 1795485266; bh=9nIBKR2E1w0/MisCOlhfnME2Gm+f+Ssf68pbQbqpYlI=; b=p
 1TXd0qkZMnilqHskaYwC1bRh03S0wV91bqKiT8N3sFKb3aWSCNw7Png5y6TXEvoy
 1Kf5ZVGdKeZLgRyUItseDpFZ24UNkDtdGoSg3WpcTRL40dEb/11cf9sgqJxy1BJa
 2tqz1WdWgyWGDugXdCw8FQcrXGT/wKNWoMFmscmX2GeClHPO6IW8djSlMuVdLs1K
 4tNqEu972Z4qpOoyha7Ukd9HB0/3wAi9D2P/GEC2N8QJICHyPbOPKyXn+avjIfwY
 L7sUXXVdWwB6mp/24TEMT9GVc9SlGW3Jy84Jr8xOOy0PMHZdpNab86BlDiqoYc6F
 suYuCOzlBChqFf7CJEKfg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795398866; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:XtthFlehVatYMTaMCVjcnaX0BlzvSJjxYt5uEtIsjSw14Eo
 uphrvXLQslVjAgSp7qdtdnHaLUikwEjFwG50vH2FbB0eM00bqiVcrZavAGr0dG7J
 gfG4aGqYlasvT/ujz4RwGSCYWpPDjYq0ZEbRxwBtoNnzdstg+M65z0hT7zOB9JKf
 9rcfXgOmawWDrxAwwPEAoSCYeHkWylp0mWAbQgoq0YhHph0tL7XuEnSZXn/54VA6
 vcX9nGiYDSrAVMDMC41VP/ClHU5eVxLt6yZEBXRmpYIadUnFpajrDg6fc0VrbDZb
 LWLIbkgKnJItGGmB2fKFBWtNv/GYbnACrNSRB9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:3qAd2HPPzpzgxvRkRlLOa8BPb12SmDHTJZnTtJlGMlQ=:9nIBKR2E1w0/MisCOlhfnME2Gm+f+Ssf68pbQbqpYlI=;
X-ME-Sender: <xms:0ZwDa-7vrJXR4KhWfkSNrW1Fuc4VD0gvI_ZuckKkxEEGkrXmE9TISA>
 <xme:0ZwDa-R6BAAPuOrnrrYQDj4DJy1OjQNM-47RQ-hB1yP6qWyvQYBM73KuYLsgPvoPA
 f72i3c008OEOFw4xrFBt6ZjfFX3Olts4A6aZPjkucNAWmiIQHgWcl_j>
X-ME-Received: <xmr:0ZwDa5tMcYdtZVQ4uW6hvtzm-Hqdb8M6MX7Z1IOLd0rDXNg55kJbav1Rlf6eRLJtNGOZPCefuJ_0CegT2ZO7YiVv8qg>
X-ME-Proxy-Cause: dmFkZTFH+x2kqa8O9RQWMqr9yWPrGOxvxDFnVypGOZOldKEvk57Eh6/+iz2B0GOjUuAmtL
 UaR+N4FgzjQhOrGdKNCy+kpLkR4lhqsTQasEg0i7YzKufNJClq2KaU5qRg1j/6Ys5auwtp
 CWwsmY1X4yIrfq88w6mxiU4zMpifXm9Byzvn7+Sk1XCXpBpqIGGCCr4R3LXeZTy+Y0H21w
 X2TW4zQ2MGy+84dqciOi+5MiamshS/K9S6Af6nadE0CO8aA3Ae6b4m59RxY/DHIRrM5CgZ
 TGwd3aqrZtpjEgL4+KQKPCDmeiaPulDjxCV+09t/tBmz9e4oJrNY0iHwsVFO6yejlXWxsg
 AYAsuiUdNmCY98eErKrK2WvDvizpNhhZLkDP1BLHIr6jTEzk/KzumyV/XhsrtuHr3J3NH3
 DbQsMp0EWzOL98CHSgckYVUA82bVnh1dyAJ0X1mv0j2Vn6O92vWOFIDabMdVFSRkDQp1rz
 +SpQh4ao9U22JWqOjkMd7g6qZSAi2qKsnmCx/UZ9+gdaAzD6AO2yid+gd+x1G68eIdbATF
 USQt1fFPv8RYL0VK/tY6YqCqB+da+OkBpaA3AQ9h9QkwjV0Uht6fnT68ioU4PFlMU4euNT
 Kc3qclv+dBcRH8ZK7F/QOKBg5d23qzjbWqz79+98WA7CSUv5bv5DV0lo1joQ
X-ME-Proxy: <xmx:0ZwDa49_YuQCF4Mo9AHVJW2wZhekAjaKTR819LkZLuFzvRh1h-c0Ow>
 <xmx:0ZwDa6zUSO8BthJmbSFxf_YDKdDMTgpCc5AKH_udRAFoIF0_sq85lg>
 <xmx:0ZwDay9hT5VgtEmitsxGZv60SdKXqqKKZgM-x4N8O2uknwnh1M9acw>
 <xmx:0ZwDawN-XrdEWTXA8DtcR701m1jnCQeORtDUhls_3Ll39YtD4W6SEw>
 <xmx:0pwDa7_3lTFE85EWzl6vgE4o5LcdeLFl0kMGcWbOmfEp15gaAMp_Rlp4>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 20:54:21 -0500 (EST)
Message-ID: <309f14662909643357b34507fedba3a120555f3a.camel@alistair23.me>
Subject: Re: [PATCH 0/2] m25p80: Clear write enable latch (WEL) at the end
 of SPI operations
From: Alistair <alistair@alistair23.me>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Peter Maydell	
 <peter.maydell@linaro.org>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier	 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,  Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, qemu-block@nongnu.org
Date: Mon, 23 Nov 2026 11:54:19 +1000
In-Reply-To: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
References: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.156;
 envelope-from=alistair@alistair23.me; helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-10 at 12:11 -0600, Anirudh Srinivasan wrote:
> The m25p80 model in qemu doesn't deassert the write enable latch
> (WEL)
> at the end page program and erase operations. This series contains a
> fix
> for that, to match real hardware behaviour.
>=20
> This series also has a fix to the aspeed_smc tests. These tests
> exercise
> the m25p80 flash model by sending page program (PP) ops, but do not
> send
> write enable (WREN) before each PP op as the spec requires. The test
> is
> updated to do so.
>=20
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
> Anirudh Srinivasan (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/qtest/aspeed_smc-test: Send write ena=
ble before each page
> program command
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m25p80: Clear write_enable after page prog=
ram and flash erase
> operation

Thanks!

Applied to riscv-to-apply.next

Alistair

>=20
> =C2=A0hw/block/m25p80.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
> =C2=A0tests/qtest/aspeed-smc-utils.c | 24 +++++++++++++++++++-----
> =C2=A02 files changed, 25 insertions(+), 5 deletions(-)
> ---
> base-commit: 73294d096cc591e122fde9e63db4739de6d84f2b
> change-id: 20261110-m25p80_write_enable_fix-d7f95301723e
>=20
> Best regards,
> --=C2=A0=20
> Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

