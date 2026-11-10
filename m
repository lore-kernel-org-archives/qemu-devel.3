Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86E606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=e8YrcNDI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHU-0008H2-Cd; Tue, 10 Nov 2026 02:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHS-0008Fs-Rn; Tue, 10 Nov 2026 02:28:34 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHR-0005Uy-8h; Tue, 10 Nov 2026 02:28:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqRaT5PxhVxCiDRtDzpVKYP1QrHXuzjTp7/252LBHOUGBjylmROusJXBSEBgaDgnb2+Gq4spbabX18NX96nwdhI2opeaVg6HOtdV7frXMAaRRTAOtlhDBRcgexP6vpmJTN53eaOWydK6EB94gyyH705J3faRgbqNxnQSVLdpNSNuT8q1OvMfWT76xDtkp8sBgnlbin1FDJJjELGunqldiRQKD65jW4WjjaXCUtOa1krbs6R0fawM39eoM9RtIDcqQeE7bEy1Nayl5WNJZtqJpx4k0JGDqeD5Dlk95cWx40KWel2yRgBowakNlwH3PDgwAcS58XnAJzqjD4iQ6UJ1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEn5J4/xL+6NFpbWwN9XjuklnPKdDus+6J5yPzw7GCE=;
 b=YkJ/EBa6+Nfo0qdTdgZkrm96UYgsRKyjerBBmSCfO+8n44Cn7Z/4NKhKtzKEUazYZZ4oDFl2GPk2Hf8KQ1K3S8w+mjxfoQ+xHr7Djo35BoKydM3MuN1yJirqWId1ujMRIsLSrphx9BpP3X+LEGakrvu3Dl/QiG8U4DPQT0Zz3AYErD9D+PnNdrMORg3i+sh+jGOvQgY9gwozEc0AJitRxqwSAUJwPiHWCCK+Yx9B2rIFAjmeIH2PEXdJODQm8485Kwe6P8yNrtWck51+RzJSkmFYTLCr2zi33WEdPnU3HK9UAKuSIhw9UlfvqKrDp5MHhOFIAD+4sRQ9al01iwLuqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEn5J4/xL+6NFpbWwN9XjuklnPKdDus+6J5yPzw7GCE=;
 b=e8YrcNDIIaM3fsh6cbyQrOd8mq41bDGexdRi1XEayd9HltvNSx9kMeDrQJvNttHFzKEl6MHLcJ49DIYV104UGriUxKP/pwrjPSJnGueA6270JJw8t9etrhq/aFUXcB7ofMXulesM57PZb7AWCv085zr54oDiJK0SEDYjr/fOwLb4lR6cfJ9kzFElB70Ld/nHXNlS2Rn1fosVLtAM7490TfwHpHSU6MdM2LdnxAF7tjCjesWwLj0+jdMbOIufmh7Vl6nbxzG9s4nepdNJrJmCbr8PfkfnJF4Cqoo5ogWcZ5oYA36MTvr3HiaGflpdb0gP7fKdVtTYG+ukGTqASPcG2g==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:22 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:22 +0000
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
Subject: [PATCH v9 02/19] hw/usb/hcd-xhci: Add an auto-hub property and leave
 it off
Thread-Topic: [PATCH v9 02/19] hw/usb/hcd-xhci: Add an auto-hub property and
 leave it off
Thread-Index: AQHdcOUQXfrXBCYUM0mvE3FM5SGv4w==
Date: Tue, 10 Nov 2026 07:28:22 +0000
Message-ID: <20261110072818.2883349-3-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: ed827acd-1ac5-4b25-aa45-08df3efc3350
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|921020|38070700021|56012099006|261102123227099003|261022105027099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info: yOg6nAxUyll3hXchSONhiRD9UlGhNi8xBEjYSd0LriJhQDGWNAZxuGPJtJLBgmOCkbVgcd84QRJWBcl9tgUymI/9tcMNLutk0nU8jz2NHVUiD4XvQJqmovbsNp4H+xGUr/ZQvSD66XV3Ui+HLBJWF1bp4A4UUm3ybjUWinlyGMEXD9DXgnjA/5vPWtWeogAuZu9+lX+QC0Gbr3uQd3Z+AsyteP1+qMQ028eY/g0bdzmWgcMpTQyueqcUcpzmS2ZIkMPqXv+HH8clhgVZzPAtD+KlhIM3YvpKHnnKrScjCg7EYnRTMjN/TgWQLMqtS+998QI9v9HLlWzG4voa8HBo3RpEj5BFfD9cMsp7Lklr5yddys2btwUno08vG4sQBW6ytRP+AXRDBBXvP33gkPRYQL8m/82Ul/KmDCpWZOevqvVNelwI5ky6pHfcE+JDwZG5/loTzNykR3ipeU543OIZLFwKlXGiWBZyEBCe6G9/rYElQL9PIdl5uZr9asRKA2ULDJkSxY/WO+XV5IWmqNS7yc5qiGpHlNfUzTJRcBSFVHLy5uSFMuJpZnxihDQkMJpRya9TKMdfu6pVIVJjGMna7+QLm0fTfCTzfUF7ctetVRd11YnxHPsZjmVtYyz6FtKNBysE7hk9v8ICh6aErCFe/3FEuGjYVt10tszdZ1QawcCf/a6abkBf2KqxXua8s5lSPXXSLNwiMzrVdSgkQX905c9h1uwwzoyLSx4P1zTObyOylLGCVOzSN1xjvLAvvG6l
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(56012099006)(261102123227099003)(261022105027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bAs/kyL6gZzN3GELe3lWHQXU15YG7aXA77Na3TPtADRZ+Wtjrp2q7xJxY/?=
 =?iso-8859-1?Q?PZAODZAXf2rkKlMAkp2dmdJkFfzCvG7o7jUJoZH11+eZPs2dfmG9lWX/x8?=
 =?iso-8859-1?Q?3ZhC0Oc0XgCcZoF3Fud0C5dmcpcRnyvfu9D2iSwbFIKnGbIqofuefE3THu?=
 =?iso-8859-1?Q?P2VFq8CH2V8Vy56A3bsIuRJl+HpB3d0iBwJVohgTx2Gq08HJey/k0G3kub?=
 =?iso-8859-1?Q?JtZ703VREvh0P0LobX9FJPmcNnBIoYoqas5DvfKNinxN4HQOcH9PYFND1q?=
 =?iso-8859-1?Q?ZXpihxzZZhOWGHqgJfSj0FGfM7/JlOocgWy1S4zHoUX3C2/o/Z5kzIbqkD?=
 =?iso-8859-1?Q?2ml+UQVqUzl7u3xkrKjm3lp17FS+G/JpmW98FMGlxZa24DaKbfroWj09hD?=
 =?iso-8859-1?Q?H2WtCl2qoyANcJrU48EFuPdIU9HgCeSpXDm7niHmSQFY58QcOplINTrPfQ?=
 =?iso-8859-1?Q?lZC9W7LYjNs/ukg06pQsHapPiuTUDJ+Z4OMtiKZ8YIZdT5BlOC5nfKfpml?=
 =?iso-8859-1?Q?NL8IjB55oZ5eVWD/7wncoKSYvkpZa+KA5uE5gG4exVV/9ex/oeVg3KBbNZ?=
 =?iso-8859-1?Q?8NwO8Vzkq2z8N/H1N8ZBdkyznsPO38lkVUWOwKbaN9xEt2s7e5M2CRJPaw?=
 =?iso-8859-1?Q?Awhu1QGLViqmBfI8h1y9Q8StC6+vvgf1chtDBkr8GNN68NCtp7xEGrvIlF?=
 =?iso-8859-1?Q?twcx/IqVBOdKrbL+Snh6ALbolQW2KHQKOTb3VPnXNLC0vASDPZupHID/Zg?=
 =?iso-8859-1?Q?YlPilSzd5MOuSOX4o7T4PBa80UfzjYcBPx15c0am7Cr3fstCT8EOMmBTkJ?=
 =?iso-8859-1?Q?VXm5Yf5FtXhGBao/3zig8E9En+6sQsmUPnqS19fzNeOGNFVhPELJHSH6C/?=
 =?iso-8859-1?Q?/Wiq/1I0rAwJpwb6ADeVzo5d0ZpSAslEHwcuzjS4U/TYsiNsG8tIIPhPpl?=
 =?iso-8859-1?Q?9v59CisbgJvh09MCeTRINOtU72ah+vPoJeT9gwHTRErZ8c+aAg7QoUyEQj?=
 =?iso-8859-1?Q?7um3a+OTyaeD53Wokst1/nDatyB6AZdv+LxetsiyglfBNmwcv97tW0GqTl?=
 =?iso-8859-1?Q?C+TDapaXooUKeVCKhWI2wGnYlkC1Zxw2ga6XSWSkFw8+Wc4wd0mxvIC91h?=
 =?iso-8859-1?Q?tTG8GwZWqkRXezKw1UenGMS2AcrX0ZAZuLXF3EOUBd/DL08Q/kcetYClOl?=
 =?iso-8859-1?Q?cBVo2LnBTX0f5dJ5f8FOpv3yLtd1H8ByS0NQklLIjfY25cABJH1evCuXQ9?=
 =?iso-8859-1?Q?uXRDRwBLRYrolG4lr3NKqD7ErAB3ICnAsp9F9QVcI04wOeVKd6OiAp+KYN?=
 =?iso-8859-1?Q?1bxko2O9VFuCVHWkyQUmgEK1NAamtWyK5V36gNS/VNj4mTB+1zTMQHdPa7?=
 =?iso-8859-1?Q?4t8Afkmbx5djxqlF0iNbnBnNoBfnZDC7096RdxQqEl+X7k29ABMqSk1AW6?=
 =?iso-8859-1?Q?0+gkHp40hx1PEDzQw9h6WXJlfjbEh8HBah9npxcQidQrn0OordYJSUYza/?=
 =?iso-8859-1?Q?Ab0/GTjXQEBw2rAqZRe+0pqbruOkKvRGX5YHETn4eF5uoumRiX1mTSmq/n?=
 =?iso-8859-1?Q?QuSus2+/3/cCSWTtfG5Scup7siS5FS212ftvfecgj7LtuPaqYtcpzNqMdk?=
 =?iso-8859-1?Q?iTnErlhZX+ig6vnc0QrvbzlzRtvtg9BqRl3hyt+ZDG1xerKOBoYuW+JWcm?=
 =?iso-8859-1?Q?v+2WDLC79OmDbypqsfbquFvMdPzBBm8bcvAeax3fnpy76103tsffwxO/5I?=
 =?iso-8859-1?Q?qV8mmCg2GGKYIX5rom4NHPPt1XAzWK+paRhIhC9jNghdg7vj/5FMkG2SrX?=
 =?iso-8859-1?Q?cxF6VrdRCA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5CkVJW0LAOWreYKIy34BlfD7HmuOlaa3GC6nslar8Ni1NQ3szHDx1SN4RkClQuBZ4oLHKce9fXcJSUce5aQMDfoBUHMkLhQz03PDixHK853tdqKxbIWB48fi+yN12Z4W9asCw/DW77YgfLN/II4sJ2C5+1R6weHU1unBMTCUAqo6qPihGoSrWPwofpl+8FHcC+e3tt0tUA2XOn7aW7cr62bWkF+S2Rl6himJCNUT4nBqsNNbb35lcfU/Nrzb8ceNYWFcY41sT8L2VZN2hT64he/oIEME8cEuzQP7n7iTS1NVWabXYQXoPvQPYZH7dg0oIWsP1VcyAUMMrw1uqFxvhQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed827acd-1ac5-4b25-aa45-08df3efc3350
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:22.2890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCo7wFZn561deRuk58UlUGTJ+f36H2l+JxI5kGra7WEZijtXVp0iOEHurIR2Ly/zV3MXV+O+SsUUHypukAk8lhnc6BDe80NxhlF0B02tpb8=
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

xHCI has up to 15 root ports and does not need a hub to fit more=0A=
devices.=0A=
=0A=
Add auto-hub and leave it off. hw_compat_11_1 turns it on, so an older=0A=
machine type keeps the hub it has today and a guest saved by an older=0A=
QEMU still loads.=0A=
=0A=
TODO: Move the entry to hw_compat_11_2 before merge. The series goes=0A=
into 12.0, so 11.2 is an old machine type too. hw_compat_11_2 does=0A=
not exist yet.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Reported-by: Junjie Cao <junjie.cao@linux.dev>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/hcd-xhci.h | 1 +=0A=
 hw/core/machine.c | 1 +=0A=
 hw/usb/hcd-xhci.c | 2 ++=0A=
 3 files changed, 4 insertions(+)=0A=
=0A=
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h=0A=
index 5cb9e06d1d..a3eaf2ebb6 100644=0A=
--- a/hw/usb/hcd-xhci.h=0A=
+++ b/hw/usb/hcd-xhci.h=0A=
@@ -191,6 +191,7 @@ typedef struct XHCIState {=0A=
     uint32_t numslots;=0A=
     uint32_t flags;=0A=
     uint32_t max_pstreams_mask;=0A=
+    bool auto_hub;=0A=
     void (*intr_update)(XHCIState *s, int n, bool enable);=0A=
     bool (*intr_raise)(XHCIState *s, int n, bool level);=0A=
     /*=0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index d9ac4b419a..f8f5b01117 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -43,6 +43,7 @@=0A=
 GlobalProperty hw_compat_11_1[] =3D {=0A=
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
+    { "base-xhci", "auto-hub", "on" },=0A=
 };=0A=
 const size_t hw_compat_11_1_len =3D G_N_ELEMENTS(hw_compat_11_1);=0A=
 =0A=
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c=0A=
index 376bc00264..1e42c851b4 100644=0A=
--- a/hw/usb/hcd-xhci.c=0A=
+++ b/hw/usb/hcd-xhci.c=0A=
@@ -3377,6 +3377,7 @@ static void usb_xhci_init(XHCIState *xhci)=0A=
     xhci->numports =3D xhci->numports_2 + xhci->numports_3;=0A=
 =0A=
     usb_bus_new(&xhci->bus, sizeof(xhci->bus), &xhci_bus_ops, xhci->hostOp=
aque);=0A=
+    xhci->bus.auto_hub =3D xhci->auto_hub;=0A=
 =0A=
     for (i =3D 0; i < usbports; i++) {=0A=
         speedmask =3D 0;=0A=
@@ -3660,6 +3661,7 @@ static const Property xhci_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),=0A=
     DEFINE_PROP_LINK("host",    XHCIState, hostOpaque, TYPE_DEVICE,=0A=
                      DeviceState *),=0A=
+    DEFINE_PROP_BOOL("auto-hub", XHCIState, auto_hub, false),=0A=
 };=0A=
 =0A=
 static void xhci_class_init(ObjectClass *klass, const void *data)=0A=
-- =0A=
2.43.0=0A=

