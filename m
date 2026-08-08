Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BAEC55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 16:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsjTd-0004um-Ap; Sat, 08 Aug 2026 12:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wsjT9-0004u3-PI
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 12:00:23 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wsjT7-0001nJ-7U
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 12:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1786204817; x=1817740817;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4aycTMFG/b5qu5BMyy1NvWBfnzJobyblbNLSlapuGCM=;
 b=izb08BAuQX6p1Nb8NZWXAn+RYeyRmmunxbk5cZGeCBI2rPNQt8XGe7d4
 JIezEFB2xSnTdxWQEQCpDXvBIDtxZOHa13CplaIPbcmF/ARRnC+FQ7Np7
 Qu0mxmabdlcR7Dn2w3iyWwUTP9NBGF2aVw2KeukRhjQ+HhzGQIDF+1XCw
 TfRd9QkAc8LAl40qa/HOfBoxroHOM+QcKY49A5mIdpJT5wbEraoDTZsCK
 yGs8d3I2jDhw8FSjBSozaTJtre1ls8YCEyGHaj5Q4JxXrz2h8vO0zHckH
 YrlxPI/a3gRcqWIBrNaY+RIiuxVres2mUk57ajv7P6YfC0IXSQhUV/nX9 Q==;
X-CSE-ConnectionGUID: 5NS7smRfSRiAMC8qmO56eA==
X-CSE-MsgGUID: C56g0qOtTrWxRR4Z02pulw==
IronPort-SDR: 6a77528a_4UH57K1brLjrh8NGO5QKfTQusGfd1iP3yzU8jSkWZPHlZ9j
 mej2astfH1EPrcnAuP2vaDI9BIVThLnqyJNbTCg==
X-IronPort-AV: E=Sophos;i="6.25,212,1779141600"; d="scan'208";a="48578611"
X-MGA-submission: =?us-ascii?q?MDFktgvtpwhAjbYL8XSUTtsODeY8GYpwiGDysO?=
 =?us-ascii?q?T370a1F3jTCXONM2z7Q543ksT4PMwykvQ1FAYRgP7c7MKS6ZSmbmWK9H?=
 =?us-ascii?q?Z7yZVL1AZ0Ml3AhKDZRaR/vg7GoiKiIJ+WH2M1/4pSed/H+jCBcBMXEk?=
 =?us-ascii?q?01J/F6cqZ7m0/xUQhlYmG0nA=3D=3D?=
Received: from mail-northeuropeazon11010051.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.51])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 08 Aug 2026 18:00:09 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWuXRh+Gz9y8c+VRdDvpkLsttsoR8YIHQ37zxMVkD8BwFwq38TILbCMIdrlK6GgZU3XDQFJUiBegRkaPNx5iEobbTCvv89oOV9bbp1TWncJ9Qaei7+u5KMUlzwlkj6NC+0ercmHdm8oVs7/P4RMJ84+SBiXsiR6iX1Mp2zY2pikzoM8QopKvHmTI9fiY4IFFwW68dsFStB/W9D+F6Y5WZGNnv1hc2wiHxGP8H+8RgMSssOrk5bg456Lfs5F0uguxAgCDtGJ2bSwEhzuhkFhxL+uTspwSTmfPkTnYYE6AEFENkxEVYz/NDK5uWk6Iy4berdlDFxvhhXYGtDAdzYnYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aycTMFG/b5qu5BMyy1NvWBfnzJobyblbNLSlapuGCM=;
 b=ISOfBpQJzimk+pyLRE52KDLTn3S5vcKcYXokA5hWvfjbDLjtm9MXt0FSKKlG63jQEPO1ggxxOH4xhWlT4297tkRdyqbe/7MLFfrlK0+ws8XtoV7ycgcsTMObda9E0DmkKrgWUtIn+UH+EYwp0iq40y9/rM8DKY748RMCclyZ2kA2zsKnMKVo2SBJXkKWpc1Y9b9GoqTILi6TsdtDxC3g8pQ30X2NyUwulQ29d4u8fUGLBuBXQtcMER8zMooB9rRXrPPKmLaBHPEXh6EaDCUrUUYtqxX2QfFeXY1VR6Gp0x44zG53ZF7W/wG6Qcbq5ReUhw5XxlSuUwJ5lyBf6j+pTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB9870.eurprd07.prod.outlook.com (2603:10a6:150:11d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.10; Sat, 8 Aug
 2026 16:00:01 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0315.008; Sat, 8 Aug 2026
 16:00:01 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Topic: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Index: AQHdJXaknO6gra3UQkST2flmIiB+OLaUUwKA
Date: Sat, 8 Aug 2026 16:00:01 +0000
Message-ID: <45013c8a3fe7983ee31f52d9d9ba6c176ce98fdb.camel@bull.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
In-Reply-To: <20260806073825.363468-1-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB9870:EE_
x-ms-office365-filtering-correlation-id: cb9c002a-b705-4975-7051-08def5661abf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003|38070700021|13003099007;
x-microsoft-antispam-message-info: nTzW89l85BSEqnJYuAu9Df1LoXPI5Vogz5yzp6LoeMHDg0Nyx+FiqVhw1EhPJNBFU14Wi8/aUg/Fp95vAON4DD0wuc6QZ7Q+9TPgu0idK1ELerWyOwe1w+IPgHRZYBLEXgxvvfMVWyM3y6dr/h11Q0SvKcWYg98H9vTAq7GF4yKPyFNNSCkis17r7/b9epioRVhNCPMvVJiTT5yniQQx0nC74DneFDUHooeTJCzRYijh7PCWpEaJ9xxl6T4zWNArBVTKjnRkgvG+TQlX0fsFC0cxZcdPlb6ZuywmftxIZTdvkoli5qAeLv1GRlAUivA20RZcclxLsu1olFDpNpD0coGdzkcETxjzVvi9/KmtwVNxUvygyduwEna79xZo2hAyRf8qDdbGTjNMLZJ5X4h5rXV1fgLOAcEtO+bcomkZUP6ODSH/UGqXxGA2nQO97GML3rfu7LbbcogSxqWgx8bm1sokNZpwemYDFyN7rG6qtR1yTrxm6w4k3Ae50nQRStYrdL3K/zdqUYPYRxhhNHmwBvqgQK83Pb94nv46t7qLkVGsu63L8J4MERdc7NiaHCuFnUtyAED1sZ5siBmc2VdZ2/aP+gPNVobj4YXMid7B7ZOjE+tMFx/ftFSAYSG6SQo2tKr6qixhxzfLyfBQgLCp4LgdeFmDELXQaT7C0BBIsMr82nj54y8pbfQdBmowd1aJKzACne4csWqKFshHHtXTJLElpl1C5PEPcZVyVTGi4WQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEZCNkZMd2ZFLzRKZVdrbFAxa2FNWVl6Nm1zMzFVdjNpU08yWVRoTTFxUHZP?=
 =?utf-8?B?bmM4bmluRk5EUkVMb0hyZUNYbW9sZmhSbzA0VWRGTUNpSUIwdk9TR1dOU205?=
 =?utf-8?B?TFFiR1FuVGlHQ3FNV2FITFFZNmtDUnM2eG1SUDYrZXliNVRQdDd5U245dnFT?=
 =?utf-8?B?dWNuVlI1Uzd4OHdFOHFIbjFzSmJubXR4V2NGV3dnTGdKUkZrVnhWZW10bXhi?=
 =?utf-8?B?ZEZSQ2lXQnVFZVgwa3RjUStjY0JoZXhhT2pxeUQyU0JUb1g3MTg4dmhkTjgy?=
 =?utf-8?B?dXJyNEJxazZhamxidXBkdDNjdUpwMnZNdXdNVW1pZk5pMEpPRkNHNXNWQmp2?=
 =?utf-8?B?R0NVSENUcG42a3VndGJyOE9ydzNYUFRrU2lzODNvQVNuWElDR1lRZzZibmU0?=
 =?utf-8?B?R1VVZlRlaU5qanNwSnFmaXJYekx4UkN6MGQ2UFJWUkxSWWFjZkx3UEFYc0Ex?=
 =?utf-8?B?eEZ3ekJhZy83cmdRTlNRY2w0TitQeXY2aERtWERyVUhwUTA2MlRXTG9EMExZ?=
 =?utf-8?B?TCtabWllRUVtOU55OVRsaEcwV0E5bjlueWx4VFZRQzNzbk51WldhMmxGRFdx?=
 =?utf-8?B?NzRYaWhKQVFJRXVSNXJEclU2aU5xc2tyYzZ2eGNvd2lJeERibWRySjYzdjBR?=
 =?utf-8?B?MkJ0RXYxbW9wNW1HT3UvZ3BvMm1XRHRaMWJPeG4xTTFKRjBmSDZxTkZxWFRV?=
 =?utf-8?B?R3NuU0pHdTA3Y3g0NWRKYkRWTjRDK1pFUUJ3T1U1dk1qdE5ZUFFVNk5qRTdN?=
 =?utf-8?B?RjJQdVRBN25WcWJoUDgwN3MvNjZxdUJNVGIwMWdLbXo1dlkxUDdBVjE4Z1VQ?=
 =?utf-8?B?QndRRHNRZmZCcnY2VGVqL08vRTBtOHB1K3lwbjJqeFB4dGQvTkhNeUZ6VWNB?=
 =?utf-8?B?a3BPQTBPQVo4Mnl6UW13WnNpS0Rsb2MvWWlIUk1ZaUZKMTQyYTdGam1RN2Fn?=
 =?utf-8?B?QjRKSmtXZUl4SVUrcVRJRXhXSnNQcEt5YWtwTHQwNjFOTEdhdG5nclk0Wkti?=
 =?utf-8?B?YXp3SFpKczdId0F3bm9WNHNPWWJYZzhJdjZud1BLbW9uK2szQ2k5NDJGWXk5?=
 =?utf-8?B?eUJKSlVGQXh0NUpQM1FjR2JsUldab3NibUErWjBOUjdrRCtzdG1rWlc1S1Yr?=
 =?utf-8?B?WWdVVnFYdGJBZGEwMW5sMVd4NkRhR3F3NUU1MkFGRHFIMFh4ZnFaa09rVm9N?=
 =?utf-8?B?YXV3QjBDUEZRSnNxL2tRQ2p6c0Y3cFBMbjRBeTh1ZG1QRC9RREJJY2JQT1c5?=
 =?utf-8?B?L0hnekZxMWhLUzFJMDVvYVY4UkhxcnpxMzFVZ3FDUU5qQklXekRvWGVqTnRo?=
 =?utf-8?B?bEhTdmtFckhpRjR4bG9JRmpqV3pMVE1KMUpOQ2Uyang3VjBYdnVlMUR1WXND?=
 =?utf-8?B?a29KKzNobkp0YjgzaGhhWm5EcjhBa0RYWk04RjhmbXg1OXNQVlNwUVhFNU5u?=
 =?utf-8?B?VXoxcDVvRWdGUU5kNTJWV05wRTBmeFQrdnRlQ05SLzNpa2lWc0VsOU9XbVU4?=
 =?utf-8?B?MVlNSUFqTVdGbkpZOWtvaGZ4eURXWUdYQ2xISGNjMGdUSm9wT2dKZXFUK2RO?=
 =?utf-8?B?cW4vNE1rRFVyZU84QllCVkJmZmp0Mks5WUpjWk4wZXBYOWUydHc2WWJ2VDZH?=
 =?utf-8?B?UjNiVjJHVWNzb09oazJ6aHR3QkMxUC9VRUczUGRGL3BMSHJIYmtiUmFCc05u?=
 =?utf-8?B?bkJWRjFRN3dqZXNOSUdDaU5IMThoZmRRQWUzak53M2VMdjV2SzlLdDhXQUFh?=
 =?utf-8?B?MEpCaEo1MFFZNUEvR3k2RzRIZktsSUlxL3hDaWxFZVMzWmxySE1tOVpUYlFG?=
 =?utf-8?B?Zm1aSmlwdFRDOWFRRnJzbFIzdjB6V09mRUJOZmo4Vnd1b2xWT2JhWkRvcEp3?=
 =?utf-8?B?b0xhSmN0OGZ3Yy9mMDBKN2VMelZZMjZ4UjZuMjFHOHR6c3ZWNmRtUUJJVFJW?=
 =?utf-8?B?U3k0T2JWMlB2YlY4bWFESGpoUGZncjhGUitUSE95OE5yY045MndVUVFLZDRX?=
 =?utf-8?B?eGlvTmFzN1pjRTgwNTMyVWpkd0dOSitoekJFRVZLODdITTl4U3FGaisrMEdw?=
 =?utf-8?B?WkFWK2lxMm93T3ozTGlSZ2RWL1Y3WGg1WjgzQXN5ajk3bTJhK2pEdzRiQUlL?=
 =?utf-8?B?aktndTgwM0RQZ1lNdkEzWm1OY0pJeGQvL3dHMlNYQ3ppVGhmYjZiNC8veHJn?=
 =?utf-8?B?Rml1Ui8rSTJ2UmZBU010QlFnZFVRaW9GVlluZ01qZWt1TGpQUTAxdW9qNG5K?=
 =?utf-8?B?NGlPWmFpVG5INDl1Y0VvdHh6L3Boa0w3QWIzRTlwRkNidXZQVTB5TjVHMlg1?=
 =?utf-8?B?d1dmcXZuYjFSVWU5bVVTQUptRWNoTWx4bTJEcTgzMEJPSVRxTlQ0dnh1MkZz?=
 =?utf-8?Q?Yu1laKvhDQ6b1Go4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <588F87B396A98F489F35D7A20D4F8A9F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c6xUALlepesHadDZ+Yvgsfmy45yR9cE0/62WcQLwaWiOr+w4Kacsk58hOzW4RvBznVwOrtRpS3tPQfiPMJbBQ+FMJtkwD6+sFEXSuToqrMVTIfiRLgRreLOcF9ngBdWFdIU1BT5L3/ldw6hW+emZAMAYErRm7BDBdS+9Pxad+hI6cKEIL8PGk38Ck9cetTRjOgDCkfZHsVXx+e9HkIxE0QUY++R8Iyqa+xTrVVk3BJHkxSr0tUOTOT0e35ibGzjgx08xDQlk749eiMDQhy/GfSac8sxGQ3p406QU05pXv4yWwWyb8m2bUiBrDDRN4NVh8ONxs3FkoKHiG4+2teWiow==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9c002a-b705-4975-7051-08def5661abf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2026 16:00:01.7083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RD7fgpb4HQt6P9wgPO1AnvgXRkCpVpN3BFAtbvmJyuiKjxUbshiDEn9vGo7w6umJVs9q3IjovubapdF5siZfpS6WwoUefR2E1YkUWe+7Utc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9870
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgWmhlbnpob25nLA0KDQpJIHdpbGwgcmVhZCB0aGlzIHNlcmllcyBlYXJseSBuZXh0IHdlZWsu
DQp0aGFua3MgZm9yIHRoZSByZXNwaW4hDQoNCmJ0dywgcmVsYXRlZCB0byB0aGlzIHdvcms6IGhh
dmUgZXZlciBzZWVuDQp2ZmlvX2RldmljZV9nZXRfYXdfYml0cyByZXR1cm5pbmcgNDcgd2hlcmVh
cw0KdGhlIGlvbW11IHN1cHBvcnRzIDQ4PyBUaGlzIGxlYWRzIHRoZSBmb2xsb3dpbmcNCmF3IHRl
c3QgdG8gZmFpbDoNCg0KYGBgDQpyZXQgPSBoaW9kYy0+Z2V0X2NhcChoaW9kLCBIT1NUX0lPTU1V
X0RFVklDRV9DQVBfQVdfQklUUywgZXJycCk7DQppZiAocmV0IDwgMCkgew0KICAgIHJldHVybiBm
YWxzZTsNCn0NCmlmIChzLT5hd19iaXRzID4gcmV0KSB7DQogICAgZXJyb3Jfc2V0ZyhlcnJwLCAi
YXctYml0cyAlZCA+IGhvc3QgYXctYml0cyAlZCIsIHMtPmF3X2JpdHMsIHJldCk7DQogICAgcmV0
dXJuIGZhbHNlOw0KfQ0KYGBgDQoNCkkgZ290IHRoaXMgd2hlbiB0cnlpbmcgdG8gbmVzdCBWTXMu
DQoNCk9uIFRodSwgMjAyNi0wOC0wNiBhdCAwMzozOCAtMDQwMCwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBv
ciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRl
ciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBIaSwNCj4gDQo+
IFdoZW4gc3ZtPW9uLHBhc2lkLWJpdHM9Tixmc3RzPW9uIGlzIGNvbmZpZ3VyZWQgZm9yIHZpcnR1
YWwgdnRkLCB3ZSBlbmFibGUgIA0KPiBndWVzdCdzIHN1cHBvcnQgZm9yIHZTVk0uIEluIHRoaXMg
Y2FzZSwgdGhlIGhvc3QgVlREIG1heSBnZW5lcmF0ZSAgDQo+IHJlY292ZXJhYmxlIGZpcnN0IHN0
YWdlIHBhZ2UgZmF1bHQgZXZlbnQsIFFFTVUgcmVhZCB0aGUgZXZlbnQgYW5kIGluamVjdCAgDQo+
IGl0IHRvIGd1ZXN0Lg0KPiANCj4gQWZ0ZXIgZ3Vlc3QgaGFuZGxlcyB0aGUgZXZlbnQsIGl0IHNl
bmRzIGEgcGFnZSBncm91cCByZXNwb25zZSwgUUVNVSBnZXRzICANCj4gdGhlIHJlc3BvbnNlIGFu
ZCBwYXNzIGl0IHRvIGhvc3QgVlRELg0KPiANCj4gVGhpcyBzZXJpZXMgYWRkcyBRRU1VIHN1cHBv
cnQgZm9yIHJlY2VpdmluZyBzdWNoIGhvc3QgZXZlbnRzIHRocm91Z2ggdGhlICANCj4gRkFVTFRR
IGludGVyZmFjZSBhbmQgcHJvcGFnYXRpbmcgdGhlbSB0byB0aGUgZ3Vlc3QsIHRoZW4gY2F0Y2hp
bmcgZ3Vlc3QncyAgDQo+IHJlc3BvbnNlcyBhbmQgcHJvcGFnYXRpbmcgdGhlbSB0byBob3N0Lg0K
PiANCj4gR0lUIGJyYW5jaDogW2h0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS90cmVl
L3poZW56aG9uZy9pb21tdWZkX3BycS52M10oaHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9x
ZW11L3RyZWUvemhlbnpob25nL2lvbW11ZmRfcHJxLnYzKQ0KPiANCj4gVGVzdHM6ICANCj4gVGVz
dGVkIHdpdGggRFNBIHdxIGF0dGFjaGVkIHRvIGFuIHVzZXIgYXBwIHdoaWNoIHRyaWdnZXJzIElP
IHBhZ2UgZmF1bHQgb24gIA0KPiBwcm9jZXNzIHBhZ2UgdGFibGUgZHVyZ2luZyBETUEuDQo+IA0K
PiBUaGFua3MgIA0KPiBaaGVuemhvbmcNCj4gDQo+IENoYW5nZWxvZzogIA0KPiB2MzogIA0KPiAt
IGNvbnZlcnQgdG8gUENJIHBhc2lkIGJlZm9yZSBwYXNzaW5nIHRvIHZ0ZF9wcmlfcmVxdWVzdF9w
YWdlIChDbGVtZW50KSAgDQo+IC0gZXhwb3NlIHZ0ZF9wcmlfcmVxdWVzdF9wYWdlIGFuZCBkcm9w
IGFjY2VsX29wcyBwb2ludGVyIChDbGVtZW50KSAgDQo+IC0gYWRkIGEgY2xlYW51cCBwYXRjaCAi
aW50ZWxfaW9tbXVfYWNjZWw6IEd1YXJkIFZUREFjY2VsUEFTSURDYWNoZUVudHJ5IGRlZmluaXRp
b24iIChQaGlsaXBwZSkNCj4gDQo+IHYyOiAgDQo+IC0gZGVmaW5lIGZhdWx0X2ZkIGludCB0eXBl
IChMaXV5aSkgIA0KPiAtIHVwZGF0ZSBjb21tZW50cyBvbiBGQVVMVFFfQlVGX1NJWkUgKExpdXlp
KSAgDQo+IC0gZHJvcCBwYXJhbSB2dGRfaGlvZCBpbiB2dGRfZGVzdHJveV9vbGRfZnNfZmF1bHRx
KCkgKExpdXlpKSAgDQo+IC0gcy92dGRfcHJvcGFnYXRlX3BhZ2VfZ3JvdXBfcmVzcG9uc2VfYWNj
ZWwvdnRkX2FjY2VsX3Byb3BhZ2F0ZV9wYWdlX2dyb3VwX3Jlc3BvbnNlIChMaXV5aSkgIA0KPiAt
IGNhbGwgdnRkX3BycV9yZXNwb25zZV9ub3RpZnkoKSBkaXJlY3RseSBpbnN0ZWFkIG9mIHRocm91
Z2ggcHJpX25vdGlmaWVyIChMaXV5aSkgIA0KPiAtIHJlcGxhY2UgImZhdWx0X2lkICE9IDAiIGNo
ZWNrIHdpdGggImZhdWx0X2ZkIDwgMCIgY2hlY2sgKExpdXlpKQ0KPiANCj4gDQo+IFpoZW56aG9u
ZyBEdWFuICg2KTogIA0KPiDCoCBpbnRlbF9pb21tdV9hY2NlbDogR3VhcmQgVlREQWNjZWxQQVNJ
RENhY2hlRW50cnkgZGVmaW5pdGlvbiAgDQo+IMKgIGJhY2tlbmRzL2lvbW11ZmQ6IEludHJvZHVj
ZSBpb21tdWZkX2JhY2tlbmRfYWxsb2NfZmF1bHRxICANCj4gwqAgYmFja2VuZHMvaW9tbXVmZDog
RXh0ZW5kIGlvbW11ZmRfYmFja2VuZF9hbGxvY19od3B0KCkgd2l0aCBmYXVsdF9pZCAgDQo+IMKg
IGludGVsX2lvbW11X2FjY2VsOiBBZGQgUFJRIGluamVjdGlvbiBmb3IgcGFzc3Rocm91Z2ggZGV2
aWNlICANCj4gwqAgaW50ZWxfaW9tbXVfYWNjZWw6IEFjY2VwdCBQUlEgcmVzcG9uc2UgZm9yIHBh
c3N0aHJvdWdoIGRldmljZSAgDQo+IMKgIGludGVsX2lvbW11X2FjY2VsOiB0ZWFyZG93biBGQVVM
VFEgcmVzb3VyY2VzIGluIGJvdHRvbSBoYWxmDQo+IA0KPiDCoGh3L2kzODYvaW50ZWxfaW9tbXVf
YWNjZWwuaMKgwqDCoCB8wqAgMTYgKystICANCj4gwqBody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmggfMKgwqAgMyArICANCj4gwqBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaMKgIHzC
oMKgIDYgKyAgDQo+IMKgaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5owqDCoMKgwqDCoMKgIHzCoMKg
IDcgKy0gIA0KPiDCoGJhY2tlbmRzL2lvbW11ZmQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMjggKysrLSAgDQo+IMKgaHcvYXJtL3NtbXV2My1hY2NlbC5jwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDYgKy0gIA0KPiDCoGh3L2kzODYvaW50ZWxfaW9tbXUuY8KgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMTEgKy0gIA0KPiDCoGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuY8KgwqDCoCB8IDI0
NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0gIA0KPiDCoGh3L3ZmaW8vaW9tbXVm
ZC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArLSAgDQo+IMKgYmFja2VuZHMv
dHJhY2UtZXZlbnRzwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMgKy0gIA0KPiDCoGh3L2kzODYv
dHJhY2UtZXZlbnRzwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArICANCj4gwqAxMSBmaWxl
cyBjaGFuZ2VkLCAzMDggaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+IA0KPiAtLSAg
DQo+IDIuNTIuMA0KPiA=

