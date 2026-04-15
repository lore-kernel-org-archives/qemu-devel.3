Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DCCF43834
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD1jA-0007lr-2C; Wed, 15 Apr 2026 11:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wD1j6-0007kl-Un; Wed, 15 Apr 2026 11:00:24 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wD1j4-0000W2-DV; Wed, 15 Apr 2026 11:00:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EioBcsabvOFVTv2XO18zymHNrq+zoK0gg4owo/Ov4dIaYvuFro9Dfghq0YaNcOKeNtflV54lBF26mf412tmvBpkddYV9Noj8uSnV3YsUeQxFzwvTJBEH4yEOKwFxRzETidQoSD1D9ZAWxXvKqZGqo1+hm2tcUjFdp3GeUmQOUNHHbfz85m/G0uprqOMfkkMrLPaJP+lurOvneLMhNAl/sFnjjU8/MUg/M1wX3DbmZstN4Z46vyLGaCdSlCQ/RJ8mUkw5QZKUeZ/2BsMrCaK7WWpJ5nJHMTEUyAbSOVeqg9ZlCP3LqzNqFioF0Zb02TeQSnYZsDwH9+I0w3WKjQpmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdz4LiL3VaA1y2Iqjf4iDV0KDWxM4MSaCe6JTvEe5/0=;
 b=qs2w7lk1SEUdvqJOJe8yOk8gYryeBOM/QR8YtkmRvKKt5WcYNHqP2nUlM6WjOufnmGx/PJblDsNBl4W5ZM1uSmomNOFBqSphZdqQ9GIIJTtzSO340skKHCLf/uIFYFIvI3D9aIeg3YdQnb0G3A8GldXVvPwch6c03sZTjkCpVcNSptddsI2K+Nuli+IymDzOBvwOnAw5WWg4rkMe0czyQYodMfFJRtHLkn/6J9qtQL29Lf8NmcnLA9kkNVWG+iutCsrQN+k6zJtnXNYH2SeiT2GOGpkNVaCAu5JilMt21R6msVQ7OypmvbQhR+ZwKWtAcxI5RBW2vYdTDf4py3bsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdz4LiL3VaA1y2Iqjf4iDV0KDWxM4MSaCe6JTvEe5/0=;
 b=Lht0duIhJkZ9R5a4WPhS3ARG2XFcy+Zj4JhAC5ZAbzEjb8MuZ69/Nv+2cnz0/AjZPsGOLIcx/3y0Od3QBodGnfNtYKe9XLVSurHyw5CZCTz4Zxs0D0+SIn4Wkjar7ncMvK8by5qK9WGaH0o1nTppidxyg61gZnXW5CJ3vyrZ2lT4PZMLuFTJPUZYWof8ydl2XhFEGm/ZkkFnabSA4rmXy3hkHMU0FloYr42BGDfkBbGvLCQlXn+5kwz+J5GstCTzw94JuDZiXIQlD0t55PI1u5vdYqOh725DR28O0SjFmFUxD47dRZ7K2+1kHDPM7C6mdC0FVj7WvCpL3oB25sBuEQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 15:00:08 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 14:59:59 +0000
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
Thread-Index: AQHcjrDucxlFepYcq0iavyq5T4OrZrXgktwAgAAHqJA=
Date: Wed, 15 Apr 2026 14:59:59 +0000
Message-ID: <CH3PR12MB7548AB11BC6EB44358F2548FAB222@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-13-skolothumtho@nvidia.com>
 <00b11b44-6625-4d3a-9bd5-6fd55f35a15d@nebius.com>
In-Reply-To: <00b11b44-6625-4d3a-9bd5-6fd55f35a15d@nebius.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA0PR12MB8974:EE_
x-ms-office365-filtering-correlation-id: a4dfac34-aaaf-4c57-bb06-08de9affaa2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: KibuWtQKWUFcd+V7fmyPjvMq5odviV4Y9166uVdWmCkFt5zbthx53bE4P1hsduGQv+1SfGXOeqfX7bmZsJugHoPIR7Wn3qfTyjX9K3wTCpCoRRfKfCNO/G37lHy69aUqdLO9LMRQPfguf+fIMK98YnoLcdEnDzby8ZTwJg9fXD+pNWYsrfKe6kRX2iG45m/dDOyW2ZZcSkpxtpym/k+kGayKuqnO6mlJWUyuCoExmKg6GfdJflwMtt9M8mn/zMOrm65SMz3WhXrR6fKqcCgkQNbHHpnW488LMR3Yfq8F3KJlbHrZmEyGAMxwsdmKF2NsjsVFWvtioZjZQVOPSO+vXjaKaWhlDIF9pIKdz0rqvtYu8s3g1l5EBWiAPm0VThDhSH1giNfLKQF3Z2guBE1/m3b+TFms4XFmspgeeFCVpa9BANIu3244MAN5njVGkK0sLgepIZ6g6ftosihMpE/IkZ7iThHg6rN6TAXRmQC0BsboUqLIYs9begPjijEifTFaYT8V4DsU2WBrsZbAa0w1n217K0YXFdEuPxdLWL4H1fFFyxlaZva/MRbHXsItsUhtDmrBMsQMNWye1EiIYYLQHPDIxPO+i364lwzDQBKuf1X+0ZFbEkPxy9rnWDEoDHEHQs5QDMbTBkv46xmJB2yh7hHYYetccMzRqax/WUd6xUhCEX/FTrOsvoD02Xf5DAeFLAUZCFIVs8y29OI8UxYl9D560sQj8bugCfLAEd2ev1FaNoDdP6GT6czmd6qp2cWHlMy6huGp3R5QOcfZ4aTt6fmXVvQr/J6kV8bQpZpxxcc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MTsbeuxTAqK4jZukMalhKyfN4NO9F1+aw9WlPwb4Hm6AW8MdZXssgUpC6yAj?=
 =?us-ascii?Q?A+M0yLnf9Ru9IY199DEH33pFVU5wEdpVokA5A6n5L+LKIXtL7Sn5wXzCwKKR?=
 =?us-ascii?Q?IR+xb4pWsc627atT/UYAmlYVEEJQrepg9dEXVulzEB2zySB5EhGSwscTPsC1?=
 =?us-ascii?Q?SLnu5Cwc8uozJ2SmitO/xMg4U42yvvyjkwuX1cMXGaHXdkJIgexgu/KbW88s?=
 =?us-ascii?Q?tfEDMI21JnzE3tq6HC0B22nI2iUpaOsHN29eO/bRjBQX/GVSIUCZuxRWm5kY?=
 =?us-ascii?Q?0Y3qp5KtR0A57Fkx4y7U+bKKCHsIsbYNugOo/GC3PVSbx/2WBj5ebkhLaMAb?=
 =?us-ascii?Q?smCOpUhRGAsJIwdnYqCjW0/c1fFI6pVD4Q6gNkcG/Xxc77FOe42PG0sVaIq1?=
 =?us-ascii?Q?aeebFbJmxLizv9ATSY/CCdGBEEPjoUxtV7TT5z3H+KjmNBalaPRkqie6yy1l?=
 =?us-ascii?Q?0XAjXxXhfYvp4tW7WHPBAp0cA4yPWX/hg4KjtqH34E+XDRHrqjdJTgNuDmb4?=
 =?us-ascii?Q?qK3nfsOFq9RPfsvA/v82hbGYU64LKLS9sy6YmaETGNmJ8SaKDGP3C/rcpQp5?=
 =?us-ascii?Q?mo1/hYclkpho1SwMjs241ys/l1y/7Wf/Y5YMxgKLqQsPwWnVYO3Ke2RVYGXH?=
 =?us-ascii?Q?UJ1x7BO+PnCV1oi8LHX1njwql6XmLsNqZ+ZBl/b3aHzbgZJ3LOA9kl91rkhm?=
 =?us-ascii?Q?5G+4BomhgTctl+ia11m8WezEfAl6hbvKR6Vnr854UZPxQzEr+vMIgkLIvLVA?=
 =?us-ascii?Q?bG92PcoA7i+YBdddvzZOMUDsm99/2CvxSltkHynSdDAVCsNg6c8At//eWlB5?=
 =?us-ascii?Q?nPnbf5UTynmQxB8jTflfq9FzbXwMwgVz4mfAEY5LuDrvSQZhvu9NqTEB1s3Y?=
 =?us-ascii?Q?EpOiqlLn2mHZiPXRg89U0FKEpd8ZaAgtbrbIuOXLg2DNWLLKW15SihKwAZqZ?=
 =?us-ascii?Q?3d+RATgzHd3vggEyPof9yvDHDbKYBbsxUaSj7623hkOM+fXqk7kABbq3ievT?=
 =?us-ascii?Q?MeCfPh0uRYomgcnz2StoXn3la+vO5MVLOjiQ21DIi1ACxBjrQB95T2XUY4ux?=
 =?us-ascii?Q?gq4nX0XcgLAI/4FRZhKmxE8DSLFw5WM25OeGqnKEG5yTTfqPxG16CO2of+oK?=
 =?us-ascii?Q?76cWl9lB4sRg6jjUpCMzg4fZdoz9ZWeASlVs/WCUJdx/wf/VAhjdfqk8Z8/g?=
 =?us-ascii?Q?l48cXnupDM55Q7MCFqTS8s/xoVZ6D6ZEKEvhexAPc4XvgXjQg3MUuPpkNfeY?=
 =?us-ascii?Q?0b8HJuTqpMCS2m/rtTA5MczCVYip3wJVdOrQBxBMZQiEdntLs8csSs9onP/m?=
 =?us-ascii?Q?IQE/bgsZLxmtg0P8PObAJwWHLrygvZFJS9g4rftNi5fnBx3KPqJiCoWF9w2b?=
 =?us-ascii?Q?2Z6JxYY9bTAmtM+Jm5iA0YZRvI4ee7OupZm4I/JjVzIkidGzf13pI+JQ4akE?=
 =?us-ascii?Q?kSEjmPvm5dQfZ9X6c1qkMB/cPEMNpUICm0FtGagwXn7K2HPz0MvvNO2FIDob?=
 =?us-ascii?Q?3EOAlS0C23u82wL4/ezEAKUyu6wf4ONrJG8r9sGk0VVQ8kGFlxFuYE3kOGoL?=
 =?us-ascii?Q?PtOIJ52vBradD/YgF5lKwP9KsmIkTPDrE3gJl5BYe30OvfcXUiK3zAYH25Wn?=
 =?us-ascii?Q?t5Dejni9hlSa+GuJBwgmr05OW4+slKgsl3hnQfaiNd7lLDx6IcJHeABL6rsy?=
 =?us-ascii?Q?n5/5ic27vIa8WhVVEO1qMjq3QJHZXr7tguP4RAap6d2IFCB/s7f9c0+UV1sH?=
 =?us-ascii?Q?OCFwkmtceg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dfac34-aaaf-4c57-bb06-08de9affaa2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 14:59:59.5305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRntY+ybkQHGUm/EvFPiprUGspr4oTwjb2C8l1QpzBeI9xyxK0hALVNlxcoc9uwFOiLrsjjS8EGMQ9bNbuz+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974
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
> From: Anton Kuchin <antonkuchin@nebius.com>
> Sent: 15 April 2026 14:03
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
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Hello! It seems to me that there is a problems with this patch and I
> want to check if I understand this correctly or maybe I'm just doing
> something wrong.
>=20
> Current master 11.0.0-rc4 doesn't work for multiple vfio devices behind
> the same expander with accelerated SMMU. Qemu fails to start with "vfio
> 0009:03:00.0: [iommufd=3D250] error attach 0009:03:00.0 (257) to id=3D9:
> Invalid argument" error.
>=20
> I've tested v4 of this series and it worked great. Between v5 and v6
> attach of HWPT based on SMMUv3 GBPA.ABORT value was added to
> smmuv3_accel_alloc_viommu() and I suspect this to be the root cause.
> More details inline.
>=20
>=20
> Not sure this message will properly attach to the original thread, so
> here is the link just in case:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fqemu-devel%2F20260126104342.253965-13-
> skolothumtho%40nvidia.com%2F&data=3D05%7C02%7Cskolothumtho%40nvi
> dia.com%7C0c6fd4366c8344b59fb008de9aef4554%7C43083d15727340c1
> b7db39efd9ccc17a%7C0%7C0%7C639118549639467993%7CUnknown%7
> CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOi
> JXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D
> fTpbtuKL5OXtvt0XpO12%2FpE7PIx%2Fznyqe%2B7TfBy8DAA%3D&reserved=3D
> 0
>=20
> On 26/01/2026 11:43, Shameer Kolothum wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> >
> > Implement the VFIO/PCI callbacks to attach and detach a HostIOMMUDevice
> > to a vSMMUv3 when accel=3Don,
> >
> >   - set_iommu_device(): attach a HostIOMMUDevice to a vIOMMU
> >   - unset_iommu_device(): detach and release associated resources
> >
> > In SMMUv3 accel=3Don mode, the guest SMMUv3 is backed by the host
> SMMUv3 via
> > IOMMUFD. A vIOMMU object (created via IOMMU_VIOMMU_ALLOC)
> provides a per-VM,
> > security-isolated handle to the physical SMMUv3. Without a vIOMMU, the
> > vSMMUv3 cannot relay guest operations to the host hardware nor maintain
> > isolation across VMs or devices. Therefore, set_iommu_device() allocate=
s
> > a vIOMMU object if one does not already exist.
> >
> > There are two main points to consider in this implementation:
> >
> > 1) VFIO core allocates and attaches a S2 HWPT that acts as the nesting
> >     parent for nested HWPTs(IOMMU_DOMAIN_NESTED). This parent HWPT
> will
> >     be shared across multiple vSMMU instances within a VM.
> >
> > 2) A device cannot attach directly to a vIOMMU. Instead, it attaches
> >     through a proxy nested HWPT (IOMMU_DOMAIN_NESTED). Based on the
> STE
> >     configuration,there are three types of nested HWPTs: bypass, abort,
> >     and translate.
> >      -The bypass and abort proxy HWPTs are pre-allocated. When SMMUv3
> >       operates in global abort or bypass modes, as controlled by the GB=
PA
> >       register, or issues a vSTE for bypass or abort we attach these
> >       pre-allocated nested HWPTs.
> >      -The translate HWPT requires a vDEVICE to be allocated first, sinc=
e
> >       invalidations and events depend on a valid vSID.
> >      -The vDEVICE allocation and attach operations for vSTE based HWPTs
> >       are implemented in subsequent patches.
> >
> > In summary, a device placed behind a vSMMU instance must have a vSID fo=
r
> > translate vSTE. The bypass and abort vSTEs are pre-allocated as proxy
> > nested HWPTs and is attached based on GBPA register. The core-managed
> > nesting parent S2 HWPT is used as parent S2 HWPT for all the nested
> > HWPTs and is intended to be shared across vSMMU instances within the
> > same VM.
> >
> > set_iommu_device():
> >    - Reuse an existing vIOMMU for the same physical SMMU if available.
> >      If not, allocate a new one using the nesting parent S2 HWPT.
> >    - Pre-allocate two proxy nested HWPTs (bypass and abort) under the
> >      vIOMMU and install one based on GBPA.ABORT value.
> >    - Add the device to the vIOMMU's device list.
> >
> > unset_iommu_device():
> >    - Re-attach device to the nesting parent S2 HWPT.
> >    - Remove the device from the vIOMMU's device list.
> >    - If the list is empty, free the proxy HWPTs (bypass and abort)
> >      and release the vIOMMU object.
> >
> > Introduce struct SMMUv3AccelState, representing an accelerated SMMUv3
> > instance backed by an iommufd vIOMMU object, and storing the bypass and
> > abort proxy HWPT IDs.
> >
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Tested-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> >   hw/arm/smmuv3-accel.c          | 156
> +++++++++++++++++++++++++++++++++
> >   hw/arm/smmuv3-accel.h          |  18 ++++
> >   hw/arm/trace-events            |   4 +
> >   include/hw/arm/smmuv3-common.h |   3 +
> >   include/hw/arm/smmuv3.h        |   1 +
> >   5 files changed, 182 insertions(+)
> >
> > diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> > index be09cf8b73..9c2b917a11 100644
> > --- a/hw/arm/smmuv3-accel.c
> > +++ b/hw/arm/smmuv3-accel.c
> > @@ -8,6 +8,7 @@
> >
> >   #include "qemu/osdep.h"
> >   #include "qemu/error-report.h"
> > +#include "trace.h"
> >
> >   #include "hw/arm/smmuv3.h"
> >   #include "hw/core/iommu.h"
> > @@ -15,6 +16,7 @@
> >   #include "hw/pci-host/gpex.h"
> >   #include "hw/vfio/pci.h"
> >
> > +#include "smmuv3-internal.h"
> >   #include "smmuv3-accel.h"
> >
> >   /*
> > @@ -43,6 +45,157 @@ static SMMUv3AccelDevice
> *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
> >       return accel_dev;
> >   }
> >
> > +static uint32_t smmuv3_accel_gbpa_hwpt(SMMUv3State *s,
> SMMUv3AccelState *accel)
> > +{
> > +    return FIELD_EX32(s->gbpa, GBPA, ABORT) ?
> > +           accel->abort_hwpt_id : accel->bypass_hwpt_id;
> > +}
> > +
> > +static bool
> > +smmuv3_accel_alloc_viommu(SMMUv3State *s,
> HostIOMMUDeviceIOMMUFD *idev,
> > +                          Error **errp)
> > +{
> > +    SMMUv3AccelState *accel =3D s->s_accel;
> > +    struct iommu_hwpt_arm_smmuv3 bypass_data =3D {
> > +        .ste =3D { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
> > +    };
> > +    struct iommu_hwpt_arm_smmuv3 abort_data =3D {
> > +        .ste =3D { SMMU_STE_VALID, 0x0ULL },
> > +    };
> > +    uint32_t s2_hwpt_id =3D idev->hwpt_id;
> > +    uint32_t viommu_id, hwpt_id;
> > +    IOMMUFDViommu *viommu;
> > +
> > +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> > +                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
> > +                                      s2_hwpt_id, &viommu_id, errp)) {
> > +        return false;
> > +    }
> > +
> > +    viommu =3D g_new0(IOMMUFDViommu, 1);
> > +    viommu->viommu_id =3D viommu_id;
> > +    viommu->s2_hwpt_id =3D s2_hwpt_id;
> > +    viommu->iommufd =3D idev->iommufd;
> > +
> > +    /*
> > +     * Pre-allocate HWPTs for S1 bypass and abort cases. These will be
> attached
> > +     * later for guest STEs or GBPAs that require bypass or abort
> configuration.
> > +     */
> > +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> viommu_id,
> > +                                    0, IOMMU_HWPT_DATA_ARM_SMMUV3,
> > +                                    sizeof(abort_data), &abort_data,
> > +                                    &accel->abort_hwpt_id, errp)) {
> > +        goto free_viommu;
> > +    }
> > +
> > +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> viommu_id,
> > +                                    0, IOMMU_HWPT_DATA_ARM_SMMUV3,
> > +                                    sizeof(bypass_data), &bypass_data,
> > +                                    &accel->bypass_hwpt_id, errp)) {
> > +        goto free_abort_hwpt;
> > +    }
> > +
> > +    /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
> > +    hwpt_id =3D smmuv3_accel_gbpa_hwpt(s, accel);
> > +    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> > +        goto free_bypass_hwpt;
> > +    }
>=20
> My research points to this change. Here we attach
> IOMMU_HWPT_DATA_ARM_SMMUV3 abort HWPT to device, replacing the
> default
> IOMMU_HWPT_DATA_NONE one allocated and attached earlier in
> iommufd_cdev_autodomains_get(). The problem I see is that when the
> second device in the same group initializes its default HWPT it no
> longer matches the updated abort HWPT in kernel, so device allocates a
> new IOAS and HWPT but kernel returns error for attach HWPT request
> because iommufd_group in kernel already has different HWPT assigned.

Thanks for debugging.

Just to clarify,  when you say "multiple vfio devices behind the same
expander", do you mean they are placed under the same QEMU pxb-pcie
expander, or that they are also under the same physical SMMU
on the host?

If the passthrough devices are not under the same physical SMMUv3,
then a shared vSMMU will not work, as the kernel currently does not
support sharing the nesting parent domain (S2) across different
physical SMMUv3 instances. In that case, the expected topology is
one vSMMU per physical SMMU.

Could you please confirm the host topology?

>=20
> How it worked before v6: during initialization phase abort and bypass
> HWPTs were allocated and stored for vIOMMU, but not attached to devices.
> Devices used default IOMMU_HWPT_DATA_NONE HWPTs to be properly
> assigned
> to iommufd_groups, and then at the end of machine creation
> qdev_machine_creation_done() calls smmuv3_accel_reset() which attaches
> same abort HWPT for all devices in the group.
> Could you please confirm my understanding is correct?

It is true that QEMU behaviour changed between v5 and v6.=20
From v6 onwards we try attaching a GBPA based HWPT as soon as vIOMMU
is allocated. And at this instance, we are not sure of the vSID of the devi=
ce and=20
cannot reliably do an iommufd_backend_alloc_vdev(). So, it requires the bel=
ow
patch in host kernel to be a valid attachment.

"iommu/arm-smmu-v3-iommufd: Allow attaching nested domain for GBPA cases"
https://lore.kernel.org/all/20251103172755.2026145-1-nicolinc@nvidia.com/

But if the above patch is missing, you should see error with the v9 series(=
or from v6
onwards) with only one device assignment itself.

Could you please confirm your host kernel includes the above?

If all the above cases are not valid, could you please provide the QEMU
cmdline used, lspci -tv output from host as well as host kernel version=20
used?

Thanks,
Shameer=20

