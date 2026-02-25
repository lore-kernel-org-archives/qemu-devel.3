Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DAAF5543B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OQ-0003il-FU; Tue, 24 Feb 2026 21:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OO-0003e7-0u; Tue, 24 Feb 2026 21:12:48 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OK-0000Tx-Tk; Tue, 24 Feb 2026 21:12:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xERty3E8wDQCu2WCRtdzN1yDAU4LCJOUjFywQV1uxjY78Y9hWkcVkdTogVgcGJozbkkse0s/vfeVx5eBWmNkVZF7OMk/WW2W4wxmcVwmmVDjrMe18i1g0UrGhJc3BQzzujnmHdXhIGM6TMVMfKF6kmuf/pZBSetQLo5Su8TwQMHyyj66c4j3bD81FPRDJBv5e34KwmFbuUliCdyDWl60SPVKRx6eig4FGgFWPKdRvKZlNBlaDYoCClIi+ZzasPb0eViEeMtD0acr23ZJO+Tg1NF3fQ1310K585kga2tAM4dGph+PTpK4RbbNuYTeDlNJ6HSgrQ4kFRSToiQlXmli2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtbNMhvVH0ZNJBZtUcLW2s8trVFeHeYNz0ln9EPdUh4=;
 b=UjWgZxOBeA6H9Fnl0ZOE+vo8LGVbQYSQHZFfGroPC2DpEXYiT6ePCfYKh4IaT2TNPIfReCsYu0F40rVnk0kDkzWCj+XmAqdD2G1gVyLvtPpUgzEDiAsp5tDoDDhTPVLa3TuketMNWKI4CxjE4JlWjCh4xDmSWeGte5ufYGeNEHBzGcfEBiW35q3RChejeiaPghaYAVQuYLJbJvU1td2MO8dirnf0EYsp/UOmz1yGSvi4ONhwREm6RR62/ckPebcO0aRkKSHQVn5ovDXz+B0steGpbbpIr4EEpnMx6yW1ZP8em5MKpJs2nS8jwf+BrZwBVT49riBQ/2LIsJ1iiOfycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtbNMhvVH0ZNJBZtUcLW2s8trVFeHeYNz0ln9EPdUh4=;
 b=aQT5bPsqs5slARuEMInXcKj1BzespHEPaZ5qRxHortvB6SMu/70pFNkOZyE0QYyOhmbuiXxi1ucHem7PPTsEQSAklLYkHNpW9iQrbyHh30E02rWvgj5VhvGBGOoeNIC1T7gcuSAWE0Gfcg+j7Bsi6SY1AXumNQpr6bTOqJ/82VXEeewxlAqKnNasMGVR1aY2DaXAC5uK2T25aMD+KkI6x6Q2FmO9cytItMlp7Ebds9W38Ar9X002f2cum+/oyD0IONvseWSKl/wqXKZ2PD9+1u5x3GYon4B3ZHf4jCL+0MyrV3mE3vXsxVY906JRxF+ZrliBg7j/IzuqxaByxLS8uA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR0601MB5702.apcprd06.prod.outlook.com (2603:1096:820:b8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 02:12:39 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:38 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v7 21/22] tests/functional/arm/test_aspeed_ast2600_sdk: Add
 i3c functional test
Thread-Topic: [PATCH v7 21/22] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add i3c functional test
Thread-Index: AQHcpfw22DxgyUohJ0OQn3w+20tcoQ==
Date: Wed, 25 Feb 2026 02:12:38 +0000
Message-ID: <20260225021158.1586584-22-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR0601MB5702:EE_
x-ms-office365-filtering-correlation-id: 7553d236-7655-4da8-fbfe-08de7413595e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IP5tC6AiGZnmS3sNDu4Ugcl4ikhG/U0cQl+to/rsGbtpL4egvuDRLugNpj?=
 =?iso-8859-1?Q?AJ3f3v2K3h7y+N34jXKOL0NeGerdwAcPupWk5ytuLc6aZQ99ClO12Oyyow?=
 =?iso-8859-1?Q?qt9zmL7kKKwPkEqqxBQVDFNLixQuetOxRNsmjya0grTg6E+3tHI4d5nIfA?=
 =?iso-8859-1?Q?vaayGTNgi5FMucztBkW1Qhkx6d4Mn7XsxFnRkGu8C/9o9G0sA2G/U2DE/p?=
 =?iso-8859-1?Q?nZ145LtjTlU9F95WziVlYg9ruXM+Xx0WAf8Mh52ajjNeGKaBIqLrVZHzoy?=
 =?iso-8859-1?Q?dKeGat/Foa21w/i1W2T9LAqUeCzmVhM+dMxy3nsY10CNWaxrMTSc2hjZtI?=
 =?iso-8859-1?Q?87fL0P9GKQvVjJmBe8euO1EUzK4lVnv5w9TieU8xQsgKc6kcIF5MDDsNlt?=
 =?iso-8859-1?Q?kBX3OH5H7bxqIvcthHPryv5zkkbsEFW+RFMm8JvtWt3GRZQbCQndkEPijB?=
 =?iso-8859-1?Q?VNORcMTkPikbr9bUc07DbUgiDC6Og6jj9ma0iQ9VRGEhizzjS5zUdCPjvs?=
 =?iso-8859-1?Q?Ke9DvYZ7VposgMzg1VainFFCALFXsDfr4QHDIv73cUfTqOHRpBYgKYPozt?=
 =?iso-8859-1?Q?SxlxxVwcxhEfhXyn4oMJn/Zy4vK7S1/UslODsBVmPt8n2P08r3oOqS32Ac?=
 =?iso-8859-1?Q?jCpW2OIakKmQ1nP5Q/bkjqU14mpbGy21vXOiZ+EO6XgJDHms7bYeJYkrUq?=
 =?iso-8859-1?Q?VkjgtOULkBVaAuTvH+BrB+K6nBKuoyLdxR1Y6kkf1K0ak8ZqlQWTSBHWc0?=
 =?iso-8859-1?Q?H4zWtPyvnRz7kz5ux7e9CJWGckE0Myb96Nu4IjsCJI2LN7Ek5a80zV7g3W?=
 =?iso-8859-1?Q?6IBeHMxdFntxcSLnchmRNcC1EV2ib2nGJ1S369u5BP4oL8sxrJZBGG4GK1?=
 =?iso-8859-1?Q?dWJ/6DEUH2r/LJyd/yvg0jT7H7kpmMymn45gIW8yjMpO3SlpfiU3lfrLUw?=
 =?iso-8859-1?Q?MDeyX/EgWsVUWtqzP6kwSlBIPiJDvoXC9X8gtbGh3Ap28rLkgM3BqKwCCU?=
 =?iso-8859-1?Q?iLgtl71miHalXEpXvGrmWiKtQc/RPKsH2UdOhcfH/335qT9w9uZ66WU0oN?=
 =?iso-8859-1?Q?Zvh8gnRmYSkcIiPKemqc1Q2uqNdk2/qptkCpiWPW6wy834qw4M+BsxrBVD?=
 =?iso-8859-1?Q?TqEEqU21lQKUIr63i40Ss6ckNq3rG4JX6wAklnMou4ASJAS5RXpb5Ji38g?=
 =?iso-8859-1?Q?6Eos+hwx+cK8hhxF27EtNNjpoYSYWAv8iYvO4GJsN96bixH8fUCwc1YNXb?=
 =?iso-8859-1?Q?yFKh5LtsTw5G7gHat1hU6OQdSPBUbYGPItUAD+ix12FhS5Z5J4avtO/HkU?=
 =?iso-8859-1?Q?JNXAbuUHY9Ik1PDacse2Widha8fSIdJpKRVRXs2qlmKe1lAsoKd/TAAL+Z?=
 =?iso-8859-1?Q?OPDqxNPnO8gxs/uyVUC6nB+Ci1Bw+plCFiGiIhySD6fNqZ6Hatv6XWex+T?=
 =?iso-8859-1?Q?Gstqq/Ou8k0Ag9WN92aJ4oamGPSf1vz6/cgvs4ev/et7Tu8cRgcZPAqj7U?=
 =?iso-8859-1?Q?X3wa/JpG1hf/W57AcZCs7JaYWigfqsvSGazRQBXHQNtjsnObwPmaVpkTlZ?=
 =?iso-8859-1?Q?uy69lO+Y8VF2pQpEvfSYPAmOsBYYwIxX8tf1ngTicUynEJz2NH4uPYfmup?=
 =?iso-8859-1?Q?KkzKJkFQu6rQ4V8ahObFvHmWaPCO/PWlQT7epoPOQHZ/4/cZjOkBMcFEqJ?=
 =?iso-8859-1?Q?h2XDtPJo82/tn9WRkOJmqwVAKH+sppgRbuXCIAh4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kgm45WKAx7UK+YhkPfoCeXap8+dJs3+yO75J3+XduUTTGWSlwkElC1jGtI?=
 =?iso-8859-1?Q?S7EGbPhqlLBQpy/S0nIrgSOZpfR8vynQmigLH1/TIJwHpb46vOmvZGtRZM?=
 =?iso-8859-1?Q?6L05977M664tneETNoB9hfLuFOKgGdm8sFDeVNfkDKQIgtX9IbxC8vyodU?=
 =?iso-8859-1?Q?ozpGR0vKCg198xPi5WFQxOhUw4RFGBprhjp9kjb/y2yakBPttShOD4kTx4?=
 =?iso-8859-1?Q?8FYC/guPAYL+FfvI+to4n4znllrBBOQkKsd3BRZJ4Rj1M3v5fk/x3ku2wr?=
 =?iso-8859-1?Q?De8kQksZ+Z4tWdVI56vYyN49TsJO+cQ585mjS/qfFGOIt+YhXa/anRoWxC?=
 =?iso-8859-1?Q?pIF3xwXEZ+bCkIuQLgOkbTzvGQZ3n48SHjO1zNZSyFRrp97MZx+OT1MSXu?=
 =?iso-8859-1?Q?o5J1W9CGnUHhJphOGfIXqANRTuS+1f8Mk1lF33hq01YKKVAXR5kuaxjhW3?=
 =?iso-8859-1?Q?US0QhfTiWgfLCkWV/sPuyIkTexJdw2sB+547bgaX0jedQiiNakZ5RcaV33?=
 =?iso-8859-1?Q?GTszk1F9Lk3lOCAdi0ks439kt5Eo8qBewrXMnF5rDWyHR0RDU1ZEd5+Wrm?=
 =?iso-8859-1?Q?eEya56meQ7mjW2lit8SdX4XE+w5VXHU8WcKYFljESon2WlFCR7TsAalv9X?=
 =?iso-8859-1?Q?yUv+bVg7JiGekNrgOBxHmZz/sjKhJwqgAsPPcKeAO8QiNsY5XEWq/VMsgg?=
 =?iso-8859-1?Q?y1NonhnQwDCtwZDEnRpoZ0PUwiRJgQWDW2ficNmIyTghYP9ySdBQwPljtL?=
 =?iso-8859-1?Q?4Q/Lywlb4Owruru3I2Xvshi8mvsYhAgA131d3fduoDfuscOcFnXqC8/Wms?=
 =?iso-8859-1?Q?DLjfs2J5gA6ioKVPZTojyVGo0kPyrfjCGTPCxl46dbd3IZzo0GdOu9p1Eo?=
 =?iso-8859-1?Q?AyOERI+pDKIfxxRdFLq/PB8Wu6IsnNn851AMkRAu7Ee6sJMslndwoGTMQ1?=
 =?iso-8859-1?Q?fn50XY+eDRE/H9V/JN481dm+BMBRyct67x8P9jK4I25A69C8dQNxHgQ+qG?=
 =?iso-8859-1?Q?TjfY01FDQcg6f7WNhOpHgmW6m8mwzrzXI9KgLpn66VtPJs3c4EUPFsN6IM?=
 =?iso-8859-1?Q?CCMr+dVspmFzoT5yLE7B9HJGhV5OE12DrLvRIFRe9MYKYLn1el1rP0ARvd?=
 =?iso-8859-1?Q?kXhfQic5nUtOD60gJvP098ZGXhr/pgBooFuUOmyWJgd2DUYfAm1T5GsQG2?=
 =?iso-8859-1?Q?t/hpRK1A64B2API/7zTwQHZErtC7utwzs5nHanHUvFVUyer5SVhd0Ntqoz?=
 =?iso-8859-1?Q?KlpxwHDrDspXr/wNgb91Lpy9b02SFI7hDh+A6MAI6XEanZmPRBrrT1op7q?=
 =?iso-8859-1?Q?faabob7QqeYENSNk6+ecZFgZR9JqsTloxPgqHOVXYZ/kXwT5kxuIVVToY0?=
 =?iso-8859-1?Q?HjQUcUiQ0yB2Pi9OzcNPgZRQTT7hIAJ+j0uH8fWuQYgu1hcVaUqZYp4acS?=
 =?iso-8859-1?Q?kI8VvPcw0o4sZAtX0TMOWOlp5TVThStJLd6Y0346a3LEgN3lpGUK8GbH53?=
 =?iso-8859-1?Q?qDiDFBfiUrVBwymkKdsdlmyVVGV714Bmns4P8ZDdXpc6OFqL4P3/fAAENU?=
 =?iso-8859-1?Q?i/pL+jQ5JHaSj41keZ+md2OORm0/l184u/ukAqaZfquvrqRPWrOexfAmdD?=
 =?iso-8859-1?Q?em5zlvvjpzrWAOfutzVMMEZNfehdpZl4HkZ6IVXk4n5qMIt3+ZvX06sMTo?=
 =?iso-8859-1?Q?f49Vxtc+rIt4HZFFHVbyfwu5qA9ECX0Syn+v/rY+nN0gAHZH1Vrq/77rtw?=
 =?iso-8859-1?Q?HCb4TFGYspALrNKgf1wqRjOgtGioswSyvl4hJUp9JxM6qbw5psfUEtGrHv?=
 =?iso-8859-1?Q?blaAW8mfKA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7553d236-7655-4da8-fbfe-08de7413595e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:38.5190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SztEuOjVsIBMq5V+RWbSxc2WZUOw/Go4AMq9GUbHwxG0qY3z+SWClrfDjXCXYEuTdIVV3sHokWYAV6/6o/GJIOVg7FYIfGUBBPoPp4JGk+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5702
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 12 ++++++++++++=0A=
 1 file changed, 12 insertions(+)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2600_sdk.py=0A=
index 971fa3390d..46b9f7058c 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
@@ -31,6 +31,15 @@ def do_ast2600_pcie_test(self):=0A=
             'ip addr show dev eth4',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
+    def do_ast2600_i3c_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab'=0A=
+            ' -w 0x12,0x34,0x56,0x78,0x90,0xab,0xcd,0xef',=0A=
+            'Success on message 0')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab -r 8 | grep 0x | x=
args',=0A=
+            '0x12 0x34 0x56 0x78 0x90 0xab 0xcd 0xef')=0A=
+=0A=
     def test_arm_ast2600_evb_sdk(self):=0A=
         self.set_machine('ast2600-evb')=0A=
         self.require_netdev('user')=0A=
@@ -43,6 +52,8 @@ def test_arm_ast2600_evb_sdk(self):=0A=
             'ds1338,bus=3Daspeed.i2c.bus.5,address=3D0x32')=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.0')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.vm.add_args('-device',=0A=
+            'mock-i3c-target,bus=3Ddw.i3c.5,pid=3D0xab9078563412')=0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2600-default", "image-bmc"))=0A=
 =0A=
@@ -69,6 +80,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
              '/sbin/hwclock -f /dev/rtc1', year)=0A=
         self.do_ast2600_pcie_test()=0A=
+        self.do_ast2600_i3c_test()=0A=
 =0A=
 =0A=
 if __name__ =3D=3D '__main__':=0A=
-- =0A=
2.43.0=0A=

