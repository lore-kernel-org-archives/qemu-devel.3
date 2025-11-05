Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834ABCCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 18:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGiKK-0000Fe-W1; Wed, 05 Nov 2025 13:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGiKI-0000F8-Qx; Wed, 05 Nov 2025 13:33:46 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGiKH-0002PY-Ac; Wed, 05 Nov 2025 13:33:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1YjDWFZK/qXGGKni5XrOwBtTtm03/MN7g6DbzqsthqSuT9MXHG2XSaRTdKi5TZ/w36rByAv48LCPYLMaJX1phvsrNhlp7ypOlJ+DkUG4dSYD96MleFAkYTd3GzSqFeIBgBWbDyv4Czp4zW1xC146kl6Oy/rpQjOY1Wo320XXqvu3ehMfygHbenI4RFDVMMhsTut0S38XLB1XXUF8/ZL28ejFc9XHYad/JIZNpXnt/y8ITe+CSXPPrQaGNJAoVWk3VFV6ET1AnVDUhXnfQHrT+wDtWpkGQuZQF1rTb30YFnDDccXUXj/0CcK0ttCdpotjEastgGV23w0Sk/r3DzFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hGtXpxcfzLPC6eQLrH9MeoFFsJ2hyPsaxe2lHO2+Xg=;
 b=NtWf+myclT9bxLVeZDC2pX90YJqYWW48easYNrOO4teiSrSjGu36ncxcg9re9dmKwoDEVqBzrOTCcO7w52+oyONLNGe+HSE5x0JwKXDcydItI9R3XtbeS7T4l2Hzqo0IoBKklTsMjFzlrcHebjZJ6OWRNKfGwdIH3/xtzaP5+hGO40cMx/15/Zd7+/MbXJCDTx1CRiH3/adkB2s1iOQ0XAYQS53Jf1XxEZuBxqgamUgT2qL9t0Rx8PtkJRZSITeQfdrO4CIeEURWElnu2wqLxJZGmYd4wHTgOki9PDvjSRxRjmmzcwpwRXN02MfN+4GpqVaaYK/IcvrIj/t9Ty6Mdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hGtXpxcfzLPC6eQLrH9MeoFFsJ2hyPsaxe2lHO2+Xg=;
 b=Px9PfvjHSXTeZ4fRT/DSaDq1Zq3tOH996cu2TKJGzOEJeOr7oDeXh0Pun19ahrnHL3Rw5CbwQfP/rexuk8GSDroEoNfjQx1ury/WcJqjzIqI+RhLPBm6xNbTdwBLYyoPVUDttM1Om6EE8zqIgNBliHsmA+cPfSatSq7novyO3InLRE0upHKwQVUBFSHvdLme8ZPlxAvZXYpYqi77trkZZrUM2e+EBQ2wXyJCTLuLFOPoaZtGgXR3ij6SOT/bNEG5MzRDNAObndej+o6EcfO7uM34dea/Is+s/sueK1IMuv5OolOB4yb86+Et7KzWb/zSGo0ps0rEDUyeDO1kw3XgVA==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 18:33:38 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd%6]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 18:33:37 +0000
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
Thread-Index: AQHcTZUAOcFtPNqTvke2OSuQhL/9/rTik/BQgAAD6QCAAAbV8IABKlWAgAArhdCAAGKOgIAADMeAgAADZyA=
Date: Wed, 5 Nov 2025 18:33:37 +0000
Message-ID: <IA0PR12MB75551C1D35E27B9614C32AB5ABC5A@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <e4fd6d1e-3fca-457b-ac6a-69e721d799f4@redhat.com>
 <CH3PR12MB75489F2161213432D34688D2ABC5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <7ac24d9a-0caf-48cb-832c-812fecc5c82c@redhat.com>
 <20251105181049.GU1537560@nvidia.com>
In-Reply-To: <20251105181049.GU1537560@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|DS7PR12MB5840:EE_
x-ms-office365-filtering-correlation-id: 0510681c-1af7-4000-0b9b-08de1c99d5f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zjzztoacacjzuy+bh/6Bcu81vngljM1uis9JANnslgT8WW4bQn9UMTjBePrc?=
 =?us-ascii?Q?q5JzJ+BKIgp3furQxlEMeC3t6nfhRNLVUiPdnQMpab26NY2reGZbUhEiKFLe?=
 =?us-ascii?Q?WA3aMYhXKaf+qkeBYOaNXtZXDzj3nT3Y4dWQkKAw41FU2YEvuUOPjj2asECf?=
 =?us-ascii?Q?MMifN7Fy95BoBCalaRKjIiqk4NuwJ8UHhE6JY+pbOtE9CHv5cZTEAi+4a2lp?=
 =?us-ascii?Q?cduzeQU9Aep64tuF95RBaeSsNYGF1WU1e+M7Nnf13l81MbGJ06Dvcz0CEgo7?=
 =?us-ascii?Q?sz5wKCFlNlTkNG/DEE9vdCSavISbV0ABelfRgODxrHn3Ik2HVdCsRk4fNSar?=
 =?us-ascii?Q?iHlwmugykUbFTu/gfN9rUzXb/zPRL1cAXmPCxKA09kK7IUYMudgwVlvadeL3?=
 =?us-ascii?Q?yvpaTNKKImE7yn6wl1241ttkmMJBgSNAy97Po9waY/Zk6R22ByZeptkcECJD?=
 =?us-ascii?Q?R25kX0NEgwOY3g/4pziNfbXCtM3rNqknrRB9PSGA/xvELLOMA9F4erwqBDr6?=
 =?us-ascii?Q?ECFhMz1U7c2wLrY3dtqOGz69WnSzJ21rVg1GoAKASfnhoN/h/ZrozU5+vYQm?=
 =?us-ascii?Q?Vrtp5IiAG+dlJFATOXSXf2nBIodmc0eLH0+aCiV5+cSNtp6TWNdHEvLKwfU2?=
 =?us-ascii?Q?JZs/x6RYSgJG3fnRFr9PlWpH3R/IUYtJibWlIRtv4hNk9xnIw1RbmRSX4jx0?=
 =?us-ascii?Q?hk6RHjwXYuL6WZBtXO7OrxSUx1g0YTP7mfIuf+IGwbqD0x1ZNq5pMWH+Lgo3?=
 =?us-ascii?Q?mVHOXPCY45SpMd9kmN8QMEGvK5Ie4kwBsNcYPDlR6g4gQP2t3QOktAyNKLC5?=
 =?us-ascii?Q?4WBL+FsaJHjKXGp0hz/keCXswAp2RTI0Lgunaq/Xd/EJPOvmbAtFVQNOJne7?=
 =?us-ascii?Q?p+n9eemXJOArG6FzJFzRjs5D31ttSkJrYiNQZM2fjLnw2NUcCFvHqFST/Ebm?=
 =?us-ascii?Q?KR9dfWMeYsZS4y3sfGLRS9P/UpuY9Y/5hNhTzED1xnC36A8tZFKfCmN8Vr7H?=
 =?us-ascii?Q?4uCSKiM/7wbkkHxCQNxMSgU4eC8Yi/e5QbsZJK6FPr97lSRMY/ErG6GA1h9t?=
 =?us-ascii?Q?0QT/XDBVHMXqO+i92y3+H7DM/SJuUWBueSvw4zdaubMNbh9c13fV71VCAN3v?=
 =?us-ascii?Q?CS7uAqKOW3we8873YWzGSJAmwHbiedtw29lGcZalsge2CRjrr7FWnQ/l03BJ?=
 =?us-ascii?Q?EDUQzB1yJsWS0Ya54y6FauGY+9/7FBJvSpkT7O6W3Whs377O+kGRcJdEEltG?=
 =?us-ascii?Q?5P57m3uWlIPFhV3QthAxAogIS218VQKxyQPmETIyV4+VUot2cQCXJEKP/lXX?=
 =?us-ascii?Q?bUH+c4RToOpeUUEg+2lqnG3Zn/eLuNdhtTaPS0XAhlAlsBPniwPDwm5d+G2Q?=
 =?us-ascii?Q?+PftEF9ybcAlmK4DS2g7tCPml09mmt8BD9pbfsd3j5bn68NhAKf5Vk1gaA2c?=
 =?us-ascii?Q?wWPOdaZA6T9y7p11Vk+YO47L6XMn2X80tbWL+p77aIkTkYXLBzkiasMqRT6z?=
 =?us-ascii?Q?HesD4o7O29uuaIz3JFNNnK3K0kVmIBd5FCI+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w+WEdlBWf43TIwhMF55jRkktCIAoF+KhgUJtyHdKXaT1hHV2CvzhOH64lOi1?=
 =?us-ascii?Q?iuEIAQnZ7UDBJfXyjLPrqJH3ucZzRB2gVsqflA/zAZ0Rl0T/WZG9HaS0L4if?=
 =?us-ascii?Q?Bb4BN5GlOg/2bjlYKWwGkN9t94sz4+a6TUhittBSFZik/QkvqRxY20fjv5zu?=
 =?us-ascii?Q?rGv1+EeEY21C+6v4JZ/5zj8O6vwL2Lotxdq8c84CHbL/SN0PaP0A3nta6Kk/?=
 =?us-ascii?Q?3fZd6XhEe9DkRtJvi+oa82DsnVOzZSOSdx4Btce9eXsj06Z/SKF0mQgCko+X?=
 =?us-ascii?Q?4mNOYsNA3zQjrp5ONfmmNg8PfM7/mH0UX7uRfauRq3Xo/ojtJdzkIBLHzLeG?=
 =?us-ascii?Q?OCjglcahnOE/7XDU9ceYR3wYzYh+WHHL/6Z4cqcBOKY8x9EtGJMG1SLyLJa9?=
 =?us-ascii?Q?aBg8eRZ7fKVOLrt0VifYHWgHGMdIl/YDiZKyYce7Xyh1vuot6Cc17QFqi66f?=
 =?us-ascii?Q?xYVoJh1/ArRraCnzjox2O9tRNa6ZTp/2gG8dzOsxu6oH5ymuRsCnbaaCF2M2?=
 =?us-ascii?Q?mM40hD7o5XMJYdbY2dLlHyHuqnnzaqIYFfA1yAt8eTgYGsZqPosRSjPiqp+W?=
 =?us-ascii?Q?7WmpfNy8GjPGs+Adz2ocsKXUQ5YQ1wgb/aDU5ZuwJGKSwHwT8/KYPfZUcI4n?=
 =?us-ascii?Q?bIIxrVntfmS3F/CbzxlqiqiSWGjcwZwagqDsAfNSveN4W0Opr5Ix3Y53B5gK?=
 =?us-ascii?Q?bEJVwrn55dmYRg0aZtVhRRKw1Q51fQvvNXLci4rkSjUfaTYs7wvqtEHceWP2?=
 =?us-ascii?Q?wEiIJ3Ak77noh4pdT4DaP0ANWkq06ZZSnOvglDSC0U5WWva5jJAC6v+JTOLh?=
 =?us-ascii?Q?0jjUyH35YvTHZsQhiu7JHMlxM/jBWhRc+tkj+2j2woEBE2Ku23Gj6A+h1WaX?=
 =?us-ascii?Q?ZcOhI8/SZQDpe+ezcQYw6Wbu3slUzgyyUiVDZxK1ab7aAEd6ulOXYUigafwF?=
 =?us-ascii?Q?OA9NLBpDnnV5V8wgmIvx/OdtrG5oBTir5mQcYPXh/cxDsOOBEXJQjY+1flcU?=
 =?us-ascii?Q?ZCHjuUINFPHm2COD8EM368n8KFf+1ebjyyaWWp4mNaej4/y0WKd9kwkxI/yN?=
 =?us-ascii?Q?gmZULMNWSVH85ZPa0rtr0KH88adL2Z+2/wp1IlzKy4magwMeqgyz06AxlOw7?=
 =?us-ascii?Q?pRIdODfQIQo7Ah9pdzP+EXvbeoX9j9h5FOSNbMS3q6Hvsiks/+ycpl96IR+z?=
 =?us-ascii?Q?OoFuh5+PAdVCCgvpqJ/QOuy56vOU+05Ja0aqbLwETkEVVbYYPyQmSjIB2DWB?=
 =?us-ascii?Q?0ivfUTMb0PlBY8zHukLfdS+I5O2TINpgJnvVYHaVpEmB3mnRByIdmg3dtnKT?=
 =?us-ascii?Q?sr1TZLxid7jfcYR1jb0h4uY1xyPuC6u+9hMakAhd+lwYPu1+R+rAonGlg1uR?=
 =?us-ascii?Q?tw9BBgNjmO+7lNufg+xGU2cOhzOTFm/oNT8gSjT++xFAYf4YBTBDIEBBDX4v?=
 =?us-ascii?Q?p3LGD+T33d8Ndv8TnVSkrYne4MnCQKBG0bLyeFyaUOaRAvsK7fvGzgIztfpO?=
 =?us-ascii?Q?HYqOLfMqKlb7Pto+V1sCgLVVR490oxb2zCV59ul3l+FZrP8honYmpabjQUdM?=
 =?us-ascii?Q?q5824bJS+Z6YcFriUtwO8pTpdDsu2wOpHEQE5zc+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0510681c-1af7-4000-0b9b-08de1c99d5f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 18:33:37.7925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJI1X3B+dbnc5azXz+kfqQVQ0fFhs75D/AtcKwMqEgNlefV9APMXjM2Mg98jPRerbGJ4nJAhdr/Y9inmeYPWPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 05 November 2025 18:11
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
> On Wed, Nov 05, 2025 at 06:25:05PM +0100, Eric Auger wrote:
> > if the guest doorbell address is wrong because not properly translated,
> > vgic_msi_to_its() will fail to identify the ITS to inject the MSI in.
> > See kernel kvm/vgic/vgic-its.c vgic_msi_to_its and
> > vgic_its_inject_msi
>=20
> Which has been exactly my point to Nicolin. There is no way to
> "properly translate" the vMSI address in a HW accelerated SMMU
> emulation.
>=20
> The vMSI address must only be used for some future non-RMR HW only
> path.
>=20
> To keep this flow working qemu must ignore the IOVA from the guest and
> always replace it with its own idea of what the correct ITS address is
> for KVM to work. It means we don't correctly emulate guest
> misconfiguration of the MSI address.
>=20
> Thus it should never be "translated" in this configuration, that's a
> broken idea when working with the HW accelerated vSMMU.

Ah.. I get it now. You are not questioning the flow here but the=20
"translate" part. Agree it is not safe to use smmuv3_translate()
in an HW accelerated case. We need somehow to hook into this
path and provide a correct ITS address for KVM.=20

Hmm.... need to see how to do that in the least invasive way.

Thanks,
Shameer



