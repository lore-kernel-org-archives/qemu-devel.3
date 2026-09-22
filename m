Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BB7C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8sey-0001YA-DK; Tue, 22 Sep 2026 01:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x8seu-0001Xx-DG
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 01:03:12 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x8ses-0002Z1-0s
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 01:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1790053390; x=1821589390;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ThB9TQ2jnQW9lj4KVhn+scuIjn+GGrMMXFiQr7G0ngQ=;
 b=NHH8BJRyllvrhWJteizCtKXEmMA21mqeoClMfpDY0Sa2EJmInL1BqcfN
 d+77eiAy8UCgyZa9Q6EnHSuLlAEksfag/ZvNrRJWEWICQbpczZpjIJU2J
 R5B0kgha3HrW8WhFDBdw5sWo7IJRYLG+fFVZ6ADERMCGzNqHLkpJgVzH4
 bi/tgw1ngtY0rwWfjETF4uq0JXgFUKNghsCo/WqpyuafYCCHdE0j6dfA5
 Rh0V8x0giMi2jsbFJL8w5S4oCufSM6cjOkq1+n2aijYEggQju7AtCMeL4
 u7UxTAdkWFyJP7m0uo7K4KmI13mvz6LSn90B34R2L8v4jaYV4WS7KyAEp Q==;
X-CSE-ConnectionGUID: Bc4piHHURn6a/gUPEJiCrA==
X-CSE-MsgGUID: EHrilueoTL+1rD0Jp+JrEw==
IronPort-SDR: 6ab20c09_0xEpFqXaMo5UXBEJARmPLpI0M5leb6borcGHV/8lRRJiw/6
 HSUF++EzHvvsYI/GvRfi74Rzjp8xMORb51G4jYg==
X-IronPort-AV: E=Sophos;i="6.27,115,1787004000"; d="scan'208";a="50913495"
X-MGA-submission: =?us-ascii?q?MDHouPCkcqwDiZEmc1fMFcTvcMhLR+CRnC+z54?=
 =?us-ascii?q?4VxRkIRnLuaZysYnWjpg7SQuHRH0tRZ9kVVrNOBz01Mbh7m5NuFuTsGt?=
 =?us-ascii?q?rhX6w1yPl32OuOdFcyEvYm+hm6sZqpaWGAWC18YjAThdcpMarUyc62Wy?=
 =?us-ascii?q?SWc1POvjL429vzfHnnPRT2aA=3D=3D?=
Received: from mail-northeuropeazon11010063.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.63])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 22 Sep 2026 07:03:05 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmTyJxQmSnxDNMMpBi6jSXEx6EfIetDYLKRCCw0amn0Atw8dADuwpT3vgqjHjPGBSZqU0lyZdi/3Ai9b3SdQLsK8gyEQf74eiZohpk4mQB30fNbj9BjVC4Xh7jW4Tjbs8kTRNMsrLV1nQ+fP1+5WvHV3R3MV1xWjMC8wHQtXP4AW85YyqWioQo71zDZjXl841qLBnAJi97aiEyew0jPRuugdpBevm43Y32imPPkyL8okXLaF8pptsYGR//J2E80IYVJ9Zv7dcusD+dAINUIUvP06rHzsSWXr5mX5jVe/usRksFMGzLNyDkY1uW7LB3zuv29qTpTfvToYOsr91ge/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThB9TQ2jnQW9lj4KVhn+scuIjn+GGrMMXFiQr7G0ngQ=;
 b=nP2cxBAOKmyJDriTtkIGEBfRU9UsdtDuMgpQz3/C5MxJ7u7hxADVJa1jRjiGqwwoqoJ9K8ev+uTujDx4GToa/y852NGJaBD81NVjcs2/yYkYsGLlnfOmsO7XP/yvuYdDLm+ZOcJDDgWD1SEDIgQYw5Mnko0V9qxif1U2ugjKlOcDIASHbN4BKajJa9wiTy2f7dT/ceGJ2+FG0LMd8uY1I/1ar31P5l0GXEA+0eQwsgCHHgvTuesT5+JiQuoPZBPR4Yrcnza+H0hw6chQ2Xq79CuJjbYsJFfqTDFWLxqyowUgNkaPQ1q6mGOpkGks08/Kjxv9gapuIJal+BF3ec28kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AMCPR07MB997868.eurprd07.prod.outlook.com (2603:10a6:20b:77d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 05:03:03 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 05:03:03 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: Re: [PATCH v7 6/6] intel_iommu_accel: teardown FAULTQ resources in
 bottom half
Thread-Topic: [PATCH v7 6/6] intel_iommu_accel: teardown FAULTQ resources in
 bottom half
Thread-Index: AQHdRcLu3SSC7ASZok6f9eLE7VV49bbYn9wAgAAsfoCAAUdpAA==
Date: Tue, 22 Sep 2026 05:03:03 +0000
Message-ID: <eafa9bea8cbdac46b1cb8c356b0067279aae324e.camel@bull.com>
References: <20260916100442.1034043-1-zhenzhong.duan@intel.com>
 <20260916100442.1034043-7-zhenzhong.duan@intel.com>
 <287990529392c887cb53369260b08b728694a9bd.camel@bull.com>
 <IA3PR11MB91366BBC0FA349F3351BAC6492842@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB91366BBC0FA349F3351BAC6492842@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AMCPR07MB997868:EE_
x-ms-office365-filtering-correlation-id: 79aa7b48-da22-45d4-fb10-08df1866c811
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: NmxLZgxI4QLCFDpwrinuKicl2G4QZR0jHCOYckPan7C9RgGX9AzEjbgCE2JZJKj5YFiboUy7/gDz5eT8079BzdNhfQjDqxbIfwM6v3T0V7HZD3v5OaW7fQ9emzYwYDq2OoCCRnfUdqrkisOGRCEvlNPbM4EWcRsO+nFNYknaaNOpKTQUcAusISm4IDUJ6bP7QrAQLgwYDUYqpiTEESHzFbqMRQ8NWXlUYJ8w7eXUgI99N3LSq5x8V7H5+Y30KeKU2GRUeI1lnHdiiSZ0A0RV0XOAI2Mzva976FbDn5DsfDvaWAUQp7w3IO2l2ftzmdoItK3Xn8nMNHlJvcqGnQiWO2t97y1/zAgGK4Zt8OwdIlJni8mha4Z0gHFRrIBoquWu2LwRAeTfnZOYy42IWEScH8hfsV3tSF9XC2iUQu+EmPx8lQe4/YQXY9cCNJjGnUZC9NmnvdbfKMEN2il6ATWw0yutbfB0WjDpWaYkPThUNoV2Th/OqXdvpc6t+nDFlLKwPjeZnZR3dZiWulDuD36P5AtAIlgwGQ92qw1zLAKuFPnMyzhJ11DR9U3PWGTwm6yesvNN8jDLi4FBNdrrBPyULW8WD7ehKyZIU0hXusTyWCDERMYz6guYvX0hOAc7dn5/kqE6Rc3m3IrNZ819/uwHNy4ROYg/CwP4XYZ8M2wq0pITt/NNDg6/1LtMh7DHsjbZXcmzydcFZQqYp7dbdj5KMy1FG07bBk02UPDrVXhlZhQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djNHdW1Sc2pwQjF5dU9pTmtsT0xZSnI3bzNrNlQ5Ukt6ZjR5bnJ4Zm9JajY4?=
 =?utf-8?B?azZsTVl5ZEYxU2R5S0IwWXVlTlVPc09JRkl0QkVnUlFJVUN3NUJ2dnY1eFhP?=
 =?utf-8?B?b1pjZHlJT25VL0JwVlhYMGJMeUdtbXlwVTd5UjhkNVJ4R1VsRzNSOFhiaWVI?=
 =?utf-8?B?aXRZK29meHVtd1pKMkdmaHkySzhxN1lVZjU0MFNySFFNaFByenhJM3RDQTFQ?=
 =?utf-8?B?d1phYVpQL1hSbEJwY2oyYTFnZzRNdFhIOE5oaVFFaGJwUGdEOTdBa051QXBG?=
 =?utf-8?B?dnh4ZldBY0hULzVhMFBwT2ZTeGxBcDFLWWV2SkZicXJWa1FrVU9FSFllSmtX?=
 =?utf-8?B?ZDM0R0FoZXQxTUVhSUFlM1ZVck50SDBPL1RucnpNOXE4NldDL2NlU0dzdG1h?=
 =?utf-8?B?MEQ0THZGMER3NXpZWmFvTjhuNlRZZFZRcTRUMC9hb2FSbGtMSUtjRUw2ZTQ0?=
 =?utf-8?B?aGxrc0VXMHJESDlvdkdKd3dSbEhKZG9LT2xoTzZ4Q2NPSmttTUkxb0xxVmNv?=
 =?utf-8?B?QTVTQm1QNm13QTR2cmg1OFdVeUxIYXIzS044RmgrZU85YTFGaDhON1hMVWZ4?=
 =?utf-8?B?eTZkbVlVQSt2OWJ2aEwzZWJrVFl4NzBJTWVSRDBGRy9FTUk2cEJ4aGNLZm15?=
 =?utf-8?B?MlYxeXFtUkZ3ZllEZncrRlJzcmZ1anE1STc3SHMyUVZITVRLSkV4dlNGeThk?=
 =?utf-8?B?MWU5L3kzUWh5UGg5d0QyRzVPOTlOczFMWUtJcnlwY29RM21UVGIrY3FvOU9j?=
 =?utf-8?B?RlBhYUMvbnJUdmVrbVlYbEwwY1Q0TVZaUFlHdkxJRGtsSU9HcmxYOVBCekZP?=
 =?utf-8?B?RVlkTmxEQkdBSHZ5Y1ArYjM0UVM4OHlmWFlvT2EvWFAwRXNKVTB1M2tEektr?=
 =?utf-8?B?S01xSE8xWGpWMkNmVEk4QzdPRWpCQTIzRlVKUVluUG5YVENxY1hrTGVXdk5V?=
 =?utf-8?B?c3hrWXBFN1V2TlJzZmcxOHpvcWczVXZCMnZ6YVVLellYWXFqZTFqeWlrUXVs?=
 =?utf-8?B?a1JjK3R1eTVBM2xRb2gxQ1dhczRlMURzSkxTYmNtRi9TdzFRbldJOTBEbEcx?=
 =?utf-8?B?ZUhVcklTQityaTYrcTNWc2VPRFg2L00yRlVNTHhOUS9sdnhTdFZjREtPYnZ3?=
 =?utf-8?B?eDJhZXFaNUxiYm01V2V0cVMzYVNBVitYY2FET2FmT3hSaTMzQ21DK2ZYWGcz?=
 =?utf-8?B?K2hFZTNhR2VyTDFLL2ZycFZ6bElISUFZQllqNzhtbnh0cUdaRHVpVEVTcFlp?=
 =?utf-8?B?RlhKcEtFUXZFZGxHVnpCemcrTDRPQW90MTBwUTdrNEI1Rmk2a283ai8yQUpp?=
 =?utf-8?B?Yjk2dTcrL1kvZURNaVFGSTg5U244a0oyY0NSRkljdVZ2NXJsSWswMERVME0r?=
 =?utf-8?B?bGVmYkc3L2pwSit3VGxiOVBaSC9KSVhtajE5Z1hRQUtKV3pCNXVGV0tlaVl3?=
 =?utf-8?B?dXhvSHZkVWFLa2JQSkJkZWVrdWRIRFhtSzJSbkR2QjBubDVJcFZlZ1J5d05x?=
 =?utf-8?B?Rk5EeThMMHJVbGVvV0JoYWNYM2NxaTFsQWFPQm0xYS9KRGl6cDNqUEZ2RW5N?=
 =?utf-8?B?d2hjbDdSZWMvaC84azFxL0xRdFZ2c0pOd3pBQXAzNkRRbm1CNHZ3bHEyUlQw?=
 =?utf-8?B?SEU0YVFGbzZZZ2Z0cEdsRGZ1NTFac25kUUNwZm92RGpyUEtxNDVhVUt3RGtR?=
 =?utf-8?B?cnpxd2h3Vml0ZUJoeEs2bjV5eFJ4blVra01SdTAwVWZ3cDA4UTRJQ3BsWitG?=
 =?utf-8?B?ZUE4MnhCL0Q4cndBUXUrL3JkSE5OcUMzYzJKWXAvWGdEdWdsNndzeE5KRU52?=
 =?utf-8?B?dkRGVXhENGt4N242ZExxaUwxWXZjNW56cm1HV0xCMGtqbkN4QjZVc1diWk8v?=
 =?utf-8?B?cG91Y2xJTTdyRGFKbVlFQUM1OC9uNmdDd2p0WHBWclR0NXI2SHZaUHhRaHdZ?=
 =?utf-8?B?VFl3bUd6QlRYQjVjYUxZaUl5K25PNklLbHpBTC82Mm5DQWcwQ3FRN2NiSnBO?=
 =?utf-8?B?R0VtTWdmNGd1SlBmTDc3NmtkandEU0hXcUNKU3E0L1ZpUzlCUWlGYlgzMkhM?=
 =?utf-8?B?UG15VDhnMWl0M1I5RXZFUU1jTW8rU3Nha0pUdzk4RXQxVlFUeW0zcHdWSlFv?=
 =?utf-8?B?Y0pOanNoNXRmWThQQzNoSllHRW9IbG5UOTc5bHY4d2hSVitLQi9xbDIrK0pX?=
 =?utf-8?B?T1EzbWVON1JUb1RqTTFhc3lwMGIvSXRPVlJoaUJCaDAwbnRzdVVoV0RvWFpj?=
 =?utf-8?B?bGpESm1qajVIZTVqS1BpN3RUb29RellaZndZWUY3SlQ4QmVQZGp0Ujd5R0lu?=
 =?utf-8?B?VHpuNU00Yi9KOWpwM0tGM3VyRVFSVG1rMFJ6TGgvSWN3QXF2V0JpL2JEeGEw?=
 =?utf-8?Q?7m6ZkFFV53nRiri0S+Y/gD1QLMXSlzH7cpvoF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81E6B0DB22C9694A89A942A3438DB356@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B83E609xBwMDpttpVCtiKEhPGUJ5NOHC63bucsWGkgNTOh2mn/POf3ASXqj0Q4FcOf2ULUOCeORKEyHZOtaYCScIJcEsQScQY0/s8fdN3xVb8VRhEK4g5wr8Ksfd78c90L7XnA0AH22a1/xNBnZwhssXc4g2hl/XyyRTHM0OI98HH8BmNkCgGTt2ocsZUy75Z4/uck1aS8owYkuPY3lKdZeN0FrNbbZFLvVqlw6Lbx8K/w9DdV1xZc2cL00FC+vAkVKEvdMLyNY3wMJhQK0B6sQPlhc5YySZhcP9/LG0xCtusP7M8f76LSdnuDJttsPALnRIFKQLqVma0jA7MqaMAA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79aa7b48-da22-45d4-fb10-08df1866c811
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 05:03:03.1260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/uoDFVU9GAKVrm3o0H75b4VlEGMJKXuA1yqXw/ArQFYVKFMeet9XGTsIzNiJHwrEEHoVsJ5Vs38e8kotzRy24oqUuZmJfWU+hdg31ctpHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR07MB997868
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost4.eviden.com
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

DQpPbiBNb24sIDIwMjYtMDktMjEgYXQgMDk6MzEgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90
ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9y
IGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVy
IGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IEhpIENsZW1lbnQs
DQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IENsw6lt
ZW50IE1BVEhJRVUtLURSSUYgPFtjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb21dKG1haWx0
bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjcgNi82XSBpbnRlbF9pb21tdV9hY2NlbDogdGVhcmRvd24gRkFVTFRRIHJlc291cmNlcyBp
bg0KPiA+IGJvdHRvbSBoYWxmDQo+ID4gDQo+ID4gDQo+ID4gT24gV2VkLCAyMDI2LTA5LTE2IGF0
IDE4OjA0ICswODAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4gPiANCj4gPiA+IENhdXRpb246
IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywg
dW5sZXNzIHRoaXMgZW1haWwNCj4gPiANCj4gPiBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFu
ZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4g
PiA+IFdoZW4gYSBwYXNpZCBlbnRyeSBiZWNvbWVzIGludmFsaWQsIHdlIG5lZWQgdG8gcmVsZWFz
ZSBhbGwgcmVzb3VyY2VzDQo+ID4gPiBhbGxvY2F0ZWQgZm9yIHRoYXQgZW50cnkgaW5jbHVkaW5n
IEZBVUxUUSBvYmplY3QgYW5kIGZhdWx0X2ZkLg0KPiA+ID4gDQo+ID4gPiBXZSBjYWxsIHFlbXVf
c2V0X2ZkX2hhbmRsZXIoKSB0byBkZXRhY2ggZmF1bHRfZmQncyBpb19yZWFkIGhhbmRsZXIgYW5k
DQo+ID4gPiB3YWtlcyB1cCBtYWluIHRocmVhZCBmcm9tIHBvbGwoKSwgYnV0IHRoZXJlIGNvdWxk
IHN0aWxsIGJlIGEgc21hbGwNCj4gPiA+IHdpbmRvdyB3ZSBjYWxsIGlvbW11ZmRfYmFja2VuZF9m
cmVlX2lkKGZhdWx0X2lkKSBiZWZvcmUgcG9sbCgpIGV4aXQNCj4gPiA+IGFuZCByZWxlYXNlIGZh
dWx0X2lkIGZpbGUgcmVmZXJlbmNlLiBJbiB0aGlzIHJhcmUgY2FzZSwgRkFVTFRRIG9iamVjdA0K
PiA+ID4gZnJlZSByZXR1cm4gLUVCVVNZIGJlY2F1c2Ugb3BlbmVkIGZhdWx0X2lkIGZpbGUga2Vl
cHMgcmVmZXJlbmNlIG9mDQo+ID4gPiBGQVVMVFEgb2JqZWN0Lg0KPiA+ID4gDQo+ID4gPiBUZWFy
ZG93biBGQVVMVFEgcmVzb3VyY2VzIGluIGJvdHRvbSBoYWxmIHRvIGVuc3VyZSBwb2xsKCkgaGFz
IHJlbGVhc2VkDQo+ID4gPiBmYXVsdF9pZCBmaWxlIHJlZmVyZW5jZS4NCj4gPiA+IA0KPiA+ID4g
U3VnZ2VzdGVkLWJ5OiBTaGFtZWVyIEtvbG90aHVtDQo+ID4gDQo+ID4gPFtbc2tvbG90aHVtdGhv
QG52aWRpYS5jb21dKG1haWx0bzpza29sb3RodW10aG9AbnZpZGlhLmNvbSldKG1haWx0bzpbc2tv
bG90aHVtdGhvQG52aWRpYS5jb21dKG1haWx0bzpza29sb3RodW10aG9AbnZpZGlhLmNvbSkpPg0K
PiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4NCj4gPiANCj4gPiA8W1t6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb21dKG1haWx0bzp6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20p
XShtYWlsdG86W3poZW56aG9uZy5kdWFuQGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFu
QGludGVsLmNvbSkpPg0KPiA+IA0KPiA+ID4gVGVzdGVkLWJ5OiBYdWRvbmcgSGFvDQo+ID4gDQo+
ID4gPFtbeHVkb25nLmhhb0BpbnRlbC5jb21dKG1haWx0bzp4dWRvbmcuaGFvQGludGVsLmNvbSld
KG1haWx0bzpbeHVkb25nLmhhb0BpbnRlbC5jb21dKG1haWx0bzp4dWRvbmcuaGFvQGludGVsLmNv
bSkpPg0KPiA+IA0KPiA+ID4gLS0tDQo+ID4gPiDCoGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwu
YyB8IDQwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+IA0KPiA+IC0N
Cj4gPiANCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2Fj
Y2VsLmMgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4gPiA+IGluZGV4IGNkMjI3MzE1
ZGEuLmMzZjNjNzQ0ODIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2Fj
Y2VsLmMNCj4gPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPiA+ID4gQEAg
LTI2OCwxNyArMjY4LDUxIEBAIGZyZWVfZmF1bHRxOg0KPiA+ID4gwqDCoMKgwqAgcmV0dXJuIGZh
bHNlOw0KPiA+ID4gwqB9DQo+ID4gPiANCj4gPiA+ICt0eXBlZGVmIHN0cnVjdCBJT01NVUZhdWx0
UXVldWUgew0KPiA+ID4gK8KgwqDCoCBJT01NVUZEQmFja2VuZCAqaW9tbXVmZDsNCj4gPiA+ICvC
oMKgwqAgdWludDMyX3QgaWQ7DQo+ID4gPiArwqDCoMKgIGludCBmZDsNCj4gPiA+ICvCoMKgwqAg
UUxJU1RfSEVBRCgsIFZURFBSUUVudHJ5KSB2dGRfcHJxX2xpc3Q7DQo+ID4gPiArfSBJT01NVUZh
dWx0UXVldWU7DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIHZvaWQgZmF1bHRxX3RlYXJkb3duX2Jo
KHZvaWQgKm9wYXF1ZSkNCj4gPiA+ICt7DQo+ID4gPiArwqDCoMKgIElPTU1VRmF1bHRRdWV1ZSAq
ZnEgPSBvcGFxdWU7DQo+ID4gPiArwqDCoMKgIFZURFBSUUVudHJ5ICpwcnFlLCAqbmV4dDsNCj4g
PiA+ICsNCj4gPiA+ICvCoMKgwqAgUUxJU1RfRk9SRUFDSF9TQUZFKHBycWUsICZmcS0+dnRkX3By
cV9saXN0LCBuZXh0LCBuZXh0KSB7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgUUxJU1RfUkVNT1ZF
KHBycWUsIG5leHQpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgIGdfZnJlZShwcnFlKTsNCj4gPiA+
ICvCoMKgwqAgfQ0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoCBxZW11X3NldF9mZF9oYW5kbGVyKGZx
LT5mZCwgTlVMTCwgTlVMTCwgTlVMTCk7DQo+ID4gPiArwqDCoMKgIGNsb3NlKGZxLT5mZCk7DQo+
ID4gPiArwqDCoMKgIGlvbW11ZmRfYmFja2VuZF9mcmVlX2lkKGZxLT5pb21tdWZkLCBmcS0+aWQp
Ow0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoCBnX2ZyZWUoZnEpOw0KPiA+ID4gK30NCj4gPiA+ICsN
Cj4gPiA+IMKgc3RhdGljIHZvaWQgdnRkX2Rlc3Ryb3lfb2xkX2ZzX2ZhdWx0cShWVERBY2NlbFBB
U0lEQ2FjaGVFbnRyeSAqdnRkX3BjZSkNCj4gPiA+IMKgew0KPiA+ID4gK8KgwqDCoCBIb3N0SU9N
TVVEZXZpY2VJT01NVUZEICppZGV2ID0NCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCBIT1NUX0lPTU1V
X0RFVklDRV9JT01NVUZEKHZ0ZF9wY2UtPnZ0ZF9oaW9kLT5oaW9kKTsNCj4gPiA+ICvCoMKgwqAg
SU9NTVVGYXVsdFF1ZXVlICpmcTsNCj4gPiA+ICsNCj4gPiA+IMKgwqDCoMKgIGlmICh2dGRfcGNl
LT5mYXVsdF9mZCA8IDApIHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+ID4g
wqDCoMKgwqAgfQ0KPiA+ID4gDQo+ID4gPiAtwqDCoMKgIHFlbXVfc2V0X2ZkX2hhbmRsZXIodnRk
X3BjZS0+ZmF1bHRfZmQsIE5VTEwsIE5VTEwsIE5VTEwpOw0KPiA+ID4gLcKgwqDCoCB2dGRfZGVz
dHJveV9mc19mYXVsdHEodnRkX3BjZS0+dnRkX2hpb2QsIHZ0ZF9wY2UtPmZhdWx0X2lkLA0KPiA+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZ0
ZF9wY2UtPmZhdWx0X2ZkKTsNCj4gPiA+ICvCoMKgwqAgZnEgPSBnX21hbGxvYyhzaXplb2YoSU9N
TVVGYXVsdFF1ZXVlKSk7DQo+ID4gDQo+ID4gDQo+ID4gc2l6ZW9mKCpmcSkNCj4gDQo+IA0KPiBT
dXJlLg0KPiANCj4gDQo+IA0KPiA+IA0KPiA+ID4gK8KgwqDCoCBmcS0+aW9tbXVmZCA9IGlkZXYt
PmlvbW11ZmQ7DQo+ID4gPiArwqDCoMKgIGZxLT5mZCA9IHZ0ZF9wY2UtPmZhdWx0X2ZkOw0KPiA+
ID4gK8KgwqDCoCBmcS0+aWQgPSB2dGRfcGNlLT5mYXVsdF9pZDsNCj4gPiA+IMKgwqDCoMKgIHZ0
ZF9wY2UtPmZhdWx0X2lkID0gMDsNCj4gPiA+IMKgwqDCoMKgIHZ0ZF9wY2UtPmZhdWx0X2ZkID0g
LTE7DQo+ID4gPiArwqDCoMKgIGZxLT52dGRfcHJxX2xpc3QubGhfZmlyc3QgPSB2dGRfcGNlLT52
dGRfcHJxX2xpc3QubGhfZmlyc3Q7DQo+ID4gPiArwqDCoMKgIFFMSVNUX0lOSVQoJnZ0ZF9wY2Ut
PnZ0ZF9wcnFfbGlzdCk7DQo+ID4gDQo+ID4gDQo+ID4gYXJlIHdlIHN1cmUgdGhhdCB2dGRfcGNl
LT52dGRfcHJxX2xpc3QgaXMgbm90IHVwZGF0ZWQgYnkgYW5vdGhlciB0aHJlYWQNCj4gPiBjb25j
dXJyZW50bHkgYXQgdGhpcyBwb2ludD8NCj4gDQo+IA0KPiBZZXMsIHZ0ZF9wcnFfbGlzdCBpcyB1
cGRhdGVkIGluIGJlbG93IHBhdGhzOg0KPiANCj4gMS4gcG9sbCgpIGV4aXQgLT4gdnRkX3JlYWRf
ZnNfZmF1bHRxKCkgLT4gdnRkX3Byb3BhZ2F0ZV9yZWNvdmVyYWJsZV9mYXVsdHMoKSAtPiB2dGRf
cHJxX2xpc3QgaW5zZXJ0ICANCj4gMi4gcG9sbCgpIGV4aXQgLT4gZmF1bHRxX3RlYXJkb3duX2Jo
KCkgLT4gdnRkX3BycV9saXN0IHJlbW92ZSAgDQo+IDMuIHZ0ZF9wcm9jZXNzX2ludl9kZXNjKCkg
LT4gdnRkX3Byb2Nlc3NfcGFnZV9ncm91cF9yZXNwb25zZV9kZXNjKCkgLT4gdnRkX2FjY2VsX3By
b3BhZ2F0ZV9wYWdlX2dyb3VwX3Jlc3BvbnNlKCkgLT4gdnRkX3BycV9oYW5kbGVfcGFzaWRfcmVz
cG9uc2UoKSAtPiB2dGRfcHJxX2xpc3QgcmVtb3ZlDQo+IA0KPiAxIGFuZCAyIHJ1bnMgaW4gbWFp
biB0aHJlYWQgd2hpY2ggdGFrZXMgQlFMIGFmdGVyIHBvbGwoKSBleGl0LiAgDQo+IDMgcnVucyBp
biB2Y3B1IHRocmVhZCwgYmVmb3JlIHVwZGF0aW5nIGRldmljZSBzdGF0ZSwgQlFMIHNob3VsZCBo
YXMgYmVlbiB0YWtlbiBpbiBwcmVwYXJlX21taW9fYWNjZXNzKCkuDQoNCm5pY2UsIHRoYW5rcyEN
Cg0KPiANCj4gVGhhbmtzICANCj4gWmhlbnpob25n

