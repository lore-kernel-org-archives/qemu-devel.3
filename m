Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D159C4453A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmj6F-0005NG-9J; Wed, 22 Jul 2026 22:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5m-00056d-6Y; Wed, 22 Jul 2026 22:23:22 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5k-0002ZN-8o; Wed, 22 Jul 2026 22:23:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRCbAgTWPgZbK8ykWYrL5BL05LNagPIGO+W1zYGRIJd1wqRvt5YseS+RGD2QYw5FYf6B4Ku4c7rTHh8ZwrYUOrZp77VCXeswR84tv+Zv5GaeIwhEGbKjod7on7KfMnVJIZH1x7sYq9kSJBOaoWr5a9uFoTEB9WAHMGGZDDFFR+N11y6pk8oYeyBoZqA90kGq/82DOF+g6diGcCyIDc45YXoBeU6tYO0XUv257ZNx6Dlpz//ALY2Rwq/zT2WylGpbO7AjOmMD2jXC3eVnvRx9DHqu7cshPhW7A4ElEGkevN+roJnMlVrF6rZAG/kTn0HfDUFCBndYVyREloxQmySPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnzGrQpmRWSgNGiCoejUhS1iLag125E+i+IgTBUSPqs=;
 b=Mce05pCglRgW/v2e67vGmdEJO8pjEqGClTxyCD0qlYr/w3I3yMdhai+74bUfwoYIniUYV4a/MHlV/doRJYwKZAtJy65tuHP4hKcpL0PKmVHHuGcEkke+H/VyHMM+SMa/SB74aCdMy0XvBnpAGfc7SjoRalQgQfHGV+Sj9rNHvyd9cxbyyY2DpcUFgtT0pNj+bywt6RIbTDxh+kzfZF92e5GoMZi2mZHrIQsAICjg7iUBTeVh7uVQRca0ziDwI8vpaYF5xDvcZ6UnZCyf7bN2usjn96wrrV0CjwWW1QU2eUJvXVXfSKFHIPqvq2edsOokXh274SZM26sk2YYjQV3Fcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnzGrQpmRWSgNGiCoejUhS1iLag125E+i+IgTBUSPqs=;
 b=kMC5/MwTqiPFFZ9CGsEvMUt3Uemp+zkzeMyyZneyStFf68ab0j9YI63s0WQCNLwgj+a6H6uEMOBVGRg8s5EAyRPY5n3DZusoBu8TlNDCJJrEtTkJFrVbfMMDBGDx1MAnd2/oMx0kYXOYyNBlk5ZFKLOAv4AnZiUISlRrJ+rA4WnkIUXSU7GRggs2JWwo6xEdm87ArASbtZ184tTWzpoNw1smVGyV2bkD8nnwT2YpONLUX0DIQoMO8V11HMCCc2jEjlNusmUZWbBnFKECMkNIfO7qMk7MqDFhEtOPGs0VP240A2s5yHZJLPdqaDJutda9v49Xse9Z63Zi/A8O2z6X7w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:23:09 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:23:08 +0000
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
Subject: [PATCH v6 06/11] hw/misc/aspeed_scu: Implement SSP reset and power-on
 control via SCU registers
Thread-Topic: [PATCH v6 06/11] hw/misc/aspeed_scu: Implement SSP reset and
 power-on control via SCU registers
Thread-Index: AQHdGkozq6jCVKCLWEWAq82GlUPI7g==
Date: Thu, 23 Jul 2026 02:23:08 +0000
Message-ID: <20260723022300.4174471-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: c5d93554-5dd9-4061-eb19-08dee8615626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|921020|38070700021|6133799003|56012099006|5023799004|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: HxjBqZZfICSLzSTVH0FRboR1sz2Qxw45gfGtIWAjTgsMxYf/L1umTWLbhBiHRPY6INdY+qvR8UPrdEuBS/zU3u60P90DnG2TuxyqdYI5tuHSBwgysPZkwxuKjU7pW6v0tshyBgC6/RN6Xb+wqhHfwXPoKvjdMjXKvA8deIV6/Bsp1AKdRLBuuYJr84OAgQ1xS5oy/bmMR2lynI3BtVvzQxjirl6NFjm+6l6kTJp7VdWsz2fJLViTvOdvhYl9wAfBZNiF9938gpeSHw/CKZIxjdbUzV3icXYSNwJ6hZMTYdlgNXLsKNSxx7zqin/UqibXrlizoBJK4jcPdNhCPpkWrdKr53/pHDFlk3v3p4vYMlNBXgaHdfAJgZNJtdQdftX8+jWgdxuQs1Rra5SxvRwXSGvgfFxHT/pQPad2JJZkoLtcQUkNkWVUwjY0TiKETCYGLNAhG8Tti947wdNPLN8EiPGqyw4WdXuJk69j5tRMzNnIPGvtXzD18N7FdSLsaVoyZ9fkm4QWgiXkrFanTs96qPHNnOtPEVYaRq+/L//BInBIZPe1VFL18SRnE+cHcIoCXFyge0s9SMKZqV/Sxy1C80zEZIOwf/RkExqWimv5peBNwUwnYUjLtS2qyeAE2Hbkq5hWX6JqEQux69luWpsVxj8r5dVGCXZkS+1+M/OI4+ahtwRjAwr355blQJJcK0auWYCFbwhO8K+gAr/MnY2ASfWMrb9nn0/9fPD5IPDeZ+4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(38070700021)(6133799003)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VxDwVlID92z5X+gu9aQqveICDxO+uiyiE/Cl0K97gFJ46d+yBNFzNs47sr?=
 =?iso-8859-1?Q?3IMKY5zZyP72ZBL/GNlrf3nYncblSeXLx+JnXBJYhOk2ORsJO4NBwk26UX?=
 =?iso-8859-1?Q?gBvyT+CqR0u+V82fWIlkCPGcnjYeOdfjWodoA3sQ7bBcPZNz5VscVjXgK8?=
 =?iso-8859-1?Q?K8mReKiE0CAM07VAOGWPs4Uu9fkE1X7IlsqHmpyvv5qndOcyq1VegheksR?=
 =?iso-8859-1?Q?1/jc+OqSoomXe7BXRFiza/bCTciEBx77Vd5nwcLstPY/ANi3svOe5RhRj9?=
 =?iso-8859-1?Q?TvNHP1fI27mxcnzd+BpX91WGmPcOZy20zvNjesBe+Gz3KHUKghUh8b7eZI?=
 =?iso-8859-1?Q?rSI4jJGV4cyCsOtxwLjlhSVuY/TfGvWAKIDq17iuKPo3YO5HoJsPxBTUsI?=
 =?iso-8859-1?Q?QbB/f6kuBqVFP6MkTyVjRH7UM14777mdVO/USnSCIah5bHvBjakHGXPDOe?=
 =?iso-8859-1?Q?obYRt2zh+lPNpgTJWxQ8HZUEeMF/q5ZcLmRgN9rWuZJOxYSxt4hMoI1Omk?=
 =?iso-8859-1?Q?V+o6Wp/5YtwDCSeyNT/DfdQYpzCzcVGUhDbQ0MMBXaAKrnJwPTPyw2vhWV?=
 =?iso-8859-1?Q?te5IDt7VaU63vK3FUe3ghasQQKRfws5a7BGPf5p/eKn+FNKNRpOXXQ6HHW?=
 =?iso-8859-1?Q?WdB77Zoi6jeYVu/MhyQbenRbKueqEDDdKWFTDocgFmWSkHA8LUXCBNLGDo?=
 =?iso-8859-1?Q?enyQzE0Zdqlbe++Ckv6DBwLo8Xe2417IrBIsnbr/thKy1yeIu4pFI9KcGg?=
 =?iso-8859-1?Q?XmojxOGquU+y2iQvc1911DR49iGsX2eeKsuv/kfWS4EQ4UceNjxxE2F+3e?=
 =?iso-8859-1?Q?XDXLGaeWkXtFn0CRRFMSGEl784+e2CbPUTHJQ4mLk09uaaJGOMaerC20Nl?=
 =?iso-8859-1?Q?Py8dJStrU4/EyLqbkPAUr01IYJTtgydg8n1mpVyZra64BkcDogZzdxWr0W?=
 =?iso-8859-1?Q?fCkUyE6t3pKzHTruoQVAUtQ6W4dAJVJ+054/P9yNdmPASSOlmFyZYvO3o/?=
 =?iso-8859-1?Q?zGldmgXP8dMK8fzAAoCJ6zX0GiOA1GfvFsWkerhjUYaHCcd6a7GNBymHbS?=
 =?iso-8859-1?Q?w24DRAPl2E2qAahYbrYbB4O+geAQZXlzqVYbM4jstB/4VOymBK/CINSmP0?=
 =?iso-8859-1?Q?1EqHz1bmOj2uPUV23TrLRZmZ3ZN8eVMz3qLMNZSdsBUbJhKTH+NSpRj8ZW?=
 =?iso-8859-1?Q?oComkt8TdOr++J5thmUfPqyklnuNN6nxUvYfbToAuWhN+/Cr25T8EJn36f?=
 =?iso-8859-1?Q?bcWYl+xDdwV4+djbeMJlTUlTr8zWAgwzj0FP9baGP+1BjuaYKHFl4/JMej?=
 =?iso-8859-1?Q?w/n1V8rzK/8S1p/X/gKbu+yDris1eLHV30S7D9cMh68W7aUskRLn0nnNq/?=
 =?iso-8859-1?Q?XhIphBqnuhmmZL0P/RNoaHVJoFdjaw/mxLfyNzerOYy5Hs4fPLRqfcbaM0?=
 =?iso-8859-1?Q?1aOMHRe2NmOmEWQ1VSi8P4qXMDLIPMWuu7I6Ko88U5aBj0JoJP1WYt+b52?=
 =?iso-8859-1?Q?tFrfUG9m3xsN5+r7JqFrPu7JsIS3/fINOAzTmm3xHxjK8EuxP/Y2Q31pii?=
 =?iso-8859-1?Q?0Gpgpll0czML6re2fvJ1NdFgdrGsqQoVAmWddVis0bqR7HLb8VQ3Vdo0t8?=
 =?iso-8859-1?Q?ZVpdzgHvaKRQXu/PkghavctxHtFA4cbBWIlcnbkW4AtiMCLLSvUuqeIw16?=
 =?iso-8859-1?Q?MXj1ptmuDrLigXKL0BaQD/wJldFArvqrL1r/gYkivmx8nKCIFBzm7x9VxM?=
 =?iso-8859-1?Q?hjs22az35Mdv6pkHraYRK7SvJgzWyxn86VH1WFLzlksmusEdHlP5M1Mnke?=
 =?iso-8859-1?Q?DG4dCw963w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AKs4nh2hYQsG8iLPXtVi4A9iEcQCcs2dqbfGDpiLttvJSmpQ7IXgEoZnsvxRrvvC5WZS8YcZACzFwnvSG024s3Bl8kQE8xIt2eJ8jagvtHwNWAhrtZ6jAiCGMdyFvX18bW0f7ejUcmbehN2C117JZ6MvtZufLy0T/e9q7oUHdSZsJL/0vztHFUaLPq6P/k2cod66CwSEAb/0H2xaL2Zqb4JOTx+Tm6CkmJjrIwDz5oojXIM01xCkXpwAE7UXIWETlCWiOjkWJk/Zrkihzywlg+ZeZpQZ+gmCXsQ7lyNIotLGrmWUuzy3Oi0RKIzkmzCwSKnhSxvyuRmP8zwPoKgLcQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d93554-5dd9-4061-eb19-08dee8615626
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 02:23:08.7848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j210CMf4iEipm3bxMiEqmKnorhgXZ4/tIphaFUQ/E5iDNE9PTCh2vWrUn0Di/IK0FYIV/udUV1w9ATgDhpyYqMl5rVh2yKUL+Fr7siwn+Fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034
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

This patch implements SSP reset and power control logic in the SCU for AST2=
700.=0A=
It introduces support for the following behavior:=0A=
=0A=
1. SSP Reset Trigger (via SCU 0x200):=0A=
   - SSP reset is triggered by writing 1 to bit 30 (RW1S) of SYS_RESET_CTRL=
_1.=0A=
=0A=
2. SSP Reset State and Source Hold (via SCU 0x120):=0A=
   - Upon reset, bit 8 (RST_RB) is set to indicate the SSP is in reset.=0A=
   - Bit 10 (RST_SRC_RB) is set to indicate the reset was triggered by an e=
xternal source.=0A=
   - Bit 1 (RST) is a software-controlled bit used to request holding SSP i=
n reset.=0A=
   - If an external reset source is present and bit 1 is set, bit 9 (RST_HO=
LD_RB)=0A=
     will also be asserted to indicate the SSP is being held in reset.=0A=
   - If bit 1 is cleared, RST_HOLD_RB will be deasserted accordingly.=0A=
=0A=
3. Hold Release and Power-on:=0A=
   - If RST_HOLD_RB is clear (0), SSP is powered on immediately after reset=
 is deasserted.=0A=
   - If RST_HOLD_RB is set (1), the user must write ENABLE (bit 0) to SSP_C=
TRL_0 to release=0A=
     the hold and power on SSP explicitly.=0A=
   - Writing ENABLE (bit 0) is a one-shot operation and will auto-clear aft=
er execution.=0A=
=0A=
4. Reset Status Clear (via SCU 0x204):=0A=
   - The reset status can be cleared by writing 1 to bit 30 (RW1C) of SYS_R=
ST_CLR_1,=0A=
     which will deassert RST_SRC_RB and potentially trigger power-on if no =
hold is active.=0A=
=0A=
5. SSP Power Control Logic:=0A=
   - `handle_ssp_tsp_on()` clears RST_SRC_RB and RST_RB (if not held), and =
invokes=0A=
     `arm_set_cpu_on_and_reset(cpuid)` to power on the SSP core (CPUID 4).=
=0A=
   - `handle_ssp_tsp_off()` sets RST_RB and RST_SRC_RB; if RST is active, a=
lso asserts=0A=
     RST_HOLD_RB and invokes `arm_set_cpu_off(cpuid)`.=0A=
=0A=
6. Register Initialization and Definitions:=0A=
   - Adds SCU register definitions for SSP_CTRL_0 (0x120), SYS_RST_CTRL_1 (=
0x200),=0A=
     and SYS_RST_CLR_1 (0x204).=0A=
   - Updates the reset values for these registers during SCU initialization=
.=0A=
=0A=
The default values are based on EVB (evaluation board) register dump observ=
ations.=0A=
This patch enables proper modeling of SSP lifecycle management across reset=
,=0A=
hold, and power-on states for the AST2700 SoC.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 109 +++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 109 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 5d34dbea5e..0fdeaf5648 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -20,6 +20,7 @@=0A=
 #include "qemu/guest-random.h"=0A=
 #include "qemu/module.h"=0A=
 #include "trace.h"=0A=
+#include "target/arm/arm-powerctl.h"=0A=
 =0A=
 #define TO_REG(offset) ((offset) >> 2)=0A=
 =0A=
@@ -143,6 +144,17 @@=0A=
 #define AST2700_HW_STRAP1_SEC2    TO_REG(0x28)=0A=
 #define AST2700_HW_STRAP1_SEC3    TO_REG(0x2C)=0A=
 =0A=
+/* SSP TSP */=0A=
+#define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
+#define AST2700_SSP_TSP_RST             BIT(1)=0A=
+#define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
+#define AST2700_SSP_TSP_RST_HOLD_RB     BIT(9)=0A=
+#define AST2700_SSP_TSP_RST_SRC_RB      BIT(10)=0A=
+#define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
+#define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
+#define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
+=0A=
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)=0A=
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)=0A=
 #define AST2700_SCU_HPLL_EXT_PARAM  TO_REG(0x304)=0A=
@@ -841,6 +853,35 @@ static void aspeed_2600_scu_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     asc->ops =3D &aspeed_ast2600_scu_ops;=0A=
 }=0A=
 =0A=
+static void handle_2700_ssp_tsp_on(struct AspeedSCUState *s, int cpuid,=0A=
+                                   int reg)=0A=
+{=0A=
+    uint32_t val =3D s->regs[reg];=0A=
+=0A=
+    val &=3D ~AST2700_SSP_TSP_RST_SRC_RB;=0A=
+    if (!(val & AST2700_SSP_TSP_RST_HOLD_RB)) {=0A=
+        val &=3D ~AST2700_SSP_TSP_RST_RB;=0A=
+        arm_set_cpu_on_and_reset(cpuid);=0A=
+    }=0A=
+=0A=
+    s->regs[reg] =3D val;=0A=
+}=0A=
+=0A=
+static void handle_2700_ssp_tsp_off(struct AspeedSCUState *s, int cpuid,=
=0A=
+                                    int reg)=0A=
+{=0A=
+    uint32_t val =3D s->regs[reg];=0A=
+=0A=
+    val |=3D AST2700_SSP_TSP_RST_RB;=0A=
+    val |=3D AST2700_SSP_TSP_RST_SRC_RB;=0A=
+    if (val & AST2700_SSP_TSP_RST) {=0A=
+        val |=3D AST2700_SSP_TSP_RST_HOLD_RB;=0A=
+    }=0A=
+    arm_set_cpu_off(cpuid);=0A=
+=0A=
+    s->regs[reg] =3D val;=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,=0A=
                                         unsigned size)=0A=
 {=0A=
@@ -861,10 +902,14 @@ static uint64_t aspeed_ast2700_scu_read(void *opaque,=
 hwaddr offset,=0A=
 static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,=0A=
                                      uint64_t data64, unsigned size)=0A=
 {=0A=
+    Aspeed2700SCUState *a =3D ASPEED_2700_SCU(opaque);=0A=
     AspeedSCUState *s =3D ASPEED_SCU(opaque);=0A=
     int reg =3D TO_REG(offset);=0A=
     /* Truncate here so bitwise operations below behave as expected */=0A=
     uint32_t data =3D data64;=0A=
+    uint32_t active;=0A=
+    uint32_t oldval;=0A=
+    int cpuid;=0A=
 =0A=
     if (reg >=3D ASPEED_AST2700_SCU_NR_REGS) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -876,6 +921,63 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
ddr offset,=0A=
     trace_aspeed_ast2700_scu_write(offset, size, data);=0A=
 =0A=
     switch (reg) {=0A=
+    case AST2700_SCU_SSP_CTRL_0:=0A=
+        cpuid =3D a->ssp_cpuid;=0A=
+        if (cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        oldval =3D s->regs[reg];=0A=
+        data &=3D 0xff;=0A=
+        active =3D oldval ^ data;=0A=
+=0A=
+        /*=0A=
+         * If reset bit is being released (1 -> 0) and no other reset sour=
ce=0A=
+         * is active, clear HOLD_RB and power on the corresponding CPU.=0A=
+         */=0A=
+        if ((active & AST2700_SSP_TSP_RST) && !(data & AST2700_SSP_TSP_RST=
)) {=0A=
+            s->regs[reg] &=3D ~AST2700_SSP_TSP_RST_HOLD_RB;=0A=
+            if ((oldval & AST2700_SSP_TSP_RST_RB) &&=0A=
+                !(oldval & AST2700_SSP_TSP_RST_SRC_RB)) {=0A=
+                handle_2700_ssp_tsp_on(s, cpuid, reg);=0A=
+            }=0A=
+        }=0A=
+=0A=
+        /*=0A=
+         * If ENABLE bit is newly set and reset state is ready,=0A=
+         * clear HOLD_RB and power on the corresponding CPU.=0A=
+         */=0A=
+        if ((active & AST2700_SSP_TSP_ENABLE) &&=0A=
+            (oldval & AST2700_SSP_TSP_RST_RB) &&=0A=
+            (oldval & AST2700_SSP_TSP_RST_HOLD_RB) &&=0A=
+            !(oldval & AST2700_SSP_TSP_RST_SRC_RB)) {=0A=
+                s->regs[reg] &=3D ~AST2700_SSP_TSP_RST_HOLD_RB;=0A=
+                handle_2700_ssp_tsp_on(s, cpuid, reg);=0A=
+        }=0A=
+=0A=
+        /* Auto-clear the ENABLE bit (one-shot behavior) */=0A=
+        data &=3D ~AST2700_SSP_TSP_ENABLE;=0A=
+        s->regs[reg] =3D (s->regs[reg] & ~0xff) | (data & 0xff);=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CTRL_1:=0A=
+        if (a->ssp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        if (data & AST2700_SCU_SYS_RST_SSP) {=0A=
+            handle_2700_ssp_tsp_off(s, a->ssp_cpuid, AST2700_SCU_SSP_CTRL_=
0);=0A=
+        }=0A=
+        s->regs[reg] |=3D data;=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CLR_1:=0A=
+        if (a->ssp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        oldval =3D s->regs[AST2700_SCU_SYS_RST_CTRL_1];=0A=
+        active =3D data & oldval;=0A=
+        if (active & AST2700_SCU_SYS_RST_SSP) {=0A=
+            handle_2700_ssp_tsp_on(s, a->ssp_cpuid, AST2700_SCU_SSP_CTRL_0=
);=0A=
+        }=0A=
+        s->regs[AST2700_SCU_SYS_RST_CTRL_1] &=3D ~active;=0A=
+        return;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n"=
,=0A=
@@ -903,6 +1005,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700=
_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC1]        =3D 0x000000FF,=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
+    [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
     [AST2700_SCU_HPLL_EXT_PARAM]    =3D 0x8000004f,=0A=
     [AST2700_SCU_DPLL_PARAM]        =3D 0x0080009f,=0A=
@@ -922,12 +1026,17 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST27=
00_SCU_NR_REGS] =3D {=0A=
 =0A=
 static void aspeed_ast2700_scu_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
+    Aspeed2700SCUState *a =3D ASPEED_2700_SCU(obj);=0A=
     AspeedSCUState *s =3D ASPEED_SCU(obj);=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(obj);=0A=
 =0A=
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
     s->regs[AST2700_SILICON_REV] =3D s->silicon_rev;=0A=
     s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
+=0A=
+    if (a->ssp_cpuid > 0) {=0A=
+        arm_set_cpu_off(a->ssp_cpuid);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)=0A=
-- =0A=
2.43.0=0A=

