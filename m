Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34954EB5951
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzlw-0005DN-Mc; Tue, 10 Feb 2026 21:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlf-00056n-7J; Tue, 10 Feb 2026 21:15:51 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzld-0001ez-Ju; Tue, 10 Feb 2026 21:15:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU5dfu+Ke7Ou0JlVRghaHmxYY4piXWpWulc2C8YENW83povDArOmYfIzMlCixcoUO7goRP1mjIqQHdA+kkK87mhTbtkKTRGvXQnOUDzqWspEsLfr8+6QWhzheoUsMt3FwIazyDIDExKtMGKUEYXV5uXIFGaLMJsTG0LK3ik1bwageHAf+kpYbtKJv2/jZLyzf7Z/Wg/8LzO6s2qXhgobCfWwbACSZ3Vpi4bJ9OJ32MZwgoS2X997ZN5isp7aNrzOvRZKj0xdFs8+TArq7zILMNLUKEb+batdW9oCdq3hyrdpuP/93OABHijp9Fc0IiFoPJY9RwMz5ZpwQwfWB4cbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8fbd3Adq3lhQrtGXmC2sa6D7UtELhExxlDBCbbKGxY=;
 b=MT+GyKgqlirLGdnYSvVBQm3UF3dYnRoTtsnhgqshkx1e2lDRkTUW8xi2DXD8bxTAHRZXv4h7lnv90GGw/6TQRscs701VwLw3+BXqkt5zOyDiNGWJeUG8wEg1It1hF5GH4zk30O9FTC/CEyBc6NTHMv000YyUZ4PDS3Qqtv9lAQSmP8Qfptc1EZantRFLV0ZES1zIuRDMMz1OnbpvcOsPH07ZDaLs4I48u5XB33v1xEKR/FADN3HtP+uRbxcSNyj0h5q/QuDvULsP519fldo9AwjOy5jcaEdaiXOLhgnSryEvbiM62JvpFVzkAZ3ab5tXrJfI78JL3mHQnJvuspiTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8fbd3Adq3lhQrtGXmC2sa6D7UtELhExxlDBCbbKGxY=;
 b=mnIfRnbqITU1DSJ0+XlZpOlR+D001AXxzUZxAQewSx5YB/MBcDxrcNGaYiTMlr4Mu/DV7T3JgA0YGVaEm+JvSDh1kY/qtEFCcFDjmIMhZMHv/2caAS+RogkO54lCsJMkv/QLNBYvigWkeYz5g0e59d9CmyiHITabbe5+Xx423Suw4sGbKtf6/q5/7BnorV/aHqJNxDnY+SHBRROCYvFI1HojNRxfwLDq5hr7zzGGhsyzNp9EWRx6TBaLIJKarXBQDQhCy62lxpIFbk+FxLGb5d3DntqdkY8PyAl8gEJER3RIaBB3Rnih1JwGZcMvQsYWLkjqXnCwXIwzKYftjrzh2g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB7994.apcprd06.prod.outlook.com (2603:1096:101:2d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 02:15:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 02:15:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v3 09/11] hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC machine
 to A2 SoC
Thread-Topic: [PATCH v3 09/11] hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC
 machine to A2 SoC
Thread-Index: AQHcmvxQ1w+MFf3rBk+GJkk6+R0sHA==
Date: Wed, 11 Feb 2026 02:15:38 +0000
Message-ID: <20260211021527.119674-10-jamin_lin@aspeedtech.com>
References: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB7994:EE_
x-ms-office365-filtering-correlation-id: 1fe6c88b-b250-4e82-fc10-08de691372bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vo4qYdnJCKEvH5regmQDtbhi4hedqMd2y249e/4w387AWH52Q7+TEjiVrd?=
 =?iso-8859-1?Q?1psPjcmURNLcsF0PEiL6Oe9zcS+ibah3QYtx5OHPn4qIfuQk3HUNkNmXG+?=
 =?iso-8859-1?Q?wj1eVIrnXrrdsUTL3NpUaFnAr1GkP8NMNBuyAx8k5W0S2KuFVhkU2NWqBl?=
 =?iso-8859-1?Q?RqaU+mudIO1MBA0vG5kbVZOFrqdT4il/HBTz7o0otLvjMSC/hralyX6sOX?=
 =?iso-8859-1?Q?8SFaKstUVL4e6anAFDpxcWPCKQAVsl8TO6W8UjrL6+X3UH606J+gbEgZzq?=
 =?iso-8859-1?Q?j2HqGVj/IJIXlHtgL9XjOWWxQZzxHIn/wW4W+dswLmkeDbQE6DuIljhQRE?=
 =?iso-8859-1?Q?KGwQmV8YNEpGi3QEY4KGNgp4v/hYHKgEAPDRMyY2HcnrGyMphraIxCn1hn?=
 =?iso-8859-1?Q?LnlNiZvf427EHUk0D0BmL0kmyEOZOavy/VJocOJowbhEkOH+vg+m3FqHnD?=
 =?iso-8859-1?Q?EaTYdsfk/Xxy0giqdmDgPPhr+95OJX+KeMTB5wCr23Q5hzyUFhi+AHPf9W?=
 =?iso-8859-1?Q?VV9eyw03TGLeHWpzsByimu/rDog1k4BSj1znrPwhN5mu+n1eLsXv6+LWZL?=
 =?iso-8859-1?Q?lK2ZoUBfcvWhbYMa/DrcspH9cdluRM6K+G3zwgoC6zGnt7Hijz/cv4Y46K?=
 =?iso-8859-1?Q?VggcMCs/NE2CmBauvDRBxjgFizSV0t79T74mCZS2w1y/2ib/HWadrgs+wx?=
 =?iso-8859-1?Q?mKJNbeHzIz7n6fGMZk+9wXTEe6oEjkFsi4LLA+G+oCFQIt3Vr5vaNW50WU?=
 =?iso-8859-1?Q?Xn6VxiXyDAEn7jKuUeGrQ6wz6pZEv6ZVlrejeQFB2ONaeqAN7BkM0mWCjM?=
 =?iso-8859-1?Q?dWX2wIpxPoU8+1nZ04NAEC/y9E1wz25W63xXTmzp2M/hcCvZPqNfy4SUPo?=
 =?iso-8859-1?Q?Q6/Tk2z6yFGJ9mdjC+Zs2Q35ioXFCv3kflMn/kBDtr8b2+vw/k+I/mwzNz?=
 =?iso-8859-1?Q?m7jkBtygF31YH9d9t5ZRT9V3KEV+DU4ImrgJ1pEz/tHN0+uodX21U3IObJ?=
 =?iso-8859-1?Q?nZBJxdLpyECt9fRwqKAS6QB5gEPy+nwK49HyI5fItWfQPuOsh8cCh4j83F?=
 =?iso-8859-1?Q?ToFZ9rOFLBpCPbjJLDxifz7xIaanFCoX6NPJ5eGGCssK9vdj/x9+zvPaBu?=
 =?iso-8859-1?Q?CmKN2TmEcbmdbr5x2Ybj07bQmykNbPivfLeuShHmOGtHHIPubDV1EQbesW?=
 =?iso-8859-1?Q?ERUtQvjjBMC5h4DMNw9gu1q5VYxFNejXAKG5HbgEYi0BeyIKC26q+o04vr?=
 =?iso-8859-1?Q?yU22R4UP+4ISKx2dslujduKzCIrhinJ2ptb6OPgAIQjsmfctOfZ+fTpHth?=
 =?iso-8859-1?Q?3Z2I1O7W9KY/zVuGQz4HvKqqpdwgl2AaM3YpIZOu0pCmxVkHcISMbLCzXu?=
 =?iso-8859-1?Q?dBoqivl3XfqjoobaBSxzhfiUYCon8uBU0aoQUSVo9LnkJeZDfzrYvTMbiv?=
 =?iso-8859-1?Q?sam/gPPSe4jQuW8OXPs67a2qadjZ/xSAZ3pYbByLFXtborrE25qEJjjpeI?=
 =?iso-8859-1?Q?G13PHRRoJydXDbN30JPjG73TUZ/9NvCBQPEfwX+qhuskayJn1/WwJY8NWM?=
 =?iso-8859-1?Q?Xpz+gHbAK1/tBt5N6o38Ig1KXzwK2jMSWEP6PRpvLy7LmpuImaeBCvpJqI?=
 =?iso-8859-1?Q?jyYZAmQOENNnuJ3I7/KWZxQ09avu/FN5tJig1sXx53WA0W1m3RqDv9qD3R?=
 =?iso-8859-1?Q?Xl+fM4WH0dpJ+KF0NqhNhyCllpR2q5DgE+GT88eO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Iy/oARkwXGejxD3rWqWI2DkA6QWHE4NLcMvRDZJ4tJrYoOve+cv/xQKk62?=
 =?iso-8859-1?Q?4srDYr33ncezT/MverRi28Sa2AKFvlvgaHcioXO4gbZ/jmd9O0UKYS90kc?=
 =?iso-8859-1?Q?UK/k+JsGccjSLqzA4gOIUYaA0WuUtEFvS4CQQSzCrdw5Zo2iDzl3Xd/cvS?=
 =?iso-8859-1?Q?B8OS9opqx32ZBrG56p5oRke0eK7p/w6aLerZNV2lNDQR/rIcDEgeyHRHyJ?=
 =?iso-8859-1?Q?3dgdLusTFs2Ha5atL6Xdx/BibIAY72BvlROwH1BMOHweTR+MM70N3UXNkM?=
 =?iso-8859-1?Q?VywGk/IGift7yghU/qdyxlTOGZw+/Lmj1ZQ114rXOZY+zs6TI63ch1Mqx8?=
 =?iso-8859-1?Q?tDgt3m1sgkOp5pXXyo/b8a5TSqq8p3A2G+HjsZpdbZm1LiHtfqjLZ0dhDn?=
 =?iso-8859-1?Q?b7HWt0XePsYg3vFfvnExw7qfiP1ASjO0MeSBAzv2vexQPasBw3upbbTI1k?=
 =?iso-8859-1?Q?CfzbqXIqs6o1No9KzGOFwh2kQFkIiNA/GnL2iJClxCDlZm52Ny/vTjxWbe?=
 =?iso-8859-1?Q?i8uXYXShxoTJ12s0aCa2BwbhURDeJZSMOopJ6S/kLXezbl1aqhkCRym4yq?=
 =?iso-8859-1?Q?7QgsD4pnsG06Ej+qrizWiAsDRjuZQCKxnufRXfw94TLRyfI+Cu7GTKDLTw?=
 =?iso-8859-1?Q?uDukAFyNJkiCBLL4uTa+leC5oXdraCaD3tS/DIhq7J2DFSWrkgVKVoX88P?=
 =?iso-8859-1?Q?H7/4TcZtuHm0UPgvjYTn3v2iqpXgkojLKa7p+/5GoTnrTdBZIy/NG2UVf2?=
 =?iso-8859-1?Q?yohI/SdQfvCOO0otsCrtrschYECiqhO90Wjn3ngm5RjXF6V6f7ZYFAdAsn?=
 =?iso-8859-1?Q?UduuqPGYKANJmyK9xLDzeNHanVvRpOV6AOkyZgy0l+YSJc1jXz4XJzIjsU?=
 =?iso-8859-1?Q?VQZLWex81prKk9RmKQNkftp9xDP6oL6aDVQQbipnj0bSDka+qcj22q7bfC?=
 =?iso-8859-1?Q?+5WHDOfKE3+TdjzkLKBWgxhRAElTHml/IhOTYvanX2G+g7uWAx6aRlAvvd?=
 =?iso-8859-1?Q?2+nxjJ5dDpUWoxVdezr0gbUxWZI/44qDsMqpmWLo0XnPU9WwQaMADbXk9B?=
 =?iso-8859-1?Q?gHTQ4tsmQi0Q02pAkZ9Jwgmfl7r82mQukyZdFf9nfsfWDwNP/nmaQ4zV2F?=
 =?iso-8859-1?Q?tYVD78NC0mVHNvGBM9WVu3xU09xKJcWH4hfNPkwyU4xwTOJJId0fOn1Z4+?=
 =?iso-8859-1?Q?7A+Du/Tqm5kqoF+XXwIlKp3z99fMQn/ovTMiOPrfH2n9AdmJmgw1i1Ctr4?=
 =?iso-8859-1?Q?HYpxriKJcwqWf50mP2aCfCrL6y49SmjBg2hoZa2QYOuzYLy73GDZe0FT2j?=
 =?iso-8859-1?Q?NGifYcw3gD48qDsSDnL4aIabD4j1L+E9SkNngR5hDNUYjtZQD4ZWSrMiFa?=
 =?iso-8859-1?Q?jz8AansACJD535ZH4nXOKSzLBq8tZkfOZfVREMInbJ0Wun4rcBOnPxVZpW?=
 =?iso-8859-1?Q?FVxR6Nsg9aYG24MpdXzm7LupUSRZ01c5ZU/Tg+zp56s8lvJA2tD8LNO5Fk?=
 =?iso-8859-1?Q?tbhb4DCF7/JtUiuGyMz7nKYMESkLWwGTinx+Y8Di+WSFf4shm/j2pAPlK2?=
 =?iso-8859-1?Q?JmBT1I4z6exui+um26oOS+L4oHsZRh71q7d8XUmOYW07+W9kWLSPIfsUFp?=
 =?iso-8859-1?Q?ZnZmPnoafPJxyvdzY3ZSbPEYRcbvOyDQ7+LL/liWDwJOeH+5UmF6Bo/hAn?=
 =?iso-8859-1?Q?4VZef96a5sNr9Kul6/K9YMzyL0CJkHvPFgQqUKKozSJ2lyKOW9yyZe8seo?=
 =?iso-8859-1?Q?CpTfp6INVSkYuesksAWWfijpYXHO9PN9vIDPIipU7KnglwIIIqLFznukE8?=
 =?iso-8859-1?Q?0NaPcL5Puw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe6c88b-b250-4e82-fc10-08de691372bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 02:15:38.3330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrwm1I8bE6/+zNiQqiFA6li2EXoTLRFikqanO2h/SlMARGOjqUYEiGCb4dErzp7vjOu747i2/sjj6VKDENxd0itDh2AecIplmFzx+K6RA84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7994
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Update the AST2700 FC machine to use the AST2700 A2 SoC model instead of=0A=
the A1-specific variant.=0A=
=0A=
This change removes A1-specific naming and definitions from the FC=0A=
machine and aligns it with the newer AST2700 A2 silicon.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-fc.c | 13 ++++++-------=0A=
 1 file changed, 6 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 0502a137f3..9b9bb2df75 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -24,8 +24,8 @@=0A=
 #include "hw/arm/aspeed_coprocessor.h"=0A=
 #include "hw/arm/machines-qom.h"=0A=
 =0A=
-#define TYPE_AST2700A1FC MACHINE_TYPE_NAME("ast2700fc")=0A=
-OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700A1FC);=0A=
+#define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700FC);=0A=
 =0A=
 static struct arm_boot_info ast2700fc_board_info =3D {=0A=
     .board_id =3D -1, /* device-tree-only board */=0A=
@@ -49,7 +49,6 @@ struct Ast2700FCState {=0A=
 };=0A=
 =0A=
 #define AST2700FC_BMC_RAM_SIZE (1 * GiB)=0A=
-#define AST2700FC_CM4_DRAM_SIZE (32 * MiB)=0A=
 =0A=
 #define AST2700FC_HW_STRAP1 0x000000C0=0A=
 #define AST2700FC_HW_STRAP2 0x00000003=0A=
@@ -58,7 +57,7 @@ struct Ast2700FCState {=0A=
 =0A=
 static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)=0A=
 {=0A=
-    Ast2700FCState *s =3D AST2700A1FC(machine);=0A=
+    Ast2700FCState *s =3D AST2700FC(machine);=0A=
     AspeedSoCState *soc;=0A=
     AspeedSoCClass *sc;=0A=
     const char *bios_name =3D NULL;=0A=
@@ -66,7 +65,7 @@ static bool ast2700fc_ca35_init(MachineState *machine, Er=
ror **errp)=0A=
     DeviceState *dev =3D NULL;=0A=
     uint64_t rom_size;=0A=
 =0A=
-    object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");=0A=
+    object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a2");=0A=
     soc =3D ASPEED_SOC(&s->ca35);=0A=
     sc =3D ASPEED_SOC_GET_CLASS(soc);=0A=
 =0A=
@@ -135,7 +134,7 @@ static bool ast2700fc_ca35_init(MachineState *machine, =
Error **errp)=0A=
 =0A=
 static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)=0A=
 {=0A=
-    Ast2700FCState *s =3D AST2700A1FC(machine);=0A=
+    Ast2700FCState *s =3D AST2700FC(machine);=0A=
     AspeedSoCState *psp =3D ASPEED_SOC(&s->ca35);=0A=
 =0A=
     s->ssp_sysclk =3D clock_new(OBJECT(s), "SSP_SYSCLK");=0A=
@@ -167,7 +166,7 @@ static bool ast2700fc_ssp_init(MachineState *machine, E=
rror **errp)=0A=
 =0A=
 static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)=0A=
 {=0A=
-    Ast2700FCState *s =3D AST2700A1FC(machine);=0A=
+    Ast2700FCState *s =3D AST2700FC(machine);=0A=
     AspeedSoCState *psp =3D ASPEED_SOC(&s->ca35);=0A=
 =0A=
     s->tsp_sysclk =3D clock_new(OBJECT(s), "TSP_SYSCLK");=0A=
-- =0A=
2.43.0=0A=

