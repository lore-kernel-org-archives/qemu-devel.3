Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D6AC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jX-0006cN-S0; Mon, 03 Jun 2024 01:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jV-0006bi-VA
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:50 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jU-00071B-9h
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394388; x=1748930388;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tdlem/PBmSzX9se9OAGRAEu7sN2rybtDsPNqgzPwTAQ=;
 b=L9fRDNYovOXpuDffxjQhO3afiRvfie65LeNR8IjWY46B0u5o3aafHKSH
 hki6XB3GH29roxdxN359c/RbU5oKA2ypUMH3Vl4F2iGGC4roAjPWcDDG7
 dxfEGniyBnhPJyaYpCyuImcWayxG4diUPwG5Ieo+FyTLMMHSAnvzsMxBd
 drzLdvizN7jkap5b7zq1SHYuPqWfHPo3yRHeG75wzvJhsbqPmNP71c/Um
 rr2XaaDJJFqrbUQZIxfd5Wh1Ix/prR5RQ7aWm8m3c11Wsnt+9HRx4zk4w
 4GejusI1GlA7mv66R5b8DELsqTVtft2WsE2ji9s9vBT2WidCRk2AAm89t g==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815871"
X-MGA-submission: =?us-ascii?q?MDFldeXDG5/ZzBI3dHlAZr39yEMq37mNhSwxlu?=
 =?us-ascii?q?/4KoHb3+NzTZnfu2c5lnNGiOI+BLE2OjLnoBcrBA/yvg+nrEbNkWO645?=
 =?us-ascii?q?JjA/A3LWTzr55N5gaxVpRsa9UxXfsVaTZHpVSeXL0MG2jL166gEuYThL?=
 =?us-ascii?q?Rw/CJt3DPGEatehPvIeDv7uQ=3D=3D?=
Received: from mail-he1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.50])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:44 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMC/Kg6IKWl/hqLuocqxX0bLJvUFyEKZmhoUKcflV1d9y6fytatARP0ppLVzkbdJGWkx+rtYsJ6MKPgGMDc+rQDk5qmZZbej/WXO2X641sKPuI1uQmWAL6/NXxre84UOIffOO60yI0hPMfq1ptZxN/IAuskINQBkI46wZemdk7R1ntK05TjbpJglPkEiJaERcILHJHilPVDfQRSnvSPy0D+/OrAWoSLyCC/4x8QEj55hkJBi706WdWL76PRjKZX4fsaQBABUl1E9d3WWrGYDuQd8UErsakCbtvdBYMSe/UVkbV60r/SkZDJdgc94Jt7/929YnoDI0hzwv4tcQOR6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdlem/PBmSzX9se9OAGRAEu7sN2rybtDsPNqgzPwTAQ=;
 b=dVukMWfGs7O6HclHZL/UUSsjNG5IilH6mWvNbiBlmA/gefEvfoi0OZSAPxSy5tU6JEqfYjjwBZusthcoTzwkT6p7A/ezfgN8JNGgnw1TszcIqDgeaAzc+WXusI//iC/m6LTcV/3Sy5isQvY6vocw8ljTwT2V5kUUANP59SiLcqvkzaYjXzehpPNucxpt6pgzJNXy09VbwWXh9AfesybxYFM2h65C4BxAusPPrt1+G/wB7FwzN43Eauyjp128TWzBBNpXLr1E269SmHpTmQ6tGduHZlC/83BoAtYj2hKkjMh1iuPat0SmplDCsqI/cH0fW7A+74JAgtvUg8QgkASH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdlem/PBmSzX9se9OAGRAEu7sN2rybtDsPNqgzPwTAQ=;
 b=I+bL7OiMscZ3VDvj2B4hngyv6PZvOS8QItY8cckyuZVMLv9vRRuYG48Vx9fssnouOL2BkKNXBZ3SwpRqFv9+jCtaJckTrVnlMjI2q3dh49ppuvqcF20F0MeB2YB7w4zkauKx4zqS9IOZt7j5JUEL5vSBrwiirc83BP15ThrKd+Xkbb8kxctTztgVs30CQh1dDSGiUWwB1edro2Wr6Q3527mKxW/6hIV1rJ0eeFfcYQ0fDeKmbgzbrJJiJyc2k7jgBZPc+8bHLRIpnQeqJzgTvhExGAME+UeUTvT9fbvAOWLO3gZdQkfDvD7Wtn0Eo7doYV+LjymW4XYknBt1aUCN3A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:40 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:40 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 01/22] intel_iommu: fix FRCD construction macro.
Thread-Topic: [PATCH ats_vtd v5 01/22] intel_iommu: fix FRCD construction
 macro.
Thread-Index: AQHatXs5gC5VI2sPeE+aetPJapEaBw==
Date: Mon, 3 Jun 2024 05:59:40 +0000
Message-ID: <20240603055917.18735-2-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: f98125ef-7e50-4ba5-7d44-08dc83925bd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RCtlVjNwYVNISDIrcjZVWkwyaWpmUXVtOEo2bEpWNHp1V2Z6VktJbVJUWExI?=
 =?utf-8?B?Z0kvNU1oOURtTVpuT1VYVHpJQTNqbWtKNlJOc0ROdUhpWTcvemVjYVMrN3I2?=
 =?utf-8?B?c051eWtzOTkwWW9Nd0JkOUlJc3FKbmVnYVJKSXpabHczTXVrelUrUTZ3czlF?=
 =?utf-8?B?b1hpK1ZFNmdBc2JCbGRKMnY2TndYc0NuajlBU2ZEd3pFV3hpS3h1N3ZUSTdB?=
 =?utf-8?B?QmRCZ05LOUM3M2M1cGFMVzYwMnA2OUZkTTZLNVpaS25CcC83VGo3Vk9jelU0?=
 =?utf-8?B?NHhtOC8wQnovSy9QRElHYzRTWkFBdGlOMXBWMUlOTzl5TEJmUk9mRmpEL3k2?=
 =?utf-8?B?WVJIREhHTUJ2NmFyZExkMEE1c3ZVbzNiLzJTKy83dG8zaFNMcmRkRE5MUmU3?=
 =?utf-8?B?TnFqQjRYbUlpU2xSV1NEUmpLM1NyVUx0ZmVaZVIvei9FOHdXMTFVU0tRUnQ5?=
 =?utf-8?B?Y25kd2hHaHJwOTVZSkZvTHp0YXZ5OUFEMFpkN3VIa2FIYWdZN3hXcnJhRDc5?=
 =?utf-8?B?UGFDQ1RuSE9zQWUvNEZpZCtpd1NOc3pMNkpKOUNJOTEvdG1FWVpMS1ZIa0du?=
 =?utf-8?B?Y21XZmo2azMyMzRxNW0yYWJBdWt2NHRUQnU3MEN4Y1graXc1MWEwa3gvSXRv?=
 =?utf-8?B?cDZoV3FVTzVuRm85d04rZWJXQ2dyY3ZmVUtyR2RIRTBzdjROeVJ5SkpJUEQr?=
 =?utf-8?B?QzZhUjZNU3EwaFJqRXRNWmlYTHpNTXNyTU5JVjBTcHlUMWJSMTJtSnBSN1JH?=
 =?utf-8?B?MEhNTEhSNWJSQUMzc1M1UEdBTkdyT2FoTWdFZGxGNVRScWFEQ3FQRkp0UkNz?=
 =?utf-8?B?TkZ6RHdWMm4ybVp1N3BUbWFGM0t3ZG16bHNjRU5UaUhFUjJiNms3WUFWVDlo?=
 =?utf-8?B?OXZEbUtEYjY1c0RiemowK0RHR0h5SGR4VzR1a0NUdEVZVWIwRzBHNXpXNnNS?=
 =?utf-8?B?U1lqYzB6TW9KRTdKanppblhwZlYvdkxOSFpUdmVFS0szcTZjNzNYb2o4Vk5E?=
 =?utf-8?B?YkpZTmRyYlJMb0NDalVRNlJlbzdiZUJ2d3owQ2gxVkZxVm9mK0hxR0NtVDcz?=
 =?utf-8?B?dDFweGxLU3cwVUxDVkZ0cWxyTjc0VGxrRVkwcVpWcmxBeEFiNzFNNUpvVm1t?=
 =?utf-8?B?Tm5RcklLUnY1d0tmZllpcld3NEFKWkpYWUJUL1RkTDlwSUxxMVlQMW91bkFD?=
 =?utf-8?B?SlY1SzhsV3U5Wi8zK20rbERESGp0RVdEVXZKV1R6bllGd3pPTWF6elliRjd5?=
 =?utf-8?B?S0d3V3FnakR4YzAwUnZ2WC9HdmFmd2pFR2YzOWlYRWl2VmNXeWpBcU1jN2tj?=
 =?utf-8?B?b0tUbGJCM0QyOGRuZmJnWUdxUjNrcGhDQTFDMHlKUDhrU0RadWxnRkZWZlFQ?=
 =?utf-8?B?MnVZZUk2SXFXOEJPQTFQZGlSaG93OXNsMFlCZGRES3AwTFFOOGo1Zkc4WTMv?=
 =?utf-8?B?Tk94MTZSOUgzTG9UNkNwY0pyTTFWcEsvUEhKbHJ4M2s4T2pDaFRKZWhmZk93?=
 =?utf-8?B?U1hOa25Ua0ZjMmZKRW5rU1ZKTmRrYXRxUDYyR3dxZW9qTU1NMk5nRllPWVIv?=
 =?utf-8?B?WUJCMUtNWWgwdWNDcWloSXVhT0s5NWc0OTdRYm9xOXJFdzV4WW5YTXZMa0c3?=
 =?utf-8?B?K01NTkNyZ0ZyWDBhdVdQMFFXQW9BdnM3Um5ldjRtbTNmcklFdTZmOW5iaXJE?=
 =?utf-8?B?ajRqcVRQbmxOREY1cGZMbThKelkyc1BkYmR2cUw3V1YyZ3lDb2YzdU9CY3di?=
 =?utf-8?B?L3VZVXVSZU45NnNlZGZKajJiZDFTTGxXRWdiazRHRnlpZTBSaHNzdzdmZ2U4?=
 =?utf-8?B?YzVGQ2RhaWFmSUZUK0pSdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFJvZXRjblVKSENTZFMvYXQrdG1wbmR0U2dLOFNhZDJYSFI4YjAxVWhNbU9Y?=
 =?utf-8?B?Ykg5b1o0UG4yc2VIWE0zaGNWSWNYSDk4UzNxbFBkZVlZYTV4K1A2bk9XRVlW?=
 =?utf-8?B?TmxpbjErR2lyQTNrVFlzbjF6VUQ3ekZrM2w5K09WdG9PV0sxWldHcktsNXhY?=
 =?utf-8?B?c1JlNzllK3kyMU9jN0FydTRzZVVtY3NjVTN3Z3V6Yk5pTlhyMGtHYndFQTA2?=
 =?utf-8?B?ZldLclBZRVpqMS9FM2NRRHFTRTB1QUtzaHJOV1Y3dGM0Rmo4c1VoekRRUTBH?=
 =?utf-8?B?amZOa3QyNGxCdXBFVE0xNkVvZUJjVEMxZi85Y01hNjNrRis5c2YyUlhsODJF?=
 =?utf-8?B?UU85QWRRd1NCV3ozbWs5cGRoV2dFR0tIaFhFS3dKS29QME1hY0hoVTJ2Q0Nw?=
 =?utf-8?B?T212R2tOSGIzSDJKSUxKUldRMEhJQUM1dTZpLzhoM3ZsVGgyQ09GRTA2clFx?=
 =?utf-8?B?K2RkMy84QkxaNkxhaHFlRTY2ZjRNR09kQ3EvLytmT29vM0p0TTR0RmF1TzIr?=
 =?utf-8?B?VnB3bTN2SEprS1FTM04zNzZxSUhHYnN5cElrdit4RUNpVHcrM2VuUkdKZWZu?=
 =?utf-8?B?SWpnNlJxWUZ6bFRtRXZYcU1zUXRvYzdDRkNMVFQ1QzhaK3NRRkFTamhwZS8w?=
 =?utf-8?B?RFZjL1M1UTI5U055LytOb3ZKNFVuN3RkL0l2UENPWDlqaW00Ty9EQ2YrckxZ?=
 =?utf-8?B?aWxlY2tscDJMa2t3QTlFbkk0UGJlZmUrNm1KSjRQN3lkVlR1Ri9rdVpLdEMz?=
 =?utf-8?B?UjQ4elVxTFM2OHRKL2tkZWNOTm1VZm1PZlNBY0tqaU5Qb1h0M1RjTFFtbG1q?=
 =?utf-8?B?YzlwZHIvM215dElNRmFJbWNwYWdBRW5BUDhldWRkaUhGM0U0T3phcSsxazR5?=
 =?utf-8?B?U2dSQUdVR2FZN0l5K3pYbGV3QWVndkd4bmhhdUFCVklzRUlMY3NaOFZSRjBR?=
 =?utf-8?B?SFRsRTdGeDNOeHlaWXNvUXZNOFVLSVFwQmozSS9pVTBIMEoxc3c0M2VwUkZP?=
 =?utf-8?B?cFl1SzZnWi9oc1ZtSVFUYW1tNlRUTytlUG1pZ0w4dm8vVWZObkhWR25VS0JD?=
 =?utf-8?B?NXYzRGdQTW9kaDZYbUY1bW9FQis5b2l1OENVSlZ5RkhXVG9BVnVZb0hha1c1?=
 =?utf-8?B?ZnRRN3dVM2RGWUVrR01SWkRCWmlWTnR2aWN1THZyYU8ra3BMakYzcUtyZ3NN?=
 =?utf-8?B?anMrWGZpRkRiVkloZ2Y4VTF3YmxXU2prejFWb3hOMFgxN2w0YWIwNm1MYW5P?=
 =?utf-8?B?VW9VSTMydUQxNVowa1lNUFVEd1ZoTjNJWTZWaHlzSGJUTHFMNkRhL1A5R2Jv?=
 =?utf-8?B?RGswZndjT2ZnZ3lBNjFBWlBDRFdCUU4rUzJhMnZ1WEdBSHIrQkFEYlVvWjdG?=
 =?utf-8?B?UGxXYUZzNDNVSEROS0x2aHlkam5ZTEMzU2F0K0xHdjkrMXBmL3YxMGFBK2Nn?=
 =?utf-8?B?NCtxNVJuNkt5SVhZMDAxN0tIdFgwVWdxRk5yMnk3QzJpU0QzK2lJcTh5VE1T?=
 =?utf-8?B?RlZGbkp6TTFEZ2hMMkhSUS9DNXBvTlZMcjVQYkgxdTdiSU11ejhzMnBqSkYw?=
 =?utf-8?B?NW8wVWQvbEVON1JFSnhsZHFKQktHdUdKYUdrVGdjMTRjUXorUVpWUjZ0MUY1?=
 =?utf-8?B?cWNKaGJKWDA2cUMvZHBnanF5WXdhNW5ST25FRFl2OTgvTHVqMW9lRk92bVAz?=
 =?utf-8?B?M2Fxd05PdWtDdXA4dFFEdVhHU25NL2dPNnpLc0V0V21qU2VXdEk0bTBsRkpj?=
 =?utf-8?B?UVhPd09nMVAvK2U1Tk9lRndMeGNRaW45NlNsb2VwUjdHREZsQUI0enJFcnlK?=
 =?utf-8?B?MERPeTlGeGwvNmFmWlcrNDhvYVJuaW1vUEs1UGhmU1h4MnZMN3RhZkpOQTB4?=
 =?utf-8?B?ZmI3ejhqOUpYZ2lsZFlsSlJJdjJnVGtiYWY2NjgyL3RqKzR1aXMxZkFSei9r?=
 =?utf-8?B?bG9lMUFxTUVwMXNSZ3BYUHV1eHNoZ0VHZ2ErVmpSUmtzYTdMN0RLbURoQWNH?=
 =?utf-8?B?SFJicG5UOEt1TGtXbUp6b29nVzZFbWFFaEVTZDA5THFOOWhqRWJEWE42Rlh5?=
 =?utf-8?B?TEI3Z2ZYUndFVERUMXJhd3VnQ280a0dwTFZiNEN2bkU1MlllUlJHdGR5Rlp3?=
 =?utf-8?B?VHo4MVVTQ0lUZVJaTkQ5U1IyZmdBVmxPYzZERk5QbnNHd2VpNmF3QTJwT05W?=
 =?utf-8?Q?HMTeX721KzKIlNYXuV4zPBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B77E65F3413E2E44A0318BC90CA539AD@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98125ef-7e50-4ba5-7d44-08dc83925bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:40.8659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3VMocovnmCy/RjDKBpX85DeVZHBo5sgeV/Y4HKSi3C/Bef6cIVBHBCNgkO0cRwKao+4uaFN23QqZa5ZPMmBDcbEz2wIoGByKyEtWjXshn16t62Br/Qi4l3Y2hfMeLClg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSBjb25zdGFudCBtdXN0IGJlIHVuc2lnbmVkLCBvdGhlcndpc2UgdGhlIHR3
bydzIGNvbXBsZW1lbnQNCm92ZXJyaWRlcyB0aGUgb3RoZXIgZmllbGRzIHdoZW4gYSBQQVNJRCBp
cyBwcmVzZW50DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQppbmRleCA3ZDA0MjBlMTVkLi4xZTM3Yjk4
YzY1IDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQorKysgYi9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCkBAIC0yNzIsNyArMjcyLDcgQEANCiAvKiBG
b3IgdGhlIGxvdyA2NC1iaXQgb2YgMTI4LWJpdCAqLw0KICNkZWZpbmUgVlREX0ZSQ0RfRkkodmFs
KSAgICAgICAgKCh2YWwpICYgfjB4ZmZmVUxMKQ0KICNkZWZpbmUgVlREX0ZSQ0RfUFYodmFsKSAg
ICAgICAgKCgodmFsKSAmIDB4ZmZmZlVMTCkgPDwgNDApDQotI2RlZmluZSBWVERfRlJDRF9QUCh2
YWwpICAgICAgICAoKCh2YWwpICYgMHgxKSA8PCAzMSkNCisjZGVmaW5lIFZURF9GUkNEX1BQKHZh
bCkgICAgICAgICgoKHZhbCkgJiAweDFVTEwpIDw8IDMxKQ0KICNkZWZpbmUgVlREX0ZSQ0RfSVJf
SURYKHZhbCkgICAgKCgodmFsKSAmIDB4ZmZmZlVMTCkgPDwgNDgpDQogDQogLyogRE1BIFJlbWFw
cGluZyBGYXVsdCBDb25kaXRpb25zICovDQotLSANCjIuNDUuMQ0K

