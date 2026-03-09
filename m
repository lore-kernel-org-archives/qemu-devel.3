Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD14FCA173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfIk-00035w-QB; Mon, 09 Mar 2026 14:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzfIQ-00032F-Hl; Mon, 09 Mar 2026 14:25:42 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzfIM-0001O3-4i; Mon, 09 Mar 2026 14:25:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZLUJUnoyn/JITZJirq2xEYtplUVFBJ33up9q9fiSR2OWG9QXZHzGhki2XPZSXAd4BTUFr7HRZ5tOhKrT4pdB5YJk55CPoniIhdFJkFTxPmigf9ggQIygSU20Jy9tBsXtZPkSULtlRl+B5TDLi4HrnaHU/KwcwQ/8Oadtej6FcTYQFt5ay7COd/dVmgWn59ieqKnqMqqfXbzjOrsZKYhVBz+GbOPqHs/0e1gdMKFQdZJTlgP5YidIpYUejRw9JNmX/07PBU+whUJe3FoiPbsNijNeLBX2qpXYjnzkwGsCzYaXyIhOUKQp+nzsYsB1+/sOHdIlGLjmv6pVUvwlcboWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mObuEcHIyrkHTF6qNEzCm6z7QjXPSrLljS81HjiVAiE=;
 b=wDKd28zeYmD8RVGB3hxo/ZtkPzk/pJtTt9LrJnLxQINzJBwL+eveSY5Ex9qh0BSeelINYHfksEc5Sr6raZSRVxWokWelt1nyvUBZhg5h+1+sRQYG6kS0+QRY9z9psNJyMXY5cUwcaIWCnZY101jkMLmd5Lsk1e3PouYiTFvtigfOb9aV+4uGLnNRA1npx9VxhP7uj1hl0OK5PfoCOQuC3lUr1+537pg6YAC1ykAaxbD8WQqHUQCUzWroVQ5YE/Vv/QiQjjizDwVXITNKNWGH6w8CTuUrg48KxWPx3Rx1Cp1/imZtomjOFoZTTMWJ6W9SCW/sbPX5g8ybdOvJmi2haA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mObuEcHIyrkHTF6qNEzCm6z7QjXPSrLljS81HjiVAiE=;
 b=tCE2FGXlO3cOzRaJ8Y2AxNznwsxqVJB9dZEfPHXrbtT+OtbFAa9aJiwpSrGBcrt1hIcy5ZD+7FlPJv+iUiAZeushRFVAXuA5tIcHGg5IWYGDM5nmgmnXQ/FGHEcUI44NcbC8vpdXP+mTzFL9OmPCPE2E7jCYAwXPTSwpcrup5yDMf6ermt89LZPCXz0YQd+vESrtLCFAHXRSmKMh8V8r806Kb2/1zy875GcaCldQBV8ln8plESMtUGH6fSUINWjxJHwBOxLZ2znGiRpmCw91Mx6/vJbgwbbJ9fPVT0qbzZtp/qld3ShhLdAcQzSZu61OE1U1gYnG6H6tFyXoM2kEyA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 18:25:22 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 18:25:21 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Thread-Topic: [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Thread-Index: AQHcpw4Fma2ObIHsrEy0JlTsVjwpILWmHESAgAAEM4CAAHFPgIAAATFw
Date: Mon, 9 Mar 2026 18:25:21 +0000
Message-ID: <CH3PR12MB7548B6C7F7DC206BD38B9143AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-14-skolothumtho@nvidia.com>
 <ed5ca420-94e5-4e9e-a2c3-f59eb6ea8ada@redhat.com>
 <CH3PR12MB7548F5610D7F339C5DAD0E41AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aa8M96GLFbPiMNUo@Asurada-Nvidia>
In-Reply-To: <aa8M96GLFbPiMNUo@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB5617:EE_
x-ms-office365-filtering-correlation-id: 6b465c6d-79d0-403d-d63a-08de7e093981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700021|7053199007; 
x-microsoft-antispam-message-info: GujyqjSohJ0ZruVoCBNOf68aeIrCf4jZik20uxouOA4Ue1Vzw+xT3cK4iXpdi3az/62hmJjhWYc3bM0SVV/Izd0sDl+PUWVilNXj46Fk4mj6TWblDgfURkLJoEPnafWK3UNGIZ9bN/sgS/gqH0eTLxc99n+kNB94J6PX3kTMo3te0eAGlprsOq2ti4uMJbMgik8gpALpwZF1fJYU+HJmqF17R2i5YvRuvqqtK3FQNEgtvHWJTAlTnHuInzwNqrdQ6gWAh3fAiwC6ntpDn311k4oKBU8LBIzp5lHLmfajqWYOxHKR4MJr5RQ68KSBxEEKevmZmIrY77d2dwYaqdXrU6Xrr22O5vpqi+Lnln/Icnud+aIV8wxKzH2CavsMnJ/MzTL1YMlHg832koM8TuhiAbUQ0oAm411BDO4P90/or/gDg1G+FBdsV76+CMsM3ieVMMrqCiWMa20a0j84sgnl2tggDWaDascxZz8PekGCK4Vrv4U+8H7pw7SzFBz+2hJkQdcAiDxfcoavGW0TGoliMvrO7JzoplOtQiAD5Jsu+uWvHmN9ZYIwp5Qpphe3aWUahxaZebshQeJ6rbDBN3YVlNjD0UQuJWIO6MrbNQUM5ivxVq2EgSaYBUz2R67hq/SDaLI06xSq4COR4bXsO3iPNrPtSQplkmxI3wSI4zvqDdDsFCmAoNysTsj7H0DLneKkYF7ps0RGVnB0N1sFpCJZ5WRZS2T/a8Mtn1jNq8C98PYhtAoIpbr+txK3hNy6OYmy588RLTXfqQlJ/sTu8jZn0M9cy0a72fEZC2Tg7/9iDPc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ycKOYhh2aMCruBRDvxJZy67EHgjQiwnsPjYQJ6wp5RrFJ0kQHE82pOEGjk3S?=
 =?us-ascii?Q?kLdv+S0RvTSQmvZqigvZBw1WndZeMfOKK1ao9VwyEA2iPj0+U8OmHMsmwn6+?=
 =?us-ascii?Q?5TdVT+H400y1xCdBDr3aU6Wc/et4dk4SSgNSNxNUjDy4zQS0iCTYOTmgR5K8?=
 =?us-ascii?Q?YIUQLuVaberPiQdTqHA1p0Uj/PTkFkYwEsHENIbH+9uzFjEJYctkuhDTF6Rt?=
 =?us-ascii?Q?4j5IVrWDqlhHu++1k7KkyYJogEY5XnHTbNoo+P2pxTe0ca3Up5X7Es/y6oXA?=
 =?us-ascii?Q?Oc621b5wGIaUWGIxpCIve5gNtw0BLeJ2ddl7hvG6kaE7h+eBoV+vRCSagpke?=
 =?us-ascii?Q?sAq9IeB0m75XJ35i8uBphqI+Vz1D38eMHiMDTpgn+YYp64JLHA/RcU6qRI+o?=
 =?us-ascii?Q?vGPiCbflsGEl06Xg9vIwZRi6sqGe9i4hZD+34EhQ6xXl2Ng2rHDwF+qzVbFE?=
 =?us-ascii?Q?7CDIpz72BhvIb2WIo4Dch4qvMEisPg9zn9d2eeAOjjvT35+/3XAX2eFio6w3?=
 =?us-ascii?Q?bDvJDt6mgKUudDzct5lE9J/Kc0riJrdVXfqWDU0DKo+aQDGVCpGmpQzQo9I3?=
 =?us-ascii?Q?hhlSldQvKBvca7VxDL16UedPBeuvaBUazRH/OkRNnK0Wq/muVIYNbKoCIWU3?=
 =?us-ascii?Q?oIEZHIYYEAI3d12yF8cqpBgThRJD+tRXlx3wxpQI7EHqrWBADXJqc0JunaS9?=
 =?us-ascii?Q?xH/6zKmyGhFCDPYLNoyZwsgblHHP9pynINgYdcLYf3joGag1UiHkdijpeEVM?=
 =?us-ascii?Q?2/UElUwTutJ97+UpNDXJihdjKUtWdRmoPfnVTHiBueV4ZZJheSTbl7rMvGgF?=
 =?us-ascii?Q?+MCJdpx3p/OH4stQmte9PpXSsy463F6q3vTjkKoMwU0sS998nUf6aeroUhiJ?=
 =?us-ascii?Q?7h2gEqFXsl0mqTwduOIUmmvYCOJH6cr+zvSLFDEu1jud9E/dDH+VAEL12uRb?=
 =?us-ascii?Q?C41K45BeJZUoIae/eOn1qekENWC74itfkbRIobHpf6IfCrs96W4ZmUG3vSSY?=
 =?us-ascii?Q?iB1+gut8VlWklHG7N898FQ5E1FIuiryU8fxU+ie8CjZ37X7k9JyRi/GrOXtF?=
 =?us-ascii?Q?pHFFCo214ywmd/w6MJbJ3pE5HHy+Pb3uYFNM4R/iUbEROKlx133ybnVWtNrj?=
 =?us-ascii?Q?azj6x6sFODD4Q/ogC+CHtCMTuepAu6TztIwuQNT/UDeAqLu+aNJE+f7spCv6?=
 =?us-ascii?Q?kWWlpptUvCOJQmarUAhUdqoGiSOzbvwEpxzct+xt09lKU/awtV635fhc1RL6?=
 =?us-ascii?Q?xQfgd3OPv8m1FSQ3NOWxcM5ihg+n3PxFrI8Rv2XtIN9c1raoUQtAOMBGrKMx?=
 =?us-ascii?Q?r6tMmHxbK4fbuBblIMcsTZCwqeiuWae+3+9dMhlXm3jXiUKnE7U0AaWesY3g?=
 =?us-ascii?Q?Bxl25qTSYRXtIng8mSpxbhgPW4BS4X9mOtseHgwx/4ZSpzYqxZs5s14Qw9Ol?=
 =?us-ascii?Q?BFjouP9rc7qh0WQkpvx+HAekSUd19ZEcBmy87WSXnJ1OFUhxw0xjuQPql/tG?=
 =?us-ascii?Q?Mi5uXJS5ytDLBkaTJ3ZCvkRepf7iYDLZKM08YlOTzXy31i7+FSSoSTDyHkCH?=
 =?us-ascii?Q?t+1i0LM7Yl7R5+YOzEXTm14mZ7ujUrV9uK6x9R+TCKn3Z+0c2HxKmZJeMFmE?=
 =?us-ascii?Q?rRZCemyAwbVS19k2t3MOJO31jE9ctXpaCDFU9TG4+idg4jW80lc95TDy2iY3?=
 =?us-ascii?Q?xR/qR31QnbRkEYb5YSnh6iuUBfwnzm0XNhQOIRAoSQis/ae2jitmvWVR+FHJ?=
 =?us-ascii?Q?0WoHzXrc8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b465c6d-79d0-403d-d63a-08de7e093981
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 18:25:21.7716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbP5ZbP0G3FMtTzjbjFlXmNnADAd1I5SfqQN1qXeIboR631MEewfKGNOmbxrIE1W1pSp94qDUI3D+zk5IE6T+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
> Sent: 09 March 2026 18:10
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>; phrdina@redhat.com
> Subject: Re: [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV
> vIOMMU alloc/free
>=20
> On Mon, Mar 09, 2026 at 04:31:22AM -0700, Shameer Kolothum Thodi
> wrote:
> > > > -    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> > > > -    return false;
> > > > +    Tegra241CMDQV *cmdqv =3D s->s_accel->cmdqv;
> > > > +
> > > > +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> > > > +
> > > > + IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> > > if the only think that differs compared to no cmdq is the type, ie.
> > >
> > > IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV vs
> > > IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV
> > >
> > > + passing true args, maybe you can just record the type of the cmdqv
> > > + that is being used in the smmu_accel device. Then you can get rid o=
f
> > > + alloc and free
> >
> > It is not just the type. Based on the type we also need to pass,
> >
> >  * @data_len: Length of the type specific data
> >  * @__reserved: Must be 0
> >  * @data_uptr: User pointer to a driver-specific virtual IOMMU data
> >  *
> >
> > And the above is implementation specific.
> >
> > If our idea of the "ops" is to allow easier support for different
> > implementations in future, it probably makes sense to keep this.
>=20
> Any future "cmdqv" will likely have a different viommu type. So,
> essentially this is just a viommu type override, as Eric pointed
> out above.
>=20
> What we actually need to expose per viommu is type/data_len. The
> data_uptr can be a union viommu_data in the accel structure?

So the suggestion is to get rid of alloc_viommu() and retrieve type/len=20
during probe() and store the data_uptr in struct accel . Doable, I guess.

But then we need to do something similar for veventq as well, right?

Isn't that actually bloating struct accel then?=20
IMHO, the ops way looks better.

Thanks,
Shameer

