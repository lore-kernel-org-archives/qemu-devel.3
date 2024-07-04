Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129BCC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 04:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPE0A-0002gV-Gk; Thu, 04 Jul 2024 00:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPE09-0002fc-35
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 00:23:21 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPE05-0007qA-40
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 00:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720066997; x=1751602997;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ddMGirky6PYzv2aRL1PRLU5Tt5QY2G3LsrhgvuiBQ0c=;
 b=EZiaL+6EMc5wa3L/b90YeUPjZ0HSInZLnwds1Tue5ohvoBmi2/dylGwO
 a/8IErmx+Eeb7Chnt0Gqbow6ZT3GYaoJOQXk9es5rW8YPtodCW/R5xX/k
 cNalIp3hS/FCE0dzvqlS5KURUisRQmsQaVG2M9dJaeei8U62bFMjBiP/1
 KK+5Mm5szOSJHmjN5NzbXeIy2CkkXqb+bB7XWn38ZVGDu1SmzzGlryU7a
 oYSi1wutp9RIMwh4DFEAoRr4OWOJSOWI36bRup+yCYGCSwQn69HJ1rXJp
 yVTXBkW0Jrfqpf7lY0uJUWjw6xPF3Baoned9fgV2KrAJNHzSIx5wuW4mP A==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="15865276"
X-MGA-submission: =?us-ascii?q?MDEVhEq3YiWVO7bxpuzi9XYFHCyRUziXBZPdUc?=
 =?us-ascii?q?Mxv3Rx/S5RtD/ck/jKBdm7FUQdFoYR0Ec5F7/BgCf84BvihZk9tPLqAK?=
 =?us-ascii?q?Or/18qeeNPmf6BiKWDLKOec+XUqXVGR+xUuiuzKdKjah/wvLr1On1t9q?=
 =?us-ascii?q?1wTjoBSWnrvH9KqtJLppt4XA=3D=3D?=
Received: from mail-am0eur02lp2237.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.237])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 06:23:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bC7B6PhKNGm7kbbpynzflLAMFfWZpEJZhCYrQMJ9xI2gxB9rtGOroFCl9vA/ZpsYdHZFv7WWS5T0wDQEf/fZnr38ewoN3LfzOrJZra8tgfJTAK3GeK2k1kefFNHFJ0FNBZZhR1+Y2boFajBEDcguHKPQevmnN/YRCLzlSzzZ2qcvDDbg37kY973QYJQlQRDiQaEdsgbjF37l3kq3Papa7f6tm5LLpkvfB/FG788LJe3XgLPtYl8uHHkaPs4z/t8utJj8aJzXu7AAFxoQxXL63wRIY7sPYh4tiDDYtUojHWlGuhmMDTA12ct2BAFOvecAddE/W91ofTgTCxzpQgZwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddMGirky6PYzv2aRL1PRLU5Tt5QY2G3LsrhgvuiBQ0c=;
 b=PvZVIaliLS+03VhD1aEF/kAeTyWIDoSHwyuGBdBRUIvVCsduYtpVAbKmEQJzBtHvREAzQ4PFARC7n05Jh4t++C5LAvgvil+1udmodgd+CpueocZRU8RCTrcSP4flsq17/LR/DdnvgFOcL6dc1pHcUFhl3EW63qX/dVLJUMyUIR8pt1Kp8ZUzIY+LyoMJhUp5n3WKckBIW7p5DvyKxkbvUY45IZAC6n7n/WDhhm3ATfG1oa3GiVi8Axn6ntEhpIVdASKJT6eJtS2G9mR6nOF825pyezaWLb4arni5YVu9jeDkfpnEp8Y6n8SVBCnaMJlKHefk/OxT+3Qg+x/k+7zv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddMGirky6PYzv2aRL1PRLU5Tt5QY2G3LsrhgvuiBQ0c=;
 b=Jp12js89QBjQxso1wyfVncDAlAY+n2XdR2GvGehhlAZSU7J+X8bRjmGRqb0+LapFvaOWUrkPi5eWA58Jx3bjLanwqV37HvJABwa76n2lqxp3aH5+sOT5CxjLjxA/QaIIsfQnU37Tu3wyb2LdpOFZ1LQvFGGyH/w+lUTUXfC/JT17avEplG4lN1E/VmN8jBTsyd214Tm4VEj1neoQlsB/P/QYBPexajAQnnCQdTPyRdHKh1MOD/pzM+ygimCG6oE9Cuav0SbFoB9Jdqdn0eVDqndkzvclddIX4/ikzjSTuM92y9fD0mzDoQdvzakACQpBHscKcdKWP8oFCJAifkmYfw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8636.eurprd07.prod.outlook.com (2603:10a6:10:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 04:23:10 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 04:23:10 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH ats_vtd v5 03/22] intel_iommu: return page walk level even
 when the translation fails
Thread-Topic: [PATCH ats_vtd v5 03/22] intel_iommu: return page walk level
 even when the translation fails
Thread-Index: AQHazEQIX64drBolXUuuM+UyOsesILHk6FwAgAES3QA=
Date: Thu, 4 Jul 2024 04:23:10 +0000
Message-ID: <7874ac68-a259-4da7-942d-14ab3bb34364@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-4-clement.mathieu--drif@eviden.com>
 <6186faf8-7855-41c4-add2-1bb7860c2cc2@intel.com>
In-Reply-To: <6186faf8-7855-41c4-add2-1bb7860c2cc2@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8636:EE_
x-ms-office365-filtering-correlation-id: c8b5c9e6-27c3-4fd7-0396-08dc9be10347
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bWpsNStKOVJWQXBuVUxlamdEc2hnNE5rTE9aZHBGUk91aDhuQWYwbnpzZ2pB?=
 =?utf-8?B?Mm5MTzhJRnQzbWdRVVJ2STNEQTNIZExRUi9ZQThZUTdpNnFsVXUwbnNDMlJh?=
 =?utf-8?B?NWRJMkpzMkZlUldvQ0wvc2NYcVVPZldTQmE3RmFaOWNjQlBibmxlajhCQzQ3?=
 =?utf-8?B?SE5PQmFjVjhnMmMwMFFYeVowRVZSME0rejlSMXR1eGNPdkVnTENnOGIyU25R?=
 =?utf-8?B?MlJobjVhTE5CQ3ZERDdCWmxQdHRoa21xcmRCbkl3VmRMbFpRYy8wSlJFeTNN?=
 =?utf-8?B?MThDcjVoT3pmakttSGpDZUM4NHZGZkpsSUJmUzJhbm14SG9qMlROZVhIa1VU?=
 =?utf-8?B?OEtnKzB6T01sUllJR2JHQVloRmk2bXVvRjhsNmNOTFBTdHQ1U1E0eHJDSmRJ?=
 =?utf-8?B?UlFvRnpTMkwvTS9TVFh2NzFCN3FNTzRtRERWWXdJUXJIdTdka3FoWUt6UW5o?=
 =?utf-8?B?Mno4QkxjTXFvR2pTQ2FBMVFGM3o1Y0FyemxTLzdLRDZLcm93b1ZaT3lJcU42?=
 =?utf-8?B?ZDZ4OFBRR0hzVVZLaGdHZ3krenl6VmZpWW9PVUNhYlM4a0x1b3I5Y0FDZDBq?=
 =?utf-8?B?ZmFHdVpIK2F1ZGFiOVM5K1QrS04wb0xGZk5pNHI0bTNMMXhRMzBTT1NsNm1U?=
 =?utf-8?B?UUxMSWR5ZGdlZ0pUZDJ4YThsN3psYVVaajhlUmtmTjFtcCt5NUpxVUhVRGFF?=
 =?utf-8?B?SzVDMDd6bjV5TWxJMU11TlF3R1J5NkpUOVp2c1RiQlNiOHVPL2pzWU05REVS?=
 =?utf-8?B?b0tSeTEvZW9neFdIaFpuL3JsUEhKMnI2VmVmZmUxMStJMFJCa0ZtQlp2azZk?=
 =?utf-8?B?UFB0K1RMQlFCWjkrcDhBUkhyVllPRmREU045TCtYRFZKZnU5UTNLMjdrTFE4?=
 =?utf-8?B?RmVDNUt6bVNiK2Y3S0JRVDlRbTNoK09qM0lYOHhYK0hkVXVPaGY1MHNpaDFF?=
 =?utf-8?B?YlVZbU4yZXBWRmVEdUg3SUYzTDcrb2pIdERTSHFiRXlOTWZsalFzWi9vbXlY?=
 =?utf-8?B?R2F1dFJaZlRIZnFDVnVMMFJDZi9uOFdIajU1T1AvLzJueDVYMC9sRkJSSFlj?=
 =?utf-8?B?YmlGK201WUxEWE5RM2ZqUDdjKzYvNk9hTVhuYVR1ZzFxeFRZRENLbTRvUkth?=
 =?utf-8?B?SFVtekxqVjdrb1BHVHd3SXRta2plVlJVRzByMEcyblNJbFo2SHdnbEcveE9u?=
 =?utf-8?B?T1YyZFl2ZWFTVUptSm1IUFFZSklCZFV3UG1HcGNnYnB6OUMxaHoySk4xdXpw?=
 =?utf-8?B?Vm82MWVkZjFTd0tCcFRPckMxUkgyR2dLM3NXb2lZQ0ZCai81eXdxWFpucHJl?=
 =?utf-8?B?bFVhT3k4LzNkZzllTDhPSVp2QTlLT0swUzA1K0pzZlpreTNRK1JkMENEczJl?=
 =?utf-8?B?OUE5eFVMUHNseU50S2wxUzR6eVo5TmswamtTWGZjck1JV1hNNTNCUTJwNGtM?=
 =?utf-8?B?K0R0R2RjL0RHU2pkT01KUlFWZkUzZ21kM2VjL0U1dWZjM05zUEFsOGI3QUc5?=
 =?utf-8?B?U21La1NHMGpiVCtiY0FLUVNCbkUrcVNaTmtyQ05WclEwbGl4bVVBZEZ3QXdE?=
 =?utf-8?B?aVd2K0dQTlBoMmJVcnhEaDlLdVB5SkJhSzFJanBkMmtJUENXd0Fqd1RBY2lr?=
 =?utf-8?B?cDRTdVlja2ZkWmlDbTl2alNtWkxlVW4vb1pIdTNnMGc4c2pUd3lDK2JlbktB?=
 =?utf-8?B?R3NKQWw3dE5iTzNZQ2lwdlRpT3FwN0N0VUxodG1TTW5tYTFvdDhRZmFSemFa?=
 =?utf-8?B?aWRKa3NBYmFCYjliZFVZSXB5L0dxU01pNXBoOS9ZT2NiRi94OVhiM2NvUzIr?=
 =?utf-8?B?TGVYaDg3WmhSOTZ1eDVTaHg0SEtPN2F4ajh4TjVIOTlxTnpwcTRPRkY1TzMr?=
 =?utf-8?B?bVJHRy81ekVEWXNyK0x5NEtXTy9yNkVma2g1WUpCa3FwOVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V25SczAvb2dIWVBqbUJGeksxMEx6T2dYOXY4UU9yYlNUZ2VKVWluTHdBMlpv?=
 =?utf-8?B?ZjcwODZhQzlXYWVacTdEa010QkhoWkRSQmpNTnBkRnk5LzZ3dXBSek0xR1Ft?=
 =?utf-8?B?TmZ0WDk4aWxhbFZmSUpFR2VNWU12Q25YUWc4Ykl6YVhNN1FUcHprM3FlaWdw?=
 =?utf-8?B?N1RPaGZiOEpNMHdXeTcyYnc0QmV3dUFGQXgvNkx6djloVnQvelhIdnlYdlEz?=
 =?utf-8?B?WWpGa2ZWcUMrdTRQUk5oSFJ6RlZjYTZQb3o0RkRNK1hSMnB4RG53aGZZLzZh?=
 =?utf-8?B?d1RXUmlxZnJkdytwN0JUemE3UGpmN3Y0MDNaWk5pYTlyL2RjNFJONHQ2MURT?=
 =?utf-8?B?bjFKUytWbCtIeVZXYzMyczNrS0w1RFBBZ1lmOGgxdTNzUlhPOWxUaml1NW5i?=
 =?utf-8?B?b1VpYjl4MllOY0NaeHRLWjhqdXRueVRTT3RsNGVVNWxWaEN2MDdmbksvZWt1?=
 =?utf-8?B?YXZmR3RoNFVDb1NrSzV1dDM2bEZFOUcyZ2ZUSVVUVlkyQ0ZWcC9YZmRHZDZT?=
 =?utf-8?B?a29rNDRhN1hQVWgzSUxLRXdjSG1WNVRMSkJZcERUQTlvRnVxdnBMME1nd01T?=
 =?utf-8?B?ZGRCSDJuckZIWlhxdHdZOUk4Uk5IL1g2K1lTOHNYR0NlSTV2SWsyRXNxQWFz?=
 =?utf-8?B?YlJaNzRMdEdNcG5PcnFuS2FTbk9HSHdGdU5ic3E5dDRubFkwZlphVmk2N05o?=
 =?utf-8?B?dlhvekRBcXFRSlNrM2xVTW1reGswMU53enRhMThRU043eWdqZkxDTkk2d1Fx?=
 =?utf-8?B?RXlHTVBweW5BeUJ2aytBUnNSa2dmMHJWMzZLdmdIVDhtUk1FVmhQSmRMOG5P?=
 =?utf-8?B?TGJMN1cwUWlQRkw3YjJnMUpmOVRNb2dJZ2xzRDFlVkk0bUoxZFRvNzRBOXc1?=
 =?utf-8?B?czZvZGpid0JoOEZySUZENlF3ZUpLaXI4UG5BVlpsdnZEMW9wcnEyejZhcWJ3?=
 =?utf-8?B?YVBpTjNETFR4ZkNOUTRXWGY5cjJuNlprRXVqRTZqVnBmV1NncG1xclRLaTY4?=
 =?utf-8?B?aXdIazN3RW5DSWRWdUUyOEVRU2Mwb1ZMZnpFSlFxUGFQdElIRlk0clNnUmt0?=
 =?utf-8?B?a3BFWGxZMWtxem5MTi80K1UzTDJtc3BjK3N2dUNyRktNMGhhSUlaVHlHM2Jt?=
 =?utf-8?B?WlQ3RGhqZ1Iwd2ZiWmtuQlJTRkF3cGxZVmU2Z2FkRldkbWJod3lJK0hiOXBz?=
 =?utf-8?B?OVVuV0Y0RGF0SHAyd1c1MEVxU1ZNdFl4ZmYxaThWR0FHcU9CRGJoMmcxemZu?=
 =?utf-8?B?dmd4TWVkdXI4WVY4LzNqcEQvSHVSSXM5UE1nRjNoL2ZwVXMyaGZMaU00RlZy?=
 =?utf-8?B?ZjdrbE9qaEJUUnRCUEtZd0FHSFZxREdFVXVTVm1ZL2hWSE80emNPUXJpbk12?=
 =?utf-8?B?R3BJdzdld0xweTcxWmd4cWF0RFJ3OStSeEJhclUrMjlCREN5T3U5VVZ1TXh2?=
 =?utf-8?B?SGpqMm5mMUx5ZlJjTXdiK1M5ajBqTnpRRllMNS81Q1B5UVQ2VTdFbGtBdksv?=
 =?utf-8?B?ZmgwcGhoQk8vZjdLU3FEOEFjdzBaRk42N2poQVBrUC9qZ1hTbkltTENscmF0?=
 =?utf-8?B?V3lmTkxuamk3aEM0dW8zODJ1RW1VcEVDNTgzNUFjWjduZSsrTk5OTXVHNVVW?=
 =?utf-8?B?djNmNlMvbmpPTE5oUjJYOUQ2Wk1icHV6Vkp5RGNxMThqS3EvRit1ejByWDQ0?=
 =?utf-8?B?Zmh4MDJBTS9GbFlGZ0d4V1lHMWFJN011MkU5OHZuOTZRWlY5cFNGVE1NSit6?=
 =?utf-8?B?U0I1QmppcGliS1dQSUx3SkE2VHZWTWowa3lWcktGWmw3UXpTRHo1b3hYek0r?=
 =?utf-8?B?NXhFanlIdTdweFZaRERCN28xVnpxa1ptdmZnUVQyUjdQcmZHUmZOVDdrNW9k?=
 =?utf-8?B?Y1Z6Mk9VZDkzbDE4YkVBS3kxZ3BRR0JxT0FHU1VGcXRVZ3pMdVdQdkREVkNi?=
 =?utf-8?B?VVFtUnp6UlpjcTBwMHBPd1NMUkROOUNsSzlHRnJsZjFnVjBKVXFwd0ZjZStK?=
 =?utf-8?B?N3d0SFpsa09mS2lseGJYSW5mMDVmOXFvMW5HcGU3bHZtdHJUZnRFVUZhc3B5?=
 =?utf-8?B?LzFxd0FaL1Q5SU1qNE96TExnRU9meXlDZDBCblZhRU5yZnFtanhzeG9YUU94?=
 =?utf-8?B?L3VYblBweG1BUWdjUUJUL0UyVWg3VDRDajlreElyTnBLRU9vMnVzMG1hL2FC?=
 =?utf-8?Q?Z6Et67kaMFP5jk8c13QmtNg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DADCD6A3B526B41A45F720163BB08B5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b5c9e6-27c3-4fd7-0396-08dc9be10347
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 04:23:10.4332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njuj89Dco4ZdkBuR3sXtvc32GZtgOVhIpuhZHJUl33jzNJaFs22gyt0Sr+egFO2hfA3gXo4hUcM8x4PaZUeCeFYC5VkMrwRKk3FZushMO/u37p7rdn5CVMgvFNHOWXET
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8636
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

DQpPbiAwMy8wNy8yMDI0IDEzOjU5LCBZaSBMaXUgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgDQo+IHVubGVz
cyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBj
b250ZW50IA0KPiBpcyBzYWZlLg0KPg0KPg0KPiBPbiAyMDI0LzcvMiAxMzo1MiwgQ0xFTUVOVCBN
QVRISUVVLS1EUklGIHdyb3RlOg0KPj4gRnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xl
bWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pg0KPj4gV2UgdXNlIHRoaXMgaW5mb3Jt
YXRpb24gaW4gdnRkX2RvX2lvbW11X3RyYW5zbGF0ZSB0byBwb3B1bGF0ZSB0aGUNCj4+IElPTU1V
VExCRW50cnkgYW5kIGluZGljYXRlIHRoZSBjb3JyZWN0IHBhZ2UgbWFzay4gVGhpcyBwcmV2ZW50
cyBBVFMNCj4+IGRldmljZXMgZnJvbSBzZW5kaW5nIG1hbnkgdXNlbGVzcyB0cmFuc2xhdGlvbiBy
ZXF1ZXN0cyB3aGVuIGEgbWVnYXBhZ2UNCj4+IG9yIGdpZ2FwYWdlIGlvdmEgaXMgbm90IG1hcHBl
ZCB0byBhIHBoeXNpY2FsIGFkZHJlc3MuDQo+DQo+IHlvdSBtYXkgbW92ZSB0aGlzIHBhdGNoIHBy
aW9yIHRvICJbUEFUQ0ggYXRzX3Z0ZCB2NSAyMi8yMl0gDQo+IGludGVsX2lvbW11OiBhZGQNCj4g
c3VwcG9ydCBmb3IgQVRTIiBvciBqdXN0IG1lcmdlIHRvIGl0IHNpbmNlIGl0J3MgdGhlICJ1c2Vy
IiBvZiB0aGlzIA0KPiBjb21taXQuDQp3aWxsIGRvDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbMOp
bWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+
IC0tLQ0KPj4gwqAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgMTUgKysrKysrKy0tLS0tLS0tDQo+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4+IGluZGV4IGM2NDc0YWU3MzUuLjk4OTk2ZWRlZGMgMTAwNjQ0DQo+PiAtLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4g
QEAgLTIwOTYsOSArMjA5Niw5IEBAIHN0YXRpYyBpbnQgdnRkX2lvdmFfdG9fZmxwdGUoSW50ZWxJ
T01NVVN0YXRlIA0KPj4gKnMsIFZURENvbnRleHRFbnRyeSAqY2UsDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qg
cGFzaWQpDQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIGRtYV9hZGRyX3QgYWRkciA9IHZ0ZF9nZXRf
aW92YV9wZ3RibF9iYXNlKHMsIGNlLCBwYXNpZCk7DQo+PiAtwqDCoMKgIHVpbnQzMl90IGxldmVs
ID0gdnRkX2dldF9pb3ZhX2xldmVsKHMsIGNlLCBwYXNpZCk7DQo+PiDCoMKgwqDCoMKgIHVpbnQz
Ml90IG9mZnNldDsNCj4+IMKgwqDCoMKgwqAgdWludDY0X3QgZmxwdGU7DQo+PiArwqDCoMKgICpm
bHB0ZV9sZXZlbCA9IHZ0ZF9nZXRfaW92YV9sZXZlbChzLCBjZSwgcGFzaWQpOw0KPj4NCj4+IMKg
wqDCoMKgwqAgaWYgKCF2dGRfaW92YV9mbF9jaGVja19jYW5vbmljYWwocywgaW92YSwgY2UsIHBh
c2lkKSkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogZGV0
ZWN0ZWQgbm9uIGNhbm9uaWNhbCBJT1ZBIA0KPj4gKGlvdmE9MHglIiBQUkl4NjQgIiwiDQo+PiBA
QCAtMjEwNywxMSArMjEwNywxMSBAQCBzdGF0aWMgaW50IHZ0ZF9pb3ZhX3RvX2ZscHRlKEludGVs
SU9NTVVTdGF0ZSANCj4+ICpzLCBWVERDb250ZXh0RW50cnkgKmNlLA0KPj4gwqDCoMKgwqDCoCB9
DQo+Pg0KPj4gwqDCoMKgwqDCoCB3aGlsZSAodHJ1ZSkgew0KPj4gLcKgwqDCoMKgwqDCoMKgIG9m
ZnNldCA9IHZ0ZF9pb3ZhX2xldmVsX29mZnNldChpb3ZhLCBsZXZlbCk7DQo+PiArwqDCoMKgwqDC
oMKgwqAgb2Zmc2V0ID0gdnRkX2lvdmFfbGV2ZWxfb2Zmc2V0KGlvdmEsICpmbHB0ZV9sZXZlbCk7
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZmxwdGUgPSB2dGRfZ2V0X3B0ZShhZGRyLCBvZmZzZXQp
Ow0KPj4NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZmxwdGUgPT0gKHVpbnQ2NF90KS0xKSB7
DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobGV2ZWwgPT0gdnRkX2dldF9pb3ZhX2xl
dmVsKHMsIGNlLCBwYXNpZCkpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgqZmxw
dGVfbGV2ZWwgPT0gdnRkX2dldF9pb3ZhX2xldmVsKHMsIGNlLCBwYXNpZCkpIHsNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogSW52YWxpZCBwcm9ncmFtbWluZyBvZiBj
b250ZXh0LWVudHJ5ICovDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAtVlREX0ZSX0NPTlRFWFRfRU5UUllfSU5WOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfSBlbHNlIHsNCj4+IEBAIC0yMTI4LDExICsyMTI4LDExIEBAIHN0YXRpYyBpbnQgdnRk
X2lvdmFfdG9fZmxwdGUoSW50ZWxJT01NVVN0YXRlIA0KPj4gKnMsIFZURENvbnRleHRFbnRyeSAq
Y2UsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGlzX3dyaXRlICYmICEoZmxwdGUgJiBWVERf
RkxfUldfTUFTSykpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtVlRE
X0ZSX1dSSVRFOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+IC3CoMKgwqDCoMKgwqDCoCBp
ZiAodnRkX2ZscHRlX25vbnplcm9fcnN2ZChmbHB0ZSwgbGV2ZWwpKSB7DQo+PiArwqDCoMKgwqDC
oMKgwqAgaWYgKHZ0ZF9mbHB0ZV9ub256ZXJvX3JzdmQoZmxwdGUsICpmbHB0ZV9sZXZlbCkpIHsN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogZGV0
ZWN0ZWQgZmxwdGUgcmVzZXJ2ZWQgbm9uLXplcm8gIg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImlvdmE9MHglIiBQUkl4
NjQgIiwgbGV2ZWw9MHglIiBQUkl4MzINCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJmbHB0ZT0weCUiIFBSSXg2NCAiLCBw
YXNpZD0weCUiIA0KPj4gUFJJWDMyICIpIiwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZnVuY19fLCBpb3ZhLCBsZXZlbCwg
ZmxwdGUsIHBhc2lkKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZnVuY19fLCBpb3ZhLCAqZmxwdGVfbGV2ZWwsIGZscHRl
LCANCj4+IHBhc2lkKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtVlRE
X0ZSX1BBR0lOR19FTlRSWV9SU1ZEOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+DQo+PiBA
QCAtMjE0MCwxOSArMjE0MCwxOCBAQCBzdGF0aWMgaW50IHZ0ZF9pb3ZhX3RvX2ZscHRlKEludGVs
SU9NTVVTdGF0ZSANCj4+ICpzLCBWVERDb250ZXh0RW50cnkgKmNlLA0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1WVERfRlJfRlNfQklUX1VQREFURV9GQUlMRUQ7DQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4NCj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAodnRkX2lzX2xh
c3RfcHRlKGZscHRlLCBsZXZlbCkpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAodnRkX2lzX2xh
c3RfcHRlKGZscHRlLCAqZmxwdGVfbGV2ZWwpKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoaXNfd3JpdGUgJiYNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKHZ0ZF9zZXRfZmxhZ19pbl9wdGUoYWRkciwgb2Zmc2V0LCBmbHB0ZSwgVlREX0ZMX0QpICE9
DQo+PiBNRU1UWF9PSykpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLVZURF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxFRDsNCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpmbHB0
ZXAgPSBmbHB0ZTsNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpmbHB0ZV9sZXZlbCA9IGxl
dmVsOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgfQ0KPj4NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhZGRyID0gdnRkX2dldF9w
dGVfYWRkcihmbHB0ZSwgYXdfYml0cyk7DQo+PiAtwqDCoMKgwqDCoMKgwqAgbGV2ZWwtLTsNCj4+
ICvCoMKgwqDCoMKgwqDCoCAoKmZscHRlX2xldmVsKS0tOw0KPj4gwqDCoMKgwqDCoCB9DQo+PiDC
oCB9DQo+Pg0KPg0KPiAtLSANCj4gUmVnYXJkcywNCj4gWWkgTGl1

