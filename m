Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28404C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 18:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueeeX-0006Qm-As; Wed, 23 Jul 2025 14:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1ueedi-0005pN-5M
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 14:56:30 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1ueedg-0000kD-3h
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 14:56:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELM0OSHh8tD5GR65eswIBtDZbXnMtmg6fmeLtR8Xhi+zv1YbcoY5dkNzDhKCxRRQai4DSlbZp2sM9A+PMnblB3vtzjqnUY6k8z5FHKdD9ZxFZ1moAXTr62Zkx0CMTUm5mCzIggz/vwHhABGzykNR9fEh11zHTqZHP3pZ2OZlC+/arHreXLQcPPlV/j1YV/VNei8PW4Zf6PvYW43Vafq2K25Ss9Rss7/STMQzI3Um3z0WyPmfUX4n5yDfo4bln9va0HgUY8e5TsW8wS2QlcYSD1lAjXNdcAlnz3mykvxRUm3V6RzpaS0lJd9VKbdE43SbE/mohlTgJVjWM7oAnQ98MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX/xbyRBZfC6LgvSE8IEkP1ins8qOpyUapLrlGCEk3w=;
 b=ar9NfXJLbJjpwNkCAywc1rQWRjcoaxEt8Yg/ZoCiPFJt45uOVNFxGfRNmUk3jAL+QyOteDV+whfWTgNJ6AVDYAHUT3dic0C6tU37C6eJXlWAh42G47NNL3iiAH+S6W60ljUTgQ9wHTGynekyFT45KUnOxSuEy1hY0t7Y/p7P/KwOtigG3wJ+Ee//wqHghPASb/YXydhA8qut3v3g95Rgu24eI/etesb2YCLOrdfGiQRNXLk8nFkUNvlLzrAy5xOnXxSRFCBOeB85Vnu33fQaWcKfWjoQn4brGxXM2BPNiB/6bGpPdvNPF7Puf33k5RvB04HRbtQIiTSd+r9qVgfb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX/xbyRBZfC6LgvSE8IEkP1ins8qOpyUapLrlGCEk3w=;
 b=NbbrstaYsw+dt29j0sjM35XFaj9R/WzdLlcNq6AkytzFwf77v0C9IJTaIRJddJB++8WdlVv6MvtzRMY6ECOhxlBsxj7xlynu13QYNOEsNONXNqjpJcbU/7Caskh7D71DZhv8ulB5dxB1jaIjfIsUUotMWxaZnLFFX39mj530wu1i3heJQCs+rlTMpZX7PO8+eoqY2E8kffkBO0M2wOwUmJdswwAlMSZqEpX9lyln8kuBr4YOneJ2H7HzYXSDyPLyHOkgbALSfqXsEH5z2RQT/lf5uAFhquBHMV5hbR3bB6vp/NNZ1XRH/QnmXmyEvP5tFmn/2BaYc4E37eVclJWLuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAWPR08MB9806.eurprd08.prod.outlook.com (2603:10a6:102:2e2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 18:56:23 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%3]) with mapi id 15.20.8964.021; Wed, 23 Jul 2025
 18:56:22 +0000
Message-ID: <98e99280-ea43-464f-8a59-887bed4a717a@virtuozzo.com>
Date: Wed, 23 Jul 2025 20:56:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dump: enhance win_dump_available to report properly
From: "Denis V. Lunev" <den@virtuozzo.com>
To: Nikolai Barybin <nikolai.barybin@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250723170402.75798-1-nikolai.barybin@virtuozzo.com>
 <584056e0-0507-4a24-b4be-8f31ebc75f65@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <584056e0-0507-4a24-b4be-8f31ebc75f65@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0030.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::19) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAWPR08MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 703b23c2-d854-4b20-4703-08ddca1a9e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHhaeVFrdGlET25sSkN1WWk3NUtDNWhSem1ZUE43WWYzbkRCQS83U1lpM3or?=
 =?utf-8?B?NFZ1K0MreVZ4ejV6Ym8wQ1Bic0ZmNC9vbVpLaVJzTlJCc08xNGRZVTJCYlpF?=
 =?utf-8?B?dGFzM1ZmNmxJV21hNTVoSlRrR1VSYUltdm9JU0lCV01HSG9jaDJ6STNhVkhE?=
 =?utf-8?B?cFVGaW5ZckxoczROMkU3UGJGU0wzMHRoY29nWjJBT2N4R1BHeVY3ekJ1OHZz?=
 =?utf-8?B?MlRKaG9jalJPT0Q5ZmlPWjJSdkZIYlQ4RjUrWlJpUXl3S05QVUk5eDVXeUw1?=
 =?utf-8?B?S0cya3NBMzVBR1hieDRDdnhsVnJIdEFPTitQSHJlakJSTlF5SVlDaEVKZFRL?=
 =?utf-8?B?S1Mvdkh1ZVc1d3R3ZU1BcWRzcHJVQ1FhWDJ0T1dpSy9DOXRFUnFvQWsvSlJr?=
 =?utf-8?B?S2V1azUvZjhkNjh3cmVsYzAvWmd0b2k5Ym9Hc05nZzRCTTJoN3Q3NUhSZzRK?=
 =?utf-8?B?REg5K0ZwZ1htVjNvSXI3RmVuWG5mT2xtajFPeHl6SjRDUjBKN2cvaVZQN2RW?=
 =?utf-8?B?UjJQYlpXQXRESm5WbCtzUkFtQ0FLcjlyeHZXc3c5RkIwQjFzWThwaU1KMktK?=
 =?utf-8?B?eStPaXRqSnA1cE5HUDFMV0VsdlVNYUxuQ2RMSURrYUZTb0xUN1pmdFdtaTVL?=
 =?utf-8?B?ZnBpaXZRTlQ4WUtCWnRzdWE5d0VuTm9tUDlNdFJxTkxJakplanIybDJlQjdj?=
 =?utf-8?B?U004c0dldDhLcUpoT09BT3c2cmRYeDBkOTN2TWgvVkxiNTZhOFNKZUtRSGxj?=
 =?utf-8?B?Qkd3NGFkTm5mUjJTZGo5SmNxOGU0enJaWi9aVVlPL1ZyUnJLcUFiNkhMd0Ir?=
 =?utf-8?B?MjVyNmdCYnJDSFVvV1RSR1NhSlZXUzBDMEJ5K3ZBbUhKK0JteFFQdWFsYitU?=
 =?utf-8?B?YlZtVEVwWmZTeDJldG1HanF3dWpvTnBwUXc2MjV4dmJpb3ZQNks1ajViZjRm?=
 =?utf-8?B?TGZ1OXk0Nm55QnhvSkVPZjBrcXFGY3Q3ak01Qy9xdnFyN0ZxYVQ2bnNSUWgy?=
 =?utf-8?B?MjNTblpoa0h5VGJ1SzVoWmNNNG1raE9oblZZZm5GZmhia1ZmK0JMMGtDeFpY?=
 =?utf-8?B?Y2d0TGJGaU93cFc4aS9hVUZIZ2xSYXdTV2tNM1QvK25nWEVxUURFZmJLOG94?=
 =?utf-8?B?b05vVy96R0d6dnJCeVZqOWxqeUcvb3d2RTBtR0VuaWtuZGx6cWRpMXRHZVdj?=
 =?utf-8?B?ZEh3S3NiRFVYYW8yTWpnRHNSZG9QY3lxTCtBOUtkMFBBZkwybzRucGJEbEpY?=
 =?utf-8?B?dzZjb0NoZjJ1TUhkR0t3WXg0UmFOcUlPU2VNblNDM2N2OVVoOEZubWdDWFJy?=
 =?utf-8?B?bEg5czNFYTRTcTFSZTJoU2VXeXA3QzhlbUhpSExPNDNPZGNmUFJpclVnV3dH?=
 =?utf-8?B?cllKSGN4WFpKSkx0QTExWDFzSjZQOVNPRVEyQ2ZkS0hKbmxCTXB1eFdQNXg1?=
 =?utf-8?B?Q01UNGU1NW94UFFlTlArOHFTQThHSVpNTFVnMkFYaHVVQ09Ub0NrT1lZd29k?=
 =?utf-8?B?Mk00dXJXVC85cGtZUkp0TUIvQkNieTNTdXJUcnNFR2ZJMnprN2JQelduRGNq?=
 =?utf-8?B?TkFuL2JRMlM1OVR3U1Y3dC85TmtKRndGbElyanQ4b2xJajJVb0RuVG9HdDUz?=
 =?utf-8?B?VHJMYmVKZUdvU0FocHlvTG1ZbUtRTzRRYUtYNzBOVy9WRmlwbmFNa2xvTFA5?=
 =?utf-8?B?aldsZHlQc2ZJV3J0elQzS1hBY0Rvei9Ic0ZPYjk4V29mZFFXTER6VHdaamFI?=
 =?utf-8?B?S2svRXhRaEdkVlI5U1MzZEpZYTVwODB4bUF1ZGw3U2I0b1RGWHBGRWcxYmcv?=
 =?utf-8?Q?NZ/Hu1UVBijrARhZwFZSOZ+AZ2JDPKd4YmCoU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXZDcWYxQVcwdTlnY0V6WWpZeldnYW1WSUZnVEpnN2ttUnhDZkVCa1dPaTRt?=
 =?utf-8?B?MmlNMDZKbURBUUtCRS9aYVRETGUzbVZtTlNWNjF6dlN4M1pFVlpLNGFBekJC?=
 =?utf-8?B?WFpwUS90WXNaR2NSbjgyMUxSK1pvVFk3UzVFYlR5ZVdiK3E1U1dNemwzYVBV?=
 =?utf-8?B?ZjgrdUx6R1M1MzNQMWJ2NTFSYnZ4VGdtRDhXcDF4K1RYUnh6eDNmcm1seFFj?=
 =?utf-8?B?VEZqck5BSTB3UUNGWHFwbmU2citqZGx5NmVYa0d2MHVLRG9NRTFtMWNyMWhx?=
 =?utf-8?B?VzFHcnJMTWpNNThPNEllTWZqTUpYY2xFSjhEcnNtVDlUdFJjQjJuVHArOFVt?=
 =?utf-8?B?d295amk2V1lSRVdJc2l6OWxzWHBqb0NCa0tyYmVqS3B5QVZQVGhWeGF1ODNK?=
 =?utf-8?B?MXY5c3Vwakg0d2RZUU1EL1NVUS9GMlppaDhOa3lBeWJGNXJqM2dNQjBnUUFT?=
 =?utf-8?B?R3hFT01mSTJIUWNPclRsZVQ3QStYa0tvN0sxeXBYZ0oyeGFpQlFNb3ZPMjRo?=
 =?utf-8?B?V3kxOHh2N2dBM3lvUjByRTdrQjZJbERwTlB5MEVTc2JPVUVadWVSZGZLUHpy?=
 =?utf-8?B?NUNCNkkxUnRKMkt0NW9MMExQWjhORnBjaUZyRlRTS3pWeGExNTVSeTFBUEJw?=
 =?utf-8?B?YkIrU3gyWUZSdUU5cmp4eWlKUndPME52K25LV0I5WTRwK2JVL2tFZ05zUERs?=
 =?utf-8?B?eldHVjBkaDc2dnVkaUxScTlEdDBkdkQxWnVaMzAxSklyOXJQbXVZZ2pJeVFM?=
 =?utf-8?B?TEdORUxrMWQvT2ZDOS9Zdml6QnkweCsxWnNOamZNUVl0azhTODJpb3Iwejhx?=
 =?utf-8?B?U3Q2YTdGUk5xcldydDZnWFZqVlRiVjZXYzRNUjJEQXlqVlVTcmt4eE1wNjRX?=
 =?utf-8?B?L3d1blNpL3ZvUmhTajE3Q3RnMmI2Y0NJY2xqUXMvMm8vNTZoU2M3NUlQQkpk?=
 =?utf-8?B?RjJ0S0NxQ1dRbzVYaGgxSVgyVVl1dHhPeW5ZZzloZVBTeEJNdjRiOUxWK0RF?=
 =?utf-8?B?dHlkVjRKTWROU01jWHNramtUdnhIQlMyQXZaZmN2bUt4NllFdkd2TEVvYVBm?=
 =?utf-8?B?OUFnZXlPOE8zcnN1bWJYVEdqVzBabWkyVTM2UDFGbGJrSjNuTi9TQ2E3dyt4?=
 =?utf-8?B?aVVSc09vVmk0NU1BT2pHek5aWFBYa1VqcW5sTExTTG9XZFc5R1NUZGluVGFi?=
 =?utf-8?B?WWU5UkxodGlJRFZNQS9GYmJSKzB3VkVUM2xsSWxtNjVwVm9yS3hZN0Z0OTlv?=
 =?utf-8?B?eFpLWDErdk02elJHdnZDaDQ1Z3JpNVVQdCszdVNtSHg1dmJ0Tk1EUUxZb3NF?=
 =?utf-8?B?NSttUS9pNUpNRTJBN0tTeHkwZlFhYXg3TXFXOVQ0QmRvRTZNMWlLZ0xWM0tx?=
 =?utf-8?B?K2RNQTZkUWJEcytTNDQ5ZjBYL0NJeGlIT1VudVVxYVhReVFOK1hzZU1lRWpO?=
 =?utf-8?B?NzBIVHZSKzlVOEZqVG5hMkl5T1BsdVY5aGVVbkZnU3dwTG80cFpFRnZmbksr?=
 =?utf-8?B?TTl5WTRxN092eGVrdnVlVUlPblVib2JPUEI4d2pTMmJxY3pkL0lsNWM5UFFB?=
 =?utf-8?B?WXp3TG9GZityaTdPYXVIR3R4RWw1UUNCREVjSi9JSDhnWGhFK0htWTJJb1NJ?=
 =?utf-8?B?M3g1a1k1KzM0eHdBZ1NrcS9iYzQvYnJxaERMNUkvbDYwSHJ5UjFQU0Y1M1Zh?=
 =?utf-8?B?SGVDOCtBaDUxM3R0c2dtWDhlQUNkZzlzRHlqWXo2UjNINkR5MGkvZlFPbjBl?=
 =?utf-8?B?SWdoTStvU1lnRDRpVGl6bTVvdWxKQnhnZStiYWZPSlNibUpsMHVGUFllSzl2?=
 =?utf-8?B?bGxtUDBYWWMwS2ZHSG1JaEpzbkQwVzJoWUcrZHd2MU5BdlZHMmFKU1IvYWV5?=
 =?utf-8?B?U25BelV4bnkrTlg2WFpQU3BRazMwTlc3TGRtNUV1cXIrOUQ3cDZWU2lJNGVB?=
 =?utf-8?B?UmwyQnhOZkFiQk10TERFb0Z0bUJYYUsyWDBLQVpqYm5ET0FrVWE2NkZ1aldp?=
 =?utf-8?B?c0ptNkNUaVJTVzB0cU8welhOcXZBMjg2VC9uV0FtWG5JSE1vaitXN25nVjN4?=
 =?utf-8?B?K1hXT3JWMU1pRnIwbnJuVEZhRDMzc2RIRmVjMElObVFsZm9CVE5CMnYyczBV?=
 =?utf-8?Q?oPgWdyF73gJXFJZF9u8/iM46Y?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703b23c2-d854-4b20-4703-08ddca1a9e0f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 18:56:22.8074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Iu4NC04uhobd5NyQwirKSVwF95o64IRGBy3XBQGwu/aH+7mH7Ib+tNBvrSAc6HWGcH8oL5e09fD/njJY0X5Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9806
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=den@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
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

On 7/23/25 19:31, Denis V. Lunev wrote:
> On 7/23/25 19:04, Nikolai Barybin wrote:
>> QMP query-dump-guest-memory-capability reports win dump as available for
>> any x86 VM, which is false.
>>
>> This patch implements proper query of vmcoreinfo and calculation of
>> guest note size. Based on that we can surely report whether win dump
>> available or not.
>>
>> For further reference one may review this libvirt discussion:
>> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB 
>>
>> [PATCH 0/4] Allow xml-configured coredump format on VM crash
>>
>> Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
>> ---
>>   dump/win_dump.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>
>> diff --git a/dump/win_dump.c b/dump/win_dump.c
>> index 3162e8bd48..4bb1b28e63 100644
>> --- a/dump/win_dump.c
>> +++ b/dump/win_dump.c
>> @@ -14,14 +14,74 @@
>>   #include "qemu/error-report.h"
>>   #include "exec/cpu-defs.h"
>>   #include "hw/core/cpu.h"
>> +#include "hw/misc/vmcoreinfo.h"
>>   #include "qemu/win_dump_defs.h"
>>   #include "win_dump.h"
>>   #include "cpu.h"
>> +#include "elf.h"
>>     #if defined(TARGET_X86_64)
>>   +#define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
>> +    ((DIV_ROUND_UP((hdr_size), 4) +                     \
>> +      DIV_ROUND_UP((name_size), 4) +                    \
>> +      DIV_ROUND_UP((desc_size), 4)) * 4)
>> +
>>   bool win_dump_available(Error **errp)
>>   {
>> +    uint64_t addr, note_head_size, name_size, desc_size;
>> +    uint32_t size;
>> +    uint16_t guest_format;
>> +    uint8_t *guest_note = NULL;
>> +    size_t guest_note_size = 0;
>> +    VMCoreInfoState *vmci = vmcoreinfo_find();
>> +    ArchDumpInfo dump_info = {};
>> +    GuestPhysBlockList blocks = {};
>> +    int ret;
>> +
>> +    if (!vmci || !vmci->has_vmcoreinfo)
>> +        return false;
>> +
>> +    ret = cpu_get_dump_info(&dump_info, &blocks);
> This will not work IMHO. cpu_get_dump_info tries to operate
> with a real guest memory, which is not provided. This means
> that guest executable is impossible to find.
>
> For me this is looking like Windows dump could not be enabled
> after the patch.
>
Correction: current code will not work on 32bit guest with
more than 4Gb RAM on i386. More problems are definitely
possible on other platforms.

Den

