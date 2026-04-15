Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E974EF41995
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 17:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD4Ml-0003UL-77; Wed, 15 Apr 2026 13:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wD4Mg-0003TQ-Da; Wed, 15 Apr 2026 13:49:26 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wD4Md-0005qf-L8; Wed, 15 Apr 2026 13:49:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fbag4Aj+9pwvYaUBB3BcTHdpXh9iVMYN30AF/Yc034ahVjtgmTzTNmorq8FfruBgP4XblqbfW711oMr7dF1LWDH6qynXf39fjX9poJhMlGNLI2MyhuWkGOGwqdmlIiJYLHMKioGtWQpY+007/pyANLOCAxg4pU3+tcyvfBSjq+T/8cvMFgUgqtxoMwK1U1Rkk+XkS2thVYtQjkuKEmOEiDd4WT6NwptzpViH+Wt2xoizyZf9PWpu8hvbnL0svegtmSF/bEu++83GuTlHvkr07o/+kY9dXi5pKcotKSIUYsgitVfi3aO3UOIxhkIoA/67G55qYTbiWYS54z5gTtY1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldbCp/C4qZQKwd0FJ8B1BtXlwIQCOyF2n68kG/bq4Us=;
 b=IUD5A1LqR8vsGt7K2BYyVRnuOe5twrxknifSYrsB98tdL2xjG6lxLSXF02wMv4WY3lFFW5+TV6b1mtgEW0TxXgL2W/Z5VUQkWCEdgqcvVbsx23R+mBVSol7vxNKFg6AAKnLN3TldfTB++cpxMMlFZerYhBXl2Rj9znxFV3ibyM+WtBdGObUWzEdg/QvswLnmPDOk25Kw8SaKSpDmM7NbPOcIbVx9hLEyolzd4WwaQAH+BCS7n7gSQpiKHEVCwx5qsDCRKZ//jfCOKQoInU+uIM/u1aAWrnPofiBD4k9akH9/z88fO245fDIs69QLNiGQoCvGObxQqCj6Hxol5Zy6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldbCp/C4qZQKwd0FJ8B1BtXlwIQCOyF2n68kG/bq4Us=;
 b=OuSGMB7+9Vh8M+2319l8iPtKfciLvN41owe3r8qpdZvdicBg9z6VaSrMf0jNWsJS1NxA1Cve4wiKULlXmSR2MKZpHdGogU8dQsdehGP/liN/d5Jk5+oUS6dJLofr/JFmwgKsw/c4Yg+Em9M0DWPX22s2gZthAfoanDVSYaw+8xdUruvcw6Xv4gvPBhn6JGGef5kDpha+vV611mKo6q7m9V4yKrOScBWYZ6ewOonbc0OcK4RhyR/i7C/QAdk30GJtbrLaCY1sBLvi4st9Cpa6fgE1B5Wbp79GHoJz7erRuQtztuk/KRwz0zYlE/+j4XrdP3kqbppyDVBwqKZobO96Hg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 17:49:15 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 17:49:15 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Anton Kuchin <antonkuchin@nebius.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>, NB-Core Team
 <NB-CoreTeam@nebius.com>
Subject: RE: [PATCH v9 12/37] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Thread-Topic: [PATCH v9 12/37] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Thread-Index: AQHcjrDucxlFepYcq0iavyq5T4OrZrXgktwAgAAHqJCAAC8bAIAAA3dA
Date: Wed, 15 Apr 2026 17:49:15 +0000
Message-ID: <CH3PR12MB7548CD81000B3A3012F3E2EAAB222@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-13-skolothumtho@nvidia.com>
 <00b11b44-6625-4d3a-9bd5-6fd55f35a15d@nebius.com>
 <CH3PR12MB7548AB11BC6EB44358F2548FAB222@CH3PR12MB7548.namprd12.prod.outlook.com>
 <6e7e78c8-d1fb-49a4-a5f9-4130fc1939c2@nebius.com>
In-Reply-To: <6e7e78c8-d1fb-49a4-a5f9-4130fc1939c2@nebius.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB8039:EE_
x-ms-office365-filtering-correlation-id: 79878739-fa5a-4b48-7ed6-08de9b174f5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 0cekQII1DQIzo2NgkVurMr8H3iggcxv4f5zKq2Mg+7RW7kf4W+pAeS14YWBDOfzWMJVpI2Uk/gyg4EBh0qJixL7cpiBODKL7mx2zdgaKMn51tnimzRAfG1D7xAMRG45NBlCBisxSdFI410Mjqyg4ORrjViOy8Zcs6dr+zTenCeKT+ym1QUK/+TIYa796tNKfRsuvT2xP2FTili+oYQcB5pCnKbPFwCP1AtIrXP7JqjMuoNA/uLt3QYf9H8Dqo/tywrKgCVbeeGAFrzoCSXjMMDPhJuGwNG1FTixcPya9xdegy4WIvtA5/1fvUY+gSwf7y/c1sqY5AYg/NGkuD55PsxKr0f4cLx1/O40Wb4nLm5MbqMV6ISdeEpTR8oPNC8HdyWPFCNbU2ZlptBAv+u+aDeHh5iKhcDCtFSNM7zQDGhFWmOytB7YQHAmLt3kTLDMmsrehROtx08cKOLVdZf13mqQ4tvgwtK04uwJr5u4d1r8uxelCCWSroWfBicmIFQ653e4CP0Q1A3052qZAQN+7Z4hxk90Fwld5EtfkV29BUhzUIuLYwqwEBDH8ble/wTlPf9XHDm+HHgaWObw47EjA3fna9TIowuUa1NJ+sCz2L4Gx2WgmgI5lToNqRYuYq229/5JoilTQ8Wyg8oK9FqcCJcbGQ6AMRscY6ewfopbkadrMTgCAO1Hvu3CIXGzDzAr+WAU0stBEYNIQxg1OXcgZhcYIX+7RXqYuc21nwHNXzHxjctrxTCei9zbPpS1HYuap3bDNg34/5C0eLfW3uCZ+3AVVMueoFtWoNTXT3hWmHKc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mofVH+py6w7JDBZWwZwmUCKBDntLfveAW1fNiIL4kmVyq375XAjVet/jlUh5?=
 =?us-ascii?Q?D3C7HsBTmz+z3fTz7Ul0XtwDAqTF/jufsUqOIzLZqs7MSzs59EWr1Bps109Q?=
 =?us-ascii?Q?18pWqMpQa2qXl02cahzabA6zzh35KAOquHV78AaFbZd3TdGhh9mTr0EWEd85?=
 =?us-ascii?Q?doOd7WRy6KWM05mBg63Z/N7hfUO7PR4I/sx+UmyZTXNzoF89gNmb77vwDml9?=
 =?us-ascii?Q?nT3iaqLHtoXneOO4TL0wZmNXdVdsR2A83pIwqAfLyeQ983WCwowwbq7HuDRE?=
 =?us-ascii?Q?1jec3AirBxq56SibmL9WhEb/sdb9YIMkAnupHbcgry5XXvtJO+QsHINtdpce?=
 =?us-ascii?Q?kntfi5uqetsZqblWgJBva4pFNNqUlGL7nJw4QUSP3Z8Na1ZJVNTIe9t2oI4i?=
 =?us-ascii?Q?ONHFINuN97SzwfhtwzJ2OuJtdG/VcCvEmzHosd+fAafEBdNtpUceHaDt8DlF?=
 =?us-ascii?Q?4kwin4b3u5y1mN2QWmKQBe+0W7DBDNRzC3NEXfdZdNgmVELK2YLkuZCrFn+6?=
 =?us-ascii?Q?zMoZfhmYf2Foq5CgQoC8BztzPu1sLNAXoyPUtw3DQ0Q2DXarFVRy9U5GFTeL?=
 =?us-ascii?Q?SE0+HBaHX++XgEX/psJ/L2wjADWbIKKG+Njm7n7dbD3vKzHxZOaamLW5Bk77?=
 =?us-ascii?Q?KMETD/m5HhYFMQGd/N9yW627F/NguIG+he7ibCwhrHl4J3cV9M/0Uar0HTye?=
 =?us-ascii?Q?NDBOmT8FPfNr5gsGRKHQJJ7MbWdMeTR7gf4GyCXTqkCkPUyg89GzzGieWgvl?=
 =?us-ascii?Q?APUmPeiAi09pQM/DJ6maJ/JmlBsKUNuVayeSJqvo9jijg0hh8I+O2hS3DElh?=
 =?us-ascii?Q?qMq0Yvj3cGfOEpePcWok2k9hwILPHdo/Sz/nMijZ98rJvjSzLGThUOEPlOyC?=
 =?us-ascii?Q?O5PSEK3XnUN0saAwkS0ZYi16EBhK/OM8zrljUJ91hPjWm5Q5zw4sOzLpHqQY?=
 =?us-ascii?Q?ZEK6bkvFPHI/46ykw2xCCrQzadAwNVNhhbFB6a++czmc+ZIYIrVyuWYPw3sD?=
 =?us-ascii?Q?HOSlZYDf/a3AkdsPJNnxiwW93GaJlHzG2jaRbpTyVnX9DBSKVVyuRPE6SyD3?=
 =?us-ascii?Q?LpI6NTWJRBfqnhRa1d42ky3Rkpgkm37UY30jcehNjZ0/YlattNlKB4ejBuKZ?=
 =?us-ascii?Q?fmMVr6+Uc6O91Lie277rRmMc7ZZDzyvSeUIW3NphZ44A/NYY6Zvr1UJwGM5c?=
 =?us-ascii?Q?8YqnAoMTyLZgX493D1RVnDvG2vNGImHGJsU4Uabh+cYc4BFmdvjWp1RW1f4y?=
 =?us-ascii?Q?DTuw/ocz1A0Thc3RW8pj1pom85jGVmRdS9S8F3+aAFUQVl/xpSiUVFRn1pac?=
 =?us-ascii?Q?6QLhuXwpTm8zl97C+u6knjmx/fuS8af1z2qWhR/om1TTKsAC0mAoY+DEiJwG?=
 =?us-ascii?Q?8T71DrBNcH7CgI+WqQ4wnvYDOJpMeFDzCY5THKQe93YPP6cKFKatUyKNvGJb?=
 =?us-ascii?Q?BsOjhL3RFkXE5pkIZu3v44Gcn6DtE9tgSafVw3THHf7u8B5ejH+Tzo7Nt76O?=
 =?us-ascii?Q?VnZ7FZcHtmF44UWlZpZKPxXsLPs83zbNtlbsIoz3YSQs99DQHBSvKci7Ks15?=
 =?us-ascii?Q?SdlP9aFeBlwbKD3nlhFw2FrwDiZ8SYvgKm6Km4bqcMn7ju9EtzVPSl36tqCM?=
 =?us-ascii?Q?4w2goP+8gjU3Cz3ofExkisfFAUxr6mHDzSBitogS5oxoSsCYUZkFB4HjsRe2?=
 =?us-ascii?Q?WpC13VMfwcCKI0b+OGDtHlIR8wpqFlCxHapboc5TN5W4fRow405lIbH+XSJv?=
 =?us-ascii?Q?KHprueasbQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79878739-fa5a-4b48-7ed6-08de9b174f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 17:49:15.0977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qbIo+swYQzX/0OcF6Iqqwh8GqKbGvKoN5BF97ZhfnIxt7dBAwGf8ObzWDROMBLBhOhsWRK3W6pgQeul98iiu+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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
> From: Anton Kuchin <antonkuchin@nebius.com>
> Sent: 15 April 2026 17:19
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org
> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> berrange@redhat.com; clg@redhat.com; alex@shazbot.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>; NB-Core Team <NB-
> CoreTeam@nebius.com>
> Subject: Re: [PATCH v9 12/37] hw/arm/smmuv3-accel: Add
> set/unset_iommu_device callback

[...]

>=20
> >>> +
> >>> +    /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
> >>> +    hwpt_id =3D smmuv3_accel_gbpa_hwpt(s, accel);
> >>> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp))=
 {
> >>> +        goto free_bypass_hwpt;
> >>> +    }
> >> My research points to this change. Here we attach
> >> IOMMU_HWPT_DATA_ARM_SMMUV3 abort HWPT to device, replacing
> the
> >> default
> >> IOMMU_HWPT_DATA_NONE one allocated and attached earlier in
> >> iommufd_cdev_autodomains_get(). The problem I see is that when the
> >> second device in the same group initializes its default HWPT it no
> >> longer matches the updated abort HWPT in kernel, so device allocates a
> >> new IOAS and HWPT but kernel returns error for attach HWPT request
> >> because iommufd_group in kernel already has different HWPT assigned.
> > Thanks for debugging.
> >
> > Just to clarify,  when you say "multiple vfio devices behind the same
> > expander", do you mean they are placed under the same QEMU pxb-pcie
> > expander, or that they are also under the same physical SMMU
> > on the host?
> >
> > If the passthrough devices are not under the same physical SMMUv3,
> > then a shared vSMMU will not work, as the kernel currently does not
> > support sharing the nesting parent domain (S2) across different
> > physical SMMUv3 instances. In that case, the expected topology is
> > one vSMMU per physical SMMU.
> >
> > Could you please confirm the host topology?
>=20
> Yes, they are both under the same physical SMMU on the host and under
> the same QEMU pxb-pcie (also in the same iommu group). I'm building one
> vSMMU per pSMMU topology.

Ok. Good to know that they are under same phys SMMUv3.

"also in the same iommu group". You mean same iommu group in host
 kernel? Any other devices in the same Iommu group which are not assigned=20
to the same vSMMU?

Please do and share:
dmesg |grep Adding |grep iommu
=20
> $ ls -al /sys/bus/pci/devices/0009:{06,03}:00.0/iommu/device
> lrwxrwxrwx 1 root root 0 Apr 15 15:10
> /sys/bus/pci/devices/0009:03:00.0/iommu/device ->
> ../../../arm-smmu-v3.13.auto
> lrwxrwxrwx 1 root root 0 Apr 15 15:10
> /sys/bus/pci/devices/0009:06:00.0/iommu/device ->
> ../../../arm-smmu-v3.13.auto
>
> >
> >> How it worked before v6: during initialization phase abort and bypass
> >> HWPTs were allocated and stored for vIOMMU, but not attached to device=
s.
> >> Devices used default IOMMU_HWPT_DATA_NONE HWPTs to be properly
> >> assigned
> >> to iommufd_groups, and then at the end of machine creation
> >> qdev_machine_creation_done() calls smmuv3_accel_reset() which attaches
> >> same abort HWPT for all devices in the group.
> >> Could you please confirm my understanding is correct?
> > It is true that QEMU behaviour changed between v5 and v6.
> >  From v6 onwards we try attaching a GBPA based HWPT as soon as vIOMMU
> > is allocated. And at this instance, we are not sure of the vSID of the =
device
> and
> > cannot reliably do an iommufd_backend_alloc_vdev(). So, it requires the
> below
> > patch in host kernel to be a valid attachment.
> >
> > "iommu/arm-smmu-v3-iommufd: Allow attaching nested domain for GBPA
> cases"
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F20251103172755.2026145-1-
> nicolinc%40nvidia.com%2F&data=3D05%7C02%7Cskolothumtho%40nvidia.co
> m%7Cefaafe8b1e0741162c6608de9b0aa609%7C43083d15727340c1b7db3
> 9efd9ccc17a%7C0%7C0%7C639118667326949215%7CUnknown%7CTWFp
> bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DecbY%
> 2Bs12Z1iVq4ugmwxotc5VRxe%2BUfejWfd4cHnBJks%3D&reserved=3D0
> Thank you! Our kernel does lack this patch, I'll try applying it and
> check if this helps.
> Could you please explain what is the purpose of this change. I couldn't
> find an explanation
> in mailing list discussions and genuinely curious.

This is to take care of the SMMU_GBPA register value which decides the
Global ByPass or Abort behaviour. Based on this register value we attach
a bypass or abort HWPT as soon as a vIOMMU is allocated.

> > But if the above patch is missing, you should see error with the v9 ser=
ies(or
> from v6
> > onwards) with only one device assignment itself.
> Which error should I get?

Without the above I would expect QEMU to fail in smmuv3_accel_alloc_viommu(=
) at:

> > +    /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
> > +    hwpt_id =3D smmuv3_accel_gbpa_hwpt(s, accel);
> > +    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> > +        goto free_bypass_hwpt;
> > +    }


 In my case the VM starts OK with 8 expanders,
> each one with vSMMU attached and one device like this:
>=20
> -+-pxb---switch_up---switch_down---device
>      \-vSMMU
>=20
> And I start getting errors only when I add more downstreams with devices.

That is a bit confusing. As I said, if you lack the above kernel patch
it should fail on single device case as well.

> > Could you please confirm your host kernel includes the above?
> I'm using custom 6.14.8 with some backports. I think that I also tested
> 6.14.0-1015-nvidia-64k, but now I'm not sure about that.

I don't think 6.14.0-1015-nvidia-64k has the patch either.

Is it possible for you to try an upstream kernel(6.19 or >) or
Ubuntu-nvidia-6.17-6.17.0-1014 Kernel?

Thanks,
Shameer

