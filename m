Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD559CA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 13:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuWil-0006ow-US; Fri, 05 Sep 2025 09:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuWij-0006oT-4p
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:43:17 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuWie-00053m-FO
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:43:16 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id A405860E24
 for <qemu-devel@nongnu.org>; Fri,  5 Sep 2025 15:43:03 +0200 (CEST)
Received: (qmail 25152 invoked by uid 990); 5 Sep 2025 13:43:03 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Fri, 05 Sep 2025 15:43:03 +0200
MIME-Version: 1.0
Date: Fri, 05 Sep 2025 13:43:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <cf6e7db43e9e9e59b6c9edb1c172b01ae62fb23f@nut.email>
TLS-Required: No
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
In-Reply-To: <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu>
References: <cover.1757018626.git.neither@nut.email>
 <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu>
X-Rspamd-Bar: -
X-Rspamd-Report: BAYES_HAM(-1.468467) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.568467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=jwwKTpDJVc83P3MsCZRaUE/SFYg0zb134MSsRDhnYAw=;
 b=GjafwSPToHgWb579unzZpo/5/wLqz8AMqEyPk24PZ9Zf+zqRRJ0fhONIK6p3gsa57UU/XO4j/B
 tN/ys+aWsOCO0NtLNFJHEBIfTbZQGbh+Nh7+0psOGOMKay/As3MZ2jTmozPlZaVzcsv8wctssJYv
 YyH9WkFooo1GpQcRJw8F70pbh5mavyJ4blohGD5a+8bIA2VnSbsexrOT3LpldqgF8ON37VxRUL24
 6y2Eguo4rNaThDinLMQUc20HkssYswrkXmXwA7Nx5r691z5Ix/g2GEidgfrWLrHGvsKIgVLqVTUX
 AIQ7PN3YUPKZ0r0JA90dApwDy9mDhxdGsUXNDDILXR0qDY1f5z4Q/upSwNKrpJkknxyClPGWeyns
 tL0sdTH/gCzS4KaJ5qlIoI3nSpwZOx/btCzPrZBjJyBjGLiuQ20cVa4ZNm99fe2kC9A+Q9xAakVz
 YQVfPZdMSrPawwj1IlN0StIGSgHdCVzNq8kGfhqkPT3S1SRw4yFW4N4TWXmVxPRQC8mRd6r/+I7y
 Ka3dXzXWaLosN1VoGWfcrJ7O1H8f/OoEWkQio/AS8MQQzeHRIeXT/wARDF4n27T8Eetpgvtmizk/
 BB50bZITRt/y9wN0czdQwjps/rr1y0uZzB4C8PwP31dpaDBU4KsfSXNvqZUVccEeQXouwld23NN2
 o=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
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

September 5, 2025 at 1:38 PM, "BALATON Zoltan" wrote:
> On Thu, 4 Sep 2025, Julian Ganz wrote:
> >  Even with the existing interfaces, it is more or less possible to
> >  discern these situations, e.g. as done by the cflow plugin. However,
> >  this process poses a considerable overhead to the core analysis one =
may
> >  intend to perform.
> >=20
>=20I'd rather have overhead in the plugin than in interrupt and exceptio=
n
> handling on every target unless this can be completely disabled
> somehow when not needed to not pose any overhead on interrupt handling
> in the guest.

The "more or less" is rather heavy here: with the current API there is
no way to distinguish between interrupts and exceptions. Double-traps
can probably only be detected if you don't rely on weird, very error
prone heuristics around TB translations.

And as Alex Ben=C3=A9e pointed out, qemu can be easily built with plugins
disabled.

> Have you done any testing on how much overhead this adds
> to interrupt heavy guest workloads? At least for PPC these are already
> much slower than real CPU so I'd like it to get faster not slower.

No, I have not made any performance measurements. However, given that
for every single TB execution a similar hook is called already, the
impact related to other existing plugin infrastructure _should_ be
neglectible.

That is, if your workload actually runs any code and is not constantly
bombarded with interrupts that _do_ result in a trap (which _may_ happen
during some tests).

So if you are performance sensitive enough to care, you will very likely
want to disable plugins anyway.

Regards,
Julian

