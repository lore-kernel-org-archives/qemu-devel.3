Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF6460A2604
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=l4R8B3JB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGP-0007iD-1p; Mon, 02 Nov 2026 04:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFr-0007Pb-Ks; Mon, 02 Nov 2026 04:23:06 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFg-0000a4-1i; Mon, 02 Nov 2026 04:22:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHfvjTkv/aKHr523+k5k9EVdcVXyVdG0pf5WI0o2jFVWnziJEb6rksfjhu0UkPWivKvTHgUzmbr4xeA1OCe14a8B8mI8VOBZnsJMvscCK0xthJX1YxTiaC4G+pXSY4KK5xeuTKoSsbqZgSkCMRK9acJtuFc8z3Mf2k1tYxJCSGCZwUa32Tj5SvbU+NskIxF5yrGTEr/xGptoFj1ZIvrnEulTIiSYEulFg1sve+AxY7vlGMkVp8Q1JY092+a2nWZ/XgG9JyDjLBUOHVmxITvpMzYzRgXJa4bZuDyec2NsRTsAdcc2DJkt0NWWjDIPLta8N8CwoUKErG1Z3qcJX5UhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qhp608D5co/UuxDymwZKOtSDGY4WQCexBrmKwma3kU=;
 b=FFqwKu97vsrOqh22J+vFcTO+CksOJtZrBUhAeYOP/3kO6pYoFrj8gs6T5QpK5UbtKjzifga+2BJJdGpigLPqnFFPUbgQr/3w1+tIIFMxNRUp7W+/iCmS/lmpRdZ/NB+aN4m5knVM0V1jGPFevdJY+rbDYKlt7x0WdIj8q7e0VldmWH+WR/JhwSYIJvpTSMcfITK4q0B3STr1AT6otvC0y1dsIwlDmUbDHtCvz7iVufeRRtxpHBL1/w9ikI51/3pfdBMkkFFvRsQ4BgKMwcQSmGuO7ToJ0WZ7AC16qLSSseWp0MIjMgyFWt/U6lM9PL3HMyUsB1++mFYGYa13yNM8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qhp608D5co/UuxDymwZKOtSDGY4WQCexBrmKwma3kU=;
 b=l4R8B3JBCjJ7HFIG0r0Z+CagXaIxqly0rKsncVEtxIXupHWwZZJFPkBsw4Jafg8FilKWZrO2F+Rdlo0GIexzcd3Ho/thS2FDC5xzbmLin60y4X7upyRZyPBk48NtIIxdRGM676bzR2SsTsri43UOoPdNgAUdPmMkWJX6v11Yj3Yj0fEEvEL0Nl6lJlylqxh7B67lkL6rBfroN8PNekqdlhSbfDz+zLvhIbaBnAgO/xPNGAWl043L7BX9EyfYg3lxLVFLhZnH2C38YV/2SPuDPdRKHr3f6s2Z/y+IdLWJeEkObNT92aLwWLMLJ0NV8yTKGmkIqd6l5ruK+ybBMjN+qg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by PUZPR06MB5956.apcprd06.prod.outlook.com (2603:1096:301:113::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:32 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v8 17/18] hw/usb/redirect-server: Implement isochronous OUT
 transfers
Thread-Topic: [PATCH v8 17/18] hw/usb/redirect-server: Implement isochronous
 OUT transfers
Thread-Index: AQHdaqut1wStafDeY0CrkssiAVRBhg==
Date: Mon, 2 Nov 2026 09:22:27 +0000
Message-ID: <20261102092201.1729245-18-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|PUZPR06MB5956:EE_
x-ms-office365-filtering-correlation-id: 9af75636-510e-40d7-9bad-08df38c2d305
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|3023799007|921020|38070700021|56012099006|5023799004|261021133027099003|261026135527099003|261021121427099003|261021130227099003|261026130827099003|261022115727099003|261022113327099003|261022075727099003|261026121527099003|261022105027099003|261026140227099003|261009221227099003|261009223027099003|261028144727099003|261021123027099003|261021135927099003;
x-microsoft-antispam-message-info: KJKDLW41nS7jNiXs9DcYsU3ANJkntWCSq/ob+S+D+IUnOX19wE1ARh4Xw/QkES9cw2FXTeQ0S75jIkwoNevBH+tZYGzNr8eeVc+f2x7/OINc+OnYuec3YTU7umVUj9CzxmPQA7W9gRFCy5GGPlAtY7CJP/17Y+4R+nbpk+ARkAVjW9kdoqkEao+dreB75gdEftd9l5gFue0ymnTjw6h4EA7oCdgT3GU/zOZPCXd30JMmaJ6zAAypUjdTJevhozKL8qEArBoHRz6pzudQo1uwP8v77sC82N/Ro183krvHuOBHRD2fggXD+ufptI8YbXW+Nh1WFYdqYy6OjW2piQwupsZXdFlZ+sNpLGQzog3RKoqc/4HQm/CP+dh0zh3zHIJnfnuW15KkMA3+2IRiiaypDH/0QJ4hP+AePeEPe7o9uQ1EBHGCu7Tvs86aS4z3SBp6He6ksQOhiy8rWSbnxOON42/+HBxDP9g5D4Q/re63CzNadxI7cxxRBK+Drez7XlKyewythPxnprnJCjptf/2+MeX3bVZLEVpuwN874pwlLYpOlCFL6sbV3mOoaVfrF4roTlvYkIxr9AajseqAGjn0tz/lDyTUEChYRgBIFw3xKfpX5V3SbGLv18ExQx256zhcxR/BWnYp3a3JOy2Z8lsRD1Zu8pkt6htqzjUXKE+ykboe7vkHm2saqjKcXlIjC3pRBoGGWsaEQvOcyHyLSOILJtBjfXQdzthzLZrYJvkz8Fs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(3023799007)(921020)(38070700021)(56012099006)(5023799004)(261021133027099003)(261026135527099003)(261021121427099003)(261021130227099003)(261026130827099003)(261022115727099003)(261022113327099003)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009221227099003)(261009223027099003)(261028144727099003)(261021123027099003)(261021135927099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?q/zBWuunlR53SxaidMgijPRXeEN9bvXWT/h5awPh9J0pwc0jraETsX9o3u?=
 =?iso-8859-1?Q?BF6O84zuhcMYYs76fekQVOPYsZ4IL72wiH8MQadnzesRBWLAAWNpPt+JxT?=
 =?iso-8859-1?Q?xTmgL1jY6YfEzsgc0d6tACD3acKS17f/QX0gYRBV5SWNMxlROpmVWUBzEK?=
 =?iso-8859-1?Q?YIhTJXnHpDcnJmbNJoQxJGhZcF22f7sTZXdJA97aqQEqDJqyOaIo7Ek/Vh?=
 =?iso-8859-1?Q?mYRl2+krPMf0A8NUaXaMQ2FbZaxojrpcGWJpTd84uXQEQXZTFYmlQ9CEts?=
 =?iso-8859-1?Q?3eQ23zK9YEkT67uwRqiu5JDpFsxb/IAIN6a70iBvpyyHvpDKA3CIBi1nvU?=
 =?iso-8859-1?Q?a3z2QZo0V+hAVtlCPAgBbaQ15M7prXdmBmRP3kIZj4uPFF63QUED0gLtCU?=
 =?iso-8859-1?Q?eerthvPtY5Iqpsqyvm8uurnc7CHsuugd2f4Rr7iNy9JU8S+28cVbWpLAMq?=
 =?iso-8859-1?Q?6ikW+gF3nkz3D1O7vvI2NeaSMiteX3/03IrcH5oNubfhfB2Qvcfvuv7emx?=
 =?iso-8859-1?Q?xGlukTZb0qqkcb9Vk1FMHiGkyicJ2SUhGP9alBY0P14MyDCw8ssdawm8q5?=
 =?iso-8859-1?Q?4K73oEPQAqC/aA6wOhhR3rTd4V0NIqoOQhnpix/GVuS+4dTOJkvvrII6Wp?=
 =?iso-8859-1?Q?+kmOeFZykQyr/02O7uTjFQMpJmm3Ncrwr0OZRevxy/rmmuut+bFlUK7RXq?=
 =?iso-8859-1?Q?5OOdbCPrZg9d9gaAsp0qS9p5qblN9j0OQ9Z8J3+4IfYUv1+L6VW28W1/t9?=
 =?iso-8859-1?Q?XNCYO8nHCInwOsTUMGLhsXbNOMrV+upmk0UWVLxQjIlhI0rMbjzlvNx4gN?=
 =?iso-8859-1?Q?2P3aGMDWn/l2Q6RwI5xmV5Ss270xR1G8aJms37MDU1xUO4TrTw6a7gYzpg?=
 =?iso-8859-1?Q?MIOnaNgDCQXiN0KdN10dL5JLHdTYmZ7tn9Pu6h4HT4GnCZ3QrdX8FCgdXQ?=
 =?iso-8859-1?Q?UJYnZuYsxLAEncmrZm4jv6GulGjj4Ne5OM2O31DHOHCbJVTwhjPFZQPEF1?=
 =?iso-8859-1?Q?O+cbKzU24hvx/jGU2ctoTHl1DmmXVVmNlbXZvKTU5yai6hjW9tiPR/csSb?=
 =?iso-8859-1?Q?YQNevelgjXI/m8/htDHqppD48+5QrbF8IEl5d+01miS/iZRbEgFts+zW9D?=
 =?iso-8859-1?Q?XU7kOfvMTMEsPDWauG5qckp2XzsasMOYXnQXdgrps+Ny3e8u9bOak2Pdf6?=
 =?iso-8859-1?Q?wb72ewWrQS3olgvKqKfZjyDifd+13VTlV2F2Qw/bjwjyQ/bc9R9skgRLXA?=
 =?iso-8859-1?Q?YXqtk44nFzxHsscdq7daaHJE6HZFWYVCGBqKaO+EsDYre92dDfFKehe5zf?=
 =?iso-8859-1?Q?g1wFaktxhNC4t7RxYEU1mLdcB1auurJYkbCB0UZbQgtutZzIoPRKtVdHNW?=
 =?iso-8859-1?Q?jhfTLkxwHwOqPL9zreaharwsIC/WLlaWGp27QUTYhbTb/blr7ak2oVsqQA?=
 =?iso-8859-1?Q?SnvJY3+Jn0aacossEPTqzVDq4cri5YqCzX3QSGgO56lNL47CChW1lx78tR?=
 =?iso-8859-1?Q?k5TxBV6ZNfpY9ekexieby9DUjlSZS6IViUpSlqhPaWmFJRvPXqs86fqDEw?=
 =?iso-8859-1?Q?CfY28tIzq754b1mFBNXRfY/niSom+ndxJsj4oN4ns0g/tRNRNgG8esHEEA?=
 =?iso-8859-1?Q?U/HfgrJ3iZfxOM7vlaoDtNrEX2mGVhUnPEdbuXmyuuGTUJghSgj7BMWeNd?=
 =?iso-8859-1?Q?2l6m/2l5dbV+0kdrJ9k+jWLMIiVf3r/wFj/DphOcdgc7n+bYTpsEVq3S3L?=
 =?iso-8859-1?Q?0wGnktf5hkpDW8ahDwbCAjSCBRluwvybqU+c1RiIEDa5dn7LPDa4kI7szp?=
 =?iso-8859-1?Q?+HAy/aTOZQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uWQcss9zdZU3PP1SeHGRK2MfY+soujQcmMRJTtk6hPTpsIpbR+0NeROFkmV0kUDDx5OdBYDQhzJqzcR5zzlatxlvP92xBCB2VzYkB/eOeF2PgQXAOI5UUILvUetOEJqefEokYH/HFUXI0tfujmcAvOqM/bWJ4lpDnG7dKtn2gCF1T7W9lXTYWDj5zoHVvd+I/FF+fS9pSiBWCsKvBDlOUAiDpxE6M8z/10lbbbTEjTRnzhWnSCf5YUg+V0UYz2v6qBVzp8qvvxPsorjL5USO4cIcukyLE4DAcvVgfxG0OJfZKRWHnDb8BmhDBGVTQBaAIexM7hVH6jUF+P9TSPv/Ug==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af75636-510e-40d7-9bad-08df38c2d305
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:27.5250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RgRMY/nGF8tbw5h/U2L74wkKpevuSJrQTrKzPYBUu7eCaNjGhIH28FWcHTmRjBrUPP3oJuZA03yKsUIQl6RROmDyeGs+mJ4GyyzC42Ido9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5956
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The protocol has three callbacks for isochronous transfers:=0A=
start_iso_stream_func, stop_iso_stream_func and iso_packet_func.=0A=
Isochronous has no capability bit, and the parser calls them without=0A=
checking, so a server cannot leave them out.=0A=
=0A=
Implement the three for an OUT endpoint. Endpoint 0 is control, so=0A=
refuse it. The host sends a packet for every OUT transfer. It sends=0A=
nothing for an IN transfer, so refuse an IN endpoint with a stall.=0A=
Only a stall makes the host close the stream. Any other status leaves=0A=
it open on the host side.=0A=
=0A=
An isochronous packet has no id, and the host wants no answer. Report=0A=
a failure with an iso_stream_status. A broken endpoint fails every=0A=
frame, so send at most one report a second. A stall does not wait. A=0A=
stall ends the stream, and the host has to hear it.=0A=
=0A=
With no id, a cancel never matches an isochronous packet. A NAK does=0A=
not park it for a retry either.=0A=
=0A=
Reported-by: Junjie Cao <junjie.cao@linux.dev>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 161 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   5 ++=0A=
 2 files changed, 162 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index cfd2bcc438..95d25b5292 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -99,10 +99,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SE=
RVER)=0A=
 /* Buffer size for an interrupt IN endpoint before its descriptor is seen.=
 */=0A=
 #define USBREDIR_SERVER_INTR_STREAM_DEFAULT_LEN 64=0A=
 =0A=
+/* The shortest time between two failure reports. */=0A=
+#define USBREDIR_SERVER_ISO_STREAM_STATUS_MS 1000=0A=
+=0A=
 #define USBREDIR_SERVER_CTRL 0=0A=
 #define USBREDIR_SERVER_BULK 1=0A=
 #define USBREDIR_SERVER_INTERRUPT 2=0A=
 #define USBREDIR_SERVER_INTR_STREAM 3=0A=
+#define USBREDIR_SERVER_ISO_STREAM 4=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
 typedef enum {=0A=
@@ -128,6 +132,7 @@ typedef struct USBRedirServerPkt {=0A=
     struct usb_redir_interrupt_packet_header intr_hdr;=0A=
     struct usb_redir_control_packet_header ctrl_hdr;=0A=
     struct usb_redir_bulk_packet_header bulk_hdr;=0A=
+    struct usb_redir_iso_packet_header iso_hdr;=0A=
 =0A=
     /*=0A=
      * The IOV points here. IN data lands in it, OUT data is copied in.=0A=
@@ -169,6 +174,13 @@ typedef struct USBRedirServerEp {=0A=
     QEMUBH *intr_stream_bh;=0A=
     bool intr_streaming;=0A=
 =0A=
+    /*=0A=
+     * Isochronous OUT streaming. The next failure report goes out at=0A=
+     * this time.=0A=
+     */=0A=
+    int64_t iso_status_next_ns;=0A=
+    bool iso_streaming;=0A=
+=0A=
     uint16_t max_packet;=0A=
     uint8_t interval;=0A=
     uint8_t iface;=0A=
@@ -724,6 +736,47 @@ static void usbredir_server_intr_stream_complete(USBRe=
dirServer *s,=0A=
     }=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Isochronous transfers have no answer and no retry, so a good packet=0A=
+ * needs nothing back.=0A=
+ *=0A=
+ * A broken endpoint fails every frame, so we do not report every=0A=
+ * failure.=0A=
+ */=0A=
+static void usbredir_server_iso_stream_complete(USBRedirServer *s,=0A=
+                                                USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_iso_stream_status_header st;=0A=
+    USBRedirServerEp *ep =3D &s->ep[rp->ep_idx];=0A=
+    USBPacket *p =3D &rp->pkt;=0A=
+    int64_t now_ns;=0A=
+=0A=
+    trace_usbredir_server_iso_stream_complete(rp->iso_hdr.endpoint, p->sta=
tus,=0A=
+                                              p->actual_length);=0A=
+=0A=
+    switch (p->status) {=0A=
+    case USB_RET_SUCCESS:=0A=
+        return;=0A=
+    case USB_RET_STALL:=0A=
+        /* The stream ends here, so the host has to hear this one. */=0A=
+        ep->iso_streaming =3D false;=0A=
+        break;=0A=
+    default:=0A=
+        now_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);=0A=
+        if (now_ns < ep->iso_status_next_ns) {=0A=
+            return;=0A=
+        }=0A=
+        ep->iso_status_next_ns =3D now_ns +=0A=
+            (int64_t)USBREDIR_SERVER_ISO_STREAM_STATUS_MS * SCALE_MS;=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    st.endpoint =3D rp->iso_hdr.endpoint;=0A=
+    st.status =3D usbredir_server_status(p->status);=0A=
+    usbredirparser_send_iso_stream_status(s->parser, 0, &st);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -806,6 +859,9 @@ static void usbredir_server_packet_complete(USBPort *po=
rt, USBPacket *p)=0A=
     case USBREDIR_SERVER_INTR_STREAM:=0A=
         usbredir_server_intr_stream_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_ISO_STREAM:=0A=
+        usbredir_server_iso_stream_complete(s, rp);=0A=
+        break;=0A=
     default:=0A=
         g_assert_not_reached();=0A=
     }=0A=
@@ -845,11 +901,12 @@ static USBRedirServerAsk usbredir_server_ask_device(U=
SBRedirServer *s,=0A=
 =0A=
     /*=0A=
      * Keep the request and send it again when the device wakes the=0A=
-     * endpoint. A streamed request asks again by itself, with its own=0A=
-     * timer.=0A=
+     * endpoint. A streamed request does not wait here. The interrupt=0A=
+     * stream has a timer of its own, and isochronous never retries.=0A=
      */=0A=
     if (rp->pkt.status =3D=3D USB_RET_NAK &&=0A=
-        rp->type !=3D USBREDIR_SERVER_INTR_STREAM) {=0A=
+        rp->type !=3D USBREDIR_SERVER_INTR_STREAM &&=0A=
+        rp->type !=3D USBREDIR_SERVER_ISO_STREAM) {=0A=
         trace_usbredir_server_nak_park(rp->redir_id, rp->ep_idx);=0A=
         QTAILQ_INSERT_HEAD(&ep->waiting, rp, waiting_link);=0A=
         timer_mod(ep->retry, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=0A=
@@ -1513,6 +1570,93 @@ static void usbredir_server_stop_interrupt_receiving=
(void *priv, uint64_t id,=0A=
     usbredir_server_intr_stream_cancel(s, ep_nr);=0A=
 }=0A=
 =0A=
+static void usbredir_server_start_iso_stream(void *priv, uint64_t id,=0A=
+    struct usb_redir_start_iso_stream_header *hdr)=0A=
+{=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    struct usb_redir_iso_stream_status_header st =3D {=0A=
+        .endpoint =3D hdr->endpoint,=0A=
+    };=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    st.status =3D usbredir_server_ep_status(s, hdr->endpoint,=0A=
+                                          USB_ENDPOINT_XFER_ISOC);=0A=
+=0A=
+    /*=0A=
+     * Only an OUT stream works here. Only a stall makes the host=0A=
+     * close the stream.=0A=
+     */=0A=
+    if (hdr->endpoint & USB_DIR_IN) {=0A=
+        st.status =3D usb_redir_stall;=0A=
+    }=0A=
+=0A=
+    if (st.status =3D=3D usb_redir_success) {=0A=
+        s->ep[idx].iso_streaming =3D true;=0A=
+        s->ep[idx].iso_status_next_ns =3D 0;=0A=
+    }=0A=
+=0A=
+    trace_usbredir_server_iso_stream_start(hdr->endpoint, hdr->pkts_per_ur=
b,=0A=
+                                           hdr->no_urbs, st.status);=0A=
+    usbredirparser_send_iso_stream_status(s->parser, id, &st);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_iso_stream(void *priv, uint64_t id,=0A=
+    struct usb_redir_stop_iso_stream_header *hdr)=0A=
+{=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    trace_usbredir_server_iso_stream_stop(hdr->endpoint);=0A=
+=0A=
+    /* Endpoint 0 is control, and an IN endpoint never streams. */=0A=
+    if (ep_nr =3D=3D 0 || (hdr->endpoint & USB_DIR_IN)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->ep[idx].iso_streaming =3D false;=0A=
+}=0A=
+=0A=
+/* An isochronous packet has no id, and the host wants no answer. */=0A=
+static void usbredir_server_iso_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_iso_packet_header *hdr, uint8_t *data, int data_len)=
=0A=
+{=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    USBDevice *device =3D usbredir_server_device(priv);=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    uint8_t status;=0A=
+=0A=
+    status =3D usbredir_server_ep_status(s, hdr->endpoint,=0A=
+                                       USB_ENDPOINT_XFER_ISOC);=0A=
+=0A=
+    if (status !=3D usb_redir_success || !s->ep[idx].iso_streaming) {=0A=
+        trace_usbredir_server_iso_stream_dropped(hdr->endpoint, data_len);=
=0A=
+        usbredirparser_free_packet_data(s->parser, data);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    ep =3D usb_ep_get(device, USB_TOKEN_OUT, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(data_len, idx);=0A=
+    rp->type =3D USBREDIR_SERVER_ISO_STREAM;=0A=
+    rp->iso_hdr =3D *hdr;=0A=
+    rp->redir_id =3D 0;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, USB_TOKEN_OUT, ep, 0, s->next_id++,=0A=
+                     false, false);=0A=
+    if (data_len > 0) {=0A=
+        memcpy(rp->data, data, data_len);=0A=
+    }=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, data_len);=0A=
+=0A=
+    trace_usbredir_server_iso_stream_packet(hdr->endpoint, data_len);=0A=
+    usbredirparser_free_packet_data(s->parser, data);=0A=
+    usbredir_server_submit(s, rp);=0A=
+}=0A=
+=0A=
 static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
     struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
 {=0A=
@@ -1542,7 +1686,8 @@ static void usbredir_server_cancel_data_packet(void *=
priv, uint64_t id)=0A=
          * A streamed request comes from us, not from the host.=0A=
          * The host has no id for it, so a cancel never matches it.=0A=
          */=0A=
-        if (rp->type =3D=3D USBREDIR_SERVER_INTR_STREAM) {=0A=
+        if (rp->type =3D=3D USBREDIR_SERVER_INTR_STREAM ||=0A=
+            rp->type =3D=3D USBREDIR_SERVER_ISO_STREAM) {=0A=
             continue;=0A=
         }=0A=
 =0A=
@@ -1627,6 +1772,11 @@ static void usbredir_server_stop_transfers(USBRedirS=
erver *s)=0A=
         timer_del(s->ep[i].intr_stream_timer);=0A=
     }=0A=
 =0A=
+    for (i =3D 1; i < USBREDIR_SERVER_EP_IN_BASE; i++) {=0A=
+        s->ep[i].iso_streaming =3D false;=0A=
+        s->ep[i].iso_status_next_ns =3D 0;=0A=
+    }=0A=
+=0A=
     /*=0A=
      * No "cancelled" response here. This runs on a bus reset, a detach or=
=0A=
      * a closed chardev, and the host has dropped its own queues already.=
=0A=
@@ -1676,6 +1826,9 @@ static void usbredir_server_create_parser(USBRedirSer=
ver *s)=0A=
         usbredir_server_start_interrupt_receiving;=0A=
     s->parser->stop_interrupt_receiving_func =3D=0A=
         usbredir_server_stop_interrupt_receiving;=0A=
+    s->parser->start_iso_stream_func =3D usbredir_server_start_iso_stream;=
=0A=
+    s->parser->stop_iso_stream_func =3D usbredir_server_stop_iso_stream;=
=0A=
+    s->parser->iso_packet_func =3D usbredir_server_iso_packet;=0A=
     s->parser->alloc_bulk_streams_func =3D usbredir_server_alloc_bulk_stre=
ams;=0A=
     s->parser->cancel_data_packet_func =3D usbredir_server_cancel_data_pac=
ket;=0A=
     s->parser->start_bulk_receiving_func =3D=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 6eb47085d0..642f42c864 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -427,3 +427,8 @@ usbredir_server_intr_stream_start(uint8_t ep, int statu=
s) "start_interrupt_recei=0A=
 usbredir_server_intr_stream_stop(uint8_t ep) "stop_interrupt_receiving ep =
0x%02x"=0A=
 usbredir_server_intr_stream_park(unsigned ep_nr, int len) "parked IN packe=
t ep %u len %d"=0A=
 usbredir_server_intr_stream_complete(unsigned ep_nr, int status, int actua=
l) "ep %u status %d actual %d"=0A=
+usbredir_server_iso_stream_start(uint8_t ep, uint8_t pkts, uint8_t urbs, i=
nt status) "start_iso_stream ep 0x%02x pkts_per_urb %u no_urbs %u -> status=
 %d"=0A=
+usbredir_server_iso_stream_stop(uint8_t ep) "stop_iso_stream ep 0x%02x"=0A=
+usbredir_server_iso_stream_packet(uint8_t ep, int len) "iso_packet ep 0x%0=
2x len %d"=0A=
+usbredir_server_iso_stream_dropped(uint8_t ep, int len) "iso_packet droppe=
d ep 0x%02x len %d"=0A=
+usbredir_server_iso_stream_complete(uint8_t ep, int status, int actual) "i=
so ep 0x%02x status %d actual %d"=0A=
-- =0A=
2.43.0=0A=

