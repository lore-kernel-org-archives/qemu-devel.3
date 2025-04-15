Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82026C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 11:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4eop-0001Vs-C3; Tue, 15 Apr 2025 07:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u4eof-0001PS-Jg
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:51:06 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u4eob-0002RV-H0
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1744717857; x=1776253857;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=NFkl2nHE7fBF+93cmfN74Yk9lWLa4xOLvkEPnWKN9YI=;
 b=GpoSRD1HvJACEcbmxVbtOEcSuYL8/AXQImU1MSf73fRHayby9TXRjntk
 xXEB14NLnSMoC5MUy2T9stpwOx1Qp2+ie+mLa5RfneeQabpmR604l2xzG
 LBZobb+l8ObmbAcqfWkmcizyxGhWk1K5htJ7lAq0HXSf1at9R3b1KjPj/
 bw877K6ex2v0Q4vo2QXMLVBzGRS7fl47LfWuQ9fohnXFzBxRnLwRSMUoN
 6EcyuTY/I9O+7AXc+Oq8f7X1NlC53q0SHIVLwzR9X1RALbTfgqlFOJKOe
 nDusg93V+M67StNrxI6I83tXldYHjbIMYPxzNcMXbKW9ss5QF1Ix6pk6z A==;
X-CSE-ConnectionGUID: OAt3PcesTG2FTGLNd0FM9Q==
X-CSE-MsgGUID: 9yGzgljAQQWo2e2gzNl/Qg==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; d="scan'208";a="37071929"
X-MGA-submission: =?us-ascii?q?MDErPRvo+uCh+w/4yqaKDpSOj3BS8EPIDydqHr?=
 =?us-ascii?q?jwEPCwsQp4gN2M/DwlJDpV09gC9gvnq9iVlOiriBGFMop1TiPR1OFuSp?=
 =?us-ascii?q?w8r60vXRDpjtlvzKLpdlPzJrpgWGr0TyEvBPRRZPB1QM8zC7naViegMz?=
 =?us-ascii?q?zRu/5JwV2Oxufxyw2X/Xp3LQ=3D=3D?=
Received: from mail-am6eur05lp2106.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.106])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Apr 2025 13:50:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDcUIODHTqaDG9Zak+g4Lfqbus4HDjfuJY0TVJ8n76Gdtf0I+vGvU7B1+ZR5u1+gF/QiELgOsBLcSwQeo+tucJArWlLQwVvxldwoibIKx4cwM4zaCA2VeunRJQpOs5WzovLK8vmtvkP0+6g7Egu+q3Um1acbXAjQVovMun+N2QOaRcOVJofH8OmvOr8HMs39SfuN9cswvc5y6KUi5JFXDudPKHt3orH0uNjxmzf7KNJwnQ1e0CGsmYJx2WLabp0UrKDqcimguaxslW8WR0TGsgmqss4PXSC5s7GlZQ3/5XTfTn4PB88oy/PBi5RFb3vPXH041N7QKbGllaA+z9zcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFkl2nHE7fBF+93cmfN74Yk9lWLa4xOLvkEPnWKN9YI=;
 b=ZpSAnatY0IcECmvXwLY6HhoBBrwMBgdxOqUPJpVU9xvWAesB5TRXEO65BCMUciOVHoIqrZq0Rea4hOLpda0jCBr9VUgUWjsezyPfFN0aBQGalocPFB0x+KzhGu0Fxg2qvIuidQq9wjRa0Rlli72/AhpRH8MA+poGSDtYGTsqhKoarrEH9ACHddwbw9/j/26Zr3yTbimeYPD2HmdK607pD6QXs1PYkglJLqpR0hAVKhS4GzQD0ge0FIY0APSKB3I0deXjfeIbsBz9O+3bZKPFYax04hsza5qj1mvaRChwHsujAu8ozxT+dqxrhk0tk4yVwEQObDrVrHGvHHG2r1hvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFkl2nHE7fBF+93cmfN74Yk9lWLa4xOLvkEPnWKN9YI=;
 b=aFW/OdKprCOVSP5OuiMtMi0HaWVlnjyp1F/RT0RPM5hJm6Spo1w0WA8WnO7QMNjjsrkwjJviuFKUsW5ANA+s32ppd1jYCuaVXz8HXG1ykXiq127SjpKetWaoADkRvEWfnt10fl5XjimJh5pIslVpf+DlY87tXszTY7eYAdjTb6fiACpt92oaH3vYobLuPQCFbSvl9GiR9dpBLRvarB+Og3ALaPZd5NV6W/7l/eLSUSRqzOumGBkYTj4P0na43wSeVRqsdpwo2vcq1itJEjUPesgaObdnwYrzhsrKsU/0cGTioXE4Mq7xjLk+G4HZUEKJOgIfvXuZWWNW/jA02fiIVg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAVPR07MB9286.eurprd07.prod.outlook.com (2603:10a6:102:314::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 11:50:51 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 11:50:51 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Thread-Topic: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Thread-Index: AQHbrc4nGIHWbw444Um4nXxoEvkhVrOkdnQAgAAnMQA=
Date: Tue, 15 Apr 2025 11:50:51 +0000
Message-ID: <ed082405-06a7-4407-9230-3a9b7e91406e@eviden.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <c6f8ace8-6dfe-4ca7-992c-2fd10faa6127@redhat.com>
In-Reply-To: <c6f8ace8-6dfe-4ca7-992c-2fd10faa6127@redhat.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAVPR07MB9286:EE_
x-ms-office365-filtering-correlation-id: e4fa8652-f852-4f7a-a57f-08dd7c13c550
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c2czUlREV2kvT3I2Q21kbWlyOVp1RzI5OWJzeCtwSDEwWEN2RWJVUlNTWEdF?=
 =?utf-8?B?TEtNd1dWSklWT25WTk9TZUR5cmVCaVZzbFkzUHJKMjc1QjRaNlNlM2ZzTU9i?=
 =?utf-8?B?TVp0VHphc1ljeDdOZlBHb1VBc2h5aTN4Vk9WT3M0bzRnaTJEcnRiRldEVmpF?=
 =?utf-8?B?TFJ6SW92eXVzRHM2T0pJSzVMZFV1TmErV1cxVzJNeDhQQXJzMFRxakEyaTVP?=
 =?utf-8?B?bXJjaXROLythTmNiV0F3VDVxc3liNnlWQlMwQStuZW00UUN6RFgzeUFCK1Bk?=
 =?utf-8?B?VFlZN2VKRjY3Wnl4T2NXc01WZnRYeEUzNUt5cEpQMjRwSWM4QmMwZlZkdmp1?=
 =?utf-8?B?S2lsTW1nTkMrMzFJZXlLYkg5YmZIeXY2bDVKam1kT0NZWmpWcHV1ZnRxWnlM?=
 =?utf-8?B?MXM5OVk2U3ZwREdtNXNZQ2haaGVLSzFEa3lFVXZhZTRtV21JOFBBam8rMnRs?=
 =?utf-8?B?RUxmc1FVd0g5Y084K0djOUt4YXpTc3ZsY1ZSbzBTUXJRTm9LNGNSaDdnbHhT?=
 =?utf-8?B?MnZUaEtFTy9peXhIU245ckIxS1RiemRoM1FvMWR0Y0ZvWGovNzJweW9Mb0xK?=
 =?utf-8?B?U3UzemNxcUtsamJsdDFscjRPeVQ1Q2ZBNW9JRytHWUxaVHZ1V0VMLzJad1Ru?=
 =?utf-8?B?NXoyblgwa3lsbWRIS1ZNeVhnNUFFanBIdk9FQklOU2hFdFBRbWJyWHZnLzJm?=
 =?utf-8?B?bXZ3aFZ6RE9lZGpHUVFqSGdEUkloZ2pHY0IyeGk0ck9KMU93VUo0OHFzQ0RS?=
 =?utf-8?B?ODZDWTl4VDdwKzBhYnVaeTdRVE1sWGdGUFZiTHJkVW41dG5RZzV0aTVmaUlQ?=
 =?utf-8?B?ODd0blJRRnNxeEMxZ3ljK0lWZEhDcUpmTnV0ODh1d0MrR1ByeGhmV3NPcWp5?=
 =?utf-8?B?MndwNVBsSDlqR0daWVFmWE9NTUc5dVBIS29SSDY5anBYWXN4Y3JCY2t3aG9T?=
 =?utf-8?B?aVg5VkVYOElXZlRmRDFzSHQ0YmZueTIySEtwTm5haTVpZVpQbTJkcEtWMVAy?=
 =?utf-8?B?TEp4akdxaWlaMmdpQXhhUEgwdVAvL3hkSDBZdVlqNzVqRlc4ZkVkaHd4VE02?=
 =?utf-8?B?NHRqcERFczVFemplK3g5WDZGVStCTUZyVjlrWHZrNDFxV2N4c3RybHJjb0wr?=
 =?utf-8?B?Z1I5dE5hdDM4cFFmMGJYczR2NGw0OU52V1JvemNnU1Fhb2N3VG1RYlZMZGhO?=
 =?utf-8?B?MEZZaVJFZkc1VW9OL1RHZ3VlSGtMZlBienVXS3d4ZU02TzhlQjJzTFIxVDdN?=
 =?utf-8?B?bzVKcDNHTEMvZ0FQcEZZK05sVGV1S0htZ0g0Rm1KQ1IyOU9nTTVEZUJhc2Zu?=
 =?utf-8?B?MVcxVHdkbWZIZHRWaTVPQzdJRHhvYUhrU3UxQlh4TjhQNVJZRXFoTERSTWdX?=
 =?utf-8?B?V0pBandEZXZQT21mM1oxZHVBMWIxV2dQWjFjMWlUL1hGTEp0VUFJUWtvU2VN?=
 =?utf-8?B?UG1UWXNZaFlTOGZ1QiszQ0VzNEJRYkNWL3FaS1hKQTdXY0NFWWhOYlU1bjla?=
 =?utf-8?B?R0c1RGo2V25hMWtTY3dJZFlkV1Vxc3VkTnJwQ1grdFdUUGhaVHpFWmRGMnl2?=
 =?utf-8?B?U1ZEUkdNdkYzSXpVWlFYY052VERueURjbkpCR1JhZDdQbWVzUVBQQUd6Z2Fx?=
 =?utf-8?B?RWVkUkorcnNkM1ZGNFNDK09weDNZWTdNM1BPR2phYmtzMTg2anNPZWJYZ1Az?=
 =?utf-8?B?VldKQkdveWs5ZnNNOVN6bHJGTDZCdGJwSWgxYnEvcFlDSmhId3ZCZlNwbGRZ?=
 =?utf-8?B?SGhoekpQNkd6ZlkzUllKT2IwY09rbmNQUTRwWHcvM1l2ZkJxRGpmQ2lwRi9Y?=
 =?utf-8?B?NTNjSUJXWWUranVDOC80YVVLcWR6T25pNHluc2lLZngrek53a3RQbjBrRXlF?=
 =?utf-8?B?OURyWDV3a055UTBTM2hNanlyV2x4NU85a1lyM0RnWktNTDR3OFRHN0QzNHY5?=
 =?utf-8?B?N0lpUnZPZHd1TWVvZ21zd3AxNFZxU2l5TWd3Q1hDSWo1Ym9FVGZYY2VIVmd5?=
 =?utf-8?B?cjlYbS90TXlnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHFmVm5IMENlV3JLLzh6Y3pNb2xTenlCVm5Qc2RySEJ1bUNWK3RaNm1tTjVC?=
 =?utf-8?B?ZDVRcUNxcmVUaTFCNUpWc1kvYy9Wck1uMVMvdm82d3pZVWhTSklhNHJCcldr?=
 =?utf-8?B?MGdzSTlFSzZBK1psclB6emRueS9wc0ZlQ1Q0bjlTRHk4NnpKemhXMEN5N29u?=
 =?utf-8?B?SVZhMGQ3RVpSMWJRNnZCOXlPQXBiMEh5K0ErWUxxQ0F2WTMrdis2bjg4MDZ4?=
 =?utf-8?B?WWsyeHVxOStYdVJSdTJzUGdoOHJ4aElmenJPbGxFL0s0cU9QUnNNZGpab1BF?=
 =?utf-8?B?U0hqQ2lsVjByTjY0MGJNTEZ5QjdJaGlyaXMxUHI0YzhXYU1VOGJad09oek1h?=
 =?utf-8?B?MkhwOGxnME14L1ZHcFZOVXNsRXlPd0Y4R1dvU2pQVitOcXZncXlibEIvWWNq?=
 =?utf-8?B?QU9XcDgyN3pNN1ArQU42V2RWbUtueGo2UCtjcHBJR0Y5bWtBSUVUY1hQTmoy?=
 =?utf-8?B?S0V4eGVPSmFZN2p3Z3Fud3pBRmxQRkRzNWR4T1huMmtxSXVjbCtkKzI2NWFx?=
 =?utf-8?B?QUkrOU44MDUvUXl6R3pNY0JKdFkwTEgyNDEzOFc1STRYTnZtMjZMSk44WFcz?=
 =?utf-8?B?N3I5SXhINXhxdk4yWVBRQkQ1WmVNaDVTUVZISWZJazZwV0tQdnNCaVlPTnBo?=
 =?utf-8?B?NTBpdG1Db1ZpUlU1eFBFNkE1SzZORjArV2xzVVM4Ukd4a3NZVjUyTnNxNHRw?=
 =?utf-8?B?MlhVcElna2hjT0ZheEhrTURRTFVGK2JmL2tzUEJoZzdyaDYycUpTbWJEU2tW?=
 =?utf-8?B?N1pUMk1jTm5GY2xnQldNRXZMSmkzY004OGVqdEdsUE9xa2VTVXdObFNzQ2dG?=
 =?utf-8?B?VVYvaHBneitCQUZsMzhPT2Q4cjFtaW9zbkRYd2Z2TlVXOFNlYkVxM1FBeHNi?=
 =?utf-8?B?a09lUjVRZjNGTkZLTXBmTG1LMGtxUHlGK0pyZFBLVG40SEtJekNFOFRpbjNG?=
 =?utf-8?B?TlN6cWpOL29RdEN3TlVTRXU1cVFRcnhoZFVYaFdiT3VVTEtMVVVKYzdySzlV?=
 =?utf-8?B?YUNtU1RyQzltRFpmNFdhV0tZSTFudkhFbytYYk9wWjVJRVozSGJqK3dlcEhK?=
 =?utf-8?B?LzV3WHpzZE4wR3JRMWRia2VRK0ptczJUQ05TenYwbHd6MTErVzdyRW9LU1ll?=
 =?utf-8?B?R21UWThMd2kyQkRNc2YwbFJsNzFBWUJPZ21EaTFRak1VV2E0RFdleXg5WllP?=
 =?utf-8?B?WDJvdmNXMjNPSzBHcnU2TzBOWU40YzcweVV3OFZvN1dxbDJBemdHbnBmUGtZ?=
 =?utf-8?B?SDk5RlpLVDJJNDdWeWFaZTRUTEYvc0FpSWNCZk81TGVqOVFNY2JLWVExcTdT?=
 =?utf-8?B?NFVWRDR3WHFYN1VNOFFyZTd4U0NLd09RVlhYbVdjUkhYcGRJVVVZQ0Y2M3Bo?=
 =?utf-8?B?WnlhL3pWZFE0TFRpZElMeVpTMy8xRjJueFZEWStOTktjdWhPUmZhYXUweHpR?=
 =?utf-8?B?Zm53SzlEYkIzM2ZlNmVqcDh5SUJmRSt6dExGd0ZJeGxvRVp0R2ZxSDZrUjhz?=
 =?utf-8?B?WDZaRUZ0VGdwMGUvbmJWSnRJTCtLNHUwdHJMVURETWlwYmZwSmNjUTk5dHU5?=
 =?utf-8?B?b0RkaWZxZk1zaUplMU5jaUFxT3pwVHdpN2x4RWUreGx5dmpUNEFIc3dTMmNB?=
 =?utf-8?B?R2hkTUF3SjhESW0xYVBhR2JYQWRtN3NXSWQzMEdENHA4d2c1WlFQRDZJNExI?=
 =?utf-8?B?RTdQSnUwM2IxTHdPZFdGbHI4Y3hyMVZaTWhONGdidG9wazhFai83ZHBpK3ds?=
 =?utf-8?B?MStiTFJTRnNrL2IzWDk4L2xpNXdESlFFRldpYzMva2hHMzVPZW9NT2t1b2Zi?=
 =?utf-8?B?cTVqM2pFRGVuL052R3JzdERWVUxEM1ZNdEI3OTZ5SEs3L0ROclhtdkNwcEhI?=
 =?utf-8?B?Z25kWGZRendZR1dvQzZnaThlN3ZTQm9BNjJxVDZGNU8wZmc0RkJDL0hYVDdT?=
 =?utf-8?B?K0RPb0pSUjVrVlJnaXRDZVlpeks4R3RLQkRvNFdNcG9XWThzRzZZa0VhazZS?=
 =?utf-8?B?ZmNlc3Q3K0JYYVVqK2I3VkRZNk5jbXJaYmMvTDZrZG1LQ2NMdkhNQkw0MkJ6?=
 =?utf-8?B?eFUyMXJhNjFzOUxSVXdKdGt4NTZzQ09xQ1U2RHZZaFUxYWJEVXlDMncvdEJh?=
 =?utf-8?B?bWxJNEVEVy93dEw2azU5MlRxb21NQ0V4K0RnRkJKQjNCYmNxSHB1U3BKNjdw?=
 =?utf-8?Q?DSoZfYTs9z+LnhjRGe+zU3w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4F5C52160E663459EBFB97823CB7DEF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fa8652-f852-4f7a-a57f-08dd7c13c550
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 11:50:51.2629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luPFN8FrVzH+is3kyb4COS3bAoJ5oXw1ZXOyCNNqnWI9TctjCJWvHAKMUKde88kI3WRLzavtmbllhLeGL5hv2p+WpTk2j15Kwqr3aOio/3e2Q/exC3BxXR5fI1PVv6Dk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9286
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

DQoNCk9uIDE1LzA0LzIwMjUgMTE6MzAgYW0sIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+IENhdXRp
b246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5r
cywgdW5sZXNzIA0KPiB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gNC8xNS8yNSAwODoxOCwg
Q0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4gQWRkcmVzcyBzcGFjZSBjcmVhdGlvbiBt
aWdodCBlbmQgdXAgYmVpbmcgY2FsbGVkIHdpdGhvdXQgaG9sZGluZyB0aGUNCj4+IGJxbCBhcyBp
dCBpcyBleHBvc2VkIHRocm91Z2ggdGhlIElPTU1VIG9wcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBDbGVtZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29t
Pg0KPiANCj4gUGxlYXNlIHVzZSBhIHNlcGFyYXRlIGxvY2sgaW5zdGVhZCBvZiB0aGUgQlFMLg0K
DQpIaSBQYW9sbywNCg0KV2UgbmVlZCB0aGlzIHBhcnRpY3VsYXIgbG9jayBiZWNhdXNlIHNvbWUg
b2YgdGhlIGZ1bmN0aW9ucyB3ZSBjYWxsDQpyZXF1aXJlIHRoZSBicWwgdG8gYmUgaGVsZC4NCg0K
SXMgaXQgYSBwcm9ibGVtPw0KDQo+IA0KPiBQYW9sbw0KPiANCj4+IC0tLQ0KPj4gwqAgaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIHwgMTAgKysrKysrKysrKw0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCBkZmZkN2VlODg1Li5mZWEyMjIwMDEz
IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4+IEBAIC00MjE2LDYgKzQyMTYsNyBAQCBWVERBZGRyZXNzU3BhY2Ug
KnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgDQo+PiAqcywgUENJQnVzICpidXMsDQo+
PiDCoMKgwqDCoMKgIHZ0ZF9kZXZfYXMgPSBnX2hhc2hfdGFibGVfbG9va3VwKHMtPnZ0ZF9hZGRy
ZXNzX3NwYWNlcywgJmtleSk7DQo+PiDCoMKgwqDCoMKgIGlmICghdnRkX2Rldl9hcykgew0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2dGRfYXNfa2V5ICpuZXdfa2V5ID0gZ19tYWxsb2Mo
c2l6ZW9mKCpuZXdfa2V5KSk7DQo+PiArwqDCoMKgwqDCoMKgwqAgYm9vbCB0YWtlX2JxbCA9ICFi
cWxfbG9ja2VkKCk7DQo+Pg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG5ld19rZXktPmJ1cyA9IGJ1
czsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBuZXdfa2V5LT5kZXZmbiA9IGRldmZuOw0KPj4gQEAg
LTQyMzgsNiArNDIzOSwxMSBAQCBWVERBZGRyZXNzU3BhY2UgDQo+PiAqdnRkX2ZpbmRfYWRkX2Fz
KEludGVsSU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
dnRkX2Rldl9hcy0+Y29udGV4dF9jYWNoZV9lbnRyeS5jb250ZXh0X2NhY2hlX2dlbiA9IDA7DQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgdnRkX2Rldl9hcy0+aW92YV90cmVlID0gaW92YV90cmVlX25l
dygpOw0KPj4NCj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBTb21lIGZ1bmN0aW9ucyBpbiB0aGlzIGJy
YW5jaCByZXF1aXJlIHRoZSBicWwsIG1ha2Ugc3VyZSANCj4+IHdlIG93biBpdCAqLw0KPj4gK8Kg
wqDCoMKgwqDCoMKgIGlmICh0YWtlX2JxbCkgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YnFsX2xvY2soKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+PiArDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgbWVtb3J5X3JlZ2lvbl9pbml0KCZ2dGRfZGV2X2FzLT5yb290LCBPQkpFQ1QocyksIG5h
bWUsIA0KPj4gVUlOVDY0X01BWCk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYWRkcmVzc19zcGFj
ZV9pbml0KCZ2dGRfZGV2X2FzLT5hcywgJnZ0ZF9kZXZfYXMtPnJvb3QsICJ2dGQtIA0KPj4gcm9v
dCIpOw0KPj4NCj4+IEBAIC00MzA1LDYgKzQzMTEsMTAgQEAgVlREQWRkcmVzc1NwYWNlIA0KPj4g
KnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzLA0KPj4NCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCB2dGRfc3dpdGNoX2FkZHJlc3Nfc3BhY2UodnRkX2Rldl9hcyk7
DQo+Pg0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmICh0YWtlX2JxbCkgew0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYnFsX3VubG9jaygpOw0KPj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4+ICsNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBnX2hhc2hfdGFibGVfaW5zZXJ0KHMtPnZ0ZF9hZGRyZXNzX3Nw
YWNlcywgbmV3X2tleSwgDQo+PiB2dGRfZGV2X2FzKTsNCj4+IMKgwqDCoMKgwqAgfQ0KPj4gwqDC
oMKgwqDCoCByZXR1cm4gdnRkX2Rldl9hczsNCj4gDQo=

