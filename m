Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130A2E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 23:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJKs6-0002Cs-Lh; Thu, 05 Dec 2024 18:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <benh@kernel.crashing.org>)
 id 1tJKry-0002Bd-QB
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:02:51 -0500
Received: from gate.crashing.org ([63.228.1.57])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benh@kernel.crashing.org>) id 1tJKrw-0004Pd-KW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:02:50 -0500
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4B5N0b5o001996;
 Thu, 5 Dec 2024 17:00:38 -0600
Message-ID: <ffac691bd93fee5192b8e91b03171422e5df0a1b.camel@kernel.crashing.org>
Subject: Re: [PATCH-for-9.2? v2 1/2] hw/display/vga: Do not reset
 'big_endian_fb' in vga_common_reset()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Date: Fri, 06 Dec 2024 10:00:37 +1100
In-Reply-To: <yqxiqgaazxuvvtx3onfqlndx2t2sa3i7iykufkl56r45iwyusj@xatjov5qiea2>
References: <20241129101721.17836-1-philmd@linaro.org>
 <20241129101721.17836-2-philmd@linaro.org>
 <21c5e930-d7ee-4dd8-a238-862f4db87849@linaro.org>
 <2f6a993cd0e12c2bf903440f9f921d7af58bee36.camel@kernel.crashing.org>
 <yqxiqgaazxuvvtx3onfqlndx2t2sa3i7iykufkl56r45iwyusj@xatjov5qiea2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=63.228.1.57;
 envelope-from=benh@kernel.crashing.org; helo=gate.crashing.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2024-12-03 at 11:51 +0100, Gerd Hoffmann wrote:
>=20
> The only case I'm aware of where the byte order is actually switched is
> booting a ppc64le guest in a pseries machine, where the opal firmware
> runs in bigendian mode and the linux kernel runs in little endian mode.
>=20
> So here the changed reset behavior could actually make a difference, but
> you will only notice if the opal firmware does *not* set the byte order
> register.

OPAL (well skiboot) doesn't display anything anyways (or at least it
didn't when I wrote it :-). It just boots Linux as a bootloader. So as
long as Linux itself sets the register it should be fine.

Cheers,
Ben.

