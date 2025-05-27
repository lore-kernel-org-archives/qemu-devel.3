Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7DEC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 11:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJsg0-00042x-Bb; Tue, 27 May 2025 07:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uJsfu-00041P-1R; Tue, 27 May 2025 07:40:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uJsfp-0002Ti-0D; Tue, 27 May 2025 07:40:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R69aBV023641;
 Tue, 27 May 2025 11:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Urz3KuxCvZ9n++1EN0Pm4EkB2WE6qO2bo5Ure+eZJOI=; b=
 NzoIiZ9Ta+59lX9jCcglmrT7oUNTmZNSaSl0q8Cr9W/MMmKZTlHproPpi9kaM3bI
 71lKkITVV2N2Tr1N0JG/ag2oV2z4Pwith+P7vU9IJi3GegKa8T1bSi0O4V75N4ty
 jP4+62xIjJ7GBHni407Bw8HrbwH34uqRTtIQ6ef5PfJbVS5jWohNhh7TemLSqU2k
 ykEJfsUxTg8StyymAXnZvs2EPnk6Sr6UvlIpveUYckJY8NPIXK70c8snQ96VJtQu
 OZk6pLICa6u0FRdDgDyTdUe3DUzMu9+RdAGFffPSIYydSOqcTX5RxjXnhdiZbKit
 M8+CvIkv18JpPrFQnjabQw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0yku24t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 11:40:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54RBbvEY007248; Tue, 27 May 2025 11:40:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4j908me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 11:40:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxoOJ6pIXjrnwT6GMG6QdoetE4GvA25IBJ4CsFYhgj2HEEjJKej2sq2bFi5Ei5r2oWZAOCxYsH8MpwdUot2Om2ufmR/GQ27qhUs5UJTIjl7cY2PjxB+/b6F2R7k8i/JDqIiWFlSFHGIe8dE2YpXXr10zVHHssbfLnGM3s7cN9KPCnvUryZ4BZl50xPFEhCbDT6JzLFPBCZ5cnWnuDG8uNh8c+I0Z5fkAIsGTuv520jvp+5Kz0skyrjf1/Nl1a7z6X6dFydqx/efIEE/cmfFr0lNDCnUH+i5aLUa7Asa8D9EcHaV6wuBy2Jb1JWRSQVhxSi/U6vemHX0A6nmWpG+UQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Urz3KuxCvZ9n++1EN0Pm4EkB2WE6qO2bo5Ure+eZJOI=;
 b=QukWY2pr44xPy6ECqwsqaTFviWbLP1fcdiXyKN+K2CQUjzvNo/nE6EF49n1Y1ZMTK/i7ALLw6fL/sGfwV05iKDnjydKIzhy+vtynR3pAZO3xPWG08qhFhYDQeFLOeDgk6iBBwW0O6WLvWGM92damorjU6GxvpWDhpMAnJTdrAlLU3WAk9kLN4tEySsfWWqeN3Hjie1Rxl30UnLzeomVwcqI/Bt0XUsl/C+lcicFQMg3gMf+9FUs8gRQv/3LyYLFiSPbBxqp+iHpT3/BKrpS8dmzOVZfeW736VYQjcno/sP51l6nUJg65ObETXC3hOErDP4NklvRtbzON9AS3S4tsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Urz3KuxCvZ9n++1EN0Pm4EkB2WE6qO2bo5Ure+eZJOI=;
 b=GbweLkAQnkGNcJ+xtkaP2PWbXfotwqSxZU1yKPlZH47WlzAkOk9r5Dv7ln50uq5wYBtN8qk3hemNvA8s+oWrjWF3rcivd8n8IokZDOwCLJc0pUGeVwKpnPTVsiSlg04qNw/TYUV5TbWQJHMgQE/iOfcBYYusbFotWY5blqRA0hI=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BY5PR10MB4339.namprd10.prod.outlook.com (2603:10b6:a03:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 27 May
 2025 11:40:36 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 11:40:36 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Marc Zyngier <maz@kernel.org>
CC: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "gkulkarni@amperecomputing.com"
 <gkulkarni@amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Topic: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Index: AQHbztA2f3Tkb/6RVECgRowZ7mB7d7PmF3GAgABDNIA=
Date: Tue, 27 May 2025 11:40:35 +0000
Message-ID: <63FE2592-DF4D-4CCF-BC76-D8656C9EFA0A@oracle.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <86msayec3a.wl-maz@kernel.org>
In-Reply-To: <86msayec3a.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|BY5PR10MB4339:EE_
x-ms-office365-filtering-correlation-id: 42c3ecbf-358c-4638-6c07-08dd9d134be5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/u5SHqLbrXXPufDiebHDUoIkun99ImT0hFcRkmjLEYQudtk5UoLFDi+6CLh/?=
 =?us-ascii?Q?XyN99R733r7xJb0J2HeyiSdyxkzi3KVV0vN6+60/oD3FnUPTE0F7aUpUF77s?=
 =?us-ascii?Q?LwTEmhQ9d+vW1hLz5qQxIgUsxV58ISj751KgNP1TTq1syyZfR4Xa7uYgCxnO?=
 =?us-ascii?Q?+QKTwpN/WPAPhS9iH26vjE5ZudbytQM2+YpDWGLa6PNf+QjHtBr5JYIoO8Il?=
 =?us-ascii?Q?lTsMI3AaOdKpqbhivu8+6TMiyXMpGCqR6ok6hDTDN8+f0YVy9/ySGMnFto8s?=
 =?us-ascii?Q?wXAbKAUTwv6HFH0RB0+uAuEawiz7N3jxnhgfwPRjr/ajrqSP0CtaOS6Fgs6O?=
 =?us-ascii?Q?zx2tgaCE07i/RJa98yk9QJnG4WP0yyj35i7gXer44+OV6a7ezl3dD6aDabfk?=
 =?us-ascii?Q?iY0AZbjm14TX+1dbZuUro78TQMLRZbAvM/meCOzChhTKgfqr82EwdlTqfMv8?=
 =?us-ascii?Q?1gHZso/cpAZ2nwpAOV+sgbcIDSzUeVnVZFDjPQNg2x4+GYxopV9vJus8zXm+?=
 =?us-ascii?Q?QQ+p4nBdQUUUNM2qT44pZEKk2LYJwVS1JplH0oJM4p0aSPnmDjq64VJbFS6S?=
 =?us-ascii?Q?TFUi+WOqzqevePim9kmqTKWO5ZrH2v48gSaj96cAsrBNLhpJ0gao/zCTCF5u?=
 =?us-ascii?Q?ROfUMElasJkY4aMisVGw4burTXT8gWmjDrzme7m8fhGDYBYg7UmY0yUy6S+Y?=
 =?us-ascii?Q?OPMWwtrALrp+VqcW1kkDg4MELW5kyT+on2BRhTgY0Wy06YbWO7YS7niYW0yQ?=
 =?us-ascii?Q?KmpqpokY90IbifdcvHYntJCniFgnGJ2QbXn/pOxgA2np2C3ow6R99/iM6bLh?=
 =?us-ascii?Q?D75OvXioCC0W2iO4zuM41ckEQ/5gJlYhNvMdNJvCeHeOkix5iUzF6WoGadtT?=
 =?us-ascii?Q?N5QHfK8blBnUtD5ju2n5p9btEdpV4eAdeN8+gjcuxbZbNoZaqqe/hYfzBh3u?=
 =?us-ascii?Q?IUYIWD6po1x3rOBP3CIbi/m66XtOgD1j5l7Ka23ac2cv+xvdmfi+dCympYtk?=
 =?us-ascii?Q?+JUoMKA1TphNOtSQQMC+fsJ/ZaI+A72e9hX22xk6yXy4o77XKuIBimtx9Lnu?=
 =?us-ascii?Q?gxDAfKRjhYrUJgv6VcqqNeVZssInfJbIUm6CUjXkylZpxgN2lM+Xa/eDWtrX?=
 =?us-ascii?Q?46KLGMikrJHWQxso6BUtZpxopiz1ll/poAwKUD3IAa9ATqFWh6pmsQ/niNz0?=
 =?us-ascii?Q?o068JGJiINGEulUaTKDEucIbDvDUs+YXMLO/5ly8q6bfvgEMJZ8wT7ATVhAq?=
 =?us-ascii?Q?U0BdhduNtGudiapj3fgdDP4q/AvAs8otjwNUiXKqANJZeDrjmB2inuLqUDeR?=
 =?us-ascii?Q?otN7imceZY/BPzmUaiEGAeqN4EQaJWpOzZTypyI2y88SDIQMQIMeSLdIFbsD?=
 =?us-ascii?Q?SboE7++quHunnqvTGEWdN9C0XsxMucCtpEj2IvSsAFs8019XBP1Wt1/etYQP?=
 =?us-ascii?Q?hLbwqaOfqRzt/PyaeCCRC5F+fletNhNoXuENpYYs5c/+Dqx/WsM0g7RVZ36g?=
 =?us-ascii?Q?DAyPGC4609HB/2c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RmMrony8cR9XMDhGPgGs/EUJcxUi3MC0UazCDqw452CW+AssM8lM9NwhP3xB?=
 =?us-ascii?Q?MPxhL87B9EwXDFxhdlCfk1vnAOMKxbcjh6z/4LjMmewefOufpltxYQ8QxIsz?=
 =?us-ascii?Q?nnv52wutIJEqVCMcmex/r0ss+dh8M4Q2GgwAAfdcWozwspnXQFyeoYL4OXiR?=
 =?us-ascii?Q?bvLSQ8bZSoBoGALqj/VqV5ckDxqZ2lbvLMFXu0NTVYC7fN6kB3fOikT4z2ze?=
 =?us-ascii?Q?trp2Alpz5NGd+1HQctM+0B1KaQ+hGnFdqgowxha+kj9ByP9Gd9ZWseS4Amkv?=
 =?us-ascii?Q?JOxVVGYBsWrkvCM/AAxwEr06KiXcli7U3k94lYkV2S3gguawqIAJTuiawY6h?=
 =?us-ascii?Q?PToToI9+leVRG91PDhR25VK0FiXh7x5l9s5QwRQK/ArhixVmIEEnovUqq6Y0?=
 =?us-ascii?Q?a/DFwKnh+getOEMS515ioJ8Js7SBXozvV1tjzfML56IKGF/SJvpkyXK0yfLG?=
 =?us-ascii?Q?N92inlDsOzKYHOT/fhvoIrHo7KHXl4AQyYvqULH2pscqQsfREY8lHhU2MOdB?=
 =?us-ascii?Q?YQpV1E7Azb1VMpuNV1LeZoIHlvLFR2Pin4Ho3ojy66NLk99mNJW7rnFLSDi8?=
 =?us-ascii?Q?2YlFhlBdR8Cm77kGT1Cv8rPsEswAhOt2jQrCRfpObYR0jA+US1T1MR7sdZeO?=
 =?us-ascii?Q?1qCZV4ARL6erIzSF0919H25AFzOC+QkQ6bXcpRau1rlOF7CoeIlderWVAoFo?=
 =?us-ascii?Q?WnEFY3DGBAuYH3/JCKJtllG18tQauPMt3gju4WbWJMIbNT4JnF0k+E275DUu?=
 =?us-ascii?Q?5hRPQnFB85dxcVxFTypP28srCNOOpMtnrbfgnS1yS4J8VItWLA21ieKSxBaR?=
 =?us-ascii?Q?dORfIHJsKkJ7bjGDInKX/Armi2agkmkEf4pZPCFgpp3dLIv4sgwLeSX3FdFA?=
 =?us-ascii?Q?VgKO0+uTKNPQrfca8rP815b+cZgJZyiz1VLr4jxJoahRe2at975DdXpcJRJ1?=
 =?us-ascii?Q?R1VXJDWj3+IbWv43ca67I6p4M2V2C0ii8Fmlk646oSwdWloyz4dUAqxwOvzQ?=
 =?us-ascii?Q?IYULHQxanXescYtVRdnbwQbfqhRJ5JWzRMddS6SlOqd5g+95MHRQJV5IT9+Y?=
 =?us-ascii?Q?CQqddBIr9Em3GdWbi1LvlPG6QAVGt5yJaU4ilxtwVwr6S/IkIdAmMiHuvm2t?=
 =?us-ascii?Q?r748laBU8nP3fq367T2CEDsuJY6jo3Fj88dyoPNbL4ThxAd4AUU+Od1xv9ml?=
 =?us-ascii?Q?n6j+CQc6Porv7cc8OQjEFzub8UP7wpnPTsjQEWrWyiY0Ggg981YcGRRqtSaS?=
 =?us-ascii?Q?EmDugIL/O9upZGzRm+UtfY4sVcZuVS6q+Ynb+wDBxG8j0q0yk32qZbqH3RQ9?=
 =?us-ascii?Q?lCJmVFPFU0sunQ8CcewZLXq1aSaVEX96ZBlzF60zM70Wt5T+tpeZhIj9FFyy?=
 =?us-ascii?Q?hBigsGVp9aCdJh2sSQcX8SuH5pX7f9ZFAi5ZTw+HuP1epa/f5WuO8vsU2CFk?=
 =?us-ascii?Q?yovjbg0he8cKO+zUgsWY4zfyzUi6w05NC5n1N/wqlMP+T1qq/iL17P+mhq/v?=
 =?us-ascii?Q?TaUC9HrxExdDcqvWhrBPrfGNYXBTVgePReNMaxjA7MJrrBl8bybI2ZJDAYVd?=
 =?us-ascii?Q?Uygg1U0TZvCLOExOlu+wnKZpKBDtGurIJPd8gP0u?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8FEF248EF581A41843BCF796D1359BA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UVQvzBdVqMYr9FKDL/Ruv9PZcymq3H2da9xWxNhVmle4AsLzY8WwgijEIA6Xk9LtsDl1m1OvFbELfgoyoZRii30IOXcz554aB7iTTyeTn0iC2q6spRcQbBNjzA9DSGmSJMMWwqnM+Ja9qr8+lHcTku/vFRUJ2D47ow6SAy5GrCPBXbntXCZZskk9quE/X9iaSF/9+SJU8KKpYv/GlCJRRtFUBGgD5tvfPZ3fHRBP2CvRPqwtfn6JXMut/KKh/olC//0+nesWuP4TIwYDLXAP4VrDkOqBxQ1n3icno2scdAXlmn8mrEMfwMqfXHXVT9mP+pW7xhnGhbwEWvgbgV87D3smiDGkUEvNkVePJ7Lvg4HlvAsnnxE88mk6By7zpwJ5/fyamnulKrLH/zvEPsDXxemgzhwxePKzdID9B2pob6EfDDY8DvMBb0aEjMO9K2ZOaplXLhlTNfYgWHzh4V4m+ti9Vx6rszY8P4K3qhS2iI3nzklXdnFscqeie26YuSwdQSKxhCBJ6mFD4YgJvTy67CGBYb3PtRarda9dXhrOptKMNniF99M4YjtN6jjVWajPP0i7kZ7OiouU150OzkvmrAlNxAOAqCM7VcghMyZv16s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c3ecbf-358c-4638-6c07-08dd9d134be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 11:40:35.9172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjhErMvU4/2FxCQH9fJw2AgiFv0YLniorjuVs6iPpmxdlHIqqlEY2KmhdWAjL8xm6TeL6hWaZrVuul35tqahQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=697 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270095
X-Proofpoint-GUID: YT9yfMIp7r63-yYTamn_GSW9KXxx6BE9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5NSBTYWx0ZWRfX3hRHpwruI4HN
 S5KrnKe0ApGBMc1IG0AhcAVhDJ9Pf04IrgtpK4md03fRwbOtEhTqrZhVu6m+nOfgz/VPpvVke1+
 vagQ1pjsWTgP1epkBg7UU0uK8ZxBWgt1dsfCm7txzkxRshv2YHe2ZCZsjwJK1Bb/Wavq58pKBjA
 UAIG5EFgBgwSQZXvdKYzvutF1BByhK2K1AlWDsRZ3deXxe1ULA5cP9cYakAF1zy7HX3HBQ+FUG6
 m701j+qkfgmJ5F9XehiC2ds1n4mtYI679L6Iw8njAMl9Gy0D/57v/h9E4ZNrxFHBcMu4GbPhXIQ
 aBwa7u+dHQH3unMt/mFdPzchjszKILBmIzM1P8JtGBLU7ghMj4aW7oKsJyJP4k+xvvMCEaIAMPW
 vRu6MYh0ENfRSH/bTPZxhl+BVM0bC3R1Ac7NjkuXVpgb1qs0Yed6UbiTB7U+0AziRPNmoSyH
X-Proofpoint-ORIG-GUID: YT9yfMIp7r63-yYTamn_GSW9KXxx6BE9
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6835a4b7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=7UDGxXlBccGI7ByPIB4A:9 a=CjuIK1q_8ugA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Marc,

> On 27 May 2025, at 07:39, Marc Zyngier <maz@kernel.org> wrote:
>=20
> Hi Eric,
>=20
> On Tue, 27 May 2025 07:24:32 +0100,
> Eric Auger <eric.auger@redhat.com> wrote:
>>=20
>> Now that ARM nested virt has landed in kvm/next, let's turn the series
>> into a PATCH series. The linux header update was made against kvm/next.
>>=20
>> For gaining virt functionality in KVM accelerated L1, The host needs to
>> be booted with "kvm-arm.mode=3Dnested" option and qemu needs to be invok=
ed
>> with: -machine virt,virtualization=3Don.
>=20
> Thanks for respinning this series.
>=20
> Do you have any plan to support the non-VHE version of the NV support
> (as advertised by KVM_CAP_ARM_EL2_E2H0)? It would allow running lesser
> hypervisors (such as *cough* Xen *cough*), which completely rely on
> HCR_EL2.E2H being 0?
>=20

Something that pops up is early_kvm_mode_cfg trying to handle nested mode
while KVM_ARM_VCPU_HAS_EL2_E2H0 is set.

Miguel

>=20
> Thanks,
>=20
> M.
>=20
> --=20
> Without deviation from the norm, progress is not possible.


