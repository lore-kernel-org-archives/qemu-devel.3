Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AD0FCC9CA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 06:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzqD7-0001rd-Ec; Tue, 10 Mar 2026 02:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1vzqD5-0001r4-FP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:04:51 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1vzqD2-0007Aj-IR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1773122689; x=1804658689;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vB0QsR3QcKOTYpoxK/e2JLhSUW/4vFIJ25itNpv1EbA=;
 b=RpVsn97Uu8AsADeeExA+IzF4HZqmqERMvCBn54VlKJH07QCow0DkAaXo
 Yus5J6ZueG4/wTHPktXiHMlHxWXy7GczlFrl2Vv84vfRM8iKgxtniinnC
 NUV8z7uahl7SVTF1KNx294rCEicTguvNgwe3kiYIg3p/tHO8sLNR94Upn
 LqZ+frpBfTJ1TP9tvBSrDUyMJes47C568wV28VC5oNKNJ6qv82XyIc/5v
 l0Dgc2Ue6oNTQtBK5F9LIYCDY1Z9ZUAaxaMR2LVMyGL136f5p48PR8z7w
 K6l9Nj9pk+HR4KqgbPnVfAixmQDfIB9JTiSLd7kpD+nMC9S/QKynD+t8U Q==;
X-CSE-ConnectionGUID: gLeVogleSj2iT/hNH+hsfQ==
X-CSE-MsgGUID: 7QgeHa++SPKPZ27GNXFCVQ==
IronPort-SDR: 69afb47c_olHDcxXENAMBexyYQUCPLszJv1o9S1UsseLWDxwZMaObFVu
 Ae12CemvC2F54dJ39jQhAghiU0s2nQxC3+lY8Xw==
X-IronPort-AV: E=Sophos;i="6.23,111,1770591600"; d="scan'208";a="49032871"
X-MGA-submission: =?us-ascii?q?MDE84xfE6swwfbGMIxrEiGl0yIr+awcGfrZljs?=
 =?us-ascii?q?8BMq3oLAVl96v+CZXroMFrguX5uU/6CQEpiT6UWbQf2YSSy6Fx/VA5kw?=
 =?us-ascii?q?twyb84O+Wu6MMm+ohlZW5biy3KkxTR2iMuOAzWZS5SuDpczI21aQtjbm?=
 =?us-ascii?q?QHlqi3GinajcPKxaZJVoKwqA=3D=3D?=
Received: from mail-swedencentralazon11013012.outbound.protection.outlook.com
 (HELO GVXPR05CU001.outbound.protection.outlook.com) ([52.101.83.12])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 10 Mar 2026 07:04:43 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTjH2E//eJ/+sC+zWEovcKjB8j5Fcd5PBQGsjWTOn+6jQ0y3UmDlj7EEI6Z0Xb92ot+IoZ43ZhIGu+QmC77OPJyK5WxV40WmbhkXNyC9YuaimiIG/lRMx+nMNtSEUjSuuGLtzuI2/x/hxFBm6TrCI//NGuGEYKFeJFHF1inO7gkkLGeIgS5u6SMRkID/ecalbqqvcbafCCXMkLWmRaDxLqZBM0OK6TsVNiFrH5qpQXV+H7p2PC7UoHL3EL8yLvngUuOUpA21rukjwMo2znBFt2J8G5285aAMqNseNlZa8bonDZ+yQEIOmus5rabjg3EPenJBtneGTKtkkT4fpzMViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB0QsR3QcKOTYpoxK/e2JLhSUW/4vFIJ25itNpv1EbA=;
 b=sDNxbPlFZbztW552l2ayKRR10a+EPGb8Zezlfand68tVUbqKBFc1RichiMYaH8JMHfxjRP0LlLD2w6NkIxPhKpiX0WsYnqqFg96GYns1CeCTAHVu/QGgAyrX5AfBXiH9v7pC+8tNOKbPwFGvwFXZcy3x/8Lb+Q+GdLXsIKYL+nPjIBAdsrhcUP/b+5CAVxOJAHFGq+3WxpDZZfjYfZUCkv+vP9XMIzOXFumHNOtepbUPvTy4SomAeLima+T9EpBdcBxBoEgce1QyH0kY/JjIPq82hJONUVmLF604/GeoTWlQ6Rh2RCFnbz4QcUnCAnjJB69zTNqLiQbebEIIdYbi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB7346.eurprd07.prod.outlook.com (2603:10a6:20b:24d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 06:04:40 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 06:04:40 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>, 
 "Liu, Yi L" <yi.l.liu@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@bull.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode'
 and 'x-flts' properties
Thread-Topic: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode'
 and 'x-flts' properties
Thread-Index: AQHcr6YD2Nzx+NBx0ki8vSMoUkMB07WmJZOAgAADv4CAAO/UAIAALvwA
Date: Tue, 10 Mar 2026 06:04:40 +0000
Message-ID: <225b43d41004ebce4faaa086152a3677d3fd26f8.camel@eviden.com>
References: <20260309092027.404489-1-zhenzhong.duan@intel.com>
 <02d2312f-99a8-44b2-b55a-b9cbc72feb60@linaro.org>
 <aa7Dw5PBcqLpG5HC@redhat.com>
 <IA3PR11MB9136B00F46D18E977140FFDF9246A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136B00F46D18E977140FFDF9246A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB7346:EE_
x-ms-office365-filtering-correlation-id: 52c02031-9f0b-4b9c-faf0-08de7e6aeaf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|7053199007; 
x-microsoft-antispam-message-info: 1lOoTHQm0CprJJ3vkq03R7oxzRh61qTDn49DNTPz3Wq30+kPAmnhA6uNvaTDM6p8Q0bI8TF72v6q4iTy2ajJVwHI3Wljy+63QdLZ+LEA4Qh6AkuVads8j3t9GKnXsF9FqZCoZZHyGvJV7rf7avu5OEMrEE7UOPWFL/6hq28gbU7Y4EEVhB8QNNw0g9QmwkzPrzG4COm7wj1DhWCfT/cpxm2EAa7Q9mkw21a65Ox3qWnHBgfkQguEg0O9gsOyRsSZMlQi+3XPCqIOw661gPy8eeGabp0eKICYaV4o8ZfDRm8BkPj/zKRY+CBUb5fBBIU1AkUxqd5mfTjwIktJbUXsbZbFoYxVyuW1+x3M163XOU9ImiVEZGqCXS0hkf80gRNkZAzB5OxAX19AlktN1MtdnKX9uov6/aBBlU4qubKzjzv5GFXX4/SHCJ4EQ1VhnuH8Vx0z921orvFa7o/244ZkL01pq70rwdSKU1eqOC/enxic4NlQ0q9za5eH0L5ffNsF3zEsm6rS6kfRsVmjzcPhWXFjgdNTL/uRe3YlE5jzg/m4tPa1PvrdtBiAsf0CFV4NWEGlXP3phmrkDnSAzw3fZ2BsRcRfG2VFqV7f7238axuRsvd3vQgx6/VQCAHrvIhdSr4kyzRXDXXVlXvlR7mBikQURqZSzP+vO4o7TTRaf/HGlnPUFYU5sT2fz0FRWdLnwfrqHVq1r3jrRiagSe3xbTP3S7pmDMK4HiJmEr4VGM9lWIQvEGJr4a/QAhTu4DQl+Hn0u/yHt8BPTQu83RFv6gW6HewPzp4ntufNLqEqaQc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bExVb2g0YmZ0alFUUC9MYmFsbFVjOU9Tc1hsbE50MkZmSlUrLzYyTXYrWldy?=
 =?utf-8?B?M0NvbFFGZmVBbk56V0xZNzA2bmZCSStOdlVxT0tvazdyaTd3eVlqN3duMmxh?=
 =?utf-8?B?aG9ENnVaYUlZekIzaFF4UVIwRUR0OG9TNkNieDJyOWx1L0ZqYnVsblg3UXBa?=
 =?utf-8?B?UjJJWHM0T3VZMUpFdXJvYzBiMWM4Vk9sNWwvUS81bDJTMmdDazFVNzZuSmZs?=
 =?utf-8?B?U3drdlVyWVp2TnVhQWg2M3dPR1Y4K2w5a1RRUzVnN21oV0pvdUtXVkF0ZzJz?=
 =?utf-8?B?MG1GbUtUNFJpRlBMN05YMXM2eDVLSGZXNjZKeGw5TUxMdEVCaXpDdGJsc3cv?=
 =?utf-8?B?dzU0d2xXanY2YW9vdi9Hc1RjRGpIM0hQSEJvdkFta011cnNUNDBPMkltU1gw?=
 =?utf-8?B?VHdJNTg2NlBwcXpEWXIxLzVZa04rVTZDVGJwNHVFbTNja0JSRzErTXVUWEFu?=
 =?utf-8?B?WkxiTnlDQXYyeFRGZ0tJV2laQ1hnV3gzQWdKOFduVjRMdmw5bks3L2FISW84?=
 =?utf-8?B?K1crMHViZ3JMZGQwQWNDemM4eXYrYXN1UWd0Tlc1YzQrV3QvamRZSE9ZaGJO?=
 =?utf-8?B?WmYrdUpBL2pIdkRsT3lYTzRoUTVvT1RobjFYa1VPcVIrdWorOGNlUGVJTXZM?=
 =?utf-8?B?ODdTa2ovRmxMaGxsckcrRTZ4eVNYZWxYdGNFNUkvdVpNVStIbXdWa1RHWTZB?=
 =?utf-8?B?YllsOWtLT0ZReUlDN3hHMlByVjl0Q0txKzEyejBNbEJxZW1WUVY3ODg5T0RS?=
 =?utf-8?B?QklMbWluVmtPNXYwRjMzS3FoNWEzUzhwTXk3VXREeWJScSsybytSWUkraUdU?=
 =?utf-8?B?aWNGeGhGV0FzUDRSK2VxN0lYOE5yOFdwMlRVTjErdFlFQUlLUkZ2VGQwQmJM?=
 =?utf-8?B?Z2xTb2lpdzRMdTUwOGtRYndLU2pHaTFqb0NmRVBPNnZVdUFYZTdZMUhpdzlh?=
 =?utf-8?B?cWFXMkJGR1NLRGFNQVFiVEkyM2tuSFhpRSsyQWNaYXBJSXk2MGVtWHNEMDJp?=
 =?utf-8?B?ZHllUmU5NmoySnhkZ1Vpa3hHKzNwVldFeTNQWnlTN1FYeURuTFN3WWxJZ0VK?=
 =?utf-8?B?Z3JOT2I4TkIwWmV3ODM4ZHJzaXVaNmtuVUR5bEJ4Mlh1azBaSlQzZkoxR0ZM?=
 =?utf-8?B?VWVZS1JYOWt2UElTTEZDVVVpQ3JqbktJVFlLMWptVXFqU2NuL3Q1d0Fzc1BR?=
 =?utf-8?B?UWFFdVYwdWZiZTk5ZzYzaEtEN2lDWUJGN056OHNqOHNPQ3ZLRWlIQ0lEbWdr?=
 =?utf-8?B?S1B0MVNPR2JPVnhUTzdQb2FPR3JiWVN5RDgvenNlSWZNSWZUU1kyaFpZb0ow?=
 =?utf-8?B?OVRZUWxEOVp4MFJSNWFPcHRNU3lRRXN0UlA1dnoyTlpJbmZaYUk2aVhrU1Bk?=
 =?utf-8?B?WTUzN2VWQVNVR0YzQ0ttdnFPSFZCR0E3emgyc1hxWEVxOHpNOTZ5QlBVaE9P?=
 =?utf-8?B?clBBWjU1VVBrYitvY3l0QzNHRGtHeTFNUDF1ZnZicmlkWnFXcW9qaUZwbWZs?=
 =?utf-8?B?US9BWjVaNXV6bXdsdUluWDhJUFNTVGdMSVkxQUR4VEV5Tk5IK1ZLUUp5YnBP?=
 =?utf-8?B?TldhRll4cUo4bVg3YkFhZVlwYzRJSENiK3VEaCtOMG5BUkxjU2I5N3c1UUdq?=
 =?utf-8?B?VEk2b2J5T0lBZ0kvWjRvdkU3OGt4SGYxeXRvL0I0bmNnYndINzlNbGhoK3lj?=
 =?utf-8?B?R0FIKzlBK0l3NTUyMytkNmsyZ2xmMWhHUm5DVEppQUNVRXBkNDlyWFR5OE44?=
 =?utf-8?B?dFBGZXFsbUswYW1ZZVVJRlJQYnVFSU1PRVNNald4dVdPM2ZqOWYxd0hYb3U4?=
 =?utf-8?B?bkw0L0kwbFpLYTlwN1NFR0trd3JITXhyZ0x6VjZhRk94ZWVNck8vc0dJVEpn?=
 =?utf-8?B?eVBiWkZmODExTDJBUmZ0b2NxczBBbFM1OVhNY0c3aDdoK1RyRmdpdWpsVUhM?=
 =?utf-8?B?dW5DS3MrTXVNZ3p1UjdLaTF0K2pTQitGcldQL2wwc0F3d2plQlVzRklsSmZQ?=
 =?utf-8?B?UEtodTYzd3l6L25oenR0MEVOcVl5dXdkZlFRdkloVGxRTHF6aEJKd0FNV3Ew?=
 =?utf-8?B?RmdIRjA5Y3JGRkZFTENtdjVNMkxaRitkSzBBaEVmUFJ3L2h6TlUyakY4NDhm?=
 =?utf-8?B?aFVORldMbFdHcEs1eGZFYkxBdGJJMTdma0dJaWRJZmt4UDZ3RUk5eElINGt1?=
 =?utf-8?B?d0JMN1NBd2xPdnBrdXVldFcwV0Ztd2RpdHpXWUpvenRTUGdDdk1YMGw4Vm9n?=
 =?utf-8?B?cDNyWU93YUY2dDM2NC9MTWgyN3U1S0prU3JhNTY3bnlkWjQ2S1p4NFMvcTRr?=
 =?utf-8?B?N2VGYW9XeDV2NmdVL1VDcmF1UEtKQU1vRWZvYVJzVUVJVk1GVDkzS0xFK3Jq?=
 =?utf-8?Q?EA3/oXakdTs8RyPkg3pjhl55vZnEZCQ56RiUv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69FE31FED2058C479ED555D798E5A0F7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nCjS51juADOPyglwFUOCP9C3i4ZABtk3uYiVh/gWOQw8T5Rh53iZ3pNJHmJajXj5eGzRXrgMGJ7I/ACjso5OtCXVGw6HCOZh3vlPJc4/w+I+M5KL+mX56d9WxNV8StVo6phWTTobZIPHfIZQLIjK/77deQiq/htJggUESd5/diwETnxdZkActrsKsqyCYo7hLTFFG0my0AXymHFxkI3rCXVHyiZ5EFmpVCCvUu7StBGkBXx/fcOfu6t10RYNHap2O2DKGet/HubOdZT/YFEwfQgc8DY3vWS84jK+GopHEzt7tquxy06/Kg40KSUL1KfvTSFLwk1m+L8S23suIrOhbg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c02031-9f0b-4b9c-faf0-08de7e6aeaf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 06:04:40.6342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fv5tXQqtzpMSWnqDzlHDY1IXhHuAqzkTjOFP221OrbK5lT+GswFLA9h+9iYcIn0Qa9UWDMdszekdDFBvIopwFXFq+NbdVCyxn5tHX7dqLV2gLaYH/sfV8SEDyZhbOEG9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7346
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost4.eviden.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

DQpPbiBUdWUsIDIwMjYtMDMtMTAgYXQgMDM6MTYgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90
ZToNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IERhbmllbCBQLiBCZXJyYW5nw6kgPFtiZXJyYW5nZUByZWRoYXQuY29tXShtYWlsdG86YmVycmFu
Z2VAcmVkaGF0LmNvbSk+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9tbXU6IFJl
bW92ZSAneC0nIHByZWZpeCBmcm9tICd4LXNjYWxhYmxlLW1vZGUnIGFuZA0KPiA+ICd4LWZsdHMn
IHByb3BlcnRpZXMNCj4gPiANCj4gPiBPbiBNb24sIE1hciAwOSwgMjAyNiBhdCAwMTo0NDoxNVBN
ICswMTAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gPiANCj4gPiA+IEhpLA0K
PiA+ID4gDQo+ID4gPiBPbiA5LzMvMjYgMTA6MjAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiA+
ID4gDQo+ID4gPiA+IFdlIGhhZCAneC1zY2FsYWJsZS1tb2RlJyBmb3IgbW9yZSB0aGFuIDUgeWVh
cnMgYW5kICd4LWZsdHMnIGZvciBtb3JlIHRoYW4gMQ0KPiA+ID4gPiB5ZWFyLCBpdCdzIGZpbmUg
dG8gcmVtb3ZlICd4LScgbm93Lg0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBpcyBhIHByZXJlcXVp
c2l0ZSB0byBlbmFibGUgaW50ZWxfaW9tbXUncyBzY2FsYWJsZSBtb2RlIGFuZCBmaXJzdCBzdGFn
ZQ0KPiA+ID4gPiB0cmFuc2xhdGlvbiBzdXBwb3J0IGluIGxpYnZpcnQuDQo+ID4gPiA+IA0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8W3poZW56aG9uZy5kdWFuQGludGVs
LmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSk+DQo+ID4gPiA+IC0tLQ0KPiA+
ID4gPiDCoCBkb2NzL2RldmVsL3ZmaW8taW9tbXVmZC5yc3TCoMKgwqAgfCAxMCArKysrKy0tLS0t
DQo+ID4gPiA+IMKgIGh3L2kzODYvaW50ZWxfaW9tbXUuY8KgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
OCArKysrLS0tLQ0KPiA+ID4gPiDCoCBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmPCoMKgwqAg
fMKgIDQgKystLQ0KPiA+ID4gPiDCoCB0ZXN0cy9xdGVzdC9pbnRlbC1pb21tdS10ZXN0LmMgfMKg
IDIgKy0NCj4gPiA+ID4gwqAgNCBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMiBk
ZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kb2NzL2RldmVsL3Zm
aW8taW9tbXVmZC5yc3QgYi9kb2NzL2RldmVsL3ZmaW8taW9tbXVmZC5yc3QNCj4gPiA+ID4gaW5k
ZXggNzhiY2RmZmFjNy4uNTc1NTUzMjQ0MyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZG9jcy9kZXZl
bC92ZmlvLWlvbW11ZmQucnN0DQo+ID4gPiA+ICsrKyBiL2RvY3MvZGV2ZWwvdmZpby1pb21tdWZk
LnJzdA0KPiA+ID4gPiBAQCAtMTUzLDIyICsxNTMsMjIgQEAgUkFNIGRpc2NhcmRpbmcgZm9yIG1k
ZXYuDQo+ID4gPiA+IMKgIGBgdmZpby1hcGBgIGFuZCBgYHZmaW8tY2N3YGAgZGV2aWNlcyBkb24n
dCBoYXZlIHNhbWUgaXNzdWUgYXMgdGhlaXIgYmFja2VuZA0KPiA+ID4gPiDCoCBkZXZpY2VzIGFy
ZSBhbHdheXMgbWRldiBhbmQgUkFNIGRpc2NhcmRpbmcgaXMgZm9yY2UgZW5hYmxlZC4NCj4gPiA+
ID4gLVVzYWdlIHdpdGggaW50ZWxfaW9tbXUgZmVhdHVyaW5nIHgtZmx0cz1vbg0KPiA+ID4gPiAr
VXNhZ2Ugd2l0aCBpbnRlbF9pb21tdSBmZWF0dXJpbmcgZmx0cz1vbg0KPiA+ID4gPiDCoCAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gwqAgT25seSBJ
T01NVUZEIGJhY2tlZCBWRklPIGRldmljZSBpcyBzdXBwb3J0ZWQgd2hlbiBpbnRlbF9pb21tdSBp
cw0KPiA+ID4gDQo+ID4gDQo+ID4gY29uZmlndXJlZA0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IC13
aXRoIHgtZmx0cz1vbiwgZm9yIGxlZ2FjeSBjb250YWluZXIgYmFja2VkIFZGSU8gZGV2aWNlLCBi
ZWxvdyBlcnJvciBzaG93czoNCj4gPiA+ID4gK3dpdGggZmx0cz1vbiwgZm9yIGxlZ2FjeSBjb250
YWluZXIgYmFja2VkIFZGSU8gZGV2aWNlLCBiZWxvdyBlcnJvciBzaG93czoNCj4gPiA+ID4gwqAg
Li4gY29kZS1ibG9jazo6IG5vbmUNCj4gPiA+ID4gLcKgwqDCoCBxZW11LXN5c3RlbS14ODZfNjQ6
IC1kZXZpY2UgdmZpby1wY2ksaG9zdD0wMDAwOjAyOjAwLjA6IHZmaW8NCj4gPiA+IA0KPiA+IA0K
PiA+IDAwMDA6MDI6MDAuMDogRmFpbGVkIHRvIHNldCB2SU9NTVU6IE5lZWQgSU9NTVVGRCBiYWNr
ZW5kIHdoZW4geC1mbHRzPW9uDQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gK8KgwqDCoCBxZW11LXN5
c3RlbS14ODZfNjQ6IC1kZXZpY2UgdmZpby1wY2ksaG9zdD0wMDAwOjAyOjAwLjA6IHZmaW8NCj4g
PiA+IA0KPiA+IA0KPiA+IDAwMDA6MDI6MDAuMDogRmFpbGVkIHRvIHNldCB2SU9NTVU6IE5lZWQg
SU9NTVVGRCBiYWNrZW5kIHdoZW4gZmx0cz1vbg0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IMKgIFZG
SU8gZGV2aWNlIHVuZGVyIFBDSSBicmlkZ2UgaXMgdW5zdXBwb3J0ZWQsIHVzZSBQQ0lFIGJyaWRn
ZSBpZiBuZWNlc3NhcnksDQo+ID4gPiA+IMKgIG90aGVyd2lzZSBiZWxvdyBlcnJvciBzaG93czoN
Cj4gPiA+ID4gwqAgLi4gY29kZS1ibG9jazo6IG5vbmUNCj4gPiA+ID4gLcKgwqDCoCBxZW11LXN5
c3RlbS14ODZfNjQ6IC1kZXZpY2UgdmZpby0NCj4gPiA+IA0KPiA+IA0KPiA+IHBjaSxob3N0PTAw
MDA6MDI6MDAuMCxidXM9YnJpZGdlMSxpb21tdWZkPWlvbW11ZmQwOiB2ZmlvIDAwMDA6MDI6MDAu
MDogRmFpbGVkDQo+ID4gdG8gc2V0IHZJT01NVTogSG9zdCBkZXZpY2UgZG93bnN0cmVhbSB0byBh
IFBDSSBicmlkZ2UgaXMgdW5zdXBwb3J0ZWQgd2hlbiB4LQ0KPiA+IGZsdHM9b24NCj4gPiANCj4g
PiA+IA0KPiA+ID4gPiArwqDCoMKgIHFlbXUtc3lzdGVtLXg4Nl82NDogLWRldmljZSB2ZmlvLQ0K
PiA+ID4gDQo+ID4gDQo+ID4gcGNpLGhvc3Q9MDAwMDowMjowMC4wLGJ1cz1icmlkZ2UxLGlvbW11
ZmQ9aW9tbXVmZDA6IHZmaW8gMDAwMDowMjowMC4wOiBGYWlsZWQNCj4gPiB0byBzZXQgdklPTU1V
OiBIb3N0IGRldmljZSBkb3duc3RyZWFtIHRvIGEgUENJIGJyaWRnZSBpcyB1bnN1cHBvcnRlZCB3
aGVuDQo+ID4gZmx0cz1vbg0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IMKgIElmIGhvc3QgSU9NTVUg
aGFzIEVSUkFUQV83NzI0MTVfU1BSMTcsIHJ1bm5pbmcgZ3Vlc3Qgd2l0aA0KPiA+ID4gDQo+ID4g
DQo+ID4gImludGVsX2lvbW11PW9uLHNtX29mZiINCj4gPiANCj4gPiA+IA0KPiA+ID4gPiDCoCBp
cyB1bnN1cHBvcnRlZCwga2V4ZWMgb3IgcmVib290IGd1ZXN0IGZyb20gImludGVsX2lvbW11PW9u
LHNtX29uIiB0bw0KPiA+ID4gPiBAQCAtMTc3LDQgKzE3Nyw0IEBAIGJlbG93IGlmIGl0J3Mgbm90
IG5lZWRlZCBieSBndWVzdDoNCj4gPiA+ID4gwqAgLi4gY29kZS1ibG9jazo6IGJhc2gNCj4gPiA+
ID4gLcKgwqDCoCAtZGV2aWNlIGludGVsLWlvbW11LHgtc2NhbGFibGUtbW9kZT1vZmYNCj4gPiA+
ID4gK8KgwqDCoCAtZGV2aWNlIGludGVsLWlvbW11LHNjYWxhYmxlLW1vZGU9b2ZmDQo+ID4gPiA+
IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11
LmMNCj4gPiA+ID4gaW5kZXggZDI0YmE5ODliZi4uMDAxODQ3YWQzNyAxMDA2NDQNCj4gPiA+ID4g
LS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPiA+ID4gPiBAQCAtNDIwMCw4ICs0MjAwLDggQEAgc3RhdGljIGNvbnN0IFByb3Bl
cnR5IHZ0ZF9wcm9wZXJ0aWVzW10gPSB7DQo+ID4gPiA+IMKgwqDCoMKgwqAgREVGSU5FX1BST1Bf
VUlOVDgoImF3LWJpdHMiLCBJbnRlbElPTU1VU3RhdGUsIGF3X2JpdHMsDQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVlREX0hPU1RfQUREUkVT
U19XSURUSCksDQo+ID4gPiA+IMKgwqDCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgiY2FjaGluZy1t
b2RlIiwgSW50ZWxJT01NVVN0YXRlLCBjYWNoaW5nX21vZGUsDQo+ID4gPiANCj4gPiANCj4gPiBG
QUxTRSksDQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gLcKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJ4
LXNjYWxhYmxlLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsDQo+ID4gPiANCj4gPiANCj4gPiBzY2Fs
YWJsZV9tb2RlLCBGQUxTRSksDQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gLcKgwqDCoCBERUZJTkVf
UFJPUF9CT09MKCJ4LWZsdHMiLCBJbnRlbElPTU1VU3RhdGUsIGZzdHMsIEZBTFNFKSwNCj4gPiA+
IA0KPiA+ID4gDQo+ID4gPiBJTUhPIHNhZmVyIHdvdWxkIGJlIHRvIG9mZmljaWFsbHkgZGVwcmVj
YXRlIHRoZXNlIGluDQo+ID4gPiBkb2NzL2Fib3V0L2RlcHJlY2F0ZWQucnN0IGFuZCBrZWVwaW5n
IHRoZW0gYWxpYXNlZCB1bnRpbCBkZXByZWNhdGlvbg0KPiA+ID4gcGVyaW9kIGV4cGlyZXMuIE90
aGVyIGNoYW5nZXMgTEdUTS4NCj4gPiANCj4gPiANCj4gPiBUaGUgcHVycG9zZSBvZiB1c2luZyBh
biAneC0nIHByZWZpeCBmb3IgcHJvcGVydGllcyBpbiBRRU1VIGlzIHRvIGRlY2xhcmUNCj4gPiB0
aGF0IHRoZXkgYXJlIHN1YmplY3QgdG8gY2hhbmdlIHdpdGggbm8gd2FybmluZywgc28gd2UgYXJl
IGZyZWUgdG8gY2hhbmdlDQo+ID4gdGhlbSB3aXRob3V0IGFueSBkZXByZWNhdGlvbiBJTUhPLg0K
PiANCj4gDQo+IERvZXMgdGhhdCBtZWFuIEkgY2FuIGFkZCBhbm90aGVyIHBhdGNoIHRvIHMvZmx0
cy9mc3RzIG9wcG9ydHVuaXN0aWNhbGx5PyAgDQo+IGZsdHMoZmlyc3QgbGV2ZWwgdHJhbnNsYXRp
b24gc3VwcG9ydCkgaXMgYSBuYW1pbmcgYmFzZWQgb24gb2xkIHZlcnNpb24gdnRkIHNwZWMsICAN
Cj4gaW4gbmV3IHNwZWMsIGl0IGNoYW5nZWQgdG8gdXNlIGZzdHMoZmlyc3Qgc3RhZ2UgdHJhbnNs
YXRpb24gc3VwcG9ydCkgbmFtaW5nLg0KDQpIaSwNCg0KSW5kZWVkLCB0aGlzIHdvdWxkIGJlIG5p
Y2UgaWYgd2UgY291bGQuDQoNCj4gDQo+IFRoYW5rcyAgDQo+IFpoZW56aG9uZw==

