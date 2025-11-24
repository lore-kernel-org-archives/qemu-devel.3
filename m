Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93754CFD348
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 19:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNbpQ-0000rx-Sa; Mon, 24 Nov 2025 14:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vNbpO-0000ge-RN; Mon, 24 Nov 2025 14:02:22 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vNbpN-0004nN-08; Mon, 24 Nov 2025 14:02:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO2hx8yd+LJrWIDp4U/BR9HcO0j7IL7cazlkPlrJ7Z5No1ozt42kKurkWS5nByusLsksHVILqB+hFQGkJRBrzGmgzdlrWjnMCJ0WFIPtLajJTOJr56KF9/P224hPV04rW87ZGdQKZFn96gZXJmMN5Ouvb3Hs8l8ldJ09Q715GQbuwy6tJ5NxVA18fSzi9Fm4iESwGMzzpRPShoOixcUM5hFeYflBHjrb4uj2YFR5UeWe5JLmulaQ2aMZxoSuoW648DjA+AzAv2SRb0rVSSgd50TYUApqiUz3R5/ishEgi/Q8RO6UtmrxlTmfC52RE1IWegdndkgg0ZTvnS4xqtqB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hobO6laaOR0M8EnNG6Dp1BMIulrqNpZiJOLykZWY9bo=;
 b=G/k5Hn7+LXU2yErCrnLL2/TeK/OTYMbqYczwQtEEWGQzSh/tCADdVhHh5Qfm3r8weDQzov8o6FP+pCFD3QGRPyVaxuIe0NgJB0I4EZPf7Yx5/4iOFbB14H5+SF1QkXRg+o9rvuIbwTqs1SgTGHa6lTGs8O5r+2clc0C8vad9mKBVbe1vfwUXsGOzzQZOt5cS9AoXgn7KLsmf2IVRRt2x22SLtT03ONuAe0OtDVWNTtfJFQel2tAav+5bRWq2AEjWHJ7mgIrBPl/ZjEQq8tnKzX5M42Jdohhxvvup+xcBpPgi6VIzaPt8m1RZtpxhOIDAVHfVepS6BPPsPBhYyR/Ttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hobO6laaOR0M8EnNG6Dp1BMIulrqNpZiJOLykZWY9bo=;
 b=pqk/YLmCSXtJv8dw0lmzolYme7AZCDWEvtCKx4vJWyVGK6z9wII65sX2G+K20fA6m1WlYuRUPawhGRrlF3ao35rHzrxtIHOjzdXWtMraWQ4u/M06NtAFws+c287S5AtufJILHDepAGVYH7ik21i1NckvT0ybBSnhWu/Mf/oVcTr9/hhtiDFEm5BxpRvha6Dtd3x0m2arSuq00KJfg7ElMEZiw1okBjVD8L72IdHGdGrkY9p5VU70d5pod+TrxqHhoo975mH4t29TazrdDAhM4y4eNFMfbQeYRWrcJNZ1NSKTr29zLQLxtGccYvTM93qdENvsxzeFSYtV+fmUhVlWOg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PPF316EEACD8.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 19:01:58 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 19:01:58 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Thread-Topic: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Thread-Index: AQHcWiEf+PaTPr3V30uUQF2zh8a+rrT8ExiAgADSd6CAAIZ+AIAEERrggACwdACAAAMO8A==
Date: Mon, 24 Nov 2025 19:01:57 +0000
Message-ID: <CH3PR12MB754878079B614319CC6FB9C0ABD0A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-18-skolothumtho@nvidia.com>
 <aR+Ga0DrveuOd3v7@Asurada-Nvidia>
 <CH3PR12MB754869BFD4D1B5C65EE30AB8ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aSCnyrcIe7kqIncW@Asurada-Nvidia>
 <CH3PR12MB7548BCF00E128545097E3DE4ABD0A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aSSlJukXV0C48pFX@Asurada-Nvidia>
In-Reply-To: <aSSlJukXV0C48pFX@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA0PPF316EEACD8:EE_
x-ms-office365-filtering-correlation-id: 216f2b5c-7805-4750-bed0-08de2b8bf124
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?S1IELSKEkX/Sdx7YI8AagTgE8289j/70/HsCoGRqMPuNuLrzAWrKj3PiWT8o?=
 =?us-ascii?Q?QWzjsVoUFREtsgQHV0O7Ggx1uD0uH4Dr7u4wibFQTdsTj9ulxfNZSYs1Exg9?=
 =?us-ascii?Q?cTdLjRrg5wwf94Vt9XIaQkT+xHlmTp36gl04i05ta/Z5ELgWm30juKuO1Ghc?=
 =?us-ascii?Q?/82p4Z5Bus9Pag2gSv6XDOUPOT74XTSJK7tP/LBpU55PdwgrfkgIelzXbjLO?=
 =?us-ascii?Q?tFtWXfO3d2VQ82WLjwYe+YLagDe7o19o9TP8lR8LiY0+42yGRRq01BI73xgq?=
 =?us-ascii?Q?OVNedae74YAdZBRDE+d0TmGLxWA1qNRXG7Yod6GsUmOQiq0YTKYhN5xcPuzk?=
 =?us-ascii?Q?TTugZEMIOdhyswUDpAK9WevYPqrS5OgN1qLRTI/ktTfK6PA69Iqg/IlNwQ7D?=
 =?us-ascii?Q?t2asbza1ShnRbLKE6tJEjr5DSNJVFXNoXBEgDQYxdAXA4fnppLY51gUuQTm5?=
 =?us-ascii?Q?r0rvAnZKLZ+CTSYvxMh4hwW70Pkzsaew9bZvps6NwjGMNoM742cYL0RjzZ+Q?=
 =?us-ascii?Q?TwzeN0fO5HR9GFv2QS95Y/wO7U8KwJTsAKCJZv6z29Otcw2SwJ8zZY2MU0mh?=
 =?us-ascii?Q?yRQoNPRIvei1t2n3RB3bDVy7Fy/wlaMxC9WvoRhrP2WtYxpJketnAs5gRgRK?=
 =?us-ascii?Q?m2Y5Db7BVN/y4FBof6VkVdxnZ4RtJBtNJsC4Vs0Y26/2tg5wFZWJ6MlgvlxK?=
 =?us-ascii?Q?XSCGGZZF7ZYkSIsQLKcynzh7IQLZaIMXaOkNW2AU9Nkywo8rQ8z6svT7tcG+?=
 =?us-ascii?Q?l4xLhAWpoWUfKG/XX2PoFFMSGyM66bThOTDuT4kHpMiU4Te61p6CsHAUdTTf?=
 =?us-ascii?Q?1rB/g7iGiWKcShtna4JL/fiN4psqwv8Q9By2myd03vtvuxIx5qayO40Nx20A?=
 =?us-ascii?Q?0f6g8rxiYCV6Id8chGdGypRYDtqw1hDjVErj/PVt/ENSTkVNS860fBoupqJs?=
 =?us-ascii?Q?IbPtSaboSijp1PJFiw1I3qRp1qpolqURHCBMjUzxKJaH2yxehAJW0/BIdWhy?=
 =?us-ascii?Q?Ix7Y2saNOPyEE8CXGwVev/yqwbAN2gBI/zCrB3h/XKJKMKaS5++U2cEfA1e+?=
 =?us-ascii?Q?7AwYxD864Pr2bb/qUbi7gF9qd88fQzM7G790AtvKC2abR6q5QP8q2VXOXeYY?=
 =?us-ascii?Q?E/8QmzXBFJqVXtZl9X2Vtk3O+U+zSHp6h3ybYUxHCSeUe5/nt1cxX/7b7UW1?=
 =?us-ascii?Q?9QWR01JkT5+EatqcD31QwuEf4LyE+ceMh6z2hKn1laXZPbooysAnxB/WVxaZ?=
 =?us-ascii?Q?2RlEOqmUWwSKIBosRc2+QWmfcgFouUGQckQ/4cntCmDvJj9YfvX5CFFkyE34?=
 =?us-ascii?Q?bDHU1/iQmQAS+LV797YRVmYGjgxnUJdY44S3jw6jHMqI1kvDieyMqp+Qzm8V?=
 =?us-ascii?Q?BuYTrNbxRCDhnR1T11G/OoepGktUSfXW1O6I6872SGnPq9J2YMbgJkHqiw0W?=
 =?us-ascii?Q?Y1cEwDIbVZc2+3rBeRRpo8n4rQ5CvKj/Dtvk6tDjKI3ExB2Kg/ZJLyDGsh7e?=
 =?us-ascii?Q?n7f6BwRNz5qqJ6gQpboZDM90IOcrIQ6wtRSC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a/WnpYI1b/IWNYa6YKPqJgfrKcuoK7rrtPLsYDsVOHNccQtOH0AVOJllkmwe?=
 =?us-ascii?Q?GaNpiYhAD7bbsVn9YcaVoFHUCHcBF1TmfZcZeu1pA5qLTc5ogQf/+JhQgs26?=
 =?us-ascii?Q?VMxpvRIeM1eN/oUjA7a3xhQDNuR0ZNN3uK/VVjPB4WEX1Sq/LIFWZ3lbBvBB?=
 =?us-ascii?Q?5eN6Po3uwHXFajnu8DVMw+//p2yYNixQtynq9nU8PK3cebe7SecOa3Ud53Gr?=
 =?us-ascii?Q?XRCE916VxkBwJkqyl+87weJF0e4WqTG9x/UsvD0YsvgXCQ2al0/HlsXSdRCz?=
 =?us-ascii?Q?Yo9Q0TBWK4BC+DzA9pvPWg1p/73HcyICK3J2uQVgdJVAEdvXMHa/HPJNdgzz?=
 =?us-ascii?Q?sl0mGDcMo+6hPC6Ii/C6xAjv42kuxwhFNSFV9tOfuWboqy6yMsKhOHW6vCkR?=
 =?us-ascii?Q?id9nfvCBmnZa66XmUO3NfVNcGYuxcQHpJmKJz6qUvH3CC7bKRa057USRw0+L?=
 =?us-ascii?Q?zz2Ya6Hv8gaE8FfhuOiQND75aVzzeWXH59Q856oK6yRYQt/z3eholDWj3twF?=
 =?us-ascii?Q?LZWEEOX5WFCkzHjdjHZMGV9r73eC2+sQCfVLLqHDToTO+owm8MlTLWsbLvGN?=
 =?us-ascii?Q?G9+OAcSeLi0aZ8KTQubk0xzx7PgQ86QWnAZjewSQkYw9QxiEhcwriaIHM3MH?=
 =?us-ascii?Q?fju4g/RuKtGGyXpDJb/BJJEkFEuJuBqyQYMha3pr/2Ahg05TBLu+HDgkdn3t?=
 =?us-ascii?Q?dkgPz1Bfepq1CcvVZI90aSmb/iqatHc7CnCXKydJtn8R4Piex5Ml8VfYhDMo?=
 =?us-ascii?Q?73ZcAE2YUAuce9iaN0fDlT9mgGAvpt4/DdW3Mk5yNrtNhgAoKrlr0jOllyus?=
 =?us-ascii?Q?FNGvb2NOv44JX3k89HtB1molzGQdq5ctRMiAGfDjE7Yx05S9lJ/EIIDRGAvo?=
 =?us-ascii?Q?zpGhYsc3ZeYRFWdjWRagtPfQGpmN422P0P2a3Ds7tPpWiM2SdLUWcj8mcnZs?=
 =?us-ascii?Q?1p/KTYghK3o5VAJXbRvaYFDigh5cNaStaHTcGrihBN6wBQUmxUJSywSBdCdV?=
 =?us-ascii?Q?+qpRiSNNStnHbALqs89VKjdwkh7CqFn70U+hZd6Jy0+mqbyhj08gUMHVKdPQ?=
 =?us-ascii?Q?hzr4t3dwk7S5SfQPqekyvbQywmclXIXZx8EodP+rDwg0U/CpD39xfzJBwjpR?=
 =?us-ascii?Q?D+3vqIhPDsvhf6TH+JSTPD3pSPpDIXQCglMqjnqfwhHZgWMbKXcgVWcG/PCf?=
 =?us-ascii?Q?S1RuZv/KJVTrTmy/wndpaCwWsWKX3wys4E8dfFCUncG98XxiyVSGtx/V7Xwb?=
 =?us-ascii?Q?MFbWp+3dAzX+F4UOMZ9iOLkV/AjnH/sIuWZpYsJs50X66iMjBHF3LvSLy7pM?=
 =?us-ascii?Q?B2fl7HWbCInV9QLFiBW4nEgTkVkHrnfiQGWpip9P3VHSCeFrNqxOsCjsDQeG?=
 =?us-ascii?Q?o0oXQVEfhBjZZp3V9NevYxspq9AqUp1maDlU4/4NFunHsFgO1+n3KBqUjCBv?=
 =?us-ascii?Q?cvVe9j0QM5gJmkleGEDZBCyHQ7E5sC36DntQG4uCZnZu5pikVPg1Jsx5tlP7?=
 =?us-ascii?Q?tdkAye3ZP3fKIookjfpPxAPYJv6+ou3ObCWR+OGWV4za9xADxY4BImxxjzmM?=
 =?us-ascii?Q?UuHlgQZtcFfZEvBz2sPzTTKOVTBwWh0bi8wk3u20?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216f2b5c-7805-4750-bed0-08de2b8bf124
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 19:01:57.8767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKnj/R5MoCpynYnAAPYDW0fbzhudJv+vyuHIn8TZ4TfpWKAOTcXRGJgfLefFTcEzvl2FiAfsb8RGOh9DwSrbcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 24 November 2025 18:34
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
> direct MSI doorbell GPA
>=20
> On Mon, Nov 24, 2025 at 12:05:38AM -0800, Shameer Kolothum wrote:
> > > > > > +        if (object_property_find(OBJECT(dev), "accel") &&
> > > > > > +            object_property_get_bool(OBJECT(dev), "accel",
> &error_abort)) {
> > > > >
> > > > > Do we need object_property_find()? A later patch seems to drop it=
.
> > > > > Perhaps we shouldn't add it in the first place?
> > > >
> > > > We need that at this stage as we haven't added the "accel" property=
 yet
> > > > and that will cause "make check" tests to fail without that.
> > > >
> > > > We remove it once we introduce "accel" property later.
> > >
> > > Hmm, I assume object_property_get_bool() would return false when
> > > "accel" is not available yet? No?
> >
> > It is the errp that will be set if there is no "accel" is available tha=
t will fail the
> > tests. Another way to avoid object_property_find() is to pass NULL for =
errp
> in
> > object_property_get_bool(), but I think again when we introduce "accel"=
 we
> have
> > change that into either errp/error_abort here.
> >
> > I am not sure there is any other way to handle this.
>=20
> This path is to set MSI GPA, which could be optional, right? So,
> we don't really need to exit when accel is not found or accel is
> set to "n".
>=20
> In that case, could we just use NULL even when "accel" is added?
> Why do we use error_abort or errp?

I cant recollect why I used error_abort here in the first place. May be
since we used that for the "primary-bus" above. But as you said,
we could argue "accel" is optional property. However, if we pass NULL
and then for some other reason it fails(even if accel=3Don),
we will end up ignoring the error completely and silently boot without
"accel" ?

The  object_property_get_bool(..., &error_abort) is used in
virt-acpi-build.c as well.

Still not sure "NULL" is a good idea or not.

Thanks,
Shameer

