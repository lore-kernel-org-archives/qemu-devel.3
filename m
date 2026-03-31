Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAC4FF60D2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Sue-0006qj-Sc; Tue, 31 Mar 2026 02:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w7Sue-0006qQ-77
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:49:20 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w7Suc-0008Kx-2Y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1774939758; x=1806475758;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QtbccpbY1BFf0xToYiWiBVFMLQx6fmRUs0YkDk2udd0=;
 b=i/pCG0dR4iUMkCSys/7X1kPh64Fs4YqrQ4MMYEFWCHXKz6hB4v9rkeec
 nYJ00umNr9w/y4dNLju6x7Hf72bfRDC7EiplyaqaMlt3ZD6pTy57QBWeM
 +2gqI3qBMGcoOT80e75khBPModH90Cci/nU8oF+eoNfAzwvdtt45Go6tr
 DeZaWdSwDrObzWkyMVb7sfZ3DSqRgjqIBTTrzZrKFxW7+9fyZrGx5cqIL
 /eq1ijM5AIvSG4e5aV5URQiW9v2ofhdh15DeHKDmLRFgizC0n+JMbnOIL
 zZRKRslAo0YjUeB2zwlyrqqJTPJXNsSJq6agZycIxl6IP0KaCs/rv4XbM A==;
X-CSE-ConnectionGUID: Wwij9l9bT8i9Hg5IZXyadQ==
X-CSE-MsgGUID: G7spm8lESuGO0g/DgJhDsQ==
IronPort-SDR: 69cb6e6b_HuxfrtzMbUn9k49jf6pBdqCIYbT8cp4FoD9up5C+S513s9a
 G6AccUjdf+CBQiOtV3pXuIHX3125fWo1SPa0G7Q==
X-IronPort-AV: E=Sophos;i="6.23,151,1770591600"; d="scan'208";a="47280306"
X-MGA-submission: =?us-ascii?q?MDEFcBgHpSKP1Y88KRRy2Hp0+hL6Z+yqjqHOpn?=
 =?us-ascii?q?tjgUZa1kJkiuKA2oQf3nMkVKoSGlzqvKp8M8S414Tt40E4KyKJtPsRP0?=
 =?us-ascii?q?YgQ/4qgONUhWzlo+kVI+TKGvs8uZ+2wcVBqjrW60jUv/pLhYzDgD2C+x?=
 =?us-ascii?q?BVWAsMqcvLYAX/W/j0dMsk/Q=3D=3D?=
Received: from mail-northeuropeazon11012039.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.39])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 31 Mar 2026 08:49:14 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZcrChSc8+3lHtpwFOU8PjwKLSp0aYK4u6HnIISBxSSVEa+pKzpYVen5nPRU5A3KNItIXFD21LXWznVrXpswdfs7a4LUbdlm8IdJJox+YuTgSVrJGdUblxOGbUtfp7PlEJZ+6a4bo8zXzAsjYJAa+dABhAuu5TBJ9krlyFW8fy5NZP6GWpU5RCqtQuw4akJ40S+eVMhOZu3xwXL2823dkCP5xOMVf1Xw2MUb77PfHRMsNi+/7n+/k+wv0tzDZeFvRbQqqLJTchGT5OaZp6WNHtHMqiwK5/diazDMcnKjvV2GsGY4Sl85B8qVKwaGfJbg952FTu3QuwMiLMZCdV78eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtbccpbY1BFf0xToYiWiBVFMLQx6fmRUs0YkDk2udd0=;
 b=KJIHPa8s6E0PWPouZvG9RlDYs+QR7EE8Uq5WzSKbc+aniKAj9lYm4Eecx5kwdxBO4t6SrMKCn3iiJO2gfXdpJWKNr5Vpp5BTG6TbAXMigX3T6wfIqBixvY0DJGyQLKUvgdwT/LRB66NIcH3ZLfwrc7RjHFWpFa7axu6x55keV3DqyeJe2/6bsLqmDLZqQ+ybyBmv1JFHDNr1ZZmQc5u2Z6IQrm68Cm5fXg1xU6coWJ1z92JPQQw8VV3ZZEy49/LzSCjp8kXgpbIWh+eo6FDIG71A8B0q5U0pDFeWXb40BRJTfgguQBcnbPUWxEvDZxcT1aqc3nR/O4wLexokSTphUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8557.eurprd07.prod.outlook.com (2603:10a6:20b:4f8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 06:49:10 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 06:49:10 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@bull.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: Re: [PATCH v2 05/14] intel_iommu: Change pasid property from bool to
 uint8
Thread-Topic: [PATCH v2 05/14] intel_iommu: Change pasid property from bool to
 uint8
Thread-Index: AQHcvQCeefg/Slq3OUyWdGqwJlSRxLXBys4AgAA1foCABjp/gA==
Date: Tue, 31 Mar 2026 06:49:10 +0000
Message-ID: <0b9e42b9a4469995002334308ddab50d3bc3fbf8.camel@eviden.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-6-zhenzhong.duan@intel.com>
 <e5422d16-8728-47e3-b2e7-c8f1a076a2e5@intel.com>
 <IA3PR11MB9136B433BE767113C5F4CF8D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136B433BE767113C5F4CF8D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8557:EE_
x-ms-office365-filtering-correlation-id: 69ef8957-58f8-4cd6-179e-08de8ef19ce7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003|38070700021|13003099007;
x-microsoft-antispam-message-info: JThfBvUjm8DYJLNTt2SuV/fZzilbZ4W0BtTVC8TksfwPUIxLXSX8B1DQaWFWpGUwxleYYFrvQ4B/tp7tnovrk9iEcIh+H/6SqlcXRKuVbrVMD7w2zTPVAF/tRGK7DXkcsSTfF7qODaKKiS2e6boaSFpKUcV+zC2cO+fa8y3e1sxbodXsbh5PoTwfHDwARF2os7H68F18Xwwx/e+LZRTr0JvlWe2O7njTbqkSXP9/pR9QsFdz6oDmogip+0NjpEtaO/+Ugvyrn35NWWiQoxG9HxTw2bDt6xVDAb+QYtOBBdx4Gfm/RoMPtjN3OMmOQedco+eRtklkbcJBy5EDjQevOPvyXwamKiv69fT58EiA4V7u5L4b2cT/Hu/BgWAqQAwhxc5S8LSBFX16ifZIRWVjcvoaJxrsEoJwJZw6ThhiLSg8Iy9qA2xImUG6Ad3jr5RSyAoQBV6YFz6TeQ40o0I8g6O9i29XHKRu60QeQs3gmxAf0FRYdNOPX6N9aGWu06n85cf3OnZTA1pPwM5mRbFhrKDziBnH2fmQtv4Riu4PI1qN+50YLLdRjY71sxOCxaOWVG1R08RgkaApRvnhYJfTT2ZXAoQJBHUq5okPa0tkyXierqGXUC4FUP9vho8KGKjZXJJ8Ch79be+xjdJqabnrmqyeg5Y7f9GSRVnGcl9Cg1/Vnp4oiwfGrEMb/NpsYqT/KrMAM20rF18TUYCFYa2kmulpqJwLUW73ul5WVbHi3xfBb+e+T/5CP3/to0yEIH6CEjZX6fhADZJ7vkM78SgkBa2QTLRmJ3uZuuFVISuw5rQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003)(38070700021)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTl2WDdnNm1lZ1doTjZhUmxXYXhnT3QwM3oyb0tHRlNkWGZJSnR2UElzb0Vj?=
 =?utf-8?B?NElIN2U3UmpjVmc1U21PUUZjR2RmSHhHUWdjRko3MUZwZXp2ZFZPQi9JZEwv?=
 =?utf-8?B?WGw2TE1uRkZRMkN1NWRuTlRja2hRNE92Rmc5YVNPbmVzMStBZlA2bHJuYmUv?=
 =?utf-8?B?bmw0QklPckhaZ0tjWjBvejBCbHpzWDdiNTBoQ01KVTVGN0Z1SGREMlJtMHdl?=
 =?utf-8?B?MEpaRVY3cWRQYjZJK1cvd1dJOGZkcHFnZ0h0ekFYRTQydTJwbFkzMEtTaytP?=
 =?utf-8?B?a2ZCMWVGYnlRNHgvVXlXQnEzVU14ZDQvdWtpT3lheEtEREV6Tkg2akNianFZ?=
 =?utf-8?B?L2RlYkJoSEw1Z3pqbTFkZWxja05wcUlSZWR1WW5CbmpsVVNrL1ovMENML0Vs?=
 =?utf-8?B?QjdxRGxlRHlmdStzTUx1Vld6TnJWamNld0ZSWTFsVWZ0ZjhXdjdnVklTeUtR?=
 =?utf-8?B?MTROQXYvaFhrZFk2K1FQM3EwR2o4ZFUvR20vdGFPYUJHdUM2MmpuNll6OVkr?=
 =?utf-8?B?aWJCb1BXTmJGdFVHUmpQSE1lTHQvTTNwUG9oSGxnN05ieCtoY2xFQVNLbEps?=
 =?utf-8?B?VnJtM2U1bFF0WXgvanZXZloreVpDQ0dNS1JYVDJ1UjNIeDgyQzNJUlErWWZK?=
 =?utf-8?B?d1h4N3lIT3dKUlREUVJGL0VZMXFPdDUvUFZDSUtpTENFckNWQmlaTW9LQnNm?=
 =?utf-8?B?VGdrR0xEaFppVVJQdEI0dFRlSnhObFNtUW55cVM5TjdRbnRiOWFsQnQ3UGND?=
 =?utf-8?B?SHh5Q1h3N0lsWkJ0VXZVd1JCUjlxc2dUenZReHZmWVA1NEF4eGtjNC92UmtR?=
 =?utf-8?B?cG93RFd6Zmh1dUl0R1ZuUFVPRDBXeWdGNXlvOE9TTXMvb2VEakVOT3BaSnVn?=
 =?utf-8?B?ckE5U3R4ZnQ3UE80VjRWY3V2bGNIa0NuT0tvU1hESGpwdFVPcWFwcThqLzhp?=
 =?utf-8?B?eEV0Ukt6NUxvMGh1cU43SXdXZUJRcFA1ZnJ3YXZReXBPRC9ncEpucmR5NDlw?=
 =?utf-8?B?UXZSY09vNk1JTG5TMTJ3MzhuWUdQRlpHMDJJdzZ1dXdvaFdINDJ5ZUlzckFj?=
 =?utf-8?B?eXFraWc0bW5tcHgrRWpJandxTGxXR2twRCtUbktZblkxL2tqQm9mT3lyVnlT?=
 =?utf-8?B?YjhhdXd6QkdqTm9wWElYTXR6QzFQMVNCN0ZNeFJNVjBiR1hnaVRIbTFlWks5?=
 =?utf-8?B?U21KZmVxRTd1dVhLaVNRVzltcXJqUFhzUllkc1pLRU4wZUNoYjJvdjQ4bHM2?=
 =?utf-8?B?cWdyTk5Ob25SWXV1alRCb0tnSHI3SVlwRjA4WnAwMFNjVUZGaVYyRWRkZ3F2?=
 =?utf-8?B?Um4rUU1XZXdiSDZEZUs1aHc1aUZ3ZE9jKytYeWwySU5tZElWazRGQlo2MWEx?=
 =?utf-8?B?UFZ1dHhVQ0Y0L0VRb0pJU0JBOGhaSnBpY2grMHFkdG9xcXhwQ2dnMEJvdkNL?=
 =?utf-8?B?RDZyeFRaNUxvS21XYnQyT200TlNsUmJRQ21SMVMxNkZZekVMNHIxWDUwdDc5?=
 =?utf-8?B?SWVYU1hzeGhPYkdsQ3BGOEVLZGY2NTVSMzYzajNQT0twbnhwU3h2VmQxTnBn?=
 =?utf-8?B?aHFzb0VlWmZzOWdHUlA0UzN6V1ROc0t6cEhFNVJOQXQwblQzd3VMVHBwckN5?=
 =?utf-8?B?OWJtcTdCM04zRFU1RWVGS1FIUlg5WExzK0dKZUtuSUhCeSt6Z1FDS0wwRSt5?=
 =?utf-8?B?b0l2Sk5OeFozRUFETVlwTUQxVzl6WUxlNXU1N2NFNy84ZG5ZY2ZzSUpDVzA0?=
 =?utf-8?B?eFVuTkxTYTlzOWpWT0t3dnY5SzF5R3c0QVMxT2N3Qm92YlBKaFhOWEc0RVVw?=
 =?utf-8?B?U1pKUnF5d25vMUt4aVA1ZUdyQmhYTnJ4ckxzYmluVTFhVG5RNmkzZnRBV1JT?=
 =?utf-8?B?UmcwVkhWQnNueWNCZ2ROVFQ5Y1R2SG5HNTVyOVMwWmZZcWRHdC9YYjErSXhz?=
 =?utf-8?B?aFpuRE9Rc1JLcUVvZW5ja3JPZEVqS1dnVm1xaHB3TXI2QndBV0hCckxvZDNU?=
 =?utf-8?B?bnRRM0tmZHE0cFpnSXRRUHNXV0QxUFZDQ01IbTdMNE1uell3aUk5bk80RDFP?=
 =?utf-8?B?WlJNUUg3dTFRSG9sOTMrNHNuS2lxNGpvWGtHQXpQWGVDV1NHUEtkMVpQNTJh?=
 =?utf-8?B?ZWh3ckVnNncycXpmTWpqQjRTc1R6blNsaVYyUjd6Rmk5R3luM09Gc1k5RVJj?=
 =?utf-8?B?emJXeGIrTGFTSFhoRW9FcmtWTXZ5TE1NT2FpK1lNN3JXd0I3S1UwM3FCak42?=
 =?utf-8?B?YlZkYWhUejFMMFFpN0dVL3Ewa2laRUg3bGkybEM5VFRqbGpVRWwzckpEVGdZ?=
 =?utf-8?B?UGdkRTZPRWRJVDRublVGSDYxR2xId0x2SWVudTZNSVo1anNDQ0I4STRwRzNt?=
 =?utf-8?Q?JYWCYmodZ0l5x1D5jsFqBW3x98SCLrrmVIjf4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DDBF3FD639EC342ADED5E6789CB2C5D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hAo+W1G+QuWkAL2QWjjoRrW3WCJbn/BaewSYd+IV8EtJrb5SagBRJBvWzuwbxQAw/jyUPWqnAUDK17k5O5r4FzUOnxXbvAlRnNYc4sZ8zQeCX3KH9WpK7ucKmjqp5gDzoMu/RrCqyhD8igR5iXK78yB0QuZaB13Q4SbeYBPtZcRi8cr9u4VeXmAznzbl1P5Z5A2CjQbd1VHtw0a83j1IC530IQmk2YQd6Z8l0UbkkngmwT2RZnmr4W82np/TPFusR/u3u0RDrTPpjsEU68T+bs704YtPd+3Z1BiESW/I+RcnUf3JEzsGBJVJbDIFlnwR0YWR61Mz0D7EAK1+JhPIuA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ef8957-58f8-4cd6-179e-08de8ef19ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 06:49:10.3521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djRFsoahNaBL1F48cNTr6XFSLOwxAuYBLGU9Dnj2PAZ0T2JJn4Nq0SURsSdjxBazHNPJzozHridkNErBb7l2JMYtXdt5AixGfkAvt8vWlhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8557
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost3.eviden.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

SGkgWmhlbnpob25nLA0KDQpXaXRoIFlpJ3Mgc3VnZ2VzdGlvbnM6DQoNClJldmlld2VkLWJ5OiBD
bGVtZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbT4NCg0K
T24gRnJpLCAyMDI2LTAzLTI3IGF0IDA3OjQxICswMDAwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6
DQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBM
aXUsIFlpIEwgPFt5aS5sLmxpdUBpbnRlbC5jb21dKG1haWx0bzp5aS5sLmxpdUBpbnRlbC5jb20p
Pg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDUvMTRdIGludGVsX2lvbW11OiBDaGFuZ2Ug
cGFzaWQgcHJvcGVydHkgZnJvbSBib29sIHRvDQo+ID4gdWludDgNCj4gPiANCj4gPiBPbiAzLzI2
LzI2IDE3OjExLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4gPiANCj4gPiA+ICd4LXBhc2lkLW1v
ZGUnIGlzIGEgYm9vbCBwcm9wZXJ0eSwgd2UgbmVlZCBhbiBleHRyYSAncHNzJyBwcm9wZXJ0eSB0
bw0KPiA+ID4gcmVwcmVzZW50IFBBU0lEIHNpemUgc3VwcG9ydGVkLiBCZWNhdXNlIHRoZXJlIGlz
IG5vIGFueSBkZXZpY2UgaW4gUUVNVQ0KPiA+ID4gc3VwcG9ydGluZyBwYXNpZCBjYXBhYmlsaXR5
IHlldCwgbm8gZ3Vlc3QgY291bGQgdXNlIHRoZSBwYXNpZCBmZWF0dXJlDQo+ID4gPiB1bnRpbCBu
b3csICd4LXBhc2lkLW1vZGUnIHRha2VzIG5vIGVmZmVjdC4NCj4gPiA+IA0KPiA+ID4gU28gaW5z
dGVhZCBvZiBhbiBleHRyYSAncHNzJyBwcm9wZXJ0eSB3ZSBjYW4gdXNlIGEgc2luZ2xlICdwYXNp
ZCcNCj4gPiA+IHByb3BlcnR5IG9mIHVpbnQ4IHR5cGUgdG8gcmVwcmVzZW50IGlmIHBhc2lkIGlz
IHN1cHBvcnRlZCBhbmQgdGhlIFBBU0lEDQo+ID4gPiBiaXRzIHNpemUuIEEgdmFsdWUgb2YgTiA+
IDAgbWVhbnMgcGFzaWQgaXMgc3VwcG9ydGVkIGFuZCBOIC0gMSBpcyB0aGUNCj4gPiA+IHZhbHVl
IGluIFBTUyBmaWVsZCBpbiBFQ0FQIHJlZ2lzdGVyLg0KPiA+ID4gDQo+ID4gPiBQQVNJRCBiaXRz
IHNpemUgc2hvdWxkIGFsc28gYmUgbm8gbW9yZSB0aGFuIDIwIGJpdHMgYWNjb3JkaW5nIHRvIFBD
SSBzcGVjLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8W3po
ZW56aG9uZy5kdWFuQGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSk+
DQo+ID4gPiAtLS0NCj4gPiA+IMKgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8wqAg
MiArLQ0KPiA+ID4gwqAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmjCoCB8wqAgMiArLQ0K
PiA+ID4gwqAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTEgKysr
KysrKysrLS0NCj4gPiA+IMKgIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiA+ID4gaW5k
ZXggMTFhNTNhYTM2OS4uZGI0ZjE4NmEzZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiA+ID4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQo+ID4gPiBAQCAtMTk1LDcgKzE5NSw3IEBADQo+ID4gPiDCoCAjZGVmaW5lIFZURF9F
Q0FQX01ITVbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxNVVMTCA8PCAyMCkNCj4gPiA+
IMKgICNkZWZpbmUgVlREX0VDQVBfU1JTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgx
VUxMIDw8IDMxKQ0KPiA+ID4gwqAgI2RlZmluZSBWVERfRUNBUF9OV0ZTwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAoMVVMTCA8PCAzMykNCj4gPiA+IC0jZGVmaW5lIFZURF9FQ0FQX1BTU8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoN1VMTCA8PCAzNSkgLyogbGltaXQ6IE1lbVR4
QXR0cnM6OnBpZCAqLw0KPiA+ID4gKyNkZWZpbmUgVlREX0VDQVBfU0VUX1BTUyh4LCB2KcKgwqDC
oMKgwqAgKCh4KS0+ZWNhcCA9IGRlcG9zaXQ2NCgoeCktPmVjYXAsIDM1LCA1LCB2KSkNCj4gPiAN
Cj4gPiANCj4gPiBkb2VzIHRoaXMgY2hhbmdlIHN0aWxsIG1lZXQgdGhlIGxpbWl0IGNvbW1lbnRl
ZCBieSAiKiBsaW1pdDoNCj4gPiBNZW1UeEF0dHJzOjpwaWQgKi8iPw0KPiANCj4gDQo+IFZURCBk
b2Vzbid0IHVzZSBNZW1UeEF0dHJzOjpwaWQuIENsZW1lbnQgYXNrZWQgc2FtZSBxdWVzdGlvbiwg
c2VlIG15IHJlcGx5IGF0ICANCj4gW2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwv
SUEzUFIxMU1COTEzNkI4MTA2QjAwNzBGMDNDRjlDMzJCOTI2MUFASUEzUFIxMU1COTEzNi5uYW1w
cmQxMS5wcm9kLm91dGxvb2suY29tL10oaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC9JQTNQUjExTUI5MTM2QjgxMDZCMDA3MEYwM0NGOUMzMkI5MjYxQUBJQTNQUjExTUI5MTM2Lm5h
bXByZDExLnByb2Qub3V0bG9vay5jb20vKQ0KPiANCj4gDQo+IA0KPiA+IA0KPiA+ID4gwqAgI2Rl
ZmluZSBWVERfRUNBUF9QQVNJRMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IDQw
KQ0KPiA+ID4gwqAgI2RlZmluZSBWVERfRUNBUF9QRFPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKDFVTEwgPDwgNDIpDQo+ID4gPiDCoCAjZGVmaW5lIFZURF9FQ0FQX1NNVFPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IDQzKQ0KPiA+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11
LmgNCj4gPiA+IGluZGV4IGU0NGNlMzE4NDEuLjk1Yzc2MDE1ZTQgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiA+ID4gKysrIGIvaW5jbHVkZS9ody9p
Mzg2L2ludGVsX2lvbW11LmgNCj4gPiA+IEBAIC0zMTQsNyArMzE0LDcgQEAgc3RydWN0IEludGVs
SU9NTVVTdGF0ZSB7DQo+ID4gPiDCoMKgwqDCoMKgIGJvb2wgaW50cl9laW1lO8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEV4dGVuZGVkIGludGVycnVwdCBtb2RlIGVuYWJsZWQg
Ki8NCj4gPiA+IMKgwqDCoMKgwqAgT25PZmZBdXRvIGludHJfZWltO8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAvKiBUb2dnbGUgZm9yIEVJTSBjYWJhYmlsaXR5ICovDQo+ID4gPiDCoMKgwqDCoMKg
IHVpbnQ4X3QgYXdfYml0czvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogSG9zdC9J
T1ZBIGFkZHJlc3Mgd2lkdGggKGluIGJpdHMpICovDQo+ID4gPiAtwqDCoMKgIGJvb2wgcGFzaWQ7
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBXaGV0aGVyIHRvIHN1
cHBvcnQgUEFTSUQgKi8NCj4gPiA+ICvCoMKgwqAgdWludDhfdCBwYXNpZDvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFBBU0lEIHN1cHBvcnRlZCBpbiBiaXRzLCAwIGlmIG5v
dCAqLw0KPiA+ID4gwqDCoMKgwqDCoCBib29sIGZzMWdwO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLyogRmlyc3QgU3RhZ2UgMS1HQnl0ZSBQYWdlIFN1cHBvcnQgKi8N
Cj4gPiA+IA0KPiA+ID4gwqDCoMKgwqDCoCAvKiBUcmFuc2llbnQgTWFwcGluZywgUmVzZXJ2ZWQo
MCkgc2luY2UgVlREIHNwZWMgcmV2aXNpb24gMy4yICovDQo+ID4gPiBkaWZmIC0tZ2l0IGEvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gPiBpbmRleCBm
Mzk1ZmEyNDhjLi5hN2I2NzZjZDEzIDEwMDY0NA0KPiA+ID4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+ID4gPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gPiA+IEBAIC00MjAz
LDcgKzQyMDMsNyBAQCBzdGF0aWMgY29uc3QgUHJvcGVydHkgdnRkX3Byb3BlcnRpZXNbXSA9IHsN
Cj4gPiA+IMKgwqDCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgieC1zY2FsYWJsZS1tb2RlIiwgSW50
ZWxJT01NVVN0YXRlLCBzY2FsYWJsZV9tb2RlLA0KPiA+IA0KPiA+IEZBTFNFKSwNCj4gPiANCj4g
PiA+IMKgwqDCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgieC1mbHRzIiwgSW50ZWxJT01NVVN0YXRl
LCBmc3RzLCBGQUxTRSksDQo+ID4gPiDCoMKgwqDCoMKgIERFRklORV9QUk9QX0JPT0woInNub29w
LWNvbnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsIHNub29wX2NvbnRyb2wsDQo+ID4gDQo+ID4gZmFs
c2UpLA0KPiA+IA0KPiA+ID4gLcKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJ4LXBhc2lkLW1vZGUi
LCBJbnRlbElPTU1VU3RhdGUsIHBhc2lkLCBmYWxzZSksDQo+ID4gPiArwqDCoMKgIERFRklORV9Q
Uk9QX1VJTlQ4KCJwYXNpZCIsIEludGVsSU9NTVVTdGF0ZSwgcGFzaWQsIDApLA0KPiA+ID4gwqDC
oMKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJzdm0iLCBJbnRlbElPTU1VU3RhdGUsIHN2bSwgZmFs
c2UpLA0KPiA+ID4gwqDCoMKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJzdGFsZS10bSIsIEludGVs
SU9NTVVTdGF0ZSwgc3RhbGVfdG0sIGZhbHNlKSwNCj4gPiA+IMKgwqDCoMKgwqAgREVGSU5FX1BS
T1BfQk9PTCgiZnMxZ3AiLCBJbnRlbElPTU1VU3RhdGUsIGZzMWdwLCB0cnVlKSwNCj4gPiA+IEBA
IC01MDQyLDcgKzUwNDIsOCBAQCBzdGF0aWMgdm9pZCB2dGRfY2FwX2luaXQoSW50ZWxJT01NVVN0
YXRlICpzKQ0KPiA+ID4gwqDCoMKgwqDCoCB9DQo+ID4gPiANCj4gPiA+IMKgwqDCoMKgwqAgaWYg
KHMtPnBhc2lkKSB7DQo+ID4gPiAtwqDCoMKgwqDCoMKgwqAgcy0+ZWNhcCB8PSBWVERfRUNBUF9Q
QVNJRCB8IFZURF9FQ0FQX1BTUzsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCBWVERfRUNBUF9TRVRf
UFNTKHMsIHMtPnBhc2lkIC0gMSk7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgcy0+ZWNhcCB8PSBW
VERfRUNBUF9QQVNJRDsNCj4gPiA+IMKgwqDCoMKgwqAgfQ0KPiA+ID4gwqAgfQ0KPiA+ID4gDQo+
ID4gPiBAQCAtNTU4Myw2ICs1NTg0LDEyIEBAIHN0YXRpYyBib29sIHZ0ZF9kZWNpZGVfY29uZmln
KEludGVsSU9NTVVTdGF0ZSAqcywNCj4gPiANCj4gPiBFcnJvciAqKmVycnApDQo+ID4gDQo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gwqDCoMKgwqDCoCB9DQo+
ID4gPiANCj4gPiA+ICvCoMKgwqAgaWYgKHMtPnBhc2lkID4gUENJX0VYVF9DQVBfUEFTSURfTUFY
X1dJRFRIKSB7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAiUEFTSUQg
d2lkdGggJWQsIGV4Y2VlZCBNYXggUEFTSUQgV2lkdGggJWQgYWxsb3dlZCAiDQo+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJpbiBQQ0kgc3BlYyIsIHMtPnBhc2lk
LCBQQ0lfRVhUX0NBUF9QQVNJRF9NQVhfV0lEVEgpOw0KPiA+IA0KPiA+IA0KPiA+IHMvZXhjZWVk
L2V4Y2VlZHMvDQo+IA0KPiANCj4gV2lsbCBkby4NCj4gDQo+IFRoYW5rcyAgDQo+IFpoZW56aG9u
Zw0KPiA=

