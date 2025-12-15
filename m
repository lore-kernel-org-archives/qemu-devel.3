Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33403D59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 08:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3WQ-00011w-Bz; Mon, 15 Dec 2025 03:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vV3WN-00010f-CR
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 03:01:32 -0500
Received: from mail-japaneastazon11022136.outbound.protection.outlook.com
 ([52.101.126.136] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vV3WJ-0004tn-V2
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 03:01:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFOIjAM4piHoLkmhERje5qX0X4ve2IiAI1HMU48DY+DqWxhHLR3ItlJYwfxf//jfcgTAXWL7/pR8lVl4vv8UgegMS24n+vcZ3hX49eDPiIesH95OgJDRaCp4Y+gFF3mcuZjgAvZ+T2qEsk0e3aiajHRMubgbHJV1YZj5PLOMm79z0p/Avq95AKlM46z/0DK0PybWGB9FX6SPn+zpdOodFZ0Uva0IbXsO+QN9qjaC78nOVleGCvYJYSaRz3Sl3x/7T7wDVp+f9nNrlNKY/goYM9VFTto7fvXGkzXm5ukwoSVHYh40CqkdjA6s959gRSZSbhGnNVhSGiGR3e5oY/7cqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAskNrgcp0QsxyRwGIG3eoUyt0v1EbH7uq0nIbrqgtU=;
 b=D5cSnT7tVVnP5V/b9mejCEeQ8glrun9EtsPmVzhT/Ov4cXA3WhV20SvKP1StF1yu7ilhi+CqAg+1cYPjImTWR0I3PToVNfnnvvVIOaNelET7zJQOHRh294QWJ3e21intD1drsGA9RqGieGzJjKBcVl+ebC12+KFLJHqR3qqeR4GbclB1Utle6OUcbv6kR7umHHsUYShIIEv6t4R3YwayL/ANBNdUDj6cfqlAafW6vqPGh7oA5aR/HJ6oN1ntqb6SxICnPJXNLvSSynf8/++JInCnw5z2Os0VQNi/HCGyi8OTDbRw6T+I2s5YGJNrADtnPySPY4vehj8+HiCVbGPJ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAskNrgcp0QsxyRwGIG3eoUyt0v1EbH7uq0nIbrqgtU=;
 b=G5YS5jj2RbPfzarbPa8o7elwelL4q/yRfIryejxEIetiJM9A8VBGajTHg/0MXdEPNznnHZnw8nJRTyd4JEwtHiS0fIe2AjesWGSZdX9syRX7TqL7eXDoZMTuGnPp6t2m+FcCV05MRsf3rhDYJfuEuy7kXufsNkaQDPnWVY0gByPHzKPgLvC+PFMZ8teA6EYDAl/JPIUGXBhLPa2ygqfB6x2fwaMGNnUu8iekIN6d1e37IpsxyyfjTsXZ0aTXZ94Vo5pfwW+jznA7mpS7oHYtdiu/rChN73YYmpeLujUq2c+aj6IIyydT4EQyanu7CaNS8hyNXUbVouNwijol85He7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by SE1PPF215029121.apcprd06.prod.outlook.com (2603:1096:108:1::40e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Mon, 15 Dec
 2025 07:56:19 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 07:56:15 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v2 0/4] Add Split indirect descriptors for SVQ
Date: Mon, 15 Dec 2025 15:56:00 +0800
Message-Id: <20251215075600.2184-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:820::27) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|SE1PPF215029121:EE_
X-MS-Office365-Filtering-Correlation-Id: 130bbf00-ef79-4885-83d3-08de3baf6c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?My9RR3RtcG53R3lKTE5DVWN4c2JYUEdlS0J4VEJFK3dQaGJFOXJsZ2hTdW5x?=
 =?utf-8?B?ZzFidVFUbGVqOEZzT3dEQkk4N2FpU2FmMk9QN1lUV0Z0d2cwbkc2STFWZExP?=
 =?utf-8?B?cENJYzlGQWhoRGVCZksxbFRsSkYrNEdHTWUyYWozTzhBR2hqSk5sSDJoL3dX?=
 =?utf-8?B?WmZvc1V2ZXRWTjNOYmxJbGEvSy8xUkJDRGpSdUFKSHZOU2h2NDRlQTRrTG5H?=
 =?utf-8?B?L0h1b25idDV3K1dxdFNLSEFHOHBETmZHQVJhWlVGU2NZbXZkSmY3cFEyV1M4?=
 =?utf-8?B?SFQvUDBsY2pXeDEzaVBKNkNFYUpobElIUEhCOWxzTGs3ZzZNa0JOTU1oUlYz?=
 =?utf-8?B?SjJPdmszQnNZZGwzSWtBSDY1TTluZzU4cjZWTTV3Vm9zWm5nZnNNc285cjRw?=
 =?utf-8?B?NUhyMTAxRW9FY0VwMytxUk4xbWtIS0g3MTBhYVh4WE9OSUZPSWc3alo2SmE0?=
 =?utf-8?B?bkVnRXhlakh1Sml4MlhrbWhxUWhvd1YxWjdBZk1DZU42ODBrT0swTExoVkZH?=
 =?utf-8?B?OWZWdzlvcDVkVVozTmQ5QkFkcXlpUGxDdXZCaENGNG5NTUh1Smt5TUpRRUc1?=
 =?utf-8?B?cEhnLzBHNnJFcllTc3podXlvS1pqa01KbFdhRU9OeStETTNYbDRJTEpaLzh3?=
 =?utf-8?B?NVlDUzlVMGsyb1MveHd6U3hERnVJRTgvcDJ3TE50d1dyNFQ0ODUyNUZXNlNH?=
 =?utf-8?B?S3c3ckZFUm1EMjJTUXlia2VCV3kySGRWamxDc3VCdFVVSWdSaFJwV1dUQWgr?=
 =?utf-8?B?eFpCU0pHeW01QnY2bUFJM1J5SC9vMHdiOUxGbUFLeEhETm52SHVCR0JQTGdk?=
 =?utf-8?B?aUt2YUVHWXBXNDJQVmFYRXlucXk5cnYzdUN2ZW9YQkJ3NGhZYkMwbDZNQzEv?=
 =?utf-8?B?Y0E3SkFKZ3hQT3JaQ1FoeUUxQlZ3MW1EeGlZTkZRZEpRaEI5MjBaMUt2cjE3?=
 =?utf-8?B?eFJ0RGFjUU80Tk5yWG1sTDRncE43NEM2NVY2WXNTNlcyaVRZOWxJY2Y1eGVY?=
 =?utf-8?B?dVBpbFBna0JBT1VmUmdqSC9nNVJxU0QrRGRkV3NPNm1qc000T1MwWVlucGNB?=
 =?utf-8?B?bnBldlNUbFB0LzNpL3pSa0tJcFpNbVhzTlZ0WFhURHVXYm5qL1EyQkhoajU0?=
 =?utf-8?B?aDFKZkJteitodGVVUjVaVGp5cGFRMUVYSGFaOUdKOTZjQzhmOWIrNmtuZ24x?=
 =?utf-8?B?Uml2c0JPQjI0QWY1eXFsSHdUZUlVQ2R3cFpuYVU4dDhITFNROHBpZkt6aTZN?=
 =?utf-8?B?OUdXSUJRTElLTHpybjBPM1FQY3BLbGNpQ1RDY2VsYWdOVFNoYXQvWGlIK1Rq?=
 =?utf-8?B?algrQkZYNG9tN3R5dTZlaklVUm4vZUd2TS9oVWpDTzdMc1JqR1pjdVN4eUZn?=
 =?utf-8?B?VElleFN2cWdmVmxuM3lHWlQwYU0veWlMcVl3UXJ2MVlnQXRaVitkRzJXY0E5?=
 =?utf-8?B?MTdtdEQ2c3lXWWVrNTZoMFBWUnpDS3loSk5KQlEzczAxZ2paSkUrbXhnZ3hH?=
 =?utf-8?B?YlpZbXViS2lpZ09vYWJpZk1pMHNrTzRHeWltSVRndWMyQ3VUaDZuZi8zMlla?=
 =?utf-8?B?bm5CWW9kSENEM2dZeW8xYjFhQkxNMlVVMSsrY1RQVThDWGVjSEVZWER4TU15?=
 =?utf-8?B?dHdDU0d4V3VoQUZkMCtyb3V1YU5MQ3dGUVpYNmtodjA1blJuVHBkZE1MaG82?=
 =?utf-8?B?L3pXYkFPQTZiNkdWTVRKYXVBenZsTzFsZllLRnF4TU52YXRZdzV1S1Fza2xw?=
 =?utf-8?B?ZGFCYVAyWk9pY2dDcDhSSlNQNWtEeXh3V1h2T3RUZFZ3VjhpT0w4am1SVlB1?=
 =?utf-8?B?c3pqTkNMMGRWcXFKNVJ4UE15ZGxLc1NHU0NDdG9ZUXFXVThUQmFpZ1ZicUxG?=
 =?utf-8?B?R0xmbEIrcVIwRHl5SGl1QVRGaGRBZ2ptM0YzUVVVWEZvVmZ3WHFUMUphWmdj?=
 =?utf-8?B?anlsK0ZNbkVRbWNTd2VxUi9PWWNzcGtKcTFsTytwaTN0Vk5VY3ZwS0Y4dUI2?=
 =?utf-8?B?K2ZrSTZwYWRVenFWeXVhMmpnN3pjcUduWkpZUFV4Qm8yNmJRbGN6bm9CL3pO?=
 =?utf-8?Q?FQY8JE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmlHdEgyODRtcGExS3N3RmNnSmhwV0FzVmo2M2ZwUEtVd2h3OWVKRFEvZEFI?=
 =?utf-8?B?OHRkcUhTMzNtMjk0TExjcUlyRVR6VXp6RzhuMFEwK01sVlZEZXVpV2FxRVhK?=
 =?utf-8?B?czlSVE9ZaXRVbEc0TFkveUNTVWtkMnJzRjRkcFdqdU5pUWN2OWVzazEwaE5N?=
 =?utf-8?B?aVMzRjJaTkRjME8rNUhoRG1mbW5VTm1VQTk0a1FVaW5rK2VnZXlVais3UWpG?=
 =?utf-8?B?RlN5RHIvOEQxU3dDMFVCV0NQV2FQWjYxR1c3RXBVUHl1VTd5Q1FzSlV0aXRR?=
 =?utf-8?B?a0VqcEswbkJCMEJEUjNqSjV4cXI0R0VRcWtIU1QxaVJ4S3dubEFnYXRKOGla?=
 =?utf-8?B?VFBtWlByQzBUNjd6UnNoSExWMEF6d0tScHVTalRXSGdmS2xlN0JoZFBFblh4?=
 =?utf-8?B?VTVUbUh5dW9hL1V5c1pDR1hJMGUvYkF3YWlOM2hyZW9IZFppL0dvdWt3T2o5?=
 =?utf-8?B?NWVkdWxYQUZtcVVCdGhpZzZybFpPU2tvb0xNU0k4amhIbnNnWU9jc1pDMk5N?=
 =?utf-8?B?SHlJL0xubXB1K3MzOTkvRXh4blpRMGh2WTlQYUZrNGVram4xdW5hNlBTNVlJ?=
 =?utf-8?B?RFNFdEJXcnQ4NlhjTGJCcGZFemJlR3NJb3prdTV6dC9pMS9YWkVnbTZNSTd5?=
 =?utf-8?B?MFdQSVNaU2xGckZjWk5oNmdINUNlaDRkS3RuM3pabkRZeXlTdlhXUEJUK1pl?=
 =?utf-8?B?QmpEbVFHR0hVRzlpeU9ZUi9PZndzNnRzckdZcG95REJiNGx3YTZ0d09rVU9n?=
 =?utf-8?B?QnpyQ0ZkUi9hSjBHZGZNQ096TVAxa1NydkJwQW1WVGxPOTZTcm41d3ZzUTU1?=
 =?utf-8?B?Wm5jZHJjc2lSSnNOd2crM0dEL29WVmtaTStpMVZabXNaL0FpMUJWSmo4RGRj?=
 =?utf-8?B?WlFlMGtkZXRCUU9BN1prV1pWTjBpd2hOMTc2S3YxK3BtQUEraThERmMzTnVa?=
 =?utf-8?B?Qm5GWHBKM21XSlRpcnY1ZENLSW1md0xUL05rakZhM1ZTS0lwY2dSQ1RmdWxh?=
 =?utf-8?B?ODEvVFVnVUNBUEQyaENrRTRxdml6VUg0MUh4d3hGS0NlRVR5RCtxeHFTS09O?=
 =?utf-8?B?cFZDOXNwWTNCQktmZUZtamM1eDVuM2ladXFmUExzSmt0QmtPNmVsUFk4ZGlJ?=
 =?utf-8?B?aStUV0xpVVVhZFYrUTh0M3BTN1ZCSnQrK1ZLR1Q2WDZpMU9zR3owT3NGMW9i?=
 =?utf-8?B?WXRnYXEzVFVoQUtqcEdhU2h6MFh2eGluRTJJd1h4YzJkZWhFdGVzMWVRcFZh?=
 =?utf-8?B?eE15c0J0R1lCM2VPbTFPeXNqcjgwMkxPZ01FckhuQTFlL3laeDRadXN3Wisx?=
 =?utf-8?B?cDZadWtTNmtEM3Baci9SNkVocHcwbDRlSmZxS2ovRkxOUkhyUHBtUDM1dS9I?=
 =?utf-8?B?YW5nV2JYK01wUE9tMHo2Z1pUbWxneDhicjZuKzVZUEh0NFZKYnFPeU9XTjJh?=
 =?utf-8?B?RjI1MkNLSFR1OTBCK1huVFFPL3NBZXlaK0w1S0tlZDZHVUFUdDRSYnd6VUhL?=
 =?utf-8?B?bG1Va2RVVlp1RzRvS1lxZ3pMQ0w4cEVQQS9QNFJkZDBxYlR0ekdRTFNNZk5v?=
 =?utf-8?B?SXdFelJvSmVCSVBJZVpubk5qN2t3QXMyNFhncWFlYVQrZlJQb3dTMXkxNGlk?=
 =?utf-8?B?NHRIWjVqZkw5MElZZEZYQ29pVDZ4VjRTcUt0YjBQNzFFQnlkRmFjb1dickZw?=
 =?utf-8?B?NVp0cUczdjdqSGVKVjlZVjZtdDluSmJXVmdHejZBdHBwRHd3aVZKTGFjSmFP?=
 =?utf-8?B?dWJvR2MwSHROZlA2R0VVMmxUZDNxd29wbW5RK3FWcUZ2czJBMWkwRGVxaStI?=
 =?utf-8?B?Ujhob25mZHRSbVZsMElDVmtIcW8rZk9RakJlZ0dUcGdXaWcwL2pPTzFHajc1?=
 =?utf-8?B?K2grbHVIOWRwTVFsN1FqZW1CaVNxcW8rRGFjVUt5dUZHaUZIZmxRVHlTYWMz?=
 =?utf-8?B?dG9peURzdjlsUG1iMzJVbnFGcVJsNldkSXRRdVBwZkRua0RoeE1QSWlKQXp1?=
 =?utf-8?B?NHJYZDBEWlp3QlYzcGdEbzJ2QkU2ZVNhUUlQVEtCWi8yc2NZNmQzN3hsaVk4?=
 =?utf-8?B?enBpSU1WNDRkNGVZTnhwZDVyLzFzVmg2RG9qelJ2ekE0bmMvNWpPbkxKZnha?=
 =?utf-8?Q?7BdkD+dG8n0JveJdr96GKq7OD?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130bbf00-ef79-4885-83d3-08de3baf6c4b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 07:56:15.7582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kx/0i67Y2PHmq0mJkLk981mFErwUYqzo02Z+1x5w3GIxtiZY5MLKuhzNmxIQYZfGnFU4iZuJ3zbAEBaotSkccw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF215029121
Received-SPF: pass client-ip=52.101.126.136;
 envelope-from=wafer@jaguarmicro.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: wafer Xie <wafer@jaguarmicro.com>

This patch series adds support for VIRTIO split indirect descriptors.
The feature is VIRTIO_RING_F_INDIRECT_DESC.

Eugenio hs submitted a patch: vhost: accept indirect descriptors in shadow virtqueue
https://lists.nongnu.org/archive/html/qemu-devel/2025-12/msg00056.html
Therefore, this patch must be applied first.

The current svq implementation can read the indirect descriptors provided by the driver,
but it cannot use indirect descriptors when interacting with the backend device.
However, if a backend device implements indirect descriptors and wants to use QEMU
to validate its indirect descriptor support,
then QEMU needs to fully support indirect descriptors in this path.
This series is intended to provide that full support,
so that such backend devices can be properly tested and validated via QEMU.

Multiple buffers are used to store indirect descriptors, and each buffer has a size of ring.num * 4.
Each buffer has two states: FREED and FREEING.

When adding elements to the virtio available ring,
descriptors can only be allocated from buffers in the FREED state.
If the current buffer does not have enough FREED descriptors,
its state is changed to FREEING,
and descriptors are then allocated from another buffer in the FREED state.

When retrieving entries from the virtio used ring,
descriptors are returned to the buffer indicated
by the buffer index associated with the element.
If all descriptors in a buffer have been reclaimed,
the buffer’s state is changed back to FREED.


Performance (pps) was evaluated using testpmd, comparing three scenarios:
1) fully indirect descriptors(apply this path series, indirect_desc=on)
guset<--------indirect desc-----SVQ-------indirect desc----->device


2) hybrid mode with indirect plus chained descriptors(only apply VIRTIO_RING_F_INDIRECT_DESC, indirect_desc=on)
guset<--------indirect desc-----SVQ-------chain desc----->device


3) fully chained descriptor mode(don't apply any patch,indirect_desc=off).
guset<--------chain desc-----SVQ-------chain desc----->device


The results show that the fully indirect descriptor mode achieves approximately 5%~10% higher performance than the indirect + chained descriptor mode,
and approximately 12%~17% higher performance than the fully chained descriptor mode.



The raw testpmd output is provided below.

testpmd configuration:
1) set txonly; set txpkts 2048,1024;set burst 8

  fully indirect descriptors:
  ######################## NIC statistics for port 0  ########################
  RX-packets: 256        RX-missed: 0          RX-bytes:  491520
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 74700761   TX-errors: 0          TX-bytes:  307543211008

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:       745609          Tx-bps:  18324096544
  ############################################################################


  hybrid mode with indirect plus chained descriptors
  ######################## NIC statistics for port 0  ########################
  RX-packets: 256        RX-missed: 0          RX-bytes:  491520
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 44153053   TX-errors: 0          TX-bytes:  202580423680

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:       674954          Tx-bps:  16587671544
  ############################################################################
 
 

  fully chained descriptor mode:
  ######################## NIC statistics for port 0  ########################
  RX-packets: 256        RX-missed: 0          RX-bytes:  491520
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 48458913   TX-errors: 0          TX-bytes:  212695989248

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:       665493          Tx-bps:  16355164120
  ############################################################################


2) set txonly; set txpkts 2048,2048,1024;set burst 8
    
   fully indirect descriptors:
  ######################## NIC statistics for port 0  ########################
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 18193774   TX-errors: 0          TX-bytes:  93152122880

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:       683537          Tx-bps:  27997687072
  ############################################################################


   
   hybrid mode with indirect plus chained descriptors
  ######################## NIC statistics for port 0  ########################
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 18948021   TX-errors: 0          TX-bytes:  97013867520

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:       646147          Tx-bps:  26466218232
  ############################################################################



   fully chained descriptor mode:
  ######################## NIC statistics for port 0  ########################
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 15944245   TX-errors: 0          TX-bytes:  81634534400

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:       583981          Tx-bps:  23919889848
  ############################################################################

-----
Changes in v2:
 -Use a static allocated buffer for the indirect descriptors 


wafer Xie (4):
  vhost: add data structure of virtio indirect descriptors in SVQ
  vdpa: implement a statically allocated buffer for SVQ
  vhost: SVQ get the indirect descriptors from used ring
  vhost: SVQ add the indirect descriptors to available ring

 hw/virtio/vhost-shadow-virtqueue.c | 313 ++++++++++++++++++++++++++---
 hw/virtio/vhost-shadow-virtqueue.h |  45 +++++
 hw/virtio/vhost-vdpa.c             | 163 ++++++++++++++-
 3 files changed, 495 insertions(+), 26 deletions(-)

-- 
2.48.1


