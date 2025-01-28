Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C88C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 23:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcv28-0003WP-T1; Tue, 28 Jan 2025 18:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tcv27-0003VV-A0; Tue, 28 Jan 2025 18:30:15 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tcv23-0008OX-V9; Tue, 28 Jan 2025 18:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1738107000;
 bh=5Fe4Kd9zjpckFGitNEIbV20ei3cICRR3NvaaUVbexI4=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=PZySY69tTwJnce1/IEs79QK2+xCnKa5fKUgVE5TOucmyNw3CoJRT8LxRVPKrzuGVK
 CUE5Iq3b+VPmGNyB2UDw+LjuguX5kUVnqvo/xkqKfLAN1jRfLkMGc/yTvTxXD4lqZW
 g/wPezXhJy9LTQmcYc8nNTBv7doDyr3FHfTTECc1QQkGbJSAt7YM4+lhN0eBpc0/A1
 688ZBuHTESsOrqyGryxwAH2haQleVCv7UDnMET+dNTpVC9YzNSYnwfYh9C/U/fmX+J
 H4qiUdeN+3xS+bO/E01pbPlt+XEs9yOileYDszAhsnYrmsoUkXHGSM/6FcXDw2U5jk
 0XfTl+FpKOydg==
Received: from [192.168.68.112] (58-7-145-34.dyn.iinet.net.au [58.7.145.34])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 231E8734DE;
 Wed, 29 Jan 2025 07:29:58 +0800 (AWST)
Message-ID: <bee99a3ef4821f69f6f1a2f6cfc77c3e247e5d87.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/5] tests/functional: Update Aspeed OpenBMC images
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Troy Lee <troy_lee@aspeedtech.com>, Jamin
 Lin <jamin_lin@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Thomas Huth <thuth@redhat.com>
Date: Wed, 29 Jan 2025 09:59:57 +1030
In-Reply-To: <20250128214100.1196243-1-clg@redhat.com>
References: <20250128214100.1196243-1-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi C=C3=A9dric,

On Tue, 2025-01-28 at 22:41 +0100, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> This series updates the OpenBMC firmware images to the latest version
> for existing tests and also adds 2 new tests for Aspeed machines
> which
> were not tested before : witherspoon and bletchley.
>=20
> Thanks,
>=20
> C.
>=20
> C=C3=A9dric Le Goater (5):
> =C2=A0 tests/functional: Introduce a new test routine for OpenBMC images
> =C2=A0 tests/functional: Update OpenBMC image of palmetto machine
> =C2=A0 tests/functional: Update OpenBMC image of romulus machine
> =C2=A0 tests/functional: Introduce a witherspoon machine test
> =C2=A0 tests/functional: Introduce a bletchley machine test

The rest of the patches haven't reached my inbox. Did you send them? It
also seems they're missing on lore :)

https://lore.kernel.org/all/20250128214100.1196243-1-clg@redhat.com/

Andrew

