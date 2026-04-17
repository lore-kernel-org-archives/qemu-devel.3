Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46078F8E4A6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtA-0002Hb-De; Thu, 16 Apr 2026 23:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZt7-0002Fz-RI; Thu, 16 Apr 2026 23:29:01 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZt6-0005oG-6P; Thu, 16 Apr 2026 23:29:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVN7kKppo2yl4d7bxp2G03pGeXayseZZJpmp3FJg1ualzpORbcE1A79b7NxzwGaNUWIvMsfQul+rqWk4H3OlcE2ES0F9Y4jQvIKER0JnFHCw3OfseI5ymT1535xaJrGb9hjq/vifvNOwUqayMWVJJVTXxKFWnlMP5G9FXGml6guW1o1Fe1/VJvZnOVVbQ7b3rXJHBBA0uFEn/QFn4OAz1c3JDN7w4eDhXHS/o0Nr7dmel6v5z69bJrynAdWuDqYYLSq7QTqnWlrX9CPRokmB07NrT1zi1p4MPW7pmhdAR4pzXaBo/89J9t494s8p/+UvcUCXZ9HktYx98ULxE+BQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AktkBAvubOQDaPkP/6jl0OxPG+pMjV4dIMTJkEgY28E=;
 b=LG9D4QRWgM/1ky8iJ8AmfZ/eNWupj7OhDWAN3cxbz2GZYEFTwjK4vSEuu5GJ40pZmB/n15951iV33yXmGOGINU41p84yb6sEhxsCNZGVasYtc2p+fkLNcoENsH5Zf/Di0zBwt0HAN+SAAyA74BWr+qjke+K1WJhNtexEQgt4U8XfGVsLHSkoizKDdzb/x+iNKDS8NOtESEXVkYGmFWeP2bbwtlZmpnaJXtCEWv7F/7such0ptM5gh0/p/IqRsAFl0pJpPQqj7e3lhHc1SEXveYNkaF5ZZTiXb82lgS1hCFWIFILZNFFQppcJML6MgiK5QnzE81fVP0mMXNvSh+OD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AktkBAvubOQDaPkP/6jl0OxPG+pMjV4dIMTJkEgY28E=;
 b=aX+OZL7ZsCAAhEpZ+C/sSPMD5ulBtxjyHJUmWCvNzndRmoJnvoMgi1KEms3x8Yu4RVW4oxT6SKqVHh/yvUS0Gl7VvtoHySl/hU7c/WNf4dfM8fRoOQdJn2ZLpqXXEqCM71xWuX10ix27zfvVuH5EbvoTr7KeIpPL/BBsv48eXKBy1J1HjN1HcV5T8Wfv9VVseYjlgJiZ7KsMEjtKQL6qT27Zu4iqBoo2ZPbAG9pu9AzWZGly3/ZnyZBfxdW3/2iTsWVMktmKMugsM4dDW4PJnK00iaN6uJlNf1+KmjIMq+8mCCn2la9m8mcQCGhJL13dW8seaov0JJopyytUvxvQTg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:47 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:47 +0000
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
Subject: [PATCH v4 06/21] hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap
Thread-Topic: [PATCH v4 06/21] hw/arm/ast27x0: Add DRAM alias for TSP SDRAM
 remap
Thread-Index: AQHczhpMkx3sJBOGaE2RsX7hjxRZxA==
Date: Fri, 17 Apr 2026 03:28:46 +0000
Message-ID: <20260417032837.2664122-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: db780275-cd31-4302-cf85-08de9c316f77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: u7tebZC99sDAivOWEK+ShxDJhLb8R6z6py42uTsifLsutpyF/nEiSBzA4kHbzIOWzHhGGZZl1Slp6WQPw1tfZuRJPxarA+QDdEdvs1eEa3ZI3WonOvpleiCCr36S3Cp3Lc/ujIexQVLW8O1+3zZ8ql/vTToblwp8OuLAMKoepDKx7PA/hP0Om87uNu19TP5jOClxgzftM1zN8YCh2MHeYfpwfGU59JHXV1vUUybvLQ9zeum2rOHkAwoOGZ0y83W3pEp2gwZIxq4COA0+ahgCm4dhIYW1RmPD/6KgnSHXAIl1IczVe0qYDKkPsmxK0XMYPG8AHlUqOIqQM3EPRTqmFIuJW3UYd6uO6xFTVWi1EKeYeb47NNI8ewSHrFRnTyyCl44Y5Ql3gDzP/Ctyc2rH6aQd8A1nm0sUjL6GyIVGNNfvztyB5oeYE2K//25otNFmEv6PQQc1D0Z5L9ccD2U8Yq+6Dh1h4DjaSU4aTWodtb94nLF96G7AFqegwrXHiKqAM1pfYzT1sAwlA4ITi7xrXqxlaSCN2n2J4ITso4D9kCPiOvQh+HVdnE+CXTtzHr7aqlffLdFFS6zR5OuoZ7wDUZJwk/QiW1YKm4u/OmPfFZVeWszm36uDdV1Brc5VHhn/ndBF1rVuzr0bym/cKklkLO+Uu8o910Kx+I/l+dcAEWofVyCQ3vnzGIx/uleMvzGBNq2kBywO60mRUfkFuNOCyTIJ2tAoq0Zp6B9S/+unyWy3IBnzb89lRBN5ntS1fgIBDsDx9fEzVDlVQ37eSUAXbCjIDmM1jtgTqwO+CUjsS1X1uBIviXHXTrV4KushBjWw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w0gTRnTaKiDfDUahgBNJARdmKG+RxEKksr0jVArbLpguHjAvPFbeGQ4E4O?=
 =?iso-8859-1?Q?pGvniWaIqfUvmITsiOZ/UNCj4TLP2sJ20h/5Ap9yQRLcDoGsY1nj4+06eR?=
 =?iso-8859-1?Q?CcJzYov+NsqLgKb2JA0cHxYPXD22pMpaAh9oYhoB/mdARRyx82DdPH/kXB?=
 =?iso-8859-1?Q?gq+qh9ie9po/vZaJLqnA4fbTDf6LmQTBS2cMwNgxbBSHd7zUSSWEPh8RkX?=
 =?iso-8859-1?Q?ukmulcXwiNWvCA8EEyTav+0x+aoUGylTTenwiBuOwmFVhw1u/Kp5Z0G6o4?=
 =?iso-8859-1?Q?iig2KaNVsTc5155EmfolnkuyrsakeeY5lFrKLVcNO9QEgIJCuoSjrYpH8k?=
 =?iso-8859-1?Q?WiVVqBhhlKBn4WYzoifqR2eGq3aNtwC/I3CnDxbj/ovdxQ3yktzxZNVGgF?=
 =?iso-8859-1?Q?ZKlicUCGl/0uwwpPDuXnH4lATZZIPICQ/D0vX51eDdWZsFzrUGGkc4JDpb?=
 =?iso-8859-1?Q?8nodtlDdM2vVdWSBIZRMmaES43tVnGhvTvOFCK2NlGnUYvyPezTfCK2sMw?=
 =?iso-8859-1?Q?oFs5IG8RWR8VDqeeYLS8wfIG0fPex9xQ+rMXGvZFd8zpv4fHeGsk3egWMi?=
 =?iso-8859-1?Q?izFyhr8CqRfALP/w4kFLMtTvOZV4OFKs7bM0t/yan5vqYHtKCjGBe8w4DD?=
 =?iso-8859-1?Q?2nZpPm7OZ6+jo0FPZiFs9XTcExkplKKZxKMetmA3HkRj3RHg42pL7WMHig?=
 =?iso-8859-1?Q?U5UauWwmEfHeraR8OnZE65B3YO+hM3SUQEvYQ22I9Fps5dIfhetvrRaiW8?=
 =?iso-8859-1?Q?/S6Omj5vyzbKOGgOoFgHgeNOn74ReUZWZ+A0hN3Ehg7hnWYhgSdBLTNWqn?=
 =?iso-8859-1?Q?bWLJ2BivFdVy7c3ZPdctFo79/i2HacHKG7sLt1g8nfA6Lpa7CIkCK03sU3?=
 =?iso-8859-1?Q?t0Oed44sBndTeRqTVr1ZX+PEiTMv1NdJ342QRnygx6aQxt/lC55LLHN3um?=
 =?iso-8859-1?Q?QlcwxOCWZv80HCEgW85iniX8BqekEWK3Z3NQka0ujqXoMWS8pdwM1c4fGL?=
 =?iso-8859-1?Q?Y75YE4rQeTa16329O2FmEA7EsNYPwWBgEVJr8FcYm05rC8C+Nl8zJ4Ernm?=
 =?iso-8859-1?Q?3PJ/YLgGPn4hnAhuIsuLWIU0UXn2u+IxvTTSgj/eDvB85LG9dNyyZmC5xY?=
 =?iso-8859-1?Q?DYSdmTKq0Bpv4edvBAYB34O+m/rkdG50eNRxQDKHaYpoSkYC/pMEMrtx4N?=
 =?iso-8859-1?Q?AMGiWoERjB+bw86NZF/YzePlj3PwARnLWhfCW8wlVGlqZjqcgkfXp9ByY8?=
 =?iso-8859-1?Q?MQPlTAklEHjxr0rRT7CppIghzbam7z6S4oh/gsq6nA4ArFwVIoAWnu4VYB?=
 =?iso-8859-1?Q?9LtfE0enqBoMkqZadaEjEz13PjLQ16y9cpIi59zC9qAyzkt15QSw7qe4+I?=
 =?iso-8859-1?Q?p13WbQZkW89k/zz7VEIewX5dm3wALm/rs2qXwyIgCAFkZb1r0Ytm7PWkhT?=
 =?iso-8859-1?Q?hxO3TyYSqtB9m3mbUsZJD9KEOdf6sb+3HnLWBm9GUeM/kiXHZjrPiwvr4C?=
 =?iso-8859-1?Q?Ntqg66Z0t6S5JIRzhuhOYWZBkmarHLlajgU4cUywbSBzNDneD58dJ+6aE5?=
 =?iso-8859-1?Q?seVtXvSX37Bv6PjQ9VxhaOWQ6pfPLKxdqlxUD74fQbmE+IKSEQMa4E1Riy?=
 =?iso-8859-1?Q?i1XGjG5RoPxNEAi+pq1cUv58winJlJP1tO3BZ/MbClc4SCCJocRClmHRj9?=
 =?iso-8859-1?Q?gD7cgeEcLJas/uc2vFvCPU7C8Ikkw17Iw/vl8RJYrrtyTCT4QtQeu6bhfn?=
 =?iso-8859-1?Q?XHMmU6rEQg8kKblJ4RDylpAaPpE6XfVMrj3y23teEciQDmkhSKE+Zqf71s?=
 =?iso-8859-1?Q?nyEBduRr1Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: beupc2hBPXFO/WVTc9L16aqqLM6eo+gUPIANT7JkSCxjnWKwKvncJWdufLqUHyAb4MetNqSUQ9Sv15fpFnyKXKYcNIG0GYCOuyunqR2gMOGnPs3BRoZOQA4kerEWKzqjhoRLn5oeVmLOQUxZsvXMbauPMSOA5625mB8lwUofU2pyfPnbi3OmaBo04kjWfr3xsn1uxPUpxNV/TJ7IPVnWeXVNA1crGZun5GRME7AmSaFrI9KRF2NvokK4UpCgXT96HaSkbttUU9cr/jIbaWB+cEnj2lP5CBWJTEyelqktyRwSe1leegPm7fO5ItpCY55te7F5Iig00zGBKVK8X3NGIA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db780275-cd31-4302-cf85-08de9c316f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:47.0171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SS3gnGKUVtLe+vIPlZuD1Q94WxpQjTu+WrVHiiUQMA0aME1uz97cOIqGeAt9mZqpGJsb7JNx4MpVkDoVH10efdW7ceYDANIu8bhf7uBDKfk=
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
Set TSP CPUID 5.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h |  1 +=0A=
 hw/arm/aspeed_ast27x0-fc.c   |  2 ++=0A=
 hw/arm/aspeed_ast27x0-tsp.c  |  3 +++=0A=
 hw/arm/aspeed_ast27x0.c      |  2 ++=0A=
 hw/misc/aspeed_scu.c         | 16 +++++++++++++++-=0A=
 5 files changed, 23 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 106ab4b04a..839cd30361 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -48,6 +48,7 @@ struct Aspeed2700SCUState {=0A=
     MemoryRegion dram_remap_alias[3];=0A=
     MemoryRegion *dram;=0A=
     int ssp_cpuid;=0A=
+    int tsp_cpuid;=0A=
 };=0A=
 =0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 0688750e78..62bd6a0568 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -102,6 +102,8 @@ static bool ast2700fc_ca35_init(MachineState *machine, =
Error **errp)=0A=
                             sc->uarts_num, serial_hd(2));=0A=
     object_property_set_int(OBJECT(&s->ca35), "ssp-cpuid", 4,=0A=
                             &error_abort);=0A=
+    object_property_set_int(OBJECT(&s->ca35), "tsp-cpuid", 5,=0A=
+                            &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index b30f2afd62..4da4741d8a 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -199,6 +199,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
                                 &a->scu_alias);=0A=
 =0A=
+    /* SDRAM remap alias used by PSP to access TSP SDRAM */=0A=
+    memory_region_add_subregion(&s->sdram, 0, &a->scu->dram_remap_alias[2]=
);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index e38b829cc7..46cc116ef2 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -434,6 +434,8 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
                               "hw-prot-key");=0A=
     object_property_add_alias(obj, "ssp-cpuid", OBJECT(&a->scu),=0A=
                               "ssp-cpuid");=0A=
+    object_property_add_alias(obj, "tsp-cpuid", OBJECT(&a->scu),=0A=
+                              "tsp-cpuid");=0A=
 =0A=
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUI=
O);=0A=
     qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 7080bd6241..2150261f40 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -966,7 +966,7 @@ static void aspeed_2700_scu_realize(DeviceState *dev, E=
rror **errp)=0A=
 =0A=
     aspeed_scu_realize(dev, errp);=0A=
 =0A=
-    if (a->ssp_cpuid > 0) {=0A=
+    if (a->ssp_cpuid > 0 || a->tsp_cpuid > 0) {=0A=
         if (!a->dram) {=0A=
             error_setg(errp, TYPE_ASPEED_2700_SCU ": 'dram' link not set")=
;=0A=
             return;=0A=
@@ -990,10 +990,24 @@ static void aspeed_2700_scu_realize(DeviceState *dev,=
 Error **errp)=0A=
                                  "ssp.dram.remap2", a->dram,=0A=
                                  0x2c000000, 0x05880000);=0A=
     }=0A=
+=0A=
+    if (a->tsp_cpuid > 0) {=0A=
+        /*=0A=
+         * The TSP coprocessor uses one memory alias (remap) to access a s=
hared=0A=
+         * region in the PSP DRAM:=0A=
+         *=0A=
+         * - remap maps PSP DRAM at 0x42E000000 (size: 32MB) to TSP SDRAM=
=0A=
+         *   offset 0x0=0A=
+         */=0A=
+        memory_region_init_alias(&a->dram_remap_alias[2], OBJECT(a),=0A=
+                                 "tsp.dram.remap", a->dram,=0A=
+                                 0x2e000000, 32 * MiB);=0A=
+    }=0A=
 }=0A=
 =0A=
 static const Property aspeed_2700_scu_properties[] =3D {=0A=
     DEFINE_PROP_INT32("ssp-cpuid", Aspeed2700SCUState, ssp_cpuid, -1),=0A=
+    DEFINE_PROP_INT32("tsp-cpuid", Aspeed2700SCUState, tsp_cpuid, -1),=0A=
     DEFINE_PROP_LINK("dram", Aspeed2700SCUState, dram, TYPE_MEMORY_REGION,=
=0A=
                      MemoryRegion *),=0A=
 };=0A=
-- =0A=
2.43.0=0A=

