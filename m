Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F21C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgez2-0004UI-KP; Mon, 06 Jul 2026 04:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgexk-0004HK-86; Mon, 06 Jul 2026 04:46:06 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgexi-0004bJ-DL; Mon, 06 Jul 2026 04:45:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3adWfA3dtQy0P+MRmXIdI6LI1x4nBiFNl9GWlk9vyo08OpFMs1z9rJQNENcFzOdUnbR+ExrGgy6ONslkLQlqKLAX7YHvTxlLtdjkdzqT1sKSyZ/Tj3KlKzEjgyI2ik1ZRg2BuJVhG9Vsu/k9Ty3STc0Q3C1cJ1GnLObSCqG8yp4OyKzNwGImS69btGxGv9CFlHEUoVMW0wFNKBSWqst1CrPKM7XXHjgewRBzkxFAGl19/JeUeYbsAJqY0BtpOEKuxJtfcLpqFcomtxNZck4pCrnio+pYbZTSaZH46YhNSeK0RiFOHvCXmT8gmblkUT4yiINH2etBBIQkQQt5P1USg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qZxtOQAdHfgWeuTjAy6DO5tbWHdGkD/Y7np602XC0I=;
 b=ONNBkJgc2wOuMRL4PZKa+TySK7CnjxHbGa0jzamOz9eHzR2XGIlXeyaOd4y43bGt+mA16K5am2RiqBsqLBsENTvUV6hz5AuVYPRsBZ922U7cvhUlvW9OD9QoOOu+TnffUo+akyizsBw0JVD8SmpPxZMQhER4lJ+E0Pe7J0A3yToAIKQ1pU9qGhlgPK2cn34HodxKdR8D1urWB0kq5KQS284ti1Qg7YNDyDJQ8rUbmtx44gYiDyQBXvwEwYFhMzGhUfEugjltqfTEVVdDLsJToIK4i7hHdhVY3T1wp3gxNdol1ih4i9hy3fTna0XIEIRK+2aFb9JgpGjsEOs5qCWQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qZxtOQAdHfgWeuTjAy6DO5tbWHdGkD/Y7np602XC0I=;
 b=ZBJGw/drFQ1dCVMPozhTVZYuTczUCqqlX5HcoNhYX+IiaO26HMGmUQ2cWmcTLD0y4eZOIQ86iaN//Go6fEsbZ4EQ+1iOGgdcnV9K/iKFClMcK6vyZrqekysn0Wx6AVEa2PfTtYoT+Yao3cgXBJCzFA6mUytJTf12oBG4H+SJdfb9h3C5Od7+uzoCA2MW/F7UbMl+0eBR7fu9Ag+Aa4dJEdJkjN7ePHa7FQav0LwFEPdlrzHpAmj+D3kCd8Lme1a0zwFTcFn/OleTjpzSR2E8s+/x8n5EwDCXclYGfktZ1FsKQbhP1A71g8QknbiV2tMPjhfa9X5yRSJ8tv/aENK25w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB6639.apcprd06.prod.outlook.com (2603:1096:400:45b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 08:45:45 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 08:45:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 3/4] hw/arm/aspeed_ast27x0: Move SCU link into AST27x0
 coprocessors
Thread-Topic: [PATCH v1 3/4] hw/arm/aspeed_ast27x0: Move SCU link into AST27x0
 coprocessors
Thread-Index: AQHdDSPVg7/CZ3c/qEOIL7bPlY6G6g==
Date: Mon, 6 Jul 2026 08:45:44 +0000
Message-ID: <20260706084540.1988785-4-jamin_lin@aspeedtech.com>
References: <20260706084540.1988785-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260706084540.1988785-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB6639:EE_
x-ms-office365-filtering-correlation-id: 45552ee4-1471-4ae7-742a-08dedb3af805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: mOOcSzDXrwwFmgPGBRLkCqeReQ6gDi2Pd6fVBdvRH4MNT7vMsdZPdHZPmcfjFAfiI93u3JIIve+IZmYXrUbXVqUOERzq2nWdmDQo1NWDh2sEc+yu0xzlHDs8T4KZGmwF0uxbHS2g3GT0gj3HSK3KbMVH80CESAYjAVgRLj8sb+a9wUt0nDiU0DDjT7GWwbc4A1rUNvaa0Lqx+o5nOx5ZiZeOLR81UqljdXE0nx/k30N3wS2LmjzAD5Lq3V9mZaWpfjn6jxWbNcILlsOaO2HzMpNSblJTJZS4D4Vjsy8x0e+OwfRZwIr6Jj1NP+FaVwIoH8vSAjqT2n22nG4BN+n7vNIWnAfH+UzjDErydioD8r5yJZRuOwmk36IBEi8IHdFIezTxfj445zgpWfK3lcYEOgAeyn0Df55yXCDEwcvomO3dxpo9GCtnuu/iRkSucxF+vnE0qcWaOieMNkXGjs+HOJBzhiYr+bHnP179UQwH7kjaiS5aB8/9EO8SE4Fr1/NpKuxL6VTit5IfddGYOEsoS3m4BUnd8bhiUAFin5lefJy/AUXDylLpHflQdV5p2/5U9Ft1SZhOMk4R2XZ3DGVx39SxkUKf5vVAf2RFpwdbG6TfDIWwMnuopOhtTWreYyjSLOwJgD9427SelcnLiyD/cY4UgPvGa2tUbyB0/rYPLiXq6SbpJSiAzRKRpy2Bdg636fyA0SWPt1S3vyfZR7xxLpxqTzRuGQVyXuW1ZAIlO6g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d4rx0RDRmiZ+md5S6MVaf1dP9EAlqr9xKOVEz7GQvm4q4anqeWScCEOlA9?=
 =?iso-8859-1?Q?ciZDuuV2XiIMFSdiAOhRJf3gj+Xa6owGZZhdK4JQg0UflrKD6prkPjcg6z?=
 =?iso-8859-1?Q?kyVVZrzTSUPR8XXf0wyDAV50a2g0batkbfpcsQQUii1KZW/glSrmSiZODW?=
 =?iso-8859-1?Q?0nn4H/q0Xg8opsJ1oAzn1Ma5hxxabuGGqBSh3vap1hq+gS/9N+Wdpw04Pj?=
 =?iso-8859-1?Q?v5KX6QgxcW8TEeVOsrohBrut4A2hwrkWzun13CQAp1oiqffwW0xnMoJnTV?=
 =?iso-8859-1?Q?StEV+vprf/r4NL9QV4CGWJDYpsQsGSTPOHOel/FwG6HQyczfH63G0A/Feb?=
 =?iso-8859-1?Q?cU206N+g7MEExuaQMhJcPLY2Je6kzwa7g4W08uLUbOW22PxPrK1K0EuDxh?=
 =?iso-8859-1?Q?6sk1LzEWfQKE6u7OKCrc5H61iNzjncDTuIqhE+pSi/gDYpmlUy3yfZ2v+/?=
 =?iso-8859-1?Q?fP+MUDoETsSnvvmIMTofMA9KaD6w957Nu2lKHErBNO9B6a5JLvKWOcym56?=
 =?iso-8859-1?Q?Z+r1cWHcA2O+aXUN/4Hk5B+tQyMk8/9EZ0ddGYH5PNw6RnhmG/f3T+jYEm?=
 =?iso-8859-1?Q?RS6kvsMCmGbTtBbWp3ldITesTlH/Pp/8+QZghjl4oNqng6eYPY5ljt6dLs?=
 =?iso-8859-1?Q?Gl5vM/GuJjNAWKmNo8y+bdjX/6nNeX2sEHmjKoiI3Noj+VZkwGPYH3IalC?=
 =?iso-8859-1?Q?f8JuuZdkvhgnfUa4rQXzczq1ftugPmIf4JmijFfVlsBBusKXrpBz9Ko3m6?=
 =?iso-8859-1?Q?T2uPTpBLR5XeuyCKDZOWY3G0Kcb8DEFerr0Nkj8eNOADN5RqhDJCQO7WLl?=
 =?iso-8859-1?Q?ptlzT/Xs/Jq1s569P3/ojNm+GvcMnkX2Qf/vmGlp1MWIaRgNnh7NHe+Ewp?=
 =?iso-8859-1?Q?3R2nYQKiev8dtmyzE/UttGoPfKVs9EcmMjnFDAs9Nldx7RK9pOl1H/Mo4h?=
 =?iso-8859-1?Q?2m26yhU8v0RTU69KQo9MjxBt1fO/NleP5k26aUS5C1Yfe7TLskLFM1Qbl3?=
 =?iso-8859-1?Q?lfQeM+ATRptRfSw9ZFE1ljtGlXwOiXAUWpF7Ok1f4hhzCGVxRP85zQ0mdX?=
 =?iso-8859-1?Q?qzR6ZGeJA5dLwXDA132VsvfH09GQMftW2v6Dt0YeLiPe9QDnR/1neWQv8r?=
 =?iso-8859-1?Q?UcqFpPPjSxie77wKV/5alB0kVAz+Zrc7SNY5XhwrKg2gidYoAqbZvsfLRT?=
 =?iso-8859-1?Q?CWBdQ1fx1jE+N+rO3FAaFfQigMWUfN+f16PxoQ4RtwkMjFydaWjZaXJksg?=
 =?iso-8859-1?Q?zJFICzAgTG62SurQFYShGGCvEn5h0BywguKcWbY4zDXw3nMnXvDyfiwp2S?=
 =?iso-8859-1?Q?JS6cQvqRI8cnQEhexTqqwBCSS/7HYbcGBBP/nHBj5HIS/oQqazWG0mjGRz?=
 =?iso-8859-1?Q?KL+q5RGnsYUm0gP7zguuFnUST91sghoIbfTKRJ2/m3/iwAEiHwifDUOiKN?=
 =?iso-8859-1?Q?GejC1+5veAaH31HAotfgaf2XLcE8KbcgzyZH75lcpT/58usOy6c5NvVrBe?=
 =?iso-8859-1?Q?hW3GW3DzPrLWHvLCeuwETUiWJ0QvW8N0x6v7PDZtx/cT6AgrY/+e01+lrW?=
 =?iso-8859-1?Q?lcG9iWr/a7qpP5vynqTEmyBEmfLNpQDNBF81j178HJocvQ6kRZnb+kpnLX?=
 =?iso-8859-1?Q?TBfMX5A4qgNhTS677LnE7W9WXKIOMYuJpc9NvrvOuPe611V5KZOXDDRRHa?=
 =?iso-8859-1?Q?S0OHQGK7QuZDXFMY98pR5rb24l+DwhTWnhVfsURUSrNjC8Uflmxw9AMxy6?=
 =?iso-8859-1?Q?v1uKEzeadYpqgF51xI3ChUcT2tHVwEaYWyFLS92jDiR5E2NOaIdUIBYzdz?=
 =?iso-8859-1?Q?1zWkThABCg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bPYmR/sGwV51Cc8PMgLFT0hB3rU5XeoKaDh5eZGaF2F/0h6qlohU1EfsmMQmilfh9u273+y3XlUrPNR/0AG+1aOOez5R2rsqZMICq7af8E0qA5NAm20B2+jIrrxyuvrEGql1mnDcI028DneaRO/1OTzWeZWCd0qp0OMuw42q8XMG4KqR+bV+7jN+WwugnPG2erFfU2EDYmSKY+q0+Ovg9Tdqomw8sAlhLzWE27mUqOzK/n4qDo3U/Qz6szMOs3mxTths3VFcqzJRS71QpgZYDLrIjG+Vb8AavChpBrE5chXcQCbS3jpWOkyYY3MRITxZI1YMroQx2VeRVtIPGGjTaw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45552ee4-1471-4ae7-742a-08dedb3af805
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 08:45:44.8492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NadrXG44tmXguZEkSemgzh//y43dlA+si+mnYN4i1GW2FhRSb0jalN0/ctXQKBJLgD6AljVds72/BF8vn1yiESJB1D81ugcDaty03kpaV8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6639
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

The SCU link is only needed by the AST27x0 SSP/TSP coprocessors for their=
=0A=
AST2700-specific SCU alias window.=0A=
=0A=
Move the link property from the common AspeedCoprocessorState into=0A=
Aspeed27x0CoprocessorState, so the generic coprocessor model no longer=0A=
contains an AST2700-specific dependency.=0A=
=0A=
Also validate that the SCU link has been provided during device realize=0A=
before accessing it.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  5 +++--=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 19 +++++++++++++++----=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 19 +++++++++++++++----=0A=
 hw/arm/aspeed_coprocessor_common.c  |  2 --=0A=
 4 files changed, 33 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index ac58a5f424..adfc3c4512 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -20,10 +20,8 @@ struct AspeedCoprocessorState {=0A=
     MemoryRegion *sram;=0A=
     MemoryRegion sram_alias;=0A=
     MemoryRegion uart_alias;=0A=
-    MemoryRegion scu_alias;=0A=
     Clock *sysclk;=0A=
 =0A=
-    AspeedSCUState *scu;=0A=
     AspeedSCUState scuio;=0A=
     AspeedTimerCtrlState timerctrl;=0A=
     SerialMM *uart;=0A=
@@ -52,6 +50,9 @@ struct Aspeed27x0CoprocessorState {=0A=
     UnimplementedDeviceState otp;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
+=0A=
+    MemoryRegion scu_alias;=0A=
+    Aspeed2700SCUState *scu;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 68a8ab26f7..17f3770770 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -167,6 +167,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->scu) {=0A=
+        error_setg(errp, "'scu' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 SSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -195,11 +200,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState=
 *dev_soc, Error **errp)=0A=
                                 &s->sram_alias);=0A=
 =0A=
     /* SCU */=0A=
-    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",=0A=
-                             &s->scu->iomem, 0,=0A=
-                             memory_region_size(&s->scu->iomem));=0A=
+    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",=0A=
+                             &a->scu->parent_obj.iomem, 0,=0A=
+                             memory_region_size(&a->scu->parent_obj.iomem)=
);=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
-                                &s->scu_alias);=0A=
+                                &a->scu_alias);=0A=
 =0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
@@ -275,6 +280,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
                                   sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
+static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
+                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+};=0A=
+=0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
                                              const void *data)=0A=
 {=0A=
@@ -288,6 +298,7 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClas=
s *klass,=0A=
     /* Reason: The Aspeed Coprocessor can only be instantiated from a boar=
d */=0A=
     dc->user_creatable =3D false;=0A=
     dc->realize =3D aspeed_soc_ast27x0ssp_realize;=0A=
+    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->irqmap =3D aspeed_soc_ast27x0ssp_irqmap;=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index b8a4f7c91d..636bfb8d2c 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -167,6 +167,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->scu) {=0A=
+        error_setg(errp, "'scu' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 TSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -195,11 +200,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState=
 *dev_soc, Error **errp)=0A=
                                 &s->sram_alias);=0A=
 =0A=
     /* SCU */=0A=
-    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",=0A=
-                             &s->scu->iomem, 0,=0A=
-                             memory_region_size(&s->scu->iomem));=0A=
+    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",=0A=
+                             &a->scu->parent_obj.iomem, 0,=0A=
+                             memory_region_size(&a->scu->parent_obj.iomem)=
);=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
-                                &s->scu_alias);=0A=
+                                &a->scu_alias);=0A=
 =0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
@@ -275,6 +280,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
                                   sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
+static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
+                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+};=0A=
+=0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
                                              const void *data)=0A=
 {=0A=
@@ -288,6 +298,7 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClas=
s *klass,=0A=
     /* Reason: The Aspeed Coprocessor can only be instantiated from a boar=
d */=0A=
     dc->user_creatable =3D false;=0A=
     dc->realize =3D aspeed_soc_ast27x0tsp_realize;=0A=
+    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->irqmap =3D aspeed_soc_ast27x0tsp_irqmap;=0A=
diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor=
_common.c=0A=
index a0a4c73d08..43026d2a55 100644=0A=
--- a/hw/arm/aspeed_coprocessor_common.c=0A=
+++ b/hw/arm/aspeed_coprocessor_common.c=0A=
@@ -27,8 +27,6 @@ static const Property aspeed_coprocessor_properties[] =3D=
 {=0A=
                      TYPE_MEMORY_REGION, MemoryRegion *),=0A=
     DEFINE_PROP_LINK("sram", AspeedCoprocessorState, sram, TYPE_MEMORY_REG=
ION,=0A=
                      MemoryRegion *),=0A=
-    DEFINE_PROP_LINK("scu", AspeedCoprocessorState, scu, TYPE_ASPEED_SCU,=
=0A=
-                     AspeedSCUState *),=0A=
     DEFINE_PROP_LINK("uart", AspeedCoprocessorState, uart, TYPE_SERIAL_MM,=
=0A=
                      SerialMM *),=0A=
     DEFINE_PROP_INT32("uart-dev", AspeedCoprocessorState, uart_dev, 0),=0A=
-- =0A=
2.43.0=0A=

