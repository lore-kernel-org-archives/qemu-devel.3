Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF7BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNK-0003gZ-UN; Thu, 02 May 2024 11:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNJ-0003fv-7T
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:33 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNH-0005zE-HC
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663771; x=1746199771;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=jqH22yC3gZ1HF0ZE1kcRC60g7aPGVpRl1CeIoCk/E/I=;
 b=HXy/3U4yqF1rI4c+pVpIbEdKQscOymKvQmPPYTxyBJdqY5XX2SX7yR5N
 0QU4NMePTFvQXdfYKdJ2uFs6MReno3LzUEk/9z5eMjAx9XDjMSM61uYMT
 stanjsVhbuWL6q/e7IxdgGvRpFxTq564U1vpSY8SXmICmmJr6PTmc6Rve
 gCUiBh9f8AlGuuCrjzzVi72EqTFe/wX+EV/HMxz8gD59tvBJ/uCKI6V4V
 mdd2Tu1c0GNO2WasZVBrm5DsfM0g+HW0D62K/dqcHi9YwemlQpRYq4/h7
 AyG5i6FwgobPe54IhU3Zw+/0S3Vh0/G/ypj27oBZn3zakyW9Ro149DmZ3 g==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11730623"
X-MGA-submission: =?us-ascii?q?MDGyCjIKEHE3ompCo/zyD0zy8d6BiKd1agTole?=
 =?us-ascii?q?4wPqvjJHjF9N+y4lPZp1Y67N6n/RDeudaUgRo0EaTAIQj/7l6yf0UQe7?=
 =?us-ascii?q?+kfxqAw1ZCd89RpktxcSMw7QUG1l81AQXKDGFgIjqCUm7CAP2EH3H1TF?=
 =?us-ascii?q?CcF7c6grIkIr8D8je8N3/zcw=3D=3D?=
Received: from mail-am6eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuqdJRYm2S/QUG3yy6ZVoqtbotcKWqJjnLuN8JWI3LbkBpKKHpoh0wGW5saoXzuHe5voxNbMDN/oy4QBe0Q8dC1JWoKZHT79cfvYONB4gIy7Gl+O5Sh/0x9KmAmycTIgr4lEWHlYANXqHcWvUb+nEbf6GH5YAdnlLJiWQL3fkqlzhlFXOIb+/eoDguK9eKq6lvIFpswVSFa5EYI4jTj8An85gTR8idvTxmV2V5CwBxeUGP5hinJjRjXk+HPntzLdWxbepHlVoZRLpieVtg9BtNZ/YyaQeUObzEIt4GvoK56/u1R8gK2KrQVF8jCa5C/YpV9KEPgoHzEqjRqb7AdO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqH22yC3gZ1HF0ZE1kcRC60g7aPGVpRl1CeIoCk/E/I=;
 b=CCU35lR+KZqxNd7Roo7V0Jgzmt55bI/PIbyKp5YcTPrOarmieYIDaGbqaVi/kHJ+TtNvTTn8cYAJ98MoDWYtJrtpUGGS6umEbZuGCKJmLZAFf+8hB0JFYGwq2z3pKHYKSrN5zEllcq+MCbwM2wTsxrmiAl1eGR3G5FprCKuxi0oKQe1frLcww9PTiIi417o6oXAfT3EuozM4BecfLv336ptxXZNKLtDIbQP1zbOkiAjVge0dwbTmGuKyLvi8VSnWweLJshCjPm4m/1VD7DZys16NaAs7s8EjnGGA6GhKkJ6qmgRcqTYNxV9xc4ZLrP5DA4ik+RgmMHRHWqKJ2lAOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7768.eurprd07.prod.outlook.com (2603:10a6:20b:351::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:22 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:22 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 23/24] intel_iommu: set the address mask even when
 a translation fails
Thread-Topic: [PATCH ats_vtd v1 23/24] intel_iommu: set the address mask even
 when a translation fails
Thread-Index: AQHanKWBYNOsIYIeYk+58ghVT37p0Q==
Date: Thu, 2 May 2024 15:29:22 +0000
Message-ID: <20240502152810.187492-24-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7768:EE_
x-ms-office365-filtering-correlation-id: 45ab644c-da77-4a2a-7023-08dc6abca459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dVdqN1hTQlhjUEIzM2ZsbjZQR2thYXZUZVRmK1FVSnh5OWxSd1MycTZZeXpX?=
 =?utf-8?B?V09rSzVDcEw4YzA5SjlRL1V2NVIvc1lKemtQU0VqbU9Kb2cyZjJ0ZzJucXhj?=
 =?utf-8?B?ZzFBd3FXK254Z1BpQ0p5NjBPY0ovbkZISW1LaStYcElQdXUxc1lYbFdYUmcx?=
 =?utf-8?B?aWhtODVMTVE3VmIxVFduQlU1ZUlBb1p5SUZlZUhyUnlBMTZMNFVmdmQyWDN3?=
 =?utf-8?B?MFVUbm5QT09WNWh4NjNwSi9hbUZ1Um5DdzNHd04vV0d2cEhrNHRMZXg5Sk4r?=
 =?utf-8?B?ZExFMEYxbWk5SmV1cHhlTG5MeDAyR3QvdklUNkpJRUg3OTNrL0prNlFBWWR5?=
 =?utf-8?B?MHg4YjlpTnIxU1gwakxveUFnbk5PQ1FQUWJZbnRTa0FZeVVVM1k1M1V6M0Jh?=
 =?utf-8?B?Y2RUcXczclE4bWlTYjVUUVJVOHlrbW84ZFZDS2JDaHdNZGNsTlBDOU41VVJ6?=
 =?utf-8?B?TE8zZHRyL3lhUWw4WjBmK0UrWlhSQ21RSkNoVS85VURyMzhrWmliTDJwMUQx?=
 =?utf-8?B?ZER5OXJ4ZnA4aU8zTnNjdlh4WlRSK2k1cURmb25EOUpMODlhcXIrWVpiZjNy?=
 =?utf-8?B?ekZXQ1drRjFxQkJtaWpkaFdJTUgvQ3hKSmNoMUwvSkJEMDNTaUluREZyMHZL?=
 =?utf-8?B?YXpDU2FWSmRWQjUveHREZW41K2VDYzNlK3lnSVBuL2kzT0NyM2RhMnpmUkJU?=
 =?utf-8?B?QXJMc3pUWmFydzNOVU5aR1hMQVZZNk1yQWsxK2U5U013ZlNNWUg4dVpBbXND?=
 =?utf-8?B?MXVsdkRpK21ua1c0Y2FRS0hSM1JqZjJhWFBlM2tQbjFZK2ROVnJQMXBBK2h5?=
 =?utf-8?B?Um0rSDFpTkNTcFJJWFhPMW9rRWxwUWp5a1p5NGR6M25JeDhqREwvM2s2L25S?=
 =?utf-8?B?eDc0ZnJSeEFCY2ZxYy8yaE9qUXM2bmFQdUJkK3E0RmkwU1IxRlRpeDFvVFJM?=
 =?utf-8?B?b1lldE83NlNOWUI2c1pVU08ySXNpR1ZzTkZGaDJLZ0FQeWlOdlZzMmpNYThm?=
 =?utf-8?B?Nk5tNUxmVFBZbnliREVrcGZPUVBOaHRmdVJaTGFOcmtxN1FvbnZKbXV0ZmZn?=
 =?utf-8?B?TlJxVml6U1VkU2RPaU9TaHNCdWJFeGlQVVhvcWs4a2xWZVBFVVJzd3BiOUNF?=
 =?utf-8?B?L09XbG5JQXd6QWpWQVJOL0tFcHdtcENZQUdGSC8zZUlxK1RjM3htNVQ5U3RJ?=
 =?utf-8?B?bEdPNXZQNWZVYlVla2lhVWFIcWFyUFJjYlJROVVPTTZsZ1lrZ3RFNXdzMkdI?=
 =?utf-8?B?Y0FRdkNnZjlGUWI1dy9ybW5qWHQzY0lZN0V2eDRFM2cxem42TXRHeW1DN05V?=
 =?utf-8?B?NTRwMER0NEM5Q25SWXVhcEphVmliMUloMktSMWNJNzNqNGloaGJoL1pITkJY?=
 =?utf-8?B?dHM4Unl2QkVKVUFZaWd3aWZWY0JlYnpmc3NrREtNUTcvNzEyVjdrb1pwcHdp?=
 =?utf-8?B?YTB3NjdwWWFlclp6ckhRYzQ3SVpoWXJhRDFrSE5qU0FuWEZ0SGZKOFFvTkFG?=
 =?utf-8?B?cnM4MEJmUlZZSEVwNjhjMmRpajBONkM2RE43QkFhRFJONlRubENSNUFTajl4?=
 =?utf-8?B?R0xOamE2VnhLdGIvVVpiTG9mOU5TT2hEZGpPWDVRRUhSSjRZMDFQVkpBZFdM?=
 =?utf-8?B?Vlc2Y3FEQ2J1UldJeFlzYXJqWnZXZ3ZPN1NXRkhrZXplSnhQODlUbWFTSWxI?=
 =?utf-8?B?eVQ3UG84SUhEd3NjcmlXZ2hTcDlQUEg3NWUzYS9Ma0U0QkpJbnU0UGlHMk5v?=
 =?utf-8?B?V3VGa2FkbUd2R0MyU2o4czh5NTczMWhjWTJOVGRPY0Rqb1M4ZGhCQU0wNnV2?=
 =?utf-8?B?eUpOUHJNcFNveitkaDJlZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVo0THdDWXhWVysxUUVXaVkwejJMbm5xY3M4bjNCaUZKeHFyckNmSmhLVllP?=
 =?utf-8?B?a0RhbW9VRzZlNDhWSGhEU3ZFSzl4c3pXbUdBYXFjQ0IxalFwaFh6VzFFZjJH?=
 =?utf-8?B?OEJXQ3paMkhHbGVmVzk5LzlqdlhqaDRHNG96Wm51SXM4TjM2VnlCUFlvMnRO?=
 =?utf-8?B?R2VueEllTTNkY0xVZnNrTUhEVVBWQXBYbnJrOUNEeWVkalpYRjQ0clBCYVNv?=
 =?utf-8?B?eFhZd3ZXV2dzRVFhZGFQcDFhdkRrdElsK3JvbEhHTHJ2YUhFbVp4dURwdm1p?=
 =?utf-8?B?Sk5mV3JaQk5TbFJzeFVlQWVaNTVwd093ZGhLTHhISElzMEk2ek41Z0hQZUVZ?=
 =?utf-8?B?K0FMbEUzSHdxZTFSOGx3OGdoYStjMTNOaGRwcitQYXVyYW9Ub29xK2tES0hE?=
 =?utf-8?B?Y1BYQXV5RTBvdG53aDd2NkdjcWtQQUlrOEsvVGpYOHB3dXRnUjJ0YUFZTzBi?=
 =?utf-8?B?QUlDSUVVTTFvNzdBVFpzeldxTi9MdUMxeWFLc3hqMDdFbnFVb011aE1lUWYy?=
 =?utf-8?B?elB5ZU9SZ2FKNlpLQ0liMktHdTdOZmUxREJyVVdlQ2hsVGgxWW9UaUNtQnlN?=
 =?utf-8?B?WXczUzRKLzhPVmo3c1hqaTV5VmZGbGVnNUlvbWpYZEIrKytlVXBSR3NYN1dR?=
 =?utf-8?B?V29mZG5WcEY1OUFWU0c0aW0wN3RYMlYyU1BvcHJ2Skxxeko5VVNyeFdxdnhI?=
 =?utf-8?B?RHI5QitRYm1QTVlRYS9hek5Wd0JFZmdDOTJCbjQ1OTdyS1ArUS9pTmplb2N6?=
 =?utf-8?B?aHMyUitTWUd1MkpsY2ZHZmkybXprVENWbUo5ZWVnL3ZiOGl0RzkzblJETUdh?=
 =?utf-8?B?Z2xIQW4wUjg3ZlJnUzhUSm9JNnlLWGdWSzdXM1BtUUVlVVZ3bGxBMElBWEVh?=
 =?utf-8?B?ME1DdXBQS2xWSDZiQ0JGNm1nSll2M3JkSVdnYlFLeEhBaWR3NGJEZVJidVlS?=
 =?utf-8?B?MGpPUnI5Yyttd3VxSlJkbTdlUGRVNXBpSEhWZ1RReExRSnlscG9SRTdsZU9q?=
 =?utf-8?B?KzFKdkIrV0pKdlE5dlRYYnpVUk0xU09kZHFYMVI4K21xeTdwL1VmQUFhSkRt?=
 =?utf-8?B?aTIxeUlPYURnMkJsdWZnZTFJMjlyNWZ0WCtSZ3FPMzF3MGZKcGNGR1Zoc2Vv?=
 =?utf-8?B?MHlPQ2FlWm9pRjgrc0dHOHllK1lYR2pIdmt5VmZyUm1iQUpzOGxSVDUvWkRO?=
 =?utf-8?B?RGRtWGplV0VGUGNpbXVyZWg5dGZVa0wvSW5qK3NuZ3ZqamV4RTU3WFZZd2t4?=
 =?utf-8?B?aHpVZExnTzgvU0ljbWloL0o5NHQ2eDNheHZVQjlCWk1Kcyt2WmQyMGpoMXpS?=
 =?utf-8?B?ZjJ0UlB2azl6RFp5VDNPYnc5UDFZZ1I0d0pQTTM2MWFjY1R4bkc1cVZIQ0sr?=
 =?utf-8?B?UmprcXZ4U2ZKcjhCRG1YcC9ZL2NzL1Q0bXE5UXNCRmkwWWVRWUtXMkNzN3RX?=
 =?utf-8?B?Tm5TOUFSbGVHRTdMRm1rNTNYZmNLNzlrNWVwRFBFa3pDZTBTd2hPWUhhc0Zz?=
 =?utf-8?B?QnRKa2VtNEVsaFladE9iNW9Gb0hIMTJUUWJtQThiMElsOWg0WTNmL0lHTzdX?=
 =?utf-8?B?TllsV1JpK1doZnJRYVdrTUhzM01kdHpObk9lbDhHSjBqVFBtRGU5WVcvWGli?=
 =?utf-8?B?bFpsNkVOTlFGVDQ4V0tlSjExZHpZbzRyNkV2cUtqNjhTNjdBRVl0YXZrakZX?=
 =?utf-8?B?M2s5QU9LSFFXTmVhdDNJZ29manNqZDVhMDJMMHdUbmpuYkJ0OU5YNk1zc0Mx?=
 =?utf-8?B?ZnhhdnZ1cFY3R01jQVE4TzY3ekNVZ1lVbE9qT0ZDRVpGbHJVRi92S05qbG9C?=
 =?utf-8?B?ZmhpTkJvU09aSW82NGJPeFhlTGhQemNFcmdQOWx0NC9oUnp1R2J2NG9jb250?=
 =?utf-8?B?em1KR21jK1FqUWF2UVVnSjRPcFBkWDRQS1hTODRWajFldjJsTFdzaEVYdmEr?=
 =?utf-8?B?RzRpSjQwYXRwSEthQU9HZGtSTzR1aWp3Uk1FdURjSll3V1JCRDdMTGY3aDE3?=
 =?utf-8?B?ZFNLWmZLM21hcnFYblVTdlYyVFo1QzNPLzN3U2M3L1o1OFRmMWdBLzF4dzZq?=
 =?utf-8?B?UGxYL2M0N2I2WVZLQ0NtUGhGeGRvMEN4KzJvZEU1NHRndURRN0ZBQnNuZ2Zx?=
 =?utf-8?B?aFJWK1JxSE1iQkJZQ2pUYkgrUlB4bHJQZldHOXJ2U3VzaHZpaTdZNFA0UlM4?=
 =?utf-8?Q?AmyYCfmG2i7hKsI7tvtu3NE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDCCD8CF0844E54FAAA84C7F5D92A306@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ab644c-da77-4a2a-7023-08dc6abca459
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:22.0893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QP2EpWIcSTk490Ep0IvC7kLbQlP+5Klu6ELg9clKiUV5tfbCQV3Qj2Hf30WGnJ8oNGHoyA/ZZ76DYcuuPhF8im7goPJqbHaUsLp5XxNqebj2xuBym8UDNvYVV/wyie4s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7768
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

SW1wbGVtZW50cyB0aGUgYmVoYXZpb3IgZGVmaW5lZCBpbiBzZWN0aW9uIDEwLjIuMy41IG9mIFBD
SWUgc3BlYyByZXYgNS4NClRoaXMgaXMgbmVlZGVkIGJ5IGRldmljZXMgdGhhdCBzdXBwb3J0IEFU
Uy4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRo
aWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCAxMCAr
KysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KaW5kZXggMDJjNWYwZmE0Zi4uYWFjNzY3NzA2MyAxMDA2NDQNCi0tLSBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtMjE2Nyw3
ICsyMTY3LDggQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lvbW11X3RyYW5zbGF0ZShWVERBZGRyZXNz
U3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsDQogICAgIHVpbnQ4X3QgYnVzX251bSA9IHBjaV9i
dXNfbnVtKGJ1cyk7DQogICAgIFZURENvbnRleHRDYWNoZUVudHJ5ICpjY19lbnRyeTsNCiAgICAg
dWludDY0X3QgcHRlLCBwYWdlX21hc2s7DQotICAgIHVpbnQzMl90IGxldmVsLCBwYXNpZCA9IHZ0
ZF9hcy0+cGFzaWQ7DQorICAgIHVpbnQzMl90IGxldmVsID0gVUlOVDMyX01BWDsNCisgICAgdWlu
dDMyX3QgcGFzaWQgPSB2dGRfYXMtPnBhc2lkOw0KICAgICB1aW50MTZfdCBzb3VyY2VfaWQgPSBQ
Q0lfQlVJTERfQkRGKGJ1c19udW0sIGRldmZuKTsNCiAgICAgaW50IHJldF9mcjsNCiAgICAgYm9v
bCBpc19mcGRfc2V0ID0gZmFsc2U7DQpAQCAtMjMwOSw3ICsyMzEwLDEyIEBAIGVycm9yOg0KICAg
ICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KICAgICBlbnRyeS0+aW92YSA9IDA7DQogICAgIGVudHJ5
LT50cmFuc2xhdGVkX2FkZHIgPSAwOw0KLSAgICBlbnRyeS0+YWRkcl9tYXNrID0gMDsNCisgICAg
LyoNCisgICAgICogU2V0IHRoZSBtYXNrIGZvciBBVFMgKHRoZSByYW5nZSBtdXN0IGJlIHByZXNl
bnQgZXZlbiB3aGVuIHRoZQ0KKyAgICAgKiB0cmFuc2xhdGlvbiBmYWlscyA6IFBDSWUgcmV2IDUg
MTAuMi4zLjUpDQorICAgICAqLw0KKyAgICBlbnRyeS0+YWRkcl9tYXNrID0gKGxldmVsICE9IFVJ
TlQzMl9NQVgpID8NCisgICAgICAgICAgICAgICAgICAgICAgICh+dnRkX3NscHRfbGV2ZWxfcGFn
ZV9tYXNrKGxldmVsKSkgOiAoflZURF9QQUdFX01BU0tfNEspOw0KICAgICBlbnRyeS0+cGVybSA9
IElPTU1VX05PTkU7DQogICAgIGVudHJ5LT5wYXNpZCA9IFBDSV9OT19QQVNJRDsNCiAgICAgcmV0
dXJuIGZhbHNlOw0KLS0gDQoyLjQ0LjANCg==

