Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D33CD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUJ0h-0004He-GH; Tue, 02 Jun 2026 02:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wUJ0d-0004H4-Jd
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:53:55 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wUJ0b-0000rC-6a
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1780383233; x=1811919233;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=b71IcyyIylw44PjX/BhkrWJQhnpMBK7QLAlRBYpPeFc=;
 b=O7BDKR+lI0tTwj37ahq5bqVL7yjNGamY/B3knVK8wZmOxiv8YbbaekON
 Y7En1BgYyfhgfkNuiea8DR9SWo27i4OccRG2u9Gn8CSVqyGujrBmPaM+d
 92XdJ7xqGM8Ml2poQUmmR2ffyhTBPNXQyW1YRrOL3d4AcY/DQWKysM/+Z
 BekAzhU6WDsW7rpxxYrRz4MznrLLQXUBpJq3du4aRNdj5KAgj40q9BHZK
 s4HTW5+/RYjAvBtT2BARDAQfKmVASenreQxKLMip9xrZAn+OVFU2DTbWN
 smUU1wGSJcMkGQevq/7huAAgKhDClOm+qT6oIrmp1qhdhWL6S/Tk0au5N w==;
X-CSE-ConnectionGUID: RNlP+EgTThipDUjT2ZCHzQ==
X-CSE-MsgGUID: f6322AdZQxi4U1ONqekWMA==
IronPort-SDR: 6a1e7dfd_8l8UGaEs2SvI4CrPmhuxSkyP8o0PieDrg/nWco2rQccDQBU
 E/CzM+brMJ/Ofr2KgD0FnmZXGUWgAkizAcI18kQ==
X-IronPort-AV: E=Sophos;i="6.24,182,1774306800"; d="scan'208";a="48152355"
X-MGA-submission: =?us-ascii?q?MDEeafyFPw6xd23nxQZX7kaR85RHjt4MGbVKWc?=
 =?us-ascii?q?j+Gz7KtFXG87iddLk6Y2QsL1Ij95HMcFbddFHLoYPhUwFu+YUzI8L5hk?=
 =?us-ascii?q?hWojmIzXhwwL4cbKxdmQ0wp2pJmvYpu5nG6whpBcbSW+M1NePqab5oYQ?=
 =?us-ascii?q?oXEGr1uE4sgLZtZh5XFuBPjQ=3D=3D?=
Received: from mail-swedencentralazon11013050.outbound.protection.outlook.com
 (HELO GVXPR05CU001.outbound.protection.outlook.com) ([52.101.83.50])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 02 Jun 2026 08:53:48 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q70PtZHBNBePTBoYRA6wcDI5gLxcPfYVP7x3t82lA+JRXArncrQptg831/X9KYM0Epy0kcYd0pueDnT9p+K39oT++3YNcyQqoqz71ztfhEh1tPvqwEBba8MlX5Y5O5t0elKYI86tepepiNRySSJRCJCam9GYgT0ZQr5TN15mc9MRZsu47iXCOb3tdn+1R3TgaFT3sxK204mehZ/9Xg+/l9OUq7lhhGSPXP7f0jQVoESKwWaH7aWdWLhghwWs+zXbiNZcyX5er40ngoFWAPYsOzkoJOa8OXigQnvNvdrNTWT4qZNnVuEA4xsNGNP51JI+/1VQO9oOKhl5oLxWpLVECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b71IcyyIylw44PjX/BhkrWJQhnpMBK7QLAlRBYpPeFc=;
 b=pgfTaUd8cUBKkEqdPIkq478WvVffM/rHvES3KixV2uOhMQEv8Vpww9La56suV27tWtEqFSeNmR48Fk14aLDpmqg44WSxQNrqi7gaTa5d+vYg2LjyT5XvgULRwXW2NOEapy2pbE5Ws5apHJJ/elgl9SdL2H/mHM+6apGF7oHHerGcffijI/sISTzh8UVcE4yO2KRQjMyuJkdbnoQHW+s6mhMXa7/nAkObOBlmMmwEW17CQ+iZjsHGuogDpjFnVbtfOIFZs8rcUhen2hrKz1aOaMBIEBg60Y5KLHsBjT8/IqiKnJmBUj/r50jW8pc8XvAyXKNr43C23CitWl8rZB9czw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by FRWPR07MB10787.eurprd07.prod.outlook.com (2603:10a6:d10:188::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Tue, 2 Jun 2026
 06:53:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 06:53:47 +0000
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
Subject: Re: [PATCH v6 06/17] intel_iommu: make vtd_dev_get_pe_from_pasid()
 more generic
Thread-Topic: [PATCH v6 06/17] intel_iommu: make vtd_dev_get_pe_from_pasid()
 more generic
Thread-Index: AQHc7Zxh6jGvSLBa6U2es4eZYUJOXbYq3ayA
Date: Tue, 2 Jun 2026 06:53:47 +0000
Message-ID: <91635e557417bbe97f81cf551057f1aac4b38aac.camel@bull.com>
References: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
 <20260527054658.1021096-7-zhenzhong.duan@intel.com>
In-Reply-To: <20260527054658.1021096-7-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|FRWPR07MB10787:EE_
x-ms-office365-filtering-correlation-id: 32c8ec68-c9e1-465e-4949-08dec073b209
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|4143699003|56012099006|3023799007|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: xdwjuK5Br/XnJdglqAoWvnQntYypo7aWfr3Ggft4V5mK1la96JDYiqQnwj2cgH+Htt+87jWFLb2GRrChIPNXJxQkfBpP+c+8ojdEtzS5ZdWWwLhq9MxHfxEOhL3ZrWSkq28+A3jZCrRHgchEWghM7/8+Dz3wZtpA0JxKIsk6bMfkOUOereU1DhXN4MnuxdOw5UY8mCYDLG6ZYTsfdDPBQ/EGdNNcdBGF8s8GOQHF/csGJBKDAdDkPi8zhjvhk+/eSbmo3Iz0hDWb6Uz3WX0lgkFSl8CDO5m/F8WlXTMnyhRPkOuiBwfJ20lCMpTsWg2zU+z4S0G+rDkJclbJLesDA0vjyJ9xnXcsawvrZBkAUcX5zf54i4bHFpeMiT8mR7BAxyjPQJ3asJ1/XETtPU64RfBUJS9jpEen/mXdoA/hzLYYWU1ThMNpVxE6Wu349gt1JBShEFD0XEYgevFTrgf4ut9047IrKv+ogOrL6mkyHhS3T6RNGZATFwbc5KwahF9QTE8Yecl5h4q1VqEMIvNXDRsZf5UBKMEgQ8wdp6wl9G6cnMwrLE3f7+XBHIQtYhcBNzCQx375t8dgBpKWSNYeCrU9RvmMNgsLyFfWVvwSSdTT1uzMeRBb4TLnnkRPKhfHib4CZQak0v6bdm20PAGp+y8DMdYgP8WjEvx/ob/XAUuCbF6DPfPvIWw1dQMA+38oHMPmymBOalzHxbyAdorbXhKTdh7YFZzBfy5Qq7fiZRKFkGOSJUjxYt4I/BD6LGi9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(4143699003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTBuZDZRVk9Gd0ZXVTU4THF5YmJiRnJpa3dzdkMxcEhvcjNuNEpNbnAvaXRt?=
 =?utf-8?B?L0ExUXpZcUR3QU9WRzBiTEQvZ3p5dGhUN1FkS0NLcVA1VTM5b05YV0l1c1hv?=
 =?utf-8?B?alVmc1JtN2E1UmRvOHpCcHR1aFFucURBN3dtc2hwTHpqVFdnWUk0L3ZvNnc1?=
 =?utf-8?B?Yk9XNURzeVVJVXFnc0wyRHAwMkU3cldCZ1I2Z0gwTVhnMnpKbGV1b2hkKy9m?=
 =?utf-8?B?cFVJRTh2V2FwWjFONjg0bjkxbFZWcTh4ZS9RdFVqUnBJR3JxbE42WkEyem0x?=
 =?utf-8?B?SnBrN3lmYTRJUDR1dkQvWGNrR2RWSnhrbUJUVHI4MDhnTTBjNHRtbEovQVNy?=
 =?utf-8?B?cEE3aWxZUGlVTEpydkFVZS9DU0xkWXhvNjlLbDMxcU53ekZqMjg2Z01laG0r?=
 =?utf-8?B?RTE4YkIvUndQNWhzWDhQN2VJQnM5ZkFoU1RRRWt1eEJVUERqT1oyYnhIRHRk?=
 =?utf-8?B?MThRNFZqUU9wR2o0bVFjUU51MTNiN0lNZ2lWaGlUcmszVUoydHhMODhKMGxF?=
 =?utf-8?B?Y1lDWVRaRWR3c0JzdlpQUEZpWHlhaHMwMEpHbEJYWU5IWHJVOFBiUS9teVhL?=
 =?utf-8?B?U2NnazBFVTNLN2Q1d0tMZXM3N1IySzdHMUVKbXNWdXBjWmRLTTlNZjlQM25M?=
 =?utf-8?B?clJuaHpUaW9QS3dzdy9CeWtYc0JJcW43SjJCd3l4RDkvMVViMElWMEtzcDFT?=
 =?utf-8?B?RG93QUwyWm5uY1lLSXRXU2JLVFU3TWtsc29DSjN2TlFES1ZIbno0UTZnVTcw?=
 =?utf-8?B?TkhpdXBsZmhqc3h4dmJqTVhqVTBPSkFjbVdSbVJQY25qeTl4RDVEemI5WS9w?=
 =?utf-8?B?b25TYTNwajVQM09qSTd1dmJPYjdvVDF2S0JQRnZnZFJab0JyR3Y1SG5mQnVW?=
 =?utf-8?B?TVgvQ3VNaUh1V1NkNVRvaFVldk05aU5Xc2gyMjN2NTh3UUxlRkdkWnBoTDhV?=
 =?utf-8?B?aDdGV2l2YjZIWVlGWS9KaTdtY2tMSXhvWWVZOE0zOHVlODMrL0hsR1ErbGxT?=
 =?utf-8?B?bll4bXphTjBNQXlOTXZjWjkzOTdkdmhnbWpqZGE2T3NoVnlDK1lXWTZPMUZC?=
 =?utf-8?B?V0U5a2lDRnIzbndoczkxL3pVTkVaNW5hTEwyVU9USFYzZHJuN1JjNkRQeDR4?=
 =?utf-8?B?USt5cnJsaXg4UDNUQU1jL1Q3czI0eUorcmpUMkxBd2tuTjJYRUpmT01sR3Bm?=
 =?utf-8?B?QXNmZ09HbWZ0aU42UG9iYktlV3Zzbit6ekh1QUdscGMzV3h1eEpZcVBnWDZq?=
 =?utf-8?B?VnpBR0RLTUZER1pBdXFWSXFTUy9QSnc2bHlyYlBpTW1icWdBQmxyODA1YUJZ?=
 =?utf-8?B?cjVsR3hrOTFGUjdheUIxc3I5RVV2dEVQd1BLcHkvNS8yQ01HTlNjc0JLY0Fa?=
 =?utf-8?B?YytXSEUwOWNRV1lGRFV1ckdoaWVnU3UzYVdjSGV1YTRUeUdjNUthRDVvK0Ux?=
 =?utf-8?B?MXlBOTcrbEY5c05QZjdUMEZCSXVVYlRBajI1SVB2OXM1a3dhQW1CWitQb05L?=
 =?utf-8?B?N3RSZnl2U0UzSkczRWQ4bFh5aldLL041T2dQcUxLeWVRMllqK1ZaTUVzY0pD?=
 =?utf-8?B?a0dNcFVNRzBSY1NGZmtRNExNYUpSUkd5VWxhMXBxbTM2djR1M3RSQTVKV3U0?=
 =?utf-8?B?NUkwSDFvYWR4UjBIcllwM1RxTm1FaEZyaFJ6Rk5SNXVyUHBnREFxRzNZZEdP?=
 =?utf-8?B?VXBUbmxjeDNoeFZISXI1R2hYQzlIcnJmRFVQMVVDM09POVlESU5WTjROVFFj?=
 =?utf-8?B?a2tGVjRBdE1RK3BnU09uT0dJRXpBQ1dvOEhEVXJIdUgwZDJVVHFlOEtxdGNi?=
 =?utf-8?B?T3B2cUJ6a0NFV1JJNVA1WFkyUU5HSkpSRWhTcEFIRHpSbEl4S2w1eVFFdWJG?=
 =?utf-8?B?NUMyUzMxYjZJbkF1YlJnOTZ3YmU3b1RtaFlKc0tJYldVcVV5TWJ1OFhOaE1G?=
 =?utf-8?B?NHZkMTBOdXdjZXpLM1YxaVU1SVVEb2lNUFY3TmxzcHIwSG5yb2VtT01neGVW?=
 =?utf-8?B?bCtwalo1Lzg5bnMzb2FEd1Rjb3FaakEwbXVWTTVoNU5QRVhXc1RoRCtlSC9P?=
 =?utf-8?B?cnkvbkxzL2JSb2VTZU1oMUhYVDErZy94ZGZJbzcwbEdQQ1VhbXB3RnRYeE0w?=
 =?utf-8?B?R05EbFQvNHlLMEU3dDlzaW45MWl0UmdzZ016VDJocWNhV3EvVDFsOUFIdFBD?=
 =?utf-8?B?amdJYWM5cUJrMlF0cE1reFdkTTZ5WVp4ek5rTEFYa3BZNW1XZGg2c3dMdE93?=
 =?utf-8?B?aHdFYzNnelVzbHpDRXpTQ3ZmTm9ZaU9pL0JvNDdUZDlIZjVWVkx5SG5pMnhi?=
 =?utf-8?B?K3RyRG5zaFltSTNkdGkyWUR5clVuTnJQNDdPZ3VuVW1BcHBVUkd3L24yeE90?=
 =?utf-8?Q?bagVT/uyLo8wvb+o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6079CC1DB6F734EA9D6A4107BE994E5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MAmdhzPEV2LKzeKcSGq9SBGpe817OfHI8c/UPMCs8Ui02rKWNLpH6IMh7DHPHDKFEdrjQNvCgupPmYnHRUz68db5jFaq8r1NfbwIGceLDoqW1hCHk/4fzxXmVq8ixUtCw09dbsRHhS9i27LI3j37KzEcqbO7+GUIU2gROD5i+v3jW/sfeAJyjoOQgWvFUOj9jFGFipUtK5Pnz+VdkP5l27YtiAmUcwZfY6fIkC3sDgpQi+hYgTq7WT1AIOSym/yZI5WZAJiTSkZSEN2wL9Fum/hG+a5OwTRtDORMv/pdjsPtstyEQj+xtjX4erX+1df3wk2FOaL4dKAYJhsLFgDQyQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c8ec68-c9e1-465e-4949-08dec073b209
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 06:53:47.3892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cm9VY5oh/Nt2tSWwfLUlyBIRQpDKjCkqoO7MYve2O6nxYm1KwVoAzv2OaGgQH7Fr8aD2aHeH+MGxDejnA4j5jBPrs9bRXliPxD/II7LLX6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB10787
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

SGkgWmhlbnpob25nLAoKUmV2aWV3ZWQtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVu
dC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPgoKT24gV2VkLCAyMDI2LTA1LTI3IGF0IDAxOjQ2IC0w
NDAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToKPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8g
bm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNv
bWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
Cj4gCj4gCj4gUmVmYWN0b3IgdnRkX2Rldl9nZXRfcGVfZnJvbV9wYXNpZCgpIHRvIHRha2UgaW5k
aXZpZHVhbCBwYXJhbWV0ZXJzICAKPiAoSW50ZWxJT01NVVN0YXRlLCBQQ0lCdXMsIGRldmZuLCBw
YXNpZCkgaW5zdGVhZCBvZiBWVERBZGRyZXNzU3BhY2UuCj4gCj4gVGhpcyBtYWtlcyB0aGUgZnVu
Y3Rpb24gbW9yZSByZXVzYWJsZSBhbmQgcHJlcGFyZXMgaXQgZm9yIGV4cG9ydCB0byBiZSAgCj4g
dXNlZCBpbiB0aGUgYWNjZWxlcmF0aW9uIHBhdGguIFJlbW92ZSBpbmxpbmUgcXVhbGlmaWVyIGFz
IHRoZSBmdW5jdGlvbiAgCj4gd2lsbCBiZSBleHBvcnRlZCBpbiBhIHN1YnNlcXVlbnQgcGF0Y2gu
Cj4gCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzIGludGVuZGVkLgo+IAo+IFN1Z2dlc3RlZC1ieTog
WWkgTGl1IDxbeWkubC5saXVAaW50ZWwuY29tXShtYWlsdG86eWkubC5saXVAaW50ZWwuY29tKT4g
IAo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDxbemhlbnpob25nLmR1YW5AaW50ZWwu
Y29tXShtYWlsdG86emhlbnpob25nLmR1YW5AaW50ZWwuY29tKT4gIAo+IC0tLSAgCj4gwqBody9p
Mzg2L2ludGVsX2lvbW11LmMgfCAxNCArKysrKysrLS0tLS0tLSAgCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMgIAo+IGluZGV4IGNmMjc1
YjQ5NmUuLmFhMjcxODdlMDIgMTAwNjQ0ICAKPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMg
IAo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYyAgCj4gQEAgLTMxMTMsMTAgKzMxMTMsMTAg
QEAgc3RhdGljIGJvb2wgdnRkX3Byb2Nlc3NfcGlvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpz
LCAgCj4gwqDCoMKgwqAgcmV0dXJuIHRydWU7ICAKPiDCoH0KPiAKPiAtc3RhdGljIGlubGluZSBp
bnQgdnRkX2Rldl9nZXRfcGVfZnJvbV9wYXNpZChWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgIAo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWVERQQVNJREVudHJ5ICpwZSkgIAo+ICtz
dGF0aWMgaW50IHZ0ZF9kZXZfZ2V0X3BlX2Zyb21fcGFzaWQoSW50ZWxJT01NVVN0YXRlICpzLCBQ
Q0lCdXMgKmJ1cywgIAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDhfdCBkZXZmbiwgdWludDMyX3Qg
cGFzaWQsICAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZURFBBU0lERW50cnkgKnBlKSAgCj4gwqB7ICAK
PiAtwqDCoMKgIEludGVsSU9NTVVTdGF0ZSAqcyA9IHZ0ZF9hcy0+aW9tbXVfc3RhdGU7ICAKPiDC
oMKgwqDCoCBWVERDb250ZXh0RW50cnkgY2U7ICAKPiDCoMKgwqDCoCBpbnQgcmV0Owo+IAo+IEBA
IC0zMTI0LDEzICszMTI0LDEyIEBAIHN0YXRpYyBpbmxpbmUgaW50IHZ0ZF9kZXZfZ2V0X3BlX2Zy
b21fcGFzaWQoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMsICAKPiDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAtVlREX0ZSX1JUQUREUl9JTlZfVFRNOyAgCj4gwqDCoMKgwqAgfQo+IAo+IC3CoMKgwqAg
cmV0ID0gdnRkX2Rldl90b19jb250ZXh0X2VudHJ5KHMsIHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVz
KSwgdnRkX2FzLT5kZXZmbiwgIAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmY2UpOyAgCj4gK8KgwqDCoCByZXQg
PSB2dGRfZGV2X3RvX2NvbnRleHRfZW50cnkocywgcGNpX2J1c19udW0oYnVzKSwgZGV2Zm4sICZj
ZSk7ICAKPiDCoMKgwqDCoCBpZiAocmV0KSB7ICAKPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBy
ZXQ7ICAKPiDCoMKgwqDCoCB9Cj4gCj4gLcKgwqDCoCByZXR1cm4gdnRkX2NlX2dldF9wYXNpZF9l
bnRyeShzLCAmY2UsIHBlLCB2dGRfYXMtPnBhc2lkKTsgIAo+ICvCoMKgwqAgcmV0dXJuIHZ0ZF9j
ZV9nZXRfcGFzaWRfZW50cnkocywgJmNlLCBwZSwgcGFzaWQpOyAgCj4gwqB9Cj4gCj4gwqBzdGF0
aWMgaW50IHZ0ZF9wYXNpZF9lbnRyeV9jb21wYXJlKFZURFBBU0lERW50cnkgKnAxLCBWVERQQVNJ
REVudHJ5ICpwMikgIAo+IEBAIC0zMTUxLDcgKzMxNTAsOCBAQCBzdGF0aWMgdm9pZCB2dGRfcGFz
aWRfY2FjaGVfc3luY19sb2NrZWQoZ3BvaW50ZXIga2V5LCBncG9pbnRlciB2YWx1ZSwgIAo+IMKg
wqDCoMKgIGNvbnN0IGNoYXIgKmVycl9wcmVmaXggPSAiQXR0YWNoaW5nIHRvIEhXUFQgZmFpbGVk
OiAiOyAgCj4gwqDCoMKgwqAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7Cj4gCj4gLcKgwqDCoCBp
ZiAodnRkX2Rldl9nZXRfcGVfZnJvbV9wYXNpZCh2dGRfYXMsICZwZSkpIHsgIAo+ICvCoMKgwqAg
aWYgKHZ0ZF9kZXZfZ2V0X3BlX2Zyb21fcGFzaWQodnRkX2FzLT5pb21tdV9zdGF0ZSwgdnRkX2Fz
LT5idXMsICAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZ0ZF9hcy0+ZGV2Zm4sIHZ0ZF9hcy0+cGFzaWQsICZwZSkp
IHsgIAo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFwY19lbnRyeS0+dmFsaWQpIHsgIAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47ICAKPiDCoMKgwqDCoMKgwqDCoMKgIH0gIAo+IC0t
ICAKPiAyLjQ3LjMKPiAK

