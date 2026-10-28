Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B139606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=JKNPEM/r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtTt-00056V-RP; Tue, 27 Oct 2026 22:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSh-0004QS-0G; Tue, 27 Oct 2026 22:32:23 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSd-00082z-QV; Tue, 27 Oct 2026 22:32:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vs2dQdd9PFFRhnFBQT/UDzKGtiBxQ1AtrrtMBaRR1lVOMNc0XA0CSRHUjGp0xn1pYrsv/JCOAFu7mzRVD97P2/YoIoDdMQzi+vxoXlHzbcGuXgX5xZrHgXJAN1keQOJH6JRc27H2L1oxPtOPsYlqPKhSr+/juoXeKy0lfuhj3L+Qy17QxqfaVYnibXjT9jxLuRfi6OuQw5zyNmblZ5Yibz40U81E6V4OP2f/lj1sJQtVeYaIo9Z/segt7hNOiq0y1pgku2CkEc8le75PeRfFqzoRZur9ydMyqTiTN3KpyYFmJuDUoRalpk7fJpKPujnk6xGIsHOL7wHRn8Mqm4PjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgIVTbGf40v5Hcv9ORTklGtuc5Agqj6yoA7H2Ml693E=;
 b=cRvCszCuo9WULG9AJjfXuVoBLm8VzXonpAYLOmFIBIxjtotNRxxEW5Q9Xe5y7AJ1ld2t2N93P7Lkc8GVL0mF7Lsa5sNyLHXnMBc9Z29eIQ0KIaRAJLNobF2q22CQ3VjSf1+qaNVhqR1JUmACtLCmkaxXnOXThwbcZ8Hq8eZ1bf+/EjU01br0zhjW+h73tyMGladJ+KVOE07dpm9xAjb9h8okGGUkKKhADXox9tyCMk2LWwuQn9Gxg5ABn1ceyld6cN6GH29dWjBfakwFVJlmba+8PmZRjv5v6WxLUQJW/+W06jUJ9IjZrtufvDr6bCAxepI532QTYYMp0swQN6bC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgIVTbGf40v5Hcv9ORTklGtuc5Agqj6yoA7H2Ml693E=;
 b=JKNPEM/rJwGL1ma24r4w0FIK+74Y+KyPdeLTOemKjarU6rLAC2tQCRT6ALL9WAyq4Xb5Y/TlGSd83YUMgvQqtYsu1CIxkYOmcw7Engs85RzigkCdVfTztH8wHfrN71meAcB/8td9tTXch8p/jibjsvGhAxyX/kLu5ZU4fC+5DdITv28bl66k9nz2XKwU5NUJ2D+WaNBZRf6sUk3SViLogqBdyyaYz3C8iYKKe7kbrNX3FMVxuN5KcsFuFtqx3Sx7YeKbJkiTl9EW15FIKERlWwRYQXw5pQ1kPzznqzljuAAtAERbMxCsAGjgoWhmisc56CtpqZ0RaXr146Jp3eN2qQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY8PR06MB9103.apcprd06.prod.outlook.com (2603:1096:405:3ac::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:32:05 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:32:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 10/13] hw/arm/aspeed_ast1040: Add I3C as an unimplemented
 device
Thread-Topic: [PATCH v2 10/13] hw/arm/aspeed_ast1040: Add I3C as an
 unimplemented device
Thread-Index: AQHdZoSFw6C7e9ETJ0SiNvGpwWRiEQ==
Date: Wed, 28 Oct 2026 02:32:05 +0000
Message-ID: <20261028023154.48395-11-jamin_lin@aspeedtech.com>
References: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY8PR06MB9103:EE_
x-ms-office365-filtering-correlation-id: 9675da2c-98de-4ed8-29a5-08df349ba804
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|38070700021|56012099006|261009221227099003|261009223027099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: JTsJuk+lSTrrxBojPmdu8N44nn7E2Vc9HUIcNfTkneU45tUy2Ze2SndBpwPbkzUTEivVth1Csctw1K/5/TCV7jXA3H35V9l+shcnWkVNcnhkmcSRbhVl96Qy6kR8kVbcSg7a14+q+ttOCjMnN7mJkTe+Q3d1MgYWRWvU3ABvRJjEOIl/ue6cB6u2N8GYflj3RtD+4tOK8rH3B6X/cH0fukFZGzrS8WHeTLcrQwnq2VF2dVv1BQqhdzmnr4/fNgKB9+ggVhwQff9n5BkT+zRWgkM3CASDLdEGYh3xkigB4+IkalRBV/8yq9GXIziO0GTiyjTHwe3Ca7HYBTRokJyeVU4ZGxZB2NocYQniEMrjqB2VbIrk2cbOrrEf0DxPSzWgPnZU1VBOv2dnKgikGPryGSuE1lCPoQJVNZpg4fdWwV1SsRqX9IUkdbNIxDT2bfrYZmcFmfpBdPNJBYw8H9j/GXGiX/uGDgr9U0vd9c+BAPH9EDVWRiMBO29CLE244gYkcobXWy2XzAlzw8guQMwD1tbTzipBRjJ6O9yw+2g4gDynKRh9ng/ySKD3z1n36+0rc86xN1uvrRMjgOwcd6UD7rECArNsW1cHJPe4Ha7oEEF0FZ4rtqzfa9S1xGIpYerZIv8tdYpgFdCDkEZBSj+4UB3P6crjlGGCSPiOumCX8Oy4D2FhFqeD2Z+UKb35RRb/RQySoIwGgJJfWy0lEfNLjI7HrhXYOZecFV/fNRgdIXtCi9ylff1pCDTBP4N2d01q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099006)(261009221227099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V//c4bJlF3XHTYS95c41b8FEfIEKVTLiMYlfgPWsoTA1Uds5cIFoGMWcig?=
 =?iso-8859-1?Q?WMz+qB0byxx8mkGQp7hN8/wZeBH5GGxKaKbqxCP3gxSkLKu+4ngmWSqz6T?=
 =?iso-8859-1?Q?FT39OR0G3iWxK4N2Yni/d8IIa0xEcnqduYEBU96nLMJauimxKSjNc2MCA4?=
 =?iso-8859-1?Q?PVhVw9Tau3tefrkPlV0obGSqWtFzpwhdK1rqtl7zd2o52vmaVe+tBpyC7Y?=
 =?iso-8859-1?Q?o2sa82JRKJO5cb8VKO9DMHIU+CZsVce/Gmm20x92R86tga7Li1v8x2e+ml?=
 =?iso-8859-1?Q?cntnT/Nz3luz1OnL6m//uTaUCGV3NPhYQO84kw4RDMkoPhHT1pj2enOAWa?=
 =?iso-8859-1?Q?vp4fRCQOJziHXy1v2OXEYglmCSK0tkr8Ig8c8bTaXbu0ZsDMp2yKLT4343?=
 =?iso-8859-1?Q?yt3lQYiCBYbPjX64gy4pfQHSH4DgcdPuawAKolue+Ne0hOgFFkuc86uDkW?=
 =?iso-8859-1?Q?rcpxLBCfUc51rLGM8zItFRDk77mS4YERXlAXm671oup9F91GxsatmGL9HH?=
 =?iso-8859-1?Q?M2KJjerlKEnkHGS/y4OmhzFSCsvGsxF9U2Uo3CpbG0/m8DDD23I0FJXgLR?=
 =?iso-8859-1?Q?nCtpmWTOObKL13IQGukxc3S0pVis38q8+DVj5ceUkMVJE5bm/4y9GbPN5L?=
 =?iso-8859-1?Q?NrLj3YngpZTDRU+Gn3BmMg/SfWuhFFCWpGes4lbCqAoNOn+X9qCI5XoLz+?=
 =?iso-8859-1?Q?L1F76QujjxfkZoX9k+V24zS1GB9/IorF36hOfWikY1NXltlPgdoQT5y41s?=
 =?iso-8859-1?Q?uvCLQk5iVErB9PU7YrAhUSt7jo9qqtE+/IaKxn921FG0QYwY+7K2pyTH53?=
 =?iso-8859-1?Q?p1YtT1KGIsDIOYpJE65I015iWLQBmji5GYKMvN9pE4ALeTUevXa5MVeDcB?=
 =?iso-8859-1?Q?GNOqqKV1DEHR5lSvQBdtTYq8Nrp9BqSrf90zkFsrk7bYLvGti8k8EJRHEf?=
 =?iso-8859-1?Q?Nh+bNWWRURwrGBbHRH38+8sODGe/4A5zOr/FkQh5O0jq3S6q3vnPGKhpKr?=
 =?iso-8859-1?Q?y28WuKsVhC5a9jxcvXM7uKxOgnozG5bgtXwAG/GooYH3H0p6FMOm/F39Yz?=
 =?iso-8859-1?Q?5AYb/dduWkJvWMGRTmRG73+mh3BgE52k6ajzEBGGpvMiy/nUEAhP+nk9ec?=
 =?iso-8859-1?Q?XB29bped8A/za9cyupIClGv5HhHBsFKNwqKlZq3rVERvGIMTUth9L/P0VZ?=
 =?iso-8859-1?Q?DvgJX4AnNXK6H567jeeKC7l+3ZQZRaeZM7QR5OiSiUa6rYSSqJPkTi6b9K?=
 =?iso-8859-1?Q?YbZ2cJ8u+Hu2zF7Qw5L2Yf8sCv+SB7u5oJaaWrmN3oV1K/k0bIGRS+SGfs?=
 =?iso-8859-1?Q?qlE2svJxyVbLIsAfBNUQgP4L1qc7TryPzMpHos2EpGjRMhfiCBz3FaovCl?=
 =?iso-8859-1?Q?3Y2tqk6RYnQsuNQ521OvYxr9ksEGbqBSatmG8XQT/KgGXrffIqwMi41K7O?=
 =?iso-8859-1?Q?otRtjlPMfcc2wwUJGSBIDL9VZuCbFy8RcstXi7ZrAu1qONJJ0q/S5kWxAr?=
 =?iso-8859-1?Q?mSmcSF6CoFy61n2v14ZlljTnEpjD1DgRyofjTJg0nOIBENNpQVHwKI+U8k?=
 =?iso-8859-1?Q?+OkycAJON6j2GE7zaHTqLu5VL/vAplckEDIDHMFqFLqHfcHdi4XMowCtc6?=
 =?iso-8859-1?Q?dTAS/etHB/JDXnRGGF2MFNEdWm2J/Ha5z+itFcvsBggh1DfxJIr9IQ34/y?=
 =?iso-8859-1?Q?UczI7SGOOTyMwBArPp9pVlWGGM0uV8x35s/lC+QT0fqt6me8ywFtc8vt44?=
 =?iso-8859-1?Q?0IwdI8qcsDrUyycYirUhXQOgtgWQnx5u+Hcd+1l8MgpaAcB6URt7PZOPGJ?=
 =?iso-8859-1?Q?UdMrUquVIQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9675da2c-98de-4ed8-29a5-08df349ba804
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:32:05.3238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFa8vsHoeyK6LQyF4V27EjYnYyVcmgSPZekytemIhaKCyBdquT4GJAfogLo92RJT0dFaMm83RZFsFF9bn/5bFqPSZ2LrZLQpOvK3jCNLsIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9103
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

The AST1040 provides an I3C at 0x74c20000, but the controller is not=0A=
modeled yet.=0A=
=0A=
Add the I3C register region as an unimplemented device to reflect the=0A=
AST1040 memory map.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 88f7a2df2c..5f6aa1503a 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -92,6 +92,7 @@ static const UnimplementedDeviceConfig aspeed_soc_ast1040=
_unimp_devs[] =3D {=0A=
     { "spi1-filter", "aspeed.spi1-filter", 0x74020400, 0x1000, -1000 },=0A=
     { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },=0A=
     { "atc", "aspeed.atc", 0x74C35000, 0x100, -1000 },=0A=
+    { "i3c", "aspeed.i3c", 0x74C20000, 0x8000, -1000 },=0A=
     { }=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=

