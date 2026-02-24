Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E430EFB811
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 07:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLZ-0002Na-B8; Tue, 24 Feb 2026 01:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLK-0002Gp-8N; Tue, 24 Feb 2026 01:56:28 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLH-0005Ll-2S; Tue, 24 Feb 2026 01:56:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU6IyT+7ffjGdoK5hEAC1IRQRD+KChVpPOzYjlkaWawloj42y++jMq+VAazoqbeEBAKGVJRQJ0ovViMOdCIAyKzoebrUt0MN8zqSrOFWV5npc3drclUrRzhPqS65hkFkabI2RnIQMaYELy/7ufpReMm+F8nllX+q4w0QWdz2aVOrK6IqQYy22yqhMinhXV6Y3MRFvzBKvaF+5hWnxx5vaCLYjQ47tTmrtjFeVEQ2+Nj77nBLzAIjwaYWek2OwQnaVHe7KZrbEBb4h2KbgyIS269RTkHTZ/+QaJJoI2PiLmJbE6HF/vlExWCyv3HX9yFSj6BoRCzqoiuOXNY+2TP1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4FwuCKF8/ITTlpgdltpuEtxG36l0GIW2LEVsMjYr/Y=;
 b=praJKK9CttYbZ7sjGdZbdoWlm+5zWscFPLDgVvh1xjy1IL5VkYODKVhPQlSP8l56EinGM+63mr6qQDY+kUsXOgvQQ1fGYa2zVsotYOvv16ky/BZHMn4EURK3D0fM5RVo9oiFyBfMM2MbYQigJkseznzRVnQXdjIkuxX8o1lWNYa88kvLdXuEEycV2FSrZroS9HbwrWa2/qiKede6Lu6fGzR0Qw8r7d04a8KZcLreSr+HM2DQ7dDAvKUeb1XdO6Hu0iaaFIQm49BgEIjEgaC0T3U3p5TeJOujmZMC+mE4wJfvlPsmv15PwHHVP7QkKQ6KVmBOatKf2mY7AwGTUSMxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4FwuCKF8/ITTlpgdltpuEtxG36l0GIW2LEVsMjYr/Y=;
 b=D5jawZ7cltRASMXM6HAPCmDKurxsCR35HtmagY4vQSBuhxlPLYBKvD/tXO6/oMaAjoRFqIKqDC3e6UhgShdEAzhEXZ0PCsenIpjvRygzyi75+TALMehlM0n8RgAjJDiAcB50pfJYcw9Bo4J1UU4H6HwMKSJ13BGFr3JbVImzRlR6FHoOwDNznFrLGTnCvumAxNeyNV09dRbsryL++qi9Vvn9yLNSdzs6wNCI87BG+hcme8mU33Z1F0q0CzP8T21rx1et+hy7b45LtV6EHcRjiioiNcknTxh+D/rBGFJ2UMlB8zIWEiYhGVJwaDhwwXHK5/Fwws+YacNKmBW9G9YD8A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:04 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 04/15] hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap
Thread-Topic: [PATCH v3 04/15] hw/arm/ast27x0: Add DRAM alias for TSP SDRAM
 remap
Thread-Index: AQHcpVqjLh68W5Hkn0yLLRW9dLLL7Q==
Date: Tue, 24 Feb 2026 06:56:03 +0000
Message-ID: <20260224065556.3847942-5-jamin_lin@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: 461d1856-790a-4ba1-f434-08de7371c71c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?RrhqDxo6XNX5+7iHvlYVeqCObhmMpvOJl/9SDhTOLh4HfOaKC2g3mlivSP?=
 =?iso-8859-1?Q?zQzynCijd09J5PKoJIqxjOhzzpb78Ui+LnEcSVwYz72zYAiuJWvG94Lb5g?=
 =?iso-8859-1?Q?jAvykxfdnZ49avhjPZJWyslOCwbA0Ou3DA1fP/5f4Nu8PGStQnL4q0LXaT?=
 =?iso-8859-1?Q?4rXaTW8pgHIaZmUovqgpS0kRezmQX/K+NM5TBCo/Fq9f3TbzwCjQlJGgJe?=
 =?iso-8859-1?Q?PQFJnREsTFrSnk3wtmuHWVFHUlOM1qCgL8rf6BiGnakKgdRPm5X3c+YOAK?=
 =?iso-8859-1?Q?cq/MQ5mEr8UU7z+umCHnrOAeoSgtVyilByK6xKLipkEmqC2B8QO5CnYjpg?=
 =?iso-8859-1?Q?vQAf2yE2pDk5yyenB31EGFMhvhLd74dhwy9KzYiiVBkzN0t3FLV8iaObyA?=
 =?iso-8859-1?Q?MLw2ILsEuwORXdS9r67lMoQNanIxa0qokzJffF8W0oksxRhc/AUGyiQ+mn?=
 =?iso-8859-1?Q?fN9meXBy/9nfoz6gAceZT1KnYg3J12QUt8Vg3Vi5OVLROdsdBeLijhv6pN?=
 =?iso-8859-1?Q?SmigSH8cMX+b1lKQDJ/KrxumWYoEsmtkIwpliRxPJfN87Rphe/8AN86nry?=
 =?iso-8859-1?Q?kWy0G5iuInzJ6dwawcqiPocpS/vL0G1VwPfhkAHW5a+fvJPB0b8KHuCrRT?=
 =?iso-8859-1?Q?uJSP7QLChb6B2jZhBRR+Zrbfq4YUNFbs10O0owkb3bSHXI2dJeOgyCfQty?=
 =?iso-8859-1?Q?jUAzyNZODV1IbVd8STYzInBOBFIyRFoOyfXjQXHLAZ7N2ZbixWm5TlAfFp?=
 =?iso-8859-1?Q?yD9jq3ebl7pqEoPB4/yFjknflUgaWcR1LWgLdAsyIt5aZzsFU4z46YmCIk?=
 =?iso-8859-1?Q?JLMp8d4NR+/vbr2EwEc1QaE/KbUkdWG55OGczZMgfAlviNvxdaXvrBkOu5?=
 =?iso-8859-1?Q?3vd8LX1D9k0Zy8zjxrY8xjkBx6OxNe2A1tZiWovfevNCOybU7epLJTlN1K?=
 =?iso-8859-1?Q?kp1vJMn4XizrUB0nM6RaXGggDYFpyXURA+vUK8qm4SvM4/aRcRMrK3CZzi?=
 =?iso-8859-1?Q?d/y2yDZA7+r/F6EYtJPP4zN0Qa0B3e2Pk8sfD8tEkAnL1aOYA6fGG3Uzpo?=
 =?iso-8859-1?Q?pMs54RhmY8fwpY27PbhBtkHdWqc1DWOiVA1KehccSkk2gM5064XMzPyfNw?=
 =?iso-8859-1?Q?wyTZwUIZbqOMF5tyR2wVAMf6P1fx7s16alru9S7/OlGf80egh9xZe8f0Tf?=
 =?iso-8859-1?Q?oiuuPyfQRIGDk6ibZNcCv6oQFOTWIkbxlKwbtN/61dN6gg3R62/yZmfUa7?=
 =?iso-8859-1?Q?+5RNn9qYjF+Giou8nwp30mOTM2tbGwqys3SSVnA3NvPqdbROL+0OXQjBVS?=
 =?iso-8859-1?Q?bIDhFYEgM+mlOpVhsLfhnET4NWJsuwBmP8yvvGUuCGS0kR6fheJXjbMqj7?=
 =?iso-8859-1?Q?4+DC5ntovv1AVuoqq1NWtYV1kUfJcZtkAraJlxMABsK9hafFe1wSVF72tK?=
 =?iso-8859-1?Q?/5QsNVxtZNyM3y1Z4gFhClOivhJaisUnvJHdLzUNmBBtneRQ5V9e08kmIe?=
 =?iso-8859-1?Q?2EUK3wTkXQDWqq+7vIBjlaKHCn+gx7ciPnv6T7scYCzIw9rJxx8nnalG4e?=
 =?iso-8859-1?Q?Ix5YeQ600+nwo5MWuspI8xdrXDeC13hLGweXSroTP4TN/zsksbkA7hUa+I?=
 =?iso-8859-1?Q?f35kjLM1+2vuXZcbVkYNsl/1Web6s8W0bnvl39iJBKMfvJw50w8GCesGiR?=
 =?iso-8859-1?Q?d0SLR7yy7BYrUF/juVtw21CwmMZECiZVt4ZCy2ui?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?geIxv5eJegWnK87sFJF3q/Ls6DyQ6x5p/RK2WTWxr1ZXHO2xHQB0GevS6B?=
 =?iso-8859-1?Q?wG4KxGGMNfv8GnKeI4xRbAxY9Rs6c49dYPM2FuPhUvglxtyxJA2ut6/45f?=
 =?iso-8859-1?Q?TBe0NJyPtfahKKbeftBGt63OPD5xMc4n4SBOv057Gjhu13ScCqLoQ4HdZQ?=
 =?iso-8859-1?Q?TE2PEMtxWrfcnhTzLuNfYZ2x4cnrHMdzI10MHg+KG5dbWbHFNkxR6ixuU8?=
 =?iso-8859-1?Q?dyosBjuU3CS4RuRr7W0ibwzgnuzwoqRZ1VnKr3TY99ZSz/EUoEz/7YQzKp?=
 =?iso-8859-1?Q?dgrbP0Cj3W3WWj1ogJKkyRSoiTsRrhZ2Z5xLX7croweSHfUTP3uVTU83nj?=
 =?iso-8859-1?Q?ZdxexQnn4S9qM4TLJhB//M/zBHkQ/1dyPDf18eR4FMrVETPgyvg3nQjAbI?=
 =?iso-8859-1?Q?41ov9t7WArsNr1O4uoOYQPQAC4UPbgx6922SJhPbsNEAxvg5L75UXQzpF6?=
 =?iso-8859-1?Q?D8oo2OM7c9/SCvOHaObucg4xESUOXnjWv4fuI3PFA0/8VvrANIUaGCFoR9?=
 =?iso-8859-1?Q?ifhLzfczXM6mM7zDRzFxcaazPRpwsmXs+687ytVh/T77YWr6pBlAMIudyV?=
 =?iso-8859-1?Q?Kn2immUKWTgTcHdSxe6zLP5/Lnqey4lov5Xyp1mFWPt5yJR0qPJAZi9cls?=
 =?iso-8859-1?Q?fUbIXBGM0weYqgzPdlkzyWmUq5wZX3DsJNY2puZT3DVNtAlN9ABPreW8DS?=
 =?iso-8859-1?Q?FfnEPUkpoO+eNOh5W5LfjRcviRM1masvMwjlGKtnp28E6kuDk0ydhl9596?=
 =?iso-8859-1?Q?oHT2GwhJ6x3Qidxm2rQf19R3SE1XkoHMfuSAlaUDtD2wWNFJnKN/ebJQjp?=
 =?iso-8859-1?Q?LB7jdht4H1lDJHQ5E5pIyEndnWVS93ZASZWU10MSYQ2R2WLuHqrDlUNNQA?=
 =?iso-8859-1?Q?EdP9yFbtUad+ZXQsAqhVnSAdMkdHkJ874s1Ocz/T2RNf6m6Vyl9ahZmH5w?=
 =?iso-8859-1?Q?66G0kRSb9oxPy4XWcRDF4H0s84BIAoR1lqoUTz0J45OhIb3WBLBdWqhc7E?=
 =?iso-8859-1?Q?9VamONp/OJ1HlBAEXiqU4iOardM0V7jwXt13X6GegdG59k1SY4JMvWV2Rd?=
 =?iso-8859-1?Q?pqAJFV4NmoMvY0RXnlSipi5XdRS6khtGCJpcAqEBWgkhRsJL8jeE1iLK8z?=
 =?iso-8859-1?Q?CRelQpVKYI4wOxmCQheTKEeQljkKRtflZ9i9bGRthIyhbhbozgSVTBHWBt?=
 =?iso-8859-1?Q?jgMOndCr0rf8qObpF/d++tG6AIt2cETt/1FJHrr+SZJgwz8ukjjUXJdEuA?=
 =?iso-8859-1?Q?vlNfRmDZ7ecDIU7zXp6larDbgbE99sGaNDTA1zisEKCMogGWJFLCNpZFeC?=
 =?iso-8859-1?Q?Gyogcm21ram2MpjrNtxFrveyZoIokj4o1mJpDmQiGNHNaRb3AmU/9ipDMt?=
 =?iso-8859-1?Q?sPAzuny2AWKLHVAQnx+Hdoy9r0VAjX2N/zBHDoa6+a8295hdVWk0Kl8WUY?=
 =?iso-8859-1?Q?5PlXxcp1v1NkfB1/tQpGFPX/qBpjSog+fHmXmmxvgAg+fJU5DYW6C+hpia?=
 =?iso-8859-1?Q?roeTIk0Uh3jdnli9i1+5nLlZ8+irrSElnQxR+4pvKSrQb6dTNrVpChfoFh?=
 =?iso-8859-1?Q?a/9JCNZMOAW3gpg1cPh8UZrtVkHee939gWh34a0h4YitcKpgMhWOtZR7xM?=
 =?iso-8859-1?Q?9ZhHtGBEPHBNRdIV/0inXYFCshOLQ0d99wQdbXJj0ckNqZZfPV41L4/cz2?=
 =?iso-8859-1?Q?2bMpQGq+ZuCxnMkvmkKo9xn6qYJWxgT/VE5s2Da8E7r50rOch0vXnFriwE?=
 =?iso-8859-1?Q?ZAb/jPJ6eMHsQGGuGx5MLas9pO8NJigy1tzbFsOz0mEcFI8Q/cD7BCYz6v?=
 =?iso-8859-1?Q?Czz3pswH7w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461d1856-790a-4ba1-f434-08de7371c71c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:03.0634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUDegWiW8Lyb6UeDkEPKEVr1lbjxhfpdRs3Y+eVy8oP+g78KbkxWg8XeF2l48mMtxJJFRepV9vD38W/lrA8n0ikOMZXSxwMqKiZuox6GAaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

This commit adds a MemoryRegion alias to support PSP access to=0A=
TSP SDRAM through shared memory remapping, as defined by the default SCU=0A=
configuration.=0A=
=0A=
The TSP coprocessor exposes one DRAM alias:=0A=
  - remap maps PSP DRAM at 0x42e000000 (32MB) to TSP SDRAM offset 0x0=0A=
=0A=
This region corresponds to the default SCU register value, which controls=
=0A=
the mapping between PSP and coprocessor memory windows.=0A=
=0A=
Set TSP CPUID 5. SCU VMState version remains at 3, as it was already bumped=
 in a=0A=
previous commit.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h |  1 +=0A=
 hw/arm/aspeed_ast27x0-fc.c   |  2 ++=0A=
 hw/arm/aspeed_ast27x0-tsp.c  |  3 +++=0A=
 hw/arm/aspeed_ast27x0.c      |  2 ++=0A=
 hw/misc/aspeed_scu.c         | 17 ++++++++++++++++-=0A=
 5 files changed, 24 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 9c29ca217d..58fef73159 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -43,6 +43,7 @@ struct AspeedSCUState {=0A=
     MemoryRegion dram_remap_alias[3];=0A=
     MemoryRegion *dram;=0A=
     int ssp_cpuid;=0A=
+    int tsp_cpuid;=0A=
 };=0A=
 =0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 77ce312591..38c5d06077 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -102,6 +102,8 @@ static bool ast2700fc_ca35_init(MachineState *machine, =
Error **errp)=0A=
                             sc->uarts_num, serial_hd(2));=0A=
     object_property_set_int(OBJECT(&s->ca35), "ssp-cpuid", 4,=0A=
                             &error_abort);=0A=
+    object_property_set_int(OBJECT(&s->ca35), "tsp-cpuid", 5,=0A=
+                            &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index b99b18bc6e..6c0f166a34 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -198,6 +198,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
                                 &s->scu_alias);=0A=
 =0A=
+    /* SDRAM remap alias used by PSP to access TSP SDRAM */=0A=
+    memory_region_add_subregion(&s->sdram, 0, &s->scu->dram_remap_alias[2]=
);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index b914c01825..52cd2bcbe7 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -434,6 +434,8 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
                               "hw-prot-key");=0A=
     object_property_add_alias(obj, "ssp-cpuid", OBJECT(&s->scu),=0A=
                               "ssp-cpuid");=0A=
+    object_property_add_alias(obj, "tsp-cpuid", OBJECT(&s->scu),=0A=
+                              "tsp-cpuid");=0A=
 =0A=
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUI=
O);=0A=
     qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 84fe88e58b..9bfe132840 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -616,6 +616,7 @@ static const Property aspeed_scu_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("hw-strap2", AspeedSCUState, hw_strap2, 0),=0A=
     DEFINE_PROP_UINT32("hw-prot-key", AspeedSCUState, hw_prot_key, 0),=0A=
     DEFINE_PROP_INT32("ssp-cpuid", AspeedSCUState, ssp_cpuid, -1),=0A=
+    DEFINE_PROP_INT32("tsp-cpuid", AspeedSCUState, tsp_cpuid, -1),=0A=
     DEFINE_PROP_LINK("dram", AspeedSCUState, dram, TYPE_MEMORY_REGION,=0A=
                      MemoryRegion *),=0A=
 };=0A=
@@ -874,7 +875,7 @@ static const TypeInfo aspeed_2600_scu_info =3D {=0A=
 static void aspeed_2700_scu_dram_remap_alias_init(AspeedSCUState *s,=0A=
                                                   Error **errp)=0A=
 {=0A=
-    if (s->ssp_cpuid > 0) {=0A=
+    if (s->ssp_cpuid > 0 || s->tsp_cpuid > 0) {=0A=
         if (!s->dram) {=0A=
             error_setg(errp, TYPE_ASPEED_2700_SCU ": 'dram' link not set")=
;=0A=
             return;=0A=
@@ -898,6 +899,20 @@ static void aspeed_2700_scu_dram_remap_alias_init(Aspe=
edSCUState *s,=0A=
                                  "ssp.dram.remap2", s->dram,=0A=
                                  0x2c000000, 32 * MiB);=0A=
     }=0A=
+=0A=
+    if (s->tsp_cpuid > 0) {=0A=
+        /*=0A=
+         * The TSP coprocessor uses one memory alias (remap) to access a s=
hared=0A=
+         * region in the PSP DRAM:=0A=
+         *=0A=
+         * - remap maps PSP DRAM at 0x42e000000 (size: 32MB) to TSP SDRAM=
=0A=
+         *   offset 0x0=0A=
+         *=0A=
+         */=0A=
+        memory_region_init_alias(&s->dram_remap_alias[2], OBJECT(s),=0A=
+                                 "tsp.dram.remap", s->dram,=0A=
+                                 0x2e000000, 32 * MiB);=0A=
+    }=0A=
 }=0A=
 =0A=
 static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,=0A=
-- =0A=
2.43.0=0A=

