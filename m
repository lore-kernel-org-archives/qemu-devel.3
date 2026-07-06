Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E8BC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgbrr-0003NQ-5c; Mon, 06 Jul 2026 01:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgbrZ-0003Hm-0L; Mon, 06 Jul 2026 01:27:26 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgbrX-0007PL-2U; Mon, 06 Jul 2026 01:27:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8rbbebGxBLwptjH0601YSjQ1YQkkUFvpoU0DVtUNYPrD5oBZqILHshcGqZWnSUE6RNWol/h7PLnt3BwdMjESCqddzQReeYC6eWlbdA1bZ94OuAJjxLtt5tgHQUXcgmEzjiqxSz4ssVJVwhNoNBJCpcd2Z7q2+GSTg7OTJoQVjv/e7lTAhqwiWF2vlmArCYglsS/HxkNTo4Oh/BwjSMTAW8/Dk4DMB/owCR7cK9nmdLbZX1nEDt/X0vtGTiVGCno0bJLAD1KJbyH/htjpWTCjxt7GKtfhHbn0+m104OEZivqjVKzXHJr+Lsnn0UTqnk2qMmNJ+TnU4P2CVI1MHm01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w68iAa2GupDxYsDtgluebiaFLXzWfBzWAxt9hxPKDvM=;
 b=a7EldwaEKqIk1flhSnxuPNqfeTlm4j2j0OCPDDza1F25ISM6dFU+4T9wKZcTlb6nIpCA83AR28V8sbanhYnQGrxXm0m8JfxByjeyEzKMBx+Fanc6nuMartxYpSlxrXooZq0tzhK8tzE7HV69mlm6LxixGcdTj9MyMwdF+d7NAR2LkIRsDtSkLbPVxvIgyTXB5f8zBXAk1TFEnGHfOMq5DAaKC/6AQUMmZeDGEd/J7RZgiWpBck+mtSTe7sntxI3peoIwhYpwUdz5222d73eaE0reoU8hURTQZCvmNuweH12hj1WW9nGQmWeUXmc13e5BLtnCu6io3GGGqAnEf6ACAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w68iAa2GupDxYsDtgluebiaFLXzWfBzWAxt9hxPKDvM=;
 b=e4MVsBtfr77Yx46oVjdshbQsPAIbti3cDdAPlDVsEZmFYHrMJ7SjcogJU3C9nGENM2HJ6Rb0F64QWMl8oMSqnSIerZG39ZZn8OmI0NGQ3hH4iQjaWiiUUeSgF7fOGBPgyZgckB+SvNUrWCggiu9j1rRTqXP/qmPzVjNO9oHaNuZUW0Ui43rMe9unj51DgR1Nffvn9ookqEagEjBgr3YcvT9jMaKWUTozhDGsO2Rp1k1f6/gcZUT9ZEZfmRXi1VUL0gR97WSAlrx4jIXCc0dVy+ontmHlwwF+UlwIxmteVuG/bIzZSLGLkW361LbHjnHHULogh3Wkp5qz8nLZ+Y+Lsw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 05:27:08 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 05:27:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 4/5] hw/arm/aspeed_ast27x0: Add unimplemented Privilege
 Controller MMIO regions for SSP/TSP
Thread-Topic: [PATCH v2 4/5] hw/arm/aspeed_ast27x0: Add unimplemented
 Privilege Controller MMIO regions for SSP/TSP
Thread-Index: AQHdDQgWiheJ8mWbHUeheaJejyQbLw==
Date: Mon, 6 Jul 2026 05:27:08 +0000
Message-ID: <20260706052701.1141740-5-jamin_lin@aspeedtech.com>
References: <20260706052701.1141740-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260706052701.1141740-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB5897:EE_
x-ms-office365-filtering-correlation-id: f431c1af-a715-4956-1412-08dedb1f395e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: BBxd8uPJGEYA43nas+Ec/G7EeU12hGU2SkJKpqGTG6oTIFBsoC79S4yZWxL8XGSkKy0rWFfC2kVvp/UGsvWWU00nC0qB98E+hJqaykeNi/QQ/GQLGVRvFqJKIhUTlpwiymA+QcEIUleccOAm/BNqCHXOPXlccERSyw+9u2vl+yjHes+LrZVDDpCZf5Q+ToZoc06vjEC1Sec2jYTe95zAFHzrPCk5mP5v37REnPsa0f69ClU8GcgIgAhsV2wuS7REkG9IaogWznLZIDAROC48gC3QD4w6Pq2qCLVjcBJZAEdU71haoxvZd+CqTkn5yxQHMpDL+1m2ttDo4KgYULY9XHmvouHOklzpBi5ryO3jsshw6XhJrw6SEkZ8HAhlelzkCEpD+xZCK9XI72OdTW3x9TGQN1dqnhGZPZi8rlEctflm6VkuIHHFE2WiiiIyeSIERbI4QnGEQRs1n98KlginA19Vd1kPKXa2xaVVVno8oe5LGnJXMbLTTQemj4iCVmihWDBJQmAVdS6vPJLZLECedWkTdGNFAoJsKDHcVjrZeh6zQ3IpjUM+lISs4tsQea31/GrJpuMD3a0r1vEWgRn8Yt75UuvptI43oJXswxX/0fpznhqbLmMQ0zBCDyjEo7CT+ocrzqe62DVDvHE2wPttrUd8zQXrbgtg/CnloSf6f17QodBvbc8sRQRW3duchpo2tvbTMzdKXFAT1LGSR4BGNQuL3vDBuvmTOnyeI1b4/VE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8JShxQQk6+5lw8+mU8jx0LNsD8bdDKPJqwESsVXvywHlWUK5+KJxeWcbsE?=
 =?iso-8859-1?Q?Lf/GMy3rnRqXbfoPQ50dtm1DuTOvfzfucvoBnCLT7bdC0T2GJJ/UEG4tZK?=
 =?iso-8859-1?Q?1gNeGog6j5Ue4YsqqTmWrO9j1fcZjpznXpHABKOHoMsd8nDMIyzc057gsn?=
 =?iso-8859-1?Q?C/wuncY0MKThYKx2rtpL6zBo2kjzt1dfukLf1RlhXJGEJ46fiiq/t7JLkR?=
 =?iso-8859-1?Q?MbyvMsjIUkmgrr7ZShEST5jzx2YQ7tLXvPXcohIX63cRfI4hU0WvsRYpSN?=
 =?iso-8859-1?Q?PAOaq2D6ez9pEfGefw8kIDDat59vIR3tXHphpIh8ktTt8mxk6CWNTcA2o9?=
 =?iso-8859-1?Q?4f8HtwbHquNx6UFBd516GC+MScDRVen21On6W4jHuvgq1rmjN4rOsc0N1e?=
 =?iso-8859-1?Q?j5uLO9yT+nniQQ8PvsnOzS/6SZFfQsPJa4wHLO1DTL2h29Uzs58sW+/++6?=
 =?iso-8859-1?Q?zJlf8kmpVX8PGsjTDoPd6NVddl2e4CvKm5FsOrKEgoe0fg4rAuD4j/Xa3R?=
 =?iso-8859-1?Q?5fafdP/jrQPMRctW/WKrwOvBmlXRHYxMDWjuaECokXOLphPLXnKvDk1c47?=
 =?iso-8859-1?Q?JVIVSZDpMGum3pMWNiJSBXgDR28yleWETg7YZk7i35ZLRZ3XyQLpZDc7UW?=
 =?iso-8859-1?Q?Y+1B9VHkra+eoSVxCshmQwQfc4okcmjjAJonnKJgHfryGKn/o2+lJRMCft?=
 =?iso-8859-1?Q?UII16nCYcR5GMd0vc7tSlsDoEZzC5ZrkikFJLAe22ASRvWtdXJCoCQTF+N?=
 =?iso-8859-1?Q?lldHxN6qzb6ghCoouqP0UQ6YgoY1PTtv3gTKeFo4Yo+dT5vSmYJ2SWtsZW?=
 =?iso-8859-1?Q?ra0IMDOJBYH1ggg0eWkETxVuV8oe//h7eXRtqyVI96CQjex0wpFMygFOIu?=
 =?iso-8859-1?Q?x5Xdf2U25QIW4Wu3z3pnBfCtp61aAAyo9wQpu3Skgg+qIIQFgh2ivmNYvI?=
 =?iso-8859-1?Q?JajWGVOl1tJ23iJOwhNfJGJmXFZ8kpW09Trf2us7z4SqfJQO+WmyaANDr1?=
 =?iso-8859-1?Q?C4aq9gai7s+sEJDISgi3zWHD5E/sdLwmFXA7M9lIvXOD8nDdK5+U9Qva86?=
 =?iso-8859-1?Q?BuTGy46YuVV9bCtPI8OS8c9OAQOrW6T523OFNFhFdhk+a/AJCR+wE+Dnzg?=
 =?iso-8859-1?Q?y3lAT9xGhdsNECQgq4+/NohVI2fF5GGxdKZu7gNXdE22xRGUglLjcoiG0Q?=
 =?iso-8859-1?Q?5iTF9ycw7mziaWURPJa7NIl9TlYA+bKIoug/h+fQlCqTY4N4R9rTM4Kb7B?=
 =?iso-8859-1?Q?0pNwvE3ToLcwQeSUCB8qe6iUHr2f3GuANBmvWBRACxtU/s8T8MPL92OShO?=
 =?iso-8859-1?Q?9mdnl3FB9MSTCEyWrz1CRVr8TTTDdiztcdltQb2ZEzbnMTnbmvidIfhTVn?=
 =?iso-8859-1?Q?JGv7K6F2M9e/YGQW11GlYkf+zMnvVvVvldiG0hbVEqAXCIA0805BVmIEpO?=
 =?iso-8859-1?Q?UxbyjVcWm/WAJhyNJdqPHC1AzdjIbS07EE3NNXi0TWiFmonM0N9KEBC5OM?=
 =?iso-8859-1?Q?xqeDa3UJDDsr/D0ylnBhoNxoK3ECBlVnU7BDkgF0j+5o2tsDJIwBJpQfhp?=
 =?iso-8859-1?Q?rLPtIiRtzN11BBUtMlcRYkNU36L+JYseylfnV6HeMUQ87QBSYkcEnPyG3K?=
 =?iso-8859-1?Q?p4qCjeDkLJHPv3EKoH+nZlt04hTTopIc3fLubasFFFd3PgdvR/92Zn4HhH?=
 =?iso-8859-1?Q?94f6mdpmnux1Z7NzfDywnP+l74byN/n8y67FuJHgiGKXW1BblM2MCGYSCU?=
 =?iso-8859-1?Q?lcdInBwl3fP2Ja78SSGZvMSdqSkwGhjIESLmesDgkCDfwfISQ8Er+iO3gG?=
 =?iso-8859-1?Q?2ceFl5wtag=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F1Wt/oP9YyB4vqfbviRn93Gw/PJ8R9kqixI2fMNusrqyVFCN24tesqVjfxJkk+Fg/u7FIi2wSIaftHz9zgNDIhuQ02yoyyWB7L732ouPsoRYoVqof2gH+4H/Pa2pDRhirYL3/mJgRNkILI2E0luHUjYve7MLG3J3yEWQnmuUn3h7VgCUEeSxeQIknR+itlysxFNKQJ29tomyN9ZHHOtocPfLjhBorWjt4nRSJIX0SxN1jiGzNK2hiTe29pD4F43sS5kVKFQw45O8BGkgJnbZNxUmYLo10M0J4mPYHMQA9/FAWOvix1rABSKAIPMHPULEwdYGYR1bfPorbeVlHlxkvg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f431c1af-a715-4956-1412-08dedb1f395e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 05:27:08.5535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzZaAVYN8433bmyGRrGIjuSSVrAPeJ5C1r9P2zb/Y93eR6i9TZ2yB9yRrPm+d8Sq1SAgofZeWWcUuR5UdPrpE84VS5uQ4Zq83ijtQyb3Ga4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5897
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

The AST2700 SSP/TSP firmware accesses Privilege Controller MMIO regions tha=
t=0A=
are not yet implemented in QEMU.=0A=
=0A=
This change adds unimplemented MMIO devices for the Privilege Controller=0A=
blocks and maps them to their corresponding physical addresses in the SSP/T=
SP=0A=
address space. These stub devices allow QEMU to safely handle firmware=0A=
accesses and prevent spurious exceptions, while accurately reflecting=0A=
the hardware memory map.=0A=
=0A=
No functional changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  1 +=0A=
 include/hw/arm/aspeed_soc.h         |  2 ++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 12 ++++++++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 12 ++++++++++++=0A=
 4 files changed, 27 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 4a50f688ec..700cbfb4bb 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -48,6 +48,7 @@ struct Aspeed27x0CoprocessorState {=0A=
     AspeedINTCState intc[2];=0A=
     UnimplementedDeviceState ipc[2];=0A=
     UnimplementedDeviceState scuio;=0A=
+    UnimplementedDeviceState pric[2];=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 };=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 3aac144cd4..a0d2432620 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -295,6 +295,8 @@ enum {=0A=
     ASPEED_DEV_IOEXP1_INTCIO,=0A=
     ASPEED_DEV_IOEXP0_I3C,=0A=
     ASPEED_DEV_IOEXP1_I3C,=0A=
+    ASPEED_DEV_PRIC0,=0A=
+    ASPEED_DEV_PRIC1,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index b3c4eb1915..e35c0c9a5a 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -22,10 +22,12 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D =
{=0A=
     [ASPEED_DEV_SDRAM]     =3D  0x00000000,=0A=
     [ASPEED_DEV_SRAM0]     =3D  0x70000000,=0A=
     [ASPEED_DEV_INTC]      =3D  0x72100000,=0A=
+    [ASPEED_DEV_PRIC0]     =3D  0x72140000,=0A=
     [ASPEED_DEV_SCU]       =3D  0x72C02000,=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
@@ -141,6 +143,10 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "scuio", &a->scuio,=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "pric0", &a->pric[0],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "pric1", &a->pric[1],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -255,6 +261,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),=0A=
                                   "aspeed.scuio",=0A=
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
+                                  "aspeed.pric0",=0A=
+                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
+                                  "aspeed.pric1",=0A=
+                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 6098d1aae3..fdc279cbf6 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -22,10 +22,12 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D =
{=0A=
     [ASPEED_DEV_SDRAM]     =3D  0x00000000,=0A=
     [ASPEED_DEV_SRAM0]     =3D  0x70000000,=0A=
     [ASPEED_DEV_INTC]      =3D  0x72100000,=0A=
+    [ASPEED_DEV_PRIC0]     =3D  0x72140000,=0A=
     [ASPEED_DEV_SCU]       =3D  0x72C02000,=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
@@ -141,6 +143,10 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "scuio", &a->scuio,=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "pric0", &a->pric[0],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "pric1", &a->pric[1],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -255,6 +261,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),=0A=
                                   "aspeed.scuio",=0A=
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
+                                  "aspeed.pric0",=0A=
+                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
+                                  "aspeed.pric1",=0A=
+                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

