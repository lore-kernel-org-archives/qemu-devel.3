Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544B4C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3VWZ-0002Uk-EG; Mon, 07 Sep 2026 05:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWX-0002SF-0i; Mon, 07 Sep 2026 05:20:21 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWV-0001gO-D0; Mon, 07 Sep 2026 05:20:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVE2jiKTjh3fHvt7nd25IjmsOMivwRMSJ5S1LTFz4h02Va7uVjCRZkZJBC+V/3LetwfEILgO1ilRlN5hcETLDZNten0K7ySUlK3uV9TF3zrdUVq8lgJsKEiBhuSKZ8M/qdrs/mCXt8pUHCG4giDG4sdi7zPX2LdQ6SfOAaZKhXhqX8SGxqx3NIsTbroH/Y/991i5WwvDESnC0Fxg/Mso306aGFNB7uDPlQQ7XNJGWFZDeWgbE50x9sYDEAHGuBkOv/Cmv7tQdoobN8NP7T/bfrp7berdi910FCQFfda6llR16eJTeGrXckiOrMMa0FJ0r84S/+FBQkElZpBytWdNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONmu7mWZVOdcv7kylr0GgtPkr4kkGqggZ0coDJCAaN8=;
 b=Zrr7w3S67nVI7YjbHbGNF9gGBdrN+Om+bpAEMPJrY6R3MuLqdlE9Aifro2YNGVvOsqSd+bleWlJ8Qj4gFziQDWz/ifErRX0FznnPzjV20UYqlnZ4zZSICw5ZxDgNFYOdxziTlHGDpCM+fii3gS1UqPNxmhzaCQ/5O7q/ZXUP00DoS/TlzxngNvipVYWz/r8q7osPotBekHou7xQP+cfY7AL24lW/Hm5tcsD6TlH5W14NmMxMncr7bIY6YZlQHn4Y9dEGwDap/SgFvXA8X4fXhmakOe0yHZCzc5+L8U0QTo0LA9Xx+y/ZE1UZ6FFeejlO6Fwbx2ZJfIQ4Yn7oRid29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONmu7mWZVOdcv7kylr0GgtPkr4kkGqggZ0coDJCAaN8=;
 b=r+rlQRjHKyBOAxRIrCbI0DuV0QJetg0Pt1zBfM8Ru2S/xZErh5PWeh5H14CPmSmWneRl4bD0IS+fVpWvLLTV1XjJKnyPOE0ukoFYPRXaAXffVTxu5c66KqR7rJGnyJSIsmi4qoF6h1skftxWzyhod/WpYrO9vVxlq3QRwYxkxlP4QdjaV0ymaATIVeyQgYO9Ry6x68MHjRUSUHvK/ciIffY1OV0PEjtAqrRcRW/onWjWkrX6s10vEv7PQOQnbOU0oXJ3q82DKzqbOxPlepz00MQbjaHA+ewi3Y9tnWzVjz1sUYDXKDwkyiR1W/2Ib5oH2WOnAbiov7HXPIWTXn9mTw==
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com (2603:1096:101:3d::12)
 by SEYPR06MB5301.apcprd06.prod.outlook.com (2603:1096:101:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:20:07 +0000
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c]) by SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c%6]) with mapi id 15.21.0382.012; Mon, 7 Sep 2026
 09:20:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 2/7] hw/display/vga: Move VGA_HPEL_NEUTRAL to vga_int.h
Thread-Topic: [PATCH v1 2/7] hw/display/vga: Move VGA_HPEL_NEUTRAL to vga_int.h
Thread-Index: AQHdPqoSjBzz/xOVJkyrQNLo0XZnjA==
Date: Mon, 7 Sep 2026 09:20:07 +0000
Message-ID: <20260907092004.2590015-3-jamin_lin@aspeedtech.com>
References: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB4989:EE_|SEYPR06MB5301:EE_
x-ms-office365-filtering-correlation-id: 2c572691-d01a-4f94-80c3-08df0cc1358b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: KH8nPNtO/StGYvQc9FhrFkaz5r0JVqcoWEc4KnA8602bcXGjX7mTD2kS71QDZwxkvZvtGWhCe7HnzZnGzuFNhBpLPhwVUSVIzy09m26VoDmBDNcakzmsjbi+hEP9QihKoQap/eXzao4xyzAyVAa2PaiVAIEbr799hnycw2dQh7NRdVJFJ4aozAQgqyJFU987xa7CYwE8WCZ8FcC7iMBClHcdA/B4ubaDMH3yI+59PiOYTkD0e5E0kogNbhMviyaT6o7bPOACb879xGV94DMqqaT/AdbYQ3KuC+opNMboNwMl9BGdI2+i68vBTJhr80mla5rVIo7nPGUNnhMsV2H45dvevZKxiCW5qnT53EVGACy0mrQzm5uFz4MgeJe+ra+mueYUP69GmMb7gtdUkQD26dFy34NvNvyfEsk1ffMTjBpi/18pF09LnQmHbeME03ryZw14kQZeriyVnxbh0Cm3uIN2kIeFSxIBbN47mAoPZFRacuOzBQfC9YNDkz24c/f0VHC1OmIKqMVaCYrFFnJA87fd/5OR6ze9QJnm1flaHuILo6IVdl773Q6jNQIRwNugbowm0FE8tANq4hk2eFPZHncv0lN4NuzMJktcS8X+UBBLx8dIsTlrFTf4fpSwfu+5YNqUIhTcEIrzL7Zy5Eu8MS7FqIBx7wKDbCB/f9XUK83o/kQcdX35phZFq2gB9jqq5k2lgiTvxUjZTexxyyzkooWhO0+7dgyudJxtUNLgpXQs+TT+5HUKpih64Hrlj5XX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB4989.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?y/aCWWDVWR+M4RiHEkidMbKX9A9qyxbCXdHQnc6aKO3bOH1fl8wCEvq6Ze?=
 =?iso-8859-1?Q?t4njZn+72+gV73+5d+Ly3mznkKD/ZQ0q5Jn47TAVn/8/bCyb8PUK3cqnIq?=
 =?iso-8859-1?Q?i7phnh+49zzgk7ZHRt0lnE5Oq90dHiQh6oyzCOBPnDDgRRJ2sllgAHMem3?=
 =?iso-8859-1?Q?oI6rZoyZjDEOhgnGSRjDnkAMVGmAkN0xKfJGM/6YD0fBoORpK03kx0lqfg?=
 =?iso-8859-1?Q?ooRQh7fM/Y9Nm9ZpRgao48h6BdtSqstf0EC/6w8Rai7gFTJedNbzIzdXPW?=
 =?iso-8859-1?Q?CjJ6mNNdYFqgmAp8HjXRj+2x8aiKOnZg0dJwARsw6oiEIK3wpt0+H67V2A?=
 =?iso-8859-1?Q?7dIUp0mbWNS1bITGPdI9pTY8bOTKOZFiLHIctWbRw7Q37kwQprm7vBZyjI?=
 =?iso-8859-1?Q?k8qTVohkz9uOdKAsqESQu8e9tknMA2aEcQCvXZixpnRUYqSGptWhY6Aqdr?=
 =?iso-8859-1?Q?bfbGGrmwiD/U+9eEYlTUtozrPouHg1kH+trKS7UcjxSCpsF+ujt/mF0KSg?=
 =?iso-8859-1?Q?C1y+9Dy1bnKZ+9KpXwSJ80SpqrA1bNfpaLWTNG4ch2OxLjVI7t+qmOBLEc?=
 =?iso-8859-1?Q?Mbk7jAtUHR5Cs/4lyRdqlGKmLeH9D//pyCks3bR3Sh6IcUcT8BNttmEkv3?=
 =?iso-8859-1?Q?vVQnJAwljrEvP/B+QzRA6iDIUMnUAV9Hfeqb4RBlAF1dfjNpdAhKLoECJG?=
 =?iso-8859-1?Q?HgK8MStbsreGJgA/n8KfaG8iMfkhb1gg19aFF5gXjdZCfsdZ84kNqUseO1?=
 =?iso-8859-1?Q?ZTETFESQrTDkGNJbAZB5K2SWFQSMj0s2OI+hTS4cxt8AIhYM0hssLAnNEd?=
 =?iso-8859-1?Q?zK//mgvOJ5In3BeGQ9z55p/JJaKnVfcaqYNWhaS+GC+CmGBdJ9dteQcxE8?=
 =?iso-8859-1?Q?dyjIvbc7LpvIFpKU7SwidwHWQH7NnrxnD+nxhFHgaNnnAkIh0PWqxAcxLf?=
 =?iso-8859-1?Q?J7MKuOLvHF3oe6aEJubA8KrURIVWs6mp9bpmE6e/Qc01B6OzeEpgEoJWwM?=
 =?iso-8859-1?Q?UtS3sVhWLKOKz284W//5ZpV3Y8W7Q4AbLpTEmpmtwPIOy8Y+IJrY4Ft7Dm?=
 =?iso-8859-1?Q?Ykwitd0tNCYOcrKExwy5rzdMQtBQl8r8drOyY+wfRxkDcoMgQA7ugJqfdJ?=
 =?iso-8859-1?Q?Z6DN3HKa2ZGzclFTK7NLS8TtbD4lsNypxGRySAscXFs21AxFCY7UVTdAgR?=
 =?iso-8859-1?Q?2CxQBChObNebtjWC5FULANZVU3RiejG0kIM1WNHaRcYiIZxosauNhb8OY6?=
 =?iso-8859-1?Q?/H5KtdfEX69+F2Suz/Y0zqvfG1UdYNvHqeTwKKCTAALoZSA1UNn74+1/Gc?=
 =?iso-8859-1?Q?H41Qzf6K3FZtEU4FSe/GWR2iSdBFlOk6ot2YqiU8gSsrdz0/2qrhjHwUT7?=
 =?iso-8859-1?Q?PqnGubaxyhDYu8DByqEj7GRHEDFRxZiJYBLc6GuLEf6s3Nr5JiMnSx7uio?=
 =?iso-8859-1?Q?rR6CqyENiK+aTDh8Ihl06OpJj5nzWjHSfp+pkCx9zwc0dJy95m1WERZdJv?=
 =?iso-8859-1?Q?rUYwibGDE57XRoBlFqqPKdhDsJH9CY/LsTFGYF9iCE8lwWKhBrnzWEhhN7?=
 =?iso-8859-1?Q?uBHYV2wTDdsJz0NO1Oj2Uz7shjab9lF+1crp0g6iHVStiDK2jVqkO+Jcto?=
 =?iso-8859-1?Q?EI0oskhS7SeTAkdY9Wa0zAsx8gOXk5EzvVa3BuI91gYeYqFKBXIhMGfB8x?=
 =?iso-8859-1?Q?GEcdnSdOAIl9J3802xtE+8nczljRwxT9HkVaZSDBOZNzpIweISKFX66lt2?=
 =?iso-8859-1?Q?tYsu1PnZiiD2kQC6Tak/IsoBvFjUE2umc9AOMK79Vgq3+S7gXvgBkREDuM?=
 =?iso-8859-1?Q?pcqGvSXW4Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gUP/OUMKN9o6At6pgn6KFq7A5JKh9F3NmxwvkuP2OjjycK01XkD+v1IzARZv+R1Iq4DQyyYRgpc4i1R8+Y0msV94hALFRr/mvBDWLvyUuvL3LsqP9ER8r+Kj0sdYYP76vViQV6ApC4UqIKyZ40BK6NsdWqRswdQlaAohq3otuw7Qwctc4o3322q4tJ/4NSWrmKdKq24TvlkIDo4cBxOtj3w3uuT/f9q0wrU1UEIXZrQNTydhEFdLCcqLp/zaZROL1FZas71Trxxl0xzj9+4HIXaAIdbXRR8six6f7bURy5qj9OAHV/MrH3ROY7NpnVEYkFRXsrHYuk7rmn/DvmqSIA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB4989.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c572691-d01a-4f94-80c3-08df0cc1358b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 09:20:07.5292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/L/jch0+TYviCCKeevtKVbQ8425EJQ/wrZms/PtNrISrNFJ4oagugtUsG1Dd0gzT86JbACXYP8blqfRzRaj9Vfj9a/dHBncoekDMRuPhb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5301
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

VGA_HPEL_NEUTRAL is the pel panning value that means no shift. Move it=0A=
to the header so that other VGA devices can use it.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/display/vga_int.h | 8 ++++++++=0A=
 hw/display/vga.c     | 7 -------=0A=
 2 files changed, 8 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h=0A=
index 68f082acba..978b05e7eb 100644=0A=
--- a/hw/display/vga_int.h=0A=
+++ b/hw/display/vga_int.h=0A=
@@ -38,6 +38,14 @@=0A=
 #define CH_ATTR_SIZE (160 * 100)=0A=
 #define VGA_MAX_HEIGHT 2048=0A=
 =0A=
+/*=0A=
+ * This value corresponds to a shift of zero pixels=0A=
+ * in 9-dot text mode.  In other modes, bit 3 is undefined;=0A=
+ * we just ignore it, so that 8 corresponds to zero pixels=0A=
+ * in all modes.=0A=
+ */=0A=
+#define VGA_HPEL_NEUTRAL 8=0A=
+=0A=
 struct vga_precise_retrace {=0A=
     int64_t ticks_per_char;=0A=
     int64_t total_chars;=0A=
diff --git a/hw/display/vga.c b/hw/display/vga.c=0A=
index b273244cd5..b951d84736 100644=0A=
--- a/hw/display/vga.c=0A=
+++ b/hw/display/vga.c=0A=
@@ -53,13 +53,6 @@ bool have_vga =3D true;=0A=
 /* Address mask for non-VESA modes.  */=0A=
 #define VGA_VRAM_SIZE                   (256 * KiB)=0A=
 =0A=
-/* This value corresponds to a shift of zero pixels=0A=
- * in 9-dot text mode.  In other modes, bit 3 is undefined;=0A=
- * we just ignore it, so that 8 corresponds to zero pixels=0A=
- * in all modes.=0A=
- */=0A=
-#define VGA_HPEL_NEUTRAL		8=0A=
-=0A=
 /*=0A=
  * Video Graphics Array (VGA)=0A=
  *=0A=
-- =0A=
2.53.0=0A=

