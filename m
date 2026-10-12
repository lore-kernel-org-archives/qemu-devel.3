Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DB6CA9ED6
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mi-0001rp-S3; Mon, 12 Oct 2026 02:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9md-0001py-NS; Mon, 12 Oct 2026 02:45:17 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mc-0006MT-8l; Mon, 12 Oct 2026 02:45:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUKzq2eIgrrCIp+ooZMGLIY6tD7XxvieB/s9bHe8aEYWeaZfeKqP+BCZvA9CK/eS1ePfInoLZCul97pWfQiHAxETisF3UNvG6+W3OWYgPWItL9Tcd6ZuHusq8IVmsODtCw7nEsaNrTsHXn3WckeTAXUzmdyhZ6pq/uX5on6kZf0ItBWl8sEfRpR/sCC2jLj8H8Ho+rXKc2AZ+dOVd+6PEPdDHJrPWx2WHiueTIYnT9nR4gFvldI6bgJ1hGrRYzriRzRieFnTsouR6/lVsXeJpLp3267w5t5fBphvTUG+ywovzUoqUlQ5G3Wd7VJqvtUTeDmBPTDfGi+JC92yNXzlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzQyBL4XUqek9PUaHpyjjkSQ8pg1ifHETTw0gMLZDww=;
 b=EQheixOTPaZGZQ8wIz0diq50a4yVoRv3LHHlhL5QkWSgR1OByGHEG2k+xTq05jxdByjnMfhXziteSVIcTp26oWFu1rzCEXfisTg51bZyLafDvsB4uM/hlQk6cTLDecwC8Rvij5AjdnU21udaj/CTH4LH9FEYPf48MosHc5vnOCi4sBhkvJcPuTp+E0AHrmKQ8S7K9OTkj0SbD9EJEWonS4+VLwHHmE1RN8Xrimne0uUT7r8xIPGxaTbfA33r/8noH08glVuU7zCCHTiL8E1mYE5mJC3t/jbbC7Ax92cdE8IF382uHqnsQarrDMGI0H1CYvyKWS23xgdhgXoyEFmWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzQyBL4XUqek9PUaHpyjjkSQ8pg1ifHETTw0gMLZDww=;
 b=WHwj5WUXT7hBuKGHZaDdyqETm8+9LxLxhDELk+ACI+BAdBsy1XkPGYtf2RxCQPjcc+B5zVwQHTI30Y1Az8rQb5D4mkCLyF2WZovQx0KN2Wgp+RPicPHp09XVvNH0eWuFSN2Wu9ABQUDWbBKLME0eRzJ7lBb1gXjbxzFn5QJFas7PyiRfVSjjK5JTM+a0+p/d+VdoWJx32u37vjXs4udJe5iEy9BAIAN7i4qnemXiIxm14HUCM1xbb8JqbajfNCvj4B02nuaHcu+0bPkLYhtMn+Z/XFx5sj6rivXJPjgr7XexZc+4xNt869vOoinmGSoxGc55F/qKMR/hhiROcLLUIA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7244.apcprd06.prod.outlook.com (2603:1096:4:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:59 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 12/12] hw/arm/aspeed: Remove unused
 aspeed_mmio_map_unimplemented()
Thread-Topic: [PATCH v2 12/12] hw/arm/aspeed: Remove unused
 aspeed_mmio_map_unimplemented()
Thread-Index: AQHdWhUzLnHsNSb//0KXkMXYajKXNQ==
Date: Mon, 12 Oct 2026 06:44:59 +0000
Message-ID: <20261012064445.2571633-13-jamin_lin@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7244:EE_
x-ms-office365-filtering-correlation-id: 761cd9f8-cd6c-4e5f-cfa3-08df282c5623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|3023799007|261009223027099003|38070700021|921020|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: 5jc7jueGJf3gmeZ09iXnNcb7rJ6B/6xhmXSvbqcj34oRs+ZFWtHQ1aa6Jk9Ys58mcBVyDzmVrZsS72Cae0teF1lsIJJGuSteipgRrpkyQXfCRsp8L3pQN8V0ZnW/mXONAfB6hfm1MDC0AKnhRrlQouLpasxGfTRPRvPcv5UJOxulcZrmIrNgaKjT4GBBqIHTm934lo6gGYB/+N8MsbS86CbCr98MzFB5vn51Bz6aPUBXyS6pFU5+NcjWwleF37VODw3poVx8/Pkha5JeFQaHUnT/OLZAWkot00KMkmKvJpD4pPc+LzkP052ZRmZcAo2NSztEPpqlWaLcwxhwxriXpvk9PMXYWB8ioXvDFCXQ+NfW9o5EaDRe9tWY5UcRyp5u1ENuI+iaw0r9XaR+HHDBPb2UxXtfA87VFxqOEB2S4Kd0tJpy6yoDUWXYXLr+mpn7l0f2iEbmi4PH7OWZ5PG1n9s2RP8wl3206i2Vf+oCx6YtcGBHl1UwVxdU2oUCkdhXlCVsUnzL2g9558iL8j7diLepWP6AFTnLALIAxm9Ah8CcghrObQwrTU5b7o2kOYsikccJwiJCB/EY9eltziIyLt55qc0jR8F1jjwRgyd8meVVBwE8+MWHiFi+qujsBKZKeBL6MpriEzPCTvujGFzT1UlzGFXLMZCo54SY41eir7BxDXsBSfuRDkxzAXQLdakzBV0u+UenxkPpQw8FjR+CBAIMPy1IJ938AzkHcQuLAggbEAYFPuqcmleODUiZR8hi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(3023799007)(261009223027099003)(38070700021)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5GaEjMRhTOmNW5uJyBZy4o5g7VXF12AoO2S74Hl5yXESPXPlOw6Gai/4gJ?=
 =?iso-8859-1?Q?j7LJ2ESUaE8I5DNjrL+krMBhCBfVtWAeu5zx92s1GddfhKovk51OPCcwNf?=
 =?iso-8859-1?Q?lyi/ttW8UVQ+lnYKkt4Zxwl59+KaBGabbFFg0EJfEK/Rt6Oq6qBgXiKk4D?=
 =?iso-8859-1?Q?k6fHTxoNr1f3Xadz1v9YUxvaTZ6X6dpk7mEKc+XvMvvhRbfBtyek+UEY9q?=
 =?iso-8859-1?Q?OIzhBmkkDfE66e96T3iH3CJd1InVPXaN4koyQ6RVZX1bIDXkI29CUP+Ni4?=
 =?iso-8859-1?Q?yDliSbYOfClss/rfF524ruhvZ9KZqNhCslIQ5C1542kUIdaNwoLUNOL8b1?=
 =?iso-8859-1?Q?r4Te4b56TY3hpDDIhp75Z3TFpV4IEkLhAbiGN30z1MsUFrbFjCzlUkXmA2?=
 =?iso-8859-1?Q?peqaT4ksVi7KgdyiUzVyKJyum3WiZSu+l1pf1ri1o/MyXWNsJ0FFDYBfqM?=
 =?iso-8859-1?Q?8rMm/jfl/gCyzWUTlV7LR1Scik+bYxE4axG8cnKNiQcM1btJRTrts8JGQu?=
 =?iso-8859-1?Q?s7vVvWckiXCPLheHjHpeOHWsBO2O5AhUZTKVKDN+sT89gYb9SREomW/S6w?=
 =?iso-8859-1?Q?CHKkgglKxR/lDSxBbPkeKorPaHokMfDJu3TBu7b0kU/0fCupXUZMSQ0rRB?=
 =?iso-8859-1?Q?MS0yUsyJBukeOflDoAgrV+acGppy3XgwGm0LbIILR4frLbZf0Ht5ClqSpf?=
 =?iso-8859-1?Q?vGDgQm4nzm3vxwSU7ThNzJn3AHQq2RfLFqpu1iYAmG3/ZLPTQGijSfjb/v?=
 =?iso-8859-1?Q?ZLraw0Zs11SkHTu49HPrxdm7hpZVD0XKDIIwQKnn/rsy0v3Aqp1sCXhuLb?=
 =?iso-8859-1?Q?gCjMq6HSQNqb/OxQrse4nQ7pkY97tRWecNdlek0l9oTT628f4kVdO1uxAh?=
 =?iso-8859-1?Q?4g2vQH9LXos5AXlbvlVreMWdFoXr9ykZRenxbmQHX+HQeEzTUgF5QzLlae?=
 =?iso-8859-1?Q?KRg6CkV2vyMWXf/hYIMuRO1yeHz0Sgzmsx0K/12f/zaUGCm7Ov/De++WQr?=
 =?iso-8859-1?Q?R0Y2eRpSoM0hvdbuzs9XLN9YKtpC+PUxYa/aT+iafNdQz9UXEIQRMTfKQa?=
 =?iso-8859-1?Q?Y1b6JLfhOgeQBE/n/FRzJev1gsqK4k2tQr523ojRuKhIk/foNHoCynGbXy?=
 =?iso-8859-1?Q?zSkBi47yxGgqinkTIGYV+OV6KTi/MwcEkHeeHY1Cnjf/vk9M7tsQuLjDg4?=
 =?iso-8859-1?Q?uztn9vOwRpjLK3uIEPuUawgFbM1dhq479AWxGAGQYGv3Th/wHQoAI01YbZ?=
 =?iso-8859-1?Q?a0pzSIoOvsQ3dDElZLog0g8R1LzwYn6FmUazijMySiAuIcmFy8M733Uh8a?=
 =?iso-8859-1?Q?717jUx2KN2L5BLo8PVtpulYgiT0FezBbtltC3obWSK/1pRiKCvmsccwMpy?=
 =?iso-8859-1?Q?oKqKaUwJx08N7aK/cAnfI/appGzrovc39dIlE6FjE1IDFoIksm5kB9GB7B?=
 =?iso-8859-1?Q?FnMuC52scdAdjvIYN6StufQ+wx1X1p3htkTQK3Y2iYpEeDYuXRrw1XKm6u?=
 =?iso-8859-1?Q?nMXiBE2Av8piu4OU57eebXODxEAnwq97DakdtWkYFLq/NzsWfTBirt/ClM?=
 =?iso-8859-1?Q?9NaFhahjSOBZpytzHOKaOTdnmzdro/oAXXXrxzfRDH1sEtgyV3COBmvfLZ?=
 =?iso-8859-1?Q?ES4yTt5KMJfY9V4iZXdHsvV7GwKhnoqkW8Jd7pwQaLUmXTveHssap6sYQq?=
 =?iso-8859-1?Q?4S7d7m/SchzqcpChMHoJG3NyIWKJvdg0DZD3bvBYyxP8RMko9sZzxKkLIW?=
 =?iso-8859-1?Q?08bPqPKZVo1sPIX6S9bqMYGu0FPvOE7iz6WY3l/foTGci4tZeZFHuFz+MJ?=
 =?iso-8859-1?Q?Ek0jrl1X4Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ree+VfThIUT5w51DrZDZ+vWMxhlPlwGebJmEWlni+qWITppnB/qON29/MiDjJcF/QUEBP1mmTm+Km4yOKCtBLbpS6h9eDJzdHOmaRZUqwrGAFVhMARWjKtvH7UHNRXU0Rhht7jM651nh7zjBK2eDur1OcWK+bghZ3kqBxgYcXJl/MTdamNS9eRgRP+I4+1DDiLk22e/IMpcbNftnwdzha1jkKMgCPpGeslLkRvH6qS2+QRtvDuHdkYCZT+/dsz0Rs6mM0MEK8fF08BfomJS8w3UCkehOIyEeVYKmWc07iKxJCz092OHkVauqRGI0fB3PTvEHcuZog3uInKX2kM97Cg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761cd9f8-cd6c-4e5f-cfa3-08df282c5623
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:59.7342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5I/fBFOje2H/woRBOXSmqF9iQrCoqio4tv82s7pMneTY/zLSxfONXhdoxbYoSIPf0T6lBZItgBm8yfWy03ciWTsrrVY5Uwj6XAxbXkMlYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7244
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All Aspeed SoCs now use create_unimplemented_devices() to create and=0A=
map their unimplemented devices. Remove aspeed_mmio_map_unimplemented(),=0A=
which is not used anymore.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  3 ---=0A=
 hw/arm/aspeed_soc_common.c  | 11 -----------=0A=
 2 files changed, 14 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 4ef1014ad0..fd860ef9ae 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -307,9 +307,6 @@ void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, i=
nt uarts_base,=0A=
 bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp);=0A=
 void aspeed_mmio_map(MemoryRegion *memory, SysBusDevice *dev, int n,=0A=
                      hwaddr addr);=0A=
-void aspeed_mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev=
,=0A=
-                                   const char *name, hwaddr addr,=0A=
-                                   uint64_t size);=0A=
 void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,=
=0A=
                                unsigned int count, int unit0);=0A=
 void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size=
,=0A=
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c=0A=
index fd08793575..54a128c965 100644=0A=
--- a/hw/arm/aspeed_soc_common.c=0A=
+++ b/hw/arm/aspeed_soc_common.c=0A=
@@ -104,17 +104,6 @@ void aspeed_mmio_map(MemoryRegion *memory, SysBusDevic=
e *dev, int n,=0A=
     memory_region_add_subregion(memory, addr, sysbus_mmio_get_region(dev, =
n));=0A=
 }=0A=
 =0A=
-void aspeed_mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev=
,=0A=
-                                   const char *name, hwaddr addr, uint64_t=
 size)=0A=
-{=0A=
-    qdev_prop_set_string(DEVICE(dev), "name", name);=0A=
-    qdev_prop_set_uint64(DEVICE(dev), "size", size);=0A=
-    sysbus_realize(dev, &error_abort);=0A=
-=0A=
-    memory_region_add_subregion_overlap(memory, addr,=0A=
-                                        sysbus_mmio_get_region(dev, 0), -1=
000);=0A=
-}=0A=
-=0A=
 void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,=
=0A=
                                unsigned int count, int unit0)=0A=
 {=0A=
-- =0A=
2.53.0=0A=

