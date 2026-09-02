Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F38C624D5
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i7H-0001IC-RD; Wed, 02 Sep 2026 06:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i7B-000131-LN; Wed, 02 Sep 2026 06:22:46 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i79-0006ig-VR; Wed, 02 Sep 2026 06:22:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SE3DIUSsw0d4XnYey0AqHXAVmA+OuDAbZJCbm0wXU0INHN024uripjGvbSVAtq3iPCbL3QJgCye/N23UrxXF6L2ckjikv5dw+WYhsZSvO4riHiabli7TX4dIvIlUHsvMHuOashj/MuvcJgPiTAOhV0oGwFm+aMjTxiJgp8CyGRJKkElbpYaQg+uNzRyhO2hFDI+7Nh25Pot9OrjYcH2WQjxMDiDozwc6nr/imuxaU3ciIYbo2tNysTqPWTBqHRIAzRsE328GYwlguHOaDi7Te0yS0GQ9L7cvZhyHDcjYONtGQnI2q1eW7d1U1l07XzChI2OHKsDy+BQL8MXLt+tCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSkBbC6n7ucuTwJwHCHPMcJYIzG2om3MUS9qW59ZBV8=;
 b=oh1DYn2MC0e8lndJH4vyF5um8EgXOvbFOuH76sch67tcDGNl9o1vwR4ssy18rfNlnba5AOCbaTideMOT0rcRBbK4s5sOBIvc6SJBQjK5aI15yhft3n5DOZRiBt4fsN10QcB2ZB9EadJl2i3d/yiZe0zfJU7VnF3Swg+QTYhvf4dNRTA5DtzOrBRbYqRdbNM7k1ym/WioVG1Uja2uwaj6OC2IQMiy+Bqed31INr2MDkmyAtEPCtYgPPchBpRLLBTz87D2w92aTQswp76irmjC79Y8jC5+jHTk3yxzkJvJSoHOQO/zbFAKy2s3DFduI71PQfMP7n2OneS7EV9SjLInSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSkBbC6n7ucuTwJwHCHPMcJYIzG2om3MUS9qW59ZBV8=;
 b=MvmIFuKWif17lZZawAgpucifMXiYk5YHYUh6vTJkLqukXGPduJBHnRg2GaMUhk+0ii96PpqfV6N2EglYqCxuNAzdgV9XLLF0/apAEnap1SDN9T8CBQlYmBolaIsTuA+PL1ssTpgnty+MowbFCosFlD7viNn54xNR4SF1fIhmZtT/ydocDhsNQmftrInZFU2+93KdvVHqJP0sDnbt6fov3pF3n4DA3JyVeXMfHY1Plo9BbdVs3qz48HvMbBJ2ChcUQoqdftCUDQu1YSelSJQLyGUMMBX/6cJcs40nKsq8BKCksDOuAv7cDizCSuqPitlHpul9Jj0It6chMgmZr8Ox7w==
Received: from BY3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:254::8)
 by DS0PR18MB5521.namprd18.prod.outlook.com (2603:10b6:8:164::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:32 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::80) by BY3PR05CA0003.outlook.office365.com
 (2603:10b6:a03:254::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 10:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:22:32 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 292C74186B53;
 Wed,  2 Sep 2026 03:22:32 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 03/13] hw/arm/ax3000-soc: Enable BXRS support of CADENCE
 UART
Date: Wed,  2 Sep 2026 03:22:30 -0700
Message-Id: <20260902102230.3039251-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|DS0PR18MB5521:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0ebd96f1-530c-4c9f-a88e-08df08dc1994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: U0+fa1mTGzDrF5IeqsDeNhMJR023B4EaEvi8NKdu/5Tzb0rnOzgsv35T5efVeUlQvrsd9nfOXGIVwAHbFHKNJnzAriw3nuji+aJS8uoeA/jfBg/y84GEDMkyaKFKoB8AKaglww8r70/WUvTm3bhVF1vBtuv24I/fWtuTU9pKmAhOXYJE10fSP8P1N30qTs70ADhN5u7TAglajwQd3i5AD7i55MWFewZ5+7c7F9l+TkwTBSGmzimE+fpy+SQaoO5b0KFCUKFwvwSssbO8mc5MqTtodHPzzi2twQzxQpSnwD4Byd4rvFBSF+8ewUj/MeFsatTUSHA5HgVwxpNfXljUFFP9aop54JP1hzLwdtd+v8b3N8yvmmGDE+netyqcsAnpXWt9k+29bViLPo/VaoDqh1/0z8zX8AlE3LhVjAr3BransT79SMyloPgDYKJqeQr1ilviyP51zE6T5c2rgoX1nZ2DJ7XBAlz3rOrFRYtPDln8HlsbQD7VemFc/3LEcTLfbiOIlB2dWVLLh1OiqENzlCuurgjVycAprTKeFwTHz0+65/cGVm1MaMTu39CmCnOy4cuqHtAAt69c7CuuDVJpXgbD6UZ3v3jVfNjSIhZCO1ixN1bTOTkqpxVzmyOsXSQOGzUSjX3U8S5hExqsY+dG5dMfpoxX6NJ1E/NeWSlXLLAk11PcMon6a3ax6cnKLm94yqr100GbW751PcERpLfSgQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(3023799007)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RgJG03ffWvpntisf9cA5SD/PWpG/uxUkVeMtnFJ2pOWjvdZB30lVEJc+2si+2DGblf6u8TrpFRJqd0UkrVqHCNl+yb1vyyh8JoUsDrlsZIyuu9SwKPTPftnldHgDizmxYEK/rxOKzi/I30cfSVdhilTV6ivMlPjwqXGeWvhrXDOe0IdicYttKAn3Y2ERI/dAz2B6FCBNXtl3Qi1aNLCtgsChUWKivhDIzOMbhIaKnq368FwWGfyZL1J5H+zAyZrMn/W3vbZw/KkiR6IwYdbzcSH1ExAasJK72ixiDIib7y3fX7WaPjHX1x9T1TF+HlMSi7uFhexjPbSeAsdWFlwxVNKm2X6Y5yxADuKSWRpJqZqPWoPgPv6RX1qBaf3nGy7eQSGsXQIN/5+Z/9TpKYxjVNLy3svlz4E+v3cS9TkXwr8KwrW//9dzzT5YqNPgjZS/
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:32.4445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebd96f1-530c-4c9f-a88e-08df08dc1994
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5521
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=kchiu@axiado.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In order to access BXRS (RX FIFO Byte Status) register at runtime, set
property brk-support of CADENCE UART to true

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/ax3000-soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index ebe174fb97..7b96466860 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -155,6 +155,7 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
 
     for (int i = 0; i < AX3000_NUM_UARTS; i++) {
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
+        qdev_prop_set_bit(DEVICE(&s->uart[i]), "brk-support", true);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
-- 
2.34.1


