Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B58CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 19:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIWHO-0002Xf-Rk; Sun, 18 Oct 2026 15:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xIWHM-0002XX-To
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 15:10:44 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xIWHL-0005MV-6F
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 15:10:44 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 8F0CDA224F;
 Sun, 18 Oct 2026 21:10:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792350640; bh=tI7taOf2WllFIMxt0qDY8jf+bzzAgKREIKKq+JtGEsA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m78U9z8b/iQH340n0zrmyI7IIrl/wRP3yXRSVeP2aGHS39xUAxa3GDBgWgaH7ngXh
 uWwWi0CuKZxnIUIJb8jOB+IpKl5U1IxbNblrOnnnwymPhK/5rU9BzCXQqistbhgV+X
 1BR4EcfAmfscT9+yNXQvnyNQT/oesuBl5m8LyFVD7LzHj+5aA5SQ1iU38FK13RCAXB
 5mu1cs6ZMGvM/odjDSG3Dg11M/7C99DmNwRXATI0K6ekqjwOkJdsDC2tBuaqowrJFl
 0bb9HwEQ8qpJ8Sk6zFT6vAUEVGGZpwfuw5TDKszytQxi0ckxVjit4YWI8aPNtphLAQ
 Z1TgcyUDqTZbw==
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LF3-CjjQ4zMg; Sun, 18 Oct 2026 21:10:40 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id 5EBB7A1C00;
 Sun, 18 Oct 2026 21:10:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792350640; bh=tI7taOf2WllFIMxt0qDY8jf+bzzAgKREIKKq+JtGEsA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m78U9z8b/iQH340n0zrmyI7IIrl/wRP3yXRSVeP2aGHS39xUAxa3GDBgWgaH7ngXh
 uWwWi0CuKZxnIUIJb8jOB+IpKl5U1IxbNblrOnnnwymPhK/5rU9BzCXQqistbhgV+X
 1BR4EcfAmfscT9+yNXQvnyNQT/oesuBl5m8LyFVD7LzHj+5aA5SQ1iU38FK13RCAXB
 5mu1cs6ZMGvM/odjDSG3Dg11M/7C99DmNwRXATI0K6ekqjwOkJdsDC2tBuaqowrJFl
 0bb9HwEQ8qpJ8Sk6zFT6vAUEVGGZpwfuw5TDKszytQxi0ckxVjit4YWI8aPNtphLAQ
 Z1TgcyUDqTZbw==
Received: from samy by end with local (Exim 4.100.1)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1xIWHH-00000002Af3-3y0B; Sun, 18 Oct 2026 21:10:39 +0200
Date: Sun, 18 Oct 2026 21:10:39 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Alexander Epaneshnikov <aarnaarn2@gmail.com>
Cc: qemu-devel@nongnu.org, brltty@brltty.app
Subject: Re: baum: NVDA does not detect usb-braille
Message-ID: <atUZr1LP8k5b78I8@end>
References: <atNoDNz0dQucxzFN@alex-pc> <atNo9sk_7jCAi98u@end>
 <atPIRr46KvMoiCti@alex-pc> <atTzTVaSxUy5r95x@end>
 <atUU4HpVVI59QcLJ@alex-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atUU4HpVVI59QcLJ@alex-pc>
Organization: I am not organized
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

(splitting the actually-unrelated questions)

Alexander Epaneshnikov, le dim. 18 oct. 2026 21:52:44 +0300, a ecrit:
> On Sun, Oct 18, 2026 at 06:26:53PM +0200, Samuel Thibault wrote:
> > Ah, that is a requirement of the protocol? Then we need to do that
> > indeed. What is the value of the uint8_t protocol field when it
> > expects to receive 0x01 and 0x84?
> 
> It is 1 (on). For serial displays, NVDA's Baum driver
> (source/brailleDisplayDrivers/baum.py) first sends 0x15 with 0 to make
> sure the protocol is off, then sends 0x15 with 1 twice, "in case the
> display misses the first one". After that it waits for the cell count
> and the device identity. According to the comment in that driver, a
> real display answers only when the protocol goes from off to on. On
> that transition it sends its device identity, its serial number and
> its cell count, and it sends nothing if the protocol was already on.
> NVDA itself only waits for the cell count and the identity.

Does the device sends the cell count first or the device identity first?

Samuel

