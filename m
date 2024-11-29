Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B8FD6EBE5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfp-00085Z-Mp; Fri, 29 Nov 2024 02:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfi-00081U-Ji
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:14 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfg-0002nM-MR
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866253; x=1764402253;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=r1cIMR2bydzS/r8/JNnPbdEFMy5ycwRYByzUFRA40/o=;
 b=Upp4fDke0KFj5Ng8a7k5ScWFxhCLYAtWa7Lq23wAgx5wg8+NUz0IoWH7
 ZGzl80VaLlFxq3pLvvE9rdYPEo+JC1cCEgVMvhTXgniiD2vnO/jfuAF7U
 E5vKXVLMrDQXRXXCiURwqLuG7ap9N1fUn9Fsn84AoFZ97FGeO95b/gDYA
 4Rt0t9Z2Ph1SAjI9RpmTwbjNdJ4qj1Ek7g0NdLBj0gTWQ8zOkXP69Nmd8
 ZBtC8vg7auPDekfZ2m1yH0Di8SEn3mGsM+3jptxY53vbdKR8Oq6i2mjxL
 dhCwf080olNQniIqncnFZb2OkjA/Kn43+8BcCKJ29asUixwJlrTPU/aHw w==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25670820"
X-MGA-submission: =?us-ascii?q?MDHwBCCxTrnBU+wELJSvXKCeujxKx9y/MTdV3v?=
 =?us-ascii?q?hMu9wh91zH4uF18ynTEZjP/wZIhsAgtt+1xjZX3sBiF44zZUOgd930Ld?=
 =?us-ascii?q?oGgKFh8PGgihE9p7I89pIMma3VGZ3+vpNm2dxCV4Kx/RXzE16yCyJ8cN?=
 =?us-ascii?q?oEXwbOa57IiW8U40Jvdt8nrQ=3D=3D?=
Received: from mail-norwayeastazlp17013077.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.93.81.77])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:44:07 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Im0+fdXMmMYpvO48Xpzdus41smX8ohQ0num5t2H/2bTRwkfKwy8DbuNxROriHEnTLtz+567O2i0ItMEL31EiFpvb3cTzDqJ2RZE2mGxLTDLUsUjS8TAMzESlEtSo7T6rgi5cBi5RzWddZ8fxIvlVXlhToyXleiOWcdPckGxHm0tv+pTpzIUtJRW2ud441hGi66sbiQHG2SeZvQqWClw+Tkeg+yp/ZT+cfh77JZMgYzWwQ+Yfr75KIldOnmPnevCM9XNKcbTXYiuseVospj1A+Mem7M/ssO4dXeBi8HPyxAp2tN0P6/jPRR9Pz6nyRDXPqb4xaPhmIpivjvkS6E53qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1cIMR2bydzS/r8/JNnPbdEFMy5ycwRYByzUFRA40/o=;
 b=Xce/7jtyut1Enl37oStbC8WjWdpepdvfvgaRah7/6lJhx6a3x3oTyXOO4XlfdirmjhGQPzidYUuUmj9evePQ7r0r3rIexyQMUr9xXhVHkLh4O4WSzRr+e3rrqjFSQATLR4uXiiVmjpeFQnNJDxWwTy4O7E7TTcLB/eFpnZEpROzAQ9zsr1CpDF8/QI7BWdO/3sB45oKvDGAX6sXYjftVlCzw6FniRXkgQuRk9B/Wj6LOvEa0kIkwZT0wEYpm1ZZKRVUwYDHqGdqFzztJFksep14pxvFK+3k/cUTVcXQwhQ0FxOBn5pbcQQLuzL91ZGDnPfSmxGkzQV5nU4l4nAjNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1cIMR2bydzS/r8/JNnPbdEFMy5ycwRYByzUFRA40/o=;
 b=JM3+6h5n/3JVfta6gShLiNyPv8ZUOOCcZFaIfZ9PYlEkNNSLno5Su3dCF2wiNdbub+1lsxMBmULm/OMEYY09L8v34Q1zbmWyPZnI/ER1JsZ/6UH4hxPB53Pa6Q687iUnZ3U9boGmRSNCnLNllMSMPDpSNcNRA0Q8zsBPu6pPfPzo6AQjMEFz5zMaqViLQLcFGw59Q2m4z01MwZIBgBzuG6IH0m2ofull19ILQ30HMlv3rLy05dCXy7wx8poFCsZzmu1PRmSqycjtg0FQ+cGnxi78CS3gMOrcidzLMm8WiaF91Mes59J+RqZXZ1Z5gOMI2HENA05D6g93qjdk1bGnPw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6414.eurprd07.prod.outlook.com (2603:10a6:800:139::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:44:05 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:44:05 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 19/19] intel_iommu: Add support for ATS
Thread-Topic: [PATCH v1 19/19] intel_iommu: Add support for ATS
Thread-Index: AQHbQjJ3Jcu7IEEYSky5Kq9PmWavTQ==
Date: Fri, 29 Nov 2024 07:44:05 +0000
Message-ID: <20241129074332.87535-20-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6414:EE_
x-ms-office365-filtering-correlation-id: 6f7abee3-0bb4-4a99-a328-08dd1049998f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cXdmZzMyaFJyYUZDZHFEa01haGdkK0JiTDYvQ1I0RTd1bUxKdk9meGdwNG9M?=
 =?utf-8?B?MC9oNzdMSy9QS0hQaW9qdVZheFJid3JndnNlcTVDV01tZXE1clB5aStDMDFz?=
 =?utf-8?B?NlBuMVpnMGlFSGRJOHNUR3c0YUs5TDRjdmQzdUx0bzl3YzRPYW5DdllFdU1j?=
 =?utf-8?B?NlpHZFNuNWdIbkVFSnZDZ0tZYzIrNGUzeWVqK2duTVpYdi9IQVZ5dGx5bGRW?=
 =?utf-8?B?S1YzNUZoNERnS3R1ZFcvVHdBcE1Yb1NKMmkvZ0lSMUxuTlNoU3J4VXhQZlhZ?=
 =?utf-8?B?TXpMeENDZnRKeXpsRHJnNEpaT3VGbjFuOUFsbUJ2ODZ0YmxvbnZoVzJ6eGVN?=
 =?utf-8?B?YkdmQkpQdkwyNzJVS2hVYm9tM0ZhY0o3UTV5WXNOVEt4bFBnVW5MY2tDMXFH?=
 =?utf-8?B?Ty8wSmo5WFVnSnJFTWo5ckgvRWJmZWdwTzJjNk5EbTk4Y3lJS2thUHlnZldt?=
 =?utf-8?B?Wlo3MWs1ZGFkbWEyQ3VYUnlka1ZvcGY4KytPa0xvcGh0cUtGOXRpcHQ5Wmc4?=
 =?utf-8?B?QVB4UjBQWUhpKythbGs5M283TlQ4TFl5d3BoZ0F6TGJiUnpVZ0lVd1FoS3Ey?=
 =?utf-8?B?OW95NlAvRnVIb0lyL21iZ3UrakxHYWRFVTV6THErVzY3YWVsY3ZQQXdGb3dC?=
 =?utf-8?B?bUFsZnhlUlhkWTlPMXZHbEZYbWwrQWZOcjVKVkhnS2NzeURUT1AyOUdmM3pz?=
 =?utf-8?B?d0JJRkZKb3hxTWFMNS8yZ0g2OVZoYmdJU29YUU5QYWlPYmVVOTZhNmgvNHBa?=
 =?utf-8?B?KysyVEpJUm12bjhaRE9LV05iSWozZ2VTaTR4VUYxaXgzaHFkZ2xnc1dkZ2ZR?=
 =?utf-8?B?OVRXTk9lUldFU1c0N1poUnBZNWpCNVlkMWM4WnJPTkdHTnpuNCtqdU5HUEky?=
 =?utf-8?B?MUlScVNVdWZQalQ3UDlwenhWeUhaSzcyQWxzY2lQSXkrOXlsOUxNT29ydHlI?=
 =?utf-8?B?RllzZE9PSUlVc0NiY01sVk9sM210OUk4VVdMeE5taEZUdGNVNU5mYWJ2cWE0?=
 =?utf-8?B?Z3NQYjBQa0dnVFVqSXFpalBabHlXMTkzdDlUbExLTks3SHA5K2FPLzc0aWlN?=
 =?utf-8?B?eFNzSEdIOEh1eEh4YnNNelZOUXcwU2FQYzR6VHJWcXF0eTA0VW1RUDdLL2dF?=
 =?utf-8?B?VktkQ1hKN0ppOWdJRGdqdjlVUjVvckpLM29XZnlQRzFFZmZNK21tMTN6M3Fj?=
 =?utf-8?B?VFBjWUpranBIbStSMnQvc1dOWFVmdnozNGxxbFhQbkRwRy9HdSsxYWk2VHoy?=
 =?utf-8?B?K3JDc2h2a0wvcE9hSUd1UEFGRVJOcytLMGVSNmFnQTVDUkM1ZVpzUnZzUUIy?=
 =?utf-8?B?bmVBMGhLMHpkUDdTZjZtYVBlS0JnTjRLMVBqTEdaQUhwMHhLZVhSeE1KWm43?=
 =?utf-8?B?Zjd3eTJWclVGeU4wWGp4aVdka1I5QnF6a3VZT1JlTHllcXVkanhnTVlydzFG?=
 =?utf-8?B?dUI0eTlxVitWd1lBRUh3S2dwaWROQ0hVbHRmTjBOcWlyUzZaVTN4Z3c2a0Fo?=
 =?utf-8?B?bDcycDJmQjRIOVNDYkd0bEZ6RDZkdGp1a0xmUlYwdjZhVEN5dmxha0pJbWJw?=
 =?utf-8?B?NEUvNnpqb3pVWG52Tm9FZ2E4dEROUlRyK1lRVmVhQ1JRUGZFdnVOaG5iRHJN?=
 =?utf-8?B?TDA0VS8yZzUzdXY4UDAzM3YzRUhpRnlwWE1yelVsYXhoakhvSTM1MlVRMDBU?=
 =?utf-8?B?aFBZanBodW9hdktDWktkd3NRSEh6WE1oYWN1T29EcGx5WVAzdDErUU55aW5D?=
 =?utf-8?B?cDI2bDJ5RG9tTjJ0WUlIYmdxazFseFNaT1d4anAvY1hRVzA1Y2EwYkFDS09L?=
 =?utf-8?B?aElCOFFDTnEzRWxIbEsvU2xQTDBPSXRsejNwYTBmM2RTdGJhZUlCQ3lWWGwy?=
 =?utf-8?B?NU1tczFBcnBuTi9pNlU3NGc4TkNGNXJPUi91Wkw1NnB1Y2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3dRc3l2QnJFRVFSMVRuSWY5WVh5QnoyYzRCdVpZMWNLRGpETmdhdUhMajNu?=
 =?utf-8?B?Smg4QjVYUGswZm42bGFQV25RczI0elZmd1hORDJwMVZhQVA0YjhQQ0d0Qkly?=
 =?utf-8?B?WWQvbnB6TnFjQ0dtRHhRN2pOWXo0QTU1R0xRc3lOYVdIYTk2aGNuUFRqRVFG?=
 =?utf-8?B?UTlGRGgzMVk0NUZnNHdEaDlUVnBHNGZWV3psc1FpbXlrUjQ5MFIzVE9LTzNZ?=
 =?utf-8?B?UTFBQ1N4RmVmVkp0SlMwSGo0eUhTVTVtd0psaEdkeVhzWTJ0NmYwT24wQUx1?=
 =?utf-8?B?ZWovWUNQZWd6YitaTDJIVzlOQXRiWGpoZFVjYUNOV2c5dE1taExyOGkyZlhJ?=
 =?utf-8?B?MEN5ZzVmNEJkc2F2Qk9GRkxRTUQ1QjlEbXFyakUrZmFjTzRVdjRuRW4yNndL?=
 =?utf-8?B?cDUrZ05QMDF2NnVtY2ZMTmFsYVJCSUxvcUVYWTJRVTVuMkI1V1VDR3RTNjVO?=
 =?utf-8?B?U1RVTVFuL01XL2lRaTF3aXNkcFdvQTliQnVJTi9QTGlBS1FaVzZRdEgreU1V?=
 =?utf-8?B?Um9uTHpZTHF6N0RWWVZXSXpVdDBHWlZXMnZNNzg3M051VE80VEZuRVF5K1Vs?=
 =?utf-8?B?R3pBcjhBR3ZJM2oyak1XNWdBZzB5NTRpanI5dUpPL3NNb3NQUUt6d3JDbXM4?=
 =?utf-8?B?Vi9MQ0FGYmI0c3dnVkdjSXkzQyt5eG1ERU4wSTZSRmZpV2IrL0UxQi9MMGJu?=
 =?utf-8?B?YmNEVjlFMEtvRmpNL1ZIMW43Qk1vakx4R3o1NW9lRE5zanVJR1RLZ0VFUkQy?=
 =?utf-8?B?bmlDUUNGTnk2eEgvMkt0VVRzdVE0VjBrRExtdkRCcWx3ZmxBVm9XZmNlaU0v?=
 =?utf-8?B?Q2JVWnB4Rkd0ZnNGWUIyVmpqNUJoV2pjMHhVNmdudFdYSzdKbDJkTmVSNUh1?=
 =?utf-8?B?czFNVnowcFpES3h0UzV4Y2NLZ1hVSks0N0d1YXVjZVl2YXBrSSs5aTdNYm5Y?=
 =?utf-8?B?OVprblc0bkdaU1V0Y1ZsamxwdHl1czRiTWZZZ0V4dk5oUzI1MUg4dkErdmVF?=
 =?utf-8?B?KzR4Z3A1UTBUaG42aEFNWmhaanZkRW1BaTZ4Q2N2MDNkSHhKK1BuT3I2NThL?=
 =?utf-8?B?RmtJY2U5UGtsaTkwcHpqM0U0WXdkOElqUDBGbG5oNUZRZWhrM3RxSC9iYlZk?=
 =?utf-8?B?M0xMNEUrdmpSZEVJYVB2aHg5WEVYZFZVemhSQWJZUGJYbkE5SnRKdk15Qkgw?=
 =?utf-8?B?MFl1cXM5bVk1c1FrbVVvbldybUdYQlRFRC9CbnA5VWU2UG5ROGVlbjBUalRu?=
 =?utf-8?B?enkycnRtamdhdnFrTjlhME5LYVhNekh1bno1NXIzOStINmNCNEFad1JYeSts?=
 =?utf-8?B?bExRZWgxYW9GSUJyV1dKRlZCYUtORytUa3pVbmJDbWQvcTZ5TzAxZDFDZjRx?=
 =?utf-8?B?LzdSL0JrNmJhWnBnazZpRDFxOExvUkpEdDlzb1hNdm9DcHl1R1Vtd1k0TkQv?=
 =?utf-8?B?YzJ4ZXd1WTAzZCszeU42UlhFSEE3VHh1b2pORmQyMUhmVmVIRmFEWXdia1ZF?=
 =?utf-8?B?THN0WkpNMEl6MW5YcU0zUk5aOXB6OHphTDYxc3Q0Qno1NEdpQUVzeE1RK1Rx?=
 =?utf-8?B?ekVCcGFkekcrY3VUa0ZXVEU1WkNOeElkQ2toSE1pdkV5ZzhCRlM3dlU5aG96?=
 =?utf-8?B?V2s2bkFpRmw5a0RqNkFIWVVSdzdYdWMrT05JVnA4L3V5SGZ3dGNiMEh6OEt3?=
 =?utf-8?B?aVd2ZklGNDlxTWs5YzMrdmthanJsSkJueExQL2ZySGdJc0pxa2JRdmNrT0F5?=
 =?utf-8?B?QjRhRVQwY2R6dUc4VXJlcjZDaFE3N3ZGYzV1ZXVGcGtLeGZOQVJoaGxaeVVy?=
 =?utf-8?B?cmMrVllkU0lyQTBTbFdJSDVwZy9leFVUNWp5ZFBLZWFyRVA5N21qcDlXUExp?=
 =?utf-8?B?VTVtWEVDRXM1aUI0ZXBubGM3RisvbnNzSVFxKzcvZ2RnOUV1TmV3TG40bHJz?=
 =?utf-8?B?dTJ5azZqRnNzNERCNGxJdjd4UG5EdmdDdEpMeUZ6RThUYkFER1FLbjlrRG1r?=
 =?utf-8?B?Zi85eFg2L1hNQXNVRDQzTEpHZWJ6dXFuOE43bnBESHlUSHJpQzFjQTdrTjBK?=
 =?utf-8?B?eFhzbFpsS1BWVUZYWERYbVp4TFRpTzJkM3V0TGlkUzNSN250U0R2KzNZeHN0?=
 =?utf-8?B?c21LRFZxOXV2aW1oK013QkU5UzhNWUNFZDB0YUpzSmcyODdlNFR6UHNad01O?=
 =?utf-8?Q?vjntRqwLEPIvx2JAigHqjMM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6E3AACFC622174F82D22861D36F9C66@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7abee3-0bb4-4a99-a328-08dd1049998f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:44:05.1044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TP/tzPD3nPveRRb0kJEavlOQ1vMnSMn/2VQB52H7/c3dXdsd68wtTHfn37cbcQM/XolfXsBUNuXP/StKA2sSuWTmpH6NB+MoQ6ukwgsV2WeiU1lg7spB4R7HA84pJH38
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6414
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgIHwgNzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KIGh3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDY5IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lv
bW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IGEzZTk3MmFmNzUuLjg5OWM4NTA2
ZGUgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KQEAgLTQxNjYsMTIgKzQxNjYsMTAgQEAgc3RhdGljIHZvaWQgdnRkX3JlcG9y
dF9pcl9pbGxlZ2FsX2FjY2VzcyhWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywNCiAgICAgYm9vbCBp
c19mcGRfc2V0ID0gZmFsc2U7DQogICAgIFZURENvbnRleHRFbnRyeSBjZTsNCiANCi0gICAgYXNz
ZXJ0KHZ0ZF9hcy0+cGFzaWQgIT0gUENJX05PX1BBU0lEKTsNCi0NCiAgICAgLyogVHJ5IG91dCBi
ZXN0IHRvIGZldGNoIEZQRCwgd2UgY2FuJ3QgZG8gYW55dGhpbmcgbW9yZSAqLw0KICAgICBpZiAo
dnRkX2Rldl90b19jb250ZXh0X2VudHJ5KHMsIGJ1c19uLCB2dGRfYXMtPmRldmZuLCAmY2UpID09
IDApIHsNCiAgICAgICAgIGlzX2ZwZF9zZXQgPSBjZS5sbyAmIFZURF9DT05URVhUX0VOVFJZX0ZQ
RDsNCi0gICAgICAgIGlmICghaXNfZnBkX3NldCAmJiBzLT5yb290X3NjYWxhYmxlKSB7DQorICAg
ICAgICBpZiAoIWlzX2ZwZF9zZXQgJiYgcy0+cm9vdF9zY2FsYWJsZSAmJiB2dGRfYXMtPnBhc2lk
ICE9IFBDSV9OT19QQVNJRCkgew0KICAgICAgICAgICAgIHZ0ZF9jZV9nZXRfcGFzaWRfZnBkKHMs
ICZjZSwgJmlzX2ZwZF9zZXQsIHZ0ZF9hcy0+cGFzaWQpOw0KICAgICAgICAgfQ0KICAgICB9DQpA
QCAtNDc0NSw2ICs0NzQzLDcxIEBAIHN0YXRpYyBJT01NVU1lbW9yeVJlZ2lvbiAqdnRkX2dldF9t
ZW1vcnlfcmVnaW9uX3Bhc2lkKFBDSUJ1cyAqYnVzLA0KICAgICByZXR1cm4gJnZ0ZF9hcy0+aW9t
bXU7DQogfQ0KIA0KK3N0YXRpYyBJT01NVVRMQkVudHJ5IHZ0ZF9pb21tdV9hdHNfZG9fdHJhbnNs
YXRlKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgYWRkciwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVUFjY2Vzc0ZsYWdzIGZsYWdzLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBpb21tdV9p
ZHgpDQorew0KKyAgICBJT01NVVRMQkVudHJ5IGVudHJ5Ow0KKyAgICBWVERBZGRyZXNzU3BhY2Ug
KnZ0ZF9hcyA9IGNvbnRhaW5lcl9vZihpb21tdSwgVlREQWRkcmVzc1NwYWNlLCBpb21tdSk7DQor
DQorICAgIGlmICh2dGRfaXNfaW50ZXJydXB0X2FkZHIoYWRkcikpIHsNCisgICAgICAgIHZ0ZF9y
ZXBvcnRfaXJfaWxsZWdhbF9hY2Nlc3ModnRkX2FzLCBhZGRyLCBmbGFncyAmIElPTU1VX1dPKTsN
CisgICAgICAgIGVudHJ5LmlvdmEgPSAwOw0KKyAgICAgICAgZW50cnkudHJhbnNsYXRlZF9hZGRy
ID0gMDsNCisgICAgICAgIGVudHJ5LmFkZHJfbWFzayA9IH5WVERfUEFHRV9NQVNLXzRLOw0KKyAg
ICAgICAgZW50cnkucGVybSA9IElPTU1VX05PTkU7DQorICAgICAgICBlbnRyeS5wYXNpZCA9IFBD
SV9OT19QQVNJRDsNCisgICAgfSBlbHNlIHsNCisgICAgICAgIGVudHJ5ID0gdnRkX2lvbW11X3Ry
YW5zbGF0ZShpb21tdSwgYWRkciwgZmxhZ3MsIGlvbW11X2lkeCk7DQorICAgIH0NCisgICAgcmV0
dXJuIGVudHJ5Ow0KK30NCisNCitzdGF0aWMgc3NpemVfdCB2dGRfaW9tbXVfYXRzX3JlcXVlc3Rf
dHJhbnNsYXRpb24oSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHByaXZfcmVxLCBib29sIGV4ZWNf
cmVxLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBo
d2FkZHIgYWRkciwgc2l6ZV90IGxlbmd0aCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYm9vbCBub193cml0ZSwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVUTEJFbnRyeSAqcmVzdWx0LA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3QgcmVz
dWx0X2xlbmd0aCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDMyX3QgKmVycl9jb3VudCkNCit7DQorICAgIElPTU1VQWNjZXNzRmxhZ3MgZmxh
Z3MgPSBJT01NVV9BQ0NFU1NfRkxBR19GVUxMKHRydWUsICFub193cml0ZSwgZXhlY19yZXEsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaXZf
cmVxLCBmYWxzZSwgZmFsc2UpOw0KKyAgICBzc2l6ZV90IHJlc19pbmRleCA9IDA7DQorICAgIGh3
YWRkciB0YXJnZXRfYWRkcmVzcyA9IGFkZHIgKyBsZW5ndGg7DQorICAgIElPTU1VVExCRW50cnkg
ZW50cnk7DQorDQorICAgICplcnJfY291bnQgPSAwOw0KKw0KKyAgICB3aGlsZSAoKGFkZHIgPCB0
YXJnZXRfYWRkcmVzcykgJiYgKHJlc19pbmRleCA8IHJlc3VsdF9sZW5ndGgpKSB7DQorICAgICAg
ICBlbnRyeSA9IHZ0ZF9pb21tdV9hdHNfZG9fdHJhbnNsYXRlKGlvbW11LCBhZGRyLCBmbGFncywg
MCk7DQorICAgICAgICBpZiAoIUlPTU1VX1RMQl9FTlRSWV9UUkFOU0xBVElPTl9FUlJPUigmZW50
cnkpKSB7IC8qIFRyYW5zbGF0aW9uIGRvbmUgKi8NCisgICAgICAgICAgICAvKg0KKyAgICAgICAg
ICAgICAqIDQuMS4yIDogR2xvYmFsIE1hcHBpbmcgKEcpIDogUmVtYXBwaW5nIGhhcmR3YXJlIHBy
b3ZpZGVzIGEgdmFsdWUNCisgICAgICAgICAgICAgKiBvZiAwIGluIHRoaXMgZmllbGQNCisgICAg
ICAgICAgICAgKi8NCisgICAgICAgICAgICBlbnRyeS5wZXJtICY9IH5JT01NVV9HTE9CQUw7DQor
ICAgICAgICB9IGVsc2Ugew0KKyAgICAgICAgICAgICplcnJfY291bnQgKz0gMTsNCisgICAgICAg
IH0NCisgICAgICAgIHJlc3VsdFtyZXNfaW5kZXhdID0gZW50cnk7DQorICAgICAgICByZXNfaW5k
ZXggKz0gMTsNCisgICAgICAgIGFkZHIgPSAoYWRkciAmICh+ZW50cnkuYWRkcl9tYXNrKSkgKyAo
ZW50cnkuYWRkcl9tYXNrICsgMSk7DQorICAgIH0NCisNCisgICAgLyogQnVmZmVyIHRvbyBzbWFs
bCAqLw0KKyAgICBpZiAoYWRkciA8IHRhcmdldF9hZGRyZXNzKSB7DQorICAgICAgICByZXR1cm4g
LUVOT01FTTsNCisgICAgfQ0KKyAgICByZXR1cm4gcmVzX2luZGV4Ow0KK30NCisNCitzdGF0aWMg
dWludDY0X3QgdnRkX2dldF9taW5fcGFnZV9zaXplKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSkN
Cit7DQorICAgIHJldHVybiBWVERfUEFHRV9TSVpFOw0KK30NCisNCiBzdGF0aWMgUENJSU9NTVVP
cHMgdnRkX2lvbW11X29wcyA9IHsNCiAgICAgLmdldF9hZGRyZXNzX3NwYWNlID0gdnRkX2hvc3Rf
ZG1hX2lvbW11LA0KICAgICAuZ2V0X21lbW9yeV9yZWdpb25fcGFzaWQgPSB2dGRfZ2V0X21lbW9y
eV9yZWdpb25fcGFzaWQsDQpAQCAtNDkyMiw2ICs0OTg1LDggQEAgc3RhdGljIHZvaWQgdnRkX2lv
bW11X21lbW9yeV9yZWdpb25fY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsDQogICAgIGlt
cmMtPnRyYW5zbGF0ZSA9IHZ0ZF9pb21tdV90cmFuc2xhdGU7DQogICAgIGltcmMtPm5vdGlmeV9m
bGFnX2NoYW5nZWQgPSB2dGRfaW9tbXVfbm90aWZ5X2ZsYWdfY2hhbmdlZDsNCiAgICAgaW1yYy0+
cmVwbGF5ID0gdnRkX2lvbW11X3JlcGxheTsNCisgICAgaW1yYy0+aW9tbXVfYXRzX3JlcXVlc3Rf
dHJhbnNsYXRpb24gPSB2dGRfaW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb247DQorICAgIGlt
cmMtPmdldF9taW5fcGFnZV9zaXplID0gdnRkX2dldF9taW5fcGFnZV9zaXplOw0KIH0NCiANCiBz
dGF0aWMgY29uc3QgVHlwZUluZm8gdnRkX2lvbW11X21lbW9yeV9yZWdpb25faW5mbyA9IHsNCmRp
ZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmgNCmluZGV4IDIzOGYxZjQ0M2YuLjdlMjA3MWNkNGQgMTAwNjQ0DQot
LS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXVfaW50ZXJuYWwuaA0KQEAgLTE5Miw2ICsxOTIsNyBAQA0KICNkZWZpbmUgVlREX0VDQVBf
U0MgICAgICAgICAgICAgICAgICgxVUxMIDw8IDcpDQogI2RlZmluZSBWVERfRUNBUF9NSE1WICAg
ICAgICAgICAgICAgKDE1VUxMIDw8IDIwKQ0KICNkZWZpbmUgVlREX0VDQVBfU1JTICAgICAgICAg
ICAgICAgICgxVUxMIDw8IDMxKQ0KKyNkZWZpbmUgVlREX0VDQVBfTldGUyAgICAgICAgICAgICAg
ICgxVUxMIDw8IDMzKQ0KICNkZWZpbmUgVlREX0VDQVBfUFNTICAgICAgICAgICAgICAgICgxOVVM
TCA8PCAzNSkNCiAjZGVmaW5lIFZURF9FQ0FQX1BBU0lEICAgICAgICAgICAgICAoMVVMTCA8PCA0
MCkNCiAjZGVmaW5lIFZURF9FQ0FQX1NNVFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0MykNCi0t
IA0KMi40Ny4wDQo=

