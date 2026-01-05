Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4F9C2A072
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 07:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcexX-0008W8-Rp; Mon, 05 Jan 2026 02:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcexP-0008Nu-GN; Mon, 05 Jan 2026 02:24:55 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcexO-0005VP-1a; Mon, 05 Jan 2026 02:24:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zA6BdgyCxfQ+5knBuGqC2ucGJ/UQ6PV8TVFFpUFwZ+AgRMzAqlGkRyUpreqgqj+Cx403WT1tr0C8be6B/ZGA4K9lGp7mZUsr5wehbgLqbw5NpWdHtNPMVQdxS5cb+FxJ2l+9w7foHdLYyjGF9f/ysbtCdM8gOa5gL8H8NBT8WLH0/HbEEfm8bJJXx3k5BEPfAVp7XV+OCDLlnEJGGwxyCsApfTvt59z5mKf/qp7+fLkhcG5NDyJx8svzyG14shYyuaNhtdUOBr61w91CnSvOey5S4hGCbqTGfWZ9bP0tEWYfktoTTQ98nI+4/jTRwlSgiyvxrxgBm6XvHtSXzenBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HISeLeGsRtBbZhUqndwRPJf6dqaFLYYatHrSOGrC7RM=;
 b=UqqduO+z12aEnHOr0BJo0PzCQvu72TWtRNmAitMTqezYb/pgyoAX7GhTPR5uxajlEyIY78H0UofXNKmjnP3lbtSgaFUdCZUW54sc7WG6Rto3kDKF2Rr2WuuWjItpQovVlZrLWAxa65OYnnkCDtpKr6Ulm7aPfLHG9D+OjzWQdUwz2gOBCYRWEDMYBEozOaGwK7876rJUux6SYJK7R5MnipiRrj747MifTX1Lo/F/1/qgSnBIGtg1FyhYjRkpOQUIbSsyxiKQUPhzdf1u6SUlIepUUsrRtB/M8k8DWnQUNTjny6iJh5ctw1flx37DjTqy7j7WNgEsmuhGW0Ay2TPcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HISeLeGsRtBbZhUqndwRPJf6dqaFLYYatHrSOGrC7RM=;
 b=rLTp5x0sEdQ46X2W6N6cX0RCOyDdtHVeuB7ohQCoo0BGmTC8yIcx4jyb7GLai42PysSY/RL82Dn340y3P0e8KYmh9BF8GLFK0Cq9sXofqzKS7nxKEViGlrAUAu9WfPjyUgETym/IvTZfR0WstlxwzhOdjXClw6WkE4Mzne4595N3XCBuQ4YczHuexqGTJsuMtsjgoz8hwOxbLoIAAPQPKIQwfFrLZiafJ1Dzm8P0AvvaG0bh44oZ4L2WsVuzqJWAlmQYV41ySuZT43HASPR51C22lCElpzCXXClC6+ooe31pxX59pKKlrR1CadpiXo92XxV61ls+JTP5Iiz1xAgv3g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB6927.apcprd06.prod.outlook.com (2603:1096:101:1ed::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 07:24:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 07:24:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 10/19] hw/i3c/dw-i3c: Use 32 bits on MMIO writes
Thread-Topic: [PATCH 10/19] hw/i3c/dw-i3c: Use 32 bits on MMIO writes
Thread-Index: AQHb2/a9YimUQwpZOEqeMP4VwJAC2bVEcLVw
Date: Mon, 5 Jan 2026 07:24:42 +0000
Message-ID: <TYPPR06MB8206908115837C3A5EE14A67FC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-11-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-11-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB6927:EE_
x-ms-office365-filtering-correlation-id: 52114cd6-f2c9-4176-76c7-08de4c2b7ed8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Vzd6UW0zbFllc3l3K0g0M3NVdnRXNnZ6ZHRzdjZ2MmhTS1FqZkJPUkVWTjZX?=
 =?utf-8?B?cHRqdG53aWMvQUwwRlN2Nll0L21GYldQQ0x6cjlrNG1jL0RaUHcveUg2T3FU?=
 =?utf-8?B?YjF0UnRvcm1ZaGl1cTVVM3VFZzByaDlUUVI2VUN5dWd5d2Y1SzNPUkxrMHBX?=
 =?utf-8?B?ZUpDRXYxUnc4R0xkWXVhQUIwc3k5OXJRcFg4aGxhWE9ocUIwZ2NZbUkzQ0h0?=
 =?utf-8?B?RlRqNExQUDJhQzhvS3EyTktzVE9GTDZJdGdaVmxJZXR2M0NrME4vT1o4RUo0?=
 =?utf-8?B?ZVhUMnRVVlFNNWJvYmFsN0NDNEt2UTljdzlLd0w4U29OS3VEbGlyVnd3azZ6?=
 =?utf-8?B?WjNyVCtuNTJQZkpQZlg5NmVyN3FjMHpqQkhtTUpkakwwTnhoUUZvMU9od3pt?=
 =?utf-8?B?U2Zab3A5SUltMVFOQ0tZT09jaVVUeEFQUWJJdHdla0pkMGFLV3hPQzVadGRP?=
 =?utf-8?B?YUd4aEZCSmNqNCtYU1ZaaGIvdU9ScDZ6elFRV1o4bEVQMGZyQk8yNW1JMzAz?=
 =?utf-8?B?b1JpR2diYnJNcmNNWmFjTGhEQi82cW5SRDl3amd5YU9XZUFDejZLaVgxZTd5?=
 =?utf-8?B?bzZKa1RRMlNYSFFLQnhIOHlCQ01Mek8ySFpTeUt5QnRoVjFpTFo2bnFYYXNW?=
 =?utf-8?B?SU5Cd3VGM2VUS1BSYTFEVmpxNU12elZDVGo1anpubmRlTzdFRkFLWDUwMFYz?=
 =?utf-8?B?RGxjUXBsQU9rZGRMTUNIMDdyRjRSbDRGV2JOc1ZkRzJ2TWtFQUNCUE1melRI?=
 =?utf-8?B?Wkd0STc5YkQ0M2VUcEVEV3VWZm1OeTAxQVhlajU2dld3VHpwa29KS3hpQzY4?=
 =?utf-8?B?a3FCZU41bnVTK2RycWZFOUs5QWdTVkhDL05Tb01taU9ET2d1QVV4TDY4U2Rv?=
 =?utf-8?B?WWp4NHphdFpXaTVxSW8vZUlLaGZRWmcvZmhXUERXWHljUnN1YXYzWXNRaHg5?=
 =?utf-8?B?ZUxkcVZCcTRKSHJnS3RvaU04dTY4UDAwRTU4QkJqTjB6RFQ4eXhNOGY2Zmor?=
 =?utf-8?B?QzdaQTVxSmZ1N3VkUCt2TCtzY3VlTUF0SXJsTytZTThGK2Z1L3FkdmxQUmRm?=
 =?utf-8?B?WFVrM0RBbS8vM2NSWlprVWthd3Y2V3YxOXdhM1Rjb2FMZ0pZT2NiYWVNQUNU?=
 =?utf-8?B?L1pta2FBcU1WV241aEZIZ2ZyamNvOWpUTEtHTkdZamIvMExvU3VUT1QxdkRP?=
 =?utf-8?B?WEJ5djFWbGQzd0V4ZkpqRFY0cmRVQ0pBTEFmYnBXOEZua2hJTGR4cExEdC9Y?=
 =?utf-8?B?Z2xzMjAzVXFYTVNrMDA2Uk41RUFOeEJIQ0Y5Z0kxOVVzSzcvWDQrNnVNbDZV?=
 =?utf-8?B?SGxFL0ZiOHJIRVBCTFkxTVZIazQ2V1liMlIvbStkOVZKejNUTFJUYllLMldY?=
 =?utf-8?B?Q2tMbjBRc3djckNpaXZnMGo3VDhXVGFhTkkxTzUrWXJONk85ME51a0dyZi9D?=
 =?utf-8?B?VHUrem9jUCt3SkhOR3BVNTBDKzl3TmRZQjZvdmlCRG9tbmhDVzFNeFR4WVJV?=
 =?utf-8?B?OG9aZU83Y1pFZ2x6c2J3aWFwdm0zdnQvRlRxOWg0YnFmbjNGS0JNcitRS0JF?=
 =?utf-8?B?elJUOHR2ZkNsZStaTkZUaE5MekIxNnExNExPWW5BK3J0YVFuQ1JRS0RWNFQy?=
 =?utf-8?B?MDFQaEVJdUdiUGgzZFppTHg1QlV5S0RlVnVIMVpCdEwwRnNKMGNpb25IMXJE?=
 =?utf-8?B?ZTV1WEIxelNtQkpNV0hhbE9rR2FHdEVrbkEwS1pIZzArVXpkMEhhUm5WeFdQ?=
 =?utf-8?B?SHpyamUxMlJqTTZlaWdHMGR1VUZEZUE1SjJnTk90dDlIak0vSGRKVk9ZVy9D?=
 =?utf-8?B?cVFSdllxYldNeklueTFFTmNrNE93L3MzVHFFbWZVV1lDM2JoakR6eGJEVGoy?=
 =?utf-8?B?TGJhQmU5WDYyOEVta3hrVHIzeGJ1MlJuaytEUHFpSVdGMjN2RU5FakwyS01E?=
 =?utf-8?B?MHJ2K3VKeWNISUhJUnJ0NndXd3Q2MVRZVkN3QW1MRXdTbTJSMjNQM2o1MTBS?=
 =?utf-8?B?b0dhcTZydHE0SlZkcU1ad0VsTGtwbVpuN0F0clFJRGJPdkx5MGx1TDlLdUhx?=
 =?utf-8?Q?kSXG16?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUZGY1dUaERManVOK2o4UXpaWnBOY0lxWU9ZUGcyYk80Y0FsRXpkenIwU2pK?=
 =?utf-8?B?TXFOSEYyWFREZzduSmlUNWQxdEhWV1M1MkRYM3dMU0l0M01ibzAveW5uMytw?=
 =?utf-8?B?OU9JRnFIZHBWYnk3c0RYQVNxL05DeVFXTkZlRmcrdDJyTnhON1ZUckFReEVD?=
 =?utf-8?B?Q1BLT3dRK2NzKzcwditHYlA1QTlwR0dmREh5MldCQTdqWURxMWxsYlRnekxa?=
 =?utf-8?B?ejVMYU9BTDdpUm0yMFByY3hyM1FOb09ZOWdqVDYxTHlBMHhxOTF4UmhpTzVV?=
 =?utf-8?B?UUVBUnI4VXE1VFlJV2wxbUxFUVcxVk9LdThIdG1lWjY4cUtvWG1HelZiR3dQ?=
 =?utf-8?B?aW9sa3hSSWdoNG1RdFBIZGgwaFo1QjVmaEI0dGxxOGEyUlg1U2o1NW5YeWNx?=
 =?utf-8?B?aDVZLzczUUd2NG1POU9QOU0wYTNvWlRDZHRWZEZiYVFBSWFmdEo1STF6bkhL?=
 =?utf-8?B?ZzBCcjJ3MzJ6bmYwakdGM1Q0TE5hL3c1ekh4cGFMbzQzeW85aDVSZHl4Wks0?=
 =?utf-8?B?SHUvdkhTQ1hEUUhzSHFITExoYm94MU95WDlISCsydk05VEdLaVFNc3dnZ0R6?=
 =?utf-8?B?RTRwb1BSQTlKRHBVdkNGMnlYSXdJMzR6UGYwOE5wYTZIMWxwV29SM0V2WjdX?=
 =?utf-8?B?MDh2Wnlsdkl2eVRqdXZSNi9DTFpib3EyWWk2QThoZ3RISDFLTWM5WlNrUXRW?=
 =?utf-8?B?UnlZdDRPL2hhaU00TXBud3NBRjNtMVI1M0Y1TzR2RzVONVhQTmRyMG5LZUJu?=
 =?utf-8?B?RngxK1RlOFJHTW9Va0gvejRTOW9oTFhOSHlsMHFEYlhPWVRMb3ZFV2lkVTBW?=
 =?utf-8?B?ZVdNY2Y3azBRKzVhRHZsYUNaSysvQlc0R3VPTEJ5aDVoT3Jzb3luOWJUM2dI?=
 =?utf-8?B?K243ckN2azE1M2E5VkwvU21GeTZhMGpkYU1Fek9jakJ3N1VIQ3pKcnFDWWNu?=
 =?utf-8?B?c01pY1JGOGNVejlkYTV4NnB0SlR0VlpnZjl5Q0hBMG4wNkZaVEZ6dE81R0RJ?=
 =?utf-8?B?anJrM3E3WFYzakE4dEpTYXoyWXk1dkJCbHRlMUlFdFBKWnVkNWFVWVF3UCtp?=
 =?utf-8?B?ZWo4dDJXMWFiUFdQcnJZL1dTT0hmeUR5Y1YxYmUzSVNFWXBYbWozOEVaTHJm?=
 =?utf-8?B?cncrSGpINTJxZGd5ZWRxQzB6dDdzT3FRdHFtL0tZaHhhZnNzNG4zYVBidHB4?=
 =?utf-8?B?RmJsMnQwaTNkeXlGT0kxR1QxTkVaRlU3dmZseWpHS3duNm54T202elJIUjZr?=
 =?utf-8?B?NnV6VmRCQ3dXQ2pROWNkamVGTldxUWpld0xzWGFoU25aZEp6OUtDMFdzN0FY?=
 =?utf-8?B?Z1VMRkZ6aWk3OHQ1djhmbE9wRzBVU0FOelFXbHFuanVBQUhTVGtoVHVVd3lp?=
 =?utf-8?B?SHNpdEVldXE0SE9qY3R6SEZpY3lRU1Q2bUFkb2Q0VjFFQWdONFNvbkhLYlMy?=
 =?utf-8?B?ZnNSZjdxT3NVclpkV011WVpHbmQvbTh0RUMwdUNPVXJVamNyK3cwVkEwTFMv?=
 =?utf-8?B?RVRPcVdBWjFKVU1CL20yMzdvWXcwaFZDSWlwTzlQWW5oWkNBNnZLY0pWblhk?=
 =?utf-8?B?WUM4ckIvYStidHFQa0d6QUIxU2FhaFc5RzF5bmVlT2hkVjlJRG1qREloMUxm?=
 =?utf-8?B?Y01RTzR2bG9HeEQ3cDdGcHlUSjlKQ2J1MmoxbzEvQVRXR2tqT0I2WHVjVjhW?=
 =?utf-8?B?QVFFSzFaYTg1RlVyenExUS9pL1dYT1RzUFBtOXBHMUs2MmdwOVQ5RkQrT0ZH?=
 =?utf-8?B?ck9tRER0dVdvYU5aMWlOOXVDN0h4UjZWN0Z5cndrVjZHWkkrd3loYXYxWlZS?=
 =?utf-8?B?aUFGWWNnYXdzaHpybjRWc2RKODltQlRVV3k2WFNjNTFOdGtKQkVOaXQxY3FF?=
 =?utf-8?B?OTVOZGFEY1l1S0VsZGt4eVA1NVZDaVlxTXZBalFwUE9GemhjV1hMalZ5VGJK?=
 =?utf-8?B?bmQyRVpHVk9LQmVEM216Z2tBY3AxS1ZqelY0V2VaZXdrN2IvZElYcXRMRHdo?=
 =?utf-8?B?YURSRm9sSWVEZVF2S29zdEo0VDJVcVF6QU9PQTFqaHV1UVE3NGFSaFUrMVVC?=
 =?utf-8?B?S2pvVlp4N040VFBDN1pPSldkUitvdTlmWldULzFlakI5bFUweWhOdi9nVGlY?=
 =?utf-8?B?cmxzTlZiL3JHQ3p3cGp4QSs4TW9NZGdVRlIrKytWdmViNFhJWTZ3Q0VKTkJB?=
 =?utf-8?B?UTI3d0R5ZDRaclQ5Nm5FRnoraTRxL3F2dUF2eVJ5NlY5dlVUbGNyR250M2c5?=
 =?utf-8?B?dWtDbG1VUVV1cHRmalBYSG9SYUVaNGw1eVVqTVFtWE1CQ3ViTUVDQ2Y2Q0Q2?=
 =?utf-8?B?TkFRQ1VDMlhDZzBMQk55OVh2M09yL3lMVkRkaitNZ0gzRHBMK25Xdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52114cd6-f2c9-4176-76c7-08de4c2b7ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 07:24:42.8490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3fgjVLeg1aemG6OqG05+3lMElW3lTvWihiCnx8Hjd4klcadqzQ9RdB+yxo0wso1H/ZtQecckJCxPo9kgz8jIDi0zI4o6h4cv/o00jdRq0cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6927
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

PiBTdWJqZWN0OiBbUEFUQ0ggMTAvMTldIGh3L2kzYy9kdy1pM2M6IFVzZSAzMiBiaXRzIG9uIE1N
SU8gd3JpdGVzDQo+IA0KPiBUaGUgcmVnaXN0ZXJzIGFyZSBvbmx5IDMyIGJpdHMgd2lkZSwgc28g
d2Ugc2hvdWxkIGNhc3QgdGhlIDY0LWJpdCB2YWx1ZSBwYXNzZWQgaW4NCj4gdG8gb25seSBiZSAz
MiBiaXRzIHdpZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2UgS29tbG9kaSA8a29tbG9kaUBn
b29nbGUuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBhdHJpY2sgVmVudHVyZSA8dmVudHVyZUBn
b29nbGUuY29tPg0KPiBSZXZpZXdlZC1ieTogVGl0dXMgUndhbnRhcmUgPHRpdHVzckBnb29nbGUu
Y29tPg0KPiAtLS0NCj4gIGh3L2kzYy9kdy1pM2MuYyB8IDUgKysrLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aHcvaTNjL2R3LWkzYy5jIGIvaHcvaTNjL2R3LWkzYy5jIGluZGV4IGJmNTFjMDA5MzUuLmVjZDc5
YWJhOGMNCj4gMTAwNjQ0DQo+IC0tLSBhL2h3L2kzYy9kdy1pM2MuYw0KPiArKysgYi9ody9pM2Mv
ZHctaTNjLmMNCj4gQEAgLTM4MCwxMCArMzgwLDExIEBAIHN0YXRpYyB2b2lkIGR3X2kzY193cml0
ZSh2b2lkICpvcGFxdWUsIGh3YWRkcg0KPiBvZmZzZXQsIHVpbnQ2NF90IHZhbHVlLCAgew0KPiAg
ICAgIERXSTNDICpzID0gRFdfSTNDKG9wYXF1ZSk7DQo+ICAgICAgdWludDMyX3QgYWRkciA9IG9m
ZnNldCA+PiAyOw0KPiArICAgIHVpbnQzMl90IHZhbDMyID0gKHVpbnQzMl90KXZhbHVlOw0KPiAN
Cj4gICAgICB0cmFjZV9kd19pM2Nfd3JpdGUocy0+aWQsIG9mZnNldCwgdmFsdWUpOw0KPiANCj4g
LSAgICB2YWx1ZSAmPSB+ZHdfaTNjX3JvW2FkZHJdOw0KPiArICAgIHZhbDMyICY9IH5kd19pM2Nf
cm9bYWRkcl07DQo+ICAgICAgc3dpdGNoIChhZGRyKSB7DQo+ICAgICAgY2FzZSBSX0hXX0NBUEFC
SUxJVFk6DQo+ICAgICAgY2FzZSBSX1JFU1BPTlNFX1FVRVVFX1BPUlQ6DQo+IEBAIC00MDksNyAr
NDEwLDcgQEAgc3RhdGljIHZvaWQgZHdfaTNjX3dyaXRlKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIG9m
ZnNldCwNCj4gdWludDY0X3QgdmFsdWUsDQo+ICAgICAgY2FzZSBSX1JFU0VUX0NUUkw6DQo+ICAg
ICAgICAgIGJyZWFrOw0KPiAgICAgIGRlZmF1bHQ6DQo+IC0gICAgICAgIHMtPnJlZ3NbYWRkcl0g
PSB2YWx1ZTsNCj4gKyAgICAgICAgcy0+cmVnc1thZGRyXSA9IHZhbDMyOw0KPiAgICAgICAgICBi
cmVhazsNCj4gICAgICB9DQo+ICB9DQo+IC0tDQo+IDIuNTAuMC5yYzEuNTkxLmc5Yzk1ZjE3ZjY0
LWdvb2cNCg0KUmV2aWV3ZWQtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29t
Pg0KDQpUaGFua3MsDQpKYW1pbg0K

