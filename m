Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8FEE93813
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 05:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC9fC-0006mN-Ki; Mon, 13 Apr 2026 01:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wC9f9-0006m5-97
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 01:16:43 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wC9f6-0002WA-Bq
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 01:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1776057400; x=1807593400;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=ZmfQ8Sn8hLjKc81IxBtrmWhE6jOG7+YJHcTkq42EDLQ=;
 b=BPaJwBQSWCqXDcsUK2zc5SYZ/gKquiI1j+lZUo52Vb04kS+mWcfhBTZN
 gDhG/VBI+rM03mcjEfCiIMKntEYNu3jSYtu/CHGBGJTx+S/tssCVXR0iU
 9drLQadJgzihjLJROS3JT116g0WLSCH1BAsC4C5rb8uSIbHUS63Bi9jHr
 mEs3T1TDelrxARtYqg7tRAVpcYsbfAZWUKrd9H9HxHOUYq3bQTL4HU+Wx
 yFN1jbIH7Ah1zldXvKwyB57px0Jk5iNrirsBxHMOo793GY+kcliMgwrtF
 qlUnUPv09OhoLaJFKuUe8T8n9FyavbsNqHZ3W3nteFeBU/efY65kzqHU2 A==;
X-CSE-ConnectionGUID: wZu9RQe8RKGPbJPWkE2zsQ==
X-CSE-MsgGUID: SbEAegZgREa4+FjyJ6KaAA==
IronPort-SDR: 69dc7c31_E8ULdBjlIz6cw7UayI6wBSTttB8yZARz/5q3s99LEXb2256
 +XHkGt6mj5Xk7pDlg79deJKgIBw87Ml1vvrPdvQ==
X-IronPort-AV: E=Sophos;i="6.23,176,1770591600"; d="scan'208";a="47491869"
X-MGA-submission: =?us-ascii?q?MDFd4+JuLQP1GKxICmO18Bkt3YfQmRlvO/n7KD?=
 =?us-ascii?q?bDb1HpdzV25rssr7lSko74EOhaNZ9mAi3eEjjIf/dSf16UAWRQHCCct7?=
 =?us-ascii?q?3T7TsypaHQSUjYjJNyT4nE/3AjtReC6eyXgLcXxWy4wYrwKU0WLod/K3?=
 =?us-ascii?q?I6RWCq+pxKkq0PSQYrQGhHyQ=3D=3D?=
Received: from mail-northeuropeazon11011003.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.3])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 13 Apr 2026 07:16:32 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEFe3kpu9OudZwbNNr0dFfkaHQXK2bivo59y9jO/48bPgL6p9VreY0fncMyTFIhLz4i86/ZVIMg8pdrjL0/3jSsToC8LWGeXQQMVZPAmnLpDtVX+FX+jNP522viqqNo3XQE24Gp2as8ctQyIQ2CfSoqr71elA0/BNWdXaMboGcejMuyuFsoLDhWsDeTdTBOcNrh4JG+cNGgIL/hjDZOkob8Jx99aSiaUatFtW6n7A1qMdHZnc470v6ECt/j+RvhEfLfeoQCH1mJ+zqf8XmXuNZYetqzOFOoCAVgfQpjKerwteOkjR+mt6w8vg/SC4k2rkG23dyiAegjy3DPGBm66iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmfQ8Sn8hLjKc81IxBtrmWhE6jOG7+YJHcTkq42EDLQ=;
 b=O94QKvvg0X1MvMC8rsLADs8tLlsbOd9ZDWW/FHkcM1qH4L9M/t/AERkKozCojgdRyGihMVSpupd/DZkqx2rF5CwTVvoQSq8Xy7l6nN2whbZPH/tFiEIOwLqlF7fKczrydYroK83GSSzmRh18okxhi+04Q9YEUHwM6mUU+ySLVG0Drjv5uwk/pTiuWe695piCqpkqh9g+e7YfHecjcHZclV+GMGWHd9Nuok2IQ1PYYMkQ3WOFO68gXmYgohVe8eIIXNWLfBvTcsbWOLP1dG4UATA9cRTXxOV/Rv1dwxWo5p94mkFtVHWvd6Kp7c+Yyya6d8ylraIIuS3GRfTeqXGcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV4PR07MB10908.eurprd07.prod.outlook.com (2603:10a6:150:2b4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 05:16:27 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 05:16:27 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Paulian Bogdan Marinca <paulian@marinca.net>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/i386/intel_iommu: advertise PT in ECAP, not CAP
Thread-Topic: [PATCH] hw/i386/intel_iommu: advertise PT in ECAP, not CAP
Thread-Index: AQHcywStzgVvbgHzP0CVF5F+Do/RWw==
Date: Mon, 13 Apr 2026 05:16:27 +0000
Message-ID: <8972321276cba7b0ab2275f1bff0d02d50163648.camel@bull.com>
References: <CAFFE2avrHDKZd5m7j3E3x5=F=pzn-3c9vzGWP3+9-AVPwQng7w@mail.gmail.com>
In-Reply-To: <CAFFE2avrHDKZd5m7j3E3x5=F=pzn-3c9vzGWP3+9-AVPwQng7w@mail.gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV4PR07MB10908:EE_
x-ms-office365-filtering-correlation-id: a7d64014-8b19-4757-070d-08de991bd08a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: LpbkX6ZnWgvi3Bf1pYuyGmJVrJDuk529kNPK46ZweQHE0N/Fb2+XvdHffXkRikDnRqpVUkn1/7BpYXAPRJBXxfGzLhJSo9BdqpmrpKIOFTO5LBz5EBp9tTjmQfgfK9EXFawyrwni4OoW5LV9ndKfQMtATj3PSR2pxo0ZquslbJ61LgNyXeeuxznY6bzBUOGKiu56xbX6tV++Hd0DCu/mXO19kCY/tz2j3J5EUtBF02S6bMju7f0oaQLnmATG+bsI32Oc0UWXML9QBpQ3f4K0e0NUA/qwYBpI9DWk6GzLQtLQpO90iaK9VYmR4LqANmRvXrqQ7J7xoz6Hdh4MKDh4R4R8YfrseGj2h2QYRQHXTzJSvIaQxCsIMWqwZditzf0jj7v15zr926CrhQcZpt5tZhHSJ9jDWJ6azj8J9FB6sbfOJz2kluKjXkMHMaazLHpFCmpXPghjqJm9T5RrePNePsOcsL67CZTE+poBrqtCMiJJo8xNRw9/B5tuFjc/3rI8muLUQmuMKZZu6DyTQMceC3X/eCH+4SxPbaYqo+FQneaIWsnY9g6B7rrhEC2uWKER7kk8FwT7pEZLbDybgCWdZLI/WPwKDPtGlqEsSAJDYCmMKz2caHl6BlKHedWI/qBDr2AwbiLYLBJPzdji6MXRRKXg4oZpuo+a9q++Sk+V2Uik881lnByDGiIegIL3YxOQh2csiKy74EuVfr/AM/6g6cBjbbZqOljc7Kmpb1Ypm3a61+hsmgl7mgAFpBltNHQL2gUkQoP/zPoSfZNdmcr0oUdQn/VfiUlQ0fz6w3CaT2I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlRFdmlacjlpT2ZkekdNU09rb2RRa3FQMTY3QnhMaENrNVpqM0Fwa1JmOEVW?=
 =?utf-8?B?VXI5cS9zdzBSd0duMk1yK0xvTXowTCthUWZ2Wk1qMzlTck9VZ3VkTEVLZWhz?=
 =?utf-8?B?V090VHhvdFh1K3ZwTlo1Ritxa1FXdzRRZ1ZuOTRGSHcyck51RDk2VEZULzFY?=
 =?utf-8?B?VkNOaVhObG0rMjg0Q053ZEZ4elZkY2lBSktydWpGamw0MDBGWnpwajBjOXJp?=
 =?utf-8?B?TVJVNWRvbHUzSEcyMzAycG1qVDNOQ2x1c21kM21ZTUZ5NUg1QTNCQUxCYmxz?=
 =?utf-8?B?di9VeThUNC9ESUNSRTFBVENYSWpYWkdSaUxtV2JzWWxHUFFNMzRvemxLRDhB?=
 =?utf-8?B?eEFZeHd1V1pmRjVLbGl3V2dJMUtldWtIU1cxRS9paWV1dXFJTWVSaFRlMlRh?=
 =?utf-8?B?UVBGcnNWV3dYWTAvUUp2ZnRWdUxER1h4MXFxYmNrUTBOZUVFeTNrcVFjODB5?=
 =?utf-8?B?cGNqUVdzaDduQUYxYjVYSEc4b1RtVTBZTTUrcnBjKzBhSnJVa1lEQmhSVUgw?=
 =?utf-8?B?cEpmZlRRL2pKY01PMHVmY2tIRWM1WklzRjhQRU9lMmF0bVBsZkwwTExqbG80?=
 =?utf-8?B?Q3AwT05TdjJmekZ3eFVzeVkyODMybDJLcmFEb0VOckhpV1ZwL1pSaW9vdENt?=
 =?utf-8?B?RFdJb2FXMVpQWWJmYUlsSEV6TXdLUXpjTkd2dWFiZHJiTW1SSXJMNGk4eFFv?=
 =?utf-8?B?T2I2U3VKem1ZcHA0anpNUVppOUZadEorbkh0eHk5YzZwM0l0d2FPc2RiSi92?=
 =?utf-8?B?VGtVUnVZb0huc1ZGZThGVXJqaFd0VVgzRi9pTC9IY3pJWGdJZVBDeWNOTzN1?=
 =?utf-8?B?Q0FGZmoyYmpvRmE2ckIrLzExQmFVTjY3R3g0T1NKaHRpQk0wL01DQWhrTlZs?=
 =?utf-8?B?NmtSYlo1TWszTnZHNHF4c1JybGc5ZEN3WDN2T3AvZ2RKNWJ4TDJLZW1lcWRy?=
 =?utf-8?B?NDc2akVMVGNiQ09VRlJ5T0IyazMvaVBYNE5GTCt3dVplekZMZi82TXV4UnUr?=
 =?utf-8?B?WnRPZWVvSWlpaEJUT2p6VUNlRCs0UWJxZ2JCbm5BaWNHdXhZQXZaYmM0Vjkw?=
 =?utf-8?B?ZGNXQnhFQ1l2VFJXTGNOZDBuaHZXbWxvc2tjUnpkS25CNkhQWm91SVdYaEJM?=
 =?utf-8?B?Vm04eEFIa0d2dHdnQU1lVk9MZGlJRWdNS1V2THZyYU8zNUlzWG4rY25MckFU?=
 =?utf-8?B?L1BTWlZDYzc4UWprc29nZ3JuVmc4UzFLRGlGU2ZsMlpFNFhPVFdxR3c1MEdn?=
 =?utf-8?B?L2Z3ZWdvNEhDMnZwQlB3cGxETURVV0dzRGkxUUVaTkYvMUZ0WDU5K0xnMGVF?=
 =?utf-8?B?aXdSUW45WEh6UkpMQXYzMjM4L2tUZnlRWnJLR3EvUWo2OVo5SllDWEx5Ulkr?=
 =?utf-8?B?N3UvWHJtdnZaL0VWL0k1WGlvbERFK2R1OXd0YXBuN1pWQngxMUR1QlVDbmdB?=
 =?utf-8?B?Y05odXNqNUlsRmhFRTR3YmNES0tPN01pSC9TVks0NThDV2FScFdIbkl4RUtV?=
 =?utf-8?B?YVNMKzJiT0lLajhOYk4rYmo2Q1BNRmQwdlp1Q3BqbUpuN1QxQU1qREJJZjJP?=
 =?utf-8?B?U05jcEt0M05xanlOYjVxNzZydWcxVS9uQlVFRUsyWVhHMm1ESHBlcUIrbGMr?=
 =?utf-8?B?QTJiTkpTYnZMNXE1SmEveUpNQk5VMjloeUtDUnQ4OXVEZm0zb2J3UWJZS2ZI?=
 =?utf-8?B?d1NhNjR5VFB2QVFKLzBkUFNWenk5NTlmRXRrTGEwOUNPZ3dRVGtjemV3Zk9X?=
 =?utf-8?B?bGlYOG5Ucit4ZGhUQ0QvUVh6SXBBOHF1bnJ0Skg3VGtFenN2ZVUvUmVYdmZG?=
 =?utf-8?B?UVpiT2lsVFRnZ09YQXQvUi9tM05LOXBYN01xUWl6Vkw2VkRMTmdsVTVTYWMr?=
 =?utf-8?B?cUtqR0doWkxlTEVocUZmb3h1MThZZWdTOWVMTXZESDlWR0tPbEdRRFY3NnYy?=
 =?utf-8?B?cTdPYnZIMFlzSENBQi9wYTdON2NjdzM4bGFuQ2UzUzVsTTQyaFBmcUxjYWNr?=
 =?utf-8?B?YlRkY0tBbVI4M2RGQlRzOXB6QjlJZWNsaHFMb0ZWQkJ2bGpJZTYvaUNVY1JL?=
 =?utf-8?B?c3hhQ29pNEJhQVlyTXo2RUU1dGo2bFJpSVVGN0JsMHZXMThqRkYyQ2llUlRm?=
 =?utf-8?B?Ynh0V2Jjck5aQUtHemQ4TWpXdVFLZm1vM0NId3o5RjNWZTZvWFFaZTZhRFFo?=
 =?utf-8?B?U3l2YWVhOVZDLzF4MWVrREpmZ2k3RGxSTXJjYmVpaHVuK3BwQnFsQ28rNUth?=
 =?utf-8?B?dDNMTytFaW5uOHZhRjJ0QUJ2RUoycGtHNmhZRkorRjA2bTNaZEZtQkFobzlH?=
 =?utf-8?B?RVJxNDVyM0N6Y3ZIWnAwT3NBRXlsR1JaaEVmemV3K2dCN2djK0R4M0RPQXZy?=
 =?utf-8?Q?htLN933EHSajaPgw4V4twOvw5qYsH21mA5HoV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <500CCD82F67277498CA6DDB6CBCD223B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QEVqDM2iVhb59HdVmxwXmBwwVjmck2GalGxdMIR9u73DYcTMWBlxok8r5Pnzo8N5elhy79HRINwI5FElD/OyFeAHas7yoYbFXYwqhq3GvIhzlbFZwt2/nO7LnjqnchKpcHgsCO1Yls/ZhY71+DyIRrj0aSIk2jrqf8BWXp+vf7pmTvezqkdKZoIxliP4BugvMxI5pAM7LQA00ttnuEaJOBteJ5RnHSJYBNGB294QmTywr019KZ4RsUxFoNSsoPw6saQj0OTOy1Zb6PxaHLoW1v2OOpVbv7hpv9g27c7+Yx/CLUM6274TuM0QlCrgLkhiViERXKFevI2gaQrBfq+nmA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d64014-8b19-4757-070d-08de991bd08a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 05:16:27.4487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5rNLYMSqdvp150MVHCiR0BMIxts0OM46qAl/pRburX2hU48H/0PzSOT6vtdwB1mcgvv5/lRcvloyWbxpvAScUeQ1CnWajD4wDaSduxhEN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB10908
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

R29vZCBjYXRjaCENCg0KUmV2aWV3ZWQtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVu
dC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KDQpUaGFua3MNCg0KT24gU3VuLCAyMDI2LTA0LTEy
IGF0IDE4OjE3ICswMzAwLCBQYXVsaWFuIEJvZ2RhbiBNYXJpbmNhIHdyb3RlOg0KPiBjb21taXQg
YWNmN2UyYzkzY2IzZWZkYTBhZGQ2ZmQ1ZjNiNWI0NDdlNjNkNjM2NyAoSEVBRCAtPiBtYXN0ZXIp
ICANCj4gQXV0aG9yOiBwYXVsaWFuIDxbcGF1bGlhbkBtYXJpbmNhLm5ldF0obWFpbHRvOnBhdWxp
YW5AbWFyaW5jYS5uZXQpPiAgDQo+IERhdGU6wqDCoCBTdW4gQXByIDEyIDE4OjA4OjQ1IDIwMjYg
KzAzMDANCj4gDQo+IMKgwqDCoCBody9pMzg2L2ludGVsX2lvbW11OiBhZHZlcnRpc2UgUFQgaW4g
RUNBUCwgbm90IENBUA0KPiANCj4gwqDCoMKgIENvbW1pdCBjN2IyZTIyYmQ5NTcgKCJody9pMzg2
L3g4Ni1pb21tdTogUmVtb3ZlIFg4NklPTU1VU3RhdGU6OnB0X3N1cHBvcnRlZCAgDQo+IMKgwqDC
oCBmaWVsZCIpIG1hZGUgcGFzcy10aHJvdWdoIHRyYW5zbGF0aW9uIHR5cGUgYWx3YXlzIHN1cHBv
cnRlZCwgYnV0IG1vdmVkICANCj4gwqDCoMKgIFZURF9FQ0FQX1BUIGludG8gcy0+Y2FwIGluIHZ0
ZF9jYXBfaW5pdCgpLg0KPiANCj4gwqDCoMKgIFZURF9FQ0FQX1BUIGlzIGFuIEVDQVAgYml0LCBu
b3QgYSBDQVAgYml0LCBhbmQgdGhlIHJlc3Qgb2YgdGhlIFZULWQgY29kZSAgDQo+IMKgwqDCoCBj
aGVja3MgaXQgdmlhIHMtPmVjYXAuIEFkdmVydGlzZSBQVCBpbiBzLT5lY2FwIGFuZCBzdG9wIHNl
dHRpbmcgdGhlIGJpdCBpbiAgDQo+IMKgwqDCoCBzLT5jYXAuDQo+IA0KPiDCoMKgwqAgRml4ZXM6
IGM3YjJlMjJiZDk1NyAoImh3L2kzODYveDg2LWlvbW11OiBSZW1vdmUgIA0KPiBYODZJT01NVVN0
YXRlOjpwdF9zdXBwb3J0ZWQgZmllbGQiKSAgDQo+IMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBQYXVs
aWFuIE1hcmluY2EgPFtwYXVsaWFuQG1hcmluY2EubmV0XShtYWlsdG86cGF1bGlhbkBtYXJpbmNh
Lm5ldCk+DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jICANCj4gaW5kZXggZjM5NWZhMjQ4Yy4uN2IyY2VhZDhmOCAxMDA2NDQg
IA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMgIA0KPiArKysgYi9ody9pMzg2L2ludGVs
X2lvbW11LmMgIA0KPiBAQCAtNDk5OCw3ICs0OTk4LDcgQEAgc3RhdGljIHZvaWQgdnRkX2NhcF9p
bml0KEludGVsSU9NTVVTdGF0ZSAqcykgIA0KPiDCoHsgIA0KPiDCoMKgwqDCoCBYODZJT01NVVN0
YXRlICp4ODZfaW9tbXUgPSBYODZfSU9NTVVfREVWSUNFKHMpOw0KPiANCj4gLcKgwqDCoCBzLT5j
YXAgPSBWVERfQ0FQX0ZSTyB8IFZURF9DQVBfTkZSIHwgVlREX0NBUF9ORCB8IFZURF9FQ0FQX1BU
IHwgIA0KPiArwqDCoMKgIHMtPmNhcCA9IFZURF9DQVBfRlJPIHwgVlREX0NBUF9ORlIgfCBWVERf
Q0FQX05EIHwgIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWVERfQ0FQX01BTVYgfCBW
VERfQ0FQX1BTSSB8IFZURF9DQVBfU1NMUFMgfCBWVERfQ0FQX0RSQUlOIHwgIA0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBWVERfQ0FQX0VTUlRQUyB8IFZURF9DQVBfTUdBVyhzLT5hd19i
aXRzKTsgIA0KPiDCoMKgwqDCoCBpZiAoeDg2X2lvbW11LT5kbWFfdHJhbnNsYXRpb24pIHsgIA0K
PiBAQCAtNTAwOSw3ICs1MDA5LDcgQEAgc3RhdGljIHZvaWQgdnRkX2NhcF9pbml0KEludGVsSU9N
TVVTdGF0ZSAqcykgIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHMtPmNhcCB8PSBWVERfQ0FQX1NBR0FXXzQ4Yml0OyAgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9ICANCj4gwqDCoMKgwqAgfSAgDQo+IC3CoMKgwqAgcy0+ZWNhcCA9IFZURF9FQ0FQX1FJ
IHwgVlREX0VDQVBfSVJPOyAgDQo+ICvCoMKgwqAgcy0+ZWNhcCA9IFZURF9FQ0FQX1FJIHwgVlRE
X0VDQVBfSVJPIHwgVlREX0VDQVBfUFQ7DQo+IA0KPiDCoMKgwqDCoCBpZiAoeDg2X2lvbW11X2ly
X3N1cHBvcnRlZCh4ODZfaW9tbXUpKSB7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCBzLT5lY2FwIHw9
IFZURF9FQ0FQX0lSIHwgVlREX0VDQVBfTUhNVjsNCj4g

