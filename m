Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C407CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 15:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPj9W-0002nA-0f; Wed, 20 May 2026 11:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPj9P-0002kv-4f; Wed, 20 May 2026 11:48:05 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPj9M-000314-P6; Wed, 20 May 2026 11:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2KqBjMODKuPkncoJBJo9ey6fn+F6fqo/hk+FhwRgpT1kPB/kvuBVHXteWbJSqRK7SA3/iUMcM1SPjIaAbSPnlbi8EOoeU5mLDJ+hYNbEpNOsuoYtzMfe4DEOUqgk7IVTg/klyNyiJFDZl60cAgXWlYWZRo8rX0LE2fr6A7Aty8dA+6gxTm79IkEX37249MCCz8mjYiHwjE64eh+c12Mgde0Oq2QIX6Di2V1x88Tbk6Om6SfvexXsjEy2yyjf9xg+RZPcVuTpvI5iWqbfTYvsGHFT1R3yZZp3vijDheEWTe6Pa28JLpCz0xp2ao7zdzL7BTn7cmmQXG/Y9HPBR2GnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xRyzfZxAv1RysWU049eaec6sFK0yKfy7W1wMuTFDq4=;
 b=Y9vQ4ZqPwCLk8DiS5ytN8HXmtBUO+ZatP3kqaeGUjkkDThPhmn0EFZFDmNB++kGsVk2oO2yCAgYKADJp2pwG4FKrAjT0t+15IFH/5UAEiLmXqXw0dNOqVhDOvnZbpyVN1CTJm4WvCnbvhwWflYfs0KksJ9yBA6YjJNO/YkCDp95J5tQQ4w5KcSfhu2bAMAT2PhczFEEOj7HeEkONCZYlZFUY74oAPdZOxbERUS2VZGuI21WnA/AwhF11g/hKrvavOCskOogYFUSQqNDqddSj/XtHn+q+xXVCfNMQavT4Lbp9LISu6hMQp5tQCogiE8SSPIeIoEEWUG6YtZRQbDqhJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xRyzfZxAv1RysWU049eaec6sFK0yKfy7W1wMuTFDq4=;
 b=rDtSgNZudNQ+T63NgDaOiIn0MZoqD7iNNuqUyROK8Rv2e0KbQVHF9F8uuzrhKoLw6J37Lx5Roh8XupIRouCO112oVvQitWpBtawcUOpOelWItEFNCe+wCRyi+wEy6Ixjw0x3U34w9vIt1o3ba1BpiNLejXP4AI66QRaJ3qqvtCs73J2qD7g84KC0aXj2bxCmEpq+8m+7nhRI1rQqUHQSKvLzy2sWkgP00zsKj1FpwctJ9r2lpbWJvKS6uoI03BA8HqdyrnrJt9yEcpNNlTPk+QzGXrc5tTgUANbWqmb+v/auxbzEG7sf4txyQKqqMzw0RizlBA8CO0fQV5so2SoqAg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 15:47:50 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 15:47:49 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v5 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Thread-Topic: [PATCH v5 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for
 CMDQV
Thread-Index: AQHc53vPgzHMdzCVJUyI0UoOS0aBX7YW4H8AgAAoG0A=
Date: Wed, 20 May 2026 15:47:49 +0000
Message-ID: <CH3PR12MB75486D02EEBCE74D47B20834AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-18-skolothumtho@nvidia.com>
 <c0dd92b2-4ea9-45a2-afbf-b61910f71fe6@redhat.com>
In-Reply-To: <c0dd92b2-4ea9-45a2-afbf-b61910f71fe6@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA3PR12MB9227:EE_
x-ms-office365-filtering-correlation-id: d93a53b7-2416-492e-a7dc-08deb6872559
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|4143699003|11063799006|3023799007|38070700021|6133799003;
x-microsoft-antispam-message-info: ofWisf1Jcx3ibnZzD9pn6fQJw1j0EGJQJv84x/sCZ49kbqauvNkR+qF9yRZ9iH989kG1oBpKc/lW7+y0kd2LBG2wvpIVnDL7F/YjoKjyE2B6/Qq2XhXO4QrPTozPAVzYva/4p5SdL8x+e8BXadq6MWrs50riAzta0FXpDOs5rpOQATs4MDo0JJNRIb1Fp+cykVmz3/EB1XmzHa2WJN/RQ2Rabjh6XmIZxjGLBFwgVmwoDeWRahulMcp28w2OEK/BpA9yRcX+dYSsieH+asZiSMdCC7mI0YUILhrawjRIRNbO8AUio/QscM3sSvRschER7MfragLKJE9ZIGx956TPPVQcvXcdbwhsXhtfsQ1iRpluTeLDJw/ug0swHg0Yzt9BH1xiuuRuZ42BVtp+vy+bGLXwg/mKbR/PYYROcIELOGEG4VsAsgzBhpB1+cqPaXcT/4maMcP9we9PSkPZrOzC4Wq0HCxcwiWuq11FnerkyJv0m6+Tp+P4GvS3XAujkOWe5q09iytK+tMF9o2okMVRvoS9mB470s6n8Vm3uRYSnYq3R/d+wWAOiiNaqFmTaU86qy2Dw2BrmYyVMCEcC1mh41w1Av8QqZhKZzPPmoGQ4TkgAQrM+BjkkC5pOuxilImdpAqEaZ+gwlfhWxx/Sb+tvGRs/FWg9jaWHkERy9hximRLvwWP+ku5Cw9Jx4C6s08plbtp5kTooq9qifYf9CPLCaOWtIgsRjLcn9Uc4I4qI4tKPxZFMwDh1enfPLoDRh5s
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(4143699003)(11063799006)(3023799007)(38070700021)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1EwVVBJSG55VzJsOTNlRS83UCtsUzM4RjFiaElycUVMSHJXSjk5Mzh6V1R1?=
 =?utf-8?B?L1czb0lWMmZUblhVamJEUDlVODV2dU9PSHFiN3FCMFd3SnZUY2V1OEl1OFF1?=
 =?utf-8?B?UUpqRDNMZS9VSWZtRklFUDJNdmhCaXA3WGxxclg1amRUUHE5OVhXUzB1Z3BW?=
 =?utf-8?B?ckJKTFNkTUtCcDcxZHJGWlZobENlRnQ0UGZFUTlHWUdtcXlCRk4xTkhrTk1h?=
 =?utf-8?B?Y2EvWmowMWdhK1hla1BnNStwUjRDamVmUThFNEFDLzJoSnR1TDZMVGJZcHVW?=
 =?utf-8?B?K0tRYzZjWkhvOVBoSm5RQ080anhtOGZNNEpEbVhuL0VoR3JscGQ0RnNhS2pl?=
 =?utf-8?B?ZG9xM0t4U1lscXF3bnMxQy9yclhvOHNlWTNhMm8vUFVwT3RCdlBLdWtvVlo1?=
 =?utf-8?B?WW1UeWpUWnhtZ2dYS2N2VEdWVGlVR0s3bUJCOGZFMzFLbHFoK3g4YmNvanZ6?=
 =?utf-8?B?b2ZVTTFQZHJDdnVRUUFMaFhjM2EzT1d4bWZVd0oxZ0JHQm1XZFlEaW1HMmtV?=
 =?utf-8?B?NVo0Y1RNUlpMZ1V6WkNBcnluZUN5djdlcEtzaEl0elpLc0JKQUhSQkJrbU1r?=
 =?utf-8?B?NjFtNDBBODNkTktHM3ArQlRzL29nZEVJc1Rra3dCYy9kRHVncVRGVlBTL04z?=
 =?utf-8?B?a21oR2owNDBGNUpiM09qbHhzYzFkNGthTVBOK3ptZURyeDZWd1ZtRHlSQisy?=
 =?utf-8?B?MFUvZzVubTU1ZkVVWE16YjhjVmdQOGI1d3ZCS204ZExTK2JmMVpvRllYQjAy?=
 =?utf-8?B?WHUzdDY3ZU1kZEYxOWxrTVphNjNuM2dTTkp5NVQyMlBaOEVUdzBHeVA2aEZH?=
 =?utf-8?B?YkZXVjZpQWwwY0F4aURGR0F0QWg5Tll5VXlseEVBUHhPbkg3ZFdoY2NZbTV2?=
 =?utf-8?B?V0hoQUlFL1NLKzdqZTRvUXE2eHpuby85UWhMY3Z2NStHS1gveUtrN3M3YVk1?=
 =?utf-8?B?c2l5V2ROUGdoeGdNTjRRejZuK2wySDlMSXdWTlZhbGFWR1diSE5oUmFhMGdv?=
 =?utf-8?B?U1hTQ1RUazEyYnlBWmQyWWJzSjhQWmZpWi9LWnpoekkvRWlMN3J3Y2E5TVRF?=
 =?utf-8?B?Sk4yTmtlYzNVOUVxZUpTdmExbEF0UG5XSFdTTDJNZEVFOTFRL0lYcXpySHkx?=
 =?utf-8?B?bWJuTHBsNW50MFVsOUsyK3FiZ3p5NVlDUEFWajZvcGpxQmduaFJhYTRtZUJm?=
 =?utf-8?B?dHNKWmxDL0duRWNMZlpocEFReTJOYkx6MjZPZm5hOFdoT3EvcjNrMjNmaTFl?=
 =?utf-8?B?RWJreVJ3Ny9zSndsaThjaThGQTJacDc3cER6anhxMGdBTnJPeHlDcHNOZ2Z5?=
 =?utf-8?B?NE5yVUJVcERWNjNEb0dYSjNzZittanZoanMwSTFJb1V0U3U0M3Frc2MvMTBa?=
 =?utf-8?B?amsvWGNsblFlVWlTSVJZczNpQ2s1amtEVGxuYUNzcVR2R2xGZGZ0MFRLaHVw?=
 =?utf-8?B?b09CMGdCWlAyRFIvanY5OUVySmtaenZCdlpGWGhjNXlqbURHcTJuN3hlbzhm?=
 =?utf-8?B?U1NHTGsvS1Ewd2djUGhYT3pGdEtxZHYwQ010Y1FrWEJiVVFIdU1qbzc5NDNU?=
 =?utf-8?B?QXhnczc2d2NpbDc3UzVTQTFWbm1JeHhWc0Jwd0xjVzhadTdsb1dnYkVvNU5o?=
 =?utf-8?B?SXNZenZ6cVJzTWVFZk1xVzJhZGRmNE5kTWlnZ1hSQnduRFZnTFQwN00xVDMv?=
 =?utf-8?B?Rkc1VWpIVUlmUkNSM2NBWERjSGV3MFRoRkVOeStLdk5TZHN0L0MvbnVqMlNz?=
 =?utf-8?B?WVhqYlJvM3paMjVJNUdqS3IzTFBtd2Frb0tUT1UzT0hqTHBFZWxja1BPUEFJ?=
 =?utf-8?B?eDgzMWlkK2s5a3VNS3A5MjcwTnlJTWY0c0ZmdUZVdnJlekxMYTArZ2hNOTVG?=
 =?utf-8?B?L1l4dTEwWS9UMHZHSC9HSVBaUHpSKzBjOU4zTXJxd3ViZUxUVEhHSDVoVDRn?=
 =?utf-8?B?Z28wZmhiK0dFSWZEcUhkNHl6czJ1MlNNQVlKQUJMM0xYYUpKQmRBL1RRNHFP?=
 =?utf-8?B?emRObUU0WE5lSGQwbThYTkk2Ukt2bGczdUJCS0pNNlhLTC9Xd3dUMzVYdXRC?=
 =?utf-8?B?WVRtVFRvN1hwcG9sbVFIQ1VPKzdGZmJFY3VrY3Bjc0JSVUhoV1N3UytpKzNG?=
 =?utf-8?B?NG5tVDZuQWhkUWtZeU8zakl3VnFqSzlDdGdWWER1WlRYV0FobTYxQ2ZvWEpM?=
 =?utf-8?B?b0c4d01oOFowalFBWVlDNG1hSFA3RkxSUHZmdTlURTdvQXFKNGpaNDd3SVVD?=
 =?utf-8?B?N0I0MnQvOGkvc29FSHRJaUJuOWNtRXBsUW0vMC84dE5BZkFGNk56QnVXNGtJ?=
 =?utf-8?B?SDNVaXh0cVFJaVRXd291SGhLVkU1NkJKQXlYdnBZR2tWU2lHbExGQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93a53b7-2416-492e-a7dc-08deb6872559
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 15:47:49.6038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNV+VO3qgBikYlwxwwvfGRjOrYAfK9YJZloQGBN+uCl+X72m6WzD4ZeLyGIAPv3W5SAKRy8BavtgkC3NqA0IVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDIwIE1heSAyMDI2IDEzOjU0DQo+
IFRvOiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFl
bXUtDQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5p
Y29saW4NCj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5j
QG52aWRpYS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4g
PGphbkBudmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlh
LmNvbT47IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDE3LzMy
XSBody9hcm0vdGVncmEyNDEtY21kcXY6IG1tYXAgVklOVEYgUGFnZTANCj4gZm9yIENNRFFWDQo+
IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cw0KPiANCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiA1LzE5LzI2IDEyOjM2IFBNLCBT
aGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEZyb206IE5pY29saW4gQ2hlbiA8bmljb2xpbmNA
bnZpZGlhLmNvbT4NCj4gPg0KPiA+IFRoZSBDTURRLVYgQ01EUSBwYWdlcyBwcm92aWRlIGEgVk0g
d2lkZSB2aWV3IG9mIGFsbCBWQ01EUXMsIHdoaWxlIHRoZQ0KPiBzL0NNRFEgcGFnZXMvVkNNRFEg
cGFnZXMgLSB5ZWFoIHRoYXQncyBhbGwgdmVyeSBjb25mdXNpbmcgOy0pIC0NCj4gPiBWSU5URiBw
YWdlcyBleHBvc2UgYSBsb2dpY2FsIHZpZXcgbG9jYWwgdG8gYSBnaXZlbiBWSU5URi4gQWx0aG91
Z2ggcmVhbA0KPiA+IGhhcmR3YXJlIG1heSBzdXBwb3J0IG11bHRpcGxlIFZJTlRGcywgdGhlIGtl
cm5lbCBjdXJyZW50bHkgZXhwb3NlcyBhDQo+ID4gc2luZ2xlIFZJTlRGIHBlciBWTS4NCj4gPg0K
PiA+IFRoZSBrZXJuZWwgcHJvdmlkZXMgYW4gbW1hcCBvZmZzZXQgZm9yIHRoZSBWSU5URiBQYWdl
MCByZWdpb24gZHVyaW5nDQo+IGZvciB0aGUgaG9zdCBWSU5URiBwYWdlMCBhbGxvY2F0ZWQgZm9y
IHRoZSBWTQ0KPiANCj4gQWN0dWFsbHkgaXMgdGhlIHdob2xlIGhvc3QgcGFzc3Rocm91Z2ggcHJp
bmNpcGxlIGlzIG5vdCByZWFsbHkgZXhwbGFpbmVkDQo+IGFueXdoZXJlLiBBdCBsZWFzdCB0aGF0
J3MgbXkgZmVlbGluZy4gSXQgd291bGQgYmUgbmljZSB0byBoYXZlIGEgc3VtbWFyeQ0KPiBmb3Ig
aXQsIGluIHRoZSBjb3ZlcmxldHRlciBhbmQgaW4gaW5kaXZpZHVhbCBwYXRjaC4gT3IgbWF5YmUg
d2UgY2FuIGxpbmsNCj4gdG8gYW5vdGhlciBkb2MuIFJlYWRpbmcgdGhlIGtlcm5lbCB1YXBpIGRv
ZXMgbm90IHJlYWxseSBwcm92aWRlIHRoZSBmdWxsDQo+IHBpY3R1cmUsIGF0IGxlYXN0IHRoYXQn
cyBteSBvd24gZmVlbGluZy4NCg0KRmFpciBwb2ludC4gQSBzdW1tYXJ5IG9mIG9wZXJhdGlvbiBp
cyB1c2VmdWwuIEkgYW0gdGhpbmtpbmcgb2YgYWRkaW5nDQppdCBhdCB0aGUgdG9wIG9mIGh3L2Fy
bS90ZWdyYTI0MS1jbWRxdi5jOg0KDQovKg0KICAgKiBUZWdyYTI0MSBDTURRViAtIG92ZXJ2aWV3
DQogICAqIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KICAgKi4uLg0K
ICAgKi8NCg0KSSB3aWxsIHBvcHVsYXRlIHRoZSBkZXRhaWxzIGFuZCBzaGFyZSBpdCBmb3IgcmV2
aWV3IGJlZm9yZSB2Ni4NCg0KPiANCj4gd2hlbiBhIFZNIGFsbG9jYXRlcyBhIFZJT01NVSBmb3Ig
dGhlIENNRFFWLCB0aGUga2VybmVsIGFsbG9jYXRlcyB0aGlzDQo+IGFuZCB0aGlzIHJlc291cmNl
IHRoYXQgaXMgdGhlbiBnaXZlbiBmb3IgZXhjbHVzaXZlIHVzYWdlIG9mIHRoZSBWTSAuLi4NCj4g
SG93IGRvZXMgaXQgZ3VhcmFudGVlIHNlY3VyaXR5IGJldHdlZW4gVk1zLCBldGMuLi4NCg0KSXNv
bGF0aW9uIGlzIGVuZm9yY2VkIGJ5IHRoZSBrZXJuZWwgYW5kIHRoZSBDTURRViBoYXJkd2FyZS4N
CkkgdGhpbmsgdGhlIGtleSBwb2ludHMgaGVyZSBhcmU6DQoNCiAgLSBFYWNoIFZNIGhhcyBpdHMg
b3duIGlvbW11ZmQgRkQuIEFsbCBpb21tdWZkIG9iamVjdHMgKFZJTlRGLCBodw0KICAgIHF1ZXVl
cywgbW1hcCByZWdpb25zKSBiZWxvbmcgdG8gdGhhdCBGRDsgb25lIFZNIGNhbm5vdCByZWFjaA0K
ICAgIGFub3RoZXIgVk0ncyBJRHMuDQoNCiAgLSBFYWNoIEZEIGdldHMgaXRzIG93biBWSU5URiwg
YWxsb2NhdGVkIGJ5IElPTU1VX1ZJT01NVV9BTExPQy4gVGhlDQogICAga2VybmVsIHdyaXRlcyB0
aGUgVk0ncyBWTUlEIGludG8gdGhlIFZJTlRGIGFuZCB0aGUgaG9zdCBDTURRVg0KICAgIGhhcmR3
YXJlIGNoZWNrcyBpdCBvbiBldmVyeSBjb21tYW5kLiANCg0KICAtIFRoZSBrZXJuZWwgYWxsb2Nh
dGVzIHRoZSBWSU5URiB3aXRoIEhZUF9PV04gPSAwLCB3aGljaCByZXN0cmljdHMNCiAgICB0aGUg
Z3Vlc3QgdG8gYSBzYWZlIHN1YnNldCBvZiBjb21tYW5kcy4NCg0KICAtIFBlciBWSU5URiwgdGhl
IGtlcm5lbCBwcm9ncmFtcyBTSURfTUFUQ0ggYW5kIFNJRF9SRVBMQUNFIHNvIG9ubHkNCiAgICB0
aGUgVk0ncyBvd24gdmZpby1wY2kgZGV2aWNlcyBjYW4gaXNzdWUgY29tbWFuZHM7IG90aGVyIFNJ
RHMgYXJlDQogICAgcmVqZWN0ZWQgYnkgdGhlIGhhcmR3YXJlLg0KDQogIC0gSU9NTVVfSFdfUVVF
VUVfQUxMT0MgYmluZHMgZWFjaCBWQ01EUSB0byBvbmUgc3BlY2lmaWMgVklOVEYsIHNvIGENCiAg
ICBndWVzdCBjYW5ub3QgcmVhY2ggYSBWQ01EUSB0aGF0IGJlbG9uZ3MgdG8gYW5vdGhlciBWTS4N
Cg0KPiBGdXJ0aGVybW9yZSwgd2hhdCBpcyBub3Qgc3RyYWlnaHRmb3J3YXJkIGluIHRoaXMgZGVz
Y3JpcHRpb24gaXMgdGhlDQo+IHNlcXVlbmNlIHRoYXQgd2lsbCBiZSBleGVjdXRlZA0KPiAtIHZp
b21tdV9hbGxvYyBkb25lIG9uIHdoaWNoIHRyYXAgZXZlbnQ/DQo+IC0gaHdfcXVldWVfYWxsb2Mg
b24gd2hpY2ggdHJhcCBldmVudD8NCj4gLSBtbWFwIG9uIGd1ZXN0IFZJTlQgZW5hYmxlDQo+ID4g
dklPTU1VIGFsbG9jYXRpb24uIEhvd2V2ZXIsIHRoZSBsb2dpY2FsLXRvLXBoeXNpY2FsIGFzc29j
aWF0aW9uIGJldHdlZW4NCj4gPiBWQ01EUXMgYW5kIGEgVklOVEYgaXMgb25seSBlc3RhYmxpc2hl
ZCBhZnRlciBIV19RVUVVRSBhbGxvY2F0aW9uLiBQcmlvcg0KPiA+IHRvIHRoYXQsIHRoZSBtYXBw
ZWQgUGFnZTAgZG9lcyBub3QgYmFjayBhbnkgcmVhbCBWQ01EUSBzdGF0ZS4NCg0KT2suIFdpbGwg
Y2FwdHVyZSB0aGUgc2VxdWVuY2Ugb2Ygb3BlcmF0aW9ucyBhbmQgdGhlIHN1cnJvdW5kaW5nIGJl
aGF2aW91cg0KaW4gdGhlIHNhbWUgdG9wIG9mIGZpbGUgY29tbWVudCBpbiBody9hcm0vdGVncmEy
NDEtY21kcXYuYy4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQo=

