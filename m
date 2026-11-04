Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A521606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=S0l21P3y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOekD-0000vN-1d; Wed, 04 Nov 2026 12:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOek4-0000uT-91
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 12:25:45 -0500
Received: from out-47.mta0.migadu.com ([2001:41d0:1004:224b::2f]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOek2-0005aj-R2
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 12:25:44 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=KvcV0c4jRWUZ56qd0nf0GVpOhs3x5p+gMgincRqh3Ic=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793813141; v=1; x=1794417941;
 b=S0l21P3yf/EePM9E9LVhImMS+NLGodZraKUntXJ5bfrGOm+j8hDq8LYrITNGVc5POFBrwkgL
 II7V0CZCApoELbfDW2dddTvPJiZOjcSHmRPgmfzRO9zz1+vB68taSpBAlPZhh8e3+gMdQ6MGwY6
 CFsrYE3xjvLHmwlM+ztltrHI=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 4064cf3a45f60569;
 Wed, 04 Nov 2026 17:25:40 +0000
X-Mizu-Trace-ID: 4064cf3a45f60569
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: shrihari.s@samsung.com
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, anisa.su887@gmail.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
 junjie.cao@linux.dev
Subject: Re: [PATCH qemu v1 4/8] hw/pci: Add PCIe Streamlined Virtual Channel
 (SVC) capability
Date: Wed,  4 Nov 2026 11:25:25 -0600
Message-ID: <20261104172527.2172366-2-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <603443293.161793792284076.JavaMail.epsvc@epcpadp2new>
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
 <603443293.161793792284076.JavaMail.epsvc@epcpadp2new>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::2f;
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

The protocol-selection checks now reject the bad writes from my previous
review. The TC/VC map defaults need another change, though.

On 3c99db7705c1 plus this series, Resource Control sets 1 and 2 read
zero at cold boot and after a system reset on the tested CXL root,
upstream and downstream ports and Type-3 devices. PCIe 6.2 section
7.9.29.7 requires the TC/VC Map default to match Table 2-46:
TC3 to VC3 and TC4 to VC4.

Software that keeps the default map and only selects UIO and sets VC
Enable writes 0x80000200, which reads back 0x200. Restoring defaults
of 0x08 and 0x10 makes that read-modify-write produce 0x80000208 and
0x80000210; both then retain VC Enable.

Could init and reset restore those map bits while leaving VC Enable
clear?

Many thanks,
Junjie

