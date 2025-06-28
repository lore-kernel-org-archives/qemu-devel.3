Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EAFC7EE39
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 18:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVZuS-0006Gs-6E; Sat, 28 Jun 2025 14:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuN-0006F0-53
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:11 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuL-0004Aq-Da
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1751133849; x=1782669849;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QPeqvMvhfeLSQhn3sF5GsckDnuPhuqjCYJn5MEMX5yc=;
 b=Cgw4gcC36l2RJkjPUzZk2ZH/Q2NqtyNMwy5SY9sZX4VHCXYuRfutogDi
 3VHQAPzZEL8oyvBiVvZUrDcQ6ZkN/OookuyPLtE/gtJyq2KET4yEKPWpf
 HY5af7tJpnoErZ4SLFAUtgm71qsUayBrjAf+pYqHCphXUb6y7oqaqHLGx
 WFRL28/LGMHfWGe731kGLzXi1KWoL/VJQdoELeIlyktaxlsEUG/rFcZE5
 pGzU8gdJ1nhL3XWeQdBFUwdHsEFdaFBwVsYJusc1RDcVzjjO7H85BJ+la
 HKgfvVFlQafVs+u/ATXc7j+Ru7FGo71vNmRLpKsuprh2sVs3wJW8tDrda g==;
X-CSE-ConnectionGUID: z4EqGl2qT3qYJEbCxISlzA==
X-CSE-MsgGUID: /Gv43j3pTdadaTNXwnEHOA==
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; d="scan'208";a="41619952"
X-MGA-submission: =?us-ascii?q?MDFlvSrEKLbHKAqAv4AsLQDuAaPS73RUyIyEt0?=
 =?us-ascii?q?Lyk/vR/2WvDjHho14Hxwn+622srWBk8xEHnAeCKj+EWZ054b2fMsh3rv?=
 =?us-ascii?q?IuejU4kvCE7w+YRYytbAH0PZ+JC9Re2KA1LhJiE2WTJTDC93fzvC5Fol?=
 =?us-ascii?q?na7g2SorqCFznywIzU5Z9PYQ=3D=3D?=
Received: from mail-francesouthazon11011056.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.56])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Jun 2025 20:04:01 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvyRSIWgi6/5F0xqd55uHkZ0QANlsxnmLE5a8WJLwxkoZnnkJo/OBs6xn48iEXvpRCcSvOp9Dd1/lbPcnzmoID0IwHYxllvNKWXT1PB+CxeU1Zm/by0EJtvwtjWDzR7Myss20aJ7AmekBXzaZfx8XX6Q4/9AFrmd860duN6Div88Aje8wV6pukApLeW/1WFe4NCb+joUSamJtcRsTasb91l/017zH2SksJDrY/lFkC9vUrb/NpH7KSVwfKLGhAP2127qEplBov43Od8UCAS0/hoMnbTOMKyyHhnHlM/vxpDFYlKLyKvVKVLAuvyPnbzmB9OlrvVaMcImTRiVSKUtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCngCOCQttNdVOlEiuSRmsh0CplJYJRszcWQ3igsth0=;
 b=x8n67gnUgZDK+kiVSPp/Wjh/cubvO77fA/+LFOuDxGxwfApXsMK6ZbMEJHxYIi/2QnW0PNPE2u20ayxGRJQi7Ne3SeWcrlSZwzRHXR7zLY7zCrBjI/eL43SCwGGptwzAXx9m2PtPwt2GmRjslBwnJ+5S3wo/hICIkfQh/2ezEcZU/JgCS+N6YydImw65DBr548FY9PfKU6oUN/lo9ng+hZunOqd3qgNS3AshBOqmdhX/i3McW8/WZA8EkJhyEeu/aVOY1dTQmhK9tFzG6IG4U+KR7fyR3Lj5bBRbYKWm3pJJxdilm0oaBav2+ZGnNy3ctX/Um9X63G/SMu930GH78Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCngCOCQttNdVOlEiuSRmsh0CplJYJRszcWQ3igsth0=;
 b=HOJrwgLMl7TL6/HMgheOGOImaqrmMsmqajbxdyGAQI6ivfsq2mmaFcqw3t/3MT/+SjFQpdpB0oIn+E6jpvrSeVEHpsXAGqhq0ydFfx7mnaeRFgBescw3ixNo6eVR/0nXzGqVYF3q/WGs1FmvTjSzNaLEV7D4Qa5Hb7miTmP8aDwGyPc6UjlZ+3lU5qWDQAU/TfwVrO148B7uEPJbAnm97SupGNEiREpkOpw7E25VEGZIogwReF4/2ZK9C9BPkjLvizpcyQjXlBxDvMmvmAvQLE/p5obrCfSQXJhwgitB/7z4VEyyCCgo+PlMFD7G6AoQtAv7gQ1094i8VN6jnRfDrg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB5PR07MB10238.eurprd07.prod.outlook.com (2603:10a6:10:5e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 28 Jun
 2025 18:04:00 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 18:04:00 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>, "minwoo.im@samsung.com"
 <minwoo.im@samsung.com>, Ethan MILON <ethan.milon@eviden.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 02/10] memory: Add permissions in IOMMUAccessFlags
Thread-Topic: [PATCH 02/10] memory: Add permissions in IOMMUAccessFlags
Thread-Index: AQHb6FcGq5ePd9GffUKovzXbYbuKFw==
Date: Sat, 28 Jun 2025 18:03:59 +0000
Message-ID: <20250628180226.133285-3-clement.mathieu--drif@eviden.com>
References: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB5PR07MB10238:EE_
x-ms-office365-filtering-correlation-id: 1ce6a04a-1bd3-492b-66da-08ddb66e2893
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IacpmdB6g0rHoupQTHv5r/9TCnC/tuslnWgtRFPpkMN/GGOxENajivsb+a?=
 =?iso-8859-1?Q?vh2QFKHbdJq6elS+BcqCqyonrbxgMAM5A9UYqeCzNzUgyeU4exUd3CS2BP?=
 =?iso-8859-1?Q?jlQQLYQD2pwO+s6AMSqS7bh7Bfe2k6+hYh78FM+K7haRbDS0HFdoDd7WQC?=
 =?iso-8859-1?Q?gAsEasFdYG+d6CskzjVYMYDVMP8G6bEznmmZ41m3DJqcrzebDodMDvGWHk?=
 =?iso-8859-1?Q?/pA4bKrhGa587S3ax3im+92VE3mUriCw+jGspTDRSfh9eFWiNh5e8k+hr1?=
 =?iso-8859-1?Q?1YYj4gLjrzeV8YOyLJ08V3P0x9qI0mJGkPWMOshQx0H2+eEXrh1HWsU9dt?=
 =?iso-8859-1?Q?tf6Si+8gQjxUiaCQdlJVicyeJlSU18Uve/F7yP8NoIyYIfzlNgyjbz7baK?=
 =?iso-8859-1?Q?ESmzgVpBp/3wnmUZUb7dqzfdFyE7NsmE7/R6hxd0drFEsyauOEtMU+meCf?=
 =?iso-8859-1?Q?lT9+36kHE3Neuh2Ee2QPt/THuIjhGe8o3DI9J9xRuXZIPNBdaRDR+3AiLP?=
 =?iso-8859-1?Q?yFdgPjlyDCByrG6jcQTnLvhdkJASM55ZtQy0pJquxnX3AsJ8v3wRkZFzxL?=
 =?iso-8859-1?Q?ABqYkw603E4e979sJB7w/Q7q+1dNFcDQzYmAvZaflH/7nxPnG3+zQvvUrx?=
 =?iso-8859-1?Q?EIwJeb0zkFTHj2X9MRi1RhqcSYlvpg4k/cGNAdETHGlkiC9afSclzz4eu6?=
 =?iso-8859-1?Q?fL9FAhtEN2FTj2nQEDY4BVixo4ksqQMkiHjfELGtdf9SQVqebZq6VvH9a1?=
 =?iso-8859-1?Q?1HBz6lQNucPR+QbV0jTifc6Bx+0phpzOgZiS75SgEZGgSIfXveQBpSxBFB?=
 =?iso-8859-1?Q?PV0b3CdKLcWwn3sZxgD3P0nohSDIHagQ70b1Ntfkk8qLPaL3Wa/MOIVOwQ?=
 =?iso-8859-1?Q?hmbbHoWW2BolxGmbUGJvpz7RpBZYWu02F9mPfe3Il0066c4Mn+BsksUG1E?=
 =?iso-8859-1?Q?+DOpE5+2Gn0HsS67Bj31oShyV1c+17mYUYuI4ZRRBj6YPOwxhrKnXuoaVU?=
 =?iso-8859-1?Q?+l/vbDFwJltIIc/snFIZbokLH6jpEy8uaH1T4VGv57MHc9mYJEy0cHzMro?=
 =?iso-8859-1?Q?KV3E2kGLYOhfcc1jKrb1q5G3GSvIcxk9K0AQ+CtCSnWZ3yKNpt41WSAwlY?=
 =?iso-8859-1?Q?D9d0Gm0fD783CAif5Gkr5JxX3YzvjdWzlo2s775UdJ/2gCDfT8IcvtcSzu?=
 =?iso-8859-1?Q?pM9NlKOicriaFgC197eXH7jaoC8ZQQ0gZ1SR7PtsD43DDdice6eK0mx+kP?=
 =?iso-8859-1?Q?sN949WNvQk+YaSZ75OuquYzJqB9XBNb+87+UvLkfFvbGizyjlM1Epkd4/a?=
 =?iso-8859-1?Q?QgR9bBGt0NsDeRlrwX1GagmITVZL1si2+ojAaF5PjORCKSXe8AwVitPqCf?=
 =?iso-8859-1?Q?YwDD7eC3vFLCURMOCdHzQOsc+TDizAUj6KSn5rnMAGbr2fKE6omTWSSBO/?=
 =?iso-8859-1?Q?ydVBy4XXCQWwOB1cW21O8+FPit+MsqWWk5YvFyhIMDvScnyXHxI7UjOViw?=
 =?iso-8859-1?Q?fFC0Uo6L2qR5UVp31Lf47ZbP96X19SRZ/p4LUAXLwrLg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aFv8NsGe98m/2EYiyATYL8/wqKHahFvgcsJasr9OJBfsLSUKiGg+qRGWzx?=
 =?iso-8859-1?Q?ChX9wpHss+r5k2EfOZ+2+RfXnoqa2mBA0Je8mypStgtrs8H8Z0Ehh1V/jL?=
 =?iso-8859-1?Q?GwUtVrtsi4RdrhfuQzaOgxoqwx8UCsyLdueMahphM+7eUPS8dV+oliC+1g?=
 =?iso-8859-1?Q?Jm1+Wd4kiPZ37VWaQKl5U+CWVnMwbx/O9cm+oFwsKaWhvlJciwiP9RTRnM?=
 =?iso-8859-1?Q?9PeUleQJV3BtvACIQGqXrmhkZqmvqtd1rCK2U4FLEVOibSLYBKIuPz8upj?=
 =?iso-8859-1?Q?DoUReWOhDQ+6+r4I7JUCpVo0fBz0c6+5A+Kgh1XBFI7rK279MhT0YYvVV5?=
 =?iso-8859-1?Q?qcBqjV6svrTku0/t5fGVVFo+YlNZSYkTsviZ+Rf9KlfBUaQN+F55YX8iAF?=
 =?iso-8859-1?Q?5Ifo3QxnBrFL/2QO32+0COdOMAVhaRunPb+vxkSzis7LU4P/+N1uNMocBk?=
 =?iso-8859-1?Q?KqEKfaFuB/vR/EbN4S/A3GjHP7T+vvLBQR1a/f/HePTDlvBz761pQ9WH0c?=
 =?iso-8859-1?Q?/j59qU+jyag0k0kf09vEiK0xxma8Rfe2C0EGx+gVy7P5pDr+/TU+0zsjkf?=
 =?iso-8859-1?Q?NApFvQdb4lD6t5vvGS8fDfyyg9qoKUezjguv4LLfTZrh15q2n0Q+kw4efy?=
 =?iso-8859-1?Q?a4LgGsrrhmFsxyyv353bjLbn9jcnZrF+1mGgGKJFhjp3e4KMuxRPWWZU2y?=
 =?iso-8859-1?Q?WqYEtp1HRt1+3i3uKX8CYk9lbcFBwUY13S9fSD2OFWzI90NAQDqlioTs8m?=
 =?iso-8859-1?Q?WuDBLmGmcHiOAzoKg8lT5cBzBKb2WSiHJXQMBF0WPxpnUOg59+xqeYdWJe?=
 =?iso-8859-1?Q?N4f/x9VS182Q/naaEiSWOM522rD09/rh5Nj7anTfo+vVk4K1bsXSZNY0DC?=
 =?iso-8859-1?Q?cryZHPIGlQQnUywQvn0r+oBjQGmfey37Nbe+HBmZTkJjoXz6px8NZOc/Fb?=
 =?iso-8859-1?Q?0CGqlfsos+a23qLaQDWgsQCAilzw0SbjguFnpwtkg7XNvDwVESA6L/1jd5?=
 =?iso-8859-1?Q?S7/ZfYxoTzRXnNEnloFT5hKOox9VoeMLFf3XeStDoGCy29pL2stacazZon?=
 =?iso-8859-1?Q?8zHN+TMtdIi0mDzZSlDA2xK5+V3r5MEPTbF8NNHHbG8Gw71HomZ6Q+h0gM?=
 =?iso-8859-1?Q?gYUuvBJwzz/8iHHOjL149rgrR3Slff1foM2RTTHTfrGnhzZYBe7S6QXCLy?=
 =?iso-8859-1?Q?SrcVAABj+3mvrl+nM1WKocBKTBbBFiwpvsHADagbwS+JWPZUgrMTbfmrur?=
 =?iso-8859-1?Q?gBJh3fplLerCcnuV1FFK8Hdlupgy0BBVFqYmEaEkBhPjAwGFStaPtmPdrZ?=
 =?iso-8859-1?Q?ZMstxvhBD7aNw/odsbZnM9Kpvqwy4ZEuzqNr7Klg4PP8QXcwcaUMkrnIEz?=
 =?iso-8859-1?Q?2c1vWq7RRwJnQobypNSqTqZ2gDxtjtkpLSvb4ufRdxOXUQ9uMO8xoMepKP?=
 =?iso-8859-1?Q?TSOmLmuv1PPtLjvouDEvqVSrukDoDBuZKCZzv7Ofu0kFmvgFQB4SlZWdj1?=
 =?iso-8859-1?Q?IVEKcjMPrMtu8bD7qzzG/EyKE4fGgJY1Nt7uxFo/8IAPT+EhxuOgfNebAY?=
 =?iso-8859-1?Q?lPPjBbIuulrhAIbaq03fEv5hvrj5+EHkDm5FE9Xx5QtOSPNxIUJ4oKcneL?=
 =?iso-8859-1?Q?EDhmBPwR7om8wCIv+h/TppFYT/YhR7zNFqa5RjvQHNc5u/AEfLs936PZSi?=
 =?iso-8859-1?Q?Fh0f8n0w6Pz5FvwIhAM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce6a04a-1bd3-492b-66da-08ddb66e2893
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 18:03:59.9832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6exXy097uwSGPktofouMtLfTMdpnN93QyV1uychYmwTMbqZBpko/LDQjgp/iq/0y0k46jVX9CWz1PvSVXLtYvYOVnl9e2UHi+2pDkqneIJ1QCkHuefavS8yjtE1QjYAC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB10238
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 include/system/memory.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 46248d4a52..1672622d70 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -109,15 +109,34 @@ struct MemoryRegionSection {
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
2.49.0

