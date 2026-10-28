Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7B606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hEVxZ/b1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtD5-0002G4-ND; Tue, 27 Oct 2026 22:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xLtD2-0002Fe-RV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 22:16:13 -0400
Received: from out-10.mta0.migadu.com ([2001:41d0:1004:224b::a]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xLtCv-0006Tj-Au
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 22:16:12 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=nhKBgpWBp6UT0ZLGjWyVq714r1vaHD7/A7/243Tlg8g=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793153760; v=1; x=1793758560;
 b=hEVxZ/b1hi9Km3fdsq6DWZdjobTxcT3k63wUzAIP15RZSYNiL81XHhkCCwIxHYMB01KrWHLU
 lZ8IsSWwqnqmXdJy3b9Niexz23pxuuKuSb9Fvhk/mYQxN0jr7aM3FvJjy3rC6nRHJpccrMs11iC
 OjkZ8L8FgsDWObxkXz8qYWEw=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 7889769fc7395345;
 Wed, 28 Oct 2026 02:16:00 +0000
X-Mizu-Trace-ID: 7889769fc7395345
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, jic23@kernel.org, mst@redhat.com,
 anisa.su@samsung.com, linux-cxl@vger.kernel.org, junjie.cao@linux.dev,
 junjie.cao@intel.com
Subject: Re: [PATCH] MAINTAINERS: Update Junjie Cao's email address
Date: Tue, 27 Oct 2026 21:15:51 -0500
Message-ID: <20261028021551.498530-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <02d394e6-eafe-4a3d-9f63-61b639267aa8@oss.qualcomm.com>
References: <02d394e6-eafe-4a3d-9f63-61b639267aa8@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::a;
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

Hi Philippe,

On Tue, 27 Oct 2026 19:20:21 +0100, Philippe Mathieu-Daudé wrote:
> On 21/10/26 15:43, Junjie Cao wrote:
>> -R: Junjie Cao <junjie.cao@intel.com>
>
> Could you Ack from your other email?

Sorry, I've already completed my handover at Intel and no longer have
access to that mailbox.

If it helps, this aw99706 kernel driver patch from August is
DKIM-signed by intel.com and has linux.dev as author and SoB:
https://lore.kernel.org/all/20260804030255.1934470-2-junjie.cao@intel.com/raw

