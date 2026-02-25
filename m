Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12775EFB7F0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv8Yg-0007YV-V3; Wed, 25 Feb 2026 01:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vv8Yf-0007Y9-MU
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:39:41 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vv8Yd-0006Ak-G9
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1772001579; x=1803537579;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=8MR6hyjGnQ6OfH4l/ZsvJ3GICWCLh8hE7pFxI7gumU4=;
 b=OoBZ6Qy1kxkJuz1dbzplMX+o4I6O2hAhIHsjy4XW92ICk/B27FUS25jy
 RGdqrSIuJZFb8hydB8Ik0c/sFTN/hMyXQ/SKTjnrA4s9TdHepMwcZiYhH
 CeSoSmXt8EhZnW66fmj0+2hiLc5HZXKiMhimtcG/miThX3DTuiOiHCPgC
 rP3haJT4O3PDoZXCIPaXSlh/ekBpPeHJ/xxHuh7M5ZIOv0gNr6BciDZYM
 z6vwdHschlxpLrd3CtYstKQ/xOX/8Q0VV5HmgS8fJKa/FnHqsih7DHtHI
 wS6cT1w9/eOUMUaRYC6ATgonyH7dmZAN7WVYHTXcKTX+kTbRfQR/CW8vQ w==;
X-CSE-ConnectionGUID: 2YsETivlQvKXrophEkdftg==
X-CSE-MsgGUID: SM5srcU/TA2m/mDbbISwFA==
X-IronPort-AV: E=Sophos;i="6.21,310,1763420400"; d="scan'208,217";a="48759392"
X-MGA-submission: =?us-ascii?q?MDHUZwGhFwtiQsotiLfus7Ic9Uz0zKJrtDGGEu?=
 =?us-ascii?q?AEblJ4IE3DRLpZL6ykCyvlp/PDJJBPF5AC/gUFARU6WY6++dnP7mg7yn?=
 =?us-ascii?q?L5kXEXinzj5RB+iuPGRRUG+tDSz02dbd7TkW5cjERKyp8UJd333Y6/my?=
 =?us-ascii?q?3qDkJ/4eTyKQvo4tT9NixZYw=3D=3D?=
Received: from mail-westeuropeazon11013021.outbound.protection.outlook.com
 (HELO AM0PR02CU008.outbound.protection.outlook.com) ([52.101.72.21])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 25 Feb 2026 07:39:36 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8MUOAAguj6xs0qokD2kpyH2aPKy5yeuknrdIdLjcynwZlxJCJT06h255eBnFdWODQA0DUrqoIVr1XRsQJW8UkMZDERQq+nlXXJ2XSGquLT/VeCCBKkjx+5vGusA/AMTR/7a5UTPnyKK3dwu/SgZ5C2kkz1lJiWYFaU871fsKy18LDZ6NWyPZX+XUmYb88WK9ht9sXwO2dgFVMGHwCyxh+OkTK988UJSmN7XRnwXEi0UJuJi0uEHaPq1V0RWoA0lXgPZcSUIOFSVGJd7atXXMEHX3gy7Dc/0hTEc5wxSNIAmb0rnfGylkW06nnZdvbsvQ2STezxrgpK3ZcwT3b1inA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KODrkODByumwSBtk0MA1Db6cFb9JLU6Fr8Uf/hEKIIE=;
 b=lmp6KGzAG75KREsD9PIpnpf4axTAI4TMHiiRQ9hgc7rke/BrnM/th5eFZa3hk+TiocYeZuPjkAL9+3w53/7JN9LGKFRAMM04p916M6SgJYyAT6xxoXAL7Fn6E3q0VWbhSmwE7R/xs3jgkn2JWeutDhV3LylkIRxKEiRnqIDEA9EF4TiN6K5u26ky8bX/T7DbtLC0Y+ki+qqJ2v+tcPdzBBEusi5e6vzi/GGi0BKpoqdzZI63OucQ5qjb8tlUxlhBd439yT4QRMvuSWb7OptJu+Du4CAmK0PoNM7zA8Sl5vUnmzC3lLfVdoYvY6Q2F9SdJSARFik4vdSn/fCfGlTwUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KODrkODByumwSBtk0MA1Db6cFb9JLU6Fr8Uf/hEKIIE=;
 b=jI61dvwu3aeYDJva+9OhyNbwZxQAkjnqdmYBGkIx0P27+oecGAYen0rq6fComne8RjxLNJjWB/Xm5QqF8lNLkgYq9dO4d4HfJnImeTbXDVTJ2qJB8qII/VscTk4eWGUDQvXgN9FHZQ72kxyTeKBHiKwNbO8fxFJRNsI0/RbFkQeuZ6GQTVQlGrMFUnnjXAu5xJ4IJ6xLOGqWeg+Gv2qVeCHn4Nq4MtnSn6ZUfTZzh8kGrTDF8cQrnzNJulkswjlF7Q9WaqI9QK6RH2j58F+jVfOjIxO9kY16zGi5SJpGxjAtYaSnNcMXb81IiAMGkQYwJN7g2pZuSqJutAwNDlmIpQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB9162.eurprd07.prod.outlook.com (2603:10a6:10:406::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 06:39:34 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 06:39:33 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [RFCv2 PATCH 05/13] intel_iommu: Change pasid property from bool
 to uint8
Thread-Topic: [RFCv2 PATCH 05/13] intel_iommu: Change pasid property from bool
 to uint8
Thread-Index: AQHcnWPnUOmYJnVK2U2r1xXMh6NMMrWTB8Ry
Date: Wed, 25 Feb 2026 06:39:33 +0000
Message-ID: <AM8PR07MB76022449D3A87724252E41FB8675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
 <20260214034135.220413-6-zhenzhong.duan@intel.com>
In-Reply-To: <20260214034135.220413-6-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-25T06:39:09.792Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB9162:EE_
x-ms-office365-filtering-correlation-id: 5bc73e3d-5053-48f0-92e3-08de7438a33d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|8096899003|7053199007|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GKxWmm74pFmRheB0s385dv4FwV0ghgRV0cddN4vuxbgXEkNLFPuA7Ecwb1?=
 =?iso-8859-1?Q?Aub+52dLhpH78AeHsPJkuR6ZOsHTTdL6dve7G6rA775l/kOzTodQn/io5T?=
 =?iso-8859-1?Q?sIDsF0XerPAcMaMdikH9bueMepQimjRkDMHSwS5H7YMLrmlDaRpY93Liex?=
 =?iso-8859-1?Q?MV9p/H7CT8getbNDjerzXA7yze6K+YmnDrxc490Wrj9+VAnauacDGS/Q+I?=
 =?iso-8859-1?Q?g3hufwuGie+Wx937at8zbSwKeS3Jf/9prtwPGug1njKb8z7blJP0eObryI?=
 =?iso-8859-1?Q?qfr9N6mAkLl9/KgadTkCoQDO1mEMokOdWYEQCZugHNzEy1mw83CsX9U3Tb?=
 =?iso-8859-1?Q?bqEvf09qFM+Vs/XSEdhyIxmOsEMfR5Xjf9FgH+TWrzmPsXFvSMxBw0E20r?=
 =?iso-8859-1?Q?aBroBngFogtJC+Po++/t922j2WaVuhvBuVLyilnu404hkPA8EHXI1KGWGB?=
 =?iso-8859-1?Q?7Drpa1mWxeqYSZBhrml1uKeCv4hSvilP+O7itWMd9pWNRkdMo8bF8wgVP9?=
 =?iso-8859-1?Q?LoX5H14hZontyBCUmDGnJBDn18ZfJ0cyXg+qE0/Jqx70pN5vIhVy4Y1BgF?=
 =?iso-8859-1?Q?18SoRfkZa4McAtvd0M+5x6ktQ8ZIn/jtEWpukaeZKusgyIGjrtJW2xh8EA?=
 =?iso-8859-1?Q?prKzMPaSru3NDpnHgEw7tEoRiJ3oclCXkp2IAhvYdsaLzGW0dHAV1hN2aV?=
 =?iso-8859-1?Q?rk8UmKCKcn2RxXLX4OXWO2KYj31drtICIH1bvJedxRbA0Pysl66kwVvkkY?=
 =?iso-8859-1?Q?+42i+iaB17N8C1P6qDdZutqEoLoa9e8T0xepTHN6F0a/87nlu714gjXoh5?=
 =?iso-8859-1?Q?m/nODiIm4CkHXW2HvvhLw/q3Thoa7BSRP1/AU6BmL4Vuvs6+np/tPr9bZP?=
 =?iso-8859-1?Q?p7mUKg5hYh4DI6Cyq5BbcowQYg9THNacd2hZSRXlvegzd3A7ovoj8eLPZa?=
 =?iso-8859-1?Q?q719zZKKwe2e2wAsHZV46WNIwPCqn/nqWLkx+H+IttaXzMR658ACOZ+glC?=
 =?iso-8859-1?Q?wklRC1bw8MTIZOd7B1/NdLtnw8TEL4NB6d9tnCNqMf4Q4z8n9novvvv82i?=
 =?iso-8859-1?Q?o7nbdkoKQmcGyqTraIKLfiWSteEhMFcX88rwGgTGqDdokfyHSm71dFVymz?=
 =?iso-8859-1?Q?fZdbZKvnKR3t+PkKQo7r5O0L2BNZrWff0OJsf4kgbN9j3BSXVGzWhuQdL9?=
 =?iso-8859-1?Q?vAuKuZDuGUJdAFss+EvT12MNu1MJceMmKMLGNrywdYof/ib+Zff9frlzp7?=
 =?iso-8859-1?Q?c4VXSirmJ5EYGRnB9vh/t8Is42lU4a5G95rq1dH1SnYG42nnq8MYw99b5W?=
 =?iso-8859-1?Q?k+U4A/1Sso01Kt0V79WBgz5sfxVnLpKKPlsB2DOOg3F3Tt6p8RqCXPfn43?=
 =?iso-8859-1?Q?A+Ceps4bwu+yRPDGY/hTwyFw0mRrs1SoR2xg6+nBSB0ZmSFCK1TxPjES+s?=
 =?iso-8859-1?Q?HtIq5Opx0NC7SieCOckLYCSH4XcxTItkQRRV/UBBVDNts7yu1EkYahQex8?=
 =?iso-8859-1?Q?L/tgoYBcxUy9ylG9GqjfFyGne+3/vSnQWQZfYde9bRmDF+G/gkRDl/uZYt?=
 =?iso-8859-1?Q?sQWx7POpNHK5zG0/Bar4Kn7TQUT3c0V3JtAD0x+zfB2NDcfdZHo2KffdEV?=
 =?iso-8859-1?Q?7T30hfJA68qM65hz81utRJun9TWKO+/9T7xnXYKQUG74La+LFz0th4ng45?=
 =?iso-8859-1?Q?GPUfmnTV3geNSWwe91Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aR4gFtKOxAPEKxsPW5ZElkZPG0SkFJuMzLVx9wL0gDprBLbazmUiy8r3yT?=
 =?iso-8859-1?Q?MjII9JgWkyIWNdBAbqam2tkAZCOpc2ehPAdGDvF2lolmvjocmNveMIuPhB?=
 =?iso-8859-1?Q?PF1W/6eB5MgWLW7O3F8HHan/fW/O7uYNLQX5cN5g4fJpE+jgmBg3kPVMQ+?=
 =?iso-8859-1?Q?Jzlkqw4mriFllF23XMYHxmUy7DIa/p67eU2GNrb2D6A2nIV0GupSxLeWEs?=
 =?iso-8859-1?Q?watsJKVr0OcCawO2sqVFh+fQyZ6I/ZI8GuxHVjBODXQJLHEHmLo50IyY+4?=
 =?iso-8859-1?Q?Da8i9YuVFqkanZYTr/TqL+RlVux9wte/fY8HAyFQIJndkKctJMiW+HaGwc?=
 =?iso-8859-1?Q?KsLyRulC7qX9FZ3Fp8ZGkvXjPEdzC0LGVGnccTqiTFwCF2qd1KZ+sdJLaV?=
 =?iso-8859-1?Q?xils9sQfTQbD8ki1gXUgdYxJ2aiI+tZmjibUlotIcZAwyzv+GAc9PSxmIh?=
 =?iso-8859-1?Q?W+5ulYCGdtBJpKMM2Wuu7EaZRp7E++7LyqNg6/dySs25njVkEiU70I714K?=
 =?iso-8859-1?Q?066NAaTb1Q9XXyfIdHf9eNyqw8eo27NiaYByxownSpiNCbN5KE8QkJ9QjJ?=
 =?iso-8859-1?Q?1V22fs2QWiFKyIB/s1a9VsnaS7B1pzzfz/386m2dLOuuPBjwurS9J6vBtd?=
 =?iso-8859-1?Q?LE9SW8PUS2SZ3eXVnXaFHc/8rfwHDe5K5BpGgMElrSznOp9HmBHydlNBDY?=
 =?iso-8859-1?Q?x5BDbVvyKiN+rfczCqScBIV3WPu3Mn8OiKaynFJNYIdwh7XSZ3iCaX0Jak?=
 =?iso-8859-1?Q?Z4q85oFrjMtjCCASaaqkkLgLf90EKcGVJ/wqEcHjw0mGKLQkzq5ON6cm2k?=
 =?iso-8859-1?Q?82nLeLWVkMq6lFVKjNMg12UyhsyvABHkMzoO+7cJbTXyiGenkOk/eQ2NRa?=
 =?iso-8859-1?Q?Dd9nzNfAvyQKe1gORIwSey6DB09V1O36KL/UVbH9Yjwl8uNq32xJRJoeAT?=
 =?iso-8859-1?Q?gIXgNF3OZVjfP0b/fZPwJ5nFwfa9lGK9nyv95p8+k8fWm/yRmJZDEtx7T+?=
 =?iso-8859-1?Q?s1vMQb+bcKt9RODrx4DNBchIRNQZ8K7h4GHzl3zCiG5Zag8mJW+5H2OdK4?=
 =?iso-8859-1?Q?Z49TZHlUbWhRwoyD3aCnFeAdueJ+AUkKtpgcdcKccZVg6I1YyUI8roXjrb?=
 =?iso-8859-1?Q?/ZGsmOynvSRTFDhTgS3J7Cl3cymGZsMidbPmckcQSjiMLR4vjwTsNZh2sX?=
 =?iso-8859-1?Q?401fK5DP9wBLRklFU5SBnkZ2ckpfyFebazosmQD3gUT9yyxD4orGgBjE28?=
 =?iso-8859-1?Q?V7ezxPozSLXcfdpEnYxwNOBM6bqy+X8wSQEs6ojAShrGFMrpsaZVIqgpES?=
 =?iso-8859-1?Q?ku5ns+XIKLuWKlAFCee7c0X24lt8Jj+UXoj4mKeUC8qPFKZp/yJeqMzeqk?=
 =?iso-8859-1?Q?YVPT5Rvg6mu93yR12R8KfZiE4k//UB1CpVFZC2d3Bsqscfaxum+/UZblNt?=
 =?iso-8859-1?Q?wL72GATTHrzIAHTI92h3FM/o5mBi6lJ56b7pmFRKcAfBKB3hy8xHKPgdMy?=
 =?iso-8859-1?Q?dE7m1QROKHsEPKxHQkr7WN2G9QpO/GqB9AyZ8gU2tBv4OgwbDrIJso9ExF?=
 =?iso-8859-1?Q?6Ek9uh+YGEoZFQY8Mt4XsfsV3+vFXC3dhdf5wgTj86hqtXDdbewsqHNKrd?=
 =?iso-8859-1?Q?psoPYmIrJIf4d8tuwQcDUcvsIuP8Obk/m1akTx3OnG8bPhoHsCSxiP9rDQ?=
 =?iso-8859-1?Q?cmR4jG+YyRAlT52HX5LXgyuANZ26iB6AexcEU3cfBEdUCia2GTXVKzjRvx?=
 =?iso-8859-1?Q?6isNBgugtnNrvU4bHlQHyoFpC+B2EqAzNycrzs/XJj24O+whyejYUn7EWZ?=
 =?iso-8859-1?Q?HTgwxIhq0x8RXcoL20QoFfklsAmq7pQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_AM8PR07MB76022449D3A87724252E41FB8675AAM8PR07MB7602eurp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qCHmi8DglWRHl/ufDSI9xLPpBxG3miYOaJ8KJn4KEqr6BrhMIw/mFayUpGw7X/b7coVoq2DeKsDrW3OTxlhtyrh+nn/jO9j14KrI3HTyd8Tq/yDZdJ88iijVnS7LBG5MAVsgtm3PDoK/p5pXJqh/DB/FYL8OVKfNLvF9EyMW6NKd+kWIfYPI+AXbfIEbFg9HM5/d7xTvnqdBk0Cu1Bm2ZMWMVmIRyT6oinICQouU463KVR3jglVZw8hl6wQm1p5bJ057mzXkL/unfJF3NvpvTGFovX6MLxTya3tiDy1g8fAvJEhi419rSg+JCIZnnkb35ZKQ9jUY+pK7cisL4IpKbQ==
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc73e3d-5053-48f0-92e3-08de7438a33d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 06:39:33.8784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RMgkuUkSuvE/IJFq0RfW+AJ/ZhOS9LCJpaeB8GQN7fhVriB8mMRULNbxLOXrtTNAWEZIyoXwDqjJqWE9y+8XGEd+icrVoXD13exXPNf0w+x6ixnRvuk73NZu9bqspNA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9162
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_AM8PR07MB76022449D3A87724252E41FB8675AAM8PR07MB7602eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Zhenzhong,

Maybe VTD_ECAP_PSS could be modified to take the pasid width and return the=
 PSS field with the correct offset.

This comment echos what I said about [12/13]

cmd

________________________________
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
Sent: 14 February 2026 04:41
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: alex@shazbot.org <alex@shazbot.org>; clg@redhat.com <clg@redhat.com>; e=
ric.auger@redhat.com <eric.auger@redhat.com>; mst@redhat.com <mst@redhat.co=
m>; jasowang@redhat.com <jasowang@redhat.com>; jgg@nvidia.com <jgg@nvidia.c=
om>; nicolinc@nvidia.com <nicolinc@nvidia.com>; skolothumtho@nvidia.com <sk=
olothumtho@nvidia.com>; joao.m.martins@oracle.com <joao.m.martins@oracle.co=
m>; CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>; kevin.tian@in=
tel.com <kevin.tian@intel.com>; yi.l.liu@intel.com <yi.l.liu@intel.com>; xu=
dong.hao@intel.com <xudong.hao@intel.com>; Zhenzhong Duan <zhenzhong.duan@i=
ntel.com>
Subject: [RFCv2 PATCH 05/13] intel_iommu: Change pasid property from bool t=
o uint8

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


'x-pasid-mode' is a bool property, we need an extra 'pss' property to
represent PASID size supported. Because there is no any device in QEMU
supporting pasid capability yet, no guest could use the pasid feature
until now, 'x-pasid-mode' takes no effect.

So instead of an extra 'pss' property we can use a single 'pasid'
property of uint8 type to represent if pasid is supported and the PASID
bits size. A value of N > 0 means pasid is supported and N - 1 is the
value in PSS field in ECAP register.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h | 1 -
 include/hw/i386/intel_iommu.h  | 2 +-
 hw/i386/intel_iommu.c          | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 11a53aa369..04a9392e8a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,7 +195,6 @@
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_NWFS               (1ULL << 33)
-#define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid=
 */
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 54c2b6b77a..bb957b93e0 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -315,7 +315,7 @@ struct IntelIOMMUState {
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) *=
/
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
-    bool pasid;                     /* Whether to support PASID */
+    uint8_t pasid;                  /* PASID supported in bits, 0 if not *=
/
     bool fs1gp;                     /* First Stage 1-GByte Page Support */

     /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 92a367d657..e27a7c725f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4186,7 +4186,7 @@ static const Property vtd_properties[] =3D {
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FA=
LSE),
     DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, fals=
e),
-    DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
+    DEFINE_PROP_UINT8("pasid", IntelIOMMUState, pasid, 0),
     DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
@@ -5033,7 +5033,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }

     if (s->pasid) {
-        s->ecap |=3D VTD_ECAP_PASID | VTD_ECAP_PSS;
+        s->ecap =3D VTD_ECAP_PASID | deposit64(s->ecap, 35, 5, s->pasid - =
1);
     }
 }

--
2.47.3


--_000_AM8PR07MB76022449D3A87724252E41FB8675AAM8PR07MB7602eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Zhenzhong,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Maybe VTD_ECAP_PSS could be modified to take the pasid width and return the=
 PSS field with the correct offset.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This comment echos what I said about [12/13]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
cmd</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Zhenzhong Duan &lt;zhenzhong.duan@intel.com&gt;<br>
<b>Sent:</b>&nbsp;14 February 2026 04:41<br>
<b>To:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b>&nbsp;alex@shazbot.org &lt;alex@shazbot.org&gt;; clg@redhat.com &=
lt;clg@redhat.com&gt;; eric.auger@redhat.com &lt;eric.auger@redhat.com&gt;;=
 mst@redhat.com &lt;mst@redhat.com&gt;; jasowang@redhat.com &lt;jasowang@re=
dhat.com&gt;; jgg@nvidia.com &lt;jgg@nvidia.com&gt;; nicolinc@nvidia.com
 &lt;nicolinc@nvidia.com&gt;; skolothumtho@nvidia.com &lt;skolothumtho@nvid=
ia.com&gt;; joao.m.martins@oracle.com &lt;joao.m.martins@oracle.com&gt;; CL=
EMENT MATHIEU--DRIF &lt;clement.mathieu--drif@eviden.com&gt;; kevin.tian@in=
tel.com &lt;kevin.tian@intel.com&gt;; yi.l.liu@intel.com &lt;yi.l.liu@intel=
.com&gt;;
 xudong.hao@intel.com &lt;xudong.hao@intel.com&gt;; Zhenzhong Duan &lt;zhen=
zhong.duan@intel.com&gt;<br>
<b>Subject:</b>&nbsp;[RFCv2 PATCH 05/13] intel_iommu: Change pasid property=
 from bool to uint8</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Caution: External email. Do not open attach=
ments or click links, unless this email comes from a known sender and you k=
now the content is safe.<br>
<br>
<br>
'x-pasid-mode' is a bool property, we need an extra 'pss' property to<br>
represent PASID size supported. Because there is no any device in QEMU<br>
supporting pasid capability yet, no guest could use the pasid feature<br>
until now, 'x-pasid-mode' takes no effect.<br>
<br>
So instead of an extra 'pss' property we can use a single 'pasid'<br>
property of uint8 type to represent if pasid is supported and the PASID<br>
bits size. A value of N &gt; 0 means pasid is supported and N - 1 is the<br=
>
value in PSS field in ECAP register.<br>
<br>
Signed-off-by: Zhenzhong Duan &lt;zhenzhong.duan@intel.com&gt;<br>
---<br>
&nbsp;hw/i386/intel_iommu_internal.h | 1 -<br>
&nbsp;include/hw/i386/intel_iommu.h&nbsp; | 2 +-<br>
&nbsp;hw/i386/intel_iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 4 ++--<br>
&nbsp;3 files changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h<br>
index 11a53aa369..04a9392e8a 100644<br>
--- a/hw/i386/intel_iommu_internal.h<br>
+++ b/hw/i386/intel_iommu_internal.h<br>
@@ -195,7 +195,6 @@<br>
&nbsp;#define VTD_ECAP_MHMV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (15ULL &lt;&lt; 20)<br>
&nbsp;#define VTD_ECAP_SRS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 31)<br>
&nbsp;#define VTD_ECAP_NWFS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 33)<br>
-#define VTD_ECAP_PSS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (7ULL &lt;&lt; 35) /* limit: MemTxAttr=
s::pid */<br>
&nbsp;#define VTD_ECAP_PASID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 40)<br>
&nbsp;#define VTD_ECAP_PDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 42)<br>
&nbsp;#define VTD_ECAP_SMTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 43)<br>
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h<=
br>
index 54c2b6b77a..bb957b93e0 100644<br>
--- a/include/hw/i386/intel_iommu.h<br>
+++ b/include/hw/i386/intel_iommu.h<br>
@@ -315,7 +315,7 @@ struct IntelIOMMUState {<br>
&nbsp;&nbsp;&nbsp;&nbsp; OnOffAuto intr_eim;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Toggle for EIM cabability */<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t aw_bits;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Host/IOVA addre=
ss width (in bits) */<br>
&nbsp;&nbsp;&nbsp;&nbsp; bool dma_drain;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Whether DM=
A r/w draining enabled */<br>
-&nbsp;&nbsp;&nbsp; bool pasid;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* Whether to support PASID */<br>
+&nbsp;&nbsp;&nbsp; uint8_t pasid;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PASID supp=
orted in bits, 0 if not */<br>
&nbsp;&nbsp;&nbsp;&nbsp; bool fs1gp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* First Stage 1-GByte Page Support */<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* Transient Mapping, Reserved(0) since VTD spec r=
evision 3.2 */<br>
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
index 92a367d657..e27a7c725f 100644<br>
--- a/hw/i386/intel_iommu.c<br>
+++ b/hw/i386/intel_iommu.c<br>
@@ -4186,7 +4186,7 @@ static const Property vtd_properties[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;x-scalable-mode&quot;, Inte=
lIOMMUState, scalable_mode, FALSE),<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;x-flts&quot;, IntelIOMMUSta=
te, fsts, FALSE),<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;snoop-control&quot;, IntelI=
OMMUState, snoop_control, false),<br>
-&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;x-pasid-mode&quot;, IntelIOMMUSt=
ate, pasid, false),<br>
+&nbsp;&nbsp;&nbsp; DEFINE_PROP_UINT8(&quot;pasid&quot;, IntelIOMMUState, p=
asid, 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;svm&quot;, IntelIOMMUState,=
 svm, false),<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;dma-drain&quot;, IntelIOMMU=
State, dma_drain, true),<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;stale-tm&quot;, IntelIOMMUS=
tate, stale_tm, false),<br>
@@ -5033,7 +5033,7 @@ static void vtd_cap_init(IntelIOMMUState *s)<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;pasid) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ecap |=3D VTD_ECAP_PASID =
| VTD_ECAP_PSS;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ecap =3D VTD_ECAP_PASID |=
 deposit64(s-&gt;ecap, 35, 5, s-&gt;pasid - 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
<br>
--<br>
2.47.3<br>
<br>
</div>
</body>
</html>

--_000_AM8PR07MB76022449D3A87724252E41FB8675AAM8PR07MB7602eurp_--

