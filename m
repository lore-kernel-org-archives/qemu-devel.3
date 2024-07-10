Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5C6C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 20:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRdw4-0001iP-4h; Wed, 10 Jul 2024 16:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sRdw2-0001fb-CP
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 16:29:06 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sRdw0-00046O-Ju
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 16:29:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A4D42CE178F;
 Wed, 10 Jul 2024 20:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3F5C32781;
 Wed, 10 Jul 2024 20:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720643334;
 bh=MXlQD95BUMQwbQsTcYxg5Jmif2vQnZ2bmNfBFHUsRBA=;
 h=Date:From:To:cc:Subject:From;
 b=DhcZyW6VIm/nnjF4TVSNovzR4+e0HAVehObEJxdcAj42wZd8xSgAa2a8s37JfUMEB
 7aq2A6Bp+aIrS07sgEWf9OaLQFJDpahshdDRx/vn2b415Ub/4TU4c8f/aR/eJqXGq6
 DPQG5oJ+Yure2XgbdvqCRJo9mlFSzBLe7ot4mQjykuGgHFaXrlIVNbYPOLTM9+0irH
 kIDtEU6x84JT7JJL3XuoFotUoX8Xju/EcuN4cgMlPoy+TWsp2ZxB1peV8QnfiLCE3P
 0XspiZ8bGUfg321QNKi//pgEvjcUMRuDfvdumpLjGthOKZq5Anrmi+zr945LVWA1sF
 qlwzGDYyt0zLQ==
Date: Wed, 10 Jul 2024 13:28:52 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: qemu-devel@nongnu.org
cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org, 
 edgar.iglesias@gmail.com, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, stefanha@redhat.com
Subject: [PATCH] MAINTAINERS: add Edgar as Xen maintainer
Message-ID: <alpine.DEB.2.22.394.2407101322290.3635@ubuntu-linux-20-04-desktop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add Edgar as Xen subsystem maintainer in QEMU. Edgar has been a QEMU
maintainer for years, and has already made key changes to one of the
most difficult areas of the Xen subsystem (the mapcache).

Edgar volunteered helping us maintain the Xen subsystem in QEMU and we
are very happy to welcome him to the team. His knowledge and expertise
with QEMU internals will be of great help.

Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 6725913c8b..63e11095a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -536,6 +536,7 @@ X86 Xen CPUs
 M: Stefano Stabellini <sstabellini@kernel.org>
 M: Anthony PERARD <anthony@xenproject.org>
 M: Paul Durrant <paul@xen.org>
+M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 L: xen-devel@lists.xenproject.org
 S: Supported
 F: */xen*

