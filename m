Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB93CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJwI-00084j-2F; Fri, 07 Nov 2025 05:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vHJwG-00084a-O7
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 05:43:28 -0500
Received: from mail-northeuropeazon11022141.outbound.protection.outlook.com
 ([52.101.66.141] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vHJwE-0002bJ-Va
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 05:43:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1PnBY9wYejiAqSkqd3rstFgWN/qQWkVwRpUOCQ2MZwPMpZnBTTwQN5FB5gNS/zWPaUSnI+5TYr4kFbB0/WdAJh+J4BXFeHnE5tSQtMOh0qJPNppoNtzPOQbn9Q+61uig5tOzLaMtZKooCch4jAW4+ebTepwLJkqlOIxOtkjg3DHxTy7eMZUQK/14pVQUMQ/J19mFSEqIJmn0kzI56KU2O95GlC+gB/oi6+tJI6VGTwED18ejJ14fLnPR31GOX+Sp4VbyMIIQWwXgMEoFIOZ4tC0qdoQGhNRP2rxlyYpnq15Tzik8fzGnuWD+bW8Qy2yGqCDq6QiNPkESvkO/vUlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKYRRJu5+/T7Jjmm2y+99ozojc0vpgWeUSLSXdnz4Q0=;
 b=DaDD+bmWejFf/saUe00TOYvaQTAGWU5VaC7lvxsG4yzvw5mHFM21yPbZvMa0FATTfs4zH6peAfRdjocJR8VIaxjhOre1ffUlSYoQ0b/6T9iuO0jza9MlpbQG1syvy9K2I0YeZDkYxQCs0BelGQesSCrIFui3gA34wkYa9E18hRUEBGVBwiNSQXU+oGFqf98Ja6yOaLrpuoTJ1D9svuOr57p+UkL51DkdLxe7L7l7SsZlBSpwmSis5yQ+NkyQBjmvLOWYEJk2YIp2JgsFJ74GZSBhIHTg2VmhSNmKjOWj3WuwNTG6vTwEZ6I55D7BqZ6Xna0facX/Sr9qjzxs1izlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKYRRJu5+/T7Jjmm2y+99ozojc0vpgWeUSLSXdnz4Q0=;
 b=tlnY10Ph57mwXRy8hZMG1kIpkzQ6cWkLmPfxELO/bKWIIXapGXt5nyQciDroE32rPaNP8xhwY9brOfOj+vxsLZkjtkkmOZtP9CEn70haxX3PIxrz52rs7vOHM45PRt6hf9dX9W9tAxxlqXXl5vmoxo0hsyd/SkFsN6YJYjBBehrsc9YnfjSXEz6E3hyG5BI71DmgsNOClb7e/AkDOLWjWHyVaVLDtC8++FUIxu9QBYz5S0XiBtxlojkUDa8Ka2mRvo5uT0U0/Vw+jzCQvEkdEYSM6HXjs4tTM721l1lDZwy63zdz9WrJg7Z7Tn0aOXhOPjX0utIxFkkZb6RLvdVN6g==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB6974.eurprd09.prod.outlook.com (2603:10a6:150:1b1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:38:20 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 10:38:20 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Alistair Francis <alistair23@gmail.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anton Johansson
 <anjo@rev.ng>, Chao-ying Fu <cfu@mips.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 26/37] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PULL 26/37] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHcQ9aCrPxcRvvKbE+e1rjbmM0eMLTj8myAgAJnOgCAAMO4BQ==
Date: Fri, 7 Nov 2025 10:38:19 +0000
Message-ID: <AS4PR09MB65189795ABA07F3C7D421D94F7C3A@AS4PR09MB6518.eurprd09.prod.outlook.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
 <20251023043520.1777130-5-alistair.francis@wdc.com>
 <a8e88aaa-02ef-406e-9737-bbe017e420d3@linaro.org>
 <CAKmqyKPEg6tpyxfZK7z+nsM-wYUiuzr8i7D2jZOQWmrxnNfwNQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPEg6tpyxfZK7z+nsM-wYUiuzr8i7D2jZOQWmrxnNfwNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ac629de7-cfdf-49f2-9483-80ca02e7fb52_Enabled=True;
 MSIP_Label_ac629de7-cfdf-49f2-9483-80ca02e7fb52_SiteId=9f85665b-7efd-4776-9dfe-b6bfda2565ee;
 MSIP_Label_ac629de7-cfdf-49f2-9483-80ca02e7fb52_SetDate=2025-11-07T10:38:19.449Z;
 MSIP_Label_ac629de7-cfdf-49f2-9483-80ca02e7fb52_Name=Proprietary;
 MSIP_Label_ac629de7-cfdf-49f2-9483-80ca02e7fb52_ContentBits=1;
 MSIP_Label_ac629de7-cfdf-49f2-9483-80ca02e7fb52_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GVXPR09MB6974:EE_
x-ms-office365-filtering-correlation-id: f88a766d-d035-4a7a-3303-08de1de9c4d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?MTUzeDRUT0xxK3Qxc2UxWm9VaThKdFkxVEZOSEh5a2o1blNNMG1tS2oyZ211?=
 =?utf-8?B?OXQyWTlrMTBIMFhONFhuaGJXK2xlbGdUKzFGcFlmM3phWUIvWHBiL0ZYTDFx?=
 =?utf-8?B?ZmQyQ0E4S0t6Q3loRHJITkpsSnVXWHdBUUJlLzdZOTJPNGw2SXdERitVekx6?=
 =?utf-8?B?Q01ZTkZLVFdVK1ErVDZhenBKVzE1NTVxTllYb3VhSGhkOXpVM3RPaEMyYS9t?=
 =?utf-8?B?SiswMGRINEhTd1pobHgwWHZRTFl5V01FL1dvZkExcHhUNWQrYjZlNzcyN0Z2?=
 =?utf-8?B?cnp4b1QzelpPY0xQNGtqRWpYQVZEVWsxZ0poa0hteTBzQ2h6YmVBQWVPQUVD?=
 =?utf-8?B?bThYcjkyelo5N3AyRUwwM1BKVDhWb3Jpb2FzRGVQNDBuem02ajlhZktRenZQ?=
 =?utf-8?B?ZTdFZlEydTdVT0E3azd0VFNGcGNoTXd5L2lGWHNGTDY3K0xFNlB2REIyUVhJ?=
 =?utf-8?B?TERudGhWb0RobmtTQllkRElqUlVmcGIwZHFJdi9xcTNEcmJJSFJaZXo5ekoy?=
 =?utf-8?B?WTRibFZuRWdNZjJZc1RGU1FJUG9tbUdBVFZaQXJvdGdicmR0N0lCb0ptZlho?=
 =?utf-8?B?NEI3RUFSeS8wOTBCbDZ3M00wRkRTNjNZZVlNc3ZjMHR1U0Vka0g3a25NaXpF?=
 =?utf-8?B?MXYwdE9FdVhtYTBzRnhoYWc2aU5VMit3aEcrOXU3TVl4S2J4VS9kYTlRSytY?=
 =?utf-8?B?VnRjSUtGM0poSjk2T0c0enVzdVY4L2hNVGx0YzRJT1pRMVdCYVlFaUZKTFBC?=
 =?utf-8?B?VjFlbEJveE94SHY2VGJ2QnRRRkRJS0Z0bGM0b3lZRUY5Sm42U2VHbDJHZUhR?=
 =?utf-8?B?YWdLYTZKTWJKbGxkajNBam83Z0pFMXpFNHpmMFJpZG5jeDZGc2s2ZFplbWRX?=
 =?utf-8?B?NmRMSzBzNHlsRDhjWnVIS1R2RVMrMnVHbExQYzQxVG9qZ3htb0tnMDJadWlp?=
 =?utf-8?B?TFFDTjFrcnVzVk1jeGIzVkJsbmdaeDdDOW0va0tjOEZTMktOdU9LWWV6SzBl?=
 =?utf-8?B?ZHNjODVsOVRCMjNFVVNIZWF3cUVNY05GaEdSLzVCQkpQWVE0dTFuT0NqSFVC?=
 =?utf-8?B?cVVVeFhkZmhVWUNack9ydXRUZCs1RVU4bDgwUEdSa29QTTlLS0doSkFUS2ZC?=
 =?utf-8?B?VW04bW4xMVVsUThVdFZYVWszUUtvNjJrelgvb3p1c2lpaHpXNDJWa25pMHIy?=
 =?utf-8?B?NktxcjdFSGRjR2IraEIxN1k0Zi8xMG0rTUZoc3hwSktmVXhsblhWU3hpSU5P?=
 =?utf-8?B?Uy94dVFyWXdVNk8xQ1UzMml6TENUbVd0RjAzRXprZC9BY3BXSGlWYk5DNGlo?=
 =?utf-8?B?Zy9XVVZqQ1JLbUYvSENKOUk1T1ZBZzN4R29qZkgyWG52OEEyUEkrbnErQXQx?=
 =?utf-8?B?amd3R2h0cVF4ZnFHUFB2ZnJORHlvWW52WDlxVGpXeVZaMkVOeFlxemhTOEZM?=
 =?utf-8?B?V2I1VDJSWURoYkpYdElyWUptRTJVSFdOVlA3a3l2UVRxWkpva1JYZFM2YVQr?=
 =?utf-8?B?TXdlenBpNEdUYXF3L2RrU2RWdlBTU1l6VzlJZ0p4U2tZMytSTWFTVFcycG82?=
 =?utf-8?B?R0J5R05YempDa2xxZ0tUVWMvekRhczBNKy9oWTUwL3VBb1doS0hiRVRlOXFj?=
 =?utf-8?B?eUhIRDBzcDh3TlBYV240MWl2Qi9aTFNoWXN4ZVdlQ24rMEwxcng1ejZYUDVv?=
 =?utf-8?B?dGptWTdtRnhlaGpIY1V2eklSb2xPdGxrYzYxdnFCeTNtNFJjRDdiRDZNc0dC?=
 =?utf-8?B?dkFJNjhSWDZLdjdYNWNLS3NYSW1QTzVMQ3lLaUJ0eWhtdTFTYkh3cWoramts?=
 =?utf-8?B?bmdLM0VFejJ6MFY4TGs4dkZ5YXZHR0oySTlZbDdNaWI0N3NvQUtKdm9udWFX?=
 =?utf-8?B?WVp4Um8zVnNBVlBVY0hyNUJEOEQyZTU4b2RvcTNYbURPOVFGWTVBeGxkOWxG?=
 =?utf-8?B?WXdyZHBKVFJvanhETGZ0S0JWa2ZNOGVqRHAxd0lISHoyQVlCU0FDcmRkNExy?=
 =?utf-8?B?cE9ySXkwSHpzZE9UU3lCUHU2ZURQSE9ha0VYMldBZTU3akNFN2NWSjFnTm01?=
 =?utf-8?Q?YSj4Ar?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm41WEF2YzRROWdTang2SHBPTGJ2aDA5RmdTOTlGdGVKN0hNa25LZDBqYk40?=
 =?utf-8?B?UjRINGtTZ3d2VWcvUmhJa1NwYm52V1VUbWp3ZVFVNERjY1JLZWhOUzEvRG9D?=
 =?utf-8?B?cG5WY0t1Rk1yTVNOTHVORGVIczh3K1E4dHlQN29lejdEcjdrMy9Vb2NhWndq?=
 =?utf-8?B?RmVyV1RRR2hYU2EwbENvZ0pjY3JKaW1BTnc0VE52K2UyN3JQOEorRlAxQ1Zu?=
 =?utf-8?B?c1NKN0J5eGhtUnZnTnJWNU1jWDJNZmZJSjhOVVlvRFk4YnpDS2MxUzM2VjVl?=
 =?utf-8?B?cUN3V1RTNGYzTVFuRDVJMXFEdWFEa24yMXNKSXV0Rk01MWtNSVlTNG9yNERW?=
 =?utf-8?B?WDRHaUN2RnNFYjFMV2pwWDdEUjBqMmpUYm5wem1HZXVBVkZ1U0IwcWNRTE5p?=
 =?utf-8?B?UUVidTFGRldkVGJjZGJPRjF3UHRRNzNTK0VwSGJab3haaUlkRlM5Q1ZXdmpi?=
 =?utf-8?B?Q3NGVGJjbTFTVWM4YnV6Wi9EVUJESTluVGJXRXAzaVV2TnpWMnM2MGlKTEln?=
 =?utf-8?B?blVMNi9mc0xSbzl4bmZ4dmtTQVQ3bE02TldYd2gzclprSzI5SjZ4dkE3VXN0?=
 =?utf-8?B?QkllZjIzYVcrZDJRc3lIdWc0QXF4WGVxdlFLcVdldDBGdElYQWxjb1dNQjll?=
 =?utf-8?B?NHVJZXhYdnVZNGgrbW5hSXNRWGZuVWY1L1NDeHdrYWZ5a0U2Rndadi9wZzJY?=
 =?utf-8?B?QzN0RWlQT0VJS2xCRDA2eGhkVGQ3ZUt5Q1pvdWEvRUdKTTRrSWdmb0dsRzdC?=
 =?utf-8?B?dU81dWJFVXFhQVFqOEViQmtvT2lrcHZUNFpicWNaMjhuV2h2YStJSWNzODU0?=
 =?utf-8?B?SUo2TUdVaEpzK2JMdVJSMXE4SWk2OW9EUkh2TVUxb3NaYkg3aGdSQ3hJZWUy?=
 =?utf-8?B?MUtLTHhSMGFOd2JiRW1ZYUdUU01VMFgwbWVndXNialN2Qm1DeDVKZDN2bUFL?=
 =?utf-8?B?UjRValM2RnpXOCtLWHBHK1Fpd0h2ZGNFTnNFN3d0eG5LNmZydHB0Q2RwVWdy?=
 =?utf-8?B?QTZPOUNJT1pLdnE3SEdzVEhocjllaFpJV2d2aWNuZEc0RUZQRXlsUHdhT1Ix?=
 =?utf-8?B?OFdqMlJlcTJkRTVqcE8yUGtBTnU1THNuQkxqcm9lcDAyZEV2QVgrS1YvNFB4?=
 =?utf-8?B?QTl3RERYYlpuUXg1WmhEUEo4d0xpUUIwaEY0MTNLT08xUU5nOXFHVmxiS1RC?=
 =?utf-8?B?TW1TWGxHSEtTS2xidDVCcGlKeWNnaXdkT0t4cmJhRUZ0WGRjSXEvTjRHa29Q?=
 =?utf-8?B?VHF0c3JxSEFlcnFMVHdDTEJjQU1aTklURThWZnV3WXBWWjd1eHdFMU9TYmtL?=
 =?utf-8?B?bUhLM2VEY2tCVEZYY3ovcURvVkFHaGM2ZGI4OHUxZmM5NnVGMkxGcDZ5RVFo?=
 =?utf-8?B?RFVvQTJyd0QzSHJ1QTJLUzlkMHVzTk1HL2hvTjdSZzJ4SHNJaHpubDlNSlJR?=
 =?utf-8?B?eXlRWElWSFFkcDhLLzhlWmUwSDlWVVlvSVR2SWxXam5DMHovNmFqMW8zZGhk?=
 =?utf-8?B?a2ZnaXpRVVVRNi9UL25uNWI2NGkyYlh2a3pHUkJGalpGQjc3SGJLZ0hDNHlo?=
 =?utf-8?B?emhIWVNvOUllZFNBWjRIUGZXTEtEbGszV0l1SjJ5K3NaWXB3akNUemV4RUp0?=
 =?utf-8?B?YlJPVWkvSXdkbndZUktBZDdZcFBOWlFRVU9sQ0ZuaTJEdytFenRGcEJwV2VW?=
 =?utf-8?B?SWtmby9rcEl1T0NLa2hEb2UzekVlZ2FSeE5tdkYyZ1lyWmRwTmhYSG9BdEZl?=
 =?utf-8?B?TmlqMEQydG5DT3FTNFdHcGkzOHJzRERyVVRmeWJtOFNMVS8rbU8zdmVvcVhW?=
 =?utf-8?B?akt5eFhxdml2TDA1TDl1SndHN1dLTUlRVERkM3RoK3V5Y0VObzF3dEJNYWli?=
 =?utf-8?B?OVRCL3czUzNraExNS0orSGo0WXg1WUI5OUNHVkR0bzJIdjZicHMzdXg3Qmpt?=
 =?utf-8?B?c3Z6bmJrcCttMk8wRHhteUR4NXNuZTU4TVFOWHROdHloL3B1cHNaRjRDQXJC?=
 =?utf-8?B?WHQ4N25qYVN6SXRadGhCRUtOcnBEdmo0Q3kzeDU4OHd2SkhqU2lCUXhFRmNu?=
 =?utf-8?B?NlVwN2RTYTBSV2ErWGVPb1JwbzVkNGJOcGl5TksvMEZJajFZNjQvVU9RZUtz?=
 =?utf-8?B?UjR0aGcreExhOHQ2SUdNcGdKaWo0ekNWNjNjN1RXZ3NWWElEa1pDSE10UUdk?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88a766d-d035-4a7a-3303-08de1de9c4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 10:38:19.9410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehKSeiwYW5IR/fYf02ABUMWapHS78NHUfBdald/Cwn+jFNIPz45kpmpW/Y9wvn0WdS5FsNc54dvG11NGdrLrzjZDBPvRYb796/GVOVRACbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6974
Received-SPF: pass client-ip=52.101.66.141;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGksCgo+IFRoaXMgcGF0Y2ggd2FzIGRyb3BwZWQgaW4gdGhlIHYyIHB1bGwgcmVxdWVzdCwgQERq
b3JkamUgY2FuIHlvdSBmaXgKPiB0aGlzIGluIHRoZSBuZXh0IHBhdGNoIHN1Ym1pc3Npb24KClll
cywgc3VyZS4KClRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzIQpEam9yZGplCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyb206wqBBbGlzdGFpciBGcmFuY2lzIDxhbGlz
dGFpcjIzQGdtYWlsLmNvbT4KU2VudDrCoFRodXJzZGF5LCBOb3ZlbWJlciA2LCAyMDI1IDExOjU3
IFBNClRvOsKgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPgpDYzrC
oHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgQW50b24gSm9o
YW5zc29uIDxhbmpvQHJldi5uZz47IERqb3JkamUgVG9kb3JvdmljIDxEam9yZGplLlRvZG9yb3Zp
Y0BodGVjZ3JvdXAuY29tPjsgQ2hhby15aW5nIEZ1IDxjZnVAbWlwcy5jb20+OyBEYW5pZWwgSGVu
cmlxdWUgQmFyYm96YSA8ZGJhcmJvemFAdmVudGFuYW1pY3JvLmNvbT47IEFsaXN0YWlyIEZyYW5j
aXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4KU3ViamVjdDrCoFJlOiBbUFVMTCAyNi8zN10g
aHcvbWlzYzogQWRkIFJJU0MtViBDTUdDUiBkZXZpY2UgaW1wbGVtZW50YXRpb24KwqAKQ0FVVElP
TjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9u
LiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29n
bml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuCgoKT24gV2VkLCBO
b3YgNSwgMjAyNSBhdCA4OjE14oCvUE0gUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBs
aW5hcm8ub3JnPiB3cm90ZToKPgo+IE9uIDIzLzEwLzI1IDA2OjM1LCBhbGlzdGFpcjIzQGdtYWls
LmNvbSB3cm90ZToKPiA+IEZyb206IERqb3JkamUgVG9kb3JvdmljIDxEam9yZGplLlRvZG9yb3Zp
Y0BodGVjZ3JvdXAuY29tPgo+ID4KPiA+IEFkZCBSSVNDLVYgaW1wbGVtZW50YXRpb24gb2YgdGhl
IENvaGVyZW50IE1hbmFnZXIgR2xvYmFsIENvbnRyb2wKPiA+IFJlZ2lzdGVyIChDTUdDUikgZGV2
aWNlLiBJdCBpcyBiYXNlZCBvbiB0aGUgZXhpc3RpbmcgTUlQUyBDTUdDUgo+ID4gaW1wbGVtZW50
YXRpb24gYnV0IGFkYXB0ZWQgZm9yIFJJU0MtViBzeXN0ZW1zLgo+ID4KPiA+IFRoZSBDTUdDUiBk
ZXZpY2UgcHJvdmlkZXMgZ2xvYmFsIHN5c3RlbSBjb250cm9sIGZvciBtdWx0aS1jb3JlCj4gPiBj
b25maWd1cmF0aW9ucyBpbiBSSVNDLVYgc3lzdGVtcy4KPiA+Cj4gPiBUaGlzIGlzIG5lZWRlZCBm
b3IgdGhlIE1JUFMgQk9TVE9OIEFJQSBib2FyZC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGFv
LXlpbmcgRnUgPGNmdUBtaXBzLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IERqb3JkamUgVG9kb3Jv
dmljIDxkam9yZGplLnRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tPgo+ID4gUmV2aWV3ZWQtYnk6IERh
bmllbCBIZW5yaXF1ZSBCYXJib3phIDxkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tPgo+ID4gTWVz
c2FnZS1JRDogPDIwMjUxMDE4MTU0NTIyLjc0NTc4OC05LWRqb3JkamUudG9kb3JvdmljQGh0ZWNn
cm91cC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+Cj4gPiAtLS0KPiA+wqDCoCBpbmNsdWRlL2h3L21pc2MvcmlzY3ZfY21n
Y3IuaCB8wqAgNTAgKysrKysrKwo+ID7CoMKgIGh3L21pc2MvcmlzY3ZfY21nY3IuY8KgwqDCoMKg
wqDCoMKgwqAgfCAyNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID7CoMKg
IGh3L21pc2MvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOSArKwo+
ID7CoMKgIGh3L21pc2MvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICsK
PiA+wqDCoCA0IGZpbGVzIGNoYW5nZWQsIDMwOSBpbnNlcnRpb25zKCspCj4gPsKgwqAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvbWlzYy9yaXNjdl9jbWdjci5oCj4gPsKgwqAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGh3L21pc2MvcmlzY3ZfY21nY3IuYwo+Cj4KPiA+ICtzdGF0aWMgaW5saW5l
IHZvaWQgdXBkYXRlX2djcl9iYXNlKFJJU0NWR0NSU3RhdGUgKmdjciwgdWludDY0X3QgdmFsKQo+
ID4gK3sKPiA+ICvCoMKgwqAgZ2NyLT5nY3JfYmFzZSA9IHZhbCAmIEdDUl9CQVNFX0dDUkJBU0Vf
TVNLOwo+ID4gK8KgwqDCoCBtZW1vcnlfcmVnaW9uX3NldF9hZGRyZXNzKCZnY3ItPmlvbWVtLCBn
Y3ItPmdjcl9iYXNlKTsKPiA+ICsKPiA+ICvCoMKgwqAgLyoKPiA+ICvCoMKgwqDCoCAqIEZvciBi
b3N0b24tYWlhLCBjcGNfYmFzZSBpcyBzZXQgdG8gZ2NyX2Jhc2UgKyAweDgwMDEgdG8gZW5hYmxl
Cj4gPiArwqDCoMKgwqAgKiBjcGMgYXV0b21hdGljYWxseS4KPiA+ICvCoMKgwqDCoCAqLwo+ID4g
K8KgwqDCoCB1cGRhdGVfY3BjX2Jhc2UoZ2NyLCB2YWwgKyAweDgwMDEpOwo+ID4gK30KPiA+ICsK
PiA+ICsvKiBSZWFkIEdDUiByZWdpc3RlcnMgKi8KPiA+ICtzdGF0aWMgdWludDY0X3QgZ2NyX3Jl
YWQodm9pZCAqb3BhcXVlLCBod2FkZHIgYWRkciwgdW5zaWduZWQgc2l6ZSkKPiA+ICt7Cj4gPiAr
wqDCoMKgIFJJU0NWR0NSU3RhdGUgKmdjciA9IChSSVNDVkdDUlN0YXRlICopIG9wYXF1ZTsKPiA+
ICsKPiA+ICvCoMKgwqAgc3dpdGNoIChhZGRyKSB7Cj4gPiArwqDCoMKgIC8qIEdsb2JhbCBDb250
cm9sIEJsb2NrIFJlZ2lzdGVyICovCj4gPiArwqDCoMKgIGNhc2UgR0NSX0NPTkZJR19PRlM6Cj4g
PiArwqDCoMKgwqDCoMKgwqAgLyogU2V0IFBDT1JFUyB0byAwICovCj4gPiArwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIDA7Cj4gPiArwqDCoMKgIGNhc2UgR0NSX0JBU0VfT0ZTOgo+ID4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiBnY3ItPmdjcl9iYXNlOwo+ID4gK8KgwqDCoCBjYXNlIEdDUl9SRVZfT0ZT
Ogo+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBnY3ItPmdjcl9yZXY7Cj4gPiArwqDCoMKgIGNh
c2UgR0NSX0NQQ19TVEFUVVNfT0ZTOgo+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBpc19jcGNf
Y29ubmVjdGVkKGdjcik7Cj4gPiArwqDCoMKgIGNhc2UgR0NSX0wyX0NPTkZJR19PRlM6Cj4gPiAr
wqDCoMKgwqDCoMKgwqAgLyogTDIgQllQQVNTICovCj4gPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IEdDUl9MMl9DT05GSUdfQllQQVNTX01TSzsKPiA+ICvCoMKgwqAgZGVmYXVsdDoKPiA+ICvCoMKg
wqDCoMKgwqDCoCBxZW11X2xvZ19tYXNrKExPR19VTklNUCwgIlJlYWQgJWQgYnl0ZXMgYXQgR0NS
IG9mZnNldCAweCUiIEhXQUREUl9QUkl4Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJcbiIsIHNpemUsIGFkZHIpOwo+ID4gK8KgwqDCoCB9Cj4gPiArwqDC
oMKgIHJldHVybiAwOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgaW5saW5lIHRhcmdldF91bG9u
ZyBnZXRfZXhjZXB0aW9uX2Jhc2UoUklTQ1ZHQ1JWUFN0YXRlICp2cHMpCj4gPiArewo+ID4gK8Kg
wqDCoCByZXR1cm4gdnBzLT5yZXNldF9iYXNlICYgR0NSX0NMX1JFU0VUX0JBU0VfUkVTRVRCQVNF
X01TSzsKPiA+ICt9Cj4gPiArCj4gPiArLyogV3JpdGUgR0NSIHJlZ2lzdGVycyAqLwo+ID4gK3N0
YXRpYyB2b2lkIGdjcl93cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1aW50NjRfdCBk
YXRhLCB1bnNpZ25lZCBzaXplKQo+ID4gK3sKPiA+ICvCoMKgwqAgUklTQ1ZHQ1JTdGF0ZSAqZ2Ny
ID0gKFJJU0NWR0NSU3RhdGUgKilvcGFxdWU7Cj4gPiArwqDCoMKgIFJJU0NWR0NSVlBTdGF0ZSAq
Y3VycmVudF92cHM7Cj4gPiArwqDCoMKgIGludCBjcHVfaW5kZXgsIGMsIGg7Cj4gPiArCj4gPiAr
wqDCoMKgIGZvciAoYyA9IDA7IGMgPCBnY3ItPm51bV9jb3JlOyBjKyspIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoCBmb3IgKGggPSAwOyBoIDwgZ2NyLT5udW1faGFydDsgaCsrKSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoYWRkciA9PSBSSVNDVl9DTENCX09GUyArIGMgKiBSSVNDVl9D
T1JFX1JFR19TVFJJREUgKyBoICogOCkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjcHVfaW5kZXggPSBjICogZ2NyLT5udW1faGFydCArIGg7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGN1cnJlbnRfdnBzID0gJmdjci0+dnBzW2NwdV9pbmRleF07Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1cnJlbnRfdnBzLT5yZXNldF9iYXNl
ID0gZGF0YSAmIEdDUl9DTF9SRVNFVF9CQVNFX01TSzsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY3B1X3NldF9leGNlcHRpb25fYmFzZShjcHVfaW5kZXggKyBnY3ItPmNsdXN0
ZXJfaWQgKgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2NyLT5udW1fY29yZSAqIGdjci0+bnVt
X2hhcnQsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRfZXhjZXB0aW9uX2Jhc2UoY3VycmVu
dF92cHMpKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gK8KgwqDCoMKgwqDCoMKgIH0KPiA+ICvCoMKg
wqAgfQo+ID4gKwo+ID4gK8KgwqDCoCBzd2l0Y2ggKGFkZHIpIHsKPiA+ICvCoMKgwqAgY2FzZSBH
Q1JfQkFTRV9PRlM6Cj4gPiArwqDCoMKgwqDCoMKgwqAgdXBkYXRlX2djcl9iYXNlKGdjciwgZGF0
YSk7Cj4gPiArwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiArwqDCoMKgIGRlZmF1bHQ6Cj4gPiAr
wqDCoMKgwqDCoMKgwqAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsICJXcml0ZSAlZCBieXRlcyBh
dCBHQ1Igb2Zmc2V0IDB4JSIgSFdBRERSX1BSSXgKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgIiAweCUiIFBSSXg2NCAiXG4iLCBzaXplLCBhZGRyLCBkYXRh
KTsKPiA+ICvCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+ICvCoMKgwqAgfQo+ID4gK30KPiA+ICsK
PiA+ICtzdGF0aWMgY29uc3QgTWVtb3J5UmVnaW9uT3BzIGdjcl9vcHMgPSB7Cj4gPiArwqDCoMKg
IC5yZWFkID0gZ2NyX3JlYWQsCj4gPiArwqDCoMKgIC53cml0ZSA9IGdjcl93cml0ZSwKPiA+ICvC
oMKgwqAgLmVuZGlhbm5lc3MgPSBERVZJQ0VfTkFUSVZFX0VORElBTiwKPgo+IER1YmlvdXMgREVW
SUNFX05BVElWRV9FTkRJQU4gdXNlLCBkbyB5b3UgbWVhbiBERVZJQ0VfTElUVExFX0VORElBTj8K
Pgo+IE1heWJlIHdlIGNhbiBhbHRlciBjaGVja3BhdGNoIHRvIG5vIGFjY2VwdCBuZXcgREVWSUNF
X05BVElWRV9FTkRJQU4KPiBpbiBvdXIgY29kZSBiYXNlLgoKQWggZ29vZCBjYXRjaCwgdGhpcyBj
b3VsZCBiZSB0aGUgczM5MCBpc3N1ZS4KClRoaXMgcGF0Y2ggd2FzIGRyb3BwZWQgaW4gdGhlIHYy
IHB1bGwgcmVxdWVzdCwgQERqb3JkamUgY2FuIHlvdSBmaXgKdGhpcyBpbiB0aGUgbmV4dCBwYXRj
aCBzdWJtaXNzaW9uCgpBbGlzdGFpcg==

