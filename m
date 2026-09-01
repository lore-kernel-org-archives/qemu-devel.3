Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96131C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KEo-0003ou-GD; Tue, 01 Sep 2026 04:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEn-0003nS-2y; Tue, 01 Sep 2026 04:53:01 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEk-0007J9-2d; Tue, 01 Sep 2026 04:53:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiwhIIWdFRbWveoiYTeYX5dpzTUKxBIrTkcj+lOTVi2JT/sk/87l5CPLDApG45Ag1EdkC08Z0YBpwxAS7j1iudbCqAeeqGqyUDTdm4e9Yi8ZKnc3O9q1LxOsWthRxRBQl2nOGGG0vbcdJiMZoJGHz0Mo/PoXAkqV7Jx0OiywTjmMnnOOk9wUoiA7hDYKezYDBqGsKglpSiDQrZ0SzLZE0orWzgExfVFDJT2/z+hT+Lgy6P+fgMFKZ/+vVENhV9AyJ047Mqr6CK5zUs0frCbLK8xOKN5SXkRU+yvZEz+nZrY62lCd2aqy7OPtjW/owgk5/RLjFNIxF44Iql4ab1z5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kWM9Ff+8dKPj+Yw5NLDrDfVKxJNYNAje1pJoQW5WLw=;
 b=TuLiiw/dXMX8TlLiDZZqW1cMk0fRI3qmT8bdG626GtDGI6H3Y9BuGYeB4vYJHh8gt8lwSphe1+gR87/JjozbOxECIYCBkbaFZ/ACWoyjSbSP0C09/IYlPBhbRAeR44kxutiZkb4InIpvLd5yOIHs2q/PgXhQuPw8kFkXdXAj/SGhvQyBRXxnwiPm5vQvfdJlu4waNbYCSj3alG97m4ghnDEgrYfv+C5rhoMu2QMfZgW7OFewXRPCf3ttA+Lp9I9bMz7Jj43BbVrFsAX5xD0JpQ21TVtvyXHq+8Nh2GRS2k4YzyI376xAwJVrpZwlFwNcpTWUetRVU7kgNh4tfRCqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kWM9Ff+8dKPj+Yw5NLDrDfVKxJNYNAje1pJoQW5WLw=;
 b=W05pgPPlRQwVzxJGshWBuJHYxaKOVP1LNYskC4S+Z7NAZTvatC9jNgXele/4lXnMABI0xhAkoSGJh3uvcqdOj/0wbmyfGAbqVD44IEfvZa8J8k1euYgyKKaGPLg82KYk1MQbm8dmaaZTV4YU8sDB5TqDkV4JqPlhqnIs+iaOz46dVXUl0POH7vhSeZnI5AgUfdh3Si3p1biYIZClnEGKvNrpeU3uQhDOO6AuZTLNgRqjsN3QKEFHZwtgahK8etNVKkSNYvmY7e9oVXXInAhi6f52yWz8HVO5oDykn9KMhDWh0oBh4FLG5RW22On23SNt9vBMqs6TIRK1V6MftrTITw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU2PPF557D403C2.apcprd06.prod.outlook.com (2603:1096:d18::495)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Tue, 1 Sep
 2026 08:52:45 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:52:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 5/9] hw/arm/aspeed_ast10x0: Remove obsolete unimplemented
 SBC mapping
Thread-Topic: [PATCH v4 5/9] hw/arm/aspeed_ast10x0: Remove obsolete
 unimplemented SBC mapping
Thread-Index: AQHdOe9BHWfNKQKI70OzmvbwItmYTQ==
Date: Tue, 1 Sep 2026 08:52:45 +0000
Message-ID: <20260901085238.995968-6-jamin_lin@aspeedtech.com>
References: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU2PPF557D403C2:EE_
x-ms-office365-filtering-correlation-id: a1bfbce6-e236-4702-7e8a-08df0806640f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|921020|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: SQmw7GAdqZ/0/hTmy+UHfcV2y2xaemVysgb/dX/+THlSl/dQLB1MkaIXDhKdvwH++tnPDUXqHkuJvNKfDsmM8s/NVTrIAeP7FYjDG+i/6dFOgIZu8z5BA4wzZ/KORGrRoamPvskMG9YvNcEnKgHkMQMdc1LQDhqvplQg00Zp1VWJprbUKU34mMC9fidORtWaiyzbaW7yI8okGi/Xx/jJJI/X4SMSmkJoLwISTceddFb9PSafS5ZuMFJXed1VEigFQ/FEez6wR2vjPF0ySMBAzYOe8wzBIL+1IRJa/8sgNL1h44hntANxXmTnTHqLhsIfZBqDYVhofzK+UfwcsnAHaUBqr71mowPj7jaLIwijT4lprzHCCQIscPbBLT3/Fc3nVMMoMVwhR7OOAFyY87XdHfzEOsXUby5lONDNROyfOKCqXFoIjF5QyYy36aGI5xxcVPoMdqle0Wi/7TIJHKTQrODq2RzvqRxZDFOe1buBEsNbB8H604bWBCo7bBidPeAg1n0vyy8y/9TyNGzewcP+2lXWeWqCOZwN5LktG0/HQVCrJSjKbkR1nUiUjn6HsOBto4rSGHEpoUPBruekp9glETmwFh21FcUz8ce+Gdv3fKH3iwuo1Kb2GOCvPI6Y1nfHD36YbTsH/PuFOcUMqpyOp7SgOCoHnXy1nCYaWLm3gLhAl4o/FzuztkyY5cPDzTdXEF/6EpQs6PtSXfnqT7nyTZJb0VrySxvZmJqsj+2U91gv4ZJ1wNSaeoxYkpqv5HuJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(921020)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6VRoPxBNFeykVSNMAViccAKj/9NR4GpbELZ/swExtMSQ4IIEgF7M3u6whO?=
 =?iso-8859-1?Q?GUWsZP7DU388AJ8eGJGlWCFLroMoSICcv5iQ17wOMd4y5J0xAP0lz0W371?=
 =?iso-8859-1?Q?wj28x8JrkMiW7nO8cCGyrMyJvQjuynD09y/6jlIs7PYBd99mdsKyCXjMMd?=
 =?iso-8859-1?Q?0hhKPivxAIRT0LaS8YqSoUICyR3lkroJljw8LKr38/7IZ0dkEnUx/nBfZv?=
 =?iso-8859-1?Q?PisR+cZ/UW5jwgS+ePj9svVTfCE67fHskbt6bHYoUw43bBERUVuA2JwIob?=
 =?iso-8859-1?Q?Ew3sJoCuiqpgVAKMpiyu9VTh3X6nEF+iNu1JQ0oIrGyZwqdB0QQOVjBOQd?=
 =?iso-8859-1?Q?SDFvLxiz7ZbglxYd3msca2Kn20qLyWSVQb+Rt1X4gVLicOTBvNIyWKeCzt?=
 =?iso-8859-1?Q?oyGu0caSINztnZV7ZOobh82f9zK5Yn1NMIMyl6wPA7eeMkb2BaSpziaiTG?=
 =?iso-8859-1?Q?nWYZJpgsKSlACfY9/ksb8Bf8keoHxIxaLvonXEMIIN2n36pIu77zl5yP/P?=
 =?iso-8859-1?Q?zjMvrzxu/BZSCl8x2Bfcx7BLRMVLVpgUJU1cr7QaJAZWCJi4BLAaa7HLbC?=
 =?iso-8859-1?Q?zXt+q/6WQCJ4Y5x83T4XJxAVbKGGsB/J3o50pbraA3z5bIc9au4k/LNp/7?=
 =?iso-8859-1?Q?sd+xzrcJH3dLV02jFSW9Igzk7WMDa/ObNr6F9cAQC7j/A7CpB38j7raP9y?=
 =?iso-8859-1?Q?gLz+XUq1HeE33vDNvLWCDtXlzksO8Dm8htZ+zvwfQDWhW7vSfLxqa6KGuw?=
 =?iso-8859-1?Q?gnyzvirFvVP7pdPyKRhMyUZfyaPRUPAUCKOmL/GaFVAwVHq8WcxZq/a3Jq?=
 =?iso-8859-1?Q?LxhI9mi9Ke8CdbK1PLEZXhOD5PxQ2idv4LbQMkgj12J9gvF5Nvyx6lh1xR?=
 =?iso-8859-1?Q?Ibr8AA7/kebudNQGW7LZjCw5vgbPYehwke4umnyt6vghKmah7Q7KjTqQNW?=
 =?iso-8859-1?Q?K6QWvvlW43aYwdM07Wp9VXit5Z36xMX5aPT3LCEi/MtVfrdNiCATij8y1e?=
 =?iso-8859-1?Q?4YpBujv1m/qJL0kKS8Icj22TljsT+3Oh3ePyxFrM5I3r+H27BgMRFuGGHV?=
 =?iso-8859-1?Q?DBx5TbjvxGPEpUHRsh2DKUdotbYSYP8GkYEhkQiwHE0/HqDGLKirJDxXfM?=
 =?iso-8859-1?Q?0mxGEeJAao1z4yzw30P4Sg9bWrVSOaCsU5PgdbLQR9g+bjnEmH0rnksIAc?=
 =?iso-8859-1?Q?EW/xu08vK3aYSh3CHDy11u42gFGsqIlmg/OynwS5Ci/BL3Sq6tAbtnYvNv?=
 =?iso-8859-1?Q?x37N02KtqjdYrkw+jWBuBL1Rb+WDnlHKlZ/Gfk0FgUgvX0Li/jODXIVIXE?=
 =?iso-8859-1?Q?qOfm78EhgAwfeVHjT7HQUSnPaJMTRBRbSB+hsfhvoG+hyyImCbZhOmbzPV?=
 =?iso-8859-1?Q?Xs54/M1MheIKqmv8iru4e2gW8bHNGcKxoqA1svg0eui33plAKZluo+thzf?=
 =?iso-8859-1?Q?iPQeZWBGw/OJSxOe3H18XX0a2m56PuPWNSYoLYWuPAVoZHEaTXFRAmPr8v?=
 =?iso-8859-1?Q?bFejkjAcFtyG/Rxt44HeM+r/NBxtlRo04/QczPtJgXc3pdmHrbXB/Uuil1?=
 =?iso-8859-1?Q?rjccUk6XmR/3kGo399BWWFdXA2aUugyJh1KhGEB8pSXnQBI1NCCK6AlV5G?=
 =?iso-8859-1?Q?IqORzd+VIJVXmV+4MjzZjNF0d2Gw6RNIsCGcRFXzV4as5uQvPzMu+Lv9Ab?=
 =?iso-8859-1?Q?YBorMkRlkONO2vYSrTPnJ6iEzo+dl6kxK6DvhbDRJIAW8/z6WGoeEW1xPh?=
 =?iso-8859-1?Q?IuMUlVBxzukh9tfvLqRWnFLrtu97OoJes+vVwhELmUda1wtGhj0J0Y1AUX?=
 =?iso-8859-1?Q?64dqZR/MKA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s/cf2xWjkA6+UqI0t/XvwRfolcryqRQLh3Dv2yt7htm9AHsB/Wsr9GgMqogTUWHCL+uBV6Q75ryZ7k+ztpTpJv4+81kTkjlVheJq4VzXMVYGvpD0Y3XwxeBQ3cp7RfeYk4anTw3R717Tzg6tuqB2coXw3qdl6jcPYsqbe5d/iJ0Tl4Rf0M2I4locbqQO76bCLU86Fd7Wj5xo96dlIKLtlsU5GP8rjv7dqFrVAtnMEnIwP6jNuThtl3Trjz/d8n9OgHUbZbKoY0ZKQJzUnWccWzxjqEK/VOBAbyDfJhVmuRP0nyfLMsfJ7Ty2F51YI+RisPV5psiHDepE/XvX14+sfg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bfbce6-e236-4702-7e8a-08df0806640f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:52:45.1160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qp6xgV1U9mU1+w5MWXapSrcaMjMl+HCn5C/4t6E23hc0KoRdIZMQLsm9dRI1medR2WbBbIAf3Q3jOVTmxqjiIL7PXKTHI7+bVR+jS4Qfqio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF557D403C2
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

The AST10x0 SoC now implements the SBC device model. However, the=0A=
old unimplemented SBC mapping was left in place.=0A=
=0A=
Remove the obsolete mapping now that the SBC device is implemented.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h | 1 -=0A=
 hw/arm/aspeed_ast10x0.c     | 7 -------=0A=
 2 files changed, 8 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 8d80f16705..cba8b7cdca 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -92,7 +92,6 @@ struct AspeedSoCState {=0A=
     AspeedSBCState sbc;=0A=
     AspeedSLIState sli;=0A=
     AspeedSLIState sliio;=0A=
-    UnimplementedDeviceState sbc_unimplemented;=0A=
     AspeedSDMCState sdmc;=0A=
     AspeedPWMState pwm;=0A=
     AspeedWDTState wdt[ASPEED_WDTS_NUM];=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index 93c81195b5..5165dcce59 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -163,8 +163,6 @@ static void aspeed_soc_ast10x0_init(Object *obj, const =
char *socname)=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
 =0A=
     object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "sbc-unimplemented", &s->sbc_unimplemente=
d,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
@@ -222,11 +220,6 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSt=
ate *a, Error **errp)=0A=
                                   "aspeed.io",=0A=
                                   sc->memmap[ASPEED_DEV_IOMEM],=0A=
                                   ASPEED_SOC_IOMEM_SIZE);=0A=
-    aspeed_mmio_map_unimplemented(s->memory,=0A=
-                                  SYS_BUS_DEVICE(&s->sbc_unimplemented),=
=0A=
-                                  "aspeed.sbc", sc->memmap[ASPEED_DEV_SBC]=
,=0A=
-                                  0x40000);=0A=
-=0A=
     /* AST10x0 CPU Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
-- =0A=
2.53.0=0A=

