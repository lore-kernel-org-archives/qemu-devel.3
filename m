Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DFEC369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 12:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA6sC-0000r5-0w; Wed, 30 Apr 2025 08:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uA6rW-0000VH-Re
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:48:34 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uA6rQ-0002Nn-06
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1746017304; x=1777553304;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6GzCkPGz3qZyB85kWpsgOxyktUCOKP6cPgZg7130sMw=;
 b=E34M01uXTTT/jsO59ZfT0offutvXnDl3Fcn+MCvqd6uituXHL++nJMvp
 v1RjeH1i51EXrYkLkpDROCRVCoUwFtAgYmci0HWqMpOoz848ihdeerJt1
 vQcSDwk84bTTdTgNt9WpGDvnwd9xo1zIL7pNvqNBslfZJ7pmn0IVXCiil
 gXEBu8iIiQPFnSIfVXm+unK8wcdz6m7GSBBO0OVEFcC+3qF4HD0zqQXSG
 t5dRNJu2OLOwcc/VkpQs/y2VIj4RbQ3Nz/9ab/shNIEm60A9y17cLYpfg
 clEY/XKcPzA75iVGh24X6ZDrGTQ5YZzxdYFfYQBEB0oEwkP4tX5qF3gcO g==;
X-CSE-ConnectionGUID: 9q+EP0SPTVOS1lDFDmFQ4Q==
X-CSE-MsgGUID: fYeFRPPFSrOxpIllwnIWlA==
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; d="scan'208";a="36004701"
X-MGA-submission: =?us-ascii?q?MDHHiwRJ3Xiof7bNRfgZD73bVB4yX5cHD+6hlL?=
 =?us-ascii?q?SCbLKNfYsA8xyVeXMGuaeEzQIGcsESpS4+ErDiGjs0jMcVasNs2zb8jc?=
 =?us-ascii?q?N9eq7lHEajQBvsNua5cotD2Y2YuL53A1eiC7DBpagtX63Uoi3gJ5UJnz?=
 =?us-ascii?q?+sNMKxa7Wg06v0LGIiBLTNow=3D=3D?=
Received: from mail-francecentralazlp17013075.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.93.76.75])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 30 Apr 2025 14:48:09 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdyakS7d+1YLZEZb0Q6ThSYxk5HkCwxwmUNNlIZiYBgyoErBHCOkd4+FHoddtXZAreWaVF7Sshdt0dK8f6S1ZDvrwg4XzNQGBA9zmft3zofNt2B4sLNs146gNlbSBK4a4adh4QfemrjjBYyKIeZAgIdPWfQ6h3Lx3KH+H7bqDND0JYoZxldIlVeZ9vGyAjeRWTAQ0yhxtTkdHZGFgizotrQKPw7CzWy/qNsRu2A00F43YSe8Ef0xmjB+0r5i+70FfqIwv4/cLCtmj4hzZZncs8+E+PcNF4HT7M7CMCiE9Hs4MF1Af8uccFWO5QvvSavXOUnhnckaFV4ziAB/WJXz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlLaU8pWhsG9PBcIdEeSqG3Ebn1YDFL5gVcqqFfkokU=;
 b=nSvbZC+Vn8yxUUPFf9IIdbg0/SY7yo2rnABdwfDs0ahKc3IbN3SWr0dFNEUi2HC2Yu2xLBCVV5QYhkepivzMXL1ViMLu0yWEkyurwKuqFF7vS+IE01FB1pEgvZt/GEY1lLKS+xJVtc9rL55lPYeCXftU4eYmwj4aCwak4UbxJ71ddjwCuG5jkbi2ElCwqpI2fHOpf1Pk6X6+n5y0ZVcApbgdwkHZBxHtjZGPmXhVOhRsj9t94fTelHmjHUDOYzagW+rRWgK5/JytgHqqfhgzPEM8Nanuiyl+30+ERc/xD7ISYroJ3c8hsI8X5EziBtYDQnGpIU1AJOMsX/H5B0XQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlLaU8pWhsG9PBcIdEeSqG3Ebn1YDFL5gVcqqFfkokU=;
 b=G3h0GOJrOsJk6DXZ1yrcJojl8LEVXZADIev3QPeL5CJpe3a1Qnx/QpZVCA7Q2XwWaEgZIf4B+KP5iwaN1oCXSOr7xTgrkjYG3YsFBQTJ0fL0N66DZdgqEg6xj31PCz7r6aGCkG2Bf3gPq/UGapztOp7+ljzRuLDhb6FihtRoHajymH1ZpJqjft1CZtkUkgbBpc3lMXnjMKpU39g5NpC6N7l8bYtGVvFWSG1/PvSSSJLzqUPuH/AHXbn2o/h5YA3td5UigjeLAYsi8weSitmdIaTJAbXuVxnWF56fxw7yHUGGG7WdFMP/1PZGa69oPZkSV45/CdpYZtseqtLBPaigMg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8449.eurprd07.prod.outlook.com (2603:10a6:10:36f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 12:48:07 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 12:48:07 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v5 2/2] intel_iommu: Take locks when looking for and creating
 address spaces
Thread-Topic: [PATCH v5 2/2] intel_iommu: Take locks when looking for and
 creating address spaces
Thread-Index: AQHbuc4evQOtS13aikapWML85jpsJw==
Date: Wed, 30 Apr 2025 12:48:06 +0000
Message-ID: <20250430124750.240412-3-clement.mathieu--drif@eviden.com>
References: <20250430124750.240412-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250430124750.240412-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8449:EE_
x-ms-office365-filtering-correlation-id: 3d4598c9-a4d7-401b-40a8-08dd87e54155
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XFPde1TxSboWgXA59VhHTJXk14OyjRU+nBNLD0hyIdfiKqxda1A1zKpGQb?=
 =?iso-8859-1?Q?Q24kF2LfWpU3byMtMH28g0jiT2oWKIgSwViZLJGGfGlAQuqJVsj+nS6X8m?=
 =?iso-8859-1?Q?0l6bKjt9e9BwPaFd5GnsBoPf1K7D9e7SRNt5h3nB1xw83CppWCekLWV70F?=
 =?iso-8859-1?Q?x3FEMQ1wkHNO510O/Rtgpo8BQiMcjEcXJTbZv8wWmRtj3WjcbWhlHqjsgT?=
 =?iso-8859-1?Q?gyAc9Dko16oL/XcbUy0gRantoftLFwYjcy1104GRFGmitnDvrmMJOR9Sjs?=
 =?iso-8859-1?Q?BJ2RmKopciaW7aLy14IAt1ZdSR4SP2WJ8I6niCo/YCzsKA40Kpu1weoUzd?=
 =?iso-8859-1?Q?V2i2725Z2I4+N8GD6VnIDyzxRita3mn2DYmhzLUJVFL7FRVfmUNy0EHyJ/?=
 =?iso-8859-1?Q?mLAG67qOBszV0wgMeHu9p2nz2uleNuwJfK8FTdKSEVbrJIJo6xDpMVbZZU?=
 =?iso-8859-1?Q?nMFrfdRnN8jiIUAVUmxm6OCILDh0YXVxabFVY+8i9LE6eWTpfK1YeV5Acj?=
 =?iso-8859-1?Q?U0bV+Hnxsgw3zNyEuR9c6Q940gZCyO09+zqvUyo9hxrRCFbtcwb9Brv+5L?=
 =?iso-8859-1?Q?N0SY8SbSrpKRtsQxpZoxp7e8GxN6/jpukym3KtSIYOP4rFKYPwq4ZGuU57?=
 =?iso-8859-1?Q?WA7kRo22STQiW6xEP2UPM2dxo1NuhMgYgfqnsyYfdTLy3qt/9Alj1uF750?=
 =?iso-8859-1?Q?w6ivyd3uZXYke+OvkoPYd55KHoQnTu6SSnSCiFkcES2kUDPNSisAcaLkjZ?=
 =?iso-8859-1?Q?QOUUE/TXSZUdiNFWKj3OzxXR5l/FtM9arm7h9sorbwTAWIfwKMpivM4+cH?=
 =?iso-8859-1?Q?b06ehPXIgffsV7NKO/8l3D2WaLpslT9ysItrLIc37EqGxqQmhDgRCPLbLl?=
 =?iso-8859-1?Q?VtuJDPBkhp6L31gQdPrIdsfX304+QbIrr3TCKgqQfFfz6evUPuhoQ476Ju?=
 =?iso-8859-1?Q?34DYydnXhcVYJq9/95sMFNOJsWPfaODWSEjQ8ftn5GOOiur4CrYpg6q+4a?=
 =?iso-8859-1?Q?o5SaMhE+2jFCmvD8LjwremO1Y6TJl3K3sqvEDD4p8ihyPi6gDj+8XBrB1F?=
 =?iso-8859-1?Q?JOdeiH3Uu3yqmZgK2Ybu2NVx6dK4/R4KyQyPAhkYCvgP69mVHHhr1ydxSH?=
 =?iso-8859-1?Q?iR+9cq0eRIqDK6BnoO/jab9TIlSpOijJLrg2su4fqx2sWa77Wom36vR3Tf?=
 =?iso-8859-1?Q?0WasrKHt+eWx+hb6APgsvXEjMS1cINbMipW59kKjhb849e3VxyltPkLMnZ?=
 =?iso-8859-1?Q?w9zYrC1BXl4p4kBQ+jRBS1uW0jt1ZBj29/KgwsftY6MWdpSC0v9o3fKVBj?=
 =?iso-8859-1?Q?cyHo+c25c6juJGmzmxE1yjJx48/G5pmpYituwAo/7pe9bW6ZDvy4anDRrD?=
 =?iso-8859-1?Q?enDdrWLyLAWs3WUV15fYs/CSvUvJiL5vZP3wnUR9pBPC85U9CP9CqyqgYz?=
 =?iso-8859-1?Q?oawQ4i7fAN7aGiOdd+ZHOWpA9WNkqw6PoYx8XCsP8PF4v0f4mu0c5jO85v?=
 =?iso-8859-1?Q?DSOMb9wdwsB7rt/5nZXLwEKYTGZRvGEPE3auk8071zYQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jVeHWbtpEacaKVA5y47nk64N9TRLure/RYgP8LaamSEY0a4F18JMiGvPO+?=
 =?iso-8859-1?Q?ur5GlUa1rfwl5CXcLA/yspWN0l8HyTvqwf2CEHO/VMj7iqMnBcbFDOU6iX?=
 =?iso-8859-1?Q?LGZuwILv7RYkGQ10uuzgi8oF+t8aEEBS7FSlOvNXoDjLrN8OLObUotN+v4?=
 =?iso-8859-1?Q?yvrXaJ3GA5Q3dvayL4VQIndY8zb0ygLrC1sfKP9AQRS9kY7TjmvBvxKZ4b?=
 =?iso-8859-1?Q?Wv7XvTKMyONLws1ZLI6JNqFE4Z2ujqLQlFkAJy51d58JOD+n9BQJ2+HCB+?=
 =?iso-8859-1?Q?AWwFQyrbrp1qAeeuqTYoNSCYYpJITz4EBliic5CR1yu7QykwdnGeA20DLU?=
 =?iso-8859-1?Q?H0HabYgYLRmj4yrMfjiFPCYbIU1fPCGjY5ZR0Hwd3smHxgmMXlyqXW+ndd?=
 =?iso-8859-1?Q?CBm1zdD9hai9uSZFBYQRGYwjxMXq6EFg6mLG171NCs7mqBctWK7anLK2P6?=
 =?iso-8859-1?Q?O7YxCJq5tHahc0Ygkc1y2NW7Gj8mMFgTpv9wk2Z6aqi+J3QAmUslC//hI0?=
 =?iso-8859-1?Q?qBzwGLdkQibT9VF/OwABGj4PK6fBc8MEENkn2xiav04wGYNTRstZUmUUhl?=
 =?iso-8859-1?Q?NYZbVsfferC66YiEYmjMR+hYmJ6bS/sGwIbsKBVcnh4E0dR/AXb0+HKDXX?=
 =?iso-8859-1?Q?oeTlr6uwlQoZeWpsQTjdUftSnlAYmU/9cKEve82Wpop9Y9F4AwtPyQyo79?=
 =?iso-8859-1?Q?pNdprSb9VrdiNryxPcnDu/c6otBs/6AMlpyZqiJsE5npwFB8aAT1x3uOfn?=
 =?iso-8859-1?Q?+tQnxbmfCw/MuvAgpaK9KYHsflHG9tgzWcS9Mi1vbJYjodEiCORfqi8/UV?=
 =?iso-8859-1?Q?Jb5LwcjCEjwX+7SA4DNGgKTgKjw+GyIu1bT5ZNsG0hXDDb02ZrB8tB1HZJ?=
 =?iso-8859-1?Q?/aHdGD3zysdNUxGs4zzU4rUs0irpwJTsyTd3l7li2AxhFQso48vOihz8H/?=
 =?iso-8859-1?Q?sbU9k2m7SmgotOnmyd/eSoxx3pzYw1TL0J09Ww4X5gFYjXFZLNpz5tu7tP?=
 =?iso-8859-1?Q?I80UAOEu+5NrfSxzXxmUOs8SPe6zkiOQoNmvLLYCfB03ehGFft2cBYGgWq?=
 =?iso-8859-1?Q?SwD3pNKkaFpWqyWy+zh25YJhnoBr8K1XaW20Ijn6TxcfTr5Y5dAs1YaRd9?=
 =?iso-8859-1?Q?28a8t/1FscSt+5HltrVg092QADE/JVbIpKsSmbRs6wFXJTPhlhaUYrzSLq?=
 =?iso-8859-1?Q?PUJLhViky7tVU4wA6LsIhUaButWby97tpBdqCZ/Ja0zA9396/3sMBaPahh?=
 =?iso-8859-1?Q?q61yro3tfFPTK85IO2LEzG3V6Q1kPqjS81Rt/kqh01BL3O11Zt859pzb/7?=
 =?iso-8859-1?Q?WWyijECMYpuxOniqGNEral/afqZSa2zdbqP40fvvpuEgUC3MY6zoW7KPXb?=
 =?iso-8859-1?Q?SdKN+lA2QqrWlA+p3exctAopnqjZbqlRfQ3G3id+xyU//RND4bdHhPOi+i?=
 =?iso-8859-1?Q?pMKON+rVWl/o4KTzpxy2gxO7KBfP6ISMe9qEJdInenMKIN1yMkUYy6Q1JA?=
 =?iso-8859-1?Q?nyWyPu1Cp+hb9dtfKx8SDQKrVO2/MF/tuRVhBJsmcoukXudBfOCDQ+usgL?=
 =?iso-8859-1?Q?LGiqNVtFnVb5abMk3SiNwW5DjnDaK3kFVnvjEDZB2CKDQAsmwT5M+aDAhy?=
 =?iso-8859-1?Q?kNUv1piCvfVOO+Tv7JMqEh5NrhqZYDsO2lpN0OWyd09aNrPsDekRZg43Hz?=
 =?iso-8859-1?Q?yZy9VpOFDaZqWpWbRnI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4598c9-a4d7-401b-40a8-08dd87e54155
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 12:48:06.9780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/1F7XWBkTt9DF50qNkPhC7555yM3n9ThEWx12jhz6EmcSKTqSLYBQjXmJLSEQ9Ru5HqIdw9DLWtNscTfG2BT+KJWJN0Ba9byQRMPDvbwBSoldv4bJqJJOoQRLyLH16v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8449
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vtd_find_add_as can be called by multiple threads which leads to a race
condition. Taking the IOMMU lock ensures we avoid such a race.
Moreover we also need to take the bql to avoid an assert to fail in
memory_region_add_subregion_overlap when actually allocating a new
address space.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dad1d9f300..144e25622a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4205,9 +4205,30 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s,=
 PCIBus *bus,
     VTDAddressSpace *vtd_dev_as;
     char name[128];
=20
+    vtd_iommu_lock(s);
     vtd_dev_as =3D g_hash_table_lookup(s->vtd_address_spaces, &key);
+    vtd_iommu_unlock(s);
+
     if (!vtd_dev_as) {
-        struct vtd_as_key *new_key =3D g_malloc(sizeof(*new_key));
+        struct vtd_as_key *new_key;
+        /* Slow path */
+
+        /*
+        * memory_region_add_subregion_overlap requires the bql,
+        * make sure we own it.
+        */
+        BQL_LOCK_GUARD();
+        vtd_iommu_lock(s);
+
+        /* Check again as we released the lock for a moment */
+        vtd_dev_as =3D g_hash_table_lookup(s->vtd_address_spaces, &key);
+        if (vtd_dev_as) {
+            vtd_iommu_unlock(s);
+            return vtd_dev_as;
+        }
+
+        /* Still nothing, allocate a new address space */
+        new_key =3D g_malloc(sizeof(*new_key));
=20
         new_key->bus =3D bus;
         new_key->devfn =3D devfn;
@@ -4298,6 +4319,8 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, =
PCIBus *bus,
         vtd_switch_address_space(vtd_dev_as);
=20
         g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
+   =20
+        vtd_iommu_unlock(s);
     }
     return vtd_dev_as;
 }
--=20
2.49.0

