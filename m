Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3929CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3mp-0007XB-Gq; Wed, 29 Oct 2025 06:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3ml-0007Vp-SD
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:52:11 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mc-000215-Nz
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1761735122; x=1793271122;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ch8joq7t4eK4w9xApOPLPuuw25nLBYLhfWDmmNgwRlQ=;
 b=FpRrQWRgZbeBxdQl49PMNluTKwMyPYk6Np9zkkDj1xWxomQ8Y5wOcbvU
 GMkEbqQHbm3DWetZpv1373HvwUEDpUIH+YenZXzcT9bQRMhTCXviOt7oV
 17u+ajXyML7FjR4OEOEBhXZy1G5++7k9ODdyZ3fIWWpglML9TRpBqWgxy
 XiwntcPrBEJsR2IbyRebc7PkaOE2WW7Fc3Vq9fCrjwHyzCaZDEPlTcACF
 p8m9dfm7WY95thXPVMeEJlXAo1ao82qfYUi06+Xd7m3yRl25PHImTNB9F
 g+n4AbBmBiboxeVIkDBNYFo6Mr+kBMmLrLmGYXZqNLfFxrv3+dUpi1XEF A==;
X-CSE-ConnectionGUID: GXf2lUF3TZO5Yu/EgUoU/g==
X-CSE-MsgGUID: 5rW/Tg9WQVyK+f8kzXlTZA==
X-IronPort-AV: E=Sophos;i="6.19,263,1754949600"; d="scan'208";a="44178954"
X-MGA-submission: =?us-ascii?q?MDEY40dJcH+TRWV8V4jL1V0CtiwlECHnrNAh+Z?=
 =?us-ascii?q?+K7NZLEI3mxhLTa8pj8SNlLNQPnfnqd/yzuCfaJcasksHtRRX2MXeWnD?=
 =?us-ascii?q?UmfxSoM+Xq5dZ3dV/BluZ36kookY5Lq6ZS+wwk/Hi3THCK8RPib36LrY?=
 =?us-ascii?q?v1VjmO2NBW9To2zM7xNbKmMw=3D=3D?=
Received: from mail-northeuropeazon11010065.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.65])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 29 Oct 2025 11:51:48 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elA9Aq6xWPBIOF1MR3hci1qPrPMY1AqNsZIaQyAMu9sdQ8TNHVRUITwd/2udtxawIpW3rJkdCxuTtuOHj3lyAFVjsz81EMMJpG0Pe086Af5g5nZcp1I/Ng4FQfkn2ERbTUr3WGRMf3stkPv5TTXZ+LZtIhBjLr0MwbCcMG918ggV8c2tAdh8hHFO2VCIGSvjtcz0raf1xFXbcwPli+028oFa6ba7q8R9yPvtp6puoHjlSxp9vv/91P1Cq1I0g44iTsSLVf3iAcYKeOcHWkusFfOKff/jjR+3naRRASJj9zJHeLfCF7GgijjXboSHUMhTFPgG2LbTFKypy2Kk2bYfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLzUkpKSDdFtSmvJ6+dFN2t+Ggy80s/JGr5OX9Abtxc=;
 b=nAo5EQIufknNyCN5qaYBh7Roz5D6ly9btLp4hPOZ+DVwvceauMP3bfKkeTM2gBtHtnWwyyM593ErExztA7NhRdn0DwKTrf3hR3cI1rohntV1GofwBqwyEOm2TiRX82L771pL3cDupC7kKH2WwvVmkD8SmvBWSq05gDYoJDJwb/tsONID7vZGWMPLhEjCJ6vTQ2h1z5vHV8ZaV7D8qSlAKCNLYgwXYeiKKYiO05Xe07GNtm4ozEfrZrlpOVOIVKQb0mMRF1mk6W9sIATp8adulh8yPVmE8n0VhQO6ngsY0usW1kJ11tp7uuy8SAmxZ1V9r9LxlxigYZE2x7yTuKUV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLzUkpKSDdFtSmvJ6+dFN2t+Ggy80s/JGr5OX9Abtxc=;
 b=oHh0rjI6kkE/ogoSNJk2rL+MOY0FitNIKKq54Cbs3zf3mVvlsAQ+qlTJsEJwvqkg0Qfw1zxoDe7AGQpX88G2UcZk8tgnnZiqkItJxEB8U/05zNZOPAz+veX2goR+79DXpzdYfk38Itrray9VDjpo4kS57xmct4kqo/kWkJUrU5jc3iTsKrT3T/kX/h87BRsC9sdXxYGqrRxsPm4SQkTNCTFRjaJoFmi3U6DgtnW/L+5iROosWc1H8T3bH2s1toUA+JW4vQJzrlAo93ZEyiP49YVfzL/P82LNu4OlMTcGOQJthnz3rKqIx/eaTcSrC1IBbaEh2XQarf/shIOjkA2nVQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI0PR07MB10962.eurprd07.prod.outlook.com (2603:10a6:800:2d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:51:46 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9228.010; Wed, 29 Oct 2025
 10:51:46 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 6/7] intel_iommu: Minimal handling of privileged ATS request
Thread-Topic: [PATCH 6/7] intel_iommu: Minimal handling of privileged ATS
 request
Thread-Index: AQHcSMIFoPQGfzZEWUiOQtq8Y9QQuw==
Date: Wed, 29 Oct 2025 10:51:45 +0000
Message-ID: <20251029105137.1097933-7-clement.mathieu--drif@eviden.com>
References: <20251029105137.1097933-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20251029105137.1097933-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI0PR07MB10962:EE_
x-ms-office365-filtering-correlation-id: ff5de850-4eb6-4351-f31e-08de16d92787
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fIO2vPBFJsjPR9Tg+pLKAHPRxeDjQGhkH1VvuBHtJjmKnIOVw+Eanu4g6F?=
 =?iso-8859-1?Q?439xgj2D7mK0JHf3iw7qj77AwvfcbXgNhcmlbAo1yYvsYxOSWbi8tv3vh1?=
 =?iso-8859-1?Q?dgfC4jWt8mBzCdnIxYxBmP+hoXGDX4gWthtSyB8gadkRTtTJhXtPa+K2AS?=
 =?iso-8859-1?Q?xfcm2rr5Mjw+5MjGvLUJYtyowY/8Y4332sGm2dFUMr8tvohknNQkONbXg4?=
 =?iso-8859-1?Q?dWBb44JJqprDUb+l403x3ba+ZP7XO+0un2oFBABzNMk+izKG99NjD7EU+3?=
 =?iso-8859-1?Q?vjGYHLFB80gGZXqnne5mEY9yCbxaVjgHQIyhIDVvhQ/185tBpseZ+c86Lk?=
 =?iso-8859-1?Q?SDTA9BoDsKQsA/JPRXJEDDrBn9UTV4JVLLOF8Xf+40n/KidB5VE3YN3kv3?=
 =?iso-8859-1?Q?WnbM9UvLjTiX3OXsr0ynTbc8gfMYxr80DCGvOJ+WclODHB0nyuZvcfstOP?=
 =?iso-8859-1?Q?fP3eSfxrAo8XZRlPaCxYvjAdxISJnUpnrK9q/vagqBSFAjxJQFFUiBsfhf?=
 =?iso-8859-1?Q?Bia0Hv+g5hzLSmN2eoh4ZiNI3BOQ5Jzx5w3zeRwmrQKjlZfMK2PTmXGSKZ?=
 =?iso-8859-1?Q?hKofw4iZ7ieAZHKiKtIEObuwu+MLKA/Uj71tOHD/bY9VminUDiutPt0EZe?=
 =?iso-8859-1?Q?yN+FJMZtyWS6Q1ksoUBH+r24jGjYfLIcNRMbfjYEMQf69/LsI5PoeMcvB0?=
 =?iso-8859-1?Q?Gr05IqJdlOj90b5f2PnMVGcc+DyPh3yJgfIBhXoaIXeYaqttswGne53R/r?=
 =?iso-8859-1?Q?SWg/lvYPNs2JhcWH61Rc2G7/3i9B2z3VPLA9oY29tbPUx87vh0U+FJyqLE?=
 =?iso-8859-1?Q?WGTjZA4PZLb/ECAUEdUYrvGmBvSiAyU9When15jpB16QQyIA9QurarVbTS?=
 =?iso-8859-1?Q?a6gCJq9/KGcdpUYpcetpIVmztdBIoFqMdNpud5/47zHSlxVwtMg2vJUyOM?=
 =?iso-8859-1?Q?44eG7aOlMp1o7FtozW1P+UPlXfk2/CEX90JfZiWR3ktyprhPAv5d0rGyHb?=
 =?iso-8859-1?Q?GnUOsiuACtF1ytBcCyWpUBP/XLry0SidB1+2ppaEir7m6vtzKnAN2MN2Y3?=
 =?iso-8859-1?Q?dc+RjCiv8nDU2I7wJmidcbcrNqhSiCdaeE1smCBmppqZwH2Jj5OPV+yD7r?=
 =?iso-8859-1?Q?nBwBeCAjgGLD4bHPDv3kef43J3E4S/pmvmATufWjwbYHPXKTEs+GQmHd0X?=
 =?iso-8859-1?Q?pWdlXRx7MZ/a/fwteG0ENhpCS5/j5lNNHY2BMFMTXgHiMgYjxtsL+Em8zC?=
 =?iso-8859-1?Q?AxYOHT1SkcxCzl5w+WH/UXmK95qZMXR1I+1DcvyS4EU6JL9sit+Ao16Lqg?=
 =?iso-8859-1?Q?+5FFDekyZHtzDkYCWxR1X0KLzE01hW64vKD3IguQ75RMaYy3L1QGUQPTrw?=
 =?iso-8859-1?Q?VjlHWb2q9Q+5yT/Y/1BcGtaRcPU9yK15cPsbUXuBnCoQW+1kT0Bo8uBrF8?=
 =?iso-8859-1?Q?r4mgjS3EZHavjALAPh+KSxerVIos1viIYah/DDVxJmx/G+PZx7nh2AlMpZ?=
 =?iso-8859-1?Q?6At1sVYtfXfNzd8LCb0V9sTVp0jW/yh37oK3Mmn1a+SuTIzKGFndjJJDTc?=
 =?iso-8859-1?Q?Qw1cIdClMxZ2+TFFwP3Uj6MrmTZ9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zsg4w+z5qAoMLYRcOxh1m8uhtmxUhOXRyUuRdzTOucPgEFoD1gRywGsamU?=
 =?iso-8859-1?Q?5sBhR2FNebaRfP4F8UuAWYowBJkkJRYkng+cp3A0XexDUcSV3ylU9V5I6Q?=
 =?iso-8859-1?Q?G2G0PzO4HofDyegJlVXgX2u46u2deRkKcrluLkBxYlcOZ2V+eHWchEmCtM?=
 =?iso-8859-1?Q?ivG5Bg1le+PTnfjBHY024HyY/cVrGDWP6QM7Y3O53yl2nX4iabcV7xKshL?=
 =?iso-8859-1?Q?iZGUGE72FdpyxlptepZ+KGUwyAE8jVoKp5WMqNtjraCCj7HojgjsPQNkZv?=
 =?iso-8859-1?Q?Ekmt+ZqzPHmBPSXJTW3/JmKF+9oWiqgfRwzJSyK/Z28S591FswJTi1+4c6?=
 =?iso-8859-1?Q?yJQA1beXYeCkySZfFjfC50MBnw8awoyMza1tJVnsd+A+DcOCuZZd1a15qv?=
 =?iso-8859-1?Q?awSnDCEc+641Lk/06E5QZNy6je3TCBI3AQjqfUvQtq0yrW32y1A8X9ifiL?=
 =?iso-8859-1?Q?3c1di3uG/o6alq+z972gkBFKpHAb6GAddJtizH5YBAT9aaBefNXR3IvMjj?=
 =?iso-8859-1?Q?cUeLnSBGvf9sMW/RX5uaXsXdDrZKxUPUHGCCO4HZ/G9/yDJxEkQUGe58Z9?=
 =?iso-8859-1?Q?6+SnT5374bWrABoCbuMPlZlo+R9mvD+wnd4yjJfaye//vXXHs5gBaRmwxB?=
 =?iso-8859-1?Q?1z+JsJmB0AtW+F/+etaa+jPVx6+FsPuo6HLNNYVay5x9rMQZ0vYWunDGS9?=
 =?iso-8859-1?Q?jLMI6b73yAPsTeH2I5ujSKhsnnd/S7LyzteNIupNZBgo8KQGNYivXSxK/e?=
 =?iso-8859-1?Q?1NX+VUabCiAyx7s/8DHjSg6Q6KiCf8ATvfnH7pFFqAwmPc9vCbHg9+tMWx?=
 =?iso-8859-1?Q?fgnLIu7zNsOFHRg8SA4tDMCAnV8ZGMX1AexbfpxFvb7jcAyZNR70llE6rc?=
 =?iso-8859-1?Q?9qDimnYbihkV9YdgE/dJNiKIqMxEwg3kI1KHega3Y8T3DU/SZSQj+HaoFU?=
 =?iso-8859-1?Q?cXp3xhUh/UgfK5E0+Cs4RwHLqQpxutTtuDie/qAD+osx6jUWysTL4FE8YL?=
 =?iso-8859-1?Q?pmKBbqASPGL1wBHd62VnDRyGzvES36RVXGfC/qiWqSPREmAnVAd94utdBZ?=
 =?iso-8859-1?Q?C3aNNzbb/BBsCo/66Ug9jKXDZ27JVAWT8dZPAPruFOfxg+4+pPohFXEBoE?=
 =?iso-8859-1?Q?kS5PM6yPM+v7/t/yfxEqEOPdhp8m9kQVXdyB6fUhbD6qFIxIvecPWTdMr5?=
 =?iso-8859-1?Q?hptPNbJWi8drO2JTkCowP+dwE0ADnhQGURXKvl6LEKzQX9U8+sDbo+s2tO?=
 =?iso-8859-1?Q?zhzSK41hLcoSeWz6O+aZJnS8rv+B2XugGQJBSnP9G+IyO2gigPRhxjnpS2?=
 =?iso-8859-1?Q?h2SvUe1pDBEegYMUXP6ObWEmKFkNEoowjZP4n96b2K2ifQB5Ll1rmlGNpz?=
 =?iso-8859-1?Q?Q+q5R2wA/p7YK3HQrqqAWpAPWDnW7BrY7GvF0Ex6GPt4DGaBaFZI5dLnK0?=
 =?iso-8859-1?Q?TUZ5Ocj9fhJqSZ855uTQ0PsvFOdk8aJl62E9myV8EZvjoNp1xVYRecrP+m?=
 =?iso-8859-1?Q?EdUI2sKSgRM5242v0pn+u/VB9AJqOufj5fcluwcR5nygZMut8RMSoGdqHU?=
 =?iso-8859-1?Q?Qhd5oz44Xv9CU1aMZVz1n5ZbeTfBqU5oCjdhM8mr6r9z4JA3Qcc+aoXXSy?=
 =?iso-8859-1?Q?8zmq8uMAPssJfMyOlZTgYVw8W4ob8Gi1ldynwiBMtGndXW1rx4L3auIM3a?=
 =?iso-8859-1?Q?3/X7/7KEZJgvaKShaVU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5de850-4eb6-4351-f31e-08de16d92787
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 10:51:45.9569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRnrUOcLnz6D531vNpTA3bD+SOHFnAjiB8pevvxWODecTN2Oe/mqvecJ0FRg8V8Q5EltupIwtjOZ2kpK82lMopJuYSelNOpOEGeHSlVWNi/OybhEAoU8DLSW8eO6OHtM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10962
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

The purpose of this commit is not to support privileged requests but
to prevent devices from doing things they wouldn't be able to do
with real hardware.

We simply block privileged requests when the SRS ecap is not set
and abort when the ecap is present.

For now, its not worth implementing support for privileged requests
because the kernel does not support it.
(https://lore.kernel.org/linux-iommu/20230411064815.31456-11-baolu.lu@linux=
.intel.com/)
However, we may consider working on it depending on how the development
goes in the kernel.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e89f31da02..38a9c87da5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4917,13 +4917,27 @@ static IOMMUTLBEntry vtd_iommu_ats_do_translate(IOM=
MUMemoryRegion *iommu,
                                                 hwaddr addr,
                                                 IOMMUAccessFlags flags)
 {
-    IOMMUTLBEntry entry;
+    IOMMUTLBEntry entry =3D { .target_as =3D &address_space_memory };
     VTDAddressSpace *vtd_as =3D container_of(iommu, VTDAddressSpace, iommu=
);
+    IntelIOMMUState *s =3D vtd_as->iommu_state;
+
+    /* Guard that makes sure we avoid weird behaviors */
+    if ((flags & IOMMU_PRIV) && (s->ecap & VTD_ECAP_SRS)) {
+        error_report_once("Privileged ATS not supported");
+        abort();
+    }
=20
     if (vtd_is_interrupt_addr(addr)) {
+        vtd_prepare_error_entry(&entry);
         vtd_report_ir_illegal_access(vtd_as, addr, flags & IOMMU_WO);
+    } else if ((flags & IOMMU_PRIV) && !(s->ecap & VTD_ECAP_SRS)) {
+        /*
+         * For translation-request-with-PASID with PR=3D1, remapping hardw=
are
+         * not supporting supervisor requests (SRS=3D0 in the Extended
+         * Capability Register) forces R=3DW=3DE=3D0 in addition to settin=
g PRIV=3D1.
+         */
         vtd_prepare_error_entry(&entry);
-        entry.target_as =3D &address_space_memory;
+        entry.perm =3D IOMMU_PRIV;
     } else {
         entry =3D vtd_iommu_translate(iommu, addr, flags, VTD_IDX_ATS);
     }
--=20
2.51.0

