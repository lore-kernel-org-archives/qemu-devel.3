Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F467606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=o3/2jjjH;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=js9QjZQ0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLk03-0000hi-G2; Tue, 27 Oct 2026 12:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLjzz-0000hS-TR
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 12:26:09 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLjzx-0000XS-UM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 12:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=BNb5v+h
 8i62UrLzb3dI7NPCVd/dkkln85eIb6LYPZ0vzEqdioJREjn03ccmuJs7Z48TDTezN6VYwX
 MN8utfKxbQutx2xpzT/41RLkFaPoG+5fzqvfEo8tyUE2LJaGKaWGGI4uNDSQodZJoibnuu
 eyLybFliDY2UYKlnNt9QIhH52PLteWSFtXzi66/6z2yDsYR2zh8tYsmsGaJIb+XOSBkhKO
 mgI5c0UTfUug9ZREev0OgUptRvaclk9D/khzWJKOCE8gW4azyspJ5ZNbBqJgvlZ/nLK6XU
 zosNdKfbuB0gW/Fk0dyEO0//ymUOJHV2P7m5548fX0+22gAYtp0q1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=S
 /cytahUR5L1brrrf6Gkckr1VAC1kNqcaqV2JI4AztQ=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=ExQgfaBEAmhiKkqAWNr3lvNuxJdmYbcE8ZbBLoq5rcZuLvey7iIOe1Gtou+Dc7nylrhU
 H+9S5DKzqSuTqoswQbhrlEkxKb0H8zxVMnXFzHjlATxmVp3/BEVgR+HxvbVTXG/QEnpWfR
 qhMmMTWmbW6HxvtthX2n/Rd+69AHlVJ8iYZ1GRMuLblID7kr5nbLryz15vW1P1Sm9JbtuI
 d4x/4ngYa+mviNaJJyn+vaZVhZBFn5qT2ErvrYGAqseKztMw8FkKDO0uBEGDAdSGNXXGqu
 QYY7BrjUubnVMI+TUWf2ZwzNUl9anAghUtxMOeQIqNVtrPUVdTAUzlaTPXROFGDw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=o3/2jjjH; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=js9QjZQ0;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=S/cytahU
 R5L1brrrf6Gkckr1VAC1kNqcaqV2JI4AztQ=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=o3/2jjjHfJ6dDhcKhkUiFr/taXVtqy
 WL4llXePpMLMiBifK34jNIRtER/6/u0kIE87k5I9mJER3BszSOAqw41Y+Tfy9tgIb5Qeap
 jyZLWv2/4AJopGi02XATBPKeN2OOgJX3v83HTas16jKSzc7DQHp4gC+QNDOMb6morGLwcT
 bsm1RGVlV0grL7VXfuljvNaTl9BiddPwjwHySk+hECR8gk1/aeimjYpijbtCgmpYQu1OR/
 EV/BJukMV93HjwnVjBr2rnqHLwLLaK5atN46SZPHgTlczUo8H1GOwo6k0/smebHdPtfvhG
 LUqNf0vChpXeIB4S//Wg0YCAwwh0C/ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=S/cytahUR5L1brrrf6Gkckr1VAC1kNqcaqV2JI4AztQ=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=js9QjZQ093ePozPmMB
 sLSqs7sJctssdCcICoBXILRm7+czOwnDPhLUW/7lYdpAI4RSXopj9y8kTljuKyvFGpAg==
Received: by mx2.catap.net (OpenSMTPD) id 554c4b1c;
 Tue, 27 Oct 2026 17:26:03 +0100 (CET)
Received: by matebook.home.arpa (OpenSMTPD) id c06360af;
 Tue, 27 Oct 2026 17:26:00 +0100 (CET)
Date: Tue, 27 Oct 2026 17:26:00 +0100
Message-ID: <87se1rrtyf.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,	Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@mailo.com>,	"Michael S. Tsirkin"
 <mst@redhat.com>,	Aurelien Jarno <aurelien@aurel32.net>,	Jiaxun Yang
 <jiaxun.yang@flygoat.com>,	Aleksandar Rikalo <arikalo@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 05/25] target/mips: add Octeon CN73xx CPU model
In-Reply-To: <7ce4be83-3525-4990-b9e5-88b5b114adcb@oss.qualcomm.com>
References: <20261027104433.25720-1-kirill@korins.ky>
 <20261027104433.25720-6-kirill@korins.ky>
 <7ce4be83-3525-4990-b9e5-88b5b114adcb@oss.qualcomm.com>
User-Agent: Wanderlust
Mail-Followup-To: philmd@oss.qualcomm.com, pbonzini@redhat.com,
 philmd@mailo.com, mst@redhat.com, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com,
 qemu-devel@nongnu.org, Kirill A. Korinsky <kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 16:56:42 +0100,
Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> 
> On 27/10/26 11:41, Kirill A. Korinsky wrote:
> > Add a CN73xx CPU definition for the Octeon III machine. The PRId, FPU
> > FIR, and L2 cache geometry come from EdgeRouter Infinity ER-8-XG data;
> > the remaining CP0 fields come from a Juniper SRX300 CN70xx/CN71xx dump.
> 
> Why add the OcteonCN73XX and not a OcteonCN7[0,1]XX first?
>

Because available u-boot is only for that board:
https://gitlab.com/u-boot/u-boot/-/blob/main/arch/mips/dts/mrvl,cn73xx.dtsi
and modern u-boot doesn't boot with non OcteonCN73XX.

Here some other very old u-boot for other octeon boards:
https://github.com/disdi/u-boot-cavium/tree/master
but I think target this one is strange when here exists a modern one which
allows to build u-boot which actually works.

-- 
wbr, Kirill

