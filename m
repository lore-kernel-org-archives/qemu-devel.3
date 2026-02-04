Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38E9E83EE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8i-0002MF-Fd; Wed, 04 Feb 2026 03:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8g-0002Lv-8A; Wed, 04 Feb 2026 03:21:30 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8e-0003UH-Ep; Wed, 04 Feb 2026 03:21:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPHHTeMp6emW8/wOuzh3zAU25IlW1bVlJ7nV3TU2W1iIk75ArUaLM6W9vwdseZSoSHrSXFYh+/2waqCEjTxIlQPxGwxND+HIknxKuzF8RMUt5UYMjIEPHCUMpJsjMNm1z/O8Q4vJuUCW4KeMlx5S72/gWxBT9+BR5NTDTgpeaID6QtnVDPHXo4PJW7K9Qdx2BKoGp6Xpnai89s12ivfqpGoTHm5Sz699jTGfBqGlBMdhs+jLQzGgmyE+ACxND/Rey6QDUUlFYdr0J+m8b8OEdNG55/5g3uc51uBXwqCvhSL9aOz7khmwbDE74e8fQWRIEVniq97xKWw5sVTI4y0G8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/yled3osf1g1u7EOJlXD+CcvvreU98+LMnkwwiU8Ng=;
 b=BE9HAU2pLZEfXgltHZ1qZyx0FKFUbAyymnAs/4bIwKoWmhkeJ8tPvgEJigqsgrMNjE7HHhkp0/IIvZvzgSFYz9u+chxk1g39BbKc/FyPZRtR+QlZ5g1kX9dCBpUyui+5ZEIfwV3DDFZSNU0JkifUf/Mi+aeBNAfHgF5py7gN8pMAoz9mvGbN+utEyNq+7pnN6SCvlL2Rtb0UKVbW/SxKRk0DZOir8C63jwu5/LEWqA1ljJ8IMf7GhKOWUIWT3o7tyxiHAX6yFxxHN4B8sngMwGbX7D4OhAKlV0a8QKRJCLbA2aXgrjdxzeR5h+L0yFjg+9nHj6rfqvDrNH+hz9LWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/yled3osf1g1u7EOJlXD+CcvvreU98+LMnkwwiU8Ng=;
 b=HUCa9Zo8dPDFbp946NzasrdQ/h0m+UVmgzq4XeVPnZ2HDRdN+dea+wkkMjllTrCwpl2eFrR1Tr2Oo5SBmwVbvZxUiM59hjrlm3WBung1/4GGdQti8EVy+/taGatUMN7VEHQUsmk6/ZBE4gcD+j8Z9jr9c1cutDMEafBluAy373dX6bnmFTGUgUw3/VSztm2RE1CJydhCZtPQZZwg6j0ySACsJSZTpriYkwPztZY9BJHPxSWrDDPgUK2qc7HIcWIY41sc3QF6LTAY6Udl/HN+EYleEHh5IzJ0xzyHsUaVd9B5U/4huE8DMkiE3ET7151uVnEkrA4bAZ5erAxcXG/r+Q==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:20 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:20 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v7 04/22] hw/arm/aspeed: Add AST1700 LTPI expander device model
Thread-Topic: [PATCH v7 04/22] hw/arm/aspeed: Add AST1700 LTPI expander device
 model
Thread-Index: AQHcla89210q/rzYZkavz1guJitqiQ==
Date: Wed, 4 Feb 2026 08:21:19 +0000
Message-ID: <20260204082113.3955407-5-kane_chen@aspeedtech.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: 5da89138-ed15-4892-e939-08de63c6602e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3O9IvMpfwK0Xmlk5BVuFV4/1bCDzD4340oE2bFfomb0W1q6gmT0ZkbK+CG?=
 =?iso-8859-1?Q?4PvnyUHGQWTFW8shCX9I7kZL9pKseJlXBJcDdnLAp18392KVfrraCK9pKW?=
 =?iso-8859-1?Q?Xssk8oviyxFRJueQcUFImdiCin1Iy9CxuJTcZoqkwpkLBFR/3KnqE1cBXM?=
 =?iso-8859-1?Q?Na5CWfa6MgN9tyWQ+4KhJJ4V94CbV91K5aO2mmH3o1SeEGf08msrKiAfEJ?=
 =?iso-8859-1?Q?UwbgA5l0Udh/4ZXPGOmJo9eOD5GmLiOL2W+QsD56r4dukJlBwnxKc4d0mP?=
 =?iso-8859-1?Q?5+ysv4i/L7aHj3Juo60l/wulhUL00nyR2NnCWXxhwk8KLiIbyiCN80VVP/?=
 =?iso-8859-1?Q?u5necW9eM8u3rcHglWlwD4yR1dmD44jfEIbvq/oYOBmo7hysacp3lijwML?=
 =?iso-8859-1?Q?NRHirFOIpMjQgSTgC99juXBZ4IW0YagJPwdZSHFkcPXzx4qEkRfGpH4Vgv?=
 =?iso-8859-1?Q?Z0a0BfTT1be79T/MrB+ABRfE1U6T81M/DEmx2ubQCfuujli/8liqcKvQIu?=
 =?iso-8859-1?Q?G+3nElEEdDNAzj9MczSKjhgC0ddwYreSsKhOo90+35npTXvJg+58m6oITk?=
 =?iso-8859-1?Q?V6XOw4JK/oQZG+KdFVB0DHBvjGG5+X+IWNZgJ2dqhJvgR67kP7A+5Jiq0T?=
 =?iso-8859-1?Q?//Dadf6fw1e8jeurXHeQCXS1U7QQ1Cm9bsHhswMjNkBfAtqvl+J8J0cj3C?=
 =?iso-8859-1?Q?od0Y01CrOk3ixjo+iPgLa6Sk3bvFHsjCWV/UbgHhdWLBpbV5oC55woWrgv?=
 =?iso-8859-1?Q?P+Nhqh07qXnSlKTaaTXpL1tieIfBkwE1p8pdxkPVDhWn5CutyxWdBFjYsb?=
 =?iso-8859-1?Q?Z8thc9lEuOAhXiu0wfgfH2tB7rP+QqVmxj8JRCdVPptxV3xfPdCQrLIVLH?=
 =?iso-8859-1?Q?zAJW2CEQDnKHERxHsc+Srh3SC6bnk9hGw0DE1TrOLmlbY7Dc23dbswH4aq?=
 =?iso-8859-1?Q?Lyl5qh6LkjK/eG560nDrBazHkM8Vj02pRajie71EP4TAfrdn/pSf9pcDbx?=
 =?iso-8859-1?Q?5ogDKbEah5py2n+fWkNFrlsrZt0VNpi+XCWcZu5/tkm18Gzqh+zjHGtAU4?=
 =?iso-8859-1?Q?tbmr6fmM36Ch26oAQcfMXcjNb7pu1l2tDfS52VjBtT2z/60vEKAQNOa21y?=
 =?iso-8859-1?Q?CevcREyyyL2tJkCp9CgpJV22vQhFE2HfmteW5PPjOw60lRJPK/lk6g1kNq?=
 =?iso-8859-1?Q?egYtq56mQAaOZZfGLCq5mTcQ0nLTuOT0v0caQ1PHG/7N3f74wlDGT69/hR?=
 =?iso-8859-1?Q?peGIMJQjklT04XgFB1DSFsa9a4FivbLBBvqqBZHa48m3dOJvxgC4HU3R1v?=
 =?iso-8859-1?Q?2sfSvwacWbWovO4gAoFEgbe4y1mYM/g9Fd6UZRXKQpom63nsjWibjkHfIh?=
 =?iso-8859-1?Q?yYbHvdTmxh9/5gBOKUvLiUQAFKqXuI28//+frjviQpEASZk+vUqFi9eJHh?=
 =?iso-8859-1?Q?goxmaUzI5RrjTOm99s8IyfO08NuK6zCAWLXuyZ46i+ESh3jscgym/mt7yU?=
 =?iso-8859-1?Q?jZAWZVGbZDJnvH3uq34xUEnC1Iv6Rha1AU+GuzBaEVPE81hG2aGLjUfGIf?=
 =?iso-8859-1?Q?2WU3meMfYQh+XEmdzZenHNHTRBvVrgQMt38odkRVk6W+mi8DfhKMlGa0jh?=
 =?iso-8859-1?Q?i3TpgKE0vYS6iBt/V7ogoK25KF42wcH/RFImaL00fHh8gvhjVaRW4Jze4x?=
 =?iso-8859-1?Q?jhWDfLiJypFxo73EKbg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JoKNkmnmFT6kwuLQb9w625uvSfhpLK5hAWFzA2N+IXPimn3R44EibffgRk?=
 =?iso-8859-1?Q?1lxprLg8kL5Op79VEZ989u5HWYoWN2G3PFMxz+8/S1eA7zzv3edSwWZemG?=
 =?iso-8859-1?Q?SSj/UPkRs+cSu63A7tUdeBZtuebBU/6kka9thhPDrQsbmyHEHrdMtb15vw?=
 =?iso-8859-1?Q?uR4O3FFCQTguW1a38nOl52qJdWTejaUlxNRWt/JBApjllzVV/zbhwhIDk5?=
 =?iso-8859-1?Q?9hjeAeUgOA5DUhYcLCaafHAsTdhMXPcF7uhxQtLvq21hCrw1RHotao5Fkc?=
 =?iso-8859-1?Q?54TE7rjb3979TWqRr94odZ7UNMF5G4oHy+CTmJVhTKfI4ZpDYHgB60/UqF?=
 =?iso-8859-1?Q?U+z4KSGc/6CvefXbxNFLZg7zD03sL1gssaPS8FjoIfx5Z11dAjtWedG7KB?=
 =?iso-8859-1?Q?zsZyiYFeOToXJtLS/hOYMBMmOlAtZbhfXhflWLq/GXqCaKsxv6Nf7/wLqw?=
 =?iso-8859-1?Q?WsYlfut4CeLi5kLJYEHg8PpFiqQY1XNb7HwU+hZI5Vg/UsK/g5kL0n1KkJ?=
 =?iso-8859-1?Q?QE2gUgCKAjb8tDdw83gyBvXJ3JCUz+emOeP3arOMHkXWkms5u6N28V/jwX?=
 =?iso-8859-1?Q?ylKKJYT7VXj85AkSreIfLlTB/KkIbmpza2yShW1fVD8dNoSxUIIrO+ClZ8?=
 =?iso-8859-1?Q?VQiLBezrljIKR01PEpIoZwv+9ploMmDd0XeYaCkm9ZMGJFKv4/Z4SJf25k?=
 =?iso-8859-1?Q?tqeitOTYdpvoEQGNuZZAQOAVnFdh4Ucse6oJXTHlvQirw0zPwMen1M+Q4M?=
 =?iso-8859-1?Q?FCsXWhFlVWGCVldSfjejXB21RDUW+P023A2RDVSCilA0SQsWZjnX999mMU?=
 =?iso-8859-1?Q?buES+dShkMFIFFouIfGx023TPQjnvXtMBBTpOgI69CB141PWNWmb7i0pu4?=
 =?iso-8859-1?Q?M17ltfDzrP4S3+lMU0j9SCfhDgH14e/SxlDrpOLQMS4RWy8y34gwVzmZwg?=
 =?iso-8859-1?Q?wzINdcWGDsjqaZKLlVrnoCd/hEXpNHOJnfL5mcQ/CCujsHnlHEO/lyXtzp?=
 =?iso-8859-1?Q?8mWDApYN+Hsx8L3ullmAA+B4T8CZtmBg4LLHybr1Gn7Jdo0nklhcUnCbvT?=
 =?iso-8859-1?Q?XAQpNtowE2Oh4Gni+2CEGn50xkmmrNizS9fHfu4v2Ty+bPOXgNAgdxTUBi?=
 =?iso-8859-1?Q?V8/FgqL7eXs6pUCXEmHypWGBiEa/SfTbDv74xcj8F1tRcfl9A/PiTBB+X8?=
 =?iso-8859-1?Q?9rgvzzAaPH7kDkk6c9JBlZSBPQ3VCTaBhj2VEsF1hzOq5tGibn60EUd789?=
 =?iso-8859-1?Q?f9utDqJKqBVeFX2HiAiLJTgNFwsrFgtHm4DOsHGU2FkPR8VakDdxXmB3zt?=
 =?iso-8859-1?Q?YwC69gnM8ushbuBSnOKSuyEptv/R5bsTWcH1JI0fic68u+fMx1OYjkQeyT?=
 =?iso-8859-1?Q?4RFkyquS313BJ3Yd/R+rcwaVMqWi1j30zAKVU0EkYV9tNKrMcB4NQeBb8F?=
 =?iso-8859-1?Q?5rNqa3xm0y6okcjnepNydXjL0WU05yg8DUWpVZvk0vEK+Y+prV/8rj1Y66?=
 =?iso-8859-1?Q?LSXZMMTJGwxC/LH5fARy7BG1SQ1veksyj595MkxOJ1euGicDx8c84ORKcl?=
 =?iso-8859-1?Q?PWSmFwHG+wtdryaEZ4pRvBZsNGNVV1ZB+zPifu8aMayTsd7E+nnuYNVnJG?=
 =?iso-8859-1?Q?BeaPFmWOU8VhQuXNI2GA33rAvDMewLrXo7HZda/HDhRrxEaLoaVmPk9X+A?=
 =?iso-8859-1?Q?bDrMJ4FDgnx5xeM8g5+e5OS7A1rWP1MSZkcQ1zorgaqYlpB3snE8kADpyr?=
 =?iso-8859-1?Q?1TMdCp7TlFzpM+dBn5NuXcDMPP49Mp7REMy/F9f/4PPgUw1lZxvk+m/ynB?=
 =?iso-8859-1?Q?6k4IOQEu3w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da89138-ed15-4892-e939-08de63c6602e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:20.0952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CrklIw77b77ZMWp0RUFU8E59UzpT5QCWauWfY+veqbsV5althg/mSkydRNFjYmpetovuEznj+q0SRUoVwgKxJaholwWNf1vG9HSsye1Fvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce a minimal QEMU device model for the ASPEED AST1700, an=0A=
MCU-less I/O expander used in the LTPI topology defined by the=0A=
DC-SCM 2.0 specification (see figure 2):=0A=
https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf=0A=
=0A=
This initial implementation includes:=0A=
=0A=
* Definition of aspeed.ast1700 as a SysBusDevice=0A=
=0A=
* Setup of a basic memory region to reserve I/O space for future=0A=
  peripheral modeling=0A=
=0A=
This stub establishes the foundation for LTPI-related device emulation,=0A=
without implementing any functional peripherals at this stage.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h | 23 +++++++++++++++++=0A=
 hw/arm/aspeed_ast1700.c         | 46 +++++++++++++++++++++++++++++++++=0A=
 hw/arm/meson.build              |  1 +=0A=
 3 files changed, 70 insertions(+)=0A=
 create mode 100644 include/hw/arm/aspeed_ast1700.h=0A=
 create mode 100644 hw/arm/aspeed_ast1700.c=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
new file mode 100644=0A=
index 0000000000..378dcb437a=0A=
--- /dev/null=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -0,0 +1,23 @@=0A=
+/*=0A=
+ * ASPEED AST1700 IO Expander=0A=
+ *=0A=
+ * Copyright (C) 2025 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+#ifndef ASPEED_AST1700_H=0A=
+#define ASPEED_AST1700_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+=0A=
+#define TYPE_ASPEED_AST1700 "aspeed.ast1700"=0A=
+=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedAST1700SoCState, ASPEED_AST1700)=0A=
+=0A=
+struct AspeedAST1700SoCState {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    MemoryRegion iomem;=0A=
+};=0A=
+=0A=
+#endif /* ASPEED_AST1700_H */=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
new file mode 100644=0A=
index 0000000000..dd38b819b8=0A=
--- /dev/null=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -0,0 +1,46 @@=0A=
+/*=0A=
+ * ASPEED AST1700 IO Expander=0A=
+ *=0A=
+ * Copyright (C) 2025 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "hw/core/boards.h"=0A=
+#include "qom/object.h"=0A=
+#include "hw/arm/aspeed_ast1700.h"=0A=
+=0A=
+#define AST2700_SOC_LTPI_SIZE        0x01000000=0A=
+=0A=
+static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    AspeedAST1700SoCState *s =3D ASPEED_AST1700(dev);=0A=
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
+=0A=
+    /* Occupy memory space for all controllers in AST1700 */=0A=
+    memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,=0A=
+                       AST2700_SOC_LTPI_SIZE);=0A=
+    sysbus_init_mmio(sbd, &s->iomem);=0A=
+}=0A=
+=0A=
+static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data=
)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+=0A=
+    dc->realize =3D aspeed_ast1700_realize;=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_ast1700_info =3D {=0A=
+    .name          =3D TYPE_ASPEED_AST1700,=0A=
+    .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+    .instance_size =3D sizeof(AspeedAST1700SoCState),=0A=
+    .class_init    =3D aspeed_ast1700_class_init,=0A=
+};=0A=
+=0A=
+static void aspeed_ast1700_register_types(void)=0A=
+{=0A=
+    type_register_static(&aspeed_ast1700_info);=0A=
+}=0A=
+=0A=
+type_init(aspeed_ast1700_register_types);=0A=
diff --git a/hw/arm/meson.build b/hw/arm/meson.build=0A=
index c250487e64..47cdc51d13 100644=0A=
--- a/hw/arm/meson.build=0A=
+++ b/hw/arm/meson.build=0A=
@@ -70,6 +70,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
   'aspeed_ast10x0_evb.c',=0A=
   'fby35.c'))=0A=
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: =
files(=0A=
+  'aspeed_ast1700.c',=0A=
   'aspeed_ast27x0.c',=0A=
   'aspeed_ast27x0_evb.c',=0A=
   'aspeed_ast27x0-fc.c',=0A=
-- =0A=
2.43.0=0A=

