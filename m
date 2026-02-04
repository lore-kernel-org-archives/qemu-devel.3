Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76A2E83EE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8m-0005tt-U9; Wed, 04 Feb 2026 02:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZJ-0004cx-4Z; Wed, 04 Feb 2026 01:40:53 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZH-0004HE-CV; Wed, 04 Feb 2026 01:40:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTSmVDzLHDXUYKG8nek+bXIi7fU0SGCX+iZtrQMx+Hajst95wHaZAvbt7COml/GNJt1/2DvDMhzTRF0mIj4CRixPb2dTk1H2f+Dn+ZKPsx43r/CoeyTTLgT9RQRqpllTwix0PtrSpk6/Y6bq9l8puNHQcppBqvk5Mz50cNLG3JLhHf4coHeC3n/VFQmkZtWqCp7axnfj7zSThwlJ97Yit5lfAPt+qgrxk9K7WPjdRTU/2lBqWugQOPvNIQc2cBaKmaIXZ/vG4AbsTAmNsP6dT84gwGtZTXnAT0u6F9L3UchRN8VQhbO7RJY3ilsLsrJFt+wv4cCy+Vo8R8nGVRxetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBVQ+nInB2nFlM12b3P1k54X5DpCfozvQBl0/qyiGgM=;
 b=iM6tfA6injwcP8/p/s9tOx6y4mTaXGOA8qgtqGaXEgaG+ujrcwOqh/9Wd0VvQb4IPcKgRFI3rwQfSMV0ZIt3sCbMwcLIMgUVcJibiKZeFTTIAEPJFgAnwQRqWfOTyQ7qN9rsj+SalFt2eCvljWeyQe44uRtCpWqUaLrDP40rIi0QqV1s2+Xd/YqRSz2IKOPME8pJVqBYqPTlj6h0pSVDUkZTklfljFrtEmLT/vdmfbPcznmO/Si1aGBC7xvkvnwbQz88RQI4bnInC1Sj5hoYlFA/XGYoI09h+Z2jRgaBERipAKnzJmsJpwc+NxT4mC7blK3DKGI3B15hfhnJ8693pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBVQ+nInB2nFlM12b3P1k54X5DpCfozvQBl0/qyiGgM=;
 b=RyHfgKWvO6diET+r9jUHQD2yn32lDfZOmAuCHj7QnLW1s13dJyvrlRbDpnNDbRP+Z8a1zv4VmU2g4PpJukARq107qiIYZtaUvH75tzacgjltUd/f7ifLsxdaVUfKBA/vSZv5b9WhXeyWj3nHydTlMKK7boGYPRwi6ScBlPT8H2dwcxMwkCQaIFKES/PU7HGmc8BfyL/1Rv0s8VFSapn4yHfEx4qT+m2goqveFvQNVnmf6JH990Qeogk3R15I/wVd/kCOlqPdjkM5N5V+IuGdAyuvY6B4WBum0TiK/8tVx5q/0vZno076QgzVmZ4drC7YqTv/BIv/0YZGJizLj8BZ2Q==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TY2PPFD3DE53D05.apcprd06.prod.outlook.com (2603:1096:408::7ad) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Wed, 4 Feb
 2026 06:40:23 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:23 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 04/22] hw/arm/aspeed: Add AST1700 LTPI expander device model
Thread-Topic: [PATCH v6 04/22] hw/arm/aspeed: Add AST1700 LTPI expander device
 model
Thread-Index: AQHclaEjEXNruCtgZ06BhmINn14XmA==
Date: Wed, 4 Feb 2026 06:40:22 +0000
Message-ID: <20260204064016.3515639-5-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TY2PPFD3DE53D05:EE_
x-ms-office365-filtering-correlation-id: 6c04e751-b5fe-457d-55ac-08de63b845ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N296YlZiZEd4elo1MFNsRlo1KzlRMk8wbGswdFdYRWpkUmszZEsvaUU0d1Z2?=
 =?utf-8?B?YlAyUUYvckR6NHVabXp3NzZjSUF2S284dzZhZ0xEQUFjSUdNcW40OElHdkQ1?=
 =?utf-8?B?Vkd0S25VTDh5SUplWVBGU3ZIeVB2THNaUDBJRFhLVmh0WXVzUE1wcmdQR2hr?=
 =?utf-8?B?c2JBMU5ObE5VVWtwNHVjWEYzQjRBWVdPNDBEWTBnZ0NVQVVXNVUzQzN1OEVh?=
 =?utf-8?B?S1IxN2grYy9uMWhYTHJDRU85cDl6WGtOSkZ0L3lyeEp0T05YcnBoTzArM2c3?=
 =?utf-8?B?WmN1czJPaTRUbmh6T0NRZzlYUnRuclZjV0w4T3ZTTFFFRHl5d1VNV3VGQ3VX?=
 =?utf-8?B?SEMvbUNMOHlIZWFPMkgzc1E5NHpySUU0MnphdHgyV3hEaXNQdkJwaHM0Z2k0?=
 =?utf-8?B?cXJ2S01iK1BZZlZDblZrV3JZRVBCWGplWlZmZWlBZ3h0cDRubCtZKzVpTlRi?=
 =?utf-8?B?c1RoTkV1MW9WZnorNVJvb283Sk9Id0F0V3dHakJMaDJwRFZLNU45TjBybkx6?=
 =?utf-8?B?czJwZDdSU2lSR09RN0hIdlpVRFhXVWdTRjd2czRFR1NmUHJ6dGJsNjBkVDdD?=
 =?utf-8?B?WXI2RUR3blhIdytzdkwrbXN3dkY4UVkxd3lPNmJvcFI3TTlYWk1XMlAyT1Vj?=
 =?utf-8?B?cWhaUndQbitLV3hsbG9iSVhrMGZTNEd5bDFCVFNieWtseWtEYVlVUk1DZ21K?=
 =?utf-8?B?L3hnR1FjVHdUMU9XQm85YUg3VDFvekR4WjBRenlxM25taVFBcDhQTERXa0tY?=
 =?utf-8?B?cHlCazNkZDVkV05iVjR1blJXelM2QXpHVTJqNXc2WGxLUytJRlQyMEpRM1hx?=
 =?utf-8?B?SHZwbHdVaFVTMDEwSElBeTNTR3BRdmtMbFNOdUxYc291bUJ0dWh4QUsxVEdO?=
 =?utf-8?B?bzBqV0xxREs5emNleFVmdEFxdyttU2ZtaGFrRkFYdjM1V1ZwMjFMRG9iRWZL?=
 =?utf-8?B?UXdZY3ZPMFZjZ1dzdjhHWGcwbVpYT3puU051RFdhcjZjTXorR0grbWdwUlpX?=
 =?utf-8?B?S0FlN3RYYjUvQnlCMkRXak5nRmxnZWpuWW53cjlzbUhpcWVBcHlMR3o5Z3R2?=
 =?utf-8?B?Y0xJd29UcVBzQkxCL2QvUzhMd0p2cy9adlpNYVRuV3RMVGdMUm56dlFwU0F3?=
 =?utf-8?B?dlNUektHVHN6cU5xa2wza3pEdkxGdkJCVHZHcWsrUmtQUXNMRmFSK2lCcHls?=
 =?utf-8?B?NG1jc0pNSURRMVVKNS9naEVIUk0wS0lWdGlRYUl6ZStKeGI3NUs0V0tUZHk2?=
 =?utf-8?B?SXhNSUVaRHZDNEJucXFzdGRCbG8vWGlaK0dvNHZ6L2JuV1UwdlJtVER5a0or?=
 =?utf-8?B?NWlpUzBEdSswVzBGUkQ3OVlIRi9PNFlnaFFFb0pSUmRRZHhQN0VMbWNZUEpO?=
 =?utf-8?B?NzhTY0R0bTlaMkdieTFQaXVPNklCSHpPVmtoL2hlT3owUmRFZCtyakxvZFdF?=
 =?utf-8?B?cC9KcTVjdHdyRy94bk03K1o4a3ozV05tM0ZueHBwL3RZQm1RcFRaVmhoY0tk?=
 =?utf-8?B?RDhTb2YrM3ZLd29ZK2FCb2N2VVF0WlFCdUV2WFg5RlRwZkZxYkU0clU3RUli?=
 =?utf-8?B?WHlvcCtqdStZQW81TlR1b1hsRmduRVRJckhyemZsWU41cXVFaXAzK3hDMzZY?=
 =?utf-8?B?M2pPcFMyYm0vVWVpaVhDTXN5Q3BaeTNyNnVEWUV4OUtweVRuRkl2bDhOcEhC?=
 =?utf-8?B?cnVlNzB1emQzcEFUL3UrSit6VHR0QldtLzdxNVRoYmpsK3gyc2VUS2RMY081?=
 =?utf-8?B?Q2RPcVZCZ1h3eXJ2d1hwV0o4Z05OUTEyb0t6aVg3UW1hOU9vQ1JOY0pMTmVI?=
 =?utf-8?B?SFdVWWUyQXEvMlkzQnpvZVpIWmgvaGt1NFVSSUg3R1VhSzEvWldodEtaYkFQ?=
 =?utf-8?B?STNJZEhUKzIzSGQ1cWhIYjY0VzlSdGdZSXJhd0p1SmlLWm9Ub3BjWGtjM1Z3?=
 =?utf-8?B?Qk91TkU4ZXRIOEdRQXNRYU8ybyszSTg5ODYwdjBVeHF6YXkyY1oveW16TS9E?=
 =?utf-8?B?VjloT3Z1SHJXYi9mZmcyN2w4cmJDQVZvOGZFRG5XV25pbklncy9wZkVkK1gr?=
 =?utf-8?B?TDR0SExXUnh1UFpRTXI2TjV0WGNUQWMyTFJhekc2NS8xT21mcElmTTJjdFJ2?=
 =?utf-8?B?TDdqUlFJL3JtYitacjFvRWhJbWgzalErdE80L2FjTURnNlQ1WGliSk1IVXE5?=
 =?utf-8?Q?gRjbVqFSmSpwt/Hs/ANpks0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3JsbTR5OFE5V3BTeE1NazNEZDBsOTR6MmZQMTJ0NDVlb1hlRHl6alV3WWMr?=
 =?utf-8?B?VHJkeER3czF1eHArSk1nNElZRzRBYmJYL3g3RDdQNStld2ZMeEo4T2VJc1J3?=
 =?utf-8?B?cTRNM1dTejdIWTluWFlVTHlYSXlSQklXSktSTUNRMVVPa21NV2J2dDg0ZUcw?=
 =?utf-8?B?ZzJRUTRJanpRSWY1QUNzK1ppbGloZjJyd2g5NmNXZlNZUVRVSlc3eWEwWC92?=
 =?utf-8?B?Tk1DYnR5M0t6Zjd3cEhucEdGWVMwbVhjbXZsQU5mczVnTSthakgwalZlWWkw?=
 =?utf-8?B?dTk1QW52TjRUYk1wTWdwNVZHdW94ZzdEdXl2V3o4YXM3VW9zYXdKR2NjYy8w?=
 =?utf-8?B?RWVRbmtmTW4zNWVoOW5rR3IzUTNxL2cvVTVYR1BDYzE5TmptNEU2NmREQmIv?=
 =?utf-8?B?QzZ5UFZFQ1l3K2RPeGV5UjF4RnJ5ODVZUmF4WXhLeE43M1pEeWJaOWJNTWhX?=
 =?utf-8?B?OXFqeE9rZHNhb01MTWFVYzNzSmp5NVNZWmJLN2V0THlQeTBwL21VcFM5T040?=
 =?utf-8?B?Q3hPa29NY25jdXI0SlRhMDhDS0VmK2ExdEJ1Vk1NcXFZS1JZVHNSVEJVWXJY?=
 =?utf-8?B?S1ZCdUNsenFNUzZvSy9KYjhmMlpubUJuMkl4dzArYmJjVUVnaXkvbGZPVk43?=
 =?utf-8?B?Qzl6VWg5d2VOTlc3ekxaK1MveExScFdNQnFNS0MvSFdLZzdlem9qSUl5ZGlj?=
 =?utf-8?B?azRtcUhKOWpPMC9zaWdkMSsrRDY0bmw2d3IxamNtaVpmQURZWmJXOFNOQnpq?=
 =?utf-8?B?ZlFRMG1zS1ZGQlk4VTN5SWp2dWQ5eVJqbWNOY0MzcGpUUjBDalRPQ09MTUpm?=
 =?utf-8?B?aU5UQy9LMk53Zyttb0dybHRKNzRDamN5L3Y4bTZGL2JVNFVvaWVSdG9Vamhs?=
 =?utf-8?B?T2pOVHVRSjhVY2x1ZlNORk9zdUdsV0lWTTB3L2t1aDRMbC9KT1NzWlZtSmhH?=
 =?utf-8?B?OTJYUUEwa2UyN1diOW5ueG1kdmJ5MUYwV0QvdjMzTGFhTlYvKytTQVVaWkFV?=
 =?utf-8?B?RkJvM05vR2JPU1hjYzhHbVdrZlMxVzhaZnk5enJXVmhKZVB6bThvUXJYOE9E?=
 =?utf-8?B?R2tSL2lPVkF3NlFMWUlBZUYzR3BMekdxTVY4ME9QTmQ1cmNXU2pCZTZ2ZnVE?=
 =?utf-8?B?bld5dWIzTEQydC9KTkFaZ0Q2aWk5VDV1ZHJ2V2lObEhMOVpEVWQ2N0daTEpm?=
 =?utf-8?B?aHB6MHdlSm1UYWhNMWRDNndQeTFKemNqd1UzczhOVkxxclRXdVR5Vk85NzhZ?=
 =?utf-8?B?bTVNMHVPT3ErWFVYdmVpekF1RmFkUDFmUmNVaEJwSXlMemNJMG9WaFlFREo5?=
 =?utf-8?B?cGkzcm5VajdLamtGcXMrbXh1S1lBU0plMTFGVGdlOXd2UldsaTZzOEd6dU1p?=
 =?utf-8?B?Rmp4WVN4WktmNlRzclJYMnNvRGljZEZCcU1LTER0QktEWXMyUnFaWml5Kzkz?=
 =?utf-8?B?ako3MGcxSjJEUjVhdHEzZXVvN1FCVXNUMmY1azVTbHZaYVpPZzFzdEo4SHlp?=
 =?utf-8?B?NXg1cDJUWGppejhUQncrdWZNNWtHTEtHbXRWdmhVQ2hTVFFRc1BoRGcrUWVq?=
 =?utf-8?B?L3pBQ2s2ZlFxbXRUTUdZRWtPTmRzbzBWYllvaDZaa2VMK3FybENhUUNYSjdU?=
 =?utf-8?B?ZHNYRytpWERlWWlFZ2V2MUw0aHAzRGNqTDh0RnU4WlhNbjIzeXRpSG43c2U0?=
 =?utf-8?B?TDExK0NIY1lEQzNIVUR5UlpoYldSSGg3WmZZc2Z2SXVrSGpDMlE2NW9GelA2?=
 =?utf-8?B?SXNsUS8vL1JrUm5naXFDYmVhekxkd3M2cDU5VTBGTEVzZCthc2d2TlFVeTRG?=
 =?utf-8?B?RzRsNHRwempXa0M0NmJDcEZqSkFlSyt4SE5NbXgwODBOTFA2OEpBTjQ0MzJo?=
 =?utf-8?B?aHBTV3h0WXZSRmU2WnpDblRpN2xGUmhwQUlQUUUrTUdMSUtpTndOM2FRWFVq?=
 =?utf-8?B?TTNObVRvV3l1R2JSdjEzWlZudjhGS1dhVHlzaTEvVHBJYXJwWEFtcjZ0ZHZk?=
 =?utf-8?B?cC9pbC90OU9La3N5QVdFaUU1V2tBcFZxYkpqdVZoVHlsVEVhWC9ndU9reU1v?=
 =?utf-8?B?aTcwaHJacHZ1Rkc4MXRtZitTTTJnNEJWU2RnMDhPenNIZDRQTklpN3ZWM0Vr?=
 =?utf-8?B?RTFIaGVLSThuVFkwOS9oU2xUM05GRis2alZ1Tzl5V3Y2RFhGa2czRXB5S096?=
 =?utf-8?B?emdMUTIyRzZaWkxsZDBmbmNJb1NZc25LWGZYRk11K2Fsb1E2L3lJMDJMZ2Vv?=
 =?utf-8?B?bGhWbXlBU3ViaGphSnBmZjJXUGRtNGlTOThMM3oyWllVaDlzUGZiUjBsRHdi?=
 =?utf-8?B?R0tqSzdnM2FXUkZ6TGVzUHdLcm5HRUFnK0lkOGlEV25oaXNjTEszQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c04e751-b5fe-457d-55ac-08de63b845ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:22.9467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3z+3WAGO+1aDWXeOoQ6ZrKIPLmZeIlMqaR5azBYnSyrjZb84tEz6KE2MbSPjf8J94h0zC+xUxMn8JZtO5UCRcwWhq8fvY4tP8IwEzjfUYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFD3DE53D05
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:21 -0500
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

SW50cm9kdWNlIGEgbWluaW1hbCBRRU1VIGRldmljZSBtb2RlbCBmb3IgdGhlIEFTUEVFRCBBU1Qx
NzAwLCBhbgpNQ1UtbGVzcyBJL08gZXhwYW5kZXIgdXNlZCBpbiB0aGUgTFRQSSB0b3BvbG9neSBk
ZWZpbmVkIGJ5IHRoZQpEQy1TQ00gMi4wIHNwZWNpZmljYXRpb24gKHNlZSBmaWd1cmUgMik6Cmh0
dHBzOi8vd3d3Lm9wZW5jb21wdXRlLm9yZy9kb2N1bWVudHMvb2NwLWRjLXNjbS0yLTAtbHRwaS12
ZXItMS0wLXBkZgoKVGhpcyBpbml0aWFsIGltcGxlbWVudGF0aW9uIGluY2x1ZGVzOgoKKiBEZWZp
bml0aW9uIG9mIGFzcGVlZC5hc3QxNzAwIGFzIGEgU3lzQnVzRGV2aWNlCgoqIFNldHVwIG9mIGEg
YmFzaWMgbWVtb3J5IHJlZ2lvbiB0byByZXNlcnZlIEkvTyBzcGFjZSBmb3IgZnV0dXJlCiAgcGVy
aXBoZXJhbCBtb2RlbGluZwoKVGhpcyBzdHViIGVzdGFibGlzaGVzIHRoZSBmb3VuZGF0aW9uIGZv
ciBMVFBJLXJlbGF0ZWQgZGV2aWNlIGVtdWxhdGlvbiwKd2l0aG91dCBpbXBsZW1lbnRpbmcgYW55
IGZ1bmN0aW9uYWwgcGVyaXBoZXJhbHMgYXQgdGhpcyBzdGFnZS4KClNpZ25lZC1vZmYtYnk6IEth
bmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPgpSZXZpZXdlZC1ieTogQ++/vWRy
aWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IE5hYmloIEVzdGVmYW4g
PG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPgpUZXN0ZWQtYnk6IE5hYmloIEVzdGVmYW4gPG5hYmlo
ZXN0ZWZhbkBnb29nbGUuY29tPgotLS0KIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmgg
fCAyMyArKysrKysrKysrKysrKysrKwogaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMgICAgICAgICB8
IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogaHcvYXJtL21lc29uLmJ1aWxk
ICAgICAgICAgICAgICB8ICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmgKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9hcm0vYXNwZWVkX2FzdDE3MDAuYwoKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmggYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcw
MC5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAuLjM3OGRjYjQzN2EKLS0t
IC9kZXYvbnVsbAorKysgYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oCkBAIC0wLDAg
KzEsMjMgQEAKKy8qCisgKiBBU1BFRUQgQVNUMTcwMCBJTyBFeHBhbmRlcgorICoKKyAqIENvcHly
aWdodCAoQykgMjAyNSBBU1BFRUQgVGVjaG5vbG9neSBJbmMuCisgKgorICogU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKyAqLworI2lmbmRlZiBBU1BFRURfQVNUMTcw
MF9ICisjZGVmaW5lIEFTUEVFRF9BU1QxNzAwX0gKKworI2luY2x1ZGUgImh3L2NvcmUvc3lzYnVz
LmgiCisKKyNkZWZpbmUgVFlQRV9BU1BFRURfQVNUMTcwMCAiYXNwZWVkLmFzdDE3MDAiCisKK09C
SkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEFzcGVlZEFTVDE3MDBTb0NTdGF0ZSwgQVNQRUVEX0FT
VDE3MDApCisKK3N0cnVjdCBBc3BlZWRBU1QxNzAwU29DU3RhdGUgeworICAgIFN5c0J1c0Rldmlj
ZSBwYXJlbnRfb2JqOworCisgICAgTWVtb3J5UmVnaW9uIGlvbWVtOworfTsKKworI2VuZGlmIC8q
IEFTUEVFRF9BU1QxNzAwX0ggKi8KZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5j
IGIvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMC4uZGQzOGI4MTliOAotLS0gL2Rldi9udWxsCisrKyBiL2h3L2FybS9hc3BlZWRfYXN0
MTcwMC5jCkBAIC0wLDAgKzEsNDYgQEAKKy8qCisgKiBBU1BFRUQgQVNUMTcwMCBJTyBFeHBhbmRl
cgorICoKKyAqIENvcHlyaWdodCAoQykgMjAyNSBBU1BFRUQgVGVjaG5vbG9neSBJbmMuCisgKgor
ICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKyAqLworCisjaW5j
bHVkZSAicWVtdS9vc2RlcC5oIgorI2luY2x1ZGUgImh3L2NvcmUvYm9hcmRzLmgiCisjaW5jbHVk
ZSAicW9tL29iamVjdC5oIgorI2luY2x1ZGUgImh3L2FybS9hc3BlZWRfYXN0MTcwMC5oIgorCisj
ZGVmaW5lIEFTVDI3MDBfU09DX0xUUElfU0laRSAgICAgICAgMHgwMTAwMDAwMAorCitzdGF0aWMg
dm9pZCBhc3BlZWRfYXN0MTcwMF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJy
cCkKK3sKKyAgICBBc3BlZWRBU1QxNzAwU29DU3RhdGUgKnMgPSBBU1BFRURfQVNUMTcwMChkZXYp
OworICAgIFN5c0J1c0RldmljZSAqc2JkID0gU1lTX0JVU19ERVZJQ0UoZGV2KTsKKworICAgIC8q
IE9jY3VweSBtZW1vcnkgc3BhY2UgZm9yIGFsbCBjb250cm9sbGVycyBpbiBBU1QxNzAwICovCisg
ICAgbWVtb3J5X3JlZ2lvbl9pbml0KCZzLT5pb21lbSwgT0JKRUNUKHMpLCBUWVBFX0FTUEVFRF9B
U1QxNzAwLAorICAgICAgICAgICAgICAgICAgICAgICBBU1QyNzAwX1NPQ19MVFBJX1NJWkUpOwor
ICAgIHN5c2J1c19pbml0X21taW8oc2JkLCAmcy0+aW9tZW0pOworfQorCitzdGF0aWMgdm9pZCBh
c3BlZWRfYXN0MTcwMF9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgY29uc3Qgdm9pZCAq
ZGF0YSkKK3sKKyAgICBEZXZpY2VDbGFzcyAqZGMgPSBERVZJQ0VfQ0xBU1Moa2xhc3MpOworCisg
ICAgZGMtPnJlYWxpemUgPSBhc3BlZWRfYXN0MTcwMF9yZWFsaXplOworfQorCitzdGF0aWMgY29u
c3QgVHlwZUluZm8gYXNwZWVkX2FzdDE3MDBfaW5mbyA9IHsKKyAgICAubmFtZSAgICAgICAgICA9
IFRZUEVfQVNQRUVEX0FTVDE3MDAsCisgICAgLnBhcmVudCAgICAgICAgPSBUWVBFX1NZU19CVVNf
REVWSUNFLAorICAgIC5pbnN0YW5jZV9zaXplID0gc2l6ZW9mKEFzcGVlZEFTVDE3MDBTb0NTdGF0
ZSksCisgICAgLmNsYXNzX2luaXQgICAgPSBhc3BlZWRfYXN0MTcwMF9jbGFzc19pbml0LAorfTsK
Kworc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBfcmVnaXN0ZXJfdHlwZXModm9pZCkKK3sKKyAg
ICB0eXBlX3JlZ2lzdGVyX3N0YXRpYygmYXNwZWVkX2FzdDE3MDBfaW5mbyk7Cit9CisKK3R5cGVf
aW5pdChhc3BlZWRfYXN0MTcwMF9yZWdpc3Rlcl90eXBlcyk7CmRpZmYgLS1naXQgYS9ody9hcm0v
bWVzb24uYnVpbGQgYi9ody9hcm0vbWVzb24uYnVpbGQKaW5kZXggYzI1MDQ4N2U2NC4uNDdjZGM1
MWQxMyAxMDA2NDQKLS0tIGEvaHcvYXJtL21lc29uLmJ1aWxkCisrKyBiL2h3L2FybS9tZXNvbi5i
dWlsZApAQCAtNzAsNiArNzAsNyBAQCBhcm1fc3MuYWRkKHdoZW46ICdDT05GSUdfQVNQRUVEX1NP
QycsIGlmX3RydWU6IGZpbGVzKAogICAnYXNwZWVkX2FzdDEweDBfZXZiLmMnLAogICAnZmJ5MzUu
YycpKQogYXJtX2NvbW1vbl9zcy5hZGQod2hlbjogWydDT05GSUdfQVNQRUVEX1NPQycsICdUQVJH
RVRfQUFSQ0g2NCddLCBpZl90cnVlOiBmaWxlcygKKyAgJ2FzcGVlZF9hc3QxNzAwLmMnLAogICAn
YXNwZWVkX2FzdDI3eDAuYycsCiAgICdhc3BlZWRfYXN0Mjd4MF9ldmIuYycsCiAgICdhc3BlZWRf
YXN0Mjd4MC1mYy5jJywKLS0gCjIuNDMuMAo=

