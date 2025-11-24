Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CACCFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 08:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNRa4-00050J-P4; Mon, 24 Nov 2025 03:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vNRa3-0004zD-4k; Mon, 24 Nov 2025 03:05:51 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vNRa0-0004t9-Ar; Mon, 24 Nov 2025 03:05:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlXkE3X5iDZYviPSdkqpyBP1YqTrObOEgDQtm58bJsiN4nV3v3GGwUbvXlf92ijLUXqUUKjDv1jscYqLtZZu5+k93FLfAf6BGiOy8rrh/FXCRYczkH4DpRJSEqvg5wkT88Kq9ewyUiFxwNL+Dc67yBX8Xq+TK2xPYnObapC+mUS0Wc2vyG6Y2/iYTHTEN3WrZqwiueEHp8IP8U21ttCU7TP/aq1XxaIhwNHjNmr4pD3HaRfFJau6iAGFfyXHXgi8wXMUFVaP2yQtA7WJTMLDCJAJd+NKG+c9zAEjxcddI/P5U65HFSqH9bQN31grjIYbSyrdeh4VEhzA2AEG+DQ2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OYI7/e73hzlbLXtpSoxokKqhRUB4GKS5pmqgg46j9o=;
 b=O+Refa32C6rVOjt4jsL0dLHLUNZLdUPfVTxR3Kdn/tGm2zip/pZpQUKJAvtMwPTYQVCjco0HGRu3j0ndq7mDiuCKAB7fNCsTgRc1oVT4avguLCPRbrnwP7taR03qsANBaUPXbO4/iUyODewHj7XPKdO9vUhw4udcXkzOgqS6WktW+4TGR0SVp9Bjju7T+YlCmOcageuLjlY5ICmKsIypAf0k2ZbnjFcDmbScrr2YI27q56XbpI2/cq9PBtyIGbjunQ39cXxWUPLe9r/m5PaXzh1z0WkuZGeue9K8kaKFyrbRTngjtAMswbatZLpyBQzZCN38efwR6I1+C4x1/g0oDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OYI7/e73hzlbLXtpSoxokKqhRUB4GKS5pmqgg46j9o=;
 b=mlpR8GnFYnZzFKeFSDKnMMJyqG7R2J4UXAvqozg/siA6LJY81ohhEe0fO8NE+S0g2py8nY0P7vBbwdpmq5dD98+YDE4Qc4vuu1DClqPzOEVYo++ZulK08uMGzTCNJtVcte3VIN0frbuiciWrtHLAjtgevqPR3X1DEnGUY40WHWbmw4s79vnqb18/MAbav9xf+VeyD5Jj/DWRLQKRcYYV/m5TQVUH2CHKiLje2faUGmfdsWcy6pKCbfYVg5gnjWPWzqZA0ebufXDY5aFr4hlT1G35DhRvOU3HEItf/ZTWIX4Nn+nl0/lqE3t/BpHpztQSH38bO7m86YlKhZ+toCbFtw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Mon, 24 Nov
 2025 08:05:39 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 08:05:38 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Thread-Topic: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Thread-Index: AQHcWiEf+PaTPr3V30uUQF2zh8a+rrT8ExiAgADSd6CAAIZ+AIAEERrg
Date: Mon, 24 Nov 2025 08:05:38 +0000
Message-ID: <CH3PR12MB7548BCF00E128545097E3DE4ABD0A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-18-skolothumtho@nvidia.com>
 <aR+Ga0DrveuOd3v7@Asurada-Nvidia>
 <CH3PR12MB754869BFD4D1B5C65EE30AB8ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aSCnyrcIe7kqIncW@Asurada-Nvidia>
In-Reply-To: <aSCnyrcIe7kqIncW@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB8881:EE_
x-ms-office365-filtering-correlation-id: b9cbb4c7-f770-47f9-59cb-08de2b304167
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UCs0WW5aRzhudmQrY0RNQjkxRkNNUnhscFJNZXFqcXZMczk3MWdGMmtGZjlh?=
 =?utf-8?B?V1FtUGdxU21iYzV1ZzNqMEZucjVLdk1rZy9hVG5mUVZCdlFmZWM1emZkSkx4?=
 =?utf-8?B?dFc5WmNiWWZmbXZ3YTZjdXcrZW1pTXVkL0JvUGdqZFNteC9WRVZNYjZNZms2?=
 =?utf-8?B?Q2FtdzE3SnEvK0MvN2RhN3VDMTZxRmNBd0xxZmNIRXgrWmtMZXZrcHB5N01m?=
 =?utf-8?B?ckUwZXZDUkQ1SjZrd045ZmJOWkhtRnNxOStlUk1kTlZXM3hsbGVpZGRUSUI2?=
 =?utf-8?B?ZHZESXlKcVhUdm8wYlpiaGNOemlnYjVMbXNZWCsvTGhNY0hheHBZMVl3V1NQ?=
 =?utf-8?B?Z0FFVFFFbUpJTVE4Smlib2xCb3NYSVFoa3dPR1pxRkRTcGEwS0lpbnFjS0Ir?=
 =?utf-8?B?cGJoeHRnVmtkY1lXUlNBdEcyRUljcVFod2RaT1Y3YnpoTndreFQxKzRydmJy?=
 =?utf-8?B?ZzNGTmtYLy9FazJsZTlRTFFFeVNkM0hEZk1YYzU1Tmp0Rnk5anlZbHMrTGx6?=
 =?utf-8?B?NTk3RjQrelZKOW9HRy9EcWlEQmxBb0tQM3dINFNxOFY0ZzM2YkFjdEtuRTFS?=
 =?utf-8?B?UnNKcjdkSVRoRzNMWGpOT3F5WSs5WldNSk5WUGtUQ3ZteUJLd0JEUlBVNTF0?=
 =?utf-8?B?R1k4czlJdG9iZ0VpNXhlaDA2U0wzZFkxK0xtLzMxSkszRGtTRHlGYTI5M0gw?=
 =?utf-8?B?dHdRekpOODFONEhVUDV3NXRvWHY4Q0N2OW1MWDNibDZ0YWJrY0g5VnQ0bkpM?=
 =?utf-8?B?WVdINXExWWk4NVFURERXdlFlMHBBMlNiNHJyUStnZXRyWDBDR243Q3dxOE5Y?=
 =?utf-8?B?a3BFNTIzeS9GcDRoTERoWlp4ZTArYzVPdTk0MVdaQjJCRDV2SWwxcHBwMnBn?=
 =?utf-8?B?UHpLVWErSW5mMk44VGxkQkplbndEVFMxbGliYmxQSmVkUnlrZ0RUQUdsV2w0?=
 =?utf-8?B?aEFSSFIxcEdHdFJ2cFhJdDZ5Vno2NFlJNSsvOHBhdTFlR2JjUU9LU1VKaXhq?=
 =?utf-8?B?ZTVlMVU0MnJqQjVQZWUvcTNEdFl1bVl3OHVucU5IZHNKSERJeDZ3bE11b0RL?=
 =?utf-8?B?YStUTWQxaDljejZmSXQ5b2gyMVh5K0pySi91Yys2YkoydWVzTGlUWTVZNk4v?=
 =?utf-8?B?OXJsQWJYamNnbEJNZ3JyNGN0RDRqc0Y2b0VSZXJXYzhzZUQ5b2lNWEg4SVJx?=
 =?utf-8?B?NDFtQi83aGo5cVZRT2crQis1aUZ1UUdFdjBLOEc3ajBheXMwN2pqNkhPa3FQ?=
 =?utf-8?B?bERibFlVNStLTXduZ3N1UmxBckkyQUpYYlhRTlBqazRWUUVXNm94bHFUOGE0?=
 =?utf-8?B?Yy9Ka3luNFVCZmR1ZzZhRzlOUEdkYjh2azdyT2pTak1pL29SUVB3QzBnWXRQ?=
 =?utf-8?B?aHYzOURxalhXUFB3NnpDbzFtYThDK2NCQWNzRzZMWGtYeEJic0N6OEp0TE5V?=
 =?utf-8?B?eGVTbG1CV01qY2NWUjBRbDMrQzFPaWQxdzNmQXhRamFpdnA1QWNOS3pVTEVR?=
 =?utf-8?B?d0VJeGE2ZkNUQkpRNlQwMER5bTZ4aVR6TjFjbElWck9icEhmTUMvRXdBc291?=
 =?utf-8?B?bWwyVmFRRmFrcEJSQytEZGlRZEFTQ1psTVZ3T3kxQStNYVRyM3kyMm9tTElR?=
 =?utf-8?B?UTBsaXI2OTlpNDFqMXM0WWZUT2k3WXUwanMvelFJcTFSOTR5bTcrLzRiVHhM?=
 =?utf-8?B?MXVRRnppTHlrMnIrakZXUzR0ZVBqd2pnSHBKWWJESnN2ZmQrRXZOMjRVNmFz?=
 =?utf-8?B?MXRHOVRxYnBqZkxjTy9HeFhyOXAxUkQ3WTNpWVlOL2ttNjllZk16Tm4rRkVK?=
 =?utf-8?B?VUhrTUNjbDVDamxpTUtOeXJETkRiaDRZYjNnVC95UHk5em5xM3J3TllxZllq?=
 =?utf-8?B?enZiV1ZiSll3M051ZGx2dlZuOGxQdnkyU0hRd0lHOEI0c25BTHNwMFBIc2xs?=
 =?utf-8?B?WEhmczRtTnZpQmtwcHZtMVBpclpzNFN6S2RoVFdxL216NlN3b3FGR2UrUFN3?=
 =?utf-8?B?TE5HbkRYaVF5SEMxOGF0MHFnMGYwMTRJZytzWXVQakdITit3QStDQnl4bDZk?=
 =?utf-8?Q?vXFiZt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QStWN3dFQms2R2p1SGxQUW94TGU5VWt2UGNjeDYxQllkbHRkQzRGa0FvaG9l?=
 =?utf-8?B?YUFzVndqRjNWd1pISGtCdnROWjRkT0RaWmEwYXh0c0tPcXZPby9WNC9DU1Vs?=
 =?utf-8?B?WW51UWRPTmRuaTdiMVVlSW5Ebzl2cDBYMG1aN2UzT1ArQ0pUdjlaU0FhOEVP?=
 =?utf-8?B?TW1XVGlEQVRMcE9taVNTZFpjQWdHUWtZSWFLSklQa293YnlET1BzUG9FUnY1?=
 =?utf-8?B?ZmNRT3ZEWmhKV3pKU1VlL3RDRUZBZytGMUQxLzdITzF3eTJibW50MnhyelBP?=
 =?utf-8?B?VjNPaWJBVWZHMjJQMmFXeVVjdW5mU2d5TlRPUE1ldnp5b05QT0ZFLytTbXJx?=
 =?utf-8?B?a1Y4MGNabk5iUXJWRm1NNTBmUjF5V09yaEJoVEhTSG5xSUN1Y29PamJ5eC83?=
 =?utf-8?B?U1piOFUyL1F0UFc4S1BidUVZSHc1bFBRWCs3VGNxVGhxai80WWNRMDNWOU1B?=
 =?utf-8?B?SVFxRmZaNi8xTmJzTXJISXZRTnVJVTlDMDJTWWVNaXN5a21aWHZOQVNRbmE2?=
 =?utf-8?B?QXdVRGVEampXN1NGZTB2cFlrZi9DR2dqTGZ5NlNnOXBlb1lwaWI4NDhTblJO?=
 =?utf-8?B?UHR6WEZOdnJmM3hmZEtOamhpUE5nQ0wwUUF3VW9HRmQzTjNBM1pBTzBNV1Bi?=
 =?utf-8?B?S2h6alluR29EMTZrZFdyenBFeTZUZDdPZU84M1BuSnFqbzNaTC9PMlNJZHhV?=
 =?utf-8?B?N0xQVzdSU21XcXdhOXRXemJFRlIxdnVOM1NETjQwbGFpWnM4OUg3ZjZOZlNz?=
 =?utf-8?B?OXYyb21IRVZURUQrblBXeHZjVzhaK0QxMTByak1EZldoNERuVy9qVWRDM1g5?=
 =?utf-8?B?bDJyS2p4SWlzYVlyTndyNmNZYXBaeTR4eUFnVU1yc3RUcSsxY0dOZFFINW5z?=
 =?utf-8?B?aUE5TXdZNHpLUVNTWnhidkpWcEdjbE11dnFCS1dEeGduZS9jR00wUVl1Q1F1?=
 =?utf-8?B?UWZva29DbFR5aDRQaGU1MG5xV2huRGFSNTJmakhGYlk5OFQyRG9qSEEzK1V0?=
 =?utf-8?B?dGZHVVhyOWVjaVVLenllSUZ3VWNXeXBDWjc3RXpOSEY2dlBWeTJXczlmYnpL?=
 =?utf-8?B?YzQ3Y3dORnNyaGx0MGV5dk94Nm1QQi82aElFaGlRSTRjWlhBVm9GZzlraHJ4?=
 =?utf-8?B?eTdybmxSZ1A3TXZHeUowcndxNDJwQVd3eHNBamo2YjdTb3pCZ0RySlE1L0w5?=
 =?utf-8?B?RDhwTWNoaCtYa0VMWWNRVlFoenVhVE4vMzJuUHplbnhGZHJjdytHdGNZN3ph?=
 =?utf-8?B?Yisrd3NieHJSNGpoM1JHZjVLdnBNaHBuN2dKYXhsMzRESHZsMGJZR1Mwdldw?=
 =?utf-8?B?eFZ6dm1FRnpPT2k5SG4wcGxHRmNNMDNKZjc3akZaakVINnU4bThmS2VGblhJ?=
 =?utf-8?B?elg4Z0RaUU1jaXpCc0c2cHF5aXJLN3UwcnAzb3ZCaUl0L3Y0cnk2SER2bHk3?=
 =?utf-8?B?UHNzMW1UTlZWeUpxMWNsbFdJRytXTHMxTDlCYlJYM1IvMDBrajBrcHBvYkRo?=
 =?utf-8?B?amlOUnRZdEhsMFNsQllkbEVMMlNxclhUTXYvWk04UExlRWUzaTQ1UUp0YVZG?=
 =?utf-8?B?SG1EcHFVTkt0WXhQUExvd1c2NitSRVMxY1ZFa2pOM1VOTE9GRXp4cTY5eVR1?=
 =?utf-8?B?K3dMODBHS0ZTNG9zVkkrakxRL2V0SXRoT1RwbGFlak9vWmdWQzRHK1JjRXRn?=
 =?utf-8?B?eVV1N1ZodWVFa204WklxOTN4bm5Bb3gzUzZMTGJ6UUh3Z1JjdTg4Uzl5aDdu?=
 =?utf-8?B?VzNrOFBJYTlzY0d4SnJSSXZmSCtPMTVjZVRRcXZvSGdSSU82dWhBa2NKNXpT?=
 =?utf-8?B?V1Nvdm5CRnZTTVF4aUVLeisxbmV6bHI5NXlvdUxFTGtKdXBJSmZMc0NROTJ3?=
 =?utf-8?B?bFUvRlNBai9oVG1nYWRaYUVka3VSeWZHcGVDNHJJVUdNVW4vSndjUXlmYVZq?=
 =?utf-8?B?ekxsTXRzRmhzdFhwMXh3a2JQOHY1N3UrL1JIVC9INy85MmxGYS9QYlNFMW44?=
 =?utf-8?B?Y1JkWkJiQVR2dzJkYkNVRXdGV2VvNkpqbFNTb1hFVHVBQS9iWi9ucEVKcTZR?=
 =?utf-8?B?ZDRLaklJSmYzUkN1bFlRNENEWFlyeSt2V0J3RGJNRXdOYXpBZVY2ZTZMSFpU?=
 =?utf-8?Q?cye72AmpLV+ry3vn7XVGqjA2/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cbb4c7-f770-47f9-59cb-08de2b304167
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 08:05:38.8546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztoqci/a00c4nsUPXJCxvKWUH4Kp0TcUvoFdxkURLXuP0X0KrCAs6gE9vgxzJu4Oxl6uHghK/ybRuFTSOJ3P9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPiBTZW50OiAyMSBOb3ZlbWJlciAyMDI1IDE3OjU2DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gQ2M6IHFlbXUt
YXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gZXJpYy5hdWdlckByZWRo
YXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZQ0KPiA8amdn
QG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5jb207IE5h
dGhhbg0KPiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRp
YS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsN
Cj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0K
PiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyB5aS5s
LmxpdUBpbnRlbC5jb207DQo+IEtyaXNobmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMTcvMzNdIGh3L2FybS9zbW11djM6IEFkZCBzdXBwb3J0
IGZvciBwcm92aWRpbmcgYQ0KPiBkaXJlY3QgTVNJIGRvb3JiZWxsIEdQQQ0KPiANCg0KDQo+ID4g
PiA+ICsgICAgICAgIGlmIChvYmplY3RfcHJvcGVydHlfZmluZChPQkpFQ1QoZGV2KSwgImFjY2Vs
IikgJiYNCj4gPiA+ID4gKyAgICAgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9nZXRfYm9vbChPQkpF
Q1QoZGV2KSwgImFjY2VsIiwgJmVycm9yX2Fib3J0KSkgew0KPiA+ID4NCj4gPiA+IERvIHdlIG5l
ZWQgb2JqZWN0X3Byb3BlcnR5X2ZpbmQoKT8gQSBsYXRlciBwYXRjaCBzZWVtcyB0byBkcm9wIGl0
Lg0KPiA+ID4gUGVyaGFwcyB3ZSBzaG91bGRuJ3QgYWRkIGl0IGluIHRoZSBmaXJzdCBwbGFjZT8N
Cj4gPg0KPiA+IFdlIG5lZWQgdGhhdCBhdCB0aGlzIHN0YWdlIGFzIHdlIGhhdmVuJ3QgYWRkZWQg
dGhlICJhY2NlbCIgcHJvcGVydHkgeWV0DQo+ID4gYW5kIHRoYXQgd2lsbCBjYXVzZSAibWFrZSBj
aGVjayIgdGVzdHMgdG8gZmFpbCB3aXRob3V0IHRoYXQuDQo+ID4NCj4gPiBXZSByZW1vdmUgaXQg
b25jZSB3ZSBpbnRyb2R1Y2UgImFjY2VsIiBwcm9wZXJ0eSBsYXRlci4NCj4gDQo+IEhtbSwgSSBh
c3N1bWUgb2JqZWN0X3Byb3BlcnR5X2dldF9ib29sKCkgd291bGQgcmV0dXJuIGZhbHNlIHdoZW4N
Cj4gImFjY2VsIiBpcyBub3QgYXZhaWxhYmxlIHlldD8gTm8/DQoNCkl0IGlzIHRoZSBlcnJwIHRo
YXQgd2lsbCBiZSBzZXQgaWYgdGhlcmUgaXMgbm8gImFjY2VsIiBpcyBhdmFpbGFibGUgdGhhdCB3
aWxsIGZhaWwgdGhlDQp0ZXN0cy4gQW5vdGhlciB3YXkgdG8gYXZvaWQgb2JqZWN0X3Byb3BlcnR5
X2ZpbmQoKSBpcyB0byBwYXNzIE5VTEwgZm9yIGVycnAgaW4NCm9iamVjdF9wcm9wZXJ0eV9nZXRf
Ym9vbCgpLCBidXQgSSB0aGluayBhZ2FpbiB3aGVuIHdlIGludHJvZHVjZSAiYWNjZWwiIHdlIGhh
dmUNCmNoYW5nZSB0aGF0IGludG8gZWl0aGVyIGVycnAvZXJyb3JfYWJvcnQgaGVyZS4NCg0KSSBh
bSBub3Qgc3VyZSB0aGVyZSBpcyBhbnkgb3RoZXIgd2F5IHRvIGhhbmRsZSB0aGlzLg0KDQpUaGFu
a3MsDQpTaGFtZWVyDQoNCg==

