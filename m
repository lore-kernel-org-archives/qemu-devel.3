Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8358C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4wNf-00043O-J9; Fri, 11 Sep 2026 04:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x4wNc-00041X-Rr
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:13:04 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x4wNb-0006fb-7q
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:13:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCosyYKlNo0w67qNduzd0C4bLGkIRolXjzDz9vweq71hTTgqas8NN+y20tKnOOPzbQ0TKZvAnHvPUwfsgpDiLRReUKxcVQRCKNyGH7A8KbMx9elXr/uEQq+cAvOoLbhCnyeqLdAMNjlTG+xzk6EiGMZAaj1X3Q9HJSbkuKqQb6GJAlrTawyRROvVR44YG9QoqMkcJLYshI/ObACoIMIytFd6+RgQpjRQnqC/Ufpkt4mowj7YsjIzPeCULJlAjpM7J3lRxLqOugledQW5yiUE6vCv9o6/anDNAhPTCgO/2XWm6Oicwi9jjgdA0yuhuJzN2iMobWKPjTegCWIm/53gHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmjADAzOLyU4l1Jgb/x0+ghg8oaLdpB9qi4tMIknWec=;
 b=wkl1Zfy6+sRMqEcai9fSpno+k3Tk2yyB/qTCT4suGZ3OqmA+0a9SgwsBShzq4uQxxv1wP86LDDYa4w8IYbtNUIOraHZWmH7Od2j2c8TlMq1+72VeryXZJgN1t783Q6vTml+tNRz3zRvdXOhd0WFnoueyd4DkJIYM8tUY+ervoY4YRUkYJZRnjLS3pf+12iZgGngExmdm1fXt1kQsiWTTXbxT17SOHfrac7An4TY/XPX8bkDk63m7QZfa1dfQ15rRQBIkL5Mo1BNa8RAc5RIm/Qmi+yYZA1/1LHbqDT5xb7P95jHEx/zTrjW1rpiQPaJ2UMZ9nB9DBPahLVzt8NKwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmjADAzOLyU4l1Jgb/x0+ghg8oaLdpB9qi4tMIknWec=;
 b=MaVbvkW8lFC2XhT1SJca2xvdKzNMyjT7Gfap20F0R5YxT92J63gWuqJ1tUkkacdycPNeGd8JdwirprqIoe++ZdRPqhhVQ7Iz6OJxTzNc1/seM8BSEc+3J4NXoAC9ul5WKD7KW2llm0G9tAU5x/aGTDXXnbizxW/YZ0kmld40S2UURfU+sHIILuobTntja7WJWRh1hqWJsv/+4wPGapOpP6zEwUoLesAbkFoLtqwVYhKct3uIBTVnYktCtRISElsgCaQs8yVj+vDfFJQ90r3F7hNetTB0+D02Ek8k5jgWLsPct2To/AzdHLDnYjM17nuHIGXp9AQEhX917pIFY0GD3Q==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:12:57 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 08:12:57 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>, "alex@shazbot.org" <alex@shazbot.org>,
 "clg@redhat.com" <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH 1/1] hw/vfio: thread vf-token through iommufd bind
Thread-Topic: [PATCH 1/1] hw/vfio: thread vf-token through iommufd bind
Thread-Index: AQHdP6wq/k4Ssk17ZUOb6vIv4wYnNbbJC0FA
Date: Fri, 11 Sep 2026 08:12:57 +0000
Message-ID: <SJ0PR12MB86146CCB19E1BE23172667DCABBE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260908160731.1658621-1-tdave@nvidia.com>
In-Reply-To: <20260908160731.1658621-1-tdave@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|SJ2PR12MB8806:EE_
x-ms-office365-filtering-correlation-id: 61b14407-c9b6-4696-6adf-08df0fdc7d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: WPCwzaJwNhwYDmfe4k3ga/G42HMO//9SRjbBFAGCNTyJmWnKmCcagGcw3/RDfNbrqdj2xIGEO9G5IZYrGSNCe63AZjOiAib2SIwrbpWhhozyyp5EcA3PcAqGucv3tgmpjIQU+Jed6QX019FUyZqYiVqbVDQ6BcdrCf0wo4f4ksciOJrVUEgiFKP6KcpWaI+84276gMvO/2bWp4nb8UhqryitbxR0k2tZhRHHqauDFFbKEywQU/DNW4JX3Twg40WjCUqg51NDuFoYe351tEGukezEI3KTAcC4MGlgwd109Faznkle5YIkZqDa9cOQHAL7LWtdtl8pQ6gTgvAP+UftLxKdE5ea+DelikKpB4uiWmUyQfmFRIKlMEUcfozoV/WcgB3uTwu4wBom/pESC9MSvzHrZ3QNeG9El/RACKgPwO8IYpBNiGxy6pMUs5oy+RBkrHuoBkS4shlwT/nrz1/EqhAe6R9CWzXdQTM7jLtaXxnSSoS4dYz7BZiQr+0ry7QCvitaR8IGHFBUBBQf/OoZv1JZanszAHh5kh0IrCbZwu60FuOB6PKsTNDjRsFGHqDVIjhp7509rLRdLg8u1rDcXHh233RkrPHCpfbdA4Av6QwYMIKjy9rsxuCM2V8+41zkA+zFkMfht/SEIBttNNqV/Hn8EtiSwNumRwwnaz1p0n3boJjLQSEfVmi+AzL2FMmQEhlI1+osAznl3Xyz8RaGKGea9jLEEB+Td2Nqp6aMKuI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pYG34disD1QgflnGBykhwzICr1p638Az9tuy1epI7NMY8IGZBfBm0Cs3XQLG?=
 =?us-ascii?Q?zfZX7hVguW0kcEiRNTDhmBD51Z2CTEkD4BCBCwyTJ5bKZWENWWMLmITeGeCY?=
 =?us-ascii?Q?NnCaqN/KRXvqtJ4x0vmk5EaB2DL8JqQfDSR3WAecaAPAe3T/GK5cDphgwI4B?=
 =?us-ascii?Q?obHv2SjOaarp1pWGr3XHELe+NGTEGTHt67CUT3NzTkUXTZOSWJgiyZvz5kYF?=
 =?us-ascii?Q?+Ibhl4a288NlC8PT4vCdl5Bf93hHmYk01PQ+c7BZ6da478Ge8WQnp7n5SWV+?=
 =?us-ascii?Q?qKQ0JPnX6ypVtUgu/79OQVIzfzwNYQlsiuJqSsfNAzbCpgAhA3MDsPgPUwou?=
 =?us-ascii?Q?ulEViA9gyZAE0gwXHadQFITuwKfvATonYh9LlK5NX/P9ZsyO1mfHlx0StFOt?=
 =?us-ascii?Q?ZexLAh9w9gtlTKmaGmwKLFAljhhPjkRWmdr8ldZHiVOTN9pqWibsDpJbxWeJ?=
 =?us-ascii?Q?36IGdTsHgcupOYfmSUk95ufkAlUTUyirZTSPUJV09NfTAynnwPBUaf8InkeR?=
 =?us-ascii?Q?dyliCTSBkH46jM9Fr0xpnzQrViyVdXl0tTWwJgNZjOLTwd7A7Q4letPXnXwU?=
 =?us-ascii?Q?mHePQLsBnp4eHE7LeJnlSr4O8pTgQiGDHITZ2PJMjDJyDANudiI/KItxNWwe?=
 =?us-ascii?Q?97GVAHiaOTOW7N4wgEHcsc4YHOIxqlSOnfv/Rp3EbpPlveK0NNpjJTOuqTbi?=
 =?us-ascii?Q?Ir+hMlPtLrjv6P6WCgxB0YBkW6QItxTf1C5Bf3+QHSBo/wo14cUdjfUu4aSZ?=
 =?us-ascii?Q?jAL7Fiv5H4aRk845N/FyfGiGj6y57b7TWDYueBnTOWNYx+osqmNOU351DZdh?=
 =?us-ascii?Q?/iADJQbeg5tZAtVFvh6fZ0SDtByTOnPR2myMGMN9Dpf5ogNb8QLKh4B/INXt?=
 =?us-ascii?Q?6eLbDHmWxlHf4rxIUrl49PpM3cdlQXWFAs0iv73CFlXCf7u8GTzsTZh0YDXr?=
 =?us-ascii?Q?zTxzp8kA3mRpbhUmYcYIiv65eaZhQnEkUBlteHslsaQwyaSe8suYoYE6NNbi?=
 =?us-ascii?Q?ymZEMTCqPVBG612NJONHKBqvc2YL14pzVoEeZdr/4P+Z3swl7wRVpf1XMwyH?=
 =?us-ascii?Q?0/WCWdBuzGerMy9yExNvHuMTA/BVkytKk3EMys2P/ppsFTHoEV9BXFDpPx6j?=
 =?us-ascii?Q?g2iyMu0WOq/Afo4a5CMsuwwATbogWN/04aJrK1h4xxTYemKcSPFk/e77NyG5?=
 =?us-ascii?Q?CERmd+CC39fRKSg1z+9KC8h4bfO8Z2fjxMY+A9UD3pD2DJspLinyQ7FU9Ffu?=
 =?us-ascii?Q?z+Sa/uGs8EV+pDMO6vH8n9ylRFY0pFZUE4EqrFv1v/CNzzeVFB/zoHiaSdBt?=
 =?us-ascii?Q?hSXj5xVxxMip/RrppIJPL1RKdJu8JODPDieuMdZ+LVZG+ICiAGxoGU3LOMyx?=
 =?us-ascii?Q?P1w5aG6dyPlzWNPxt1Q6izzUa+OiHTUtPr+HeDdY9rOATjOMF/xR/4PXhLlC?=
 =?us-ascii?Q?bG+wo/q3DW46OLn0Na2j6KRM739bO7BNMYRXU8k0/FLxI8LuUUtuhWKksWla?=
 =?us-ascii?Q?DGuGAd6HQKOwra7NX31Ozyfl/JRxcTXtZSEp/lJR7MUx55Lf1q8WrJARxiup?=
 =?us-ascii?Q?oOv8/KWN/bfQEEX0QIGTE5QFJfDCp5ySqoibym4UYYrAf9GcfubcDe74CArd?=
 =?us-ascii?Q?1/4eyzP5Z9j7eBrGRb1JXt48gTsXSoAn5MM3NkskgcAKrICwQ8jh+oNeFto2?=
 =?us-ascii?Q?Nkqt7dzbOl+W+iYBCg0wDbbIBAuNDFoQpOlJc6CpARZoj1UWls40dc1kS6fS?=
 =?us-ascii?Q?GwSjzkHAww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b14407-c9b6-4696-6adf-08df0fdc7d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 08:12:57.7217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kx8v5VsARPQT7VoCYwkP7wRn4BwD4OMlwTt8vVpLJoAFL7Q9IcrJJipH4hlWDLbAtQo5FM2n0dL6mmdYm4/v/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> From: Tushar Dave <tdave@nvidia.com>
> Sent: 08 September 2026 17:08
> To: alex@shazbot.org; clg@redhat.com; qemu-devel@nongnu.org; Shameer
> Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Subject: [PATCH 1/1] hw/vfio: thread vf-token through iommufd bind
>=20
> A VF fails to bind through the iommufd/cdev backend when its PF is
> bound to vfio-pci and requires a matching VF token.
>=20
> QEMU currently initializes struct vfio_device_bind_iommufd without
> the token flag or token UUID.
>=20
> Pass the existing vf-token device property to the IOMMUFD bind ioctl
> for PCI devices.
>=20
> Signed-off-by: Tushar Dave <tdave@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

> ---
>  hw/vfio/iommufd.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 242644aa00..de482128bf 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -155,6 +155,7 @@ static void
> iommufd_cdev_kvm_device_del(VFIODevice *vbasedev)
>=20
>  static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error
> **errp)
>  {
> +    VFIOPCIDevice *vdev =3D vfio_pci_from_vfio_device(vbasedev);
>      IOMMUFDBackend *iommufd =3D vbasedev->iommufd;
>      struct vfio_device_bind_iommufd bind =3D {
>          .argsz =3D sizeof(bind),
> @@ -180,6 +181,15 @@ static bool
> iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>=20
>      /* Bind device to iommufd */
>      bind.iommufd =3D iommufd->fd;
> +
> +    /*
> +     * Pass the VF token when binding a PCI device.
> +     */
> +    if (vdev && !qemu_uuid_is_null(&vdev->vf_token)) {
> +        bind.flags |=3D VFIO_DEVICE_BIND_FLAG_TOKEN;
> +        bind.token_uuid_ptr =3D (uintptr_t)&vdev->vf_token;
> +    }
> +
>      if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
>          error_setg_errno(errp, errno, "error bind device fd=3D%d to iomm=
ufd=3D%d",
>                           vbasedev->fd, bind.iommufd);
> --
> 2.34.1


