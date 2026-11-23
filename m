Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E96606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=akamai.com header.i=@akamai.com header.a=rsa-sha256 header.s=apr2026.eng header.b=JiF4T5zU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWX2-0007YP-6K; Mon, 23 Nov 2026 11:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1xVWWz-0007YA-90; Mon, 23 Nov 2026 11:04:38 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1xVWWx-0000nB-D0; Mon, 23 Nov 2026 11:04:37 -0500
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
 by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 6ANCg3Ea2081462; Mon, 23 Nov 2026 16:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 apr2026.eng; bh=iw/0f8D5tl3a6WpmvqewUVLZwkxq/LqDpHYICKA1O7E=; b=
 JiF4T5zUOeWL50R4R1iW/jm5FjAiMogvWalwcK/pSQril2p83OSYb0OMoOz7G8OW
 z/oz4sRDX4LW2qFfg6aubORFZFBCRw8C1Hu813tKGwvHtIT7Ox1W6NfJZA9D1DKx
 7Plt7nZxiIB1/lBewDu05oX59nooi80txmh4N2Ycyqzn+sGztJGgZYKpfdhrk188
 uUABF6Ht3nRWtzDzH0Z/nhKG1S9o0b7/bwwVz0PcINHy6dXbM/nkWh45bHpDSWv8
 mWlAsbDBVT/bgyXZnghbJxOLeyC5usHJUsTIULC4BRfzL/ME/l5j1va70Dcjphr8
 P6yBZq06o65yxcR1jmBefg==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
 by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4j3ngq6uuu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 16:04:27 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 6ANFpEwx024949; Mon, 23 Nov 2026 08:04:26 -0800
Received: from email.msg.corp.akamai.com ([172.27.91.40])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4j3a5b88c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 08:04:26 -0800 (PST)
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 08:04:26 -0800
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 11:04:25 -0500
Received: from BN1PR07CU003.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft
 SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 23 Nov 2026 11:04:25 -0500
Received: from SJ0PR17MB4301.namprd17.prod.outlook.com (2603:10b6:a03:29a::20)
 by CH4PR17MB7427.namprd17.prod.outlook.com (2603:10b6:610:22b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:04:17 +0000
Received: from SJ0PR17MB4301.namprd17.prod.outlook.com
 ([fe80::8159:aa6f:8ecf:11f]) by SJ0PR17MB4301.namprd17.prod.outlook.com
 ([fe80::8159:aa6f:8ecf:11f%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:04:17 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Michael Tokarev <mjt@tls.msk.ru>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zhivich, Michael"
 <mzhivich@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>
Subject: Re: qemu stable process questions
Thread-Topic: qemu stable process questions
Thread-Index: AQHc1AwRb+1ByKdD1Um30qkGP0GOrbXugxiAgU5JkgA=
Date: Mon, 23 Nov 2026 16:04:17 +0000
Message-ID: <95ADDA79-C604-4025-A9CE-182027BB2098@akamai.com>
References: <9C918929-E60B-4298-84A3-0B9C2F7E399F@akamai.com>
 <0be3bac3-5aa9-416f-849f-ef7da3015dec@tls.msk.ru>
In-Reply-To: <0be3bac3-5aa9-416f-849f-ef7da3015dec@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.115.26111533
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=akamai.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR17MB4301:EE_|CH4PR17MB7427:EE_
x-ms-office365-filtering-correlation-id: c2781441-b7da-4634-e97d-08df497b6d57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|4143699003|56012099006|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Cdb04bE91esZ4wa9LoeXa6f4rN0jNbzhhERjSEZj1aELN78LXMC8GufunMd47JZG7FLveRw6xokX3d4g1NxpS7xcQfH+1HjXiFfvHmL7LqBUdAPi9jFtt/lc+iEpkfjVN0h91hMHM3rwGTXGSdsmTR9aQmPtQ7qQMlE93H7jkQunYz89MRv9bUvLxZ4BAYUz8EBesyD11a9FzAI3+DZL5wmXXGKY1N/2XbHFY4BBxIWjJlcXEzzLYpZ2v+lH/ObpmOO2GW/nyeOABs3DnvC6xyKcjWYxKpYzMDbhRqJVlLD5qV8GF9W1I4AbAvJPanE4cHYmFYHXKNFPFgbjZJdxoJeb73+dkhGtc3bql94fY9mGIpn75cRF15ldg1X7HI1upnVCRcWGY+3+LvZ9hB8cOw4DIylJ7YNEqQdF/tMNyoOfnpC48S+1DKVCa2Z0mgTUSkk18b6CXAWaTcBtkhkf9L5+0JlcwQjqE2vmazceHw0yycutwhXrX/n+iWDhQqA6bx0Y6hDBoi+LDknxS7D7mLdmjGoFlOHy5KoFm2kl4VlemmbqrFAEkJhAQd1I1eRgIa9WArZcCNrrAeLb2gwBsEZ5DCChO4P7y+h/c2lUfqAJShPYLxkqSmPkQ0FNTNKU/38yTKjed2tehzSt01BieeE/GPyR9VxaCoi5lSsN2PItTvxUNegObpCbF8sf8biTeFPtC/bmmqTOFv1nzV6ZGQjuOJ+tXQQZs19DNoWk8/k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB4301.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1l2OFg2ZHVtTEtMU2hOR3M2N1lEek1CaUVlMnhsRTBNTUxJVS9qT2ljcERS?=
 =?utf-8?B?WEZIT1htQ2RESzBmWUlJa0VoUTVYeTlBSmRKRmU3ZGo5QmZ5Q0d2ZHJnbmtI?=
 =?utf-8?B?MUdobVByeEFpbWpRYjc1T0RzdFNIS01XeElJY2ZxUjF0UFB3eFRsWjNtZDcv?=
 =?utf-8?B?RW1iZU9RbmVNamVFekIwR3JTdXcxTHN4Ymxmc3l6UXpRSTk5RXFZUmRTc0lB?=
 =?utf-8?B?WnZkS3kxbnorSnY0OUo5eUY1Q0l0MGNHVFM3RGZ3a1IzZUxPZ2RST3g1UUY3?=
 =?utf-8?B?NE1WeWZrUDI5Mm05WDdkT0VOb3I3OFhxbkw4STliVDg2b05wSFY5REVWUDlE?=
 =?utf-8?B?K3pvSVhoVDVwL1V1NlZMWStYSjRRaStDOFl5bEUvb3hNZmpPME04RU02YjNt?=
 =?utf-8?B?ZHBzOU1WRUdubGphb0N1ZU9FUU9Jc3M4d0d0YUUxbE85b2JYMmVkVC9rSTM3?=
 =?utf-8?B?WjBraG1yWlhXWWl2S0Fwcm1Ja045Nk45Nzk2dlo2U056RUVhYW9NdTlvRmpI?=
 =?utf-8?B?aEQwL1VNUFA5aUh6T1FNR21ZSmhtNExrekZHUHRtajVNYklBUENhbWJqNHB1?=
 =?utf-8?B?eU5RWTNOODZ4NHFVU0Frd0tNNjhEY1NudW8zVVlXcmxKVXVoT2I5Z0FjOFNk?=
 =?utf-8?B?UWlIa2hmd2IybEE5eHlXc1lFMkR0czUyMW1tenZpc25qeXBndmwvWUhyWUVP?=
 =?utf-8?B?dWxpbmg3MWFpYUFEeTJRV2RHblVqT1h2SHFnYk5QbVFTbmlieEpwUmNtVkVK?=
 =?utf-8?B?eWJYVFo0V1kxS1Y3SmI1RWJCT0ozZmhtc2Raa0lNTVVXdVAzREVqRzRmYUFR?=
 =?utf-8?B?bVkvLzB3dW9PclhZdTF5ajg4Tit0V2hrNnNyZ2hxc0NPQ2ZnZzNCcG84cEs0?=
 =?utf-8?B?MHN6NTZPcjdFOWZsRHk3eTA3SEFRSkhLNU5mOFZwS2hPSHhPTGlPaThBNktx?=
 =?utf-8?B?QmNJUkE5eW1HNGsrc1FrZUx5YVc0YkNPN0pFS1FoSUVIZ2FRWFhVbS9tbmEw?=
 =?utf-8?B?bXp5OVliZlA1aTdhK3FNZGt1bVhnN2tHR0N3dmxkRDRDVVBYMUtBcHQ3ajdB?=
 =?utf-8?B?Kzh3M0ZTWFpkMndkNTdSYjRQUDlvY0RqV01ueU5jSE5ycTR2eVd4bXZrY2xr?=
 =?utf-8?B?Qmc2VHpOb2JPYWxDSHVxUS9HaFRtUkU3QjNCQXMzaUZGb1podEdpZTNndHN2?=
 =?utf-8?B?bktUNVk1c3psUFZCeGFRdE5WL2NPOWFwakZBcXF6aVFxSjgxWDdEN25VV21C?=
 =?utf-8?B?TUNxcXN1WGpEZ0lhYjVvdDAyTXFpSjZ1dXBkZlpQY1F5N1ZGTzRueHlyVUta?=
 =?utf-8?B?RjdFdis5b3pkT21TMWxBLzBTN280cWQ3OGJFb0J2UDkvZHVwMzJBWitZNnNj?=
 =?utf-8?B?eFUyRHdzNjJtK2JxaHhYbmxGMzMyRlFnR0kvT2dFTVV4bVRMeUJpVlYxRXgz?=
 =?utf-8?B?czh2OWdQMEFmbGx0c0o5ZHdCVU9ONmU2TzdURWpsQkF0cGY4TWVUZXJTenRB?=
 =?utf-8?B?bkJlRnVmUEgvREF5OFlIUFJKbnJrTE95WmJvS0dmUHV2USsvOENYV2NUZ2pB?=
 =?utf-8?B?ZE9oMjhxRTRBRVZudDBYWiticmZQaWNBS1g0Nys2ZWU5Z1hQcFNGb2ZodzNT?=
 =?utf-8?B?UlFuUGhjU2ZDRjhsU1RyUVBZL3RmWGRUeUhTQkRtcFg5RVdFOGlQSmpnMk9S?=
 =?utf-8?B?REpDTTdSNXRwZ0ozWG13a3c5R2F6ZTdoTkdlWit5Q2hDdEY5VGRtR1Njak5U?=
 =?utf-8?B?SmNHZXIybXZobktoZ04zQ2hlUDZxS29yS01iOThITzNSVUo2ZTN4dm5GeFB6?=
 =?utf-8?B?QU1aVk96ZXI2Z2FPN1lnRW5qQVUrMDN2anhWZ0lURWhyUjZqSGJuS21VaVhD?=
 =?utf-8?B?WWRZR1IzSDduc3QyUlY4ZDVFWUJyTnhybjZyYVJVNlJ0bHRmd1NJZUpJbkV0?=
 =?utf-8?B?RVI0YU0vdkQxUlBpTGp2NVRoNkpxb21lMDh0U0pySDdEZE9TaWJ2eTlFN2Nt?=
 =?utf-8?B?U2VQRmhlQWtEWk15V2lZRnlQNEZsKzAzTGh6ZjM2YVA0cnQrckFVeGIycm56?=
 =?utf-8?B?bE1FdDVTeVc0K2hNS2sxRkVLQXFsQkplalFYUDJDQUVVVG1JWmJ2RTUwUGp0?=
 =?utf-8?B?a3NaVEZRQzBERDQrVHJmMWVwVWdwZEFENFd1aFRrV2lKMWRQVWNiRE9UY3hj?=
 =?utf-8?B?b09YQWFkcTVtN1hxNXFjcVByUU1Gdld4TXJ3cDlmZTZ6TnJKNUUyRWFZZTND?=
 =?utf-8?B?bkZ0ZzJyUTJpV3BaQ0NvOXpla2JCVTZodkxBOEdRT3g3NGlLYjd1cFdlQ0Nu?=
 =?utf-8?B?RlQ5c256NVBPQXlzQnRPUGY0c1B1YUR4c0ZoRDFFblpEL3hkclRXdz09?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyY4w9R+RlbcjyoRbeMm42XgDPBhznKtohVaFuG/glWUDRwJBarjNhsxI4dkk4lAytidQk6RmURuPahJXaRFYc8gI3R28ppJD2Rva/aNwcnpKrPHq1EuVaTF+IZyfitCNv2dVIbtPVpsIV/x2LFZhbqJJA2QtRPBV5t56H5c+OKFzytV/FC3pODFW4HCDFAzc7cJuZUsQV/euuxfDo9hRjuvPc0g8GCSSgOcCxU/RR3lAURlu2191jfaZqS4m2RLxJrYE/BfEZht6vC6UnKZ6WELtS/B/exdRVrtrS+Vvu6hN/jKHtb4us6pkG237+n4RsjwlvzvgpfnpG0a6AB3Eg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqJ32JCNyfBTEOLExbpSa/LqGrftJDPV656Pl2QC0Ak=;
 b=Z+5vjCLV3U8Lk19ffKX6apmEYgAc1dNZ1SbILbyYjIZ584bHCVUUTZuF9ewO0xXBED7QD8I6+7bl0gMuVhXsa5IMNlKt108u6WXFQXh48sGJHp94X0kfv7jXTsXwUFz+9cBFFo+N6R4GWoJu0GXYQXQsGUfmHidvxUymSldW7+Kvb7kGVx6CJClJmU0GkmANqZuvCEgQTvMLl7AnDFxKKTqeS0EEenEAQZdtmVUKWJzOFevQL4u6wL0biy0db5dH8t01NY9WSxqxzCVM6mPKmiwK8YVKDrqJ5tFHLbMLEXH2P14jnNhpurlFokbxqNvkmY2GmBTYidQ6iRyrEKml9A==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: c1RxJnrVjVkssdFzTGg6RwV6a5lSO1Oflh0gz+ab3O0r3yn5Km1w4AHtsgWr1On0ICuMyKM6PnkGWQWpejjhYmC0SvnIBnsAf5XFaWkArA+ofnf0fMdPovuk8mzUboHnIVhmw57R8CenYy0le7FedLzuplDVQ6sjjgeanJXqqLrsOZjfB7Fo1oBMF2rT8y5z/289/CQ758waZXlGWL43slow0X+BwaA5wx5hjCdsXMnN/nuqmNEFLlbvizU629U82NsS9pML875+Gg2l/UhJLgVoaf2zkMj7vpr77crEckGoIBzHEV/zmWvVwhcgIlMFIgLfDnb2PkvCMdpP864YLw==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SJ0PR17MB4301.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: c2781441-b7da-4634-e97d-08df497b6d57
x-ms-exchange-crosstenant-originalarrivaltime: 23 Nov 2026 16:04:17.3685 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: GUY1NDDg15Cs3Pv3Q5YdzZRYrS6a9cokHaybdopmPUO5fbdMZfzsb0SqFa+ITBurLoqW+F3qMYzcanaAhJMNxw==
x-ms-exchange-transport-crosstenantheadersstamped: CH4PR17MB7427
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DE45BAB32A2144CAA385118F1E1D304@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11975
 signatures=596817
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2611040000
 definitions=main-2611230063
X-Authority-Analysis: v=2.4 cv=QcbzLcbv c=1 sm=1 tr=0 ts=6b04640b cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=TTBIr9FR-UdC54aaq7Eb:22 a=9qUTvQc-AAAA:8 a=ID6ng7r3AAAA:8
 a=v79M5AA58SyU3TEbEKYA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=axOgMmt4Ejcwn1cqzmsR:22 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-GUID: WOu2xjbxkqMFXoQOmCK_gn-GnAjq18fJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MyBTYWx0ZWRfX4zv4C5hVqqss
 naXtbhh6ZU6xtOWt82FlaRz14IFDmoPyLg1CIMV2vxSRwL7ZTdzElk+OPOb9DsdM09WwShnWbOK
 WoVHAKAYsmoi1VrrCjC2875vGZiTp6s=
X-Proofpoint-ORIG-GUID: WOu2xjbxkqMFXoQOmCK_gn-GnAjq18fJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MyBTYWx0ZWRfX3QP0KeU5Hblw
 /Qzmk5vYp0IWhrLMxMuxTskdnRBbFWwCR0J7Em8fpX6a+GRX+DNcCk+PiORz4Ip9gUC8SzizPBk
 LmdLI04SFQXmoDBGXSO0f6ngWR7zlJOuBZNY+AItGIxl+5d4fMR2j8oNnx5pU2f5I58fCanV1dv
 gXAYUOgdG7qljE6Oo5nh1BREA6VUyHXC6D0hsjK/mlrwndqo7t2mA9Z/HGQwlYxfp68OnwJPO1V
 D+FVVqPJNz5UNIStOyYzEv2tuWIdwdt3tc70Y+jBoqjhNaFCa8PXWMLmDP/wjUS5jYQoCdIWZXu
 zB3uvFOAlkLE0HVuyc5xgLSLn9fhS0tOjxbz//7+hWPrzy926BP920s1y4jq/IdnlwBdap87FsS
 fr/o6BgY6zHUWW8ARTs1yWEkAq8O4Fgc7rnoo9DCaAKExpHySbcni7ONYgS26q+oSoI1mJWPtTf
 LtfclzMf7Q7VGqMzL3Q==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11975
 signatures=596817
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611200000 definitions=main-2611230063
Received-SPF: pass client-ip=67.231.149.131; envelope-from=bchaney@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCu+7v09uIDQvMjQvMjYsIDI6MTEgUE0sICJNaWNoYWVsIFRva2FyZXYiIDxtanRAdGxzLm1z
ay5ydSA8bWFpbHRvOm1qdEB0bHMubXNrLnJ1Pj4gd3JvdGU6DQoNCg0KDQo+IFNvLCB3ZSdyZSBi
YWNrIHRvIHRoZSBzcXVhcmUgb25lOiB0aGVyZSdzIG5vIHJ1bGVzLCBJIGdvIGFzIEkgZmVlbA0K
PiB3b3VsZCBiZSBnb29kLCB0aGF0J3MgYWxsLiBJJ20gdHJ5aW5nIHRvIGJlIHVzZWZ1bCwgYnV0
IGdpdmVuIG5vDQo+IGZlZWRiYWNrIGFib3V0IHdoYXQgYWN0dWFsbHkgaXMgdXNlZnVsLCBJJ20g
cmVzb3J0aW5nIHRvIGd1ZXNzaW5nIDopDQo+IEFuZCBieSAiZmVlZGJhY2siLCBJIG1lYW4gbm90
IHRoZSAidGhhbmsgeW91IiB0eXBlIHRoaW5ncywgYnV0IGFib3V0DQo+IGlmIHNvbWUgc2VyaWVz
IHdvdWxkIGJlIGdvb2QgdG8gYmUgTFRTIG9yIG5vdCwgb3IgaWYgc29tZSBzZXJpZXMgY2FuDQo+
IGhhdmUgImEgYml0IiBtb3JlIHN1cHBvcnQgdGltZSwgZXRjIC0gdGhhdCBzb3J0IG9mIHRoaW5n
cy4gSSBqdXN0DQo+IGRvbid0IGtub3cgaWYgYW55IG9mIHRoZSBzZXJpZXMgSSBydW4gYXJlIHVz
ZWZ1bCBvciBub3QsIHRoYXQncyBhbGwuDQoNCkhpIE1pY2hhZWwsDQoNCkFwb2xvZ2llcyBmb3Ig
dGhlIGV4dHJlbWVseSBkZWxheWVkIHJlc3BvbnNlLiBUaGFuayB5b3UgZm9yIHlvdXIgZGV0YWls
ZWQNCmFuc3dlcnMgYW5kIGZvciBtYWludGFpbmluZyBxZW11IHN0YWJsZS4gRnJvbSBteSBwZXJz
cGVjdGl2ZSwgdGhlIGN1cnJlbnQNCnByb2Nlc3Mgc2VlbXMgbGlrZSBpdCBpcyB3b3JraW5nIHdl
bGwsIGhhdmluZyBzdGFibGUgYnJhbmNoZXMgaXMgdmVyeSB2YWx1YWJsZQ0KdG8gdXMgYXMgdXNl
cnMuIFRoZSBvbmx5IGNvbmNyZXRlIHBpZWNlIG9mIGZlZWRiYWNrIHRoYXQgSSBoYXZlIGlzIHRo
YXQgaXQNCndvdWxkIGhlbHAgdG8gaW1wcm92ZSB0aGUgcHVibGljbHkgYXZhaWxhYmxlIGluZm9y
bWF0aW9uIHJlZ2FyZGluZyB0aGUNCnFlbXUgc3RhYmxlIGJyYW5jaGVzLg0KDQpGb3IgZXhhbXBs
ZSwgSSBub3RpY2VkIHJlY2VudGx5IHRoYXQgcWVtdSAxMC4wIHdhcw0KZHJvcHBlZCBmcm9tIHRo
ZSBtYWluIHFlbXUub3JnIGhvbWVwYWdlIHdoaWxlIGl0IGlzIHN0aWxsIHJlY2VpdmluZw0KdXBk
YXRlcywgZXZlbiB0aG91Z2ggc2V2ZXJhbCBvYnNvbGV0ZSBicmFuY2hlcyAoc3VjaCBhcyAxMC4x
IHdoaWNoIGhhc24ndA0KcmVjZWl2ZWQgYW4gdXBkYXRlIHNpbmNlIE1hcmNoKSBhcmUgc3RpbGwg
bGlzdGVkLg0KDQpTaW1pbGFybHksIHRvIHRoZSBiZXN0IG9mIG15IGtub3dsZWRnZSB0aGVyZSBp
cyBubyBwdWJsaWMgaW5mb3JtYXRpb24gYWJvdXQNCnBsYW5uZWQgTFRTIGJyYW5jaGVzLiBJdCB3
b3VsZCBiZSBoZWxwZnVsIHRvIG1lIHRvIGtub3cgbm93IGlmIGl0IGlzDQpleHBlY3RlZCB0aGF0
IGEgZnV0dXJlIExUUyB2ZXJzaW9uIHdpbGwgYmUgYmFzZWQgb24gdGhlIHFlbXUgdmVyc2lvbg0K
aW5jbHVkZWQgaW4gRGViaWFuIDE0IHdoZW4gaXQgaXMgcmVsZWFzZWQuIElmIHNvLCBpdCB3b3Vs
ZCBhbHNvIGJlIGhlbHBmdWwNCnRvIG5vdGUgdGhlIGV4YWN0IHZlcnNpb24gc2VsZWN0ZWQgb25j
ZSB0aGF0IGlzIGtub3duLiBUbyB0aGUgYmVzdCBvZiBteQ0Ka25vd2xlZGdlLCB0aGVyZSB3YXMg
bm8gcHVibGljbHkgZmFjaW5nIGluZGljYXRpb24gdGhhdCAxMC4wIHdhcyBzZWxlY3RlZA0KdG8g
YmUgYW4gTFRTIGJyYW5jaC4gSXQgb25seSBiZWNhbWUgY2xlYXIgd2hlbiBpdCBjb250aW51ZWQg
cmVjZWl2aW5nIHN1cHBvcnQNCmxvbmdlciB0aGFuIG90aGVyIGJyYW5jaGVzLiBUaGlzIGlzIHBh
cnQgb2Ygd2hhdCBwcm9tcHRlZCBteSBpbml0aWFsIGVtYWlsIHRvDQp0aGUgbWFpbGluZyBsaXN0
IGJhY2sgaW4gQXByaWwuDQoNCkkgdW5kZXJzdGFuZCBpdCBtYXkgYmUgZGlmZmljdWx0IHRvIHBy
b3ZpZGUgaW5mb3JtYXRpb24gYWJvdXQgdGhpcyBzaW5jZQ0KdGhlcmUgYXJlIG5vIGhhcmQgYW5k
IGZhc3QgcnVsZXMgYW5kIGRlY2lzaW9ucyBhcmUgYmVpbmcgbWFkZSBvbiB0aGUgZmx5LA0KYnV0
IGFzIGRlY2lzaW9ucyBhcmUgbWFkZSwgaXQgd291bGQgYmUgaGVscGZ1bCBpcyB0aGV5IHdlcmUg
bW9yZSBwdWJsaWNpemVkLg0KDQpUaGFua3MgYWdhaW4gZm9yIGFsbCB5b3VyIHdvcmsgaW4gdGhp
cyBhcmVhLA0KICAgICAgICBCZW4NCg0K

