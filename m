Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D17606A33A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=ErkA/NR5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RveuEgDn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJ6T-0000Li-CP; Sun, 22 Nov 2026 20:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xVJ6O-0000LG-Mj
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 20:44:16 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xVJ6L-0005UJ-FJ
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 20:44:16 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id EAD501D003BE
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 20:44:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 22 Nov 2026 20:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1795398249; x=1795484649; bh=0N47pa0CQjHEhwV5WpubYnmKQtn8e8kZ
 09+cOgvlCdQ=; b=ErkA/NR59rHi4N4qLMZc2XHNNk3xnfR1Ino0mUVyXvo2ota/
 7Mq1IqJElRfjr8x8GtwJDeKnTBRb3lS6Lj8TchjOV8J22Gy+5boQMPhMcA4k8aE0
 aDTgUlYKHw4xWfmL0fY88zBUUTfEMsfZpQAxBAMbsmuNUxw9rd5nO/Ev3JjTcLHD
 IRePYuPZiS2EtdCwIpnZg6sSmU7Inapb2CbWtXzSZRShtVhga6ncNwL7fMSGwzJw
 SQNu64oSOsXfOVOdDZVjYs57hK8vkXUyU5yMqtcnG1PIT+ySxrkaM68VWles1i/a
 funpboHjwxeCduiFMuGgEvVk+sTan8Hep78kJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795398249; x=
 1795484649; bh=0N47pa0CQjHEhwV5WpubYnmKQtn8e8kZ09+cOgvlCdQ=; b=R
 veuEgDnBAGzFuJFb7QW0fjC9s9mprk3ui10t8DJMvIofKfFSekSDFMkzj/LXmgC4
 Cvb8N3II7vJcSyIENDZFZbt0IQlnzIANZlFuxzRUXSjwi52K68yvcT/823YClwDP
 O51Six9+U0dDZyuy+EGc9dYtCtkzMn6EU4qYZbMzvkoqmkfTXQ/JqZiDCOsmfYit
 edPxvZ5y9L3mP1ujcglDZjPJ4uHDouI5IXHFJsDHtUDfMH3VnEyYjr25bZmaYUou
 1trn8aMq+jhuxHm73DXBxopQaVqY8RHcb53NCS99WaVrwwNb2TqDJUPfLqOS6JcI
 Z7ljWpE1BAcBpVVaQIxFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795398249; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:GZNT2vFlcYrbeNSzJZOLn/YZjnPPaqn58fmSmsN5gvqV5Of
 imbdaI6FJUGu5BbMaU09qMLe8KyeIGJ/hW6dOoIATost2GCQkhAybJZIHpQzrpTh
 Sa3y6O74WmbLwv065QJfmth9wwaLyFTHFIhAwLHwzcLgssp/wQEdQptXjwq9dpQ6
 8GTTaL+WBrpadWayl3iwpqU9F/kWCdL5zQ6X+BRao2PWOEcWMhxFlfymll3pv/Bg
 nRuwLMLUWcerm4GuVF9cXhsGYZbWB9oCnR9aQRH9QpjZePsuzrjcUI3rWyeEh7Zr
 Vr2CsWXZ5cYdH9IZmr1bvswXBpWrzUJpp2PSkeQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:WmTzPmHBq/tlRwbQOy5OkF4ZWrbJOi77UkzCqYrgmYc=:0N47pa0CQjHEhwV5WpubYnmKQtn8e8kZ09+cOgvlCdQ=;
X-ME-Sender: <xms:aJoDa0IJmluuQLKFbVLTNuKvY7EFVYn9pAiIwwVcxi6KWZ4lZFPnvw>
 <xme:aJoDa6i7KXw5zHdLdHwm3wbTKd1_bs_yGz4G_lS5Szi9trHp3TOWSaire0XlShur9
 OPHKrpH0xec99ck2qDJyGwCF5IcdVOJpFujfvMXBpvK_fRl0wu5PjxY>
X-ME-Received: <xmr:aJoDaw_4LYjGtdwHOOwFr3N8YgeG_APYMK1u7OgupEvK4MnQUYfPFER-sZM5zWoD1W6yh8E6SoZE5wNrFCQ2C_r8Lo4>
X-ME-Proxy-Cause: dmFkZTGLH5SQJgb9SFf8Rq/ZS0DtnyyK7iJy/Km2vXfT2HQZtpxHRrJog/06eowC7TYk5b
 3B2XpN7ydriB4miW7P4cehpsxxbyRhB8E8WsJuzAEoA4Dx4UPUg39q8vO9h4DJhOBkZF8t
 VRbliJSP4vVH+MJCbjkqUz+TFkZYqlwj8j38OzzUTy2mw6oGhSGT7pJkaU3HCW7BqCPXld
 V/1R2qfsl5Lyfnavk6zK7n1V0JLc2aHiZ4cV673iMpVjQBO2xx+UK4zFDQD1quoS8aAWZp
 52Q1X5v+B0PVjO+5liieLSwvYB52FUVkweQNmRDpPIo7Cg37wDTgzdUG7vo4fRKIamqDJY
 yViPNeh7CYmOS+8ciPSRj2EsbGWl6N7v9im1q5/K2xba8Ma5oAhJp11N+xnNT0M4cxHnN4
 XT4JeosKGo60mzL/C/heQA5bieOfQqT7z0xMRLKwgorhHJhEifcXZ3r2Jo2HtoC+X5JSSt
 7DPcRt4YBJ1DDl2Ci3YqZ9cLYeh5L7LQ/YelCw83mQVMyWNA0EzzNwri93k1LSG3MHYE2Y
 4d607tQXQCbQyKtG0TBM1jJq6xh/Ruzwd7xPxpDvyeUzLzzF8C676ynT9x+G9UHpH548ta
 75C31JGEz4Vcx/E6qUUlo9U9HDSEI2ZzpGSEpyDbBGjaDLL+CX1Xcr9/VIVw
X-ME-Proxy: <xmx:aJoDa_O3sV2nUlqj8M1meV-y7mrFvsejUaVxmx9YGpEhXYW6Vi5T3Q>
 <xmx:aJoDa0Cv3XYJMW9A18ot2iJeblhWzUyPEAN0CnsaYmUD38iXsUatQg>
 <xmx:aJoDazNqgeTJmQehVvIk2p2NamvZ24TQoGluyFe1ljwZF2Kir5o3kw>
 <xmx:aJoDa7fsdSto3kIEIE-IIdXX1rNFmx2a8BGqWltJ34Gz0nIPxcKY8g>
 <xmx:aZoDa4O5M0IAvhDn72rkb2EstafZs2SHyaevtd6ARqpPOrll-LGQJgQF>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 20:44:04 -0500 (EST)
Message-ID: <eccb67cf4495cc3578123bd2cebf89ce9d9e6894.camel@alistair23.me>
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
Date: Mon, 23 Nov 2026 11:44:01 +1000
In-Reply-To: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
References: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.147;
 envelope-from=alistair@alistair23.me; helo=fout-b4-smtp.messagingengine.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>

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

