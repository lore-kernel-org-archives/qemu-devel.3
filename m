Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA38CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcJoE-0004Gr-DE; Wed, 24 Jun 2026 05:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wcJoD-0004Gh-4D
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 05:22:13 -0400
Received: from mail-centralusazon11010035.outbound.protection.outlook.com
 ([52.101.61.35] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wcJoB-00020E-4r
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 05:22:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZwRaXBkpcRtHaBzEzhF1ugO67e9OTsNklHctElkqIG/H9hV64cWwkEkas6DPXYM5xqHIXJz1aFxcS1SYoqQdD+8VARIhA0Zsac26XPh+mObz3xAgLHlYZN9wbe7RA/LGJusbjPT+7dBMZ1VP9FjprcGTsPc8HryTzyplB0qPDdoqDDGdRGvPTrYFCs2XMwZdbbfxqFlGr3MDXescHir72RlEORZXzTG71b0yuiKMlHp2uoewMnNyLuXCtuFkQTlecNcRjVpaY89P5zXx8F+Igs48ugRmxRBR8G15aIFKFlcrjEys3WQeEQ+PQTVF27r7gcExuRThWvIGOJ0WNAQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrnQ6y09waafm02ZmCI94pOkw2y07FbSIuCkYut4cpQ=;
 b=fBdk+oV9zfVm8koDh0WYBXd8ujs8QJviSiM1ZUpLRHw8BGgltKERvaZxBBmAecRWfXIgJiuVOfxT2f7gKLi+QZH44tgdv7butcrqgCan7IHnGMyfV6y4gIx7UqPqJv+96SDcgZ5MqbVEv8YrQccTxHagUtMXaeGCs3gHxh6tmEj8GJtp2jSXeeXPM7NwEJgvGMJLLsciwgnggpBFImZFFXOUCIYKuhWEXgd+va2OPhYwclwL/GEX7o0Tvgc4qRERFGyOFKbO0Mp7NCTjinx/xHgr1yViGoH3UJ+pc9YcCTKqlqSviTFopUV5r3fUPKmiit/TfyPMlfLKrAeqnskoSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrnQ6y09waafm02ZmCI94pOkw2y07FbSIuCkYut4cpQ=;
 b=PZ0wq0e+/ZBZwBjSuPxoeihEX4rH8ECDX5xs57GMql7/xEW3VpsSVq2PrtYl8tq/xtAObbZ1jSZ1vcZ/Ol9MvbfFjgmgpUQcdOKjU1m4Zzt57oawO8Y7ZgC5gB6ep1bCfhKvNTke/ZPffbJTwRsX98fGxrmLbpprd0k9teth1MhjUfLqOSZTWATjdnP/HbiopIC9a5KJkmM5b8gnLh8krZ3ro++8dVmDDu/Cx96FGqQDqPjMftcQ7o5UZouGY3BYKQTk9OUz0jlCsY+kxowXDdAW86zVVTPd0BCzAk9aC7VFWIIKqLlpv8njj4+xx9YranzoL2H5bhyGgC245du3Kg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 09:17:04 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 09:17:04 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong
 Duan <zhenzhong.duan@intel.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 2/2] vfio/pci: Add ats property
Thread-Topic: [PATCH v4 2/2] vfio/pci: Add ats property
Thread-Index: AQHdA1HXQ9kFjofoIU+t8iorrcMozLZNbbmQ
Date: Wed, 24 Jun 2026 09:17:04 +0000
Message-ID: <SJ0PR12MB861465BA7008FD268F463B32ABED2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260623204943.989903-1-nathanc@nvidia.com>
 <20260623204943.989903-3-nathanc@nvidia.com>
In-Reply-To: <20260623204943.989903-3-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|DM4PR12MB8560:EE_
x-ms-office365-filtering-correlation-id: 28f36bc5-2685-451f-2339-08ded1d15b4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: 0KFnLLqSCrwNr3HtO+hQslLuWlZfv3FvbNDYgiiqxbu5XGDIvqdO5SbKVQb88SwHI8qnoKg1TgRTZVM+eYMfiKq7mXI5bBaCjEhBF+eI6/TW8VqCV3oG1x9ko9umTcUt9mjasg4dhYv5ZS7BqGr0J45hobuEi0VUApgf2TcwwnZIVLJNLNFQqJi//yeT6+KXm8G0LMJMoYXaBuhp0G/kU5A+mPPhO17hQnu2frPzYTjxScEqPWaxeNyMUGHOIGNA95R1Y5OGK6bcYcQZOxGd9Bwgf+KjdVLCK5xEBmbTrsbVZy3WbJT3lzYeLJGx3hBhdtJmsfIM8fDFHWdbYT8waHEi7aOPd+0R6XBDBu+HU94qoFwKZiu2RGc4C8lX8cd0obFVJh6sUX28HH6JXrQfokWMuvC1LPOYVnMzoqnpVelqdNPEPcD34Umt2int4m9T1k5RfvwscLngO8yYZyIFrzLLaC+mNf0jR76lGU75HMa75Ks/MoJKTiDtjm97Ii3vOr+SOe9q6auYoYbSvgNxttddsNOxI2uJPCLAv5PGNYyV9ccJp6u2E3Jod7QULyDnTIN3mXtBqIrvOCr2uuVpB54/7I5vnSx0zJY5KuKcSUOykdUrF9fATYBh8ep/hsKAfh1UOEXswYh1YSR4hxOcPO9cmh0h1GfAia8E9CcqnUqQqN+pMDL5dsFLFLd8jWJ32ZNmRMcI3jLVKD4yi85/s1O6M1FnwbATogXKaw5FYhs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g+qE/z6OTvqpHq//N71ReAtX7HJnPj8Y0+DFuHWmbia9O0YAmFUA54McwA?=
 =?iso-8859-1?Q?nEYmvx6ThNPw7TNiDQLu8IaLJPeyHJFw1nbZHyl5C12MhN6kDdyFuKiNF0?=
 =?iso-8859-1?Q?bV2kMjrsRSN26q0EqzFfsNMMOAITxPOdM4WAqV/MZkoxOoeDSedEamM4tO?=
 =?iso-8859-1?Q?RxdcYinVpDvNeEr8Mr5QAA9MudQ8jx21cZrFoHsDQ9JL9Qcr4mz6UH6SM1?=
 =?iso-8859-1?Q?/voReNW7CqYssidaZxlyc1D1S6x24JgHhW88WdL7Z+KgNUeEnurfNMdIf8?=
 =?iso-8859-1?Q?jvttEVFg2emFM8uOCjbjPInBoFYk9N+FFABi/D37CVRXfJSR2FNLiX3vye?=
 =?iso-8859-1?Q?kDzqHw9zwyPHR6cGdF8+IbAxNOvGuziWq+ynEGvzbre3eqIYfM/Lxu4xqV?=
 =?iso-8859-1?Q?wL3IiSIMVe7dwW0DxgvhO346J/3LysB3gGmsRe/HMFzjEzlIZDXB23eFXs?=
 =?iso-8859-1?Q?uQyvcH3m3SZDJypueP0fBHcyZooSXQGOzjjuS+lZgqwQHOqo+95qS84ZWv?=
 =?iso-8859-1?Q?PtSf4N1Iz3d3t3dobQgu3cFFvlzxL1gCsI5A03tH4DW6L4JG98+vJta60w?=
 =?iso-8859-1?Q?pmY3iIEoUV6P0HcnZyPrvbfE2TnYkpWVzSWthQ56bHBkK1Tc/FPHcvTTj/?=
 =?iso-8859-1?Q?4DYaLKukxM4UbH77TmNtDMF4qQ+MrM3UtTqzcHA/amM2GtAXEYb5Ws9t78?=
 =?iso-8859-1?Q?wZItglM0UAyQoldnTpL0Fa8syVGba9y5S9R9+z5fYb52xptY7QkfPDOAuY?=
 =?iso-8859-1?Q?NW4z7VmSxaAltgF3kGUQ9nwUcGBTEyYFBBPQjKoAMLBC4JfHvtnqECtdru?=
 =?iso-8859-1?Q?hCypq8+kvYa9lvgNxMG+IYWNGeDKOK7wBhJ8Pq43DYKCmKk8tUARahWboP?=
 =?iso-8859-1?Q?bhJcxwzbuwyKWvVONcZKfKAuup6PkW8w5kc1LVYQKCQc3rmL4Xnf7vEBfU?=
 =?iso-8859-1?Q?Mb2kUCRdvsj0E/S93MPcvdIghD7COG6T9CBXtzf03tEVRgp8ZxleTWlZqj?=
 =?iso-8859-1?Q?Q7EC1a0QT2tylcSk3rtHEgztk9DvZ7H7agvUnqMKZochrhsy79DrH2dUw+?=
 =?iso-8859-1?Q?msUAaEI1pDGSjAukNlnnYXdp4dVDMwtiTnoEwL4cRVLIXW+hgahKec4ddO?=
 =?iso-8859-1?Q?LEkuMDhrAlGMheX50BYiFKVMq2EnSzZfOFaqenwaTNy3higtxBQBKAASay?=
 =?iso-8859-1?Q?9VjaUYaVQdn2JI02vtZ4vtRDorbhgFKT/PTOIiqpuUhNbMbyiQ/0BfBIOS?=
 =?iso-8859-1?Q?DiQt+IccgxN8dFj+uMpMo/3JPSp9QxGrsQCtsWoioBpqImH5q5PaKfzbi6?=
 =?iso-8859-1?Q?K9xHd3LKCPoE6Xc2pSVsw2ewGK+IWtMqkAdiZ86O4UpVXApGpQXoMt+kiw?=
 =?iso-8859-1?Q?xVzLfVx6Jk8PzlKwrapXx9I7J3fYL5B5HAX57v+6K6ixFo9hkhVL72BUNn?=
 =?iso-8859-1?Q?UxXqCDDagX3/J37U1nbwOXRFeAlHuExm/8pUHSie5+UZuCKg9SDrXF1KhR?=
 =?iso-8859-1?Q?I2eqet9bA2sJgNM3iyTRdckMT9GNHoSzc4Hy33pY/l1q0okwjfsohD1VVC?=
 =?iso-8859-1?Q?0SA/dtNllpc4ghoOFLmvHdrVYuoAxrgb8CtA0kFDNUTVquIp6XRMuaBmS1?=
 =?iso-8859-1?Q?KigvoX9hWHKdfHsXWQs5cjvsaR08L0cwF7kwv0qYY9ulvHdxi8va+ueGX8?=
 =?iso-8859-1?Q?EwWhH7+bLbrDXcvv2P2chX9PtigjrrYN+XwYX9SJ7wwU8WPHryVKmNzFHL?=
 =?iso-8859-1?Q?gK/RlpZvLXw2baV0xODnJqsUHYl+A8ZNlFtHyntgA2Yv/g7IbHZfUBdT8+?=
 =?iso-8859-1?Q?9wDxdXPILw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f36bc5-2685-451f-2339-08ded1d15b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 09:17:04.2769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWCSCSONdnVDRCOev0kd0o8DNa0TKWsh7lL/mT5pazcDnhLgDBogoF0pwYcgZzXbGvmBQE3idf/vs/I6aXdKgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560
Received-SPF: permerror client-ip=52.101.61.35;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
> Sent: 23 June 2026 21:50
> To: qemu-devel@nongnu.org
> Cc: Yi Liu <yi.l.liu@intel.com>; Eric Auger <eric.auger@redhat.com>;
> Zhenzhong Duan <zhenzhong.duan@intel.com>; Alex Williamson
> <alex@shazbot.org>; C=E9dric Le Goater <clg@redhat.com>; Matt Ochs
> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer
> Kolothum Thodi <skolothumtho@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>
> Subject: [PATCH v4 2/2] vfio/pci: Add ats property
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
> Emit a warning when ats=3Dauto, ats cap is present on the physical device=
,
> but kernel reports ATS as unsupported.
>=20
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

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
> index 9c06b25e63..fbec41f0f5 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2546,10 +2546,53 @@ static bool
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
> @@ -2635,7 +2678,19 @@ static void vfio_add_ext_cap(VFIOPCIDevice
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
> @@ -2646,6 +2701,16 @@ static void vfio_add_ext_cap(VFIOPCIDevice
> *vdev)
>          error_report_err(err);
>      }
>=20
> +    if (vdev->ats =3D=3D ON_OFF_AUTO_ON && !ats_cap_present) {
> +        warn_report("vfio-pci: ats=3Don requested, but host device has n=
o "
> +                    "ATS extended capability");
> +    }
> +
> +    if (vdev->ats =3D=3D ON_OFF_AUTO_AUTO && ats_cap_present &&
> !ats_needed) {
> +        warn_report("vfio-pci: host kernel reports ATS unsupported; "
> +                    "ATS capability will be masked");
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


