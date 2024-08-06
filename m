Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B892BC52D6D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 06:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbDn0-0007Ez-LE; Tue, 06 Aug 2024 02:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sbDmy-00073T-99
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:35:20 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sbDmv-0005CY-LL
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1722926117; x=1754462117;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=oNw5NppkniICnG1FPNk+32kwAidz3rtTvFEDg5OjHd4=;
 b=o1VI9I8g/gCI2Z1vCbL4LTmiKesixqpTQlykdiWpL1kWvkAbdgaoP92w
 BA4jB0+6CmJCY3zrMDriQOuVMXU6h9PrJCaiavYBWmcuaD5dpCmKQH9V3
 NhcvpvCp03k5EVBdQiQ3CfBZAxxupwuAm9yZWS/8RpzxM//pLdCNu9nrt
 C3hICGUbelKm9ubxZn1Lu8jRLgEmWdKU9RlQ/eoY1AxzSEYIBS2V2oxso
 hN6Qo8kgjt6KOGvR6FbkQcKe2EUuMgjPiLAjDWFC3//2fJ+93z3Z/Flmb
 tbRz+sjeSSD/IhBMNQZeBaY/vIPxGuVxPGLrfadMMM5J/pDaBytYKvXZQ g==;
X-IronPort-AV: E=Sophos;i="6.09,267,1716242400"; d="scan'208";a="17871312"
X-MGA-submission: =?us-ascii?q?MDGBsEg+H2blVA0Gl3EsbkoTMHmORnDxhvUn0f?=
 =?us-ascii?q?U7voRO37xulgOs71rtq478HfXg9Mt2h7bRD+Pkk1sj6vZ0rbLwthBEAW?=
 =?us-ascii?q?BBFlPLMpKa1lnTC1b1rlbTAVb9rk0UPc6sP3h9/qRl62JEDF3ZtZF1da?=
 =?us-ascii?q?KLQynmxEaVx48Bj7HPOCTiXQ=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2024 08:35:15 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnwZSAlOgra8HhKz4XqptBye1pglIVPI9/yl/6qlyispiWnnXgWSSLXKlEEIKjzrJZGGPG3/Dl9ArJXg/6onTT5TkBklbaqzyhKD5R+kPj3VK6y++lov2v4iYtveGLqS8ln4gfE2nr8lQNg4OGBDc/W0P+EeyATWUJYzuqgtMtsGMBXUpvJfoU0NWm1bO89K3pM8KDzi+lhWq81nCy7ZvBjKNKIkrybyIVF6wE6DZ1M4y8X9FgrfR/BY21eldAiDqE3Cy3s9tAaR28hWNgFce0Slu1jlNlTTNn7I/7GwZlnLD2tErdDT/O5vwT1jWRVsgIbO/p8K8PiNiwa4ZFB1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNw5NppkniICnG1FPNk+32kwAidz3rtTvFEDg5OjHd4=;
 b=o6c/MDU11/9YKboyCbkN1owmq0kQ2+oJA2C/mTU9Nq1tS9HJppK0rxvNhHQWClYIsg6bTakBApS2EGINYNzB74deZCnVDw7tnya+Yf5G1r/eQILy1Vm8SIRp1ZhC8BfhGMFwmI61sIWn5V8ZjaofJguPlK+g2sJcNBDaPI2CRziZwZ+heQ7+vPhZnw0acolsNRWcL0x5VqvPywh9fiLv/uDfg6jIR7zTaf6A441msAJa8MIXw63ZbBzzcCvtkkMuKH6hnZ2S+NUybqx9criABOjSZcVq4Z9rpIE+EccMyJx8+lO+JKqLFDaPcwOrgenhfZzXYm72eLCT/Gja+46CqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNw5NppkniICnG1FPNk+32kwAidz3rtTvFEDg5OjHd4=;
 b=ifB6A/30xGW/tcvaLBHEF0jB5GOUN0wRayrd6V/eGTDd9edsFDOfgC68EwQji0BsO4ZQM/zP1oSmlq+9NPF9erWx9or65FETgbSsNivo8pBpuyrCEFC1G7vpjNjOIXdm81kRY4PLsZwIBobK+EocZexnMkzgycY8spa+ezmoZ6kTFrUOAs8YNXI8S4FDBH9SuwS3b/A1XrtRvJmvgOpYxduruNvzg2RR0lvy4B6kswog3Z7TrV+H7xWItYXrdb6tIXsWN71iwilObeJrEDV/JhxNaK/YH0tQpKp2Io6zWpPLqOp/HGnU6MLn4N9JjjImhpx/8FDgHXVUiMvBBcjp2w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAXPR07MB8000.eurprd07.prod.outlook.com (2603:10a6:102:130::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.10; Tue, 6 Aug
 2024 06:35:13 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 06:35:12 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Thread-Topic: [PATCH v2 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Thread-Index: AQHa5wEU4dsp6z14Ok2y/poAbGkIa7IZx4MA
Date: Tue, 6 Aug 2024 06:35:12 +0000
Message-ID: <2e30f59e-62ad-49e6-bd6e-2a24b33edb4e@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-15-zhenzhong.duan@intel.com>
In-Reply-To: <20240805062727.2307552-15-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAXPR07MB8000:EE_
x-ms-office365-filtering-correlation-id: e8490045-3356-4adb-13f1-08dcb5e1ece8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Ri9iL3RuMGw3TVZxZ1l0OGJhT1B5d2pCTy9WVmtCQ3ZhOVVrQTVRNEo0TmtK?=
 =?utf-8?B?YTZoR0t5R3ZkVVNraDFnUUhQVTBNcW0vZHM4c2hXVWhVVU1qaTNLU3oyTk1l?=
 =?utf-8?B?aU14TDl3QUxjVGRuVEZWSEVqRTVqYVV1eHpUa1A5MTNjSkFzbTMxTTkwbWx5?=
 =?utf-8?B?aHRGL2xCVGcrVHk0NTAzSmduMGc1SXJRSnEwdS9qZUIvOVBseTIwaTFTUTlv?=
 =?utf-8?B?VkpTSXdjQWtWSXdWM2Q4QWsxOHVZSFZyZmxSSVdmOGhPVVJLcE5qbmxhankv?=
 =?utf-8?B?NTU0SWNQZW92RVAzQWNQVkxrbHlPQ05GMFhjNXc3Qm5CdVNRZTNwRTNNV0Yr?=
 =?utf-8?B?eVRNN01VRjJ6S3ZKQWlsaDhRU1BPR1Y2eExBTks4TXJyd0NFQWhVRHkvYlcy?=
 =?utf-8?B?d1NiM3NUYzVLQ3JFbEZ2RnpHTjgvTC92bHUxamFvQTZPMFRRL2lZZ2ZIRWZ0?=
 =?utf-8?B?ckRSVWpUcjdrOXcwNkRxQjVzQkV4ZHVleUEwcHhPaUExK1JkRDQ0TEZSRmtz?=
 =?utf-8?B?RkZ4NmM0aDFCSFdxTG00SFU0ekZJbGlEWFYwZVFTY1ZUVFYyaFFFSmcyd1BN?=
 =?utf-8?B?TEMyazZncDJNaTdNNEJPcGgwL3BHR0g1ZFRwNHJFbFJpV0VoVzErUlpVUmYv?=
 =?utf-8?B?dzlzajVsRkl4NDdhM29kcDdLcWtrY1BFMkkwTmZzZkJmZ0ZRRHVONkE3SGV2?=
 =?utf-8?B?NTViYzdidlJ5NVJPS1ZhYVJubkQ4dTJHSTRidmNyMDNTa0QraGRZK0xkQWlz?=
 =?utf-8?B?VktvejBua1kwdGx6aVZWWkJhc0VEcjc1emlHUE5pQ0dBRm5nK3lVbUhQeC9I?=
 =?utf-8?B?Yy9rK1cwa3NiTWE0UG1kaW9tUEhJdzNyL2RXNlErMUl3c1NkR1BiaHFFcGs2?=
 =?utf-8?B?ZEJhazNuMnRycEdDVDJ5TGpGUTdINHlOeGNsSnZpL1BRcVdBOHc5YXRhdGFN?=
 =?utf-8?B?K1pmMzdJMFk3SEFGVUZ0RTFTQzRSWGpHTGdGbGtSQ0x2bXEwdHRVYUFyZVpn?=
 =?utf-8?B?YlJsSy9ZMVMwdDFIaHRlMVpuTkRwalNHdVcwMHpYNVdKaHI1enRhUkRHK28r?=
 =?utf-8?B?SnJPeGZBcWJmUDVsRUJFaWtBcTZOOFpZTlp3UExQQ2lOU0ZnWEJUUDN1SkJi?=
 =?utf-8?B?VldOaVZkUkhwRWFVUE9pQW1IYkkyTEVUWDJqUHpDeDdPUVRjZnI2RUZCSXlU?=
 =?utf-8?B?YnhBc3VhK3JLeGcyWHpiU2U3S0QzamVvVEVYeDhUTVdhd0pYTjVBZkpBMnl5?=
 =?utf-8?B?d1YralYrWHlpV0pSNGh4dDk2VUFDd1VGaS92S3JzbzB3Mi9Da0t0RnpIK0Jw?=
 =?utf-8?B?TjFKTURtZys5NndXZkREUGNXTTgwbWhpMXlkWGIvRWZoa2RVWmFHR3Y2akF4?=
 =?utf-8?B?S1B0MzJEZGFtWUZodldWRGZzakd4OTUyR1prVS9BTllwdFVJclEwTUdFeEVT?=
 =?utf-8?B?ejlvUDNZcGpJQXJaa2VUcGs3ZmxOem82WTd2bytFZHhKV2xkN0QwblFqd1M4?=
 =?utf-8?B?VmNRdG5vWnBheXV6Zm9lUG04eXVvSWQ4bXVOWWh0dUtoNTVCR3VJL2kxbHQ5?=
 =?utf-8?B?SnE1TDFjNWlkRDVwR1B6WDg2WUJhMmZKMi9PV2VNdlU1cFNLQXRKVG1ScnBQ?=
 =?utf-8?B?eGdkMjZzaVJYK3c0eXdJbE5XOVdmL2xMZE1jaHJlcW94SzR4bU8xWHltaDBW?=
 =?utf-8?B?S3FMdW4yWTlORUlubVFHQS9wRWJMYnpCaXBrNnRFSE1wMEZPeEFkcFdVOEZ1?=
 =?utf-8?B?endLVERnbHNIRHBWdWdVTEppcTdKUUtkaEJSR2FvNTh1M0pvaEtHQXZOanYw?=
 =?utf-8?B?bFQwYnFoaGpFZTNBTWZkMzVLU0RYZ1Fud3pZU2RmK1N2azBlZDNNMitUajhu?=
 =?utf-8?B?U211WEZVTThQZTYyTFpPdStrUTFiV01NTlJzSUFuMGdVV1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnpCSHV5ZUZKSW41MnViY2g5cm9ZZi9TbzgxbWdjL2xoUDdQR0syeHVLaGtC?=
 =?utf-8?B?QmhEMmZ6VTBSR1N1a05tRUZIaVRmOWZNRmcyakdIaE5kNkZvQ09haUdTcElL?=
 =?utf-8?B?UnB0QmkySFNXcEZFMTY3QTBKbVhCZW1remFBMnFwTmpMSXhuMjYxTmV4WDNv?=
 =?utf-8?B?YjNHR2hoYkZPSmhRa25NU0NuNFhCUUhWbmR2Y0pnRzdGcUVvMFJuSXdwaEMv?=
 =?utf-8?B?NUV1T3pid1Y1NWMzaWFqVzFGaGFZbFZJSnRoRGd0aUZRWnpFaFlTSUNvU09x?=
 =?utf-8?B?RnhmZmNBcDlMc0VnQzBWOXJBbUtmWU4zTmltK04wNWpWME44aUl5KzlwYTl3?=
 =?utf-8?B?dzdWRXVTWG1IbzFrL1JVUG56aFJGQit1bXlJcVpENFJEcVpMdGVxTGZxcHRt?=
 =?utf-8?B?ZHZTeENLWWliOElDai9sMkdSZWhxZXE5Rk9sd01iVGNzbkpDaVQrNTZjUDFD?=
 =?utf-8?B?SVhBWUtiMjlnU2hGK080dnREODdxNHNJa2VEZWtaZTZqVk9lV0xtc1lPT0Jw?=
 =?utf-8?B?TVN1YlBSSk9pb2tTdkxZVGpJcFhRdXQ1QUV0dW4vYXdLdUc0Q3ZVOC9wTE9m?=
 =?utf-8?B?b0wxdWxLSEp0UnZQS1lDQlpVOWIxSUZHUHJ2UU5RdFZzczdXTmFKMFRWYzFF?=
 =?utf-8?B?OU5YZmF1V0RJbEVlSXpiNjZDTG9BanQ5cHo2UzFqcUZZVk9qNnJadE1YSFE4?=
 =?utf-8?B?UUhCTjdpMEZZajBoOTNCWHJ1M1pNc1JsV0NRcFNWVG1wT2tnTmhmYzZIV2d2?=
 =?utf-8?B?anZkYzFUZDFyb1B2QlQ1ZlhCVVJqQU8xa3RiMHY1OUJVU2VFaXRaOVFCQU16?=
 =?utf-8?B?SDFUd1lGMGl3dEs5Y3dDMVozQmM5dEtBNkFvUDlpak9GYUc2NFZ2VUlwRjFt?=
 =?utf-8?B?N0NlNlpTdXdFWEpoQ2hNWXNIOFRQUEp5SVRVVlI4djlyWDdxYjJ6eGpYWmR4?=
 =?utf-8?B?cTBwc2tsTEdsdE1aai9vTzJHZXo0MndxL0J3RklHRE9pWk1xUGZaS21xWUJk?=
 =?utf-8?B?blZZNlNKMUlOUm00NlhrN05ZUHBzTjc2UjVGKzlmQU5UcmtGaEFjb0lra1NW?=
 =?utf-8?B?OVhxSWhiSWxkMk03NzZSbzljdTFJb1dsQzBuRjhENmMrN3BUdENrNXFSZFMx?=
 =?utf-8?B?N3NueFRETmg1UHE1a0FscERaRzJuRU1qdUVhdDBqS1E2VnNmTHRrUG5LN1ZR?=
 =?utf-8?B?YlZvSXVMVzZFVWNNMU1Lc0NmRVN5Q3U4bUdNRFl2TGp6aXNNL1B5ajZRdXRZ?=
 =?utf-8?B?MGhQZ3NOc3FVbWZ6SkJZYWRRRjRVTHg1eTd3K2RVdndCeGd6ZmhrWUFpcU9F?=
 =?utf-8?B?dngwWlJ1Q0JJVWVaRk5LR25KRVRZSVF1VmxTb2NHckRvenNqMmdaRG9VRmJq?=
 =?utf-8?B?TUg0N3laaENIWmszblduckJXVUdyaXMrVEZRYzA4NXNKZTdGcTdYSnRDUkVQ?=
 =?utf-8?B?VlVSMy9XK2grZWxCdlAyclJ0emZBRjd6Z291VklvdEpreklEamdYRDBiOG5W?=
 =?utf-8?B?bjZ3QzE0cXhIbHhwRzVjdC82ZmdXRlkvQ1U4bTN4LytOaFpXUE43MTBINElk?=
 =?utf-8?B?RzJRN0VTREZvT0gxZHUyQWhSVTVLdlFlVDNPdERLakg0UXhQazl4QXc4dFYz?=
 =?utf-8?B?bVB3L3lETVROaFVWaHIvaE50Nmd6YWkyZnMxOE5zemlENHltTGwyOUJhbVB1?=
 =?utf-8?B?QUV5c0ZsZEF1VzcxWGxwdVZZSmFRWTFjRVgrbVlFM3NBWEdnb1F6aGUxTjlO?=
 =?utf-8?B?eDdzK21VUWxGR0J3RDJET0xLQVBQanJnUi96YytUeDhjeDUwekUyZW1yRUlt?=
 =?utf-8?B?ZHl5OGUxZlN1b2dsRytYbnYvcHhXWkczckY2V3l4dVR3VFV6QjJESU1UYklM?=
 =?utf-8?B?dGZSbjA0VnlYMEI5WTUrY1doOVRiSGxaVlhKcW5XNFFIZG96RXBtMlFXVWNJ?=
 =?utf-8?B?NzM3YVRvOEx0cm1CUzdtYkN5NHhmOXJCaXloOFpPME92M2VORGhsTmd0YWg5?=
 =?utf-8?B?Uk9Ca25ZRGc4cjFXSEVOc280cmk1OUNmeFB4aXFQUHlvVW5CR1hTc1B6ZlBT?=
 =?utf-8?B?MnVzTHNNVjVkQldiUmIxYnpUMk5WK3Uvemk4MzluWEx3N2lTZEgxd1U5OXBF?=
 =?utf-8?B?SW1PV1FJek40NWQxS2NXRjJKWDdFaWRPUmVkNU9pb1FpbWl0QnZDa3RybzZB?=
 =?utf-8?Q?jKpatOFE5MqWvJDR5+xtnWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E71A97AA95ED024D92157F20D0853744@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8490045-3356-4adb-13f1-08dcb5e1ece8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 06:35:12.6112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibmIn+FiE1BytLO/nLuy/aCUT/xJxuF67earswlM42T3dJcFCM9rq3RCD1ab3x5gVTkYLTQ+in/5nP0rdu5LoykeeH0X1VsQr6kGAqf+KK/1fpU5WNEmHGS/L2ZaLeKu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8000
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

VHlwbyBpbiB0aGUgdGl0bGUgOiBzL21vZHJlbi9tb2Rlcm4NCg0KUmV2aWV3ZWQtYnk6IENsw6lt
ZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQoNCg0K
T24gMDUvMDgvMjAyNCAwODoyNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+IENhdXRpb246IEV4
dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5s
ZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gQWNjb3JkaW5nIHRvIFZURCBzcGVjLCBzdGFnZS0x
IHBhZ2UgdGFibGUgY291bGQgc3VwcG9ydCA0LWxldmVsIGFuZA0KPiA1LWxldmVsIHBhZ2luZy4N
Cj4NCj4gSG93ZXZlciwgNS1sZXZlbCBwYWdpbmcgdHJhbnNsYXRpb24gZW11bGF0aW9uIGlzIHVu
c3VwcG9ydGVkIHlldC4NCj4gVGhhdCBtZWFucyB0aGUgb25seSBzdXBwb3J0ZWQgdmFsdWUgZm9y
IGF3X2JpdHMgaXMgNDguDQo+DQo+IFNvIGRlZmF1bHQgYXdfYml0cyB0byA0OCBpbiBzY2FsYWJs
ZSBtb2Rlcm4gbW9kZS4gSW4gb3RoZXIgY2FzZXMsDQo+IGl0IGlzIHN0aWxsIGRlZmF1bHQgdG8g
MzkgZm9yIGNvbXBhdGliaWxpdHkuDQo+DQo+IEFkZCBhIGNoZWNrIHRvIGVuc3VyZSB1c2VyIHNw
ZWNpZmllZCB2YWx1ZSBpcyA0OCBpbiBtb2Rlcm4gbW9kZQ0KPiBmb3Igbm93Lg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPiBS
ZXZpZXdlZC1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZjxjbGVtZW50Lm1hdGhpZXUtLWRyaWZA
ZXZpZGVuLmNvbT4NCj4gLS0tDQo+ICAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggfCAg
MiArLQ0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgIHwgMTYgKysrKysrKysrKysr
KysrLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIGIvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4gaW5kZXggYjg0M2QwNjljYy4uNDgxMzRiZGEx
MSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4gKysrIGIv
aW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4gQEAgLTQ1LDcgKzQ1LDcgQEAgT0JKRUNU
X0RFQ0xBUkVfU0lNUExFX1RZUEUoSW50ZWxJT01NVVN0YXRlLCBJTlRFTF9JT01NVV9ERVZJQ0Up
DQo+ICAgI2RlZmluZSBETUFSX1JFR19TSVpFICAgICAgICAgICAgICAgMHgyMzANCj4gICAjZGVm
aW5lIFZURF9IT1NUX0FXXzM5QklUICAgICAgICAgICAzOQ0KPiAgICNkZWZpbmUgVlREX0hPU1Rf
QVdfNDhCSVQgICAgICAgICAgIDQ4DQo+IC0jZGVmaW5lIFZURF9IT1NUX0FERFJFU1NfV0lEVEgg
ICAgICBWVERfSE9TVF9BV18zOUJJVA0KPiArI2RlZmluZSBWVERfSE9TVF9BV19BVVRPICAgICAg
ICAgICAgMHhmZg0KPiAgICNkZWZpbmUgVlREX0hBV19NQVNLKGF3KSAgICAgICAgICAgICgoMVVM
TCA8PCAoYXcpKSAtIDEpDQo+DQo+ICAgI2RlZmluZSBETUFSX1JFUE9SVF9GX0lOVFIgICAgICAg
ICAgKDEpDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4gaW5kZXggMzE3ZTYzMGUwOC4uNTQ2OWFiNGY5YiAxMDA2NDQNCj4gLS0t
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
PiBAQCAtMzc3MCw3ICszNzcwLDcgQEAgc3RhdGljIFByb3BlcnR5IHZ0ZF9wcm9wZXJ0aWVzW10g
PSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9OX09GRl9BVVRPX0FVVE8pLA0K
PiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJ4LWJ1Z2d5LWVpbSIsIEludGVsSU9NTVVTdGF0ZSwg
YnVnZ3lfZWltLCBmYWxzZSksDQo+ICAgICAgIERFRklORV9QUk9QX1VJTlQ4KCJhdy1iaXRzIiwg
SW50ZWxJT01NVVN0YXRlLCBhd19iaXRzLA0KPiAtICAgICAgICAgICAgICAgICAgICAgIFZURF9I
T1NUX0FERFJFU1NfV0lEVEgpLA0KPiArICAgICAgICAgICAgICAgICAgICAgIFZURF9IT1NUX0FX
X0FVVE8pLA0KPiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJjYWNoaW5nLW1vZGUiLCBJbnRlbElP
TU1VU3RhdGUsIGNhY2hpbmdfbW9kZSwgRkFMU0UpLA0KPiAgICAgICBERUZJTkVfUFJPUF9CT09M
KCJ4LXNjYWxhYmxlLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsIHNjYWxhYmxlX21vZGUsIEZBTFNF
KSwNCj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgic25vb3AtY29udHJvbCIsIEludGVsSU9NTVVT
dGF0ZSwgc25vb3BfY29udHJvbCwgZmFsc2UpLA0KPiBAQCAtNDY4NSw2ICs0Njg1LDE0IEBAIHN0
YXRpYyBib29sIHZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVTdGF0ZSAqcywgRXJyb3IgKipl
cnJwKQ0KPiAgICAgICAgICAgfQ0KPiAgICAgICB9DQo+DQo+ICsgICAgaWYgKHMtPmF3X2JpdHMg
PT0gVlREX0hPU1RfQVdfQVVUTykgew0KPiArICAgICAgICBpZiAocy0+c2NhbGFibGVfbW9kZXJu
KSB7DQo+ICsgICAgICAgICAgICBzLT5hd19iaXRzID0gVlREX0hPU1RfQVdfNDhCSVQ7DQo+ICsg
ICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICBzLT5hd19iaXRzID0gVlREX0hPU1RfQVdf
MzlCSVQ7DQo+ICsgICAgICAgIH0NCj4gKyAgICB9DQo+ICsNCj4gICAgICAgaWYgKChzLT5hd19i
aXRzICE9IFZURF9IT1NUX0FXXzM5QklUKSAmJg0KPiAgICAgICAgICAgKHMtPmF3X2JpdHMgIT0g
VlREX0hPU1RfQVdfNDhCSVQpICYmDQo+ICAgICAgICAgICAhcy0+c2NhbGFibGVfbW9kZXJuKSB7
DQo+IEBAIC00NjkzLDYgKzQ3MDEsMTIgQEAgc3RhdGljIGJvb2wgdnRkX2RlY2lkZV9jb25maWco
SW50ZWxJT01NVVN0YXRlICpzLCBFcnJvciAqKmVycnApDQo+ICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQo+ICAgICAgIH0NCj4NCj4gKyAgICBpZiAoKHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdf
NDhCSVQpICYmIHMtPnNjYWxhYmxlX21vZGVybikgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICJTdXBwb3J0ZWQgdmFsdWVzIGZvciBhdy1iaXRzIGFyZTogJWQiLA0KPiArICAgICAgICAg
ICAgICAgICAgIFZURF9IT1NUX0FXXzQ4QklUKTsNCj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0K
PiArICAgIH0NCj4gKw0KPiAgICAgICBpZiAocy0+c2NhbGFibGVfbW9kZSAmJiAhcy0+ZG1hX2Ry
YWluKSB7DQo+ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJOZWVkIHRvIHNldCBkbWFfZHJh
aW4gZm9yIHNjYWxhYmxlIG1vZGUiKTsNCj4gICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gLS0N
Cj4gMi4zNC4xDQo+DQo=

