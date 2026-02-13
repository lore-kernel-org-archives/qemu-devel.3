Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7148DEDF150
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqpE-0005pg-44; Fri, 13 Feb 2026 05:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqpD-0005n2-0K; Fri, 13 Feb 2026 05:55:03 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqpB-0001kH-5N; Fri, 13 Feb 2026 05:55:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSaUxftGO/sHE+v/jyHvNaw58QgH1i3nWA7NqJsL/xGjpYTLEwvTFdQm+42o17ajMajcLEQ6OlMSz97DwPnW26VsKrQOCzhM3X/+KfEBwpLwyLoTN3hZEYlwnxOrlexlM8kndNsDY7hetcxLmmbQSSwEgnZ42YWPqS9He8qOHUUCcK8X6iAh6GNDY74AmJws8EI0S9STW6XCJTf+IPN9DbS2Tpt/9rTCkXtlvPqT0LavOc/AAFGUIclgZNASv7Ta1uyitvcK6YOeg0iumG7BRw+19dzvx5/oTAxVQQQnj0+QCS/4275Fovfyqa2jF6ebPbx6NwlgGxF+A+nUTIYMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyUfPvcOhP7RPThcHFHyVu1DQvbNbodc9erDyVkyEiE=;
 b=AdcFHO602bv70r9bwgiojTxNzRwdxt48a1kK0C1jN9Iovxz2JBdjbp71FvdgruV1wjp2YDePvUzJizEMo8KRXXdZ/HCLDQDV7Q31V7V1YltQSM5ddn6t/ZL87qvA5thCbe/A7RHWwE6V/xcTJ+bpdRzSqH+TSQTFIGMebXXINP0uKemD4xtNnuIXCWYjTprK8YpeVqIbMLTW4vC3lXYyKvU5mlkbF1F8KOR+pFBJHlJQGsfMwAOKKwBXa8/O1O7XTZ9F7w8VPT7+W/lwTue4D96qiT5TJ7Up1h2H14nMTu8tP5ZndLpZlQWwWOSelyFDntmZ/gBKeP1CLxjrsuLrKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyUfPvcOhP7RPThcHFHyVu1DQvbNbodc9erDyVkyEiE=;
 b=jy56dtgariQY/NBXa/29FTWLo+abWfKeUInXUDjLCb+qi1mq2NFgmGc7c9AiC0xNVNilp74BBkPZswbVHNqgM7P4BAvaC1UBQ540iVAQlWPlxq+b9GoB3Y/6RNHW6lr2ECo8AqioYyWWgCi59lAiVEw/H9DA0+EtQKYgNZIw7uDFYqX8KpC7EiDZ04+qemSBh6kqpoqyyxvr+bj4J5o0XRkydQe7O8go0mEKbLdz60SD4VHh63+qu0QjN9WTlY+tpIedw2NgAmz0r7oyyfCvTkOELxHpreE3PccS9GqP+++UaNkhBr4EvrQu9ECgQgu2jkFaQRunPkhRbYo8H4eyZA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:54:54 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:54:54 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v2 04/24] backends/iommufd: Introduce
 iommufd_backend_viommu_mmap
Thread-Topic: [PATCH v2 04/24] backends/iommufd: Introduce
 iommufd_backend_viommu_mmap
Thread-Index: AQHcl3fVlY09rKo4ak2D2nldd+nqlbWAdXoAgAAJyMA=
Date: Fri, 13 Feb 2026 10:54:54 +0000
Message-ID: <CH3PR12MB75486220E099645ED622EC71AB61A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-5-skolothumtho@nvidia.com>
 <cf34ad79-1914-428c-8999-8a4faf337a15@redhat.com>
In-Reply-To: <cf34ad79-1914-428c-8999-8a4faf337a15@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY5PR12MB6106:EE_
x-ms-office365-filtering-correlation-id: 094774f3-b371-4e86-6d49-08de6aee520b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RExiWlpLclR1YmJUTDNiL0RZdHIyTFNMVGVMaGNCREFtelM3TVEvUG9SN0Jm?=
 =?utf-8?B?VXdjMkwzd1lEZXpzb1o3R1JDeHJIaldSNFlBbW5KOVQvRGdRSzg2bGhBckJ0?=
 =?utf-8?B?TXRxSWFIZmpwV1dwalFIUjJLQU5lb0RWQ25DSkc5Ym80ZTFUM2N0N3R2c1V3?=
 =?utf-8?B?Y0pKQnRPb0N6M3RZMERCcXNUVlFQRkZDN2laVkdQR3lKc3o2YXlhWm9YWmlF?=
 =?utf-8?B?QVZZM0FKK3YzR1pCUjgzMU1zSHJKQ1JVSnhUUm16WnJzZi9IeEZZUzlEcFhm?=
 =?utf-8?B?Y0RZZVRzTk1OOTBJSXkxTU0zbVB2NTRZNmtlNHI5VWVWMERlMXZVWUdGU0Zy?=
 =?utf-8?B?MStqRHJLcThIQ1JNUFIxU1R6Ym0ydURaYk1Gb3hDWERKMEZ5Z1RINWY2WFA0?=
 =?utf-8?B?NkpLWVRRSTZhOWNTejJpSnJ1WkNzd2pHdVpTY1FDbHZNS0hDU3Q0WCtQM0lK?=
 =?utf-8?B?djZTWEV4QkdwVjBhSnFKYXhPRm9yNU1vL2cwdEF1N01uaU04aTZiUlliOTdE?=
 =?utf-8?B?TEZTaTBrY1E5WXpVa0RJakhDMEQ5c1BiRjFlSDVaejh4Z0xyN2Fuam5tV1A5?=
 =?utf-8?B?ZmxVYm1XVndTNFJEamxETGU5Q0loRUlJV285ZjY3a0lKZE1wREVEUzhsZGxv?=
 =?utf-8?B?VU4xTnNyc2RKMVVqc3k4cnRTeWtqOHA1MDZsRjZiRTVaNUV4WFlidk4zSEo3?=
 =?utf-8?B?UFhPdFVhaFVaOHd6RXU1MW5iZ3ZBN3VsTUdFSW85TzAzQXEzS2hVbGkzakR6?=
 =?utf-8?B?SVRqYkNEWUdhdDA2aGQ2MEZaRVhqY3E2N3ZFdlNMWXRGdWUzRXdTNW1WRTd0?=
 =?utf-8?B?SWJzQ2pTWnNWMGZIT2VtVXhlbXVCbFRtZWQ2d1NheGFJQU1IWlg0MXhpemMr?=
 =?utf-8?B?M0hzTndxY2RmWTZ2Nzc5MFV0K3pPMU9oLzRoZEhmR1FLSWdLbHNCYTRBNzVO?=
 =?utf-8?B?Mm9TZkg1a2ljdjJCbkVVSkFlTU9ZcEtRdm1Td3prTHBGaTMrL3dqdW56MEor?=
 =?utf-8?B?WkN2UU1keGVoNVNyQ1BYVVhKd0l3dEsxaFIzS2RuZ3N0VjEvRSt6WWhBYklR?=
 =?utf-8?B?NkQyRzU4SzQwV3hCQkMzRWRnTmRWWjJON1lhSjNHanRJSGtyRjVDc3V6cXVr?=
 =?utf-8?B?SDI2YWp3MmNDNk9RSThRbmVHYzQ4aTBVVTRxaDJmTndQbUlsN3hZb3ZRMXY3?=
 =?utf-8?B?c08vUHdwaGl0MUJtUm9wQ242YzQ1bE9sL0QvVU5BSkdSQ2V5UDBYeUNEK0ta?=
 =?utf-8?B?S0dhRkxrMlZ1M2JoZ0NLWE5VV0pLaXdURHVscGVYVlF5NzR3cTFXUXlEOUkx?=
 =?utf-8?B?djNyQmM2bzBINW41aVA0aWMxT1lyWDgxL01YNzV5Y1BKc0g1bGVzWFJxclRB?=
 =?utf-8?B?ZUMzc083NEUrdy9mRWlOQ21ieTRFZUJXYmZkODFYcVlRRStzWVRXQkxRL2ZX?=
 =?utf-8?B?UkE0cVNuMDBIL1EySkdtRS9yWkVmNVhNb3JQYU1kd1JjTXdZbU9qNEVSTGt3?=
 =?utf-8?B?b25ra05vOTZEMWlPSEFvT2dkS2VWbHk1VmkxTXc2WXFDN2lZb3FEcjdKU3pK?=
 =?utf-8?B?Y3lnRVBNTVplZmZyRkJ0engwMVdWTE93Vy8zclVWL0lueWtTSUxrbXFsdGsz?=
 =?utf-8?B?Q1JSUnBqYmRhM1BVNTVRbWFmZkoxb0NySTJ2NlV6T2owYndxWXZMdXhtVmJl?=
 =?utf-8?B?MUxROUxGSk9UTGkvVkpNL0ZVVVFzVDFDMGpzSnNNYnNYejV5Zmo2cm1IZWRQ?=
 =?utf-8?B?bXkrdjBnYStod0RqMzlLeGNhcDBrVzh4Y2RZaDA1Tzl2ZmZPT3RNT2NEMHRl?=
 =?utf-8?B?NW4xcFlpZHl2Qy9nUXJWaDNtblEraXpzWC91WjEzRTBRUVVGWTlSdmxVb1JJ?=
 =?utf-8?B?b2lQTFZrSFdSVTFTemgySzI0dFh3d3VqcWV0OFdlM1lqVVhscXJoZ1N2T0xs?=
 =?utf-8?B?Q0ZJQTNrbFJMNXphR216ODVHbkZINVJsVnJmaUY5YzNkS3Z2ZGl1OW9VaEd6?=
 =?utf-8?B?aTVUK1NZa0ZYNXk5UUFQTlJaNUpSc3VXZHpIK1NOVThiRGs0ZDd6TEkxNUNV?=
 =?utf-8?B?STJ3U0JwVTZCYUNJRWxURm9UTEw1L1BGbzV3M0V2eEpQa3BJQ05pZm5zNjRo?=
 =?utf-8?B?UkZrVWI1U2hqY0JlMHgvMytXcExPREl6WXJyV0FQMnhBb09KTWcvZkpQL3BJ?=
 =?utf-8?Q?j0JJ6XHWQYxlY0H7VAfz4Z4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3RqOWJQRTFQeGxhZnB3cWt1RGxGNWJOK3dmcDlnV0xKUGYxMlR4Y3RxN1ZO?=
 =?utf-8?B?SWdhK2dLb2lpVGl0SW0yK3l0M0dsTzlFc3R6b2d3RkhGdktwTXlTVXB3ZFVq?=
 =?utf-8?B?V1pTNGdCYlhQUXdHMFhpUFY4UXByRUpUVTB0Ynl4VVJNNUdlZUFmUHBXUjZK?=
 =?utf-8?B?eGZ2ejNWK2xTNSt6eHVaSlZENmU5Qlp3YnAyVlJGNW55Y2Z2elAwVXhjR2tM?=
 =?utf-8?B?dm9tMHFCNExRMDNuSVdobk5NUGZxcFpiQ3dFbXR6OXBTYkY1aGRneVdtNGk2?=
 =?utf-8?B?Y090NlYycGl4Ynl6enQvOGNrZkhNTWh1VVBpK2UyOEtSK1pRTnh6aTlkWDk4?=
 =?utf-8?B?elg3Y1psU0ZYMVQ4LytONzJ2Q1hCMVlueWVvZmd1MHc1UkpGbEQ5WGU3M3RC?=
 =?utf-8?B?bURFWE1GNnJMVFVOeC9xR2IrYzhaU0tQcitCMVBvZ29pTGRXbkZ3a1J4MkdN?=
 =?utf-8?B?Wnd3dnhYbTRGdjF4S0Z6eWRnOGZoQUd3b3Q2YkVTUklROXhnQlJaMDF1UTgy?=
 =?utf-8?B?SUN4YXI0ckhqdEhqdG9XN1J0Vk1aV1prM0ZiNHhua0hxWVNjZTFSamEvMTF6?=
 =?utf-8?B?NG9oTll6NTZoQjF3QkxZRzNrM0pXRmlkT2hMUjlRQnFpbkdMUVNIRkFoNVhI?=
 =?utf-8?B?b2JDQjUvSTBPOFhyRFQrZVVYREtIV3I3WlpPN0pzT3dabGt0LzZ1a0dLaXNm?=
 =?utf-8?B?bml3ZkZ6UGJjR09DRXRwc1lKMy9DWnlSNkwxZTFmeG1adTNXYjBtTWVHNm91?=
 =?utf-8?B?ZHRzR0lRVUNlalBhU3BpYnNjWFZQeGNrKzJnQi9ON085c1lWSzRXYmpnTTA5?=
 =?utf-8?B?eURSaU5MWWV2bmE2TFNpOVd1eGNYZHY5bXBWYXkrM2ZRNm9nOUZFNVBtb0tX?=
 =?utf-8?B?RXJmUXU2bUd0R2ZGNWFmU0NwK3hpZFhpOGs5SlNJRlZMekljT1Y4cVRrckNT?=
 =?utf-8?B?VW5PN3RYSDl2SmZGNWxFQ2NwdytXZDVIM3l5SGpEVmVXQjJkZUo0TVk5SkFX?=
 =?utf-8?B?UU83Qk81QnZOUmJPd3NsOVM1N1lRNy8wNmp1dWpwS0lQek9kVDRxdndBTjlt?=
 =?utf-8?B?bHNUN2RablZpcnRqeXBEa1kvVUliRnJLam1YNS9ib0FuYVRESEt6YWZTVVN2?=
 =?utf-8?B?WVZBUWI0d2ZWVDlFQ2NEWndVbG5ONTVYNU5LeVplejdaNDhWWlVtYXc0NnJS?=
 =?utf-8?B?YkhRMGJLa1pud25ERDZGQW1YM21KYSswVGtkOFVpZ0hSeUtreTF2TGNZclJH?=
 =?utf-8?B?WG5MN3RIRlpVUDUycEttLzI2Y3ZGU0J2c3lZbEQ5UHFEVm5HTUZaMnA4Zm9X?=
 =?utf-8?B?KzYxa0R4ZnNxRmQ0VnJpcTIwbHZtT2czY2x0RG05NDdoTzU0WUxoc1JZeWpm?=
 =?utf-8?B?cnJuNEYrMVpKcjU4dkVtSzk2dy9ENXVMYkppVzBXTjRRVXp6blBJYjBvazhT?=
 =?utf-8?B?Z0tENzVpa2U0Z1VndDhBYStQaWMwc0VrVHdOSUJTa1NJRW9aNW1WdmpHam96?=
 =?utf-8?B?RmJFY1E0WEw5bGFBM1AxWEZjZ1dYLzdmdlY2ZVpIVGxNdFB1UmV4amRkemRO?=
 =?utf-8?B?ZXhQRkNPbWVkRGdOL2svNjRsczhaVWxoRUU4YlYvSUt5eTIxMFA5cTRSbWM2?=
 =?utf-8?B?SzRDOUdaTnQycXg0V2NTdXgvOWNnc1BWMFRub2ZUNkZUQnQ5dDdTKzZmbGsr?=
 =?utf-8?B?N2kwL2htZXliRFNlV1lxdUtQMXlsRnFjQmppZm5zeUtxZDhWdzB4aDVEdE1L?=
 =?utf-8?B?dXpha2JJNGxlY1NyTVBmTVJ1dHVLMFdjaEUrREl6MU1LenNGdVNGTmhUYWUr?=
 =?utf-8?B?QVhRZUxxN0x5VjFJc0Q0TkpIdGl3MkUvTk94T1BndDlJT3JwZ0NjSDBodHBB?=
 =?utf-8?B?b3dSVHdvd0tPbWpqN3hZSnNUTkZUT1ZRb1ZrQ0Z1aThpSmdSa1piY1YwaDQx?=
 =?utf-8?B?YmJsQjJhRkZvMnFwb25pdjV3d1E0bDc5U2dmbFR6QVdTWnp3U0NVc25NQW9v?=
 =?utf-8?B?NktKK1ZOcUJFQjhLWlIvSlJQUzhFUERHUFA2M2lVaTBKbldHSzV5TDlYU2Uz?=
 =?utf-8?B?SGJCWkNpQUdxeFQwN0JSTHZSY3g3Y1lJNnFvQVlzY0p2WklFMzZua29UajBB?=
 =?utf-8?B?c0hBaXNwd0JpNVdOcmNJZjd1UVhlK3VrUjNjZG9zRUJzbzQwakNDS05weHI5?=
 =?utf-8?B?YWFjckpDMFZGYnVYZlptSGZ2QmY3MkhxSEVwMUREU29CQXVObmF4YVVoMHRW?=
 =?utf-8?B?NFkxblBOcnlIM0FNZEVVS3F5dk9lSWFSMnovUExhT3dUSFVqbHpOdXhNVVIz?=
 =?utf-8?B?cDl6UjhES3Q3VWpNdGcxV0FSdlR5REVCV05uLzBHSHI1OFFZNk44QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094774f3-b371-4e86-6d49-08de6aee520b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 10:54:54.3684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2BROelwXU/hJK5wMObcCLxLm9kJdAMiV+tRx4ArYuP87lW5ZJhbzSR3W16ZVY4aJxYejjliImcCjzcIQN5GKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMyBGZWJydWFyeSAyMDI2IDEwOjE5DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUt
DQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5pY29s
aW4NCj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52
aWRpYS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGph
bkBudmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0
aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNC8yNF0gYmFja2VuZHMvaW9tbXVmZDogSW50
cm9kdWNlDQo+IGlvbW11ZmRfYmFja2VuZF92aW9tbXVfbW1hcA0KPiANCj4gRXh0ZXJuYWwgZW1h
aWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBP
biAyLzYvMjYgMzo0OCBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBGcm9tOiBOaWNv
bGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4NCj4gPiBBZGQgYSBiYWNrZW5kIGhl
bHBlciB0byBtbWFwIGhhcmR3YXJlIE1NSU8gcmVnaW9ucyBleHBvc2VkIHZpYQ0KPiBpb21tdWZk
IGZvcg0KPiA+IGEgdklPTU1VIGluc3RhbmNlLiBUaGlzIGFsbG93cyB1c2VyIHNwYWNlIHRvIGFj
Y2VzcyBIVy1hY2NlbGVyYXRlZCBNTUlPDQo+ID4gcGFnZXMgcHJvdmlkZWQgYnkgdGhlIHZJT01N
VS4NCj4gPg0KPiA+IFRoZSBjYWxsZXIgaXMgcmVzcG9uc2libGUgZm9yIHVubWFwcGluZyB0aGUg
cmV0dXJuZWQgcmVnaW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1
Z2VyQHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2tv
bG90aHVtdGhvQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIGJhY2tlbmRzL2lvbW11ZmQuYyAg
ICAgICB8IDIyICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgYmFja2VuZHMvdHJhY2UtZXZl
bnRzICAgIHwgIDEgKw0KPiA+ICBpbmNsdWRlL3N5c3RlbS9pb21tdWZkLmggfCAgNCArKysrDQo+
ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2JhY2tlbmRzL2lvbW11ZmQuYyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPiA+IGluZGV4IGM2
Yjc5ZGEwZDQuLjllMzA1MDFkMzggMTAwNjQ0DQo+ID4gLS0tIGEvYmFja2VuZHMvaW9tbXVmZC5j
DQo+ID4gKysrIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+ID4gQEAgLTU3OCw2ICs1NzgsMjggQEAg
Ym9vbA0KPiBpb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdfcXVldWUoSU9NTVVGREJhY2tlbmQgKmJl
LCB1aW50MzJfdA0KPiB2aW9tbXVfaWQsDQo+ID4gICAgICByZXR1cm4gdHJ1ZTsNCj4gPiAgfQ0K
PiA+DQo+ID4gKy8qDQo+ID4gKyAqIEhlbHBlciB0byBtbWFwIEhXIE1NSU8gcmVnaW9ucyBleHBv
c2VkIHZpYSBpb21tdWZkIGZvciBhIHZJT01NVQ0KPiBpbnN0YW5jZS4NCj4gPiArICogVGhlIGNh
bGxlciBpcyByZXNwb25zaWJsZSBmb3IgdW5tYXBwaW5nIHRoZSBtYXBwZWQgcmVnaW9uLg0KPiA+
ICsgKi8NCj4gPiArYm9vbCBpb21tdWZkX2JhY2tlbmRfdmlvbW11X21tYXAoSU9NTVVGREJhY2tl
bmQgKmJlLCB1aW50MzJfdA0KPiB2aW9tbXVfaWQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQ2NF90IHNpemUsIG9mZl90IG9mZnNldCwgdm9pZCAqKm91dF9wdHIs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4g
TG9va2luZyBhdCB0aGlzIGFnYWluLCB0aGVyZSBpcyBub3RoaW5nIHJlYWxseSByZWxhdGVkIHRv
IGlvbW11ZmQuIFRoaXMNCj4gY291bGQgc2ltcGx5IGVuZCB1cCBhcyBhIHN0YXRpYyBoZWxwZXIg
aW4gdGVncmEyNDEtY21kcXYuYw0KDQpJIGhhZCB0aGF0IHRob3VnaHQgYXMgd2VsbC4gSG93ZXZl
ciwgdGhpcyBvcGVyYXRlcyBvbiB0aGUNCklPTU1VRkRCYWNrZW5kIGZkIGFuZCBpcyBub3QgdGVn
cmEgc3BlY2lmaWMuIEl0IHBlcmZvcm1zDQphbiBtbWFwIG9uIHRoZSBiYWNrZW5kIGZkIGFzc29j
aWF0ZWQgd2l0aCBhIHZJT01NVSBpbnN0YW5jZSwNCndoaWNoIGNvdWxkIHBvdGVudGlhbGx5IGJl
IHJldXNlZCBieSBvdGhlcnMuDQoNCktlZXBpbmcgaXQgaW4gYmFja2VuZHMvaW9tbXVmZC5jIGFs
c28gY2VudHJhbGl6ZXMgZmQgcmVsYXRlZA0Kb3BlcmF0aW9ucyAoaW5jbHVkaW5nIHRyYWNpbmcp
IGZvciB0aGUgSU9NTVVGRCBiYWNrZW5kLg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCj4gPiArew0K
PiA+ICsgICAgZ19hc3NlcnQodmlvbW11X2lkKTsNCj4gPiArICAgIGdfYXNzZXJ0KG91dF9wdHIp
Ow0KPiA+ICsNCj4gPiArICAgICpvdXRfcHRyID0gbW1hcChOVUxMLCBzaXplLCBQUk9UX1JFQUQg
fCBQUk9UX1dSSVRFLCBNQVBfU0hBUkVELA0KPiBiZS0+ZmQsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICBvZmZzZXQpOw0KPiA+ICsgICAgdHJhY2VfaW9tbXVmZF9iYWNrZW5kX3Zpb21tdV9tbWFw
KGJlLT5mZCwgdmlvbW11X2lkLCBzaXplLA0KPiBvZmZzZXQpOw0KPiA+ICsgICAgaWYgKCpvdXRf
cHRyID09IE1BUF9GQUlMRUQpIHsNCj4gPiArICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAs
IGVycm5vLCAiSU9NTVVGRCB2SU9NTVUgbW1hcCBmYWlsZWQiKTsNCj4gPiArICAgICAgICByZXR1
cm4gZmFsc2U7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgcmV0dXJuIHRydWU7DQo+ID4g
K30NCj4gPiArDQo+ID4gIGJvb2wNCj4gaG9zdF9pb21tdV9kZXZpY2VfaW9tbXVmZF9hdHRhY2hf
aHdwdChIb3N0SU9NTVVEZXZpY2VJT01NVUZEDQo+ICppZGV2LA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgaHdwdF9pZCwgRXJyb3IgKipl
cnJwKQ0KPiA+ICB7DQo+ID4gZGlmZiAtLWdpdCBhL2JhY2tlbmRzL3RyYWNlLWV2ZW50cyBiL2Jh
Y2tlbmRzL3RyYWNlLWV2ZW50cw0KPiA+IGluZGV4IDNlNzAzMzg3NTAuLmY4MjRhOGQxOTcgMTAw
NjQ0DQo+ID4gLS0tIGEvYmFja2VuZHMvdHJhY2UtZXZlbnRzDQo+ID4gKysrIGIvYmFja2VuZHMv
dHJhY2UtZXZlbnRzDQo+ID4gQEAgLTI1LDYgKzI1LDcgQEAgaW9tbXVmZF9iYWNrZW5kX2FsbG9j
X3Zpb21tdShpbnQgaW9tbXVmZCwNCj4gdWludDMyX3QgZGV2X2lkLCB1aW50MzJfdCB0eXBlLCB1
aW50MzINCj4gPiAgaW9tbXVmZF9iYWNrZW5kX2FsbG9jX3ZkZXYoaW50IGlvbW11ZmQsIHVpbnQz
Ml90IGRldl9pZCwgdWludDMyX3QNCj4gdmlvbW11X2lkLCB1aW50NjRfdCB2aXJ0X2lkLCB1aW50
MzJfdCB2ZGV2X2lkLCBpbnQgcmV0KSAiIGlvbW11ZmQ9JWQNCj4gZGV2X2lkPSV1IHZpb21tdV9p
ZD0ldSB2aXJ0X2lkPTB4JSJQUkl4NjQiIHZkZXZfaWQ9JXUgKCVkKSINCj4gPiAgaW9tbXVmZF92
aW9tbXVfYWxsb2NfZXZlbnRxKGludCBpb21tdWZkLCB1aW50MzJfdCB2aW9tbXVfaWQsDQo+IHVp
bnQzMl90IHR5cGUsIHVpbnQzMl90IHZldmVudHFfaWQsIHVpbnQzMl90IHZldmVudHFfZmQsIGlu
dCByZXQpICINCj4gaW9tbXVmZD0lZCB2aW9tbXVfaWQ9JXUgdHlwZT0ldSB2ZXZlbnRxX2lkPSV1
IHZldmVudHFfZmQ9JXUgKCVkKSINCj4gPiAgaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2h3X3F1ZXVl
KGludCBpb21tdWZkLCB1aW50MzJfdCB2aW9tbXVfaWQsDQo+IHVpbnQzMl90IHF1ZXVlX3R5cGUs
IHVpbnQzMl90IGluZGV4LCB1aW50NjRfdCBhZGRyLCB1aW50NjRfdCBzaXplLCB1aW50MzJfdA0K
PiBxdWV1ZV9pZCwgaW50IHJldCkgIiBpb21tdWZkPSVkIHZpb21tdV9pZD0ldSBxdWV1ZV90eXBl
PSV1IGluZGV4PSV1DQo+IGFkZHI9MHglIlBSSXg2NCIgc2l6ZT0weCUiUFJJeDY0IiBxdWV1ZV9p
ZD0ldSAoJWQpIg0KPiA+ICtpb21tdWZkX2JhY2tlbmRfdmlvbW11X21tYXAoaW50IGlvbW11ZmQs
IHVpbnQzMl90IHZpb21tdV9pZCwNCj4gdWludDY0X3Qgc2l6ZSwgdWludDY0X3Qgb2Zmc2V0KSAi
IGlvbW11ZmQ9JWQgdmlvbW11X2lkPSV1DQo+IHNpemU9MHglIlBSSXg2NCIgb2Zmc2V0PTB4JSJQ
Ukl4NjQNCj4gPg0KPiA+ICAjIGlndm0tY2ZnLmMNCj4gPiAgaWd2bV9yZXNldF9lbnRlcihpbnQg
dHlwZSkgInR5cGU9JXUiDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQu
aCBiL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaA0KPiA+IGluZGV4IGY3MmFkNTQ1ZjguLjg3ZGRj
MzkwNDEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+ID4gKysr
IGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+ID4gQEAgLTExMSw2ICsxMTEsMTAgQEAgYm9v
bA0KPiBpb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdfcXVldWUoSU9NTVVGREJhY2tlbmQgKmJlLCB1
aW50MzJfdA0KPiB2aW9tbXVfaWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQ2NF90IGxlbmd0aCwgdWludDMyX3QgKm91dF9od19xdWV1ZV9pZCwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4gPg0K
PiA+ICtib29sIGlvbW11ZmRfYmFja2VuZF92aW9tbXVfbW1hcChJT01NVUZEQmFja2VuZCAqYmUs
IHVpbnQzMl90DQo+IHZpb21tdV9pZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDY0X3Qgc2l6ZSwgb2ZmX3Qgb2Zmc2V0LCB2b2lkICoqb3V0X3B0ciwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4gPiArDQo+
ID4gIGJvb2wgaW9tbXVmZF9iYWNrZW5kX3NldF9kaXJ0eV90cmFja2luZyhJT01NVUZEQmFja2Vu
ZCAqYmUsDQo+IHVpbnQzMl90IGh3cHRfaWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBib29sIHN0YXJ0LCBFcnJvciAqKmVycnApOw0KPiA+ICBib29sIGlv
bW11ZmRfYmFja2VuZF9nZXRfZGlydHlfYml0bWFwKElPTU1VRkRCYWNrZW5kICpiZSwNCj4gdWlu
dDMyX3QgaHdwdF9pZCwNCg0K

