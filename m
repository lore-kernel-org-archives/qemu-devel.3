Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FDED778AD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 18:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjLoQ-0003tw-OY; Fri, 23 Jan 2026 13:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vjLoO-0003tU-Ko; Fri, 23 Jan 2026 13:23:12 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vjLoM-0000aS-H5; Fri, 23 Jan 2026 13:23:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnT3LNW3W+e9Dki3Tmrp27R+x5P6uikJ/qh3Y8vNIJBhf5IWeHYMiQFy8k0xmeCPvUcoTwiWEpIOD0ceieBHajHaZg0Squi8oRmgMFx3m9XBSLguzB2/ExgSFvkvXWEE/iS/tsfs5NbDO5V06gjbYdTEJNio7/hckNM3wKPf+Vs+ji60RtsfHh/o7hVsjS0uBTrFiFBcbzQkSfR5+jo/mis1tMzYQT6hsg8NdlZpN95VH+ZRhAA4eHIuhToXWqU8cTdaJgCEY/uhBQL81hElO+7t8mq2SZ+6pICu64sFnMsszam7ZIv0rMiqkHQ9PiRS3T4fxV0t5/45D+4DEIcfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr7MHs2xd41yfwppNzhhxrpgXnQ3wksGfFMDKysBWVY=;
 b=vYueHHm7XeGsOZmBqhPe4iV7d+z03lcvAe6GNpkm0uOQN0T7X5PbzDPZnx+GY0/TYTDSCb4S29oKjEGrwr/MSOZjR6HYJqCd9PXDgrBE5mIhpEVz8Vv2sZ1pUjwAEhWoVtmeYj+j0eyjX/YiPTBqurq6r8f48mNQQXZdbLzUUhGd5wzKxiHoB5FfrSSUZ0Ttbfzln/4qdz+T6qDmGmUDM/15/1yMwEVJ90+e5T/mzr0oiL6vFwznLIl863Em8Jm3zbu+aZcsFi0P0AW/XnkNWp0iIHseE14GwVGNU5gAgd9xpi6H1PtB/4BxtSrp8yQnsUCwdNQ9FQ7xwU5mTa0p7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr7MHs2xd41yfwppNzhhxrpgXnQ3wksGfFMDKysBWVY=;
 b=EwaU2IdBcDJ5YO+PvH0EElSEAHH0/6XZtWf7Oo6rPSwtDwRjc7Zs318Vi9/gZhmFLACPombp+RODXUHGbdvV/v1EPxPcOoAe1DBicEzYBG/2moUe+d5/lVn9B+pSfKD0HXtsfQT1UAVKw0WN44x4YvFxW3bNXwpvHOPEpt5zNMvXbMn1KnjFJtXIczq7I8UElxVDe/s/4cgoP+shnEPOy3V5yqhYxkW5t8Ldl90BBFYxeqbSJ2BiWfAsLgAKaZMfDsCkG2SKkNXDHAlgayg3KDGRwnpDgoiDRiMMl5x4RzZ3TCVe4CiVQZGVPS+4huG4qkRSOoUs7yM7PwQgJWKg/g==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 18:22:59 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 18:22:59 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Eric Auger
 <eric.auger@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Nicolin
 Chen <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHciv8RXDVv9+SEiEKA20nh1wOeY7VfZT0AgAA/SYCAAAStgIAAAURAgAAzGICAAAaFgIAABVUAgAARidCAAAXzgIAADu6g
Date: Fri, 23 Jan 2026 18:22:59 +0000
Message-ID: <CH3PR12MB754823CAB18042F434709A58AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
 <4d1a883b-5465-45af-8dcc-eb905f552c29@redhat.com>
 <20260123114149.000065c5@huawei.com>
 <CAFEAcA8RFqO-U5ayU2u=dNhjHCj=1mJiAv26QihfqNfqQVq1Lg@mail.gmail.com>
 <CH3PR12MB75480D0CDE889070E1F4C448AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA_8Zd1_C+94wj2c+pJk3ebFT5_Zgt1Ww0qxzFqW=F98xA@mail.gmail.com>
 <CH3PR12MB75482DA817149816D5CD485EAB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA_w=+RHygwsSQVvE6XU44d6+hgKy=bqdD08aBM5_xyn=Q@mail.gmail.com>
 <CH3PR12MB75481DCD5A4A890617429C55AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA-jxKnmD=8A8b5Rur0F1+_5w+JHY2yjkZQvD4wbhMwvkw@mail.gmail.com>
In-Reply-To: <CAFEAcA-jxKnmD=8A8b5Rur0F1+_5w+JHY2yjkZQvD4wbhMwvkw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA0PR12MB8930:EE_
x-ms-office365-filtering-correlation-id: 8b2d3a3e-ee4c-4a9c-aeec-08de5aac6ff7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ZnVZRTFqbWx5L2RyWC9tWUJYaEV3d0VPRVFnc0FPbnUvVUNvN2tTSlFyU1dm?=
 =?utf-8?B?bHUrQnQwNDF5cHIwTDdiU3REL1BLWDBldXk2WER3a1NmVjRaMUNLWUR0YTVV?=
 =?utf-8?B?a2dmM2pzcTV2RmFkTGxucEpESjc3K0svVFU5WjhtVTB1dGkzajAraVRGUWEv?=
 =?utf-8?B?QVk1RTZqUnQwMjV6VEVxZXhiQmpOM1k1bVhQYThxeC90cUt6SGVzSUNaMXdR?=
 =?utf-8?B?UnNtV2c3UHFveFgycUZNSG50bWVHVk9oMmM1S2ljTWFrMVJQSXBWQ3hvZGhE?=
 =?utf-8?B?dkFtYUlGZ0V2WlY5aXRpUFZPOFRvcC82QlV6Wit2VktRd2VuejFMdXh3eE4z?=
 =?utf-8?B?RkhqTzY3b1lid2orYTRpaUVjdkhuN1lJM3VnbVRpRVJsQXp5aVEwUEYzR3E0?=
 =?utf-8?B?cDJ5OWU0YW9Ga1VsTlR6bi96WTVuL1ZBRFNCekVDNU1oR080ZXF2aFk0N0Rs?=
 =?utf-8?B?RGhVYlNWWDIzMVBoMHBZOS9YdldXRkFlc0ZIUGhjU0VIamo5bHI3QU13anFk?=
 =?utf-8?B?Skd4aDFIVEh0SUpsTDBMb3ArOUNJNkI2TDdFcG5Ld2l5VDNiNFcrU2h0U2ww?=
 =?utf-8?B?LzRBMDh6QUJhZWR2ZG1DWk9GOTB4YUFmaDZ6THArd0dBdE10RmJqRno4V3d0?=
 =?utf-8?B?VzhSdUR0WGthN05rMFVOSWZhUm8rektPbDVpUk9GWGFKdlllOFFjbzJpQjBm?=
 =?utf-8?B?NkNtVXZEaXByeUYvbHBUZ3Z5YXh3NmJCcWpDL2MzY3I0cWxXeVpWWU82aFBK?=
 =?utf-8?B?alFMV0hKcDNRcnpESFdGaDh2WlBYTEZLaG40YTg3VHJjT3BYUkZoNDhURkJW?=
 =?utf-8?B?ajhBekd2dXdRdWI2Tm9XRGx5QUd0MFZlVy9jVGllQzhnN1NmTU91b3RkMFo1?=
 =?utf-8?B?VVkwWmU1VmZhVENsM0dLc3Z1dDByV1pDV1NhN0U5bTZHZDRxeHRzaWtJRW0w?=
 =?utf-8?B?MjBtTDlpb2tlQVU4V1c4Rnp2Z1NPYUExNUlqcGdtMmF2TzEzVE1LZXNtVkVs?=
 =?utf-8?B?aXZndVQvZU1rcXRnWWV2U0ZjQk9Gbm1BSmQzRitKQ0VSSTRRRkUzTDQyK2Vz?=
 =?utf-8?B?Y2dlb05JbWV2dUU4NzhLbVM1VmdHRU5qRk85a1RLL3g1R2ZLN3JURjZCaldw?=
 =?utf-8?B?ZWowVUZTUThjek9BSDBHKzI0bm96ZHVKV2dvaHE2RVRIajV5SE9TOVM0c2NX?=
 =?utf-8?B?K2lVQWpxanRFL09rNUtxOFUwekwxRysrZXlQVklYYkJvc3liNXEzVG5DbFVx?=
 =?utf-8?B?VWdiY09wV3gzVURTLzBiZ2RhbHJxSW1Kb0p3ejBJRnVjUkwxdUVEb0tPMzV2?=
 =?utf-8?B?S0hkSHFtZFh1U05pSk1McDJNaHZGaUUyRG93eTQ0cTFqUllOMHdLNE9mRkVa?=
 =?utf-8?B?Y05DcUlkL3pMRzNSSFNuQ2ZBMmZnZTR0OGZGcHhoQTFPU2x6M1I4UFBlVTEx?=
 =?utf-8?B?cFQrazFCeWRwNmY1V1g3SzV1bXJKUlpTUFRsSHV2dmlycmMzSUVlREh0VzVv?=
 =?utf-8?B?bCtEUlR6eGNCb2tNdU9pSklDZWlWMVZhMUhKT0o0NituNU1hdHMxQ29yVDZ6?=
 =?utf-8?B?TTE5cjI1a21MQ2lCWWVrZkExVVhXNmdESFB4NWlGYVI2UUlmL0EzL284bU9r?=
 =?utf-8?B?bll2VzV5ZXU1QXh1UG4wdTVFSzhxR2VQNThmc3NEZ2cwSU9HUGxJa05TK0lS?=
 =?utf-8?B?aUVyVjFhVDgxODA3UVdKaDRPTDVYWUtuNm92dGdZcG9laGxiQlBRSGJWNCtx?=
 =?utf-8?B?MXVYaXZNOFpSemFQemwrVjNhWjdheDF1NFdKdUtTTkExeDJqRDVJaitSM1Bk?=
 =?utf-8?B?d3ViaEZ2alJ6RHhYZkNNTEFub1dhZFFXQUZPL29GSFBzUyt6NHlja0E1V08z?=
 =?utf-8?B?V3FWenRqWjdCTTM1bm9CM2h5QWtWejgvWHBKUFA1UHBxQjdlRnJiYlBjMmFk?=
 =?utf-8?B?QXFFbGJ2K0pKa3lGemtjMEF0dFU1TVR3R3lpYlRnaUFxYjd3UTdsSnl1K3ZL?=
 =?utf-8?B?bnZTVUo3ZzdtMmU0MGhKNWlZOGlaT2NEMjllWW5TMVZKSU95YkF4RU1vNE1o?=
 =?utf-8?B?UWZ6ZEJad1d4YkwyL3pzcHZOS3crbGI1ZFRHN0tPTEoxQmFkMmVLZktUdkxt?=
 =?utf-8?B?OURjbVNxcDExMHkzTGZiTFhmdFBLWVB0dVErSERoTkJMYjBaL2pLTTVBMWFl?=
 =?utf-8?Q?fQrHNb85BOe7yCPNTVnmLD4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0k4YnZvbTNXUzFabUpzM0hDcUNnZCtSYWU0cHo4MDZjQUhMV1lPbzl1cUty?=
 =?utf-8?B?YWpnUVEyU0oza2h2ekNpN01Ib0hZZHhycHk0Rk5QaThVTnFxSzZFeTNrMDVi?=
 =?utf-8?B?amo5MVFLOWd3a3pjcWN4MmhHRjlkZGhzaXFjTi9lanlObktGdFhETTFlSmxO?=
 =?utf-8?B?cDVQcENLbHQ4UFRUZmpCQmJUWERtdHdmaWw2d1lKZXFnemlNVVdqSWRiTkpo?=
 =?utf-8?B?WWtVR0Joc2hBQ29XbjR0UnliaUFrMVRZK0p6SVlDM1dYeE5GZUxXeXZuSkZp?=
 =?utf-8?B?Z3duQ3J2ckVuS1RJNXFwdFRwbjhWNFJobEJLRXNnelRoY09zK0NBQ0R2U1pt?=
 =?utf-8?B?UzY3NlRtUGhEWC9JYkpPUTloN25PMzgxRkJtMEJ5U1dmT0RSaWsxYXU0QWE2?=
 =?utf-8?B?c0QvVmdnYTE5L1RhQVVCbkVGekVZYnN0ZUxoTVpMcHF0ZU5tVCtGVUZndDFy?=
 =?utf-8?B?ZHZqbzl3MVZHMUF0WGRQTmZXZVMyZjc1bDlacXNjWWVlSE9hamphT1VUeVp2?=
 =?utf-8?B?Y1FWYXBwNzU1TUFBZHhiOGxBNFFGWlFYYno3b1J3dUNYSjgzNys2R1dmOUdT?=
 =?utf-8?B?MklUeVRkQnpDcjdDSmNrQ2oyK0Q0dndWblV3RWJjb0lZRDJBV1V6KzRLK0ln?=
 =?utf-8?B?RzR6L0VWa0VTWnlGbU9wRlNpUytiaW44Tld6bW9aMjBpZzFWZTlHa3ZqcUdh?=
 =?utf-8?B?U1lOV1FSYldEbk9IRVhCUjhkalZBdzNESU8xQWU5VCsrZVJIajAycENQWnh3?=
 =?utf-8?B?eGdmQ1Vqa0c1ZHNjZm9QamcvQ0trZC9DcmxwYnBLM3JYN1U0aU5xMkw1b0o5?=
 =?utf-8?B?Zy9sSVQxbXpadGlkQmhXL01WV0RaYnpRRXhYYlM1NWtSRHgvbHgwMFJSOStp?=
 =?utf-8?B?YmhwdUM4anFlOHYrWTJkL2dxTnU1aDZCQlUybkZPWlhOSVZqZVRzNzdCbFlN?=
 =?utf-8?B?cEV1cWFkMzhIaWpTbmUybW5LRnk5MEFOT3NSWExxL0VjQTRqLzdGUDgyL0J6?=
 =?utf-8?B?RkdlaHh6NytVZFlEczhVVVlTNHlGcjVGOWVGQ2JHSlYrWld0M0xGaUoxTit5?=
 =?utf-8?B?ck12M0J0bFVveU9YZXZHbE40b3BSSEVKSnlNWVB0NHhKeXRmaHIwamx5bVh3?=
 =?utf-8?B?MmRqcVVURW13dlpxNi9ZOGVlakhiUnp1WFRMc1dRcU9TeUcybVFwYXhHTFRp?=
 =?utf-8?B?c3Z1cGhDNXY3VXAvaWQ3NGMxYVJ4NHgxa3VjSmM3RXIzV3hURmkzVVFwM2d2?=
 =?utf-8?B?YXBheWJQeUtHTmlQdHo4YWRmU2NvVjE4QktJcGdEc1V0SDlkb3ppdlBUeVA5?=
 =?utf-8?B?dnF0cmtTTTB4L1VIQmJEYkkwKzNJSDIwOHh3blJ1dittRk12Y3AvdE5HdkYv?=
 =?utf-8?B?dXBoV3FqcHlhQWFqbTlnY1VuekdLaHRSa2RjeDVMR2hNSGpqeDNiUW9kQ1lW?=
 =?utf-8?B?NUJkdTNxdENzZTE5dnNOdTdTSGVZMzRaWXREWERtaFJmRVZLRGl3OWptUWdC?=
 =?utf-8?B?djhRQWFXOWpReXRIOG1LV3UyVHlYWEdSaThXcGNUQ2w2MTVNQTExRGk4SXlU?=
 =?utf-8?B?N25uV3pOWHplWWJleXBYbkNqQTNjSWgxUjBXRmpLZWxQQUlGdlNYRkN2SzE4?=
 =?utf-8?B?VE9LQlFiakVnaHFLZkRUaDBxTUw3MGRZZjBRaENOMU9ERVZleGZuOUh4b0Vv?=
 =?utf-8?B?MDk1aTRHSE51SzkzTHNyUEpFb09RdHF5c1BuSDRkZCtpQUZEV291TUhNUGox?=
 =?utf-8?B?Y09ieklTeUJWNGhXY0JzZ2Z1K00rVXcvcGlYUzVMTWI5dTFDQ3BocnptQUR0?=
 =?utf-8?B?SjhVemFtSHpLOERabDJFUjIyb0J5amhUelFrc3BPbXVBZXFBWWk3cnB3V2hT?=
 =?utf-8?B?L1VJZVFkaTBxWjhnem5kL1NaVlJNWVZ6V2krOU5vb3JtSUNVbGVvZUpZSnBZ?=
 =?utf-8?B?anRhRFNDZTZoNnJzWkdFR1gvWmwwL09GbC9reHJmZWlyK1FUWWlJUHFUKzJY?=
 =?utf-8?B?WENOUXNFQW9BMWkvZnBqSjFOVGJ0TlU2YkIxK3FJN2lvVzVCZUZUVlUydkRU?=
 =?utf-8?B?a2dVU3d1NVBvRnVrcTdFMEZjL3ZvSnJQejFWMTlRVEF0NzNXdGd2cWdQOVpR?=
 =?utf-8?B?ZlcydG9iZmpydWxjWmR3RFdUTmdROTFJT1dTRHNhSjc3V0t4ZnloZnpHWEN5?=
 =?utf-8?B?cFduNzN3ME05OXM4YmQ3UTE3WHVQWDArTnFkVWtQTWJORGpGeldKUlc3dHZ3?=
 =?utf-8?B?dnI3c2o2Zm5aai9EcENZNllBS3doZlM5c1lMeGI2YkJUY1FPRnlBY09WclB3?=
 =?utf-8?B?OTRyVTV6MzFjZWJXdDUweUNpdkhYTjRSbThqTHdQVlVpVnBmRzRDUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2d3a3e-ee4c-4a9c-aeec-08de5aac6ff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 18:22:59.2034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrgDd2IjuPm8eQoXcKQV9LZdZrvwoNTxRy2IPjJ/lqa2x/j3WSzG1dRT9UVk666M3Q31yfYK6upuFCUH++xtuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMyBKYW51YXJ5IDIwMjYgMTc6MTIN
Cj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzog
Sm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgRXJpYyBBdWdl
cg0KPiA8ZXJpYy5hdWdlckByZWRoYXQuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS0N
Cj4gZGV2ZWxAbm9uZ251Lm9yZzsgUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmc+Ow0KPiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmljb2xp
biBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBiZXJy
YW5nZUByZWRoYXQuY29tOyBjbGdAcmVkaGF0LmNvbTsNCj4gYWxleEBzaGF6Ym90Lm9yZzsgTmF0
aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2Nocw0KPiA8bW9jaHNAbnZpZGlh
LmNvbT47IHNtb3N0YWZhQGdvb2dsZS5jb207IHdhbmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBq
aWFuZ2t1bmt1bkBodWF3ZWkuY29tOyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsNCj4gemhlbnpo
b25nLmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUN
Cj4gPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMDAvMzddIGh3
L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBmb3IgdXNlci1jcmVhdGFibGUNCj4gYWNjZWxlcmF0ZWQg
U01NVXYzDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBv
ciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIEZyaSwgMjMgSmFuIDIwMjYgYXQgMTY6NTksIFNo
YW1lZXIgS29sb3RodW0NCj4gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPiB3cm90ZToNCj4gPg0K
PiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBQ
ZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+ID4gPiBTZW50OiAyMyBK
YW51YXJ5IDIwMjYgMTU6NDgNCj4gPiA+IFRvOiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10
aG9AbnZpZGlhLmNvbT4NCj4gPiA+IENjOiBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1l
cm9uQGh1YXdlaS5jb20+OyBFcmljIEF1Z2VyDQo+ID4gPiA8ZXJpYy5hdWdlckByZWRoYXQuY29t
PjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS0NCj4gPiA+IGRldmVsQG5vbmdudS5vcmc7IFJp
Y2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsNCj4gPiA+IEph
c29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBOaWNvbGluIENoZW4NCj4gPiA+IDxuaWNv
bGluY0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29t
Ow0KPiA+ID4gY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5hdGhhbiBDaGVuIDxu
YXRoYW5jQG52aWRpYS5jb20+Ow0KPiA+ID4gTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsg
c21vc3RhZmFAZ29vZ2xlLmNvbTsNCj4gPiA+IHdhbmd6aG91MUBoaXNpbGljb24uY29tOyBqaWFu
Z2t1bmt1bkBodWF3ZWkuY29tOw0KPiA+ID4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbTsNCj4gPiA+IHlpLmwubGl1QGludGVsLmNvbTsgS3Jpc2huYWth
bnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjgg
MDAvMzddIGh3L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBmb3INCj4gPiA+IHVzZXItY3JlYXRhYmxl
IGFjY2VsZXJhdGVkIFNNTVV2Mw0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgMjMgSmFuIDIwMjYgYXQg
MTU6MzMsIFNoYW1lZXIgS29sb3RodW0NCj4gPiA+IDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4g
d3JvdGU6DQo+ID4gPiA+ID4gc3RkZXJyOg0KPiA+ID4gPiA+IGFjcGktdGVzdDogV2FybmluZyEg
SU9SVCBiaW5hcnkgZmlsZSBtaXNtYXRjaC4gQWN0dWFsDQo+ID4gPiA+ID4gW2FtbDovdG1wL2Ft
bC03UVFWSjNdLCBFeHBlY3RlZA0KPiA+ID4gPiA+IFthbWw6dGVzdHMvZGF0YS9hY3BpL2FhcmNo
NjQvdmlydC9JT1JULml0c19vZmZdLg0KPiA+ID4gPg0KPiA+ID4gPiBBbnkgd2F5IHRvIHJldHJp
ZXZlIHRoZXNlIGZpbGVzPw0KPiA+ID4NCj4gPiA+IFRoZXkgYXJlbid0IGluIHRoZSAiam9iIGFy
dGlmYWN0cyIsIGJ1dCB5b3UgY2FuIHByb2JhYmx5IGRvIGEgcGF0Y2gNCj4gPiA+IHRvIHR3ZWFr
IHRoZSBDSSBqb2IgdG8gYWRkIHRoZW0sIHB1c2ggdG8geW91ciBvd24gZ2l0bGFiIGZvcmsgb2YN
Cj4gPiA+IFFFTVUgdG8gaGF2ZSBpdCBydW4gdGhlIENJLCBhbmQgdGhlbiBsb29rIGF0IHRoZSBy
ZXN1bHRzLg0KPiA+DQo+ID4gSSBmb3JrZWQgeW91ciBRRU1VIEdpdExhYiByZXBvIGFuZCBwdXNo
ZWQgbXkgc2VyaWVzIGhlcmU6DQo+ID4NCj4gPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXRsDQo+ID4gYWIuY29tJTJG
c2hhbWlhbGkyMDA4JTJGcWVtdSUyRi0lMkZjb21taXRzJTJGdGFyZ2V0LWFybS5uZXh0LQ0KPiBz
bW11djMtYWMNCj4gPg0KPiBjZWwmZGF0YT0wNSU3QzAyJTdDc2tvbG90aHVtdGhvJTQwbnZpZGlh
LmNvbSU3Q2MyZDgwZGI1M2QxYzRlNA0KPiAyOGFiZjA4ZA0KPiA+DQo+IGU1YWEyOWNiZCU3QzQz
MDgzZDE1NzI3MzQwYzFiN2RiMzllZmQ5Y2NjMTdhJTdDMCU3QzAlN0M2MzkwDQo+IDQ3ODUxNjQ3
ODU4DQo+ID4NCj4gNDg5JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lP
blJ5ZFdVc0lsWWlPaUl3DQo+IExqQXVNREF3TUMNCj4gPg0KPiBJc0lsQWlPaUpYYVc0ek1pSXNJ
a0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0MmDQo+IHNkYXRhPQ0K
PiA+DQo+IEVDdFl3TFV3NVREWE9vJTJCSHpzNFpkR0lmb2dWcWd5UHglMkJQS1l4SlVYRjRvJTNE
JnJlc2VydmVkPTANCj4gPg0KPiA+IEhvd2V2ZXIsIEkgYW0gbm90IHNlZWluZyBhbnkgQ0kgam9i
cyBydW5uaW5nIG9uIG15IGZvcmsuIEluIHRoZQ0KPiA+IHNldHRpbmdzIGl0IHNob3dzIG5vIGFz
c2lnbmVkIHJ1bm5lcnMgdW5kZXIgU2V0dGluZ3MgQ0kvQ0QvUnVubmVycywgc28NCj4gPiBpdCBs
b29rcyBsaWtlIENJIGlzIG5vdCBlbmFibGVkLg0KPiANCj4gWW91IGRvbid0IG5lZWQgdG8gZm9y
ayBteSByZXBvLCB5b3UgY2FuIGZvcmsgdGhlIHVwc3RyZWFtIFFFTVUgb25lLiBUaGluZ3MNCj4g
YXJlbid0IHNldCB1cCB0byBydW4gQ0kgYnkgZGVmYXVsdCBiZWNhdXNlIGl0IHdvdWxkIHVzZSB1
cCB5b3VyIGdpdGxhYiBDSSBxdW90YS4NCj4gVGhlIGRvY3Mgb24gaG93IHRvIGRvIHRoaXMgYXJl
IGhlcmU6DQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRnd3DQo+IHcucWVtdS5vcmclMkZkb2NzJTJGbWFzdGVyJTJGZGV2
ZWwlMkZ0ZXN0aW5nJTJGY2kuaHRtbCZkYXRhPTA1JTcNCj4gQzAyJTdDc2tvbG90aHVtdGhvJTQw
bnZpZGlhLmNvbSU3Q2MyZDgwZGI1M2QxYzRlNDI4YWJmMDhkZTVhYTINCj4gOWNiZCU3QzQzMDgz
ZDE1NzI3MzQwYzFiN2RiMzllZmQ5Y2NjMTdhJTdDMCU3QzAlN0M2MzkwNDc4NTENCj4gNjQ3ODc3
OTI0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVcw0KPiBJ
bFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlq
b3lmUSUzRCUzDQo+IEQlN0MwJTdDJTdDJTdDJnNkYXRhPW1DOTczUEl1UTVsSHh3dTNZMTklMkJZ
dk95MGxrZldMR2s2ZWpzDQo+IGZSa3dKWG8lM0QmcmVzZXJ2ZWQ9MA0KPiAtLSB5b3Ugd2FudCB0
byBwdXNoIGl0IHdpdGggdGhlIFFFTVVfQ0k9MSBvciA9MiBzZXR0aW5ncyB0byBnZXQgaXQgdG8g
cnVuIHRoZQ0KPiBDSS4gVGhlIGRvY3Mgc3VnZ2VzdCBhIGdpdCBhbGlhcyB0aGF0IHlvdSBjYW4g
dXNlIHRvIG1ha2UgdGhpcyBzaW1wbGVyLg0KPiANCg0KVGhhbmtzIFBldGVyLCBhbmQgYXBwcmVj
aWF0ZSB0aGUgcGF0aWVuY2UgYW5kIHBvaW50ZXJzLg0KDQpJIGRlbGV0ZWQgdGhlIGVhcmxpZXIg
Zm9ya3MgYW5kIGNyZWF0ZWQgYSBmcmVzaCBvbmUgZGlyZWN0bHkNCmZyb20gdXBzdHJlYW0gUUVN
VS4gSSBjbG9uZWQgaXQgbG9jYWxseSBhbmQgY3JlYXRlZCBhIGJyYW5jaA0Kd2l0aCB0aGUgYWNj
ZWwgcGF0Y2hlcywgYW5kOg0KDQpnaXQgcHVzaCAtbyBjaS52YXJpYWJsZT0iUUVNVV9DST0yIiBv
cmlnaW4gbWFzdGVyLXNtbXV2My1hY2NlbC12OA0KDQpJIHRyaWVkIFFFTVVfQ0k9MSBhcyB3ZWxs
Lg0KDQpIb3dldmVyLCBJ4oCZbSBzdGlsbCBub3Qgc2VlaW5nIGFueSBDSSBqb2JzIG9yIHBpcGVs
aW5lcyBzaG93IHVwLg0KSSBtYXkgYmUgbWlzc2luZyBzb21ldGhpbmcgb2J2aW91cyBoZXJlIGFu
ZCB3aWxsIGhhdmUgYW5vdGhlcg0KbG9vayBvdmVyIHRoZSB3ZWVrZW5kIGlmIHBvc3NpYmxlLg0K
DQpXb3VsZCBhcHByZWNpYXRlIGl0IGlmIGFueW9uZSBlbHNlIGZhbWlsaWFyIHdpdGggdGhlIEdp
dExhYiBDSQ0Kc2V0dXAgY291bGQgdGFrZSBhIGxvb2ssIGlmIHBvc3NpYmxlLCB0cnkgdG8gcmVw
cm9kdWNlIHRoaXMsIGFuZA0KaGVscCBnZXQgdGhlIElPUlQgZmlsZXMgaW4gcGxheSBoZXJlLg0K
DQpUaGFua3MsDQpTaGFtZWVyDQoNCg0KIA0KDQo=

