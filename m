Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB1606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=I4EWRAvl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHc-0008LG-GP; Tue, 10 Nov 2026 02:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHZ-0008Jr-Ng; Tue, 10 Nov 2026 02:28:41 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHY-0005V4-3k; Tue, 10 Nov 2026 02:28:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejoB3sk6/0WssDRQ8ZE7Wx3OYWS3v4xrByZ0Rt8QgsnNNsB/lJzMCu0U/DEIpxdT9ojUIvFhAejCMSacGqqPdVnSR4KPQ9wnKTGSp+HBvYySK2oqWb+BJ+zsX87i9D+dNv4pGHkx9d9MpmXt5Ek0j2CkpD5PIKikCueuV3hhMyKAr+LQ2E3lB8eJrUyALxCRPKa8LVn/5K1cHYd7GeZk5ASYwukUdaP5nU8Vbd4K/ZpVUruE9ZGVZhgQpGEH4glM1nG9rW/ffGYoBsRYnWdZkT08k8HGXRe4T+VSbuqG7+ZQ5vDfT5NeXMpVWnWyrsjm9yIaMkA8qSm3nOIs9WD6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i+dDbnhs/ipwjDDII73SF8lfh+KFUTrj5s7rxXYH0w=;
 b=wO8LGOJbGNrnpJnKLwW78CdjNcYZsgYegUmPl5IrNEBlavQpanVlpqWtkYLax4QzRjXIqE6KC+KtfI3pXiH9Z4u6eE/mNbEyvnQjCf9ISxG79hg7d7vNCZZ4QXq4xTLJledGloZACEdNffxDD82RdIANr6jQmGQ4y4Mb/ZHH4uK/MXJ47+KzyvouszbwWAwCAGqmSInefkshB1rZ5liLS8Rf9ywBcAs6WoLllVkOEzdknjsZ87q0fBuQjbaZFARhaPyEvHSF0ER6WhnVaowO0GfNAl+wCe/huOzSX0YkhFdvsKoJAvGec4YNtGKBzP9vRrchUuhClXYA7IcMZ4xBDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i+dDbnhs/ipwjDDII73SF8lfh+KFUTrj5s7rxXYH0w=;
 b=I4EWRAvlWWL0C/kJ8NubjHh+I8WH1HteLy06WZc5hNe4RPuApA8xbzjSCiucBHOv9l0G/nbQPTDeaEZVuFSYqn3NReJeMShJ4QgRD96BDjV6w9yaJq+eULfck+olZ4oo12rj7QAThN/+1omZGu7KB3W6N+TIFci7XVhG4nwtTaa9pQYiIUGHKLAoE5DQtNlVJLUllah8eeu2BOMqeE4TVzBjTVOPn+H7znGidloepu6U65+ANuNQsDrQaOwwXYil/nXaVyzds6ctA3OLHYTbrhimUFktufCbPArVnHdZvILLhJp/pOOZPs9CSbc3hhEsXjzyr2QoMzHbnocMfZfqAA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:29 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:29 +0000
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
Subject: [PATCH v9 07/19] hw/usb/xen-usb: Do not insert an automatic hub
Thread-Topic: [PATCH v9 07/19] hw/usb/xen-usb: Do not insert an automatic hub
Thread-Index: AQHdcOUVAdCkms4ACkaoU6ZRpD1Y9g==
Date: Tue, 10 Nov 2026 07:28:29 +0000
Message-ID: <20261110072818.2883349-8-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: ad4b9653-041c-4c75-1a6b-08df3efc37a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|921020|38070700021|56012099006|261102123227099003|261022105027099003|261021121427099003|261028144727099003|261026140227099003;
x-microsoft-antispam-message-info: L0/rerVcKKu/comJoKCPSshfDPz8O1GJqs7aUQl1sCIF3N+liTh1DA7Pg0RpkDfrK5iDqzpTNZbxaFuEMFHY0MFDAEaDWfcKAlKlCaI0BA5U/rIQLLSysbvIZGD1vx9jTlFmsiOxD8onxg0kVTVLobya/x4pQKoqIbDPEvzTlZTeWygmsv2D94fzER53edqKfrfCby6eeD7xi2xY9mZiQ//zPggR1hBg0pvXyXBTosifjz/9Pl57ZlbxbWpwEfA7W408w2NacU3vZp6rvMEy8wDKFxQRSwcUBjFagXGVkyWJApvwi47bTr+KBuHGIOxUWndhHie2SI+S74cTiZv/lmf9zx+5c68FjzKa1gDWWXpftjKexYfm2P88uzxgGdaP3Mx+If/xIaYlg8nlL6aXHsTNXgQBCvX9MqwG3TxxldDTx15RYzHHcbraYhYwC2NVU+6AgTjpzUehtuibBxQjcH9tec3apgwmocSpDHcGXea6JmZrGi1ZhG525t5OSyzDElpYzO7Tv3h85p0c9QK3lycCeWO005UWmQoxWrZjiZkBvz08ykdJKlAXjKGlXsLTq+UPlBq4PEYze574coFu+CDInUywSqQjQoFhNPOg8k40lq3J1bGGIhnxnZLOCTx2ioCHXLnSybfBye1vxOv1w9BV1ExjqI5eytbxMqlkbYwBkdsirSmJPYpUj7eSvrGd8LeRmsMnHW2vJJgP44POSZSpVuLimNstCppThykvc0IlSyvuxKyYuSiSbyl32aX7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(56012099006)(261102123227099003)(261022105027099003)(261021121427099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eWzh/yHwlh4IsoDyzWmsmZOSXoH/MxN/MXu2Sir6K63EceLAJVVyeHTF8s?=
 =?iso-8859-1?Q?Mvf0faKpGSG/J+RYmBa6MOBc3dq6ognjxq7Dp+ulOUEcLdwLK9sYeKAQuG?=
 =?iso-8859-1?Q?ru4ghaMuFdnTi0XHtH+9pO75Ky9WaDgIsCsZ91/pf1mmLw92OF8kqoADUy?=
 =?iso-8859-1?Q?R7te8jvAgTILrDUf9XhgMUIujw7vW2IR3a9v/JjNJc7pUMrw41qysQcPVo?=
 =?iso-8859-1?Q?A4Qwa8hjw96Go/o2H76zHdPXYCvqMbbeU3MeiShfMo1EvBpb874EeMu3bC?=
 =?iso-8859-1?Q?WVtLB/NCELG3QCla2lP3OzAitUuvM4E+fjmCvCDh72n4ywZ+zXMIDm0Tuz?=
 =?iso-8859-1?Q?sX2Fd4YQJiVo2StrJsCTQ0pXeP3vmYPim4fA2WuiBCSEsCLaUePjHU3S2K?=
 =?iso-8859-1?Q?QVhX7nHNgQ9fNBfc2XYnv7Av9jZFzirsQ0zEC1MzeISe7OCE/AeGYTI50q?=
 =?iso-8859-1?Q?HzRIkuhtXlhAIEb4K0UkhGUZFnkCZmPKauGwsNe3hUogMesW5tEsbGhhQO?=
 =?iso-8859-1?Q?4TbEluIZcjAsdnjBXSVtPY92nAjcKKt2Km1G1QU0us4WJuY3bHTqzMRkhq?=
 =?iso-8859-1?Q?6lfF0m5hzu5qQpAdoveKk5D2fsCqNtudpO7pwlIsoG0ME6ltVGf6tFhaF0?=
 =?iso-8859-1?Q?eegtXljCzP7QxHH5v9P6gH8dJ4pFXmGxC78BZBFT1ecN4opmaZ+HdsXYWP?=
 =?iso-8859-1?Q?46x4wVf5pdXGOiEoTkbZ/W38dc6yR44O1DyPD+ckdrxVzgJ6GRwLgxfG9B?=
 =?iso-8859-1?Q?Y+lt/7ivg61+Ti135PvkFyjNeZvT/8DxT+LBs2QWdQQtS3/0ovfwV6aGPY?=
 =?iso-8859-1?Q?sZoniZ4U/sUyk3qa0wNZxYRVtAnp9sy9ABGoIXbuY0I8vBpd+Jhxoa0owQ?=
 =?iso-8859-1?Q?uKxsYFVxYWQBQyDAEdjXyHdnk+a5GvS9ijDiM4AQ8GTi0htwhVKw3kBcdE?=
 =?iso-8859-1?Q?8eQh2NpymmOugCM2VkRS0JM+OOXG6msDKzNoJVhUhZeS+E1i2TrzWaDQkh?=
 =?iso-8859-1?Q?+udJn8cysN0CbfvGqEoSw5ONg5bVwRz/vKivdH51wmZ2o5y9UfMRHtWQ7m?=
 =?iso-8859-1?Q?yTwVMprLGCdi4FMloWLC3w1ZuGweGtFO1CSnIaSkVu+5AcWy03JIi7S4lQ?=
 =?iso-8859-1?Q?+L4R4JJF648kJoncdfqz+yM1Obs817ylYrkXdBrzGqoo2U0vPHzq2i6aXE?=
 =?iso-8859-1?Q?ZSsJiOSVtkSw1cz2PjOm0m83Vazb5aUNPSOgopjFlMfw0tPLatmZJ36pLX?=
 =?iso-8859-1?Q?wx8mlm6WwSXlqalrS/06IkvitF5YMkOWedFCasR5aitBLTQ9ArgBZ11ZT1?=
 =?iso-8859-1?Q?vMaI6XK6CvSzqR5FpSqNoqOkTRKMZ7HY39lPsqBJDZhn/OqLjUgFYRioHU?=
 =?iso-8859-1?Q?jbgOD4a6sp/TMZ5zujs+FVu8Gn0uefa4ku3Xbk/ofY2/yshYQa8MciZqIj?=
 =?iso-8859-1?Q?4auTdXRfXJTwZwX7pb3z/RT9hN77ocNcRRMlVnUayDChaDp6iMxchHemTv?=
 =?iso-8859-1?Q?YaSSNlk5QwNAxmz+m4k5mlx4nQqo9Soib6+Y4dzXKHlDYVVcxD5Rpuh96b?=
 =?iso-8859-1?Q?npwr3znaDOMJrshsTwUXkUPheq0luRivaeAhNtwlXKDXh963OzseIOxOa3?=
 =?iso-8859-1?Q?dmPdHaL/9tygfE5r9zO6T2atvUceTd0E22vm4smAOxTnXZmH3C3t2Bp+Bj?=
 =?iso-8859-1?Q?ZwEkPqiNdHpJ65MOwdmXUBbzNlx6T9aiFK7neN2iMJzu1BlkrgKxhot/Ye?=
 =?iso-8859-1?Q?MwexXjFC6Oa2VhpuvDOF4nZ8MMt4IpmVw21hQyM/hlPRMIFuvn9ekFhkjb?=
 =?iso-8859-1?Q?9otmSm9zuA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xSl/kSXCTE+N/vGPYSjy6OKGxd7VDRflcAR63dEcEmF5J5VIEgzXVWaGGePXIM5wGmuKdNfLLF0H2OFUX8pD+7uC8KkE32UQyDV5LRjpih0+4ZI8rtMCoOz1AZfiyXsNbYouKGvDRJ4LH0V10yxZDzJZhsa1l54lcYxtyu8Os3cl52CdG5/xOaWoYUI8Lasb0l4Fz01u2tngzcdLYcE42uzLi+IPFS0C2mlxR/NMn0SchlWa6cUHPflyCfJQBBgfrxjPF8NoigR7cblM/eE/4fxZO0l9aAervczEYXvNWqTWl7u77HT9E6Wtg4wn05//zBn4Gz8nXwHs9+JfTBYn9g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4b9653-041c-4c75-1a6b-08df3efc37a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:29.5365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nd5nV6UlGoYMU/KcShuZjbxSjk9ep5FHuSBZrykTM8wCO6OjT4nCYmWcZsD1aTWJxqsJJEV/mvDUJ0zw7jdhFq+Ra18pVo178CbloZLGoLM=
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

xen-usb gives every device a port number. usb_claim_port() then uses=0A=
that port, and never reaches the automatic hub.=0A=
=0A=
Set auto_hub to false. Every bus creator then sets the flag itself,=0A=
and usb_bus_new() can stop setting a default.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Acked-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/xen-usb.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c=0A=
index caf9efbb77..5d1dbe6b1b 100644=0A=
--- a/hw/usb/xen-usb.c=0A=
+++ b/hw/usb/xen-usb.c=0A=
@@ -1023,6 +1023,7 @@ static void usbback_alloc(struct XenLegacyDevice *xen=
dev)=0A=
 =0A=
     usb_bus_new(&usbif->bus, sizeof(usbif->bus), &xen_usb_bus_ops,=0A=
                 DEVICE(xendev));=0A=
+    usbif->bus.auto_hub =3D false;=0A=
     for (i =3D 0; i < USBBACK_MAXPORTS; i++) {=0A=
         p =3D &(usbif->ports[i].port);=0A=
         usb_register_port(&usbif->bus, p, usbif, i, &xen_usb_port_ops,=0A=
-- =0A=
2.43.0=0A=

