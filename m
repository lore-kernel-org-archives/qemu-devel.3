Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AA2C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 09:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJqvm-0008Pv-Pw; Tue, 27 May 2025 05:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uJqvj-0008Oh-1V; Tue, 27 May 2025 05:49:07 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uJqvg-0003Xr-3G; Tue, 27 May 2025 05:49:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCuyqpivapKK3r6tFZWL0M8rw+kbR49kyAL7SlHq5rKPflvU+X0MbALKPzhLUyCRy6+FbJZMmoQ3l7AuMkfy6NrpdXtvExIsD2fvBZO+oX7eScJMRVQM4O1LXDONLXXaeytvaK5zjGVoU/Of52LmUoi40g3BDwjsxC37VjeK3lBOSeGPj//bRnbivbnJXfhHW3kLnVo0pSNvvdDkk/mDm9q6Pd32OHoUmKlqhomADtgir3hAZQwkpvYR8gbW8xj9wISdlDTAjdaoaDiHuLrAUn8eihNNuaf1AZILUiey3Pjgcp5LTPy1eA8IveMdYzgIPBOfxqNcjK7XoiWNkl6yPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cdjd/vlytlEsLh/ZIonmkVLrLMBvlfVb+2JYlRjTW0g=;
 b=XexYkv+LF86xewsNYiHTGFvfu4oEMlQZbsdm0zEf4xEU0PzgBkOUvDLQorefgx1kdfWXdBTX+ae5wReXS7F8M1qA0RLi129ec0LMYn0hrQOMNEPUB/Y/pU/9IWwQ/Ggkj31FLKTWNkXvE3wrJ+JPgbw7YkqOlUYbXfaDhujI7mNs/L3wiK/uGdWTqcvfjk7qsOHIU64NSBUMq4xBSgLRQaii33G+diz9hmncg/Nt/69rYjszdaYGi2kYN+2F5aWBcgy8pU7evAYtuptSl/4HSSbCLoCcRF7FdUQn6epqTwg0TVlSRepoFSyooAV3e33jKRzqOhr6l39Jueca3NP1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cdjd/vlytlEsLh/ZIonmkVLrLMBvlfVb+2JYlRjTW0g=;
 b=WzuOKafWrwg6Ift1gD0Q4guowL1b85cbelam7lSekteTe9vWNJ3HrfhyR2FFW5H8xx+mNjU/Xv/y19Ej/VsIaq2M3hEkfPJvwAn+vIlxpaOJrU0yLVoByTZICrpJ+YcqijYoROV1pxjvxFGj4y+6I1T6zFHv7z+MFb79QqeXkWeit78XNkzH9n+KxG5C3c0GxOAfBhn4TOTHLsG9BI++56QES++gDXLUervU1XiDXn9KzxscgNipumm4WuWWAGp7E6h9bvU/MTAEMkfttHcMY1j9C2AXZq93Oda7Kfo0tDgMH68gdXIWepY8uJg4s+fYElwpu9ldi6UPAH8InVloQA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB7283.apcprd06.prod.outlook.com (2603:1096:405:a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 09:48:49 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%7]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 09:48:49 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 2/3] hw/misc/aspeed_sbc: Connect ASPEED OTP memory
 device to SBC controller
Thread-Topic: [PATCH v4 2/3] hw/misc/aspeed_sbc: Connect ASPEED OTP memory
 device to SBC controller
Thread-Index: AQHbwx2wy9OBNck3jUaG7fhOGvFKe7PmJFuAgAAAhoCAABLRAIAACIVQgAANowCAAAGIgIAAAMOQ
Date: Tue, 27 May 2025 09:48:49 +0000
Message-ID: <SI6PR06MB7631ED24AD2D562A7144A1CEF764A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250512091014.3454083-1-kane_chen@aspeedtech.com>
 <20250512091014.3454083-3-kane_chen@aspeedtech.com>
 <67ced980-d6d8-4a2d-85ba-c918298ecf8b@kaod.org>
 <SI6PR06MB7631337C549FA649031173DFF764A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <05a02b39-a76a-4f1c-8562-cc93ff0c21c8@kaod.org>
 <SI6PR06MB76316CDF36D7F51A6AA8A21CF764A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <eb6e4c89-d50d-4e16-8824-5a6cd2985526@kaod.org>
 <81a3f8bf-1c1a-4dd8-a9ce-b89589e904eb@kaod.org>
In-Reply-To: <81a3f8bf-1c1a-4dd8-a9ce-b89589e904eb@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB7283:EE_
x-ms-office365-filtering-correlation-id: d034b351-c491-4923-2b6d-08dd9d03aead
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bXRtZ2xpQmdGL2d6SXlDVFVoZmhkWmNvdjFPQXZaaS8yclA3dWQwcnRHb2Nt?=
 =?utf-8?B?K0trMUtpZ0hZOWxQQkxRM016d2dnQkJ3WUQvVlpsdWxwMmRybk9QTVBMeWU1?=
 =?utf-8?B?NDBGajQyOFdQRDNJM1kzdld1WVo2dlJ6b2RpeWhOVVlDM2NZaDhXVXpNcTUy?=
 =?utf-8?B?V0FWR2ZlN1E3T1ZqZVZ1eG94WWtkTTlXSlJDemR1d2JwRXlURGxQeGkzRExX?=
 =?utf-8?B?eGNYT0hzVHFLWkNRNENLTGdUUkxuNTNkNm5yZ3RMS1h2a3MyZTJ6bVIzODVV?=
 =?utf-8?B?SXFSdWFsMzhiREZaclFvUFEyQ2xXcTZhY0tpc1lUZ2pFOFNIMGJSNWVBbVpq?=
 =?utf-8?B?RnVRcXQ4VjZxQ2lIU05zK1V2clJ0QmtTaW44aFJnNGw3UU1pS25CaFFELzRa?=
 =?utf-8?B?STVQcHQxVGVSNTRyK2lxVk9HeE1iQkVwUHk5bC9Wc2xUTmhWWHdMamh3RUhR?=
 =?utf-8?B?QmpjYjMxckRJNkxwVS9JeGVtRmxibTh5cExkUmlBYmFob1IyR0w4aEFqYUJ2?=
 =?utf-8?B?TWNUUis1NklqK0hwekhCamlvak9LRktFUEdDcXdCaWxCdGpvM2RqZnUwOE5p?=
 =?utf-8?B?aC9iRXY1WnpGMS9zRC83TUxjbi9DWUIrb3NWcWszekVidjNPMTh5cW1jQUtu?=
 =?utf-8?B?S1ZYV05WQkNPWmJuOEtCTUlGTHZiZXQxSnFtY0F5a1UyazBwYzhaR0EwWnZS?=
 =?utf-8?B?OFI5M0c4a3dFRjYrdjR4RHpZZ2ZQaDBQeTU5bkdrUmoxaTg3aDVWNTVEZHpi?=
 =?utf-8?B?cDVCbjNaa0lhMVFaS3lEaGtadThDdmI4UmM5L3lVd3lhcFF6Zm04Z1dWRzRM?=
 =?utf-8?B?ckVsWHlsbXNmRDI2L1FDY2pNVDlqR1JjdGl5QTJqYjdWWk14L1d4aElWeGVD?=
 =?utf-8?B?d3pHOUVvZXFZUkdsYis4a1NOSmlmVUF2elRXdm1TdFVJNHFRejNIUmNteUgv?=
 =?utf-8?B?czUrTDNFNVZkNkFIVVdtVUVkK1MwWUh6YlNRQmtDNEJlUU1aNlQ3RVdnVmx1?=
 =?utf-8?B?b0ZiQVJwbVlQdFdoUWxGNXZtWjZkTVNaU09KR0JpM3ZnbHFXQ1BYTXlGSUx1?=
 =?utf-8?B?a0pOeExMRkYvcE8zRVpsdmdUeE1OeDFGTlNiNDJUNmdETXZUUXdTWll2dExX?=
 =?utf-8?B?MzQ5QmpwWitmR0VLRzlKVkdubGNyMTc0TXI2aUIxcU5sbC8vSVdYclF2WFBw?=
 =?utf-8?B?S3lGZjVrd2JlYWRzalJwWG9GSStTS0hiUHpDbTlvN2ZZRjJvY2lzclNubjlX?=
 =?utf-8?B?SkowcGxoc0lPLzkyQ2pwT2FLQlJ0QVgwQWlsQzc0SzVtcjFYcDhsd29UeFpr?=
 =?utf-8?B?TTFiSElFWVBuZ3J5b3AxTXNsTVVFTCtYaEtWK0VyVXBURnptaXU4QVlkRUJO?=
 =?utf-8?B?NWNPeGRhRDdWYnRack0vbHQ3aEtHN0F0RnNoVGRrdktwNVAxbEJEQkFaOGVZ?=
 =?utf-8?B?anFkU1BoOCtWSk9RQjVTMkJPNUdJWlkrVG44Y3MyYmx2UDFkZzBVNzJwY2Rp?=
 =?utf-8?B?MU51UUFwWWE0STZZZXk0M2lGUEg3M0xCbytNb0VOMDRsc05aaVBPMEY2ZlRx?=
 =?utf-8?B?ZXZWbHBSYy9KUnJ2SmIwSnNCQlViU3k2RkhVUHIrZmNuTTZLQ2NhdnloV1Nh?=
 =?utf-8?B?K3pDU3Awa0dXeGFtN3VyNno5THB3dGtGLzk4cDZBSXN3SEI2ZkxUUDhoYnBh?=
 =?utf-8?B?UGZYeGhuc0NJek5SOE5SR0dYY0NidCs0dlkxUEVqa3N5dU5JVlNGUmJGVkpD?=
 =?utf-8?B?KzJVdmh2eGFqZ0R2VDhSMzl3ODRwaTVUVGVIQWpVWVB1MHhJMWxNR2ZIUEZJ?=
 =?utf-8?B?aVBtcFNGd1lMVVpRMWRVaG00T08yVVdmUkdUUHRxSVZuT0ZJeTlrVlQ0Wm80?=
 =?utf-8?B?MnlVOVk0bEQ1OFgxb3JVQ1NuMjJKSS9tYzN4MEJscjJ3bng4QUJuT3ZzdWdw?=
 =?utf-8?B?aUd1a095cmVQMVZlNEJNdWJ6MklMYUZGNXRoV2ZaTlByWXdlbEEvQ3U3N3R6?=
 =?utf-8?B?L3lnNEZFUTJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU5wNXQwdUMzMU9MMVNYN0xHRk94K0JYTytPSExONDVqTTRYQWw3RlNEUU5N?=
 =?utf-8?B?RFdxMDhWUldueFpYaGU5YXh5eHZINXBlNExobVNzUnJoTGV1WmNFa3k2NmNJ?=
 =?utf-8?B?Y3VRM1V4b0NxUmRlV3lqOEZMUEYxeUs5UnZFZXcxSHZEK1pmSDRjKytWMU9q?=
 =?utf-8?B?UFNwUGpQK2tiaUJoKzk2Wnh1U1VQOHBYaWNvVGY0T1hnV1JlNlJ2MCtEZldu?=
 =?utf-8?B?Ni9JVkRKcUpHUHgybWRvSzhveHE1M1I4Znl5WXh2SVBOM2dRNWVGTVNGY3hK?=
 =?utf-8?B?MXNZcHRhdGZTNDg4WloyYy9qL2FMTENlY00rTHFTZVNQMi92RTM4VE1Yb0JF?=
 =?utf-8?B?M05ZR3Y3Z3FGTXBWQzZ3a2dxTkQ1K2hOT0RGbUFNb1hEOUpxL1NFV0ltSnR0?=
 =?utf-8?B?c3FRSkhHSGFsZk5OVnc3UVJsUURtSDg1NGJPdmN2eExFYXFPaEVCVG5YTFBY?=
 =?utf-8?B?VkN4UUltV2w1MUMrSHFxeTRoZDlaUEcyRE9YRzlRdjBQUWJ1UTllQzNoM2kw?=
 =?utf-8?B?SjljT0dZME52YkExalB2WG5hMWxoS0N4N1Ywc1lldmRJM29iV2UzVkJBZGNs?=
 =?utf-8?B?ZDNaV3FsWUxXRUZSbElkK0UrTXV3UmVKY0hsM3o4OU53bUMrejRYYmFibGN5?=
 =?utf-8?B?RlhLRlg5VHR5Z01GM09lbVAwYnhjZ0l0SE5qZVovVjlYNCtqOThtTUhHcmR2?=
 =?utf-8?B?UEFvTDJub3BDejQvUWVBVklJUTlTbXpNdkx1RFFVRXZZZGsyUENsbFpDZ29N?=
 =?utf-8?B?dEQ3ZVhSSHNmNHlSOUpvSzZVWTA2aW5QdklNUFlieHRteldrSnJaQkQ5SGxz?=
 =?utf-8?B?dHRRSjNlREROdXhQYkRXMDZ5d2lDVzFRQzNOdG52bXRXcHovY25RMUIxTFh5?=
 =?utf-8?B?RHFib1JSVUhQbVlvS1I3cERkTk16bVRyYmhLU2U2S2hSdkhJNmFGbXdONExt?=
 =?utf-8?B?VmdBRVQ5Wm1rTFpFZ055Ky9ORFpKYWgwdERjd0lITDQrQlZDamhrdnhmTk5S?=
 =?utf-8?B?Wmhya2dDbXp0Z3RSVmE1VzYzaEhyVUdMZWRHN0JRQlE3UGpwMTNOc1Jhbnl4?=
 =?utf-8?B?M0pnYnZKd3B1cWhmdW1zTTQ1QkRRUkRkdGY0MFF1ejlibXNSWEZHa2cvVUFh?=
 =?utf-8?B?VDk0T3lNWGpxbkJGbU0xbnNzbWZNYXZweTB4MFo2WjhFZFR2S2ExckhrZXR1?=
 =?utf-8?B?WXZwM21vaWlQZjNKNFZNZVN5QlNLcmVjOFVGblJEeitOR0VNWWtST3VRNWdZ?=
 =?utf-8?B?Sk85OU84TkZoZGdLM0NTQW13QVhoWDRudWV3OUVQT2I0a2lRN2pFUGRKRGJq?=
 =?utf-8?B?bng4QzdnYk5yZzdGR0thMGJDTGdhNFFMSGFUek5EZkNPbXFZeWFnU05ydUJz?=
 =?utf-8?B?VTlreDZwejZhUEk2UEZvcmtFRXZDT3FUMUVPOEVnNzE0THM1RGU2Y1p4OE9N?=
 =?utf-8?B?Wks1MW5tOHNIcWxITGFhd1NGSVRJRFl5dE1ZOGxZRUhJcmtJaTdIcVg5VVM0?=
 =?utf-8?B?Slhad3FOMXVOVUZLREp0NDVvampmOU9VWVNydUN2N21hYWdnSENmNkhlQmoz?=
 =?utf-8?B?OStJK0kvUWh2bDNrbXIrV3hxOUtLWlJoZi9SdjlLY2FHOW1sL2tGS25SdFlr?=
 =?utf-8?B?N1NQR3pyT2ZVcXJlbk9iUEU2V1YwZnJNR1JOWnJ1WUYvQ3M4SkxlL0N3Y08x?=
 =?utf-8?B?czdtZ2hyS0hSTVNvUkY1eHRmdW1wb2ltelRBMkRGNVQxcThYNkhnTnNEMHB1?=
 =?utf-8?B?QXBCc3VsMGpURFdIVG1kSklDS1Z2ODRrcGZvc3hsejFHU2hwalVZWFFaUlVC?=
 =?utf-8?B?Z2I5OGxhcjJYSXFCNExwN2VpbVV4UkJuOUwxa3ErcXNaTVBJS21mZ0xUTzhZ?=
 =?utf-8?B?UEtMck5QUExNdDhaYnp4aEk2K0hMTzZyK25UTGVDd0J0alNJVXljZS9PakdH?=
 =?utf-8?B?bmlFWjlMNkRlU1o1cU4weVhUS3dKYXd2cC94cDBqRUdhNTBZZUlka0NkeGk4?=
 =?utf-8?B?STU2QjdxZ1NGdmhpeEZOQ0lsVmJORTZHWE0zNmJ3YitDeTNsNlFkL2ltdTZy?=
 =?utf-8?B?NWw4V2w2Rk15Unk1NDRBT1ZLazZJRDZpSGtzUlJMY0V3UTNJN2FkZWs4SzZs?=
 =?utf-8?Q?4jPGFA4Wt9A+Ywof2ffngD9K3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d034b351-c491-4923-2b6d-08dd9d03aead
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 09:48:49.7034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZ+ZQoH4vmwtfJ9I75+5fIiqaXJn+Eo4XFSaj0sW703dLLlSxAHU1Bzh10JGZYpl/6c3kWZ/yijBUNasB88elAwWPQJbOz64h1uNo5YG/RA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7283
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

SGkgQ8OpZHJpYywNCg0KU3VyZSwgSeKAmWxsIHN1Ym1pdCBhIHZlcnNpb24gdGhhdCByZW1vdmVz
IHRoZSBtb3JlIHNwZWNpZmljIG9wZXJhdGlvbnMgYW5kIGZvY3VzZXMgb24gdGhlIGluaXRpYWwg
aW1wbGVtZW50YXRpb24gZmlyc3QuDQoNClRoYW5rcyBhZ2FpbiBmb3IgdGhlIGd1aWRhbmNlIQ0K
DQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE1h
eSAyNywgMjAyNSA1OjM2IFBNDQo+IFRvOiBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNo
LmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZl
biBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVldHJveUBn
bWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJldw0K
PiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpv
ZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUu
b3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NCAyLzNdIGh3L21pc2MvYXNwZWVkX3NiYzogQ29ubmVjdCBBU1BFRUQg
T1RQDQo+IG1lbW9yeSBkZXZpY2UgdG8gU0JDIGNvbnRyb2xsZXINCj4gDQo+ID4+IEdvdCBpdC4g
SSB0aGluayBJIG1pc3VuZGVyc3Rvb2QgaG93IGFkZHJlc3Nfc3BhY2Ugd29ya3MuIFlvdSdyZQ0K
PiA+PiByZWZlcnJpbmcgdG8gc29tZXRoaW5nIGxpa2UgcG52X3Bub3Jfb3BzLCByaWdodD8NCj4g
Pg0KPiA+IHllcy4gQXNwZWVkU0JDU3RhdGUgZ2VuZXJhdGVzIHRyYW5zYWN0aW9ucyBvbiB0aGUg
QXNwZWVkT1RQTWVtIGFkZHJlc3MNCj4gPiBzcGFjZSwgd2hpY2ggYXJlIGZvcndhcmRlZCB0byB0
aGUgQXNwZWVkT1RQTWVtIG1lbW9yeSByZWdpb24gbWVtb3BzLA0KPiA+IHdoaWNoIGdlbmVyYXRl
cyB0cmFuc2FjdGlvbnMgb24gdGhlIGRyaXZlIGJhY2tlbmQgaWYgcHJlc2VudCBvciBvbiBhbg0K
PiA+IGFsbG9jYXRlZCBidWZmZXIgaWYgbm90Lg0KPiANCj4gVGhhdCBzYWlkLCBJIHRoaW5rIHlv
dSBzaG91bGQgZmlyc3QgcHJvcG9zZSBhbiBpbml0aWFsIGltcGxlbWVudGF0aW9uIHdpdGggb25s
eQ0KPiBhbiBhbGxvY2F0ZWQgYnVmZmVyIGFuZCB0aGVuIGFkZCBhIGRyaXZlIGJhY2tlbmQuIEl0
IHdvdWxkIGNsYXJpZnkgdGhlIGRlc2lnbi4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0K
DQo=

