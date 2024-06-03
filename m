Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA164C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0js-0006r0-Dq; Mon, 03 Jun 2024 02:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jf-0006io-UA
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:59 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0je-00072f-1A
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394398; x=1748930398;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PaF1jpNiXIxhEHv7houvHLORN0+AzjnvPV8H0KLGjak=;
 b=SfdeZq2lzx7odD7PogofDUtKkY9Xjeux92n/LqvZBzOtTKzaTBb4e4hT
 +6zZoKWS9g7vVn2KA4xNmtlKlIT1l/ncFgTkGTj8hh1HHo2jfed/WOMo3
 j7xmsXSKbSXjnP2UI3fZzAG84ThYBTUlskjI55YGEc9YAkdegkepv3i88
 8c7ismJllWXBS5ir60o0Sovixz/uXiMInEKDMxbXP0Ch0c+AJueFo9h2d
 l2FTNQ6xZWRtPEoAH3KgFR4ATQhYyY6tWwYZGE5UyYZ/xbjYPCBZmWWdg
 7Kv3u5Vcy48ZYmDYw1OhREOqfFoYDRWa4NqW6V3NBJcmHoCL5ZUVQkOft Q==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13763249"
X-MGA-submission: =?us-ascii?q?MDH9/EM0uA47Z5iTqrPJktTNnXEoVdPDxPLTNA?=
 =?us-ascii?q?mdU2MNkbrMYYOz25F0JVjCucDMDXzDpo7ubXl4Guvi8FmWacw/8jDHBC?=
 =?us-ascii?q?9JPoUH7InMC8sykaTpd3G+naGRPE7zqmeWJlFPrWOXTEEonLQEuo+bKc?=
 =?us-ascii?q?YyzVmgxzpc39A7q15qZTBeFw=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4hrMpKpsYxawJUHBdxw/6uZRXs4xzzFgzE3kwk3QwDZD4u9CGmwcJBL7oJTo825Vp0z0T/f+N7n2zVSFOM7Wa8c9VEpTE0Z40pGH/NQKZvgHcvV2KKnm7v8lp9qR0jcLb/JepVzD1VD0hdAgIDTsknhV9CX4Cprzh4s4fV2tbiMHHy44NPz4YiEd2YUQkNYuRYxr2HMPMhXrFKvC28OxYRmp9AIGKBqD71Ee5WB7MK/9qxwl3v3l7glchlKqbI7Onwy5m2TnAFNKECIWP4eXLeHAt4hipzM1P2TJUIhx43tNrWey+7HjmWXP2FMTEOvODSRJnI2je7rrA4aCV/4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaF1jpNiXIxhEHv7houvHLORN0+AzjnvPV8H0KLGjak=;
 b=DXG9aGivBdzSS8WOw2L1jjOfgvxwqAaOaSERd0jA6JT8ChqMDWoUv/VgK3c2RD16jk1ow3cdT8bBS5BS5wSipNQx6d3OA43J5jX/vJ6odDpWefdLjD2wwXvX3Pv868/S1HEIjrgFbYZPXBOHGI3z6tBqoaOLEfZZHWl0GIXCYJcYMuWe5D0okkK3Qq4NUIm7qiYoKcY4zk3nIx9A4NGp4JvgNww8jcdHVkdn8u3QmfmkM8T9gWJJ3vzJ2I1WOFny0Xb0wYZsEWqL3R3X+ZwNknufiiQpzKtPbR356Yx2AZ1WhXxJG6zN3iJsaMob9mn3PNOKhNjvT7M4GdD16S10kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaF1jpNiXIxhEHv7houvHLORN0+AzjnvPV8H0KLGjak=;
 b=e1OctJ2GpU6oUQCUum6j57jxrhD0YhTdjto1OpYoEsaDbuM+iN12gRPcbFKja5r1bMNl3vWnbEcLjkqoyJsnybY/GUeTUOyecyofUf9UzkTa1QEESm/O66m4l5xh+rEYfrbYOpHnojykn05UjdJPRDjISHKb5j4wRBc9a/6PbX5/M1R0mkCu4dLYtOqR5nMSSS74atsEatK106HbGrBCN0m5V+8uqqllet7eObVBfZJKRemlpH6XjRcMW+50Ov5W0fjMYnidhCaPoWJKomreZVdLQgNFw6I41Q0VxyvtNQ0pODyPX4N7ItsW8kX2VOSIMBv+Tu042SQx/aV69iFL7A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:49 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:49 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 14/22] intel_iommu: implement the
 get_memory_region_pasid iommu operation
Thread-Topic: [PATCH ats_vtd v5 14/22] intel_iommu: implement the
 get_memory_region_pasid iommu operation
Thread-Index: AQHatXs+MAXYJyAioUmyLyGhw2C/bw==
Date: Mon, 3 Jun 2024 05:59:49 +0000
Message-ID: <20240603055917.18735-15-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 40c55032-d11f-43d0-9c61-08dc8392611a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MUtRZmxrUHUwRlYyRHYzUWZ2c2JodWVsU2xGcnR6R0pwSjhrcGdwNFJkZFVF?=
 =?utf-8?B?RDdHWUN6dkxLTW12dHZFc2ZBUG9vTG4yc0g5SHVpU04yNW51cVlITzYrVHV6?=
 =?utf-8?B?UWF0VHVXN1dVdC84dGZLOFJ2YXJEQ25DY2RSZk9PSlk1WENzakU3MzlRbFRi?=
 =?utf-8?B?aTVGbnN6Yit1L1Z6YVF2MkVZZVpTNWVxdTVwdUlJenY3UFpVY3hNRTB0WVRP?=
 =?utf-8?B?cERVWCtiWERXbGpBVFMzVmRBRlhpVTlCRU9LWjRxUCt0d2tDQWljbFhTY3Bq?=
 =?utf-8?B?Z1FER0VnUUdsZGQ0TjIyUENFbDh3UEZIcnF2UzJqb1FYelcwYWttaHVEWTZK?=
 =?utf-8?B?eWx6WmlQaHc5bGxpaXNvYkZyZ2tYS2Rodmx4Si9lMzZwV0QvbHRaOXh3dU96?=
 =?utf-8?B?eVJ6SVpMZ1FsRU9Dam5jcW5CeGdtNm1qMEsyaHVYZHU4cnh4TjZFclFIK0lq?=
 =?utf-8?B?UzhVblE2U2pIc3d5K2xVajNNNzc2dDdZZlFlWENHdDBIUlNzQUdwdklXdE5D?=
 =?utf-8?B?VTZWQUJtem9VbjQ5MTFkZE02N2lWbk8zVGRJM0dZTlJiZ1FzOTRDMVdWS0ZF?=
 =?utf-8?B?TmZBQmJNVmZkdVpzSUlQRWhrVGgyNklSN3lBN2k3dkxhTlZWMkhaVytnVFI3?=
 =?utf-8?B?TTN1RlFSOHNDVllCY0oxRlpMTmh1Wm9HM1ZJWWJKUFdraDRIT3VVQlZLZnNB?=
 =?utf-8?B?bS9PN29YYklpTEpRNmxWeTd5WlVEbUFNSFVSc1JWRWtwcUFRbWRXeEpoazds?=
 =?utf-8?B?WTlNV1ZWZEtpdmRDU0xhbXNsOGNqZ1JjbWlGdzhVU3doeEUwRmpYSm5LVHkr?=
 =?utf-8?B?L3h4Q1Q4ZXRrdS92a0tGZUg4andQK2ZkclQ4UnJlc2diZE11a3VkOGt0S3dU?=
 =?utf-8?B?M2poUkkraU5OQzZ4TVFFSWxPUkxLOHJvZm40c3RTdVVxcmVoamFJZjZoNnhX?=
 =?utf-8?B?QkJla0psWFhnUy9OYmlmU1plQjlhTW1QckJ5NG42citvZXdqMU1RUjdReFZO?=
 =?utf-8?B?ZzBaNlZoMEFzTFFtRy94ZW5HQnVNVDduajNMUlNtZDdVVWFTNlZJWGxBa2pW?=
 =?utf-8?B?Zml6QTg5TCtmRkpwMXdwMTJZeXZ1UGZEdzV2MUZHREdpRDVJd1VTSUpuaVNS?=
 =?utf-8?B?b2dNcDVCTHZnS0FVWit4SnNKZld5TUV4VXRPcXNySTNLdEJvYVZuR1JlbUhl?=
 =?utf-8?B?TnAyaGRPMzAxRzRxWVJ3dWRBOU5zdDhQQ2tMQ3A3c3l0RDRkVTkycmpWZXph?=
 =?utf-8?B?UDNJS2tmbUpTd1ltY2h0WVhSTzNxMXV2ZFVYZC84VTRkWmdjbWdSbkM1ZFly?=
 =?utf-8?B?VnRBQnV0LzlNcGMrVzhLdk1OOW1PNDdlR1Fsa0hCWUNSWFJadHpVSmJnT3lp?=
 =?utf-8?B?VkhXd0RXOXRnYnI1QXVxNGlrdFp4UGoxNkFpNytsMTRDbjBjc01uYnBiV1NK?=
 =?utf-8?B?NGw0cVFjOC96dmQzOGNvSndyMEs1dDhvK0V3Nmc5RFJ1NHNRK3kyZzl6ck5O?=
 =?utf-8?B?emlSUzdkN211S2dWQ3RZUFdDZ3NzY0FPMGxWWVpWejg5SGdNK0dRMWQvckJj?=
 =?utf-8?B?VXV1NEp0TWkvdXZyNjNJcVpOcmVvNmR4RWU0NHM0bHpLcUtBbXAxWlJQc3Uy?=
 =?utf-8?B?Y0xZNXh2Q29TSmNwK3pvUDVkbVVFRkZYSUhEVTBadm16YXJ6K0Z0RUdSVmNN?=
 =?utf-8?B?YTUySnhqR1pMSEdDZ2hWRWl0NEdxcTZpVkpQcmw4T2Y1WWw3dlRQNUdRQ09s?=
 =?utf-8?B?WVpycUJEUDA2R3VvYXE5MkNZNm9wZFN1VllQMGlEM0RNb1owS3pnVHROSjM4?=
 =?utf-8?B?S2ZWK2EyWTR4cU16dm1qZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VldYN0lOa3I1TVR5Y21hL1hNend6QTdxS1piMVA5RnRLa2U3L3E3clhyRnVV?=
 =?utf-8?B?VnEzN3hWaUZydzNlVDFhbHZDRlNCUTBidmNMWUxQaXN6bGN2RkpVVFVjYXJq?=
 =?utf-8?B?ZCtzUXlQVHdGbkYzTXREMjRsdWY2M2pFNzh1cFVmeGpjRFZtc2ppN2ZzanBp?=
 =?utf-8?B?aUgrMUlQQWJyN205V0EzWG1XQ3FyNVp1TEZubkFKNnNIRzdKUEtDc1Z6c1Nj?=
 =?utf-8?B?Mit6RTZsaGNkeGVWL3JnR2MrcjJmcCthd3Nrb1JQM1poTGczamR4ZDNMT2Qz?=
 =?utf-8?B?RGwwZ2JnTWdFRWxVeXQ1ZWdUM3dOWG5DL3NncExValJjYmc1dWp0WEw3QWVU?=
 =?utf-8?B?S25rb3piV0s0MEJjbGNQOExZSVhoeFBsNXpuK1FSQnNVVWYydC96UC9PalRz?=
 =?utf-8?B?Z1RhVGNiNWR0T3VhTEVvUXFOejJYRnMxVGhpS05kaHNaVlMzSjZ0cWphQ0I2?=
 =?utf-8?B?MkZ2Q3UzeE9lVXNLOUdMNTdGOWJKVVBDS3lRbUZZaEFFVnR0YjIrSEFtTXZR?=
 =?utf-8?B?blVUL01JYUpLTGQ0V2diV2RYY2tna0drR3BzUGpyOHJxMHdlYzJkUzRrb3Jm?=
 =?utf-8?B?ZzgyVy84TVdqVE5NNnZXaVhyK08yN0F2NFhmVUJFVmtGdTBzWEg3Rk8xclg3?=
 =?utf-8?B?TS9iMEdTZmVzYmhiK3BTVml2TlZNOG04QmtoRU15SDNiZG9TRXk5M1Y1SHNK?=
 =?utf-8?B?Z3dBRXc3Mm40VUYrMGtGVHI1VGl2SmxQQUdvMENIRFMvRGZwdXNIR29NMG5p?=
 =?utf-8?B?bTIrU3hqeWFMQUV4T21rQlFZV0VKWDF6aFRBOS9vNnVRcGRCWTFXNmJ0TTVR?=
 =?utf-8?B?bWMvVk53SE4zZ1JQOXljdUh3ZnJ4eUdkQ05kV3ZXS1VxRmZLbmNReFozcnQz?=
 =?utf-8?B?aVd6OXBETFZ0MElWZ3VrQVpQd1BYK0Z5VVU4NlgwSGhXUnE3MWUrYmlNNEQ5?=
 =?utf-8?B?OEFhWlhXYTFVaFBlREs5aWxqeFpVZUNUUDF5a2hGa21zbjZGMWRPZlBMNnhj?=
 =?utf-8?B?S3ZDSytvRFk3L1pRV1VsRi9vUEdGSjduVE1aRTdTVDljeGprWitCMmd5YUdq?=
 =?utf-8?B?Wjg1ZC9UUmtoejVkaWFYZnFmN2xQeDREbTN2anZwU1RSQXliTWdpemo4MEhi?=
 =?utf-8?B?M1djVGE5M3Uvd1B4R281MnJORHg3MXBTaUE1Skl3SGdrWXRZdEp1cVJLTllp?=
 =?utf-8?B?U2d4ZUdUNG9iWGlENlhFNUNOYzduZWNDWm5qSVFiNFhXQ0FqQnpIZytBUTlp?=
 =?utf-8?B?Qm5leDNmRDdLS0hiUGFZOGp6RnhyWVZnMEhzSXMraVY5YmxPTWl2WUMzTmhK?=
 =?utf-8?B?UUZ1clQ3K3JKZGhwRytJdW84Zm9aK0dCNGkxWVVPQnFYa1MzTFQwZ0ZPKzJW?=
 =?utf-8?B?Ni9DUzMzQzhEY3g2Z092RU52ODZ4T3AvS1dXZ1lIdGdyMyt3Um1IT3BaTStK?=
 =?utf-8?B?Q2hlT09UWk0vSTFEYmx0L0lnU0tLblFQbk5nRDJlOHJIRTZZdzFMaFdWdFc4?=
 =?utf-8?B?ZjRwYkNDK3lxYjVVVDNqeXA1bWZ4Nmp3TE1ONkpQaDZYZUh6TU9KL3laaDdv?=
 =?utf-8?B?d1d1UGZBWTNIYlNXSXNCQlJIbnlwWWVobUdHVTJoWUNGZFVDQk1NNStaL3V2?=
 =?utf-8?B?WDNhUzZrR00ydGdhTEJzV2FrREFzUi9UVmpIL284NDllRDkyTUVvVTdtWS95?=
 =?utf-8?B?WEVJdlZ4cjRpYXFHMHIxSWVlRmVQT0RxT3B1UW0xWlhWRDVXNVBEa250bmFV?=
 =?utf-8?B?RDVBUXJTZVBSdmR3UWxvTEZUc0VNUEZjb25aWjhSblFLNlRBb0l1aXRRdnZQ?=
 =?utf-8?B?UFZOSEdFaEROd1BGM2x0RlBlRXN0cmNzQktWM2N2ZFBSTnFIM1pBOWtRUXRG?=
 =?utf-8?B?YlF5QTlEVjdHaVEvNlUxcHlRdVZremFaTzRrMEVPSlR2empUdFNPSTQrY3Nm?=
 =?utf-8?B?YW5mUE5hRGMxYXFGOEFYMVlzeFh3U3NDekcwQzRLaloxUm54SG80eGV4Vlcw?=
 =?utf-8?B?aXVQa1ZuU0FzbEJJZk9oY2hkL01jSFBTdEMwOXVSVTUwYVZVVVZ5Q0FRZlFo?=
 =?utf-8?B?RE9kN3llVmpCd3MrMUF0SHhidzVPaDExdnR3bW5kWXQ5RStBcHJkRlVKa0RO?=
 =?utf-8?B?VEp0RGNLOG1pNDJZQ1pqYUQ4QWYrNm5COWxnaXY2S3I3SEZSTU9HQUR4UGJQ?=
 =?utf-8?Q?BKOYclNWNjTPOfcr5t2gJko=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65A60D98503C274F85AC23DE05819053@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c55032-d11f-43d0-9c61-08dc8392611a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:49.6871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/fGCMZmCF8sDiQ90fg4Lt+UuwEfO/ZselZYk8NvGN8IFtqM11c3GYXUcaGpWlHlgMI3weR98N/cqITqVhu6ugKm6dgdINgB87OAfPZz7hmtU2RwdY8bqiRvJKd2anaE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwg
MTUgKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KaW5kZXggNmE2OGRmMDE1NC4uZDYwNzU2MmRlMiAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtNTk3NSw5ICs1OTc1
LDI0IEBAIHN0YXRpYyBBZGRyZXNzU3BhY2UgKnZ0ZF9ob3N0X2RtYV9pb21tdShQQ0lCdXMgKmJ1
cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2Zm4pDQogICAgIHJldHVybiB2dGRfaG9zdF9kbWFfaW9t
bXVfcGFzaWQoYnVzLCBvcGFxdWUsIGRldmZuLCBQQ0lfTk9fUEFTSUQpOw0KIH0NCiANCitzdGF0
aWMgSU9NTVVNZW1vcnlSZWdpb24gKnZ0ZF9nZXRfbWVtb3J5X3JlZ2lvbl9wYXNpZChQQ0lCdXMg
KmJ1cywNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2b2lkICpvcGFxdWUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW50IGRldmZuLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkKQ0KK3sNCisgICAgSW50
ZWxJT01NVVN0YXRlICpzID0gb3BhcXVlOw0KKyAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hczsN
CisNCisgICAgYXNzZXJ0KDAgPD0gZGV2Zm4gJiYgZGV2Zm4gPCBQQ0lfREVWRk5fTUFYKTsNCisN
CisgICAgdnRkX2FzID0gdnRkX2ZpbmRfYWRkX2FzKHMsIGJ1cywgZGV2Zm4sIHBhc2lkKTsNCisg
ICAgcmV0dXJuICZ2dGRfYXMtPmlvbW11Ow0KK30NCisNCiBzdGF0aWMgUENJSU9NTVVPcHMgdnRk
X2lvbW11X29wcyA9IHsNCiAgICAgLmdldF9hZGRyZXNzX3NwYWNlID0gdnRkX2hvc3RfZG1hX2lv
bW11LA0KICAgICAuZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQgPSB2dGRfaG9zdF9kbWFfaW9tbXVf
cGFzaWQsDQorICAgIC5nZXRfbWVtb3J5X3JlZ2lvbl9wYXNpZCA9IHZ0ZF9nZXRfbWVtb3J5X3Jl
Z2lvbl9wYXNpZCwNCiAgICAgLnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3NldF9pb21tdV9k
ZXZpY2UsDQogICAgIC51bnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3Vuc2V0X2lvbW11X2Rl
dmljZSwNCiB9Ow0KLS0gDQoyLjQ1LjENCg==

