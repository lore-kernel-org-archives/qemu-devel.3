Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFFDD74970
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 09:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWWod-00086w-D2; Fri, 19 Dec 2025 04:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vWWob-0007zm-C8; Fri, 19 Dec 2025 04:30:25 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vWWoZ-0001KS-87; Fri, 19 Dec 2025 04:30:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBW6BMA2iW1mstpG9mmPDMO44HECTSpzNDHQfQ0f4k3Yx4XdbceDQvg3XTwo7bQFO0OPXlYyQ/DotHH0g9iYUBrhQdBFGCArBjF0jO/JceCdFD8Y9am4l1jHF/L8015jM5zgNL95b2XrZmOdST5XCx1AINCd7X4rV/lfLUw9MWzCkzWND1s4jzGeBtrJv/I9rTR55L2ac9nUdBAq2T2+XgvKXjKuiUD8gH6Vri50qUAdOYdfIws2gAzbBD3s8OpQiM2+xMbfj+qvYxTqVjqwrR4/JAFySVm+6Smzeu54okjlR+YMiimVo4TSIHJSrDSH8uKCPhgMVsZ8AXgWOKvfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTfSvlhKsknFulPLWyVzbAlE1TZ+xYUv8BqnFWglkaI=;
 b=QOl0TjxQ+VLCJy0Eggr5yiJYXqbhyOwxN0cyymypjqg7AK3TLojhQV6xYRgp0gWgZixQcnCp/3d+6VfD1vyOcDzJXCw7qWon92cpqi6SMWS0lHnAUyeAoiWOhi/VMqe9ik/hn/dLZFhH3xuy319Qrvs9GIN57dX1fRup9UXW4eGfXR5wS1iW9TTNz2tduebAobCve+2odk6MNba+2CfJ/pSWzdVlwn+/4q0WWLpVnar0wfipifRfYRysvn7xVFdhzvgiFZLkoBUlaVFMQS1gQNmJT5wCy7snbubpqov+neMlmBjIKKlGsLgrTcKRSFt1GK1Yu40nXV3YTgkTMV2HjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTfSvlhKsknFulPLWyVzbAlE1TZ+xYUv8BqnFWglkaI=;
 b=Bh7i1AGLE+MjoJNRSvL5koCMRRf5wHnie6M9wQEj8E9P7/+D6oy5jOkgB/1Ng2mdrwNKrSzRWnCC7YL/aBtSqIXwGnIOllxpdzUQiit+fh1tZIjcC5mJrpz7jLIzXWtP95vXTVUB19PC91YOiMpPHKtlMVpmScVWrTPcx6pmH9DQr3GHoQQYNPID0nVQdzaN2iEb2obnbvEhknSNY054YNTWXnzXdyHktthvu15TxoQp2GbkruhTljm6rg5EjG/wUt0vj+nXokEBfwj9XcKiKqC1G1OiVpwZVrejot/kwZHTLprWNLi506dJWgUf92mVSrFsoaXc7X8HIwMJHtV+nA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TY2PPFE0788CA4B.apcprd06.prod.outlook.com (2603:1096:408::7b0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 09:30:17 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 09:30:17 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Yubin Zou <yubinz@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Nabih Estefan <nabihestefan@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
Subject: RE: [PATCH v5 0/6] hw/gpio/aspeed_sgpio: Add Aspeed Serial GPIO
 (SGPIO) controller model
Thread-Topic: [PATCH v5 0/6] hw/gpio/aspeed_sgpio: Add Aspeed Serial GPIO
 (SGPIO) controller model
Thread-Index: AQHccLXAr3uzybIfUEOX64DoSw9O+rUosF/w
Date: Fri, 19 Dec 2025 09:30:17 +0000
Message-ID: <SI6PR06MB763199B647CB308C9C6830B3F7A9A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251219-aspeed-sgpio-v5-0-fd5593178144@google.com>
In-Reply-To: <20251219-aspeed-sgpio-v5-0-fd5593178144@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TY2PPFE0788CA4B:EE_
x-ms-office365-filtering-correlation-id: 3adc3c0b-15ad-4bdd-e35b-08de3ee138ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dnNDUWJHbVlaTWhMZEpTWnNUVTJ6aVR3K0dIZEhOR1RtTDJuQzVvQW1GMlFi?=
 =?utf-8?B?RHdsVWdGVFdEa1pad3gzUkwyVEVSRWowYmpWZEk3aCtQRE9kQ0U5UjAvRTM5?=
 =?utf-8?B?Q1JTc1FjTHpSZlFEMFcyaGdlZWgxd2tZbWw3S1VaUjNPYkUwbFRLeCtLS0hs?=
 =?utf-8?B?cXk3RDFud1hpdUtNVUpHMTRSWXNxUFRVQm9QSGdmVUpHVi8ydk42R3VGUCtT?=
 =?utf-8?B?Z05BMUh1d1hMY0t1TDNsYWlycTRpdjh6cUhSQTgxTW4veEVBZWNVcXVNMDA2?=
 =?utf-8?B?b0JOdkFNMkQ0YnhTNGhIU0VkZEJKMkZCOG55cFpZWTRoTGxHb1lxMm9CUEFR?=
 =?utf-8?B?QVdRc2VaR1lKQW5wTEdON2hNUVBwWmxYWVVHdUlJclpYem5vNElVRmcwZElJ?=
 =?utf-8?B?L3ZsRTF0cmgyZFVuNWExSEIyWW9MeXJ1Z3JvVXNlSVludGl0ejZ4am9FcUlN?=
 =?utf-8?B?Yy8xZGw5UHJnemhMbGlaMVk2YkVQZnN1VHZ4eklHVTFGbjRSYjE3djYvRDVX?=
 =?utf-8?B?dmRlRHY4VXluQ3dsLzJEWFg3b09zc1l6Vm10VWtHeUQ5eFVGUVJ6azNFQ0Qr?=
 =?utf-8?B?d1VEenpyL2dnMU90S3JYcWlEWmlRNkdaM2dPOEJiRmxjZVQrTWtiRmtsbnhk?=
 =?utf-8?B?d3JUMndRS3JMQkZ1RXdNb3lpQjZxOVRGd2lXTGRaa2FNKzUyT1hSaXUxdC9F?=
 =?utf-8?B?bklsMVBIM3NlUUl2LzBOQmlnQ0RsdlFoODVrVEZyeTdlUmwvRGlSY3BrWExG?=
 =?utf-8?B?MkgxbE1DTlRsdXNOdWRocEJJMzl0TWljTUxiaDJkK0M1aXdkOWd1TDN0T095?=
 =?utf-8?B?VUQ4M0VDL3lFMFRyTnpjek0zcnA4ZHhhd1NzVFJtYm9HY3RXb0tYR1hGdVl0?=
 =?utf-8?B?amo1WWFQYkozMzNOQi9Jc0V1UWpMTFhWRUEyUW1WendtdHdrVEIrVS9mcXlu?=
 =?utf-8?B?a2pIOTdpNmcvNHJXOWdJdTl3Zm9lOWk3bkhKWEhFWWhwZUtQS3k0b2hCcDVJ?=
 =?utf-8?B?RVZpc2plaGt4UG5UR0RDMzdVRUFTWjM5K3RiN1pTTi8xNEhRQndxd2x0M1dk?=
 =?utf-8?B?RllQQjB0QzVtZlZJcEhqVVpsNXpvUVNEUUhyd1NySiszejRjSmhKRWdaNm5K?=
 =?utf-8?B?ZDFteGZQeXBhUTVhYnhwbG5UQlIzOVdSNjJnUm5zTDFNU0RZN1hQZXg1czM0?=
 =?utf-8?B?RjZNUHo0bHlsZTZ6eHpFQm5DY0JVL05NWXZXck5LeWozN2ZPODRYbVA2OEkr?=
 =?utf-8?B?Q2xveFRNNUNQbXF6SkJxaDk5UElzN29Ra2RMakFYSnBIeUV3NDI3OXluczNG?=
 =?utf-8?B?ZzZhN1Y2VXlmQ2JhTXZpV2hzQkRENU14UzJsbHBTeERpTkw5eXFvbFNFZGc4?=
 =?utf-8?B?d3JmbkVHdWZOZy9HNExnUWV5b2dWUHNtZFRxYSt2dWx1VWdEbTA4bENka1JJ?=
 =?utf-8?B?a3N3a0kyK1NsOWR5cHBCOGFTTTQ0OUd4RUxMVXFITE1lcW9RY0xEanE2Q2tX?=
 =?utf-8?B?bkdicFRPQU9EOTZyU1ROQnpKTGpDQ2FHRk5kK2ZHR2QyTlV2TGNQUk5jT3dL?=
 =?utf-8?B?aS9aZ2d3MXV2OEVDbWVIL2pkLzQzdkpvdmU0NkE0a3hLQnNXaFRvT2dBMnJl?=
 =?utf-8?B?dWkrS1ZOWmZWQ1BrazJFZkk5S3JSM1JyNll4TGJPNXFVdkZiY29jS08wK2pw?=
 =?utf-8?B?R01RbnJ4cllGbnZxQW1oNGUvMkNzVFBMSEpiWkxsNWVTL3hNZ25aS0YxSFRx?=
 =?utf-8?B?dFd0V2xXN3R3Q3lBNTd6TzZpNTZtaHpOZW5wTStFbkxCeXU4RGQrWWljcXlH?=
 =?utf-8?B?NENxM1o3ODVUSERIMlhmOUlMWFc3bmZIVGNKM1FjM0d2dVkxdmkvQ1Z5T2hz?=
 =?utf-8?B?NmpyODZCMWt6eWpoeFNkSWZoYkpDSmtUQTJENkszMDF5Z2N2K3R5dmZFNFlx?=
 =?utf-8?B?ekNWb3NVeGV1REVaMHNSYjJINXdVTkQ4UTh0N3RaNzdDeVBENThwSTMyQ3Rz?=
 =?utf-8?B?NUszOFA5SHBJUEdaMnNYeWxtUHFrNHUyNlZ0byt1VGRxOHNWZHcyOE5CTVdZ?=
 =?utf-8?B?MVlULzB4T3c5bG9Wc3BEVVdEQ0twZ0xMd3B5QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGl5czNVM0IxWmd6dmhDL04rUmVlbDR0VXdmRlVUMUJPdWo0alRjOWZ3Nmtk?=
 =?utf-8?B?YlVJOVNsVkRZYzhQSTBQdjlucTJZYWVTZ2tuN21EajFYU2U5QS9HY2tOaG1w?=
 =?utf-8?B?cHhmVHhCWERIUGdETVVtSEJJOXB5bDVHWmRkd2VxRnU0dVFSZllPVS9JSnhx?=
 =?utf-8?B?S2Vad21HbStnNWUyZXI0cUMyeXU5ampEcXBESTBBUHlaNFMvaVFJUUsvYkxY?=
 =?utf-8?B?cXpYWmdjZit4RkFvZ0FmeFNuaGlHTjBFZkpveVNab3pFeVhVSm1pekZoakVm?=
 =?utf-8?B?SCtGVnRUMURCRm0yOHd3S3gyQTZQcjNXSmRTMnpicldLTW1rdE1HdW0ydEdV?=
 =?utf-8?B?VFRWY09XcDlqeE9qb3l1VE44ZW93WVVCdnNUY0MwQU5ZL1g0Z1plV0xrSjAr?=
 =?utf-8?B?b21oSVcxVDlYTkozd0FJN0g3cG5Uc2RJVUpmbVpjZVh4Z2QrTmVBUllHMlJR?=
 =?utf-8?B?YVZ5UDY1QW9wZ2RKbTg1TXovaGFobE9tN05jOEM5MnhhYnFFRjdTUUlPYnY1?=
 =?utf-8?B?ZlZKN0p1Z3ZRM2xwYitCRFlXeXBzVVNONFN1cGJlV29lcUIyZWN2QzJ3dzd0?=
 =?utf-8?B?bnM0amd6YnU4dDJYM2pNMkJGYTBJa1pLTXQ2WlhOZWZGNnRJNHBBWVU5VDJF?=
 =?utf-8?B?eGkwODFiNkZQMC80bFZ1YU16eE16ZkxEWVJRMGlwdzVIVTQ4c0JzOU12NWxn?=
 =?utf-8?B?VlpTd1M3ZVNEVDRyWTI4Vk1Nb2VVYlFpR3p1aFZZbkdYSFZyS0krS3RZOVQ1?=
 =?utf-8?B?a1pnZngzR2VJUWQwSWFYNlVHbXhJR082Skw1TS90UERXbjhZTXJZRzNiTGNu?=
 =?utf-8?B?b2dRb1QxbjBhdW42dzV5bU9wU0k4L012aDhaR0JpTkdUbGJlVkJmVi9vUXNC?=
 =?utf-8?B?eEF6Z3AxL3lNdEs2YW9NOW55SlRCS01HRDVuRm9hMjdzV2pSK3lvY1E2Sm9E?=
 =?utf-8?B?cVNEa0dKWmNFTWwyWGYwbkRQMzNKK0FobEp0MURtQXRwR3Y0Qm9BOWlrNVZQ?=
 =?utf-8?B?b2R0K1VSSjZCczRJSU9aSjZMUVcxbnoyMy9hRDVRL2VhL003dldRdGtNa3pa?=
 =?utf-8?B?L2tsazU1VmxoSmo1dk55MjlFUGJZVEhVdFdndGlNWTdiTERER2dOQzMwZ29Z?=
 =?utf-8?B?ZUhFT0I4YmdibGtQNVNjaWcwU1hyL0c2N3FDNnNYNXR2WXljN1BqVkhycEtW?=
 =?utf-8?B?dU1YMlMvdUY0UXBleFk1R01hS2RBK1d3ekdvMUl0amZ1WUcreERhY1FORUxl?=
 =?utf-8?B?Q1k2VTY1b0tpcTVBZ1RBbGJRWXVHTUtINUVYVkZ2MmZRSzhYK3NSWjdtYWcr?=
 =?utf-8?B?WVFMQ2NucFdCVWdpcEFnd3ZFL25YNTZsWDREVVpnaHlOTVIyYW9uRHVGMjV5?=
 =?utf-8?B?SXhWcjB2NEJMRFBTLzJWcmhLRDU2VWoyd3Q5cWRQbXlwejdwNHg4MWNrbFV5?=
 =?utf-8?B?YmQ5MjdWUktrT1V0am1yODcvQXFkcDljbmZlZHpCN2NVeW53b3JycGZRNHZG?=
 =?utf-8?B?cFdiYnBGRDI4bllkd2h3Sk0zOGl5Si9lQnRiNkdXTE9vUkNhY0hGaWtjditz?=
 =?utf-8?B?dk9tcUdWL2pCcERkb25EOWk0a2JhMHJFaWJMdTIzcE5hOVkrNE9sbW5ZSG5K?=
 =?utf-8?B?ZzVkeHJiTWIwNGVPbU85VDEzYnU3ZDlHWFN5SnZ3VlRrU3pvTnBmSXRtT29a?=
 =?utf-8?B?VGhOaWhxbUpibjFOR201QmtTOEw4d2tmSlQ1VzdoRnl3Tk9Dam9GcDIrblkw?=
 =?utf-8?B?ZHVYd3lhZk1HTHc3d3VPSDFCU2FNcnJxbVpSaVY4U3dGYmdWaUFkeXVlRWpv?=
 =?utf-8?B?OEhNOW95cnlSR09KTGo1K0lyYVVxZHNaTEVuNXk3dFlkSG81K1YydW9IVHU3?=
 =?utf-8?B?UzVLRXVudEwwamVuNUZCZkhxNWx6c2F4ejFxLzRZTjkvUVExdkR5UXMzeGJD?=
 =?utf-8?B?d3RoanBnRHJKVVp0NGlVWGptM2hUSmlMcWRNZkMzT0c1RXpKclhvd1lpbU9Y?=
 =?utf-8?B?UGtVWjRHTXY2UmpNQ09HVDF3MjRkdldjbUdTRlZhdGJuaVk0dlorbmNGdHpl?=
 =?utf-8?B?b0RFcGFhYW1CQndya0dDcFRNZFRkNkFLbUtIVC96OEpXcDRid21EYUR5SHRR?=
 =?utf-8?Q?8okWchOSwgOXy60HbCuhY3ix6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adc3c0b-15ad-4bdd-e35b-08de3ee138ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 09:30:17.3343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdTRJ3H86RGGEl7qNitqZqjLuTog0ikX8GmJTXr66gSVllEE1f19YrV+JxHhbuhohMLMqV0JCj1kQqaxrx3yoLb20ACL1KflNFpGJtmqG9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFE0788CA4B
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZdWJpbiBab3UgPHl1YmluekBn
b29nbGUuY29tPg0KPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDE5LCAyMDI1IDM6MDQgUE0NCj4g
VG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0Br
YW9kLm9yZz47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0
ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVldHJv
eUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJl
dw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkg
PGpvZWxAam1zLmlkLmF1PjsNCj4gRmFiaWFubyBSb3NhcyA8ZmFyb3Nhc0BzdXNlLmRlPjsgTGF1
cmVudCBWaXZpZXIgPGx2aXZpZXJAcmVkaGF0LmNvbT47DQo+IFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+OyBLYW5lIENoZW4NCj4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47
IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPjsNCj4gcWVtdS1hcm1Abm9u
Z251Lm9yZzsgWXViaW4gWm91IDx5dWJpbnpAZ29vZ2xlLmNvbT47IEPDqWRyaWMgTGUgR29hdGVy
DQo+IDxjbGdAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHY1IDAvNl0gaHcvZ3Bpby9h
c3BlZWRfc2dwaW86IEFkZCBBc3BlZWQgU2VyaWFsIEdQSU8NCj4gKFNHUElPKSBjb250cm9sbGVy
IG1vZGVsDQo+IA0KPiBUaGlzIHNlcmllcyBpbnRyb2R1Y2VzIGEgbW9kZWwgZm9yIHRoZSBBc3Bl
ZWQgU2VyaWFsIEdQSU8gKFNHUElPKSBjb250cm9sbGVyLA0KPiBjb21tb25seSBmb3VuZCBvbiBB
c3BlZWQgU29DcyBzdWNoIGFzIHRoZSBBU1QyNzAwLiBUaGUgU0dQSU8gcGVyaXBoZXJhbA0KPiBw
cm92aWRlcyBhIGxhcmdlIG51bWJlciBvZiBHUElPIHBpbnMgdGhhdCBjYW4gYmUgY29udHJvbGxl
ZCBhbmQgbW9uaXRvcmVkDQo+IHNlcmlhbGx5Lg0KPiANCj4gSW1wcm92ZW1lbnQgdG8gUUVNVToN
Cj4gVGhlc2UgcGF0Y2hlcyBlbmhhbmNlIFFFTVUncyBoYXJkd2FyZSBlbXVsYXRpb24gY2FwYWJp
bGl0aWVzIGZvciBwbGF0Zm9ybXMNCj4gdXNpbmcgQXNwZWVkIFNvQ3MsIHBhcnRpY3VsYXJseSBm
b3IgQk1DIHNpbXVsYXRpb25zLiBCeSBtb2RlbGluZyB0aGUgU0dQSU8NCj4gY29udHJvbGxlciwg
UUVNVSBjYW4gbW9yZSBhY2N1cmF0ZWx5IHJlcHJlc2VudCB0aGUgaGFyZHdhcmUsIGFsbG93aW5n
IGZvcg0KPiBiZXR0ZXIgZGV2ZWxvcG1lbnQgYW5kIHRlc3Rpbmcgb2YgZmlybXdhcmUgYW5kIHNv
ZnR3YXJlIHRoYXQgcmVsaWVzIG9uIHRoZXNlDQo+IEdQSU9zIGZvciB2YXJpb3VzIGZ1bmN0aW9u
cyBsaWtlIHNlbnNvciBtb25pdG9yaW5nLCBwcmVzZW5jZSBkZXRlY3QsIGFuZA0KPiBzeXN0ZW0g
Y29udHJvbCBzaWduYWxzLg0KPiANCj4gSW1wYWN0IChCZWZvcmUvQWZ0ZXIpOg0KPiANCj4gQmVm
b3JlOg0KPiBRRU1VIGxhY2tlZCBhIG1vZGVsIGZvciB0aGUgQXNwZWVkIFNHUElPIGNvbnRyb2xs
ZXIuIEFueSBndWVzdCBzb2Z0d2FyZQ0KPiBhdHRlbXB0aW5nIHRvIGludGVyYWN0IHdpdGggdGhl
IFNHUElPIHJlZ2lzdGVyIHNwYWNlIHdvdWxkIGZpbmQgbm8gZGV2aWNlLg0KPiBGaXJtd2FyZSBm
ZWF0dXJlcyBkZXBlbmRpbmcgb24gU0dQSU8gcGluIHN0YXRlcyBvciBpbnRlcnJ1cHRzIGNvdWxk
IG5vdCBiZQ0KPiB0ZXN0ZWQgaW4gUUVNVS4NCj4gDQo+IEFmdGVyOg0KPiBRRU1VIGVtdWxhdGVz
IHRoZSBBc3BlZWQgU0dQSU8gY29udHJvbGxlciBvbiBzdXBwb3J0ZWQgbWFjaGluZXMgKGUuZy4s
DQo+IGFzdDI3MDAtZXZiKS4NCj4gLSBHdWVzdCBmaXJtd2FyZSBjYW4gY29uZmlndXJlIFNHUElP
IHBpbnMsIHNldCBvdXRwdXQgdmFsdWVzLCBhbmQgcmVhZCBpbnB1dA0KPiAgIHZhbHVlcyB0aHJv
dWdoIHRoZSBtZW1vcnktbWFwcGVkIHJlZ2lzdGVycy4NCj4gLSBFeHRlcm5hbCBlbnRpdGllcyAo
bGlrZSB0ZXN0IHNjcmlwdHMgb3Igb3RoZXIgUUVNVSBjb21wb25lbnRzKSBjYW4gaW50ZXJhY3QN
Cj4gICB3aXRoIHRoZSBwaW5zIHZpYSBRT00gcHJvcGVydGllcyAoZS5nLiwgdG8gc2ltdWxhdGUg
ZXh0ZXJuYWwgc2lnbmFsIGNoYW5nZXMpLg0KPiAgIFBhdGggZXhhbXBsZTogL21hY2hpbmUvc29j
L3NncGlvWzBdL3NncGlvMA0KPiAtIFRoZSBtb2RlbCBnZW5lcmF0ZXMgaW50ZXJydXB0cyBiYXNl
ZCBvbiBpbnB1dCBwaW4gdHJhbnNpdGlvbnMsIGFjY29yZGluZyB0bw0KPiAgIHRoZSBjb25maWd1
cmVkIG1vZGUgKGxldmVsL2VkZ2UpLCBlbmFibGluZyB0ZXN0aW5nIG9mIGludGVycnVwdCBoYW5k
bGVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFl1YmluIFpvdSA8eXViaW56QGdvb2dsZS5jb20+
DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHY1Og0KPiAtIEZpeCBsb2dnaW5nLCB0eXBvIGFuZCBpbmRl
bnRhdGlvbiBpbiAxLzYuDQo+IC0gRml4IHR5cG8gYW5kIGVtcHR5IGxpbmUgaW4gMy82Lg0KPiAt
IEZpeCBkdXBsaWNhdGUgZGVmaW5pdGlvbiBpbiA2LzYuDQo+IC0gTGluayB0byB2NDoNCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MTIxNy1hc3BlZWQtc2dwaW8tdjQt
MC0yOGJiYjhkY2ENCj4gYjMwQGdvb2dsZS5jb20NCj4gDQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0g
Rml4IGluZGVudGF0aW9uIGlzc3VlLCByZXBsYWNlIFN5c0J1c0RldmljZSBieSBTeXNCdXNEZXZp
Y2VDbGFzcywNCj4gICByZW1vdmUgdW51c2VkIGZ1bmN0aW9uIGluIDEvNi4NCj4gLSBGaXggZ19h
dXRvZnJlZSB1c2FnZSBpbiAyLzYuDQo+IC0gU3dpdGNoIHRvIHVzZSAgJTAzZCBpbiB1bml0IHRl
c3QsIHJlbW92ZSB1bnVzZWQgaGVhZGVycyBpbiA2LzYuDQo+IC0gTGluayB0byB2MzoNCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MTIxMC1hc3BlZWQtc2dwaW8tdjMt
MC1lYjhiMGNmM2RkDQo+IDUxQGdvb2dsZS5jb20NCj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0g
Rml4IGNvbW1pdCBtZXNzYWdlIHR5cG8gYW5kIGFkZHJlc3Mgc2V2ZXJhbCByZXZpZXcgZmVlZGJh
Y2sgaW4NCj4gICBjb21taXQgMi82Lg0KPiAtIFN3aXRjaCB0byB1c2UgZ19hdXRvZnJlZSBhbmQg
ZHJvcCBnX2ZyZWUuDQo+IC0gVXNlICIlMDNkIiBpbnN0ZWFkIG9mICIlZCIuDQo+IC0gTGluayB0
byB2MjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MTIwOS1hc3Bl
ZWQtc2dwaW8tdjItMC05NzZlNWY1NzkwDQo+IGMyQGdvb2dsZS5jb20NCj4gDQo+IENoYW5nZXMg
aW4gdjI6DQo+IFNwbGl0IHRoZSB2MSBpbnRvIHNtYWxsZXIgY29tbWl0cyBhbmQgcmVvcmRlciBp
dCBmb3IgYmV0dGVyIHJldmlldzoNCj4gLSBMaW5rIHRvIHYxOg0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9xZW11LWRldmVsLzIwMjUxMTA2LWFzcGVlZC1zZ3Bpby12MS0wLWIwMjYwOTM3MQ0K
PiA2ZmFAZ29vZ2xlLmNvbQ0KPiANCj4gLS0tDQo+IFl1YmluIFpvdSAoNik6DQo+ICAgICAgIGh3
L2dwaW8vYXNwZWVkX3NncGlvOiBBZGQgYmFzaWMgZGV2aWNlIG1vZGVsIGZvciBBc3BlZWQgU0dQ
SU8NCj4gICAgICAgaHcvZ3Bpby9hc3BlZWRfc2dwaW86IEFkZCBRT00gcHJvcGVydHkgYWNjZXNz
b3JzIGZvciBTR1BJTyBwaW5zDQo+ICAgICAgIGh3L2dwaW8vYXNwZWVkX3NncGlvOiBJbXBsZW1l
bnQgU0dQSU8gaW50ZXJydXB0IGhhbmRsaW5nDQo+ICAgICAgIGh3L2FybS9hc3BlZWRfc29jOiBV
cGRhdGUgQXNwZWVkIFNvQyB0byBzdXBwb3J0IHR3byBTR1BJTw0KPiBjb250cm9sbGVycw0KPiAg
ICAgICBody9hcm0vYXNwZWVkX2FzdDI3eDA6IFdpcmUgU0dQSU8gY29udHJvbGxlciB0byBBU1Qy
NzAwIFNvQw0KPiAgICAgICB0ZXN0L3F0ZXN0OiBBZGQgVW5pdCB0ZXN0IGZvciBBc3BlZWQgU0dQ
SU8NCj4gDQo+ICBpbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmggICAgICB8ICAgOCArLQ0KPiAg
aW5jbHVkZS9ody9ncGlvL2FzcGVlZF9zZ3Bpby5oICAgfCAgNjggKysrKysrKysNCj4gIGh3L2Fy
bS9hc3BlZWRfYXN0MTB4MC5jICAgICAgICAgIHwgICA2ICstDQo+ICBody9hcm0vYXNwZWVkX2Fz
dDI3eDAuYyAgICAgICAgICB8ICAyNiArKysNCj4gIGh3L2dwaW8vYXNwZWVkX3NncGlvLmMgICAg
ICAgICAgIHwgMzQ2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiAgdGVzdHMvcXRlc3QvYXN0MjcwMC1zZ3Bpby10ZXN0LmMgfCAxNjUgKysrKysrKysrKysrKysr
KysrKw0KPiAgaHcvZ3Bpby9tZXNvbi5idWlsZCAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgdGVz
dHMvcXRlc3QvbWVzb24uYnVpbGQgICAgICAgICAgfCAgIDEgKw0KPiAgOCBmaWxlcyBjaGFuZ2Vk
LCA2MTYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0
OiA5MTdhYzA3ZjlhZWY1NzliOTUzOGE4MWQ0NWY0NTg1MGFiYTQyOTA2DQo+IGNoYW5nZS1pZDog
MjAyNTExMDUtYXNwZWVkLXNncGlvLTFkNDlkZTZjZWE2Ng0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiAtLQ0KPiBZdWJpbiBab3UgPHl1YmluekBnb29nbGUuY29tPg0KDQpIaSBZdWJpbiwNCg0KVGhh
bmsgeW91IGZvciB0aGUgU0dQSU8gY29kZSBjaGFuZ2VzLiBUaGUgcGF0Y2ggc2VyaWVzIGxvb2tz
IGdvb2QuDQpMZXQncyB3YWl0IGZvciBmdXJ0aGVyIGZlZWRiYWNrIGZyb20gQ8OpZHJpYyBvciB0
aGUgb3RoZXIgbWFpbnRhaW5lcnMuDQoNCkJlc3QgUmVnYXJkcywNCkthbmUNCg==

