Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C663AC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgpz-0001wx-PW; Tue, 15 Jul 2025 10:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ubgCO-0007qD-9j
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:00:00 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ubgCH-0003aa-SW
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1752587993; x=1784123993;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HceaA5sI7wJLJHHc5sJD449+cog4MNnhzI6EgyhXnV0=;
 b=NCD292d/2qZHe0r66XCWKY7dyPb/S6Z95uT/DQeqQiRTGWRi7DwvJ/YN
 kBixM9OmRStsrmNCqfABHbp/kVyTjKgnqIUvtvaW2Xtl1Z6F5CSDnhkrC
 3NoVKV3icBau1V6Ma79Qu+s/PrerlFFuPcJMglDPK/W7r5FqWo5gW+KaM
 sPCWDPFICJNWvVIQyG6JCaVGzL1wJ8k8DyU0M00622H6SswZ5i6/PfS/p
 xxpbOUwMEfaRhdwWMhSG0PLsTlisvRCSENpriMRAWlMGlmSYphbqjxhQE
 Gu6Qh2QL5guEoZFpYzPHuC68SqXqePFAfOXCELNoXRxuAfBqFMT5I8f/J w==;
X-CSE-ConnectionGUID: /7Ucp7OMS8SAWjO++HPX1A==
X-CSE-MsgGUID: W9fLtlTOTNyUKwDgoguRdQ==
X-IronPort-AV: E=Sophos;i="6.16,313,1744063200"; d="scan'208";a="40362784"
X-MGA-submission: =?us-ascii?q?MDE6X1BIn2N2UrKXTla0Hk+Wg4tc6pyV5VA5n7?=
 =?us-ascii?q?SNgaJ9Tl35UyWwyPZH5SZ87GpA2C1TZ0jw5BMXIlClrS3amZ7nqzkuuF?=
 =?us-ascii?q?R1F4x8s7I5gI/oJjvGRemHrndrzgLhlPQEXYt4c5rfPm99MM9J+SjPMK?=
 =?us-ascii?q?ksLvww6gk0dJj/a0KWeZkSig=3D=3D?=
Received: from mail-francecentralazon11013045.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.45])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Jul 2025 15:59:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBqrqkNfhJiPfepiaEs99ZyKlHThe4OidzOXAp8miHprYoK7ysN2HKVwkGwk4hLpRW120JErVs4yzYV8SqzKanA+ibNUmjOKcENhCOKcxzYZWP6mZ1y5rYacx04COUbmQboJ8NV57atxKuTW0ZceWZEzXQs1+7yTmvr/Xb/lnl91xQJeBPMxw9juZ8Wv8FkXK42wuYzqqloOqlW6BgJmnVH48H8tFqkKiVQMM2sOM8qTQgcEPs75m8mFL3snTihuCbtYjELYyB6XM/luG2UKutdgzS2O6wgtcvcGhRon425DLFV2FR7BKfiy0wDOKGTNliQt+BFVoWNNB3qv6ymN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HceaA5sI7wJLJHHc5sJD449+cog4MNnhzI6EgyhXnV0=;
 b=M9AIdVmPxovDiZm2JniI9N37Ir3yUhTBIM899CoonZQnzy6GV9BJmoGeXTYFZSWOL/dx+2QAGnS54IhQZJ5qtchzPAEsERJw14NQ3swJadvow4GqQjMgsGE3jX6yb4u0InIbV/IWeKD0ghq9X1VLbUVLVaRS4ZMLoho3YQP9PbZ06B5xIZ9xg4SBF92PRFY5S/GvzSYBvCVs36FDIxMccpdOZhP1hc5j955L0HkaPqk/yclZT2Il4uf2cL6wdP1xrtj4T81/M7Sgx4WuwfkzeYFG/4mpCPP0Hsi5XKKWOeQBAmhYXsyLRHsu1I89RRy04B5+cQqfv0n85xlVAPZAmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HceaA5sI7wJLJHHc5sJD449+cog4MNnhzI6EgyhXnV0=;
 b=Df/WGHFBbOP4y+GKe+8QlRCE10cVW9MRH6h5f3KZHGWPzOEgDjtfUCIi8asHgcpgYT1uwPkfOfF6clhyrlKuJq5UU1pSEXovg0zkhpYCYsINls3vrY1VvVLvCgdr9zJ0XoV29Gy+bJbq7nC/L+DKkpBHMDetZrTeuZagdObHpBt+DMSAXkvT20n+9fufX/ePXFkZZo38FzMUSv1Wfnt7NG2WREh/mPWe9qje7swen0UM/9bRGjXQAs8htZ7vHppgQ3VPPtw4OB7uTLFS9vABj9AEoIcl3bAIhkYXnmLIVOLwdxhO3M0rvbFkSSkktM0q1el1VEsUQUQk8SoZEAKP4A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM9PR07MB7300.eurprd07.prod.outlook.com (2603:10a6:20b:2c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 13:59:40 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 13:59:39 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, Konstantin Belousov <kib@kib.kiev.ua>, David
 Woodhouse <dwmw2@infradead.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Le Tan <tamlokveer@gmail.com>, "jhb@freebsd.org" <jhb@freebsd.org>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
Thread-Topic: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
Thread-Index: AQHb9JVtonfMGrKluUCpVZOjgLqK0LQxrd+AgAAlOQCAAE5sgIAAk+0AgABraICAABdMAA==
Date: Tue, 15 Jul 2025 13:59:39 +0000
Message-ID: <eef6b26e-5ef3-4a16-8a36-730942cb5560@eviden.com>
References: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
 <9ce8b7e6-ad15-4d2e-a430-3896eccc7519@intel.com>
 <4FE9A8E3-5BA5-46D3-A1FA-EA1B7C85C058@infradead.org>
 <aHV0-wDJImAjRPPp@kib.kiev.ua>
 <afe3881b-1193-4d89-b0d0-6c316e54684f@eviden.com>
 <8fe80210-7cf0-4fec-94d4-79b41216a620@intel.com>
In-Reply-To: <8fe80210-7cf0-4fec-94d4-79b41216a620@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM9PR07MB7300:EE_
x-ms-office365-filtering-correlation-id: e23fb91f-6ee8-4e5e-165e-08ddc3a7d74a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NXlRMWRxV25VVS96bXBMR05abzRvaGFYZjVDWTJrc1NMWEVxYko4cFpOQTNo?=
 =?utf-8?B?ZDM4a3RneHJGTGpKZ3MvRHA0ZXZHVGNDOGJ6SVVTb2RsZDR0cTdSNXZKV2pU?=
 =?utf-8?B?ZmR6Z0RPNUQxUVlXV1p3bHhXN0cvUFM3cU9QN1l0U0pDUmI2T1ZVUEJYcm55?=
 =?utf-8?B?ZkhGa0VJZVh4NThXT2NsdUI4WWNqTXpoVHFqWXJvVUl6QzgzSW44ZUJzTmxV?=
 =?utf-8?B?cTB6TG9hWHBxR054WTNtdmZuS0hCcEpYWW9WK0p6MEJwNTlXanJqbkFvbjVP?=
 =?utf-8?B?S0J0ZER1YjU1SGxaU2pFU1RPZ0Exc1crSWtrY3F5cW5YMGRhTWlJc25RQlhQ?=
 =?utf-8?B?Y0xOMStjWjZBRHV0WmhnRHZjQkYzVVBjWUh4NjFjV1l4YWJRcXQvcjBXRWxC?=
 =?utf-8?B?cTQzY3REU2J0N1BGY1VjSkxlbDdtb0xMZW5PZjRWbCtpbzRKMUtiN3cwcWNX?=
 =?utf-8?B?Zk8rN1M4YnFYQlFsaWszYkY3b2dsbCtyb3ZjWWhqbDdNV1lYV1JxcWtkSXB5?=
 =?utf-8?B?WTU1bW4zVWV2VjRrS3ZqT0ZkYWozNnhyK2J3L2NQRENyU2luckRCajdYbDJS?=
 =?utf-8?B?UlZUYlJDc2R4NCs3bnlZNFRSd1UxalZCSGs2MUFGWG4yODNTUHlna0RlNU9R?=
 =?utf-8?B?ckdTU24zNGlFVDNaVUJ1ZTVocGEyeTlUd1hwSUNZMWZWeGpYVmIzTmRLcTcr?=
 =?utf-8?B?dGthUFordG5VdVI1eXFsTU5scVlxc3B5OXU2dW0zYnBPc0t3cUN1ZlhPRWZN?=
 =?utf-8?B?ZXhvVmNQMGs0U2FnVWVtQ2M0dXlIWXZycTg2eVNGSGh3Vm0xU2tTSUpsUHZ1?=
 =?utf-8?B?QitYMUViVVNWYUk0SjZsa284RFRsNURBZDNLZkpKVlVXVm9odUlPSnF0NDM1?=
 =?utf-8?B?dUswUEpreFBqMENhRjdsOXF2aktpNkJRekU3UkhablFFYzNwSElGU0poQ0xY?=
 =?utf-8?B?WExsVndZd2lRVSt6WVkxYVJyZWxRdHE4KzlzazlqS2dyUnJUaWFSUWxkOXI1?=
 =?utf-8?B?ckwzTHNuV1YyRXUzcjJwMXlHU1BhK2ZxTElhVjJmdFF5ZzcxK2J6cldhM2hS?=
 =?utf-8?B?bW85d2V0UHN4clFwWFUyZWxwOWlDdjZPVjdwdnNDRmg5aXhWR1dhVG55a3Y2?=
 =?utf-8?B?RkpMdEVudEFwRTJOcm1qVU1qYUtFeDBjQ093RTlvbGVkbzh3NGQ3TElpRnpP?=
 =?utf-8?B?RFl0WDk3bTB5WU1PQXhteXV1TVk2d2RTUUxJaXNtL1JGY1pkdlFhemg4MDMr?=
 =?utf-8?B?WXpxWEN6ZjhTdHZkMFZDai8yODVyMW4xVEFnN1dZeVhxaGQ5R2lzYlQyQlVY?=
 =?utf-8?B?TlJ0cHlTS256bmVROExUaHkzWVdmL2IzQjNtODNRdGpUQUVRYkhJQ3JOOTh0?=
 =?utf-8?B?UFlOZ1RnZU13a0llTjJBdTZtYTNvNVU3S0pXVFYwejVTTEdWb1E4S2k4eHZL?=
 =?utf-8?B?TjMxTjNReG5NMWJMK2l2a0toQ2N0N0xTQnQ4MzlldFRRa01HOS9VQm1zWThx?=
 =?utf-8?B?aVpudGFYQ1B0RnN3NUdRTVJSRGM0TzdBeUpwT2tLQmxoc1d5U3c2ZHl6ZmY1?=
 =?utf-8?B?dFBhQlpEM0FVRmk5WmpwKzZCa2M0UWdqTEdRWHV4eER4SmMydWpFWkF3M20r?=
 =?utf-8?B?dU5SSytOY1NTcjB3VzlxdkpLUXNFUXJBR3dTc2VDQnRNSkozN3d3TUxxQ3Bo?=
 =?utf-8?B?cGNwSTRWVzFUWjI1WWx3TFpQME0wR0JVdEk0VWNOTGhtZlVHYURud28wZVlT?=
 =?utf-8?B?djNxbno5VzlaL1owOXNRZmltTkNyS3pIZ0g5L1VHaXNTZjZOUDF4NElnVjNP?=
 =?utf-8?B?NDlVcldKeXhzQ2N5L00rSUNLdlFicDZDSkpHRFhoQndhZHRCV1J5Wnc5UVVI?=
 =?utf-8?B?c1VuWDlUbFpWTGZLVzE5REJ0aDcxOWN0S1U2eWVFbXVOK3kvQkY0L2FkUnRs?=
 =?utf-8?B?MTdWYXlaSUIwbnljdEtOcmk3Wnh4eTFKNXprcEJUMGJsMisyQ2ljVVl1NHVn?=
 =?utf-8?B?R2d2dm5yYWtRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3JJSUpQcmhROTQrakpQaFdzcGJUY21MSkNaSXpmRUtsU1kvTnkzcHZWNm1D?=
 =?utf-8?B?bWMzQnVEQWhEM2xLS2gwbUxINHpvUWRGM2N0N3hlN3lVM1NCVjBPU1JEL1ZB?=
 =?utf-8?B?MVZsRFdtTytyYVVzcXlpeFliQ1lOSHRZQmJnKzJxUmN5SE0vcmlaZ3EvUXVV?=
 =?utf-8?B?UkJoT2pjaXQyT25IY2lGbWpub2NNUkJJbTM4WVBKVGpCUTlKbStXS0hNTnBM?=
 =?utf-8?B?ZmdvcG0wQmlaVGFBNkgwMCtrVytHeXd1UDJvWmxTRE9FR095T2tzR3k5aDkw?=
 =?utf-8?B?MldsRWsvaVNRbUFRSTFISy9wd3dOaXFKS2tJK1NpNHZxeXJwYkZCWXRUeXNW?=
 =?utf-8?B?bTBqR1E5ZlRXVFNKZU81cm9oa1o2QllEb3hxdFh2eWVFVzN4andiU3AyRWlG?=
 =?utf-8?B?UjFFdXl2ckF0eTZtdTV2V3pnT2MrWU00aDVZNmhLV01mSll6ekJtaWhsa2Ns?=
 =?utf-8?B?VTJiMUZRZWQwRExsM0xOZlZtL0MybGVkWWpSM0dwdThrMmF2c2VFUlhKVC9p?=
 =?utf-8?B?Y01RdVJGR0U1WDhGOW1vNEZoaU1LU2RPYkFRY3RGdDNyVmpSRnRtYXVuNzdo?=
 =?utf-8?B?OC9ic3I2aXN2RFNOV2lUbFc0eFRkOHNFemliUXBvaWNiWkg2U1BXM245cVRJ?=
 =?utf-8?B?ZnVzTDhNaktnNGpxSEh1VnYvdWpMNk5xcmUzU2hXVVpFR0l1RDVuVUpIZlFX?=
 =?utf-8?B?empkWkR6eFdOamo3d3JINEJuNjY1ZWZDYWIvVnVuQ0JKa1FVVmlKTnNjUEhD?=
 =?utf-8?B?UkV2N1dFZTFxc0hCam5FZmorZTJ4ZmFwT0t2Y05EOGtGNUxUVDk0MkZiNVNs?=
 =?utf-8?B?b0x1UzZTR2F1d3NDUUp4ZlNlb3MrWUtkVmtyOTRnbWxCZnZ6T2RWOEhHL3ll?=
 =?utf-8?B?cEFnaGt1STJxL1Z4bmZZaUlJc0ZwZjFSYjVtQWVTV3N3YWRBcUgvMlBqeXVn?=
 =?utf-8?B?Rk90WFJkS01Uc1JoczFITHpua3VpbVhrSVBQQUx0SEsvL0s4dGx3ZS9IemYx?=
 =?utf-8?B?M1NWTE41U2lKZlNWZFM3aysrTUV2MGJzbU5NVnQwYkdWY3BFRFAyNWE0RVVl?=
 =?utf-8?B?OHF6TDdBOW5TaFVtVE5EeUpWOERkeGloNEF0QnN3am5weEJWRkxBbkQycW5B?=
 =?utf-8?B?eDI1R0JZcGNBU1lJbEdzZzUwYmNUL2RuSFNBcXNKRmV4Kzc4TXBETDByYi9O?=
 =?utf-8?B?V0s4KzJvT2UrM1V1Z3kxRXFMdnRla1p1bDBueUZXOTQ1MWJBeEhvY2doN2Js?=
 =?utf-8?B?L05ySmtOQldZUGZVVnJNVlBHSmJMRldlaHUyVzgzZzFjRFFxVnV2MEJseGUr?=
 =?utf-8?B?WXZub1hLdTdZVk5Bc2hlQWVVZU53ZHJmSEg5aEtLcVFMZndUSUh5M3N6YS9a?=
 =?utf-8?B?OTZZQTRLajlPUGZBaVZ4bjNqSnpMYTJyN2pTZ0lrT200cWE1citRL21oSHFV?=
 =?utf-8?B?OURQMk12bHh3WEN3TjF6U05XNnhOVnpNNGdmS0RkaHVoNDRvdVpZK2Nicnll?=
 =?utf-8?B?NFRKb0VhMmJXOXc2TVBiR3JGcEdON2lTUEw0RTRmMS9Dd0FiNi81dzRBSjNN?=
 =?utf-8?B?MkZoQ1d5WW9BVWsrRFhvc1ltNWltdFFtbVI3VktUNzR3czlUQkFqMDlPYUk3?=
 =?utf-8?B?UExOQ3lrVS9GeW5PV1MySm85T0ROQzJsdGZMSEZrOTBsTGhaYkw2RU5CbE45?=
 =?utf-8?B?ZTVaR0lFL1Y0Q0d3OEVQOW9LYy9OKzFCcS8yRmlDcklEd3YzYlp6eXlCZDIx?=
 =?utf-8?B?MXVtaEZQdWN6SURIa2tGemVzUzRGTUd2NmVkRXE0VVoxVWdjeWFkSzRKQmZy?=
 =?utf-8?B?UG5ucDhyMU5nczRvOHhPWXc4UUorV08zeXhrN3FTRHcweVhldk4wNTBhTkJx?=
 =?utf-8?B?Z0NZUklWMlBsUUNWeXVzMTdBQzZHdFh0TTBHWDU2YkQ0OXQxUm1iS1JEWGln?=
 =?utf-8?B?WmRBMkJFRUE5THA2UmR6YnVIWmcwOTVON0pac3NWUGthblZ4em84ZWpKU0R1?=
 =?utf-8?B?QjRLUk5VKytteStUaDZQdkpGYkg3SGVFNklXUlJFc24xc2FKNk1YRFE0d295?=
 =?utf-8?B?S0RxdE5Md01ibmlZanZibm9PNkhxc3QvbnNSWjVVaEhIb1pFamVadFB0a3NS?=
 =?utf-8?B?Q1htenlEcnpVVlNUU2JGUXc5TWsvV3NGbEJPeWZMVXZpc1B0QUZJZ1hRWGUx?=
 =?utf-8?Q?IQrHmkgyWoNG13SRr3eiscA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <364CE001ED790047A16F0BD1BCD6E575@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23fb91f-6ee8-4e5e-165e-08ddc3a7d74a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 13:59:39.5157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+0sL37vdwbcmP5gNwes5nzcPdQVXKzU9p7RWRHqaVSbOxqg28CcJPVe1+xlIO8zMpQ944QL04LDFAQI8wptAz+MBGcMqvA4RCyrlIc8LsDwLjv+JVSbhfCu0twomCnh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7300
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

DQoNCk9uIDE1LzA3LzIwMjUgMjozNSBwbSwgWWkgTGl1IHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRl
cm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVz
cyANCj4gdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIDIwMjUvNy8xNSAxNDoxMSwgQ0xFTUVO
VCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAxNC8wNy8yMDI1IDExOjIyIHBt
LCBLb25zdGFudGluIEJlbG91c292IHdyb3RlOg0KPj4+IENhdXRpb246IEV4dGVybmFsIGVtYWls
LiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgDQo+Pj4gdW5sZXNzIHRo
aXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRl
bnQgDQo+Pj4gaXMgc2FmZS4NCj4+Pg0KPj4+DQo+Pj4gT24gTW9uLCBKdWwgMTQsIDIwMjUgYXQg
MDU6NDE6MjJQTSArMDEwMCwgRGF2aWQgV29vZGhvdXNlIHdyb3RlOg0KPj4+PiBPbiAxNCBKdWx5
IDIwMjUgMTU6Mjg6MDkgR01UKzAxOjAwLCBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4gd3Jv
dGU6DQo+Pj4+PiBIaSBEYXZpZCwNCj4+Pj4+DQo+Pj4+PiBPbiAyMDI1LzcvMTQgMTY6MDAsIERh
dmlkIFdvb2Rob3VzZSB3cm90ZToNCj4+Pj4+PiBGcm9tOiBEYXZpZCBXb29kaG91c2UgPGR3bXdA
YW1hem9uLmNvLnVrPg0KPj4+Pj4+DQo+Pj4+Pj4gRnJlZUJTRCBkb2VzIGJvdGgsIGFuZCB0aGlz
IGFwcGVhcnMgdG8gYmUgcGVyZmVjdGx5IHZhbGlkLiBUaGUgVlQtZA0KPj4+Pj4+IHNwZWMgZXZl
biB0YWxrcyBhYm91dCB0aGUgb3JkZXJpbmcgKHRoZSBzdGF0dXMgd3JpdGUgc2hvdWxkIGJlIGRv
bmUNCj4+Pj4+PiBmaXJzdCwgdW5zdXJwcmlzaW5nbHkpLg0KPj4NCj4+IEFyZSB5b3UgdGFsa2lu
ZyBhYm91dCB0aGUgb3JkZXJpbmcgY29uc3RyYWludCBtZW50aW9uZWQgaW4gYnVsbGV0DQo+PiAi
UGFnZS1yZXF1ZXN0IERyYWluIChQRCkiPw0KPiANCj4gRGF2aWQgaXMgdGFsa2luZyBhYm91dCB0
aGUgSUYgYW5kIFNXIGZsYWdzLiBBbmQgaGUgaXMgY29ycmVjdC4gU3BlYyBoYXMNCj4gYmVsb3cg
c2VudGVuY2UuIEl0IG1lYW5zIGEgd2FpdCBkZXNjcmlwdG9yIGNhbiBoYXZlIGJvdGggSUYgYW5k
IFNXIHNldA0KPiBhbmQgaW5kZWVkIGNvbXBsZXRpb24gaW50ZXJydXB0IGhhcHBlbnMgbGF0ZXIg
dGhhbiBzdGF0dXMgd3JpdGUuwqAgTGV0J3MNCj4gZ28gb24gcmVmaW5lIHRoZSBwYXRjaC4gOikN
Cj4gDQo+ICJUaGUgaW52YWxpZGF0aW9uIGNvbXBsZXRpb24gZXZlbnQgaW50ZXJydXB0IG11c3Qg
cHVzaCBhbnkgaW4tZmxpZ2h0DQo+IGludmFsaWRhdGlvbiBjb21wbGV0aW9uIHN0YXR1cw0KPiB3
cml0ZXMsIGluY2x1ZGluZyBzdGF0dXMgd3JpdGVzIHRoYXQgbWF5IGhhdmUgb3JpZ2luYXRlZCBm
cm9tIHRoZSBzYW1lDQo+IGludl93YWl0X2RzYyBmb3Igd2hpY2ggdGhlIGludGVycnVwdCB3YXMg
Z2VuZXJhdGVkLiINCg0KWWVwLCBJIGFncmVlDQoNCj4gDQo+IA0KPiBSZWdhcmRzLA0KPiBZaSBM
aXUNCg==

