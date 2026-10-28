Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14A606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=LhvRhNzm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtT5-0004Ui-TT; Tue, 27 Oct 2026 22:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSi-0004RG-G5; Tue, 27 Oct 2026 22:32:24 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSg-00082E-Nq; Tue, 27 Oct 2026 22:32:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8zgi7JUPKBQLyAnj3iN1cP07QNsQZhJ2ENgo2v+Prf9h6L5F+PFIeXw0DOncBl9GzlAP+TwsfbLx3wpCMlIPC01XZMeuW8gETP5x2DBgmx+KmCAP59Qj0x0wu57jYCiUA8De5gx3I7IAp3GRPtvqLvNUf7tajAsHXEz35XiyUGLqtWbNr8mENzH6dJHkKADNDdHG/6B3rAo5tMSFhSUzCKVBN+CltjO7HcHkcJPz6+Ade7pvgdUv3E01V84iUUmCK11sJX6UJdWYTVUHUIWtt3f5PYU5pXvqFEL1h3E/l8ziAtjJvaOWoJO+qxtEvJxrIggKgHtauSKpi13Br7M5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbnCJnJ3NGjsSakrkRHS0/NKUpyIaexSkcbqDcKuiHA=;
 b=fTUJ/I66j14sgJ9K7AMcep3kxfBT4X1DhNCdQdzmTjGRqBYTdL4a5djLTkK2MlX99GgnjaLmPUMDNDmKCBLpP7uo8UWGBr0l82DV75dPdZdyfZtXuqt5N6Ertdbqlm7AlmIiJGBDnBOpD+FVy9Z1YJD7xCHM5wJhReCpGIIdlAmHsxU5B/EIWX0T9W4QWvfXvBocTdXQHhEUx972AVg1MUO5AnZ39LdO5Pjz7C2CUWXuoE1QpyeZ0s4zHr7lwBHihMqJOnSzJD/mjmALbeUC7K7pfYKT3zraL/Z2W5YnI8z0EvofBA7eVDRjA26jyYAxmW07b+hxE0fqnS9OyGeVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbnCJnJ3NGjsSakrkRHS0/NKUpyIaexSkcbqDcKuiHA=;
 b=LhvRhNzm2AgP0Nz2y2aJ6Nvzt+sPmYv/UUTA9TIgOBXRE63Pwb6+zCMs+L3SHizIUf9rP5WaYB3sKNQnO+EjZbUBa8U7OTqBr5FLz1ocEUZJmwC+I1RPpLgZn6X5B4NEjjCHz2Nxtwl8j6oXUqIvuojoYTaMHdmTiRGN5lK+9p1zQSG2ga6D2WZvOsIDbWtqtqM+crG5R2mLTkjSmagJiwjS5Tx+ElpwrMfWOxpYl5sxbEclvXzHE5gmGeHze/BAknXVOQ31kmPqKJruJlfBRhSOHFhlbVa0rW25YcD4plfS3kYAlBMJ/Sl+Xrqm1Z70s0iUattb6om3euKwfbNSOw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8531.apcprd06.prod.outlook.com (2603:1096:d10:91::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:32:03 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:32:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 08/13] hw/arm/aspeed_ast1040: Add OTP as an unimplemented
 device
Thread-Topic: [PATCH v2 08/13] hw/arm/aspeed_ast1040: Add OTP as an
 unimplemented device
Thread-Index: AQHdZoSEApZ9xleRUEuCeUbFRvw3jg==
Date: Wed, 28 Oct 2026 02:32:02 +0000
Message-ID: <20261028023154.48395-9-jamin_lin@aspeedtech.com>
References: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8531:EE_
x-ms-office365-filtering-correlation-id: 05ed3b8a-e6df-488b-1243-08df349ba6b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|921020|56012099006|261021121427099003|261021123027099003|10067099003|261009221227099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: NkoVhEEtgwYYHup8eCffuB4p5+O3PNjoX2xHSCjgiG8N5c8525qGaEjrFgW7LCQMWzBVqmZLe3NBoamFI+vNF9wPr4Ju2xbDNULM00RS6q5RD0SXGd/AjilgQTr4T5z04QIKhDJGZGiDdnX6X4fsZvuR/gZzSOU5qyvlL+0ekZyolob1HlxqPZPxSx34RhZnKLeRshalG89s4k3mbB/qasVWPbG27dCNULfiPw7HtQOzDC7xyOSwqjTfvaS6wHRPDawTUmMyOPD8KeT45+ka1BTWzvBf8Aqwrfq8VtfXEkmVhh2P+FqpDowoNEpe9+F3S394TzCS05FGnN1Odz2m32O5XDH82yo38o8DELfNJg5viyoj0ayiAlAtvpAtQzZX4IuVlMqRDdjWo9KPqX/UjOGm4EzCiy2PeOsuQPDTt9P9FSSP3fp0QjrD8dBzT/kEyzasrHiykw3obj1PXE7WBUouHOoJ076ZFO9pRUhyTqbAq33YTEAf6RUH13rptr/BvJSQVyKG+IbnlQy/iDWzGm00nB0lvKUP9OOdkmBA90YSd2c9GN4glrcBm4RxEhaYjnm/nJoNCDxQKX87h/0hJwV/rVw/pXXnhmyMUtJMTRyBwx2cw6aVshPwejnWGEttGJvpwg8VrnIOt+OlBwBvz0wtzVJAX7rr61L3AlmTkfoTdflg1V5nYLe82q/10RRuj8lp7R8vnt65rfd8jaSigQis5gWW9kJdoQAV49qZnco=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(921020)(56012099006)(261021121427099003)(261021123027099003)(10067099003)(261009221227099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I0LPLG/ayiJzIgRWYLM2uv9dGtqbspp01H3bNAEJMuY3zV90PEMR+5YG30?=
 =?iso-8859-1?Q?3q/ejxIlfhMYWjxvAnni1u5WUgvsNIWJ5mzI1mazpxvCNCqQVTdRJFX8Ua?=
 =?iso-8859-1?Q?wD7LQAhe+OgDxLGX2zxXQ8zSAF2mIruoubnqw7yI87bVQ1+9KGGe4BjG7U?=
 =?iso-8859-1?Q?jc+LLprLqEFacAqsGjzhbCUWVTeepH7NmTtEelpsrAnwuRLVuHtBumMkKF?=
 =?iso-8859-1?Q?qbeqwTYRnBzHj+J0dI6HpapVhnZxWOi/g/OxpI+mPHHIKO/01h5WQPPhAu?=
 =?iso-8859-1?Q?2M3yg8+nb0joirewAz7TSUlUexC4e15JiywxX3MkNJN9F/M1ss9VJyYY2l?=
 =?iso-8859-1?Q?58idAoQYjH2kcIucVAQveCDXJbrYnqPbt8ZeZ2D4ZUE6o1jg3mcQEzCtVn?=
 =?iso-8859-1?Q?g9kLWeJqfRY8+wzLstz3pc6CqzPAJ4t8e7Sjt6hW32VCxVeF8DHs/Xa+z8?=
 =?iso-8859-1?Q?8L9bcGHFUBXDzSdjL4hGWpPAAPm4ClzxNPKmWN4BM75aAQbctHc78EQnWg?=
 =?iso-8859-1?Q?GKUukI3/YtMx/DO2kzcsAkNzCxtG5FOgLSLM+a7PVYayNGMGhs6CL/Qu+7?=
 =?iso-8859-1?Q?qdKSVUxlnpd682K6SqRkDUIVZce9LysZJdj91hTYYMUWkmGSEoAR8muoCR?=
 =?iso-8859-1?Q?UwkaudUKNsZP+f/f7xADJ9tkQL39Bou/E/PwX/2XseQC7f59ctkuzMyW/Q?=
 =?iso-8859-1?Q?prAF7sF5eCClEvwGt05mUKY45KOGm1WPaqooZk4ZQ4PjwJ4ahyma+yp8Lp?=
 =?iso-8859-1?Q?JLW1x7qNgvi61FbhhkOpdFCffcmAVQPNew9FxuFx2QxZcMGKsTTc80pL8g?=
 =?iso-8859-1?Q?nc7x70OkX9kbgB/Oq1IvzIGbg9El90KumiIAG0uF3/OE+qX+fV1D5mK7BD?=
 =?iso-8859-1?Q?EhJjwa+RIr11BDqRaCPLMPiaZjcIt3VlDijEhDFu+9uSC64/dhhDg31gmn?=
 =?iso-8859-1?Q?jwNOJs8DLj1wTqCWoseQhCPdXXyL2Kb8scq+1wd+pbpl4Z588pFs3pasbs?=
 =?iso-8859-1?Q?/gWjkMFLdSlr7f4nER1aNQGmnANw2hoNkJPk7kUT4BjIThp/kutICXDfaF?=
 =?iso-8859-1?Q?LQZzjYs7P0f82jhw/XABPUSA6fXagfbvjNpBY7rW1L+qQ7luSyQAB6znO5?=
 =?iso-8859-1?Q?m7uRS8stTeLmhuiY1MRioxbMEelVHRmuxkDvzT5N9/fj4m3eA4r+NQe7Ve?=
 =?iso-8859-1?Q?UDbM08LDPwyAzZp5w/FaIMrsXyoFB/eqM7MbrNX/UiQ8ME/0+Zz+Qrih4s?=
 =?iso-8859-1?Q?q2E+tLiMZKCHL4ybqa4/2PjpTfUBonOJS2E/fLf0/uJpdNEE2Ry2GusANE?=
 =?iso-8859-1?Q?id5rTNNieBbDjowH5ip242D6B7rx/ZLTh4rd+ufELUXDuLtBEss8D3qzVA?=
 =?iso-8859-1?Q?58xfVUa4h4/8IgSXgcx2csRrYbDuAntQk5+ZuxDsLX6O2o/fZGNolRz+ms?=
 =?iso-8859-1?Q?vXw+3Mg6ZKW0606AQZK8zIN2z4HsE8NW+8p8zY37hwuo2MLTvSMqSlV+b8?=
 =?iso-8859-1?Q?K2Dxr9OIt6mRNvqfnC6Z9fRPzNO5mpBsjSMRYw1KP69dJl8TKOyF8H0WN0?=
 =?iso-8859-1?Q?Ot/jGo0kRFDC6ph4NyYDy8Q7yU9gY+1tsWzF+FS00/12ARjLKA0H46Dkrn?=
 =?iso-8859-1?Q?8xOADQMQG1/n+3nmswPatYr0ACAyvF4mfKB7ILfPhD7JtExPurWDvOmBYT?=
 =?iso-8859-1?Q?p/6iOKdYaGocQJ9emv6/PnL/SeNk69mu4rd2j5BqUlOD9zwCkESV7Oo6rN?=
 =?iso-8859-1?Q?ZAI5MFdc31ex28sXlITop76++LU3na4KWIFnBql8K6TW54gGUg8w6bPGW7?=
 =?iso-8859-1?Q?49LdYjlUfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ed3b8a-e6df-488b-1243-08df349ba6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:32:03.0133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7LdTKc7YpetlJF1tuW5qyTpAEbQ3dNTt5qxAeGGfQEU6yRdrThV0dLA/Hl0RCgv1UtikrJEBj7I5sqmt8n51RaeNf+AMTZ/+wFc22CXdAyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8531
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

The AST1040 provides an OTP controller at 0x74c07000, but the controller=0A=
is not modeled yet.=0A=
=0A=
Add the OTP register region as an unimplemented device to reflect the=0A=
AST1040 memory map.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 5eb091e675..48eda35ffe 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -90,6 +90,7 @@ static const UnimplementedDeviceConfig aspeed_soc_ast1040=
_unimp_devs[] =3D {=0A=
     { "fmc-filter",  "aspeed.fmc-filter", 0x74000400, 0x1000, -1000 },=0A=
     { "spi0-filter", "aspeed.spi0-filter", 0x74010400, 0x1000, -1000 },=0A=
     { "spi1-filter", "aspeed.spi1-filter", 0x74020400, 0x1000, -1000 },=0A=
+    { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },=0A=
     { }=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=

