Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D617DFF4932
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78Sz-0001AZ-KM; Mon, 30 Mar 2026 04:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w78Sy-0001AG-E7; Mon, 30 Mar 2026 04:59:24 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w78Su-0006ZI-VI; Mon, 30 Mar 2026 04:59:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7SnTHb23/T11njvviJeMbXM+PSztkgn8RwHEjIpcG05yxC5dIyHhRvTk2S2xmkuGqyUBuXUHwgYkvFbHusiOA4lSpvm/i21j0xvPRvBg3Zcb88/eGB1k5TQP51kI17Xt0Tz1fRe1pMYtE+nARYyceSlKYkChgcREu6UxpjB4z1x1mYECR1CZPkQWB12k5VY8ACzQc59Y6xP+0GxFWwAYQJdQyy1kylimmU1ngp9sZj2GhTHJEmU7ZGvHA8afmXknqL9UfyXzg7qBDFmXtoDCVZ3NhFdrpad0MPHwa8/983+4gmWRFvcm/WobSI/X8sqRUmGW2BjO9jZR0oWI8y1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF0VOaXgYdDS3zTR17ho3oAslzboB/7wW0D/IK2mNfg=;
 b=qopSs2XONuhm6Bz1EKP7+VW5OOKRAZZhUhPi5HJlqSyScV6j4C5l3tRnz/DCryYpooZABlwwImIfTy7qi/VjxCIlLzOLhM7EHdYZlyXWAJRmOCV8NZUX7wM3YFl+IX0rm2/PQ+z0+Pzb8b7Ge7JsE1BznyycYSv7l5fBw6+iV53EyDO1G/2qzD//4GHK6Sknyx3QKYx/7EBNiF8SwdZHAp/7J/D6YXZJ4ShNj4DIc2o/sBwTNclBYzxJkY4LTzyQs8+DmcGecv8xjMKTzhNUS6JfjqNvXKcr+M2KtubQuOyvwRciX4ZjX+dd3zk7vyW5W62DWaF3YVRv4xMIwV+JBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF0VOaXgYdDS3zTR17ho3oAslzboB/7wW0D/IK2mNfg=;
 b=prWajhmXURug6TzlCJ0M14nspj5Ce+3QhsRz6rJFVcktOJJ2YWQ9GZDPg2bGk09qHHw5aKrji3d1+k6v69jW1KSeg1tdXOgia0YctzHSfLO0OnGQ7D4okoM/qN1cy4QDwhUC36Qa2D2nXvJs8sxDlbSn1ZDaKLzE5OGbYU0w0SkBirrg3mktCItFYCN+IQX6mL8rUP5NecbsQFKVEgJe46mhsV54FwZdMoTU9KyaE83T73jT6v/8IA4JwldImUKQh0pfFTjprR6t897ZWEKjmoneeo/reUJtYvbvZj/xFVqQnKqzcyoKmoWBRdPiPMBBlEVDxNBGpFpRCot4Vp+9Pw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:59:12 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 08:59:12 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: RE: [PATCH] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called
 only once per bus
Thread-Topic: [PATCH] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called
 only once per bus
Thread-Index: AQHcuvMxQPz3cX50cUGZe2My9k7aebXG0MUQ
Date: Mon, 30 Mar 2026 08:59:11 +0000
Message-ID: <CH3PR12MB754884921CDBF05D249CB56FAB52A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260323183024.4069032-1-eric.auger@redhat.com>
In-Reply-To: <20260323183024.4069032-1-eric.auger@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM6PR12MB4059:EE_
x-ms-office365-filtering-correlation-id: b67ffd8f-787e-49bc-3cee-08de8e3a9c9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: GEiwZBEy2vKEz902O10NN2JO7EN/X+zPvig/6rDgPxqvcHQIOjVEinOfwYrvZ7Tm0elrTdxLt9q5nsudaiT/+YI5Ujq3zfH7YMFJuIB4ZKMIEJGZ+T29aQ1gfaWnSGZkIexOd6AQI1QtvGSq2yp1MzufAbEU08VoBCvmi626SYk1mwEBldKfNkyyPj8PUSbfFDzgrHoteGKiWCxEl2+S9csrQoSVBusgGBsTY3FGCPftKGps5aQp3rxHVBQk+k7GjI+QRuK3rVz/x1DGfqU2Pgqv0iZo1L+V0LALS1BYLs/PB4LidShV0wM9X8tp850vfHXw16YT7qKY4ABw/0tYxN6eQXypVFcePCvCs03+S5o2JXTPOcMCPoqaMHir8F1vqF1m0QCNMnuf+AvzZJJW7MCui11Yi8qG1b1eiRNW8vMBKY7TZbgTXtKaNAaxoKopknT8mNSGHSqaVxH/vxKEd7rlN8INqra9uCMWwz+DTXKC4mfaNCz8NFUkE+i2opGyasB7+Gu7Ti3xkkhP3yzrTs9KXHNBadzjdpS8OH1U13NZ1CBsN8IeZTIzxr30itoCkiefqpU+rlGLi6Xuv2bcXwDwaN5WHuuPIDByvkt8lyVVBWE/uR19J9FP8F7A/ihOKBBQ8cm/LgRGJfWMG4M5aiItb/0fIHVCSFr4xD8SpIA1X0K7X6z4RUadaTq2kPLGb+NFhbYDIGNJ+cDnintzbDR6GNjBPD7Xun+Au0M2jipJT9cvy18SHcPXBTKZ3p3KeE1hEFpIlsU5mE9IUxtuNHV+De2A7NUxkvN0Xxtns+Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DjTFNTlOIz7HzoU8EYUMRvkkerUuRgvgI9aKjJGCRjlRaU32eEOsf65+q2?=
 =?iso-8859-1?Q?MgqrRxy6XAxdNDVw1IV6h5Bu6Tf0HFc95v/UQM7hF0ZWGC6i03Dynz8LD7?=
 =?iso-8859-1?Q?dQ11rMaU7V3atHKW+M2rio57jwzlp0hCFizGwxFGl/faoUH6SNZKMsAXmF?=
 =?iso-8859-1?Q?FeEyKAozT79TaYquOWTpUiVsEi1pNzesvwebmIt5ggG7b2/HBEUGBPJ3YY?=
 =?iso-8859-1?Q?uURYGX0RpYSC8QBUBrlQcPVqF98YeMIKIAOiUVPhogkEYb8vbH1oIf5B4i?=
 =?iso-8859-1?Q?2JGAt98svC/wJr92pyNyknsJaa65eIpQBPAtiqwMV+1l2C+41cdTju7zxU?=
 =?iso-8859-1?Q?Z3u1Vkw0UjNdnOj1o0pT6KVsP7Q62CUrMnPtmcgdXOl2EA0OTTO149+pRe?=
 =?iso-8859-1?Q?qLBUgMbSPkJsVeyXxo+Zj+A1RfgO8Tlp63zqxOQRc5Nkb60ehTbTnTN1ZF?=
 =?iso-8859-1?Q?y9U6xTOutImxmU1Ak6DJgXNlk9tBaavLNtwpP3hEJOBmdgbZ5pLzUiQvdG?=
 =?iso-8859-1?Q?Qg+U8lR5+PqDDQNjx5TAt+CfF8nLN9EsefI2gGwnZwbgEVCLGAWAEcI6dJ?=
 =?iso-8859-1?Q?WLnZ+nEUu+KGCU5HtONHAdQRPqZhaWiKIXAIDTznFS1BzqAdYRYv04k/pg?=
 =?iso-8859-1?Q?Q000heHLpiywbBBYsVsztAvGsIepn9wQwHm2VkV3AYYzTYkOZc3TN3eOcU?=
 =?iso-8859-1?Q?YSiVFLllXnjGWUSqzlL9hIbLXeBZXU+sPVeSCK7YEDTefmnVeQAAR5Zs+N?=
 =?iso-8859-1?Q?PZz5g5ZAD3v+JKWkf4HzBqEbbj2zL8x6kgijog1S5748f9TSs7YindmN/0?=
 =?iso-8859-1?Q?vIdx1FcgleKFr9yKFEqRALuGn082pXnWIUeyuF37KLn7ZZ/rLyxeEDnmW2?=
 =?iso-8859-1?Q?GRfEmReXuqCTYq9PtH30JhFy6p4KUhZV7KW7GaFlI6LOeuKQNgfnA4Motw?=
 =?iso-8859-1?Q?TNdP7vVSSPGqOGELB+6K5DJV9UjQM8vle6FInpzHagRTccs2GjrGJGIbeu?=
 =?iso-8859-1?Q?zIcNF6F81lm5ido/+gz1Mi0vAH1ihdONbCcrtp6sctatm83iZ4F/GzlLRD?=
 =?iso-8859-1?Q?ArQuxJXtgHJl7i9dXBOh2hOyJPptTAzw0NEEAc+AWJ9zqhWXCIir3Vd2OM?=
 =?iso-8859-1?Q?5drOoS9e85qF8k1IFaR/zVG9ZW4wiUC5xnm4QESJCQWcvs0Z7BcC3z3rmZ?=
 =?iso-8859-1?Q?tF1b0psIH91HTBAp+vj8rsvGrKWumWwqxWrliLuBWFlUIYrHnwNeptJE7k?=
 =?iso-8859-1?Q?o4xB+E9kt8Xj/NMV9f2ruE6nXqdVjTIIkk0fyL9p+HmShzfTBNMnIec0N7?=
 =?iso-8859-1?Q?naYuuFe2E7fgJr208qzgu/QKHwCTucoPmbOo3DFpgW/Cfx+iqdmiCnSj4c?=
 =?iso-8859-1?Q?wcRozk/OI+8gqc+TQrJaBYBEM4YjSyNIsGNbCQQWI6D2JCtxPSqe/A8qiK?=
 =?iso-8859-1?Q?lp61GlIXDLJZHRxddZMKOHnpOU2BR3QTsjhiWBp/uG6tXHIcQ7utdUUorC?=
 =?iso-8859-1?Q?WfQVhQjMKKuDpaHC7q6WI3+N1s3L3qUprPc8s3tXituKqtNLr6/ZlE/B4p?=
 =?iso-8859-1?Q?3JNTyPY3Zbq3DUPZD0cdeeKxHzZI9Q+eSrcKhXJaaYSBAA5sFumusS1KHb?=
 =?iso-8859-1?Q?LeZZHM/MZqqrxpO7DLOGfVjgOwxWxJkBjO36qoizulrBlHglY3wDWhobsB?=
 =?iso-8859-1?Q?7DusulMsrq2c7HCAJFLPDPFctiELNKtgxWqsW5YYB3cwm+lfGVDM930Bc3?=
 =?iso-8859-1?Q?Wqn7VzNZ4QO18y8I0ygGnxYbU70DgdnCRSOq38BQxhp0HSpz8DrcNkoCnp?=
 =?iso-8859-1?Q?oX5MwrVj8Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67ffd8f-787e-49bc-3cee-08de8e3a9c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 08:59:11.9425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vq1BH3sKKHXDSXY7C2bU0VBIu9ImlCgM3qf9obOyAfceARJ7kCjiCe7a5p97KGFJO3sP/RFWpb6CN/JEBvwBAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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
> From: Eric Auger <eric.auger@redhat.com>
> Sent: 23 March 2026 18:30
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> mst@redhat.com; Shameer Kolothum Thodi <skolothumtho@nvidia.com>;
> Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called
> only once per bus
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Currently it is possible to attach several arm-smmuv3 devices to the
> same bus although it is a wrong setup.
>=20
> Change the prototype of pci_setup_iommu_per_bus to pass an error
> handle. This latter is set when iommu_per_bus is already set and
> used by the single caller (smmu_base_realize) to report a useful
> error to the end-user.
>=20
> While at it document pci_setup_iommu_per_bus callback in the header.
>=20
> Fixes: 66d2f665e163 ("hw/arm/virt: Allow user-creatable SMMUv3 dev
> instantiation")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

LGTM,

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

> ---
>  include/hw/pci/pci.h | 16 +++++++++++++++-
>  hw/arm/smmu-common.c |  2 +-
>  hw/pci/pci.c         |  9 +++++++--
>  3 files changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 5b179091dee..f2448e941a0 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -863,7 +863,21 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice
> *dev, uint32_t pasid,
>   */
>  void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void
> *opaque);
>=20
> -void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
> void *opaque);
> +/**
> + * pci_setup_iommu_per_bus: Initialize specific IOMMU handlers for a
> PCIBus
> + *
> + * Similar to pci_setup_iommu but enforces that the iommu only protects
> + * @bus downstream end points and no other bus hierarchy
> + *
> + * @bus: the #PCIBus being updated.
> + * @ops: the #PCIIOMMUOps
> + * @opaque: passed to callbacks of the @ops structure.
> + * @errp: error handle
> + *
> + * Returns false on failure with @errp set, true on success
> + */
> +bool pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
> +                             void *opaque, Error **errp);
>=20
>  pcibus_t pci_bar_address(PCIDevice *d,
>                           int reg, uint8_t type, pcibus_t size);
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 58c4452b1f5..a3aeb5a8796 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -981,7 +981,7 @@ static void smmu_base_realize(DeviceState *dev,
> Error **errp)
>          }
>=20
>          if (s->smmu_per_bus) {
> -            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
> +            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s, errp);
>          } else {
>              pci_setup_iommu(pci_bus, s->iommu_ops, s);
>          }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 2c3657d00de..5610193783d 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -3307,11 +3307,16 @@ void pci_setup_iommu(PCIBus *bus, const
> PCIIOMMUOps *ops, void *opaque)
>   * IOMMU ops are returned, avoiding the use of the parent=E2EUR(tm)s
> IOMMU when
>   * it's not appropriate.
>   */
> -void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
> -                             void *opaque)
> +bool pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
> +                             void *opaque, Error **errp)
>  {
> +    if (bus->iommu_per_bus) {
> +        error_setg(errp, "An iommu is already attached to this bus");
> +        return false;
> +    }
>      pci_setup_iommu(bus, ops, opaque);
>      bus->iommu_per_bus =3D true;
> +    return true;
>  }
>=20
>  static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
> --
> 2.53.0


