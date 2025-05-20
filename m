Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17423C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHFj-000189-C0; Tue, 20 May 2025 03:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFh-00017F-Jl
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:05 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFf-000277-Gc
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747725543; x=1779261543;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BCpPV+AOjC+Yp02BmteDrDVL9O2jw6UpVXN4cxr1U18=;
 b=DFYfWcbL6Xnw5IKnFVv1WqnpC38VabJxJHigTobrxlywervzNB9dI8z1
 l92n2/b+xkdetT1uqmvrug0mSbuhxlXilXkyW8rMJAJLOunui6oc2R0Yr
 ImE4gpTD6BSi7OYg4BV3x/n55LTnEtCDV7TwUdwYWzc6bERZXldMfVPvy
 7ycPrRPasA379OwLjyh5rwnNCon1Zeb4SN2li+VIChvwW9YoQz48sNFN/
 Ox3fjsZDoVQL58ODdftD+BLJ9pOeD7QVQkgnvIHnY7Mw7/fCDVM3hRX7/
 bgU61GAVEeRWl6FBl9FwOLIOsCSivawJYQQwalsUnML2RHrzKPNe75nr1 A==;
X-CSE-ConnectionGUID: Xi5zcinVRrSwAyLdt31/lw==
X-CSE-MsgGUID: JgKfXEsUSxyeNJJh46tPEQ==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37190740"
X-MGA-submission: =?us-ascii?q?MDF0/D9EEdoWlzkTFbgaHyQ2kSZJHqU0zd4Jhh?=
 =?us-ascii?q?Cur8yI+HvTjet1W/hgmeg7WokyBp6gAwgM+yKl+ycAw/aHl29Z3hyU3z?=
 =?us-ascii?q?vtzh96ptODwpecuc74iC+GyGnDSRn1b8q16yLnd/bn3ZyVkNaIQmX6Dd?=
 =?us-ascii?q?JFOdv1f+m9EyRRDT893oDHrQ=3D=3D?=
Received: from mail-am6eur05on2046.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([40.107.22.46])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 09:19:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWNt3nPVWTUVUBPL2PHRSCTZ03a6cfJ0O+c0LTFTkHCPMpFy13Sr9uW4Y5aD+4mk4vpYy4+3npmTgmXxGom/FFIFptvPMkkzEWopPRoJsGLd0Pa54c/diZF1onhf/CRJfVpjyFAvXT31C3MkkpXAAnME2VLce3UZZvLwG7gOsY7/8wcRqTrPK6s9Ru4GcVArXVBcee5+hU3bDDFva75wkluzWUh5eZxLzJ5mQ0NmoHHsUz10Ok3V6JfSMQOeHTrtV5GOppEFkTc6K7RYD3NfnCUzdoxscdObxlYrNv/vdI+BIfsEsrUceNa5lEtRhj+6qapFszp/uZrWANEgCUR8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTJH0C6MP6vsCGMwQ1z+JcrsrSrQoSMiTtfxfEYSWQQ=;
 b=sh7EsxqTB0ctRJKv//21qkJ8BJd63pPCBCRc4lWu9+6Ic5O7TIpf0R6OOUlfvuCEkD5ItWAssfiUzZ93L41MzjznYD/39Z2W98RUkiFwoQF2WsMFNHd/SYC2mc18oM/hejI63QJDUfTOG8b+m6XIsonmLf8xcCWz1d0F0OQjUvFxVc+rV7sd1gQxgqDo1MPqtOh0UEw7a4bZ+7kMZXtuf3mr5/+NnvcvesCTrtcui9tpuvoaNyoqMNMoaBn3wW6xNMBImIPMYuofYFs2RpTq3tHaocxWLDfY8TjpjKPvW+kRDaJQtthbIsinG8QJ/3IbjcvpocSgi1bibhoPn9xU2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTJH0C6MP6vsCGMwQ1z+JcrsrSrQoSMiTtfxfEYSWQQ=;
 b=CME804AyMypLMfjxFZe1rj3uQiisFe4GH8hakC/c9zh1de6ZRAa3XyoZHXIMGHrCIT2bSy1d9xVobfhIrEhap+G1DF2K0oyL5QlnkaqGgLiqHWBdKHBZldJTDjwdKyYokcH5va9HoB0VO/rd9Y2U9SAdxCayzXNvZfe2eKcX7GA6bxMkTzk19YdZxisM3fGqCf8TINIm3qCLxb7JWhPU96TyPxqu/9Kt93U8W1SSwtAR8ByNnCVYV0ud/YDWEIwWeOf6z/NeeqYiT++s63RHoAISNd7PFgj89pTca0zaDAVc7qN+qY87n77irnSLGRwtna3GxBqMSQ7olqh0uWhpoA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DUZPR07MB10037.eurprd07.prod.outlook.com (2603:10a6:10:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 07:18:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:18:58 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 06/11] pci: Cache the bus mastering status in the device
Thread-Topic: [PATCH 06/11] pci: Cache the bus mastering status in the device
Thread-Index: AQHbyVd0TYFA8ISTBUaaNvp7dqo5qg==
Date: Tue, 20 May 2025 07:18:58 +0000
Message-ID: <20250520071823.764266-7-clement.mathieu--drif@eviden.com>
References: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DUZPR07MB10037:EE_
x-ms-office365-filtering-correlation-id: 3e96e856-4ffe-41e7-7110-08dd976e969a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BGOhe+sKEGehhwRpXjQn7qW7xtG0VV6ibU0tcCNbwIYS4Ln7ESGdIBCBZL?=
 =?iso-8859-1?Q?Xy39fdX9bpOdLW2nmbO0thMfpM2siLdQ44jZEJNB7+kHON+k+EDEYSWHKd?=
 =?iso-8859-1?Q?9cV9IDMce6DOowe2/sJI2LKQJH1OL7/KEKYtkJ6lQmwNnWu0uX5eW+dWY6?=
 =?iso-8859-1?Q?YruDldDAkLehP8+JlIbdbiCi2QoNRgiSpkwdqht8LfTWWd0R2id7x55tJ6?=
 =?iso-8859-1?Q?Ywk/nl8YxfU30viufEvTdjO6vmhKKStlBpzjqzgwO5YzsvLvT44wOYALft?=
 =?iso-8859-1?Q?4qWkshacljtB8bhCLJg6aD7A/gzAlgZG+8YxwRwBaWoE/Ww/CWNBLsKi7z?=
 =?iso-8859-1?Q?Zq3DJa4zf3arkXI3iteBFeAIouusHiEIEwceWLiQCtY11a0vaUrKGFl1dn?=
 =?iso-8859-1?Q?gIxTazMW7CzSAsQIAveD+oqjDTuUvYdrY3iHQHP3syRL128uAYj+aLi4YJ?=
 =?iso-8859-1?Q?Y5O65v3Ck9qZFufuMZec6oF9tgZxP1maY6Qw6AwCmvWNzbIFygv94kC1dV?=
 =?iso-8859-1?Q?1H5j1aiTJbMihG2alz31JF3+3GFsI8Hg+X32q0P5OABhJFfVDMtXwSK8Ap?=
 =?iso-8859-1?Q?DxsYYa2fvH7uH4uZwSdfuekQXumCmRSxur8JKTscgJ1whP6Jw+xklxc5tu?=
 =?iso-8859-1?Q?X69vRFj+FGGVwSgINZ0w0xsfi1/xTLNh8R45+d7Alr0bmG0biMIuARE+uj?=
 =?iso-8859-1?Q?AOt+uaKXeUy5oP2musizfWEHRJYq/5SHLgki+k1prq3RvJeUb5OJboPvYu?=
 =?iso-8859-1?Q?ip9+L63rygbnfMCAmuGn+VIWf1jIOfmuh1LLd3PEfy+ByuxnM8/uepumQj?=
 =?iso-8859-1?Q?zH2177mYvoZ9HK1+fkXJnZypClqNO1LKD1yP7Bs3+dNBEG87/88NsAR3mS?=
 =?iso-8859-1?Q?oh5flTqqRIel3mMNbHRZeTwH3BNLd1dKQ21070frIEaOOTFRscEohpXBr4?=
 =?iso-8859-1?Q?vkFShQx2nbJTOZAWBveuTW4VgpG5JK/vPZRhIwqkYWyLn+zh4Hs4un//vB?=
 =?iso-8859-1?Q?zwCZcTkqxLXwIYumnU5NWtbt23ssGAehjgBHYWrlCWQFESKSsej85WCjO9?=
 =?iso-8859-1?Q?h/Ij2s05URNBdP/LjlfNALRIL/C5XXNIdjqNYFCPRRGTcAiDkOXpjZH7N6?=
 =?iso-8859-1?Q?PFVdrp5j4ljtr39Pgw2RHRC0uZe3qznsq2Z0FJ3W8F0+DCc7w0ZvWKUHwi?=
 =?iso-8859-1?Q?386BCOkukGyurJZUeUyUor+cxmO7a5Ku7VXVF784gdxT8UWqbo68KsuwJD?=
 =?iso-8859-1?Q?uMvS/OUjydqGAWX+ql+nBvyY6tiZU083K5alQze9ScbPMDpsKl0y1r7r6s?=
 =?iso-8859-1?Q?OolfPoU+tqxa2kTXKX6zxpocqaI7ou6bbCvQPYE54AdO1VKEUJUWAagbda?=
 =?iso-8859-1?Q?LLUCsvHrJr7R3oNvTnIL2xsmYH1bCnxG1CwjC6qfVxcHaJTizYgxzPacpg?=
 =?iso-8859-1?Q?r26Nk/BC2e0rjrQCwkenMaWNyw+9WjMCIetPrFTn5wIeRodUSvm7GKG+Va?=
 =?iso-8859-1?Q?7g79c41n0etbqr76lawhqfHaefLD4L7NoTQdkZPkmCbDCzuQ/n5KaJWVLb?=
 =?iso-8859-1?Q?BhOjeaI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rEIXsjU4lxFTJJOluDXyT5KYJCrJ0j31UE+h/l8VQNCAK2tF0RV2D31vrC?=
 =?iso-8859-1?Q?Apx4qT3yxNyI3iHwRBiM2u1M6lQIiz34mp/7kswGqWZODN9y8eYIrlcm2q?=
 =?iso-8859-1?Q?gZ44+mzJwWtvUY0daOlDBPBeEKQhuoZlAUr7IQztGb1ircPPYCYTrTwvFO?=
 =?iso-8859-1?Q?RBZx7X7zfkz6iu9hFk+lIjhqRTi4EnFFabc7hCn10N5BMf++yJkHkINQms?=
 =?iso-8859-1?Q?kf07rD36jiRlt0iZw0FaHoOQ5IZZnpjdiHvAd9XNdwPi33BVdBpomnEJFJ?=
 =?iso-8859-1?Q?gZWhj4n3pVE1YHN4RiWcyPyh0qu3aU5eYscwBczhA1vnNFBBMVqNlg6a7M?=
 =?iso-8859-1?Q?BaYvBeNT7zLOMIeGz1t1Q2uHzJuJyPQUFhD+1aBBUDXQvJbnl+yZPZHcIa?=
 =?iso-8859-1?Q?QIP/IwnYrB5tR4ypJREwO6Alw5bfuabgb4Chil/IcdQZaEVpYQos7V5H+U?=
 =?iso-8859-1?Q?OnVzNzA1r5pNMDYbG5jIHuYydWrgo881h3wOpV50SckxKzugcJ3UH/Bw/4?=
 =?iso-8859-1?Q?vSNBLxsMnEEf+SFTa52MNyeTL5hZRTZ8X2erWlzLWKgKDadIkbbBzmsTEg?=
 =?iso-8859-1?Q?6ygD/4poJTeSW4TduY/AU0S1rMfujsGh+3SNJ7Jew5mSGh7IJ3b026ocsd?=
 =?iso-8859-1?Q?GHjtbT/T+NqNwk+fGdAboh65KpeWddv9Ez15E4IMBPZHJpyiGwCjLxU4Q0?=
 =?iso-8859-1?Q?66RXccpG6QkchlvsjQ1/+8Fp/V8ZzgMj8ZhNYxqDxnNEgR73XgxJxwy8EO?=
 =?iso-8859-1?Q?uGinFvlsOyXKxQEpKBhJHkFjYBkxP3US5ndcKQNqhKfcuyGHAQWM0rbNMw?=
 =?iso-8859-1?Q?fklVoOhCY+U2SitU80EmVXjAZTA9lvO/Fo7wPKvRS0FXVGfRe2ic5jLI+c?=
 =?iso-8859-1?Q?mLB43mG0/ss00hEnc0048Xs8R6dCBH4orCTCSWVCVRLEv/w/FKNfl6S50U?=
 =?iso-8859-1?Q?l2wOcSc8UNNEGSgueIOS6odsxT7jvfeRc5zEv07UQIzDCiiQ7vXcHoFjz0?=
 =?iso-8859-1?Q?u5CzJfIoi1aFCpmy+wetGPFvsLUy3elAZErL+hn5M354NhSp+UFULHS60I?=
 =?iso-8859-1?Q?E4sV5GJx+FSNVYW4v4TwSfieZBisrG3zNwuqfjQ6bPUZeJV1fEJt3bYTIk?=
 =?iso-8859-1?Q?/v+w3hiERNG+0yLSWnASTzi/ZAtRQCs16wz6eH2Wf/6K9Lf2Oocji1c+sB?=
 =?iso-8859-1?Q?vmlCPnpq/aDabABn0r+KKULCR3NvW/JLJNQ74LlR45N8GN+3wQa0f39mEc?=
 =?iso-8859-1?Q?fJ4E7DUwDrPcY5YzNBWy8gguvAuZdQD508CnuySR4Fqu5hb4/4j+HQfcx4?=
 =?iso-8859-1?Q?6Ss8fffdNTB42mpFmH3Pb0htfDnpMeyqBz3NSU5b/SrW3NdOaJvt+F8zyR?=
 =?iso-8859-1?Q?jNhy8eU503BfYU9/3UVZ+S4lPWRD1ncnontGQ125+hp5303JBvVWeBEN06?=
 =?iso-8859-1?Q?Ym0lG+xSoQ3S6jTr2I0dHH/wP1Ofa3Yrbk74zV4Dq/PY8lFQoGrr4lZjjL?=
 =?iso-8859-1?Q?w9uG4zQrIHk/JFcXPp6cG8/ulmoc0kIvHz9LaUqwrCsVqCQru5VMz1tyuG?=
 =?iso-8859-1?Q?42siH64b80OdOYA6Q37dPyZTu++pXbEMt9fUAZBf4LyM/D760wPO8MnBji?=
 =?iso-8859-1?Q?/m1ejQ/LLbEgpLBjkl1Tn6pAxCUnW16CQXT6ba69jJu6mX4iH8RkOD23VU?=
 =?iso-8859-1?Q?zoTM3BEP0M+YHjmmQZg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e96e856-4ffe-41e7-7110-08dd976e969a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:18:58.5352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7R54LogKjAGLZttseliIRL3niTmJdD/gjNL+bnqU+lW+Jj+vv4ZG21TrHIfXPexWlM9u3kSdNONtpi5Ndq2pbuwinKbJH1HTfCtkfUGXCtU2JFeU5BMK/zMK8Tv+KVn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB10037
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

The cached is_master value is necessary to know if a device is
allowed to issue ATS/PRI requests or not as these operations do not go
through the master_enable memory region.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c                | 23 +++++++++++++----------
 include/hw/pci/pci_device.h |  1 +
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index f5ab510697..1114ba8529 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -128,6 +128,12 @@ static GSequence *pci_acpi_index_list(void)
     return used_acpi_index_list;
 }
=20
+static void pci_set_master(PCIDevice *d, bool enable)
+{
+    memory_region_set_enabled(&d->bus_master_enable_region, enable);
+    d->is_master =3D enable; /* cache the status */
+}
+
 static void pci_init_bus_master(PCIDevice *pci_dev)
 {
     AddressSpace *dma_as =3D pci_device_iommu_address_space(pci_dev);
@@ -135,7 +141,7 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
     memory_region_init_alias(&pci_dev->bus_master_enable_region,
                              OBJECT(pci_dev), "bus master",
                              dma_as->root, 0, memory_region_size(dma_as->r=
oot));
-    memory_region_set_enabled(&pci_dev->bus_master_enable_region, false);
+    pci_set_master(pci_dev, false);
     memory_region_add_subregion(&pci_dev->bus_master_container_region, 0,
                                 &pci_dev->bus_master_enable_region);
 }
@@ -804,9 +810,8 @@ static int get_pci_config_device(QEMUFile *f, void *pv,=
 size_t size,
         pci_bridge_update_mappings(PCI_BRIDGE(s));
     }
=20
-    memory_region_set_enabled(&s->bus_master_enable_region,
-                              pci_get_word(s->config + PCI_COMMAND)
-                              & PCI_COMMAND_MASTER);
+    pci_set_master(s, pci_get_word(s->config + PCI_COMMAND)
+                      & PCI_COMMAND_MASTER);
=20
     g_free(config);
     return 0;
@@ -1787,9 +1792,8 @@ void pci_default_write_config(PCIDevice *d, uint32_t =
addr, uint32_t val_in, int
=20
     if (ranges_overlap(addr, l, PCI_COMMAND, 2)) {
         pci_update_irq_disabled(d, was_irq_disabled);
-        memory_region_set_enabled(&d->bus_master_enable_region,
-                                  (pci_get_word(d->config + PCI_COMMAND)
-                                   & PCI_COMMAND_MASTER) && d->enabled);
+        pci_set_master(d, (pci_get_word(d->config + PCI_COMMAND) &
+                          PCI_COMMAND_MASTER) && d->enabled);
     }
=20
     msi_write_config(d, addr, val_in, l);
@@ -3100,9 +3104,8 @@ void pci_set_enabled(PCIDevice *d, bool state)
=20
     d->enabled =3D state;
     pci_update_mappings(d);
-    memory_region_set_enabled(&d->bus_master_enable_region,
-                              (pci_get_word(d->config + PCI_COMMAND)
-                               & PCI_COMMAND_MASTER) && d->enabled);
+    pci_set_master(d, (pci_get_word(d->config + PCI_COMMAND)
+                      & PCI_COMMAND_MASTER) && d->enabled);
     if (qdev_is_realized(&d->qdev)) {
         pci_device_reset(d);
     }
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index e41d95b0b0..eee0338568 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -90,6 +90,7 @@ struct PCIDevice {
     char name[64];
     PCIIORegion io_regions[PCI_NUM_REGIONS];
     AddressSpace bus_master_as;
+    bool is_master;
     MemoryRegion bus_master_container_region;
     MemoryRegion bus_master_enable_region;
=20
--=20
2.49.0

