Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6376FD0047
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 20:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmxW-00017e-Re; Sun, 01 Mar 2026 15:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vwmxU-00017F-5Y; Sun, 01 Mar 2026 15:00:08 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vwmxQ-0000Pb-5o; Sun, 01 Mar 2026 15:00:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjeKNSX6gNZEpK5HKjqVUo8PxW0Ftz7n2PjXvAm7Oun8hQxFt3eGmn3tSTUxJstF5yV1t3K6HTU1RFcE2sX9gPGnjEim9+7Tr8uAjMIf8XqLPZ2QcHcry+MYrppH2i8LIc/StfJ6RbsKrAnieB6SsiHEOOeaUuHv0vXpKkAQB/ksH8OQ+X5GwkLwpKR5cIyWakBxoQHgNGISdcKMTDOjVMv9ZKuG+SD+YZFj+7oq5LfIPrPKVMBUFZK/eDYmDqxZx6ZOlunMeP2+apr662RPS/Exf502H2hLpHF8A6xZPXUnPmxqk86DP1Py8X1zK/yFxx+sAIEX0KlWCdD4BKMHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzDZkxiW8hfL28WVXiixzJe3NXbAo3Mx03Tonz84F+o=;
 b=CJeFXKgQ/LOz9byFioG67WosXosQMYboBrN5YK++0EcIhA7qIY9gnDHa4NeRDBmU0Jic+2gJ2e5ZUjDLKgedGqxV8oYKzj7G6MeiESGiK/8hMUjxdC/GZsQXAiPNr8w1duI8N2fzU08OPcmuCtEvnp+OAjwom7HbFRHkphDO1zvhcAAVkGf+skysXXdDRqS6wTC2QSDz9zhXYmUEF5n3TERqoJ9ooaIeTy/Fa2R1DGyjwrnRAde+Lxt11gvRC8pN/qHcr2hOnyGOTSiMJO1Q9m1syYh8xAKpW4mgogFpYRj/N5bPGSgEvrrulbyaNGVWRI7FAafIszMtvsU9SdPaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzDZkxiW8hfL28WVXiixzJe3NXbAo3Mx03Tonz84F+o=;
 b=keumx8mnsvrzDahajhWEvTf7DpsPWx4g+LLw6R2/dPMWXEpLS9tSK22McHn+Rg4jmN1SsxO1H6rRZ5H3me+lyTMKAcyxBllzHABAB/mcjE3/SKgTLPLoiM2whtAGJr7649AjUkQ7iZr4S26NgzEQLu6jjr7kamK46V5svKF7OdSqgZOLt/JZrnmR3Xry+TE45Qk91xJRqrAcaGFNu74G8EDoBV2k69faMDLwPOpDf3iaZWxCJEafjHXfgDyWiLmIIhd6HkXU3VTbxmFRoad7r8ry9JGTVB5y7xk+j+S4IveMPLsCgMwm55UlhLNnszUumIvclsAY726wN019ybarQg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Sun, 1 Mar
 2026 19:59:57 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9654.015; Sun, 1 Mar 2026
 19:59:57 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "philmd@linaro.org" <philmd@linaro.org>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Topic: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Index: AQHcpvxYoJA2rVvrlUmoO+kVeNPgOrWXqK6AgAJnu9A=
Date: Sun, 1 Mar 2026 19:59:56 +0000
Message-ID: <CH3PR12MB754818FE668426F2078F25BCAB71A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
 <20260226084456.112142-6-skolothumtho@nvidia.com>
 <IA3PR11MB913652049863E1F32BE9C1319270A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB913652049863E1F32BE9C1319270A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV9PR12MB9831:EE_
x-ms-office365-filtering-correlation-id: 3facfdee-c78e-4e4f-c403-08de77cd1ce4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: tspEvFQdu8lkJCNjbQ3dyAa1+evc/w9NyMTsPyeIn2VjIEl2Qgs5PlbsUZE7+XvSQIN7Xhn1DsvJYZf41WtXYpgyx/XRE+ZNDkZK7PARhiP5Mqt8SMN1KGi2mdvkdI8azPJ/GH32II1N1McZa+sEmbm6YjIysbbaQfwgtlMOMydDoD5+w06pzzQu3R8CDSpOX8DYZHPBw0CNKj4jDyXrxaMhmB767Zo2htrmdaPwAVOSIcVdvLmXmgzXJPF9tGMQNMmvoi4IBISf5aWkGCyFdyggE4iZf1gPJyAcjQI9ljX7/qTOvae3eRMD0F9P7xEybl6qASVwASmQxlpQemn7CHeK1OqOsh49yyWlmrcMsNw+VQDlL4emeTG6JPY3BAJ4FKAEIUAf3vYqVbwSYFp1wQQI9uW8a722BhVtv7HlmQg3duR7JDRtaKn4U1pCIQbUtthHZbvbC0HtphTnQBusZ94hqKC5U7zGqpkuhSHFzJ1f3lbJ2BJJ9+BlWbDkjdlWbqmxeOzy32GYwozm8yNNF4EyDjPa4viAdss9k/xQTLfbNSwwrZ3Elvacn9hmJgbjesp/HQ/vzvle1sY3e6nEJh8Icx6Fz5YK64TayIgJbo/2ZwEZmkOSB7D9rDYoZ+Z4kMKf/3n5AXuBIKe0CWJe75bFY02m/IoSADfj8P0v2r9KEo8+QlBPRMOb5oX1iQLg3cDhF//+s/U0YiZTCCf7Hg+CkZQvbEhsnpixQxb4tW5TdkgnsHwLtEqddQESW6FG+NFQ3K2uGyI7LpCMZqscERilRyJmFika2NOXhXECH1g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s28b5l2T0MWuovlbHnOUI5MMptS+ldn/7GUrDeSe35JECjJ6RlhIdIwiltmz?=
 =?us-ascii?Q?e6pdwfh+3/xwaS2m4bVOKQeQ5UviQ9jItz7nHel4aboTDaDLCOLiJW+qjYhp?=
 =?us-ascii?Q?M3Y9oCBBJnOcIW8jLSRCfGFK6iub0cdjwYoEQhS25jUR8muOauQCfKQXIm9d?=
 =?us-ascii?Q?1fwYnAtYThJ75kkQHlASbJg15C8eAw+Ix3rFCaawPWdOQ/+e4XgwBMeaqHI0?=
 =?us-ascii?Q?2glOu9FiluYWu+WOwAcdBZ3DLsmzS5oumlWU1T/xQega4lZI7KM2pJYzmyjv?=
 =?us-ascii?Q?Tq62BuBrQB5nMnBkbsqtCFVDH6kKFcouYI64Q3m491qw0mvuiMnyeRpgo1o1?=
 =?us-ascii?Q?gvJkkMRmUVsTlSpPQIk2C779S69RCzNrMGAp3GKQAYSHIcdUNPa999ksy1Kw?=
 =?us-ascii?Q?BoiYb83AjmKNgsja8/xCPF1FYolC9jKHUBr5XZbnBbTEaua9yVC/s7+7q7ml?=
 =?us-ascii?Q?UoGlxqJtZd4Jem83AcX5eWSAtu0K78krB+cjJQmVs9WDvl3d4qVokNi8hHRL?=
 =?us-ascii?Q?zXV3ntZJmu69o1O3+RBL9y0l94GG+h5Aqh2UTbd5tj6MqC2xtfu0MPyetIXM?=
 =?us-ascii?Q?2NqULBZ7OiIAwti9c6lp07rJmc57l8MPbJxqbSnZh6uCkA1MC5Lx2CltFmuE?=
 =?us-ascii?Q?EMHWURL4Ofa/xqIXdU/S0pbMJ9/NEXja1fDh7t6wiQNt2cxcoUddkQS10bT2?=
 =?us-ascii?Q?KnpBsZ8QX02zmg+RaRPsxAleOQCRP57UVNq3X9hc/jzAujZwsuoWAZKGCmfE?=
 =?us-ascii?Q?5C1v8/C3i+DxSXgMTc38/NlnDHZ4JwBbZvYYCSgKdCS26sg/jyit7J2fmAz3?=
 =?us-ascii?Q?QZx7JEEYZssSsoa/uV0py4vY0u3Q4Gv25cBdIT9QJfcINfg/L8jYhIiifscH?=
 =?us-ascii?Q?NsZyjthb2ZJs7CIIOX7ygH7RzLoDG5pM+wWb4cUSsPa6wRHFkwUrOedv0G8w?=
 =?us-ascii?Q?fwxxsQOBnWy4OKNL/EmyXrq8gXL+J2SXVll/TuFOPUoBcUyfVN6KN9muWKiQ?=
 =?us-ascii?Q?QswmPCJwqUVaEW92t8xiZRZmVxKukpUMKqlsaYuiDQA4kH4cldZTsW++02CO?=
 =?us-ascii?Q?b2UiL6nQgYdK95NdoPGJVtSMlgELawMgHvYrxKZkfcv6atnUwG/jIqwar0Ar?=
 =?us-ascii?Q?G7+hkrAuSxwd/b5TKjEA+VqnBNQ6Le2ydj6ooNYSBoxovA0cejKMJyuHwwqk?=
 =?us-ascii?Q?IQpnbHWE3pFygCOcQ7G02liAwFLgMSw2SWYOIVd0+TKYynTxGqRFsVn1yg8H?=
 =?us-ascii?Q?MgSg4dhC3az0HWVaNnysmGai/OsBPgKhMMtYY1mKsK23U+j0ceIGIiqMMafO?=
 =?us-ascii?Q?jHv1BrD9EBL0aDyc4I0IMG+EdE44FfItE7o0hAQjTygp5TFJi14g3nX33HPK?=
 =?us-ascii?Q?UyOZRTiArUsXWjPyKlHsizPyUbGWAgr8em7E4W4+rSiK1XIItoigxv6aarrR?=
 =?us-ascii?Q?YsQyOMgJ1SFYlKkN2GCttbEWYuFU8yW4akZclG86YZwCkaO1TyVYkK2EtF1F?=
 =?us-ascii?Q?zuXGMRjITt8Y6BwAxrrUJT3JX0JLlo4sc5cGGkosRn0vBJrMQfapUckPccyc?=
 =?us-ascii?Q?pQQZaHD6l4D/f0BzrkJ/o9kORNKIsdkrPPkD3oY/r6oAm/ZKhbHPkScQfHML?=
 =?us-ascii?Q?nB/TvzytK4J9A+xjr50bVLqxgXpH2SJlwsjotkMuZRAGXwuVyJq9g3svPXDX?=
 =?us-ascii?Q?J/q64WBVJSzDLjIv3CxAYlc1EV+dUg4YV64DNmqQJUbO8t4QhOQJZDOVbwMj?=
 =?us-ascii?Q?/PsxCbbQwQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3facfdee-c78e-4e4f-c403-08de77cd1ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2026 19:59:56.9583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASAhHRttFHlg5giD9rZqWxxavP9oMsonbn11FcVDhrup7gX/2BrW5mDUzKPs8Y7t/fPGiwj5jHjsQdgnOhR2fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1.676, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi Zhenzhong,

> -----Original Message-----
> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: 28 February 2026 06:28
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org
> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; philmd@linaro.org; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
> vIOMMU events

[...]

> > static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
> > {
> >     IOMMUFDVeventq *veventq =3D accel->veventq;
> >@@ -397,6 +441,7 @@ static void
> >smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
> >     if (!veventq) {
> >         return;
> >     }
> >+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
> >     close(veventq->veventq_fd);
> >     iommufd_backend_free_id(accel->viommu->iommufd, veventq-
> >veventq_id);
>=20
> Did you ever see free_id failure here?

So far I have not seen free_id() failure in my test setup.

 I'm working on PRQ using FAULTQ in
> intel_iommu
> and find a race condition, I suspect the same for vEVENTQ because both ha=
ve
> similar
> implementation in kernel and qemu.
>=20
> qemu_set_fd_handler() is called to remove veventq_fd from epoll() but it'=
s
> async,
> this can lead to releasing of veventq_fd delayed after free_id(veventq_id=
),
> during veventq_fd releasing, it drops reference of veventq_id but it's to=
o late
> and free_id(veventq_id) already failed.
>=20
> It's not easy to reproduce, we had a test case in guest to trigger FAULTQ
> allocation
> and freeing sequence in loops.

From a quick look:

qemu_set_fd_handler(fd, NULL, NULL, NULL) -> aio_set_fd_handler()

aio_set_fd_handler() takes ctx->list_lock. For the delete case it sets
node->pfd.events =3D 0 and then calls:

ctx->fdmon_ops->update(ctx, node, new_node); where new_node =3D NULL

In the epoll backend (util/fdmon-epoll.c) this results in:

epoll_ctl(ctx->epollfd, EPOLL_CTL_DEL, old_node->pfd.fd, ...);

As I understand it, epoll_ctl() is a synchronous syscall. When it returns,
the fd has been removed from the epoll interest list in the kernel.

Also, I think, aio_set_fd_handler() and aio_dispatch() run in the same thre=
ad for
a given AioContext, and dispatch runs with ctx->list_lock held (via
lockcnt). So looks like handler removal and dispatch are serialized at the =
QEMU
level.

Do you see a specific window where the fd could still trigger after
EPOLL_CTL_DEL returns?

Could you confirm which fdmon backend you are using..poll, epoll, or
io_uring?

One more question: is the FAULTQ register/unregister model identical to
vEVENTQ in terms of allocation and teardown ordering? For vEVENTQ we only
unregister when the last device is removed from the vIOMMU, typically via
device_del hot unplug.

Please let me know if you see a specific race case here that I may be
missing.

Thanks,
Shameer

