Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F15ED65C44
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 06:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBSyJ-00045V-Di; Thu, 14 Nov 2024 01:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tBSyH-00045A-Fr
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 01:04:49 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tBSyE-00058y-OB
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 01:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1731564287; x=1763100287;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=cgZ4JxszlN+VAuSlZTEVT/ASLIBpB4M8KXZxrFbdThg=;
 b=nqvHfhu1RqUyt6G/v7IXB5C384ZIq9j0IsPwfP8p4Ed3y+YughWhunlW
 GoDXrKjzbKXJanCyUX7Z3Ue2US8I+5co0HgoNNgjtaNazFdpcdDr7wO8Y
 nLSPVWcGzvdhpbDaj43pecz+BCUIat3/u/Yiffse1kjp5F1+G257EKQzP
 zeO61JrB7B/Vr4PwCwIuMuhPrWcAkQwi5G5NiOmIcfQPPpDAwDhiuMAfA
 2/EE1VDrv+kgcA8XtQmL+T8aRt6ff85bI+Timi5tuYp2wPGODOiRpjXiz
 udFbSYguQnfSTiBf4GbWTvhVYDZlYtalHyCOEqBTf2RUXF/kbv+ha34dr A==;
X-IronPort-AV: E=Sophos;i="6.12,153,1728943200"; d="scan'208";a="24556895"
X-MGA-submission: =?us-ascii?q?MDGgTjGalm3JnkuCnhA7t7BMjwJgiVmh/Bl/y9?=
 =?us-ascii?q?/HYWA/eejZRwmIf/HFZVVwLH//n2a8dxECqr9+pqPyWjMrikfD83Hep4?=
 =?us-ascii?q?GlsrpjU0tKBcDGsavI6rm0UIr3qJbsGtGJUa9euUlUtEMA5t8bBdYZHi?=
 =?us-ascii?q?UBlMaEHYg8NQR9I4et7is3+Q=3D=3D?=
Received: from mail-vi1eur05lp2174.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.174])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2024 07:04:40 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcnU0Dxb4/lgbH9vkbum/ifLv0SU3D8KcH+3zWTAO4jnO70iV8L8taMaFwmluNyFAcMIx4V3hIYGoFAuZpr5LPNMWRNejVmrA3nb1gVwdq2wPkbbqjqcNXMzgwE0gWJTgXn9Cf54ydldsu1U7BCAnfOqFlczjkG3g0s44NpZ7cDJo0G9BfZuPzfcKGly4izFpHmFguKUA/d3eTEtbjoskVRxcE0nfcjISd/eJaxRWPxxI1vY8kTsZVGZleumg9Sx4Qf4m34mvKuYbiQMjERPbFVVyUgvVvYxefNbDlrkZxjiwzMb++nRfaAyatCfHd0C6kYWl5nPQdfvjXQsY9Z3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgZ4JxszlN+VAuSlZTEVT/ASLIBpB4M8KXZxrFbdThg=;
 b=q8WGTwPzkySSZfRyUnsrQeiWeBSack6P8ArwTCzbCh6Fth3jsfwiLK7bJoslWHcb4cwhv2qLUBFFetIEb9xpKKjfRYd/nkRnyHsOeRwO2kpHwzZBQLeMc0ns6AIwfXPxugDB1zaFkj8GRjzuvEzipxJN1znt9tKWiYeAQMfpaCvqv3Se6wqkhrfWUqEfMqsZ95+Kd4hxarOe1HzUye4MUMlssJg88XaxyNIIOc9xg9nCjDOUZEVOxE3FrbY4kv5CKuB6grTgmXwcv69+K3mYxFsotUbiS8YRBtP2eeQknhepOL8eFAjDVhm4FgNke/xGwAmVQzDuodF31zwOLgv9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgZ4JxszlN+VAuSlZTEVT/ASLIBpB4M8KXZxrFbdThg=;
 b=UiYelR6jJ56q+Uyg6UaTQFKNFjZkciFR1sWSgvQERyUbf4x2V7FOo2DOtL3QemYFyh3da9mhk0l7MSGYqrq25XBPzj7bsAAeltidAlQrHnLcJqBxjFbvsEmvD00/vAVzMmVump1ls5lfNDvi6DvqV2zBi8ARntj4sKQ/gkZmKjZhvZp/96bwzO0EsrYzBEbXmhhsARVYmf1TL7TOdr2JoaffS87A6u6t71LPjEKGtrxHNsXA/a0wNf0QkzUix3CS4JnT/iDeIbn+f4J8KUC7x8tBclecLcAvPLFltbPBkceZxB35J1NuUSxDjcTeP39GSRLVXf8Qec3TO3VNnXuIFA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6392.eurprd07.prod.outlook.com (2603:10a6:20b:13a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 06:04:38 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 06:04:38 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v5 08/20] intel_iommu: Check stage-1 translation result
 with interrupt range
Thread-Topic: [PATCH v5 08/20] intel_iommu: Check stage-1 translation result
 with interrupt range
Thread-Index: AQHbNBUeMwd02aV0pkCrJjkNtdphnrK0ye6AgAAfrgCAAWRigA==
Date: Thu, 14 Nov 2024 06:04:37 +0000
Message-ID: <0a18e998-fa9c-47d7-a7dd-20b918c3df8c@eviden.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-9-zhenzhong.duan@intel.com>
 <04f7b400-b754-417b-8c17-7605d9676e76@eviden.com>
 <SJ0PR11MB6744955D0692A4D225108831925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744955D0692A4D225108831925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6392:EE_
x-ms-office365-filtering-correlation-id: 9b356ec9-716e-4132-7365-08dd047238ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VGQ5cnRtLzB5TlpHcUNKM2FGcEJrdGxjUkRnd241akVRUGhNejFYUDg2Y0dI?=
 =?utf-8?B?ako2WGxSdFZiOS9FTXR3cUJjR2RWTnVPOGlnZVRHeWYwMXIrazk3R1V1Wk9K?=
 =?utf-8?B?TG13Sy9INjRRSm1hcXA2UnZndCtnTzI2a2c5US85Y1ZkV0VOV0JFbGs0QTN0?=
 =?utf-8?B?dG94WW9TeVhYYlF4MkcwUnVXVTNJZWIrSWJxU1dDaWxYMGEyMFRLZTI4OVVo?=
 =?utf-8?B?MG96U3hXeHM5Rmp2dE5iczRrMkxvZzJQbGhWLzJCYjNpczBiOFEzSHhLZE1D?=
 =?utf-8?B?Mkc1ekVlYmYzYmczMEhINVE3UnVKbXZWYlNMZGZrVzlSenRkWWpBaGo2L2hW?=
 =?utf-8?B?Q244Vmg1dW1sSXdXRkpIZXFBNzhScjBDc2tPVTJFWnVpaUhOSFk4NWFxUjBq?=
 =?utf-8?B?amdSZVcxNlZTbDgvQ2JvZ0RJV0tPZVpXTHhwK0dxV1VhRGdPLzFUQU9DV0xL?=
 =?utf-8?B?cFJ6ZUU5ZjZwLzJIMU9aSCt2eUllc1Uxb0k5SC9jbXo2YnFjd09VMzQxK3NO?=
 =?utf-8?B?cUhRUlpBUGlaeVQ5Uk5YQjRDenlTY2ZyUkxNQTRTTEVOcHFoeUFYd3N0N1h3?=
 =?utf-8?B?WWhoUzREc2piUTVMRWFyTFBEWFFNeUx2Q1JlUjlpZlAvYWZHMElZdnc5eDlj?=
 =?utf-8?B?SE1lWm83ajM5OWRlRWdGWGI1S09hNUg4a2t3Y2w5cFJlLzZEbE11cG9Wc1lR?=
 =?utf-8?B?SUtJMlVSak96bUh6MklvR2RsU0RFYmh1SnFjMmo5M2JOMmg4THNPY1RLempS?=
 =?utf-8?B?c1cxc1dkeE8wa2YvYllJbm92cUVOeHN4dXVWanBIVk00UUw4M2ZwdGszT2d3?=
 =?utf-8?B?VUlyNEpPaXNiWllqbElwS09BclJ0U1RZQVR2TDhrMlhQNGdhQkpEUDQ3UHg4?=
 =?utf-8?B?eTBWakpteEtiRHduQktEeEliSTdCdjhRcGVMckp5Wml3cS9CbDhBYXFJa0li?=
 =?utf-8?B?ZmxwRGx3SGNPSDE5NFJuWm9oYlZZaUE4d3lwUkZ1UVdXVGt6VWxkL2s0SkIz?=
 =?utf-8?B?QjA2T3I4clErTE42dTNLN3FGZWMzUmZBd2R1VFNRcmVXWHowaWNiU0ZiWHhT?=
 =?utf-8?B?SW45ZFp5b1lTWk5pSUhwRE9CdUN5OGpiamk3YlhtTlVFaHF6V0ZSZTgzQjZh?=
 =?utf-8?B?ZFQ4TGRWRGJIUnc2Q2lSUDU5VDRZQ3NkUGZuTnVJeGJONEJwYmUxMEloeFBN?=
 =?utf-8?B?Y0tOaEF4cFhrK2JtNkExd1NuNGJKaHhPeHdPUXR2SjAycTVrUmpJV0dpUW84?=
 =?utf-8?B?aS92djNvenVLd3VuVXc1c2tmK1F1RUIwRjZ0TituR3FVRXBtdkIzMXV5UTFD?=
 =?utf-8?B?dmJOT1cwY1luUHU2TmM4OG0rOGcxTHNXNHI4NGFBbTNrMWg5YkpMYkh3THo0?=
 =?utf-8?B?aGdiMEVmd2VCbkpmelpyUUpwZFA5N2hjZU16Zm0zWm8vS1FmUVZhR0NxT1FR?=
 =?utf-8?B?ZGR2SEk1b09NUFpxdXBSVzcvNUFERCtLQ3F5Ynd2eEtFcU1XcEFzdk5rTGxD?=
 =?utf-8?B?TnFwTHVmcUJ0ak1hVnV6MEhMMHFJb1hCQWZZZVRRV0d3TVZUYTg0dXVKeXRB?=
 =?utf-8?B?ZzdrTlBBU3NUN3g4UzJKOEozSURIaU5LdVNiOHdjb1hhTTd6MnlEMUcxeHpo?=
 =?utf-8?B?dEtTQUlOY21HU3Y3NFJhQ2dCTk9Xcmt2UUt5MlMwbDdMTWx1UHp6QzlkVURL?=
 =?utf-8?B?QitXUVI4cmI5SzB4Nk1ySmtyMkNvcXhPTVVaby9ZSTFUZmFRem45NmNUWjAz?=
 =?utf-8?B?amEyRVNRdEpmQ2YyUlpDTHhiWFYvRnZRQlVWeVJRY1FsVmFsMG5YZVFyb3RD?=
 =?utf-8?Q?bqzZnvhS/3qkA0OcZDhp0pCt7ekZvsdhPE6JI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cktWSE9YaFpOeFlwYWxZN1lOczZuQ3huZ1EvUnNkQU91MlJxVW4rUDYrd2Yv?=
 =?utf-8?B?T01HUDliVjJZMXlWSkRtUFZaNHA0alRHNmVrblNJUTBXR2pYUzBKMUkzYVdi?=
 =?utf-8?B?dmgyT2ZwbGJEQ0VEQVAxcnd4RTBRMGNJOXJySWxuM3FqSFgzMG9qWDBKeWRa?=
 =?utf-8?B?cnhqczkvYWZLQlB1S3NWRldNaERvSUkvTW5EK1FsTTRic01SeHBGNjJLbmds?=
 =?utf-8?B?OWxRNXl5NEdud0xWYnpzWXFuN2ZDcld0cEZ0REdmUDRtdVJFUG93MjZpby9r?=
 =?utf-8?B?ZmxUenJXNEd0SCtrUmtGTVdaS0tyNVgvZGt3ckZ2V0xyU2NkTGhTT1NvcFJ1?=
 =?utf-8?B?OTFMM1hzT2FkVXNoaTlwMm04VWx6ZlhBdjhxWkxaOW9tL1Q0bGZvcWVxVzZU?=
 =?utf-8?B?c2dkQzh2clR4RkkxbytEeVFYN1V6aGx3OEtFMmdaUks0U1dUZGxJU1YrTmZH?=
 =?utf-8?B?dkVQcWZrQjRzMHhNUVVralFYS0lwb1piTGxDY1ljVWJJWFdoKytsQyt1eVh5?=
 =?utf-8?B?S1JpUkNqQmE5M2pkYUQwWjZPYlRCZnNPeGVtL0svUi9xRW50U2hNL05maGFP?=
 =?utf-8?B?WHFic0NoM1p6THgveHFJUXdrbndYYlYwbnJNVWVKR0V5cjBGYnJ1UEV6SHIy?=
 =?utf-8?B?d054TFpGamx5WEZFWU9FbEhscXhXYWwrcXNHMzA5Y0k3Tk9GK0VMalpPclRH?=
 =?utf-8?B?bmdHSEpFdHYzUTZna01vbjN6aVRvK0Zhck1ydDY4Q2VkbmVWOWdLMWpYOTVh?=
 =?utf-8?B?d0xIYWJjMWJaMUd6WkZMMVl2V3B6bFpQS2cwQnRQbk1Zc3hoeVlvTjV0bHRl?=
 =?utf-8?B?SFI3S0VpSDl4c3Z4MUFBdEtPbW5VMVA2bkJkSmMxdjZIUHVzSVdWYWkzazdT?=
 =?utf-8?B?bG1Db0h2amxoQkJ6QnlpWlcvbzMyV2cwYStLdU52UkVoRDZtOG9XWkxqUlVJ?=
 =?utf-8?B?UDIvZFF0WDcxTkxPM3JrTzVUc2Z4bkJqUHVSN08vSTRvUHhoY1FvN2lUWGlh?=
 =?utf-8?B?emtEaTZheGNJMTYvcWFaVEM1L254ZngzbEJwUG1CWmlUM0U0ZXk4TVhZdy9r?=
 =?utf-8?B?aU82SmJ6UHI2MEg5OWxMYndUL0JKU09PdXRnS0RZc3hpQm5nekdrOUhaOWk5?=
 =?utf-8?B?NSsrZlNWKzVZbndmRVZlaXlpbUJnN3M4TWZGZGhUc1JHT0UwSUE2bHVOSlVz?=
 =?utf-8?B?dGpCMVl1ZnVoalhjUDZRZkUrMy8relYxdDlaOVA1dGZtWTlqTm5mZ1p1c0VQ?=
 =?utf-8?B?TDk4RW8zTFFDSEFQSXRIRGhVNDNTSmZyWmhmUkV5L2dac2lYOEZKSnpLU1Vx?=
 =?utf-8?B?Y1Y1MjNtcFJSWE5xMkRxdVRObmdCR1hmTjZrWjdSMStNcS9zd2FBYXIyWG5F?=
 =?utf-8?B?d1R3cFRGTjQzck9IQVlIKzhLSCthTFQ4TFgrNGlQcXpDeGwxakJLYndKaHR3?=
 =?utf-8?B?TTl3MEl0MUd6QnA4WU5mVzRWTEIvWHdtaXZVa2RHZW9uaXk1TWx6MGFGUFlq?=
 =?utf-8?B?R1FYVW9acDRob0JGa3FvajRHU1hndEhxRzR1bjFqZlRIRGpiREJQNXJ6Wkt2?=
 =?utf-8?B?Z2pvaUx2SXdJU1I4Y2ZFWlppL2QySU4wSEFVb0ROU3poY2h2OHlDQ203Z0E5?=
 =?utf-8?B?OUlUMWw1UHFQQS93TXpsZ3ZLVEJnZjRDMjQ5cnFBYTBaQ0s5eks0ZUhOYTdL?=
 =?utf-8?B?QVJjRVBocVNTV2lVT1R0TEV1Q1lSV2xza2FuT0JtY1VpWjhYbWtBUjVlY3BH?=
 =?utf-8?B?WDJ2QVpHN2Qwc3NGaDRkMjhQVDRDNVNaZFhiMjdaM2lpWGFSd2V5bXA5SW83?=
 =?utf-8?B?NWlxZWREWHNNdTNzb1Awb3RuSDJUZ0FwMGY3dG1GTHEzZ2JhN2Urc0x4Tlpx?=
 =?utf-8?B?N2ltd1BVY1NkTlhSaWdVZ3BvOXpjLzRETG8wRThCV3oxa3ZjakJJeE1YWlA2?=
 =?utf-8?B?M0dnVlc4YllZb2ovTUd3U3BCeDRNNzJkNktJa2Y3QWV2Y2xRb2FjMGNsSUtH?=
 =?utf-8?B?NnNUZFZDL3NBWi9pdGVwbnZGNGIxV1pFSjl3RWdqUW5mVUM5c3hacG5zYlVs?=
 =?utf-8?B?bFJDcW9PbEtuOFQraW4rMEtDdHFVN2pORmdkalhaRkRqZmVKbEJzQTVjdXFE?=
 =?utf-8?B?dFlQZitWL1ZhTUYwajZUeWZnei83RHNTZW82TUpzeHZ3UU1hbFlCUmtiTTBn?=
 =?utf-8?Q?GGOcZMzdSueqiz83x0pITNY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3FB7395DED9554CB77FC3FCBDBCE1B7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b356ec9-716e-4132-7365-08dd047238ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 06:04:38.0050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nAeAEvQlCwq6J3Xe6rgrAnYevNHLVxSJRbD7340znCuNU8/irzdYCsUndAqcsOfZ8kv5Q8hNuCFzypJSOeHmQsXqH+3H7hwGzgnNP5qxvDWDFIhcY9xfj+fMorv24tAj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6392
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCg0KT24gMTMvMTEvMjAyNCAwOTo0OSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPiBDYXV0
aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlu
a3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4gRnJvbTogQ0xFTUVOVCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRy
aWZAZXZpZGVuLmNvbT4NCj4+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIwMjQgMjo1
NiBQTQ0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAwOC8yMF0gaW50ZWxfaW9tbXU6IENoZWNr
IHN0YWdlLTEgdHJhbnNsYXRpb24gcmVzdWx0IHdpdGgNCj4+IGludGVycnVwdCByYW5nZQ0KPj4N
Cj4+DQo+PiBPbiAxMS8xMS8yMDI0IDA5OjM0LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+PiBD
YXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sg
bGlua3MsIHVubGVzcyB0aGlzDQo+PiBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFu
ZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4+DQo+Pj4gUGVyIFZULWQgc3BlYyA0
LjEgc2VjdGlvbiAzLjE1LCAiVW50cmFuc2xhdGVkIHJlcXVlc3RzIGFuZCB0cmFuc2xhdGlvbg0K
Pj4+IHJlcXVlc3RzIHRoYXQgcmVzdWx0IGluIGFuIGFkZHJlc3MgaW4gdGhlIGludGVycnVwdCBy
YW5nZSB3aWxsIGJlDQo+Pj4gYmxvY2tlZCB3aXRoIGNvbmRpdGlvbiBjb2RlIExHTi40IG9yIFNH
Ti44LiINCj4+Pg0KPj4+IFRoaXMgYXBwbGllcyB0byBib3RoIHN0YWdlLTEgYW5kIHN0YWdlLTIg
SU9NTVUgcGFnZSB0YWJsZSwgbW92ZSB0aGUNCj4+PiBjaGVjayBmcm9tIHZ0ZF9pb3ZhX3RvX3Ns
cHRlKCkgdG8gdnRkX2RvX2lvbW11X3RyYW5zbGF0ZSgpIHNvIHN0YWdlLTENCj4+PiBwYWdlIHRh
YmxlIGNvdWxkIGFsc28gYmUgY2hlY2tlZC4NCj4+Pg0KPj4+IEJ5IHRoaXMgY2hhbmNlLCB1cGRh
dGUgdGhlIGNvbW1lbnQgd2l0aCBjb3JyZWN0IHNlY3Rpb24gbnVtYmVyLg0KPj4+DQo+Pj4gU3Vn
Z2VzdGVkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+IC0tLQ0KPj4+
ICAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygr
KSwgMjMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4gaW5kZXggNGNjNGQ2NjhmYy4uZTY1
MTQwMWRiMSAxMDA2NDQNCj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiArKysg
Yi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiBAQCAtMTEzOCw3ICsxMTM4LDYgQEAgc3RhdGlj
IGludCB2dGRfaW92YV90b19zbHB0ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiBWVERDb250ZXh0
RW50cnkgKmNlLA0KPj4+ICAgICAgICB1aW50MzJfdCBvZmZzZXQ7DQo+Pj4gICAgICAgIHVpbnQ2
NF90IHNscHRlOw0KPj4+ICAgICAgICB1aW50NjRfdCBhY2Nlc3NfcmlnaHRfY2hlY2s7DQo+Pj4g
LSAgICB1aW50NjRfdCB4bGF0LCBzaXplOw0KPj4+DQo+Pj4gICAgICAgIGlmICghdnRkX2lvdmFf
c2xfcmFuZ2VfY2hlY2socywgaW92YSwgY2UsIGF3X2JpdHMsIHBhc2lkKSkgew0KPj4+ICAgICAg
ICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIiVzOiBkZXRlY3RlZCBJT1ZBIG92ZXJmbG93IChpb3Zh
PTB4JSIgUFJJeDY0ICIsIg0KPj4+IEBAIC0xMTkxLDI4ICsxMTkwLDcgQEAgc3RhdGljIGludCB2
dGRfaW92YV90b19zbHB0ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiBWVERDb250ZXh0RW50cnkg
KmNlLA0KPj4+ICAgICAgICAgICAgbGV2ZWwtLTsNCj4+PiAgICAgICAgfQ0KPj4+DQo+Pj4gLSAg
ICB4bGF0ID0gdnRkX2dldF9wdGVfYWRkcigqc2xwdGVwLCBhd19iaXRzKTsNCj4+PiAtICAgIHNp
emUgPSB+dnRkX3B0X2xldmVsX3BhZ2VfbWFzayhsZXZlbCkgKyAxOw0KPj4+IC0NCj4+PiAtICAg
IC8qDQo+Pj4gLSAgICAgKiBGcm9tIFZULWQgc3BlYyAzLjE0OiBVbnRyYW5zbGF0ZWQgcmVxdWVz
dHMgYW5kIHRyYW5zbGF0aW9uDQo+Pj4gLSAgICAgKiByZXF1ZXN0cyB0aGF0IHJlc3VsdCBpbiBh
biBhZGRyZXNzIGluIHRoZSBpbnRlcnJ1cHQgcmFuZ2Ugd2lsbCBiZQ0KPj4+IC0gICAgICogYmxv
Y2tlZCB3aXRoIGNvbmRpdGlvbiBjb2RlIExHTi40IG9yIFNHTi44Lg0KPj4+IC0gICAgICovDQo+
Pj4gLSAgICBpZiAoKHhsYXQgPiBWVERfSU5URVJSVVBUX0FERFJfTEFTVCB8fA0KPj4+IC0gICAg
ICAgICB4bGF0ICsgc2l6ZSAtIDEgPCBWVERfSU5URVJSVVBUX0FERFJfRklSU1QpKSB7DQo+Pj4g
LSAgICAgICAgcmV0dXJuIDA7DQo+Pj4gLSAgICB9IGVsc2Ugew0KPj4+IC0gICAgICAgIGVycm9y
X3JlcG9ydF9vbmNlKCIlczogeGxhdCBhZGRyZXNzIGlzIGluIGludGVycnVwdCByYW5nZSAiDQo+
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIihpb3ZhPTB4JSIgUFJJeDY0ICIsIGxldmVs
PTB4JSIgUFJJeDMyICIsICINCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAic2xwdGU9
MHglIiBQUkl4NjQgIiwgd3JpdGU9JWQsICINCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAieGxhdD0weCUiIFBSSXg2NCAiLCBzaXplPTB4JSIgUFJJeDY0ICIsICINCj4+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAicGFzaWQ9MHglIiBQUkl4MzIgIikiLA0KPj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBpb3ZhLCBsZXZlbCwgc2xwdGUsIGlzX3dyaXRl
LA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgIHhsYXQsIHNpemUsIHBhc2lkKTsNCj4+
PiAtICAgICAgICByZXR1cm4gcy0+c2NhbGFibGVfbW9kZSA/IC1WVERfRlJfU01fSU5URVJSVVBU
X0FERFIgOg0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLVZURF9GUl9J
TlRFUlJVUFRfQUREUjsNCj4+PiAtICAgIH0NCj4+PiArICAgIHJldHVybiAwOw0KPj4+ICAgIH0N
Cj4+Pg0KPj4+ICAgIHR5cGVkZWYgaW50ICgqdnRkX3BhZ2Vfd2Fsa19ob29rKShjb25zdCBJT01N
VVRMQkV2ZW50ICpldmVudCwgdm9pZA0KPj4gKnByaXZhdGUpOw0KPj4+IEBAIC0yMDY0LDYgKzIw
NDIsNyBAQCBzdGF0aWMgYm9vbA0KPj4gdnRkX2RvX2lvbW11X3RyYW5zbGF0ZShWVERBZGRyZXNz
U3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsDQo+Pj4gICAgICAgIHVpbnQ4X3QgYWNjZXNzX2Zs
YWdzOw0KPj4+ICAgICAgICBib29sIHJpZDJwYXNpZCA9IChwYXNpZCA9PSBQQ0lfTk9fUEFTSUQp
ICYmIHMtPnJvb3Rfc2NhbGFibGU7DQo+Pj4gICAgICAgIFZURElPVExCRW50cnkgKmlvdGxiX2Vu
dHJ5Ow0KPj4+ICsgICAgdWludDY0X3QgeGxhdCwgc2l6ZTsNCj4+Pg0KPj4+ICAgICAgICAvKg0K
Pj4+ICAgICAgICAgKiBXZSBoYXZlIHN0YW5kYWxvbmUgbWVtb3J5IHJlZ2lvbiBmb3IgaW50ZXJy
dXB0IGFkZHJlc3Nlcywgd2UNCj4+PiBAQCAtMjE3Myw2ICsyMTUyLDI5IEBAIHN0YXRpYyBib29s
DQo+PiB2dGRfZG9faW9tbXVfdHJhbnNsYXRlKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBQQ0lC
dXMgKmJ1cywNCj4+PiAgICAgICAgICAgIHJldF9mciA9IHZ0ZF9pb3ZhX3RvX3NscHRlKHMsICZj
ZSwgYWRkciwgaXNfd3JpdGUsICZwdGUsICZsZXZlbCwNCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZyZWFkcywgJndyaXRlcywgcy0+YXdfYml0cywgcGFzaWQpOw0K
Pj4+ICAgICAgICB9DQo+Pj4gKyAgICBpZiAoIXJldF9mcikgew0KPj4+ICsgICAgICAgIHhsYXQg
PSB2dGRfZ2V0X3B0ZV9hZGRyKHB0ZSwgcy0+YXdfYml0cyk7DQo+Pj4gKyAgICAgICAgc2l6ZSA9
IH52dGRfcHRfbGV2ZWxfcGFnZV9tYXNrKGxldmVsKSArIDE7DQo+Pj4gKw0KPj4+ICsgICAgICAg
IC8qDQo+Pj4gKyAgICAgICAgICogUGVyIFZULWQgc3BlYyA0LjEgc2VjdGlvbiAzLjE1OiBVbnRy
YW5zbGF0ZWQgcmVxdWVzdHMgYW5kIHRyYW5zbGF0aW9uDQo+Pj4gKyAgICAgICAgICogcmVxdWVz
dHMgdGhhdCByZXN1bHQgaW4gYW4gYWRkcmVzcyBpbiB0aGUgaW50ZXJydXB0IHJhbmdlIHdpbGwg
YmUNCj4+PiArICAgICAgICAgKiBibG9ja2VkIHdpdGggY29uZGl0aW9uIGNvZGUgTEdOLjQgb3Ig
U0dOLjguDQo+Pj4gKyAgICAgICAgICovDQo+Pj4gKyAgICAgICAgaWYgKCh4bGF0IDw9IFZURF9J
TlRFUlJVUFRfQUREUl9MQVNUICYmDQo+Pj4gKyAgICAgICAgICAgICB4bGF0ICsgc2l6ZSAtIDEg
Pj0gVlREX0lOVEVSUlVQVF9BRERSX0ZJUlNUKSkgew0KPj4+ICsgICAgICAgICAgICBlcnJvcl9y
ZXBvcnRfb25jZSgiJXM6IHhsYXQgYWRkcmVzcyBpcyBpbiBpbnRlcnJ1cHQgcmFuZ2UgIg0KPj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiKGlvdmE9MHglIiBQUkl4NjQgIiwgbGV2
ZWw9MHglIiBQUkl4MzIgIiwgIg0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAi
cHRlPTB4JSIgUFJJeDY0ICIsIHdyaXRlPSVkLCAiDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICJ4bGF0PTB4JSIgUFJJeDY0ICIsIHNpemU9MHglIiBQUkl4NjQgIiwgIg0KPj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAicGFzaWQ9MHglIiBQUkl4MzIgIikiLA0K
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgYWRkciwgbGV2ZWws
IHB0ZSwgaXNfd3JpdGUsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHhsYXQs
IHNpemUsIHBhc2lkKTsNCj4+IEhpIFpoZW56aG9uZywNCj4+DQo+PiBTaG91bGRuJ3Qgd2UgYWRk
IHRoZSBwZ3R0IHZhbHVlIHRvIHRoaXMgdHJhY2UgYXMgaXQgY2FuIG5vdyBiZSBnZW5lcmF0ZWQN
Cj4+IGJ5IGJvdGggRkwgYW5kIFNMPw0KPiBIaSBDbGVtZW50LA0KPg0KPiBXZSBkb24ndCBhbHdh
eXMgaGF2ZSBhIHBndHQgdmFsdWUgdG8gZHVtcCwgZS5nLiwgd2hlbiB2SU9NTVUgaXMgaW4gbGVn
YWN5IG1vZGUuDQo+IE1lYW53aGlsZSB3ZSBoYXZlIG90aGVyIHdheSB0byBnZXQgcGd0dCBpZiB0
aGVyZSBpcywgZS5nLiwgZnJvbSBxZW11IGNtZGxpbmUuDQo+IFBndHQgaXMgYWxzbyB1bnJlbGF0
ZWQgdG8gdGhlIGVycm9yIGl0c2VsZiwgc28gSSdkIGxpa2UgdG8gc2tpcCBwZ3R0IGR1bXAgdG8g
YmUgYSBiaXQgc2ltcGxlLg0KDQpIaSwNCnBndHQgaXMgaW5pdGlhbGl6ZWQganVzdCBhYm92ZSBh
bmQgaXMgc2V0IHRvIFNMVCB3aGVuIHRoZSB2SU9NTVUgaXMgaW4gDQpsZWdhY3kgbW9kZS4NCkJ1
dCBpdCdzIGZpbmUsIHdlIGNhbiBrZWVwIHRoZSBwYXRjaCBhcyBpcyENClRoYW5rcw0KDQpSZXZp
ZXdlZC1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZjxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZp
ZGVuLmNvbT4NCg0KDQoNCj4NCj4gVGhhbmtzDQo+IFpoZW56aG9uZw0KPg0K

