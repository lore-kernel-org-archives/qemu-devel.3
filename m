Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8D7C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUXM-0007ej-QY; Mon, 26 May 2025 05:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJUXK-0007eE-Lg
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:54:26 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJUXI-0007DV-QL
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:54:26 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 0B775180140
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 11:54:21 +0200 (CEST)
Received: (qmail 8157 invoked by uid 990); 26 May 2025 09:54:20 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 26 May 2025 11:54:20 +0200
MIME-Version: 1.0
Date: Mon, 26 May 2025 09:54:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <001e4427e1c1eb53a8c9b4017bda790b34b5cdcc@nut.email>
TLS-Required: No
Subject: Re: [PATCH v5 05/25] target/alpha: call plugin trap callbacks
To: "Richard Henderson" <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, "David Hildenbrand" <david@redhat.com>
In-Reply-To: <d90dd6ad-71c7-4720-a07f-8504f7fdfece@linaro.org>
References: <cover.1747666625.git.neither@nut.email>
 <a5ec8863418a946530d167677184d40319470af2.1747666625.git.neither@nut.email>
 <f140b06d-53c7-4d32-ab95-1327d2659a37@linaro.org>
 <3626834acffdaf2f6f2504c1dbb2c457601964f2@nut.email>
 <d90dd6ad-71c7-4720-a07f-8504f7fdfece@linaro.org>
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-0.283774) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.383774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:subject:date;
 bh=rvhkquX/dA3qZ09XL6grudUmEEE4N226AM7Eh1gOmLg=;
 b=CJy62dyzCaqHguqgm2KoVqsZjEHLaXpV0/Q7F/S0Qcgaj6z/pPXREYtlSehBUUMpbzM9xIj0iz
 t6p6pajzBhd21r3HxXqzeiYKQ2jeCiCUm6niktOfQrJU5FKpUUjwDXExxXIv0OOq9jUOIXuAVL+9
 vbwNzCR7sgn5X1jGc752kwgArds6K6eq7FoT1kwEH5Ha7QGBSoTzcP6v1VV/U5qb1KTBHPX8j/yG
 YH1FttyHMz2xRuU59FQoZ+DtgOt9/g7f0oALE46BqM1R6Tkjk6yRdaB+pVCfuwMkclk1jg1RFLGV
 M5Eo1ZxL3D05xz6vAZDV/iutQgxXhcu03D372V5Ab8Vc5a7aCUhSflFHqjSmhoT8X+YSrii2H2BR
 OrlJKMktIboC3O5+YRCLwtxFKOEPo2c+CfiGtBojVc2KBWI4MiOiIXOEvYJ1RRUgmh+MXE5HRdq7
 Rw1Zr+DbUCesGBrG0CoF3xdf8fbuX8h+1Kcw7WgWiQbgIS5s8DwWDEtTNTDfMH79gtmG94sdKDGn
 yjUv5m+OL5hQijxscnr/j25DXUu0TwGMCIiKsVbDF4yKZ1fXR0rvG4RA4czqQVrjks0xc5vY5u95
 InmnR0dGXnfncSOdAt1NKAV+P9jyhUWPdwcxUq78qisk9EpcgGUytVYSi6JAvY8Lonkc1kkostCE
 o=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Richard,

May 26, 2025 at 11:01 AM, Richard Henderson wrote:
> On 5/25/25 21:16, Julian Ganz wrote:
> > Also, some targets such as tricore only have a dummy/stub do_interrup=
t
> >  and handle exceptions differently inside non-returning functions. Fo=
r
> >  those, we would call the hooks directly from there as we do now?
> >=20
>=20It may be only tricore. And you're right, it would be a non-trivial r=
eorg to make tricore fall in line with other implementations. So retainin=
g the separate qemu_plugin_vcpu_exception_cb will be required in the shor=
t term.

Yes, tricore (and hexagon, which I decided to not support) are the only
ones that don't have a do_interrupt at all.

Note that x86, and maybe other targets as well, may not return from its
do_interrupt but call cpu_loop_exit_restore or something similar,
arbitrarily deep in their call stack. But as far as I can tell that's
also exclusively for exceptions.

Regards,
Julian

