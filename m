Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3437C3DA4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 19:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRz2k-000370-IE; Thu, 11 Jul 2024 15:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRz2c-00036K-0q
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 15:01:18 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRz2T-0007tV-DX
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 15:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720724470; x=1752260470;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xwJVeJ4DBDeJzO8VydTsFy2qUxmsCI8DEgSWdr+CxjM=;
 b=kBnUgd1ZI9K3Xd93pCuvgMeOxTSQOCEp/rN92esiwSOjZubmI4I/Y68q
 geDVEWfGLNtEodLHmfB4JkTCAZ/RIk0hNlMckv4xDi8BtW1YG85E4oTHt
 7R7pO8eindl1T35NyccjfZuz6VPGVjdqUKtXdLGYqSrrPCyvI6qywZQZZ
 iXpeGXhwRvc+VmQb8QSC3tf4zi1iTDEyBd5i69wkTc9STj0s0htRp3trK
 uWTcKzyAUHiGtuPVyUi+uzGsWVXo21mNiTek98RdeuyVgZ7vdrn5uCUPh
 B+OxtYYV94JsoY+8eTd8v45Q0KjVuFmbgHTNLZcPxPlybKrqPmXtIjz+Q g==;
X-IronPort-AV: E=Sophos;i="6.09,201,1716242400"; d="scan'208";a="16319422"
X-MGA-submission: =?us-ascii?q?MDF4C6V5xNbpWL1xHypq6rBufa7lY0/bht6lAH?=
 =?us-ascii?q?lqC9xnFSZ+a2qxPMAIVjPDYNxxMWs5cbOZj5s2ouZYKovb8IGEF7HZ7Y?=
 =?us-ascii?q?FfLc0IbrmliqiAlWZB1ZBm9tPTWYpiBBznhXdX/SDhMO/7lgVDT1SlFX?=
 =?us-ascii?q?yLGDK9B1296Fpxoyefsg43CA=3D=3D?=
Received: from mail-vi1eur02lp2041.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.41])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2024 21:01:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmPtkkbd6Wzb+qsJ1CXTNF+kdus7TiUOdyCNOftuBGayWp/40SH+12uGbRH4c8qE0DCgvpZc+EKF6JFtQOqJ0s+2+dCE6ANlMyh+cwEYTomA5VkxhSYCnxHg8+fox/JB7XVqvZ7uPFqXb0aPUwxjQAEFzvFLt31+fiepFd0tl2A/1O0sppoHd3WTudhVoA29PWMmetMcjxjwR1gXAC1wAvNVMRGfsKsOp3Tk0WK0bJqOmuqRhxi5+6ovTUz9L2pE8TefP+zDUqcBe3kF15b4JdoQrf3EmHpB4MXw3iM0H8fKZKsdZY/WkK1wpE1dWA8ajxLwJ0E6VIt08ZFazqCdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwJVeJ4DBDeJzO8VydTsFy2qUxmsCI8DEgSWdr+CxjM=;
 b=wCW2TPzC02wcCC2rLaDhFrGPpJO7T0w26yy8ThrZODz0fYwmBJZS5oNw67XB8h3Qq/9P4m9bScKUcEQampVz/gv3Q60UyRhJnmqD0t/5uvou5x1rVwdoCXf1eGbrk3PCk56K7lGWvu1xUq0Xpp7tVBkJ0YL5NbYAmrzspBy3zxasnvCZu5Lk/ifaVOjNIvCAJqzeHvKhmNE9JysnhkVuxqrYk+NPDpOsJqMaAq8xC2sE690i12SxM/FTOA6M+NJbHUcFn8NJDvYeYUy73v3nTG0Jnalhm//b+dVpgLDcZh78OwdJFrm0GwT/U2tYKUtG2JtJY28Ye4NdaKqODc8Fiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwJVeJ4DBDeJzO8VydTsFy2qUxmsCI8DEgSWdr+CxjM=;
 b=k5uRqRRu4pfFA+fX8qWFRO4LTjNGFR9ed5FD02/+1FvS4pyuY7l/W3nBxeyhF2Viy4dkzK5PoVFYw5o02VlTtJLi+Sh/sFOsJ656rzowhJZlaeY+FnJjyKjbJ1jy6/VtGSbY5k8M2xv5srP2H2SOdMEy6c16QRnkv8CARm/XAoNjSMD8BO+MsvnpOE+sZ5oZF+45stHMkRuVuoo4ba4Y0WLoiNU0hclgsK9jU92BwC8c9xQeNXK96wUd8PMD1268snT8MiN9RN7q5aKFek/PaJKZiRyUWOgQHi1EGvmk3FAURzRaYWkVVHHsAcn27Mh0hlT4dU/VQWaH+QlISSpiag==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB10015.eurprd07.prod.outlook.com (2603:10a6:150:11e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Thu, 11 Jul
 2024 19:00:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.005; Thu, 11 Jul 2024
 19:00:58 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Minwoo Im <minwoo.im@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Thread-Topic: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Thread-Index: AQHazEQPZma3+RPBzE6mhYIQQIOAh7HuOTAAgAAdBICAAJwTAIAAhiqAgAHBAQCAALdZAA==
Date: Thu, 11 Jul 2024 19:00:58 +0000
Message-ID: <a1d82288-a3a7-46f0-b6bd-bb636ecc147d@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <CGME20240702055502epcas2p2f54e3234f35d28e73513a5634a7cb03a@epcas2p2.samsung.com>
 <20240702055221.1337035-21-clement.mathieu--drif@eviden.com>
 <Zo0NpttNP8OkrOG8@localhost>
 <929fc1df-0a19-4da0-8399-5d792dd25684@eviden.com>
 <Zo2o6kkqpSgmj4yN@localhost>
 <156af18e-255d-4149-be7b-bb93dc360da3@eviden.com>
 <Zo+SHAPHSbaIOJ25@localhost>
In-Reply-To: <Zo+SHAPHSbaIOJ25@localhost>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB10015:EE_
x-ms-office365-filtering-correlation-id: 559b2e0d-a790-4875-3cdc-08dca1dbccce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VW5QN3o3eGVGajYvSE9PaFI2dlhubEl3RU1JZ0hsTm1pNEZXdjU1TWVvZEtk?=
 =?utf-8?B?cDhHNnUrd0N2VHMxVWZOQWhsQnJuSm1JaEN5VG5VemlHQzNBeU52L1ZKTEpK?=
 =?utf-8?B?VzBZL1JBQ2FWajFHdGpiL3lDWU5Idy80RXJrdzNoQTdQbEV3aStqTUkweDdR?=
 =?utf-8?B?K3ZlbzFWdVBEZmZrU25kSFVBc3ZsUFN2RXk5OGhneUFOa0xEM2lOdDRxUmhY?=
 =?utf-8?B?cFlTV3V0c1VjYmlVZy9hWjFFRnBpdWdBVWRSR2hpMXd0SWEzMUFIVUVhVGds?=
 =?utf-8?B?NUIvUTg1UGJ6WEtmZTgyWnVGZEJIemVrQU8yNW1ML3RBNm5zYm1KVFBpTlkr?=
 =?utf-8?B?ek1WL3lVTG00bStCNnN0RHBGRkJtS05BOWdCa2dPV1A5RG9VdGRkOVBHekc5?=
 =?utf-8?B?WmhWWUR5cjRjOWpqSWIxY0xPSjNKcTI0SUFDVEt6d3c1K0tDYjFSQStGNFEw?=
 =?utf-8?B?VHpXeTRMOHNaTjBNL2FJVGdhZlVqaG9uK2d5dkR5cWlvVTk1VzhUcTRTL2hV?=
 =?utf-8?B?UFZKVExNQjk4UnNaeHhSb3d6WEt5QkxlUlkxVm8xOGpNeDcrUTZ0Q1YrVHln?=
 =?utf-8?B?OWhxQXFVZVl4dWlsenAyUWpkck5wSGR4cXI1Ynk5RDZZMU9HTTgwUzdYT3pq?=
 =?utf-8?B?bzVKL2wrQUpBSnlad1ZXeHBMdkJTeDFRS3BaRkZSVnhZcklrdXMzeUVaMUlM?=
 =?utf-8?B?VFAzS2xEeUVGM1crNzZsNk9KSHdRMTA4eTJpczRrdWpwb05tbXBVamRKdG1B?=
 =?utf-8?B?U015d0dBRGl2OFRsejFZY25STHRkUkxNME92RTVBVzh6TmZVWThsajJtNERT?=
 =?utf-8?B?MlpHZDhIM3VjSGdLem9hQnUwUmZhcEdTeDFwSWlRcEQyOW1zK0JBVmNmTEhM?=
 =?utf-8?B?THZ1TkJWUEtwakNoaktPUzlwdy9lWFMzQlZDdGI2cHM1RVJtdG5aQnJyUWdo?=
 =?utf-8?B?M2oyS1VZUC91V3p3bmVmZUo0V3hkaEZWWEZpeHhhSktMd3J3VGhWU1paU3RG?=
 =?utf-8?B?YURhbW1qR2F1OWdKejRiRldTaG50OE05TUtpbS9oNWc0cmQ2Z2tsR1pKUml1?=
 =?utf-8?B?eFMrTXBuK2h5UEs4b0ZqWTZQNGdLOHEvWnZEcyticFEwZjgwNGpFSFYyMjYr?=
 =?utf-8?B?RkMvcDJkKytxTkYxcVpiTVBuMmlHdlJVYnNlVjgyRFhxK3B3R1NXMXFweEoz?=
 =?utf-8?B?ejArcld5L21DZnFZSkJBaHNyUHlhZ3dLMG1vR1huSGxEaWZJTjd0VDNwaVR0?=
 =?utf-8?B?RXZTbmI2U1lyYVdoR0pzK3lsdUtRbmk4US8rUE91NWxDYjZ0Ulp6UVJKRlQ2?=
 =?utf-8?B?VVF5TTJwS2lZOHdEa2hWZWRtMURRZEtROC9ORllzb3pKVUlZUUtWV2Y3VjBR?=
 =?utf-8?B?cnRFdjEyNkkvT2lYWTVzc3BYR1d6ck5PNUoxdzhSOE9iY2pZeUtFQnB6SUlO?=
 =?utf-8?B?ZGUxblNpaVVFWHNUM2dVazRKV0hXTWxxT0hvd1ZIazdYVHlzbXl5ODg4emU0?=
 =?utf-8?B?OGF1bXpZR1hkMDd2VUhkWFcvSVpYMWMweG81bm5EN2JqVHhZKzBSY3F5TlFU?=
 =?utf-8?B?dk5yUmV6WEZMbk9FdTExaWpiZXF3TlZOdUZYNXE2MzFSeEtaOXJUMFFEQ2Q2?=
 =?utf-8?B?aDBRYmw2YzVyNWUxNzF0MC80UCsrWG4rK1hMNy9CemIwU0UyWE56M0FidTln?=
 =?utf-8?B?Mko5citrRUVSQS95OVZUTHVPK2pPZVhLUzBNSG9MU1hsd2JIcjRLY3dET3g3?=
 =?utf-8?B?d2tRVzVEQ21sZ0E1aXdVQURtZWswc3lZMUdhZi9XQitZckRuVndaZC85Rngx?=
 =?utf-8?B?Y2tmN1VIRmRFbmU5WkovdkJlY0MrczRvZVhVc2JXQTNGTW1uT1phQ1JLRFor?=
 =?utf-8?B?WmErSDBTZGNTUGhUeU45Ulk2UzRxYVZva3laR3JJa0RoVmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzhNQ3RLcW9GQmFRMVNMS241OFdibWhWcFFRMVl3YjNzK2ZJVTk2YW9zTkF1?=
 =?utf-8?B?TDY0QVhxRlhNMDdzWCtEZnIyWGxIYVJkdXFUZnRFRXppMVgrQjd4enUzYXhQ?=
 =?utf-8?B?ZmdaWUE0cmV1NTc3Q3RMVEE3WHNqelV6MkxrQm5CelhmSEJyOFk2SzhTZy8y?=
 =?utf-8?B?SC81Rk9QUDRPelZ4L2VXN2dQRWNzVEdoamxQN3gycGpLVEtZVXFiakdVck9t?=
 =?utf-8?B?UTBmeXBsNWVwblI3dko4UzdsU1ZqMkM3NTE0K05VaTNDYTFFdnpoWDQyZEI2?=
 =?utf-8?B?c3BCR3MyUEg2NnhPU05MSXhheVFJbE9RdEpPb3NzTkZOWTJmV0lmWEZhR0dX?=
 =?utf-8?B?dEJPaDd0dVhnbFBMSlRTTWVmdFVlZ3hDclBjU3FyTWEzSGJSZm1FM2x0dHNH?=
 =?utf-8?B?NjA0MlRhNEpVZVVGVml2eXdaemRvK1ppQTNtQ3puS2xRL1M0VG5mN2NnUnh5?=
 =?utf-8?B?eUYydUNkeUd6Skx6ZGhnQndJSnJEaEduZHBOb1prSlM4NjNHam12OVdURU0y?=
 =?utf-8?B?Y2VubmZMdlpBV3BaWW1vMUY2TGdhb25nejhpeHcramovOVlCSlhrbUwveVdz?=
 =?utf-8?B?ZWVNbjNGbVFOVXY4YUxjQXFOejdnWFVGNWtlRDc3cm1aazVXTzFyMzlJVEZV?=
 =?utf-8?B?aHJnVG42dlR0czZSWjEvbFFrMzlRcDZZcnhkT25rUEprT2J3RUtZUzBUL2Q2?=
 =?utf-8?B?dG1CVVdXVzFjUG1VU3NZMlMwalBQV2YvTXVsNDZ5cTVmck1qYjNGbU93TVpG?=
 =?utf-8?B?TTM0dlJ2RGJBb1JvWFEwVkxydXJKbnBNQkpDSUpXTDdNOVo5aml1dENZTFpa?=
 =?utf-8?B?V0trcG9QMHMrUjVTdHBjVm80a2FtRTdNTkk2SmViSklCTUI2ZHBBaEM3VzEr?=
 =?utf-8?B?NlFwUTBBQkw0UkdMdWt2M25aL2NoQkZMODlzSTZzSlcvNis3aEpCWlJYOWlC?=
 =?utf-8?B?S2FMWHJLZll6ckMrUnFsWWRGTWw5UnpUSmdKV05IdXR6cFAxRHdZL0tDSVdP?=
 =?utf-8?B?alB3UUdpN2RqbU84dDNFbTJhcGJwSG41QzhiK0t0bFFTMmxQL3p5ejlFaDEx?=
 =?utf-8?B?RGV0eDR5NHZVWWVxTWVERlg4cCtJOFhCN0NDSHhKR2FxRWNqa3ZXc3d0TzBV?=
 =?utf-8?B?djBaQ25OTTNMYVBJVlZKTThrMGh4L3grOVVjZFFodFpEUzAvSS80VGo5UEpx?=
 =?utf-8?B?NkpGQXkrWFB5dUlDdEptOGQ2Vlllcm1Dd05XcEdGR2Fmc0dNN1dEaUhGaG1T?=
 =?utf-8?B?UzFGcjQvZm02Q2ZIYU9acm50OTlGTXUxUG1odUtkSnVQMFlBeUNsblVSUzJs?=
 =?utf-8?B?SDA5czhuQXhNblhVYkZ4UHY0N2czci9yMjlGMjJWc1NMemxGSUltWVR5b1g4?=
 =?utf-8?B?Sks1WlVLdjhlZ2NKSG5LaHI0cnRQWjN2WEJhTTRnZXRRSVZBSW40MG0yQnN5?=
 =?utf-8?B?NWdFLzRIaUpTcyszditRajdWdno2Y1RQR2RBK1dYUTFBenpyYzVOZ2RzUUFX?=
 =?utf-8?B?UXRDY1lFVFJORG1oVHZqR2h2RVAxVVVIYVlkQm5yNTdlN25wWXpKQU8zbDFM?=
 =?utf-8?B?SVZYcldUMUd4WVZlYUNBNnFXYVRKdWZNKzhsSzZKd2ZHTjdDV2E5am1DTkFT?=
 =?utf-8?B?c1poTWxDVFp1RXZpYzBzRHZJSXFDSGtkWXRRcEtJaTFoVkFoTnhvL1k2Tllm?=
 =?utf-8?B?UUlBaUZkbTNhM3hwdTNwUThmMXFiK082SVlZWTRmYkxRVjlKeGNLMk5DQW5J?=
 =?utf-8?B?VndhNEI0WXYxM2tDTzE3eng2UmUrRVVRNzJrN1RTUzVjcVJsckJWMXpIb2tD?=
 =?utf-8?B?WHE5Nmw4V0srdDJuU251UXV3L3YxWVYwWCtCUzBzSUFZZUFHYkpvbzRKcDZ1?=
 =?utf-8?B?VUFkckVHazNybTAwbHRTMWxsbDM2Z3I5T0huVDJXWGswOVVJa2xZcVRaMTZz?=
 =?utf-8?B?Sno4YTNTRDB6Q1Z1Ymh3WWRxTllGUHFmL2JId3pCbzBwTGNvSEtOVXBybHZJ?=
 =?utf-8?B?UGMxbW4yRjVaL2F1MGJMQUFrZnUyNE9HOGE2V0FWNlNMeWpTa3BHNXFSeWZk?=
 =?utf-8?B?VjFzZlgyNEZ6NTFPaWg2VlM2NTIwZWttRFpaUEdjNDdVY2p3V05vL2d0T1hU?=
 =?utf-8?B?RXZ3emo4d285b1ZWR0pvUWlTUHE4YlV5VDJNazI3ZWM5cXBocGV5ZHFnMnln?=
 =?utf-8?Q?Z/4j2lCUl8X6gMcyBorV00M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2A443C9F3B0DA4692C8C6C8EC9ECC91@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559b2e0d-a790-4875-3cdc-08dca1dbccce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 19:00:58.5455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjR/0QfbUPju4Yv1L3ZbinTkn9aGVNzFfxG0V7qCyDymEIVtHs8d/aelHY8E67w4MjpHCYARCzgxht+4gWp85pKUhcdJ1HrvDYh24s4km3BdJ2h8zuxpFyTHUBTgIUda
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10015
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

DQoNCk9uIDExLzA3LzIwMjQgMTA6MDQsIE1pbndvbyBJbSB3cm90ZToNCj4gQ2F1dGlvbjogRXh0
ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxl
c3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiAyNC0wNy0xMCAwNToxNzo0MiwgQ0xFTUVOVCBN
QVRISUVVLS1EUklGIHdyb3RlOg0KPj4NCj4+IE9uIDA5LzA3LzIwMjQgMjM6MTcsIE1pbndvbyBJ
bSB3cm90ZToNCj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNo
bWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93
biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pj4NCj4+Pg0KPj4+
IE9uIDI0LTA3LTA5IDExOjU4OjUzLCBDTEVNRU5UIE1BVEhJRVUtLURSSUYgd3JvdGU6DQo+Pj4+
IE9uIDA5LzA3LzIwMjQgMTI6MTUsIE1pbndvbyBJbSB3cm90ZToNCj4+Pj4+IENhdXRpb246IEV4
dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5s
ZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZS4NCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gT24gMjQtMDctMDIgMDU6NTI6
NDUsIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4+Pj4+PiBGcm9tOiBDbMOpbWVudCBN
YXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+Pj4+Pg0K
Pj4+Pj4+IERldmljZXMgaW1wbGVtZW50aW5nIEFUUyBjYW4gc2VuZCB0cmFuc2xhdGlvbiByZXF1
ZXN0cyB1c2luZw0KPj4+Pj4+IHBjaV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbl9wYXNpZC4NCj4+
Pj4+Pg0KPj4+Pj4+IFRoZSBpbnZhbGlkYXRpb24gZXZlbnRzIGFyZSBzZW50IGJhY2sgdG8gdGhl
IGRldmljZSB1c2luZyB0aGUgaW9tbXUNCj4+Pj4+PiBub3RpZmllciBtYW5hZ2VkIHdpdGggcGNp
X3JlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3RpZmllciBhbmQNCj4+Pj4+PiBwY2lfdW5yZWdp
c3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXINCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4u
Y29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+ICAgICBody9wY2kvcGNpLmMgICAgICAgICB8IDQ0ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4+PiAgICAgaW5jbHVkZS9o
dy9wY2kvcGNpLmggfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPj4+Pj4+ICAgICAyIGZpbGVzIGNoYW5nZWQsIDk2IGluc2VydGlvbnMoKykNCj4+Pj4+
Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMNCj4+Pj4+
PiBpbmRleCA3YTQ4M2RkMDVkLi45M2I4MTZhZmYyIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2h3L3Bj
aS9wY2kuYw0KPj4+Pj4+ICsrKyBiL2h3L3BjaS9wY2kuYw0KPj4+Pj4+IEBAIC0yODMzLDYgKzI4
MzMsNTAgQEAgdm9pZCBwY2lfZGV2aWNlX3Vuc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRl
dikNCj4+Pj4+PiAgICAgICAgIH0NCj4+Pj4+PiAgICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gK3NzaXpl
X3QgcGNpX2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uX3Bhc2lkKFBDSURldmljZSAqZGV2LCB1aW50
MzJfdCBwYXNpZCwNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwNCj4+Pj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyIGFkZHIsIHNpemVfdCBsZW5ndGgs
DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wg
bm9fd3JpdGUsIElPTU1VVExCRW50cnkgKnJlc3VsdCwNCj4+Pj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQo+Pj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICplcnJf
Y291bnQpDQo+Pj4+Pj4gK3sNCj4+Pj4+PiArICAgIGFzc2VydChyZXN1bHRfbGVuZ3RoKTsNCj4+
Pj4+PiArICAgIElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tciA9IHBjaV9kZXZpY2VfaW9tbXVf
bWVtb3J5X3JlZ2lvbl9wYXNpZChkZXYsDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhc2lkKTsN
Cj4+Pj4+PiArICAgIGlmICghaW9tbXVfbXIgfHwgIXBjaWVfYXRzX2VuYWJsZWQoZGV2KSkgew0K
Pj4+Pj4+ICsgICAgICAgIHJldHVybiAtRVBFUk07DQo+Pj4+Pj4gKyAgICB9DQo+Pj4+Pj4gKyAg
ICByZXR1cm4gbWVtb3J5X3JlZ2lvbl9pb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihpb21t
dV9tciwgcHJpdl9yZXEsDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBleGVjX3JlcSwgYWRkciwgbGVuZ3RoLA0KPj4+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbm9f
d3JpdGUsIHJlc3VsdCwNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJlc3VsdF9sZW5ndGgsDQo+Pj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJfY291bnQpOw0K
Pj4+Pj4+ICt9DQo+Pj4+PiBDYW4gd2UgdXNlIHRoaXMgZnVuY3Rpb24gbm90IGZyb20gdGhlIGVu
ZHBvaW50IFBDSSBkZXZpY2UsIGJ1dCBpbnNpZGUgb2YgdGhlIHBjaQ0KPj4+Pj4gc3Vic3lzdGVt
IChody9wY2kvcGNpLmMpIHRvIG1ha2UgdHJhbnNwYXJlbnQgYWJzdHJhY3Rpb24gZm9yIEFUUyBy
ZXF1ZXN0IGZyb20NCj4+Pj4+IFBDSSBlbmRwb2ludCBkZXZpY2UgUE9WPyAgSSBndWVzcyBpdCB3
b3VsZCBiZSBiZXR0ZXIgdG8gaGF2ZSBQQ0kgc3Vic3lzdGVtIHRvDQo+Pj4+PiBpc3N1ZSBBVFMg
cmVxdWVzdCBpZiBwY2llX2F0c19lbmFibGVkKGRldikgcmF0aGVyIHRoYW4gY2FsbGluZyBmcm9t
IHRoZSBlbmRwb2ludA0KPj4+Pj4gc2lkZS4NCj4+Pj4gSGksDQo+Pj4+DQo+Pj4+IFRoaXMgc2Vy
aWVzIGFpbXMgdG8gYnJpbmcgc3VwcG9ydCBmb3IgU1ZNICh3ZSBhcmUgdHJ5aW5nIHRvIGludGVn
cmF0ZQ0KPj4+PiB0aGUgcGF0Y2hlcyBiaXQgYnkgYml0KS4NCj4+Pj4gICAgRnJvbSBhIHNwZWMg
cG9pbnQgb2YgdmlldywgSSBkb24ndCBrbm93IGlmIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8NCj4+
Pj4gaW1wbGVtZW50IHRoZSBTVk0gbG9naWMgYXQgdGhlIFBDSSBsZXZlbA0KPj4+PiBhcyBpdCdz
IHN1cHBvc2VkIHRvIGJlIGltcGxlbWVudGVkIGJ5IGVuZHBvaW50IGRldmljZXMuDQo+Pj4gVW5k
ZXJzdG9vZCB0aGF0IHRoaXMgc2VyaWVzIGlzIHRhcmdldGluZyB0aGUgU1ZNIHVzYWdlLiAgQnV0
IEFUUyBmZWF0dXJlIGlzDQo+Pj4gc29tZXRoaW5nIGdlbmVyYWwgdG8gUENJIGRldmljZXMsIG5v
dCBvbmx5IGp1c3QgZm9yIFNWTSwgc28gSSBndWVzcyBpdCB3b3VsZCBiZQ0KPj4+IGJldHRlciB0
byBoYXZlIGNhbGxlciB0byBgcGNpX2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uX3Bhc2lkKClgIGlu
IHBjaSBzdWJzeXN0ZW0NCj4+PiBsaWtlIHBjaV9kbWFfcncoKSB0byBhdm9pZCBkdXBsaWNhdGVk
IGltcGxlbWVudGF0aW9uIGluIHRoZSBmdXR1cmUgZm9yIHRoZQ0KPj4+IG90aGVyIFBDSSBlbnBv
aW50IGRldmljZXMuDQo+PiBXb3VsZCB3ZSBzdG9yZSB0aGUgQVRDIGRpcmVjdGx5IGluIHRoZSBQ
Q0kgc3Vic3l0ZW0/DQo+IFllcywgZW5kcG9pbnQgZGV2aWNlIChlLmcuLCBzdm0uYykgc2hvdWxk
IGNhbGwgcGNpXyogaGVscGVycyBpbiBQQ0kgc3Vic3lzdGVtDQo+IHdpdGggYFBDSURldmljZSAq
cGRldiBpbnN0YW5jZWAgd2hpY2ggcmVwcmVzZW50cyB0aGUgZW5kcG9pbnQgZGV2aWNlIGl0c2Vs
Zi4NCj4gQnkgdGhlIGluc3RhbmNlLCB3ZSBjYW4gbG9vayB1cCB0aGUgSU9UTEIgZW50cnkgZnJv
bSB0aGUgQVRDIGluIHRoZSBQQ0kNCj4gc3Vic3lzdGVtLCBub3QgdGhlIGN1cnJlbnQgY2FsbGVy
IHNpZGUuDQo+DQo+Pj4+IEhvd2V2ZXIsIHdlIGNvdWxkIGNvbnNpZGVyIHByb3ZpZGluZyBhIHJl
ZmVyZW5jZS9yZXVzYWJsZS9lbmNhcHN1bGF0ZWQNCj4+Pj4gaW1wbGVtZW50YXRpb24gb2YgU1ZN
IHdpdGggYSBzaW1wbGlmaWVkIEFQSQ0KPj4+PiB0aGF0IHdvdWxkIGNhbGwgdGhlIHBjaV8qIGZ1
bmN0aW9ucyB1bmRlciB0aGUgaG9vZC4NCj4+PiBJIHdvdWxkIHByZWZlciB0aGF0IFBDSSBkZXZp
Y2VzIHdoaWNoIHdhbnQgdG8gcmVxdWVzdCBBVFMgdHJhbnNsYXRpb24gaGFzIG5vDQo+Pj4gYWRk
aXRpb25hbCBpbXBsZW1lbnRhdGlvbiBmb3IgQVRTLCBidXQgb25seSBwY2llX2F0c19pbml0KCku
DQo+PiBIaSwNCj4+DQo+PiBJIHRoaW5rIGJvdGggc3RyYXRlZ2llcyBjYW4gY29leGlzdC4NCj4+
IEtlZXBpbmcgY29udHJvbCBjYW4gYmUgaW50ZXJlc3RpbmcgZm9yIHBlb3BsZSB3aG8gdXNlIFFl
bXUgZm9yIGhhcmR3YXJlDQo+PiBwcm90b3R5cGluZyBhbmQgd2hvIGdlbmVyYWxseSB3YW50IHRv
IGV4cGVyaW1lbnQuDQo+PiBXZSBjYW4ga2VlcCB0aGUgY3VycmVudCBQQ0ktbGV2ZWwgQVBJIGZv
ciBkZXZpY2VzIHRoYXQgd2FudCB0bw0KPj4gcmVpbXBsZW1lbnQgdGhlIGxvZ2ljIHRoZW1zZWx2
ZXMNCj4+IGFuZCBhZGQgYSBraW5kIG9mICJETUEgbW9kdWxlIi8iQVRTK1BSSSBtb2R1bGUiIHRo
YXQgd29ya3Mgb3V0IG9mIHRoZSBib3guDQo+IEkgdGhpbmsgd2Ugc2hvdWxkIHByb2l2ZGUgaHli
cmlkIG1vZGUgb24gdGhpcy4gIE9uZSBmb3IgYSBgZ2VuZXJpY2AgY2FjaGUNCj4gcG9saWN5IG1v
ZGUgZm9yIGV2ZXJ5IFBDSSBlbmRwb2ludCBkZXZpY2VzIHdoaWNoIGNhbiBiZSBjb250cm9sbGVk
IGluIHRoZSBQQ0kNCj4gc3Vic3lzdGVtIGZvciBBVEMsIHRoZSBvdGhlciBvbmUgaXMgdGhhdCBk
ZXZpY2Utc3BlY2lmaWMgY2FjaGUgcG9saWN5IG1vZGUNCj4gd2hpY2ggbGV0IGVhY2ggZGV2aWNl
IGltcGxlbWVudCB0aGVpciBvd24gQVRDIGxvb2t1cCBiZWhhdmlvcnMgdG8gb3B0aW1pemUNCj4g
dGhlaXIgb3duIGNhY2hpbmcgaW1wYWN0Lg0KPg0KPj4gVGhhdCBtb2R1bGUgY291bGQgYmUgY2Fs
bGVkICJzdHJ1Y3QgUGNpRG1hTW9kdWxlIiBhbmQgZXhwb3NlIGEgc2ltcGxlDQo+PiBzZXQgb2Yg
ZnVuY3Rpb25zIGxpa2UgcGNpX2RtYV9tb2R1bGVfaW5pdCwgcGNpX2RtYV9tb2R1bGVfcmVhZCwN
Cj4+IHBjaV9kbWFfbW9kdWxlX3dyaXRlLg0KPj4gSSB0aGluayBpdCdzIGltcG9ydGFudCB0byBr
ZWVwIGV4aXN0aW5nIERNQSBBUEkgYXMgaXMgdG8gYWxsb3cgZGV2aWNlcw0KPj4gdG8gZG8gYm90
aCAid2l0aCBBVFMiIGFuZCAid2l0aG91dCBBVFMiIG9wZXJhdGlvbnMuDQo+Pg0KPj4gRG8geW91
IGFncmVlIHdpdGggdGhhdD8NCj4gSW5kZWVkLiAgS2VlcGluZyB0aGUgZXhpc3RpbmcgQVBJcyBp
cyBhIGdvb2QgY2hvaWNlLCBidXQgSSB3b3VsZCBsaWtlIHRvIGhhdmUNCj4gZW5kcG9pbnQgZGV2
aWNlcyBjb2RlIG11Y2ggbW9yZSBzaW1wbGVyIGZvciB0aGUgZ2VuZXJpYyB1c2FnZXMgOikNClRo
YXQncyBhIGdvb2QgcG9pbnQsIHdlIHdpbGwgc2Ugd2hhdCB3ZSBjYW4gZG8gb25jZSB0aGUgY3Vy
cmVudCB3b3JrIGlzIA0KaW50ZWdyYXRlZC4NClRoYW5rcyBmb3IgeW91ciBjb21tZW50IDopDQo+
DQo+Pj4+IERvIHlvdSBoYXZlIGEgc3BlY2lmaWMgdXNlIGNhc2UgaW4gbWluZD8NCj4+PiBBVFMv
UFJJIGlzIHRoZSBhY3R1YWwgdXNlIGNhc2UsIGFuZCBpdCdzIG5vdCB0aGF0IGRpZmZlcmVudCB3
aGF0IHlvdSBhcmUNCj4+PiB0YXJnZXRpbmcgZm9yIDopDQo+Pj4NCj4+Pj4gICAgPmNtZA0KPj4+
Pg0KPj4+Pj4NCg==

