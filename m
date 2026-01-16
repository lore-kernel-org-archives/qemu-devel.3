Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B98D4A61A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggEu-0006en-Q6; Fri, 16 Jan 2026 04:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vggEt-0006dw-Fj
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:35:31 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vggEr-0006GJ-7i
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:35:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdnrFAjJ+PG7o+Ok1tdvyQ6/BS9JqBEsCx871/jO1yPTAV2nEdDvS3IISAFQPbHhc7ncuwY/SdK5KidDKZvqUoboIPQO8jF+ksvUCtXmY3mLLpNJwahjckKSrZXXirF/o5bAaqd4KgbhvdQYcwW70gFdzZEd3iro1X+k9v4DHEJdMVr3i/ZkyU4G4pufkvTZoOy5Cz3ETpmu8hwN+7tDNQbtp38oOzpsR5sB/b6p4UJKpUETmrBDuzOQ6IAxCp8P6zc7OedH446rFbZKnNLGZbjhpDZAtsFDogCD6In492WKLpvJCnuF4Yy3KABlBhkr4xFusri2VEdkTahZV2ci0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHuEDzZDDecOA3kTIBZHXd1OoNQgb9NbmpXxGem54Xc=;
 b=Bx3xQv+h0x60wxBO1HwviR8yT3VVoR9NrUeNlgqfqCiHZggxlAgssyD3mVmuKySmUMCoI8TUHjjE0dT8fu+ZhHmpIkCDzNPm4CNmXlXpVRQEOzn3WzRV0xl+s8VQJ/hKHwO6wMP/z2Fh3os/FsZNBRNVSWenxF2VMoWvXNwofvL3j4VGPZwV5ZyscUnuj81wjmY4wAjYZ58hCIXSL9pRVwBNs0PVTg3JM9hIH1Q7FGPsfFZ8SqKSn1rfTHtAZgwtSOACKAlEVXnH79Y6mMLdODQoawPwaljzlVybFMv7GWQpDmQdBd1jOhuX+/DdTjSy/DUu9ZlE4+jWPb+pupo4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHuEDzZDDecOA3kTIBZHXd1OoNQgb9NbmpXxGem54Xc=;
 b=l57r3GZVX/T6RRtSGE0w4iXZ8spx4TrCOFhyP9QUoIX2Mxih7hPpIeO5aDPZ/nWsMObOA+T2Y5HqR5SXIv0VyNqiAbEIFK1kHJfvrRhiyHqJi4lOpYn9r0cN/6k2Cp34eGrFftnSAttTandNu2c6EFzBWFTk0E5jfibq2VxlyeYPoRstliwkbc8NcmjkbBdwQlCDDXlnwlsTsQMqj1NycqcnEBVqZYC1X6IO6IbSASox0tp9nbQnMpvNDfqYDF6OvEXYtJbkKeV0PqR9Y80k2jm2IT5A7RtsTnhKM/qeXonQANfto2xbLaJ1U6wEONdgLHtKn+y7ERlikWllrPaX5g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYSPR06MB7019.apcprd06.prod.outlook.com (2603:1096:400:46a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 09:35:20 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 09:35:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Hao
 Wu <wuhaotsh@google.com>, Michael Tokarev <mjt@tls.msk.ru>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>
Subject: RE: [PULL SUBSYSTEM vbootrom, v2, 0/2] Update vbootrom image to
 commit 1c8e9510b22c
Thread-Topic: [PULL SUBSYSTEM vbootrom, v2, 0/2] Update vbootrom image to
 commit 1c8e9510b22c
Thread-Index: AQHchsGNdALvco5gGUOd4RKsZ1vP+bVUg9MAgAAE4gA=
Date: Fri, 16 Jan 2026 09:35:19 +0000
Message-ID: <TYPPR06MB8206FC043C61247FEC3BDB1DFC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260116082431.3689035-1-jamin_lin@aspeedtech.com>
 <226f29f4-0017-4436-b14d-232b3ccf8d45@kaod.org>
In-Reply-To: <226f29f4-0017-4436-b14d-232b3ccf8d45@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYSPR06MB7019:EE_
x-ms-office365-filtering-correlation-id: 6904e936-a0c5-4f83-08f4-08de54e2909b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?ZGNvY0pPWkJVeHR2S2NOdzFQbWNndllIb2Z3UkswTCtaMnB1M3Q5aFRadEpZ?=
 =?utf-8?B?MkNNMFlleGJpYit2eVBQc3RrdG9QYkM4NmVYRmVBZG1XSnFJbFA5Wk5ISGhJ?=
 =?utf-8?B?SDNJblRNd0pENThESGs4aFVRTXhUcTU1OGRUVHYxaXJhbGNkWEIyYjFkamFs?=
 =?utf-8?B?VzVuNnFPMnhNS0xTV3FadDNCU2tnSUoxYk1JVW1vM2w0eTVUOXRQZXlERVd4?=
 =?utf-8?B?M255OEhKUnZnSHIwL1JxUGh4S1ByNWdCZk1KVkk2c2tPWHNRYjJoVzFlTTJv?=
 =?utf-8?B?UXdsMDVMTjF2N1J3eVdTV1h4YVArWXlYV3d1Tys4Q1lkTGtOZThEUzczYzJ2?=
 =?utf-8?B?blE1QXJIblRZK1hrb0p4cnFIYWF2dkpNNVdTLytnMkxWVU8vTzRZZGNGY1lZ?=
 =?utf-8?B?L2tIZHpsZWwydnhxeTc2TFc0SlU3dmhtMEttb0pHRlM4d1Q3eTFOTm9VRzky?=
 =?utf-8?B?bkF1MWZRZjhwYnA4ai9CRTJoYjRxZFZaVUZFOUtra05pTGZDR1pDMU94KzhN?=
 =?utf-8?B?Vk5OUHVPMEh4cHFRZ3ZMR0FZQXpZanpYZmpPc3VaeEEwMEI2R0xhY0lQNE5s?=
 =?utf-8?B?eGp0em5GVDdpbzFEYnMvQVZvamV4eHFaSmZ3Nmh3S2tlcnFVOEJtbndPRC9Z?=
 =?utf-8?B?Y05Ob1FmdHpmY2ZHVzBvSWRkbDlHdlhTWnZoWjFXUTB1TFdPZ2tURExTR2Iv?=
 =?utf-8?B?aGFwcUdROGhaU2xzVjlRQytQUjkzcjRXSmRsZ0JoWVJHWTVNaFNKbHdHdDJM?=
 =?utf-8?B?dGRYemJQTEF4eW9OcHZqcHlXZTd0Ykx5V1M3ZVpkUkVlWnZRdjdsNUN3ZjZy?=
 =?utf-8?B?bzQvalMwVHAwVlZtdzhZVkxGbGFFeklUNWp3Q2h2QzBOdDdUNmhNcnRXaHhp?=
 =?utf-8?B?Z0p6cUpiRlpGcU1PRW5JdkV6UEVFcFJGTjVnVjJFNllUNDdyR1RDVXllQW5K?=
 =?utf-8?B?QW1Vb2kwc3VxQW5ybzJHNEx6NnRpSzZyVzFhWDhPUHpCOGozeFI4VTVYd1pt?=
 =?utf-8?B?VVNWYXM4U3lkOFRXS3pQWmpMUXlaRXUyY1VJTjcwM09tS05MS0NrR3pMSEJa?=
 =?utf-8?B?aGtTMVpVVkVyTDhzcXVPL3lKVnI3dGF4WFFUVWJTYjEzZHFtTDJoTDJlVlRI?=
 =?utf-8?B?bXhnSjFVbjNKSGlQVk8wRDZmcUp2OTZPRTB1NnpZeXo4NFFCUm9MVUd5RUhh?=
 =?utf-8?B?R3NaL01ua1VWT2R4UU9lZFVHT0FpUjRka3ZDTnArL1djZUVGc2VnT2hYaEdZ?=
 =?utf-8?B?VE40RXFwS2hIOEx2Q2VkbTFETFJhSmg5RTQ0VmxPdHB0WEltMTBnMHdKaGJ4?=
 =?utf-8?B?aWdCSlB1eTdvQ1VFUEhNUXZYMDIvOUhoMTcxamhEWjRIcGlac2s0UGtGTGNn?=
 =?utf-8?B?bkxnTm4zc2NiTjlpb29TbmFBYStGVkZZNDV6WFZDcXF2aEdSbU91eFhLK01B?=
 =?utf-8?B?YXl2TjlyL1ozSnBTRmsyQnNwa0hvVXdNbG5xQW5pQXVrL2ZPU2k4SjR3M2JT?=
 =?utf-8?B?SW9GK0IyeC9HaTA0UFIwREMrR1g5Wk0vbmxoZW42ckhWSGhEUnEzNXdLUEx3?=
 =?utf-8?B?QW5GWi8yYkVsVUZQSjFBbnlMbllwRzRndmc0MWhnMEFJRGdmTHZ0UFVBZkZP?=
 =?utf-8?B?aktPemVjNktDeEsyQ1RaTXpEVE0vMjNtcy9MS3Npb2czVWQ3cFZ1SmJBc0RM?=
 =?utf-8?B?RVV5OHhEbmUxaExsczVpcVkxR1lpbGpKTCtYS2c0eWwyMkovSWpjLzVQdGF4?=
 =?utf-8?B?aG1lbmhrZWppQXF3RmFCYnk3WXFWTDhkOHZ6YnB0UE5OdHFLZC9wYS84WFQ4?=
 =?utf-8?B?bXdoaUZUYUxOZllHWEdWQlc5dStBUXNHazdpcHBJbDg2MmZKTkI2Z0ZnRVJa?=
 =?utf-8?B?ZXQxb2lXckVIS3h6alc0WEpneXdOU3dOWnQ1S0JEUExBSFR6OEVYR0NUc3VF?=
 =?utf-8?B?NHJnMGxMNFBrQlRUbXlhQ3NZNXc1LzlQWGxIajN3MkJZL0tER0F4YjRmRmJI?=
 =?utf-8?B?M0NKc1I0dU5VYnBvZUwwOXcvYVRxU3ZIZk5PRUdGYVRqM2ZZT0VOdlhGSElH?=
 =?utf-8?B?bnljSUVVTGV4blFCbkpaMXZHbGNUaXBRWGJhRWYvK1krdEt3ZmIzT2lSaEMx?=
 =?utf-8?B?VzVWdEp5Mm9PVUpvRlZZOFJDN3FUOVY2ZEF4SE5oNGhQM0UvUDMxUUgvUWN3?=
 =?utf-8?Q?xmhRXKY5z+iL7mUXXkjuJbEok/O/DySdedvvsiFozYEw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnVLcGZyR0htMEhQV1MwSmR4ZHZhOTI4aGNobnExWkpBMUFiMUExZGU5RnBD?=
 =?utf-8?B?V1NmZTBLUzJQZ0NkbHcvZmgwY0NVZTZlVHllS2dXcEVONWhuOEZCOWRta3JV?=
 =?utf-8?B?TmVMcVpiY3dOOFIvS0hEYzFmMlF0TjBjZmZrcXMwQm0rekswd2hEK3puYmZ0?=
 =?utf-8?B?Qy9ETzcyRkIwaU1hdFphQ3o4MWVpS0dLS2lPNUlmZHNYQnhJWEIwOE1kMG1r?=
 =?utf-8?B?TWJQWEFmT3dxMDAzZW9uR0V3V1FxNVpCeE5LQ3NSdmdIbUowM2V6N0l1blZ4?=
 =?utf-8?B?Qy9ITUd5WngrMUZFSWdzc28yN3FwSUdWOCtMNGFpYzcvOGpSd0VyVlB5d0tG?=
 =?utf-8?B?K0VTZWNJbTlpb0xGVkYzSURvZWU5K203T0ZXbWxrL2pWTmF5SzVmMXhyRW95?=
 =?utf-8?B?TnRjN0xrSWFlQUxJQTB1bFZTeHQySEUzcy9Ub1ZESXU3QitNU2VyYjNsbkdi?=
 =?utf-8?B?eGFLcTlpYWpXSEFNTjhLZEZTNUVxbEx2Y2I4SXo5Z25kTlJxYXErTDB6ZVRK?=
 =?utf-8?B?Ymc2N284bjZMamFnTmpmY2hGZmZqV0FKaXVxVE1kRkx0R2JKd0Z2eE1SeVA2?=
 =?utf-8?B?VWVYQnNkdnhLdWVLdnhiZTJOSk5iOE1PYmEwdnVFRFdQT3hKNnJIOU1LYzFq?=
 =?utf-8?B?K0ZRb1A4UEFHS0RPTTBqMXpST0dsbFFjUnQ0aHIyUXJFR25nMFF3N1FQaEpU?=
 =?utf-8?B?aUhLSTNqZmNmZ1dac3gyTFREVFZ3bVdYNHgrTDBjV21nMUxKTUZobjI4Qk1y?=
 =?utf-8?B?S2UrRjlwOTFnTWUveVczUVAwR05nWDF3cU13R0VTWi9GQ3NObDhCSmhCMVh1?=
 =?utf-8?B?WFdXc3FQNERCR01KN04vcWZHWEZ1TjJqalJsRStZL3FwZUdVSWUvYUFOTFRv?=
 =?utf-8?B?OGp0RUVIZXJtbUlpNDVaRjNUUGVhb0w3UkhaazFkeUs2MHlvaFdrVjJVWXZC?=
 =?utf-8?B?aGxJZjFIVUZvYktXdkVSazcwQWYrdGIzdmVqeGp2bi9HY0FIVVpXMitrWFZD?=
 =?utf-8?B?UC8zT2FrMzh3b2h4UXpoQ3A5cUdzSWljS0pjQkZvdjY3QTdGZzhCd1RHckNN?=
 =?utf-8?B?VXQzL3hieC9aUXp6VDNUcjZ6bEFJTXpsWVhtVWNyV0dGYVlSaEM3V0lBQW50?=
 =?utf-8?B?V0tweEhuVDZUK25vNzkrbnFvSkRrZHlvZWlvRTltTFAydWQ2UmZ1dWVGMUNj?=
 =?utf-8?B?VWNRVS9HTXVyL24xaGhIK2Q2eGRyMExIbkJHYVFVcTNMY0hOcjZ2YXFWdlV1?=
 =?utf-8?B?ZlpTUHorYnhoWnE2UlIxL2RiVFhuQUM1d0tNYk1VYXZPVmxlVXI3akdiVW1I?=
 =?utf-8?B?R2MrVzV2M2hwVVVZUUkrTmFlQ0RXaXZEQTh0RU8wamVyNmdCQVNJdTZPOSt1?=
 =?utf-8?B?NFNrdWVBQ0ZZVVV1by9MZjhPNTViR0lrc2FxNXRYUmV4VCtxS3U0NUU2enNu?=
 =?utf-8?B?SFJMSU5aWStSVGs0S3JqS0piSUw3OFJKSmJ6KzNpWmYzanZud2krZmVDVEk0?=
 =?utf-8?B?UHQwSEg3RlBMTG5uSkQrY0EvRUlISVlVbDAwMkh1dVVYRXdhdVFNUk5NZlI0?=
 =?utf-8?B?VTVEenY0Z01CWkZtOWFHd2pENFBkVlUvSUo3c3h4eE1iQmZVcE9GdEIzMW04?=
 =?utf-8?B?clpPV1pzS0t2eGt2TUtiY0tKZHpRRnF0a3g1SjNZWFd0MEovdXpCZGxGZzZL?=
 =?utf-8?B?UjZFL1VQT3RybUJWaWgxaG1TOWNudDJZb0Y3K0hCaUZpN1V4amRuTDZjWTVt?=
 =?utf-8?B?cmZIU0RKVE9NRlNDVlFBTmRFZi8wUkc2eTNsN1JsVU9teXFYZVJwRFpBaVJK?=
 =?utf-8?B?ZWh1YUdHYlpSUTlSNElsZXAyR085Y3BmZzNQR2NSc1NLSlRiTVpXM21DRjBj?=
 =?utf-8?B?VkdLdTA2YmhESGYzVWhUaXllU1lTbUFpaDlWaStxQ0MrR094czRnejBKb21q?=
 =?utf-8?B?YmJkL3FiM0tIVHZhUWVzdm90Njdia1ZsMytMVlBlUUtFakFwUEY5UkE5TjNB?=
 =?utf-8?B?dXFEMEk5cDVONDNhM3RGUzBNRU5QdC9PeTB0cnFyUHNBTGtxZno3TjhRQm84?=
 =?utf-8?B?WDNSbGFqaEdRZzBPSkRaQWpveGtTL2wybTkzajQ0dUxjM3dETnp6blFnY0JC?=
 =?utf-8?B?a0RYZnpZeUUwNzhSQ1l4K0NueW1GeTNnSUs2TmZNZ29QbGdEOURXU251TTdv?=
 =?utf-8?B?dTBsYkNKa213YmEwd1QrVDByMU1UT1pxalQ5SFZUZ1QwQjY0TTIrUU42TGlJ?=
 =?utf-8?B?S2VvT0JTb2VHaXB1aS9RcURtQ1diekU2MVA0YS8vOUd2aTJvNFlQcnFPZmIw?=
 =?utf-8?B?bU15cnh6dGYrWWFPcHV5U0NVenFYdThhUnlpZnRQS1BKbUZCVG9Ldz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6904e936-a0c5-4f83-08f4-08de54e2909b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 09:35:19.8265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROpqSgBHKCnYyYPlhTlz2wfXWmyVj1VWcLs0Vn5SqB7bjsJs+5lCaxuF8mgTFRb9RtTfROD33FGvJ4GHLoEK7aFfkqG7MCeTiN0nAyzitIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7019
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BVTEwgU1VCU1lTVEVNIHZib290cm9tLCB2
MiwgMC8yXSBVcGRhdGUgdmJvb3Ryb20gaW1hZ2UgdG8NCj4gY29tbWl0IDFjOGU5NTEwYjIyYw0K
PiANCj4gSmFtaW4sDQo+IA0KPiBPbiAxLzE2LzI2IDA5OjI0LCBKYW1pbiBMaW4gd3JvdGU6DQo+
ID4gVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdA0KPiBjMWM1OGNlZTE2MzgwZjgx
Zjg4ZmJkZTZiMTJmMjQ3YjM3NjgzOWUyOg0KPiA+DQo+ID4gICAgTWVyZ2UgdGFnICdwdWxsLXRh
cmdldC1hcm0tMjAyNjAxMTUnIG9mDQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9wbTIxNS9xZW11IGlu
dG8gc3RhZ2luZyAoMjAyNi0wMS0xNiAwOTozMzoyMCArMTEwMCkNCj4gPg0KPiA+IGFyZSBhdmFp
bGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KPiA+DQo+ID4gICAgaHR0cHM6Ly9naXRo
dWIuY29tL2phbWluLWFzcGVlZC9xZW11LmdpdA0KPiB0YWdzL3B1bGwtdmJvb3Ryb20tMjAyNjAx
MTYtdjINCj4gPg0KPiA+IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0bw0KPiAyOTU1OGQx
YjdkN2RjODI1ZmI4ZTdjMDc0NDY0YzFjMzZhMjdiZTdiOg0KPiA+DQo+ID4gICAgcGMtYmlvczog
VXBkYXRlIHZib290cm9tIGltYWdlIHRvIGNvbW1pdCAxYzhlOTUxMGIyMmMgKDIwMjYtMDEtMTYN
Cj4gMTY6MDA6MDUgKzA4MDApDQo+ID4NCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gdmJvb3Ryb20gdXBkYXRl
IHB1bGwgcmVxdWVzdCB2Mg0KPiA+DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+DQo+ID4gSmFtaW4gTGluICgy
KToNCj4gPiAgICBNQUlOVEFJTkVSUzogVXBkYXRlIEFTUEVFRCBlbnRyeQ0KPiA+ICAgIHBjLWJp
b3M6IFVwZGF0ZSB2Ym9vdHJvbSBpbWFnZSB0byBjb21taXQgMWM4ZTk1MTBiMjJjDQo+ID4NCj4g
PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICB8ICAgMiArKw0KPiA+ICAgcGMtYmlvcy9h
c3QyN3gwX2Jvb3Ryb20uYmluIHwgQmluIDE2NDA4IC0+IDI4NTY0IGJ5dGVzDQo+ID4gICBwYy1i
aW9zL25wY203eHhfYm9vdHJvbS5iaW4gfCBCaW4gNjcyIC0+IDczNiBieXRlcw0KPiA+ICAgcGMt
Ymlvcy9ucGNtOHh4X2Jvb3Ryb20uYmluIHwgQmluIDY3MiAtPiA2NzIgYnl0ZXMNCj4gPiAgIHJv
bXMvdmJvb3Ryb20gICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICAgNSBmaWxlcyBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiANCj4gQ291bGQgeW91IHB1
Ymxpc2ggeW91ciBncGcga2V5DQo+IEM2RTA5NDAwNTQyMzE1RTg2OUVFMzU0NzUxOEU4REFCOEFG
MTNCOTQgPw0KPiANCj4gYW5kIHJlc2VuZCBhIHYzIHdpdGgganVzdCB0aGUgcm9tIHVwZGF0ZSA/
DQo+IA0KSSByZXNlbmQgdjMgaGVyZSwgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L3FlbXUtZGV2ZWwvcGF0Y2gvMjAyNjAxMTYwOTMyNDkuNDQzMzA3LTEtamFtaW5fbGluQGFz
cGVlZHRlY2guY29tLw0KDQpEbyB5b3UgbWVhbiBwYXN0ZWQgbXkgcHVibGljIGtleSBoZXJlPw0K
DQotLS0tLUJFR0lOIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0NCg0KbURNRWFXbmdCeFlKS3dZ
QkJBSGFSdzhCQVFkQWkxMjZHS2FxbHg4ekgyQVc0NlNxd0lOVnRIV0prM1NPNTgyRw0KV3dSK2dh
cTBLMHBoYldsdUlFeHBiaUFvVVVWTlZTa2dQR3BoYldsdVgyeHBia0JoYzNCbFpXUjBaV05vTG1O
dg0KYlQ2SWt3UVRGZ29BT3hZaEJNYmdsQUJVSXhYb2FlNDFSMUdPamF1SzhUdVVCUUpwYWVBSEFo
c0RCUXNKQ0FjQw0KQWlJQ0JoVUtDUWdMQWdRV0FnTUJBaDRIQWhlQUFBb0pFRkdPamF1SzhUdVVu
VDRBL2prajJFS0lYOVBBN253NQ0Kakhqak0yOHlITkI0THFUQ0pIcE1GbkRDY1FoQUFRRHdTbThF
N3VnTlR5RW1VUDFYb2xDMEJoaUlsL05uMGxFYg0KMUI0NXQ2MTJBcmc0QkdscDRBY1NDaXNHQVFR
QmwxVUJCUUVCQjBEc3hPSzFFTjk5Y3hCS1Q3MXkvUDl4UUd1MQ0Kc3BsZHB0SEdySUpHdEhaaGF3
TUJDQWVJZUFRWUZnb0FJQlloQk1iZ2xBQlVJeFhvYWU0MVIxR09qYXVLOFR1VQ0KQlFKcGFlQUhB
aHNNQUFvSkVGR09qYXVLOFR1VUdxc0EvUnBhUkNDQk9xVEp4ZVFHbUxLYWJjSnhOMHFIbHJZNg0K
NlhOMUVyU0Fmd2VlQVFETGpNejVkSU52Qm5pNllsSEZQVk1BcndZcnkrRVBwNnErb0NGaTF4V3FE
dz09DQo9dmZpaQ0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQ0KDQpUaGFua3Mt
SmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo=

