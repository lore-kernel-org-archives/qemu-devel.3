Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A0CE83EED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY96-0002an-34; Wed, 04 Feb 2026 03:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY92-0002YS-R2; Wed, 04 Feb 2026 03:21:52 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY90-0003VZ-I4; Wed, 04 Feb 2026 03:21:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whDJZR7LZ3bAaxNw7wkqyqKLS5bwKR9kq7sjFmyAUJyoAJOa2eEAxdFuXOJ31YVNYMOEePpsn6pgwhDzyJhzbOtuQm+qWXba7AfsLaYKkIXoAL2N3a3wGiYzx8W9RT+4Wue+I7gYcdrN0r4mpKLGFLVTRMISD07ZHCk4bunT5iLLjRO4Opz+a0q6zr0FtTjGn5KyQ6A5HoaD48tn4cZXZYsPZ7Y2wH6s2Re34tmgW53pNy/nZ6gHDz4Miz2nn7SHTA3b8BuipWJUqV3qQCq3jm3Yyrlc+mfLeck8cou6SKTz4YnvHTRPNAW36+p33axCLzaO3DYiDJpE2RsLxcOoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF7Njb9v+BsRlO6R/bn6OpYCAHFDtn4EPfQgyTgefIw=;
 b=LWRuE3EHW4ng2pQbzH9ue5+Bmy1mffeDbQ9bS5wzWNHw1MwbMlYzno2bDG5up0pmUiG+4NA9FLhG0xpwwvU/fvlxkAM1ofzXa5VQNgQ9ClY7kcBIPkJKSMD36Ov76iiifibEd4rQozOvRAE8u5JbwpUDuQzMITEeeyUIj3B9hxyYHvd744Dx3Qa3itnRm+ZEMTv3GgxkPNKrJwhPH0g5Rot0vc/D8lUsz0jLw+emnxNhyv2V7oL7pbnjGetqtBTKf7+p3dQw7bMnUjptNtu2Ei/F3kchhUdYw5bkV/qoeScrMMH16ue1hWdp0QRuHz7q6V3YRpCR8coHdb1kTCruYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF7Njb9v+BsRlO6R/bn6OpYCAHFDtn4EPfQgyTgefIw=;
 b=Qr66RCPPcXJWUJTyQZAWHdgDQfH1I2fV4Zh7C92HwjP28PXYGjsvSt4O+mcmoWLAAK+QBm2F1nHxOEdq+B3lv14609BVEqvPbrWWkfEirbPfp31F9UtgDiRQG63uBb/yxdhzawLwOLxGSMIxU/IX05NAbJPy5SeZHkxJmJzp/Q0cIAKgxrTUQEVKYSBQQDcBqHRN5Xr/jz5PTUPvLFtHfGcRl+ByJ4KdMeaqeOG/NYsEOChudTE+agqMWhouRGWPsXOezvFdn6HJY7L0o46YnXc46vTzkxtE2BuL+WhXrQm9mNzbvfmrV4ElKtumn2fzrc9Yuqg+9vaAEVXOX/uw7w==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:41 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:41 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v7 18/22] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
Thread-Topic: [PATCH v7 18/22] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
Thread-Index: AQHcla9K0p+zl7LAM06fRelgKl9Z8Q==
Date: Wed, 4 Feb 2026 08:21:40 +0000
Message-ID: <20260204082113.3955407-19-kane_chen@aspeedtech.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: 12390f29-c154-4b1d-8587-08de63c66cf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IaoR+tyHhlXRdKb1tSVs6zwHy5LCX7XusxbikFFf/zVNGShtU+MaAboq2C?=
 =?iso-8859-1?Q?64mRdvIJCOrRTILUWu9jqAgnf5yN8YCUz5/Luy7jgB4lrz9Ihk47+GgET/?=
 =?iso-8859-1?Q?XbXaIgsCSwAdrR/XoxlwzeB0NXdqyN6Ux8wv5zGiKC+ZkxxN4s2KXCmFGD?=
 =?iso-8859-1?Q?xcEMRlc7CNI1n5Ka80QewYuXnh9uW+CR4ESsy1c9x67wChE8joR4QK53yH?=
 =?iso-8859-1?Q?J/kE4lFyfNdmGWVYZkyxcFp990uAmK7BYlUlkD7H+fiE7mUlt35PVCm1I0?=
 =?iso-8859-1?Q?s+0+hnb9rOvcFxqFAdISzI2fTbxYzhGFOaXrgFB+ASKCPyDGrSZm1QiQV/?=
 =?iso-8859-1?Q?/9H4uvQZ3noCol3oBE5UhnT+FVKyro1HSFZyxXIRCOK5+61xwKLzuXkIUj?=
 =?iso-8859-1?Q?KjseZcK2Zni8kCmKBAuttNks0XScA2JKezeOU2phoP7J9GyP1Nt7zoYELs?=
 =?iso-8859-1?Q?DyZWJjrUFSF7pIhysmFeqtJTV9+dUq7EfBAEqpVfgTdMIadpNWoBzLo/Tv?=
 =?iso-8859-1?Q?QUWAjhbpPJIBJS5s0c3aG2LN1oImyVfwlteSmlThpywCusuN6hGffhCeB2?=
 =?iso-8859-1?Q?fh85iJi+1L/Umfu/x8ZoYya/GDzWvM4C/TdkvoiBpEgsvUklGRJxquqon3?=
 =?iso-8859-1?Q?RY9PL95uUDr66Gh+vCH5H/IaKyFotIRNBUysj8fxdKHWwCUuNUQCtKkdgO?=
 =?iso-8859-1?Q?rPhXh4JaTSeUuwZynROfD6MhxGz7D8PlNeWQyFUJx8YoYgwFy2vEY/FGHn?=
 =?iso-8859-1?Q?4xXjWsATN3/MSczibwUb0q5CpXQNXN5mVOjBJKEKjH3dtwWFR2+06PfzM/?=
 =?iso-8859-1?Q?YCAmnRI68kOgtrKB+L1TaObGBcoBCzOcCZucE60gLwDpzVfVuK1eCtYvOv?=
 =?iso-8859-1?Q?tG3Y1qnbIe/i8o/JfDFRiSBLce3/7fDYnhcLIr07JS6Q/VKu3yGLLn8Y2T?=
 =?iso-8859-1?Q?hqRb5Nmggowd4vXWO3YntEfwdmGIf/Ct2zMok1iYiWjkJrIPyrEGGOGR9b?=
 =?iso-8859-1?Q?uMIm1eRr025Hf+GyJdFfkT9wT0DWD8iqZBKf9JPgd7NZ/doyZ7WR96Qa6x?=
 =?iso-8859-1?Q?xY7uGAVzAl+tOEcUFxfkXhsZsUqKvw3IPu/wLsF1sOP1T3yGrNtc860CW8?=
 =?iso-8859-1?Q?ukzKxwyG1ONl1qZmeS3krz+GwtpJ8h5xcOpWhbhSyqzL++5KcEkyKZMNbF?=
 =?iso-8859-1?Q?WOd3yIbTOsf4f32LR5Zavk+BqRvCZn/cbXPO2Q9O8N6WVWPIFD23e6B3US?=
 =?iso-8859-1?Q?m6hJeddzlW1kkBsCLS6qbV+jA2lDCoQ4W6yfNwqDdOCcHknKEtxq3EL1h7?=
 =?iso-8859-1?Q?MY4JG4quZJmAC6LCJBGBPIZz0EJJL6NSue9cBVng1ZpQ1rPCReETy4D9NC?=
 =?iso-8859-1?Q?IaO25Ek0DZ3cxkOVLKe4Scv4t9s2JlNCwUYsHVxeuJ/wIPiKYqoVcSvtgk?=
 =?iso-8859-1?Q?nGoUaNO8mai+FV2g67gToCA/ivlbqWOy3HDK43K8cWtY2THtKjmXYX+dJq?=
 =?iso-8859-1?Q?Ti4o/nwpp6WItFDdv914sivOV7s//R75qKvu69WFB91qJpSE0ElWbxxDTe?=
 =?iso-8859-1?Q?swI/tARaVBVV7VOgT0GqKvEZfjv8BensguujNAmm9EKudRewjPYp5PyJVI?=
 =?iso-8859-1?Q?xoQNHqPTr5fFVcDu4e2KsjvO9gT/Y3NH8hk9vF+Cy/eqMnkgVWTjlgKPMq?=
 =?iso-8859-1?Q?wLnYOn/HQhC4IcjoQec=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YMixa/Fyd5xV2/hPjKNArgKcDA66jckkDwkRvVytRXjv3mNMgOW2t39oMr?=
 =?iso-8859-1?Q?k2wlWg7BEeF7uSLGxZeSkkOoJ5bUB4bLlN6QfGA2zvJLGMFsDl78AkbLMm?=
 =?iso-8859-1?Q?EmaIuqnTVNik4UIna6A/U3Qh3v908Qx/7urzhdIuagTYSiCA7IUuSybClu?=
 =?iso-8859-1?Q?tTSq9lBzhsPJR9GdQEcShRww/lSKdt1tv0eUBqFxsgtsp1ZklymIkf13En?=
 =?iso-8859-1?Q?SZvtbDzuxmR9oKfCJZKLtLZmUkcT/fsj0b29333qVjET51dQigrRih35FY?=
 =?iso-8859-1?Q?fxwA4Z02PdzzNpjdNQmQjL868mPjwJ02E5Bk2ZJcTVmh5df45ILeKKULG8?=
 =?iso-8859-1?Q?oQfChDBbXdnWBaigZPIFV7ubWGWGfyemqNnuoPWlUK2+3PexjEGoJk8Ej9?=
 =?iso-8859-1?Q?6wNu6rL6MjX+g1ulGPnOcLIhALy8fetS+Nbg1+p37ovrtJJQ2qM9Op5L5o?=
 =?iso-8859-1?Q?EPI0ijAgyFsVfRtCo3qq6gESkVKZEV6Vo73WhkaYrlvBYsBlANg2l+TD5k?=
 =?iso-8859-1?Q?ECQo0vNh07Bytav8xhZxBN/Giiu5benSPH0JFEI47JPnMqMsTxDdNS4M33?=
 =?iso-8859-1?Q?gIgWf4cYbHeXEs5zGgkc1+TjeWYtUUH4mukbq8egsyi5wpP3+1nL1pASG/?=
 =?iso-8859-1?Q?byH27WLN1NlJuO2/At4uNlj6XucD7uCO5B8F1bOLc/75ZYALxoC0mfnFTu?=
 =?iso-8859-1?Q?P4JLvHeiZjkqgUMs2jj70eJwkRXoAnpI/YU692aomu7eEj0LuSP5MKdPdE?=
 =?iso-8859-1?Q?UUQlB6y1Qrhd28f6nroAOF1NBCHgKMFSp8b/HQLLyRo1iJvgo4ERTQN8TT?=
 =?iso-8859-1?Q?pR51xubNGP0HR5dkr4tiHVzMTdXQB6lybZ6j4XOrvIBtSqGgoai1vp4RkL?=
 =?iso-8859-1?Q?i7pOXtxpvYPKIGSVRk3vwLZCEru0nc09D5238SX22Cc3AYIAOqAOGp3sb8?=
 =?iso-8859-1?Q?rs3qhA6WUA2YSQ+rE5EgnBz0FC+eu5+//kJfUKorDPneo8ey3UnybxPPg0?=
 =?iso-8859-1?Q?QuxdUyik7/WKU7Vgt+OBbQhXdN2p5rk3J1zxV+ekjTmeHiYh+fAkL1OZ9i?=
 =?iso-8859-1?Q?pTUK5y713cb1F+07hmz8zmuwxSfPPuOe9tE5HzoKRR8+lYyP204pKe5sKq?=
 =?iso-8859-1?Q?8UXL4wSR2p4PqEHzbg2KlKQ+YNAW+72+XfWFsu9yHgNjEs3YaS7kPQ3ZTt?=
 =?iso-8859-1?Q?mVwwutGXP/7dW1degbUlTIbVcefXPh4UkfKbHSSkhDhjocTVuej6QCSkpj?=
 =?iso-8859-1?Q?pKa72A5lfXCuVFvvgZSlcjb6jTS4KhCxplF98fnnOTpA7WnW6rEHn8F9d+?=
 =?iso-8859-1?Q?II6puZolllxC49kZOo9y7Q1PcX3wTfY6rZ64yQSjdOforyc6iT5dE4zXxT?=
 =?iso-8859-1?Q?PrSNEOh/QgVvBOyMejxur4LD1LSUcPqxYg9dneMpSId6fq4RBtr1P3rXxu?=
 =?iso-8859-1?Q?sLGjQd7HC0/0PxIYocaTT4v8OPcucOK/T44lp8S7mtunRaPwsjp47+bBd0?=
 =?iso-8859-1?Q?WSf3oU93/mJKsWmtlXomZKG2keNmGzQ9aHeseruB7dyxv6H5z+3HsGSYzi?=
 =?iso-8859-1?Q?3+okcpGmK7h63ZgynzLyuJepp+4EkNd/NIJ+9Fw/vmwmL32LzZoEgZ7Odr?=
 =?iso-8859-1?Q?ZMOsU75vZEEK/wbPvPs/yaBMKMK/bGzinuIj+zrs9JXMPt5ogf0Dzo577B?=
 =?iso-8859-1?Q?d5D6ps+S7XLySZdVwlkSizsUhKlUyfRJgKWSqCrAK1ZGgw12TDvmwaD6k5?=
 =?iso-8859-1?Q?O6q8pR+1fKIF60nNLXVJMgOUPsS5zQgiwcqyQcMWEuTdnUWs2Qzue/hvxP?=
 =?iso-8859-1?Q?IMakYk5RzA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12390f29-c154-4b1d-8587-08de63c66cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:40.9058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5TAlu1B+0uVGAEOVlS3LWi92JS08Szqasc/q24C3s+Prbcw470wZIurNNfUxy9xCK/vsHqIYgroNaMRBBoP7XCNjTfF5LFVInmzW+KwzFxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

AST1700 exposes more I3C buses than the current dummy I3C model=0A=
provides. When Linux probes the I3C devices on AST1700 this mismatch=0A=
can trigger a kernel panic. Model the I3C block as an unimplemented=0A=
device to make the missing functionality explicit and avoid unexpected=0A=
side effects.=0A=
=0A=
This wires up the I3C interrupt lines for the IO expanders and adds the=0A=
corresponding device entries for the AST1700 model.=0A=
=0A=
No functional I3C emulation is provided yet; this only prevents crashes and=
=0A=
documents the missing piece.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  3 +++=0A=
 include/hw/arm/aspeed_soc.h     |  2 ++=0A=
 hw/arm/aspeed_ast1700.c         | 15 +++++++++++++++=0A=
 hw/arm/aspeed_ast27x0.c         | 18 ++++++++++++++++--=0A=
 4 files changed, 36 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index b5cb0a9010..f7bd4e8650 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -19,6 +19,7 @@=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
 #include "hw/watchdog/wdt_aspeed.h"=0A=
 #include "hw/char/serial-mm.h"=0A=
+#include "hw/misc/unimp.h"=0A=
 =0A=
 #define AST1700_SGPIO_NUM            2=0A=
 #define AST1700_WDT_NUM              9=0A=
@@ -46,6 +47,8 @@ struct AspeedAST1700SoCState {=0A=
     AspeedI2CState i2c;=0A=
     AspeedPWMState pwm;=0A=
     AspeedWDTState wdt[AST1700_WDT_NUM];=0A=
+=0A=
+    UnimplementedDeviceState i3c;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 4ea2521041..b185b04186 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -294,6 +294,8 @@ enum {=0A=
     ASPEED_DEV_IOEXP1_I2C,=0A=
     ASPEED_DEV_IOEXP0_INTCIO,=0A=
     ASPEED_DEV_IOEXP1_INTCIO,=0A=
+    ASPEED_DEV_IOEXP0_I3C,=0A=
+    ASPEED_DEV_IOEXP1_I3C,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index 174186964e..e90302c11b 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -15,6 +15,7 @@=0A=
 =0A=
 #define AST2700_SOC_LTPI_SIZE        0x01000000=0A=
 #define AST1700_SOC_SRAM_SIZE        0x00040000=0A=
+#define AST1700_SOC_I3C_SIZE         0x00010000=0A=
 =0A=
 enum {=0A=
     ASPEED_AST1700_DEV_SPI0,=0A=
@@ -26,6 +27,7 @@ enum {=0A=
     ASPEED_AST1700_DEV_SGPIOM0,=0A=
     ASPEED_AST1700_DEV_SGPIOM1,=0A=
     ASPEED_AST1700_DEV_I2C,=0A=
+    ASPEED_AST1700_DEV_I3C,=0A=
     ASPEED_AST1700_DEV_UART12,=0A=
     ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
     ASPEED_AST1700_DEV_WDT,=0A=
@@ -42,6 +44,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_SGPIOM0]   =3D  0x00C0C000,=0A=
     [ASPEED_AST1700_DEV_SGPIOM1]   =3D  0x00C0D000,=0A=
     [ASPEED_AST1700_DEV_I2C]       =3D  0x00C0F000,=0A=
+    [ASPEED_AST1700_DEV_I3C]       =3D  0x00C20000,=0A=
     [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,=0A=
     [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
     [ASPEED_AST1700_DEV_WDT]       =3D  0x00C37000,=0A=
@@ -178,6 +181,14 @@ static void aspeed_ast1700_realize(DeviceState *dev, E=
rror **errp)=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt[i]),=
 0));=0A=
     }=0A=
 =0A=
+    /* I3C */=0A=
+    qdev_prop_set_string(DEVICE(&s->i3c), "name", "ioexp-i3c");=0A=
+    qdev_prop_set_uint64(DEVICE(&s->i3c), "size", AST1700_SOC_I3C_SIZE);=
=0A=
+    sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp);=0A=
+    memory_region_add_subregion_overlap(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I3C],=
=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i3c), 0)=
,=0A=
+                        -1000);=0A=
 }=0A=
 =0A=
 static void aspeed_ast1700_instance_init(Object *obj)=0A=
@@ -227,6 +238,10 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
                                 &s->wdt[i], "aspeed.wdt-ast2700");=0A=
     }=0A=
 =0A=
+    /* I3C */=0A=
+    object_initialize_child(obj, "ioexp-i3c", &s->i3c,=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+=0A=
     return;=0A=
 }=0A=
 =0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 8242258df4..d3b305fa7a 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -158,7 +158,9 @@ static const int aspeed_soc_ast2700a1_irqmap[] =3D {=0A=
     [ASPEED_DEV_PECI]      =3D 197,=0A=
     [ASPEED_DEV_SDHCI]     =3D 197,=0A=
     [ASPEED_DEV_IOEXP0_I2C] =3D 198,=0A=
+    [ASPEED_DEV_IOEXP0_I3C] =3D 199,=0A=
     [ASPEED_DEV_IOEXP1_I2C] =3D 200,=0A=
+    [ASPEED_DEV_IOEXP1_I3C] =3D 201,=0A=
 };=0A=
 =0A=
 /* GICINT 192 */=0A=
@@ -221,12 +223,24 @@ static const int ast2700_gic198_intcmap[] =3D {=0A=
     [ASPEED_DEV_IOEXP0_I2C]       =3D 0, /* 0 - 15 */=0A=
 };=0A=
 =0A=
+/* Primary AST1700 Interrupts */=0A=
+/* A1: GINTC 199 */=0A=
+static const int ast2700_gic199_intcmap[] =3D {=0A=
+    [ASPEED_DEV_IOEXP0_I3C]       =3D 0, /* 0 - 15 */=0A=
+};=0A=
+=0A=
 /* Secondary AST1700 Interrupts */=0A=
 /* A1: GINTC 200 */=0A=
 static const int ast2700_gic200_intcmap[] =3D {=0A=
     [ASPEED_DEV_IOEXP1_I2C]       =3D 0, /* 0 - 15 */=0A=
 };=0A=
 =0A=
+/* Secondary AST1700 Interrupts */=0A=
+/* A1: GINTC 201 */=0A=
+static const int ast2700_gic201_intcmap[] =3D {=0A=
+    [ASPEED_DEV_IOEXP1_I3C]       =3D 0, /* 0 - 15 */=0A=
+};=0A=
+=0A=
 /* GICINT 192 ~ 201 */=0A=
 struct gic_intc_irq_info {=0A=
     int irq;=0A=
@@ -243,9 +257,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcm=
ap[] =3D {=0A=
     {196, 1, 4, ast2700_gic196_intcmap},=0A=
     {197, 1, 5, ast2700_gic197_intcmap},=0A=
     {198, 2, 0, ast2700_gic198_intcmap},=0A=
-    {199, 1, 7, NULL},=0A=
+    {199, 2, 1, ast2700_gic199_intcmap},=0A=
     {200, 3, 0, ast2700_gic200_intcmap},=0A=
-    {201, 1, 9, NULL},=0A=
+    {201, 3, 1, ast2700_gic201_intcmap},=0A=
 };=0A=
 =0A=
 static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)=0A=
-- =0A=
2.43.0=0A=

