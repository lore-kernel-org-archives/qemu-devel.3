Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51210CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 22:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVG90-0002j6-Ee; Thu, 04 Jun 2026 18:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wVG8y-0002ij-AF
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 18:02:28 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wVG8w-0001YN-5J
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 18:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780610528; x=1781215328; i=deller@gmx.de;
 bh=jxg528G0qbUkPj6OywEWeeB3oLkJWGczydAJgdanrgQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IWG1noDpv9tKUpx0bJRjkjzIspK2dMtBtYN27lKBEuH12evj0Oy3G4c6dOlfFtX0
 lX9ourMHCxbDqG48XbYpIgTx2ZH9YzT5xya/BQEVBzN7Yir51AgshMiJBv9ThaeVd
 XHj2ThRyunqdIlzyJ2mM8uqZoCipa/rFRHOFrHegEGiauEBiLtA7weRivMO9L3mzU
 CPmjtIMqvmO/02TI+OzQIxN0isz4JCo5vc6a299iahYMjBapMyo1QItbxrgnf6iE9
 Uh0jakAs5txaYOIemOIPvoF7tFfz4/XIpeQ7x+6LYhJjOAwDl54pRkaRPzG92hNGe
 I0snfpwwXV0OM6NTsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1wdUwo15P4-0009kG; Fri, 05
 Jun 2026 00:02:08 +0200
Message-ID: <f9dc7ac9-4d59-421c-a024-a1fb743570e3@gmx.de>
Date: Fri, 5 Jun 2026 00:02:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] linux-user: implement fsmount(2) series of syscalls
To: Xinhui Yang <cyan@cyano.uk>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mingcong Bai <jeffbai@aosc.io>
References: <cover.1780036891.git.cyan@cyano.uk>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <cover.1780036891.git.cyan@cyano.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WDCP3BZLLpGcIeoIML8TdWu6oB1iPsIW6XCTanty1aWSiNlgqc/
 ScLJ1DhqaAu9VRzWcG6Fv4ESGqSOD2WudWJH7oQc7Lwm91oUnB8SPUcEDAeIMpK9MPX/V/0
 fixffpxC0u57OL2gGOIOhGbcP9GK9xVEnaZ25SXKkR9JZHN1t3QvFchEGGLhoqq8+xUc7Zr
 JyPAs7pDz7VRPirX+cHhA==
UI-OutboundReport: notjunk:1;M01:P0:waw7zIJj/+o=;WEMvZo6Jwa8mpbcGIl4a54cpGwd
 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
 P9BI1ylUk4zQt2N1HFadu57UjoI=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 5/29/26 08:53, Xinhui Yang wrote:
> The motivation of the implementation is to allow any foreign guest OSes
> with systemd v259+ to boot using systemd-nspawn(1), otherwise any
> systemd service requiring importing credentials will fail, including
> journald, D-Bus service and getty. We used to work around this issue by
> patching systemd to retry the clone() without CLONE_NEWNS, which is not
> and can not be implemented in QEMU user emulation.
>=20
> mount(8) from util-linux worked prior to this patch because it will
> fallback to the old mount(2) syscall if fsmount(8) series of syscalls
> is not available.
>=20
> Tested good on an x86-64 host, with:
>=20
> - an AOSC OS mips64r6el guest, which boots successfully with full system=
d
>    support using systemd-nspawn(1).
> - a Gentoo ppc (big endian) guest, which boots successfully with full
>    systemd support, using systemd-nspawn(1).
>=20
> Changes from v2:
>=20
> * Apply the review from Pierrick Bouvier[1], making sure that the buffer
>    is unlocked before returning error in the fsconfig handler.
> * Clearify some comments in syscall.c.
>=20
> Changes from v1:
>=20
> * Add missing guard for FSCONFIG_CMD_CREATE_EXCL in strace.c, since it i=
s
>    only available since 6.6.
> * Fix some wording issues in the cover letter.
>=20
> [1]: https://lists.nongnu.org/archive/html/qemu-devel/2026-05/msg07794.h=
tml
>=20
> Xinhui Yang (2):
>    linux-user: implement fsmount(2) series of syscalls
>    linux-user/strace: add fsmount series of syscalls
>=20
>   linux-user/strace.c    | 105 +++++++++++++++++++++++++++++++++++++++++
>   linux-user/strace.list |  15 ++++++
>   linux-user/syscall.c   |  91 +++++++++++++++++++++++++++++++++++
>   3 files changed, 211 insertions(+)

series applied to the linux-user-next git tree.

Thanks!
Helge

