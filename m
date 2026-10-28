Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90F606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bull.com header.i=@bull.com header.a=rsa-sha256 header.s=mail header.b=nMH1pqQf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4Oa-0000KV-UA; Wed, 28 Oct 2026 10:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xM4OZ-0000K4-Au
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:12:51 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xM4OW-0002Xe-Um
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1793196769; x=1824732769;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YCltASmbtODTv8ERO9gJlglHxEhRndocZer3YM9afSw=;
 b=nMH1pqQfxZsZysVQeB6Ll7zIaZwi2AV5a6fCWXGXxIZuBiFmC50bOT2D
 uzn2whoGHVJSGraT8BDKAvSFPdg7fetCldVAtLidZC94aNEnhTE1sitc1
 TuKZJKg+xq3R8lEofYRcxKUn4L7LdB6zFRzbpfsILtZyAvf1tQ7rxN4pj
 vU2LfRJLoc7kDcBvFuD1C3PBW8SX72WsTTU+FcuenFfkgAdllqae9x421
 Ptqrbih08wf+flmqakyJaibI6oCcSJfbJbvCvzNxoFJTr3czEOuYpLNSz
 ctUctv6DogjzVAvaezkzD+kplGDKXJM0CmL3driufP8Q3mIFAXtig+spW w==;
X-CSE-ConnectionGUID: faOx2EK1TN2h6cUIkUP3zA==
X-CSE-MsgGUID: aVkDoxHfRBGsEy61c9xJrg==
IronPort-SDR: 6ae202dd_3Fzlx2IQPW5ZWjnZI6P+90tAlHyQIctIYogMsiJlD2fV9w1
 2UQ1eJE7TYz0LDzovPRobYcTpeWBaJO0goCK2HA==
X-IronPort-AV: E=Sophos;i="6.27,182,1787004000"; d="scan'208";a="49035297"
X-MGA-submission: =?us-ascii?q?MDGakuU3huEtTD0mlJQkU408pJ8/sk5sC6iJR9?=
 =?us-ascii?q?4IPyUK1VMHv90rpG1aHeVtleeGb/9LlzTVCpbT4uK3xkQ6FGZMjzBA3D?=
 =?us-ascii?q?K1hDxVgki1xdk4vhiWxdIcWL5tC2CccKFmRJoKmuCvPW8WudJf6sxxxB?=
 =?us-ascii?q?MKtal3ojZSBAtB4Ag9icmPmQ=3D=3D?=
Received: from mail-francecentralazon11013001.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.1])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Oct 2026 15:12:45 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOEshpHiJzs9o7qVynnq2AvF3YC11IoSfdpZumFaeN5PVLjrvh9bNPcnf/jFnNLTWcdc/uvIoK+yyjyebZw8ADB+UUJsktq3MdTNZDCzbJhAV4oWAk6k6KHI8PHgPzcdlypIMudFEC6pmLp0xdQhhVMOtha1FFHGgEutQKV+q/KgSMlWCpNrz12C9sCXHsn9GzO5LJQaV3jww7PlAWJR/hAfme/sS3fSuN9M39lfyHJi01FEoRiYmz7335TAdTirYqH2VJpPIo/oPN27k52UT+hPT9z7K3ybp/w0ktc18/ZlWY1Wh/eSRcUlwPrYOUqkHV00vjWUQjW6ILBK/ysdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCltASmbtODTv8ERO9gJlglHxEhRndocZer3YM9afSw=;
 b=M1CUP7diJwIb057wRnZAAjoSQBJj8sT0dnZYmFwjAjM4InChEE/E82cZfdIfmZhz3YC6rf1OIQM38n7GkubqlhZlatVfe3v6wcV4+shRjlpEQdkyZaZLCis9y5NDj/DV0lyciQpyKie2vk1fCjkjEk7/4VxNyJA91/ZzVlMq/PE3WHFetrTsid4LvUWOdlCjTHMbuJG1gxeb5jrMiWi5Lpfk7nVRDmPpLwIYOIZCQNsuHKCrOmYeQItZwBAF/MLfKWp0j4YciJGGMSTrBwf2i5+YERXZXFdxrwFTTU7Fmx3mtTMiolGDTSKfrCE3WFVxAgonkJbCG796SnBI12qkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by MI9PR07MB948908.eurprd07.prod.outlook.com (2603:10a6:290:be::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:12:43 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:12:43 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "odaki@rsg.ci.i.u-tokyo.ac.jp" <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH] pcie_sriov: Avoid capability structure overflow in PF
 reset
Thread-Topic: [PATCH] pcie_sriov: Avoid capability structure overflow in PF
 reset
Thread-Index: AQHdSY5ZcmZDGZMVw0GjF8dGChIOELcTKWYAgAAHQICAAAL7gIAABg0A
Date: Wed, 28 Oct 2026 14:12:43 +0000
Message-ID: <843ada23fc5c54c2fe70fc0f569241a43635b6b0.camel@bull.com>
References: <20260921055917.715685-1-clement.mathieu--drif@bull.com>
 <20261028091349-mutt-send-email-mst@kernel.org>
 <c86e267518a07ddf993127c0427dce1543410b4f.camel@bull.com>
 <20261028095024-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261028095024-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|MI9PR07MB948908:EE_
x-ms-office365-filtering-correlation-id: db991c17-0039-4ca2-f002-08df34fd88a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|261026140227099003|261009223027099003|4143699003|261022105027099003|261022075727099003|261021121427099003|10067099003|11063799006|261021123027099003|56012099006|261026121527099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: 0slfd/WAg1EHHau7ovQqTNb0judoF1ZgasSoq13qlN/Cag+9JgPaKy34mTDVfzxgRNlD8ISWRv0i66B/CfxtxPP992oUuAXMizA3Ci5lCt1rHC7swKG4DzX2Um0KuOb1t+IMVh8BwFE3LXtJuQQSkcnZkr7njBa1a7T3VClcYXmPdaLI92iCnIMWdMjLv3VDdHwKNELy8SQMdkR8BmGqpmvdU7xSiqRgbKenAlPwwHYSppargbqODn67z3DocCtQT7ok4PJrE1YXFxYNMwWb6f7OgF1oijQugU0mSrDJ0srhZI+Y3l60glfbY9KAAbsUOBZ6G9+n9H9i3UClUssRCbu7i/NV1S+LXb/WPqrh1ItVt6I/qVUIzIX5/XosHtAWBonjpEEl8sDRRtQfymOCx9Gei71xEdlhNbZ5iTk/p3zFrQWf9v0UkiMTdwX+IH1yKTTyJj0sDZNRGgzPXpiOe/6blHcYRWldfOFI9eUh3F2YYbgzCueQFHeMSD6YGubqLFvyu66bd3gaybyW17+hloVY9Zy3dBR1k0btqskDMYomHPwdhTPMbZoKIdEEvNTwfQoo3FxDH/s8LkeEh4D+4i+4Ubj0cQRNmyFhtllov25TkZNSOBghQftA85dW4FaId5e1leWclkZx8zcpE9ndsRhPnV5LsKIEXURMWPRHvOsooDE41w2hhuJfKMepGllagql6XxcbRCBNANUUgI2q1h1nrCEFZHJT38x8OumljLU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(261026140227099003)(261009223027099003)(4143699003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(11063799006)(261021123027099003)(56012099006)(261026121527099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzYzRnJic2hFUEc2NnRYR1ZSRUp0OUJiRGx0LzBnSWExb1BMb3IwaTkxZFFz?=
 =?utf-8?B?MGZ4aUEyT2pIV2U5Wi9mejlZZysxbXp2aHV1SGhDd1hmck91R0ROYjhqTE9P?=
 =?utf-8?B?WlErMHFoVnJ5U2JjNnRQOEtPWDdBSkE1MWIzWkkrYXcwZ0Z2VkRNVXovblNM?=
 =?utf-8?B?OHpwekNuYXhkdW4vbXNEaGJrTG1rSlV2Ymxlb0pSOTBTVDFlaUlsanVsMlRk?=
 =?utf-8?B?SU1lbUlmSUVlTjZ6S3NSYzRBOW5zdm8yQTVMeDA5ZCtPeDJNZHdKVGt1WlA0?=
 =?utf-8?B?RHRUdXVGMHlmaXpoV1NYV0h2cmhhbTJRUW9ZM1hDNXp1dVRuTithTGJ3ckNZ?=
 =?utf-8?B?dzZYd1FsUEU4WmRFclNUVjFFYTVsU2s4bmdHZzBPWEs1UjVTZk1OTU1yc2My?=
 =?utf-8?B?R21jb1I4MkdIM2FuZFJQdXVBUk5hY1hNWEUwcGhVUkwycWZkMVdrdzVqWEQv?=
 =?utf-8?B?dW1TT0ZHSldiK2ZtdXg4akJaNVBZejNjRnEwVVdBZFRqZGJZa1VVbTMrckNP?=
 =?utf-8?B?Ulk3c1FlbU1NYnYrRnlKb2pFL2pEdlErS3J3R2dScms0aWZHY00vWkxqaEZJ?=
 =?utf-8?B?Qk9ySFZmUFo5YitzTWhFTmlxQUpJSHl2MDFrU0Y3WnpDQzMwTndNb1Mva2lq?=
 =?utf-8?B?bGlIblhpMHdudlY1WXhZVU9lS0tqNFQ5RkMvOVlaZ0dQTE9aeHd4V3NRWnFh?=
 =?utf-8?B?VjRCMVFtT0ZKU01EdHNCVGtqRHR3R3lUMmFBcEVIZGlpVjdiTDk4RXpRTGJa?=
 =?utf-8?B?Sk45Wmphd1hlY2p1VW9HUU55Y2hFL29GYmpncUdSKytEOXFYT3MvWWZOZ1dn?=
 =?utf-8?B?c3hhRHZyVzRsdjNDbWhOc3hYeEhvY3JZcmtwVjhMNUdvU0tXNzcyZTM0NmdU?=
 =?utf-8?B?T1pxcmpGNkVoZVNxejVjWmtJUzJtYzB3V1gxcHhWVnBmRDNsdFlOYWhHNDBN?=
 =?utf-8?B?ckY5eVRXdXA5clU4Vk9zUzh6WHQ4MDdDamhQOFZHdWZMM3hnMFJ1WCt4bndF?=
 =?utf-8?B?b1oxNk8wMXoxSDBtMzNCZ3dOazNQQVpucHc1Q09hQWliZi9GTTFZWnhUWVpY?=
 =?utf-8?B?Y0tBejY1NXAyTnNMZFBxMHJ6RWl4MnUwbnJLSERPaHlMdWZudGduUzJPZVFm?=
 =?utf-8?B?Qk01NExGRFZjV0pRLzcxMzFLQmFuN1YrbXFPMFlNa2pNdzZwSUo0YnduaDZw?=
 =?utf-8?B?bXllcW9LQzRkMUpZTW14bnZ0YldNdFJkemFKN29rb1RaZmZwNGpDbDhwMnRJ?=
 =?utf-8?B?ZitEYkZLbjZOZU5renExQXJxOS9vR2VJdHdSQkpJTU9ydGlrVC9KSDMxZU9G?=
 =?utf-8?B?cjkrWXgyWkRoV1NQejlDUS92VzZVU2dxVVEzdVRHd1FnK0lMMXFwMkxnVlFJ?=
 =?utf-8?B?dWxISC9EQThJK0EwbEFib2VzcXBRWFNyYTV0dWJrNVMrZE8rWTkzZ0xDUWli?=
 =?utf-8?B?SGJQWm1LTmtLcDZGODMzYXh5T3JsVkw1TFN0Ni9FYzN3ZnJqK1BLVDVZbHNa?=
 =?utf-8?B?Nmd1d09XOGtMTVAvNXpIbHNhemR2ZzFNRFF3SURaYVFMNU0rT0FKM0Ywdmow?=
 =?utf-8?B?OEwrSlRMVFc5cmVvNE13ek1tUUZsOU9UOVpsZ2MvSHRFL1VhODYxVzU3dnlh?=
 =?utf-8?B?Nm01Tk1UeFJqMnpkUDBtV0xENHNwN3VUaE83c1JlODR1clR5TnY3QlY1aEpa?=
 =?utf-8?B?RmVKRmlQNFMvbDdWOFA3Mk9WZHlHeGtKdklUOG90U05WSDJuWGR4Rzc4TW5y?=
 =?utf-8?B?cWhsWElhNW5pWmcwcjRMaXVUbEg3Wnk5dWhzNDdjMXFMU0ZmMElJQmI1aHIw?=
 =?utf-8?B?UHBXTFpnc05nbHJBM3cycGxYaitqOHlrb0lSeEtMa0RZdFZRcDNJWjNvVXQr?=
 =?utf-8?B?YnZsZkxyTHcyZVJjakpPN2lQZGw5R0JCK3NjZlhUVlVHNFBleklicW5JOVAx?=
 =?utf-8?B?Q2l1QkxZSHQraDRiVVNVd3lQdDViVCtJbzZZSnBzUHJva0RVTlpibEJWT0FR?=
 =?utf-8?B?L2JRNE1OMDBsbW1WZ0FTMW16T2w5bmRrd0hTUUNvMEhUeDducGhqNGt1TkpM?=
 =?utf-8?B?L2wyVHptenVKWjhlQXVUNC9qb08zTW96RWllcGtOR2JtVTlaSWFmUHpleHU4?=
 =?utf-8?B?TFM3TFBGNGtMa1BRb0U1Mnp2Z28rYnlKOERad3UyZis5K1dkMXhnRHNmUFRS?=
 =?utf-8?B?bHk5c1JqbGlSOUF5UVVBYnlhNVo5RmlYU1YzRE9yUnV4RUF5b2twZ1NONmUv?=
 =?utf-8?B?eCt1VUgwY1ByNndQNzJONDBKKzcvY2xwZTdyNDg0YXVXNjhIekdZM0ExNHVE?=
 =?utf-8?B?cUtqaS9MbWptcjcvZUpIdGFVN3VEWFhod2c2aC92U3hiMFgybVZ2VEJBclFa?=
 =?utf-8?Q?Z/NslohlkpV/uXk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A4DB38DB340234FB590FAEF16B2C516@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rR7pwCTFP2nuKiuDyJKgGVXSIEoJirOGFo6eRqmaeWQs0hVMwlFoT2MSWG3eLD2CFAJqc70G9fNWXKpRLsz9CTWwMc2MXP7MQTRxPe8UKJdhLxOFMg+FVNvTsDsPRKFt27jMxjsa7s+FHWZ/jIWVMfmegwG3oGkUV/m640T0iae93d4S7jL7g7Mo5Wd5aF2nXdwe/WSjuLC6htA6d1sNEsa43I0KFbL+aJrflsgPuz/LOPqPKp5V4XSqrfzqd7kt36/n6bg68oI34pn0kFBY3nXixD7kYE24TTa5Pypf8t5Zgzs+7YdEFCL63TxVLjCyXug7RA2ENZZS3cOG7jD02g==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db991c17-0039-4ca2-f002-08df34fd88a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 14:12:43.4011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2eVbcp7xutp+N8Ud79soRXRzF70CbKGdgbMy14B+EDu/RzoGSMd0wDoo9k/n8jLB1VAxnBf1f7R8eZDNh/4fGYYj3RjIlnwVkBXk/1+lRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR07MB948908
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost3.eviden.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQpPbiBXZWQsIDIwMjYtMTAtMjggYXQgMDk6NTEgLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRz
IG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2Vu
ZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIFdlZCwg
T2N0IDI4LCAyMDI2IGF0IDAxOjQwOjI0UE0gKzAwMDAsIENsw6ltZW50IE1BVEhJRVUtLURSSUYg
d3JvdGU6DQo+IA0KPiANCj4gPiBPbiBXZWQsIDIwMjYtMTAtMjggYXQgMDk6MTQgLTA0MDAsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gPiANCj4gPiA+IENhdXRpb246IEV4dGVybmFsIGVt
YWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMg
ZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZS4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiBNb24sIFNlcCAyMSwgMjAyNiBhdCAw
NTo1OToyM0FNICswMDAwLCBDbMOpbWVudCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPiA+ID4gDQo+
ID4gPiANCj4gPiA+ID4gVGhlIFNSLUlPViBQQ0llIGNhcGFiaWxpdHkgZXhwb3NlcyA2IHJlZ2lv
bnMgKG5vIFJPTSksIGVhY2ggd2l0aCBhDQo+ID4gPiA+IGRlZGljYXRlZCAzMi1iaXQgY29uZmln
dXJhdGlvbiBmaWVsZC4gRml4IHRoZSByZXNldCBsb29wIHRvIHdyaXRlDQo+ID4gPiA+IDMyIGJp
dHMgaW5zdGVhZCBvZiA2NCBiaXRzIGFuZCBzdG9wIGFmdGVyIFBDSV9TUklPVl9OVU1fQkFSUyBp
dGVyYXRpb25zLg0KPiA+ID4gPiANCj4gPiA+ID4gQXMgYSBzaWRlIGVmZmVjdCBvZiB0aGlzIGNo
YW5nZSwgdXBkYXRlIFBDSUVTcmlvdlBGOjp2Zl9iYXJfdHlwZQ0KPiA+ID4gPiB0byBtYXRjaCB0
aGUgbnVtYmVyIG9mIHJlZ2lvbnMgZXhwb3NlZCBieSBTUi1JT1YgYW5kIHJld29yayB0aGUNCj4g
PiA+ID4gYXNzb2NpYXRlZCBhc3NlcnQgc3RhdGVtZW50cy4NCj4gPiA+ID4gDQo+ID4gPiA+IEZp
eGVzOiBjOGJjNGRiNDAzZTEgKCJwY2llX3NyaW92OiBSZXNldCBTUi1JT1YgZXh0ZW5kZWQgY2Fw
YWJpbGl0eSIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8
W1tjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb21dKG1haWx0bzpjbGVtZW50Lm1hdGhpZXUt
LWRyaWZAYnVsbC5jb20pXShtYWlsdG86W2NsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbV0o
bWFpbHRvOmNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbSkpPg0KPiA+ID4gDQo+ID4gPiAN
Cj4gPiA+IA0KPiA+ID4gSSBxdWV1ZWQgYW5vdGhlciBwYXRjaCBmaXhpbmcgdGhpcywgeW91cnMg
d2lsbCBiZWNvbWUgYSBjbGVhbnVwLg0KPiA+ID4gT25jZSBteSBwdWxsIGlzIG1lcmdlZCwgcGxz
IHJlYmFzZSBhbmQgcmVwb3J0Lg0KPiA+ID4gDQo+ID4gPiBUaGFua3MhDQo+ID4gDQo+ID4gDQo+
ID4gSGkgTWljaGFlbCwNCj4gPiANCj4gPiBEbyB5b3Ugd2FudCB2ZXJzaW9uIHJlYmFzZWQgb24g
bWFzdGVyIG9yIGFub3RoZXIgcmVmPw0KPiA+IA0KPiA+IGNtZA0KPiANCj4gDQo+IHBjaSBicmFu
Y2ggaW4gbXkgdHJlZSB3aWxsIGRvDQoNCllvdSBhbHJlYWR5IHB1dCB0aGUgcGF0Y2ggaW4gdGhl
IGJyYW5jaC4NCg0KSSdtIG9rIHdpdGggdGhlIHJlbWFpbmluZyBjaGFuZ2VzIGlmIHdlIHVwZGF0
ZSB0aGUgY29tbWl0IG1lc3NhZ2UgdG86DQoNCmBgYA0KcGNpZV9zcmlvdjogUmV3b3JrIHRoZSBh
c3NlcnQgc3RhdGVtZW50cyBjaGVja2luZyByZWdpb24gbnVtYmVycyAgDQoNCnBjaWVfc3Jpb3Zf
cGZfaW5pdF92Zl9iYXI6IFBDSV9ST01fU0xPVCBpcyBhbHJlYWR5IG91dCBvZiB0aGUgU1ItSU9W
IHJlZ2lvbnMuICANCnBjaWVfc3Jpb3ZfcGZfaW5pdF9mcm9tX3VzZXJfY3JlYXRlZF92ZnM6IFJP
TSByZWdpb24gbXVzdCBuZXZlciBoYXZlIGEgbm9uLXplcm8gc2l6ZS4NCmBgYA0KDQo+IA0KPiAN
Cj4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoGh3L3Bj
aS9wY2llX3NyaW92LmPCoMKgwqDCoMKgwqDCoMKgIHwgOSArKysrKy0tLS0NCj4gPiA+ID4gwqBp
bmNsdWRlL2h3L3BjaS9wY2llX3NyaW92LmggfCAyICstDQo+ID4gPiA+IMKgMiBmaWxlcyBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvaHcvcGNpL3BjaWVfc3Jpb3YuYyBiL2h3L3BjaS9wY2llX3NyaW92LmMNCj4g
PiA+ID4gaW5kZXggYzQxYWM5NWJlZS4uZGY2MWYyODFlYSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
aHcvcGNpL3BjaWVfc3Jpb3YuYw0KPiA+ID4gPiArKysgYi9ody9wY2kvcGNpZV9zcmlvdi5jDQo+
ID4gPiA+IEBAIC0yMjksOCArMjI5LDcgQEAgdm9pZCBwY2llX3NyaW92X3BmX2luaXRfdmZfYmFy
KFBDSURldmljZSAqZGV2LCBpbnQgcmVnaW9uX251bSwNCj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDC
oMKgIGFzc2VydChzcmlvdl9jYXAgPiAwKTsNCj4gPiA+ID4gwqDCoMKgwqAgYXNzZXJ0KHJlZ2lv
bl9udW0gPj0gMCk7DQo+ID4gPiA+IC3CoMKgwqAgYXNzZXJ0KHJlZ2lvbl9udW0gPCBQQ0lfTlVN
X1JFR0lPTlMpOw0KPiA+ID4gPiAtwqDCoMKgIGFzc2VydChyZWdpb25fbnVtICE9IFBDSV9ST01f
U0xPVCk7DQo+ID4gPiA+ICvCoMKgwqAgYXNzZXJ0KHJlZ2lvbl9udW0gPCBQQ0lfU1JJT1ZfTlVN
X0JBUlMpOw0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgwqAgd21hc2sgPSB+KHNpemUgLSAxKTsN
Cj4gPiA+ID4gwqDCoMKgwqAgYWRkciA9IHNyaW92X2NhcCArIFBDSV9TUklPVl9CQVIgKyByZWdp
b25fbnVtICogNDsNCj4gPiA+ID4gQEAgLTM0NCw2ICszNDMsOCBAQCBpbnQxNl90IHBjaWVfc3Jp
b3ZfcGZfaW5pdF9mcm9tX3VzZXJfY3JlYXRlZF92ZnMoUENJRGV2aWNlICpkZXYsDQo+ID4gPiA+
IMKgwqDCoMKgIGRldi0+ZXhwLnNyaW92X3BmLnZmID0gdmZzOw0KPiA+ID4gPiDCoMKgwqDCoCBk
ZXYtPmV4cC5zcmlvdl9wZi52Zl91c2VyX2NyZWF0ZWQgPSB0cnVlOw0KPiA+ID4gPiANCj4gPiA+
ID4gK8KgwqDCoCBhc3NlcnQodmZzWzBdLT5pb19yZWdpb25zW1BDSV9ST01fU0xPVF0uc2l6ZSA9
PSAwKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgUENJX05V
TV9SRUdJT05TOyBpKyspIHsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCBQQ0lJT1JlZ2lvbiAq
cmVnaW9uID0gJnZmc1swXS0+aW9fcmVnaW9uc1tpXTsNCj4gPiA+ID4gDQo+ID4gPiA+IEBAIC00
NjMsOCArNDY0LDggQEAgdm9pZCBwY2llX3NyaW92X3BmX3Jlc2V0KFBDSURldmljZSAqZGV2KQ0K
PiA+ID4gPiDCoMKgwqDCoMKgICovDQo+ID4gPiA+IMKgwqDCoMKgIHBjaV9zZXRfd29yZChkZXYt
PmNvbmZpZyArIHNyaW92X2NhcCArIFBDSV9TUklPVl9TWVNfUEdTSVpFLCAweDEpOw0KPiA+ID4g
PiANCj4gPiA+ID4gLcKgwqDCoCBmb3IgKHVpbnQxNl90IGkgPSAwOyBpIDwgUENJX05VTV9SRUdJ
T05TOyBpKyspIHsNCj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgIHBjaV9zZXRfcXVhZChkZXYtPmNv
bmZpZyArIHNyaW92X2NhcCArIFBDSV9TUklPVl9CQVIgKyBpICogNCwNCj4gPiA+ID4gK8KgwqDC
oCBmb3IgKHVpbnQxNl90IGkgPSAwOyBpIDwgUENJX1NSSU9WX05VTV9CQVJTOyBpKyspIHsNCj4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgIHBjaV9zZXRfbG9uZyhkZXYtPmNvbmZpZyArIHNyaW92X2Nh
cCArIFBDSV9TUklPVl9CQVIgKyBpICogNCwNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldi0+ZXhwLnNyaW92X3BmLnZmX2Jhcl90eXBlW2ldKTsN
Cj4gPiA+ID4gwqDCoMKgwqAgfQ0KPiA+ID4gPiDCoH0NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvcGNpL3BjaWVfc3Jpb3YuaCBiL2luY2x1ZGUvaHcvcGNpL3BjaWVfc3Jpb3YuaA0K
PiA+ID4gPiBpbmRleCBiMGVhNmE2MmM3Li41ZjgxZTNiMWJiIDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9pbmNsdWRlL2h3L3BjaS9wY2llX3NyaW92LmgNCj4gPiA+ID4gKysrIGIvaW5jbHVkZS9ody9w
Y2kvcGNpZV9zcmlvdi5oDQo+ID4gPiA+IEBAIC0xNiw3ICsxNiw3IEBADQo+ID4gPiA+IMKgI2lu
Y2x1ZGUgImh3L3BjaS9wY2kuaCINCj4gPiA+ID4gDQo+ID4gPiA+IMKgdHlwZWRlZiBzdHJ1Y3Qg
UENJRVNyaW92UEYgew0KPiA+ID4gPiAtwqDCoMKgIHVpbnQ4X3QgdmZfYmFyX3R5cGVbUENJX05V
TV9SRUdJT05TXTvCoMKgIC8qIFN0b3JlIHR5cGUgZm9yIGVhY2ggVkYgYmFyICovDQo+ID4gPiA+
ICvCoMKgwqAgdWludDhfdCB2Zl9iYXJfdHlwZVtQQ0lfU1JJT1ZfTlVNX0JBUlNdO8KgwqAgLyog
U3RvcmUgdHlwZSBmb3IgZWFjaCBWRiBiYXIgKi8NCj4gPiA+ID4gwqDCoMKgwqAgUENJRGV2aWNl
ICoqdmY7wqDCoMKgwqAgLyogUG9pbnRlciB0byBhbiBhcnJheSBvZiBudW1fdmZzIFZGIGRldmlj
ZXMgKi8NCj4gPiA+ID4gwqDCoMKgwqAgYm9vbCB2Zl91c2VyX2NyZWF0ZWQ7IC8qIElmIFZGcyBh
cmUgY3JlYXRlZCBieSB1c2VyICovDQo+ID4gPiA+IMKgfSBQQ0lFU3Jpb3ZQRjsNCj4gPiA+ID4g
LS0NCj4gPiA+ID4gMi41NS4wDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4NCj4gDQo+IA==

