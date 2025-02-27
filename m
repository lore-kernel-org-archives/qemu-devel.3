Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB05C1B0D9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbY2-0005Gy-Nk; Thu, 27 Feb 2025 05:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXy-0005Eo-NI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:55:18 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXw-0005pC-Ik
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653716; x=1772189716;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=thx/EhaMFSpCXXIfgOfxU1JCplMe9WF6IcJG11lYnsQ=;
 b=JmO/5LMbJ3bxz7RjvVBgtnoa0M7qVR1zzHrcfc90/pmwBZhfSRqt/yEz
 2sqU396X8A716HlcdK0V0VD0IF4iMdrHMEfKh/lwOvmg+RPphEqAoaPun
 aOJBoF12O7JK87PWQQsvdI0OjEm4O5kvUFBDc3tGcICLYRHQksNBnI1Bw
 NTW7fvdJybkIl7pWZrdI5pWbgMGHkoH0yzP86HIUCsrIGlmlxo9sV3igU
 TFec/o4I6UfntNnrEEYkruMRIBEEnfzTZnLtzSd9d5MXTRF6GdeVklWxB
 WXwLbia/ZB0NS7Hr21DMTuEZx78IB31UiWPkvWYWN7GFGp0cA1IncR/2P A==;
X-CSE-ConnectionGUID: EFL1yFbGS72W5JCF5Nw9UA==
X-CSE-MsgGUID: 7kwR1EsBSJ+aGXaMmpCJVw==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331859"
X-MGA-submission: =?us-ascii?q?MDG6/5DQTOC9L9s+HN24DSB3hjKWtjD3E/kW11?=
 =?us-ascii?q?K9aOBD8toS1wjcdWqUoDSt2fLIzx9ndCDRVAzQi9cSC5k1wMQZpcHJQr?=
 =?us-ascii?q?WacfZf20XOhRb8OdPgUdmIL+7nu9J9fFMTUDxPbNzQIzJHeTNRhiIYBr?=
 =?us-ascii?q?HFd5VP/zXEvHrnXfApV8Cjow=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:50 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URSFqHlTCUCvajhA8rMvLD5DeEG09N+p8jDNsI8nVVcP8cDvNF65Yy8E0ba5GQ40HBLigUxXtc/fPet3iz2KkZ1aXFl1nu7Ul6K806dPHET9F2BSCIc1sZo7DSfBN6oCjY6iPvafD8FLUc4Gty9PvSQ99DM1jOx8hU4bmnbUfa5KoUVfM856xXbbbTHyT2z6+8caeHblnK3kc9idYLbsmq6vvvqISHpwTr5DmBoiYXTnctUODCbsIxjeO3N6kH7/Rf6EMadwTDwIG2ttyx5i34ApqJYHAWuSzSpvB6HtoBZGfUv7+cIBAdKn4sMcCyEwnLW048xbaj7gB0iaBFG8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfhltBH6apxt4PKk/fiqX0GKuSvhqsHT/xupMPVyhFk=;
 b=p3BhEyLoeXUoSqxYP5NmVkLMqRZe/Puy2t2sFr778b/vvUEI0pEw5TGibLysJKdHbUoaQDHUe175NRwGFde4nJ7aquCW2Wt4eiBZ8fL3PCxZi3qrdz6cwD++ftDJzYlYrAaACEouh8yg+gG6wwXtcdfWFvhbsH20k//2ZDGpIZKDyBfP8Qi646AwsbSK3aywV2MrzhWm93MJbbWzhEICFEF1YKqlRSWpPRrVL4W5NP+zND7MnuGYFDhP3pYCy9OvNitiSsLgur1R8SVcDUaw4Jvxqyel9g/+U9h95fLX3ZmoKjsBc+rh8Hb3l7fScFvxffODGC83OCQPvbNeIbjuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfhltBH6apxt4PKk/fiqX0GKuSvhqsHT/xupMPVyhFk=;
 b=iN01uTmH3A5yBfDJkwZ0NuW3p+GJ6FAjyyZHQ7/aNEueJjPcbbEc4EescT8zw5vT8/96NZmJsyt7HXpn4vmihSpguv9pWfKEGwM/M/zrgB6eHYmM9rWaYxt7EU1vc6oeyZDFlIjqKUfpCSmibExhcf8EQNtghdTin8xSdBODq6HgFzF7RKySYar6X1X+1Gphe4a40wq8fxX8VZDH7W+5Djwsz4G77LO77zPbFfKzI4bgZhYLZofDCk8OhvttqW5Xf0WiXv0+o6gmETJnoTIrdZofuE0lzLoATxihF7ksoSCLG5TrfvKfYu6hUrVd8ctR4C5vJxHRtpksIgGQQ+25dg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9097.eurprd07.prod.outlook.com (2603:10a6:20b:558::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:49 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:49 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 16/19] pci: Add a pci-level API for ATS
Thread-Topic: [PATCH v4 16/19] pci: Add a pci-level API for ATS
Thread-Index: AQHbiQYF4FT+hHV2UUmgrPufKTOtXw==
Date: Thu, 27 Feb 2025 10:54:48 +0000
Message-ID: <20250227105339.388598-17-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 1a383428-57fe-47a1-7d27-08dd571d27df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|4022899009|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lBB6EmQzqd2mg1DuymH6DKV0L3okg62+utV3agc5uaeOyHCIxU+DpSxfTt?=
 =?iso-8859-1?Q?XLfbgbDyrS5uwZQOuYzrTrTpsm3cxOX/+O/LXpRezzt6nEbOI9hO/S+/dh?=
 =?iso-8859-1?Q?aAy4y/laLVoNBoPfg/Ll2N5dtwvAW60vJDeGw0TF3ZcKtQw6bDe6tet9Jf?=
 =?iso-8859-1?Q?cWqISjpqFntUqqrdt7ylU8FEVsqRTYNRc+xdHamr6rsTiJBx0h7lSl0HJi?=
 =?iso-8859-1?Q?StqXmmJA15ZrS2WZ2nVoj8VmdGE/lT7XXdeqgmlA2HWL970SlBIYTAtPRb?=
 =?iso-8859-1?Q?/StL9JB+ZxfIuCgzHrIpH36QgUxYvbwQOqacDPpAGzfScqIkoBgNowJAcf?=
 =?iso-8859-1?Q?U6COxKpQkpG6zpNm4CxcpFDvrTVSrUw6YImZfOmzEWvZDmH+AaUu0Ts8BV?=
 =?iso-8859-1?Q?OYchJGpUDrnXp+NjL54h3I5O/JvUQPwD2yFEqI4AJzx1mJWFERHOHuONj9?=
 =?iso-8859-1?Q?+iLLIBuCGZ3y0UbPqDilRuxg/WyPqlemjXexd3ap0GnknTN/H/FuSl4zQK?=
 =?iso-8859-1?Q?WXaGgJQ/lq+8UCXbPKVlkiEy+VWXztmuj9xiBBBOm2pjETFfis44NlWa+c?=
 =?iso-8859-1?Q?Kw/nTnwqkoRr+yc12jve3lbXFs3PoZOPrIyHnqvaahWaGNHgMWaglIP0ms?=
 =?iso-8859-1?Q?BreLK3Iue2DflXEsmss8uimBOKr+vlq47uAkqQWRfhSVAdgnA4L+r3vQkk?=
 =?iso-8859-1?Q?jwLncyza+MuAOQqr0GsJLvDvdx6K21F1q2Cr1FGP22Hs99QRlXBflQs0Y+?=
 =?iso-8859-1?Q?BMtXE4TyFynfFh+5Z29Xt/pBuzG4LwIG0SjE3UOl2bKuzAFpUhhK9/pjqp?=
 =?iso-8859-1?Q?c6Sw3ZTNDNlqAV2UUO1qHxJcZsGXFhX8Pgv0MEwj7baVr5Z3v+8ikO6f/k?=
 =?iso-8859-1?Q?D2G63eIrdPHFbbz+jpvIh/LarcamOOgb17JQX345tt2QZqtX72NFZLW1ay?=
 =?iso-8859-1?Q?+mrfRuoe2kB0X7U97lctRUXrEINn0A+HUos6ETteji1QWVeyE/ZR+848mc?=
 =?iso-8859-1?Q?9PNFO+80V/1MlvhBEgt9Gzpiv8DK5UyDFAwDbINKR6Iu0mYULc3QVLT+sw?=
 =?iso-8859-1?Q?MnBTJ9XeNuv3n0BO5/UGBG73P1o+jIGylWyTPrCHeZqClTAg7/1Nz1O9b/?=
 =?iso-8859-1?Q?Bfu+vV7rlohCam0ovVQ68zS8zr3m7vnBZ22wY5vO6wZ+IIYmVSyH7idzVE?=
 =?iso-8859-1?Q?aWLFCxHH2uqXHVABEdFeOeksvbA81AW6YZr5yvU7wmxFNWbmPj8NnTYz7v?=
 =?iso-8859-1?Q?xupuF5IK1KzNHc1CIfXvTKjuF60RooDjDBd+7q1caUn4vGDN4PmnFxM6Hi?=
 =?iso-8859-1?Q?hDh6+7TrqcTger2SpPG6cTRXizfn0fbryDS8pBXDHXG5/CD9VdOpmTyqhV?=
 =?iso-8859-1?Q?HHcBHsGeCgRncXU2GC509eCb/2mseEaQ87iZBNn7ACoWYQHC3o09I32+Y5?=
 =?iso-8859-1?Q?Eid7FfIUGWYhHri+GhbyyiiQnOyYH7ymPFFCqTNfLpdM2x7BHmfeDLlJdn?=
 =?iso-8859-1?Q?4ZJ2hrwUVaLDLO4tiMaDEF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4022899009)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JFFc2Rs43leQuUsmxWXCpGf5xLy8nmfVSAjBZkT9XjmpL8AykwrOmcGFnn?=
 =?iso-8859-1?Q?oOhtxpVzYYowZa7/X7j4I+bzS/tfkxJY9NFbJ+JIVvuLRI0spn4rSFmBQu?=
 =?iso-8859-1?Q?s/r1i+GwK0cXpLzF5lG5GLlnRuimwEgcW6dUgTUmOefc1/6Di7WwE8FTqN?=
 =?iso-8859-1?Q?y4e3ZPQNiAszgZxbVmrhUc/6uP6Sgmi7F/XHsA5SkO60ouEh2COTqRD0/0?=
 =?iso-8859-1?Q?lefHugsEQVdUubu6bIUpl9xOpNhlI5R2HZgWQWDhyHZOy9N8f7acB8rCeg?=
 =?iso-8859-1?Q?537kAcHd2RGSiBrJUoWJaxdjdnOglPE1nWklUNTqd1FVfYe++7cOnJDTKf?=
 =?iso-8859-1?Q?YV6liRc7jNkPx/ocPSSgTSwvCipFxszYVPkDB7LkmoDEii9hHFzgTh/A60?=
 =?iso-8859-1?Q?qD/+cAmYS1qybA1udPGMrRNGir98iL9rP/4xHnaqUkSzKKAvb0rDcpPLnG?=
 =?iso-8859-1?Q?A3bjZTUfr56flMY3ipJeE1JmEnIA9rsJymU1YEfyzrm10q1rCoi7INDvGy?=
 =?iso-8859-1?Q?RVUftJs1h00rF8+QdOkvvjHewN3bIjMCsQMK11sw53JSAfz8DgsoysA4XA?=
 =?iso-8859-1?Q?mUUUueI1xd+NsGnkoSzEz76GVbQ1jb4DqFhiIpfxJvl5slBifxt5YMt/Hb?=
 =?iso-8859-1?Q?xYKp5LG+eeX0SmJrfo5Sm+SEXfUsTzBqW+sAwF7QvQjiVaO28PirEuTa36?=
 =?iso-8859-1?Q?h6uaAQNrlyRl3Ma830UbaOOmzBSgp6Ogwfo9sPaLL5ARZdMcRqqYkGIk8Y?=
 =?iso-8859-1?Q?mUIulNaMcRR3NuR104JO10T0bbdgSFxeOsOsr1ZismCKei46sVGAXgF9HW?=
 =?iso-8859-1?Q?YdgHbo/+AUydG0GCBMBGD+TfHOs+UMhR4bj8ViaKptGP72TNsuZO7u+rxW?=
 =?iso-8859-1?Q?s7dUW1CGaGZPHh7OF+6i0uB06XWuK56Chsgw3J+MGAXikTxMSkhbqYtj4D?=
 =?iso-8859-1?Q?cTf7oVHeo+aL9+ipRkzmbMdAZU5UOomQWnqm3WSKcHgoRJZBFr8bPBEhoT?=
 =?iso-8859-1?Q?Nde5oEH7xlnjfXUw31B0W8Rc3hU1YQSulsgIsWvcEnke+Uf/g1iqlB7/+3?=
 =?iso-8859-1?Q?v/MBjOqTqO54eXAT9ooRJErVTvVK/BiQaeVVWftnqFF1noHHoTOj1iZi0I?=
 =?iso-8859-1?Q?mAhUd9X/LufXwYAotW2xzPMeaplfleRjxJEyu/O3xMMELADOXwing/ab1B?=
 =?iso-8859-1?Q?h7IsiUy960Kf9WfXK6UzSfyZTu/XiCQK8j7UdrnYsani6cWLiB98/oyyHS?=
 =?iso-8859-1?Q?lNVlrT0ut5wu2uQoZA7r0FkaK00C0Oi4V5Aj9lXrHHgH441ZuJ/soN4IJ6?=
 =?iso-8859-1?Q?ZU+Va/10HauDNjD+RKFagSCpIzCWYyXCvQ1qAB3YpaB2/ZkC+w5C/iUFGU?=
 =?iso-8859-1?Q?k/4EMW2Gcs8bXdQMOctrBBgXdGOMF/FtJ0mVbWyV+7FdVEfRjzWqmJGiZU?=
 =?iso-8859-1?Q?E3VSh0Rr83DROJFEUzeK2r9WLWPtf3aY1TTszyZLKlwkU/WsEwZsOZo/SC?=
 =?iso-8859-1?Q?Fc9/yPEJw2zSRHeXkL5fZUNcuaziXh4dG23SeYbgSdm5xAnPd4UqM4Rn5h?=
 =?iso-8859-1?Q?rtQQ9x5Ccjeq1K4G8P1epokCiwmEOWCXfhVaoOAuH6zIGy1t9MISAURxRh?=
 =?iso-8859-1?Q?yslxts/gNnKC2t53mh/ZVHnLop7utBiMWeOEXOWHD2kmdxNikLb0wxi8jm?=
 =?iso-8859-1?Q?MSOFNiF7TFgxF5Br7Dc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a383428-57fe-47a1-7d27-08dd571d27df
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:48.5725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIsKsO0D3GuZxKYz6qvBoMScOYblO9F23pogNVzmtY+Y9Bvd+EGt8dHB2wy27nq0nGiWumiaGScrAGgWV9RqtINN7xOjWeD2q2BxoJHzZJM4aplV8pi2dya94Ww1sfmG
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

Devices implementing ATS can send translation requests using
pci_ats_request_translation_pasid.

The invalidation events are sent back to the device using the iommu
notifier managed with pci_register_iommu_tlb_event_notifier and
pci_unregister_iommu_tlb_event_notifier

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c         | 46 +++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index be29c0375f..0ccd0656b7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2896,6 +2896,52 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
=20
+ssize_t pci_ats_request_translation_pasid(PCIDevice *dev, uint32_t pasid,
+                                          bool priv_req, bool exec_req,
+                                          hwaddr addr, size_t length,
+                                          bool no_write, IOMMUTLBEntry *re=
sult,
+                                          size_t result_length,
+                                          uint32_t *err_count)
+{
+    IOMMUMemoryRegion *iommu_mr =3D pci_device_iommu_memory_region_pasid(d=
ev,
+                                                                        pa=
sid);
+
+    assert(result_length);
+
+    if (!iommu_mr || !pcie_ats_enabled(dev)) {
+        return -EPERM;
+    }
+    return memory_region_iommu_ats_request_translation(iommu_mr, priv_req,
+                                                       exec_req, addr, len=
gth,
+                                                       no_write, result,
+                                                       result_length,
+                                                       err_count);
+}
+
+int pci_register_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid,
+                                          IOMMUNotifier *n)
+{
+    IOMMUMemoryRegion *iommu_mr =3D pci_device_iommu_memory_region_pasid(d=
ev,
+                                                                        pa=
sid);
+    if (!iommu_mr) {
+        return -EPERM;
+    }
+    return memory_region_register_iommu_notifier(MEMORY_REGION(iommu_mr), =
n,
+                                                 &error_fatal);
+}
+
+int pci_unregister_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid=
,
+                                             IOMMUNotifier *n)
+{
+    IOMMUMemoryRegion *iommu_mr =3D pci_device_iommu_memory_region_pasid(d=
ev,
+                                                                        pa=
sid);
+    if (!iommu_mr) {
+        return -EPERM;
+    }
+    memory_region_unregister_iommu_notifier(MEMORY_REGION(iommu_mr), n);
+    return 0;
+}
+
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
 {
     /*
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index a11366e08d..592e72aee9 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -461,6 +461,58 @@ bool pci_iommu_init_iotlb_notifier(PCIDevice *dev, uin=
t32_t pasid,
                                    IOMMUNotifier *n, IOMMUNotify fn,
                                    void *opaque);
=20
+/**
+ * pci_ats_request_translation_pasid: perform an ATS request
+ *
+ * Return the number of translations stored in @result in case of success,
+ * a negative error code otherwise.
+ * -ENOMEM is returned when the result buffer is not large enough to store
+ * all the translations
+ *
+ * @dev: the ATS-capable PCI device
+ * @pasid: the pasid of the address space in which the translation will be=
 made
+ * @priv_req: privileged mode bit (PASID TLP)
+ * @exec_req: execute request bit (PASID TLP)
+ * @addr: start address of the memory range to be translated
+ * @length: length of the memory range in bytes
+ * @no_write: request a read-only access translation (if supported by the =
IOMMU)
+ * @result: buffer in which the TLB entries will be stored
+ * @result_length: result buffer length
+ * @err_count: number of untranslated subregions
+ */
+ssize_t pci_ats_request_translation_pasid(PCIDevice *dev, uint32_t pasid,
+                                          bool priv_req, bool exec_req,
+                                          hwaddr addr, size_t length,
+                                          bool no_write, IOMMUTLBEntry *re=
sult,
+                                          size_t result_length,
+                                          uint32_t *err_count);
+
+/**
+ * pci_register_iommu_tlb_event_notifier: register a notifier for changes =
to
+ * IOMMU translation entries in a specific address space.
+ *
+ * Returns 0 on success, or a negative errno otherwise.
+ *
+ * @dev: the device that wants to get notified
+ * @pasid: the pasid of the address space to track
+ * @n: the notifier to register
+ */
+int pci_register_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid,
+                                          IOMMUNotifier *n);
+
+/**
+ * pci_unregister_iommu_tlb_event_notifier: unregister a notifier that has=
 been
+ * registerd with pci_register_iommu_tlb_event_notifier
+ *
+ * Returns 0 on success, or a negative errno otherwise.
+ *
+ * @dev: the device that wants to unsubscribe
+ * @pasid: the pasid of the address space to be untracked
+ * @n: the notifier to unregister
+ */
+int pci_unregister_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid=
,
+                                            IOMMUNotifier *n);
+
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
  *
--=20
2.48.1

