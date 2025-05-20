Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F0CC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 20:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHTpT-0004hy-Nw; Tue, 20 May 2025 16:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uHTpR-0004hX-MI
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:44:49 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uHTpQ-0007kZ-19
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:44:49 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id CBF6E180E64
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 22:44:36 +0200 (CEST)
Received: (qmail 32157 invoked by uid 990); 20 May 2025 20:44:36 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 20 May 2025 22:44:36 +0200
MIME-Version: 1.0
Date: Tue, 20 May 2025 20:44:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <4ea8edc376234e43230b09cb1b740616dee1652a@nut.email>
TLS-Required: No
Subject: Re: [PATCH v5 23/25] tests: add plugin asserting correctness of
 discon event's to_pc
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>
In-Reply-To: <dbf71afe-1ae2-4110-8f83-fe1b1823a774@linaro.org>
References: <cover.1747666625.git.neither@nut.email>
 <2a30a629012f39f8495415f87568fe9b3a0eb32b.1747666625.git.neither@nut.email>
 <dbf71afe-1ae2-4110-8f83-fe1b1823a774@linaro.org>
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-1.374938) MIME_GOOD(-0.1)
X-Rspamd-Score: 0.025061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=HOOU9sTY6ZpSjKlth04DzkW6tGmpifQY6dmBQt8Bl6E=;
 b=EK/m+/LD2Td3agw5Mtk0bW8Gxmmv+oEL+RqnFyDNPAToc3pumGUmcSzTgWGM2CwJL1JNreQrf1
 5EwCnQeM3+hSdp0PRiQKEspwop4hG9zT4MLb5IEGFZ7Imbq3Qm04K+SnnYMSoh2B43LKy9TKDvPq
 7E8RnX4Y1ERO82KZARVBzjT1cFT6FVYfDvOKR9Us026SITvFxjKWvhSyo3BS8nvKKo4U+EXV6lDs
 lCjBhPdF7o8YBy01Sq3Z14KGae4KHMLNP0cqq/SJgCHcOvLQ8EgwLWPgKe1LKc7Cp/eOldaL2U/S
 wrPbMGdAFG0BTx1UTOLPt4Ro2CVZq4TJ0dBM+HQ4ASv1htPmyWKOgbX7h4uhPyW5EcArxM98Ex00
 bRsELRdWlYq/2uOJA/wFPnFczI/JmbXv+kWVx1M3bOPKjryeB36/7cJpxEZJfsyId5mgEKolMul2
 gTug6D0qpogTKQDwuWdjaYrfAuyxdff8wOKLzI24kLmLWPHtrz9TJrrsZZO0J2DE+TDqrGDOFcDn
 ji7lJ13yOCPvEp2vs89VTZanaZj7Wha6GhR7kdmYAjENxgnZxNwhLqGisyBg7om1jI6YDGp2J7Qo
 d3AS5uZy2tC4wLlxZv3Mz4I49qTdxF80UpmauCn0GI7yufJeOlSyhDLSfENW9EDBE7eAC6HncIYz
 k=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Pierrick,

May 20, 2025 at 10:01 PM, Pierrick Bouvier wrote:
> Regarding the issue with the same tb being mapped at different virtual =
addresses, I'm ok with the current solution of comparing only page bits.
>=20
>=20That said, a better solution could be to compare physical addresses w=
hen a discon is detected (on plugin side), and confirm it's really a disc=
ontinuity or just a different mapping. With this approach, it's not even =
needed to have a dedicated option, and there would be no false positive i=
n the plugin. It's just a suggestion though.

I actually tried to do this before resorting to the current appraoch.
However, there is only API for querying an instruction's or TB's
hardware address and none that would let me translate the virtual
addresses we receive in the discon callback, which we need to compare
against.

I considered also passing the hardware address to the callback (do the
translation in the `plugin_vcpu_cb__discon` hook), but that turned out
to be not straight forward and not something we'd want to do in the
hook, either.

Regards,
Julian

