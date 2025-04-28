Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E308C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 05:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9GoE-0006T0-KX; Mon, 28 Apr 2025 01:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u9Gng-0006SY-Nw
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 01:13:05 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u9Gnc-0003tH-EH
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 01:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1745817180; x=1777353180;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=+Jqp3Du/v4WRCYyWDN7o1AGaQ3lQlZZBNP3HSIUSbp4=;
 b=Di/wZjrejHVWAY5WGVwaR+aZ7Q5uDzS+1Jr3u+mC+/NOGEovffARXFn4
 JcLmILOM8jLNBFpUtK9tzyPLNO7Ai+2fDNb7bd2APkOcCzlxltjYFuWQ3
 5nmDisF7vvufcM02GiA+mj0iPcoRrSDibdDNLGx5XMvPuOih2YuioAa7i
 j/HrfAJl3h22onbCadCrR9Bmk7sKPqi1uTTv/YDxB1hKqwK55ytxwgMNm
 KRmE7bM/gFRr/dL2VUaprENO6qi0YLZ9Gs88PJYXE0McCWW6UfAoV+ete
 yEjpuZRoPTZiOjxL+RN8AGBH9p+VKs51mgpfyRuOEtyV5/Iz6uGG+Sfqi Q==;
X-CSE-ConnectionGUID: wE51QIYZTM+zQGoV6wk9zQ==
X-CSE-MsgGUID: zSYo/9O9Qwa8fCrqKkzwqw==
X-IronPort-AV: E=Sophos;i="6.15,245,1739833200"; d="scan'208";a="37932141"
X-MGA-submission: =?us-ascii?q?MDFJtfuSWmkWEdHgyHNUSLAfvXbWDcbMFpaiuB?=
 =?us-ascii?q?oASqiMoIrU6ptj1mr9T6lJIIwbKg2jHYRvi+qf1gDW/9jZUn3XACC7DN?=
 =?us-ascii?q?UOAE7JkGi3tI5bMMRT1RA9pOvtfIuMNA9ioaUA1jjDC+EnYs6JCY56aA?=
 =?us-ascii?q?JsbKI7P7/l1BN/aqigDPc8yg=3D=3D?=
Received: from mail-northeuropeazlp17013009.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([40.93.64.9])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Apr 2025 07:12:55 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQkyIw08gGyCrZBH1NID31EgsvfTFiFFWI0yVFuxgc3yVoKJWK8B/Chh/L5fVAXtXDhR7c3yKhckgf/7XaXwgSg33hxdZ06P4eR7BnnS316BkKWWliu+rtuxJqnN7VKQiyj4ewACsk3MO/ASP9E2/2UIaWosTO9hhrdmPCL20t2ZtMZV5K7xyaBAM7/NrslmEfi1rDoXvc1ABaSmIstqa/eRQGNzwOozBGb56/0aGbDsf2DvfUbxOan52jhrxdq+7RWXoMJ65/RqQfRMhO3J9Bpwh6j911EONvHX7srHM7iojeoXX/NyBmEq7XX+H3QkKWArVYXVh/r8YATCc05ZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wssVlLneZKPRIeH5tsHKp3ZFQLuvEXwmEGyvYKfA/cU=;
 b=cGJPACO8sFnHBGeNUK54iMGiWUhSD9OkQhFzzqeOhLU2FabZJGGLsRKv3l2F8C829HxqZaIAs7Iz3Ed43ayhDk0qTLmHROapIpQbWHBa9oEkPOH04T0XvgNxi/HKNz9voKUPAJ5x6noHkefbazxiTBw//WLoCsYZ9xtVJyHf6aAObIbgsWUUBR78368pGpXptgqi0MlX9zmnSOI0aI2MmxiKUufGXCnO0StR1GnvOmFFnSUqJCHEIcbJv2WNaIoGySDSti4ZUcnlZxj4Eb85zqUr5ZkTk877csOWWKWFNXq/oXXA3md9Xn4W0B+Bj6YqzLx46Tcqipyns9Vsw7UwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wssVlLneZKPRIeH5tsHKp3ZFQLuvEXwmEGyvYKfA/cU=;
 b=oc9BkYN41iPmvDvGkLXYSZKzs1P0TpeFVfjz4/9XRYCgbV9YZVo4sTjls8N/AqoHpA8Z/W+rBZlNwe2G6aJuOhNwSRqgp482Mtf4l60i+77Fx0RQBXJO63rW6+oIM+l8c/nIu4lsCnySr3Rj9S50Vz8V2tq/hstWD1hCjWI+/Yw3ys6tJSKLr/6cjPxYj8sm4E+xsQGb110QbJ6BYZqF5F7vvAdfe6/UFnSbkHR53Pq4lxGwBMhj6dF2atUzb391cgRZofYwZ5/WQMfxryRfl3U/krQakDhDR391n7t9uBrxfRVKl+z7+1U2CSoIZ6JR2BdJJekKfENM2qscqoruXg==
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com (2603:10a6:102:c0::19)
 by PAVPR07MB9240.eurprd07.prod.outlook.com (2603:10a6:102:315::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 05:12:51 +0000
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393]) by PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 05:12:50 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 0/3] intel_iommu: Fix locking issues
Thread-Topic: [PATCH v4 0/3] intel_iommu: Fix locking issues
Thread-Index: AQHbt/wwc/Oxw2kuZkWnFPGdMqAR/Q==
Date: Mon, 28 Apr 2025 05:12:50 +0000
Message-ID: <20250428051235.10767-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7613:EE_|PAVPR07MB9240:EE_
x-ms-office365-filtering-correlation-id: 1a4acf08-237b-43f6-1c3c-08dd861352d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vK1LPloC1CASC27Ms+1+xwHF1VnSUQLIeybQA5yNlYR7sc2aPCbRAzPWdf?=
 =?iso-8859-1?Q?escasgOuuvTCziUgF6555is7D27FjAY/MCgn5aAWI98ne7jTupBo/YaK2V?=
 =?iso-8859-1?Q?x1Tps5jFVQCxpxMg87tLyQ03zOIddceFpFvE3mxSLo1dDJ0yu+55Jnk6V9?=
 =?iso-8859-1?Q?iCt+QMvyCy3YAdbxahaxcnOohWL++f9zd26vbokJWEkGa3OjZZwmFJVIue?=
 =?iso-8859-1?Q?NZC0qACag456oEHIaKaYrz50NKrh8p7nAlnDMevzWSRgN9J71LdjdK41X4?=
 =?iso-8859-1?Q?5jy9c4bVstwVi5EzNmo5GqMNh3a/Q60oPVh7oSpgHGtHjNmld4rkHPMm+3?=
 =?iso-8859-1?Q?pbGIwbdsDc8wxjAWEOc1qYO3Pyey+TEqv9ZuGHD1jiYRVM7Q1QIep5x4oa?=
 =?iso-8859-1?Q?SoQB3wHxPqZAh9lRR9GNJiLleZFp94mNjKTayVNboK1Tl03XQ+tqHYH63I?=
 =?iso-8859-1?Q?ZwQ8Ek28K1cvrCZg1x0ChlWEFt2X/m+TZpL2+LmHc2NtJ/pnT/wGsWeYv3?=
 =?iso-8859-1?Q?s2leMrcgP6O+cNXggDRNYF0Axvq02lUR5JW18eq1A6mYH6dwbt6WyIf6Jc?=
 =?iso-8859-1?Q?WI9bX+qyMs02fm2V9DcyDTIKGGqAe8bAn4xBcr01Ke4djfry8MbnD8W9Qt?=
 =?iso-8859-1?Q?DwEx/iyhYsqwgDL0ZZ/psh2quY3z61OA6kwcaTLmdDZcMtOC5igYTlBJ/l?=
 =?iso-8859-1?Q?jHdJF8HnA1D8wHbTVePrgNiBJNEP9GeERFE3UhXwY1fIRHEbyp1TazZQ5E?=
 =?iso-8859-1?Q?faQAxbcQ5U2aB3bAlQxRR3eW+OYQo7Eys7DhvKAwLLWFGjP1d5NExcicaj?=
 =?iso-8859-1?Q?e008GoF70tLJEpccFmwquWK7AzV0A0YanaiMjwxXt14yVWMiPQoC+zbYqb?=
 =?iso-8859-1?Q?/HLCf4boOB9FliB/9PUZYn3KajAl4ptJ7EmijMmuFfUejW6XGzufJr69a/?=
 =?iso-8859-1?Q?zyCAeQjYR2ZBcegk1IlVNQYVsHHkP2xTq2Yn6EkYW3tAcFPROSuQE3Yats?=
 =?iso-8859-1?Q?EE033WK6qdr6ahrTaO8j/CAP1gurE2vsycjqSUsTCEiuaztI+kw7hE6pNd?=
 =?iso-8859-1?Q?HmBJY8fKTlKMuY0OGWghUwC7f44fUeG+11WqNddTO91a/MaVgM1HXelPtb?=
 =?iso-8859-1?Q?hO3wU8S17cSEJQKu5X6EyxnYAo9LTqNqFdxtQorURfK0BCanjfVL4wk7xg?=
 =?iso-8859-1?Q?f6wUcoyx+/kzvu9u4PrMXj+UfDvyEUR1RS1g2msesPmyBPqktFhHqedIvI?=
 =?iso-8859-1?Q?EU4ptnl9ug93Mf6UVXjYUQ+RYLWp5b6e/3iM86TAK1CcBWIx4QZloDfQH1?=
 =?iso-8859-1?Q?UuKKV+oGbrz7WAQhV9cxeTzSAMa6vIYReoHDszPCIeFq7rnQ6iuvs2GM5b?=
 =?iso-8859-1?Q?DR9W6i0JIdTtGAYpX738V2f32lKyO/YoHgHdK5W5uNuPpkXIK+zF57sPm4?=
 =?iso-8859-1?Q?vmFKliukKzXuDy9tqMhg5ue0wzWrOE+obB4OsWzc4Ktr4lRrNP/XcJxx94?=
 =?iso-8859-1?Q?v/dNX+uRHZ5jQkdzTzEAmDjiiinzOdMCjR+swX++mtLhi3wHDDeUTBafl+?=
 =?iso-8859-1?Q?Ti3igJA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7613.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cjEAWFUGnSf6A/3dKWM1tzqhtyLgxUsOypPUsYx8uVPI5nJQ6RNDpv3Rzc?=
 =?iso-8859-1?Q?MlutHSfaYt+w8bYvKsP/wIqP45ZsQx3HE4vVhOAw3dv7r+s/myttkI0mb3?=
 =?iso-8859-1?Q?ZrEVIlG5/VMkgZPD50WeGJtVPvS4MLm1OSI51IvpLLFdeOqG1CG9iLHudS?=
 =?iso-8859-1?Q?1aVvurVlgeySrGB03NWBX9JzIclYLwbwnDweGWS200XRu+RQObIBjDiWl2?=
 =?iso-8859-1?Q?rUz4HT9oO/hsrmNm1zS5G4qauHTalbxJ/k4xGuSmKqg/qe1i0LjAgoixgl?=
 =?iso-8859-1?Q?AgRaeo6BA+/ajYXuvNmB6TGrPDAKqf0auP9LYq17UaXaMp269OGzAJwsBL?=
 =?iso-8859-1?Q?S4/BzfIMOaZCRjsZBgjKiGctydj4n5X4ydKvFi3eQDPelsyWiQ9KKhaG3i?=
 =?iso-8859-1?Q?BfQPkuF1Uv2ORzeqrlzUmli8Wz2Yw8SwyBSGSQipNfBhWBQWcbGvvgox0t?=
 =?iso-8859-1?Q?MlR1wcd5L1tJqe5fMabpKeJU6jhg21yRoaCh3+wFeS+qPT4rVx0CHrmxos?=
 =?iso-8859-1?Q?ri5mLeCtyPDUQmiBoUBoq6+8aA90L7w9eJIJ94npB4NMnp2LjBNwS9LNV/?=
 =?iso-8859-1?Q?345KwZjdnXfVsLjxShr3zNF9ULNhV0rYPMW726llAwG+uNjrPAyc3Htx0F?=
 =?iso-8859-1?Q?UaJY1yKnFif7jGLHgzW9wsF/xMVLQ6URphyegfjtjsNUTixlQZhPtKu8Ha?=
 =?iso-8859-1?Q?oUT5dw+cyEa9lHct6dCsMnaJKrXFjBNwYekPRo3IQh57o3cBwCg6WAQpyX?=
 =?iso-8859-1?Q?NG28F8okEAo2NpDZ7nbXnNhkcAT0zweJDX96pWrpECuf6RcxRdKTwKhn+p?=
 =?iso-8859-1?Q?JMsoNHZFEbo2b6kR7KaE6EAaF5ri2NuB52a3pTcD5WeA83PTuUhLM9mxXy?=
 =?iso-8859-1?Q?Yn2h41uxzb3TJhhsrSz9mvfYkVh9ef/UNSjE6qC9OX4MHqKnAEqrYhFOcU?=
 =?iso-8859-1?Q?jKvLMh/NyriSK+60Vrh+krFi+9SM7mtY8M5MGeJUWasb6AB6uvPip5CaPO?=
 =?iso-8859-1?Q?Me2GhBpsMBNs1XPJ40OgWR4843eBUknHUoaUIYQ9N2iYjbOA4EHx7cN0Jr?=
 =?iso-8859-1?Q?lnaKNy3vPbEm/DvtQK1xfCb+CRmUv/cQbG6bnBH06fSE64xWEZ67gNw5gk?=
 =?iso-8859-1?Q?VtT2gkmWACuUyzSFbuL5kiSney1ARW+Bh/HzjdqlMlheNUxpZKbDByShOw?=
 =?iso-8859-1?Q?5gUKXxlaJtmMxq96XoCSF6Ebgpy6as2JdUnHvUgE0Hic+8wk4ayTMRQaLU?=
 =?iso-8859-1?Q?efWwlDGm/4pojGSK6TR/65Cj4b4/lsrpvG8V3ps52AsmE11y5un/6al3FG?=
 =?iso-8859-1?Q?emGxIUvROcFwM1pFvzRFatXqn9X4nNihtG6X139Lo4d0C1eT6VNuxCG7b6?=
 =?iso-8859-1?Q?zmnwDtl/c7ZPwBChKs6Hg1eE6XCb+KQbT0alerbzvrc6IWBkuzIZhHl9rD?=
 =?iso-8859-1?Q?FQ1HRFLQ6Oh9uzJa+dTMPm5POxfLeiLqwQFTLc73F1Y12ZZQ8m8p5HsHRy?=
 =?iso-8859-1?Q?qo5mIWgoaKBwqpb3jbsOxLcTXVIs2APLuXPVZETPfWilUy+EHriJ1gb/BR?=
 =?iso-8859-1?Q?Z+Bj37IbGeXqJLslaBcNPsOf7MDPFE6lgEn+WwQ/ikcp8rbxZITlwfz3H3?=
 =?iso-8859-1?Q?jvonYWuEM+oN2k6iv99Vnj8jnd5W6zoYG/Fr8MuyqnMEqyFGvOAC9CB0VD?=
 =?iso-8859-1?Q?DDLVfi3/QqObcSVMMnc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7613.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4acf08-237b-43f6-1c3c-08dd861352d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 05:12:50.8559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /EU32YkXVokCcWPBRzTwM6IHhagi6vebsxmLBfQ8LQfmKvvuFouDC2BJ01Nlry01iJ5UKJSDneL1xZCnwu39gvGUnTEnAklt27kv6f7vTPg67MWYwB1Hg8g991HVVzN1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9240
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

This series introduces 2 fixes and improves locking style
consistency in the VT-d device.

Clement Mathieu--Drif (3):
  intel_iommu: Take the bql before registering a new address space
  intel_iommu: Use BQL_LOCK_GUARD to manage cleanup automatically
  intel_iommu: Take the VTD lock when looking for and creating address
    spaces

 hw/i386/intel_iommu.c | 44 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

--=20
2.49.0

