Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3ACCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 05:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLDZm-0005Fg-CD; Fri, 08 May 2026 01:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wLDZk-0005F2-0M; Fri, 08 May 2026 01:16:36 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wLDZi-0007Tx-7v; Fri, 08 May 2026 01:16:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXJpXK313Yk0zNc6dzOlgohfNwK60wMZr+oYhzcOhC7ESb8k0NWdnnGLkzELDdqAfQfq4uSXJsm1TLnitaczOEfjkKOHzh/zGzESiJUj+Jmfr8AkVVo7Y398lydnmqpv/5B4aY2xZwmvHj8S+2ZvljTixMHZcSX9qfQArYATUgdE/kFB9nhEpO8Aw1E5xBCzF7HmBFeD5nltd1QZ5F6HkpzKUnSQ4zRkxrmojJTTEmWWmzZGqUtIPr/1ZVWthTgsaEtuKDtCtPLBI8QLbqhQjgRq1bmDejDl1iEKDpGy6ZbLJ98hHmyjYlPKPI6Z8gWIGOKB+NPGlygvAxCSUPMkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwnyaB9KCNKfvq3dm/l9D36z+t8/GubQoGmaT/zXTEE=;
 b=IU0cnpl0okjV396kruk9T0/g50KSN20aYKQd1dY3jSuZ9KFz9dvz6H7ZgXgGFjZPv/oB9GE1hUEfH+iZ4W0lbgVeJSs9j3/z5Vs9GuNUhVcO0Kw2QLBIJF97yHlEbg2Ak+Ui96vx+8ziJeAsZTTmurtv4IyLR3yshqPgDQx7T9g+attmp5jREBFAqSZpqIe+CexNs2FFNMgCq5OsJ+l7SWvr/wUZx6TEJzqxiCZL2AT7VfOM1wlat2PZMgmo1ntR4Tso07RhY2hiKQMWPZ951A48UqtaSMPDcpFTCKjbsgMEiEp5lmgGLsRWKviXVffzLAL6MmNHDr/wdIZM0/Cqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwnyaB9KCNKfvq3dm/l9D36z+t8/GubQoGmaT/zXTEE=;
 b=jv3p2Xn6//HJKu2B5btMIKEK3ji+5ADiCaULHs24jIC/FcjLR47574m2vBKS0/qBp7EcKVZpvyvUzkTyHX05Imm2+DhiwdFdNv/bslXn4nlODersquIOZT2U/BjGUPOrfqOEjQ2D+oMVO6WiWjABDRRcPcMiQ4WNV5R22SiO3SE70jP+n+pjix8W688BEb5CQlYPBtuB8MWAUVB7LVFOMCihO1I7ZqPiRuQstFVCrjxZS0oCBqdOwQSE2VcvSD1aV2o46hVTpnagWf8KwQPiMVTflRZ6+UEWMd3F4NrWbW48tyUfzaIq2JsLb7R+RnH0hX4wikHW319Y+RXe8jTvHQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5885.apcprd06.prod.outlook.com (2603:1096:301:110::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 05:16:22 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 05:16:22 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 1/1] aspeed/hace: Fix mapped address may not be unmapped
 issue
Thread-Topic: [PATCH v1 1/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
Thread-Index: AQHc3qnPl3aK51F7Y0aXhHDUgxk26A==
Date: Fri, 8 May 2026 05:16:22 +0000
Message-ID: <20260508051619.3887383-2-kane_chen@aspeedtech.com>
References: <20260508051619.3887383-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260508051619.3887383-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5885:EE_
x-ms-office365-filtering-correlation-id: ed031fb7-a7ed-4dea-7b02-08deacc0f1d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 4pQ2Nr2orAuBoYtRMq5Bd4H5bYCpGkD1cRFOoD7Z9/sV8hF0QRYspO7AGX+KZO3iSQu/m7360VQB8RV3VeGk3xF0Vyi5WMCROrTAvwdOSwoBX8H03fNp8wWqDaJWco9ab0uuD5vAmHjb1czQySOOjbBXt1AI3Gnj/BXNZK4srzc2zmkKAorNEvESzUK+O9wWbBqhbyhxaS16aIp9TPFDeQw22hOBrfvAXOOTutshjty5FYLIm5GysNhZ8/NBlDGGQ3nOI29U10gp3dR8JBxYvi8/v1BH2hO+car9vbbkucwYdSZoP5NYLv09xnyz42WCDR55ez0C3oTgIEJaW64kzf0OL1cD+vggFBvoxLjAbTViZy+mUsrqKVBFM624swZ20kEL14zLy6i7Qza+R45xkWawf00UPySWb+G6BfxBoxyG2bB39YfVfuyOYOyahnYeEXAGTfQpmQcZ1t61GI3oMTji9VKb/q9TCM/roqlbv2pL8aPVo3kBRHDZ/7QNVtWJS5oWI1WhYCc+bCB4xd/8r1PnoN666ngiQFP2RR+Kl0g8xVnCYo9tzKvjlYLBpr1t8E6Kd+bVIbj++8YTEmw/zzOXVC3HUuBbqDqWUfgzv+97wyUutyvwSKhpDKM/SCygP+lj+nhmx+Gvy1QKnqvjL9FhZwFCdo2fGx8JeXrQjRkatVP8C8mpvUW0X5ymtpZ8rJnmLgW1Rc1+0VzN7IHDrP1BBa+165p198egfIXvpecsH3RlwjYl9cVM2DZcjL1t
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ShrXEzuFeG7ZYNpqxP3+22DIBXyNNA9NiULDGvf21bfPMKlTmFmcuEktcE?=
 =?iso-8859-1?Q?RpM19qg+LMOlTm9XQ3abTzanQUcOYejFwMF6MBtc8b0dmi4dJlanOavsMS?=
 =?iso-8859-1?Q?IjuusMjnFZRG0YHVricfnuUT2QqNivC4kcYLquIu4/ojpq9w5f/TWFBQFz?=
 =?iso-8859-1?Q?ZHsLKFUhFCdZzh0cDbHZ+KH5iDHiGWZvpw3NTf4NcPFXqhHqavhtcPA51c?=
 =?iso-8859-1?Q?pUrPOSVc3G7l/XXYyE/vVHjgVKDAqOEdLrZpPwPPmW3UTtEsir6nQT9Nm7?=
 =?iso-8859-1?Q?Fm76xZe+XzjjUMF5g4eJVA5hUYZf3pc7I136z0uTVijsgIgtAvD9CbXnel?=
 =?iso-8859-1?Q?W9yvtGcw4hznMt2kVVzPOzE9Lb+jC+5+S6eEjFwXnrmgQtG7C87oi+YL21?=
 =?iso-8859-1?Q?5VAP0P9jsgxw1gn0BHlGISVZjHEhN85AXGNA682r1iK51DfyGkPgut7tnG?=
 =?iso-8859-1?Q?yWYOJQ1Qh3XpKUYg9VyUL+M3yDFy7J//wRIrl5PtGD7/PbgiwAm6qni6ES?=
 =?iso-8859-1?Q?N4Df/p695BdjPrDiKm9Q9bi0iF0pnTRd/Nmc/Cj35AQtaERHE5OxxpghBy?=
 =?iso-8859-1?Q?lSQ/GMGRzNud8oe+RhHnDM0SQSUuiBLkKv5jy/omoDmnnagnSjHlMb3DTu?=
 =?iso-8859-1?Q?MrVirbl3sgVJ7aWd4T2TsfzOC/35MYrRnWrd6bhkPeC2tPWpzYZ3klRMp3?=
 =?iso-8859-1?Q?JvXfwVUqczEAJmVTR+ub33y9bN6HWAmY0WhNzEeFW/m/m675xbvJBWEdWB?=
 =?iso-8859-1?Q?s7AVxyAOhFH5cItEGxZ8BeAoJxg0TR9hcdab7EqLoHaBs43jOHdCvsE7ZF?=
 =?iso-8859-1?Q?Q0eAnApeTcmXkZS9O6diT8rgjRgnBjXLYNgikoo52xlAAWJi5kYLKhL/j5?=
 =?iso-8859-1?Q?rPPREdXmAjF5o4yfI+2CIv/l5TcizZHaItU6KQVoB4gxkuwbGF6LFzO561?=
 =?iso-8859-1?Q?pNrsi3KKKI/34FR8hTOkxFv3qR8KjK+86Cags3IsQS/Vn0GL3UdGlJMCuv?=
 =?iso-8859-1?Q?hWee2EBNEGZTZmOAluX4X7ycOIjs3bz2PiJF/DmZzDtAMfGDuocWf0i7yc?=
 =?iso-8859-1?Q?gBlbckdhZbZsQydwP6A+oztM+bDg5iSHGdcLMz9vhagNSz265KUKYqaRC3?=
 =?iso-8859-1?Q?DmOKhmQ2IwUxBJqLvXLay7l+O5/s4uRdRjdz2a08b1vHLEqLIZ0bFgJ3Ub?=
 =?iso-8859-1?Q?CMrqKVllzIxpa2U4LTBx78FiAsoZRcrxjTngttoyy6t2jqP95TlxJUo3ae?=
 =?iso-8859-1?Q?9/LY1wu5UWnRMIBMHG8AkRLz3SdwQHOgJvKEv15Rupwxeb0FPqpOEnxDBK?=
 =?iso-8859-1?Q?23PBd5MhX+Y5YqWBq3XnWTYcUi+s40yoIRPO2AV1bv0glGUKMCJig96ZyG?=
 =?iso-8859-1?Q?0Q/6s1epTWCBzmOjvOGroz9+BVGuZSd9RD1xT/H3IuLrJBSAXDi81UakhH?=
 =?iso-8859-1?Q?T63gX6WX8higCFKMqwfIL11cpLruJg3zIdXFSw6Ge4t1RI1n6epbU7cHKF?=
 =?iso-8859-1?Q?RYsefh00QO126vaOFl1KuC9/v2EYfIq5qXB7QTT78KLX8kLo+ncMrL/ScU?=
 =?iso-8859-1?Q?U6kn5zp/oOZnCIzo6ktMbbDzGIzswzb2Ww6WcthBOqrk0gTCPNwuxmnnwz?=
 =?iso-8859-1?Q?dh1cFoQ1yXDopCFnFcGSmpGLFSaspowzO8/4laKckKC7Qfj9dJUSe/7/ew?=
 =?iso-8859-1?Q?AO5tMhLl80/XtPHcaGV6Wt6ioYqreiyQle9FPb0wHHmTqAn+L+66SuqA/D?=
 =?iso-8859-1?Q?r50ekxwr4vjqidh2KtnFlL0H/j2QqvZ0uzQ6vgcvLXlsWInlp6x7fYv6BX?=
 =?iso-8859-1?Q?t06BUXhbWA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LA1pSEjwRvoW6IZ7FrJL7R70BNGhc5eyMQQP/V+0Sd0VLgqqRU5sVGJ4rX8bneREN2uP3w2+rg/O9p8rory7ZuNgKuQyLGSBz34edf+of+6NrRpzx/5PxlERRMmdxY6lalG1ZpSL3fUYwgu8pXR+r/+akpjxMbiDuRKSlkC0nnagPicV8RUTxB2ip8g/QBBEZOWtJlIppkRFoCskUzLRfYrmaAEQD0r6rlHXf2zNYc96ZC9gnoyQd0gRBpPQJ6lfHoNb6M+mEXEz76EB3wuckQiLQN0aRQRK+MAI+JzlkTsxGzemedWrPLW1AMnsq86/pR2L5rTk9TUKBLmLrH+cZQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed031fb7-a7ed-4dea-7b02-08deacc0f1d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 05:16:22.3732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZWpkHuxvNN75SUHlnANyDrJSpQ1vrR4t6o7kGx+M/GwGR5X85O0h9EbYJ/2+TqiF90BaxFRqLy996oHsDHQ91GlPeI+/2/i2088QveQuy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5885
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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

In the do_hash_operation, the code may be returned earlier because=0A=
hash_prepare_sg_iov or hash_prepare_direct_iov may return a failure.=0A=
When this condition is happened, current code flow doesn't go through=0A=
later code segments. Finally, it causes the mapped address isn't=0A=
unmapped properly.=0A=
=0A=
This change is intended to unmap the mapped address if there is any=0A=
error is occurred. Thus, it could prevent a reasoure leak situation.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 63 ++++++++++++++++++++++++++++++-------------=0A=
 1 file changed, 45 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 0504d61cbf..a322905cb3 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -218,8 +218,19 @@ static bool hash_accumulate_len(AspeedHACEState *s, hw=
addr plen)=0A=
     return true;=0A=
 }=0A=
 =0A=
+static void hash_iov_unmap(AspeedHACEState *s, struct iovec *iov,=0A=
+                           hwaddr *mapped_lens, int iov_count)=0A=
+{=0A=
+    for (; iov_count > 0; iov_count--) {=0A=
+        address_space_unmap(&s->dram_as, iov[iov_count - 1].iov_base,=0A=
+                            mapped_lens[iov_count - 1], false,=0A=
+                            mapped_lens[iov_count - 1]);=0A=
+    }=0A=
+}=0A=
+=0A=
 static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,=
=0A=
-                                   bool acc_mode, bool *acc_final_request)=
=0A=
+                                   bool acc_mode, bool *acc_final_request,=
=0A=
+                                   hwaddr *mapped_lens)=0A=
 {=0A=
     uint32_t total_msg_len;=0A=
     uint32_t pad_offset;=0A=
@@ -243,9 +254,11 @@ static int hash_prepare_direct_iov(AspeedHACEState *s,=
 struct iovec *iov,=0A=
 =0A=
     iov[0].iov_base =3D haddr;=0A=
     iov_idx =3D 1;=0A=
+    mapped_lens[0] =3D plen;=0A=
 =0A=
     if (acc_mode) {=0A=
         if (!hash_accumulate_len(s, plen)) {=0A=
+            hash_iov_unmap(s, iov, mapped_lens, 1);=0A=
             return -1;=0A=
         }=0A=
 =0A=
@@ -265,7 +278,8 @@ static int hash_prepare_direct_iov(AspeedHACEState *s, =
struct iovec *iov,=0A=
 }=0A=
 =0A=
 static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,=0A=
-                               bool acc_mode, bool *acc_final_request)=0A=
+                               bool acc_mode, bool *acc_final_request,=0A=
+                               hwaddr *mapped_lens)=0A=
 {=0A=
     uint32_t total_msg_len;=0A=
     uint32_t pad_offset;=0A=
@@ -275,6 +289,7 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, stru=
ct iovec *iov,=0A=
     int iov_idx;=0A=
     hwaddr plen;=0A=
     void *haddr;=0A=
+    int iov_mapped =3D 0;=0A=
 =0A=
     src =3D hash_get_source_addr(s);=0A=
     for (iov_idx =3D 0; !(len & SG_LIST_LEN_LAST); iov_idx++) {=0A=
@@ -282,7 +297,7 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, stru=
ct iovec *iov,=0A=
             qemu_log_mask(LOG_GUEST_ERROR,=0A=
                           "%s: Failed to set end of sg list marker\n",=0A=
                           __func__);=0A=
-            return -1;=0A=
+            goto fail;=0A=
         }=0A=
 =0A=
         len =3D address_space_ldl_le(&s->dram_as, src,=0A=
@@ -307,15 +322,17 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, st=
ruct iovec *iov,=0A=
                           "%s: Unable to map address, sg_addr=3D0x%x, "=0A=
                           "plen=3D0x%" HWADDR_PRIx "\n",=0A=
                           __func__, sg_addr, plen);=0A=
-            return -1;=0A=
+            goto fail;=0A=
         }=0A=
 =0A=
         src +=3D SG_LIST_ENTRY_SIZE;=0A=
 =0A=
         iov[iov_idx].iov_base =3D haddr;=0A=
+        iov_mapped =3D iov_idx + 1;=0A=
+        mapped_lens[iov_idx] =3D plen;=0A=
         if (acc_mode) {=0A=
             if (!hash_accumulate_len(s, plen)) {=0A=
-                return -1;=0A=
+                goto fail;=0A=
             }=0A=
 =0A=
             if (has_padding(s, &iov[iov_idx], plen, &total_msg_len,=0A=
@@ -332,6 +349,10 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, str=
uct iovec *iov,=0A=
     }=0A=
 =0A=
     return iov_idx;=0A=
+=0A=
+fail:=0A=
+    hash_iov_unmap(s, iov, mapped_lens, iov_mapped);=0A=
+    return -1;=0A=
 }=0A=
 =0A=
 static uint64_t hash_get_digest_addr(AspeedHACEState *s)=0A=
@@ -350,6 +371,7 @@ static uint64_t hash_get_digest_addr(AspeedHACEState *s=
)=0A=
 static void hash_write_digest_and_unmap_iov(AspeedHACEState *s,=0A=
                                             struct iovec *iov,=0A=
                                             int iov_idx,=0A=
+                                            hwaddr *mapped_lens,=0A=
                                             uint8_t *digest_buf,=0A=
                                             size_t digest_len)=0A=
 {=0A=
@@ -369,15 +391,12 @@ static void hash_write_digest_and_unmap_iov(AspeedHAC=
EState *s,=0A=
         hace_hexdump("digest", (char *)digest_buf, digest_len);=0A=
     }=0A=
 =0A=
-    for (; iov_idx > 0; iov_idx--) {=0A=
-        address_space_unmap(&s->dram_as, iov[iov_idx - 1].iov_base,=0A=
-                            iov[iov_idx - 1].iov_len, false,=0A=
-                            iov[iov_idx - 1].iov_len);=0A=
-    }=0A=
+    hash_iov_unmap(s, iov, mapped_lens, iov_idx);=0A=
 }=0A=
 =0A=
 static void hash_execute_non_acc_mode(AspeedHACEState *s, int algo,=0A=
-                                      struct iovec *iov, int iov_idx)=0A=
+                                      struct iovec *iov, int iov_idx,=0A=
+                                      hwaddr *mapped_lens)=0A=
 {=0A=
     g_autofree uint8_t *digest_buf =3D NULL;=0A=
     Error *local_err =3D NULL;=0A=
@@ -389,15 +408,17 @@ static void hash_execute_non_acc_mode(AspeedHACEState=
 *s, int algo,=0A=
                       "%s: qcrypto hash bytesv failed : %s",=0A=
                       __func__, error_get_pretty(local_err));=0A=
         error_free(local_err);=0A=
+        hash_iov_unmap(s, iov, mapped_lens, iov_idx);=0A=
         return;=0A=
     }=0A=
 =0A=
-    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_le=
n);=0A=
+    hash_write_digest_and_unmap_iov(s, iov, iov_idx, mapped_lens,=0A=
+                                    digest_buf, digest_len);=0A=
 }=0A=
 =0A=
 static void hash_execute_acc_mode(AspeedHACEState *s, int algo,=0A=
                                   struct iovec *iov, int iov_idx,=0A=
-                                  bool final_request)=0A=
+                                  bool final_request, hwaddr *mapped_lens)=
=0A=
 {=0A=
     g_autofree uint8_t *digest_buf =3D NULL;=0A=
     Error *local_err =3D NULL;=0A=
@@ -411,6 +432,7 @@ static void hash_execute_acc_mode(AspeedHACEState *s, i=
nt algo,=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash new failed : =
%s",=0A=
                           __func__, error_get_pretty(local_err));=0A=
             error_free(local_err);=0A=
+            hash_iov_unmap(s, iov, mapped_lens, iov_idx);=0A=
             return;=0A=
         }=0A=
     }=0A=
@@ -419,6 +441,7 @@ static void hash_execute_acc_mode(AspeedHACEState *s, i=
nt algo,=0A=
         qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash updatev failed : =
%s",=0A=
                       __func__, error_get_pretty(local_err));=0A=
         error_free(local_err);=0A=
+        hash_iov_unmap(s, iov, mapped_lens, iov_idx);=0A=
         return;=0A=
     }=0A=
 =0A=
@@ -438,22 +461,25 @@ static void hash_execute_acc_mode(AspeedHACEState *s,=
 int algo,=0A=
         s->total_req_len =3D 0;=0A=
     }=0A=
 =0A=
-    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_le=
n);=0A=
+    hash_write_digest_and_unmap_iov(s, iov, iov_idx, mapped_lens,=0A=
+                                    digest_buf, digest_len);=0A=
 }=0A=
 =0A=
 static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,=
=0A=
                               bool acc_mode)=0A=
 {=0A=
     QEMU_UNINITIALIZED struct iovec iov[ASPEED_HACE_MAX_SG];=0A=
+    hwaddr mapped_lens[ASPEED_HACE_MAX_SG] =3D { 0 };=0A=
     bool acc_final_request =3D false;=0A=
     int iov_idx =3D -1;=0A=
 =0A=
     /* Prepares the iov for hashing operations based on the selected mode =
*/=0A=
     if (sg_mode) {=0A=
-        iov_idx =3D hash_prepare_sg_iov(s, iov, acc_mode, &acc_final_reque=
st);=0A=
+        iov_idx =3D hash_prepare_sg_iov(s, iov, acc_mode, &acc_final_reque=
st,=0A=
+                                      mapped_lens);=0A=
     } else {=0A=
         iov_idx =3D hash_prepare_direct_iov(s, iov, acc_mode,=0A=
-                                          &acc_final_request);=0A=
+                                          &acc_final_request, mapped_lens)=
;=0A=
     }=0A=
 =0A=
     if (iov_idx <=3D 0) {=0A=
@@ -468,9 +494,10 @@ static void do_hash_operation(AspeedHACEState *s, int =
algo, bool sg_mode,=0A=
 =0A=
     /* Executes the hash operation */=0A=
     if (acc_mode) {=0A=
-        hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request);=
=0A=
+        hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request,=0A=
+                              mapped_lens);=0A=
     } else {=0A=
-        hash_execute_non_acc_mode(s, algo, iov, iov_idx);=0A=
+        hash_execute_non_acc_mode(s, algo, iov, iov_idx, mapped_lens);=0A=
     }=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

