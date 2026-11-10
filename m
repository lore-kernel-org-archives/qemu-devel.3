Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5711606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=WKHVlx21
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHX-0008IZ-9f; Tue, 10 Nov 2026 02:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHV-0008Hg-C7; Tue, 10 Nov 2026 02:28:37 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHT-0005Uy-N2; Tue, 10 Nov 2026 02:28:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbH4UtAvT5zkzcwBWz9scn7+BC+ybuF2FI9+UmgmiDrEOBUharptjgnMN4hfR91ZxH417XC+0Rru5rI5vnmgc/+V0muh+aXRUZP4BdK4X3KuFN8gSJGkpghU7k1rxJbWK/8+UlzaVhNDOvISWTqJJlVJK6ouFl+4q9equcuXVCP/IeTaYoFnK6KnlVu4obZo85HQSFplVecwtsOb/e1TBGU9r8H0azvl0j39ZBS04wK5ez/MSy7zADkHAg0a0iIf2aM18lqa63Qp9Y22oHJP99aGjbWNoaBzRqLTN6RNh/wZlYil9H4GytY1kKo0vEu7JoEWrtmimWBZ8U5U2u+T9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrEJKKYBX/WBufi1YeXZqM0uNEB3A/jMJiFaidOiuBs=;
 b=ZkdDtbj+yIBol1TcPG3aWoKMgFjPRY65EK1+YfD0ggsAa1EXwo14zhtgD3+9qBsYaQrQOynQP8DfASkThqARml6XLtRdn8X1nctjmKdLYTuRBJfackVQ+lX7zVbC7Mc2LeLRxQI0+Zgtp9a2TvLAKwd9gDYjm5th5qoEyurW89dtezXSH+uk2DMPQ7plYDoyr1KlcgAEqDRrnaej89C/jtzzVuKpyLGGPvEYp1msmCz6gdkUMvaJXJojjmS0vTGRtBnQ3EwCS62Thg7S7TlJbJ3tc0j+WL/0dpa6+oh/GwMf5JWeK9FPbiZnwe7pzTcft/xznFO86bABpLDQLak5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrEJKKYBX/WBufi1YeXZqM0uNEB3A/jMJiFaidOiuBs=;
 b=WKHVlx21lIbR850CvxzFsyY+VlpgBGgduhULMZW6MEAK7Q7iDbWnSwTjLaYO1fg3LsilnvEYrRUY8Q/QBgnEL/YfkCf58UiCX66QpM1PWlzXpVX0WuIzQ+SHuVa+Hn26Uk47V88l8VmdE3Ux8k8RsIvq0331wpX58372WAXk/68Wp47OIVYAh57VRcq2OIpEfVyAcrsJmola99bx+YzbR8lgK8V1YXOteequ2B0SlDlyXDURk/9seyKZIu8JNnD7ZqFmPwiKnvGTBuf6Y6ld3wIz2UwpE76vMEFmFq+02FvWTg159OOCqySYwUj6bgBzyh23WCkgR4sAX8Xwtpqgwg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:25 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:25 +0000
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
Subject: [PATCH v9 04/19] hw/usb/hcd-uhci: Add an auto-hub property and leave
 it off
Thread-Topic: [PATCH v9 04/19] hw/usb/hcd-uhci: Add an auto-hub property and
 leave it off
Thread-Index: AQHdcOUSfINGBotqd0uFuszLhB5z5w==
Date: Tue, 10 Nov 2026 07:28:25 +0000
Message-ID: <20261110072818.2883349-5-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: a4b00d19-6d48-4737-fee3-08df3efc3522
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|921020|38070700021|56012099006|261102123227099003|261022113327099003|261021121427099003|261009223027099003|261026121527099003;
x-microsoft-antispam-message-info: i7Rzv5Gl1LWhJf5pWI1VvmH0l/VSZk7UbtdA3klAav+fU5g4wF9tmLgplaVkzm/GhzdbigZmSTNZuLCeGejqArsjM7l6riu8zXxupLTbDkH8bXbA/M2dUQ6GnhRtI5hDJFSlbdx7O8yo3A0NMQuaojRqbU4wNY9LJ0KN0fe44qigDug2XBtVHhOsh/Pve4bVia5Ug0O4Lz5YrDxaZJQhwfUmxDAq34NFkTsH58Cl/4bF45qr801Fke0vpL9bjyYH2OtCdta8ohK43x67ftWuqMJJSKc9EYfPeaNxBZPJrP/RFbtCl6NjpEaaP49Mv8uo1xyhxeZm4le141n5lHz56xDKVf5xQD1ON2ThGm+BXaSpL1dm/t8+bAQsWJs9xmzwAfZFbQMcplHElDJRG1bOnz1YTMNtFOlr7jThRyQG+PiP/2KvDstXv0BnOIMz4VyAZGFa4wIuAyGpNbNFvXWdnVefEdrEEQh9hVYoOocAgsd4naAKtJ4vlNPXMtiHWxg80WEIyzkqAcKSapnn6Cam64Ktog6+aLF1xLyKedHp0ZB81MkrchoaLgnuLPLuywp31g3GBVto2QKMRk07hD62y5MQrmIxbFv4fLkUaw3UJiXWzKAAyUi5LXXevd8nBWHXm2beshonrnUOtNMTieHnAwR+wvdrGzRQmzTEsx+wCxxNC2SjQZSbjAYrCpVOAKwQ80EKYUaL19HesRffSIQ/kHZ51oYA2tp8E0RsULMpKoYqdu69RdaxzcXrVO+oEQ4g
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(56012099006)(261102123227099003)(261022113327099003)(261021121427099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AzAeOVzBE9mDHNXVOCfCzl2n3pEgatf5e0GzN3A9zlKU3TC718Ap3OdxwZ?=
 =?iso-8859-1?Q?D1XU7L7nqk4EpxBzMlI+gBTT4uSMZrzQY0p5XmwjqUlAO4cNO86j5oY1G+?=
 =?iso-8859-1?Q?yWUIeaxx4wuA37VEn9wqIXm9mgxrtSkGWNovEkoCmTuhmzrlFbqPIf0UZn?=
 =?iso-8859-1?Q?r7drjc6TDOi+iW9Sxwqb73s2x8Tj2JQDUBGtI4xHzhCmYr9A6NNotqPyOg?=
 =?iso-8859-1?Q?I35CIF627xGggu5II2DM+163NC7mZn7WMNcQ3gLikeQeJE7lFdjkd93LiI?=
 =?iso-8859-1?Q?bTIB7onjK1p/MBpoaTNBijWXhSPlNmPcP3jqUeng0H7wOkOrbZcc9iQnyX?=
 =?iso-8859-1?Q?iG/CCS67dsRjL1GD8K8YzFi6ZpsmEjiVSsiJD3ofo95sXgSN7RqkehMvab?=
 =?iso-8859-1?Q?ObWF5Q3qPweUwO2kRyyxl8AEtaw63N7NrYyPql/CtxueUZvHKSx/Z63MYM?=
 =?iso-8859-1?Q?2PQ2GR+HJumMGIlYZInh07BqpAdgr+Vgt3XFl4hTRC2jfb0H/yDHiLkElW?=
 =?iso-8859-1?Q?Ewl9ACObu9TerHZb1ddQGDirYe4WvtzHvZebocEVH4yHRG3SMinNwExfSL?=
 =?iso-8859-1?Q?QirtLKS8c7vq0CFu70AyPKfosgg8ngXVuqpzPokmrypo9B3OkOd64IZe1k?=
 =?iso-8859-1?Q?N1rSchKaJWQdxi5VCvONzpXf56TbdG1Otj2A1fDYg1TkTfuVT4LLvtZ1SV?=
 =?iso-8859-1?Q?MAlt0BmZ//fTJ0VEIPnV3azWRP2rU8STnldFAQx02VL3QvLk8I7jUO9nEx?=
 =?iso-8859-1?Q?qCd4eMi27x25IiAkQUeniJ9gUQ39Gd6u+BGVshqYxpezd2nWsV7j0+cXvd?=
 =?iso-8859-1?Q?G+S3qPg1+j7USuz983HBkP4V0QkiUlLQ//NGu9ROIk9NyxjwY1Mq7cGiHC?=
 =?iso-8859-1?Q?k2Vi90O8eqc2xLRmUE7KPcZ/ntg1qq057vinTtdSV12Gkd6FJ4J2fmhVRM?=
 =?iso-8859-1?Q?P8rWdK9c6J1VqxybGq9YdQ+K7hofgetbaKK4zpZTV8blIKAwZCixTE+syP?=
 =?iso-8859-1?Q?sNvgkUbNzc66rnNIxH6cfg0UzXu4gz5rvoETl8F+xJXkKgYuKu2H3Xu8cW?=
 =?iso-8859-1?Q?x07dIodO5H6VGolP0uEenKCeS7XLHSgJt22yHCC7HuXoxRLqNG7Dj5VW94?=
 =?iso-8859-1?Q?ZzzCWaAnvBhqGWFKsS3XP5yCB0rEG1ejLn1mMroVJqM5AnFFPuXQMVwenX?=
 =?iso-8859-1?Q?egc0KHj+S6ucx73ebcQhdv2IZ3FuUdJJ/EbQ6eHgEz52FLysBvNWtXh4ba?=
 =?iso-8859-1?Q?CNmgf6qbOZ/VlNCNIAr2Y/bL2uVMvEYbVfO4A3fhjDQvWkO2X1VLjmRjh2?=
 =?iso-8859-1?Q?t6XhlZmnT+dyTh2R+8DlUloig4ONBHG10CXF+yF+6OH0oH6buYVvz39UWl?=
 =?iso-8859-1?Q?N5CDDY7+VIUu9GzYcErQTl55h5C1DlS6HIbf3Fyh2FvgAEw2edZprLyWl+?=
 =?iso-8859-1?Q?2psg3n/AMwx1YpFqx600h4r8V9Fog0Fd9oBiQYQk+8ToIYsJsQHGs6RZv1?=
 =?iso-8859-1?Q?l1lNdsye4L22/9tvVqUEuiZhsPSwV4qzAFaTzNkTmCB8y8CE6qfAl7teeV?=
 =?iso-8859-1?Q?y+upQCY86Kvo7HtHZcJKtv4woJf8738tvwg73sKRd1CzKTvzzvL8mFGvJi?=
 =?iso-8859-1?Q?jsQSuP1cWDiROAZd5XVayDMUcOGnAFXchhTYi5mGr1f8kNcu+gMlEMTHEC?=
 =?iso-8859-1?Q?xcDkEj1AWPqrTGuL93jgzB7DgNCyySm3+vf/VoVHdkIng7SNMVQlTtuWIU?=
 =?iso-8859-1?Q?d3XNrPsdGAIGDe7zKGOY08wX6OUSWfLy9PgLbwpJ9FqRgSI6Cu0ypaQOto?=
 =?iso-8859-1?Q?tVRxw3dKKQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hCKCsdL+NjoVE5fYWFCfnc8vREXl3wIRs70b5+s+cu4C81NIvjeEW5Hqdh/9G9tO9qvvvrU1IcBxxW4KHEcEU1T1nHmKxVmYlbGu0FN6S3dBokmvqfNzuT2hKiz9jLUaq2A0kC3PK4kUiBH8DGnDaJuRDRqi33arLZdolVLaWjkkKJRiGyfKK01cp8w6gGsGZ9iSRPZegpYU7Tggm7wwvv2tRJR59uFF07oaQ3HbwMJjXHmx7CwMKksuxMoz0I2icQnhDIV1LjrsdR0WVHmpMKjn2z1r7dTkQljS1+sTe2DXUZQfTvgVYltCFdQdOsKe4crbQF2pVym8mvSzCZxA8g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b00d19-6d48-4737-fee3-08df3efc3522
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:25.3196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKH4A9u7FUbyvHKVaIYujHYvGXVoMQ5BtUE8bicLpqnLZFFE/GgxFhqgrHPzRSjJMPnr3pyvXXV3aoSUdeeR18LMwpuQpk0BAs7F/1Yp+EE=
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

Add auto-hub and leave it off. hw_compat_11_1 turns it on, so an older=0A=
machine type keeps the hub it has today and a guest saved by an older=0A=
QEMU still loads.=0A=
=0A=
A companion UHCI adds its ports to the EHCI bus instead of making one,=0A=
so there the EHCI property decides. Both property lists still define=0A=
auto-hub, because hw_compat_11_1 names pci-uhci-usb, and QEMU stops=0A=
when a global names a property the device does not have.=0A=
=0A=
TODO: Move the entry to hw_compat_11_2 before merge. The series goes=0A=
into 12.0, so 11.2 is an old machine type too. hw_compat_11_2 does=0A=
not exist yet.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/hcd-uhci.h | 1 +=0A=
 hw/core/machine.c | 1 +=0A=
 hw/usb/hcd-uhci.c | 3 +++=0A=
 3 files changed, 5 insertions(+)=0A=
=0A=
diff --git a/hw/usb/hcd-uhci.h b/hw/usb/hcd-uhci.h=0A=
index 3154837f1d..06433ce3de 100644=0A=
--- a/hw/usb/hcd-uhci.h=0A=
+++ b/hw/usb/hcd-uhci.h=0A=
@@ -72,6 +72,7 @@ typedef struct UHCIState {=0A=
     char *masterbus;=0A=
     uint32_t firstport;=0A=
     uint32_t maxframes;=0A=
+    bool auto_hub;=0A=
 } UHCIState;=0A=
 =0A=
 #define TYPE_UHCI "pci-uhci-usb"=0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index 0103038cad..f79337e7d7 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -46,6 +46,7 @@ GlobalProperty hw_compat_11_1[] =3D {=0A=
     { "sysbus-ehci-usb", "auto-hub", "on" },=0A=
     { "pci-ehci-usb", "auto-hub", "on" },=0A=
     { "base-xhci", "auto-hub", "on" },=0A=
+    { "pci-uhci-usb", "auto-hub", "on" },=0A=
 };=0A=
 const size_t hw_compat_11_1_len =3D G_N_ELEMENTS(hw_compat_11_1);=0A=
 =0A=
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c=0A=
index a7b9fe1317..36d4076c25 100644=0A=
--- a/hw/usb/hcd-uhci.c=0A=
+++ b/hw/usb/hcd-uhci.c=0A=
@@ -1213,6 +1213,7 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **=
errp)=0A=
         }=0A=
     } else {=0A=
         usb_bus_new(&s->bus, sizeof(s->bus), &uhci_bus_ops, DEVICE(dev));=
=0A=
+        s->bus.auto_hub =3D s->auto_hub;=0A=
         for (i =3D 0; i < UHCI_PORTS; i++) {=0A=
             usb_register_port(&s->bus, &s->ports[i].port, s, i, &uhci_port=
_ops,=0A=
                               USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL);=
=0A=
@@ -1260,10 +1261,12 @@ static const Property uhci_properties_companion[] =
=3D {=0A=
     DEFINE_PROP_UINT32("firstport", UHCIState, firstport, 0),=0A=
     DEFINE_PROP_UINT32("bandwidth", UHCIState, frame_bandwidth, 1280),=0A=
     DEFINE_PROP_UINT32("maxframes", UHCIState, maxframes, 128),=0A=
+    DEFINE_PROP_BOOL("auto-hub", UHCIState, auto_hub, false),=0A=
 };=0A=
 static const Property uhci_properties_standalone[] =3D {=0A=
     DEFINE_PROP_UINT32("bandwidth", UHCIState, frame_bandwidth, 1280),=0A=
     DEFINE_PROP_UINT32("maxframes", UHCIState, maxframes, 128),=0A=
+    DEFINE_PROP_BOOL("auto-hub", UHCIState, auto_hub, false),=0A=
 };=0A=
 =0A=
 static void uhci_class_init(ObjectClass *klass, const void *data)=0A=
-- =0A=
2.43.0=0A=

