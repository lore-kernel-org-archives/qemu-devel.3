Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFB5CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCb86-0004Mt-Oo; Fri, 02 Oct 2026 07:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xCb7z-0004M5-8K
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:08:36 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xCb7x-00019M-CS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:08:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=merW0INWGWYQircJ3VqsDnLCnurE+v8bp+G1Gf3VPeefNrFJDfP34/af9P/Ae1Uro8Sc+YlSHK+1AiX56l6VCihKEFjqGDF4vvJOGdnUfD6d/WHxLbog3X14iNUigu7FAlQDF9e1/+s5FL1YaCs8MJNJ+7EXmFLr/k8bq3gqpxL1JZnR5s9noI5IOu8z0XroVG2J8ldcrlAheRi4L9JcrBRZjNPjX1xGapDEt339f/Ew8j/KKB503dw8gj4eSumkZnh05uZRcM+qMQe7n37qgtY3QBy6oTBcJjNPF97TNsGiA9nlIOKMY9BXl5u4K4lM4m41coPVQxaN4hzhw15L3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5vBvDw/oU2Ibr+Tnz+ITqZY7r4J1OYWr3gmn5p/uGI=;
 b=hkOfVO4COprYipWkmah44h8Mqs1/qxLy2Q4nIAa/QMxdRkRBZBREnSobRHJvyYIW7zE0GyfDbgMDNTTE2QMiqgPvl4n3Vpy7B+V+zfo9BHb0PiOml1uBtndyrKasjWZ0v+12RZoz4WurqhRoBHSBQbdQ1wCqc8CvBpAGHH7EWjDvQN9ZG4oVhpE6i4uqm+OTpYqiGXy24uzM7GcSR17u8DdVCBJwIy1lHTfDPjIP3x+ATlBhou+C28i27bQl4OVCz2gcHxOp6KKjh7+WHrno1A2hPdNdLQGvCJMyCq4NglvITfbcA97uwBRukBEv1aYtk08SUJTwp3v1HSP8UFXzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5vBvDw/oU2Ibr+Tnz+ITqZY7r4J1OYWr3gmn5p/uGI=;
 b=dHbAfQGvAgDmGma0+BugsyM4YsdBj/pQQLxIMoVtqMmhjKFJTbdIe4cZtf1zZTUYy0DPQI+cPz6LD0Ohs965+mAFnwaJMjzFV2be09z4VHqO+LFkQf0hvNoYC8QLsqwf1t80Hll4wk9FexWAvR3VV/L+C2Tu0NYFvJ1yua9DEIyZhLrUt6bVQsfsQZtw2oDzHe0JIEWdU7ibRUcVA1cTfl3JdkSJhH1dznVxdlX95hbUCWrsBrb1I5zcPy7ThdOQriHQl6n05aI7xR3A466szxxbQoXgbnVF6ovsAP7p/2xZGkdwy1/8I2hWUOODHGY+axJEFwNPJd5HYQtmE1f8Og==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by CH8PR12MB425199.namprd12.prod.outlook.com (2603:10b6:610:32d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 11:08:28 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:08:28 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, Alex Williamson <alwilliamson@nvidia.com>, 
 Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH 2/3] hw/pci: Expose ACS ctrl on Guest as configured by the
 HYP
Thread-Topic: [PATCH 2/3] hw/pci: Expose ACS ctrl on Guest as configured by
 the HYP
Thread-Index: AQHdStxfuAqVI3T1mkKgqvrTv4/cHrbqH8JQ
Date: Fri, 2 Oct 2026 11:08:27 +0000
Message-ID: <SJ0PR12MB861420C62807B26BFBB42F89AB892@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260922215008.2554402-1-tdave@nvidia.com>
 <20260922215008.2554402-3-tdave@nvidia.com>
In-Reply-To: <20260922215008.2554402-3-tdave@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|CH8PR12MB425199:EE_
x-ms-office365-filtering-correlation-id: 117f81fd-490c-4911-7fca-08df20757c66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|6133799003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: ryUlqlHeSjnRAyWT918CAJbCC8fw9BWke/gOUf1/bawEyVPPVCNhQ+ajcoXqnzuqsi9CkvSFKVvuOuJoNjgaNYc03RwRMcr4/vuJwI/HP319iqbZIi0WNw0pcMiCMUf6kcNI9VXjMUfUsPCRadrX8f/MlSMVn60tgEbuvo4h4Kil6dt5h2l6Y3ZlHJA5oWOo5OTz3kveBpplH9psBiHpok5ynD5+HTlNjhpLfn5cp8w7U+zeZ4Z2Ljb/TGumWgzMNWWCt7r04ot3dcTrPtlIxBn1VzjomW6GcURWAIPzrLPRONW8pW3OK8+6Z7T2q6evQuOuPX2N9VxFev63lOHxm9xuT5oYvwgIHGGJFfv3cezstAkfPD4cH2HvbYmZd/bSzCW+VyL1TfT4hVy2H1C5Vdho0OImiVpUYydtCPTwK3vXP7MXbOB7wRkFkgSntMAMsyOKILGOq5PYuWwbU45NtbJuz+iBuTu40c/Sn6Sc/3R42eOrA9zcov8tCrNvaI5vBLB7W8ukvhNio50+KvQHakgOFYE3Z8qp9WKZIAOac71hL2AwgD2W7P9zud3hed2ywtKzUdUMY9PjvWhwscKY/LA8dxV61YJI9s5e4yGP86HclQ1/+7p4JNkStCKrK2KXDbGyBLau8yc2ySMgC9+QU6/RmfD1GFdkm1S7ggwsdswv051z0de5OWIYyw5lCX28mAqD0mpC+XPGqL6mIFiAhWQw+QUfi9britli+LtkgS0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2bqeaNwqnuDndlWuXNHy4xLSF939dJ8/2proF9zt1/fF1wSGXNhV1++B85D9?=
 =?us-ascii?Q?hVUW0SNbPal0i5PF+c8F8Eg8Dj2CWFU7SPiVFaRuAwXliodDURbz9FKCrKAP?=
 =?us-ascii?Q?prWIEEf2nynvRUvR9naMTpb58epHS5qyjuCCDUNxEMTJubqFF8PEsJdBbdnh?=
 =?us-ascii?Q?uiedWYihZ0jChQj6R+3puraKfytpQSoEVtIWrXuXYP/lEJWaOk7PRapAXfj2?=
 =?us-ascii?Q?iRnUMs2yPOCVBKvHGN2xDUYH6CXpQk53OdiKhztTtsTfHoUFg9Av7l77f8cH?=
 =?us-ascii?Q?pmvMnn3Cbq7/3uY0MpvsSprfkMB2vavK74t9fqRfRXaN3EwrAK4FuFTiREIG?=
 =?us-ascii?Q?MXh5M5K7VR783fHB7c974JIzVdDh871Bx9yHe0pA/N7KVH8tbC/vUu7S6CYF?=
 =?us-ascii?Q?WOoqmIYk4SD22b/26/L2XmZU24Gr8ONzG0mD2nu/zx9CXBV4UxN/ktAeOYSH?=
 =?us-ascii?Q?4AElqf2u9aIw8YonJh99JfOfJSq6DUc1bB2y0HpiMsrEb1s5CTXA2jvMXMfA?=
 =?us-ascii?Q?JkfC1TQq00FAzO6Tz5Z8Ny+ShKaI4t+wUj6fiGxq31L1hRaG8A6Qh0iSs5vF?=
 =?us-ascii?Q?p2BbUX0KHoS8qojt+O76Dz56ZXHC91TlEEGd4PAScmp0z+s/hLtQY9fUrkQp?=
 =?us-ascii?Q?iZ4lkWlotN6sF4yqb2iofg6PYJWMDAgDc3KV9rj4Ez0WOAy1/TqfG788k5sR?=
 =?us-ascii?Q?ClY9qkhDy/ks6n8yi5K4lgfeu2B1R/VW8EByI9HkWlQfd7atIRds19lo3rgq?=
 =?us-ascii?Q?Lmp2CUgj40XoOgLUO0BDSVZRxXyidv2HKoFnOb3IKqmYR0as3kxu15u79NSX?=
 =?us-ascii?Q?s1dKCyuR9OSLitk4nYXtM3V16J5BBqJX0yeHfMVvQKWuz5vSyJv0k98LlqWP?=
 =?us-ascii?Q?xZEUyDwpy0DpYJ0kOuTP5Rzrx91kwOes8nokv/57FjRxGhD62xlS2Mu64wjH?=
 =?us-ascii?Q?cesctVvHZuSY13l2brsFvQbyauIkg8IAKPBiLbeDDOSMSH8bfza7CWMKGeXf?=
 =?us-ascii?Q?nnljHalEZA3qxdx1Yv2+nkkMrCtlmyZoLFATkr7ywiMjscnCg0Uo+9WnhsGG?=
 =?us-ascii?Q?NL696y3uHWbm6oI47ByhKWMRBeSiPTtMT5roczPf6ErAGXOiDXBa2zKSgThD?=
 =?us-ascii?Q?p9pjKRL17Qy2XKBUPtN07hMx/hpjimPCyTezLNFluh5w5CEyenjNWaDTw7sa?=
 =?us-ascii?Q?uu3tz9fY5pA2KOQq/bRI0UPPj1ARuqVnCGi8DSjTGLgPIx374F/Tn7DX349a?=
 =?us-ascii?Q?sUBTt/gZZNNJeQ7Ko8s2T36J/yM4CEjY/uM2EExgecvY7YD6GoJEZBmRHUIx?=
 =?us-ascii?Q?6wncMLHVFAK4PtbV32VqakL8s4mDUy7dwDFP0KIEQJ12D1HHiVlPtgM9rjRl?=
 =?us-ascii?Q?q5TFrqgJyjE190KT0rAOU9HtVm4SGwD1J/6AFVUqW536Zusxk+Bb3xTXd65O?=
 =?us-ascii?Q?si2eK2mM0JPYUDgxct+J44/Ml6m4r4im7sCCG9IQdQpnvv3Te1vSLzrirISL?=
 =?us-ascii?Q?U1lBjl/r48PBiT31hdPhLTtJdtK3Y3WeuRGglkeN2hsE9ZLd6QCLtV8aHzR3?=
 =?us-ascii?Q?yUdwRZO0xwn69mcTII/KzzoxzfdZqAVc/FOfaqjjaF4WhOofYDRzEOXB0vqh?=
 =?us-ascii?Q?xki1bSv7pXJLS4qnBCqn1EEb2pwdrVVD1+AsxKrNOvBqM2170D2D6YYiIQua?=
 =?us-ascii?Q?gZ9VPQGntCWosRtPEBN24xHGC43QO+mZGd8hOnX1Vr8ar6/KG+1AmiTjVIBJ?=
 =?us-ascii?Q?CdZsObH15w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117f81fd-490c-4911-7fca-08df20757c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 11:08:28.0192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8GVqivYC298T1yHOfr3wXnyVB9uALHsbH4GSA2cz2idktjNr0GICt/ILRcs4WOG0GHx8iwpZiFeY4nDMXLVYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB425199
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
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
> From: Tushar Dave <tdave@nvidia.com>
> Sent: 22 September 2026 22:50
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; philmd@oss.qualcomm.com; zhao1.liu@intel.com;
> Yishai Hadas <yishaih@nvidia.com>; Alex Williamson
> <alwilliamson@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Shameer
> Kolothum Thodi <skolothumtho@nvidia.com>
> Subject: [PATCH 2/3] hw/pci: Expose ACS ctrl on Guest as configured by th=
e
> HYP
>=20
> From: Yishai Hadas <yishaih@nvidia.com>
>=20
> To support P2P on Guest we must expose to the guest OS the actual
> PCIe topology and configuration as set by the HYP.

Please use "host" or "hypervisor" instead of HYP
>=20
> Otherwise, the behavior is considered as un-defined.
>=20
> It might fail by SW or HW.
I think this is vague. Please spell out the failure.

>=20
> Extend both root port and downstream port to get acs ctrl bits that
> should match the HYP and use them in the guest.
>=20
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
>  hw/pci-bridge/pcie_root_port.c     | 10 ++++++++--
>  hw/pci-bridge/xio3130_downstream.c | 10 ++++++++--
>  hw/pci/pcie.c                      | 18 +++++++++++++++---
>  include/hw/pci/pcie.h              |  6 +++---
>  include/hw/pci/pcie_port.h         |  1 +
>  5 files changed, 35 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_por=
t.c
> index 7c3e78010b..3ae0b75146 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -46,6 +46,7 @@ static void rp_write_config(PCIDevice *d, uint32_t
> address,
>  static void rp_reset_hold(Object *obj, ResetType type)
>  {
>      PCIDevice *d =3D PCI_DEVICE(obj);
> +    PCIEPort *p =3D PCIE_PORT(d);
>      DeviceState *qdev =3D DEVICE(obj);
>=20
>      rp_aer_vector_update(d);
> @@ -53,7 +54,7 @@ static void rp_reset_hold(Object *obj, ResetType type)
>      pcie_cap_deverr_reset(d);
>      pcie_cap_slot_reset(d);
>      pcie_cap_arifwd_reset(d);
> -    pcie_acs_reset(d);
> +    pcie_acs_reset(d, p->acs_ctrl);
>      pcie_aer_root_reset(d);
>      pci_bridge_reset(qdev);
>      pci_bridge_disable_base_limit(d);
> @@ -118,11 +119,15 @@ static void rp_realize(PCIDevice *d, Error **errp)
>      rp_aer_vector_update(d);
>=20
>      if (rpc->acs_offset) {
> -        pcie_acs_init(d, rpc->acs_offset);
> +        rc =3D pcie_acs_init(d, rpc->acs_offset, p->acs_ctrl, errp);
> +        if (rc < 0) {
> +            goto err;
> +        }
>      }

If acs_offset is 0, there is no ACS capability and acs-ctrl is
silently ignored. Please report an error in that case.

>      return;
>=20
>  err:
> +    pcie_aer_exit(d);
>      pcie_chassis_del_slot(s);
>  err_pcie_cap:
>      pcie_cap_exit(d);
> @@ -151,6 +156,7 @@ static void rp_exit(PCIDevice *d)
>  static const Property rp_props[] =3D {
>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> +    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
>  };
>=20
>  static void rp_instance_post_init(Object *obj)
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-
> bridge/xio3130_downstream.c
> index 87ba30eb36..9829832c39 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -58,11 +58,12 @@ static void
> xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
>  static void xio3130_downstream_reset(DeviceState *qdev)
>  {
>      PCIDevice *d =3D PCI_DEVICE(qdev);
> +    PCIEPort *p =3D PCIE_PORT(d);
>=20
>      pcie_cap_deverr_reset(d);
>      pcie_cap_slot_reset(d);
>      pcie_cap_arifwd_reset(d);
> -    pcie_acs_reset(d);
> +    pcie_acs_reset(d, p->acs_ctrl);
>      pci_bridge_reset(qdev);
>  }
>=20
> @@ -115,12 +116,16 @@ static void xio3130_downstream_realize(PCIDevice
> *d, Error **errp)
>      }
>=20
>      if (d->cap_present & QEMU_PCIE_CAP_ACS) {
> -        pcie_acs_init(d, XIO3130_ACS_OFFSET);
> +        rc =3D pcie_acs_init(d, XIO3130_ACS_OFFSET, p->acs_ctrl, errp);

Same here, with x-pcie-acs=3Doff, acs-ctrl is silently ignored.

> +        if (rc < 0) {
> +            goto err;
> +        }
>      }
>=20
>      return;
>=20
>  err:
> +    pcie_aer_exit(d);
>      pcie_chassis_del_slot(s);
>  err_pcie_cap:
>      pcie_cap_exit(d);
> @@ -144,6 +149,7 @@ static void xio3130_downstream_exitfn(PCIDevice
> *d)
>  static const Property xio3130_downstream_props[] =3D {
>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> +    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
>  };
>=20
>  static const VMStateDescription vmstate_xio3130_downstream =3D {
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 42bcb9206d..c36f8c58c6 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1260,7 +1260,8 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset,
> bool aligned)
>  }
>=20
>  /* ACS (Access Control Services) */
> -void pcie_acs_init(PCIDevice *dev, uint16_t offset)
> +int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
> +                  Error **errp)
>  {
>      bool is_downstream =3D pci_is_express_downstream_port(dev);
>      uint16_t cap_bits =3D 0;
> @@ -1284,16 +1285,27 @@ void pcie_acs_init(PCIDevice *dev, uint16_t
> offset)
>           */
>          cap_bits =3D PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
>              PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT;
> +
> +        if (ctrl_bits & ~cap_bits) {
> +            error_setg(errp,
> +                       "Unsupported ACS capabilities 0x%hx were supplied=
. "
> +                       "Supported capabilities are 0x%hx",
> +                       ctrl_bits & ~cap_bits, cap_bits);

Nit: maybe "acs-ctrl 0x%hx has bits not supported by this port
(supported: 0x%hx)" is clearer.

Thanks,
Shameer


