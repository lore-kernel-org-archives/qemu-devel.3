Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF7FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwDe-0006Eq-Ox; Mon, 03 Nov 2025 10:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFwDa-0006De-Dq; Mon, 03 Nov 2025 10:11:38 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFwDU-0002Wy-UA; Mon, 03 Nov 2025 10:11:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djGceNlM03LS7NAkYcZzius86JV4slmvQ+5f/JKug4fFcicQ1BF/HqCNgvIXE6OekMYJcbFqaa3gAYeW0TVAxsHRtNQV4Mg8JHtd35XfwWSokvg2vWs1GysjDjwr9FwCxPV0pOOxDfDMEhoq1UfxIkpwchcV4Kho6jIScXRBjZIKH9f0zhL0Fu8Dd5hMeuyLOUE1G0tAsOTVUUpGCgJMEpe8ptE+/M67RVGDxoiQfgrXQZqKby962oM7kwVZpuAaqoKR6IfN0n0px5ff6qgMAgLv1QAHC2muU8Fy32sVQBzIOAyLK9NcYKOWjX6JbsOrjwSAXRlGE7QfYSmRxSWNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cTXSiPPLRhQoP4vlLZaNNXbJijkV9BqbDykEA1K924=;
 b=U40pAlKx5B2AML0SI+l7Z9GEWoOesZFqmZW+SEpzKL2lfyfaO/w2gMwuFiyLTGzpffTRDsqZZZi0i56g6RviQDnzYrJh6haU9EsCYT4NlExnhmtmyI/kuwOHksKjFzZGq0QeYxjiIVebZPCxP1FfUSoUe3mcdlBDE1zX1BLeb6PPlt+9QkgY1650vkbEIpOAyPk2fwk80CWjgz2oj9YTQpYLGBIL5btG2ahB7RRFVE7KZb3W/5zgZ9jc8SY8Vp/+tydFS+7BzmLrpe9u7KU9uAjq/wnGjlysdvx5rUBZoY55kH6rty/ApuP9TNMIY2Ahc2QsZM2ceRE6itBKe/sEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cTXSiPPLRhQoP4vlLZaNNXbJijkV9BqbDykEA1K924=;
 b=VS81YTHtp6Qohj5WtYwDQWTMHhmkY+/HiarN8Ftoo7deN+7XWvcn0ztMfRbdoWob6Trp2w5aoYeBJVeu0MLltVyXvQX0dgv4Gk1Eq2ZOGFpzvWxdDqL0z6eYTkkEO9+fnrx8z9e+2oMHzC6uqRB9spXvyKCkYnjmF/kBaRLdTlUFpxjC04tAuCQUNJDCh27Z5jFId6eyjODrpUyOM+7MeCA2+ixdIme5mLQ0zN2kYDVOERloMfJhbYHPGnEVe7jwgc1WK4AmxJFJF2KJNGKUG/sZB2ET+K2scl6FqCe37zakv73qkmDtQ0xcn+jbePif+GvZCcvElqZzMIATDhuo0w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:11:19 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:11:19 +0000
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
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 13/32] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Thread-Topic: [PATCH v5 13/32] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Thread-Index: AQHcSsGAWekDcEWtlEyXTKUl3fhckbThDtJA
Date: Mon, 3 Nov 2025 15:11:18 +0000
Message-ID: <CH3PR12MB75484B6FB1F67EC13F4338DBABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-14-skolothumtho@nvidia.com>
 <aQVLzfaxxSfw1HBL@Asurada-Nvidia>
In-Reply-To: <aQVLzfaxxSfw1HBL@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB7990:EE_
x-ms-office365-filtering-correlation-id: 3ac2ff89-c703-4df1-2c22-08de1aeb3db0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LgKSpcvp0Amll64IGiplSwPAucwyzKnCEAn02EyDLPrEEcpcFDKNnj0qz+ZW?=
 =?us-ascii?Q?a/ohOOvRUqfVzCgsGxUpTBrTjFRu0QAuZkFRVBE2pmdXDxK9KpyOzL6XM0n0?=
 =?us-ascii?Q?esICtTeDRaCXxpQV4uh4FweJ2RpPIE0Bac6riyMvyF82y+k6F0Zttjcjpqw4?=
 =?us-ascii?Q?+MC9v3vhHYCO2bkTP3oBsq27Nl14uIBjXX0eAgPehyZqmjhCgtYKnlHvPzcL?=
 =?us-ascii?Q?6adPVJsh9iZr7fznOAUU4XiIDn2n+aC0fIwBmlQHjxuTtTMH/uVwcTvJZSLV?=
 =?us-ascii?Q?TctSGZiG3L6QG40v4Zp+YkrSL/HiU5EaipAxF3yh+sZs4h5LKJwYxdOKSj3B?=
 =?us-ascii?Q?BjXTnnjWoIfjBU/gDpok7qxcWUdshlcChqbxLYi7uToAFOY8HhMDq4ydxDyn?=
 =?us-ascii?Q?KbnkQR2PsNzMsFATaF8ZoWreucPLaMwHDpqFNjgu9DvzhRigzTa2WZ3fX4uA?=
 =?us-ascii?Q?k8dnSsUhH9KsAvqdwWQEJvz9immU0hLEM5+dl/f6em168zmkVyIVP2sDSs8C?=
 =?us-ascii?Q?lWfR25ljlCx1+tHFUOwq/1E9eE8XvD9cw0ozpCyiRqJfaRcEEVwLlYOLEup/?=
 =?us-ascii?Q?1Zigc2BhUrVGjZ4dnSKNdEMSfi3UMe1ooIoVUaURQrEQt+C2fHOoKswnFwYW?=
 =?us-ascii?Q?GeoS/gLdsvyMAvf3CZjHM/5o2BvAAzzCBNTGLLZzzTcurixfPBesbthw0Sal?=
 =?us-ascii?Q?B+YxanbPMJXvpmselVpDws2diuTnangJNUzlXBGOFoEtsBvI9BZPAP9jgiAZ?=
 =?us-ascii?Q?xmx7+6I42iWX2FNTIm4ji+iltutCcdrnnAOwLdSB/KKdIIOwHCyKMqVJN6BV?=
 =?us-ascii?Q?5D+aH1/cTyAJPO4a6UfPZGSpzd0l5BJ/9HwPEP79UYAGcfrlkffuaqKhhzPK?=
 =?us-ascii?Q?ImcWqJ1jcfbNG27Ok/6M89iYO+/b1dcmBiab752/737PiAzep13DcEf3XT7O?=
 =?us-ascii?Q?1O7CGEj1Lld7jg29CTEitbrX4u261T6JAAwJD3h7QLI0E+Vc1SKw5KJaqsor?=
 =?us-ascii?Q?nouWe+dXdiliAVc0bVP9oH0Da78393zaxkb9Pn0TrR5gtoGUL/FTNhTrUPG/?=
 =?us-ascii?Q?1oA3QPTYECEDRe5WWCSO93MN7V4ysFTyszVac6qmM5twUm3fNWuK0xN5ilav?=
 =?us-ascii?Q?GVpmX5PXeod/lt2YLJMco0bDpRNJA4Or94aTkLj/nEYTNevAkwBAA/aFPCxr?=
 =?us-ascii?Q?n4pVCuKzC9PbEistwDoTzfi3JnqWl+VbG1xHNSrkV/a9PCyuI4AKtBOvvOL2?=
 =?us-ascii?Q?CNviNmtBXwasoPCN6jD02A5TNMWgASosJPhSm5sLf9ZxMiQw0i+BOpUULHHv?=
 =?us-ascii?Q?3faGj/rkL2TkPrlZv2f8rtokAKruSzPux+hF+RGUwOkOGuiEyIwTS2bA3kHo?=
 =?us-ascii?Q?Sl8wm4yOoGVa5mTL4LCVSuhtgUGZ7TZNmKla533IJyKPdwKQhFJOdzodZvwj?=
 =?us-ascii?Q?qByLBMEuZQYVe+G6fCPcAYDI//VgbVQqdCKeS1OWz8aVSw23JXcdwNa87+Rx?=
 =?us-ascii?Q?wMx90vbWCMWzV5DEjLw5t/YCyRKit6vijbQc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uZCKzk/4OTM2ygODSh65lefj3KBsdRHAuSQ2Wn4JAiQq957sp2WlNPTMSoR9?=
 =?us-ascii?Q?Zmefr52r5iwlUhraJshEOGZ2INF7sAeNpnUFZd53aRaSt8I8Ap53JQNEK3bj?=
 =?us-ascii?Q?WvfPjH/0UqNQLVNskHKDwjzqZgb0MeMOPvlcrXEtqBIMAj4156xEhBcigi/7?=
 =?us-ascii?Q?EmOIZ2jNM5VR8wCZbkhqA2yVtcuGC7EX/k84ispKCS1VLI0AzMSxQ+EODqAq?=
 =?us-ascii?Q?i6U5g5Wdx5QTC5xUDAa4u3GBz4XDrQcfzD+NoC123pB5FyuxkSq1VBCfrcK0?=
 =?us-ascii?Q?ZNl/xoykVJ9OwX/i5TK51sL59komwDtWLDNckicxPRT4aaOdXtiHQd/e647Z?=
 =?us-ascii?Q?o+VLMKVB4AoQDIUutCYsVqXOAasly9ny6yTfFEF6+jQq1z6qMqakOQ25+2QF?=
 =?us-ascii?Q?V+Zoz3S93H+cX8M12YmxctjXmwhjiCp+bhrfWCpf0AEFMEh9RF1H5nc0TMTh?=
 =?us-ascii?Q?ZLzKSujqzhw0JI8UvNZbdG5J3q6zCQ2bK6L/Dxwjp63ahtxNOG0vudJM0zaG?=
 =?us-ascii?Q?c9mRLKCkas/fkUaQxQc4cO0wFRr1/4e33EuWUOxHGXGKl0bvU3eCqbpsi5p8?=
 =?us-ascii?Q?IDtS8UHt9XvqF0/4399VWxpcZLGAv09SV3HWOfoAJHC6HWw7g0xoUbDS71Xe?=
 =?us-ascii?Q?LQbD0brFbco9pZeZ37T5K2IOkKNJoyFQapI7zI7NpVsA4lh8Wmo+w/tAdXfl?=
 =?us-ascii?Q?zKLL/PwrBHlmJ1Se4WX3Fo5cO/s1f5eizQQyJAOfwQMt5k54V6qfWYMwSQ9S?=
 =?us-ascii?Q?k8sJwWgf3ELatGTsfcS+xFLSoq1GoL1a4RucBMpq4zUq4Tvh41hpxJ10qMOh?=
 =?us-ascii?Q?Pmp2QKmgCGaSj2EOAV+lmWHOsijqrM+dH7r2IRHo/J5xSQL0RjBCaZ8VeTJh?=
 =?us-ascii?Q?jN5OGNLcrDDglG+JfW+oBVouTAkuv8L3Hp5MR0upROHKhiuwenHZFP/Fkelr?=
 =?us-ascii?Q?1L/Bq9ciLmgm5iDPX5jJAGaCR6Kz3IeCvdpWKju0YOJCneuTJT3NPuEDIlkx?=
 =?us-ascii?Q?6VPoIf4NDRXRWSfMScCmOcE9l07Hfptc+C63LJBfQ/l/GK+B2KfiYz99A+UM?=
 =?us-ascii?Q?dkooqB3l1ThwlTGq+nzHBmmmhkiRaVrUAWU5+aV+Kl4nGM5z7M2PSaiwlUUV?=
 =?us-ascii?Q?m2AApTvuk5MtQNi8Hr8evIhnSZHr1S9DdumEIRK/BejDUyYoSUcAdUSfhdlP?=
 =?us-ascii?Q?ozx22yscRAa2MIKliggZ45TiFWW1lm1Q6jzznSxwfcTtiK2G4070yeBvdgmg?=
 =?us-ascii?Q?MiyQCMBTY4M0hYSWHDv3iXRPcMLAq+SvBeatottVH1e21d2C5XM1L99jxxR1?=
 =?us-ascii?Q?pbclPaU0HICPB/TReuWOFMNBe9VtZx43GuREBVYobpxBmf6BJYNcwI5vUqzY?=
 =?us-ascii?Q?1hX5Kwr3HVyHnf77/cQeRy2gxNDHSxPFcmWEPIjyZ2dS8zqwM+C+zxQ19AvK?=
 =?us-ascii?Q?qujJM+jukb05lViQypI4l/4qvISoCJARIN8nwvmPw6pfaAXLqf+kbUal0vGD?=
 =?us-ascii?Q?Bipof6awlzvAomfvb32RxVYzplKGqTeB2qxnyWvTKFNCssLBgDOsxpHo9hnN?=
 =?us-ascii?Q?mQeQhqYj8BQlVRyiV6QBuwWxF7Bm/w5jpVj5Tk/p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac2ff89-c703-4df1-2c22-08de1aeb3db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:11:18.7376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ooDSjTRSKpZRHHEh31EEyseHSHy1B6Z7OPLFRcCEc6bjU1kATtOQSZaMQGFO0vv+qmrR3EjCXz2shqKAwNSow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990
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
> Sent: 31 October 2025 23:53
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 13/32] hw/arm/smmuv3-accel: Add nested vSTE
> install/uninstall support
>=20
> On Fri, Oct 31, 2025 at 10:49:46AM +0000, Shameer Kolothum wrote:
> > +static bool
> > +smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error
> **errp)
> > +{
> > +    SMMUViommu *vsmmu =3D accel_dev->vsmmu;
> > +    IOMMUFDVdev *vdev;
> > +    uint32_t vdevice_id;
> > +
> > +    if (!accel_dev->idev || accel_dev->vdev) {
> > +        return true;
> > +    }
>=20
> We probably don't need to check !accel_dev->dev. It should have
> been blocked by its caller, which does block !accel_dev->vsmmu.
> Once we fix the missing "accel_dev->vsmmu NULL", it should work.

Ok.

>=20
> > +
> > +    if (!iommufd_backend_alloc_vdev(vsmmu->iommufd, accel_dev->idev-
> >devid,
> > +                                    vsmmu->viommu.viommu_id, sid,
> > +                                    &vdevice_id, errp)) {
> > +            return false;
> > +    }
> > +    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
> > +                                               vsmmu->bypass_hwpt_id, =
errp)) {
> > +        iommufd_backend_free_id(vsmmu->iommufd, vdevice_id);
> > +        return false;
> > +    }
>=20
> This should check SMMUEN bit?
>=20
> Linux driver (as an example) seems to set CMDQEN and install all
> the default bypass STEs, before SMMUEN=3D1.

Yeah. For RMR I think.
=20
> In this case, the target hwpt here should follow guest's GBPA.
>
> > +static bool
> > +smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev,
> bool abort,
> > +                                      Error **errp)
> > +{
> > +    HostIOMMUDeviceIOMMUFD *idev =3D accel_dev->idev;
> > +    SMMUS1Hwpt *s1_hwpt =3D accel_dev->s1_hwpt;
> > +    uint32_t hwpt_id;
> > +
> > +    if (!s1_hwpt || !accel_dev->vsmmu) {
> > +        return true;
> > +    }
> > +
> > +    if (abort) {
> > +        hwpt_id =3D accel_dev->vsmmu->abort_hwpt_id;
> > +    } else {
> > +        hwpt_id =3D accel_dev->vsmmu->bypass_hwpt_id;
> > +    }
>=20
> This should probably check SMMUEN/GBPA as well.
>=20
> Likely we need "enabled" and "gbpa_abort" flags in SMMUState.
>=20
> > +static bool
> > +smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
> > +                                    uint32_t data_type, uint32_t data_=
len,
> > +                                    void *data, Error **errp)
> > +{
> > +    SMMUViommu *vsmmu =3D accel_dev->vsmmu;
> > +    SMMUS1Hwpt *s1_hwpt =3D accel_dev->s1_hwpt;
> > +    HostIOMMUDeviceIOMMUFD *idev =3D accel_dev->idev;
> > +    uint32_t flags =3D 0;
> > +
> > +    if (!idev || !vsmmu) {
> > +        error_setg(errp, "Device 0x%x has no associated IOMMU dev or
> vIOMMU",
> > +                   smmu_get_sid(&accel_dev->sdev));
> > +        return false;
> > +    }
> > +
> > +    if (s1_hwpt) {
> > +        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev, true, er=
rp)) {
> > +            return false;
> > +        }
> > +    }
>=20
> I think we could have some improvements here.
>=20
> The current flow is:
>     (attached to s1_hwpt1)
>     attach to bypass/abort_hwpt // no issue though.
>     free s1_hwpt1
>     alloc s2_hwpt2
>     attach to s2_hwpt2
>=20
> It could have been a flow like replace() in the kernel:
>     (attached to s1_hwpt1)
>     alloc s2_hwpt2
>     attach to s2_hwpt2 /* skipping bypass/abort */
>     free s1_hwpt

Not sure I get the above, you mean in this _instatl_nested_ste() path,
we have a case where we need to alloc a S2 HWPT and attach?

> > +smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev,
> int sid,\
> [...]
> > +    config =3D STE_CONFIG(&ste);
> > +    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {
> > +        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev,
> > +                                                   STE_CFG_ABORT(confi=
g),
>=20
> This smmuv3_accel_uninstall_nested_ste() feels a bit redundant now.

Agree. It crossed my mind too.

>=20
> Perhaps we could try something like this:
>=20
> #define accel_dev_to_smmuv3(dev) ARM_SMMUV3(&dev->sdev.smmu)
>=20
> static bool smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice
> *accel_dev,
>                                                 int sid, STE *ste)
> {
>     SMMUv3State *s =3D accel_dev_to_smmuv3(accel_dev);
>     HostIOMMUDeviceIOMMUFD *idev =3D accel_dev->idev;
>     uint32_t config =3D STE_CONFIG(ste);
>     SMMUS1Hwpt *s1_hwpt =3D NULL;
>     uint64_t ste_0, ste_1;
>     uint32_t hwpt_id =3D 0;
>=20
>     if (!s->enabled) {
>         if (s->gbpa_abort) {
>             hwpt_id =3D accel_dev->vsmmu->abort_hwpt_id;
>         } else {
>             hwpt_id =3D accel_dev->vsmmu->bypass_hwpt_id;
>         }
>     } else {
>         if (!STE_VALID(ste) || STE_CFG_ABORT(config)) {
>             hwpt_id =3D accel_dev->vsmmu->abort_hwpt_id;
>         } else if (STE_CFG_BYPASS(config))
>             hwpt_id =3D accel_dev->vsmmu->bypass_hwpt_id;
>         } else {
>             // FIXME handle STE_CFG_S2_ENABLED()
>         }
>     }
>=20
>     if (!hwpt_id) {
>         uint64_t ste_0 =3D (uint64_t)ste->word[0] | (uint64_t)ste->word[1=
] << 32;
>         uint64_t ste_1 =3D (uint64_t)ste->word[2] | (uint64_t)ste->word[3=
] << 32;
>         struct iommu_hwpt_arm_smmuv3 nested_data =3D {
>             .ste[2] =3D {
>                 cpu_to_le64(ste_0 & STE0_MASK),
>                 cpu_to_le64(ste_1 & STE1_MASK),
>             },
>         };
>=20
>         trace_smmuv3_accel_install_nested_ste(sid, nested_data.ste[1],
>                                               nested_data.ste[0]);
>         s1_hwpt =3D g_new0(SMMUS1Hwpt, 1);
> 	[...]
> 	iommufd_backend_alloc_hwpt(..., &s1_hwpt->hwpt_id);
>         hwpt_id =3D s1_hwpt->hwpt_id;
>     }
>=20
>     host_iommu_device_iommufd_attach_hwpt(.., hwpt_id);
>=20
>     if (accel_dev->s1_hwpt) {
>         iommufd_backend_free_id(idev->iommufd, accel_dev->s1_hwpt-
> >hwpt_id);
>     }
>     accel_dev->s1_hwpt =3D s1_hwpt;
>     return true;
> }

Ok. I will take a look at this.

> > +bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s,
> SMMUSIDRange *range,
> > +                                           Error **errp)
> > +{
> > +    SMMUv3AccelState *s_accel =3D s->s_accel;
> > +    SMMUv3AccelDevice *accel_dev;
> > +
> > +    if (!s_accel || !s_accel->vsmmu) {
> > +        return true;
> > +    }
> > +
> > +    QLIST_FOREACH(accel_dev, &s_accel->vsmmu->device_list, next) {
> > +        uint32_t sid =3D smmu_get_sid(&accel_dev->sdev);
> > +
> > +        if (sid >=3D range->start && sid <=3D range->end) {
> > +            if (!smmuv3_accel_install_nested_ste(s, &accel_dev->sdev,
> > +                                                 sid, errp)) {
> > +                return false;
> > +            }
> > +        }
>=20
> This is a bit tricky..
>=20
> I think CFGI_STE_RANGE shouldn't stop in the middle, if one of the
> STEs fails.

True.

> That being said, HW doesn't seem to propagate C_BAD_STE during a
> CFGI_STE or CFGI_STE_RANGE, IIUIC. It reports C_BAD_STE event when
> a transaction starts. If we want to perfectly mimic the hardware,
> we'd have to set up a bad STE down to the HW, which will trigger a
> C_BAD_STE vevent to be forwarded by vEVENTQ.

I don't think we need to mimic that behaviour. We could return an event
from here to Guest if required or just have error_report().

Thanks,
Shameer

