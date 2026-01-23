Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A537DD6CFBB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 05:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj9Kd-0006sy-P1; Fri, 23 Jan 2026 00:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vj9KY-0006sS-Qf
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 00:03:34 -0500
Received: from mail-japaneastazon11022078.outbound.protection.outlook.com
 ([52.101.126.78] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vj9KW-0003Ww-CD
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 00:03:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIoATz37kFAW6KKuElfK+Q8rJosirHGA6Ve4W66GpYrw92+NKnBjrz9AcGaDDdbkGZ6V/n8iesoPdToFxwMwR8jy9aBFHak59F43sW4tZJbaqMGpk8n0Sfj64g6UMt6yAPiATDCJfqN9zd3Nj6GlPlQomn4i4EcNKa0pRLyCpHwnzGGhJMHzWMNvQbacmJ/L9ErjodFjc2z0UN6400emHkW2KMxUxjNUoot2ECKkAzZi7krQ8fT09zg3hn9xYXWBFcROJBHWOqz8x6ojUM7gI25S+zHsK6urPT8Av3IeVMmoggeIluWWcgnZM2YvHj3yepC2s0JKU9vQvCzwSnoX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWXiYeDR0a0N90bCont2A8liZqgH3l+wsHgesmghAV8=;
 b=CX6Z1idSl0uMtqO97UbSGdWJBj94m7zIYgBfN2MsDuu7ozAkTvtX4Drbpv4YU8cMhhebxV4Eobh56rhheq09ICj0CtwjXY6cOF+bTGS8t/806Y8ck5ap60HNdWih8EhG5HOX+rXkPUgTqZLUpQ0D1bIPA8tR9czWJxl3QEXl03g8ZLJZFxa9FTjxgG1r0cLLxaJMnaPm/MZg4G3A8X0amMjklz2MCHSEtZP0CFZWEwOlCo/b8Ws9eadOTdum10GLi1NhuzdAGh6EVtemF7+LgYkbcs36LeFLUiZrPuTd+wBwbXghEqZAJzdxeriw7t+Dq3AULArX4tbxTuUbZ/4mrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWXiYeDR0a0N90bCont2A8liZqgH3l+wsHgesmghAV8=;
 b=LAPGdWwtq2PSNYL9Szf+TM2e+xO281toU9T7sHe1XWrm8/0BUCRGJofIZ188KFHyzuIFzclTl/r6qhyno4pdwIozkxV8OfLivtLU6InsuC5GmyLHZPEQE++w3UfWLfLuk3FjpI+0zBnGe4IZdFvZOqOxrne1AN/pdLeZ+DlCM7nCUWcn9W9PTS56U3kEetxp0GAHq33Lw7D+o7cU//gMmqpcTQrdxoG9g9XN+qzStdA7QHhtYJDgqLKYaEnKwV7LmyTV7NpXkrMgX4u0PKtzst6lZEa1u5H4oph88xx41R84kh0D9b2d/X5JmaaqMsCJTIkiXQKRUbyAJAO/uWfnqw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6258.apcprd06.prod.outlook.com (2603:1096:820:d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 04:58:23 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 04:58:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Michael Tokarev <mjt@tls.msk.ru>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>
Subject: RE: [PULL 0/3] Update vbootrom image to commit 1c8e9510b22c
Thread-Topic: [PULL 0/3] Update vbootrom image to commit 1c8e9510b22c
Thread-Index: AQHchrn9D+vfYwM4mk6SyACbYX4WXrVUoqKAgAQSGeCABobxQA==
Date: Fri, 23 Jan 2026 04:58:22 +0000
Message-ID: <TYPPR06MB82063DC02D7CF460FEECBB47FC94A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260116073024.3485812-1-jamin_lin@aspeedtech.com>
 <ce304e18-b28c-4a85-a765-4a3f2680901e@tls.msk.ru>
 <TYPPR06MB82061980D169464392781CC9FC88A@TYPPR06MB8206.apcprd06.prod.outlook.com>
In-Reply-To: <TYPPR06MB82061980D169464392781CC9FC88A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6258:EE_
x-ms-office365-filtering-correlation-id: 51ee2006-4aba-497f-199d-08de5a3c08f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WjRwN2gvUkVCZ3Z6emw4NTJEOHZrODgydEhERGFNZzNzbFlQKzlzSWRNbVVQ?=
 =?utf-8?B?L1RGOWFobHQwOFR3K1IzSUpleHBaZE5FSDltUzFUY0xzVHhlT3dNcG9LQWRs?=
 =?utf-8?B?OHpKKzhWc1dLZzlCVm5IK1R5b1JJVlNsUzMycTgzWUJvTTlvWTh5ejNwSEJn?=
 =?utf-8?B?THhwOXEvZkUwZVpKSUFUZ3NmVXk5UEhwTlVWQ1lHTmoyeTZoczQwMUcvVWY2?=
 =?utf-8?B?bDBGeDlvWkpTZGlEdEpzaURWTHRwRnd3RC9Id3lVVWQzdUhCWDdhNng1MTlU?=
 =?utf-8?B?OTlLM3JQeFc0THFmS1c2Q09TM1lsb1loSDBqaWp0ZkhXSnZpZjdWaW5DUytv?=
 =?utf-8?B?eFBodWprbmwzSFhPSkpMeURLVVAwYXorR2VEVnVvVG1FVEZVUzdteWRwTk9Q?=
 =?utf-8?B?aUxFYmNnS2swcDkxK2VBMWg3VVk3SS9HdXZhVnBxVEFDZWw5WFBHMGZzOXlu?=
 =?utf-8?B?TUJFbCtFTGg1WHBEc3hwVmJTTDBCYlhqa09vcVlnd2pldVp3dlIreHZybUVV?=
 =?utf-8?B?ODNyNVJncU1VZU4vMEF5TGR4YUxsbmh4VFNGbnhHTTMwZlVPcEllQ1dKMVRv?=
 =?utf-8?B?MmRQNERWbHo3ZDNPb213VFhQWnhqeFJlMk1GelFTZzNrZUhndXY1T01tOHVz?=
 =?utf-8?B?RGE4aXlwRHNkYXBobWVIdmVnRTFpblVTaUR0VHVIS1FTZmRlYkN3OVdYbzA5?=
 =?utf-8?B?SnA5d1BLc0tiNUZCSkNUK2ZnYXhVa0hubHNlRTlxM3dMTXBnVXBGeGROaExI?=
 =?utf-8?B?K3dzV2lQNlZPd0dneFBkZmpxOVI1NVpaMCtkN0o4dE5xWmVVYWlxRGZIUDFN?=
 =?utf-8?B?N2NCYWNpdUMvV1YxNzEwVVVTaXA4ODlXV3FyRHhJQzdlMXFReGdMekI3aURt?=
 =?utf-8?B?ZHhIOHhXQVpxUmpqbnkrRytmeTA2dEFRQk5zTGVONHlDaTRKRG54R3o3dGFB?=
 =?utf-8?B?Y1NOeWFUOUpSZ2E1ZzlSdHE5UHBEWkJmUGRRRkxTdW04RDNMbVJ4OE1vMHAr?=
 =?utf-8?B?TDlydEJaNncwSFVEeTFVRGE1eVhCbVVLak94MnJ5ZzIyVmxpYkZXM0tSWWN4?=
 =?utf-8?B?cEE2QjFpYWNXTUsyNDRWbVQyR1ozeSt6MUJJRnd4bGJrYmI5UGNVRkZKeisr?=
 =?utf-8?B?dytaNXhYTVp5OFN4N2JxSkQzd2Fka29ITzJRREZOb0F3WmxHOGNCQ0x5VjNW?=
 =?utf-8?B?T0p1NFRwSktOV3JOZXVETFB6L05PbEtSMlROZitaTEpsOXVVL3NUc3N0UTAv?=
 =?utf-8?B?QWt2ZzMwck91WGMwdW10TXhrVitPZ2YrTnpmcU1xeWtNVElUMWhsOW1LYTM4?=
 =?utf-8?B?ODFTbzZLMWRHd2EvK3dWT0ZzSTlJdG9vVTEvTXdSZDF4MTRWZ1ZocGY3eGVN?=
 =?utf-8?B?aXFDTWxEUWI2ZVhXRWpyb1UyZUVRRWJPSnF3MytQWW5NV2NXMzc4UStTMXN4?=
 =?utf-8?B?MVNsdDhveXdlRUkzeWdjQmRQZVJlNytuRUdFU2MrU3J2RjNoSTcxckNITHBC?=
 =?utf-8?B?MmszODMvVWdmWjNDSFQxN2NJVW8vZjZJaldDWG1rc3lhdmVURDIzY2NQdnRV?=
 =?utf-8?B?dHZaT1dxU0xXaE5oZWRrc0VCcitnczh6ekY4RTNKbS9hRVhjcXBBOVJqMG9k?=
 =?utf-8?B?M0pwckhUN0cxSUtpdlVlSUw4MkpDUERXUjRsblNKdFZRSHlSQjZ6QUxxUG1w?=
 =?utf-8?B?QWRXWll1cCtOQ0lyb1I4L0loODgybHduY3hNSUFuZGs3a3BZaStNY1JKVThW?=
 =?utf-8?B?WUlTdjdkd0JzalVleGlKTnhXL2x0eXoxay92VUdaOFN6Z1RWV3hadENzWXFy?=
 =?utf-8?B?Tm9Hc1c2MnFaWDJlN21UVnF4NHk3eUxmcGdlNFl2ZnN6NHVIUjdsWHRBL0h2?=
 =?utf-8?B?S1J3Y0dBQUxUdG9WOHdXUnpKc0F2UEpTaVdNY1VFdGFZZnVWUnRRKzdFV2Za?=
 =?utf-8?B?NnNING9XU1V3WTNJaHNreFpYT2RXaUowcThDS1ZiRE9VbGVDT3M4WkI5Qmd0?=
 =?utf-8?B?UU9yWTZackNnR2htd0hIbitNaW5odk1DYUFZYTIwZjNVQkRpR1pQU2xBSnB3?=
 =?utf-8?B?U291N1lWbUFnaURvTVEyam1oZytUeXNJaS9maW5PVDZ0Qm9EdWhtcDRxUGhZ?=
 =?utf-8?B?cTEwd0dFVkpZdy9lYW9mcDY0eVlIb1dldHVjK3JvVk4rSzJ0NURpNlpEOTNB?=
 =?utf-8?Q?QhGbekj592HVJ9tSru1l3dE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTFEbk01bFB1UWNETFdUbGI4Vytkb1h5cWVFUVhhbWh4UXhtbld6U016MGVW?=
 =?utf-8?B?blhjTy9GaFhKZGVXL0t0ck5BbU9peW1mS242SnhLU3ZFdmkvVFB6UTR6UVRX?=
 =?utf-8?B?d0R1ZFFJMkV2d1FKUXR1YXd0M24xN2NWV2oyWmFUc2dzUUtNZlZLbW45STZN?=
 =?utf-8?B?V3lDQW9WamlVbS9YYlVEeCszUjd3L05sVzBoY0dxODBzZnhjRHNJZzhqZUtJ?=
 =?utf-8?B?Zy9lZnVxUkNBejdMVVNkckJqWnBNeWpKd0htNEthc0k3ZzNsMTB3S3RWUVVl?=
 =?utf-8?B?Wkd6ZUZ5ZjFXTlFxODVzT2FSVm9KZHZWdXBUamlXbzRXQkhJMHQvMG9XUjVU?=
 =?utf-8?B?UDc3bmYza2NrNG9nVllibWpGWFRZT1Fmb2N5djdmS0JRSExPQ3paNkszd1Vl?=
 =?utf-8?B?bmVaKytxcHYxNTA5bGJQV1ZOTjloNjJaVlpQNmFFT2ZwMXZWMVVpOEtxbVRs?=
 =?utf-8?B?Q2VUMEw1M3o0aGFCRzJUZmEzdWxFMkI5R1M1UXM4UkhGUnBKQUk1cjVCSVBl?=
 =?utf-8?B?a1RvWXJzTHZuTkdreXZLaHlBZ0ZiQ3FQZEF0Z3hxbUFPM05WSGU0d0JjcUVm?=
 =?utf-8?B?Rlh1WVhISlJUaGtETndyOEZkUWtmRDRsZjBML0N2eHVYclB6anM3VDdNL3Fh?=
 =?utf-8?B?Z09hbmpxMEcwbG9mQkM0clhuQ2VQOUt6TDdlanhKaDBuUGwvVEkzMVlIYjlo?=
 =?utf-8?B?UjhPU3JUUUI5YzI1dloyUExqQmRVVW1GTnQwRXJYNjBtdHB4QU0zemFhMjZJ?=
 =?utf-8?B?eldvME5pY3FmSVJVQzVyQnNqYUhjbTdKRW5sT3NTMllldThDaGs0K2hXY2xa?=
 =?utf-8?B?eEhMLzdVNVU5T1IzdkJMNXJZaGp5aC9HRHRLWXhVVmp1MmZzelhneFlBM0lI?=
 =?utf-8?B?Yy9MWmxRL3JCa3BNN3JoZ0NrbUoxV1BTZlNDUi9XTXpXV1cxU0lnSkFOV3d5?=
 =?utf-8?B?NzJaUXNTdjM0U09IcEtpcVgvTXBDaGQ4UkVoeW4rU2x0bGVNdzhtMEk5Tngz?=
 =?utf-8?B?eGs5T1NaTlVSSEtkZG5HVndkeld0c0hHSytxUURjQnpmcUxLU3RneXBSR1Jz?=
 =?utf-8?B?UFdXK2txTmJjSUk2dlVONHJ3OC9zMFpENTBEdlFIdS9INk1TekM1VjNuRDFX?=
 =?utf-8?B?dTJRTWVyZS9ydG9wVmh5dC9mWnNCcklSWldSMUV6Sk4wTkY2OFI2WC9CeVlX?=
 =?utf-8?B?TERHVkZVTmd5bHduSVRKcEpxMnh6SVdWZU03NDA5V21HOEN1Y1VKUFpWdk95?=
 =?utf-8?B?dWMxaWdES295NGZ1N2FEaERVZUdPWFg5UGtTS093bDIvbmwxMmJ2QzZrYXM0?=
 =?utf-8?B?RDRLSTVwYnQyOGxjRmZ5QUpHdVp2SXJkMXVaazd5MlZSVU1uc0RRTXJFZkpk?=
 =?utf-8?B?bzVFK3AzeVZnMTlFQzF2cXNrZDR6SytxdTVuWXZXWVlPaVErZGxIVDhzcnRv?=
 =?utf-8?B?WGpWRDlPdlFWS3MwdmZFTEcwQk5qYmJ2TE1NcEV2SS9nTkJtR1pkRkZJVUtB?=
 =?utf-8?B?RFNQWWZoUStYemdGSFhudEs0NG9SVmowMXEwSU5YbnBKVGxTbmo5Nkc0S09s?=
 =?utf-8?B?T00vY0xUaHQwVlJQMEFvMVc3VXMvLzJtVU9WYnI5SnVqSXB3aVhPeVd4ZlRL?=
 =?utf-8?B?TUJBQytMK1NiVEM3U0pURzJZQXh5K2lZeWFjQVBORG04YUowbmh3VEtOb0p4?=
 =?utf-8?B?RVZwRzFPT0hQcHc1TjFpNnE0V0lHZDY4dmIraUkzaW1SeXg2b2x1dk5ZdTZL?=
 =?utf-8?B?eTEwOEplVjQvSWhta2lVNXhEYzFTcWpiTXQzU1N2OHQyZkRqOFdMMC95SERR?=
 =?utf-8?B?aVl4TDJaZVM5amVCRkM3WDNZK1YrWjVPWWJpeVFQWHlrdUF3VE9yWC9BVGF6?=
 =?utf-8?B?T25BZm53RFlqcUpyU2RwL0ViUmYvdGhGczRlNmxuTmhCeCtCZHhnZlU1MWVR?=
 =?utf-8?B?SXFML1NHTTduVUtYNWYvNEx6cWVwOHlnZnZQUzNhYUd3UTZQa3dNc2dTbDB6?=
 =?utf-8?B?VnE4b1JPMG9mZ2UzcGRneU9nNXdDUWFXd0ZkQm5haW13MU5oZk1ZRmo1V2lU?=
 =?utf-8?B?V0JnWFhjdnBiZlQ2cU9EenRwTk5QOURnVDA1Yk92Zmk2L0ZoWEdydzVMeC9I?=
 =?utf-8?B?WXJ0QVhMWFl6Q1gzeTVaR3JrNGNlYVZFQ0hxcjBSN1doeXNObHdiRlFoc1BV?=
 =?utf-8?B?SktWT2RLUFhlVmo3OGl2SHpQMEVIekdiamRsRStVZ1JZR21XcWFIVlAvWkF4?=
 =?utf-8?B?MnNpTUUyYnZkdVVBMFMwb1V0Sk96WHhmdEY5UVZzTjNod1hSZmxPRUNsNlFR?=
 =?utf-8?B?Y0pzNFZpUUlyTUljdmdtdEptVms3VlAwbVpjbmNqQTV1ZjdWeTlTQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ee2006-4aba-497f-199d-08de5a3c08f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 04:58:22.7080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNHm0uzmjQGC0VeELM1dKaAv9D6xAscfcOaE+zL1R3b+P9Z6gXp+KC5CO02RbakHtNHYBEqYlPlSeZAZmXCmUKRHiUKE84e+YVMIVgTuBss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6258
Received-SPF: pass client-ip=52.101.126.78;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

SGkgTWljaGFlbCwgQ8OpZHJpYw0KDQpEbyBJIG5lZWQgdG8gcmVzZW5kIHRoaXMgUFIgKHYzKT8N
Cg0KSSBhbSBjdXJyZW50bHkgd2FpdGluZyBmb3IgdGhpcyBwYXRjaCB0byBiZSBtZXJnZWQgc28g
dGhhdCBJIGNhbiBwcm9jZWVkIHdpdGggc3VibWl0dGluZyB0aGUgY29ycmVzcG9uZGluZyB1cGRh
dGUgdG8gdGhlIEFTUEVFRCBTREsgdjExLjAwLg0KVGhhbmtzLA0KSmFtaW4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW1pbiBMaW4NCj4gU2VudDogTW9uZGF5LCBK
YW51YXJ5IDE5LCAyMDI2IDk6MzUgQU0NCj4gVG86IE1pY2hhZWwgVG9rYXJldiA8bWp0QHRscy5t
c2sucnU+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVtdS1kZXZlbEBub25n
bnUub3JnPg0KPiBDYzogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gU3ViamVj
dDogUkU6IFtQVUxMIDAvM10gVXBkYXRlIHZib290cm9tIGltYWdlIHRvIGNvbW1pdCAxYzhlOTUx
MGIyMmMNCj4gDQo+ICsgQ2VkcmljDQo+IA0KPiBIaSBNaWNoYWVsLA0KPiANCj4gPiBTdWJqZWN0
OiBSZTogW1BVTEwgMC8zXSBVcGRhdGUgdmJvb3Ryb20gaW1hZ2UgdG8gY29tbWl0IDFjOGU5NTEw
YjIyYw0KPiA+DQo+ID4gT24gMS8xNi8yNiAxMDozMCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+ID4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+ID4gdmJvb3Ryb20gdXBkYXRlIHB1bGwgcmVxdWVzdA0KPiA+ID4NCj4gPiA+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gPg0KPiA+IEhpIEphbWluIQ0KPiA+DQo+ID4gSSd2ZSBiZWNvbWUgY3VyaW91
cy4NCj4gPg0KPiA+IFlvdSBzZW50IGEgcHVsbCByZXF1ZXN0IChhbmQgc2Vjb25kIG9uZSksIGxp
c3RpbmcgbXVsdGlwbGUgcGVvcGxlIGluIFRvOiBhbmQNCj4gQ2M6DQo+ID4gZmllbGRzLiAgVXN1
YWxseSwgdGhpcyBpcyBkb25lIHdoZW4geW91J3JlIHNlbmRpbmcgYSBwYXRjaCBzZXJpZXMgZm9y
IHJldmlldy4NCj4gPiBGb3IgYSBwdWxsIHJlcXVlc3QsIHVzdWFsbHkgaXQncyBlbm91Z2ggdG8g
bGlzdCBxZW11LWRldmVsQG5vbmdudS5vcmcgaW4gdGhlDQo+IFRvOg0KPiA+IGZpZWxkLCBhbmQg
bWF5YmUgdGhlIGN1cnJlbnQgcGVyc29uIHdobydzIG1hbmFnaW5nIHRoZSBtYXN0ZXIgYnJhbmNo
LA0KPiA+IHdobydzIG1lcmdpbmcgdGhlIHB1bGwgcmVxdWVzdHMuICBMaXN0aW5nIG11bHRpcGxl
IHBlb3BsZSBmb3IgdGhlIHB1bGwNCj4gPiByZXF1ZXN0IG1ha2VzIG5vdCBtdWNoIHNlbnNlLCBz
aW5jZSBhIHB1bGxyZXEgaXMgc29tZXRoaW5nIHdoaWNoIGlzDQo+ID4gKGFsbW9zdCkgY2FzdCBp
biBzdG9uZSBhbHJlYWR5LCBpdCBpcyBiZWluZyBtZXJnZWQgYXMtaXMsIHRoZXJlJ3Mgbm8NCj4g
PiB3YXkgdG8gY29tbWVudCBvbiBpdCBvciB0byBtb2RpZnkgaXQgLSBzaW5jZSB0aGUgd2hvbGUg
cHVsbCByZXF1ZXN0IGlzIGJlaW5nDQo+IGFwcGxpZWQgdG8gdGhlIG1hc3RlciBicmFuY2ggYXMt
aXMuDQo+ID4NCj4gR290IGl0LCB0aGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLg0KPiBUaGlz
IGlzIG15IGZpcnN0IHRpbWUgc2VuZGluZyBhIHB1bGwgcmVxdWVzdCwgc28gSeKAmW0gc3RpbGwg
bGVhcm5pbmcgdGhlIFFFTVUgUFINCj4gd29ya2Zsb3cuDQo+IFRoYW5rIHlvdSBmb3IgcG9pbnRp
bmcgdGhpcyBvdXQuDQo+IA0KPiBJIGNyZWF0ZWQgdGhpcyBwdWxsIHJlcXVlc3QgYmVjYXVzZSBp
dCB1cGRhdGVzIHRoZSBwcmUtYnVpbHQgVkJPT1RST00gaW1hZ2UuDQo+IFRoZSBwYXRjaCBzaXpl
IGlzIHF1aXRlIGxhcmdlLCBhbmQgYm90aCBteSBtYWludGFpbmVyIGFuZCByZXZpZXdlciAoQ2Vk
cmljKQ0KPiBzdWdnZXN0ZWQgdGhhdCBJIHN1Ym1pdCBpdCBhcyBhIHB1bGwgcmVxdWVzdCBpbnN0
ZWFkIG9mIGEgcmVndWxhciBwYXRjaCBzZXJpZXMuDQo+IFNpbmNlIEkgdW5kZXJzdG9vZCB0aGF0
IHRoZSBwdWxsIHJlcXVlc3Qgc3RpbGwgbmVlZHMgdG8gYmUgcmV2aWV3ZWQsIEkgdXNlZCBnaXQN
Cj4gc2VuZC1lbWFpbCB0b2dldGhlciB3aXRoIGdldF9tYWludGFpbmVyLnBsIHRvIGluY2x1ZGUg
dGhlIHJlbGV2YW50IG1haW50YWluZXJzDQo+IGFuZCByZXZpZXdlcnMuDQo+IA0KPiBnaXQgc2Vu
ZC1lbWFpbCAtY2MgamFtaW5fbGluQGFzcGVlZHRlY2guY29tIC1jYyB0cm95X2xlZUBhc3BlZWR0
ZWNoLmNvbQ0KPiAtY2Mga2FuZV9jaGVuQGFzcGVlZHRlY2guY29tIC0tdG8tY21kDQo+ICIuL3Nj
cmlwdHMvZ2V0X21haW50YWluZXIucGwgLi4vdjMtcGF0Y2gvKi5wYXRjaCINCj4gDQo+ID4gQW5k
IGFub3RoZXIgcXVlc3Rpb24gaXMgd2h5IGRpZCB5b3UgYWRkIG15IGFkZHJlc3MgdG8gdGhlIGxp
c3Qgb2YgcmVjaXBpZW50cz8NCj4gPiBJcyBpdCBmb3IgbWUgdG8gcmV2aWV3IHRoZSBjaGFuZ2Vz
LCBvciB0byBwaWNrIHRoZW0gdXAgdGhyb3VnaA0KPiA+IHFlbXUtdHJpdmlhbCB0cmVlIChpbiB3
aGljaCBjYXNlIGl0IHNob3VsZG4ndCBiZSBwdWxsIHJlcXVlc3QpLCBvciB0byBwaWNrIGl0IHVw
DQo+IGZvciBxZW11LXN0YWJsZT8NCj4gPg0KPiANCj4gDQo+IEkgYWRkZWQgeW91ciBhZGRyZXNz
IGJlY2F1c2UgaXQgd2FzIGF1dG9tYXRpY2FsbHkgaW5jbHVkZWQgYnkNCj4gZ2V0X21haW50YWlu
ZXIucGwuDQo+IFRoaXMgcHVsbCByZXF1ZXN0IGlzIGludGVuZGVkIGZvciB0aGUgbWFzdGVyIGJy
YW5jaCBvbmx5Lg0KPiANCj4gVGhhbmtzLUphbWluDQo+IA0KPiA+IFRoYW5rcywNCj4gPg0KPiA+
IC9tanQNCg0K

