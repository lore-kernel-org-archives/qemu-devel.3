Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5255BD132D3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7y8e-0007FK-3z; Mon, 04 Nov 2024 09:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t7y8c-0007FA-4O
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:33:02 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t7y8Z-0002b2-L0
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1730730779; x=1762266779;
 h=from:to:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=uX+zHX0bCvT8F3HZaYAaUbKlmI7ofChMiGB6dkhvp20=;
 b=cq3FUgTWw1oeww4RdLCjabBoowBFeywv9aF2D9M8pPL8+t1HX/6Prvhe
 EDLRvSHpcHbkQy8K3T3tipP0TrhegINxa/E7zu/v5ERgZZNV6qHc9K6qt
 PXA1oDc8rJCNFY3UgwuuSOPGl8+ALknrGBim7qAEekB9mJm2Jbk75lDjl
 YGTrA5Fnvrq+jYwRFlbiCL9GGtF55IIgoHFiAsLchxv8fZL/+32e2In2e
 o7sTMcISsxvGHbt9Dn0/GCbllP+bs8PpGJvr2GAYV2nQG7oaGNS71SYtN
 WAk3wq5zYeGznkc5sc245aWWvJIy0S+lR1aKGmEuxukV5EZhltakivxq9 w==;
X-IronPort-AV: E=Sophos;i="6.11,257,1725314400"; d="scan'208";a="24331148"
X-MGA-submission: =?us-ascii?q?MDFyv/ziYHcxZ0IqI9bhLgUTzYKABG4Kno0BF/?=
 =?us-ascii?q?gyitxsYVi14e3HSVVyOJa2vuB0ZHtV6PlSB60hrqVdou9d0x934b83yK?=
 =?us-ascii?q?ZPrE3SplullyPYKC+aq/XR3Ez/7adnpqy/rC+sJ90RHFmoXo+YgGQ3yY?=
 =?us-ascii?q?9GpjUJOWPfbghAgwmGa+wAIA=3D=3D?=
Received: from mail-vi1eur05lp2176.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.176])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 15:32:56 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGETCj6i/x8Q+1eQQwnn2F0ryiLl61RgynQLodkF4nkajgAyGuDVH/zPIIZ4A2PeKLnpO9YEOOgqyotaSn+IT13OALskbCmabuJpfjgg5hEgpuVCKqecyF6uv65k8jmAMEJCzlR/At+ScBHK5anYu62x2bUX54mVF0B+Dd0VI0SjD5H+WUn2I6yREZ8ks2+5Lu+swe19k0qCObv27JImSPa2Z7G1/08IgiSA/kU4w+gxAZ5RcYRKVm7n51yQhiIokgoQc0lfUWWrEHrajR+pKRWh0+Ko79CiOWQ3WbmwrLGaLfTydWmKo2shxUFCwdoj6zIV7s7FwwccTe1VOVaXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX+zHX0bCvT8F3HZaYAaUbKlmI7ofChMiGB6dkhvp20=;
 b=lgWbTuh1yuajgPw40MhCDLU6QqVdSZUYiJLDK8RTKWLgPwTNiXwMQAyOqjT18GQPv4nK3/KkrB0q8EwQlGImPFb6WdELOBie+mq4VPQGV7Zo/KOoAEPNhobyUWCU3TuzfuMaI4tkDzdWnklSSaREk2sDouKrXB38Jv+tCgvcu6eHELYBKgkn0Tj6mfrY5thPk7yoUIXbB1mfw4xDbxYRb+/VQj1nAs1FovOxfpOQFe3jQ5UbvaU0N2VbnYmQlcfLIrkYaX3RfLa8soFpbXwWD24BcS/wlUWyshBy3UiQhVgRKwQnqr8b4krgw2P7WIOG1FVKHBoBn5GRrgtmvSGbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX+zHX0bCvT8F3HZaYAaUbKlmI7ofChMiGB6dkhvp20=;
 b=acJ18t1Y0JzNOB/msPlOHCwxxrsR8Sk/MBwmmZzo/Y8IIGaPd3qExJmyWt/CVUCqmT7yYGaBDzSvUwq6rGwkrp/YDsgqkpQpHO5QRrVyxauKqxbV85fZy9E3ZBIdxr7KkhH/AZyMW420ToCUl/JbihL+b/Sl8UPqZxBpH7+UzGFW7VVLpAhsN7gG8/0VELFvOvJTZ2dQAIJrC3M3lz70iURkhdYVMgQ76cnc09Z/9gRVWrWH+26jGYl9AwESOER3C8KmcIjJhF5Nb7Pjt4ACxEVSTgVMB5pVdf6S3BRFQlwJJT8y7DUmQ/GlTR9ABkxBhZOQ/tq6xzroZhod7t1JzQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8134.eurprd07.prod.outlook.com (2603:10a6:20b:371::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 14:32:53 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 14:32:53 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: [QUESTION/ISSUE] edk2 missing dependency
Thread-Topic: [QUESTION/ISSUE] edk2 missing dependency
Thread-Index: AQHbLsZujRHwEP8RGU6OLDC/nytdJA==
Date: Mon, 4 Nov 2024 14:32:53 +0000
Message-ID: <d9aaedd4-80a7-40d1-b5ab-c75afda794e3@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8134:EE_
x-ms-office365-filtering-correlation-id: 0b054a4b-979b-4196-d9b0-08dcfcdd9153
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MkhSeDJXZkFKcTVIWW5zLzk0MzYzdml2NFg1TDB3Q3I1M0NuWXRkYTJRalVD?=
 =?utf-8?B?bXpRaUdHeHRIWUgyYXIxeWJMaS9rb200S1JpbCtRMzZOcm5yLy9RajV1aDhY?=
 =?utf-8?B?dUJjdXpCZUJESmo3ZEY0SHFWT3hKeEVXMWdPZk5DenNjV0lINXQ1V3RwVkRH?=
 =?utf-8?B?cGRTYlZzQVpGRkh1UzEzVnU2NFRvVkljQ2hoWTd4di9xcVZzdVZrcVdaRmVP?=
 =?utf-8?B?OXNTUElVbDU3b2xOTDYyWG1pUWhZRjUwVzV1eWZha0lrdDJOdzMrVFljaDhu?=
 =?utf-8?B?MWM2N2lkZlNPVEtGZDhVaUU0SnE1UEZwSS9lS0p1eFJ3VjMwdmpZYVJsbDI2?=
 =?utf-8?B?MFI2cGxadFB0cDN4MEUrck5kdDVKMlpGV1J5VXZRS0gzK2c5VEFtay8xbUU5?=
 =?utf-8?B?czRMb1MwK002cm85RG1nMU5tc0d6bFBhd3o4ZmV2czlYSUoxbkxpeE14MC9J?=
 =?utf-8?B?bmRsVFVZWGd1NTJxWG15YTQxTkk2K0ZTdnI5QmVIVUpRNFRobGprNFE3QjhZ?=
 =?utf-8?B?UHFxcDQ2MkF4V01uT0J6K05SejRobVVYOTZtTkZ2NHZQTkJ1Umx4cUYyNEJh?=
 =?utf-8?B?Tk9mRXd3ZmhZODRhL2lSRjZYV0ZLMW9MQThocncrVXR1L0d5a1J0TkY5aldH?=
 =?utf-8?B?MUs5by94K2M1enNrc0NQbTNqTUVvS1ZWOE1IN0xiaUpnVWdnNmt1b1dnQmJ6?=
 =?utf-8?B?RXVKaG02WU16b3lhb3BPZktqRGpLS1BOZjIrQ0J4UlZFbVZsemxOTTJGcU5T?=
 =?utf-8?B?NG16OXBVbGhuWC8rMy9ndlBmcFVyc3BGZ2V6UkFBcU9uQXgvK1dyUlRwL0dl?=
 =?utf-8?B?Z1RtdmRJdWxDb1ZwOXg4NllDWXFYelQ1Nml1bk5NZDlYTVozd0d2K21SOUZt?=
 =?utf-8?B?NDVlTnhMVWtaTzI4UzdYOUxpalljemczN3hlQzR1dE80dUdSb3FIMzJ0Wkpp?=
 =?utf-8?B?blBnbVpZb0NJYVR1Z1Z2ZEdCNjZ0RGlmK0hCbUNkcFd6dXRRM001ZGRUbEl3?=
 =?utf-8?B?SFl0Vis5bE1manpXb3k2b3dLbTR0VldkdXlmYjBPcUJKMjM4K01FcE8vR2Fx?=
 =?utf-8?B?NnNZWGk3OXYzd2RuaEk1ODdQenFXMXVTZzhSZ0VSYVR0aGtDeE9qZFdyTDVJ?=
 =?utf-8?B?VkxkNDJ6VVUzRXcrZjlvNWMxZEk4SmRXRCtUTDVDTHpHaEs5QU42Wk9kTDly?=
 =?utf-8?B?eDlOdHRuTGxPT0xkV2p4QXJHTEx4OFU4bGthUWhXNVRtcnQrUXhOTjBwc013?=
 =?utf-8?B?RVNHS2JHYWQ4RWd0SlN3TFg2bHAvMTZEVExWcC9QV0NNaVoyYnRhTjdObzVN?=
 =?utf-8?B?c3Zackh0ZWdQaFF3ak10NXVyMmF2cG5DdFByVzNwZzZhVW9Nejd0QVpBR1Z1?=
 =?utf-8?B?bTNiVS92eGxWamt5SDF6TExuMXNtSTl6Y0hPU1NGWUIrMVhTTDFxb0ljdm9G?=
 =?utf-8?B?bU9vOXBtTThFdXMvdTRHbmI4S2Ywd2c5M2ptZkxkeDdjZ3gxWi8yNHlveWZF?=
 =?utf-8?B?MVg3SE5FclMweC9MTythOWF2K09FOVUxZ0cwa2Vab29JdkxKZlRQU043M2dm?=
 =?utf-8?B?dDBQMGQ3R1lvWTNxZndQaXdQdVZhUGVFalpNYzZIK3Q0cG0zbVJjR01QL2RC?=
 =?utf-8?B?RmdMZ0lXWWViL3NaYnprd0c4RTRjOGhnMjFwdlUxT2ZmRm9kTTVqelBITVZL?=
 =?utf-8?B?blZkNlJPTEhOSlkzcnpFU1kzcTM3TTRMcWRINUpnUE5QNUFQM0RUNzBrODQ4?=
 =?utf-8?Q?YjpaUL1WSfT7eAwa4zTDVpj2dd8XOjmlx4Qvbop?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUl2NFdTMjJzSWwzUGZramx4OG1YaStmL3FqekdyYzVNclF5U2w1VXN2bWhw?=
 =?utf-8?B?ZzRURzYyY0kyWnF1UkRBNld0MDBzZ3NTeldNTldQQUwrbG1ocjd4aU90M0VV?=
 =?utf-8?B?QlJWcm5UZ0lGSXp5VFNmOGNjdVV6ZHRGVTRjQlNTYVZsWVBRMjNvZldtdkxz?=
 =?utf-8?B?ekNRYVBobVVjaDZac3prb1FzQWxlWWIxQXpCT1JoVFhhb0pPUE5HOHBwVHRC?=
 =?utf-8?B?amVYOGxoM2lXdUprRzRXbnYwTiswTUt2WWZ6aFZaUU5XYW1FSEZBMys0K2kv?=
 =?utf-8?B?V1VSd3FjSVQ5NitYSzNEb0tkT254NXIrdzhTTzY0SDF4WEJVdStXMHZ1Vm91?=
 =?utf-8?B?UUZRL3VIZkx3YXpuUG5ZYWgyYjlmU2FtNnpLelJaMzUxeWJWOEVPS1AzdXhz?=
 =?utf-8?B?OWxrbXVvOW1BaDFYLzVFTTZyTENZTHdaWDB5YkZiY1N2VlhiSzY1Z2pKRmxq?=
 =?utf-8?B?WmNLMUNPMHNMK3RaZ0thbTgxUHVTdU5Yd3JpOWlRZk93Vkl0UVRSUEhEd1hY?=
 =?utf-8?B?K3Y3VGRXYVVheTNZbW5RNGFTNUFjU3hpa3BJaW1IL2xmOHN0SytWYkdCV252?=
 =?utf-8?B?aDdCV216cmFraG1HSytvNG5rbFMrNm1nUHNTNm5nRnQrMEtaUGZ1ek9IcU5O?=
 =?utf-8?B?QjRCQ2Njb0FSSGc4ZDJvL05xL1JlemNiVUxOa0todE5zQXVISk5OMDNOektL?=
 =?utf-8?B?MCs3Yk9wbk1MUEMzaXJFMzBjM2hLWnBzM3BwZHhBV2lrV2NDVGxFWmhsTExt?=
 =?utf-8?B?UDBzYThydFJMOERlRUpuemZCSFF4M2g0Ukt4TGVEUExta2FhNjlZbDQ3T2o2?=
 =?utf-8?B?QzM4VHlRbHpZUkVuYVZjdWNpTmt5VHc2N0s4Z0RSVzZJblpSMTdOTXR2K0VG?=
 =?utf-8?B?eFpBcWp6MnJuelZMWThjMHUxUWdFZU9jVG43Q3NZSU1DOFZIWGh1Vjg3N3Vs?=
 =?utf-8?B?T3FjQW4waFFHeGUvNk9vaUY0bkRpOHBqR0t4aGVCalFRbFN6a1hhRW9mbWhL?=
 =?utf-8?B?NTIxN08zY09LdnE5SHRhb1dIMnU3WHBMbFBJRFdmZzFiQWdydW85T3pWRGlw?=
 =?utf-8?B?UFZ4R1lIQXFqNEZiUnJWV2lxQld0TktoMCttNUtzRnFmZHQwUkRCbTZoVE1t?=
 =?utf-8?B?ZGJYZk5HOENpbS9ETFdMOGZPbUYzMjZGM0JBa3JuWHg3ZktOSmlVdjRuNUZJ?=
 =?utf-8?B?UHZNdE55cHNSTlZmSnRSYjFFZTRNckZrNEI4cThuT1l0MDhOd25ycUFVaEpL?=
 =?utf-8?B?YUVCaStMOGpIR1F3bzE5NGZvRk9VNDFpSTNoRFc2M0lJK1k5S0loa0ZIdFMx?=
 =?utf-8?B?eHY5THo0eHRlaElabi9PNDNKZ1AxN29jOE1vMVRsNjFpWEs0SGdEaHRCa0ZH?=
 =?utf-8?B?d0JsbkpwV3JMSDBKT1hFc3JCOGVlK25TYk5LUkpDK28rc1Q1NjY2SzdWaTBW?=
 =?utf-8?B?NUsyV0oxR1FWL2lFaWlPTlh4YmtqZ2ptK2o0K2Q2NnF5MEN2RkhreWZmSTND?=
 =?utf-8?B?aUlIMGwxY0tDc3U4M3hoUG1kaWRaempJc1prc2F6aDhWdk0wUW12VFp2RW14?=
 =?utf-8?B?ZWV6ekQzemlrVm5idFNWMU13MlNiZDFsOGpOZjB0d0g4YlUraHBLNFVUNzA2?=
 =?utf-8?B?eGZqQ1pnenViaFBrUUZqZGcweUVaMkRESklKSVF5TUVjTlZ1TWtwMjUxT0R4?=
 =?utf-8?B?dmhCLzJnZ2dhY0FTaVZuWFNNQTNhWkpDL2VqNHFCWkN6WU9QMEF3ZVVybDRL?=
 =?utf-8?B?U2lybWxiaDJTMmRLVE9WUjZhVXJBcDQ0WHFyQlFvb1VYb05YU2xiM3BybFUx?=
 =?utf-8?B?WWFScmY3bGFCQmw4S1JMWXhKVW90NHFsZlhRQ3F0VSt1d2VBL0NQVHRDUVE5?=
 =?utf-8?B?ek5VQnp5eTVBeVc5bmFXWnZybXFPR0IrZDRsY2lrOUtKRE4xODNLUytCdWp6?=
 =?utf-8?B?QmJjU3pnOUdGWE5QbXhmTVVheUljR3pmTUF1Ly9WMXg2ZW5xRGVRZUdTUGgr?=
 =?utf-8?B?dVV4WGlTeHN4MnlKQUZOd08zSGJodk9PQXZqRGJXaTU5Y1ZuOGNkZ0RWUmta?=
 =?utf-8?B?REk5Vll0cHVPeWFqbS83ZkYydGI3VGl4VHhicVpabW05bGJXNzJDNGY0bk4z?=
 =?utf-8?B?ZU5Td3JhZE9ySThSZTA2by9hNDhFR3pwU256S1lMZ0wzSHVFc3pEcStjeCs1?=
 =?utf-8?Q?B/vxBTNAkolXZTTjdmZibJE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48A5628807A94448869913407D02A945@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b054a4b-979b-4196-d9b0-08dcfcdd9153
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 14:32:53.5359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uHHoOGc3k4OUstYTrSksqgYFwxe9V4TkVOE1d4TWtF61W1qbmLhyFXt5eZVTuk+0oPMksC4ymr9m2MGfxUhmyBwy4HcFzkHkCzLoYSP8ghDPrU82f/bdxzBDyFwINO+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8134
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

SGkgZXZlcnlvbmUsDQoNCkl0IHNlZW1zIHRoYXQgaHR0cHM6Ly9naXRodWIuY29tL1plZXgvc3Vi
aG9vayAoRURLMiBzdWJtb2R1bGUpIGlzIG5vdCANCmxvbmdlciBhdmFpbGFibGUgb24gZ2l0aHVi
ICh3aGljaCBtYWtlcyByZWN1cnNpdmUgcHVsbCBvZiBzdWJtb2R1bGVzIA0KZmFpbCBmb3IgYSBs
b3Qgb2YgcGVvcGxlKS4NCkRvIHlvdSB0aGluayB3ZSBzaG91bGQgZG8gc29tZXRoaW5nIG9uIG91
ciBzaWRlPw0KDQpUaGFua3MNCiA+Y21k

