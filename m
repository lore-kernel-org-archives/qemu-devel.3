Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAA606A330
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uXUSWSDc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOek8-0000ub-99; Wed, 04 Nov 2026 12:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOek0-0000u7-Rq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 12:25:41 -0500
Received: from out-45.mta0.migadu.com ([2001:41d0:1004:224b::2d]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOejy-0005aK-Ft
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 12:25:40 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=Xenqm7tT8aY2/8jh0immIrLobh1PPDktvJtMt0frxlE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793813135; v=1; x=1794417935;
 b=uXUSWSDcK92X6GLIz+Jw8/CmM3fFrx5BxuYT63jVUmVZj9utLsJTCcBH7flqI+0vR1vD23BT
 htRa9gx2spS4Fn7iSpkFmg43hYbGFXMwkrPA2XwSe8yKjbYrdn1gydgu3TgKCzpUjrBmOjEOxGi
 SKdeRJqN7hQ7b6rVBHjjoTv8=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 3b99aa60dbfaf8f0;
 Wed, 04 Nov 2026 17:25:35 +0000
X-Mizu-Trace-ID: 3b99aa60dbfaf8f0
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: shrihari.s@samsung.com
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, anisa.su887@gmail.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
 junjie.cao@linux.dev
Subject: Re: [PATCH qemu v1 3/8] hw/cxl: Wire UIO capability into HDM decoder
 and DVSEC registers
Date: Wed,  4 Nov 2026 11:25:24 -0600
Message-ID: <20261104172527.2172366-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1384010761.101793792283622.JavaMail.epsvc@epcpadp2new>
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
 <1384010761.101793792283622.JavaMail.epsvc@epcpadp2new>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::2d;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Shrihari,

The switch/HB write mask opens UIG and UIW, but leaves ISP read-only.
CXL 3.2 section 8.2.4.20.7 makes ISP writable on a UIO-capable switch
or Host Bridge too.

With two UIO-enabled host bridges in a two-way CFMWS (4 KiB granularity),
the switch below the second HB advertises UIO, but writing decoder 0
Control with UIO=1, UIG=4, UIW=1 (two ways), ISP=1 reads back
0x00144000 rather than 0x01144000. Software cannot configure the second
position in the interleave set.

Could R_CXL_HDM_DECODER0_CTRL_ISP_MASK be included alongside UIG and UIW
in that switch/HB branch?

It may also be worth diagnosing a partially configured host bridge:
with x-uio=on and two RPs, one without SVC/flit, the HB reads 0x22382
but that RP reads 0x312. The HB UIO bit is defined to cover all its
root ports (8.2.4.20.1). A warning would make this inconsistent setup
easier to spot.

Many thanks,
Junjie

