Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044A3C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwG2O-0001r2-7o; Tue, 18 Aug 2026 05:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2M-0001nT-Bm; Tue, 18 Aug 2026 05:23:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2L-0001Yk-2c; Tue, 18 Aug 2026 05:23:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsvu2m7gQFGNJsWe7mBIZsYdgM2RSR2trcIBVOwRoQvbOQd8YkMRLc9eCv0wRImD6zHl9sPUWKa4KbOktWNvr+xcqlTYc/ymShCi44ob/c1RjnWtBc9l/IX/iEybWhm1CgP4CUddzgZHkmDOBn9xKYWZSlYOG5qCP15zeh6aNA61EZMfzddweiEFGDWXskEO5JRen+0KBduYJInFxIJJ4kBph+iBaEhU/2XxSyjGmrCXBRRn2dk9FaxyFHl/e0VI+mjPbfx/EJF29pMM/83xweOd1dW/7Hq/jTiO3QXgjXUvu4f3ZTNyDDrTQKpNhUZ+/PI5Itqcn1bRoXs473LKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUYa1QB+yGOCHjUp/7IWpQv/bAN2pUMUiqN/sXjWFvo=;
 b=ZkoBS/uPhvzppZLEWR0YrUrrEs3Y8Z/fO1LXJ09yNeQIlqYzNmBU15zpcmYe2PJvxrJ+zCR125l9o/jJV/SrSmKqqhwmCciVB2FGmtxdLPWBosNT3KRqAyUxvDI2IiMLS3f19tLKS8dez0TMfwIuDergrKtTUYXovmlMnpbLx1WADhHJZxWDJOJCrA6sNujCXcccw5Fl04rFLkR6lo0vNj4EJwJmnLbLx1JWXvW/566mTaV3+LqcYG+zGh7hcaTxDJntt6c6Nv+jgARyFp3lbswgtN5+ovHROfDJ96bjH7SjzWtNgIPOkPQdSGa3vBkZIhCxbT4KGw8/39BqYa88yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUYa1QB+yGOCHjUp/7IWpQv/bAN2pUMUiqN/sXjWFvo=;
 b=CgPUaU+PNiIdKlPEhdMaWa+fiK8EvXBAsdS8+9oiAOE/CqK9DLF09Yehw/9/G11VKrCZVVvUR4YMAyDpEWupSGODNp4XgK6zz3EvZbgVT1X8Kgl2VYAMCUPvP3fC6f5XHUSdLRhgUSThrVtxGt5wMdRRKA2qiG9E03b5rswYujno8fUp+qVIDwGx0IgpFH1J96fp6rMwqxxL65nU0aWIIDW3KW6pm3bYJBT5NBoizyUv4g9PLzW7ZvqV4aw29rrkmjz1c0ysRobNV8boFMuYiQMMH0jqJP7uWAMDnjhPlEdHZnsHSnkO/J46eC8Tjk0mB1W7idqNGFQ6nOwpQgz0RQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 09:23:03 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:23:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 7/8] hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC model
Thread-Topic: [PATCH v1 7/8] hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC
 model
Thread-Index: AQHdLvMrfnkkkwz8Kk2kwH5pyGSATQ==
Date: Tue, 18 Aug 2026 09:23:02 +0000
Message-ID: <20260818092249.602137-8-jamin_lin@aspeedtech.com>
References: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5982:EE_
x-ms-office365-filtering-correlation-id: 23ee3f26-d45a-4f2b-3d2f-08defd0a4dbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|38070700021|6133799003|10067099003|921020;
x-microsoft-antispam-message-info: HVyWoslK42HkaHrQ874quMI7Y2HBrMm1Hc49rmqcVgW7KJFMQDM5tJNueZ0NexeH5mm125G0YVsqyxmnxxNjrNezkzkfBTufBBBdsojYnS/p4CV4HJ1OnKoCYEIvduEyrdZCWA/0BKxXMOW/PW6lfsfhF9uz1yiUwgpMRQJLbsjptF+JwaWdyGVM1ujqJzB+FaXZQ+EpzCmWEdk5Hpx5K0mEgoxp4C29CYm7uti/lJ3BS+9aj9wvzXwG6uOAkwNl0Z0hUwfg5hLhfVtYHiL2mBCsNJCCTZfV2nYhem+JGmNQEizqpAhZNSkd638oFci2X3hFx44Is8UG0d4EZ36HxWuargBtgdkhi5rj3zZdEseocCqNOJKByY7yplScl0C26M/jMyASayvpN5UBRGYVXD+ohz3LsBsarROk6jdXlBJibJ0oBYwj1lEnXCvk4Lfd2tE3XN6MJJX6a3sZr82sjISBYZJZrVh8ofSohuqZj3x0Pq5IKmTSNFa420X85BbSr1/rwTlIQmjGFyukGCt1M5FZpKZI/wi0ed4BfLv8QxkzR/ba71AsXcrfAoSvOfxS2ayhq2OcD/hhLQ5Pd+psi7g0rUzjmp4eYrROHkqV5s2nm4LYpw5IMXlx5n5MJZTspDWiMyuN8pRji2SZAyZxBVdU17e4e55p9CuyOxm3vUor1eksksIezxSZNTFoa5vXDBcggvpPeGv4ULyeJGNU4qcf1cy5ktW3Id8Z/rsWk/paT9ZWekXMAVuXltFYdoSv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0yB7mxhCscgviUam+gzrGeEmBt5Zm1cF6Qo3kdcoKAbIhYKSSSKaZs5a0Q?=
 =?iso-8859-1?Q?kw/2uNqm1jLibGktl7adEt4Q9DlQBuwN75sLU4a5avOvEjxk1iwOWe3M04?=
 =?iso-8859-1?Q?wxTnTYCzP6/MCwy/XwH9DlX4bGnqvOyQyMEG2kvTOX2EKdDzUYeENxAANd?=
 =?iso-8859-1?Q?kSgvR9rI2UtSXUlRXBzXkFHYyDABnRBLkD4ma9QLfBVrdue/GE4lbiiZ1j?=
 =?iso-8859-1?Q?PahWnncAi1asnCI6tW3Npy/yFNTiXFiHdSJeOzyax9iS1RZYFk1JPm5Stz?=
 =?iso-8859-1?Q?MSRCuSegYGKDGx4UlHB+/5tQbCPQGWfq39SrRoIW9urNGxcJ2E5uiEv9oA?=
 =?iso-8859-1?Q?Ny/ajcUp2m3/EiXpTpTlCwNVYAc3EM57XPwPrMV9ceFT9e44JdrLcEocX2?=
 =?iso-8859-1?Q?38tpdFi8xNga8Mid/iUyX48o4tgy1543i7j84gDoC7o3h3Y+xayJunFhQo?=
 =?iso-8859-1?Q?WrM7O6EV0JJLqeIoKGPoA6cxq+rhToHFJKAYIU0Sz7VjiugyJ9nQBd/oyu?=
 =?iso-8859-1?Q?QzGESCsr1y4DeaF6GCsVQnOe6kOh6KBlKtVBHzoMrQzW3qc9lZfddPf6SC?=
 =?iso-8859-1?Q?XVsxQpFz1+S0WqXZZAQsBqM9aujyjiqNjkZi2QOmyPnuLeMNSPrSJPqAo0?=
 =?iso-8859-1?Q?tLu7Qg/0OoqdAXbqyAL25McysKisyF3rDsUGwQMShbv4Tjr7Cg0lrqFKwx?=
 =?iso-8859-1?Q?In02IF0YtAvtsMZE9BvSWAkqWbnXVAzvC/PgUTKc6iDFbwqvTsZ/Y376mz?=
 =?iso-8859-1?Q?lRMr0Gmggb5NK50XiiBI8bf+sITBqEzsQMUfLmUQyKacwP98nU2gd0bsmu?=
 =?iso-8859-1?Q?4t4J8Nr5CjHFUaPjdMYWkpn/HhyjwSPPjQuw7DY1NRETz4LV+FSiFOGCo6?=
 =?iso-8859-1?Q?Ip7TZtNoPjCoinKPuTmaElIReqEN0Fm6FGyA1h4PCLmbqfduglOEAXQLl3?=
 =?iso-8859-1?Q?hWOsN4L/CDBGjtJfRQ3sEgWkQmiBfKS12PtblNpY3yto1xOVb4OBypqWR+?=
 =?iso-8859-1?Q?aTOxNvrLyaYpm6rsh5vSqqqPXNi3Vt/3lrl3cCYtJ1QdYBUlFvZQ9rg6jK?=
 =?iso-8859-1?Q?HPepXqgQg5frFuGY07ggnNH+fsLBDTFb1twYQyx5NjUZELFv2AYrdGnwsd?=
 =?iso-8859-1?Q?gZRRkzSa4i/Cf1bBU8HLEk3rKLoppkzFu4YlnRhnIupahBXU69CrUcN8Ni?=
 =?iso-8859-1?Q?fbNNsejvKv13Y3eIibn3ZeBQAvF9hkxd2aG4ItGc/xjOKdDDRHXUwAF+uK?=
 =?iso-8859-1?Q?aVcc7NbqO15tFXsoP1OFLmFKGpSYSZ7HEvdafwJrBCEtusSaRjqb7uHUBI?=
 =?iso-8859-1?Q?Q6twpIRUlDndhbfk2zBuasWNub1OTwAu1tMDXkHYgSl5ndUM0EHCs+L4lm?=
 =?iso-8859-1?Q?eDOvKWzfH/jV4/OxO/gAgs6KUo+wxs07jN1Er7IXVnS/SX0SoYTwpkZDT0?=
 =?iso-8859-1?Q?ZOnGPZIV72UydqhTSTMruqBX1NZj4A0hxxEimhPupKrjyj/HnngNNNK+8F?=
 =?iso-8859-1?Q?9WHDKmDlJbeuXI+hSSX4yDN037njRixTHifYRdXu4/wCGaOVwenQe0nG5h?=
 =?iso-8859-1?Q?fYbowU4qSOxExc5NxKOagdMlAduGHW4l6hsjIAbyAA28Yq2WAtYv6Bx+NM?=
 =?iso-8859-1?Q?FXsTuxMKdEiK2I2HWICcG0YVm8EP72OToI2cdnqQabTLN+klthymz8Fub1?=
 =?iso-8859-1?Q?S5U7etJsXnLram9A9zdDNi8wB2sdBxeZkBIVZ5WeSBNqPS3HZ+pqQjn4aZ?=
 =?iso-8859-1?Q?qGAWKGFiQGPcX1mUFdxd9i13U2OOFWsQj1lx8T/Sj5XBhMFWhK+3wotV9v?=
 =?iso-8859-1?Q?4DXumOITvg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PktaWWvSXGz23Av5HoEKj3KNCXLMoYSM99bwntCLibmu+UT9T36y70zPEZSG9BejXrzdde0nWuvOVzX8TyKeuG1oP0pjHQy7I+G1TqmGRStcP3XmlafhyReSb0QrqJOyGTDPRXPLEnOCLfMwQc0rcxYn5J1tgvGdnhgeNS/HPXJ5klidkX3Uv2pxn+GIROm/+ppXyk2SyrIpFJyBc7fgY+XEU6LXJS8CWk0DT7IpQXqVDoFurbhdq1R9C6eCkfOfnOOfCnUOVEmWRZOuzrFA4HiDmnjhlkacZAMK0lsehQg2LQtBxYdswhzkRQDBOlconagcjsffNR3r1TJ10imfeg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ee3f26-d45a-4f2b-3d2f-08defd0a4dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:23:02.8635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9kutjQpp4WvH87gAi60AT9cXKK8PNpii5XU0Bl/3ZUJ6J2F+qZWmvax7WYZqqey+Q5yAKpBkaVStuyJwshpMPlY+KEYHi7Tdea2q/V5kzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Pass the internal SEC SRAM region and its base address to the secure=0A=
boot controller (via the 'sram' link and 'sram-base' property) so its=0A=
ECDSA engine can read the public key, signature and digest that the=0A=
guest firmware stages there before triggering a verify.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast10x0.c | 4 ++++=0A=
 1 file changed, 4 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index 93c81195b5..8e34870856 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -357,6 +357,10 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSt=
ate *a, Error **errp)=0A=
     }=0A=
 =0A=
     /* Secure Boot Controller */=0A=
+    object_property_set_link(OBJECT(&s->sbc), "sram", OBJECT(&s->sram[1]),=
=0A=
+                             &error_abort);=0A=
+    qdev_prop_set_uint64(DEVICE(&s->sbc), "sram-base",=0A=
+                         sc->memmap[ASPEED_DEV_SRAM1]);=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sbc), errp)) {=0A=
         return false;=0A=
     }=0A=
-- =0A=
2.53.0=0A=

