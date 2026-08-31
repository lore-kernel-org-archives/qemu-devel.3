Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3327EC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0uiD-0004mz-Tl; Mon, 31 Aug 2026 01:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x0uiB-0004mM-Nm; Mon, 31 Aug 2026 01:37:39 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x0ui9-0000vD-5f; Mon, 31 Aug 2026 01:37:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dL/hIvX9Fsjc3hO7JHa/3hi5SMm7OPmhIi1HoWPM9ACCvfgQ/b9Oa8jlB5Xvt3dR4Kj1FS1opQJluvg5twO7XdSHSUU4WcVTNY/GAPtGGMqtJbHW5q6Z6B0N1rUXyJ1h4ajliRoK2If/BPlPyCI/Sb6POE1TMJrPFFPw7hgZ4ONFFPFNJ9wsAuGXwZtpM7QN3TiozLAjhsx6ifOT9zzrpLVrEOLGeApeuwe3+st8K8IAvI3suDoilHo65Chl0h4lktUTgX/mLQMucvRNIEd5DV+1GtVEdByOo5y8TswJyZdDTGx7wWT5F8vel5urnMkiZ/2Z6nMmNEX1N0KUg7UWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARNvaIjwN9aCJ+utZAZURboj9S0e+Rqs5G/m5k/NbSA=;
 b=uYem51gxfUPpUgYoHYHsB7wnlt9eoREJZ2D4cSs9NRJKKLn9Qeu9YRg2JiO/SMFt4qiiCrx+45zhY7vzaibmNzj+8DngVDrVhUmQGJIt4coaKgIStZwFgkDob+RcdCqpbexZ06vr7Ry2kYn2NI8X7fS2pB07CTa//3WlZsOQa/+PE9C/6kJwYqHchHwnkcvrrZfvhLJJTeZJDmCGdsxPrzk5TSToTiHKyMw6UdcmafCWX5JNmhtVaKcGafqn8Mni8ehnbda1oVCoY2roTVzTH/lV6d/piokk+AA4fWcHCd6XQsye1+HHFi4ndb7UKvXtxYpz4KY7lqI5+hL5cb9y0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARNvaIjwN9aCJ+utZAZURboj9S0e+Rqs5G/m5k/NbSA=;
 b=JRC6RCTyluc71RlXmq0KR8auXUWeFeQu6V4kyCjSEUJFKOTe3rqjPsC5VvN2ExZ2Ax8Eh680ltAnWz3y8GgHP+k+FNcn/dxqmlXyQSd4g0TNh+lwwRq7VVHCGGgGdJ/dtXu5W5uwdIdoGoNCYheg1Le9h2bcwijL7+XqoOlQDB3PuMT646bzc2A4hYaHdnE/hEFUKyPCQzwkbOIAK7/p74qZY1GysTvghJ8jMB2CwLE9DdUr5Vl6yy8x/TRkSVad54LFpbaFbODmrnpVxYeeD+0XrhfFdzSJQd8pR3bD3501wkasrs3vKVNVdUMnJ3O9GZohF3SDjsxmft5xvG2n2w==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KUXPR06MB8654.apcprd06.prod.outlook.com (2603:1096:d10:a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:37:00 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 05:37:00 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 1/2] hw/misc/aspeed_sbc: Derive ABR state from OTP config
 straps
Thread-Topic: [PATCH v1 1/2] hw/misc/aspeed_sbc: Derive ABR state from OTP
 config straps
Thread-Index: AQHdOQq+cBR9EwprsUu3rVJhF83igA==
Date: Mon, 31 Aug 2026 05:37:00 +0000
Message-ID: <20260831053658.462203-2-kane_chen@aspeedtech.com>
References: <20260831053658.462203-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260831053658.462203-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KUXPR06MB8654:EE_
x-ms-office365-filtering-correlation-id: 67382dbf-b12d-42fe-690a-08df0721e11a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: vlQvx3i4eaUF7FCV9AVgTbxEJ/BAfNGRmb3GlG+8uSdQvCcjoQPojCAg57Oksfh6rhXTam8dVXkt5D+HIVKBVIF1ANU7K4faTznc5QqP+y6w6JgENW+yxO4vtKZutnZ14VsoLPCweRjfVqzZBomrJlU/ZauKy0mUu6LR36uDIp2gDK/NswbpH2sPhzXDsSfNEDLiw7fEAVliXBbl92b/Ld1OOxUTVToOvoV/rG2g7W9ZGFKtk4MnQ4DB9XZCz7WDc6uVI4+ZuqoOn6wjhFSKlv/XSMqcBSvNQkZzyygHN7nnow+n6kcMRbLXGh2UaBHumH0bevgsNC2TbWrf374nQKKiekSa42AAk8p1HaqaIW0/TisyV85v6Lz5Nr7Tmyf5Z7of5MPNEkOgcaR8JniGXs4l8CpW8CIiRBc9mm0ar5Np9XmNYC2kN42Q9iky9Fgothm1SfgFWWY+XajAloMtrPUipR07/ydsRtFEqk18NKpLUIn80k23jxZMZFB0UQZe6Yh73Wbayp2ID09tasLOykVt3ERGw4qW5+c9PCjYvv1RX/2k0oDPkE6WZ+gwE/51SShx856kCHlySMhKEMWzlVkydh0Ym5Fk8KpDdlvNLWTuSJAsTy0hPKCtBhtNuWSoE3+hEZjTe/R1qfQUoarccdIa8/WYi60f9M3eGLNmL28TC1/DYfULUE/YSVORD29r9Kugj4PBRYep3oz2w7iy+oXeRfDLWdpee1qC4eWs718=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gbeQehPVeeHZmhltsIBsbfQXPdWoskHaacbq2GXLMU6Rl1ZG5dhHcNWmb5?=
 =?iso-8859-1?Q?m7HkA8cvq7qolQyo4xc2t3Csd96m3k+bvDslB2/N90mMY/Zs1fMSn/OXwV?=
 =?iso-8859-1?Q?oqxbKG2jyHpy4J0AApR9FztqtXv4Fqr0sH0zvIOoi0vbjkhnep35yzs8+i?=
 =?iso-8859-1?Q?JdgnpLEhq93QCJBykbDWfQhbt23gr/vKynbwHmT33sE7GFw5RpA8/AKH9a?=
 =?iso-8859-1?Q?VflpSgfpclHbXucgiGZPTT+rSfvmzM6/GVfbvWVwzK+eIMjxpfTcl3l0vw?=
 =?iso-8859-1?Q?S0QR38rai8u9U7lVow3rUXHxh2j1yGIuJfnkOsUF9iB8xmF1jbNs0KEyNW?=
 =?iso-8859-1?Q?fNQDomKhBM1rwRD8zuutTUZN0tU8lJCNlZg0cVGAaK22TrfWwsMD68WyDv?=
 =?iso-8859-1?Q?eqGJae/fZwAhPIgedAstPQ0YLlKfd+e+ZzlKtnsLsilngug26TpUgDmX7j?=
 =?iso-8859-1?Q?4ngG9aCZJzC3wX4t5i0GhmBx0ECQM8LQ8P78bAVP0trt8BI0Mwuc2NUkvd?=
 =?iso-8859-1?Q?UVYlUWvsWiFiClCL4vMh6ql8d2wyn26PhBT+GykaQLsWC5kvC4nbpQ9Yzz?=
 =?iso-8859-1?Q?kvGcJW5gkDPm/fQE1xLKoUTWjL67FPxc6Z0TQ8y9ajPTR7VMWrG0tXJgG8?=
 =?iso-8859-1?Q?d/k2pweJij4aOUoYYXcHFaExnF7ftqHEKLT7LM3B/rxd0SNYqM3nJsH9Up?=
 =?iso-8859-1?Q?za2LJgkzNWPoR2RPinss76AaE+2l+kFXYa1qhW3tvR/k09M0CdWiJlwIw7?=
 =?iso-8859-1?Q?QssdYWaTFpolizaWqLUKsRr3/QzEvO+dnPcUuXZP1ky5FgOHC1OvKlqkeU?=
 =?iso-8859-1?Q?Al3wQDfEnjWMhXUX6ayU7nxgoFtszWsVoNTo40s/a/XeVivzLbmxnh8/56?=
 =?iso-8859-1?Q?LamXT+ZQmv0uWxYoMvJmgoTggDYMZ8zNBuU9frVCNK8G4nHy0lcLhR0Tgm?=
 =?iso-8859-1?Q?RdWFwGuWnm5+fc01zl808DTFmNkR4rRxb2UeeSsYtWlSKuxSXRcG0Enpu4?=
 =?iso-8859-1?Q?pmfW2fkODmh84kmNE+xTyQEzNoZga+CativmAZhfreTrYrdH9JD5uOqynL?=
 =?iso-8859-1?Q?zBgwp7YIkfp3jp2y4kacdNrGnuKVk9yYLqEDCXWDAyj7kApdVJzOQnJln+?=
 =?iso-8859-1?Q?mcC7SK2ifIpawPXI6q5vAVxm+CGnNpP2a44c2oRzQtlGUzclK8txBFqpDE?=
 =?iso-8859-1?Q?w2y997zEg4BKfL76KyL0v338/lGnLmGpmP6V1xvZlM5yYPGDoh2vtvq0e1?=
 =?iso-8859-1?Q?UgJ0gWL3WDU0pWbw2qUdFB3L3rD3UgoLevgd1OEFkKAb7P4XbBkdJz2mvU?=
 =?iso-8859-1?Q?gZ7zxVJYwjG1h+TKysr+gkhwvIJ2xcGR0bLyJRJGvIDXPvoUNzhcUs8/KL?=
 =?iso-8859-1?Q?JBwJknfWaQ1UdM1aRdVO8BGsJ3WAqGSlPH6VV/eiOZXLavhY63nvQqrn8t?=
 =?iso-8859-1?Q?Gd66U/9epTOSqg9jnI8S3kNWl9yEaPbLJdlPJdqtMHOACy2vfpTI6qvV8D?=
 =?iso-8859-1?Q?tyXIV3T+l3L6YodNLQ608Y5ttBuWNJFDGFCSW6wmWicpzBaV3RsYllmwri?=
 =?iso-8859-1?Q?jZ7Bb/F0kHnnDmJprq55KRoVVKGKa7AlxSTfZlFs4prpIfjIfoDuuhku34?=
 =?iso-8859-1?Q?iBcCAFETnVduUdLsgNcXsBpbE+pqF+Kd5I4Mt84Wg+5rRa01KnkRISHWcy?=
 =?iso-8859-1?Q?Ka/c85ind/7O7FBSVj8tfWgQ2Wzt0vO3hZDeN9UzGsLcfzSMYRnNvbnIfw?=
 =?iso-8859-1?Q?SDjGVRTbV+94JwIsS1Ii1+sNnAC0zl7o4cDNIBGaN/FE9nMwNUMOYhXk8H?=
 =?iso-8859-1?Q?T6qG+hSqmQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1y10Sw4aI/quGFOs1M8s2x+EmzZOz9PU9osSsPZRlpRnTIqyFPh69KfmsYORegBuo9GZS+1GtWE7xI0chCnlu4aYNMNbRjGFlW2blOdJLXcpUgIKJvqjbFAkPNgJJZCVUpFPhivSUhQlRx7skrQ5C0jZThPk8ZS+sSk5QRIPCmWk9j055bgUeRXhuTf54GqdFfier4fNqSp9ZYrfaZgxtFjW+PGdUTmHmc6ZEdjCpb+YuSI49OnxxEeJNdrz68HjxT0m3h6cbaqFVsaiPMfA3kSY5a+dMbDGvUZeOWV7uDDwn7Aelo+UPGEPAK9E+tmXnFrE+fJLtUxEkfy9TlCJsA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67382dbf-b12d-42fe-690a-08df0721e11a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 05:37:00.1296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U96jgfnC+Wh8F8qiXqhlrI4SIMkn0E75bRkc+KzUiXlbjobAl32Y6skJAw9C7o3YZ8gGK6f5DgddFR2ESPh64FuzbufsK7vwCsjl8DsJxyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8654
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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

The eMMC ABR (Alternate Boot Recovery) enable state was controlled by=0A=
a fixed "emmc-abr" machine property, and the logic reflecting it in=0A=
R_STATUS was broken so ABR could never actually be reported as=0A=
enabled.=0A=
=0A=
Instead of relying on the property, read the ABR strap value directly=0A=
from the OTP configuration space and derive the enable state from it,=0A=
matching how the real hardware determines ABR. The now-unused=0A=
"emmc-abr" property is removed.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_sbc.h |  1 -=0A=
 hw/misc/aspeed_sbc.c         | 35 ++++++++++++++++++++++++++++++++---=0A=
 2 files changed, 32 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h=0A=
index 07c7c22a86..7152497b2a 100644=0A=
--- a/include/hw/misc/aspeed_sbc.h=0A=
+++ b/include/hw/misc/aspeed_sbc.h=0A=
@@ -32,7 +32,6 @@ OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEE=
D_SBC)=0A=
 struct AspeedSBCState {=0A=
     SysBusDevice parent;=0A=
 =0A=
-    bool emmc_abr;=0A=
     uint32_t signing_settings;=0A=
 =0A=
     MemoryRegion iomem;=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index 1dfcf14e5b..5d4da39d30 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -60,6 +60,9 @@=0A=
 #define MODE_REGISTER_A             (0x3000)=0A=
 #define MODE_REGISTER_B             (0x5000)=0A=
 =0A=
+/* OTP Address */=0A=
+#define OTP_CFG0                (0x800)=0A=
+=0A=
 static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
     AspeedSBCState *s =3D ASPEED_SBC(opaque);=0A=
@@ -261,17 +264,44 @@ static const MemoryRegionOps aspeed_sbc_ops =3D {=0A=
     },=0A=
 };=0A=
 =0A=
+static bool aspeed_get_abr_state(AspeedSBCState *s)=0A=
+{=0A=
+    uint32_t value;=0A=
+    int i;=0A=
+    bool enable =3D false;=0A=
+    int config_offset;=0A=
+=0A=
+    /*=0A=
+     * ABR is a strap setting, and each strap setting consists of six=0A=
+     * sub-values. Read all sub-values to retrieve the latest setting.=0A=
+     */=0A=
+    for (i =3D 17; i < 28; i +=3D 2) {=0A=
+        config_offset =3D OTP_CFG0;=0A=
+        config_offset |=3D (i / 8) * 0x200;=0A=
+        config_offset |=3D (i % 8) * 0x2;=0A=
+=0A=
+        aspeed_sbc_otp_read(s, config_offset);=0A=
+        value =3D s->regs[R_CAMP1];=0A=
+        enable ^=3D (value >> 11) & 0x1;=0A=
+    }=0A=
+=0A=
+    return enable;=0A=
+}=0A=
+=0A=
 static void aspeed_sbc_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
     AspeedSBCState *s =3D ASPEED_SBC(obj);=0A=
+    bool abr;=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
 =0A=
+    abr =3D aspeed_get_abr_state(s);=0A=
+=0A=
     /* Set secure boot enabled with RSA4096_SHA256 and enable eMMC ABR */=
=0A=
     s->regs[R_STATUS] =3D OTP_IDLE | OTP_MEM_IDLE;=0A=
 =0A=
-    if (s->emmc_abr) {=0A=
-        s->regs[R_STATUS] &=3D ABR_EN;=0A=
+    if (abr) {=0A=
+        s->regs[R_STATUS] |=3D ABR_EN;=0A=
     }=0A=
 =0A=
     if (s->signing_settings) {=0A=
@@ -323,7 +353,6 @@ static const VMStateDescription vmstate_aspeed_sbc =3D =
{=0A=
 };=0A=
 =0A=
 static const Property aspeed_sbc_properties[] =3D {=0A=
-    DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),=0A=
     DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_setting=
s, 0),=0A=
 };=0A=
 =0A=
-- =0A=
2.43.0=0A=

