Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36752C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 02:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBm3D-0002Xh-Dp; Sun, 04 May 2025 22:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uBm3A-0002X6-F1; Sun, 04 May 2025 22:59:24 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uBm38-0001Nj-OH; Sun, 04 May 2025 22:59:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2V3mO+oqj0vQdComhSLJfUOwgbAscFbY9rMWzBu8x5gn6gBqSzyWGHeNrk3jjJhRd/jZjyQBMKPdzuO+ghY5iQTkE+UxbfaTLHgZZfd8WVsHNtO/sa8wmSOdgFd+0+LtctrXjWDZy1ujEiYq0P2yBK7Bq04N1Y9Rst2Q//OBWwDUJDO1YdPMMXwdYy5FESeUOSzxgbSga+HvVnXQ0yWpcdmN6DVmQbf9O5rEh2fdkfelyDljSuo5viL6Slc+zb7V+gHkN62SktFAR2q8QWt+64MwJDqwQKDqd166iXPDEIuCEGz8JDRWYcNiCeyXya7xZxE6BjAIhmzbOw6oHHkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45o4b8z5G847oDL/OTIFBjBYZ9WExgaXRg2NS+SgbQM=;
 b=N2UqmYJW6Miovkp/bryxCjKz24m+TWVX6y0vgGxvWcfEcUR9pn4R9V8sSOHPHYKQJSHnMJVheP1Sj+TSPqT0Q6XZRfFX5qyapw64bw0cO5tbPbGF4zazSZzpvOuhFSCpMlQu1l3jvxSkTmHeFqTE1dNPcQmNMhD8TNJqvdVnYRcC/h46LFrbujEnzJVGlwAeBDzlAc7joFBGO3N0Jo4tj7gcLGqCopERxL+gFl1sdwzkZV4LLTmm25S+T/lC1hBX6B7USPUtpvaHhd8Fb7uDjS3EN0MaKZ6xU9Zvdn7N7fZ/jb2kQZp7zps3oSlC6PCeajl0Ke8rJ53enZLjEK/PeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45o4b8z5G847oDL/OTIFBjBYZ9WExgaXRg2NS+SgbQM=;
 b=Xu0wwkAVDQlpuL0aSG5vqTBbKklWuXmrr3MKlopn/sSz4gkT3yW3pk4qJE8Y938PPtau5n9n7g1qAWnrmANCoIyzAKvMaw6IC2DTFVAaaWDIvHdrgXYFdW30L5wGis3SJUerHIhqJb468g5WGfjlCn47nuLRCfTT99FEwFixZvY=
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB7789.apcprd03.prod.outlook.com (2603:1096:400:452::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 02:59:17 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 02:59:17 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Hao Wu <wuhaotsh@google.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>
CC: Tim Lee <timlee660101@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "CHLI30@nuvoton.com" <CHLI30@nuvoton.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] hw/arm: Attach PSPI module to NPCM8XX SoC
Thread-Topic: [PATCH] hw/arm: Attach PSPI module to NPCM8XX SoC
Thread-Index: AQHbrOH/6pMWf/zdOk6a2zx4Daw6XbOi+mQAgA1BfoCAEz2B4A==
Date: Mon, 5 May 2025 02:59:17 +0000
Message-ID: <TYZPR03MB68965433382889EE2778C7CEDB8E2@TYZPR03MB6896.apcprd03.prod.outlook.com>
References: <20250414020629.1867106-1-timlee660101@gmail.com>
 <834ad4b1-9dac-4559-b4da-bec6e6d4a945@linaro.org>
 <CAGcCb107LRZR4=cso9VzN_54mpc2GJGsuM3q9k+1Z18X_rf_kA@mail.gmail.com>
In-Reply-To: <CAGcCb107LRZR4=cso9VzN_54mpc2GJGsuM3q9k+1Z18X_rf_kA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6896:EE_|TYZPR03MB7789:EE_
x-ms-office365-filtering-correlation-id: 2f90d3fa-7cd7-4404-b80b-08dd8b80d335
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aGZEYzVkSGJVVWFHQjJJMUN5ODZtc1Q1QmhVVEpycDM1bUxQY1FUU215c3Zo?=
 =?utf-8?B?bCtsSThZRit1R2d2d1pnbkF1ci9rOCs5QUNneWk5ZDJDZDQybEI5M2t1eFZa?=
 =?utf-8?B?azZ6ejBROE40bFk0UE9BV0RtWHRPQWF5UEY2WmxKTnh6Q3hEeHFxbDhZTW1E?=
 =?utf-8?B?N1AxejJ1eVlNTC9WVmxZbXdWdEh6eVhNazZ0NUlFV1h5RVVoRThBc2tvZ3JS?=
 =?utf-8?B?RkdEblVEbGYvZzBUR09sd3crejNWbHNYQ3Y2RnpFd2RtZnhWcEtKNkE4SkFK?=
 =?utf-8?B?Y2NSVE5wcVpISnBWZnZ2Q2E0QkExNVV1dVlCbVNiRVMyemhLRHNxWURiY2ZN?=
 =?utf-8?B?Y2tTQm9jODZMVFRHYXAvNlpQWUN2UmxXNitJRGErV3ozMUd4VGFNQ3BFaEVF?=
 =?utf-8?B?OVUwdEZaWUZ2dVgvN2h3R24wejUyMDZpT3R0QU5pMFhUV0N0UWdQSVVFcFdX?=
 =?utf-8?B?OVM2M2tFekFrMloxQXJaWDlMY0JBajhXNndSR1g5cDQ0cFlzV1FzUU96cjc4?=
 =?utf-8?B?MEtmVTArMUlRSG0yYlBWQWp2MHN1Nk1JaWVHSENTaHBHN1BaSnJMRUcwTUF6?=
 =?utf-8?B?SVJkM1FhUFM3Vnl4YThIUzRVYW9wdktIMmJib3VORVAyUGRXd3V3MFEvOVht?=
 =?utf-8?B?TGNvVk4yaGJaSHhpaEFhRnpwU0dNWUNQaUYrNkFnQ0w5QUpPeVY1ek5aQk1L?=
 =?utf-8?B?WGhOc0pCRCtPR1UrUjZBeHpUUS9zUG0wRWxEZjdHNFIzOWpNRDI1bUhoQ21W?=
 =?utf-8?B?ZUZ0UTcwRStuVWlUT2s3WU5CWFZvMExDSVM5b2dDeUhBU20ydFdQaERRZXZj?=
 =?utf-8?B?bDVDaEJ5YjNrMFc4WE9YbGxGQVdQME5hQmpZdEgrbUpqakdFc1NEOUE2WUZN?=
 =?utf-8?B?K1NKbGcrNjdmRGJoeDUvaW5JWDhpcjNzWTJjZGEwMkpFT1hkcldxYUxQQ1Z3?=
 =?utf-8?B?d1o0RGdRTWpxWHdXOEcxeTFhU3YvcFd1S0IzY1J4OXgzSm5OUFB6amMwZFZa?=
 =?utf-8?B?TXhvT00rUmttd1JqTHg4dTdsVUxkUTNDY3JpaU5tWUQ4ZUpOMjlQcFVuZzNz?=
 =?utf-8?B?RUQ5THNJSlRVTWVIRnZkUTZUN2pSY01XY3UrUS8zWS9rbjR4a3FRSklkb0pt?=
 =?utf-8?B?UGlGQ3FjVS91L0pRWk8vSGo3VjBtcnhCNXJtQTFURUROUjArT1llcVd1YVl4?=
 =?utf-8?B?SlNCWDhzRHlTbUo2Mm9QZ0RiRE4wYUxlWlFyc2lVakQ3VCtheFo0b0FaWi9m?=
 =?utf-8?B?WHcwNzVha0lURFlpRytzTUUwc1RjUGdNTVk1RWJpRDNldXlwcFF3YVhUOU5t?=
 =?utf-8?B?VlFyR3NRZXNZeENPbXh0ZXd0d2V1b1hEbXhUbEVsTGg0akFVb0NvckFYWUU0?=
 =?utf-8?B?dTZhVndhNEtrbGhqY1ZpSWxlWmY4VFo5Z25yOENzTUFMcm5MQk5LaHVEYWt5?=
 =?utf-8?B?dTUzM1JDK1gxMHNLdmhvVVd2aUUrMHhlVXVWWXFCbFhYVy9SMkVNYjFkdmVF?=
 =?utf-8?B?TUJXRmoyaWxLd2RTOGszMFY1cE44Z1pFNkgvWFZTcnJLbFF5VEQ2RGErL2I0?=
 =?utf-8?B?aFczU252RStLQ2dCUVV2N1JyS2gza0JTY2dIdlJhd2o2RlQ5akxxQzVleklZ?=
 =?utf-8?B?eXFlY2hSK0VsdzZRUERMUlhEVFo3Ni91b0ZPd0dsUWlZaGFRRHZ6TzNaRDBS?=
 =?utf-8?B?WGREZy84SDNqMmg1amgydndBcDJodEJ2elp5K1I5TmpUdmFKUm1ST0hzVmdz?=
 =?utf-8?B?QWtzczE1bWczTlJqd2lpU3Y2OC9veHBPTlpYTmZOU3l0SmxiL3MyZVpteE1N?=
 =?utf-8?B?cENKbktHRWZSYkVNMjhWUmNDcGUzOTJhd29iNmFncEVFWlpqaEc0UGVHeGpW?=
 =?utf-8?B?aVI0ZXhaNUN2cjJXL01oM21HUFJnMVlXc1hnWE9WSUt5TlFmVVQ1SUpGcm83?=
 =?utf-8?B?RWpRNWlpQk8xbUJDYzRTZUw4ZEFYdXVYYVI4Z1VkbDFRVGlzenhocm5QVGcv?=
 =?utf-8?Q?eM/dUmISujv7652zRWalicaj6JKWok=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6896.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnYzYkd0WFJBQWJwb3ZzZDdUWjFSR09BejQ4cVhaZlk4WHJtdVBGRzJGWGNL?=
 =?utf-8?B?OW5FbW1ZRTFlb2x1Y0xzU0VPU0lHOTl5Wjlsdk1DVWZmK1hkZVRoYXliOWhk?=
 =?utf-8?B?SFc3VW13ZXVDREJXL2FTWUl6N2srU3JHdVhJSkNrRG0vWmxWQmJDeGFPSEtq?=
 =?utf-8?B?UTFGSE9HZzJDeit2UVFoeUZoZ3NGMnVhQUtDZ1o5VDJDcHdRUjhWQXljdmxn?=
 =?utf-8?B?NG00UHVGNXdLckdwSHF4MDB2WE04a2xCN2x0b0VueEV6YUxob3VCaURkdTVv?=
 =?utf-8?B?MUh3UUU0dDE4RzRmZ3A2UzBQWXNxam9TMTl1aU5tSUZTQ1BJSFJjaFZDQmYw?=
 =?utf-8?B?ekZsTnJ6dVZkMlp2VjVmRkpsQzN1eGw4d2llM1ozTDBndzlNbjVtaGpFOWpj?=
 =?utf-8?B?cUsyQzI5K1ZzVGZLeGxkb2pjZmNORnViZGZEK0pWVzR6TW5IbTBkSFZSTE0v?=
 =?utf-8?B?Y1llRnR5VXZhWklrTzBueFRIUXVVc01xUmZWeE9yVHhGSlJpUTdaVEFQQTZm?=
 =?utf-8?B?ZDhHaVUrNUxBNzc0SVlxMnpobEMwblpJUHhFUGFaNEZjM2puKzFlbU9GSEs1?=
 =?utf-8?B?RHJVMEMzNVFRYzZMNEJ2c0NRKzlTa1ZBSFpwR3RXTHB1d3c5N3d5M3RCa2p5?=
 =?utf-8?B?cTZEQzRaV21yMGRRS3Jva1Bkem9BRER6N3c1Ry9MZU1NSWpqTGxJTk82cUpW?=
 =?utf-8?B?QUdmUGpvUDlMcFVZckVWRmJKNC82by92VUN2c2dxK3A3SGROdTZmN3YyYmNk?=
 =?utf-8?B?akQxVk1mWVcvU0JpNjRwSHVNL3hTMWh3V0pvaEorME1ESk9wODBLTGI4UVgv?=
 =?utf-8?B?di9SRjJ1dVY1MXZ3cjVQcDVTc0xsN3dybTl0QlVpL1dETnU0ZWJvT08rMFNm?=
 =?utf-8?B?aCtwSW9jUEh1cExiaG9iTzUwVHZhQU1zY0VHRGpRRzU1VytQZmJHWFA4TXRj?=
 =?utf-8?B?ZWFmOFZTODNLR0NFc09DeE1DUkFyYVFVaE50OC8xMDdmK2VsTnNYbnd4dWps?=
 =?utf-8?B?Sm13RzFpajNYMkcwUFBWb3J1US9rZ3dxVEFZVktUY3AvcEl6WTJ6clkvOWV4?=
 =?utf-8?B?VmpZNmVQdkorY0xPVE1TSnUvMHRucmZhMStsRFBwL2wxK3BDOEdSV2dTZHFM?=
 =?utf-8?B?eDJYY1Y3bFpidU5UNVdSTmVnbjNEZDZiK0VvTFBmenVORER4NlptQ3ZTVjNS?=
 =?utf-8?B?MVYvM2RGUVp0cTQyM0lYSU1zTGxkTmpNNDRZZ0toSUkvRndLTjZaWDVTR0w4?=
 =?utf-8?B?OUs0TzI1Nmt4bTVieUp3cmMrZ2x6TjE1TUFTMEtyczBRVVNZc3J0cGxkYWVw?=
 =?utf-8?B?MmVyWSt6MVVTR010NFhMN0tyOVlsWHJWQzVDU0t5T2MvdzNoYU5oWDl2Nk1T?=
 =?utf-8?B?TWd4Sk5UaHJCcUpwTVpFZFlHWjJuRWNLMjdiU2RCdWtSQWFjMFlaSW15OUR2?=
 =?utf-8?B?MzcyOGN0SXg2d21lQmhJWC8zeSs0RmZpMW1JMDl2M1NWWmo0bTU1T1lzRmJT?=
 =?utf-8?B?UVRYcmlZLytxK3hXOGczYjFBbkZXUTlUcDE1RmFleUJkZW43QkJZVTJ6UTdm?=
 =?utf-8?B?dUVxMWxwV2RNSGU5Q0t4alpxUDRJQ2V5UHV0LzErYjFvSXBQdTc0K1daLzlI?=
 =?utf-8?B?bjZGem50cHVnMVFydlFtZ1Z2UVRvTDNwU3hLTjJYZTFWeHRhR0ZlenpxbzAx?=
 =?utf-8?B?VWhDbzJhK0dtdjdzSzIwdjlsM1Y3K2REZmtjTnVMMEMvSzQwdEpOSUlBMi9T?=
 =?utf-8?B?RVI2U3hvNnQzYS9rdkN2dUYxUWJENEFkZVdrU001NUZiRHRJWXRaM1BCY01T?=
 =?utf-8?B?LzNhV2R5S2YwWTNBZmVXdUhRVE1obzZBV3ZjQWJJL1NoQklNVVB4V0ZlT3Q4?=
 =?utf-8?B?UDVkSElzZGJzbFZua2U5N3dXeCtRZy9yUkxPTGU2MEovWW1uSmg2bTlLRjFD?=
 =?utf-8?B?QUlUdjNKM0RscGp6VU9mWXFQUTluQkpQU1lUcXJ4SXBDN3ZIa3Q5akNOQm1h?=
 =?utf-8?B?NjJzZktwdzI1eStTUlZoZ1RTL29RSThTTTY2NEVORkNyK254cDJMZ20xRHdi?=
 =?utf-8?B?ek10OVlLWW9MU0FXSDhTWjk0NHowUFIyajdWemhBek9QNFpXekFpWGlUR3du?=
 =?utf-8?Q?isg5oTgrLsDqOSq9FgEIn4KU7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f90d3fa-7cd7-4404-b80b-08dd8b80d335
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 02:59:17.1872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SLG7iFflcaBn2f9XzVNjb+vdppSX9jhPeBydEFFlI38mNQbRI5CGPzDwJo9856Y9YR1BnvHEKR39keWd1E76DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7789
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=KFTING@nuvoton.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

DQoNCkZyb206IEhhbyBXdSA8d3VoYW90c2hAZ29vZ2xlLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwg
QXByaWwgMjMsIDIwMjUgNTowOSBBTQ0KVG86IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGls
bWRAbGluYXJvLm9yZz4NCkNjOiBUaW0gTGVlIDx0aW1sZWU2NjAxMDFAZ21haWwuY29tPjsgcGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBDUzIwIEtGVGluZyA8S0ZUSU5HQG51dm90b24uY29tPjsg
Q1MyMCBDSExpMzAgPENITEkzMEBudXZvdG9uLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gaHcvYXJtOiBBdHRhY2gg
UFNQSSBtb2R1bGUgdG8gTlBDTThYWCBTb0MNCg0KT24gTW9uLCBBcHIgMTQsIDIwMjUgYXQgMzo0
M+KAr0FNIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxtYWlsdG86cGhpbG1kQGxpbmFyby5vcmc+
IHdyb3RlOg0KT24gMTQvNC8yNSAwNDowNiwgVGltIExlZSB3cm90ZToNCj4gTnV2b3RvbidzIFBT
UEkgaXMgYSBnZW5lcmFsIHB1cnBvc2UgU1BJIG1vZHVsZSB3aGljaCBlbmFibGVzDQo+IGNvbm5l
Y3Rpb25zIHRvIFNQSS1iYXNlZCBwZXJpcGhlcmFsIGRldmljZXMuIEF0dGFjaCBpdCB0byB0aGUg
TlBDTThYWC4NCj4NCj4gVGVzdGVkOg0KPiBOUENNOFhYIFBTUEkgZHJpdmVyIHByb2JlZCBzdWNj
ZXNzZnVsbHkgZnJvbSBkbWVzZyBsb2cuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFRpbSBMZWUgPG1h
aWx0bzp0aW1sZWU2NjAxMDFAZ21haWwuY29tPg0KPiAtLS0NCj4gICBody9hcm0vbnBjbTh4eC5j
ICAgICAgICAgfCAxMSArKysrKysrKysrLQ0KPiAgIGluY2x1ZGUvaHcvYXJtL25wY204eHguaCB8
ICAyICsrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQoNClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8bWFpbHRvOnBoaWxt
ZEBsaW5hcm8ub3JnPg0KUmV2aWV3ZWQtYnk6IEhhbyBXdSA8IG1haWx0bzp3dWhhb3RzaEBnb29n
bGUuY29tPg0KUmV2aWV3ZWQtYnk6IFR5cm9uZSBUaW5nIDxrZnRpbmdAbnV2b3Rvbi5jb20+DQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCiBUaGUgcHJpdmlsZWdlZCBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gY29udGFp
bmVkIGluIHRoaXMgZW1haWwgaXMgaW50ZW5kZWQgZm9yIHVzZSBvbmx5IGJ5IHRoZSBhZGRyZXNz
ZWVzIGFzIGluZGljYXRlZCBieSB0aGUgb3JpZ2luYWwgc2VuZGVyIG9mIHRoaXMgZW1haWwuIElm
IHlvdSBhcmUgbm90IHRoZSBhZGRyZXNzZWUgaW5kaWNhdGVkIGluIHRoaXMgZW1haWwgb3IgYXJl
IG5vdCByZXNwb25zaWJsZSBmb3IgZGVsaXZlcnkgb2YgdGhlIGVtYWlsIHRvIHN1Y2ggYSBwZXJz
b24sIHBsZWFzZSBraW5kbHkgcmVwbHkgdG8gdGhlIHNlbmRlciBpbmRpY2F0aW5nIHRoaXMgZmFj
dCBhbmQgZGVsZXRlIGFsbCBjb3BpZXMgb2YgaXQgZnJvbSB5b3VyIGNvbXB1dGVyIGFuZCBuZXR3
b3JrIHNlcnZlciBpbW1lZGlhdGVseS4gWW91ciBjb29wZXJhdGlvbiBpcyBoaWdobHkgYXBwcmVj
aWF0ZWQuIEl0IGlzIGFkdmlzZWQgdGhhdCBhbnkgdW5hdXRob3JpemVkIHVzZSBvZiBjb25maWRl
bnRpYWwgaW5mb3JtYXRpb24gb2YgTnV2b3RvbiBpcyBzdHJpY3RseSBwcm9oaWJpdGVkOyBhbmQg
YW55IGluZm9ybWF0aW9uIGluIHRoaXMgZW1haWwgaXJyZWxldmFudCB0byB0aGUgb2ZmaWNpYWwg
YnVzaW5lc3Mgb2YgTnV2b3RvbiBzaGFsbCBiZSBkZWVtZWQgYXMgbmVpdGhlciBnaXZlbiBub3Ig
ZW5kb3JzZWQgYnkgTnV2b3Rvbi4NCg==

