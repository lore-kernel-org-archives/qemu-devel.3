Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D1BCCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 09:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6mnS-0000Tc-Gw; Thu, 09 Oct 2025 05:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1v6mnQ-0000Qo-P5; Thu, 09 Oct 2025 05:18:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1v6mnM-0007YU-1V; Thu, 09 Oct 2025 05:18:48 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5997u9Q0021467;
 Thu, 9 Oct 2025 09:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=oEM9CXp0V+DDXRaQh79R4dogzcwOcSGjQISYHgJwlns=; b=
 A5Bmu4E9szVbmn8SDapO6bL0qSYW2JJdIw0mn5w73rETJTEjOXVq2Iiosp0UKWnT
 jXrrbTNltU5Mm8VQqJ9FENMcswodkaELc/y0IraipJiaT6zASk2guZBsU8RHxq7F
 j3DDjgcMrr3G+yl7wMOQ24MthnoAEv3itvK+iGy01ajZzXnmuHhQBrtK6XNBN6eo
 p6V9w45HkstcHi112XSn3Y7a7z2ffeYiEXG6L+P8yMgDH9GookNOpfz84i9JErws
 2fvBYPTYOAeg7tjQQ6SZI+QxE4Ix7wHuazneyAfjkccHG9dR+sd+Xh6Bbn1N2DaQ
 H/lbNnHxhKn3RW3cK2X3vg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6d17qu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Oct 2025 09:17:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59979oml036587; Thu, 9 Oct 2025 09:17:40 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49nv67cak7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Oct 2025 09:17:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEO+qS6+VJUPfaDIcir5tL9htOKRImKy5U1qOPjXxehpTJd7KBtumT00biBfiZDhnN3hnSeI0kaup3JFz769/8J+bvCFtBmRXASZtZ97hcgTKkZgnl9JS3+cOeWAcQmDi0yCZPc6ITQJd0lmvmnDFpWec2/AmdBWFvNWfUf6/ethboA/gG+gb7VdVXs+Yhr0sdW47OH3GIRhqpmio6m/jzCnbnOvFwjlebWL61n9+P+fDIkEcxbgIRxGdnOW1VAKnmTGcYG/xIk7/XnoyzBGRWvWvfTNLKW7cYmlKB8Gq2wpgLQn05JDCiYPDXhtDo18QII0vZ+86CG+zVrPBPEYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEM9CXp0V+DDXRaQh79R4dogzcwOcSGjQISYHgJwlns=;
 b=bHouPhaDChehRugCK/M9kWM55yRqkMKvkdMnVGYSQI31TvN9QQDxdCKoE0BwpW88yjlGO37+qdhoLhZh2XCpUPf3gt2YGw2MMkv3fD8XkVJkGHnKa9CtjzVcoFP5CSnTi3+qTWfXUs4U4Xi2LStEqp3699MuU1CqUMSy97vKmM7bnnBKCctPQLjo8MgtA8Kn3oS6Qs4E9+vCiafZKTkZuPVDLvwD53NL4uWiTzHTigT0B2eCuu7j0IUzaR5HAYpK8V/Q/mUIsyRzLxB3nbTNDLQf9rpa+Lwst9tNfGIUl64b0w/0L5UGR5AFYYzoOAVEioEmB+ra4pZHu/Ls1E/Gkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEM9CXp0V+DDXRaQh79R4dogzcwOcSGjQISYHgJwlns=;
 b=uyhbNWTJExl2hvqON23f/WMUg0mxKDLr2XhDf/0cWj6S5Sz4AMC5BjJncROS8iIoDJ989FkTLOdS8X9WZcDXPoD2T8ZYpSU7Pnus5jK/w8tBR3ekBOjSiwGU3ETfdDTOkkY4K16YFI41f61U0nvhsIY8jLXesVbQI5Ob2GpO1JI=
Received: from PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22)
 by IA3PR10MB8491.namprd10.prod.outlook.com (2603:10b6:208:576::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 9 Oct
 2025 09:17:26 +0000
Received: from PH0PR10MB5894.namprd10.prod.outlook.com
 ([fe80::75ce:9a39:e0cc:96f7]) by PH0PR10MB5894.namprd10.prod.outlook.com
 ([fe80::75ce:9a39:e0cc:96f7%5]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 09:17:26 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Markus Armbruster <armbru@redhat.com>
CC: Salil Mehta <salil.mehta@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>,
 Karl Heubaum <karl.heubaum@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, "zhukeqian1@huawei.com"
 <zhukeqian1@huawei.com>, "wangxiongfeng2@huawei.com"
 <wangxiongfeng2@huawei.com>, "wangyanan55@huawei.com"
 <wangyanan55@huawei.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>
Subject: Re: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like Feature
 for ARMv8+ Arch
Thread-Topic: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like Feature
 for ARMv8+ Arch
Thread-Index: AQHcMltnamnUQRT3aE2PGbO30B0W17S4OwBpgAA6mYCAAOS8o4AAO/WA
Date: Thu, 9 Oct 2025 09:17:26 +0000
Message-ID: <FC06F103-13EB-4928-8170-310E0675416B@oracle.com>
References: <20250930224037.224833-1-salil.mehta@huawei.com>
 <871pndlgi7.fsf@pond.sub.org>
 <6A8391B8-5E75-49B0-834B-00183BA4CF3E@oracle.com>
 <87bjmgiqbx.fsf@pond.sub.org>
In-Reply-To: <87bjmgiqbx.fsf@pond.sub.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5894:EE_|IA3PR10MB8491:EE_
x-ms-office365-filtering-correlation-id: 9ab47afc-a46f-42b5-2a86-08de0714a9b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dU1PaHhjYU9hYUlwY2FjZmZ0ZDg4VXRzNnYybFVnYTRiVTRQSlh3aTJldnhj?=
 =?utf-8?B?Zm1taFFhN3F1VkpQNTY2ZksrVkhDZWVENkNtVWpGMkp2QnBsRmRRNFdYR0FP?=
 =?utf-8?B?Sm9lYjh5cllVVjVBNDdaUmdIc0hYWTg0VjlOUGtwZ3E4bmZ6VzJuRjQ0RGJT?=
 =?utf-8?B?QlpPNTNLNy9uUytRNFJuTFArS2NJbEdNaWFGUDN6Ukp2dWN0TXdTWVM2d0oz?=
 =?utf-8?B?TVZoU1pTbVovc3ljQm1LUWFiOCtyOW91WlpzSlhGZGpCMnNRMGZyRllYZnVh?=
 =?utf-8?B?NGRIRHRreFdxVG1DWXpmbUlUQlRLMnNXSTNLWmtBa3dMM0NDeU9RcXFsZnBk?=
 =?utf-8?B?RHhvTUtDMmJiUWJXYlJESTNuMVlWbDk4WW85Y0o2eEQxdlBLd25xV0hobVZa?=
 =?utf-8?B?c1hvQjlxVnpQcEswVDJjNnNibkFDdStLWnpVVHZ6UlRKa2N0bHU3OVhDcjli?=
 =?utf-8?B?UFE2U1owck1rY0J2MGpYT2cramZoODhmRjRzWS81Sjd6WU9zelNuSU9MTWl5?=
 =?utf-8?B?NGRucmYyUEZOSnQxckdVYStUSk1GbFBNekQxelhxWHVWVDBQa2hjbUNMdzNL?=
 =?utf-8?B?bDNlQy82TXQ0cXJPdk9ZVFJRTUhkYmpGYXpHV0lOMW5GK2pLYmprWDcyQVgy?=
 =?utf-8?B?bUJSSXVNOHdYaUJnSUhNMm5CMmNSUWNZZm1HOWlZTWNuVjhkRzYra1cyTEkw?=
 =?utf-8?B?OTdYdjlMSjRRVEZqS0V2SUNxZ2RjY3YySjM3UVg2Z001YllEVTVDNGlZYUMw?=
 =?utf-8?B?a0N6dS9rRnRyWUN0dzhuYTRmNDRGYmg4ZnRMaC9hUGZUbm0vaVhjenNqU2gw?=
 =?utf-8?B?bFlXVTRwenlhWVZkaHBOMlc3SHlwdDkxUkZGVTRpSHN0SmFVYUEra2I2MnRV?=
 =?utf-8?B?aEE4a0xHekkrOXJZRWtoK3RZSVMxVGpPeUZEeGF5czMrWWdwUjgrV3RCd21P?=
 =?utf-8?B?TVFrK3JDT2trc1lGZlY5LzRwL0tZU0tZZGIxVTdRT2NpWlZ6dCtTcGlod0F1?=
 =?utf-8?B?S3MxRmNhQUZsbStHaTVFVVFwWUpVeGlhZ3VhYjhpZGptbk5zUzJlODU2Nko4?=
 =?utf-8?B?MmFvcUNZUmQvZHhIclF2ZlF2cC9qUThOSDhYUXhWM1pFcVhNckkyYlpWZHU2?=
 =?utf-8?B?bHpVcHB6UkNnSzlxck1UTnN1OHNoMGUwTWgwTXltdkxGUW5NTkpFY1hoSURW?=
 =?utf-8?B?NE04aGNqSmg2YWZvUE1ObFFnQm5MUnRMcjI1U29HUVBpeHgxRGhNRUZ1WFBm?=
 =?utf-8?B?ZzgyU0tmRTlURGpxeml2U3RSTHMzekE4cHJxZFBWbnlOdUc4NDIxNDFNL1pw?=
 =?utf-8?B?d2NWUElmVzJJd3RjWVFYSG96ZS9KMkFaeWtKYU81bzRYK1JVSnN4YmZ5YUsv?=
 =?utf-8?B?Sy95Z01jNzVRdXBGSFA2cnBUOCtZdUZTeGUvcXlFRWFoUm5hNzlxVTFPR1hZ?=
 =?utf-8?B?RTFPWk1GbnJqR0dBTUsxdlZCaStIazRnTEJId0g3RExrYnBaM3UyaEFZdjl2?=
 =?utf-8?B?SUp1N0VteURLNlRQVmpLVlAxa3lnZm1SRFNrb3RJdUVSdmZQSUoxQ3ZINjc0?=
 =?utf-8?B?RmdlZytnVTJoTUlZV0tRTytOazVOY1BkSTdpWERjanFoemdUb0h2ZmViQUp0?=
 =?utf-8?B?OEltanBHNEFSSzkvOVFjaE1tYTBON0xiRjFJOXZqZmIzU3ZacGQ0SjRIY1Jj?=
 =?utf-8?B?L0VGQnY0a3VHSGlUMjd5WXdHcEhOZTdFdzVKc21YN21LK3RaaTVlOUFOYlRF?=
 =?utf-8?B?NldOWUc3V1REYzkyLzhxRGw3cDRXMVpRb0UwMTh2OWIzcFlFSjlpa1FoNVFn?=
 =?utf-8?B?YWZ6SFo0THkycE9wd0p5akxFMlNpbzhabEp4cGdzcVEvMmYwWVJWRmcrWjhq?=
 =?utf-8?B?QTJVc1JsNHVVb1pINHdRSzNJQTFRYUNUeG8xSFhUMDljRkt3ZzBjVnVnSCs1?=
 =?utf-8?B?Lytmd0RUTnMyNkdrZzZUM0JNbzlKSFpuNjkvLzE2UkFXeCt3ZE1oa3NaMEg5?=
 =?utf-8?B?OFdMOWt5cDdKeDlyNFplZVBpdFlsTS80LzlLVk5HelFSd24xaXVCUmJQRjdR?=
 =?utf-8?Q?Mm8YzI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5894.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzFmMHN1aCtGc2dvRHN3U0hjbERCVkhMcUVXZm92WmxEd2Z2cElXM2NCOVNZ?=
 =?utf-8?B?ZEtHMEo4QUNvK0poc0VJYWh3elBUSzBLaWxqSW9FSFd2K0xmbVBoY1E3T3lw?=
 =?utf-8?B?U01qUEFCYXVrQjRxZkJCMVRha0hSWU9QTHB2aVpoZDBQcCtLd0VNS1BrNi9U?=
 =?utf-8?B?RHRNdVpXOUNIT00ydWhvUmlFTFpIR1dMNWVyazZsN3RuV2d4OHhsQVhlblQ3?=
 =?utf-8?B?QWI2WnZNL1c2bnQxeHo3TVFmVWtONW1HS0h3QmdJUXY4bWlJZlNCNnV2Wnhl?=
 =?utf-8?B?SHlLSG1ZK0R0ajJab0NaNUpzNHUwMHNaWHh4K2xyb1FEWU8xSy9RVzI4cjB3?=
 =?utf-8?B?Y29zUGJBb2c4Y0VhZVVBeFJXRmtSWkpIWm9KTnhlRGhlczhZTlJCa3lXNTN5?=
 =?utf-8?B?WlVWNzVtMHJUYUZtZjlnbXV4TE9qaCtHQlJVLzRlR3UvNW9OalYxa3ZiZ3hP?=
 =?utf-8?B?cVB2QTFsa01tSitlYU03Rlh6QnNDTzAwaHBNUXd2a2p3TElGRlg5MSt4MUNY?=
 =?utf-8?B?S2NtN3F3MXdXUU1YeGRVQVpFVW9QSDBZdUJwK0VMUnVlRW9Qc2NpK3hCRjZi?=
 =?utf-8?B?UjNveDN0OU1nZnpkdjZOdjJYNm1HZXlHSXJkdFgwUmRwSWtKeTQ3UlFMaS96?=
 =?utf-8?B?dUpadmFydXQwVm5ES21RZG5qTnREN1Nvc0R2UkgvM2pSSXFzMnhDVUVsUGoy?=
 =?utf-8?B?YUpUdEpzdjVLbXMyMVk3N0NSRElKcU9sTFY5UGNOZFZnL3NRMStPM09EdVdB?=
 =?utf-8?B?N2NqdHNyVEI1anVrN1JhNW9hNU5xMXJVL0pGYVd5d1lTNFJSZHBWZmJrMG5x?=
 =?utf-8?B?VTBuK0YrOE9OYjMxNXBacThWTkM0SFhrRGhVcUVEL1FyUmxWa3NYbytnTWpz?=
 =?utf-8?B?Z202UWxMaWNrQ3dWUUsxRDV0VlRYdHdxeDlFckVOV1dNUGdRR1M2U2Uzam81?=
 =?utf-8?B?czJiU1h5Z3RiT1VqTHhJUG1KQmNoeWxwWTVrTGo0bytBb0k1TE02QXJyZnNa?=
 =?utf-8?B?S2NuUEJaOXJsRmhpQU9tekxzdkxicXZ3TFhPTmNSZjBhdEdGWjdoYVBYdTBu?=
 =?utf-8?B?cDRmL2FPcXFWVjVuQlVwTzF0S3dLVlhLdVF3YjJ6LzFnT1ZMKzFlVFhTeGJy?=
 =?utf-8?B?clRoWmFwV1dyL0sxaC9Ua29RYUg1Z1dVU3ZhaVdIZUMxUXZaSThmeE9Ec3NK?=
 =?utf-8?B?eXR2Y21jWkhMSEh0WWdUSU5WRDhCeEx0VFdWRzhNelFRZEVPRUZFei9pTkJQ?=
 =?utf-8?B?Y2g0dXY1MU1QemF2YTRwVnhsK0pvSmNBOEd3MEtTd0lJY1c2dkdGdlhXZFdC?=
 =?utf-8?B?akRvZ2kwQ0xVS0pkQUlreWNiNEpMY2JZTkhlK2Z1MEx1d240NUFiTDFTc3Vr?=
 =?utf-8?B?RnVTOFBsQ285b3crVlZtNWNUd3o1bS9wUE1QRDNwek94OEhPVmRPb3pMc1NI?=
 =?utf-8?B?MlBYWFRkd0dVUUpzL0h6enVJTFVUNnZpeVQ1ZTkwSHFrRVNPYnhwMVU0WC9Y?=
 =?utf-8?B?aGJDUTYxS1dqTDRydm9ZSUVEcy92RjNpbTRhUzdTK0gwQmNZSTRNdTg4dGQ2?=
 =?utf-8?B?K2pFbGQySG93RlNSWG9YWGdLV1JIN2Q2TjNxYURiN0tUNlZCNDk3R2s1czMv?=
 =?utf-8?B?bEUwSm16QmEyanFoWFVjaitMeEpENlpSSDFiVnpUY3BjeW5Cc3RXMFVFU2lz?=
 =?utf-8?B?UzRvUjBFbDZDQ1k0dGFjNlo5TmJ1Z0NObWpIbXdSYXlUcFFkUVdPZlkydVBj?=
 =?utf-8?B?eFBwNVoxYnFhWXAzajZHWFZYVjlPQnFPWnIzbmZmelhzMkxlMzlhOUhZT2FL?=
 =?utf-8?B?MVZqUkwwSXpKM2VqUlRVekhORDluTUkwVFpTSVRHZklidmNOZzgrMTFNaXZV?=
 =?utf-8?B?clpBL0dUR1lpSnZlZ3pKeXd6SVZpcGhlVm1HZUJIT1pxSDhSOHFqVWJEbWFn?=
 =?utf-8?B?SjQ3TFQzSnAyd3Q1U3U2RzBKN3RhclNwU1FZQkpMYU1XUzRTZkh4ZndZUHRz?=
 =?utf-8?B?Zkd3SHhHR3NwUVpiMyt2R1ljQzhXM21VSysxS2hMczhZUFpEMlhVWmp6czNP?=
 =?utf-8?B?enhUK2RyNVlwRE1vemh3SUNNQjVqcUJ1VG04SW9mNnZKREVybnZvZ0F4TTY1?=
 =?utf-8?B?V3p5dlo4VXF4YXo1czZ3dXg3QS95VVlLT2ZYd0lZRHFkT3FOSnBnTzc3U2dV?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <309442733932794A970DB78AB7D9EB79@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1fRuXep6BzV5XIKipP+3xYUw3gBMsaghcu1YAjkeTM4Lb+Ul1nLqDSq+l+B3RpruG8rLy3GIz/YcwtY6iiGiP1VM/VBaZ0o/JOZ7d4kivkinoL5Fw9NZYfGVyC2J2q4Yvsq3YUgyGo9cvZr4H6GWMlHKL1isndZsK9gzOOUI5BCEtj4VDSnFXzU98y69TG6euqpuVsYupQyOwM7ClKW8p4Ht0k7cqvGeB/8SGsBlCc8F1iOQkGqdkwZz1vXx8OjVAojuib4IS7KDJq+sEXbCukHgwb2NjQGrF96nVAePhk+IYoTPj7EIDS/JHO5AV2JKNFWfSEB15ZuTbERRxuSaGtAqj8mElJ5522KoVLwTyMRjMHUAcb1nk8KC9oTJKpZN58vemDCKuLK9+Qtk/Rnwc62V8wFf5cn/OUdx3KcuR8rUYbyfr7eYtC+seidwcynaYBE+NNlaJc70n9wBu1kKuwr4RA+vI46kL11EZrJBAMp2KRsEOHi9gIal35hMYM5jEnl8aHRCXYygQMXc5TXzaC0i9lChVDV3SCFm+Hiv1re772QlvLoPUVfqsqI51OL7WtLHBgwhZgT7yHarYUY3LdxCcESKDvFHMiuxgERZnyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5894.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab47afc-a46f-42b5-2a86-08de0714a9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 09:17:26.0364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sidw+dKa2dHuW+qmt0PlkMTv8uiCOTn4rsTICL4DQQ2VySx8Ynf5qpwIDwqAr1kpU9cYt15jT81/oYlUXZcKxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090052
X-Proofpoint-ORIG-GUID: mMPomzLzt0LpK0eiTrHBxkss8oUoRke4
X-Authority-Analysis: v=2.4 cv=bK4b4f+Z c=1 sm=1 tr=0 ts=68e77db5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=i0EeH86SAAAA:8
 a=C93WrAUGXKHK51LYCMUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mMPomzLzt0LpK0eiTrHBxkss8oUoRke4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5DgU+XJNUv7x
 RVtcva8RY9eGKUvjC47zXf2bE56oeuCpLKicrShOqSP4ZyFa6TsARkn3Kqisi7UbB0R7DQy3FG4
 w0XvJ4i7dcqU8ggHJGLMQq3jPKF5kaZmNNygEwr0Fo6zt5eFE/+ou7N0HupVJR/cp9pIjbEyMNW
 AZYNgROP4b5Jx8aDI2ElMhiLIxfu3Xjderhjvbsdxrc3EAJ8BkZbr2Q/bBm0F6VzwD/IlaCH/xP
 /h3i5rWiZmb6oSZQRagYQiPGhmy4E3vglWVVn81YotuBMRdZKr8qHY6xB4KW6AHEKjRQqHhJlSj
 jSHtutR6TidlHI8FgUGJE+nn3cf76vPfGoeb/GwUDIv2SopfCZ2f74saBzd52it7p70b6+hOT+w
 KnGbygYLIbEYwWs6qbg2cz8W8Ymm8A==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gOSBPY3QgMjAyNSwgYXQgMDU6NDIsIE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xl
LmNvbT4gd3JpdGVzOg0KPiANCj4+IEhpIE1hcmt1cywNCj4+IA0KPj4+IE9uIDggT2N0IDIwMjUs
IGF0IDEyOjMzLCBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+IHdyb3RlOg0K
Pj4+IA0KPj4+IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPiB3cml0ZXM6DQo+
Pj4gDQo+Pj4gWy4uLl0NCj4+PiANCj4+Pj4gPT09PT09PT09PT09PT09PT09PQ0KPj4+PiAoVklJ
SSkgUmVwb3NpdG9yaWVzDQo+Pj4+ID09PT09PT09PT09PT09PT09PT0NCj4+Pj4gDQo+Pj4+ICgq
KSBMYXRlc3QgUWVtdSBSRkMgVjYgKEFyY2hpdGVjdHVyZSBTcGVjaWZpYykgcGF0Y2ggc2V0Og0K
Pj4+PiAgIGh0dHBzOi8vZ2l0aHViLmNvbS9zYWxpbC1tZWh0YS9xZW11LmdpdCB2aXJ0LWNwdWhw
LWFybXY4L3JmYy12Ng0KPj4+IA0KPj4+IERvZXMgbm90IGNvbXBpbGUgZm9yIG1lICh4ODZfNjQg
Ym94IHJ1bm5pbmcgRmVkb3JhIDQxKToNCj4+PiANCj4+PiAgIFsuLi5dDQo+Pj4gDQo+Pj4gICBG
QUlMRUQ6IHFlbXUtc3lzdGVtLWxvb25nYXJjaDY0IA0KPj4+ICAgY2MgLW02NCBAcWVtdS1zeXN0
ZW0tbG9vbmdhcmNoNjQucnNwDQo+Pj4gICAvdXNyL2Jpbi9sZDogbGlic3lzdGVtLmEucC9od19h
Y3BpX2dlbmVyaWNfZXZlbnRfZGV2aWNlLmMubzooLmRhdGEucmVsKzB4NTApOiB1bmRlZmluZWQg
cmVmZXJlbmNlIHRvIGB2bXN0YXRlX2NwdV9vc3BtX3N0YXRlJw0KPj4+ICAgY29sbGVjdDI6IGVy
cm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzDQo+Pj4gICBbNjc1Ny83MjMyXSBMaW5raW5n
IHRhcmdldCBxZW11LXN5c3RlbS1taXBzNjQNCj4+PiAgIFs2NzU4LzcyMzJdIEdlbmVyYXRpbmcg
ZG9jcy9RRU1VIG1hbnVhbCB3aXRoIGEgY3VzdG9tIGNvbW1hbmQNCj4+PiAgIEZBSUxFRDogZG9j
cy9kb2NzLnN0YW1wIA0KPj4+ICAgL3Vzci9iaW4vZW52IENPTkZESVI9ZXRjL3FlbXUgL3dvcmsv
YXJtYnJ1L3FlbXUvYmxkL3B5dmVudi9iaW4vc3BoaW54LWJ1aWxkIC1xIC1XIC1Ea2VybmVsZG9j
X3dlcnJvcj0xIC1qIGF1dG8gLUR2ZXJzaW9uPTEwLjEuNTAgLURyZWxlYXNlPSAtRGRlcGZpbGU9
ZG9jcy9kb2NzLmQgLURkZXBmaWxlX3N0YW1wPWRvY3MvZG9jcy5zdGFtcCAtYiBodG1sIC1kIC93
b3JrL2FybWJydS9xZW11L2JsZC9kb2NzL21hbnVhbC5wIC93b3JrL2FybWJydS9xZW11L2RvY3Mg
L3dvcmsvYXJtYnJ1L3FlbXUvYmxkL2RvY3MvbWFudWFsDQo+Pj4gICAvd29yay9hcm1icnUvcWVt
dS9kb2NzLy4uL2luY2x1ZGUvaHcvcWRldi1jb3JlLmg6MTkwOiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdhZG1pbl9wb3dlcl9zdGF0ZV9zdXBwb3J0ZWQnIG5vdCBkZXNj
cmliZWQgaW4gJ0RldmljZUNsYXNzJw0KPj4+ICAgL3dvcmsvYXJtYnJ1L3FlbXUvZG9jcy8uLi9p
bmNsdWRlL2h3L3FkZXYtY29yZS5oOjI2OTogd2FybmluZzogRW51bSB2YWx1ZSAnREVWSUNFX0FE
TUlOX1BPV0VSX1NUQVRFX0VOQUJMRUQnIG5vdCBkZXNjcmliZWQgaW4gZW51bSAnRGV2aWNlQWRt
aW5Qb3dlclN0YXRlJw0KPj4+ICAgL3dvcmsvYXJtYnJ1L3FlbXUvZG9jcy8uLi9pbmNsdWRlL2h3
L3FkZXYtY29yZS5oOjI2OTogd2FybmluZzogRW51bSB2YWx1ZSAnREVWSUNFX0FETUlOX1BPV0VS
X1NUQVRFX0RJU0FCTEVEJyBub3QgZGVzY3JpYmVkIGluIGVudW0gJ0RldmljZUFkbWluUG93ZXJT
dGF0ZScNCj4+PiAgIC93b3JrL2FybWJydS9xZW11L2RvY3MvLi4vaW5jbHVkZS9ody9xZGV2LWNv
cmUuaDoyNjk6IHdhcm5pbmc6IEVudW0gdmFsdWUgJ0RFVklDRV9BRE1JTl9QT1dFUl9TVEFURV9S
RU1PVkVEJyBub3QgZGVzY3JpYmVkIGluIGVudW0gJ0RldmljZUFkbWluUG93ZXJTdGF0ZScNCj4+
PiAgIC93b3JrL2FybWJydS9xZW11L2RvY3MvLi4vaW5jbHVkZS9ody9xZGV2LWNvcmUuaDoyNjk6
IHdhcm5pbmc6IEVudW0gdmFsdWUgJ0RFVklDRV9BRE1JTl9QT1dFUl9TVEFURV9NQVgnIG5vdCBk
ZXNjcmliZWQgaW4gZW51bSAnRGV2aWNlQWRtaW5Qb3dlclN0YXRlJw0KPj4+ICAgMSB3YXJuaW5n
cyBhcyBFcnJvcnMNCj4+PiANCj4+PiAgIFdhcm5pbmcsIHRyZWF0ZWQgYXMgZXJyb3I6DQo+Pj4g
ICBrZXJuZWwtZG9jICdwZXJsIC93b3JrL2FybWJydS9xZW11L2RvY3MvLi4vc2NyaXB0cy9rZXJu
ZWwtZG9jIC1yc3QgLWVuYWJsZS1saW5lbm8gLXNwaGlueC12ZXJzaW9uIDcuMy43IC1XZXJyb3Ig
L3dvcmsvYXJtYnJ1L3FlbXUvZG9jcy8uLi9pbmNsdWRlL2h3L3FkZXYtY29yZS5oJyBmYWlsZWQg
d2l0aCByZXR1cm4gY29kZSAxDQo+Pj4gICBbNjc1OS83MjMyXSBMaW5raW5nIHRhcmdldCBxZW11
LXN5c3RlbS1pMzg2DQo+Pj4gICBGQUlMRUQ6IHFlbXUtc3lzdGVtLWkzODYgDQo+Pj4gICBjYyAt
bTY0IEBxZW11LXN5c3RlbS1pMzg2LnJzcA0KPj4+ICAgL3Vzci9iaW4vbGQ6IGxpYnN5c3RlbS5h
LnAvaHdfYWNwaV9nZW5lcmljX2V2ZW50X2RldmljZS5jLm86KC5kYXRhLnJlbCsweDUwKTogdW5k
ZWZpbmVkIHJlZmVyZW5jZSB0byBgdm1zdGF0ZV9jcHVfb3NwbV9zdGF0ZScNCj4+PiAgIGNvbGxl
Y3QyOiBlcnJvcjogbGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1cw0KPj4+IA0KPj4+ICAgWy4uLl0N
Cj4+PiANCj4+PiAgIFs2ODc0LzcyMzJdIExpbmtpbmcgdGFyZ2V0IHFlbXUtc3lzdGVtLXg4Nl82
NA0KPj4+ICAgRkFJTEVEOiBxZW11LXN5c3RlbS14ODZfNjQgDQo+Pj4gICBjYyAtbTY0IEBxZW11
LXN5c3RlbS14ODZfNjQucnNwDQo+Pj4gICAvdXNyL2Jpbi9sZDogbGlic3lzdGVtLmEucC9od19h
Y3BpX2dlbmVyaWNfZXZlbnRfZGV2aWNlLmMubzooLmRhdGEucmVsKzB4NTApOiB1bmRlZmluZWQg
cmVmZXJlbmNlIHRvIGB2bXN0YXRlX2NwdV9vc3BtX3N0YXRlJw0KPj4+ICAgY29sbGVjdDI6IGVy
cm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzDQo+Pj4gDQo+PiANCj4+IEnigJl2ZSBoYWQg
dGhhdCBzYW1lIGlzc3VlIGFsdGhvdWdoIGl0IGdvdCBjb21waWxlZCBmb3IgbWUgYWRkaW5nIEFD
UElfQ1BVX09TUE1fSU5URVJGQUNFIGZvciBNSUNST1ZNOg0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9LY29uZmlnIGIvaHcvaTM4Ni9LY29uZmlnDQo+PiBpbmRleCAzYTBlMmI4ZWJiLi4y
OWQ5YjA5NDg2IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9LY29uZmlnDQo+PiArKysgYi9ody9p
Mzg2L0tjb25maWcNCj4+IEBAIC0xMzMsNiArMTMzLDcgQEAgY29uZmlnIE1JQ1JPVk0NCj4+ICAg
ICBzZWxlY3QgVklSVElPX01NSU8NCj4+ICAgICBzZWxlY3QgQUNQSV9QQ0kNCj4+ICAgICBzZWxl
Y3QgQUNQSV9IV19SRURVQ0VEDQo+PiArICAgIHNlbGVjdCBBQ1BJX0NQVV9PU1BNX0lOVEVSRkFD
RQ0KPj4gICAgIHNlbGVjdCBQQ0lfRVhQUkVTU19HRU5FUklDX0JSSURHRQ0KPj4gICAgIHNlbGVj
dCBVU0JfWEhDSV9TWVNCVVMNCj4+ICAgICBzZWxlY3QgSTgyNTQNCj4+IA0KPj4gTWlndWVsDQo+
IA0KPiBUaGFua3MgZm9yIHRoZSBoaW50LiAgSSBhZGRpdGlvbmFsbHkgbmVlZCBhIHNpbWlsYXIg
Y2hhbmdlIHRvDQo+IGh3L2xvb25nYXJjaC9LY29uZmlnLCBhbmQgY29tbWVudCBoYWNrZXJ5IGlu
IGh3L3FkZXYtY29yZS5oLg0KDQpJdCBzZWVtcyB0aGF0IGV2ZXJ5IGFyY2ggc2VsZWN0aW5nIEFD
UElfSFdfUkVEVUNFRCBtdXN0IGFsc28gc2VsZWN0IEFDUElfQ1BVX09TUE1fSU5URVJGQUNFIG9y
IGl0IGZhaWxzIGJ1aWxkaW5nIG90aGVyd2lzZS4NCg0KPiANCj4+IA0KPj4+ICAgWy4uLl0NCj4+
PiANCj4+PiAgIG5pbmphOiBidWlsZCBzdG9wcGVkOiBjYW5ub3QgbWFrZSBwcm9ncmVzcyBkdWUg
dG8gcHJldmlvdXMgZXJyb3JzLg0KPj4+ICAgbWFrZTogKioqIFtNYWtlZmlsZToxNjg6IHJ1bi1u
aW5qYV0gRXJyb3IgMQ0KPj4+ICAgbWFrZTogVGFyZ2V0ICdhbGwnIG5vdCByZW1hZGUgYmVjYXVz
ZSBvZiBlcnJvcnMuDQo+Pj4gICBtYWtlOiBMZWF2aW5nIGRpcmVjdG9yeSAnL3dvcmsvYXJtYnJ1
L3FlbXUvYmxkJw0KPj4+IA0KPj4+IFsuLi5dDQo+Pj4gDQo+IA0KDQo=

