Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77FEE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJBci-0003Lp-B3; Thu, 05 Dec 2024 08:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJBcg-0003LZ-NV
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:10:26 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJBcc-0006Ml-W9
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:10:24 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 17B3D180C3F
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2024 14:10:19 +0100 (CET)
Received: (qmail 20596 invoked by uid 990); 5 Dec 2024 13:10:18 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 05 Dec 2024 14:10:18 +0100
MIME-Version: 1.0
Date: Thu, 05 Dec 2024 13:10:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <0e4171ca0baa8727c0bbec7a25fd72d8b8e1e4b8@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>
In-Reply-To: <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.190743) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.209256
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=nJSZYu5K/+AFYGovpTO1YIK9Zc1H3Mwuom4DDx6UM58=;
 b=rJTKL1m9cT0dJ27DCmX1awUmRBR0bNpLEKBVueVuRsRA7V7G2KQSKiogqKC29jPuFMlJSmOJAJ
 ZfAP0b2jwdnmLus5UTeeOTWnf3a6MytfLcnAOcTJY89u92gcnJ3orV2xeZwTfwFkyU3mSR5ixdz7
 UTplRT8fpF+VlUQxSZpj5L8PYMp1YC3nVPjzOlBheSAx3h6wDkrGzJ8gJM0MpPsHAYlff6emf9rj
 7NRshr/sZgijQllk8VmqdWihZ4026ji4eF753Dwy926KFJNHfmoB4n8nCAirnQst3FS8z0y0NvLG
 /J6MobbTvBQgSwvHT27wIqc+taKERyaoKvrDsv8eFp1X8sLItgiJvjTqTY/cQ8yKjhTffVQou01u
 PIjolVeDnTfPSyP1DtNWXHuwkAQ2SydeWim/jH8yxhgHzkh9ejiUjFqTwOhSw3tkxrDCaFB17I9o
 fixuOQJByl/7V24lNdZBGtgepPdyU3IJpRRzC5mg0Ph5BoH92yKOoszHIv/fJh4/mnhEbn5bWRpv
 nuBU0YveZPSFqKZDOPzQRbkb0qlIPBAGpkKItDj12Tg4NwPdjSI8h+8rkgrWDj8QUIPyATlKDreu
 1lMWIS6727Kn8CmcllSB/Awuakza+JOYMY9GW+LefK6sfXHu0j3V6oJNPGxhevFUQzrwqdo3vplX
 M=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Pierrick,

December 5, 2024 at 12:33 AM, "Pierrick Bouvier" wrote:
> On 12/2/24 11:41, Julian Ganz wrote:
>=20
>=20>  +/*
> >  + * Copyright (C) 2024, Julian Ganz <neither@nut.email>
> >  + *
> >  + * License: GNU GPL, version 2 or later.
> >  + * See the COPYING file in the top-level directory.
> >  + */
> >=20
>=20Would be nice to include a description of the plugin here.

Agreed. I'll include one next time.

> When booting an arm64 vm, I get this message:
> Trap target PC mismatch
> Expected: 23faf3a80
> Encountered: 23faf3a84
>=20
>=20 From what I understand, it means that the next_pc we have is incorre=
ct.

Yes, this is indeed incorrect, and also a perfect example why this test
plugin exists. There are likely other errors lurking in target specific
code. Did you happen to also log interrupts? Do you remember what image
you used?

Btw: this also illustrates another issue I have with from_pc: we can
test the behavior for to_pc, but doing this meaningfully for from_pc
via a plugin is next to impossible because the instruction it points to
is not observable via an exec callback. At least not in the general
case, even not if we only consider a single type of event.

Regards,
Julian Ganz

