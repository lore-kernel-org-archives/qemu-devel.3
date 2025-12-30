Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17118EE4998
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 18:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaeBV-00075W-NP; Tue, 30 Dec 2025 13:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaeBO-00074n-M7; Tue, 30 Dec 2025 13:11:00 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaeBM-0004Jm-Vs; Tue, 30 Dec 2025 13:10:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEmukSsWy6UFA61sC3/ofC+MqKG65z3qYer7qnLIMEL7OeMrOLq1mpE1Iq2Fw60KVURqoxcZ+vBP6JOKMRjkcyOVQDm0TcHpdKJhPPauaKkVf+QTWojtv00r1k40d7m2ckvKCfnDvYwY5+VfdoefSaurOAM8RP4BzrL+39WjZdVNbBlp4WUfLyrSc2kIoTZxwm6QvHeDgzbQZf/+lR2/M6rB2VPfMUCIsfyKX4KHiFhB0hblq7VmWVv+VUdGYKo0VSD16t+hqi3tfFPjwPq+nJ8ykShxl6BaVezxtU7ufpHwq/a58jPtsDOJCeC6cNh1lg/oazzUXCpYVMEuVfL2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0f15+GSBQrXPJ/LZhXqjExFhkGt0ZdTurLmw3nWLbE=;
 b=FdJeDGaDe0HgR8aHsczKDcmMTw2MjDWQISSW+MPeMpgoB2MV3fUw1MzrupNHofWejR4QVCfvizS9jMHYL5ffhMrc+/Ex/T3WMuOzfUjLAlbW/qOCpScC9Cl9wFxpwdifIGkfqnFmqRlsYn6VFmVDAyxyW0keh0btXx7kMT0jyaQLTlGJCsdWlXvKkuHyKjWmoPGmNtclEaewjeLAh8Sn/NsW0OkkIGobFN+lGYPpqR75H0Q4EtbQgBTu0VVo1RHCLYGwlPr/FAZjZvfHpu9QJAnV+exNwInWbAt924OD0k98ygUbFS1Ko38gwIgbvkisPscFSw4+H8QAak3pLoJJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0f15+GSBQrXPJ/LZhXqjExFhkGt0ZdTurLmw3nWLbE=;
 b=RR4HcRWSElrOFZgk4ixTZ2XnA/4gqFouZCthJ+RJaMJMFIycH0/Wr8T2PAGNfjbL2BZ+qzmEgMI5a+lF11OwDpgdQjpwNgpdvDkFIPUJcX0bdXsjHCwHnv9Ah+LlU4swO9dz0bEdCeA9RRezLT0PLxhX8D1yVD3NDmhTZItUKMmZFa/oqfTD5sM7eaoDBP75o7Du4AibmAqdHhLHQf6jbY0Ww8bZNTgKX7EpQpBYQEMfRKMUnDdFtA4K6AqHPuFwmU0bnduDrSVjiNQUZOobCI8pUYyTR0maY3mzUOPOAY6DOdXLm+lVkAgeCY5mcD+dPA+vRkNYCxAwwzR01jXGxQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 18:10:49 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 18:10:48 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [RFC PATCH 10/16] hw/arm/tegra241-cmdqv: Allocate vEVENTQ object
Thread-Topic: [RFC PATCH 10/16] hw/arm/tegra241-cmdqv: Allocate vEVENTQ object
Thread-Index: AQHcadqOqHtReOjPAEGmZGv5J3l5+rU5JMqAgADmALCAAIwPgIAAAvjg
Date: Tue, 30 Dec 2025 18:10:48 +0000
Message-ID: <CH3PR12MB754883CF90FB349D4CCD2126ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-11-skolothumtho@nvidia.com>
 <aVLbS6g+Sd6vfaFc@Asurada-Nvidia>
 <CH3PR12MB754807EAC29B50A82B3B84E3ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aVQRuUkeBroWIAHU@Asurada-Nvidia>
In-Reply-To: <aVQRuUkeBroWIAHU@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN0PR12MB6199:EE_
x-ms-office365-filtering-correlation-id: dad55771-1ec6-458b-bd0a-08de47cec2af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?hLqVSgpkhXGgRZ2QV0oMUH0+Lgf39usczFrMFOOyQOAMEnZt8d3620AnOsaM?=
 =?us-ascii?Q?HXHnIAgtio/mx7aAQaDCaPINU60VNgFrAfZNlyMEOC69zXY6GItC3FJNrQts?=
 =?us-ascii?Q?9ISDxreQAxcl+TZ+b3BCH3RU0NFu62D4zXYTUgbGgYbyBz78INLz9JGdQweT?=
 =?us-ascii?Q?Dc39Dsd5C53usKmURHu+lvDsqhkvzmjpTzrofokETIQk+2CVb99J3iAafHqc?=
 =?us-ascii?Q?nqNm3N91nCeutbxYkHBHieR88/swdZ+0Ql1F0Ti6V1PkGK4I+8vlHMBWyxJw?=
 =?us-ascii?Q?mmWzfHIRb4Dhkw2bfNhpmFfjAIaQpqEAQl/Nj7P282+chVFrV8qhrSHLWRaL?=
 =?us-ascii?Q?shEsbyOi02/bOSEpNeGZyYKVmO3di4oTBUKhmLF9tO+Y1pw7Y39CUpdOdmXa?=
 =?us-ascii?Q?uBgIGZ4sXCS1TkF52YwRzQWh2SODTZN1u/4l5VHPZ4qPL6YjnLPxZlh/zJ8b?=
 =?us-ascii?Q?w0qUf/2ZPbxD91su2fidpfDNs4JECvJe2d2DFBNgeHKHmUtgPRKNw4ESBoRN?=
 =?us-ascii?Q?ik9UUVwZazJb5a818l7uOX4M3TvL902u+0TDMDeKi2ShdixStiVbDq9ZJyrJ?=
 =?us-ascii?Q?dtxwEkajDmdb210Ns+ZDKqUqD4FCn1Xl39gLyLF1og0beWvENsp9+0YMAI4F?=
 =?us-ascii?Q?kPFA5n3qA1UrzMHXidZhOOFVaGV2PwVm9RG0B7ANXiuD+LPOapaFIx5wk1BC?=
 =?us-ascii?Q?cIIU4mTgLnRpYuv4p8C6VTebnhWgv8iH69PuHyQVJJKtGTvwri94hmW2JB5T?=
 =?us-ascii?Q?XVZAyCYlZTrv6Hyjmuf7ev4tplrX5cjYDbbYUHtSM5EGd1KOQnzKZDKzp0A3?=
 =?us-ascii?Q?3ea6DzYXDbP8jHLXfs1qdIZShIj8ZAop6pIz+YENiCGVzW0NFCq+ymKKpQIP?=
 =?us-ascii?Q?HGMROPamPrnV5DKNWuO0pzHrpuLK66vH+/5zXUCekLkahxkppO+nR6A/F98r?=
 =?us-ascii?Q?OFV1o91l+LI2hJRoHaagNwxj4OwVXaakkh0gOPcziBjpjl6MWWGgDaEx4ZEl?=
 =?us-ascii?Q?NI/fJgtiIdS8i+XM19NRV56yhcxivrArzGPmS8F9d14pbjK+klxnekh83qDW?=
 =?us-ascii?Q?dCv3hpYdm8/o97iJc7INO9pnOlWhBAMuWV7/DSKR7orDq+yQbvFqXcpDJWBm?=
 =?us-ascii?Q?dNonf9VOofwhhuf59/iElmiierez8lwy7ER9fFwxiLgj8WXu5EZOBvtfYE4C?=
 =?us-ascii?Q?2BdRK0DccFFpdDhEu47O7YUK57pbpKEc8JQs9I1Qy/yO7xjHwRl6+rWchASE?=
 =?us-ascii?Q?gfa+9EiTCZdvpXicdHDGt/pNQnbhZnsTfRVUocHIEzXuckYQPd3EXdDY6iWh?=
 =?us-ascii?Q?XdUoW3FAgeqaSuVVNyiVSUvr6brzo3m0OMF7hXRvVuD3FGlhlVOXJj0gHuOU?=
 =?us-ascii?Q?OdRkWVOuGvRD8LhvJ5bdSS4yT67HwObCnT+qDZl+fsk5e/7uK5baWUlrX6IQ?=
 =?us-ascii?Q?FnVnp6U+JQbusjTMN0PMlGJVNWWD7msYyBDAjPSEvbCLeVf3xzHl49KF7xZ4?=
 =?us-ascii?Q?rz5+AV9G4gbnvo/keOFe8RwgBGW8eQ828Fe+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LYU1rtrQYG0fbPoWvsey19+y6JhosS4HETY9/oUzreSCdsvFs3uLEmtUmoKl?=
 =?us-ascii?Q?vYgGoDb9HNb2XSvX4LwIB9sr/SC7dYNv8G9JpZnxhc0rMlCLm/+Z/Vl2QJNc?=
 =?us-ascii?Q?vB9svc2jdjSZBGKkJVOFeC/M0EZg2oSRG69v3UJ20X1r8zxtehbIbYB3mHFE?=
 =?us-ascii?Q?1HkLvRDD3nvCihNgJANUpbGGomK/jRv4ZM88Cesujt9kJ20R38SfjZoscdxI?=
 =?us-ascii?Q?q3LWCWJRRGuK06RQghlCPYssu+2CfSt/cfrALLjFIjTapm6Vcknut/deUFe2?=
 =?us-ascii?Q?NO4GuQ0G/B4zlTKNlU013v5OnmTmJbjva6Ln3o4OS73g7cbW7RxyVpMwJC3/?=
 =?us-ascii?Q?f4MZT8OSgddUUpu83hTHWnFfc1wP8YDhBS65zZWpzYno7fAEzfmGV1l72J+K?=
 =?us-ascii?Q?2iv53E4VDKQrBNeY9Ncg70cZejo6x8YBE8PztmGLd06drzFz10N7UdL4Wi9X?=
 =?us-ascii?Q?xOJxhc/JA0ZIjxOzu01o5RUcpm+LTMzAjo35wPjBhaQNTbPYbhBYn83pVqRc?=
 =?us-ascii?Q?768ByBdVUAzLHZ//orET/atgAYStbEVieZ+y1kaNVqOTBL9gMFOcPoSL7TvE?=
 =?us-ascii?Q?V2Jw76+jPJcnJUctbKxdrAtJt2muJqmfVF/mn9oU5S83rxKpEXDY23djqC6C?=
 =?us-ascii?Q?Z+WkRtrhC/EKgzdDo7zh6LPmmoDciAItU2PwjtHRYvSYeeYaCu9TuJvXgail?=
 =?us-ascii?Q?4ECzStuNOC99FhA85HmUisGvQMxialgiScBgCy//KmEn5ZYWbAMoACsWNdoy?=
 =?us-ascii?Q?Ahawtb61yMf+IYSxCAWMsKdjZCbCcK4/athyrXyQa7EGnN1pld+CL1admgr2?=
 =?us-ascii?Q?wp5XzZPYrE8qebv+Uv5gHZmkTkWvri5gAh9s2UuXUGPaljy/e7l2ZPjHjJtB?=
 =?us-ascii?Q?DEsC0dUaaeMHKPzepsIJRTSaIJItcuhkmN2r1wIdFexXvLQFsn6ee7+tjhNc?=
 =?us-ascii?Q?4d2IvaSFVRzGcciR7pDbau/CtpFpYlNA4a0mRAyNIXHJhJEC0I3aNRcdw5jw?=
 =?us-ascii?Q?VCSuyldYtwop+xSvVJFoCEncDDIVrI0NS4hrxLoUB2FppqXZLaH3c7RuZ0M0?=
 =?us-ascii?Q?M0taPZZ3pdqjzSNhqQ+5atiyGbIHpq9aNN2ikpP+nlqY7cBKtjYSh1O22jTG?=
 =?us-ascii?Q?JTkRpUhXvjkLO9QrVxTHGjrm3hAi4t/HS6b8xDQHyVKmNWAJu8OpGdBSPuDM?=
 =?us-ascii?Q?NxyWtovWN7BHRResPf7vlDplff+kAEctR0PZ2MmfZMSSzOjOUgEEtPgXCFzq?=
 =?us-ascii?Q?7VaeO2QgzIOUSo7mW4lCPSZMKdzWA1oFQ2L5mLhVUjJAMDixwG4t+5JCAm68?=
 =?us-ascii?Q?sDfWbkwz19j/qM/PcTem98zNF6ao9uFVQCGCuBLhNXFAOkN4BhMKpxGsfSSZ?=
 =?us-ascii?Q?lkRH95vNi69S6QMUNxiKUiH9wzXu5t77P8lQyW4SHbgsJLwlNMN8sHkHhNK2?=
 =?us-ascii?Q?AvSD7bSzLuQOnBuGpaEMyz8pPdSno7FbEI92hAgDQCjEtbH0mkP0Mhq0SCzj?=
 =?us-ascii?Q?S1zd3DmXadB7F7j0g/lhGlcFRDuDS46QgSQhYzIBSpTMe532OBLtizPdv0FQ?=
 =?us-ascii?Q?ztSnZpPl4jPVSFgrn9NaVzmuwr0BEzyrx5BGgqAeHJVzrTXHCTmoZvIHtVmr?=
 =?us-ascii?Q?1mU2qkVuU2qnONiKUR/HS9xn1zpY/4wLsDdpZ+6w3dmHtFxF4ubJQGMU/OJ2?=
 =?us-ascii?Q?234ocMMT/hvoWiJRbjH6KFX3HGua7yDV/LDMIVATXjVKiSv7dnh77KX8ZZY9?=
 =?us-ascii?Q?94xHupKhAQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad55771-1ec6-458b-bd0a-08de47cec2af
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 18:10:48.7914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRAuWkC2y9CImJyIEVWY52wqB6bAm14SnHkS16lPk/WOF1pgphMfORwEYaHv4NZWe9PPHyLUcCsSSWWbQKKXKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 30 December 2025 17:54
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [RFC PATCH 10/16] hw/arm/tegra241-cmdqv: Allocate vEVENTQ
> object
>=20
> On Tue, Dec 30, 2025 at 01:47:08AM -0800, Shameer Kolothum wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: 29 December 2025 19:50
> > > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > > eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> > > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason
> Gunthorpe
> > > <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> > > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> > > <kjaju@nvidia.com>
> > > Subject: Re: [RFC PATCH 10/16] hw/arm/tegra241-cmdqv: Allocate
> vEVENTQ
> > > object
> > >
> > > On Wed, Dec 10, 2025 at 01:37:31PM +0000, Shameer Kolothum wrote:
> > > > @@ -259,11 +305,16 @@ static bool
> > > tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
> > > >          g_free(vcmdq);
> > > >      }
> > > >
> > > > +    if (!tegra241_cmdqv_alloc_veventq(cmdqv, errp)) {
> > > > +        return false;
> > > > +    }
> > > > +
> > >
> > > I think this should be called in tegra241_cmdqv_alloc_viommu().
> >
> > Should/Can we? _alloc_viommu() will happen before the Guest boot.
>=20
> I think we can. vEVENTQ only needs vIOMMU ID. It's per VINTF v.s.
> per VCMDQ (HW_QUEUE). So, it should follow vIOMMU.
>=20
> Basically, we can allocate vIOMMU (VINTF) and its vEVENTQ even if
> the VINTF doesn't contain any LVCMDQs, which are allocated/mapped
> to the VINTF later via HW_QUEUE allocations.

But what happens when you receive an event from host during that time?
Should we just ignore it? Or is that not possible at all from a hoist drive=
r
perspective? To me, it looks like the natural flow is setup vEVENTQ when
Guest is ready to receive the events.

> > Unlike the SMMUv3 vEVENTQ for accel case, we restrict the hotplug
> > use case when the tegra214-cmdqv is set. And as soon as Guest setup
> vCMDQ
> > the vEVENTQ is enabled here. Do you see any issues with this approach?
>=20
> Once guest OS is booting, !tegra241_cmdqv_alloc_veventq will fail
> tegra241_cmdqv_setup_vcmdq while it cannot break the guest OS any
> more. Then, the whole thing wouldn't work although guest OS runs?

If vEVENTQ is mandatory we could exit the Guest with a proper msg in
case tegra241_cmdqv_alloc_veventq() fails, right?

Thanks,
Shameer



>=20


