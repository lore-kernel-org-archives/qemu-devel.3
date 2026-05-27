Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98684CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 07:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS8od-0005k3-4X; Wed, 27 May 2026 03:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torbjorn.svensson@foss.st.com>)
 id 1wS8oa-0005jN-Rw; Wed, 27 May 2026 03:36:33 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torbjorn.svensson@foss.st.com>)
 id 1wS8oY-0002FA-JW; Wed, 27 May 2026 03:36:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbFZFca6DFvEgH1q7mpBmomnBCbD+T1AGOVXcKI1HGvCuihlcIitDW0aLyK1bJ3ZNQaILZCqegO3JyGyQqVpaLNlAzFFqSnLZqnQzBZ02fqlFz6M4C8RzkggdcAq6n0Wdgtj18bkgq5VulnaIrOXWzJtQPGvaFDLS0+//j1hFDXRGDGuYUgn+Aeqol21HGskKTxLCf3HgBoVnKikBjo0MxQ9gh5Mr0ytjP87te7vDNiYFz4ih58eqUUEfBbJ/knBD/tXYbnGV/l5GJY0DRqXyoEqJDpe0vEv6Ma+3YpYWW6c97hy/zmfAcF7VZnYSGZ0kpSuYm4t0DiZp9ux4/bSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEeee33uDgRYZeNg/1MSULfJjZrqEgh9/ez4XPenLZc=;
 b=rgv+7/vcjPlZ81fDfX/PkvC9iQKypB5YsDzmIL8Jc1y95ML4i/9zcMS+Ndvgw5jN0uh80E5OIw2oDHHUxG9PI7XEcZBRLVWEmr6InzAH5kM7b8BbZasBJ2CkNqgztDob1gaT/p3RQYLeuvVTJbvFjPBBUkxw7Op7rwteL7DCgjo2eBXFJb1gJ6O8I8trHOzNaRKXfzzJ+7U6n34FGOkbDNib6inl6eRMyqEECCVCdNsdHYPI0pL6xAtVzgEZyGvzAY9qMOjEfIh4FiwafhxGPs+tCmQfq8RMa9IsFe9tk0YFcfeqGrC28bw+rVr3JMyZ0CdLX4zl72ZWKllpyWPwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=nongnu.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEeee33uDgRYZeNg/1MSULfJjZrqEgh9/ez4XPenLZc=;
 b=LGkIDJAd4D6Bx/tqRCMjFkKuDAAYn4ZtiHGVAM+XK4Fvc1VS7qnnm/IlsT7FjItRCsbTDNFqoUj/fR5HIFvFdF4EjGgle8EQc7ksDlCL+MscOJvZJb7AIUZc2A2iUiIaoyZ/Xmui8Lxt/Wi2JxV3fubRJaBMLeIT+leWVB1+DOQZqB1X+ar2faO5eqlQK/LHNE8Z7jTCrTIOoQBjoL/2ETML8xi3IblcbwUuvNOXv+2AXDuJIEgp/4kxZTyINnVGOi1cOULf9RKxXVrR4/evOGcykGWA8qvu+n6VD1mHveKY2uomkVWxMYuESCzgc8TcdoQQrAMwcLv9WF6XtnJQhQ==
Received: from DU2P251CA0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::25)
 by DU0PR10MB6319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 07:36:22 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::3b) by DU2P251CA0010.outlook.office365.com
 (2603:10a6:10:230::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 07:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 27 May 2026 07:36:20 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 27 May
 2026 09:40:01 +0200
Received: from [10.74.16.102] (10.74.16.102) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 27 May
 2026 09:36:04 +0200
Message-ID: <b50cb0e2-5198-460c-abee-ba86c7002a96@foss.st.com>
Date: Wed, 27 May 2026 09:36:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PING] [PATCH 0/3] target/arm: add support for Cortex-M pointer
 authentication code
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
References: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
From: Torbjorn SVENSSON <torbjorn.svensson@foss.st.com>
Content-Language: en-US
In-Reply-To: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.16.102]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FF:EE_|DU0PR10MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 448416c5-74e2-4ef3-71be-08debbc2a580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|13003099007|11063799006|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: inVJZRrjqF7AI/h1i1jyejlLREiMAm1V+ZBztTjqioeg6sCwEAGQ7TzJMe4RdEFwHc1iu8jDfPKS+uR3d775PbpgK/1ME91hY6MzW4r2hw68SmGAWwvBc4NfKa363Mph1iC/+hOsKWmpXGsH+wvRWbvvncmxv/3h5x74MQDlHS/RJrochcpf+y60rw1roy1M6wFC0g7sWW6Epg3xMR7wLb6oHLWVLVloWXtWvf6TRx6eoHJvr7aFiSs5pDL+HEhyfeiBw3IVSAlEwwRHL+Cei4N/KKGmZvapZCv2CoQO4Mna/j/lDoTr0185vDiyBWOIsoAwRBODCEEaLJlHDdUQfuyixEKIQpRmP3rrXwRb7b1jn69ZGGZA1zcjuPsllJirMXe0AQNE/pizc76bTDAR5BJ0OAxAAI5tfeT2I5zSic3V0IlfKk+zFi9BDS8ojnApEquyJe3/PolENkqBnCbDCVRNuZZMA6mZ6tr8pD3vOYyyaHMpbGq57CiZIZdbkQcOFHiAjY8D3PfNbTkutob5WsbNLd3I3f0vkaeAGUTeBswyRBmK/RU8zm0lQG+L7V05vk9InikmNRkFruNeCIHxdCNllIwSl0KjX2Y01uyzlXhu2CF+BrktoKvixr4r2057+qObHmxuijXeSjP9T3YdgADPTus9ezbSo00WqpJbOBoMQMNIHVPv8YyX+XrjrcbYqvXPm5KRpSR+FSD+vAVk66EtH179wgvWMoZ+9x9b5NA=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(13003099007)(11063799006)(22082099003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UUjteYeZa0qCv9WYOSufCRogcKKoAbLkgJGBqN518rSW+zuKbO/AHhbOJAQCq1diERGImeIJ+WKGJBqdcDACMv1kJyKlYKrYDR1CQILOz2xZNajSyEJWTEEpCLz3qP1Xl8SFphJFdNpx56hLtWwVFYlGYVYe/3wWWaeGsTeO/7hOmLgPwxA3NGoYswW5GNYbd7FnZYamvxi6dq9tof3UA1uu4SMS5gP5lyJOKXY3WXoXAA51RkIYKQouQhyGM2cr2uOrwV6bFeCLWXvJH0c13Oi8LzdfTb08cs4Ef1VfNiGns37NzrboxQ0DnJ50iY8MVoG7DKpJwPYyVUahQ0lnaHLv1hD6u0fwbkRsktqKLiCbo3OGkNeryZXQ4khBIxxjlnDa7hTuYeGqsMHkQ4XHDCZwBxuKMfLnQBmWstJvDswUw4i9HB9rStX4JSz1HuN2
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 07:36:20.6798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 448416c5-74e2-4ef3-71be-08debbc2a580
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6319
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=torbjorn.svensson@foss.st.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Gentle ping! :)

There is apparently also a ticket for this work (that I did not see before I sent the patches): https://linaro.atlassian.net/browse/QEMU-444


On 2026-05-18 18:13, Torbjörn SVENSSON wrote:
> Testing an arm-none-eabi GCC toolchain using QEMU gives unpredictable
> test results for some test cases. In the GCC testsuite function
> check_effective_target_arm_pacbti_hw, the testsuite tries to identify
> if the target supports PACBTI instructions. The test consists of:
> 
>          __attribute__ ((naked)) int
>          main (void)
>          {
>            asm ("pac r12, lr, sp");
>            asm ("mov r0, #0");
>            asm ("autg r12, lr, sp");
>            asm ("bx lr");
>          }
> 
> Running the above code in QEMU will cause LR to get corrupted.
> The reson for the corruption is that AUTG overlaps with the SMMLA
> instruction, and SMMLA will write the result to Rn, that for
> `AUTG R12, LR, SP` happens to match `LR`.

The above statement is not entirely true.
SMMLA is writing the result to Rd and that happens to match PC, not Rn and LR.
Sorry for the confusion this might have caused.

Kind regards,
Torbjörn

> The solution to the above problem is to define the following new
> Cortex-M instructions in QEMU:
> 
> * AUT
> * AUTG
> * BXAUT
> * PAC
> * PACBTI
> * PACG
> 
> This patch series only implements the pointer authentication code part
> of PACBTI. The branch target identification part is not implemented.
> 
> Signed-off-by: Torbjörn SVENSSON <torbjorn.svensson@foss.st.com>
> ---
> Torbjörn SVENSSON (3):
>        target/arm/tcg: define cortex-m85 cpu
>        target/arm/tcg: add PAC related instructions
>        target/arm: implement v8.1-m PAC support
> 
>   target/arm/cpu-features.h  |   6 ++
>   target/arm/internals.h     |   2 +
>   target/arm/tcg/cpu-v7m.c   |  40 +++++++++++++
>   target/arm/tcg/m_helper.c  |  17 ++++++
>   target/arm/tcg/t32.decode  |  21 ++++++-
>   target/arm/tcg/translate.c | 138 +++++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 221 insertions(+), 3 deletions(-)
> ---
> base-commit: ac6721b88df944ade0048822b2b74210f543d656
> change-id: 20260518-pr-pacbti-366d7acbe1be
> 
> Best regards,


