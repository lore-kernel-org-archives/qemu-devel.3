Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF310C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNV-0003mT-Le; Thu, 02 May 2024 11:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNU-0003lw-9O
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:44 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNR-0005yW-Nw
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663781; x=1746199781;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XdRcKz4UzvZ+woWJhI3pztr087NyonzEBAqo9r9/ROk=;
 b=bW8NTR9UgNqYyzX22Hw3y5BmsUMRlO8godOXixOaok9txhbFcbmputxK
 3iXhETOGtfbUrbvX5mYUPOqxhcVFcKO9zBOaUaSySjL08XLEbpj4TQBnJ
 1Bh3+j5Ydnrbwpy8dzuOmNmUl2M8WpYJOO9bzXwcSd3mJ9W+QB6Tggbpp
 /pqdVgy/vpPQzdBYmNl4K3LRUoPVxssyv4u1Hx5+D5EdGiE2OLxjqCaqm
 wqenQL7RxAdcOLOTEk2Rjdz2r7TmyBfXBo80X8PMa3ZP3D+WXMnSrLpsd
 g1RcloTMInaPXBQ2bWz09bjoqoRGF4q2B+7CCDEa1ULwTf+Dfcr14mM+t A==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785879"
X-MGA-submission: =?us-ascii?q?MDFYmYZnZ2+CZm+r5o283xyc7GRQXGT9Zpl3xO?=
 =?us-ascii?q?+Mc16/pfi9PITnBQ1zUNYJk3jGmXfsBPwQuz/6sQ8s2NyZNwbKAEz2zY?=
 =?us-ascii?q?71W8KtBlbxIsNwQyfAfjLUe+MzrLTVKJhWsma3oGPdV4/R++KStbD9Xk?=
 =?us-ascii?q?2ACYQ1ERxdO9E1TVVfIvbN2w=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:20 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fka65gef2756AG75BKwb/UeE4lNjWZoeOHwruBMuQ8TSVY67tcxP9IVJLtqExzyDNoB1PB0bu1T9+mwvWJtWR7S2IZaSwyTvuZGpJRJkfpA6sN8fM3D8U449AB5wHHh8WuPa4DNd8H8AKJ+idZvneZYGoVr40Os9UT/ZpAPaOUziHT+lkT/J97gHsn04lD8MVSYTw78GFp8dGKk7ze+vWiod5LIJaQtmFpDO/Ub0daViKz7s0P/7YBKkeG/rJAbYkw12/D0qh6+8OcxtaaJu9ZcxSNls8NfaOy5cfDyTEgKjtUGSLMFPuAkakgeg/U/svKmO7Vc7uf0nd/dW0FHxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdRcKz4UzvZ+woWJhI3pztr087NyonzEBAqo9r9/ROk=;
 b=hE8Azm2pBfZmYQ+pxctKk7kz0xl5MwYiXLGoFmDcQ8f4SvB9BX1fZ1cBpmirPTeomRfrLcPc0QTKy7Knu9Ang7ZpNTP6L8qow1ti5sdRA8Za+lBW9NKqIjvCuTWgb1z38f1RrMilIDx0dGOM75IanYqHObI9lKHBxp0+HQueW4USnt58z9Y9101YzVIxIOxKHhEhVaJLzn1BqrXbVe8GSWO0baaMstFv9QOK6bTnu/0ddAUkcAN+IzX8QQVcxPs1gJ1YkN/anaEmTWiwXHBJGb9GPiygQTi94uidX0wZ8k3GmSVxhexm81bXpFvG05s8FphGOW9y3QO3fUvH+5iueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:18 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:18 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 06/24] intel_iommu: do not consider wait_desc as an
 invalid descriptor
Thread-Topic: [PATCH ats_vtd v1 06/24] intel_iommu: do not consider wait_desc
 as an invalid descriptor
Thread-Index: AQHanKV/hE21IWhVrEugDPFECrFAVA==
Date: Thu, 2 May 2024 15:29:18 +0000
Message-ID: <20240502152810.187492-7-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: afc943eb-b053-4b0c-a9bb-08dc6abca1cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?S1ZtWU4wOW0vNSsybTdpYm5JL3NZdVJueHRtcWh3ejMzcno4QlpoZFc3R09u?=
 =?utf-8?B?OGZOTU1HQnBwczI3cUR5QnhqRmh1d1pueis3L2tvUitGSVJyQkRvaGh6dndZ?=
 =?utf-8?B?REZleUUwR0NheFhyUFlJQ04wdmhXb3BRbFNoejNnWEZITUdqaHdVRUwwM0FE?=
 =?utf-8?B?dHNlT3VSM0dxZ2VYeHUyRWNmSmN0SktiSUxiYjBtQ29jMSs3UjJPMTdZdlFY?=
 =?utf-8?B?YUp2ZTZwV3JreFNmNzQ1akdCbDIxVW5XaVh4MUxveDE3ME9yWW5YRW13TjJy?=
 =?utf-8?B?VXNJZjJoeC9zK0luNFhkRFgvdFFhYzVScjJuTWlEaFlZclRPUnZaYit1aUFV?=
 =?utf-8?B?VlJLby9LUVYyVVB0aDR4amFkelpIbCtUQjVjM1U4ME5kbHlVY2xQMSthVFdh?=
 =?utf-8?B?dnAwd1l5eVRoQThYVmU5SUNEK1ZhQ1Jza2J0VUpGTmJTdm40U2hrdFhiMm1T?=
 =?utf-8?B?RkpkcUVrYnN0S2hNcnZYelpwZjFXNUVhT2poMFJSN2NUdThhZVhqUVRKSHNr?=
 =?utf-8?B?eW96NFNLTUhRYXlEazJ1SzFHa1FjamthbkdTYXlabVJXZEZSOHpqNjZ4TkpF?=
 =?utf-8?B?RnhocE81Q3lhY3pSZWZKU1BObXRPeDhsR2Yxd1FZMnM0RjFGR1pkeTZuaXJD?=
 =?utf-8?B?c1RtR2pVT0F4YW55SmE4ZUZXUE9VQ2l2cUtvR0IzallrWkszR2Y5bkc5cUp1?=
 =?utf-8?B?dlNxMGlXOXNWQ2FwSTA0L2NCZUJzd1k0MUJWcks4V3F0dEU5VlVCMUphUjhZ?=
 =?utf-8?B?NlNLaVptWE1MOTh4MHJvYTkyMXdwMVVDdUthcHJYSW9jbDlMZWM5YTNkUWZE?=
 =?utf-8?B?KzArTHI2OEwxRVlwVlBVQUxpdUlNZGZ2QWZ0Z2UraHJtMnNrNjM5N3M0OTl6?=
 =?utf-8?B?TUF2V2g2b0d5dk5RSERZVUcyY3A4NHdtMnpkdkNLRU5oazV6b0I4SEpVeXhH?=
 =?utf-8?B?L091b3pNWDl5eG1FR094dmpCVG56M0hnekJScEdUcmI3YjB2NVJyVHJ5VVFZ?=
 =?utf-8?B?S3NFMU80UzlxZVJQcE1qUFFhOGh3VjhQREtjMzNMaEl5Y1ZIMGdWUFBVdFNk?=
 =?utf-8?B?K3RydFZUVU0ydFYzUFQ5OW1xMndFbWhDcDhOTlhXWWJYaVE2SlhTenhMUWJX?=
 =?utf-8?B?aFFDMjdwTzFvY0lXV1FtajB3c2VTYm1KaVZtVW1TaWxybklHN25YWVlBUTJr?=
 =?utf-8?B?TG1nWnc4MmxyUmhUMnZNRW5lLyt4SG04TVU0WXNvdnlSdlJNNEVSYjRhM0Zn?=
 =?utf-8?B?UzE2ejNEaUM0cGNtWmg1cDJUay9hN0RCRnhuZWtGVzlWZGtLcWpaZHg3cW5U?=
 =?utf-8?B?MEswSStsNHJPQzR6WmlIN3NvcVhScXQxSnZHTTVTZ3VHdnpJcXR4NUhTYjR1?=
 =?utf-8?B?MHg0UnBnZmR5MGZaZFBrd2gveVpBem12NWRmQTIybGhUejRtSHlTWW9xczFh?=
 =?utf-8?B?aGdMWUFJR2Zva280cHNBc0MrWlRHTlVBc0YwTGZKL0FFWE02U3Juc2VuU3BM?=
 =?utf-8?B?K1ZoQVBGYjBMWU45cXhBbCs2aWVvbHdqbFZsQzNtdTdpcDFMSkpZZXdlNlRn?=
 =?utf-8?B?bkVyK0NzWTcwcDVRTFluNnFHRWVpd0QyM1RTRnRVYzVVc1RNck9rQ2xaNmtO?=
 =?utf-8?B?RlB0SUtJODdubXY4dTR2MFFKdVNJbmIzSnJyd1VEdWEwc0NiZytsNTlDUnVx?=
 =?utf-8?B?VmFmZjZLUWpIT1pLbFVYcVM0YmZ0V0dVK2dMQVE2dkJPem5VMnZBYmpGYXJU?=
 =?utf-8?Q?ER9PmlNOcTWn3JabzTa5ZHQr2xt3YQqTsWrXWpg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TERZQzQ5NnZ5T09TNTlMMHJHUW9VVTFBZnVVMTNKVUdvcGU3SDl2cUl1U291?=
 =?utf-8?B?U0tJZXY5bnhwZWNrWWJMS0tUdEVIMHlhbUxWZ0gvNWVIbUxXZFVBeXIxWCtM?=
 =?utf-8?B?TjloQk0xcno0NXo1QUVxNXI2VEJaV0Z3SEtFbW1wekhBbXZlTUhKNmNUZ0E1?=
 =?utf-8?B?K3BaTzMyRjA1emJ0UFl1Y0JXK05oL3lQY29vbGZhWUppTkdEMUJleW5ZVU1y?=
 =?utf-8?B?T3RhcW83dG1WRCtMajZZZ3NBYnIvMitITkpDa2UzS1gwd2duUnExcTAwZ01y?=
 =?utf-8?B?WnNjcmdGRGZRbHRpUGpMZXZOTnhUdzgraCs3UElvSVZYM0tPU3JpRWljcGow?=
 =?utf-8?B?OG1pazBUY3NQVkQrT1B4OHpGcEhvb0xZQ2g5Tm9wYVN6WEFyWFVxMzVZTW4z?=
 =?utf-8?B?cDVtZGZqbUhhUkVISEV0Nklrd1c0TFFkblh1L0dIeVY3anpxMkp5U1Z3M2F4?=
 =?utf-8?B?dTRDTTUrRms0QmZFc3Q0UTM0YkhGSXVvM2ZTSEErT2RwWnhsQmN3NzZ5bzNH?=
 =?utf-8?B?R0ErM2p5VW9NU2lFMGN4bmJLR1BiaWZ2cVgva2hxVFFLdFMwWXF5cGp3dUxn?=
 =?utf-8?B?M0JDblZVd0NJclE1VVNpTjMycWlSUzVVV1hLeldzemtpV0VvZEE5cEFoQ25P?=
 =?utf-8?B?OU0yZU9henJtUXBTMEpWcEs3QThUSGlMYjFmWXNGbzVaU2I1bGk1ckduN3o5?=
 =?utf-8?B?RWhiNjVrcE4wNFFhWDdQbGk5TWJxdEdGSzZYWUhlaGQ1N25IZFJrYmgxczJS?=
 =?utf-8?B?dDB2RkMzdC9rWExLdVpRYTN6TnZJMXFIaUdXRUt5L2plUXVvd3hveWxlbmFi?=
 =?utf-8?B?YmpqMG91M3VKandJNkJwa2NWTVYwQkFSV2F6VnJzYzRVVUZRMDFjcWtqSnlu?=
 =?utf-8?B?Tk9Lbm9IUCtiaW9MZ25EK0M1UkhPbEFEamdQWm84L3RTV2xOWXZkSjAyMEpS?=
 =?utf-8?B?SU1Ody9XQytKRFc2TmdFc2M3WmRtR1ZEeDI4REFCZjU1ajZJOWlSMlpnNUd4?=
 =?utf-8?B?bk1qelpIWlRxdnZBenJrT3E0UmNUaDRoM0dtUDJ0UlRCdzQ5L05MQjBodUNn?=
 =?utf-8?B?a3Y0cHkvMnB0WWRTNm1OTllJdWZWZUQ2SHJkL1ErZ2d3YUZ4eE9LNG5WdGF2?=
 =?utf-8?B?b25VT3A2bkNvRERuL0lRYzdndm5Iam1wYmJqNnJjTjVVVDM0bEc5RVpWSXdI?=
 =?utf-8?B?ajBxYXZjbjE2S1hWVWJvaHhZS3k1QVhiWkoxZmdTZ3pKTllPRTF3MWI3TU9G?=
 =?utf-8?B?a0dJdGJkTWdhSnhZdWh1VGhnZURKMTkxQVJJRmYrMmd2cnFaTzc4amZWQThH?=
 =?utf-8?B?S0NXV0E5MSticlZHOENPTHZVVzBwZ3IySGJ4ZG16a0xhZmhLV2N0MUJmOVNy?=
 =?utf-8?B?SzYvMisxdkxPRHVpR3JBRENMMkFRazhVYk9HVzdscm9pcEFieW9YVnBycTBj?=
 =?utf-8?B?WjVUbG0zczNKUFFSWDZtTmZXNGszeUFmdXVHelVRd1lPUEhaY3ZDRyttNVVV?=
 =?utf-8?B?My90WnVkQXN6dkJLVEpyTm5XMzlyU0kweGllNmpHZ3o4MWVxNVZNMW5vVVdz?=
 =?utf-8?B?VlFqbDFTRS9FRGY4TDIzaU5Ia0xxbFFEV1hOeFVxYTV5NmlneDBwcFljMnM4?=
 =?utf-8?B?VGNha1BuOWNTUjFkaEN0dFRkQnVTcXF6alJhaWkrQ0lwb1QrTGZYZjYrTHYr?=
 =?utf-8?B?NTM5bkxOVi94K0cra2JtYUdaU1N4ZzVRdUt4SHB2bzJra0diR1MwdHo4czc1?=
 =?utf-8?B?QjZaUVhuQWZ1dVRzNGVmSU84UTEwa1dnQlFmTU1Hd2VXOVZ1Nzd6NE1mSWU4?=
 =?utf-8?B?Z1BJbUFFTXFNY3laM0ViV3d2NEljcVUyVE85d21MVURnNXFYbnF0SnJCRVg4?=
 =?utf-8?B?S3NCRW41a005ZHpzNXh4ZTQ4OFo3WXhNWmxnY3BkZTdRTjVsdUY2MGNEWkt0?=
 =?utf-8?B?Z0ZSNDJCMWc2UzgrREpYeEhBN3RpVTVtcGhyb1lBNE5sU05odUpBMWF2c3Zy?=
 =?utf-8?B?WWNENWYyZDFWdFBHd043SUx6akJrNC9hUEJFSXpKM3pMc0E5c0t0dml2UUY2?=
 =?utf-8?B?WnF4aUdXZVJwWTdjMTFRVm9kTVFRYTV1WFpLUkNEaSs1OXhFcFFQL25BSE9H?=
 =?utf-8?B?aFk0U3hzNy95U1Y3c1dKeWxpeVYyMElOb0taWFJTWitKRm9yc2hVd2tZM09y?=
 =?utf-8?Q?6jMuuv+zrQPnCNHTNZ9Ye2s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1150C7861368194F9FDDB4AA94F9EE68@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc943eb-b053-4b0c-a9bb-08dc6abca1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:18.0512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OFPuYCEOGtAoipD7JPbbFS95PpytgZVCb1GGjP53Z1icdQurrhES1mrVC19b6FcMwjrMBiqM+o8xE1kon6RNgXdrqGdSOCJLbn5XPYRF0pJH6AKHXA5z8HiXpbuBo0C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA1ICsrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCA4NWE3ZWJhYzY3Li5j
NDc1YTM1NGEwIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQorKysgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCkBAIC0zMzY1LDYgKzMzNjUsMTEgQEAgc3RhdGljIGJvb2wgdnRk
X3Byb2Nlc3Nfd2FpdF9kZXNjKEludGVsSU9NTVVTdGF0ZSAqcywgVlRESW52RGVzYyAqaW52X2Rl
c2MpDQogICAgIH0gZWxzZSBpZiAoaW52X2Rlc2MtPmxvICYgVlREX0lOVl9ERVNDX1dBSVRfSUYp
IHsNCiAgICAgICAgIC8qIEludGVycnVwdCBmbGFnICovDQogICAgICAgICB2dGRfZ2VuZXJhdGVf
Y29tcGxldGlvbl9ldmVudChzKTsNCisgICAgfSBlbHNlIGlmIChpbnZfZGVzYy0+bG8gJiBWVERf
SU5WX0RFU0NfV0FJVF9GTikgew0KKyAgICAgICAgLyoNCisgICAgICAgICAqIFNXID0gMCwgSUYg
PSAwLCBGTiA9IDENCisgICAgICAgICAqIE5vdGhpbmcgdG8gZG8gYXMgd2UgcHJvY2VzcyB0aGUg
ZXZlbnRzIHNlcXVlbnRpYWxseQ0KKyAgICAgICAgICovDQogICAgIH0gZWxzZSB7DQogICAgICAg
ICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGludmFsaWQgd2FpdCBkZXNjOiBoaT0lIlBSSXg2NCIs
IGxvPSUiUFJJeDY0DQogICAgICAgICAgICAgICAgICAgICAgICAgICAiICh1bmtub3duIHR5cGUp
IiwgX19mdW5jX18sIGludl9kZXNjLT5oaSwNCi0tIA0KMi40NC4wDQo=

