Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D4EC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 05:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugz18-0007QZ-2r; Wed, 30 Jul 2025 01:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ugz0u-0007MK-3p
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:06:08 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ugz0p-0007Sm-Rm
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:06:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iieusQuBNZNasTU4mu/I3J4tF5MO8M+bB0eSSdjuNLSvREhTNA7ejSupMN39MqymGSxHdmlYtmnONRelwxP4x4iQUbPIWVELy/W45r+SiyEikM5xHWAfQuZSdMD7BaRHoUB3kYk8WPcR/3Fm+1NbA/Jqou75R5iqkmYhapwsj5mRxoNPQ26Hf19TUei/KvCC5fu5Pmpo2JYAgmTPXGzyK+rPeSgHYQLdM05tvEcuiLn4kpdzFWKkZU5W3t+cUhm6cAnyXyTIReWUNpounJYdGvNbgDs9V0amTO4fPEPY92HJkfHmiLXF4a0MFLh/tG0yJc5pqckCvZl7MHO7TM/djA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NVq4bXwzCLHrSRgI5I7X5hWQPWpXYCGN2yfXtDONdA=;
 b=S1Q62tbEAx2Z5mjBVnAa3wpCNbI1p0Kky+Wdji6ZTXNdt+Q9r7/fIMvGOB8j1hGdS6UMeeOlkSiSmOi1ZW4UsTOlJlsRrNNppwmFN9yxWasJBLqrqFKcuLh9gGyUVuM4QndvxQFK4qPHL3yn/O64qBKnkIoO/GsY7vXbJD4O56VF7n9vccPJg7BjXQhok9CWuE4HHbRDnGg0jRtbgMFSvosHq8Fy9GMDWzlXInghmUA7sxCqWVHgfjiQs3z6gIWTNtublzvxsnqyh/b+KMbtL3kJE9b93E6C4J08ULTHa5WYbBAgDQ7jMgdcpzqidyfZ/ENvWhfVISQIW2EHDMZViA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NVq4bXwzCLHrSRgI5I7X5hWQPWpXYCGN2yfXtDONdA=;
 b=qc02hLkUxoF//H4JD6rxVJ+4OG5KeQhvkvjdETIRbOV+dQ4ANOiJmfCSzymmcPQF5rnzRNCnwH8I11O3ENceI8mbAX2/BN996tIM8raxwzN3qAI6xnlJu2DO3Lz0hG7Ncpwt8t4Eq7Mll82qVSyZXI803jS2hqtYbch//kAwx9tztQbIxsz+OMhrNvJHyyYZxnvOogoQ0B30LX8Mx8vZQywaVMykDJAZNbfV1xePY2xfQpx3Aoc3nZmr6t+g9zzGnlv9fOALWM/VbvybUdH0/bTmpRVRQ/gmN+iSrRiGuxVOkG7AzkZAw+DPEqGNeYjzM0jmWtDialOWnvaFwpio1Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6087.apcprd06.prod.outlook.com (2603:1096:101:e7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Wed, 30 Jul 2025 05:05:47 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%7]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 05:05:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Michael
 Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Hao Wu
 <wuhaotsh@google.com>
Subject: RE: [PATCH v3 1/3] roms/vbootrom: update to 7b1eb5f7fe6a
Thread-Topic: [PATCH v3 1/3] roms/vbootrom: update to 7b1eb5f7fe6a
Thread-Index: AQHcAQ6bmLIS+gHD0U2m8g7SY/CXybRKHFmw
Date: Wed, 30 Jul 2025 05:05:47 +0000
Message-ID: <SI2PR06MB50412FB108DBF81386D0BF25FC24A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250730045813.822132-1-clg@redhat.com>
 <20250730045813.822132-2-clg@redhat.com>
In-Reply-To: <20250730045813.822132-2-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6087:EE_
x-ms-office365-filtering-correlation-id: 080acf33-1917-4e2a-40c8-08ddcf26beed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UExWOUViYmRWYVA0TS9qUWNIbW5wa29yZVVaamJ4S0E3Vng3cTVrbEZxbGpV?=
 =?utf-8?B?amxxbnp5T3VsckdjMUg1V2tyTHROSzN6d0YyTXZqRWFmaUR0U1d5OXlmVVds?=
 =?utf-8?B?OTRhSjhmSzUvbmE0LzdISVp1V05ObHFGb1VZNXJEa0kvSHQ3TnBnTGhrcmRJ?=
 =?utf-8?B?ZkF1bTJZd3hrckNmUmVXeWRaOGFndFBrRkdrN1E5QTIzanV6TXQ0c3lVdUpx?=
 =?utf-8?B?U1F6Vk5wakd5UHYvaTVwQkZnaDI2c1UzWjZERVNXMlhEaytyR2R5eUZsUDEv?=
 =?utf-8?B?cDQwTXdtYUhsb2NmV25QRytDRVZ3RURBVkZNMjRBdU1ObnBnWVBscXJGVXVh?=
 =?utf-8?B?VUlXS3F2YVBlaS8wcUl1Yk5peDR5eVNuMmFSQkhDbk03WEN5cW9oZXd1bWor?=
 =?utf-8?B?Mm1RU3FSVFFmdklCazQxdUsvb0RPWks3MFZ1RWFDbmxkeDVkVHFBdW9Vc3gx?=
 =?utf-8?B?dDY3eDRCaTVPcWpsaG5wMlVKU0cvTDFkaUJkUitXM2JGZHV2YzVVWllpOGJH?=
 =?utf-8?B?S1ZZNTJSR2lnNDFwdk9JQ0VRWUdPRS90YS8rUHFaTkk2TStXbWtnMnFlWUcz?=
 =?utf-8?B?VDJVZGhVbjZMSThQVmUrMVgzUWNCei9NUmt1MXhUTVlPN2NVaXRDaERGRmVH?=
 =?utf-8?B?bU1vU3gyenYvaW1hYi9sRGZlcjhIN1BrOWpEMTMzRkxZYm1wSmlaUmUxR0Na?=
 =?utf-8?B?bFMxcDhTTjZrMDdUaHZDd0JKZGVlamxvL2RVWUxxTzlNK2JpejJFcnFobXNz?=
 =?utf-8?B?VURQWW4vdExGOTU0ajhleVpXQjJUejNtT0xNcmRma2NyUENreXlnK3RTWk9o?=
 =?utf-8?B?b0RxTVZCSTRpaEQ0cjRmZXlmK0ZEWURBUFdMNGU0cFpZRnE3aW5nYkhJR3pH?=
 =?utf-8?B?MFdSd0ZCUW5ZcDBUS3N1blo5MkpSSkVRdXBxaHBFNFg4Z3B2S0g2NHU5ZGUy?=
 =?utf-8?B?cGd3a0xBeHJpRUtqcG15NEpCU0NoQjd5WXZQcDBFNmtGTk1pWXpCR1NLSGJT?=
 =?utf-8?B?VkZYTElkc0NUdnpsMGxmVndaWExxVTdCYXQ0N21IN2xmSjdVeUJVdnRUR2Jq?=
 =?utf-8?B?UStxVDkwUndBZVI0V1pQbFRaUXlTS0o3bDFuSlJrNjBjVHhqRFJSa1Era0J3?=
 =?utf-8?B?MFB5eE5ZZW4xWDRYdTVVbG5qTDhPS1djTUROUTFwTVNMNzl0OTBWOUtKTXlr?=
 =?utf-8?B?NzZ1TEtXMWI0UXBtYUxPT1NRNlJscDQ2b2t6UWcxUTE3aFV5RUxkWkdTVUR0?=
 =?utf-8?B?bUozNUpCbDNhR0hVc1VkWVIvdlpHNkorLzNlRk13TmRaR01IMWUra3JqT21R?=
 =?utf-8?B?N0ZDRW5pL2g5bTFBUDExcWY4ZXlJb2V1TS9ZQVllV0FYN0RONlRwV2pTcTZ6?=
 =?utf-8?B?T1B2NTFhYTJOMzQ4em5IemxwTUpDQndLRDZEek1KUUtuYVNWSWRpM0VueElM?=
 =?utf-8?B?WUxZcm1Bckd2SXpkV3dxd1V2bUhFNkp2b1NNU3RzQ1g0SXkxaWc0ODJ6S0Zp?=
 =?utf-8?B?QTk3U3FqQzJLY3UzY1JySE1HSmpVZ3RaeUZpdlMxSjdRQzJRRmtpQzh1VlRN?=
 =?utf-8?B?RmdCVEQ0bTFsL1hlQ05BZVBHVUhBZmJUZCtpYnVEMzhhV2pvU1pWMjkvSDFX?=
 =?utf-8?B?N0JOOGcvVUEzZ1V1eXBqZEtUcmFXRzZRa3NWMEp3czFTaGU1YXFISTZYMXFM?=
 =?utf-8?B?TzlML3ZRN1hvZnVVZ28ya2tqOXJNQXVjb2V1UW1rajZwUnFMbTNaaE9Ebkxk?=
 =?utf-8?B?VzBvYytkNlk3R3pickNGRyt3cEFhbnlucmo0c3MrQVZSQUJZbHkya0UxWXlY?=
 =?utf-8?B?TjM0MTN3Yzhob2pGeCt5TmVERHZIdHBwRzdOdFNRSFBNbnNCRklSR0lZY294?=
 =?utf-8?B?UGxHWWlWZldJWEcyL3k3bVRzZmtxdlZhSWJvcWFRVjd6NVNyNkhIalc4VnNZ?=
 =?utf-8?B?RVZvc1JYUmVmUU9PbDVpTkFSQXpwT3lSeEJLaWZLQUhUYWNnQjdrYzN5VHVz?=
 =?utf-8?Q?t7s8tdyE7g5YQpFIpVZAuu4rhDsZDM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDZkRzc0YVhEY1ZDU0tTODkwNUhCZ0tSSE1jek9uOE1ENWFkaU5EY2dhS3lM?=
 =?utf-8?B?S1g0RVBmN25PalFLcmU5UTE0TUVoY3dlOG92WFdVMllIWlFMdUxzRFJXVGdZ?=
 =?utf-8?B?SVdBYUVkU0NyL3NrS3d5cDNoRWxxQm53aWo5ejAwYUJGSzNUeVo0c0xQVE8w?=
 =?utf-8?B?d1o5cHArb2dyVHBwUEcxc3pkaUZKN25nOUppYys2NWxwbWRnU0UyQS9ySXdu?=
 =?utf-8?B?aFhzaHVZQklCRXFrSGVha1ZVaWdDZzBLc2xHQWUzMEJxaDdvZXJZWmdBN1Nr?=
 =?utf-8?B?QlhrZkpIaisreklMUEtwOXVkUjgwSDhacVVkcTNnVHczdjhoWnJtWHFrQzNu?=
 =?utf-8?B?VUZWVmdaa2g4RGhoVXEvSzZhdUhsQjFEbjRNTW0vbHEyZ1gwa3cvL1VqQ1dq?=
 =?utf-8?B?KzRNTVF3WmNyK01nUllpYy9IN1ZnL21zR1NCNjI0cGNtQXZzVGdiY25BSzRC?=
 =?utf-8?B?eWdYVDh1ZENkTHVkSFYyRTlVYXI0RzM3Q1VzNzJhV0hHZm5od2ZvM1VoNXNE?=
 =?utf-8?B?WmdNYnJnZ0U4OFlFV2VxRzJ5RjhLUjdEKzZ4cnRiL1k3WG9iUjNkZnFKR0ox?=
 =?utf-8?B?RmFzcjhnbEh3SEMwRThiNEZabmhrR0lEM0o1K0FKMEw3RFFVb0xjSE5WTWtI?=
 =?utf-8?B?M0ZLU09OQ1JVZWc2UXVKMnNzRWhFQlk2VFZUcG1HSGZGMXFaVXc4ditpa1lm?=
 =?utf-8?B?M2hDQWhRNzZzbnFLTWg0eFhxSEcyaERVQVFSaVV1c3Fld2dnb2VQTjRqVWZl?=
 =?utf-8?B?VFhYWklJaDBrZUtuRyt0RFZOR0ZLdXNQcENWYzNrMzhTL25yTFlwdVFzL0Nx?=
 =?utf-8?B?UXRhTkNCUy9BTWcvLzBwZXQxdFkzNzRrcno0NG95ZCtodFFiQTc5ZDJRRW91?=
 =?utf-8?B?TGpYOCtMeG1ZVU9pYTlJWFh5eE9YTXovWVNma202bmhIZTI4NGhnei93SUFa?=
 =?utf-8?B?b0RzSml4enFMeUR0OSt6bDhXTU4rYzFLelVnWDlPR1MrMnpCTW51d3UxOVZz?=
 =?utf-8?B?aTkxc2ovWTlvSFpWblNDS2U4S0t2MU92YVdMc252V2JjbDFveXBDZThhdHQ0?=
 =?utf-8?B?UnNsNWJ1ODNWL1RMNi9yblhmVEVabThZYUJqWExyN3dtRjRNaWExVTNpWGZC?=
 =?utf-8?B?WU5mNXdyS0xMMHpMOThPZXdpaHN5YU40OFQwOGpiS2tDUXl3cG1PQTFkTXlr?=
 =?utf-8?B?RVg5QmxTQ0txelZwcVFoMGpQaXJIbUVsQjh1am1pelFDQzZmQW5YYmRkY0dj?=
 =?utf-8?B?WUtBSCtvdkNmQXpRTU9HQjJwQ0pQaXg1UHRpSDRiS2d4NWNOaGFrNDNRTGZl?=
 =?utf-8?B?RnBjQnEyOEM2OXdqeWRoaW1qUElLQ29TZjVpOSs2VmkrMjlNWlZNaHRQR2U3?=
 =?utf-8?B?VGdnN00xeDVpQUMxVW5NZG9yVE84RVFSSzgwQ3hQb25ib3VKSmQyeSsxVjg1?=
 =?utf-8?B?VElhYjUrZUZoZWJEaDV6N1NQNzNxd2pha05YZS9IdGY3b2JJWVFNZ2s3L2pi?=
 =?utf-8?B?T01IYmF3ZXp5UnhMME1Vajl2OTkwMFM5RU5oYjVpK3puckJkSGRmU1NvQVlV?=
 =?utf-8?B?WFk2Y0sxdk1CaFVGUlJGbDZPYk9CS1hYcXJ2UGRydEhkMkdJbjZEWXJoOHph?=
 =?utf-8?B?TlZVcDRneEdUblpRZjJ3eU13dytpaE9XamRyU0pIUGxjZXVnSWFGNWwybWVu?=
 =?utf-8?B?VUwvclBvTVRVSTA0U1VtMjJWM21zdXo5OUxHakJ1NHo2UGNTZDhLUDVYYSto?=
 =?utf-8?B?WXozdW9ROXA2VGhEQzdxU0ZHRit1Z0FQaHg0UEFDUjZ6THUxQnYrQ01kNkc5?=
 =?utf-8?B?bGtuMmFsY0RIVWE5R244c2REL0JqanZqNWRCOE9Ta2xvZ3VHNTU0NmFPcmg4?=
 =?utf-8?B?RlRBcFp1dXgwSklKQnhVczdXK3AxanpCMXRLNDEySnloMitYRUJYWXEvN3lP?=
 =?utf-8?B?S2xCQlJoUGIvUE5wRjNRbTRMRTNPUXphR2VKUEFKanIwM1lGcEpsUmc2Tmdj?=
 =?utf-8?B?Z3JFUWt4dGo5TWl1enUvZVZHSE4yYU9vcHRIMFZHTjZRZWsxQ1dFejFpdks4?=
 =?utf-8?B?WHp0cGoxL2dQOE4rdW1BZjhOaWlCckxpMllEa0x4MzRhRllZNVkxbHQzdnBV?=
 =?utf-8?Q?82ykMsFwVk3/+1LE0gHbE0ZIV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080acf33-1917-4e2a-40c8-08ddcf26beed
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 05:05:47.5285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4jcQEvXQNDNaXe9yKxMhfygW8239GV3n+SaEBoRgQwCdJqMZEdY4ktrBeIMkKlCiExiZ37ZPKgNu7lPR0nerVI9LgNKGgBdMmYC5wBlRdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6087
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgSnVseSAzMCwgMjAyNSAxMjo1OCBQTQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3Jn
DQo+IENjOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+OyBNaWNo
YWVsIFRva2FyZXYNCj4gPG1qdEB0bHMubXNrLnJ1PjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5
ZGVsbEBsaW5hcm8ub3JnPjsgSGFvIFd1DQo+IDx3dWhhb3RzaEBnb29nbGUuY29tPjsgSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlDQo+IEdvYXRlciA8Y2xn
QHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MyAxLzNdIHJvbXMvdmJvb3Ryb206IHVw
ZGF0ZSB0byA3YjFlYjVmN2ZlNmENCj4gDQo+IEZyb206IE1pY2hhZWwgVG9rYXJldiA8bWp0QHRs
cy5tc2sucnU+DQo+IA0KPiBDaGFuZ2VzOg0KPiANCj4gN2IxZWI1ZiBhc3QyN3gwOiBGaXggTWFr
ZWZpbGUgdG8gdW5jb25kaXRpb25hbGx5IHNldCBDQyB0byBzdXBwb3J0IGNvcnJlY3QNCj4gY3Jv
c3MtY29tcGlsYXRpb24NCj4gNjAxZDQxMCBhc3QyN3gwOiBGaXggbWlzc2luZyBTQ1UgbW9kdWxl
IHJlc2V0IGZvciBTU1AgYW5kIFRTUCBpbml0aWFsaXphdGlvbg0KPiA4MDc2OGU0IGFzdDI3eDA6
IEluaXRpYWxpemUgYW5kIGVuYWJsZSBTU1AvVFNQIHVzaW5nIFNDVSB3aXRoDQo+IHJlc2VydmVk
LW1lbW9yeSBmcm9tIERUQg0KPiBmOGFiNjM1IGFzdDI3eDA6IFNob3cgYnVpbGQgZGF0ZSBhbmQg
Z2l0IHZlcnNpb24NCj4gNTMyOTRmNSBBZGQgaW5pdGlhbCBzdXBwb3J0IGZvciBBU1QyN3gwDQo+
IGIxYzI4MDMgRHluYW1pY2FsbHkgZGV0ZWN0cyBOUENNOFhYIFVCT09UIGRlc3RpbmF0aW9uIGFu
ZCBzaXplLg0KPiA0ZjU0ZGZjIEF1dG9tYXRpY2FsbHkgc2VhcmNoIGZvciBVQk9PVCBsb2NhdGlv
biBmb3IgTlBDTTh4eCBpbWFnZXMuDQo+IA0KPiBUaGUgYWN0dWFsIGJvb3Ryb21zIGFyZSBub3Qg
dXBkYXRlZCB5ZXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFRva2FyZXYgPG1qdEB0
bHMubXNrLnJ1Pg0KPiBMaW5rOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVs
LzJhODlhZDRjOGY1NjY1ZDA3OTUyYTRmMTc0OWNhYTZlYzBjZA0KPiAzZDljLjE3NTM2NTQ1MTUu
Z2l0Lm1qdEB0bHMubXNrLnJ1DQo+IFsgY2xnOiBVcGRhdGUgdG8gbGF0ZXN0IHZib290cm9tIF0N
Cj4gU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiAt
LS0NCj4gIHJvbXMvdmJvb3Ryb20gfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9yb21zL3Zib290cm9tIGIv
cm9tcy92Ym9vdHJvbSBpbmRleA0KPiAxMjg3YjZlNDJlODMuLjE4M2M5ZmY4MDU2YiAxNjAwMDAN
Cj4gLS0tIGEvcm9tcy92Ym9vdHJvbQ0KPiArKysgYi9yb21zL3Zib290cm9tDQo+IEBAIC0xICsx
IEBADQo+IC1TdWJwcm9qZWN0IGNvbW1pdCAxMjg3YjZlNDJlODM5YmEyYWIwZjA2MjY4YzViNTNh
ZTYwZGYzNTM3DQo+ICtTdWJwcm9qZWN0IGNvbW1pdCAxODNjOWZmODA1NmI3OTQ2ZGIxYWU0OWNj
MjNlODk4MGFjNDEzMTc0DQo+IC0tDQo+IDIuNTAuMQ0KDQpSZXZpZXdlZC1ieTogSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQpUaGFua3MNCg==

