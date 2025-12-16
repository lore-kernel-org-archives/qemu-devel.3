Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B38D5B87A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 01:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVKGx-0005HC-Qz; Mon, 15 Dec 2025 20:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vVKGv-0005Ft-Aq
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 20:54:41 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vVKGr-0007AS-SY
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 20:54:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9BSG2CkiRpTljQg5JlZiEF2qqLDZF0avvnQllIv5pDK8XZkvbNApHaUPSBBdzCmo4+VIY8SDMsvHRKAbRiiBxm5TZ+WFkUqWW2O96/12SHSvhLgJaGl692JGyVet+sPITlLYb6GlSJ7Jd0PIL1kQnzBfQPGTT7n9NG70Jgd+lSEul8ZKO8utetXkp84jtQQe02nW+Gp58dkS7PkF1t3DysQkGP6htCYW7xXN8SZahP2CWl1RTSSBD/hax+ClNrToeEsUkkulHZccbuRkidZUr4hWKod4EYEJ9jyuBwaTRcnVq48tD5HBa30oNbnQxOpJ/22tZoZF4nIXZL1jliu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kX9G95UNHNGKnNxB0tIqMy22sVbyQPXdx6KR2d/Spzg=;
 b=sQKL1yyjlzbgsU51DIXRuu/kLNZo6MverDpX3lLLxneEuKCoa/YJ4HiDAYmJAqeo1HiSBLXltgTpa6BJnj4Znhy3EwfXoLpl230HEIA9A5diZHwI0nnsskq8vTSkEMbSz4A79zU+vXSteZQO1Bo9zB25OjpjZ1a8FTQU+CrcMBcXTuyRMqJGZ9cZIJBHkJayddtqSVZX96GFM18NsalJswSSAGvebfv1NqRKIumf7xBWFsOS/08wngYaOT8P/DsVzl+hHrlu9GlWj2NhAFLyUfMT8AJd1KKu05SVa7teG4+eb2UXUSvcpplT5YVEgRLDNaesE3THWmY8R+C/AOwzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kX9G95UNHNGKnNxB0tIqMy22sVbyQPXdx6KR2d/Spzg=;
 b=paDjO8Bmy0zB8HdEEJG+7KpgR7aPnvtodGFVPvKR2jHrJUBV7rw1mUTEdjLalCgOV9qyLkkSUbTqhsae9X32EM7gct4JFu+pvUPXoHXQ7+LZ28ONgoHSZ/MMa3pCmswf2tDpcLV/CaI+eK0UHzlbUk19xJgpDiafugWDhNmP50YOt/aiz4tfSgUPnQjv1MM+XSGkCFPhXCbfE8YsycFIYcx7ki5YWijLKdGqIpY/cMsQJ7IGuABBUxUGU+EhqoOghv8JZQbeNBrHb2W1sHlgLkhCPnZ7VPCS5diM+bXzzo8YbeV+fatU5kNO/RFmxSmVcXH7xAYAo9+mYdZb167Zjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by SEZPR06MB5856.apcprd06.prod.outlook.com (2603:1096:101:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 16 Dec
 2025 01:54:30 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 01:54:28 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v3 0/4] Add Split indirect descriptors for SVQ
Date: Tue, 16 Dec 2025 09:54:16 +0800
Message-Id: <20251216015416.6418-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::18) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|SEZPR06MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4356fe-7d4f-4b1c-fb01-08de3c460bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0c2NjJUKzNXVEkxNXhXc3UxU3FOV3k3Y0k4bGhRMXROdG9PNXE0dzVBeXF1?=
 =?utf-8?B?WTlxditlRXB6bGt4MjJQNzN5ZGFrVHB1cXQyOHFiU0JJNzhYUEtxeGJjemd2?=
 =?utf-8?B?Wi96Qk5lLzlqeStiQmFoN3Evek15K1NyQjFFMU0rZlN1dXJYdFo3RDhvVnNQ?=
 =?utf-8?B?am5tbzlqclg4OVRxM0d5WWE1Yk5nMElsKzVPSWVobTkrTzJ1SHR1MDA4N09n?=
 =?utf-8?B?OElZenlVSktSRis3TTI4UVMrL2sxNTdKZkZoMkEzc3hpRThPSWZZWU1UZnFL?=
 =?utf-8?B?WFVBdWIwcU1oRHZNNTVReUFrbUhzVTM4UEJUdThqOXlIZ3ZZVjd6QUF5SDZK?=
 =?utf-8?B?WjBJODVqOW9MZ3Q3Vk1rbGxFdWFWc2VoQysvQTd0bHRkMlpjbnlNY2xibjIr?=
 =?utf-8?B?Yit0TWRiUUlUSWtJd2FIdnkyZlo1ZStNWnZERzc0WEtHMkhpYmdhZEwvNFI0?=
 =?utf-8?B?c0tuME01WUk0WWF0bnl2Y2w0cDlmUXpLbUxvbTNXWkh2c3R0dVNRdVVob2Fr?=
 =?utf-8?B?TnhTalZVNGZqS01MSSsvWlE2U1NlcGFpWTVyZkR6NHFBcFkvT3J6a3RNSTZW?=
 =?utf-8?B?OXdwcHBUekQzQ21TUll4Y2hVVWtjVE1rcksvdUZNblFmS3BRckJrUVl4TVlm?=
 =?utf-8?B?VmxVWFpPaHg3MXdUNkdUVndBY2pMNDlMazB3bE05aUU1VFhaQ1ZvbGNaM3dC?=
 =?utf-8?B?QlkwODN4NmJhakVTVEp1RkNrRTIwZVZuWGg1Wkc0RFpISThubWRHcW41NnQy?=
 =?utf-8?B?WGh2VTI3dkJhbGFiVjFGdjNyMEVtekZadjU3RE1lZG02RWVSOE10ZEFhdDFS?=
 =?utf-8?B?Y2tFSnlKbjJabEt2MG1iUVh4a09EY3N2RjlSaWFwMXJ4WFBGUTB0VmJQWWRW?=
 =?utf-8?B?UENvNElveTFqZnhYQXhWWUtaM295YlFxV0NrbUZIbURXZm1GRFgxMWNoL1Bz?=
 =?utf-8?B?VjZuTlB2NkRMeE1KaTlhZ24yYytSMmtkM25sWHBMaGwrZW5zUHhJcExITnJJ?=
 =?utf-8?B?Z2hobm9MdjdrNEU1Nm80Nzk1OGN3a09tVFZndG9jRERRR1VyNk9nYWF5L1NP?=
 =?utf-8?B?ZlA5OG9OSDhKSEdqU2wxOW5VSU9lRHI4R0ptMVZlNUI4OGxDcDNNMkVFdXJh?=
 =?utf-8?B?bS9QSDVhZTBWYkFOVkhhcXJpaXJMUHBqcC9jMzh3TXhWRFVucFNkNWNJbDFp?=
 =?utf-8?B?Skwyc2lGYkZkQSt0VzhVdGlMbWc2Z0Z1bC9JTkp5UUFPdlcyYnM3TGdaVHFN?=
 =?utf-8?B?eHhxd2FkVzZRVnFXbkh0TlZKYkJ3cG9BOUFhQTB5QmJJQmdnU0ZsY2xXQjEy?=
 =?utf-8?B?SGZoZUlXaEhPc1pqWEZSU3Y4UTdhMFFyUHpYOTk2M3h2TnArYkNBcXRhcXpv?=
 =?utf-8?B?WWY5Z0VTQjVqa0xHT0U5SXVIU1dkTlkxMk90by9nOXBoOFJhalAwNVpHaUNt?=
 =?utf-8?B?OCt3ekhHMTZrc2l4S0h3djBSVStJU1FiQWlvM3gyM0J6WkszQnM3N3V0Qmda?=
 =?utf-8?B?aVgzcitYcmxOa0RNVUFONnNZaCswS0ZJSlhTVU9kTElQZUtoQTRiV24yTitI?=
 =?utf-8?B?WlUzMkR2bTF2SmljWG80SlgxVXpJSmhmWlpJL0lVTWprYjRaOS9Sc2w2QUJP?=
 =?utf-8?B?dlVWR0lpVXVpWmNOUEloMXhoNkJaRkh2OEoxektrYXRjK0ZmRFNZWUFZWVdl?=
 =?utf-8?B?bldtSWk4cThJNWpxZkVJeXBvZER5M1kzUUN3eVFvenhtT0ppOWNPaXNBSGFT?=
 =?utf-8?B?R1M0ZEhvR0dQcGgvT2duYklDT092RDcwNzU0ei9LTGVlZFRyZS9Vd2lySmtK?=
 =?utf-8?B?VXpxcm9zV0pnV1htUWZ2Yjh3TDVhMjNnQUZYQ014ay9sc0lQQ0U4SWV4d2hz?=
 =?utf-8?B?MWdpamRxRDE4SXZPaS9nT3VpZWV5M01FY2daOU1YTDdsakNTNlNEN3hoa2Vj?=
 =?utf-8?B?NitYallHc3dlZ0Z2ZVdhUmNUbFpYdko2UFF2TGZRV3pGYlJPdHZQTmpYaklZ?=
 =?utf-8?B?WEtvSFBrRCtJQUJpZ0lIRERQOU9lbVpXbDRaN211ZmMrcjNVeVhhK21mM0Ev?=
 =?utf-8?Q?+XXBgi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExOaDc3U1NxbjVuL3BMNHlUckJOODNiUVdERzZ6QWVuZGZvMS9wNUQvdDJk?=
 =?utf-8?B?djBZcHZjUFVjNmxyZENuLy9LVllyeDJLalF6b1d3SDQwaVc3L0R3OFVFQjdK?=
 =?utf-8?B?bWdraEJsSkNrTG1WYjYybmNpQ2wrUFQ1bUpObmVWNFpBTHRzWUZOc1ZGYXNj?=
 =?utf-8?B?TUI0dm1iZDR0RG5JWDJiSTJwQVhSVGJKZXpZZk5rcnpHSkljUndlcU1PMzE2?=
 =?utf-8?B?SWN5RFg2OE0vNFllTUcyamNtQUY3R2FBSzN4SXBhd21ZQjNnbVJkajY0Yk1i?=
 =?utf-8?B?OGZETWZOZ3NEWmFhaDM2VENrMldmMitwM1pxYmRkMHduSVpFaVNiQ0hVZzFS?=
 =?utf-8?B?SVZLNE1DWHRmUE9HTWF2MTBzczMrWURvYmUxTFlOV2x0ZlRLY3VGRlZ0aEl1?=
 =?utf-8?B?MythbVRGTXpUT1c1RWdrSUQzSXMwYkF1cjdRSUZzV01BRk1qT2hCdEdFYjMw?=
 =?utf-8?B?OTJSZlFGdHZaUEkybkQvc0NMUWZ4Unh4R3lLMDY1VTk4dm43bU1QZHFRdXM2?=
 =?utf-8?B?UHVTeStlUDNBampnVHVUSXQrVVduRXVCMjhHTllZbHVIUzdEMS9lcUFSU3R2?=
 =?utf-8?B?OXAweE9RSTNJZjl3NDJId21LN3Y1SFdVeHc0WkVLaGYxM3lQUjAxZ21UNEFw?=
 =?utf-8?B?SDNWampFTHBPNDRvU2JYNlNiOHlpOFg3OU9TRldUZCsvdVFUUWFUbkZrTE1V?=
 =?utf-8?B?OUpXME13MlQ0eENvaXBhK2dpc1pWVkVqbzdRV3lDK0Z5K3dORDc3UjFEUXo0?=
 =?utf-8?B?dGREMzRVcHlZKzRhT1pyRXFwcmpKRmNWREJIWlk2NEJWUTNpamxKdEtjVVpR?=
 =?utf-8?B?Szk0UE9zWUVoRFVDUEFPcm80aXJyeGR4bVRqcXdrNnRYbk9mc3ZzenBLMlcw?=
 =?utf-8?B?K1BOT1JXVkltQnM1VzdaNXk0UVQ4emsvMHB1b01DVkpQWC9CaFBoR3hnTVU3?=
 =?utf-8?B?aXlwN3JKWFFwZXZQUnpNKzJvR3NOYnAyWUdlRk1BUHNDclRObkM0aHhpS2hV?=
 =?utf-8?B?K2VLbXFWaVlGd0xoQTJ0WUV6Vk9mRTNHUmZZRjdLUjRtcEhMTDhmUnhlTW1K?=
 =?utf-8?B?U0thV1FiMG1DdHpTQndQeHhjTW1lQ3c4b1JhTTg2cjVRQmZ0ZERieTV4eFJT?=
 =?utf-8?B?MjV0ZnhpSGNqMmUwY0tSakpnbmdqMU9uY1UrNi9aSjdYVS9USmxWTDRiUU9X?=
 =?utf-8?B?bXpSQjRhU3VwU0ROaFlSa0VZSlBaV0I4azg3VUY5a0d6MktBSDAyN0czZ0ww?=
 =?utf-8?B?TE1mV2lWMElYS3JvVnVTbnRmVHVWSFRIVU15bjZmYVlEczhKb2htaEcxSjJz?=
 =?utf-8?B?bnJyOXpoS2xnM2xnUnVCTHJlWlRHU2ZyaWVXM0UwVjRNdUJnaDNuRXpoSEFx?=
 =?utf-8?B?eTRnRzEyZTYyV01aNGgwTW5MeUtjYTVXdVYxVkNhSlkrVXlNb1o5NFZjaEJD?=
 =?utf-8?B?aCt2ZEZCVU4ydlN4WXl0NVZjRXFMV0lMZTU3TWdFSGJyQUNKUEN3aUpJb3pF?=
 =?utf-8?B?OWZMWmtteUpWVmRjN096bFplTVZpUTJiY2w4WU9pZXEwNG96cjhyWkZpUnZQ?=
 =?utf-8?B?bDFlcVZGZGlDUXRqaG5MWVJad01FUmROTHRHNUFvbzZMMVNJMlZkL0lEOGZp?=
 =?utf-8?B?Vll2UXZsQlFMK1RhMGU4c3NlVFBlMGw1Q3QvM3dLdU83aEt4TjR3cUErbjBU?=
 =?utf-8?B?Zi9YVlNOa3VjRTQzd1RDN2x2QWNRV3gyOVV5N0I1cERkb2w0dDRaZktYQTZG?=
 =?utf-8?B?MHhtdC8rR2VScU5uMjBDcFBMdWo1OW5nM1NvR29sa2FTbjk3Q1N5QmtqcW1U?=
 =?utf-8?B?T1RnUGZjbGRDSUwrTTlmWVBkSXhHRlBxQW1OSXV6YUFHcmt0MXZFSEtaa0VW?=
 =?utf-8?B?RmVGSURabk1JTUtncVU0V0kxdndlRzhhalBneWVHWDljWkIwOEJUdUJodk02?=
 =?utf-8?B?MWVHQ1JEaVJiRFUxVmxzQzV3MERMRVh5TFBURjhwS2JzMzhwUWlQQmZCQlU1?=
 =?utf-8?B?cnU4bUxLSnloMlBLSzZjVk1pNHBJOURuQldTaFJRT1hTeDBXVHNVU3N6UUJM?=
 =?utf-8?B?bkxva0ZuRFgvV0ttNWFxTFhXVVhMeklNVjJBblN5YlVJQVRWRWJFS0ttUlV1?=
 =?utf-8?Q?w5RsqUPRYQiPYSjoW4B2C3MBG?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4356fe-7d4f-4b1c-fb01-08de3c460bf8
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 01:54:28.1931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYF/PJko6mvrRphdw/QZoa2R/Qsk9K/du2zl5AA+u6FigMach1LUVcmpxwx7Z9EiRANR5dPWWxSaa5+nrdp7Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5856
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=wafer@jaguarmicro.com;
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
Changes in v3:
 -Fix code formatting issues

Changes in v2:
 -Use a static allocated buffer for the indirect descriptors 


wafer Xie (4):
  vhost: add data structure of virtio indirect descriptors in SVQ
  vdpa: implement a statically allocated buffer for SVQ
  vhost: SVQ get the indirect descriptors from used ring
  vhost: SVQ add the indirect descriptors to available ring

 hw/virtio/vhost-shadow-virtqueue.c | 325 ++++++++++++++++++++++++++---
 hw/virtio/vhost-shadow-virtqueue.h |  46 ++++
 hw/virtio/vhost-vdpa.c             | 163 ++++++++++++++-
 3 files changed, 507 insertions(+), 27 deletions(-)

-- 
2.48.1


