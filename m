Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC105CD1288
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Mar 2024 14:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqZOK-0001pf-8E; Sat, 30 Mar 2024 10:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <dcae75fba1084823d0fc87caa13f0ba6f32155f3@kylie.crudebyte.com>)
 id 1rqZOI-0001pW-Qw
 for qemu-devel@nongnu.org; Sat, 30 Mar 2024 10:09:02 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <dcae75fba1084823d0fc87caa13f0ba6f32155f3@kylie.crudebyte.com>)
 id 1rqZOH-0000I8-25
 for qemu-devel@nongnu.org; Sat, 30 Mar 2024 10:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=CKxpSnGumg2HQUjOvfXHdXAFz/Bc3upBTPoFzaGQN2o=; b=UzMjv
 282AtLVtYGXwZ8hLrbuFEGN/Y2qooLBORSPfDO+7OvPI1pkK5yrioJrL52UWWB9IXBcuksCdGu66B
 ye9OLMF3dYwZO2ErrBCSJG05qWmjiBcsYBSdTErpc7C8nblMkML5i4qTbhUspTsZVbs6CAsfFtAlA
 JnEU1O8PZvsOOMf1Oy9shoLN8sktKASwzvBmTtKW6sDJB/ur94RpFmEyLU3Liq70hVeU2iIWBJ2Tp
 Qo+FPN/DUI1TMZ9B4OAGn0hbsJMTNjIWT8umY/9TX/d658Y5QRMlmLfzLUjcTgX+8hwRsrBawCn4r
 /FZCNWz2SxidxdMZHDfvZpsRh2NsBLNHLPR68IB7dyXQfFLjMB+Q5kvV+6ZyUX90ZT7iBYQFCG0aK
 DIEU+mYrr3MxfCuE0IRl+7cj3Tc2oX5AiadCk4YpQ3sBJV5ORl5DEObAJa1iXzO0832LClLQGhKyL
 zdpQUrhnWKhs2jEFpAAPDP9aegG49f3KynoUXbdTP3q51/Gq4fmwSQcB18/IB/WRBHPHCuuRGGa5w
 DDIpajuq+kRplGRm9MTpx1gVQ1qAIk467P/InmPp89nuP9K7xSP7QKLb0yQdlGJnFW+NqJ7FYsI7m
 VrU0iyR/vAtCKnRxAi4dY8UHlZ0a54wHR6r0Grx+ou31a+FnuLgYtPlc4OwiV0=;
Message-Id: <dcae75fba1084823d0fc87caa13f0ba6f32155f3.1711702001.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1711702001.git.qemu_oss@crudebyte.com>
References: <cover.1711702001.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 30 Mar 2024 14:33:03 +0100
Subject: [PULL for-9.0 2/2] qtest/virtio-9p-test.c: remove g_test_slow() gate
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>
Received-SPF: none client-ip=5.189.157.229;
 envelope-from=dcae75fba1084823d0fc87caa13f0ba6f32155f3@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit 558f5c42ef gated the local tests with g_test_slow() to skip them
in 'make check'. The reported issue back then was this following CI
problem:

https://lists.nongnu.org/archive/html/qemu-devel/2020-11/msg05510.html

This problem ended up being fixed after it was detected with the
recently added risc-v machine nodes [1]. virtio-9p-test.c is now
creating and removing temporary dirs for each test run, instead of
creating a single dir for the entire qos-test scope.

We're now able to run these tests with 'make check' in the CI, so let's
go ahead and re-enable them.

This reverts commit 558f5c42efded3e0d0b20a90bce2a9a14580d824.

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20240327142011.805728-3-dbarboza@ventanamicro.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 0179b3a394..3c8cd235cf 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -746,15 +746,6 @@ static void register_virtio_9p_test(void)
 
 
     /* 9pfs test cases using the 'local' filesystem driver */
-
-    /*
-     * XXX: Until we are sure that these tests can run everywhere,
-     * keep them as "slow" so that they aren't run with "make check".
-     */
-    if (!g_test_slow()) {
-        return;
-    }
-
     opts.before = assign_9p_local_driver;
     qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
     qos_add_test("local/create_dir", "virtio-9p", fs_create_dir, &opts);
-- 
2.30.2


