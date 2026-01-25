Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C29E63CBF
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 20:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk6ue-0006yz-VB; Sun, 25 Jan 2026 15:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6ud-0006y5-U5
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:47 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6uc-0006Cv-9x
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769373644; x=1769978444; i=lukasstraub2@web.de;
 bh=aOvpBKvuQu7w4pl2aOeHOdeK2Xv4HGosQpxJEOLDGSU=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=KWH6rgvJr2cYFeifhWiOHM6DYi5SycG87Cfs8bWPTSS3OPe39Y9aAQJYHDA3zsHg
 b758WsivezQGZflIrASSNW5vsnJliaOsSiNxCOmW2fH/N4Rpw8XJZukv70FrkjxHc
 iWdLojuFhhnwJAu8fFgGFm3EhE6HmLxX4G6JGmo14gXUs4pA9qZrBqodUABSySuyy
 GN/T/RBSqH3B9P13WFhvzadgMwk5o71B10Vwi6NPkDmcbH1JD2KwUegovkNEYVau/
 0ijxVCuM+0SU2fdV6/hFemrFg3HgzM0h9yIh3RVy5Rn+4RyuI9/tfz2iOqV4AEeYk
 kMt2O0or+BCg1EWtiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYu1C-1vFByG2anI-00MP7w; Sun, 25
 Jan 2026 21:40:44 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 25 Jan 2026 21:40:14 +0100
Subject: [PATCH v3 09/10] qemu-colo.rst: Add my copyright
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260125-colo_unit_test_multifd-v3-9-ae926ccd8eae@web.de>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
In-Reply-To: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=861; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=T71DG3fEVTcTLwOHOcb6Prrz95/6+WhpFwEqvfzYkdU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpdn/GRDTFfO3tMp2NeWaKhe+Hjb5hcMeOslQ9N
 NJGOGvk86+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXZ/xgAKCRA1qwsonF2y
 WK6iEACM3rwzqUVmcxaD9t//vttjuK05pA6uSkIj5aUAxj+pac8SA4M91QYeqDeRs/iIhgqZUWU
 bDXjNNHLLdufZ8MSXvcv/jK1rMHPXjFc6IbrZnoD6J6/crpjQBlEd4pcPj+l4TrByIxDCq3QzOL
 BVhex2w1u7afvT6VD/yS49KmYwKVH33UvMYgRjnMZ1Fl+l0lemGlmhenZtLOTdcQmshOF3cEN2h
 TCg+gFu/EAADV2clZg0EKdLFr+GlhOoU3U6dbTf4ONBJRosBwBVhY53AvfUTMw5zX1HVq+LacYU
 g2WoVGLGM1GUkWmhN/IrZdhdhV8fD6mXjGZiwkt2c7RPll2MiWNnM+9XXrpEgn3XPkyCa1XTskd
 /NUoxNxtufexq0t3yXRKWIc/cIBxeE2SMaDBa8hMmkjKag/LQzuiwOdoAPJc7SleKgnpNdUe5fX
 21ERUpcezGX3f3bqiE3QDM6xPzfvR7OIM2ve1JBV+LkVN/yk/4grW/yOSDb1xYKduSv+XtaPGtg
 ECbXN45IbePta88lwHE2kAVUlJ+fl1+7sTQ9EVh0y9N+P6YtAnEvqE5SfZYsAgJjOkZCYT4NuPY
 CTMq+W7o6CXfb9a4BVSTkA8d8wdf9ZdtrVV4IzTQvHu3fQvAmvmQvU+jBzsY/kfCEcuTGeS2TRt
 tpMLRoOuB4tggIQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:6vVKJ63Fp9ZXVagD4J4ToHYwOgmDit91qBL5h2w1AzxfRI8Vdxa
 jHAQRPJPHZCmTo16TbrrLxpcpij8qicAoFGGAfnmvuCDIRUesL4J3tM6OEEQ+PDy2RZaTkh
 I2DlOQj+JCDWqrVnCURNGnGtg2xP+iHeTapePsXN/3eYpwOOqtF6+NHMopw0UpVNTKLxOl1
 FSm3+hUlUPYCQxD2eg/BQ==
UI-OutboundReport: notjunk:1;M01:P0:u4wlhnTfur0=;9Tgw5NBwHC3sgM81fTSMkNg2hub
 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
 UfQM+7WIxwFnZa62gBa8ZBb24CBVWBm0WQTeoH
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


