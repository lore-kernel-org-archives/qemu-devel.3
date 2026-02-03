Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37028E83062
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 09:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnCHP-0006ZK-Rj; Tue, 03 Feb 2026 04:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnCH9-0006YK-LS; Tue, 03 Feb 2026 04:00:47 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnCH7-0006T7-5t; Tue, 03 Feb 2026 04:00:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAg2ELA4nXDVoU5KV1BIGudCQM6CxH192mGg+Nha9nIm42fIPo+G+Ik40cB6ebboofCH4WCiGWUJgW3+HdTOOLYeZoFh/h8JVXq5k5BcyhuDfyl3h5bG80tHVqvkb/XkFPC0n2Tedgf+RDJEVt3rFRP2fGqH6SRC8cEZI95onFG7lRGBM7TEUzzwejF8B/eDQDSRNUwlaXRQZ7A8lRyJDg/0fLRz2XTudCu+J7HlgfP7pwF91a5BdrG5v9W3yrhjJPYG3labB8Rt624KGTC3ADUu0+3Jjib8yknMHZTubSudl/qNwkL7XIr3FKirOA8KGHB0hNBtqGOHBZxdx2DN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GA30YdTR0gN4aFefYJxbT1ex/rLr2nsdMlhfwKXFXTs=;
 b=MsXatUDTFAL4vLMa9o6gztEblyvpsP/766BALXrju/KQYx735bxHDx15sZXk+VgzNLET/q3+4jZmWeXGx0SD0G1TLHADIol4LOLH0rJ28RyLbc9BrJVL+3wsPkoiSx8C8u18AtHwWKezxrcPAJV2lQS/M0gyUv+40/bp9cOmDbd6JUF/i7n+2zBplq67qZ1kVtwHzJi2Dwo4v56OFBQSks+3bmKxiCKoVm67BntLw4tjQ61saE9z9gqO5jiDzikIUZlS4ffU6I5MNTsJ8WkGj+vFTpG0c0KUr5ZlPG/u11Wn/x9izQeM0XDjdaDtvz38K3wNWx2FtrtdtN3PToJSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA30YdTR0gN4aFefYJxbT1ex/rLr2nsdMlhfwKXFXTs=;
 b=UOxnTBQ5nljLZSwRV6pTorjafH2iofGzQYTZDveuatm9Ao2v5uwHB/1GEH/ulFXbZSPZNrQ4kXgQDLtdICiuzzStdtbNNGs0zTSL+0Olb7MB7RGaKnY/2Qr2QTrfucf0b8dw01WnZC0vE6QKtGFMX9hQX5nwIJWLZyHPqtXcoFkaTSfuax1stCrx6+YTLZ12LUWu4p7Iif5TwJkJDuKIiAY07OEW6vWtbZeP4nriQkEiqwlIAO/Wizfq4nTknL2vwOcwGt9RmmwMvbWPZqbkd//bI27MTv7sSOQwa1w1EKYZCDlS5g3O2sBcST0EgcTAqzZAQiA3gvaFwJSJCy0CZQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8226.apcprd06.prod.outlook.com (2603:1096:604:45b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 09:00:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 09:00:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Kane Chen
 <kane_chen@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Nabih Estefan
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: RE: [PATCH v5 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Topic: [PATCH v5 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Index: AQHcicxLj69gtQDV7UaGII1il83Fe7VbOqAAgACSMECAA3ulgIAABE0AgAsZXoCABlvK4A==
Date: Tue, 3 Feb 2026 09:00:38 +0000
Message-ID: <TYPPR06MB8206F29363725A1F5929C6BDFC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
 <1433fb86-bb1b-41f7-b7ec-45560e52146a@kaod.org>
 <SE3PR06MB81997150B11579509E3B31C1FC96A@SE3PR06MB8199.apcprd06.prod.outlook.com>
 <ccf7e1e6-f7fb-483e-b69c-32ab15a9ce0a@kaod.org>
 <TYPPR06MB8206E096C66EF9C504F79146FC94A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB82063D551A78C621B00F399DFC9FA@TYPPR06MB8206.apcprd06.prod.outlook.com>
In-Reply-To: <TYPPR06MB82063D551A78C621B00F399DFC9FA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8226:EE_
x-ms-office365-filtering-correlation-id: b138fbc9-3a0d-4ed5-fa08-08de6302b36d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cFZPS2VxUXZaSmhHQW9SU01PMlNXcmhMZFRxKzRyUTBvTWZSa01EQURFUlJa?=
 =?utf-8?B?blVnMXZjNVE5N1VlU1dXQ2NYZEV5dzZFRWNlM1VxUmZyeEhkVERtb3VtV3lW?=
 =?utf-8?B?SjVtSzhvajVGY2hyazR4bzZPTDQrRGpkWjZnUDdCOFFtcmZ1SDZ0eWttUjJ2?=
 =?utf-8?B?T1JzZStrMXFZOE84NGR3OW9TemRTWC8vZEZsZm1TTCswYXhRbkJXMi81L2I4?=
 =?utf-8?B?ZkNHQjUrT21QL2pVY2d5NXZaRml1cUg5V0dXdnlabERVcVF4Qi9wV01PaHdB?=
 =?utf-8?B?REhLc0JlY2VxZzJKSHB4eGFxVTdVcUZ5a2Jndi9VQzE5MlBhQStNSUt3RFA1?=
 =?utf-8?B?UkswYTBTN2Z0aDBTenFvV1B4TXdOd2pMYkRwYTFGSVhoYUZMU1dTQXNyS0pm?=
 =?utf-8?B?RTlHd25sZFNta2RONFphQUNWUkd0V0hvY1hwa3Jpb2dzNFRGV0tjN0NMWmhH?=
 =?utf-8?B?UU1ETGt3UVJhTHhZelFLY210TUM2VVRycktBVDIyNzVYbldKRUZ5aHVDNHk0?=
 =?utf-8?B?NXgvODU5cGkxNmthdnZjbXVqVURNUStkUmc5WjY0ckdta3JBdFdqRmNrOWFZ?=
 =?utf-8?B?NXhTZ1Y4eTZPRzlnamJZOVg1b0FXWXZRYU1LWEI3a1Voa3pWZGQ3VTBQRzRT?=
 =?utf-8?B?NEdWR3AyYno2NU5UWm1VMjhORGFFKzJqa2V6Q1piZWlzK3FjUy9rN0s5TW4y?=
 =?utf-8?B?TkoyZDFGVWQwelNNNTl1STF6QUo3RXhwc1RlamhTdXlFRW9reWJXSHowZFZI?=
 =?utf-8?B?eFhMOTg0NVpIL05CcktmWHJndjR1Sy9VMzlVTi95YlBTNVlvTm9DZU9UUW40?=
 =?utf-8?B?Rm9kNjU1NnliV3djR29HUWFjQXhvSWgrTVNVcmlPaUoySVRueHNkdUVsWVA3?=
 =?utf-8?B?NXN2cEg4dVI2R0pjRkhGWjdYQm4zeFBsbE93LzltVEc4Zk9seUtpemlpdUJT?=
 =?utf-8?B?ckExYlVhaU51eU45a1h4a0llNnNoaTFjWGZPak1CSSt0WFd1SWhXZGZrRWtI?=
 =?utf-8?B?dnFOSFRYNm0wbjFrM1VOWkcwVXpxanloWllQQVEvVWhZOVhVeXdVTUtNVEI4?=
 =?utf-8?B?aVkzV3lJbjA0bGI2TWZieFhxUUtnYlNneWNRdzJzWFFXTGFFdWdicCtWQWhn?=
 =?utf-8?B?MEtCa0hZSUNiR3IxY0dsVkhITXREdG1id0R4RHoyOXNEblpHczJXVUN2V0x1?=
 =?utf-8?B?OHVUd2U1RHFwU0VTV0owVUkwbFczNE8rSWZuZCswMFJ3dXdLZTdXYUpobE8w?=
 =?utf-8?B?MlNBME5vQ01lSTY0VitRM0RTbUlDZktxRnp6UkNTMDVnN2VPekRDVXdYRGY1?=
 =?utf-8?B?b0VFbWh4TGNkTWYzUVJHbXJmVmtidk5JNHh3d0xESVhnYjFrakptK1FhZkhx?=
 =?utf-8?B?RU84OEtKTnNmWjJ2Z2s4R0U1Z2I5MkRWdG5sbk1FdGJlZmFyM2NDd2hMNS9o?=
 =?utf-8?B?NUZ4Z2xHeC9YWXQ4L3FEd2ZYVmxvK0x2YWI4NTFKNXV0aEJHbWxwak5JcnBr?=
 =?utf-8?B?K0dma1V0VXprTEk0VzZYcG0rc3VISW55YVVnQzlDWEdsSGpXYk1Uemc3b0JB?=
 =?utf-8?B?b0tXV3Z2S3VmdGJvWG5vZHltQ3dscnVkMmhOTzF2UGtOc3duUElNTHJiQU9W?=
 =?utf-8?B?SlRhd1dCTTkzdHArVmNQald6Zzg2azRnSU85aTQ1Si9ESWpHQXM1Q2tQdi85?=
 =?utf-8?B?aHAzMHIvamtkTzY1UVJSVUVSNEt6dFJmN2FxRm1WSG5qaGtvOXRTU3Rmc3p5?=
 =?utf-8?B?S1RNeFJ6NjQrMjRHN1ljOTkzb1I4dnJ1dHFVcHI4UW5PVkNzZjAzUjJkWEJL?=
 =?utf-8?B?L3ZvNkc3YXBNd0xRTStDbWp2OVpmMlo1MUNnbDFyWkl4dWFlMUhpK1lXTjB4?=
 =?utf-8?B?dmZmME9tZWdlZWFjd2xOUU52NW5CZUdUUG9pVm9ZL1o5QVVoZWoxdjVKT05H?=
 =?utf-8?B?ZU9GMG1obGZQakJWbHJVb3dLdm9sbmY0OFhGMUZOWWR2VisyaXJGZWtzaHZQ?=
 =?utf-8?B?aTg4QkVUdHQ0YTJiUEJOaGtUeU1BRnZITUwvS3EvMk4vUGlKRWNYNjBFckZm?=
 =?utf-8?B?TXpodCt6eUNTUm92U3ZYdnJsYXlUUjV5UGN2bis3bFpYS0o1QW1LVnZveHh5?=
 =?utf-8?Q?3iBc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm1tYUdreC9udHVrNndJMk5xTjdvUHlLSUdLY1RvckJDR01NQVQvd3dmbHFE?=
 =?utf-8?B?ZzJVNGlWUjdSd2FpdWpNeUZ4MFdhRXNMRk1KdnV6V2p1YVZGTGNoQXlPVUY0?=
 =?utf-8?B?bE53aklTT1QzMURoTzE4MTR4ek1VcGJxUytkZFVuZTZYQjhodXVsMkhhaXBC?=
 =?utf-8?B?ZmFLWHBUZ05WWDFFM0ZxMDR3aVNGZjlid3M3bTFyelNZNFlyYkh1R3BQN1NX?=
 =?utf-8?B?UVUreXVSc2tUQ2JzMFAydUVUeURYNFl1K2llNmc4c0FKdG03UzFRQWFJbUQ2?=
 =?utf-8?B?WmJCRFRhOUNvNXUrQ3VyOFRyYTNJUjdDd1BTQytISmhsWFdQTVc0Yk1xeUNm?=
 =?utf-8?B?YlFyeVpwRW96MlRDbnpkL2tyTFZJWFNXWjVwRHowRWFJYVdRdFQwNW8zTjZv?=
 =?utf-8?B?Wlo5LzJxUHNXNVB0OUhnZy8xR3d1ZWFOWHhlVTBsaUxJbEtnT0dQMVNHM3c1?=
 =?utf-8?B?YWsyMVA2ZlFjeXhtVFlxbGs2bTN5RDNFSEE1RTBOR3lTdlViRHVuY1ZZV2xQ?=
 =?utf-8?B?K1dFZkxhM0hSaUNpd3dvTUU0RDlCVTVwQ3JVKzAzQmRIYStJT3NEdVNUeFFh?=
 =?utf-8?B?TWJERHgvSnRMZG1UbE93TDRiVk01R2VTL0hGc2d0aHBVd2RLNkZoaElIVUwr?=
 =?utf-8?B?K3RGU0QzaUY2WDdqM1BKWk9lWXd6QnpYRENmVU51bmJHc01ZcWFrY3lXTVpS?=
 =?utf-8?B?YzFTVTQzQUVSTW5yQklmZ2dETmlJZ2hTNi9MTnE3aTYyUnFWVXFlUHdoTFNv?=
 =?utf-8?B?VkxocGV0eXBoOHBwdmlIWmIxbitNMDhNK0tpbXJwTkZDMWsrZHVoTmowOW5x?=
 =?utf-8?B?SGlhSDdDVFByQkZGWW5qYUZNc213dGFiVnpvUnA3OXdtM0VhM29OdldWbXFY?=
 =?utf-8?B?anlEaXU2c2M1ZjJ4cFRpUGQrN0NKQm5hUHdjU2h6anQrRmNaejZFdSs5UlN0?=
 =?utf-8?B?bXRUVTNzV1FES2tHZEdZUGkzK2IrQlAvU0I2N1J3MGRhbzdtQjN4UW41NXZm?=
 =?utf-8?B?LzBxckxKYmUxOERNT0pkeFBHOUM3dlhjVEdxeksxV2ZIZisrd2M1TlNMOE9S?=
 =?utf-8?B?Z21yd3pZZVd6U2hmU3VWRzhnMW9ocGJFTmw5aDdJSlY3ZTJKV25Ud1BjMTVV?=
 =?utf-8?B?Rm4yem5nTGp4Tmh6c3k3ckUxUFlzNnZwMGIreDg1WGhEZDBmelRnZmFNdEZC?=
 =?utf-8?B?VUdmZTBTTnF4WHRFK0FUZGJTY3gwckpWVWNLVytoNlFPRXJXOEZxWjBEaHRw?=
 =?utf-8?B?QU8rQWdtQkE1b295Z3d5YTlRVFVhbGJSNUkvVVBERUVSUldnWjhLS3cwZUNu?=
 =?utf-8?B?cFU0NGttNWRkUTdMUCsrNExrNmhTZjQ3SEdhM282TXo5dlp0YmcwTG0vdEJz?=
 =?utf-8?B?cWFNT1dTUTZFSm5WaDNHd3hlNUlXa3I4UGlGMDIycHNkTFIycUpWS0Y4Vitl?=
 =?utf-8?B?YlFiTEswcDVPWjAwT2V3ZGdzbnBFQVFsK2thZFdUbk0yRmFBakZLZnhDb2ts?=
 =?utf-8?B?UXp5QVJGMzVJS3J2NnBSOXIvNTcxMjlPcmoxZVV2cHhDczV4czVNcC9lbllm?=
 =?utf-8?B?R2hzVmVXSnhHRU1ZdGU5YTh5ZUhKcjArU21GYlg3a3lJM3VBanFzcmFMTFgy?=
 =?utf-8?B?MGpHUkZFZEltOVpCWDlGY3p2Wmg3Z3BPdEtEbUgzQWkyT0dScGFmUjdIN1lz?=
 =?utf-8?B?bWJCbEtuQ2FPRXo4c1kzY1RKcUR4amtxL1JCMDlOdTU4ckN3c3hiWURtd2hR?=
 =?utf-8?B?ODQ4VlhPdGxsQ3psbmp2Uk1nTHQ5UmlLaC9zL00vRUNIUnJrcHhNb2t3OUJo?=
 =?utf-8?B?OVBNU0p5QXVpczZCZTRGbU55WHVqT1l4VmtsQzVVSlo2NEFod3VzTXV4eDJ2?=
 =?utf-8?B?dWVyT3ZkaFFXMVBzeWFpd2wxelZmSnNaWXVFZWpMSDgzcXNjaEpTU20zQkwr?=
 =?utf-8?B?RFo4bW9pemhXUDhKbW1sb21BeDIzTm9RSjU4SUpncGFrWSs2M0toOUVWRnNZ?=
 =?utf-8?B?d1BnTTJiaklJU1IwZE9FbUJGejU0V1dHc0k3U1VtdDJuVllycVVJaVpNeTRJ?=
 =?utf-8?B?aGpZTmxKaXBpSW84U1AwaGljYmFxOXkwYm5IaEpmQlZnaWNPclFPTXQyL0xQ?=
 =?utf-8?B?Y1RvUkNQU0tOK0hxbU1JQkt4Tmlza2ZDbi9tV3FLekRUSytDWndBNzJCc1A5?=
 =?utf-8?B?UHM3NUh1VHM2QWx0N3Z5Q3hiYVRoS1ppbVJ4VCs0SVd0MGVKUGwrQWJXdHZh?=
 =?utf-8?B?UEpHQTAzc3RkdFJ0L2ptVUNhQ2ljTTNDNVU3SHNUbmpVMWRpYURpU0cwclB5?=
 =?utf-8?B?MWhZUHFwZk0xQytBNFhaMTVmdVB4SzJMaDVnTGtVVUhONmdPSjhlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b138fbc9-3a0d-4ed5-fa08-08de6302b36d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 09:00:38.3957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tr4ALcmS7QWzVB9G/9Gwy6rNRTCH6TH5vtzIrpvXJJiUoxTIAy2aE8kJ3APWBngcGWNoe+I9D6Slg/ZpGCvzWyWHJPGgEkFI9fdtbh7Bs0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8226
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

SGkgQ8OpZHJpYywgSm9lLCBOYWJpaA0KDQo+ID4gPiBXaGF0IGFib3V0IHRoZSBJM0Mgc2VyaWVz
ID8gQ291bGQgeW91IHRha2Ugb3duZXJzaGlwID8NCj4gPiA+DQo+ID4NCj4gPiBJIHdpbGwgZGlz
Y3VzcyB0aGlzIHdpdGggSm9lIGFuZCBOYWJpaCBmaXJzdC4NCj4gPiBJZiB0aGV5IGFncmVlLCBJ
IGFtIHdpbGxpbmcgdG8gdGFrZSBvd25lcnNoaXAgb2YgdGhlIEkzQyB1cHN0cmVhbSB3b3JrDQo+
ID4gc3RhcnRpbmcgZnJvbSB2Mi4NCj4gDQo+IEpvZSBhbmQgTmFiaWggKEdPT0dMRSkgaGF2ZSBh
Z3JlZWQgdGhhdCBJIHdpbGwgdGFrZSBvd25lcnNoaXAgb2YgdGhlIEkzQw0KPiB1cHN0cmVhbSB3
b3JrLg0KPiANCj4gSSBhbSBjdXJyZW50bHkgdXBkYXRpbmcgdGhlIGZ1bmN0aW9uIHRlc3RzIGZv
ciBBU1QyNzAwIEExIHRvIHZlcnNpb24gMTEuMDAsIGFuZA0KPiB3aWxsIHRoZW4gcHJvY2VlZCB3
aXRoIHVwc3RyZWFtIHN1cHBvcnQgZm9yIEFTVDI3MDAgQTIuDQo+IEFmdGVyIGNvbXBsZXRpbmcg
dGhlc2UgdGFza3MsIEkgcGxhbiB0byByZXNlbmQgdGhlIEkzQyB2MiBzZXJpZXMsIHdpdGggYW4N
Cj4gZXN0aW1hdGVkIHRpbWVsaW5lIGFyb3VuZCBtaWQtRmVicnVhcnkuDQo+IA0KPiBUaGFua3Mt
SmFtaW4NCj4gDQoNCkkgaGF2ZSBzZW50IHRoZSBJM0MgdjIgcGF0Y2ggc2VyaWVzIGhlcmU6DQpo
dHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAyNjAyMDMwODUyMjkuMTU0MzI4Ny0xLWphbWluLl81
RmxpbkBhc3BlZWR0ZWNoLmNvbS8NCg0KVGhhbmtzDQpKYW1pbg0KDQo+ID4NCj4gPiBUaGFua3Ms
DQo+ID4gSmFtaW4NCj4gPg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4NCj4gPiA+IEMuDQo=

