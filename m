Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68DBCA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 15:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqvLW-0004Z6-IJ; Tue, 26 Aug 2025 11:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uqvLO-0004Xu-Ap
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:12:19 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uqvLE-0003nw-Oh
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1756221128; x=1787757128;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eMxlF89noCxHlkPpCMLzT2WKsDpgVzQs3p2hNlsr1og=;
 b=QADT/+L361r8+tdjPIUUtEWq5dDtwyJdhe3csZXej3VUqjwuBTneTr95
 GttJd2AUZrh+PcQqevoIbDQAOlDZtx8Lq5a3auMoP20xIUNoWpHNICKl4
 J4e02+HTx1B2k46eQIZ79O0WCgaSydQoBxLxk1r8275OjDJUbLGsfx+To
 us7zpMO/UEWiOHw4UfxJvagN/duj7PZQdFFTfQc9OQUMwu90iPeQmto+X
 RYsLCImPQf+EpnZYKhncrSnuZNv4TViwCSpOQzaqB8ftBGirHe2xQ3NFm
 ScyEATYZehho9viXjpMRw/ae2E6PV0RnCmT0YphQx/bHdZVa4DTF7O5PF A==;
X-CSE-ConnectionGUID: LNk9bjv8Rs+CZY5Y0YjRSQ==
X-CSE-MsgGUID: WSo/sW30SOeY4MDfMj0S3A==
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; d="scan'208";a="42347736"
X-MGA-submission: =?us-ascii?q?MDG2a07KfE9pihLo5JW9M5KNXn1JzYF2Sk3sQR?=
 =?us-ascii?q?d/WBhexidObM+pz9hqzH+byKuBwFHfAME6KyaJ3AoESbvhB8ru+jPXaz?=
 =?us-ascii?q?sH20VAro4yk0eisTuXgT94o4P3uRk46E1wy9vRyG0cVHm+anP+uSkl03?=
 =?us-ascii?q?a5Rhonh9nzAPZdBrT/6Q1iOQ=3D=3D?=
Received: from mail-norwayeastazon11013012.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.107.159.12])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 26 Aug 2025 17:12:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfjq7A7+kBy0UTze3XVpCteaodJcL+5CDbnzyiKjHFUvmWA3wGTs/BrQXm92Es9ZPGvfk2UEUaQUcmYxsrqrZNe80nI0tKg4z1HiMYNV1U3Mqm0PkanuWnrt07c1+kyCxSbGV7y2Asy5ZaGU6MFG1grVKzj5+BbGKq50b5Zn2Wf7no1WDxs9aEHiRY/zV7Lpunx9Cnb5C8XCWONP4RtOk5aUIUKYFWwre3UV3XcYTcPRztVAHIDCydrXWxKeyrCWcbKG+/OupV0DQI+v/y0SwuRqMbgUWsq3H9Qere6TeyZkFldRjeYdh6NUbpeIJVtvLt92BpJdOooEOhbCqeaygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMxlF89noCxHlkPpCMLzT2WKsDpgVzQs3p2hNlsr1og=;
 b=lfj62VNrin8bWndKrlVUiqESVs483OqRBMNeZtSNeCGoWt7nuEEfvnt3D8h+WmTcdF4HQMbVXFlzRvj5mt38aFZD4k5duEkk+mhRFw27zH73ZDvwD7I4pLs1O2Ub8cN0AW1nI9cTrF5QmyhMYdKnbGl7qwg02ZEIK+m5sVduDoYere9hST7DsFvByVGwRo2p+wUekUITM9Ffr4afU04Fi3VA9BRv8FrBj99h3m2F1OzGQm0wA/OoZE7bUCA/4SY7sSrngc4WprZNh8eepdCtwFBhbqDiJiMHJ/hPj8vHReCnHhFyZlCpF7cI/Yajgt7OfEGsNszrD3B2zDnOJZBW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMxlF89noCxHlkPpCMLzT2WKsDpgVzQs3p2hNlsr1og=;
 b=amLnKQRi6jrMcPSJb3byxqGhCfxmBP6RZqbJ0FqfACQx2/YoB/LVJWwTdAULRr3kZ2KnTtTQXNmocZD6/Vq51qAEfLs0DESeC4xHKmjsExQePqIlKVBqDTB1EZKOo9hIxl+6tpfl8O/QVOiMvexB3EOOeya+bi6W2kQXTKPZZz3nwhY9zDYrKU3cpugaWqxIvXum8VnoFcoQZktgsRZcQlRdOxRXgDS1GOdksBIVpSjSl25wkuEuzzvi0Bv8Tf4Hk1WdxMQxPWT1pK6uaMbwBk3X3ti9NwQLNyzX0SPMrjnxeLZZcK8C67nAj1gnrrprd4CVPBEJyT1u34zQnEf29A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7382.eurprd07.prod.outlook.com (2603:10a6:20b:2af::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 15:11:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 15:11:58 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "odaki@rsg.ci.i.u-tokyo.ac.jp"
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, "sriram.yagnaraman@ericsson.com"
 <sriram.yagnaraman@ericsson.com>, DAMIEN BERGAMINI
 <damien.bergamini@eviden.com>
Subject: Re: [PATCH] pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
Thread-Topic: [PATCH] pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
Thread-Index: AQHcEa47CsbyPv83lkeRMpZl7TSUYbR1FAaA
Date: Tue, 26 Aug 2025 15:11:58 +0000
Message-ID: <8eaba1a296152a4750ac581172fa6ba150d5c8c3.camel@eviden.com>
References: <20250820083953.439635-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250820083953.439635-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7382:EE_
x-ms-office365-filtering-correlation-id: 87bfc6ac-9e0e-47c8-3434-08dde4b2e69e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UDVrcENCcytWeVJNMVZPWkxQOHo0NEFxOTc0a1VaSDJoSlVvOFp5dXN1bDkx?=
 =?utf-8?B?RnNsRnpXOEhqYkh5V0FDZmpXcUFwcEM3TU9LLzRic29RVW8yc1R6akR3ME5T?=
 =?utf-8?B?cjBjVW5qVVJvWUxTVTM1dW1ZOGVsYlZ1QVh4Q0F0L0taVjloS1oyTEZLL3Fp?=
 =?utf-8?B?VG5ycjhFN3o5WEQxUG1nYWl6SmxMTkVJaG1LMWVTK2Z2K3B4dUdZUW41R000?=
 =?utf-8?B?c2ZNUmNtME5abkRGUDNIRXBpL0htVml3VXlWMUxrN1JETEViS0NqTk9wMHZh?=
 =?utf-8?B?eHF6K0M0U2QyQmJOU29oeXVobVZJUlJuaUplOFVWSk1KWlFMOTlhNjQ3bHll?=
 =?utf-8?B?bVZZOERIa3h1OEphc0NhaVVKVXhNL01kZ21QQXM2UzI4VEluUHNoT1FkYnB0?=
 =?utf-8?B?ZlZTYUhvKyt4Umd2R01RQTFKdmQvQ2UyNzhJcGZNVzVELzlEcTNoajlscWx0?=
 =?utf-8?B?dThBVUd4VnBoZHh1a0pVZ0tPQWVqRzhwUTA4Snl0dGI2b3N2b1E1bEtHN2No?=
 =?utf-8?B?a1RDTmxlUmFrenNWQzhsM3ZNeHJ1SXA0L2pxVnBTMWxSa2wwcHl2ZHM2MFl0?=
 =?utf-8?B?Ny9HbGhLVnFmS0dPVnY3NFJWMy9mTTZwTFNnaEFldDRRRnllVmdtb3g0T1h5?=
 =?utf-8?B?VEJTWTFZczY2cDVxMFRwS3NHaEFSVkt1VHI0dVVWcDhnbnBON09lOEphSzRW?=
 =?utf-8?B?UkZYQndCcWtHcjZBSzlZem5ScTRVTFlyUituc3I1a0x3S2NsYU5GdlFiU09r?=
 =?utf-8?B?aWp3c01GbzJRZUh3LzBHNzRzZG5mUGN5dHF0TFJoR1o5eDgwVEQ5MEMxbkNa?=
 =?utf-8?B?UytLb0pPaGNoenpraDZvVGI5QzVoUUVSZTBwZlZoekd5bUM2Q3VNTVhjWkUy?=
 =?utf-8?B?NUxaRVFzWldNR1EzME10dE9kY3RObW55NS9kT0xrbUZ1VUZpOStGUUtibklk?=
 =?utf-8?B?Q3V4YUpWTEVRVjc2SllTUlNadTZTUkh2K1hxRjQ1VUxWajZUWkowTktwZEtB?=
 =?utf-8?B?ZmoxRG9OR0t2S29JSXBoY1VaNnJtNlRVaml5a3A0N2hDaVhQdHZXMkh5TnEy?=
 =?utf-8?B?cHhIVENpNGN4T1l5aGVaM2dLa3VaWFh3T2g4TnFYaEJyZ2p3dU1aSTF0NFJq?=
 =?utf-8?B?ZTdRQzZhQUlZSkZhdTdsMmh6ZjRDRXl0cVhuOXVISnB3TFJPUVRiNE5tZm5u?=
 =?utf-8?B?WGlDM0pYcVVzQVQ5RlpZYUppV1paVVBLRlB3R0x3K0R3WkM3TjNxT3FBUjho?=
 =?utf-8?B?YXdwYWFzQys0dGZQM2g4enUvZGVHMEg4VkxuZkpPRTFRQVZ4SzRnZ2tzNXhX?=
 =?utf-8?B?dm9zdjFPaTVwd0lqY1gzeDlpSllaMzl6VFJSOE9zUGNPazJqMlYxVUNSQUNI?=
 =?utf-8?B?ZHJldUtVWDhuQ0VRMnduMWwxc1N4Y01BS1NDdkU3UHBCWWorN0d0UzVFaStr?=
 =?utf-8?B?N0NyZXFFUEdwRU1mT0hnb3dId0phU2p0UCtiQnczYllBL0NQbTBtdXBXVnQ0?=
 =?utf-8?B?U2lDbEtSTzV1cFBMWlFYWEpadFpBbFpTOVZYaTBsczlPUVMvVkxaM1dBMkEv?=
 =?utf-8?B?VUlDTXpydDZINDF6NVRLR0tSSjJoWDdCdVdkQ1o1V05Bc3BzNUhzQlRRNXlG?=
 =?utf-8?B?d1FMeFpIaFN2WmgzZ2Y5cE9ReEIvRDRsRW9TNHNvWHRmMVBzUGdramREbUc2?=
 =?utf-8?B?NFk1Y085SEQzSTRsbzJyU3cvWEtrMUJSVmJrd1h5eUVqUkpUMFpSRFVxaU5a?=
 =?utf-8?B?My9sM3E3Ykc5Ti9nYVNnODZLQVZBbWY2WGJIUEJIK2R4enNDUGJ0bEJYN0RQ?=
 =?utf-8?B?dmgxdmtYUXdtNHo1cDZUVW80N3k4aW9kRlRLTEhvZlY2YjFDUlp0T0NzejJ2?=
 =?utf-8?B?WUVUeXFaenlnRFlxdm41Q3YrdnhsTWlIdmQ3cU1nWXFtRzJSeWNjY25oSGV1?=
 =?utf-8?B?Q21YTENxNTV6dUJ0RVRFYXlqU3JpQTZrb3Y2eDJWSEV0bUNhNjNsbU9jSTZl?=
 =?utf-8?B?U0xpTU5ybDhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QndQbGtoVmFaMUVHMmNDTzZHb2xKV3o1TlpzQXA0T2dyQXJ5VkNHY2VDZW94?=
 =?utf-8?B?cFFWTVBBa1JRTjFQbzBueTN1YUxkNjBjQUdKSmpPRnc1U2s1M25aVmwzOXJn?=
 =?utf-8?B?amZsaHZ5TlF3Z01ybHFmdDFrekhQd2NLZjBtRmplSTI4VnFDaUFuQVlaTEJB?=
 =?utf-8?B?TU4rSjd6SGZUN01XRGtNdjdYNzZINks1LzVnNFhHamk5VGNpc1grelBkSGZL?=
 =?utf-8?B?b21Pb1JtUzN5dUIySEVxTU83TVFyR2hIaU4wcDFrTklMKzZqSFdEY1lQS25G?=
 =?utf-8?B?VWpQMU94aXZ1S3B6alVNeSs4ZDJoMTA1bWFvaFh2YTg1d3I0NFIxTVVNWGdS?=
 =?utf-8?B?WU5SeFZMTkNFZWMvc0h1bUwxeDhnQ0IyMDZQeDQxaXVxZWJ0RVcyQXU4ZFVm?=
 =?utf-8?B?RlBVaUNHWWJ6dzYyR2wxeklDS1lKeUJiZjN4eFpLa3lnajRjTktVYzMrUGlr?=
 =?utf-8?B?MWd4WCtQNlNDYnp6aTZoZkxDOVEzUUw1VzZJbmxrMVZ6cFRUbkdhUzVVMzJx?=
 =?utf-8?B?ZTJUMVBhZ05SU2kyNGZCTFh5RUxOMFlJMWFrVTJqL0tpcWJYQk5VWW0vL0pX?=
 =?utf-8?B?UGtoZWVVM3FKbHpXWmg5dzZmU1pTdGRQR0c0cFk2ay91L0tmUkw2ZG0xcWFD?=
 =?utf-8?B?ZmZ0WmZMdzBiK2tQOWdnMUVHRDViRG1heU1VVzBOUEhXT1NRZWRJOWhVMWx5?=
 =?utf-8?B?TVA5dUFMRk1oM3Z3ejFsWlRieG1hcDh4RHc5dk9oQ0NSUEo1MHZwWUlFaEc0?=
 =?utf-8?B?SjVMMEdJUldYeEozRDlaZUtMdmRmdjI2bWNjRlZDcUJMdXdBNUVkUFBUbHgv?=
 =?utf-8?B?V2xKQlNaOFBtSGtVQWZMc3VJYlJ1anVIZTg2Mmpmdi9DVUk0bDdaNWtjMEFF?=
 =?utf-8?B?Y0E4VFZxeG9BWnVCMEhLT1U2WTZ1WUN5LzFGR2s2N1NTZlIxV0VvUmx2aE4r?=
 =?utf-8?B?MGc2RlhWUDBuZllvMkFHNHcvRWUxQ0lvSng5U1p5bFc0aFlsSXNpbE9TR0do?=
 =?utf-8?B?MFBCY2J3ckxWS2hOR3pPNFIycW9GaCszMlhiQ1dMcUVQTEFBWW9wQUd2SGJE?=
 =?utf-8?B?RUdMQXhWVHJPVXE4Zk5yenlOSkZQbGF4YzY4NTdmMlJ6d1VpbzVKcWYzd0My?=
 =?utf-8?B?NWdSam9nN0UyNUtEcFd4OE5Id2JCdzZ0UXgvMy9YeVI3Y1FPY2wrSXc4cy9u?=
 =?utf-8?B?NjlFV2p1ZVlmRktkZW56bEw0UG1hdmlEc09SVFkyUVlJd2I2a2RtQXZnUy9R?=
 =?utf-8?B?aElRRmlFNmRwbWJCdUU5aGdwck5ibEU4WTNLcnMrV1lMRnVhNG51VFNFV3Uw?=
 =?utf-8?B?Qm4vRnYwYWtJVmQxaExXUFJ3UG12K0Q1cnhKQ0czVjNxT25hY2llMjNLVE5q?=
 =?utf-8?B?L0wxTGpGYTRJeUsrb2NNQlZwSVZFUU03cUliZjJzREdkM1d2ek55YUVCdEp5?=
 =?utf-8?B?RGVudmRPWVl0OVFJZW9JdDJyLzh4UGE4WjNIOGtpNDJBck0rUDVQaEV0TUhU?=
 =?utf-8?B?eUVIbEJUVGJpTmdkWUZVcHVEUUhWQUpvVXJhNGo2aFE1T3FrdUZ6S3l2YXR2?=
 =?utf-8?B?SjNzQmx0d01OZTBFZm5EVkdiTy9xcTYranlPc0s2ay93QmcyVmVnZy9xNHJP?=
 =?utf-8?B?VkszeG5iUDMvSXl0T1htYlJhbEd0N2pXNmpNbEl3cHlmZTloZG5ZV3V0SDR6?=
 =?utf-8?B?YmtQYmRCWjE4SER6b005YXNoZ0h1ekJXaWQ4U0ZDcmxzMG1yM1J6VjVxcGxI?=
 =?utf-8?B?eDdCdmdQNDRVTTZjd1F1SmZPNGhDZy9SQTFtVlJpT3FPOFBYMVRxV3F2bmhi?=
 =?utf-8?B?NDNpNkxEeW52MkF5YU5RckZiUkl1cUlZejYvZlFkekYrRVFtSXN3Y0sxalpu?=
 =?utf-8?B?djVDaEI5VTd3djRpWnZsM3p4OWFxc2x0eTFOL2M1aGFBQXE3Y2swV1JVTitU?=
 =?utf-8?B?ckpTMU1DUU5CNDZUZ0JpYjFPR0ZWUTBvMFNPK1RHS1VLR3VZaW9SWWE1ZHdP?=
 =?utf-8?B?QjZsUm9hcG5TTHpOVWNwZW1vRE1QTFVlc3hGYlRMY2NPN2ZrbHV6ZmtKS2xS?=
 =?utf-8?B?ajdsR3hIdHZmeHYxWnlXYkloUVBsYjJCeTFmaFIwR1JZTWIxSDZJL2lYRkxt?=
 =?utf-8?B?ZVQ2SWxzV0JnbXhYbmVDdE1BY1krR3dZVHNwOE9LRFhTNHo2ZUZRVmFkaHFU?=
 =?utf-8?Q?vZiTkBAMjtG2+RFxlS4qi04=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3475108D4EBB8245BF6D493E06349AAE@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bfc6ac-9e0e-47c8-3434-08dde4b2e69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 15:11:58.0606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A00MY97+RoAhL887PjbxHsvlMnIzTqu+Sn8AmAwTymd41MCn9Bm3gYdV529TZjC2D2MUZwc8RSVEbCxi6k8xnZ1fJs6ooYoJBLFBLg10+woMfEj2DS8i3+JjGzrodXx4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7382
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

SGkgYWxsLAoKS2luZGx5IHBpbmcsICAKZG8geW91IHRoaW5rIHdlIGNvdWxkIGhhdmUgYSBsb29r
IGF0IHRoaXMgaXNzdWUgYWZ0ZXIgdGhlIHJlbGVhc2Ugb2YgMTAuMT8KClRoYW5rcyAgClw+Y21k
CgpPbiBXZWQsIDIwMjUtMDgtMjAgYXQgMDg6NDEgKzAwMDAsIENMRU1FTlQgTUFUSElFVS0tRFJJ
RiB3cm90ZToKPiBGcm9tOiBEYW1pZW4gQmVyZ2FtaW5pIDxbZGFtaWVuLmJlcmdhbWluaUBldmlk
ZW4uY29tXShtYWlsdG86ZGFtaWVuLmJlcmdhbWluaUBldmlkZW4uY29tKT4KPiAKPiBTdGFydGlu
ZyB3aXRoIGNvbW1pdCBjYWIxMzk4YTYwZWIsIFNSLUlPViBWRnMgYXJlIHJlYWxpemVkIGFzIHNv
b24gYXMgIAo+IHBjaWVfc3Jpb3ZfcGZfaW5pdCgpIGlzIGNhbGxlZC7CoCBCZWNhdXNlIHBjaWVf
c3Jpb3ZfcGZfaW5pdCgpIG11c3QgYmUgIAo+IGNhbGxlZCBiZWZvcmUgcGNpZV9zcmlvdl9wZl9p
bml0X3ZmX2JhcigpLCB0aGUgVkYgQkFScyB0eXBlcyB3b24ndCBiZSAgCj4ga25vd24gd2hlbiB0
aGUgVkYgcmVhbGl6ZSBmdW5jdGlvbiBjYWxscyBwY2llX3NyaW92X3ZmX3JlZ2lzdGVyX2Jhcigp
Lgo+IAo+IFRoaXMgYnJlYWtzIHRoZSBtZW1vcnkgcmVnaW9ucyBvZiB0aGUgVkZzIChmb3IgaW5z
dGFuY2Ugd2l0aCBpZ2J2Zik6Cj4gCj4gJCBsc3BjaSAgCj4gLi4uICAKPiDCoMKgwqAgUmVnaW9u
IDA6IE1lbW9yeSBhdCAyODFhMDAwMDAgKDY0LWJpdCwgcHJlZmV0Y2hhYmxlKSBbdmlydHVhbF0g
W3NpemU9MTZLXSAgCj4gwqDCoMKgIFJlZ2lvbiAzOiBNZW1vcnkgYXQgMjgxYTIwMDAwICg2NC1i
aXQsIHByZWZldGNoYWJsZSkgW3ZpcnR1YWxdIFtzaXplPTE2S10KPiAKPiAkIGluZm8gbXRyZWUg
IAo+IC4uLiAgCj4gYWRkcmVzcy1zcGFjZTogcGNpX2JyaWRnZV9wY2lfbWVtICAKPiDCoCAwMDAw
MDAwMDAwMDAwMDAwLWZmZmZmZmZmZmZmZmZmZmYgKHByaW8gMCwgaS9vKTogcGNpX2JyaWRnZV9w
Y2kgIAo+IMKgwqDCoCAwMDAwMDAwMDgxYTAwMDAwLTAwMDAwMDAwODFhMDNmZmYgKHByaW8gMSwg
aS9vKTogaWdidmYtbW1pbyAgCj4gwqDCoMKgIDAwMDAwMDAwODFhMjAwMDAtMDAwMDAwMDA4MWEy
M2ZmZiAocHJpbyAxLCBpL28pOiBpZ2J2Zi1tc2l4Cj4gCj4gYW5kIGNhdXNlcyBNTUlPIGFjY2Vz
c2VzIHRvIGZhaWw6Cj4gCj4gwqDCoMKgIEludmFsaWQgd3JpdGUgYXQgYWRkciAweDI4MUEwMTUy
MCwgc2l6ZSA0LCByZWdpb24gJyhudWxsKScsIHJlYXNvbjogcmVqZWN0ZWQgIAo+IMKgwqDCoCBJ
bnZhbGlkIHJlYWQgYXQgYWRkciAweDI4MUEwMEM0MCwgc2l6ZSA0LCByZWdpb24gJyhudWxsKScs
IHJlYXNvbjogcmVqZWN0ZWQKPiAKPiBUbyBmaXggdGhpcywgYSB0eXBlIHBhcmFtZXRlciBpcyBh
ZGRlZCB0byBwY2llX3NyaW92X3ZmX3JlZ2lzdGVyX2JhcigpICAKPiB0byBpbmRpY2F0ZSB0aGUg
QkFSIHR5cGUuIEl0IHNob3VsZCBiZSBzZXQgdG8gdGhlIHNhbWUgdmFsdWUgYXMgaW4gdGhlICAK
PiBwY2llX3NyaW92X3BmX2luaXRfdmZfYmFyKCkgY2FsbC4KPiAKPiBGaXhlczogY2FiMTM5OGE2
MGViICgicGNpZV9zcmlvdjogUmV1c2UgU1ItSU9WIFZGIGRldmljZSBpbnN0YW5jZXMiKSAgCj4g
U2lnbmVkLW9mZi1ieTogRGFtaWVuIEJlcmdhbWluaSA8W2RhbWllbi5iZXJnYW1pbmlAZXZpZGVu
LmNvbV0obWFpbHRvOmRhbWllbi5iZXJnYW1pbmlAZXZpZGVuLmNvbSk+ICAKPiBTaWduZWQtb2Zm
LWJ5OiBDbGVtZW50IE1hdGhpZXUtLURyaWYgPFtjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVu
LmNvbV0obWFpbHRvOmNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tKT4gIAo+IC0tLSAg
Cj4gwqBkb2NzL3BjaWVfc3Jpb3YudHh0wqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0gIAo+IMKgaHcv
bmV0L2lnYnZmLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDggKysrKysrLS0gIAo+IMKg
aHcvbnZtZS9jdHJsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQgKysrLSAgCj4gwqBo
dy9wY2kvcGNpLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzIC0tLSAgCj4gwqBo
dy9wY2kvcGNpZV9zcmlvdi5jwqDCoMKgwqDCoMKgwqDCoCB8IDYgKystLS0tICAKPiDCoGluY2x1
ZGUvaHcvcGNpL3BjaWVfc3Jpb3YuaCB8IDIgKy0gIAo+IMKgNiBmaWxlcyBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZG9jcy9wY2ll
X3NyaW92LnR4dCBiL2RvY3MvcGNpZV9zcmlvdi50eHQgIAo+IGluZGV4IGFiMjE0MjgwN2YuLjc3
ZDYxOGIzNmYgMTAwNjQ0ICAKPiAtLS0gYS9kb2NzL3BjaWVfc3Jpb3YudHh0ICAKPiArKysgYi9k
b2NzL3BjaWVfc3Jpb3YudHh0ICAKPiBAQCAtODMsNyArODMsNyBAQCBzZXR0aW5nIHVwIGEgQkFS
IGZvciBhIFZGLiAgCj4gwqDCoMKgwqDCoMKgIHBjaWVfYXJpX2luaXQoZCwgMHgxMDApOyAgCj4g
wqDCoMKgwqDCoMKgIC4uLiAgCj4gwqDCoMKgwqDCoMKgIG1lbW9yeV9yZWdpb25faW5pdChtciwg
Li4uICkgIAo+IC3CoMKgwqDCoMKgIHBjaWVfc3Jpb3ZfdmZfcmVnaXN0ZXJfYmFyKGQsIGJhcl9u
ciwgbXIpOyAgCj4gK8KgwqDCoMKgwqAgcGNpZV9zcmlvdl92Zl9yZWdpc3Rlcl9iYXIoZCwgYmFy
X25yLCBiYXJfdHlwZSwgbXIpOyAgCj4gwqDCoMKgwqDCoMKgIC4uLiAgCj4gwqDCoMKgIH0gIAo+
IMKgICAKPiBkaWZmIC0tZ2l0IGEvaHcvbmV0L2lnYnZmLmMgYi9ody9uZXQvaWdidmYuYyAgCj4g
aW5kZXggMzFkNzJjNDk3Ny4uODhkZDhmYjUxNiAxMDA2NDQgIAo+IC0tLSBhL2h3L25ldC9pZ2J2
Zi5jICAKPiArKysgYi9ody9uZXQvaWdidmYuYyAgCj4gQEAgLTI1MSwxMCArMjUxLDE0IEBAIHN0
YXRpYyB2b2lkIGlnYnZmX3BjaV9yZWFsaXplKFBDSURldmljZSAqZGV2LCBFcnJvciAqKmVycnAp
ICAKPiDCoCAgCj4gwqDCoMKgwqAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZzLT5tbWlvLCBPQkpF
Q1QoZGV2KSwgJm1taW9fb3BzLCBzLCAiaWdidmYtbW1pbyIsICAKPiDCoMKgwqDCoMKgwqDCoMKg
IElHQlZGX01NSU9fU0laRSk7ICAKPiAtwqDCoMKgIHBjaWVfc3Jpb3ZfdmZfcmVnaXN0ZXJfYmFy
KGRldiwgSUdCVkZfTU1JT19CQVJfSURYLCAmcy0+bW1pbyk7ICAKPiArwqDCoMKgIHBjaWVfc3Jp
b3ZfdmZfcmVnaXN0ZXJfYmFyKGRldiwgSUdCVkZfTU1JT19CQVJfSURYLCAgCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0lf
QkFTRV9BRERSRVNTX01FTV9UWVBFXzY0IHwgIAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJX0JBU0VfQUREUkVTU19NRU1f
UFJFRkVUQ0gsICZzLT5tbWlvKTsgIAo+IMKgICAKPiDCoMKgwqDCoCBtZW1vcnlfcmVnaW9uX2lu
aXQoJnMtPm1zaXgsIE9CSkVDVChkZXYpLCAiaWdidmYtbXNpeCIsIElHQlZGX01TSVhfU0laRSk7
ICAKPiAtwqDCoMKgIHBjaWVfc3Jpb3ZfdmZfcmVnaXN0ZXJfYmFyKGRldiwgSUdCVkZfTVNJWF9C
QVJfSURYLCAmcy0+bXNpeCk7ICAKPiArwqDCoMKgIHBjaWVfc3Jpb3ZfdmZfcmVnaXN0ZXJfYmFy
KGRldiwgSUdCVkZfTVNJWF9CQVJfSURYLCAgCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0lfQkFTRV9BRERSRVNTX01FTV9U
WVBFXzY0IHwgIAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgUENJX0JBU0VfQUREUkVTU19NRU1fUFJFRkVUQ0gsICZzLT5tc2l4
KTsgIAo+IMKgICAKPiDCoMKgwqDCoCByZXQgPSBtc2l4X2luaXQoZGV2LCBJR0JWRl9NU0lYX1ZF
Q19OVU0sICZzLT5tc2l4LCBJR0JWRl9NU0lYX0JBUl9JRFgsIDAsICAKPiDCoMKgwqDCoMKgwqDC
oMKgICZzLT5tc2l4LCBJR0JWRl9NU0lYX0JBUl9JRFgsIDB4MjAwMCwgMHg3MCwgZXJycCk7ICAK
PiBkaWZmIC0tZ2l0IGEvaHcvbnZtZS9jdHJsLmMgYi9ody9udm1lL2N0cmwuYyAgCj4gaW5kZXgg
ZjVlZTZiZjI2MC4uMzVhODJkMjAzNyAxMDA2NDQgIAo+IC0tLSBhL2h3L252bWUvY3RybC5jICAK
PiArKysgYi9ody9udm1lL2N0cmwuYyAgCj4gQEAgLTg3MDksNyArODcwOSw5IEBAIHN0YXRpYyBi
b29sIG52bWVfaW5pdF9wY2koTnZtZUN0cmwgKm4sIFBDSURldmljZSAqcGNpX2RldiwgRXJyb3Ig
KiplcnJwKSAgCj4gwqDCoMKgwqDCoMKgwqDCoCBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24o
Jm4tPmJhcjAsIDAsICZuLT5pb21lbSk7ICAKPiDCoCAgCj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAo
cGNpX2lzX3ZmKHBjaV9kZXYpKSB7ICAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwY2llX3Ny
aW92X3ZmX3JlZ2lzdGVyX2JhcihwY2lfZGV2LCAwLCAmbi0+YmFyMCk7ICAKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwY2llX3NyaW92X3ZmX3JlZ2lzdGVyX2JhcihwY2lfZGV2LCAwLCAgCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJX0JBU0VfQUREUkVTU19TUEFDRV9NRU1PUlkgfCAgCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJX0JBU0VfQUREUkVTU19NRU1fVFlQRV82NCwgJm4tPmJh
cjApOyAgCj4gwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2UgeyAgCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHBjaV9yZWdpc3Rlcl9iYXIocGNpX2RldiwgMCwgUENJX0JBU0VfQUREUkVTU19TUEFD
RV9NRU1PUlkgfCAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBQQ0lfQkFTRV9BRERSRVNTX01FTV9UWVBFXzY0LCAmbi0+YmFyMCk7
ICAKPiBkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaS5jIGIvaHcvcGNpL3BjaS5jICAKPiBpbmRleCBj
NzBiNWNlZWJhLi40ZmUyNjI2ZjllIDEwMDY0NCAgCj4gLS0tIGEvaHcvcGNpL3BjaS5jICAKPiAr
KysgYi9ody9wY2kvcGNpLmMgIAo+IEBAIC0xNDkwLDkgKzE0OTAsNiBAQCB2b2lkIHBjaV9yZWdp
c3Rlcl9iYXIoUENJRGV2aWNlICpwY2lfZGV2LCBpbnQgcmVnaW9uX251bSwgIAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA6IHBjaV9nZXRfYnVzKHBj
aV9kZXYpLT5hZGRyZXNzX3NwYWNlX21lbTsgIAo+IMKgICAKPiDCoMKgwqDCoCBpZiAocGNpX2lz
X3ZmKHBjaV9kZXYpKSB7ICAKPiAtwqDCoMKgwqDCoMKgwqAgUENJRGV2aWNlICpwZiA9IHBjaV9k
ZXYtPmV4cC5zcmlvdl92Zi5wZjsgIAo+IC3CoMKgwqDCoMKgwqDCoCBhc3NlcnQoIXBmIHx8IHR5
cGUgPT0gcGYtPmV4cC5zcmlvdl9wZi52Zl9iYXJfdHlwZVtyZWdpb25fbnVtXSk7ICAKPiAtICAK
PiDCoMKgwqDCoMKgwqDCoMKgIHItPmFkZHIgPSBwY2lfYmFyX2FkZHJlc3MocGNpX2RldiwgcmVn
aW9uX251bSwgci0+dHlwZSwgci0+c2l6ZSk7ICAKPiDCoMKgwqDCoMKgwqDCoMKgIGlmIChyLT5h
ZGRyICE9IFBDSV9CQVJfVU5NQVBQRUQpIHsgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
ZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb25fb3ZlcmxhcChyLT5hZGRyZXNzX3NwYWNlLCAgCj4g
ZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2llX3NyaW92LmMgYi9ody9wY2kvcGNpZV9zcmlvdi5jICAK
PiBpbmRleCA4YTRiZjBkNmY3Li5lZWRjZTZiZTFkIDEwMDY0NCAgCj4gLS0tIGEvaHcvcGNpL3Bj
aWVfc3Jpb3YuYyAgCj4gKysrIGIvaHcvcGNpL3BjaWVfc3Jpb3YuYyAgCj4gQEAgLTI0MiwxMyAr
MjQyLDExIEBAIHZvaWQgcGNpZV9zcmlvdl9wZl9pbml0X3ZmX2JhcihQQ0lEZXZpY2UgKmRldiwg
aW50IHJlZ2lvbl9udW0sICAKPiDCoMKgwqDCoCBkZXYtPmV4cC5zcmlvdl9wZi52Zl9iYXJfdHlw
ZVtyZWdpb25fbnVtXSA9IHR5cGU7ICAKPiDCoH0gIAo+IMKgICAKPiArLyogYHR5cGVgIG11c3Qg
bWF0Y2ggdGhlIHR5cGUgcGFzc2VkIHRvIHBjaWVfc3Jpb3ZfcGZfaW5pdF92Zl9iYXIoKSAqLyAg
Cj4gwqB2b2lkIHBjaWVfc3Jpb3ZfdmZfcmVnaXN0ZXJfYmFyKFBDSURldmljZSAqZGV2LCBpbnQg
cmVnaW9uX251bSwgIAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNZW1vcnlSZWdpb24gKm1lbW9yeSkgIAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
aW50OF90IHR5cGUsIE1lbW9yeVJlZ2lvbiAqbWVtb3J5KSAgCj4gwqB7ICAKPiAtwqDCoMKgIHVp
bnQ4X3QgdHlwZTsgIAo+IC0gIAo+IMKgwqDCoMKgIGFzc2VydChkZXYtPmV4cC5zcmlvdl92Zi5w
Zik7ICAKPiAtwqDCoMKgIHR5cGUgPSBkZXYtPmV4cC5zcmlvdl92Zi5wZi0+ZXhwLnNyaW92X3Bm
LnZmX2Jhcl90eXBlW3JlZ2lvbl9udW1dOyAgCj4gwqAgIAo+IMKgwqDCoMKgIHJldHVybiBwY2lf
cmVnaXN0ZXJfYmFyKGRldiwgcmVnaW9uX251bSwgdHlwZSwgbWVtb3J5KTsgIAo+IMKgfSAgCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaWVfc3Jpb3YuaCBiL2luY2x1ZGUvaHcvcGNp
L3BjaWVfc3Jpb3YuaCAgCj4gaW5kZXggYWVhYTM4Y2YzNC4uYjY3NDQ5ZjhiYSAxMDA2NDQgIAo+
IC0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaWVfc3Jpb3YuaCAgCj4gKysrIGIvaW5jbHVkZS9ody9w
Y2kvcGNpZV9zcmlvdi5oICAKPiBAQCAtMzksNyArMzksNyBAQCB2b2lkIHBjaWVfc3Jpb3ZfcGZf
aW5pdF92Zl9iYXIoUENJRGV2aWNlICpkZXYsIGludCByZWdpb25fbnVtLCAgCj4gwqAgIAo+IMKg
LyogSW5zdGFudGlhdGUgYSBiYXIgZm9yIGEgVkYgKi8gIAo+IMKgdm9pZCBwY2llX3NyaW92X3Zm
X3JlZ2lzdGVyX2JhcihQQ0lEZXZpY2UgKmRldiwgaW50IHJlZ2lvbl9udW0sICAKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
TWVtb3J5UmVnaW9uICptZW1vcnkpOyAgCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ4X3QgdHlwZSwgTWVtb3J5UmVn
aW9uICptZW1vcnkpOyAgCj4gwqAgIAo+IMKgLyoqICAKPiDCoCAqIHBjaWVfc3Jpb3ZfcGZfaW5p
dF9mcm9tX3VzZXJfY3JlYXRlZF92ZnMoKSAtIEluaXRpYWxpemUgUEYgd2l0aCB1c2VyLWNyZWF0
ZWQK

