Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422EECFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcjp-0000ev-DR; Fri, 21 Nov 2025 20:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vMbRr-0005kp-I6; Fri, 21 Nov 2025 19:25:57 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vMbPu-0002h6-Ec; Fri, 21 Nov 2025 19:25:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvcdyQApCmMJIUWBXWlNqGoRYyTl/jA/gGDrLvrCGILh4fcHzRemy+xUBy8yEnGSxZm7iX/PJ+/W7LiefToUi3Ij0KNGoIp/R2IsJe9CgxbUjNreqiNm5MeSmYPukjkHDMnYqiiB2yLC/4Yw+KRrGi74uszRyupy+nMmCpiR0LKvtg2Q3602mFB0f+lFbuYJx5HNxBDhPGjp+6JvvFwBhctud2NGlwgMSaapVuRyRqtazWS014BFJR2l7OP3LRj7sebuaWS1NszrYmucetwKa/T7NVd3V3ZU8SF4Hg0N8XGvrBD4gYqcpMztnNHiufz0xBeA+2KSlGgRpLMNslEQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRjFitd7FsZAAT/4+O017tyTUl63tNDhrVwTeU83bGs=;
 b=PQgXotrJRpbBSVh9QfHp/hX6zBEis7jzgpKTm3hZ5eZkx+pLJJeOE9iq6fTKooG/uQD+F7h5ycV56iwnS2jNU4inRvsgRt6+LOcboozKtToVGTT0j0Iv4zdqt0pYc9orjpKxirES9DjEDq08ruCrYrAkYDrxWFHE9k09AxVZixQkdtR6juwTGj6SYPC8DJJv9cNH8KvMfl0GEcrxBgHOcokdQUJ5absvi9dFb19dCuTQdTEylDG2U0vwc5oUnlWFZj6nG15ZbEHYNKtXbhVt+Z/oYmdNrZUg1G44IDJcb/yk9tBXZ2zFVmdeH+mf/1bzUnr/KizxOGQDnJroab/ZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRjFitd7FsZAAT/4+O017tyTUl63tNDhrVwTeU83bGs=;
 b=OevDY311wXtka2Jz27h1mVQ5zspAmDrm+A2cyh7XDS64+FIdzAqdGJowZc55/BHLEcqQEspsjaUf+nUNOwbr4S1EJJRDMGtTMlkK2BWyK+8D38njgx6Uhhh5FU0aSBOjHJ309Be/zNNsWD+QFYk08D2i9BgK37+uJNsVquUIn+inHU7pk8Wr8ALXCpT1KfpYl/wpqAf/IEf4hPC/t2I+Ink4qSySOD2tKRwnNpaEEgn7lqXqrFuihGfe6D6Z6mt1j22X1mpR8Dg4l9WwuW5V+Gdzsv6N7mFoDAqUimMbeDHiIlyvDdzik59T7NjD10hkKd3be7SWOI4RSX29FX8JIg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 17:32:27 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 17:32:26 +0000
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
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v6 08/33] hw/pci/pci: Add optional
 supports_address_space() callback
Thread-Topic: [PATCH v6 08/33] hw/pci/pci: Add optional
 supports_address_space() callback
Thread-Index: AQHcWiFC5ZutjosMpE+DcYfPDxJ0SbT8CpYAgADj5VCAAHWrgIAAAGXA
Date: Fri, 21 Nov 2025 17:32:26 +0000
Message-ID: <CH3PR12MB75487F475CA02C6319AE5086ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-9-skolothumtho@nvidia.com>
 <aR9/SMia+iganQ2r@Asurada-Nvidia>
 <CH3PR12MB754864DAE416B1EE5C1DFFC7ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aSChKQtpSs/zYqh1@Asurada-Nvidia>
In-Reply-To: <aSChKQtpSs/zYqh1@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM6PR12MB4353:EE_
x-ms-office365-filtering-correlation-id: a5375047-2da8-4287-1c9e-08de2923f01c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/D++63OjDJcJpbg0gzAjBxvmEssEeLvEaiSuatEnrugGxhGiA2WNIQo3UmhH?=
 =?us-ascii?Q?dJaxYFBAXPQlsj57WzMxZQ5qav/fVMXl+A0tTH7+DVgqO1TsivJKJ9GcJCsa?=
 =?us-ascii?Q?eSnasTyiEbZn0o0fYCqh4iwzhicqOnKbEG+ef0wPcWwV5jaWUTWoj/Y45znA?=
 =?us-ascii?Q?t1peRuUNlsF0FuU59TzMcS+FwV8KE7acWPI8wP0DmIdy1VFdzc/TJphIJB87?=
 =?us-ascii?Q?vwQZcQgzTYUrL0N8pbWcacBIDQHkAwSKtm0Lhhx8dLXE57/f8QDHzmHU0fGC?=
 =?us-ascii?Q?mZ9CuL6mHYw1lvMjTsoYbNxllWvbdfq/595XTCPTY6RaPRsuGdJb0rc5+du8?=
 =?us-ascii?Q?i2ayx+9nXXI7jErAOJF8jIhiOwswkvxvEZiqcl6zCG9D4667hBym4GfOdjBd?=
 =?us-ascii?Q?6Mgjue+pHk3BvH8v/L1rKoBwvSXX9UT6AdmwCFsYkSAr82Ahoxme83lI2e5f?=
 =?us-ascii?Q?qNiEJq4ZAnLBJ8AScVMi01sX9QNCT0LSLOhcMH2KiHleuP32sKikZt+CKMk2?=
 =?us-ascii?Q?jYwEybQKKQPV7x6tBcHlzvLXfzt4mTcThtC97yEdjgZ6AekfotFnzVhOO/iE?=
 =?us-ascii?Q?RXzGXB4ZuCEiJSLWCokeWWhv3eiuaYRX3YrwKRkhxLCk3KzjfN9PZMsntHI2?=
 =?us-ascii?Q?G8blvJ4GZWWeDbl1d1qjsDEvUM21/L6pL2qo1LVqgye9fNbrO48Y5AiOG28g?=
 =?us-ascii?Q?QbkSjY+PXYkpxBsRHdcNQCs2or3ZTp+0ix00sXHggFMbi8ko4VlSNDmxbdGg?=
 =?us-ascii?Q?NJYJP6BhgGEomzFruGhHU9uBeGz5hWd+RgKJOwbG++Jf1fsv5ior5JAEVyZ/?=
 =?us-ascii?Q?6ve3xvUmZ3RFAoKp5V2JR0bdpBa0EMhX6qemPf0NyJWhvpzTzR4gotV276So?=
 =?us-ascii?Q?YrVZP5aP6SL8NFCuO2PHoIDO2UQzwfu91/dnqQPQ73JDDvi8IHGhePl8MjgD?=
 =?us-ascii?Q?bdu36CzF7XAlfzcDN3RImEn+I/TuoWpRR+btFSlVAadd39qlY6v2NCPYPKDr?=
 =?us-ascii?Q?a5li7J4i1WtGjginugPlIB4mAg8puq44gvB5gABiU2nN2j0pKJZ1oAF3t/Bg?=
 =?us-ascii?Q?5bFumlBts4gJ1tggoBbQbJ5LKubW3G/4YzkhDOjKayKPh6JMfTPfjdyAz06z?=
 =?us-ascii?Q?IFRmauYZlbwkucUH6NLf49Ol+Lol8/fTWmLEnwE8WcR4DuCpFpgT8QaYysVN?=
 =?us-ascii?Q?Pg+4Rv8WzNb+xVFTJt2TolB2Q1rxjEn0b6sVMO847YbdSMpaF5ywnTy8o8+K?=
 =?us-ascii?Q?x4Cv85mlfJ8n+IFw2JslrP5VU3fMufR1o2IpjKSdIw8P2Z+d5kasXEqjYsIc?=
 =?us-ascii?Q?4a766YgQKvKwoSgb8xRhwwFbU3/4awbYVUgrfTTYSOw5fXg/supNVCe83GQ4?=
 =?us-ascii?Q?nTEDJCxYPstBoI2NDIx/6lMt7QFovGXdCHAI9pG/aPwIGjdDfBdP+L2SA8Z6?=
 =?us-ascii?Q?p6fBO9lYyMdUzTsZdnHUxQX3XDUH2dTlsDQ0V0YN5zR3SgUupSw/t4GNaBnZ?=
 =?us-ascii?Q?jnqX49C34PXtgy+y5ZJH9KUFv0VCm0IX+kv4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LZobua0kYtryxN1FsI2mBiNrE+aiBQWwfC6x+/YWJxoO8+YBERfWY3tvnBhd?=
 =?us-ascii?Q?WE+gFj9fN7ricsxF0sGrE7xnFapxGtVc0v5hea1mZgmqb8CxqZ/PLOf3M2c8?=
 =?us-ascii?Q?XhIzqgGEqQrOzB/L8D3rUxVCdX2GsMfUYCG3ZF0YyGnH1oKPAnTN5iXV2tN4?=
 =?us-ascii?Q?wZcvcxchS+aE9FszvYoLAGLFnJB6dSagVwyj8pPAXyQCAE25oheZxH1uChU8?=
 =?us-ascii?Q?Y/84VPslgezeMdmwCiJD1mUC6oHKb/boqxrFLVh6PITPsyH/Xb9WXPw6u5NS?=
 =?us-ascii?Q?shXprCOzVXUJEmDJMzw1mflApkaweMnn54/4S6+gUqP2oezgJBl6F1CgB2Xa?=
 =?us-ascii?Q?R+b51jAXKuhmXUwzLMSC//cx+UCNJV7ge3WSYXTnVsdkJ29KZWw21Gf1YhvG?=
 =?us-ascii?Q?jzs5f49pZ8X94gEL31O73+NgliZ8PamkX0BJivZIc9B7QvMGm+LB8HFx5226?=
 =?us-ascii?Q?frOn6SKiyKuqkS0unuSjg7WZw9KNVYW3GOCQeACz5TSzv9qDiPNbS9u5X9Iw?=
 =?us-ascii?Q?biMppHju5auIUeYiSd1e8g2Ebv9bp96Xzvk0bQbuNjYBLdmDJpmO4oh93U4+?=
 =?us-ascii?Q?/7EDHQSOXZkGzeAEWpqWcW2Weh5VMXyen1e1GA0fDIq6ZwGIXNhq/u8W+WE2?=
 =?us-ascii?Q?1iOZVGkypR5QVCIYCoz/vkabTwYP+ToLB38e5WnbDOdgll4/Ks6MrkmVDNhw?=
 =?us-ascii?Q?EmDz0R8FJZvspwd8Ekqrd+rWHyJavkiuDKzKiKQ7ZYW7AfxNgJRswpfPfuYn?=
 =?us-ascii?Q?o/wT8M1a4EgeDaPgoHm2Gzh8F9Na5abccf/o+6nIMs6blWhJ7fCibxEi2TD6?=
 =?us-ascii?Q?cp7T1ye/090yh2Es4tW5hEuB3fSGmXMFLKibEfQDDKgZjlbuCjj3c0kqQEXU?=
 =?us-ascii?Q?E9vaCqp9U0b77ySFmgMSI8LhscGb9lAEIE0u8fCTTtC+34CC+/epat02Syyw?=
 =?us-ascii?Q?ewPpx1pi4HNKURCzValMg+dTPbQFZ+HqlyR47k1rjvhliBODJpBPY9ovEfp0?=
 =?us-ascii?Q?G+wp+S6qnVoitVyY4PduIHU1Dz6/uRdUz0IXoByNej4+nM8gu7X78VibGgp4?=
 =?us-ascii?Q?5zzHvgOdILu3kiqnqR88PtCjwGhWzaFV/RHr7eF2AqOmwkxjlwfySIwfbV/+?=
 =?us-ascii?Q?stPuChI93//dawYPXrQ9YujF86F2TraIZhlgQXO1lUrqpztzbmiOuktjVHLy?=
 =?us-ascii?Q?H0FZo2FdR4zxQkvEPswJAXJ+LJ8kgs//8wpAzehlTthvzns934hMfr24Jf/8?=
 =?us-ascii?Q?R+WVRGooHOi2xxYdZJLlk7hpU3/5x5JOURbwA7SGQtb9EYspmFCD6k8pS+58?=
 =?us-ascii?Q?v6ZragE1RHhidaZVh1kKij5V4nnFvikUx44L0txr/0hn9xvnScXJMIsg3s4s?=
 =?us-ascii?Q?YVYh708O1XtYrREtorr38hT5zZDkn8VdKajs4ruvV/aYyPArVhc0HzEW6BTJ?=
 =?us-ascii?Q?QJ4zbyVeCR6rRAgVSVCd8xddXFPkOER/lDZBnu88XGRtZwLF+cv3QRiPMJIM?=
 =?us-ascii?Q?8XzgOXCos7MLE44gXJQUyap8q2RgVVO4pCDlE0+xlWhVHDWaO3DdnMHIbamd?=
 =?us-ascii?Q?P80CMuZoMhKS7kKW+2f8JhZdIZHAN5HxZP7/jxA3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5375047-2da8-4287-1c9e-08de2923f01c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 17:32:26.1778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJejzvuP82y2ut1dZOchOs2E1nz3EW5fp6WyRnO6n7MJ9RaCxUY6+fa10xYWcNm5EkDAzDl/D8NA3ew1+0SYMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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
> Sent: 21 November 2025 17:28
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>; Michael S . Tsirkin <mst@redhat.com>
> Subject: Re: [PATCH v6 08/33] hw/pci/pci: Add optional
> supports_address_space() callback
>=20
> On Fri, Nov 21, 2025 at 02:38:06AM -0800, Shameer Kolothum wrote:
> > > -----Original Message-----
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: 20 November 2025 20:51
> > > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > > eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> > > <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> > > Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> > > smostafa@google.com; wangzhou1@hisilicon.com;
> > > jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> > > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com=
;
> > > Krishnakant Jaju <kjaju@nvidia.com>; Michael S . Tsirkin
> <mst@redhat.com>
> > > Subject: Re: [PATCH v6 08/33] hw/pci/pci: Add optional
> > > supports_address_space() callback
> > >
> > > On Thu, Nov 20, 2025 at 01:21:48PM +0000, Shameer Kolothum wrote:
> > > > Introduce an optional supports_address_space() callback in
> PCIIOMMUOps
> > > to
> > >
> > > "supports_address_space" sounds a bit to wide to me than its
> > > indication to supporting an IOMMU address space specifically,
> > > since the "system address space" being used in this series is
> > > a legit address space as well.
> > >
> > > With that being said, I think we are fine for now, given the
> > > API docs has clarified it. If someone shares the same concern,
> > > we can rename it later.
> >
> > The intent here is just to let the vIOMMU decide whether a device shoul=
d
> > be associated with its address_space before we call get_address_space()=
.
> > If the check passes, the vIOMMU must provide the actual address_space
> > through get_address_space() callback.
>=20
> The naming makes sense now. Yet, the API doc is a bit confusing..
>=20
> Why it says "device can have an IOMMU address space"? If a device
> only has a system address space (i.e. it doesn't support an IOMMU
> address space), it still returns true, right?

Yes. I think the API doc wording requires tightening. Will do.

Thanks,
Shameer

