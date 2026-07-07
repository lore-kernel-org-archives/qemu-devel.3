Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD66C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whD2h-0002KZ-0t; Tue, 07 Jul 2026 17:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anbelski@linux.microsoft.com>)
 id 1whD2f-0002KG-3Z
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:09:21 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anbelski@linux.microsoft.com>) id 1whD2d-00085Q-J8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:09:20 -0400
Received: from frill.fritz.box (p5dd8e580.dip0.t-ipconnect.de [93.216.229.128])
 by linux.microsoft.com (Postfix) with ESMTPSA id B0B2320B7166;
 Tue,  7 Jul 2026 14:09:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0B2320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783458551;
 bh=K/1oS5E8FY/XVRAZBs46fZ63qzRvUDHMThk/9rO/uUY=;
 h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
 b=G+IyzHsPqVh2cb0jz6LkSdpI2JgL+vnI3CaOOj/p5mS8YCj6Oz/PkDaR17llJlnqc
 YV2Vchmxz2EKVRAK0g1++klJ0Z6BQAMiPfOwpG3EPIpDmGe8E0NZ2ARlxuyuPwJLpa
 qUqbRJtHbP+zkIOXM/XyM74a9PPhb53VXmh2Q/n0=
Message-ID: <861020196095d6d91a83b878a1ed744b2824d159.camel@linux.microsoft.com>
Subject: Re: [RFC] virtio-villain: Guest fault injection for VMM robustness
From: Anatol Belski <anbelski@linux.microsoft.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Date: Tue, 07 Jul 2026 23:09:12 +0200
In-Reply-To: <akzXblNvD5s4QGgB@redhat.com>
References: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
 <aktl-ojkXVZ4Jira@redhat.com>
 <a2a7bb2e20d954689a638b8a27b7fb95de156667.camel@linux.microsoft.com>
 <akzXblNvD5s4QGgB@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=anbelski@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-To: anbelski@linux.microsoft.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2026-07-07 at 11:39 +0100, Daniel P. Berrang=C3=A9 wrote:

> We appreciate the intent not to flood projects ! Feel free to
> drip-feed issues to us, a handful at a time though over days
> or weeks if there will be alot to process.
>=20
> We recently switched our security disclosure process over to using
> our regular GitLab issue tracker, so would prefer any bugs to be
> filed there, rather than emailing people directly:
>=20
> =C2=A0 https://www.qemu.org/contribute/security-process/

Perfect, that makes it easy. I will file on the GitLab tracker and
send them in small batches over the next couple of weeks rather than
all at once. For the ones with a host side impact, a guest triggered
hang or use after free, I will tick the confidential box and let
triage decide whether it stays that way.


> We also have tests/functional/ in QEMU where we boot real guest OS
> disk images and/or kernel/initrd pairs. The minimal initramfs
> approach would probably fit in nicely with that, and indeed I have
> long wanted us to replace some of our full-fat disk images with
> minimal self contained initramfs images to speed up smoke testing.

That sounds like a clean fit. The harness already boots a kernel plus
a tiny initramfs with a single static init and no full OS, so it
should slot into tests/functional/ with little friction. Each test
finishes in under a second when passing, since there is no full VM
boot involved, which makes it suitable for smoke testing too. Would
it be useful to have these wired in there directly, or is there a
different shape that would work better for you?

Thanks

Anatol

