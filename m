Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7AFC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 21:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tct89-0007zB-9R; Tue, 28 Jan 2025 16:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>) id 1tct86-0007yv-K2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:28:18 -0500
Received: from mail-dm6nam12on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2417::604]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>) id 1tct84-0006Aj-K2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:28:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyWXf71maVj5sfT/Mls2o3z0gBiespNksUlzWyBmgSiyHrw92ThLeIfzPFfG0bdlbuaa70ZNY3MdCEKxmccqB0xhF3WQUmTm925qnrYrTYJjwosb41oGG6iLMc7DO/q5pAzHKvs1bj4yULZpIXBbSdcD5yaRO6h9oUM7cVaEUKDcCBy8rHOjUdsn9ilkFIjqXJtU4leC8oWKaNBWx64SfKi9ahxFSD9CVzblZCvz8tLtJlQ/fJ/LkrLOVvwTCRRA2RFwHbMwPl8uD1HGVfGgIEQj0T+bmzH+A6zWRfVIQ7ITpjgWZk5T89u8rALgLKaARM69INl0TXwL/zEx7mvlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgdpakaXs2Kul0cbf9fneaIN+USej4aucpwn6MokS2Y=;
 b=NLp08+mGP9mPVhgDqohSowosQxturc5qmLuearfbsOa3Dj7Rx9DFNkmY3xeY+Nz0ht42SxsgOV6hK7bZ2JoGSyt9uDN7mZj7ry+6Yv5sCDHVC4bmuDQFa90wFDubbtJFLJqx7Itn/6LZyMpIkGiqvv6CqAuI9k9odUgtUUwIt80vII1fYTat6Zlry2as2ZqKB6ZdHBrhAlazfpdnb+A+aKg3I2aeNtvcTe2xUdeeTmTIfecam8ECWNn+T0juSvjsZV5Y/94hJZB5mJUkSRLylNXpuY82NbFIFoUspEUl+UfHZODhd81D8x4zOhZkimQK+Mcw71Dh3RvboGdeP00/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgdpakaXs2Kul0cbf9fneaIN+USej4aucpwn6MokS2Y=;
 b=S+2xRQtttIdlmRAZtm2TpdIprQMQXs6mvYl1ItW7NRT/I/kwiJKWgT+mFYPspDc8/IkVnC/humc3yTb8xyCByF39840s1IqeutfBgvJWp00qmFoHt2f7FyNZI+HuTob7D0X7tZrrdAoxzuy2FQ5sTg89EbvEUCLgX8qsumB3WJj/MidwdrMnEzEnqdoPIhieX00D+WRAU4n7LCmmRtTtEphAg+HRV7fOEh8vc+TZDqpovZSlRxTrz5iV352evMOFp0pd97oyv/43bBNhIb47ZM6mrrnqgfaXcyHT8LPQr+8i3oUy7OPt5d4fRUp0laxrEZuJklSWKVBoxeeMvuG2GQ==
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Tue, 28 Jan
 2025 21:28:09 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%3]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 21:28:09 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Nathan Chen
 <nathanc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>
Subject: Re: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
Thread-Topic: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
Thread-Index: AQHbcZ4NVBrM9t9rn0KftTkrAnTiqbMscwGAgAAEbACAADxXAA==
Date: Tue, 28 Jan 2025 21:28:09 +0000
Message-ID: <BDF4F631-8A96-41B5-B7CE-2BD631C23A2B@nvidia.com>
References: <20250128160237.3379569-1-mochs@nvidia.com>
 <73f3e4cf927845809c6b10424c00c0ff@huawei.com>
 <cb91da0e-9163-4e59-a060-4a76a077c5d5@redhat.com>
In-Reply-To: <cb91da0e-9163-4e59-a060-4a76a077c5d5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8897:EE_|PH0PR12MB7815:EE_
x-ms-office365-filtering-correlation-id: 145ee861-eee9-46ac-e39e-08dd3fe2a948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WktUMnFFQWJnK25qUjJIc1pVZXQwdTFlS0tZQmxMTlZrSE1WRG5OUXJ0T3g0?=
 =?utf-8?B?aHR0eU5wdkZpYjh3SGhvUGRHVmVSbDlISFdaVHp1ZytrM0ZXdXdUVzBmb3l3?=
 =?utf-8?B?TG8wS1pIdkR2bjF0dzNML0NVNmVYYjdDWE5VQ24rMExKbU1pWjZnL2t5ZzlV?=
 =?utf-8?B?TU4ya01NaHlXQW5qV0htNFNucXh3cG5RYnpHQ3hySXpSOGdJK01qTUd1eUIx?=
 =?utf-8?B?d2pmRmZUUmt5TkZnWkgyVWxXbC9JVVRaR0xBK205c0hGOHNVUGF3THRJMDgy?=
 =?utf-8?B?MnNHQXRDTis2dVRNZmtuUXgrcWxwWGVxMFRXaFdKZG1UTHU0YXpXSVNhVG1O?=
 =?utf-8?B?NjMvaXpHWTNqZzlJb3RvSndSL0E4VWZKc3ZiSHBHZU94SjBaS3ZjV0UzQmtY?=
 =?utf-8?B?aVJKcndSN1llckVKUml5bEx4KzZyR0o3OTJGajJ2U3FQbXZNdy9KU3JpOHZj?=
 =?utf-8?B?eHJZUzlHaTc0ZGFraWkxTDNhRklJYUN4MjBNRmpkOEEvdk1qNnByQmt3Wktk?=
 =?utf-8?B?TFNtNDRGNXo4UUJpR3l2OEovbkY0SXNTNit6RXcwcWc5UU1LK1dkS3BhckZr?=
 =?utf-8?B?SXM1bDJJVWRvbTduNmFRZDMrdTNXMjM2c1M0Zno1YmdJalQxZVlESVYyb2xu?=
 =?utf-8?B?R3V5d29aSWdQc2FQQjBzL1hRSlRacEZ5Z2Y4Slo4QnJIaDFhZUUySkdyVHlN?=
 =?utf-8?B?N1lDYnhqMlEvRzl6dmp6VHlnYWVPcGZWSGtlNTNZQ2ZrSHdHWUVFLzFYS2Zr?=
 =?utf-8?B?OE5ZbHZJMmcrc3g2eUpSTzFKa3MyNTJqWC9UanBObUlMcEhGVXltMG5tYkV3?=
 =?utf-8?B?d3FneERrNWFRUDJyVDNLSldxVm9namcwbjJ1ck1ZSlp3N0pIMzRWUVlLb3Nk?=
 =?utf-8?B?UjQ3N1hnSDBnZ05UZmlDbzlvODJBWlJQT3NGS2s4TUVOVUF5eklDcWxBdi82?=
 =?utf-8?B?ZTZ3ZzNhSklrWVFOWjU1U0FJdVdZSHdxenBIVUlqM2VuYnEwdzRtdi9rQjFM?=
 =?utf-8?B?dGdLUDR4K00vSWtkWVVwWkhUOFlOWERuZnR0TXFpZTM3UFZsWHg1U005VmI2?=
 =?utf-8?B?SlE0ZHkrSElLMllOQUtZZFJEbCtuY2FmaVdkektLNXhTQ2RPem5JVllJMVZL?=
 =?utf-8?B?VHozbjR6QzAvMWhDd1p5UlpIQXpLTEhPRU91QlhKWlBSNjBQUjJRYkVzczI5?=
 =?utf-8?B?dWp0S3NSZmFDMzdlbVV2MHY2NWtzbDIxdDNqWkZpenZWK3Fmd0FqMGRVRkp0?=
 =?utf-8?B?ZFVQVDJmRStxS3NKT2RZK2oyckU4VGNzajdQVEtMc3l2bEpyM0ZRNU9hM0Q0?=
 =?utf-8?B?K1ZqUk1hVGt5emE5Wk1PZlgwc2llWnQzWis1ZG9iK0lsaFpEMCtCRmJyQ0Fq?=
 =?utf-8?B?WVVnUzlreXVpSzY4T2JxcEljN1QyeFN5NEVQNlFBc25EeHhRdGppTkRSQkJv?=
 =?utf-8?B?bXN0V1RscDJyLzI5TUNoM2hFcVhyQmNtbjJFVDJuVGZxTnI5a2wxMTdjQ3Ux?=
 =?utf-8?B?SjlKUzdWQjFuVE43ZVptRUFaT0VKVGg4YVVwQ1F3c21OVUNTV3VoV2krVXdo?=
 =?utf-8?B?Snk1MEc1bnh6NWJlSUg1TW15VTRJQUVkRzJxd3ZNbm1qanllWkRKRlBrRGtG?=
 =?utf-8?B?ZVU0eDhSTUo3S1FtNmp0VDkzRkZkM1hNSWhJN2hpM1pvNEUvZVpweHFreHpO?=
 =?utf-8?B?c0U3c0I3Y0RpeUpIZit6NDBzQU1kT081YVhrdHFleVlvR0hVQUFaZVNjejZC?=
 =?utf-8?B?K3VEaCthODJ3czhsYnlUSlFtakVBWVk4NDRKSjdJbThSd3k4T1ZKeEJZaGNO?=
 =?utf-8?B?cmhUNFFJeCtIK2RFZUFQS1I2M2V0SE00UEdwMkM0RW5GTHhhMkFwK0ZiN3pw?=
 =?utf-8?B?bmhxbHQ1ODFHc01DTmlHWHhJbDFWSzdxS2pkQm4zMVZuM1QveHpXSEswbmQv?=
 =?utf-8?Q?XvxGIkZJlZlmmwJL4bJtoxzg40EjNT4l?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDlid094UDZuSkdYWE9JZ25IREhWQWd2MStINEMxUGVJbGlUZkVHVExkallx?=
 =?utf-8?B?d0FHcFZCT2dZaSszWGhVa0tYNi9JNUJncjdoV2MxR29odW12bVpYNnhub3hh?=
 =?utf-8?B?alhPSUw4THRwUlZTb3FhaUF6SisyTXdLQWl1MjlMYkZHQmU2OXgxb29tTnR2?=
 =?utf-8?B?ZWEwRmhnRnVUbXdMcVFSWmdLdkhpQ1AwbGV6cjZuU291anVmeVNLd1hVZWxm?=
 =?utf-8?B?eDQ2dERCeEgvRk1MaGR6QkJ4aDZVUU1GWUNqQTZPLzZFYmRtRzRPT24zYnFq?=
 =?utf-8?B?MXhwSTFkN2c3d2pCWlVvK1FxQVlXM0ZUZ3VQRFF1emR1ZHZBZ0IyS1dYV0Nh?=
 =?utf-8?B?TUY5b1pGc1BxRFhQaGFFNkNHbGV2eDQ4UXFXMFU5T3lNT1FEdjZ5TEtnYjdp?=
 =?utf-8?B?aFRPdGpaZms1YjJhenBaTDlqdXhjZTZHaVcwMjI0N2ZsYVlwL0ZaUEpLZnhH?=
 =?utf-8?B?dkFFZm5qeEJsNVp2MmtWYmFkalFUb3V3QnN6aE5GVWs5Yi9PQ250UU5KWkN2?=
 =?utf-8?B?Tmt2U3hxcDBVdXNvR29WZXNvY0hVRnVPOW5JZEJ2dUpPYUlhNjNHbGxVbXRJ?=
 =?utf-8?B?ZlB0QXMrQ0N0ZlZ5VjI2dDUwT1orZE5TTFBkaklwK0hEMGoyRFZGSHVBVjRD?=
 =?utf-8?B?NDJIMFRQbjk1V1N1ZHpHcmhnWlMzMkRldXI5VG5BeXR1bURLeFdNVTRpbGkv?=
 =?utf-8?B?RXdaV0JzUzVFcGpvOG5LcWFDLzVKcExVOGJ6dlNRMDBNY2VldGFLT1dMdFlZ?=
 =?utf-8?B?cGRQZGU1MnlmSDJQZCt0bkVVRUdvV2h5dUZFMmFxSXByM0k0cGZyUUFyNjJh?=
 =?utf-8?B?ZUZUOWt2L2Vza3pJRnVlMWJLUDRhTHMyMmZEdkJnb1B4TnpHL3ptaDlNMHA3?=
 =?utf-8?B?eWVqTE8vMzNKRFppNDczK2oraDFScmRkblE0Yko3UU1LYXYzWFkzTG9PS2hL?=
 =?utf-8?B?cHZmZEQvMS8vQlhWQXpLRWJ0c2RpSEYvYnZxUEE2ajVYc25PbCt2ekNaQ0Nn?=
 =?utf-8?B?Y2JNVno4bmhYam5qbDQxaXlnWFJGdFRGSUtFY2tDZEttMDg1OVMxaHJuM09E?=
 =?utf-8?B?TXlmYWYrY2tIU2NsU2k3RFJVWE0vb29Seis1OFVMN0RlTVZzaUo2eUUzU3dR?=
 =?utf-8?B?aUFmc3NyTGdpaHBVYkpkNW9SZWtWU25ZbnByZnV6TDFyTitZVFJoWVpjTlpD?=
 =?utf-8?B?dk9jZzlTUHZScXJ6WXdibng0MjBuOVRxREJSKzRzb28xQ1VOY1ZKM0hTZWhV?=
 =?utf-8?B?Qk1JaWRiS0x0bjZNR1Noak50ZWVIUEkxV04rNEhHb2g1WFVIUy9sQ1BuRnBk?=
 =?utf-8?B?NnRLbXk2S3M4cVFTTldnN1NSWFdSSko1dmI4QUZBanF5WlVIL2ZRNTlnTFlW?=
 =?utf-8?B?YkZaa0NqSXBwcjRwaGZMNVNab3IyWTdlb1NPZ3RIaERiV25qeXliNUJRVnJ0?=
 =?utf-8?B?c0RjOHVhWUYycUMzQVhhanRyNUdLNFlyaDRCb2ZMb29sOElmRXVYQml1STF2?=
 =?utf-8?B?RUVMZWpEQ25yRjh3VWdSTVRteFhIbGQxbVRraHl0ZTF0ZGk0eHJqaWw4dG14?=
 =?utf-8?B?TGtMbjEvTU1DYjhrbVh5WmUvbTY2YVYyUmk5bjVsVng3UWVRVE9zSUFrQjFl?=
 =?utf-8?B?SnlGZGxEWVhtdEhENHFnLytxbDFPbEMvdmMzUjVyMFNXM3lLdHdSWW9BbWIw?=
 =?utf-8?B?ZUprMzNDSEdzNG5zSXpEOVNGd3VKRW1HNFdnSm1QUUZzbVFkNGFya3Vva254?=
 =?utf-8?B?T0dFaExvcTRUTk1lTGI4NFJVWHp2MS84MEF6ZzNwVk1IMzZVSnBnVk8rWWJQ?=
 =?utf-8?B?Yzgyd3NQWkI4SThJNytweEpocHRqUFFJSEpxYmxqUUtjT0txTkpZS3QwMzdD?=
 =?utf-8?B?NXRsdXVFTy84QkNVNTZ6WmM0QUFzcHBiMDBHT3pRekZLTG1oYXpZVzYyV3ZM?=
 =?utf-8?B?NkVnTndlK0RiME1CSnhNOTl3VkYrNjYxZHoycmxsamdDaEZDN3FuT1JxdTVL?=
 =?utf-8?B?NW9lR3ZmOEM0TktPczU3VTRHWjFScHNqRklpZHpFbHdWYVl2QWxGRzVjdk1x?=
 =?utf-8?B?QlpETUoyN3oyZENvZlJLVnhLUVNJL2RKamNwSFlsOXFzT282Q24ySzdhcFEx?=
 =?utf-8?Q?rMhHcE1BlFg3HqDu6uEFyH2V/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02594A6F8B640248849443E5381DC444@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145ee861-eee9-46ac-e39e-08dd3fe2a948
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 21:28:09.1235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmne58K5ApkKZ9Nh7Bey+SnPYraiz0hdM6LcSlSlERI07B0mvPWJkmsvMPLKbIbnzcKByWvRZSCtmdbmYo4VmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
Received-SPF: softfail client-ip=2a01:111:f403:2417::604;
 envelope-from=mochs@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiBPbiBKYW4gMjgsIDIwMjUsIGF0IDExOjUy4oCvQU0sIEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBNYXR0aGV3LCBTaGFtZWVyLA0KPiANCj4gT24g
MS8yOC8yNSA2OjM2IFBNLCBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPj4gDQo+
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBNYXR0aGV3IFIuIE9jaHMg
PG1vY2hzQG52aWRpYS5jb20+DQo+Pj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAyOCwgMjAyNSA0
OjAzIFBNDQo+Pj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgU2hhbWVlcmFsaSBLb2xvdGh1
bSBUaG9kaQ0KPj4+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+OyBuYXRo
YW5jQG52aWRpYS5jb20NCj4+PiBDYzogZGR1dGlsZUByZWRoYXQuY29tOyBlcmljLmF1Z2VyQHJl
ZGhhdC5jb207IG5pY29saW5jQG52aWRpYS5jb207DQo+Pj4gYW5raXRhQG52aWRpYS5jb20NCj4+
PiBTdWJqZWN0OiBbUEFUQ0hdIGh3L2FybS92aXJ0OiBTdXBwb3J0IGxhcmdlciBoaWdobWVtIE1N
SU8gcmVnaW9ucw0KPj4+IA0KPj4+IFRoZSBNTUlPIHJlZ2lvbiBzaXplIHJlcXVpcmVkIHRvIHN1
cHBvcnQgdmlydHVhbGl6ZWQgZW52aXJvbm1lbnRzIHdpdGgNCj4+PiBsYXJnZSBQQ0kgQkFSIHJl
Z2lvbnMgY2FuIGV4Y2VlZCB0aGUgaGFyZGNvZGVkIGxpbWl0IGNvbmZpZ3VyZWQgaW4gUUVNVS4N
Cj4+PiBGb3IgZXhhbXBsZSwgYSBWTSB3aXRoIG11bHRpcGxlIE5WSURJQSBHcmFjZS1Ib3BwZXIg
R1BVcyBwYXNzZWQNCj4+PiB0aHJvdWdoDQo+Pj4gcmVxdWlyZXMgbW9yZSBNTUlPIG1lbW9yeSB0
aGFuIHRoZSBhbW91bnQgcHJvdmlkZWQgYnkNCj4+PiBWSVJUX0hJR0hfUENJRV9NTUlPDQo+Pj4g
KGN1cnJlbnRseSA1MTJHQikuIEluc3RlYWQgb2YgdXBkYXRpbmcgVklSVF9ISUdIX1BDSUVfTU1J
TywgaW50cm9kdWNlIGENCj4+PiBuZXcgcGFyYW1ldGVyLCBoaWdobWVtLW1taW8tc2l6ZSwgdGhh
dCBzcGVjaWZpZXMgdGhlIE1NSU8gc2l6ZSByZXF1aXJlZA0KPj4+IHRvIHN1cHBvcnQgdGhlIFZN
IGNvbmZpZ3VyYXRpb24uDQo+Pj4gDQo+Pj4gRXhhbXBsZSB1c2FnZSB3aXRoIDFUQiBNTUlPIHJl
Z2lvbiBzaXplOg0KPj4+IC1tYWNoaW5lIHZpcnQsZ2ljLXZlcnNpb249MyxoaWdobWVtLW1taW8t
c2l6ZT0xMDk5NTExNjI3Nzc2DQo+PiBJIGd1ZXNzIHlvdSBjb3VsZCBkbyBoaWdobWVtLW1taW8t
c2l6ZT0xMDI0RyBhcyB3ZWxsLg0KDQpTdXJlLCB0aGUgdmlzaXRfdHlwZV9zaXplKCkgaGVscGVy
IGNhbiB1bmRlcnN0YW5kIHRoZSBjb21tb24gdW5pdCBzdWZmaXhlcw0KdXNlZCBmb3Igc2l6ZXMs
IGUuZy4gMVQuIFRvIGNsYXJpZnksIEnigJlsbCB1cGRhdGUgdGhlIGV4YW1wbGUgaW4gdjIuDQoN
Cj4+PiAraGlnaG1lbS1tbWlvLXNpemUNCj4+PiArICBTZXQgZXh0ZW5kZWQgTU1JTyBtZW1vcnkg
bWFwIHNpemUuIE11c3QgYmUgYSBwb3dlci1vZi0yIGFuZCBncmVhdGVyDQo+IG1heWJlIGtlZXAg
dGhlIGV4aXN0aW5nIHRlcm1pbm9sb2d5LCBpZS4gaGlnaCBQQ0lFIE1NSU8gcmVnaW9uLg0KPiBl
eHRlbmRlZF9tZW1tYXANCj4gV291bGQgZGVzZXJ2ZSB0byBhZGQgc29tZSBjb21tZW50cyBvbiB0
b3Agb2YgZXh0ZW5kZWRfbWVtbWFwW10gdG9vLg0KDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9u
LCB3aWxsIHVwZGF0ZSB0aGUgcGF0Y2ggdG8gdXNlIGV4aXN0aW5nIHRlcm1pbm9sb2d5Lg0KDQo+
Pj4gKyAgICBpZiAoIXZpc2l0X3R5cGVfc2l6ZSh2LCBuYW1lLCAmc2l6ZSwgZXJycCkpDQo+Pj4g
KyAgICAgICAgcmV0dXJuOw0KPj4gUWVtdSBzdHlsZSBtYW5kYXRlcyBicmFjZXMgYXJvdW5kLg0K
DQpXaWxsIGZpeCBpbiB2Mi4NCg0KPj4gDQo+Pj4gKw0KPj4+ICsgICAgaWYgKCFpc19wb3dlcl9v
Zl8yKHNpemUpKSB7DQo+Pj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiaGlnaG1lbV9tbWlv
X3NpemUgaXMgbm90IGEgcG93ZXItb2YtMiIpOw0KPj4+ICsgICAgICAgIHJldHVybjsNCj4+PiAr
ICAgIH0NCj4+PiArDQo+Pj4gKyAgICBpZiAoc2l6ZSA8IGV4dGVuZGVkX21lbW1hcFtWSVJUX0hJ
R0hfUENJRV9NTUlPXS5zaXplKSB7DQo+PiBOb3Qgc3VyZSBpdCBpcyBiZXR0ZXIgdG8gZmFsbGJh
Y2sgdG8gZGVmYXVsdCBzaXplIGhlcmUgaW5zdGVhZCBvZiBzZXR0aW5nIGVycm9yLg0KPiBJIHRo
aW5rIGlmIHRoZSB1c2VyIHNldHMgYSB2YWx1ZSBpdCBzaGFsbCBiZSBvYmV5ZWQNCg0KQWdyZWVk
Lg0KDQo+IE5vdGUgdGhhdCBwZXIgdGhlIGR5bmFtaWMgbWVtb3J5IG1hcCBhbGdvLCBjaGFuZ2lu
ZyB0aGUgc2l6ZSB3aWxsIGFsc28NCj4gY2hhbmdlIHRoZSBiYXNlIGFkZHJlc3MuIFNlZQ0KPiAN
Cj4gdmlydF9zZXRfaGlnaF9tZW1tYXAoKS4gQnkgdGhlIHdheW4gd2h5IGRvIHdlIGZvcmJpZCBh
IHNtYWxsZXIgc2l6ZT8NCg0KVGhhdOKAmXMgYSBnb29kIHBvaW50LCBJIHdpbGwgcmVtb3ZlIHRo
aXMgY2hlY2suDQoNCj4+PiANCj4+PiArICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9hZGQob2Ms
ICJoaWdobWVtLW1taW8tc2l6ZSIsICJzaXplIiwNCj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2aXJ0X2dldF9oaWdobWVtX21taW9fc2l6ZSwNCj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0X3NldF9oaWdobWVtX21taW9fc2l6ZSwNCj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCBOVUxMKTsNCj4+PiAr
ICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9zZXRfZGVzY3JpcHRpb24ob2MsICJoaWdobWVtLW1t
aW8tc2l6ZSIsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJTZXQgZXh0ZW5kZWQgTU1JTyBtZW1vcnkgbWFwIHNpemUiKTsNCj4+PiArDQo+PiBJIHRoaW5r
IHRoaXMgcHJvYmFibHkgbmVlZHMgYmFja3dhcmQgY29tcGF0aWJpbGl0eSB0byBrZWVwIG1pZ3Jh
dGlvbiBoYXBweS4NCj4+IElzbid0IGl0PyBTZWUgdGhlIG5vX2hpZ2htZW1fY29tcGFjdCBoYW5k
bGluZy4NCj4gSSBndWVzcyBpZiB3ZSBrZWVwIHRoZSBzYW1lIHZhbHVlIGFzIGRlZmF1bHQgd2Ug
YXJlIGdvb2QuIFRoZSBkaWZmZXJlbmNlDQo+IHdpdGggaGlnaG1lbV9jb21wYWN0IGlzIGl0IHdh
cyBzZXQgYnkgZGVmYXVsdCBmcm9tIDcuMiBvbndhcmRzIGhlbmNlDQo+IGNoYW5naW5nIHRoZSBt
bWlvIGxheW91dC4gSGVyZSBieSBkZWZhdWx0IHlvdSBrZWVwIHRoZSBzYW1lIElJVUMuDQoNCkni
gJltIG5vdCBzdXJlIEkgc2VlIGFuIGlzc3VlIHNpbmNlIHRoZSBjb2RlIGlzIGRpcmVjdGx5IG1v
ZGlmeWluZyB0aGUgc2l6ZSB2YWx1ZQ0KaW4gdGhlIGV4dGVuZGVkX21lbW1hcCBhcnJheS4NCg0K
DQo=

