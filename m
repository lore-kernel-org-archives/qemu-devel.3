Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A650E9413E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 09:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaWK5-0003tP-Er; Tue, 30 Dec 2025 04:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaWJx-0003sg-Ld; Tue, 30 Dec 2025 04:47:17 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaWJv-0003ez-2d; Tue, 30 Dec 2025 04:47:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHQVy+IKmfDRT74zwl+MC4NXEpjRnVAa/fr8koyIu8LAyp7cOQAgJwQJNO6K6xDFqrbZBkM78ku5HR2WOers1LuvnMdhcU/gW3upcGq9hNFd74M6pM3Ui7Sq16qvkBUhfUf2JH0ImRdta29/CWQ2XX4dzsSx4jg3T22yd6nOxV2kJif7+ORbBYz44BUQic6awOh0eaXTZlCg0ezrgyhSkvfOhB6wEgMUT9ZiksHLeDpVjzKAFy4niOPQPsn7Vp8kQ5Vixav+LSMtYy2m5t32yt6Row8Y3q2wID1LFAGX1MRNK0cR70W0CcjY6PzcfkzwmSxkjO3GK7GYBY6hNhKxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGG4jWwo0gm+dyIJz56QMbe/K5dkJ99bB4Sc618CrF0=;
 b=D9z4G4i8ELJ8nnyrydRVQpRZrZujkD9u93N/TYLYu0LrnmCAe9p0UuIvMUyRVeVxCIJpofO2ULeawLUjFUwxQJmFcZv4TsTZb9h4Z29GsMbW2mC2xkvWvwJhMnnIvBRiaMaBHk8pF3r899/j0TbVtchsJ9+qjq/AdL1YZT2sAUA+OO8M9KFWUbQ/gAkTMpq7fCU+HDcvSxoZ4Lygy0y3z2PUBsVIJ5Q264VIv1SEI83Dy5ffrjv0ckG5LGopNv3dTQHnadXOHandb6cpptK91e/AqhqJMQthxre/ftkq5NLW1S3H4/AzVrJoSL2mRC3SRLJUMxEATPn+5uc1qwhyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGG4jWwo0gm+dyIJz56QMbe/K5dkJ99bB4Sc618CrF0=;
 b=dO1gkv3Hz50Xy7knfL3oNzPVQ91EBdd9T1p9uGzCGvC+HmJnqMzUkgjcVzEZh9p0uWGkyggosr1xZJNOaDjRdeH+dTzdc34CjvaXfxrFzDKKNti1uu77DHDfaajnaBZkUU/45GBjeqhDpvzRChqmytV4Xrqf0uuU3EaiLALGKElnFXYmkyiT+nyP3i/PjRmjX4TS7aDfCjSXIG8zGT3D1VnXcrGm+d0lQFGeUt3pcH9PxajYjiikQS0ZKFIguFGEIi8WXkdeD3S6HXON97kSbPVyJFilE6f9BxehSAHWge9pUbFhO1iPvVwW7EQcKLiaMGJ/K6fYCVr981WVFuI8dA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 09:47:09 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 09:47:08 +0000
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
Thread-Index: AQHcadqOqHtReOjPAEGmZGv5J3l5+rU5JMqAgADmALA=
Date: Tue, 30 Dec 2025 09:47:08 +0000
Message-ID: <CH3PR12MB754807EAC29B50A82B3B84E3ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-11-skolothumtho@nvidia.com>
 <aVLbS6g+Sd6vfaFc@Asurada-Nvidia>
In-Reply-To: <aVLbS6g+Sd6vfaFc@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BL3PR12MB6545:EE_
x-ms-office365-filtering-correlation-id: 058d86d4-20e7-4e5f-8067-08de47886630
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JzTU4kGmh2gSFymRnbLhuazBUbNZd0lVJrVct2rFjz1ZFhsRfPssKcW/eRlq?=
 =?us-ascii?Q?IaqjVM4h2xyusUVYlUGcl2iD/KaAB689Kfq/O7M0OgA6cP/ltcFYjHe3rBXm?=
 =?us-ascii?Q?6GmWP7qzD/rzbEAijUjZ34oYaavOFAxiQpFF4TCE0A0CaKyknpsiXjHgQd24?=
 =?us-ascii?Q?wfHtP8GqoqbBp1Za10EP134MPU+RUEFgt6CcuZYZ24mBQaOVKXFkte/kITIA?=
 =?us-ascii?Q?Ow5GY5Rd708dCPI70cRcegB/av9VLB/C0AUiHyxho8o4crsupn5VWMUpr0Xj?=
 =?us-ascii?Q?GnJw3qgp3ws4rz+9ldyBymbpjcQoEqqPQMepSrEJLV1XzayhqpdFniGAfRbM?=
 =?us-ascii?Q?ijBekIlKFHTpSe6StMmu+b2qJz4qVMOZB41sx6cjhaQR5ZOfalTx+A3hr2OV?=
 =?us-ascii?Q?TXbvHQWHgoTAqjdwkmYv2XdTetDJKHYDo0WYETSaxs7QroY0vlUZB/Txiw+T?=
 =?us-ascii?Q?CPKpHE5Fnnl8V3cv9zB9qzJEZjp432cU03JNAVgg5ja4e2LdrSZURQSdSeOp?=
 =?us-ascii?Q?RwcOrH2A+8U8sADW+F/AM6BWsJAwmEwHE+aXodUdfoHsmCMqLfsbq4z4xwFL?=
 =?us-ascii?Q?VfMLhew8t9YRHHaCi+AwebZiBvZIjyyD/MxdTbrMhyfAIivW79EPHrc6ZKtJ?=
 =?us-ascii?Q?/EV/jGcytQXONLgXzywIF0qJ8hYbeFYVTyTrWw9Ai4uvqKBqK3VhF+Zi0133?=
 =?us-ascii?Q?p8aq7v/gL6NswtlW02jY8ATXexftiNE5NJINrhmfCwrL1pByByBR+yplIWmj?=
 =?us-ascii?Q?utIwWCL50+76TSvyCP1dk/walTzE7RpBJ8qLfbQGzjMCBMUuBj4dwlUOfblV?=
 =?us-ascii?Q?qq3BbgjelsIc/0RnRAlVUewPZRgPw/x/Wf8Me0BTrYwcSMuhnTJs805uOO/r?=
 =?us-ascii?Q?52XprzhPh7N5b2AmN6cgwJjbPznEEuOzKuy5YH6RGosXtrYJJKJCkNLhqwr1?=
 =?us-ascii?Q?7DlJgJPxk1epBW5vHt7l2nG/+iLFvLEx/c/++cEfRpGrX+/Lj5mDCgdqr/FQ?=
 =?us-ascii?Q?1K4mSHnIoli+rL82uFxxs49pXB+bUZ61X5nVT8z1nORfS5r8glnIdxrstGNp?=
 =?us-ascii?Q?IyZFerwhUDLuC9eCiTLraWrebrOeuKFPJ26X2jHhD0g62xtbR77fxTUX+EBI?=
 =?us-ascii?Q?QqHzDxwHGQT3Xrmd9wa2dfFYf274Sijvxg/iRDZQbo4+qKC94bmoBFkzz2lD?=
 =?us-ascii?Q?Pk6FJNuCi2hPFQsc1+FuycNNaSWhTQ9wXuuoKSDmAm+r7qCcOJfN5F1lBw59?=
 =?us-ascii?Q?Z2o+6FKiq8HO5ts8ZtZTmq70ZhGZBtSKIcJdyZmvfl52yEjEndzKMbL/MOcd?=
 =?us-ascii?Q?SiLJsTrjH9AIB6PcJfo73u1i1ruENc6ahBUO84xt5OeJXK+Y6UxpIsLmWcnD?=
 =?us-ascii?Q?1uZgohpeBVsrfVp7RbMSCJPoMW8vmpOkMBapcia6KfX1S6OJSYwrA6pmsH2U?=
 =?us-ascii?Q?CsjAx27t73R2aYkXp+HVfJD7EkEzDPUy3D+uUsPntFQmQD/R7tfrErLvMwqR?=
 =?us-ascii?Q?JsYxoDFVLfWrMHgz+hADqMfoQyn5jKqpT3V6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JjGdZw2WFpqg1U+0miFm7j7RKdwWoz+5OBYgDalXI/AkzE4tPKATEHExb/Q7?=
 =?us-ascii?Q?BoXR8v1p1w0hQPm1eJGcbbZMvfxwqfMALJPXTNjlGHyrIztwYwlxrAZLv4am?=
 =?us-ascii?Q?pIn85/dq3Td1zpt3ePKJr55TmxNvb6X69/TW+kTv5SYlxH26bT6RLZUK60c5?=
 =?us-ascii?Q?k1Gs33Ob4eoD4hrUDVOyjdBG4HBOhuiIZWiCwVLX5rPGIdO5cMN0DClHD+If?=
 =?us-ascii?Q?kUxgpj2iXygs0vnF6slqK2PMp3UhqxzGH4QfKAGnDGTEPK8C+SISHDAOwHO9?=
 =?us-ascii?Q?AswercTDE+uv82PjjRULevD1bUu0OXg2BQ4FoYkV4/nZB4cmZssHBEWhVYL0?=
 =?us-ascii?Q?2lk+9imhNvRr+ZtaMLGsavaFIzlazqVRrr6UOmlxvpdF5O3wrZ4V9LTvxcrF?=
 =?us-ascii?Q?A1jIS4gHqEtGyJyi7hxLj3IyLUTmCbBW6Vi/8+hdwo9ye1pz3iXFyWN0aJPI?=
 =?us-ascii?Q?0Qns72EIIzHyfmgjr7wIsiGaHqqaYJL8hGeT18zQLQBu8ZDl8sYUZD7CUCjj?=
 =?us-ascii?Q?3y31iL+SHuU5m7pGOcpkN5Efc2mEFX0GOzptP7mhnDdNGRZ3lg3cj+999yW8?=
 =?us-ascii?Q?8zNgX5wymyBdclpJ3co8xPyQ54oUremT4ozqzaWjlEQWJMEq2aiaHpF97ZaV?=
 =?us-ascii?Q?NAF6N1uMqU2viM5w/tXRFvQaP0uuGY8uMk6fHH3VW8MYGsYH9IfwuKc7xfev?=
 =?us-ascii?Q?AIC9axlfa+d3rW+vQg6jxWmwmlqgGI7YyAeLq80detwlCcJpfiyt3U82XvD4?=
 =?us-ascii?Q?nsZpAvctiyXTbRB7DMNeYQiOTG71FdDHUW5fNEUVFoe/yE+wIn3tLDNMZ1Wa?=
 =?us-ascii?Q?NJItvU5Bq0SHJwUQQOhYE2gXu23XSAYAI1UUIrFAvTaQZdlQJ3HAJCN5cCXf?=
 =?us-ascii?Q?4GPNNBB87/JswpQgXzQKS5df8AIgwLKPUJli86+j5hoh3mIDmZWHAqYPSn9+?=
 =?us-ascii?Q?z7k/VuoQBS0VZ1VDsd85q4rnOWBIgsLcQ/xpeJli7tm0t4goLa4tHSf1uQdX?=
 =?us-ascii?Q?2MJrhsrm/JeV8QNEKLzSLpb0ipR+e2Ec9YcAp4Ka6NR1/IiT0jt94cuba8O/?=
 =?us-ascii?Q?MDJph0H8NMfOn7OZG78H1+ed8f5FmqV0H1sa7sgD3SRcmVhgoNpjk2qv+5DB?=
 =?us-ascii?Q?ScblywJhqQ1F/ldi+Om5fTDKBaPbeDtnaOd3cRY+a/JnTd8sxKPdKzQANd+N?=
 =?us-ascii?Q?0fhFQ/HudHT0yMXWPQ5XVASEdQnZxX/yGsgfmaFY/9DeZ2kXxvKi36IL5ntd?=
 =?us-ascii?Q?GjwLJy28tVqD/G7L1dxiuDkSOfby92Npf2uz9V7wqxVX1Kl8ghwa22PaDkUJ?=
 =?us-ascii?Q?f4qmVt3Nt3IiGIpolE8nsZvuHWfEEOwM14WfSDYQ7Y+aRBR//tW45y3aAigY?=
 =?us-ascii?Q?gJiTUl2oN9qNJ7oHUzPPQGfQyNPtwJyNtOCmlq5mtc4Uhiwm+uFb7kz0rUNb?=
 =?us-ascii?Q?hAUlKYaIxRqUz8okQPS+H5jo3dkkTVVf36oHrBTYm3Gvbh00L7PRV77IDsW/?=
 =?us-ascii?Q?cgav5fmRZ7h1vjLcVB74qM5rk1S4UQrlDuZQcxRFVD56LCUcQ5mobwzU9Bge?=
 =?us-ascii?Q?tCtIZWYI69hxeKSYk8OiDOAuVA/xWydi9dr7b/AIAL4JuhUZg5dV9m/s6bOL?=
 =?us-ascii?Q?13BWClzt4xSr6+1tXF795SmcBI6oNDtZ9BJhqqzNIaAnv/nNNci1s6Q/zO5b?=
 =?us-ascii?Q?+Q5VUtdury4i1IOub0UNOmVYgphLW72z+UxK869cIB8bWgpx3iEmfULyKuRF?=
 =?us-ascii?Q?SJayiyC/OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058d86d4-20e7-4e5f-8067-08de47886630
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 09:47:08.7961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNChEWYg3h+QNzXqlAbH/1EEIMyAkyqmB7eH7O+/HsPrx3SnDvCRWEpr/xByarkJS1t3DXUO2uvkogBW98v2fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 29 December 2025 19:50
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
> On Wed, Dec 10, 2025 at 01:37:31PM +0000, Shameer Kolothum wrote:
> > @@ -259,11 +305,16 @@ static bool
> tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
> >          g_free(vcmdq);
> >      }
> >
> > +    if (!tegra241_cmdqv_alloc_veventq(cmdqv, errp)) {
> > +        return false;
> > +    }
> > +
>=20
> I think this should be called in tegra241_cmdqv_alloc_viommu().

Should/Can we? _alloc_viommu() will happen before the Guest boot.
Unlike the SMMUv3 vEVENTQ for accel case, we restrict the hotplug
use case when the tegra214-cmdqv is set. And as soon as Guest setup vCMDQ
the vEVENTQ is enabled here. Do you see any issues with this approach?

Thanks,
Shameer



Thanks,
Shameer

