Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E1FD185F8
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqGs-0002Vw-Sz; Thu, 08 Jan 2026 08:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGq-0002UH-GC; Thu, 08 Jan 2026 08:41:48 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGo-0005p5-Iw; Thu, 08 Jan 2026 08:41:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhZavkpjcd4c8mKm/MK7mhzDXCSKwq14Vc9qF04Noh4E8UvFL6pcFkaWOUMbOvVZh25/xaOlHrtjwLSu+4CZhmSMbluJVS44jQTDIYKPhgIHzuYVKIjaIjj9aQaZ3juJposVJsRqUcIlhNVe1sG1usCBJnZpD6Aeb3enk1Znv85Hi8ktQpGekWgbfCsr0doRl94LQLZqovjJTdmzphC2nWG+DMLSDRok4nxqOr1RSqaHjWnd/cFQAOCjZQJp/VKY//GyYolRkJPNQJdYuODIeM/9cF/23fWvLwDvnYYpKRdIkgqltzWjH4hOWowaevjMe2BthVFq2ZujUG7PltXfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCXdlYfhc7F0a1mXJOkRoT3XcQscip9kc+RGRfSLUWI=;
 b=iBkHMc+ePG3ZzKWmBFQJrtyQ99Jal8kycIVC79LvmZC+2GqZWTdJzejt5IR0yiJEylhoi54uY29Oc0aWzC81QQ2Zi+L6sp3S5BTk7LPmpFuk2kaBjn3Oo1YTJHy52Zv1gA5OVc3DVpfFLI/fNfaNPRFiSJ/fnAIAu61fd2eJEOT/5w2kV3gzCHGocMp4eo/Za5FvvhQpfYAqbPoFSKnu7+gXw5B9gqEo6q3pi0YDh5TvkudO1NpBFeJfGb86aWpJ+5S0+vgzjIWIhRI0V8yILH9vnbXv0mesnlwc/4Ha9kGx1Jp7QNVdzgQ4z4BYawrJJYes/5f0vKS+6ElYISbIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCXdlYfhc7F0a1mXJOkRoT3XcQscip9kc+RGRfSLUWI=;
 b=AwqdXQfMaRLnSvuw5l6ExJV2PT8hWe66Ow+iAY4NhAzajYzmQuR2XDwE27y59zdqbBa5yU1Xf91JfVMxBJjabaVvlgDVDuK8o5Tbf/MbSGMuGlJtHVGPpeUQzDMLHZX+sANIPVNRza9zh2+ZUPIK9tD2MLpRvDgE2JuUxwruPLKWg3QFdednai0IhMEfvtexegnN4SmlyF8U7ivR3VtXVL23bdUQvNCdOtI9xySJKoyzwRY7zpQoGJruHfq4WHVCT85nSpRTZRhhx6DL3LMLS/PNoZQ6ergeH3QoUpNlFUaUzeAHaFtqpqOm/29KgmLtNpuDS+gZ/JzldNKSlL1v2g==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM8PR09MB5226.eurprd09.prod.outlook.com (2603:10a6:20b:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:41:37 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:41:37 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v16 02/12] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v16 02/12] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHcgKSCaMj/Xq+/ok6kYIQzLCMGzA==
Date: Thu, 8 Jan 2026 13:41:36 +0000
Message-ID: <20260108134128.2218102-3-djordje.todorovic@htecgroup.com>
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AM8PR09MB5226:EE_
x-ms-office365-filtering-correlation-id: 3613e172-c26d-42ef-7b8b-08de4ebba527
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?73/UaUI9UItijE4N3ltScy/DGqVMxT6onqkmrl+aO0Q5LnqV6qRzWd5eTW?=
 =?iso-8859-1?Q?YVFTU0vPqLoxPiv/quECGsdm1q0R5YDpK2Ft8EQ1cG6Xy/DeyBG6O6QZSJ?=
 =?iso-8859-1?Q?JTIsi7jWxv7w8gYAwJsr+BWx2DvAmv8Z5adQDITAPsazgShnqgH08xdeD4?=
 =?iso-8859-1?Q?EjIpXHeTw9DmcMkzvZrwwdqvdeSEuvIZkCqQvH2o5tBmg6Ds66iIP5Cewt?=
 =?iso-8859-1?Q?pHBX+8pgFi0aQA1pV7xqDchtRviovSpN5WzP5ppmPLez1euYaCVROXitO+?=
 =?iso-8859-1?Q?/Qp5q1g2DQyIo/TW+YNRbFW0+Z3+Pkpza4PSMCE3tdMMl5sY7zGfOMobch?=
 =?iso-8859-1?Q?3E+REyV+EcWR+AiMlpLv2NTRjukWU+5L9F6dNSqTI81hrZaeCrQ3mx04Ut?=
 =?iso-8859-1?Q?IaQCa7K1+4DAq+dF9duqplKaSUMI9y+kxMUJLXkxyl8nrxdArMXIcAPOpM?=
 =?iso-8859-1?Q?IXPJgPL+0d7QFLUgil6NxvilnlWcndi8nBtGKgFOk+PtDyfCsZvYaRwD3h?=
 =?iso-8859-1?Q?B6Co03DxEvFn8DEn6p1jIFTS+9b+gjuPIeoYSaSZkK9bPy56Jw7apAFdnM?=
 =?iso-8859-1?Q?R0XoA13IGzX//S2bcDhDeHd+C3yxWRzmB2PPyRuh9+a9fbkdZVHIxw5sHU?=
 =?iso-8859-1?Q?ScXajcO5euWeRZv/tWcx1ZfgOfmCNtnOypRqohVTsEHGtv+fOfkwbvCAkK?=
 =?iso-8859-1?Q?A4o6uE8wVHIiilswHxUKK5LpV7Qvb8xy2knZ3BHWGSpNBG0Esq3UVer1UZ?=
 =?iso-8859-1?Q?dCq+kyCL7ZQDQsXYYewyhMU7IAwynujoTVlC713dyBooAWFoT/qNRy6++r?=
 =?iso-8859-1?Q?XtOdih9Mj40vGniH3m6i5gfcbG/EcghCYnqFGbc4B3Xkn2aPxTRL8HNx9p?=
 =?iso-8859-1?Q?MIBPWBbjsQOGxbHFNVJJFpRibz9Xkxh8MEDEGZes6Av+B4my1JjMzg0aVy?=
 =?iso-8859-1?Q?/FOqWKzWXRG9nam/o3TeHZfiBa8P+hn/9GyUurQxqF3fe7F3TW3Eu+EcLq?=
 =?iso-8859-1?Q?vPABGoA2347m7Y/2Xnwi6l4BP0Sv5wVuGaB6dcVpB+lA7Bd0U80gAjxTt0?=
 =?iso-8859-1?Q?ym13XhbJPJomkIIAN5SSXGJKShGM3V1CpKNeTw5j57BekpZuJ/a0nlHs4z?=
 =?iso-8859-1?Q?SXadTJYz4055WgI1YqDW7eeUMXlq+uWkQLMdsckqJSU5J2grEKHa5aNZZ7?=
 =?iso-8859-1?Q?kWyuj/qH4tikJWZorQlT6NK9pb2JCrfZCSBI+kMARaC7kJU70fslaDHonO?=
 =?iso-8859-1?Q?GeCbFtn0CSBlF1AKggDUuSuGWNigy2w8CLGYLsuOvyQ93vIqSOgsMN1Cko?=
 =?iso-8859-1?Q?tlbtIk01j543RUxfRY19DJycAOjs4BrQq7P8yMgxj8tFnQoiQf8I6uXtTQ?=
 =?iso-8859-1?Q?SxRTVsUq/Ksqswf9rRvsZ8njRWdkT0/JdFrmCvLZ3kZI9j9se3NLus6ipc?=
 =?iso-8859-1?Q?SVk8foDEIreMoad6TZ5ij3in+I8ZqlxszmmCdAxbFrQPBJ0leAb+A+0esK?=
 =?iso-8859-1?Q?Ac83YGw8/kqJr8gZYGxTOsWNNRENcWt/Fnt9YuFHnJmtK2ddfxfrt5F/GZ?=
 =?iso-8859-1?Q?YUROEAbbDuPUbsT8Fm/0KScGw61D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GM1Ylrx42I05jrLu2jzHweFGZYkmpKbrMzvtgaYVGbL/Q7cPCJQAb1I2Za?=
 =?iso-8859-1?Q?Iz28P2T7+vNBB7T9V2k1TYcOVKdlmrHyK5SPYZcSOLZWf9aapfizGwAvYr?=
 =?iso-8859-1?Q?/3RRZaAnwf8qIjmHL+r7mw/YW0+SSVbHS0UbRZ03r9ywu2/M5CGxzdNq6z?=
 =?iso-8859-1?Q?ySIRap6/qKcjG/tUccUYjCOZtbR660TwKlO0K96e6c1sFGEeEjT6i42Ptk?=
 =?iso-8859-1?Q?SRiNOqKOsIO1q4ii6eSIGPxav/iCOGHKAkPfxkQKiBmzfUoSmkKbLQlxa/?=
 =?iso-8859-1?Q?hti6Pt+uvcU+eR5F5/dM6nN46Q5DkUHl799WE6dbCWNapEDzb0+qfGvrjE?=
 =?iso-8859-1?Q?LqbB80GzE8b/GjK6TSw3V86ugrPpFWZ7UQGe+PaJb86tcZCX5toA9gd3Si?=
 =?iso-8859-1?Q?Tc2dkLAMqc+4uhuCaoJmrVMsdmmK37VCNVGW5N6kXm/RuE8bEJOo8Yx6aC?=
 =?iso-8859-1?Q?k4amnUU9O/AeqWOZqu0RpUhn5txO1yWsmkLYgv7KZSrLeSn1x5mh+oKxWS?=
 =?iso-8859-1?Q?Qh/zZzUNx2v3ylkTCrTjmnWP1CQZk4r4QtmS7zXJovJitEDpFcKLKutJAl?=
 =?iso-8859-1?Q?8C94x9iqV3b92X2tZOpo+lpzOGn4KoUyvtczennVXzPj+gW5Y1v4Sf9DnE?=
 =?iso-8859-1?Q?eKHglRpAaRoZqVknRIXLUimbZqaDxgwO/i3hNVjMAiqlSW/aEG18VhzjC8?=
 =?iso-8859-1?Q?m7b/XZbykLDklckRtPFAn3G25FfxatSmvV/oEjb6UGRNIx0Wmj7strHa/c?=
 =?iso-8859-1?Q?WF4wyKWgWODEVY05iUhiwnDsA0pB4gD+8Z2bCR/a1SzY9nmLKpGvVAOncV?=
 =?iso-8859-1?Q?aoGVcLEmPBy1ppDpUPIr4MBLT6++jE7apnQEqIFHYtYKs8Lo3m2JSTMjor?=
 =?iso-8859-1?Q?uJ3Swjs90C1WscUIB01LlvdOoU5P6A8IpPsOMb0XbUXiroTMhhTdQjnMoa?=
 =?iso-8859-1?Q?xkst2PO6M7+51MhXiWivn2iGdrV/Vymr5Q73+oBMFcbbfhE+oB1eZUykTt?=
 =?iso-8859-1?Q?ufT58ekmRRBjINap/knkAq8i6vPpV/mIDsM6LVWM5j24KJZI83afPre8KH?=
 =?iso-8859-1?Q?RVdctafaghxJdHf5s600z4p6v6CRBCO0J3bWuNxrLJEzOM/GtZ2Rrh7+50?=
 =?iso-8859-1?Q?ugIAEcEXiZenrZH+GE3pAF/lOVX8qpSA1QViGySFEyUai4lvbpn+RtAhTd?=
 =?iso-8859-1?Q?oM8r6umd2gypl9rVlLlUreQrNLvR/qsQfiO9r0Gg98QV/dko1vM7NXL4US?=
 =?iso-8859-1?Q?pqRT6yYssANk0wSig9yb/CkvULSsyYiZ4wmkVany8ZvcVsNQx1EMvePsQ9?=
 =?iso-8859-1?Q?F2fqtyOFr8Tv5TgDRgRGSQ/rKfy5LTZIdtd6vF9f2kVa9RPC42Ot6f3exs?=
 =?iso-8859-1?Q?mUEsQRUkBs1Cb53yf3lhKbyiQbyBQGEF/QERstPCkfbNEyLIWV7fsI1JrV?=
 =?iso-8859-1?Q?MfgHeXFxWxt623cxt4Dwl4ah4PJc4TtBKmwHbO+rmIVtSZgznQynxM+d2i?=
 =?iso-8859-1?Q?h7TbPbc3K+2ueIBU1u31FJaUzCNvNlvHJnPJeuyd98SCOZlskuaAz1XoIZ?=
 =?iso-8859-1?Q?dRQIYbF0arPCrT0wYzDRhpLh8Impg45DsDNbxyS/4Beu9izTvTII2w1/Da?=
 =?iso-8859-1?Q?fYMbMOMhbW1DfyxoqwBQRjphuGuSdZ0kPMx9N1g2Pq5gjuqZX+w/b1ry5b?=
 =?iso-8859-1?Q?xUgIxV3WsBQ7IiBas6eLFDVwkIqfTDn9P829RQMPRO8okIDpwAodd4zUlW?=
 =?iso-8859-1?Q?O7Xrh8ehO5vBjxD3Usl0pvLwtIKRc4ZUa1OpDxmW1kcrIq0lVFjwY96bnm?=
 =?iso-8859-1?Q?YsCNp0LO+ileQDvXgfpbst+rYfNDLjroRzIAE/pl7i3iDtnUQqlK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3613e172-c26d-42ef-7b8b-08de4ebba527
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 13:41:36.6035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDbOQTBbmhhdtPRQkUsC0S8TQD1FGHhAn3n4hpqdr4HkaVGe04rZE1FMrczKoKqfAvva5XZUMowOnVd7fvPW0Lr6y2WjFk6jR5eh5ebDdA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5226
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu.c          | 16 ++++++++++++++++
 target/riscv/cpu_vendorid.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..30dcdcfaae 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -56,6 +56,7 @@
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kun=
minghu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 39f2336a70..f144107c89 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3322,6 +3322,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV48,
     ),
=20
+    /* https://mips.com/products/hardware/p8700/ */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+        .cfg.mvendorid =3D MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..f1ffc66542 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x127
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

