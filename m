Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57092E7317E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 01:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5e5-0003RL-4K; Mon, 02 Feb 2026 20:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5dn-0003M7-MA; Mon, 02 Feb 2026 20:55:43 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5dl-0007tD-L9; Mon, 02 Feb 2026 20:55:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UM45mw71jqKAgT7H/kxahK5+jLF/E0U+e/SyLKw4ip7PGFTHk3sbSQfUrKujJrJChlLOzNv3Sno5ReS1j+CP0HrtChiAsCcHWjulW32lZTWc8alfMGsLbeaMBrZ3W6Zf2sOK/u/ESBROV8KmkkXL2U5BzJUDau7NaB1+qdoFWco0D5t94v8kh4FLbI/EhALclqhgiQQHBK5/8V7ZRk8eJfu2kqsb8zqGlo/ZOupUZ0l9zI9Ryq5RdDHf1J/XnU91GljNth73vEihP/o8qgwAmorb9ZF+NIXuo5r63G+3PuZtye4vD8ADzkU9ZQeE0x4wKIvXl+nMcMlyAvP1w6w/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqnVYNNvcJKDW0Bus7UtqSCtlIy2KWWR6StApodPu3I=;
 b=sSE33Pt4AkBYDYf3faZWax47X/MFBr6IaTKjswRLYT1PGIvP1K44nwC6HJyonRrBl7+lufx4Dc0+8V/8Rl02NoRcxNWKsXIT+lERsAKL4L7SF6itAMT8d0GYHYhNbYcLGIWR+EkPqcUKZJKpKoE9SObe84hwxDP/wQI+zFkkKx+K1Oxj1XJ+lfuzmvv7qQiWcBCLw+ymDuFJBeztmitbcQM7+PMCUrqvAzGG1sY2UXdyGrLoC/ReYwp0+zfdzH5NGM5uNvli/W+MbzrXi1X7VN3x/0ELNXkxue9MS1qZOIcp+25OD9k4rGjmIqh1oSom1jn2IRAz5hB/ZqojG9njUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqnVYNNvcJKDW0Bus7UtqSCtlIy2KWWR6StApodPu3I=;
 b=M/h2tub7t8+9vJpnqaFFgcbiZJ8ByyP7d8JgGjyuL2K8BTuIqz6sALZrRLxLRsw4cL/G56JEcSzjSoWiPhWkiz1NI3y+TA7ZEbL66aw7xryCXYB2x75uCC/s1465Fw7lojAv8YoiHzQU9RxkGpXRZ4LxCrOICDuXjM6KpHqTKA5hRZlSpdSBoOamwMA3A25GGLpKqmvuGln7qJ2ScYULlH+UGpVAKj3PueD6k+1ZJcR3xLA5QwDJ6UB/Xt1mQgeZ9o+aBl4rQj8fs9pbMuR73Gus90dH3xHmLq7/xmrdRmLrLv6XCfunXozliHx1OixooL55xX0CzkGWwuBdmb86tw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB8040.apcprd06.prod.outlook.com (2603:1096:101:2d9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:30 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "clg@redhat.com" <clg@redhat.com>
Subject: [PATCH v2 1/8] hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to GIC
Thread-Topic: [PATCH v2 1/8] hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to
 GIC
Thread-Index: AQHclLAt1a6G4/GXeUeG4VT+rBGY7A==
Date: Tue, 3 Feb 2026 01:55:30 +0000
Message-ID: <TYPPR06MB820671853682575948C1EB0AFC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB8040:EE_
x-ms-office365-filtering-correlation-id: 6b69518b-f793-43d5-8fae-08de62c74f99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bHpHSmNoMWlOc2I2RHNIVTk1cnd3cUZBQ05WRno1OFZTSEJoTUlaSUpjYnZy?=
 =?utf-8?B?ZGlXUUtZK3lqUWY2RzFYNkpyUDQ4M3greWh6YTUyMHV3U0swcGR0Qk5Lbjh6?=
 =?utf-8?B?WnhIY016ZENaVGFCNHNBTEZ0dXRMdGVVQXAvMXNIYkdCS3pycTFhb2JlaWdj?=
 =?utf-8?B?c0tWUDJIdHdvYnlUb1JNVjh5YnU1cWduYklMdXNWdS9YbVFndVI4YmhLNmxF?=
 =?utf-8?B?M0loS3IzbnN5a2V5NXl6cll2UUYwS3VhSTlDeEtrdGREQ01KZy9RV0ovMWdB?=
 =?utf-8?B?TU5ZK3NhZ2JWQ2tQajlWQnF3b2RwdnY1Q3VGU2VKeC8wTlVPNnJKMml2b0Ev?=
 =?utf-8?B?ZWdDU1FsYkR5ZWJSNTdUam53QlM5NzNNOFA5K3NNM1NlSDQ4UXF3T21vcHdD?=
 =?utf-8?B?djhhd2QzbTdQR3Vwd2tUaEZUOUVsYU1VcnB4ZE9qdXhQRXRGK09DZTBnY29B?=
 =?utf-8?B?UGovTWNzeXJNQ1kybUFVak8vaExNTlA4N2pSMlpzclJiMHJuTTNRSnV3bkdj?=
 =?utf-8?B?VUtWV3dqRW1kSnFsMXNNN1p3MnV1cGxqZEhiZjFlN3hKU0RLREhqWWxFOHRw?=
 =?utf-8?B?THFRanl2aFdhUXlvZjdMZHdCc1Z3T1F1elh3TGJBSHdTUldHeUcwQzlBQU44?=
 =?utf-8?B?Q1BScG52blBLY0x4Rk1oMGNLWFZZa1UzRW9uMERLcHROd3lXanlNTTJrNWkw?=
 =?utf-8?B?YlBrMU13eWpyNzRqQzQ1cXk2c0NHdnpkb1RkUXpVSjczeGlQbWV0RHRJVDNF?=
 =?utf-8?B?TXZhc1F6UktIMDBXbi9hbVhITUFVaWV4cXZNeFZWVHpNbGx0WmV2NnRvKys0?=
 =?utf-8?B?bC8zZkM1eXNkQnpTSmtrVE96UkQ4MTkwZGFpcmpCNDNpanJBUkpzWjhIUnBw?=
 =?utf-8?B?Y0R0OTVnSkJMblhrY1ZRdTQxa1ViS250cHhRbXRsemh1bytmRWRIVXd0VFl2?=
 =?utf-8?B?SVRWS0pUZ2xJTStwWFRDVktJeU5wckZEeFVCcDB0S3RyemF5T2I1b2dROHVh?=
 =?utf-8?B?a3MwTHczcWptemhHOHkySGpacW1maUthMTRUK0hBcjBWdXJ4ZlEvemYvMTB3?=
 =?utf-8?B?TkM0OVZaT2JHa3ZJMnlZRnhodk83cDRheE1iSXBmRTBwU1JEcHJtMHZyQ1kw?=
 =?utf-8?B?bDg0dUovY09ZeG5PZHJ2V2laYkMzTkh0VHpEclVFQVpTMkh6WGpIY3IrOEFS?=
 =?utf-8?B?R0V0WUNoVXM3WjF1TlBDbUhhMnF4bWpMRStpVG5PZ0lEbC9nNHQzTVV4RVJk?=
 =?utf-8?B?WkpKV012QVFEcTlVMU9Td2Z4VXJXRjBJSWo5OWp4aTd2STNwRzc1WjBTVWpM?=
 =?utf-8?B?bGE1c2JJVlVLZkk0SGZJb0FZUHJSMWxDR3NrMlZidkRBVGVLSjF3ZHV1czBq?=
 =?utf-8?B?L3pSMXpkZDhvV0FZeEZMM0ROWThrbk5vRjRZMGR6K21PVUl6RlhKYmRMSFJD?=
 =?utf-8?B?d3hNNStjUExaYlJQcmowSVJqVndSK0pvNm5BMDJ1ZU4vdGs2VG9obk9DYWZq?=
 =?utf-8?B?dkpJaVBhRCtjVnI0OGwvMUhQaXFFSGVwQ2xMbTdBNnM2MDU3T3F2RmJNT3FK?=
 =?utf-8?B?eFpDZ1NrRU5tck5IQldRd3RXOWJTanlnSnBUOFFNVWZSSEVwN1NVc0dtR3FU?=
 =?utf-8?B?Z0hlUXp6d1pPcHp0eVZmM0N2L3k4amdRVWpXUzA2VHRVTksrT0tRR01jTEwr?=
 =?utf-8?B?VXZNRXhGL3I0eTNQRENwczFpNDRDbTZOdkJNcjVEa3E2RHFHc0g1RXd2bzV6?=
 =?utf-8?B?SDJXRXNpK2IyM1VLa05iWGdPU2trUXBmQklUMUI5R0x5T1VxQTUzdnljZlRv?=
 =?utf-8?B?a2ppUC81akFILzd6anZHODlCcFg5TzhQdEVMQm1HaXJybWYrZG5UVThiQ3Vx?=
 =?utf-8?B?TzJjL1c3NTgzbkJOM1NVb3lkNWpQSWlwc1VZZkVvcEJpSE90MlJmQk01dlg1?=
 =?utf-8?B?akFQenh2MFNxTjNYbDFSbGVyekhUSE1BVDcrbEc1U0NJMW5qcGUyZFA1ems1?=
 =?utf-8?B?L2xWeU1NLzJZSURoa3FJdmRTQWJzL3h2dW1YNXdhQllEMVJPUTVhbnErZkNG?=
 =?utf-8?B?cFNscjdsYTliWGV3ZXFhU2xDK05kNWxjN016RkxvdHVuL1hKRVpHc1pROVZq?=
 =?utf-8?B?enAvWjZBZlBpM1JncmJieXJRL3AzUjVIeG9yWjkyV200OXZJWFk0TnVKRW1M?=
 =?utf-8?Q?KWJUzqqUjw5PD70VEae9AIg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjNzVWlnWWxUcVhxMW9IaFdwU2lrL0hvRVNYb2QxQVhJMWJ4UG4ySmJianRk?=
 =?utf-8?B?M1VkRUlvVjZ0TisxYnpIQlJDSU9ucEVnUjlSUFYreWhPK2JkL1pTblpoc1lo?=
 =?utf-8?B?RzMraUlOMXBNdit2Q01EM0huUHpQbEVNZ0dDdG8xemt0eU9UWFhZNlhVS1A2?=
 =?utf-8?B?c3paSG9WOHRZWm5oMGF3SGQ0cTNmR2lQVUpYSEtpSlp5UkEzaGRoRkRZZk1D?=
 =?utf-8?B?Y21ZK1VTdENrQWpPejk3aDZNOUxoVU5zeWorSE5Gem4rU1pXZjZFbDNmSGM4?=
 =?utf-8?B?aTJOVnVBS3k3SUR4SWRJY3ZaTXRSS2pqd0tBYXdEdGFZQkhjVlZzL2x5RlRW?=
 =?utf-8?B?ZnpFMzZRdEtDc2RkNWZ1ZGZ1S241NkQ3VEFoeE1iT3dsNFhPTXJEZk83ODhG?=
 =?utf-8?B?SVB6WXBmZlgyWFZ4bGp2eUQrUGZjMW5KcFgyNTFMaDRrb2RyM29PMU1CWENl?=
 =?utf-8?B?SkdTRmVNZkNvekpRZVYxeWh6QWM1RzZsd1A3WVA3bDVyRHBIRUoyR1R1ZEdx?=
 =?utf-8?B?OG45QnJPUHpKNEdQVkxwOXJtbTY0L3J0bDR3cSt3U0ZidjZmVWo1anEwc0Fy?=
 =?utf-8?B?ZFZ0SVdMQXB6bjRjcDZDNUQrTzdIVy9XbFAxc0NJMjZialNISFA0eE5xdHp4?=
 =?utf-8?B?Wnc3aUlzbStrcVRMV01zbzQ3MWM0VHRTZVlXNUVXWHlqb2dwK3RPOEFVMm9G?=
 =?utf-8?B?YTVHNHZlcGthK2dHY2QzUFdBaFZoZVhDWTEvTm9QclMvNlRwbFZQYWpkSlV1?=
 =?utf-8?B?WjBDYm5QZndzdlIxeVo0UU1sUGc0WnRPa1RCbGlhemt0YzVrVjYxTWdvTmV6?=
 =?utf-8?B?T0h4aFA3ajBKQ0ZUVi84SGFCV0RrQTRFQkU0S1hSVzdRSXFnL3Mwek5DbUsx?=
 =?utf-8?B?emQrNTRWbUw3Ymd1cjF5eTBsRWg5cVR5SkIxbUpPZ25PRCt3clZLOXVVUTIz?=
 =?utf-8?B?aTZLb1VVWmtaMFhBekt3NU5QcVJmY3NuZ3dpbVVOYmxGenNoenBjcHFNMThY?=
 =?utf-8?B?Q1lQdHFtZnJwcnViUmw1YnRhZVJTUXNKT216ejRsQ2NRMkhTR0VidlN3VXh5?=
 =?utf-8?B?bzRMejIxUVVPZFAxdXo0WHVQSTlrSzNVOWdnQy9kbnNjM0FCOVVTTzFRV2dJ?=
 =?utf-8?B?L3dicVl3aVdMZTZMS0xhU2xYKy9kVEdnRVNYdXZzRjYrYUhHYzNMbVZLcFJv?=
 =?utf-8?B?UlJyWW12YnlwZWpDYVIxY2lzK3JqK1p1TjFWYW5id2ltdzVCdHhtOERXUjFS?=
 =?utf-8?B?cU1Pd0RsWUNYQmVyZmJzalNDZmlVeTdLRThLQmYvbEMrK2h1OVF1MXhLUjc4?=
 =?utf-8?B?RFhUQm1PNVlPU3RYR0k1bXVYMU5SSFRkUUxRRUFUTFZtbjZlZ2pVTEFrWi92?=
 =?utf-8?B?S2xLT1hIRDRZK1pKUlJHbmtEZUlxSU5EUDZsVmIva0RGTXM3NW9Mdkp5NG5O?=
 =?utf-8?B?QXIrb0NDSjYxRGd1cTFQWE4vRXdGNXJvYUZhWXZwQUhuSkcxSzZieW1aRUtn?=
 =?utf-8?B?NGJhS252dWQ4N01kN29LdVVvUzFQNnVBaUtZK0tOa1lyVys2dTBZeHU4T1lI?=
 =?utf-8?B?bUU4R2VEcFMvSUpucnhWeXpld1pDVXpERnRZVXY0WDd0aE5jQlp3bXJmSC9K?=
 =?utf-8?B?cTErS2VCdGxLR2hVTUYvTytVVzVUb01yNkJhUDU5Q0FUTEh5c2xXSmtlOG1H?=
 =?utf-8?B?dWx1NHVzUkpLdjBlVS8wTlozYllubGJpWGtzVUx5UFZSQjNMVzkwbnhhZm5T?=
 =?utf-8?B?N09FY0pzYXpEYVFTcm1zSm9nYzZsb0pDNUVzR2FqU1A2NVdWSkc5VDY0eE9N?=
 =?utf-8?B?Mzk0eTk5MTV3ZnRyTFFiSkwvNk9tc2NUbktYOElCbGh3K2FBM2loaWdRZTVM?=
 =?utf-8?B?dTM0Nlh5MUNYOXp1ZEtWVW5yWTFadng5OTN0R0xncFFPVnlhSW1RcFVpSk1B?=
 =?utf-8?B?U0pXak1lUXQ3cGZBSVJBZFN3dWlid0hxMmFkc3VnQVpqOGw0d2NxR2x2ZzNw?=
 =?utf-8?B?c3lmTFAwWDR0eURMdWVpNld4aXA3YmY4YnJRbnFsbDl1Q2xEL0pPSkk4aDU2?=
 =?utf-8?B?YUJNWW1yejhHK1BPWXdKd2VoV3QwdHpzMTBTejRlS3NURTd4c0Jhb1J1L1V3?=
 =?utf-8?B?NUdkUVdkM3FDZTMxZDQ5cWJuOVNZZ3dGcnRpU0lFdmw4NWp5MnJSb1RDb3pl?=
 =?utf-8?B?NGd3YUxkS0tLZjE0ZWZJWXpKME9SUXU2WEFGRlV3bHRydEp6QUZuU2VyUWNK?=
 =?utf-8?B?V1BtWUZ4alRTQ1MvY0c5enNQNWR3bGNLcStaSldKb1hqVXptaVBNb0dNOFFp?=
 =?utf-8?B?bkFhc2svc0lDVTZRQ0pubXVEN2ZEVVl6ZEZZaGJPVDA4alFYdXFMdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b69518b-f793-43d5-8fae-08de62c74f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 01:55:30.6452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbDDoZ944JjufW1nP+0WLpAe22gyPCmqUHA3xZL3Oue2H2mJjO8ei1SvqDtWaBYKmMFJLO9i6w8jlq2CZBsG6AwhTnNbW6VoAT+NOp4Qvvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8040
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

RUhDSTMgYW5kIEVIQ0k0IHdlcmUgbWlzc2luZyBlbnRyaWVzIGluIGFzcGVlZF9zb2NfYXN0Mjcw
MGExX2lycW1hcCwKc28gdGhlaXIgc291cmNlIElSUXMgd2VyZSBuZXZlciByb3V0ZWQgdGhyb3Vn
aCB0aGUgSU5UQyBPUi1nYXRlcy4KCkFzIGEgcmVzdWx0LCBFSENJMy80IGludGVycnVwdHMgd2Vy
ZSBub3QgcHJvcGFnYXRlZCB0byB0aGUgR0lDLApjYXVzaW5nIGluY29ycmVjdCBpbnRlcnJ1cHQg
YmVoYXZpb3IgZm9yIHRoZXNlIGNvbnRyb2xsZXJzLgoKQWRkIEVIQ0kzIGFuZCBFSENJNCB0byB0
aGUgSVJRIG1hcCBhbmQgcm91dGUgdGhlbSB0byB0aGUgc2FtZSBJTlRDCmdyb3VwIGFzIG90aGVy
IHNoYXJlZCBwZXJpcGhlcmFscywgZW5zdXJpbmcgdGhlaXIgaW50ZXJydXB0cyBhcmUKcHJvcGVy
bHkgY29ubmVjdGVkIHRvIHRoZSBHSUMuCgpTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWlu
X2xpbkBhc3BlZWR0ZWNoLmNvbT4KRml4ZXM6IGJhMjdiYTMwMmEyNjQxMTdjOGI4NDI3Zjk0NGNl
ZDFiZWQxN2M0MzggKCJody9hcm06IGFzdDI3eDA6IFdpcmUgdXAgRUhDSSBjb250cm9sbGVycyIp
ClJldmlld2VkLWJ5OiBD77+9ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPgotLS0KIGh3
L2FybS9hc3BlZWRfYXN0Mjd4MC5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGIvaHcvYXJtL2FzcGVl
ZF9hc3QyN3gwLmMKaW5kZXggZDE3ZjQ0NjY2MS4uZTE2MTgzYzNiMyAxMDA2NDQKLS0tIGEvaHcv
YXJtL2FzcGVlZF9hc3QyN3gwLmMKKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMKQEAgLTE0
OSw2ICsxNDksOCBAQCBzdGF0aWMgY29uc3QgaW50IGFzcGVlZF9zb2NfYXN0MjcwMGExX2lycW1h
cFtdID0gewogICAgIFtBU1BFRURfREVWX0VUSDFdICAgICAgPSAxOTYsCiAgICAgW0FTUEVFRF9E
RVZfRVRIMl0gICAgICA9IDE5NiwKICAgICBbQVNQRUVEX0RFVl9FVEgzXSAgICAgID0gMTk2LAor
ICAgIFtBU1BFRURfREVWX0VIQ0kzXSAgICAgPSAxOTYsCisgICAgW0FTUEVFRF9ERVZfRUhDSTRd
ICAgICA9IDE5NiwKICAgICBbQVNQRUVEX0RFVl9QRUNJXSAgICAgID0gMTk3LAogICAgIFtBU1BF
RURfREVWX1NESENJXSAgICAgPSAxOTcsCiB9OwotLSAKMi40My4wCg==

