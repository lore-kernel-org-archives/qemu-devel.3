Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310E5E83EF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8u-0002Tt-SD; Wed, 04 Feb 2026 03:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8p-0002RF-W9; Wed, 04 Feb 2026 03:21:40 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8o-0003UH-GB; Wed, 04 Feb 2026 03:21:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeeRVbC/vMck6cGt/qkFFvH5eOs413vIjLEI86mDwu1kFQiy3YXTXsC3Ya9z7SJiyY5in/3wHNqwgSBnBbHSUsp2OfdDKN2digvu8lgCXaJecZC0G+HnUDD+N8fsZSyY92TLtnNfzqqvGWpba1UhKoHLs/Hptj5xaKtDR87V6xZK5Q6PyZ7TMY6YNR7aS2mF50SoYMEvCjb87QQJMu0w9SXrVRpSc83ASHXXIAUKVD+5/p4NTAOTWN54KYO8rasagM7viViJLJ+bqNbZyrC5KUAj5QERudgVgFX9cMGoSDXopMb5APoAytA+uznSd6DUuYyMoTUY+jwsyCiEfu59Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwQd5lkR0v7BLlBAi4FSkkeGDFJ53JIDTA2nfnL3ohw=;
 b=GCnTIdGKHvearE4yjbHAFSiAoLZDXMoMk3K4NzHvcBr4a1wH6B7rTDDlX8HEex6GwNAfpU5Z5Yd7vXbZf425WapGcfXATbYPAX1Ej1lyVfh1JhKpYUnbsdlZk9vU4ZAJghP2Vllc+mdRysvvk+jpYRQj7ONOdmg++fHAXV7+I8M1zUDEqhBAmhocksz8eesKY9X4fa9TGideSm8aWhHJJK5aotVkGe3X/etfO4pjx9TQpAz6SEWXlI74OJqr2Zmejwp39kPPqh8pVGf8xz7VvqxxlFbdYw/dwFWMZVtvGOpYaX/rB5cT//bMkN+Q8atYtRPziyB/NsUk5h+UCmXtdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwQd5lkR0v7BLlBAi4FSkkeGDFJ53JIDTA2nfnL3ohw=;
 b=fOxecNRMAjQg17iqEvJvlrhvC3fBQ+U/KzMH6kZ/2NR9cUqG9BT7Hd1fP8Er9ROr5Ql7OBbb++n8RjhMMeYHeCT1FKNT10OZbPUfcMtVzhzu1VZiDNHp3HIHa7molYS5OSFwwxn1EaNrr5I8viVK/SEcLkpPuh0AwOxvlqfLfwr/UMDAwQqiNlfE6VWlWN9uT/IAf6TvRN0ONCXDwqFte4PVnUCw5BH5WnjeKKOBrC5PKTzwec0xEZHFH4WhhDZgMH3Xu35QdyTRfHbnGgXUcQI7//kDtoAaQfLlZm6DcCTpwdsAH3mnjLbzenQZubSdKPnc+NMvVwlEazQEb1bhOQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:30 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:30 +0000
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
Subject: [PATCH v7 11/22] hw/arm/aspeed: Attach ADC device to AST1700 model
Thread-Topic: [PATCH v7 11/22] hw/arm/aspeed: Attach ADC device to AST1700
 model
Thread-Index: AQHcla9Dh28eTBJs+0CGxSnnqDMaZQ==
Date: Wed, 4 Feb 2026 08:21:30 +0000
Message-ID: <20260204082113.3955407-12-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 563c7c77-fb34-4557-3be4-08de63c6663f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?cp29pXSMEnTg33k0wtL7PhEhbA861AnwYJFjaHNoNxGZo1PGDqknvYH2rx?=
 =?iso-8859-1?Q?L4fPk99+IOdBSbdCsJyuTsW0gEyfY26bl2HEJ++jeFoFal0w+3TfLswzkb?=
 =?iso-8859-1?Q?u/4EWmOHUxfF4z8A8oJGphqQMY722iUzyFbWsaLiMdmFqgrgi18myfi72h?=
 =?iso-8859-1?Q?gOFTsdKx/Jqp3IoQyFVnAv4F2vi2+flsWIWRoyP68enUwYQpjBO0arsAFb?=
 =?iso-8859-1?Q?tpORzAN+Yfr+itp73pK5q4/yiXxCALqHvbkR8axAO6l6g55GWjxu+upouM?=
 =?iso-8859-1?Q?zhYRb9jUEKXCgfCzZi13jHZFdOwf4TNLz4J0mldQqYNiqOiC8AYlnZfohL?=
 =?iso-8859-1?Q?2M2VVCOtZ/lF2pmH1bGQfHvk5hmBOUrgsxUP9YTUkrwe29cETw4iT5dI/U?=
 =?iso-8859-1?Q?rAu1jJMvArQdwesvx83WsGNIwaGf3lroYe+vDT7TK0P1ZdNu3UFY32+Ri8?=
 =?iso-8859-1?Q?YFGGh0FKfcuBSkW8wKyE4kjbfHbN94r2JOBtI63h0adH4bXKnAvyWPS+3X?=
 =?iso-8859-1?Q?7cAak3s+yquPCEpy2Jc2HqmKRKfCBU5Vmp6LHfaBla9zA5eH4H3/j6fkyv?=
 =?iso-8859-1?Q?uJffKrNB4dB7zQwP7dQzEMUhVn2uVyQ/M/W43U9IxGseIN+6bPtlHxP0qZ?=
 =?iso-8859-1?Q?WBl0wWcJjDU3AuVVjIzpBKOsgV1WPgFJemXr0uH33ElhjTILrVZi1zIF98?=
 =?iso-8859-1?Q?yeJeoSoezZ8vMYRE6J6siAG61XGZblx0bt6Fipji/GoyH25JIGhfZyos9c?=
 =?iso-8859-1?Q?0hc8SUXgotzwRjK7Odc7Jq5AD4MGOOJRQlGKfh64oscDSuzYGxqmlLWGGR?=
 =?iso-8859-1?Q?/saa255dtXxHcHQXsMpviESYCTcLOaL9Sb5SBkA7N2vTz5MTMDYYN8LoUw?=
 =?iso-8859-1?Q?l02Z7gtS5Ekotb4Cb8sWqSfC9x606jNdV/Uew/SQpWs0hSprndrCZtC+gE?=
 =?iso-8859-1?Q?opMZWBcMBAFkgUu1HTxt+4gIJ6+cjkacViFO0RTLMLFuiSkAUJISn4gHL0?=
 =?iso-8859-1?Q?XEzUnKiRc8zZC+gB8vUZKlQFsbhCimTTCy8r6+1dRbdUUmuzcbSpaN73xP?=
 =?iso-8859-1?Q?1vG2maZdjRj1OY4fcMLBdNQtnmh4MGptE7TM+RvpmSQ22pHB0ivyslPmEj?=
 =?iso-8859-1?Q?qd3CfomOadDUZtbnshLF+740wG8iF8EvIKHhWTwklTztsSpaEVkQ+z7pO6?=
 =?iso-8859-1?Q?E/umdg1EITurFGCIsUO9ne399T4RmlPuC/ss7yamk7zDGkVkzyfDiAeoBo?=
 =?iso-8859-1?Q?APBWEjQSmRZ7aqc7jZxUNxVZDFR8o0mm1YJ6E4TOWUQFqRereZn2edmzjd?=
 =?iso-8859-1?Q?HT+mxtgON0wZAvp+zqj/jaJ4ZKY2mMRqGr2dCC9Eab6pNogwIU8r1SGHKl?=
 =?iso-8859-1?Q?AT0JvFo9g7q5F6nXtt64MbRVsBFJMWl1PNuJmU96AIYbvu9zCjNCnC7yli?=
 =?iso-8859-1?Q?HdBDklmir7SXIhObcVAwziLKE735rMFvSFPuSLRrY5GuWtTZIhwbehdHkh?=
 =?iso-8859-1?Q?iJmhPPsB98IbFuUzu+QMdyY7JiFkDlaFEqe8hKMp6CSwhzZ5oEsgEmzHY/?=
 =?iso-8859-1?Q?ymMUs5ABR3dN/N6fzldkFLKWZxY/p3biMnnaSK9p/rQevQ+9H+Sn0cMTsx?=
 =?iso-8859-1?Q?hDxFRFerC0Jz/ogCef/qJlrtnVXxEsvhoHKT5oCTrZLPwzMkG9wWqJHFE2?=
 =?iso-8859-1?Q?P5BJkeRds/brQcDHpoU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v+GsOEo4hKgKBYoOP8blHHzqgzn2B3AZgqNLErdkklgxeXh4n9sV1TPJNK?=
 =?iso-8859-1?Q?lHLfE40fNNH1HyFdc7wr6nrwszHmhAHr/F/98eqWkarZlZzg/eGtseyFML?=
 =?iso-8859-1?Q?95Kptl2TOl0LZOHeBJbVPSlufnHngGgvsly5hpjY/y5RtPIajHF5XLdxVc?=
 =?iso-8859-1?Q?3EMK1yrNEJFnfDUnUkLcMz3JHuklonkrEMLyMoHps6Gm3ZO4IqCTQ+Rml5?=
 =?iso-8859-1?Q?0Xt5lEryqZyMR+Rv4cRPWKPh23oMByzMNjZWdOkSesEFPMNZUDOU7Fn/vb?=
 =?iso-8859-1?Q?jeZB9aRgb9GgGLkk21iTrCnk58TaHf4SzJk56Cx0HiXhGbu6L9e8n6gAJN?=
 =?iso-8859-1?Q?CsVpOT9c4oCO3uZ6oyvPM2w7Ey+8x37SA2u5uR60SPDR0EDb9ad1ZL2LJg?=
 =?iso-8859-1?Q?z90uucXY3vPmq+dSPbkhgxwlhwOP4L8Q2kPmnKE4tWd6+xv+y+J1WJ1h3E?=
 =?iso-8859-1?Q?RYXVS6/rgx/CP2SU/WicqHAN28Pkpnyr/ONlJTA5IEP96VnMNveNIiq8nm?=
 =?iso-8859-1?Q?m2XLxbmVbXL9iNr6iEWSEUO27TFSWyTE2MyBGkOAa0S1TG2A7hqnlKPcuV?=
 =?iso-8859-1?Q?tWu3eBGzyaiiiFonmlQXIUmb49nIC7GmzY8dTu/lX9IMDwK+2Y9xbXYu9i?=
 =?iso-8859-1?Q?nJbsZTWLaF57gU7sMFvuiXzjfYfz309poCsYsuCiMdqovC577YPMy6Ip89?=
 =?iso-8859-1?Q?AaGqc9qqXR+dMP3GCTYGUTKQzj/gVcaJQGVj6Kj9Eq0hgC8wtn8cTqYSfT?=
 =?iso-8859-1?Q?GAC1oUzdcG8mBCp8nfKQzcQSyhVHnnd2i3KXwjp+UcHCL8s5KQiqkfh+UC?=
 =?iso-8859-1?Q?Na2rXQZXXxHt22GghQ6ao+zDVQvp5DypUqa2otbCsuRVxy3kwNf3K9gKF8?=
 =?iso-8859-1?Q?AXu6motahpTFMHcHLSWTwbUyYqn6XlR4I3mxJMTth9ml1NgbE/MZt3EAta?=
 =?iso-8859-1?Q?8VpkuZzwpWdiNyG4NitmF4muMIyZ2UsA3WvaYrYMc1b9OrRIkj8KSqgykz?=
 =?iso-8859-1?Q?LW/MFbHXFeiA5p7Xeac06ba/cmxiBedaPuek/c2t6w6fo9ekcG0lQodNPO?=
 =?iso-8859-1?Q?MST83xzGvGfgAxoPTQemP7eSJFcr8sxnw8EPUEt66YtVc6PIkYRdS9oJR4?=
 =?iso-8859-1?Q?6S3kkNiOV6EKzQqcSJE3b0G6cWV9cRYxQyI8bZxvgHCXH3so2XTJI7Ozma?=
 =?iso-8859-1?Q?JMIRK3A7ZqxHjV3DtzkJpLjW96hEd/hoUizQebSM9zZTFEUdWX0pIc0/ar?=
 =?iso-8859-1?Q?9wZzrTSHv/blwR4sS0nIsYWYeRrfbDlP/HDOfUCLNNeHo9qa0J3d879uOP?=
 =?iso-8859-1?Q?Y2oAnpciqC4K1bqO76/dNvmGTiyC+MddEbfk8zMaiGYUAxaUdT9J+fOBkZ?=
 =?iso-8859-1?Q?pd90rg8isfyMqjBYAq6IMPT58I0ynNPXOa5jaTTQdFa0Y4EaDfffC7QA4U?=
 =?iso-8859-1?Q?JCgoBbdwxAaRC6IYcQHAWLIC6ITJrYCD4czo0PA2buyfsDqUc1dM3M9KsO?=
 =?iso-8859-1?Q?rbgKK0mZrRd2tkoknl/Ca54Z+R1SRzxfs/SOa7nfYeWyTOi4kD9aIM2Vfv?=
 =?iso-8859-1?Q?WKt5idqJLoTLlKnhwa0DeOkjIRbWOP+LiwrKgxywc9A+LNs1kLRUHAbLxt?=
 =?iso-8859-1?Q?LqY4+yauhFpqrFOVw4SyAGllN10/yskfgAGSdh+ttIkbUXF2SQuEDlHhNE?=
 =?iso-8859-1?Q?gQ2/TZgioW42faXAJeprqFIVLNEopIS3Zric+4vRZphhzwlhVH5R1OZidl?=
 =?iso-8859-1?Q?Ph1/HzWcfFLBzzKsdypxr2UjIiqhxO2KVQ4HJMprgQ16WHbFfY1ho/IOfH?=
 =?iso-8859-1?Q?AvtXgXbR5A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563c7c77-fb34-4557-3be4-08de63c6663f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:30.2964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vrv+nG+EcRRp9hnknRuDNmPRPfvMTCaKfOLuii8SEMWoZ2Ld3ZTzzET7Yois5XtAN4aQb2DjvBmvGuGTiKEexL3V77qtBWnZkFbPW3w6UU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

Connect the ADC device to AST1700 model.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 ++=0A=
 hw/arm/aspeed_ast1700.c         | 14 ++++++++++++++=0A=
 hw/arm/aspeed_ast27x0.c         |  5 +++++=0A=
 3 files changed, 21 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index 89562eb64f..441655cee7 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -9,6 +9,7 @@=0A=
 #define ASPEED_AST1700_H=0A=
 =0A=
 #include "hw/core/sysbus.h"=0A=
+#include "hw/adc/aspeed_adc.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
 #include "hw/char/serial-mm.h"=0A=
@@ -28,6 +29,7 @@ struct AspeedAST1700SoCState {=0A=
     SerialMM uart;=0A=
     MemoryRegion sram;=0A=
     AspeedSMCState spi;=0A=
+    AspeedADCState adc;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index 97990688f8..17577ebb5a 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -19,6 +19,7 @@=0A=
 enum {=0A=
     ASPEED_AST1700_DEV_SPI0,=0A=
     ASPEED_AST1700_DEV_SRAM,=0A=
+    ASPEED_AST1700_DEV_ADC,=0A=
     ASPEED_AST1700_DEV_UART12,=0A=
     ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
     ASPEED_AST1700_DEV_SPI0_MEM,=0A=
@@ -27,6 +28,7 @@ enum {=0A=
 static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_SPI0]      =3D  0x00030000,=0A=
     [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,=0A=
+    [ASPEED_AST1700_DEV_ADC]       =3D  0x00C00000,=0A=
     [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,=0A=
     [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
     [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,=0A=
@@ -81,6 +83,14 @@ static void aspeed_ast1700_realize(DeviceState *dev, Err=
or **errp)=0A=
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0_M=
EM],=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), 1)=
);=0A=
 =0A=
+    /* ADC */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_ADC],=
=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->adc), 0)=
);=0A=
+=0A=
     /* LTPI controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {=0A=
         return;=0A=
@@ -102,6 +112,10 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
     object_initialize_child(obj, "ioexp-spi", &s->spi,=0A=
                             "aspeed.spi0-ast2700");=0A=
 =0A=
+    /* ADC */=0A=
+    object_initialize_child(obj, "ioexp-adc", &s->adc,=0A=
+                            "aspeed.adc-ast2700");=0A=
+=0A=
     /* LTPI controller */=0A=
     object_initialize_child(obj, "ltpi-ctrl",=0A=
                             &s->ltpi, TYPE_ASPEED_LTPI);=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 2fc50af8b4..5086d4c51e 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -1046,6 +1046,11 @@ static void aspeed_soc_ast2700_realize(DeviceState *=
dev, Error **errp)=0A=
             sysbus_connect_irq(SYS_BUS_DEVICE(&a->intcioexp[i]), j,=0A=
                                irq);=0A=
         }=0A=
+=0A=
+        /* ADC */=0A=
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].adc), 0,=0A=
+                           aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_ADC));=
=0A=
+=0A=
     }=0A=
 =0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
-- =0A=
2.43.0=0A=

