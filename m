Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958C5C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdmR-0006rX-PQ; Fri, 17 Jul 2026 04:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdmQ-0006qo-2S; Fri, 17 Jul 2026 04:18:46 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdmM-0000Cy-75; Fri, 17 Jul 2026 04:18:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkMTaauT6d3UDMharjatAqg+bBbQutxyZMNUzasnrBUfDHDVnfXcmMiOoyfYGJapWZ0ci0bBmaEJQ2glW68C1NrDwRykxMUdvpEm9/sUbvKZzq1MA57fdGGQWcf6JoZ+rMkuK8+zha+bQe7IYQE/s+ZKts+c15LpyzPLPZOkLEAt+o5IsEiWMTjARKSIua+4Iwt2pXClA4cY5d9MbdYNrXyyDA+aE4MJMaDIykrGQteeBNdyd7DCsRUevyQXbw6aKb4YJ6MjT8oiZe1TbJ9zU3F/BRmIio+SOF+FrM3WWSaX4e11SnqohXlCqAld20o86RbiC0YAtL2+zQSdg12IkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08UIiginG1nL5wq+OdaaIs8PxlwWCdsb3XgO18Lvb58=;
 b=eqNIInI4PdL6lwwH9c7aBBAtnqGnyZfI363xmVsGCBs+B9TBd16D6nHdH58s7vFZOOA4wVNtHZX1l/9kbAAwcWOSATmaAoqzHLjTCx24+pgp/ljz1WIdqF0F7hL++bNkfxsMOYSedqScv9vHiMoMQLn657axNe/ewbOTDhOUjdaMNdAn3DPjqaM0gIe/LidJGQtiqa/TRswdQyli6/cz6mnFYz1mbkPNXm8M6v2h8y/SvWIKsDhD0FYJmgV3p/GjMCf1zBEmOvvS86pKgpd5vNcmYMJJVMQ1dJGOrcuAkfpN6jHI40kKsi5CZMBV30aAd0ip3lIV72chTQ5vgIHNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08UIiginG1nL5wq+OdaaIs8PxlwWCdsb3XgO18Lvb58=;
 b=dg9D7PXFUtHreC3fe5JBZl02hLTEXF4UWZK6OlPIlByC6bzH0argIZQUYzSvFuBiC7gcrH3JVTm/FEfB1Q13rMwVpBmhY93s7LqbxxFAF3mCnU91FcIjT3RbzoCnnd/UJNPywClCrzR6YHiezOEMVi1RdreQuzJqjicMA4UVxLx2YfrFvXQjW8fDbbzry41Kz/K+kn//OsB09iLCxgWaZnXb+OSzB+Pe3eiZ+jaT9dQmM0Gp2pFITzN9yF3DQDaOoD07kfClZcy6tDsp2T7VDY4dt3wVyqj5S4aEH4UF9nIiB3friX46CKkQ6/4bp3t+2YgLO27KUYhT0Ub3/v3Fxw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU4PR06MB8339.apcprd06.prod.outlook.com (2603:1096:d10:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 08:18:24 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:18:24 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 8/9] hw/ssi/aspeed_smc: Add Data FIFO-based flash access
 support for AST2700
Thread-Topic: [PATCH v3 8/9] hw/ssi/aspeed_smc: Add Data FIFO-based flash
 access support for AST2700
Thread-Index: AQHdFcTW67ZkY7hwlUmpHTorI2N5jQ==
Date: Fri, 17 Jul 2026 08:18:24 +0000
Message-ID: <20260717081813.3407862-9-jamin_lin@aspeedtech.com>
References: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU4PR06MB8339:EE_
x-ms-office365-filtering-correlation-id: 47651c2b-6ab7-44e9-b352-08dee3dbf8cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 0fG7lUNdGKJVBIEpF35qf37a2wZXJxM7d2aHIGLUfqqXPUyWbAXjgUTSyv9uFvX1KeN0fk6oJsMvambwk/HazH2BY9EYSH2NyjFZA2WS6IMasSJY1J4QBNxB3KZZViYvwMD1g28UIHtJ6B3UYEcwTOl5qoxg56t2nLpCLLLO9+tOPhBWS8K4CWVmzRVXsIBqNsj+UmNZLJ3+MP+J+TJKDDoCuvrvgnaX+wM6ppkQQmUKP9kh9R4WfsswaTjVzmQKWMyN+x1c+lTUBMoA3q53Y1GKPGwj7X/unoSLehDGJZzLIj6PWlLPt6mNIIRM5BPE2pnfsOZ3q+yuBJamJNFpvsAkMgVqnb+qxbuHzjoU9J+ebQCHNubGCdQP6VUcxPPUg59yFg5bem7vbMr/Cb/V7SjJpnQ2NGPw4v+PGa1maKiCVLzQq2KNCoGuYQgIhX7vMHM3GHjUE8I/snP9lb4tITyaDhOAV1T4oYkOYqFfpFiFAX9ytvqRoHLjFzcdYVY/Cb9GUhHKLsMEZVBIxm93e6V0LgdI5OF2s9cVrg3x2Iqs9wMKaO4x0OPPmKnbKn/PbJvYnk8dlv/0aGZoZJNeMMVJXFbfgPeUb7F2ohdwcmyWhhcZn90dXER5F3nI9ormRAgawdzavALTAwNV/dXBBlr10JukkOyJwa5LmXIoyejHNAin8lOgJpsu2RLQd0OMq8juZnnEKPsWUBKsFL/stIwbOhD2IIGwKZMMnfsbIuzUEj3reapjNpxmc1is0kh4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q+cWa+2Jm7KcUUfz8I/bw1JHBDDU4oinNaLwLm9DQ+UHkFpGod2K+TUj2A?=
 =?iso-8859-1?Q?bdx1IRHT513s+DWuoKoovvZQtPeWnv1d4furstfajgKwPPraiclecUmSl7?=
 =?iso-8859-1?Q?9RSBsZJ6H1cQhn6VIPulmPpINeQqHlET81kXsNY7uRgy9ufrqzCiGdmgC2?=
 =?iso-8859-1?Q?SlEtm3pbY0HH7KjK3K71eaVIIbydgFYlifKsAJ6AQfTYMVIJnII1YJCDoh?=
 =?iso-8859-1?Q?MTDn0a0L6Ws9uxxebdBqQi48bE0KKkTXPWgNK+Dq28TbAfQ+Pwf1JyQ0aW?=
 =?iso-8859-1?Q?GyN4HLnJfixzZFzzKnFm6PazOuFeVN1mvcsvUImrvSPplxEmnyUkd/+R9S?=
 =?iso-8859-1?Q?ZITlBnlEwGySTiEXRFjFi+myThr1KK35BUemH9WYkr+Q8PbhT/768PT5E2?=
 =?iso-8859-1?Q?mDplJba+ZErbh8p6cngxGuwzwNd8P/bsqL1aWu4ij0xbxyhTeI+7vDi2Ov?=
 =?iso-8859-1?Q?QmQgI90AtPIGthOFhzbyyXW76AaaPvFO3n8gaAwTCo5D6ohgT+8G6xpP8L?=
 =?iso-8859-1?Q?UH/d+kCmcc8kBrhU2vzkT57ecNn8KOVlWbcSiRUXDj0e+TVZ9fpjYNTz2j?=
 =?iso-8859-1?Q?nXLaI8P+TXlqYqjHyc3gUZPg9yrs7UjMe7FKOJphIcsYrwBX4j3v/emBYk?=
 =?iso-8859-1?Q?feszjr0b6uLhWKJucg7Z5oFMULReztmStyQBWAn6cejezvsQo91u7LQDC+?=
 =?iso-8859-1?Q?AItAZYtAsYrhJ7JoULf0oOHbKn8dNiXm9LUr52GSGqo9qOruOc/sHMIHy9?=
 =?iso-8859-1?Q?Z6R3vxFpdHOXMil2HerDuoA51oNmMQVKyQnJYjGTPuErYByzq4yU4pFljM?=
 =?iso-8859-1?Q?r2dAUx6qLrtFRY8mez4O9V5opIVe19E0GzXkXWH3NHEktsYd9th4aNF61M?=
 =?iso-8859-1?Q?goea5vB8bXDMa5CxbaVwPsVjQxMqR0nSfZ9CIuzBkUeE51PIWzILUmQxPj?=
 =?iso-8859-1?Q?A2E2Pydw+CgbJl8Fl0dTIYhVAY1ISiblAK6fMTx/l7KEcgRGl/nNX5OQDL?=
 =?iso-8859-1?Q?UzGfN1iL3YxhZ6KqN++2KVF+lBRE+jKALTkkdqWtq49F+Ma0bmrkKpxJe3?=
 =?iso-8859-1?Q?BVpopM0pZezE4dqoJid7d1Si/lmVYOtpz2hhQ1u1RZeZ7Cgi1tZ4hhXDzn?=
 =?iso-8859-1?Q?Yab9eHFBePAmyBubJ00YSaPeiMRu/NLVTYD2pewAkuuOjA8Cp86FhrNgv7?=
 =?iso-8859-1?Q?Bs62yANaD6htdEXCedcAt8bwJ56CN9/8n8I/6EfUh8x2gRL7NSXb33ZmvK?=
 =?iso-8859-1?Q?5A2vJa1tCO+53RrJsc7SirA+s1G+2kQbDGJiRfQ/IIcEAtcUbsFEy27wOh?=
 =?iso-8859-1?Q?hE3MAAzjJSlx4xzEHOJXzIJrU34ywSYtiMV1vNTIwGuRGfQEEV4TDIEmHj?=
 =?iso-8859-1?Q?Dwzl7dS+V1vhfhOBtKDysUJfn+RKL67XS7aR/CT5GEQIcSQweFbgGcQZ/v?=
 =?iso-8859-1?Q?3FveAwPXl+B7G+T85wpU4K8y6Dc55ECYBjBpZjCZLKakpD6Es8Rkl7KCUN?=
 =?iso-8859-1?Q?zPYcLeyKlWzR8j66VbShxIr7eEhfqaGCyX07u/OVCRTlAMuR8x94OY3Qf9?=
 =?iso-8859-1?Q?OhmwNnyZqC8FfaUX7UIXRP0O2rhCKkl7HSzAsOkYN401PzHOQQkVX2dMs2?=
 =?iso-8859-1?Q?PMuM4YE7myYkV/OT+Sf6hEPOV/Il04+hvjOk8t2O2s3Oxj3JBgQqovMU/E?=
 =?iso-8859-1?Q?1dM7DUC8EPXRs3p/l0X6vnNyp4flEz2UqsDaXcGvtjRTs+IEXBMC0uv+n7?=
 =?iso-8859-1?Q?OYkhgAvqWSqNHbdJlx58qnXyZBfRegSsh7l8X59yCWEOOIgg1OGKyRDi7p?=
 =?iso-8859-1?Q?uihdCdA8bA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LqUOY1WlZ0HGRQ1oG8FOiteTZ5AmR9BwZ0PkDcGwWGLeO0ujQGsfxAT1XmMC8JAkvlgWdng5fPxLMVka0LuTqpPVA2GXLNLxFJisO3dB8bw2zF8g75KV2drULZPVAbPAe3OgM2drLhbrkPTsuAS0RpVRAghRIqQirRTKEnoO1z4emcB0SXyPlO8UbFeJNfqAAgcg7MsJf1x9QmD6TE0/O/Ln8OLE2oLamcw0w3v2SW0tUnOv0eW21aOEhHEMXcgcYlykzlkz5T4KTvjapbfKX7SeglMFGUJ4lvu8pSQguWCzVA8bmUFCvNjCy2/ZcfAqSm384TyR7bjBEmCsOForvQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47651c2b-6ab7-44e9-b352-08dee3dbf8cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:18:24.4349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymrJfs3eEsKQH+oAhaJPqG6WAiuXDdU1dKFTxaX95UhFUI4/Rs1QwRNeJObPS1MGldxMQHIDsd6/jLafX/+JINFp/1qitd8XxzKAXXaKVXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8339
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

AST2700 supports a Data FIFO mode where flash accesses can be performed=0A=
directly through Data FIFO MMIO offsets. The Data FIFO start offset=0A=
increments by one for every 16MB of flash address space, allowing the=0A=
chip select (CS) to be decoded from the Data FIFO offset.=0A=
=0A=
This change adds Data FIFO support to the Aspeed SMC model and introduces=
=0A=
a class callback to translate Data FIFO offsets into CS indices. For=0A=
AST2700, the Data FIFO offset is matched against the segment start address=
=0A=
of each CS to determine the target flash device.=0A=
=0A=
The SMC register region size (nregs) is also extended dynamically=0A=
based on the number of supported chip selects to cover all possible=0A=
Data FIFO regions.=0A=
=0A=
This breaks migration compatibility with older QEMU builds for the=0A=
affected models, even though Aspeed machines are not officially=0A=
covered by migration compatibility guarantees.=0A=
=0A=
Bump version_id to 4 and minimum_version_id to 2 to reflect the=0A=
incompatible format.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/ssi/aspeed_smc.h |   3 +-=0A=
 hw/ssi/aspeed_smc.c         | 117 +++++++++++++++++++++++++++++++++---=0A=
 2 files changed, 109 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h=0A=
index a273365689..5f391fc24e 100644=0A=
--- a/include/hw/ssi/aspeed_smc.h=0A=
+++ b/include/hw/ssi/aspeed_smc.h=0A=
@@ -47,7 +47,7 @@ struct AspeedSMCFlash {=0A=
 #define TYPE_ASPEED_SMC "aspeed.smc"=0A=
 OBJECT_DECLARE_TYPE(AspeedSMCState, AspeedSMCClass, ASPEED_SMC)=0A=
 =0A=
-#define ASPEED_SMC_R_MAX        (0x100 / 4)=0A=
+#define ASPEED_SMC_R_MAX        (0x300 / 4)=0A=
 #define ASPEED_SMC_CS_MAX       5=0A=
 =0A=
 struct AspeedSMCState {=0A=
@@ -114,6 +114,7 @@ struct AspeedSMCClass {=0A=
                            AspeedSegments *seg);=0A=
     void (*dma_ctrl)(AspeedSMCState *s, uint32_t value);=0A=
     int (*addr_width)(const AspeedSMCState *s);=0A=
+    int (*data_fifo_offset_to_cs)(const AspeedSMCState *s, uint32_t offset=
);=0A=
     const MemoryRegionOps *reg_ops;=0A=
 };=0A=
 =0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index c8cc6cfa56..bf596f7b2d 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -163,6 +163,9 @@=0A=
 /* Read Timing Compensation Register */=0A=
 #define R_TIMINGS         (0x94 / 4)=0A=
 =0A=
+/* Data fifo */=0A=
+#define R_DATA_FIFO       (0x200 / 4)=0A=
+=0A=
 /* SPI controller registers and bits (AST2400) */=0A=
 #define R_SPI_CONF        (0x00 / 4)=0A=
 #define   SPI_CONF_ENABLE_W0   0=0A=
@@ -209,6 +212,7 @@ static const AspeedSegments aspeed_2500_spi2_segments[]=
;=0A=
 #define ASPEED_SMC_FEATURE_DMA_GRANT 0x2=0A=
 #define ASPEED_SMC_FEATURE_WDT_CONTROL 0x4=0A=
 #define ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH 0x08=0A=
+#define ASPEED_SMC_FEATURE_DATA_FIFO 0x10=0A=
 =0A=
 static inline bool aspeed_smc_has_dma(const AspeedSMCClass *asc)=0A=
 {=0A=
@@ -225,6 +229,11 @@ static inline bool aspeed_smc_has_dma64(const AspeedSM=
CClass *asc)=0A=
     return !!(asc->features & ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH);=0A=
 }=0A=
 =0A=
+static inline bool aspeed_smc_has_data_fifo(const AspeedSMCClass *asc)=0A=
+{=0A=
+    return !!(asc->features & ASPEED_SMC_FEATURE_DATA_FIFO);=0A=
+}=0A=
+=0A=
 #define aspeed_smc_error(fmt, ...)                                      \=
=0A=
     qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## __VA_ARGS=
__)=0A=
 =0A=
@@ -664,6 +673,7 @@ static MemTxResult aspeed_smc_read(void *opaque, hwaddr=
 addr, uint64_t *data,=0A=
 {=0A=
     AspeedSMCState *s =3D ASPEED_SMC(opaque);=0A=
     AspeedSMCClass *asc =3D ASPEED_SMC_GET_CLASS(opaque);=0A=
+    int cs;=0A=
 =0A=
     addr >>=3D 2;=0A=
 =0A=
@@ -689,6 +699,18 @@ static MemTxResult aspeed_smc_read(void *opaque, hwadd=
r addr, uint64_t *data,=0A=
         trace_aspeed_smc_read(addr << 2, size, s->regs[addr]);=0A=
 =0A=
         *data =3D s->regs[addr];=0A=
+    } else if (aspeed_smc_has_data_fifo(asc) && addr >=3D R_DATA_FIFO) {=
=0A=
+        cs =3D asc->data_fifo_offset_to_cs(s, addr << 2);=0A=
+        if (cs >=3D 0) {=0A=
+            /*=0A=
+             * Data fifo mode only supports SPI user mode.=0A=
+             * The flash address is provided by the SPI command/address cy=
cles,=0A=
+             * the MMIO addr parameter is ignored.=0A=
+             */=0A=
+            return aspeed_smc_flash_read(&s->flashes[cs], 0, data, size, a=
ttrs);=0A=
+        }=0A=
+        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr <<=
 2);=0A=
+        return MEMTX_ERROR;=0A=
     } else {=0A=
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, addr);=0A=
@@ -1063,6 +1085,19 @@ static MemTxResult aspeed_smc_write(void *opaque, hw=
addr addr, uint64_t data,=0A=
     } else if (aspeed_smc_has_dma(asc) && aspeed_smc_has_dma64(asc) &&=0A=
                addr =3D=3D R_DMA_DRAM_ADDR_HIGH) {=0A=
         s->regs[addr] =3D DMA_DRAM_ADDR_HIGH(value);=0A=
+    } else if (aspeed_smc_has_data_fifo(asc) && addr >=3D R_DATA_FIFO) {=
=0A=
+        int cs =3D asc->data_fifo_offset_to_cs(s, addr << 2);=0A=
+        if (cs >=3D 0) {=0A=
+            /*=0A=
+             * Data fifo mode only supports SPI user mode.=0A=
+             * The flash address is provided by the SPI command/address cy=
cles,=0A=
+             * the MMIO addr parameter is ignored.=0A=
+             */=0A=
+            return aspeed_smc_flash_write(&s->flashes[cs], 0, data, size,=
=0A=
+                                          attrs);=0A=
+        }=0A=
+        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr <<=
 2);=0A=
+        return MEMTX_ERROR;=0A=
     } else {=0A=
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, addr);=0A=
@@ -1183,8 +1218,8 @@ static void aspeed_smc_realize(DeviceState *dev, Erro=
r **errp)=0A=
 =0A=
 static const VMStateDescription vmstate_aspeed_smc =3D {=0A=
     .name =3D "aspeed.smc",=0A=
-    .version_id =3D 3,=0A=
-    .minimum_version_id =3D 1,=0A=
+    .version_id =3D 4,=0A=
+    .minimum_version_id =3D 2,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),=0A=
         VMSTATE_UNUSED_V(2, 2), /* was snoop_index/snoop_dummies */=0A=
@@ -1808,6 +1843,39 @@ static void aspeed_2700_smc_reg_to_segment(const Asp=
eedSMCState *s,=0A=
     }=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Convert a data fifo offset to a chip select (CS).=0A=
+ *=0A=
+ * Data fifo access starts at 0x200. The data fifo offset index is=0A=
+ * calculated by subtracting the data fifo base offset from the MMIO addre=
ss.=0A=
+ *=0A=
+ * The data fifo offset index increments by 1 for every 16MB of flash addr=
ess=0A=
+ * space. Each offset step therefore represents a 16MB address decode rang=
e.=0A=
+ *=0A=
+ * The CS is determined by matching the data fifo offset index against the=
=0A=
+ * segment start address of each CS.=0A=
+ *=0A=
+ * Returns the CS index on success, or -1 if the offset is invalid.=0A=
+ */=0A=
+static int aspeed_2700_smc_data_fifo_offset_to_cs(const AspeedSMCState *s,=
=0A=
+                                                  uint32_t offset)=0A=
+{=0A=
+    AspeedSMCClass *asc =3D ASPEED_SMC_GET_CLASS(s);=0A=
+    uint32_t start_offset;=0A=
+    uint32_t fifo_offset;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < asc->cs_num_max; i++) {=0A=
+        start_offset =3D (s->regs[R_SEG_ADDR0 + i] & 0x0000ffff) << 16;=0A=
+        fifo_offset =3D start_offset / 0x1000000;=0A=
+        if (fifo_offset =3D=3D offset - (R_DATA_FIFO << 2)) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return -1;=0A=
+}=0A=
+=0A=
 static const uint32_t aspeed_2700_fmc_resets[ASPEED_SMC_R_MAX] =3D {=0A=
     [R_CONF] =3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |=0A=
             CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1),=0A=
@@ -1842,6 +1910,27 @@ static const AspeedSegments aspeed_2700_fmc_segments=
[] =3D {=0A=
     { 0x0, 0 }, /* disabled */=0A=
 };=0A=
 =0A=
+/*=0A=
+ * AST2700 supports data fifo mode with a base data fifo start offset of 0=
x200.=0A=
+ *=0A=
+ * The data fifo start offset increments by 1 for every 16MB of flash addr=
ess=0A=
+ * space. Each offset step therefore represents a 16MB address decode rang=
e.=0A=
+ *=0A=
+ * Assuming each chip select (CS) can use the maximum flash size of 256MB:=
=0A=
+ *   256MB / 16MB =3D 0x10 offset steps per CS.=0A=
+ *=0A=
+ * Data fifo start offset for CSn:=0A=
+ *   0x200 + (n * 0x10)=0A=
+ *=0A=
+ * Examples:=0A=
+ *   CS0: 0x200=0A=
+ *   CS1: 0x210=0A=
+ *   CS2: 0x220=0A=
+ *   CS3: 0x230=0A=
+ *=0A=
+ * asc->nregs should be set to: 0x200 + (asc->cs_num_max * 0x10)=0A=
+ * to cover all possible data fifo regions.=0A=
+ */=0A=
 static void aspeed_2700_fmc_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -1861,14 +1950,16 @@ static void aspeed_2700_fmc_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->flash_window_base =3D 0x100000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -1896,14 +1987,16 @@ static void aspeed_2700_spi0_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x180000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -1930,14 +2023,16 @@ static void aspeed_2700_spi1_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x200000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -1964,14 +2059,16 @@ static void aspeed_2700_spi2_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x280000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x0FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

