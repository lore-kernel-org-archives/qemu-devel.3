Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3D8C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 18:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVZuT-0006HN-82; Sat, 28 Jun 2025 14:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuR-0006Gl-HG
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:15 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuP-0004Ao-PB
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1751133853; x=1782669853;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uLNATpJo3wI2AZl+ttK4URFw/JDTZnEljnnJ8NGwcck=;
 b=rcZ9loTdH+27iIFILJErWxhYPAw1eP6VqBrpQ+xZZ4Ituj+/OrUol6GD
 tyObblTBiDsMKwdDLP4oeb0H2/XMh3BIykaZ/PE/ANXDoM2ejP/D0HNb9
 onY6Rt5uYV0/DbXqvNd1uhdPeLlJoFoO3mr0uJ4ygcU9iQqomcd4NlDe7
 QoyFzZ0fL+7t+3xeih4vprjNbH8McbhbCqiH7Qft0IBfXlwdxBKgpM1w5
 eRUSwTyedGW5TE98VAZG9887AdXWEdQm5bN+tNrHk8rPEmjf2KcCTgLMY
 kYQ1IHH27ea0dYOrXB3ReCcewmL7vLFqjYZdaoFHPd1vyq5F4uGqk9fht w==;
X-CSE-ConnectionGUID: GSEaK/26QZqyXV0kB0oPAA==
X-CSE-MsgGUID: uU8yFrB5TTa7lPxB2SYn5g==
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; d="scan'208";a="39505877"
X-MGA-submission: =?us-ascii?q?MDGJ6s9GLr5mHES+3YGWAneOw24HarHRa/2IqO?=
 =?us-ascii?q?87+A4hTwBKZr5Y4M1iYmSTKeyQ17Wt5VurB1g7VqTjdYvAsc3qOibUe7?=
 =?us-ascii?q?y33T65McJCk83kv6aMhHm3+OG5069QO/7umCgKXPMhkpgiKLyU09jt2t?=
 =?us-ascii?q?R1A8tD+VlOgTO+5DeqB/tEMA=3D=3D?=
Received: from mail-francesouthazon11011034.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.34])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Jun 2025 20:04:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ctg5g9f6Ln4EK31lETM30a6kHW4u7Tjt/zWiSEAfKmy3vVDu45miNWpQPvw+Rb4KiLD/YljMfo9crzoboCL727YFYM0kw6PhPSoBtNY6L0Y8utV0egSjU/bJik4rBfqNw5ZWPM2MYxVikNL4JV6CPrvxth5K5qCivewfRJmzuFIsHmx9kx1+MsvcoBKBDv+04E1BDZSU1jNXBv8dKeIUe8nV2dIk3avBHTy3Zd0hugVHTP6HddJapHVEiocPaN9SyWZegC4vzwQvcMXJJvJXreEoU2tf/qFaZWQtYOamdMTZvhCH19n5tolZ5lZmvWdNSQt3lbGJR9RAM+DEkTBEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i78k45ie2trPK/Ql2PWOerpB+LfCnbM8Ht+wWBRX1BM=;
 b=cWESqv+9KzotIU3Ao1I7DEj+79f4ROLY6Sp6IEtJh3Gh8A3K3wTCchJ1pBb86wrskyqwLdDNRzHc2ULFuOEnD9uT1qnYvDBq5VyfdxQaxdffm6krnBSgQ0x+nn7TtK240vEbgdbOK1tFpiFPaw5wpzaRekE2BldMjLvNJvokkF0ueqQlMUwgthGJxuA2rAzGG0J99w1a8OQysC2UgERBk1ZuHbt2C5W3psk3TpPYhqan8q7w1jM+B1qlFXB1NB2p/ESDdI3PH7TzWlssMmfQIWn5nbXRoH+lMXPPJDVB/Pp8n25Ji0Zo2eHn1B20rwy+5OZ+vARcOme1JAEd/3H6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i78k45ie2trPK/Ql2PWOerpB+LfCnbM8Ht+wWBRX1BM=;
 b=UZOwL03gm7C3CupT2jwgJIPCULAwMtdzv50PuARC3A5ZDR5436cM4HW1fPba9YOI1/nJqVXxW656QpCkjMN+lzD9lFRORc5VQx6S4I+Fh9Fve9NLSfIFsWnjCJS8cDbJz0ccEo7HqBFFdXziyow2JqHNCuFcWGk2J2A+YlfkYK6PFbH6Yeksf84lMGbVs1b6w0rF5zJEYPOAAp8ZgT5IEGXt6nXOyIp1xsna/d7UYChJh6u+eOnG4xvg1HUpZac/qxap62ZvnLZkDByUmXXKG/lL+gPmq3BY2PJ290TwodyfkMWdz32ZxGxl9m1GGhOhsxkFpXEk7MSX1nlSYSOcPQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB5PR07MB10238.eurprd07.prod.outlook.com (2603:10a6:10:5e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 28 Jun
 2025 18:04:10 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 18:04:09 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>, "minwoo.im@samsung.com"
 <minwoo.im@samsung.com>, Ethan MILON <ethan.milon@eviden.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 09/10] intel_iommu: Set address mask when a translation fails
 and adjust W permission
Thread-Topic: [PATCH 09/10] intel_iommu: Set address mask when a translation
 fails and adjust W permission
Thread-Index: AQHb6FcLxpyJwTTRGka23lqLSRy2aw==
Date: Sat, 28 Jun 2025 18:04:09 +0000
Message-ID: <20250628180226.133285-10-clement.mathieu--drif@eviden.com>
References: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB5PR07MB10238:EE_
x-ms-office365-filtering-correlation-id: 23be3b7b-1cd1-4a85-8c8c-08ddb66e2e7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Rghii7PPwU5/CHombSQKQ7HhgN01eoYRjScdWO9U/9WlqMWbfPOvDS5fo7?=
 =?iso-8859-1?Q?d7pP2y0dcQ98WDlBCRRxAhEbjjG9NPWEIWGY9uwmbGBoCSGZBlShM3/ZeE?=
 =?iso-8859-1?Q?ldogCAbUO1kzRYunkdia6zsGrl0e/t7I3Xbvuh57zgeMLoSKorQJs3sG2Z?=
 =?iso-8859-1?Q?AGf5EoAe5TJmQzkBKvniUTYJAzdqy6yzzCfukBVFJZBqhfssS77er5+Q30?=
 =?iso-8859-1?Q?6jdrs/HPC9FqDiyzTL6vtogVFUolkKxgu+C2UasPur/KynxsbBGVBCV0tm?=
 =?iso-8859-1?Q?t96kq26bb5oYot7VQS3OEOmrAvUbVgwy0txyk9wqrmriTGY5wOp/jRdM1d?=
 =?iso-8859-1?Q?5xRZsG8I/gjcojp5SaNnZH0mvoc6SpyHgktWftSqQp/By5bgfJ3VLTBM1O?=
 =?iso-8859-1?Q?/qNLLOfKwEjMAIXZ4qrm4qFLK21m3dR5YynbM4S8AUtbcTj+ytG2e+Sfnu?=
 =?iso-8859-1?Q?wi0w90U8n8mQ/Tijvgkvc+jcV7j2AaYfS4NwdDMKBmbgUHpnUa2TVt0WEP?=
 =?iso-8859-1?Q?jZ1ZJqqcgWwlUTMHK9PK1qjkFF+pQnB/GnR1RzgAgKcme0IXIzuEJlsqcN?=
 =?iso-8859-1?Q?yMMBc2ec2jzuKql4ud3ntHW1eq6p7X+/qHgLAeqnV2doGFrJyz/HvEllr/?=
 =?iso-8859-1?Q?w7ii4qX89kgd6UKUP9hAGmB8M79Hn9lfIz0NnwOPyXQ25gbuwqNPU9WpD4?=
 =?iso-8859-1?Q?mWQc2gnot7JJmqrkIORQ5etEyJJaM3WbSozNoO476iW0fllh65hzdTF8gG?=
 =?iso-8859-1?Q?/vHcz+6XAIds3TkpYmYL3hWlG58AkllCyOqNd6iYHwcisa+8lNZRv0wziG?=
 =?iso-8859-1?Q?sCLy+aM4fVnE2gts9wub/k/Q1YzQd/cV3jx/OBNOjR2nMqTpK2GH0/FvPp?=
 =?iso-8859-1?Q?lJ3/bXV7jxvYC0JTTbks+TfGwSj+dCnAlKxMPkAW30nranbqcRTq/771kb?=
 =?iso-8859-1?Q?DR6cJsSq7PLsBLPowJuSPEEkTd70CMO0QM8bVyYYYGINttZQiCaqfL0CZF?=
 =?iso-8859-1?Q?xH0W6VIPJsIuxYapl5zYsBHhB//smJMXxkIRfT5Dj4xBHl3wGp15vRNuc4?=
 =?iso-8859-1?Q?TCKEjzeTST+azDfBF4lQiXWZA+4IKEsfzGYs7npqg/YLqo+VYSrNCJrLfh?=
 =?iso-8859-1?Q?5j8RBH4HISzQcTuIz9AWd4C6wjoh0OVzm9WOYIbX91T0w8VFH2/3noEtyH?=
 =?iso-8859-1?Q?g9u9DNfxWJZWLDlzkSZmVZeg2C8nkxSfyWuiSpdr1A8MO5qPZvsNwUJwY9?=
 =?iso-8859-1?Q?SsHHSC5iz991G8PUnpKxk7vFIxaE89frvUp6EBaciJhVxvq2DXRi5B4vwp?=
 =?iso-8859-1?Q?N+Velxohzc51ThRP30asfqYE2925wGTDairpmT3Z1Bfsco9b+8TWuk4Km7?=
 =?iso-8859-1?Q?vF5ELZFwq/AITl1BUCqXdt9yAaO4DbUq93EZdDTEKnF3aR5hDBFkXRWcf5?=
 =?iso-8859-1?Q?4h/h0/7axH4dQR7JjLMujwMz9rQ3rijNkpfcZ5E7N5LdZSz4FYUdm43iWr?=
 =?iso-8859-1?Q?2zhW+y48GnAYtdDNxV1wLwQFSRdqhGaYG7rMGXysovHg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N1co6jh40FA/k76wDJLfSeyUKNFpkqasAcv3lWJkBDbNDiGrmjlaehNmGT?=
 =?iso-8859-1?Q?+Tg+AIMAG7gy/fNgIMhAbGAWIeyh7Z6KTe4feKtcGPocMC8RbZ7zQmetrz?=
 =?iso-8859-1?Q?Eu8XOZsCRmTGLgHOIBQl6kAawNaHND0iqFO4eWpZ7GwJNe5O52SQ2lzv27?=
 =?iso-8859-1?Q?x6eogQ44ZVyl0WzuTCwWcBVq4Avq7DRI852KFIXQbgUyQOjz+Vwan/n1Aw?=
 =?iso-8859-1?Q?IuJ/dDmIU9lPdm0hTFI3aL/ldnaCsRuKDz555qigQB4ZVsq64lhBlM2Wdd?=
 =?iso-8859-1?Q?nGoAoPFevH72aDvdhsf+LvgBy2GqHvfqyVwox/hglZySE/DnFJe0hW0e93?=
 =?iso-8859-1?Q?v+VPgN6oLFjPQLGgR2ZDEecSwPiZVvajL5Y828WD1GJldERm6fPflnuN2B?=
 =?iso-8859-1?Q?7EElO2uhRjl22ELXKo/Rbk9NnRBfNUWLh9M7hh2uNE5FcRtZSSVmK4Dgoy?=
 =?iso-8859-1?Q?FYOr/8OrjOg3ZpY+uSqB9EGiz4kUm9U9cnPePaZsxEssxtnN2YToDoFJPR?=
 =?iso-8859-1?Q?9jMlodvzUnE2Fb53YHiLAO3mUnyZToPmseXlM4cHUU5/3mA4kAiVtSrlBl?=
 =?iso-8859-1?Q?EM6la5nPt4QwEUzV04+DzMCnzBXVV2Jy6V7+YuZnr3MFGzEj1Aqn7sVS36?=
 =?iso-8859-1?Q?AufprNlTvTD7Z79bGYjGPX37uRAwaUuWM+4gIzUQoCbipZfH6PcXX3QLhj?=
 =?iso-8859-1?Q?4s/NA0bqSHLAyrhmsTtY1mvTiwbG+LHZpwZAIZsvMTEJwHcg/6PBSJmBIF?=
 =?iso-8859-1?Q?c+dnZ4MpQNSydLo9StS3miTS+gpTFX/d3dFuDNeugNkHiTfLGrc5wY1FqE?=
 =?iso-8859-1?Q?0i7iAJ8/emlLCRvDGcqFPy8xx9PW8FvE/v5mgvhA/X/B3bUiiYTx7pSzRW?=
 =?iso-8859-1?Q?cKWBxabHJbDouVauCDZrA9oPYQvPPiQ5F0IE75eFFwK4QrLNv87t6e6/N9?=
 =?iso-8859-1?Q?HzZvTzl3kRbKRxWgI0iTl55S4PIwL4ZtdobmA0Jz8m3dkAjweTMpWQgSrR?=
 =?iso-8859-1?Q?OxsIrmEAupkAep927EvngUpLwTXIUu9I+8sWDrujoQ9TJpyRWTlOaL3wsr?=
 =?iso-8859-1?Q?BPUItoVUiduSF7ok4gMKfnbWHTsZPJOOMX+t4cb5qVKFRz1AT7ntTASwPF?=
 =?iso-8859-1?Q?sVixr7ikHy/PZZkE7mNT0nYA8uo9E+KOguPRuRdOOfXibpbNVzbArT+7Bj?=
 =?iso-8859-1?Q?OlajFKNB4OQnwAwhpJ+2Gzoiaguqbjjff/JLMlqgH4jBQ5HUoPZt9wT2ez?=
 =?iso-8859-1?Q?rpxiWq+KmVxd+faQmdu+05oujG0i0lXbggxG1KGjyhFxGXEBngQN6qau80?=
 =?iso-8859-1?Q?ZrF9ijGAyhQrzhNdcRj/K3OkN5ML7noE8F9ZnvnXUGu87BE7P3QliUCi1K?=
 =?iso-8859-1?Q?ND4/MYdh9JAKmo+ulqgtCn7w8lempA75d3lKVSxu52lcIg+RUlOEWFRGXW?=
 =?iso-8859-1?Q?/B++CMLlgdzFVUYe1WQ6TXdeueHGU8iB+qejduY6KV+tIA3K8IpC8iVn8c?=
 =?iso-8859-1?Q?q64fTeMpke7qK0tDfYAZltMYNryCVJnhHyrojOhlCYQfR7nVFq8YNA8PH+?=
 =?iso-8859-1?Q?7z46e8+Usya8SPzkJKxvdMQl2ms7os+lxhxzOSx7J23Ujspfs74hKWEFuM?=
 =?iso-8859-1?Q?cQF5jXylBZPpCas4vhr35jwTCGrc6Z2Cb0x2lDO2MegU9bjcNjzUGuCfLG?=
 =?iso-8859-1?Q?EMwHzgmTEhxkCot56kY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23be3b7b-1cd1-4a85-8c8c-08ddb66e2e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 18:04:09.8565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ik0qx7E+76Ss8Z7BXbPR61R+OwUeG8qXdUmlSAp7c/+TqXw3FXJV3ExvPDQ5kMZhqqANTSWbQbaGJkhjQMsdWWFZA3FWA8Er5pd+70h9fGVZLznoXUF3o4g5ohAq+UUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB10238
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implements the behavior defined in section 10.2.3.5 of PCIe spec rev 5.
This is needed by devices that support ATS.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bff307b9bc..1b1b0b5632 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2091,7 +2091,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *v=
td_as, PCIBus *bus,
     uint8_t bus_num =3D pci_bus_num(bus);
     VTDContextCacheEntry *cc_entry;
     uint64_t pte, page_mask;
-    uint32_t level, pasid =3D vtd_as->pasid;
+    uint32_t level =3D UINT32_MAX;
+    uint32_t pasid =3D vtd_as->pasid;
     uint16_t source_id =3D PCI_BUILD_BDF(bus_num, devfn);
     int ret_fr;
     bool is_fpd_set =3D false;
@@ -2250,14 +2251,19 @@ out:
     entry->iova =3D addr & page_mask;
     entry->translated_addr =3D vtd_get_pte_addr(pte, s->aw_bits) & page_ma=
sk;
     entry->addr_mask =3D ~page_mask;
-    entry->perm =3D access_flags;
+    entry->perm =3D (is_write ? access_flags : (access_flags & (~IOMMU_WO)=
));
     return true;
=20
 error:
     vtd_iommu_unlock(s);
     entry->iova =3D 0;
     entry->translated_addr =3D 0;
-    entry->addr_mask =3D 0;
+    /*
+     * Set the mask for ATS (the range must be present even when the
+     * translation fails : PCIe rev 5 10.2.3.5)
+     */
+    entry->addr_mask =3D (level !=3D UINT32_MAX) ?
+                       (~vtd_pt_level_page_mask(level)) : (~VTD_PAGE_MASK_=
4K);
     entry->perm =3D IOMMU_NONE;
     return false;
 }
--=20
2.49.0

