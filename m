Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF5BC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXn-00053U-Nj; Thu, 27 Feb 2025 05:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXm-0004xX-2Z
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:55:06 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXi-0005pC-Vw
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653703; x=1772189703;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=93DPdh46cLzZN/H4SIAXi99N43vLB8BDQmTdIJflg/U=;
 b=wH0LVVIFjkSXP9MoZUlHuwJmUi/1gcVXMgAJH4JcB/7n0vkF0sDkepFH
 TLqix0ulKa3omHDPQSucZaVW/KDAzRGt00VRtTb4IEcolWqbShlFUofGd
 5/wDl2vHsHYXmBlEaK2f1g2aEAlv9FT8Lg9pvmu8vO6ft8KR3ClX0jl9F
 NFtr6+YDnJENlsOBED0sO9E+4pUwUJwDc185/ODY23705S6AFH0aPHq0S
 nYGZ31A9EJKlFgmI+pmfErqfCDLzL1dwglHeUt0udat0miYnuC5Ml2tTZ
 jkQ+SOK8Wut0TNCVcknSqOn9UPDND8n5B9xmWFBhB1wP81IH8hFrTQJsN g==;
X-CSE-ConnectionGUID: qHwjQ/MiRsCjpd3Xfk0hkA==
X-CSE-MsgGUID: 6L/+7zHCSi6gFYAv4PYtOQ==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331846"
X-MGA-submission: =?us-ascii?q?MDFWjuXsEDunYHr/HTDP38RtzypBRAetvtOVcm?=
 =?us-ascii?q?dOGsmKOGat8VvKbD1ToST3hdGGTKC0WqVzKNvzmZQ+ioHlY6/vEBK+bl?=
 =?us-ascii?q?/VXXqV/xBfBzC54N7mH3l5c8IcL0shQmLKSw9FVGjYTigwvhKlatheLt?=
 =?us-ascii?q?fLx2KA/BJ/ZtwrBIIgpy9xkQ=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:49 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5KBlAL3wa7LNxmac2Np25/rNBEzldZNWx4JcY1qGoHz8hyBkQTsTpWVM+hAaKyVQEHHN8JOK2LpBol4g+H+RL/X8vSRLJV+A4zEcPuONv8NDPJBa03fa8XHFq9y2fhvF7YfYd7GGedf6JC8+nJhcI4y4KFIAhbjPlJgWNz2/xG9KYlXs5tOfOq/J8NUTU0vh2AMeP6K2H6lQcdCZdacUTat1WROBnHytkrWe0YYAldHwRolA9DuyOv2PF7AqqApFYRMm7YVIq3e61i++wGJRh7uJ2Zi4ABorLaDjd57dHgfQE7kkYnKl63mpdV0NMTHd5pWC4yzRAiWEXy7Sw/1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVNdNxN1Kzl6NpH3QHUnyPEPBmv8L7Yr/HO9NfaAAhs=;
 b=GpgXOcVAc6Dbob45u3AHSF3dmnZhRAvIbOx3n6GBwBMJpxunBnJsqvgrgA1BmHC1PzFvXZ1IsFpzNI7SFbDtcupHw5VIhD8xl5NYqn31w8LBGW5evQyHnjlRfyxqUYrdPaXWJR/p09cyIgtLAw1mrxiHmAV04cru/1mCkO4bfTn/E/xP1SInTEM8Tlm/iGVLuJwPXd2E51jvGqpFtvM31lh/5bL9pKtd3Vj8n6RNd0nn80qrqgpNWcz4MUvus8NFCPVZgRI1m9ZvEjxscN6wYA8bp+DCs5oFR3+KZVhfm3gna7rBEce4Oo977vOfs8uippByyLHHRg1KgdOibDCYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVNdNxN1Kzl6NpH3QHUnyPEPBmv8L7Yr/HO9NfaAAhs=;
 b=WMDgYZtlTH4Y8KgXNjRpSdGg8f0SohhbcSSGMA+iV1NvE6xRYpwojIFE0AISUHejeZAd5XbkcvEImqqBM3ABbRH1/hBrblZj+q+62crFJVmLwd+zskdR3GyWKg69sWB7l8OHe6ET+1hnbMxjV9DhtriC50flOJcTZnPyfftP0Lw462o6oeZEHvrlD+q/1J5ITlrp9RaVBnjadmc0TnPuBYUAN4PRoudN8PI9O8LvMHEHRkVtcDmVtyp1WVJB1IHUIaCUzw8awuqsmj0ZQ+TEW6f0KLpwT7J9A4klkjc91G/gTxSVhVA8vksqTZ66z3arJnEAEP2xBMzxLkwvcmo2zg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9097.eurprd07.prod.outlook.com (2603:10a6:20b:558::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:46 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:46 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 13/19] atc: Generic ATC that can be used by PCIe devices
 that support SVM
Thread-Topic: [PATCH v4 13/19] atc: Generic ATC that can be used by PCIe
 devices that support SVM
Thread-Index: AQHbiQYDqF0Aw28mhEmJoFUeCXHL/A==
Date: Thu, 27 Feb 2025 10:54:46 +0000
Message-ID: <20250227105339.388598-14-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 9cce7e6b-1416-478b-4504-08dd571d268d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?RI32GePygr7xDBE2ev4qO6D3MihhO4ewxbG4r1QOJQ/3ksQhUQ76pkoI17?=
 =?iso-8859-1?Q?CsY+NteBnc2c75tifz5p0GiWijZS0Vio5hb+1wav25Kt7pi3YRdFrujUpC?=
 =?iso-8859-1?Q?0Gd8IUSoKVB1imVRHrBU4ZclEPKO1jxOnCZ9YAvMv4lBejOhpIN3oncg5r?=
 =?iso-8859-1?Q?S1SbXQ0e4EENHgWwVCKlOmhGJlf72oU2gcXlxEKx3CqYYZRkuLQOkCIedo?=
 =?iso-8859-1?Q?eNRclT2sRD8HWXqIXJAjiESpbenKssmbp/InFPMLo1Pen9Xa0UtpmUVdKy?=
 =?iso-8859-1?Q?U8RuWbl+mb+9HCscahf47cnyaLflP3DQb6xxTTyIAJhSFiBc1V1zOcgylv?=
 =?iso-8859-1?Q?dT/lpfa5GuXVe+FYICKPGirPyrWfz1pNRQV0eqHtgu065Zgt6H6OQqGo19?=
 =?iso-8859-1?Q?16mLe3sWEKKgolH8bRM3Dc/m9mfDj/FfPdaHFyqoBo68JaTajWAAi64yuB?=
 =?iso-8859-1?Q?Wgo0CR/dMg0/BiNTcvT28z+qefwvAOlWJKhIyPOgT2p+rM8vQhelWoIq7d?=
 =?iso-8859-1?Q?Zf5X0a9yFYfKX+eCH/PsGXlkxA2UMK+pAINdpA4nwc7+nLGk7ZNht5TL60?=
 =?iso-8859-1?Q?dXNEo9ri4kcjXFoJBZN2SMRzI126Luuxw9wC+Gwy+LpMS570do9bAM8ao7?=
 =?iso-8859-1?Q?CcUa7n3ZExyDqXViC4Neknf6ZczxEq54HuEJa3ObT8ro5XxFU6R5f3ICcK?=
 =?iso-8859-1?Q?nuIz7p+kOlfhmRXpqxA/3iMhYPS9o6Yr+oapqCU1mo7G8dBs24fp8gB3YW?=
 =?iso-8859-1?Q?A6iFQEks9/F2uP+uHgMykuSqmNiSAJ2694u6vcfoqx7Tkj/HnXQUqtp8Qb?=
 =?iso-8859-1?Q?SPS1ia53FQgrNoeSxKvPYmaxnwDnKqD6YYgej+TPVMfjeyLcRbOE12sUzi?=
 =?iso-8859-1?Q?+fm0g82Fmi9xbSZs0rTNSMUO09TzdCy1d3+ZJmUBLciQAPp3ATRCIlyYig?=
 =?iso-8859-1?Q?9Y1AHMKJFJ1javezVZVloOEMtzgsHsM3HNBUgWcQSiVumnX2uw5zsdoBNv?=
 =?iso-8859-1?Q?s0vvoIipj74/QtQUS5bEC59eht2tgKstlty8X/vFhYLg/rAGanKHpEEjOY?=
 =?iso-8859-1?Q?GANzpXh42rlvsRdDYWkFVN/TaNAC3r23s3fg5/rBlT1vncVivu8wncERNB?=
 =?iso-8859-1?Q?oCvk2xsqmZ3692OPNQnJO4DcPltgj7d/ZSx4B83hozNVRXmjqo2BMhkC6F?=
 =?iso-8859-1?Q?x+kUTknEqpglvwFZBOWvWz5OmDYIW2TJYzz72iCiGePj+29nb0lZdgWxct?=
 =?iso-8859-1?Q?DMCcQD/vAUgNtZxnhDluNMrqJrRah75H/F47RCCfyPT9EeUeTT4+is37XB?=
 =?iso-8859-1?Q?m4QjeF6Ci3rtIFaqu5izzQX4mx88S9N92h9Kc25lnmuWpgNJvz62acofu8?=
 =?iso-8859-1?Q?JujYEqWWs0715LjpU67C7D0f+Yd1ec57S/0fzZjs/INJU7TeYNvsYE4ZIl?=
 =?iso-8859-1?Q?nmJtLvFxty2GwnFqjwUIIHZBSASS5orCYsLp1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vPH/la5EL/WXnX4HiujBCcglOdJHcilJ2zY8jxQVz8qIVU2Y93P8Bm48L9?=
 =?iso-8859-1?Q?ObGSr3P7nAIVNYDi2rVyirIEVFh3xKwcC55mqw7mfkIimSSyo6m1VF0ni1?=
 =?iso-8859-1?Q?1LxGYcfLpG1Dt7iNmqUiULr3D+aJTvz+Q/ecG9Ce3VVG8P6weeYYSvWr69?=
 =?iso-8859-1?Q?4qQzSnieJymusiBTcs6yh7Tai5tP6g58tu7MBy/G311b8GVIseBRIUJ1G1?=
 =?iso-8859-1?Q?1eEvXN4F2VnDePaoGGhYtNkBp0+0aTyf3RsQPZvY5eqEDMuz2WSxxnfFBR?=
 =?iso-8859-1?Q?4nSLAog2/ROx0v+yOq5Q9fpDIqXqe9sJBLQnCBmV9oUgyeMyIHLtwICyMM?=
 =?iso-8859-1?Q?0lvIpa8O9h5hTONhQjTkPWa7siXQLPwTeGph+5WRYOWVipXQogWffsjXFT?=
 =?iso-8859-1?Q?ezEh+C2GvEXNR0W6uEEfIquoPYMmgjJt0eVW5JgQs8oKVd100GwtryQqFn?=
 =?iso-8859-1?Q?wbmKItf+dPO3/XS66zFzfPwAFtt/JQPYBllUt7s/fnNPh+B1LP77uKsPXd?=
 =?iso-8859-1?Q?xwD0uauUyoReojQFDC+kPGqyK2QcdBvoy4oCDGT9qeUSHIwfq6gfGMZJwd?=
 =?iso-8859-1?Q?RaYVbb8tMXVH0tpOOOan1EhpBScrK4Ccomq2zGSObfm/7rwIy8XjgvpIiV?=
 =?iso-8859-1?Q?UyO9tClQjeR4S4BnAjaveXELuGlF1wlMW3jgCNIydPjJMfe5ruqWYr2JqH?=
 =?iso-8859-1?Q?i/Uo2NaQHN6KRZgKASR2PiW4XYqR0FfOX2TpJx0BrgB3wLrGc0z/jYNAPe?=
 =?iso-8859-1?Q?Fq9IvoV5e+fVFJAQwEX29tzWF/nyp5PGErgPUZwRiWhuVowangql1qnH4l?=
 =?iso-8859-1?Q?x+73r/qx+5FlEeSO4qivVAQU4qNFXHDrMMz4fQp+FoivDof6owaqPZzx6A?=
 =?iso-8859-1?Q?cT06Ztn9zhCGcA4EU8yycNyNi37MSMHQRd8kBzCtQFQSO0KHW63z+SYgaw?=
 =?iso-8859-1?Q?ZGqfIa8b2TYOhfL7N1pHR8/wcNGtwvtGT3TRiPHaT21ipBxP8mu+HAs2Iz?=
 =?iso-8859-1?Q?opmF6H1BzeG8kw7UTulKK6u/F6ZPpPGZfmYJJdPM/2ovDb6w0/I8kSJRr4?=
 =?iso-8859-1?Q?GV7x2U+VWhLKLVtx1gGJFGekSdGunvxNnHTbWGtsG3+TdpRGRtdeI98XeL?=
 =?iso-8859-1?Q?eVHKrRilARpxp4pHEW6ywFCHvkzNkyrWzb09nKGTdVudqIw2T8XtvLonog?=
 =?iso-8859-1?Q?+PfD+PbhrJhvyWPdc5IAzdeEanG2pOg9SZj8xxdo9+SbvrPeHP11i/0g3B?=
 =?iso-8859-1?Q?9ApVnIqu0sGEleZFEuRZVKkXyuw8nkH05oIQilcJvn/D6dBooC+N8aEUqf?=
 =?iso-8859-1?Q?zwJB82BF2nnrwCYQ6o43/dHtxdjqFcGd76UfhJoD2BFsv9y/l+c0VZoJri?=
 =?iso-8859-1?Q?AIDvaIYWHXMGbMHe78Mfwuu3/41hSebTX00WhcymjNfOJVIwWLMtG5g0Cn?=
 =?iso-8859-1?Q?QKV2moRqf58dhNVheCUYMQOnt+1sQOfB4pPmUQ3usxPMipZ3icMnWs9WdM?=
 =?iso-8859-1?Q?Le6fYG9egoYE9LPZpLeoLqgPwVjIy1FwK8ZOM1bLuVA7DkIFOJT2asaPV3?=
 =?iso-8859-1?Q?qLwppfUgWOSbUp4Oy6M1aPMfx/j86i6nNLh/y0QEYT8Vaokcm+0Us/wfI0?=
 =?iso-8859-1?Q?qhqI28Ktgfrmm7QI2SyeP+SpfBpqvK/nGQH+0xbscmFUv9R0SlsrQ/c/zw?=
 =?iso-8859-1?Q?zpcTgm2QSJqF41ifmeo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cce7e6b-1416-478b-4504-08dd571d268d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:46.6093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXjzH8riGveULQkGpOTr7vKRGyG1vP/uImeOlhhjedpZNSmdCuM3nz+nKJ9H+aaTr4aAEQTXsggeliQf/bCFuG7rHOxR3AQIExurdyhzWLfzkwoNnm1hrEdHHw8FcKvB
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

As the SVM-capable devices will need to cache translations, we provide
an first implementation.

This cache uses a two-level design based on hash tables.
The first level is indexed by a PASID and the second by a virtual addresse.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 util/atc.c       | 211 +++++++++++++++++++++++++++++++++++++++++++++++
 util/atc.h       | 117 ++++++++++++++++++++++++++
 util/meson.build |   1 +
 3 files changed, 329 insertions(+)
 create mode 100644 util/atc.c
 create mode 100644 util/atc.h

diff --git a/util/atc.c b/util/atc.c
new file mode 100644
index 0000000000..7cd5c7abea
--- /dev/null
+++ b/util/atc.c
@@ -0,0 +1,211 @@
+/*
+ * QEMU emulation of an ATC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "util/atc.h"
+
+
+#define PAGE_TABLE_ENTRY_SIZE 8
+
+/* a pasid is hashed using the identity function */
+static guint atc_pasid_key_hash(gconstpointer v)
+{
+    return (guint)(uintptr_t)v; /* pasid */
+}
+
+/* pasid equality */
+static gboolean atc_pasid_key_equal(gconstpointer v1, gconstpointer v2)
+{
+    return v1 =3D=3D v2;
+}
+
+/* Hash function for IOTLB entries */
+static guint atc_addr_key_hash(gconstpointer v)
+{
+    hwaddr addr =3D (hwaddr)(uintptr_t)v;
+    return (guint)((addr >> 32) ^ (addr & 0xffffffffU));
+}
+
+/* Equality test for IOTLB entries */
+static gboolean atc_addr_key_equal(gconstpointer v1, gconstpointer v2)
+{
+    return (hwaddr)(uintptr_t)v1 =3D=3D (hwaddr)(uintptr_t)v2;
+}
+
+static void atc_address_space_free(void *as)
+{
+    g_hash_table_unref(as);
+}
+
+/* return log2(val), or UINT8_MAX if val is not a power of 2 */
+static uint8_t ilog2(uint64_t val)
+{
+    uint8_t result =3D 0;
+    while (val !=3D 1) {
+        if (val & 1) {
+            return UINT8_MAX;
+        }
+
+        val >>=3D 1;
+        result +=3D 1;
+    }
+    return result;
+}
+
+ATC *atc_new(uint64_t page_size, uint8_t address_width)
+{
+    ATC *atc;
+    uint8_t log_page_size =3D ilog2(page_size);
+    /* number of bits each used to store all the intermediate indexes */
+    uint64_t addr_lookup_indexes_size;
+
+    if (log_page_size =3D=3D UINT8_MAX) {
+        return NULL;
+    }
+    /*
+     * We only support page table entries of 8 (PAGE_TABLE_ENTRY_SIZE) byt=
es
+     * log2(page_size / 8) =3D log2(page_size) - 3
+     * is the level offset
+     */
+    if (log_page_size <=3D 3) {
+        return NULL;
+    }
+
+    atc =3D g_new0(ATC, 1);
+    atc->address_spaces =3D g_hash_table_new_full(atc_pasid_key_hash,
+                                                atc_pasid_key_equal,
+                                                NULL, atc_address_space_fr=
ee);
+    atc->level_offset =3D log_page_size - 3;
+    /* at this point, we know that page_size is a power of 2 */
+    atc->min_addr_mask =3D page_size - 1;
+    addr_lookup_indexes_size =3D address_width - log_page_size;
+    if ((addr_lookup_indexes_size % atc->level_offset) !=3D 0) {
+        goto error;
+    }
+    atc->levels =3D addr_lookup_indexes_size / atc->level_offset;
+    atc->page_size =3D page_size;
+    return atc;
+
+error:
+    g_free(atc);
+    return NULL;
+}
+
+static inline GHashTable *atc_get_address_space_cache(ATC *atc, uint32_t p=
asid)
+{
+    return g_hash_table_lookup(atc->address_spaces,
+                               (gconstpointer)(uintptr_t)pasid);
+}
+
+void atc_create_address_space_cache(ATC *atc, uint32_t pasid)
+{
+    GHashTable *as_cache;
+
+    as_cache =3D atc_get_address_space_cache(atc, pasid);
+    if (!as_cache) {
+        as_cache =3D g_hash_table_new_full(atc_addr_key_hash,
+                                         atc_addr_key_equal,
+                                         NULL, g_free);
+        g_hash_table_replace(atc->address_spaces,
+                             (gpointer)(uintptr_t)pasid, as_cache);
+    }
+}
+
+void atc_delete_address_space_cache(ATC *atc, uint32_t pasid)
+{
+    g_hash_table_remove(atc->address_spaces, (gpointer)(uintptr_t)pasid);
+}
+
+int atc_update(ATC *atc, IOMMUTLBEntry *entry)
+{
+    IOMMUTLBEntry *value;
+    GHashTable *as_cache =3D atc_get_address_space_cache(atc, entry->pasid=
);
+    if (!as_cache) {
+        return -ENODEV;
+    }
+    value =3D g_memdup2(entry, sizeof(*value));
+    g_hash_table_replace(as_cache, (gpointer)(uintptr_t)(entry->iova), val=
ue);
+    return 0;
+}
+
+IOMMUTLBEntry *atc_lookup(ATC *atc, uint32_t pasid, hwaddr addr)
+{
+    IOMMUTLBEntry *entry;
+    hwaddr mask =3D atc->min_addr_mask;
+    hwaddr key =3D addr & (~mask);
+    GHashTable *as_cache =3D atc_get_address_space_cache(atc, pasid);
+
+    if (!as_cache) {
+        return NULL;
+    }
+
+    /*
+     * Iterate over the possible page sizes and try to find a hit
+     */
+    for (uint8_t level =3D 0; level < atc->levels; ++level) {
+        entry =3D g_hash_table_lookup(as_cache, (gconstpointer)(uintptr_t)=
key);
+        if (entry && (mask =3D=3D entry->addr_mask)) {
+            return entry;
+        }
+        mask =3D (mask << atc->level_offset) | ((1 << atc->level_offset) -=
 1);
+        key =3D addr & (~mask);
+    }
+
+    return NULL;
+}
+
+static gboolean atc_invalidate_entry_predicate(gpointer key, gpointer valu=
e,
+                                               gpointer user_data)
+{
+    IOMMUTLBEntry *entry =3D (IOMMUTLBEntry *)value;
+    IOMMUTLBEntry *target =3D (IOMMUTLBEntry *)user_data;
+    hwaddr target_mask =3D ~target->addr_mask;
+    hwaddr entry_mask =3D ~entry->addr_mask;
+    return ((target->iova & target_mask) =3D=3D (entry->iova & target_mask=
)) ||
+           ((target->iova & entry_mask) =3D=3D (entry->iova & entry_mask))=
;
+}
+
+void atc_invalidate(ATC *atc, IOMMUTLBEntry *entry)
+{
+    GHashTable *as_cache =3D atc_get_address_space_cache(atc, entry->pasid=
);
+    if (!as_cache) {
+        return;
+    }
+    g_hash_table_foreach_remove(as_cache,
+                                atc_invalidate_entry_predicate,
+                                entry);
+}
+
+void atc_destroy(ATC *atc)
+{
+    g_hash_table_unref(atc->address_spaces);
+}
+
+size_t atc_get_max_number_of_pages(ATC *atc, hwaddr addr, size_t length)
+{
+    hwaddr page_mask =3D ~(atc->min_addr_mask);
+    size_t result =3D (length / atc->page_size);
+    if ((((addr & page_mask) + length - 1) & page_mask) !=3D
+        ((addr + length - 1) & page_mask)) {
+        result +=3D 1;
+    }
+    return result + (length % atc->page_size !=3D 0 ? 1 : 0);
+}
+
+void atc_reset(ATC *atc)
+{
+    g_hash_table_remove_all(atc->address_spaces);
+}
diff --git a/util/atc.h b/util/atc.h
new file mode 100644
index 0000000000..8be95f5cca
--- /dev/null
+++ b/util/atc.h
@@ -0,0 +1,117 @@
+/*
+ * QEMU emulation of an ATC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef UTIL_ATC_H
+#define UTIL_ATC_H
+
+#include "qemu/osdep.h"
+#include "exec/memory.h"
+
+typedef struct ATC {
+    GHashTable *address_spaces; /* Key : pasid, value : GHashTable */
+    hwaddr min_addr_mask;
+    uint64_t page_size;
+    uint8_t levels;
+    uint8_t level_offset;
+} ATC;
+
+/*
+ * atc_new: Create an ATC.
+ *
+ * Return an ATC or NULL if the creation failed
+ *
+ * @page_size: #PCIDevice doing the memory access
+ * @address_width: width of the virtual addresses used by the IOMMU (in bi=
ts)
+ */
+ATC *atc_new(uint64_t page_size, uint8_t address_width);
+
+/*
+ * atc_update: Insert or update an entry in the cache
+ *
+ * Return 0 if the operation succeeds, a negative error code otherwise
+ *
+ * The insertion will fail if the address space associated with this pasid
+ * has not been created with atc_create_address_space_cache
+ *
+ * @atc: the ATC to update
+ * @entry: the tlb entry to insert into the cache
+ */
+int atc_update(ATC *atc, IOMMUTLBEntry *entry);
+
+/*
+ * atc_create_address_space_cache: delare a new address space
+ * identified by a PASID
+ *
+ * @atc: the ATC to update
+ * @pasid: the pasid of the address space to be created
+ */
+void atc_create_address_space_cache(ATC *atc, uint32_t pasid);
+
+/*
+ * atc_delete_address_space_cache: delete an address space
+ * identified by a PASID
+ *
+ * @atc: the ATC to update
+ * @pasid: the pasid of the address space to be deleted
+ */
+void atc_delete_address_space_cache(ATC *atc, uint32_t pasid);
+
+/*
+ * atc_lookup: query the cache in a given address space
+ *
+ * @atc: the ATC to query
+ * @pasid: the pasid of the address space to query
+ * @addr: the virtual address to translate
+ */
+IOMMUTLBEntry *atc_lookup(ATC *atc, uint32_t pasid, hwaddr addr);
+
+/*
+ * atc_invalidate: invalidate an entry in the cache
+ *
+ * @atc: the ATC to update
+ * @entry: the entry to invalidate
+ */
+void atc_invalidate(ATC *atc, IOMMUTLBEntry *entry);
+
+/*
+ * atc_destroy: delete an ATC
+ *
+ * @atc: the cache to be deleted
+ */
+void atc_destroy(ATC *atc);
+
+/*
+ * atc_get_max_number_of_pages: get the number of pages a memory operation
+ * will access if all the pages concerned have the minimum size.
+ *
+ * This function can be used to determine the size of the result array to =
be
+ * allocated when issuing an ATS request.
+ *
+ * @atc: the cache
+ * @addr: start address
+ * @length: number of bytes accessed from addr
+ */
+size_t atc_get_max_number_of_pages(ATC *atc, hwaddr addr, size_t length);
+
+/*
+ * atc_reset: invalidates all the entries stored in the ATC
+ *
+ * @atc: the cache
+ */
+void atc_reset(ATC *atc);
+
+#endif
diff --git a/util/meson.build b/util/meson.build
index 780b5977a8..5e175ca665 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -95,6 +95,7 @@ if have_block
   util_ss.add(files('hbitmap.c'))
   util_ss.add(files('hexdump.c'))
   util_ss.add(files('iova-tree.c'))
+  util_ss.add(files('atc.c'))
   util_ss.add(files('iov.c'))
   util_ss.add(files('nvdimm-utils.c'))
   util_ss.add(files('block-helpers.c'))
--=20
2.48.1

