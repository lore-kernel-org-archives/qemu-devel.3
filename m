Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6A1CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc4W9-0001KV-Pj; Tue, 23 Jun 2026 13:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wc4Vg-0001Id-Ir
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:02:09 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wc4Vc-0002hv-Qi
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:02:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XM053/f4fSeTt+GEMLHvI/yWLUPmnG0kKhe4bwbu7+HJSR9fkgIdFWJoRVkhqe4gnOWwJIErBiLsmbNH8EhpRa9bnxEXZm61Cu9+4cs7W79UtRN5dGGaSi9iny8brFSXGvLj7UGrgEsVCrqs7UBDJA8Uhk2a+HXvfCrVQBnmxL54DtBcTNluDCl82PXbl/tDkUmmOUDk3b5KpjCRaeu5lckju3n6apI7V9eK/t/WhkVySMwelZYSjcW6RHJoXHANzv1wmymJGOoadepZ7FTNp36GG4MOiqbDJpvPHa4sHWHJAsBOr9mPUDTQhPWMZ3XxGjn/6ZE0SLo257utevlQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vdO5Xcjb7M2CYqAShFcy0r+vltz55Z0tlKJNvdvD5U=;
 b=BcVlFCmm+yf0uL+Mm0biQ8WLgsWzAI6Ks+SoDW5geGZcVWW5DEDelFd10apK+S1jlUaBTqqZfaM1+aZdHZAF7IuygI8ldzxcn4T69Eg16OhJrCqdt4rGkyk9pPuJypZHR7KXV6iVHVoHL+L8oF1YXcSDLuafplWY81jc8+iWMo8k9ZuH+ohfwKpgJRaIxAqJeLurz3YHrzNAjrOukovar9tKJnfFYEzu37k27V3ZzedIyLpAP+NmCs7MveaA9sInmrkGxNCexxvuICRouQBMpjfCnudQtcencuzv35OWUEIOTQ+eS8EOFgavMOadkvKix2fe+ESF5v0vJS90/3hfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vdO5Xcjb7M2CYqAShFcy0r+vltz55Z0tlKJNvdvD5U=;
 b=FklkmDiyFNd1TuRSeB3PWMcockDsGGOe+trTD+VUHY/+grk0KPS8xb02P0vnMx1iHBUUifOKN3yT1bpX++g69TjO0rw3l9eUTsoTmGJOsL3/4c+IMY5via3EdKlFoikd2EA9/9bHA+/tGoE68rAAYCiPq+944kywaUnnvXWs9LFS8m2bMIiazQmbaLpomZJWojydFX8vU6XWaid640LyIdZ6X0F81TEvjfYTg0sAOUxWAfhyAE9qsu211rkK4zYQsOStOQxtakGOtktRG+RyoL1q8PnWaMrhz63xDIGmd77qaY4g2ixjHwWwhHjYFrJIFr3CD3i3q2o2FnEPFUXkeA==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by SA1PR12MB999254.namprd12.prod.outlook.com (2603:10b6:806:4dd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 17:01:55 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 17:01:55 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong
 Duan <zhenzhong.duan@intel.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 2/2] vfio/pci: Add ats property
Thread-Topic: [PATCH v3 2/2] vfio/pci: Add ats property
Thread-Index: AQHdArkF3k4rsLstbUilR5vgfiyqVLZMVSXw
Date: Tue, 23 Jun 2026 17:01:54 +0000
Message-ID: <SJ0PR12MB8614F88365BE0F4362ECBF84ABEE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260623023540.836825-1-nathanc@nvidia.com>
 <20260623023540.836825-3-nathanc@nvidia.com>
In-Reply-To: <20260623023540.836825-3-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|SA1PR12MB999254:EE_
x-ms-office365-filtering-correlation-id: ff09c157-58e3-4494-7d2f-08ded14920fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|18002099003|6133799003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: /6EhRlAghI1OuA+cJqZcQcvt7EnkTPfd7/M3KwAfybYfS4XTG2fWSt7GFtlGRFLKHCZPYYvdUPaVKWzlHrUnBuGJ28cNc1FXrkVx42v3LAYQsH77m6GpjRezbHsQkrJkmmggjIxlh3ayG9DCaNEHeitfJApVVXPmplLi4I48vU/ZWgD7c3y8ak8Xeu1R5fltxSZpQq/zW5jbX9G2fBGHmwGC1a+UIQTiRvUAwgH8jFzXNvgjDR3tLEzOh30c/ABad/hDOa20FSr8ze539dUF1owPmRrM154TJxNXDXiDG+ll71IprIKbN93P4CvC5RiB/6H8W+ORIpXrVIjFaFRpyxwflsDGHsestXqUFrF1lXrWSOh2wYouRU45Vx0UH+QueDi3LF0aCId86ua95XLqjqX5EenruW1l4wlmrfsq4+R6lHnAnnYa6PxwDbthInMyPk5bPjW2v3pJiy6qg2TJo04ibxNAv6wilrSEYR7sdY55cUzlCO4yLHbSuSe63jnvWga9E8IdaXy/L3G+s5j0L7R6t3GYXGw1+XGSUT6uN+Vv/hXruYq0BcohTEppusL9nL2lUgYjikmvUoYDyTX/npe1OiNyNBxW8ujcRW/rNMV3s/exc6kPm507lDMV9lYGkLzexAF0j3Xqf0kaJPWdfzLdM1fhyMPAcsVXwYoH85cTcs0N1tEqMqNDuEclxhn68IQ/Wk9H3gOeowI86bN2GlndFX4nmbuGAwR6WnCtxZ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(18002099003)(6133799003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DBGGH4DhptvI5hMD+i55qh10Sp84Lgub718gw6WBtFfoQxq8eyg6pWBcWQ?=
 =?iso-8859-1?Q?iDzXWOLJUf/0Bah2gM6BmNLgBuSMXIbofu4xBk4VhJyntjjYOEKImxawzy?=
 =?iso-8859-1?Q?/U1NKlF6cyCrEFdKdU781b5bmxLc8Siq1tEv+U7bk+dPb4D2Nyb1vpoPeP?=
 =?iso-8859-1?Q?hH8TEn3SGLqNJj59N2gwHp7wkSbzjkWX6N3QM7cAJcFdpfKm8jypwbUlO1?=
 =?iso-8859-1?Q?DQfAf1hGP1UJ9aZNfEIhHswjgapL6zhqUfhDHWxHjTYgpxEpOlPo0svMX5?=
 =?iso-8859-1?Q?59Kclz40O1fpgAXMyqw60zJx1860PSm5BeTjJDbM986V2N4b3BVhy4rOoZ?=
 =?iso-8859-1?Q?VrKcGcnbYLs67Qtugh4BO1Wwr8Fr2M9UHVWPBF7Qcygt9XwFyLTAlykusX?=
 =?iso-8859-1?Q?BBnqkF4O9Nn/x1rEheuNFKZzXgm+xwsP//o3HoSJrYSoLSf+2Cb2nZyveJ?=
 =?iso-8859-1?Q?vQzd7fM7vAfTtjAo9F4qGq6Y377+cBYzgcqIANsJcsco8wo30sfcb61iJB?=
 =?iso-8859-1?Q?f8BY+LzH4BRacQtnApPU7VLK/5Xfz3cQtNhYhJaOUQS46YtLqawjDfJ6A4?=
 =?iso-8859-1?Q?ijX7m7JFDRVrkuHP/+a5lFxIMI2441Atk2fWNGxEqzhEo9ybuEVLvX5YOm?=
 =?iso-8859-1?Q?TZ5VPBrZdxj1tKa38H8U0LVYdhUoJKeLp6Elo5D3TL+LKnyjsx9ddmH8AB?=
 =?iso-8859-1?Q?x1gw3ZtecBorJ+b/3MUsvFvWhjJc9MwbKBDPm7iANsEyXlI0uVdxdpQ9If?=
 =?iso-8859-1?Q?ykFT7alk/oJbiz773Bp0mqZlBVkn8ufo8jz+SQrmmYTBBcTcLjsaYc6Dbw?=
 =?iso-8859-1?Q?fhRBBA/aBCBOozVwd+l5XwqsEM93/1qEmX/09+bLxxF5tsrrPmF4rF/JT2?=
 =?iso-8859-1?Q?RdjK9t0y4OvXGxyBify07LKc2OFiIWd4Si9CAeoZz/gJQ1USM9EcTO22qw?=
 =?iso-8859-1?Q?oqipah2Mx7HMklAGhzlSU62uY15rSRx/r0qt7FcoIkpQya4+/fSohbNWDA?=
 =?iso-8859-1?Q?8gz6g1xxwbosmZ6zaidK6vN+K9WjZcGsrbDxUDy6Qhe1EJ9VvRz9kZp6mV?=
 =?iso-8859-1?Q?dFJqnGZA3kxol3e9c9Y7icICr/L0uKNRSENZlRp9An+arFhyCmExO8Y/KU?=
 =?iso-8859-1?Q?WKZItA5loQ9aB5BE3I1gM0MENYNQjldX3EjnOMsLlNAhbG8PXKoBcy4jRx?=
 =?iso-8859-1?Q?2Oj4BPdTOJtthbv9AueBHC5z9IVNtkmd07WqQWdZrYoC3Qxsx67rnVxqVa?=
 =?iso-8859-1?Q?0jRG4Ty/Csc0FpmmnaSjGHvMl1rsrJjatLIr2yB0/ocbOklMPfboYZD4aI?=
 =?iso-8859-1?Q?/IQhAbfrdhCHVZniQw88ewM+tw/CD9mBbg8akTec2ChMNC/Uu7XCWxAxY6?=
 =?iso-8859-1?Q?qPtmQn2KzWqNCRAYVYPBacBr51K4WJFX0Mi7VKSUMgzAAISIfiEeast+WT?=
 =?iso-8859-1?Q?pWfFuwa+U70hfJEA+/+NYiu9KipZRmeSqSx3vVUT5RtGagJs7BhWcSuJWy?=
 =?iso-8859-1?Q?3aJZQjgN0PXySYIGuvj6K/cJgsZZnDzwP/jFOLSS8uKzgF1VJWIb/DAs1/?=
 =?iso-8859-1?Q?ZaHnCuq3DYYPCR1UnWOPi1vD+rK8hK9BlWz4CcO0GHjJSzBFcFvK8LO8uw?=
 =?iso-8859-1?Q?ZBNXwWz1VqHWUbkJgc8xhBhZb9w0i/uwRSIkWVmIpWmhMzLu6JZ/9n3pAg?=
 =?iso-8859-1?Q?THraGbuH7zqU1j4h9CuTsXwPEci5rXYDxBHtNW0d+mU41e1t6hMZPt0E4H?=
 =?iso-8859-1?Q?rf4QWlOxMFbKv3iLU1vYFduSW5CJUYzsPxzH6+lhr1w/joZz/Yy5vj4LWU?=
 =?iso-8859-1?Q?SJN4GAICNA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff09c157-58e3-4494-7d2f-08ded14920fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 17:01:54.9233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQ+jU4uTsQbBUV3PJ1TtmdVTw9FBZfPJKeIII9sdM5U2hTHg4kQT/WChJfJTcWdriO/AvGrlW0nTBDTnaV6MlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999254
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 23 June 2026 03:36
> To: qemu-devel@nongnu.org
> Cc: Yi Liu <yi.l.liu@intel.com>; Eric Auger <eric.auger@redhat.com>;
> Zhenzhong Duan <zhenzhong.duan@intel.com>; Alex Williamson
> <alex@shazbot.org>; C=E9dric Le Goater <clg@redhat.com>; Matt Ochs
> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer
> Kolothum Thodi <skolothumtho@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>
> Subject: [PATCH v3 2/2] vfio/pci: Add ats property
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
> extended capability in config space but we should not expose it (ats=3Dof=
f,
> or ats=3Dauto and kernel reports
> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
> the capability so the guest does not see it.
>=20
> If ATS is explicitly requested but not supported by the kernel, fail
> device realize.
>=20
> This aligns with the kernel's per-device effective ATS reporting and allo=
ws
> vfio-pci to mask ATS when the host kernel reports ATS as unsupported.
>=20
> Emit a warning when ats=3Don is requested but the physical device does no=
t
> advertise ATS, since ATS cannot be exposed to the guest in this case.
>=20
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/vfio/pci.h |  1 +
>  hw/vfio/pci.c | 88
> ++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 85 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index c3a1f53d35..f2934f2d84 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -188,6 +188,7 @@ struct VFIOPCIDevice {
>      bool clear_parent_atomics_on_exit;
>      bool skip_vsc_check;
>      uint16_t vpasid_cap_offset;
> +    OnOffAuto ats;
>      VFIODisplay *dpy;
>      Notifier irqchip_change_notifier;
>      VFIOPCICPR cpr;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9c06b25e63..c0436b4c04 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2546,10 +2546,58 @@ static bool
> vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
>      return true;
>  }
>=20
> -static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
> +/*
> + * Determine whether ATS capability should be advertised for @vdev, base=
d
> on
> + * whether it was enabled on the command line and whether it is supporte=
d
> + * according to the kernel.
> + *
> + * Store whether ATS capability should be advertised in @ats_needed.
> + *
> + * Returns false only when ats=3Don is explicitly requested but the kern=
el
> + * reports it is not supported. Returns true in all other cases.
> + */
> +static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
> +                                                 bool *ats_needed, Error=
 **errp)
> +{
> +    HostIOMMUDevice *hiod =3D vdev->vbasedev.hiod;
> +    HostIOMMUDeviceClass *hiodc;
> +    bool ats_supported;
> +    *ats_needed =3D false;
> +
> +    if (vdev->ats =3D=3D ON_OFF_AUTO_OFF) {
> +        return true;
> +    }
> +
> +    *ats_needed =3D true;
> +    if (!hiod) {
> +        return true;
> +    }
> +    hiodc =3D HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> +    if (!hiodc || !hiodc->support_ats) {
> +        return true;
> +    }
> +
> +    ats_supported =3D hiodc->support_ats(hiod);
> +    if (vdev->ats =3D=3D ON_OFF_AUTO_ON && !ats_supported) {
> +        error_setg(errp, "vfio-pci: ATS requested but not supported by k=
ernel");
> +        *ats_needed =3D false;
> +        return false;
> +    }
> +
> +    if (vdev->ats =3D=3D ON_OFF_AUTO_AUTO && !ats_supported) {
> +        warn_report("vfio-pci: host kernel reports ATS unsupported; "
> +                    "ATS capability will be masked");
> +    }

This will be slightly misleading if dev doesn't have the ATS CAP at all.
Isn't it?  I think, the best place to do this warning is below where we kno=
w
ats_cap_present is set or not. =20

Thanks,
Shameer

> +
> +    *ats_needed =3D ats_supported;
> +    return true;
> +}
> +
> +static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>  {
>      PCIDevice *pdev =3D PCI_DEVICE(vdev);
>      bool pasid_cap_added =3D false;
> +    bool ats_cap_present =3D false;
>      Error *err =3D NULL;
>      uint32_t header;
>      uint16_t cap_id, next, size;
> @@ -2635,7 +2683,19 @@ static void vfio_add_ext_cap(VFIOPCIDevice
> *vdev)
>           */
>          case PCI_EXT_CAP_ID_PASID:
>              pasid_cap_added =3D true;
> -            /* fallthrough */
> +            pcie_add_capability(pdev, cap_id, cap_ver, next, size);
> +            break;
> +        case PCI_EXT_CAP_ID_ATS:
> +            ats_cap_present =3D true;
> +            /*
> +             * If ATS is requested and supported according to the kernel=
, add
> +             * the ATS capability. If not supported according to the ker=
nel or
> +             * disabled on the qemu command line, omit the ATS cap.
> +             */
> +            if (ats_needed) {
> +                pcie_add_capability(pdev, cap_id, cap_ver, next, size);
> +            }
> +            break;
>          default:
>              pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>          }
> @@ -2646,6 +2706,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice
> *vdev)
>          error_report_err(err);
>      }
>=20
> +    if (ats_needed && !ats_cap_present) {
> +        warn_report("vfio-pci: ats=3Don requested, but host device has n=
o "
> +                    "ATS extended capability");
> +    }
> +
>      /* Cleanup chain head ID if necessary */
>      if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) =3D=3D 0xFFFF=
) {
>          pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
> @@ -2657,6 +2722,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice
> *vdev)
>  bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>  {
>      PCIDevice *pdev =3D PCI_DEVICE(vdev);
> +    bool ats_needed =3D false;
>=20
>      if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
>          !pdev->config[PCI_CAPABILITY_LIST]) {
> @@ -2667,7 +2733,11 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice
> *vdev, Error **errp)
>          return false;
>      }
>=20
> -    vfio_add_ext_cap(vdev);
> +    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, errp)) =
{
> +        return false;
> +    }
> +
> +    vfio_add_ext_cap(vdev, ats_needed);
>      return true;
>  }
>=20
> @@ -3815,6 +3885,7 @@ static const Property vfio_pci_properties[] =3D {
>      DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check,
> true),
>      DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
>                         vpasid_cap_offset, 0),
> +    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats,
> ON_OFF_AUTO_AUTO),
>  };
>=20
>  static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
> @@ -3966,13 +4037,22 @@ static void vfio_pci_class_init(ObjectClass *klas=
s,
> const void *data)
>                                            "destination when doing live "
>                                            "migration of device state via=
 "
>                                            "multifd channels");
> -   object_class_property_set_description(klass, /* 11.0 */
> +    object_class_property_set_description(klass, /* 11.0 */
>                                            "x-vpasid-cap-offset",
>                                            "PCIe extended configuration s=
pace offset at which to
> place a "
>                                            "synthetic PASID extended capa=
bility when PASID is
> enabled via "
>                                            "a vIOMMU. A value of 0 (defau=
lt) places the capability
> at the "
>                                            "end of the extended configura=
tion space. The offset
> must be "
>                                            "4-byte aligned and within the=
 PCIe extended
> configuration space");
> +    object_class_property_set_description(klass, /* 11.1 */
> +                                          "ats",
> +                                          "Control guest visibility of t=
he ATS PCIe extended
> capability. "
> +                                          "Valid values are on, off, and=
 auto (default). "
> +                                          "'off' always masks ATS. "
> +                                          "'on' requires ATS support for=
 the device and fails realize
> if the "
> +                                          "host kernel reports ATS as un=
available for this device. "
> +                                          "'auto' masks ATS only when th=
e host kernel reports "
> +                                          "ATS as unavailable");
>  }
>=20
>  static const TypeInfo vfio_pci_info =3D {
> --
> 2.43.0


