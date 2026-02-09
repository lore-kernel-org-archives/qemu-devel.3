Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F02E78D70
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNOE-0004l1-4o; Mon, 09 Feb 2026 04:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOC-0004k3-0u; Mon, 09 Feb 2026 04:17:04 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNO9-0007K1-C5; Mon, 09 Feb 2026 04:17:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLOC3Ow2NHCOgySpD+NtxN+1m2fZ9o1BiOhCS2qeP7IAtLnB+vxIUR4B64IBHiN9t/Vn8OkpI8KoasmjJGb8hXbSyrh8pBPfNQRjjKaZwtIdDZS9weqyvoGsq/SrlJPudTQEmzzvWp8RYMfAn1DG7QbeGTN1KsSg0Bi/jbZilcgzeGlrLEtdWe21hzYcucaaAzz9cqZ+sw958SjGrrxuf/OLDy5wsTeRr5S/hvW3ObunuhA/aVvfkmuh5KCZLw8HJDzA/AeSaDm148C3eXk5FEkWZPTIb3oPP4b6jg80zyEgASRFGSW7sTWAXIP+p6ZwYbnhNBDMGJ5qrXfatKiKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQoG8f0sOOM0hYKZvrpSc0WgPLc0gA5RiGejOkrraIo=;
 b=mM6oJ0z9rSWP9L2OLaCmG4HEZBpT4omfqtwhkJsf01Pih5tu6epyRdIb86jM5KFgavJ1joH2pZSkMe1cqnjDDZx9wPSWZQQHzUGb6it9tMEuyitE4E5OhOlLkAkwnpsu/WHEOy1iP/dcEsHjYQPS4TJ2pMe9h2l91oPLSgG1OK8frM9OMFm0DabAYBMFzjdjOLaNR8SRYuDpumyfWSy0FAct93qZAD6aK4q5rOUCmKtYQ5DYJQYLpp1J0zP+s3m4xqaFa1rt/cXKImboijpMx4XYS86JOTinYHJOt15yEhEkU9n/pjCDNAR6WQVrNXd0201OezQOBcSQwbULzfGN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQoG8f0sOOM0hYKZvrpSc0WgPLc0gA5RiGejOkrraIo=;
 b=njvTKyTt+Cz8UmoSmeO4vED3ykz2D/FLsqNQFVJhrZT+3mPxNzSnZGSiRDp3yWlqlf6S9isxzqKfeX9KqbI2eWSE0Of+8o8IuwlgrfZB3IiV1ex31GqQ329flqOKn5HOLpcyNagQcGH4+eqm0TKSCA8oBZ+smSTncIZ3T4afhzpBeJO1o8Y1UyzTS16u4daxh29PfnMJBBT52FM3oXyoRK3AUJ7bi6p/7CnXMvw8GKxzyxPBYa2OxqblnM0FAGqKoOevRmysYjONoaNjjfhVnRIMIscC+ZqlRmzQgX3aGffqcOgaQjklVO+pF07GZD8qSnlfc26R2lljmRbdprr+hw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7031.apcprd06.prod.outlook.com (2603:1096:990:6f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:52 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:50 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>, Stephen Longfield <slongfield@google.com>
Subject: [PATCH v4 13/20] hw/i3c/dw-i3c: Add IBI handling
Thread-Topic: [PATCH v4 13/20] hw/i3c/dw-i3c: Add IBI handling
Thread-Index: AQHcmaTSpn5Z96hDokaGPGltW2mU5g==
Date: Mon, 9 Feb 2026 09:16:49 +0000
Message-ID: <20260209091629.823457-14-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: ddf4ce30-a043-408c-0971-08de67bbf52d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hw2qCYdOZyxBoSC9L34q1fBHTuMjuj+9DcVN2NtxHI5vL3oAjQpTi75DDe?=
 =?iso-8859-1?Q?SqUNV8xK841NdY1F8z2tGqjYo/dYjvNo6CWAzJ82O+KYRosc03GmObWnpy?=
 =?iso-8859-1?Q?xagCc4sSfAxbn4LBpaem7eeWBQWGUWNkANO/KLRLxpzHtjWZbTQAac6xA7?=
 =?iso-8859-1?Q?cv0vl0mxVxLCAIw7FOo/HYfC4gBFNETYeVOiqrWLKhVK3FwKqt2U6n0BjW?=
 =?iso-8859-1?Q?h5VOSKtXSTuBG2ySGGOCIPnjUsFvoptSTogdIx3FwRZjRS92rxn5bZUPEg?=
 =?iso-8859-1?Q?t8z1Wx1QKeRszMjw1smFEavSL0Yg7dN3A/hRYxsfHqD+UjTRW35St5tOkj?=
 =?iso-8859-1?Q?QDfZ6j61bWaIgtH4qgy6d08FzxR72OfnSKcpGgbdbDVhMJ+Iro/gi5jWyO?=
 =?iso-8859-1?Q?YxmSUhDlCj4MJABrIygntL3PKOwIpbuX1DjP9r93wTlrDGV+CbWFU1HFEh?=
 =?iso-8859-1?Q?B2bqCP+A/NLWIYE4PcP+nQpoCvQB0RqfuVR+3/alFhhF4R1nAynjF+tJK9?=
 =?iso-8859-1?Q?WBwatpn3ECjc2d95EHKpdcJ1y2HFT0E+TiOMJnEYv/jzQszo3bDyRUwIOr?=
 =?iso-8859-1?Q?yReKS5Ih8gw7Bf9vf8oPi6a8S6Ie+pG+G4P1G53fGFfo16UTywhmGJiqac?=
 =?iso-8859-1?Q?ticwUQmJO9vAWRvJvKul8DF9KkU1IAqu7hsQS7nU8gg7LkuSv7n4rv1RDH?=
 =?iso-8859-1?Q?sLp8jsBZKRGRJpixQHgPDp8iC2RewbUDGlbrrUBT2g118qcG9FwFFaxHbU?=
 =?iso-8859-1?Q?Ug1tYMMVu1l1YGabJk9HYU2+N3qKIFUqZZoVqq3AY3JezyB5XvTr9YP0Vf?=
 =?iso-8859-1?Q?oY3LADvtn/Ta8SgmFhg3JOddYpy9/ngUQnFFbh7xv0e63QW0A7KbRREarE?=
 =?iso-8859-1?Q?Y9CTduS5TsVShT7FHNvg1uMplXD99pSqg0BM3gAYVEDkX9aFC3MW5q1i7i?=
 =?iso-8859-1?Q?0yvTkodBREw+PRqM2RIMiK6pBzfXgqxoMrspdHamK9SaV4Bc4y5lAr+4UQ?=
 =?iso-8859-1?Q?cO1LsKvAz1TsE8KTWkkQz7AMjcQSsrofOFAbeFz6EkMEHkz7/o6xd2f8e7?=
 =?iso-8859-1?Q?OX191Y45GPmY1plTXwJTweebKQEDd1F3RWQHj1x9iMqmGXZhpbfKoPhWgJ?=
 =?iso-8859-1?Q?LYQ9nHO1shJ+4nsFKCLLZ9pfuyQP5Gdw7YueyxLo5AUis12E7YBwKtVSlg?=
 =?iso-8859-1?Q?pKREZ8hjLKUgx3tCZYUMx9kbnMHh2/CdIoU9daSjCV6rXlbvyr+nFoHx2M?=
 =?iso-8859-1?Q?LKnoHMNedvJC63bqtNEx6Exazbu+weINCzT+N108R21JO5lMvMQ+HpeAmp?=
 =?iso-8859-1?Q?v6m8ypmNg3NlrfbRtvbFk3wWRl2AvyaR5BIuFC0+g9LJIwl6WqCpzXaeAu?=
 =?iso-8859-1?Q?mM20xjBsGwjNF6nK5465K8xcdkSbRY76z/X1r6NK8rSq/f/8UkMo2uQzOa?=
 =?iso-8859-1?Q?mNY5sSEbgYO6YxRnXFn3aMQhGtb/cYAW5VtTmZDrDhsEg4Pvk2YG+krt0C?=
 =?iso-8859-1?Q?vfotyv6pXw/cPiPCJR80xhUU5jF5EQBLJquPn+QaOJYxui0o/eIyUvQsH0?=
 =?iso-8859-1?Q?XWcnvWEwYdaTnOeI4p9gtMxsBy7Ek3mDgJ7zzbW4tSqRRMQrI//gedU7S9?=
 =?iso-8859-1?Q?LxbsomYAApMGpn/bxxoS5imRbJtqCiuc6zP7yh09arLlfugxkn/UOi8833?=
 =?iso-8859-1?Q?hiui1QZjNjcL9hqkUzPzDd/BQ1/wPwlsBNLi540W?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DEdSpmVDxTmDk6N+95LLH7PCmTPEzwJZqgCCVIcLrYiyL9Pr8edwdNeps/?=
 =?iso-8859-1?Q?V9DTUFm057e2r6+YAlWcA5JIJQPzh/JL0KbuAvtemuGJIL7Z4v9hQgNh2a?=
 =?iso-8859-1?Q?sgkpn0/ucDC7RmIE1WejPmvlFmbDoje362jKMaYmiTVzszFtay9KYCXtaZ?=
 =?iso-8859-1?Q?t9vv2PIe/J579+OMHsflLgoPUwsw1R3KEf4IYh7YMAqH97WX3xnEjBWWqf?=
 =?iso-8859-1?Q?Lvmann2/byPh6vGDumggoAerbV9doA2HaTH3gsLVYH9DUF58NHZmlm2FyG?=
 =?iso-8859-1?Q?vcHLZVBXQhwmna7esxP2D3VzpKsmkv/dqxM/zbQ+rcwhWHO3MAfb82wDGi?=
 =?iso-8859-1?Q?sGTBVpRM7bHy2ShJI75AmhfDgzDqOMkJFF02CmVT2UokWnUZm/7zQDrFQL?=
 =?iso-8859-1?Q?v65I3z4oNbhyehalTySDPX3ZuNZtv/76qqzp12vwJALFDhDfPdimJPXyYa?=
 =?iso-8859-1?Q?y5S59BGrfffyH8SxcWeaw2dy7TZC/ZowjwojJZ3qJAKFI5xoUv5UoenPxD?=
 =?iso-8859-1?Q?DC2gA6wakk+G6HihSQZaMmw6AbLlaiu7pMBcQR0UnIga0uQ+pvgq1lWUyi?=
 =?iso-8859-1?Q?3jtDdvxnBaifR6nFQJ+UO3/I6fo6XgWnAlFj59A2zHKwcsUZjkpcoR09J4?=
 =?iso-8859-1?Q?P6wNqCeVVLmvY1EGOveJ9ic9uSkHgbAz+6sUZclECsMEcUYaaQxnG+5+WX?=
 =?iso-8859-1?Q?+jx2ZL6rxRe+XjEPuNgL9zhyxY+OyOCDWjxayy7rLXogh8h9hn1glj6X3D?=
 =?iso-8859-1?Q?JCPjErLnq0Q3E7eqH4C8K0VZ8A7dJ9JS6AB9CYcuU9hRDG5YLq0OOPsHtV?=
 =?iso-8859-1?Q?AiMYNDU0NESY4BNA0Gmo0jSkXnbIdSNGlgru2so16Q5uYKJmtfT2CXnRf0?=
 =?iso-8859-1?Q?kALqsEosrkKuwqnitIvhS9PGSUkjxtVESWBZIt2V6ch4UCgWtmxkSCNVGi?=
 =?iso-8859-1?Q?/0p/GzL1uK/lESymAJDI1g9Ff81gHs5CSvmqtH/NCXgL55no1guaAL7eS5?=
 =?iso-8859-1?Q?vra9dxIM9p2FZPaq5ssBaCMuTmQMVfZ0GYl9Y7wyqFH2KqgYKZzLLgpH3U?=
 =?iso-8859-1?Q?gjm0b2R7wkvTYtOxvoP09vLs5Esw3RDgFZcppbM9MyEPQOC0o0Ucgsa5Jw?=
 =?iso-8859-1?Q?PfS7dArabDo2G5ZWnvM9GB+GEvtI6fOoqfMJ/4n84xmGgZpQ51giXbrqxm?=
 =?iso-8859-1?Q?g59T4KOFS5PSfXk57ibGVYGGRcYJbM+y+V82MjLi5SQaikw/IuQW66WYaW?=
 =?iso-8859-1?Q?Zu4ID81YV7CVtqHKOLk2z1cFJoq7W7Pr12xpCXxIK1dMJR+ebKZtgkbP+h?=
 =?iso-8859-1?Q?EQ1Gs1urqT1tk2i53ao+5W2BxMbXkdDaH1mNzD262c0us8KGe8mN6S+ICF?=
 =?iso-8859-1?Q?5cWbRdY9nt3iOyp+u9ENLtlnsCewbMMAF+AJe8Dmh6FHDG5JNX8qJVTDBc?=
 =?iso-8859-1?Q?oblNO6/5T5LlMUAZHHUbBksCH9bKDZAE+Abyl6KxnSAbYgJr4yLtOLQOZv?=
 =?iso-8859-1?Q?rVHeiE9hz7GLBRXTtrFhu+cPxMyxRfTa6g10P4X5S1Iw+R1CNkRW1B5851?=
 =?iso-8859-1?Q?mWolq0moKxlO0G0Wx96JUO0IUGi6FNYbXrc75/s+XLONTZFkJpbqEFsK18?=
 =?iso-8859-1?Q?/DkI6CHRXp4M1bFsObOkyfhMsNFtwl8bkdhG98z5CXNH5xUWu+tAIVLCsJ?=
 =?iso-8859-1?Q?ycSXCuG+wbDlU0ZcZa4jxhesBKdpWmMBW0kzuojEUF5WJULZumAwWNc6gN?=
 =?iso-8859-1?Q?D/ffPdrn0OaWb6Ijx52GGmWPFO+jc0cOZ7gLtXeglGaD7KosxO4pOYf6ee?=
 =?iso-8859-1?Q?RmHuNZaoXg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf4ce30-a043-408c-0971-08de67bbf52d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:49.9625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4uQtpY1edNXyAXM72cmHMXMV+j82JOwzoDa6Z6gDnUqQ2bCp7dAgF6jxxuYVEXZdZ1VCzQ30Ef5JWnHpTGVpAOCFVjyuiHUNNSziwfIVCbg=
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

Adds handling for different IBI events that the controller can receive.=0A=
This includes:=0A=
- Handling a hot-join from a target=0A=
- Handling a secondary controller on the bus requesting to be the=0A=
  primary bus controller=0A=
- Handling an interrupt request from a target.=0A=
=0A=
When receiving an IBI, the controller sets an interrupt to notify=0A=
software about what happened.=0A=
When the IBI is finished being serviced, the controller pushes the=0A=
result of the IBI and any data received from the target into the IBI=0A=
queue.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Stephen Longfield <slongfield@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/dw-i3c.h |  27 ++++=0A=
 hw/i3c/dw-i3c.c         | 317 ++++++++++++++++++++++++++++++++++++++++=0A=
 hw/i3c/trace-events     |   2 +=0A=
 3 files changed, 346 insertions(+)=0A=
=0A=
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h=0A=
index 4b592552b4..93a3ba784c 100644=0A=
--- a/include/hw/i3c/dw-i3c.h=0A=
+++ b/include/hw/i3c/dw-i3c.h=0A=
@@ -141,6 +141,28 @@ typedef union DWI3CCmdQueueData {=0A=
     DWI3CAddrAssignCmd addr_assign_cmd;=0A=
 } DWI3CCmdQueueData;=0A=
 =0A=
+/*=0A=
+ * When we receive an IBI with data, we need to store it temporarily until=
=0A=
+ * the target is finished sending data. Then we can set the IBI queue stat=
us=0A=
+ * appropriately.=0A=
+ */=0A=
+typedef struct DWI3CIBIData {=0A=
+    /* Do we notify the user that an IBI was NACKed? */=0A=
+    bool notify_ibi_nack;=0A=
+    /* Intermediate storage of IBI_QUEUE_STATUS. */=0A=
+    uint32_t ibi_queue_status;=0A=
+    /* Temporary buffer to store IBI data from the target. */=0A=
+    Fifo8 ibi_intermediate_queue;=0A=
+    /* The address we should send a CCC_DISEC to. */=0A=
+    uint8_t disec_addr;=0A=
+    /* The byte we should send along with the CCC_DISEC. */=0A=
+    uint8_t disec_byte;=0A=
+    /* Should we send a direct DISEC CCC? (As opposed to global). */=0A=
+    bool send_direct_disec;=0A=
+    /* Was this IBI NACKed? */=0A=
+    bool ibi_nacked;=0A=
+} DWI3CIBIData;=0A=
+=0A=
 typedef struct DWI3C {=0A=
     /* <private> */=0A=
     SysBusDevice parent;=0A=
@@ -154,11 +176,16 @@ typedef struct DWI3C {=0A=
     Fifo32 resp_queue;=0A=
     Fifo32 tx_queue;=0A=
     Fifo32 rx_queue;=0A=
+    Fifo32 ibi_queue;=0A=
+=0A=
+    /* Temporary storage for IBI data. */=0A=
+    DWI3CIBIData ibi_data;=0A=
 =0A=
     struct {=0A=
         uint8_t id;=0A=
         uint8_t cmd_resp_queue_capacity_bytes;=0A=
         uint16_t tx_rx_queue_capacity_bytes;=0A=
+        uint8_t ibi_queue_capacity_bytes;=0A=
         uint8_t num_addressable_devices;=0A=
         uint16_t dev_addr_table_pointer;=0A=
         uint16_t dev_addr_table_depth;=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index dd10230da8..9a0460cf31 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -19,6 +19,14 @@=0A=
 #include "trace.h"=0A=
 #include "hw/core/irq.h"=0A=
 =0A=
+/*=0A=
+ * Disable event command values. sent along with a DISEC CCC to disable ce=
rtain=0A=
+ * events on targets.=0A=
+ */=0A=
+#define DISEC_HJ 0x08=0A=
+#define DISEC_CR 0x02=0A=
+#define DISEC_INT 0x01=0A=
+=0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
     FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
     FIELD(DEVICE_CTRL, I2C_SLAVE_PRESENT,         7, 1)=0A=
@@ -356,6 +364,23 @@ static inline bool dw_i3c_can_transmit(DWI3C *s)=0A=
            !ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_RESUME);=0A=
 }=0A=
 =0A=
+static inline uint8_t dw_i3c_ibi_slice_size(DWI3C *s)=0A=
+{=0A=
+    uint8_t ibi_slice_size =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=
=0A=
+                                              IBI_DATA_THLD);=0A=
+    /* The minimum supported slice size is 4 bytes. */=0A=
+    if (ibi_slice_size =3D=3D 0) {=0A=
+        ibi_slice_size =3D 1;=0A=
+    }=0A=
+    ibi_slice_size *=3D sizeof(uint32_t);=0A=
+    /* maximum supported size is 63 bytes. */=0A=
+    if (ibi_slice_size >=3D 64) {=0A=
+        ibi_slice_size =3D 63;=0A=
+    }=0A=
+=0A=
+    return ibi_slice_size;=0A=
+}=0A=
+=0A=
 static inline uint8_t dw_i3c_fifo_threshold_from_reg(uint8_t regval)=0A=
 {=0A=
     return regval =3D regval ? (2 << regval) : 1;=0A=
@@ -509,6 +534,266 @@ static uint8_t dw_i3c_target_addr(DWI3C *s, uint16_t =
offset)=0A=
                       DEV_DYNAMIC_ADDR);=0A=
 }=0A=
 =0A=
+static int dw_i3c_addr_table_index_from_addr(DWI3C *s, uint8_t addr)=0A=
+{=0A=
+    uint8_t table_size =3D ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POI=
NTER,=0A=
+                                          DEPTH);=0A=
+    for (uint8_t i =3D 0; i < table_size; i++) {=0A=
+        if (dw_i3c_target_addr(s, i) =3D=3D addr) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static void dw_i3c_send_disec(DWI3C *s)=0A=
+{=0A=
+    uint8_t ccc =3D I3C_CCC_DISEC;=0A=
+    if (s->ibi_data.send_direct_disec) {=0A=
+        ccc =3D I3C_CCCD_DISEC;=0A=
+    }=0A=
+=0A=
+    dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=3D*/false,=0A=
+                                 /*is_i2c=3D*/false);=0A=
+    dw_i3c_send_byte(s, ccc, /*is_i2c=3D*/false);=0A=
+    if (s->ibi_data.send_direct_disec) {=0A=
+        dw_i3c_send_start(s, s->ibi_data.disec_addr,=0A=
+                                     /*is_recv=3D*/false, /*is_i2c=3D*/fal=
se);=0A=
+    }=0A=
+    dw_i3c_send_byte(s, s->ibi_data.disec_byte, /*is_i2c=3D*/false);=0A=
+}=0A=
+=0A=
+static int dw_i3c_handle_hj(DWI3C *s)=0A=
+{=0A=
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_HOT_JOIN=
)) {=0A=
+        s->ibi_data.notify_ibi_nack =3D true;=0A=
+    }=0A=
+=0A=
+    bool nack_and_disable =3D ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL,=0A=
+                                             HOT_JOIN_ACK_NACK_CTRL);=0A=
+    if (nack_and_disable) {=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                                  IBI_QUEUE_STATUS,=0A=
+                                                  IBI_STATUS, 1);=0A=
+        s->ibi_data.ibi_nacked =3D true;=0A=
+        s->ibi_data.disec_byte =3D DISEC_HJ;=0A=
+        return -1;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int dw_i3c_handle_ctlr_req(DWI3C *s, uint8_t addr)=0A=
+{=0A=
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_MASTER_R=
EQ)) {=0A=
+        s->ibi_data.notify_ibi_nack =3D true;=0A=
+    }=0A=
+=0A=
+    int table_offset =3D dw_i3c_addr_table_index_from_addr(s, addr);=0A=
+    /* Doesn't exist in the table, NACK it, don't DISEC. */=0A=
+    if (table_offset < 0) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
+    table_offset +=3D (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER=
,=0A=
+                                      ADDR) / sizeof(uint32_t));=0A=
+    if (FIELD_EX32(s->regs[table_offset], DEVICE_ADDR_TABLE_LOC1, MR_REJEC=
T)) {=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                                  IBI_QUEUE_STATUS,=0A=
+                                                  IBI_STATUS, 1);=0A=
+        s->ibi_data.ibi_nacked =3D true;=0A=
+        s->ibi_data.disec_addr =3D addr;=0A=
+        /* Tell the requester to disable controller role requests. */=0A=
+        s->ibi_data.disec_byte =3D DISEC_CR;=0A=
+        s->ibi_data.send_direct_disec =3D true;=0A=
+        return -1;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int dw_i3c_handle_targ_irq(DWI3C *s, uint8_t addr)=0A=
+{=0A=
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_SLAVE_IR=
Q)) {=0A=
+        s->ibi_data.notify_ibi_nack =3D true;=0A=
+    }=0A=
+=0A=
+    int table_offset =3D dw_i3c_addr_table_index_from_addr(s, addr);=0A=
+    /* Doesn't exist in the table, NACK it, don't DISEC. */=0A=
+    if (table_offset < 0) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
+    table_offset +=3D (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER=
,=0A=
+                                      ADDR) / sizeof(uint32_t));=0A=
+    if (FIELD_EX32(s->regs[table_offset], DEVICE_ADDR_TABLE_LOC1, SIR_REJE=
CT)) {=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                                  IBI_QUEUE_STATUS,=0A=
+                                                  IBI_STATUS, 1);=0A=
+        s->ibi_data.ibi_nacked =3D true;=0A=
+        s->ibi_data.disec_addr =3D addr;=0A=
+        /* Tell the requester to disable interrupts. */=0A=
+        s->ibi_data.disec_byte =3D DISEC_INT;=0A=
+        s->ibi_data.send_direct_disec =3D true;=0A=
+        return -1;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int dw_i3c_ibi_handle(I3CBus *bus, uint8_t addr, bool is_recv)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(bus->qbus.parent);=0A=
+=0A=
+    trace_dw_i3c_ibi_handle(s->cfg.id, addr, is_recv);=0A=
+    s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_stat=
us,=0A=
+                                              IBI_QUEUE_STATUS, IBI_ID,=0A=
+                                              (addr << 1) | is_recv);=0A=
+    /* Is this a hot join request? */=0A=
+    if (addr =3D=3D I3C_HJ_ADDR) {=0A=
+        return dw_i3c_handle_hj(s);=0A=
+    }=0A=
+    /* Is secondary controller requesting access? */=0A=
+    if (!is_recv) {=0A=
+        return dw_i3c_handle_ctlr_req(s, addr);=0A=
+    }=0A=
+    /* Is this a target IRQ? */=0A=
+    if (is_recv) {=0A=
+        return dw_i3c_handle_targ_irq(s, addr);=0A=
+    }=0A=
+=0A=
+    /* At this point the IBI should have been ACKed or NACKed. */=0A=
+    g_assert_not_reached();=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static int dw_i3c_ibi_recv(I3CBus *bus, uint8_t data)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(bus->qbus.parent);=0A=
+    if (fifo8_is_full(&s->ibi_data.ibi_intermediate_queue)) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    fifo8_push(&s->ibi_data.ibi_intermediate_queue, data);=0A=
+    trace_dw_i3c_ibi_recv(s->cfg.id, data);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static void dw_i3c_ibi_queue_push(DWI3C *s)=0A=
+{=0A=
+    /* Stored value is in 32-bit chunks, convert it to byte chunks. */=0A=
+    uint8_t ibi_slice_size =3D dw_i3c_ibi_slice_size(s);=0A=
+    uint8_t num_slices =3D (fifo8_num_used(&s->ibi_data.ibi_intermediate_q=
ueue) /=0A=
+                         ibi_slice_size) +=0A=
+                         ((fifo8_num_used(&s->ibi_data.ibi_intermediate_qu=
eue) %=0A=
+                         ibi_slice_size) ? 1 : 0);=0A=
+    uint8_t ibi_status_count =3D num_slices;=0A=
+    union {=0A=
+        uint8_t b[sizeof(uint32_t)];=0A=
+        uint32_t val32;=0A=
+    } ibi_data =3D {=0A=
+        .val32 =3D 0=0A=
+    };=0A=
+=0A=
+    /* The report was suppressed, do nothing. */=0A=
+    if (s->ibi_data.ibi_nacked && !s->ibi_data.notify_ibi_nack) {=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_IDLE);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* If we don't have any slices to push, just push the status. */=0A=
+    if (num_slices =3D=3D 0) {=0A=
+        s->ibi_data.ibi_queue_status =3D=0A=
+             FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=0A=
+                        LAST_STATUS, 1);=0A=
+        fifo32_push(&s->ibi_queue, s->ibi_data.ibi_queue_status);=0A=
+        ibi_status_count =3D 1;=0A=
+    }=0A=
+=0A=
+    for (uint8_t i =3D 0; i < num_slices; i++) {=0A=
+        /* If this is the last slice, set LAST_STATUS. */=0A=
+        if (fifo8_num_used(&s->ibi_data.ibi_intermediate_queue) <=0A=
+            ibi_slice_size) {=0A=
+            s->ibi_data.ibi_queue_status =3D=0A=
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=
=0A=
+                           IBI_DATA_LEN,=0A=
+                           fifo8_num_used(&s->ibi_data.ibi_intermediate_qu=
eue));=0A=
+            s->ibi_data.ibi_queue_status =3D=0A=
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=
=0A=
+                           LAST_STATUS, 1);=0A=
+        } else {=0A=
+            s->ibi_data.ibi_queue_status =3D=0A=
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=
=0A=
+                           IBI_DATA_LEN, ibi_slice_size);=0A=
+        }=0A=
+=0A=
+        /* Push the IBI status header. */=0A=
+        fifo32_push(&s->ibi_queue, s->ibi_data.ibi_queue_status);=0A=
+        /* Move each IBI byte into a 32-bit word and push it into the queu=
e. */=0A=
+        for (uint8_t j =3D 0; j < ibi_slice_size; ++j) {=0A=
+            if (fifo8_is_empty(&s->ibi_data.ibi_intermediate_queue)) {=0A=
+                break;=0A=
+            }=0A=
+=0A=
+            ibi_data.b[j & 3] =3D fifo8_pop(&s->ibi_data.ibi_intermediate_=
queue);=0A=
+            /* We have 32-bits, push it to the IBI FIFO. */=0A=
+            if ((j & 0x03) =3D=3D 0x03) {=0A=
+                fifo32_push(&s->ibi_queue, ibi_data.val32);=0A=
+                ibi_data.val32 =3D 0;=0A=
+            }=0A=
+        }=0A=
+        /* If the data isn't 32-bit aligned, push the leftover bytes. */=
=0A=
+        if (ibi_slice_size & 0x03) {=0A=
+            fifo32_push(&s->ibi_queue, ibi_data.val32);=0A=
+        }=0A=
+=0A=
+        /* Clear out the data length for the next iteration. */=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                         IBI_QUEUE_STATUS, IBI_DATA_LEN, 0=
);=0A=
+    }=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,=0A=
+                     fifo32_num_used(&s->ibi_queue));=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_STATUS_CNT,=0A=
+                     ibi_status_count);=0A=
+    /* Threshold is the register value + 1. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=0A=
+                                         IBI_STATUS_THLD) + 1;=0A=
+    if (fifo32_num_used(&s->ibi_queue) >=3D threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+=0A=
+    /* State update. */=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+}=0A=
+=0A=
+static int dw_i3c_ibi_finish(I3CBus *bus)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(bus->qbus.parent);=0A=
+    bool nack_and_disable_hj =3D ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL,=0A=
+                                                HOT_JOIN_ACK_NACK_CTRL);=
=0A=
+    if (nack_and_disable_hj || s->ibi_data.send_direct_disec) {=0A=
+        dw_i3c_send_disec(s);=0A=
+    }=0A=
+    dw_i3c_ibi_queue_push(s);=0A=
+=0A=
+    /* Clear out the intermediate values. */=0A=
+    s->ibi_data.ibi_queue_status =3D 0;=0A=
+    s->ibi_data.disec_addr =3D 0;=0A=
+    s->ibi_data.disec_byte =3D 0;=0A=
+    s->ibi_data.send_direct_disec =3D false;=0A=
+    s->ibi_data.notify_ibi_nack =3D false;=0A=
+    s->ibi_data.ibi_nacked =3D false;=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_intr_status_r(DWI3C *s)=0A=
 {=0A=
     /* Only return the status whose corresponding EN bits are set. */=0A=
@@ -569,6 +854,25 @@ static uint32_t dw_i3c_pop_rx(DWI3C *s)=0A=
     return val;=0A=
 }=0A=
 =0A=
+static uint32_t dw_i3c_ibi_queue_r(DWI3C *s)=0A=
+{=0A=
+    if (fifo32_is_empty(&s->ibi_queue)) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    uint32_t val =3D fifo32_pop(&s->ibi_queue);=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,=0A=
+                     fifo32_num_used(&s->ibi_queue));=0A=
+    /* Threshold is the register value + 1. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=0A=
+                                         IBI_STATUS_THLD) + 1;=0A=
+    if (fifo32_num_used(&s->ibi_queue) < threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 0);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+    return val;=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_resp_queue_port_r(DWI3C *s)=0A=
 {=0A=
     if (fifo32_is_empty(&s->resp_queue)) {=0A=
@@ -606,6 +910,9 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset=
, unsigned size)=0A=
     case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
+    case R_IBI_QUEUE_DATA:=0A=
+        value =3D dw_i3c_ibi_queue_r(s);=0A=
+        break;=0A=
     case R_INTR_STATUS:=0A=
         value =3D dw_i3c_intr_status_r(s);=0A=
         break;=0A=
@@ -1345,8 +1652,16 @@ static void dw_i3c_realize(DeviceState *dev, Error *=
*errp)=0A=
     fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_bytes);=
=0A=
     fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_bytes);=0A=
     fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_bytes);=0A=
+    fifo32_create(&s->ibi_queue, s->cfg.ibi_queue_capacity_bytes);=0A=
+    /* Arbitrarily large enough to not be an issue. */=0A=
+    fifo8_create(&s->ibi_data.ibi_intermediate_queue,=0A=
+                 s->cfg.ibi_queue_capacity_bytes * 8);=0A=
 =0A=
     s->bus =3D i3c_init_bus(DEVICE(s), name);=0A=
+    I3CBusClass *bc =3D I3C_BUS_GET_CLASS(s->bus);=0A=
+    bc->ibi_handle =3D dw_i3c_ibi_handle;=0A=
+    bc->ibi_recv =3D dw_i3c_ibi_recv;=0A=
+    bc->ibi_finish =3D dw_i3c_ibi_finish;=0A=
 }=0A=
 =0A=
 static const Property dw_i3c_properties[] =3D {=0A=
@@ -1355,6 +1670,8 @@ static const Property dw_i3c_properties[] =3D {=0A=
                       cfg.cmd_resp_queue_capacity_bytes, 0x10),=0A=
     DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,=0A=
                       cfg.tx_rx_queue_capacity_bytes, 0x40),=0A=
+    DEFINE_PROP_UINT8("ibi-queue-capacity-bytes", DWI3C,=0A=
+                      cfg.ibi_queue_capacity_bytes, 0x10),=0A=
     DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,=0A=
                       cfg.num_addressable_devices, 8),=0A=
     DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 044ff06a01..a262fcce39 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -9,6 +9,8 @@ dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t da=
ta) "I3C Dev[%u] read=0A=
 dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%=
u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] send %" PR=
Id32 " bytes to bus"=0A=
 dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv =
%" PRId32 " bytes from bus"=0A=
+dw_i3c_ibi_recv(uint32_t deviceid, uint8_t ibi_byte) "I3C Dev[%u] recv IBI=
 byte 0x%" PRIx8=0A=
+dw_i3c_ibi_handle(uint32_t deviceid, uint8_t addr, bool rnw) "I3C Dev[%u] =
handle IBI from address 0x%" PRIx8 " RnW=3D%d"=0A=
 dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx=
32 " from RX FIFO"=0A=
 dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push=
 0x%" PRIx32 " to response queue"=0A=
 dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PR=
Ix32 " to TX FIFO"=0A=
-- =0A=
2.43.0=0A=

