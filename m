Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3C4C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHFl-00018m-I9; Tue, 20 May 2025 03:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFk-00018d-Gw
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:08 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFi-00027W-Gy
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747725546; x=1779261546;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Czf/q5q5Ywv0gFlffuweTfPAr990Xvortqu4IEIiO2s=;
 b=hkoSSZzQCb6lgrQVi9IbO8yaf9le5eq2GxMUTlQWXseCRc3PQDcKQwz5
 P5N3oJ2JrhzPucP3jFWfUldWpnKFJWxZKMlyLzATCpKRNmltI+Y2LW5rI
 AcugnR/pI+/DQeymBeZnfXwjJ7f7mMeZWY50ft4atkJQxp5iuy2zkwR/5
 biWYr1N4vY9WJS/SNVQjEgovQgeKIvg9gLR8448YHjCloCH/lohW++7fi
 LULo30DfsYFJpUp2f1MAWiuy1ps44Kp6jxv5eaxucfvjIPxO3490MPp/m
 sWsAChAaojMTw7FcY4U01vg4zDc50uIvIbqiyrtTW1R6wQhXbKwSyXUec g==;
X-CSE-ConnectionGUID: J93k6qNuS/m8TxW0oaKHlA==
X-CSE-MsgGUID: 6CLShqEoTtODA1AvnxLCnw==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37190743"
X-MGA-submission: =?us-ascii?q?MDGozPGirG3S6jvNb2dMsmWjcmxZ2JWBSqxk7n?=
 =?us-ascii?q?QqGZ7d8f5+CafcYwtF6J+32ZLBcwbY4nOYXNqmRTmqbOQOMypIIIdPFd?=
 =?us-ascii?q?yPvw1ysRSSYGuIjawPDMNrxnbkiGeDRjJ8ohEm9aOclPqcRXJkpDKn3I?=
 =?us-ascii?q?hv3I5HK3jUDUBKVnqhY3Mvbw=3D=3D?=
Received: from mail-am6eur05on2078.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([40.107.22.78])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 09:19:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4BuNzpueKu5n1RFctyr+v7Etw5ylMkA/R5F6FPWvfWtn6vHBxkox3Vff5Is+AWF5rQJdu99Y8/dSQCJm6KXTyEuLlrUZ7kmtCt5UFieOvFX5JtGh0//jq+ajHjcia5O8uk8gQPeY8mXfbT32shx/Acgpl7kevqQ/HYLQB6P2ClBIOOKa0OPmgPpuTbDg4qZN3ha9ffX0hcX1MaC/HTUUdD+cAsK8cNT4AaBZ52TF1PSx1z+jNfyoIx22sQ1XEKbnzBDrbma3lzLfTkxHuOPeARBH3h07Uz2qx70n9OH1dIXaOYcJwKjZ/h3LC6KmbriLqNT3D30+/n3gAPUplYvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccd9WNN2RekrlLPOimMvN0jQBmypIiE9bh/93osorek=;
 b=R/RZhQteczfdGGY7ULHa/SaIYLRCGWStvqg0V1crxTRgG41UvyayHaZnI/LUMQlELXBGiJzvzSHu1dMV/U8LW/66CYAjh+VFFaESxM1qmKXgGt/xAyG0PXWI7m5hJemjvDkeMcf8s5fgty2fgggQ5bCrkT4gJhKux87ZSyNgVDwM0UV0hEjBUfXiqqbVkYLGzxLVJi3q0oh6bcx9JipIKvLIXvYS5RzUNe67vbC8zcXV3Gj8V+VaEMlsnu5TrthIVmNc8FRzsciUvTQqOI/xXqANVGxvQCvRkjHZFAS3R+8pmN4Kq13sCmJwX3epJIlvn0R0+xocp9nmbUX008igBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccd9WNN2RekrlLPOimMvN0jQBmypIiE9bh/93osorek=;
 b=WQ8AlxOd1kibrYA0gsXY16NXqYlvBwl6yP33b5GsIZrw6ZeZISeKKbJufhFj82wWUEmntCJzwLih9qlGKxBHu3kXiQ6t+Xr0igmTbShlFzj+3jG2Dg7gUyo/aibmyVVPBrMEu4bL1VjpOfG8COE6vMQVQpDwgOuKaTaw0s6CyUqzU6IkyFeMPh/tIg7C1Gv0zaOODVMEr/d0w9g8s3fyZqzEp4wnStp1S4+t2nx7SEGMS4m8ncZsRjxBZ5ner6u+zXCzFv2xcSu5F/RPcf7JETcDX9hkr1V9DWkxz20n+TxU7Jb4I6KPtvFJazv90fMzk+J+cNCxce4aIJJi7RuL2g==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM0PR07MB6388.eurprd07.prod.outlook.com (2603:10a6:20b:157::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 07:19:02 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:19:01 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 09/11] pci: Add a pci-level initialization function for IOMMU
 notifiers
Thread-Topic: [PATCH 09/11] pci: Add a pci-level initialization function for
 IOMMU notifiers
Thread-Index: AQHbyVd2L9vUD5WrZkKPGjG6r0jKuA==
Date: Tue, 20 May 2025 07:19:01 +0000
Message-ID: <20250520071823.764266-10-clement.mathieu--drif@eviden.com>
References: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM0PR07MB6388:EE_
x-ms-office365-filtering-correlation-id: 190636e7-b44e-420f-3d8b-08dd976e98a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XuPjnvONuvadLWGLGHMnu5sp+n+OVCXND90mc/cwMf8Li3XfCwZU/vl+zH?=
 =?iso-8859-1?Q?qeE/PmVFR0lDyZlZrME050wN7KAHS42m89IVo0orp5VAmCJG2DDXk2GP9P?=
 =?iso-8859-1?Q?qh4tGu8EcqnrEG84zy4jaIofE3s62cG4IVfA7Fve5Zc7HhzSijqmfHu29s?=
 =?iso-8859-1?Q?cPftdRRyMkAlcmCALxQ1xHSAruWLpGBl01jZfTuzPoTeeSI+1BSbrspPVP?=
 =?iso-8859-1?Q?IyFbScod2em7SDnbeI2k7oL4+JEc8ebclRjCBiJXG2Zl0wakfPAUiwNGlS?=
 =?iso-8859-1?Q?17anBRWYKwhBydeGbRvhmlkWKhlvIWusvpSD7VNn/EF0yP2Xv11QeAlSgD?=
 =?iso-8859-1?Q?j5IicNbsl8TUVvAR+X2/TPqRG81ywYH+gcw19ZHz/J4JbTCyblODvRSR2+?=
 =?iso-8859-1?Q?mCxOL0fBXa2rawcDQ33neN67m56i0olkPlAiTE/fAVgiaqOWyPQRblOAV+?=
 =?iso-8859-1?Q?b+QMvuCGSCwjOd3ZIsczJkCTl842Udlj6Axo63Vh+qlaxxy6lmxmzIO6J9?=
 =?iso-8859-1?Q?VJTrvpkaNWZmjkmFfGOqwfdE2iuN/VHREWqKeyOVMXuzGZtfV+taMuZ0N8?=
 =?iso-8859-1?Q?w+GVdgCvSiDKHGlF1AVM+oNcldqwRreBxbuqRAiNYpA2EZSPb7PR0MAoGy?=
 =?iso-8859-1?Q?/5oqfeloC9//GGWe5wT/s6cZrYdew35IA2ggX90KsE+tnhoMXpyHdD+Qfy?=
 =?iso-8859-1?Q?XeHurf3N2EzVG7Lyh7TeekiO3sSN6kWHUpNOa8mD6vNZ4J3DqRPqjgz295?=
 =?iso-8859-1?Q?vPprD3PINK3LF/o3Ii+y8wpd3sb42a0Q4YjYdUf/YzwBpTwBAHcb4wIoBi?=
 =?iso-8859-1?Q?OhqGvHB5b7XRglLhYlvDoh9zQzRSsMNnqaw2B42wyp1zzrsJI9lftAF0BE?=
 =?iso-8859-1?Q?1dyRK3JlXMQwhYPaj8IDLEPRALmGZdamvl6/ibmD4Bu+VAX6rDNCn6ydvW?=
 =?iso-8859-1?Q?CCbgVsEMaRL5aFipkThRV5k34CLbfOo357jU0LD+7BYqNBtlGsc7NVSN5Q?=
 =?iso-8859-1?Q?VOlrbxwCxsa3Yyq7pRgNlYESh8o/C2YttbjOJzWIzTH3meUfncK39M5DkK?=
 =?iso-8859-1?Q?c4N4pjxZoUQkH67G8DA+0SJi4XiamKBKQ8MFKUswHXjPe2lbveXOl1ElxH?=
 =?iso-8859-1?Q?IvOPRVgXhsvFmm3198kwBmWLfYV9sAlY+DTl1HV/xzAYaydn2Or8SLgBBE?=
 =?iso-8859-1?Q?wPs23tvjx4UrvNPK9z7rC8MR+2BQ4J/ENtI4HoOuRC3f7wNmYYptQA9I9f?=
 =?iso-8859-1?Q?ucyNW53vrOd6z7EbgzgLkheXH1Y8Kw8QM6UIyHsAsTqihl7Aqvbhg2+EJ5?=
 =?iso-8859-1?Q?410aq+nPymh8SRpvVqjp7w+sKM9W9oThyZ5A2/Nl+s1Ci/OPYEoNOfdSrt?=
 =?iso-8859-1?Q?2Pd4BVxhHR/bXQ5fFBSRyoKCEocvp6wyaqfTfp/Z5J69Rk2a41AfPtWuvl?=
 =?iso-8859-1?Q?UGvxcOP0zg8LGFr8V28avDXGDpIVala23dhA8XLEAkApx8w78VpEypzPel?=
 =?iso-8859-1?Q?SHpMyh6SoNgPWKgwbRUb0BnBZdGQg2HemZDBLJ/ABNP8A255LYazK1VE3U?=
 =?iso-8859-1?Q?GZpAKeU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kztIeEZNfK7Oerzm7JFu05MDvS0yh2ztPU/Skf3R9+qFKJ67QnXg/rcLsA?=
 =?iso-8859-1?Q?a/AQIThtVk8MyBU0mGGF1Wo9qVJXSOXUxilpxA2n7Skkc6nbGD8tBJfn3h?=
 =?iso-8859-1?Q?xyzB9OwQe+XY/sgqc6yr/JD9BsKQVm+F0ihAmMXHPlvtMOuVQJTWYb2GS3?=
 =?iso-8859-1?Q?hTOZegKx69SoebucPZ7A00tsbSqqwnFMMUea0RI2fwsUtmBxCSRz1rkFnY?=
 =?iso-8859-1?Q?fmkU6rVKua3hbRJ8KjXH9JTjmq8u2goERHQky6y/Tq1aKyya9s97E+0wfD?=
 =?iso-8859-1?Q?mtdYwVwXuaZT+LByw2EVxzfptNLyEDJRHjb+UrCuLjsfWpTUN3AJzJmW5f?=
 =?iso-8859-1?Q?azinNIw5uqO/+zVHAAlty1pLQKF5DHbPan6qu+hZbOXgPejJ2gTJN2sdX6?=
 =?iso-8859-1?Q?bytVWfV68QTOXRh/niK5J4ItB87hrNp/BXhyPphRcxcK4AvnXGmzwfvYrP?=
 =?iso-8859-1?Q?Ep6pOLIiA5DojnaTrcaMrBIf0XzD9DY65Py9EcmybjqqGXk6jgsXUHQ0Ho?=
 =?iso-8859-1?Q?xwGxzQDlJOdH5oIUEBsqo5RZ/mZenGeKKdve4MBFaH2w4Ukw6c6YyAAk26?=
 =?iso-8859-1?Q?uHEise9+OyWz0079be3ytiwHTDwnPi7a+CWXfD+lsELEf8Uskxvn1Wj4HQ?=
 =?iso-8859-1?Q?sFzZ9af4xpO4y4inZcSriJitjGbtPobt37FJNOm7WsAMWZ+qgfroEAZIpw?=
 =?iso-8859-1?Q?+eU9SrDdg0/USTH5veVSUFK2wLkOWjJoNiDmjzgWsbKsSqeBp/9w3gSeYF?=
 =?iso-8859-1?Q?xPLyWIykZL/sr3/f7qI96IPtJGa6ei1KxhVZ40r5hKvm7EzAHVu1+QWXut?=
 =?iso-8859-1?Q?ArxWsEzqXl+Bb3LQ//IgfEmj5Y23jBYt708VWv/qQ1c26zpnNhjr1zEoHK?=
 =?iso-8859-1?Q?pNni7jw9PIMQ8nvz7F4X5KKLCOtLiN+ZtUL/eH/DkkFf3QZkNsXDs4Cnw5?=
 =?iso-8859-1?Q?IYoPYxjr1MS0MoBZVTDvRsMdFRB4d1jK6LTrwfe6YejZ4UF2XnYT83oeWJ?=
 =?iso-8859-1?Q?wF7RMWAIejs0N1AUSP2/ezn+I0V8P4jhi+2jATyg2fpB9u/LEGWiutTBcX?=
 =?iso-8859-1?Q?ziXrZzoAXSbMJXs3eVAaS/QOCMycAOeXFuOVTnXLveUuVhPVabLoE6FB9j?=
 =?iso-8859-1?Q?0GoP0XSRsxFBLstbmmlxu1MOg8OxPLsF2auS7jVm6LC8frz0FIC2FoJfGs?=
 =?iso-8859-1?Q?8IFCYvo334XCSkfP6LgOvBSVegYPbi3LfZNV/q6bABQkiEL9uWYB2RiBBY?=
 =?iso-8859-1?Q?5s1w5yLzlNFkYRVgGGMniPCac2ClRQPiIET1kwaDlrPujlgyygAWOKdQpL?=
 =?iso-8859-1?Q?AxCq/uz0QPBGeLHDvnfdkolIiaSvabFe5Nr21Si1oa5F/koOUte5M/Zb3w?=
 =?iso-8859-1?Q?Am/MWqEiaLX+hc34uzmNbYyIh+8OG8KB1DsFJvLMTcPSxCZhVYmetR9s5E?=
 =?iso-8859-1?Q?bu8VqaRkgZflcGR+7RAzCqWssQY2c1mdEEQOE40aytxQg5rMPYFZZj0P2L?=
 =?iso-8859-1?Q?bo7LKCHLsraz6wfwC801QR2R3W2v3QFaPsUs2oJiFDR0TWqha7jRkV4toB?=
 =?iso-8859-1?Q?TwEl/rggLFqS9W6Js6hsVhbGiehED2w00PGCOrUJS9T57cIqJPWBTWYnRP?=
 =?iso-8859-1?Q?3JPR3JNLS6XTIiSEXxcRCuaPBumDb+E7/teTZzsoEwLuLSIw+KcL90USTV?=
 =?iso-8859-1?Q?OanblRYsHQouajMLYis=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190636e7-b44e-420f-3d8b-08dd976e98a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:19:01.9242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssj0MMhzkQyUHwRAmxVaSkN20EN+9SG4Y+u6QnBxDxd9GS6GExol7oy5xcKvjWJiPVjdF/ex44lqG6r+7ApBSQeAjf+/Kggro8fUn2li7FOJXg1R3jTUpDGLHBrww8YU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6388
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

This is meant to be used by ATS-capable devices.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c         | 17 +++++++++++++++++
 include/hw/pci/pci.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fc4954ac81..dfa5a0259e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2939,6 +2939,23 @@ AddressSpace *pci_device_iommu_address_space(PCIDevi=
ce *dev)
     return &address_space_memory;
 }
=20
+int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
+                                  IOMMUNotify fn, void *opaque)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->init_iotlb_notifier) {
+        iommu_bus->iommu_ops->init_iotlb_notifier(bus, iommu_bus->iommu_op=
aque,
+                                                  devfn, n, fn, opaque);
+        return 0;
+    }
+
+    return -ENODEV;
+}
+
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp)
 {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d67ffe12db..f3016fd76f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -442,6 +442,26 @@ typedef struct PCIIOMMUOps {
      */
     void (*get_iotlb_info)(void *opaque, uint8_t *addr_width,
                            uint32_t *min_page_size);
+    /**
+     * @init_iotlb_notifier: initialize an IOMMU notifier.
+     *
+     * Optional callback.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @n: the notifier to be initialized.
+     *
+     * @fn: the callback to be installed.
+     *
+     * @user_opaque: a user pointer that can be used to track a state.
+     */
+    void (*init_iotlb_notifier)(PCIBus *bus, void *opaque, int devfn,
+                                IOMMUNotifier *n, IOMMUNotify fn,
+                                void *user_opaque);
 } PCIIOMMUOps;
=20
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
@@ -462,6 +482,19 @@ void pci_device_unset_iommu_device(PCIDevice *dev);
 int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *addr_width,
                              uint32_t *min_page_size);
=20
+/**
+ * pci_iommu_init_iotlb_notifier: initialize an IOMMU notifier.
+ *
+ * This function is used by devices before registering an IOTLB notifier.
+ *
+ * @dev: the device.
+ * @n: the notifier to be initialized.
+ * @fn: the callback to be installed.
+ * @opaque: a user pointer that can be used to track a state.
+ */
+int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
+                                  IOMMUNotify fn, void *opaque);
+
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
  *
--=20
2.49.0

