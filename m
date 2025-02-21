Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19222C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4P-0004SB-G3; Fri, 21 Feb 2025 03:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4O-0004Rx-5b
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:36 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4M-0005im-Bk
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125254; x=1771661254;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tQ4ZD/jVqFaAa80Rd9aB0joY7YkHKhzqxvXOWS3zxO8=;
 b=lwTOUVWmce6jJR+o18bPNKlNs77ek6dj2+KnxEyn9WBsPv9weGW+Na+h
 yPFtw/JMZybHdThwgOa+WYVKIuwhYoS649tyqpeLxLuUQCFMk+HFD7oDL
 thU9jhTTDg18vJCj9ZZjoMvPJUeW/Lzzo3w6uNm0XfJ4+CLWP8kLsGaGG
 GwXQli74EInopSx57nSuR3K6t+krgAaP48amdARof3FfiGXprvjT81TWD
 HdfTiplyeKbY2tR8wMTo1o8hbgnsYdQI7KJvTA/Bun7Pe1O2KPWyt8Rjl
 l0JMJnbMEvc/ZS8N2DtrPmZtfl21oToeI+VP4X6GambQ+2izflWYac3Wg w==;
X-CSE-ConnectionGUID: RMmJhISlSR2vrPv0C9vx5w==
X-CSE-MsgGUID: tpaTDNRlQweHwdUckI3GZg==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="32836633"
X-MGA-submission: =?us-ascii?q?MDG3gb+MQlXwotH0jsL3z3D2KHls9SeTAATDBI?=
 =?us-ascii?q?+XSUWdVXKEERj0TB+5uC4fEbJYZvXRfM+4xdTX0MR6qb7DHfvUDdfUjc?=
 =?us-ascii?q?07H6Tsl4pCR4mPW30+z2O4gMnHs4tibGz6LSy++sfT957kfRF+WfNz7J?=
 =?us-ascii?q?SU9QaCR79s16xglzOc8yaZHg=3D=3D?=
Received: from mail-db8eur05lp2106.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.106])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:31 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouphA0KQVrKEEDTPuWHiKmGYSK+Hh88CoHpz+x7eTObpQXUZXmWQLJEO4zl/mYdq3nvElMbiwBagkeR4Nzm4QZh+kz9v7USIInJOcwHIr9Gnj0ZMMRBUaVw0pfm8w42OwpvQE1nE8sf0nBBCF7Px7v+7utPI+DEWYm7bhq/Ai6Pcop2wiqPl3UlFTTTkmyORgZ2UgXlucbJoQWpBVKgKAxz4RtFhlEVgw7/w2UeMXNQtQrvLIpIyY+9C+x9I55wh4jaE2yxyYFrVCMQ4g5hUt4Rh7tww6iuVi2uMwzrp0/mHprqw5UpwYAmIOn968N8gKaE1BnaNzw/Il0UQkTUDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7CTr+Rb2R1zqg2bmxcnsAs7xBENi9tcDM1WAW1bfKA=;
 b=tVEjeAHuZ9LkoM60QHs+dX8ysYcEkPGnIcVUdt47dOdOVz6sJHcEOI+2prw9zoMtoyWssETUtKpjCcigX7hDAvAY2zocWYpvJ8K+qHX1HrbTqHYCL0DD8QUvWln4SqjQDp13ZoPbZg5c1i0PsSRZstEqQOfGNO5p6HCEdtyPcF0MjLXhPFcbsiTamt5P5gWYid/NYvpS0dGrMxK8rSWxhHoby1PLJ8lkeyVU9jOpYl+y0LsDysGE16fIbUHury9A/O9XuVNbTaJg2muBzAjj/gjVLqsP/8rBNcFngbPDJ0cEO418KdRGY0uIugyqgUJ+gHxprWtd2jduv/y0/y6jiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7CTr+Rb2R1zqg2bmxcnsAs7xBENi9tcDM1WAW1bfKA=;
 b=FPOB1tN9hCVWtcWNLuLPV5tRXEQQK+MdcwmX1tTbfqEXwVBYnXoZIo2sDKAUCfrfFx24Ti26r6Bs1U5jLQLehzWvEECoGb6UyVnPxT0U4DSv+DJps8eK+PaHiWSESGqCeUoG/29+NpdXc61/1Kt1l98tnBLPHM62/igAFb9CVhuIZ1nfhn+d1aKNBqSPea1o/N/t5xQ6XhGvukeQmQ2Yp/WZK5Hbdu5mavj86q6QgK91bdHlW1a6XS6bIuwARRknrjp0pcfzvUvfax42qB4HrW1gB8QnrSQpQ6AYx/iiVtobo+SEXXJCqwlF6+T6qgkWVw8zVnbZy45kK0OWRcGrJg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB8162.eurprd07.prod.outlook.com (2603:10a6:102:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:07:30 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:30 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 01/19] memory: Add permissions in IOMMUAccessFlags
Thread-Topic: [PATCH v3 01/19] memory: Add permissions in IOMMUAccessFlags
Thread-Index: AQHbhDeng2anJ60rSkqnEuIWTEDQ7A==
Date: Fri, 21 Feb 2025 08:07:30 +0000
Message-ID: <20250221080331.186285-2-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB8162:EE_
x-ms-office365-filtering-correlation-id: 9590c01c-cf27-4ece-4a73-08dd524eca0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EJ2hNfGQ+UOuABOzDz9q3Zc6ZW760/Xuk0ciU6qmtVIeqHZ+Dvd8SMmYYn?=
 =?iso-8859-1?Q?M789vR5m25FFf++sTAfB9UeQy46mVh5SwoelmhidgmCZCRJsex1P+5ZGvZ?=
 =?iso-8859-1?Q?jlIy3N0W6iV1fst9+Nw7zBmCkbDO5z//i6NVE/Zqss7hwXtWzjixpYBsIw?=
 =?iso-8859-1?Q?wD7Qx6hk0YRGJask7aGqH+TIx5Y2s5Z82HqUf4RCVr8tGVRG5OtDE6bA81?=
 =?iso-8859-1?Q?WJpIwYKqHUtzFj7B4w1mcSn1e3g0t9i3pVskEUopEhaCEDcQiLC1BCVfPf?=
 =?iso-8859-1?Q?6cDqP9K2g2Dr2G0HoVT2TxtsXWZ/IW0yMSJdhkEgNelBaquYgzB3MB4NCr?=
 =?iso-8859-1?Q?MotLMZNxptp8THOX+haSVFhDpy2nYcDlzz3q49OnP7eAhLWDberAVyGJ6o?=
 =?iso-8859-1?Q?BXXz9zjK0JqJ4AizEeWDNbOlz546zXjzuzeeJEh4RL3zI15y2SaMA3LFLH?=
 =?iso-8859-1?Q?ALkSZLR+6fkbeahKX4jwXgGjrQWmTXglDSmzNSQI/45ej6N3rmx/W5eWwG?=
 =?iso-8859-1?Q?/kWijR5YXK6l+cSQpZ8K6uBi2QBlTmeFX1vHhargesEj1zapf4Q0WnRPWp?=
 =?iso-8859-1?Q?iqiGwoVxwTfVMp4GOxPiN6CbcU9PC05BUn+kWoUUx2oeDXYaZOJbsv9pBH?=
 =?iso-8859-1?Q?DiFOTuaakDIYujh5wb12MR1HMzzRh3v0kuA3rNgdiA2d8zsWto9z2zrECS?=
 =?iso-8859-1?Q?SLzpHxk7/SqC+hLQ65Pu5K3/mFRB8rP/wU/m0JbBmWePRVaayoNl5DLQh4?=
 =?iso-8859-1?Q?LcTpC1zN57UhP0Je+r4GAlEdK3Vh2NWt9YMMKOTydzIDX1kQtdp1NSiZkj?=
 =?iso-8859-1?Q?LQmprMd0E8b7vsF1nQLurhs3k/ZDmQcUqpcXn89cVi2u0uyKjyjoULHip6?=
 =?iso-8859-1?Q?0cp7XZEDx46zyznyeA8OOnotOci4a3tsZ+oDE54+3ntSVttznuMz8C8cGP?=
 =?iso-8859-1?Q?gk0xWxbmVRKLj7OUijawo2IC3KJc7dGm49HnPCsL9z2yXVwCs8D54qoFhs?=
 =?iso-8859-1?Q?7DED9veUiv288g+JWsQeR2+3HqC/pn3NkkFmbAtQmkKdfKiZyIlwJgREwb?=
 =?iso-8859-1?Q?6iRUTpC3vmSpIKJMPlczPgdpoHS4RswUafNOtPqvxMMqDDyvoiPuo2Lrgo?=
 =?iso-8859-1?Q?u7Fy9jngAbDdQ9GDxc8dW4GlFFuCwqUAaUD/UDcU3onLRWQX6ZRfUbCf4R?=
 =?iso-8859-1?Q?viyE7mD/h5U/nsdwH2sDomRPjj+0cuH3IZ1SwTcfRo2d07+f2CNb6A5wwu?=
 =?iso-8859-1?Q?dZkyQaRqSQTmJF6GBmZR22EnxaquwvkXH3Uo6GssjPD40HQxCkTnkCtjwV?=
 =?iso-8859-1?Q?EEIuM0IQtKVOPogzv2dBLuA9IqT23ppxz5Q1iJM3Pz/RmD3ziXA275I1mb?=
 =?iso-8859-1?Q?EsWU/xKjSNQsf8u/I173W3FWQgoRhBcjWher2YSeR2m3AmPQACcbR99lvj?=
 =?iso-8859-1?Q?8VzTSLScHsyJv2xvjzScw7g3OIJhvv+q6XxqgwcRl9q7qOTNVSQV9JWO2Y?=
 =?iso-8859-1?Q?OQTeraoUxeHTnZUhbE+PoE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r3kymrEcMkxkXIk/QxNLgYaKw3bifiG7y4T9tNmHNaM8rcoj2h0/43JwnW?=
 =?iso-8859-1?Q?mw0RQ1KkzZtmn2tlIQC3BL+jFNkH6WlHEhOCRSqzo5aLO/qN6757vVNXQF?=
 =?iso-8859-1?Q?Kk1tU094bNGQt7p1sk1CvcJ6CnGKO+wlv42DQtYr3qaMmVJwQDeTKpB23k?=
 =?iso-8859-1?Q?1UjdO8e4fQb6S6yudPy+JRZjpEOZI8UhdK/wgjOqDymqAFfyJ0yC/uZFos?=
 =?iso-8859-1?Q?mrwSNX40tMQdzRHC8RUC7ctbx+xMRwu2mvtmCVsnGziAErJPTiEcxJSzdh?=
 =?iso-8859-1?Q?LOgEokdGOW5kDHwdCogn4DBYJTbCJ1zzAm4cUmpcPRWu4RS/p6WpishnX9?=
 =?iso-8859-1?Q?RsjVqtoGahzr7l9JX0YCpHCqS+7gBgwnbkNAKNlzM0Lrp+YRZaccEWvpDU?=
 =?iso-8859-1?Q?zNr17gCmYCjnPdTuaqEFcJQRn4WCmSCgHUlTMmJAjAyG+NllPPhxAWaZSJ?=
 =?iso-8859-1?Q?nlb5IpeAUyR+1CZTPWqUiJc30eECQenzRcwBFuRHXPmiZfDuF9vkCBVfm6?=
 =?iso-8859-1?Q?N6gRcFfLoxlTdCPD5/q76HsloYqTkIF8fPW9iz77sSPRPbnuO00dtkN5hQ?=
 =?iso-8859-1?Q?wpNe/DMsBC7q0qoV8F+bVKDM0cKyIuAE1LfurOSZedllHxvdXp7nhFxV47?=
 =?iso-8859-1?Q?4KRFJ22g/Y611LM1F1eMPi2mCvRW53+H5fy0JbzAz8twSkXHWyu6F0ek0i?=
 =?iso-8859-1?Q?9Ozl5p63Ls1zS8rbSG6qa3VpR/3AVFLwFrJW1Xf7VlJMoJu4E+XznKFM/1?=
 =?iso-8859-1?Q?h7jYPcQdgYf7nvMcls4B2eRxGd1HIcrfrfKUpqF/26egc4twpvHvg4cMHy?=
 =?iso-8859-1?Q?gljZjiOqznixGFch70GjVwp/thNGkTckBtdvZDzcQoGhcktr99+nB2v46d?=
 =?iso-8859-1?Q?lSK0GdVwP51Ma179pXpA0FibzSoFeaqnya+aHLklkIZ6ZG1G/thGzCBNU5?=
 =?iso-8859-1?Q?v0R8mmcz0U+x/vVRbF5XKqGxomTOccwgaqPoK/WwrXWOX2sWFAXXQw0fRd?=
 =?iso-8859-1?Q?OqC5zJluNL5Ray+9fGJG/pznADMUY7cCZE919acrk4S/e4tSIW+WuyRgnC?=
 =?iso-8859-1?Q?rZtC0jjkZRCzeupmeMW+C1JH0vtWwgKm13U5e6NZCUhgedfYeiRRwXPT/r?=
 =?iso-8859-1?Q?VmIBbVAgJcBQgBPXa654946EhWX+AD/XXNPvgDe2m2qJ7IY/+dUlFgQ6VU?=
 =?iso-8859-1?Q?ld/35YyEZXaXzcYYKlDG6nht2jsqRsfe5zuvBHxoQ2V4XbMhc1Lja9zpZO?=
 =?iso-8859-1?Q?rGO0+AdSCfq6qLGK31pmqQCa+iR/GoH9Q5RF3l5zhTcpOabfvt1Phi/aaS?=
 =?iso-8859-1?Q?GXIzBMA+YS9cO60yCEo6+eS38fCyNKCgUREfvSbg137WMfUnjRS22M5OiG?=
 =?iso-8859-1?Q?TL8O3pbk4F6N/YFWq30+/5eXYL0tppx/z2WkHYYTRIbZq1Y9dsC2oqqMe3?=
 =?iso-8859-1?Q?+oitRJ1wqo9aFjzRLvxHU1LDBah+Je+7+TQ7Dk9xiRKx+FjUj76RMgFoDV?=
 =?iso-8859-1?Q?1xlTFn745/s0RkwnsVGPBRt8c+xRPbIqRANqgombT8UGXDs2EKBY58vmwR?=
 =?iso-8859-1?Q?LYKS47F95e3M84SABJkHf4vluk5b4PRETmSc7U3Ci7DTzcQmJpuKza33tf?=
 =?iso-8859-1?Q?REl29ItKSDQOOl9hSU0rlj6LtqM7tgbKnnik1sgttqVTewI3cwQ3UjplpV?=
 =?iso-8859-1?Q?F9Dzq+h/tjLOt9blSdU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9590c01c-cf27-4ece-4a73-08dd524eca0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:30.6985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKyqHA63sbAGWAZN6rBW8ykvmP3JGabtDh2V08dwY/i0rBOepzgMNAL5NQhOL3djgfSZ7f70I9NpbNJAIxFxka6O90EP/I/8qNw0wgzzrmP6IqgLRPyRMBCCWbCrmB7l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8162
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

This will be necessary for devices implementing ATS.
We also define a new macro IOMMU_ACCESS_FLAG_FULL in addition to
IOMMU_ACCESS_FLAG to support more access flags.
IOMMU_ACCESS_FLAG is kept for convenience and backward compatibility.

Here are the flags added (defined by the PCIe 5 specification) :
    - Execute Requested
    - Privileged Mode Requested
    - Global
    - Untranslated Only

IOMMU_ACCESS_FLAG sets the additional flags to 0

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/exec/memory.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 78c4e0aec8..29f5d31eef 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -110,15 +110,34 @@ struct MemoryRegionSection {
=20
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
=20
-/* See address_space_translate: bit 0 is read, bit 1 is write.  */
+/*
+ * See address_space_translate:
+ *      - bit 0 : read
+ *      - bit 1 : write
+ *      - bit 2 : exec
+ *      - bit 3 : priv
+ *      - bit 4 : global
+ *      - bit 5 : untranslated only
+ */
 typedef enum {
     IOMMU_NONE =3D 0,
     IOMMU_RO   =3D 1,
     IOMMU_WO   =3D 2,
     IOMMU_RW   =3D 3,
+    IOMMU_EXEC =3D 4,
+    IOMMU_PRIV =3D 8,
+    IOMMU_GLOBAL =3D 16,
+    IOMMU_UNTRANSLATED_ONLY =3D 32,
 } IOMMUAccessFlags;
=20
-#define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ? IOMMU_WO : =
0))
+#define IOMMU_ACCESS_FLAG(r, w)     (((r) ? IOMMU_RO : 0) | \
+                                    ((w) ? IOMMU_WO : 0))
+#define IOMMU_ACCESS_FLAG_FULL(r, w, x, p, g, uo) \
+                                    (IOMMU_ACCESS_FLAG(r, w) | \
+                                    ((x) ? IOMMU_EXEC : 0) | \
+                                    ((p) ? IOMMU_PRIV : 0) | \
+                                    ((g) ? IOMMU_GLOBAL : 0) | \
+                                    ((uo) ? IOMMU_UNTRANSLATED_ONLY : 0))
=20
 struct IOMMUTLBEntry {
     AddressSpace    *target_as;
--=20
2.48.1

