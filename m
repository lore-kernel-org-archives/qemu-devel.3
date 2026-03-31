Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDF0FF60D2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Sug-0006rA-Do; Tue, 31 Mar 2026 02:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w7Suf-0006r0-9Q
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:49:21 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w7Sud-0008LH-8D
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1774939759; x=1806475759;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SSUy75K2+20MKyWr87ldmwS+a39/x68L1D3k/UgfDWM=;
 b=aJ/rQKJGLavf3fYetYis8O5Vpw8Oa/PVo5TiohSitGtpJcy5ib43+EXa
 VkCxPSdttPj+uljUWxGRpUnIyIXV5qXw15NOGOMLJ99aEN0/E+7Of5N3Z
 lMV/ClkuSwRbDmss+fR2nC9nRB/J3ltPF6S/cJXFwtVQ4c+PKzZiVbjeW
 zyjAjfgPIYGFeUYjJyDk4ljbU58VjWVgRa3AhHMD3nl7saImyRKIAa/Oz
 9dHekYLWM2FNMFuM3fFvWvzApzem2mXbAohUJ787x5DSIWzKOzVDUX9o8
 KeXucKQEfWfbftEN1eIq+fVVO6OcJppmUs0pvxtpYifdEXwWWpauirOUu Q==;
X-CSE-ConnectionGUID: +Wi0LVRkSPGkAq8dCvs1jA==
X-CSE-MsgGUID: Q+tPSxifT/CubAR6PiynNw==
IronPort-SDR: 69cb6e6d_X68viXqxFW25P9c4cZLYIe94hPsAKRTqgl+Vv8oKLDZ5n2q
 uiBEYNtSpXWRICqXFkLFx7VuNq7v6Zs1GyFFuYQ==
X-IronPort-AV: E=Sophos;i="6.23,151,1770591600"; d="scan'208";a="49394527"
X-MGA-submission: =?us-ascii?q?MDHz3cBF4PuVNAH/YQqC4JX04NaLmxj55BUEOV?=
 =?us-ascii?q?FGviUTF2ZpTwDI5MHwbEY+mz98IHsE6kaAjlWCj4XaN+w4J4pcuei33b?=
 =?us-ascii?q?1BWo0e26OGsa6obG7Cu99x5YZfvjAakJyBwcgMsUl6U5nHOhgkZPYr99?=
 =?us-ascii?q?jjYcyWnALmRE6lWwT5b15WpQ=3D=3D?=
Received: from mail-westeuropeazon11010020.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([52.101.69.20])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 31 Mar 2026 08:49:17 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVa3imdCVMkPNIi33/h3pzgrZ0U/TMs5wRegouLDeQpyuuV1gNtMoBpWSzcxq5cpHUZ80D49TPc6qnBC7S+8Za4K9CFT2AqvBIGYn01FaTaDe0z7HYzbmumBYU7r4QVuZu5LrlLoseCtR/cbCmoLX1MziZce/6UDmcd+/H01mw6pVZh2tQZGgIpS+yuPD6TZeyXfEjWSvrR3WDIYLENJsT2tCbYKW5HwFhZHc0lX+IVoatAw7MQiZgrlaa4ikaCRYLpDc+fcOGpfXa+JEJLTCRS8fKR9emAOXyoUWlJNTCqYrMuic43X/3OvpLFWyObQGMnxbQWV9C0C0WEO5qRl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSUy75K2+20MKyWr87ldmwS+a39/x68L1D3k/UgfDWM=;
 b=imso6djpIC/Mhowl4rrr5m8nXlHVHqYe7BsRqIuA1bKMcElEe0fy+twqKpPMaS0v480ETAp19A0MfUtE7EcQLy3aF8UKnJseGaQoN3j8++fyw6GGxv1nmKwkC2TjU1Qt5UnfC7U+tA9i7day9uJqw5gmOYslf1z1YcPNDaFub9TKKHaGoO9nrBi1xMa0YdlQfh90dog2ryg7Mn6cbjPaq8CTu89gdjmCvzVMUNlwwlFrIQXkK9oYKjlEHiF4DgobHuSrFHuARriPy7kn9miey+mNGIm93s2b+XHfb/1HxN4kDsTbt0zTZpuPFVSZN3KiILlI74GlQmFbtmsCAAYFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8557.eurprd07.prod.outlook.com (2603:10a6:20b:4f8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 06:49:14 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 06:49:13 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: Re: [PATCH 4/5] intel_iommu_accel: Accept PRQ response for
 passthrough device
Thread-Topic: [PATCH 4/5] intel_iommu_accel: Accept PRQ response for
 passthrough device
Thread-Index: AQHcvZTPe7Euk9sXuEilsesIeHYDebXGrIWAgAFu6wCAAB43AA==
Date: Tue, 31 Mar 2026 06:49:13 +0000
Message-ID: <dbc748961eb3776f212c706063b666b4cd7b8dbd.camel@eviden.com>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
 <20260327025228.474257-5-zhenzhong.duan@intel.com>
 <a874598ba13c8e47751f01dca4649342365bd983.camel@eviden.com>
 <IA3PR11MB9136BD47ABDB98735C9BD0DF9253A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136BD47ABDB98735C9BD0DF9253A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8557:EE_
x-ms-office365-filtering-correlation-id: afcf741a-c23b-4def-a68c-08de8ef19f09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: wtRRZ7kHIxH1m/ESLk+VgBXB0ufIjXcwY2tTJzZCHP3izfr7Qb86UUHKSQ03jiq3iw7JmOT5xtk/OM4IvugmBOpqGhwgua/rLCSDtyFIv8mYsZk9AYhbD1ZbiWjdkEz4JrlWGvw6mSqjewFn3pVTZC2f6eKcY8b5flgHYOoEs6FSmrRRczH4kS16Ky74t3foJjHfsvd+6Ch7uN0Fm6c4V+WNCRFVyU/uHzj2SvI1vFCLcxzYm+rS2JUc92MW5wxW5P6Barxk+UDD9U0M9C4xIqB847ROT/U/HA+sJKIJaFEVSBB6k6OLE+gdJSmS3/889P62DESla/mZL6NndFi3h1F53Dh0txuBiOWoWeIyj6gMg2A9xd7kVjyEIkiosdgJouDbPqiz1ocKniBF50N1u1evYT7MlmmU8HkJRvZvfdEh4F8KX10+CVM+m48vs3EFfoG5usV2JU0KZh0JJ0Jl9vUC/p1nYARQKaHfgWMXB0jIKIVuohRHNKNmtxPTgl0v2RU5IrUPCdTboo7uUmT2B/9dAmwpOJvcHpJN8pUbbJv0Es2vfzZrnleqYgGdGC9x9+jmJYgG1Rj80lycnaDNRXnYAJNDIOwF2rNH67H4Uvsi9XR6RhTkyGI9MY+utopfXeUA+WTZ52fYOHIW0KM5DHEmd1A7kclKsPUizPzLzQ9XwugQBHhDDBOiacfJmqpakr/fF35a1yh+7Eef+U6dDdl1PMc48J90OJ54H9nCyPpvIx0H8wclRgDnAZDn24RJ98t1XdBafvTso9t+KAi8T91pGT+ysdkPN0PV73ufWHk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWtxYk80YWlOTWFyRjhETFBQeTdqN0JLVjhXOVVVZWQxSTJVdVBaUjdUc3Zi?=
 =?utf-8?B?dzVlS0hraGtTZHVvNzg1ejBUOUxzazU2RE0yaUF2cUNTR1ZWMnJsdzJuSEFQ?=
 =?utf-8?B?TEN3RUNkWXJsbk92d3JSVTlDN1JRbUtidmRwK1lUbkFWRnc5d2ZDK2pUU0ls?=
 =?utf-8?B?YXhLekd5YWY4Wnh2NnZhd2kxS09DVTFvUllkemc1SWIrU0pZR3MzU1p4dVBT?=
 =?utf-8?B?UFh2RnBxZGV3bXU4azAzRHZUd05mNmE1SkN0cUs0VDA4S2VxeEJySUxNYTNZ?=
 =?utf-8?B?YnM0bmtwM2x5ZVJ2K2IxZ0pxTEV1NXR6ZkxrLzZabGtkL1Nwc1VXU3NteUNl?=
 =?utf-8?B?bjUzVURFUDBGK1JmaDlmdHFFYWV2OE5iNGcwMGRmT3NwVFZMVTh3WENTL1Rt?=
 =?utf-8?B?dlJqTGhuZzFCWVEvWG9mU0hoQkptK01wZWZCWXVYOVd0VVhhYTJpRUVVemRB?=
 =?utf-8?B?Tmt3bWVEaU5UcXlNNVBJMGt5NjRlL1RZbnNwR1VaOEo0aWdsTzBxMkE3TlZ0?=
 =?utf-8?B?N0d4NlFrS0thSWgwRThFak1kZlNVYWRiZDhSVXphdkMwWUo3cUtEbGxHZ2M5?=
 =?utf-8?B?YjZoUzR2QjJFeWVTdzgrNGdITXZDMXBmWks1cVpVNGxnblVyWTczSlJ2OEc3?=
 =?utf-8?B?MUt2QUxwUWwzTVJBYUwrOG9JSjlpRThUa0xnQXloTzVka0RubUNjUW1FNWZR?=
 =?utf-8?B?YTlmUVk3ZEhKZlMwQlY1cmRjUThCdlpxZ3BFcXFONEV5NEt4RncrWENLeUVK?=
 =?utf-8?B?RVNkc3dRdDlyeGt3bFhqT0tRbTlIZ1Y4T3IwQ0tNam5EazhEdUcwREhQTmJk?=
 =?utf-8?B?R1haNE14UWs1WlZWcE9LUUtTZkgycXlvTzViL2EzQUUrc3JEejVzeHgvY1hp?=
 =?utf-8?B?NXNEQUlKNXNlM0VEWDN6NFY4UVN1WEpBS2xWU2FmSUZjNW8yWkFQSFA4dzJx?=
 =?utf-8?B?UnNHUzIweGlSSGNRNnhnK3NLMU1QUTVqaTRxNFIrUHB6SGZ4bGF2N0lha0k3?=
 =?utf-8?B?U040ay9UVkRTVkpwTW1MU25pdW5TcDZtcFRPc1VZbEtFemtjTzZ4YTZkVG8w?=
 =?utf-8?B?eUgyM3MzQUNOc0xVK1JyWUlvM0tRa0syVGxjeFl3cWloV0diaXBLZ3RNcUVi?=
 =?utf-8?B?a0JQNWprQmtYZGkzU1dNY0NVYjZXOUZQd0tJcElPbjVHM3N5d2Y1SVIxRjM2?=
 =?utf-8?B?aHhLTzFXLzd5aERrOFZFTkxEUVUveDdVelZoOGZONitMVVE3a3NrZm5DeWNt?=
 =?utf-8?B?aEo5UVovK0YyT3lxYU5VRVRlemRJcGkwZ09mUWdXbUIyWHpKaE1pZURydUxn?=
 =?utf-8?B?RTFZSVpHd2ZBMU45REFnamptTEp0TEpIcGc3ZUFpQ2N0dXFmOXdKLzJ4dExl?=
 =?utf-8?B?WEp6SkxYOHNqeVdKTy9VaTlWdVdyZXdtRW1saERQNlFaaGZ3c1dIN0xIUFk2?=
 =?utf-8?B?QnhtWWtKYXpCa1ZIOHhaOGxMcElRVHIveEJhZG5tSDRYT29ITDdLYjgrOVZR?=
 =?utf-8?B?RTdjSzNZcksyVXFtR0plTGF6ekJpU1pSeTlyRE4vOVc1MzFZd01RQmErQXdq?=
 =?utf-8?B?MFpkaTRSS2JORXV2TXhtbWlxSDkrSStzcVVwOFJJSm1KYVEyN3g4clJnYjVy?=
 =?utf-8?B?RGlSeWtlenRGSWdFaE9PQVgxN0pIaEFCbU9BN0M2YXltWXEyRWs0ajFocXFC?=
 =?utf-8?B?T2lnWnlPcGdpR0g2MkhMdVExVS9LYjZFTmpUZS9GN2N5bGZaQlZHN3ZTKzJV?=
 =?utf-8?B?aXUrQ3NVVk9USUdpSFdOY09KNUp6NDdvUkFEZUJLQ2R3OVpKVTJtTGFsdzFW?=
 =?utf-8?B?ZjZ6dzR6dE4ybUN1VWZJWWdwMkdtb2hoaUhFSFRkQmJDOEF6OTRjd05lUVlH?=
 =?utf-8?B?NXFuOWlxL21LUTBBOHlTQytReTJXdS9RR25CamJ5U1hZNmcyYU13TXE1emI0?=
 =?utf-8?B?YkZpVnNxVjNQOEJWZWFYQ0ROQmJPSnBPNkxiOWV4Zmt0Z1YwMjcxWXh6dkJQ?=
 =?utf-8?B?bXV1UkV6NEhMa0Q0UXRTWnd1SFh1RFdrU01DT3dmc1ljNGhPZWo0dFYyUzR6?=
 =?utf-8?B?UDFuNyt1QVpZeFdrODFHSjNYZERBZmM2UlFDMHVCcTFLWHRPc0d3aTQxOGNC?=
 =?utf-8?B?ZHY3VGd1TGdjNFBJR3ozdWVhLzh0OVRJWTJTYkpVa3ZxNmdDZkk4RWN1OHdn?=
 =?utf-8?B?dVBUZWtlNEpqSDlpeTF6S0xGWHg4UGFrZW5zSDJrN1hmWmJXZi9XbFErMk1x?=
 =?utf-8?B?NVNwbm42elpwdHlSdk9EUnNwVTUwUnNwUk0rTC9DVWtpek1nSlBZK3R6ODA3?=
 =?utf-8?B?RjRHdUs5QkJmWnFDa2xhZ0NwYVRNZjMzWU5jcE5hNE8wdys1MDkrRUxvNUFV?=
 =?utf-8?Q?uKXOi4MrmHd0Bb6ig/XWsdP4WZxwSsJhykTEI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D477B49FDBA6D4089B0B57627FF5446@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PUvcIINXwkNbi1xPgJtPxL52kK9lLx5sloBRU5DvFs1mdO6p+wHr06fwDy8HJvutNTuUnkkbe9O+XCoTgEiQH9wb+AwZtvtFAUJdRD9Fz4r6UDTnonnhJ1iHLMCxPu20wilgfTNs6TAIxDLA7UxWGzZa7OPs/ROijfcDa2CONrCdbAIKT0gdqZbPIlsWzQGTx0Ytw54wKIqTkOOVJ1XVw0jm81SZrK1j90VeO/qpkKlA4jZD4dGE/X3bkXN+uExM8aHiFZB20h11nHC38EdrOuMcd/4Ut7DYfO/YzhCse0/fp54CAvInM5AzkRt/YHwkbnczhBZjEu0C/xvbcv6YAw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcf741a-c23b-4def-a68c-08de8ef19f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 06:49:13.9648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3qvuLp0dMu56JT3pTbCPc28yQ2mJ1L0q+XDDiFqSWPGcCiETYikkfDQb0fmhR/JmZrptDWQVu/gqhc0Zawsum75biiLAaoV/TASCQibt0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8557
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost4.eviden.com
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

T2sgdGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbg0KDQpSZXZpZXdlZC1ieTogQ2xlbWVudCBN
YXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20+DQoNCk9uIFR1ZSwg
MjAyNi0wMy0zMSBhdCAwNTowMCArMDAwMCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPiBIaSBD
bGVtZW50LA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9t
OiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPFtjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb21d
KG1haWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pPg0KPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggNC81XSBpbnRlbF9pb21tdV9hY2NlbDogQWNjZXB0IFBSUSByZXNwb25zZSBmb3IN
Cj4gPiBwYXNzdGhyb3VnaCBkZXZpY2UNCj4gPiANCj4gPiANCj4gPiANCj4gPiBPbiBUaHUsIDIw
MjYtMDMtMjYgYXQgMjI6NTIgLTA0MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiA+IA0KPiA+
ID4gUHJvcGFnYXRlIGd1ZXN0J3MgUFJRIHJlc3BvbnNlIHRvIGhvc3QgYnkgd3JpdGluZyB0byBm
YXVsdF9mZC4NCj4gPiA+IENyZWF0ZSBhIG5ldyBWVERQUlFFbnRyeSB0byBjYWNoZSBjb29raWUg
Zm9yIGVhY2ggZmF1bHQgZ3JvdXAsDQo+ID4gPiB0aGlzIGNvb2tpZSBpcyB1c2VkIHRvIG1hcmsg
dGhlIGZhdWx0IGdyb3VwIG9uIGhvc3Qgc2lkZS4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogWmhlbnpob25nIER1YW4NCj4gPiANCj4gPiA8W1t6aGVuemhvbmcuZHVhbkBpbnRlbC5jb21d
KG1haWx0bzp6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20pXShtYWlsdG86W3poZW56aG9uZy5kdWFu
QGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSkpPg0KPiA+IA0KPiA+
ID4gLS0tDQo+ID4gPiDCoGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaMKgwqAgfCAxNCArKysr
KysrKw0KPiA+ID4gwqBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCB8wqAgNiArKysrDQo+
ID4gPiDCoGh3L2kzODYvaW50ZWxfaW9tbXUuY8KgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKysrDQo+
ID4gPiDCoGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuY8KgwqAgfCA2NSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gwqBody9pMzg2L3RyYWNlLWV2ZW50c8KgwqDC
oMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+ID4gPiDCoDUgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0
aW9ucygrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9h
Y2NlbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5oDQo+ID4gPiBpbmRleCAxMGU2ZWU1
NzIyLi5iNDZjNzEyNmY3IDEwMDY0NA0KPiA+ID4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9h
Y2NlbC5oDQo+ID4gPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4gPiA+IEBA
IC0xOSw2ICsxOSw5IEBAIHR5cGVkZWYgc3RydWN0IFZUREFjY2VsUEFTSURDYWNoZUVudHJ5IHsN
Cj4gPiA+IMKgwqDCoMKgIHVpbnQzMl90IGZzX2h3cHRfaWQ7DQo+ID4gPiDCoMKgwqDCoCB1aW50
MzJfdCBmYXVsdF9pZDsNCj4gPiA+IMKgwqDCoMKgIGludCBmYXVsdF9mZDsNCj4gPiA+ICvCoMKg
wqAgUUxJU1RfSEVBRCgsIFZURFBSUUVudHJ5KSB2dGRfcHJxX2xpc3Q7DQo+ID4gPiArwqDCoMKg
IElPTU1VUFJJTm90aWZpZXIgcHJpX25vdGlmaWVyX2VudHJ5Ow0KPiA+ID4gK8KgwqDCoCBJT01N
VVBSSU5vdGlmaWVyICpwcmlfbm90aWZpZXI7DQo+ID4gPiDCoMKgwqDCoCBRTElTVF9FTlRSWShW
VERBY2NlbFBBU0lEQ2FjaGVFbnRyeSkgbmV4dDsNCj4gPiA+IMKgfSBWVERBY2NlbFBBU0lEQ2Fj
aGVFbnRyeTsNCj4gPiA+IA0KPiA+ID4gQEAgLTMxLDYgKzM0LDkgQEAgdm9pZCB2dGRfZmx1c2hf
aG9zdF9waW90bGJfYWxsX2FjY2VsKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gPiANCj4gPiB1aW50
MTZfdCBkb21haW5faWQsDQo+ID4gDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCBu
cGFnZXMsIGJvb2wgaWgpOw0KPiA+ID4gwqB2b2lkIHZ0ZF9wYXNpZF9jYWNoZV9zeW5jX2FjY2Vs
KEludGVsSU9NTVVTdGF0ZSAqcywgVlREUEFTSURDYWNoZUluZm8NCj4gPiANCj4gPiAqcGNfaW5m
byk7DQo+ID4gDQo+ID4gPiDCoHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3Jlc2V0X2FjY2VsKEludGVs
SU9NTVVTdGF0ZSAqcyk7DQo+ID4gPiArYm9vbCB2dGRfcHJvcGFnYXRlX3BhZ2VfZ3JvdXBfcmVz
cG9uc2VfYWNjZWwoSW50ZWxJT01NVVN0YXRlICpzLA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdWludDE2X3QgcmlkLCB1aW50MzJfdCBwYXNpZCwNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElPTU1VUFJJUmVzcG9uc2UgKnJlc3BvbnNlKTsN
Cj4gPiA+IMKgdm9pZCB2dGRfaW9tbXVfb3BzX3VwZGF0ZV9hY2NlbChQQ0lJT01NVU9wcyAqb3Bz
KTsNCj4gPiA+IMKgI2Vsc2UNCj4gPiA+IMKgc3RhdGljIGlubGluZSBib29sIHZ0ZF9jaGVja19o
aW9kX2FjY2VsKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gPiA+IEBAIC02OSw2ICs3NSwxNCBAQCBz
dGF0aWMgaW5saW5lIHZvaWQNCj4gPiANCj4gPiB2dGRfcGFzaWRfY2FjaGVfcmVzZXRfYWNjZWwo
SW50ZWxJT01NVVN0YXRlICpzKQ0KPiA+IA0KPiA+ID4gwqB7DQo+ID4gPiDCoH0NCj4gPiA+IA0K
PiA+ID4gK3N0YXRpYyBpbmxpbmUNCj4gPiA+ICtib29sIHZ0ZF9wcm9wYWdhdGVfcGFnZV9ncm91
cF9yZXNwb25zZV9hY2NlbChJbnRlbElPTU1VU3RhdGUgKnMsDQo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MTZfdCByaWQsIHVpbnQzMl90IHBhc2lkLA0KPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSU9NTVVQUklSZXNwb25zZSAqcmVzcG9u
c2UpDQo+ID4gPiArew0KPiA+ID4gK8KgwqDCoCByZXR1cm4gZmFsc2U7DQo+ID4gPiArfQ0KPiA+
ID4gKw0KPiA+ID4gwqBzdGF0aWMgaW5saW5lIHZvaWQgdnRkX2lvbW11X29wc191cGRhdGVfYWNj
ZWwoUENJSU9NTVVPcHMgKm9wcykNCj4gPiA+IMKgew0KPiA+ID4gwqB9DQo+ID4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggYi9pbmNsdWRlL2h3L2kzODYvaW50
ZWxfaW9tbXUuaA0KPiA+ID4gaW5kZXggMTg0MmJhNTg0MC4uNWQ0NGVhYzBlZCAxMDA2NDQNCj4g
PiA+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+ID4gPiArKysgYi9pbmNs
dWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiA+ID4gQEAgLTEwMCw2ICsxMDAsMTIgQEAgdHlw
ZWRlZiBzdHJ1Y3QgVlREUEFTSURDYWNoZUVudHJ5IHsNCj4gPiA+IMKgwqDCoMKgIGJvb2wgdmFs
aWQ7DQo+ID4gPiDCoH0gVlREUEFTSURDYWNoZUVudHJ5Ow0KPiA+ID4gDQo+ID4gPiArdHlwZWRl
ZiBzdHJ1Y3QgVlREUFJRRW50cnkgew0KPiA+ID4gK8KgwqDCoCB1aW50MzJfdCBncnBpZDsNCj4g
PiANCj4gPiANCj4gPiBIaSBaaGVuemhvbiwNCj4gPiANCj4gPiBNYXliZSBzaWxseSBxdWVzdGlv
biwgYnV0IHdoeSBkb24ndCB3ZSBrZWVwIG5hbWluZyBpdCBwcmdpPw0KPiANCj4gDQo+IEdvb2Qg
cXVlc3Rpb24sIHRoZSBuYW1pbmcgaXMgcGlja2VkIGZyb20gdUFQSSwgc2VlIGJlbG93Og0KPiAN
Cj4gc3RydWN0IGlvbW11X2h3cHRfcGdmYXVsdCB7ICANCj4gwqDCoMKgwqDCoMKgwqAgX191MzIg
ZmxhZ3M7ICANCj4gwqDCoMKgwqDCoMKgwqAgX191MzIgZGV2X2lkOyAgDQo+IMKgwqDCoMKgwqDC
oMKgIF9fdTMyIHBhc2lkOyAgDQo+IMKgwqDCoMKgwqDCoMKgIF9fdTMyIGdycGlkOyAgDQo+IMKg
wqDCoMKgwqDCoMKgIF9fdTMyIHBlcm07ICANCj4gwqDCoMKgwqDCoMKgwqAgX191MzIgX19yZXNl
cnZlZDsgIA0KPiDCoMKgwqDCoMKgwqDCoCBfX2FsaWduZWRfdTY0IGFkZHI7ICANCj4gwqDCoMKg
wqDCoMKgwqAgX191MzIgbGVuZ3RoOyAgDQo+IMKgwqDCoMKgwqDCoMKgIF9fdTMyIGNvb2tpZTsg
IA0KPiB9Ow0KPiANCj4gQmVjYXVzZSBWVERQUlFFbnRyeSBjYWNoZXMgcGFnZSBncm91cCBpZCBh
bmQgY29va2llIGZyb20ga2VybmVsIHVBUEksICANCj4gc28gYWxpZ24gdGhlIG5hbWUgd2l0aCBr
ZXJuZWwuDQo+IA0KPiBUaGFua3MgIA0KPiBaaGVuemhvbmc=

