Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4975CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIFY-0002Wz-1J; Tue, 04 Nov 2025 09:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGIFW-0002Wf-MQ; Tue, 04 Nov 2025 09:43:06 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGIFT-0000aY-VO; Tue, 04 Nov 2025 09:43:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLENT9/HZW3BaOpFOnvFHHGud4bOpMApi5WWCXH+Bb8WHpKooeoxCNcbMDFBx5pHNMrQ6JNJfjGk03iLAxLuz6JEthDl8SQBlewf5IX6LzbWsmsjmxP4uK0I5I9nShsryqrh5Un1kn+gbucQqPnqfUgl+KuW8eEl6holh+KmoRhWiBLLzq65iDsU1E/h9VjnM2TvCUKo3Ior+PRNUfC0azHyL+t4ncoIKQcpiz1RSeg3gM/ceu0bLUZaDEE5/Yqe3kJktURaqfzqXR5o4YMcfkeM6vcvAeGYPLjDdOOzJhMq0uvmqc2ekqVWs8AYcv6fMWip0KpSHGzGCcNGpbPDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36OMKxfggyelqifcsLlHe50cRfEQ5J6hP4yT56HkM9w=;
 b=AmNrS6taQPjakj30lhwcuBaRBp6Z5Li4oyXcCVnwO032jSgD0hMJvTnwLlDd8owa4I97NvzxlK5TVYPTnznCASJcIbmvX+ssbnQcWKZROWUxpodQ2y9sCQs4KJ+t599DKL+Yyd0Dh/zzIVfFe8W/YKd4Vv4w1HtKr3pXQEYElih5011YTbnE8i/Z/zpeEiXlCR8Y0/jPd8+s+wPDT9mbE13M70cZJzlDXPESfJtlvTdi8FxxjkmPEWcIKhxPrNBZHDpH/kT02hpMQsujSEEdJCZNNWHsn7IdB+G4Jy43hDk14R3b9FjH91xirp/KfoDfaubpQ9J77cH2r+QktNIn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36OMKxfggyelqifcsLlHe50cRfEQ5J6hP4yT56HkM9w=;
 b=B3G+UB+pzNuuuZCFs6F7MpVsU2KEz28Bpd3Iv+RhrTsIbg+b/uhGnurFawoQCo5oXLrQRxjKSvtyvyPSHpYItXIIcjz7XO6dTrd4WL3FNvGPBVQMqkNe/32UbwUJ/mGPpthAuHCInNMK7ukYhy2amq/ilg1qOJVl41QXJEPHUGlRthbJ4oRh+mwMdvcCba0S+oQPw4L6lS5bBEeuEa+w3cmSlpJ09JYngbbYKXJG3SohDDADQigMGjRTWmdP9Zeu5CeC2jqvo5jb5mTkaSIfV+Tpi0g2g77ivtPpVYrxNV4zmU6JlmOoqOhqpUY4kNV+aXbnO2yZ2E2fj97c2bXEdA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:42:57 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:42:57 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Eric Auger <eric.auger@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Topic: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Index: AQHcTZUAOcFtPNqTvke2OSuQhL/9/rTikUkAgAAEzmA=
Date: Tue, 4 Nov 2025 14:42:57 +0000
Message-ID: <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <20251104142052.GD1537560@nvidia.com>
In-Reply-To: <20251104142052.GD1537560@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA0PR12MB7604:EE_
x-ms-office365-filtering-correlation-id: 8ddac3a3-b789-46eb-7e71-08de1bb0722a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bXf//H0qL88k7W8C/IU6IqaUGw1UQQYOzlwZ/E0+o2lH+CG4lxXrM1G/H7Jz?=
 =?us-ascii?Q?wlgULLw1CIuUUCeGL8VPYtC3CsC23IQNjlHfgtlNdzb3N+XKrtJQbOqhoTJ1?=
 =?us-ascii?Q?R/DBza7/RZ1j0hWP2TLCMDrwv8fGAcsJYuWqMKavlqRbbmBo3dc0GxyOkzHJ?=
 =?us-ascii?Q?pyuj37F7Wvc6soLysVDjLQWCvYGvabkYujMDT2wQ04l1mB8KJi9GT0sC6TOS?=
 =?us-ascii?Q?sAoQQOgDUw3Mu+8LbsnXmz7qlDuLpPEJM0FT02n446W34VqblpA3g9pKByFz?=
 =?us-ascii?Q?cy0LieubJOnd+oY8yJn1yKUF9+4Fy2mSaEtvoKZLrfmHfGD3NJpU2KOSmcfh?=
 =?us-ascii?Q?Csu34Mved2VKjcLuaCKwGxsWEpLFJKcvlNbR5iD1nCA5aMXaigIbM3hJQ3G2?=
 =?us-ascii?Q?0SjirYmFyuXgvAW9ynF5bAeLzu6yTriIbz0nABw1vqg7tQdYs/eGq2jYyFSr?=
 =?us-ascii?Q?WMqhdaGC1qSJrI06H/S9cl9hBR3s9OntaUVgjgD1Z94eOhdIGDirPCDs7hAY?=
 =?us-ascii?Q?9KsAbCH7A1CxDyO1E1L1ASIfCdaD+Up7/c/xUKkCDiYTOV9nRzUgGsXUuvri?=
 =?us-ascii?Q?wdohrUxvAZATiL25dDVxdqemPBIK0gwEoauQtED/YKohIO5xr+z73DpZGUA9?=
 =?us-ascii?Q?l/gTiFwiJgSSE7hXa2x6tcAqSXUeZ23bviBsiF8/lAwtroYm3FBqHZI4IgzU?=
 =?us-ascii?Q?VOQjsds/+bXzpi2dwGsAYXgaHZqRsvqIcKVZWB//4SO9CYVQcaYk8pfiyOLj?=
 =?us-ascii?Q?PPPQQhHUB+xj20phTlhHswnfIRE4WlUd/lTJYuVxVZ9dF84/tYq9aHMmQfrK?=
 =?us-ascii?Q?IZI7R/5kAzyhAPULZWwQFkbV+XNFJUZhmGzo0GuQOss5f1qx0hZRSeiMJXBy?=
 =?us-ascii?Q?CqiaTn09ZcQMGvO1xkX0fGws3lQU/8UsK8ub8hqhc99wrdvHZkStN/7nP3AC?=
 =?us-ascii?Q?9cZ6P6rAh3F0X8PqljxODK8U+3DNmZwpBKDigRsmeDrDZWZ7ETvrJjyd0hlK?=
 =?us-ascii?Q?N9y92RZFlIPxplboDl4BpwVKDCK4Iag8yeDq6puu0SOi1uCw38fDVMtDL+6d?=
 =?us-ascii?Q?BL3Cy8wLPv0XkgSSpYAbmwK9/XfIGKUzeiSo9vWNGR7rcl4Sq0UBm/tkVH22?=
 =?us-ascii?Q?I540zvarvMsqKOCnoNpyGgKvtuj/MU7C83cFCF32LAMBFoaaDidKS28IiH+s?=
 =?us-ascii?Q?7qE8d8F4fzYUqxXspb/Tww4u0/AT3vyu0JsKlGfQ9f05WXp51Tk4wY0snRTy?=
 =?us-ascii?Q?67DX56WsdOqGeJY0SK35HIomg29fux+7WuXvKEbbM8iBhSgDwkDdq6R89r2+?=
 =?us-ascii?Q?/rZaS+0fpjGMkgFAkaQNDRG274EN/RhSAclQ2pMN1XcfXGVi7Y//aXGEuz6G?=
 =?us-ascii?Q?KL9QCW3tSoMNGcuNF9sD/HnAWNKyml1MyvgLSNH/xkVXPtxnKZBoQ6H9+2M/?=
 =?us-ascii?Q?/ij3P3hXuPWgx134KmJMHxkTlEWfDDN8lY7JLY41c2DxA12UgxsWvrsGv+Qx?=
 =?us-ascii?Q?b7TUYo3njiHI99GSfwqDPk6sN2k6gSDgebza?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LbFIdtmNMpgV9ZsKPNoKsf2oMJWrTPjlOlUmGWp0sirZ1//KRhV9KXGi/4Jt?=
 =?us-ascii?Q?Asgq8l19JS6JALUOdrC1tL9I+q6wnUvKOlBE3FQJMpqHo+P7HOjgfROMdz8E?=
 =?us-ascii?Q?i/o8vj+k2Moym/vWioWzqFn17y3xyM3SlfuRehZ75XCDLRluNAUAlhh1W+Lk?=
 =?us-ascii?Q?Pbk8H5ObKy7all/JsKFNj9tiTcbYw0qyorUtqZPiJAIltoMKr0sQC3SDQOVh?=
 =?us-ascii?Q?toeMECGaBtREY56ZcN0JpiDWPA9iH+6W9FCy+iq5EX6Em9+j0AAiYjhW0nkB?=
 =?us-ascii?Q?kLkF55oCRln/CTupQdwBankGubatAa2Pka6bE6LOj/nSPfgdT4n6XSgOwABr?=
 =?us-ascii?Q?e/zNcUntH3QzzQp0IqfNCWPQO44BNLQn1ePrU5F48t2wIfDCj9ojj+MPWmzy?=
 =?us-ascii?Q?V3ypMfyu4Qq60htKC8x2NsO1J3x7OqaKY4DGAXZpOj9b0G22fQq/HCPh0wSu?=
 =?us-ascii?Q?/hfu5mQ8v9AnNOL71Gy5mFsh59rHDDrMwGsM2Wft5Rd9bhMFAjrr14+Hvtsg?=
 =?us-ascii?Q?9rai2wgBmpF3ZJATawKm/3A8p2cKKEeTFgzqozcmA0XghqlyJj6lfkUzieCO?=
 =?us-ascii?Q?ltEGc01UIHu4sTLRrut3i8N0gT7s52qKU3M1OYtWo6LsieEVDDt2MCWtbk7T?=
 =?us-ascii?Q?CuFaDDQKLph0NEL9KVrQe3So7CauVc6B2R8BZA4GDF80IBm++4FEPiLgNZfq?=
 =?us-ascii?Q?JTU3C/RrOEQveQgHDwjKBsjcszELQkDU0iPhnkxMH7FDz2NhKd/eYi199sHT?=
 =?us-ascii?Q?WGby3MBNEdUiGS9AMRKwgFBFPLWT7oXqa94tGZV+Kv1Zlb2az9LEVBNCszKD?=
 =?us-ascii?Q?vegqON9QSWBBn7M9ZBFw8EYI7y1BjyimJMsB94PMt/RnSAk5ry8262QRlr8w?=
 =?us-ascii?Q?jjtxpNOnh8rqDUegBE2+5D/QzSYip1ucSYHVQ4rM0QthtkuhM8FFpJ8QXgyT?=
 =?us-ascii?Q?Gt38RFOaAvtrIWnP3y1XQ25z3u3vgJnYWgEubqu9P6zi+COpF39rSiHCqxFu?=
 =?us-ascii?Q?psF5xcmNvH0CJZqfEmFWBnAIQMrP0oaE4wGf94kQke9objZZCCFVdXh/3w+E?=
 =?us-ascii?Q?qUsALqe5xowHKjEzNDL/jvs+aXJtiq2BTRAcXitijKIoGlnN7+S3Dclz6DPb?=
 =?us-ascii?Q?hpq9Ouk8KHntWFUKEo7AWDiAAB/xgtH9+CS8plyCucGvkoZF2LBEy0HIJ/zq?=
 =?us-ascii?Q?qkYTyWIn3a7GHrPtzxkQ1BRzd5oJfT51WhatZJDWoHDB9lPcOpcg9qGcSRNy?=
 =?us-ascii?Q?ER/wH6rAuH65M4u2B9O1+xvORk12gdffdTueeeozI2NxTlmUytezM+Ueb2Xg?=
 =?us-ascii?Q?/OYurjnsjxPgSpwQ0+7yRtY448/UrL/SzqHvQ3xzwS2Yvyl5PCcrGXxqf7gy?=
 =?us-ascii?Q?8UO29pfmyB8DY8rNeiMzzTNIS8UBWs2VwpdAo6ydhLoPEK5RaPwm/xOoPX+F?=
 =?us-ascii?Q?J86nfhy20OP6orimiSul6Ua0CVHeewfFShHffsCsfHkparb9FI7xflVsg4aI?=
 =?us-ascii?Q?eLtF7oOw/Wvn8ezxLIFovk68bA+hkLs1IV50qOTyxoAIWcHgkwUvXRUi2aIe?=
 =?us-ascii?Q?F8PXpQcxOBKvnLVjVC8X+Wq7iQ2vJHI9MMt6kFd4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddac3a3-b789-46eb-7e71-08de1bb0722a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 14:42:57.6569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsOel4lt+rjexNqYkUeSnGJ8W2r6HNBsGuQwYFMqmCTv4FazG7wIh8t9Bpzp+RZNGuVz0N6GIaPXEFKprxbNCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 04 November 2025 14:21
> To: Eric Auger <eric.auger@redhat.com>
> Cc: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org; peter.maydell@linaro.org;
> Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
> get_msi_address_space() callback
>=20
> On Tue, Nov 04, 2025 at 03:11:55PM +0100, Eric Auger wrote:
> > > However, QEMU/KVM also calls this callback when resolving
> > > MSI doorbells:
> > >
> > >   kvm_irqchip_add_msi_route()
> > >     kvm_arch_fixup_msi_route()
> > >       pci_device_iommu_address_space()
> > >         get_address_space()
> > >
> > > VFIO device in the guest with a SMMUv3 is programmed with a gIOVA for
> > > MSI doorbell. This gIOVA can't be used to setup the MSI doorbell
> > > directly. This needs to be translated to vITS gPA. In order to do the
> > > doorbell transalation it needs IOMMU address space.
>=20
> Why does qemu do anything with the msi address? It is opaque and qemu
> cannot determine anything meaningful from it. I expect it to ignore it?

I am afraid not. Guest MSI table write gets trapped and it then configures =
the=20
doorbell( this is where this patch comes handy) and sets up the KVM=20
routing etc.

Thanks,
Shameer


