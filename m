Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE54606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=lmNMqKu1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjUq-0003sQ-Sa; Tue, 24 Nov 2026 00:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUo-0003rB-Ao; Tue, 24 Nov 2026 00:55:14 -0500
Received: from mail-japanwestazon11022082.outbound.protection.outlook.com
 ([40.107.75.82] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUa-00010L-5w; Tue, 24 Nov 2026 00:55:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcQHFZN9rL3i8DOcy+9jAe7ysUuZ5mzYW4siqLm6tacQx9WN9aQUk5TsnJkSbz8bx78nK7cQKTCZTqlFg7/Dyym/nOQO4vfppph2UwBMMo1I4s4fMhAa4XuDB5aobYdJFQvo18bVRYOCz1mbkQMC90T08AAGzjbeb9M1C9pbeRZmcKcvPzkXv81NnTS4WRPkWcQnCCY63pfv5C8hVWDq/i24zJHLNbrVMvl8Iw8XXB4YdaQXbGhFkJyGCLWToO4grSrzACX6JI102aegZmqXFF8Haq8yXbiQNWC7SiPr5GY1krKXxuIYBq34TSnUZtaJ6B8KGG+jdi6qQouD7e0nnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usUA2NIG27/NYkGj8pvNEBPOZtpo8caeyUKoFCXTkgo=;
 b=mzjJO9wXrMXljMaehopbGWQcznq+CdXHZ+OoTSS3WU92oUgRsd+vxO8XjaIIvgH7Lkpti6YTjHx4NiNFMmerGru/NissxShJnBNzLJz5JVDx4niLkjzEJazZDdo3Kcp4lhUCDozy6JwfYTOLFCkb7itYx0G5vZ1dYr35b77tp5tEwq9uGxCDg3orhsZ8aFqNPyGVhdFUMmLhJSG4sUUp109Kd/i/MmpcKTMF1rptVu5mYq3CNAsHYyrEFR4hDy1wC1YP1uL/fTWbLegyM21dnv58BSvjxzsKu2ZQKbwfMoLcsOyi+fHObtDUZfHr/UjXgVBtGtOLCR3L8JxLz2yYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usUA2NIG27/NYkGj8pvNEBPOZtpo8caeyUKoFCXTkgo=;
 b=lmNMqKu1HWT+UoUIMKTgqb7FdUeLWGnZAw6hws7xRnNsWtfYTE8m9PZ9QdT/M8xHlhvxyUzD9Gmi0XnjqyI2mkM//eRXTPFuxfYA+p/qnrOxtrjs/CuTF74qmcXg05ypA4w3bCvPh5ESXR4Bq61DnDiHsY64dlcP0AGxk6YyxcU+GMc9P8+zao9wR9Ymo7gXvzrMEMGfQyefXYQulOIiF1qBvFf3g+cWZpP8DIshTpaLI6yLQWT4fA2rHd7qzbIQwwd9Nj7CXvTJ3XAaB8gExeliaSTrmGgYnrjHCZ598/rX8AZaC9ZfO4oYK0Id78CoWAgcxxC1StExSWzURzqa4w==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SE3PR06MB8456.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 05:51:54 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 05:51:54 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 03/11] hw/arm/ast27x0: Start TSP in powered-off state to
 match hardware behavior
Thread-Topic: [PATCH v7 03/11] hw/arm/ast27x0: Start TSP in powered-off state
 to match hardware behavior
Thread-Index: AQHde9foRWNxp28UQUSXOthsiATvbg==
Date: Tue, 24 Nov 2026 05:51:54 +0000
Message-ID: <20261124055150.1328856-4-jamin_lin@aspeedtech.com>
References: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SE3PR06MB8456:EE_
x-ms-publictraffictype: Email
client-request-id: 24e444a0-6ff0-4d1d-ac4f-b4ba47bc61e2
request-id: 616cca73-491e-49bd-b4c4-08df49ef0b26
x-ms-office365-filtering-correlation-id: 616cca73-491e-49bd-b4c4-08df49ef0b26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|6133799003|56012099006|260925022911599003|260925021911599003|260925021311599003|261102123227099003|261028144727099003|261009223027099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261026121527099003|38070700021|10067099003;
x-microsoft-antispam-message-info: sAvoKdyW6WxLx4PWhmpqu1DsGDEryv/m/dt0O3fTPICJUIhZR11BdH2uGUCoTEwoke/r8F6m0xipa6REEEq7FustYiBn4gGDliHOzQEEB/xSYZ5nJ99Yd/SZ4bII+BeWk0kffPHsz2zdfaJJvKARMcPQCZHvCu6opBQYbRYd3ARkYdizEeK3Kyt/36YqBQfwDo4JucUUpnac56wUYnH4O4YyqRPSVDs206A56XTBNirRssyy7b9eEaJuXECxU6sfsnvFW0DMm5GDgxlPUP/pJ1+3ewNyO2Llph8Y9OgBkDNEjnrUXrwb/Bz2DZ948yqhOv5vrMYISEDv0tkcPQHUp30OhI74wnDd0k8+V8+gV5LGQ4M/Dtv2s6LZBUHXrFkc18pKhnUM/BUp0065+6Rlv+bmTUVdCRHUfNBM5SbCtbNpDgbNmzkNNinJAzdYbGuXx7Ct4QBa5Pt8EmIQzo2Djkoe7m8pRvgW0WNLpXAbhHD6rO8AnU+HCyMkMwfTtkarxT18nDSdD8Wo0oyrZPwhnqznUVFdiHEP10GYp0emZfTiZ5eIf1FuTYBRGu+86QQ3rVEZVt+uh8fwsJtwa7EjKaXkZ8FCBo7rZlVmfr6F8rtFIPbzKY+iNKDDW6zAmGrH9zijqTkYiMFmO+QDP0CH3weLkmMGpXUaXGLKsZumyad4HYSFEUL7zlGRGgh4Ji3LYc34vIz0Xvv7Kg9mr45pF8HvHl/fczOdjAE/8HSVlwI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(261102123227099003)(261028144727099003)(261009223027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261026121527099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Hl66YGvIIm8z4uIMHFnaLdkmAFt0QRrISzuf92+ttzC5dkurlmZf6Wd4hE?=
 =?iso-8859-1?Q?n8Qlq/euINQaAQVw0wTdPvRjh+nq9JLUOUqyuyxpxWAobgonHfxHXjDgia?=
 =?iso-8859-1?Q?LQWhIhNOutBJiBdBYbfylStXpV4saaf01UI8OUHpgqOj0ZxM5/WBNcVcRt?=
 =?iso-8859-1?Q?yq8s7GjeIjTozeUFOsysV3h5cI4fygzS6ZQeX681MVQJ6YiDAxsDP5nBqq?=
 =?iso-8859-1?Q?CoUm14hT6NaZSrRyc0x90FhPpL38zXQxnhTU1qVO2zja4SBAXbt0ZtBin9?=
 =?iso-8859-1?Q?iTJMa/R+fWRxBjpBZ8bR+bPY+61wLzRujxdjv0m67g2PxpewZoaTbupEXI?=
 =?iso-8859-1?Q?8JvQkEMyd/8Ohd7OnSf0j/wJxSkykv10YiilxR93+oiAsCRI5tx/1x+EM2?=
 =?iso-8859-1?Q?fumTpfhn31n6/L1HZCGCVUgQXCsno7YFFPLmCgeMaKBP7XsBGTeyF6kXd/?=
 =?iso-8859-1?Q?XMGPSUMSNLo12io/QSq4/+YTRy1a2mI0OejwOLEkiT4iUZoofa25RWdegX?=
 =?iso-8859-1?Q?OU6t4yhn8P+bDT1E6E+yJ6hhV2JCVi5v8XirNRrzGR/xkWb0srAkx5whRh?=
 =?iso-8859-1?Q?Snj5YT07orNdw2y3S9dd52nE/QH4c941Rns1b6WED8zSzfgEw5fHzQ+gVl?=
 =?iso-8859-1?Q?uFDzDI+3BU8oD5V02Vo2X7qGHaCQatbgEUNc20UmauCO4ntB0Awqe65u68?=
 =?iso-8859-1?Q?YNWCSf1EIscotNpgRicBX04H8rfA4pu2B4dolfmLo1/eP/uKsYdOZBiFDU?=
 =?iso-8859-1?Q?2Y3Nnkjtxk4ah1UEiELrWqektjfLhwQQ8gS7Rf6ZUCy+QenVSPAvTCGb5J?=
 =?iso-8859-1?Q?dLZ3rX/sQxcYwlNKFG6y6Ug7qvaRPP6DKg28cmwLREqol5EpXET9EANO+h?=
 =?iso-8859-1?Q?hm/Llqr0vNm+pjw6tacNq2RsXSNQIF7PHF2kg5Xc8sJtvBcqrl4xFdp0t6?=
 =?iso-8859-1?Q?NsyTkCPx0Y7N0Kd+KBEClv2o69NqVkldycdpJzrb5/+IgRNNCSrODhSMvf?=
 =?iso-8859-1?Q?8JJUjH8mSKqKR37IRMIyrfjRXbK29v+QMt1CRfWf2d0Tiw6RUicSJ6Zs2o?=
 =?iso-8859-1?Q?P8bCDX3eYYHbpxzOMGDFWtnhu2ph4ZoD07KDv07T6dOJU0BtIpRL+GNzSx?=
 =?iso-8859-1?Q?7FSKuR5VxH3C808ClDVcw4nSCUkFu3ELqytVjnixCnMzXVdy8Vf3cZl4fV?=
 =?iso-8859-1?Q?PRKYSeItXo6RpBMtaTf3P3xJamLFwWec09AnDF1SabToYt4VbJ9MU44/lf?=
 =?iso-8859-1?Q?zuXHJettqb8BVWtORIWgMuMseTdY6O1UiHyX5Ccjk8lzLRdVOe72cZaAKY?=
 =?iso-8859-1?Q?G/FT2ntoyCsHWIVv/VbZBh9rMsuzjrMo3NGLsi43Nrtq6EYe2Kae80uLRi?=
 =?iso-8859-1?Q?pARO7ctcsx9eNYZM8yBMPLvjLJE32rk7ioF3zt/yoj/5W/gfqp/66DmMMP?=
 =?iso-8859-1?Q?OSjlKiOh10oZp4lc5wQiGdgmTIUJScfNYzS00aWnqbj2OCusfsuoWRx9ax?=
 =?iso-8859-1?Q?rckYvvbli7EO/yB/dMNFQ+SxVfQs1IHslAWAUSJxGZXdW/x5j2hyxk7QXX?=
 =?iso-8859-1?Q?TMeNoSxNiXNjXeVIP3DVJAriNXH4NHeTrY71SrW54bxCE/GMNkdPhaE41g?=
 =?iso-8859-1?Q?tBSwEqOVqaKbqQzroPSqYi7EOzF0DD/62xxE1oek0DGgFQML33IxWmr9Gj?=
 =?iso-8859-1?Q?y9rwMM4ceWnwpIDbf07YKo6zqUMewBxQmaiYS5GaUnnoWIeUZMEeYnbvbR?=
 =?iso-8859-1?Q?kSbEVHfZ5JOurNR80SMLECdVStdGoQ8dMNvmsb4a+2nwgFED2EBBlnH+la?=
 =?iso-8859-1?Q?TqUhkaoipQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616cca73-491e-49bd-b4c4-08df49ef0b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:51:54.2310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FU7zyWeiquRPctCGzzh6F6MGVvsrj3hntECg8BAlzTAZL7bLgRHqSGOFiP48xi3n2CAfdGIBWmImfcroqFi443yZi0TvXUXNVsthNZHCoOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8456
Received-SPF: pass client-ip=40.107.75.82;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-tsp.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 7f057ff135..7348834458 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -189,6 +189,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
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
2.53.0=0A=

