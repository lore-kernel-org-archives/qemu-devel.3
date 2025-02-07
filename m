Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B66CC02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 09:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgL8Q-0004KX-Ez; Fri, 07 Feb 2025 04:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <52065d405ae96221f15b0fd9c099437c77178d4f@kylie.crudebyte.com>)
 id 1tgL8N-00044J-02
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:58:51 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <52065d405ae96221f15b0fd9c099437c77178d4f@kylie.crudebyte.com>)
 id 1tgL8L-0001Kr-DK
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=JkRdxjgnBKt71547XwUn1O1/I1Rb6x+CIeZvvDqy18c=; b=e9cvd
 QTiXv3zc5UaN1mjj9K8O/stP3/tyTdthqNvx2CzLzuYnNqCD6n6xWBViNiNfJ5dYKaApadoGMfv0Z
 C7Oma4MoaR+JB4Pe/8j44Cc/vPW2hK03jLh6thp0T/EqotxsTksOIj4xUJb7JQZic04dRfABpp387
 HPc3jhZ6iklW90x1qwVWOfP0iID+xc/K61RQqkOcvcXkyC6l+b+KsofEFhJVW5/uNdcw3JD72l6HD
 iYXz0dA25nW5qvF2Czgq61FxzTfwh56UhRHMcEDxHv1/cS+enXSRuxwrq60pN6CLU7neb0PGbSL5u
 JdhAoSZ7YeeDntCvdrC4KZpqoOlBSDHCUhUnU37ANQ7k7wVUJUqxoqxXEukVl3e3TKwTfJjErijE0
 xUqMdbENUJQTZdUPL1BxFHBjR2ywaRb/lOrP80RLGpUulkVv7juL/d8dbyfF7Lk1kkNXQFm/pKKxR
 NO6VTvVYAWuZV5g77EIKYpRKl5rKfY5frm35seMSuKDKJuTdhmQGbxQGp9dlzGhwOO4kbIVoi2se8
 XYSSFjJsTY/Vh6TGAUkXpuz/7HGr2LuKC5885tIsZTYLmkxIz0U++LJbcgx1gw5lFg7nFVCvuFz6C
 3/kFTbLGlquVnBHnNHasX8NhU4ok43H8m8QYtasG+TLQNGQJ6ckJVEAnyymrRg=;
Message-Id: <52065d405ae96221f15b0fd9c099437c77178d4f.1738921999.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1738921999.git.qemu_oss@crudebyte.com>
References: <cover.1738921999.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 07 Feb 2025 10:53:19 +0100
Subject: [PULL v2 4/4] MAINTAINERS: Mark me as reviewer only for 9pfs
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Stefan Hajnoczi <stefanha@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=52065d405ae96221f15b0fd9c099437c77178d4f@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Greg Kurz <groug@kaod.org>

I still review 9pfs changes from time to time but I'm definitely
not able to do actual maintainer work. Drop my tree on the way
as I'll obviously not use it anymore, and it has been left
untouched since May 2020.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <20250115100849.259612-1-groug@kaod.org>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0cf37fce7b..c6859cbb0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2254,8 +2254,8 @@ F: include/system/balloon.h
 F: tests/qtest/virtio-balloon-test.c
 
 virtio-9p
-M: Greg Kurz <groug@kaod.org>
 M: Christian Schoenebeck <qemu_oss@crudebyte.com>
+R: Greg Kurz <groug@kaod.org>
 S: Maintained
 W: https://wiki.qemu.org/Documentation/9p
 F: hw/9pfs/
@@ -2263,7 +2263,6 @@ X: hw/9pfs/xen-9p*
 F: fsdev/
 F: tests/qtest/virtio-9p-test.c
 F: tests/qtest/libqos/virtio-9p*
-T: git https://gitlab.com/gkurz/qemu.git 9p-next
 T: git https://github.com/cschoenebeck/qemu.git 9p.next
 
 virtio-blk
-- 
2.30.2


