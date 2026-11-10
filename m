Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4B606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=GjTptf40
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgIP-0000qk-7U; Tue, 10 Nov 2026 02:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgIM-0000oO-7W; Tue, 10 Nov 2026 02:29:30 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgIK-0005V4-Ai; Tue, 10 Nov 2026 02:29:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udn8TnD1DFNREjoSq0cSJTDePXg9N9U4JYWazw6biJJvQO1BiHKY0SibruQaTB+0bAUQgtgOQr68hb8qVxoxg2RYHv4s07hdfF3yd44nH80PbYKhIoQKmoqKdacK/XjcWQ2lhiDC7rrB5WfkPFhd0lTOyJPZ/QNTiCTxDKgETUBEorFgXAS1/FEAfE8AyIpV41Fglwss/k7nCqvWhcYvJxNZIJQdg5++BTteV88is2uRUKjvTqNCqxYKTf+OYr6k48fr9syVR4QQBYwWcwDzzIA0GyoPcUz/YSZAryf9pOxXfctNtXDby0jcND1bLfhbMe57TB5iNywDlLJVEE9qlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=056yUTVyfKlGHxdsNSqrWJc8llsFMInFPEs2cXJPH5s=;
 b=u1KFBp/mHh9+pNO0wmsd9e2TH4eSo/5lz/UqDfqrPXIhiCr0tJ1qPKxjhnMrdm9K3JVsy9qAN+zrzDXhhDF55bwxlA2RElQLEWSMIeitPBqUVy1xi7YfkyuvtfXqKdW33q1IMlYX7DnOoSyXyxOFSSSub0uv5wEFjUW+UJExxyPIercroc4JT2w6zVkbe8YN3wtnqcLeme8UjKqTMjHTImUiDBnG7IxpyeY88bDJA+ccMpezdKj5IYB5uhTmKo304oYKRg53ae4EkAGYYy6Y6YgnMVEX5UKWAtbnGY5OEV1MFfU9y9RFL0qpwNEzBtaSt28PpT+EtMe5K4whNQDcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=056yUTVyfKlGHxdsNSqrWJc8llsFMInFPEs2cXJPH5s=;
 b=GjTptf40YhUlDrSa82eATAi0BP8pIU8PLmVoW2PNX2uVbpdgzOEF8DqyusGHYyIP3Zjd7vLBI3BDnpAmvFHamHrqsL2uNYZDm//NlaQ5R1dI09Av7Rvw0v/BL54oOgLRTWwhqeeimIPER82WAujUpSQuLJpBrgcSeJ/prhkqelp00Lch9YzTXmf8ARsTosXSR5i03dMfKn62Np2GkkaH06q/y6wZdQJiLOSqkR35h4YUiQq3jYt6X7KaA1jxZAuA3e9E6STXYmjXtzVLr8kXjCwNNpE+VQtnAzQpug9rb1eoJxhw8e7tyxjN2Z0ECZe9Qi2q54T8OtGmHpaI8Zpy5w==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:38 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "berrange@redhat.com" <berrange@redhat.com>, "junjie.cao@linux.dev"
 <junjie.cao@linux.dev>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "clg@kaod.org"
 <clg@kaod.org>, "junjie.cao@intel.com" <junjie.cao@intel.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
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
Subject: [PATCH v9 13/19] hw/usb/redirect-server: Announce the exported device
Thread-Topic: [PATCH v9 13/19] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdcOUa3JZw4eVrrEKd2bGx9BdwrA==
Date: Tue, 10 Nov 2026 07:28:38 +0000
Message-ID: <20261110072818.2883349-14-jamin_lin@aspeedtech.com>
References: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8987:EE_
x-ms-office365-filtering-correlation-id: d1d63618-8a75-4755-3659-08df3efc3cd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|6133799003|10067099003|3023799007|921020|38070700021|5023799004|56012099006|261102123227099003|261102130727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info: TyL/TvjsvSoQ++xWSjIJIE/l4RwFtGtqFOGyykytQDAIqkdehXqIEPDy0oY6yvOJ5s3f+3J0HvRtTel41MerBFaq6J8iBybyg9RmZPcC7L2Uj41FEnEztOZacZicCPY8WGlhZl9a+Pt8ZsSnpEEPCXuS6DiwqaLQL+55E+TtrohXqPwIzwpidVcS8tPbTSsbsHgqFQvtlkaifsA58aVrx3+6Rk7q1rAgmVhR6Tkj4FRc+pksF7IxIYGH7jJhMDFmbIG0lMV2vpfiUm1tqcWBGe+ksYwiiARxSvwULsm+Wio0b1YyeRQlTViK7LG8imsEZUuxhJlMhgO3uFSLSH33clG78e3hpypAK+nEZ1glGgWjTeq/R1e1/NzqUpWln+5wQzZzFvE1K+/O0YorQKLdGzdiaegUVMS1MWh1IBTR6E1JT8g+OqH1ERhdVbjB7USNKgLDgFL+W6zpTWDJxKc3A/+6Pg+kDZEX7v1nFtke0YTU3KKFQsDBI3OLWDwB6dtWKS9VFufm/OEEMnRDUwfyTjXSYgMmzya9boGAJVTbuLodkUW6GljiCJIWaM7mFD5LITw0r95e1dG9kES1Kd4hY1Xyt1hE0GIwuxNv8Z0ga+B15bV7Km9UuIhWbExwwF369N9BcpNGBgc8syntkqBgdAWKHZq6h/zikL54p3qdkC1Eu92rOG8aMAzxFdoNRIkiHYhgV2byIEoQmIF72hvnjugoFDEjjjYHxMbW5sZASh+r4Qml0spobu/S5Z8PnskV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(921020)(38070700021)(5023799004)(56012099006)(261102123227099003)(261102130727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZK827AHPckYC+Hz/6yT4VU4VLUeaiM2z/897ZfCx9/TdoB+InWL3xhVj5X?=
 =?iso-8859-1?Q?ju40O/TF/Sy9I9ptrKaN4HbRd6+UjP/QDpeo+i9+5lDyUMpaEPQ3E4XWWq?=
 =?iso-8859-1?Q?iuOti/1jPaqNMu1Vl7wI7X1iC671eWF3Z24tEtHtZgyWYgOqvN8EfAgOT5?=
 =?iso-8859-1?Q?XXTNvVe1IB/MwLUKnVRqr6QSpcnr+w+alpLHf6PGHaBMetDV5guVrgbvPm?=
 =?iso-8859-1?Q?OpCLG9bZ01Qn9/4hPtqForct/v+sWJhkTMZmqNft7ATPWA8bSe+PMD20wh?=
 =?iso-8859-1?Q?rR50og2D+0NPthMEFXS2qyUfrvJX3FOpmJEKSzWiRyQT/kY8PHUy604o8w?=
 =?iso-8859-1?Q?cs3Ue7bgh//y5xOp1LJUSvaFMZH1Z2n8+oXZYWkvh6z9DgVDBsejgusJHi?=
 =?iso-8859-1?Q?P4Y++tNoQsSlxAS6Q+LmNIgzkNgfSlC+EJiy0ohZbuKGWxyZDlGwGTiBRP?=
 =?iso-8859-1?Q?M+0PTpGJsR33MmGWv2G7foRsn4UQ7w3NutDAro4DydY0Gbcxw+S9IEp5/G?=
 =?iso-8859-1?Q?vqsopcOTZ8FjfVcy84iZSCtX+fAAUAitcmYJaZitLSXAWBeOiqLQ9BgEBp?=
 =?iso-8859-1?Q?TK1OkT8Z8C89CQpH1sS0NvYxZrCPUPCnYWj4E9qv2sXWxJzCDt7QbfS+r8?=
 =?iso-8859-1?Q?NyojsFljSRNT9xKrU1vxZIRh/A0b6QAuMyNvPGIKmzhONfqDZvHRsipXy5?=
 =?iso-8859-1?Q?0LtPRxL4cBXTeBLVWlex+6g+rVKEReyBl8f9weXHi2u+bG0R5xXt9dc+H6?=
 =?iso-8859-1?Q?GKnVGgboWPwxF1xw47TCwERHvuZMAZdhgsWVxDQGBaMyLRo6rV6K3ytc2w?=
 =?iso-8859-1?Q?IjwSlZgj59Ti6c8KYUnuWXmZiViRWsS4OlyGOZHpLKgV4Kld45Ik6xVXFX?=
 =?iso-8859-1?Q?Iiw3jMKWKcy7DAHh6MiEAm16z+KEgHpeO86NkeEWFrDwoeGL4hHErwfVAR?=
 =?iso-8859-1?Q?mMQtHNIGELObjf3k8biuPTx3RIYStsA+UAiQ0fKv16sWaJmiIl1qD29Yng?=
 =?iso-8859-1?Q?j1+WQv5i0p9Ttn+Lk0FHpGd9n0VGv61Qmv60Kvvelihu/1RYsBjc2kDmV3?=
 =?iso-8859-1?Q?nBI+9KOhPhcEfb+EjCfpS9wjXFbyv/RMPmErBlWIzkqn+ADxZRZmXDybSS?=
 =?iso-8859-1?Q?Cn/N4OKP2zIHv11wP6Hkh/U2s1nzjWsQCvgrRgTn6fbt9YBzfFLY13t+up?=
 =?iso-8859-1?Q?KSh0Rd/A8wzmFlbpCEgHD19tUA9Th3egvGS8N7c2+uI4w1pspbDey9S08n?=
 =?iso-8859-1?Q?LX5WZiGrD/QWTY5C8HNCwGNfONdWWAgN8MCrN/Cq9tC5CMJRA4S73aLZim?=
 =?iso-8859-1?Q?stv54UpkVMiFZhHdDrqPariW1pOx/njMcmTIjZcqn0qjc7zQzvjlGSlRFI?=
 =?iso-8859-1?Q?585gE1iHzdln8dT0WYBOwzyGi6ctQW235XRki4WLlP01O/21NqtzAfchcW?=
 =?iso-8859-1?Q?MY6ElJstcdeoI1eUDyTdj8B4oljzOpN0aSBP6vOZtvfqpF7r43JdlY6CkZ?=
 =?iso-8859-1?Q?mtRjom/o8czYxpJjooEhyKEj1O1YL3PTS+DEmiRKH8BP3hI40PvbKnj0dz?=
 =?iso-8859-1?Q?0xTkx0+ar2MJQCBvLiAHsiFQZmVY42Adl4nDUdrfySLZFTeNci+UzXyRWy?=
 =?iso-8859-1?Q?0hRjJokNepSjlDZ9/Pm0tPuIuaQueSZi4b1oEHp8dKvLVLEq4xduC/4GsU?=
 =?iso-8859-1?Q?PAQL6QC5shFqEonWOHcSVUDMhitwENyqVIfuIjRkVtHdTkzft89g48UVTn?=
 =?iso-8859-1?Q?2tvinPTFnbFELeLgbt4nD0lpFSsglv9mJ10KEcr1QZsnQd4yVzuCiPLmlY?=
 =?iso-8859-1?Q?/Jrocr3Kcw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xxm/Mr8MNHs/VOe/VqcF1/t9ce+2R06Q7H47Vy0U5NZ53prgd3h7VRG0vpnvL6plKKMeQfLVs+PCkpi+7stCxb0NZUl9DZLyeAp9w1OSstj5Gyg7qRblPpCNqdb3OmMHFTIa9SMylKBNZQd2VM7OHw0CwGQMqmeS1032GPx2R52VcVfLwBBpbosDsylrfi39fWXK85tCICHhklcrt9ggGaxmWHMGfmGx/oqLFe40VKq7YBxymtV/dC3nh2H93wxNCsyyNivkHrB6/cI7pI06WaWfij+npIp7WRMUjqwvn3bBBN+mPhIGsDJxMPdDgyrg+YljRybBmKvXNYG2VNN1Cg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d63618-8a75-4755-3659-08df3efc3cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:38.3136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsmg3L1C+5zDJ/dzyAFw0PxhYxTEe33nE70TniPdZtvxyR50m0lH0sUFQeywqmk11pFQOQffBKBUvC6BdxMQS59uLDh/RytJa2azdI+c7GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8987
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

Send device_connect when a device is attached and the host has greeted=0A=
us, device_disconnect when it goes away, and handle the bus reset the=0A=
host sends before enumerating.=0A=
=0A=
device_connect carries no identity. The peer asks the device itself with=0A=
GET_DESCRIPTOR as soon as it enumerates, so anything we put there would=0A=
be made up. The speed is real: it comes from the device on our port.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 136 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   6 ++=0A=
 2 files changed, 141 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 5abaf7e01e..5a3b01c337 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -56,6 +56,7 @@=0A=
 #include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "qemu/cutils.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
 #include "chardev/char-fe.h"=0A=
@@ -85,17 +86,91 @@ struct USBRedirServer {=0A=
     /* usbredir over the chardev */=0A=
     struct usbredirparser *parser;=0A=
     QEMUBH *chardev_close_bh;=0A=
+    QEMUBH *announce_bh;=0A=
     const uint8_t *read_buf;=0A=
     int read_buf_size;=0A=
     bool in_write;=0A=
     guint watch;=0A=
     bool host_connected;=0A=
+    bool device_announced;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * The device is whatever USBDevice the user plugged into our port with=0A=
+ * "-device <device>,bus=3D<id>.0". NULL until then.=0A=
+ */=0A=
+static USBDevice *usbredir_server_device(USBRedirServer *s)=0A=
+{=0A=
+    return s->port.dev;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Device announcement=0A=
+ */=0A=
+=0A=
+static uint8_t usbredir_server_speed(USBDevice *device)=0A=
+{=0A=
+    switch (device->speed) {=0A=
+    case USB_SPEED_LOW:=0A=
+        return usb_redir_speed_low;=0A=
+    case USB_SPEED_FULL:=0A=
+        return usb_redir_speed_full;=0A=
+    default:=0A=
+        return usb_redir_speed_high;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_announce_bh(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    struct usb_redir_device_connect_header conn =3D {};=0A=
+=0A=
+    if (!s->host_connected || s->device_announced ||=0A=
+        !device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+    s->device_announced =3D true;=0A=
+    conn.speed =3D usbredir_server_speed(device);=0A=
+=0A=
+    usbredirparser_send_device_connect(s->parser, &conn);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
 =0A=
+static void usbredir_server_port_attach(USBPort *port)=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+=0A=
+    trace_usbredir_server_attach();=0A=
+=0A=
+    /*=0A=
+     * usb_attach() sets the state to ATTACHED after this returns.=0A=
+     * A device needs DEFAULT state before it can serve a request.=0A=
+     * The BH runs after usb_attach(), so the device stays in DEFAULT.=0A=
+     */=0A=
+    qemu_bh_schedule(s->announce_bh);=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_detach(USBPort *port)=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+=0A=
+    trace_usbredir_server_detach(s->device_announced);=0A=
+=0A=
+    qemu_bh_cancel(s->announce_bh);=0A=
+=0A=
+    if (s->host_connected && s->parser && s->device_announced) {=0A=
+        trace_usbredir_server_disconnect();=0A=
+        usbredirparser_send_device_disconnect(s->parser);=0A=
+        usbredirparser_do_write(s->parser);=0A=
+    }=0A=
+    s->device_announced =3D false;=0A=
+}=0A=
+=0A=
 static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
 {=0A=
     /* We only export the device on our own port. Nothing to do. */=0A=
@@ -107,6 +182,8 @@ static void usbredir_server_port_wakeup(USBPort *port)=
=0A=
 }=0A=
 =0A=
 static USBPortOps usbredir_server_port_ops =3D {=0A=
+    .attach =3D usbredir_server_port_attach,=0A=
+    .detach =3D usbredir_server_port_detach,=0A=
     .child_detach =3D usbredir_server_port_child_detach,=0A=
     .wakeup =3D usbredir_server_port_wakeup,=0A=
 };=0A=
@@ -211,13 +288,53 @@ static int usbredir_server_write(void *priv, uint8_t =
*data, int count)=0A=
     return ret;=0A=
 }=0A=
 =0A=
-/* The remote host greets us once the socket is up. */=0A=
+/*=0A=
+ * usbredirparser message callbacks=0A=
+ */=0A=
+=0A=
 static void usbredir_server_hello(void *priv,=0A=
                                   struct usb_redir_hello_header *hello)=0A=
 {=0A=
     USBRedirServer *s =3D priv;=0A=
+    char version[sizeof(hello->version) + 1];=0A=
+=0A=
+    pstrcpy(version, sizeof(version), hello->version);=0A=
+    trace_usbredir_server_hello(version);=0A=
 =0A=
     s->host_connected =3D true;=0A=
+    qemu_bh_schedule(s->announce_bh);=0A=
+}=0A=
+=0A=
+static void usbredir_server_reset(void *priv)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    trace_usbredir_server_bus_reset(device && device->attached);=0A=
+    usb_device_reset(device);=0A=
+}=0A=
+=0A=
+static void usbredir_server_filter_reject(void *priv)=0A=
+{=0A=
+    trace_usbredir_server_filter_reject();=0A=
+}=0A=
+=0A=
+static void usbredir_server_filter_filter(void *priv,=0A=
+    struct usbredirfilter_rule *rules, int rules_count)=0A=
+{=0A=
+    /* We accept any host. The callback owns the rules, so free them. */=
=0A=
+    free(rules);=0A=
+}=0A=
+=0A=
+static void usbredir_server_device_disconnect_ack(void *priv)=0A=
+{=0A=
+    /* The host saw our device_disconnect. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_interface_info(void *priv,=0A=
+    struct usb_redir_interface_info_header *hdr)=0A=
+{=0A=
+    /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -241,6 +358,14 @@ static void usbredir_server_create_parser(USBRedirServ=
er *s)=0A=
 =0A=
     /* Callbacks for messages the remote host sends to us */=0A=
     s->parser->hello_func =3D usbredir_server_hello;=0A=
+    s->parser->reset_func =3D usbredir_server_reset;=0A=
+=0A=
+    /* The parser calls these directly, so they must not be NULL. */=0A=
+    s->parser->filter_reject_func =3D usbredir_server_filter_reject;=0A=
+    s->parser->filter_filter_func =3D usbredir_server_filter_filter;=0A=
+    s->parser->device_disconnect_ack_func =3D=0A=
+        usbredir_server_device_disconnect_ack;=0A=
+    s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
 =0A=
     /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
@@ -268,7 +393,9 @@ static void usbredir_server_create_parser(USBRedirServe=
r *s)=0A=
 static void usbredir_server_destroy_parser(USBRedirServer *s)=0A=
 {=0A=
     s->host_connected =3D false;=0A=
+    s->device_announced =3D false;=0A=
 =0A=
+    qemu_bh_cancel(s->announce_bh);=0A=
     g_clear_handle_id(&s->watch, g_source_remove);=0A=
 =0A=
     if (s->parser) {=0A=
@@ -372,6 +499,8 @@ static void usbredir_server_realize(DeviceState *dev, E=
rror **errp)=0A=
 =0A=
     s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
                                               s, &dev->mem_reentrancy_guar=
d);=0A=
+    s->announce_bh =3D qemu_bh_new_guarded(usbredir_server_announce_bh, s,=
=0A=
+                                         &dev->mem_reentrancy_guard);=0A=
 =0A=
     qemu_chr_fe_set_handlers(&s->cs,=0A=
                              usbredir_server_chardev_can_read,=0A=
@@ -391,6 +520,11 @@ static void usbredir_server_unrealize(DeviceState *dev=
)=0A=
         qemu_bh_delete(s->chardev_close_bh);=0A=
         s->chardev_close_bh =3D NULL;=0A=
     }=0A=
+=0A=
+    if (s->announce_bh) {=0A=
+        qemu_bh_delete(s->announce_bh);=0A=
+        s->announce_bh =3D NULL;=0A=
+    }=0A=
 }=0A=
 =0A=
 static const Property usbredir_server_props[] =3D {=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index d141661673..075a9d9eae 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -399,3 +399,9 @@ usbredir_server_chardev_open(void) "chardev opened"=0A=
 usbredir_server_chardev_close(void) "chardev closed"=0A=
 usbredir_server_write_recursion(void) "recursive write, leaving it queued"=
=0A=
 usbredir_server_log(const char *msg) "%s"=0A=
+usbredir_server_hello(const char *version) "peer is %s"=0A=
+usbredir_server_attach(void) "device attached"=0A=
+usbredir_server_detach(bool announced) "device detached, was announced %d"=
=0A=
+usbredir_server_disconnect(void) "device_disconnect sent"=0A=
+usbredir_server_bus_reset(bool attached) "bus reset, attached %d"=0A=
+usbredir_server_filter_reject(void) "host rejected our device"=0A=
-- =0A=
2.43.0=0A=

