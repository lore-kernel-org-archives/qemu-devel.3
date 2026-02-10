Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB1FEA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjqC-0003KZ-5z; Tue, 10 Feb 2026 04:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vpjq9-0003Hu-Uf; Tue, 10 Feb 2026 04:15:25 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vpjq8-0005PC-6W; Tue, 10 Feb 2026 04:15:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3OiacfDWUgP30MyuItbgJUMJsXKfKlzSwGm5nSwmEMQTHPnfPflIjvDVzvwE7a0+j50xgnF73pDp67xdEMG8dAc9K5FSnQOT9iz6KsgSiF1y43qfv8YHexGrven6CKPq2853RtPoJfOExsCPztrrHCH5xkrjEwC5H7dwxSqX+a8Y7bzDfy70AprHg36ha2u0W5A0HXTJzvZM9K/W5FnVQb+zXiJcDkNVBd9nEoKAtDyROS4RHJS8I8YbtDHK+9tYNCwm6rx+mu5MsDbNQuWaA4kLKu7Bacf45rOwV+wJzt8c9910HTvu2Cvs4aeYxjxWJVc+z11FFY7z/PtK+qftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPAOwNm6VMN5nQUx8sEI0GxhT3kakoLeINHrMhuyRVg=;
 b=ZDT8u2Sre9gisbYsKUStLSIqHJoLmiirBo+KMRUlsH32RI6RxqZjMZVolN3oquuQMYCkxETBVXMaY0hnf2I2b/MQrYIGHDf9FfFn++sI04ktq6XHTsxVbmu7ekOLoSzzqPfgpunDLxizqP/8ZKPYWShRLzm21Mj68zYc+Yrvkpv/6KEDbNMqf/eErD99SlxH5LW/cZXbt3aghknGYzfN+cKsik725k0zaQP7jrXPXllggFaRut57xqJpa9BiUvyvtFBCV3rQxuGbfKCCyovFki7OwJk3Z+9kEFtFlwhiALRjac15kir4BmWHrnI95CN7FkpJS4EDr9Nbt+uCMKVLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPAOwNm6VMN5nQUx8sEI0GxhT3kakoLeINHrMhuyRVg=;
 b=O7YH4RtqBM2yE4XLJzX8nPZ93o6G7KO+K8QgkhjbBtN/cBk4TzpqWnmp8dsKPISaIryzHw/JaTqi/ARtjCjirVeSgsoK4l9WLxN+CSuD29DvfEg+1u36pzroyXT+iuhi6AICzrV/f0ygLhpqEXMkhV8NR3fSb9lnMYK3Bcvbf5EEb8CknF8J3J0gdGTawkDDrz8vXvaCxB/RbnuFrxApIj0BXrkHNfJa+KAMyd+q5rxkU3AUOzSsmufJMQYVUfjqyNa2oiIje2Kxb/jQV7vS4ujrUK9myHkCHjIuUkv+bHrUje7Qlqe1Xnji8TDSpjeWX1YcTwtIC2f9I6q625WgUg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 09:15:15 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:15:15 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v2 15/24] hw/arm/tegra241-cmdqv: map VINTF page0 MMIO
 region
Thread-Topic: [PATCH v2 15/24] hw/arm/tegra241-cmdqv: map VINTF page0 MMIO
 region
Thread-Index: AQHcl3fx/GgCj1yKDEmRXsQ/+bgrSLV7DscAgACYutA=
Date: Tue, 10 Feb 2026 09:15:14 +0000
Message-ID: <CH3PR12MB754836812813F46CEE5E5289AB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-16-skolothumtho@nvidia.com>
 <aYpywAQ2EHubTEfB@Asurada-Nvidia>
In-Reply-To: <aYpywAQ2EHubTEfB@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH0PR12MB7886:EE_
x-ms-office365-filtering-correlation-id: 80bf2452-d2c6-4056-5546-08de6884e6b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bkBk0mFy5pkq93t+1VRo0LhHRhOti9YlOMFOrdJAkR1wQc+rhU/euLF0jjdt?=
 =?us-ascii?Q?pn/yJWZsWqsVUX11kUH3LH0kLDvhpO02xCgdY5fTH3Ll9nQmcyQOLSCsLqWX?=
 =?us-ascii?Q?VUlT127STN4KJH5iJsyHfJDfd4uUcSCLauGLRT2TtzmV06Rg/ny2NWT1dWMo?=
 =?us-ascii?Q?40/4DhdauwIGw/R8jcndWpfXKOWipJT9Te5vLbT0kpNStj4X0w14Pn077C+C?=
 =?us-ascii?Q?MOExJadi8AYDcCwHCRs0p2+eYEgw82yZXobhw70LI2XUe7hMEkfJmPjLAiHu?=
 =?us-ascii?Q?ysEdNnAOAJ5Bf1rRDCnEzfYKhTaMCshxNENd1eOCVY/7b/CiR9DUHX4PxK0p?=
 =?us-ascii?Q?HlF+QR9yoatm08hTb456xBPQ3EjtDgv2SIXA91RIFplhvWSh1ochMQmXTx70?=
 =?us-ascii?Q?TvYx5h3tc936RuyHMY1pb0CO61S3+h4NlUmVX93mpbxfvyHwrCqKmhI3Tl//?=
 =?us-ascii?Q?9RQBZjdsjy1GN0YFXdgppUZ3FVr7aEc9Kbn6pzO+hzfgCZ8tDTC5mTgx7hn5?=
 =?us-ascii?Q?61k7dlL42RWu7wtCn8sE/3MzNXu8gjy/W/l0tr4a8SLRtGovL+O3N5Fk5mn5?=
 =?us-ascii?Q?8Qp5d1jOhH/l9TmR0sqml6Qn8sHuj/qEGY1iaydIEyOxwD5sKQYR9h/lrVfy?=
 =?us-ascii?Q?NAYO5SpE8fh06Q/7a7cazY18xUUeKUP7QCDRtrPppIj9bk4fBHV+sNHRkleb?=
 =?us-ascii?Q?KQZfa6OAsfXl8UcmAYTmBqpO3AuDBYz3OPdo5v8DsZBlS4360ghrzCUShNtO?=
 =?us-ascii?Q?njYN83gNBNbbJLEpif960qpltOppKPfXcAYuFfVCxcHJWpFga+efSQntyzGn?=
 =?us-ascii?Q?UB8aT9wSk2kMTUyL7Os0MSjc4sh03Ja/14j0AkTCgepnuvrxgruj83S+DdJs?=
 =?us-ascii?Q?PRBgDPPIB2kNBGwjh9bcuu3L1utDTLl34hntaOD9xBbZnEbfSetzofE6rLwX?=
 =?us-ascii?Q?OByuXny2Rm/zvSkN8oDY/K1E7/NsdtW7rSD05dHH3yX/1R7WFZFXnhNnJJ/N?=
 =?us-ascii?Q?3AzaIzr21aj4sxuB3rLmwV97o4OM7r/rVqXKC7m1Xz24SxVC/Fwfdq0sKWrb?=
 =?us-ascii?Q?c+sqwStKrKXhjASo///+IrerfHTJgHvUzHPN/XPzsbJVXuZNSQfLpiivYYut?=
 =?us-ascii?Q?E71AuRAxOVMRlFI8scGB4dCMaMc2d7l47OjDuRNrpxuqqqiGDFwRiV6uJIL0?=
 =?us-ascii?Q?btDhMOonckHxIoOHrbr0FyVlnwKrV3+bIhEOzcBK3puQMgnq61gFbQJ5ZL49?=
 =?us-ascii?Q?NwmXBDo+JYVugtB7WjgUQWUDd9WwUfwmZ6uUitD5YTYMqzgRBZERK0GQ9os3?=
 =?us-ascii?Q?GAHiRDIldpURJbcbKSv4uNSVuR1/WBlkyzuLSGHkDPxi6hY8+ggZW2Kga0nS?=
 =?us-ascii?Q?/ldzjwQyrokA/wRfHehXewR2riK4N7FBX9FLw0gp0Ccf+Xw19jRDpR9MSCRq?=
 =?us-ascii?Q?Ki8uG/EzMnJgFhY1sjUMEFTDiE4nVZGkO9+wDeSRALpkBkEGERgaoPZ2jzaI?=
 =?us-ascii?Q?f/ss++S10+fpwz7ZV8FWfJgbcOWFe/Uo3lYq1SvxLBLvQ5sN2kTt6tztR0wP?=
 =?us-ascii?Q?juXzw0FVoD8ghi1oaSla0YtP/2AcUI46dn2NIHrRoMpfMFDZxKqiqZ37U9Mg?=
 =?us-ascii?Q?etrzr+0zoAXqb9z1aZbSr0w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uh7l4kRH1Y0shkKlVVoWdxcm1FubmnXfytGbS9KQ1KvJ/qe2aIf4wJOLbtXC?=
 =?us-ascii?Q?KSA+IyMhof4NexkcIw6C1bhFkb3o8yrQAgCAF/tu8A0/TaCfwx/XYr9fv0x6?=
 =?us-ascii?Q?yjvzZMptVIwzKUAsPLli6c4WYymMAC06t+JBaU8/L8ZGu0UGDthBEF0jlKDt?=
 =?us-ascii?Q?6dqT7f8NCyZJVf4lj/eFKpIV/W6+oDVulvkpxZS7WHc5+16LXcz+DLYML8pJ?=
 =?us-ascii?Q?8tOv6yaAoAltuLeU049eyBze1Df92PwcebuN7P+dJyEKDdBycWqxeEXWWJWi?=
 =?us-ascii?Q?3FGG0UWS14FNNMVTgKs875SM8obcD8aSIZ/2Fy0fSui75KW2V7CvX52oWvyn?=
 =?us-ascii?Q?fERNCfM0Tw0KLKi3FSK3kwknV+odiGhcD1fXYfOoDRi7CPZTKajrmoVcClyK?=
 =?us-ascii?Q?uKblyOXm6XDztBlMVBXb9ru24Eum1h0FPu2Hg0tAAC7zplAKSWUjCYdZM5+c?=
 =?us-ascii?Q?ynMCD0bwkaiVqdiXBBBESotPFSPxU6ndrHnZnMLIUuUHCu/uhzEluUBDAcpU?=
 =?us-ascii?Q?JASBkIrQTeUD2TavcertV8ivCUqLgG4mYE9nBYlvcXEuVQ8Ti1UjWz6E3FL1?=
 =?us-ascii?Q?QUKp8Rp5vE7FjXDXgpyRz5GNpoGnD6+Z9Usfd0NB7Y/I+iMIKpPQpp+UD0Hl?=
 =?us-ascii?Q?q5P/21eJNXo/PNi5anRVzor//bM5Z8qi0Sw9Q3LIk03KTdtx0VJq6uEJSr6z?=
 =?us-ascii?Q?0aM/iSsgpn0Cna0NXvPEvytavf4OE6494v6jRV7jM8uQ6KTXX0oPI2qYMt0B?=
 =?us-ascii?Q?AbY1igCsz7atRbsaLQHfEUQDJ+UqYdYUEpYk8rbFtgq1yTqDdV63q7a69Gj3?=
 =?us-ascii?Q?/vPqdo8cRol7WmjPsykrZTO1ZwXew3KmQU/CDF8khn9EfVjoVndGlw9hCwNU?=
 =?us-ascii?Q?JGjXkCJGVPnqr2+nqlr7xUNTL8DLpTskUM5IuevinQd7zGibD3UcnYSEVle/?=
 =?us-ascii?Q?kIESb6iTFrOoWAlofY0afwMJbLwAi97TErGPb5SYQdaTTGBMBIiOxBNdsr3H?=
 =?us-ascii?Q?xlJU5qGtwvahHI/0vvosgVvBAXTZDX8wybLRigR0N6cBl4L+1XDVJrenr8GI?=
 =?us-ascii?Q?s+NIz/y0uIve3anc0rzjSUIs/LzU3403oDkJZDIeZpClW3CY4sA4womcaIKe?=
 =?us-ascii?Q?wwtAf5aNKXHi5elu0BNwK5VtQPHTuMCmYfzXGyJiRzyzsNaooB7bB+bSA+X0?=
 =?us-ascii?Q?oCJHiqigMDNkCB7/ch2e392uOLfIMvezgpicJ7v7plASWfNRxI5SSQ6KMF+u?=
 =?us-ascii?Q?STi2dqojdKqCtvcgip8Gbx20M+5D+5uAm5gqqz4m/E/ZVtPP3e5MdKuwhu+k?=
 =?us-ascii?Q?JU1r7rVXAhOD09QFMdWyY0G0ToM3Hfn1DWRW9JAJFRSUrIseMUq3ISOqLA14?=
 =?us-ascii?Q?NhkcgCxJvPXl++UXxgJkcMJ8yig683XD1l0CSNfb1ip6AmvyQAsTm3I+xVdv?=
 =?us-ascii?Q?3usLKEiWaeiuw4v+lfPTDpiCUoWmcUwpliZaJrEAK2dIU1me/Y5WA814ZTO5?=
 =?us-ascii?Q?rZPpIbEb3GNnzjUuJWsEvb8f724TO1vfp+eJTSwZJigdjwgkhnAngbETtIMA?=
 =?us-ascii?Q?TriQhb+lxHxsxrzUzLkZFAShyqZ8vVcy44IykTadTCM9lLL/TsR+qvt8TKaZ?=
 =?us-ascii?Q?reT3Kwawn0tCwAD7yQAHQ53rzA4TLhswJaiFzACHKsADkWyQWaM+q6A9GlMC?=
 =?us-ascii?Q?CzunbVU8VMy5Ft76D/n8M8Ubio2jxbb2XPrInlVykmGsfXRKM43hLJlDfvmt?=
 =?us-ascii?Q?b4HyBMab7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bf2452-d2c6-4056-5546-08de6884e6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:15:14.8450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b68PM+q3WfXpbh8ymYPx0MQRXYXA99ErshdPEHL+VDJYm060QK0NSJlBIZ1A3tBU8OtIsAp0wO1Cy9yMsU+c6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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
> Sent: 09 February 2026 23:50
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v2 15/24] hw/arm/tegra241-cmdqv: map VINTF page0
> MMIO region
>=20
> On Fri, Feb 06, 2026 at 02:48:14PM +0000, Shameer Kolothum wrote:
> > diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> > index 2f4a8ab35f..b92c34e1d7 100644
> > --- a/hw/arm/tegra241-cmdqv.h
> > +++ b/hw/arm/tegra241-cmdqv.h
> > @@ -31,6 +31,8 @@ typedef struct Tegra241CMDQV {
> >      MemoryRegion mmio_cmdqv;
> >      qemu_irq irq;
> >      void *vintf_page0;
> > +    MemoryRegion mmio_vintf_page0;
>=20
> mr_vintf_page0
>=20
> > +    bool vintf_page0_mapped;
>=20
> Why do we need another boolean while having vintf_page0 pointer
> already?

My original idea for this flag was not to track the vintf_page0 mmap
itself, but to indicate whether we have allocated a HW queue, since
that is when vintf page0 is mapped to the guest.

Looking at this again, the flag may not be necessary. I will double
check the flow and remove it.

Shameer
Thanks,
Shameer

