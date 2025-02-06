Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA7FC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 16:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg54W-0000QO-3k; Thu, 06 Feb 2025 11:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bfa7bf02782dbd996201c90f850ca11730041af1@kylie.crudebyte.com>)
 id 1tg54G-0008Sk-TJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:49:38 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bfa7bf02782dbd996201c90f850ca11730041af1@kylie.crudebyte.com>)
 id 1tg54E-0006H1-H0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=JkRdxjgnBKt71547XwUn1O1/I1Rb6x+CIeZvvDqy18c=; b=SkEi/
 cQ2KjJs+Lbpu/slDZ74yqOOy8NOiuYpIfKBTnv8hkSzPTCWI9rZsTim1G/N7HEvh8Z8wyJQi4utgB
 zUo/C1juCQvjw3ZhWzz1smT+JWx7eHEX0F5yDh/8pnKZIRZV1kafoCINVxfEvj/S8ZH4n9OhiMf3j
 gnP42Ubu9oT7aLAKMIRS07sCWQ4QUYi3LdBHdMuIxXIEFpWjTv+Z4nvF8HzBo7/oipRapmq0D5lxn
 qiI1s4Q/bguDk+Vo08lbhD44axuwrZyg63mu5RO5489/uJS+fAyFhgHyVUntZoh1iqfYai2W0Y0nf
 Am8qC1mZYU8MoAKZMpZ44NWviDMfEySNM8RbGFkyW8yZ9bbhl1Dajz02LcbQwLe/WKc3jcsFD6mi3
 0Ww5hsiaM6DHlrUElvVhRWTYYSGfXZvFxrj68hEpoyiYUrJK5Jp4INa4+g4OgK01QX3GrX8cK0ysb
 JYRk6qZCo7qq93VqxH/pAC5Lsps/wAONhQ4ajCm7F1n1Lhb4MJZDNVyYslAhuudjssZYXVSuxm89c
 ESFvaBGdFshBfp85i8afdEmp2U3x1KAtY7xflq4uvxF823Ze+hS11Rv3GVZTEnWtCkKVZevRKySXz
 4rPxJPwZe9aSfNlMTwjFbDMjNXrCqrAMxGxtvQ6rDLerSE02V5m7h5l35Z2py8=;
Message-Id: <bfa7bf02782dbd996201c90f850ca11730041af1.1738860115.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1738860115.git.qemu_oss@crudebyte.com>
References: <cover.1738860115.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 06 Feb 2025 17:41:56 +0100
Subject: [PULL 7/7] MAINTAINERS: Mark me as reviewer only for 9pfs
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Stefan Hajnoczi <stefanha@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=bfa7bf02782dbd996201c90f850ca11730041af1@kylie.crudebyte.com;
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


