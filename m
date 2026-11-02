Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593E606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=eRL6zqrI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGO-0007iC-Uc; Mon, 02 Nov 2026 04:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFg-0007O5-DK; Mon, 02 Nov 2026 04:22:59 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFQ-0000Zc-PZ; Mon, 02 Nov 2026 04:22:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnW8BwR6yUMh2WDfGAk0IBQoPkYN0s1+1d9XAZpk31ln+w71kLjqzaULhxjAZZL13NVupmmsddsf8hko+HeEDC27tf4T0UlC6NkJUHxqpSBmENUjNhoeAJrMR9bwGARM1/vrwx0pVd1pTIw6B6RDYgIWYG4H9l9RCI9mc77eQHDFuGk5ru3SbmHC4k9iKSDSmZqRTbt9oKji08tQgzcAwv5atkXv1ggqM5z7IYERTSQFxWSQkddF6PTWdwx6aEtoKUBE5hcLcFrM1GUe4HvGma6wrf8r3lJ5B9+Y9Gp/5nQOD8G1VrYKgZdgxiK9gDreM7zn228viyiw11zJvQl4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5m4vFgqwJ7d4DsSLSFySW7I7g6HmM6xGn7bEovmalM=;
 b=pJiPsezEw1IRMS8V7Im2LNNu9BPLZyyzEjdAIecGw4URgxu/G02z1UbZEl+8ieFDpfPX7SJbfAlYJjxT7pfrR4ZUUDb/Io3z/dVRrVviQzlIAJh0v1YlJiUrdE2fDKcFA6pTrF9ynQkxtKejGu1mxEbu0LF62FpnbEfyOjbHDjSRyXkQRbfC1/5MlKSGe8Ag9cG7hyBhVkkoOe9D+KfrBs7tyr7Hq1/S9pQn4xb/GHdHtaEtLz3sNvcxUF1UU8HAY78Z5e5j3KlmpPQOYdiG1u8IxF9KK0AhkrCke789+mDewOZMYBWcxaFzKRJqIuUxUK5cmOgURkCj3ewGChHaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5m4vFgqwJ7d4DsSLSFySW7I7g6HmM6xGn7bEovmalM=;
 b=eRL6zqrIMHSGEcHIT0oVaLtaWSFUdGI1mu2EbhZzxDSKbJ55D9zOPb2PPAz9P43bmwRnxOiFNM6EL+c7hU8I5yJFX2g1P98g45oSwW6iIMMCk6fN5DrnuVRTBiyfkOzimBcWR8J3K/LrvJPNLAHGKz7lZz2kI1fJ9mLaq+KDC1yRs8G9taQGoKRBHVCTiRLrApLwjmDWzwL9xSWMgn722rlNmJidWdtTPk4RAM7XL0Zm7h6NT80fCld6eJ3LY3lNY9me9IQe4qOuqJxs+SNjebaX0JPngQ7HpWzWmbMm3zgQ9ZYrhP2zlHyFTBunZUeyapYB81e9JHWTbmXRBZKMug==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYNPR06MB9200.apcprd06.prod.outlook.com (2603:1096:405:3d5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:31 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:31 +0000
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
Subject: [PATCH v8 16/18] hw/usb/redirect-server: Stream interrupt IN endpoints
Thread-Topic: [PATCH v8 16/18] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Index: AQHdaqusEi/dXAV6WUG6mAb2gc7SGg==
Date: Mon, 2 Nov 2026 09:22:26 +0000
Message-ID: <20261102092201.1729245-17-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYNPR06MB9200:EE_
x-ms-office365-filtering-correlation-id: bff08b16-1622-4acd-2d19-08df38c2d21a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|10067099003|18002099003|22082099003|921020|38070700021|56012099006|5023799004|261021121427099003|261022113327099003|261022075727099003|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261021123027099003;
x-microsoft-antispam-message-info: ITZWEmKUF7oTxfRhKbnxpzA6oHc6WAAZhiqIPeR5dS+p1UmOEoGRh6px60eCreoVa0V0LpKlwXMa3FR/8POU/v1BhRkib49JB0H2eWU5kEKrVtGLUHjgIpBv9I7VqCtTanILuj5unL2CwZUoEjY8k53qXMVC2HEw1wGjbzg/AREDAIYb16aEef2+4qCTj0MsSDuTeKf/3rgCdS49TLKIMsZa9B4n1VziU7FJP1k0v5GPEOt+69tymkqLg2BlfTJA51lJTq0c+qdDfKUSUVRK7JaANDw93pRhnUmAsWF14DAICYZeBePG2GoPTouB9T1T7XdAsUxc9oCiqABNvKGQPe8+gMpZDdFACuaMrkzsdqWTWlMdW46sl9ro1+oNo2nv3a5iLHuz0N8wcEESWwfmbQagLyl7bMC/xMGDOKRxXKwQVeLvEZeSs2GgEGrIkFQvS96294Fiz0+qN7S3v/DdxZy/IOmbbyct1AyBjaPvC9Daug5fEaZW8vdHxkTx7axz1rpB/ljhaIVD44LVpcPrZCWSMp0zC/Q0S95o4B/mI4zgke8OfDx6AIhZLuWYbPI1zgJZKe0geicQz5cCKF4pJ7D9kkfSIGknPNfCz8/TCoFv2ETXcKYVxIHDntRaKt40QFTHjVgrzYsFx92p2C8LSmXOd2t46lD58Poh5gHB7wTZBhQZRHHCy3BDpLcf8Wj5j8Cc41hUsKEH7nKuqbfJgn1rnqV9yn1PlyOZsrVdJ04=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(921020)(38070700021)(56012099006)(5023799004)(261021121427099003)(261022113327099003)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b6ebnCYGdPJ57FCe37CRPbq6fRTJWYywJ/0jVzMxmkPsEwBa8bvrvFhTY4?=
 =?iso-8859-1?Q?HpiQ+/v5MK/w66WinaIT06nF4UTVtlPM5hTJMkWWwl7IRk7XDy92IvC58l?=
 =?iso-8859-1?Q?mt8UUVDrxtz8ploXn6M9U9QFuKBxXGg1X19v7Qe2Rj7JmstJL35HBplhD2?=
 =?iso-8859-1?Q?gjDeHxi1USeZMDP8hgEbDN/zkMIH0K9HDltFVzunl+A23W2zDZJ/37xKUn?=
 =?iso-8859-1?Q?H1dal20kztS7u4WfKvBU/tp/FDaxdpC5vmjfi7jZ4M2ZCXVRXZOAFLv4RS?=
 =?iso-8859-1?Q?QKKtGhzeUM/JrYTA/qZiL8e61eE+g7MKhIUDS85lNAlNlAGYp1ahgvtqEi?=
 =?iso-8859-1?Q?BmVATri535YnwGyhfN8VX6E0R8FttStrRI1IKwXFid6gBFSLKmwtytvApb?=
 =?iso-8859-1?Q?3DULTm0udnMXd3PV6eEksUL3SdPR3mq5dGE2uCItMICVdVKEJFE+cIiTvh?=
 =?iso-8859-1?Q?pIXA0XiwE6rRGdm7/LtIvSfPTpdxN5sMS+XsU/hgt1a1vH9SQLpQ/y0G4f?=
 =?iso-8859-1?Q?SPas8HQ9rC9TsISAkGtcFRV0Ib2XPPdt3DSeyN1a9KUMecGkk1CW/zjtsK?=
 =?iso-8859-1?Q?H67lqBGDoGplbhb4ELO6CCGz04iY8B27hgImpEGoWDxQEeU6PRaP+5gZ8+?=
 =?iso-8859-1?Q?PqkFPCPFUeZdU9PJVA4sKhgESBcxN/dzQp6PlJosfUH7HctNoP8sntq+g1?=
 =?iso-8859-1?Q?IaY4ZGiAOUZNDbrD7QfEh63VDlMLkx08IdIB/3Piu3QFbUrZfMnSesjKK0?=
 =?iso-8859-1?Q?rUrEKY3geOKULmz8UbDl0pjOGckRAkizrQrawkOzvAaX95qkfgsL1D5Mqp?=
 =?iso-8859-1?Q?lhIAxxhZA11+epRm7+XQcNgI3VJViXX05y/kjwII3cYDN7ry80YWjfkv1+?=
 =?iso-8859-1?Q?yfTriBqjLk3Go+147k/AjB8T0UuZRC1ZQdzQvowQ9oP0VZGAaszQwjCtuA?=
 =?iso-8859-1?Q?kNJ2prffF+B/W8ZGVEzY/ZNhPIqUslJSY4bX8vqHoIj3p0p65xTE37C5Lk?=
 =?iso-8859-1?Q?l56vs7e2Yw3uwSJFb65TURW4CkkIKYXl5biBVDrQ+rj6k8LrZDC2QErKu3?=
 =?iso-8859-1?Q?oeEuterOGYo7wGbA3e6buFrrIRZ8Bu8SbTjbST30XjqzLHzDzwote2pint?=
 =?iso-8859-1?Q?+nkB4qb27bBIsqNMntRKrfD92n+RyKhd5AmrXqn81Q8cs+Ei8qHnJ3nVn5?=
 =?iso-8859-1?Q?jnvvlCZuvX/LiqBLAklp8E7ibpQAJcv0oST3R0OzT0gkC+XEHTigDtWIg3?=
 =?iso-8859-1?Q?j52MXusnZzLzoJjMX9etYnOmt6QeWFVAXLxiM7x8flz82/4ga2YBm8OWqu?=
 =?iso-8859-1?Q?VvXLBP40VkCHJGQrSviTeNN5RvlPjr8YG8IX9xzzFI7RPd1mE/zQETiOrW?=
 =?iso-8859-1?Q?9m3MxS5B2x8NGZrTOMWviU35U6/jOCL/8EMhgTPBYp4B6kqzHwor2dKMfm?=
 =?iso-8859-1?Q?SYHUO6Yr8gPS28qg/DjOl6ye87KICnX3bZ78J01a/At5lUsWJyIj/ufPzu?=
 =?iso-8859-1?Q?2LS4qBPewMwn2n2BJLpb1xTHtQ3yseE1n53pl+hpY1cw2BYyjPQZDDZ0J8?=
 =?iso-8859-1?Q?HuLWMUT2mdJl7VYnnOVWq37vJmFWga6Mu2k1/xH1TztPshJ9wPQdCHv0+G?=
 =?iso-8859-1?Q?AywsI0zMzAYpQXhde77W4+JCLczW3PPn2hRZQugURbbKwrjhJtpxXr7F1H?=
 =?iso-8859-1?Q?dm4CGJyEsvJKxinMb9BhHWuPhAEXwZ4gt8kkl6pYh/Gqp4a3w71XP0stPz?=
 =?iso-8859-1?Q?YwXBFZC+ImXekQ1RldP7V4yWaiFSC+yE0JTRTKTTJHchYVeTxH+5kWEfXb?=
 =?iso-8859-1?Q?sEtCxdZNDA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: noBYpc6iEeiLzf0oyCmz1BEfxgKJf8n3ujU7bxVPeFZJkdE6Sh09ilmZbrodn/pPlfpw45QlVEGjoyIbQIpjuOc8ON0Jibo/FZ5lz8SewlyayTdTf+7s70LY54zw38AzpbhtrK9p6DkiIp7+tSm6Je8wrWRxamlhNtcntrOBV0dNKKtWTHtFSGD53UQAyGC5jvMnKPyFL21bWA8HEbhAAtTZj2LbGf5pRUS/emg6K9bOvK6u+wHQOTh/BiIGFfrj4lW8/1hOjzawT8trjoNwln06ZLka27Tj70nQ64/9vJpoKMYsubqxFkgscQhCGvcZ+WL2TKD6BElAW7OYpP47oA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff08b16-1622-4acd-2d19-08df38c2d21a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:26.1413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48Fchs8MIibyukMV/pB0heWTnK2bW++l+OVN4BUn2KRoAaWvZzda9XKcfqcZ2tSUsetN6DZkYYoFOIq+KfGwCgkqMNdpfrNnhSxeuCXGnKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB9200
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Interrupt IN is not a request and an answer in usbredir. The host asks=0A=
once with start_interrupt_receiving. After that it expects a packet=0A=
every time the device has data.=0A=
=0A=
Park one IN packet on the device for each streaming endpoint. A device=0A=
that answers USB_RET_ASYNC holds the packet and completes it when it=0A=
has data. A device that answers USB_RET_NAK gives the packet back at=0A=
once, so park a new one when the bus reports a wakeup on that endpoint.=0A=
A slow timer parks one too, for a device that does not report a wakeup.=0A=
A streamed request does not wait on the endpoint's list the way a host=0A=
request does, because this timer already asks again.=0A=
=0A=
Wait for the endpoint's bInterval before parking the next one. Some=0A=
devices answer every time. Without the wait we would ask as fast as=0A=
the main loop runs, and the guest would get no time.=0A=
=0A=
On an error other than a stall the stream stays up, but back off to the=0A=
slow timer. At a high speed bInterval of 125us an endpoint that keeps=0A=
failing would otherwise send thousands of status messages a second.=0A=
=0A=
Give every endpoint its own timer and bottom half. We ask each endpoint=0A=
at its own rate. Drop the timer when the bottom half has already asked,=0A=
so it does not fire for nothing.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 309 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   4 +=0A=
 2 files changed, 308 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 9a83cc22ef..cfd2bcc438 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -96,9 +96,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SER=
VER)=0A=
  */=0A=
 #define USBREDIR_SERVER_MAX_BULK (1 * MiB)=0A=
 =0A=
+/* Buffer size for an interrupt IN endpoint before its descriptor is seen.=
 */=0A=
+#define USBREDIR_SERVER_INTR_STREAM_DEFAULT_LEN 64=0A=
+=0A=
 #define USBREDIR_SERVER_CTRL 0=0A=
 #define USBREDIR_SERVER_BULK 1=0A=
 #define USBREDIR_SERVER_INTERRUPT 2=0A=
+#define USBREDIR_SERVER_INTR_STREAM 3=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
 typedef enum {=0A=
@@ -156,6 +160,15 @@ typedef struct USBRedirServerEp {=0A=
     /* Asks again for a device that does not wake the endpoint. */=0A=
     QEMUTimer *retry;=0A=
 =0A=
+    /*=0A=
+     * Interrupt IN streaming. The timer asks the device again at the=0A=
+     * endpoint's own rate, and more slowly after a NAK or an error.=0A=
+     * The bottom half asks at once when the device says it has data.=0A=
+     */=0A=
+    QEMUTimer *intr_stream_timer;=0A=
+    QEMUBH *intr_stream_bh;=0A=
+    bool intr_streaming;=0A=
+=0A=
     uint16_t max_packet;=0A=
     uint8_t interval;=0A=
     uint8_t iface;=0A=
@@ -184,7 +197,7 @@ struct USBRedirServer {=0A=
     bool host_connected;=0A=
     bool device_announced;=0A=
 =0A=
-    /* Every request the host is still waiting for an answer to. */=0A=
+    /* Every request waiting for the device to answer. */=0A=
     QTAILQ_HEAD(, USBRedirServerPkt) inflight;=0A=
     uint64_t next_id;=0A=
 =0A=
@@ -620,6 +633,97 @@ static void usbredir_server_interrupt_complete(USBRedi=
rServer *s,=0A=
                                     rp->data, actual);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * How long to wait before asking the device again. bInterval means=0A=
+ * different things at different speeds: a number of frames at low and=0A=
+ * full speed, an exponent at high speed.=0A=
+ */=0A=
+static int64_t usbredir_server_intr_stream_period_ns(USBRedirServer *s,=0A=
+                                                     int ep_nr)=0A=
+{=0A=
+    int idx =3D usbredir_server_ep_index(ep_nr | USB_DIR_IN);=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    uint8_t interval =3D s->ep[idx].interval;=0A=
+=0A=
+    if (interval =3D=3D 0) {=0A=
+        interval =3D 1;=0A=
+    }=0A=
+=0A=
+    if (device && device->speed =3D=3D USB_SPEED_HIGH) {=0A=
+        interval =3D MIN(interval, 16);=0A=
+        return (1LL << (interval - 1)) * 125 * SCALE_US;=0A=
+    }=0A=
+=0A=
+    return (int64_t)interval * SCALE_MS;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The device answered a streamed request. Send the answer to the host, th=
en=0A=
+ * ask again, because the host still wants more. Do not ask from here: the=
=0A=
+ * device may answer at once, and this function would call itself over and=
=0A=
+ * over. Arm the timer instead. It also waits for the endpoint's bInterval=
.=0A=
+ */=0A=
+static void usbredir_server_intr_stream_complete(USBRedirServer *s,=0A=
+                                                 USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_interrupt_packet_header resp =3D rp->intr_hdr;=0A=
+    struct usb_redir_interrupt_receiving_status_header st;=0A=
+    int idx =3D usbredir_server_ep_index(resp.endpoint);=0A=
+    int ep_nr =3D resp.endpoint & 0x0f;=0A=
+    USBRedirServerEp *ep =3D &s->ep[idx];=0A=
+    USBPacket *p =3D &rp->pkt;=0A=
+    int actual =3D p->actual_length;=0A=
+    bool retry =3D false;=0A=
+    int64_t delay_ns;=0A=
+=0A=
+    trace_usbredir_server_intr_stream_complete(ep_nr, p->status, actual);=
=0A=
+=0A=
+    switch (p->status) {=0A=
+    case USB_RET_SUCCESS:=0A=
+        resp.status =3D usb_redir_success;=0A=
+        resp.length =3D actual;=0A=
+        usbredirparser_send_interrupt_packet(s->parser, 0, &resp,=0A=
+                                             actual ? rp->data : NULL,=0A=
+                                             actual);=0A=
+        usbredirparser_do_write(s->parser);=0A=
+        break;=0A=
+    case USB_RET_NAK:=0A=
+        /* no data yet; wait, unless the device wakes us first */=0A=
+        retry =3D true;=0A=
+        break;=0A=
+    default:=0A=
+        /*=0A=
+         * The endpoint failed. There is no data, so send a status=0A=
+         * message instead. The host gives it to its guest.=0A=
+         *=0A=
+         * redirect.c ends the stream only on a stall, so do the same=0A=
+         * here. If we end it on any other error, the host still=0A=
+         * thinks the stream runs, and it never asks again.=0A=
+         */=0A=
+        st.endpoint =3D resp.endpoint;=0A=
+        st.status =3D usbredir_server_status(p->status);=0A=
+        usbredirparser_send_interrupt_receiving_status(s->parser, 0, &st);=
=0A=
+        usbredirparser_do_write(s->parser);=0A=
+        if (p->status =3D=3D USB_RET_STALL) {=0A=
+            ep->intr_streaming =3D false;=0A=
+        } else {=0A=
+            /* the stream stays up, but do not ask at the endpoint's rate =
*/=0A=
+            retry =3D true;=0A=
+        }=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    if (ep->intr_streaming) {=0A=
+        if (retry) {=0A=
+            delay_ns =3D (int64_t)USBREDIR_SERVER_RETRY_MS * SCALE_MS;=0A=
+        } else {=0A=
+            delay_ns =3D usbredir_server_intr_stream_period_ns(s, ep_nr);=
=0A=
+        }=0A=
+        timer_mod(ep->intr_stream_timer,=0A=
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -699,6 +803,9 @@ static void usbredir_server_packet_complete(USBPort *po=
rt, USBPacket *p)=0A=
     case USBREDIR_SERVER_INTERRUPT:=0A=
         usbredir_server_interrupt_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_INTR_STREAM:=0A=
+        usbredir_server_intr_stream_complete(s, rp);=0A=
+        break;=0A=
     default:=0A=
         g_assert_not_reached();=0A=
     }=0A=
@@ -738,9 +845,11 @@ static USBRedirServerAsk usbredir_server_ask_device(US=
BRedirServer *s,=0A=
 =0A=
     /*=0A=
      * Keep the request and send it again when the device wakes the=0A=
-     * endpoint.=0A=
+     * endpoint. A streamed request asks again by itself, with its own=0A=
+     * timer.=0A=
      */=0A=
-    if (rp->pkt.status =3D=3D USB_RET_NAK) {=0A=
+    if (rp->pkt.status =3D=3D USB_RET_NAK &&=0A=
+        rp->type !=3D USBREDIR_SERVER_INTR_STREAM) {=0A=
         trace_usbredir_server_nak_park(rp->redir_id, rp->ep_idx);=0A=
         QTAILQ_INSERT_HEAD(&ep->waiting, rp, waiting_link);=0A=
         timer_mod(ep->retry, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=0A=
@@ -786,8 +895,18 @@ static void usbredir_server_wakeup_ep(USBBus *bus, USB=
Endpoint *ep,=0A=
 {=0A=
     USBRedirServer *s =3D container_of(bus, USBRedirServer, bus);=0A=
     uint8_t addr =3D ep->nr | (ep->pid =3D=3D USB_TOKEN_IN ? USB_DIR_IN : =
0);=0A=
+    int idx =3D usbredir_server_ep_index(addr);=0A=
 =0A=
-    usbredir_server_kick_ep(s, usbredir_server_ep_index(addr));=0A=
+    /*=0A=
+     * The device has data. A streaming interrupt IN endpoint may have=0A=
+     * answered NAK. Ask now instead of waiting for the retry timer.=0A=
+     */=0A=
+    if (s->ep[idx].intr_streaming) {=0A=
+        qemu_bh_schedule(s->ep[idx].intr_stream_bh);=0A=
+    }=0A=
+=0A=
+    /* The host may also have a request stopped on this endpoint. */=0A=
+    usbredir_server_kick_ep(s, idx);=0A=
 }=0A=
 =0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
@@ -841,6 +960,95 @@ static void usbredir_server_pkt_free(USBRedirServer *s=
, USBRedirServerPkt *rp)=0A=
     g_free(rp);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Interrupt IN streaming=0A=
+ */=0A=
+=0A=
+static bool usbredir_server_intr_stream_inflight(USBRedirServer *s, int ep=
_nr)=0A=
+{=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    QTAILQ_FOREACH(rp, &s->inflight, inflight_link) {=0A=
+        if (rp->type =3D=3D USBREDIR_SERVER_INTR_STREAM &&=0A=
+            (rp->intr_hdr.endpoint & 0x0f) =3D=3D ep_nr) {=0A=
+            return true;=0A=
+        }=0A=
+    }=0A=
+    return false;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Ask the device for data on @ep_nr and leave the request waiting. A devi=
ce=0A=
+ * sends data only when asked. Do nothing if a request on @ep_nr is still=
=0A=
+ * unanswered.=0A=
+ */=0A=
+static void usbredir_server_intr_stream_park(USBRedirServer *s, int ep_nr)=
=0A=
+{=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    int idx =3D usbredir_server_ep_index(ep_nr | USB_DIR_IN);=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    int len;=0A=
+=0A=
+    /* No device to ask. */=0A=
+    if (!device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* The host did not ask for this endpoint, or a request is unanswered.=
 */=0A=
+    if (!s->ep[idx].intr_streaming ||=0A=
+        usbredir_server_intr_stream_inflight(s, ep_nr)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    len =3D s->ep[idx].max_packet;=0A=
+    if (len =3D=3D 0) {=0A=
+        len =3D USBREDIR_SERVER_INTR_STREAM_DEFAULT_LEN;=0A=
+    }=0A=
+    ep =3D usb_ep_get(device, USB_TOKEN_IN, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len, idx);=0A=
+    rp->type =3D USBREDIR_SERVER_INTR_STREAM;=0A=
+    /* A streamed request comes from us, not from the host. */=0A=
+    rp->redir_id =3D 0;=0A=
+    rp->intr_hdr.endpoint =3D ep_nr | USB_DIR_IN;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, USB_TOKEN_IN, ep, 0, s->next_id++,=0A=
+                     false, false);=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    /*=0A=
+     * The timer is there for a device that does not wake the endpoint.=0A=
+     * We are asking now, so drop it. The answer sets it again.=0A=
+     */=0A=
+    timer_del(s->ep[idx].intr_stream_timer);=0A=
+=0A=
+    trace_usbredir_server_intr_stream_park(ep_nr, len);=0A=
+    usbredir_server_submit(s, rp);=0A=
+}=0A=
+=0A=
+/* BH and timer callback: ask again on one streaming endpoint. */=0A=
+static void usbredir_server_intr_stream_kick(void *opaque)=0A=
+{=0A=
+    USBRedirServerEp *ep =3D opaque;=0A=
+    int ep_nr =3D ep->idx - USBREDIR_SERVER_EP_IN_BASE;=0A=
+=0A=
+    usbredir_server_intr_stream_park(ep->s, ep_nr);=0A=
+}=0A=
+=0A=
+static void usbredir_server_intr_stream_cancel(USBRedirServer *s, int ep_n=
r)=0A=
+{=0A=
+    USBRedirServerPkt *tmp;=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    QTAILQ_FOREACH_SAFE(rp, &s->inflight, inflight_link, tmp) {=0A=
+        if (rp->type !=3D USBREDIR_SERVER_INTR_STREAM ||=0A=
+            (rp->intr_hdr.endpoint & 0x0f) !=3D ep_nr) {=0A=
+            continue;=0A=
+        }=0A=
+        usbredir_server_pkt_free(s, rp);=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * usbredirparser I/O and logging callbacks=0A=
  */=0A=
@@ -1248,6 +1456,63 @@ static void usbredir_server_interface_info(void *pri=
v,=0A=
     /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The host asks to stream an interrupt IN endpoint. Send the receiving=0A=
+ * status first. Without that status the host throws the interrupt=0A=
+ * packet away. Then ask the device once.=0A=
+ */=0A=
+static void usbredir_server_start_interrupt_receiving(void *priv,=0A=
+    uint64_t id, struct usb_redir_start_interrupt_receiving_header *hdr)=
=0A=
+{=0A=
+    struct usb_redir_interrupt_receiving_status_header st =3D {=0A=
+        .endpoint =3D hdr->endpoint,=0A=
+        .status =3D usb_redir_success,=0A=
+    };=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    st.status =3D usbredir_server_ep_status(s, hdr->endpoint,=0A=
+                                          USB_ENDPOINT_XFER_INT);=0A=
+=0A=
+    /* Only an interrupt IN endpoint can stream. */=0A=
+    if (!(hdr->endpoint & USB_DIR_IN)) {=0A=
+        st.status =3D usb_redir_inval;=0A=
+    }=0A=
+=0A=
+    if (st.status =3D=3D usb_redir_success) {=0A=
+        s->ep[idx].intr_streaming =3D true;=0A=
+    }=0A=
+=0A=
+    trace_usbredir_server_intr_stream_start(hdr->endpoint, st.status);=0A=
+    usbredirparser_send_interrupt_receiving_status(s->parser, id, &st);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    if (st.status =3D=3D usb_redir_success) {=0A=
+        usbredir_server_intr_stream_park(s, ep_nr);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_interrupt_receiving(void *priv, uint64_t =
id,=0A=
+    struct usb_redir_stop_interrupt_receiving_header *hdr)=0A=
+{=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    trace_usbredir_server_intr_stream_stop(hdr->endpoint);=0A=
+=0A=
+    /* Endpoint 0 is control, and an OUT endpoint never streams. */=0A=
+    if (ep_nr =3D=3D 0 || !(hdr->endpoint & USB_DIR_IN)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->ep[idx].intr_streaming =3D false;=0A=
+    qemu_bh_cancel(s->ep[idx].intr_stream_bh);=0A=
+    timer_del(s->ep[idx].intr_stream_timer);=0A=
+    usbredir_server_intr_stream_cancel(s, ep_nr);=0A=
+}=0A=
+=0A=
 static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
     struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
 {=0A=
@@ -1273,6 +1538,14 @@ static void usbredir_server_cancel_data_packet(void =
*priv, uint64_t id)=0A=
     int idx;=0A=
 =0A=
     QTAILQ_FOREACH(rp, &s->inflight, inflight_link) {=0A=
+        /*=0A=
+         * A streamed request comes from us, not from the host.=0A=
+         * The host has no id for it, so a cancel never matches it.=0A=
+         */=0A=
+        if (rp->type =3D=3D USBREDIR_SERVER_INTR_STREAM) {=0A=
+            continue;=0A=
+        }=0A=
+=0A=
         if (rp->redir_id =3D=3D id) {=0A=
             idx =3D rp->ep_idx;=0A=
 =0A=
@@ -1348,6 +1621,12 @@ static void usbredir_server_stop_transfers(USBRedirS=
erver *s)=0A=
         timer_del(s->ep[i].retry);=0A=
     }=0A=
 =0A=
+    for (i =3D USBREDIR_SERVER_EP_IN_BASE + 1; i < USBREDIR_SERVER_MAX_EP;=
 i++) {=0A=
+        s->ep[i].intr_streaming =3D false;=0A=
+        qemu_bh_cancel(s->ep[i].intr_stream_bh);=0A=
+        timer_del(s->ep[i].intr_stream_timer);=0A=
+    }=0A=
+=0A=
     /*=0A=
      * No "cancelled" response here. This runs on a bus reset, a detach or=
=0A=
      * a closed chardev, and the host has dropped its own queues already.=
=0A=
@@ -1393,6 +1672,10 @@ static void usbredir_server_create_parser(USBRedirSe=
rver *s)=0A=
     s->parser->device_disconnect_ack_func =3D=0A=
         usbredir_server_device_disconnect_ack;=0A=
     s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
+    s->parser->start_interrupt_receiving_func =3D=0A=
+        usbredir_server_start_interrupt_receiving;=0A=
+    s->parser->stop_interrupt_receiving_func =3D=0A=
+        usbredir_server_stop_interrupt_receiving;=0A=
     s->parser->alloc_bulk_streams_func =3D usbredir_server_alloc_bulk_stre=
ams;=0A=
     s->parser->cancel_data_packet_func =3D usbredir_server_cancel_data_pac=
ket;=0A=
     s->parser->start_bulk_receiving_func =3D=0A=
@@ -1535,6 +1818,16 @@ static void usbredir_server_realize(DeviceState *dev=
, Error **errp)=0A=
         s->ep[i].retry =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=0A=
                                       usbredir_server_retry_ep, &s->ep[i])=
;=0A=
     }=0A=
+=0A=
+    /* Only an interrupt IN endpoint streams, so endpoint 0 and OUT are ou=
t. */=0A=
+    for (i =3D USBREDIR_SERVER_EP_IN_BASE + 1; i < USBREDIR_SERVER_MAX_EP;=
 i++) {=0A=
+        s->ep[i].intr_stream_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=0A=
+                                             usbredir_server_intr_stream_k=
ick,=0A=
+                                             &s->ep[i]);=0A=
+        s->ep[i].intr_stream_bh =3D=0A=
+            qemu_bh_new_guarded(usbredir_server_intr_stream_kick, &s->ep[i=
],=0A=
+                                &dev->mem_reentrancy_guard);=0A=
+    }=0A=
     s->config_descs =3D g_hash_table_new_full(g_direct_hash, g_direct_equa=
l,=0A=
                                             NULL, g_free);=0A=
     usbredir_server_clear_ep_table(s);=0A=
@@ -1545,7 +1838,6 @@ static void usbredir_server_realize(DeviceState *dev,=
 Error **errp)=0A=
     usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       USB_SPEED_MASK_HIGH);=0A=
-=0A=
     s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
                                               s, &dev->mem_reentrancy_guar=
d);=0A=
     s->announce_bh =3D qemu_bh_new_guarded(usbredir_server_announce_device=
, s,=0A=
@@ -1582,6 +1874,13 @@ static void usbredir_server_unrealize(DeviceState *d=
ev)=0A=
         timer_free(s->ep[i].retry);=0A=
         s->ep[i].retry =3D NULL;=0A=
     }=0A=
+=0A=
+    for (i =3D USBREDIR_SERVER_EP_IN_BASE + 1; i < USBREDIR_SERVER_MAX_EP;=
 i++) {=0A=
+        timer_free(s->ep[i].intr_stream_timer);=0A=
+        s->ep[i].intr_stream_timer =3D NULL;=0A=
+        qemu_bh_delete(s->ep[i].intr_stream_bh);=0A=
+        s->ep[i].intr_stream_bh =3D NULL;=0A=
+    }=0A=
 }=0A=
 =0A=
 static const Property usbredir_server_props[] =3D {=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 5ec5127efa..6eb47085d0 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -423,3 +423,7 @@ usbredir_server_bulk_too_big(uint64_t id, uint8_t ep, u=
int32_t len) "id %" PRIu6=0A=
 usbredir_server_refused(uint64_t id, uint8_t ep, int status, uint8_t want,=
 uint8_t got) "id %" PRIu64 " ep 0x%02x status %d, wanted type %u, it is %u=
"=0A=
 usbredir_server_interrupt(uint64_t id, uint8_t ep, size_t len) "id %" PRIu=
64 " ep 0x%02x len %zu"=0A=
 usbredir_server_interrupt_complete(uint64_t id, uint8_t ep, int status, in=
t actual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
+usbredir_server_intr_stream_start(uint8_t ep, int status) "start_interrupt=
_receiving ep 0x%02x -> status %d"=0A=
+usbredir_server_intr_stream_stop(uint8_t ep) "stop_interrupt_receiving ep =
0x%02x"=0A=
+usbredir_server_intr_stream_park(unsigned ep_nr, int len) "parked IN packe=
t ep %u len %d"=0A=
+usbredir_server_intr_stream_complete(unsigned ep_nr, int status, int actua=
l) "ep %u status %d actual %d"=0A=
-- =0A=
2.43.0=0A=

