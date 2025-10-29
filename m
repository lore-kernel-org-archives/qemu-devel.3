Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54C8CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3mo-0007Wp-Of; Wed, 29 Oct 2025 06:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mm-0007Vr-0S
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:52:12 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mg-00020L-Rf
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1761735127; x=1793271127;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AEQp9XxQWIcE+YXnkRdwc9EoGxxm+91NWPTyXC/dc1s=;
 b=MAU18CfbA89pvVZfMqdDO5VtjOXUMJpNQ+5+knkeAQRH2x94qWCzhPym
 hZ49kWmaIdYMik5YrHZiScy9nstCbZHDvd49m4siJBhEt2gRLq75QB74/
 J+oiO+deM1p0n6DE69FdBP4IY/DNZo5iP81gtpqYS0Htrs0XXwhQGDv7E
 Wre3CppdsWvL5a8qOWkYK+Fy7l0ZOVsIWJwn3r1MPPv3VymsHPymt0Z2o
 3vysDG7tg0BliiCEG/ngmIJ6EAFYMjLwfdw4Tt8AnArs8scSbipvFDpgO
 na5WwwNtjB4kpLvAL9WmexHNHRyL09DUpoym2ZBeooN9lwR/oSMlzg2Gj w==;
X-CSE-ConnectionGUID: R16XfdnDQVWHEKbztVAQrA==
X-CSE-MsgGUID: QszA1TPoT1WDcYifN8ADnA==
X-IronPort-AV: E=Sophos;i="6.19,263,1754949600"; d="scan'208";a="44193190"
X-MGA-submission: =?us-ascii?q?MDEdEs4dro1xbHjXVnLyw5Z/h4+sh1JyAnYz5j?=
 =?us-ascii?q?0vKAiRraVuJhcWvBUwJFy1UNufK0U19pHcJILAAWnJwYw5OqFGXh4iMc?=
 =?us-ascii?q?sjE8286FD3gepYCcCuG564izPjlhyGdkMZK5zwXT7d9bLjobqDb5ugRg?=
 =?us-ascii?q?vfBQQH/be3GCP+/b4rtMY5LA=3D=3D?=
Received: from mail-northeuropeazon11011056.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.56])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 29 Oct 2025 11:51:44 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5/AT7s4IWyIBqpBzqHBMqBq0nSU+j3SZ2wMgkozui9qNuFqkLVdslBxEPgAaSORiyOX6hdpEkDwEnlKiGfN+htSCqdL0ztE96xi0GaNggNkw/Ees/6+DQbKzwO6sc36neBBEGlNkgM4fbCA4qzw2qzAwmFOxhLm1ibWrXmQ7BcsQbMKZr6NxkLUbMA5T7bj40tVY5MjLLYCZEkTFviC3yA75J59Abe5NQLT6sNSNlUqyqNQ9Wf5PRh5ZiLtRoLjzmYLvKh26jWTuq14M2a/OWJWAp8155/5QNLB3I8C9T3ZpxMY/mKZM/VmbHb48msV20EbH5JIWtgB2uXZsyYEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcwYH1mQl8XweZm5gFQW1ukn0uWwiZEh0UQnjU7LPIA=;
 b=HVsQff1HYlYEUS+H0e05adamzg04xA5mXSPa9w7Yh5UaSdpydIpLrCHY/DPYSLGURUiaDqSnCw5gkPxXzCIBQPqM349ejZ5ixidjj703XlA5IPy6ubQxndaHLagWO5and/oXHPj77Om8ixyoA2+6m3Ek4D+o1duPOV2rWPGuI1AXwR/KM3JMoNKw/Hj2e/ixD+EbFfYh2KpjGV3aPKL7adRVHSibxK5yH4ldL6Zag0luuwXWVvYwL/fS/uFEaAw8hdB2Fn70mo61Tv6nvpf5QardwEVD30aWn/tl4gqQd9OFA+NiBSGh0xkAeogRxIEK/3PCBn4fW5J8APaaDzui7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcwYH1mQl8XweZm5gFQW1ukn0uWwiZEh0UQnjU7LPIA=;
 b=Dsc80qmMooLPJHug4q0cI0bEHUE8RXL91DRYGeltlqCL/zu175Fk2oOiWCSnATXKC8ZQMvNnDtlcMh9HDuBQAJ5RN56bfvHCd4LL7/9qG2MmILSDnmEMlbuTHb24NFiWVoVO+srJ313wQO7S0f7BDghSgkdBN3oDgikigEnMOiK6AFE1MJdpKd3eHCJYOK+ZClNzG8p4kkSx5CNkEJ2/zOyJuhv2ydftRUtP1nr7Dqiyzdc4fGrQ6yjvvj84V/9WNuVyvg50M6izCYuTAeww23PgrsulHMxIsX8HqEc4XUIM4H0J2qGu7skmVT0pklgasW536uIK9g0eqdPOPzOnmA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI0PR07MB10962.eurprd07.prod.outlook.com (2603:10a6:800:2d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:51:42 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9228.010; Wed, 29 Oct 2025
 10:51:41 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 1/7] intel_iommu: Add an IOMMU index for pre-translated
 addresses
Thread-Topic: [PATCH 1/7] intel_iommu: Add an IOMMU index for pre-translated
 addresses
Thread-Index: AQHcSMICQJlqeCJvNk6ofjjBzKY3/Q==
Date: Wed, 29 Oct 2025 10:51:41 +0000
Message-ID: <20251029105137.1097933-2-clement.mathieu--drif@eviden.com>
References: <20251029105137.1097933-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20251029105137.1097933-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI0PR07MB10962:EE_
x-ms-office365-filtering-correlation-id: 1f8548a0-98b3-4eca-499f-08de16d92519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fMi1txumelo/5zWOi4Sx5VFQ52N5L+/Pbufmyfco6/C+x+GR4mgrRekMp1?=
 =?iso-8859-1?Q?cs7Xlt1ni+kQ7K6X5cfVzfCcELhDhuHdZAkDLdU+b4JnMTSNT+J75CzN8K?=
 =?iso-8859-1?Q?FZvVPH4ESH1upaccHyXADC2MkCSQfLUHYnGfxervM0krqK9zgko2tFpCa7?=
 =?iso-8859-1?Q?+nNBYjbXZrE0xjRzer0/S5EWps7NojR3Cp+U+/TTZdxRDRXA0NwHSH1tmd?=
 =?iso-8859-1?Q?9h9QVL9yexHrlclIDUGqrD8caWqOJZ+oE2U4jxDKIAb8zgGCVnzNH1sBZO?=
 =?iso-8859-1?Q?4MaxASWqbVzRo4hG9r2FNoYl3E3+1AXX/PeeXBcv0uskFHs6V1zSWaYnaL?=
 =?iso-8859-1?Q?BNAz/Ep8SV7VqgWphXZur3dAfPoRx936BC64tTk6qYQChHTkabgdAyOfQh?=
 =?iso-8859-1?Q?yTIfYQ3cD4hrrm4++OBXM/cS8oKQs1qEQtgqv6TnNtyWYBpZPcdCQRRmvv?=
 =?iso-8859-1?Q?mPLnqCN3qsgTIcClCPZ8sIkdYbfjLkDww41JVref8SzuQqtYA0zjXYdsoN?=
 =?iso-8859-1?Q?Jht9hn3HsBG4ypZDC47Cpo4WR87dZjLfre734/0rREwIeKdqrDf+MwmY1g?=
 =?iso-8859-1?Q?LqAziOTYYcCPjQeA8W4TMs9tFvV3Icogk6WxYDoBm+UEDndc6/H2PmZ/GS?=
 =?iso-8859-1?Q?L9NRnCxWGySN31l50dxKXyZpxx1wjgKnq5ADgw7zEiKQ82VLaqW0a4R7ZE?=
 =?iso-8859-1?Q?8Uc6U4CwF8/pxdBbaDAdvOfAKpDBZdguz4vMy4qcUldgOgGpbWeWPX9EwT?=
 =?iso-8859-1?Q?j5t5MokvdY5J9yNWyuqwzl52UaPxVJdBR9wDfJZVoRKYSj0UHgZGmKal4M?=
 =?iso-8859-1?Q?+b31Dewdp8TYkCtY/4Uub6K3mQBkO6oT/xVwEv5OHtXRQAfiT2dobOQGb2?=
 =?iso-8859-1?Q?hfsfKqn8KlACd4Dy6jNzhlCsIgcvfXvmwxQxrBMNSSfXF4RpSiCnwAJ+pm?=
 =?iso-8859-1?Q?RaBjw9nJnCNCCbmjwrUD9OeGQXylUxxInQmBetWCEZxbCxDWpqBU3836OQ?=
 =?iso-8859-1?Q?yRFiVBn+n/GhuRr34doxKrHVRR/ELv5Z9iygmat89+eyhPOI/+0j3f/jSR?=
 =?iso-8859-1?Q?UCiV7rVlYHZRhzhNHyX3d8HPoLDTpTTWqig+7moh9VOxr0a5ZzSHkJq8rh?=
 =?iso-8859-1?Q?2zPl4up4rT1w7Tb+8zX9D5SaGINL8GfhMnxmKh/ru1Kr+kc3XX9n80n+o+?=
 =?iso-8859-1?Q?CtLt9w5UMylHuGhAtJpNM8use52Qhukf0EBZGcToJjLsJC2Ph1/2laU1+P?=
 =?iso-8859-1?Q?q60zNXIjB96P5tGXq9X3lOOVLHIPO5rI7VL+rWN/BEOWh9pJvzmj/N8aaM?=
 =?iso-8859-1?Q?kdpsOisw/lCpQhpCL1drPiqJM47/FRp7EnDv8zUzRbBaSmiNh1QkIePSK0?=
 =?iso-8859-1?Q?dyIw8zhHgdsnCkuIX2ohEx7viQNX7FrgrjBG1/niJafzdUNm1qe0wsCyoh?=
 =?iso-8859-1?Q?P8bDYxt0vRaqjO7sDxBXpQXWHo9grXRg/3mnrEu74zCXe8dPw0LK59Q5TH?=
 =?iso-8859-1?Q?gBS44IXRMwDm0RnJpWBbybWSyhwlZGRIOv+omKyLZ+FblmhuTcgoOCtB6F?=
 =?iso-8859-1?Q?Wkb4rwwrEf2lzPgFG+VvAPnx1N4t?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2HmU5XCRDwxB1b5lzEd1nQXsWXWxhnOHJHRTq7rPOqkmsmgUaO8pLaTFgm?=
 =?iso-8859-1?Q?u+I9ecwESctL3eVQ5j84iMP9pylP9RvkES527iG7JpHzTbLcxth3mmhtSb?=
 =?iso-8859-1?Q?6YIHU7VO1Edo3IdFf9pM1XO2I/q+23pkwFHpQDcqdEmPta/CvsxxK4e/SA?=
 =?iso-8859-1?Q?Rqx+BSFV01azEVEi6zDM6rjBQj7NYMSKXFtA9lGVG7Fll/SjdEXQdaxXqq?=
 =?iso-8859-1?Q?dyNotxNJF6A17ugcTWAfVLjE7O8AYwzT0j1PnBS6ubTm1Iay8MaqWvdw2a?=
 =?iso-8859-1?Q?5jYmDcnpokeFJ98qXfTjSf2ORPYbfV25ODifPOE7c1Ms33r+QGiO2dd0zw?=
 =?iso-8859-1?Q?wwiHv9ccbgGJBpAnpDiEFVRxRzSrFXoKIVvZkmznsFQhJ4QdNngoK31AWf?=
 =?iso-8859-1?Q?C00Z2Y+i4dNnmIAh4U+G08POZNkuXd/SElbwFECXkIFhz6+DkfYfwVOA96?=
 =?iso-8859-1?Q?a9JSqzz8ZTpqLEd1agj7aRmd94ZM9kfeDPI5qICNI8YdYK7WxykoxdQfgb?=
 =?iso-8859-1?Q?pvj5rM7WzgiIaNhVjyX+xlfn/MExGTSGUYPgglC60KFH7SuWP1Dvs5ybIK?=
 =?iso-8859-1?Q?doF7pSFl66Wf/CG3VmWCSVz/jUpWO6M0pZqAbjYywQwMmflGg0rwAcvUWP?=
 =?iso-8859-1?Q?Re0eRuS6nW9ynaLebqlf9ZBtZEnvEwYiwGKQZUtfyE0Ry5g9xAd2tbQJhF?=
 =?iso-8859-1?Q?o6/QlOOq3qjWqv62Zt78vJvopV0BibvHO6DZf3c8fow2ftY0mnhb8Op9/5?=
 =?iso-8859-1?Q?Oy9bodIH6RMiBqupQu3MMt+yP5fEcsJq+wmWo6+iG6PthPRp6ol8GwtgF5?=
 =?iso-8859-1?Q?lfUIY1TDk5Pea+XAdm5tAuNDCMt5lGGiMuPiXriLWDAxn3r/UbGwhA7Tpw?=
 =?iso-8859-1?Q?ieoQ/rkOQPVHTiyguVJfr4dLh1gRyHGPuBnLx0zqzK4GH0f+M/TYdJv49I?=
 =?iso-8859-1?Q?ZihDFCGb2uXKhpS/5ctz5/DgFhS3v/2yq8/JwQnxCD79mWxXSK4zzU22qv?=
 =?iso-8859-1?Q?X9TfoHO9GfC7g9CPGVQAkVUGekqd4lOcAnuli+EroBctf9dFmj6iL+ijyN?=
 =?iso-8859-1?Q?M4/Lnn2FaWP4tXFGhuIIey3fDms+6zjnmbQsOV6f8fE1SUy0Mq7yRJ12+j?=
 =?iso-8859-1?Q?zwMw8FmFzg4Y2mVDGhypbQgdvl47JV6y786l8KJ8Mwyg/0nw/shVzP1FiR?=
 =?iso-8859-1?Q?3tuj8WSocwcTRDxxvIhQZFj+xYuAjK+41FILTRLM1tHfEBLdxeTh2cdcDr?=
 =?iso-8859-1?Q?taeXrUXtbfxoTX2q69NGiaJMiK8wYm1iYReXphHe0cesOG4Y2fM1UYdfJb?=
 =?iso-8859-1?Q?4pUp5flMLeO8Ru0faw2wyk8kJi6HqQH2K4PNJQxMP24z7L+sZ6sMPnXFfJ?=
 =?iso-8859-1?Q?pS7zmHSEv24n8eSjdz/YPJdvnHreH1ZQxcA3sAz/JI9z9hIzeE+R6gE9vI?=
 =?iso-8859-1?Q?8wDdwxKNVZv3zTjnQrH2rWMVC0PFg3mnrCde3q4grwk0mdrrQ0p9pUon+i?=
 =?iso-8859-1?Q?9eH7E09PZ9esy66M084/JlcxP+qE9TKHoee7iyYd09ZYM25ntxdBB655+i?=
 =?iso-8859-1?Q?Ex5vCLrWV57Jq0KjyaXs96m5MfKugyKrsIa5UnnJllbRxLW3qk5ZqhTK6R?=
 =?iso-8859-1?Q?1Uw69TCZYh1dfrgSz2sKaat623fvrZzHZbBd0+AksF4k0hpxpdKW5gX/cw?=
 =?iso-8859-1?Q?yLBK4sfLiG8Lb+UJwds=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8548a0-98b3-4eca-499f-08de16d92519
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 10:51:41.8738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOuwvP0YzsxOM0jc4yIWEzhmdDLA0LKuv545PSUk06TE1A+mmK8Ccy4S9BRN3vlhO3wgseO692a0p2O/HgSiFFgv3VZwopBiccufWsnk3N2pXGoyxMJl1JE/vu3MteP6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10962
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 13 +++++++++++++
 hw/i386/intel_iommu_internal.h |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6a168d5107..8dbc4ea508 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5326,6 +5326,17 @@ static const TypeInfo vtd_info =3D {
     .class_init    =3D vtd_class_init,
 };
=20
+static int vtd_attrs_to_index(IOMMUMemoryRegion *iommu_mr, MemTxAttrs attr=
s)
+{
+    return attrs.address_type =3D=3D PCI_AT_TRANSLATED ?
+            VTD_IDX_TRANSLATED : VTD_IDX_UNTRANSLATED;
+}
+
+static int vtd_num_indexes(IOMMUMemoryRegion *iommu)
+{
+    return VTD_IDX_COUNT;
+}
+
 static void vtd_iommu_memory_region_class_init(ObjectClass *klass,
                                                const void *data)
 {
@@ -5334,6 +5345,8 @@ static void vtd_iommu_memory_region_class_init(Object=
Class *klass,
     imrc->translate =3D vtd_iommu_translate;
     imrc->notify_flag_changed =3D vtd_iommu_notify_flag_changed;
     imrc->replay =3D vtd_iommu_replay;
+    imrc->attrs_to_index =3D vtd_attrs_to_index;
+    imrc->num_indexes =3D vtd_num_indexes;
 }
=20
 static const TypeInfo vtd_iommu_memory_region_info =3D {
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 0f6a1237e4..3a1f7a1d99 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -660,4 +660,11 @@ typedef struct VTDRootEntry VTDRootEntry;
 /* Bits to decide the offset for each level */
 #define VTD_LEVEL_BITS           9
=20
+/* IOMMU Index */
+typedef enum VTDIOMMUIndex {
+    VTD_IDX_UNTRANSLATED =3D 0, /* Default */
+    VTD_IDX_TRANSLATED =3D 1,
+    VTD_IDX_COUNT =3D 2, /* Number of supported indexes */
+} VTDIOMMUIndex;
+
 #endif
--=20
2.51.0

