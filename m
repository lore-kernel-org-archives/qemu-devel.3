Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15AAC624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 19:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2wAu-0003PV-ED; Sat, 05 Sep 2026 15:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ryan@psychicfriends.net>)
 id 1x2uTp-0004Tj-S0
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 13:47:05 -0400
Received: from ns502904.ip-192-99-36.net ([192.99.36.83]
 helo=mailserver.psychicfriends.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ryan@psychicfriends.net>)
 id 1x2uTn-0007c7-E5
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 13:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=psychicfriends.net;
 s=mail; t=1788630421;
 bh=cO6oYQQAlaaDDWIP9ULPC45uOPun0/iOLhTjqaVxpAU=;
 h=Date:From:To:Subject:From;
 b=ExX3uqD4O92ke2W9SRMo8482JWAVLqvrLmg/eZC2SirNAhi87132E9VqnrMJxOdlN
 e6Df9Jq9XnePY68VKmzxx2obeV07bQrY9K0dg1Av5LBMed4CrA6K1wxLKBNJoOS8Po
 kE2vH2atcd8NtwE7Ks5lu9bbrHWO05wFg3V/yYfqupHnJ2MnRkSpzCekoQR4WeU3Qj
 DakhiXQ0UryQO0ykTI+skSs7/4QLLGetl1KNDed+8n0nNWe5xBxZMNGbjeHAkGq8Ra
 PR6hesRKcAhrJIPPGJ3rPCXnxM9qQhfhS78R4r+SGxmnGFzK4HynfU+9C4i0s+8g6O
 7JrwrwT8/pAaA==
Received: from authenticated-user (mailserver.psychicfriends.net
 [192.99.36.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mailserver.psychicfriends.net (Postfix) with ESMTPSA id B9932140272
 for <qemu-devel@nongnu.org>; Sat,  5 Sep 2026 10:47:01 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 05 Sep 2026 10:47:01 -0700
From: ryan@psychicfriends.net
To: qemu-devel@nongnu.org
Subject: qemu-system-sparc64 niagara patched to boot Solaris 11 and Illumos
 distros
Message-ID: <807004b02d986d7dac93263f72d92026@psychicfriends.net>
X-Sender: ryan@psychicfriends.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.99.36.83;
 envelope-from=ryan@psychicfriends.net; helo=mailserver.psychicfriends.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:35:35 -0400
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

crosspost from illumos-sparc -- i'm quite aware that solaris has booted 
on sparc for quite awhile now :)   the qemu sun4u machine was never 
friendly enough to give devices to a real solaris installer, tho.

Hi, all!

just finished this demo -- i've got what was the bones of solaris11 and 
tribblix booting kernel on the Niagara QEMU machine.... turned into a 5 
minute boot with zfs root, to multi-user login prompt.   With 
networking, and guest-to-host unix sockets.

And a cool easter-egg bbs for good measure.

It's all packaged in an amd64/aarch64 docker image for easy 
getting-started.  The demo's running from my m5 macbook aarch64.

Github repo with so many notes i seem insane:
https://github.com/ryancnelson/qemu-sun4v-illumos

youtube boot and network demo:
https://youtu.be/TzgbLWeTZPM

i'm ryan@ryan.net , and I'm happy to finally be ready to share this.

it builds upon cool discoveries by
masa-murayama , GitHub user `whensungoesdown`, and Artyom Tarasenko
https://github.com/ryancnelson/qemu-sun4v-illumos/blob/02057eb0a05522f174a76ee7ad6df4f5f280671c/THIRD_PARTY.md?plain=1#L34

This was the result of a lot of iterative testing with codex and claude. 
  Their results and the drivers we produced can be grabbed together to 
prove-concept, or someone can observe them and produce incorporate-able 
patches.  i'm nowhere near there yet.

