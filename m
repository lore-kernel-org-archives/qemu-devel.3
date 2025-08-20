Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AD5CA0EFA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeO9-00027U-D4; Wed, 20 Aug 2025 04:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uoeO7-00027F-3A
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 04:41:43 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uoeO3-00031u-PV
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 04:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1755679299; x=1787215299;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=kh3Pzgsi0SFbM2GfshWB499cPkxT2rDkp0CG5lJIxW4=;
 b=Tpg1jrOjQNCw4Vqv/054Ao4KVDyvp1DMrahdKLbtifZkgik8vXAnpRUc
 VEV5TPODB6PhpRq/+x0+uloIA50O6vAPhzz5Kju4qEqv+lLpyUBpuvf8V
 VG4/VDW4YNcWRazXArQanJBv8NJG0X4xeX2CxxPiaT7PDq04ianfcVxDv
 AJHACCysMX5HTf1GgHwAnGi9/8/kF0ypu5dUL7YdwbegemCuSS5MJnyuP
 oArBbHKYiaBU+TMvsgsenlMrKl3T6SCWpxrn9eVW8T/kh7OFbJ7eDl1bx
 JeNMl8DqXQPMK7FC5mdf2UvTUfBrWT5DaCqH/CzF6S+vmdDnV/gw2qxnx Q==;
X-CSE-ConnectionGUID: RLRKRsIAQjugziqlgK1/5A==
X-CSE-MsgGUID: FWzKBrU+SgmX1onnqgo/nA==
X-IronPort-AV: E=Sophos;i="6.17,302,1747692000"; d="scan'208";a="41721279"
X-MGA-submission: =?us-ascii?q?MDHHwnvadPkysQOfKjjV636VrQY2Wb1hc9nvWI?=
 =?us-ascii?q?vERUxxdYZq8hdDcbeBQdYkolXF23zvi0NRFcsZBSLzibhrcxrIBOTTEi?=
 =?us-ascii?q?prLb/hSirXbbBn7njhD1LEBhMj2R6oXINqQL9VrkyIlde1qKRwK910um?=
 =?us-ascii?q?JOCeu/mvsWHB9aW5EUsrTXnA=3D=3D?=
Received: from mail-westeuropeazon11013007.outbound.protection.outlook.com
 (HELO AM0PR02CU008.outbound.protection.outlook.com) ([52.101.72.7])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Aug 2025 10:41:34 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0/pIgiRKE0WNeDMrC9rvs5D3O58p8fQ8VP3yFQWBYAu6mUZ/qqwH+BzmTSfWCYU0DxG3TUqbbcO+tes42XZp1U7jGLYXJyk/ZCMC7c79Ly0imyPvP9z1d6NUy3M1zj7EMvQu9Qpk8L8NpRU/3Nj+dxYiC8ZXKmrsdIDk0al5cETNhRjMiZxBkQPVB1jsP4AdKbH/nhKFTGFnQ3AwyadaVbZwh6Lpq65c+FlNbaTdaWOCxfyCJow7cvpdn9efSK/Dh8USBM65U5BJpnQ5jDYsSMOMWNYzvREUNftMNkRTKf2IDtMVsGZ1Hx9MMF3KVf3MzS4pMgeTj9+B9bz+pQ0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkCv+caLGoqk1cjAgXiNHJGjGzWVGfTGr65CykplT0E=;
 b=C5q4YbExcbroteevusq2UTXkRln1EZCUvUKk39vd/BSFVcyZH8ihKAe8BWK3+DKDk4wABcCjGhZpzKRDxt+SZFkFlvMJE7k8zMgRVVEXX+1duA4WLFXHWDMIvaplslJ6P8BfiCoLB1DmYfmUOHwFX4hiAtNdr1NuYQHjHvf6YU8V6EqT4gdelbm3twrmTFXdz/TEhY6Mc5QmDvdfVYN8hLW9DFIDzw5T6+3Vp3RHuqhpk6uqAIChdKDPs8tqt0DvY+Lgl6HAKVt7OaKoi3ApesUNTTDbPe7RU/d6JZjoOL+5ILnUcXFHOUiackZviPgBAAgu5X/tswfGz7QRBzekGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkCv+caLGoqk1cjAgXiNHJGjGzWVGfTGr65CykplT0E=;
 b=V+WNUQBYyhdo17W0v7iLJts/sGWuC+Yn1KSIaCkE6EmmUh884X80wBU53EVE3jItKv/vovzaNlbDjBRNkGwpveiDJy5bsbKiYNI9+QN0NT06OSmdDBw+2SQB6dW3Zu6PEGDM9SKpDjZTMdBl/4VHhw+AWrCcKNxawPa0zQbyXR+PDoC+wsH6c1fBFSUiCCcN2BxRjz5I3I+9jRN+coOSYlQRQn6cVNHNJFqnqxltKi0u147+NmQKXOFARdICoTkin2tEQuwjlfGmH3JNPOe3JpxHHuqrLknTZpg1f6Zf0J1nYNrZopeBCt16sN4NKnhD7hreSl1GffYPgPdO3VXFeg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB10702.eurprd07.prod.outlook.com (2603:10a6:10:5c9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:41:33 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 08:41:33 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "odaki@rsg.ci.i.u-tokyo.ac.jp"
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, "sriram.yagnaraman@ericsson.com"
 <sriram.yagnaraman@ericsson.com>, DAMIEN BERGAMINI
 <damien.bergamini@eviden.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH] pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
Thread-Topic: [PATCH] pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
Thread-Index: AQHcEa47CsbyPv83lkeRMpZl7TSUYQ==
Date: Wed, 20 Aug 2025 08:41:33 +0000
Message-ID: <20250820083953.439635-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB10702:EE_
x-ms-office365-filtering-correlation-id: 7470084d-1224-4f84-0a28-08dddfc55dbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?OXagh3bxCNj4oaWCAs1uTPgB80R4fte0i0eDMWNFdGUynvawwrlkOACzg4?=
 =?iso-8859-1?Q?dzJLLrnKttbzDSyUIoMRVlwHraniNkh6uUBv893XgFTuqhH4nvEGbE04cX?=
 =?iso-8859-1?Q?F6jIIhSFvbuzDJ2wZz655jwkjrxE13OQQBCrKK0H5TnyIiHmeFBxothN8g?=
 =?iso-8859-1?Q?MX6CuDC/qSw00EL3ZbbE7Rs4K8abXb8zlqTtvhQR2kAnd8fz4waee7pnKc?=
 =?iso-8859-1?Q?6Rft4Av0Ynp6ywk4sgD0PNKGOMW0sbRgcNMYQic4yrzt3+KeEZSlOxSuMV?=
 =?iso-8859-1?Q?K7KCxEWkKcsiRm0tfMyaK3su62T2vtdp1ZxR0eYv+TqEI82CbuWpNERv5s?=
 =?iso-8859-1?Q?zFhvY7f2OnzfFCJ7y4kXMhfCNO3e4GmeIpAEtsWLXxtTpAu2clf5pu7VH/?=
 =?iso-8859-1?Q?Aj4kO5gjvRc6xhWzK+ewZwgKwg8FUdUoXNS1oyx6Cj53EkK7C7I49vo87N?=
 =?iso-8859-1?Q?h3pUt93mchyAEgg/l1oOPRCrmRTwJbutd/qqkuC8xCF4ZuqPmVW3DDxlet?=
 =?iso-8859-1?Q?iyXl2My7tdJ+Hz2gVhizbGoW/aElabKdqHmzCeoEoX4Qy0mpBbEJ3ZTEz/?=
 =?iso-8859-1?Q?0KyTwMOOXHFPRhhPLpc8rQOIkBDxAnVtdQgTn+ZNBRn1A+rclcj4j+1Ijb?=
 =?iso-8859-1?Q?fSJsSqmQ8gedmK7oAtPHLMA+qLjjelqjTolCJ8kOkvJL4ICM0lB3OYxuxR?=
 =?iso-8859-1?Q?XtFrARcJgexF03Y1hIbndTMOG/rHfFWtSzY+MBKr9T/JwW0dkGnY+GfOhc?=
 =?iso-8859-1?Q?XTSKVh6HQXhwa9qbn8jGoqflH1gQ20EW1hxk+RtphPIKp0AHfPoe4CK8Jb?=
 =?iso-8859-1?Q?RlWcyMZAnpRsJng8Pz/skqTtCWd1XuxbsOEAxNf/Axo7I4FxF4gDi/UyDR?=
 =?iso-8859-1?Q?kHr2NXNUZaMeyuBbTkkXdqy3rlMqhWAunQEzlhyMC3D4Af47+9GfTtMCxZ?=
 =?iso-8859-1?Q?dntNOrBTIoX6qz9ob0Mx/pEvrGFjVbBvo/f3X7MVVEYI7rEFq34JK7AWYH?=
 =?iso-8859-1?Q?ju1JvmvgDKlJ3WzxiEZhx4jX1u9SN38xNPCKFQL942J2tgi8GV4k6v8qIL?=
 =?iso-8859-1?Q?q9KHHIxr3wu/zb+TzVYzFaVMIsvKL8ksmL7ltimqGp3gqyCTJAJ/80X+mb?=
 =?iso-8859-1?Q?ideKKonU2DJzA03n2eN7WV4yDKbky5yVU3uUumlndT6mQsKBy/LXGg3Jok?=
 =?iso-8859-1?Q?GkgjXP3OskdvpkKN/FeUqEDu7HEnRSYd95hXUwLQFkWoi2J7pYUH1byNS5?=
 =?iso-8859-1?Q?So5Bwqutc8sbSTOeE91TP7kT0K38oqqzwgzdD9IlZD8Tqj+bL/4sbRx5sK?=
 =?iso-8859-1?Q?cAD2U15Da9BaNxJAwnfM7/7kpXdTq06qfO00iDZPJM8s2fiq8VITL7Dmg8?=
 =?iso-8859-1?Q?eorpKbGa6XhJKENLESe8Xnd4rM3KMFuUTMtrAhH0kUnBNMX6VgudYNi3wn?=
 =?iso-8859-1?Q?ZEhNztdTFR7RVN87OPixRhA85qVyNXp+ZG5o4S2gxIR/TtVkQQUObv4hLC?=
 =?iso-8859-1?Q?LlRqseQynv5WaUH4B47a82A+Atfn2cnKdTnDYZjXf9fw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Tu/a7Fv01EuDb+NINei5LCUfq+mX87Ub9iace9m4bJKmutGKLydh5GSBpd?=
 =?iso-8859-1?Q?ADMBM6Dd5tyK/CTVQh3sT5tzZOqu9oB1YV86ugeccSmwlTbtmc7JMWDnz0?=
 =?iso-8859-1?Q?XD6U768ONZrojzhfmXSS804NMkERgTdpBToLAr+bRPy6D70FCDfPzB49m3?=
 =?iso-8859-1?Q?9+3GvLujRNDOmKiuMP57tgdb8aXYkQqP9o4BEBKgscjyYw0ob1scCkg1a8?=
 =?iso-8859-1?Q?9ebon9PfWXUg462Wt/0AfP0lXNneko5KSVEkT10WgO/jbHrhdckfeba04x?=
 =?iso-8859-1?Q?Mvv68U8J9hT2NzfRY6Aq31XIUR2TernWKYAnbgUwHUZGjs1Zb6wuHSGKcP?=
 =?iso-8859-1?Q?LzgqCKK+WhZ4F/F7h9TwuWekIFwihssqz+h95XE1tUMJEFZQk0PfhDQq/X?=
 =?iso-8859-1?Q?VqLWuUPCc+wvYpLGCqtE6FHXAjWbITrHAQokNqXIdS2O/nR0wZ7+53llx1?=
 =?iso-8859-1?Q?wM7tn+1fgiygJTew1IVbQigHzFd6yJBHyNhv+Evt7C1/qPoEs05QDwa4Y/?=
 =?iso-8859-1?Q?vW7z9z1vRLOr2sddZGFwglKGZzK6eFpi+HUP5a9LNFg1UYx2hMO9lEHROj?=
 =?iso-8859-1?Q?dsJ89luO+OnFzIBdk3ZRVPSv2BQ6nxAY0zkntcIHp6wGWExbtv64p7cau+?=
 =?iso-8859-1?Q?+hEY5pJS4QD5U5tiarz6Eb1vv4S69CqW0YgpZuFqArBkEqq9YSMThS2oyg?=
 =?iso-8859-1?Q?sVUUW8vK9yd4EGEju1z3rM3hjNZXWXsPgjIPRnbS5ggn1IYz4WgnRvJTPG?=
 =?iso-8859-1?Q?vS56MOfaXO2zmhfN2bIREg25wegCzEFzqvEGg/YdxbtPt6+aL0JhIkRnbI?=
 =?iso-8859-1?Q?GWSCglPZn6U/cEiArQhW14H5RpLuXjugSSH2ZXAChWtEA0QV3ySkHVvcpU?=
 =?iso-8859-1?Q?C5veuD5PCkaB6MNnkaWcbd1waFxMBGKyDYEvu4Qn7/Kh5dwlcmIioHpXzS?=
 =?iso-8859-1?Q?8VWKdcbcFG2V2BJrZTUaFoAUX0c5fp3VoWD0hLpZ0StAV//WSB2PBSWHJ4?=
 =?iso-8859-1?Q?R3Z7FiwVzoJMAnJYH8mW1RtvMUQnYwGe70LVrjnADNH3Y05FWlfqOqpkA5?=
 =?iso-8859-1?Q?iRmAMPp36aUHuyvMjCk0EbnY6ZIUPlzYHyOqQdYLAANM/+tyqxY1B3mXHZ?=
 =?iso-8859-1?Q?/KXnZKn3I9A68dxU/maXyxBVwSYyaD9XQWoAbZvAdnDJDExxPzk4AjRkvd?=
 =?iso-8859-1?Q?3t2DMHZfVzGz+YEVJFiwuQHCkBObyrNjTd4NaM/wzYbHIunprKLas9snci?=
 =?iso-8859-1?Q?FFNNYJVlfbgV5oewjqNKkU5VBwM6brM0TkOuzJ/sQ0x3J0evEmdGekwcvC?=
 =?iso-8859-1?Q?BZ5qNZQPqIuw7V+O3ORVseKRHvBa71a65vgzegxIUTJeP0b2JsXgCZv2ND?=
 =?iso-8859-1?Q?87Zjh/E621Oh0gKgnarnKDB3pSpsqQdxYyPfPCVHSnUl/uHYZJaHGwcc+S?=
 =?iso-8859-1?Q?wfQfkCRnA7wYZPOzW8jMjCD7od4H4UqszRR0xuBveAoXU40Avcb6dAtxDk?=
 =?iso-8859-1?Q?mimw6GJ5m1LLrccQk9b9OINJvW36LERRy3OMxipgy7NJwcny0PCcSkRmQO?=
 =?iso-8859-1?Q?AbdoGuN2OJuvshPcln5ojNurwKvNn85s+ywbERZonXQYXSJ6pDhqgsh8dv?=
 =?iso-8859-1?Q?xV9ATgcbhSK9QbcCD2BWAhPk/Mkp2zuilYW+vH6/mypzbSQm0mUftj3vDd?=
 =?iso-8859-1?Q?Z1BkPzr8WDVgqVOEry0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7470084d-1224-4f84-0a28-08dddfc55dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 08:41:33.0472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fagkuj0cCd2T2FXFz1ZcQ/Ojd1vDDtNVT5AbLZs416q+lkeDLjtMLpuWr+kJKQdEWYTfj9C5/3oiM5WZrVQ2ZU0aBhQ/EUcYkvYuksnSsEXwWrGP7zz+IG/v1Ej8m7Ze
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB10702
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

From: Damien Bergamini <damien.bergamini@eviden.com>

Starting with commit cab1398a60eb, SR-IOV VFs are realized as soon as
pcie_sriov_pf_init() is called.  Because pcie_sriov_pf_init() must be
called before pcie_sriov_pf_init_vf_bar(), the VF BARs types won't be
known when the VF realize function calls pcie_sriov_vf_register_bar().

This breaks the memory regions of the VFs (for instance with igbvf):

$ lspci
...
    Region 0: Memory at 281a00000 (64-bit, prefetchable) [virtual] [size=3D=
16K]
    Region 3: Memory at 281a20000 (64-bit, prefetchable) [virtual] [size=3D=
16K]

$ info mtree
...
address-space: pci_bridge_pci_mem
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    0000000081a00000-0000000081a03fff (prio 1, i/o): igbvf-mmio
    0000000081a20000-0000000081a23fff (prio 1, i/o): igbvf-msix

and causes MMIO accesses to fail:

    Invalid write at addr 0x281A01520, size 4, region '(null)', reason: rej=
ected
    Invalid read at addr 0x281A00C40, size 4, region '(null)', reason: reje=
cted

To fix this, a type parameter is added to pcie_sriov_vf_register_bar()
to indicate the BAR type. It should be set to the same value as in the
pcie_sriov_pf_init_vf_bar() call.

Fixes: cab1398a60eb ("pcie_sriov: Reuse SR-IOV VF device instances")
Signed-off-by: Damien Bergamini <damien.bergamini@eviden.com>
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 docs/pcie_sriov.txt         | 2 +-
 hw/net/igbvf.c              | 8 ++++++--
 hw/nvme/ctrl.c              | 4 +++-
 hw/pci/pci.c                | 3 ---
 hw/pci/pcie_sriov.c         | 6 ++----
 include/hw/pci/pcie_sriov.h | 2 +-
 6 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index ab2142807f..77d618b36f 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -83,7 +83,7 @@ setting up a BAR for a VF.
       pcie_ari_init(d, 0x100);
       ...
       memory_region_init(mr, ... )
-      pcie_sriov_vf_register_bar(d, bar_nr, mr);
+      pcie_sriov_vf_register_bar(d, bar_nr, bar_type, mr);
       ...
    }
=20
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 31d72c4977..88dd8fb516 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -251,10 +251,14 @@ static void igbvf_pci_realize(PCIDevice *dev, Error *=
*errp)
=20
     memory_region_init_io(&s->mmio, OBJECT(dev), &mmio_ops, s, "igbvf-mmio=
",
         IGBVF_MMIO_SIZE);
-    pcie_sriov_vf_register_bar(dev, IGBVF_MMIO_BAR_IDX, &s->mmio);
+    pcie_sriov_vf_register_bar(dev, IGBVF_MMIO_BAR_IDX,
+                               PCI_BASE_ADDRESS_MEM_TYPE_64 |
+                               PCI_BASE_ADDRESS_MEM_PREFETCH, &s->mmio);
=20
     memory_region_init(&s->msix, OBJECT(dev), "igbvf-msix", IGBVF_MSIX_SIZ=
E);
-    pcie_sriov_vf_register_bar(dev, IGBVF_MSIX_BAR_IDX, &s->msix);
+    pcie_sriov_vf_register_bar(dev, IGBVF_MSIX_BAR_IDX,
+                               PCI_BASE_ADDRESS_MEM_TYPE_64 |
+                               PCI_BASE_ADDRESS_MEM_PREFETCH, &s->msix);
=20
     ret =3D msix_init(dev, IGBVF_MSIX_VEC_NUM, &s->msix, IGBVF_MSIX_BAR_ID=
X, 0,
         &s->msix, IGBVF_MSIX_BAR_IDX, 0x2000, 0x70, errp);
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f5ee6bf260..35a82d2037 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8709,7 +8709,9 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci=
_dev, Error **errp)
         memory_region_add_subregion(&n->bar0, 0, &n->iomem);
=20
         if (pci_is_vf(pci_dev)) {
-            pcie_sriov_vf_register_bar(pci_dev, 0, &n->bar0);
+            pcie_sriov_vf_register_bar(pci_dev, 0,
+                                       PCI_BASE_ADDRESS_SPACE_MEMORY |
+                                       PCI_BASE_ADDRESS_MEM_TYPE_64, &n->b=
ar0);
         } else {
             pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
                              PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c70b5ceeba..4fe2626f9e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1490,9 +1490,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_=
num,
                         : pci_get_bus(pci_dev)->address_space_mem;
=20
     if (pci_is_vf(pci_dev)) {
-        PCIDevice *pf =3D pci_dev->exp.sriov_vf.pf;
-        assert(!pf || type =3D=3D pf->exp.sriov_pf.vf_bar_type[region_num]=
);
-
         r->addr =3D pci_bar_address(pci_dev, region_num, r->type, r->size)=
;
         if (r->addr !=3D PCI_BAR_UNMAPPED) {
             memory_region_add_subregion_overlap(r->address_space,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 8a4bf0d6f7..eedce6be1d 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -242,13 +242,11 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int re=
gion_num,
     dev->exp.sriov_pf.vf_bar_type[region_num] =3D type;
 }
=20
+/* `type` must match the type passed to pcie_sriov_pf_init_vf_bar() */
 void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
-                                MemoryRegion *memory)
+                                uint8_t type, MemoryRegion *memory)
 {
-    uint8_t type;
-
     assert(dev->exp.sriov_vf.pf);
-    type =3D dev->exp.sriov_vf.pf->exp.sriov_pf.vf_bar_type[region_num];
=20
     return pci_register_bar(dev, region_num, type, memory);
 }
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index aeaa38cf34..b67449f8ba 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -39,7 +39,7 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region=
_num,
=20
 /* Instantiate a bar for a VF */
 void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
-                                MemoryRegion *memory);
+                                uint8_t type, MemoryRegion *memory);
=20
 /**
  * pcie_sriov_pf_init_from_user_created_vfs() - Initialize PF with user-cr=
eated
--=20
2.50.1

