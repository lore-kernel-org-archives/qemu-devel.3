Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD3FCD3424
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 08:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKXTK-0003A3-Th; Wed, 06 May 2026 04:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKXTJ-00039N-8k; Wed, 06 May 2026 04:19:09 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKXTH-0006jg-E5; Wed, 06 May 2026 04:19:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5b2hv5GIaRAjSp2gpCh3VxtYMzLQuKK1C5+Opl1Qv7nS8bC4lAZGPr4tkl/Pd2xV8CKquSxOlc5aiRJhlUhpvvJgs4ncFXWzmhn6DkcCdzG2w/UjcGFQ9kL3+ykmyx8iYb76+gAkDOliAXIyqrDAygBOXg0h0rZZGUxefVyxzMkEfz01NlfaBfhvME6kAEQ6TW1FvkjtCuYKkjYfuvGh/yBIfzP03LdUCUyDeo8tt5aH+1ov525N+3qCrW1gev3mTnQWLMn4XaDTfjn/5WamGynSJTXA8Jg/mtBGU1/fz08av0tZ/Z/KEQeGTUiSEOQ5gAmsaxJcCDRdpgHmDOPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cofAuoy/gfo/lSc3sX9lVeSjgRDmP6OoArwlrDeggXM=;
 b=dXt49SoYJ9XwbXyUee2gisH3/k1HTRWlnyGVexCHXTGB+UbeqfEfe6R6B7m/9K5FkxkAEvFLirSgz8HjTI73JLiFVPFn6FcZL1WyS8/CI6d/nU/4kwb6EyH15CqnYOX3HfcQtf5MglEeYSVKic0M3nNlHAROcKKuz7v7CNA/g9R4i2v1WCuZWl+q13nejKctfVkP+Zp5LVsgvKPJ6rjz+6uAo+aely8YLYTKAEPR7/7buQeDrjP3m6gyR1WvMpXXHFh8ovDtFW7+lVsVAXr1jkMiH+t/5LiZ7tQJeNV98v5WYk/7skZ9wyQF5fz9vOTo5mLEZfZ5gHkK4sjl7rDlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cofAuoy/gfo/lSc3sX9lVeSjgRDmP6OoArwlrDeggXM=;
 b=R2YbxF9jRur7SErUlhqEd7MkZBbUm/dKrAhRbFieK3oxaJma5w4/DKhAOAlbO42leedq868o8CDsK/NNdDN7n43boW16T1ETREcTHpIPl4Q8yTSt1uK7HxYaPDGyZ+joZDfUiNrOVxLfijLdKF44QRGh7zlLxfEVcF9TH7mXFLlY8N0Zc8WJ3RZ5+U7TlI47aT8puH08Pt3PCt0BBMEzdYdYdafVWT1D01r1UD4TOHFuTJX1T9Ec3hMwqadNGb9pXsMC6vNaTn4X3qmKdr0jZULpWtoWihmIXkqCUW9bRtZe36PfHPDbdcoNtvsTgfNWpjMtcjY9+B1r0oIAWJtVsA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 08:19:00 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 08:18:58 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v4 19/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Thread-Topic: [PATCH v4 19/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Thread-Index: AQHczMa8RoKQGbMZKEKacCtQsK9v9LX+tf+AgACPEhCAAK6+AIAAyQmg
Date: Wed, 6 May 2026 08:18:58 +0000
Message-ID: <CH3PR12MB75489F58CFA97FBBFCA9776BAB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-20-skolothumtho@nvidia.com>
 <afk8f6BNAN2J/9f2@nvidia.com>
 <CH3PR12MB7548E9681835CC2A31ACED1BAB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <afpHGPsdG5F3xLlX@nvidia.com>
In-Reply-To: <afpHGPsdG5F3xLlX@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB9115:EE_
x-ms-office365-filtering-correlation-id: 0c8ca3ab-e944-46d1-f50d-08deab481f1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: pAeVQHwX+bB+xZJ6XZZXBhgYeQ68z7WGqWOKDcN0isF4Mm5rF/IN0VKxF7tvdk6EncDQJ9Oa47bKaqF49XrvJ12EBXE0HTTDnsTv21HPlBcRyHz5F9x3g7FBesGGmbV7E+lxn6E9tSLOk9EyFhqNf57YMIvjcI8U3Zx1CDbMTY7HzgCHyyzcaKAmIUbSDHXoyT2UX/T3tHNJ/P+FJKJ3M0JEmxhpKZLNuiQ1m39KeMPvOzztfVP1SKbAtkATBPMNd3BR3Pq72DATn9TG+Xs+ogVoPZnE2zRJyFXTkDH/1JHF8KqOOsoL4u53PLec3PsH+yW1XffdEmaKxvsd82w5rozgr9POJgXwa1Sx2FBQPb8v/BMVZnNHWCmDfDo/XVEK7ELqGbDaF3sQRIVzwS4b16gdQwzCTp2FRh87NexAT5pyV0F5viUtpVvbcBpZfiZ/I9qpQ0zabb6noxm+QD6fx4KdQWCcTrlMCKfT8TaM59MmGHjsQbXZY8h31bjAUn5uQXzAyoei+QqFmsULA7on5MGF4Ubn7GhfqpeOkBizeLc0A9JGdzFM3VrI4cmvXv6MlDU3Lzf0wSGdhlQ0eic5PFTXKP35fxaOcqR3WlW2F713ywkp/Tlseq7plbbJ0z/ud3MuqrsaKXilTwF567iC/FdWlA3KE6QVUvwZLmoDoHo/rLiMybulQJWHfxccDeAEfwpDpy3yT6wbZqc4cakvsqG7gI0yKaJa2fe1PyV9u9KA5zS204fxcxxwEs+zNrwV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?grUK94YBJXrsBIYa9r5UXUHmM8iB/wHRslj3WOy4Sk35di196sQ2QCAn9wDn?=
 =?us-ascii?Q?BoyHH68PiRAzL2iOwZQJsAJjAjvMPlleM1N3JxtKJM9VsEYvfASSTYXXWA7/?=
 =?us-ascii?Q?URe4y5ZdFTGQfuArQnE3qayPim007ep5xTtfaKY1Zlk5ZYzP8WSOFsCI+QdI?=
 =?us-ascii?Q?/q2icU/PIOsVKe7U8KVD9+RGLaDK2rtcM42KuOA4F69gCfQl9S3urAY/kKcm?=
 =?us-ascii?Q?eiHEvJcA+tgOozvLPCp2lCZoe1Cy3/fAm/tIs6QnuGPneL1nAN2urfZpLT6x?=
 =?us-ascii?Q?RIlPzdP3AsQkribOHEuRhwh4pxOveU2NPeGSUX18IOWwskv8EZGtHbn1DCA4?=
 =?us-ascii?Q?62Yvf32ZpOBEsWwoJYmxiu4TCmM3mfdMl10hE13DaoH/TA1sCeRGj0rvIxgI?=
 =?us-ascii?Q?a1t0j1wD1dt14bUCdH50i/+eYISrxW0bFvOZW6Wzn2erSNT8W0Y9ycmMefjx?=
 =?us-ascii?Q?Z3F9G7m9CVZlBGL7EFNz+Cl6YegctLqjEes5y1BnVQhq41JiobFDy13PEhRi?=
 =?us-ascii?Q?inaNc0LK1mwVdnVQ6QsDIcNhQqFUwFIQrEYjM97iI+ioc0lqSjWopqYmQP/A?=
 =?us-ascii?Q?hCyVVrEVjX1uJVKGM/j/rx7sL2cMKU34xE+DT87xbd33EXpTLJO9N1WNmXrr?=
 =?us-ascii?Q?SfhRAaO7jMugwEWHA4kLMfaxNcgjTmigpmqmpEskdY69pIhIk/kw+fRDso6i?=
 =?us-ascii?Q?a9W8oPK687NUnoGrGsACxjdep09kXjuXBTJn0/kHiMe7bz+lDKLqsBq3SLuD?=
 =?us-ascii?Q?CpT4ub/ez/Sq6/dBnsyn18NnYeX8qRhHQRHAAuHJF6B7soqpXQaJDEiYjOK+?=
 =?us-ascii?Q?Ts3UUh0NCFAr9aKMIUmQg4oJ0YFSpahbG/jnL/KzqPMtQ+xfykZ0Ymm0YG4e?=
 =?us-ascii?Q?2+m84G7+yo/AYNQPw4HP2xhJLL5WBhBB9v3u42MHJMIB1NqzbHSpzvpvHM9k?=
 =?us-ascii?Q?QeoXhsIpB7uV8EtICkaBVtodAst2zNSnk6ZsomzXDR5N2GQAX9KZGUIn8zNc?=
 =?us-ascii?Q?oxF+ehKlFiU1FabJzcL8kUyVTkO7qMx3N+i4c3zevni+ew1m5PQ5XGJip8Fu?=
 =?us-ascii?Q?GaAOFhyrWW5TzLtgBAEFxRftEkuHOWY7qKXb8px/r9dDoOqR/96GgZ//ouet?=
 =?us-ascii?Q?3Tadt5m5FkCQiQSVB3BGWfeYsENalFXh8bbPEmKzfAlIQ6sRG8b7mAbGJSTw?=
 =?us-ascii?Q?fcGyk/xDERoXIXDdlxw9x4FZnFy/UF/OM8k5ZTfczQKH+Z0qNIwn6+BViM7h?=
 =?us-ascii?Q?ZU7OzCm3OH8aCmEUlGu28sxTchhKgGbrBsvUvlMwc6DzTLK2jMGmsTynpGXe?=
 =?us-ascii?Q?z+NOzCQBgZT/lr10EvLFgbFndCo8STeUghUuHlOt3Ezs8PMz4xmbkqKsVvoo?=
 =?us-ascii?Q?0/4xkjotIsPJ4SYz5+obRlV8XM0W+KUuUQhXcjTJvF5gPXg1lycKMqEXKHVs?=
 =?us-ascii?Q?efww8tHSy0+WD2r3e81VmWFaEatE6gPQUCbe6Fh4EyPDmnCxys/g8CuTeJAk?=
 =?us-ascii?Q?6YiHj8i0HespbX/MrgzJZw/7XgD92psgprQdho1oBoA6kYkemhGkGnC1W0on?=
 =?us-ascii?Q?/aYGK6RpJBzcJbqUpcMf3vLyiMNocRjV+WUXc2u6WHZZjeo88bLPGAdTKImM?=
 =?us-ascii?Q?1IyKIJtpTq2pxuIWNI/MnOIuzIhgiexMGkArAjd/oMYf2wu4ysjiRRH32aaK?=
 =?us-ascii?Q?XQnF5ME9MdfRen65VcNOBDo2g0N8lPu8GFtqNazRBpiOFySlFRARKmfyZFZd?=
 =?us-ascii?Q?qbW1WnlJzQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8ca3ab-e944-46d1-f50d-08deab481f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 08:18:58.0698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIXarFb/VL/O6LCb67T04sK7yRBKfKCvnbTw8ElVbfw0Qwh/PUKCMYE9MkRj2A3mvrgehdJxeqGdZSGACb6iHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 05 May 2026 20:38
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>;
> phrdina@redhat.com
> Subject: Re: [PATCH v4 19/31] hw/arm/tegra241-cmdqv: Allocate HW
> VCMDQs on base register programming
>=20
> On Tue, May 05, 2026 at 02:59:55AM -0700, Shameer Kolothum Thodi
> wrote:
> > > Also, do we fence against unassigned vcmdq? Corner case is that a
> > > guest might write base address registers via direct (global) MMIO
> > > space.
> > >
> >
> > Not sure I get that completely.
> >
> > Spec(p. 176) has:
> >
> > "While the software can program the Virtual CMDQ(s) directly using the
> > direct VCMDQ aperture (and not through the Virtual Interface), it is
> > required that the VCMDQ be allocated to a Virtual Interface before it
> > is used to send commands to the SMMU."
> >
> > The spec only restricts sending commands before allocation, not
> > programming BASE. In our model, the BASE write itself triggers
> > alloc_hw_queue so there's nothing to fence there.
>=20
> Our model has an assumption that guest would map a VCMDQ to the
> VINTF0 first before doing any meaningful programming.

Yes. And I think by "map" here, you mean the writing to the _ALLOC_MAP
register. If so, yes, we don't check that.

>=20
> What if a guest programs BASE before it maps a VCMDQ to VINTF0?
> This can end up with allocating hw_queue that will map the VCMDQ
> to physical VINTFx, while the guest hasn't map it yet.

Yes. We probably need to gate setup_vcmdq() with:

if (!(cmdqv->cmdq_alloc_map[index] & R_CMDQ_ALLOC_MAP_0_ALLOC_MASK)) {
      return true;
  }
=20
> > For other's
> > (Page 0: CONS_INDX, PROD_INDX etc.), the vintf_ptr() check already drop=
s
> > them silently if vcmdq[index] is not yet allocated, consistent
> > with spec p.172:
> >
> > "If no Virtual CMDQ is mapped to the Guest, or if the logical CMDQ inde=
x
> > in the Virtual Interface being accessed by the software does not map to
> > any Virtual CMDQ, the access is dropped with no Fault/Interrupt".
>=20
> My reading: "the access" means accessing logical VCMDQ via VTINF's
> MMIO space (0x30000 and 0x40000). Yes, silently dropping it is what
> we want.

Ok.
=20
> My concern here is about the access to the direct/global VCMDQ MMIO
> space (0x10000 and 0x20000).
>=20
> So, if this concern is a real case, should we:
>  1. If the guest maps the VCMDQ to VINTF0 before it writes BASE,
>     call setup() to allocate hw_queue as our model expects.
>  2. If the guest writes BASE before it maps VCMDQ to VINTF0, we
>     need to fence against it.
> ?
>=20
> One more thing to check for case (2): after the guest programmed
> BASE and then maps it to VINTF0, and it never writes BASE again,
> should we call setup() at map?

That is a non-spec compliant behaviour I guess:.

In p.176: "Allocate a VCMDQ to the Virtual Interface", this is
the order:

-Program the CMDQV_CMDQ_ALLOC_MAP_X to map CMDQ X to the
 Logical CMDQ (L) on Virtual Interface (V). Logical CMDQ allocated in the
 Guest must be in order starting from 0.
-CMDQ is allocated to be used by the software. Guest can now program
  the VCMDQ to use it   as described in the "Enabling the Virtual CMDQ"
  section.

"Enabling the Virtual CMDQ" (p.175) is where BASE is programmed. So the
spec explicitly places ALLOC_MAP before BASE.

Should we support a non-spec compliant Guest is another question.
IMHO, supporting non-compliant behaviour adds complexity with
no real benefit.

Thanks,
Shameer

