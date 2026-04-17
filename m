Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B650F8E4A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtK-0002Oy-5i; Thu, 16 Apr 2026 23:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtH-0002N5-AP; Thu, 16 Apr 2026 23:29:11 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtF-0005oG-J4; Thu, 16 Apr 2026 23:29:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEdBAyENOs2qcoLGKLS31KfLicCkJAbI0bGVezQGx+K0P4+nUAPHWgK1U6w+G82rbNutlbbWXPO0KC9/p7xkGGyiFY6eGN/QDPdwY7sdy1hVPanmBcQXFrnaV8vjWMO/JPkxNOjmrT8Z/EBguNRbLIP1QHKdhw7F8LEl3UQ4Vg7Wobr9Q1UO6lR9VcxOnHlIquh14lKBjUeegUWQyS1xykNDwNfFMCRyJ7rheWHZgFVFO20iY9A7+wbZqFqLI06XzVbYdg7czWtmeJ7zhZba36ZS7jvNXXFC9MJsWU40YNPGyRTW7P3Nrr2fA20vOa0heB893El7UelmNHiWOOzMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGBcsL5vXANZXG27ZiTF4FHaBTTfRCJvp7uTlIvIeEg=;
 b=WpE+q3sCC7YSVo3xSvndU8aCjW5p7sCRwGiMjDRW1bhP0QOWTnvFZxSHFme2Z8z7jiEqRUeuUnuXPvEYAkDwc9qEsdswlAooAWoVXG/2siCKTWK53OmQDuOcyVVBhpXtE3a20dfmbK3Qi+jIANEMc32KG1p2yQSkwcDSNzkub8wWuZR8grpcaYtcBU0HweMpcoGytQC1hRrYhJFTBoTbiEdDe0J34DSE9FOt6chbr+364z0atXOl30pVV69HUN5vv+9QJLuEcp6RNgcO0xkMmdvnKL7i4jRwFjsHFouoxcUCl/Ep24kwcj+CAVD27udAfMo91b9f/MMtyOWhuPudJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGBcsL5vXANZXG27ZiTF4FHaBTTfRCJvp7uTlIvIeEg=;
 b=MmQkV2CkhIiMhQDQwPr6g4VtRAxXqb5LPxCZVL7z+xHeiTaismyWpvbSWugZbB7DHYD4g7YhnSdJN3hVdkTXbbDr7YfcjsdnML2rE/rYeNRIMHbA0DGER4lQDkTAPWwGh+tRtwV4tR02oAT2p+xHfCZc2XaCE2CuN5BAUQloScyAWCzwNzRtGs/tWSlbnrpFjTA2YCqvdljWCa/+MhielXwly06VYa8cpzailebZzKcSzMlUub6zG0w9i+Pd8RGUX/QNQP9pHn5WZQ3OYFRcnFxWJ+3Hdi9Uu3uoYgQF90M5cjE+HA5FzFEcxMqP3hBpdMlSBx9NjZnJHvjhkEsq+w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:54 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:54 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 12/21] hw/arm/aspeed_ast27x0: Add unimplemented Privilege
 Controller MMIO regions for SSP/TSP
Thread-Topic: [PATCH v4 12/21] hw/arm/aspeed_ast27x0: Add unimplemented
 Privilege Controller MMIO regions for SSP/TSP
Thread-Index: AQHczhpRMaer1y6L7EWYdovb7OoIMw==
Date: Fri, 17 Apr 2026 03:28:54 +0000
Message-ID: <20260417032837.2664122-13-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6299:EE_
x-ms-office365-filtering-correlation-id: 0c785d2a-027d-4fe8-08c1-08de9c317407
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: FLaytBROfXqa5S68aOGDrBuvGFgwNBDI95XIwgbVttNsydmd0g/G0xnJpaBr8NyYU6yQEc3zCDneSeJeiChROAqhfPx5j1QEiYAKTRTbSv3c5ewNSNDmS4S02C+npbA7j2KbvsdhZy/BVGqvtv7pG2oQAUF7bwUa75JPCFypzWWjoLh8+YS7FsPsH9Zn6bSdYpgjnQmefhDGFCzyrPEq920+R8sZyF/x01vSvyYqfuEUUMgjzPAMvlYfRKp+qBMcV3K8ip0MNGjn7PyzvqWV3T7Hqc3DwuvcJVCStrRrip7+yYi+WVQUm8EE8kfHx0EBbmaV/4OVCAfZD2uktzuMvltdNEVxCjPQPkUQXyQ5Jh7Duk5gIxgNA9IAI8S9bEH3M0L8LLtGXYabYJOD01xL0CVwiDRKHo3r5xSF23c9Yq6tc/2YfJUqwZEFi3NdbT1AZ+f542pDyzbFAKD6qOPvx/3pI6iEr0RPQF1B/YkP2gYdOjqO/v9R3fjulfwZ3WgtPNzlgX5XoM6El1DypF0cKDyR58uoI3nqXwx9yoYE6XVYmS67luu5nBr0viQboEU/6k47D4FPXtK8hXI4iHpRWmP1tzlmRvoKJfrlgBUp2Y0XBs9gEeNQdG4sJvTK+Jwe5E6Qd1qCeDCLOQotil1K+psFDzc2OXpX4NRU2Qosw0M8n3HGATKHd9CTpN7SeNEyT6vrIq2nzoNeRSSuaQBKiFHYIrgq41krk3+RJMPBWeyv40YvMjGN5/3SHH9It2ldh0TwqCkUQ7Ed21bFcKk+n8/FhCdoGIBX2CqskUgkXyj/BTZCqOLVPa7MnmdooJYU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XrlpuSkV1ixsLbJL1X6bz+1DHlHvb8LuZd7LjiPAKl8UY7CKw5SDD5veuM?=
 =?iso-8859-1?Q?E93EKnk7ujaV25UIB/2Rj0yp1vHvc4TTrglzVMCQP5rtX2KkiVQXBCX+LI?=
 =?iso-8859-1?Q?/zWUr37vIYCSEzJdiDOuV71DCcAOaon5rAf270lW56gFcgRaJYh39oIAa4?=
 =?iso-8859-1?Q?8n3NgrNSTq79WOfIgplX5oAYphUrgw207zMLOyn+IoC3McFAqEKtOWO3zC?=
 =?iso-8859-1?Q?fas8J0W1w7/3EbcqsQMG6gGz76Sa6g3L/oe1eDUSfCubKM9/vaUvjpMaNO?=
 =?iso-8859-1?Q?4/y4Wu3qKLiiMS6TZtmmKp3gCFma0xSbSrl8iUNyrKfyMJcQjOgWZIwP+I?=
 =?iso-8859-1?Q?lerIPIqi0dhGUBfjdO9qYjrvCAL4ktzN+VP//hoUhSX5Wm4xg3+T1/aKsP?=
 =?iso-8859-1?Q?PfAB8xIPjHI5P+ayI58W2bIDczNrhulXvXo2d2DWomCyoXhmUDu041ixmJ?=
 =?iso-8859-1?Q?DBjs8CSFxa62LAwAyJmM3w/RQ4kxLLjJg5Lz8P5T6cDxBskB6DCW+OMDAd?=
 =?iso-8859-1?Q?NyjsZY2OWGPhV9C+qPwUQAYA3cxtWCKjWFbXVHJD12+cG3LGzJ9knIQGHs?=
 =?iso-8859-1?Q?ny9DvvAzoRJr0unqa31zMOCwWb2PRP21jAsHb0t7RQFpD3ZqkKSI6gIz+5?=
 =?iso-8859-1?Q?EY00CPMQxiGCE55f6jax0Lq4jo1I6QMrXZxLPwXZYVus29K8SRhH9v+JrX?=
 =?iso-8859-1?Q?CB3sQBHCT6uxCm0Vc1ucdhbliwZ+fhZa570NP5k9upq0+UB3LzTw4o6yAb?=
 =?iso-8859-1?Q?5jhrd1K8DJ+tRwGMY1onjZCtGlgU8LeyNkOC1bSn2NV9CQ+UMs/QwHnQfG?=
 =?iso-8859-1?Q?GhxFbaPx5tNp8SQbXE9or0g3PMJSd1Gu53q/V1Hoybx2C7JqwwzyT0QCmK?=
 =?iso-8859-1?Q?LFdfgTkyrR/WY/tStmnZPjwcSnNB401+jgi08q1AiAK614H9UU/e/U+Lkx?=
 =?iso-8859-1?Q?Y7h0Hc9KTUmxye3X7xnnptK+sksYq3f2NKGNhaH+eO6bppIu1YsHRyzeei?=
 =?iso-8859-1?Q?2umBWo0j4wuLDYojqk3t5+Z12M8kn8+VwHpkT+SlduZcMUvkXmrGEx0a9E?=
 =?iso-8859-1?Q?u87DlgV+2nLr6hsMA7lBAJslezk1Yk77aE+9CMfnDypAw/4FCiiIvUxCmp?=
 =?iso-8859-1?Q?rxb5hzAC11aBGdSbo9UezGwsQjuVO0aCPrp9jsX4OZ4V9hU1f2UyK9US3d?=
 =?iso-8859-1?Q?o/RK9tXmIInKOQ1Sg30kEdiBe6W76OWbpFGaq7aN/X81yvLjFMYExKeHNA?=
 =?iso-8859-1?Q?oolEA+feyWONMFJv3oaxYEmErf91KhfzYiVAPx6tX9Q6ix4VVOTJOLk5Jj?=
 =?iso-8859-1?Q?uXXZi1oAoI1TUcXgy3hr+ZM7B1nKqi6sbxY/SWN0KAkEVyFefSw+m4Y2Wv?=
 =?iso-8859-1?Q?5kosDByawVnrwlvj0k8DCXEFTODH7bPxAOTXKV60rYYSAbXpRnSqx+G0mc?=
 =?iso-8859-1?Q?Y2wDuy/i/F4F/QQB2scILvodtFXnBFLXAP1oSBSC0Oydo4PwsZQiIzJ27n?=
 =?iso-8859-1?Q?iIAG97mJdpZ6t56wVKJvm//WIjx3p6F2g3uU8tNM5FmhT5CXuQv5QAWxNO?=
 =?iso-8859-1?Q?IZWqXhxo2Jmsk6BtS8FGYMB/e0qWR6/m42ukRHjgCFVbhRZy6lCluxhFQQ?=
 =?iso-8859-1?Q?0PXwvvpP+MmuRYAlCqsuvG8kHh428cNkjgpbpY+VZWOPx9dH/o2RNTziG0?=
 =?iso-8859-1?Q?ZmOzBUO6x5k0O2l8oqJAbkJy1TYfcD8bh6Y4FZVA2qOMB3crChtj9MJqaJ?=
 =?iso-8859-1?Q?758bWWhwxXa1VMsR0f4AkDi/BmyotRHwM2JpotDVsmrguOwdDHU9V8YxVN?=
 =?iso-8859-1?Q?f9O4LJuZVQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y2laBIJtbn3tjhCxny7dwel+A7RbXO8YwUlpqMb3a8U1v9077l4Kl7mVeYuJkhZ8Fb++s74HnGDzGRotjP3sKPC1y+kXKGd83pE4ihzjcWQOmCZ6EhLbkiHyJyIKIiQpuLFLMmx/8uyAx9exs8LOAYy3mJyqUvFqSSH52a09hm9q7T9SrdT89Z9dYLgENpmKtJW6uh7VoqF81gvPD9Sxqo57cv03Hyfh+0+ILZ4sjyPbZ8eiyM4dH5vwNFeHFvENcbHgZf+uQkfI/mWoYM/QVQjysQoMQFpU6cemL+TM6WwGQIU64b6b8akvnLaxhJACL+hqaQzen0/GXeXquXecTg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c785d2a-027d-4fe8-08c1-08de9c317407
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:54.6810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDKF+y3OauQ+/oioepSxI3fEi3dI3Pdw6wC61fuPoQSIH5iqw5iAhJGGrtm+EUMyVW95BAVZR/RYfDGptrEsLslOrLe62sR4Guu79qXWtSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  1 +=0A=
 include/hw/arm/aspeed_soc.h         |  2 ++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 12 ++++++++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 12 ++++++++++++=0A=
 4 files changed, 27 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 2460a11401..084040bbed 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -46,6 +46,7 @@ struct Aspeed27x0CoprocessorState {=0A=
     AspeedINTCState intc[2];=0A=
     UnimplementedDeviceState ipc[2];=0A=
     UnimplementedDeviceState scuio;=0A=
+    UnimplementedDeviceState pric[2];=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 =0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index adf2f2898a..d39e4f7553 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -297,6 +297,8 @@ enum {=0A=
     ASPEED_DEV_IOEXP1_INTCIO,=0A=
     ASPEED_DEV_IOEXP0_I3C,=0A=
     ASPEED_DEV_IOEXP1_I3C,=0A=
+    ASPEED_DEV_PRIC0,=0A=
+    ASPEED_DEV_PRIC1,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index bfd6fe4485..467fdea9db 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -22,11 +22,13 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D =
{=0A=
     [ASPEED_DEV_SDRAM]     =3D  0x00000000,=0A=
     [ASPEED_DEV_SRAM]      =3D  0x70000000,=0A=
     [ASPEED_DEV_INTC]      =3D  0x72100000,=0A=
+    [ASPEED_DEV_PRIC0]     =3D  0x72140000,=0A=
     [ASPEED_DEV_SCU]       =3D  0x72C02000,=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
     [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
+    [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
@@ -142,6 +144,10 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
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
@@ -276,6 +282,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
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
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 166dcb14ed..3a90bbec51 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -22,11 +22,13 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D =
{=0A=
     [ASPEED_DEV_SDRAM]     =3D  0x00000000,=0A=
     [ASPEED_DEV_SRAM]      =3D  0x70000000,=0A=
     [ASPEED_DEV_INTC]      =3D  0x72100000,=0A=
+    [ASPEED_DEV_PRIC0]     =3D  0x72140000,=0A=
     [ASPEED_DEV_SCU]       =3D  0x72C02000,=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
     [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
+    [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
@@ -142,6 +144,10 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
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
@@ -273,6 +279,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
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
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
-- =0A=
2.43.0=0A=

