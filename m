Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E5DCD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV580-0007wp-Eo; Thu, 04 Jun 2026 06:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wV57r-0007vZ-LY; Thu, 04 Jun 2026 06:16:36 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wV57h-0004BR-2v; Thu, 04 Jun 2026 06:16:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXqzKoJtsGJGfQE7cOG8lq3pjw5KdtH0vjJDe59r/q3T1ZT5/l48OOp++WOnxywlXBQqv/ckNkbsWTynUaDEOq8xaSxkaFQmyZB2VQy7Z5hBkDNvOrKvrfd+vbHeEtMJzqYnL8ODUFfk3gEOV8kLHd6gS78vkuGyqNw83JcbisOVYfH5gz57vB3Mmedw8jZ7QzZbw/wHbUSgsek7HYAmy6R6t6N8audY8ZfmPaGp52ovpFwz9ihWGl7VICOzjgBO9EK+HlePuMZtSrcOWiLeEa6ZDVQm6np9kykuA+/uQ4JhJ7rkAGow/pPVB6CPAGGjT56B+2ys12vODtP8Lj1vwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1a5BRy78jUsy/wl2Q6FdbBn+e8WWOX8AFYVVQh7HTY=;
 b=BleIPyzG9o0tHAQ3XaOj34ageP5UOaGtsNISPMe+2dNdOqt7rL6UYCCUA6Yl1sDi9yIEiJq1UGQLldMnQ2uEx6zkjFproIsEfzoJguJBA30rbEDhqiZbHMkSN+t/mm7rsNa4ssYqIJ5eq8pM/2DF15J3gcQB+oCosmOG/nj2j4jFZvFedUhswmR1nP7yMDKSNBW1R4pB84uASvQg2lh56uq+Prsq7bOLycnX9r15sQj1nDLoQl7ZA0mUSQGhT36qPq/RDevDU0hwchY2cSJnluO1MYiSbx1gCvP/OzqcEY2NUm/hnXYtjD7wL2Nnn+tD7+iD8YZOkgqrWMbONrsAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1a5BRy78jUsy/wl2Q6FdbBn+e8WWOX8AFYVVQh7HTY=;
 b=ZhrfIKqGRUzfwA9bSkuZ5FrJXr35LM4gO8t80wBIe0CJb5bMBKBuSUhFKz5eLrKMp3M9xqdQ4PwFVzmxPjp2EmbuvrO2/4hO2a9UZXX/OLVSc38An7v9+cERstD3vyQ7sZ98w1+8SCk2VbS/Zw8KW7dFZaT2B0qW/ZN/mo1zVB2HzUHgISosgfi4ZKXY6gMGZ95wYeIfS/G7Z76BqfIaiA86mPhvPpE6GoL0DZd4xiSx5MUotS4+h9fzq3T9szls5i0NF2gyWcBlzjDXWtccSEBIEuFLdRic5l7EXcEm/UHeVWD3ngc8jSerT3Bg6oq1PZmXQWZ2XHaXj3ao37uIHQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 10:16:18 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 10:16:18 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v6 18/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Thread-Topic: [PATCH v6 18/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Thread-Index: AQHc8by3Y53q3N6TM0yW4PnUp1zL/7YuJ9mAgAAEiQA=
Date: Thu, 4 Jun 2026 10:16:17 +0000
Message-ID: <CH3PR12MB75482ED309FA7824C69D8E4BAB102@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-19-skolothumtho@nvidia.com>
 <8e656872-4991-4e44-a64a-c055efbb311a@redhat.com>
In-Reply-To: <8e656872-4991-4e44-a64a-c055efbb311a@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH3PR12MB9395:EE_
x-ms-office365-filtering-correlation-id: 3b566fcd-146e-437b-4b6c-08dec2225125
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099006|4143699003|5023799004|11063799006|38070700021|6133799003;
x-microsoft-antispam-message-info: hOUQAuaWCgRLW9FQ5SZiVFQ0HMR3xFzeEgNZKRw0qPfqYahsVdCJ+GeHqi+Nel8qYktESrNIEDwsp/Pqtf+GwylAhlACw7dBhe+wiJYRe8F+KW+avOtb8YalJqmuYJZRNLEgBP5biN7PI1W6PvyuNermCi/Xp/NwL8gd5VW1PYRcv9y7dmGpetuJvIltbes3I6yBgZHc1lhxu8ohkNHjatmHfaZgx/5wNFyXL+VXC7cnCROoWau20D7LML+DYSP43GbOXqXJa57eDs62H9XD0TRrTjWftf0+IFF1PDTkem1fXccM5vLy/YI9uGSBevNEaaoSUmIrqLKeqUi6QLXJ5NnyuX6jsCu3ndWS474KsxIra8IcTn46UEAFX7o+8/brAC1tk2AtQ2FYvzF6qKFJzKDlCZqUaNMFa4D0FGWa+9LA8HyVU3mx25IH31hQLwA1HLj40IEpWK9S+yyw5mDOl8upnxvtfp+TLUDI8JXxHu/tT9pFCkB+WiSgbvk6EJrWH49xrmp4Nk2Z9a8C4eIZ6Yk5iYbLv7eul4im6ibDiyIUq4gruO1s64GR9Pw67aABvn/421d4A9ewKSQwyjEpJpg3yjn9KtJVZR/DYFl8jGV8kgC55Rs3OeF/DHHToTk2B+EULKbuQ17yx7QtutF2PSJgkMQB9783L8EX5Q7Dhn2MeCrCBXVM71o+KisVHMlw5PWp3MnnycR2zhrNLK9MT2FV360K23MqRrSI2KCw8/samyfg61MO2RiXdWA3rk06
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006)(38070700021)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ai4FJvuj9fbg9Ob3UW3zy3uPyHokRLHgPZ6tr8yh7jmRU+HXU1XvkWClPFmP?=
 =?us-ascii?Q?3c8QSG3qDTJcsxWBmlYaYctKHZiL/BZQgpIEIjvaCtlwoxdfXZq4uPlY2LDm?=
 =?us-ascii?Q?OgzlnoHYOrQyS2u0CHuvJ0JltBPnTisBo0SrovD0ytebY/DZ/xYYGsKjExhc?=
 =?us-ascii?Q?HHas8qOnHqTyTd8fNVexxAPitrlIucn9skxUAkbqAr7lmfreWk2sg0H2tn6U?=
 =?us-ascii?Q?3e1RL3LgHZLfABrVw1O5bERuRucFBXpnB7mkQWBT6QR4aANEJtIL89E8aP+Z?=
 =?us-ascii?Q?/llp3cqKhyOGcyrKLkYmdNInX+2UMtlZajNpHgi84SFILqtdXTzprLOA4FWV?=
 =?us-ascii?Q?zC0YEesPRiVbM6UcZAOk1yuAP9B5dg305YqpJmy+xZecsA/57d1DcxUZ463K?=
 =?us-ascii?Q?qcrVPK9SMyHA5pck9b8bl+paZRX16NQBlHgb7E8XGCnAA0Chaw45TfW1t4oo?=
 =?us-ascii?Q?nNh41FsWpGAdc8AvOnEfifhvtKFPFPseIycVL60yPg7BXSQr7b4e+4Z91DA3?=
 =?us-ascii?Q?lW1j2TFp+GSlUKVdGv2oqRpiFaSBvqvfBD0Ck85MJlhcOUvhH+NMHXEFqjAM?=
 =?us-ascii?Q?IQkt5az76agrbGHp5yjRRks+Tx8fvDV0KeMWDQGpwV11n5CtC/ecmoXcbTpy?=
 =?us-ascii?Q?ygQhx8BfDQfI1LCgxCu2X9WqCGCu1b/6nDpQiU1nOzXZhqK/31ZhpQFqxi1J?=
 =?us-ascii?Q?AcLOEVtpSKt08IGr3Z47VtVsYJYilg6wrZfNiReyFACVFeKYbdvKVeJQ4Dbu?=
 =?us-ascii?Q?OHnXM/2tQ/89B3SL7AXD0todXIODTbQVoKcbo00BxobEVBOQCf8j90Aw62Qa?=
 =?us-ascii?Q?qN6kpFIzaqHkiGCq3xQTaUVy+x+U/Mh0FiH8CUw/oj1rVvo3FhvT9+UAldGj?=
 =?us-ascii?Q?92V0E9KNqVuVXiON6tnoMTfZc1YCjqP3slRuAP8+ztnnOnELpslPGekofR5a?=
 =?us-ascii?Q?+ZpwoPFPuf1but+yzQf59Ibns8l1+MsB5dCSVRK0UPDkUpBcsNq2vKhnAIaJ?=
 =?us-ascii?Q?aj5lIILp9NXQodbqy/Rgfy1NJfQPaPsREwZXF930y7Y1gyxTG29JtYJw0JJ9?=
 =?us-ascii?Q?Ok9FaeCwB8Eqm8ahKEh/yfdkRC7O1+FO/o8r/M85NCtn2n2JYQrHpSSZvUHP?=
 =?us-ascii?Q?ur4HDtUxUy9w8lo1u423h3tRydRaOPL/2Oc9ZEAKLFlbeA67X7f9YwNq4fJP?=
 =?us-ascii?Q?s0KnXfq1fiNu0gQ4j+dpxD9u1zKw9DYDghQWWhi5tHVioh74wWY1wR97G+7f?=
 =?us-ascii?Q?HxC6Whp+/c7kpgLLKXCmDFmtlic+QzWTD0Blm3bw+MedDFpqVeInOIpwmNG8?=
 =?us-ascii?Q?BbhPu9lV5N75cKvxxQQRuRa7IrnhXniE8OiDEGZPOWvjPwegSp6jamNuEShi?=
 =?us-ascii?Q?CWC7SOR8VKdsFJzWZ+kGlRjueB2A7S3cGWcMLW0LAH8qT1FmOgjy29Qcy2CR?=
 =?us-ascii?Q?FeE97fYSZjWnbww/5XwH0q7mtREi2CvgnTrtGfMTbGIkYnFX5RRk/n5l2GZa?=
 =?us-ascii?Q?7s6P6hmYYhpia7HxvDzAQv4QaHxyZ2UkUqZxpI53SNT52STXej62pCZMXk1O?=
 =?us-ascii?Q?7tfejXf8Iu3ov13NYmDTxmbgCKpiFvE2SGdws9QrJMIBshXcg+iaPtfUpeVH?=
 =?us-ascii?Q?okF+BJKeEt7De49MvwNugmppzGeB3srnMd6XrubsCTTYXTUZ6Za9e7WGlMn9?=
 =?us-ascii?Q?EKTaSnuvnb/H2smvQ+6ZznE2BUUNOI5kkMm7GrXsJUbLPZxWfxw8JOETsiIa?=
 =?us-ascii?Q?CfWFTRpFiw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b566fcd-146e-437b-4b6c-08dec2225125
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 10:16:17.9012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StX/KtLx8kno4p/jLf8FuhZeol9Rpw16fDDC08/6sMM/rfWUlsT5/PkleDg5rzI7g0tD0DKoLAv9Eaim05VMKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
> From: Eric Auger <eric.auger@redhat.com>
> Sent: 04 June 2026 10:37
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org
> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>; phrdina@redhat.com
> Subject: Re: [PATCH v6 18/31] hw/arm/tegra241-cmdqv: Allocate HW
> VCMDQs once configured
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Hi Shameer,
>=20
> On 6/1/26 1:42 PM, Shameer Kolothum wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> >
> > Add support for allocating IOMMUFD hardware queues when the guest
> > programs the VCMDQ BASE registers.
> >
> > VCMDQ_EN lives in VCMDQ_CONFIG, which is on the VINTF Page0 region
> > that a later patch installs into guest MMIO - so QEMU won't trap its
> > writes. Allocate the hardware queue instead once all of these are
> > set: BASE programmed, CMDQ_ALLOC_MAP.ALLOC, and CMDQV / VINTF
> > enabled. Each precondition write retries the allocation, so the
> > guest may program them in any order.
> >
> > iommufd_backend_alloc_hw_queue() needs the guest physical address of
> > the VCMDQ ring buffer, so allocation is deferred until the guest has
> > populated BASE.
> >
> > If a hardware queue was previously allocated for the same VCMDQ,
> > free it before reallocation. All allocated VCMDQs are freed when
> > CMDQV or VINTF is disabled, or when the ALLOC bit is cleared.
> >
> > On allocation failure, set CMDQ_INIT_ERR and clear CMDQ_EN_OK in the
> > cache so trapped guest reads see the failure rather than a queue
> > that looks live. Clear them on a later successful allocation.
> >
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> >  hw/arm/tegra241-cmdqv.h |  11 +++
> >  hw/arm/tegra241-cmdqv.c | 154
> +++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 156 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> > index c4d327a9a5..84499b840d 100644
> > --- a/hw/arm/tegra241-cmdqv.h
> > +++ b/hw/arm/tegra241-cmdqv.h
> > @@ -47,6 +47,7 @@ typedef struct Tegra241CMDQV {
> >      MemoryRegion mmio_cmdqv;
> >      qemu_irq irq;
> >      IOMMUFDVeventq *veventq;
> > +    IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
> >      void *vintf_page0;
> >
> >      /* CMDQ-V Config page register cache */
> > @@ -364,6 +365,16 @@ SMMU_CMDQV_VI_VCMDQi_BASE_H_(1)
> >  SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
> >  SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(1)
> >
> > +static inline bool tegra241_cmdqv_enabled(Tegra241CMDQV *cmdqv)
> > +{
> > +    return cmdqv->status & R_STATUS_CMDQV_ENABLED_MASK;
> > +}
> > +
> > +static inline bool tegra241_vintf_enabled(Tegra241CMDQV *cmdqv)
> > +{
> > +    return cmdqv->vintf_status & R_VINTF0_STATUS_ENABLE_OK_MASK;
> > +}
> > +
> >  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
> >
> >  #endif /* HW_ARM_TEGRA241_CMDQV_H */
> > diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> > index a52e153501..54d95f4e4e 100644
> > --- a/hw/arm/tegra241-cmdqv.c
> > +++ b/hw/arm/tegra241-cmdqv.c
> > @@ -18,6 +18,96 @@
> >  #include "tegra241-cmdqv.h"
> >  #include "trace.h"
> >
> > +static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int
> index)
> > +{
> > +    IOMMUFDViommu *viommu =3D cmdqv->s_accel->viommu;
> > +    IOMMUFDHWqueue *vcmdq =3D cmdqv->vcmdq[index];
> > +
> > +    if (!vcmdq) {
> > +        return;
> > +    }
> > +    iommufd_backend_free_id(viommu->iommufd, vcmdq->hw_queue_id);
> > +    g_free(vcmdq);
> > +    cmdqv->vcmdq[index] =3D NULL;
> > +}
> > +
> > +static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
> > +{
> > +    /* uapi/linux/iommufd.h: hw_queue destroy must be in descending
> @index. */
> > +    for (int i =3D (TEGRA241_CMDQV_MAX_CMDQ - 1); i >=3D 0; i--) {
> > +        tegra241_cmdqv_free_vcmdq(cmdqv, i);
> > +    }
> basically the same comment as previous patch. I would add in the exit
> phase reset at this stage too.

Yes. I get that now. Will populate the rest handler.

> > +}
> > +
> > +/*
> > + * Allocate a host HW VCMDQ from the current cached BASE / size for
> @index.
> > + *
> > + * Setup is a no-op (returns true) when any of the following precondit=
ions
> > + * isn't met yet:
> > + *  - BASE not prgrammed yet.
> > + *  - VCMDQ is not mapped to a VINTF (CMDQ_ALLOC_MAP.ALLOC =3D=3D 0)
> > + *  - BASE / size don't resolve to a RAM region
> > + *  - CMDQV global enable or VINTF enable is not yet asserted
> > + */
> > +static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int
> index,
> > +                                       Error **errp)
> > +{
> > +    SMMUv3AccelState *accel =3D cmdqv->s_accel;
> > +    uint64_t base_mask =3D (uint64_t)R_VCMDQ0_BASE_L_ADDR_MASK |
> > +                         (uint64_t)R_VCMDQ0_BASE_H_ADDR_MASK << 32;
> > +    uint64_t addr =3D cmdqv->vcmdq_base[index] & base_mask;
> > +    uint64_t log2 =3D cmdqv->vcmdq_base[index] &
> R_VCMDQ0_BASE_L_LOG2SIZE_MASK;
> > +    uint64_t size =3D 1ULL << (log2 + 4);
> > +    IOMMUFDViommu *viommu =3D accel->viommu;
> > +    IOMMUFDHWqueue *hw_queue;
> > +    uint32_t hw_queue_id;
> > +
> > +    /* BASE not programmed yet. */
> > +    if (!cmdqv->vcmdq_base[index]) {
> > +        return true;
> > +    }
> > +
> > +    /* VCMDQ not yet mapped to a VINTF. */
> > +    if (!(cmdqv->cmdq_alloc_map[index] &
> R_CMDQ_ALLOC_MAP_0_ALLOC_MASK)) {
> > +        return true;
> > +    }
> > +
> > +    if (!tegra241_cmdqv_enabled(cmdqv) ||
> !tegra241_vintf_enabled(cmdqv)) {
> > +        return true;
> > +    }
> nit: I think I would introduce an helper
> vcmdq_hw_queue_ready_to_be_allocated(cmdqv, index)
> where you could put a proper doc comment.

Sure.

>=20
> Not that once flag the base is set it returns true. ie. you do not check
> that both L & H are set.
>=20
> But anyway the queue will be reallocated

That's true. I will capture it in comments.

> > +
> > +    tegra241_cmdqv_free_vcmdq(cmdqv, index);
> > +
> > +    if (!iommufd_backend_alloc_hw_queue(viommu->iommufd, viommu-
> >viommu_id,
> > +                                        IOMMU_HW_QUEUE_TYPE_TEGRA241_C=
MDQV,
> > +                                        index, addr, size, &hw_queue_i=
d,
> > +                                        errp)) {
> > +        /* Record the failure in the cache. */
> > +        cmdqv->vcmdq_gerror[index] |=3D
> R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
> > +        cmdqv->vcmdq_status[index] &=3D
> ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
> > +        return false;
> > +    }
> > +    hw_queue =3D g_new(IOMMUFDHWqueue, 1);
> > +    hw_queue->hw_queue_id =3D hw_queue_id;
> > +    hw_queue->viommu =3D viommu;
> > +    cmdqv->vcmdq[index] =3D hw_queue;
> > +
> > +    cmdqv->vcmdq_gerror[index] &=3D
> ~R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
> > +    cmdqv->vcmdq_status[index] |=3D
> R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
> > +
> > +    return true;
> > +}
> > +
> > +static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
> > +                                           Error **errp)
> > +{
> > +    for (int i =3D 0; i < TEGRA241_CMDQV_MAX_CMDQ; i++) {
> > +        if (!tegra241_cmdqv_setup_vcmdq(cmdqv, i, errp)) {
> > +            return;
> > +        }
> > +    }
> nit: you you could after the tegra241_cmdqv_free_all_vcmdq helper
> > +}
> > +
> >  /*
> >   * Read a VCMDQ Page 0 register (control/status) using VCMDQ0_* offset=
s.
> >   *
> > @@ -145,7 +235,12 @@ static void
> tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
> >          break;
> >      case A_VCMDQ0_CONFIG:
> >          if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
> > -            cmdqv->vcmdq_status[index] |=3D
> R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
> > +            /* Report init error if any. */
> > +            if (!(cmdqv->vcmdq_gerror[index] &
> > +                  R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK)) {
> > +                cmdqv->vcmdq_status[index] |=3D
> > +                    R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
> > +            }
> does it really belong to this patch?

I put it here because this is the patch that sets that error in the=20
first place.  Commit log kind of mentions it. I could explain it better in
commit log if that's enough. The other option is splitting the error=20
handling into a separate patch, but THB don't see a need for that.

Thanks,
Shameer

