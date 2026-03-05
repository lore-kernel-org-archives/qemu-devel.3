Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0CFF30931
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy675-00075M-7B; Thu, 05 Mar 2026 05:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vy673-000758-TT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:39:25 -0500
Received: from mail-westus3azon11022123.outbound.protection.outlook.com
 ([40.107.209.123] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vy672-0003XR-L9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:39:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNnstre3UjxDmu5z8brb6plC05EkJlvoSXjCSzFeypvQEfofevq260c8JJMXexUWtc/LfdnMMz92DOKI/oDYZrPdgw5TQw/D5iMNvRLp8U4s8s+tuzRtNByXq4uapC8RNEtwOSkCgKfdXWR+7RCn//cm0ZI9Ow4I9bbY6uny4tZPhfvzi2eEP97bPKgbNSEGV2ELi+uHgh26aArXSdsvq990nnUE4RBGzij2Ubzwfe/Qb/107/UclKP5mlaVEXUqCSYd9PFwYSOa7bAunWLhq70xLqpavKX0gTUpY61A6R+ZoYGbIXQ99qHkB2k5ZZvMxTRxbny/7DE8UhfEd5TjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=581N8fzFzDe0sAeHlnLRUCLp0qCNHs1ZymVA2xtt/aY=;
 b=hJ3wAwdJ1+ry7bAn5TsfssOrkAcjY5q9v3WiP43FQIkPr8vxUuHIKEUaxRwLOo52s13xUMrh1lYVrDp61MG7dQ8uMyR7w44X1wKzXCwSlJakgVGkFjZncOQQe2owW3X6w6XcDqg+XyKxVmk46HtyxrbJ5v7Jim2BQfcBFvbTPBV6ASCOLWKkRIJsbbc+wb33ifdZJxytlvK4gPR9aeU6ByBlcILtkO4KAUSdRZFqhkWRvAiDFAVJGFHI1hIesMBq0m9y5iH/3SzepxBO4cg6epqMEu6/bFHBEYd6GtQldq4aHYIqqr3ZAkJliLC1/iuI3R6rF/QELU28a6NIb8eENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=581N8fzFzDe0sAeHlnLRUCLp0qCNHs1ZymVA2xtt/aY=;
 b=hE/7i+JwwcI2U8V0BXUtugf2jZvE3EK9zvconAXpPVaUemb3GQDo/1URKAuobJQ3/fQGz7bSXuiQHJA83HFE5cC6zc768AftYndSVe31EX43E2T0pb/RutmXS1BQrsuDfpB4rdQ8SJnIH1k1CLWW3lFNUv7JNQ5Z/0nn+c0vXb9/nHuUPzepwNjFXUbgSWh8yHHGQaAQx/eehDoN0g+q5If7LdQ08cMUIA7GeHfK5C2kSBxbPCKQ5/r6Em7ZnwR1hpDJDgWPIC9JKrj6W81PXHyv4ocpaR1p3ht6Ihf5u7b8fw9DlPDQvV1TYW4H7Deti2iEfMmuazDXljTJL3GWKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by BY1PR18MB6111.namprd18.prod.outlook.com (2603:10b6:a03:4b4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:34:19 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 10:34:19 +0000
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v1 0/1] Add new model for Cadence GPIO controller
Date: Thu,  5 Mar 2026 02:33:59 -0800
Message-Id: <20260305103400.1574217-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::9) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|BY1PR18MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f481dfe-fedc-4306-96d2-08de7aa2c1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: yl9tpBoTKi9espca2mH43oyzxDG4ewY64Z0CLu/CdHpBLUS7KMNJhExwL7KyFCFHj9GiA1hTFuZZD27Dp5o92LWuV5A1GYKYw6a5ndOrMe7sLLICPhPudXMs0+gTuVbK0uZ9bz7PiV9G3CK8ciY1/fP5cFTPoXxNNItAXIoJO5WZM3KiIavJ8G9zxzC7Z/TqB7hIuQEvzSCVVigSeTSPgqs1lknaPxULTNHSZD+0OAclzYgBCbC5ugxkT8lzTCBFDcvvYIPjtJx6jda3/I5D2oBBUoZ/1ib18YBzPqm+ijGTlgeHheSGbELJJlbIYgESNw3tdc3FYKU6bOCk9mfaM7v7DGI2BUrsi+ynOXjPPPLGbTMdcE2dEQwMSWQklCVt7py5pFKUY6pBdCzeEsu/MYMB+bWs6q3cd3xHsVlQXrQbsEKqdG6tY/Dl82Fc027m2OApp0Huf65mIzagcPg+BtEgsLE/tvcySekxORTrnXAWRdyaM14Xq8vJ7ZbCj6nA7hsatGeXRmxjxkDBRBWHjGxA1m7P+HX5BVUGgiGm83+hroWvbhKh4nQJohm75zoBVtxbjH2jmmS10MqxChzw/b/xOfYfyuCZc7v+aRgrs4R9rpvk/YO5eD9H/lp/Rh+YImbOawMFGqecaUHnmKx059MieTsnQcP35ENuRlC0QItTW9yA4C0KX0iWumliNNp7L8x+bz/J2YkmqmrL2mufirIWGeD90RpiNVUHE7z5hk5Gy4Gu32h/dsxQxymVUDDCAlRHVju/nAALvHvGO/EBHJB2uMrIup9E0vr1Qe9hTD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UzJg2djXJcVAH56AtzpyTBTrQzfzfnvx6gJB1TYjoJIl7LxbzYaaJ+A5y1Xj?=
 =?us-ascii?Q?MCeXc0Vd7nDZWAcac00CIQ5bIYda5sLFPwUE9D3PcWW+NhzyHSFG4h6G5Gxf?=
 =?us-ascii?Q?gT4EV3rPDPIuMPy3H75q4FiH1WennvuD4DwbNhjtryjDTm8K5qAafqaMZ9bB?=
 =?us-ascii?Q?kmlyxpaPspo6CQjl8QRY6M3Zy3Iq5rPlJ086iz5RMLcW+xr+XMjM9f6b/I5g?=
 =?us-ascii?Q?/OhRzUjUsn23OY2rsfnK03Xvah0/znwEohll3ab2lKH0ADijoo+2/NxtNZ8d?=
 =?us-ascii?Q?3e6917JqhoeqOPRlMKE5ocjVsEb3/pO/UqhJd82dgvrOP6ivfdbN5fg1pZ1U?=
 =?us-ascii?Q?xhjhtWzmwKuNn3CR0adE8cBhC9yGfhX13KtKp70NygUQ+xjynCcLm5o9cMmN?=
 =?us-ascii?Q?S4NW+s1KWZ87TAeTj8PHsMwcu6aW2I4GTJPb7O6C0sZFougxdP+ljw3g3wAm?=
 =?us-ascii?Q?E6koQpHiI0bQ32T+Y1mmg6sIgdA3EFGbP+2YGZrJV8AeUoB08pdNxkWtIYEU?=
 =?us-ascii?Q?Zpr/gEQPL0OIXDbtcfVuTJv7zdY2dIUWPdhOCjOCcatl06tDcWerhTK6O9CC?=
 =?us-ascii?Q?RVcYRCXjihlNV9/E5QzU8OxsbPYJcfX808Ye8Jcy5shMu+nc/eSmTAoPH4fO?=
 =?us-ascii?Q?yiVHwhP/7z7jSw5p7nnI+w3MKQ6qyppal7KekTIGlCI3grfFKjqCybjR7Jif?=
 =?us-ascii?Q?yqzHESayJiLOdtoFbtAXFrUp/WMNTQwb27PHNQojlZZwL99gT/AzMlNgl0qg?=
 =?us-ascii?Q?JFHtHvTkdeUNk6t2NX5mljlvmltVkdwgd8GENVIrBfL9G66HY0PiO6OF9YD+?=
 =?us-ascii?Q?/imBz7VHIgo3Qf+OrmsYdZHv/iTngzQmzVo4eqrdjfrwXBx8xa1thLv0nbIL?=
 =?us-ascii?Q?BWysCgQpcHq/5Qh5ZNXnWuVfSf/4pUifOXhgPsGiQylrHPRjO63EUmr56t6/?=
 =?us-ascii?Q?itvAglWz8PvBJjIaEpmGu+K8BIIt/RdX+qqLW1i9I1gpxjPdQWHUOL+dCcJZ?=
 =?us-ascii?Q?yVeEFQ5uuOCOo7e8u/3Q/4ZIZFqePV/tagNmHzgDmiXUlVZ4A846kAI531+r?=
 =?us-ascii?Q?11ya16ZCFZvuOAHBJFTmvkhyGbgFGw+1C8iGiHyKuzmrixo83HxTjYASACpc?=
 =?us-ascii?Q?rd5gfUShGFY6vNgOd1q5xxwkA5s9U02vysvo68rnYmSjfbEkLj1FIRsUfuZ3?=
 =?us-ascii?Q?AIi3k1pSHdgfrahbwaF8jmruqMDX10Y15iCX/3/Dq3I8VjcsOCi28XvjnYc/?=
 =?us-ascii?Q?tp0aTaBbxcW/vdtD2epn9qSziN0VIOuc+eelhzrYWFqg4wYLimxWQiybMep2?=
 =?us-ascii?Q?+HAOMK2+gvfZdCDKmWQ5mchqKgN56ukoI4M2kaWyTf5IK2jVY63Kn8AscPg6?=
 =?us-ascii?Q?YxSERvgLJhi4jrturq0e4K8PBxap7DMBOEYfQBd5ICEaOI8bH6CYqovq1P/u?=
 =?us-ascii?Q?a3oPudFkfAMcjaOfac3vXDfLY/DdAIXs09vHgkquu2W018I0zcEbMx9RYBrT?=
 =?us-ascii?Q?TA1rbTeJg53ZNj1OcDWpgehsJTBdsVvJNtiHjxXTlNA761cYhjAadA/QIsPB?=
 =?us-ascii?Q?NobChtiQkjqMZVY3WPinKfihWBU/VoldI7VuQvv0upp9beuph4RotMQwKnTs?=
 =?us-ascii?Q?gR7E5tQU4G/ucINOnum/KggM6xPrvyonws/xeschceGE/cYXrcukKqA+XX13?=
 =?us-ascii?Q?CmrWgnmVJR5qg2SVF4y61AqS2bgnB17zOyNLJlkvkBPonwZZw0wF+Dvkd63T?=
 =?us-ascii?Q?Idoz7IhZUw=3D=3D?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f481dfe-fedc-4306-96d2-08de7aa2c1fd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:34:19.4469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wa1LHYf6ZADL5/FskOXFpnmxqnibdxMBaaXqu27PexbycSO2tAdD3xIEquH9+Fx2iNucIReKhxkmjj4AVwaCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB6111
Received-SPF: pass client-ip=40.107.209.123; envelope-from=kchiu@axiado.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

This patch seriers add a new model for Cadence GPIO controller which
supports 32 pins and interrupts for level-triggered/edge-triggered type on
input pins.

Also define new trace functions for analysis purpose and new configuration to
enable this model.

Kuan-Jui Chiu (1):
  hw/gpio: Add Cadence GPIO model

 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 312 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 include/hw/gpio/cadence_gpio.h |  66 +++++++
 5 files changed, 387 insertions(+)
 create mode 100644 hw/gpio/cadence_gpio.c
 create mode 100644 include/hw/gpio/cadence_gpio.h

-- 
2.34.1


