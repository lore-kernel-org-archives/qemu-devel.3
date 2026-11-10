Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5B606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=HH5+F6cI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHe-0008MC-D0; Tue, 10 Nov 2026 02:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHa-0008KL-Gn; Tue, 10 Nov 2026 02:28:42 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHY-0005Uy-Ut; Tue, 10 Nov 2026 02:28:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzBCr67OuR5cQvr0FK/6Ih3q6dN//VA+NwcsC4mb68DpELFwbECOoF5Vtw022ThR8lcgLl9+/PcsNWOl9D+Q3jmrPyYdlsDeh5R6aL76BZr02eOUWL6JjPQQvh59h9DK3dLXi8Uw5JW3zyQjL8I+wiGndfXo18VCFFNnys2+1dPRrQ1wPbQa4A0zv30vjApqB0P0xmHo+zmVDSb9yBYyMf76z+ANIa4ZqcksrF67bnxn1cjlK/18LU8rEGR6ds3vnGCSwa9cK0PZRfI3VomdCYmaVAkvCCZn0t+AiJndWmSqP2ZJizPwtmpA3NAN67EVdC7erxc0AbyLWNzDChHjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZhxLWOiGtzSIS3y5lqmp6RYDkXXe68z2yd+BSuEbaw=;
 b=Bca5LtJqp7w8Xt+xSnf+d0mFkTb0qF+TCr5vXspwk/2TO5bBE8c1bnCcBpOx3CNdNJc/orOtJs6AEAMGFBgXxayCW9ynQNql8UtG5dvHj0Rj4VFtHneseJ1UBOmOLX57R+Yl0sJhPqp+QsxYtjMJqIgE0JcLOhEhN/2Oov3bZ/iVbFR+vusBuAXbspTYdfiveW4IYEorEBbNXmlwKiAHM0RDUgMnl5lI12xG4bXa8264fGdjLT6VQh1R5KgBgEgNkFnMvakCIx/c6vbr9fry75XlceNpbIok83/qRC+IN26AxNX3wCAHgeFexiM/7sTUPP2Hhq7LiF8T/yJTtZUC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZhxLWOiGtzSIS3y5lqmp6RYDkXXe68z2yd+BSuEbaw=;
 b=HH5+F6cI4NktzN8VjpYrpOq+OjHrzd7aHlky/vpsH0+cuLhdR/zLT5s4xvYHL1NL/2XIEkZoyI/oVD8LL+N7GenxhrHhjtO/dfM/hMpc7QjxBgZxJLv/K58bdfbcTsHdIyNFAKVoZjRzle8z/c+32O5knQctHi48TCDbcEUAtWJ2zdABwrNdDxydyR+mkL79wzBMpWiTAuqPXGeLp2bb/fGO471IcvyLQz4wFbYUZXgn5Ka+DT1J8Xvn656ADFQ99K6jwSCZaKVjbGsf/XLTUjD+yWB0/8gzVn3Ur1D/K+iCEhVm1mkOuSL7lO3Nuppah7k/a5h5lezYdyJDBluGXg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:31 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:31 +0000
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
Subject: [PATCH v9 08/19] hw/arm/npcm7xx: Keep the automatic hub
Thread-Topic: [PATCH v9 08/19] hw/arm/npcm7xx: Keep the automatic hub
Thread-Index: AQHdcOUWff71LIv9akuWfdHfquZUcQ==
Date: Tue, 10 Nov 2026 07:28:31 +0000
Message-ID: <20261110072818.2883349-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 6228456c-57c7-43e5-9e9f-08df3efc3889
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|921020|38070700021|56012099006|261102123227099003|261021121427099003|261009223027099003;
x-microsoft-antispam-message-info: Gee9CFruU+X3bR+Rul0OYherWwHVlyaKBQykuZfvODSySqKFh8Vm2xkHNtjxqp2FxAmGoSQwsUnbGAp/1BmARkwO6B+98pQ8EdFPBK9cthAFHTIy1vdQho0IZBgV07RJn+J91dncjaT4Oas5altcWFy/Ai4R1ctVQc657hxUFcUPw7WOurz8D2903eTuKdfKLYiYF7Wvkseg+zQQxp8i7bIZYjnHFDu9C4x6uveI3cE1vIxinUF8tnEAKxhNQc5WA5R19tUwedxhMfOmeUmsXKUvxsxO8MOSzPdnHe89HN80bPIs2cVjG+vb6s1z+O8m9jfeBi2UDuQ4KhBBaPSWXi0QF7mMs8xv78U8zvNGzea0uMfCaVErNSY9mYZIRWvMx6IStOPNi/kWZsSDiRc5nk9n69wvjtodiBq+WkG5w8cOmHBhbMQ+d1a37tXa4jNmxpka6GpnM6eg9/lcxgAu3J+VEJNskQmKZSvTS3WIgIs7fpXx1c1Z2mlYUJs3Xw2T056vKlo5V/Beghdy4H7HLW7HUxbfKJDBP1iFzwV2zWM1VtAFCU0cqAX3UVwqDjT0e7JiosbTIyO3GhMlb1N0s+jC+Mxsfo5vdeqJGG+rPE2zcgUXay1MptBl+2u/0yVWuQisdMdZMbxTXe4qmTl9vAyqT+bMPCD28vcBxhisqYIKzzMChopJHebv8htI2uhFW25bCCxcg0RGxlK+qzXJrVm/sRW0iNlALSQsXHs7/vR3POrKFLvR3C6SjZhMJmXr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(56012099006)(261102123227099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A4CNETF8oczuDSO2UZ9uVwTfMez9oel9if8P68KhwbxUXyjB3UoZpxNhX8?=
 =?iso-8859-1?Q?YEEFlDPIRDZQiXMY/Oz3uIfeTtWya7Q/TqfxEBqpy31F++U/KQdtxVHSJe?=
 =?iso-8859-1?Q?HYPZgW2gFlvEBhNkdnHVoJN0SfiMr0i43Y7CKwlPQJDKPnpzhcsKwo7srH?=
 =?iso-8859-1?Q?Aqo93qebo/lhtSf45/C9q0GaYRXouKbE4Ed/eDFczpUwa/Wp04DJP3TXny?=
 =?iso-8859-1?Q?wh1WrXM4ARlf2Jy+3eAdbbcUSTiw+lqalZEBZColwbJ6z9DKp3LqDy06cO?=
 =?iso-8859-1?Q?7pBtacFevQXPBwYWKu0BeHscbhV9X/3YRON3u5OikRIvZeg6057X0Xcc6V?=
 =?iso-8859-1?Q?IybzbY2VKF/qovWenyQBb0iU3xiD5Kdnd38rVQkzz02MZo4n4UHXVRg/zQ?=
 =?iso-8859-1?Q?jIUz/2/1PTKTR/dSxoN+kKJmYSTUEd8b9Df/X4DkdX8BCftzGhoyYESLH2?=
 =?iso-8859-1?Q?FTlW7yGljkfWRhjeWp60eju9bC2fVFkF44igrs0zm9b8ZL6koakCDwfj5d?=
 =?iso-8859-1?Q?gVFdH4GoqMDc3cV/PpXxUVZCvg7g/J9xT6bFKWpmVLzdiXXafA13FBAM56?=
 =?iso-8859-1?Q?oNevqDZXXcAqRDdyNYXtIWiPYahrUTE3tkW8XTuEFr1IxYlkqw4sJDRBwD?=
 =?iso-8859-1?Q?g01laWUlWjy6zoWulD5sD1kFZ8GxUHX+WtICs10iw2iBwijaQtebudZpn2?=
 =?iso-8859-1?Q?SstOoGCj3hgP4EcjWSijLuxMr84ZtzTkTluBMCtGGYSJQiRlJH78NSXTIt?=
 =?iso-8859-1?Q?UIK+Dl7Ptt8JLU09VN4QNXjXqqeBleexQcnt7xRDgrVzbhd0aM0YUZF/Ss?=
 =?iso-8859-1?Q?w4omhCAbpJH93Cy3pNNV83jup9XLV6PX3utNhwYXCjoutU//sPVUYvhvdT?=
 =?iso-8859-1?Q?tld7WzjWUj3QBqFLa92ovQPPXxUNeWQjkL8zvTMPSJK2nl5sfy4muYtzoB?=
 =?iso-8859-1?Q?EPy6AqTc2Wp8c8L/2VyWw6d9T/5ETFzVkEAqZttfW53jYrSPGnqbID38Em?=
 =?iso-8859-1?Q?IlzTztsb1yVhvcpDKcVtW2Gvf68Y4PywkfDHaH01v/rE/BUwLEiBPYtgiB?=
 =?iso-8859-1?Q?a6OHSHLE5QvAPvMH4mdZxJV7TPVPL45Bz0VbkNgaFtnXyfwGThsCzm5HuY?=
 =?iso-8859-1?Q?1CPHj4W2xDdzwDooDaNNVNYrDQiLH7tpjq25noRRtDecSC5qn8gF+QSZgN?=
 =?iso-8859-1?Q?x8Y3n6dseoqZswe4+9ubGgdRmTGxdbd75NMbTVJbQl+lkyX5ycQko/yMI+?=
 =?iso-8859-1?Q?OkCS340lKPAfv9V2GkMvjw4IR+9T11YksfOcH0HYWoVYTnmPMfye0wBjCj?=
 =?iso-8859-1?Q?CSQX+1g7susQ9qRPkhDA8+zYfIaMQ6FJEDZt3H7UcV4FXRjPgkTvCIQj8o?=
 =?iso-8859-1?Q?rkaKAynYyCBck9tJqWJSciSSEif/XKIu3ij/7xHCn3+J2nAWoKgdsR4t5w?=
 =?iso-8859-1?Q?opOKXwN1/CUZF81OPDTh/zeJL5iR93Z8DxHr+TV0tMFwG3oL6LPysApYfq?=
 =?iso-8859-1?Q?4mhvj4Mmpqdz/siBhWKJ20xqlvs61vP/7A+66Ky0dLABahPaimRmnL7SrT?=
 =?iso-8859-1?Q?SCkLvgPYYMSBJwtwnck0B60Tb5AnDed/5M4tPArk8MFXG9wEIv7YPqye/H?=
 =?iso-8859-1?Q?GezevLtCF886CSK2DgKIJ4Jn+7piyuTbvSC6+W/SM268OcabKPPZMIpmWl?=
 =?iso-8859-1?Q?nnGUGXDoGnBbrkSv6pPHJ8Y7ze+5LpXCILl2tJkIzucyOziuBLGncXW29R?=
 =?iso-8859-1?Q?yxSAPndfBIpN4kdMR0AijCSCuT9b4ZJy0tA9mpL27DBhlNROrEVQsGSdmX?=
 =?iso-8859-1?Q?4aDNKtayNA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H+gp+Cle/VUXYcCX47+WVkHIb2awYEgwB6XBkImdTVRWro1QYNjISZ68UVIyYId3BDPTOyyUOyq2OxsOGIjsPrWtPSyKMf4zUVSqKCyFSj6z80wgYRUlCZYYZLI7UoPrWPqTjlLQZQZlh41aF67R3J0E4NTNB6Fen1dshwxFVZmKW3x3fsdMIe4fTnTpN+sKKG/YjxTYVaQ9oj+D2snxeuqpz6CC9JyPcXxUOYI0RBktjt8/HPNCyQSEgPJkO8wY0LsKHrGYHToCivwFhd8HzyuN7E0k6rjn2naEuzkTEIBFSvSyIuyygPwk9UlXeR1ge9YFmaTN1gh6w8UPzTllxQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6228456c-57c7-43e5-9e9f-08df3efc3889
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:31.1061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wyc0YA0LEeu5h+E0I1DWONaJi3jC3mQsEKM3uukZFTHAzNL+oRYDjcuxvj98PZ8mKR+dxsKz7TG9pVHFAVTVjL03YrT9ZlKH9/ehYU8W9fI=
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

The OHCI companion has one port, so a second device only fits behind=0A=
the hub.=0A=
=0A=
npcm7xx has no versioned machine type, so compat cannot reach it. Turn=0A=
the property on here instead. The companion shares the EHCI bus, so=0A=
the EHCI carries the property.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
Reviewed-by: Junjie Cao <junjie.cao@linux.dev>=0A=
Tested-by: Junjie Cao <junjie.cao@linux.dev>=0A=
---=0A=
 hw/arm/npcm7xx.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c=0A=
index 695f30a0dc..3f5b33d7e3 100644=0A=
--- a/hw/arm/npcm7xx.c=0A=
+++ b/hw/arm/npcm7xx.c=0A=
@@ -628,6 +628,8 @@ static void npcm7xx_realize(DeviceState *dev, Error **e=
rrp)=0A=
     /* USB Host */=0A=
     object_property_set_bool(OBJECT(&s->ehci), "companion-enable", true,=
=0A=
                              &error_abort);=0A=
+    object_property_set_bool(OBJECT(&s->ehci), "auto-hub", true,=0A=
+                             &error_abort);=0A=
     sysbus_realize(SYS_BUS_DEVICE(&s->ehci), &error_abort);=0A=
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci), 0, NPCM7XX_EHCI_BA);=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci), 0,=0A=
-- =0A=
2.43.0=0A=

