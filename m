Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F74C1B087
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXu-0005Bh-Lw; Thu, 27 Feb 2025 05:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXn-00052I-3h
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:55:07 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXk-0005o1-W6
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653705; x=1772189705;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=L+qfiCqDv/FvxxOldZORUEjs2F9iRklyEARtcbtk2HM=;
 b=v+tjLdcclykausmCv7vzwGTDPQy2Mdr9edZMwv7rK/N90DUeTvIofv75
 hRnuH5M9V+AG8bvKLprcrVbW7D2bo1EvjxbHOTKVffM3oN6gMMlv3QoVS
 RnkAYOIuT0UNGclrNwG29PU2vBHevpnd0Gv2QMly4hokrdbLeVw6dL5Kg
 NpALYn7uUXhTJrDy3OOqv/Y0W+HU+FO2bK2AkfclcNcFwsjdR5fGDzExS
 ZvGqUDomH9okUu71rRXVH8G5Nthn2QebG+hQduWBSYxCk5zSZGb2q5VSW
 KvNPrrdCnWu8zGIhVyNLlK+/IY2qgSz6ocE5eCybpeW9CXsphJN6FC1It w==;
X-CSE-ConnectionGUID: C+RDtWRdRme8ZWSewEBHag==
X-CSE-MsgGUID: 5aPUJKp8Q12q3kOqfdRmDg==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331856"
X-MGA-submission: =?us-ascii?q?MDGyf9621O0n+gR25HSLjzaylgnq+IflCTDqGp?=
 =?us-ascii?q?OFY7PHyWqQPFvkAt9dgUL6MacODUdulWxKWtiVSKM1t6c8eZc5GHq2+N?=
 =?us-ascii?q?h+cX0Xtqx3VX108saZpSl/PcqsqBxrDrQpIthcFIUDtXUhbnG82vGfU7?=
 =?us-ascii?q?61o3pXeSBr1Y41xAPR+fYkBQ=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:50 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzpUkcXxzTumeUMQ1bPFjIborRpB0JA5gUdvngvh+B0Q3naC9GoDGrlRvispFjHxcLqthPG2qAKOmA6jgywQ0Wy3BM7nNer1e8exJ4EgirJEwb06m36sP+D+xhCfHwrb+x12CuJ7wPAsh9+O0ZmKbbA+pBoYyMp4lSNzMMS8nPBxvHuJCleaPYPqfm7T/9wH0+Ml6v0gw8uWl/YTWMLuZG8S64DCrkmiSgSz38Tv4VBXCqsEDUMNZi1q1fnlrMP5AFMzhWK+fMRaeZ7hFAaZjUKgha1eyYxCJ4EzBh9+OgtEPRaJzT91hsT7KNFq51Fg23eSTCvOsO98MmRm2EJovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Quf2k86fFz0ZYXnqnyMCqldIOYG9IMWVRxd9aH7T6rw=;
 b=STRn7DGEFkBp2rUAdCJ+x1SdSeIbEcwJvqtNbm0ArD7zZro0S649Y9CxWsz+PhNindzu/iyHmpefSWcIkcknbrre9tr2dJDpRiF3TepvjdLpVf1PuqJBQXnBqK0f/nL1l648ynDwbomuwpmv21Xx+wrQWmWtxPYxOYaxKZn0sLv6JjABP25e+eyQRsnyMFtJPvC4qfFL6uJ7E3eXQkrrYtbYGqFI4zXYTO95Qa/5F6/2T18jVIz9Kiml/N4DL77KzSt0Rugdt1DASDwpqWTLwCONqzvyxwFmo7KG6fUfzD/LqitaKSSl9m6MHUpRTYzI92F+xykfrDN8aaIWmn80BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Quf2k86fFz0ZYXnqnyMCqldIOYG9IMWVRxd9aH7T6rw=;
 b=sXv8krICGbrzlrIwI4yp0YO/LkYkiM8wcqumXVNR240tT1Ma/OzxCZnQpmAn1XSCyZ5+B1VxGetweuYqqBFk1N8+yoSR96HTwUwqeW3kF1XnUgbJFKOWF+xsFyUIkGwh1l44zbm7+XxzbpLsNzkdoKbru92T69Q2Zb/8B6h/l9bkfpwd1JfEQVC3HbNw2cBEteWApTggQBwzMd+XdHv/Cn1zmq5I01RlBJAxLBQzClI7ER+e1+qNi1myWeqf1ohPblhstZniGWiDPRrCZk+PYSgvCCG/ajGiEEUMfDNOSW7uxcuRAv8c5FmU1DSlFpNSxbQho9A/8zE+Br1rJHSIVQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9097.eurprd07.prod.outlook.com (2603:10a6:20b:558::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:48 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:48 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 15/19] memory: Add an API for ATS support
Thread-Topic: [PATCH v4 15/19] memory: Add an API for ATS support
Thread-Index: AQHbiQYERBOBlG/ExkqAjrzlMtbyBw==
Date: Thu, 27 Feb 2025 10:54:47 +0000
Message-ID: <20250227105339.388598-16-clement.mathieu--drif@eviden.com>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS2PR07MB9097:EE_
x-ms-office365-filtering-correlation-id: 7398f958-16e4-481c-933e-08dd571d2731
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0XTVT4W+5XRAnWS10kB47Z0wUHSnurPrIw2N0YWWrPEPhVXzXkW+negwvn?=
 =?iso-8859-1?Q?yxAC4228fdnfJ8mAKQDBGMQ/TYMrof6vapvynl28U8IVKPSdCueDBOywvH?=
 =?iso-8859-1?Q?3+h27CXl1pAem2cg0Vu43rGTazbM2A0jRcHYPcmxcym7p5YU8cbuZrwk7C?=
 =?iso-8859-1?Q?KT1dXStERyUkcqhClzVuZd8fOxY46N8NtSXyDzEbqGeKKYUX7JGDPBQcfA?=
 =?iso-8859-1?Q?/S2ASQ+AeHN4Zn0aTf6RJniWgfcH2PNFxy/4YUWF2AfQgi8KtneJ2EZgbD?=
 =?iso-8859-1?Q?qPShlC/zPkAruDTdnA3uAbnvYNURSfVM82myntiewIoRMAXZmQlCtwQ7gH?=
 =?iso-8859-1?Q?T+7OiV5zrkzOFl/p2OtO1n9YJxGy7kI6YqKmmmXvzeMk6GI9PIsAooOAsq?=
 =?iso-8859-1?Q?mdLDYFAC7yrwW2omaQIJcdXfc+GJTuXnYr/aJrXctd0K/X0+zXv4AI69bB?=
 =?iso-8859-1?Q?wpRlpyuJ2cmBfT1ehTHg7yEHqn/uFzi9LURf4iMo00/dHgxI1LEFoeV9Wa?=
 =?iso-8859-1?Q?drF2Ie+3or/h4GPOkQNX3FyelAObrrXS2GbsQ2C5/XHXi2GQpjL8T5ftI0?=
 =?iso-8859-1?Q?LIqIM+Hm6NzWipsN3q5fGNIMZdgw/pPXCQC+GaHRLU1/c9xustZgSwxKLb?=
 =?iso-8859-1?Q?tDH/n+20J50l2DuDcWRrEEafbYW7ky4RtztU+Id69TUm3YLo4LWM2sh1hf?=
 =?iso-8859-1?Q?kjt4+4TXIyDUwE4htBDQBvCt/1zwe9m5KZz7Oen6vfshNXQhxI87SCGfpU?=
 =?iso-8859-1?Q?x4yBJJxkzw8phKQQJRUzKbVnDSDXNajZEznxd4ppkX8KbEA6ppk+G+/ITP?=
 =?iso-8859-1?Q?iFGwySnpTl2nnv8ZQAc3R01ClnnYBI81CH6BTcgAi1aCVvijYG2EXPySYO?=
 =?iso-8859-1?Q?dLt/WifAmVLl1NVdrbTQJgZZCIHZhxSX4JdAaMiJcmTEcEOjswavUIbRJ0?=
 =?iso-8859-1?Q?ORJ0nGGG8mrYAPq6zOtmxf/DLMByR1IybUb05Mv8sXca216dm5dAyaUFiN?=
 =?iso-8859-1?Q?A6dROdR0hfR4Ipzkc0G/UoN0CYOZT5VJJgzHlwlLd+uqxFWwam9inIxsce?=
 =?iso-8859-1?Q?8GMzYNgriQjQH2W+jpKSOiijtC+d4jMBuISyaiLN3rKSqQNrkghkUFvlLA?=
 =?iso-8859-1?Q?k3KPhriMSbOoeS3hSoq3dMeX0qxKl4invjKn7KzqJbHtBBHt+gSF4mHOhw?=
 =?iso-8859-1?Q?csMRY3rZu8JDxeR4dF3zd9Z9quiBwOxjoJsYRX5oV6vOhSFIFgAiBKTIf5?=
 =?iso-8859-1?Q?TN2xGhJ0laXjmY37eq3Wl4fvPTD9QCFnwdZwOf51JCq1t6jtgwaSAvsEgw?=
 =?iso-8859-1?Q?+mt0uI3WA/JT7FYBng+mKht9kGebWnX9uvVwTTp1fTuZoQRSx6HZqoEhxs?=
 =?iso-8859-1?Q?rAmXwwqXQU3uwXsVqV0+3adrijiLOXLezyCaamc/+iWeslwAjPRdPrrlWX?=
 =?iso-8859-1?Q?9jiuOPCIdBnIjzNxRk0GiKsY9x7PhM7Uv99fWM0TWRFjhROtwq1B41411T?=
 =?iso-8859-1?Q?DpCCWDIHWPur0ZukXA4btO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MuOmQNM8H+Rk2nduFqO1suxeMemWJ0DeK1C4FhDiyKFlGyxdWF8oYmT7aU?=
 =?iso-8859-1?Q?VyTR18mvk9NS6HIXlyj+alrRffDJ+arF0Se9Q6AwvrdW1CZSEvMgtKj+oG?=
 =?iso-8859-1?Q?JIVbdSnhFj0yIRl95AgFF5r40PcEYSXqjnCrH/i0I6c62rl38oJGG9yUdq?=
 =?iso-8859-1?Q?QwSAWcowN6dzD5Ga0M1sNULKs4eEnRcSeywDouF6ktSNjZhDJuIfeuI0sD?=
 =?iso-8859-1?Q?ycBaAmrJh2CNordi+oVI+M7ByXO8B7xO+Pso8xakV5Hp4gaHj/l1v3zqO9?=
 =?iso-8859-1?Q?hFRPSSyMtFAkB15UqHuKa7oTNDBjLYzmNmUob1omA513CQoirPmi9/UuOU?=
 =?iso-8859-1?Q?EkHP+WcurM0nqCAcwa3E5yup3OhijRfMeTYaYX/1NVPe2QRzERK4aN/AYG?=
 =?iso-8859-1?Q?6iZCh3qsGRX1fBiqAEp75z6Bn6uC3NIdQgdNw0t0Cfd4qePhQPE6BhUpKS?=
 =?iso-8859-1?Q?vijP1qj0XaNpKKkDHEuC+jZudlHXMBPSTkZKMkplNhZIigSUta4ZxVruK6?=
 =?iso-8859-1?Q?7glvV56F0LTIx+nL99cuSo0zWEInWcyua89q7/jc2XRicL2xaXVqpMoPZ2?=
 =?iso-8859-1?Q?IFXh77p6pScLBpQ3mfgbODVf38D4hRsvd8XYw38/sNZVpfVVyQnbZq8Q+l?=
 =?iso-8859-1?Q?NdYuZVqVRBnZq5hMQN/GZzRg3EF9hPW1jnW58+oNo2BjKcoCGRFtQ8ocvi?=
 =?iso-8859-1?Q?ZmIwwlh+2qlt59RMcNQj8tqFzHuRb/EkTUmEYDqEDcxH+/oYjGCpZ/KR00?=
 =?iso-8859-1?Q?4XFw/o/FCVkB9s1tc+229PZRSLVmr0yvGVfyU82DZeBg5Y3RFKNHWbg+1s?=
 =?iso-8859-1?Q?GyQLPY0Wj0W//BFCctNTXH+ZRtx6g9rPcb7oIb8y76LiNT0RA38Wf8LBA5?=
 =?iso-8859-1?Q?sDUTgyITTjBpP68D28t/N8HAj0OPSjjtF7zbr9ASnRrQ8SrUrdo2w/HetB?=
 =?iso-8859-1?Q?gF6myn9KaaNqZao4yDI46jqqP7QCNCqalcB6Sxi3hWkoo6+CZy1ovlGh6L?=
 =?iso-8859-1?Q?7lJ4UHV05IIHPAdcdDTawIhYCZHZqVI/D0Xzs+cNJv5BSzbQ6QWYPMWLe9?=
 =?iso-8859-1?Q?TSy9+tGwKsSEcR3HkBSict3bj64VlYPaFarKa4ye7+Ai4TDDTbuKfVmcQe?=
 =?iso-8859-1?Q?rUz5ylC+Es9oXdUYxAaec/2aOMu32fJUkW8zV7F3YOIJ6cKCgEtRrNwk0v?=
 =?iso-8859-1?Q?4cPjlOoReHPQOxk6v+12Z3AMcH32+WWGJISXLT5Ebv258dp7SDtrb76Xo8?=
 =?iso-8859-1?Q?q1B6UbGDij7dDAn+o2SV09IDkb9h7psoZIFkR44gGDNK4M4Vm9qm/ciB/l?=
 =?iso-8859-1?Q?gCNRMHSKAoFalxZjClSf0z3tDJardIcxhlCF/5qZgXG27eq6/0hG3XO/Bv?=
 =?iso-8859-1?Q?xCkgAE8IKUbTr1tlVApTvevE10/5nceOB+sXgGvA25Y0phoLajVkAeI4hl?=
 =?iso-8859-1?Q?+sFHJ1oa1EV8HHlZg7nfIVTYJxgObZDmcGn4+ddIdWWwR/lVfSYjjNqJ1p?=
 =?iso-8859-1?Q?up6HdEPey4IxRGAyadozN5VwxblOP8YZEt17E8++MmbSD4zre8r57B7145?=
 =?iso-8859-1?Q?ytq49AL14baHtPl7xwvTeiK/A5T8BAd+T7j79j8tRY7j36Q15i7xXoaixD?=
 =?iso-8859-1?Q?eGvwxGiy7JkPtxEFuxebISjRs8bftQ6JHgt4KBuEh9ZBywh4KrO5B5kcXt?=
 =?iso-8859-1?Q?rFLaQvw861l1dfrMKfs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7398f958-16e4-481c-933e-08dd571d2731
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:47.9388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lY+BJX/p1z7n26mBrOelW7G0w9tcP/7KjJmcAAxM4n/J5zN11fzAIBcRST2fUVll3I4b4EAakDDN3z51TqmaFKB7VxH8UFcLzgVvHgqbXnAeWbFso5sJA068D+Fr4guw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9097
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

IOMMU have to implement iommu_ats_request_translation to support ATS.

Devices can use IOMMU_TLB_ENTRY_TRANSLATION_ERROR to check the tlb
entries returned by a translation request.

We decided not to use the existing translation operation for 2 reasons.
First, ATS is designed to translate ranges and not isolated addresses.
Second, we need ATS-specific parameters.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/exec/memory.h | 26 ++++++++++++++++++++++++++
 system/memory.c       | 21 +++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4d240cad1c..9a8e765909 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -148,6 +148,10 @@ struct IOMMUTLBEntry {
     uint32_t         pasid;
 };
=20
+/* Check if an IOMMU TLB entry indicates a translation error */
+#define IOMMU_TLB_ENTRY_TRANSLATION_ERROR(entry) ((((entry)->perm) & IOMMU=
_RW) \
+                                                    =3D=3D IOMMU_NONE)
+
 /*
  * Bitmap for different IOMMUNotifier capabilities. Each notifier can
  * register with one or multiple IOMMU Notifier capability bit(s).
@@ -535,6 +539,20 @@ struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      */
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
+
+    /**
+     * @iommu_ats_request_translation:
+     * This method must be implemented if the IOMMU has ATS enabled
+     *
+     * @see pci_ats_request_translation_pasid
+     */
+    ssize_t (*iommu_ats_request_translation)(IOMMUMemoryRegion *iommu,
+                                             bool priv_req, bool exec_req,
+                                             hwaddr addr, size_t length,
+                                             bool no_write,
+                                             IOMMUTLBEntry *result,
+                                             size_t result_length,
+                                             uint32_t *err_count);
 };
=20
 typedef struct RamDiscardListener RamDiscardListener;
@@ -1892,6 +1910,14 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *i=
ommu_mr, IOMMUNotifier *n);
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
                                              IOMMUNotifier *n);
=20
+ssize_t memory_region_iommu_ats_request_translation(IOMMUMemoryRegion *iom=
mu_mr,
+                                                bool priv_req, bool exec_r=
eq,
+                                                hwaddr addr, size_t length=
,
+                                                bool no_write,
+                                                IOMMUTLBEntry *result,
+                                                size_t result_length,
+                                                uint32_t *err_count);
+
 /**
  * memory_region_iommu_get_attr: return an IOMMU attr if get_attr() is
  * defined on the IOMMU.
diff --git a/system/memory.c b/system/memory.c
index 4c829793a0..f95c602a46 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2011,6 +2011,27 @@ void memory_region_unregister_iommu_notifier(MemoryR=
egion *mr,
     memory_region_update_iommu_notify_flags(iommu_mr, NULL);
 }
=20
+ssize_t memory_region_iommu_ats_request_translation(IOMMUMemoryRegion *iom=
mu_mr,
+                                                    bool priv_req,
+                                                    bool exec_req,
+                                                    hwaddr addr, size_t le=
ngth,
+                                                    bool no_write,
+                                                    IOMMUTLBEntry *result,
+                                                    size_t result_length,
+                                                    uint32_t *err_count)
+{
+    IOMMUMemoryRegionClass *imrc =3D
+        memory_region_get_iommu_class_nocheck(iommu_mr);
+
+    if (!imrc->iommu_ats_request_translation) {
+        return -ENODEV;
+    }
+
+    return imrc->iommu_ats_request_translation(iommu_mr, priv_req, exec_re=
q,
+                                               addr, length, no_write, res=
ult,
+                                               result_length, err_count);
+}
+
 void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
                                     const IOMMUTLBEvent *event)
 {
--=20
2.48.1

