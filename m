Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8A5CD342F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKSua-0007oy-7I; Tue, 05 May 2026 23:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wKSuY-0007oA-P5; Tue, 05 May 2026 23:26:58 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wKSuX-00052y-5W; Tue, 05 May 2026 23:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+9wuz9zq6/FvbU/RjmhjP486/jpDnT75k41H37OCeKl0y/t1WPB+g5yBK1HH0nf4B96GRhRGabX4cPQ+dgGfrb4d/sXhbr9nomftkbi3J9DL2ciYwh/dhJTRR0Tr6tep+7GfmzydsSMPvqSZGiIfsnN4yzC9IofiO8jOkDAT8sUDdY4FpSmmPu8FxjuOsLyJVAxv3SxUdJEBqS5jJ6RrFF5/AF5APfb/+08WxJQlDveyP2uY6C+198BimFb8S/Y3GW3aW0Q9SEudr5hinIeorGXrkvbreJBnjCbuHMa0Bd5Onz+CyHYfMPIXjpyBXPmmERucj18gOKS9K6CgGPRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0Z3fhDJh/SxiuCFbf2Spdj7BoLHYafuISJw2v/PxPI=;
 b=fLvGvFrJcACX+u97/Q6OrI0Lxx9Ip303Uy4XH9WAoKKCqOG155aomS/YGphHlEfDiTi51KsS14ZnTInZFKqJnELTXgf8NdSzjpOnTRfevIH/C7/xxicG5AVjS2gu3cUwy4PNpi+0qZGQNina1cYql28wb1GEwcztJTHgC+KgpSvSGs0tGkXmxqaVXlVo8aKP9ujZFSQxWXHwx540MmndYVmChnQmG2AxxcLEak2sIr4ekJSkwFMHcRxizsMDldIP9zgJS7kkLYdJIvH4ueWCMDTu2cSb2pidHhJifm+/tGuqTTXSmWI3gZj+doZuf4aPtJIGnLyI52PEGwPc801D0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0Z3fhDJh/SxiuCFbf2Spdj7BoLHYafuISJw2v/PxPI=;
 b=CujhCG9HgounMFYOppEixGvas+lnXaoopYp6MGkV+fCO+7/XRNAi1SqLUOiYCwYdV7lgNqBpZchIFKaCWA5QWKZ5iqoYUZRUwrL16gPI8WKfhkAKNnZ3tFo3meOQLtTsNRCunbRPGwywfFjUsZwvk1v2fPXqSXLwXoaosAs3lJTE3SKsSvw7bF91RB17nd5HSIEkA05d2Fr+LM9u1L+yZ4y5M6LnEC9X1Q/fEM1ElE2E1NP4tzT0vy5bJFQqsgXWhrPfBBsAFwp5e6hbqz7SXIVW2v05TKdYxN/qwTKilsJqH0h/6A+QzYQ+sUKntAi+3NyCXvSGhx4TA0yExo02PA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7325.apcprd06.prod.outlook.com (2603:1096:990:a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 03:26:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 03:26:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 1/2] hw/usb/hcd-ehci: Rename migration compatibility fetch
 address fields
Thread-Topic: [PATCH v1 1/2] hw/usb/hcd-ehci: Rename migration compatibility
 fetch address fields
Thread-Index: AQHc3Qgqcy8dSi89vkGRdd4mbz53gQ==
Date: Wed, 6 May 2026 03:26:44 +0000
Message-ID: <20260506032643.2510575-2-jamin_lin@aspeedtech.com>
References: <20260506032643.2510575-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260506032643.2510575-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7325:EE_
x-ms-office365-filtering-correlation-id: f00a3af2-3724-453d-9577-08deab1f4c8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 2gej/5wjYxGyvHXI2G4d3DNr4Mk8JSxJ71GsXmsjDqOgD1Otj+ZokqDIP4oKvCVcQxJrEggLZIitpjKw3R6cCXhI6JdQyZgWEe7EWKnskFFzCYRLATXiL19i+F6aJEik15fTEMVpXKRjDSy8bMTsUwbH3e1I3TxLybGZrbMcYQqyUXn4+MU0V4koDol2JxWgDh35PBXKqKqTMAWh3LpK/TbBaOJTN9nPnXMjw8vLJU3ZXqyRCjGnrEYPv5CB3RhOR0SegyjhVgKKvASIH7rMnYex7XuuF0gr8s/6ZuCcHu65hKfOuFVfX2p7gTKgLaDdzATTS0RjdrNxyHsQPAbC/pr6Mq1WJr5sasnsQrV4YoVfqqeusxSIquYpQ+P2/bBKNmt0SPHIn73MtmiVE0LmNFgbXxK1R7VFIZP77T66YOhVZ6/RCVkRLumWBQVwJX1xX1kICoF6pZH9FG/ocIiHoKYkbUzRQfU6cw0TbC/vyGu6IBg21nL56oNZmaA0a5owe42oqsVZ2XOvU0BD83iPTG9vAlLYCXGmJMunqE3o3DME6/g2dXDrR/KolZMz16yqLx8FRSvxHEt6IrZzBtD0whyprOSPHjB3icEAh2IkghtqX5IAnYTw4Rvx+ujaH62zXRYSGMzO8SWnOHj5m7EG6c+b7C7Tcr5BPaDXn24oZDfyik1Emm1dSASEP88tM/gvzkAieDCibNw2azSdrx7zrJHLyiUGhAOPk+IlOgACTYuQaJ+KH3Tq3OrcEPBB+yFNnxvUzFE0dyaojmVKPbSQOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i6e/1Z5n4NMylGfjeU5aYLcATSSWMoAWkU1YLs/9I9loRbgZRCpFlM3Fvm?=
 =?iso-8859-1?Q?dcuuRMIzmi6Hf7DM1RKAzFlWqfJ3UEFBX/JbUvEQ5KtyjDOb8Duj1zbCRH?=
 =?iso-8859-1?Q?KQOl2HLAKW/3OqTct7/BQcdIUhcEw5gTLJvY2FT8DqMs6Ld44Mm9W8+F//?=
 =?iso-8859-1?Q?cn3IE4C5IpGcPD2bKzQPhD+1nSCyC4bXDcaNTuBDbn48WnBsQ1XVBHZWMQ?=
 =?iso-8859-1?Q?oK9dFSbk+tZ0pR1Gc4qKQEgRjUTOTMPv6cWo0bqLb9TcUW5E6By+nWYRR9?=
 =?iso-8859-1?Q?AlFj0DsQKRWyUrp5pXTEMmbFWAfVAZ9m6o78eRDp6DeXK3jCqv9V15wnNk?=
 =?iso-8859-1?Q?mjQ5MvM3ERWovC4oxDl2cpcNUlrtm+CWia8VYEJNwD+3ZW9bUIj7qiVAEv?=
 =?iso-8859-1?Q?PTkxNKGfVTCCIpbZpCGN+LcNpDwS6OLOGlXkizz+aUxFSimYMN2S4Nwq9Z?=
 =?iso-8859-1?Q?6IZjblwBEn5rVe94Oveu0N8EcPd2hVsrxHU3jA65rcUjkDAhlBUknRJjoF?=
 =?iso-8859-1?Q?zXu6/ESul9GGhTHpZtQ26m+uPl68EJwAOFqYMe/gw9qZ++akGcX4d/RPZn?=
 =?iso-8859-1?Q?0ZWEc7AdGl0ta7Gxvrub/BsySatIEZF+q6WIxbmm5xRtxHLNZbVzPLJEhg?=
 =?iso-8859-1?Q?2A4DF0rCjUZlzcOlvxe0LGED6sh8YHl/M51gfmL62k99sNWXg/4xCVK9pH?=
 =?iso-8859-1?Q?0Lu7ZPPXYjC3hmBASkUivslfuiXQGPixSViSQAmAgNxpV9dc5bE4NCq/B7?=
 =?iso-8859-1?Q?OAwOMB18qE5Zm/kac3K44ywQb9qwcnq/uYwbSLvbmsCZuTSKkhXb//Hcvd?=
 =?iso-8859-1?Q?xsOqB6p2mGkHCfHfO5YwMQfff2hineMhTbWG/Tf3GK7eoh7iKkCP8hf3Gr?=
 =?iso-8859-1?Q?thwfMTg8N37qGA7ncSLotw5yvpngxKZgBobzFlW1xWQYT241a80nu2beST?=
 =?iso-8859-1?Q?l5bUcDDnL/PIJAjWxWAFJHuGTfRU5U0Hc+1xQ5ExqmeHAMAfJLYEqjGR4A?=
 =?iso-8859-1?Q?sIZ/95UJ2A3Mb6St1bqZTKVTLn2k0ionCByMK1FM7/I2fskpbPTGYqTMGQ?=
 =?iso-8859-1?Q?Re4oWtneD/oHeQq5USP+huyvrEbWWrC3HaZImEw8zon9ddwCmOGefEx2Vn?=
 =?iso-8859-1?Q?W/ARl6c0toVUZFsqrrUNHU0EN+Nl8j6zHkF8+SDhIgEbhJ6tK/m4GcGMIp?=
 =?iso-8859-1?Q?MJ/C87et0y/+Oci8D0QiG/gAfmb+KVuEkuaKjkv/uwewArn6RkOjHwyNVt?=
 =?iso-8859-1?Q?bgAOD06tZgh/Puw7UR59p8zpdRQ1aOZ67E+88t8P8GR5yGy9w2+vmdKfgg?=
 =?iso-8859-1?Q?gXTP8oQPQ6ituOi2yT8ye74Nd2WaNGL3YG1xbuhKT2RrgMA39Utr/H6lB7?=
 =?iso-8859-1?Q?Kv/5B1uZH3q/i+5j/x2dwRQ4MlQMKTaeajUBOxlC0Ecik+tRMPLQLjbmfa?=
 =?iso-8859-1?Q?EOTg0fW5QOmn3zHogemsTfRT+BKg5D7XNb+aEGP0V7bgL3qUc61p896BJb?=
 =?iso-8859-1?Q?EsjHI8uzmR6IopeJN+muo5R0uVfGQ7o44sCzTrZmI9PUk1kchoOVGDYRrC?=
 =?iso-8859-1?Q?T4CZjTvxiSfWXGD0+p//5RlILPMg1Zndzj04T3QSLEcIb1OvPrzwWKmm/Y?=
 =?iso-8859-1?Q?XKMgLZ5HKggffJsy4CLpIMHDAYjfVGqOo0IOJ+CW7y2tFZdyytK7pOI1p4?=
 =?iso-8859-1?Q?/JDjYa3btOwmShBsBXTVrku1hR6IQdLm5HQ2VIcEe9itlPLLWJXsGqiGRc?=
 =?iso-8859-1?Q?NPSTzV5rkVfUWAWDi6XrIQivmR8NWQZZc3pYMcqWCFwaR9rdPRDpFXhZDs?=
 =?iso-8859-1?Q?xxTsWe31Pw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QMrSbmy9e5AG6o8nW3PdxI1VZk66afdMDJQ0GLDzim4b2D4x7s1kdwegRKApKLCSLigidDyf7nwYCz6KhCG4QJZv56qyUdtdyWjjTZVf7MaWs/EiQV9zcRR+G0EbLQLPT+8vv5lgJk6mzabYlqXgAwGGsqNFckg7MnZu78AHKpfBdg3otKo5YuG+iufYPS48D+h3rPHDQs+EITRcgjvdwEXBhBkVtb9xIUag5Y2yTHfLoZ1IMkO5YJXDo3JD824+PlEU/nsabvCQm1/Kkz+P2CPRE8xnx/2Ddi5bAxdouPQCKTN1HCyXTiF+pYSmxcc0sRJAx8d2GoKlf4EYtSuN6Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00a3af2-3724-453d-9577-08deab1f4c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 03:26:44.9258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJTYtT2Njzxpyb43fTczh7zmUt/hr09vy0vKxSDhxrsdUNwcqdGlcJJ3S+EOT4Bvw/L366SyH06uio5mmH8OB7CvEku6zLQ9zreBGcvSbOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7325
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Rename the 32-bit fetch address migration helper fields to make=0A=
their purpose clearer.=0A=
=0A=
These fields are only used for migration compatibility with older=0A=
machine types that transfer 32-bit fetch addresses in the migration=0A=
stream. They are not runtime fetch address state.=0A=
=0A=
Also add comments to clarify the relationship between the migration=0A=
compatibility fields and the runtime 64-bit fetch address fields.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 17 ++++++++++++++---=0A=
 hw/usb/hcd-ehci.c | 12 ++++++------=0A=
 2 files changed, 20 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 3d57e1de5f..b5ac9c8670 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -262,6 +262,10 @@ struct EHCIState {=0A=
 =0A=
     /* properties */=0A=
     uint32_t maxframes;=0A=
+    /*=0A=
+     * Controls migration stream compatibility for old machine types.=0A=
+     * Old machine types only transfer 32-bit fetch addresses.=0A=
+     */=0A=
     bool migrate_fetch_addr_64bit;=0A=
     bool caps_64bit_addr;=0A=
     uint32_t ctrldssegment_default;=0A=
@@ -302,9 +306,16 @@ struct EHCIState {=0A=
     EHCIQueueHead aqueues;=0A=
     EHCIQueueHead pqueues;=0A=
 =0A=
-    /* which address to look at next */=0A=
-    uint32_t a_fetch_addr_32;=0A=
-    uint32_t p_fetch_addr_32;=0A=
+    /*=0A=
+     * which address to look at next=0A=
+     *=0A=
+     * Migration compatibility fields for old machine types that only=0A=
+     * support 32-bit fetch addresses in the migration stream.=0A=
+     *=0A=
+     * New machine types migrate the full 64-bit runtime fetch address.=0A=
+     */=0A=
+    uint32_t migrate_a_fetch_addr;=0A=
+    uint32_t migrate_p_fetch_addr;=0A=
     uint64_t a_fetch_addr;=0A=
     uint64_t p_fetch_addr;=0A=
 =0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 62c3770ac5..56ac8f6ae5 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -2482,8 +2482,8 @@ static int usb_ehci_pre_save(void *opaque)=0A=
     ehci->frindex =3D new_frindex;=0A=
 =0A=
     if (!ehci->migrate_fetch_addr_64bit) {=0A=
-        ehci->a_fetch_addr_32 =3D ehci->a_fetch_addr;=0A=
-        ehci->p_fetch_addr_32 =3D ehci->p_fetch_addr;=0A=
+        ehci->migrate_a_fetch_addr =3D ehci->a_fetch_addr;=0A=
+        ehci->migrate_p_fetch_addr =3D ehci->p_fetch_addr;=0A=
     }=0A=
 =0A=
     return 0;=0A=
@@ -2507,8 +2507,8 @@ static int usb_ehci_post_load(void *opaque, int versi=
on_id)=0A=
     }=0A=
 =0A=
     if (!s->migrate_fetch_addr_64bit) {=0A=
-        s->a_fetch_addr =3D s->a_fetch_addr_32;=0A=
-        s->p_fetch_addr =3D s->p_fetch_addr_32;=0A=
+        s->a_fetch_addr =3D s->migrate_a_fetch_addr;=0A=
+        s->p_fetch_addr =3D s->migrate_p_fetch_addr;=0A=
     }=0A=
 =0A=
     return 0;=0A=
@@ -2571,9 +2571,9 @@ const VMStateDescription vmstate_ehci =3D {=0A=
         /* schedule state */=0A=
         VMSTATE_UINT32(astate, EHCIState),=0A=
         VMSTATE_UINT32(pstate, EHCIState),=0A=
-        VMSTATE_UINT32_TEST(a_fetch_addr_32, EHCIState,=0A=
+        VMSTATE_UINT32_TEST(migrate_a_fetch_addr, EHCIState,=0A=
                             ehci_fetch_addr_32_needed),=0A=
-        VMSTATE_UINT32_TEST(p_fetch_addr_32, EHCIState,=0A=
+        VMSTATE_UINT32_TEST(migrate_p_fetch_addr, EHCIState,=0A=
                             ehci_fetch_addr_32_needed),=0A=
         VMSTATE_UINT64_TEST(a_fetch_addr, EHCIState,=0A=
                             ehci_fetch_addr_64_needed),=0A=
-- =0A=
2.43.0=0A=

