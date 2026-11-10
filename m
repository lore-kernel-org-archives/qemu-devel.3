Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF63606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=C0d7LtFZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgIB-0000IE-Lt; Tue, 10 Nov 2026 02:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgI9-0000Aq-Fa; Tue, 10 Nov 2026 02:29:17 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgI6-0005Y6-FH; Tue, 10 Nov 2026 02:29:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ2C6S4h41vev8q+Me5OioYkFx6hOlg6+f6EpMladxui0lW8wDP0aw7h94eqQX2C+T6RSRzixPYbeERP2t6Khb6z55TSOtog+yaYYqk4QYoj4BhkcjcK1VxLmx4Sr/7+s+QS/TPFGHBp6ocB5GX3dziskeOSVSaNdNPw94Ygt/6r+HDWSi/a7P9XW6F0sGUFavQL+99dc8UMQEIAO0ZNCDeCPKQlmVbqOaCqdo6wHl7ITay2K8pCkOi179CkUdytG9j19ZgqnpKls1kt+Kjo4TNr8J/6eWlY0kDm8kpib3xaV8Dgm9fJw0GSlny5Ji2AVbjIdwITMBk41MbRV9MyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI8yPxr/rw7awblwX3+1p7CvTSlepP7Vcsoed2BPtCU=;
 b=L2Y/T3pzibwqysLesdi+mv3yw/+03LDZSV/FhfkG3IgaMXuQtm9dsqDVkmbFszGX4CvY4HeqE6ReZf7glTpQTkm7ig+dLMmLdJHsqc8Z/EK6nf4TAma766HXIuY2QHxg4fcpbA79wj7xu/riC7tqFxD7y2ojBGt3K8bNFkdqk9gZA1d2bdbpvlSKad8C3g90SBKC8kBIvDV2O27OYLxBIOxvUwaUjwvJnq5kXSiLKN2FL97K3pY6oQIoxD3LJYm/dkON5leqd0m/KcEmIya6MHvUZP60WOGz8R9oj2Rc++Z3h9tUNTJ30gEIB5V4AfLiPPNLAVHZcTwyorJwmkDtrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI8yPxr/rw7awblwX3+1p7CvTSlepP7Vcsoed2BPtCU=;
 b=C0d7LtFZnaFRqQMa4eFPGfCDj56rI7dy1Zu71cjRpihdAbIUKdsdVkIjU/bFRKTHPkOyMxkmbdpHuRPCD3AWW1h1iWMTBafTiczkRG1DEYlBq5on1pViYx4ByoC+EfLuR3SF0FOTHnxX5id98buFePX3LNLfGpe6pb23xkROnpdBNa1HIFG4dhT/cKxAIP9Zr6tLAwS535M8hw48fxcZ6jTDV+uhvf18yIa8YvNlUxKg93BwRX1JkRBq84ZnPT8Qu2vYqnBrg/H2xXLmR/45drv/AFHwhM1ZpcndmrmCETi0eDzhV1SNP42NxF/9pKJD/Nx/rwesdFKC2GiNW7SW1g==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by PS1PPFE8625B3B1.apcprd06.prod.outlook.com (2603:1096:308::26b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Tue, 10 Nov
 2026 07:28:44 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:43 +0000
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
Subject: [PATCH v9 17/19] hw/usb/redirect-server: Stream interrupt IN endpoints
Thread-Topic: [PATCH v9 17/19] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Index: AQHdcOUdZKEpc4NYaUGzPtpb01F11A==
Date: Tue, 10 Nov 2026 07:28:43 +0000
Message-ID: <20261110072818.2883349-18-jamin_lin@aspeedtech.com>
References: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|PS1PPFE8625B3B1:EE_
x-ms-office365-filtering-correlation-id: aad416d6-a757-45f1-1229-08df3efc4031
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|261009223027099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022113327099003|261022075727099003|261022105027099003|5023799004|56012099006|10067099003|18002099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info: sEAU1/kWfNmVdSIzjBl85A+XAfv3eaToIHHa54zwkB3RybUWAngWaObHxf1KzTE03YLliQKZBTVWm3mBpspQnElGRwc2g1pLwNWAkDKioBX/0UhVhL6EP2X0mGz1YkQXm2hojoqG1cYYV97r0Mn1oeL8aMv8ReHWHk6v6TXnIxX7aLXbHzsNIs9X3aHOxUjuJu+EFKBiEJett+bTDgKzPrpw4sDtS/OHRAmPA5dwLinTgQedDj60UtrZI59A7tZ+GTPxEWJPGfKTXCc6vTW5FAtBteawkwqXS3v+6rsUkXZhLZlq/x1IkTwWMus8q9Y7jU3dclm/ffHnnpnv98zkk/0A3yL+EuJkseKRxuy7FzJSVonaHn5rQgBTppEIhw+mpWgehevG/no0ASqoGslafua0mlMLe3tiIilqjzQ4b3EMzKYJzqoVC0RZKa7VnJ76Ilvh9H01Wig76SfceqaJJ+pK1wq1GQVVnAKMxXc+s+dFla3VuFmaagJvn72mBKICArqgisI9Jk3ophb50sM7WjnZp7GyDLWL9bAhKHM0zeWDw/NzRKqJHB05f5dqcnOE6S4ejt7W4BurLYea9FBld8KTyGOULye2IHqujQch/jyzhJ+gimYUWXXw9kk8cw346K7Rafv36U09DoLl34nID+No9qjEqwPKVM5R8EOOKVhO5TJKo9CW3q6m5FrTZ24Ogep3fC9HhpWCRY4WUxmLMVfmNy0Ff+fORAuimBwoUPs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022113327099003)(261022075727099003)(261022105027099003)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lHkA6vcnVStGOx7sxCXmfGKqusw7M8t75QyBah7V8/YoAI2ytX3iDrPX+Y?=
 =?iso-8859-1?Q?08oNUDBZOs25/GYKYOw0F3NtXQETKJERl5aWLfW7ijeqFEl4CRpbFuuiHu?=
 =?iso-8859-1?Q?1odIZ1zSduoZqZWyzAxoQzAqWlxVZpY13e91twwvq1eAXIMIgmALgD49p3?=
 =?iso-8859-1?Q?3VReXt+PtWB2BdJwuf7BAkzXE5kIL0oNRHeyoW4GH1KnyOoAd8FzoOlVUU?=
 =?iso-8859-1?Q?yG3pHYq7wUGXggvCBqok2Ir5KykgGrz9DsWFIgpttBMHd09RnScdvCncvA?=
 =?iso-8859-1?Q?8ui3Yg4/Nl2sE2lfGbEPEEWcs/AdTRm2WFweP0ZDkrltyABtCG82nC/BPz?=
 =?iso-8859-1?Q?2efUciEp45LCYcGpFJAUOqztoRGMFUlJpD2r8hfXurLNmvlCk1VeuCMBML?=
 =?iso-8859-1?Q?tZ29Gn3bWv+wMO9EIDrUMShx3w4pxJA2aZule7+6avxkfpeuM3jjrTO+rB?=
 =?iso-8859-1?Q?LB/6xkFRzT27aDHb0cWbOzl9scB06C9GHGeSgrh3bmwtD7XdfF4/mHvUrM?=
 =?iso-8859-1?Q?rX9f7NQiT7TqsAlFSKft2KGzIQv5GfMGJZayy1TqykgoQsQD0/LkC5N/cG?=
 =?iso-8859-1?Q?OIb6nUPXwzb6BJqb5TNyDmyX3AfLP0TfW+7eb/ns34tvzslxQRVKO4ahx4?=
 =?iso-8859-1?Q?BSXvymOXzsDU1svAgfyD+l3zkoOfG/OTNLslcYAARAbPwmwRD3saEPsMwa?=
 =?iso-8859-1?Q?2xv/zHh44eUoexrfgLP+n7+TSb0aM5FgxBwzXkG93kO0jNOzmsd1HIUWkY?=
 =?iso-8859-1?Q?OyQYv9rHjJ5IBCJbLVMQhmXMmD5qOS6jCSi9UVJOYpN6bQYxYACQAjsYxu?=
 =?iso-8859-1?Q?jxgQmLoli/iKM8dmibFvuTHGgaoHBXgVTPU1HoEE9i0L0qg0ypoVpWGQNU?=
 =?iso-8859-1?Q?RwEG3zpOTqfsOJB5hgRvLQalvt0Hw1bTWP3IxFS924FWyL0SnOyO4KSiPe?=
 =?iso-8859-1?Q?04oMUDVTlOFtb8AxtSJyTJRNbjt0hS+t8lkOJ28KRDdV5bJy8e/HliyUZU?=
 =?iso-8859-1?Q?gSDh2EU6AhBlL8grXUllTFADNk7dUVdsQv+eTXK5l+bL7UVaQN5EsNqXuX?=
 =?iso-8859-1?Q?bn1kSS8Wvm9sXt178wy7Gpmw8A16qPplYyiYFVlbeDfPx3tYfIps7qA4yx?=
 =?iso-8859-1?Q?JTXXqU6WjUZmv7SUbLuIN571tcatjbgBJ0GnitqnTKNRPQrEEShUSpXMWp?=
 =?iso-8859-1?Q?y3ZXqXO7I4Yh473qscRfhGipifj1MxZLLyoodsVYkAid+IVTqmi4GyTSQ5?=
 =?iso-8859-1?Q?ChW9AF3q/eYo45OK6xwNvhR50fTE6C+pUNdS3O540saKeE2PXZiL28hHT+?=
 =?iso-8859-1?Q?KUq89rkF7/iq9Lo4myKNeeZKswWgDWldlWNSkKUh/j3J+sPa7vHuR62kWO?=
 =?iso-8859-1?Q?6iB0JeEDE8dm2waFaJ6TYMqaEXoFkSEG5of/QtX0jseToGqywswDLGVmLf?=
 =?iso-8859-1?Q?xq/+sB+rdJxcq+4Q7Pg3rYOgGknDrSR009xEGkAHhFK23ghFzt8GcZp8bS?=
 =?iso-8859-1?Q?bvunleBzJm1rFRbdvLfhjxyv78CQLSYUnHuxL0aajRLjvSzSegtdtOZMWZ?=
 =?iso-8859-1?Q?yTTha0LL4YQDtuZhOcTjN+zrcwkzHrKrl1TGiP3bMWHphmk83LvPfmYoYl?=
 =?iso-8859-1?Q?pg2o9i8CEDm73yegEKPB+e0Nb8YsgovvOnNqkZ3tiwmH3Dy80/ILEgVmyP?=
 =?iso-8859-1?Q?rT5gCtMi85hnxa4sbEZwmR/qH7UsmXuEms2Kzcm9R2aXvPom1Crn1TFVkF?=
 =?iso-8859-1?Q?e2B+c13iNg8P6IFF3E49HVXmHyC/rZ3pn1UqrYJyW7vXvW3R7IJpUJ3DbX?=
 =?iso-8859-1?Q?Yci8GI3oLQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eRxE6TB+/MBjv2zIApukKjwUFbFbIU45Ytd8rueDOV9ncDKZR5Cl0pPR0Kqw8dgX3EmcCLPorGO/F+bXeRDrzV2wtBSWB4A0puGZ2G8d/Dt2LG23zE8GOIIJ+RfRIDr/Y5nyP+9y+OdIolUSHIKjTK3N8uiJgxkBXTUJS6SfxOZPqwVYZmEL8bJGeF0Kpb3PEinXO+2pdynKzgJt742yVWCFUXhfqfUQQF3CtzA5UbaPcG5HJq8ze4OHe6Q/Hjacj3kVrIX9YyJ1E8L0zr8jo5teMZy4w+rgtwk1tzxr72eRwmXapOZVEHJMgZlmRTGzXci+YyoqRXa4QVbRVNBcxg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad416d6-a757-45f1-1229-08df3efc4031
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:43.9112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIQTQ8dyqVVMF3lLaiaxoX02E9un5e5sIZcQNpZ5DZTqLfXrbmjQWt8PQdO3/g2dKIyRtO6lK8gkbIhR9gSWmmn9DIUOfISMqbzxiFAFwGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFE8625B3B1
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
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 309 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   4 +=0A=
 2 files changed, 308 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index dce92eb263..2abbec74c6 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -123,6 +123,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SE=
RVER)=0A=
  */=0A=
 #define USBREDIR_SERVER_MAX_BULK (1 * MiB)=0A=
 =0A=
+/* Buffer size for an interrupt IN endpoint before its descriptor is seen.=
 */=0A=
+#define USBREDIR_SERVER_INTR_STREAM_DEFAULT_LEN 64=0A=
+=0A=
 /*=0A=
  * The steps to read the descriptors, in order:=0A=
  *=0A=
@@ -153,6 +156,7 @@ typedef enum {=0A=
     USBREDIR_SERVER_DESCRIPTOR,=0A=
     USBREDIR_SERVER_BULK,=0A=
     USBREDIR_SERVER_INTERRUPT,=0A=
+    USBREDIR_SERVER_INTR_STREAM,=0A=
 } USBRedirServerPktType;=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
@@ -211,6 +215,15 @@ typedef struct USBRedirServerEp {=0A=
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
@@ -255,7 +268,7 @@ struct USBRedirServer {=0A=
     bool desc_answered;=0A=
     QEMUBH *desc_bh;=0A=
 =0A=
-    /* Every request the host is still waiting for an answer to. */=0A=
+    /* Every request waiting for the device to answer. */=0A=
     QTAILQ_HEAD(, USBRedirServerPkt) inflight;=0A=
     uint64_t next_id;=0A=
 =0A=
@@ -1176,6 +1189,97 @@ static void usbredir_server_interrupt_complete(USBRe=
dirServer *s,=0A=
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
@@ -1273,6 +1377,9 @@ static void usbredir_server_packet_complete(USBPort *=
port, USBPacket *p)=0A=
     case USBREDIR_SERVER_INTERRUPT:=0A=
         usbredir_server_interrupt_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_INTR_STREAM:=0A=
+        usbredir_server_intr_stream_complete(s, rp);=0A=
+        break;=0A=
     default:=0A=
         g_assert_not_reached();=0A=
     }=0A=
@@ -1312,9 +1419,11 @@ static USBRedirServerAsk usbredir_server_ask_device(=
USBRedirServer *s,=0A=
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
@@ -1360,6 +1469,15 @@ static void usbredir_server_wakeup_ep(USBBus *bus, U=
SBEndpoint *ep,=0A=
 {=0A=
     USBRedirServer *s =3D container_of(bus, USBRedirServer, bus);=0A=
     uint8_t addr =3D ep->nr | (ep->pid =3D=3D USB_TOKEN_IN ? USB_DIR_IN : =
0);=0A=
+    int idx =3D usbredir_server_ep_index(addr);=0A=
+=0A=
+    /*=0A=
+     * The device has data. A streaming interrupt IN endpoint may have=0A=
+     * answered NAK. Ask now instead of waiting for the retry timer.=0A=
+     */=0A=
+    if (s->ep[idx].intr_streaming) {=0A=
+        qemu_bh_schedule(s->ep[idx].intr_stream_bh);=0A=
+    }=0A=
 =0A=
     /*=0A=
      * Our descriptor request is not on inflight or waiting, so=0A=
@@ -1371,7 +1489,8 @@ static void usbredir_server_wakeup_ep(USBBus *bus, US=
BEndpoint *ep,=0A=
         qemu_bh_schedule(s->desc_bh);=0A=
     }=0A=
 =0A=
-    usbredir_server_kick_ep(s, usbredir_server_ep_index(addr));=0A=
+    /* The host may also have a request stopped on this endpoint. */=0A=
+    usbredir_server_kick_ep(s, idx);=0A=
 }=0A=
 =0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
@@ -1391,6 +1510,95 @@ static void usbredir_server_submit(USBRedirServer *s=
, USBRedirServerPkt *rp)=0A=
     usbredir_server_ask_device(s, rp);=0A=
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
@@ -1816,6 +2024,63 @@ static void usbredir_server_interface_info(void *pri=
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
@@ -1841,6 +2106,14 @@ static void usbredir_server_cancel_data_packet(void =
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
@@ -1918,6 +2191,12 @@ static void usbredir_server_stop_transfers(USBRedirS=
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
      * The host waits for an answer to each of these. Send cancelled=0A=
      * before we free them.=0A=
@@ -1966,6 +2245,10 @@ static void usbredir_server_create_parser(USBRedirSe=
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
@@ -2115,6 +2398,16 @@ static void usbredir_server_realize(DeviceState *dev=
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
     s->config_table =3D g_hash_table_new_full(g_direct_hash, g_direct_equa=
l,=0A=
                                             NULL, g_free);=0A=
     usbredir_server_clear_ep_table(s);=0A=
@@ -2125,7 +2418,6 @@ static void usbredir_server_realize(DeviceState *dev,=
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
     s->announce_bh =3D qemu_bh_new_guarded(usbredir_server_announce_bh, s,=
=0A=
@@ -2178,6 +2470,13 @@ static void usbredir_server_unrealize(DeviceState *d=
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
index fe73ef6698..20c910e28a 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -430,3 +430,7 @@ usbredir_server_bulk_too_big(uint64_t id, uint8_t ep, u=
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

