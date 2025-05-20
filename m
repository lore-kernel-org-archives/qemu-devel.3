Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58755C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHFc-00015F-6b; Tue, 20 May 2025 03:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFa-00014l-19
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:18:58 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFX-00025E-8j
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747725535; x=1779261535;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=lXpI3LRkfR8BsvSFOolEWZPNOPAKOPU+KB3lhbvKsas=;
 b=ASRcY1YKhZHEzys6SAzQI4nV48KtjWoiR670sb5EiQGB8lNhDJUTDKec
 1JXyJKOLfLRbVu4UdH9dNiEyfVzmK8Tu78mQ4hfYFWZ6Qbv7edesDZhAH
 SneG83jGRZCllp2EfMbvBlyvu3Ff1VtfcpcuPiqrKj1fi9Z39l52BBmEN
 WUkMSXqFXZhs4Sw6acGPTWWpC0zDyTPBcT3IMQP8y+MJwiDc5KtgOODuB
 9dNWOETlV6L7R0/8CERRU3cQWFOgEQ55LiXFtS+kViZxTgPjylQLCpFDE
 gvWaiYRGzCdXCP8D10kdXm+VfyIHicEwGSKixA/+LwhCA/6T/OTBwaFaL A==;
X-CSE-ConnectionGUID: TuvtBtqZRLqs0MGihwfrHw==
X-CSE-MsgGUID: 674/z9r8TTSeFJ6rEAA9EA==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37191596"
X-MGA-submission: =?us-ascii?q?MDE+S/mHXWVEHhumB/p8DiWISo5MAv4mCPll9m?=
 =?us-ascii?q?KEFwgMLZJFPP1jLvuFb46FPY9q29i3p7AEAk069pBFsa2iqMeVc9NyQX?=
 =?us-ascii?q?jFT9EVY5CVHallquxRfmeSirZ6z8LUeAXd+phk01VZYxu+cyNfDyy2tW?=
 =?us-ascii?q?mrxzLuoLFxm2rAe24+XLPrKg=3D=3D?=
Received: from mail-am6eur05on2053.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([40.107.22.53])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 09:18:50 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0TwkGidDewT8YTIxASPvVyGGm8jZJjiw3ROCJ1FHjS9zQdWn1Cx0Z2LM6XMyYnsnqtX3v3XCgNwT2TdCPSbiqzkrs+nbt+nTWakiDtPeTjORY8A/Vaqv2AL5u9V6gBez0SEhhaHHF2aUIIGcJuD/A+SunhmkmJRI0BBy1rz5PnxbKPFofwBS4wec/60CzHtfYq+e/QMxyTJtpKBofpSk+E/kBOJmCa5FF2WsRX+H289/Dp/pkn+yi54AzJS18V7ztOkIZlcG1gNTzvQusMzV1VI1f34EllHVJZwerM76+j8P6R/Os/rvBKy5MmdOVJHWhR9oPhTrQPIjG03lk924A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvdBGzHV+rm1acs8Lo/pMj2z9xFy3Akh5jStevm9Mjc=;
 b=cCW2667sLlA44j3iqM4lKkfOGAs/MzT0dSkunEjAZrW8+ufW6boewHLwJzNtRCpZPd7JT7tqARA5PR5CwUqupNi+VR35HCYDes6FEXQ9XHOVyw9k7Tg8UUdGYI8dKmuEVpmICKQ8ezdN+vI/tuKRMJIXdcJKlj3RVjrhbKtDaxnouCt56nYCBNmia8weZUTaZrayODwLOiISmqC6SKLhJjLy1GQ2SdXR+bmIdyyNkRUXwvpTGZjN8FUKj2mRlrAO/0rXng7OVvbMJwzaQWH7ErUPqK7aBILSJ/JTIuhRkWgo+fDME7DfHv3HaC4yuXELoQdK0EIGgr6WuQ3QiSJnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvdBGzHV+rm1acs8Lo/pMj2z9xFy3Akh5jStevm9Mjc=;
 b=PyffH+lBZg5zU1VOt6ItjuFVDmrKgPvWI4wFV1Valssg0MfsG7SZhME4bF6eiiGxoEvukpZiMnaLbaMkfCiTYScov9QDWbWAksoAvwR14DJ08YYKtnzWReWRrMCxH1LGQgMhgxRkPlEq2M5h68GslTJ43GtcLzT92X7ncPrDc10dMkp6URsEhIYobHPw7YhUhcARg2KgeTDcMYLCpTKN2rkVy4C8fK562lSt2Vyun4QcPPQwJ8TigwKa5vdGcgI4VqlTC85J0rSyWqz4y3SDXjGDQZg54wIhDuZIGNcdjpNEFi29EN+TOQvHoghqURaTMFfabABmmhW/rt9DPUOSNw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DUZPR07MB10037.eurprd07.prod.outlook.com (2603:10a6:10:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 07:18:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:18:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 00/11] SVM API declaration for emulated devices
Thread-Topic: [PATCH 00/11] SVM API declaration for emulated devices
Thread-Index: AQHbyVdtveefhgtz0E6YCoK5Dr0yXA==
Date: Tue, 20 May 2025 07:18:47 +0000
Message-ID: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DUZPR07MB10037:EE_
x-ms-office365-filtering-correlation-id: 8974e71f-aaa4-47d5-cb11-08dd976e9036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XE8fBs+TQy3CysaJrE/yoCf73WO+lL1JOA3CxaOre5WCJSTm34Vz26D4ZC?=
 =?iso-8859-1?Q?LyfFHtLZIAND69ztT2tk2txJfwO0i72haLRyehON27vPAby4BKVugZkLHH?=
 =?iso-8859-1?Q?+DHdg3PY6XKPULaVkjzs0bbjA7H8+jPPpa4KBI3MX0SZREs5scglES976O?=
 =?iso-8859-1?Q?iKL0VTHRIDs37lqnur++geeiv3jt8P/Un4UoGP5sHpgo5cLzGX473G4vjR?=
 =?iso-8859-1?Q?8KGJWQ8ztAP1dCjWBRMqueOk+GUIOBTMC+gpImaYkEc1bHO666SgRo+0tY?=
 =?iso-8859-1?Q?2oTTfynEvMRw74WO+4FqHFDU8H62i+H6hTvVoSXSF4k+sN3qrcWL8xyaNc?=
 =?iso-8859-1?Q?K1DuV8V9p8/EmjEnpIeLJTZi5V+DVo5wzOGU3Ca4v6zM926aUOgPhNl0jr?=
 =?iso-8859-1?Q?S9jRmeDqVIib5iHfXl/olKLLX/jeRXTYBBKP3ZA7qmtmrpaoQMlbMHFKRV?=
 =?iso-8859-1?Q?/pGenp8ocKeNe1pvUS62P6mVRSI3j2mrcSDSmNm0kmbVaZjt4KU0P2XCoG?=
 =?iso-8859-1?Q?t82qLqamB91FcrzsNCqn5E0HTTk09VkUaLyQkd/ZpfgjU4Z8dRk4pKU0t2?=
 =?iso-8859-1?Q?AiQ3i3NLvvdmE47iwoK1Q1kyYVNctY25HWLBP/RP4/prqyk4P0igSekIjQ?=
 =?iso-8859-1?Q?YDpp7e7z5NyzwohdbzG6zp88Y5+S361upOrqKDxN2zxHu75vI9R/qdPSEK?=
 =?iso-8859-1?Q?P/vOoOCo8ZXAo2H+DBlh8tQ6+hF/TGOyWpG2DCiRjX7kX7G5UNjwr1w+ia?=
 =?iso-8859-1?Q?gsh6q/KOA9JbBhDhUbxrRQczlwi9Fm3Pzx56lQCRba7sLoJLZJaa6SHrGS?=
 =?iso-8859-1?Q?uYI2m/7QXcbG4c+iIQCu/h9KwC+YbDRSk/fmPoG5Fwas34IWrySrxYZA9Z?=
 =?iso-8859-1?Q?4LGvdGBs4RhWigmIZzHqhFztoyUFO/NmCI5GUCouKokkvhBrUCJo6cuAJF?=
 =?iso-8859-1?Q?socr0bc4C4VtdWtbEv84+3nMQINGC+pJs3VXAkic7jQ3SXSuH+rYul+Lt1?=
 =?iso-8859-1?Q?C2U+Sm3xsq5AbswzG/KdFRAIRUnc2zAcE/w5Gwup6DARJLfJlKoPQL1ufl?=
 =?iso-8859-1?Q?eSqjoZ9yRFAdb/Twlbgd2uLg4ClCQgc+bMJiTtn/sqSavK68ZqonezNxMu?=
 =?iso-8859-1?Q?KkG9DqJMMp9scQQExnkWZYs8aCBp3PSK9Zf2pi3D6qGRHbfZbNK0Bo9TMe?=
 =?iso-8859-1?Q?S4C5sS6dhMPjY5VMttTAb4hOsA4cKk/co5bvNRBbyIcr8heG6ktQY8rMEt?=
 =?iso-8859-1?Q?G8LKPf2ne+B3BPnGFzLiHPtztFpDNIRcHKy3yOFRIITbd7ZfSm5wjDM4h+?=
 =?iso-8859-1?Q?DMbVGHkLmTi219ZmVTFJ8y0CovfdeRPAyn4iHaetJBRoPoQeFmgpgKs+A0?=
 =?iso-8859-1?Q?mUCPYIDxc96W9g7xxv485lg7fmyQQDX+YKNoY3OcLv7foZNo/9ty5FOg0B?=
 =?iso-8859-1?Q?44kHmKCOuVVzFUjr+B4q3O3Nk21LzgaEweQCjTwInDY6m7fj7D8EIDSDDV?=
 =?iso-8859-1?Q?YOKQT/LbVpXQTpVIJXxFgFizdweJ+dMGFuIaN1dZCb+SZHIF5c9l3ExDQ2?=
 =?iso-8859-1?Q?ioK6fzw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LjxYFKAHB2e5lsvuMRkRbpV8CQAGkF6yP7OqMqUKZ/Bp6uSNxZ66vXWNXw?=
 =?iso-8859-1?Q?A/0vSh+cyt0yzFBRJJ9wOvNzA7pO90pI35cHhahPe8mLODSQhOd3yNg7jh?=
 =?iso-8859-1?Q?fRGY4SLREVjK3shlkjZpc7a9knpjuoUxl78xIjSEJEWNvQ9feCFhXBPTtl?=
 =?iso-8859-1?Q?EevghsL+6UWIg3gcdRM2rCFDIM2zhuy5dNzYVezJylW9zTlNSG+llE4WbD?=
 =?iso-8859-1?Q?YxrorL2/7RDNUBdOZedIs7lAPFoOcujIjEeP55U/eevkyg55+ut8dqTHGP?=
 =?iso-8859-1?Q?uC2hsOia5lYBrG6xwyp/1JNO1VHFD1328lnvDniMXZr/wzH20vXhh56Jek?=
 =?iso-8859-1?Q?wLd4HtMAY935om3gOpSYGfinR6upd8NYP5k4nBopdwgIeXo8GIEmX7fCrj?=
 =?iso-8859-1?Q?OxfcXG7d2JJb93F1PKSbzSvbhtUSnq99iCmwEe15AqjppJqW3lORRYzE3K?=
 =?iso-8859-1?Q?k8NRaQRyMebQKXSk7uZNKGeP4lTOLHbPMfKJlYokfNeB2ckJeaIo2Q6tWY?=
 =?iso-8859-1?Q?qcG7oSmy/5qwnaSQ6o/wdroCzJajoZgzuMdfKo82S/kT3adJk9qY/93wVF?=
 =?iso-8859-1?Q?YNVnGHQdlJbm0f8MYSgLvFlxVx5cq1pCwm2R729zqEjjKrDkA2grlMzO78?=
 =?iso-8859-1?Q?UFsxkiaZAulFqehcaPK38yJTZ2dVQATa0sCIu3eoXEPWOf5nwTMVughjkm?=
 =?iso-8859-1?Q?2DFwFx3wFys4/h+sixwwlMNDSR+lf4BFOhCcarsh4xsCQDc3HPURQpGQ+f?=
 =?iso-8859-1?Q?4AXJnWb7NRYIgluQyXgsk99lcMrCg1ahWa8VpsYNbk2/Q/ihE4XVzGKREh?=
 =?iso-8859-1?Q?V9ZMNS+2oyQJRaJ6GwRSV1Opxk2Hfz79h4PPr3DhD4tFPIuiPJD/ALvU5I?=
 =?iso-8859-1?Q?u6vvPNO78lfkJP3sMfd4whosii4mavBHz72PDrmOFbtp46hvCsMDeyiAv6?=
 =?iso-8859-1?Q?Xnl03BryHULJIlWR+3Uln027JichPxX1VhuXkpsc6cGPOr/YFNAWjcs/PU?=
 =?iso-8859-1?Q?fEKPPJMZLKRcQYaCNghFXx8ENikXEELASWK9f40mGOqzIAeU+E97/R46u7?=
 =?iso-8859-1?Q?tea265CtraKtKOlMhcLduwNqvdxVtdJVQsAN5M/npYleLH935U2NIZHwMB?=
 =?iso-8859-1?Q?NLXRsxN/QJsG37toU7yehwWnffqZYRrmwnm1p2uq1w1mNeBxp+0pD3bP5h?=
 =?iso-8859-1?Q?m0uGC3Z7SASyFX8Igg43kCLTc3y4nxgJD/JdI76VvOiuN8dvdQNGOaQCDd?=
 =?iso-8859-1?Q?jUHIPkIw1kYzK9lOBrGGSRkSLj5brr16hdFXYBQXMG5eSjyk4fs7HBw1W9?=
 =?iso-8859-1?Q?BnLL/evrpMofRBLy8/R/mCjFNoB/IOl2z9DCf//Gu4STPu05M4B7zXFDMI?=
 =?iso-8859-1?Q?/cRtQrbAmkEckO4TeZdop0eFwLtUy+7bdtwoTO8rDd+O2rZKmFQoWEHtW/?=
 =?iso-8859-1?Q?Ecc8ECdeN6vEPeyHdR/dPNxsuPymsZ23IxfmpxIWmJp5rF48AG9A96DVtd?=
 =?iso-8859-1?Q?z+8H3TulT7MttA6IyCEke1ggm/xCkfPTiBerEj6BNyYCJC5gUj984mboeR?=
 =?iso-8859-1?Q?tY/GUG/o8W3ogyJ9xikr8H6xLzcqOOwTOQiM1BTgr4gp3M/eVwvKgNHboO?=
 =?iso-8859-1?Q?cAG9fbR9X62jIB33wQNR38pFhin30zh26F9zFwyQL7QIpGFuQ0r6YEXScL?=
 =?iso-8859-1?Q?6S7jQ0Bxe32l3+EJiSs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8974e71f-aaa4-47d5-cb11-08dd976e9036
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:18:47.8157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DF9GRVA0N6zixxIOhNRSZEwu4qP76kgF9OzHTOH0oTCrM3kt+3vV/GFcAbKVr8HSVJXggH+CxF6uqwlt3QeatXIYxHR0Erj776oWy2HfqS/p7vmfd6NM9NzoBoW0uhPy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB10037
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

This patch set belongs to a list of series that add SVM support in VT-d.

Here we focus on introducing a common PCI-level API for ATS and PRI to be
used by virtual devices.

The API introduced in this series is mainly based on the PCIe Gen 5 spec.

What is ATS?
''''''''''''

ATS (Address Translation Service) is a PCIe-level protocol that
enables PCIe devices to query an IOMMU for virtual to physical
address translations in a specific address space (such as a userspace
process address space). When a device receives translation responses
from an IOMMU, it may decide to store them in an internal cache,
often known as "ATC" (Address Translation Cache) or "Device IOTLB".
To keep page tables and caches consistent, the IOMMU is allowed to=20
send asynchronous invalidation requests to its client devices.

What is PRI?
''''''''''''

PRI (Page Request Interface) is a PCIe-level protocol that
enables PCIe devices to request page fault resolutions to
the kernel through an IOMMU. PRI combined with ATS are the
2 cornerstones of a technology called SVM (Shared Virtual
Memory) or SVA (Shared Virtual Addressing) which allows
PCIe devices to read to and write from the memory of
userspace applications without requiring page pinning.

Here is a link to our GitHub repository that contains:
    - Qemu with all the patches for SVM in VT-d
        - ATS
        - PRI
        - Device IOTLB invalidations
        - Requests with already pre-translated addresses
    - A demo device
    - A simple driver for the demo device
    - A userspace program (for testing and demonstration purposes)

https://github.com/BullSequana/Qemu-in-guest-SVM-demo

Clement Mathieu--Drif (11):
  pcie: Add helper to declare PASID capability for a pcie device
  pcie: Helper functions to check if PASID is enabled
  pcie: Helper function to check if ATS is enabled
  pcie: Add a helper to declare the PRI capability for a pcie device
  pcie: Helper functions to check to check if PRI is enabled
  pci: Cache the bus mastering status in the device
  pci: Add an API to get IOMMU's min page size and virtual address width
  memory: Store user data pointer in the IOMMU notifiers
  pci: Add a pci-level initialization function for IOMMU notifiers
  pci: Add a pci-level API for ATS
  pci: Add a PCI-level API for PRI

 hw/pci/pci.c                | 204 +++++++++++++++++++++--
 hw/pci/pcie.c               |  78 +++++++++
 include/hw/pci/pci.h        | 315 ++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci_device.h |   1 +
 include/hw/pci/pcie.h       |  13 +-
 include/hw/pci/pcie_regs.h  |   8 +
 include/system/memory.h     |   1 +
 7 files changed, 609 insertions(+), 11 deletions(-)

--=20
2.49.0

