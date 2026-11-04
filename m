Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726A606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=L9el1IU4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeLx-0001R0-TG; Wed, 04 Nov 2026 12:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeLA-0001An-EG; Wed, 04 Nov 2026 12:00:01 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeL8-0002Ut-Jx; Wed, 04 Nov 2026 12:00:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOaLmRTAvCqum3tYz5IQ01U7Fze5jvOjE4bIBeWoZo10FUIzOZK2ecAyvL3ROaIgEUPbHo0GEekVrsxjr04PHoUU3dyCpYaTWWywioXw2dFIprEjfiP5sXeZzyArQQXojo90AyKa9SVpePjx7nbC+rLiL3R7NcH5ApJt7N9NOuCOHfDP88i0llDUnZsbtBxdnrxA0vqbCtQ4+MQ9c7zI6jIzQMXbGxypNNGjd3lYpj5FCsyd21nsAr6ONkISWAqSj66l4D/L0DCFAG1msRP0Xm7Hjl2WyoF+vABuCKYrdWJ29oKt68o/3n2cfiStkp18BbzSoHq/jKLTDoZmIgna6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZXG9JJPchRBDcPVVXrtJUQaZF3CJ/gZfCRUoL5ygsY=;
 b=fFTNDduiflJtJ1Ro66XDG08AgoQ+Qk6LcsoRP2cpdUnDzrLz/IDswE0uxTUuexOG+Xc+Poc+RWR0BWd50oH+U89CWxAkaiYVl7Nb7cwGHfmjbJRQ0uJpuwyx1xOPuejclUQC6FIaK46L87uzBz1VaT+hrKqJOLsmZWj4bMTHwrA4uXDEM5ZqCLOFOyafcbssSEeD6jC4f1MrVx2J4FCG5WXcw6PTD+GhiPOQ7bWDRdl5IpGtzUzB6J2+RZB6j/Z/+Uf3r97XN+atN0Uk2FEbAP6VySUNMQMcYtUsx2BLQwc0Gpw6Qx/QfznsMAp2a15rJYffXN8vgAE9Fo4bfyXkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZXG9JJPchRBDcPVVXrtJUQaZF3CJ/gZfCRUoL5ygsY=;
 b=L9el1IU4F7SodVtVoWrtjb/zfwfr4DJXQvTKvUSfhp+lnnCMQO6WAfGaI3eiGMPq7lwOPIMH3IxjAPQd3az+MJWE1OAQHj7qoRXDYfi4h8qluMS7ppnOsCTxFAiB/nnmqhAfvXLpp0HwogSmvDMrz51/WCFGxAvVGZez8Cpss6Av1arZrWuj8gd9VFejX5ad53QFDJEx03/QYpOxf9PbvGlwVlpAeGHIvAjOF3K8n0Z5gX6zn/llOQZHxrUEUPFzIK6pWF4OeVxUh96t/liqjZyXhuBrbpwqTXpShUXFVD2JvxmPJoTsQl72PxZj5OSmtRAmh3efLM+BezkQ4xsDXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB7533.apcprd02.prod.outlook.com (2603:1096:101:1d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 16:59:52 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:59:52 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
Subject: [PATCH v5 05/10] hw/sd: sdhci: Use a QEMU-local no-busy IRQ quirk bit
Date: Thu,  5 Nov 2026 00:59:17 +0800
Message-ID: <20261104165927.678833-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104165927.678833-1-bin.meng@processmission.com>
References: <20261104165927.678833-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEYPR02MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: e249fd02-19e6-428f-8331-08df3a950a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261021123027099003|56012099006|261028144727099003|261009223027099003|261021121427099003|261026140227099003|261026121527099003|261022105027099003|10067099003|18002099003|261102123227099003|22082099003;
X-Microsoft-Antispam-Message-Info: 61tiSN05kMrPDVE15EGgJZK8Twm7eCu+rg4W6QKmjU67KsFuc5SvdRn3bzlG298TMupQbn/p3F+jrONC7YCYRXQk2IIA9YI+M/JDlVYeC72oOv4AtG77MmJavynQsRN8ZAWdIMLu+65xc1ikZn0IrrBKcNxyMMnrcF0ofKSgLJLLUnu5v4xzdo8Q8z6gFkwF6sN0WhToSGmFplZv8QOK1zw5Q8Jyy5dp2xCdr04gcpjCmvM8yX05QtKS7JbA7Fva6Ta85wzcsKUoifwQaU4GDXUCeWSz2X5PEOBGCRZD2MM0Ech30DUCgC581AuOVTQpqPGvm59BnuS7ToMLKVvg5VlC5jQFNKWwyUASlbYaNdSMQ1FigBWfiXX6eMOp3qxoR2bKfx3orZ34Ih0e3mYEmWudDvsB2T21L2Qx7XH4KQ6UOGnHwuow+3zfT+Glt5omFKGzk+HK91Vqz0nU3F/B8nGY1zWFCsEEpC3BY3PU5uMGBFjkIeQtlVe0kTPyU0NSmE6oZnrce8LSk9NrAqcRH2QKea3DdU1P2QriZy6aIlO+967U3sgVAAp8fJatacmr2E9BaJXTI0aNJs/pPFYXeH/1AtrYwluO1hY3i6ZQQg94HEkFWiccyhA1Y7xNjDC5PpRpcZ/tEIA9T/UhF9g/KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261021123027099003)(56012099006)(261028144727099003)(261009223027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022105027099003)(10067099003)(18002099003)(261102123227099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWE2ODB5UkFGYXIvNVdSV3ovQ0JCRzNadWIyTHNvOGtGUFBndzZpZGM0bEdj?=
 =?utf-8?B?RTlORFREQUhESy9NQTI3anhtdWY0MHZlWU10d1R4ME41bHJNQm1yT2RBSjRr?=
 =?utf-8?B?UFN1T2FaaFpuUzRqd0E2a01Wd0pSMGNTc3BmSmc1MVdJQTM5VnQ3Q1pRMjJk?=
 =?utf-8?B?eEp6UlhLcXNUM05wcy8xSVZVVlZNMlZLMTE2S1hkbmNIc212ZGVwME1VUndo?=
 =?utf-8?B?dDV1SFJ4S1psWk16bHg5T0x1UjFHN3Y0RU12QVA2NnY5S3p5amtUZ2MyR1Yx?=
 =?utf-8?B?WVFPcXdUQlFaaDVLelIwZERKd0tsaXdOMDVnYzIxNFo1ek0raWwrVE15OEts?=
 =?utf-8?B?SEVNQklFWHlkckpEdldad1hnbVR0NEVYSDdBby9TTy8yUnNFVm1VakxpdFFP?=
 =?utf-8?B?NkxDQjJMelErajBrVDhXR25odUdNQUV6SlF1Ty82SGE2K0x2OUE3VjlrS1pr?=
 =?utf-8?B?WGhCTFFpbUVUdFkxTlFFdk1NMU9vU3lDTGt4RDMzQmRGQitkdVdsNlJOVlly?=
 =?utf-8?B?clBrajNuYWJsU1o1N0NCcVhINmc5d3dnZVVud3lYWWNqNHV2bk9jY3Z5QzNH?=
 =?utf-8?B?Q1ZpN1FCTURsMWpnOXBzZElNbzF3N0dPSUVPSXVXWVY2bTJOVVY2RzdScFVv?=
 =?utf-8?B?cVFWYnoweWt5WVo2UU5EbVc1ajdxOSsyS0FXVzNzVnorclJGNGxqWHFvYVNx?=
 =?utf-8?B?bzJ5bWp1L2V4YUp2b2FlT1ZrYlc0aDZZVEZaNVdOWWZGeHAwQ3NuUDlFckwv?=
 =?utf-8?B?OWVHQUhrMFFycjhEOWxnY09rWmV4Mzh6L01yalBlRENpcjFkZEJwZ3JMN28x?=
 =?utf-8?B?Mnd0NUJIamRGc09POExPRVEwTUYwWmx0Rnhvb1pIVFJPMU9hNExyUlRFWUt3?=
 =?utf-8?B?bk40SE4zSFJDc1R5aldmQys0a1FKMldJU3ZPZVVaaHROSHNFWWpWN1FvVWpC?=
 =?utf-8?B?dWQyRGZ0cE82bm93V05XQmdKSXYzSEh1V3kzTkgvVVBPemowc2lrVmJPdHRi?=
 =?utf-8?B?d3VWWExmRm03cFMvNG5NRXUrSEY3QVZ5SHFzeUkwdlZ4MUpodkZ6bEdmUkVp?=
 =?utf-8?B?V0FiYUlKdjZKMTVpeFNYNUs5a2pkSkx2QzRvZjNoRzVkSG1tQW1xL1I5bXh0?=
 =?utf-8?B?VTFNd2hNa3pKZWdaclJ2VXZESVE4bTQ3MFd5aGVFRTBkMGZ1SE1nYXhZZ3hW?=
 =?utf-8?B?V2ZjWm02bmsreUxSWC9WQ2w5eTZGTDAzYVptOE02MlU3bWxsQjlmaU5TYnpo?=
 =?utf-8?B?OFhyRm9ZN2U1aVgyVlkxOXQ2ZmZwc2hJS2FWOGFoaGNWZHFhbUZvcmttTSsy?=
 =?utf-8?B?bXFRSUlBajV6SG1RS0ZhcXIzVG96T3BDWW9CclllTHdKZExJNGxwbjJDc0hW?=
 =?utf-8?B?WjVoTzIzVjdFa2ZRb3VRR2NmbUJ5RlpFN1g4N2E4RnlIa1U4aDRGM1kxR2Rz?=
 =?utf-8?B?eHhOU01PVlEyN3g5aVhIWmoyQzVxRXlNNEJCZjRTR2FVZUFwZ1E0dEYyR3oy?=
 =?utf-8?B?RjN1aHhDZitYSXBaU2RMVG83MmxONVJuQzFaSEJSWGdrMGZmaCtOblE5cEM5?=
 =?utf-8?B?YUp5bnIvUW1OakhpN1dSekhsUkZNUGY5S2ZxVGZCVTRXTU01NTRqSTdxblZk?=
 =?utf-8?B?bk9xbVZDalRuZEwxWFhiU1hoUFdOYWhwT0dkc1JSaXh3azFEOFlNRWUzcGY2?=
 =?utf-8?B?eDZ2dHFDUys0Y0FNcURDME9heDBEd1JpOENhRVpwUlR6YXpFVDA0Y0dwR3dR?=
 =?utf-8?B?TEs4Si9xYzVaYUlsVUp1dVBzM0xmYWZIenZmamhYeDdmSHh4ZDBTbE1lNzg3?=
 =?utf-8?B?aGdJNDRndTdpZkVhS0g0Vk5QS1QyNnZyWnk5QjVmZFRMZ2ZIaVQwejZ1S3ZU?=
 =?utf-8?B?RjlsSmV0Nmw1ejV1WGxGc0dSaFF1WGhXVzJYb1VnVXp2djVIcXhRbldkOERT?=
 =?utf-8?B?U2FsZlZqbk1ZaWk5Q1docnNpeEcxZ3BCU0t6aFZ5ZDlxTjdiYXREMmJ3V2Zr?=
 =?utf-8?B?dFltbVJsUkcvcjhNeE5QS2x2djA2Ym1leUo2RXhuMk5YdTR4d3p3RDNNWjFa?=
 =?utf-8?B?YmpUaWtKQ1NuTEdpOCtZNDZMN0U3NndHNTJtR0tSK2t1bjRvNW1ZaUloMFdS?=
 =?utf-8?B?RTJzTFowaUs1VDY3QVJtUGdLNW1RTEtrS29UTDlkTWtwNG1ma0tNaFloSXVi?=
 =?utf-8?B?SzJOVDVIVHNKZHlYZlo0eGkvUUxqUFk3akd3blQwSTllQzhqYTdRZHQxOGpz?=
 =?utf-8?B?OVhuYS9ULzhyZTZKVUM5U1ZvQkFiU3ZRS0xSUHF6RWg5Zjl3ZWZaaUNZWU9U?=
 =?utf-8?B?R0pMcDBmQllkVmFZZVorUUNrUUtPRjlDbjVSVXZ0YnJyVEdoTVVPTEtTUTh5?=
 =?utf-8?Q?ibdBLAl0YokIFwJ8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e249fd02-19e6-428f-8331-08df3a950a90
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:59:51.2728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4YoB/zJb5ds1p6DlZ2aW3cSG5wJmJv7eo7ItAupTFCvkZjWU9j7b8jdzx43FFzC/dJh3mqhpG/sy3bEyXrXSxbvknrJeveEoXeaDmhgB0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7533
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

(no changes since v3)

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


