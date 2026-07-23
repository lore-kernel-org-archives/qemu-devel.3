Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0D9C4453D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmj6B-0005LO-La; Wed, 22 Jul 2026 22:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5k-00056Q-I1; Wed, 22 Jul 2026 22:23:22 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5i-0002ZT-K2; Wed, 22 Jul 2026 22:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLGi0LGlnX/kiV2zmKMZoIy/XLl1IClpZUafVYYBMYaobNK3Cu5xWCno26D+849Ow3ZuaBGnlJDv1gnPUNfup3p7KF58oxAQq2ciJTBnqMeK8F+6yiJNRCyux5wn6yqgGFZTbIcRdeJFbZlvj357CDJiwNBBEF2w524MiP6ySO0vUyu2nGHYdp4uL7bd/DTIxZzLuYUudPjVIdWpCD0dgaSjxcL+wEzWi8dvohsiEFDNcIIA+j6i0ElOn5VqTJCL33rxi2z1PiUwTdoapXuhQC8WvfNnJZ1rxezPbKCUrphL23Bejd9qBLBeQaq4GhfJCq53/B4CpAOWl4xdpgQf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqdHLRajLsbB+gR57Pp0nYgCQXWIIO20SO8fSUqOl7Q=;
 b=gSw5NCykHmPCh8hk7vb0ViuWLV0RxzCO99oH/mEUNRMJl/eJnk53eWebaznGEtJNijgH9Qn+Un0aaQ0RQCYBzi4udKNAeC1iWrSTszCL2r+sNEf0joTjc2gUDNIL/vM7OTFx4rHmIZES7PczV8iUpbMX9Ui+PVMhOi/x/SOLGcsYQewKmuGMLvcJvzhvd/32dJTTbJhQb6t9gUl691YXVkpOTcro41l9vwB6FL1aeQrCBx+val0f1aCFhoeIDW8fbp8ibpqX+Ke2PYqu40bSQkyiPQfElcbW79aHMOfc/9v/ghvxom9VgqT+Ydok4X+yJp0A7mHgaa8Io1r6oSt/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqdHLRajLsbB+gR57Pp0nYgCQXWIIO20SO8fSUqOl7Q=;
 b=Vv30ECRzu1+JfngVDL9q7qIuS2U7BfyizaFJU2FGNrWaZum/+o2+MwBk6tO9FQQP3gN6ZeoHxI7fTji+TuRuqcBB+qeHVCJr7ymsPAqddDo9nmf4XMHvBnscz2MB4m9+wYD5bRoCgKAd9ensK68+xVWkfeZiHkr1xck/YAyIXKNgLnu7kMekAkCxypdixI/UcxDZEHfrGmBrP6Vn4VF+M3EB04zZHtS8Lsqt3oKx+el338cN9Vvudewgn0c3pX83zu1f2dcllrWgL2Ijk6ouYTyxdlFFWkVr12YLrmWDt9r6tDIuYkoCimxm4BmZFr4fZbvc2bDThNxATKGwen3JQg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:23:07 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:23:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 05/11] hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap
Thread-Topic: [PATCH v6 05/11] hw/arm/ast27x0: Add DRAM alias for TSP SDRAM
 remap
Thread-Index: AQHdGkoycQkwEXOFZUKo9UL+EZiwQA==
Date: Thu, 23 Jul 2026 02:23:07 +0000
Message-ID: <20260723022300.4174471-6-jamin_lin@aspeedtech.com>
References: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB7034:EE_
x-ms-office365-filtering-correlation-id: ec68df1b-77c1-4dab-3851-08dee861556f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|921020|38070700021|6133799003|56012099006|5023799004|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Ylfbuktbte83J9xhX4XK6Ll2uHgMxpL72Bs7NyKHjpAosbtcugYeFA/K4HS9mKHWEpH5Esfv/1aaD52yoQi2e7gCtZkD2EjOvnWdfc+fHm5Tk1Su+ap10i6ZsyvnG4zodOU7mmWz04Ua9FWAHlhqtoS5erdMM7Ee7jijuFwngH+vJqc8Vv8F7H579JdckYY+Likvjzo8prn+5ByYHemHUhZoS0SdnBiCjbiw4T63DDyI/U0dXhODxSeDdxNRG6P931b70/ssC1sjxHvaEZozHaaIYPbO7X/USue6vYPLY184waLQQQuRboSype9uPT50fRZT+Z4v1H6o8GxR1/1lJaXjH5Vv0Zdx/zmHwD4It7L91GYMGE9ff28cg0TzC+SZ3fcbkjaHUKPmjhC/fWrOu5ncEEBscqp7x8+DyXHbLfX/llik9M+dzlzpqK5KqWJrLhkKyoajKs4wNaBlT+7bP+sr/Wv+9ZvHaJQtAPv9LgJfQwgRZoXGUTb0Un6wQQDKWPdCyvZeO3As4vNzBoQxYrfI2uHEqr25FRmqxhkC5LhMET9hJLQJwP9QXpugnwwo1ESTJBxm25+rvsNICQBnrQITFp2ejYkgc7ehzLoZXu1IPl7Df+EtW2jdrcwM3HXkpJHHMyXphrKpTkaxx1JLTz+Cq6V4GPD37ZhxHFUyhjluTs1/nBvduW5cp2s/RWV21aYKd0BB8ykENG74TRv10d1GhC5pc6MD14aRNNqxtTxZ8iqmOIgOz6rhAjdxVW2G
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(38070700021)(6133799003)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LSpqcWSdLXYR+FnzWRg4Fu0ZZ3pZZJLmnDbgPMvwdyAPDC6MNMybTiXYcX?=
 =?iso-8859-1?Q?ziH4EJPz6EUe3CwsxDL78+Osn2qFUI0FDt9QPGPwvlE/z4+0HL9sqiqCmt?=
 =?iso-8859-1?Q?iaWVV3ew1U86SIEnxnlKLdhusRqg3hylgJVRfHmnuE5jIteGTB2vsdvCfK?=
 =?iso-8859-1?Q?dJwhQV9f1QQFA3x2dfi8YTP2zCC0+gosJcPmwaSvCKMzYZBcCeADF+oLbL?=
 =?iso-8859-1?Q?VXIRm/m5ve8ytYkvLITIMb0E7R7NWQZQG0Eo3B9VnkCDNWqTPuFxQ3XT52?=
 =?iso-8859-1?Q?2G+D9TjGIxsz7YzF2cbwJox6sIGnNA+sRT9lg5gRfP57jKkBDDtKI0vXJh?=
 =?iso-8859-1?Q?mhdY1WQdaw4QwBr9kGUmtCCTCFUm2XqewJjPhGM2D/8O5U7D3oIl6oX8TP?=
 =?iso-8859-1?Q?nqQ5onrBgLLIoGLhQPfSgvi8CqmIVMz8jmBOlpVWbChqrF45yGvL5IvR6l?=
 =?iso-8859-1?Q?w7VbNMUN1jvUGAbEcgd+CMP1HnG40WVz/CJZ6aTaBWz1A37m1VMHfRhQpi?=
 =?iso-8859-1?Q?PuGix54/7eOjWqnPsp2P4fPO7pHPknz5aqeYSlr/zab8Ajbbcj6PF/ZeNR?=
 =?iso-8859-1?Q?omM2Fr+4n2HvZJlaggTWECqDK8cn11r7urEre1WnbI8p0eQZB6bFfPtrPv?=
 =?iso-8859-1?Q?C1rs7BsvUIsidyoOmcZUugF8uOCBf1OioWTtbrpmplBtq6IHkXXDyTbglk?=
 =?iso-8859-1?Q?zz7b2vn0yPMj/Yk7ERlOhSf1NWn/DMkpXy9+cYlvX282i1c8G58cA1xYIS?=
 =?iso-8859-1?Q?fCfsAXLfvOMHeXujN4SYc332LBrhLsUc3yWzMllw34jKSmgVQMXB+Ex95o?=
 =?iso-8859-1?Q?dHKRzwCK4iuFNnARDs1MrwzAs59faaMlXOe+JkhxSKKzVeVnbtYKJ76J4+?=
 =?iso-8859-1?Q?lrbyOiAayYTVQxxDb0bIt20Z76CUGd/97ScS6reiZLi7ksP5HV8kqaYZdS?=
 =?iso-8859-1?Q?JZv1/RhtC9ABgU9hu3EE4gnbpOEOm9iqEAzuT/QrDC9EvA2z0ioDWt5lvf?=
 =?iso-8859-1?Q?rlE8o2v2qEzjY8sNSdZRYOzhon4ZIiyqeySrq2p4x4k7aY9qjRlyqHBNPw?=
 =?iso-8859-1?Q?XGxgdabwIbzRXeq3xjVqIe64Uyj+dbEyxWdvFOZXKqkfguhwOJvLtxLkiU?=
 =?iso-8859-1?Q?/R8M6pJGSA8kk0HVs5cvlWZSCu9e4/7zpLOjAQUdPWR8USjAtqIUFcAkxR?=
 =?iso-8859-1?Q?VZrUUTgYR+sWB17RneMgFqAclplM7fcdTxtPhBMTieA5tJ+j+prgODzd/v?=
 =?iso-8859-1?Q?DBuN6fAfY9TcOM4EZEJYMcksvEDneEHyy4Z+aHzvEWQx6eOeGOz/c8d0RY?=
 =?iso-8859-1?Q?SLA49Q/jHY47FQBS8waQeimEpQ+BrBKdQOkPL/qUj8An7gOZ/ZavuSmxSL?=
 =?iso-8859-1?Q?GsUH28XVMZJQDP8bc4fYHQKduyWu1vIrE2QiLszX9qj7uc5/Rm8bI9Sk6C?=
 =?iso-8859-1?Q?IPVvUBeNcZSm41iFYTFXTvykq3rIDaWXlp7UN/OGg1dEIVhKEM5IqynDCY?=
 =?iso-8859-1?Q?htzmBwscRUKrhH7JhE5aKpjXV5GgzNfTQjhdRdZEeeu8q6p7gq6OMgTyVT?=
 =?iso-8859-1?Q?C2m2anKl2rWeNK+5eo7fojZDgKwa1O1JG41zpOvndTXqZLGKUa+tXnYonf?=
 =?iso-8859-1?Q?uXsxTQ4JQ4lBu3sOygZEo49fDuB/EPVhQRwSsRrdRjG9rTIz6vsOzmI53u?=
 =?iso-8859-1?Q?mG8GnETINHJEmTVUKYPhMKDw5ZYAcO4GOpF92PL6yW+nC0nE3GHdkyEzG+?=
 =?iso-8859-1?Q?67xbqMI5Pv0kdNUO58zn9e/RODn+elL284ZvSzRzdFDmv8Zd0XZBbHm9zk?=
 =?iso-8859-1?Q?I4BkCXGmiA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UfOn+mGZFHGLwX7QqgbJbKifZP7bY4eoE42S7vZlNCqnnfu4o+ubJsEw4h0jEDSSNFZCAs0IP0zpiYFKOiBIzKw2zwMexphjY7UovsxzmxBPMcVT7/2xwqNZbjOawUbD8QQ51waOM3UX6NIYYEJaXNBDJRSoOynQFqjy4NTTZDU2AqHFYNrkVAZaqVplyUfv404bdoEEsEGXQAQqlGomm/f5c1hf8wfZ3/yUn2zHVWolwQtaGwBleosCK9TS01HJqNuxZM5gLwuuJmnkbm3Ha2nVLY+FhPZwfY3cPEEKx53WblLE17R1r98l7keD/9ZwTYKLy9H6TorQCfBNBeF56Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec68df1b-77c1-4dab-3851-08dee861556f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 02:23:07.5454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yx708+A5e47WBc6X4y7xOlX6+rSnHXMTx4zCjgqzpETbwjm2JfvGLsbf1tCWVAShcXqPQNkZfyDZaHDpm7L2N2k12MFHP1GPZyhpEO72gXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034
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

This commit adds a MemoryRegion alias to support PSP access to=0A=
TSP SDRAM through shared memory remapping.=0A=
=0A=
The TSP coprocessor exposes one DRAM alias:=0A=
- remap maps PSP DRAM at 0x42E000000 to TSP SDRAM offset 0x0=0A=
=0A=
These mappings follow the default SCU register configuration used by=0A=
the ASPEED SDK firmware, which defines the memory window mapping=0A=
between PSP and TSP.=0A=
=0A=
The alias MemoryRegion belongs to the TSP coprocessor state itself=0A=
(Aspeed27x0CoprocessorState), mirroring the SSP remap; the SCU only=0A=
holds a pointer to it (tsp_remap) so its control registers can=0A=
reposition/resize the alias at runtime. This can't be a QOM link=0A=
property since the SCU is already realized by the time the TSP sets=0A=
it, so the pointer is written in directly.=0A=
=0A=
The TSP cpu_index is only known once the TSP's armv7m core is=0A=
realized, so it is written directly into the shared SCU at that=0A=
point. Its "not wired up" default of -1 is now set explicitly in the=0A=
SCU's own realize(), since nothing else sets it via a QOM property=0A=
anymore.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h |  2 ++=0A=
 hw/arm/aspeed_ast27x0-fc.c   |  2 ++=0A=
 hw/arm/aspeed_ast27x0-tsp.c  | 30 ++++++++++++++++++++++++++++++=0A=
 hw/misc/aspeed_scu.c         |  1 +=0A=
 4 files changed, 35 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 01e8854104..aef13e8915 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -46,7 +46,9 @@ struct Aspeed2700SCUState {=0A=
     AspeedSCUState parent_obj;=0A=
 =0A=
     MemoryRegion *ssp_remap[2];=0A=
+    MemoryRegion *tsp_remap;=0A=
     int ssp_cpuid;=0A=
+    int tsp_cpuid;=0A=
 };=0A=
 =0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index af700e748f..e51d8024eb 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -191,6 +191,8 @@ static bool ast2700fc_tsp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                             &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "sram",=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->tsp), "dram",=0A=
+                             OBJECT(psp->dram_mr), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scuio",=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 4212e7bd4c..9a860f6ea3 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -184,6 +184,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->dram) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR=0A=
+                   ": 'dram' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 TSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -201,6 +207,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
                              &error_abort);=0A=
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);=0A=
 =0A=
+    /*=0A=
+     * cpu_index is only known once the armv7m core above is realized;=0A=
+     * write it directly into the shared SCU.=0A=
+     */=0A=
+    a->scu->tsp_cpuid =3D CPU(a->armv7m.cpu)->cpu_index;=0A=
+=0A=
     /* SDRAM */=0A=
     sdram_name =3D g_strdup_printf("aspeed.sdram.%d",=0A=
                                  CPU(a->armv7m.cpu)->cpu_index);=0A=
@@ -232,6 +244,22 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],=
=0A=
                                 &a->scuio_alias);=0A=
 =0A=
+    /*=0A=
+     * DRAM remap alias used by PSP to access TSP SDRAM:=0A=
+     * - remap maps PSP DRAM at 0x42E000000 (size: 32MB) to TSP SDRAM=0A=
+     *   offset 0x0=0A=
+     */=0A=
+    memory_region_init_alias(&a->dram_remap[0], OBJECT(a), "tsp.dram.remap=
",=0A=
+                             a->dram, 0x2e000000, 32 * MiB);=0A=
+    memory_region_add_subregion(&s->sdram, 0, &a->dram_remap[0]);=0A=
+=0A=
+    /*=0A=
+     * The SCU is already realized at this point (it belongs to the PSP,=
=0A=
+     * which is realized before the TSP), so the remap is linked in=0A=
+     * directly instead of via a QOM property.=0A=
+     */=0A=
+    a->scu->tsp_remap =3D &a->dram_remap[0];=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
@@ -317,6 +345,8 @@ static const Property aspeed_27x0_coprocessor_propertie=
s[] =3D {=0A=
                      TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
     DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
                      AspeedSMCState *),=0A=
+    DEFINE_PROP_LINK("dram", Aspeed27x0CoprocessorState, dram,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 4025ea3205..5d34dbea5e 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -935,6 +935,7 @@ static void aspeed_2700_scu_realize(DeviceState *dev, E=
rror **errp)=0A=
     Aspeed2700SCUState *a =3D ASPEED_2700_SCU(dev);=0A=
 =0A=
     a->ssp_cpuid =3D -1;=0A=
+    a->tsp_cpuid =3D -1;=0A=
     aspeed_scu_realize(dev, errp);=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

