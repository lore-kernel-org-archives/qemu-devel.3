Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1FECCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 07:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHGZp-0002UW-Oq; Fri, 07 Nov 2025 02:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vHGZn-0002U6-7z
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 02:08:03 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vHGZk-0004Zn-ME
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 02:08:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGGWHqn7IubixMwgmHZWgJlxOFnsmpfDLGCBupA/YnsapVBKsJnAsurCTwkKuSwefyl0x1CETcdRIIhHQGVkTTFUBG0qmIDQtzWujA42OpgrTCgyRY95NxbquoXuB8GZ+RYDWjEdM6tmzrsYoYyBrlBR+IeOOBsO/kPH9SxrOaP192Jetk4bxILHVx9brV9raokSCUSPR02E0XlY2ztp3MFilYAIv+HGmzZEfvH1fhALv0B6wbRuYQPiZJeANdnf/D1n85M6yiTSUNBmJ+lwZL1glqBECCScZXJDFsPxQUmUH4pe7uRIyPdQqFj2czvgl5uaT5CDL0WAyDalkm0XHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LbcDYTjUknl0AMDZyMBAxIu/jX84GqlrQLck9tfUwo=;
 b=j8rXfnbXsqf45aUtbTU+uiAaNhm+sLRn3Xv/V69Z6wnEOIAtJoCNwTrDsHksdgepBJPqpfCUoXfDUnKdQ/f7te/Bmg1itWyjntYDR7HvsI6qNzpJJnADPiMDDvsOdRv5fnrcOpl9fp21CqLj5fyKWWHXHCmMRBSHCGaT2VtPxZWxUCogMZxwEMqwgvWqzsXELb1FQwd/m3Udkt536Wg+FbMYSQqvfO+Z1XYlGEPXZuh8iKcF00SjdXgmiqhEz66ZFN28ng3HTzB4Yi0OXyh8/W4FDlmKexgYbYxnHKpuzT5NbKUpAQfwuF6bi5UPV6Hgz9G0VDaeFUkCDHz1Oyd0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LbcDYTjUknl0AMDZyMBAxIu/jX84GqlrQLck9tfUwo=;
 b=dcAY2mRpswHgY0QN2u/lVGRIkuQn4WLyIE2vUcpDMs8Rqfu8WeNnqneo82CvKR60H/UqZMILlBGKsN3iBGLN10X2G5bxOAzz7yAVV3MjrL2DvJE/gjYXwl/jMOFWPGDE39nhlm1y/vwNyDgYktlCJS/9o1vv35rEdP4uhSrcABt8/v/8XMcwPLWrE0UW064yCyuy0v3EWjFYC+GESP6eYqjYLmyPKjomvXmpNiy5Raxcpcm5R10hb0Mdykc8id8iEpvGUQyWFFiiozIVo/+haExv1vKsAaPb6hbRaFVkK1AgAXWmSRHoUsnnxPywGRlTRE8u6v0oM0ihg7PefwcHIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by TY2PPFBE94497F1.apcprd06.prod.outlook.com (2603:1096:408::7a5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 07:07:50 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9275.013; Fri, 7 Nov 2025
 07:07:50 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: eperezma@redhat.com,
	mst@redhat.com,
	qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	angus.chen@jaguarmicro.com,
	wafer@jaguarmicro.com
Subject: [PATCH v3] vdpa: fix vhost-vdpa suspended state not be shared
Date: Fri,  7 Nov 2025 15:07:23 +0800
Message-Id: <20251107070723.7491-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1P15301CA0048.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::36) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|TY2PPFBE94497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 6095ec74-fc34-4a27-e4bc-08de1dcc5cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXVDci9XNEt1cUFUa3ViK1AzcUN6ODZtaElBZkFxQTNOQnBpUWkzbHppZXhP?=
 =?utf-8?B?YTZ3RElFUVlUblJsZGx2OGhzMEV4SU9RLzhzOGdZQnRvdEh0NjFsUHk2NE93?=
 =?utf-8?B?SzhoV2M2aWovdkRxTERIZVd3bUpIc3hGZ25oSllMWDdkVEVkd05VNWZ2TGNS?=
 =?utf-8?B?bXY4RS9YRnBERDF0bWhZODZIWVNQTVBBdGgycVFzcGxmVDF2UmtGTm9UMDc2?=
 =?utf-8?B?VUx6dU1JN09LQkRrNk1pWkY2MDc5Mm4yYzE0SG5xeVBzaTBZVFRUVlR3ODZq?=
 =?utf-8?B?WTRUekdRYUlqM1hBUkd4b093VlRIdlpFK1cxMStXRnFHQU5KVEhJcG9WNGFq?=
 =?utf-8?B?Z2ZWRTNrdXZUZHhaMU9wV3dhTm1xWW4veTRzckZBODlWNXpvejdyRlZTZjhi?=
 =?utf-8?B?T0Z2bHhTME0wZHlzV1NzLzRJK1RFbEhCWU5DTkF6dGZyWWIwOEIvL3ozMHIy?=
 =?utf-8?B?bDR1cXQzWWorR3ZFc3NCb2FLcEk4V3gzb0lKR09UQ3F1bkJDNk5MUllwTFVl?=
 =?utf-8?B?SFpFUmRudG1QUmgvZEZnZHNGUHhicEVoL2ZOSm9kMkRadGFGc3JNclljd05i?=
 =?utf-8?B?WnZUQWNpTkZHSktVNmU4MGk2ZFdYMWNNaVc3c28yTEN2aDYyYlcrQThldE9P?=
 =?utf-8?B?RXpqUkFRazNCS3VGV2VVNWd3Zm5lUHJMc2Z5b0NFOStuVlhXTkZMT3JpUmsr?=
 =?utf-8?B?eFJTVmpiQ3dFcmhOcytlNjVKRUxmblhmZ1NxWFgyQlFvQmFuTlF2QWtMNTZS?=
 =?utf-8?B?ZVRZVUxBV29ERlc2QUF0N21wQWxpMUpzS1YwL3pYMHJXRDgwR3BnS1JGV25D?=
 =?utf-8?B?MFY3UzZlSkhwTXhUciszdHBTc2xxd1pGczk0TWRuL1hpakwwN1BDVC9FU0Jq?=
 =?utf-8?B?bzkzRVlmeGRpWlNvc2NIWjZhL0NYcG1UYW1VYXh6azBZMi9OSk5JZW9hbklw?=
 =?utf-8?B?Q1dGMUxtaVpuRzBBMG5POFF5S1kvMWVKYTRHeERROE9OcGNyYUUveUg2ckRP?=
 =?utf-8?B?ZGNhczFPL0ErTm1SeUtYbG1pUUxFbXlmNkhacXFGWXYrU1gzbm5qWlA5SmVP?=
 =?utf-8?B?L042Q2NHVHF5VUtST1FSWkIwQkVvKzRqejRjQzJUTjVydFl2aGxUd25PYVIv?=
 =?utf-8?B?YUZJemJKRm8yQUZ1K1BOVXEwR2x6MWY4MlJqVHQ0UW1IbGVPdUxPclVUYlRi?=
 =?utf-8?B?b1RZUldvc1loV0YrSEMxcGVjZXFvK2ZBMlRYVC84NzVESmUxY0NuZHZwVXVi?=
 =?utf-8?B?cDZGYUpTTWJsa2hkSmRZbkpqc2w2b3ZTcU9ONkNKUjJLME9Fc1kvelZURzYz?=
 =?utf-8?B?dEZiYVF2MlFXTmc0T003cnE1YjJ2L3cxZHZMa1R2L0R5U1V3dEJvUEIyUitm?=
 =?utf-8?B?WTB5ODhORFp5VWR1ZnJJdkZOSFVwOWYrV2VOaGVXNWU0c0h5NWZjcDh3NDJI?=
 =?utf-8?B?Uk9iTGltRHJtblA3blRsOHJxUkg3Z3RsenNpM2N2MTMzdTBwa3lDUnhyQitO?=
 =?utf-8?B?dHVSY1cxckFvTG14TGNZUEN0NVhSUEVOTThuSzFYb3ZYZHI2Qm5OSzBXOGdB?=
 =?utf-8?B?a1pqTjJTLzIvNHFJUGt5MDR1TW42alJuMWxISXp4VVYzSlBRVzhiUGFYSmky?=
 =?utf-8?B?V2krd09oYVU5eG5nRFB5VDVmVHlIU3VVN3RNc3VvUHZ2bVFhMFBUbmx3R1py?=
 =?utf-8?B?eDNiZnFyUDV3SXIxMlVKRmswaVpCVjRwK001bG9ZZ29wNlhiNW4xQUVFU3ht?=
 =?utf-8?B?T3kyNlJGc25Vc1FQUC9mMFllY0xmbDZ4a1U3Y04zNFpKSTlJTnRheGhlUFRU?=
 =?utf-8?B?QXl4RWcrUG4zblBieUVrYjNMVlNNY0EyNWhOVHRMbXp0WFZKeSs4QTlqZkVZ?=
 =?utf-8?B?enVJazJ3U1UxWHJXUTFCVGJ6Vi9JblRsS01MZk1vWFZoZkFnZXUxNDJQSnlm?=
 =?utf-8?B?aHRHR2hPcWdITng1andwdk1IVVZ4aUFpVkVzUlNURUM4RlZHcEMrUHJ2OGY5?=
 =?utf-8?B?K0lUekRHL3VXUm5CS2xiV3VWeEt4ZDVHcUFHT0dCT1FTUWhsKzFsRVVXR1Bp?=
 =?utf-8?Q?qPek04?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZTblhoZ3hxL3FkYjdNcmljZ0VvcHJrdDhPa0tGRzRhZkdzcFFVY2VIRHpT?=
 =?utf-8?B?bkhqYW1NRkVLUk5PaXBZbS9ORG5EVlBGcjY3NE5ScVMzMENNUFh0ckZ6QnJm?=
 =?utf-8?B?SFdJaFpmN1FKTDE5QUt5akt2NmZzNk5kcndaSm9iNHlNL3B2bmxPSFV1bzVQ?=
 =?utf-8?B?MmFuci9sTDhzdGVLdk81SVJ6Z0d1bjNibXgzTWhLWVpUSlNhK1F3K2RLUzJx?=
 =?utf-8?B?T2czYTNwSlZDcWc0UW5SU21GZnBiZ3pXZDBEZnNLQUhGVnFteithcmNTU0Qw?=
 =?utf-8?B?TXpaTEdtRzlaS3dodjZ1WUhrODdIN3VnNVJ0NmdLdzFaWk9GZytZdUkrbjVH?=
 =?utf-8?B?cjZxYi9BWWNvTzJNcDIwVjdYQXd0ekIxT2lKSlhuWk9OUkJEYk1ITFQvQUo2?=
 =?utf-8?B?SzhkSm5jYWUvL1V3QU5yZE5WT3Z1aDdiVVFsQVNLSVJSODZCUGgwZE5BbThZ?=
 =?utf-8?B?aXJKSnBKbWpPd1QySDc2aFN0eXA3Tmo4T1VSQlViZmJUS1o1Um8wc0NGL0NB?=
 =?utf-8?B?bE5abGJiTlRFeDlqdWNOYkp4K3lnRnRSb1hrdFJ5My9KNytkMjF4R1FURkdT?=
 =?utf-8?B?TW1NQnZNaDJSUG5PTWtob0taOTljZ3RaQnRDOVIrUkM1UU8vUmR0OTB1VkxR?=
 =?utf-8?B?b29PZWE1N0RVbUkrdDY3TFNzRXo2M3M2bVdWSTkraDhPWGJoM2lHN0paaFBJ?=
 =?utf-8?B?VTczcXlWdjM4NnFJSzFLZDdnYzVEUnJEbmRGak1uWHA0dk14R0hJclhXZ05u?=
 =?utf-8?B?Y2xTMlRMeWRwRVJjTDNXTFUxUTNUcDdFTGZPVUExYVJSVkxRamZQYmYxSUtK?=
 =?utf-8?B?ZVJUNFdnbUV6aGNDSWpoWGlvU2FQdUtrVmVYVysxVGU3TXpoYzVRS0Z5ME5M?=
 =?utf-8?B?YzE4VkdHV2RQVHFNZ2xtOVdsVE55M010QnY2SWVNZHRKYmZTMVpubmJ3Q2dI?=
 =?utf-8?B?MlNOTkhvTW43M1lXek1ZSHFpclJra0dVNENOZkJrVkZSTjV6QUFSYytBRWlL?=
 =?utf-8?B?QmtLYWZmREFEZ05lQ0ZCaUtmYTZHS1doNy9rbEg5VGZ3MENzcndZbXpYejFx?=
 =?utf-8?B?SXlyTTU3TmtMRmZxV2k1M3B3emlKalViOXVuNEc4MmI3NjMyZjc1R3VKQ1Va?=
 =?utf-8?B?cDB0UStiNVJnOHo0SCtQRHI4cGl0SXUwZE5XTWVZK0JJVVpOTHdPVE5mcUtI?=
 =?utf-8?B?OG1yczVhaUxmOWlOMStuTWI2VkI3MXdnbUE4V0FCTXhjRytQbzE3bzE3Q3Jp?=
 =?utf-8?B?RlpSUlJuOTBCMHBZUXMxeENLQnkvalM3RjlDcGlXaDRTN3RMY1VkRmJjS1cv?=
 =?utf-8?B?dm9HV2ZEMjF2cnlVaEFvNU43Q3VsVTVEQk1BVGVibndCREcxRlBEaVFzU0lK?=
 =?utf-8?B?dGVTK282L2hhL0Zvbk9acy9KMEVUYVM2SXByVTR3WENNL2s5WFBya0V1TFBX?=
 =?utf-8?B?V1AvR0R0cWZuRUZiWnZ5YTlSNHF2MytoVi94ZDFkQmZreGFwcHp2SW02UWtm?=
 =?utf-8?B?S1NLQjhhaWdLNUdPTlZzUTBTVThLaWhvZm9pTHk1RGwwWHN2TTYvTnViMmNa?=
 =?utf-8?B?OGxyaGxZWXpZUFJ2bFZnSXduZFhnSEVxUkgwVUJzczJaa2t5MlVHZXZzKzhz?=
 =?utf-8?B?QU9YWGdQSWJIeHd3MHdmTC9TR2NTM05qdGFhbjJEOTAvMk1qS3Q0Ukk4Q2My?=
 =?utf-8?B?ZkZsSG9BL2VzZWxnWGplWG9UMEFlV09mdGoxZXFUMVNtY0MrUmEyek5kSzVt?=
 =?utf-8?B?dFBidUprREVha1hGRUEzNVBJZk9oL3pVRmFMSmZUN2NFUExRekl2S2tEK0hr?=
 =?utf-8?B?Y2d3Snp4Z2orYmJJL0tjVkpQT0pJRXZlY0VzMWd1SGZhSVJJZ3JkMkdBY3FS?=
 =?utf-8?B?N2gyRFR5c25VUDZmalBFdnI3SkM0QTQyV3NTeVFkU0o4SmJlVUo1ZkNXSmtN?=
 =?utf-8?B?M1U1SGZtTFI1Q1VLOFVvNjFueUpCTklsMGhHRENpVFBjOUoya29Ca0FLczVr?=
 =?utf-8?B?VnZDc3ZYNnY5b0NWRVdTVGZwTXZIK3hveU14b3Z1SUVNZTBrcjlVWnQ3OEgz?=
 =?utf-8?B?bzlnWDlPMmk2c2F5WmxFb0FJekdLVjRnall6U1Y0SFBTVTZrUmgzeHZOSitL?=
 =?utf-8?Q?PbfBtl3FCxPMhBmQ+HlPaj8wl?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6095ec74-fc34-4a27-e4bc-08de1dcc5cd2
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 07:07:50.2805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4J6zmvjFyU4GDDbr1P8vG4Oxpmm35wa+4yChA1lBxCjBwcIU7Pp2p7MJ0W73lEGQZ782WRKnHAr0GmKDoQAqew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFBE94497F1
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=wafer@jaguarmicro.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

When stopping a vhost-vdpa device, only the first queue pair is marked as suspended,
while the remaining queues are not updated to the suspended state.
As a result, when stopping a multi-queue vhost-vdpa device,
the following error message will be printed.

qemu-system-x86_64:vhost VQ 2 ring restore failed: -1: Operation not permitted (1)

qemu-system-x86_64:vhost VQ 3 ring restore failed: -1: Operation not permitted (1)

So move v->suspended to v->shared, and then all the vhost_vdpa devices cannot
have different suspended states.

Fixes: 0bb302a9960a ("vdpa: add vhost_vdpa_suspend")

Suggested-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>

--
Changes in v3:
 -Update comments and add Acked-by

Changes in v2:
 -Move v->suspended to v->shared
--
---
 hw/virtio/vhost-vdpa.c         | 6 +++---
 include/hw/virtio/vhost-vdpa.h | 8 ++++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7061b6e1a3..2f8f11df86 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -905,7 +905,7 @@ static int vhost_vdpa_reset_device(struct vhost_dev *dev)
 
     memory_listener_unregister(&v->shared->listener);
     v->shared->listener_registered = false;
-    v->suspended = false;
+    v->shared->suspended = false;
     return 0;
 }
 
@@ -1354,7 +1354,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *dev)
         if (unlikely(r)) {
             error_report("Cannot suspend: %s(%d)", g_strerror(errno), errno);
         } else {
-            v->suspended = true;
+            v->shared->suspended = true;
             return;
         }
     }
@@ -1481,7 +1481,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
         return 0;
     }
 
-    if (!v->suspended) {
+    if (!v->shared->suspended) {
         /*
          * Cannot trust in value returned by device, let vhost recover used
          * idx from guest.
diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 449bf5c840..80ff670e23 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -76,6 +76,12 @@ typedef struct vhost_vdpa_shared {
 
     /* SVQ switching is in progress, or already completed? */
     SVQTransitionState svq_switching;
+
+    /*
+     * Device suspended successfully.
+     * The vhost_vdpa devices cannot have different suspended states.
+     */
+    bool suspended;
 } VhostVDPAShared;
 
 typedef struct vhost_vdpa {
@@ -83,8 +89,6 @@ typedef struct vhost_vdpa {
     uint32_t address_space_id;
     uint64_t acked_features;
     bool shadow_vqs_enabled;
-    /* Device suspended successfully */
-    bool suspended;
     VhostVDPAShared *shared;
     GPtrArray *shadow_vqs;
     const VhostShadowVirtqueueOps *shadow_vq_ops;
-- 
2.34.1


