Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66C606A329
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YMRpIUBf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOekG-0000wW-3R; Wed, 04 Nov 2026 12:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOekD-0000vk-ID
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 12:25:53 -0500
Received: from out-54.mta0.migadu.com ([2001:41d0:1004:224b::36]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOekB-0005bX-SO
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 12:25:53 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=bd5pazkQFKyYKEGSIrWiOc6GEPTqyZzq9paOrIDWKRk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793813150; v=1; x=1794417950;
 b=YMRpIUBfnwMjpobL1YZXYntr0uShvmm/gVsUQvDl8JotH/Fxvub4m/ceJEjRTI4vsdyZ9xl8
 xdlkVcv+NmXFVI6W2kUZnXWaOglWNSfvv/yRCEw1C2lJw1l+nKV5A+arzK/W/O/BPkB4ahzpXm1
 jS9oXOYhV431spqrq19YfZ7E=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id b823a6d435641782;
 Wed, 04 Nov 2026 17:25:50 +0000
X-Mizu-Trace-ID: b823a6d435641782
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: shrihari.s@samsung.com
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, anisa.su887@gmail.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
 junjie.cao@linux.dev
Subject: Re: [PATCH qemu v1 7/8] hw/cxl: Wire SVC and Dev3 capabilities to CXL
 Type 3 device
Date: Wed,  4 Nov 2026 11:25:27 -0600
Message-ID: <20261104172527.2172366-4-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <331418503.141793792283935.JavaMail.epsvc@epcpadp2new>
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
 <331418503.141793792283935.JavaMail.epsvc@epcpadp2new>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::36;
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested Type-3 capability enumeration and UIO/SVC/flit dependency
combinations at cold boot and after system reset on q35, with the
full series on 3c99db7705c1.

Linux UIO discovery and a 1-way UIO region commit also passed with
Davidlohr's pcie-uio-rfc kernel [1]. For that kernel's UIO checks,
QEMU used hdm-db=on and CFMWS restrictions=0x2d; the guest kernel
enabled CONFIG_CXL_REGION_INVALIDATION_TEST to allow region setup
in the VM.

[1] https://github.com/davidlohr/linux/commit/4726547f45a612b2d953f5f4e13ab6fe34672c7c

Tested-by: Junjie Cao <junjie.cao@linux.dev>

