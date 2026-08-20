Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF990C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx57e-0006Ce-Td; Thu, 20 Aug 2026 11:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wx57d-0006BZ-1C; Thu, 20 Aug 2026 11:56:05 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wx57b-0000fa-BT; Thu, 20 Aug 2026 11:56:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZCWlxBOV9BScKyHH8E6k6tHaJw/BydB2hIDhXIRoSta7WDFR6k8DY4RHkFv6+bjXW6/fczWoBk6fIOdWyPWY1woT7RAgG4yd7Ilj/jeNFhA4gGlPBlSJM48zynTCXnw4vviwDh8QOEGzjYADUUQOQg52c1P5T/Krc3ZGYQiJfbcyGWdvH/JhkBsi2XTKCsWOYsgcTkZy/RIn1SrQbPth38Qkui2tjdxmuVw+4ZJx7VUo/T2Ahh8ibnMjmv7VPnqB/+KR0oFmDtIbwX6aBrZtpkwmMOatoTDVI9TPE/rmvpCaG2yMMLC/2FtBaaUJRihRLng7BRNYlnl/qPAt90Urw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly37bQJrnG/NNqE8SCfGXAUpO7AxqbjgaKv3APVBdVw=;
 b=Pc89evTkkM8FneCAm11c+5bAH+5F7zsafVCKZlIr4/j2P7oZpcMXWA2bhhOTKGro5z+H6eCO6AI4r9K5t5U9TjRoLI6ufODoVYOncoL1wySZyK6gGYk2/w1CnnMGBAacW+2Pq7QsOcMsHrSDpQWF4HGELS2TvulFsv7tuIJGEqY3gBcEQPODVFMZT/0c4R1I2631NNDJIkY3K0aNleQtb86U3sPgHs/HSqbwduGQi5HAWBNv0pY4fuPHdKg8AfUWWFD0yc/RaU7HKEJ8Rmo/lMmNwZMiyKSqOcOMG8GTxx83JFWjoZFn2ws5sESI11rOWYRb88QIZ6/Pdv1qoBanVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly37bQJrnG/NNqE8SCfGXAUpO7AxqbjgaKv3APVBdVw=;
 b=TPYnZX2WtEjU651bnhfv2vS/b7Nc0WPT7R0SEdn6UftCnx+aAE51PwPGx7nUBBnqSjo/6Tzeh2sObxkX6hEGomMQXMgo8dxezHlqWSiZos9qJHvlOH0cuj/+4K1T/yonxZqjhmlJqo4xW/oajN3/jjnXTR5fDit5omPkBlfVISU+TxeuAEbHFnGkAGDsdCgVmmxTI6u++5Hd64ZKTr3lhNcVMIRv/QZ4HK11MZ6pE/AfnaeTO53pBfN3IKTFOKyxbrNyPCAeMZ5mjCJwH/m9wzwGuOx+lWauwvXAqj5b5LnOhYSfiu4nYAwX0GWSKqpI7Z81oSveeWw6lz9AaIE9Xg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 15:55:52 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 15:55:52 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Junjie Cao <junjie.cao@intel.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>, 
 "jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
 <dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
 <alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>, Krishnakant Jaju <kjaju@nvidia.com>, 
 Vikram Sethi <vsethi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH 06/10] hw/vfio/pci: Bind a CXL device to its fixed memory
 window
Thread-Topic: [PATCH 06/10] hw/vfio/pci: Bind a CXL device to its fixed memory
 window
Thread-Index: AQHdKyTCFyxHBR8MtUiORQjDWrN0ALajmEAAgAOHSrA=
Date: Thu, 20 Aug 2026 15:55:52 +0000
Message-ID: <IA1PR12MB9030A059BD696E2508D4B81DBDA42@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813130623.2499506-7-mhonap@nvidia.com>
 <20260818095226.252213-1-junjie.cao@intel.com>
In-Reply-To: <20260818095226.252213-1-junjie.cao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8755:EE_
x-ms-office365-filtering-correlation-id: 17021dc9-9777-4814-35cb-08defed38305
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|22082099003|18002099003|38070700021|5023799004|11063799006|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: x0et0Y3M9FesjHzAIBe5chJrXiPxeSbk64Rd3BzkuxsZGYmhpWK3eRl3mZzCDlrU3zdIG7oXfDVyh4ndrgFe5IoOUPHTDJmrcOgxyucj617KHg/n5zie/qNoOd7sLlXZf6FSpzjNgamo0iIhhcpOq8EN5x4dZ2x+yKgmCg0nBBoAdi3VYyKGs6TiYhYSC19yWf9+lE7aZ0AOumZYaQ69qjKBHwXON80OHK0FwLG1cwLjUpFHIX+jOwmudl3dq0ArfnsDnSdAKoN9w5gO4tdm5Sox3SGmAkXLa9K2IFraNWT5h+c2sdyTHZO9LZLFHsBMkIx7ySGIMajGTwg/u8GoT/mHLu7AJoylw05Iv5LN4TjazBcmYWpFS1jUdAkAxabSu8k0ed6itjtaVH8LQVKUkhbFE8uVhzMBSl9bj5+fELS7sdDxNnZGenMk9hzgXBskU2TxjQElE2n1jXJcZnxQwKnMj2xcPbaI0CLmC0oMdy5QOz1+FHZ/tUCKq7TQAEjnuULV2ngCCNKJFrz51PUrTHucpKkB8G3ah/82c/GIh4r75oIS2zb2E5C5CHGyqUW0j+x4M5SdAqOxgJMJHSYWTNTT6qupqGw8NsahcYGAetA0mP8GtVtVr+XvGOs9yCiF3BAFlmm6BQZNeVYxHqsM6Y3E4hhlT8DQz4BpHrGUGiBLbBXVncl/BKk0otpHUXt0FFCaWeoULQTLSJ/8iUSVbJhz2QbDsifzTz6byCZiDLs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9030.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(5023799004)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mPj6FagiSgEzxe4pkaC9pP66N4WdLMEdKnodyBBdufEfrcTsB7YfRg3oUr0i?=
 =?us-ascii?Q?pTzaEv6rU99B08WD/krJeH5OXijqWV1QuFJ0Yo+wodMrWHFcKSecIt8xZbB5?=
 =?us-ascii?Q?2Gkj7tuEQk8ewYDxZ6liFp705V2czZWeQ69MHYl0NkeCgcVdfBk9/Z76pWWE?=
 =?us-ascii?Q?Ho9kyUoAW5qcyuqKkOI3weE0vnoebHEipbooyfXtX8Rnv9ulIdyCuIjFgHiG?=
 =?us-ascii?Q?qsoUg0D1u4amM/di+lX/oSncUIvTPc6QAWsD3G/iI3Q/7UyA3cxNXBKbrOX+?=
 =?us-ascii?Q?/KSZNMsSYAv3ARzrF+BznJGCLeW6x35KnTqx3eNLVkABFUR3aRefpjtfeegM?=
 =?us-ascii?Q?qnN42mBFHiTPJwNFHEHj75QdPTu1hlNqOvf4hOVh7FdqaIfCkctJqRdhHa3O?=
 =?us-ascii?Q?m3UTF1cCFI2NJaXqTFwwV7Sx2rtIN/IguvAyFqP2FOdWAd2ub5yhbbNoghAv?=
 =?us-ascii?Q?SQd+NqolSb2aJrPZYMBabdNU7gX7DLC06Z/p2TgSvJREX1pMECyK8vFwIbEv?=
 =?us-ascii?Q?OaCaN2rDnaNC8Z4QWk/sphZdF5H7iqvjd1WMMadjvHxgG+ceBUx32jysAvFH?=
 =?us-ascii?Q?ubGRfZoi71l/Gz9oFGXoYrbbn+DtJEwRaxzQhpEy6tAVGNwNC9KGhxaGu2Bc?=
 =?us-ascii?Q?tt0HCIEhQ5Bwl9fSxbViCV+NCCvNxSNC3XayaMswHpgKtkZ6wj3akYNA0MpA?=
 =?us-ascii?Q?2o+lsqK8B/N9N9aqoYhlEgwcXhRCDHOmFxWhiVucfuRHhfIZIhPXE+dw7HPA?=
 =?us-ascii?Q?nA+BKkhA40V2aq0Nnzmb92ycaWkr6Z3gq+70rMKmgrZp/45CsZ5Z2Cw4jvYw?=
 =?us-ascii?Q?KzQ0sf50rFI1kBWqnRmcdtEzbUSJu3QU1qKXrIt+aFvAcDGnuy29X8DQoEdC?=
 =?us-ascii?Q?47RrzP6MsaxgwbXT6DGBxZDlDW9MoEsnA9AKSTeyJmwwgSgbNOkTcp1zagMj?=
 =?us-ascii?Q?hRt+JC3bws6nfWpdVwLx5cPcNZg0+qa+wlN7vqDqWRAWjQa/1e2MFqWTkVBl?=
 =?us-ascii?Q?LiwrC0QHrLjNX9dDTGqeaOYRRMlrQ8kgNsiRM6loOvHR2VPAqswjVapv9qrf?=
 =?us-ascii?Q?531I8aLDP+pGAh2fONcMvkOXhQ0jnzTpjkO3QTrwhFgsq0MPYx09lmBNHoPw?=
 =?us-ascii?Q?olNMxPPej3OoCp3tLibLem7T/qAZGL94LidREdsyLegBpCOv4lefMbXJGMRk?=
 =?us-ascii?Q?0E53T1sgQLQYmjjscV1yTtOUqUzEdD0tEKbD9VvppyIPqfuH3gIWEvk9/51c?=
 =?us-ascii?Q?x8M58+DmS4zZLiWG+XWPusdFkxpsxZWkH64Nw4p79xhoAEU8EsEuAn53T8hO?=
 =?us-ascii?Q?G1/zuYKsB3HPebS63kIxWwfL7NtJj/KZNGom4tFhdBj+iHtcy2m88ZBm/NgT?=
 =?us-ascii?Q?JTBA39hR1OI3/amCkDH4XCYk/JWuaZHWiU3EJGwXhAYIKo1lJZL18onl+zQ/?=
 =?us-ascii?Q?W/3/YeyToSvwn2BFDa7trfFpMUioB6Z9y3s+L5Ovnj4mIA/vK3xwvxU5Zw51?=
 =?us-ascii?Q?2gJ9peQTa8vkAAH9PqRgCxzcx7OMbmROUmlxYFEuL3HyRrhemwycni/KxT/p?=
 =?us-ascii?Q?i1ZmQrn68y8hCDraUl1NCxKilhNYT6m4e0glPQZj+XyRD3JOTo+XzJjs2Kzh?=
 =?us-ascii?Q?HlHTLY2VgeJEwg/+YZIx+r7fcNtsjf63qJuz1gr/n53rq0csY61nLqCNviby?=
 =?us-ascii?Q?BACpsFY2S2ag+2W9p/6waxHqaR7NY15DXXRMGKIYlL77HDqy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17021dc9-9777-4814-35cb-08defed38305
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 15:55:52.2247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJJ3YuFEdYG/gDxDvOfekm4rL7YPPw8a2qpKOT5gQsaOYoA9QlfqcyGFsKFGmsn+U0la/tAKUbAcbJLHli8Ytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=mhonap@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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
> From: Junjie Cao <junjie.cao@intel.com>
> Sent: 18 August 2026 15:22
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; Ankit Agrawal <ankita@nvidia.com>;
> jic23@kernel.org; dave.jiang@intel.com; alejandro.lucero-palau@amd.com;
> Srirangan Madhavan <smadhavan@nvidia.com>;
> pierrick.bouvier@oss.qualcomm.com; mst@redhat.com; imammedo@redhat.com;
> anisinha@redhat.com; pbonzini@redhat.com; eric.auger@redhat.com;
> peter.maydell@linaro.org; richard.henderson@linaro.org; clg@redhat.com;
> cohuck@redhat.com; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; qemu-devel@nongnu.org;
> qemu-arm@nongnu.org
> Subject: Re: [PATCH 06/10] hw/vfio/pci: Bind a CXL device to its fixed
> memory window
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Hi Manish,
>=20
> On Thu, 13 Aug 2026 18:36:19 +0530, Manish Honap wrote:
> > +/*
> > + * Cold-plug path: the CFMWS windows are placed at machine init done,
> > +so the
> > + * binding can only be validated from this notifier. The VM has not
> > +run yet, so
> > + * a configuration error is fatal to startup. A hotplugged device is
> > +validated
> > + * in realize instead (see vfio_cxl_setup), where the failure fails
> > +device_add
> > + * without taking down the running VM.
>=20
> At this point in the series that isn't true yet: the DEVICE(vdev)-
> >hotplugged branch only arrives in patch 7, while this patch registers
> the notifier unconditionally.
> qemu_add_machine_init_done_notifier() invokes the notifier immediately
> once the machine has reached PHASE_MACHINE_READY (hw/core/machine.c), so
> between patches 6 and 7 a device_add with a bad CFMWS config lands in
> vfio_cxl_bind_fmws() and exit(1)s the running VM. Move the hotplug
> branch from patch 7 into this patch; then every point of the series
> matches the comment.

okay, I will move the hot-plugged branch into this patch so every point
of the series matches the comment.

>=20
> > +        for (slot =3D 0; slot < PCI_SLOT_MAX; slot++) {
> > +            for (fn =3D 0; fn < PCI_FUNC_MAX; fn++) {
> > +                if (ep_bus->devices[PCI_DEVFN(slot, fn)]) {
> > +                    nendpoints++;
> > +                    break;
>=20
> This counts occupied slots, not functions: the inner loop breaks on the
> first function of a slot, so two vfio-cxl functions cold-plugged at slot
> 0 each pass with nendpoints =3D=3D 1, bind the same single-target window,
> and map at the same base with equal priority -- the aliasing this check
> exists to reject. Count devfns instead.
>=20

I agree this is a real bug. I will drop the break and count devfns as sugge=
sted.

> Many thanks,
> Junjie

