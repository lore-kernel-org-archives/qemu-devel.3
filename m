Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434A6C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHFe-000162-RN; Tue, 20 May 2025 03:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFc-00015M-AU
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:00 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFa-00025z-F5
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747725538; x=1779261538;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zlvg/jUROVZ+10ah33uxDEpDW8jE1OkZopl0gi0Xygw=;
 b=KFeZ7P+GLvXtoC+j4tyzb4pzSFdf0WRgqOg9FYy4Kb5HZl66etOjTo2A
 1SS3SNqVZPf4n65JS35GCmdQy6oWCVszbZTsDwvqHHMlRVKmCchytsxL0
 djsArZWTi5KkK+BwRKdG8e5lPictBkre9gE5O9kQ+RJpOEynd0emu8FhQ
 517pW5DXo6PJM+mBjBnfdRxDPGZVjOLOcuQAkMpxLPkoiTbQrEr3HnPbd
 Jw5E8U1tKGhlNBl5RqBIGpMpzpMJae4IFFChJkHz+SklfSEgmld0iT/Gn
 hvx3Er/FPd6t6AfOvHe2W+tt6dwD6bRD9GN6S+AtNKD1xFZm175Gv1OO6 Q==;
X-CSE-ConnectionGUID: 1qSahIeCQ5K7VaHQbskwlg==
X-CSE-MsgGUID: SUQ9T+zAQ1CjDn3MQY5HCw==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37197184"
X-MGA-submission: =?us-ascii?q?MDHU5MwHbKRYcIB+F5CILfHeHH5xwLUkOO5K7K?=
 =?us-ascii?q?+LskWGJIHKA96RI0fDS4Jii2qc2qITFyK45iUbfg843TfdqpiugaZc1v?=
 =?us-ascii?q?kaC1mxKFBEeZ4YXIK3ovRffvxeFbXIFOgmpfP8u4TVrG7DP3C/A1MkRX?=
 =?us-ascii?q?8BtvEEscsqhXC+FicWJY/dLQ=3D=3D?=
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([40.107.21.68])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 09:18:55 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXvGPtKbF1FmHQqE2wO2DbKoDEjwoV3zCzEQj+XP3mdqm+cfSEa+hD7uZBZj9Fp2bnlTWtQpwug5v8DgmxRDshTrXRmqQfCed/GVajUdaK5mwnNoKQFmdiTlstpHVXmx7ytIf85AmX0XVlix4ocoGfnyoU+2UeZHksontolNrDtJzhcyEGd4+NvTzSNHzDEQqiPW+jjJqGj4pxdAc4HtoSmSkWJaEP3Bk2kP/R4alUJYB4bXi3pLsdAFJzt4slrq3c40/qdp8Vo7qFd2QjdHd8i836RVLxkCxshzSPPQqfLyTs1rCLdyaa6bwoeqwnvurOn9HrhGuXYQI0nXyoN9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HI5dl9nWXTry5az4KlPo4ZHUKtAIoN5pXjFWxb0Hhw=;
 b=rYDnJWa2sOQwjm38nOORxo1KqXygLbcFf9apVNsCLiTpRibR/Hg1VGDpppMHkP3B5s97eDFuEM+PCKHWQ37j3vz14y8yEv0l1z9ny21oYUQb1MEuYkg8Y41iwgkKyPEFB1FJwTHvJiBWK+sVk+5g8iU8X3qLNDSHBPq29jQZfccx+MLY5BU8k6l+J7WZ+MNvT+GH6hyhobAlouzNfBpbbAunKZXuR2AXopqEMopkwz0JGgLQ+1mSaKNWhsvjoFUN6HBcZAzkSK7Uc64r4xBbFLpiLr1gTFuKvOyVDNfKuMqyIJbJubj5e/L184C2tpv9dM2zQgmFFte76nmYPCzrHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HI5dl9nWXTry5az4KlPo4ZHUKtAIoN5pXjFWxb0Hhw=;
 b=U8Vh340vNBZ5J+STJtE4TBddj6Y4xa2KIMhfmnSSzqsxnOy6+eT2cHuGMUDO0aX8ibYYtd5vJpbrXe2yaVsdeaXpDGZMMt1hRthAJlfDhiRj0f6agdiCVZgOH67MoeB8P3sMybphKXEKTNwvltKeddMTu0PfZvM0XmyyU7Fkpawyb35n06YSBJQfvoUOF3HuqnPbONSutMPXNvUkdh0MJW5VjdMztMHq5gm0jqzge+D05i14RADerU5klMbUTBT+CkHKu3w5qs6GrB4pkgtiHk1m4Tiv2e5YsIkaz+jEhehlYnIG95vV8Gzuk2Y+l2qPnLOAR0zxzz5guU1qEztavQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DUZPR07MB10037.eurprd07.prod.outlook.com (2603:10a6:10:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 07:18:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:18:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 02/11] pcie: Helper functions to check if PASID is enabled
Thread-Topic: [PATCH 02/11] pcie: Helper functions to check if PASID is enabled
Thread-Index: AQHbyVdwrcSBUKrHQE6E138zbQ1yag==
Date: Tue, 20 May 2025 07:18:51 +0000
Message-ID: <20250520071823.764266-3-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: a31786c8-b663-4ba1-7bf1-08dd976e92ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nGdTH3CMXxaICRh/n5dGy2BMGcrfBSTUtB1UGvXruQ7ECc8D4eyM/xyOpP?=
 =?iso-8859-1?Q?qSDErOKfpQwIJurWAPK/JUNjmHsXCCdtTEyjbBEpp69juDNyA7yL0f89Xa?=
 =?iso-8859-1?Q?MBy7wtyQMv7FXAZvjYfMDry4rkG+O6gJ3dJxIhps1fE09v6zIfFcfUh3+v?=
 =?iso-8859-1?Q?srCNhKl/eek0f0l8j5ZJfiVzLWKKD+YIJzBBGSTydcmBp69a4CmhgZ3BXr?=
 =?iso-8859-1?Q?peGIvPSQNkG/HT4ODv6l8CfZJvY0cm8uXxJ5zbmd3FqOpLH6apQvg+hOCO?=
 =?iso-8859-1?Q?A5oIyLJxz8NF4BCIR0Ai3/X70qX6P4ubw28K9AGXhij+RH54TNIk6GwW+D?=
 =?iso-8859-1?Q?QKylNlkJkzzqlM1xO6AKnNfvYlRVGtlDi6k0prPtTZCnKwmt00/Nys5C54?=
 =?iso-8859-1?Q?xchADhTO9mlrk5ghJG2khwyWKTSig1DORfXCFDG2W6EBjXBYUR9aCTZvDv?=
 =?iso-8859-1?Q?5iZ3k19pP0c4Ziso3ZzKYdgEQ4FKzXevEja77OuWps1iuwArkie6ghPMSW?=
 =?iso-8859-1?Q?sQxp/ZMRDplzoktATVPSI16zhp6jpXEyeeSczmiMxTTO8QDUTEdU+X8Gco?=
 =?iso-8859-1?Q?UVeYvB0P7eaIRIBVr6mibIchQ11PWTP0toL0ujQHbRfPFXikQ6hh/iSdC8?=
 =?iso-8859-1?Q?drftfjbHEz6t6b1FOTorQ9blUEhjM+nHSwRV3J1JUzwx8+1TCQrBMV67iU?=
 =?iso-8859-1?Q?4M7FAqsbD7MQraXGcjbH3uYSpf+0UAs4tDgB4I7yugNz4tObkFNEA1Ir8M?=
 =?iso-8859-1?Q?0DFiYY5tIYsn7g6PbIty1l6iIFd7ITB6RHH/bnroFfGfkixOem0Fo206pt?=
 =?iso-8859-1?Q?ZiBS2FKIjnbBoy0f2oqJuO9NNBnddbsKIA0Zhe4npSik9poEtMf5G2Ssf4?=
 =?iso-8859-1?Q?fJ2ARR+XjHkSx2lWK9vuD8igC+oZnc7Lwo7ur3tb8WMfw4mXQfWCewPEc2?=
 =?iso-8859-1?Q?y6D2bSeMOdCP4KyGIUxTNaYPqodIQlZJA8PzcMEkN3fcImtgu+H0ES1J1F?=
 =?iso-8859-1?Q?TS4OBKs7frLk7PboQclo4nOJtM2f8tvLZNEAwYRW2iEmlHiRZd6lsnDNhJ?=
 =?iso-8859-1?Q?7Q9mBvAUQSOHJiRnS/oOUJeJP4AQMmWMgg2566QlXw8Y4E88vP0T5hf3+O?=
 =?iso-8859-1?Q?6r1kUWAGVYC6/n3hRwZmOtGoxzPmVNUjcD04IvB5rtcKhGwsmgo2bS/gjd?=
 =?iso-8859-1?Q?1IXxpFVMwKHWSS1BHPfmIU/AaFetaQAq9XIoHJQw1R1MAEJJdfTO7rttOn?=
 =?iso-8859-1?Q?tygGbTzikwq0a6jyCazwZZneDhLdm/dfmAxgPCyKQgtHAj+MrI+bxum5rW?=
 =?iso-8859-1?Q?SNFsQFVStwrxpdApO4iKJajcDwHAXMVhSZvT2g0QOb1R01yod2Wi0WVCcw?=
 =?iso-8859-1?Q?BQw5qRa718dGKOwdU22YJDabPVOJpeL5OGUKtqpvBIsog1jtInRJNy29x9?=
 =?iso-8859-1?Q?6j9Zr9zW8nzJLw/b3coyhRVdQYqEnAO4L8bKGjtSlR2z57HROrnS8HXX4A?=
 =?iso-8859-1?Q?/JuES0hk6+TFmuQrdC69iLjhTYullM/wEZyQFBB0e+Iipb1h1DNE/2dsge?=
 =?iso-8859-1?Q?DpQvCNY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ehvMGKM0QwlAUiXJFVQ77jtKHSklCsxaXzQRG8pOyreufHQmJ2HzcG6+ge?=
 =?iso-8859-1?Q?FPnk4c3Tx95bLrQBSRvXmQd55LW0mMLckCquUYnCV0Ocp3D20ejQRBNrsY?=
 =?iso-8859-1?Q?Jz0jrb15BXkij9F73BEgDSBJ+p81Uj7p9p1KlQpYpSpAMpsnRmSpaPVog1?=
 =?iso-8859-1?Q?+aBROk8K4H623VlfyY8O0Gh0/jhtFNOyjUz1oJmP/YS5RwccF6e5c3rmSX?=
 =?iso-8859-1?Q?BDt/1z1WkNrmxlQAk0fdWUolJx5yxJ3RhFj1YOm/bpdtrafRUT/CL5Q8aM?=
 =?iso-8859-1?Q?pk8zkrWEJ20TSDskmnUkoYcsUzT0IN6FCwsB0VeLu4ExNFxTP6VPSQ1rBm?=
 =?iso-8859-1?Q?vK3U/YbHyPhUZpTCFKoc5kINZrtRUHGX7IVInhYLmwMKGe1z8xILD9YIU9?=
 =?iso-8859-1?Q?H1GdGaTxwIzHrfNCbU6o08mKNVQxLGFwJ1/SZiAeLCwq514w+wxS10/TRy?=
 =?iso-8859-1?Q?V7Vj6UBL9XzAhLzSSZPHZOUJV28qpT/y9nDRNd96t4o9ok8RyJAk4vs415?=
 =?iso-8859-1?Q?n/Vchnw5ZgDars3nby5duuHDjHLf5ETHYO46hPhojrjUXRLo+Bn1KQrCTP?=
 =?iso-8859-1?Q?eKZXfbIlE4T6+rC5pg5DsrQOcz1V49/0DPLtIC6zT8DPb+Z9iG3NeidGKs?=
 =?iso-8859-1?Q?4pwKVzv9ujYiFn6hAwx2oYvKpEeBdYCZkGvoNrGSQ5DRzPbeiWoMxbciNq?=
 =?iso-8859-1?Q?0nIYsssHDuAFDF/BBi0jByEW/7opbcd4MY+Wp4iui9ss9ofnqSYmRPbiGh?=
 =?iso-8859-1?Q?b0KwxIjmTDZIiulIrTVydLbLPMuf3RiufFt3Njophsx2p5Dcban+Rh3X9u?=
 =?iso-8859-1?Q?9aNvSTZCGCZeKdJkSoK7yiBPpVb+KyJ5pIRx3E7jqXcxeDR99pq1u5Zjp6?=
 =?iso-8859-1?Q?7JcSxWdE2KT8A7IWylQhV5cyGyljoYNxDAraTRdiREKdNAnwbo8/MUJBhX?=
 =?iso-8859-1?Q?VKwCOT85XuYnx6D/5DOG/XUsyehbbKnrGggzuWTIXV9IdeGdo09mgxBHOA?=
 =?iso-8859-1?Q?uBZNapXN5+a8CdgBFFk1dHHWdzi8GzxWB9YDKxVX89J1xZvsVzemIKsT7O?=
 =?iso-8859-1?Q?6eOwQXnmTWuFcDklzAfI7W+cSzXtJUNmdA2mRjZXTlfAGEDPA+mWubN9s7?=
 =?iso-8859-1?Q?KLZwMd30g9QkW39gYVgkpFoBYLKHqna6AlezZ+a0fqODcch6h/E0pk+kI3?=
 =?iso-8859-1?Q?mHF2pa3rxyXT8W3Ykvo62+hNoWsbVWlwgcdMsjvdgRAkFQjPPDR66yzA+n?=
 =?iso-8859-1?Q?ndTXAVZf50+2BUsTn+LBQMFegmLhqGidcvd4KdHYPSjS+Mpr3VsJeU2m8H?=
 =?iso-8859-1?Q?h4lnXxj2LkzqnFqFr1ovaeUtbMiJrtF6ACy+VFHKhgwr4iHac3Hi6ovIhe?=
 =?iso-8859-1?Q?VdoPhiYIHkEv62dndGzrEU7yQ728WABedYOX5gqI2o6MFJzve0Hnxpq7Qf?=
 =?iso-8859-1?Q?oImCnCUyKjy3OVq+m0Oou76KBy0mdIZhLYCAKD7fvGAkesC/rTh2ZdZp3X?=
 =?iso-8859-1?Q?tA64UKzRiFQ1ScyaUlbXghcciJW1F2igzYqm9PGfZwz5JHWnKQbYXa4AeG?=
 =?iso-8859-1?Q?seLU8Mk2L7z+EM53AM5Sw+iXu1BA/XuDAzSXHOn9z1yeVuTUydiPPCpDZy?=
 =?iso-8859-1?Q?yef1i8W9HFsvbSKR7cMcGuphRih1DnoAEeN9ouJwk1XJ1oE5nH+W9aGRNw?=
 =?iso-8859-1?Q?GdRm2deJLYUHlxXOkCI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31786c8-b663-4ba1-7bf1-08dd976e92ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:18:51.9795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWFifYKi7iPY8Gg2y5sxssqY2YtpVbwGFthXU5rwOOdmX43uGK3HD7dyodIkjFqp+NDWVMvb4cwS3ZJsqWYuY+LLWvBVMDRLGaWkl5nGHDZ7u07QtUWsY8sqES0ke5tr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB10037
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

pasid_enabled checks whether the capability is
present or not. If so, we read the configuration space to get
the status of the feature (enabled or not).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c         | 9 +++++++++
 include/hw/pci/pcie.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4f935ff420..db9756d861 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1239,3 +1239,12 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset=
, uint8_t pasid_width,
=20
     dev->exp.pasid_cap =3D offset;
 }
+
+bool pcie_pasid_enabled(const PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL=
) &
+                PCI_PASID_CTRL_ENABLE) !=3D 0;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index fe82e0a915..dff98ff2c6 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -154,4 +154,6 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *ho=
tplug_dev,
=20
 void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
+
+bool pcie_pasid_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
--=20
2.49.0

