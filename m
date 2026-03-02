Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABCFE9B354
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hg-0004wO-OP; Mon, 02 Mar 2026 05:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HX-0004tV-1v
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:43 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-00062n-GM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446416; x=1773051216; i=lukasstraub2@web.de;
 bh=M4oN3ce3lEdgtN7JBdV1BpBJqmDTcNHIBAHkYu1vDHI=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wGzpLKV2Z23VxXQxDPDQvGj/+Tq8O8oIYmGctSQ3TTL27FnI/MRwB+sBuD97u0BI
 qZHKNuv29Y+lwVBO7m86tytmJE9vMWpHzf2ynkYM/cYnWddJsDAIR6W03PJCCB36p
 ifXkJyHX4ImAgOvoiuWpzx9zpv4Aduw2cjU2q06AaLmVmNlnlH8VZ5DbNWptH2jlr
 NFeAtNGIeeBofR5f0i4KqEBTS45zZ0B77WqW58cwOznh00KthN7wuQmyuQf2VEABi
 KB9byfdeXVTrQcYQ/KyHnc+R0Va3MPgsljGKM38BwKyadwLojJnFPZ7v07sdB4lPb
 T46irXs2s1Q+Ef8kdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFrxl-1vtyPv0ECV-00CqI2 for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 16/21] qemu-colo.rst: Add my copyright
Date: Mon,  2 Mar 2026 11:13:27 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-16-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RBjsUyK419OI2tM2s9seVXuGPbNJkvd1FTM/9fBKVHA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAGG1qfYLFmZqWaXJZpT0nJFRzya1nRvJ9CJ
 4DBUk7EhHCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBgAKCRA1qwsonF2y
 WGkzEAC7AfGiIX1SNIm4UAkBPYhaK/xxJ4RFZdqHzyhAoRhETIS0+fIgCbwp0nPlsT7uL+7r8Np
 Xh21jsnPlVPN9wPO1BW+pzpjgbj4pmLix3MSIhIxvV3dzq9+YBC4FF67372GhFjps7I7rPmlKUX
 fG9M+J2sPUwKOqjqdK/G5QtoUn3BImp+UxsJ9F2uqgmeo+1Xpi1kRayW0OLbFKnxiAE2+KIzo23
 1DRCnGUqAJYpkJ8YcRsAHQVbo7IZqCipwPFgtPh/zFRaPXujL+yPmhwiCyRGnhns7DGjVHzyadg
 Mznp5mLZ1UOfdQMSOeqO0kALs0Y+jkDGyfadHOs5rn82qMha8yd1zNJrOZLrYyUqsSfOjKJmrOa
 It0YBkG5z+bUGnM3BPbKUETLzMkfU7HsZKRag6pHFAY0YC3WQl03Z9ezfUvJzeUXaM4mtWhfT9O
 PXBlDnUld2V1Tz3Ts1tz4oR7ED7bOBr1duqSzT2PpF+ms0YgqWE1ndiCbnjXp3SKUn34z6ZKBjv
 dSuNgPFT4FFk+SjzEJd0DRYX1c3SbU5krTUjvHX1VreDB4WiVYBrA0zLtt3ZD1rtQKDL99pk3o1
 7Lo1owZEp/43/6SiXxVHcLvN4Rd9cfaY6ZCSIPNqWWF78L8xwBj3hDv94s4vSxfnIB8hrWQHGhb
 1S5LMtoqeOr1zOg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C0/2mJuNnue5dIrnR4Zzs0VCSU/IiBW5WZGmC3SY0dMAmRfXxwG
 TWJjjqRDl/MXUepjA4Ul4+VN1en3sq35hNh3xNJaCB5rlHqFA1JA1qkobODw1spb3zHWVox
 ZYs3/8DWKem1UTDcBIgjO7nFX+IviUtrpmjc3Glbi36SPPVju8zqHuXK7VcmGuczlfhfS3y
 DhJNnKwejkD48z6IMaWXg==
UI-OutboundReport: notjunk:1;M01:P0:ZKZo/NixLaI=;SP9/qBfEyNrKb5fFMaqA6d2sFYb
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I have so far contributed 61 commits to the colo project, waranting
the addition of my copyright to this file.

Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 docs/system/qemu-colo.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index a70e61aa09391cda933031535fa982d27cf6654b..75abbd80298df79223cb8e7006=
4a5dc83d70f4eb 100644
=2D-- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -356,6 +356,7 @@ Wait until disk is synced, then::
 | Copyright (c) 2016 Intel Corporation
 | Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
 | Copyright (c) 2016 Fujitsu, Corp.
+| Copyright (c) 2026 Lukas Straub <lukasstraub2@web.de>
=20
 This work is licensed under the terms of the GNU GPL, version 2 or later.
 See the COPYING file in the top-level directory.

=2D-=20
2.39.5


