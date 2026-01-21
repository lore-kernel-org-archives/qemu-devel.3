Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB81D262AD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 00:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viMSS-00016I-1p; Tue, 20 Jan 2026 19:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1viMSK-00012d-U8; Tue, 20 Jan 2026 19:52:20 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1viMSJ-000346-2k; Tue, 20 Jan 2026 19:52:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1SvKU/UabPLFPbhH0T+iAJX2C/XmiLU250krMNwwMV5ZlV85xp7zVNfj8e/WiTZCLh2CXEh64myE663UsVxCy5YBAA55/DKQM2X9U9l2BnB8uMjyE1MEp+59jOnWIXExHjBd+pc4UwMQskHf6SSWnry6n0T+d59udOs0HegTBAx7rr5fKq78OwtDx34nswTxEd3/M6Clo06NtRoLz5Hr1HroDB9PHcz9KFQY9nowCXKNC9StBId+jPWw7dFIOBhigTyqInL4Jd3Zc6FJEcpybi+WolSzf2B2qAGf2mDB9HQQbtOLd41mter0za/adHt0THSIwsLB98IcZUABJrjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fs7bIJjvIFTbISufgjfRU2Ad+7VDa6QFGrGVveOvXM=;
 b=djPZ8cwoSRVBC/BB4+WmDkJKxNDXTmBz+e+b2j/7d51g5NPfY3dz1aha38fH0hIoSNsPuBPIJXblQELd37y2vMTiBRlEMp1/5V8wojDwr6QeJVj/s6WGtGTnKcOGUgq++Mjm7MuFyP56o5yzsquNstgfYZBIVF7W24C0ydWFwsFuYy7kiTDKKEjjSN54iUk4bMNMAsSCWWwxL/t7SfNE6gRgXty4j7TZFAxePouM2uBdff8j65xKx1hCKsVQ3roFRAIIWjwrR62CrRhi1w61qwN5aUVOQmEHQK+kXMrMDkNk0vhT2puwF/zr2UTbXiioZ9N4Sfkbyz1vGFEHp4lTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fs7bIJjvIFTbISufgjfRU2Ad+7VDa6QFGrGVveOvXM=;
 b=OCeNTBljfz5o+PRjZjETR6g/FRE5TIxzFxd6AtbFMWT2C6c4OFXuwRf/1z0QCJpXC36BuCe9OBw96+STRmTApKeKVbhTSo/AuM/NF/Uw7bGcDaly7Z5QmLKVHCHPF1l5h1bkzOkEtRh9E74JM3tTvPQB8e2T+Z+oZ3d1eQCTcRJPdO6w7qfqx6dDgHgCh9cFwWJPp80dLSoXgThVpJ4bFe+3t0Unlz/47YKon7/zcQ4a8nJzu9Cd7AukNdOXvDkahD4PrbvfA05J2a/huLX+Ifh9mWx2/Whu4MDlcwY+WP4rAqvKu//q+WbRUW3VC5eDPAqmVVAd31UGlqJH2LITRw==
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com (2603:1096:101:2f0::5)
 by KL1PR0601MB5613.apcprd06.prod.outlook.com (2603:1096:820:9a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 00:52:11 +0000
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b]) by SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 00:52:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Nabih Estefan <nabihestefan@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH] hw/i2c/aspeed_i2c.c: Add a check for dma_read
Thread-Topic: [PATCH] hw/i2c/aspeed_i2c.c: Add a check for dma_read
Thread-Index: AQHcilFVTbLky3mg0k2aCRQ17ImAbrVby2yw
Date: Wed, 21 Jan 2026 00:52:10 +0000
Message-ID: <SE3PR06MB8199DD280F78213F0CB5243BFC96A@SE3PR06MB8199.apcprd06.prod.outlook.com>
References: <20260120211116.1367476-1-nabihestefan@google.com>
In-Reply-To: <20260120211116.1367476-1-nabihestefan@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8199:EE_|KL1PR0601MB5613:EE_
x-ms-office365-filtering-correlation-id: 6438274f-72ce-47fe-a6af-08de58874f78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?R011SUVzRjB4bzhQSGh3cWplV2JGdWF3UExlaXkrdGVVNTRmTnFFZExXR0ZK?=
 =?utf-8?B?TEtUNnQ4Yzh5ODBlNlFwbENzeGxwVkQxRk9mai9oNGt5akh4T3ZOaXF3andh?=
 =?utf-8?B?RWQwR2lWN1JaSlVPbzEwRCs1bFJqcUxKaFBjR1dCZ3FzQkExenBsZk5ma1pB?=
 =?utf-8?B?Smo5Vmo0UmxidEFmelJxNk9WOFNwbWtYTVliUlNkWXU1ZXJtZ0dVUTBjYzBO?=
 =?utf-8?B?K2d4RkJOb0poR29jUnVkL0gwMUJVL0JXdVJzdG5LM2FZcU9oR1lrb01OMW11?=
 =?utf-8?B?d0ZMZEdKVnlxQnhFMlFRM1NiaUNtVFJuOTV2L2t4aEQzVGl0NDRmbndadUZv?=
 =?utf-8?B?WUZUYVE5dFhFVmNKTDZOT3VYdE1Tc3A2UGdlVENYLzc2aGRWNjIwL0swbWNv?=
 =?utf-8?B?ekR2QjUxQ0pieG8rTTYrK2srY25XNW5TQndNcHliS084djJON0svbEdBamEx?=
 =?utf-8?B?WEF5MDc5eHZBckNFQWd3NVJaTXpSd05wekI4NWlweUk3UWpzM2V1MVp6NkdW?=
 =?utf-8?B?TVVpZW43cHI1MWtIa3ZtMU54NzJBYnpld1ZpUTRRK2Y2elZZbE9sWVE4eWhW?=
 =?utf-8?B?NjJ0L3BZazl3dlFyRVZEZTdiWG5xS2g1akhWaHRtOGFOWW50TkRML3dQLzZY?=
 =?utf-8?B?WmM0M1dHdjZaOWxadkxlcmFIYkdXd2RtSWNVNGp4Z3N0L0x6czltRlpFRkow?=
 =?utf-8?B?NmE4TjhsZFFsWmxDMDdoc1FpdU1HVzFQMWdXdkxxd0JoRDNScFl0TFZzNmc5?=
 =?utf-8?B?aHNlbThKa2RCUExqUWRHY3Q1OGpmYUpLOExVTUE1c2pwVXNhSnpIRWtZdW9x?=
 =?utf-8?B?Ujc3L3VlaDBUcjVZMmdhLzFkRi9MVGQrM3NGa1NtWFNjSUIvWVVJN2ZJZmh3?=
 =?utf-8?B?cUdZNDFXRno0YzJCSXpsMGVqWjQ0eXQvQ1hOTTFldHlIaWZ2eVpJVE1pNmNY?=
 =?utf-8?B?VDIrd3ZnZ0tmck55by9PeDFpSll3Wi8xMXplcktndmhNMlUvbmg3cFdJQUtT?=
 =?utf-8?B?UDMyMmRXWHV3cXB1QWpJRzdVQnNsamJIS2V5US9iQlE2OVhodWZUWUpYZ0NX?=
 =?utf-8?B?NDF6OE9aMDlFTThQaFRQWHU3bjExMWRvcHZKaTBtSUEvQmpocjZkOGJ6TU5F?=
 =?utf-8?B?WThwYm1YNk9SZWVmSy9VU21nTE95bVhSbGFjY25JTnFFTmtyYVdXa1BBV2hR?=
 =?utf-8?B?QU1NTitXNnA2TGUzWXpta1RTaUJyR25NN01zQUFFZSt4dFZzZmZINFl1UzZZ?=
 =?utf-8?B?bmJSZ25hZHV0dUpqVU9vS0N3cE9XekkvUGEyWHY4R2dKK2ExSGhOWmFPV2Y4?=
 =?utf-8?B?b1ByeWw4YjhDYXdKVTY0ZWRzMG4rSkZzTGRaWkZxSUdkZEZDL2lGcUxmazEw?=
 =?utf-8?B?N0lOYXRxMFZGbi9ldUowcEVFUEZ3YzYxWXVldkw4Q1VQUjdScDI3YXZzS01U?=
 =?utf-8?B?aVhGWG5MUkl4d2EyN3dITk5kdmVIdTdvMnZrOG95Q1QwK1RjSGVQcUFZSDVp?=
 =?utf-8?B?azZ6S09LaXRhMk8yS1ZCTXRtaFMvVHl1akNYQjQzUG5rUFZ1dlBmN09hQ2Vi?=
 =?utf-8?B?VWhySEZOK3BDbEEwRHIydTNabnpscFkweVpPTUgxcDNhMG9FOW1PaFM1dGg5?=
 =?utf-8?B?L0xZV2dIRitsVkgrajdIemVYL01RaWJXL1ZEU1R0ZmJxaUxyMEt6cEo1cEJn?=
 =?utf-8?B?S2tmTzZVUWtyNkRWc2NXc3U3bDBRZWxCVkhKYkJtdXBiUGRNQTJmYVFGc3VR?=
 =?utf-8?B?QXZrNERLcno5VDVXcmJsLzdtcExyaGxLVW16M2w2V1U3UFcveHBseStOMTJ4?=
 =?utf-8?B?a2RvYXJYckVtTHIvRk4wU3AreXRUTEhQQThKT2EzMmJuTVp5aXI0am1lVUFO?=
 =?utf-8?B?VDR5Y05NalVvdGo1WFNtVWhJRHY0NTR1Wk1GTnk4a2lVbWRnNVJrbWkrMW1T?=
 =?utf-8?B?SHZlZjVienJmMGt1MTdHdjlHdWhaT0dVR21td1pQbnNDZ2VwKzg2bmxLR0t2?=
 =?utf-8?B?cnBxZ0hDdGpDN2Z0YkxFa212Vkp1UW5RMXlMU0prYUpaTndCTlRoUnBKYTlj?=
 =?utf-8?B?OEJodCtJcVpoVm5PQjZXbWJySUJVeEFGWDN6aG1vRThnZCtCUHJiZm1DZFIr?=
 =?utf-8?B?cmFMM0NXdk96NER1SjFMOElTVmtsOXhGNDk5ZWg2Um15RzZiTE1ib3h0amJr?=
 =?utf-8?Q?nATtc3i5B62Fwdg2xdxZqrU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SE3PR06MB8199.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzYyUTBYWGttN0dDNFFwdnhGWXluVnRENFhIdUs4T2JaNWpXa1ErT0RHY09j?=
 =?utf-8?B?NFRTdzFBTDE0YTkxK212d0FiZmFWWjdJQVV1Ym9WMDRKdDJwK3Y4YS9oNWZP?=
 =?utf-8?B?N1F3bCtqQlk0WWZkWHBQMitaUzJxUUFwTzJha3psQVZ5bXhoZW5OSHhwQmNZ?=
 =?utf-8?B?Yksya2Z6ZmEwZ3hKV2NNeUh5eGRRU29MSFlNbG1JVzZIMy85NE56dFFqa0ln?=
 =?utf-8?B?ZThROU45NjRma0JBZnNTMmJVT2s1Z09rZm10TXlVMi9ELzRWazczNnRrTkU3?=
 =?utf-8?B?T3gzY3RhRG1mbXBxQjBPM1BtYWc4MTNOUWNWbExuYVEvWkY4ZnZiYk1zb3Y5?=
 =?utf-8?B?VEVvaFBIWkdEMENIMEVISmNEK1EyZHl4SGttUldBTnNBbkNDZTdYaGx1bENj?=
 =?utf-8?B?QlRYbnJ2QlVTa0l6UFAzQmp4QkJQZHZWTTFJWUhWVEFQN3R5MXFWc2cxZHR0?=
 =?utf-8?B?SEg4TEgyZGpwSkxvaEsvcVhWVk5ISmhxaU5BSlRwV1BMZVFESE1qdEM0ekc5?=
 =?utf-8?B?WWNMdnMzTXE0VDZJTzhLRFhadkdiT0plbTdzV1UvS3hYeXV6TW9VUHF4aDFM?=
 =?utf-8?B?MWpCUDhtU1lMTnRUQWZRdEQzV3d4ZTVGNFNqRzJSYmlsT0xUVE1KQm02dktK?=
 =?utf-8?B?OWFaU1FDNGFFK1Q3R0sveWJ1SmZFb0xtQkNZeHBmMWp1OGJlRGZraVJNT2JC?=
 =?utf-8?B?UG9sdDh5RlFPcXVXeVFkZ0ZLL3VTWW5QWStza0FKVmlnRmV5c0N6RGVQSkFj?=
 =?utf-8?B?Vys1ZHBVSG9ORHc5cDY2c2V5R2JoWjg1S05QV1E0L21kS3NsUUhod2JTaFV0?=
 =?utf-8?B?eUZndHY2VEt2QmlCQUJUVER4QUFqbE5NVDJydXIxSmYzVFk2cjF0Y2tCaWRI?=
 =?utf-8?B?bE1ydERTU2FVZCtQUC9QUDlERUIrcFlxdU43OFFZUHpIS1pjZ0pna3pubEZ2?=
 =?utf-8?B?SUUyTlQwMGQ1V0piQTVIZlFXdzZkSnllMDQyWDBlN3pPcEJtYTI1eFFNVmZD?=
 =?utf-8?B?RGxJa2I0SE5OTnNNWHJUZVA5MHNDdmZZQ1R1WDlZUmg4Y3E1WndQRkNuOFFQ?=
 =?utf-8?B?MkJPZXU5NEd3UkxJYlcxU0hsNmZ6b3ovbVNGWk9IMW4zQThZSkM4aktvQlBu?=
 =?utf-8?B?RkFDRmE5bDQ4V3hWeE0xd0YxVmlxcWZDNU1HckFKcTZ0S3owdmM0OGUwdGRW?=
 =?utf-8?B?WVlrKzVyb1VaUktuYi90bDN2cm44YVM4ZnNyQ1lyNUhJN2FERDVxMW1DWmhM?=
 =?utf-8?B?eWU3aUlBQWlwUDVxUGpZMSsrdnYyZGlaV0tTNERvS1VOK0ZrUU95QndjWFNr?=
 =?utf-8?B?WHd4dEFNdlo3VVJ5U3MwR3N0ZU1CMDRVajlqSFJySzkyTmlIZGY0NmZ4Vmln?=
 =?utf-8?B?ODZnSldCSTRMUzh0UExWWmlHM2xOZW5ROE5jTXhkYjZNSW9pMU1uQ3dGZWVW?=
 =?utf-8?B?RHVNdEVieGk0V2tmeVVOQnc0QWN3b2tSVUVZQ3UzelJUeGZSS0h5N3FCbGpY?=
 =?utf-8?B?aU1ITFA3NWUybkVJUHVjSHZGeGEvbjU4VDJFNFJiK2dPN2xXUFZHNFdTUEJj?=
 =?utf-8?B?OTVKd1RjUDllajE4d2xES1J4ejUxbnFMNExmV1F0R0Frck5hZVllTmI2Ykx0?=
 =?utf-8?B?OWYvRzZYdjVPWVZ4TldWeVFJM0ZqSEE4M0YvU0lZaGFobG1zdjdTNTVUdUdi?=
 =?utf-8?B?eW5qSDlZZzNTSEZJSndQM0V0eFlQaVkrMXZhbVFlajNqOGZhOHA5cDRqdm9p?=
 =?utf-8?B?MEloY3ZUUnFoWmE0KytlZThwYUNQQWtrTnorY3gvL2FITUpkbXl5VWZBdUlv?=
 =?utf-8?B?YUxFektoVDRPbjNMeE1lQmRLdHZzcEVGTHh6TDFWaEUxeG80SFNJbmtXdGVo?=
 =?utf-8?B?N3NIanZCcUFkNkVBVEhqQlZuSFFYTVRTYXpJdCtmak9rbHAvT3h6M2ZsS3c2?=
 =?utf-8?B?WkpUMHQ1YUU4Z3ZNRlp3N1Blc2k5VVI5dlllZWJJRjByY3BqTkxkdXc2UHJM?=
 =?utf-8?B?Um9VdWQ1OG5LcXRxNEJmZ1JsTFFSVlZNMU01bDAveWxQMkFrSmxTL1JrU0tq?=
 =?utf-8?B?MXpvZ29GbGU0S20xYWw2d1ZNbUpDVVBrLy9mWkRkQ1hJa3FqYWZ5bWpvUXRk?=
 =?utf-8?B?VDFEditTTjVzaWxkOHJSVlRPelBMYmdhWlE2L3l6RnRpQW16bHU3cVJnMHkr?=
 =?utf-8?B?bncxZk5iS3JLUzB4R2pJZGF6b3JkRC8xbnBFODA4a1FrUTF5WHVFNFdQZlE5?=
 =?utf-8?B?bkRoRkltdHpvcW16d2N5a1FaZWhmdHgvek1BSWJVa0ZyRnhrL1RBTnl2dzlM?=
 =?utf-8?B?MjFDbDQydlc3dWIwaVFobVlJOVJidFVYM1UxQys4aGc0Y3dLOTVRZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8199.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6438274f-72ce-47fe-a6af-08de58874f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 00:52:11.0178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQkOW1V7f9BUY5Fx2FwBsOTHiI5JJOkA7uHT+fKhTEhy/E4MVPrd4vRHwkprmT+b644zaVPp7zaVeXKY64CrsiD3VXtmqvQEK7FpJ0tKLF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5613
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgTmFiaWgsDQoNCj4gU3ViamVjdDogW1BBVENIXSBody9pMmMvYXNwZWVkX2kyYy5jOiBBZGQg
YSBjaGVjayBmb3IgZG1hX3JlYWQNCj4gDQo+IElmIGFzcGVlZF9pMmNfZG1hX3JlYWQgZmFpbHMg
aW4gYXNwZWVkX2kyY19idXNfc2VuZCBjdXJyZW50bHksIHdlIGdldCBzdHVjaw0KPiBpbiBhbiBp
bmZpbml0ZSByZXRyeSBsb29wLiBBZGQgYSBjaGVjayBmb3IgdGhlIHJldHVybiB2YWx1ZSBvZg0K
PiBhc3BlZWRfaTJjX2RtYV9yZWFkIHRoYXQgd2lsbCBicmVhayB1cyBvdXQgb2Ygc2FpZCBsb29w
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2ds
ZS5jb20+DQo+IC0tLQ0KPiAgaHcvaTJjL2FzcGVlZF9pMmMuYyB8IDYgKysrKystDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvaHcvaTJjL2FzcGVlZF9pMmMuYyBiL2h3L2kyYy9hc3BlZWRfaTJjLmMgaW5kZXgNCj4g
MWI4YWM1NjFjMy4uM2RlNzJkYjY1MiAxMDA2NDQNCj4gLS0tIGEvaHcvaTJjL2FzcGVlZF9pMmMu
Yw0KPiArKysgYi9ody9pMmMvYXNwZWVkX2kyYy5jDQo+IEBAIC0yNzIsNyArMjcyLDExIEBAIHN0
YXRpYyBpbnQgYXNwZWVkX2kyY19idXNfc2VuZChBc3BlZWRJMkNCdXMgKmJ1cykNCj4gICAgICAg
ICAgfQ0KPiAgICAgICAgICB3aGlsZSAoYnVzLT5yZWdzW3JlZ19kbWFfbGVuXSkgew0KPiAgICAg
ICAgICAgICAgdWludDhfdCBkYXRhOw0KPiAtICAgICAgICAgICAgYXNwZWVkX2kyY19kbWFfcmVh
ZChidXMsICZkYXRhKTsNCj4gKyAgICAgICAgICAgIHJldCA9IGFzcGVlZF9pMmNfZG1hX3JlYWQo
YnVzLCAmZGF0YSk7DQo+ICsgICAgICAgICAgICAvKiBDaGVjayB0aGF0IHdlIHdlcmUgYWJsZSB0
byByZWFkIHRoZSBETUEgKi8NCj4gKyAgICAgICAgICAgIGlmIChyZXQpIHsNCj4gKyAgICAgICAg
ICAgICAgICBicmVhazsNCj4gKyAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgIHRyYWNlX2Fz
cGVlZF9pMmNfYnVzX3NlbmQoIkRNQSIsIGJ1cy0+cmVnc1tyZWdfZG1hX2xlbl0sDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ1cy0+cmVnc1tyZWdfZG1hX2xlbl0s
DQo+IGRhdGEpOw0KPiAgICAgICAgICAgICAgcmV0ID0gaTJjX3NlbmQoYnVzLT5idXMsIGRhdGEp
Ow0KPiAtLQ0KPiAyLjUyLjAuNDU3Lmc2YjU0OTFkZTQzLWdvb2cNCg0KDQpSZXZpZXdlZC1ieSBK
YW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCg0KVGhhbmtzLA0KSmFtaW4NCg0K

