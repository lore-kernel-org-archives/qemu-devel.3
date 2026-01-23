Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8639D6CFBD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 05:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjAAK-0000AL-CC; Fri, 23 Jan 2026 00:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vjAAI-00009k-IF; Fri, 23 Jan 2026 00:57:02 -0500
Received: from mail-japanwestazon11022141.outbound.protection.outlook.com
 ([40.107.75.141] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vjAAG-00052X-8i; Fri, 23 Jan 2026 00:57:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zd9SkZHTf3NaBqCmbIAj2pXTCLzEOcg7NdtLRT/wOQPBLsu2DqVp6h9c+/sIJaS8JYHbDL8RYPq2NzWttFB2X5WPxVjESq0krtoili25gNAx8Chvulzd2cRUQND7tj3QX9nuLAk9KUWWdXdxZNihaolido2mmvufrSDoMTOkyM5MzrVdn8YSwv3qHUN4Ve3zadnJ4i8WFEL3RnXzrFx8Fv8sbxfg86KPWDvg5F4Druvh9rFkJDKPgZbYEaP+P1JYMznus9Uj+8I3KpMbosTNnSr5WlY6euKND9//PcYdbvZ9+erPKYw8cAUJjdsnKjhE68hHxZoPYqXIwd3QtzzqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZM/O8oahXnV3xZnb6E4tIcGolAqH30HWdfovhZyaSk=;
 b=cawzyHwIeT0wEMfakTGbLIijUzvmgsJyc4IiUHXGx3r5QxyO9mnqgphq8hMj98FJfEQfLfKzaKYgdY01I8UGS3HXz12sHFtVnuuymokQDVcX0PHBS7nL8ItAwm1HAvxZqCtggToCfJrKIeeX+dh5CATTfNoDQrx0P8vwf2wNTWQar7E3JyCfYHoGsWx7Zmlc8I4eEirezPkbSW4ehHkFNiHa6HlLshF3AELsXbT+sey3HBkcEQlpzVPh3TWBtNFWM4Vim3Rd/dAM90Z7iXOyEXBs73rG5YD/R6yjBGQZxAMXax5blGT5JCIMBElvjAdO4wEnykeUdIFdQLN/lSRy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZM/O8oahXnV3xZnb6E4tIcGolAqH30HWdfovhZyaSk=;
 b=lwoVgSmlOHK95SUHcfDvHq7SbohPfog5nrli6kCU9IX/A/t+y5BOTnZNS50jGVmznN1vl5JoB9Te4EnmuOV8+hkqeev31p3DwSGQK8k7ur4qVchf6BVEgrvxwCFETFporwS9EWd71Q/F9LcXJZa4OhYqp58DI8nP7WjG10xfiJGyI4SJ8jLp55oX5coAVQW5kx6u1xy4MaMpV7xP2PdYHQLaIS/3wqzym9Kz9GfhXlGG/9rn6r4v2pdABPcPBuKg696NIhQIG0W/quT/Grl8w7ad6KIo+sY+axrSDkVeiQrwKOCxdMsm51gcR86VzMJOFgGM4oj6a9mmHHfFWJq85g==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KU2PPFD77119BF5.apcprd06.prod.outlook.com (2603:1096:d18::4ae) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 05:51:49 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 05:51:49 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v5 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Topic: [PATCH v5 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Index: AQHcicxL/oWavu0/2EO2Qkbn97XXvrVbOqAAgACTTgCAAeMVUA==
Date: Fri, 23 Jan 2026 05:51:48 +0000
Message-ID: <SI6PR06MB7631D05FD47182EF34BE9FA6F794A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
 <1433fb86-bb1b-41f7-b7ec-45560e52146a@kaod.org>
 <SE3PR06MB81997150B11579509E3B31C1FC96A@SE3PR06MB8199.apcprd06.prod.outlook.com>
In-Reply-To: <SE3PR06MB81997150B11579509E3B31C1FC96A@SE3PR06MB8199.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KU2PPFD77119BF5:EE_
x-ms-office365-filtering-correlation-id: dec3e882-570d-4dfd-96fd-08de5a438008
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MjJSbzNjSVg4MzZ2d1Zaek9uY3Y4MUVMUHZrWW41NHRQQ1lSWE9LNHkxMXJJ?=
 =?utf-8?B?SmF1VDcxTDhkVktCZytEMTJVcXE5d3UxN1ZKUFhxdTh4UlB5NEluT3VYOWdk?=
 =?utf-8?B?QU9vdUtJU2hGVHV6UzU4MTE3UmdvSlJ0UTlHVmNCa3lOa05PQ0Z4T2o0ajhG?=
 =?utf-8?B?TTNJVGc0cXd6aFBjQkFVRXdwbkRFYXpJdm9PT3JlSWFDMFUwK0dhZWp5TjhN?=
 =?utf-8?B?NDc1RlZyMndEUUs5eEcxeXV6NGxObFpGN1B6dXBVTFFyUHVCT2lwUDR0U0VI?=
 =?utf-8?B?T2ZQbHZWUHZ0K2JEMkFWTHhtenVHU3FHOGJMTEc5K2JpSlpUZXdVdjN2bFVK?=
 =?utf-8?B?bllMdDVmWW83VlRDWGYrMHFhZFNYbWVzUEZma0xCKzRuc0IvK09LTWRHbWE5?=
 =?utf-8?B?cWhhWkEvTjkrbjRhVTJFdWtyZmhHajVQWTBuZ3lNT2pXUDBIOGMyWFc3Wnk0?=
 =?utf-8?B?c0VqcUE3NW4rTGt1R2g1NGFuTG9pZVNHSXFXUEpVemEwR0h2cHdONTZPQXNC?=
 =?utf-8?B?WDBvdTJxNXl4TXo2cXB4ckd3WHNlN0V5MHBJSDlyM0lJK3N2Z2ZnaXk0bGUx?=
 =?utf-8?B?MGNnTFY3LzZ1MiswV3BBaG91VTQ1ay9rWjhBc1Z0bEZLMCtDN1BYSmkyVEZT?=
 =?utf-8?B?ZzJuU1RpTTg5ZTN2ckxCYnVYK285SE5qUVM0SDg3Qjlaa2QxMzFBNVF5RWZI?=
 =?utf-8?B?UGpNZmdPZHBaYmh0bE1NUEswalFhWGM0cEs1c0R6cTd6blYvNDlMOWZPb2J3?=
 =?utf-8?B?Wi92Z2MvMm1Ia2l5UmRhREtONkU4QXB2bTdqQitEc0M5Sy9JNkZQQ3hxNUt3?=
 =?utf-8?B?SXg0Nm8wVjFRSWN4dGs2TWYxd01ZWi9wdEcrTEtndnpXdkxxV29HRjhVVmEv?=
 =?utf-8?B?OS9YYmdSTG1rNER6ZThwcU54eVY4Y04yMkRLSFUramVkdW1aK0tyaGFzQnBR?=
 =?utf-8?B?VnRVaTBwMkJVbzhtaHdDRU9FRm5yNWJLSmMvWVNxb0trNnhua1RrNkc3TXNs?=
 =?utf-8?B?VjFTMnhOU0l5UXc2dnlqYVg1aUJMdlJqOURzTWlTVlp6TjQvN1I0S2h1djg4?=
 =?utf-8?B?OHZlSnpqSW5aOTd6RWxpMG9MNnEvLzAwS3FwTGRjLzdmVHp2U3phV0RkMWZG?=
 =?utf-8?B?Mk9vaXpwVUpvRVdqeHlSR1JyNUVsVlRaWitGcmV3aTdtcWVlNGUwakU4L2hV?=
 =?utf-8?B?U1BQcHBLeG5zL3hRbkZ0c0VPWlQ1Q0tINkRmbjZnNDQzYzdpYTJvTWVDU0NS?=
 =?utf-8?B?SXNDRVFEQ2kxK1VXZEpLT3VDUFNWeWNLbmNkUTdKcnJHaVpWaFJhTExsNjNU?=
 =?utf-8?B?T3kwdHZIdGZ0NGxTeXdndlBOMDlLOFJjUHA0aGZmbVc4UGt5d2I5SGxVTXpI?=
 =?utf-8?B?bXhUOHRPaExUNFZWME15ZnlzQWRFU1BObUZ2TlpaZEI1bUpzUHdWazk5TTV0?=
 =?utf-8?B?Y1ZMLzZYVW9jS0pkQm9ueWk0SHBRaURBR3VXcWd3NjdSY2pEbU80QzRPRkdV?=
 =?utf-8?B?aG1mbW1pUUVKV0lPQWVxOXpOR2cvcmRWc0NxMFJRa1FkYXMyUkszYXE5V3ZR?=
 =?utf-8?B?eit0NU9IVmJrV3hPYjNXaU0xTkxlMmQvY0tlVEdteHRHdnN5NVNGZTE5V0c1?=
 =?utf-8?B?WENYdkdINVVTV2FTdm9NeEwwdDB5NWQzSkprNGRkamIxeFcycDR2L2FsZHBk?=
 =?utf-8?B?UktrcFpIbkpCSks1bWNZZkdjSnN1Q2FxK1RDbzdUVVhtODJJQ3M2dlR3eTY3?=
 =?utf-8?B?ZVg4NkIzdmJ1MXUxSm9QUmdhWXZJQ0laejJVSlJwWHRzTHVHeFF0M3pod3NW?=
 =?utf-8?B?dktVdk1QQXBIS1JLYlp3TUhHQnZ2YmJ2cEMwOHY5QXdVcENCRnMyWHM1TDJJ?=
 =?utf-8?B?dTlKL1EvazRiY0IzWEx4YWsydVBJRzVsR3ljVlVxenc5Uk5qK0krSEp3djg4?=
 =?utf-8?B?K0tZcTZ3ci9iSkRiblVzbTBMa05iSE9PS2o1WmE0UWdQTWZXN2t5eG8rVlpN?=
 =?utf-8?B?Z3QwQnBrRnNRbktQWDEyVm1ZdkJ4Tk1MUm5Va0JpS2daK1IzN25PMlFaWlVt?=
 =?utf-8?B?RmN0OGRqNWp2WWhoTEcrRWRVN1FYTlRwU3ljc0pPUjl2TU5BRWkxZE0vZWVu?=
 =?utf-8?B?Y3dZdzl6SkttMzR0Tm15bHRZYU9kcDVVajJBbWJPc2FyY21WQjlvc1AwUWZQ?=
 =?utf-8?Q?7Td80CnLrXlke9KfQ655j3k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzhiNk5NTmZDTk5zTEV3Z05ZeFMxbVJBOWNLYm10bmNPQVdnM1AvYmJscnhq?=
 =?utf-8?B?Y1A2RTROUnc0bVhPY0FqYkFwSC9FUUo3SGlNYjJDcmJsNzQzUklDYzdEZCtk?=
 =?utf-8?B?ZU9ESnlZSkJNQWN6ako5VnZsVzZnRGxibmpKT29NNkJucHprMlBwazUxblR3?=
 =?utf-8?B?aS82S003ZE5GZjNuOEdGbVhDTTF3T1hFRDBzSG5iYjNUbkF5WDBuSHBscWNL?=
 =?utf-8?B?aytkaVUwZ29KbVZ4MGpXcDFzMGJkc3d3VExVcVFNNytIRFdnTldTZCtEMTVG?=
 =?utf-8?B?K0hZdWtUc0Q1dmhERG1OUjVIcnNKRjY1UXVmSFFMSHE0enI5SFJqOVIwbFVh?=
 =?utf-8?B?VXhqdFhEM2U1a05hU05rUFR0ZHljeXMrYTFiSEQrRTQ0K0RCNmp6QnlqK1hM?=
 =?utf-8?B?ZmJib05hTUM2S0tUSWdQYlVpeHNiaHBhRnlQSEJJbWJuOUZJa3FxWjBseW00?=
 =?utf-8?B?ank4dkZIeHhnNkVlU215WEI2cnhlaURHVjlKMEZiMHZ1a3h5dzhVSlhJR0tT?=
 =?utf-8?B?V2RjYVp0c09HNGdZZE84RWlBK1lwdXkyczVxL1VvUzNZT3dZaWIyV1NpYnlW?=
 =?utf-8?B?dTl1d0R2dnRMZkkzeFNORDF2a0cvZCt5L015VEpCVWkrK04vbmFiTC9qaUhu?=
 =?utf-8?B?Y25RNkt6VHpIa1VRSFRweUNYdUxRRm5YZVljNy83dXpvbjMzMWlUS3ZLTmUw?=
 =?utf-8?B?cHBoclJMZGR3NStRMHlDekU1eGRYeDVQSGpaMURxMXhPcWtxMmpZU0JxQU5W?=
 =?utf-8?B?UU5OK1kvT0Q2eUlvWU8vQXBEYTRoa2xnWmJtbVdzTmpsNnlvYU5NNHFyUHJY?=
 =?utf-8?B?VkIyU2Q2M2VUY0NuWUdXUzRpaUo5clN3T28zYW5xSU8wNUVsVWR4Skg3a212?=
 =?utf-8?B?Y2oxQk5FY0x0RUViVmt4S1k1YWRxb1B0TVBlV0Z1dGhNdkluR3FiNy9oVUlu?=
 =?utf-8?B?ZjB2bFRLSXNER1BpYkc5YjdwZ1MydzBsS1RGaldhcUwzYWl0ZmxVak1vYm03?=
 =?utf-8?B?a2QxUDI1SFEyRnVCakoxTGYyNkN2WmFuUkxxSk9nU1RZUzRtVmlYaytNcnVn?=
 =?utf-8?B?alpWd2N3d1RYa0szVnpsMjdxL1RqM2pkcFdwbW9tL3VHN1d1RjM0MEFGd1ZQ?=
 =?utf-8?B?dlJmeDI5ellqQ2NicExtRjlDMEg3VEk2TDFSc0paRlppdE1OU0RKNUpmZ2dv?=
 =?utf-8?B?RkV2alRUZktUcFFaRlJuYkZ2ZGZ3Wkp2VFN1YXRXN1R2YXJoVE0yaXNkRkFi?=
 =?utf-8?B?ZGoyNnNCcXpXd3N3ZHZJRmJRNGFQdWRkcG15M0Nwd2Q1L3NJWTBIb3YyRjM3?=
 =?utf-8?B?R3lISUhTYmRYRkx2eFcwcWxLSW1kY2tmUnNHb1lJTzFaeER0eCtPUHB1MDdR?=
 =?utf-8?B?TWxhekJJZXR2Vk00NEV0Zi9kZUhpMHlvdXpqekxFMWQrT0t3VmxQUmxBWm5j?=
 =?utf-8?B?MFpueEcreVppWnQ1cUhZWDF5MlovdGRvc2RTSTJ3Z2tXamVSY2doTHN0TTdB?=
 =?utf-8?B?U09wODMvZUh5dnRBRHJ1bGJkTjJSVUtpbzhwSzhLVnMxUkhOb2EwQXQrREV3?=
 =?utf-8?B?MkhHSXJIVFoveVNnd1dsQythaGNJV2dOb2w3Q3djY0U0N0Zza2FsK2hCVUl6?=
 =?utf-8?B?RXZTKzNNWXFQTVdOcUJhdmJYdFRHYmdCYXZ3RE82NHlLSWRnekRIcVo5dXBE?=
 =?utf-8?B?YkNxQWF3MFVMMEFQWW5qUlFFMmtURXk4VTRXbDRaZXBYb3FWL0E2ZTFheGNi?=
 =?utf-8?B?YXVWQUlTcWcrYy9Gc2pudEJOOGdaWmVhM3FDRkNIY0g2bXNLQWQ0YkJ3d1VC?=
 =?utf-8?B?elU0eExMVDM4VkFKcjlMSWZldStFNFdjMnhPYnJDM3llRWF3ZWhIeVhrVm01?=
 =?utf-8?B?aWZZRnRlNkVITlVBTTBKQ1Bpc2pOcXZaWXdmVUJnNVFKeitUTzFsdy9scFRl?=
 =?utf-8?B?OXE1QUdrb3EyYU9CNUNCK1RWV2RmMTZydzEwZFIvYjZJT3BTN01PUWlETHJw?=
 =?utf-8?B?Rnh5R3NybHdoYXFnUmVWRDN1bi9VV1pPaWNDdkhsd05sQUo4bitLUHZYVENj?=
 =?utf-8?B?THltSk9SSjVXeElscmxOVlAxdzR6SUtaQ1dYbVlyOVBXVG16cTRhOTg4RUtI?=
 =?utf-8?B?eXl0Y2d3djlxZFJHYVlwMzRMdXBMSnVndE4vM1dlbnRyeEIrQm0vUjRWNmYy?=
 =?utf-8?B?K0EvMlczb3ZldEVLbFJQMXVWQlVrdGRRMWZaRWNqR0g1dGVEOFJHNFdwMVhM?=
 =?utf-8?B?NWpOVzVtdnd0NktvTEFyaHNwclI4WWhDc1FUMU1CblBzR1BObEhucjhCZjBI?=
 =?utf-8?B?UVlhVUJjS1FzYUlWUllKNkJUZXkyaHB4c3JCbFFIZ1orWkN2VlhtUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec3e882-570d-4dfd-96fd-08de5a438008
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 05:51:48.9957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QpuhOoZDWxOQXknLZG4gaCAEnrpJ1/1Jod0RLGrsTE/rIvUoy+Nx6pbe9H56sQGyWmlPE6ji+TeF8z5rNAVnH6Dii0IPYPOHnM2n3CtJXS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFD77119BF5
Received-SPF: pass client-ip=40.107.75.141;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYywNCg0KSSB3b3JrZWQgd2l0aCBvdXIgSVQgdGVhbSB0byBpbnZlc3RpZ2F0ZSB0
aGUgbWFpbCBkZWxpdmVyeSBpc3N1ZS4gV2UNCmlkZW50aWZpZWQgdGhhdCB0aGUgbWFpbCBzZXJ2
ZXIgdXNlZCBmb3Igc2VuZGluZyB0aGUgcGF0Y2ggc2VyaWVzIHdhcw0KbWlzc2luZyBES0lNIChE
b21haW5LZXlzIElkZW50aWZpZWQgTWFpbCkgc2lnbmF0dXJlcy4gV2UgYmVsaWV2ZSB0aGlzDQpp
cyB3aHkgdGhlIGVtYWlscyB3ZXJlIGJlaW5nIGZsYWdnZWQgYXMgW1NQQU1dLg0KDQpXZSBhcmUg
Y3VycmVudGx5IGVuYWJsaW5nIERLSU0gb24gdGhlIHNlcnZlciBhbmQgZXhwZWN0IHRoaXMgdG8N
CnJlc29sdmUgdGhlIGlzc3VlIG9uY2UgdGhlIGNvbmZpZ3VyYXRpb24gaXMgY29tcGxldGUuDQoN
CkJlc3QgcmVnYXJkcywNCkthbmUNCg==

