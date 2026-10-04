Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D03FCA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDIAQ-0005z9-U9; Sun, 04 Oct 2026 05:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIA5-0005tm-Uy; Sun, 04 Oct 2026 05:05:40 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIA4-0005jn-AY; Sun, 04 Oct 2026 05:05:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMbE+bbg9waK/+aEITKXSJiD2QDHYvKw2LTtwFw2zAa8VHxF5RN0lKqTVR2+tvEXHTixSOWd005SBX5QFg/5dW43TTNPYudFAXULvOjUcUgFhBDwU3gMH1/soYgQMvtkOkF/e9Xuou1mCgBwU2tpP8sJE04RiPEadjPHXIHgJR//c7JSMT39p9in6DsYy+qsyCxvsrKoy6+XyEjck5tpEXwxoHDf+93TXNEASpbfBE9+ZumlD2WCSG1s554F1RfQXgFrwkjNzEgJ47YEYSc8n/fgVGxYZDVXLByI5j+QzvQFi01tgUfotQEv4LM8sjsy6OtTIBZUMeRKYtNISMBahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrXWAiy78PewNP0BJjhnQj6ilxrrKtjBohgL7aQmAtI=;
 b=dbXYT7hOF/TOSQqg20X5IM9mX5ZmPBaos0KsBf51g8nyzaqcp5JQ8KAhmfX1JJKYx0op97gDBwqws8K/iwDtdQw8DjQXQD/nG1jabswaVfXt74x/S87rvuhN16c72mUKinPIdZrHokKxlVNo96IT9Z3+m+jRcDOy0Xcwro4Q6lXs+0aaPJFaw0HaITIAitKV7bqKqIiiBSc47nm9/kAjJWYymfwivmsgXW0QXvx5XG0Mw9DBcHM9auFGMW+xWfKnhGloP6SDhk/fPDmWEwoRT44h8gYui6NMXVcDw6M75x4LUx1U2zuWNzwyiwxEEv9zhgalvcS6ZtktZvCIqjoJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrXWAiy78PewNP0BJjhnQj6ilxrrKtjBohgL7aQmAtI=;
 b=Qgc2JY0KZPsdhsmdSPe+w3kwEvYaFI2l7LCddtyR5nC/kXmOa0xlr1z7MVTvnqL0VNUemhlK7jvTDW+CXN8712wpfk8NACfp34jPQjdlNBlQzl3e5LCcbp5UVtlpfGmofbVm1ZtmTSojrEteBYx/ZkL3Y2KMo4pMi2tum0JmmjzqfDEj0fojR2rqvhjGdD/EDxxwzEw8VI1VJlRirt7S7FxGjObu/FL60AleFesZ1ccOW1hHjWjcyQy1/DuTwuCGjTEKQP/bswUvWLcujJ+dfREC3G5poF30ansHxdv9dxdkbc3gShrrI6yncVi6L6RFqlnwDOORzhhZ+ax8DETQPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYPPR02MB8958.apcprd02.prod.outlook.com (2603:1096:405:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:05:27 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 09:05:27 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
Subject: [PATCH v3 05/10] hw/sd: sdhci: Use a QEMU-local no-busy IRQ quirk bit
Date: Sun,  4 Oct 2026 17:04:50 +0800
Message-ID: <20261004090500.3082641-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004090500.3082641-1-bin.meng@processmission.com>
References: <20261004090500.3082641-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYPPR02MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 08dca235-dec5-4184-44a3-08df21f6a1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mLLCaVZehE7F4LZVfXgM2C/XDpbj+YqPmpf8YJLXOVxZy/mMGds2JvbcNf51B0Mf0nRCBkIWVhB6aWTCpA1O9UtDpzN0fCqkONJR+7ZVgAESOirDwfo+7Cz7/mewBCFHOWrdRkdPZWZgZllS6XDBEE8kqtj6Y7cnM06T1F/h4/Fc4qhlW2Opw221NUv3izkFWLbfsNSrPbe0xL4DNaZyC52Q96oOdpGBvc6zdc2U0Ue0aSy2UCKja37hvHpLSk8cUmYivBzhp8lLaGt8GsuzquSL6PtpI0Sjoz5Y8RGKrTWSfH3vpcwQZyYS4+q4s2oAlpQpCi3x8MvaUOkK98qCHe8ifKnP3Er7WBDZQzB/I09A3WyKjA3L3HcwpsWDe0SOEw5hUKnY37phRRz5Vof+azcYpFOnDbl5hcnwRQTkjKfgTtr5DIjQOUIDrM0l7wNgRBx2mg265m0FLLP1X1o6qsBnKVLzGnJRGLTxS3v1TQ7aJf54wNxeI26G6f5fa/rNOXWB2w2T1dHLqiDDNMHiHO8uro2SsbUDSyD1rie/j09rxa7G/38TymYiMMlVFnUeMeD4/K/xum9gL40wt5P2JDFdsRuv2AstlBnqWcoBf4M5WUKipyUBUb9wrcxQYjIpTCT4JsfGBTs0+GAldonUv+WWOBKmVX82i0xklql+7iA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlZtWnVtT1d0dmdZa1lmcDhoaDJYbXN4aU5ncllaaEtsVGlXZ2lyZDlXRjI1?=
 =?utf-8?B?Q3FmeDdZSENqMnRuaFJkbm9iM3VrNW1iVXNpcU5yNGRRNDR2MDFkQSs1WGJQ?=
 =?utf-8?B?QVg2bW5hZy9ZWVdhS0VxNTEzcEVWQjFsN3l1cjFvSW9nUkZDeFJGL1dGaGlI?=
 =?utf-8?B?UGE4aGU0S0x0SlhrdFFDQzluTi9UajNOdDBRZGZNRHVVTEJNQnBlTHV5dzc2?=
 =?utf-8?B?RDZEOEw1MWdHM3ByU2NheUlxUGpheGlZa24zWUg1ZGRKNHp4bFZHOE1CVFpp?=
 =?utf-8?B?WHVua29Fbkg3Mm9mck9ydUR3b1pUNEhIMzNrYjRyc3FTQkFzYUtndWMzeDQ3?=
 =?utf-8?B?VzRMNHpqdUFRejBXN1RnMUhhY29lZnpiUTFOdTdQZEJ2ZE1PNlFoRkptZjRW?=
 =?utf-8?B?eGhwRzlvcEFiZHRMMHRZdDFNZ24yRXpaUzA5TFhoSXVOcHhqWFREeXgzQ1lx?=
 =?utf-8?B?VDl0Tk93WHMrWjFxNHJkenJvL08rQ0gwaFpZR3ZIQWhQUlhWZHlwVDA2SUJ4?=
 =?utf-8?B?QkpOdjI2REhJZmc5S0h3aVE1bG82ZmxxdVhtQVpaSjA1MmZOUUcrS0hQM1Ju?=
 =?utf-8?B?QlBwMkJTYVhlOTM5U3piYWFzTkFCWUFVOEtOLzhUaVk2NXBlQzJZY3NEaDkv?=
 =?utf-8?B?Rmp2bUtheXpGUng5VTd5bGtVYUsrZFZUSnBuNFJBWjBZTlRDbS9BN0R4eDA2?=
 =?utf-8?B?K2JUYUVtc2N0SmpVSWxmWEFUdEJYTjNMbjBQL2ZDdElnRzhaSkVIZlhMWGY1?=
 =?utf-8?B?Y3ZZS244bFFFc2pXVXhZS0VCTVlLYWh4eXRsUlZLVkNwc1Z2TUVwWEFpb2JX?=
 =?utf-8?B?dHlON21FMmMweHo1UktrTTE3cmJDdWh1NnlZeUNuU1ZJcTRicDNRTldibUxE?=
 =?utf-8?B?MzUwblJPc25FS05yS1RQTzlDTlRnUFJiYW42bUZURk93TzM1Y1BwaVRsdXdO?=
 =?utf-8?B?VUVMMC91MXIvRStxYWhGU0JEY1BxcHB0MENKeHM5cDhyQ2wycFc5eThtZ3JU?=
 =?utf-8?B?VUxrWDIrQmgwQ1UyNlNyOVdhdmRsOFdSNVFtcGQ0endLRklmWG44WnpNS2RK?=
 =?utf-8?B?d2tIYVZGK2xBZ2kzV0N5NHlBUlFSc1oxQ0lWZ05DdWNzSzZ4ckhTZmM2VTJi?=
 =?utf-8?B?Ny9QeXdVeVZoT1NyUS8vbjVoaGY0U0Z1d0dJcUk1MGMwL1plQXZicndMVVdP?=
 =?utf-8?B?OHovMHhCNkIwQmZoY3VtTHVhZlF3WThCUFZUWlNhOVIyK0xtWWU0R1BSazlu?=
 =?utf-8?B?MGd0czlidE41S0RpaGxJdStxMEhQMTdMdURKWTVmeHdwWXVQakJ4REZnaGpL?=
 =?utf-8?B?YlNWSnlBZjFsRFlwNXhrK1FQU2F4SWRwQzBzMlZLemVFdWx6ZHorbHJBd2I0?=
 =?utf-8?B?Q1pwd0tzVjNwVVkrYlltM0g5YzgxT2F6S3BIMGh3ZzVreFFSRGhqWmhYbDBa?=
 =?utf-8?B?Z0pvQTRLS2RQcnl1VjUwdWFYN1o1T0NjeEV2WDY2MGFuUlh3SFpwM1hhVWJD?=
 =?utf-8?B?MXVybVpxYlBlMzhaSXArT2FKei9vY0gxQnJaeDVFSWloZDM5c0l5US9kUkFX?=
 =?utf-8?B?eU5nU1I1WHVCNDZ4WHFhckVwclZHSFVPcTJHSzd0MDlnY09OSXFFS2c4MFYr?=
 =?utf-8?B?ZDhsd0V6dlFrdyt6K0RXd0hIZUJhR1Bhbmo1Z2ROQjJzcWtJQk9MWXNIVWs4?=
 =?utf-8?B?YW01L3NDMEdXVTJRZVR1WDM5WmRvSGh0NmZDamJSSHVtRXRMS2QzZTB4MDNz?=
 =?utf-8?B?WGo5UWRwY2MxbkJYYzBlTFlTREpJVkFOVk42TG00WUxtOTJMbjRNbVVIQ1kz?=
 =?utf-8?B?a3FReGFUay9QME5TOTlMNWIyc1BCYTVvNXFHTEYyUjlBd29KZDVXSE1JRXU1?=
 =?utf-8?B?WUNQUnZXVDAzNjcrK21ieVNIMnNIRkp4QUg0U0VXSHhVcE96a29TWE5RYUNC?=
 =?utf-8?B?MERJWFptMzkySWZONFAxT0NBNzVlL1lBalRHZ1VvSzRaVHpPS2Z0emFJRzl1?=
 =?utf-8?B?K01Mak15MS9zbGxEV295VSt3S0hQdTQvYjY3cHZmY3dmNDVVbjRCWVlWMlcx?=
 =?utf-8?B?Rzc3cnc0bEg4eU5Bbnh6ZlhjT0FIUDdqVWhTMndWdWptTWhRNTZnTkNwam5j?=
 =?utf-8?B?SWQ0VXZUVnZqTEtVcFhQNXNyekV4b1VaZ2xoaVdZZHZWZWZkb3BBVFpLRHMw?=
 =?utf-8?B?V0liQzVJdjgzVjdhRnhMeDErT3h6Mi9YbUxuZSt5ZEttS1A2NmVqNll4bDRL?=
 =?utf-8?B?TlAzcVJ6TVNVVURFaVZwbFNKeUJ4U0pBbVpOT2xpeVlhZ0RZYW8xb3hRbVJY?=
 =?utf-8?B?Uml6YmZtaktYWFVtZHQ5anRKUWVESDhweFl2TnR4UFhnbWU3T3Zvdk43dk4v?=
 =?utf-8?Q?3oecpYax+35indnY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dca235-dec5-4184-44a3-08df21f6a1e1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:05:27.3144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rhkX3Mf447N/whbhAbc+aBduOX6DPoGOcC5t/ZSWduCl/4dTm64hGF1AE7aqbG23+xH54zwVkvyrJKjm5zQOemgdazwCffSuVBX3lhQ014=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8958
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SDHCI_QUIRK_NO_BUSY_IRQ was copied from Linux with its bit number
unchanged. The quirk mask is internal to QEMU: it is neither visible
to guests nor part of migration state. Mirroring Linux therefore
provides no compatibility benefit and constrains local allocations.

Move it to bit zero so QEMU can allocate SDHCI quirks sequentially in
its own namespace.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>

---

Changes in v3:
- Align the quirk definition before adding another bit

 include/hw/sd/sdhci.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index c485277744..c5297310f6 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -111,11 +111,8 @@ typedef struct SDHCIState SDHCIState;
 /*
  * Controller does not provide transfer-complete interrupt when not
  * busy.
- *
- * NOTE: This definition is taken out of Linux kernel and so the
- * original bit number is preserved
  */
-#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
+#define SDHCI_QUIRK_NO_BUSY_IRQ          BIT(0)
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
-- 
2.53.0


