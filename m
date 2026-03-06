Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98620F01806
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPbF-0005Nj-0a; Fri, 06 Mar 2026 02:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1vyPbD-0005NS-4b
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:27:51 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1vyPbB-0001d1-Ak
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1772782069; x=1804318069;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=qZ+fkL3HFNyIdRngAHEnaGWttF/R0coqfFPOJ8DOj+k=;
 b=vXO4oYCBCNgK87YoSbLnvuKBvBG7PUv4U0L5L0fgg2/2krNtfyijyLyM
 oyupd+JMWvu4+4ij2J5Za4h6HWLk/7ShWhwmkW9YT7qKE6Ngow3dEwx7B
 2ga+LGxqdVIUYyVCxxPIX4KVHNrWlBakgLU5cE2gkJnFcRNX01IJgHazf
 PMgW0RUYVeyal5kSuWZzSmCZfVp8xUhtpf8EWdYJK7xgsklr7+yhQwxy9
 8ynHgl0LDrCpR4zdaU/5rPx/fqA0lEk2OjXGLFtnWOTFlitmssansqWYt
 gzI0J1ZuaEbshi0tJ4hIzr7lwk5S3lMaE6riDGzQSy5Z8zZFg6C2WmHUp Q==;
X-CSE-ConnectionGUID: bggCrDYwR6eGg4QInyY5qQ==
X-CSE-MsgGUID: 2g5NO2vfTIK+KSMFWli73A==
IronPort-SDR: 69aa81f0_psbVRJ2md+72UHhyHx/ElsUa3q8qOpszcWpiyusU8wvuzre
 VIxursbHEUETJIF9RvKGfhqubjltMKUtyPNrunA==
X-IronPort-AV: E=Sophos;i="6.23,104,1770591600"; d="scan'208";a="46854451"
X-MGA-submission: =?us-ascii?q?MDGvVzYxg6o7s566IlF8f7a9DmdAUAsW7NvLsW?=
 =?us-ascii?q?2BoX+H1cCox6uXq05FNiK1/7j2PF+5PbeZ5w/XpHelRxR7aro4/l/rga?=
 =?us-ascii?q?jTrcJo082wnAtpapp3ZOm/nIKH+10bbl3sVbAgXXKSpnsFN5P+HPa4Jd?=
 =?us-ascii?q?BoAqylw876opImwKaI3JSr/Q=3D=3D?=
Received: from mail-westeuropeazon11011004.outbound.protection.outlook.com
 (HELO AS8PR04CU009.outbound.protection.outlook.com) ([52.101.70.4])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 06 Mar 2026 08:27:43 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuzmu2G951gfd7M/ElqfokNU3RGgBBvDXPa91CxG9EDKisLJkcHJneaz14ffINK6WEjCT8viv5YjAQV9HqfG5Gjntv05zilEt79ydPqpH4bZKKyaw/5m1WTaI1pp+ZWuk9KHkC/bS/WV3Y9obiZq+J9dDzPFY7iHC4qAzxzq6+AtApUR4M0X4ZhcZ1AsnOaojs2o/SOhZRziBf6+evUVWCRLXRRtvsILdO6yCV9WG6/XXY2/6V1DLcatEEp1+/o73vM/XB3h7Nk8PSihL7ceg369MKcprGvYBEOr6kdhbGto5qD3pIcXjhmy6ZUY6vo9govI9vBFbOZteGvHQ4U0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ+fkL3HFNyIdRngAHEnaGWttF/R0coqfFPOJ8DOj+k=;
 b=e9yCO4AZ51B70DV4JSLVXMFnFHyLnFetnJpUBxxMapwXYm0LiO9Z1q4/TVshIpYBPaCLUhKWKOXXkIj7n8xTumu5drWoz9+89Sg6mIrINSRkXA7yk0JY3prUZBEk25Fd4FAit4bO2ERWRgaWvX59jW7R0WkgaRuNL7xmWjVzYDj6EPrwR/YmX6hNdQdWPE6dOUsbH0EwufAc4FlzTQmD1qcFgo7GqZTxX9MQ9DVsVNMkDNnK9pu0Mr3Nb/arwZbpMpohdqSZSckrYIoc83yzR/IyPgDLXaa+lnCWO4qgP5nCrjEucABS0YJEezPR5L5AHCs+1R0akY6lg9UY/anw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB7277.eurprd07.prod.outlook.com (2603:10a6:102:fa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 07:27:41 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 07:27:41 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [PATCH v1 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [PATCH v1 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHcrRuehaFk4ogv7kmbSpD63TywALWhGxcA
Date: Fri, 6 Mar 2026 07:27:41 +0000
Message-ID: <927baa6883584bd5bcc344009cf25ddd282d0ab1.camel@eviden.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-13-zhenzhong.duan@intel.com>
In-Reply-To: <20260306034409.184873-13-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB7277:EE_
x-ms-office365-filtering-correlation-id: d4589825-e4e5-4c63-f37d-08de7b51da24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|18082099003|7053199007;
x-microsoft-antispam-message-info: qlChqALNFj01GNoKe3y+pcfrh0G5GjZTaXdPJWi2WuFn/Cn81pKWX15jNkFc+OXAAahoTKzppOOJnz3APku3W7E95nP2Y0fdRck8mfpiYInhTnCxaTY2TLUUGomUQHXDG0nNaHLcn5s8WO3wEELUJldm7G3y8rjJ29Ge+anv3nXigP5VNehLjKGGLre++k/XWe4Te4AwiqPktmHu4CVEkbwDmRLGGkvctN1IzdlywdPZ/shZihh+b3kFHdueOvo/gLA2Hgh+L0RhNWEs4gIBYO3cPgqgEQa/uTT83jSpsa8FlImpP4RJuU/eK1JSysPtOQoTOoAOv0T5exr5hsMxPm0FfY+L+lMCAVApsAUlyEo89aWV/k4PrrG1NOumL5IXXdLLAqZ44bxm6n+dNiXlxi4NG/3+CfHjkXwqk1uFkOtFNxBrh6+JkogGnf0tDrvJhqdl/4M2x/TTHxcnw8yrQ4hzKvaPEOceTkZ8aRtarpowf9PohAmdIITAr+2iuaql/JdRRdm+aHceLDUVOBtwHin8Twf9Mei+FFq76ZpmxqjJN+MD6Spq4BzC/UAWLbalwagDLLJoqXw0js7LkCczX9h3Vbq4e9pVGQ52wDR1Yi/21VE59YohFLkBs7Eaj4qMsa4mwdHR/FLrN7GVqhOTkBuekPzAZUweBTbwvBakOS91fxeJPA/4Z9kN/nicsUhk78HOZJbXlHrYa7Xh3CnCnGa01N0Y2tdGnqwAec0z8myzwAofTIWG0VHfGa63Mge8Noxfn0YaKI6VswQ1VUJ7GpXwMI8ivLNoQvfHDfNyoXw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18082099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUwveUIyYmpvTFkwanVBbWd3OVlFK0VlQmFOdWVWRFUrNnZYKzJ4NytWMjky?=
 =?utf-8?B?cW16RU5VNmk2Q1lvQ05jaUhGOGJOc2s5eXcwbXU2SWp1eC9pTElra1k1aEhj?=
 =?utf-8?B?eFM0bFdJWSt4K2NhRkN5OGdjK1pNUXorb3hhS2lrS1dySFBNZDdCMUZNdFJU?=
 =?utf-8?B?K0dJRCtnRTVIYzBzODkxRzlvRzhWSm1pZjVKNHQ5RW5ianQ0V29UbG5SekVT?=
 =?utf-8?B?aElaK0RGWi9VcTluUytKaFJIRENYUmFsMUh1RnhyQk9kK29ISEZHYUxFYjBU?=
 =?utf-8?B?NURYYnRTZWVmR3J4OW94NVByZm1USllDN3drNFZ2b3VhLzJYTDRoYk1uZVRw?=
 =?utf-8?B?QVNoczAwcjBjUTRKZWRCUHlQQVVFRWJ4eDkyQVFaUHlZTXRxK1plTjV4bDly?=
 =?utf-8?B?QVFXZ2JKOTVmdVdVVXlWaG5oOTcrYnA5LzJTLy9Kd05YWjBFc0gxSjVOU0t4?=
 =?utf-8?B?WkN0amJwOTVNaVJJcUxwTnZiU1JiMkY3d1FuV1JEb0dNUHNEYlZwQ1Zpdm5a?=
 =?utf-8?B?OVZWdDBrcWJnK2V0ZWQyOEZPRU93NDF4TW54Wm1kZllqUnNwbmFYZjJSalBj?=
 =?utf-8?B?OE9PNnZEUHlBVTdCWGpZZ3ludXVxd3Q0eFZYZGJJd0RZUHdJaldzY2Vzdkpv?=
 =?utf-8?B?TW1TV2cxOFA0TjVxcllqWW1CMWJZNlFUa3FDbityVkZjdW0zU1NqeTZSczB0?=
 =?utf-8?B?Z1U4bFIyYklJaFRHRmJ1ZnRKb3M0TVB4RmhhejQwdGswS2hCTVBNd21SaTdj?=
 =?utf-8?B?QlV6Q1lhOWkzZ3pOdjJJUlJrSDZQeFk3RC9EdUtkTDF0ZmJESTduek5MMCto?=
 =?utf-8?B?SkR3MitzaTZTbXhwUTVYVm9lUk1ZWXBlenBsL1lieERkd1dlOTZGM2RIaHVs?=
 =?utf-8?B?dFVOd2JaT0xpKzk4WFFTSWU2Z0x0bFJoUGRWSGtwNkJWQnUwcjJWejZvODEy?=
 =?utf-8?B?ckdGNmFWMW9JbVVvZVA5RzZjZVJud2ZOYmZEQ3kvVTVuQzhqenlCYTFnNEN1?=
 =?utf-8?B?WGtidGRyUHhWaEwweHA2emRLNHdRYWl1d3dib3hqdFZ5d09TdFBoOHhKYW9V?=
 =?utf-8?B?Wnc5YVhNK2pZbzR6WS9DdmF2K2VBMjRyUGNsMlpZOVoyejQrRlBlanJJMmJj?=
 =?utf-8?B?VzNFRFdYYklpR0xoUmR0Q0g3aHFnaEpHeDJxSCtlc1lKejdGcmdJRERQckRK?=
 =?utf-8?B?eC9zYmVuU2kyMkZHbGRLOHd2N3NpR0xUVDA3ZDFQaU0yK3h0c1Q0amRWUll2?=
 =?utf-8?B?M1NYZUZiTFNBNVB4bVF2S1lidlM0ZGhjNk5sMFVHTWhJOHAvQVJZYkF6SkZ6?=
 =?utf-8?B?MWZHMWRaUW04emQ1L3IvaW82MHFRTHprUytyMUhnTDZxOXRSZGNPVktxZHZx?=
 =?utf-8?B?U0pjWVFWK1FKZUgvbkJ4MUJuZS9GK2FXb3hod2Zkc3dHZ085WXVqV2tuYktU?=
 =?utf-8?B?OTdjMmtQeTNJQ1g2SnlVQVlpZXFxLzgyWVpmQ2VhZi9FdUFIVmxCYVVlNWNO?=
 =?utf-8?B?NzlsbHByZkVLZFkvcmxyMGxuMHNFcjdMQ2JWUmZsM09WSjlCTmRCVkYvemZr?=
 =?utf-8?B?YVkySE5KS2xUT1ludFhqNkM1ek05WWtCMm5mZGVFWkF1SFU1UHRTYjVmMGRS?=
 =?utf-8?B?cjRtN2kvQUlhblZ5c2NPdm53N0tJejZuamFEVndUcm5WK3pmaUgrL0c4TzYx?=
 =?utf-8?B?dVRJaExoa0FYSnkrWnowMXlTcm03aGlnVWhpY1BSaTNFNlBNR2ZNVXB2TWlu?=
 =?utf-8?B?bkwzOEl5aENRWlJXOXVWdDc0QjlmcElLK2xFSGNPdWtJN3l1Tm90RXNJR3VB?=
 =?utf-8?B?bWhjN0ZVams0K29kUVNqMFhadkJaWFJsMW1aUzhySFE2WHNtMXVSdEN1T0M0?=
 =?utf-8?B?N0F4Snp0ZitoZEgvcEJZV0dtUUtNUEFrczZGYStqbTIxNmZXeWJ4QVdQRnNt?=
 =?utf-8?B?dldGQktpNzNlQXNTOU1EZ1RTaDVWSTN6a2llQzhNREdWSExYSDc4MUFvd2pZ?=
 =?utf-8?B?ZU0ra2w4R20vcVdLS3ZJMm9aSlNTZnhZaXVtc1pVR2JJKzA3STd3VXBuNTRM?=
 =?utf-8?B?SnF2TFd2RHJqZGp6TW5XUDVCMWhGMmJ6M2lPNHJid0dldmgxKzJVMENKWDha?=
 =?utf-8?B?NGREUWgwSEM0YnVrbnRvQkczMFlOV1MxaGYvTnRKWW1EdlcwMzFKVDY5TjMx?=
 =?utf-8?B?YXRGTCtKZ3BLcngxaTNnTFhZZGxPRjNtQkxaY2l2Z2FreHA2Wm9rTjdJNXpF?=
 =?utf-8?B?VDNmd3JZMVVzcEREUVNZSzRBMzZxOE91dlhUVEhEMTVxUklBVzR3QmtubThK?=
 =?utf-8?B?b3diVFFMS0JKNnBUWm82YW8zUjhLUXMyNDk5T0JId0xjU21WanB2cGFjQ3dZ?=
 =?utf-8?Q?hILLgrBDFrtaoLnCBO6xJ0Jzch6m+aUtiV1+y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36E5DE979D2D3346ABD7903F1B4D08A7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uy8eHAnZCQMoUQFI0ethwqkTGuhq2OZHQWImMkzUwztVRqK8vnTjb4gFJoaEujU7ovKI/TOfwDFSnexQdFanOlKg4XtyLCwdKXSLD/lP1ohsjug/9LxUa+BQwohWT0Vh5C90XtTGFTWhfyX/Khdna5htHddcYNMDTskJPdUAjm5VwWgoGa5M+uIMoUfyO5eX7moSHFsdoCNf9xNf1wS0ednHT70WkxlasfDkJu7Rhbw1y29m4HuKMgEDrG/FABqIbELA/3HymHpZ4XWnMu9M92bYoC3g7MT2tXm0JJh2PdSpwLN+ZWvc2BJn1Q1+Br2atDBqjqC+ztQvkkHNGBW2/w==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4589825-e4e5-4c63-f37d-08de7b51da24
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 07:27:41.5278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHluLVI7/Bbeo0K2Qx89HOTWIPvalyJy3QM9/RP7uqR05o+uWTM0ppdCLHuOIRByyI2cAHcAYRyiZT+suuIGtz+AzhjhB6CrQZHmFxol9CjWD/E6S0n3OztUHFICCA6K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7277
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

SGkgWmhlbnpob25nLA0KDQpPbiBUaHUsIDIwMjYtMDMtMDUgYXQgMjI6NDQgLTA1MDAsIFpoZW56
aG9uZyBEdWFuIHdyb3RlOg0KPiBJZiBwYXNpZCBiaXRzIHNpemUgaXMgYmlnZ2VyIHRoYW4gaG9z
dCBzaWRlLCBob3N0IGNvdWxkIGZhaWwgdG8gZW11bGF0ZSAgDQo+IGFsbCBiaW5kaW5ncyBpbiBn
dWVzdC4gQWRkIGEgY2hlY2sgdG8gZmFpbCBkZXZpY2UgcGx1ZyBlYXJseS4NCj4gDQo+IFBhc2lk
IGJpdHMgc2l6ZSBzaG91bGQgYWxzbyBiZSBubyBtb3JlIHRoYW4gMjAgYml0cyBhY2NvcmRpbmcg
dG8gUENJIHNwZWMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8W3poZW56
aG9uZy5kdWFuQGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSk+ICAN
Cj4gLS0tICANCj4gwqBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAxICsgIA0KPiDC
oGh3L2kzODYvaW50ZWxfaW9tbXUuY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDUgKysrKysgIA0KPiDC
oGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuY8KgwqDCoCB8IDggKysrKysrKysgIA0KPiDCoDMg
ZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aCAgDQo+IGluZGV4IGVkZTRkYjZkMmQuLmQ2Njc0ODYxZmQgMTAwNjQ0ICANCj4gLS0tIGEvaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oICANCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oICANCj4gQEAgLTE5Niw2ICsxOTYsNyBAQCAgDQo+IMKgI2RlZmluZSBWVERf
RUNBUF9TUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgMzEpICANCj4g
wqAjZGVmaW5lIFZURF9FQ0FQX05XRlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxM
IDw8IDMzKSAgDQo+IMKgI2RlZmluZSBWVERfRUNBUF9TRVRfUFNTKHgsIHYpwqDCoMKgwqDCoCAo
KHgpLT5lY2FwID0gZGVwb3NpdDY0KCh4KS0+ZWNhcCwgMzUsIDUsIHYpKSAgDQo+ICsjZGVmaW5l
IFZURF9FQ0FQX1BTUyhlY2FwKcKgwqDCoMKgwqDCoMKgwqDCoCBleHRyYWN0NjQoZWNhcCwgMzUs
IDUpICANCj4gwqAjZGVmaW5lIFZURF9FQ0FQX1BBU0lEwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKDFVTEwgPDwgNDApICANCj4gwqAjZGVmaW5lIFZURF9FQ0FQX1BEU8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCA0MikgIA0KPiDCoCNkZWZpbmUgVlREX0VDQVBfU01U
U8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgNDMpICANCj4gZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYyAgDQo+IGlu
ZGV4IDNlYTViOTJiMzQuLmU5OWE5Y2Y5YzYgMTAwNjQ0ICANCj4gLS0tIGEvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jICANCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jICANCj4gQEAgLTU1NTks
NiArNTU1OSwxMSBAQCBzdGF0aWMgYm9vbCB2dGRfZGVjaWRlX2NvbmZpZyhJbnRlbElPTU1VU3Rh
dGUgKnMsIEVycm9yICoqZXJycCkgIA0KPiDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3NldGcoZXJy
cCwgIk5lZWQgdG8gc2V0IHNjYWxhYmxlIG1vZGUgZm9yIFBBU0lEIik7ICANCj4gwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gZmFsc2U7ICANCj4gwqDCoMKgwqAgfSAgDQo+ICvCoMKgwqAgaWYgKHMt
PnBhc2lkID4gUENJX0VYVF9DQVBfUEFTSURfTUFYX1dJRFRIKSB7ICANCj4gK8KgwqDCoMKgwqDC
oMKgIGVycm9yX3NldGcoZXJycCwgIlBBU0lEIHdpZHRoICVkLCBleGNlZWQgTWF4IFBBU0lEIFdp
ZHRoICVkIGFsbG93ZWQgIiAgDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgImluIFBDSSBzcGVjIiwgcy0+cGFzaWQsIFBDSV9FWFRfQ0FQX1BBU0lEX01BWF9XSURUSCk7
ICANCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsgIA0KPiArwqDCoMKgIH0gIA0KDQpJ
IHRoaW5rIHRoaXMgb25lIHNob3VsZCBnbyBpbiBwYXRjaCA1LzEzIGFzIGl0IGlzIG5vdCByZWxh
dGVkIHRvIGFjY2VsDQoNCj4gwqAgIA0KPiDCoMKgwqDCoCBpZiAocy0+c3ZtKSB7ICANCj4gwqDC
oMKgwqDCoMKgwqDCoCBpZiAoIXg4Nl9pb21tdS0+ZHRfc3VwcG9ydGVkKSB7ICANCj4gZGlmZiAt
LWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXVf
YWNjZWwuYyAgDQo+IGluZGV4IGFjYjFiMWUyMzguLjE1NDEyMTIzZDUgMTAwNjQ0ICANCj4gLS0t
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jICANCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdV9hY2NlbC5jICANCj4gQEAgLTQ0LDYgKzQ0LDcgQEAgYm9vbCB2dGRfY2hlY2tfaGlvZF9h
Y2NlbChJbnRlbElPTU1VU3RhdGUgKnMsIFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2QsICAN
Cj4gwqDCoMKgwqAgSG9zdElPTU1VRGV2aWNlICpoaW9kID0gdnRkX2hpb2QtPmhpb2Q7ICANCj4g
wqDCoMKgwqAgc3RydWN0IEhvc3RJT01NVURldmljZUNhcHMgKmNhcHMgPSAmaGlvZC0+Y2Fwczsg
IA0KPiDCoMKgwqDCoCBzdHJ1Y3QgaW9tbXVfaHdfaW5mb192dGQgKnZ0ZCA9ICZjYXBzLT52ZW5k
b3JfY2Fwcy52dGQ7ICANCj4gK8KgwqDCoCB1aW50OF90IGhwYXNpZCA9IFZURF9FQ0FQX1BTUyh2
dGQtPmVjYXBfcmVnKSArIDE7ICANCj4gwqDCoMKgwqAgUENJQnVzICpidXMgPSB2dGRfaGlvZC0+
YnVzOyAgDQo+IMKgwqDCoMKgIFBDSURldmljZSAqcGRldiA9IGJ1cy0+ZGV2aWNlc1t2dGRfaGlv
ZC0+ZGV2Zm5dOyAgDQo+IMKgICANCj4gQEAgLTY0LDYgKzY1LDEzIEBAIGJvb2wgdnRkX2NoZWNr
X2hpb2RfYWNjZWwoSW50ZWxJT01NVVN0YXRlICpzLCBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9o
aW9kLCAgDQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOyAgDQo+IMKgwqDCoMKgIH0g
IA0KPiDCoCAgDQo+ICvCoMKgwqAgLyogT25seSBkbyB0aGUgY2hlY2sgd2hlbiBob3N0IGRldmlj
ZSBzdXBwb3J0IFBBU0lEcyAqLyAgDQo+ICvCoMKgwqAgaWYgKGNhcHMtPm1heF9wYXNpZF9sb2cy
ICYmIHMtPnBhc2lkID4gaHBhc2lkKSB7ICANCj4gK8KgwqDCoMKgwqDCoMKgIGVycm9yX3NldGco
ZXJycCwgIlBBU0lEIGJpdHMgc2l6ZSAlZCA+IGhvc3QgSU9NTVUgUEFTSUQgYml0cyBzaXplICVk
IiwgIA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPnBhc2lkLCBo
cGFzaWQpOyAgDQo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7ICANCj4gK8KgwqDCoCB9
ICANCj4gKyAgDQo+IMKgwqDCoMKgIGlmIChwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4o
cGRldiwgJmJ1cywgTlVMTCwgTlVMTCkpIHsgIA0KPiDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3Nl
dGcoZXJycCwgIkhvc3QgZGV2aWNlIGRvd25zdHJlYW0gdG8gYSBQQ0kgYnJpZGdlIGlzICIgIA0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAidW5zdXBwb3J0ZWQgd2hl
biB4LWZsdHM9b24iKTs=

