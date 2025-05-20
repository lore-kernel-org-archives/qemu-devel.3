Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAA7C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHFd-00015U-8T; Tue, 20 May 2025 03:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFb-00014w-CM
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:18:59 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFZ-00025k-BY
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747725537; x=1779261537;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=f1JnRsC9ePUlTgcBlQhsyWHB9jkjiQmMJwGwJOISmFQ=;
 b=IAOXRg8cKqHdqV7s2pQK04DCMKYQMDffD5nI/9kS1I6SKXya/LigPYMh
 TXrxs8+7S9uT23Tr/x3dBlJa6li9y4dwttkWMjLYFizr8SKqTYH4SRM8N
 5KjzOmAKmlnecuKrKDs6waHDTscJhuApOVCjOBqypMdVN1kSYYtM1DtmM
 FNpLREChW9LuRtmlPxul6ptorN9aVABvA1LNGsShzXNvmQDqT8XBySjdD
 3tBqDRRHodJqgz+nXUopM6+D9I78Kd+/zxl0RfNYvjHdMRNNZtR0+Mo1E
 etJvAVWwg2ddJAiFQtiAxSPSnUbIfcuU6MCKfXbiIpWo9nkROKpjckJuD w==;
X-CSE-ConnectionGUID: uoG8ux+IQsKN8Y8OOiegZw==
X-CSE-MsgGUID: jv1YG00xSJ+rTiZjeDX2Xw==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37197183"
X-MGA-submission: =?us-ascii?q?MDHFMUuLhlMstz4VlW4oNmL3Vkc/ao8oO6ccBH?=
 =?us-ascii?q?1iN1TrgvA0CVKx0RQh3fg8BksfJKwDc7+oE2/6Z4MWulDgRGCPYLMb4M?=
 =?us-ascii?q?o8n1/3f0+mF7yqLFHQes81eafVRk0TtXKyInHndTtMXRSFaDoePTJp74?=
 =?us-ascii?q?UvW5awmUM5pjKJ6T1eA7BOMw=3D=3D?=
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([40.107.21.68])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 09:18:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7Qz3+4Vh47Em9drzeoLqi6DLUIOalbXOjDW9qhVzijEj+clwhhPIwc2BWXZxj4niNRVASADYpu4akcgYqJ9l6McoA0F9wail3zbtI1C1/fKZPkCoOLh4R+gKz/e09qtbnUbrHY7IY8eehPMDEfj2c9O6BGmtT6xBynDfdnJReVKLNeFJzG7wRlhVpUuaKRM3fSjM8GEVUcAEIP5ajoArggn4hUitBczntkFCLpyRbZa0izXe2mV0fzCYBohR6J/fPBJekFrfXEClweDmhzl5VbW4BnvK6eNXer6X7Co3aZmY8m6RpLYIujiR6dIjstELqGY3+dNOm8rmTCMFaMqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItrWFDaWs2I2Ws4Wbq+N4rlbc7jqlO1x190+ka8/mqQ=;
 b=pFjDd62FwKLL5Sk8Qa22P2qpRoUZmXC96j+8H2/fdjbHc+DdEhnL+0EKsJlV7hooOBXtFhZrnezuHA21wzilpFdK87iKirMuMxZxfO4N1PIG8NJNnmgM1ihzvpdPvySzHscc9TcJemdt/RR4oUk15uNaNP6z+GmdDv8CB2nxlpICl4fJlb/jcXlJWxJf19um1P8FWnKWlf4qpS+zObN7SUsWhn8wK7xanIdED0n1P8P6qGnQZg0c+eZgzzueEaG+lYD8MPiOhlCkIfDTJLEy21F+y6HX7SW+oKU472mSo5fYogTgRpT8yY+aUpzaf//RB0McQjUkq8b/fG1Q4sYO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItrWFDaWs2I2Ws4Wbq+N4rlbc7jqlO1x190+ka8/mqQ=;
 b=ZgdBADxLJqvYMaDETKw9QdhPvge1pISPtK/XHzyfcfK/4XWCviriIruZ6jtI9G2pneIrQBFPWiLbtYEWu0qcOWVXiRuXxS7r3cnEI9X2WOou5ZG02eln8MfIXL+NIdWPgXkAjszZWlJPKq5HreToEfewKvjOvQZAmytRm8lExL06GES2Z3Mg1yruFv0aUo9hJdb1if4JXBkRa5qdlTw1i/AqYh1V0JzKJxTQiS31wpWHaXZZ4850LSOXm29m2ZmIjEjufyz8GKdz5On8dd+vTP7JF7BaxYT0J6MwR9rUgtFvdrIF1uNvJRWxIXC86BAtu01qsM5r6A4MBqP4WeKfAg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DUZPR07MB10037.eurprd07.prod.outlook.com (2603:10a6:10:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 07:18:51 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:18:51 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 01/11] pcie: Add helper to declare PASID capability for a pcie
 device
Thread-Topic: [PATCH 01/11] pcie: Add helper to declare PASID capability for a
 pcie device
Thread-Index: AQHbyVdvBdD4v0hBk0ujnU5gnkAy3Q==
Date: Tue, 20 May 2025 07:18:51 +0000
Message-ID: <20250520071823.764266-2-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 7504390e-666a-4b67-1d89-08dd976e923c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gmG/mEDwry0iK7+ECgCxJAPCWu6uDwn8nDwhXO9/RL0ERUPchcrqafCFUf?=
 =?iso-8859-1?Q?sRttV4m/BG84ga5Sc3UvPfroSITZE5WnS47XMoF/FK/1IPt9IGT4BqQiFm?=
 =?iso-8859-1?Q?LWVyy1qeb7AERkR4VWXPs6XVzR51+Ox0oEqbYRNtRpL5m9qgmeWQoJkLaW?=
 =?iso-8859-1?Q?bbvpF2tGYcZ77xuW/PDICph+puGeELf/p3vU4yqMx8tONnO3KdotDVKZec?=
 =?iso-8859-1?Q?7DzwsF0t+ZCO+ihPkIMAviZG8We+V7D5Kj4JSzzM5OkxsJwscEAsic/0WC?=
 =?iso-8859-1?Q?rKea7aprEtleiHdl0cAd/L7PhYfBtnc1emrsMAs7JOCWuV/mtx8cpBNNyA?=
 =?iso-8859-1?Q?36Suvnf65CUQ7viwgZUU43ay5QRz+/jKmixUCEaiswbw5PGeTmsJmbBdTG?=
 =?iso-8859-1?Q?Z9kOZcv8mvlWtxMf7TYk2mMx8xkZei5AvtJIiz6QOeqXMuq9IhkJMVW+lS?=
 =?iso-8859-1?Q?mnydEXHrD+36YuAhmDelAn7Pxl2DX8x/Rxegt+UAQk0OUEPFxqrKro9go+?=
 =?iso-8859-1?Q?e+Tm9qLfxEGGavnLqW4M0jLnigo2us15BHsGnplU3ULVjrHgExrwEq9pRW?=
 =?iso-8859-1?Q?xo1RdD1Xe165cKZRUyQ3CJyyvLgA6Mp19ZMDSSdDmC5dsGZrsudfj9W1hv?=
 =?iso-8859-1?Q?te8076PNs87+7SLX0HIorubnzS8+BVWEWcEgoltg8nd4QMnBLA5YL/T87B?=
 =?iso-8859-1?Q?S06dAG+LPdmif3AQRJYNB9rbi/GYnoO8+zmUrAShDLSyQoywO20w/eP/gg?=
 =?iso-8859-1?Q?d9yrIIpb91OtogzDVvMq7ZoRKsXXy4XMARwvAjSY2Jdk7NC68QNlhNYSxv?=
 =?iso-8859-1?Q?fVShPG96TDlHkfk8CLWA4GP2LZEBcqsjSlBhnefWskcnhXgKcMvueQjq67?=
 =?iso-8859-1?Q?DgsjZ3/v7axd9WqkzMH84Ip+D/nMQ5j/v8VHSnGIvSe9q7d0tFDpb/VTkB?=
 =?iso-8859-1?Q?a7uCzWIGQCIomauR4hlzz85AOL11TQyDFRxtlok0eTuSg7F9pUF7vG6Njw?=
 =?iso-8859-1?Q?oHrgY3qonuadcIgNd805EeqPgL/JW1dwnUufBARsr5ZbGoaHSPzyPc1WYk?=
 =?iso-8859-1?Q?0r63dm5xnzV/ILEXHnh6Z923cd4ynVVx9BJbyXZgdzqe6Gffl81bf6NmJb?=
 =?iso-8859-1?Q?AwnCorZ2aUjB9qtraeeu/47wqw6VCX0MBPdEUmLnMjxA0QPC9ENMIKEFBv?=
 =?iso-8859-1?Q?7nTZj2SMJ2FBxwncE+AsZe5SY8yAw6L15b/Zfn2gr00eUPblnTI9A7thDB?=
 =?iso-8859-1?Q?RRxzJKfQTjWelJ8oumI6bvvWnWKn8MUEjYBFqAmsr4URYuCS6irvM8Z1Sk?=
 =?iso-8859-1?Q?oTb1OcXjDQKAk0/abqx1Qy86ymQaIfJ/S2FfwOd9a3Bjg1JB/vGb+UN4y2?=
 =?iso-8859-1?Q?Rj9uuixC+723WAdnJ6jH4z2aaAJhen3aAlV/KIkTKPAD9oQbUWkgEkptxG?=
 =?iso-8859-1?Q?EPPmaUj9bcA/8Uho78fyOYD2EDLG6mIZqzwWPt9yoOIhjMio4dFhQPi1pR?=
 =?iso-8859-1?Q?5Egmz3gTFaO8YyCwsUZ+P3p22d9EzowX0YzRdfcxieOtEcMcwvnYrCE5TL?=
 =?iso-8859-1?Q?sm1Qz9A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qPsMhMiSXk3xafdGXK7tGIKpNj15jXrbf9WS5KYcKVmOCOPPj2j3HrpSKs?=
 =?iso-8859-1?Q?Y+jcUDjGDJtuytYxAQd+4cTGT43UQig9oGjoeMkyYuRJ7ZrjYK18gm5PFh?=
 =?iso-8859-1?Q?dIk1pj7qxadYAcaP12jIThNfO+F/L3sN+q+n56MhAXcSBF8kgNTocpPlaq?=
 =?iso-8859-1?Q?W0ZfimQcuRHZTaiHhVqdTnj1aBdOApUGZvHxm+BAncaqKamVW6TXageVb2?=
 =?iso-8859-1?Q?gbbkIPyeuNnRFNC1UWMHxGU6SJwieYRDKJwrDdGaoR6YEqU1XIuuOZ48ri?=
 =?iso-8859-1?Q?nh3j/L6dHVhTFUQEol66713kkrbgBSelxcFTeI+2e0CDgbHirJUK6P8BAf?=
 =?iso-8859-1?Q?6NUMAczE1HUjDTOIGJQWC+N+z0yC9H1E2tZ3wyOigGHhwjaGN9PfBCr9qS?=
 =?iso-8859-1?Q?uV+0Z0WJP+BMu6mMwvumaFsbjhy5OVbLIiZX9Taz0Z2s9Tj/0xufRnCKw4?=
 =?iso-8859-1?Q?TSRpRvkDsUTvVdCOyLlWthz1KDrwhenewOqfAY3PWQh+Zh5/VIgIMeM3cF?=
 =?iso-8859-1?Q?3QK1NEJ8qSM7TuxHLMMO90cKd7hTlRt3v4ZIkB/eOK4z5mnrYSU4atxmfC?=
 =?iso-8859-1?Q?w+C1dsSZPO8FsQeoeQxgVA+bQaKZIYSW2CK1Aom5jQpZr1I5bv+yJr6wv9?=
 =?iso-8859-1?Q?wc98MWZOWNrjImZ/H6ImRT32KsfQzd/F74snHST98elxd7fwxuaLEH2pfk?=
 =?iso-8859-1?Q?3SFLGDuu7sIjvXeOvreSaNRcl4Cew8oKRroOJkIjbGOQ79OMmWNqgLl+yo?=
 =?iso-8859-1?Q?fWYQYrvA9LPSb2VVS79P+aH/oI1PkOV1Ets0lTkwDgm9uGSrQnGiVcpoJl?=
 =?iso-8859-1?Q?eZaOgnG0bxB+mCwUAFhPWADq6da7Uxl0AtcW2nqxsN6Wy85LhFZMD96KkS?=
 =?iso-8859-1?Q?vNc8OiE41Iqfu1qQYEIxFVx1BLNtskm7H8JUrw8dwlKXgSO8glXmgVPevq?=
 =?iso-8859-1?Q?ARoytDZ5atlfwRzNxcZKVWb9nUwzkGMusV+rBPHeOZSuSpinsCp85f4GRJ?=
 =?iso-8859-1?Q?XAheVX9SejJVp1U3KEfpYcd7OwqydFVqeG6JDNiM1DzIfX9YSkmMA9IdJ+?=
 =?iso-8859-1?Q?3qY59zXYP9l1eK5YX9q/rO/glT5lSIEGrJ6kGLluC6huvCd1Yf5MAyq2yr?=
 =?iso-8859-1?Q?ajZr8T015ANkfpagO2j+FknNxvK45/3gWEaFcwJ4ATDWL3+acf5fgvc704?=
 =?iso-8859-1?Q?Af9UtxmZjW8DuOemH0gOf/1L1AGnM3gkF6QHlJgxZ0t3oZTzNaqzIodBI5?=
 =?iso-8859-1?Q?h5+/jzl305NaJ7/HYabyZeeElJB/JKfGQol86DhmGMZli6aDK2V4bYF2fI?=
 =?iso-8859-1?Q?ValZ6Nh7BhGPm20YWvefGCO21jQnZk2l9Ne6S48WnaUYZG03SbrvyyfUpJ?=
 =?iso-8859-1?Q?b5K8LacVBNM02KmHc56TB9a4plY3DwO6qfZyoXhaTxcS0s6kAS3EB+pxqq?=
 =?iso-8859-1?Q?2hyN8cAxUnL4w7RFoXWk6BDJjz9XPO2aTGGHejbvaK6YdCIxMiIBNz+DD7?=
 =?iso-8859-1?Q?hFYqrOvo6XqXbEu5JLObgMAnD7KIEzdWE4lPmWFOMmEwhumuRNfsFdW7oQ?=
 =?iso-8859-1?Q?KNXBz/OAm11EngmVOb+XmN9Emr0lsfEheifGpb3z9pNcppqlpPwTJKltGf?=
 =?iso-8859-1?Q?/O8qigidAz309kpraTobeRdZ+AmTVIzkZ6UvH112r47yFcL1CjtZXo7eqe?=
 =?iso-8859-1?Q?kC13q6CE4gVnfp7S+ow=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7504390e-666a-4b67-1d89-08dd976e923c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:18:51.1733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5q7nDl8UBuKHaxVfVGexq7JhxogXvlikC/76dB7GFMhV3ZBm5FZAJE2jKMsCAfRt3jWr1GJQCvabgMsS0O0JxxIJAUzCI3rRoCGqEAujhrf9t9xgJSVP3JqbWr8YkXq
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c              | 25 +++++++++++++++++++++++++
 include/hw/pci/pcie.h      |  6 +++++-
 include/hw/pci/pcie_regs.h |  5 +++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 1b12db6fa2..4f935ff420 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1214,3 +1214,28 @@ void pcie_acs_reset(PCIDevice *dev)
         pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
     }
 }
+
+/* PASID */
+void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
+                     bool exec_perm, bool priv_mod)
+{
+    static const uint16_t control_reg_rw_mask =3D 0x07;
+    uint16_t capability_reg;
+
+    assert(pasid_width <=3D PCI_EXT_CAP_PASID_MAX_WIDTH);
+
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
+                        PCI_EXT_CAP_PASID_SIZEOF);
+
+    capability_reg =3D ((uint16_t)pasid_width) << PCI_PASID_CAP_WIDTH_SHIF=
T;
+    capability_reg |=3D exec_perm ? PCI_PASID_CAP_EXEC : 0;
+    capability_reg |=3D priv_mod  ? PCI_PASID_CAP_PRIV : 0;
+    pci_set_word(dev->config + offset + PCI_PASID_CAP, capability_reg);
+
+    /* Everything is disabled by default */
+    pci_set_word(dev->config + offset + PCI_PASID_CTRL, 0);
+
+    pci_set_word(dev->wmask + offset + PCI_PASID_CTRL, control_reg_rw_mask=
);
+
+    dev->exp.pasid_cap =3D offset;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 70a5de09de..fe82e0a915 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -70,8 +70,9 @@ struct PCIExpressDevice {
     uint16_t aer_cap;
     PCIEAERLog aer_log;
=20
-    /* Offset of ATS capability in config space */
+    /* Offset of ATS and PASID capabilities in config space */
     uint16_t ats_cap;
+    uint16_t pasid_cap;
=20
     /* ACS */
     uint16_t acs_cap;
@@ -150,4 +151,7 @@ void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_de=
v, DeviceState *dev,
                              Error **errp);
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp);
+
+void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
+                     bool exec_perm, bool priv_mod);
 #endif /* QEMU_PCIE_H */
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 9d3b6868dc..4d9cf4a29c 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -86,6 +86,11 @@ typedef enum PCIExpLinkWidth {
 #define PCI_ARI_VER                     1
 #define PCI_ARI_SIZEOF                  8
=20
+/* PASID */
+#define PCI_PASID_VER                   1
+#define PCI_EXT_CAP_PASID_MAX_WIDTH     20
+#define PCI_PASID_CAP_WIDTH_SHIFT       8
+
 /* AER */
 #define PCI_ERR_VER                     2
 #define PCI_ERR_SIZEOF                  0x48
--=20
2.49.0

