Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37A9FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKc7D-000233-0c; Wed, 06 May 2026 09:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKc6l-0001zP-4w; Wed, 06 May 2026 09:16:12 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKc6j-0004IQ-8H; Wed, 06 May 2026 09:16:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDAjD6iiLO2b/eXqj/niq2qp6Huqw86+n3gPBkfGyKJJRy2aGdWQdyjIQ6sswi/8mqyG59cZEyO+kk9NZ50lqvftQdgeAQ1YOIRRaO0Iqdr0lwk5MwmNV6kYGmrRuDAls6GecZSWL61N3FpS4wRZgRW6HbkZneDJ1J95gwPItHjqA6iiTkAJPQUrRF3hfpBxVx0w7ZwEXG7oC7/VsqETFs3DQZuSwAS7/1sJCjz/BvGgPAmzgeobICU24fFQP1pgTTXVSdtcXveGWGTvVpIJ3OoaK5JfpWKgnhmTFumWbOPR69uUckUMOmjpDpH2PruJqINw6PybhY3vtUN268t6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7zXIAGO74LTJ/SN69x9fDbKJ81QpMnjXZBwus+wcgU=;
 b=x84wqH2VKJQUYuWVZejjNZxUOwKmlG8HpgV9BuIQ30egzQ9sWsU09+VHD41G+HijYSAnSZ6IiRRfVs3XnOzgtRsfbJUU11FJfSyzz8ag1MvbSSXXvBFbpHXF6+w0wFMBA3KO75ytyzGd6IyJO5h0gNHgEBSwpnNc/Oc/tNxsn0O2xN86N3i2fW3zA52wxUniI7wEySwPRrQVNquoxeqxI4lBzTK0BWYmtyaXVG0eqT5jwfsx/7bwiWRcQlTGDpMG0a/r27BvJFFGtZiwyn9TE0BpLWeCrg2Nd+nSNEDhXFGcBrt76nf/TOCC3lJjg9WHHPDPKN/ZoZoywWop8x6YYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7zXIAGO74LTJ/SN69x9fDbKJ81QpMnjXZBwus+wcgU=;
 b=LHmuDLgu5wXBnjIEzh4spx/V73L+SeKWrO30DXMREFoPNhFJU1zD3HTtpQ3hIwkIUtxRBEhKRF9mRzNW+RltiZrMwDrt+QmJrz/VPs8gaigJNgS57mCNHgMGKMvv9Sim0TFmqiVhUZvFowY20UBIiK8csmz81jARoJAYg22B3kYbTTx5SfIRxpySOaJ2opAKj2fLLLkhpqPXLnhMMmNlh/9Gdnq6b5C7UcaqrxNKA5fYTsxtT2UGo6seOLn6EsD+m7u3/DEmGqU7a3fTFPEFuwFe66pjxD/f8PM2tcT3BGr+pjPlm78tD6EqG9c7vsSy8EsOApcUQFM/nJJsvqKgMw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 13:16:01 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 13:16:00 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Thread-Topic: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0
 as VCMDQ backing
Thread-Index: AQHczMa/jfzTjyAD+0CcG7hTHjM1ybX+uL4AgADqScCAAFTSAIABAS7Q
Date: Wed, 6 May 2026 13:16:00 +0000
Message-ID: <CH3PR12MB7548E76E38625713F6AE9F78AB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-21-skolothumtho@nvidia.com>
 <afk+zBZLQx+x+ODl@nvidia.com>
 <CH3PR12MB754892989B2A76D3D3A941D6AB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <afpKfEvuT3ZeBSiH@nvidia.com>
In-Reply-To: <afpKfEvuT3ZeBSiH@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-Mentions: eric.auger@redhat.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH3PR12MB9281:EE_
x-ms-office365-filtering-correlation-id: abd617be-5c51-4f24-ef1a-08deab719e12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Rd/lfuRhLpN1648PSX9M6iqbXIRzbYlucnpvq1BE6IVC+V11ArBuA+b5dmB6k+e2UMin/VjuhP5Wu3+Jdh3yb6CT4tdSP1rdanyYh3RJjSAnTVcSYeGY96D+fCpOCnb5P69PqtzX5TV1A0ddpMHUEO862Hg77ZwiAQSkQkEFcSB+wEx58vfzNVJSHoarqr9ep3sTOdLi1hwh/GojekpZ4p9B5bXsg1wN5oYGoupKGFNRGnGbx0X3AETSz2RYJHedKN27N9iJ1m4+syWeQrqU3q1FQytjaJF2uO9gHRKC4I097XNo310mQmxVbpYZOZ8WaPH4HDRILhbbi2jJgHUZu08QyWwvXgSiUFl9lTsdOxPjzh683QO/zJrQyzqE9N1Y++nnNsBcJ8tINhYQsw41dG1alGDH52LeJEfkRxIBWbZD1DwOf9Wddg1b8vTKlCeNOr9BQNgZLTYE0TPoFvwg7v/i6z4h5XzKu509RAZ6mh+DI1wUQF56gOwD/tB/B3Vz0Apjd6+oW4cmm4poBFZ6jJqG/pphqN/OGV+eXywZDOUWfMihA3vca56XKiQpWaJfjbJAttM/sfjk9AGNp3Yc2mUlC1GPht2IJwsI2kRBXg28xRYeQvjHGRNQIKjb5hiGlf24ZfZ1hE/HtZAfcwiq1uBbcqy/E7SNL9i5VT9tu7U2z8HPfXK+hngpBcpZigoJV1LhUFAyVJa0u2vzvhm0+Gu+F0dO7OeDaAMfPd9yTsWBkM/Dtf70gMZS7Satzi2o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JpPVl/PB0vS50l3f6Pzau+BwnNb21wY0n3Kj/2OQzTYUoKUCVYspeUyKxmg4?=
 =?us-ascii?Q?O2mWo6VFrH8sissFVlwwzKS824H1zojCaFfgZGVR8lR4EzvkASCmIMscd62h?=
 =?us-ascii?Q?v+dLxE6IoN0gkRvhA4XxRA99SayoUuNsNUtMxN+6lutdHOmgY4oEHavpMN1Q?=
 =?us-ascii?Q?Ixzej++CHWBvYVJfGI1YnhHJ0+Efl+QhWbS8vucYT85xIVAuttZ5lElO+t3b?=
 =?us-ascii?Q?OMjOJ7AG2g5Kb4+NDYL636toWw1mBougBdRKKOBDkkHLUfMC1tuPU4rPNrE2?=
 =?us-ascii?Q?I3sHDVkGAM8yxFcPSa1fEyfA+neeYdgSlMDuelbA2UuP4gpctNgq94Vw8JSq?=
 =?us-ascii?Q?CjWKwdOFLnBLGMI7cMYOMo3NFocpDWvcbdZaLwnBEukLV54mYDRfmmYE2oVq?=
 =?us-ascii?Q?Jd9T4iqw7yY7OEiG034+Y3OeOnSDz2Hk7ZgSM6ABLsnrMxr9T2FEYyuGqK7O?=
 =?us-ascii?Q?0tGEdRzwrdOdborYNDltydxtNi5HT8XSQkHfNqc6qyTyhc9zhx10nxi6vX/A?=
 =?us-ascii?Q?NHZWPAtQRiGw8Emij7pe/lkcbOzFrbiZpfFMSlzBzmtEHAs7ADfFbrZkGsBG?=
 =?us-ascii?Q?8zUGlQhwHdS+MChiyf4rffp0O5nWQS4NRam/r9fD6SuYB7etY5eTs8jy4CYr?=
 =?us-ascii?Q?mCfycNkGkjsYSkwH2Se36mM+CV+xpLK/L24mJWWlaCYXecs5HWwQsnofupZr?=
 =?us-ascii?Q?JF9ezEwcyc6hAQI2dz9Eu/5Ab2Tif7lqGifcmbe/qTyuYS5gh08Is8WJjIsM?=
 =?us-ascii?Q?V8TEQoxzoRmhmMMRjNDKAdJYi/MQ7fpWgHrh4tGxcoAzA5Bj1RtsFtX8pGU2?=
 =?us-ascii?Q?YESAc2S9X9dpZTz1DXQey2Kg20tBxJHR/CbHmIA6bgHRG+m9N+LN9+1AP/b5?=
 =?us-ascii?Q?ES/6nAMUdw98OGG32P4clfP1oP15/Q+0VbNchCubwW3Ep9i0SZCleL9wNAQl?=
 =?us-ascii?Q?9P0jg+kwCRQ5JXfHd4px5Wq9JY6vz5b6MNpafVPPPnglaqPxqZhAfMbAl61a?=
 =?us-ascii?Q?GwV2bTTikqI9NQgNBAHZs0m/98drph2rlTSOQY8CfDgzVvEGEhkYQHl6cuCg?=
 =?us-ascii?Q?aQcrJQbjs6EWNmwzkNSvXDc7gN5NEHGY+R4uAi3J15rgqRgNYcFflImCilCf?=
 =?us-ascii?Q?R1c9r4daS9+1o3f2i58Q1LsFA1wYxBOL9tpK757qYYycTrWFON4MmvYHQ/c+?=
 =?us-ascii?Q?GyqkZk+LkiPfezHaUp+YyohQxMaKG65y8H0o3UpI3oUcVsM2IRqNS+44hGk3?=
 =?us-ascii?Q?ZNgZFuwgIFCfJ8Tl7rCjtzRigNIk9xygF3w1F+ZVOvfF6YBL27Wcst/QMQQn?=
 =?us-ascii?Q?Uzthj2CTaaet5sADqHu77GZYazcreLRf+Q2brUZ09Db5B1N+YpFIeMlGEi2j?=
 =?us-ascii?Q?05HScnR4coehgyf/EkDneLzsOTxJouYnKBmh/SMTJ+B4GYRI1vXDwK/Bjv6t?=
 =?us-ascii?Q?aYwAoKmjqLCLZl7vOnWYVr0+0wY4HogvTS5ch6v02aSQrRMiP0+iB8XVf03/?=
 =?us-ascii?Q?+XddZ2zK27sLJ1gy2saHUv8T3/2EyUwZSEV5TO3fQ1jE+C56RTcNplRFfHBs?=
 =?us-ascii?Q?3ve29PD1ueBpxSwgyFirMHXmvT/pi6hIhpo2dtnzZbyCQ7es7uBzTyf8cGKv?=
 =?us-ascii?Q?tVmI2PQMoOc6y/gYAcFmWgva9eH2gP0jRiId3rg/4MFVPQt++1pFNClBmtmV?=
 =?us-ascii?Q?vKn6yuqBLHEQIAxlOwB3XZZLthOEHJmN9w/cV0D/2ZvG/RzHl+Vvfr8THwyr?=
 =?us-ascii?Q?EbeGMuI6nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd617be-5c51-4f24-ef1a-08deab719e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 13:16:00.4564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZeQsX/MCcLsgJm74wDmS9ySlDSU3RhX0e6sAJGoHVoG2adCxZp2GInjOkSxfeqcFs8QxK6+5gJD+6YB00yUnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 05 May 2026 20:52
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>;
> phrdina@redhat.com
> Subject: Re: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF
> page0 as VCMDQ backing
>=20
> On Tue, May 05, 2026 at 08:13:40AM -0700, Shameer Kolothum Thodi
> wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > On Wed, Apr 15, 2026 at 11:55:41AM +0100, Shameer Kolothum wrote:
> > > > The pre-to-post-alloc transition is triggered by the BASE register
> > > > write that initiates IOMMU_HW_QUEUE_ALLOC. No cache-to-hardware
> > > > synchronisation is needed at transition time. The hardware mandated
> > > > init sequence requires BASE to be written first; PROD_INDX, CONS_IN=
DX
> > > > and CONFIG.CMDQ_EN are programmed only after BASE and are
> therefore
> > > always post-alloc.
> > > >
> > > > Any pre-alloc writes to those registers update only the register
> > > > cache, which is discarded at the transition.
> > >
> > > Is "discard" the correct action?
> > >
> > > Guest OS might expect HW (VM) to retain what it writes to those
> > > page0 registers?
> >
> > As explained above, I reached that conclusion based on spec p.174/175:
> >
> > Under "Enabling the Virtual CMDQ" it specifies the init order as below:
> >
> > - Program the VIRT_CMDQ_BASE
> > - Init the PROD_INDX/ CONS_INDX to 0 or a consistent value
> > - Program the VIRT_CMDQ_CONFIG to enable the CMDQ
> >
> > Since we set up the HW QUEUE on BASE write, a spec compliant guest is
> > expected to program the Page0 registers as above after that, and we pas=
s
> > those writes directly to the VINTF Page0. There are no GERRORN writes
> > before HW queue setup either.
>=20
> I don't think we can make an assumption that guest would follow
> what spec suggests.
>=20
> Could this be a case:
>  - Write the PROD_INDX/ CONS_INDX with a consistent value (0xf)
>  - Program the VIRT_CMDQ_BASE
>  - Read the PROD_INDX/CONS_INDX, expecting 0xf
>  - Write the PROD_INDX/ CONS_INDX with 0x0
>  - Program the VIRT_CMDQ_CONFIG to enable the CMDQ

Yes, if Guest is not spec compliant then this can be any order.

However,

>  - Program the VIRT_CMDQ_BASE -- suppose we call setup_vcmdq()
then kernel will reset PROD/CONS, right?
https://lore.kernel.org/all/20260129224341.1594785-1-nicolinc@nvidia.com/

Again, the question is whether we should handle all these non-compliant
cases to prevent the guest from shooting itself in the foot, or simply
propagate any hardware error events due to the non-compliant
behaviour.

On the other side, if we discard the register values, the read-what-you-wri=
te
contract is broken.

I am not sure what is QEMU guideline w.r.t a non-spec compliant Guest
behaviour.

@Eric,  any thoughts?

We already have a spec-compliant behaviour assumption for accel
vEVENTQ support, as discussed here:

https://lore.kernel.org/qemu-devel/CH3PR12MB75485AFF456B4133B9FB3770ABA0A@C=
H3PR12MB7548.namprd12.prod.outlook.com/

Thanks,
Shameer


=20

