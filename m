Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2945FC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 06:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmoK1-0006Ic-9S; Tue, 25 Feb 2025 01:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tmoJz-0006IM-Ty
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 01:21:36 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tmoJx-0000l0-TK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 01:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1740464494; x=1772000494;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xt9aJXANnwVGtKUJ4e9g9inYfKRjqwah63DBY2YEVVI=;
 b=VrouhD9Zg3uOqzzOpIMk6UYhit3f/GvN84ftUVQa0LlC7nJJ83qXyKK+
 AmR2Sdn/iOzsKiArXBB6JckhbXzABfQfqABuntfzq04U0eETdINleYNXt
 Auhj6beIC7/hvf3r5zrzLkd54uNDNEIaXNc5JlbSQESc48ctYuaFOi6TY
 7+Whc5zL4eOxH9AoyGzs3HllPlnfwJvoUaT8qHX07yOOXDELas1NcaHq2
 mQq8o331vuBItGVZQMnXm2TPguLs7nxKbzo0zO6WI6NA6vpWMlCnWjFWD
 1kewCxxCrl8R4jdDN8vB9QQfcdW+C1afbOa09bux8F1jbCcnr1IE8KDvu A==;
X-CSE-ConnectionGUID: BZs9dSxWTDC/Im/RlWWS1Q==
X-CSE-MsgGUID: AlUP/kajT+ahzj5n422RkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="147957472"
X-IronPort-AV: E=Sophos;i="6.13,313,1732546800"; d="scan'208";a="147957472"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 15:21:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQCzZhTy5Ki9XLu2/xc6D6GanOgUjpKbsHvPVlDFLsqeHeHn5nG7qJZP0APwNSFOAwj/SyCSHfAdKPvHu/zxZFcqzkDMSK/HKAoF0p2uReTY7X2Fefkw0gz6O23IK2leb3G5EiJiYWeinZBztyYaeBX8iQs8M4X82MTnF6+V8SYFU77C5HJO0IjRZnUCyNkO5MfMdfjulzi33mEWwzcFfzevqgWWD2hBGKSF8RA2J8hXV8wx6I0ev7ib/36Vhljzd2tSJURDagQaZfywe/9bgfBz9owkkBTlMbYmGBjdsvs5Rc2Sz3Wjmwk0Tkli8sPDU8ifvPXIdV8cypIA9kbVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt9aJXANnwVGtKUJ4e9g9inYfKRjqwah63DBY2YEVVI=;
 b=E93yxUxRJPlABmUX0mOGwT5sbc2NiGQ5bTJMFnbiESCzPpaAjk37kOz77OE6XdtGXLz9zE/wTxOH80i7vFNdphDcV4dx/bINg38n6wrucvGNlv4C5Os9IroisyyF1ZBmKN42lR2GZ4Q2kCdpjlE+/njmMtfzvdF/LjTCoGkoeLIYTSjPjxBC99t6M21Na3r5qneNibUAn1BZJrBMYfI+J6Ia24XIKOEqDcdQ1Tq/c4JHhWKv5DpfW+/NOvbJfL7W9kuRjvzFeN2X24py42NSx/mhiFxq17VaRIzS0YpyE2uEFQLoHedG6G5pHPTVNnScbKhRTWOu3VEIuAeUgy1CoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYYPR01MB13138.jpnprd01.prod.outlook.com (2603:1096:405:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:21:20 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 06:21:20 +0000
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 7/8] migration/rdma: Remove redundant
 migration_in_postcopy checks
Thread-Topic: [PATCH v2 7/8] migration/rdma: Remove redundant
 migration_in_postcopy checks
Thread-Index: AQHbhCrBlG6ulKw7oEaprcXJsu1TmbNW5UwAgACtVAA=
Date: Tue, 25 Feb 2025 06:21:20 +0000
Message-ID: <1e44eb40-9131-42ef-8544-ffda89ddd9e7@fujitsu.com>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
 <20250221063612.695909-8-lizhijian@fujitsu.com> <Z7zP-HRmX-Oe89Yf@x1.local>
In-Reply-To: <Z7zP-HRmX-Oe89Yf@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYYPR01MB13138:EE_
x-ms-office365-filtering-correlation-id: 4a16e6d5-cd5d-4ee8-7d45-08dd55649ea3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?b21UT0duUTBuSHEwM2NDTnBmaXRwK3UvUUthWGFkS0JUL0FWemZrVi9ZTEZz?=
 =?utf-8?B?bGduejBSZitYd0xUSDBrREg5OGlJWXRxbGNoMVltWFBXTmkrNGJTWXpWSnEy?=
 =?utf-8?B?MDJsNTIxa2ZNTEJvak4yeWlFUkRaM0l4Qm9pSE1taDF4aW9BRmFmcHlOYi9i?=
 =?utf-8?B?QnhRc0RnSDkxYzJoaWNweEwzSWFSaE81S2d1WjFEbWw5ZUdEdlY2NHpsUFFC?=
 =?utf-8?B?SHNmS053UEM5Q0FzcllLVVp0WTFueVlJallqdS9FRjZNNEY4bTNKeTBtWFFX?=
 =?utf-8?B?TUt4dU9uS05pa1ErazJjYTBrK2NoTE0wODJjNjl6QXZMRHB2bUhabmVzNklr?=
 =?utf-8?B?ZFpld3VuNzc1RWtzd1pxZHgrQVJpeGpFTnh2VUdEajVvSU0xZGhORkE0MXRK?=
 =?utf-8?B?ZHplVGFFU3BwZ2RvR0V1Q3FGdVpQa1A1VGxOZ0hSNG16ay9nMjFiMHBqbk1m?=
 =?utf-8?B?bzJIUWtDNjhxSkZBd3E4TWFWZkE5aGtYVWFDK3MxajAvSklNamQvOGVZV1lw?=
 =?utf-8?B?cm00S0UvNGYxTjRRR2huYzg0UnFISFdrMGh3bnlCKzRCSTVoM2xPbVNaNXZ0?=
 =?utf-8?B?UEh5cFNkUGF1N01JMnlZSE1wWG5tb1VXZTRESmxpVThKbFJ0U2xYVHZDelNL?=
 =?utf-8?B?T1NxbGdrbzViWHA3cFBMQmhSZ2o2c3kxZ091K0dlYTRWQ0hzVjhkSnd6WnFD?=
 =?utf-8?B?c3JTbTRDaGhnME9vR09ReUpNNld3VzBPWDhJcjc4OG1TblhQODVrMy9TSkhi?=
 =?utf-8?B?RmFXUHVIOVJ0WHdpdkdMM0xHQzRGTCtqejBMbkIwem1WTk81d2FSR3NtbWts?=
 =?utf-8?B?aGVndUttNjhieWNXcXZ0a1BDQjBXYmNTUDBRUEVXRE9ocUZXUDhLYmdQSXFU?=
 =?utf-8?B?OUV0L2lQcE1xQW1BbmJ2YmZNc21SbXhmM3prcmgxbUxnMEcvOTM4MTluWlN6?=
 =?utf-8?B?dWJ5NVhYdG9JSmQ0QnJWSXpYTXlpNjZUMTJxR0VPNEhJTGRZUVdyOGRMamFY?=
 =?utf-8?B?ZUg4NnpmUEhtY2o1K2hTN3J2Q0p2WWkxVG94cWpQVnl1Q2RHenZaN3V4UXlD?=
 =?utf-8?B?Mk5KZU5SOWJkbVVsN2lNcWYrUVlQc3UrdG1yVE40bGRhWlc4Z2lKdmNoK2lv?=
 =?utf-8?B?ODlwRjhLVzArZ2dRY0V1MytCblRjVjBBazl5TXAwTm56OFh4OXgvd1FidXNq?=
 =?utf-8?B?b1hna2hnb1U2TmlpOStWeXhqN2dIVldlSnk2NlcwZVN4MnNmYW1UMC9FSXZJ?=
 =?utf-8?B?dWUyRngraHFGS0s1Qk1hTXF5eU9VV2dXbXNEL25vSUpNRDB0bFJWNU1NS1Uw?=
 =?utf-8?B?dHFZeVdyT1A4L2IyVjc5dVYrV1hjZ2F0U0JIVERzWWZ0ZTZjeXRTL0MwTHZK?=
 =?utf-8?B?V1kvd01xM2dsL0xZRC9YdWNibUtNcjhkWWZYZnpxYjZrbVNPSEMvLzFUa2Rt?=
 =?utf-8?B?Rk9ncTdrMVJCMytsMU1KYndtM1poQXNEcnhyNGNqY2lPYW5MVUJpTXFPdnJX?=
 =?utf-8?B?ZUhUdDJJbDR4N3ltdXlwd2Yva0JJSE1aU2E2S2djRHE3WWxYbndWbkR2QWdS?=
 =?utf-8?B?SHgreG1na0VoRGNDazBreExlSTdyN3l3K3hGamRHNUpaRU5zTER5RTJHWitK?=
 =?utf-8?B?ZjJvRkgxTHhoSkpqZlRMbGhDYlZ1dEdYeVVhano0bmtyTUtJdDU0akJCY1JN?=
 =?utf-8?B?cGNQTUxBLzgzaTBiV1FVUGNRN0VuZTVtVDR5OXpwUDNhZml4YTR2MnJWRTZ3?=
 =?utf-8?B?V2R0c2VqV1c3aExSaDhyR3kxYVZRMG9kKzNiaWRnK0wwQnNPSVhSSmJOemJ3?=
 =?utf-8?B?VHk2cTFZN2IwWWcyZ1hmV01xa3ZVcmMrNklKWENZRVY3QjVzQ3hIbWYzb1BO?=
 =?utf-8?B?VkZjYVp3Q2IzUzc4bkJXaE1OWEtSeXhvQ0ttRkl1cml1UERkQ3pBajZUa2lm?=
 =?utf-8?B?M2RaTDJHYU5OL1FhL2oyMnE3ejdwVGRTTHdNLzFpSk9MdEFwN2dQU0ZNdGVU?=
 =?utf-8?B?TEVXZ01zMWZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REh4VFd1WEY1YjB5Q0FXMHRKWnRTT0Q4ZFYvR3JQUkNxZWhYOVAwZ0lCeisw?=
 =?utf-8?B?dFRDQm54TVhIRjBucndycmVTUjVIMVQvOUxlb0Jkc1p0MlVnck9Za1hpbi9T?=
 =?utf-8?B?NEFBaWhVUkFTWHhXRFMwbHIzWURHbjBxUjJVcmQ1dERhcWNTbDd1YkFsd0pO?=
 =?utf-8?B?Z2k0RnVpWktBS1hVR25nZ2VXNjVMSUR2M3RSazZ2bnRORjhjVHZPNzE3ajZW?=
 =?utf-8?B?WmxHYmtoZlpmZTJyNEExbEhuNEtkUklSdmpyb3NaRE1QZU03MVhMN0JEeXNO?=
 =?utf-8?B?S2FlNGk5TWlWVFpnSUJ5N0YzZVUxeTlHbklXaVpNcFF5Q2ZGNlBUdC9lMVZO?=
 =?utf-8?B?VGROdGYrNHJjcWlOY0o5UnB2NnRzMDRqdi9renVoT0hMNndkTDRXZ3hZUjNw?=
 =?utf-8?B?cktTWWFsSGxEbUNRcVpVZXZ3RmUrVGxNWmRvYUMxQU04cmFWTFNxSHVLMVgz?=
 =?utf-8?B?RjRIbnF3cVZuOGk2REYxZTZ6SVZVSTJhSWVxU1oxTFRDcDltNEtESkQvVmVr?=
 =?utf-8?B?ZmhubVQwK1lkM2RvZkFaV3ZEM0lXang5N1dIRjJGdjZDcWtoTktzNzhsYXBr?=
 =?utf-8?B?d2dKdVJiUklJR0hpeCtRbVlhRXg5S1dUZEtrRGlJWWlHU1ZWOGYwK2VUbGdZ?=
 =?utf-8?B?MUhJSkJpMzE0cEgyNy96SmFwbTNrb2Z1TmVySy9rVi8reGcwbkN2N0U2YUlZ?=
 =?utf-8?B?ZHNUZ3AzUFFpNWdwSmgyQVhTOS92ZWdXTWI1TWgxZWFaQUlpd1kyT3pabWR6?=
 =?utf-8?B?SEhRbmVxRFVhRGc4YkVKejFHbElPVHRDb2QzeFVTT2RBQkVIK2Fwc09UYlRr?=
 =?utf-8?B?ZThqaHMyKytleDM4SklUS1dSSGg4ZURvRWk0TmQreGxzdDRXRGFSekp2bTdu?=
 =?utf-8?B?YVRsUmhES2NGN2VNK3RkWERXUkZHdFFKRWNmZi9TUVExK3ViV1YxNTVLY25O?=
 =?utf-8?B?bGlOYy9HWnhISUFQL0lhUFVRYm9oa2xSazJrOUl1OC8ySUhlYzNYUUZXVEY4?=
 =?utf-8?B?S3FUTk5QalBqV3JPNkxsWWxEaEZTN0lXM2lQT1k5UnR5d1hLRkdRS05JQmd5?=
 =?utf-8?B?MUprd1hTWm1CWWhqaFNkd3hHcmE2Q01lYVNTYWN2N1NvZ0hhdWE1UXNFYzZq?=
 =?utf-8?B?VTh3VVJMRkcrWUhuL0xwYjNlcW92RVNoK0t0R2Z1dEtBYXhKdkcyQ2dteHJW?=
 =?utf-8?B?blVmWGFia1Npbm9zbHFsUmlSdnptL3IvVlpwQklXdFM5Q0lFU0FTUUl1ZGFo?=
 =?utf-8?B?VEVRY2ErRE4rKzZvaklyRG5SNGZvZUZZR0ZVbjBENU5QWnFNeGZjZUdlcUtU?=
 =?utf-8?B?MCtkNVQyZUlJMnkwZnhxUzk3Z2hmcHAxY0FYOWlIZDZINWsvVmU1VWZJOWFi?=
 =?utf-8?B?Mi9uclhENXF2enAxRnZWb3JrMUtuWXp3NGV0ejJkV3RTRFlwZjFRS3hubksw?=
 =?utf-8?B?QmNtMEZyN0tydUFwOWh1QzlIWW0rVW5LdUNZRm9vRURsVktBalJ1MFdMZU9l?=
 =?utf-8?B?YkFZcjQxSjJ4dmxXV0YrNmhSS2pNZkhQSjJndEdidURFbWk4aTZua1FjZ3Jn?=
 =?utf-8?B?UzdFNG51eFpyN3k0T1E1NXA3U1d1Z0tmVlpGaTUyYS8wZUVtQjFaOUFYM1JO?=
 =?utf-8?B?N0wzelBPaGIwd0NQZTlVblJQRzdnMEJRejhKTjF6MExhL2FFaUFRWDhEMlBF?=
 =?utf-8?B?RzUwbDRoUFFvSS9LMFRKZGNWTWttMDdhQUxuWGpOTzJaV3BEVEZuTVBCQUdZ?=
 =?utf-8?B?a0NhVTJCUTBGT1JNWXlrM0NwVmR3Q1ZWTmN1cTBCVUc0dURzV0VRWFduNU5B?=
 =?utf-8?B?Q2p0NFpCUExubmxkMHpveFhXZGZtcU11VFF0Vi9HRS8yMlkwcjZQVUNGdEpP?=
 =?utf-8?B?eW5yRjAwclN1MU1kRHM3MFJqbU56VG9hTGNTV2NxdTJ2WGtGWkZ2bVRUL2VO?=
 =?utf-8?B?Z1A3M2NPenJPNkN1RElBYk0zMTZvWEVDandRdm10ZmZIQXhsYTdEaEZWV3F1?=
 =?utf-8?B?VHpJVkdFMC9haEpwUFQwTlM3ckVXeERLNkRtVDRkdmdqMXhBdVhSSHdoNy94?=
 =?utf-8?B?MDZ2TGtNMlBsMWp3TStNYmFpSzJyUFRSZTA1YlQ1NWZoV2dMTzZjbGhVYm5N?=
 =?utf-8?B?YUZYS2pZYTRlTkRJRTdSNjdYSFdZU2VrRlhYYjV3TWtWU2cxTzB4NTFsc25U?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F56B069D5D2A9E4A962BEFE43CBACEFB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sFT+UUGsIVIaZWgQtB7FOQtiknioXXCtpYIkGSVRXsKS8AoujshRyLmJy/IOBdoan/wvUczivfDvL2NN9wwQi+d7LM5RSs9niV0+8UaFdOAbaYV4Sx1FssPKjCmAbZXTVsGCVDjMuafDoA78z/OYvrPzARnRWnvN9wo0izqeHcaLL2rbofINaBKsZ7IJSpm8A9ZuwmMVZ/r0NFWUT0ysrdtai8YREEivktbXc1xvRChSQXDHNzWPLTTBTU+q0LHXfQdM/VJj2CE2+yf6Ye54BNWMU0ihkNsP4VOTljxJs/ACC8kjO03ig5bic/oI7m01FT+my8gwbXhBQkioKHehzueNhVRGFYe7OHZw+nyKvIVZYfFPjKF39vDCR9BsqUpkKneYUkXlG5+PW+xGmZMDyX0CnK9AUfNG5Jn1CR65a6zfaFsHD0W4uF83+W/WXX/Gw+Luh/7sGDoXEffbSq1JQTlTcA0q+1IxfPdHJCnKTYJ3c659NRTJQ3p0D+M5/2S9fWUIvwCkUkAqW0Ev3dOnjyZdouNd780edeAqUVh1FeTQkPVuEdy30YCCtNapkotoxWMr/Usfwf7B8+ZLDvwUrSXX90FAWGveYGgVVU+WDxoB04bz15YCy5tVz1H5JCWo
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a16e6d5-cd5d-4ee8-7d45-08dd55649ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 06:21:20.2573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pee0+Iu1rwctarAWZOqGo97NkX3rpUO2Yn0rOttuQOjJFn/RyydXigdLOHEOqyKIIPSGn1SbK1fgR5RRk1p+rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13138
Received-SPF: pass client-ip=68.232.156.107;
 envelope-from=lizhijian@fujitsu.com; helo=esa15.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDI1LzAyLzIwMjUgMDQ6MDAsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBGcmksIEZlYiAy
MSwgMjAyNSBhdCAwMjozNjoxMVBNICswODAwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gU2luY2Ug
d2UgaGF2ZSBkaXNhYmxlZCBSRE1BICsgcG9zdGNvcHksIGl0J3Mgc2FmZSB0byByZW1vdmUNCj4+
IHRoZSBtaWdyYXRpb25faW5fcG9zdGNvcHkoKSAgdGhhdCBmb2xsb3dzIHRoZSBtaWdyYXRpb25f
cmRtYSgpLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWpp
dHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBtaWdyYXRpb24vcmFtLmMgIHwgMiArLQ0KPj4gICBtaWdy
YXRpb24vcmRtYS5jIHwgNSArKystLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JhbS5j
IGIvbWlncmF0aW9uL3JhbS5jDQo+PiBpbmRleCBlMDc2NTFhZWU4ZC4uYzM2MzAzNGM4ODIgMTAw
NjQ0DQo+PiAtLS0gYS9taWdyYXRpb24vcmFtLmMNCj4+ICsrKyBiL21pZ3JhdGlvbi9yYW0uYw0K
Pj4gQEAgLTE5MzksNyArMTkzOSw3IEBAIHN0YXRpYyBpbnQgcmFtX3NhdmVfdGFyZ2V0X3BhZ2Uo
UkFNU3RhdGUgKnJzLCBQYWdlU2VhcmNoU3RhdHVzICpwc3MpDQo+PiAgICAgICBpbnQgcmVzOw0K
Pj4gICANCj4+ICAgICAgIC8qIEhhbmQgb3ZlciB0byBSRE1BIGZpcnN0ICovDQo+PiAtICAgIGlm
IChtaWdyYXRlX3JkbWEoKSAmJiAhbWlncmF0aW9uX2luX3Bvc3Rjb3B5KCkpIHsNCj4gDQo+IFRo
aXMgbGluZSB3YXMganVzdCBhZGRlZCBpbiBwcmV2aW91cyBwYXRjaC4NCj4gDQo+IFdvdWxkIGl0
IGJlIGJldHRlciBtb3ZlIDUvNiBhYm92ZSwgdGhlbiBzb21laG93IHNxdWFzaCAyLzMvNC83IHNv
IHRoYXQgaXQNCj4gZG9lc24ndCBuZWVkIHRvIGFkZCBzb21ldGhpbmcgYW5kIGdvdCByZW1vdmVk
IGFnYWluPyANCg0KWWVhaCwgaXQgc291bmQgZ29vZCB0byBtZS4NCkkgdHJpZWQgdG8gcmVvcmRl
ciB0aGUgcGF0aGVzIGFuZCBzcXVhc2ggcHJldmlvdXMgMiAzIDQgdG8gYSBzaW5nbGUgb25lDQoN
ClNvIHRoZSBuZXcgbGF5b3V0IHdpbGwgYmUgbGlrZSBiZWxvdzoNCg0KZTViMTk5OGFkMzAgbWln
cmF0aW9uOiBBZGQgcXRlc3QgZm9yIG1pZ3JhdGlvbiBvdmVyIFJETUENCjlhMWI4N2UyZGI2IG1p
Z3JhdGlvbjogVW5mb2xkIGNvbnRyb2xfc2F2ZV9wYWdlKCkgIDw8IHRoaXMgb25lIHNxdWFzaGVk
IHByZXZpb3VzIDIvMy80DQpiNmNjZDQ5ZTkzNCBtaWdyYXRpb24vcmRtYTogUmVtb3ZlIHJlZHVu
ZGFudCBtaWdyYXRpb25faW5fcG9zdGNvcHkgY2hlY2tzDQpjN2M0MjA5ZGI2ZiBtaWdyYXRpb246
IGRpc2FibGUgUkRNQSArIHBvc3Rjb3B5LXJhbQ0KMDQ2M2I1NGQ3ZjkgbWlncmF0aW9uOiBBZGQg
bWlncmF0aW9uX2NhcGFiaWxpdGllc19hbmRfdHJhbnNwb3J0X2NvbXBhdGlibGUoKSBoZWxwZXIN
CjIxYzc2ZGNhYmVlIG1pZ3JhdGlvbjogUHJpb3JpdGl6ZSBSRE1BIGluIHJhbV9zYXZlX3Rhcmdl
dF9wYWdlKCkNCg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQo+IEkgZmVlbCBsaWtlIHRoZSBmb3Vy
DQo+IHBhdGNoZXMgY2FuIGJlIHNxdWFzaGVkIGludG8gMSBvciAyIGluc3RlYWQgd2hlbiByZW9y
ZGVyIHRoZW0uDQo+IA0KPj4gKyAgICBpZiAobWlncmF0ZV9yZG1hKCkpIHsNCj4+ICAgICAgICAg
ICByZXMgPSByZG1hX2NvbnRyb2xfc2F2ZV9wYWdlKHBzcy0+cHNzX2NoYW5uZWwsIHBzcy0+Ymxv
Y2stPm9mZnNldCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9m
ZnNldCwgVEFSR0VUX1BBR0VfU0laRSk7DQo+PiAgIA0KPj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlv
bi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5jDQo+PiBpbmRleCBjNjg3NjM0N2UxZS4uMDM0OWRk
NGE4YjggMTAwNjQ0DQo+PiAtLS0gYS9taWdyYXRpb24vcmRtYS5jDQo+PiArKysgYi9taWdyYXRp
b24vcmRtYS5jDQo+PiBAQCAtMzgyNiw3ICszODI2LDcgQEAgaW50IHJkbWFfYmxvY2tfbm90aWZp
Y2F0aW9uX2hhbmRsZShRRU1VRmlsZSAqZiwgY29uc3QgY2hhciAqbmFtZSkNCj4+ICAgDQo+PiAg
IGludCByZG1hX3JlZ2lzdHJhdGlvbl9zdGFydChRRU1VRmlsZSAqZiwgdWludDY0X3QgZmxhZ3Mp
DQo+PiAgIHsNCj4+IC0gICAgaWYgKCFtaWdyYXRlX3JkbWEoKSB8fCBtaWdyYXRpb25faW5fcG9z
dGNvcHkoKSkgew0KPj4gKyAgICBpZiAoIW1pZ3JhdGVfcmRtYSgpKSB7DQo+PiAgICAgICAgICAg
cmV0dXJuIDA7DQo+PiAgICAgICB9DQo+PiAgIA0KPj4gQEAgLTM4NTgsNyArMzg1OCw4IEBAIGlu
dCByZG1hX3JlZ2lzdHJhdGlvbl9zdG9wKFFFTVVGaWxlICpmLCB1aW50NjRfdCBmbGFncykNCj4+
ICAgICAgIFJETUFDb250cm9sSGVhZGVyIGhlYWQgPSB7IC5sZW4gPSAwLCAucmVwZWF0ID0gMSB9
Ow0KPj4gICAgICAgaW50IHJldDsNCj4+ICAgDQo+PiAtICAgIGlmICghbWlncmF0ZV9yZG1hKCkg
fHwgbWlncmF0aW9uX2luX3Bvc3Rjb3B5KCkpIHsNCj4+ICsgICAgLyogSGFuZCBvdmVyIHRvIFJE
TUEgZmlyc3QgKi8NCj4+ICsgICAgaWYgKCFtaWdyYXRlX3JkbWEoKSkgew0KPj4gICAgICAgICAg
IHJldHVybiAwOw0KPj4gICAgICAgfQ0KPj4gICANCj4+IC0tIA0KPj4gMi40NC4wDQo+Pg0KPiA=

