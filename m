Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7380CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DlV-0002Wn-Sv; Thu, 02 Oct 2025 03:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4DlN-0002S9-PN; Thu, 02 Oct 2025 03:30:06 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4DlF-00067a-6u; Thu, 02 Oct 2025 03:30:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnPXkBqE0co70w476ncaYiLGawKiOj7DubyMrTRBeLqBMhGY94M6YsIeRb+GRagkE9QY/g5oS7ODPRIkoMhPtV0ar9HiTYCkjRGiiUbmnSeFgvSqQTjFp8UGD0vHKC+/Kx9Imjp9ibQb0K6Q6TIr4jUzlTFaAfzPFc16cLhF9LoK381hK9kz8GfloYnNj4x5KKywjSI13zzghjbEzF/yi17zbtnw/ug7/j2PgJ/OsT9cfKaQ0d4qS5OzoTCZp3dUY8mFW59tdedbCWSeJccpyOfYgIxOUr5m/ScGTPRLZ24oIq9fWYKvuOiWDIraPMWGd12TKdxFv8HX3evBKtdt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvHBW/JQ1NELF1tELMsYlKE2a9rh0NCLfXa6IWuAC7s=;
 b=JyWJMwyQb/xUZIHNftfuaRpmWFP8eSp7swI+EhuWMvzv0HPRge3vmTarsQGP8BbCRXEJ1YeumfZK7CkHxOdxU608amQVF3qv4iuOhokwYP2yRtZTxqWVyQfiCyef606YpYLAdPHr3zAg1Lduqosj1DsfPCRrx8HVoaDVggY8rdvnoFpAnKZIKus/bYU7UcBf8pSMPjJriWD3npzQqXp/BJ/XrSc/si97BukkXNJpfus58chMXqMBrqu4/4r6XpH1BAgao5nFz7oZp80ez4OwFe/iNQXatLbxixDlhsYrD5vWYtZ5/4nVLWenl0fgrSagqA+9pRPMB3p1StuUgahBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvHBW/JQ1NELF1tELMsYlKE2a9rh0NCLfXa6IWuAC7s=;
 b=VrS8JuYLhk7TSMbw/DTlhEsexrV6eMdTIG1pUC6OXRGZdHcc+txJ35TEtIxLDSqSP4mqui3hqeWzXZUW4b7ASZJsAWagNk7INUkjeJQtPC05HFRjWRb2/NASFm3QiV3nk8kOzhpwU9218Sm7RS+f7c8SKPqIqoqj9+UnWiUe0zVaH1j1SSiRKw4i9d9+X4r5CFIVB88Htem5/Lc6obQS5HPKhtNcf45E9/MVF1NJYX5rGC+MB8104kNILEKNa+DYZFLuF7BzuahO1t/oZcO2zbgUseMFhZXKWmsyOvqsTS8GfnY03dkxDnwMd4Fw8A3Xttd7k40AEw+SAB4ywDgqUw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:29:31 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 07:29:30 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3
 to vfio-pci endpoints with iommufd
Thread-Topic: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcMZ64HNFvMFbT2kCFLixXDfUlObSud+HQ
Date: Thu, 2 Oct 2025 07:29:30 +0000
Message-ID: <CH3PR12MB75480F04FD2EDCBBEE6C180BABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-7-skolothumtho@nvidia.com>
 <aNsgHV/Ebqx0WZXf@Asurada-Nvidia>
In-Reply-To: <aNsgHV/Ebqx0WZXf@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB7990:EE_
x-ms-office365-filtering-correlation-id: 5252b14f-6b83-47ab-bd16-08de01856d48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?85eTOYkEsAkpJcGekZuTB8ylOxy77oqBfW01bmqsEC7D6r+OxOFbtUC2A0MI?=
 =?us-ascii?Q?8MrzlvRVUMktljnskPaOcwRuZMRbZbqtd9MRlLnndgXTDhNIwJwTrytuPICz?=
 =?us-ascii?Q?xtHH2kt6umwcOaUYuBKBKmqsgnI6EQd8Wq2ibu/Q8Ti7/VFuGHWK8Q5opWLO?=
 =?us-ascii?Q?/0bosDPH6S8gqnoUGvAzXIaPzC4LWHCT98V4AsbkMMX4THcCC/qrDeMojrPm?=
 =?us-ascii?Q?0aDMg/uC5fsvDtYroXFZmNxoQB/25ws82TIwMyGABj7NhIHUno2Y6SnCa9sZ?=
 =?us-ascii?Q?sd1Ersvr4ZCTcHB8jxq0c6/E7sLRVPVRt/DdgCAnH7+3bVzxsFJCXgizE+VB?=
 =?us-ascii?Q?7HxMCYTkI4kdu3FdDojosvu1+bHaMYTxGHsUWd2Tr181VNNa4REzaKB9P+8x?=
 =?us-ascii?Q?cV0oWrajNz0xxtmeufI1cnJTZsTu4lVZfcE5igKVFtJCxfANVba9L+vIvgZB?=
 =?us-ascii?Q?D/XWGMarjNk4SaAQUuehMYpKJAXlDPL9BxPDL/AgkrPE0UCMRwhpXcjYsIjM?=
 =?us-ascii?Q?AqFSXwtBfCujDPvDruJXeAt08G1SyuA9YXtebLEs1WfmRfHAGOUK+gbM2iqr?=
 =?us-ascii?Q?mWubcaUqSqzuUzybNugYXq0CQa6eetFJK7YuIDFKwhlfLzm1fFF3whB/8zvW?=
 =?us-ascii?Q?1TIEMvsx98Ol55UgHyFFqPEhdghJ8BCKa2MN64J1h3TbvL3vunQ9lBUwqINm?=
 =?us-ascii?Q?Ja2ohDq9WCPp8IDAS76NLk5IRgosAByxz+sPGoJzvk/zhb/sHGtBQTTwcuT6?=
 =?us-ascii?Q?HaM0Qwi8kwy3CHPOVvfxRGNa/3aiEVE5aaokUfQnA1Byuc4ogMiW09iFU2EU?=
 =?us-ascii?Q?u19ecC7xXvIgwUrvYH7CMQeYM1yr1gm/8N43E03qSl3FPZiMEVVQaMMEtfqF?=
 =?us-ascii?Q?RjGXLP2TuYAWRfUypiPSoWMv4Id6DHLqr99AUVBo8B8tTpsLAwIgtLUcNyve?=
 =?us-ascii?Q?fA8bLDJaqQu3iOidZf1mJF+Qyjp8ioGCHortkSJlkjG8ohXvvdNLBGizXfjc?=
 =?us-ascii?Q?J5T8mXMxe6nA3BQTk1hPcLOYcYSvYt2pt4E41PgOlLO3zbLAYNu95W+f1zbJ?=
 =?us-ascii?Q?4UWtB/jY2CWjXb5VDdXUVXDYYMYyQYoo94Vsr5aHIyS1g6IPMPSjA+UWCvu8?=
 =?us-ascii?Q?OLMaFbVAFWqNrSEUiU5XaK/gaL//X1zYYKdeLnHKcWTc4PSbyi7/u8jgdNXV?=
 =?us-ascii?Q?UbWWLDfJayXlrVTGFC31ezEpxq8WYLmbNlpPBmyU5+CN9oY82hCJElBIyq59?=
 =?us-ascii?Q?3OgMmRrDxcQJM3Xp248/VuMP7c1R1sPRSLf2Tb6RNtPcuKH374Sh8uMEesxJ?=
 =?us-ascii?Q?45wtJTjFt2s7bS/wgdbkKsjvSU0fSNgWvn3/xRJeqeSzsUX//Mp4uqa2s1kb?=
 =?us-ascii?Q?AGR9V9kTKXSjvTsI1QFtQvctLW6Stc8VoQDJwbq/s7WtKvpmqSImqegF7ziV?=
 =?us-ascii?Q?xz5yhkUq8c4pGYPducJzW20pMO4ZjNQX6D7DW6qPBKQ+puMSLWNNGDsEKwF2?=
 =?us-ascii?Q?v4b+wGEM0L2OI3als/i12lSjj12FV9JpWTHf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XSVqszs/d5IfmUpwH7wgA0HbZ4Zio7QFkcKNd4dcFeXzMrqESjq+3hx/TI/y?=
 =?us-ascii?Q?5zemFiWF16nfOBn3Su5237xMQe2ZCWW52MjZAKFo08QaFPpblJBM2MzLjP3+?=
 =?us-ascii?Q?Y6nGjQrjEsnn2KkKUDy8YWwAMYWoN0byu1YUKyPYOa77VYUVUqhpcjnTTqwr?=
 =?us-ascii?Q?j4b81AD3444zuAZtcC9l6Wtbfj9ULb78bmiVEz1jsCrAmCsYWdOMRqU3Ay+W?=
 =?us-ascii?Q?ZyJh1emm0/tQgf+85595Cf+QSlxLgjhJ4VVZiO/g6YAAGw3L8LI8psVvlhfe?=
 =?us-ascii?Q?tvGR9FXif8xRHoYhC44ktsZyrKELp/jicwUiuEbGbLMneOcmvRG0RuMIagSc?=
 =?us-ascii?Q?3E+rzqBaRPH1UV9PZg9yDvjEr0ftrHWizTamGVaJCvBvRbu9nB9J/nk3GcjX?=
 =?us-ascii?Q?mejO40XrL0+UJg3Cwkcz1HiMXV4PG1Pj52A9QFUrgLyr2W9hXy7SLrZHGlzO?=
 =?us-ascii?Q?SEtS0hDaH2qnYFidVAhDDTSbpiFR4w94znFYrofvTK7YAi+UtHmGpErrTJ9/?=
 =?us-ascii?Q?W865kC12eYzHucR4hIOMMegSXOzLS2quH6YKJV7chi9ybXeB3lvn0/UC99xP?=
 =?us-ascii?Q?8fxKwNOkbRS0bVe45Gi2pQbUHufKQV4dwBRRlb0yKbSmAnFZDQod0AnPSodF?=
 =?us-ascii?Q?kbruEj4lE+pBmcLoFXBfMc7yFzXiE0XoZ2IvWdjxU/Vv8Wz6/8SSPzFkR9FO?=
 =?us-ascii?Q?B+rYlo36lMSqWtRMOSDouTQBWY5bTf/NIYN6iEvBw2TOL26CHk0b/z2jK0Bn?=
 =?us-ascii?Q?rGH32gMfW1TEJpnWmMvi5BEX80yGr/zDctTlGxM4bhJEYgz1gKcGaeO9IxyR?=
 =?us-ascii?Q?aVen5Tqz09NMM7f4HoqH/OHNpdW+VXV1otonROWn+gbsrIp9tGstlFARAexD?=
 =?us-ascii?Q?nYrHSLD6hk3wycE4VfRL5jn/pHelM5aI1sqSw4/rBiyP1fuWGJRzZBl3HVtX?=
 =?us-ascii?Q?PO+5UH0OPn3S9ZZbP6UQ+9ifM/qL5l/fv4FkkBIg39Ehnk7CW44sFBXpIxWV?=
 =?us-ascii?Q?h72jHKf/bGAfqhcSURB9KDDQiHXkUJL12KMfwnnHdixQbAySHo+7KbwcFR0C?=
 =?us-ascii?Q?lySdzBEjJ8vb2eKW4Utae53tUuVHPKwARo3ZNgCxS54QKyq/8MNgaG3oJ5mV?=
 =?us-ascii?Q?ZCelih381ejSC+jxU8XiMZtCWcfAO73v8vCsQZzFsqEHfJ/+eUBB/JU1g3Ii?=
 =?us-ascii?Q?mnK3bWyQoOetEOtPosUn5JSPWUI/wAZ7KP4uFZQ7UsfvCFdk56QPyvrckF5+?=
 =?us-ascii?Q?NsvGrbfpd1GGH9OCVsdqurRlowQ8S8E4jNw+Rb2ittAnMi7P7TrwDLgv6Q4m?=
 =?us-ascii?Q?RF6GhrQPHYEOjFIuQ+7T+qQElpTN6vE5r9f6e0npgp/k3ESPjOutfBDdZgCh?=
 =?us-ascii?Q?Sqk9IgaseO2dUD3jN+9geNvjOjbMh05FsHd/ilV4Y9Pxs40+NY8sReT5LZgA?=
 =?us-ascii?Q?OErFn5GcgFOpqAOyH7qGNhX2YWCLVm9mWTmoB61xZredJHsfcfimbshFPbeg?=
 =?us-ascii?Q?30JBr40XX7jyB2sjAniqey1oWyovoyii/VjL9kQaRGSAUx38M4WLuFv64Q/Q?=
 =?us-ascii?Q?3bLNxUYAPiFOey4L564w/o83DnBfdp/pJDe3itKO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5252b14f-6b83-47ab-bd16-08de01856d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 07:29:30.8765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWM8tnzd9vL+Pc3EqPqvoSSDZKJinKyUp0yoCUZmAE9Nh4gjdEncPuRBfBGHr8Pa3heQo0LRfo2qQC2LDSuH5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi Nocolin,

> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 30 September 2025 01:11
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> shameerkolothum@gmail.com
> Subject: Re: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
> SMMUv3 to vfio-pci endpoints with iommufd
>=20
> On Mon, Sep 29, 2025 at 02:36:22PM +0100, Shameer Kolothum wrote:
> > Accelerated SMMUv3 is only useful when the device can take advantage of
> > the host's SMMUv3 in nested mode. To keep things simple and correct, we
> > only allow this feature for vfio-pci endpoint devices that use the iomm=
ufd
> > backend. We also allow non-endpoint emulated devices like PCI bridges a=
nd
> > root ports, so that users can plug in these vfio-pci devices. We can on=
ly
> > enforce this if devices are cold plugged. For hotplug cases, give appro=
priate
> > warnings.
> >
> > Another reason for this limit is to avoid problems with IOTLB
> > invalidations. Some commands (e.g., CMD_TLBI_NH_ASID) lack an
> associated
> > SID, making it difficult to trace the originating device. If we allowed
> > emulated endpoint devices, QEMU would have to invalidate both its own
> > software IOTLB and the host's hardware IOTLB, which could slow things
> > down.
> >
> > Since vfio-pci devices in nested mode rely on the host SMMUv3's nested
> > translation (S1+S2), their get_address_space() callback must return the
> > system address space so that VFIO core can setup correct S2 mappings
> > for guest RAM.
> >
> > So in short:
> >  - vfio-pci devices(with iommufd as backend) return the system address
> >    space.
> >  - bridges and root ports return the IOMMU address space.
> >
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>=20
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>=20
> With some nits:
>=20
> > +    /*
> > +     * We return the system address for vfio-pci devices(with iommufd =
as
> > +     * backend) so that the VFIO core can set up Stage-2 (S2) mappings=
 for
> > +     * guest RAM. This is needed because, in the accelerated SMMUv3 ca=
se,
> > +     * the host SMMUv3 runs in nested (S1 + S2)  mode where the guest
> > +     * manages its own S1 page tables while the host manages S2.
> > +     *
> > +     * We are using the global &address_space_memory here, as this wil=
l
> ensure
> > +     * same system address space pointer for all devices behind the
> accelerated
> > +     * SMMUv3s in a VM. That way VFIO/iommufd can reuse a single IOAS =
ID
> in
> > +     * iommufd_cdev_attach(), allowing the Stage-2 page tables to be
> shared
> > +     * within the VM instead of duplicating them for every SMMUv3
> instance.
> > +     */
> > +    if (vfio_pci) {
> > +        return &address_space_memory;
>=20
> How about:
>=20
>     /*
>      * In the accelerated case, a vfio-pci device passed through via the =
iommufd
>      * backend must stay in the system address space, as it is always tra=
nslated
>      * by its physical SMMU (using a stage-2-only STE or a nested STE), i=
n which
>      * case the stage-2 nesting parent page table is allocated by the vfi=
o core,
>      * backing up the system address space.
>      *
>      * So, return the system address space via the global
> address_space_memory.
>      * The shared address_space_memory also allows devices under differen=
t
> vSMMU
>      * instances in a VM to reuse a single nesting parent HWPT in the vfi=
o core.
>      */
> ?

Ok. I will go through the descriptions and comments in this series again an=
d=20
will try to improve it.

Thanks,
Shameer


