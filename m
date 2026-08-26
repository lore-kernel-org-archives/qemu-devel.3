Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDA3C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHEv-00067T-91; Wed, 26 Aug 2026 13:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexandre.frey@nxp.com>)
 id 1wzGzF-0001aK-GQ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:00:29 -0400
Received: from mail-westeuropeazon11010067.outbound.protection.outlook.com
 ([52.101.69.67] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexandre.frey@nxp.com>)
 id 1wzGzD-0003bz-TT
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:00:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gz7qjjX82TjrvBfmZIVJA4LO/hzpozBE7JByzqjARkLDsGAT49kD7AS+O1203obsJsVdhFVBggiISfx33hTIRBBdvhJszraG9cQKPe2irFfhu/e8ghv7XmI5EKT/qClbUIEnYupysNYwZ4gcl8a6MgJMGwF2nYagY206KEsc27wiHFL6CT4QcOzf6SLckpPtf36zAgnoNn5P5+oeoYzzHczmNvCD8CeOlVs38CHVFvqaRXnVlhey3B5ZDU2vztudrXMjMmrc5pCYdeTbHdLB1w+o82wRTAEmcWTgGiq9+E9IEfo+c1SDgnpPsCUAFBb3pXHPlwpNX335/DItQxtWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPO6nfln6Q19R1mzLqR8/pWChIL0Kq0HCIZlMcHDygU=;
 b=bs8YTnenLSa91iKrV2Fy6oD7DTJDcr5/bjK0xv68rdOFR4a4qeyIf5LDsMmyDCUVZ1vPIJ4CsgGIi/yLX6O8D78OH3iLhsZP0GYnq1aBUBUtiuteYX/c7LaDiSep2mEi7zel43gWMyzW1vMRGMSRDKYSaLzklhfdBg76wBPy9P5WeuyKNGsYuZr0A51iWQkBOJ7wspCONNMtAQx0LST2B4MQWr8v9QD1//COX8sSCfOfXejmLAbBANwwPO8y2NmKsNht3iwLSGuNWoNY6ytTkVnjoSjNZfBFOTydZNQwjlrQ6pcpS/fxOZ9GqlE+2ZdZFJ3UYeYjsXaKNU6Tu22M0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPO6nfln6Q19R1mzLqR8/pWChIL0Kq0HCIZlMcHDygU=;
 b=MMPgR04xdKdIzHL09F0nt+umLR+T02rXhsLnOvZR1C/w1L0he0/Hznh6NFyLSK5qajj8x1ovgB72wtiRR/ocqBIRH660YsiSQqESpvYQKWbMZaL9Zfx6AdIBM2+i5td4C6oTaN3rx/Yq7x3t04pjOZ5IaesyTrsjDhOkRBw6TtIPBnLVw0J7rvp0cML6caDxSbQY2J6LJwuh3yDizaYoQ+USUMYdrS3Ym1Wux8PkJkFX7jCYoicNw3xHus7KPLqNp6gRULEN8gLdcrU2lJLd456bGj5USY5TwQ7WN33xcSV8eY0fZx90+NYoRDi3Kayw94UTnwqyzlEfQRnAGGET8g==
Received: from ZR6PR04MB442388.eurprd04.prod.outlook.com
 (2603:10a6:910:e0::14) by PA1PR04MB10913.eurprd04.prod.outlook.com
 (2603:10a6:102:484::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 16:55:22 +0000
Received: from ZR6PR04MB442388.eurprd04.prod.outlook.com
 ([fe80::e57c:ad6f:f66f:6ef3]) by ZR6PR04MB442388.eurprd04.prod.outlook.com
 ([fe80::e57c:ad6f:f66f:6ef3%5]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 16:55:22 +0000
From: Alexandre Frey <alexandre.frey@nxp.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH] target/arm: fix TTA instruction S bit for IDAU-exempt
 addresses
Thread-Topic: [PATCH] target/arm: fix TTA instruction S bit for IDAU-exempt
 addresses
Thread-Index: Ad01eSION6yidU7/RGey5oqH0pc/Lw==
Date: Wed, 26 Aug 2026 16:55:22 +0000
Message-ID: <ZR6PR04MB44238851A057F385D7EECEAD3599AE2@ZR6PR04MB442388.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR6PR04MB442388:EE_|PA1PR04MB10913:EE_
x-ms-office365-filtering-correlation-id: 299ee613-b897-45cd-4b4b-08df0392d16e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|23010399003|1800799024|10067099003|56012099006|6133799003|11063799006|3023799007|18002099003|38070700021;
x-microsoft-antispam-message-info: GfSoZu6JIY2WUh18VtIAQMhMarfwjrJSDLYB9jDGxmx6mmu191QNTNDtS/Ah4IKxqAnCEmEK7lc/JkZkUg6in2PgWY8cannU+vKPiB4Epz7xaVqy9KICPqP+GKQgzCmgLjlB4wBpEi/9rNOtOkj42nP3C6Ip6N66KjowvTb+mipa0z+q0NLccZk+EaVX+n3ywbOMtvIByWEcjR6IXyMW+GIpeTJGzaIulFuGJ6QzQ0/nxYA3zENoO6UdI4frZqQnjQnCzJx1NNcjAkw58SpwvhcZra05y8hJuNTlDo1pX708Z6UwhhYI0DyOL9supQM6i13QBrcUtDAvqaWSqkIFTjfv4hwHJVPPsF6JpnLncyA2CNKNCvM126gfnsJoEIUbxuHi2Y4C4KPb0O4lfi7/IrKxZmMhsTBoQ2Wh8ZQQcOLd01amkiuhjmPlZEm3z2xYUbG8ZUfAwiVutWDIme6Ee/uMPtPD4iGJCp5iMf5XFmzaQ7LBE0GgJ3eQOzWCOl3lESH9IuOnzssxiVt0vK00cho2n7LQ818Svp5dxSYs8ZW4XUKvEZeNKLyhPH+Q0SIDmQUUpXP3FSdsYAdw0hijckmSwqpy1kEgVSTEtcfcbkhXaMGyhmxI5sNBsl5rEUgYaXHAqix8TuyRWLU29UNTLLwvDC95OgS0K8E5wbf+vQwu/5rr8aeVf72JPL1wvTLzH41jkAFKILB79MtACMBgJDLWibq9GgaFd7SG4uyC8V0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR6PR04MB442388.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(3023799007)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tI82dQFn6HOeTEECx1zD2ClRGQp2rejWtBF/R9UMRDWPDHSoa0WqufIdDQav?=
 =?us-ascii?Q?iFDRlhzAuc65UjWgOMdzv2B/lZV6ejygBxfvON4/P/oz7uK7J5KXZArrGf2T?=
 =?us-ascii?Q?+JihIpWiF99srwDkASKlkibv/j/rveteMDcWujyx40TytgUXDM7L8+f6Ywaq?=
 =?us-ascii?Q?yK8zAAKFeZP6QWEhGRwAZxz3gBo6PHE+CX7d0ZoWH6TxbXYaVB8bz+AMUkWy?=
 =?us-ascii?Q?pA3YXNkutpUjSwzIIkCv/zLf4iBtR+6lxf5Hn2atDypSIG3/DKZcIhvxinLF?=
 =?us-ascii?Q?DGAphUK2Vif5dd1rFKg+vEbNpouJGgm534l4GKVsfdQbSKea4/KP/BrXtbme?=
 =?us-ascii?Q?AJV+6kWhEC3NL6IS/f5LUH5eT5p9caMpz/XG1aAJ07qWaTQ17GTUnyq4vrdD?=
 =?us-ascii?Q?ym3ClEjEjUTDIjsCbMRChuO+OheMBBjO2wFyUi4Fo8TNIhtu1vIcUrR1SJmM?=
 =?us-ascii?Q?bnXBhWG2DMNsN6epe12chsHzZQcnpTk2ucQEJr3jIUJt5+Ehz3PtxW0fVEH+?=
 =?us-ascii?Q?b4fhZpOIAUjYCkyIhurioVFgI0+6QNTRoxTpE7KGeTJoZtnYM2CN2pti9lBJ?=
 =?us-ascii?Q?BeUjSlajL3zBk5NUSEVm1zL4FhFV/bzdfXCobzrzTEtuedEoN7fHO8oyAx3d?=
 =?us-ascii?Q?d+XAvjjBRBik/3TPw8eRV+Es6ZsPclamCheDZuPUCqYF8+Hx/F1LzuP8myXx?=
 =?us-ascii?Q?xDLTTcFstZ8bk7gclwQKlU1/24zZcmuW2fpihV6BSIxHUPNb1wRDYldfumFJ?=
 =?us-ascii?Q?YHDI+RKauIcREcZctwx96tATIp9h/eZpxPV1Qj8Dttt7k8SIUwDy5REl4svM?=
 =?us-ascii?Q?98GcsmZwIjwP63V/piXsE7eeCUazYYiBkuH30RhRHLJAmN9NH8pYYR8sDBnq?=
 =?us-ascii?Q?yDYXP9DONLA+fGL6ZJBMt6B/XDj5Gsv9dngwUmOtqTtV3QO0qqu5Rm0WYsAl?=
 =?us-ascii?Q?+w8D3R1DztKRGxfP8CVmNILO4AqLnsYxvbfczMYUwgNlLQl6Vc1xGGGYCapE?=
 =?us-ascii?Q?hOvbLFJxd5j04P++j4a5L7ivyQzqNs1yD3DxiSdD7LhJaLiiWzRC+Ql5+EHY?=
 =?us-ascii?Q?dMqzhk7N+Vzml6FW1Oq7z7nSAUHkrhsMdFD0wZEb6iHbMevV2Z3UqpZjfctf?=
 =?us-ascii?Q?afmdRR/HdGb3Y138fKpA2v377HKFvnYpwzCJAseqDQ4ROc83MkrnHY109CXm?=
 =?us-ascii?Q?Rk/rusZxgVjR/5yO13r2z+0WK2FtbZoFB98Cbv/OFpx4sHeAwTqoA7x84Ims?=
 =?us-ascii?Q?E8K+U6xs41FdKI81Hrc0U7eVGy1LHg5sF06hnkz10JbbssDntOsSiNIexcYg?=
 =?us-ascii?Q?nCCZLUuptv2bJKlkUPc+peKulQIHDneC/s8RETrods2IoMWI+ENCEebpCv4w?=
 =?us-ascii?Q?Ch5W4t/7jO2uFePvCpc1tv2OIgf8HwVa1yD/O3V02Ht5KgPnvsv4mOpA/i4w?=
 =?us-ascii?Q?1DrNfq+QlBHiSPmgCGgaNMn+OGMueINqV6gmJlfb8gxcv6VN89I9pbRCllhV?=
 =?us-ascii?Q?XqUZTZdxirsVtEtxT5RlwMgWrvqNjCJkXjrOA+JBgCH/DF99TZCyItVjpe35?=
 =?us-ascii?Q?Lt4HHlcaotyadkzrkcUXe3kLc7oocSFCdrrLqnI+/XAgcwUAOU/quGmtGkrb?=
 =?us-ascii?Q?NMnKNZXcYgLWO0zrjeoXfWpQd6+XyjJQfVZZ287Ru0WkEEqQ56b/U5/xi/o/?=
 =?us-ascii?Q?ARQ4o1zvo8eazrTZWraT7ptiNWpaMOACUJIFcm4iR8lfty+XqCWk3I3DYlgP?=
 =?us-ascii?Q?MlTDRanRBw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR6PR04MB442388.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299ee613-b897-45cd-4b4b-08df0392d16e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 16:55:22.2969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppe3IFKmFaRmpsJmjIu9tlAKB3f12MXndbmmnCQXMbPztZMk5oGKtIli6y0322MLBodcSK+Rll7IfmGTK3iH3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10913
Received-SPF: pass client-ip=52.101.69.67; envelope-from=alexandre.frey@nxp.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:16:35 -0400
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

The TTA (Test Target Alternate Domain) instruction is specific to
ARMv8-M processors with the Security Extension (TrustZone). It allows
Secure code to query the security attributes and access permissions of
a memory address as seen from the Non-secure domain, and is typically
used by Secure code to validate pointers received from Non-secure
callers before dereferencing them.

The TTA instruction incorrectly reports the S bit (bit 22) of the
result register for IDAU-exempt addresses when executed from Secure
state.

According to the ARMv8-M Architecture Reference Manual (DDI0553B.z),
the TTResp() pseudocode (E2.1.408) always calls SecurityCheck() with
the current security state, regardless of the alt flag:

  sAttributes =3D SecurityCheck(address, FALSE, IsSecure());

The alt flag only affects which MPU bank is queried for the R/RW/MREGION
fields. It does not affect the SAU/IDAU security attribute lookup that
determines the S bit.

For an IDAU-exempt address, SecurityCheck() (E2.1.366) sets:

  result.ns =3D !isSecure;  // isSecure =3D current CPU security state

So TTA executed from Secure state on an IDAU-exempt address should
return S=3D1. This is confirmed by testing on real Cortex-M33 hardware.

QEMU currently passes targetsec (which is flipped to !env->v7m.secure
when alt=3Dtrue) to v8m_security_lookup(), causing the IDAU-exempt path
to set sattrs->ns =3D TRUE and return S=3D0 instead.

Fix this by always passing the current security state to
v8m_security_lookup(), as the spec requires.

Signed-off-by: Alexandre Frey <alexandre.frey@nxp.com>
---
 target/arm/tcg/m_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f4ba93b..12ec191 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2870,7 +2870,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t ad=
dr, uint32_t op)
=20
     if (env->v7m.secure) {
         v8m_security_lookup(env, addr, MMU_DATA_LOAD, mmu_idx,
-                            targetsec, &sattrs);
+                            env->v7m.secure, &sattrs);
         nsr =3D sattrs.ns && r;
         nsrw =3D sattrs.ns && rw;
     } else {
--=20
2.43.0

