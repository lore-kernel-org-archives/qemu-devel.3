Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D858AE9A04B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7l-0007JM-Bq; Wed, 18 Feb 2026 16:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7L-000798-R6
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:56 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7H-0007O4-UT
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450182; x=1772054982; i=lukasstraub2@web.de;
 bh=M4oN3ce3lEdgtN7JBdV1BpBJqmDTcNHIBAHkYu1vDHI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=E7+ar3ohhw8bQVBCNVRsCJv3K4PUwc7t4UYn+SjaCjfR0c+Q8f9wWsIBu8XLWbGz
 /5dJeZBdJBHIfW7NPdJMmsWaIvIxx36tY8sxpm3zWUY1cXt2cNpiOf1jYg8laPCLt
 7WKnZk4oiINXu38m72NnHkU6rYRitSV42X/XPg6lla+J1PjcLKM5NujUnENLm3CJ3
 DQq5g74ebmCWOj0Y6oCxHBhbUDYe7AuPREX3OU+Lrh779P1us4tmsTZdZlRPPCb8S
 XCld9kqtCireZgqwZf5IJRKIhN0E6QykSCvVdei10y/NKTTHRcxF+FAry1cAeS5qC
 hu9MVwOwv7ZQZ2ohtQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaWF-1vdLOn12S3-00rwzw; Wed, 18
 Feb 2026 22:29:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:36 +0100
Subject: [PATCH v9 16/19] qemu-colo.rst: Add my copyright
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-16-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RBjsUyK419OI2tM2s9seVXuGPbNJkvd1FTM/9fBKVHA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli89zHDdN11Qw6qwuppDDo9HdeDO9bgfvD7X8
 ZnihDZndOWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPQAKCRA1qwsonF2y
 WPBFD/9lgZE7HfWXAFz3JOb4ZLhle7xt4ucACEDhxcRigOiNDA6OCcgrY2Xv/jEUveF6hfUXnXN
 Rw7iz+Mv/sCY86HUWzK8JgyLM2HK+VZeKYIsxvs3cYYFtWSStrhljZpm0lwtjvYZdbAzW7f2zC9
 J30KQpmSrTz+BNmENDOWPcUzg1w14GemXE4ifSFuy0m/J9e9HrFN0kY85fI80alTiJ5dhmxQv83
 4KK81I2AytB6SKJZIzEnW/wRkABhddTbJEkPmFnYnvmcuDXIpb02varkL1F564ZWOXWqtDRFxrb
 +oSkbxF5xeT0ulGhPHXcVZiCDTakRiGG3nPAs2Edb3Z6g3IRwkUDTEDCn9wGNAjT71t0ijNQJ1x
 dIBZT83+Ky1q7np81/3A7rv6SiTs8LX9s++IN+RIXgZohA+2TNZ5yH8jSpETaGOqCL1t6ufYqjq
 FEJ3wqULn4jitEnwyxdQd/XXbYG2JaRDXz1h9F3DLO13MoapjD2ppwT5rVShU3Aom3xcVN1ZFBT
 ZfntFPnV3E/hOJvedAiKc5z+CUZZQn9vBrxQvf72HufPjFKwcPcS+gzkLXv7P5keNGQoQeAY5pc
 D/5I1DT5gWT+5xOtx4RzZFNzOMlBEySj7skjv/lDI/CRbrvJYUmXdYBgIjWuhP67AMrL3C11wqO
 mPVJ7EPW3OEcCXA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:OToPzgOad+5DGlcOqArpteg/3BuXjsNoRPTKNv1G3iSezH2vEra
 OEtxEeKN0mE76Wz0lGSK6UMN7u0vxGfj73B4JJe8iqmL3c/Dq0Npuf656nUm4EmpdKxy4KR
 +zDBWztbj/Hv4fKweCqKqiX+tva4TiBBd4f/33wy8kTw2dMYnT+ehLKmBZe+6CCyhIhQEbS
 GY9q78tqtJEGONvyOQ6oA==
UI-OutboundReport: notjunk:1;M01:P0:v2uhjcqRmHI=;/mNoc2OQu66spM0OeeFhVMF2Q7C
 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
 c5jXzHp1okmOx7/lxpwsSjPhIu0LXa0BkZYMv6
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


