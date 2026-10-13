Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7229CCC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGdU1-0007aS-Sx; Tue, 13 Oct 2026 10:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xGdTr-0007Zs-PP; Tue, 13 Oct 2026 10:27:52 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xGdTn-0003Od-I4; Tue, 13 Oct 2026 10:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1791901668; x=1823437668;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tkghRx17baCStnFnUvnP8Ba0U/eyuYtyMeYT56hVnmk=;
 b=ijcM4cuWtDqc8k+d6L6NouudKm7qrtnGH9t+uB8t+8I6xMVaDe9pAPyp
 XTvStIaNmEJgobaBV/aUa/9Tz00zqKf/i+kpIDhY08wLy/y4DqME/WmbJ
 xMmjDrWQe8rlmBF1/z7wmGx32P42JqUGRKzQIeVL0GGABSIha4GGUUnAW
 izaqRJbmwZYAuo/br6HLBK5q3KQ8LaUtRiLPLJUXgZEao0d15br651wZH
 wPasOaVG0An2NCy4VmVNuGadjueBsGRw2I4ZCorSvBQiM6bzPQxhnH9Fa
 Y08kPfgJ5nL7iKHDHsaxnxJ0nIZmZblXVnctDnzzR3NsGK9lvO8iDur/T Q==;
X-CSE-ConnectionGUID: rZ0vmO1zTGqhT4JXYmJQlA==
X-CSE-MsgGUID: obtadmPQR0OQOkniS5+ayQ==
IronPort-SDR: 6ace3fdf_jHVTbcwv5gM5LY9s7acB+kwTPEcP/5aUYyloc+1Qlh/plPa
 p4e4IwV6sErVzLfRROeQqUrSRu7s0NjwqNtR8cA==
X-IronPort-AV: E=Sophos;i="6.27,155,1787004000"; d="scan'208";a="48942465"
X-MGA-submission: =?us-ascii?q?MDH+DOL8qU9CYHU7OOgSJ2ttAb1w0hUMFFcloB?=
 =?us-ascii?q?RsxF57LtieXT7b6JW2vbHR4YdwePhvyNErAc4ubBOm69ZOiK9NqVfc+G?=
 =?us-ascii?q?p+LALbS7B4u2U6tw4SiJpjH6pvml6RwQ5Quf4B83EaACq7MepRQivUZH?=
 =?us-ascii?q?14TxXFcd0JptVVAEyMRrjWBg=3D=3D?=
Received: from mail-westeuropeazon11011061.outbound.protection.outlook.com
 (HELO AS8PR04CU009.outbound.protection.outlook.com) ([52.101.70.61])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 13 Oct 2026 16:27:41 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQ4+Z/dUywNf+g6rc1vnUqkQzPtNZbl+CZkA4P7WVFYjKoGPVtGQqtWybWS+meoSAeDo/J2sJcN7kJm/KceBETiJmZlXQ4EF6nCPCT9Ui6VHzmr8atNQo5FK4RSwjFpwgNS+fI+2PGW8KBfUnjqE7HvGGihFrNr9a2+lXzUiXYAhnmpn7kQqC60Mb9PcSRMqjAhlwgQE23OQervdgnQbowp0hZ7HaikzWml94gVN/0i3DlrIuHUlS//VRNAgUxvrl/hG/MEYo0cwSKXrAMSp258T3IqLBSGN9saI1n7M0/JezxbuBctZ6RuolArwog3xBqpkCyYnQe1p3zYqz2JQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkghRx17baCStnFnUvnP8Ba0U/eyuYtyMeYT56hVnmk=;
 b=fQYqAttDVlPqMTWndfvTz86PASu9Ny7HZs4+PzNg4zPyPDFnS6PHnzS78hxemKvCsg3iXBbJ2ledI3BmV9CEtTsa/6mwMMcqvylqQDwz1OGLLgfFH+FEgSzp4g50BzW4gIFO6d/pLytYmImhof1HAlIqEKPksWTqyLuRX8KzSkSghDJwV+nvNUJT6Ohp4fHgPSghMsqtdeHaz41UL0zhRP24PrXcsxFSOT6gJVRm+KfdOMUk7jAmLqolSitx30P2TFeUr07jVVr9cZEl8VYyjiWNhrqs5uPqETKLJOUZg3KwvtI5yiH9almis89L0eUjrZ95f0M4sI9XzEvpF3MLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB9592.eurprd07.prod.outlook.com (2603:10a6:10:310::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 13 Oct
 2026 14:27:27 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 14:27:25 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "artem_mygaiev@epam.com"
 <artem_mygaiev@epam.com>, "volodymyr_babchuk@epam.com"
 <volodymyr_babchuk@epam.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "francisco.iglesias@amd.com"
 <francisco.iglesias@amd.com>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "eugene@nuvacore.ai" <eugene@nuvacore.ai>, "Ruslan_Ruslichenko@epam.com"
 <Ruslan_Ruslichenko@epam.com>, "takahiro.nakata.wr@renesas.com"
 <takahiro.nakata.wr@renesas.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Xu <peterx@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@oss.qualcomm.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH v2 12/20] system/physmem: Add ats_do_translate helper
Thread-Topic: [PATCH v2 12/20] system/physmem: Add ats_do_translate helper
Thread-Index: AQHdWx731X0JMc9Ev0+s73m4HQw/Yw==
Date: Tue, 13 Oct 2026 14:27:25 +0000
Message-ID: <07181e2fc148dce3c2152f450e9337b4b9a21f16.camel@bull.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
 <20260915160044.345788-13-ruslichenko.r@gmail.com>
In-Reply-To: <20260915160044.345788-13-ruslichenko.r@gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB9592:EE_
x-ms-office365-filtering-correlation-id: 679d8baf-75a9-4b7a-91ab-08df29361a06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|10063799003|261009221227099003|10067099003|22082099003|18002099003|38070700021|4143699003|56012099006|261009223027099003|11063799006;
x-microsoft-antispam-message-info: T6d2zxLWXWIsUT+U+cRRHIMbRbnuAQsYTeNaJhlGS8HjB7Pi0UQzL1jtnKfUbrvLnZa8hnJ5hGNGjaGKx8QasUCM6+8/cxQfU81ouWydCG54yoGjJ5EzjMbduWsHvsnHYUVXYo2NjK2XWHPrIA9hjYPJ3uSrZdIGYNu9Au40YOqdgKn7T16b7LMGa3FfqHcgmo1dtyVp8IdcTtG22qnW7BSR87cPuPqnbrd2/QXct7y6j2XoJ3hfQCQuhz5Zr3QV/3Kp2Qt7ZYBnVkDsQkhahnSdok4VMLKzwZ2x6bh6aaO+Yph2QovsJEje5B1Pd3MXz56968MMPrsRmbrjUNGEFcCwzbjXBdnbAl1AJ+vYx1CjDae/GjOyWE3bLJpEKt/Yn3asxDHQ4hAS11o9zeaK0RkbHYqffBfou10m7fTFlx5iqRVHMmTmsr5w+fD2G/yeaICo9W10BSF00fvibpYKQvap6N67H9r2udcJVJk1UiJir/x+HcAlrGyEHseJILNRQ1ri4pFNRbRTzs8DyiskdO50AE9eaN6qKbBhcXlTl7BWRRa+lDigHMIjdzVxHdFL6/T0lAXOh3DsF5DLzrHH4WJt+zqoxUZsh2P46lvYnfQ8gEZrIPr/3Mr6PssaN9T2rBLMGI9/4YCRsFiYyzm1HYyKQCuvc+r2gDIO2z2Jql5evLEyT9fMf7Yi8nR9DIZIPaGB8Se0nh5zypSIXOn1hSnLXr62pE5zLJO6ewVKWKM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10063799003)(261009221227099003)(10067099003)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(261009223027099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXJFZk9MOUdBRXpVYXRxTjlLeUVMNUpXTVNCaW5hdWVoOGlxM1g3cTgyTmFL?=
 =?utf-8?B?Q3dtM0lWODU1Q1ZSTEw1M2NVRVNJQWNPazlVanVteW9lSlpnWmJBbkNaOFlR?=
 =?utf-8?B?amI4amZDYkpQZVRUKzJWQ2c2eDlBWjQwTTk4dk5YeW9uT2tmM0hlaC9mMHFp?=
 =?utf-8?B?SDRjY1RQSnI1Zm9QT3Z2Qk95NENJVzFndHdRQjdKbnhmYmYrblRKcWpHYWha?=
 =?utf-8?B?MmdCQjJoMC9MbnNGMlNweUYrdEpYbER6WEkrZXpqS0dWWUhtUk1qQUh4dEhN?=
 =?utf-8?B?NWZjUVNOTlNyYzBNT2F6TkxkaHNzdmI3Z1E3OWNybVErUDgvRXZPd1ladVli?=
 =?utf-8?B?TU9tQndidGs2c1gxNHZWNldrOE5sOG8yL0ZBKy9PZzdvc0YxeFp1WjhkUUtE?=
 =?utf-8?B?SEkwTkxEb2FLamh6WG5YTnV4SnNrM2VMNUVjbXBuNGZKYVBYU1hSVEh5QTJK?=
 =?utf-8?B?UWRQZlNMMFJ0MUVqbk4zOTNVRzBaYnZXS2NTdTN4YU5uS3N2R0QzVk9Xemda?=
 =?utf-8?B?T2xqVGVhUlRESlVncUVvbEc0SG5IazQyQ3BSY1NpTTZSRnp1ek9KYm5IQ2Vr?=
 =?utf-8?B?bFV3SmVZRlJJMTBkNnRPdE94NjVaUlJ1enp3NjlCNFlqL21UOEY2ZytPaWFN?=
 =?utf-8?B?ZS95NlJwR1RQblhrSWdqa0xOVEgvSWQ5Ry9pVmFWSi80TVBHNUNNeWNHRnlj?=
 =?utf-8?B?WUUwa0JNTGROWGxtamxOeHVNOXd0RUczRmtIVFdwNUNzZmRBMmQxV0psUzd6?=
 =?utf-8?B?WkY4TFhTZjlRQlVIMGk0TFRSam1HQ0M3dSs4cUF6Vm1uNHhjRmpCeWtDZ0VX?=
 =?utf-8?B?MG5DMXpuSnhSYTNXRVRyL2JJZ0tCSGVLMDFSbjJRR3JrMXMvYjEzWXBzdFpE?=
 =?utf-8?B?cHhNekJuVGsvYjk1cG9UR28veHhPR3gxbFE2cEdKWVpYcXNTOTdzSUZPRE5n?=
 =?utf-8?B?ZjlPSjBXcUkzVElNa1NHZmJrV0phbDhBdXFpRHh6WEVPRmlaWlQyS0FIQkp6?=
 =?utf-8?B?SDJLcXdieUdNeWpneFpkTGlVUjE4WWJhUm9LUzhtKzZPSFJsNElXSGVlN0h5?=
 =?utf-8?B?WXdtanZrR3FjeWhhRnpaczJoeVkzT3Y0czFWbUVTZ1FKSjNOKzJzTmxEMUp0?=
 =?utf-8?B?ZjFvblhXZThnajRtTHNNa3M0RWMyZlloKzdTYXRGRDI2NkQ5cTg3ejdXdjJM?=
 =?utf-8?B?YVdOY3F6WVQ3T2lFMXV0TWVVRlE3QmNFNjI2QzZvMjIvQlFOakJERnZuN3VG?=
 =?utf-8?B?ZkJpajd4OWpXZlJGQVMxNjYrVzcxY1dXd211Sm5SWnF6YkRMc2h3dm9BMXFz?=
 =?utf-8?B?ZHYrd0tZMHg5SCtaMUVqM3lpNHRYNmZoUDUwRWFIdnRiMG1CbmJVNVNGTDFw?=
 =?utf-8?B?UmR4cGN3ZWJudEV1VU14U1pja01hU2szWGlnMWc3TStMRGZDZS9LMXZHZU16?=
 =?utf-8?B?R01ZelZTZ2JvRDh0ajZGcHJ5MFFVUGNvRzVOL3VPZWM1U0dPa0hqWDdXdUdG?=
 =?utf-8?B?S2JDMkc1cUpWTXpPZStyQzBxUmZUZ25lYUoyY0h5SHp0TmE1REk3eUlkYnBV?=
 =?utf-8?B?ZzVpTTdobkUrR3YxcU5FTkZvT0xWa0pySUtXZUI3di9PUkY4Z2dacm14SjY3?=
 =?utf-8?B?L24yQmdIVzd4Zk16TEZnKzZsYi9RbVlSUjdkc1Z2UXE2STB6dFpFV01nS3dp?=
 =?utf-8?B?c29zOGdodmxNSUJOSzQ4emprR3NKTmJraVJnSnJLVkx4MWdMY1hWYkovUlQx?=
 =?utf-8?B?NlJ1eE5vb2lMODluWFIydXozTDQzeVRPMGZIK0syYnI4WnEyRmZiLytDM0VG?=
 =?utf-8?B?M2ZUdVBoYVlMbktRMFI0QVBjbm5tK2lGa1N3VElsOG1vajZ5U0h0enpJOXlE?=
 =?utf-8?B?bnVsVjcxQXEvT0lkcEl2U0JnOEh1emd1ZjB3dzAwOEduV3VCNWJ0dWlXeVRq?=
 =?utf-8?B?SXhsMFZsV1NDOENYeFk0RFN2M0VBZVYzUlovSzNaU1FRV1dkdS9LcFV6M29D?=
 =?utf-8?B?VGgwTkFrTlloVGY3L3ByNWc5Q2NwTXYxTE5rNHNad0czODdSVFBLNC9FbEI5?=
 =?utf-8?B?SUNhYy9VMVV6NGZIK1UzNldIbFVjUTRZdm1rbjk5ZEZGK3I0Y20ybUk1dU5k?=
 =?utf-8?B?aWxLOEZQZysrdVB2OTRFdGdvSGZLQjZjV3NZQTN4NytBODBSL01nblJ4ZmNB?=
 =?utf-8?B?OTFJck5xR01PZXdNckhvRTEzODJlT0gwU2RIV3dBV2trcDNDVGZZazN0VkE5?=
 =?utf-8?B?OXJ5K01sRVdpdXc3OXE2WXRNNXJKL3RxcDZRK1lwMDRMazk2WjBxdnZ4azN5?=
 =?utf-8?B?Y3FwcERMVWNlQzBQamFiNW1Kd2JkN214bVFISjI2bFgzQjAyNTBwNHpTWDJ1?=
 =?utf-8?Q?wdG3vMELluXo2g4e/vT8ckrxMnhthnE6VJguS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06C5FF69DDEBF84DB726650A6DBCFC16@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dTf37ludgfheHXjjC/NmBtvEdCiqTdNpKLQFqs2JFp/Az9Ay4EPzWi1VnlO17Vt1CxFqsoZw/LFHbBwJ2jlfTTCqqUt1C4zsYcls6zX1ewInfGa6aKj9L++9OUjirV9Tz68AY6Cd3JIPDUFKA5Fcjw6b/7Xi5LN8YIEyh+/zqq6MVwQ/8yLK1z+TEteTQG/fKLtxQHMww16n80MoCZxgxhhr0AK90e/wdbJdJSiDJKPWyFMb9CUzmH5qpqzN8D5x9Dn6L/P1DjXtebV/aIQjcc+UEzfTrzC6vL+UDRADi751nrn4hzd6z08o5Fj0pDNz6zNXHjX3rehjNrqDRaMKsQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679d8baf-75a9-4b7a-91ab-08df29361a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 14:27:25.1020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzqFH/FfEw3EopN4GwLMcbYFDXFhvTDBsdfY+jQ9OoLtMAHM+npNIgfUQCwDTIqChh4z/GkiSnNW5FPvCouS/0fjacXlidZCChKB0hQcNRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9592
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

RG8geW91IG5lZWQgdG8gb3BlcmF0ZSBhdCBwaHlzbWVtIGxldmVsPyAgCldlIGhhdmUgYW4gQVBJ
IGZvciBQQ0kgZGV2aWNlIGZvciBBVFMgYW5kIFBSSSAoc2VlIHBjaV9hdHNfcmVxdWVzdF90cmFu
c2xhdGlvbiBhbmQgcGNpX3ByaV91bnJlZ2lzdGVyX25vdGlmaWVyKQoKT24gVHVlLCAyMDI2LTA5
LTE1IGF0IDE4OjAwICswMjAwLCBSdXNsYW4gUnVzbGljaGVua28gd3JvdGU6Cj4gRnJvbTogUnVz
bGFuIFJ1c2xpY2hlbmtvIDxbUnVzbGFuX1J1c2xpY2hlbmtvQGVwYW0uY29tXShtYWlsdG86UnVz
bGFuX1J1c2xpY2hlbmtvQGVwYW0uY29tKT4KPiAKPiBBZGQgJ2F0c19kb190cmFuc2xhdGUnIG1l
dGhvZCB0byBlbmFibGUgbWFudWFsIElPTU1VIGFkZHJlc3MgIAo+IHRyYW5zbGF0aW9uLgo+IAo+
IFRoaXMgYWxsb3dzIHRoZSBSZW1vdGUgUG9ydCBzdWJzeXN0ZW0gdG8gcmVzb2x2ZSBndWVzdCB2
aXJ0dWFsICAKPiBhZGRyZXNzZXMgdG8gcGh5c2ljYWwgYWRkcmVzc2VzIGJ5IHF1ZXJ5aW5nIHRo
ZSBRRU1VIElPTU1VICAKPiB0cmFuc2xhdGlvbiBwaXBlbGluZS4gVGhpcyBpcyByZXF1aXJlZCBm
b3IgdGhlIFJlbW90ZSBQb3J0ICAKPiBzdWJzeXN0ZW0gdG8gc3VwcG9ydCB0cmFuc2xhdGlvbsKg
IHJlcXVlc3RzIGZyb20gZXh0ZXJuYWwgbWFzdGVycyAgCj4gaW4gYSBjby1zaW11bGF0aW9uIGVu
dmlyb25tZW50Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEVkZ2FyIEUuIElnbGVzaWFzIDxbZWRnYXIu
aWdsZXNpYXNAYW1kLmNvbV0obWFpbHRvOmVkZ2FyLmlnbGVzaWFzQGFtZC5jb20pPiAgCj4gU2ln
bmVkLW9mZi1ieTogVGFrYWhpcm8gTmFrYXRhIDxbdGFrYWhpcm8ubmFrYXRhLndyQHJlbmVzYXMu
Y29tXShtYWlsdG86dGFrYWhpcm8ubmFrYXRhLndyQHJlbmVzYXMuY29tKT4gIAo+IFNpZ25lZC1v
ZmYtYnk6IFJ1c2xhbiBSdXNsaWNoZW5rbyA8W1J1c2xhbl9SdXNsaWNoZW5rb0BlcGFtLmNvbV0o
bWFpbHRvOlJ1c2xhbl9SdXNsaWNoZW5rb0BlcGFtLmNvbSk+ICAKPiAtLS0gIAo+IMKgaW5jbHVk
ZS9zeXN0ZW0vbWVtb3J5LmggfMKgIDggKysrKysrKyAgCj4gwqBzeXN0ZW0vcGh5c21lbS5jwqDC
oMKgwqDCoMKgwqAgfCA1MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KyAgCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9zeXN0ZW0vbWVtb3J5LmggYi9pbmNsdWRlL3N5c3RlbS9tZW1vcnkuaCAgCj4g
aW5kZXggYTdlMDNmYzNlNy4uMjAzMmQzMDI4ZCAxMDA2NDQgIAo+IC0tLSBhL2luY2x1ZGUvc3lz
dGVtL21lbW9yeS5oICAKPiArKysgYi9pbmNsdWRlL3N5c3RlbS9tZW1vcnkuaCAgCj4gQEAgLTI1
ODMsNiArMjU4MywxNCBAQCBzdGF0aWMgaW5saW5lIE1lbW9yeVJlZ2lvbiAqYWRkcmVzc19zcGFj
ZV90cmFuc2xhdGUoQWRkcmVzc1NwYWNlICphcywgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGRyLCB4bGF0LCBsZW4sIGlz
X3dyaXRlLCBhdHRycyk7ICAKPiDCoH0gIAo+IMKgICAKPiArTWVtb3J5UmVnaW9uICphdHNfZG9f
dHJhbnNsYXRlKEFkZHJlc3NTcGFjZSAqYXMsICAKPiArwqDCoMKgIGh3YWRkciBhZGRyLCAgCj4g
K8KgwqDCoCBod2FkZHIgKnhsYXQsICAKPiArwqDCoMKgIGh3YWRkciAqcGxlbl9vdXQsICAKPiAr
wqDCoMKgIEFkZHJlc3NTcGFjZSAqKnRhcmdldF9hcywgIAo+ICvCoMKgwqAgaW50ICpwcm90LCAg
Cj4gK8KgwqDCoCBNZW1UeEF0dHJzIGF0dHJzKTsgIAo+ICsgIAo+IMKgLyogYWRkcmVzc19zcGFj
ZV9hY2Nlc3NfdmFsaWQ6IGNoZWNrIGZvciB2YWxpZGl0eSBvZiBhY2Nlc3NpbmcgYW4gYWRkcmVz
cyAgCj4gwqAgKiBzcGFjZSByYW5nZSAgCj4gwqAgKiAgCj4gZGlmZiAtLWdpdCBhL3N5c3RlbS9w
aHlzbWVtLmMgYi9zeXN0ZW0vcGh5c21lbS5jICAKPiBpbmRleCBhNGE2YTQ3MTBjLi4xYWNkYTIy
ZWRlIDEwMDY0NCAgCj4gLS0tIGEvc3lzdGVtL3BoeXNtZW0uYyAgCj4gKysrIGIvc3lzdGVtL3Bo
eXNtZW0uYyAgCj4gQEAgLTUyNSw2ICs1MjUsNTkgQEAgc3RhdGljIE1lbW9yeVJlZ2lvblNlY3Rp
b24gZmxhdHZpZXdfZG9fdHJhbnNsYXRlKEZsYXRWaWV3ICpmdiwgIAo+IMKgwqDCoMKgIHJldHVy
biAqc2VjdGlvbjsgIAo+IMKgfSAgCj4gwqAgIAo+ICsvKiBUaGlzIGZ1bmN0aW9uIGlzIGNhbGxl
ZCBmcm9tIFJDVSBjcml0aWNhbCBzZWN0aW9uICovICAKPiArTWVtb3J5UmVnaW9uICphdHNfZG9f
dHJhbnNsYXRlKEFkZHJlc3NTcGFjZSAqYXMsICAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRkciBhZGRyLCAgCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBod2FkZHIgKnhsYXQsICAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRkciAqcGxlbl9vdXQsICAKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFkZHJl
c3NTcGFjZSAqKnRhcmdldF9hcywgIAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50ICpwcm90LCAgCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNZW1UeEF0
dHJzIGF0dHJzKSAgCj4gK3sgIAo+ICvCoMKgwqAgTWVtb3J5UmVnaW9uU2VjdGlvbiAqc2VjdGlv
bjsgIAo+ICvCoMKgwqAgSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21yOyAgCj4gK8KgwqDCoCBo
d2FkZHIgcGxlbiA9IChod2FkZHIpKC0xKTsgIAo+ICvCoMKgwqAgRmxhdFZpZXcgKmZ2ID0gYWRk
cmVzc19zcGFjZV90b19mbGF0dmlldyhhcyk7ICAKPiArwqDCoMKgIElPTU1VTWVtb3J5UmVnaW9u
Q2xhc3MgKmltcmM7ICAKPiArwqDCoMKgIElPTU1VVExCRW50cnkgaW90bGI7ICAKPiArwqDCoMKg
IGludCBpb21tdV9pZHggPSAwOyAgCj4gKyAgCj4gK8KgwqDCoCBpZiAoIXBsZW5fb3V0KSB7ICAK
PiArwqDCoMKgwqDCoMKgwqAgcGxlbl9vdXQgPSAmcGxlbjsgIAo+ICvCoMKgwqAgfSAgCj4gKyAg
Cj4gK8KgwqDCoCAvKiBUaGlzIGNhbiBiZSBNTUlPLCBzbyBzZXR1cCBNTUlPIGJpdC4gKi8gIAo+
ICvCoMKgwqAgc2VjdGlvbiA9IGFkZHJlc3Nfc3BhY2VfdHJhbnNsYXRlX2ludGVybmFsKCAgCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhdHZpZXdfdG9fZGlzcGF0Y2goZnYpLCBhZGRyLCB4
bGF0LCAgCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGxlbl9vdXQsIHRydWUpOyAgCj4gKyAg
Cj4gK8KgwqDCoCAvKiBJbGxlZ2FsIHRyYW5zbGF0aW9uICovICAKPiArwqDCoMKgIGlmIChzZWN0
aW9uLT5tciA9PSAmaW9fbWVtX3VuYXNzaWduZWQpIHsgIAo+ICvCoMKgwqDCoMKgwqDCoCByZXR1
cm4gTlVMTDsgIAo+ICvCoMKgwqAgfSAgCj4gKyAgCj4gK8KgwqDCoCBpb21tdV9tciA9IG1lbW9y
eV9yZWdpb25fZ2V0X2lvbW11KHNlY3Rpb24tPm1yKTsgIAo+ICvCoMKgwqAgaWYgKCFpb21tdV9t
cikgeyAgCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOyAgCj4gK8KgwqDCoCB9ICAKPiAr
ICAKPiArwqDCoMKgIGltcmMgPSBtZW1vcnlfcmVnaW9uX2dldF9pb21tdV9jbGFzc19ub2NoZWNr
KGlvbW11X21yKTsgIAo+ICsgIAo+ICvCoMKgwqAgaWYgKGltcmMtPmF0dHJzX3RvX2luZGV4KSB7
ICAKPiArwqDCoMKgwqDCoMKgwqAgaW9tbXVfaWR4ID0gaW1yYy0+YXR0cnNfdG9faW5kZXgoaW9t
bXVfbXIsIGF0dHJzKTsgIAo+ICvCoMKgwqAgfSAgCj4gKyAgCj4gK8KgwqDCoCBpb3RsYiA9IGlt
cmMtPnRyYW5zbGF0ZShpb21tdV9tciwgYWRkciwgSU9NTVVfUk8sIGlvbW11X2lkeCk7ICAKPiAr
ICAKPiArwqDCoMKgICp4bGF0ID0gKChpb3RsYi50cmFuc2xhdGVkX2FkZHIgJiB+aW90bGIuYWRk
cl9tYXNrKSAgCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAoYWRkciAmIGlvdGxiLmFkZHJf
bWFzaykpOyAgCj4gK8KgwqDCoCAqcGxlbl9vdXQgPSBNSU4oKnBsZW5fb3V0LCAoYWRkciB8IGlv
dGxiLmFkZHJfbWFzaykgLSBhZGRyICsgMSk7ICAKPiArwqDCoMKgICpwcm90ID0gaW90bGIucGVy
bTsgIAo+ICvCoMKgwqAgKnRhcmdldF9hcyA9IGlvdGxiLnRhcmdldF9hczsgIAo+ICsgIAo+ICvC
oMKgwqAgcmV0dXJuIHNlY3Rpb24tPm1yOyAgCj4gK30gIAo+ICsgIAo+IMKgLyogQ2FsbGVkIGZy
b20gUkNVIGNyaXRpY2FsIHNlY3Rpb24gKi8gIAo+IMKgSU9NTVVUTEJFbnRyeSBhZGRyZXNzX3Nw
YWNlX2dldF9pb3RsYl9lbnRyeShBZGRyZXNzU3BhY2UgKmFzLCBod2FkZHIgYWRkciwgIAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBpc193cml0ZSwgTWVtVHhBdHRycyBh
dHRycykK

