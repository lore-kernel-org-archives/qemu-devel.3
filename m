Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BECE7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 07:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIkDh-0000sS-Kd; Wed, 04 Dec 2024 02:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tIkDT-0000nT-7M; Wed, 04 Dec 2024 02:54:38 -0500
Received: from mail-tyzapc01on20731.outbound.protection.outlook.com
 ([2a01:111:f403:2011::731]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tIkDO-0002S0-93; Wed, 04 Dec 2024 02:54:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8gSWl2sFhfnG1cNvGf2m6SOZfhQw8+ddhJwmaUrv8905wVpLGQJEDEqTXCfFZlxBxFddBgVrA0j/dh9cN3Co96yp9wiW1VT03z63bt7n8Vj/xeIVk075IkZHERSTP6IaSdTkATi/Fln2bQ4zz3hUrB+mUrlm1+q8y5aAO67u8ZnwE/9axjJLoZ6O0O+M6thxERSMCNBj7JsJkUp5P2mgUGKgokoK/0IIwPCkkpoyNfbpIPaBh/+K6HmdVpzv5UUXZrvtBnVPvXVkFpFq1Xvgr+GhJEkzCIScLQfUCe7AJMcMjyab7fZ2UHlh1Qv1aQTU9jQ051ZwNkxudUzmG/bnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fs+aGBjHW3l+PuOUO65S+tv+Zlq+TsqhMD76JAdo5wk=;
 b=B3kuJJDnaoSrcNrFvTYk+g+/m7aNKrlLy/Z+pWOhaf7gyM4tJ6rMpZHblNvOBz1/DEctRSRjyMucgPRbnzT7St/oRjrZSxJHrOxsncZ6KVfJRwidx8ARuFtmuRbbvxeYiGXknR9VHXb049R89GBvpgFt1Z27gyKsgv6orHXkYo+6C2A4QtEhwki/sCus6GdvBu5NnOMLMPflBjxO3Mr4XzLTyo8zppuOfO+o35DnCx+jC9MMLEFcpoTRDTl2soy+DFCz6U/IzdkHWxV9z/AHOspNfK9/0LQUre7BZGEDKdeY0DRKTsRUbQmezKbs/LgOyP+ngVpdkiEwdy1pfJNySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fs+aGBjHW3l+PuOUO65S+tv+Zlq+TsqhMD76JAdo5wk=;
 b=HZepNia9wQto1YPU8ATQ2VX+8CHFGALItoOhAd3sHV2weKm51pbUAWrMiOrcGnakuoHqsa7ZhPzzE0VA7qo3GEtOEwcJk8T8adllmGjG90/cjoJh2lyNS3DnEysIIfj5eOnae3Usiz61d6XFfsUOkxCjDD2GJXznR7WzVYMjcPg5S5See+9cyT43YBSFxIObrN8WihgLZC5yexvkkCaPAC1sKPIGNO+aUblUVx5dm4P/2mHSf3ZPg3mM7+1XUlp9KfvqdGjCxXQMVejUnGn59xQ7JT0kY97TJOxFNYgDUqekVlRwf0I+5/OfJbaIqZ0N44kbzJC1PGEDb/DysESNDg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB5085.apcprd06.prod.outlook.com (2603:1096:101:55::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.10; Wed, 4 Dec 2024 07:54:22 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%7]) with mapi id 15.20.8230.000; Wed, 4 Dec 2024
 07:54:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Bernhard
 Beschow <shentey@gmail.com>, Jamin Lin via <qemu-devel@nongnu.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 3/6] hw:sdhci: Introduce a new "capareg" class member
 to set the different Capability Registers.
Thread-Topic: [PATCH v2 3/6] hw:sdhci: Introduce a new "capareg" class member
 to set the different Capability Registers.
Thread-Index: AQHbRSku2n2Tv9S1rkmdLgDvcmDNcbLU+CoAgABujyCAADJZAIAAH8kQ
Date: Wed, 4 Dec 2024 07:54:22 +0000
Message-ID: <SI2PR06MB5041A4F1DDEBF7D420FE4C20FC372@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241203021500.3986213-1-jamin_lin@aspeedtech.com>
 <20241203021500.3986213-4-jamin_lin@aspeedtech.com>
 <94E62126-BB97-465A-9021-2FB365E677A8@gmail.com>
 <SI2PR06MB5041216ED78069F9BBE4275FFC372@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <793ffece-66b6-4201-bc78-cc774d8ec35b@linaro.org>
In-Reply-To: <793ffece-66b6-4201-bc78-cc774d8ec35b@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB5085:EE_
x-ms-office365-filtering-correlation-id: 26b50c76-d0c5-49a5-fe6a-08dd1438dd6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?VDFXYjlwSFJ0MUYxNTI4U3MxeUhLemc5dVpBQTdyeEVqOCs2QnRuRW5yRHRj?=
 =?utf-8?B?aEVOb2xCc3hScXVnME54Ync0Y1JHVWlzRXJnbEtRVWRQaGpIeTRWYWNldnRS?=
 =?utf-8?B?V3FDcy9KaG0yZGY1OHVuRm1OcXFMcndUMjlCV0hydGxPK24zeVVmbUtVSTlp?=
 =?utf-8?B?TkJBSWVOSDViNkJmSWNkSE5aejhrS3lZaEVJVm8ySGtXNFpTVVQ1RVk1QU1n?=
 =?utf-8?B?ZGxuMjRBdzBZRHQrZnZNMmJuakVITC9HYjVuN1lCaHJjNTNNait4M2lIT1lI?=
 =?utf-8?B?NUhTL05zMTRkWGc2UkZLSnE2RGZ5aXdkMnpGTlZ2Z0VKU2t3NjR4U21zUU1q?=
 =?utf-8?B?YWR1dmhFS3F2TkhFMStEcXVVOFk1R29rdUcyL3R6bDlFZjFKNndxaHhiTTRY?=
 =?utf-8?B?bG51RW9DdXBxdnBjK3dLVTFlSEt4ZTVWSkZGNlY4MDdmdDdNb1ZSRGtDRkVr?=
 =?utf-8?B?WTg1UmxFKzFrNC95VWRhcE5RWXNPbFQrUk5IRzdFSXhxZ1Y5T3o5ZnpJWWNS?=
 =?utf-8?B?cnpWaFlKZE13R0FqV05IYi8yVTVkRFBsV2J5ajkwLzRnek9aajR5aTlBeGNk?=
 =?utf-8?B?cFhiTjhaOFRjQUwzWThoamMyU0VTYjA4Y0lKcFVmUG12Uk5Va0liTE5VdDZR?=
 =?utf-8?B?WGo5d0FjNyswNExmclBvRWI5aC82Wk5jOXpqV2k5SnpqY1VrVEFRRTluOVZW?=
 =?utf-8?B?SVBrQS9EUU0xajFPWWNIUW91Q1NiNndjNlhTbThnWVdVSTlPK29PM0JGdlh1?=
 =?utf-8?B?b3BrOFNxQTk4eTk4WkhvSldIQ1MzdWR6TzRzVEp0dWNZRnUvQ0xwUk5hWGJG?=
 =?utf-8?B?dGxHWkFxUVJsQTJ0aEpYYXV5bzRUK1NibTh3alFRYmRvRnVTZmZZeGdiQ3JF?=
 =?utf-8?B?N0ZiZ1lITHFoTVpQNnVLMk5VckdtUjRLc0xJbFhsREZxQkpFbkVhaURocmtG?=
 =?utf-8?B?TUNwbFV6dmFtS3RJd0tvekNVSVpyMnA5YllYYVpkMUcvbXNjVjd1dU9nTjIv?=
 =?utf-8?B?bXdaWm02dWxjYmtVM21mMEVhVFpweEl1VEJGOHVtNzlkUWVVVkZVNW50blhy?=
 =?utf-8?B?bUNNK2hhVkdsZ093MWp5Skw2cTQrbXdLc0NVS2k5M3BhcmhXVDl3VXpLbWln?=
 =?utf-8?B?c0Z2Wnh2TXA5TGlob3UrVlBSNEdWRFNIQzR1bmh1OVZUVFZTS25DNTZ0T0xN?=
 =?utf-8?B?RlEwOHdQYnBXTzY1bzlaZUdUVUhrcXh6Y3JjdE9RUzNvb0RGM1VIelpNdkNS?=
 =?utf-8?B?Tm5ybDVKOUs5TFhLbXlrMEJXVm1kSVgzcmtWVjlDWGhKOHJ6aVJISHJrVWlG?=
 =?utf-8?B?OGdiM2g2bTlINFRCTDNRV2FkOEVPaHVWVFF3clFQQUtCZkJCOWMyVjA0WnZV?=
 =?utf-8?B?bnpjb2thRTlvdHJoYnBnaldiNXNRSE9SWU9EQnVHTW95UmptZGdnM0tvU0pM?=
 =?utf-8?B?a3lQejNqMUJGQytPMVg3eXhZK3l0bjF4V1RtZjZQNmxNWDc5cGVjYlRHZXBT?=
 =?utf-8?B?QXRpRUJPQzh1YmdCQTZOTHdVMy9uem1GMDlEZ2xZT1V3b3lpYTZyNWxTcUJ3?=
 =?utf-8?B?cTZsTGQxU3VUUXFISnBURVovRldRa1RFdlRjRjZ3OHlqUUtjZmd1UlowdFVO?=
 =?utf-8?B?MUQrak5zVlYvRzkrTFdtQkpHL0dObytlbkl0UmtkRTZwRXVvM1ovZWpjblJZ?=
 =?utf-8?B?cG1FbVNlcEQ1Y0ltY2Z0c001eEx4K2c4S2RIVS9WUVFzSVF4NXpwUkw2MFl2?=
 =?utf-8?B?N1daclhjTzNBOFNHa3oyZjY2dWM2OXA3amJtZ003R1dFYi85UHpDWGl0N0lt?=
 =?utf-8?B?a3NZNjJsSkU0UER1UU9XODBBMlJWamdiL3J1UGFQRW1Zc29BNElPdkxhUC9N?=
 =?utf-8?B?c1JTM0JLQXlYaW9veW1kV1YrSGl6VFZaNnlPMWdqU2tXYXlpd2ZONHZoY3FP?=
 =?utf-8?Q?Bspaq+hujMQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFppY0YrWWpCRU43dEtuWW1nQW5GMm14VHJxUkxjVlFUbGVONTY1ZjhyaDFy?=
 =?utf-8?B?cnJEZUtCcmF1UXJjYW5nNTlLZWlFdHVybDllMHJ3aWhaNTFxS25YajNVQ1Uy?=
 =?utf-8?B?SDZEcmJ0emRUWDlrSXNxcjAxc2JVbDZ3dEZjbHIrODBwYjdocTROc3NIWEFR?=
 =?utf-8?B?bjl1bGlkUEFSRklkWnRQR21tck5zOXBqMUlNUjRqZktPQzVyT0ZvUkxIZzl3?=
 =?utf-8?B?Z0FCbUJqemJrOGtyTGhTaVQ4NkFMQllWazBBWEtSb3I2aUZpZGFCRXpZdGxv?=
 =?utf-8?B?Rm5RdktlMWVCVXAyY1BCOWt3dkE3T2pncS80MVBGZ2k1RUxRb0hZNkpxam9x?=
 =?utf-8?B?bm4rWUw2YjlZUWUzMWZtUkJyT3RYRlgvbzNRKzhpZzA5WEdMY1lhZmpXcVgv?=
 =?utf-8?B?YUtKWUtqRVRES2NlMmZVV29XSURkY1NNd1UvcWJ0N1ZiRSttV2hZa0hQakV2?=
 =?utf-8?B?eHFENTV2WVlIZ2czdmVDTEZxdENyQkxJdkdzRG52YVZsbXlZSHB2Z0k4TWQ4?=
 =?utf-8?B?dFh5TUlWQnBYc1pDZk9zcmxuT3pUQVd2MU9xb1JUQWNZck9jQ1VnSlZBMGpp?=
 =?utf-8?B?d2F5cVd1UnQ5eEJxZGp1WXNqVEcxeXdRc2dkMU92ZmJ4NzNTT1RMTHVSMW1p?=
 =?utf-8?B?SjBCK1loUk1Uc1l0T2NOMFhnUEFNei85MWIwNjNmN2ZsRkJOU1dlREpmZytM?=
 =?utf-8?B?Skp5aE84anVHS1U4Qmh6Y1dOTW1KVmkzaHkzeEp2dCtGMG5hcWdGOXR2bysy?=
 =?utf-8?B?blZsTjJyV2h6dzk3ZjBHdjgwN0paNndHY3NYd3RZQmZyWDZKaDlJVEVhcVZv?=
 =?utf-8?B?VWtXaDRUSHo3VElwakJVaVN6VjNSVkxFS0lMajNhbmZrTTNGVFJ1VHcyM3p0?=
 =?utf-8?B?NElHUk9oR3VwcStaeTFVNkhsZEMzTTdtRjkreGN0bXFmWnI4UlkwRitpTy9h?=
 =?utf-8?B?NWpJb3l6blNob2cycVRVcDlIM2hGdlo5YlNnQytFNEk4RlJnbFVWTnVDTTF1?=
 =?utf-8?B?a1V2SUFZTkN2clR3a25vSzZidzRFeEd4Nk80dEFGZWRDOGVUZHFlekRaM25s?=
 =?utf-8?B?RzNOWUhNbWpEeUhlcmFmeEtIR1d5TDZLdXVhMytCeWxlMTZEZ1B5ZTZyUVpJ?=
 =?utf-8?B?VHg1c0FPNHozSnBwbkQzOEo0SzcyTDEzN2dieENJNVdpbHQzVVRrakk1angy?=
 =?utf-8?B?cDFQaG1ucWJiRVcvTEx5LzRhMkVGQkhralNNSk1Fa0lNU2RsK2d4b0VjSVkx?=
 =?utf-8?B?eVU5NzVTUDl4aVh5dHAzUnpwL01WZEJZSVdlQ1M3V24weEJvWWR3RG1CVVlm?=
 =?utf-8?B?bytiNWtIT0xPTDJNdkoyV1U4UEh2RjhkZHBGcitlYk5sOTRGU0hRRTN4dWlh?=
 =?utf-8?B?ZndkNXVsek5JV2N1Q0VlMUFVMU5DSmhJeHRmTHEvY3JUQ1pVNFJVTWJodjBR?=
 =?utf-8?B?NUp1Y2krUXVxSVpFbmU1ME50bGVpVDgzeU8xYlR5Q3NoQjl0bjNCL1FRbW5s?=
 =?utf-8?B?Y0lRNkR6Vjl4QTBzME5GYTdyelBiQTZvUnlKcklyMjlrQjkvVmtESjc5T0tZ?=
 =?utf-8?B?OVM3MS8xUlBkbUtobTNoK3M1c2wzSnhVdHJxQWpLRktzc08ybUZ5ZDZOUWRZ?=
 =?utf-8?B?MVMzYUljSzFUM0NwQU1qeEtqSk9SNk1XSWs0Yzk5K2lZMkNYYTdOWTZTcURh?=
 =?utf-8?B?SGVwb05ZaXlxNmp1K2duaTdSU2pOaUE1Vi96TTUzQTNCWkVUbU9Hd25wUWFL?=
 =?utf-8?B?c1phS1ZUMUVuUUJlU2RtdDkzd0RPRjlicFdnZ1JCVUc1Qm5yVTZzS2FRSnVi?=
 =?utf-8?B?WGwyb2k0dXFvd3RJQmxSS3J0b2Jaa1ZKSTVWdzR1Z0R3ZmJGMlM2ZkhUeFZm?=
 =?utf-8?B?WEJmcS8rcUF5MDNNOW5QejN5TzRhc1pzS1dNd1U0QzJsY1dNR28xaHJEWXAy?=
 =?utf-8?B?S0VBSXFVUWZkSGIvMWFkdGNNWVlDWExWZ2xQSjJWN1VTTVdVaCszRU1HY3dx?=
 =?utf-8?B?c0IxUm1wM0RVRXNKOWxwVDgrOXJUdXpLRG1Say8wVVF3N0E3TVRnSTdBREZE?=
 =?utf-8?B?RVNBaXBFMkNqKzlyeXh0T3dpbStmMmQvRDRtMXNGb2xLMWlNY1J2T2RlUjlO?=
 =?utf-8?Q?fKKNVqUNF9tWIdDsdknqoO8gz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b50c76-d0c5-49a5-fe6a-08dd1438dd6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 07:54:22.2017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /et0C9B/42636i41HhgGFL5Tf0W51NnGL0GruCaIKAuIjDCLek0xbNj/LdV+tHD+UEG/dMphOFwUG4Q+kc3gBzGdVEIV/8wT0WZ+0QY8iQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5085
Received-SPF: pass client-ip=2a01:111:f403:2011::731;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgUGhpbGlwcGUsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzZdIGh3OnNkaGNpOiBJ
bnRyb2R1Y2UgYSBuZXcgImNhcGFyZWciIGNsYXNzIG1lbWJlcg0KPiB0byBzZXQgdGhlIGRpZmZl
cmVudCBDYXBhYmlsaXR5IFJlZ2lzdGVycy4NCj4gDQo+IE9uIDQvMTIvMjQgMDQ6MTQsIEphbWlu
IExpbiB3cm90ZToNCj4gPiBIaSBCZXJuaGFyZCwNCj4gPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDMvNl0gaHc6c2RoY2k6IEludHJvZHVjZSBhIG5ldyAiY2FwYXJlZyIgY2xhc3MNCj4g
Pj4gbWVtYmVyIHRvIHNldCB0aGUgZGlmZmVyZW50IENhcGFiaWxpdHkgUmVnaXN0ZXJzLg0KPiA+
DQo+ID4+IEFtIDMuIERlemVtYmVyIDIwMjQgMDI6MTQ6NTcgVVRDIHNjaHJpZWIgSmFtaW4gTGlu
IHZpYQ0KPiA+PiA8cWVtdS1kZXZlbEBub25nbnUub3JnPjoNCj4gPj4+IEN1cnJlbnRseSwgaXQg
c2V0IHRoZSBoYXJkY29kZSB2YWx1ZSBvZiBjYXBhYmlsaXR5IHJlZ2lzdGVycyB0byBhbGwNCj4g
Pj4+IEFTUEVFRCBTT0NzIEhvd2V2ZXIsIHRoZSB2YWx1ZSBvZiBjYXBhYmlsaXR5IHJlZ2lzdGVy
cyBzaG91bGQgYmUNCj4gPj4+IGRpZmZlcmVudCBmb3IgYWxsIEFTUEVFRCBTT0NzLiBGb3IgZXhh
bXBsZTogdGhlIGJpdCAyOCBvZiB0aGUNCj4gPj4+IENhcGFiaWxpdHkgUmVnaXN0ZXIgMSBzaG91
bGQgYmUgMSBmb3IgNjQtYml0cyBTeXN0ZW0gQnVzIHN1cHBvcnQgZm9yDQo+IEFTVDI3MDAuDQo+
ID4+Pg0KPiA+Pj4gSW50cm9kdWNlIGEgbmV3ICJjYXBhcmVnIiBjbGFzcyBtZW1iZXIgd2hvc2Ug
ZGF0YSB0eXBlIGlzIHVpbnRfNjQgdG8NCj4gPj4+IHNldCB0aGUgZGlmZmVyZW50IENhcGFiaWxp
dHkgUmVnaXN0ZXJzIHRvIGFsbCBBU1BFRUQgU09Dcy4NCj4gPj4+DQo+ID4+PiBUaGUgdmFsdWUg
b2YgQ2FwYWJpbGl0eSBSZWdpc3RlciBpcyAiMHgwMDAwMDAwMDAxZTgwMDgwIiBmb3IgQVNUMjQw
MA0KPiA+Pj4gYW5kIEFTVDI1MDAuIFRoZSB2YWx1ZSBvZiBDYXBhYmlsaXR5IFJlZ2lzdGVyIGlz
DQo+ID4+PiAiMHgwMDAwMDAwNzAxZjgwMDgwIiBmb3INCj4gPj4gQVNUMjYwMC4NCj4gPj4+DQo+
ID4+PiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gPj4+IC0tLQ0KPiA+Pj4gaHcvYXJtL2FzcGVlZF9hc3QyNDAwLmMgICAgICB8ICAzICstDQo+
ID4+PiBody9hcm0vYXNwZWVkX2FzdDI2MDAuYyAgICAgIHwgIDcgKystLQ0KPiA+Pj4gaHcvc2Qv
YXNwZWVkX3NkaGNpLmMgICAgICAgICB8IDcyDQo+ID4+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLQ0KPiA+Pj4gaW5jbHVkZS9ody9zZC9hc3BlZWRfc2RoY2kuaCB8IDEyICsr
KysrLQ0KPiA+Pj4gNCBmaWxlcyBjaGFuZ2VkLCA3OCBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlv
bnMoLSkNCj4gDQo+IA0KPiA+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvc2QvYXNwZWVkX3Nk
aGNpLmgNCj4gPj4+IGIvaW5jbHVkZS9ody9zZC9hc3BlZWRfc2RoY2kuaCBpbmRleCAwNTdiYzVm
M2QxLi44MDgzNzk3ZTI1IDEwMDY0NA0KPiA+Pj4gLS0tIGEvaW5jbHVkZS9ody9zZC9hc3BlZWRf
c2RoY2kuaA0KPiA+Pj4gKysrIGIvaW5jbHVkZS9ody9zZC9hc3BlZWRfc2RoY2kuaA0KPiA+Pj4g
QEAgLTEzLDkgKzEzLDExIEBADQo+ID4+PiAjaW5jbHVkZSAicW9tL29iamVjdC5oIg0KPiA+Pj4N
Cj4gPj4+ICNkZWZpbmUgVFlQRV9BU1BFRURfU0RIQ0kgImFzcGVlZC5zZGhjaSINCj4gPj4+IC1P
QkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShBc3BlZWRTREhDSVN0YXRlLCBBU1BFRURfU0RIQ0kp
DQo+ID4+PiArI2RlZmluZSBUWVBFX0FTUEVFRF8yNDAwX1NESENJIFRZUEVfQVNQRUVEX1NESENJ
ICItYXN0MjQwMCINCj4gPj4+ICsjZGVmaW5lIFRZUEVfQVNQRUVEXzI1MDBfU0RIQ0kgVFlQRV9B
U1BFRURfU0RIQ0kgIi1hc3QyNTAwIg0KPiA+Pj4gKyNkZWZpbmUgVFlQRV9BU1BFRURfMjYwMF9T
REhDSSBUWVBFX0FTUEVFRF9TREhDSSAiLWFzdDI2MDAiDQo+ID4+PiArT0JKRUNUX0RFQ0xBUkVf
VFlQRShBc3BlZWRTREhDSVN0YXRlLCBBc3BlZWRTREhDSUNsYXNzLA0KPiA+PiBBU1BFRURfU0RI
Q0kpDQo+ID4+Pg0KPiA+Pj4gLSNkZWZpbmUgQVNQRUVEX1NESENJX0NBUEFCSUxJVElFUyAweDAx
RTgwMDgwDQo+ID4+PiAjZGVmaW5lIEFTUEVFRF9TREhDSV9OVU1fU0xPVFMgICAgMg0KPiA+Pj4g
I2RlZmluZSBBU1BFRURfU0RIQ0lfTlVNX1JFR1MgICAgIChBU1BFRURfU0RIQ0lfUkVHX1NJWkUg
Lw0KPiA+PiBzaXplb2YodWludDMyX3QpKQ0KPiA+Pj4gI2RlZmluZSBBU1BFRURfU0RIQ0lfUkVH
X1NJWkUgICAgIDB4MTAwDQo+ID4+PiBAQCAtMzIsNCArMzQsMTAgQEAgc3RydWN0IEFzcGVlZFNE
SENJU3RhdGUgew0KPiA+Pj4gICAgICB1aW50MzJfdCByZWdzW0FTUEVFRF9TREhDSV9OVU1fUkVH
U107ICB9Ow0KPiA+Pj4NCj4gPj4+ICtzdHJ1Y3QgQXNwZWVkU0RIQ0lDbGFzcyB7DQo+ID4+PiAr
ICAgIFN5c0J1c0RldmljZUNsYXNzIHBhcmVudF9jbGFzczsNCj4gPj4+ICsNCj4gPj4+ICsgICAg
dWludDY0X3QgY2FwYXJlZzsNCj4gPj4+ICt9Ow0KPiA+Pg0KPiA+PiBUaGUgc3RydWN0IHNlZW1z
IG5vdCBBU1Qtc3BlY2lmaWMgYW5kIGNvdWxkIGJlIHR1cm5lZCBpbnRvIGEgYmFzZQ0KPiA+PiBj
bGFzcyBmb3IgYWxsIFNESENJIGRldmljZSBtb2RlbHMsIG5vPyBUaGF0IHdheSBvbmUgY291bGQg
YWxzbyBhZGQNCj4gPj4gZnVydGhlciBkZXZpY2Utc3BlY2lmaWMgY29uc3RhbnRzIG90aGVyIHRo
YW4gY2FwYXJlZy4NCj4gPj4NCj4gPg0KPiA+IFRoYW5rcyBmb3Igc3VnZ2VzdGlvbiBhbmQgcmV2
aWV3Lg0KPiA+DQo+ID4gVGhlIGNvbW1vbiBzZGhjaSBtb2RlbChzZGhjaS1pbnRlcm5hbC5oKSBo
YWQgdGhpcyAiY2FwYXJlZyIgcHJvcGVydHkNCj4gPiB0byBtYWtlIHNwZWNpZmljIFNESENJIG1v
ZGVsIG9mIEFTUEVFRCBTT0NzIHRvIHNldCB0aGUgZGlmZmVyZW50IHZhbHVlDQo+ID4gQ2FwYWJp
bGl0eSBSZWdpc3RlciBzdWNoIGFzIGFzcGVlZF9zZGhjaS5jDQo+ID4gaHR0cHM6Ly9naXRodWIu
Y29tL3FlbXUvcWVtdS9ibG9iL21hc3Rlci9ody9zZC9zZGhjaS1pbnRlcm5hbC5oI0wzMTgNCj4g
DQo+IERFRklORV9TREhDSV9DT01NT05fUFJPUEVSVElFUygpIG9ubHkgc2V0cyBkZWZhdWx0IHZh
bHVlcywgeW91IGNhbg0KPiBvdmVyd3JpdGUgdGhlbSBpbiB5b3VyIGNsYXNzX2luaXQoKS4NCj4g
DQpUaGFua3MgZm9yIHN1Z2dlc3Rpb24uDQpXaWxsIHVwZGF0ZSBpdC4NCg0KSmFtaW4NCg0KPiA+
DQo+ID4gSW4gdGhlIHByZXZpb3VzIGRlc2lnbiBvZiBhc3BlZWRfc2RoY2kuYywgaXQgc2V0IHRo
ZSBoYXJkY29kZSB2YWx1ZSBvZg0KPiBDYXBhYmlsaXR5IFJlZ2lzdGVycyBmb3IgYWxsIEFTUEVF
RCBTT0NzLg0KPiA+IFRoaXMgcGF0Y2ggc2V0IHRoZSBkaWZmZXJlbnQgdmFsdWUgb2YgU0RIQ0kg
Q2FwYWJpbGl0eSBmb3IgQVNUMjQwMCwgQVNUMjUwMCwNCj4gQVNUMjYwMCBhbmQgQVNUMjcwMC4N
Cj4gPiBUaGFua3MtSmFtaW4NCj4gPj4gQmVzdCByZWdhcmRzLA0KPiA+PiBCZXJuaGFyZA0KPiA+
Pg0KPiA+Pj4gKw0KPiA+Pj4gI2VuZGlmIC8qIEFTUEVFRF9TREhDSV9IICovDQoNCg==

