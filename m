Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E9606A32C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=SzkPrOHv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=WVKTk1XN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPkdC-0004H8-Uy; Sat, 07 Nov 2026 12:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francesco@valla.it>)
 id 1xPkd8-0004Gq-6i
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 12:55:06 -0500
Received: from delivery.antispam.mailspamprotection.com ([185.56.87.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francesco@valla.it>)
 id 1xPkd4-0008Qg-M4
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 12:55:05 -0500
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com;
 s=arckey; t=1794074095; 
 b=Z+P/a20sG5huBFjlLctSBBYVQpT31bpEhOirMUAaKwHZ4/gpUNu2IrDU+or4tXiJeUtxcHHZG2
 nC4liL8bS9bxs/7b/GOLezOpNtiDBsIcHPdPtlgJCE5ns9O9DOZ1QkTSZE7Xt3FHDOsKabuBph
 gvKHpWlLqyr/SmkCQm+jCyDMbK+yFR200KeH/qqwyq9sFkZzJJS0z8RVbSChOxpthVRqFpxmtL
 wtD+RFZ8iWbt3TdASfZhpbK9rBSwIBGl3NskuTw08Uan2NzNOnZJRzvo1ggxqqSuNGfOa0s663
 xVAemg1Fxaz7JfIoEPHYZqN+jPFfZb+okQpaxYvzKzerNw==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com;
 s=arckey; t=1794074095; 
 bh=PTSl9UiltPCj+yVur+a0DMYvxaB3a1pUhsgPUD40VP0=;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
 DKIM-Signature:DKIM-Signature;
 b=W6dpPCP8mcP6hm2EA601oiKRWT1ppPQxPhMoCTsmTEloucWgjM9yUnfugFK16TB7H3rUtDqgOV
 +r8kZaB6kAQohSMd4zKxMzGKACEUx+ETQi3EvPBMpTWMVMJ0v8U+IokmfWQH7RN8baUAWd157N
 GuHhbeRus2Oukzfuco+sE3BV4ZndFvwEw09CvzS0xTfUVbZrtSySw02VmIklok/FV8Szri0d8M
 XEcrGP+ANFxWf+1g0gtzGryLCUbwzM4QbRmDDpJl3DPdlqPXEmR9d70H6KCJI3LkGrqRfGx3sY
 5dqw1g7P7tYs0HJE93udjR/rPd2QPOjsE3Dde3s+vZSEfw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:List-Unsubscribe:Content-Type;
 bh=AIvPYvRd2QkIrA3WcLJCe1vy4TucALxQ0617RgEz5yg=; b=SzkPrOHvKRo4tpXjtrLMEYGyG+
 ho1kDSs8QY7Q95ri6rBRRSdyx4fjMmZ44aUIkxprdbTh4vx7hBu5IOf+vOpUS+LlpSUsyQEFOuiA5
 M8aLDn2ehfZYbUu1g1oSpDsDztcmYryvCB3w91gu21Ns3L6ckJoS8b+iK8acLIOgrmDk=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xPkcu-00000008eXW-1FhN
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 17:54:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=AIvPYvRd2QkIrA3WcLJCe1vy4TucALxQ0617RgEz5yg=; b=WVKTk1XNVnjtObkklBhbtrrq8i
 SNraU5mvpvct+okx39nIT9d/YbLc/msWyeTdvwX/V42ELUBwxcvuEHJADH4A6sJCaqZM4MYl+XQat
 mue+iZlxNVCmBvYR3a7s72JQSrtm9dWSkH3tZeeG+DODq3Wwl1WOBDEY1fzLh0pGeLGI=;
Received: from [82.62.171.177] (port=49852
 helo=bywater.homenet.telecomitalia.it)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xPkcp-000000001sO-3qyB; Sat, 07 Nov 2026 17:54:48 +0000
From: Francesco Valla <francesco@valla.it>
To: qemu-devel@nongnu.org
Cc: Francesco Valla <francesco@valla.it>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] update-linux-headers: strip endianness-aware __counted_by
Date: Sat,  7 Nov 2026 18:54:43 +0100
Message-ID: <20261107175443.29012-1-francesco@valla.it>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - nongnu.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 33cbdea858e9a3a0dbaa4d3530558bfb
X-AntiAbuse: ID - 33cbdea858e9a3a0dbaa4d3530558bfb
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xPkcu-00000008eXW-1FhN-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
Received-SPF: pass client-ip=185.56.87.5; envelope-from=francesco@valla.it;
 helo=delivery.antispam.mailspamprotection.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Deal with the endianness-aware __counted_by_be() and __counted_by_le()
annotations in Linux headers just like with __counted_by(): stripping
them.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 scripts/update-linux-headers.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 3c3a0e9394d2..d3f843356507 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -92,6 +92,8 @@ cp_portable() {
         -e "$arch_cmd" \
         -e 's/__bitwise//' \
         -e 's/__counted_by(\w*)//' \
+        -e 's/__counted_by_be(\w*)//' \
+        -e 's/__counted_by_le(\w*)//' \
         -e 's/__attribute__((packed))/QEMU_PACKED/' \
         -e 's/__inline__/inline/' \
         -e 's/__BITS_PER_LONG/HOST_LONG_BITS/' \
-- 
2.56.0


