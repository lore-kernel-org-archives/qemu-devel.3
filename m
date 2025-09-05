Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BFBCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 08:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRiG-0001cl-Lh; Fri, 05 Sep 2025 04:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uuRi9-0001b3-QO; Fri, 05 Sep 2025 04:22:23 -0400
Received: from mail-dm6nam04on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2409::614]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uuRi6-00008Z-Mn; Fri, 05 Sep 2025 04:22:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTG+thSMyNxKCptltcDKgK6gJInGikzED9SIaCPMBNwNvPLUCAqK+kjJZyJOpMv2m7t2UallxzIukvlzuNi8aQzC765S0S85kJ+t2IBCKK5znW9T3pswz3NK9Murpo01p4dGX0uPHw1GvSTK8yftAFI2xxjI/OTubhmP9UQdMibxZgHnJI1R5RBcfrJMobiPGehMzsL4bH2xDabPFpjoBsvPXEzV/GqIlaAFEGkpg9MMkhA07+9Gq2ZcwRTIcZwA0sn9d55S1k5u6k5ESru9adcUlAWn0EOftKiRBz1Xv7X+w9vLRnaDozTUSD8pRV3L249+JUHsrvKwFQfNE2TWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoAG6cb28Bt0NNXXAJBwZq9Ts0kAhXXxi9xJvkkvCEc=;
 b=Jx16nFXsTAjpyAv605hZZGgIvE/4tI9WEu8AMaM5RX7xRBnc57RT/lKB8hXjm5i6rOiMRL/PaZzUvPQXBWZi4NG4OAZiyOkSb94dEr2kzzoq4lrVyQch5KpOH3AOjCZXtKek1ax/mE9UF7gkYr6CNU9z+HUGTB8tbrZBSbN4FYBt21BZed1v0IUAvS/RlzZqTMIIElDCVEV32TKtIqljZF9UvQwLUJbOwCdGOMqtMAbT9eMfgI5/AvVTG33QgD3/VdRdMQTD5NrW50rQkba8gFUzGOCFBZ6t+mZ6UJta+K1lP3eyn+BUxq8C+j/0bMYQT3viLXNNLjtTd4w3nUmRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoAG6cb28Bt0NNXXAJBwZq9Ts0kAhXXxi9xJvkkvCEc=;
 b=bhNtEXN2wi6rdsD4mDByKcOYcWuWvk4r1xze8LUq3bYqtUT3PQgdOATcicafJowS74ki+oM/1G9VcPGH6f7/++HeNiuFpuCWc4zkl1PrAP4wSbzz6AOhtENxQrf0QAdNFJO0Dyy+p1dh3wosIdSmz58/i1i2HitFL62pXvk6tQOHFb6hiiNeLBOYQk7NP5CzP/D8rW7Lik+zXGklaxktLUd8ibbGVzlc2efqAn7QB74cSxpbHQQ8r8zhPN52JAqvaboqio+v841F5C3XKEzi7XSqE2uHVAINKO2yAQ+ynW4VE/H8aEdlsK1sxp5ASu5rQObb+L9Tn8yD0A1X1HY3bQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 08:22:11 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%2]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 08:22:11 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Topic: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Index: AQHcHajecGBvRYDlMUyaDHeRHM9GsLSEP0uQ
Date: Fri, 5 Sep 2025 08:22:11 +0000
Message-ID: <CH3PR12MB754884A2F1673D1424EE8378AB03A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
 <aHU9INgBsFgvtec+@Asurada-Nvidia>
 <f0473156-2e59-4467-90cc-d8315cf9063e@redhat.com>
In-Reply-To: <f0473156-2e59-4467-90cc-d8315cf9063e@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB9733:EE_
x-ms-office365-filtering-correlation-id: 1bfe10ab-b20e-42f0-4a9f-08ddec555009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NFJkbllRMnNDNVlqZTV0OFlEaHhqR3F2c2pMdGp6RmFjNlFFd2EwTEFsVVlS?=
 =?utf-8?B?NVdONlNhNFg4WURNU1JJcTl2eHhlQTdXVmhEcGRpL3QzWDdvTFp6TXhUb0lH?=
 =?utf-8?B?cWxFTW0ydVBSSjlyYTFGSGdaN2swc2hteG10N1gyNW5IckkvQ2dGS2dicUpj?=
 =?utf-8?B?ZVhTenNEby81KzJobXdhaFA2TGtHUHI1My9kNmo2Y2t5alVjL0lqK1ZDWWtG?=
 =?utf-8?B?NVpqTGFkdmo2d0gzZUtvRXRVbEx5dk52UlBvdFAvUEFlb0ZaR0VxQnJGSDZ0?=
 =?utf-8?B?NGpmN2NtMlRBVndpS1EzaVJBR2N4U1k4aTlUNkRTdlM5WG80L2pYZEFqd21R?=
 =?utf-8?B?NFF2dG1BVm1XVWt2eUNETFg1eWFrNExmbEk0RkEwOFQ1Mjh3OE5mT1hLQWFS?=
 =?utf-8?B?MVRsVGs2N25OWGN2SVE5TFpHYVF4cWpMdzAwbUViM1BVcFlLY0F1RjZFTmF3?=
 =?utf-8?B?bHU0RklLa1ZQdDgyMGU1S3JNZE1SS3FjclJwcEdPS0ZSUERIajZOalRQbU9l?=
 =?utf-8?B?UFY3cndQcExyV2JOTlFvYU9MK1NWdXFjOUs1YmF1bHRlcklzVlY4QU04NDhU?=
 =?utf-8?B?ZGMxZ0V0UklsRHdsNTNIdEFKMC8yOGhzdHNhSnNHSDBrdC90LytYRVJteXEy?=
 =?utf-8?B?cnNYZ1dFUVBFNUpPNlFLK0ZqdVFqbXViM3RoRGhyejFIYVdoRVpXMWZockhi?=
 =?utf-8?B?U0JReHU4ODJEMWYyK21VTDRRSXE3QWNLbUpjajQvTVd5MWIwUU9XeWJaT3Fx?=
 =?utf-8?B?QnlkUDllVUsxbTNEUGFJMWRxcGVGV2ZnZzVTOGdnOXl4UXdRR2dwYXB0aW1u?=
 =?utf-8?B?L3k4Y1B1MTIxY0NEVitoTkVmekNUVzVTVzNFN3BrQ09SNm4ySnR5RWtnTzJk?=
 =?utf-8?B?RnZSY0lrbFRFZ2VZbTJFNS9jMnJBL2RZVjlPaG1KeU1OYkNkaTNJWVB5Zkho?=
 =?utf-8?B?RW1QUU05N0pEajJVeGw3T1Y5WER5MFhTUGU1czVGc0ExT1Vid0RiTkhTVU16?=
 =?utf-8?B?WGFRQjJNRHJuSjJGN1cwYUIzbjFXZlJRU2x3bzlVOWE3dFpyVG53R3FITk5O?=
 =?utf-8?B?YWhydnQ2NGdpYXJYcEZHMjFLdFplR0lITjJaODBKaEl3RDU0OGhLM0plRm1V?=
 =?utf-8?B?Mmg1MG9qK09ZWHlKVCtYOTMyRXloR0hlOUVXNjlKVkR5MUUrMTFveVJ2aDFk?=
 =?utf-8?B?cFVwNVIxclNZSVJTRllwNnJpZWN1SVJHcDdNQXlnR2JWMUh1SCt0UjNxUFZW?=
 =?utf-8?B?WmxIUUlZejdldzBjWEk0K2t5aUF1UmdXWHFKZXhMcjlZRWNFdVRVR05KVHhG?=
 =?utf-8?B?cXlGUTg1anRsQ25RbUFyUGp0MmhZY3o5RC9mb29FK1k4U2l1TURob3ZXYkMr?=
 =?utf-8?B?SXM4M0I0LzZJa0M5RjM2eWpmQjVHbzNhK25UdGlOSkI2NzBzT1JEMGF0aHZi?=
 =?utf-8?B?ZUNTZ2Z2TEpNS3J6WVlSQ2pNbWlRNWlqaDRHM0l3eVQrTkhUOUwyVjRhcWhr?=
 =?utf-8?B?cmM2QkZMaXhjYnl1cDZZRGd3cFh1RWxuMGp0Y1AybFdORnF1MXJWQVhQTnUy?=
 =?utf-8?B?a1pZWFNLSmVUUWM4cERnTmpzeVp6SlZTLzM4dzRsTFBxL0VMeDdpc3ZkcnI5?=
 =?utf-8?B?WElVUW56NHZJNmh0OWdZR3lRU2x5bHJDSFlUa0IxSlFJKzVWd0NuWFQ3UDNN?=
 =?utf-8?B?U3JoL3pLanFLT1RoUVRnK1FaYUdaN1BTY0tCSmh2SHdiUUwzcDc1WXkwci9m?=
 =?utf-8?B?dk1JbHpwNkJCVldjcnQvZSsySkgyd2lFcm1VM1MxN00rNGwxYzdWb1dNQXhF?=
 =?utf-8?B?QXZZWldha2dPK1dieXNmMStkSG41QU5Vc3VKU3NVS001RENyOTJZdnN5M01w?=
 =?utf-8?B?dXdaT0hadER1VURuczUzblZoaE4yT1BLVG5NamVUb2hhdjlDYmcyMUZJUEhS?=
 =?utf-8?B?MWVNT3NaUUptS29haWRIVWMyZVh5TCsxVW5wUnEzTlR3R1ZvNFRwZ0xkd0FQ?=
 =?utf-8?B?bXZlN3JqUUZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGZlaGM2cXNheEJOMmVJMHl2cllNK1RrZXB5NXdrWnQ4cStCSml5MEhJTnpI?=
 =?utf-8?B?K3dRYWFacUFqdWMvcHMvY2NyREg1cExna1NkTTMyM3JGd3VoR3VMMVd2ams4?=
 =?utf-8?B?ZkRXTTArMmpmODMzUWVvQzFJSzZYMi9hWWQ3OTJTK1RBa1QyeUE2Myt6SU1r?=
 =?utf-8?B?OEpEa0dqUFArYWdRMWY1R01jaGVBWGpCbXdCVlBiZytSY0p5TGNiNWhaNTJ1?=
 =?utf-8?B?TzRUaTk2dFdZWlIyVmxPalVZU2JmZTg1VEJvL1ZaYnlKWkFYRS9uaUQxQXha?=
 =?utf-8?B?VURNbTI2TXFGcFc0dk5YQVp2R1BHOHBhd2szNmxqb0prZklGdThCaHZnb2sz?=
 =?utf-8?B?dmdDa2JyZnFkQ2NXendsWlc3eHZYU2tGTWpGVWh0dENmSjhlQjlQa1VzRTU5?=
 =?utf-8?B?VVVJSzJ1eUgvVURCR3BtSms3K28vS2E3YlFFYVE2dGsvMmZhRjJrREtzL1ov?=
 =?utf-8?B?YUtBZytUQ21PSWYwSlhzSk5meXAxYlVUUE0waEJiYk1kRkl1Sk9YbDRWWXRM?=
 =?utf-8?B?d1licUo5OU0rcERSenJhRkdXNE1Pekp3cFBsRUhLWGhiZHlqOENNdGt2RUxw?=
 =?utf-8?B?aHdJTEdCRXlITEQyN0pLempld3ZNK2VLTXJqNFpHVGJXZkFIU2I3eHgzL1pT?=
 =?utf-8?B?aDhuRTVNUzJSMnIrL1dsQWJKTHM0elNmYzFkSmZiSC9xVlVlcDFBOWw3UStR?=
 =?utf-8?B?MmlwMWMxRVZMRlRoNGtUam0xd2c4RlVVY3F6S3pOUmtXMmg1TVNJTTNRbFdn?=
 =?utf-8?B?a0dlMGN1MitRbEJ1ZGE5REVmYjh5a094Mk10MUd2Y3V0SFVTSWhoMmdRVUVI?=
 =?utf-8?B?QnNNQWJCNytoUmxxTzJYK3ozMGt4M1dEb3JRM1grTWpDSy9icVFjT1F3eVgv?=
 =?utf-8?B?cVpkQ0QzdGF5dDByR1FTN0ZlMWFPc0tYVUt4Q3pKQjhKTHhVTGNFUFlVM2Yx?=
 =?utf-8?B?MlptUVV0eG1ndktYeitTRUNSeGVNSWQ1MURwbXEwVWt2KzhQVzRGTU1mdHFm?=
 =?utf-8?B?Z21XSytYSlVmQjNBc0MyUmJqUVJiVjdudzNjTFI3WVNCMTZFYmZRRGRBYTdZ?=
 =?utf-8?B?M3VUNjM5Mk1sT3IvcGFwZmlLbVlJeEZ0ZkVMWDFUN0xmenpFbU9vQ1FnZFU2?=
 =?utf-8?B?UzcvRSszbU1iOWtTcGZQMmlaQSthTmpUZjQxOTZFWDJqeEVmdDRRMlA0RzN1?=
 =?utf-8?B?SENXSGFCWGVobExYNksvVlBkb2ErSk8waVVuaVhnNktpaGphWjhoYitldWdy?=
 =?utf-8?B?c0tIRW9XZ2VvbGFjdFB5SVF2aDlhTGk0QnR1eGR3OG9aUGtoaklTNzZmcHlZ?=
 =?utf-8?B?cGJwaHFWNTJKSG1heWlsUDBQSnRwWjFpbkVJWnlrNnFBWEx4Z3dJMjk1Mk9m?=
 =?utf-8?B?ZlR6Vk5TOHNoVHd5Rmc4bzF2cXhFaDNPR3ZrQzRjcFY5SU5OZmZsbTFsdHpv?=
 =?utf-8?B?eW5IRXZVVHhkR2xkdmY3OWtDbVhneWFGRlU0aWZkRGw5QnN4Ty91eWYrYiti?=
 =?utf-8?B?bEN5cVJQcHZRNkl3RklzVjg4aVhMdW9ITEJuYzFkU1dFcTk4ODRnUXdLd2ww?=
 =?utf-8?B?a0dRdWVXVEFaUy9jK2lhRk9DSE9pT2JmTVMxRmpzajBsbS9yRHlUdE44NVVx?=
 =?utf-8?B?OTNiQ3FsSCt6enZsSGRXZ01WbFJKSzNnTzc0Wmx4d2RReTBVcmJjQi9zWlhP?=
 =?utf-8?B?ZWF1VXp0NG1rbFVSUEdndENhcG9WQ0NZZjRYMVR4WjRsUjkrUzZEWnl5dTU4?=
 =?utf-8?B?QWozMENiUTlDVnhiL3UvL3FHV1Nsa0tLOVd6OHFNTGFLK1k2RGZONlU0VkhV?=
 =?utf-8?B?Tk9TVDRQWFVhRTVWV1poM0ZBUllYTERxNTllSzllaFVLMmFNWHRDUlFZZzdX?=
 =?utf-8?B?RE1CVVpZZFB6NU1vei9EZXc4VHZaM2RRRXF2SGszN2srUC9BdTFxUTVlb3V5?=
 =?utf-8?B?T09YNUQ0MERaZU5NVFJOSERGT1FuMzdSZWc2MWZwaXpSYlpIK0p4c3RIcys1?=
 =?utf-8?B?RWZYSXk2TDZiaEJnZFdOSFpCY21kbmFjc3cwZzhpc2pHZHhHNmE2UDFVRDl2?=
 =?utf-8?B?a0tIb1pJbU1TOG1JeHZEcitCZmR1aHA0UkJkVndGV09GREN0ZU1RbVpJUmtn?=
 =?utf-8?Q?cls7LaAl/bL8VKLhyQSyLdWai?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfe10ab-b20e-42f0-4a9f-08ddec555009
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 08:22:11.5291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iF+JHMAYHrRciOR0pDjX8Y2Hx4mAZtnLIeHxHmV9Esxm5qJLphTqCHVEjAs0h3G2fve1w4fQwBJQjPn2HUie9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733
Received-SPF: permerror client-ip=2a01:111:f403:2409::614;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNCBTZXB0ZW1iZXIgMjAyNSAxNTozMw0KPiBU
bzogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgU2hhbWVlciBLb2xvdGh1bQ0K
PiA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+IENjOiBxZW11LWFybUBub25nbnUub3JnOyBx
ZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgSmFzb24g
R3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47DQo+IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFu
Z2VAcmVkaGF0LmNvbTsgTmF0aGFuIENoZW4NCj4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQg
T2NocyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IGxpbnV4YXJt
QGh1YXdlaS5jb207IHdhbmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1bkBodWF3
ZWkuY29tOyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5h
cm8ub3JnOyB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBnbWFp
bC5jb20NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMDUvMTVdIGh3L2FybS9zbW11djMt
YWNjZWw6IEludHJvZHVjZSBzbW11djMNCj4gYWNjZWwgZGV2aWNlDQo+IA0KPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+
IE9uIDcvMTQvMjUgNzoyMyBQTSwgTmljb2xpbiBDaGVuIHdyb3RlOg0KPiA+IE9uIE1vbiwgSnVs
IDE0LCAyMDI1IGF0IDA0OjU5OjMxUE0gKzAxMDAsIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+
ID4+IEFsc28gc2V0dXAgc3BlY2lmaWMgUENJSU9NTVVPcHMgZm9yIGFjY2VsIFNNTVV2MyBhcyBh
Y2NlbA0KPiA+PiBTTU1VdjMgd2lsbCBoYXZlIGRpZmZlcmVudCBoYW5kbGluZyBmb3IgdGhvc2Ug
b3BzIGNhbGxiYWNrcyBpbg0KPiA+PiBzdWJzZXF1ZW50IHBhdGNoZXMuDQo+ID4+DQo+ID4+IFRo
ZSAiYWNjZWwiIHByb3BlcnR5IGlzIG5vdCB5ZXQgYWRkZWQsIHNvIHVzZXJzIGNhbm5vdCBzZXQg
aXQgYXQgdGhpcw0KPiA+PiBwb2ludC4gSXQgd2lsbCBiZSBpbnRyb2R1Y2VkIGluIGEgc3Vic2Vx
dWVudCBwYXRjaCBvbmNlIHRoZSBuZWNlc3NhcnkNCj4gPj4gc3VwcG9ydCBpcyBpbiBwbGFjZS4N
Cj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bQ0KPiA+PiA8c2hhbWVl
cmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+IE92ZXJhbGwgdGhlIHBhdGNoIGxv
b2tzIGdvb2QgdG8gbWUsDQo+ID4gUmV2aWV3ZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNA
bnZpZGlhLmNvbT4NCj4gPg0KPiA+IHdpdGggc29tZSBuaXRzOg0KPiA+DQo+ID4+IEBAIC02MSw3
ICs2MSw4IEBAIGFybV9jb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdfQVJNU1NFJywNCj4gaWZf
dHJ1ZToNCj4gPj4gZmlsZXMoJ2FybXNzZS5jJykpDQo+ID4+ICBhcm1fY29tbW9uX3NzLmFkZCh3
aGVuOiAnQ09ORklHX0ZTTF9JTVg3JywgaWZfdHJ1ZToNCj4gPj4gZmlsZXMoJ2ZzbC1pbXg3LmMn
LCAnbWNpbXg3ZC1zYWJyZS5jJykpDQo+ID4+ICBhcm1fY29tbW9uX3NzLmFkZCh3aGVuOiAnQ09O
RklHX0ZTTF9JTVg4TVAnLCBpZl90cnVlOg0KPiA+PiBmaWxlcygnZnNsLWlteDhtcC5jJykpDQo+
ID4+ICBhcm1fY29tbW9uX3NzLmFkZCh3aGVuOiAnQ09ORklHX0ZTTF9JTVg4TVBfRVZLJywgaWZf
dHJ1ZToNCj4gPj4gZmlsZXMoJ2lteDhtcC1ldmsuYycpKQ0KPiA+PiAtYXJtX2NvbW1vbl9zcy5h
ZGQod2hlbjogJ0NPTkZJR19BUk1fU01NVVYzJywgaWZfdHJ1ZToNCj4gPj4gZmlsZXMoJ3NtbXV2
My5jJykpDQo+ID4+ICthcm1fc3MuYWRkKHdoZW46ICdDT05GSUdfQVJNX1NNTVVWMycsIGlmX3Ry
dWU6IGZpbGVzKCdzbW11djMuYycpKQ0KPiA+PiArYXJtX3NzLmFkZCh3aGVuOiBbJ0NPTkZJR19B
Uk1fU01NVVYzJywgJ0NPTkZJR19JT01NVUZEJ10sDQo+IGlmX3RydWU6DQo+ID4+ICtmaWxlcygn
c21tdXYzLWFjY2VsLmMnKSkNCj4gPiBXb25kZXJpbmcgd2h5ICJhcm1fY29tbW9uX3NzIiBpcyBj
aGFuZ2VkIHRvICJhcm1fc3MiPw0KPiBJbmRlZWQgd2h5IGRpZCB5b3UgbmVlZCB0byBjaGFuZ2Ug
dGhhdD8NCg0KVGhhbmtzIGZvciBnb2luZyB0aHJvdWdoIHRoZSBzZXJpZXMuIEkgd2lsbCBnbyB0
aHJvdWdoIGFsbCB0aGUgY29tbWVudHMgYW5kDQpyZXdvcmsgdGhlIHNlcmllcyBzb29uLCBidXQg
YSBxdWljayBvbmUgb24gdGhlIGFib3ZlIHF1ZXN0aW9uLg0KDQpJIHdhcyBnZXR0aW5nIHRoaXMg
Y29tcGlsZSBlcnJvciBhcyBub3cgd2UgdXNlICNpbmNsdWRlIENPTkZJR19ERVZJQ0VTIHRvIGNo
ZWNrDQpDT05GSUdfSU9NTVVGRCANCg0KLmQgLW8gbGlic3lzdGVtX2FybS5hLnAvaHdfYXJtX3Nt
bXV2My5jLm8gLWMgLi4vaHcvYXJtL3NtbXV2My5jDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4v
aHcvYXJtL3NtbXV2My5jOjM1Og0KLi4vaHcvYXJtL3NtbXV2My1hY2NlbC5oOjE3OjEwOiBlcnJv
cjogI2luY2x1ZGUgZXhwZWN0cyAiRklMRU5BTUUiIG9yIDxGSUxFTkFNRT4NCiAgIDE3IHwgI2lu
Y2x1ZGUgQ09ORklHX0RFVklDRVMNCiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn4NCi4u
L2h3L2FybS9zbW11djMtYWNjZWwuaDo1NToxMzogZXJyb3I6IGF0dGVtcHQgdG8gdXNlIHBvaXNv
bmVkICJDT05GSUdfQVJNX1NNTVVWMyINCiAgIDU1IHwgI2lmIGRlZmluZWQoQ09ORklHX0FSTV9T
TU1VVjMpICYmIGRlZmluZWQoQ09ORklHX0lPTU1VRkQpDQogICAgICB8ICAgICAgICAgICAgIF4N
Ci4uL2h3L2FybS9zbW11djMtYWNjZWwuaDo1NTo0MzogZXJyb3I6IGF0dGVtcHQgdG8gdXNlIHBv
aXNvbmVkICJDT05GSUdfSU9NTVVGRCINCiAgIDU1IHwgI2lmIGRlZmluZWQoQ09ORklHX0FSTV9T
TU1VVjMpICYmIGRlZmluZWQoQ09ORklHX0lPTU1VRkQpDQogICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCm5pbmphOiBidWlsZCBzdG9wcGVkOiBzdWJj
b21tYW5kIGZhaWxlZC4NCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTY4OiBydW4tbmluamFdIEVy
cm9yIDENCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5ICcvcm9vdC9xZW11LWhpc2kvYnVpbGQn
DQoNCkFuZCB3aXRoIGFybV9jb21tb25fc3MuYWRkLCBpdCBsb29rcyBsaWtlIHRoZSBjb21waWxl
ciBpcyBtaXNzaW5nDQonLURDT05GSUdfREVWSUNFUz0iYWFyY2g2NC1zb2Z0bW11LWNvbmZpZy1k
ZXZpY2VzLmgiJy4NCg0KTm90IHN1cmUgaG93IHRvIGZpeCB0aGlzIHdpdGggYXJtX2NvbW1vbl9z
cy5hZGQuIFBsZWFzZSBsZXQgbWUga25vdw0KSWYgdGhlcmUgaXMgYSB3YXkgdG8gYWRkcmVzcyB0
aGlzLg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCg0KDQo=

