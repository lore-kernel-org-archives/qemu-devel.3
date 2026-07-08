Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F748C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOST-0004B9-Mq; Wed, 08 Jul 2026 05:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSQ-00048e-AY; Wed, 08 Jul 2026 05:20:42 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSO-0000N4-T6; Wed, 08 Jul 2026 05:20:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIk4vfND5GNGVAarxeqrl692QubkeWFKk9WnO3XhwQHO0PBf+vT+IQkSbj+se8vXjOpH1a9i1Nyu6ogMFqgRx64ssHRcKYPhgOhhqV+bS0gEVsZQM8UJ6zA2JbJQjiYi1ZtuAgh4kS+4SdNvVvohiRQKUuUH5TgiFo5w4OXiNWm0ilkmXThOIbhk76YC4FD2YJgZnKFu7PGCeORpTxGEvNn1eruu3E8EZhluVlNDyb5F0XN+ia6ox02q11xkq3M5QOQiQSXsW0N++T2C+5XU0fq/rTz8aGQfPj97AaPIiH2OclIXdHpiTsIWxuFgac2zzpE5rcii9e8XZj9e0xrh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSI5yKpcG5qkdNusNG4mzDjuXKJOit/QYcyY3O4WDaI=;
 b=umaHUrKDmykf6RxNFCeopMJB4Qh3PJwYew4QgEa9CSEr2swv2yT4q0Gao2iKzRTkwi/q0Scj7GDmIiuw596PbSiZ/kuLcDj8B7vFtap8y+1Od0acGyCP2+Od+hnRdEhl2NcpTcr/Y6RvEl+HMZPmtpE5D1gfwsxjI426GGMxzMGZlrOCMJVVa1WeOvOTb7J3Q2gI35KjSSnv6ObiIYYv7bmeWtfkmm6qaQ/Ur+kxgapYIK9SKbCN2fgh7zEK94CRSe2ovQ/X/1UEmbg0l4wBIQq3RQ+Xlsyh7WmAmXet2SieIB+FpkwGf+VSK8aRHXGqsJ+V9tvZhVW5zceflFnmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSI5yKpcG5qkdNusNG4mzDjuXKJOit/QYcyY3O4WDaI=;
 b=TrK2t+bONodbK/KVBRGyspSuaf9Ijx3B5woluoo3ekyxhZ1UEGaoUg9m6ZhWHJcbdIUD+HP6oRDkMgh7968m2rnKpR1jSte+fg30ouYcefTUKe01X1yutM2XyVZ+wiP5V6MBLXzgPo9+n8ZyUrTHJNKng7fQE+gvz32Qgkc5U2tBAI5Owxgli25aZMa6sI8O7ai5CtOYJwxhE+HgRycc4Bgx73ySfGCYfbECxha+2taaXHSk683koST85faX/L4jeyWDOnNPz/l9v6N8Op5r5NtfSalpPYfsTNDMsJgvVdOODRQcpODO/Cmp+LaRU7Vw4SLff8Vsi/yXBUZL1gbndw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB6311.apcprd06.prod.outlook.com (2603:1096:101:13a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 09:20:27 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 09:20:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 02/10] hw/arm/ast27x0: Start TSP in powered-off state to
 match hardware behavior
Thread-Topic: [PATCH v5 02/10] hw/arm/ast27x0: Start TSP in powered-off state
 to match hardware behavior
Thread-Index: AQHdDrsDdM4aXwddqUmi7MxGdtdIog==
Date: Wed, 8 Jul 2026 09:20:27 +0000
Message-ID: <20260708092023.3826159-3-jamin_lin@aspeedtech.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB6311:EE_
x-ms-office365-filtering-correlation-id: aa6eb795-f0ff-4aaa-c317-08dedcd22632
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|921020|38070700021|6133799003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: 1CnIC4jaMVmyzuMRawuyFUo/zcpIi5NFt84O+PQo5cTNURWCSdVOB5xzYTOdpPRSIYJ31AThSuYqf51MU8DFLJLR7qXNmHSXO4+EDqybuXSa1heJMg9W1HW1HLY3WjL1DWcfVHnKAS3uCoha4Dtk7yUYZxSrWGLeKvm23KNjT4b1bGUZ4TPC2q7+nUls0lsyPIBvpEqsoaUdh8foR0v8EfxcLLETVuMBo8JFYEpcJrfcM2nOhOSnfDYK1pM2petzrBHin5lKG+O1/LDN+1PmURSkhuZYw/0FIeF9LXuNQ29Qd5gl6OPPISi2jzRBSmCZS5uqk3yIfRC5r0inMAPhCuXGjQ9VFfycf06pFgnDSWimB1H1dwiANIJq9F43SHKjYVF8T+P+X9QQrUnL+RoM8Mb9wGVUwYe8xeZhfkCpdMAL+bDbWDLj6BKdwTKlH+MS2OeNA2QWIV9fctKZYSi7Os87QYp5MhqdcAIHJaWtAuYhL1g3ZzViYd/r64H4eTftjSo+n99LxfUAFUD5ibWIscOt/yQGVta+T2jYKfb5DbqXM3YChz5QaKG9sRHvsQuuJe/z7p1IsL6ilru2hGTGSZXheWUD8A9L7CcuB/t/NXllcOGhTY4VnLb6AI8hm3mOdFVZU2uxPk6wQ58sj7FsWbRcFXliaOYE2MLvD8xk221Oo9MSPM6/u8q5HaiiXiwEF22LmgoF0CH2nckkSMRr8YbYDaDOPr1V5s3m6PROtqdzainUbkff18gBoqBDOuF5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(921020)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?keufaOVCluQcnTVscMIftUWm+uOUcm0FDVg4V+nEiRZl/jdbldeYfepq8i?=
 =?iso-8859-1?Q?IdVA/Acfxs1blwgSN7LyAti1uXxEDhSF0MaGTmF42yoAkyVFj9uf5bEuZZ?=
 =?iso-8859-1?Q?Sm7g0jirfUbDTCMZ0ZchW9aXPjhuu828/S18vsSyAoWXqj7pyWPt2RzsOI?=
 =?iso-8859-1?Q?OtV75vicmZGwyjwzI0lG0uUQtSzhePvxi23Z8K+TrCd0U7UAFa+VYPOY87?=
 =?iso-8859-1?Q?oaYvgnQ6QwampjDehYU8yn8u8HM2el6iHT8KiOlLfI0rqX09iwddXOZCtx?=
 =?iso-8859-1?Q?6W7hpnHDtxmHE5NfgwnSzc62R4LhALubOssx7/BeqXE/eZfiXYowhYJ+xb?=
 =?iso-8859-1?Q?CJedcX9qGtGK5Ksy4UIez884oF0agxhq72npiOFBB/MYuvJNhmVLC0paGW?=
 =?iso-8859-1?Q?wPO/zCeGcnfiYLoa4mnmW/VS4W9AP4uY8rAa/cLq5bfiqwWc2affngY9aB?=
 =?iso-8859-1?Q?Cfu8aYj41m7zyPXSA+2TutUPC2++DKxG8E5nH26mES5139D4nT7vWPJvmq?=
 =?iso-8859-1?Q?eDV8nm5yfQIhGfnkeA7CQaoZP4e9X3QXzq9DOq9+1+z7xdWFizGE+kMKEq?=
 =?iso-8859-1?Q?zGw1Y7BxWZP5nj2QEke9HSUbADqXFX5iFdGLaip7R07vbjT3ysHDDecNun?=
 =?iso-8859-1?Q?PDFPe0kvW+9RHZ/8QvkycWjMnrwkWz/vhkYJd7uX4pdYZa7qyCck2PCW9j?=
 =?iso-8859-1?Q?OBrlzo8VGful+2A/vEa0pxEalM/z9eURgiRy7eStD8ZtH0xW45Sg4hW0KE?=
 =?iso-8859-1?Q?82B9VbUFWLC/ZA6SRG4fojKedTrJffHx9GkxS0XiR2/3LLekT6G1LjQCEh?=
 =?iso-8859-1?Q?IDfVSx2fcGe6iHeIMmyEgs6pmmT85tJTf3OsoEq8c/oExU9wEbUlB3PVjW?=
 =?iso-8859-1?Q?MUpNAhH/FqpI6sWVCNmdyJ9/+Sou7RFx1Kyjsx6HR/YJrT8DgZyuscAVdr?=
 =?iso-8859-1?Q?eVGBOUgUIa6anbs6ROxLQmSm+Tcx62qxvVlwiAn+N2yncO3RMSQ4OfBCW9?=
 =?iso-8859-1?Q?Rwru4Y7aPnU1RTS4r70JXfk9gl4gBvHytmcezH9NNFRfMnfJKXUDWAOerU?=
 =?iso-8859-1?Q?6OIrUmp1EcsBycvzPhHKgNKUVZQasF7AMMbvvqPZMbqRFQt3Tj697vpPbu?=
 =?iso-8859-1?Q?SFOBg5h4CHO5sdHyfW1UrYS8ws4d+fkgpQcDKFvYuFRstVkt6JqG0hom9Y?=
 =?iso-8859-1?Q?OYWCUjsbeI2+HdNRuq6mbvG5G1PXPtAnX58WMO2GjFGWy150DSW3u9nhGh?=
 =?iso-8859-1?Q?3KFd+Zes+cpzX/cqGuMqnsG0kK3bYjYRmjKBRCPJKOnPlFKhumcTq77zp5?=
 =?iso-8859-1?Q?wMmH/n80GVd/J2GOhPLtBwDBdegNlSTmHCS1TOaVOJoRDrBmGY9qno3NYK?=
 =?iso-8859-1?Q?o2E4CCUfnwfTbFD57UrIvDKu1awcBFFzArAg+CnS/Ij2hcDpNOBCBBSmxy?=
 =?iso-8859-1?Q?1iC8lbNr8/IFDNFC6cGDvTAZq5q4HZuF/zKRGvpx0Y64rtuY09OKpnVJvF?=
 =?iso-8859-1?Q?y2aBrQC73/YPXauoIl56K8VYD8KQb3MzANjjORPuRv6vOIYR4JYaOAZAPx?=
 =?iso-8859-1?Q?dMfCk+r1RaT/8ooGxb5uICr9iwK88/6aaDn8++n2+2kpDMaSyW5aUcZT7v?=
 =?iso-8859-1?Q?PzfzKv0P0UpPjma8edmw6FZ7KoI/UQNQKIWu7SfB5t46ZeXT1fLIG7RIhV?=
 =?iso-8859-1?Q?F/3kY2tyNH5ty77BImb+8VD9aNbaGe1G9+hB/tNhKH1mTtH4nfpfh4+ogJ?=
 =?iso-8859-1?Q?gI6jwZm53Ugiovm/lLDxZADDs2kId1VOOkt15o4nuz0eZG8VN6NfIPbSDi?=
 =?iso-8859-1?Q?avEF/Tc7xg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PwHvqjAYRNhC9MpxTlFJt5/AyHziA+hFztLhODD3d93Tr/19qSYU4Aydt1/eO4sMnxbHHny3KMaIerGn1pdn7yky2SoELEasPcWEHtB/pLyLtPVzrdFYaxP14TykIPxG+QNSxT0tLdDcYoCy9njxbmnWYm9z8CfRDqCoHXwoCtDoMfGCj1T24JDIWiJSrHrcIzj5SriMNI11/oZGHdcwCssZBV8IvI8VYM/A6JPnJbMpGyF6WBbxycQl5usnoWc/boHJ4mlzBlEmGjIXN5tO/M7denHGzWDYDebxm+aaRYt8zcqkBnTC9hyd94eZa9y62OXhDt8/ZcF6d804Or7slg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6eb795-f0ff-4aaa-c317-08dedcd22632
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:20:27.5045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEMs+5ZFF8YDOmqa2pmURb+pkU4cy8s1gigIsJ/rBZ0RNHI31myGOeXygf+0KWd155ASIB8sfPgZyg+VgpIeXBw3dYHgjBMHSz3+0d6CzR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6311
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

In the previous design, both the PSP and TSP were started together during=
=0A=
SoC initialization. However, on real hardware, the TSP begins in a powered-=
off=0A=
state. The typical boot sequence involves the PSP powering up first, loadin=
g=0A=
the TSP firmware binary into shared memory via DRAM remap, and then releasi=
ng=0A=
the TSP reset and enabling it through SCU control registers.=0A=
=0A=
To more accurately model this behavior in QEMU, this commit sets the=0A=
"start-powered-off" property for the TSP's ARMv7M core. This change ensures=
=0A=
the TSP remains off until explicitly enabled via the SCU, simulating the=0A=
real-world flow where the PSP controls TSP boot through SCU interaction.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-tsp.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 39ba062a20..4212e7bd4c 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -192,6 +192,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);=0A=
     object_property_set_link(OBJECT(&a->armv7m), "memory",=0A=
                              OBJECT(s->memory), &error_abort);=0A=
+    /*=0A=
+     * The TSP starts in a powered-down state and can be powered up=0A=
+     * by setting the TSP Control Register through the SCU=0A=
+     * (System Control Unit)=0A=
+     */=0A=
+    object_property_set_bool(OBJECT(&a->armv7m), "start-powered-off", true=
,=0A=
+                             &error_abort);=0A=
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);=0A=
 =0A=
     /* SDRAM */=0A=
-- =0A=
2.43.0=0A=

