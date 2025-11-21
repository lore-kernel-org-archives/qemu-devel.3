Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E14CFA76B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMONP-0000cE-Qg; Fri, 21 Nov 2025 05:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vMOI8-0007lA-V3; Fri, 21 Nov 2025 05:23:01 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vMOHy-0001Eh-8o; Fri, 21 Nov 2025 05:22:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7WonJWfv2LNZQ5FYdautBZSCZ1TjB1W8xskYTg5mxjUejGdr8DTUn1/XSjVoSL/kUgpUzfAKRvk6q7CPvPyl7UxD0LgQiHjzNI2yV0UPqCbfr1QwDdWUi0w76tjucmkZSeXtV+xysqWaKSLwgU2AYLC1KiJYDcKJwrx1JpZigwEfizzilPh5i9iFiB1xxtEWfCb5BmtmC2Y1SA5hCxKRRFLshgGMY6Q+jc7OPSKtugG2/HQhi5Z+k+j7/X48M90Dmf/O+5YsxKPsCDIusLSiE6HbHchl83fyl0bkF/TbU1yaFFxwcfU5vFGoMN891Fx/NBvurEAQx9oe6m8+b9XVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkdipiNHgD2YBjJihTPp2q34GZrBZ9P9Zc2OhHIDqWA=;
 b=VXzwcjCx6bv1MjPo3W5+rEyHZAi3+HHKqJWqbB3s2QJhGc+hteJpfPKF5nu3ir2qHVVl8CBXHXMzM8LPxwPZu9AbK3uyMKOCElTnBJIyI4g1sSlYXEZwyYEQi2Vpqn/eqzbiSBsnQAz+0oXGk0iiq9nInTEN3dr66VdKig/UrJULpKCkUGJw1Vh7WtDlgFvoWR3M7N0FOXGELXtatvCF4ouJsfDCrm6nzN/TQ7AwtRw5MMvqh/TLjsTXvSPkVQ1KVUPp+As76+KDssVH1Pq8JYQHxRaDrI1GkP6vjBJaURzF9ojy81v0AQryY2QAu5+vNLT2uFcV3EM9hZdyNK/PNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkdipiNHgD2YBjJihTPp2q34GZrBZ9P9Zc2OhHIDqWA=;
 b=k8wND824Bp8Ta6AQ3j6OYt+XK1G9YuFgkW0eWSVa29P+rHDZXN7x2DPZoVMT03nytlmnjandzEyIdcAyH6raZZYVd/V2ApVx/3ynYgCnFbLvMUgCyNxjdMOpo1/vzrVXCFAJFRDEC2CdMKzSGgvy8xVj/ObK/i3xvhvhIxS+dIYWmxLxTYkTa5yyT2PZA6kkgsWFT84B5iABh25bVdb8dKg1gGVl69gNO0osiuExoOJ8HI1PdAiVPiYyVx6fP8t6TXI0gBa67VgLQx0/dfLqSviK0esW8wJ8soKVsH4BB4n6EWOPuB/ebFcrYTD0SgwQ9jcSdc5F1fU78LL01weIIA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS0PR12MB8343.namprd12.prod.outlook.com (2603:10b6:8:fd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.11; Fri, 21 Nov 2025 10:22:21 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 10:22:21 +0000
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
Subject: RE: [PATCH v6 33/33] hw/arm/smmuv3-accel: Add support for PASID enable
Thread-Topic: [PATCH v6 33/33] hw/arm/smmuv3-accel: Add support for PASID
 enable
Thread-Index: AQHcWiFqHSYhBOGE40atlLYpe09yo7T8IHEAgADKkVA=
Date: Fri, 21 Nov 2025 10:22:21 +0000
Message-ID: <CH3PR12MB75485354E16E462D66567416ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-34-skolothumtho@nvidia.com>
 <aR+RngqP3HTLZIlH@Asurada-Nvidia>
In-Reply-To: <aR+RngqP3HTLZIlH@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS0PR12MB8343:EE_
x-ms-office365-filtering-correlation-id: 390df915-a759-4006-499a-08de28e7db4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zQ7rEWC4bE1QDgL1TQPRX5tNaqNRdc/ztJBSp7VIYqnJIcE7kAj9C95GvTWe?=
 =?us-ascii?Q?/s4//hRsIYkm1gLfrws69+7q1rgSB7NPhv2Bkq+Pgc6RoOdVggaGfPIeV/Gu?=
 =?us-ascii?Q?R3skAs1CbUlf0nHBQ0V19CS/RoGp4Q+V6U5kVxpukwXnYIhCT/pzzoP2FLtt?=
 =?us-ascii?Q?QhZc0jE2ChYwpEhh4KdkZ6OjPvvzJdXEsQupLyQlT9Xhmeflo26L3uI1F7Df?=
 =?us-ascii?Q?MBd2h/M6SuKE72fJ5pEuZYz3TYlC268OF61JG+VHxu+MkPGcNzkxVsQsZ1oT?=
 =?us-ascii?Q?91cokrdYAKGEDzdhCMzYmCa4Qo/S7r0BmfvBX3ehFteW+u9bDpBj7rVUGM/i?=
 =?us-ascii?Q?ihIhWT8ocb0yUMrKwTf8tqCGqqajOoRBLr6hvPrjV7A+lFqtlV44ymkhuD1k?=
 =?us-ascii?Q?97qHj6i4izyx5iYlpMFy2QvpGtZg2n2GMRJQMStt/C69f67hMnXN+LIb4BOS?=
 =?us-ascii?Q?pMJyZomvrkURBbG1+800RzFQX/wSPwMLnru4dW4YV/HFs8kcn+U/XD4iP+e4?=
 =?us-ascii?Q?/S/+7ZW1mtJnnyIPPrasUWGx2ROUoqFJ/nlbLuPYTgvDL7RfOw2b7yZCwW+I?=
 =?us-ascii?Q?lG8Q7UwxqukBWle2kyIXzei7LYjpf8vqKmYSwzhkOtOEsnG8TGmxkMeNpVCq?=
 =?us-ascii?Q?pSHTFHAlri6o34fc7BXWK9DOouJPc5GCujBNZKGir0G71WOF++41nahJ9zvZ?=
 =?us-ascii?Q?wBG5XWxiAp59BSQrp0JiICHWNRWrrbHeCoph+0AH22YybZjD0NcBw/rnAXlF?=
 =?us-ascii?Q?l9NFE4YK3zc8LxECOti+Frvi3+/gknBJu6aym8QQuptUfJxwrpKrQ/81mV2u?=
 =?us-ascii?Q?XLxptKIKgGhWNyYWB0DIfbmQBlMvu5bgiM8mF3XAYmRify52BNPHzHWnu6aw?=
 =?us-ascii?Q?go3QV8TSnWm15ZEEd2J5Dq7mVFm1081HUIP1SV09m6RV3RijqCbNvWrxBxzd?=
 =?us-ascii?Q?e9/jrI6ugeUM15E0FmQ2jBf0kBcilp67DjYqqHlW8z9sB+zHPyAbrn4nJawQ?=
 =?us-ascii?Q?0n6vbhzle83JhN44q/Mtuhknz7gb69MPTLMbHtN5Q1E16lye/UVfjzFijdOp?=
 =?us-ascii?Q?JRpbJZr0Ky2J36Zep4J0tMAufXuYbAgVFk1ay0iNTPOz1+CSCsbWOwZJ5cFv?=
 =?us-ascii?Q?cwsExZAIMRIVzTQXDZODX9RBQwj3iZSL0d4M1kW0UvTZejbrhcLZmVkWWWEL?=
 =?us-ascii?Q?05kGAFrRDgSrctTToXVowZA+3vWw9/lIs8MgnGXwm43UY0ev+/ayeFRrfYLe?=
 =?us-ascii?Q?+WY7s6eIiupkbO/gw2wfXMBLv//wSg3ez9j6sAfoBFWLkZzi2j0ydvQTmLxq?=
 =?us-ascii?Q?JCRv3c6KkOHUHGBRTtfoRVfDTZ8v+vEDKk0tHAGSlf/LJhMOY8VophTVVMPW?=
 =?us-ascii?Q?DRnQPVoHgXMHGTMM2EOBX7ZJCQRfKSDGiHxhAmtxSSxHHisDiV/WPpSURVTx?=
 =?us-ascii?Q?LPFFYjPnBmSW8ugFcNyDudVG/pLszI6qS4dsQ7pSW74rg+ZBo5pfTRFjThEQ?=
 =?us-ascii?Q?W7mvwN4OHgCIHZvndaX3XWSf82+GENS53jiE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QAKzrbtHIhVPHdNYKwafIIwB7xSKmqZx6rypgHjgHSycMH622bZrw48tlNYI?=
 =?us-ascii?Q?JIOR/TS4inCJXt94OIxOS4yOj7oqlcGzRZArFeD5VtgNTGJPyK7RHqfRtuhq?=
 =?us-ascii?Q?KXC4EJgrqBtj/txQssYYwdyqMmrCI/+RqXnOkW5zqIY18m3zA2wNZ3evxLsb?=
 =?us-ascii?Q?RrkYl3G1fSMlKyQ2SVyx2H7+sSIJja7RTRaIbkrnBQt8cxxNRojMy+JpSlxc?=
 =?us-ascii?Q?ldA7Har4sbKKwgIYmHcZMxIE1+d7VZzwrqofD1aBsczF5hG3xP7Rb9ScDrzs?=
 =?us-ascii?Q?uD9VIUnQ/GlCyti32BzlR6qhvXHBe8c4a9Q5m52KXB12EQ+N8mXTZPSJtX+K?=
 =?us-ascii?Q?ukfW8qE98fFZuMBec162LkzOB2IWMaa7rsnu4S+rPbvF4L95fvtc2orFlzlt?=
 =?us-ascii?Q?xylgcnnhWVea8jsAVfH2fa/sTbeEsuPGcjFFw32fHr16os5PgQdH4eFP4Quz?=
 =?us-ascii?Q?68b+LE56a6BFXAs0/aVL8tiL3w6fxhb+rBB5e+tD/tBNT6vF2T/JGy8V1Xm+?=
 =?us-ascii?Q?sNuZxYo3MoWgHwLp2mQ4b2PpJ1zcn9icE3jI92ijOW4e6urFE48cgCQAPSIN?=
 =?us-ascii?Q?e/mFIjmUllDHVdNaSyiIvy9CvPX+Z9R/LxHOX6r3P/GKBw+rMRS7ixp3q9UN?=
 =?us-ascii?Q?Z0dmqIgryDMRUVSsFZ6UPwAbfVSrsSL5IfRfxzwfGhhaC8nz3X1gAcOOItDe?=
 =?us-ascii?Q?swJYxYe0qNOTUA5v0JpkzMhqkRi63+2MX/g5VSXUsvuc/5dlIO6HjNIBXCLL?=
 =?us-ascii?Q?WhfBJkpGIpauFw8Kd0PqTG/Bk/W7ns2pR77rS5DFPdEkkvmuBhJdGKREB9wf?=
 =?us-ascii?Q?L9f12RQRitmEUJ+XqEOCyl/pIssBBvbTdj5klooPxdChcpqxVm9DAEwhvEBi?=
 =?us-ascii?Q?Etj2PeO3Vd4eUO/uUL+zepYklETFKIg7KHc+6gLVL/LHQwBwriJZ+GchRSH9?=
 =?us-ascii?Q?cmQ0c/PCqAneieobOLcQ17iTB7AJoqtmNkSNOoujf4zZA+ybFrnQ9R71uX2n?=
 =?us-ascii?Q?riEt9tRWC4X5wlF58wZGzqm4CRcHWbGlLVGOM1xRvFNbIUXi28W97Q26iFcj?=
 =?us-ascii?Q?KKPhAXRHeRhmtysuQCDiG0/L4s/4CoR/vki8iRFlMKhMyuS/0BJKYaUWW2gY?=
 =?us-ascii?Q?7p4qlITPBv+CzfBIcli+DBXeQnQMBszXY+YVyBPk0klu++b6fmllWmAMgdQk?=
 =?us-ascii?Q?cm3LdqLrT0zlfsYsxOlleWSc768we4WK6fuZB8ra6fWXVULIeNVvkOSLlXW7?=
 =?us-ascii?Q?MsdU5oUXPjtVKTtG2DpVQQCBnDHYVxp1aeNO+OoC9npdwpgJDFgYpWwE7ArF?=
 =?us-ascii?Q?8jNkM3O5iONCLFJEMMPWVsAdWP0sePOLvola0j0Drevr/FpXcDlHDUns9bgC?=
 =?us-ascii?Q?rNTd8Y5Afp2NVBbuHQXP/79+YuVfyO+adY5cBWlR2FvrNX36R39Kgvs0Ekl7?=
 =?us-ascii?Q?aBQuTmQ09NVa5PoikvFICg4sWnbijObosGWGtdJro83+6OVfuSsmWk+gWAko?=
 =?us-ascii?Q?zCURqkOS/zj/CS8Q1kaEcFyBF6y7S3xgVgeWvSVjN9gWwOHJ7h6MEIWnCtyD?=
 =?us-ascii?Q?hv58Qwrw7OpiGLt+dgADQ5+tusM7Ah0VSaPnN51g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390df915-a759-4006-499a-08de28e7db4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 10:22:21.4421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vL6bVqBdPcPoT6UIILCuusUno5fmTta8A22o2FB+Me+SdTVyslqqiUS6DcZwd0H290rZf1j0anBQXVITG1p70w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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
> Sent: 20 November 2025 22:10
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v6 33/33] hw/arm/smmuv3-accel: Add support for PASID
> enable
>=20
> On Thu, Nov 20, 2025 at 01:22:13PM +0000, Shameer Kolothum wrote:
> > +++ b/hw/arm/smmuv3-accel.c
> > @@ -67,6 +67,12 @@ smmuv3_accel_check_hw_compatible(SMMUv3State
> *s,
> >          error_setg(errp, "Host SMMUv3 SIDSIZE not compatible");
> >          return false;
> >      }
> > +    /* If user enables PASID support(pasid=3Don), QEMU sets SSIDSIZE t=
o 16 */
> > +    if (FIELD_EX32(info->idr[1], IDR1, SSIDSIZE) <
> > +                FIELD_EX32(s->idr[1], IDR1, SSIDSIZE)) {
> > +        error_setg(errp, "Host SMMUv3 SSIDSIZE not compatible");
> > +        return false;
> > +    }
>=20
> I think we can print the values: host vs VM. And at SIDSIZE above
> as well.
>=20
> > @@ -2084,6 +2090,7 @@ static const Property smmuv3_properties[] =3D {
> >      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> >      DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
> >      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> > +    DEFINE_PROP_BOOL("pasid", SMMUv3State, pasid, false),
> >  };
>=20
> Instead of doing a boolean "pasid", perhaps ssidsize and sidsize
> should be configurable. Then, user can follow the not-compatible
> print to set correct SSIDSIZE and SIDSIZE.

Do we really need that? Currently both are set to 16 which means 64K
values are supported. I think we can make it configurable when any
usecase  with >64K requirement comes up.
=20
Thanks,
Shameer

