Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B717E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJK71-0001si-MS; Thu, 05 Dec 2024 17:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1tJK6z-0001jy-Mt
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:14:17 -0500
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1tJK6x-0002Ss-LH
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:14:17 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 0E1B618043B
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2024 23:14:06 +0100 (CET)
Received: (qmail 29346 invoked by uid 990); 5 Dec 2024 22:14:05 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 05 Dec 2024 23:14:05 +0100
MIME-Version: 1.0
Date: Thu, 05 Dec 2024 22:14:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <nenut@skiff.uberspace.de>
Message-ID: <176392855b0b6aac93ec1f821173ce437f1af8a6@skiff.uberspace.de>
TLS-Required: No
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
To: "Julian Ganz" <neither@nut.email>, "Pierrick Bouvier"
 <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
In-Reply-To: <51ac04eea17a6c5b59a240d3c57ce54a851e4989@nut.email>
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <181b9b53a258257df1b24e7bfb8b0e6fc590c25f@nut.email>
 <35529516-cc96-41de-8e0d-a7807ccc09cb@linaro.org>
 <ca20c295f464ae7e3365e012ad9a550f70b34b51@nut.email>
 <64e40e6f-bc90-4760-bb70-fb67d80ff4d7@linaro.org>
 <51ac04eea17a6c5b59a240d3c57ce54a851e4989@nut.email>
X-Rspamd-Bar: -------
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.995818) MIME_GOOD(-0.1)
X-Rspamd-Score: -7.095818
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=nenut@skiff.uberspace.de; helo=mailgate02.uberspace.is
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

December 5, 2024 at 10:50 PM, "Julian Ganz" wrote:
> December 5, 2024 at 6:56 PM, "Pierrick Bouvier" wrote:
> > Let's try to move forward, and solve the problems we have with from_p=
c. The testing part can be solved already (as explained in a previous mes=
sage). In which cases can't you identify from_pc?
> >=20
>=20I'll have to check, but problems that I discussed with a colleague
> included jumps to an unmapped page resulting in the appropriate
> exception. We ultimately agreed that in such a situation from_pc should
> point to the jump target inside the unmapped page, instead of, say, the
> jump. We assume that most targets should already behave this way withou=
t
> further changes. However, in order to compute the correct from_pc, we
> need to know the jump target before the exception is raised (i.e. right
> after the jump instruction is executed), and that's not necessarily
> straight-forward to do in a plugin.

Just remembered the joyful existence of double traps.=20=20

Regards,
Julian

