Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFA3C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIor-0000ZL-9b; Wed, 28 Feb 2024 07:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <esriyag@ericsson.com>)
 id 1rfF2a-0000ro-Uo
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:11:48 -0500
Received: from mail-db8eur05on2067.outbound.protection.outlook.com
 ([40.107.20.67] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <esriyag@ericsson.com>)
 id 1rfF2O-0001MF-84
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:11:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2W52oTyOPpq8Q2vsvyCp6gVbi7kBNgy0Ao+MdWnSg5jA+rXkjwEVBB5AEapIm50KKEOaOsU5Fv4E8TSaApmm0grplDXgLYA7EhN80LE9eVgRGvPDi0UncNMl3nXFpFaqnrjQwLD4XsXGCUdfWwUdEl3oo552Bkpfa2h192E3ojDWWEKkDkYnj/B0hSnh/dpkL/bogrVU0GpqdWWb8OQdwInw7HiVxtGcRytcJzkuE0FxID0JNM6tc+BCsK4yfuvRmTuWnRZHKhbN5OIlih2GmaPDQSUX8NfGeN61p3q4Huycu5PKV7F9Hl8eB9Kw89b6nO49zHBJJIJmgwmL8i2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fhywoz8C8ANmsmvXiJgpYy3nCd1oaxQ1CnjkxvMn0D4=;
 b=TJwUevUoL6nCE9sYT45JeqaD7DCDPidzONnOuePMjajAPfQLuT81r26LIOn9Fxo2BMtxclPWPuzxxH4OgoVIFLk8NiQuiVagHHQfX/t2GUU5wwiz3dkfV1rMHpSKmc7TvpYK2SziNaBB/N7gr7AVzRuDqKkRbIeB1EhdGhV6OlccOlI0iAQWzokkhcT1+v2XqFyAVHxi+iIOTIwUy6VAhK3VNOR1WMaogVXdLn9nMua4rcKCp2DNzLvgtL+6vDv27l6dZv9npNPRah8Xs3pqqqOz42Et2FxL3mfCmLBczTfgTyWU1BJ+fk9SvtHwomIRb5CszNiJVml8VpwNrYKtzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=nongnu.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fhywoz8C8ANmsmvXiJgpYy3nCd1oaxQ1CnjkxvMn0D4=;
 b=EvjkEuKZsGecWx8CzSrG5FgTZ8yYYtOeICclgbBUs2fBqNOZP6ojDfmA0hLYjvR16L3sxYPqcaO0S9rV3+6tKO2OG9VUPl/WNmUdXQRQabftlCK45/AhnGmCF2kxb8CkmgwvV4Ye13RT8qezAGPUI9W577V3nbb9DeKp+hgymZa7O4Wd9eiUfBOm/Zvq3Ppxbb3vi+DYSCChamEWfukgVJXntJNtIg7FVxYnbDfk4zFk6NaQ27ybpXmKCCckOy0NTWGnvyFW4DTY4reJ3wYUmMOgjJhQ17reN0xWG5Uv+SzNoXI6CietBWlePIDV+rwdBrEsDZu5gLBHOkti5Q0M6Q==
Received: from AM6P191CA0042.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::19)
 by DB9PR07MB9294.eurprd07.prod.outlook.com (2603:10a6:10:452::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 08:06:29 +0000
Received: from AM2PEPF0001C70C.eurprd05.prod.outlook.com
 (2603:10a6:209:7f:cafe::c6) by AM6P191CA0042.outlook.office365.com
 (2603:10a6:209:7f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 08:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM2PEPF0001C70C.mail.protection.outlook.com (10.167.16.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 08:06:28 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 28 Feb 2024 09:06:28 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 2D494C000088;
 Wed, 28 Feb 2024 09:06:28 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 0677561BBD3A; Wed, 28 Feb 2024 09:06:28 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <qemu-devel@nongnu.org>
CC: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH] MAINTAINERS: Update Sriram Yagnaraman mail address
Date: Wed, 28 Feb 2024 09:06:25 +0100
Message-ID: <20240228080625.2412372-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70C:EE_|DB9PR07MB9294:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d03ae56-0ff8-41c0-6900-08dc38342ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmBkd4LWD1Z8+cByKNwh2Sb6BHxF+kArLcfQ0+rlZxnkq+RvdDIrmsUfl4GMtHEldmaNqFWbDhQjCr5tWYfR867kCzWsczHAZaD00GI5OFzZe62ZtEdKPbN52nfoq6eyQzj2fWGp/Y8IfGIaGrrS3dx5S3Vn4q//b/HTK4dkEXlDx+kHXJdO90ykd0/wKoI4pV56Zr8IduvgfL/slMenRXWZfyho3ilLsP7P1hgxotZuzgdI+5e7r/EwBnwRV/egWOb7xR4RyCUMubRl/iX1AN1fQTlucwOBFCo3KIcIuTcowz8gNM92ocu7eJ7N0rMbY2xBkf8yyPcWDhtzfB6QsEdQz6DFYpK6r9+b+clCG552Du51AoyCebEcrsWsylKwAslgx53ydpad8NoXqONgQSEgiYsMUQGNxTKr5qHkTo9UcjKhmFDWsDvWk07K6+iZASNjfWhjMHaXJKEc/JEqrfJT6yny/E8flhgLGaoEohhjoSXW4gsRlNQ283vg6gWT1yg6Pn7bxkt/Y5CGFiBJdh64/KtDiUYf0vlO58oUe9UbqnqTCUt530cdegwfVnqdFtj1BytifQnfW0seJ4NohU4NIxBBrwqtY5KCcnjX+9vkAR3aISi5bROtzwIL415biXWc3FrvkLdCeZyMLMWY8DyaqV/F0ObY9u53YS/KrVYvkUI+nfkmc5x2i0AMriBLn6FXXv7TAa/NC7eOjIt2NMTViLOAMQ5Pk8vyepOwWG26UJYnW6X7tZ7ONhoFbenp
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 08:06:28.8537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d03ae56-0ff8-41c0-6900-08dc38342ae9
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9294
Received-SPF: pass client-ip=40.107.20.67; envelope-from=esriyag@ericsson.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 28 Feb 2024 07:12:13 -0500
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

Due to company policies, I have changed my mail address. Updating
MAINTAINERS and .mailmap to show my latest mail address.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 88fb68143e..ef1b8a53f4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -100,6 +100,7 @@ Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
 Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
+Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
 Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@weilnetz.de>
 Taylor Simpson <ltaylorsimpson@gmail.com> <tsimpson@quicinc.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 65dfdc9677..0a3294f698 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2474,7 +2474,7 @@ F: tests/qtest/libqos/e1000e.*
 
 igb
 M: Akihiko Odaki <akihiko.odaki@daynix.com>
-R: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
+R: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
 S: Maintained
 F: docs/system/devices/igb.rst
 F: hw/net/igb*
-- 
2.31.1


