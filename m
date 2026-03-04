Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AFFEB7EB6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxizT-00064P-3e; Wed, 04 Mar 2026 04:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vxizQ-00063v-Sy; Wed, 04 Mar 2026 04:58:01 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vxizO-0004JG-FX; Wed, 04 Mar 2026 04:58:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2dGD2b5lBBKEpCrhI1r/OJzPHOpxmiFzvjnVgmS0E2N7NcOXvVW6UshUYclGr/RrSi85xqssMuhEjofIGwBytn+O6IBvMrdlN59oB3TpPWAFzOgiIxUI5ISeLfXbl8A7PWZLRmVXRw5+YIhViWBvQok76EVb+Ye5XAPXyDb4fzLmKlWi9AtdCV+1Cmz4XbMpe9ZrPgKaXOrfJd70n7v6kN8iKKISyprPzc7D7gwxjAbxoAHq2EgKAW7nwSs6oiBQh1IigNjIfeg9Hi3uwSXeTQDphEug/P7TU27gCrNeNt0qFW7EO2xGSnlwBzfA0gQ1RHdPhRRI0bMNq/Ued7ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP4weNaKKpTMTpfUuGGqD5wQUhd+ce6ufAoJj44w9mw=;
 b=MlGvkBYtbSEjALDp7SKBH1n/OKaouDbSj6kdU1RreUNp+vFuSuxFlMksB/il+u1FQ0JTJXouQUpI+zF9KzQxvswJ/gtj3y8bMGWOV05fPbVGemZyWyDeHnGC/oCRCkEetYjsN9npexaP7hNNELFFb3zFGarojMPLOZAPWXWY5zevFLF43KBDwTUslK68n+z2qE4zDsM6sqcH9X7B2MIAyB5NyXW8J3KkQxr0/tPFYeaDsf2fU+jWqO+9rU1FddTVQR9A/Jl54x4ktut7FHETWIPp7rlQo6jbPvTcePClMhYy/+DTeKweqbBWjkjuGz6+hcPsActsIJrJ8neJvxQqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP4weNaKKpTMTpfUuGGqD5wQUhd+ce6ufAoJj44w9mw=;
 b=Y/2ZCUuxcCskjJ+FDiUz+RQJVQl4/Fu7+lkht+jJl8DROtVh+OtpVsgXTSpp+dFSi1jXnbX5eOeu6t3tmw3K4NmPOVaxCZ7UhJTrLePywuGhBSINdNaXNB/vJtLECKsNTqkV/fQU7/CXOq00VQywJskRe08AtqQIz8nVzrHJ/VRrD+vWnV7iAJ169TM7RoiKD73g0/8WDFBs0BI654WrLn5eRMnQ31cS6JQXhlBT43kIrMs93kULc2EzUWauBiXQ25sas28amBrtn7fSqpuu1oYYJqBbxbQLiS5UF/UngDm57sAtUx2LA9EiqkXqM3eFz5zloV0ExkOn/x9FemcIdA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 09:57:51 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 09:57:51 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "philmd@linaro.org" <philmd@linaro.org>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Topic: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Index: AQHcpvxYoJA2rVvrlUmoO+kVeNPgOrWXqK6AgAJnu9CAAPAvgIADGvWAgAAPA1A=
Date: Wed, 4 Mar 2026 09:57:51 +0000
Message-ID: <CH3PR12MB7548A4BD3DB9BE3D21E9BB2AAB7CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
 <20260226084456.112142-6-skolothumtho@nvidia.com>
 <IA3PR11MB913652049863E1F32BE9C1319270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB754818FE668426F2078F25BCAB71A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB91365D6AF54A9D44998A9BD3927EA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB913663EA85A8B00DCEAB2301927CA@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB913663EA85A8B00DCEAB2301927CA@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SN7PR12MB7156:EE_
x-ms-office365-filtering-correlation-id: 6b4b1977-53f0-47ae-8086-08de79d47fc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: N5ZA01YeRtga+OPhhUXlItAZAi4jJjaWty3a97IXjwH2sKsKR2M4BpAiJKOldEWIkD5Up8Gax3FpkdpYjGZuc5B67ktKSfk7qMQplg1gKaOxcwrs3F7szBYlGeJLUntwxHGwsb0afSDpENWfTz/0khRnPNyBRK96lFyA+cXcsEwiuCg6EcpZYEDpIrpjW1lOmx+lWe7HUZaQ/fOud/SZ+0pzg/Vfji/oopfBQdVaspwcvcv/xc7Cwak3vh9QopgpvBOVCvD3AaxruD/yjLCsTKDhgjISkH1a5NwSYLgXMliqjT9S5ESbgbkn8VdE5Ypnmenp2P9+T/YlFi8D+C4WoucR2JjDFFIuHX1A30xbmFVXJKQ+cVk+WzscY2Q2FY/m0fY1/mpEZwxEcR76T5haVVKE+Or+Fzvn+8bF0RrXIjkRgEcn0PiCReqs38ONCM9IWp8/sXOzjv92PgWHsjQh0T9PvdAmzY0NlbrZj2GccvoZkC2MIoOLeY/HhbPDGsCOtsgkSkAOHHOBsrQfHeTLHIW6xUAfSynT81g24n59/NnmXNdAgiOodMGx23qmo980txSgVMIYRzW0E7/a+xRBC7P3fGMZZbAIAWyhp4ueUroV44d/eT3PreXLxB2Egua75+hW5EQpArqtwQuRTxOsMnSrWKs5QMQ0s95ivgmsbxDIATkiumGCYv8RNMgPKOkZ/5y5KwmfaFeNZ7ZfqiTirvv8KBPVYEGmrsDPgl0AfThka1G7sr5Dvhe/Kwo/RwFMQIPNVlH+2Bs5stWJMRM6zv1pXukz8RvxwTz+EvmeiW4+7/MgdtL0lA4Que79FiLC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ww27yCETz0ZzM2twlJSHLBtjFAfX3IIovc2/440WrbWuaQgK75kQGDto1pKC?=
 =?us-ascii?Q?00VeiBn+qMZBBzRw1kjNO0SA2uIH7sLD1H3NnWeNyjYzYB4LCq7XnDaUbZvB?=
 =?us-ascii?Q?2WxxAZKp63NxLbx7V1IaQppwTsw/AuhwjqCYUXjsdczNIqp4daTJqbWqBfxn?=
 =?us-ascii?Q?r+NpFyt88P1gMHJ5pcyghvrdCgSFkNy5I2C0mbPqe1zVvBjKrlsSnjBPHLau?=
 =?us-ascii?Q?1NtsBPuB7/fDBgHGtOIMfYbKj8cDjKCaVhmOLbv2mcEeOoqxvAQU27ZJn9Bx?=
 =?us-ascii?Q?avLqmocaLB+nFcTB+d+RbSWiwmTfbU4juqZh3vizNyDGzukmctPIlI25n0mK?=
 =?us-ascii?Q?wfGLL8xxJBjod1dgw3NSn1UO8nDT7hZWLn42uL2JYPu6SanYuUzHmYi6WqHT?=
 =?us-ascii?Q?xvSZT24fYFdvySLoQqna3xU8GCzGWjh142JPv3BNYaI2QfLbVpFkCaoClkOA?=
 =?us-ascii?Q?DGXi0KfHet/Raz90fMPfZ7ayWIZSji+67d/fJjSqL9EP/rIpde37N23C2oqR?=
 =?us-ascii?Q?WuFCjlBX+MUsKSdrriS7EB9nCPUEcACvwuGVENUwsU2IUfidT1RsQ5iilaJO?=
 =?us-ascii?Q?Sfj20oOvSwvzmMEtbtEJRJFarWrVD3V9Mi/FvxKv/N+MDHHFVp3BaiyD3oU7?=
 =?us-ascii?Q?iky/0qv6YL4joiE7j97kqSP8U/bXoiNqaHtV7oyfIzgj4a6bJFCRWbwKEUXv?=
 =?us-ascii?Q?qeVOv4sGjGbrHz1rNXpJl4R3hT0wdWKiXWewDN/Gqw7/0sNOmp63aU8gna7M?=
 =?us-ascii?Q?9yM0+oU6yue1g0XvAUJhH1/6SvvAbhzELAs8AAlP3V3v9Fpw87lOfgt1IrYs?=
 =?us-ascii?Q?yCJ9L6hp6hO5ZNFflwOENPpIvcah+c/tIQP+AuEQa6frgGhnGxEc4i1iU8Nb?=
 =?us-ascii?Q?/QZabWTA7bQcW/3YE0j2pJxC3k/IA58PjuHlDkryRAGRcSbyfG+GMuF0qVJG?=
 =?us-ascii?Q?T/aBkcZ0OrsDfb1coqSBVToZxYnevbJQYOc3yC1Kwsc3zqmcwMXyXPiT57AD?=
 =?us-ascii?Q?ga9SxH8a0m8ncLXTZTfTjvTH4upV0iz7pKiJWxWRC9FqUE3HVOqZY5iDtVks?=
 =?us-ascii?Q?23yJlByngudn1iQq+mgh4h46etMhIPlaPAuaeFEKuZhXhkvZoJNRy57DagUq?=
 =?us-ascii?Q?4els5f7jT+fFFc2mdrDl0apXs1mwdOALtg8jLcRrf0Hppkg0+Ufw30lD3qiF?=
 =?us-ascii?Q?hiFeJrR8iJceq7Hl/X5+HWtsWRDxDGsPTZ8uqkg4f85fXkU/NQqMhKIP2HZd?=
 =?us-ascii?Q?x81j71uWhdRz1PYa1HYqdXJOB+6fUA9eKonjiriXOD9T8CGBh8LxcTyM7oKP?=
 =?us-ascii?Q?bF/N3bcdDfaEO651a8ETeAXhFAx5JhBJqKchYrcH5F9uDiphLcTCYUDuKho3?=
 =?us-ascii?Q?f3WxEXeWEqoG/abvdu1NauFemkBY5TIKphkjexSzuL7sGgxM8D20TlnbttWz?=
 =?us-ascii?Q?q6gKRx9PjRJpZDexAZWvP+LyLE9sv9Sxie5Fgblm/SOSVbWBXbKrhUxWkr4T?=
 =?us-ascii?Q?Zzauhk1XiTmjhAfBXJEVgzNQ8fqtQxMR7lnVGFYyFwTD2jSI/wSRB5/WMqfT?=
 =?us-ascii?Q?QviiXW0DOrqsfu0D5Q0/pQpPEYSc7vVuVeLx4iIM0otLKd9bNcaJE5JBTn0G?=
 =?us-ascii?Q?8w6FkFm6vy+niF2JEMeUiUJyFyI+rwg6RVo32XQN82VeHTgrBvKjv2DV5pfJ?=
 =?us-ascii?Q?9RyhCHE5WjxNkggYb9Fszc8hpHJ8/TCp91mIWnVYaAzw/754QCBm41fEDVuS?=
 =?us-ascii?Q?JKxH6DuLaQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4b1977-53f0-47ae-8086-08de79d47fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 09:57:51.6366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/4me8Lj0AXFDGsv2QmmarMoaRNoi9EjXuGYDI7g8iAAi6Xe9iyF8UrdGz1PlOXVvYsFCZFSniq/o6ITS3S6RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: 04 March 2026 08:56
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org
> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; philmd@linaro.org; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
> vIOMMU events
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> >-----Original Message-----
> >From: Duan, Zhenzhong
> >Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate
> host
> >vIOMMU events
> >
> >Hi Shameer,
> >
> >>-----Original Message-----
> >>From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> >>Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate
> host
> >>vIOMMU events
> >>
> >>Hi Zhenzhong,
> >>
> >>> -----Original Message-----
> >>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >>> Sent: 28 February 2026 06:28
> >>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> >>> arm@nongnu.org; qemu-devel@nongnu.org
> >>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> >>> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> >>> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> >>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> >>> zhangfei.gao@linaro.org; philmd@linaro.org; Krishnakant Jaju
> >>> <kjaju@nvidia.com>
> >>> Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate
> host
> >>> vIOMMU events
> >>
> >>[...]
> >>
> >>> > static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
> >>> > {
> >>> >     IOMMUFDVeventq *veventq =3D accel->veventq;
> >>> >@@ -397,6 +441,7 @@ static void
> >>> >smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
> >>> >     if (!veventq) {
> >>> >         return;
> >>> >     }
> >>> >+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
> >>> >     close(veventq->veventq_fd);
> >>> >     iommufd_backend_free_id(accel->viommu->iommufd, veventq-
> >>> >veventq_id);
> >>>
> >>> Did you ever see free_id failure here?
> >>
> >>So far I have not seen free_id() failure in my test setup.
> >>
> >> I'm working on PRQ using FAULTQ in
> >>> intel_iommu
> >>> and find a race condition, I suspect the same for vEVENTQ because bot=
h
> have
> >>> similar
> >>> implementation in kernel and qemu.
> >>>
> >>> qemu_set_fd_handler() is called to remove veventq_fd from epoll() but=
 it's
> >>> async,
> >>> this can lead to releasing of veventq_fd delayed after free_id(vevent=
q_id),
> >>> during veventq_fd releasing, it drops reference of veventq_id but it'=
s too
> late
> >>> and free_id(veventq_id) already failed.
> >>>
> >>> It's not easy to reproduce, we had a test case in guest to trigger FA=
ULTQ
> >>> allocation
> >>> and freeing sequence in loops.
> >>
> >>From a quick look:
> >>
> >>qemu_set_fd_handler(fd, NULL, NULL, NULL) -> aio_set_fd_handler()
> >>
> >>aio_set_fd_handler() takes ctx->list_lock. For the delete case it sets
> >>node->pfd.events =3D 0 and then calls:
> >>
> >>ctx->fdmon_ops->update(ctx, node, new_node); where new_node =3D NULL
> >>
> >>In the epoll backend (util/fdmon-epoll.c) this results in:
> >>
> >>epoll_ctl(ctx->epollfd, EPOLL_CTL_DEL, old_node->pfd.fd, ...);
> >>
> >>As I understand it, epoll_ctl() is a synchronous syscall. When it retur=
ns,
> >>the fd has been removed from the epoll interest list in the kernel.
> >
> >OK, I think I understand wrongly.
> >
> >>
> >>Also, I think, aio_set_fd_handler() and aio_dispatch() run in the same
> thread for
> >>a given AioContext, and dispatch runs with ctx->list_lock held (via
> >>lockcnt). So looks like handler removal and dispatch are serialized at =
the
> QEMU
> >>level.
> >
> >I just found my scenario is a bit different from yours, aio_set_fd_handl=
er()
> >is called in vcpu thread and aio_dispatch() is called in main thread in =
my
> scenario.
> >
> >>
> >>Do you see a specific window where the fd could still trigger after
> >>EPOLL_CTL_DEL returns?
> >
> >No, just speculation.
> >
> >>
> >>Could you confirm which fdmon backend you are using..poll, epoll, or
> >>io_uring?
> >
> >There is no CONFIG_LINUX_IO_URING defined in my env.
> >GDB printed fdmon_poll_ops  for iohandler_ctx->fdmon_ops, I also set
> >breakpoint on fdmon_epoll_try_upgrade(), no catch, I think it was
> >using poll.
> >
> >>
> >>One more question: is the FAULTQ register/unregister model identical to
> >>vEVENTQ in terms of allocation and teardown ordering?
> >
> >register/unregister model are similar, see
> >https://github.com/yiliu1765/qemu/commit/28b72d6b372555494d0e6a1
> ccfc97c8
> >0bc34423a
> >the full branch:
> >https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_prq_wi
> p/
> >
> >> For vEVENTQ we only
> >>unregister when the last device is removed from the vIOMMU, typically v=
ia
> >>device_del hot unplug.
> >
> >OK, this is different, register/unregister model is triggered in vcpu th=
read
> >when guest send PASID table invalidation request in my scenario.
> >
> >>
> >>Please let me know if you see a specific race case here that I may be
> >>missing.
> >
> >Maybe this is a race case only in my scenario, I need to dig further.
> >Thanks for your analysis.
>=20
> Sorry for the noise, find root cause, this is indeed a race case only in =
my
> scenario, because I need to delete fault_fd from polling fds in vcpu thre=
ad.
>=20
> While aio_set_fd_handler() indeed wake up the main thread from poll(),
> but there still could be a small window we call free_id(fault_id) before
> poll() exit and release fault_id file reference.
>=20
> I wrote below to make it work, in worst case I see free_id(fault_id) fail=
ed once
> and could succeed in second try.
>=20
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -206,13 +206,20 @@ static void
> vtd_destroy_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
>                                    uint32_t fault_id, uint32_t fault_fd)
>  {
>      HostIOMMUDeviceIOMMUFD *idev =3D
> HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    int ret, try_cnt =3D 5;
>=20
>      if (!fault_id) {
>          return;
>      }
>=20
>      close(fault_fd);
> -    iommufd_backend_free_id(idev->iommufd, fault_id);
> +
> +    while(try_cnt--) {
> +        ret =3D iommufd_backend_free_id(idev->iommufd, fault_id);
> +        if (!ret || errno !=3D EBUSY ) {
> +            break;
> +        }
> +    }
>  }

Is it possible for you to use aio_bh_schedule_oneshot() here to force the=20
unregister run in QEMU I/O handler AioContext instead. I think that is
what this fn does( though I have not used this before).

Something like,

aio_bh_schedule_oneshot(iohandler_get_aio_context(),
                        faultq_teardown_bh,
                        data);
=20
and=20

static void faultq_teardown_bh(void *opaque)
{
    data *fq =3D opaque;

    qemu_set_fd_handler(fq->fd, NULL, NULL, NULL);

    close(fq->fd);

    iommufd_backend_free_id(fq->iommufd, fq->id);
}

Thanks,
Shameer

