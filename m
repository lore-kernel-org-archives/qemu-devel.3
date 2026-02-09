Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA5FE78D73
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNOK-0004oQ-Hh; Mon, 09 Feb 2026 04:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOI-0004me-5h; Mon, 09 Feb 2026 04:17:10 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOF-0007K1-He; Mon, 09 Feb 2026 04:17:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7PKE2QbBRRl70sZRHe7gNg+9QHoDx2b+YkYls7vKaty5rkCjRAT+sblTMhbatnupFegRnxd47mhJmNCLC1o081HVEkN+7UGcdnIaP5T9Twz8e3SSQM87rjSilSp9X5v39ZAyeovsarqurWn+u6MWmITzpaR6F5wWelTQyMZxHl/bGWEDGsT6+W6wIbINznrYcZJhTFim+imCnU6YdUYMzO6LlBsogxM2PRg2PE8y65FHJrXYRsXnjBHnYU77Vbc8SdlXY7TVAooahegnrkNXERN21MS2bz8jfhY2ZHXDY/59w2WbssZUiXaJ/TUL9qccoB8FmESkO6e/6Qqrn6A7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vds3dPXbxjr2A71H0OK3Y+WKSGZrTCHyrI8s/7iYPAA=;
 b=vRkIwckKeaS/0Fsqp1Kl+OcfMY1umAs+jyOAhE9RA/Bisqyqf0lhCuhhy8UiBKNe6Hy03V0IJkExyPs0WiEvCw91Mbqi/QeXxAShQRMdGKj9nvDnkF9HsxJOZyj6bRuBA0GXpw8potJicUaBK7TBrG58lRjny3zxHh5EMnmr2NtLTd6h8IeQHqFq8Rwh05gfblJueSggAt7VTzrXVpFM7jyWxLD6GgJqX5SdRqWMoWBxyR/4pXRFaa7lb/T5gUFJdW9pf+qY0QvbG6GXl+cNO+15oaKjf+xwTzTS0jc9UuecslvE8OLQzaap0xeNX0ddqxAUMMP74w6umUd7AEU3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vds3dPXbxjr2A71H0OK3Y+WKSGZrTCHyrI8s/7iYPAA=;
 b=GwaaqNXYn9RSy5F6rNzZTn7XVviBz3Y6LLwPJ7pbzKrVua9+GNYw5dF5+Zv8fzOlCK09EV1TF1BRw9pniWE9ZB8bhP8y5kDF7VbGaHJYc1fr3arh0A+lwEa3icA5y5ewGw1W5KKAsESnUAp1fAEh2nAqirMf7t1i1H0EkxqBaGPgsDE7DD4gpYXkG9cq/gIc0Z9x0zz4Dz5bgW5utkGfzGg1E2t33ADbPYFwroWEA8GvytuX0tPX6i2MQrOXDXbyVRq+vmwD+PgDL6QrYJ3hPuipRMEUVhbc/kfG02uIKVFb/S1RPhAuGozk/oC3R8aTzf3yOuHzCh+MSrO5fPB0hQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7031.apcprd06.prod.outlook.com (2603:1096:990:6f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:55 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Titus Rwantare
 <titusr@google.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v4 17/20] hw/i3c: Add Mock target
Thread-Topic: [PATCH v4 17/20] hw/i3c: Add Mock target
Thread-Index: AQHcmaTVPZWIzPche0K2Cf8k344Exw==
Date: Mon, 9 Feb 2026 09:16:55 +0000
Message-ID: <20260209091629.823457-18-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7031:EE_
x-ms-office365-filtering-correlation-id: 8efd8fb7-a6bf-44c2-075a-08de67bbf872
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8dFF4xjYe+Kpzw3Ypi0J8QTJrFSTRBti3p/z8f7IudTExcDucleY4NtTDp?=
 =?iso-8859-1?Q?mYt9Wf6nXsGA/mjclMDNOlDYzipAwRNnRmzBi3AFV1SJRwdjfjOIg+XZFr?=
 =?iso-8859-1?Q?Dx38X8plyQ5elVcx8aDkAgzFIMskEhk4i8L5ke/gIUBO72yhGHzCd+XRON?=
 =?iso-8859-1?Q?iyiUuoK6QWrSYHqt5gPBK4ZtzKw4W3f8KLI2hn0DlKFGlNI3otA035A24A?=
 =?iso-8859-1?Q?yf6+ycdh5bnpM8PuSmVPxfNtd1DmjXzMB3lOfMgKh5HUAQP+6uzhFRxrxn?=
 =?iso-8859-1?Q?fGjj/yVDeKjISENqQzxaYaZLOAkhmy9oPWaZ4PgcjTpSxZcesUgDU4/4oy?=
 =?iso-8859-1?Q?KKGiZq+cEnmLMgF4Pf1jY2+J4JGE+AvM1tSnwErjizEqmuteU+tnMFTBvB?=
 =?iso-8859-1?Q?+sLODeCNtqu3EHZKrZjYXJtR7/GQcY2iLdRffAx97tT5sWabGTPAfIWeas?=
 =?iso-8859-1?Q?BFGY1pIhwwryAAv4ykdpLIEo37TfWK8jMPtTQktXulo68VDBxDnYJtHUf1?=
 =?iso-8859-1?Q?akFvMd/yWtZgveJq6iDqlPABDQnrqc7OG0H+RQuqMlsO6kapvjKV9FgoRI?=
 =?iso-8859-1?Q?lQoFS5VtNcP9BcMykhnA/T+G9X20WR0sp2+Enwz88QB+fOThkYsBGtq1yr?=
 =?iso-8859-1?Q?efiTKP9qYThGDmltuv4cU8RWIEMQTgrXGQQAoSy8CU21DeJ9plyDML/3pa?=
 =?iso-8859-1?Q?hn9x1oLimuZIgIjbFjj801bdiGe+51qm9ZIRsOHkvb9GJKF+5ZFXQhw8UP?=
 =?iso-8859-1?Q?qlDOXxS+zF446KZ5SMuNwmvCCxPXeBDw2+Da3K27vdDp3c5hHoGv+34N8h?=
 =?iso-8859-1?Q?nFVMVEX4zBHvbKwAJeHcQyApWVNRhDWQhupQxjDIp3dczscBhUYb1sB3+W?=
 =?iso-8859-1?Q?1OSRDB6xtyk+sDe9vGrElWYUIZUYv9f8sqN4SsqAaoRGBJ50iK9kbaINpm?=
 =?iso-8859-1?Q?FkaynutYvX4TkWQ4hOFfq8vUn4HS7SPFDW6EKnkgQ70Z1XouLVYxYyT6HI?=
 =?iso-8859-1?Q?roRPAG+kiB2RTmo8xecpWTgpm1tOQHT56t3taVTl08DqfhAjXmMG0Ifo+5?=
 =?iso-8859-1?Q?JCvkpjjRCb83LDZlTCzCK+EAyHL4E+VpXoN0mRMGK06h6jqvwhtygAa/qY?=
 =?iso-8859-1?Q?ut42rC48RhEgmVijdjYodzeENTZxc2fejstA+PMXEB1hxpkZctzk57kcpN?=
 =?iso-8859-1?Q?dwdeJSHc3Fv6aPSHOzv/0mv3nBKpG+Ns2PcrSEh2/aUxvD9yeRegb1hTpB?=
 =?iso-8859-1?Q?IsktO8p9rBeaVA5IQ6OJhyKVjJD2eL2VEYwOf2ExEb63VVzkrWyZzJnTzN?=
 =?iso-8859-1?Q?vvH3ZGXXOsPOqzoJnWzQPlqdL8bLkHSKs3/68QUkTW79IHIO6/W+QRhmpx?=
 =?iso-8859-1?Q?cq3CvonYSf1IIskbgOBIq/pyr2M2yw4Ff0qnhr1KAAZKzE4gYByEnecRDp?=
 =?iso-8859-1?Q?Ev2zac/Ju5y5BNAd7en2amjv0karKDEqTuTAHdaO2epVE8A0q39YPfvQrY?=
 =?iso-8859-1?Q?ATAXhvMdhiqy4UHLCg8rfmwnEv9HOsBTtwGOdWjmRJ8eoxM8odibKXiyae?=
 =?iso-8859-1?Q?eNh1f4vUUd7ltjDK8mqtgL2FNJEFpNcLmLNQci7bTZ4VBmKZRt/2FAsmQK?=
 =?iso-8859-1?Q?bTdLFPwM8oZF7ZSkrQtykqu2EHaGs2xgsQ4nXhrV5D8vpC81nauL3A41DU?=
 =?iso-8859-1?Q?wx33hGiNpQDfwPgbTlG3SM48u9CizMFPGv3vvlLY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MTNxI+aKM6DVb5VEP++kmG2ZO2eL+claTWZMQIV8J43z0YB1W8HiyJWW+8?=
 =?iso-8859-1?Q?zRcszn4gjHjhYgup/FsHfphYYMKqMeoEfWrxS+Qsfuyn2C5FYj+pcm52a2?=
 =?iso-8859-1?Q?9iTOMC/H5+I0+4dH8y5SLykDkmgwJrcZxCpbALp3VGn3FWUkVJRbcVabzQ?=
 =?iso-8859-1?Q?51WJjk8vrZJBtYfGS5HMzcJjt3D5P3ToRSPgPvntWajrEYqu+lrO2i9b0/?=
 =?iso-8859-1?Q?/07gTtBEyWIuwAZeq+30o0n0NJeVl82ztl+gOPoux3rNSXS+qjrEPdb/jZ?=
 =?iso-8859-1?Q?/PswSvy6LnMVui4KoKvyBloPlOcMwk6yalhoyKYTHVY0l6X+1p7e1rJBlO?=
 =?iso-8859-1?Q?LSjMdkVN3hlxe3athkJeRN9eX5exooJsb4/QKluT9KnbDC1N6/lc9K2KpA?=
 =?iso-8859-1?Q?PAkU9yypcDHv/clr0ptyZ+H6vjVw1wWQqW1YuUSu+4/2DSRa4bIe7mHYGD?=
 =?iso-8859-1?Q?jKnU43zaM4H5SAs5aSwqtfMDZcE8eET0uBqHo6jQFpbz0His7gLRHqHnxO?=
 =?iso-8859-1?Q?ctQ1NYKrPevrG8nRQ+rJei1xvTHAsTzqak99Sg1Z84015vVM+KM/uoZkUO?=
 =?iso-8859-1?Q?EoobvBEg8Jhinwb68yPWtRbfDAJFX8tFHjACYP2IVADlxKKmxV3L7xCrwt?=
 =?iso-8859-1?Q?f+ZqRex3gk5d2WaK/TRqlDgUqGao69v+2MA2RYPgqR5/kVmNcokWQDaYv0?=
 =?iso-8859-1?Q?pVTRZK4AmIffvMN/CfRRiht/2DnMHyICTv9++YEV+U7upyi22p6J3ZVZxB?=
 =?iso-8859-1?Q?yiuos6nDSIeDJi9MQk00bDsMJYeuQc6JCC67WglSnX26V8rKhle7keg7vU?=
 =?iso-8859-1?Q?VhqNb21n0lIFhkDc+9od67ZxxCNv1n7oqqaLrSwUlTGSDzeeBukvQcJfRl?=
 =?iso-8859-1?Q?sScbmC7NTAmb41OMUfsb7UjyAKyFYsVCeVHT67xgduIkbkDy9qAfNY6YnA?=
 =?iso-8859-1?Q?8MPZMYHW7nT3qfP5ollKFsP9N+gpjVkfWJWCcX7VPzvM9mTGUKPS/dRz8h?=
 =?iso-8859-1?Q?Jpo7ud3BRxvt7DidP8hwQEfGclqzcOxgXzUIfBCZdpBEsCLnk+HK3aIpK3?=
 =?iso-8859-1?Q?iGTfccAfFoUPdHvwQtWe134xNORSMLTz8lYz1GoGHZR164YwCn6vsaKRc0?=
 =?iso-8859-1?Q?YCo1QJrxZHxdqLOXAcj9Fzt9IanN2bHZsk1RZDHDaa/kKgSYKj5EXBnCY6?=
 =?iso-8859-1?Q?LShRDpKUyWO+L7oAhcjvMQizxPKAYbhwYEdgcM6OCQNFGpo80nn0SacVsw?=
 =?iso-8859-1?Q?4ujNde90cSSZ5MZWGYqdlHNLu3buiaWlcK1Xu6WDEYlCIVqf5F+yvxMTN0?=
 =?iso-8859-1?Q?pbnJ2VKvEf12j2CUmGOmnKn8QT41QEAYq0N1UqWzr0nr4PTllOxZZO9U68?=
 =?iso-8859-1?Q?nrp5EKMkxBEl+KPrlkMGLfJkTQ3bSXQ7HxYLW1tlXprEj+Iz/hWSAahFgg?=
 =?iso-8859-1?Q?OkDOAzUD8/SV5ImY1hK79CFeVCDXnRNmI89Ng422CGOJa1HaBLRE7hjumo?=
 =?iso-8859-1?Q?B8ncpbtYEI17DHvlVpYZhrG5gem390w+kaWjeV5YhBKJKlOZognrGr7xVt?=
 =?iso-8859-1?Q?e2p0DcU8Stj/D41o+0zeTlN6HFAQgwlsby4tmSTrrqAeRGi6YFhoTQxPKW?=
 =?iso-8859-1?Q?Iti+RUAE7HVZHuZ7lvAxD6EuO2LicZzxObhsod4ocQUPM+9RcT2BN1rz3h?=
 =?iso-8859-1?Q?/iPwFy2ek/QjtudPhzNfYJvUtmFpP1eWzZNFWP1OaIdfUOe0A8w3LxOrmJ?=
 =?iso-8859-1?Q?+BXIHaK99QKPcbkkNDdkvi3NpCaA2ZuxlIKZY6zsvvAyCPTMbVrjJjUJ2d?=
 =?iso-8859-1?Q?DZft/TAV0g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efd8fb7-a6bf-44c2-075a-08de67bbf872
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:55.7765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbSlFHwTT44mX6SfnFdDRlGaU6QCisXAtCHXhWhXKLvR+ixjubeMdA+gGk609Q3kbAeEiY2tJ+uArw19sFNL+hjgbn503DT5O40Auppj1LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7031
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds a simple i3c device to be used for testing in lieu of a real=0A=
device.=0A=
=0A=
The mock target supports the following features:=0A=
- A buffer that users can read and write to.=0A=
- CCC support for commonly used CCCs when probing devices on an I3C bus.=0A=
- IBI sending upon receiving a user-defined byte.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/mock-i3c-target.h |  52 ++++++=0A=
 hw/i3c/mock-i3c-target.c         | 311 +++++++++++++++++++++++++++++++=0A=
 hw/i3c/Kconfig                   |  10 +=0A=
 hw/i3c/meson.build               |   1 +=0A=
 hw/i3c/trace-events              |   9 +=0A=
 5 files changed, 383 insertions(+)=0A=
 create mode 100644 include/hw/i3c/mock-i3c-target.h=0A=
 create mode 100644 hw/i3c/mock-i3c-target.c=0A=
=0A=
diff --git a/include/hw/i3c/mock-i3c-target.h b/include/hw/i3c/mock-i3c-tar=
get.h=0A=
new file mode 100644=0A=
index 0000000000..7ac55a3179=0A=
--- /dev/null=0A=
+++ b/include/hw/i3c/mock-i3c-target.h=0A=
@@ -0,0 +1,52 @@=0A=
+#ifndef MOCK_I3C_TARGET_H_=0A=
+#define MOCK_I3C_TARGET_H_=0A=
+=0A=
+/*=0A=
+ * Mock I3C Device=0A=
+ *=0A=
+ * Copyright (c) 2025 Google LLC=0A=
+ *=0A=
+ * The mock I3C device can be thought of as a simple EEPROM. It has a buff=
er,=0A=
+ * and the pointer in the buffer is reset to 0 on an I3C STOP.=0A=
+ * To write to the buffer, issue a private write and send data.=0A=
+ * To read from the buffer, issue a private read.=0A=
+ *=0A=
+ * The mock target also supports sending target interrupt IBIs.=0A=
+ * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number,=
 and=0A=
+ * send that number in a private transaction. The mock target will issue a=
n IBI=0A=
+ * after 1 second.=0A=
+ *=0A=
+ * It also supports a handful of CCCs that are typically used when probing=
 I3C=0A=
+ * devices.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/timer.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+=0A=
+#define TYPE_MOCK_I3C_TARGET "mock-i3c-target"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(MockI3cTargetState, MOCK_I3C_TARGET)=0A=
+=0A=
+struct MockI3cTargetState {=0A=
+    I3CTarget i3c;=0A=
+=0A=
+    /* General device state */=0A=
+    bool can_ibi;=0A=
+    QEMUTimer qtimer;=0A=
+    size_t p_buf;=0A=
+    uint8_t *buf;=0A=
+=0A=
+    /* For Handing CCCs. */=0A=
+    bool in_ccc;=0A=
+    I3CCCC curr_ccc;=0A=
+    uint8_t ccc_byte_offset;=0A=
+=0A=
+    struct {=0A=
+        uint32_t buf_size;=0A=
+        uint8_t ibi_magic;=0A=
+    } cfg;=0A=
+};=0A=
+=0A=
+#endif=0A=
diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c=0A=
new file mode 100644=0A=
index 0000000000..e540a6c2f7=0A=
--- /dev/null=0A=
+++ b/hw/i3c/mock-i3c-target.c=0A=
@@ -0,0 +1,311 @@=0A=
+/*=0A=
+ * Mock I3C Device=0A=
+ *=0A=
+ * Copyright (c) 2025 Google LLC=0A=
+ *=0A=
+ * The mock I3C device can be thought of as a simple EEPROM. It has a buff=
er,=0A=
+ * and the pointer in the buffer is reset to 0 on an I3C STOP.=0A=
+ * To write to the buffer, issue a private write and send data.=0A=
+ * To read from the buffer, issue a private read.=0A=
+ *=0A=
+ * The mock target also supports sending target interrupt IBIs.=0A=
+ * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number,=
 and=0A=
+ * send that number in a private transaction. The mock target will issue a=
n IBI=0A=
+ * after 1 second.=0A=
+ *=0A=
+ * It also supports a handful of CCCs that are typically used when probing=
 I3C=0A=
+ * devices.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "trace.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+#include "hw/i3c/mock-i3c-target.h"=0A=
+#include "hw/core/irq.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+=0A=
+#ifndef MOCK_I3C_TARGET_DEBUG=0A=
+#define MOCK_I3C_TARGET_DEBUG 0=0A=
+#endif=0A=
+=0A=
+#define DB_PRINTF(...) do { \=0A=
+        if (MOCK_I3C_TARGET_DEBUG) { \=0A=
+            qemu_log("%s: ", __func__); \=0A=
+            qemu_log(__VA_ARGS__); \=0A=
+        } \=0A=
+    } while (0)=0A=
+=0A=
+#define IBI_DELAY_NS (1 * 1000 * 1000)=0A=
+=0A=
+static uint32_t mock_i3c_target_rx(I3CTarget *i3c, uint8_t *data,=0A=
+                                   uint32_t num_to_read)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    uint32_t i;=0A=
+=0A=
+    /* Bounds check. */=0A=
+    if (s->p_buf =3D=3D s->cfg.buf_size) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    for (i =3D 0; i < num_to_read; i++) {=0A=
+        data[i] =3D s->buf[s->p_buf];=0A=
+        trace_mock_i3c_target_rx(data[i]);=0A=
+        s->p_buf++;=0A=
+        if (s->p_buf =3D=3D s->cfg.buf_size) {=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    /* Return the number of bytes we're sending to the controller. */=0A=
+    return i;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_ibi_timer_start(MockI3cTargetState *s)=0A=
+{=0A=
+    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);=0A=
+    timer_mod(&s->qtimer, now + IBI_DELAY_NS);=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,=0A=
+                              uint32_t num_to_send, uint32_t *num_sent)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    int ret;=0A=
+    uint32_t to_write;=0A=
+=0A=
+    if (s->cfg.ibi_magic && num_to_send =3D=3D 1 && s->cfg.ibi_magic =3D=
=3D *data) {=0A=
+        mock_i3c_target_ibi_timer_start(s);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    /* Bounds check. */=0A=
+    if (num_to_send + s->p_buf > s->cfg.buf_size) {=0A=
+        to_write =3D s->cfg.buf_size - s->p_buf;=0A=
+        ret =3D -1;=0A=
+    } else {=0A=
+        to_write =3D num_to_send;=0A=
+        ret =3D 0;=0A=
+    }=0A=
+    for (uint32_t i =3D 0; i < to_write; i++) {=0A=
+        trace_mock_i3c_target_tx(data[i]);=0A=
+        s->buf[s->p_buf] =3D data[i];=0A=
+        s->p_buf++;=0A=
+    }=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_event(I3CTarget *i3c, enum I3CEvent event)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    trace_mock_i3c_target_event(event);=0A=
+    if (event =3D=3D I3C_STOP) {=0A=
+        s->in_ccc =3D false;=0A=
+        s->curr_ccc =3D 0;=0A=
+        s->ccc_byte_offset =3D 0;=0A=
+        s->p_buf =3D 0;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_handle_ccc_read(I3CTarget *i3c, uint8_t *data,=
=0A=
+                                           uint32_t num_to_read,=0A=
+                                           uint32_t *num_read)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    switch (s->curr_ccc) {=0A=
+    case I3C_CCCD_GETMXDS:=0A=
+        /* Default data rate for I3C. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            data[s->ccc_byte_offset] =3D 0;=0A=
+            *num_read =3D s->ccc_byte_offset;=0A=
+            s->ccc_byte_offset++;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCCD_GETCAPS:=0A=
+        /* Support I3C version 1.1.x, no other features. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            if (s->ccc_byte_offset =3D=3D 0) {=0A=
+                data[s->ccc_byte_offset] =3D 0;=0A=
+            } else {=0A=
+                data[s->ccc_byte_offset] =3D 0x01;=0A=
+            }=0A=
+            *num_read =3D s->ccc_byte_offset;=0A=
+            s->ccc_byte_offset++;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCCD_GETMWL:=0A=
+    case I3C_CCCD_GETMRL:=0A=
+        /* MWL/MRL is MSB first. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            data[s->ccc_byte_offset] =3D (s->cfg.buf_size &=0A=
+                                        (0xff00 >> (s->ccc_byte_offset * 8=
))) >>=0A=
+                                        (8 - (s->ccc_byte_offset * 8));=0A=
+            s->ccc_byte_offset++;=0A=
+            *num_read =3D num_to_read;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCC_ENTDAA:=0A=
+    case I3C_CCCD_GETPID:=0A=
+    case I3C_CCCD_GETBCR:=0A=
+    case I3C_CCCD_GETDCR:=0A=
+        /* Nothing to do. */=0A=
+        break;=0A=
+    default:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_c=
cc);=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_handle_ccc_read(*num_read, num_to_read);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_handle_ccc_write(I3CTarget *i3c, const uint8_t =
*data,=0A=
+                                            uint32_t num_to_send,=0A=
+                                            uint32_t *num_sent)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    if (!s->curr_ccc) {=0A=
+        s->in_ccc =3D true;=0A=
+        s->curr_ccc =3D *data;=0A=
+        trace_mock_i3c_target_new_ccc(s->curr_ccc);=0A=
+    }=0A=
+=0A=
+    *num_sent =3D 1;=0A=
+    switch (s->curr_ccc) {=0A=
+    case I3C_CCC_ENEC:=0A=
+    case I3C_CCCD_ENEC:=0A=
+        s->can_ibi =3D true;=0A=
+        break;=0A=
+    case I3C_CCC_DISEC:=0A=
+    case I3C_CCCD_DISEC:=0A=
+        s->can_ibi =3D false;=0A=
+        break;=0A=
+    case I3C_CCC_ENTDAA:=0A=
+    case I3C_CCC_SETAASA:=0A=
+    case I3C_CCC_RSTDAA:=0A=
+    case I3C_CCCD_SETDASA:=0A=
+    case I3C_CCCD_GETPID:=0A=
+    case I3C_CCCD_GETBCR:=0A=
+    case I3C_CCCD_GETDCR:=0A=
+    case I3C_CCCD_GETMWL:=0A=
+    case I3C_CCCD_GETMRL:=0A=
+    case I3C_CCCD_GETMXDS:=0A=
+    case I3C_CCCD_GETCAPS:=0A=
+        /* Nothing to do. */=0A=
+        break;=0A=
+    default:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_c=
cc);=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_handle_ccc_write(*num_sent, num_to_send);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_do_ibi(MockI3cTargetState *s)=0A=
+{=0A=
+    if (!s->can_ibi) {=0A=
+        DB_PRINTF("IBIs disabled by controller");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_do_ibi(s->i3c.address, true);=0A=
+    int nack =3D i3c_target_send_ibi(&s->i3c, s->i3c.address, /*is_recv=3D=
*/true);=0A=
+    /* Getting NACKed isn't necessarily an error, just print it out. */=0A=
+    if (nack) {=0A=
+        DB_PRINTF("NACKed from controller when sending target interrupt.\n=
");=0A=
+    }=0A=
+    nack =3D i3c_target_ibi_finish(&s->i3c, 0x00);=0A=
+    if (nack) {=0A=
+        DB_PRINTF("NACKed from controller when finishing target interrupt.=
\n");=0A=
+    }=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_timer_elapsed(void *opaque)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(opaque);=0A=
+    timer_del(&s->qtimer);=0A=
+    mock_i3c_target_do_ibi(s);=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_reset(I3CTarget *i3c)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    s->can_ibi =3D false;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(dev);=0A=
+    s->buf =3D g_new0(uint8_t, s->cfg.buf_size);=0A=
+    mock_i3c_target_reset(&s->i3c);=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_init(Object *obj)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(obj);=0A=
+    s->can_ibi =3D false;=0A=
+=0A=
+    /* For IBIs. */=0A=
+    timer_init_ns(&s->qtimer, QEMU_CLOCK_VIRTUAL, mock_i3c_target_timer_el=
apsed,=0A=
+                  s);=0A=
+}=0A=
+=0A=
+static const Property remote_i3c_props[] =3D {=0A=
+    /* The size of the internal buffer. */=0A=
+    DEFINE_PROP_UINT32("buf-size", MockI3cTargetState, cfg.buf_size, 0x100=
),=0A=
+    /*=0A=
+     * If the mock target receives this number, it will issue an IBI after=
=0A=
+     * 1 second. Disabled if the IBI magic number is 0.=0A=
+     */=0A=
+    DEFINE_PROP_UINT8("ibi-magic-num", MockI3cTargetState, cfg.ibi_magic, =
0x00),=0A=
+};=0A=
+=0A=
+static void mock_i3c_target_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    I3CTargetClass *k =3D I3C_TARGET_CLASS(klass);=0A=
+=0A=
+    dc->realize =3D mock_i3c_target_realize;=0A=
+    k->event =3D mock_i3c_target_event;=0A=
+    k->recv =3D mock_i3c_target_rx;=0A=
+    k->send =3D mock_i3c_target_tx;=0A=
+    k->handle_ccc_read =3D mock_i3c_target_handle_ccc_read;=0A=
+    k->handle_ccc_write =3D mock_i3c_target_handle_ccc_write;=0A=
+=0A=
+    device_class_set_props(dc, remote_i3c_props);=0A=
+}=0A=
+=0A=
+static const TypeInfo mock_i3c_target_info =3D {=0A=
+    .name          =3D TYPE_MOCK_I3C_TARGET,=0A=
+    .parent        =3D TYPE_I3C_TARGET,=0A=
+    .instance_size =3D sizeof(MockI3cTargetState),=0A=
+    .instance_init =3D mock_i3c_target_init,=0A=
+    .class_init    =3D mock_i3c_target_class_init,=0A=
+};=0A=
+=0A=
+static void mock_i3c_target_register_types(void)=0A=
+{=0A=
+    type_register_static(&mock_i3c_target_info);=0A=
+}=0A=
+=0A=
+type_init(mock_i3c_target_register_types)=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
index ecec77d6fc..d5c6d4049b 100644=0A=
--- a/hw/i3c/Kconfig=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -3,3 +3,13 @@ config I3C=0A=
 =0A=
 config DW_I3C=0A=
     bool=0A=
+=0A=
+config I3C_DEVICES=0A=
+    # Device group for i3c devices which can reasonably be user-plugged to=
 any=0A=
+    # board's i3c bus.=0A=
+    bool=0A=
+=0A=
+config MOCK_I3C_TARGET=0A=
+    bool=0A=
+    select I3C=0A=
+    default y if I3C_DEVICES=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
index 83d75e7d5c..e614b18712 100644=0A=
--- a/hw/i3c/meson.build=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -2,4 +2,5 @@ i3c_ss =3D ss.source_set()=0A=
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))=0A=
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
 i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))=0A=
+i3c_ss.add(when: 'CONFIG_MOCK_I3C_TARGET', if_true: files('mock-i3c-target=
.c'))=0A=
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 39f33d9a50..3d6dd4f7dd 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -36,3 +36,12 @@ legacy_i2c_recv(uint8_t byte) "Legacy I2C recv 0x%" PRIx=
8=0A=
 legacy_i2c_send(uint8_t byte) "Legacy I2C send 0x%" PRIx8=0A=
 legacy_i2c_start_transfer(uint8_t address, bool is_recv) "Legacy I2C START=
 with address 0x%" PRIx8 " is_recv=3D%d"=0A=
 legacy_i2c_end_transfer(void) "Legacy I2C STOP"=0A=
+=0A=
+# mock-target.c=0A=
+mock_i3c_target_rx(uint8_t byte) "I3C mock target read 0x%" PRIx8=0A=
+mock_i3c_target_tx(uint8_t byte) "I3C mock target write 0x%" PRIx8=0A=
+mock_i3c_target_event(uint8_t event) "I3C mock target event 0x%" PRIx8=0A=
+mock_i3c_target_handle_ccc_read(uint32_t num_read, uint32_t num_to_read) "=
I3C mock target read %" PRId32 "/%" PRId32 " bytes"=0A=
+mock_i3c_target_new_ccc(uint8_t ccc) "I3C mock target handle CCC 0x%" PRIx=
8=0A=
+mock_i3c_target_handle_ccc_write(uint32_t num_sent, uint32_t num_to_send) =
"I3C mock target send %" PRId32 "/%" PRId32 " bytes"=0A=
+mock_i3c_target_do_ibi(uint8_t address, bool is_recv) "I3C mock target IBI=
 with address 0x%" PRIx8 " RnW=3D%d"=0A=
-- =0A=
2.43.0=0A=

