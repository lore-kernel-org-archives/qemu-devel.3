Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399D5C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 09:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHKAw-00083s-Iz; Wed, 12 Jun 2024 05:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sHKAt-00083R-Uz; Wed, 12 Jun 2024 05:21:48 -0400
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sHKAr-0001oT-U5; Wed, 12 Jun 2024 05:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PxNXpRSFog0V+aKZKEY1fvquyKlyNRIvWqzeQsDUMeY=; b=nSL8B4cJeRubIyHUrnU9Hwwp8P
 A9FuUrI6Cr977d7ZXEGLJLU81aZqjg2bBGcZoY/8/1njRUrqRDo6Nl9sssE2TrfRGNWW7it3Q5TU/
 W5prdyaThSG+Qou5znUltvYnrt1Auuhyq6MmmyoaULBHKzIJGIWiOMZGXbiAhZGTKPN9BA5RUCgkC
 gcWkot/Evevqr4Z/A9kjF47/GWlN3ZjP8PCdccJvsDMarqG++qywGNw9dyohROl49EiVvp8dcD2MP
 RxGl4fu+0PVqunDqjBnR09+IRdc92TDIoBPIKxRX5yzJMv1YJ8hWUpp2y51yiVH7VNHe1RnsbFFua
 BABWedvw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sHKAg-002F7v-Tx; Wed, 12 Jun 2024 11:21:34 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1sHKAe-00AGL7-Mu; Wed, 12 Jun 2024 11:21:34 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1sHKAe-00B59W-1l;
 Wed, 12 Jun 2024 09:21:32 +0000
From: Alberto Garcia <berto@igalia.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>, Madeeha Javed
 <javed@igalia.com>
Subject: Re: [PATCH] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
In-Reply-To: <eye51.7m7tedycfrgc@linaro.org>
References: <20240610144708.81351-1-berto@igalia.com>
 <eye51.7m7tedycfrgc@linaro.org>
Date: Wed, 12 Jun 2024 11:21:32 +0200
Message-ID: <w511q52ms83.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed 12 Jun 2024 09:01:01 AM +03, Manos Pitsidianakis wrote:
> Hello Alberto,

Hello Manos!

> > This is equivalent to using qemu-img to convert a file to qcow2 and
> > then writing the result to stdout, with the difference that this
> > tool does not need to create this temporary qcow2 file and therefore
> > does not need any additional disk space.
>
> Can you expand on this a little bit? Would modifying qemu-img to write
> to stdout if given, say, - instead of a file output path be enough to
> make this script unnecessary?

Yes, it would be enough. Allowing qemu-img convert to write to stdout
would indeed be very nice for the end user but it's a bit of a niche use
case and it's also not a trivial task so I don't think that it's worth
the effort. The output files that you pass to qemu-img convert need to
be seekable because the only way to produce a qcow2 file without doing
that is by precalculating all the metadata in advance before starting to
write anything (that's why this script reads the input file twice).

This is fundamentally different to what qemu-img convert does, which is
to read the input file from start to finish and write it to the output
file, relying on the relevant driver's existing write operations. All
those assume random access to the output file.

qemu-img is also much more generic in the sense that it supports many
different output formats and image options.

In contrast, writing the algorithm for a basic subset of qcow2 is quite
simple and that's why I think that it makes sense to do it in a separate
tool.

Berto

