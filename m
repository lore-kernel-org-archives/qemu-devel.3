Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CE1CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4EIt-0000wl-4C; Thu, 02 Oct 2025 04:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4EIo-0000vJ-6N; Thu, 02 Oct 2025 04:04:38 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4EHm-00023u-3J; Thu, 02 Oct 2025 04:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h10U2hlWCh2/MuJvJUYAU1F1g0vVYIjaYtl40RD01StlLAooT3Qfwo817H1ZqZcKU/jJt9JqpHVUGD86VA1OYiTfk9ZZTDQtfAh+jsFOg2zTkRUfpAdZ9AOIxGoSxAXwSLIjN0rs4E04ZHbB+Pr/ZQ80G+Fc8VfrzL7vszTjXg1spDiPW597Iw0htMKAG45R9ngKkQrg5I5MrPnmKnYHYqwZ3DcUE4wStg7rl6n0MQmGDN7AlMqrdRADBEjvMhuxiKP4MHX8aU3ldIYjMlfSoIdApoPkAw1YXz8i+gSB64hnXRL8y26pKiSboSLUdDUAX27QtszeXL5KourzEl3JTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYMbLj7So9wYNpMc4NHEjMzCuyhQMggYEtMSyUBtG6A=;
 b=XDsySjgw0FN9VPi/PamWW2irYJusC4LihWWU8TtjUSHUMetBuQibiU+vfrs8pPfp4DQEIJMAljUGGnW/TcAm66rm/xU/Db8+OIPRbWuo6nDzEXkUB9MpP+76TFEm+co/Y2bRGnA5ckl/qN8o/YRHWeaD3JwYtvy0ko4huTXbeMLI1jSbcKJS2B/BI1V7g9JvNRiz1+hnmyEsaVl6M3fHKee7K9AUmK2cWKbQNl1WPHwUT+ATRfBw3T1GuFO5QYlpQzkkAQuada5UA3Si28RZyd/E7Dft6aN0ZCOJ24wVXfOaNNJ/2QW7R16vMzrBxJ3FguPERRH34+eza7P+mcXPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYMbLj7So9wYNpMc4NHEjMzCuyhQMggYEtMSyUBtG6A=;
 b=oH+bRdcuv0mfoi86JhoGOfJ1ndPh00vaM2tmkn6VnZ49bq8f72Kr4LHP9nwbcMyu/CG5TOQgacr+qWbI9zNTzSo1I9X0C/kdVolleh/nBxkxflANPGklUE7id901JGBvnHsD0JDXmArBGJLNcbQ/Q0U/Fe/DraUJS6Nae0PeNFo97fFpV3WLfGA+7R9WlE6Y9LEI8P4dklrYgbJLYw1SR4mKQTYi4hYYnQHjb7y8mfNGGbs7kKkJG/4yDNUPSG8kmopCmZV8yCW6tZ/MMTHveAg5G0E3P2IEzJOeaEmT0z5KSssO4lhsPs1ceI3vu5EXvnfKIzMh5a5hBZ7ACccidQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 08:03:10 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 08:03:09 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 26/27] vfio: Synthesize vPASID capability to VM
Thread-Topic: [PATCH v4 26/27] vfio: Synthesize vPASID capability to VM
Thread-Index: AQHcMtt5lBAzGvHpXU+UHDmFx2ObPLSufIGw
Date: Thu, 2 Oct 2025 08:03:09 +0000
Message-ID: <CH3PR12MB75485C98CAB78552EC4C1597ABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-27-skolothumtho@nvidia.com>
 <20251001145822.00002f7c@huawei.com>
In-Reply-To: <20251001145822.00002f7c@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MW6PR12MB8835:EE_
x-ms-office365-filtering-correlation-id: cc99fe25-960b-4128-5f36-08de018a20a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?iNtZ+gyueZ2v83I/cXIxQKSyi585s+64gLrW6W3Y8nHzWC5sEAOEADAHgq5D?=
 =?us-ascii?Q?Ix1UurtlSajX83fXA5EsS/YgUkagYGszCY6ovqxSF+5jqcC64hbYn7UHdwiH?=
 =?us-ascii?Q?N+ZyDvD/t+MQJZzukkvHDFNQr6ntwm4dnu+p+bSYseCpLdhnivAhXq1zoy1v?=
 =?us-ascii?Q?SbxKdy2K3qG7Gv62ZI3HgVCZoZqZaaB6IUFPR/UODksI6CG4YHrYFZ9iDjgU?=
 =?us-ascii?Q?+Hka14VuNgUCwlOVkLSgNlXf8Q5UEj625fIGJLjV6jWggv2kOJlHoW3EMUkw?=
 =?us-ascii?Q?CzLpI+V33PUOvz9Sjh5U6wdbSeySxF5jK+M8s98qL3LcXuywP3ehdGPyf4HS?=
 =?us-ascii?Q?4L+D28VMuafzf17dkNK/N83AWmJFmVbl2NyjpFzAdy5DkWNJoqdbs1XM31h1?=
 =?us-ascii?Q?BG5VNOf2yTyC0TQvyOJdrlhOfXBZLaEuamy37Ro3TyvbUL/1HPbPu4nATfn6?=
 =?us-ascii?Q?E/maGPoGAGzK+qExGaUUGKdDP263ePjveTTy5xIYThaB0S8R7jT+/z/00dDz?=
 =?us-ascii?Q?cHromZFzEyEm0GZkEBupKLqRjWC4CGg8RCxdzl3mGuwype8XjVgwjmGoi21Y?=
 =?us-ascii?Q?DiJduyrLxs8CoHjJ9rluKFVEuY1jOAgtL//aRR2E7YZXs/kRQ5bIVZq/4YaL?=
 =?us-ascii?Q?xW/yl0l2zRVXX6H1WEXxSYEtG3cjulwek93vOZ3DQA3L5vtpRkrE0s3ifn/e?=
 =?us-ascii?Q?/C/n1D64wbPcl9teO0otjqN1nsA7sWNLCF6bIfHl5aRG3bTTyAibgE3NrHQY?=
 =?us-ascii?Q?HY5JIwRlc9fz+TKppdiZIhK5DCC0wHZn4AIyQFc5uK/ARv1dsDIbKW2mhDSh?=
 =?us-ascii?Q?VGGTNNrPh+PwTBCPXLAx4ntmMvDq5gi/G+3wsgW0ft3gSLMrlp6BXmPcjT5X?=
 =?us-ascii?Q?lL5s6Zqox9xwJs2rFUbJVI9gFmvZ69E5fNzpPkGOeSssHwpAjeV9Wwz07CL9?=
 =?us-ascii?Q?qd3VneAv352leQN41YEPbbWYMH5bdbfhdj16JqcukDJd0CdP8j6K5pfR555L?=
 =?us-ascii?Q?stiLvxwLPA6qnXiGj99rSTExbI56+GTpCfXU4rhFdX9s5d4zLudDgHMs7/iP?=
 =?us-ascii?Q?gNs/qFI4l5uyEGvicuKxV+mB+O0+JfYk13hQbCBFcMmpZbXmf6Sp3z7i2get?=
 =?us-ascii?Q?ThCavxYy4h+q7dausXzp7sXULkKIDbfPXUSGErafVb0mv9GubjdiQgvWTB4E?=
 =?us-ascii?Q?7oelK1uhmJKOA++bsz8IdgI+KvjFSjCqGqtXd1eacJ2ggTRTI7NPpgohA7dr?=
 =?us-ascii?Q?WNOJDo0aucyYRMyJh+2IYiIJCUYjTjp335CdDX8nIH3b8+R61qGYCX9Ear2b?=
 =?us-ascii?Q?0BAbALr0M0hsT//RtJQsf2A/jIhmohTAa+Gt7K5E6IrMHcnk/AoScMU9plJo?=
 =?us-ascii?Q?ZNRrpGQkTGmuEBvkvaVQrOxsxlKjByTw7cF/Y74v5A9qVXk//BGzmxC3usZ/?=
 =?us-ascii?Q?D/lqVDrOh/jhveWjkt9TsnS2EEtuN/h6ZLq+ilAoZnU6qa3GQJwutA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FhwPSt+k+r7oZTB27lEpLiPa8XOWP7ZESDBlcz06evJ0trm1pqn3tz13voIa?=
 =?us-ascii?Q?OCUJwr8RU8MfKL4a7emrDQef5CLv/mny8/gq8LUqD8x/UAYrNYCjhHwyjhve?=
 =?us-ascii?Q?ti4O8LhNJg7e/ez9qDIFme4S8OiGbZ7Cy8uN5e8Id5BmLcBehj+NHyxauSwh?=
 =?us-ascii?Q?njPhXDJ19XB/K4WNAqPMv4s8joJpD8a7ZwpRWlANdxF+zrk4FSkDsCmCoMd5?=
 =?us-ascii?Q?7ZIRnt1flBVySK7ybsZ0iSQ7Z6ac8zspEvWqdafss65RFxxfcHenCEY5G/ij?=
 =?us-ascii?Q?VNLNMehY5GZboO/CPMmeya1XQh2JV4/FHp4r29gp0v9MNMWid0/XhWJYvMFe?=
 =?us-ascii?Q?OP10sU5xR+PoIj0Mfb9+R3ru3in222kTB4TcojUGNK/Qlbnx9gH+6aBrnIcI?=
 =?us-ascii?Q?tfFe66vckqBVn8sFfXBzjyjhwrBSWTQRNjtCu/975SPeUCTVnawi8RPSYTcd?=
 =?us-ascii?Q?iiuwalMAJ4QgZ5WRl/XnA+13fQnJjbYETLUQ8aC/+xy1TRR4eEGXzi1nCW1E?=
 =?us-ascii?Q?BOxhBGkYy47EhzRc0Z95i5lRKSSv1w6U3gNsHTPFHHsxYPp6PR1ccvMQshKY?=
 =?us-ascii?Q?HmQvUNmKr0kgWnRWxNE1bNsK7NfXb5UTu5DbdzKeDMSbdJ5AWNfBYo/VbsHP?=
 =?us-ascii?Q?zSJA5hxcYRNaUIVxdDUTwKEPMkp6p+sP2kGHwYh6s7qfkMPRI+SlM/l1Vvos?=
 =?us-ascii?Q?fsl9hX/BWfNIkh1qG2R7PS2otLOlXFFs4L5jJOkBuEK224rR2IoEZ5jU+v0D?=
 =?us-ascii?Q?xGiI5bw4UTJFZRLG1ns4h+nBtlSO9Y5pjaZR89D6FcC1SrN8UkGMd6oazu+k?=
 =?us-ascii?Q?AdPENLAoiIykTBrJGcsopKHFgkEpyfnwtGUbDWhpFt/P6Tw6WxcIH/aN4n6D?=
 =?us-ascii?Q?KB7gpR31WUwVHKTIVMzn51E7wIpnC8wSxQVEZVl/LUvDksg97LVKlUqEA0c1?=
 =?us-ascii?Q?I/VagW8a+MpLOwu9l37ECW49D9n5h+Mdu0qLie7Lc4xvap8gg9MNHAStGbkh?=
 =?us-ascii?Q?55ZhCcOZNg2GpoEaD9P/x9TxYjMANUqedT/eOKyfvl+qkfMi2ZL4gk42KZwn?=
 =?us-ascii?Q?18Zjl9i1DsPWct5tmWJnerMUGWtmHDIkHcXUHd8gxRBk0E/E7rX88dg0RawD?=
 =?us-ascii?Q?l1eY1s3lEeLYmi7O4EoZ3hFmYVtuPBWKHteKkzTWi9sGuz86lTz7uH0CDpBI?=
 =?us-ascii?Q?hTxk/Ux9YPLlEl0wi7lv5HMPVbN8HqcCHll6YTD3xCyX6zrw4or85OfiL1st?=
 =?us-ascii?Q?epwo+Q24Wr3Nlt2b3ZX6EgzPrx3LMBzEq+7NV3ZTXOZGvcrT+611pGDJtUUl?=
 =?us-ascii?Q?GTf5VM3XAga+kK7J/k2ORk2PlrwJfuY+0LTd8fw56hzDFYnurFjaz27bbrUX?=
 =?us-ascii?Q?kfED1n2HE+xOMll9/oekeGb62OP2m6NCAk9Vvk7/0ivHGJGQPMRR9uyyWAN7?=
 =?us-ascii?Q?loqTfwDYQ2pUy0peQb60Xc0qYwDJpoAD3/RU/vgJ1DdxbVguyLEUFq0OB2Qw?=
 =?us-ascii?Q?FeHhQhnSPGMmLYBvNN90F6MUcS5G36J32sHFMEpKhep2GhQYWptxhkDYffjM?=
 =?us-ascii?Q?e46ud6dtX/AVRKsfDqsiU2SYo/H6sn1LG+Na67+V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc99fe25-960b-4128-5f36-08de018a20a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 08:03:09.7717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FFqy21hYvPuAnbrkZa6WHzBpPqc0aKJyp0yh1R1ZevroLvWQ56JsA6AgsjtkPHPPWriTzlilz7Vl22vPlhKmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 01 October 2025 14:58
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> shameerkolothum@gmail.com
> Subject: Re: [PATCH v4 26/27] vfio: Synthesize vPASID capability to VM
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, 29 Sep 2025 14:36:42 +0100
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>=20
> > From: Yi Liu <yi.l.liu@intel.com>
> >
> > If user wants to expose PASID capability in vIOMMU, then VFIO would als=
o
> > report the PASID cap for this device if the underlying hardware support=
s
> > it as well.
> >
> > As a start, this chooses to put the vPASID cap in the last 8 bytes of t=
he
> > vconfig space. This is a choice in the good hope of no conflict with an=
y
> > existing cap or hidden registers. For the devices that has hidden regis=
ters,
> > user should figure out a proper offset for the vPASID cap. This may req=
uire
> > an option for user to config it. Here we leave it as a future extension=
.
> > There are more discussions on the mechanism of finding the proper offse=
t.
> >
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fkvm%2FBN9PR11MB5276318969A212AD0649C7BE8CBE2%4
> 0BN9PR11MB5276.namprd11.prod.outlook.com%2F&data=3D05%7C02%7Csk
> olothumtho%40nvidia.com%7Cfc027ec76e294ee3db4808de00f29861%7C4
> 3083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C63894923913220611
> 4%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjA
> uMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7
> C%7C%7C&sdata=3DQjerx3fDhLranvJPSoif4z0ue%2FcVgFYvFjroPgCjOQQ%3D&
> reserved=3D0
> >
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> >  hw/vfio/pci.c      | 31 +++++++++++++++++++++++++++++++
> >  include/hw/iommu.h |  1 +
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 5b022da19e..f54ebd0111 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -24,6 +24,7 @@
> >  #include <sys/ioctl.h>
> >
> >  #include "hw/hw.h"
> > +#include "hw/iommu.h"
> >  #include "hw/pci/msi.h"
> >  #include "hw/pci/msix.h"
> >  #include "hw/pci/pci_bridge.h"
> > @@ -2500,7 +2501,12 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice
> *vdev, uint16_t pos)
> >
> >  static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
> >  {
> > +    HostIOMMUDevice *hiod =3D vdev->vbasedev.hiod;
> > +    HostIOMMUDeviceClass *hiodc =3D
> HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> >      PCIDevice *pdev =3D PCI_DEVICE(vdev);
> > +    uint8_t max_pasid_log2 =3D 0;
> > +    bool pasid_cap_added =3D false;
> > +    uint64_t hw_caps;
> >      uint32_t header;
> >      uint16_t cap_id, next, size;
> >      uint8_t cap_ver;
> > @@ -2578,12 +2584,37 @@ static void vfio_add_ext_cap(VFIOPCIDevice
> *vdev)
> >                  pcie_add_capability(pdev, cap_id, cap_ver, next, size)=
;
> >              }
> >              break;
> > +        case PCI_EXT_CAP_ID_PASID:
> > +             pasid_cap_added =3D true;
> > +             /* fallthrough */
> >          default:
> >              pcie_add_capability(pdev, cap_id, cap_ver, next, size);
> >          }
> >
> >      }
> >
> > +    /*
> > +     * If PCI_EXT_CAP_ID_PASID not present, try to get information fro=
m the
> host
>=20
> Say why it might or might not be present...
>=20
> > +     */
> > +    if (!pasid_cap_added && hiodc->get_pasid) {
> > +        max_pasid_log2 =3D hiodc->get_pasid(hiod, &hw_caps);
> > +    }
> > +
> > +    /*
> > +     * If supported, adds the PASID capability in the end of the PCIE =
config
> > +     * space. TODO: Add option for enabling pasid at a safe offset.
>=20
> What are you thinking needs doing to make it safe?  If it's at the end an=
d there
> is space isn't that enough?

That is based on this discussion thread (mentioned in commit log as well)
https://lore.kernel.org/kvm/BN9PR11MB5276318969A212AD0649C7BE8CBE2@BN9PR11M=
B5276.namprd11.prod.outlook.com/


" - Some devices are known to place registers in configuration space,
   outside of the capability chains, which historically makes it
   difficult to place a purely virtual capability without potentially
   masking such hidden registers."

However, in this series we're trying to limit the impact by only placing th=
e PASID
capability for devices that are behind the vIOMMU and where the user has ex=
plicitly
enabled PASID support for vIOMMU.

Thanks,
Shameer=20


>=20
> > +     */
> > +    if (max_pasid_log2 && (pci_device_get_viommu_flags(pdev) &
> > +                           VIOMMU_FLAG_PASID_SUPPORTED)) {
> > +        bool exec_perm =3D (hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC) ?
> true : false;
> > +        bool priv_mod =3D (hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV) ?
> true : false;
> > +
> > +        pcie_pasid_init(pdev, PCIE_CONFIG_SPACE_SIZE -
> PCI_EXT_CAP_PASID_SIZEOF,
> > +                        max_pasid_log2, exec_perm, priv_mod);
> > +        /* PASID capability is fully emulated by QEMU */
> > +        memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff,=
 8);
> > +    }
> > +
> >      /* Cleanup chain head ID if necessary */
> >      if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) =3D=3D 0xFF=
FF) {
> >          pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);


