Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EBBC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 18:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVZua-0006Iy-0o; Sat, 28 Jun 2025 14:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuU-0006Hy-GB
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:18 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuR-0004Ao-Sr
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1751133855; x=1782669855;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zigLduHSMJu7kryyGQFsfebMba3knL/vzvp8SuvvzbU=;
 b=B9os9ojD203TtEuFWXrm1CENq2DXL95c/quOWjmYkWvflIK+Al9Pfb7R
 q8n3z31IZO3/VpGLQg9x2ASHXsbgcB8ytO5eZuUSU9Fig/s3gt3xo0lOa
 SJ71kkyzuT5cwevqF/Lt2fkhUvHTLY4BMSInP7MriLm4awgOGO8sesyJv
 wudHhsVOaCX5CiTgh1VC/GoGKRHgoeYh1Lama4xe6HzuNsXSjlinrEBAx
 Jc4ThffpJ5B/GuM3jYp9MzJrScBPqGAKjKVeiOzNboxR/yoJFUcK8bxa0
 D8h6LLB/pLHf9kduGkJRgVG7Y0jbpBSStJXSrpAYbH6blyy6er15GGTez A==;
X-CSE-ConnectionGUID: z4GcSVnqSAmXN4atKxQ99Q==
X-CSE-MsgGUID: OsJwpRsKQoOpLy0kAyQRiQ==
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; d="scan'208";a="39505879"
X-MGA-submission: =?us-ascii?q?MDFW/CzU0Of0YXh4XUTr6EN3dj7rtaYTCfiVep?=
 =?us-ascii?q?ryF3K+fSKD7PDXX6bycPGBJEKe7fmBZGg8qLr6L5C073ia0KtGjfI1xj?=
 =?us-ascii?q?SfUMak0qEznhFPMDOlNzWLWIryHBZ2DFGJJnDwkvuUfKZZbKclu6wq98?=
 =?us-ascii?q?53rVKHC86FULNHD71hgkgppQ=3D=3D?=
Received: from mail-francesouthazon11011034.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.34])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Jun 2025 20:04:14 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwFM+S7BEizPk4HO6aI/d9RbpqT2qGZnabBr9Fo0bUxD0gKIz2wqW23LSVNZoSNUFXHGD96tuRTc5Ou8JcPpMP/VPzvzYyVdBLACxxoi31I32WoU9RkJoNjISmPnyOkrO2A1JII+6fCa9AAu2mei5Fx/vMwi9I1CDxw3uTBnjOUM5Qa+8BD6ozpUJpo3hb381VhrYQYVajXtDN4aOgIuGO/C0LeMtN0hxMrGrdut3ib0U+cxPgeN3rDQ4OijrBB/5x0RYFfp8eD8OIBak4tLK/+kJo+yg79rS3LeCPOxAqdFGwQ8SKHb6bAlEO5xOBj0G9+UYwtakvjFJPBMbrNLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azG58GmWcfxfOTTONa7DMMLwecnpfi2mo0K4NanvLYM=;
 b=pax1U8LcwOS5syvilCw0FvTgAjvH7T/F9tXelCb2b1R/jHxjoVIaC8JY8xQ46pNiEZ2Kiv6cf4xxqhDOmVt1evpTNrrHnsPJ4ifprMUbh2tVmqs6DM+q7p1X0fqAZTljn58ypk3HNa+oRWV8HvpgKVVnZsgp0Th9omE1KQcqIH60jJjP44EBQBFqGY1lv7e0hQQCczazC/ouyr6MBTH4G/V3gSHjPePxqtpZGIjjTiyQTdtYkl5fCBIw1hIrySDqkyq4XJx/l/qLWwE7iL0Yom2tepe84VCrcKmRhrEZJS74QNA60yWNzdhW1ykXItaSqu1X8YepN614FjJU5ZF87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azG58GmWcfxfOTTONa7DMMLwecnpfi2mo0K4NanvLYM=;
 b=nQoo3sN1BVJ239bv6R1XoZQeDXEJYwfnrz1WMwSuKKnOk7Z3umbvo1sabRto4ULXa0ZoJ2b/JSpa6MK77OUKG9lNcoBGDO+bjw3k7piknnwLmEoOmiuFd+rzG2LLjYNUmVzjBRq1f5c6iZdVt3OeXtSc2s2Sc/0hwfIGttzYGljwk+iRPtHEWva6c/Wn0KPKRZj56K2NFfg8MO34tUoDHwT1fWieJwbEC5CekuWC0P54coa8aTkit4wAcLn6PiXY+KN70QWioZ0p7HDCQh51SodhyGmftBIPvJbPlapJ8K0rSzagGtFZCkuWojUCocOP7LPJdBtbf/GyPUECpXbUyA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB5PR07MB10238.eurprd07.prod.outlook.com (2603:10a6:10:5e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 28 Jun
 2025 18:04:08 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 18:04:08 +0000
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
Subject: [PATCH 08/10] intel_iommu: Return page walk level even when the
 translation fails
Thread-Topic: [PATCH 08/10] intel_iommu: Return page walk level even when the
 translation fails
Thread-Index: AQHb6FcLG7ic2NBBAECkVIq2IhEE4A==
Date: Sat, 28 Jun 2025 18:04:08 +0000
Message-ID: <20250628180226.133285-9-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: e9dcc305-41e8-4982-6749-08ddb66e2ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?M/6ngx1QJdZ3SshtymwMoPq8T+BvpPzt7k1giisB89Kt5mWpktlXP6UCLK?=
 =?iso-8859-1?Q?59rt+2NSW0xUfOTon/tnwPL3QcStGafE0wC0ZnlRillgquyQq2gmso7Rs7?=
 =?iso-8859-1?Q?PzY9DNQ4vz0vOLOMflMasZwqGZph+dQSFIz52ITNF4QvZvL1TsmBpNFPE+?=
 =?iso-8859-1?Q?AOo9HtY/g/pBmW5edW5encCOyaij/Cv8MEQinbA7ebAOiiN5wqdIWdWcQx?=
 =?iso-8859-1?Q?BcmIZo/9hnEagzAja1On7RbV2XXcm524qVcQIXoeBRfmr4QUvkwS8G8hkp?=
 =?iso-8859-1?Q?TekPNIDuazEWZfOgIvfaBPKfDzMJxdiahbP9/iHi8+rXJz0HMV6s2uQKKh?=
 =?iso-8859-1?Q?/GNgETSyagawxHyee10u9u03h9Wjjf2rBtawq7LU7/XL5fsN1fuut0WGBx?=
 =?iso-8859-1?Q?BskkBzB5ve6yjh2PQ2A3PJvbm8RR1Yx/zDWIc5+sqI1QWH5YehL1m/HNS+?=
 =?iso-8859-1?Q?b9zA9jvATZKjYL5nfPKqRbHpb6FDMYx771c1kBwZNl6yPUBTm/Sr1gZBEM?=
 =?iso-8859-1?Q?TyPqFPCPCjVDK5dKhG7tiXEFsG4zM2Ium9hj+RDe9IOhrBd7W8snoE6mwl?=
 =?iso-8859-1?Q?b2DRWlNVJro+WpYPtvi3CYZIEwxtmGmn/upsZFqx1/OEesV0d0yW5egoKH?=
 =?iso-8859-1?Q?f+igdZdzz6aaRCUEikCmSru1LSTMpLrGlt5KTNHoJRMbLaa+/7cCUl3tkp?=
 =?iso-8859-1?Q?gKQ+sz7lakKJ5eWIVIqeIvthHs8zZCFR72bRm3b+cOJVwMuiJBoWGnVL64?=
 =?iso-8859-1?Q?YWQp7mHpkVISMJx1ja2Wyb4Yexb9sW+iJIZq9Qzw+U5sMcTulP9Sz3ELoY?=
 =?iso-8859-1?Q?wqbpig6cS9KIcfmn0V/M4kSw4U+KkMUyhp55Ad9yH9N5DKZXUkY1WDOrwk?=
 =?iso-8859-1?Q?v4UHDNudjXjlsmXDCzqCaiCEzg18iMwCbOXykpO/5bxeWzH2uNpGLSmWIm?=
 =?iso-8859-1?Q?q7BmnNiwAk2qtRyJ4d8gpjKACvOTTQDivJEfJ5Lfe0l+sizNBoyy0i8F2w?=
 =?iso-8859-1?Q?reNX0l8D9qq3cAprLlfSm7wn1iykiljMV1PEHd5v9FvJMvqS1qWGVPBQwI?=
 =?iso-8859-1?Q?mF1iImXYll2VgvOI1cUrA4sx1BUwfDBM8wsWlDfcpT7o28vUe7eHc+lF3F?=
 =?iso-8859-1?Q?t8FJD9nV/oMzJ5AmyNKQ/SPTmEn5bnXkIMDmTyVt7HxH0Tr3/+TA2xOl5V?=
 =?iso-8859-1?Q?3iKOj8NGaJFoBThOwvX6nDucDJw4eoyqvNZ1Xt/OtAxv3nA4n/WVpbIYdJ?=
 =?iso-8859-1?Q?0+kdip3pU8+o6SbOSGUf0uN5qheluzIkaxWxY1+pH5G1UeTaC9ZPur/5os?=
 =?iso-8859-1?Q?wkFQxzqVg4aZZnZKAdKmJZklh6FMBCR0kNPfOQwEDuaXejfKAy+eOxUk8c?=
 =?iso-8859-1?Q?ArjyodOtBocVo0zvpq+h7kJxdZgc+DVXt0mvP0NOJL0/V1SUcERVgzEbFX?=
 =?iso-8859-1?Q?8dYfCr6Fr8QAd6c12algeADPzrf/bpvB5dU3GqWJ/5sL1eI/sAXPUKnXSN?=
 =?iso-8859-1?Q?bd0WEkizUgJZwlHWcWD5trgU20VJnvnvU4Xi4ajb2Zrw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0dmDVW81/zzRd3cE4KE85ENdLh25w60Z2n/Nu7CQGuHpIg5/vsADB0idBO?=
 =?iso-8859-1?Q?uWVwwE/vKXA3zJYqEHKyfcQ7e81AUa+IVdhKUidwhN94jX14yyB1RMAFed?=
 =?iso-8859-1?Q?bJU6ZL4qHLyhW7tf0Kgrgh05a1mQQ6Q9ZmQJG1Jjk8Gj9kzhunUjaeQLCq?=
 =?iso-8859-1?Q?xnpxWymvJAdAYQPJe1FfPxFMOQKy/j/yXTDEmySHI9cHQybAjy977I1S5O?=
 =?iso-8859-1?Q?Bg18jHPMteJ8RBxq+oYVd4lYQWW0P5WVyS6cyYfvWhLAVvbUhoJTqOR5aR?=
 =?iso-8859-1?Q?ERxzrSZ2OjAdX5dpm7ycACMQMX6G2XUx+mImGDFtFWyjZw1j9xVciDO527?=
 =?iso-8859-1?Q?UgNGfyDa5b0glBdoh31uw5aTNanjJrE2HelxbuYVUlAWYqdAZhaZs10MM9?=
 =?iso-8859-1?Q?cKMP2rLGmmVxgU1XOOaPFDyy74bZtfZ3h031mc49PvpUFHHh1oShkUisfo?=
 =?iso-8859-1?Q?FIf5jhVMMbNTk3xGiPzCJ4LYoYZrtMLFKWt6x83KD3HsXLpLwmxXw+KVLQ?=
 =?iso-8859-1?Q?UIneJ8q0wNOQzND2D6YG2I4xf/v04C6bhcg54rMBV+79ftkEFW5h0bQBHP?=
 =?iso-8859-1?Q?sqhlnvweCSPKtDaCzNeetroXhkxY+kuUK0BXDIh/Dn3icijoyUzWidUdJX?=
 =?iso-8859-1?Q?smli5dASminXue449sf06GGRYnCyrroramvmWlaH69VJMArSkefRjLAdpL?=
 =?iso-8859-1?Q?IGXKRIp/w1vM5Xv7i9xwV0huYghgeXzXxmeCSBO55FF6rIrObIm1tBvoRD?=
 =?iso-8859-1?Q?9pWFddmu2SR7Bzxo4h0x8Mv6p3D/L0xAHGk3uTMmU+Rkv9UCUZTnn3uuBy?=
 =?iso-8859-1?Q?5FhUbtWsby+jVI7dB0cvmphVUdVXJzr0AF7PzknfE9AEReUKgS6TaJ9VaR?=
 =?iso-8859-1?Q?eFJLWT60P4JAfVN/NMuEowrS2AAerIpCt/NJ+NeoY+fGUjhAdBfmHRHKw7?=
 =?iso-8859-1?Q?bJha/CP/JGEf85Nm1yVfJMkrCH0J/7ga01DcC4hM4OkukVMpJQc054iE1W?=
 =?iso-8859-1?Q?nRZpgeGvw1lWsvKAq0I5vxFsCEam9BbxBkdjwXsKuK+UC3vfR0I4x0RDJd?=
 =?iso-8859-1?Q?qgd5AtW8yeQmPKCj784GfEthgK5EZO4g8U1pVUDVKW6K9EjTRCCPpBYVM9?=
 =?iso-8859-1?Q?LNoDPrQhint7OPo6kV4l0nz2BMsjUnSZVApb7ySMbdlU8tv6T8IYkbpfSq?=
 =?iso-8859-1?Q?xusvnHoumW2baIS4Sgt//Vz+tO59cQmAvSiBfi5QNdGQTWjqwr5vfZbhdN?=
 =?iso-8859-1?Q?UezktBelQTWM+mDlHu7K7c84fbjZCF6aFENdH0daONu7a857GkbPrHz8OV?=
 =?iso-8859-1?Q?B/Bg1S/enKXTmC1NgZoGmmkuwAjKw+8TjNXpVquZc3t07OpLWmLh6xxeNF?=
 =?iso-8859-1?Q?Z59bXpe0Cd3c4H/heRVUyjxQzCRjDzZ76jwfopm/D3ZEtdWXweD90tPMud?=
 =?iso-8859-1?Q?jkXeZBy+poruA3pUumSSvr9oEf2NPj7LmAQOuVuw+PtKYNKISVneyK7kqK?=
 =?iso-8859-1?Q?McF81JwgQY5ysDe5fQ+TpXtpgqs8jzqvOPMBdv5s3tW4uY0s6KAQAMDmlK?=
 =?iso-8859-1?Q?NnpkOzkmVef/n4scb7WkxUuY484ZgZA/VrQzac0GIjm7ZHPqYu0nslF0GB?=
 =?iso-8859-1?Q?nO3NDnDEMdIQ7yESZUfYyEgeihbaoNs1oIbE9jeMo/+GeNZWvOsuiVxs1K?=
 =?iso-8859-1?Q?Ecau64dvPLl+XZf/QWw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dcc305-41e8-4982-6749-08ddb66e2ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 18:04:08.8420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUlsytAxnmbxxlswbLZsXAGf6Owp45fJyXDNrxvE/SL/Mfourwb/dWaqEre4Bq1CBni0k63YdHztwVCONZQf09zUCZOReBL3BBVAZJ44u3YTqNCjty9Kk0ShxP5j8LYk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB10238
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

We will use this information in vtd_do_iommu_translate to populate the
IOMMUTLBEntry and indicate the correct page mask. This prevents ATS
devices from sending many useless translation requests when a megapage
or gigapage is not present.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 234c452849..bff307b9bc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1987,9 +1987,9 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDC=
ontextEntry *ce,
                              uint32_t pasid)
 {
     dma_addr_t addr =3D vtd_get_iova_pgtbl_base(s, ce, pasid);
-    uint32_t level =3D vtd_get_iova_level(s, ce, pasid);
     uint32_t offset;
     uint64_t flpte, flag_ad =3D VTD_FL_A;
+    *flpte_level =3D vtd_get_iova_level(s, ce, pasid);
=20
     if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
         error_report_once("%s: detected non canonical IOVA (iova=3D0x%" PR=
Ix64 ","
@@ -1998,11 +1998,11 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
     }
=20
     while (true) {
-        offset =3D vtd_iova_level_offset(iova, level);
+        offset =3D vtd_iova_level_offset(iova, *flpte_level);
         flpte =3D vtd_get_pte(addr, offset);
=20
         if (flpte =3D=3D (uint64_t)-1) {
-            if (level =3D=3D vtd_get_iova_level(s, ce, pasid)) {
+            if (*flpte_level =3D=3D vtd_get_iova_level(s, ce, pasid)) {
                 /* Invalid programming of pasid-entry */
                 return -VTD_FR_PASID_ENTRY_FSPTPTR_INV;
             } else {
@@ -2028,15 +2028,15 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
         if (is_write && !(flpte & VTD_FL_RW)) {
             return -VTD_FR_SM_WRITE;
         }
-        if (vtd_flpte_nonzero_rsvd(flpte, level)) {
+        if (vtd_flpte_nonzero_rsvd(flpte, *flpte_level)) {
             error_report_once("%s: detected flpte reserved non-zero "
                               "iova=3D0x%" PRIx64 ", level=3D0x%" PRIx32
                               "flpte=3D0x%" PRIx64 ", pasid=3D0x%" PRIX32 =
")",
-                              __func__, iova, level, flpte, pasid);
+                              __func__, iova, *flpte_level, flpte, pasid);
             return -VTD_FR_FS_PAGING_ENTRY_RSVD;
         }
=20
-        if (vtd_is_last_pte(flpte, level) && is_write) {
+        if (vtd_is_last_pte(flpte, *flpte_level) && is_write) {
             flag_ad |=3D VTD_FL_D;
         }
=20
@@ -2044,14 +2044,13 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
             return -VTD_FR_FS_BIT_UPDATE_FAILED;
         }
=20
-        if (vtd_is_last_pte(flpte, level)) {
+        if (vtd_is_last_pte(flpte, *flpte_level)) {
             *flptep =3D flpte;
-            *flpte_level =3D level;
             return 0;
         }
=20
         addr =3D vtd_get_pte_addr(flpte, aw_bits);
-        level--;
+        (*flpte_level)--;
     }
 }
=20
--=20
2.49.0

