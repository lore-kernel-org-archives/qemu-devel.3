Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BF5C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmg-0004iu-Cl; Mon, 20 Jan 2025 12:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmb-0004bw-Rg
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:54 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmX-0000ZQ-Gh
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394909; x=1768930909;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nm91vlwGe5D+P6Uq5nJl+1ahvziKN3ReGpZa9nFH6IE=;
 b=d+jViTI9/Syj1djzaDYHZkDjt105W0O0GP5aDz1EjqRSDKOLNYfkb8hj
 H/HE5VUNFoG/MrBqQuPeFC8UHyiVqp3aIHhVn9B6Dh9q7dMbGxroohJFD
 LTGzoy45KRXUOEr2J33UWDW4fWtfFK5GMrCjDog3blXFJRUO0QMTrIN3w
 5yWCADg/0XIAHdKXENTHn7A2Qb3wI8FhabvK2UevsPp1iJSfLU8hmYh18
 s8T9wIXmOBA0gv14i4yCskC+AG7tnDykHs7GJqNcTgBT5QLjsmokSou/s
 OkaKr+umt0zLWobx2Dvqhonqb6gl2qa0BSbuPUJ8dTDwX/OKog2vgB6HZ w==;
X-CSE-ConnectionGUID: WhFqQ3IXR06tq/EP9KJy+A==
X-CSE-MsgGUID: NOXLJ1yPSh+YYt2Gvilofg==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29125395"
X-MGA-submission: =?us-ascii?q?MDGCNDPG0jb0gvufw9cl56ciFo57gjLkKQxnxp?=
 =?us-ascii?q?pgeESJObntp6ePeZkBODaLibps6zj0SgksxOnyouP9006HcLcjHJldMh?=
 =?us-ascii?q?/8aBpZDiZZ+AYnDK4rCf3MD5f3zt2aLX/tZLwVdWvpstp/aD4Fmv2cgA?=
 =?us-ascii?q?I4xTc7ngmd3QbrQixQndxPwA=3D=3D?=
Received: from mail-db8eur05lp2107.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.107])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:46 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHAkGSpQhmFaiTJ7coWpyj10s+lz6cSH6E1UvUM8PUh9lCFFZhCJaKMf6cgiK5RQfsELDj+J4aFMlfXa2eiHJPEoZhIH2Vixh00xvoAwWM4KGwWurfqRmQuTIzImGSrSe2YktmwcNImxO4qtb7hx/d7knALfes7S1L+dHtnbopp/BzbWUBnDba0yiCJnqt3gJIAZKxvb0ME5CNKbJBD2981IAtIarroRE6sYDqdUtokWqsVd8ktSAkaIgi0za8lOQRf6ruEmz9QfcMJqeIO5TwP+F86Gx8pul5f4eJ+MDZY+QdCheq2In8CdbPzx6vVpKMMpxXonzBfeAJTfucG6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxMhYZFYSn3X2ZShgsvqQ85rnjzav49VlNt0u4XhQeU=;
 b=Yspy+3GzYEawiS4rahghcijSoMTCClDxRt4WW1ZSxy1pmJj+hRlyrUjNxAOOgQwV8vDa1R7zJjw/LBOw7nme9FYCvP7OeJFMBse4NsJx+++LlcPhBee9yuIk7vNe9+KIO9Bq/OYhRdCCSBOhWWeTJKfgsm6d9WTBjR72hF2y9Hwa3FC/xNZQJ6njBrDEgViGbo7rZ/bi3TLeC089RqcH+B4twYUsY2txb1Gyw6Trhw6anrSAZx8ahaaca1XgLH5fKJCfYC/MRyo1585ktcZkmcwcvArVsXEWdVqPs7kUgmVGb4H8OvChsdxkFdBiYeX8k/p8bAHW3Ia2J9vnZZXdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxMhYZFYSn3X2ZShgsvqQ85rnjzav49VlNt0u4XhQeU=;
 b=e96Mp88oGbuYL31lRMInraFds+Ffd5xSDkHiTZmaqNiQGJ5Ivgv01AfmyMs9yt1c/W4ta0+bxVnF1zm6VsUXgG5A30H7Oz3Hd6VsFXab3LVn2/04ARvpr//5uiQlKrsb/mEskuHTNLWJMyYOFSsypoJYJ5j4UZlPaO9WV+OqaF4NwcZss1nF+Mqwz3jzi7QwOmiuVd/NNiWDDGstItmtid8GaTll/cdf78xWTTOW6VMWAQVbvIZ6O2bk4Q+uNHsZ8oS/eD2qtpVaMP+Wt/5Pv035unpkfgi83JLTZcQZNK80pqtdb7dl2UDnjalku7ipEDxR5sZkU6nfZ32pt3yAbg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:45 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:45 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 07/19] pcie: Helper function to check if ATS is enabled
Thread-Topic: [PATCH v2 07/19] pcie: Helper function to check if ATS is enabled
Thread-Index: AQHba2KScjmpYxRe6UitchMA/gFjVA==
Date: Mon, 20 Jan 2025 17:41:45 +0000
Message-ID: <20250120174033.308518-8-clement.mathieu--drif@eviden.com>
References: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7548:EE_
x-ms-office365-filtering-correlation-id: 7f362ab4-7987-48d6-42ee-08dd3979b56e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wZL2E1p6PW/toeyns141XkWb6pu3HGrcokwC2mWhiWuVBk+cw3hGtTl8sf?=
 =?iso-8859-1?Q?B41sPpETHMlX3ltmmary0rKPjSimnox3tKTnoxDS7nfx6RSDl3DCi1NGeX?=
 =?iso-8859-1?Q?qjr69sPe2fDGawpS65w6nh3JOR+TcIVMFV7LoJeOg2Jzd5rAmzv9PuZuUr?=
 =?iso-8859-1?Q?3P/hyaJXd0v42lXuG6cqFSM/jIu6GcByDOmUbWktyjqHH1rzT/dFnas1YB?=
 =?iso-8859-1?Q?P78GMMjGP13fFBIZr3zrLJbHFhnhEhhk2sUR43wepIEtPvdmRZ0rpbhzJu?=
 =?iso-8859-1?Q?FA1mUUDov0L3y6W7l/rzitWlwjv4+QMsA6eHcKaZV8qnbFeATU8cPbyZt5?=
 =?iso-8859-1?Q?p8HIe1mOoHBhR2QMVPYVqzSit2UPqwM8DgUtIJradf+s0ATLXgzwbooYGs?=
 =?iso-8859-1?Q?x5PqKvtvvG67EPpwElsAtmoB3iudg28SCYT58eGCNndZ/Zp9N3Eba9cl1j?=
 =?iso-8859-1?Q?ZKsEWbR+r/j48saWQR5qUFaNQy9SBY9qzCxh1bnkF2ULjxjSubN/9xcZpS?=
 =?iso-8859-1?Q?qt0Kd552vXNyaROiHKyXgkCH9mWeRqY0v56f2qFLmxJdcV/hrdgmUiEXSz?=
 =?iso-8859-1?Q?H1ThcoGx6MlTyMOZf2N7Ptio2wdSqyfuU8ouF4JP1MS+xIg1sqv7wvXTj+?=
 =?iso-8859-1?Q?exlZLsO1mZhOveM3QXVqqkfMREdkzCylJJ+9MrfCx7PKaEl+anh8d3trIA?=
 =?iso-8859-1?Q?G87joq7cOGPn0u0R/9O0rIvKf9L2I4ZDQTwWtdy6j33mRHqVp9BJ0gyFXm?=
 =?iso-8859-1?Q?kDyezoF5GbVxB+LxVzvxvEBAC0GMwNfIinDXRucxFvH5jKstwhx/Yk8+YL?=
 =?iso-8859-1?Q?pqFES7R9dkpNjtw4+lF3zGNZvAWr4eY2yk9fpGK3QY+zHqqtVC3xYBY1mU?=
 =?iso-8859-1?Q?tGbsJyghdQDSfr1PI0XZnyDZQt2P+bXffY9WSl6ePKaiUoNt5a3rhz1hR9?=
 =?iso-8859-1?Q?iBUgs73XvmE5is6pj3dqWv1Bd8jOM/QsxJqcRLzrv8Ye8VGyi/PXpMLrZg?=
 =?iso-8859-1?Q?jDmj0pemX40M6RPOotxMXAhh/18hXArWomfwcOriAMIRKrDhytMjsTbCDN?=
 =?iso-8859-1?Q?X//BaBK/v4pW/pnIRB9BITSaw08XI1J88Ouj+ZkAL4SQOguPRAOGGPARtR?=
 =?iso-8859-1?Q?trIPCShXbnD3lWqfVkaTs3FyaeESbeof6hIcceeao2a7dTZVN/6dpf55RY?=
 =?iso-8859-1?Q?lDW9iXtvH7fiMkVzlkjfDUHx56QprJJW6WZd6FdCErWQ1lzO8RQEuAuHmt?=
 =?iso-8859-1?Q?1haY0JwYqQCFiLfr45+U+crfBnO/LvPBFu7qqou2UYPvKxbWftz8Aroq3d?=
 =?iso-8859-1?Q?cybW4Drg3gnaRCC+voMs4DWbTaGX7DrJUOZu4DNapKzo2DG5RQWl54+LWt?=
 =?iso-8859-1?Q?qEXV+eQgXIjm15xlWWxG4BEeduhOgAH6zcvUjMx5J9pvug0cQtY6b6SipY?=
 =?iso-8859-1?Q?YozPEqnULOnX7710JKC3TQzmRY2GyPUTck0Rm8qRTJtTHOulsb63olgVEX?=
 =?iso-8859-1?Q?VvHK99OpWKuzxMt0s5eOmH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BIkAFxVpv9EjB9+k28B0Io9peKTJiH8JuVEoJLzjk/HmSgRV/MfBXifTXv?=
 =?iso-8859-1?Q?wIvVmoP2svzZntCDCeb9ijuWQ5ep+lsEhY+vjFxq1s55rUwKtX6bBhJzSn?=
 =?iso-8859-1?Q?q7Y/6gS86cOG1vZhXp9DXu0ZkDMU5Vkiis9dcvTfAz/xgh+km58AFewL+a?=
 =?iso-8859-1?Q?ogu0D5mTetzdX8+zqGY1XsGfKvbNI87tfCXe0QVp9kOpH08BXW7CbGTgSt?=
 =?iso-8859-1?Q?0lLCjfePSGZEGi23n78aStkALvwsfrwsNyyuLB+O1Ua3mZOHj3JxuCSjBe?=
 =?iso-8859-1?Q?HIQpkCORhwXs+TynjctwUKF5Jgugf9Pyh15/y96FtMuUmKmLYwQ+q708bS?=
 =?iso-8859-1?Q?gxXyKx/BMxvOP0UYKPBoX9KW9cG+8MgKUxnpDUqlE5HMd1JYVRxezI5s4F?=
 =?iso-8859-1?Q?yeleShbf+cs2a4VAoz1BvDvaPJhOPs9DxShJ144zPS96uA0JsCCFhfCO1R?=
 =?iso-8859-1?Q?9zyKvHDCvlx7poq3UqNIumiCoKgHGArDd+umm/2C9W4wYxQQaQ+mJEP3oc?=
 =?iso-8859-1?Q?5Ke8crQx24WyHEvpUbhoRonPPipfjjXds9ZX9oUn/Buxdy0AxEaD6DUpt6?=
 =?iso-8859-1?Q?Q7DjS9k/QrE6D3rGW9VnbRaM8S0KMldYj+W2sXFC3drIdt/sglmAVo/i+O?=
 =?iso-8859-1?Q?Q3+sgBnRdPkiAzgM1wUHt+3g7fY6L+EYoJvtxfKAkxI/vaRVP8JmAQzo0z?=
 =?iso-8859-1?Q?kX2J0Y6BKVsx/s0Z3PvkjAhvFGOtrryGTJoa82zh/WlPgCci2DqZPMpvoI?=
 =?iso-8859-1?Q?jBTqG/LVxyr64n46z7le7CnjJJLk7AtcuoQfP4ui6uupStQaH5VAjL48bA?=
 =?iso-8859-1?Q?EYjtaDVk+9sK6mvEYbpJxAAeRH5a93d7v7kUlF79Ag3znXRRVMN54HfvOE?=
 =?iso-8859-1?Q?AtFkM82vbl12wjUwcj2vUKhqT9du1dG2oLWEQBn6v/lZZZjNn0DavhoMa5?=
 =?iso-8859-1?Q?DH6U4WDrRr0N9TMcQgHrlBQR8ZxaxN5eKQvlYcReIE+1zehzly3NlFw33t?=
 =?iso-8859-1?Q?QnhhcjnmuoFK2Y5oubfBwBk3Pu9YvRjWk4uTecHe3TGTcL+Ye3jn5vXa/+?=
 =?iso-8859-1?Q?X7+2m8AelwpwLsltLr7FKBIHfe/vmkbeIU2IIqo1tF9ifv98XxpoAZR9E4?=
 =?iso-8859-1?Q?PxXSI6ArS1zj4Kocf1VfbCZfuK5doo/+O05iCt8J9S5i+RH3ye+tC4981X?=
 =?iso-8859-1?Q?OVKdz2VZ4OKyVWEND4OGhgKeCun4O7HVMYeN8XM6zpw3yF4VogdLrirNY+?=
 =?iso-8859-1?Q?pZKOcgROajgZEFq1zIYuYC2KbevqQLgsEAwCvwpXJ2v92uhpunLliFrTdM?=
 =?iso-8859-1?Q?j9ncY1dXLyXDhA2ahLNKo/khTvXHWIUCJgUxWAP7qNGoCLv+8c+zgRYefj?=
 =?iso-8859-1?Q?e2au3gUGvKFDWTti7fVUjv4sw80T+Ba+H5IX2ZSBd+WMs7HrQ1MDq1oiaP?=
 =?iso-8859-1?Q?hJkOpXLxWUsdq1CFXvYmYMdN0f4IwYcrX04uZJ7LGBxqX9OgdKAdT0UpQg?=
 =?iso-8859-1?Q?usNsN2lx/dl4UvHvyM96S5t2FlbYq2AB1ahltsTxi7KbvG915tVktQzk1R?=
 =?iso-8859-1?Q?kaNCBepX6R/3rxtYuJoUAxQnymB24Gfw0f2I4aHIvnqGbY22baITeVx1Mm?=
 =?iso-8859-1?Q?TODfR0JqRJ+wp2iG3UgYcLNpe5mHzpP8K+bAdk1ppV2WBlvOb8kHkNytLZ?=
 =?iso-8859-1?Q?w6rN8+2As4WQkgS88AE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f362ab4-7987-48d6-42ee-08dd3979b56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:45.3872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cOlyrk9CRxFuMZe8svV552c45S/x363IcvywTVsZESa9WA6DbfipQuPoAfOW8NiIX+KK0dVMjRafPbtt4FT41wQR19S5r9YdMg4JC3dFJlFNx5YA8cRx/oGCO1/5pB/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

ats_enabled checks whether the capability is
present or not. If so, we read the configuration space to get
the status of the feature (enabled or not).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c         | 9 +++++++++
 include/hw/pci/pcie.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 8186d64234..3b8fd6f33c 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1247,3 +1247,12 @@ bool pcie_pasid_enabled(const PCIDevice *dev)
     return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL=
) &
                 PCI_PASID_CTRL_ENABLE) !=3D 0;
 }
+
+bool pcie_ats_enabled(const PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.ats_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.ats_cap + PCI_ATS_CTRL) &
+                PCI_ATS_CTRL_ENABLE) !=3D 0;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 63604ccc6e..7e7b8baa6e 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -158,4 +158,5 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, u=
int8_t pasid_width,
                      bool exec_perm, bool priv_mod);
=20
 bool pcie_pasid_enabled(const PCIDevice *dev);
+bool pcie_ats_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
--=20
2.47.1

