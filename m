Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9847AC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4T-0004WR-8Q; Fri, 21 Feb 2025 03:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4R-0004UT-34
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:39 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4P-0005j1-0I
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125257; x=1771661257;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uJlqSs57TInsB3tqU25LwXRqfzPv1aIxe7YNYeKhHCg=;
 b=PC7H7/z7M0qqof0J788liU/QwDyxSMNltzXgeq6TvXajEjLiiwfjk5nT
 NTpTCMFY4oH0+uXcuGXZ7qgLgQznueCN7TXywuBaBEw96nuWsXsGiW5xd
 ST3XSz9Mpfl8AjHIwgcNVVrlDrbXsXoiHYvYWpgmDHKMhfPGv9qhtksEk
 RjD2CRrfEYbdjcEF23wE/rQvUOrGHEuSXPx0TXVoe7lDxQNrWoipOb1bk
 3vyGMRlKCCHr1dxbN3IFcZt4/47Emi4ZwZG3aZLxw0SVSHu05Q/38Q0mw
 5g1kHuxQaCx+eF78J0lOyZyi0BFZStGpqnQVBBWLmgn/8kAkcy6m9geoD A==;
X-CSE-ConnectionGUID: Aa/kJQnyRr6ok8JBABN14A==
X-CSE-MsgGUID: Nk9EXkZmSqa9oVUquvZAUA==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="31394121"
X-MGA-submission: =?us-ascii?q?MDGS21pRw7xvuObjDLnjVMH4eEXuWpMrVF5DJo?=
 =?us-ascii?q?i0VZ2hv1/4pYWPbQMKxV2K3/GiQI3eRDQl8nF4LSWbXONd607gcUdvpg?=
 =?us-ascii?q?fti88HxxG4K1zKgj8vRiMUW1zIDjsvloPKGZtH9kf2r7PnTzQrtJlWlg?=
 =?us-ascii?q?4VZ5ucYTuDlcY1ZQXU11qb3Q=3D=3D?=
Received: from mail-db8eur05lp2113.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.113])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:32 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2UPtTCcu8yLIAarIyerJoufRqbDQTSxLzY/lPo7MBogdhA8qG/ocXH80jJo7/vPUTEnWAhy/EgtW2xa4as0VgUFJeQtI4eEE6qUpqtbb7Uj3j9xSXWvYYprmE7ztH9br2pZUPwFlAlTGBcD9y39JYNu2/AqxBTpxKQNx/ZoPaKZpxzzVjruidjBvSlYvu3ljyTuPxIjtCS0KPgTbpuQmAX8rI+2MOaDHFA4nH6FcKWjUN/BKsu1Qmc3gDZcT6uixGQPMQJhW2aReeW8auNLqFiZp7CtwM//T6yx+GdDmLH+T9O36QRv+J87MkR0JxV/u4zgRrVA0ronLqXOtW1lyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIT6AiwY3yFCcHWXpCPT56LF2YCfuC6fJtGxDNZQlvg=;
 b=GIO8eZHe9gEWB/6WcFze6IREh7ylnYez/tFwrdOXZ/1l/05Tnz3UfgHgGo7c1lQzKdLVDk+NiRTZwiP5osevV52rvqI717rbClrjb7ZE8Ys61idnzvUYpeNkQh+6rN/VjPrzNu+PSdD9nbvRjF6nX4V9Z0gDz/GMT9qd6+p06hKsFEnqzvBq8exd8Dfpwe/yzMVxh2FNODFe002aW9YeEd3fJk+9z4et2QvbYvP4IC3aYBCPjPnmTznGknWNphvlOs/vf6kzD4ZxhwQzhNR8+0l9OVZjWdt1xl0942CYh8ZlU44jjtFc1CPTVM2lDs0vZ5cbAGtRHUBQ5fr+OwiLdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIT6AiwY3yFCcHWXpCPT56LF2YCfuC6fJtGxDNZQlvg=;
 b=kr/DZzJFarn52nsxtHuH4UJ0omCKzW7fQycnorGUeTbDEPkBBLdybnIgV23LV1JB6IVwFlW50enHMODBBtocRCYhjXxayHdBd1xDTtLXoYzEBJu843CGaHyhyhS7lwrKZNoVFLurM14QkVkGp07VCzb7Gc/uWLSG1KGYUmZnoHcWcm69QCpw23V0Q43Xvu5U2BzPsjyGdUZqlN1KDmz8UR7kBLrpJ5buuneEKo+epynweNOlLa19/NxlSyKrlBv1jLfOIf3aaup3WRJwi51djrDzopDur0Ppbil7gXF+wCgSitE9BQ/J+wKRe7vqWUKm8LcEp2kG0AVfhSXCFeYwcQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB8162.eurprd07.prod.outlook.com (2603:10a6:102:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:07:31 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:31 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 02/19] intel_iommu: Declare supported PASID size
Thread-Topic: [PATCH v3 02/19] intel_iommu: Declare supported PASID size
Thread-Index: AQHbhDeo75NPWXjMt0eB1wluCkUGww==
Date: Fri, 21 Feb 2025 08:07:31 +0000
Message-ID: <20250221080331.186285-3-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 389bdce0-29e0-43f1-e511-08dd524eca86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2v1PdIfZw5w/bBHWzVVSQvA6Sws+TFHpJh7igsJEgAz/2qskcgnNt/mbQ4?=
 =?iso-8859-1?Q?O+Vd6lpt3qoeISOVjvvjHghtgqpyBr/ZBCk41efS0n1sGu81pcOPrKlyhb?=
 =?iso-8859-1?Q?xWx2mW7WXjmkhjwX9KnFOU9I2aR8epUy1zgO4eZwn3sOoQ0NcJFEgZS+GB?=
 =?iso-8859-1?Q?NISQDpTxcTFWlu8cnp8+eUAJrq0qs6REID0+WNnATzZWsjD9I4oqTYw9MU?=
 =?iso-8859-1?Q?0g0p8y9hmsa36ngh6qGXp378PpU7IN6OmzwMXM4bLXmWz9aTbHsJRQ/XWn?=
 =?iso-8859-1?Q?I3A7OHqkmf+nVBSbAcuIBQp4JNIM7lgVG9b/Zr6LA36P51KPDL/fz/ZqTN?=
 =?iso-8859-1?Q?aYWaYNhZ8UrCpO184sakSbQ/PemdxHsDhKzQiz1mVvdba4VxHR9AORaZNP?=
 =?iso-8859-1?Q?2toPWXiDiST6um+fcGo672Dkaocc6Uexto5By+a3mqPWCvsZD9s50tR2Jn?=
 =?iso-8859-1?Q?liOyOKIhWbuljyjnFTMnRO705xMVcy0b8GVKBZkYK465OrnDGdTLJjl2z3?=
 =?iso-8859-1?Q?YMz97Wzwt5VFvHi5G27MhCzzFcxJ93GgvVEqWeGfiP6NIkpcPNc91RwfKl?=
 =?iso-8859-1?Q?xy0njPmcos7vrAoMSiqBX65kWPMJVIS6GHV6mnzxlqMy+AVN/o/UnY3WkQ?=
 =?iso-8859-1?Q?4xGgsYPG72XwV58xkDjgPuskx47Do9DXcNOh5svXsu+DsaSAtYL9K+HMsy?=
 =?iso-8859-1?Q?WxFc5+szStiNIMRuST4oKvEj0i36pinXvQO2jAGuVzjZz5FYsHrDktL937?=
 =?iso-8859-1?Q?o1IyulSqIzGr35N0RiHZVvjVgRIjtCA78ImWmtk/f6pj9A+9fpI5+3w2yn?=
 =?iso-8859-1?Q?FALE236ttlK1fPGuMJg4XwYNmEHAvPqkdQamz6L+3SOEh/6pUTHNtxdY3W?=
 =?iso-8859-1?Q?dckhGZ11b/+iIepcVC+8kFmoVbZ/Xi9e/Wrp5c4v7x6I9dvYqJnjBmtYD8?=
 =?iso-8859-1?Q?aI2eDy4EBt6iCIOBe2mThAM6lMJfiIrxAElrdT/kaEKFBaCV6EwrppOTsz?=
 =?iso-8859-1?Q?APUpQ9LIv3RsfgtRZ4pkPBPFzyXK8iZBAElz86bFdWdr96kAfsOb1Iu0h8?=
 =?iso-8859-1?Q?Nc55993IzpHz9+hu/xdkAPktJFytikxP+ZLDBwyXKOR6Wph83bPjDB+nkL?=
 =?iso-8859-1?Q?AUP7fJFPJ0azosdJIdid53m16aKVd9tz6GknVogktrO74t4CKRpVbB+SWf?=
 =?iso-8859-1?Q?2kjo5CGoQ0QVx1Gwcz/u+dqs0jfYn6YILSPnwCNV1m1NqbWgnnc+RQFsSQ?=
 =?iso-8859-1?Q?j8QkruwT80uczGrlI8XkGsJZKHwxY9aASaNtPIlzoE9Dj8bUiPGP63qeVT?=
 =?iso-8859-1?Q?2wN9Zhosxio4+RrPJaokPz67ET63X6QubjXr4XKNawXwOlBC5M+OoKc/Jc?=
 =?iso-8859-1?Q?sVXA/UWjIQaV0afpu0mABXndK1B+9pbQ90SKwLpjmHhF/GXdaVLsIhdAbU?=
 =?iso-8859-1?Q?q0C0NGRJ/wRgT/iBWZFAzvXEqQMNGGYk/LoDfyFdFahr2rzZUynB4MChJ4?=
 =?iso-8859-1?Q?w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MahtzD1NaacrFrxhc139K3uYKKaVbb1J+konL1XEuv+d44FdXE7y2Plwum?=
 =?iso-8859-1?Q?agFV1ApBqlxK/H2Fnmj+wfA7IUr/2oYNIA3qBRpiBNHdIDMQjHOTGKGbWG?=
 =?iso-8859-1?Q?AjLkhmtcwGE9pSee/L8iFTOQqaJ4Gireh5F02Aqq5rKTa8D7w1jBuyxSpt?=
 =?iso-8859-1?Q?ZRJGqsMXDf7WrnC4YANoRdKV08a3oGpnQvOfUwlLSUNF11vShMw0+S1H32?=
 =?iso-8859-1?Q?Ful1R/XeG2GOrIm8f256ww4WIkchpAyMSJ0vJUmKBv9sowyrS5zpUG53+q?=
 =?iso-8859-1?Q?c2Ts5rzrAIF4jAc28SM5H2fsdZmBkOlRV6LNSuWub0mJT+jU4OoDHGOIwL?=
 =?iso-8859-1?Q?tYKvpVwRvmH0bpJuCecRWdr3Zu/WBPzh0HahUZkoD2VdEMSk7XjBd1bsab?=
 =?iso-8859-1?Q?+fieC5NbF5Xxni50tPkl842ypU7gZorJNpTrYeIoXeQquvUFK7Z1xAxdU2?=
 =?iso-8859-1?Q?bDeBOCszSWOqw03yUKaBCI2TE1suaUsl3ToRlHWU6SgUn1oQ0vXiiRCXkr?=
 =?iso-8859-1?Q?SqeM5zwLj5yGp91+K8KcsKVVkNDj6fUVR+R1bghya62OJQMMd90ZRNza23?=
 =?iso-8859-1?Q?cE30SXS9/k2fY3clGQgsz4EUEbJ6fxqHvmTAO1jBxn4xMKLerrYGBoyHy+?=
 =?iso-8859-1?Q?8qvZhLyztJWms1MzqnmZisyQstm9qFLuZZahgsITG3DjsUUYg5jVRtgJoM?=
 =?iso-8859-1?Q?TGL8i5+LMRKZzdadKDH5cVSOVyHCl2QDDv+KG4UfFYAQvpDq+p66t3/x+e?=
 =?iso-8859-1?Q?O7Nl5J5Q0ptpUCT66REhuVA9iOfG3xWoxdaWTxWRrDUWuhIhDxIZHnmo87?=
 =?iso-8859-1?Q?RYr3OxiwsHDQHyhLB6T+PSBqr/b53qjdZ2USb7IV+zDkDjyN+OEYiAs3iH?=
 =?iso-8859-1?Q?qPHkx7S1pVd7Ey7/w6a8PSAjqnhLv5BuLaixfzopdjd3LZV7hwTh/tPFfr?=
 =?iso-8859-1?Q?Yny+SlYRWNmpRb00BYkkXZOE+pCKgWJW5DLO36NXwt+vp+aK5zvI2o+WQ2?=
 =?iso-8859-1?Q?MeJOTbPBISqJxYaz6pojN0qwCvfYt3sB5aY50IjBaIW+NE9oFo8KSrT0EQ?=
 =?iso-8859-1?Q?BIDQ98mhZFnb+aDhaDdyJqxj+ZrfmVtnDkTkjEwkmS4BODfltKYJuqLrRD?=
 =?iso-8859-1?Q?NGOsMi8odIsF2FLOBNGYx6JfY5QYqeg8Xf3+u7b7xdRjIC83IirtEyBCi8?=
 =?iso-8859-1?Q?KOiGtgLU5cPCsPqhiDUYH9cHhJUcpfDhBNOrNGIMOJ/iAjSBW6XGZPAeb8?=
 =?iso-8859-1?Q?4uuXp7mmqSeKVmKn7E8InKqTCrTUo50WqUYeD5CdsK/FC3mChAK3/FtJ1B?=
 =?iso-8859-1?Q?MdaYNDcNmzzJ/X+YP10vLCh6IV5Lu4JwYQC67TrnxQne+2DodSrXa9C989?=
 =?iso-8859-1?Q?ElqmAoRHnUAiw8XNUH0i8Pl0Ef4sKfgYCAEGttcHk9qjwpshEs4+sGk2Iw?=
 =?iso-8859-1?Q?eVNdWROEyIrHJ3PO8MfzhdHcRU+luNHaN1mHj3vMld0NalVr7s5276dw9n?=
 =?iso-8859-1?Q?q1nZxROm/JaDzK1GrgWHEt+k0kpJ7Jdepcuu4iEUnoWgxFZ2M/OzxqhHJo?=
 =?iso-8859-1?Q?qbdNBgVQS8xBSj/3g0ggHThjm7zY6/qItcG4FXzlIHM2rmKlWnLApjBiC0?=
 =?iso-8859-1?Q?cD4dcUEDobQjgubUwtzqlJB9euBi5n6qKudBJHB4f21V5LHVyckeS27XXt?=
 =?iso-8859-1?Q?RjywyfolZL7xpqNRXkw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389bdce0-29e0-43f1-e511-08dd524eca86
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:31.5181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoUjm5f2HjvwuSK6eTFTOq+nJTfUman3mQw762QJ4ujUj7N6WhtiTeTywdmnGKnF7aKz4vCeJJiLQdp/x3+JI1oEUyFif989es1QdjOTHvrcabOnZdfPcqC3bDV0AocN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8162
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

PSS field of the ecap register stores the supported PASID size minus 1.
Thus, this commit adds support for 20bits PASIDs.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 2 +-
 hw/i386/intel_iommu_internal.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7fde0603bf..1b4aaffedc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4574,7 +4574,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
=20
     if (s->pasid) {
-        s->ecap |=3D VTD_ECAP_PASID;
+        s->ecap |=3D VTD_ECAP_PASID | VTD_ECAP_PSS;
     }
 }
=20
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index e8b211e8b0..238f1f443f 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -192,6 +192,7 @@
 #define VTD_ECAP_SC                 (1ULL << 7)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
+#define VTD_ECAP_PSS                (19ULL << 35)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SLTS               (1ULL << 46)
--=20
2.48.1

