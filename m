Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AAACA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCbcA-0003mU-13; Fri, 02 Oct 2026 07:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xCbc6-0003mG-7A
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:39:43 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xCbc4-0005F3-H5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:39:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWLr1byZyivXyTq7vLzeOlhgWJHPUSFFTKIK1bGL+LlnW3YIKUe3rUgPy66U6cT4QXVdZJdJF6uCKQn+Y2BrBi1YB4wr0JshRxVpbTyyw1EBKc1Fvshsi0xc9Pgvu0nuSwx7D/byU+qvI41evfRXMtwBqZhazMcpByHNZK07vfyCpKjea5LCYbnatoU2NVjOu8LK5CV260nMxX7RV2aO5xuvw+fxTSwxsipZsRAFVg+nXxMviBKN8QpgZaLDZuGxE5afNUMF9iHdXK+HWcks/Zr3zWaynmrUOviAfgnm+h0neGN9An/mfmn959MVlk8b63DB/QYd7pZ8EQzrmNNHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6RyGH6Elbic1YB1TTBI6lHCZfIq1lq4OY06pmRP7xU=;
 b=HHxTFp7HsjeTvjzJ2enag4A67u2azRyeCMj5o50h6llCYbodCPmWynPef08J1V2ia1vKDoLumU//ZQswwBHQnNYX2ZyFP+5m3XSkpc2Avaofc839mAIq8Qaqfe51PvwDkWWvBHj6AKCjzAbijZj+s31gvewTK46IrEDGfqIMJZE5cJpY2aRxNZEteLMdKPOgbjBA3ey3NlPQyOm2seS8Cqhpb4hvt4FH5rFIRfr2lC6X7jXPOhiVCwFS8oNHXblbRQs10qH3k/LS8gdSWBX18vYY+2rgnrtUWw1RKFK9p+VhODTzUE/ygLRDRht2Q0ZW2KpGNSHRs7MU1/dHKxjXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6RyGH6Elbic1YB1TTBI6lHCZfIq1lq4OY06pmRP7xU=;
 b=JpqYH70/h3m6EJuNfH1a9Uf7Xv00vUlHRAnUTr0XJQxomc1iyqqCl+G5q1UBAumOhVPauvOKKnG+3F5t2WL1XPLl+9zFmTkIVXFaKVvmsqyYQVwpCZoCDpZqivM9jeCSNTjZfmjiTT63j3BincKHUmSQLk1LK0WLwjauN0bLSNsh/xTLukoS8WzLgtCjrH07AowxrzmiTp0v7Ij8gD4fy6FjnZTa/gtvulqjuy7ootYAnZGhITwULzKpsfu/+mWatEsImkXOsu0bswN1Q+dAXwmes7OFuRAwpwqeN2e4n8+f2QwAmGZ09zFC0pJDHSR8YrDECvwzZT7jD54fJhxzQg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Fri, 2 Oct
 2026 11:39:33 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:39:33 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, Alex Williamson <alwilliamson@nvidia.com>, 
 Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH 3/3] hw/pci: Make ACS Control read-only to guests
Thread-Topic: [PATCH 3/3] hw/pci: Make ACS Control read-only to guests
Thread-Index: AQHdStxg1uTtqBIumkO9UBfQ95aEyLbqLQXg
Date: Fri, 2 Oct 2026 11:39:33 +0000
Message-ID: <SJ0PR12MB8614D569CAE33978A81C8884AB892@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260922215008.2554402-1-tdave@nvidia.com>
 <20260922215008.2554402-4-tdave@nvidia.com>
In-Reply-To: <20260922215008.2554402-4-tdave@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|MW4PR12MB6899:EE_
x-ms-office365-filtering-correlation-id: adb4c627-2f9e-491a-d71c-08df2079d424
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|4143699003|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: F/i72KH4QcMU3lpKdJVGzUoUBjFW9zx9vnlwkB2L/JLc67HohJAXlXt0hOI6EfIvCJnf7mHmkBTd0uZLlhQSVHFE6ABKlDSxCzxtX/Nty+IgB+v+zV2lp8VW8/ALTBKNESUtB8jqEp7wATttCOsf45vHjSta4gP50uAbM9+xtmLQaFDR+/v1gkCjzxdJL6aMjhDfQxkVTBG0Jy0buE7EBhHB7RC1tOuYoLPA/h9gmRlL3ylYIeQJWFtvZpqHYxOTVA2pT4nb/NVFQew1sVk9uDycj1gk66kmSXAXdZWuTIEmU2jcw/qcATgNOqephg/zEE8KukZ21TH8q7LQ8vEZWqraxwM/O7E3y1VUOLMTLdyCDaO3Whq7NqlL1f8sDsDSFiClNQB0GLNOwVmz9Z8HyqHYrrAlPG9Uvw0HWEnnsMGzXdUPj11EI8ZeqbD23NRs7wNOvVAUmJ+COwsyXRONVzlv7pPkLz3koWiEU3+dmsi+LmvfaTSUDX1lUCy9xzXnXNAU3QKSagY65BfTlxAIcMJ8APZEv6MMMH7jTUwmTHng5NQdVmbt2qaW7lFliwQlxijMmP61dMuMR44XbFfP3PrND6/MUA6+w8rJkrTI57v3TYjmoHyyzBhF39iO2jsXC9iDz/0xkdyPiAleHYLtOL+FG8S4yFN2/59wm7tzjo486KKc3DDzwBrifuFYQz8EHEFOBo8zMHbgyhcDNV+bfpCWRxzt+Lc1kxdjT2OY0Zk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(4143699003)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7SR/uVzNViW9XKWU4ytSs+KaPFJcJakIurF/LsYy5iM5T81n9eDYDy/m95PC?=
 =?us-ascii?Q?KI78tzXCv2Q3LKhLehLiCmpfJqyrgw0tAh9/uy/CnArKbXt4JhKSqBYPS3aV?=
 =?us-ascii?Q?C2f95iwXVa74Qz6QwBtFLdAzkHGpmVhbmZOdcfXiccsq03XtRb2c/y40j96r?=
 =?us-ascii?Q?dHAzaA8l/kOq+f17YSiXB8BCFUqWoj9bVU/HZadA82rPCCtHPHms8IfDz2r9?=
 =?us-ascii?Q?wMjS1rTJ15eNt7umgjmvDu/jru239VlBgQacFjNXrzUlL3U36wvghkiHRYjN?=
 =?us-ascii?Q?jWFw2UaMSIqvxyFEZimBVTbtc05edHuvaB8afe8CGEnjSKyAuiQZfhk9SM+z?=
 =?us-ascii?Q?ttC1M+Y3L2MVmF6FQ6DTi3DZoe35B03H30Wua0yS9whdIyOMWiNd5FmS8zSB?=
 =?us-ascii?Q?k89SjsDmkLLxnG6V18LDyZXWCVJ6kDJyngK8p5yEp9BBmxEZdoxJiVqKk+nr?=
 =?us-ascii?Q?AFmTl90iujURckROxkrhJTTwNYaEjDpuvo57qrr+f6yOg9ouia7jUc+TOwl9?=
 =?us-ascii?Q?PGMS8IMCPZv+RsjB5HHp/24Qlv1a55xaPdAdd46XQmrYqHyv0gv7h8COAhXT?=
 =?us-ascii?Q?lBHhvewnmwLVTgjNklc1KqXR9ZhP8GD2AdCVqk6GIcjXsDOGLufYXgBTZPO9?=
 =?us-ascii?Q?1O5+ZI8MsWCyX6oMcpRq9kjuy6i5hFRYTZBNo8Q/vSoUdLqz6/PNKJAlUgFp?=
 =?us-ascii?Q?FOKpMK4qJnfIxt0cPu/tGfMEUWEdId+ODqOt5CHlHA1Ssq+86US4c1uUO51x?=
 =?us-ascii?Q?OYrxAEFKdaCcbnMn+KgrZgz/sfhAevftSTLbdMBSXDPQG+eRGvD2/STHgEe5?=
 =?us-ascii?Q?SMrR5BYAoEFL4lN3ZIs3oFSky4scAqqJpjR5Euajo7MtX5xVkpO/jJ+UKH+B?=
 =?us-ascii?Q?8QZcDzGLgbU/Vju2o1iWHwdStLcIdTP9sLwxPfUtJArmWmOoUG/YM5QJx3mK?=
 =?us-ascii?Q?/ealkL+Dx0PrJD/+yQ0B0BRw4UF3dtzhpTzAAK9p0bk/E/o65vglTI3YXYwT?=
 =?us-ascii?Q?U31OeZfCyUCjFr8XWITS0kfQNShoqHKOb0SeBtJM11Rx44Q4u2+qSHelVtqN?=
 =?us-ascii?Q?sk3wk1W/LdtWe/c6l2SnZD5OdNRNw9iMrpoK46tAMvkYxGmhB34YI5pCBwLI?=
 =?us-ascii?Q?UXVNH8OtueFI8QSXFJ7i2z9oMq0G3fdExmEBMTerrcbp7SHI4/3PeA9TN9vU?=
 =?us-ascii?Q?twuoEKk9RJk5yH9QlVpeZ1nj+qp9r19nNazSdP7YphH5HwUWdpJf/Yy6DP5p?=
 =?us-ascii?Q?Vy2nZNebqlXgO/xNdKrtkXos1qRJB5VGpGfVyNLORoCY9N0NaGjTtWkts6vR?=
 =?us-ascii?Q?YT75oSqvnNunfkPIhKk0jiYXqBz/AjQ+CZ+Oy7Q3mN11/hm2Vvc62Dw2/2dt?=
 =?us-ascii?Q?z0re4Mi4+VdD3YF6LFUJyqbJB93FVHR7/aa1tRdX4xHqxuiSUf+OGTwxL4CL?=
 =?us-ascii?Q?CT7mtuanPS53N8XQm63520vgRKjUPJmEMP9Os2mrFxyG4eu5IdtGBL6cUpEu?=
 =?us-ascii?Q?+9GoQPsMYRE/IUfIgOlY7P9eK9U7Ji1de/H98L1EhIdEepaWshhd3JGtCYHg?=
 =?us-ascii?Q?BlTCsOWKen/UVVUwqGsvWNIsTwrMwq/Bca0m+nCLXStkT1/hEPgQkDhEpk7F?=
 =?us-ascii?Q?jlLadEIWqh+F0xLtMPJK+pq2mSwhIUEtmg/eUfWxuGa8+cJw6E34PCzEE/ti?=
 =?us-ascii?Q?Zx13py1WJkpus6dSzHMHie6472ZXKA42YrSMR/H+Osd/NUQ7+kfO2b87tpf2?=
 =?us-ascii?Q?ORf25OXxxg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb4c627-2f9e-491a-d71c-08df2079d424
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 11:39:33.1149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Y0QcBampT8GPR78OgR+DWKruxLFGVBz7CQxp3iwvHdy6pkBS0f4+DXM03XMnkukYUbPZ14XKbRQ0mdpFGFRiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
> Subject: [PATCH 3/3] hw/pci: Make ACS Control read-only to guests
>=20
> GPUDirect RDMA using data-direct requires a specific ACS configuration
> on PCIe Root Ports and Downstream Ports.
>=20
> While ACS can be configured via QEMU's 'acs-ctrl' property, the guest
> kernel may overwrite ACS during standard programming.
>=20
> This change blocks all guest writes to the PCIe ACS Control register and
> preserves QEMU-provided ACS settings across device resets on PCIe Root
> Ports
> and Downstream Ports.
>=20
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
>  hw/pci-bridge/pcie_root_port.c     |  3 +-
>  hw/pci-bridge/xio3130_downstream.c |  3 +-
>  hw/pci/pcie.c                      | 45 ++++++++++++++++++++++++++++--
>  include/hw/pci/pcie.h              |  3 ++
>  include/hw/pci/pcie_port.h         |  1 +
>  5 files changed, 51 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_por=
t.c
> index 3ae0b75146..784697b1ca 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -156,7 +156,8 @@ static void rp_exit(PCIDevice *d)
>  static const Property rp_props[] =3D {
>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> -    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
> +    DEFINE_PROP_UNSIGNED_NODEFAULT("acs-ctrl", PCIEPort, acs_ctrl,
> +                                   qdev_prop_acs_ctrl, uint16_t),
>  };
>=20
>  static void rp_instance_post_init(Object *obj)
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-
> bridge/xio3130_downstream.c
> index 9829832c39..e8717be73a 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -149,7 +149,8 @@ static void xio3130_downstream_exitfn(PCIDevice
> *d)
>  static const Property xio3130_downstream_props[] =3D {
>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> -    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
> +    DEFINE_PROP_UNSIGNED_NODEFAULT("acs-ctrl", PCIEPort, acs_ctrl,
> +                                   qdev_prop_acs_ctrl, uint16_t),
>  };
>=20
>  static const VMStateDescription vmstate_xio3130_downstream =3D {
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index c36f8c58c6..08e21022e5 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1265,6 +1265,8 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset,
> uint16_t ctrl_bits,
>  {
>      bool is_downstream =3D pci_is_express_downstream_port(dev);
>      uint16_t cap_bits =3D 0;
> +    PCIEPort *p =3D PCIE_PORT(dev);

This is a common helper. PCIE_PORT() will fail if a non-port dev is passed.

> +    bool configured =3D p->acs_ctrl_configured;
>=20
>      /* For endpoints, only multifunction devs may have an ACS capability=
: */
>      assert(is_downstream ||
> @@ -1286,7 +1288,7 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset,
> uint16_t ctrl_bits,
>          cap_bits =3D PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
>              PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT;
>=20
> -        if (ctrl_bits & ~cap_bits) {
> +        if (configured && (ctrl_bits & ~cap_bits)) {
>              error_setg(errp,
>                         "Unsupported ACS capabilities 0x%hx were supplied=
. "
>                         "Supported capabilities are 0x%hx",
> @@ -1296,7 +1298,17 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset,
> uint16_t ctrl_bits,
>      }
>=20
>      pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
> -    pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
> +
> +    if (is_downstream && configured) {
> +        /*
> +         * Block guest writes to ACS Control entirely to preserve QEMU
> +         * ACS settings
> +         */
> +        pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, 0);
> +    } else {
> +        pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
> +    }
> +
>      pci_set_word(dev->config + offset + PCI_ACS_CTRL, ctrl_bits);
>=20
>      return 0;
> @@ -1309,6 +1321,35 @@ void pcie_acs_reset(PCIDevice *dev, uint16_t val)
>      }
>  }
>=20
> +static void set_acs_ctrl(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    PCIEPort *p =3D PCIE_PORT(obj);
> +    const Property *prop =3D opaque;
> +    uint16_t *ptr =3D object_field_prop_ptr(obj, prop);
> +
> +    if (!visit_type_uint16(v, name, ptr, errp)) {
> +        return;
> +    }
> +    p->acs_ctrl_configured =3D true;
> +}
> +
> +static void get_acs_ctrl(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    const Property *prop =3D opaque;
> +    uint16_t *ptr =3D object_field_prop_ptr(obj, prop);
> +
> +    visit_type_uint16(v, name, ptr, errp);
> +}
> +
> +const PropertyInfo qdev_prop_acs_ctrl =3D {
> +    .type =3D "uint16",
> +    .description =3D "PCIe ACS ctrl configuration (unset =3D not configu=
red)",

Please also say here that setting this, even to 0, makes ACS Control
read only to the guest.

Thanks,
Shameer


