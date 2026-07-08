Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127C9C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOSV-0004Cw-Pr; Wed, 08 Jul 2026 05:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSQ-00048r-VK; Wed, 08 Jul 2026 05:20:43 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSP-0000NV-8r; Wed, 08 Jul 2026 05:20:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4LefeYiPxByG5I8kp4kt8Z87PYhjUAXoFG9kctrvi7ASjGpnGdT6aWFgYaZAQm+lJpMrLJl0h/lEocG+mln0VVAhWvKF3lzR9GYNUnn82ni+srfPAdWtEcsiAbI2ciihAabmK0vHnhxGcIXyaCfExHCzuSYxslceU/GNBhhhMWeQN+obpy0NqU7rcb2BGXzUlFGPAM4UumSrCW6kkltiEeLPwu/R/N+44B/1zE9klfuDlAM9xnBdg2dpDyFNOGAeRpu8MFgG7yGV/h9M6vFj6meI0PH6/abWoddYPEWBjlO8Pqd99gcSUczAvCDGAwsYBky7vOdz3HwRi93NaMUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX/UsMypomTsvqKRqN8I0nRRlK3wsYPbcABKLMqQMFc=;
 b=l9xmOK6JR0fh5tnq0TqJJUAWiv9OSbxf7j4YmRt6dG3N4BtaAaiDc+P56OTNMbcPE5S0GYBUK47EjaSwBpPwRVHy086X4QtFJMpqNqtmcOku5U7RJbMWijimMpEO3U8KA+MQY8ZrHi94MvwZPXYIOVbATP5VHjq3YKWXZSILBS0xX5UGevtD9Jj5lLzvxQGgLSqdR/5lGv6hTWkkYE+17NxBAfW3VANA9KuMeUfAmSpQtB+wXYSQ1X/tYyn6MnuZ2PS0ukFSM4PH+ZOlPK5NCQSHAFIOZx+NjWWIAAssUgNKgJy8GSms4lDvZjWzqetkRdxPHFTrxZWwI/mK1iJQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX/UsMypomTsvqKRqN8I0nRRlK3wsYPbcABKLMqQMFc=;
 b=N3sUeez4k8+F1/U0+i9o9xhW/k/IycqfaKqDhdixZErD5j4XRMueADCFY7CXy0vTxzokNe6hHscKlmzUU9TSgEQUsX+31ft2CtdONwxxAEf5Zvzi1OPVdVIK4ZrsdcXssURrkxxPxS8RKr3h59vMBqr6lM4OCVkkmdhqTH1PfPooww9yT3f7lCll6rU9R0wfizDHqPylREhGsJy92A9FCYNlOOL7xyp/oLtg5iK5r6iZpXkU2SwQDsOP/UIrufnt4e9V2WB/KHDwXv2BxGpDjrnwvh1oBPcQWVK5ncMgzHMGL7TuieEEzG5prn4TQ8pO8OW7lKV/ItuGpmz93B+v0A==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 09:20:33 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 09:20:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 06/10] hw/misc/aspeed_scu: Implement TSP reset and power-on
 control via SCU registers
Thread-Topic: [PATCH v5 06/10] hw/misc/aspeed_scu: Implement TSP reset and
 power-on control via SCU registers
Thread-Index: AQHdDrsH90codjYdo0iZkdPj6nXDGQ==
Date: Wed, 8 Jul 2026 09:20:33 +0000
Message-ID: <20260708092023.3826159-7-jamin_lin@aspeedtech.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5499:EE_
x-ms-office365-filtering-correlation-id: 37f92a0c-b5a5-479c-d72f-08dedcd229ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|5023799004|38070700021|6133799003|56012099006|921020;
x-microsoft-antispam-message-info: FsznCVDAEUw8Zq/7EmFFNb4QubPM66u6QZYLTXico3rxTODVs78cXdBfVV17sMSpm/92qkZku4XZB1pEFu0aIUJkUU5sGZRJ2W5AGWBUSdHHDEoDKjl7MeLVUR2mFeoPDr8Zt6vR+/+TQhT7uvzdQi4xN+8GS+lRGdO4zlkwULnytklbJHOBix2BdzpKl10erM+O/dWaJRbIwwwwUOJzVko4UOqiC+1AE3yIpn02opqN+j8NV3iJ0oymkL9Y0PzXi94NnTNcSpEkOUGWo2f/emmwpre6WHd9TjqWKw1DHBq9TyJ42QLFS7E4conB1h4rR9rLAf5dt20My5rS3g9vYFRG/3p0RbJSJYbdm8lrlk6sjvO/FQO50TwN0ISeVsk/GYJPGqA2CqkXVbPC6GeW6I8m0rQo0+Pgn/DpcDsW3sONyHl6piMoUy+bs+K0lnhrL/18hM9zlpGOjMJjWWEpVP425YMi3OyASsTyeJSMmTsdcoAd4Uz7U1QoKB71BXPRDkm7sUc2lpHatOhw5Kg0UNa+bGgS/1ATFIGS3uGfBzmOYjvF55kKJ8aZpXUjcw63cr4cuZu7q2wjaO+4GJMI0SmDupNTCisVDpqWo3HVrZXBqVPMPDNeo9APO34MD25MwFzKcteGG4n0/pmL1TFhv/xC7CwXn7lr2hWWx6iyrU9hg1fRHI1+W5HeILuRVqadM5HdK3lDj/XZEQ4pqR3cv5hTWYcrnGy7OYNiS5/0ZfU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(5023799004)(38070700021)(6133799003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9ok4LsmtvZe6aAc7svcl5/6RoEP+3IcmPI0lFQ+qBBYldrshligTpFInjs?=
 =?iso-8859-1?Q?7NREReGab4rq4SU2GBOecZHDRDz9Eva6PoQa/L4QOjt/D+RdLegPXnrHv7?=
 =?iso-8859-1?Q?w0QKRp4CWAQx2fK8hJ7r2kR2xoesTQgSh/rUPB70PfnzYdytjE5CMoP9c6?=
 =?iso-8859-1?Q?eDaKosgbMVGVz1FQyuGgpIRWWCADh/JqGEoH/Fx9rel+EAyuOMM79WqxSt?=
 =?iso-8859-1?Q?NKPyVtNLZdpa2Ah3BdG1tcnEU28yBYbSG0OhrtmjwADO7akhvoxAZH2VW3?=
 =?iso-8859-1?Q?Kur93uOcg171lOOWEFSZqBbtxB/aUtGDINkHdEz6vnow75N9PPLZXzx3Kp?=
 =?iso-8859-1?Q?x7PhUw5FL8rJ1BlIZY4ULzHUaTzKIMiBaGYDBe5TRJQ0pHeVmOGyslprLV?=
 =?iso-8859-1?Q?6+vcjwS/rGevbs2INNRCpm/AARGBptwZMJC0YWyqgQ2r73hCjmRxkQttfZ?=
 =?iso-8859-1?Q?KfTsz3GZ6xY4kznryqYTeZoQb0CxTp+kilCBjpOe2PurRp+A0TwLho6nVv?=
 =?iso-8859-1?Q?FN1Je+tEgBrkzoC04YEH9K8x1OC/8Zn0YdXjnvTKFhgTwTLbX4vF6y2hYx?=
 =?iso-8859-1?Q?sLI4iYLpl9fqJTIB/tnQ4WvzmBooFdpG4UyrWytYxCevxFiIBDMo8QHjpV?=
 =?iso-8859-1?Q?uiX9LDggKrpachc1kI0il9eJhLgpq9CPj0a+TxenRXFMCDjRdFzSCsQNom?=
 =?iso-8859-1?Q?26QwSvxSaXsFxyXA3kXYzo8SAWfU+TfwcXj5npdoigsZ7cMD177qzDGcOF?=
 =?iso-8859-1?Q?NcpDn6vt4P7nCBrd8cSoPS5idTUa+qdyO7d+bm7a9XHGID1mrEfSmywFsj?=
 =?iso-8859-1?Q?1caMopwjNemP7TiijBMKRiaqns5jQugxNAMYv7ddTZ/ryn4QUpOluhhnHA?=
 =?iso-8859-1?Q?wrl1rbaOykRpZSxwZEHbbPVdgMI6bbXLm6tH8nLfMBRdGoWlir/7m8j+Kz?=
 =?iso-8859-1?Q?b1jipzDGwW/vQVGlzGwa72ofJQPqiRM2aTcH22BHAdyq45JEB2j7bsJrX9?=
 =?iso-8859-1?Q?KjKJIsFl9lXymUpygHDtINeCuKnsTBtIYeTTBYZCaWmV6GPSg0l9I9P2Ar?=
 =?iso-8859-1?Q?M9ihzVMJdLa4gRR91SrPzeOnMfQAalS8OtpFUmb9AmAtvsLB1iE47b38Ey?=
 =?iso-8859-1?Q?pHmezaIPi5heEFOImOEJNUQto6BcsJhXySlikyoPXNOoZfzQCWr0o739yt?=
 =?iso-8859-1?Q?6nYTbo51ry7Eicrkk0CyUqDnrLQwqR+mT7Lv1UlJaHuNEhHa4uQg3ms6Vp?=
 =?iso-8859-1?Q?A0fP9PTghB3OONrv7wYPU5ikmGnzbNU/vpS2aOmpWQ3NPg2X/LInPchfCZ?=
 =?iso-8859-1?Q?/tbGePHNQ9+dGXxVSqWs6mYx0GwbAPWZkD0vt3EgqUcxIzkPeah91hutS8?=
 =?iso-8859-1?Q?5cyKqfTPbkf0K6Qq0NO1bpIdGv5k3Hg87FnWbwTrQM5rsYnKlqxHwfXQq0?=
 =?iso-8859-1?Q?uq0v97iL2DhgeoXGpPQpY2QMIJNB+owVckILlOqszEKAWRkA69pn8T3guv?=
 =?iso-8859-1?Q?D8Ra7e6iPHGS6/8/Dals6L7ch+4JSE7eCo/xUp4JsVmC38d4/V8ULuTUsR?=
 =?iso-8859-1?Q?c4L0Z309c6hv4xqWbYxZa8/6XnhdCXPJeWnUPrj/P4jaI/LfBRwYtYTB1S?=
 =?iso-8859-1?Q?E8yg10IZav7Pc70CU8LFmdyXXhLVhQTf5+Sa/77ku9vOPZU7P7i8JluCkk?=
 =?iso-8859-1?Q?yaaBkZ+H/4M4WBC7SqeFBiAY2rZ9/TnuoAO2C7vkXJ8Hdu77v4NFmOppi4?=
 =?iso-8859-1?Q?oVg8nxvvBDSiJF9HAUv0j06S8xHKALji8KN9ycb//mR0KVwAkCavo3ExGP?=
 =?iso-8859-1?Q?eoriJq8A+Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KTW4BWtwBzc3kvgS1y56oQTXJYbeHcDhfTA5jpfHo/jxVTiwPkk3aGUhEiV+dG6yHYZK/2aUKWbNRfFGg3Ocg9M7NClfzkola55u+erJ3Ph69059gS3q6fO+gWTozZPljHzGiTFW+qWYgd/xpSkbR7QtJY8qiGDFsTMqRhwivmgpJCm+FNNFyacUIzYxDjUL1K3U6an6YyQyzuSvC2OuMIh12hi+njMvgTzhOhJELRs/ZoBtug15tnZabVvMpkfpgwsin1U7gO26Hd20b/zpxHMMxSRNB8A7HldXi6xGALvWyPtT/IP79HueOPuLgKa1OEgEV1cl1Z3RwYtlEwUARw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f92a0c-b5a5-479c-d72f-08dedcd229ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:20:33.3636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZ2X6XTkbOSKl/sxsaAx1BFKz4xkInZ+FZ8Kl6JYRWbD29EDzPeoQs0I1xZqpHYRyW40U3khiBRHZsccKyjHdIGFxk9YviDTmmBkA/N1HC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
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

This patch implements TSP reset and power control logic in the SCU module=
=0A=
for AST2700. It introduces support for the following behavior:=0A=
=0A=
1. TSP Reset Trigger (via SCU 0x220):=0A=
=0A=
   - TSP reset is triggered by writing 1 to bit 9 (RW1S) of SYS_RESET_CTRL_=
2.=0A=
=0A=
2. TSP Reset State and Source Hold (via SCU 0x160):=0A=
=0A=
   - Upon reset, bit 8 (RST_RB) is set to indicate the TSP is in reset.=0A=
   - Bit 10 (RST_SRC_RB) is set to indicate the reset was triggered by an e=
xternal source.=0A=
   - Bit 1 (RST) is a software-controlled bit used to request holding TSP i=
n reset.=0A=
   - If an external reset source is present and bit 1 is set, bit 9 (RST_HO=
LD_RB)=0A=
     will also be asserted to indicate the TSP is being held in reset.=0A=
   - If bit 1 is cleared, RST_HOLD_RB will be deasserted accordingly.=0A=
=0A=
3. Hold Release and Power-on:=0A=
=0A=
   - If RST_HOLD_RB is clear (0), TSP is powered on immediately after reset=
 is deasserted.=0A=
   - If RST_HOLD_RB is set (1), the user must write ENABLE (bit 0) to TSP_C=
TRL_0 to release=0A=
     the hold and power on TSP explicitly.=0A=
   - Writing ENABLE (bit 0) is a one-shot operation and will auto-clear aft=
er execution.=0A=
=0A=
4. Reset Status Clear (via SCU 0x224):=0A=
=0A=
   - The reset status can be cleared by writing 1 to bit 9 (RW1C) of SYS_RS=
T_CLR_2,=0A=
     which will deassert RST_SRC_RB and potentially trigger power-on if no =
hold is active.=0A=
=0A=
5. TSP Power Control Logic:=0A=
=0A=
   - handle_ssp_tsp_on() clears RST_SRC_RB and RST_RB (if not held), and in=
vokes=0A=
     arm_set_cpu_on_and_reset(cpuid) to power on the TSP core (CPUID 5).=0A=
   - handle_ssp_tsp_off() sets RST_RB and RST_SRC_RB; if RST is active, als=
o asserts=0A=
     RST_HOLD_RB and invokes arm_set_cpu_off(cpuid).=0A=
=0A=
The default values are based on EVB (evaluation board) register dump observ=
ations.=0A=
TSP reset control shares the same helper functions and register bit layout =
as SSP,=0A=
with logic selected by cpuid and distinct external reset sources.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 37 ++++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 36 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 07901f2ab0..2a20253410 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -147,6 +147,7 @@=0A=
 =0A=
 /* SSP TSP */=0A=
 #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)=0A=
 #define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
 #define AST2700_SSP_TSP_RST             BIT(1)=0A=
 #define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
@@ -155,6 +156,9 @@=0A=
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
+#define AST2700_SCU_SYS_RST_CTRL_2      TO_REG(0x220)=0A=
+#define AST2700_SCU_SYS_RST_CLR_2       TO_REG(0x224)=0A=
+#define AST2700_SCU_SYS_RST_TSP         BIT(9)=0A=
 =0A=
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)=0A=
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)=0A=
@@ -923,7 +927,10 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
ddr offset,=0A=
 =0A=
     switch (reg) {=0A=
     case AST2700_SCU_SSP_CTRL_0:=0A=
-        cpuid =3D a->ssp_cpuid;=0A=
+    case AST2700_SCU_TSP_CTRL_0:=0A=
+        cpuid =3D (reg =3D=3D AST2700_SCU_SSP_CTRL_0) ?=0A=
+                a->ssp_cpuid : a->tsp_cpuid;=0A=
+=0A=
         if (cpuid < 0) {=0A=
             return;=0A=
         }=0A=
@@ -979,6 +986,28 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
ddr offset,=0A=
         }=0A=
         s->regs[AST2700_SCU_SYS_RST_CTRL_1] &=3D ~active;=0A=
         return;=0A=
+    case AST2700_SCU_SYS_RST_CTRL_2:=0A=
+        if (a->tsp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x00001fff;=0A=
+        if (data & AST2700_SCU_SYS_RST_TSP) {=0A=
+            handle_2700_ssp_tsp_off(s, a->tsp_cpuid, AST2700_SCU_TSP_CTRL_=
0);=0A=
+        }=0A=
+        s->regs[reg] |=3D data;=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CLR_2:=0A=
+        if (a->tsp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x00001fff;=0A=
+        oldval =3D s->regs[AST2700_SCU_SYS_RST_CTRL_2];=0A=
+        active =3D data & oldval;=0A=
+        if (active & AST2700_SCU_SYS_RST_TSP) {=0A=
+            handle_2700_ssp_tsp_on(s, a->tsp_cpuid, AST2700_SCU_TSP_CTRL_0=
);=0A=
+        }=0A=
+        s->regs[AST2700_SCU_SYS_RST_CTRL_2] &=3D ~active;=0A=
+        return;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n"=
,=0A=
@@ -1007,7 +1036,9 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST270=
0_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
     [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
+    [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
     [AST2700_SCU_HPLL_EXT_PARAM]    =3D 0x8000004f,=0A=
     [AST2700_SCU_DPLL_PARAM]        =3D 0x0080009f,=0A=
@@ -1038,6 +1069,10 @@ static void aspeed_ast2700_scu_reset_hold(Object *ob=
j, ResetType type)=0A=
     if (a->ssp_cpuid > 0) {=0A=
         arm_set_cpu_off(a->ssp_cpuid);=0A=
     }=0A=
+=0A=
+    if (a->tsp_cpuid > 0) {=0A=
+        arm_set_cpu_off(a->tsp_cpuid);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)=0A=
-- =0A=
2.43.0=0A=

