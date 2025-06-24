Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E9DC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 05:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTvnr-0005Ao-51; Tue, 24 Jun 2025 01:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uTvnp-0005AX-Dz
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 01:02:37 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uTvnm-0006MQ-0C
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 01:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1750741354; x=1782277354;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yMwzbgep8pR0ZqOiopa93nBduYQWI3/lfoNWpUHu69c=;
 b=oQXY1GHQO0eeOLLqEHYyNF/Rd8JfSxd7v6raeEm3jar7PpeLPPbdrGqi
 s/rQQEDMXvrKDdSd2AkH+Q6AhOscMWrXI5ahy5BWFAvZqhx/qRGJF1fvM
 NKXMR2S5tZbK4l3+TCOhNCsuuz91N86iJP9XaH99JN1AqF64rVXPWJKnI
 4bGbFoes9HaApxgvRTSqg44jXCLPyy3p+/WQkNRpdHlDgG1kn2cq5MA8u
 4Xycd+uIU++IShmZXmzxdhYj6b2IE0u8fSlOOlNeFmWHX5BhIVHZKicRR
 8kj7aPA/yTFZe/h9qtebIaIQFK8AjvS3wmJd70XcUy4OABNNdRmiUu1hJ Q==;
X-CSE-ConnectionGUID: 0O6q4mWTTImN1EEI12jF9Q==
X-CSE-MsgGUID: SZKutUVmTeueUbBwolU7FA==
X-IronPort-AV: E=Sophos;i="6.16,260,1744063200"; d="scan'208";a="39277254"
X-MGA-submission: =?us-ascii?q?MDHR04EVz+AaemS//1Oj6vnoxv/osHETJk5i+J?=
 =?us-ascii?q?UCjsCZ9jTFXy2YCq96L/l53uGFXbSOAMH9f4VKq3AQAoa9JwV7pqgWPM?=
 =?us-ascii?q?fkN3kLC+5+TI0JWZ3Ky9FLMKnan6gaEdwwUxl//w1bL0RV5KeoYjcifl?=
 =?us-ascii?q?XIWh6glQuDaFZjKKh8CCr6tw=3D=3D?=
Received: from mail-northeuropeazon11010025.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.25])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 24 Jun 2025 07:02:30 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8qFQ1mIaSdBPwkSV3YCAtoBzVg4hrEj+sv/PGr5GpmIqU+7fPCaUhlzjj+ac2GBupzp98g4eXoffIVc4SSJpXnrnB0T2zVEhgF1APLgEJMMaZHIW15xyacvblIbbdZ5GLKSQAQr22WvwofDGa/nHxOqr3/AsTEAcx+BBVEN346moeyaFjj5AD33D+QCpIdsg3BfZ8wwc4Xlp131V4P2zdvQBs66cX1uKL5AC4Pa9/2SzJGpkm71blz4NQONPIraH204HZnhOCl25izur8qZt056GnWkOsonZaChvG2eQQZPk2qy/KJWFs+JdHy7qwmLJ1FKDKiRwapj2mCpbedBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMwzbgep8pR0ZqOiopa93nBduYQWI3/lfoNWpUHu69c=;
 b=VbScnG+Ajrx2MiAPeY9+pDFV/Ntwlb21reyM3NhiRJDYyd4CueEfto/dtqhWPi7AjZ4hQ1DutYtlTDeaxm+1eV8p75s7h+yvEEcm/7ar2rPomLNfg8jaatKA1CToIoIzaGF+BGsLgBYSRsJUb4jqfyUCSpN0jgURqCXm9/STrajKSLgqRHfOgAd0BVQEM3naE2AXFH6ibk44+VRG78XcFRXiUejiRmPYld+9KngDeGWMYWWsC80Zwa+Y6JfMRXJ1TPxHrP8VI2bO9Ba72RRc3Ue6tiXSC5r/RO1uBJt4UtWyaEEp1uEFJB6mggJ+axYcfSpqvFXAn1yVlQosCJEIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMwzbgep8pR0ZqOiopa93nBduYQWI3/lfoNWpUHu69c=;
 b=KRB6O/KN+iZnjOWcdneAHf0mgoWUyZ1CoQqV+GU6Q7b1yDSZifpIhzUuwVJ8Y52e+UuABZPTwQPLv6BKoihpSo/Y7Dmh1Z2LsbQDKMgbBKK+E6XdXjZb0oQXpStOWlJKgPm/TcPpK9LoLG0SzUsxibSSeX+cZqvFVHeFDHVwPYqNGXG2ot1n30fOBtNi19JYzEJvbAaivGwUln5MS8RCQDfel7roa4GZ/iE5JPxFeUnrm7lWiWtNyk7+FqQ6p1iPlzc+vgIRKtpKeWzNKi3slspnKQAI6F8kZxGFdR9pwxZjWpDdUnwhjdjTl9zse19i23b94TO1O/yUxHoDAs0s5w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU4PR07MB10322.eurprd07.prod.outlook.com (2603:10a6:10:5d2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Tue, 24 Jun
 2025 05:02:27 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 05:02:27 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Ethan MILON
 <ethan.milon@eviden.com>
Subject: Re: [PATCH 0/2] Memory and PCI definitions for emulated ATS
Thread-Topic: [PATCH 0/2] Memory and PCI definitions for emulated ATS
Thread-Index: AQHb4agdcjvbOfmLQ0WiEyuqDfW1lLQMHeUAgAQiGACAAH6LgIABCG6A
Date: Tue, 24 Jun 2025 05:02:27 +0000
Message-ID: <3a16c9cd-e818-4ffd-9826-e238cce038cc@eviden.com>
References: <20250620055620.133027-1-clement.mathieu--drif@eviden.com>
 <aFVxwG_O2QkryM6P@x1.local> <7ba298b6-13d3-44b4-bc67-5516893a6cb4@eviden.com>
 <aFlTf-El8TefWoQa@x1.local>
In-Reply-To: <aFlTf-El8TefWoQa@x1.local>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU4PR07MB10322:EE_
x-ms-office365-filtering-correlation-id: 6f8c4a37-4220-494b-5ed3-08ddb2dc50d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NThyMDgxYXhTM25lbmtsUW5ac1d5UC82bzE3N3FyZldLMlVLYkdxV1k2djNn?=
 =?utf-8?B?c2RhRHFVMW5pcHVTSmhZQ0czYWd5RjVTbHhrVW9VbERCSnYwOEx4WUZMSVY3?=
 =?utf-8?B?S3lJRlE3WTR1cW1OZG80L0NscFYyQXB0aWR4QVVUcmFPZWNhREE1UmhqK1FJ?=
 =?utf-8?B?dDRicWlFK2dqc0J5dXBubXVkckR1Wm9PQWZVR3FGalVtYXl1cGllUDFlK0E5?=
 =?utf-8?B?NUVEZndOdWhSSCthNXpTWmZtZElVS0J5Y0JXa2JlajdpS3c0R0VzaHN3SnRj?=
 =?utf-8?B?em51REovNnpYYlBIMzRndUpzeG9NdnFIK1l4cXBubDF6N0pXTlhFTkVDVEFh?=
 =?utf-8?B?MjZyY3FRbzAwOUhyUEZlMFlZWGxFWlRXNGduQXg5MkhwRGNFZ0tibklnYWJH?=
 =?utf-8?B?cnJ6RjVSVWpwRmJEL3lHaXdwS2VVTDg5eWZ4VmtaWUkxeGtOOUliK2w0UVZX?=
 =?utf-8?B?VFVDYm1Gc3pMUXNuZ3ZlbXRlbnB6T25uNWEyZUxyamxoOHBYcjBvWEN3QUJW?=
 =?utf-8?B?MThDWVJQWUwvZktzOU1VcnNSUjZENkRURXg3UGFOeWh6T2VxSDN2amk5ZzVK?=
 =?utf-8?B?MERMZGNuODhLMk45bzBsdVpKQVZKOHE2SVhvZ1BFQlB4Yklucy80WUdLeVhF?=
 =?utf-8?B?cTU4RWRLTk85T0lHRHRDT2FqRGRoampwOGhaOUYwTHZESDJMUWZUMlNTZlNz?=
 =?utf-8?B?R0g2bWdXMDFIR2lLanJiSDZ1WEJjZDhkUlk4QWZ1V21jWFQzM1dVZnIrMHhy?=
 =?utf-8?B?RFNJcUdGeHlxbWFxVXp2OGY1djFTTTRhbGlVeHFXSmFNZkRVUWwyQXJIYTNJ?=
 =?utf-8?B?cENYUWg5eHlNZ29nOGJQRFlUdXJUTHNHejZjUnYzZ3Jra0RZVFRlSHQzUzk5?=
 =?utf-8?B?bngwektjcGd4YjRNYVRmTTlGRGlIS29tQitNejlyVUxyNGo2YzNseW0rV2Z6?=
 =?utf-8?B?M3pSK0pGWDlJaWk4SkloeUVqaFZJZ21iVXNBS1UwOG9kQUhlTWFkTjJQck0x?=
 =?utf-8?B?MTZBQW9sYXFVb3RQTXQ2THhORUFPR1pjWEtKUWZWaDd2Rlh0ejdRTVI0ck43?=
 =?utf-8?B?cERqYm9sMjhSZTJhTURybDFVYWFTWWNxQnhmanM3TG03UURnMlBoRTcrclJy?=
 =?utf-8?B?ZkdGcEozeDBjSitlVnMxUkQ4QjhIMUFUczVpOFc4VlRVcWNlbVdNUTg1R0Vt?=
 =?utf-8?B?NkpScTFZcUliWlRZVFdtcmJPZUFYODBEbEdQUHFwNXpkejE2YktPQmV3VEx6?=
 =?utf-8?B?L1hJWnJVQmlMUWNpS1F2aStJbHZzZ2V0eEtTTUpBUzZrZ05TZkg2QWVxL05s?=
 =?utf-8?B?VURHRTFmaFNROWxBcEVoZGd0dkZWT2lLZlFqV1dHekRUOWhoUlN3UWt3b2o5?=
 =?utf-8?B?ODU4dXhPREhOeVZYNHA3eEJEaW5sV2pGTHEwdm1GbWhPdGU5TXpqT0J5cHdY?=
 =?utf-8?B?NDRHWm5XWHpIcVE5M2I4dVhJaHNnUWJMdDh2anFYNTBZZTZONXFZUDNyS1pj?=
 =?utf-8?B?ZzB5Uktpc3h3bDczRHdDWHJjVVZjWStQNlRqTERFbXczUlRzektLMzRLUnpN?=
 =?utf-8?B?N1l3TE03eWdTOHdkYngxOGM3N01oRTZVQmJaakJ4UnAyb29ySGhYY2hhN0lQ?=
 =?utf-8?B?a1Y4QzRMbEdUVGpaNGFGajVmTzJRWEdiY2xVT3NveDQzQi9pcEZXU29HTVU0?=
 =?utf-8?B?eG56RGZESHNXU2hBRVRZM0svYzZOK0ZIREw4Q05FdWgxQk9LUnQ5bkpXN1Bo?=
 =?utf-8?B?Tjh3SndZblBiSkVOQTNJUWQrZXdpZ3o3cStaT21WVDBMQ20ydnFCcHFlczl3?=
 =?utf-8?B?VUJjMnM0MSt4aFZMMnRFVEYzUWpPSzk5OGlMbEw0L3dRN3NrS1Nka0VaajVp?=
 =?utf-8?B?TFA1S3c4dy9McW5vMUhPR3A5UTRtNVhEZnp0QW1pekZOSlU1cFZjNlpHUnlG?=
 =?utf-8?B?d0ZCTmJtaXF2WmJpUzJZMG5Sd0ZsRDRxZGMzdmNCOGw2VXh2V2Ziay9GdVNJ?=
 =?utf-8?B?Q3ROSVlVamF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1hCS2RqaEZnMUl4dXVDTEFWY2FSVVUzL1A3SzZIaGJPVGV2dnpiZE0rc0I0?=
 =?utf-8?B?eUY1M3JCMmo5M0daT242Rk9PYmJBTE8wV2Flc21kbFBHaTZXYzFRcSthQWtt?=
 =?utf-8?B?SHUzR0cwN3V4bmF1WGRlZGV5QVdJRm5aQmZtek4zUTVXYzJuRWFIUzQ0dXBO?=
 =?utf-8?B?emRPK0V1NGp2ZXVzM3NleUZEMFVkcHFIdXVWV0dQZnk3QkxZcUZldGNySTVI?=
 =?utf-8?B?UDNQSkdKdUQwR3I4dEhYcHNmMWNZeUV5bTZ2T3RITkZ1RU0ybXdxNXZHckRw?=
 =?utf-8?B?VUxuVlVLNjVYTG8xUTBMQTNNd01ZODlrM212Tm9QeDdXcGdPd0lKQXhVSUN6?=
 =?utf-8?B?U2I4S0xLNU9jSkN0N3hKWGRpNFJvaVdPL25aMUxwbWVHNklCLzVaeWx6eU9I?=
 =?utf-8?B?bjk3NVlVUlVXTVVOVldVcnJ3aDNNbEhDZ0JLK1lscFRvOFFYSEpmNWN1NEV3?=
 =?utf-8?B?VzNiUUNvbzBrVHRVL21QSUNwa0QyQlJJVTk3NExIUFFDcnNjcFJMUzVjQ25M?=
 =?utf-8?B?MkNwSlVNekk3Q2tPMUYwNnhRKzJqcWRIZ2l0Wm4rL2svaU55bFZkaC9kZGlr?=
 =?utf-8?B?Wm9wQmd5R0RWdmxNZW9WRnVEaVQycW1IZUl3MDdTeVBEdnZjcHdyT01TbDN0?=
 =?utf-8?B?ZmprQm52WHNTVHNJUU1nbTh0UmVLK2xUbmlVbXVTaTBaZDVrMmkzbWFFOFBN?=
 =?utf-8?B?TC9ZWlRDL25LczhxODk4WTNjOWp2MzFOQnBqenl2MStpZWtkYkZpa3pjUGRi?=
 =?utf-8?B?RWRDNS9SejBkckV1NnpwM0huZGkrWXhaQVEzRGNBaERTRzF3RHpPam9XM1dq?=
 =?utf-8?B?eWdBR1dkS1FmM1pCb0FYRzJLWHRydExVQVgybEhlZFgwR3N6U0NCNjg5MVRZ?=
 =?utf-8?B?SjVkTEJrTEtKVmpDbXZqa29rdHlzMCsxQXF4NE1WakxCVEVrMXpjWHpBTTFY?=
 =?utf-8?B?L2Z4RkVvamJGN2hnaWxSUDNTUGZwdTZvVGZVdTE5bkloNTMxdmNrWjJUZkZR?=
 =?utf-8?B?V3BtNGFlbWhObUQ1OVhmRTlGQmRoWFQwQlVoQ25PaXh5c2R0WnIvVG9DdTEz?=
 =?utf-8?B?b2RJUlo5YVpXMHB3T1JpM2NVRktnRWVqWVp5K2pQcVZiRFNZWVZVL3YvTHAx?=
 =?utf-8?B?Smg5V0VUY3Q4R1U2RFc1KzhLbmdWdUVSbEJtOHA5aDBIQXgxOGdCNVVEdUdk?=
 =?utf-8?B?UGFvdk5ZNTN4bGp5M2hzcEE2cjMrdGhHZDdJaTVwb2ZSYlJ5a216UUNkK2s2?=
 =?utf-8?B?VjQ1cWFCSkJvOEMwTmdVYlV5d3d6aVZlV1VvZjd6d1I3a3ZEcHF0SExUZlJy?=
 =?utf-8?B?Q1dtNFI3OG96cjZ2T3RrNGpBV0ZCcmh3anBucXlBVmFnUHV4akdHbDFTV0Ez?=
 =?utf-8?B?WCtRQmM0NEFqemRhbmF6eGNTYnRhYWhaN2xpRHFqazRkc2hPRUtaTEpsTkpo?=
 =?utf-8?B?cGxzQWw0Nkp2MzlVQUVJL2hNRmRjRjQ0TmQxelNtYVBNOTExTnpXSUhYMUI4?=
 =?utf-8?B?VERJaFQ0dU0wcEZuMjJ3R3BVQmtnSGZxUjBXUHpXb2Rzd1J1aDN4WVpMNUJV?=
 =?utf-8?B?YzBKcGNHQUkvZDdNdDlvRlBRNjhNbUZVbkl1WjI5dkI2am5QL3FPcXZoT0V4?=
 =?utf-8?B?WHQyTTRVU2NUMHRMMUVzVmd5OHQxY2FpUlVlOHBFSW4rb3pLSkNiM213ZEtW?=
 =?utf-8?B?UldEZTliV2Zmd2t4cndycVBsK3pGejFGWk14T2w2MWhXbHMzL2g0YTlmM0RP?=
 =?utf-8?B?Zm4yeCtwcnplcE9PcVhyQ1BBaFdRLzZFSUo4cGpFVnBjcVY5aDYwdllEN1Rl?=
 =?utf-8?B?eFd5ek9tRisvdXJQYkUwTjR3Q1dZRnA4aVVvV1BWV2JuUzJqak9rQVRsNTJk?=
 =?utf-8?B?YkxLSWFycU51M2NEaTA0bFdiSlB1dTFVS1kzc2xOS3ozeENiSWdDVlZ1cXRT?=
 =?utf-8?B?WUI5b2J1QVZjZFd3MDI1MzhYVDZsdjZDOXFPdktETHVhenVDR0JnVlA4QkFS?=
 =?utf-8?B?K0R2NGNwN0I2SWZYL0k4RzhDWlBRZmU3b1l3bnBrVHJ3TEdaQnZBMlZpaC91?=
 =?utf-8?B?V2Z0MFdoQ2NNU0pwSnIzdU1rVkhDN3ZDdWhYWEVidzQwYVRzU010TDV0MGVs?=
 =?utf-8?B?S2RYbWNjLzhjdm80a2JHeGRBbHVuMjJyUHBwdnR4dkJPVVoxbytjYXhSamZL?=
 =?utf-8?Q?aPBNe8QNrwXqmirivwv8rqw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC7FBA361A9B8541B97FA5112990BB93@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8c4a37-4220-494b-5ed3-08ddb2dc50d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 05:02:27.4286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9qPtVIO0c2FoELnnwar/52kYfx8AHBBaAnZ8jWh22V48JWCYVmPnllFsy6ojbsLL5YG4F1gcrZc3YeJXo58I2KjOZHooMvWG6fKdL5OugHl4MbabkiLv3jYqcYsBdUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10322
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

DQoNCk9uIDIzLzA2LzIwMjUgMzoxNSBwbSwgUGV0ZXIgWHUgd3JvdGU6DQo+IENhdXRpb246IEV4
dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5s
ZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBPbiBNb24sIEp1biAyMywgMjAyNSBhdCAwNTo0
MzowNkFNICswMDAwLCBDTEVNRU5UIE1BVEhJRVUtLURSSUYgd3JvdGU6DQo+PiBIaSBQZXRlcg0K
Pj4NCj4+IE9uIDIwLzA2LzIwMjUgNDozNSBwbSwgUGV0ZXIgWHUgd3JvdGU6DQo+Pj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4+DQo+Pj4NCj4+PiBPbiBGcmksIEp1biAyMCwgMjAy
NSBhdCAwNTo1Njo0OUFNICswMDAwLCBDTEVNRU5UIE1BVEhJRVUtLURSSUYgd3JvdGU6DQo+Pj4+
IFRoaXMgc2hvcnQgc2VyaWVzIGFkZHMgdGhlICdhZGRyZXNzIHR5cGUnIGJpdCAoY29uY2VwdCBm
cm9tIFBDSWUpIHRvIHRoZQ0KPj4+PiBtZW1vcnkgYXR0cmlidXRlcyBhbmQgZXh0ZW5kcyB0aGUg
SU9NTVVBY2Nlc3NGbGFncyBlbnVtLiBUaGlzDQo+Pj4+IHdpbGwgYmUgcmVxdWlyZWQgdG8gaW1w
bGVtZW50IEFUUyBzdXBwb3J0IGZvciB0aGUgdmlydHVhbCBJT01NVXMuDQo+Pj4+DQo+Pj4+IEFk
ZHJlc3MgdHlwZTogRmllbGQgcHJlc2VudCBpbiB0aGUgUENJZSBSL1cgcmVxdWVzdHMsIGl0IGFs
bG93cyBkZXZpY2VzIHRvDQo+Pj4+IHRlbGwgdGhlIElPTU1VIGlmIHRoZSBhZGRyZXNzIHByb3Zp
ZGVkIGluIHRoZSByZXF1ZXN0IGlzIHBoeXNpY2FsIG9yIG5vdC4NCj4+Pj4gSW4gb3RoZXIgd29y
ZHMsIGl0IGFsbG93cyB0aGUgZGV2aWNlcyB0byB1c2UgYSBwaHlzaWNhbCBhZGRyZXNzIG9idGFp
bmVkDQo+Pj4+IHZpYSBBVFMgYW5kIHRvIHByZXZlbnQgdGhlIElPTU1VIGZyb20gdHJ5aW5nIHRv
IHJlbWFwIGl0IG9uIHRoZSBmbHkuDQo+Pj4NCj4+PiBUd28gcHVyZSBxdWVzdGlvbnMgb24gdGhl
IGZsYWdzLCBjb3VsZCBiZSByZWxldmFudCB0byBzcGVjOg0KPj4+DQo+Pj4+DQo+Pj4+IEFkZGl0
aW9uYWwgSU9NTVUgYWNjZXNzIGZsYWdzOg0KPj4+PiAgICAgICAtIEV4ZWN1dGUgUmVxdWVzdGVk
DQo+Pj4NCj4+PiBEb2VzIHRoaXMgbWVhbiB0aGF0IHdlIGNhbiBzdGFydCB0byBwdXQgY29kZSBp
bnRvIERNQSByZWdpb25zIHNvIHRoYXQNCj4+PiBkZXZpY2UgY2FuIHJ1biBzb21lIGRheSAoZXZl
biBpZiB0aGUgZGV2aWNlIG1heSBoYXZlIGEgY29yZSB0aGF0IGlzIHRvdGFsbHkNCj4+PiBkaWZm
ZXJlbnQgYXJjaCB2LnMuIHRoZSBob3N0J3MNCj4+IEFGQUlVLCB0aGUgc3BlYyBpcyBzbyBub25y
ZXN0cmljdGl2ZSBhYm91dCB0aGlzIGZsYWcgdGhhdCBoZXRlcm9nZW5lb3VzDQo+PiBhcmNoIHNo
b3VsZCBub3QgYmUgYW4gaXNzdWUuDQo+Pg0KPj4gIlRoZSBkZWZpbml0aW9uIG9mIHdoYXQgaXQg
bWVhbnMgZm9yIGEgRnVuY3Rpb24gdG8gZXhlY3V0ZSBjb2RlIGlzDQo+PiBvdXRzaWRlIHRoZSBz
Y29wZSBvZiB0aGlzIHNwZWNpZmljYXRpb24iDQo+Pg0KPj4+DQo+Pj4+ICAgICAgIC0gUHJpdmls
ZWdlZCBNb2RlIFJlcXVlc3RlZA0KPj4+PiAgICAgICAtIEdsb2JhbA0KPj4+PiAgICAgICAtIFVu
dHJhbnNsYXRlZCBPbmx5IChjYW5ub3QgYmUgdXNlZCB3aXRoICdBZGRyZXNzIHR5cGUgPSB0cmFu
c2xhdGVkJykNCj4+Pg0KPj4+IEkgY2FuIHVuZGVyc3RhbmQgdGhpcyB3aXRoIHBhdGNoIDEsIGJ1
dCBub3QgeWV0IHdpdGggcGF0Y2ggMi4NCj4+Pg0KPj4+IFBhdGNoIDEgbWFrZXMgc2Vuc2UgdG8g
bWUsIElJVUMgaXQgbWVhbnMgdGhlIGFkZHJlc3NlcyB0byBiZSB1c2VkIGluIGEgcGNpZQ0KPj4+
IHJlcXVlc3Qgd2lsbCBiZSB0cmFuc2xhdGVkIGFkZHJlc3NlcyB3aGljaCBzaG91bGQgYnlwYXNz
IElPTU1VIERNQVIuDQo+Pj4NCj4+PiBPVE9ILCBwYXRjaCAyIGFkZGVkIGl0IGludG8gaW90bGIg
YWNjZXNzIHBlcm1pc3Npb25zLCB3aGljaCBJJ20gbm90IHN1cmUNCj4+PiB3aGF0IGRvZXMgaXQg
bWVhbi4gIFBlcmhhcHMgdGhvc2UgYWRkcmVzc2VzIGNhbiBvbmx5IGJlIHRyYW5zbGF0ZWQgYnkg
QVRTDQo+Pj4gcHJlLXRyYW5zbGF0aW9uIHJlcXVlc3RzLCBzbyB0aGF0IERNQSBvbiB0b3Agb2Yg
dGhlbSAoaW4gSU9WQSBhZGRyZXNzDQo+Pj4gc3BhY2UpIHdpbGwgZGlyZWN0bHkgZmFpbD8NCj4+
DQo+PiBJIHB1dCB0aGlzIGhlcmUgYmVjYXVzZSB0aGUgQVRTIEFQSSByZXR1cm5zIElPTU1VVExC
RW50cnkgc3RydWN0dXJlcywNCj4+IHdoaWNoIGNvbnRhaW4gdGhlc2UgZmxhZ3MuDQo+Pg0KPj4g
VGhlIHVudHJhbnNsYXRlZC1vbmx5IGJpdCBpcyBzZXQgaW4gQVRTIHJlc3BvbnNlcyB0byBpbmZv
cm0gdGhlIGRldmljZQ0KPj4gdGhhdCB0aGUgcmVxdWVzdGVkIGFkZHJlc3MgY2Fubm90IGJlIHBy
ZS10cmFuc2xhdGVkIGFuZCBzaG91bGQgYmUNCj4+IHRyYW5zbGF0ZWQgb24gdGhlIGZseSBieSB0
aGUgRE1BIHJlbWFwcGluZyBlbmdpbmUuIFRoZSBpbnRlcnJ1cHQgcmFuZ2UNCj4+IGNvbW1vbmx5
IGZhbGxzIGludG8gdGhpcyBjYXRlZ29yeS4NCj4gDQo+IEFoIEkgc2VlLiAgWWVzIHRoaXMgbWFr
ZXMgc2Vuc2UuDQo+IA0KPj4NCj4+Pg0KPj4+IFNpZGUgbm90ZSwgaXQgbWlnaHQgc3RpbGwgYmUg
bW9yZSByZWFzb25hYmxlIHRvIHB1dCB0aGVzZSBjaGFuZ2VzIGludG8gdGhlDQo+Pj4gQVRTIHNl
cmllcyBhcyB0aGUgZmlyc3QgdXNlciBvZiBmbGFncy4NCj4+DQo+PiBZZXMsIEkgY2FuIGRvIHRo
YXQuDQo+PiBIb3dldmVyLCB0aGUgQVRTIHNlcmllcyB3aWxsIGNvbnRhaW4gfjEwL34xMiBwYXRj
aGVzLCBpcyBpdCBhIGNvbmNlcm4/DQo+IA0KPiBDb25zaWRlcmluZyB0aGUgc2l6ZSBvZiB0aGlz
IHNlcmllcywgSU1ITyBpdCBzaG91bGQgYmUgYmV0dGVyIHRvIHN0aWNrIHdpdGgNCj4gd2hlbiB0
aGV5J3JlIHVlc2QuDQoNCk9rLCB3aWxsIGRvIQ0KVGhhbmtzIFBldGVyDQoNCiA+Y21kDQoNCj4g
DQo+IFRoYW5rcywNCj4gDQo+IC0tDQo+IFBldGVyIFh1DQo+IA0K

