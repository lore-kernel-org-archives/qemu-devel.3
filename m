Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8795AC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 02:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvnE2-0002Hc-9l; Sun, 16 Aug 2026 22:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvnDx-0002HH-H9
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 22:37:18 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvnDv-0007CH-Ls
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 22:37:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mE8+PPXLu3rgQ8gS0On2sLlb+L+tNSw9cDkXswmf5pU4eo5WEtHpswuXh5rpFuwzpICG5hR1dUEnTqM7kNgnWKW1AjCMRQ9uaPfjVf71WO3lCQlXv1hfSOu+wO3DhtMmhjyLlQqAAF5b0h0eB70zri4AnXzRh1vHLUn0k4rc8Pfs3dyumN7kxshKP0A2PBvZ/x3sz2sTg/pngAO+ncwpCCclfXDqMyhKwvfvmmNa0wb7GzZ8a6djPgGQacC3QypmraYMPmgp3tVFGMmk1P7oxbbKZfy35v8tDL2esr78GFC9GQ7dwGX9vTCsSt9Z8uHicqnRLrExD+gRS2AHUgovaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPYI4S5njShbtGg2NpaZ518A98BZhrc93EnOFbNcP2A=;
 b=pGclvH3gvbbu+22oz5ZsQAmQL/I5XOcywtEap2wl5tdb0FLvptCI5I2AQwukNhDPZpyzC5Nps3lNBURqRNSrcHohKgc8U7IyuiMuzAC8pY4emzGRrvBDAmvqWYJBF0WjFA+IplI9eMe63kGBkOMJGQ0hGb21OLjrb3vVk+9VaUAt9hpZBBTc5ecbX+WVQdQTTDQmr/qgMsMBab8gDorbzhlVTo4ZPK5Kvg0/+cyi5PcTp4JpH9RrVWgH7SmUxaLDH2IeG+RRYth5FgLMDK9m81eztP9CZ7C03wrIfHbnRzhwx66dmCGNJP/Kl4PVrz/UGwLMfHusfBixhMzfglRYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPYI4S5njShbtGg2NpaZ518A98BZhrc93EnOFbNcP2A=;
 b=q2OGX23hWbEuMd5DIlDMa3X/PRfYXoAf94XoDhk+CIokClQ0wz3P6oLW9srC3Ph0iw1+yZtKAXfswBUcyAowE6o/G9Hb/sEUqIXHYnNqcG8nmdYfGzQGJvd87oAx6t9jnbT8vvZiXgTUXjek7k4Di3YCedBR/GzGqooegEO/w3QCFQVMeeMJ7u19205gIOGqcLczXdKgQIEJv3kKiwSaacksi6OR/5hOCjMxQZnUHWqrhqeZtEPGK0UTU0Hs0jVJwUnQv44k/wVIbgx3aLIkXB/ZviTIQAxMm8YztSkXyDPdALx+yYpEwk1+PKRONOuR7PNRkMtsHXFVhvIFINYwBw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6591.apcprd06.prod.outlook.com (2603:1096:820:f8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 02:36:39 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 02:36:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@redhat.com" <clg@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "philmd@mailo.com" <philmd@mailo.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 1/2] hw/usb/hcd-ehci: Handle get_dwords() failures in async
 writeback
Thread-Topic: [PATCH v2 1/2] hw/usb/hcd-ehci: Handle get_dwords() failures in
 async writeback
Thread-Index: AQHdLfE6+YKK2JdlsU6cDAo6pp5SnQ==
Date: Mon, 17 Aug 2026 02:36:39 +0000
Message-ID: <20260817023637.3082135-2-jamin_lin@aspeedtech.com>
References: <20260817023637.3082135-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260817023637.3082135-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6591:EE_
x-ms-office365-filtering-correlation-id: fb726543-2d98-404a-7cf8-08defc085d7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|18002099003|22082099003|56012099006|10067099003;
x-microsoft-antispam-message-info: yJaF7l6nPrYXYMVP3Og0EnpJ/HL3mmuvwRoJ6N4kiSe5fUNnB0SAfNGu87eVCKCUZtZtKVza3PyRezJd7o7ldtBYQbyJLh6a4W6k2ypVYuFTWZLcfD+yQQTwdI6qgl+Uc8gPyNlLzzlI/TiDiBI4GItDr9wAY/uqHYVF50DIqnPvsBK53UuB0GQgcsQ8p275GpHqszzr6gsJx458PExsa/RKOVBNp75o3lY2KVtd+FUhUyTgBZp0E9/6OnbTtyMqe49loa0AByJeyZftLaOZut37uQmIOl06kxphU+qclOUsiaS/gTaEzql+0eZBnCG0Gtvubfyr+OM2Ml5q7rllOLiYpngG3uWc2wSNo6/UrHMjIX6fuRhCiM/H6EcuXgEfApZQOrBKpp4WzEV5tS5A3RS5rnMCgGsRwPFAIMATa2kirteGQ02TYZaC9ZJa2qq7wxFKXIFJG83HXN8DQc6uPetofLD8Icl2YSDFzvc6KxuWqzEcZqJwJeDRETX+521WyVv3Ttaw4GIuyXLp4AE3mf/Zs984E7pck/lHS2i82KqgCog0Yv++iAEYuM1H3fZoEtg7ggermW7yzwHa+j3pKNAtUT5HFv9QnNmBzSzqZrRlJfERMN0HcfqWrEZ5+C5q5RZUco2TSx1f7XvaYJghGDdDGIIbPE+JfDMLbk9gawPpRx18jse2O8tpdiQvSeDnErk6WxhpgzfXhY/hrBaSvP0cobD70n0J1MCpOOnrS/0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RzC5FUFWzG3UUumisV6vFUCi+e/jp8emCuV3PhiwVct8LLTXrUHIpxh34a?=
 =?iso-8859-1?Q?ISO1DdRXkca2yiT6G/PA/UOXl+d9DJ55KLb/3ibNPOi5N/skJqp6CS/LZW?=
 =?iso-8859-1?Q?RfrpoBXa23pHGbulifWNoo84XPdjLV5vXsZD9PtYD/BiX0CqMxHj9ZNLqH?=
 =?iso-8859-1?Q?wv8yqiw4jFtXALFc3CratNPxfdeCJgZGpamFcFa+A44tnNQT+LGH4iCwa7?=
 =?iso-8859-1?Q?/iEINa3Vudxf3d/9Ud9WSBAXJkzTfVur5oqyDMFZbgrHDQpFQr/vY/knN2?=
 =?iso-8859-1?Q?qhy97OLxTJKKGTonVAnZZPfLvYGEQDRRyhDoqPWu4IsV5OQNqG+bSt98+L?=
 =?iso-8859-1?Q?wBw7euTilPvU7MQmhtwxUj2KYGsOwagpt5+9kTnBvtW69jXkhqUI5TAL8D?=
 =?iso-8859-1?Q?b/LeABSoK0+Ij+COm4098I2TRudNxNnKoftpMqkVWZAFUbgi+qF9VeOezR?=
 =?iso-8859-1?Q?4c9pzIXcQHhIe6pONmI7GDejUy9OmENUuqfqqMXqNWxhtT1v3A7Z858vV3?=
 =?iso-8859-1?Q?oIzmwJ0heBas8ubybjjNEyVbH0kLgoH0LGNMpDCMV/vj6l0gj/nNJUc5Zs?=
 =?iso-8859-1?Q?ZiZZuGuLbnxPzfuTPRZriiyx8nx7ZNwZdewm36bjMWqHoVRsJYXGgrkSzU?=
 =?iso-8859-1?Q?TZ4D9WPfQLJfewOjurqzv1AWqjnP+a9gehR6ljeHq3PxIdU0orKoyyEfm0?=
 =?iso-8859-1?Q?Oq+Sa0561Qxv8FgwwvbghKaTVCnoW/CpJU5kj6OC+EVrmgDC3kZtpHGiIy?=
 =?iso-8859-1?Q?Bz11WuhTiFzcO7C0hwSLFd1yjjen5XjycVQVb423EWVDhaMT3WLv0zqcYA?=
 =?iso-8859-1?Q?IIAr+UrgtR533cnJJGj50N/dcxVDPA2tZq6EWrd+Vrdoxp13J0NxF8gJik?=
 =?iso-8859-1?Q?uz5Qb+DaA0wmxZKKPeTEACVGuqdq9dy+ZFIGIXUbQ8zwEXvptAAHvHLq2r?=
 =?iso-8859-1?Q?vNqjHAgcXWjydubpPNJRCgMuSbsKFaVNCKEgrvM1Qe71fJAWpDwHzzRsQM?=
 =?iso-8859-1?Q?Gmw1kCXLOOR9Bk9A3aOZ5zWCUdtjqZZETG5TleW+WTrk9vRVRSLYK+75tR?=
 =?iso-8859-1?Q?5A+ZYFxrrkBUEqhp4dj9FmHyoOaXDSzSTtfwjEsxVQHHksQVjgyIGO2gbd?=
 =?iso-8859-1?Q?GH05VQ0qeZyPQv7K+ZBLr3NXFKWHY6+xl4Luhrl/ToDRYSvh2yGw8wmIe1?=
 =?iso-8859-1?Q?lY6VV2rEgZCg2Tc+xNpz4tdN1kK3p6pRMcq5gZpnllFXF01cwUvRMQ19kI?=
 =?iso-8859-1?Q?nf0TIFGkYWJ55lx/a2KzBTBzQsdYhAmWwC7/8vhclWoMmWXoMTzLOdF7DK?=
 =?iso-8859-1?Q?qkj4mr/gCDGo0Ga+JOfb82hir2+Wz9/vEQ9br9BYHX+ZLVmOOe5N1O78Cw?=
 =?iso-8859-1?Q?9gHW6/4q4Hh21VZQv64j22IVASc/vjgP/6b7pEYTNDVtC7Xr81EebJjv1A?=
 =?iso-8859-1?Q?3ed8JeTl3HAlxYb6tdtAfeTR4tUyUUH4TWnzKMslj0uoAawDGoz7T1cGDp?=
 =?iso-8859-1?Q?/DD1BVR1YMMS1Px8lrKUNEacAWv62JNXmPNcVfX9MbwHus+/sdAa3D5jKg?=
 =?iso-8859-1?Q?mHaUtTG48BKpZ0E8Izu18IuFZ77k9ISO1R2c4QdN078XBjs0N9Nr4ZnPzY?=
 =?iso-8859-1?Q?815ZiVa98O2nMzd2UVSCa2s09c4/nap13lDDWdv8zPBbXzS1ElC0EGTjjE?=
 =?iso-8859-1?Q?RNGjfm7l8+O20F8nXW/peDqK2qdAJLOtb4QRAeqfA1OrAFmORH5VonCJka?=
 =?iso-8859-1?Q?Fd6HVKJEw7D2VRdMwnjRd1bKYpUP6/BxtxBAn+q+VVCFt3qCG7EDTKskHd?=
 =?iso-8859-1?Q?oBbUoUXOBw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb726543-2d98-404a-7cf8-08defc085d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 02:36:39.1077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ld6NA3VgzecFq2UVWAjUMfzDjbM4RXtQF5OXLXff3tnei+Mbtjg0VfMsJkg2V1V8ZobBxtQoE9cg704aPlWjBG4IJmMW06lK8tO1jwbaXXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6591
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

Coverity reports that ehci_writeback_async_complete_packet() ignores=0A=
the return value of get_dwords() when reading the QH and qTD.=0A=
=0A=
Handle read failures in the same way as QH and qTD verification=0A=
failures by freeing the packet and returning early.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Resolves: Coverity CID 1685236=0A=
Fixes: 2b3de6ada5d ("ehci: writeback_async_complete_packet: verify qh and q=
td")=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 10 +++++-----=0A=
 1 file changed, 5 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 451a918e9f..d43951975a 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -533,11 +533,11 @@ static void ehci_writeback_async_complete_packet(EHCI=
Packet *p)=0A=
     /* Verify the qh + qtd, like we do when going through fetchqh & fetchq=
td */=0A=
     memset(&qh, 0, sizeof(qh));=0A=
     memset(&qtd, 0, sizeof(qtd));=0A=
-    get_dwords(q->ehci, NLPTR_GET(q->qhaddr),=0A=
-               (uint32_t *) &qh, ehci_qh_dwords(q->ehci));=0A=
-    get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),=0A=
-               (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci));=0A=
-    if (!ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {=0A=
+    if (get_dwords(q->ehci, NLPTR_GET(q->qhaddr),=0A=
+                   (uint32_t *) &qh, ehci_qh_dwords(q->ehci)) < 0 ||=0A=
+        get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),=0A=
+                   (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci)) < 0 ||=0A=
+        !ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {=0A=
         p->async =3D EHCI_ASYNC_INITIALIZED;=0A=
         ehci_free_packet(p);=0A=
         return;=0A=
-- =0A=
2.53.0=0A=

