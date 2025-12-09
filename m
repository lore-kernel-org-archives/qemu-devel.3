Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EA5D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 14:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSyZh-0004Em-Dd; Tue, 09 Dec 2025 09:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qti.qualcomm.com>)
 id 1vSx4f-00070i-12
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:44:13 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qti.qualcomm.com>)
 id 1vSx4d-0002gN-9A
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:44:12 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B99NCp73870828
 for <qemu-devel@nongnu.org>; Tue, 9 Dec 2025 12:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=RFhh83PbkyZVIv2QsesYhkRP
 rjOmmCqVeNkPwSUcAuU=; b=etDuzI8Ams3PVL9WhszF1bavLOkydxbMWZYlSQuB
 I5DnGGbSP+xokpeBYrR7ARgzVj/sS9SOX3orzAD8Z3zA3zkJ/U0fLibJ3+h2Bb5H
 +gQliM6ft+IMIJVTz4zhXltLe53reAf8wc0ZIhTCL2B2mZ9zNdDEOKWfU49Xz2IT
 rMCgRorof1QvimJgTDcFMj51cZcLN5eZsqobFnTdMdOEXwHYwIUsW1MHipYR+ldm
 5bVvCWebVy8pD8iD7jfmK8W/LctXqr1zolPJg1OaAMNYm7QDCtknNQd1XDW2ukZX
 ZyU2QWRGAqIxQ/4mQ0Wlm99B00NCGbXFLSjINnHqaX9qAw==
Received: from cy3pr08cu001.outbound.protection.outlook.com
 (mail-cy3pr08cu00100.outbound.protection.outlook.com [40.93.6.104])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axgs9rmp5-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:44:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RR/KT6DKo7OsRkhYahh6yvRxm4BXrSRJjOU/WP5kV1/bpjdDGUMeLEAJkHAx3+NMAx5yJQkQUAYKRK4lkbsLAyIHDtqwSCu1+td7NgHf0niYoGFxhnscWd7Fs36/NsUEkh+k08bAZSJTiwAZxZjnlDFHTZrqr0t9eIJkHMrJZ0Cd0dEwt+ZkT5CHVLF3SmWgTVYpd0MksuCvKslB3NfCcpeDR46rCslpZJeCn+w9FL0wopsG6kFG8+8hfZzvM8qPA13tM95W7RcOHcAojpP1Zh/NUmEZKZNcWalh1hpRaLCQyf+Y0bJuHjF9X9ug0ziL7Or8eX21GmLtA3ISnw39RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFhh83PbkyZVIv2QsesYhkRPrjOmmCqVeNkPwSUcAuU=;
 b=rjD+j68dF8zTruQQnrC4cVBv3zxnPnVn2hKwybL8sX5+zEbA7EqjxW5/vTsk22yHOH8Q19GxFer0KyDDi5iyiRNi+RVodVEDsvwRgc7Kq/3g1s1Me2UL1YDr4XXXxNrblmZxBZtG8/9NpCVaZj6NATwQweEqGH/JbKCzroipzHu0zTMnQsKdWip28KrZy5aGD+stRsDC+q1wukrVbYRWr4Z6bigwpvN6X5SGcHJ/3cE8MKX/gxtWp+Hq2EtJYGVelxU/OT9twS2bTe76x9uXv54VplAsFY6pvpec0y7p0KYA78nlk69VkMurqr/yCjI3tooiM71C3nxvZ5MPdtZwaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from PH0PR02MB11150.namprd02.prod.outlook.com
 (2603:10b6:510:376::14) by DS4PR02MB11141.namprd02.prod.outlook.com
 (2603:10b6:8:2e9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Tue, 9 Dec
 2025 12:44:04 +0000
Received: from PH0PR02MB11150.namprd02.prod.outlook.com
 ([fe80::2726:9b60:9e0c:4d5f]) by PH0PR02MB11150.namprd02.prod.outlook.com
 ([fe80::2726:9b60:9e0c:4d5f%6]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 12:44:04 +0000
From: Matheus Bernardino <mathbern@qti.qualcomm.com>
To: Mark Burton <mburton@qti.qualcomm.com>, =?Windows-1252?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>
CC: =?Windows-1252?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,
 Sid Manning <sidneym@quicinc.com>, Brian Cain <bcain@quicinc.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: Record AS in full tlb
Thread-Topic: Record AS in full tlb
Thread-Index: AQHcaPk9a1ehpTIlp0SZwThihBgF4LUZOMalgAACKICAAAXTHg==
Date: Tue, 9 Dec 2025 12:43:39 +0000
Message-ID: <PH0PR02MB1115005280A907E8642FDE2CAF9A3A@PH0PR02MB11150.namprd02.prod.outlook.com>
References: <A5D46F85-9B92-477C-B964-1DCE2A1CCF19@qti.qualcomm.com>
 <87ikefhmxz.fsf@draig.linaro.org>
 <334BDB3C-1F95-4577-8938-1956B24F3670@qti.qualcomm.com>
In-Reply-To: <334BDB3C-1F95-4577-8938-1956B24F3670@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR02MB11150:EE_|DS4PR02MB11141:EE_
x-ms-office365-filtering-correlation-id: 69272fff-779a-4488-279a-08de3720a31d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?PG7Z+w85js8QBWwpuE1U9fy2hgFn36s2wDnI9IoIzCa7nKwqBb93hR4y?=
 =?Windows-1252?Q?RqULkt8s1u/xDzSQO2KB1o4YYQoR57r6x85jzMX1mh6xb1/JZzaYetfw?=
 =?Windows-1252?Q?r0ZDu0d9clVnXl8dXSQ8b7dgxZzqqqkkCqP1Yj4Ra2EVj9TiI/CiSlS3?=
 =?Windows-1252?Q?NOvWbMOfvRSkRG+s2OhRYtfwDgBqhy+blALIWcZW2fvs51+8/yG3zwOA?=
 =?Windows-1252?Q?VrAh6DKK1V8tKwpMhHZWkO8Bx0TAL+SjuwlN88tF//PE0Q9M4pRWdxkv?=
 =?Windows-1252?Q?zsKxUyH/4pufuO8XN9xw9kzSUS4y4mWZGsq8gzfwUykXBtuzZ4d8xKT/?=
 =?Windows-1252?Q?kvRI6uqwnOQyPhxUEBG2VYr2wqgawm3c/Nmpi/zsx2ioZHn6s8vHoV0w?=
 =?Windows-1252?Q?pWNA75ejWM2ZODH6ymiSGR9T5UcOGX2QHxG7YOKSRh72Cwk6cEtZfd0G?=
 =?Windows-1252?Q?pfyBKcxjltq6gSA188HPuTEpSk/MZmg85uirEbdQo39A02LSyyMMZP2L?=
 =?Windows-1252?Q?pwRPFdwlOIAt7xyG+KLvvKinl8fmloQV58N8YyskOgiRi0XD3pF1SLwk?=
 =?Windows-1252?Q?ipiS8zcSSK8ZG1UO98cTXkhuanzB6Ul6pveVfDWmA/x7sslIxs6RCArw?=
 =?Windows-1252?Q?Y70inbinx4C1V4z9z7REhppcT6QSJABSp8t1a+dp2qnnz48j1V9Hg3q4?=
 =?Windows-1252?Q?B+jObs4+7uJ8tP/iP00wui+K6dia/SeBhlDkSJl/i+5EM20iPBq+l4Ul?=
 =?Windows-1252?Q?hSzEd8vMhLhs/pz+xZcMjW4ZRH+TpQfVonNueN9LzeYe0DDNdUGzh1xD?=
 =?Windows-1252?Q?zGXCRzsxEntu7Mff1q8cG8UKKOUDOht6mCmVoNqAp70n83E0m9ycu88P?=
 =?Windows-1252?Q?qMlsvEO3lAp5lf09CoqwxLd2ZDqlb+Vlx2RvtfOtFPQrYfRZvkWUj1xK?=
 =?Windows-1252?Q?1lTKV3XGzczRgcDOpa7FSXCdKGC9F2BCnLAXI2iyC/g2ppndEP/lt2d8?=
 =?Windows-1252?Q?vtMc1xNq+Ar06dfhbPig7eI6/697x9JSZZmu8oUH/nUKtW6WhM5IJ4rO?=
 =?Windows-1252?Q?5hr+wOUYv3VLtGdNLBSBW5F75kHILcE94PZSY/17l7wilDK1O8HXGRgC?=
 =?Windows-1252?Q?Imk6SSK0MFI9PLUtk5rpJxMlOFPfXNh5DHkJ3UKFUg6X5cRgomjKCO+u?=
 =?Windows-1252?Q?+hgdrQp+BX6fZkypH322IXSU3zdWAJZLQd88jhX2xUbUSAWPIUc0Pn4o?=
 =?Windows-1252?Q?hHVxIkxX0LXIehFn8V1k3HRZsEwNFgm0aORbRi35hXP0UpNjeIhaetc0?=
 =?Windows-1252?Q?VHYZWr6HJ3PQSgkGKpruPXjyfqXHaoss7BuqhW/Mbc7OJ8wC9kNbFFRq?=
 =?Windows-1252?Q?e9p/I5yfBzW9M7+gammDSRdobN1MHyzKcP27ha9Fio5Li4oBFD4OCfi3?=
 =?Windows-1252?Q?fDWaEe+XuynE5QlsO95hUS3+U/dLet/JosjGl3Xt3SrjgL8rngJgGkHA?=
 =?Windows-1252?Q?rK6bs2oEdl2hY1k/HEX5SCIiW+bH3Cx63hIw4f+OzQ1KqhtTUw116jzC?=
 =?Windows-1252?Q?ob5pgtZGBv5RHJiDgkE7HNjRe6C3wgxm3t1BR1kf4l/OCc7cI/VU60k5?=
 =?Windows-1252?Q?f90gzpBPY8Qf13mFkBsJC59U?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB11150.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?p1TSNGzCesJt1pRbmrKF3BVh5DIB1X8n6uhATGlotCah2C9m3w5urC3C?=
 =?Windows-1252?Q?JB43dhGpsWgqf63+SjLFs0amIx3STBC+LZOeZO+1HAxWQJxlaCy5Hd1K?=
 =?Windows-1252?Q?1daIx2Mkqvk11I+/9NcqjOU0O0hd6/cIrcuXB96fOVQKFvadaaZqh8l0?=
 =?Windows-1252?Q?gYB8DlgPyDSIKCy3YxpcKMh1rnt5vJqeQbbe3HY9dOEdB6FgheOr6Ckf?=
 =?Windows-1252?Q?mWXPSSI1ik8xiVEbcr23Xrn5tI5mOCSMnCIPgDQWYxNPtQTfD2dvQzGZ?=
 =?Windows-1252?Q?gkcB469JykuhYcbVeWRGMRGlDBvL+xTDD5965dOGrhXyrthTqmPIISh1?=
 =?Windows-1252?Q?Swu72EL1/qVhnlcYGrjo8+FHSdunTtLBvdVysvYDLBzMMcPqJLFwS9bd?=
 =?Windows-1252?Q?UPt5i/8FeKWOIQkISQK0nplSXxBlxaOGXbd1Tcp7jVn2/vpA6kO7/HIZ?=
 =?Windows-1252?Q?k5OIHC9/j4dHvRYbpr57qDGSS4XQrCBs6SMNtITO1craVhXNoJyi/EGg?=
 =?Windows-1252?Q?pMD2BSrtIxwQZ65s5mEzIFvlKQO8SCZDEj8quyvu26oBdFrhhwT8cv9n?=
 =?Windows-1252?Q?UyrD9goNwNEW0EcIg28OHa2jO64c/iCnza6R4l0UabnJLqp4GYfSxGo9?=
 =?Windows-1252?Q?kCkQGf1psJGqHFJqxACq0DXZhcd02UaAGiLT1wo8j2r1YjzK12zOOLPZ?=
 =?Windows-1252?Q?ah6A118vChiGq8MvzxWfoDubeNDcjPpa3NDeS+bMY7DcuI0W2zTd8yhk?=
 =?Windows-1252?Q?9Y/qWKiGikpWfE1uTvAClCQozqpUGyiGHyHI1+ge0SGxKcpSmbewCqmB?=
 =?Windows-1252?Q?sfcImjFuBVH6TMyheF6ctkGPtm4R01zG0qaRy9HGjXI/Z6/OBaZ0bGaQ?=
 =?Windows-1252?Q?alFou08Q9CSkgR+zPdqdb/22cXm5a1b2nQLePdcl4vdW6l1CB+Ax164n?=
 =?Windows-1252?Q?EPRth2S4RBtslU+DZJtwI+Ah1+G68QminSkbkcggk0QtsbJzsVO/wLWW?=
 =?Windows-1252?Q?XacH1/Jqvt9bbqmTbUzik/U02gug86v3HHBlXnq6DWLp6zd9IbiYOrCS?=
 =?Windows-1252?Q?d1+k3sxxibO9aeT5ulpgZYJUI6FoBbsHBF+Bu7kRKxSj14CAeuBGZ2y4?=
 =?Windows-1252?Q?Sbe9jOJDaLxoyEav1zhaxAMTXuN1bJS3bch38A4pVXWOuLIKRCXagDAp?=
 =?Windows-1252?Q?ZcsBUngWOrDtKNTnGhZq/CFdT5IEaAGnlic+LB9mGx9VVWccCz1hUjxw?=
 =?Windows-1252?Q?+iU+sd+uDtfWe2/9Vdk6kI1iiO4hpFkzaJnokefxiWz2aolGHnmX0a1H?=
 =?Windows-1252?Q?gmY4vBtlvS7qZfhfy0Xk6n+lKw3P0RfZfnHzNJNBfwcRiQK9ByVmxr7b?=
 =?Windows-1252?Q?89Bv8L+nw4Rrim6VIZjaNvSEMwO6L83tP1+Enb+Iahp1pYDkY3m7lVNg?=
 =?Windows-1252?Q?zuAY8McuJakDqz19HTF7RkKJmsa0/o21mudsuFp6Siu5M4Pg6gItAZNv?=
 =?Windows-1252?Q?ZdxlGuzHlMKuz6nLZCP0pYmZ0dqLrIs2VZBn0j2m3PewiYWPqTdSfR+3?=
 =?Windows-1252?Q?uxRPqXaFLoX5S5R2BkcQ0enmT2ReUo9oVPxzZgfHFkPE1SS4rdjKy9ca?=
 =?Windows-1252?Q?0l1BSiFFatrXsCXFK/feMz8PEPPacY6iAKW3T7qqPtQbvkgiIz2yEafQ?=
 =?Windows-1252?Q?ADdeES91jViYgf4W7wxO6mUOBw27GTcMsEpXoSKzhlQWa6yW88LLWw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR02MB1115005280A907E8642FDE2CAF9A3APH0PR02MB11150na_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PAVeUW3uge/T3vRRMIMg4x4d9wDDoNBv4pJvALw8L6O9FHrgI3TFGYtJawFH356I7g5l3AygwtIWTwwkmlVNTQ/LIwVlT3DUNpTdMUkwq1LO0FBoo6AbtOIPkElPXZuTrrkfHwatPRXSI3HoRv2FED3SUaam8DGx2rFxEr7sFUaRT+VOZA/Xij8OWpPNUGisOa1OnNarewZ/CwUSq+Ip8cX+0qjuKlIpg6iJqUl4AC8S5sHvIjgsCLQ5+Kn5JIFAalydP3rCtUdt/d3eJj2giAdCgvqj+oOhPMbcOV5uTR4XtntQYNyjr8mMD/UA2XqjzXeKpNJi2qrthg6AXPwugKAnErK7sDhWBp2p/UkgvmU7oK9qoxt2Qzb0WxETSuQZj06zyaMOzT06c3fE6fQMhv+1hdFJxA67gPr6p6JJeL5q8tHtURqy0hi8v+uZlXr41ZujLxQiTJyRTg/bD/OWjSDBmxsWg1qRnzTwQEkwmww336b/lCeJmlOTCcmqcqbflSaVKfmcnEhFrT8DOPmBI32UTHnS1jHHOojSU8kwXfWbu4Eb52yjA/f8GHEBRBpEaTyfL3IWryESbXp1PTQ01apVp0XVwtrBSaAjDAb1dZhJ2SVGYZdmSolMbK34H+PT
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB11150.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69272fff-779a-4488-279a-08de3720a31d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 12:44:04.7620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+XcFO35Vo7XwiZozngtebuSg7ilFQ8sqh1gQJDFnw6w4Tn/1A5Fk/bkRb4H1o/nI83FBtcSKNvHP8p4n/AZ/lblg1ubmE0NZAltucZLIMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR02MB11141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA5MiBTYWx0ZWRfXzGp+gDfB4pwm
 Hz28yD8vYyYgBXAozRuOD0qkQVgQwGG+nHxfdMsw1J3P5z+tTlx1exWJlBjDcv58PPd1dzydbsU
 CiSj8lWL6oaur9pb8/tjC11aAUQiUikPGEvDeYBWgXd3k/PASF5IYdJw8Cfer402p2HWGQGvYpZ
 +ITxkFMZtCBYiyjOc0sFY4fasz81S4NiPlzcu6POHSsb5aJ0GCuMRWQymlGcfTr7H05KStk4tF9
 2akbgJIRKf9fg9L2UDRilG4+Eu01ba5V2ZgHUHkgmEK9qTtKcZ4O2DNUSacmsh81iv2j7WQzxw+
 1HBMg159t1LsiG66Wa6lr9RXLghFQbbkyo3KCxYSq6LX5g3l44T/2ypP8DGDycvuvfAXo737U1z
 nfQ1eycmlrhl74nwNDlIsds01h4G3A==
X-Authority-Analysis: v=2.4 cv=ArzjHe9P c=1 sm=1 tr=0 ts=69381997 cx=c_pps
 a=ETN6ulabYCoNbUlQWP244g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OwJs9nohIi3sW0aeKYAA:9
 a=pILNOxqGKmIA:10 a=KLdPnh5kA2m1__VL-xMA:9 a=2tpc9bkwIxUM7MLa:21
 a=_W_S_7VecoQA:10
X-Proofpoint-GUID: -NcOg221HhauWsvL-aD_6asHDTwT2xU_
X-Proofpoint-ORIG-GUID: -NcOg221HhauWsvL-aD_6asHDTwT2xU_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1011 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mathbern@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Dec 2025 09:20:19 -0500
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

--_000_PH0PR02MB1115005280A907E8642FDE2CAF9A3APH0PR02MB11150na_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Dec 2025 12:22:09 +0000 Mark Burton <mburton@qti.qualcomm.com> wr=
ote:
>
> Also turns out that we have a very similar issue (though not exactly the
> same, and unfortunately doesn=92t get fixed by this patch)
>
> If an instruction is going to do multiple accesses to memory - (something
> that sets an area of memory to zero, or a DMA or=85.) typically we probe =
it, if
> that fails, go ahead and do the access using MMIO. If (by chance) we then=
 get
> a Memory region added, lots of bad stuff happens.

FWIW, this exposed a bug downstream, for which the following workaround was
temporary applied:

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b09229dae8..90011e5671 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2529,4 +2529,5 @@ static uint64_t int_st_mmio_leN(CPUState *cpu, CPUTLB=
EntryFull *full,
                                 MemoryRegion *mr, hwaddr mr_offset)
 {
+    vaddr orig_vaddr =3D addr;
     do {
         MemOp this_mop;
@@ -2570,5 +2571,6 @@ static uint64_t int_st_mmio_leN(CPUState *cpu, CPUTLB=
EntryFull *full,
         }
         if (this_size =3D=3D 8) {
-            return 0;
+            val_le =3D 0;
+            break;
         }

@@ -2579,4 +2581,9 @@ static uint64_t int_st_mmio_leN(CPUState *cpu, CPUTLB=
EntryFull *full,
     } while (size);

+    if (!memory_region_get_iommu(mr)) {
+        tlb_set_page(cpu, orig_vaddr, cpu_get_phys_page_debug(cpu, orig_va=
ddr),
+                     PAGE_READ | PAGE_WRITE, mmu_idx, TARGET_PAGE_SIZE);
+    }
+
     return val_le;
 }
--- 8< ---

> One could expect many things  - there used to be a cache which hid this i=
ssue
> - you could also expect memory regions to be added only =91outside=92 of =
an
> instruction execution block - or you could expect that adding a memory re=
gion
> shouldn=92t break the MMIO access, or =85..

The cache Mark has mentioned here is `cpuas->memory_dispatch`, which was
removed at 2865bf1c57 (system/physmem: fix use-after-free with dispatch,
2025-07-24).

--_000_PH0PR02MB1115005280A907E8642FDE2CAF9A3APH0PR02MB11150na_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<div dir=3D"ltr" style=3D"font-family: Aptos, Arial, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
On Tue, 9 Dec 2025 12:22:09 +0000 Mark Burton &lt;mburton@qti.qualcomm.com&=
gt; wrote:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&gt;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&gt; Also turns out that we have a very similar issue (though not exactly t=
he</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&gt; same, and unfortunately doesn=92t get fixed by this patch)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&gt;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&gt; If an instruction is going to do multiple accesses to memory - (someth=
ing</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&gt; that sets an area of memory to zero, or a DMA or=85.) typically we pro=
be it, if</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&gt; that fails, go ahead and do the access using MMIO. If (by chance) we t=
hen get</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&gt; a Memory region added, lots of bad stuff happens.</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Arial, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
FWIW, this exposed a bug downstream, for which the following workaround was=
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
temporary applied:</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Arial, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
index b09229dae8..90011e5671 100644</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
--- a/accel/tcg/cputlb.c</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
+++ b/accel/tcg/cputlb.c</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
@@ -2529,4 +2529,5 @@ static uint64_t int_st_mmio_leN(CPUState *cpu, CPUTLB=
EntryFull *full,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;MemoryRegion *mr, hwaddr mr_offs=
et)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&nbsp;{</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp;vaddr orig_vaddr =3D addr;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;do {</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;MemOp this_mop;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
@@ -2570,5 +2571,6 @@ static uint64_t int_st_mmio_leN(CPUState *cpu, CPUTLB=
EntryFull *full,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (this_size =3D=3D 8) {</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return 0;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;val_le =3D 0;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Arial, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
@@ -2579,4 +2581,9 @@ static uint64_t int_st_mmio_leN(CPUState *cpu, CPUTLB=
EntryFull *full,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;} while (size);</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Arial, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp;if (!memory_region_get_iommu(mr)) {</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp;tlb_set_page(cpu, orig_vaddr, cpu_get_phys_pag=
e_debug(cpu, orig_vaddr),</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PAG=
E_READ | PAGE_WRITE, mmu_idx, TARGET_PAGE_SIZE);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp;}</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;return val_le;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&nbsp;}</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
--- 8&lt; ---</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Arial, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&gt; One could expect many things &nbsp;- there used to be a cache which hi=
d this issue</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&gt; - you could also expect memory regions to be added only =91outside=92 =
of an</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&gt; instruction execution block - or you could expect that adding a memory=
 region</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
&gt; shouldn=92t break the MMIO access, or =85..</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Arial, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
The cache Mark has mentioned here is `cpuas-&gt;memory_dispatch`, which was=
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
removed at 2865bf1c57 (system/physmem: fix use-after-free with dispatch,</d=
iv>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
11pt;"><span style=3D"color: rgb(0, 0, 0);">2025-07-24).</span><br>
</div>
<div id=3D"mail-editor-reference-message-container" dir=3D"ltr" style=3D"co=
lor: inherit; background-color: inherit;">
</div>
</body>
</html>

--_000_PH0PR02MB1115005280A907E8642FDE2CAF9A3APH0PR02MB11150na_--

