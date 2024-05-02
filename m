Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BED3C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNY-0003o3-72; Thu, 02 May 2024 11:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNW-0003ml-As
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:46 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNG-0005z0-Bv
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663770; x=1746199770;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gouuSI73YO79A3pxghx3VxnSjCaNE4VgvnGoPug7hsY=;
 b=gPsT8bXMFMBjLqgHzeAEaS5dqVM+Ij7ftldqAV/qRIHed0TEcjKHlPs9
 liZmsyQoHx/f3YO3HZ5vIjITnLXsm9bR82oJtOEE1NAAEkobnaKS0muYY
 R4c3ovOsVSKgOvVJxT9fgzW+jciXPR6aIB9isij68DQ0GF5dfA0ws4jwr
 SMAC0v9V/N0MQxMkjp8DZPKa+PzBfpVlRalf4Y7Tk+5lrhCQNETuqS3Ls
 BR1LNu40DDIqybBOoRmZA61hknOwEbYe6lvcBzRB+BwousOdFgdl9BMLX
 D8LcIwEc7bldjcXEsr15DCevCazmwOOpHsNSbRDWeotq0kbveeqOfcioo Q==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785877"
X-MGA-submission: =?us-ascii?q?MDHNQtB7hKQPhwM+Z9nxgpLMQvBBJkJCDhA5/1?=
 =?us-ascii?q?ku24GH7I+HEJmd1fpC8RZHTBlWR8qGbzGph4Ux6FSd/uqDw44A+kgizp?=
 =?us-ascii?q?HogMpNjPa22HyYWcUsizlL6hQ/hVZyNjJki/+3cI4Z7TsqpVMduw2Evn?=
 =?us-ascii?q?YLXprip315wkUCmG6a6k/p/w=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6ADbNN6/JcKUadYJWqEhZ8ppvGHFXlPHtorhPAp2fgUkX57ZO1kwUdVUEyf6O9yo6lwIoJxAlLuVxs9dvMFdHkvenC1mQyx4wSYA57gfvUOfpHAqbk3JlwlkFtjk19eRNyTOs8+/H/2jx/1ztTJuM8ecr5L0Unxo+/JqaXJk+nXpVuI1LJffaNglLF+cPT7GfDNkSoMe5ao83DKTjITp+FvwhgnO4jVqD8V/DsuCI325GiEvHfjjQR8LpEd7V1b99jQGOv24GtEDEpG/j01T6JqcfKHeKWqsLGthXVgF9aaofndID6RJ9YAjIZCy3fMoBlaxCRz2Rwdpa3tJEpPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gouuSI73YO79A3pxghx3VxnSjCaNE4VgvnGoPug7hsY=;
 b=NvJT7gnnwMIEWJPo4GZXBaSDQF5mkTmaFlijPkbBSJeTs22ZzVL2TcQVfHJmCIOnBwOTfHeGUYJqObPHGzj8RyzsTxDeY8eVZcraLWu/RoHGgbcrGhPt6bZPMobU9lCwLKDViXY03MAeqwn70YOY9M7qmzuF3DC79xA7Tx0UxEAVg2eK6a8vuFDokYtdpTwFU3dbX/NZEyG9CZRJyBOVu3gl0tR0tpxlvg6FWNkoIT+aMXXvlzpwDrximEKbcMTXJ+AI5WC/cssz8LVvCFjfuIkB/effCS7D+4FpMYAnzVSzJ11xMQC095Y1rUJKdaoXJcJ+ZhhUMaPS4Mo0WZfsiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 04/24] intel_iommu: set accessed and dirty bits
 during first stage translation
Thread-Topic: [PATCH ats_vtd v1 04/24] intel_iommu: set accessed and dirty
 bits during first stage translation
Thread-Index: AQHanKV/mhjM4ak/Ekuu9if0HXvkSw==
Date: Thu, 2 May 2024 15:29:17 +0000
Message-ID: <20240502152810.187492-5-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: e0a055a6-711e-410b-e5c7-08dc6abca189
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bzc2dFlUdDBtdUk5SGNDb0ZDWDBLM0FsZnRjbDB3a2poUG9McHkzd1BNV1Zo?=
 =?utf-8?B?WnlaUTNRb0lTcTh3bkE2N01KTFlraDdZTnU2UVA3SmNweE1PMnFibWMycjNx?=
 =?utf-8?B?eHlROXlUY2NmdkhBMUpTSXVNbnBWdTVOYTBzVitWc3YxTU1MYytydXRrWXVm?=
 =?utf-8?B?d1JESStmMjRUVEtpbVNnWVphTXZuSXZxL29UN2FsbTU2Wkh6a3VjYXRxcWNO?=
 =?utf-8?B?RVh2a2xDZnRUMVRQZWFPU1VqaTAzaVFxQ2Z3b1RaOC9INkJidlFvNnkwSXY5?=
 =?utf-8?B?clFkZ3ZYKzhDVlF2WFR1ODdMTzZKZU0wR0FZWTJVSjFlbktRMXYrdHFTMjVr?=
 =?utf-8?B?dWJXMWhQTmh4bmVQclV4Q0pwbUNCd3NVNy9DcFNRUnhjQ3hWNFZDUHQ4Zm10?=
 =?utf-8?B?UUZJQjgzUWRxVnRZMGUvdUZHMUdRa2JaRGhZNmdOeFhMeG9qMGltZ0FvZG0x?=
 =?utf-8?B?bXRraDYzd29OcnVpek95OHl6aE8rVW5aZHUrV0RNWHNhUENZZ0FJQ1k3MWsy?=
 =?utf-8?B?SmNmMFAwTmpWMHpOcWY4T3RqU09Fbmh4M0ZqcE83cWF5RTNTOGdHSDRBMkEv?=
 =?utf-8?B?U210NW8rS21nb0pJSGQvaXVDOHZFbzdVTkNTQlltWFRGQ3h2MmozcWtremxW?=
 =?utf-8?B?dDJQY0lUekFla1VlL29SaVAvRW5GdGZoeWlOUGw2RE9NK2FnV3lsNHVxUzVv?=
 =?utf-8?B?WW1XbFV5QkRyczMwTzdtcEJONTh4ZVdaZ1dON1pGZno0c2tGZTVoc0VDN21W?=
 =?utf-8?B?RmtnbEY2OGpjdnF5M3JkbUF6eUJIRnBIUFFTdWZNeWhyS0lSVm80NEd3dlJY?=
 =?utf-8?B?SFIzaGgwSEcvYkFpdzgrd0d0UStJeExJV3BJaFI2Q3p4TFRpbXl5SFZaa085?=
 =?utf-8?B?b25vbTNnTzI4QitmYTNRQ054OE43dmpwN1piZ0ExRDdMN21yM1hXK3JnZURU?=
 =?utf-8?B?bnE4MWoyb0hSYzhPcmFYRWRvdHhEbTlFZjRMd21MTG1WeklXNGVqTDZqWU1a?=
 =?utf-8?B?TWZ0YlBKQWltajEwUStHL1Q2TFZrT0VnSGQzWW1iWTFOajRqUytwU1ZtRTd6?=
 =?utf-8?B?Y01pZjV0dU1yQ2xRZjQxZVVweFFLSnJuazMvR3lvbUtNeFdzV1E0OTU3bjVy?=
 =?utf-8?B?QkhuWGZ6am9ud1lYWmF0ZXc0NHg3bU9UVEgvUCtUaEFIanRiVjgvQUZYL3B5?=
 =?utf-8?B?VUJ2TGtZTjFWVXlPNEVOVVNmRk9sRFN4S1g3ekQ1ZEZtNzBJNTlNWHBJTy9h?=
 =?utf-8?B?YjVQWFhuRm4zb0ZBOVZyQzAvRFNtcGN2VkgzaWtiRW93MkhPcHRtby9xNDd0?=
 =?utf-8?B?ckxmSVNJVnRYMlVxRU8vS1RSS0FVTU9ZbzNHR1ZGaDIxQTVBZzdkNFI3Njh1?=
 =?utf-8?B?SXdVcjQ2c3VhcU1rNk5vMENvWURnRjdYTm5INkROTzRJRis3SHlOWU9ISmRK?=
 =?utf-8?B?Q1EycndyRmloV0lxVk9zdnl3T2VVclJrMCtoazhKSzVWMzA3UnV4QlU1RVZi?=
 =?utf-8?B?QnBtQmFnMjBiL2NSblJKT1RsR0dPejRCQWFycmpna1czWWQrYmRsQzgvQjdv?=
 =?utf-8?B?bUVkVnZVeWlqM014dW5CQ0R1b2xINTYrMDVvdk14NC9Pcjgyb2Y4am1BQXl4?=
 =?utf-8?B?c1NERERuK25IZ3dBbE1LcDFPTjRKV1NBNmFuL0ZaRWpSQzNXY0g2UitZZzBn?=
 =?utf-8?B?M29EWmM0Ymg3ZjRMZUEzNnJZRkpTNGFLVk5vWEV5SUllMjkxb21FaW9JWVly?=
 =?utf-8?B?REVyVEU3STZ6VzRXcFpFbmpKSTBWdWdDV3k1YjArbDh1dWZQZUNEUlJZME5O?=
 =?utf-8?B?L005aWhLZ2o4NXNjZmplQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUlZclJPaTZNQ2FpZWxaRXltQUJCT3JkakovcmhoK0doQVViZUZ3RVQycGZE?=
 =?utf-8?B?MkhBYnhjeUVUSTFUcG16UmlFczZwZ3NKNlRxbnBZaTNmRjVSM1Y0WjZXWVdG?=
 =?utf-8?B?Y1lFcEpPV2M0QmdqSzU1SERPdnhtaE4rRTNPVFh1SFZBaWtUUmVzcWh2OUgz?=
 =?utf-8?B?VFhEbDExZTNXUlZGdmIxY2dOS3N6T3hxZkxXMkg0aUpxdVgzeGxDWTcwWktz?=
 =?utf-8?B?d2ovdmtXL0JNTVFNWmgzQ2JYOEc0enROcW9xS0ZvOEkxaEg1SzlkMFYvZ2ZX?=
 =?utf-8?B?aVpoMzQxbk02UGR1RDhma3oydFcvbXJibkNrd1lPRnZqekRzOHF6Mys1YTVo?=
 =?utf-8?B?TlYrT2dDS1hSS0RlaHZqbU1pTUVQM2Z1aitzbU5hNHFIOVMxQy9XVDRDZncw?=
 =?utf-8?B?cUlvckJTbm1aRHhyUVdLQVlmNksvVUV1MjVDaDZQU1Z4Y3RZbSt3TUwwendk?=
 =?utf-8?B?U3JDR1Q3QTh0ajd1clRjZHg1b3BxazlnVmt6OVc2OHJSTzBtYy95YWFRQTh4?=
 =?utf-8?B?NFdvRkRIME1RYjJKSU5vUWJRQ2xVY2ZDT2hDSXlqZTE3cktuUXY5Vy9nM1Zw?=
 =?utf-8?B?aVoyOWt5cEIyUTN3YkVxZGlycnFTbUVNOGIrTkVWcE5YNGlYbHY3OWRWYzls?=
 =?utf-8?B?SDdobDNOV3I2R0Y5WWFqSHNOZDl2QjBkZm1TcXRZQ25EVm94RnZwRTFRVmF4?=
 =?utf-8?B?dWlRakVFclRvNkZ5UmY1aDJjUE4vWnVyZUVHd0hZK0RRQWV4TWFWWXJkN3Rn?=
 =?utf-8?B?aWRkVVNwL1RBTFFYbW16cU5yZFBQREhWNGFERks4STJuSnlJb0gzenFaRkpM?=
 =?utf-8?B?bUFGRE9ZUHcxVEs4WU9MYmI2NFBUVTNvTHNqZ3g2YWFPSEVxRjllcExPMFcr?=
 =?utf-8?B?NzdpU2FxYjFoUElyNERpejk2cCtocXUxdFBNVU1rZ2ZJSHdVYjFtSjlYbDUv?=
 =?utf-8?B?ejdCQWpwWmt1L0Y1WnJ6Sm9XMzhTRmtIMDkxcUdjQkVNa1hpVHc0cHhTV0hJ?=
 =?utf-8?B?OUlSd2UydjB0Y3NUcHdCcmhqdkp4SjlkRXJTQmVPMXpIaVQwRFNnOEsrQmtB?=
 =?utf-8?B?R2IxM2lJOTdONE1OaHpzRkNMS1FvUk84Y1BWcHlwc1duVXBxWXlxOTRUUWNY?=
 =?utf-8?B?bGUyRzl0YlA2RGpwTG84SVJ4SjRBdTBPc2FiS24wd1o5RkJxUUhuVXFpamox?=
 =?utf-8?B?Sk1YVnFLKzA1UnpjKzhTUXBxb2UwaTN4Z3VaenFHVHZlNHlkRjFoVWNZVGtm?=
 =?utf-8?B?akZnTnVVSVFLczR3TTRraFg0VHFYK2JiVytvNy9GUUtNc29lRjgwSkR2OEVP?=
 =?utf-8?B?QkxuYkNKZjRwcTZGbGpZelJTQlNoanJKK3pPRUFvQ0JXdFIrcHVwa1BaVTZH?=
 =?utf-8?B?RzdJTFFFNVRTMmZiT1NGYnpYMWhKK2ZZTVdzZlN4TDJzTnAwMndoS1FkQjly?=
 =?utf-8?B?bVRVUHhSVkN0Tjg1Yk9VT1pqOEZ6dDdWRVBnQk5WSXhCVytWVmFLVGh4THdp?=
 =?utf-8?B?R1l3WFFjNW9yRVpkVWZRR0x0SmtYMWxjRVY3TTE2dmVRaWpjV21jUGZyeUNO?=
 =?utf-8?B?SDFDSzRob0kvSllscU5CK1ZLWGFmUG04UE9GNC91NDZWTDE5dENRVHM3dWp1?=
 =?utf-8?B?Ry9XSjBHSWZXSVFvM0VpdDI5V0pZZEZKeTBycGN6T3J0aUpJejkxczM3S3VR?=
 =?utf-8?B?R09YRkxwQVRHYndvRE9MOEhGbDA0aGNNNXVTdi84eFBmeVFUNEhuM0xhbGNa?=
 =?utf-8?B?UXorRk9UVFNiUG1yMWlHbTVVYmNCaThVamhOSjA0bUNybHBRMFdmbjh6WXBR?=
 =?utf-8?B?Tkx3Qnl5d0tlMCtnNnpKVlhXdzZkb1N1VmdtYjlaS2xnMDBSejNtbDZOREVB?=
 =?utf-8?B?bUVEZUszN05KaG5QRnJVR0xnYmE0Yzg4WTgxbXlKWktIOGpmZyt2U3JSYmx5?=
 =?utf-8?B?TXFXWlNaUFVuQndGazc1N0JsaUd6U2VWSm1yalBrOVppVkRJd0gwbjFsb0xI?=
 =?utf-8?B?aVdOdnAzUjFQQmQ2enluUzlmMTFZM2VNN0FsNFlIdXQzdXVob29kWHF5OUJW?=
 =?utf-8?B?cFlGYzNGcVo1VWVmMzFnRDJxbk5PcXR2K1lOcHhMQnpsMFJ2THpwaHNOKzRr?=
 =?utf-8?B?RlN1L1FNdUFPcXZOUWlBSWJXSEl2cVdvOGZ5VXdKeHp4Ylo0YXVrYkUxUEts?=
 =?utf-8?Q?GnGHzTpWQ67fkF4cEoWotlE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C77485D8274C124AB2CA97CCEBC6A788@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a055a6-711e-410b-e5c7-08dc6abca189
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:17.5817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eO5s+VL9VErq2nP3qHlVrJgn0mDriQskyfOc4HtB6K89IbiV+6SC4tvBicYwHB5ePqkFsmsYUBBu7cprPGSvBbd/opD4pEPglMtR+K8tRqW9p79ClBPhMUs910KHGmj8
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
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAy
NiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaCB8ICAzICsrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZm
IC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpp
bmRleCAyNDBlY2I4ZjcyLi5jYWQ3MGUwZDA1IDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC0xOTEzLDYgKzE5MTMsNyBA
QCBzdGF0aWMgY29uc3QgYm9vbCB2dGRfcXVhbGlmaWVkX2ZhdWx0c1tdID0gew0KICAgICBbVlRE
X0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOVl0gPSB0cnVlLA0KICAgICBbVlREX0ZSX1NNX0lOVEVS
UlVQVF9BRERSXSA9IHRydWUsDQogICAgIFtWVERfRlJfRlNfTk9OX0NBTk9OSUNBTF0gPSB0cnVl
LA0KKyAgICBbVlREX0ZSX0ZTX0JJVF9VUERBVEVfRkFJTEVEXSA9IHRydWUsDQogICAgIFtWVERf
RlJfTUFYXSA9IGZhbHNlLA0KIH07DQogDQpAQCAtMjAzOSw2ICsyMDQwLDIwIEBAIHN0YXRpYyBi
b29sIHZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nhbm9uaWNhbChJbnRlbElPTU1VU3RhdGUgKnMsDQogICAg
ICAgICAgICAgKTsNCiB9DQogDQorc3RhdGljIE1lbVR4UmVzdWx0IHZ0ZF9zZXRfZmxhZ19pbl9w
dGUoZG1hX2FkZHJfdCBiYXNlX2FkZHIsIHVpbnQzMl90IGluZGV4LA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IHB0ZSwgdWludDY0X3QgZmxhZykNCit7
DQorICAgIGlmIChwdGUgJiBmbGFnKSB7DQorICAgICAgICByZXR1cm4gTUVNVFhfT0s7DQorICAg
IH0NCisgICAgcHRlIHw9IGZsYWc7DQorICAgIHB0ZSA9IGNwdV90b19sZTY0KHB0ZSk7DQorICAg
IHJldHVybiBkbWFfbWVtb3J5X3dyaXRlKCZhZGRyZXNzX3NwYWNlX21lbW9yeSwNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYmFzZV9hZGRyICsgaW5kZXggKiBzaXplb2YocHRlKSwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJnB0ZSwgc2l6ZW9mKHB0ZSksDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQpOw0KK30NCisNCiAvKg0K
ICAqIEdpdmVuIHRoZSBAaW92YSwgZ2V0IHJlbGV2YW50IEBmbHB0ZXAuIEBmbHB0ZV9sZXZlbCB3
aWxsIGJlIHRoZSBsYXN0IGxldmVsDQogICogb2YgdGhlIHRyYW5zbGF0aW9uLCBjYW4gYmUgdXNl
ZCBmb3IgZGVjaWRpbmcgdGhlIHNpemUgb2YgbGFyZ2UgcGFnZS4NCkBAIC0yMDgwLDExICsyMDk1
LDIyIEBAIHN0YXRpYyBpbnQgdnRkX2lvdmFfdG9fZmxwdGUoSW50ZWxJT01NVVN0YXRlICpzLCBW
VERDb250ZXh0RW50cnkgKmNlLA0KIA0KICAgICAgICAgKnJlYWRzID0gdHJ1ZTsNCiAgICAgICAg
ICp3cml0ZXMgPSAoKndyaXRlcykgJiYgKGZscHRlICYgVlREX0ZMX1JXX01BU0spOw0KKw0KKyAg
ICAgICAgaWYgKHZ0ZF9zZXRfZmxhZ19pbl9wdGUoYWRkciwgb2Zmc2V0LCBmbHB0ZSwgVlREX0ZM
X1BURV9BKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAhPSBNRU1UWF9PSykgew0KKyAgICAgICAgICAgIHJldHVybiAtVlRE
X0ZSX0ZTX0JJVF9VUERBVEVfRkFJTEVEOw0KKyAgICAgICAgfQ0KKw0KICAgICAgICAgaWYgKGlz
X3dyaXRlICYmICEoZmxwdGUgJiBWVERfRkxfUldfTUFTSykpIHsNCiAgICAgICAgICAgICByZXR1
cm4gLVZURF9GUl9XUklURTsNCiAgICAgICAgIH0NCiANCiAgICAgICAgIGlmICh2dGRfaXNfbGFz
dF9mbHB0ZShmbHB0ZSwgbGV2ZWwpKSB7DQorICAgICAgICAgICAgaWYgKGlzX3dyaXRlICYmDQor
ICAgICAgICAgICAgICAgICh2dGRfc2V0X2ZsYWdfaW5fcHRlKGFkZHIsIG9mZnNldCwgZmxwdGUs
IFZURF9GTF9QVEVfRCkgIT0NCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1FTVRYX09LKSkgew0KKyAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1WVERfRlJfRlNfQklUX1VQREFURV9GQUlMRUQ7DQorICAgICAgICAg
ICAgfQ0KICAgICAgICAgICAgICpmbHB0ZXAgPSBmbHB0ZTsNCiAgICAgICAgICAgICAqZmxwdGVf
bGV2ZWwgPSBsZXZlbDsNCiAgICAgICAgICAgICByZXR1cm4gMDsNCmRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCmluZGV4IGU5NDQ4MjkxYTQuLjE0ODc5ZDNhNTggMTAwNjQ0DQotLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KQEAgLTMyOCw2ICszMjgsNyBAQCB0eXBlZGVmIGVudW0gVlRERmF1bHRSZWFzb24gew0KIA0K
ICAgICAvKiBPdXRwdXQgYWRkcmVzcyBpbiB0aGUgaW50ZXJydXB0IGFkZHJlc3MgcmFuZ2UgZm9y
IHNjYWxhYmxlIG1vZGUgKi8NCiAgICAgVlREX0ZSX1NNX0lOVEVSUlVQVF9BRERSID0gMHg4NywN
CisgICAgVlREX0ZSX0ZTX0JJVF9VUERBVEVfRkFJTEVEID0gMHg5MSwgLyogU0ZTLjEwICovDQog
ICAgIFZURF9GUl9NQVgsICAgICAgICAgICAgICAgICAvKiBHdWFyZCAqLw0KIH0gVlRERmF1bHRS
ZWFzb247DQogDQpAQCAtNjQ5LDYgKzY1MCw4IEBAIHR5cGVkZWYgc3RydWN0IFZURFBJT1RMQklu
dkluZm8gew0KIC8qIEZpcnN0IExldmVsIFBhZ2luZyBTdHJ1Y3R1cmUgKi8NCiAjZGVmaW5lIFZU
RF9GTF9QVF9MRVZFTCAgICAgICAgICAgICAxDQogI2RlZmluZSBWVERfRkxfUFRfRU5UUllfTlIg
ICAgICAgICAgNTEyDQorI2RlZmluZSBWVERfRkxfUFRFX0EgICAgICAgICAgICAgICAgMHgyMA0K
KyNkZWZpbmUgVlREX0ZMX1BURV9EICAgICAgICAgICAgICAgIDB4NDANCiANCiAvKiBNYXNrcyBm
b3IgRmlyc3QgTGV2ZWwgUGFnaW5nIEVudHJ5ICovDQogI2RlZmluZSBWVERfRkxfUldfTUFTSyAg
ICAgICAgICAgICAgKDFVTEwgPDwgMSkNCi0tIA0KMi40NC4wDQo=

