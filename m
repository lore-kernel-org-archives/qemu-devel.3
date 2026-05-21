Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EC5CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPxGt-0003Jg-Fk; Thu, 21 May 2026 02:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPxGc-0003H0-Bu; Thu, 21 May 2026 02:52:28 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPxGW-00083B-JL; Thu, 21 May 2026 02:52:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfPoCtnXaOEcu97Eq4RM8MHfosJJEMw4lLLqUbeMQDGWupQcYWOKjstSi69jng5HnuWelwbOfDYCy0sIKcEGsdh5QB4tZ3lifAwO7UrDKai1Fu5IqxR8Am/FNdEaB/Z2Jd0J19loCB3HhQCiJsY1ZhK9urTP6VcIeWWSabjznfyki+qz+zNWGoF8Kgbgz/ubFRxxb8o5ZkV2XfK1vvNrj7SgKiTI4RES5AkuwgkceNzuMku6k1C4FjqgjfWvum4/ZvjygHCc82k7L9fHAbwTUsWHvp8VJBM2caJW0axCubKcudLpq0lc7wV4abKyBV3Ou3ROH4nuJX+PLRszxlVwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggR2LPy1PFk09TPhHeczs7kfdNswf4x83nWpdxv0FKA=;
 b=srcsNVRD7LLdp/V4laIowG6NSX1scnBDidYUnVJMY4vQCzQmLr+M/RFDvCDXOKHTnzyFX1XI8nH8B4C90ayf8iJ7fnkBCrmB5C3+Z6b5KhKgHjLj+dWoulmzfR+GuoCdRVP0oVuTI1ipR9fScRl4uBF+K4S8vtRzLnWtI+5AzgayWysIe5lfTpTLq5UlFIWxs0V9fsRd2pxiu8O/07R8p+Atgi/Sl7jS6L0wU9zKdzrjbjgDgWAeuu4Sp8RfxUpIxECcKQL4xjOQ+COzWhr8fmp5BL5RP3+0fKAvsqJgBovAx5YHjuBxBKaAxulpqOmi+sB7E12Hmsb5TTOaCaYGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggR2LPy1PFk09TPhHeczs7kfdNswf4x83nWpdxv0FKA=;
 b=jz0hvIBuvPm8tfxFYTDu7dRdLrPTJ741eUqUbWLLAdlvX30idOc5qsnj37nZirNH7RbFouommSDlOzRZNyfsKNs5+ZAzYoqvdk5MOR9UneLBgN6RgiHeTe+csmBNqWFvoZSVz+SyCf8xnhqRVOv6HaAlqUXB00fEQTY5z2iiwcYqPJh/huH2gLtvAHScVeodQ4w/YAPh3wjB+k+ItQAOl/LvlEBTTemKdvduwH9IDFAgWKu+BL+5/z+GOBlyEZJVxUbQNNKLBC7PCnyHsSE8jdvI03Z8xak2wgUk7p/7XcIWxnGUztRsrkJTpXFU/dgmJEVeIgWUvZ2t9pisF6FQ5A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6044.apcprd06.prod.outlook.com (2603:1096:820:d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:52:05 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 06:52:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/4] hw/misc/aspeed_scu: Add AST1040 A0 silicon revision ID
Thread-Topic: [PATCH v1 1/4] hw/misc/aspeed_scu: Add AST1040 A0 silicon
 revision ID
Thread-Index: AQHc6O5VNVXdJPlHHkOpDquBYWOYxw==
Date: Thu, 21 May 2026 06:52:05 +0000
Message-ID: <20260521065203.3713466-2-jamin_lin@aspeedtech.com>
References: <20260521065203.3713466-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260521065203.3713466-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6044:EE_
x-ms-office365-filtering-correlation-id: f9736623-58fa-415f-8449-08deb7057866
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|38070700021|22082099003;
x-microsoft-antispam-message-info: FyHe12M5TaHb1KY+Pjj+8K1mys4uXbm0v7U1PQhG8YobDkQgs5AoCAhoHJAIX8T4xLCNzlFCLsmzqBPcMfx/6e07Lw8ZPlnyj93mfAH5LP+ZrhHrV3+zPepKoeqbYPbGp2wk/ThAwQOMPZKI5+KEEK74qSWyLXfYpx9p+IWxFAZmRu1ZXamJk+QBBf1EDaX4rX06jLgM1WIdYdulUkGs8YnNJdmehU1i/fMgdxfGFNdIzKFYo9rS00UvqjLPCNyppxa40npw7SKqmIR/H0u50Y79dMjlvxkbRzXzIL4ZwtcKMteDKy2tmSx0fQkBRTa1v0PHRkX3Ar5gn5Y9BswwwfsejqcoPywXK8DmKWCxE7EJZv+v/iLVxfC5TkCklMXaPXWGHnncCp046fajDKDNRtOiue9JZ8OlJT2goontYSrUn4ysgo0FGP0HzVCVBqvIOSETQCb086eqa3JPUZtEJEaJT9Hx7XC34SesCi1zW48soHyN065NbH9zIxvahdCtQIRJVnoNzzXhG7qjlrCTg2IZ3Jmf0l9+ScjU5P2vnsG0bw9w6Q+t0lq+6Rebxb52W+ngTgLoGr6DRDDOzN5DIRm0R77wRgKmesmB5szHHlQxwrMo3qgyWwRi3SnBYqRg6czF9oIHeNN0dVCZg+vXB74Hg8kHCSAEJLbEJtCWm8T8oo8mLGv4Oyq4KlzGsc8m8wcdkmvmujfS1DaaolxSBWXqWN7hdvwnPMYK5EbIuKylVR37HDaYtcCdN65j7uem
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(38070700021)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WfkABecB5HTvsO5aQNpYc9c3GfhcSST2nBkeRKymhnulEi2J8yf1Tv3lac?=
 =?iso-8859-1?Q?ypGWM4PQdYvubCjzXTsRUsV90EA+bcZH9sJw/alTBdyGoxtFptSUSVEoIG?=
 =?iso-8859-1?Q?H2WLBslesGimXyew4TfXRnszKff5QHna5yNxxKN7OY4BhUL+isYYTKpQUf?=
 =?iso-8859-1?Q?MB59pqtRz3Q56GKBK9fdsMkX/3Q2+R9U2lmfaOevTNSeHVgt4CMUoQCtRi?=
 =?iso-8859-1?Q?riAR7DXFX7hGAKT9TMR/zRKfMIl+Q8PZc+pg3yKgtHhTgyGZXRULVZUfh4?=
 =?iso-8859-1?Q?gkZJ1QfGgTzVZPQpAtNrQiWmU3XIAGMWKkamyJkQOCaAglBfPH/9vcq7mO?=
 =?iso-8859-1?Q?Gv8SCSnV/Um9RPXqaHBea7zzvizBBfA6+YRxI1NXxGKqdo4STaC82LRLuX?=
 =?iso-8859-1?Q?lsJPxDD288kkOHTpoZ/cp5kEHHSXg8CvDLeNpCgrL9+2B4O9jlK6iX4UVM?=
 =?iso-8859-1?Q?cq5CrywImYHRumirnrAB9IAIdNAictZTYiFf+TOn2lJf7cgj0oxnMJ/VY2?=
 =?iso-8859-1?Q?yvDivEnu0iqk5KM4viOblt53sqcib+4RpaLuhxFPG0XMfywyIMoCngJlkN?=
 =?iso-8859-1?Q?fVJt4K0lWIG+teBxORqMXcrv1Hii+BL70Kzht2T/HAWFHmcrSZW992kKhi?=
 =?iso-8859-1?Q?jui9PvqmtPKPsr56XKXMqzq7oBl4m1C4oKwdLCmqGP1ImbPnsyyAh5qfXy?=
 =?iso-8859-1?Q?NU89ERfuaIDCCXH2yF18NeEg0GS7vuirRb343rNzOPyOOByAPFGmkveben?=
 =?iso-8859-1?Q?y+1cE2D1BQ+tOPsur6LSPKcPaCzpFtFVX4PGjZpdipId6QQoQsCPMnyxje?=
 =?iso-8859-1?Q?sivEs5iTKrDH7ahbgetbUwTF3Nuw354tSEHEC5d0WfnjapWmR3P6g3JmQK?=
 =?iso-8859-1?Q?LNBCaYlv8TtiArOQ1OL4QEf20bK+4b8wJIuZnA1m+o/Brcw7hIaO9YIIC+?=
 =?iso-8859-1?Q?E1tWJELLNyAH3FwU/JevYnxx/zK7f1/dQ87Gh9ztpUFVzef0FQl2FXoYgh?=
 =?iso-8859-1?Q?AY11OdtB+J6c1L6E0ucYtBQ/WXo52mab49/X0Bu2AVUs2ioZ6FxJS7R3ow?=
 =?iso-8859-1?Q?j8XU0wlIjywXNr0YXdjRfyqsAhVYv4PI7rY92a1fZW/8ZMByLbjUlIvDFD?=
 =?iso-8859-1?Q?4T56FccG76Kbf7eb5E6j9f1gaGhtvoZgT9Ivn5b/HGlCmEyGN6wY5kJ4vN?=
 =?iso-8859-1?Q?9Ki8VsHB0Fz+qF0R9ZMDYru305bdBTQ7UrzmIa1VgUs/9VsBL8bP0YDqGd?=
 =?iso-8859-1?Q?aGCk/mKHtNDcLURb9p1Nf8yM0e93xl/HI7WqyidkrlSk/7MUlunYW5WdmM?=
 =?iso-8859-1?Q?W1z4X094brs4kY4FkPDYFmXS/iDjxOTdF2OSmN9QObCWryS+9lEy94Fkzm?=
 =?iso-8859-1?Q?dDNdRSVLHNs2RczEl6qGjKfedKoXFnvDORjs44FkBqvD8P1yARbdASBqgl?=
 =?iso-8859-1?Q?6APlBvPhMiSzLWcc4V0p9cJCtyQ46jMELDqu6OXCzGMwVi1yIOZsonb628?=
 =?iso-8859-1?Q?tVRLy8bH8DXoMYyI92gJIVvD/gFWkMQRnKv+gxdYoKfydhtYITTfDCiliD?=
 =?iso-8859-1?Q?MHbMpO+QN3z3Ux7mTYOGi4hO2SjsEPJaJk2a6yaKDgpTvaTRWotdp5L/RQ?=
 =?iso-8859-1?Q?WtRJ+x/vJSi/3hVYCZFSMMPA1nY80z6oBzwqThW08oTt7uZGpVnHesfITV?=
 =?iso-8859-1?Q?Kr5s/5ujyY6nsaUKQGw5Z0Arv7/figL3Bd7LZ80R6jLrzMoftaPXVsL4fN?=
 =?iso-8859-1?Q?YL89ztXTNmNfG2kcy82FwcEi7EQscqrqpIK/JQzrjq5iPLvbmMgy473z6B?=
 =?iso-8859-1?Q?VlXw1MD0eA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ppX1Sy+GuYOT/rgL6jZad66Ot+3kxxsu7gMfUPxSnAkat+lvFYq0C2dGTtUD2jXLhsIoL+T5EgN93N3A3qk9UKtC41Nt9DCqCKY2Lks0Tzf9FkthVAAKVQtLAmS91dRZH0MoOMU99cDMtbAud8DAd6OGw0t80PIqALIYDA2RZFQub93lBViTHrAr1glgRhWbtpvirjxXvR4yCiTTVFVP6RfV70/Bn38zoYdv45iy8H6VpfhsWn3WVIkxlwvEGQyITaLKoZhKu74WYUOw+nNq7n07Es9xqyFxkRMCiB3JOgEVSKYyjlCawAg2WxCgddbXJvpE+DFbwfDGyZkrZue0dw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9736623-58fa-415f-8449-08deb7057866
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 06:52:05.5655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hKqWN2ETiF+Ad2uOgOfaq3Qd/+qe8xEi1Nq4lPZ8AfHCidRJK0zrP/bQS0fuNmgm9SzBsfcQS6BRrgWmhYIVU2C51Fh2ezFg3UoYTPTtKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6044
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

Add the AST1040 A0 silicon revision definition and register it=0A=
in the supported Aspeed silicon revision table.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 1 +=0A=
 hw/misc/aspeed_scu.c         | 1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index d003955428..c30940ab76 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -46,6 +46,7 @@ struct AspeedSCUState {=0A=
 #define AST2600_A3_SILICON_REV   0x05030303U=0A=
 #define AST1030_A1_SILICON_REV   0x80010000U=0A=
 #define AST1060_A2_SILICON_REV   0xA0030000U=0A=
+#define AST1040_A0_SILICON_REV   0x81000000U=0A=
 #define AST2700_A1_SILICON_REV   0x06010103U=0A=
 #define AST2700_A2_SILICON_REV   0x06020103U=0A=
 =0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index e4160356e4..507dc4ea9f 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -562,6 +562,7 @@ static uint32_t aspeed_silicon_revs[] =3D {=0A=
     AST1060_A2_SILICON_REV,=0A=
     AST2700_A1_SILICON_REV,=0A=
     AST2700_A2_SILICON_REV,=0A=
+    AST1040_A0_SILICON_REV,=0A=
 };=0A=
 =0A=
 bool is_supported_silicon_rev(uint32_t silicon_rev)=0A=
-- =0A=
2.43.0=0A=

