Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F2EFED2D7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 06:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ZP9-0007VJ-8x; Thu, 12 Mar 2026 02:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w0ZP7-0007UH-45
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 02:20:17 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w0ZP4-0008NR-DT
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 02:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1773296414; x=1804832414;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Oj39Mv9/1oEQ4yQnLb8T7R7SjERyhNZQnvJf/XRFu4s=;
 b=Dcj76s5+T5xCudmFqMUgCtHgKk7T3aUEL5RwA2mdcyUGRar57ox9M2ji
 lTH8N2K2BhBE6SPCsOyhwU1FgX0OJTLvhjEC3MHqNs4K/oayEaBuxyrXF
 uLJ1qPqRe0Eb6r6O4o0hn3t3OW2wTvdf+DijqyicZbYPZ/0QVmoI4ieUt
 sWWSm1yeWmqwhMZUQPMStrJWZvZ3xfo2g+wQR0T0EKc3Yqxv3HK5OBMQ7
 Hk3Ye1Y68KSSgjbLTCosahjzCKDropyCYbKOGWUSjhFGpYJMAzgpQXBuA
 n2LYNHPaU4RlfcC7ZCczAJdoC1jBz61td7ZStGQGZ/lKaTPqlit4sME0i g==;
X-CSE-ConnectionGUID: APqNkq5/TDWsCCHe/Pbfww==
X-CSE-MsgGUID: w2MoWg0aQUWE5OJDluHxbQ==
IronPort-SDR: 69b25b1a_SKmE3fcXDhH/0nmbJdroUSKj+Jij7rwaQcnqjeu58v45ZNf
 4Uu6cX7M2JOzKcjrx4o/sacXhhmUUh1BdUhZmJA==
X-IronPort-AV: E=Sophos;i="6.23,115,1770591600"; d="scan'208";a="49073916"
X-MGA-submission: =?us-ascii?q?MDEEBxJcCvHfrZOTbuVyyqjbHDASAoOpgsw2/F?=
 =?us-ascii?q?OLQC1yt1V/mqKBDYt4F8BS+JmJg7nRzHXdocraZG6ve20RElcRP5Nw9t?=
 =?us-ascii?q?rmi8uEHTKdVKLSD1PoeoTUY0tHpKkW7EhyNKfXJ+kPOAQ3ExUdyngRRC?=
 =?us-ascii?q?M9v0W8+0oCujqUBOihIbuZxQ=3D=3D?=
Received: from mail-northeuropeazon11011011.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.11])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Mar 2026 07:20:09 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvkkI8v1CEfkx2y+7Ic2Udyr73qH64jP/PBQvTgQ76smr1Q89Fp3LzSe7YU9kXxrlray/KfPOJX0EIS3EQ2lUlcLDfMl+Cmm6kvsF/1zX3xZs84VQgQmDXHcfV4k7AgUHSM7rxqlxh+g+sRbAP9ExRhWY7vgLzQAkHSzA0x6X4HZPpLo80Z87vL0joiajWDYuBP0D017+CU1T4QQdw7pne34X4X1ZE2fh9S5IuN3D9+cEKeKb4BHOAWEhI3kM9js0drM0amHfBQUDRSC2elRQg6LVvTXb9GSwk+iIHopQJLi3PinS86CnoAPsGACSm3svE9vxTHgr3FpbYAUZW4/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj39Mv9/1oEQ4yQnLb8T7R7SjERyhNZQnvJf/XRFu4s=;
 b=zDwXpMDCUcd7sRW5gIKJj/CIeXFAQpll5g8vUV4ZzKd1ig4K/iR+o4JUQ5TNQy05RmK//0eIywjf1MCZxXxh4y0N15+43i14bX45zzMlDPi+j3LsdbuwzxVN/KVNPOQkYMvajf2Y2qTCENJgP8aNSuHoB8p2/tj15B1Zo9rqlv6i7aDQ0WVGqBb0tjmrdZgg88cqRxaISh880yiSolPueY0Vlg22H4qqVh9u+SRGyUgNMAX6rB0IG+3b8UZwiupyPU2RSaHtIffjaEoQIX0PAwY0H5tXGgHDnQ8mmmbtYxbguYSWN99vYhswSB2csy4jvUul0ctx1sCmnPsHKjl4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by OSKPR07MB10495.eurprd07.prod.outlook.com (2603:10a6:e10:97::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 06:20:03 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 06:20:03 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: Yi Liu <yi.l.liu@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>
Subject: Re: [PATCH 1/2] intel_iommu: Only set dirty bit when PTE exposes
 write permission
Thread-Topic: [PATCH 1/2] intel_iommu: Only set dirty bit when PTE exposes
 write permission
Thread-Index: AQHcsFskubOEgFc8HEeHP9N2sSLBHrWqQIEAgAAvLAA=
Date: Thu, 12 Mar 2026 06:20:03 +0000
Message-ID: <ca81cba3d96c61558ff3058b6deeff3b7716b658.camel@eviden.com>
References: <20260310065644.426838-1-clement.mathieu--drif@bull.com>
 <0478ab32-cec0-4872-ad09-340a73cce7eb@intel.com>
In-Reply-To: <0478ab32-cec0-4872-ad09-340a73cce7eb@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|OSKPR07MB10495:EE_
x-ms-office365-filtering-correlation-id: b3de4cda-292b-4934-e993-08de7fff659f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: rx083sGmKmQajWsRNUT72fXH2I2wCVgFoBREm5Ge+C17vL3+LXtoa5x3REW6RmlgtigLk8IeyUk0TAUEXBfZuJFT0itiE/LuXSOGX6h27G5ixleqadlQ7nyM78tVCwrDyYYijLExbOaHnij4t1iICvR/WDoNFY+2hmcDBsR9CbtIuhlrJjI+frM2KxHdDODVqNq96VVVstNQUv1HfY2mEUpCeLjgW23LxaE6xVtZOLLT6fPxJRys9Om+AJknDmsh0pZEBNmdWWVhL+hhrG6i912xUSxrtWMvTSW52+LtNftjqhJKI9CVW9YSBHGS4ZIU458ySLkhOeifrPFdODstixiC+TU+Z8q1dieelrvNZrEU32bj6y766+2/YyQDI/g4PqisZcx8AKpI358hHgPNVAQI2O/ezwrQNZ5itIOJcQdbchGq8XVL4G+idnAr/L24TwsBEY6oUDgtQTsvAutUQdP+Ub5sqarMmTzj2zpY0uHjVt/stMhvJaRDjNNMO6VaRh/UiR9kYn2Hdiz3jmKOtNIRMfCa5qMKFm5blVOyRPBjg1DRbEuNLeR0o2CUrIv+nQ39PsoycKVTSjL1QZFeE8uWezZARoLxAdA0u+7M5LJJS+cpsiSpD5jdKeilpCiib07ySyV7HLHxP7OKjB6SriFc83+v9CyfYHXyasdPVoJ1Ho7Bc1J4vw6715cYp+un6k39XlMpx9hMUQhkSCkh9tG7kEsyYzOdu6BzLYcjuK9PzXupiM1e8BNVjXmN9+AVFZW8vx9rx1ALFABBnnSWuFXCxGsw0DyNzonU9R8jmpg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFBmQ0NFK2E0dDRwbVVTUDNBZUZTK0FvOFF4Y0RlelQxRk56NXllMkhmVlJL?=
 =?utf-8?B?QndBcjFUbVlJOVdJV3dHSWhzNmtOOGVDckxobEpGQmEvYWc3V3VjYjA4YnR2?=
 =?utf-8?B?SXF5MStIUndxdnR0aVlTZU5RTDhRb1BkSXcwYXZFdmpCaXBLdk5VMHlKRFlu?=
 =?utf-8?B?YmViQ1dkMk5veTVpM3IwdnZlZlJsT1hHaVBMbkhyL3V5SFVwQldLNUdoc284?=
 =?utf-8?B?b3JuNWxYWG1XRTFncFV5NXFnOWQvbUJTMDZhNStYM2lIeGs3M0RUeVpJTW9a?=
 =?utf-8?B?bHhnQ3lIK2Rpb1BPSXZibVljN3NRTE9STDlwVnMxREVVakU2NUVNK2t3QWNh?=
 =?utf-8?B?d0REU0kxRy9QaDFiN2NieWRFM1FUYk5LMmpML0dkT2FpV3B3c1cvNHk5d1cv?=
 =?utf-8?B?ek12THlzd1ZUc1dCUm1NSVNhUCtUaVBUWllueTZvQTA4RjIwSTJ3RHJmcjdB?=
 =?utf-8?B?RTNpV2JjWThUZHBmR2w0RmJKK1ZDODI0b0RtREJ2bTV5bWh2blNKZGRNQkZy?=
 =?utf-8?B?SkdVQWw2OXVpc0NEK3V0R3ZQZVBQTytUTFZuWFR2Y0JlRkRzUDVob1NhMmxq?=
 =?utf-8?B?UnB2VjJVbE41eEFLeERTdUxZZGNVV3p3ZUlXNnlYUWlRWC9ETFJLc2pFbEVN?=
 =?utf-8?B?bDZiTjJiZUVObzZDSjlXaStoYjJjRk9McEY1dGg5RFZPeHFWeWEvT2V4OXRI?=
 =?utf-8?B?ZlZ4VVNMYXdWeVVGWEpBbTM0T3FEazZzeUNIalJUZGc1b1lFaWhHVEk2Yzcw?=
 =?utf-8?B?amREOFNmS08zMEY5R2x4L0hCVmEwalkxeTlXUjFjSkE2Nm1KN0ZVSUJXdTRR?=
 =?utf-8?B?WFBZZ2JUS1JaVUs2d2U5TVA2L2RlNzR5SGNmOThSVjhLZk9STE91V3VGM0lT?=
 =?utf-8?B?YjBzekt0cW5WSDRrY3dNdnl0R3VCa25sQ01haitCNlFJZjA0MnZGSitjbU1H?=
 =?utf-8?B?bmYxSStyeGNtSG5nYVlCKzBjUURFc2NnNzZuTnlid2M2bG9MNUNWWWZsc2hW?=
 =?utf-8?B?STlNRXFFZnNLQTVPT1g4TXdsb21xaUkzS3pPeWgranlQaGw5N1RPMWl0dGU2?=
 =?utf-8?B?aUdBUlNGcTNxWDg3d2NkOFNnU1p5cFZ2TWVKZnpCZkxWZUZCUzc1dUNjMGM1?=
 =?utf-8?B?Q2lPZCtxei82ZEs3M25LNGhrSWhZUDlNY1Z1KzM3anpzZlFlMmZ5aTJFWmhD?=
 =?utf-8?B?Y2VuaE5sM0hocGNTVzRlRm5LRUk1M2lxcjZMRlFYV3dDcUw4UVNxZzlsOFhi?=
 =?utf-8?B?TWFQVnhwaWJvL0pOZHREbG1BVFNOajZZTFRYRU9tMC9xSGpLR0FrMzlHaUgr?=
 =?utf-8?B?TmEra2RtYXBQMFRTRWE1Y3p4TXorNytOS2UyQUM2QXdYOHhwWVNuSjFSUXdI?=
 =?utf-8?B?RWxIS2kvdGtYOEpBWkJFSnVhdml2VStXcE9jb2YzZnNtQzVPUzE0dVAyZmFz?=
 =?utf-8?B?OVlCTFpMZ21EYXpCMVd5UmF0eWt1UGhXUW9yZ21aZ0EydkNsSGw0SmZoa2JK?=
 =?utf-8?B?SW5XVUhlWVZOVnZyam5PRnhHZzU1c2phT29WcjZjL3lOZkI5U010VlNPTS9E?=
 =?utf-8?B?WmtyR3ZQR0JBRUxTd2VXQzI2aEs1V3I1ZmlvMkRNYnUxSE94Zjhic0llaXVZ?=
 =?utf-8?B?UnlPL3VUVnB0TUtnQnU1blZHMkNDTW9sYlNrNVg0Zlg0Z3dzQzJsSHFjRnJ3?=
 =?utf-8?B?MG5oc1BhdHAzcUFxN3pzZVU1MkluQkxEWWV6Zld0T1p4aFlBRXpCSmZwSktD?=
 =?utf-8?B?Q1E2emVFZ1JoR09kTkRBZ3ZpUWhEQkNrc1dsK2hFNE8zRHhUbWI0L0pHVzls?=
 =?utf-8?B?YTdUZ2FqSlg3end6UldqN0dGU2xxM0tvOVFDU2krbHN4V3BtcldHM2tKYllU?=
 =?utf-8?B?OWp6dmQ2VjFXcWkxWWJ2K0pDN0FyVGxYRk50dFJvYk9SQUNwbFFNNk5yMVJl?=
 =?utf-8?B?MzM2UEp1a1d5bmJxeG13dFJ3RVVEYmk5NHNKMVpoNlh2NU01dE1xMldZc2wz?=
 =?utf-8?B?TTlMMC9Gak5HWDZvaGZYV0E1aDRRb1ZvT3lQbVZCakQ2OHJjYTJKVDJYa011?=
 =?utf-8?B?TkJJNUxaaGJIWEQ2TDBHR2kwcWtVTzdxRS9qZUJ2YllSaWMvL0xuOGI2TkFM?=
 =?utf-8?B?Z2VBeTU2YitlK0RRNUROZnNrNVc2TnNlSGN3V1czZkJROU90ZWR4dnJJNzZq?=
 =?utf-8?B?bldBVktGT1VpREtzOEVlTTB6OThvQ3BlVUhzMVN5WHZiYkwyVmlQQmJsYms4?=
 =?utf-8?B?UHFjSS82azhKUVRqYUIvazFjdjA5SDdkdUVKQi94Zi8zWGxUN3oyRmt0elJn?=
 =?utf-8?B?YUw1a2ZCMXh3NXB5KzV3cWZOUUwrRWRiSklraTNDZG5VK25uQmVGZ041Nms5?=
 =?utf-8?Q?1Up86j2DN400hVO2POMW7mUk92Cu4QZwkr9OS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A91717C5DDDDA84282475B2CD0670442@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BpFiJmfd01NaNHLky+PHRAIPlJomgFpOULKeknbI2g5jQ+FuRkksq/waCiODMD8K/OkDfw6sRyFnwy4zv+h9OfEP5ShdT8DfsLsQK0GitCFfVgkCPvUzq2vztZocorRGcs6Kq8EX40Hk1hkkhdLQIbyuRUJojsD5U+clFUahldqruF2O+G6SP9oWa0JwFGn7MLCRROqzbNQNyFpSnMfTeRkhVMN4vieGz0nPgCopbHoWwtVmHHngBdjQeoMrV+PfHVRj6f1tiVT0BsMxMcJ3a08DhRV3grvClOg/G8Y/KmXf6ON+6ZDmfqfoqJUIyvTh+z62lAjqQsABHhHYm86J5g==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3de4cda-292b-4934-e993-08de7fff659f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 06:20:03.1294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEVQgq+2xyt0gI3uawiTocfYxcRHiMbjYAg4xAS3mu4MyXrD4Pe30yCQ4gUIYaqcUn0l5SsFjm62TCvsGKo3vnigOZJLTCmcxS8hdmLxBS/QXq/F0Hb84kzkxh8NqJT1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10495
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

SGkgWWksIFpoZW56aG9uZywNCg0KTW9yZSBkZXRhaWxzIGhlcmU6IGh0dHBzOi8vd3d3Lmtlcm5l
bC5vcmcvZG9jL2h0bWwvbmV4dC94ODYvc2hzdGsuaHRtbA0KDQpEdXJpbmcgbXkgZGVidWdnaW5n
IHNlc3Npb25zLCBJIGdvdCB0aGUgZm9sbG93aW5nIGZsb3c6DQoNCi0gRGV2aWNlIHNlbmRzIGFu
IEFUUyByZXF1ZXN0IHRvIHRoZSBJT01NVSB3aXRob3V0IHRoZSBuby13cml0ZSBmbGFnIChzbyBp
dCByZXF1ZXN0cyBSVyBwZXJtaXNzaW9ucykNCi0gSU9NTVUgd2Fsa3MgdGhlIGZpcnN0IHN0YWdl
IHBhZ2UgdGFibGUsIGZpbmRzIHRoZSBsYXN0IHB0ZSBhbmQgbm90aWNlcyB0aGF0IHRoZSBXIHBl
cm1pc3Npb24gaXMgbm90IHNldCAoSSBrbm93IHRoaXMgcGFnZSBub3QgcmVhbGx5IFJPLCBJIHBy
ZXBhcmVkIGl0IHRvIG1ha2Ugc3VyZSBpdCBpcyBDT1cpDQotIEJlY2F1c2Ugb2YgdGhlIGNvbmRp
dGlvbiBJIHVwZGF0ZSBpbiB0aGUgcGF0Y2gsIHRoZSBJT01NVSBzZXRzIHRoZSBkaXJ0eSBiaXQg
ZGVzcGl0ZSB0aGUgYWJzZW5jZSBvZiB0aGUgUi9XIGJpdA0KLSBUaGUgZGV2aWNlcyBnZXRzIHRo
ZSB0cmFuc2xhdGlvbiBjb21wbGV0aW9uIGFuZCBkZWNpZGVzIHRvIGlzc3VlIGEgUFJJIHJlcXVl
c3QNCi0gVGhlIGtlcm5lbCBydW5zIHRoZSBoYW5kbGVyLCBzY2hlZHVsZXMgdGhlIHdvcmssIGFu
ZCBlbmRzIHVwIGNhbGxpbmcgaW9tbXVfc3ZhX2hhbmRsZV9tbSAod2l0aCBmbGFnIEZBVUxUX0ZM
QUdfV1JJVEUpDQotIEl0IHRoZW4gY2FsbHMgaGFuZGxlX21tX2ZhdWx0LCBfX2hhbmRsZV9tbV9m
YXVsdCBhbmQgaGFuZGxlX3B0ZV9mYXVsdA0KLSBJbiBoYW5kbGVfcHRlX2ZhdWx0LCBpdCBydW5z
IHRoZSBmb2xsb3dpbmcgZnJhZ21lbnQ6DQoNCmBgYA0KaWYgKHZtZi0+ZmxhZ3MgJiAoRkFVTFRf
RkxBR19XUklURXxGQVVMVF9GTEFHX1VOU0hBUkUpKSB7IC8qIFRoaXMgaXMgdHJ1ZSAqLw0KCWlm
ICghcHRlX3dyaXRlKGVudHJ5KSkNCgkJcmV0dXJuIGRvX3dwX3BhZ2Uodm1mKTsNCgllbHNlIGlm
IChsaWtlbHkodm1mLT5mbGFncyAmIEZBVUxUX0ZMQUdfV1JJVEUpKQ0KCQllbnRyeSA9IHB0ZV9t
a2RpcnR5KGVudHJ5KTsNCn0NCmBgYA0KDQotIHB0ZV93cml0ZSBpcyBkZWZpbmUgYXMgZm9sbG93
cw0KDQpgYGANCmludCBwdGVfd3JpdGUocHRlX3QgcHRlKQ0Kew0KCS8qDQoJICogU2hhZG93IHN0
YWNrIHBhZ2VzIGFyZSBsb2dpY2FsbHkgd3JpdGFibGUsIGJ1dCBkbyBub3QgaGF2ZQ0KCSAqIF9Q
QUdFX1JXLiAgQ2hlY2sgZm9yIHRoZW0gc2VwYXJhdGVseSBmcm9tIF9QQUdFX1JXIGl0c2VsZi4N
CgkgKi8NCglyZXR1cm4gKHB0ZV9mbGFncyhwdGUpICYgX1BBR0VfUlcpIHx8IHB0ZV9zaHN0ayhw
dGUpOw0KfQ0KDQpib29sIHB0ZV9zaHN0ayhwdGVfdCBwdGUpDQp7DQoJcmV0dXJuIGNwdV9mZWF0
dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfU0hTVEspICYmDQoJICAgICAgIChwdGVfZmxhZ3MocHRl
KSAmIChfUEFHRV9SVyB8IF9QQUdFX0RJUlRZKSkgPT0gX1BBR0VfRElSVFk7DQp9DQpgYGANCg0K
LSBUaGUgcHRlIGhhcyBEPTEgVz0wIHNvIHRoZSBmaXJzdCBoYWxmIG9mIHRoZSBwdGVfd3JpdGUg
Y29uZGl0aW9uIGlzIGZhbHNlDQotIEFzIHRoZSBDUFUgSSB1c2VkIGZvciB0ZXN0aW5nIGhhcyB0
aGUgc2hzdGsgZmVhdHVyZSwgcHRlX3Noc3RrIGlzIHRydWUNCi0gSGVuY2UsIHB0ZV93cml0ZSBp
cyB0cnVlLCB3aGljaCBtZWFucyB3ZSB3aWxsIHJ1biBgZW50cnkgPSBwdGVfbWtkaXJ0eShlbnRy
eSk7YCBpbiBoYW5kbGVfcHRlX2ZhdWx0DQotIEFmdGVyIHRoZSBmYXVsdCBoYW5kbGVyIGhhcyBj
b21wbGV0ZWQsIHRoZSB3cml0ZSBwZXJtaXNzaW9uIGlzIHN0aWxsIG5vdCBncmFudGVkDQotIFRo
ZSBQUkkgcmVxdWVzdCByZXR1cm5zIGEgc3VjY2VzcyBjb21wbGV0aW9uIGNvZGUNCi0gRGV2aWNl
IHJlcXVlc3RzIHRoZSB0cmFuc2xhdGlvbiBhZ2FpbiB0byB0aGUgSU9NTVUsIGFuZCBnb2VzIGJh
Y2sgdG8gdGhlIGZpcnN0IHN0ZXAsIHRyYXBwZWQgZm9yZXZlci4NCg0KTm90ZSB0aGF0IHRoZSBz
ZWNvbmQgcGF0Y2ggeW91IHJldmlld2VkIHdhcyBtYXNraW5nIHRoaXMgYmVoYXZpb3IgYXMgaXQg
d2FzIHByZXZlbnRpbmcgdGhlIGRpcnR5IGJpdCBmcm9tIGJlaW5nIGFkZGVkIHRvIHRoZSBwdGUg
bW9zdCBvZiB0aGUgdGltZS4gIA0KVGhpcyBpcyB0aGUgcmVhc29uIHdoeSBJIGZpeCB0aGVtIGlu
IHRoaXMgb3JkZXIgby5PDQoNCmNtZA0KDQoNCk9uIFRodSwgMjAyNi0wMy0xMiBhdCAxMTozMCAr
MDgwMCwgWWkgTGl1IHdyb3RlOg0KPiBPbiAzLzEwLzI2IDE0OjU3LCBDTEVNRU5UIE1BVEhJRVUt
LURSSUYgd3JvdGU6DQo+IA0KPiA+IEF2b2lkIHVuaW50ZW50aW9uYWxseSBmbGFnZ2luZyB0aGUg
ZW50cnkgYXMgYSBzaGFkb3cgc3RhY2sgZW50cnkuDQo+IA0KPiANCj4gaG1tbS4gbm90IHF1aXRl
IGdldCBzaGFkb3cgc3RhY2suLi4NCj4gDQo+IA0KPiA+IEluIHRoZSBjdXJyZW50IGltcGxlbWVu
dGF0aW9uLCB0aGUgZGlydHkgYml0IGlzIGFsd2F5cyBzZXQgaW4gdGhlIHB0ZS4NCj4gPiBIZW5j
ZSwgYW4gQVRTIGRldmljZSByZXF1ZXN0aW5nIGFuIFJXIHRyYW5zbGF0aW9uIGZvciBhIGNvcHkt
b24td3JpdGUNCj4gPiBwYWdlIGlzIGxpa2VseSB0byB0cmlnZ2VyIGEgUFJJIHJlcXVlc3QgZm9y
IGEgcmVnaW9uIHRoYXQgaGFzIGp1c3QgYmVlbg0KPiA+IG1hcmtlZCBhcyBkaXJ0eSBieSB0aGUg
SU9NTVUuIEhvd2V2ZXIsIENQVXMgdGhhdCBzdXBwb3J0IHNoYWRvdyBzdGFja3MNCj4gPiBnaXZl
IHNwZWNpYWwgbWVhbmluZyB0byBQVEVzIHJlcG9ydGluZyBXPTAgYW5kIEQ9MS4gU2V0dGluZyB0
aGVzZSB2YWx1ZXMNCj4gPiBjYW4gY2F1c2UgUFJJIHJlcXVlc3RzIHRvIGNvbXBsZXRlIHN1Y2Nl
c3NmdWxseSB3aXRob3V0IGdyYW50aW5nIHRoZQ0KPiA+IGV4cGVjdGVkIHdyaXRlIHBlcm1pc3Np
b24sIHdoaWNoIGxlYWRzIHRoZSBkZXZpY2UgdG8gZW50ZXIgYW4gaW5maW5pdGUNCj4gPiBsb29w
IG9mIEFUUy9QUkkgcmVxdWVzdHMuDQo+IA0KPiANCj4gYXBwcmVjaWF0ZSBhIGNsZWFyZXIgZXhw
bGFuYXRpb24gaGVyZS4NCj4gDQo+IA0KPiANCj4gPiBGaXhlczogNjVjNGYwOTk5OTkxICgiaW50
ZWxfaW9tbXU6IFNldCBhY2Nlc3NlZCBhbmQgZGlydHkgYml0cyBkdXJpbmcgc3RhZ2UtMSB0cmFu
c2xhdGlvbiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxbY2xl
bWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tXShtYWlsdG86Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGJ1bGwuY29tKT4NCj4gPiAtLS0NCj4gPiDCoCBody9pMzg2L2ludGVsX2lvbW11LmMgfCAyICst
DQo+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KPiA+IGluZGV4IGQyNGJhOTg5YmYuLjU2MTQ2YWFmYzEgMTAwNjQ0DQo+ID4g
LS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+ID4gQEAgLTIwNjYsNyArMjA2Niw3IEBAIHN0YXRpYyBpbnQgdnRkX2lvdmFfdG9fZnNw
dGUoSW50ZWxJT01NVVN0YXRlICpzLCBWVERDb250ZXh0RW50cnkgKmNlLA0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtVlREX0ZSX0ZTX1BBR0lOR19FTlRSWV9SU1ZEOw0K
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gwqAgDQo+ID4gLcKgwqDCoMKgwqDCoMKgIGlm
ICh2dGRfaXNfbGFzdF9wdGUoZnNwdGUsICpmc3B0ZV9sZXZlbCkgJiYgaXNfd3JpdGUpIHsNCj4g
PiArwqDCoMKgwqDCoMKgwqAgaWYgKHZ0ZF9pc19sYXN0X3B0ZShmc3B0ZSwgKmZzcHRlX2xldmVs
KSAmJiAqd3JpdGVzICYmIGlzX3dyaXRlKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZmxhZ19hZCB8PSBWVERfRlNfRDsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiA+IMKg
DQo+IA0KPiANCj4gdGhlIGNoYW5nZSBsb29rcyByZWFzb25hYmxlLg==

