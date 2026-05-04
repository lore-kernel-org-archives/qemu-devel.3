Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BBCFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJjRe-0001c4-Fm; Sun, 03 May 2026 22:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRZ-0001Xf-3O; Sun, 03 May 2026 22:54:01 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRX-00040F-LZ; Sun, 03 May 2026 22:54:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1M0wPEoMCcnlW4LYACTj/LLXW1CtpB3JSEB/+VJuc67+mXyjJinuuRyd8zjrkES2EZWBMQ/ctHyjG585r/LXBJK9w9Kmrgw1eILeh8BgdmnsZQA1njiXIgShnBRQ6x2PytLVAkLS3ZKTsAFig7jQhMFtd1vYyG2c3FrYtJNX4ZBZecTe39iDgAOmGNyvfA/Sue+nzwfVfJtNTCqCeHB97m5YnMXWZOIY6A21ArHddG5r5TmEIafXj+QNMksvOzmlss7CLwz5lQxmsymDKtG/bna7I3eQ3wZsoOb9oebvrB3oAhwZ0kpPibMPQgFdi0lWs2nk6/3Lwj2KXDUCK3Wtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n342GnTDJZgWAY0onIBs4Ng+w5/giWD5CWoq0ViXfaM=;
 b=y5Ne4kXDZ221tX02ofuQhecxXVeFwKojCfYKtbIJumHx/D4QfOlXLZ1wiOYGxuSVZPA1XK6CbVNgP8pn+KPuNEV49ss1iL98BbUB+WFPiCvfM2cPSikyHSp6eApjLmghduk6P61OXDjDSW0W/yhGUnGDqbnqBusZYBR87si/yQEPcFtpfrQ0l/Ev3VkNp1iJj/yUYsVVLEOu2E+n5GZ16nl8whJBFGmoNvB5lPlz/XA/ig6xWFdgiX9Iic6WP1CUw4B3aM9vuERHjIQbeOw8z+J/3F1OYAgNXKDfogMXNhObqxdgURl6Hygwlj89OJ9/njh2wH7kFfIGQLVhQsJW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n342GnTDJZgWAY0onIBs4Ng+w5/giWD5CWoq0ViXfaM=;
 b=NFicj1yc77hztW5nK+SHXiwWhJFYtG/3VzoRwc9B7sUrAQsmyBCXIykHRSuyfhjIuyLTWX6T5PsdOiW8c9UYbov0i42IzNunor5jgsrUXQgbemMp3flnP+5nnh2xd19gPNs2Z6AHGnDUwfEi7T+E24oGDsLVRE1K4IEKzqTps1O2eTdXOBmWxTtHyfgaQNCYzQFKtiG32Jz06Z8iH1MZGCxm7T2FdKiF/KxoCOT1QRIcLMxL+MmUm0nj21J/63SepTzE1aSR7bWtMpeDHtBUENL4h2x4s0XbH9GS0wfH3gssGiFt9EZumM9J9tzkGnBZpNyT+NfEZ/D+dA+RGoIiYg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5111.apcprd06.prod.outlook.com (2603:1096:101:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:53:51 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:53:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v6 07/11] hw/usb/hcd-ehci: Implement 64-bit siTD descriptor
 addressing
Thread-Topic: [PATCH v6 07/11] hw/usb/hcd-ehci: Implement 64-bit siTD
 descriptor addressing
Thread-Index: AQHc23E8qS3Mhv3SkkqA//NF/ZlJCw==
Date: Mon, 4 May 2026 02:53:51 +0000
Message-ID: <20260504025342.1452605-8-jamin_lin@aspeedtech.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5111:EE_
x-ms-office365-filtering-correlation-id: 0db081a1-21eb-4185-882d-08dea9885f45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: sRzeAElFJwRuVH63pPcc1pS0tbaymJj1z0Jo/uBX7RtjmyygeVvkk+btlTU8aYlIzwCKT2W/6K5/M8Nbfa+yW4iSPRNtz5113VEEe2zS5haely8bkvQ/X6m1ebblZfmXylAu8MzL36ixppoNEdMomwj0Nfjr1BOXseA5f5qa5hMMLkHSW5JulRDfIKlGdLkz/t1yYk0Qr882/IGOuZ3zBMfkNYhCJAh134zcejicJdyFRXHgXxKUZcRn75l/0+aMUuB+W+bQxk1FgvZCjv80lQAQ7UcfWo3UYjWd6OM641YgtxyNJ1e0QhQolaqE5w1m/um77wm+GxBFZhUvXmxnlVy3ubbeFrXeHkyZoUdP7FUXibwX1Eqwco5cxYP9XMvfUExPEQD2jcQs/wCM5MM/Z0QXJ6beZETXlGmG6oIBfg0nioUig7RjruATPczDta9Wp/i3WZSbFNzhW2pJvRsNhBS+QjbwhpgsCt6NJuyMnXcPjO/+bRDBFkD+c5mE8bFKzrM4pVIIXvG8WXUzMkJCps/R4jhMnPVRACdhl4PPS+ABN7odHTUMiTbap5l8Dt3Ju1FYlLTGMjVUvuEEVAFeKFJkQcxdh6i372Kmox0nZHFHW87sQpGqe0hKwScAdOyN3XPTmNxhn0FdJn0i2jieWsy61D/lyVzjlk5c2e/8qgrDa3L2xbCtjbvZw1lAFMIIRKMVdmF3thkHndDL+dHAzIsUPcWyFtvwwZj6iyWiJk9/vsM5SPHWLfsshX47bEJi1tWIB8iUVe/h4R+w9RFTlw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5BFmQ0mEx2yXaN2iWt/B2o8qD+3o8sFh9sWE+mfJrMejl4FETWeZzyIdkU?=
 =?iso-8859-1?Q?oT4SBv1R8o2/7ftZnmT/2hWCkFVFgBH7zTBHYczGQkcOLLrDtZWmAHmYPJ?=
 =?iso-8859-1?Q?ldXJIsHzJOuuIKG4gSOggvWzTlVgrbdi3M07pM0whuHaUJ+fs01K2DkluT?=
 =?iso-8859-1?Q?v7il3mHAQZ35PMYy/gmNJcevPl3oqAH/0eYd/mwCriN928/6Otf2mBRYax?=
 =?iso-8859-1?Q?WkKe0oNuOfAjADFhp6Fgqg7UDdlzkJi7Q2cqt/F7KyIb+i+Tm7IaJg8/lU?=
 =?iso-8859-1?Q?dahoV+zTFocG4xVPBWL+uBIcXj5SUQwcotZeRVbx2ZRwIZE8yAVJeiBaUI?=
 =?iso-8859-1?Q?vpFbIaKOwFQL/FLnTBgpBwMFTRCkEtI6/wjp1UFUD+cgPV2Ch6BUtuUlsv?=
 =?iso-8859-1?Q?GIk7ol5eckQMO3NAL77od2L5in35zc4Lsh5OIcRNOg2urbTZA4iCdJ9SeF?=
 =?iso-8859-1?Q?bsfY8+rptI3cGFzGkWUTOy4dXqR/bkS5rLq1MmSMrQsdH6zyDIyQo9BWfq?=
 =?iso-8859-1?Q?E/zK2qStqt/WGyOi8w6SKqrYznc3b0eISnH+tJMtmATF4Dk/M6F+5dnhKL?=
 =?iso-8859-1?Q?fb4DkvklHnNSjWK1Cai5p+YYtQP6F035KvYK7TB2dU59rjXt/sZVMiVokS?=
 =?iso-8859-1?Q?deerJT0Znx3E+/elB3VOXDETGPDW9a5FMMDPWlpKProx2o+Ku8k3u/i8Tz?=
 =?iso-8859-1?Q?ap23L6wyqtHOCB3eDVpIZt3jX6wBztGQNc50vHhPNNQlWStmkItyT28zTV?=
 =?iso-8859-1?Q?DZqtVDJLYZTWHHqB4Akz77jg3J48BqYYPfTNELRx4dPCJKQPuo+9sk+N89?=
 =?iso-8859-1?Q?niRzN8LYc7USmr144o7U4+1Qs9tpu+SedqWT9bbB6oFyMPF2ZcESSg368M?=
 =?iso-8859-1?Q?7S++j2jrxAlhfO66cAQL7KhK77gGYNwbCd8Xy0+p0c1VXzgdy2goJgCMZz?=
 =?iso-8859-1?Q?OExoQYNrr4Xl3nwhfUSwZgZy1uXdmfD1yaCrnQpm30bd/2wxTUCeNr8kV9?=
 =?iso-8859-1?Q?uyw6cBYUVT7C23km4tg5ii8LmJIxzPbXM5V3T/D7V9xhD3qVdSZJoJDj5P?=
 =?iso-8859-1?Q?VegEtIYscCw9t2wnYZf3mNo1mRuUUAPxu4FHkOTJSNxBc4Nu2LzAcBaBJa?=
 =?iso-8859-1?Q?rge+6GYNFXtiNNcCgTOo2yqjJSgkAgkr8/o0HiUR8OpixjTCctCTkrKSt+?=
 =?iso-8859-1?Q?RuoNNuH3v4xw+7kKkGasEATQbY7DTp6myRZub7/1q70s/yYDSxEDQqlz9c?=
 =?iso-8859-1?Q?Q2PIm6oMTPYp4/gabfU4oPtCvo4e8TmNhqT4X5cndHEK9U6RmUQFyWj9g1?=
 =?iso-8859-1?Q?GAYBsKwlWf202yJljYiwTY4vi/DaVVzvYjmMiWhXtvjAWxvV0O96dSbx2b?=
 =?iso-8859-1?Q?WIM4vPIHxSH8ZYR10uZxvzWIGxcauTKE9t0NT8RwucAZbEhUVfjImzdh2m?=
 =?iso-8859-1?Q?lKGCG+YYtt3ElG6iLU7ugotXgdkVTXzZK9AC5X4zmyTufD/cNwSAYjIGdA?=
 =?iso-8859-1?Q?tnmPXEguN3AiYTzfotzFcDnJ8HreAfz4u9lLwbPGLCeLyIhidguB2OFZHb?=
 =?iso-8859-1?Q?2ZyGJsCP5v2JXOBkgFaJv++aaJKtUjduU1VqwOVMHpl3uF+d42UHZOOME4?=
 =?iso-8859-1?Q?1b81fHg2AGvQ1YbDePMDJyPYH8AD7jVDKc8bq0kFGA8VL1d9mUDB+vZmRx?=
 =?iso-8859-1?Q?XCnzkiPSWa52jWNxBFwPZu0/jYQC8Lfpnv8tat/A40MLc73RyR4scOl1Fj?=
 =?iso-8859-1?Q?f0pJcaY+KMka/e8AIPUiw9w31J8tBUPhrgPnRVz9rzHSIkTpIBfyTZeu+5?=
 =?iso-8859-1?Q?UGUV166mdA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YaeL04Cb0P24ncaG+tEJk6UtfO+38HLK+1LvJZXCE/N4urxNTvXcLKX3vWmTi1qCTZ+Qi1k5aYDbOxzDvM9c0yhzbeSMlMdEND1oA5iI32JanqY/EbqzMie7rwDKtMYdbsfss9Bhe5CJFVtTsfPZ4zJ/LOoNiizd5+nH2Qhp1Qa5sSM2B7pMgQtq2g35OAgzwV92O2z/lu9VSG/KtjXSbAiNhiFYBTLUA1HBJUS+iJg5Eh5mSVoGFWv9meSVHkB9qPaN6PXqgzXPEzkuZlXVgNrLQcPhh5fw/cnIKDSSF724/EfnpGQYQrN/treDAZLVxxVLPgZ8RaMYcqEiMfrg7Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db081a1-21eb-4185-882d-08dea9885f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:53:51.1616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9c/+Hw3CCtmtfwwZQuumrC8uGpljGwdH7qP4LVpJUniEEWeZ0mtioERf2YS+DBXIJSZrRO4ThfrZkhXqbISCTlp4pgvY1ROyd9sdOs0asI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5111
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
siTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the siTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
When 64-bit capability is disabled, descriptor addresses remain=0A=
32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 611882ba1d..b1c7bfd90c 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1792,7 +1792,7 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int =
async)=0A=
         warn_report("Skipping active siTD");=0A=
     }=0A=
 =0A=
-    ehci_set_fetch_addr(ehci, async, sitd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, sitd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
     return 1;=0A=
 }=0A=
-- =0A=
2.43.0=0A=

