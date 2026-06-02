Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44EFC5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUHgb-000433-6k; Tue, 02 Jun 2026 01:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgP-0003zN-M8; Tue, 02 Jun 2026 01:28:57 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgN-0002fW-0A; Tue, 02 Jun 2026 01:28:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pViv1jvLGTj6oNQNH28PZjdiQs7ZJKpZxzaAuOOwiHV4m4eiwzBu6WcVIaAu8Fnk6TICrSO31qlIV9d/xuejSGVH3lPYtnIm4qDmbIxKOzTOUOoqHK8syggoT+PATlFlaRApQSeizhDYpMXP5ommOQEkJshImCigv7OuyBkYrE2Y8NBx8VRY35wdotLMhSQuBRK4/dy8dpHh2bVIMcJj5dP1wb1J/QyLgHhk94YR0h0ZC5flDJumNd5VfzV/kvlpgI/wx0l83KQd9nVGiwMvtku6QrVEgqzwsRRtcVGIjxz6GYGT/05Q2yDFEzaHvxpbf8JC3etjw6CMYo/Qh/Ipvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Nfl4QAPNWGNdHhXByDOkhIZW8XVzz3hkMhnpx6zNpI=;
 b=andoNLbs8JRTGkxlGSOoNDR1siek6iIZKOJT1Ufjbt/XjUQgRJssrclyOcPA8AnAdwhlwoldI6+pCMTUgss3tk+jHtMCYzP3VZRhDRQv2yn7ye5aLuxkFVaZb5Te5KkQN1EdGAOs6+yXN0KjUxjtxVxQWrlevrGhwh6JGe74QWhVLVhfeBhlxAUSba9B3h5rUuX1hjepYTiiDsc85SkLdJtSfCKFlrQtIXwt0I0apIFyPTlTkCwq5NFET/L6f9vWcWYmFHEKXkm68Zp23TqztcgJiRy9kFIXgB/PdXHfxNO1wEnNbcJcObWBPVGYjMKkXPtXPa1f+FTbDtaN6St6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Nfl4QAPNWGNdHhXByDOkhIZW8XVzz3hkMhnpx6zNpI=;
 b=TMP/1g9Dw+YrRFe34WW6QXTdGGdIpMyaB8DUH8vlbqNCy0EYswrFx8SagfUO0BVYpel3pSsgpNiA0M6/OJRFlbmTdqqqGYWc9mqSIKHdIpGaWdK7wCvuNspICVWQ94je2NvNN9K6ukIAfYdo1Okjxzp6FEq2Wk71Bbxf1PZpzdwZbss1InxPIy7JQb2ZV2K8V0b1xyWglR85muI5oMkh+UgJD+IBJ8kCzpDhXllpSgtvg72/Vb1WApIPbSx7056DMl0tmE4CRjHo1Guuig5/1CDgt8kpBtaUFSdCeWo8QUt7tJhB/URhr2s4HLuqJ47eTJWo9h+UCgZqE43/cRguBA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5411.apcprd06.prod.outlook.com (2603:1096:4:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 05:28:37 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:28:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 07/10] hw/i2c/aspeed_i2c: Introduce AST1040 I2C model
Thread-Topic: [PATCH v2 07/10] hw/i2c/aspeed_i2c: Introduce AST1040 I2C model
Thread-Index: AQHc8lCpVLHcmwklNkWfSlsdKf/XHg==
Date: Tue, 2 Jun 2026 05:28:37 +0000
Message-ID: <20260602052827.1535299-8-jamin_lin@aspeedtech.com>
References: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI2PR06MB5411:EE_
x-ms-office365-filtering-correlation-id: ae31ae4d-05cf-4283-1ca2-08dec067cc16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: a8U8xiZCqfqLpCdHT+6p8bJcC4w6P9mco98pJBX8XqXRmn17NdUHlwF/2pd04a1X58YgNggnot51Zkc9JSCTNbwycypOZWnJ88/CvpHy7xZfypMxsgrrbLASbiaNY7SzGP3LZ0HG6XZiqBnhoXiU7pfBqWem98hsb290G8FxUj8J4LO9OjxiiljHt890cTAIdZeTWlgGplbNmbgdlrq8ol7gHf/OLa5kawtaJ3esyUmAKxUQ//yrFWT3kqrJnnJVPJX5l9rH1VL24g89vp6PzXkt+hr/SZ14U4yXGwlcod7VJB5Evb8Sab9UpQtkXsq3dYcQV3ucZl4DoGESF4SdFc03chnbdtTdlOUGr/c9TClHMO5VQotF15ZGSjsNbkhZbeJuLABTMjvdQCB7L9mURK+XR7lWIs3Fv6oBAu0XQTEl/VetM+mRoyeJHDU+zTm+/1en8bB2fixhKEBroVry8VKOZevGQ7ThAnKmtl01yGO2od5vtttC2Nv0+suYhxVADrD0yNajxm8AYgF+K6LFtAzD6t9qFo8jz4HN7sOzmHLP6jiuY7svg/fyfs+Bw2b4Sc+ZfxPUJfr/FOel8xcpqLMPcf5sSIxf2UsmhFku2Ao/Lm21ZnkMXN879s4LMoh2JFQciequclZOeuL8rWQ6smCHh5ONrCJ9fG3MxfZoxwR4eNfkqa2somf/rLud/R8tMMf3j5SCP42U0AyDFstZxgUjEXo55TSdW6IRHwSXl9pXN6JrB8eusMj/isXYzB7G
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eYybDWEq56z3EYHl1YtgeZpozsB/2Sjxa1ZjeaRxSGVrJ2qWlaUIPBW3rW?=
 =?iso-8859-1?Q?V3aF8RivDq6OnBUUZ+ULqqokJptuq4sUjUqKM2Kv7DU2HUJyyw9Yb1azxU?=
 =?iso-8859-1?Q?gjNkO2q6+eVOkC54vsSN8+4sGty7/aCxxeD1amuZfFLxlZCny2oUiB6+il?=
 =?iso-8859-1?Q?acYZb/HqyvPhVoEODxYT7elQSGpBL3N5zR1FGzW0waVKlnYGKNYONbK0pe?=
 =?iso-8859-1?Q?FA+kFbjMOtlZ2XCEohmUNhwFjuCSv3k7Pboly2qVYMTbcCISSnQXCiLzbS?=
 =?iso-8859-1?Q?+DchU5oeq4MB4XXweKu4HoXcH0zZSfY+lqkKIWjdCFHGX8CHZ3awYwP3+7?=
 =?iso-8859-1?Q?9GYNtntfKe4UtMJHwa4JPc1e2ciWniXexv1SDqwUXJgY1V0tztheTJh/og?=
 =?iso-8859-1?Q?znVRNdHup7qy7ie5ZVfnWb1eXrQCSd7vPuDKCalfQXYi9Co6wKSCnG47J5?=
 =?iso-8859-1?Q?u8he0taUPSR97/ka0ejJsdQ5Wiek5dKf0OzewQKfZ0yZI3bny83kweNY8I?=
 =?iso-8859-1?Q?QvY1abt5lXKRpkr4/KcxCdcL7vmRZ5M+hZMRiESDTbtxAHuGBfmJE4OlSZ?=
 =?iso-8859-1?Q?iN69TEMVCYW88Kfn9h+D5Ns1ioiRQ14w8lrAe6882XNe1voRWyst+jUM+w?=
 =?iso-8859-1?Q?Zo0i5P+XvwUdEAfoOZfRZeNwUF+k4uY24il1gDAvSi5xHVL26iu/tEBpgB?=
 =?iso-8859-1?Q?k9fGV4N1Mqmw2sox8tJFMrtmr1wTleMUB6Z6D++KMScWuQ23hdqvKQeVSm?=
 =?iso-8859-1?Q?2FhPayDd+kcjxa7e6293KLL+LcSWmopqEpAN+c/3HykcF4RZZR1V1lhVKM?=
 =?iso-8859-1?Q?NAN6bHfpG9UkSp87dlS0je1fT+xktGfgIOm5eKfXEsNCIREz29zUP717Rh?=
 =?iso-8859-1?Q?yv1wStYnxKO3ulSoYF1ZpPxDI++DLFgePBJ50O+PvhZhkAJYkN43zvn5Wa?=
 =?iso-8859-1?Q?KQQdBirCvhI+ChpYbJSl8YW/Gz9Ca23iN96kvzioE0QI+XIfxsvpy1+p1U?=
 =?iso-8859-1?Q?buObPfQlJdyCAII+xwoTiwvvyMsKFY1369q0pQ7Plv6ordec9FsuC7Zqdw?=
 =?iso-8859-1?Q?ait0PIflw7bd8vOzvw4WJU0mN5wRABsyD+fVOi8ibXkhuquZVwO6fAXCy9?=
 =?iso-8859-1?Q?peeQb64MVTjcSlHwaxVxEGZJPAApeINzq92NrH4xbwA/frApa7tpmb/dhx?=
 =?iso-8859-1?Q?v6kMVlLNMjQT0dSnhsfR4YzdUPwBIj1PGhazGSrQxo2kVSBbgICT7f8Hz5?=
 =?iso-8859-1?Q?14qpMcaXC8q9ZQEmyNNl7I1a3z5pcRqMb3ndtU4+kz7q6lQT9KxKOEBsyX?=
 =?iso-8859-1?Q?U2MIg12uEEey0zMZHE+XNOyTD0EHlxA5FdBkhFpBpzi1NhsMWQWuunrfJZ?=
 =?iso-8859-1?Q?lDebOujPqulVD0r/Kj3KEDoSeNWqcgFRCx1GB22P+Yf93WAXlgbaTrvQtg?=
 =?iso-8859-1?Q?smml+TMh/mqOXHKmuZ5pM/8aYZf6EBPoQ9kaJP/HCqu86b83NwzHUtAIOF?=
 =?iso-8859-1?Q?7kXtWpA2kOyZl3rhI1HNDHs8jdx632uplBG0YUG8bsdUGYtFamcLi6OTmA?=
 =?iso-8859-1?Q?oEaTB0v/KnBXO5HwdMuNF2tVedcVLmtkdAVemezcQBUMUZRRIE+kIXAwg4?=
 =?iso-8859-1?Q?B/Jj9I85WQW+vrHpO26LBqvuzam1TTmb3hP9dErTLnfq+nrWO8KZVOnSi2?=
 =?iso-8859-1?Q?yUKePq8TsW+HJBw5/TNyOT5PFq+Tr5gZfQEJMWvvVASB572lYCqaI8amMe?=
 =?iso-8859-1?Q?xBq4i6RtxLYEGoPZ/Wl4nqmtTahPjSE29vC9sjFXpVSeb4VogQmKqDyhfU?=
 =?iso-8859-1?Q?SlziDxAIYw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EVM8oL9Wd94CyGlrsOHGpX1gQeG8IvLPKIyvdqEDgHFfmkJfYY9ZZSxAb8do2g6oZPK9uxQy+pN9kG/QXFqLiA7dnGbJNZaTKu9RTX6MzAVpET6VgXngoPkHo5FJDdKFdnF51vfidgaBcMzaWN/bdT8S5HOyOtfSHJTF+2Jenih7qb8boEJ6EYT1PNV9pJqjoRN56k873J/Fd3jnRb1vUOdHr/k8kdvyQ6CszO3weSzqQZfI5Y8seQtGVeFZZIwzp2iOGWSQ/6P0O7b7f69K747n7xxjyd0MBi8I/U3QvU72yL091eXVbRCAgdoiLSv5lFYWdjOfnlF+J2ERA1Qnpg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae31ae4d-05cf-4283-1ca2-08dec067cc16
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 05:28:37.1137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlzGp2ExAuYO4myl6INgbuY+oxsq4l0KXp1d2bU2K/3ZCu02qxqURIB1+Q8j6tfmq2Z0C6Xy8cibz+3FnuKk5MLO3+0D2B5zHm9Ty/nvvb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5411
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

Introduce the AST1040 I2C controller model.=0A=
=0A=
The AST1040 I2C controller is compatible with the AST2700 I2C controller,=
=0A=
including DMA support and the 64-bit DMA address registers. Set has_dma64 s=
o=0A=
firmware can access the high address register and program it to zero, as th=
e=0A=
CM4 CPU only supports 32-bit addressing.=0A=
=0A=
Since AST1040 has 16MB HyperRAM, limit the DMA low address mask to=0A=
0x00ffffff.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/i2c/aspeed_i2c.h |  1 +=0A=
 hw/i2c/aspeed_i2c.c         | 33 +++++++++++++++++++++++++++++++++=0A=
 2 files changed, 34 insertions(+)=0A=
=0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index b2e4d2fb9d..156998e7c1 100644=0A=
--- a/include/hw/i2c/aspeed_i2c.h=0A=
+++ b/include/hw/i2c/aspeed_i2c.h=0A=
@@ -30,6 +30,7 @@=0A=
 #define TYPE_ASPEED_2500_I2C TYPE_ASPEED_I2C "-ast2500"=0A=
 #define TYPE_ASPEED_2600_I2C TYPE_ASPEED_I2C "-ast2600"=0A=
 #define TYPE_ASPEED_1030_I2C TYPE_ASPEED_I2C "-ast1030"=0A=
+#define TYPE_ASPEED_1040_I2C TYPE_ASPEED_I2C "-ast1040"=0A=
 #define TYPE_ASPEED_2700_I2C TYPE_ASPEED_I2C "-ast2700"=0A=
 OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)=0A=
 =0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 595b5fcf5c..a810ef9ff1 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -1654,6 +1654,34 @@ static void aspeed_1030_i2c_class_init(ObjectClass *=
klass, const void *data)=0A=
     aic->dma_addr_lo_mask =3D 0x7fffffff;=0A=
 }=0A=
 =0A=
+static void aspeed_1040_i2c_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED 1040 I2C Controller";=0A=
+=0A=
+    /*=0A=
+     * AST1040 reuses the AST2700 I2C controller implementation since=0A=
+     * the AST1040 is compatible with AST2700. The only difference=0A=
+     * is that AST1040 HyperRAM is limited to 16 MiB, so the DMA low=0A=
+     * address mask is restricted accordingly.=0A=
+     */=0A=
+    aic->num_busses =3D 16;=0A=
+    aic->reg_size =3D 0xa0;=0A=
+    aic->reg_gap_size =3D 0x60;=0A=
+    aic->gap =3D -1; /* no gap */=0A=
+    aic->bus_get_irq =3D aspeed_2600_i2c_bus_get_irq;=0A=
+    aic->pool_size =3D 0x40;=0A=
+    aic->pool_gap_size =3D 0xc0;=0A=
+    aic->pool_base =3D 0x1c0;=0A=
+    aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;=0A=
+    aic->has_dma =3D true;=0A=
+    aic->mem_size =3D 0x2000;=0A=
+    aic->has_dma64 =3D true;=0A=
+    aic->dma_addr_lo_mask =3D 0x00ffffff;=0A=
+}=0A=
+=0A=
 static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -1703,6 +1731,11 @@ static const TypeInfo aspeed_i2c_types[] =3D {=0A=
         .parent =3D TYPE_ASPEED_I2C,=0A=
         .class_init =3D aspeed_1030_i2c_class_init,=0A=
     },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_1040_I2C,=0A=
+        .parent =3D TYPE_ASPEED_I2C,=0A=
+        .class_init =3D aspeed_1040_i2c_class_init,=0A=
+    },=0A=
     {=0A=
         .name =3D TYPE_ASPEED_2400_I2C,=0A=
         .parent =3D TYPE_ASPEED_I2C,=0A=
-- =0A=
2.43.0=0A=

