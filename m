Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C18D172CE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmmj-0007NX-Bh; Mon, 02 Feb 2026 00:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vmmmh-0007M9-7h
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:47:39 -0500
Received: from mail-westeuropeazon11011000.outbound.protection.outlook.com
 ([52.101.70.0] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vmmmc-0004in-AR
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:47:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwDQ1J19lKddR6mOO3coyW6wGBlwJOP6Dqd1ix9/j8sEeuszYGe4+U+YKB5+oFe7QPoQ84yN58Um1nnCDep8ZN5KFKOthXpzN3003uGtvxGASfcw6jl7l8XOTCeD47ZD0rTEpaxj8UyG1y0akh6tipB+LrXvmjy7R//5oji38Nn5MJTDwWkjck0Njw4Suy22iM0x+vroOFL0UYdtaA1BKNp3RHf13n2bGJX35CxMd2HH81T6pleJ2n2nrWwKyMvKRmea+UfoDCPbhMQibxbNjyykuooGQ5L2GJJ95T3ycQolzW5A4hRK6AWq5IR1lDA6h2i5ZufyFOg+Wgt0Kk60+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdL0Bu9DYeGzaIMaiNkY/7sWsFd1EFGU6BC5jgONnyc=;
 b=cBpryRO97R0VvyLN+M5MGyGt39PL5WoPUtWWphlb+vZgdfGFe++UtHNGpZaUfdjbsoUU5VH8+y8hoKdd60UZ/lJSbWvn17KsPw8idx+oKnJv2X0FxEAyBp7TfpIi2NsONbXVznnuceQFjdSOIs65uv12bRGG/buMNgH1Lg2UjCJszeh8Cbnwh/t9HQ3cfnhP4c923OSaaQuAoTus+xyNNX7JF+eiA6Ja+mgL5OrypaqQI7c+t3i7E1j3kkpJqWRmTYfACwITBXT+FA1wVmKU0l1Ai0AXejnzKs6g+EWU1XGs5u5QJSgcIZo4q2UJ1ZHpkoBwczn6nTXtVqfXm8TAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdL0Bu9DYeGzaIMaiNkY/7sWsFd1EFGU6BC5jgONnyc=;
 b=oIeay+bYH1u9EzoNIMygRNmXe/u3fOtFoo/5fFwsT9RUPF1TgTwNdUaS8hkKd6VsOLewsa2k7HtNeH4Q6Rxgomh0I8KQaG3ZLUxkNB1h04Jz7VHgfaJ/638Y7+Oex0Vuf+TjsqxBb+1mk7N9XT3PpTxw1sTE6de0exmLH6sLoX5vppKYwfgWA3ez8D4dE2NSK5JDAeDue98RRaCKzeVk3R/3pp/524OKTWC/ycwFAyKN0m1AA5AGU3zhRV1Glh0fcYSprm4BNR5FzxraVweJnWvD788Gvs0eSgJPYHRvgy/pd7Ha0l0MXt0sM4/cxw32dlq/7X3KAhpwjuarbQW8DQ==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by AM9PR04MB8291.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 05:42:29 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 05:42:29 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv4 01/15] hw/arm: Add the i.MX 8MM EVK(Evaluation
 Kit) board
Thread-Topic: [EXT] Re: [PATCHv4 01/15] hw/arm: Add the i.MX 8MM
 EVK(Evaluation Kit) board
Thread-Index: AQHcZalfx1wWExJ35kiD6NPzwhPS7LVOkXuAgB/0YICAALucYA==
Date: Mon, 2 Feb 2026 05:42:29 +0000
Message-ID: <AM9PR04MB8487606AE04E3506E9418E89879AA@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
 <20251205053819.2021772-2-gaurav.sharma_7@nxp.com>
 <61D6819C-96C4-4C7D-87CF-378F76E85C2A@gmail.com>
 <FF50AF9E-C20E-4FE8-8DDE-96EB634268B4@gmail.com>
In-Reply-To: <FF50AF9E-C20E-4FE8-8DDE-96EB634268B4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|AM9PR04MB8291:EE_
x-ms-office365-filtering-correlation-id: b5612964-277f-4420-4753-08de621dda78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5WO2NuBRwx1B/j7AGUrL7tO9TQ6J6JLjfGRyU+gejly00QN9aRaqqSITybyz?=
 =?us-ascii?Q?SPv/9rjhfnHrlTCJfWrwG6n8GYoqBM0yqfSH8qnd11OyXONczMZKVTf93AjK?=
 =?us-ascii?Q?4jZzmFtBksfayOaz79BYe5sc5YmjvljxRUz9U5ON08UE8KUFj0iqY22U9BVs?=
 =?us-ascii?Q?juQr3KHtzCqMS44fRcxkhkTnO/GbDyzbng674fXMEyrrRyyvleMEy0DUQqmZ?=
 =?us-ascii?Q?j1+uegPtieaBiw4B1zca53Sqgcu+1UepIdug6xHPm5M7i6QhM3Sh68JOg6/x?=
 =?us-ascii?Q?frzwTzh0SrFZXIQwmyrWUTUvd/yPAzS4itsCmFVNJDI0lKSZaNy97tD11ZGE?=
 =?us-ascii?Q?cRBBIKCbQ564juQLTXFrp+ZRSLRDYxkNYPNi6O8WkWecaUi7GIhSEMVUwz21?=
 =?us-ascii?Q?lyqv7ms9merpdhft4BOCBE2kwWaepvTiLcO30dnXOK0PcgTlDMk6Pq3QWaI1?=
 =?us-ascii?Q?Fzw34YezTaBnJ+kJtwnhsDJO5/ekJK8pk04iOaH5xTQvePaTsj8E0dqg/QFu?=
 =?us-ascii?Q?ZvUQauKex9oA46lKXTIWV/hJW640IEJvcBmRdde+UGGEQaAbd6tGaklf0vtB?=
 =?us-ascii?Q?/WsoATtQbW+l2d+09HEcZTDODKB4iK3LD12JGbQLbZBx8BlwhLoMuAQiXcw3?=
 =?us-ascii?Q?eGFjoM7gPf/Xd9zESW3bkmvVGEYi9nICoyAvfPb9LkZ3qlhld5huctaz5994?=
 =?us-ascii?Q?5+fSENWbSdvj213CoGL4yBu7Q33W7cMZ6DnPOI+2EqRz692Az2E10ZOP7wu0?=
 =?us-ascii?Q?IL2UVzSFM1EokhN/WddMGz7SSheJ2dbqHSuQWhUxPFv4BQ8JBUbGcxz8Vayj?=
 =?us-ascii?Q?DHJU8xzPxJXfbZcNXmIc8sBQAgaKfinh1ENI8i1/IrN3jkqc1a4ZaDMlfUzf?=
 =?us-ascii?Q?3b8yfZPLHtbT6AjjWhLoewFGs9jHnXsGcOOS5rfLrN5IjmLmWhhU6bvdlUL5?=
 =?us-ascii?Q?w4IGqteeZofgJAYtVjz9dsz0o50PS5gzbUeM8b/SeG4Qv9AlLHTK3Gf0hQYI?=
 =?us-ascii?Q?DiBsDBU+gn8Ivk0Fdtz6P5+TX9g66zCzHSqIO1aWWAY/+GX129jLDe77piZ8?=
 =?us-ascii?Q?Oh/TbAUf0UfcauZ+aCAqrNF8Ig7msmGvJuGd3VBg5R62jWOYvdRjbKNQ5b42?=
 =?us-ascii?Q?fV/ZFgP410vCvwff9z2uY0Ddm4dMveUr7pd4DycVrEz7GnMlitttbExyrHwx?=
 =?us-ascii?Q?dXFUKT53WYtly5+NyfktuJ128AGBU39zXiDx8ytm25qV/6h9pPjvwKf+28V7?=
 =?us-ascii?Q?eIZpXpwEYrPCntKBmL6moWQ/+aTKrv5eiy9sj6IXUosOG59xMjHhxkMCSU9C?=
 =?us-ascii?Q?7oAdUrI9qdfKL5YDnH0rbHU/BnTG1O2i1+I003FfTWQzFjv7XaEUXULCqmBO?=
 =?us-ascii?Q?9hmBjPmbNC3U6BYNXvSKeGVbRgUiRfDbAM42FQu7w15nL+0dANAUNdROKGm8?=
 =?us-ascii?Q?80DkCgzVAX80Eo9ncPEcTMjjAEzTzXm45yKRLCkTJooaBUbUDyLFt5mrJYa1?=
 =?us-ascii?Q?J6ObnjJHil3OLTsuVpGy6D92wTNxyZtyIp0gql8pCau1sZYtb/1PNNhUcw5a?=
 =?us-ascii?Q?QhO/xduPyQuPJsqMS8cfhYNh597S0e0frFsg8yE/JbpZRnXZXFAMmslZjfO9?=
 =?us-ascii?Q?qmjiDabarh8PununTH2Qtts=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?06UgPtOi1zPoGgbPe4PcUqEn4KMb8S145ItYM6pL/ta+Vf9YHNtrAwxIw1S+?=
 =?us-ascii?Q?XTXO8qmOU763yn+PxQgZ9e4+T+Dh03Q0tQerToJcIh83uEIGAe/GB3sMra94?=
 =?us-ascii?Q?UR4o2KR2dYKOI26dJzlDw4Wkyh1YrRuSr3yhfHP7i+bAEVd7IPv/Y3C4JO90?=
 =?us-ascii?Q?JHui6Husc+b602HFKHhwE4We04hYzpv6hUZ8Y1YJUdlIA6BGpjn11l0Ne+7m?=
 =?us-ascii?Q?mFRJmlh3Dfhvq2qosFSpy+jSw9nXHV7jtEkrHIdivDJG6ojMfzJdibCSFuju?=
 =?us-ascii?Q?3KTONxBcIs22MprK8TzCuM5l2QPrNvmqqHQ0qneicdhTSfkrKTWAKW0DFJJx?=
 =?us-ascii?Q?PvMk5d0qWkRJzDBfKOzcG5RN1n9bM4u3vAH80dJWdSwghqP+IrC6qC9PwYDS?=
 =?us-ascii?Q?V2L4c9nuxlkJ9xZlSiAGm327+8tGHo9yNpcde0PgCPKUPPoFf/eCYLEkDQ/e?=
 =?us-ascii?Q?+h3/I1aI2/i3T1alqW1ie3D3L3AbuXhYMnNJ68iGcdmRGpm61a5fvVyhBnSq?=
 =?us-ascii?Q?dZP1NCrK/RG3ldFAAGsLzfV4DX/oT9ZIZFZvZaGmou5dEHsxJ88WfDg4VJzc?=
 =?us-ascii?Q?wrJgkZ267nUpLaucUcoWdaOtxKHvrwsTiqSO3OMqg/PcOilYJO/7ZySi3jxD?=
 =?us-ascii?Q?LeuH5KfoXbCUrzIf5UIIrtKmuKOlec7ZwMa0zRfad06hI5MA94KJFhVANfX5?=
 =?us-ascii?Q?18+NGdIAVcEgmjGJCRYsJTYAuSKBf9lu4oDyktDvaDnPwEu6VpRdlEntKglp?=
 =?us-ascii?Q?il3JriGra/KaBahmsdhPAAF5t9SbXJ6KJx6v2pfgjs1jULo8x630LtXQ9xs7?=
 =?us-ascii?Q?0KJCs5QQDphHFJc1H+nZwOFnagbzhj8YwaM8qYvY0UM2nO+zAlfYBLN3Htvz?=
 =?us-ascii?Q?ObLIjW4PFrwISbCYBlMWS/vFrsZ8PaaBZZtStgEczFW+mTOjSSu859mgilOd?=
 =?us-ascii?Q?76JzdVQxexDlqYuSRnJLIabmxgWclHQB9Vj8XLHAww1net4XKl+72dk+UhL1?=
 =?us-ascii?Q?0M4+CmIWgpG1ka8bfrx4OOomCq/XahhBDkLPQvu1VWwpi7YXJxOAs6Yo+0bd?=
 =?us-ascii?Q?ho0ZI562I19nKKmaon6LyIQ0zzT11k7ZDVMYelH+VCQjKNsd6ewvluC4Vn8/?=
 =?us-ascii?Q?sZWfkgQYdVRujyFI9bjkLe7GDDwH2UXNcRk7G/MrEmpSB+PQ6f836dA7AVzx?=
 =?us-ascii?Q?+iLzsIGB66kSL2qoXU5NkAz4DHJDXgaGNUPScs1qvsF/6WE0nIljCcxLRWnH?=
 =?us-ascii?Q?2jALHHOCIlB6SrWBl+87OT/U0P4N1KWHbXHEwjUytu/WFdWYdFcxXNzGbsTo?=
 =?us-ascii?Q?bkLVsg1vWoN5T9vkPeateh7KkZW/E1otWt+W3XCqFP6pE24awDpxeKFUXPa6?=
 =?us-ascii?Q?CTrYxbccwT/y+XYn4EnDCWfcsVnHY8GSyA2IkP26Y65Ij/7solPBrkgKApwh?=
 =?us-ascii?Q?6Km3xm8zJ4Bkg74XAbr4cxJBvoxE8iVynKoiduRJCTj0ZnnMFqYiclVwQ0p6?=
 =?us-ascii?Q?4yGkLLPfAZutdCiLwRLzG+XHZpqkadRmrzlpuY3q9ssuJf0BugehSuma75Zb?=
 =?us-ascii?Q?XjG1d2DzpN2elSupeSCir+u7p9xwxBPvWMxy2dyhWk2IGBmAT5wIpxa/3WCA?=
 =?us-ascii?Q?hSPx+iuO85r1hzNfB5M4rgjva3+FFySAd7ZwkBEA8cMHGaR5BbEdD2so4u7a?=
 =?us-ascii?Q?uX+DorQHlsWsJ5qH+ZFURu7uNMD/Pw6eh5h4vcWwgWs8S1AA3cwRo0bGhzdc?=
 =?us-ascii?Q?yTdX/AxxZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5612964-277f-4420-4753-08de621dda78
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 05:42:29.1860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wslMVEyUrKXonVzfwclpeqxPW7FOaSZ/PQj6YZ69y9fPfjIQarWadCegfSLE7CbzCoZ18V5ZMPra9Dm/+Dflg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8291
Received-SPF: pass client-ip=52.101.70.0; envelope-from=gaurav.sharma_7@nxp.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Bernhard,

Sorry for the late response. I was pre-occupied with some critical tasks at=
 work. Lemme have a look and get back to you on the proposed changes. Thank=
s for reviewing!

Regards

> -----Original Message-----
> From: Bernhard Beschow <shentey@gmail.com>
> Sent: 01 February 2026 23:59
> To: qemu-devel@nongnu.org; Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> Subject: [EXT] Re: [PATCHv4 01/15] hw/arm: Add the i.MX 8MM
> EVK(Evaluation Kit) board
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Am 12. Januar 2026 10:29:59 UTC schrieb Bernhard Beschow
> <shentey@gmail.com>:
> >
> >
> >Am 5. Dezember 2025 05:38:05 UTC schrieb Gaurav Sharma
> <gaurav.sharma_7@nxp.com>:
> >>Implemented CPUs, RAM, UARTs and Interrupt Controller Other
> >>peripherals are represented as TYPE_UNIMPLEMENTED_DEVICE Complete
> >>memory map of the SoC is provided.
> >>
> >>Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >>---
> >> MAINTAINERS                    |  10 +
> >> docs/system/arm/imx8mm-evk.rst |  68 ++++++
> >> docs/system/target-arm.rst     |   1 +
> >> hw/arm/Kconfig                 |  12 ++
> >> hw/arm/fsl-imx8mm.c            | 366 +++++++++++++++++++++++++++++++++
> >> hw/arm/imx8mm-evk.c            | 110 ++++++++++
> >> hw/arm/meson.build             |   2 +
> >> include/hw/arm/fsl-imx8mm.h    | 157 ++++++++++++++
> >> 8 files changed, 726 insertions(+)
> >> create mode 100644 docs/system/arm/imx8mm-evk.rst  create mode
> 100644
> >>hw/arm/fsl-imx8mm.c  create mode 100644 hw/arm/imx8mm-evk.c  create
> >>mode 100644 include/hw/arm/fsl-imx8mm.h
> >>
> >>diff --git a/MAINTAINERS b/MAINTAINERS index be6efff80c..41f76c5bd0
> >>100644
> >>--- a/MAINTAINERS
> >>+++ b/MAINTAINERS
> >>@@ -884,6 +884,16 @@ F: hw/pci-host/designware.c
> >> F: include/hw/pci-host/designware.h
> >> F: docs/system/arm/mcimx7d-sabre.rst
> >>
> >>+MCIMX8MM-EVK / iMX8MM
> >>+M: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >>+L: qemu-arm@nongnu.org
> >>+S: Maintained
> >>+F: hw/arm/fsl-imx8mm.c
> >>+F: hw/arm/imx8mm-evk.c
> >>+F: include/hw/arm/fsl-imx8mm.h
> >>+F: docs/system/arm/imx8mm-evk.rst
> >>+F: tests/functional/aarch64/test_imx8mm_evk.py
> >>+
> >> MCIMX8MP-EVK / i.MX8MP
> >> M: Bernhard Beschow <shentey@gmail.com>
> >> L: qemu-arm@nongnu.org
> >>diff --git a/docs/system/arm/imx8mm-evk.rst
> >>b/docs/system/arm/imx8mm-evk.rst new file mode 100644 index
> >>0000000000..408253193c
> >>--- /dev/null
> >>+++ b/docs/system/arm/imx8mm-evk.rst
> >>@@ -0,0 +1,68 @@
> >>+NXP i.MX 8MM Evaluation Kit (``imx8mm-evk``)
> >>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>+
> >>+The ``imx8mm-evk`` machine models the i.MX 8M Mini Evaluation Kit,
> >>+based on an i.MX 8MM SoC.
> >
> >This file is basically the one from imx8mp-evk with s/imx8mp/imx8mm/ .
> Perhaps we could just list both boards in this section there and mention
> somewhere.that all the commands apply to imx8mm in an analogous
> fashion? That way we won't have to update both documents when something
> changes.
> >
> >>+
> >>+Supported devices
> >>+-----------------
> >>+
> >>+The ``imx8mm-evk`` machine implements the following devices:
> >>+
> >>+ * Up to 4 Cortex-A53 cores
> >>+ * Generic Interrupt Controller (GICv3)
> >>+ * 4 UARTs
> >>+
> >>+Boot options
> >>+------------
> >>+
> >>+The ``imx8mm-evk`` machine can start a Linux kernel directly using
> >>+the standard ``-kernel`` functionality.
> >>+
> >>+Direct Linux Kernel Boot
> >>+''''''''''''''''''''''''
> >>+
> >>+Probably the easiest way to get started with a whole Linux system on
> >>+the machine is to generate an image with Buildroot. Version 2024.11.1
> >>+is tested at the time of writing and involves two steps. First run
> >>+the following commands in the toplevel directory of the Buildroot sour=
ce
> tree:
> >>+
> >>+.. code-block:: bash
> >>+
> >>+  $ make freescale_imx8mmevk_defconfig  $ make
> >>+
> >>+Once finished successfully there is an ``output/image`` subfolder.
> >>+Navigate into it and resize the SD card image to a power of two:
> >>+
> >>+.. code-block:: bash
> >>+
> >>+  $ qemu-img resize sdcard.img 256M
> >>+
> >>+Now that everything is prepared the machine can be started as follows:
> >>+
> >>+.. code-block:: bash
> >>+
> >>+  $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 3G \
> >>+      -display none -serial null -serial stdio \
> >>+      -kernel Image \
> >>+      -dtb imx8mm-evk.dtb \
> >>+      -append "root=3D/dev/mmcblk2p2" \
> >>+      -drive file=3Dsdcard.img,if=3Dsd,bus=3D2,format=3Draw,id=3Dmmcbl=
k2
> >>+
> >>+
> >>+KVM Acceleration
> >>+----------------
> >>+
> >>+Be aware of the following limitations:
> >>+
> >>+* The ``imx8mm-evk`` machine is not included under the "virtualization
> use case"
> >>+  of :doc:`QEMU's security policy </system/security>`. This means
> >>+that you
> >>+  should not trust that it can contain malicious guests, whether it
> >>+is run
> >>+  using TCG or KVM. If you don't trust your guests and you're relying
> >>+on QEMU to
> >>+  be the security boundary, you want to choose another machine such as
> ``virt``.
> >>+* Rather than Cortex-A53 CPUs, the same CPU type as the host's will be
> used.
> >>+  This is a limitation of KVM and may not work with guests with a
> >>+tight
> >>+  dependency on Cortex-A53.
> >>+* No EL2 and EL3 exception levels are available which is also a KVM
> limitation.
> >>+  Direct kernel boot should work but running U-Boot, TF-A, etc. won't
> succeed.
> >>diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> >>index a96d1867df..d6a4b5bb00 100644
> >>--- a/docs/system/target-arm.rst
> >>+++ b/docs/system/target-arm.rst
> >>@@ -97,6 +97,7 @@ Board-specific documentation
> >>    arm/mcimx6ul-evk
> >>    arm/mcimx7d-sabre
> >>    arm/imx8mp-evk
> >>+   arm/imx8mm-evk
> >>    arm/orangepi
> >>    arm/raspi
> >>    arm/collie
> >>diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig index
> >>0cdeb60f1f..be38c67a1c 100644
> >>--- a/hw/arm/Kconfig
> >>+++ b/hw/arm/Kconfig
> >>@@ -626,6 +626,18 @@ config FSL_IMX8MP_EVK
> >>     depends on TCG || KVM
> >>     select FSL_IMX8MP
> >>
> >>+config FSL_IMX8MM
> >>+    bool
> >>+    select ARM_GIC
> >>+    select IMX
> >>+
> >>+config FSL_IMX8MM_EVK
> >>+    bool
> >>+    default y
> >>+    depends on AARCH64
> >>+    depends on TCG
> >>+    select FSL_IMX8MM
> >>+
> >> config ARM_SMMUV3
> >>     bool
> >>
> >>diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c new file mode
> >>100644 index 0000000000..fb6a78adba
> >>--- /dev/null
> >>+++ b/hw/arm/fsl-imx8mm.c
> >>@@ -0,0 +1,366 @@
> >>+/*
> >>+ * i.MX 8MM SoC Implementation
> >>+ *
> >>+ * Based on hw/arm/fsl-imx6.c
> >
> >s/imx6/imx8mp/ ?
> >
> >>+ *
> >>+ * Copyright (c) 2025, NXP Semiconductors
> >>+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >>+ *
> >>+ * SPDX-License-Identifier: GPL-2.0-or-later
> >>+ *
> >>+ * iMX8MM Reference Manual -
> >>+
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> >>+
> w.nxp.com%2Fproducts%2Fi.MX8MMINI&data=3D05%7C02%7Cgaurav.sharma_
> 7%40n
> >>+
> xp.com%7C36aebc91c3f74a13c3ce08de61bfbb95%7C686ea1d3bc2b4c6fa92c
> d99c
> >>+
> 5c301635%7C0%7C0%7C639055673312122807%7CUnknown%7CTWFpbGZsb
> 3d8eyJFbX
> >>+
> B0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWF
> pbC
> >>+
> IsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DJEd%2FoFIpj6DZmE%2Fu%2Fo
> 8c%2Bk
> >>+ NME5vS0LZqHo9WT69NS6Q%3D&reserved=3D0 -> Documentation */
> >>+
> >>+#include "qemu/osdep.h"
> >>+#include "system/address-spaces.h"
> >>+#include "hw/arm/bsa.h"
> >>+#include "hw/arm/fsl-imx8mm.h"
> >>+#include "hw/misc/unimp.h"
> >>+#include "hw/boards.h"
> >>+#include "system/kvm.h"
> >>+#include "system/system.h"
> >>+#include "target/arm/cpu.h"
> >>+#include "target/arm/cpu-qom.h"
> >>+#include "target/arm/kvm_arm.h"
> >>+#include "qapi/error.h"
> >>+#include "qobject/qlist.h"
> >>+
> >>+static const struct {
> >>+    hwaddr addr;
> >>+    size_t size;
> >>+    const char *name;
> >>+} fsl_imx8mm_memmap[] =3D {
> >>+    [FSL_IMX8MM_RAM] =3D { FSL_IMX8MM_RAM_START,
> FSL_IMX8MM_RAM_SIZE_MAX, "ram" },
> >>+    [FSL_IMX8MM_DDR_PHY_BROADCAST] =3D { 0x3dc00000, 4 * MiB,
> "ddr_phy_broadcast" },
> >>+    [FSL_IMX8MM_DDR_PERF_MON] =3D { 0x3d800000, 4 * MiB,
> "ddr_perf_mon" },
> >>+    [FSL_IMX8MM_DDR_CTL] =3D { 0x3d400000, 4 * MiB, "ddr_ctl" },
> >>+    [FSL_IMX8MM_DDR_PHY] =3D { 0x3c000000, 16 * MiB, "ddr_phy" },
> >>+    [FSL_IMX8MM_GIC_DIST] =3D { 0x38800000, 512 * KiB, "gic_dist" },
> >>+    [FSL_IMX8MM_GIC_REDIST] =3D { 0x38880000, 512 * KiB, "gic_redist" =
},
> >>+    [FSL_IMX8MM_VPU] =3D { 0x38340000, 2 * MiB, "vpu" },
> >>+    [FSL_IMX8MM_VPU_BLK_CTRL] =3D { 0x38330000, 2 * MiB,
> "vpu_blk_ctrl" },
> >>+    [FSL_IMX8MM_VPU_G2_DECODER] =3D { 0x38310000, 1 * MiB,
> "vpu_g2_decoder" },
> >>+    [FSL_IMX8MM_VPU_G1_DECODER] =3D { 0x38300000, 1 * MiB,
> "vpu_g1_decoder" },
> >>+    [FSL_IMX8MM_USB2_OTG] =3D { 0x32e50200, 0x200, "usb2_otg" },
> >>+    [FSL_IMX8MM_USB2] =3D { 0x32e50000, 0x200, "usb2" },
> >>+    [FSL_IMX8MM_USB1_OTG] =3D { 0x32e40200, 0x200, "usb1_otg" },
> >>+    [FSL_IMX8MM_USB1] =3D { 0x32e40000, 0x200, "usb1" },
> >>+    [FSL_IMX8MM_GPU2D] =3D { 0x38000000, 64 * KiB, "gpu2d" },
> >>+    [FSL_IMX8MM_QSPI1_RX_BUFFER] =3D { 0x34000000, 32 * MiB,
> "qspi1_rx_buffer" },
> >>+    [FSL_IMX8MM_PCIE1] =3D { 0x33800000, 4 * MiB, "pcie1" },
> >>+    [FSL_IMX8MM_QSPI1_TX_BUFFER] =3D { 0x33008000, 32 * KiB,
> "qspi1_tx_buffer" },
> >>+    [FSL_IMX8MM_APBH_DMA] =3D { 0x33000000, 32 * KiB, "apbh_dma" },
> >>+
> >>+    /* AIPS-4 Begin */
> >>+    [FSL_IMX8MM_TZASC] =3D { 0x32f80000, 64 * KiB, "tzasc" },
> >>+    [FSL_IMX8MM_PCIE_PHY1] =3D { 0x32f00000, 64 * KiB, "pcie_phy1" },
> >>+    [FSL_IMX8MM_MEDIA_BLK_CTL] =3D { 0x32e28000, 256,
> "media_blk_ctl" },
> >>+    [FSL_IMX8MM_LCDIF] =3D { 0x32e00000, 64 * KiB, "lcdif" },
> >>+    [FSL_IMX8MM_MIPI_DSI] =3D { 0x32e10000, 64 * KiB, "mipi_dsi" },
> >>+    [FSL_IMX8MM_MIPI_CSI] =3D { 0x32e30000, 64 * KiB, "mipi_csi" },
> >>+    [FSL_IMX8MM_AIPS4_CONFIGURATION] =3D { 0x32df0000, 64 * KiB,
> "aips4_configuration" },
> >>+    /* AIPS-4 End */
> >>+
> >>+    [FSL_IMX8MM_INTERCONNECT] =3D { 0x32700000, 1 * MiB,
> "interconnect"
> >>+ },
> >>+
> >>+    /* AIPS-3 Begin */
> >>+    [FSL_IMX8MM_ENET1] =3D { 0x30be0000, 64 * KiB, "enet1" },
> >>+    [FSL_IMX8MM_SDMA1] =3D { 0x30bd0000, 64 * KiB, "sdma1" },
> >>+    [FSL_IMX8MM_QSPI] =3D { 0x30bb0000, 64 * KiB, "qspi" },
> >>+    [FSL_IMX8MM_USDHC3] =3D { 0x30b60000, 64 * KiB, "usdhc3" },
> >>+    [FSL_IMX8MM_USDHC2] =3D { 0x30b50000, 64 * KiB, "usdhc2" },
> >>+    [FSL_IMX8MM_USDHC1] =3D { 0x30b40000, 64 * KiB, "usdhc1" },
> >>+    [FSL_IMX8MM_SEMAPHORE_HS] =3D { 0x30ac0000, 64 * KiB,
> "semaphore_hs" },
> >>+    [FSL_IMX8MM_MU_B] =3D { 0x30ab0000, 64 * KiB, "mu_b" },
> >>+    [FSL_IMX8MM_MU_A] =3D { 0x30aa0000, 64 * KiB, "mu_a" },
> >>+    [FSL_IMX8MM_UART4] =3D { 0x30a60000, 64 * KiB, "uart4" },
> >>+    [FSL_IMX8MM_I2C4] =3D { 0x30a50000, 64 * KiB, "i2c4" },
> >>+    [FSL_IMX8MM_I2C3] =3D { 0x30a40000, 64 * KiB, "i2c3" },
> >>+    [FSL_IMX8MM_I2C2] =3D { 0x30a30000, 64 * KiB, "i2c2" },
> >>+    [FSL_IMX8MM_I2C1] =3D { 0x30a20000, 64 * KiB, "i2c1" },
> >>+    [FSL_IMX8MM_AIPS3_CONFIGURATION] =3D { 0x309f0000, 64 * KiB,
> "aips3_configuration" },
> >>+    [FSL_IMX8MM_CAAM] =3D { 0x30900000, 256 * KiB, "caam" },
> >>+    [FSL_IMX8MM_SPBA1] =3D { 0x308f0000, 64 * KiB, "spba1" },
> >>+    [FSL_IMX8MM_UART2] =3D { 0x30890000, 64 * KiB, "uart2" },
> >>+    [FSL_IMX8MM_UART3] =3D { 0x30880000, 64 * KiB, "uart3" },
> >>+    [FSL_IMX8MM_UART1] =3D { 0x30860000, 64 * KiB, "uart1" },
> >>+    [FSL_IMX8MM_ECSPI3] =3D { 0x30840000, 64 * KiB, "ecspi3" },
> >>+    [FSL_IMX8MM_ECSPI2] =3D { 0x30830000, 64 * KiB, "ecspi2" },
> >>+    [FSL_IMX8MM_ECSPI1] =3D { 0x30820000, 64 * KiB, "ecspi1" },
> >>+    /* AIPS-3 End */
> >>+
> >>+    /* AIPS-2 Begin */
> >>+    [FSL_IMX8MM_QOSC] =3D { 0x307f0000, 64 * KiB, "qosc" },
> >>+    [FSL_IMX8MM_PERFMON2] =3D { 0x307d0000, 64 * KiB, "perfmon2" },
> >>+    [FSL_IMX8MM_PERFMON1] =3D { 0x307c0000, 64 * KiB, "perfmon1" },
> >>+    [FSL_IMX8MM_GPT4] =3D { 0x30700000, 64 * KiB, "gpt4" },
> >>+    [FSL_IMX8MM_GPT5] =3D { 0x306f0000, 64 * KiB, "gpt5" },
> >>+    [FSL_IMX8MM_GPT6] =3D { 0x306e0000, 64 * KiB, "gpt6" },
> >>+    [FSL_IMX8MM_SYSCNT_CTRL] =3D { 0x306c0000, 64 * KiB, "syscnt_ctrl"=
 },
> >>+    [FSL_IMX8MM_SYSCNT_CMP] =3D { 0x306b0000, 64 * KiB, "syscnt_cmp" }=
,
> >>+    [FSL_IMX8MM_SYSCNT_RD] =3D { 0x306a0000, 64 * KiB, "syscnt_rd" },
> >>+    [FSL_IMX8MM_PWM4] =3D { 0x30690000, 64 * KiB, "pwm4" },
> >>+    [FSL_IMX8MM_PWM3] =3D { 0x30680000, 64 * KiB, "pwm3" },
> >>+    [FSL_IMX8MM_PWM2] =3D { 0x30670000, 64 * KiB, "pwm2" },
> >>+    [FSL_IMX8MM_PWM1] =3D { 0x30660000, 64 * KiB, "pwm1" },
> >>+    [FSL_IMX8MM_AIPS2_CONFIGURATION] =3D { 0x305f0000, 64 * KiB,
> "aips2_configuration" },
> >>+    /* AIPS-2 End */
> >>+
> >>+    /* AIPS-1 Begin */
> >>+    [FSL_IMX8MM_CSU] =3D { 0x303e0000, 64 * KiB, "csu" },
> >>+    [FSL_IMX8MM_RDC] =3D { 0x303d0000, 64 * KiB, "rdc" },
> >>+    [FSL_IMX8MM_SEMAPHORE2] =3D { 0x303c0000, 64 * KiB,
> "semaphore2" },
> >>+    [FSL_IMX8MM_SEMAPHORE1] =3D { 0x303b0000, 64 * KiB,
> "semaphore1" },
> >>+    [FSL_IMX8MM_GPC] =3D { 0x303a0000, 64 * KiB, "gpc" },
> >>+    [FSL_IMX8MM_SRC] =3D { 0x30390000, 64 * KiB, "src" },
> >>+    [FSL_IMX8MM_CCM] =3D { 0x30380000, 64 * KiB, "ccm" },
> >>+    [FSL_IMX8MM_SNVS_HP] =3D { 0x30370000, 64 * KiB, "snvs_hp" },
> >>+    [FSL_IMX8MM_ANA_PLL] =3D { 0x30360000, 64 * KiB, "ana_pll" },
> >>+    [FSL_IMX8MM_OCOTP_CTRL] =3D { 0x30350000, 64 * KiB, "ocotp_ctrl" }=
,
> >>+    [FSL_IMX8MM_IOMUXC_GPR] =3D { 0x30340000, 64 * KiB, "iomuxc_gpr" }=
,
> >>+    [FSL_IMX8MM_IOMUXC] =3D { 0x30330000, 64 * KiB, "iomuxc" },
> >>+    [FSL_IMX8MM_GPT3] =3D { 0x302f0000, 64 * KiB, "gpt3" },
> >>+    [FSL_IMX8MM_GPT2] =3D { 0x302e0000, 64 * KiB, "gpt2" },
> >>+    [FSL_IMX8MM_GPT1] =3D { 0x302d0000, 64 * KiB, "gpt1" },
> >>+    [FSL_IMX8MM_SDMA2] =3D { 0x302c0000, 64 * KiB, "sdma2" },
> >>+    [FSL_IMX8MM_SDMA3] =3D { 0x302b0000, 64 * KiB, "sdma3" },
> >>+    [FSL_IMX8MM_WDOG3] =3D { 0x302a0000, 64 * KiB, "wdog3" },
> >>+    [FSL_IMX8MM_WDOG2] =3D { 0x30290000, 64 * KiB, "wdog2" },
> >>+    [FSL_IMX8MM_WDOG1] =3D { 0x30280000, 64 * KiB, "wdog1" },
> >>+    [FSL_IMX8MM_ANA_OSC] =3D { 0x30270000, 64 * KiB, "ana_osc" },
> >>+    [FSL_IMX8MM_ANA_TSENSOR] =3D { 0x30260000, 64 * KiB,
> "ana_tsensor" },
> >>+    [FSL_IMX8MM_GPIO5] =3D { 0x30240000, 64 * KiB, "gpio5" },
> >>+    [FSL_IMX8MM_GPIO4] =3D { 0x30230000, 64 * KiB, "gpio4" },
> >>+    [FSL_IMX8MM_GPIO3] =3D { 0x30220000, 64 * KiB, "gpio3" },
> >>+    [FSL_IMX8MM_GPIO2] =3D { 0x30210000, 64 * KiB, "gpio2" },
> >>+    [FSL_IMX8MM_GPIO1] =3D { 0x30200000, 64 * KiB, "gpio1" },
> >>+    [FSL_IMX8MM_AIPS1_CONFIGURATION] =3D { 0x301f0000, 64 * KiB,
> "aips1_configuration" },
> >>+    [FSL_IMX8MM_SAI6] =3D { 0x30060000, 64 * KiB, "sai6" },
> >>+    [FSL_IMX8MM_SAI5] =3D { 0x30050000, 64 * KiB, "sai5" },
> >>+    [FSL_IMX8MM_SAI3] =3D { 0x30030000, 64 * KiB, "sai3" },
> >>+    [FSL_IMX8MM_SAI2] =3D { 0x30020000, 64 * KiB, "sai2" },
> >>+    [FSL_IMX8MM_SAI1] =3D { 0x30010000, 64 * KiB, "sai1" },
> >>+
> >>+    /* AIPS-1 End */
> >>+
> >>+    [FSL_IMX8MM_A53_DAP] =3D { 0x28000000, 16 * MiB, "a53_dap" },
> >>+    [FSL_IMX8MM_PCIE1_MEM] =3D { 0x18000000, 128 * MiB,
> "pcie1_mem" },
> >>+    [FSL_IMX8MM_QSPI_MEM] =3D { 0x08000000, 256 * MiB, "qspi_mem" },
> >>+    [FSL_IMX8MM_OCRAM] =3D { 0x00900000, 256 * KiB, "ocram" },
> >>+    [FSL_IMX8MM_TCM_DTCM] =3D { 0x00800000, 128 * KiB, "tcm_dtcm" },
> >>+    [FSL_IMX8MM_TCM_ITCM] =3D { 0x007e0000, 128 * KiB, "tcm_itcm" },
> >>+    [FSL_IMX8MM_OCRAM_S] =3D { 0x00180000, 32 * KiB, "ocram_s" },
> >>+    [FSL_IMX8MM_CAAM_MEM] =3D { 0x00100000, 32 * KiB, "caam_mem" },
> >>+    [FSL_IMX8MM_BOOT_ROM_PROTECTED] =3D { 0x0003f000, 4 * KiB,
> "boot_rom_protected" },
> >>+    [FSL_IMX8MM_BOOT_ROM] =3D { 0x00000000, 252 * KiB, "boot_rom" }, }=
;
> >>+
> >>+static void fsl_imx8mm_init(Object *obj) {
> >>+    MachineState *ms =3D MACHINE(qdev_get_machine());
> >>+    FslImx8mmState *s =3D FSL_IMX8MM(obj);
> >>+    const char *cpu_type =3D ms->cpu_type ?:
> ARM_CPU_TYPE_NAME("cortex-a53");
> >>+    int i;
> >>+
> >>+    for (i =3D 0; i < MIN(ms->smp.cpus, FSL_IMX8MM_NUM_CPUS); i++) {
> >>+        g_autofree char *name =3D g_strdup_printf("cpu%d", i);
> >>+        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
> >>+    }
> >>+
> >>+    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
> >>+
> >>+    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
> >>+        g_autofree char *name =3D g_strdup_printf("uart%d", i + 1);
> >>+        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIA=
L);
> >>+    }
> >>+
> >>+}
> >>+
> >>+static void fsl_imx8mm_realize(DeviceState *dev, Error **errp) {
> >>+    MachineState *ms =3D MACHINE(qdev_get_machine());
> >>+    FslImx8mmState *s =3D FSL_IMX8MM(dev);
> >>+    DeviceState *gicdev =3D DEVICE(&s->gic);
> >>+    int i;
> >>+
> >>+    if (ms->smp.cpus > FSL_IMX8MM_NUM_CPUS) {
> >>+        error_setg(errp, "%s: Only %d CPUs are supported (%d requested=
)",
> >>+                   TYPE_FSL_IMX8MM, FSL_IMX8MM_NUM_CPUS, ms-
> >smp.cpus);
> >>+        return;
> >>+    }
> >>+
> >>+    /* CPUs */
> >>+    for (i =3D 0; i < ms->smp.cpus; i++) {
> >>+        /* On uniprocessor, the CBAR is set to 0 */
> >>+        if (ms->smp.cpus > 1 &&
> >>+                object_property_find(OBJECT(&s->cpu[i]), "reset-cbar")=
) {
> >>+            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
> >>+
> fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST].addr,
> >>+                                    &error_abort);
> >>+        }
> >>+
> >>+        /*
> >>+         * CNTFID0 base frequency in Hz of system counter
> >>+         */
> >>+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
> >>+                                &error_abort);
> >>+
> >>+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el2")) {
> >>+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el2",
> >>+                                     !kvm_enabled(), &error_abort);
> >>+        }
> >>+
> >>+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
> >>+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
> >>+                                     !kvm_enabled(), &error_abort);
> >>+        }
> >>+
> >>+        if (i) {
> >>+            /*
> >>+             * Secondary CPUs start in powered-down state (and can be
> >>+             * powered up via the SRC system reset controller)
> >>+             */
> >>+            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powere=
d-off",
> >>+                                     true, &error_abort);
> >>+        }
> >>+
> >>+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> >>+            return;
> >>+        }
> >>+    }
> >>+
> >>+    /* GIC */
> >>+    {
> >>+        SysBusDevice *gicsbd =3D SYS_BUS_DEVICE(&s->gic);
> >>+        QList *redist_region_count;
> >>+        bool pmu =3D object_property_get_bool(OBJECT(first_cpu), "pmu"=
,
> >>+ NULL);
> >>+
> >>+        qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp.cpus);
> >>+        qdev_prop_set_uint32(gicdev, "num-irq",
> >>+                             FSL_IMX8MM_NUM_IRQS + GIC_INTERNAL);
> >>+        redist_region_count =3D qlist_new();
> >>+        qlist_append_int(redist_region_count, ms->smp.cpus);
> >>+        qdev_prop_set_array(gicdev, "redist-region-count",
> redist_region_count);
> >>+        object_property_set_link(OBJECT(&s->gic), "sysmem",
> >>+                                 OBJECT(get_system_memory()), &error_f=
atal);
> >>+        if (!sysbus_realize(gicsbd, errp)) {
> >>+            return;
> >>+        }
> >>+        sysbus_mmio_map(gicsbd, 0,
> fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST].addr);
> >>+        sysbus_mmio_map(gicsbd, 1,
> >>+ fsl_imx8mm_memmap[FSL_IMX8MM_GIC_REDIST].addr);
> >>+
> >>+        /*
> >>+         * Wire the outputs from each CPU's generic timer and the GICv=
3
> >>+         * maintenance interrupt signal to the appropriate GIC PPI inp=
uts, and
> >>+         * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
> >>+         */
> >>+        for (i =3D 0; i < ms->smp.cpus; i++) {
> >>+            DeviceState *cpudev =3D DEVICE(&s->cpu[i]);
> >>+            int intidbase =3D FSL_IMX8MM_NUM_IRQS + i * GIC_INTERNAL;
> >>+            qemu_irq irq;
> >>+
> >>+            /*
> >>+             * Mapping from the output timer irq lines from the CPU to=
 the
> >>+             * GIC PPI inputs.
> >>+             */
> >>+            static const int timer_irqs[] =3D {
> >>+                [GTIMER_PHYS] =3D ARCH_TIMER_NS_EL1_IRQ,
> >>+                [GTIMER_VIRT] =3D ARCH_TIMER_VIRT_IRQ,
> >>+                [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
> >>+                [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
> >>+            };
> >>+
> >>+            for (int j =3D 0; j < ARRAY_SIZE(timer_irqs); j++) {
> >>+                irq =3D qdev_get_gpio_in(gicdev, intidbase + timer_irq=
s[j]);
> >>+                qdev_connect_gpio_out(cpudev, j, irq);
> >>+            }
> >>+
> >>+            irq =3D qdev_get_gpio_in(gicdev, intidbase + ARCH_GIC_MAIN=
T_IRQ);
> >>+            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-
> interrupt",
> >>+                                        0, irq);
> >>+
> >>+            irq =3D qdev_get_gpio_in(gicdev, intidbase + VIRTUAL_PMU_I=
RQ);
> >>+            qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> >>+ irq);
> >>+
> >>+            sysbus_connect_irq(gicsbd, i,
> >>+                               qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> >>+            sysbus_connect_irq(gicsbd, i + ms->smp.cpus,
> >>+                               qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> >>+            sysbus_connect_irq(gicsbd, i + 2 * ms->smp.cpus,
> >>+                               qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ))=
;
> >>+            sysbus_connect_irq(gicsbd, i + 3 * ms->smp.cpus,
> >>+                               qdev_get_gpio_in(cpudev,
> >>+ ARM_CPU_VFIQ));
> >>+
> >>+            if (kvm_enabled()) {
> >>+                if (pmu) {
> >>+                    assert(arm_feature(&s->cpu[i].env, ARM_FEATURE_PMU=
));
> >>+                    if (kvm_irqchip_in_kernel()) {
> >>+                        kvm_arm_pmu_set_irq(&s->cpu[i], VIRTUAL_PMU_IR=
Q);
> >>+                    }
> >>+                    kvm_arm_pmu_init(&s->cpu[i]);
> >>+                }
> >>+            }
> >>+        }
> >>+    }
> >>+
> >>+    /* UARTs */
> >>+    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
> >>+        static const struct {
> >>+            hwaddr addr;
> >>+            unsigned int irq;
> >>+        } serial_table[FSL_IMX8MM_NUM_UARTS] =3D {
> >>+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART1].addr,
> FSL_IMX8MM_UART1_IRQ },
> >>+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART2].addr,
> FSL_IMX8MM_UART2_IRQ },
> >>+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART3].addr,
> FSL_IMX8MM_UART3_IRQ },
> >>+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART4].addr,
> FSL_IMX8MM_UART4_IRQ },
> >>+        };
> >>+
> >>+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i)=
);
> >>+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
> >>+            return;
> >>+        }
> >>+
> >>+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0,
> serial_table[i].addr);
> >>+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
> >>+                           qdev_get_gpio_in(gicdev, serial_table[i].ir=
q));
> >>+    }
> >>+
> >>+    /* Unimplemented devices */
> >>+    for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
> >>+        switch (i) {
> >>+        case FSL_IMX8MM_GIC_DIST:
> >>+        case FSL_IMX8MM_GIC_REDIST:
> >>+        case FSL_IMX8MM_RAM:
> >>+        case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
> >>+            /* device implemented and treated above */
> >>+            break;
> >>+
> >>+        default:
> >>+            create_unimplemented_device(fsl_imx8mm_memmap[i].name,
> >>+                                        fsl_imx8mm_memmap[i].addr,
> >>+                                        fsl_imx8mm_memmap[i].size);
> >>+            break;
> >>+        }
> >>+    }
> >>+}
> >>+
> >>+static void fsl_imx8mm_class_init(ObjectClass *oc, const void *data)
> >>+{
> >>+    DeviceClass *dc =3D DEVICE_CLASS(oc);
> >>+
> >>+    dc->realize =3D fsl_imx8mm_realize;
> >>+
> >>+    dc->desc =3D "i.MX 8MM SoC";
> >>+}
> >>+
> >>+static const TypeInfo fsl_imx8mm_types[] =3D {
> >>+    {
> >>+        .name =3D TYPE_FSL_IMX8MM,
> >>+        .parent =3D TYPE_SYS_BUS_DEVICE,
> >>+        .instance_size =3D sizeof(FslImx8mmState),
> >>+        .instance_init =3D fsl_imx8mm_init,
> >>+        .class_init =3D fsl_imx8mm_class_init,
> >>+    },
> >>+};
> >>+
> >>+DEFINE_TYPES(fsl_imx8mm_types)
> >>diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c new file mode
> >>100644 index 0000000000..ffc69f1050
> >>--- /dev/null
> >>+++ b/hw/arm/imx8mm-evk.c
> >>@@ -0,0 +1,110 @@
> >>+/*
> >>+ * NXP i.MX 8MM Evaluation Kit System Emulation
> >>+ *
> >>+ * Copyright (c) 2025, NXP Semiconductors
> >>+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >>+ *
> >>+ * SPDX-License-Identifier: GPL-2.0-or-later  */
> >>+
> >>+#include "qemu/osdep.h"
> >>+#include "system/address-spaces.h"
> >>+#include "hw/arm/boot.h"
> >>+#include "hw/arm/fsl-imx8mm.h"
> >>+#include "hw/arm/machines-qom.h"
> >>+#include "hw/boards.h"
> >>+#include "hw/qdev-properties.h"
> >>+#include "system/kvm.h"
> >>+#include "system/qtest.h"
> >>+#include "qemu/error-report.h"
> >>+#include "qapi/error.h"
> >>+#include <libfdt.h>
> >
> >Rather than introducing a new source file I think it should be possible =
to
> extend imx8mp-evk instead. More comments below.
> >
> >>+
> >>+static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info,
> >>+void *fdt) {
> >>+    int i, offset;
> >>+
> >>+    /* Temporarily disable following nodes until they are implemented =
*/
> >>+    const char *nodes_to_remove[] =3D {
> >>+        "nxp,imx8mm-fspi",
> >>+        "fsl,imx8mm-mipi-csi",
> >>+        "fsl,imx8mm-mipi-dsim"
> >
> >You could probably just add these nodes to the list in imx8mp-evk.
> >
> >>+    };
> >>+
> >>+    for (i =3D 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
> >>+        const char *dev_str =3D nodes_to_remove[i];
> >>+
> >>+        offset =3D fdt_node_offset_by_compatible(fdt, -1, dev_str);
> >>+        while (offset >=3D 0) {
> >>+            fdt_nop_node(fdt, offset);
> >>+            offset =3D fdt_node_offset_by_compatible(fdt, offset, dev_=
str);
> >>+        }
> >>+    }
> >>+
> >>+    /* Remove cpu-idle-states property from CPU nodes */
> >>+    offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,cortex-a53"=
);
> >>+    while (offset >=3D 0) {
> >>+        fdt_nop_property(fdt, offset, "cpu-idle-states");
> >>+        offset =3D fdt_node_offset_by_compatible(fdt, offset, "arm,cor=
tex-
> a53");
> >>+    }
> >>+
> >>+    if (kvm_enabled()) {
> >>+        /* Use system counter frequency from host CPU to fix time in g=
uest */
> >>+        offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,armv8-t=
imer");
> >>+        while (offset >=3D 0) {
> >>+            fdt_nop_property(fdt, offset, "clock-frequency");
> >>+            offset =3D fdt_node_offset_by_compatible(fdt, offset, "arm=
,armv8-
> timer");
> >>+        }
> >>+    }
> >>+}
> >>+
> >>+static void imx8mm_evk_init(MachineState *machine) {
> >>+    static struct arm_boot_info boot_info;
> >>+    FslImx8mmState *s;
> >>+
> >
> >In this function it might be possible to perform an object_dynamic_cast(=
) on
> the MachineState to check which machine was requested by the user.
> Depending on that one could fill variables with SoC-specific values and u=
se
> them below instead of hardcoded values.
> >
> >>+    if (machine->ram_size > FSL_IMX8MM_RAM_SIZE_MAX) {
> >>+        error_report("RAM size " RAM_ADDR_FMT " above max supported
> (%08" PRIx64 ")",
> >>+                     machine->ram_size, FSL_IMX8MM_RAM_SIZE_MAX);
> >>+        exit(1);
> >>+    }
> >>+
> >>+    boot_info =3D (struct arm_boot_info) {
> >>+        .loader_start =3D FSL_IMX8MM_RAM_START,
> >>+        .board_id =3D -1,
> >>+        .ram_size =3D machine->ram_size,
> >>+        .psci_conduit =3D QEMU_PSCI_CONDUIT_SMC,
> >>+        .modify_dtb =3D imx8mm_evk_modify_dtb,
> >>+    };
> >>+
> >>+    s =3D FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
> >>+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
> >>+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
> >>+
> >>+    memory_region_add_subregion(get_system_memory(),
> FSL_IMX8MM_RAM_START,
> >>+                                machine->ram);
> >>+
> >>+    if (!qtest_enabled()) {
> >>+        arm_load_kernel(&s->cpu[0], machine, &boot_info);
> >>+    }
> >>+}
> >>+
> >>+static const char *imx8mm_evk_get_default_cpu_type(const
> MachineState
> >>+*ms) {
> >>+    if (kvm_enabled()) {
> >>+        return ARM_CPU_TYPE_NAME("host");
> >>+    }
> >>+
> >>+    return ARM_CPU_TYPE_NAME("cortex-a53"); }
> >
> >The code below might just be able to copied over to imx8mp-evk.c.
> >
> >Does such consolidation work?
>=20
> Hi Gurav,
>=20
> If you feel that such consolidation isn't useful feel free to leave the -=
evk.c files
> separated. I don't have a strong opinion on it.
>=20
> Best regards,
> Bernhard
>=20
> >
> >Best regards,
> >Bernhard
> >
> >>+
> >>+static void imx8mm_evk_machine_init(MachineClass *mc) {
> >>+    mc->desc =3D "NXP i.MX 8MM EVK Board";
> >>+    mc->init =3D imx8mm_evk_init;
> >>+    mc->max_cpus =3D FSL_IMX8MM_NUM_CPUS;
> >>+    mc->default_ram_id =3D "imx8mm-evk.ram";
> >>+    mc->get_default_cpu_type =3D imx8mm_evk_get_default_cpu_type; }
> >>+
> >>+DEFINE_MACHINE_AARCH64("imx8mm-evk", imx8mm_evk_machine_init)
> >>diff --git a/hw/arm/meson.build b/hw/arm/meson.build index
> >>aeaf654790..12ecb824cc 100644
> >>--- a/hw/arm/meson.build
> >>+++ b/hw/arm/meson.build
> >>@@ -84,6 +84,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE',
> if_true:
> >>files('armsse.c'))
> >> arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true:
> >>files('fsl-imx7.c', 'mcimx7d-sabre.c'))
> >> arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true:
> >>files('fsl-imx8mp.c'))
> >> arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true:
> >>files('imx8mp-evk.c'))
> >>+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM', if_true:
> >>+files('fsl-imx8mm.c'))
> >>+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM_EVK', if_true:
> >>+files('imx8mm-evk.c'))
> >> arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true:
> >>files('smmuv3.c'))
> >> arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true:
> >>files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
> >> arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true:
> >>files('nrf51_soc.c')) diff --git a/include/hw/arm/fsl-imx8mm.h
> >>b/include/hw/arm/fsl-imx8mm.h new file mode 100644 index
> >>0000000000..133f519b7c
> >>--- /dev/null
> >>+++ b/include/hw/arm/fsl-imx8mm.h
> >>@@ -0,0 +1,157 @@
> >>+/*
> >>+ * i.MX 8MM SoC Definitions
> >>+ *
> >>+ * Copyright (c) 2025, NXP Semiconductors
> >>+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >>+ *
> >>+ * SPDX-License-Identifier: GPL-2.0-or-later  */
> >>+
> >>+#ifndef FSL_IMX8MM_H
> >>+#define FSL_IMX8MM_H
> >>+
> >>+#include "cpu.h"
> >>+#include "hw/char/imx_serial.h"
> >>+#include "hw/intc/arm_gicv3_common.h"
> >>+#include "qom/object.h"
> >>+#include "qemu/units.h"
> >>+
> >>+#define TYPE_FSL_IMX8MM "fsl-imx8mm"
> >>+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
> >>+
> >>+#define FSL_IMX8MM_RAM_START        0x40000000
> >>+#define FSL_IMX8MM_RAM_SIZE_MAX     (4 * GiB)
> >>+
> >>+enum FslImx8mmConfiguration {
> >>+    FSL_IMX8MM_NUM_CPUS         =3D 4,
> >>+    FSL_IMX8MM_NUM_IRQS         =3D 128,
> >>+    FSL_IMX8MM_NUM_UARTS        =3D 4,
> >>+};
> >>+
> >>+struct FslImx8mmState {
> >>+    SysBusDevice   parent_obj;
> >>+
> >>+    ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
> >>+    GICv3State         gic;
> >>+    IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
> >>+};
> >>+
> >>+enum FslImx8mmMemoryRegions {
> >>+    FSL_IMX8MM_A53_DAP,
> >>+    FSL_IMX8MM_AIPS1_CONFIGURATION,
> >>+    FSL_IMX8MM_AIPS2_CONFIGURATION,
> >>+    FSL_IMX8MM_AIPS3_CONFIGURATION,
> >>+    FSL_IMX8MM_AIPS4_CONFIGURATION,
> >>+    FSL_IMX8MM_ANA_OSC,
> >>+    FSL_IMX8MM_ANA_PLL,
> >>+    FSL_IMX8MM_ANA_TSENSOR,
> >>+    FSL_IMX8MM_APBH_DMA,
> >>+    FSL_IMX8MM_BOOT_ROM,
> >>+    FSL_IMX8MM_BOOT_ROM_PROTECTED,
> >>+    FSL_IMX8MM_CAAM,
> >>+    FSL_IMX8MM_CAAM_MEM,
> >>+    FSL_IMX8MM_CCM,
> >>+    FSL_IMX8MM_CSU,
> >>+    FSL_IMX8MM_DDR_CTL,
> >>+    FSL_IMX8MM_DDR_PERF_MON,
> >>+    FSL_IMX8MM_DDR_PHY,
> >>+    FSL_IMX8MM_DDR_PHY_BROADCAST,
> >>+    FSL_IMX8MM_ECSPI1,
> >>+    FSL_IMX8MM_ECSPI2,
> >>+    FSL_IMX8MM_ECSPI3,
> >>+    FSL_IMX8MM_ENET1,
> >>+    FSL_IMX8MM_GIC_DIST,
> >>+    FSL_IMX8MM_GIC_REDIST,
> >>+    FSL_IMX8MM_GPC,
> >>+    FSL_IMX8MM_GPIO1,
> >>+    FSL_IMX8MM_GPIO2,
> >>+    FSL_IMX8MM_GPIO3,
> >>+    FSL_IMX8MM_GPIO4,
> >>+    FSL_IMX8MM_GPIO5,
> >>+    FSL_IMX8MM_GPT1,
> >>+    FSL_IMX8MM_GPT2,
> >>+    FSL_IMX8MM_GPT3,
> >>+    FSL_IMX8MM_GPT4,
> >>+    FSL_IMX8MM_GPT5,
> >>+    FSL_IMX8MM_GPT6,
> >>+    FSL_IMX8MM_GPU2D,
> >>+    FSL_IMX8MM_I2C1,
> >>+    FSL_IMX8MM_I2C2,
> >>+    FSL_IMX8MM_I2C3,
> >>+    FSL_IMX8MM_I2C4,
> >>+    FSL_IMX8MM_INTERCONNECT,
> >>+    FSL_IMX8MM_IOMUXC,
> >>+    FSL_IMX8MM_IOMUXC_GPR,
> >>+    FSL_IMX8MM_MEDIA_BLK_CTL,
> >>+    FSL_IMX8MM_LCDIF,
> >>+    FSL_IMX8MM_MIPI_CSI,
> >>+    FSL_IMX8MM_MIPI_DSI,
> >>+    FSL_IMX8MM_MU_A,
> >>+    FSL_IMX8MM_MU_B,
> >>+    FSL_IMX8MM_OCOTP_CTRL,
> >>+    FSL_IMX8MM_OCRAM,
> >>+    FSL_IMX8MM_OCRAM_S,
> >>+    FSL_IMX8MM_PCIE1,
> >>+    FSL_IMX8MM_PCIE1_MEM,
> >>+    FSL_IMX8MM_PCIE_PHY1,
> >>+    FSL_IMX8MM_PERFMON1,
> >>+    FSL_IMX8MM_PERFMON2,
> >>+    FSL_IMX8MM_PWM1,
> >>+    FSL_IMX8MM_PWM2,
> >>+    FSL_IMX8MM_PWM3,
> >>+    FSL_IMX8MM_PWM4,
> >>+    FSL_IMX8MM_QOSC,
> >>+    FSL_IMX8MM_QSPI,
> >>+    FSL_IMX8MM_QSPI1_RX_BUFFER,
> >>+    FSL_IMX8MM_QSPI1_TX_BUFFER,
> >>+    FSL_IMX8MM_QSPI_MEM,
> >>+    FSL_IMX8MM_RAM,
> >>+    FSL_IMX8MM_RDC,
> >>+    FSL_IMX8MM_SAI1,
> >>+    FSL_IMX8MM_SAI2,
> >>+    FSL_IMX8MM_SAI3,
> >>+    FSL_IMX8MM_SAI5,
> >>+    FSL_IMX8MM_SAI6,
> >>+    FSL_IMX8MM_SDMA1,
> >>+    FSL_IMX8MM_SDMA2,
> >>+    FSL_IMX8MM_SDMA3,
> >>+    FSL_IMX8MM_SEMAPHORE1,
> >>+    FSL_IMX8MM_SEMAPHORE2,
> >>+    FSL_IMX8MM_SEMAPHORE_HS,
> >>+    FSL_IMX8MM_SNVS_HP,
> >>+    FSL_IMX8MM_SPBA1,
> >>+    FSL_IMX8MM_SRC,
> >>+    FSL_IMX8MM_SYSCNT_CMP,
> >>+    FSL_IMX8MM_SYSCNT_CTRL,
> >>+    FSL_IMX8MM_SYSCNT_RD,
> >>+    FSL_IMX8MM_TCM_DTCM,
> >>+    FSL_IMX8MM_TCM_ITCM,
> >>+    FSL_IMX8MM_TZASC,
> >>+    FSL_IMX8MM_UART1,
> >>+    FSL_IMX8MM_UART2,
> >>+    FSL_IMX8MM_UART3,
> >>+    FSL_IMX8MM_UART4,
> >>+    FSL_IMX8MM_USB1,
> >>+    FSL_IMX8MM_USB2,
> >>+    FSL_IMX8MM_USB1_OTG,
> >>+    FSL_IMX8MM_USB2_OTG,
> >>+    FSL_IMX8MM_USDHC1,
> >>+    FSL_IMX8MM_USDHC2,
> >>+    FSL_IMX8MM_USDHC3,
> >>+    FSL_IMX8MM_VPU,
> >>+    FSL_IMX8MM_VPU_BLK_CTRL,
> >>+    FSL_IMX8MM_VPU_G1_DECODER,
> >>+    FSL_IMX8MM_VPU_G2_DECODER,
> >>+    FSL_IMX8MM_WDOG1,
> >>+    FSL_IMX8MM_WDOG2,
> >>+    FSL_IMX8MM_WDOG3,
> >>+};
> >>+
> >>+enum FslImx8mmIrqs {
> >>+    FSL_IMX8MM_UART1_IRQ    =3D 26,
> >>+    FSL_IMX8MM_UART2_IRQ    =3D 27,
> >>+    FSL_IMX8MM_UART3_IRQ    =3D 28,
> >>+    FSL_IMX8MM_UART4_IRQ    =3D 29,
> >>+};
> >>+
> >>+#endif /* FSL_IMX8MM_H */

