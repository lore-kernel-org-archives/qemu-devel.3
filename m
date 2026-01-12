Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA26D25041
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 16:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfKiC-0004Nk-7C; Mon, 12 Jan 2026 11:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfKi9-0004KQ-7b; Mon, 12 Jan 2026 11:24:09 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfKi7-0008Q4-IH; Mon, 12 Jan 2026 11:24:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4LzG35YKQD27unUk/05ku/cxHNSei+q6XS/ovcW933o63js9I5ZeCjtw08+cskPp2hf1Nq0Gdltrke3kOoeh2nZWC6tGch5wGgdLWV7rZGDJ6WFd/Un9If8sdZjk+E3nbyLWCgji4op1ovPHjIyoH5nA4DeMQ7JeyE4ljXZAMt/IKMpC/daxtyATTAwj8o6+AjIMFtfo4sY/Olsdni/W40pVyFvCVrCquBKxftS3BwYPXsFTp22wp7JTUkFafTEnrMbS+bNuiJlcYpiKvOPmi8+STSsnAovQThNOrOyjBb34rOa2pusnIl5GNYB5+O4IgeE9rjmnD8bE6bSnt7iDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1p2HBNEBHas69YcCxSWku5mOWA7yQpQkpiRuEa6eOE=;
 b=CU0a9DuxBDh5SAiYe5V7ud2W0AQBSq7rKeTRtwWNqRtBWk9F54SYd+oVE5qyJIwvKHRoxT/2z5h3Xc8TP/N1x/dHrNZHf8gvJekcSUsRKa4LgmlnRLA130jW457wzC4c5un3xINsOowxi2RNWzrGRW93OnjAVK0lIzqWJBOCAoFhZM5nySl4NazdTzSngR8oU8OauW0gDVJR2JIrH3kc1YGALSLMina5QLAlEQO/ugWt7ZHk9Z3XIRnPuABYG6HNnjMlStgPCbvLn6WycaiskBzLzeUh5918cqpw2gdojF0SSGlpDRsQIGxZwFOUP0C+UOF1wQ3IAqPg8oh+WvH7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1p2HBNEBHas69YcCxSWku5mOWA7yQpQkpiRuEa6eOE=;
 b=rdGeQR0mxMp9gCstzweauwnp9iHeHNEmxHE9Y0w1CorIh6c1yhpGtvKjuNJAxacsphJC/MYHurryRxiTVVCesrzmGyDBPasT7zQQkuh4Z5S+qT89amgNZzE3U8cVVzsnLsqbjhQFFm1S7jzgx7SxDVBjxxgBZDWqoxQnVa8Be98xINIAjm2QDP2SFZneKybr8tnsgEl4jiF0t4G70cn3oxHhI90FF9udjD5Sg8rV4MN1uCAQAN6kHsL+dwxlSloSxR/oZTN4ZUhNNtbqNz2W0j73cSeTD6BjM80F84L5Ukwnj9OzyDc2h1GUkTiUXpaW7LQjYKH8Khu0xxJNdCpq/g==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 16:24:00 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 16:24:00 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Topic: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Index: AQHcc0r/PShlE7i9HkafE8JAYPcnrrVIH1QAgAAPWOCAAYu5AIAARN1QgAPxowCAAGXKAIAAb3qAgAASR8A=
Date: Mon, 12 Jan 2026 16:24:00 +0000
Message-ID: <CH3PR12MB75482E793CFF27E0BEFDE767AB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
 <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB9136783B1EC050DB8B655A2A9282A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB75487D6B81B1C6556E044B6EAB82A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB913696E604E31C678F7083979281A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB754866E17D778C5836903444AB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <d999a43d-6879-49e4-b93b-f50fdf19f9d6@redhat.com>
In-Reply-To: <d999a43d-6879-49e4-b93b-f50fdf19f9d6@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM6PR12MB4234:EE_
x-ms-office365-filtering-correlation-id: 826e34e7-93f8-4de0-a1d7-08de51f6fe6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bvOhKhSmqRytL1JYlzWreMzuSQ8gILTerBJSHYlOMe4a4CPAae7yvhAd2V?=
 =?iso-8859-1?Q?2TukvCtCuMDz7hkoPD7xWjWHqbzIQxiYOv9D1pT1ovFGg7ttFx8XilcuVF?=
 =?iso-8859-1?Q?cLeqTgb3ZNMk08xEsc3L9oVmWrhfiHN4kpQMzY2I1xzqSOqOIkbkMLc6jS?=
 =?iso-8859-1?Q?C0OvlvIHHuy7N9LTTsB1oNleuvtw1EusmaiOQHnqbTAbnldo3Izfft1SMO?=
 =?iso-8859-1?Q?y9Fvbu1S5W7mqsXrvuasM/e4Mhp7NerwGJC+3XOmy62l/qBlfYhhq2Inz5?=
 =?iso-8859-1?Q?Npcq/dIGs4Jp4wIsmYotQvFkb3BvsaxPjc08RrGUiLHwIHmt1ctY7iZDix?=
 =?iso-8859-1?Q?qhofOEVyTxUqzJ3aRHn2HuYnonV3wvxuduCT+OoRBPiQotF54mDS1krq25?=
 =?iso-8859-1?Q?l0Dr6k85ve3fMOiyRm0EtaZRoF3mzOhQe86zad+1JFTwCm1v0oQLFTyDvu?=
 =?iso-8859-1?Q?mNdRracRR6X8IsFjd2KrD756Ib4beeef/WxUT5HI0y5Xl3nfcvC9FrlJu4?=
 =?iso-8859-1?Q?Rjlhh6COWjPL4msL+hS7jWKwFsQmNJN1KM2zQ1bA3iwGcw3sMIWncd/PHM?=
 =?iso-8859-1?Q?8I2bBxe3yj5YZyC7t63BRh4J2H3CNQLzTGgf+4wNxq68Aqq+FE3kvne/Wk?=
 =?iso-8859-1?Q?iaqku3W5VkPk6DnK5YF/J67IekDyr9kUuK48w12V4bl7XZf2M7JutxIGmK?=
 =?iso-8859-1?Q?d+k9VoRLy/x9ZOsq03Gslq85AAqwBWF4hXYLXwaCEHzdAuHuHh6PPkiOqz?=
 =?iso-8859-1?Q?PzfHSqkAWoK8QFeFB/WOYIz53swrPjWuAssI7tljPFNQnO/8sJeOxwPkzv?=
 =?iso-8859-1?Q?wpMazyRTr7JTPAQOebDKNZhbBG3Nc6jx5QdzxTyWP63KtEfbz+qPkkUB77?=
 =?iso-8859-1?Q?N+2JVP5HRYgrV4pQYvxZruQWCMMzZnPx8zOB7PNBg08qXt3O514hYuNuTw?=
 =?iso-8859-1?Q?3wlpyhyi/CcbtLLYaO1MTM9y0Pbdo5X+/gimChaFOxMHQDW6bofhNhpcBG?=
 =?iso-8859-1?Q?pG8Gm8aIh4vT1WbMsTD+QwfO1dZVL8dwWprhmXCdj3PLCX6MIdZBVryPN8?=
 =?iso-8859-1?Q?Pwih3sUvH6Zw0d+CZY1cL5fD3krw2/uKxH8qVXPsPGyOeAQVtWfEN6A/Ao?=
 =?iso-8859-1?Q?kgHvDPg2L0FMhGt2bh7VKdLXgaaRio0/VHals9QNginsHxpjTHfI8/0jdg?=
 =?iso-8859-1?Q?q/2xW/MJDff0iZp75CSJsskmNssWl8a5/UYI5nOTa4FftUMKKa6lQ6iQNu?=
 =?iso-8859-1?Q?x3kDKSX4P530Cxs1jCu/hGu7HH0WNEi/8D4AfBtS7OAu/fQ8cSYgMwirmG?=
 =?iso-8859-1?Q?QWtDyrEl29KFCSY5c3PbCiCLeSsANegMx3Ivun5ZnQCaV0HuZrNeBYApf/?=
 =?iso-8859-1?Q?obqwpYfe74H8+SsxSolbskWwhRj8QeoB1uHue7rVYxh1/OKk1tYMsiZL5G?=
 =?iso-8859-1?Q?lOVfLIniTyVfOhcCZSKaqZbXMB/4CrdUp5nfyYU8Jk7NzCzBkasEtuiuB4?=
 =?iso-8859-1?Q?MwORXDRpGTVmzGX2Y4BWNK3QNnUzxO9rg9ob3P5p66RHEpxe+I5Pbt2MOi?=
 =?iso-8859-1?Q?n/zhCJ5A+LNyTPVMFoCDApQDc0AC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rZZ2hosPNLX8fDP4M3vuCPFx0hiwSjkFRe6Sx97rBhAMLTBP6eWMvrgETC?=
 =?iso-8859-1?Q?xOnzTrRAKDQamHSzkV/WksefeUEJHtEjoZ5iW6kvCxcCkZzaQ2tM0c71DQ?=
 =?iso-8859-1?Q?sjCdgr0ROSz4lPHvtfSOkzEHlFYlh47VnuAFDoI+5PAPwiIIOKUo5U2A+y?=
 =?iso-8859-1?Q?ojVtEio9OLp2Gaasv9vKvAxWjdtaYhU4m9GwG3vuf8uUpL4YCbdtmI9Gzh?=
 =?iso-8859-1?Q?XKdww4ieoegWlrVqf/b2h1T3Dox+QEaiXoS7OMahTc85w8fWcgof0dQ9dQ?=
 =?iso-8859-1?Q?JsJUj/ZM7gBPkaCEpNmckItm2oZvntc3nrPpR1GGcLrjbn++LKLyxy9aVz?=
 =?iso-8859-1?Q?PRBR6L+0qxgcaZRCfsawBJeApRJ8DC/yBViFDXKOztk8rr6LUa2wevz/tM?=
 =?iso-8859-1?Q?HdknwFoa4PfPshm7KIiCWfUmQY2bO7xd9Sa1yTZN3OfFyd5/OhDpM1+HP6?=
 =?iso-8859-1?Q?O0xIWRez3lQX4qJBWw1z86c7nTsl0jQJKwwQhVW+Y4uVYxlflNl48lwisH?=
 =?iso-8859-1?Q?LJ2nsc3oi1BQR8uNHtgFnywtTLT7PrrYNoJgX3h/yluI11PNltc5CBM85w?=
 =?iso-8859-1?Q?G9Kqzqq1T0P4NmnNpTxGcEYZC21fToISECttiQcsDjpspSV7+7e59mW9z0?=
 =?iso-8859-1?Q?mgxma1Q1RACq6PXR1MxF+IGZLQ9N2tQYdFYt90q/L4ArFzAowqFRZwokvr?=
 =?iso-8859-1?Q?JCsAgLgBiSbRGkRGAR5tAAaQ3fl7/bhLDosxlBQPXyEWOogQa2QJA+o9f7?=
 =?iso-8859-1?Q?nhR0soHWp27jnNNZPy9tUIPIzhknzNFSKHCwe+JuTndaA4nfHvTb2Fkjn0?=
 =?iso-8859-1?Q?9Cxw+f6ctwow86duU19BfueDz2xVCrJEW9zmHGlgIt8x0dF85C0zbbXfuN?=
 =?iso-8859-1?Q?OiQ+S/kMJs+47/S5hsj9dvQbaqCmPO/+sKMp4bXZ+eLQf80kKnUG3Vnaw2?=
 =?iso-8859-1?Q?7glSksV+/9P+ZtJVMnb8c5sbpUgDkVSmAzb28N+ptPEDxxS1SYhaj7WoE1?=
 =?iso-8859-1?Q?TMP7q7gl9z39yHRj10QztkL/cuggU7Ne0ZMlUZapNZ2Vr0ANl1IwLBM+Mk?=
 =?iso-8859-1?Q?uix1aH4mHJz+bM4c0QMlh2Ikjc8Gw1GRRpkK+4yLAx5J8WKqYAbJ6eA1uJ?=
 =?iso-8859-1?Q?+aEEnC2BncfMmq4MPMIOiLl+ishH1sX4YOyxy+bN12SCnJdvNbGi0dEFId?=
 =?iso-8859-1?Q?BB1bxSoDKHlNtYHNlhcFm0QCeNB7oPP1Q0D9TqFT5kDEB8veI7b3j9aAFh?=
 =?iso-8859-1?Q?MeFWWtlgOiyCMTKDkvA0cK6eRaieNhhiKT+11VTKYXRzLTEUf/qVJrnz07?=
 =?iso-8859-1?Q?aHyol/WsVRPUSuTH4dnC+OCOOMKwbiYa/fpDxsI+zpswmAXPfNvBCMPiyZ?=
 =?iso-8859-1?Q?aRUi8fnyWn+kyHDpPjVjZ/YZJsTRbPe0w9i8eVieaTW6qyJkyPkaby3kYd?=
 =?iso-8859-1?Q?TQaYFWfWgHRlxR1HuW7ZlyeA6tRZpiFVF63As9I8atSZPbnMMtGPuNYj1h?=
 =?iso-8859-1?Q?mR+ZZ/jqYzbD+4+7VJwGfElx7uKhO39B+T4l6aQ4KM2Wipm/i1mqgsNzec?=
 =?iso-8859-1?Q?K99cmSenmQdavStPcFVnQlxaS5mLRsuq9gyyIiOwl/SXC2a9fDpgua306+?=
 =?iso-8859-1?Q?nU3y0m2KivauB3vMmZGS88vJTXnGSyBsqNwQ2KkklPNP3RvcHeU8XTvDz2?=
 =?iso-8859-1?Q?+StVtgFweFMyrzMjPoeUwJ/UVPogmbyPfoB31w0ycbsKj2OVjpeiHwz4tM?=
 =?iso-8859-1?Q?RJtzXz/6i56QUFLtq4M8meb7yuwaJdtSVT26tKFdiEzPyAEENHJWUCIiRp?=
 =?iso-8859-1?Q?6+kFlaKIeQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826e34e7-93f8-4de0-a1d7-08de51f6fe6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 16:24:00.4892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdgIvTkL3dWDKe6xH0ooanW0tglXZ1l495eFPKbGmgm7p+luU3AdeCkeYkWkHqAwMqOIHHg4tfC5Nnmvd/v6pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
> From: C=E9dric Le Goater <clg@redhat.com>
> Sent: 12 January 2026 15:16
> To: Shameer Kolothum <skolothumtho@nvidia.com>; Duan, Zhenzhong
> <zhenzhong.duan@intel.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org
> Cc: eric.auger@redhat.com; alex@shazbot.org; cohuck@redhat.com;
> mst@redhat.com; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per
> region
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On 1/12/26 09:45, Shameer Kolothum wrote:
> >
> >
> >> -----Original Message-----
> >> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >> Sent: 12 January 2026 02:33
> >> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org;
> >> qemu-devel@nongnu.org
> >> Cc: eric.auger@redhat.com; alex@shazbot.org; clg@redhat.com;
> >> cohuck@redhat.com; mst@redhat.com; Nicolin Chen
> >> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> >> <mochs@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Krishnakant
> >> Jaju <kjaju@nvidia.com>
> >> Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR
> >> per region
> >>
> >> External email: Use caution opening links or attachments
> >>
> >>
> >>>>>>> @@ -305,6 +345,21 @@ int vfio_region_mmap(VFIORegion *region)
> >>>>>>>                                   region->mmaps[i].size - 1);
> >>>>>>>        }
> >>>>>>>
> >>>>>>> +    ret =3D vfio_region_create_dma_buf(region);
> >>>>>>> +    if (ret < 0) {
> >>>>>>> +        if (ret =3D=3D -ENOTTY) {
> >>>>>>> +            warn_report_once("VFIO dmabuf not supported in
> >>>>> kernel");
> >>>>>>> +        } else {
> >>>>>>> +            error_report("%s: failed to create dmabuf: %s",
> >>>>>>> +                         memory_region_name(region->mem),
> >>>>> strerror(errno));
> >>>>>>> +        }
> >>>>>>> +    } else {
> >>>>>>> +        MemoryRegion *mr =3D &region->mmaps[0].mem;
> >>>>>>
> >>>>>> Do we need to support region->mmaps[1]?
> >>>>>
> >>>>> My understanding is all region->mmaps[] entries for a VFIO region
> >>>>> share the same RAMBlock. And the kernel returns a single dmabuf fd
> >>>>> per region, not per subrange.
> >>>>
> >>>> Not get, can RAMBlock have holes?
> >>>
> >>> Yes, a RAMBlock can effectively have holes, but in this context that
> >>> is not what is happening.
> >>>
> >>> IIUC, for a VFIO PCI BAR region, all region->mmaps[] entries
> >>> correspond to subranges of the same BAR and are backed by the same
> >>> MemoryRegion and therefore the same RAMBlock. The sparse mmap
> layout
> >>> (nr_mmaps > 1) exists to describe which parts of the BAR are
> >>> mappable, not to represent distinct backing memory objects.
> >>>
> >>> So while sparse regions may look like "holes" at the mmap level,
> >>> there are no holes in the RAMBlock abstraction itself. All
> >>> region->mmaps[] entries share the same RAMBlock, which is why
> >>> attaching the returned dmabuf fd to region->mmaps[0].mem.ram_block is
> sufficient, I think.
> >>>
> >>> However, possible I may be missing the case you are concerned about
> here.
> >>> Please let me know.
> >>
> >> I see memory_region_init_ram_device_ptr() is called for each region-
> >>> mmaps[x].mem,
> >> and RAMBlock is allocated in each call.
> >
> > Ah.. I see.  It does allocate RAMBlock per  mmaps[i].
> >
> >> IIUC, we should set fd and fd_offset in each RAMBlock.
> >
> > Ok. Will update in v2.
> I'd like to send a vfio PR soon and this v2 looks a like good candidate f=
or it.

Sure. Will send out the v2 soon and thanks for sending those update-linux-h=
eaders
and the hyperv patches.

Thanks,
Shameer
=20



