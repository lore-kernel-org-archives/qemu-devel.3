Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FABC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRf-000815-1m; Tue, 02 Jul 2024 01:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRc-0007yM-3y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:48 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRY-0006Uc-GE
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899564; x=1751435564;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Hc5l9iMS0hIGeK1Yyp7kRyUFTRfoq0lTUk/Ikx1qcEk=;
 b=uDEp6owyrXyG5/dBrUxflW0OIFhzmXrhET8vMHzqYJt4/PTXFtxBNGEC
 LfIzgeHPLkSfU+lSDm4WKLNp1cgDUgs2WbqDCBAQO8odTXknzNWi2S2sN
 ScySxz3iDsbrksu6isrqSi0KDS2moLhx7tvR+HS3+i2paFr2q1LZIGcu9
 N8RVi2dze7ixH5t94BOBdQdBTORVBehM5pc9khPkV1K8eps6ZtujgmAD9
 lyMt9iEaEf34vn/SnDvR8s4C0rUihDolrnob1uO97Ja4HoTf2MArZz2pk
 zuIVKmvizgnePGAwF05YHe+bAWbyEn3YbueIMLATHhXRbviYhLHHTSjWt Q==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15721523"
X-MGA-submission: =?us-ascii?q?MDHunFQvuKlY5IMC5+XIvZjU2JALoYqSx/h1PG?=
 =?us-ascii?q?dLHYYiTj9XkbnKuwVKQk5RNF4MR2xFQbTuwkCrOMlsNCF6F/50supxmn?=
 =?us-ascii?q?QOmIJLxZysBXEQyyjTUdxOMr1uhx8TyB2a8d1mBURuiNpmusnBAnJYRp?=
 =?us-ascii?q?DWagwSy7rdrzJgmQdGkbYDIg=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:40 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by98qBR8l2/abxeYVmlgroLV7sGBsrz8xSPy30pMwq+kFsRm7Z9kKjwh0YNZBsV4F8CW5buSoQ7DbWplRETUYDqsyfvGlNKtK4v+kVnmYqkrK7vgRWWG6REOKg2+g1CAZeJD7lqF1hZrNtUii80l4Ida6v2KlnjZC6jvjR1VmuWQMEm5kkAFK2zefILUqUQOeBFHHANV2dubFcHAP++KdNx9cNcPPmwwoD1KSePTML7Ss54oYtF/WMQSQDoGiVraTEepm3TZ6hhZxfGKnZyY90M+2EyXkSk8bQu2xcff8GIAk8uB7rWHm6ddsfuHBugxD2Bzur1M9i+4x8Qxp3dLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc5l9iMS0hIGeK1Yyp7kRyUFTRfoq0lTUk/Ikx1qcEk=;
 b=NVFL8dAg4/siA4/0vu7H5j6ZZz+yBHJsN3l/s7529qeN4XNYBHHtEntpfoZ7xAQ5PSpJl7uBkMQ9/GGv9Ayq0YY/pFdVvKeaCpNiXNGh5dSdYqQFz9vs+TejFj8fzoA7RPkQRcVi0cP1xeRypW3JD+Z+N/Zi7LW8JAfDFrIjsHeRClkrsy+hU1pgqWF+9rrFSKKvhEXi5FEaBPDV3ud0iZsAGEw11R4cJ5J4JKcofkbgLP2o0/7p6vDLFqH11B4XzHjr9C/Qbt1Q46MPkoaFXtl+vgeSyTrnTnWzS4S3GRg2mq3q23RMtNILG3Pp8v5Tq+0bJ2w5NPIAjGaHKXq7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc5l9iMS0hIGeK1Yyp7kRyUFTRfoq0lTUk/Ikx1qcEk=;
 b=U98AoJY3TQQ85syHWVy8+d2ktrh8nOFki9Gnt6myccm0RYI1uDaPOHiy6NC3Qgeq/8qtidARSnZhk09akD3Lm5TcR/c2BRIbV3QwlNeSG9uJ65HpM5jEsPrdcGY/0cGDE+vTJf08ucLXqmoK5JUkCfnpk0I183K/geeJKWbkvKNmo5qaU0RbnofYs8M6v10oyka/AGEz9zQJ12noYX6wWDsqmw1WafnTCrADpnGPl9K08E1Y/I9y0y64IvhRwZngn29D4uEz9qdzVps4Z4kA25zCxF23TPOEMTxQk8mIx2a+H3yviu485xA0CG1SS8Kz9bJ2IGkSpTF0xFjihNhgow==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:39 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 11/22] memory: store user data pointer in the IOMMU
 notifiers
Thread-Topic: [PATCH ats_vtd v5 11/22] memory: store user data pointer in the
 IOMMU notifiers
Thread-Index: AQHazEQLU37p2/DTDEm/CBKcsLSUAw==
Date: Tue, 2 Jul 2024 05:52:38 +0000
Message-ID: <20240702055221.1337035-12-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: ab6001f5-e86c-4024-a3bd-08dc9a5b2e59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?azgycFh2MWM0R2RZa25pMGJJMEN3bUNsekNnTWNCWkkvU2lqYm5icFh6NUxQ?=
 =?utf-8?B?UGZQNm41KzlCSnBzaUE0N1NTV2JEY0VpOE8rejMyaGozUlFLZU9uZTJSeUgv?=
 =?utf-8?B?SDBlYzZ0eWlhbzFDb0Y2b3JJQjUvYTdYM2gyRk5zK1ltM2o2eWlFR2hSdS9H?=
 =?utf-8?B?eWl3dFRZbk5VOVN1ajJ5TDJ6UjhLVHpWeUkyWGx4SHRsSXZVN0gzS05MZEVo?=
 =?utf-8?B?Q3FrRW1rYlFoYjBobVRhUFFxa0c1bXFkL3BLNEgyQVpYY1RxdXVFcVAzRDU4?=
 =?utf-8?B?WjFxUGoyNVUvOHdVWmVrV0hrbUE4S2h6Mk1qd1E1OW1vRTF0OVl0UmNmQXZE?=
 =?utf-8?B?M2NDb1Z3UWJ0cXB6RWdPSCt3Q3RVWFBNZE9tSkZpdlNNcEZONVpCYVVjdTA3?=
 =?utf-8?B?YzZIR3pTanNsMGpnaG1KcmRyS2ZMQkNMZGQ4clpzT2dPMWJzZnBxQXJPdDBR?=
 =?utf-8?B?TEs5aDM5TFNqTHU2cGhHb0ZaYTFFMHBhblIyWlNNc0VSNWJrOFoyVTdFUXJG?=
 =?utf-8?B?eHdvc0cvenA4aEFUMVRxTEEyQ0lUNDY3WnMwUmNsdXVBVnhEOThBdDNvRlQ5?=
 =?utf-8?B?Z2xzdkRFdmV1SXpCU2xtSGpKRm1kcTBzR3hFNVFuTGRUQWRwMEFSN2dFZ2tL?=
 =?utf-8?B?d0liSk5CVDJNTTZqWGhWTHhyU2w5T21CQVZxc1ZkU3NOYVg4eEV3aVBTYWFC?=
 =?utf-8?B?VEE1ZlFhejRWaG1PUE9PTWQ0V1JhcnFSbThKWHVkOUJpUHJnQUV3MXh3UnhF?=
 =?utf-8?B?NzhXQnl5N1VCVGo4clJHUDN3cVo3ZUMrUk9QbHlqcE5tbUlvK01TYVF1bTR1?=
 =?utf-8?B?aW1lVmlTN21QMW4vWXlycXBUOXB4Ujk5V1dkZVpqWllXVjJLQkV2eXVkcjZJ?=
 =?utf-8?B?S0tXbE5WeEFCNlBHM2cvdXZ6L0hVYTRrL2x0L3VMUWRwTU1JWkl0eno3bGZG?=
 =?utf-8?B?WnBDNXNocWkzd0xGMFY2Tld1bnNnQUxOUFh0M1pObEt0KzJlRXkzTUN1bi8z?=
 =?utf-8?B?QmRLbWs5V01tODk2SUhOUWZrc1lGVDd4RWMyZWJrdnRsdWRGd3ZER3duSkxD?=
 =?utf-8?B?RFM1anNiTWF2U1pPYzNxakpMUW9acnNKVnNtbm94MCtNTUtWVkZDM3Y1eVlx?=
 =?utf-8?B?bzJFa0phWWVTcnM3S3VtMENka2k0RGZXYzgvM2RSY09GT2Vya0VHMmg3OWt0?=
 =?utf-8?B?KzZGMWxDWERMdlpqaTdzWWw5elhVSW1ZeFhseU5RbjN2bHFRWjlQZlU3NWFG?=
 =?utf-8?B?MGRMVjZPZjc3TW9rN0ZtaHY5R29FZldEb1h4alozbHNBNkQyNFlqVUF3M2w1?=
 =?utf-8?B?ODBVN1A5TDVVa2Q4WXM0YXJOT0JOaTRhT2g5YUhEOE1nejZPV2hHaFdDeHFx?=
 =?utf-8?B?ZitlREFHaVJDNDVxTnBwVEtNWDU5SW9HYThFbUJLSTlyeUNNVzM2OFQ2c0U1?=
 =?utf-8?B?eEJVRlVRZTZnSDZrYjl5QzNuZDRISnlmdTZNOHpBeHFqL08vdWZzbkNWRUZn?=
 =?utf-8?B?ajVZL0ZzQ2Q3Nm5xKytpcWNjMThGWUEyZWFieUxvVGlta2F1dDd3Y0JsNmpB?=
 =?utf-8?B?Y3BYNDgvV3hqOHQzTW51OWZ1c1hJMXphSnkzbVRpOEpCZWdtQWc4TFVGL2pn?=
 =?utf-8?B?d2hQV21TRllLQkFFU1Q3Tzk3dERaTzJOaHAxcU9FYlBUME5LTmZEU2hzdnFr?=
 =?utf-8?B?S2J5akdrMUdnL3BFRUp5V1JEbEJaVytsa1RRcjRKcmVuSFJML2JxSEtjT1cz?=
 =?utf-8?B?L3FKdlNuVVZlcTZ2S3hoMWxnVHMzZHpqejlYcnYxOWlCNytacVFTZS9mb1gv?=
 =?utf-8?B?cktKRExNRElzalRNVzlxNm9YU0hLblV2RWlVY01ucVU5dkhmdVppZkd4SWQz?=
 =?utf-8?B?Rnp3VitLUk0yRjIvQVhycGtNK2kwNzBibVpOa0dwcVk5UHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU1sUzF6eWR4S3ViVSttTUxjNFJid21pcFpwTVA2SnVyUnhTU0kvWUE4NzBC?=
 =?utf-8?B?dzhlZXMvSHcrRHBiYldSREdlcE5DV21VN0lHZXo3TU5aY09pZEN5YTkyZW1N?=
 =?utf-8?B?WFhiaEcycE04UWc5OGpoRkRiaTBIdExLZ05HbXJ1eFB6TGZHdnUwWmxTeCtQ?=
 =?utf-8?B?SzFGMitqMkhka3NPTnZMSzF0dW5iQXJZYlVUY2ViTUxBSFRITWdlSnlmTE8v?=
 =?utf-8?B?UFJEdHA1bW1QdFNqTU00Rm0wbCtma1gyOUYrYWxzTW4xTElKWDhEZmw0UjVM?=
 =?utf-8?B?WjYrSmRXZk00MFNuSlllQXpTVlV0a0hTSjVnQXNoZ0cxaVkrcWl0dkMvQ3pi?=
 =?utf-8?B?RFFDQmZMSkNwWDZvaElFRko1ZU05dDNQZGZVR3R1RmRYNTByMzZzb3dTRlE3?=
 =?utf-8?B?SW5TcXNUbEsxaUVhL3gyWlgySDVTNmJaZ2Naa1VJUHlZbWNFMUhkMnlld00z?=
 =?utf-8?B?ZkpzOHNHQktCaW54enVBVldJZnRWeVhqdFhNQWd0Z0pvSWswY215dFJiQmdz?=
 =?utf-8?B?ZEtLTGRyTCtEVzdiem0vaExkK0s3emJNVzdTN2dXNE5zMjVsRXJqL0RDRHBH?=
 =?utf-8?B?UnVMRC9kcnlYRE1GM0l3b3l6MmxEOVhsRDNvc2Ewelcyd0pZZVBMN0FZcmF1?=
 =?utf-8?B?Uy9TLzh3dGF1dzhKd3RpdDJ4cXphNlpPd3NUVGNwREJEdGpMc1dvazgwb2ZM?=
 =?utf-8?B?ajVXTTFwOVhDNElMd2JNOTFsZWpOOHhWQm42RmlzT055UjZUa29zY1gyakhW?=
 =?utf-8?B?eXpYRmoyalFLVUFVeWpZQzR4aHR4SWpwV2toRGxNUkZweVhGVllNendCbDV0?=
 =?utf-8?B?dFUvVW8rSnVIaWpkMFdDWWw0cjJYRFp4NDJ6enhkc2dOM0pmazViRTBXSFZZ?=
 =?utf-8?B?QTlTQ2R6WWg1eGNNeTN3LzhDQWtjTHNta1ZnaWpCUEc3eUJvZTM4VXpyNWZa?=
 =?utf-8?B?a3lYakJMd2V3QUUxeVhhUVlnRVJTaUd2Tlo2bDN4cjlrcFJabGVKVkMzM1hm?=
 =?utf-8?B?cHh3UThqVUlFbmkrd3l2MkVwNHQ0MlNCQnFIRHN0dWxKVlFqbzFvVUVReDFp?=
 =?utf-8?B?Tkk4bUtjT0ZCZkxQd2pEMVh3MnRtbmlKUTFTTHhuU3B6bTY3K2lZQTRORzUz?=
 =?utf-8?B?SmR2VzJIVWdCTy9sTkZ4eUdWWEpUVm1iL3pycGIxVlhTdE85MlpiVzdKUTZk?=
 =?utf-8?B?eTllL1J2R21pVDQyaVowR1IwUzBmbkh6bklSUncxNVRENE1ybTRibnZ3NkIw?=
 =?utf-8?B?RTNGUWxEMS9mend0elJ6SUpWK0o1djh0M3RILzU1RWFzbHRWdmpWa05XbXV4?=
 =?utf-8?B?VGtBb0kvVEVGTzQ3Y2lkcC9xVmdWZW9qWWpoTU84SytsdVpVdkJweVF3N3gw?=
 =?utf-8?B?VTJabWxkMXVSU1grVzBNbE14M0NnMnIwWEFVS0VOSEl4U05yVzZIeFR5dWN5?=
 =?utf-8?B?ZFpEWVc0MUhNaTFVelJHRnJjY2p1aUExdm9GVlRPZmhYOFNDMTkwRTN0TGRk?=
 =?utf-8?B?bG5HdGlQUWJNT0xncTU3QUVoK0R2ZGhFbEhJTHFrTDN5dDhGZ3VQK0pnZVFr?=
 =?utf-8?B?R2F6UHJNZ05VVW1jREtXQlNvUmNtaXRMMUFENlhIbUR6SGQ1U05YcVlZUEQz?=
 =?utf-8?B?QVB4cmZFUFJqTUx1Z1RUNENNR2ZNdDBvNkswc25hNjc1YTJpV2xWeGR0dldO?=
 =?utf-8?B?a29GdTFGYnpmQXpiWEpIOVZ1cVlCaGZZK0JMRDZpMGEzRk1WMU5ERGYvaTJK?=
 =?utf-8?B?UXV2Z1JWckY4Z3V6dHRkT3lVTm9ncklRZ3RkZ1JuclFmMlQrWW5kRE9UMGV2?=
 =?utf-8?B?TDdIQ0Vpc2pzb3lya1p6ZGZIUjdPUXEyK2piVzl4QTlyMVZHM1hKcEdqdVJD?=
 =?utf-8?B?YU9Bb29wTkJIUHlVREZwUW1WbjEyY1lsZEE1WmpiemJCNXNLWEIzWjFadlZL?=
 =?utf-8?B?bTd3eHZjMHpCK0xMODV5QmphbmdnTTFPVlJwcEJwRGtJR3dTQmV1djZFRE04?=
 =?utf-8?B?K2x1b3gvSGpwNDNiK1BCbjdzNG1CcTRBcFIzZG5WQkNpaXpPN2Nid2tlTmlM?=
 =?utf-8?B?Tm1Ya0xqZmhVNjB3WUE1YzlxeE5Ba1ZkSHU4NGdtczZJWnJLRXZoaHR1LzNE?=
 =?utf-8?B?UFVqY0RFMVR5VFplUTY1bjhvWi9MZ2RDeHNscnczOWl5WmFFOGVoemZoYjl2?=
 =?utf-8?Q?xuE1cRC5iNeJCmJ3ZU60Mfc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E0C635EF0AAA4499BEC000EC77CEDC1@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6001f5-e86c-4024-a3bd-08dc9a5b2e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:39.0001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +eQstc+CG2EtDg3wfoSkSyGXj1KZ5icQR+LCQ34pDfHX7+biGTTKUAHIr+V1Tf2NxH3ibwH6knSTaQfnpXS9CcOhsaRmlK8chXc1jRFGUr2qfsWGFXrJ4MAvNTM0LKDD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoaXMgd2lsbCBoZWxwIGRldmVsb3BlcnMgb2Ygc3ZtIGRldmljZXMgdG8gdHJh
Y2sgYSBzdGF0ZQ0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVt
ZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGluY2x1ZGUvZXhlYy9tZW1vcnku
aCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9leGVjL21lbW9yeS5oIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oDQppbmRleCBhYThl
MTE0ZTc3Li5iZjkxYzRiZWQ3IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5oDQor
KysgYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCkBAIC0yMDMsNiArMjAzLDcgQEAgc3RydWN0IElP
TU1VTm90aWZpZXIgew0KICAgICBod2FkZHIgc3RhcnQ7DQogICAgIGh3YWRkciBlbmQ7DQogICAg
IGludCBpb21tdV9pZHg7DQorICAgIHZvaWQgKm9wYXF1ZTsNCiAgICAgUUxJU1RfRU5UUlkoSU9N
TVVOb3RpZmllcikgbm9kZTsNCiB9Ow0KIHR5cGVkZWYgc3RydWN0IElPTU1VTm90aWZpZXIgSU9N
TVVOb3RpZmllcjsNCi0tIA0KMi40NS4y

