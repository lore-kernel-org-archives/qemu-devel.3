Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF1FCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKCZe-0008Am-Kw; Tue, 05 May 2026 06:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKCZU-00087u-QL; Tue, 05 May 2026 06:00:08 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKCZO-00075R-EA; Tue, 05 May 2026 06:00:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sef122Y3AfKPzdvrK7zesCmlkXheduEo2aRpLWuimKHoueKq/W61X20kuen8ruMxd4hj1vu6V2xKtw959YhTRgmpcPn1YZbN+6nAJRxIadDPVZOF9CF2sPAmYrsnwJAmhHClxp58vMRKFMOwFDY3AP2pplhkfwDCnN7nZgnKdKsYWu6q2UPt4wH/qIl8T2pgZ+HQBQYNjSgIDewDLEexUTDKI26ejycclGdZVnoDp635Yg3GuoVj86mBFkUJBHQVIuL1nxfSv+/O4R4TcLXxaNUOWPn4wkqBDe4wfTCdWe3ShAAm/1ebG4hnZ5wLrdhB+GDJ7ziy89r08KahRAGd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr+xaNR7V41ElJF8drCltHW+7JQBtfxL5Ypd3mwf4X4=;
 b=K5rszTsv8W5p09M9GjLHFYcKZ/mRhQLw1rKUgL1T3UqQNnBAibtb2tM2PCKjh9hLTMhBBF2J+z/2a/lIzigZZSkuXCLxq7wmnonsNWKLNFH5yyHqX0U2PMiVQ07gem3PB2dMpkgOyC9Yzmn7pZYv1FoblCnFTBVy1igdLudcKMZ0nA6fKak9qYBrWz3ihtV3DI7WtB4uvl3A1V7jbzAULr7zq3asnFrJ4dTa/ty1IGX4Qw7MzzWcITwxv0fFVnleEdId44ds8vSsDg/hGjIoscmbQ2c4tGET4sqhMucRP0JqwrOmJmwtMNiUfhrjrBo0V+ekBQPaYAZiS8HKnhd+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr+xaNR7V41ElJF8drCltHW+7JQBtfxL5Ypd3mwf4X4=;
 b=f1XfyfMnIK8gpLDyB/MxkwnCpM0+Ewt5pMc63tW30P95AbWK0043BmpbaqB3WjL06C3XRwVkgdDLfm/6LWxcb9mfnWOqJu/bFPb798ZCH8A+Mr5gWYkds3J+dxRweekCnccftbef6QFBoqQgIYmVtBnM674x4/r36AoG3FDb1OfJ+SJNaRWWIWseyupd8GXt8vkKBHX0+9fMH5dt+Tkj0OKbXO1/qomULiPMortJAbrLjmrtRq3978Uqt7slCb4XJ+GkFA0Ni5MtZKP96+/s+chVAx9gtzjfcQTOlzy2Mr0qdz45vo5skH39IxLIFrKOz3lcsp9erehUVZU//E9TJg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:59:56 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:59:55 +0000
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
Thread-Index: AQHczMa8RoKQGbMZKEKacCtQsK9v9LX+tf+AgACPEhA=
Date: Tue, 5 May 2026 09:59:55 +0000
Message-ID: <CH3PR12MB7548E9681835CC2A31ACED1BAB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-20-skolothumtho@nvidia.com>
 <afk8f6BNAN2J/9f2@nvidia.com>
In-Reply-To: <afk8f6BNAN2J/9f2@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB6628:EE_
x-ms-office365-filtering-correlation-id: bd0fddc0-9098-48a3-30d1-08deaa8d0f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: /dE1IISU1bTR9595EBcNJBifg9qICEPT8rJ/esc1LIA68qoNPftaWo3mTvUqcKzjhb9qr8riZtp3dxDFlOuLQgyQf1CGKmgxtA5SQZjlrWpqzzoQhHPtA6qU4VuxvW5Om+QUGN9SPIGsCgoLiZ3alw9ErmZwkb00I4MqqWzMuUESbCsSCiyYorVbBfzzLxydgFNz3knhvve8FiUWYpUClnpJVxLOtKlby76kfxdzb1Fwsl3h5w3HzO0bnRsFuFsZHGDiwACsyKkLz6cCDMvY2Vgi4NbFKV5bEjCqu3ImXMjEH6tWzrX2faIg7kXjEv8OwKtYUSqo8VIdImpSDsiFzUS4RV2iHERtsDK1e1yQJysdefHMZccmVUQUAGI2aEyzEDSWRbhbBcpXnbcyMi0m24zKQgVWQh3r7x660SDu4DFLL8qHvHA3ezuBYpvxnVaxTfglVyV46eklxG3mAyv8EIpfcVxuFrCxuksygVOO3SkzyDShDzf3OFYi9aPnnrMl6qP552LwlZsx8Mb/M0I5UweGBKVHEs+xB3B6LLLG+yrj2kkOooJdTXOKZitWswePRYGwu3AAx4veuWjA4apo9ueTsp7TR3dVReyHPlpETZuQ/WbC2MM/TtPo5lqdf7fI8YKG7coE3znldnYZIqC/xnThdWCwV+FpnPopjUI7SsVhYiK9YTtG3rGM7vPzJF/YKJazU6z9SrNhQlKM1VhpdoLmBXGlLCM06jziVEkstMYnDjZ9NoIUFOIC6j3jE36m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cZoi36wyXlY3fqHSeFxdzcrUdTzhrMI2HIg9xtei60eUHpQxe+2jj4Qko/og?=
 =?us-ascii?Q?KXRBnBgA1cjj8LuJQ8KQ151t1+KQkDmosXF+MwQ8+SDCDoWo2PXe6pImQ8al?=
 =?us-ascii?Q?kG/GHlDvsOZQjb9a1sxmiW2BnTjIsY8hil7bAKDuhaK5WPduJj9m1w24QKCL?=
 =?us-ascii?Q?t2m35D8/BTiPyLkmYFBldBgOUT4/GxlSV9Zleqbikv49kwhjzppJc04cCgDE?=
 =?us-ascii?Q?Trt12yFt3w8u5W1CXmvDXQ9X5bq8pcTH+hxtj5ZJKBAqK+A4HWPDgCaSN4Rs?=
 =?us-ascii?Q?e5E0FGiZJLwyrvrmG2wME7pLobbb4SuZWF6AdnZyIo/6ahB8pEY8UkTik9LF?=
 =?us-ascii?Q?N0A/MvIFcTjZqzD6oE9JxXoml3C2ns0lEkilTn/fkq++mke73RS+i8B+u3FK?=
 =?us-ascii?Q?zklR8czOhP8pz2PyHphViW0kp68tIscbCp8PRAUl2WHogyxmpSuF9GXGWe3Y?=
 =?us-ascii?Q?brZBcqLLX8p114W9xSqSI6sp9vHhcJI1SzWrY3cTc7AaYW8J/Dthjt2H7gTi?=
 =?us-ascii?Q?Uxd08Bj4YQJcXucF9Al5+Pb9ItzuaDysAzddZ19E2+4FOdUE48ZbLaSiFXHa?=
 =?us-ascii?Q?ORJ9g37xpR+8jXVX/l8wz0QSsBD4W0aTPvby0dhG4ztopwk6QJTWmDzkb+CB?=
 =?us-ascii?Q?PmbIgvl3dMImyEHyd33umu33chvl7lhOdXaFCj2TkqoFz4Cjc3FuJzFDYv/d?=
 =?us-ascii?Q?fqziSmlptB2zKcB3AgmGViw7YEIICQmdwy3IuDlO1o2rTvzc3wfRC9Ui8vFY?=
 =?us-ascii?Q?BLsUxMseRjI/KD1EMjX783k1QxvRZxJEmSZQ0c4ZotyUAzgBKLorFxaWiC8U?=
 =?us-ascii?Q?ucv5h6DJlS8L7qpmnDlUdFSD+9lYS0MhnM0Ws6DuCIcQoy+fNvoLEeRbj1Ov?=
 =?us-ascii?Q?DwXrYF+gyxSUB89V700Dx6IHnP3tqcRUwObmaaiLjJkwxYhQ2Mil9ClN76og?=
 =?us-ascii?Q?g0D4QQeH5ordWEgOaSe2Vj6eMobUTrq/TQ/uviNyfVdrLUg1nwqdjn4fTb0h?=
 =?us-ascii?Q?HqzSn0Qsr8endGqItZzWrya3mw9xUNlkAogyOaQivyjoAajJ4fXDbtGuZ8oU?=
 =?us-ascii?Q?yoKcwGzX6oKlSSe+9IcHVRct3gnRbe87GrCWemaqdbBQdx2KKp5ri7fS66uG?=
 =?us-ascii?Q?vBwx1QK4WoSSd2zNSZVaCHOptRZbPS7iP4NJHbftu7G+2LCtj9vOHzYdkCuo?=
 =?us-ascii?Q?A5BTUVVmKLO2/92W/AlRrumASydCZY/Ki5Wc/RjhCZ0sfeJi4xtyKGNlMUxR?=
 =?us-ascii?Q?uM/mFChmYKRmLQnN/5dSNMGMvYiFWDjdPCIAVqSrDlokTh3jEISC+0EFaWcN?=
 =?us-ascii?Q?bYbdSd+vIcCfeQ/69tp55QTP7a9tidpkUzt8sPXyu71GhivO3OK0ZjxKPFXi?=
 =?us-ascii?Q?Zp64rUn4edZjGjVvzr96CB/78JqOzuUvDoHvs7E9+4zTP+RT88mRNFIXQlyU?=
 =?us-ascii?Q?v4dM3OTRSR3AHMVMQqdgC5QwosmpEr5Tb/nIwTUjBHq3zf13wXUKt+Zqs0hR?=
 =?us-ascii?Q?I9mQoaNptRymY0zfxn+0NGcjjAWL0EnoKxo1CT4f2eZZgposN9gcyXFzonL0?=
 =?us-ascii?Q?sDpEmMEY8+YShUtGcMyTwIX+TvM6iTKlROD3b+mIZMqwDEVH14Qe7+o4rSZM?=
 =?us-ascii?Q?Vns44EHbjzyujEZANzWtBNK4XBu1+DNtHtt6Q6vBK3rW0CPFM5cNnzeW9hPa?=
 =?us-ascii?Q?u3lTOFBMQMxy4lHHcTNWa0ZaddhaQdC7V9VhMFyLKEN/zt+Q8URglxa1D87V?=
 =?us-ascii?Q?dighv//yYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0fddc0-9098-48a3-30d1-08deaa8d0f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 09:59:55.8333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Yio0hZSOAjL/75cPY7A6jTopjZ5HUrxsiIkwtppN4A/ksnRVA+bEHQ1XqeTrCitZPFg/CkuMiH4kdan5b/uvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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
> Sent: 05 May 2026 01:41
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
> On Wed, Apr 15, 2026 at 11:55:40AM +0100, Shameer Kolothum wrote:
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
> > +    /* Ignore any invalid address. This may come as part of reset etc.=
 */
> > +    if (!address_space_is_ram(&address_space_memory, addr) ||
> > +        !address_space_is_ram(&address_space_memory, addr + size - 1))=
 {
>=20
> Overflow prevention:
> size - 1 + addr

Ok.

>=20
> > +    if (!tegra241_cmdq_enabled(cmdqv) ||
> !tegra241_vintf_enabled(cmdqv)) {
> > +        return true;
> > +    }
>=20
> It's good to have these two checks. But if vcmdq setup is skipped
> for vintf=3Ddisabled, we need to call this setup() again upon vintf
> gets enabled?

Yeah. It looks like more restrictive than required as per spec. I will
address this.

>=20
> Also, do we fence against unassigned vcmdq? Corner case is that a
> guest might write base address registers via direct (global) MMIO
> space.
>=20

Not sure I get that completely.

Spec(p. 176) has:

"While the software can program the Virtual CMDQ(s) directly using the
direct VCMDQ aperture (and not through the Virtual Interface), it is
required that the VCMDQ be allocated to a Virtual Interface before it
is used to send commands to the SMMU."

The spec only restricts sending commands before allocation, not
programming BASE. In our model, the BASE write itself triggers=20
alloc_hw_queue so there's nothing to fence there. For other's
(Page 0: CONS_INDX, PROD_INDX etc.), the vintf_ptr() check already drops
them silently if vcmdq[index] is not yet allocated, consistent
with spec p.172:

"If no Virtual CMDQ is mapped to the Guest, or if the logical CMDQ index
in the Virtual Interface being accessed by the software does not map to
any Virtual CMDQ, the access is dropped with no Fault/Interrupt".

Please let me know if the above interpretation is correct or not.=20

> > @@ -363,7 +427,7 @@ static void tegra241_cmdqv_write_mmio(void
> *opaque, hwaddr offset,
> >           */
> >          index =3D (offset - CMDQV_VCMDQ_PAGE0_BASE) /
> CMDQV_VCMDQ_STRIDE;
> >          tegra241_cmdqv_write_vcmdq(cmdqv, offset - index *
> CMDQV_VCMDQ_STRIDE,
> > -                                   index, value, size);
> > +                                   index, value, size, &local_err);
> >          break;
> >      case A_VI_VCMDQ0_BASE_L ...
> A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
> >          /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above *=
/
> > @@ -373,7 +437,7 @@ static void tegra241_cmdqv_write_mmio(void
> *opaque, hwaddr offset,
> >          /* Same decode logic as VCMDQ Page0 case above */
> >          index =3D (offset - CMDQV_VCMDQ_PAGE1_BASE) /
> CMDQV_VCMDQ_STRIDE;
> >          tegra241_cmdqv_write_vcmdq(cmdqv, offset - index *
> CMDQV_VCMDQ_STRIDE,
> > -                                   index, value, size);
> > +                                   index, value, size, &local_err);
>=20
> Should these two be squashed into an earlier patch?

Yes.

Thanks,
Shameer


