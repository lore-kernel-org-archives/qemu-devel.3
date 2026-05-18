Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0020CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0eG-0004RH-Ev; Mon, 18 May 2026 12:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torbjorn.svensson@foss.st.com>)
 id 1wP0do-0004Dg-5D; Mon, 18 May 2026 12:16:28 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torbjorn.svensson@foss.st.com>)
 id 1wP0dl-0004Zw-E8; Mon, 18 May 2026 12:16:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOxkDjleAEDvwHxLFkDW4/wNLUFAiz8zIUVWa62iAVYc/B2PkEOkCu067/tX4vWEyWBztknCjnfenSi5uk6smk91TByLjcxlJe+iaLL4X6XKRjXP61uUDRVld4oi++0ZBAXoI9v31ME85uqHdMcELlGld/AWylX4VXkIEWeTwb2l+GxkTxlVcjs4/RARqATNXhbrsfZghQc51WoCnq7PkNUfbIfVBsDP3oX+FDsowy8aXZDdjfbPoCldiRexNDm+a3vGv+cz4rzMfo/NjVsZGxUxLY6i3F3nme8/r33VnBu0A2Vu21Eqpd/L8vn56GDtFp7Lm4DL6Iscjh5rHjYMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnA4pwPmqntp25zqHStgWSjzEtUaTpNECcNVBqMnLVk=;
 b=UL1dh06+3voDHf9AMDOAEBXi5tWmwlXTjUX47i1xT1hdM7gv6ElTUSUQP2Y8RBh4+Naf4MxzozxURitwTfjm3bWuO7iY9AG5tQ8rOmOg9p1cFYC3+OcIMkMozw+I98vIaimiRsSkn4WehO8xTFT3fsAgsHeZxOZ1hg5BOrEJSMXqAGTuJNQcUbUD7dsDgpkn5Pspi/bhqm4YxbPwn+63TY1aWJt/4dqgRD9OCuP2GuEu47dmQ2fWvs1eRRPZEC9FJ3yql7cLw6RbCkuvep5xzNMBH2i4ZoA3i9BgVpBD4gY+qnYkDJm6bUQI1Mg+he49XSqPPeKWFCWMjldo917Z8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=nongnu.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnA4pwPmqntp25zqHStgWSjzEtUaTpNECcNVBqMnLVk=;
 b=a4mUGj+DAqKG3CQ2SRFXlbvjtAdGWDl8yyGqZ7G9Yc5X7OKtsz61r8P18HPxk2hj+DE3JxNOeOcBy1a7XuhPA5CMJEI9/4W7dAS4ODZe27E9ql9NiNIqtdOUQuW5mEhXusJPN3cyE6Qpl3mkxzKaur6CBFa/EvMPr6m6ZxtnC2KU4zJoGevgC+JEUGPeEn4JuBKLRtsdC6GP0LfAI9MLohldBsq/aBfrB7kmh8Ajsxhuo84gPrR00M52nEJXhEGosmF7sXhjYev9Y2Jup15VTKDstAAOZ0LCvMVPdDtvs83QTwOhP8wdexftGvJrEUHkkUamB6KyOv+Hjrr/8CN/jw==
Received: from AS4P190CA0038.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::17)
 by AM7PR10MB3349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:16:17 +0000
Received: from AM2PEPF0001C712.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::4f) by AS4P190CA0038.outlook.office365.com
 (2603:10a6:20b:5d1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 16:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C712.mail.protection.outlook.com (10.167.16.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 16:16:17 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 18 May
 2026 18:19:45 +0200
Received: from jkgcxl0012.jkg.st.com (10.74.22.122) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 18 May
 2026 18:16:16 +0200
From: =?utf-8?q?Torbj=C3=B6rn_SVENSSON?= <torbjorn.svensson@foss.st.com>
Subject: [PATCH 0/3] target/arm: add support for Cortex-M pointer
 authentication code
Date: Mon, 18 May 2026 18:13:58 +0200
Message-ID: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMY6C2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0ML3YIi3YLE5KSSTF1jM7MUcyAz1TApVQmovqAoNS2zAmxWdGxtLQB
 09ZNZWwAAAA==
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>,
 =?utf-8?q?Torbj=C3=B6rn_SVENSSON?= <torbjorn.svensson@foss.st.com>
X-Mailer: b4 0.13.0
X-Originating-IP: [10.74.22.122]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C712:EE_|AM7PR10MB3349:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f26be71-de81-4d32-df06-08deb4f8ca53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|42112799006|1800799024|82310400026|3023799003|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: HmeBEQrceqoKrNv/WhQbQWpL/DubSl7fXSFKPglgI1MJxmTuO+gthTqzK2Rj+TO4sY4a1zn/nF9PP7y0ZnvvurL43OVPcPT9Bol2z0e0wkG9agwdZXwnUEhh1ycLK5MB7UYSaWHN/qJALCDC3qcyAZpy9eKL9hj/NTqiaZJRhKcvNavtRt2WQ7V940GsxNPrKxNUpbiV/dgUA4xMTS8ZnvBhpeR9mCyb/FJzY3Vi9le51426oQAjWVuaVSqPq1EAfgWY7BG8WiHILVUYh93jcWjT0kNZE6B2leQnEF4eGNqZjiWERKWVumB4g2IMTxfPcDJncoEgtsw1mESTXNYxG7YUg6l0xkaa2YIZGJyhwGKcX+23BYeTxMayc163CqyGAGvCTLsd12QXcV56vyQZJcsoINjIspOW9sUdWiYXo77gNJX7y3n56bCQ3wPy5xXrr1MIhSd2cKnsp04jL28SPTd2HLnNE+RuZmdUkRifvhniPXucxk9TSuIVD26I/tf5LIhWMNtA0x9mz7we/7vB0Tl2Ncn88++vS6tEkngGB/S1T/CfIxvzqVRBt971PvYj+0oyXzSzH9zlC8btvLet4J4Q9xgyJ3iYMOVsVRTPYU8fiMBFDvZWu3EuhFQNZ4b4kInNH9NEZ/8vrOtTLG3vqQjebHHuP8KAcC5mq3402bYG/jeiDHjTjGG3EqYvxnyPF67LVznH0mMpokv0Zw+lysqsjdsIEI1fMJFeIZ3O54o=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(42112799006)(1800799024)(82310400026)(3023799003)(11063799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LIYV6TBZS7YijiSceDIH45hGaPPGX+O4km1BqciXEVmobHO+MbrGGygfJd+wUMGitgmQPjN1Rq608OkYoj0dfVjU7aG5uhPYCQkG3R/qYpHn8wAD2zQ5X7X1y0TCU5csj/D8yRDu4wCsOf5WSlWps/VBZDWtcbHve01NcOE3rHoM3O5cHmx7nBewBgMgFiDQS7DdyOvhm/aaD7/nFZtwYS0aaZ8lpEv4kuVh0D72w1Y5PMR21K64B5ceJyMfs3Uysi2m3uH55b4htLLuLZVz1AOfg57XOnyGq/OlQIqFZbppVslKv8YWHOvZC1hkkRoUyzY3T9nIsQ8rgYQvJDrBvKDSlr6yWDBqKqDsk84dxfEj5OtEN+6VDBFszpCFla9Gs8IWn/AYvTZHU6dokm1VBffDRJH7+guLnu0RHFFwdjzVE5EIe15LOSemVQttiQ20
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:16:17.1601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f26be71-de81-4d32-df06-08deb4f8ca53
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3349
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=torbjorn.svensson@foss.st.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

Testing an arm-none-eabi GCC toolchain using QEMU gives unpredictable
test results for some test cases. In the GCC testsuite function
check_effective_target_arm_pacbti_hw, the testsuite tries to identify
if the target supports PACBTI instructions. The test consists of:

        __attribute__ ((naked)) int
        main (void)
        {
          asm ("pac r12, lr, sp");
          asm ("mov r0, #0");
          asm ("autg r12, lr, sp");
          asm ("bx lr");
        }

Running the above code in QEMU will cause LR to get corrupted.
The reson for the corruption is that AUTG overlaps with the SMMLA
instruction, and SMMLA will write the result to Rn, that for 
`AUTG R12, LR, SP` happens to match `LR`.

The solution to the above problem is to define the following new
Cortex-M instructions in QEMU:

* AUT
* AUTG
* BXAUT
* PAC
* PACBTI
* PACG

This patch series only implements the pointer authentication code part
of PACBTI. The branch target identification part is not implemented.

Signed-off-by: Torbjörn SVENSSON <torbjorn.svensson@foss.st.com>
---
Torbjörn SVENSSON (3):
      target/arm/tcg: define cortex-m85 cpu
      target/arm/tcg: add PAC related instructions
      target/arm: implement v8.1-m PAC support

 target/arm/cpu-features.h  |   6 ++
 target/arm/internals.h     |   2 +
 target/arm/tcg/cpu-v7m.c   |  40 +++++++++++++
 target/arm/tcg/m_helper.c  |  17 ++++++
 target/arm/tcg/t32.decode  |  21 ++++++-
 target/arm/tcg/translate.c | 138 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 221 insertions(+), 3 deletions(-)
---
base-commit: ac6721b88df944ade0048822b2b74210f543d656
change-id: 20260518-pr-pacbti-366d7acbe1be

Best regards,
-- 
Torbjörn SVENSSON <torbjorn.svensson@foss.st.com>


