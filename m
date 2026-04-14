Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F82CED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhf-0003f6-LS; Tue, 14 Apr 2026 04:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhd-0003dz-H4; Tue, 14 Apr 2026 04:00:57 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhc-0005oL-2R; Tue, 14 Apr 2026 04:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ndb7YumKcqR+09RcXRTu+3SVumBkOWfLj/0kFJoFAoBkKKTfjjMAKUGWwhYS3GBrdWh/zHQwsmly0G2UZILf9VwZ1aYJsb+TitK7F6+TRy6WgD541gI2YK8yPy2zAudvZGEmOu8hfv2zOc6gLwNNC2ToHTb2YCPBG7p5OYvuRaC7EBKR7uxFGVzKlx2BagumZ0+S5mjrJVQuznVM+UFl0tAog8kbfheqZsud2SrL/GuZvBxvSYtYBGrOO5SEglkfeUaR2jGQbhAQBcm7UCmDaA8LOA8C6vUPmkfKvGOeyNTgZr4uBI3iKEzlnt9u5LTRg7F0zsNBeC8p+1PP2lYswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU8IkWc7WfKzrDM3ZBQ+aMW/imqYQd9QOl9MxOe/UGs=;
 b=KOj0EVbqeQbLZP1f8Tn9DXSu9RxBSKtYuQWkmOWA1Gnd5TJeporIWCJ3R48WR+7n/c9kI7my+7ZQ+M5KRUesgw6JeS5IrfINVLWEOQz84fZRbmW0KxAE1Mzxn+8ZBOdAaIUfjDWXDVmRsH/gFVChf9kti9iy9u1MOJCOMKBbPjw4rwjtMDPsCTAD5UXLAgFHmH3rna08nQkvpO9Xm87QrCl2Xy6uFvYcfYKl6cplqJFq2cK4kH9ZrlU5MvCps3ZlywkSMSgdh99ZDOTmdBBmVUEa2S8yv7QQaYfxeubabezPPpw3epIT3pxOs2wCIa/jnmZUUMnxzn2F8FDPApLclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU8IkWc7WfKzrDM3ZBQ+aMW/imqYQd9QOl9MxOe/UGs=;
 b=YavMIYNfyKZrL36x6M9ox0XXDpsjQrkac7uDufN7a4vMKWrgbMSnwxdxBHcMosaWJrlaJr1qVB8MszqManm72ES9IfNmf9kCqrPJD3yJE2nHaMbPPSmvHwhFnfgMMFyEJp6AeH69nx8Rz4odequTn3lO+GiqWUP/5Mh+T+sCciG4GjxKuRQmMqBvIm2+PwOMOciLWxjsUdz+MY3fqjrnVvmukNSx3fYi936PyMiJ2nIAIth2IGga/gEJ2oZdG4mq3FVl5cR0PsGoX4iz3cUd2Qe7F38BZOvfZ+lNnVl0cF+0d3xCGF7YLidkAS0P5DQSVFPNEV6yOXmWJUeqhGNK6A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6745.apcprd06.prod.outlook.com (2603:1096:400:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:36 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 08/17] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes without
 64-bit capability
Thread-Topic: [PATCH v2 08/17] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes
 without 64-bit capability
Thread-Index: AQHcy+TG7IgZ0tbh9EGKhlnAj2UbFQ==
Date: Tue, 14 Apr 2026 08:00:35 +0000
Message-ID: <20260414080025.3005916-9-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6745:EE_
x-ms-office365-filtering-correlation-id: 380b9096-beaa-47ff-ae7c-08de99fbe936
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: uKe/DhumztJHphZCStZJkcp6zB3rEt5k1waDo9T9jV/SLqXcgvfRWrpcchFHIeQ0oZ2WGfN5Q4zmkCjxSatHztVt2EJ9ooO9ON63JpTtIigTQu0AwSYJaQdFsA2tUKBbGQtP6kNgZea0zI9fNBzwwWLRc6p83xmShguusVVcTqf2W4oTZFQE0LUNIplHiBGc9npKQZ2L0OK0EleNrFEIJl82rJ6V8zkc5qG5JylbQdPtRJZJPhxghwgpFAofOTEuHu9j8xwOAzJU6yVqR07seKo+OmCBBmjoIX0wdBq4qCcCifybehvkSsj6OQuKSmYZp332NxX4/enD3/Ps3eGuzfMVxhFhxkAANMFVTRHwPz7zg4jxfiAF0wGuYxDlBtkhJencAoBKR/m0fC+DlChA3f4Nh8Oxj4Jx11gqDF+fF09WLctRR9cm4zF6mkNikldNmP/gOjkHCIIC6k0rFi/8nkyOZI6SvXsWB8Fjp4TNgzWxx4lFMKByA69LI3usZiz7RVffh9NgNYWm4dVEyC2BeUr0AFKr5wa05fcDrhTwuCuzmaXgZCFsimIN9qqMbVN6dYamSPcE0onMC027vOfBYrhUVMpnko87y2Fu25bm4jyACVWIRgf2YCVLOlMvixq1DRjRd/yenSlRZpLEHWdYZEz64ytJeUqxBlWUMsaDCJQGn0hDobJ8zmsC1QE2rGTHYULtSG3CGMhEY+iKB/ekyZrO64SPhehOtocFxyNTlLCTTLEy4jWrmxsdXX0uhFpi5GbAnNA69UZKsoskc4V8dyl1pJVR0SqIPwrXgx8rtd0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N4vbQ9fdCID3ir72TyItXjjEMMC3zgI96cGEcZ2BAwuugPM9/v9uqV+00C?=
 =?iso-8859-1?Q?tp7yy5sO6ZWmp1oyaNHzejUezEDa4LZvix0AwUSMNunqXeqnT7ME0PT9zd?=
 =?iso-8859-1?Q?c1dwEYWO7WfglBJ/FXP/AzE1IzScAqlBse0tAuID7O/+FLJzFp0HkdRPcH?=
 =?iso-8859-1?Q?NJFki4groTNKVeEJcl2ebQpDtx2Gru9xRZa3yISxuqFRVUJPIf7tK3s6Ph?=
 =?iso-8859-1?Q?Iq6mMaFAXUQT9Msd9tpKGsD9Gpmvw2Kxm8ifJds2BWNwibXhGYhPKNq8gl?=
 =?iso-8859-1?Q?QMwotOmQ9KEE20cAldQmxWH+QMGuKZcxaVrqr10sGjPnbJUgnIQ2CHfYvi?=
 =?iso-8859-1?Q?biavjX3WRHeL4ZDiouqsrRFMqrjlwdJQ415EXjwgS+tEWJfUkszUr3bKrF?=
 =?iso-8859-1?Q?PtHxafkSLS+zU6zsiIHnT+XAYSDk+6oRbFMHWXLkPoPeOIcuy0HX3KaUz3?=
 =?iso-8859-1?Q?W0mz3kFsvGNl48K+UKUIwDJuWe7LKfUq1mwhMjPaUXltqUUEldNe8bqvQG?=
 =?iso-8859-1?Q?fH75uKjYPkyc87/ol9O7+wRTzu0aaVaLVLvw42vhcHaWJqAZe6+SOnDzF2?=
 =?iso-8859-1?Q?FiyhhTBuil14VTJdEZn3s5UvgvvWJYoGH3KAjfZMFkX3A4L6MKkMyWKPCh?=
 =?iso-8859-1?Q?seFmbC28efWyJzDLgsDjfFL+wz0SdZJ9/8cUoB6RT8ZSluJyJiZfYfKvTX?=
 =?iso-8859-1?Q?GCST2tTCG9jarvCxeypFf4qGoxxMp0VQfPTdBb3fqpTuKtPm2K8JXy8DCk?=
 =?iso-8859-1?Q?gIE4fAGum/p8xepNZ7K3hl+rCEIuuWOcpoEQzQUlCmfA93bSsbrkCoBd9Q?=
 =?iso-8859-1?Q?G29A4cNOSovPhpT7+UGbmD9cN0akchsSqES8xDdFfFDIW8X2JXJ3dyTB+y?=
 =?iso-8859-1?Q?2m5GPvfvLQrIhFBhRUuXsIdxUu5IGAYN7F93vPnUA08pnSrNPyyK8SR6UO?=
 =?iso-8859-1?Q?9MrdSUweT8Y9kFiewGOVm0OE3SPxr3lQivLTxaf/byppEvtN2bZjwfB/EL?=
 =?iso-8859-1?Q?KrJ3LXk4zA1Oy97oDNEX7ZkwOCgLxBdo+e1hFi36+NgllUyiOccTMa1Ysl?=
 =?iso-8859-1?Q?M33nf7/j7+yVp3IITYlVnpn0x1LzWFnqGCHXCMp7/fV88OQukaQipIpeui?=
 =?iso-8859-1?Q?VQIm/KSp7wHVaZAWtJlvMj/FvXEHpbdj4D3wtEDSM8lSOJQjYa2FyssKUa?=
 =?iso-8859-1?Q?yyFUEO6mVASB21X0V1KTxjY3DU0ydpAK6U6N5sgQxxDCqw6/VGeTtgRABL?=
 =?iso-8859-1?Q?l1kBL8TQGekFM/XO62LDxEcuVt5uwzRIU5akLV7fm7fDXChYcUGc4lS91o?=
 =?iso-8859-1?Q?5Nwaxy9PE3nlGejPEBp2qFq7f4cI4VACHZvCIfgfzwOl5oswUAc4vwAwgO?=
 =?iso-8859-1?Q?8E7Zd8vL7Aowu4pYF84EK4LEm+F4FpGtB+54Wyvs3uyj6b1QUfi80VaZQ5?=
 =?iso-8859-1?Q?Q2sPDSwYlehiAbearmUpPF8odRwT5jZRsA673+MG1jU9G/CRjtNkCWUz16?=
 =?iso-8859-1?Q?SuKltktjJSQe2XXrgTjSfQhlW2fFywPRnj9yMWOwSSETNBScjgwwEI4I1H?=
 =?iso-8859-1?Q?80S/mdAwhT6YLDiUO22Pa1wSUsU+sRFuwBrdDwvkv1tUXqaA2z0TY5xOb9?=
 =?iso-8859-1?Q?Wvks8DNdvEGULAxMrU5dVT+toiMHAFLOlhrCB4UOVLthQCmCItcVu7X0nP?=
 =?iso-8859-1?Q?eKvqHpunomhxPyWv3f1avfiUvCmUCMiCARgtnEWsBmKTbWQy+GSWldLFvi?=
 =?iso-8859-1?Q?ttKIPJIt3iNdVu9w+NY/Qn43NYM2rnbb4es9NwJ43jTTjOZyqnYUb7oat5?=
 =?iso-8859-1?Q?mMdYvxGaPw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r3zpIWIYoy41LzXldVmpY+/7Ruli4obMmlzOz/UiYhsyWR6eFs94psd78cZTVOoFBJkisrau3Zpf9LKK/XYTXkWGp//ya3Nmlri6MVcuXEf4x152fDHSRvdV6ZhKiu2240viiPF0cY1CcTOFpkAhwNUyQCYWSTTcm8vZyuug2U2lU0I3QRqV9oZzvVyPh+Ovf3aKhY4LqwBhxLolZePjEcMC+uif0gcbQRbQsYwluO5TfDw/6oYMKvOX2wTmhUCNQWk3zYU0/0ifg3c/UWG+4Y1wJJcf0IBOo89t1MtMjPmLN3zm01LBCtCr9wvzj4fvWhwryyJ21CH635SLYKosYg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380b9096-beaa-47ff-ae7c-08de99fbe936
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:35.7570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6oxE8oLHeqlIzdWBs0xvOEFpXX5xyd3+uR7Xw8DcYDNo7J14HBWJsUKQaXPWmoDUt7ApddfTTOg0AvTpBkKrAt7VyhwtRYSRzBIVx6enmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6745
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

The EHCI CTRLDSSEGMENT register provides the upper 32 bits [63:32] used to=
=0A=
form 64-bit addresses for EHCI control data structures. Per EHCI 1.0=0A=
spec section 2.3.5, when the HCCPARAMS 64-bit Addressing Capability bit=0A=
is zero, CTRLDSSEGMENT is not used: software cannot write it and reads=0A=
must return zero.=0A=
=0A=
Add a capability check in the operational register write handler and=0A=
reject guest writes to CTRLDSSEGMENT when 64-bit addressing is=0A=
not enabled.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 9 ++++++++-=0A=
 1 file changed, 8 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index e3bff8e518..54a1a6f7f3 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1108,7 +1108,14 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
               "      is enabled and HC is enabled\n");=0A=
         }=0A=
         break;=0A=
-=0A=
+    case CTRLDSSEGMENT:=0A=
+        if (!s->caps_64bit_addr) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "ehci: write to CTRLDSSEGMENT while "=0A=
+                          "      64-bit addressing capability is disabled\=
n");=0A=
+            return;=0A=
+        }=0A=
+        break;=0A=
     case ASYNCLISTADDR:=0A=
         if (ehci_async_enabled(s)) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR,=0A=
-- =0A=
2.43.0=0A=

