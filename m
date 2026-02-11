Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEBCEB594C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzlm-0005A1-Uw; Tue, 10 Feb 2026 21:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlZ-00054n-03; Tue, 10 Feb 2026 21:15:46 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlX-0001ez-Hx; Tue, 10 Feb 2026 21:15:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTWPPtVWpOSlMnTTCWK8NmObbNabzr6vLBu5P3D3yl/NwLQRwHWEe6CHZcfgdwe/JL241IoJoNDhLtYPiNqWoyrOnAyQKqK2QNWUb2InKi84iUL5YtrLPoUjw7Exui6WZ12sL6+9X0SQa3P3S+AQEVv6to93W0CWpWR9elQo45bpDVVjd/cOQeEEd0RX/3THB/g3ufBw22O1zugw+0CwXhzG/Qu91S1KnMbq1VCcuBoV/tFmsGRnBEFnRWA/T52LGYiJz/VmWi2i+3bSbvXALQjyeQjmI5TbmKxTRdNtOVpUcKbsxXphEBWuXTvFjL6Zsp6eLmWtE/e90low6mjWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TscjLj9EH/KRacsywHVCsAPQHOLmO0WcT2y2yLFZt9E=;
 b=Z2BdH+DjI1SQJBqzO/sMhut+Ga5bHky1qKLkQIQHdPAITpk+zQJANiSmGt+qiTObIEtKkksZ625yDF48veuHe8r7SGTGFbTJRQL2XI+G4M9obZPbSPmEaYkqo7NzuqajatnQyB6xDgmoUN8Cft2RaqCAZA6ZbmJuJPDhneVN8tNqgkShtYGm8YM7APwf980uhy4mpkgGCkTH8NKK1UUsMEITzhblUcsdGaiqcASffjv0oYmLNXhZLwdYnH3Vqv1xas4jZAW7/CUjqkuMbOq7DKuSzHN+sljaIO1SC/Qo4CZ0DxnYk33rZOwpmkyc+omWp+rWfOSdBlbYAWkgBS9DYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TscjLj9EH/KRacsywHVCsAPQHOLmO0WcT2y2yLFZt9E=;
 b=i0qCEKGocUTgpMD4LaeunByc16sT36Ix4Qiy5k4pPrIe2JK4s/47xWLEoiNrryqYyRfA84lECKOo3DDkYhVh422LLIpV3CaLZ815wweu7kyUCIrYMOE4M4i+vNuP8jH/CMx6ivlpESwu9EMWFpB4DS9+mC4hPBlflwCYpToV8nocqzbKEnhzZIMjNHrM9EeSA6Qs8Gk5dew/rYqprwkPR9T6JxS/b5b3tfLiHfUYCeKErTLXSQxH/v6YkOUPP0Rbo/dz1aQyKfrqftvIrsEOQxYRrGraE08QdCoc46Vg3XW8DqQ40XFoA1+z0H7EWnhoDZhLXib1VJ6hpjOWKfd1JA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB7994.apcprd06.prod.outlook.com (2603:1096:101:2d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 02:15:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 02:15:31 +0000
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
Subject: [PATCH v3 03/11] hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC support
Thread-Topic: [PATCH v3 03/11] hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC
 support
Thread-Index: AQHcmvxMwHvGA2NBeUSebNQKk3XOuQ==
Date: Wed, 11 Feb 2026 02:15:31 +0000
Message-ID: <20260211021527.119674-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 3bfa5963-cb37-4b22-2e39-08de69136ea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dPTgXzXdilp1lZp6NbSDKhYcig5rP7UJisoDfoXuVW0u+hpO9i6XelyWg2?=
 =?iso-8859-1?Q?aIS2T4aknC+SpjHsnYtrpZnRa/Lbzrs2wqmTYC8Ts9taw+TQOYpeEZqzaj?=
 =?iso-8859-1?Q?FQ7BeXlYcRoV2xzcteh0vaUrky2k2ozuqFl1BD+ClAHPmwfHxL953E91Ha?=
 =?iso-8859-1?Q?1UBGGTUboLqndZwhltUMjD+Tify+DRxCq06AlaRpdpho5sdDokQtiEO510?=
 =?iso-8859-1?Q?5DzKSiw8mm1p/mjLPcbHNdN6t54tyjsf4IVXj6IGQWX8z08kFMykd8XDoc?=
 =?iso-8859-1?Q?PgOPNkHnSFcASpe/8pDkZAKEUqFsP2nZA7v0a+8VIKUChexdSx8ugxBGIa?=
 =?iso-8859-1?Q?3s0QS6LlmOSqwONtaAhqFWwRO5lJllsWjJab7fJER1QrRPyoh3sjsmVzL7?=
 =?iso-8859-1?Q?5P4WwNQvG3Tp9V+8k/oSjLOYJceWyntWXFYwmaV+tEPAoQgB8dyo8AfMAW?=
 =?iso-8859-1?Q?+qxYRqXi2rFx2kJ8Fd0Rek4tiVP2c8nAJucvF9kL3JGA9MwC2YB22yecY4?=
 =?iso-8859-1?Q?TDuDxdcDwuow7AWxIHnnt/c75BGi1U3byLgRHrjCwEJeWwOJ0niSTOkrYS?=
 =?iso-8859-1?Q?QHO2yO9Cga6AKpKTiAxig1O3WBXTIvNPazaTwEuu3MIahE58H0347GutOz?=
 =?iso-8859-1?Q?6K/oLu9FHnjlg2wZgYuG7EpmzsRTi7zfSiqKQXjYeMc5/IiqDk68mpSIyU?=
 =?iso-8859-1?Q?dEavBCgs8ycm5qSelD1yfSCEq5Vde36T+aM6UiC8BMH7/YOD1h95NKmAeW?=
 =?iso-8859-1?Q?do5Z0r0mYNaLl6KHiacFE9A8GCoH0+d/k9XXTHSGPP7bs50u/ydQLpo6hT?=
 =?iso-8859-1?Q?ALkiPzkzg19Nr4qfJ2oTwYqK2Xg+uJrhT3AcKcNhADq7pzv6LhfcUdiz6H?=
 =?iso-8859-1?Q?AUzktl8TRCH9KJHNssMVv/57MiUJL1ZVJHQRek6WQA2/7lhhApu3AiD1j4?=
 =?iso-8859-1?Q?qD7UVoAFyzGSLJ1t5gV6IoFjtLswDgGapUmsXkCnZxHaUH9AexFtmLcMvM?=
 =?iso-8859-1?Q?X2lt0L6KYaUKueNbW2PsjULYde1ykhPLn8owdS9XSD7jZL6AQXL6e9xMa/?=
 =?iso-8859-1?Q?u/bkUQEgT0CqhuQHEPq0taHvD5zQmu7Tm33L0RKnWHgT948UWcanH6aJd2?=
 =?iso-8859-1?Q?7WiONPwULS5ELrh49n4kCX/1HyXvU3srTNlDLG1lErncCA0a7iuBcwJiMq?=
 =?iso-8859-1?Q?X+HynqSmu32Og40DC6vyb9pexruFmwdRovMgGNRdcr2Sz8Kenbs9+cAmSM?=
 =?iso-8859-1?Q?BH4NsFJOhivJ/ztRnCUuyHbOCt03jbDgAm2ZykDQxynKDyw4qmHsCjBjH0?=
 =?iso-8859-1?Q?uEI2gPYT1H6Ft2nBM4wGmrxABBtuFCHvpQY4baCu6a2SaYOFDKV7aQDm5s?=
 =?iso-8859-1?Q?rrTYb5zp3irI7sXY4xGSjlHOaRL7zM2KIUOClGmX3xJLrjj8n6061EhrhM?=
 =?iso-8859-1?Q?8Fu2kB7Yj4V9lQldR2OIgFVgDl/pw4CK/YvFxlX336qmaQsY+by+nECG04?=
 =?iso-8859-1?Q?4aALGCYfGj92gtkw4aZ1KQH1Ud9VpEsi6Pc4Z0vf1CADGsou74HDqjuckZ?=
 =?iso-8859-1?Q?7PozY6bakBQWsqjHsHt59ubHiC4UBu/f+jJdhrRqcXMxPqdiBvo460aFaZ?=
 =?iso-8859-1?Q?RZNxvHsmyN28mFrjfKgv6Of1Hb35DlfGXU+gqt4TEMcO0yfLuYde8bolUw?=
 =?iso-8859-1?Q?xAWMnn0Nt/IhU9bo8Uw8HvlsQR99a+KuwU/oNnuj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EANhkLWnmqJrN9t4poyVmpQl6kQF8nzbjFTIccEzz/jl4VOh3U2CxnTpnF?=
 =?iso-8859-1?Q?9ilIbE8jA3nVa2Nejt/1xUXMMLodZHKqrRxabjb2ez9mfCz/1J8xvGHTEk?=
 =?iso-8859-1?Q?/MHGKpryA2FAPY7fi4y4UiEfrj47NTKw5L1yT9TTxmtS3nKS51mdt2/m5o?=
 =?iso-8859-1?Q?MyJc5XHDSF6i4dhvHa39ydKupmFRDVF+D46+L1+shW6TXTl95xZ7Nqfj3E?=
 =?iso-8859-1?Q?dxfdgEYOOCU+hu9BohP5h3BLlv6fFH93/Jciqw6WSAYKp+CEHe5CVBWcJG?=
 =?iso-8859-1?Q?v0f0MfKroEWn1QYWrUkhBK1mJNP+wcCzck2wS/fyYsmIXItF46XC9tZb1M?=
 =?iso-8859-1?Q?IpWaVm4MUoipFd9VovYDTPl3wcBlT8MdujprQz/0xf/2cDmdmFDlUh0Uue?=
 =?iso-8859-1?Q?NsSzK5QqP1JYeGhj2OEz1nD7UEGNgnYZ/rBMFhuHSYLYhZfd1Cuk8woyz5?=
 =?iso-8859-1?Q?qFBX3daFshNfuGpRpdGbu/3/7PV2uf5GR9/UWs0pXSNCPEO6VSTMnctL3F?=
 =?iso-8859-1?Q?vZBzIkT0xN69vRQdH3lDn8kibFqHMwJHZEdpb9s3WwCFe9w/dHfRGppesX?=
 =?iso-8859-1?Q?wPTfmLX0MiNwV855DkGPTAr5o0pvOPVZjAZgoxXwXTAvb+OB+B1BJcWICQ?=
 =?iso-8859-1?Q?0Vt+sUSgTE/5AwtL5vMZfmfom8UMFbCgAgCtNkcSkphAA9thbAKfCrEWvL?=
 =?iso-8859-1?Q?lA8cDKzqtufDvjTFInyASPh4ZNfG87iuUaQ2zwI8iIpvAkdh1kMl+F2la2?=
 =?iso-8859-1?Q?y7/UAgzjLS5XOFfpWlL9ajwyLAhQ2iYHyksdiLeQKqfsZv+bYFkQdB21VJ?=
 =?iso-8859-1?Q?sSYe4NYpXZDZdRhfs9tLKidrBJaTnhpVYfMHOcxnqmE8TBa+ka6e0EoZFb?=
 =?iso-8859-1?Q?hOVH1u0sBG7oA8LvfQozer6/DUO2wbQfJUMRhH8x2x+h6B935NlJT4asRx?=
 =?iso-8859-1?Q?BhvCBTsCa2AUX1u81UkB1vtyA2gAFHunp4VlSI/iHStsTF5HuOjeHYEzmx?=
 =?iso-8859-1?Q?D9x63/gFmfn1LUTqNP+HaG3ixOBORA6QbKQZzHCV8U/bXOyrgfuG78+q6G?=
 =?iso-8859-1?Q?X7tQD7bo3BuDBELMPkbwpA5NwlxtgpnmPZvSS2YXcy4uPXG9l7fbUDXv3Y?=
 =?iso-8859-1?Q?YAD2V+BvXbEQjK+w83cl/5vvOFO7e+srzZ7CeGNPHuIDQcFKnp5zJt5ztw?=
 =?iso-8859-1?Q?jjtet5Ub8SxWNEnl4lyL/jWYIYdiVHi9/vRzh8lVzROnqDv2aU54q3PIXB?=
 =?iso-8859-1?Q?IL7sx6i+Vvz/PIgn7HVFcNURTGJVEyDYYH5S1NkXZegSFkC3dPy3ar+cHp?=
 =?iso-8859-1?Q?ibsY6/xZ+0nYeQ8eLGHnMkexJwxgpQxrEra3/AKi9PbcRxKEFq4q4KxbyI?=
 =?iso-8859-1?Q?qPUnN27l2nPfkd8HtlFAynb4vks4VAX46u8YjpOh4EWGDMOXMo+Oat0uh2?=
 =?iso-8859-1?Q?AIai+ZLSjaec2cqTllddAYHYRTKo/1peLWu6rgwLkNEKcnHfr6eNKfKutq?=
 =?iso-8859-1?Q?WunOMxPzuQ4b99jH7l6pZhafRd13R4n/kyVasd6KwMYDM8OXblA0LWnECU?=
 =?iso-8859-1?Q?raoa6p+6bhxIQ/vf2TwEgvSo4S5t9C44UJ0NMQEPsSENR31apbABAjwHIa?=
 =?iso-8859-1?Q?mykMSKaUPe2Xnbk+aqAQhgiT0K6t8oq1p0TDzWQ3Gwwa0f+7r6/OXFxeee?=
 =?iso-8859-1?Q?Igu3UVEaDgkQ9ZVW0lrf6OQgDwyteu+Q3pAzIoNgMFwtJkGxnXJbMT+ntE?=
 =?iso-8859-1?Q?b/JoxbhnRJeLBqTCpzRNL1buyWGZYCkovg4BzFZksxoyfbcJqYCI9wURVz?=
 =?iso-8859-1?Q?TzAlkWbpnA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfa5963-cb37-4b22-2e39-08de69136ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 02:15:31.4543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0aPN7760dUDSKGMW787HjJtomMtUsN3jwlMtFikodC8us/Uiq0aWKiH4KWPHMQ1+Dbns3gHOqe1G/DhK5tIHuQWgmfvLzqUJz4ti94ZPUjQ=
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

AST2700 A2 is functionally identical to AST2700 A1.=0A=
There are no changes to the IRQ layout, memory map, or peripheral=0A=
configuration. The only difference is the silicon revision.=0A=
=0A=
This commit introduces a dedicated AST2700 A2 SoC type by reusing=0A=
the existing AST2700 A1 implementation and setting the A2 silicon=0A=
revision accordingly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 36 ++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 36 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 61790ea1cc..87dcb82e1b 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -1166,6 +1166,36 @@ static void aspeed_soc_ast2700a1_class_init(ObjectCl=
ass *oc, const void *data)=0A=
     sc->memmap       =3D aspeed_soc_ast2700_memmap;=0A=
 }=0A=
 =0A=
+static void aspeed_soc_ast2700a2_class_init(ObjectClass *oc, const void *d=
ata)=0A=
+{=0A=
+    static const char * const valid_cpu_types[] =3D {=0A=
+        ARM_CPU_TYPE_NAME("cortex-a35"),=0A=
+        NULL=0A=
+    };=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(oc);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(oc);=0A=
+=0A=
+    /* Reason: The Aspeed SoC can only be instantiated from a board */=0A=
+    dc->user_creatable =3D false;=0A=
+    dc->realize      =3D aspeed_soc_ast2700_realize;=0A=
+=0A=
+    sc->valid_cpu_types =3D valid_cpu_types;=0A=
+    sc->silicon_rev  =3D AST2700_A2_SILICON_REV;=0A=
+    sc->sram_size    =3D 0x20000;=0A=
+    sc->pcie_num     =3D 3;=0A=
+    sc->spis_num     =3D 3;=0A=
+    sc->sgpio_num    =3D 2;=0A=
+    sc->ehcis_num    =3D 4;=0A=
+    sc->wdts_num     =3D 8;=0A=
+    sc->macs_num     =3D 3;=0A=
+    sc->uarts_num    =3D 13;=0A=
+    sc->num_cpus     =3D 4;=0A=
+    sc->ioexp_num    =3D 2;=0A=
+    sc->uarts_base   =3D ASPEED_DEV_UART0;=0A=
+    sc->irqmap       =3D aspeed_soc_ast2700a1_irqmap;=0A=
+    sc->memmap       =3D aspeed_soc_ast2700_memmap;=0A=
+}=0A=
+=0A=
 static const TypeInfo aspeed_soc_ast27x0_types[] =3D {=0A=
     {=0A=
         .name           =3D TYPE_ASPEED27X0_SOC,=0A=
@@ -1179,6 +1209,12 @@ static const TypeInfo aspeed_soc_ast27x0_types[] =3D=
 {=0A=
         .instance_init  =3D aspeed_soc_ast2700_init,=0A=
         .class_init     =3D aspeed_soc_ast2700a1_class_init,=0A=
     },=0A=
+    {=0A=
+        .name           =3D "ast2700-a2",=0A=
+        .parent         =3D TYPE_ASPEED27X0_SOC,=0A=
+        .instance_init  =3D aspeed_soc_ast2700_init,=0A=
+        .class_init     =3D aspeed_soc_ast2700a2_class_init,=0A=
+    },=0A=
 };=0A=
 =0A=
 DEFINE_TYPES(aspeed_soc_ast27x0_types)=0A=
-- =0A=
2.43.0=0A=

