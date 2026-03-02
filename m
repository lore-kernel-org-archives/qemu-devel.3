Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87058E9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1jD-00019F-3r; Mon, 02 Mar 2026 06:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1ie-000074-FR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:51 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1ic-0006DH-Rn
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451941; x=1773056741; i=lukasstraub2@web.de;
 bh=M4oN3ce3lEdgtN7JBdV1BpBJqmDTcNHIBAHkYu1vDHI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hGdB5Bk9ZjNYJ7t5t8turdQ0GSyx6NCt3flaE3Xn6e6pb9c2VPsCgpc4zRiZYcDI
 NIWV5Z/HCUGqA3jWFQfoubS8ScWOebcjYKDLR06u3HBALlQasKkx9ZKNkZO2JMqQP
 hnDQsCHnDgN5o/SEVn4SiibSx1oBNkremT/qNBsYAS+7G7L89Esv3tK5NeZd2U/pA
 yoaYPf6mHmQD3Z/k7XIXNtIt9fMS4y6YJjeO1sgQBI24ZI+vRHIALuw4CPA7niaUt
 jWrQLpIdM2KrLCKjwO+ZjplPSEr0XWwZqPmxDBd8qEaafOOrw758fiDL4aL7D6qxH
 CloriI2fNlaFMkT/MQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsKH-1vFPYk0sS3-00mzrR; Mon, 02
 Mar 2026 12:45:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 16/21] qemu-colo.rst: Add my copyright
Date: Mon,  2 Mar 2026 12:45:31 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-16-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RBjsUyK419OI2tM2s9seVXuGPbNJkvd1FTM/9fBKVHA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6U5ZlaV99eJwVc83J1mGqzUFvz9/2/TKb40
 y4NLJ/RhMqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVulAAKCRA1qwsonF2y
 WI0kD/99NHnY4UqUUVg0pPaZ5G5CDlerRCmPCTlwGTawtLNtsHL08LMegkU5+alUKjtbcR7Bzc8
 azP/DNonuSQo182LxdjEmF/xkb4pmjwakYN5D80ZqlTc/9AJICWraS1wLLlQ7yIx4kdX8wP+C7+
 4aez5Jdr25Zga05O0B4n+3Y1jiT6NvOFJ+V4ivCD5fOZi8lpeQPfL9OF1gYS9RecMyBm2sHkEGC
 UByJ6dV0jOTAwQOHO9dWVhPHMKATIpZLcgptOTiPJYJ/VNALZIX9PtzE/scDKeQteyNWQfsPk/n
 igIhGNNYAgOfp9UlILX6mY+gvOPDtuSZt/fxvtyjpbMCxPgGTIK6KdCiWsM/pWIjZ0esEygu3mG
 iYLFcWLQQro/NmdSCtjiTUmSze7aCDyV+tGoCcV6aoYbTpjAGPTuHfcroXLBaYuKWxx1SIBVCME
 1ECfsnYN4F996c66pAwPUGt1vWFAHBVVJ2VwGvDahAXfKcC9zEK4pEsVOvvc+fTJa2vWFnjZTni
 hFnfHkyxKpWUXkZsUMQuc2k2Hc54YnkDj2TYr+c4tY/dbf3Z3zytr6DlTfcSTckpP1kMJ5f6302
 fByit3VIHq74kpfI+RlP//zXFXeGLWx6hZLBJrnttuQt3K7vcowETos3/SF4xnGn5zGciSrP0tc
 kp7p7Oxelq2MKBg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6WDC3vwM7L7NG+fVdtWpELsAaN3SEZjnfl9kVFCHVkancn91Spv
 +NDeQkVW77er64TVz+13ypPv7gR8JhL3wUL0G3NfMvaZGvZq2V/3vYOvmBL7cyJLiZ+ox8A
 nmZSyAKnjOo0OmZ/vDQGg+DG8eB7I19v/pgu6nXYeqdy1OkzKfb9sc9gqMwc66IUJSdpn1v
 py1MHJ6Irn2Okq1LA8U+Q==
UI-OutboundReport: notjunk:1;M01:P0:ylYIbzxe2po=;DYW9ytI+iMc78q6p22GJO4FxqTk
 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
 0SWbAzDyEUEku+gAQ=
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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


