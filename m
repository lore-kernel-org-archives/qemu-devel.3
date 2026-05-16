Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07C9CD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOAXG-00056A-Fe; Sat, 16 May 2026 04:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wOAXE-00055w-Ro
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:38:12 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wOAXC-0002au-Av
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1778920690; x=1810456690;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=b5uMr1zAxWNYfoXXIr8D0bRQn8h99Akp12PglOl3TVY=;
 b=I3VBuU1CO7FrC8Wfi00vGv6/zYKKUdTGc9FMyXfkikscKeRMQAuh3qit
 wxJhslBlIOhTUw8ZK5/olNwyJVSobxBIjEVWp5lWH5+YXdO/0Bf1pmnuG
 JwloTJo/i60k13QOnL7lHlOwBvWkoyfjG7wSR9zheUolfri13CRlxE0uT
 +vH7S8p3mRH4nh5bpRcZJtHviKiEjHfcmbSX8LyxxCD7UOL7mlN5NnnY1
 CugwrCQf5wM4V1etiWkQygM94qsMTyekT4VmdAhbqgu1LD5E6fIrdS3G+
 HAjCwLKL4qecbY4ajApDKfWKcB8TrYbdgvXSRd9QtmLVSzN+OUOZoxOLN g==;
X-CSE-ConnectionGUID: 7uQ8OIPaSR+u5jLHE9Ay3Q==
X-CSE-MsgGUID: GYX/JF6OQ/GFvF6E2NrsTw==
IronPort-SDR: 6a082ced_QyCL3Kraj63Sdu7gR6FSGK+Bel3dYx6soNLoM1++ReOzICZ
 NUXGzZ2lmOsfv4tSQLZi0mryM9U6F2SbH/PG44A==
X-IronPort-AV: E=Sophos;i="6.23,238,1770591600"; d="scan'208";a="48033981"
X-MGA-submission: =?us-ascii?q?MDF0itjm85AtTIj4buqBVN2Ib915OQAh2DSaS5?=
 =?us-ascii?q?qz2syzdER0YiO1IEPROL4nsm/7gNGSd3AnYJzSFEgGD1FlhtROORWMxo?=
 =?us-ascii?q?mFAwBBzpEVDGQCwDTQVaSsAfxw5x8SwSe078D9jnuTWAAYmrtIn1HwTR?=
 =?us-ascii?q?Xx/l+jaIDp4z5UEcDUXB7PVg=3D=3D?=
Received: from mail-swedencentralazon11013056.outbound.protection.outlook.com
 (HELO GVXPR05CU001.outbound.protection.outlook.com) ([52.101.83.56])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 May 2026 10:38:04 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4sRDZr8JBxclvqPNP9LCa73E/tIOaMfbCu17z0t1oWB3lbzjhJCroemWi7rF+eQJhI5DyZ6IsUXLLjyr/Vc6nA2XdkEDifxneNUj4xsOhRn2MfTkwxul+XAsZxqSCrEH+E6oAywiV6JIIHe5AG6g8fdrGa2zadQBkSuFRa6r5UxOT8bwCn3cJzE45z42mEUZYmpDmxwpbqwNkG6c9yuLcgLlI26ZBox7isYF1qE64XHFhlqUU/oi4bj+WJ5DB77tLBklVuXBMrLrWwk11K2Zj/lXR3dhkYQNAw46/AfVTUYK07Smy+OYy+7H713fEkg+7ngT2/tROiEf2tjy+8xOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5uMr1zAxWNYfoXXIr8D0bRQn8h99Akp12PglOl3TVY=;
 b=eWay8ZdR3zjLf6nO59dNCmdzs3MGjhXz+IpAPjqRziAU0mFGASBktmVsfckIqmIbf3Qwszm6m4ZM82uOIhZlLmdfWswJwYNJwoYXqCO0Ugt0Uo60r59sCO/is1srza5DcmEJj3UtnbhvR9NYuVwK9Fe0mie+AenJXAX6ucx5bE9dpPKK319BBpOpsR8pNolBGNw6ZfuoEtPYe/SRozjA6KfZAalhqWbeAyW5ih4FDOTexKn64YSEqIol3q0vzSwP/mmwCIL0FAuMQoCQ8OEmHv0KdfR/CsjycjNyrb7YeF2EquM69zWMO8vaLYAVSUn7Av4vn2rGTv5O5Roxc7+ghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU4PR07MB11330.eurprd07.prod.outlook.com (2603:10a6:10:615::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 08:38:01 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 08:38:01 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [PATCH v5 00/15] intel_iommu: Enable PASID support for
 passthrough device
Thread-Topic: [PATCH v5 00/15] intel_iommu: Enable PASID support for
 passthrough device
Thread-Index: AQHc32mIhDRipqg3eEuwWZRA7S5iD7YQX5AA
Date: Sat, 16 May 2026 08:38:00 +0000
Message-ID: <83576adbe6c19d562df2633d118173af4295f3b9.camel@bull.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
In-Reply-To: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU4PR07MB11330:EE_
x-ms-office365-filtering-correlation-id: 41eeb272-16c3-46d3-1824-08deb3267078
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|13003099007|11063799003|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: HUcZBJYzrC05n+I+wR3lBb3nchD+mk8pUMw+jZC1Jo0rP4SOlfHalafwwVefyCGCQYSmbqMp0GomYOrHyaqG2kHiloai3LAUUJSJ7Vo9yqvjdpoI08BU3jcH4LZc75R1dvjifbsyIoXrcxGziG72jebpxJTqzqBfI4BNBpNWj1oIQgnWX/lq8bn6wLcmMZ97HP/0LENtX8T9QcbRAsKw3li7ncOOe+tp8o2oA1QU0NKCFljU7N/M3d6e2YQ3RLoJa4mM2jgpXOqVwTMQbZZW/EL7HyC6a7ajjRH+/q6mUWf3iF8XZ4TvoYXfFaeInK9/0z8hZCSj+8qFL8rwJJtrpRoD+aDrep/N4hKIjnS9VdAtAhQpnr1ZkJRCs/efOfAKVhD0uEX/MqYuI2rJjABSzd6XieXp/zCIzJlmyT892ilyi1dyd/DsomytJ3lcrZiDzbRD0ndxgtuaisAA51fpoRQQfQWDtfUHnrCjpi92+A1FDTPRYUMEPZpREb+XvsfgSjNodPS6556fEnELewFl5C1sEJ1qw5MgwalBTXGncF8IlnpB9gKS4fPGQ/YJfr9zsCxfn3YbVz2Ig6XM6AGEbFASzp74UbNVwuJu+cJwTKsuOk/dZFT29UfnZwPJuWip1ggDhI5RJCMwjPcbH9iVF8tzWLjIG1liZ1KeI8K36OlJfxS32dY3vLCOF0MQTI7OlWvg7nWh9UGGUZ4qcZVK6640fsxPT4nZUbiR2MSYzfQYq41S8R9DRfM74LbBnDah
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(13003099007)(11063799003)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGxjUzVZTjRzYk4vMzhvZkZvOVhBVmp6VWdNcFR2WDhGNnBQaXk1S2F6SlNS?=
 =?utf-8?B?ZGpYRGpOME5jZm1ORE05Z1dqZ3lvbFZ5dzUyNjNjb01KQVhiUHdkSEIrcWtj?=
 =?utf-8?B?U0VqMWdrbWN5ZXpmeUorUHZiWlhWVnM5TnhlZHpmZlMxZ3RKdmJpVE5DUmVm?=
 =?utf-8?B?WFNOOXoyaS9mRlhVZVM4YW9iNUo4OFg3VWk3TG9IaC9pVmx0RVdrU2ZUZDZm?=
 =?utf-8?B?V21YT2VaZVVJQ1BCb0xHb3RxTFFVUmFwdjRBOHZpdVAzbnNpeVdyWXNIUndP?=
 =?utf-8?B?TjUzUDl5eFpicU4zQ3lQS0RYeHlnbnh4RFU5dWlSekF6RTVFa3JXeG5mWVBU?=
 =?utf-8?B?bzVyMmxPaXFNZlRwdUtQeGhBZS95cm5CVS9rMThHUVdvVUFTT1lpSFNxOWFz?=
 =?utf-8?B?WTh5VXB5dVNXOHB4alJWWDhVdjc3NzgzV3hXSG1ZMmpiOUNSSUlIQ0c2NTV0?=
 =?utf-8?B?dkZyTTJvQVNOL3V5SklQcXdYTjZsQmp0UXlOcjRXNEpCLzlscHlGNVVjU1NH?=
 =?utf-8?B?ZkJRenQ2RFBlMmRvZU5Ldk5zTnVUa0kyWWZBSWVOQmV2dVcvQ3lMUmNvenFX?=
 =?utf-8?B?WTVTVW43WnBmWkZpcGp3YjBpYWt2dzlONkNCNEs5aHlaVngwWW1qTUN0dGNy?=
 =?utf-8?B?RE55eUdTWkRTMFNuQmhIeGhEVmxsb0o3MXlucGlDMUh4Um5yUVFGYUl3MmZo?=
 =?utf-8?B?Q2ZJcytUSm5MeHdLVGFLa2VzOW1BeVhvL3dkckxvY3ArbVBCVXhsN1lwaGE4?=
 =?utf-8?B?VDR5OUNXdy9FcmZoVjdxb2Z4bThlaG9GbUczUGpUdGNUdEwxL3A5U1kvZWRw?=
 =?utf-8?B?Y2JSRWxRa3Z6Q3VPWEZEZUpCMmdsTy9UQ1ozYXdDOUNML1puQVpVdkVDK0xW?=
 =?utf-8?B?NVBGUVVZeEJtZXlRczV3Unlna1ZJVEFGOUp3M2kwcVdib0VXaHpBZDU2NWJk?=
 =?utf-8?B?OFNLeFRneld1dU9DY2xHQUVxOG9oT0Vibnp1WHJoWnVXYWxTbnZRbFVGRlp0?=
 =?utf-8?B?cllUM2U0bFJXUlBiUjRFTThRbExkSUVFUnd6cTVBdEtPdGExaTlJb0Q2VEF2?=
 =?utf-8?B?ZzBoN3FEcjRvVlIrYmtrZzlHeHhRWmhlOS82TGFqSmNmMGxCRGVWeDNWc0I1?=
 =?utf-8?B?cm16LzIyTzdhTEZuc1oyQnlaclB0U0pwNE5EdVVBbGFFdUI2NWt0QjVHU3lx?=
 =?utf-8?B?U2NHbU1wY3FtcFlSUmJ4RFVQSTBHQ3llZzRhZmRNNlJvTE0vVEo5OFRNUlZZ?=
 =?utf-8?B?VU14d2NIMk92RENYdFQvUVJudWozWCtvUGdQd211NVNNRzVyaWNOZE00ZXpF?=
 =?utf-8?B?VW5mSnNnRHdqcGx4SW9jZXowNFkrbUNBVW9DQlZQc1ZiZFpoRGdMR1pOQmtL?=
 =?utf-8?B?QXAwRHVpRjJ6eGFGamFzSXl6Tjg0V20wWFlQWWltNG9hU05nMzNleG1MWWsx?=
 =?utf-8?B?ZlVsMHZ0MnVDYkJqcVp0eW0xVGdqakZaUkEvMVdWcHZIWjdUcW8zTVhFRktu?=
 =?utf-8?B?bUIycVViVDNyeTJSM3JvOVh3R3FMQTAzRE5vOGszaUFudFh4cklDRlZGVGo1?=
 =?utf-8?B?VjlTamlsWDZWeDJBb3FyZUNZV01scXdtNkRGSnVBeFpRSzY1aXcrOWxzNVRI?=
 =?utf-8?B?WXplMU40ZURaWTk4ME9FNUZIaVh1ZUtjVkI0SWJLcE8yblhPZUFXS3RCVjdU?=
 =?utf-8?B?cUYvL1JPd2xRYWREZzlnUXVCKzVNQTZpc2ZxeFdwcVMvTm1NOG8vc21MUVc0?=
 =?utf-8?B?Y0RYRldPV0dGaG1UYlROTVVvVXl2aS9VekFmODUvTWtmVUtaQ0NTZTQrbXRJ?=
 =?utf-8?B?VXVyczFsM0x4ZytkWGh5UTlBeUZHcXR2VEROZHJTUFZwZWUvYmRwcEc3Y3p6?=
 =?utf-8?B?ZU5LTXIrVDVxdCs0WllGRDkyNm1pN1N3NWpsdStBdFVBUm9YcUxjNGsyTWpj?=
 =?utf-8?B?cGRNVUUvM2FYL0ZLWm1ocVhEdnk0S1RTY3g3MXhQNUhYMzJoMktjTEpjaWM5?=
 =?utf-8?B?dTBJWmhpdndBMFJxdUR5d3o3VmdNOTRSQmN1MDZUNlc4aU9IZUdEVGNVZzlJ?=
 =?utf-8?B?RVJpZFE1YzBJYVhtb1VjSlFucGRkL05YbndnVVF6dkVjWnMyOXRPZGFDMVZZ?=
 =?utf-8?B?R3lWdFhGVE8vM3NueC9vTGtLd05kZzNxcjJTS0E2RHQzMWJHVitxVm1tY0NN?=
 =?utf-8?B?T2RXeXlpcWsyeS93eDNrWEJsQzMxazJJRmhpYVo1dVQ3VnNENisrdXdTaU9y?=
 =?utf-8?B?Q2t2M2NnUHE2VTljbFQrL3R1SndXWEoybHZMVk9ZL3RjYlA1Q0NWMWVqVzFu?=
 =?utf-8?B?MHMyTnRHTU5maDlHOVdnUnZhZ2QvUm9WcjFFNVIrV1lGMGUvWmNsaFN3ZXRV?=
 =?utf-8?Q?n06uqV860bPkowxs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37D329DEEC0D2749B60068C42DDBDA16@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: euGEGjtwh7Rjx43GwH9K3UX6xrHrk6+a2D2fc7zwYuGQXt6RpvzOQkQdCHKhD++rlrmVzDUReX93yx8lgbHAUKapgCQxxkWysuLcjgN6kzrWqnr+Hc2wh6xQ+QD8Jta9HF3Vg/imN9/STKl/AHcSWnkJDoBy52QaTe5hZuDEiv/z9/12qppHVNG7o1QaK5y/Fp03Db7JuEQITDeRIuadrc/iKgtZWUvTi9l0mZvmfK3bLbKVVjqpwLf8019Xdse+vICAxfjNBaBWUjEWI5oA6Ys1cmoco7hMUOIp+VVt2Wy/4EBQLlti+4j3rz1TufR9sNu4Z38uU1tFFKQZUjXQBw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41eeb272-16c3-46d3-1824-08deb3267078
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2026 08:38:00.9793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpzE9sjVXIXIwv5zC7R5uhz8qRz+zB8rFKtxGczFYMKPpWx8nXRiV5jNnU0RX3SzpF1p4mIe93Cwyav4cg/u6vWfhliKT74E0y8LAhvryYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB11330
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
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

SGkgWmhlbnpob25nLA0KDQpUaGUgc2VyaWVzIHBhc3NlZCBvdXIgbm9uLXJlZ3Jlc3Npb24gdGVz
dCBzdWl0ZSBmb3IgZW11bGF0ZWQgc3ZtLiAgDQpJIHdpbGwgdHJ5IHRvIHRlc3QgdXBjb21pbmcg
dmVyc2lvbnMgYXMgd2VsbC4gIA0KDQpjbWQNCg0KT24gU2F0LCAyMDI2LTA1LTA5IGF0IDAwOjA3
IC0wNDAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4gSGksDQo+IA0KPiBOb3cgd2UgYWxyZWFk
eSBzdXBwb3J0IGZpcnN0IHN0YWdlIHRyYW5zbGF0aW9uIHdpdGggcGFzc3Rocm91Z2ggZGV2aWNl
ICANCj4gYmFja2VkIGJ5IG5lc3RlZCB0cmFuc2xhdGlvbiBpbiBob3N0LCBidXQgb25seSBmb3Ig
SU9NTVVfTk9fUEFTSUQuDQo+IA0KPiBTdHJ1Y3R1cmUgVlREQWRkcmVzc1NwYWNlIGluY2x1ZGVz
IHNvbWUgZWxlbWVudHMgc3VpdGFibGUgZm9yIGVtdWxhdGVkICANCj4gZGV2aWNlIGFuZCBwYXNz
dGhyb3VnaCBkZXZpY2Ugd2l0aG91dCBQQVNJRCwgZS5nLiwgYWRkcmVzcyBzcGFjZSwgIA0KPiBk
aWZmZXJlbnQgbWVtb3J5IHJlZ2lvbnMsIGV0YywgaXQgaXMgYWxzbyBwcm90ZWN0ZWQgYnkgdnRk
IGlvbW11IGxvY2ssICANCj4gYWxsIHRoZXNlIGFyZSB1c2VsZXNzIGFuZCBiZWNvbWUgYSBidXJk
ZW4gZm9yIHBhc3N0aHJvdWdoIGRldmljZSB3aXRoICANCj4gUEFTSUQuDQo+IA0KPiBXaGVuIHRo
ZXJlIGFyZSBsb3RzIG9mIFBBU0lEcyB1c2VkIGluIG9uZSBkZXZpY2UsIHRoZSBBUyBhbmQgTVJz
IGFyZSAgDQo+IGFsbCByZWdpc3RlcmVkIHRvIG1lbW9yeSBjb3JlIGFuZCBpbXBhY3QgdGhlIHdo
b2xlIHN5c3RlbSBwZXJmb3JtYW5jZS4NCj4gDQo+IFNvIGluc3RlYWQgb2YgdXNpbmcgVlREQWRk
cmVzc1NwYWNlIHRvIGNhY2hlIHBhc2lkIGVudHJ5IGZvciBlYWNoIHBhc2lkICANCj4gb2YgYSBw
YXNzdGhyb3VnaCBkZXZpY2UsIHdlIGRlZmluZSBhIGxpZ2h0IHdlaWdodCBzdHJ1Y3R1cmUgIA0K
PiBWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSB3aXRoIG9ubHkgbmVjZXNzYXJ5IGVsZW1lbnRzIGZv
ciBlYWNoIHBhc2lkLiBXZSAgDQo+IHdpbGwgdXNlIHRoaXMgc3RydWN0IGFzIGEgcGFyYW1ldGVy
IHRvIGNvbmR1Y3QgYmluZGluZy91bmJpbmRpbmcgdG8gIA0KPiBuZXN0ZWQgaHdwdCwgdG8gcmVj
b3JkIHRoZSBjdXJyZW50IGJpbmRlZCBuZXN0ZWQgaHdwdCBhbmQgZXZlbiBmdXR1cmUgIA0KPiBQ
UlEgc3VwcG9ydC4gSXQncyBhbHNvIGRlc2lnbmVkIHRvIHN1cHBvcnQgSU9NTVVfTk9fUEFTSUQu
DQo+IA0KPiBUaGUgcG90ZW50aWFsIGZ1bGwgZGVmaW5pdGlvbiBvZiBWVERBY2NlbFBBU0lEQ2Fj
aGVFbnRyeSBtYXkgbGlrZToNCj4gDQo+IMKgIHR5cGVkZWYgc3RydWN0IFZUREFjY2VsUEFTSURD
YWNoZUVudHJ5IHsgIA0KPiDCoMKgwqDCoMKgIFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2Q7
ICANCj4gwqDCoMKgwqDCoCBWVERQQVNJREVudHJ5IHBhc2lkX2VudHJ5OyAgDQo+IMKgwqDCoMKg
wqAgdWludDMyX3QgcGFzaWQ7ICANCj4gwqDCoMKgwqDCoCB1aW50MzJfdCBmc19od3B0X2lkOyAg
DQo+IMKgwqDCoMKgwqAgdWludDMyX3QgZmF1bHRfaWQ7ICANCj4gwqDCoMKgwqDCoCBpbnQgZmF1
bHRfZmQ7ICANCj4gwqDCoMKgwqDCoCBRTElTVF9IRUFEKCwgVlREUFJRRW50cnkpIHZ0ZF9wcnFf
bGlzdDsgIA0KPiDCoMKgwqDCoMKgIElPTU1VUFJJTm90aWZpZXIgcHJpX25vdGlmaWVyX2VudHJ5
OyAgDQo+IMKgwqDCoMKgwqAgSU9NTVVQUklOb3RpZmllciAqcHJpX25vdGlmaWVyOyAgDQo+IMKg
wqDCoMKgwqAgUUxJU1RfRU5UUlkoVlREQWNjZWxQQVNJRENhY2hlRW50cnkpIG5leHQ7ICANCj4g
wqAgfSBWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeTsNCj4gDQo+IEJhc2VkIG9uIG5ld2VzdCBtYXN0
ZXIgYnJhbmNoLiAgDQo+IEdJVCBicmFuY2g6IFtodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1
L3FlbXUvdHJlZS96aGVuemhvbmcvaW9tbXVmZF9wYXNpZC52NV0oaHR0cHM6Ly9naXRodWIuY29t
L3lpbGl1MTc2NS9xZW11L3RyZWUvemhlbnpob25nL2lvbW11ZmRfcGFzaWQudjUpDQo+IA0KPiBQ
QVRDSDAxLTA4OiBTb21lIHByZXBhcmluZyB3b3JrICANCj4gUEFUQ0gwOS0xMzogSGFuZGxlIFBB
U0lEIGVudHJ5IGFkZGl0aW9uL3JlbW92YWwgYW5kIGJpbmQvdW5iaW5kICANCj4gUEFUQ0gxNC0x
NTogQWRkIFBBU0lEIHJlbGF0ZWQgY2hlY2sgYW5kIGVuYWJsZSBQQVNJRCBmb3IgcGFzc3Rocm91
Z2ggZGV2aWNlDQo+IA0KPiBUZXN0czogIA0KPiBUZXN0ZWQgd2l0aCBEU0EgZGV2aWNlIHdoaWNo
IGRyaXZlciB1c2VzIDIgUEFTSURzIGJ5IGRlZmF1bHQuDQo+IA0KPiBUaGFua3MgIA0KPiBaaGVu
emhvbmcNCj4gDQo+IENoYW5nZWxvZzogIA0KPiB2NTogIA0KPiAtIHVzZSAldSBmb3IgcGFzaWQg
cHJpbnQgKFNoYW1tZXIpICANCj4gLSBzL2F0dGFjaG1lbnQvZGV0YWNobWVudCBpbiBBUEkgZG9j
IChTaGFtbWVyKSAgDQo+IC0gc2F2ZSBpb21tdSBwYXNpZCBpbiB2dGRfYXMgdG8gYXZvaWQgdGhl
IGNoZWNrIG9mIFBDSSBwYXNpZCB3aGVuZXZlciBwb3NzaWJsZSAoQ2xlbWVudCkgIA0KPiAtIGNv
bW1pdCBsb2cgbWlub3IgdHdlYWsgb24gcGF0Y2gzIGFuZCBwYXRjaDcgKExpdXlpKSAgDQo+IC0g
dXNlIG5hbWUgJ3Bhc2lkLWJpdHMnIGZvciBwYXNpZCBwcm9wZXJ0eSAoTGl1eWkpDQo+IA0KPiB2
NDogIA0KPiAtIGltcHJvdmUgZG9jdW1lbnRzIG9mIFZJT01NVV9GTEFHcyAoQ8OpZHJpYykgIA0K
PiAtIGFkZCBhIGNsZWFudXAgcGF0Y2ggdG8gc2ltcGxpZnkgdGhlIGNoZWNrIGJldHdlZW4gUENJ
IHBhc2lkIGFuZCBWVEQgcGFzaWQgKENsZW1lbnQpICANCj4gLSByZWJhc2UgdG8gbmV3ZXN0IG1h
c3RlciBicmFuY2gNCj4gDQo+IHYzOiAgDQo+IC0gZml4IEBQYXNpZCBwYXJhbWV0ZXIncyBjb21t
ZW50IChMaXV5aSkgIA0KPiAtIGludHJvZHVjZSBhIHdyYXBwZXIgdnRkX2FjY2VsX2RlbGV0ZV9w
YygpIChMaXV5aSkgIA0KPiAtIGRyb3AgcGF0Y2gxMiBpbiB2MiB0byBhdm9pZCBhIHJhY2UgY29u
ZGl0aW9uIChDbGVtZW50KSAgDQo+IC0gcy9QQVNJRF8wL0lPTU1VX05PX1BBU0lEIHMvZ2xvYWwv
Z2xvYmFsIHMvYXNfaXQvaGlvZF9pdCAoTGl1eWkpICANCj4gLSBtYWtlIHRyYWNlX3Z0ZF9kZXZp
Y2VfYXQvZGV0YWNoX2h3cHQgdXNlIElPTU1VX05PX1BBU0lEIChMaXV5aSkgIA0KPiAtIGNoYW5n
ZSBfYWNjZWwgc3ViZml4IHN0eWxlIG5hbWluZyB0byB2dGRfYWNjZWxfIHByZWZpeCBzdHlsZSAo
TGl1eWkpICANCj4gLSBkcm9wIHVubmVjZXNzYXJ5IHBhcmFtZXRlciB2dGRfaGlvZCogZnJvbSB2
dGRfZGVzdHJveV9vbGRfZnNfaHdwdCgpIChMaXV5aSkgIA0KPiAtIGludHJvZHVjZSBhIG5ldyBm
bGFnIFZJT01NVV9GTEFHX1dBTlRfUEFTSURfQVRUQUNIIGZvciBwYXNpZCBhdHRhY2ggKE5pY29s
aW4pDQo+IA0KPiB2MjogIA0KPiAtIG1vdmUgdGhlIGNoZWNrICJzLT5wYXNpZCA+IFBDSV9FWFRf
Q0FQX1BBU0lEX01BWF9XSURUSCIgdG8gcGF0Y2g1IChDbGVtZW50KSAgDQo+IC0gbW92ZSAjaW5j
bHVkZSAiaHcvY29yZS9pb21tdS5oIiBiZWZvcmUgI2luY2x1ZGUgImh3L2NvcmUvcWRldi5oIiAo
TGl1eWkpICANCj4gLSBwb2xpc2ggdGhlIGNvbW1lbnQgYWJvdXQgQFBhc2lkIHBhcmFtZXRlciAo
TGl1eWkpICANCj4gLSBzL3BlL3Bhc2lkX2VudHJ5LCBzL2FzX2l0L2hpb2RfaXQsIHMvdnRkX2Zp
bmRfYWRkX3BjL3Z0ZF9hY2NlbF9maWxsX3BjIChMaXV5aSkgIA0KPiAtIHMvVlREQUNDRUxQQVNJ
RENhY2hlRW50cnkvVlREQWNjZWxQQVNJRENhY2hlRW50cnkgKExpdXlpKSAgDQo+IC0gYWRkIGV4
cGxhbmF0aW9uIGluIGNvZGUgYWJvdXQgUEFTSUQgcmVtb3ZhbCBiZWZvcmUgYWRkaXRpb24gKExp
dXlpKSAgDQo+IC0gcG9saXNoIHRoZSBjb21tZW50IGFib3V0IHNjb3BlIG9mIFZUREFjY2VsUEFT
SURDYWNoZUVudHJ5IHZzIFZURFBBU0lEQ2FjaGVFbnRyeSAoTGl1eWkpICANCj4gLSBhZGQgYW4g
b3B0aW1pemF0aW9uIHRvIGJ5cGFzcyBQQVNJRCBlbnRyeSBhZGRpdGlvbiBmb3IgUEFTSUQgc2Vs
ZWN0aXZlIHB2X2ludl9kc2MgKExpdXlpKQ0KPiANCj4gdjE6ICANCj4gLSB1c2UgbmFtaW5nIHBh
dHRlcm4gIlhYWF9TRVRfVEhFTkFNRSIgc2FtZSBhcyBzbW11IChDbGVtZW50KSAgDQo+IC0gZml4
IHMtPnBhc2lkIGNoZWNrIChDbGVtZW50KQ0KPiANCj4gUkZDdjI6ICANCj4gLSBleHRlbmQgYXR0
YWNoL2RldGFjaF9od3B0KCkgaW5zdGVhZCBvZiBpbnRyb2R1Y2luZyBuZXcgY2FsbGJhY2tzIChT
aGFtbWVyKSAgDQo+IC0gRGVmaW5lIElPTU1VX05PX1BBU0lEIGZvciBkZXZpY2UgYXR0YWNobWVu
dCB3aXRob3V0IHBhc2lkIChOaWNvbGluKSAgDQo+IC0gdXBkYXRlIHZ0ZF9kZXN0cm95X29sZF9m
c19od3B0KCkncyBwYXJhbWV0ZXIgZm9yIG5hbWluZyBjb25zaXN0ZW5jeSAoQ2xlbWVudCkgIA0K
PiAtIGNoZWNrIHBhc2lkIGJpdHMgc2l6ZSB0byBiZSBubyBtb3JlIHRoYW4gMjAgYml0cyAoQ2xl
bWVudCkgIA0KPiAtIGluaXRpYWxpemUgbG9jYWwgdmFyaWFibGUgbWF4X3Bhc2lkX2xvZzIgdG8g
MCAoQ8OpZHJpYykNCj4gDQo+IA0KPiBaaGVuemhvbmcgRHVhbiAoMTUpOiAgDQo+IMKgIHZmaW8v
aW9tbXVmZDogRXh0ZW5kIGF0dGFjaC9kZXRhY2hfaHdwdCBjYWxsYmFjayBpbXBsZW1lbnRhdGlv
bnMgd2l0aCAgDQo+IMKgwqDCoCBwYXNpZCAgDQo+IMKgIGlvbW11ZmQ6IEV4dGVuZCBhdHRhY2gv
ZGV0YWNoX2h3cHQgY2FsbGJhY2tzIHRvIHN1cHBvcnQgcGFzaWQgIA0KPiDCoCB2ZmlvL2lvbW11
ZmQ6IENyZWF0ZSBuZXN0aW5nIHBhcmVudCBod3B0IHdpdGggSU9NTVVfSFdQVF9BTExPQ19QQVNJ
RCAgDQo+IMKgwqDCoCBmbGFnICANCj4gwqAgaW50ZWxfaW9tbXU6IENyZWF0ZSB0aGUgbmVzdGVk
IGh3cHQgd2l0aCBJT01NVV9IV1BUX0FMTE9DX1BBU0lEIGZsYWcgIA0KPiDCoCBpbnRlbF9pb21t
dTogUmVuYW1lIHBhc2lkIHByb3BlcnR5IHRvICJwYXNpZC1iaXRzIiBhbmQgZGVmaW5lIGl0IGFz
ICANCj4gwqDCoMKgIHR5cGUgdWludDggIA0KPiDCoCBpbnRlbF9pb21tdTogRXhwb3J0IHNvbWUg
ZnVuY3Rpb25zICANCj4gwqAgaW50ZWxfaW9tbXU6IFVzZSBJT01NVV9OT19QQVNJRCBhbmQgZGVs
ZXRlIFBBU0lEXzAgIA0KPiDCoCBpbnRlbF9pb21tdTogUmVmYWN0b3IgUEFTSUQgcHJvY2Vzc2lu
ZyB0byB1c2UgSU9NTVVfTk9fUEFTSUQgIA0KPiDCoMKgwqAgaW50ZXJuYWxseSAgDQo+IMKgIGlu
dGVsX2lvbW11X2FjY2VsOiBIYW5kbGUgUEFTSUQgZW50cnkgYWRkaXRpb24gZm9yIHBjX2ludl9k
c2MgcmVxdWVzdCAgDQo+IMKgIGludGVsX2lvbW11X2FjY2VsOiBIYW5kbGUgUEFTSUQgZW50cnkg
cmVtb3ZhbCBmb3IgcGNfaW52X2RzYyByZXF1ZXN0ICANCj4gwqAgaW50ZWxfaW9tbXVfYWNjZWw6
IEJ5cGFzcyBQQVNJRCBlbnRyeSBhZGRpdGlvbiBmb3IganVzdCBkZWxldGVkIGVudHJ5ICANCj4g
wqAgaW50ZWxfaW9tbXVfYWNjZWw6IEhhbmRsZSBQQVNJRCBlbnRyeSByZW1vdmFsIGZvciBzeXN0
ZW0gcmVzZXQgIA0KPiDCoCBpbnRlbF9pb21tdV9hY2NlbDogU3dpdGNoIHRvIFZUREFjY2VsUEFT
SURDYWNoZUVudHJ5IGZvciBQQVNJRCAgDQo+IMKgwqDCoCBiaW5kL3VuYmluZCBhbmQgUElPVExC
IGludmFsaWRhdGlvbiAgDQo+IMKgIGludGVsX2lvbW11X2FjY2VsOiBBZGQgcGFzaWQgYml0cyBz
aXplIGNoZWNrICANCj4gwqAgaW50ZWxfaW9tbXU6IEV4cG9zZSBmbGFnIFZJT01NVV9GTEFHX1BB
U0lEX1NVUFBPUlRFRCBhbmQgIA0KPiDCoMKgwqAgVklPTU1VX0ZMQUdfV0FOVF9QQVNJRF9BVFRB
Q0gNCj4gDQo+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5owqDCoMKgIHzCoCAyMCArLSAg
DQo+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHzCoCA0NCArKystICANCj4gwqBp
bmNsdWRlL2h3L2NvcmUvaW9tbXUuaMKgwqDCoMKgwqDCoMKgIHzCoCAxMyArKyAgDQo+IMKgaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmjCoCB8wqDCoCA0ICstICANCj4gwqBpbmNsdWRlL2h3
L3ZmaW8vdmZpby1kZXZpY2UuaMKgIHzCoMKgIDEgKyAgDQo+IMKgaW5jbHVkZS9zeXN0ZW0vaW9t
bXVmZC5owqDCoMKgwqDCoMKgIHzCoCAxOCArLSAgDQo+IMKgaW5jbHVkZS9zeXN0ZW0vbWVtb3J5
LmjCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstICANCj4gwqBiYWNrZW5kcy9pb21tdWZkLmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOSArLSAgDQo+IMKgaHcvYXJtL3NtbXV2My1hY2Nl
bC5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMiArLSAgDQo+IMKgaHcvaTM4Ni9pbnRlbF9pb21t
dS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjU0ICsrKysrKysrKy0tLS0tLS0tLS0tICANCj4gwqBo
dy9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmPCoMKgwqAgfCA0MTQgKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tICANCj4gwqBody92ZmlvL2RldmljZS5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMTEgKyAgDQo+IMKgaHcvdmZpby9pb21tdWZkLmPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqAgNTYgKysrLS0gIA0KPiDCoGh3L3ZmaW8vdHJhY2UtZXZlbnRzwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNCArLSAgDQo+IMKgMTQgZmlsZXMgY2hhbmdlZCwgNjA3
IGluc2VydGlvbnMoKyksIDI1NSBkZWxldGlvbnMoLSkNCj4g

