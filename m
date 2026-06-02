Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A6ACD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUPJ1-0007tD-7r; Tue, 02 Jun 2026 09:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kiraly.tamas@outlook.com>)
 id 1wUPAL-00057C-1L
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 09:28:21 -0400
Received: from mail-francesouthazolkn19011028.outbound.protection.outlook.com
 ([52.103.39.28] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kiraly.tamas@outlook.com>)
 id 1wUPAJ-0003jh-J4
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 09:28:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqwlathx39/wpJF55HgPNkceaetHBDUYGM8UqfzBHhh2TRqxEaiXObl9c2pwJQRovPxvX0dpZ5ensn39DJJYwbazwzo1xAx2jD48MdIaSIGuuOWF0qGO0oGxFsAJgu0kdZWFFK9z9NeRqp4LnDQUnO9Czp9t0DzUO1PykaWZdvSVlNTpuPqcB+/fWMs86N/t/xj8nIK9T2jIKMF8sGmuBmFJuk38liOALJ50D54z88wh60GivsSTTMPJnByeNS+yR2EimmHgh10xpFONnAfnUf6iRuqlIaRnoJu9dbGxn24I/vPHqD/ZzxMcUSs8TdH7e2tsnkwdAx0p5FEq+dRe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NckgP5WQUz2jmFkl+kVrVhdevA1xGqYvIK3arxOT4Pw=;
 b=iHdkiHAeMyaD7stRNaCCGGVFRQkHhkaVPPqPRnhJluQpp43SG2QboE1TCXw0fvvbNiO+bDrDWm3NDEokQLCHLWiEJUr9qYU4JBGqOMGPifwh8v+XVE8QImUnTnc0uWl3T1Ec0w6jftuvBL5Gr1S+9/CwOaVN6dNPnk+wOMwBxJAPbXSe1St4hTuQ77bdaKSgmL9cMJ+dCsWRQc012I+znIPVSU9etiCSbl1m9zCH/tc6+iT1eXh+ld1NHSqDdGUe4+iHtvfDduzJgU9BO1YGu82m+uBjnybq1irzLKYjtHjYuKBAXBQWE8QW0gaqwDx8DxS5a3gbouGjXiQtzVy10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NckgP5WQUz2jmFkl+kVrVhdevA1xGqYvIK3arxOT4Pw=;
 b=W2y3PxS4tybplzW7ke+HE8P4aIEeKpWCOl2oSOJSlhUO7er+E6lmXjAQL0KZ5HaF5NCgYIQKPiQBaRFlLd0p4pQ8K9PRPt24Rph5Dd9rzESHWDEkRbmB0ebHrwwbNsw3R+gDPJ8JcloWe4GX80cw0w4bcCVKWiXCG/W+DrGpD243ForpStUuYLtRybJXGkh3EGejCdFfZCl6L4YgIPWzJ8dKIHmJjWiTQlbpif66XphbOXERIpM2qgvraDZFvp12KarzUAWXp93GR3cMYhDsuJjNyJMGqx8uioARsBaa1JAVtrvOGfyzpYAcxpevB8C6HDIa/Kp5QldMnFZPMf/qhw==
Received: from BESP192MB2919.EURP192.PROD.OUTLOOK.COM (2603:10a6:b10:ee::23)
 by PA3P192MB3014.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 13:23:14 +0000
Received: from BESP192MB2919.EURP192.PROD.OUTLOOK.COM
 ([fe80::adba:2c43:321f:433c]) by BESP192MB2919.EURP192.PROD.OUTLOOK.COM
 ([fe80::adba:2c43:321f:433c%6]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 13:23:14 +0000
From: =?iso-8859-1?Q?Tam=E1s_Kir=E1ly?= <kiraly.tamas@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@mailo.com" <philmd@mailo.com>
Subject: RFC sensor simulation in QEMU
Thread-Topic: RFC sensor simulation in QEMU
Thread-Index: AQHc8pDt2DN3gYDPbESNmIREuyJwHQ==
Date: Tue, 2 Jun 2026 13:23:14 +0000
Message-ID: <BESP192MB2919F3C79FA633DBB40571C89C122@BESP192MB2919.EURP192.PROD.OUTLOOK.COM>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BESP192MB2919:EE_|PA3P192MB3014:EE_
x-ms-office365-filtering-correlation-id: 5bdfac84-b63f-4470-7158-08dec0aa1a2c
x-microsoft-antispam: BCL:0;
 ARA:14566002|24021099003|24121999003|25031999004|22091999003|14030799003|31061999003|20031999006|39105399006|24071999003|8060799015|19110799012|8062599012|15080799012|26104999009|40105399003|440099028|3412199025|25131999003|102099032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DcG0Wrz4tmxhegHo1w/3V5PGO9KrlxEhU1iCKXImrC3+YCll+k4HMGg2UO?=
 =?iso-8859-1?Q?LF/YOO/RaVdXNk7+fKQBE2BNr/TutuigHysoyZVauJhX4WcRC/01pWL1lp?=
 =?iso-8859-1?Q?z4Hc5RdDF77N7BVJXy41JnUMFeER+oIcSdG8oFKkTxf0tXDnZxHS1Fm6cn?=
 =?iso-8859-1?Q?wt1BdPIYXo1lM1L1bahatcJYCCLZ9c61gImyg/h2E55R09zEGKwg8Yx4wP?=
 =?iso-8859-1?Q?hG4SWqwDqrQYlNb7rH2pOjWEH3DMh2VktdNwYht7S+oMkeMychR3IL+2Dx?=
 =?iso-8859-1?Q?vsjGmlfqY/COH3E2I1SgzxzWjvJw3qKgNoDXsoJhIBhvSo3GynhKT3RNGO?=
 =?iso-8859-1?Q?qFUNSoygLvGicNngpSrAQS4Ns/hacJCGLO0tCr8FQhAsxLkWh/MZejBUGL?=
 =?iso-8859-1?Q?q9dJQj1/c062cAd0XncDO6bmmQApasvBB23LNIlF9XqwngPqe7w7ige+TB?=
 =?iso-8859-1?Q?3iZC6cBy8G7bJq7UDHDsihWWfX3y+t74mHjnBte2lSgYaLELHx204/HabQ?=
 =?iso-8859-1?Q?lXUuf65oINwNQZGXofJUzgfM3NvtPNT612DveN/ME6UMZLrsTtPPLzQuwE?=
 =?iso-8859-1?Q?L0snHiXEYwI8MWEVqNrTLUcmJpEn4WcPTmTCHjYHUirKKkqjlk8LZ6R2VM?=
 =?iso-8859-1?Q?CB7irkMhQY/p8uraOTWLfhPocrDpcD1jPM9H7EyP5Dbd/VeKCHrqZp055B?=
 =?iso-8859-1?Q?EB8X1Qj0F6QUrACVNHM5dWq08YD6mYJQidTzxDN0oUuvFZhF8twCZl0oLA?=
 =?iso-8859-1?Q?EWdwpIDdzZ5YJxiBy2ZX5uk1/6B+Y1pL692CweN/RAgJjHE608fpIqH3y4?=
 =?iso-8859-1?Q?KcFpMgV4j2tioiHZPQxJiWiIl6MrEhXktrGNJji0kSwOkluZUxGMs7Q0fL?=
 =?iso-8859-1?Q?OhmDHCmYWytbylRlFwRQSsse6DknEa2pVnl036E108tm+Iqhn+hMQj6Has?=
 =?iso-8859-1?Q?uTXRv5Ycx/CQr9e0YdN9DNzt6HaUFjMKGWaQFzpV6TWfFOj3e1CRDhupYq?=
 =?iso-8859-1?Q?594gIStb05ZLx7fw4Uv5bNIaVQiTDzfckgOI6SuXEFrDSN/KuQ/318oqE6?=
 =?iso-8859-1?Q?Oe0my954CGCGnmrKRgPF2mSTBkQQRAgrRO2pDEgIlaVdV696FOelBesP/b?=
 =?iso-8859-1?Q?SigMEqq45I36++UotxUsgK4dYCpO3LYSgJrNSoGa2IS9yfrL4UESjbAcQC?=
 =?iso-8859-1?Q?vHh7NnPFB5eHEQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rsznIZ9rviqD5WUnEQLu0pUiFnxOLB4wUJWynD+C7mb54D4toIG/CzrR1X?=
 =?iso-8859-1?Q?Up6pU1gXIhRqlR4+3dIc8ZZtNFt4lxj00yUPYrS3ZD3ebOx+HJO9H/tjmr?=
 =?iso-8859-1?Q?nXNSlYaeJzFNQ2SrKOlA8AGEQEq1PFTkpSdbMf2uTDnO5xegKUvU66v8LD?=
 =?iso-8859-1?Q?pYpa2BhrGFJ+XMg22fKsU0TObpBLDWu1PNG9kbUMteghKzt4e8hAvvd4lk?=
 =?iso-8859-1?Q?Y2s36HzDOlMHiltGvTXR6iuPCX8u++p4y8+qPM9Qgyp/Gkckmrt8ZApMb4?=
 =?iso-8859-1?Q?mYF7pvDxoWi+Zo71T18iWAtEOjlRLdZFTVSaBBXFE/TKjgO6+mA5Qtua/D?=
 =?iso-8859-1?Q?cCCYp99Lb8ZROu0iOkqwKfCF4fP4JHfYwFne6cnEGvdnuVv4d9B+QeDZg6?=
 =?iso-8859-1?Q?o+sSDqSvl1S79CqaFkB9eo6QiS9lX+PbSpovKTNqeLl+v/u2sbWJgv2iSm?=
 =?iso-8859-1?Q?YnXNj8GlP42ln9rusFPa86lILOEhcsQFAOX3cL7x8qcEVDEb8hh6R4pIGC?=
 =?iso-8859-1?Q?MuRfqRqDApMxUUvptYnfj+mwIfesYrzGPHqvQn59NhSYOp52vRHC1KPwzN?=
 =?iso-8859-1?Q?VVKjY1C3Et9FY5zb9oMMpc0HT962QYda7YvLD9KyvUclnijKpL2LlMCTCC?=
 =?iso-8859-1?Q?G6CwLsDvfhI+M8VEel4eklarC19U3zwj5S4u+tgLcCbZpTqrCfAifasD2/?=
 =?iso-8859-1?Q?L9EXDm9ZbzkjU7xkB/AWht6JzFm05qZpb5lyj2XjAjkCwmugyicYaSwhas?=
 =?iso-8859-1?Q?Ex/Am4U3POm4xzlzD8Pt6Whf5Gbsc4Op6/wPCuvMGAwQw77jwpHhLeE/Bz?=
 =?iso-8859-1?Q?DDtMq9OEm+lUQo6dYnnvDUZrXaJ+lIsEIuoIZyvWjFaIN5xdsQAt9EpEDs?=
 =?iso-8859-1?Q?ELiRsjnuISA0Ej28V5HpW4ON5/s6LhAYHs+EV237ILXW66sLYnI7dbHksM?=
 =?iso-8859-1?Q?54lcXmBaRZUAYy3ZL704IXLS+M7BzEUd75s1uOzhTDScZSUIAGCJJpYzH/?=
 =?iso-8859-1?Q?St/SX4i7wqj04jNpsRjP9dXCIeeJx2UDsP1MTtZH4J0GFnX7EQpi6rjnyO?=
 =?iso-8859-1?Q?q6nSPcomA12cE9kNrJ+cbQuUH25/uF7FvWk9LuQteVvf3V3+jGjIlthwbq?=
 =?iso-8859-1?Q?lavQ52L8wSSCQ/G2WSMGIOM34F2Ms1KFvjaQaXKGk9Q4zTt8dqsco69zX8?=
 =?iso-8859-1?Q?cIXadlokPLV+1QHZj8qZuCC4DJ7ZG72Cv9TvafhDnRNNFKmXIWVugGccjh?=
 =?iso-8859-1?Q?imLBBcC+koC2mVQFLaY+7hSSuL76fdIFfaMlly3gHSPiMcWa46j17a0bQ7?=
 =?iso-8859-1?Q?dCYSKaSRtcz85DIqypRFM3DDqgnwF6CtXEQXw4IuDKpMn7TKtEHzO8RQ90?=
 =?iso-8859-1?Q?MKEt0WFrFsSwtlVX6ZG6rMq+P6xg7VhPPXwFGSEh0GtfW8u/46jONqzp4f?=
 =?iso-8859-1?Q?+52iZuqLvjNwxw34ZZuLtm/IPDR9sOgSE6crLg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BESP192MB2919F3C79FA633DBB40571C89C122BESP192MB2919EURP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BESP192MB2919.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdfac84-b63f-4470-7158-08dec0aa1a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 13:23:14.9080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P192MB3014
Received-SPF: pass client-ip=52.103.39.28;
 envelope-from=kiraly.tamas@outlook.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jun 2026 09:37:08 -0400
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

--_000_BESP192MB2919F3C79FA633DBB40571C89C122BESP192MB2919EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am interested in implementing sensor simulations. I already saw that ther=
e are some sensor implementations with varying details in QEMU. My question=
 is the following: Is that a good idea to extend that part of QEMU or new i=
mplementations should happen outside of QEMU and some protocol, e.g. vhost =
user should be used to provide sensors to QEMU? I would like to align with =
the long term ideas. What was the original intent with the sensor subsystem=
?

regards
Tam=E1s Kir=E1ly

--_000_BESP192MB2919F3C79FA633DBB40571C89C122BESP192MB2919EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Hi all,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
I am interested in implementing sensor simulations. I already saw that ther=
e are some sensor implementations with varying details in QEMU. My question=
 is the following: Is that a good idea to extend that part of QEMU or new i=
mplementations should happen outside
 of QEMU and some protocol, e.g. vhost user should be used to provide senso=
rs to QEMU? I would like to align with the long term ideas. What was the or=
iginal intent with the sensor subsystem?</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
regards</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Tam=E1s Kir=E1ly</div>
</body>
</html>

--_000_BESP192MB2919F3C79FA633DBB40571C89C122BESP192MB2919EURP_--

