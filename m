Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277B6C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 12:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA6rx-0000eM-9m; Wed, 30 Apr 2025 08:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uA6rP-0000SA-JM
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:48:26 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uA6rJ-0002Nn-F3
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1746017297; x=1777553297;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XcYltWBqPQIrglbjC5wvryhtFHloGpX0c8eryQ6qzSI=;
 b=VN/1up8yjYlxCYUNXf5ofimkqZfInIrUkITo6xxtGYsNYgOMojhH4tGE
 lbJV9h4tGvCYRfhzha5mwYSxF+GsRb1zvydCi3QPzvlCHl0Umf7GsJpBF
 kezoVHjWOTvev/942LGteNX4spD2VC/tYgOunT4cimnMTsVg+Lw0oTJ1S
 oDjTVQP8b4Vhb7FYHwNkS1bQtbe6//99QaN1mzX8TpWa7P8MM6EBbaU5C
 /g1rnAWbj2CkjCUwFP2IkwGohI1SX2x+llC/RE6p+lN6qNI8qFFQtPUUX
 /ISZtj5ZfzYHGxdhukcH6NyPhALOnBFdEiu29iHMc3GeCjoioLY+FzGHP g==;
X-CSE-ConnectionGUID: bPfPioSRSmuRyQTVrGjvJw==
X-CSE-MsgGUID: bk7zrEroRzSIsiUiiK/t3A==
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; d="scan'208";a="36004698"
X-MGA-submission: =?us-ascii?q?MDFoZJhu7anUVYrFAnvZ+DaIkzub64tx9u7fMw?=
 =?us-ascii?q?kvUyVmRruqvJSmZu5Z+N/RZ1a5eYJeVmr8t78VYSGzMcdC0d8PJI22mU?=
 =?us-ascii?q?lg5B8ms48eW5xnhI6qQSAmVeZagtS/YDnLqlxQgc1URZwvQ1AbxOpZ0S?=
 =?us-ascii?q?F7bwKslz4XFhK7NU7Ycn0ayQ=3D=3D?=
Received: from mail-francecentralazlp17013078.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.93.76.78])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 30 Apr 2025 14:48:07 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee8AGAhg9dHBuAbUV7qu5Abwdb6c+Ai1jcpTA7kY/g8hc1oVDpsbnPwzH1Lz1bu4J/ctMzbx3t3c+gCmZIec6HZZVkVpaUO2sr3pl7R6oKTax1VnqjO8ntDbwbmPjChfVxCMXLsaFsbw2gQkfNdy7nI22g8+58fKru3n3uJEtIcWGV8vvtIF+g5pZiBs1hkEJqDJbV9NMpSOWF25l3JcsmrkwE9govwXc1N+Wd1gGqvwigDJy8RpM8ZRsk8cD72ecovp1yd6tPyPQmKz/w3vM+/MNR/beHMM/fEjx9EIChcj4yPTlHi+OXI7kOLEs8S8UQJfv1ChdiO9/CUK0O++XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LFtXk0OZM49jAyOXp75yjsRkR91vwF4fLg/5edTTvs=;
 b=Q0fGKWRyQAIQ7A8k32sr8G/JrmZtjAvyjiEh7JmcVyGr3QzKTthzQxWLpycJhzRC5tPuP34sk1T0WA/g/vAv8tKH2/VV4gesla+fLQUZRru6ayqVgLX4ZvCWqZv2scOyEcpjxi7/Flk+CdQHY9JQZy+Qk0QUIt1yWepXKZBxzYrsF/MOPLnZBZM2R9yUJ6sWrrhFQ69PIiulpNt2XSYSwvTzEfG/616x5ycPNEs0HMA1dOamaEE8nmJAU7STWCI638lEXb84impklLyEhZRmaLGMSEFc4z2dHNq0xE3cfo2aFGPOvxfyOC4JLpAD+kRYgKVoFEouFWXCKS55lVQRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LFtXk0OZM49jAyOXp75yjsRkR91vwF4fLg/5edTTvs=;
 b=T0CfdTBkiCXnscM4OZI64C26xtFR2Nf6Ob1Wo8u3eHyF23gWQG0h5usHksLK7uXlvPVFZrERInmNfAgmhrW+ARiUUX4OyJFgW/pZkjmXBtfWeruHuoBI7zYlwOz+XmWC8cnDXXqfjzbihJJ4i6xHALu/8u2LqC3RHGljL1r6dVt4vW946vXCHgj/F7YFBdWPsXsQ3cqPQrU9DZ7//xObD+DVQiDKSm8MzAbWPL0zcZrsGE/Ii6HopscY+lxC3A31JjC1JwglZwjH5sFXqDHzvW8KUvSeGf2S0lLEnoNDkuE1papvUtBqODeBfEHiP6HOmKK5pBm0KIjkzemCeW2Deg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8449.eurprd07.prod.outlook.com (2603:10a6:10:36f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 12:48:06 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 12:48:06 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v5 1/2] intel_iommu: Use BQL_LOCK_GUARD to manage cleanup
 automatically
Thread-Topic: [PATCH v5 1/2] intel_iommu: Use BQL_LOCK_GUARD to manage cleanup
 automatically
Thread-Index: AQHbuc4e/7bqZb/HQkOZOHntjScv0A==
Date: Wed, 30 Apr 2025 12:48:06 +0000
Message-ID: <20250430124750.240412-2-clement.mathieu--drif@eviden.com>
References: <20250430124750.240412-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250430124750.240412-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8449:EE_
x-ms-office365-filtering-correlation-id: 13a9140c-c1ca-422b-726e-08dd87e540e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?yNOYD7xN6VQWpkxNcDM2+eusphY8ZoA2SMuGrpE/s1aEMKn+stXlU18nFi?=
 =?iso-8859-1?Q?Y1XpmUGaAyX2Gxr8Oib1W9nJ2cvOyWVdBywP5TKl2O6SX8Iv4VcW+JnqzT?=
 =?iso-8859-1?Q?lhKlT30kGZn2z3R/8IyxTjgsSXcpo1qhnNZx37ewf6g0JLE2OrTQWh6KRY?=
 =?iso-8859-1?Q?TaaomGZ8kG/qwerWpNNjiCMR4i37yjkl0lEWRRh4iMwIZFOvUSmL1JHjA6?=
 =?iso-8859-1?Q?wwePo37FEHZ0+KAJ83dJBUihH5IrxCkpsJONlGo9yCTyKaX2kk1ChwPmiA?=
 =?iso-8859-1?Q?Dju9njQ3Kty5RV8kJgSKjvTcJLIAEQgPrsRxJchpR1WXftrWoYGYZ1HKDz?=
 =?iso-8859-1?Q?aByzK0tzrtibVEp0CfY4nmpuN11btZNPCjiFsZBpln3Vr9K+z4w7M8Aq5Q?=
 =?iso-8859-1?Q?8dBuOz2Vvh3zuEE5lmA9rgpZgy3e34+zcCA88gRmuBa2Yv+kSwuRVW2l06?=
 =?iso-8859-1?Q?ufVryYWXF9GStCuS3nvxuqDs9o0Xn+I78/ngVb3qYYeSlmMaT/scyzr6/I?=
 =?iso-8859-1?Q?mrVcWXeeTx4bGo8RTZs2iIkRUjFR6NeJ7gAoVy24Mi7awo/uDTSffWOSXw?=
 =?iso-8859-1?Q?p/4jxFUWBBNuowPO3cUaNDvqqz+VLUef3JtaegGBo6yBXPPgCsbPY5kNwS?=
 =?iso-8859-1?Q?VJC4ubXnSsJ/LJ85o/gSJUMJ40nXufRvqG1MRZM4P/zOK+C1AmyfyTLOF/?=
 =?iso-8859-1?Q?Z0nPTqv51AyfCWCKFb8zSQpBcwFk2kPb0NYFQBk6mRJhXAgaj7oqZ5fB57?=
 =?iso-8859-1?Q?xLPySXSmj/jrlugG3FTzj97x5OZjboDNEWVL5YMjmLbmSHhX1qe2e2l1Uv?=
 =?iso-8859-1?Q?izRE390wh9/tGOprV/WdsQaK+p35MU9xZTm4pDwrGn68Deb8Ys+DCdJFRj?=
 =?iso-8859-1?Q?9XVh+JGkehvUCTWOslK9f2VAGDS6CPThIec5EM/XrLj7D65NPL+FAWDNyl?=
 =?iso-8859-1?Q?1u/c0C6mV/FHAO3QfznBb60FWl8lyIjQOTG5B/+hWdaM5YU3aJ/eaX0DJy?=
 =?iso-8859-1?Q?W8lZ5K3jibyFcFLKx4mkT+AvHLlJbHLzUn++JOp3VK+yYISrShPtLoe+kS?=
 =?iso-8859-1?Q?l/Y5oq+5CxtbOi5ipSsPxm5nU0885MKn6BRXl6eRA7KZM6NKmfKJwKqFYM?=
 =?iso-8859-1?Q?xg4piqHmQLBRxRyM8CcC7boaEqVv0UBQVqXZapXj9IdjwEOAmL6zoAVshZ?=
 =?iso-8859-1?Q?OBqT2CAHndSo05Py/ecp9NNKMenGUUc0KuPCpbXs3/F6ckNcz/VQm6XiVH?=
 =?iso-8859-1?Q?iYZwB0tmdNI1nUZchXnTs0d04ReBdSJpcsZeBnYYLZ7w7DH//FLUcq37R7?=
 =?iso-8859-1?Q?yMe4UJRd1AiItxgSjycNOvIbmtyRwJUUVT97hLHfMt084YQILAAUt8b/CK?=
 =?iso-8859-1?Q?x6lXng2r65e4Cj7517JpNS0T4ug1zlL7ADFMt0kpTDZWAJ+mlUyj/emnwH?=
 =?iso-8859-1?Q?hS6XHSyC5ZzrobfJEfb9+Y2PUAbVyq5nhDRbsCQuNsdbCqU4Bey070S5FA?=
 =?iso-8859-1?Q?R7gnACHe7WQyff7qAnoSrKXOHOiKRldL2HU4VGx0Py8w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S5j5Qj6KQrXTgjqPPxVhvMo2wsMDykSm9pBfnI7OIoa3/HT0YJW1GvWkZ5?=
 =?iso-8859-1?Q?cfvLBnr0t0urb434j6Janwtcebg2Z4HVTv3lCJfR+w/fhuIvRCcGoY8P6H?=
 =?iso-8859-1?Q?2IN/Hz7+s43YpdnMY5sQrOa3IsE5jPx5yWxm7ZGyBJF8VJNBFZ5qXptmIs?=
 =?iso-8859-1?Q?NvirWnI6k0IuixPAoNoVqnRy7cwo8JmygQEA3U8qQWL12QBzlJW+MLxa3E?=
 =?iso-8859-1?Q?Dq0dL8GpQsQ31eUUmz1m0ghkYwwfK2i2JopLsTOcpHcrODGO2h4mFGlCYd?=
 =?iso-8859-1?Q?5akot+S4LorqfCpHCoLV/yf+SI7Fm/JOsnN3PdswJ9CYVHCCFxOLEtUzqj?=
 =?iso-8859-1?Q?FhOShVmRGZNph7sbK0m7M1uDQgFUGptmphe0wkOcv02E5Z5bjMvYYL5BhC?=
 =?iso-8859-1?Q?qqghgEQtKSwCoZqLeYPbdySM3pWwzEqLcxAvShJAhh9tcBcoAmmt9VQvfq?=
 =?iso-8859-1?Q?Y2R4salA72paxEJ4GSHV6KHFIgpRLt1F5ZbOO3xnwFnvb6+oZac7XJT5jy?=
 =?iso-8859-1?Q?6PAy9m5mRveiE0On9zca4oDulXeZpCAAQpUXTn97OMHZoDLFBqsInQFchs?=
 =?iso-8859-1?Q?olGp4jwkXTqDT7+Fsu4R5uJyO6sfbsgIaZ2SHUymNE1wRP+4rr57hAr7EQ?=
 =?iso-8859-1?Q?0tbrz63d70aUedXHuDV6f6MOwRTn0AfMXOg017wZkg4+w+Z6n0FoFkBT+p?=
 =?iso-8859-1?Q?6tD34BuGDH7ZWcwDozAgoooab/qUhZo3GDn57onYyGLIJxRob8duYxk44F?=
 =?iso-8859-1?Q?WLt88HrGaIiP6h4RLyEjfyrnuXrkHGgWEcoGupq0n3617boBZLm8oxKkHc?=
 =?iso-8859-1?Q?jGtIn7Q4jEHNDjPMVQUerm2/Yn88PKMS1yKtD2Or4/7YmkFYbuZ6sjVfUV?=
 =?iso-8859-1?Q?vlsLluKI/9XAXf0m526pFO7JaM9cKAvhY/d6lPlAaZcep3f1Lp3FdTN/k3?=
 =?iso-8859-1?Q?C423qP11kkEfZVrW379nI4tux8MPxOGIgrhcqUMMulujK9h89bkFtpk0IK?=
 =?iso-8859-1?Q?joNWCi31hrJ8DGDLcljSovUpcWwQz+4Q3x5jCHc8MMOGQYh2/UFzVU3zj0?=
 =?iso-8859-1?Q?f8U65qWmaBGW4o42HaaUMuAphq9XYFTr9a/ER/yTuR4GTnoizir0SZTCEU?=
 =?iso-8859-1?Q?Ee69okrmfA0Okk2kzBpsP2HH6b/iC42UnOEbEkfA53pax7M0xsV8C44Rrj?=
 =?iso-8859-1?Q?aSfZWfNJtz9p7ME0cPq7+20kkcR6PNFl2vfEw5YA0yS/Ib36U6iFh1LCtf?=
 =?iso-8859-1?Q?u4H8q8lLQZP3Zt06RDLfim2iwx1x/EjriTiJHfMTAzuJw6nwze/Ygvm4Uf?=
 =?iso-8859-1?Q?O+FVF/Z/8o9xp3hwIOIv+QvNFhBVjkb3xg4v0M/VUPUmOUtcBgNkjK6zti?=
 =?iso-8859-1?Q?eLTzxo18j5qAAnNLOCnaQni9XP8fXnO0XgxkuCYDwudsWJVroD9x96EGUZ?=
 =?iso-8859-1?Q?90tQi7eq4/xlUkmm4eV+W8saJ4S/Ra4PcFlWYUBT9AGNhfptJjoZ6HgWwH?=
 =?iso-8859-1?Q?uABbR0/6JbumYjdxLPWnXeBChbx9bpeiLTw7uoXRuCP9183+pGNlUI9Gyb?=
 =?iso-8859-1?Q?ShQrhvDb+dyRzj9RPgoWGW8FLl6gwHPAahsEjdA+uah9UDhJtJh+SyNAr+?=
 =?iso-8859-1?Q?DTMSi1hY3Ru2fJVr8bQFylFEv+9ZzFsomq+srXGOePosMkdVEAuevzoPA5?=
 =?iso-8859-1?Q?qVzjynuIGR6dGd5QgJk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a9140c-c1ca-422b-726e-08dd87e540e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 12:48:06.2081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7EDaXJwtWZ0GrrD7StQe1kIbYACmfX7Q/PFU6giMxvAmGCAjOEpo/CgL9AAFzt/9p6juonXiDNXfD18FDOZ2urJszsJusK8SQx1Xq3xxYdsFCzmyOlPzwIFRXtjn+0DV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8449
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

vtd_switch_address_space needs to take the BQL if not already held.
Use BQL_LOCK_GUARD to make the iommu implementation more consistent.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dffd7ee885..dad1d9f300 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1728,8 +1728,6 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
 static bool vtd_switch_address_space(VTDAddressSpace *as)
 {
     bool use_iommu, pt;
-    /* Whether we need to take the BQL on our own */
-    bool take_bql =3D !bql_locked();
=20
     assert(as);
=20
@@ -1746,9 +1744,7 @@ static bool vtd_switch_address_space(VTDAddressSpace =
*as)
      * from vtd_pt_enable_fast_path(). However the memory APIs need
      * it. We'd better make sure we have had it already, or, take it.
      */
-    if (take_bql) {
-        bql_lock();
-    }
+    BQL_LOCK_GUARD();
=20
     /* Turn off first then on the other */
     if (use_iommu) {
@@ -1801,10 +1797,6 @@ static bool vtd_switch_address_space(VTDAddressSpace=
 *as)
         memory_region_set_enabled(&as->iommu_ir_fault, false);
     }
=20
-    if (take_bql) {
-        bql_unlock();
-    }
-
     return use_iommu;
 }
=20
--=20
2.49.0

