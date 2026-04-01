Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFD6D35157
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7qmy-0006Mj-Qe; Wed, 01 Apr 2026 04:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w7qmw-0006Mb-LQ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 04:18:59 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w7qmu-0005o4-7p
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 04:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1775031536; x=1806567536;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RpvXB/t2qQwYbdmtSn0qzZdqflepPUJ4s1klKdGCV8U=;
 b=kW1sT3+2yHotr52HFUuR7QlcW3Kcb65Br0xY7QtLmc6JqmCkKrmS4KnO
 ER5w68ZOCSEJ+jm/A7/FM7zK7KNiUqTQvF3ZPliUSDbRxdX6jBrCiQMc5
 rj2xGSuuTooltdmLmB/m+a1iWKDG3I/svQrbs26AaGjHAXdjh/8bUGzCR
 r0hToZp7vR3vxX6T/c7zGAElduRl8zQLM/VQMGCOnj3wjsZEcFg1ELl0y
 KFnD+2J1DQzefv3jfYEsU7DKJotNxaLd6kHqIZdFb1IukDLUteEeptM5A
 Tw9gm7CkSvsSEsB7VDbrsN6HhSNjCkaFayfATU/xlHByu/1MdbX0O0A6u Q==;
X-CSE-ConnectionGUID: ElW76TKESmW7Try5yuAVxA==
X-CSE-MsgGUID: +7hM3OTBSoSgLoPwiHP/eA==
IronPort-SDR: 69ccd4e9_Vuc3Snj9RKz8LFjHOkKaT7Lnl+wzswy63uXnkQvJmEao4Dm
 pxJkvZAq04gFe/Mf4Du2fkng/HDYzQy0d+YBKOA==
X-IronPort-AV: E=Sophos;i="6.23,153,1770591600"; d="scan'208";a="47312915"
X-MGA-submission: =?us-ascii?q?MDE3kjUOrD2GgVmtZzXnPIEnL7RipVp0Vxt1wm?=
 =?us-ascii?q?0rKed1vIoQYSmO1GxeE6m9nFrAAEJUJQRyJXCQYycR9g/5CSHHyCb1HK?=
 =?us-ascii?q?bM5CDc6NsHGed+lF9zetU+UrDdViBPFeh7yG6v/qpDiPmlelQK7Va09z?=
 =?us-ascii?q?e5GFdavAXT0KfzDU049HR3fg=3D=3D?=
Received: from mail-swedencentralazon11013045.outbound.protection.outlook.com
 (HELO GVXPR05CU001.outbound.protection.outlook.com) ([52.101.83.45])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 01 Apr 2026 10:18:48 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7Js3RxKQ98HFBzt0ZdyGHTkySb+yKyotm4SULkvK8zbQ3BxPlo4/0+9cEXxeTEZqcHAs0wtPf6y3RZBom0ZkYc6l+XQHM/bvkGHgcQXxub6MNPPoj4rULvmtN3aa8wQS2p1yul+kD+TWVamy/93PH9ClElVrCzcBfP74UYcp4l124C8IODfN4OtExO7tEEOE4vZDGZGWAG6eddfUPc1RdF6h5x1bf4V7pGFnRaHVHATc05eveI2ZIVIBwV/V6PfkjdOdtaE9BhgPfR08ZbEEaxkwjZJWY5fdcShs0/z9MgRqj9jcI9chJBqZcEnKtuVJTOtqky8/DUBfk0Fl9cygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpvXB/t2qQwYbdmtSn0qzZdqflepPUJ4s1klKdGCV8U=;
 b=nSJ7RZqbKohUEqp+YZ7CAnqyOaw08lB63MmdcsZOCZzssvexoYrlP5AVyVHxne2R8YwjeJe+A33li29qihvfhifeALMfXgivQ87ZEQGuCLu4+ZrT/7VeGaAOlMDp3hfSsAjaQKCJoaf1ZoZuOv0lkav2zf99NtnmG/sBYegR3tFnokyLGYdEOr7oOF0DTqZSFlp1MWJJHfm2qycAZsrrPnUcdT3pqtRwbbQicXloPp8+fYlANnhftGvTFxkz+mopB8IrCPjmbLQvmpEcB1cHSfr29nQf/KpIUI2rbO39a5k6scmULa4i/r/2yfmmWfMQ6UzUObuEVkUb/9Op3tjx6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI0PR07MB11746.eurprd07.prod.outlook.com (2603:10a6:800:313::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 08:18:43 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 08:18:43 +0000
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
Subject: Re: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Topic: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Index: AQHcrRucl+8w3w8Tvkaf2W6HYfy4KrW1kwGAgAASeoCAAT2GgIARd4iAgAAIVoCAAaMPgA==
Date: Wed, 1 Apr 2026 08:18:43 +0000
Message-ID: <fb14a3f7f49e98683b666084aa3ae10b36ee4282.camel@eviden.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-12-zhenzhong.duan@intel.com>
 <1b2b191e2f9f1315c883ed2de4fb9644a01c8713.camel@eviden.com>
 <IA3PR11MB9136F0D294E9FBE576E0CF91924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136B3C106DDF70856F27FE6924CA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <bdc0f51e1496c841a4f3392ec3e775e6a69b57e1.camel@eviden.com>
 <IA3PR11MB913601196392D72E02E5AB579253A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB913601196392D72E02E5AB579253A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI0PR07MB11746:EE_
x-ms-office365-filtering-correlation-id: 39ebe2f3-9903-4ce0-0e69-08de8fc74a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: fdT7ZVmb5SV1lTD/MG8k0/hEiqPrTT0V6VwW+0EAorxY9TDNPSmR75ryEadcRZvpqhppMZl5kWVA8HtSPUS0fYDtBpIAozw5rUV53t2pofKg+YUf9s85Nz4AXwzcDEp+vU+xDmNUyRY/nKtbKc74tVYfmfXWpUnHanmZ1fwX9b4+szRD9uJnaMb3+nv3+w6legdoioA2RWU4A2hbu9+hegqzDwWIyCAZcAMyJ4DKX1n3juaywjhSyWlxY8OJI5oFknpNUwk9i2P95HlNV/xJfulpmfpYU+OlLRd/7xA7hxhMcG/YxPpuUmRdwbKeSe7IyoecQLNjqVOf1pcnFnZSc4j+9tNWKqk+K/nZeEIgIuhkuI9c+jYZVALJcrpZIKg+9DasGjLwfG4ucy5pD3kaG239VecljPPHbRfczq7hMgkguU2jd1suinYir32CsAkdaxVfTHOgezuCXMQA9Il74V90X/lIV7zNRlzphA+s5sCJKdbGS4fNnDIHl66Iv0n9M9k0IQTOXScyhqYTxVOPvJ8Spgovj9yvzmFzhRgmWjufE7irPmQQwd+5r3b0pXiyMoBfLUVfMOXqrMFfndFij+cIg0XwwwoCj1BcHdnN6q19IT0b2Dm3p4v1g6GcWffbW9oLLD4Rif9jP/n7rHSQEBCoLFlTqPe2KZRQiBfL2RL0aCFhkYIKlMBPT29imGejpcQ5ebY+4Y5sJRKAyG1Ntan6VbhNqxxxiiEpUmECZ0SFnXF8JSzNjgOFvT5q08ybFrg1U8+QwWYT4UppUHxInPZBdRvSSiSAQIDGrcYLO6E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aElTdEFzREJpU1ZNNVBWWTRza1lRZmE0Q0ZGc3Zwc2JzU2VCQnRXNytkTHhq?=
 =?utf-8?B?VGJKdUNxL05aNEprTXR0Y2dQQk90Z1Mzd3BReU4xQmc4Q3ZJQ2E1QnBOQklC?=
 =?utf-8?B?N2VhclRSSHc3NWQ2dis5cklVV0VCZFlWNjliQUQ0enFwem0yMGw2OFZVdHVO?=
 =?utf-8?B?aUFsUG1ySTJQb2pBenQ1Sko2RXIrMGRndDhDeE9PMVBUMGIzWnhrbk9Xd1Fi?=
 =?utf-8?B?TjVRa0QvOXAxT3d0b2tZQitMS0t4VUNJMVZZaXZDc296M2FGamFDK3BjYlBn?=
 =?utf-8?B?aVFOeE9icEFZM1c4WTJEWHlORHRIVS90d2JpbUE4V0xKNVBqU040TGxTeEtq?=
 =?utf-8?B?L2hYWm83YStuV0hsV0hMZ0tqRXlzS0lVTWhTcGpoYWZSaThMOWRucHo5clpK?=
 =?utf-8?B?bDNEUm9USDBHLytvVmx0bjJra0w5cWkrKzhXWjJlb0ZkcjJYV3JSTDF5Y1NU?=
 =?utf-8?B?Znh1d0pJKytlMzNQQ1FlNHpOVm4yd0pPSEsyUTJNdXNLUEtTQlEwS3NOWkVO?=
 =?utf-8?B?YTFnTEJzVmlLSytybkI5blNqeWQvWmMwTURDMDkrTFpudmpkclMzT0JleCth?=
 =?utf-8?B?ai91QXNwS0taNTJldlpVMU1oRVRQcjEvQld5TE1MckpqWUtZV2FpKzFQaUFn?=
 =?utf-8?B?dkg3dkowbTRaUXVkZ3puTHlZY1BGUEFoZHQ3VTAvUTM0aHJJeWlzandPaDRX?=
 =?utf-8?B?a0ZoY1Qxa0dIdC9BZ0dLdjB4RGd3NXROYnJ3b0NWeVFQcEdEY3NOTWZITEho?=
 =?utf-8?B?ci9heUhzcGVESHNDcjltWk5JYVpCK2FLSGFEcHUzaFpxVUp3Q3czbklad3lK?=
 =?utf-8?B?VW5ORTYrUHljQmhtZDYvS3FqVTNvZ2NFOGZWNnNmK2RMOUJwOEVBQ21FR0lF?=
 =?utf-8?B?dmxwamJ4QnJRUEN0N2NXV3o4TEhlYVZGVXRqUCsybEh4aEVBeCtTTGQ4aEtO?=
 =?utf-8?B?UnUwZ2R5OWlNanlEL1lFdzkybk1VZi9hblZlZWJ2VnJSNFR1YlFIYTNKUVpi?=
 =?utf-8?B?b1NVYjVLK05lYmFTNmtEQzBCcWhaM254N3duVHdSeG1PajFIeisvNDBYK0dz?=
 =?utf-8?B?emFERmVRbTRjL0pmU2ptQlB1aXNORS8zRDUrdkViWXlKYUNmUDVMWDZ5WHFL?=
 =?utf-8?B?SWlKWUtLL1FiUThBTDRPUkhURU9FN3oreVRxUXN5eWx4WDJFMkpYQ2x1NCsw?=
 =?utf-8?B?eThYNVYwemtQZEVXSko5Q1JDVmRQT3BySGxUNENneU05RnRHczdUdFRGdUQv?=
 =?utf-8?B?NlV1RmNuc0wvL1JJaWpabHMrM0VnQXBCNW1qdlZFaXVnOVFDalNIM3lZdm1n?=
 =?utf-8?B?bkRiMGxIajZoYXgrUmZUK1pZZzZ0YlYyMDhic082RmJ6c2NCb29xZGsxZzFi?=
 =?utf-8?B?SFNvNzlXeVd5WTVHTjM2bGdLVkNEL1FnTGttMmkyMmhFa2IvWW4rU2FaUWpP?=
 =?utf-8?B?a3VjaWdLM3V0d3ZiWStLV0NOczEzSVl1bWxTa1p2Mno4UlNJMnJQbFFqbWps?=
 =?utf-8?B?Y1pXNDBRNlNRSXNyY3FEcmNoMGRyK0lyeUhjYkxQRlVCL2c1VDQyOXlnM0pq?=
 =?utf-8?B?dkZRN3RXYm9DcG1xZGhFTzJvMDlVeWlzVFJmdGN5bkMvK0lVVWVRdXErUFFy?=
 =?utf-8?B?NjBvTWMwOGQvMmNkQVd1T3pnM25rTG9pZE9GTStROXNiM2h2dlBQWmVtWnZC?=
 =?utf-8?B?bTNRS3UwMXZrRmFWaEpiTnpQVGxYakxxN3JWenpIdDhrOFl0WjRvQk1teXRt?=
 =?utf-8?B?ZVJnRVEzcEk0aGJhYTE1bW9CZnNnSFVNNVM4cGdYSG1VQnlxckRTb0d2UHhq?=
 =?utf-8?B?M2gzSVV2VUNhNTdXSG1WU0oxWmpXdFFtcTREa0hpY0hBSWtBOFJjekdFRTVz?=
 =?utf-8?B?aDNicEdxOFZxTVR5UXNtYWJzMlhzOGJVaU53ZTlNUmFyLzVEcytENFBrNlNi?=
 =?utf-8?B?N05aeld3U2hPQ2V4Nll0Y2RqWGNPTTRtNTdIL2pIUVFzVU9qNDhSYkdzODJV?=
 =?utf-8?B?VHhHbGxPWVkvbjcrVlI5MFdhb1BrM05iQnZMbUhDRjBIMVBxMHRJeTB2YUN0?=
 =?utf-8?B?RHJUaW1peTNBYk83T1R0TDJRM0VZZ3A3SW9sRE9ZSXIvVE1QY1NFYnppeC85?=
 =?utf-8?B?VlNienRIaFpEU0c1a2dZV0l4SWU4S2xuS1F5ck05UmFwWithbks3TU1idEM1?=
 =?utf-8?B?Vk5DdWxVbW9CVGtxSVZKT21SWUpIRnJBSVk3NUQybUlNdHhEN0dBeHc4Ni96?=
 =?utf-8?B?NTYrM2JNa25LcEpRbm5EZ0sxMzVaeVFyRHZDM0M2bVMxOFRuRHpyek83ZDhr?=
 =?utf-8?B?WVFJd1h4UkJPWGFIb1ZUTzdLL1FCajlPcVh2bVlvS1F4bUU5YUF2RFlDV0tS?=
 =?utf-8?Q?5/DBFUGHzhZiaq9O7aIrxTzjmsmhRu+i5c3qS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84B6F5E9D17F4742ADD0D1956D488F42@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qwTTvQutX9vl12KR1rkUGoxXphhvthvXuHRmrtu1WvmF8t28aOJuHgAkGEHkQdpFRpGAg7HimqdKP0u90fWsRV0t9LecVdPzLqrCw4glMcg5hEYDUmHpcapsZAM269OozWxEwFE+e6bm2gzzF9KID5opxne0QN6cMyfkIQwfmsApDXwM1JFKgGmNziCvOyL9bh+74IGOlitS5RQuyKutFFCZ5T/cb+pxc37ttdrSPCyDr5k7KAXOvZNJDrDRNDvI+78rm+EpoNu9H7ctBKgQicGp0ybT7XVq5zmDQGlDb8bFy/HlE8/KRDT0ocVwINFCdML3FXGlU1lQifqccmuhzg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ebe2f3-9903-4ce0-0e69-08de8fc74a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 08:18:43.7982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYNn1ecOxbz/BVbPk0g21n4PoMytz4cuDKy0DzlHDvcygMAsjGNpJGNXgGTpZl9p8FES04YOLpYW5sObCpi98Ead+vCSJr6xhE9mT8WYQxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11746
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
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

DQpPbiBUdWUsIDIwMjYtMDMtMzEgYXQgMDc6MTggKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90
ZToNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8W2NsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbV0o
bWFpbHRvOmNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbSk+DQo+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MSAxMS8xM10gaW50ZWxfaW9tbXVfYWNjZWw6IGRyb3AgX2xvY2sgc3VmZml4IGlu
DQo+ID4gdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9sb2NrZWQoKQ0KPiA+IA0KPiA+IA0KPiA+
IE9uIEZyaSwgMjAyNi0wMy0yMCBhdCAwNDowNCArMDAwMCwgRHVhbiwgWmhlbnpob25nIHdyb3Rl
Og0KPiA+IA0KPiA+ID4gSGkgQ2xlbWVudCwNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTogRHVhbiwgWmhlbnpo
b25nDQo+ID4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjEgMTEvMTNdIGludGVsX2lvbW11X2Fj
Y2VsOiBkcm9wIF9sb2NrIHN1ZmZpeCBpbg0KPiA+ID4gPiB2dGRfZmx1c2hfaG9zdF9waW90bGJf
YWxsX2xvY2tlZCgpDQo+ID4gPiA+IA0KPiA+ID4gPiBIaSBDbGVtZW50LA0KPiA+ID4gPiANCj4g
PiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiA+ID4gRnJvbTogQ0xFTUVOVCBNQVRISUVVLS1EUklGIDxbY2xlbWVudC5tYXRoaWV1LS0N
Cj4gPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBbZHJpZkBidWxsLmNvbV0obWFpbHRvOmRyaWZA
YnVsbC5jb20pXShtYWlsdG86W2NsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbV0obWFpbHRv
OmNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbSkpPg0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+
IA0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTEvMTNdIGludGVsX2lvbW11X2Fj
Y2VsOiBkcm9wIF9sb2NrIHN1ZmZpeCBpbg0KPiA+ID4gPiA+IHZ0ZF9mbHVzaF9ob3N0X3Bpb3Rs
Yl9hbGxfbG9ja2VkKCkNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiB2dGRfcGlvdGxiX3BhZ2VfaW52
YWxpZGF0ZSBjYW4gYmUgY2FsbGVkIGZyb20NCj4gPiA+ID4gPiB2dGRfcHJpX3BlcmZvcm1faW1w
bGljaXRfaW52YWxpZGF0aW9uIHdpdGhvdXQgYW55IGxvY2suIFRodXMgd2UgY2FuIGNhbGwNCj4g
PiA+ID4gPiB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2FjY2VsIHVubG9ja2VkLiBJcyB0aGVy
ZSBhIHJpc2sgaW4gY2FzZSBvZg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+IGNvbmN1cnJl
bnQgaG90DQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gcGx1Z2dpbmcgb2YgYW5v
dGhlciBkZXZpY2U/DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEdvb2Qg
Y2F0Y2gsIGhvdHBsdWcgaXMgcHJvdGVjdGVkIGJ5IEJRTCwgYnV0IGlmIGFuIGlvdGhyZWFkIGNv
dWxkIHNlbmQgUFJJDQo+ID4gPiANCj4gPiANCj4gPiByZXF1ZXN0LA0KPiA+IA0KPiA+ID4gDQo+
ID4gPiA+IHdlIHN1ZmZlciBmcm9tIHRoZSByYWNlLg0KPiA+ID4gPiANCj4gPiA+ID4gSSB0aGlu
ayB3ZSBjYW4gYnlwYXNzIHZ0ZF9wcmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24oKSBm
b3IgcGFzc3Rocm91Z2gNCj4gPiA+ID4gZGV2aWNlDQo+ID4gPiA+IHdoaWNoIGRvZXNuJ3QgY2Fj
aGUgaW90bGIgZW50cnkgaW4gUUVNVSBidXQgaW4gaG9zdCwgbGlrZToNCj4gPiA+ID4gDQo+ID4g
PiA+IEBAIC01NDAxLDcgKzU0MDEsOCBAQCBzdGF0aWMgaW50IHZ0ZF9wcmlfcmVxdWVzdF9wYWdl
KFBDSUJ1cyAqYnVzLCB2b2lkDQo+ID4gPiA+ICpvcGFxdWUsIGludCBkZXZmbiwNCj4gPiA+ID4g
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9TUEM7DQo+ID4gPiA+IMKgwqDCoCB9DQo+ID4gPiA+
IA0KPiA+ID4gPiAtwqDCoMKgIGlmICh2dGRfcHJpX3BlcmZvcm1faW1wbGljaXRfaW52YWxpZGF0
aW9uKHZ0ZF9hcywgYWRkcikpIHsNCj4gPiA+ID4gK8KgwqDCoCBpZiAoIXZ0ZF9maW5kX2hpb2Rf
aW9tbXVmZCh2dGRfYXMpICYmDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCB2dGRfcHJpX3BlcmZv
cm1faW1wbGljaXRfaW52YWxpZGF0aW9uKHZ0ZF9hcywgYWRkcikpIHsNCj4gPiA+ID4gwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+IMKgwqDCoCB9DQo+ID4gPiANCj4gPiA+
IA0KPiA+ID4gDQo+ID4gPiBBZnRlciBmdXJ0aGVyIHRoaW5raW5nLCBJIGZvdW5kIGFib3ZlIGNo
YW5nZSBkb2VzbuKAmXQgcmVzb2x2ZSB0aGUgcmFjZSB5b3UNCj4gPiANCj4gPiBtZW50aW9uZWQu
DQo+ID4gDQo+ID4gPiANCj4gPiA+IEJ1dCBJIHRoaW5rIHRoZSBpb3RocmVhZCBzaG91bGQgdGFr
ZSBCUUwgYmVmb3JlIGNhbGxpbmcgOjpwcmlfcmVxdWVzdF9wYWdlKCksDQo+ID4gPiBiZWNhdXNl
IGl0IGlzIGEgZnVuY3Rpb24gY2hhbmdpbmcgdnRkIGRldmljZSBjb250ZXh0LCBlLmcuLCBQUVQg
YW5kIFBSUyByZWdpc3RlciwNCj4gPiA+IHBhZ2UgaW52YWxpZGF0aW9uIHF1ZXVlIGFuZCBpb3Rs
YiBlbnRyaWVzLiBXZSBzaG91bGQgYWx3YXlzIHRha2UgQlFMIGJlZm9yZQ0KPiA+IA0KPiA+IGNo
YW5naW5nDQo+ID4gDQo+ID4gPiBjb250ZXh0IG9mIGFueSBkZXZpY2UuIExldCBtZSBrbm93IGlm
IHlvdSBoYXZlIGRpZmZlcmVudCBvcGluaW9ucy4NCj4gPiANCj4gPiANCj4gPiBEbyB5b3UgbWVh
biB0aGF0IGV2ZXJ5IGVtdWxhdGVkIGRldmljZSB0aGF0IHRyaWdnZXJzIGEgUFJJIHJlcXVlc3Qg
c2hvdWxkIGhvbGQNCj4gPiB0aGUgQlFMPw0KPiA+IEknbSBub3Qgc3VyZSB0aGlzIGlzIGEgdmlh
YmxlIHBhdHRlcm4gYXMgdGhlIGluaXRpYXRvciBwcm9iYWJseSBhbHJlYWR5IGhvbGRzIGFuDQo+
ID4gaW50ZXJuYWwgbG9jaw0KPiA+IGFuZCB0aHVzIGNhbm5vdCB0YWtlIHRoZSBCUUwgd2l0aG91
dCByaXNraW5nIGRlYWRsb2NrcyB3aXRoIGNvbmN1cnJlbnQgTU1JTyA6Lw0KPiANCj4gDQo+IElJ
VUMsIHFlbXUgZG9lc24ndCBzdXBwb3J0IGNvbmN1cnJlbnQgTU1JTyBlbXVsYXRpb25zIHlldCwg
dGhleSBhcmUgc2VyaWFsaXplZCBieSBCUUwuIElmIHdlIGRvbid0IHRha2UgQlFMIGluIGNhbGwg
c2l0ZSwgdGhlbiB3ZSBuZWVkIGl0IGluIGNhbGxlZSwgbGlrZToNCj4gDQo+IEBAIC01MzUxLDYg
KzUzNTEsOCBAQCBzdGF0aWMgaW50IHZ0ZF9wcmlfcmVxdWVzdF9wYWdlKFBDSUJ1cyAqYnVzLCB2
b2lkICpvcGFxdWUsIGludCBkZXZmbiwgIA0KPiDCoMKgwqDCoCBJbnRlbElPTU1VU3RhdGUgKnMg
PSBvcGFxdWU7ICANCj4gwqDCoMKgwqAgVlREQWRkcmVzc1NwYWNlICp2dGRfYXM7DQo+IA0KPiAr
wqDCoMKgIEJRTF9MT0NLX0dVQVJEKCk7ICANCj4gKyAgDQo+IMKgwqDCoMKgIHZ0ZF9hcyA9IHZ0
ZF9maW5kX2FkZF9hcyhzLCBidXMsIGRldmZuLCBwYXNpZCk7DQo+IA0KPiDCoMKgwqDCoCB1aW50
NjRfdCBxdWV1ZV9hZGRyX3JlZyA9IHZ0ZF9nZXRfcXVhZChzLCBETUFSX1BRQV9SRUcpOw0KPiAN
Cj4gDQo+IA0KPiA+IE90aGVyd2lzZSwgaXQgbWVhbnMgdGhhdCB0aGUgZGV2aWNlIGFsd2F5cyB0
YWtlcyB0aGUgQlFMIGJlZm9yZSB0YWtpbmfCoCBpdCdzIG93bg0KPiA+IGxvY2suDQo+IA0KPiAN
Cj4gSSB0aGluayBpdCdzIHRydWUgYmVjYXVzZSB3ZSBhbHdheXMgdGFrZSBCUUwgYmVmb3JlIGVt
dWxhdGlvbiBzdGFydC4NCg0KVGhpcyBpcyBwcmV0dHkgZGFuZ2Vyb3VzIElNSE8uICANCg0KVGhl
IGVtdWxhdGVkIGRldmljZSB0aGF0IGVuZHMgdXAgY2FsbGluZyB0aGlzIGZ1bmN0aW9uIHByb2Jh
Ymx5IGhhcyBhIGxvY2sgb24gaXRzIHNpZGUgYWxyZWFkeSwgbGV0J3MgY2FsbCBpdCBkZXZfbG9j
ay4gIA0KDQpJIHRoZSBkZXZpY2UgZG9lczogIA0KCS0gbG9jaygmZGV2X2xvY2spICANCgktIHN0
YXJ0IGEgUFJJIHJlcXVlc3QgIA0KCS0gbG9jaygmYnFsKQ0KDQphbmQgaWYgdGhlIGhvc3QgdHJp
Z2dlcnMgYW4gTU1JTyBvcGVyYXRpb24gb24gdGhlIGRldmljZToNCgktIGxvY2soJmJxbCkNCgkt
IGxvY2soJmRldl9sb2NrKQ0KDQpXZSBjYW4gdGFrZSBkZXZfbG9jayBhbmQgYnFsIGluIHJldmVy
c2Ugb3JkZXIsIGxlYWRpbmcgdG8gcG90ZW50aWFsIGRlYWRsb2NrcyBvLk8NCg0KPiANCj4gVGhh
bmtzICANCj4gWmhlbnpob25n

