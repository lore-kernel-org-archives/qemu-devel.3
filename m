Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20D4C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx58T-0007Ir-FK; Thu, 20 Aug 2026 11:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wx58S-0007Hv-7L; Thu, 20 Aug 2026 11:56:56 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wx58Q-0000l7-LO; Thu, 20 Aug 2026 11:56:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRGfFPu34PaVtWG5lKt37z7Xl09mR/3qis7xA11gddmdKHv2TElhMW+T5WackVDSVhweh7TclU0rvHZowZUFBpzxLbfY/7aZt6LILm0arU/HftJPr6ezoWPOdL0VE91uS/W1qKu7wYz7mAnAnvGgLN7DjTAvGkHw72IxCuugo007VRLQVQo3hdNW2gkkiKcyWWxXWc0Jhpiv1mgXEKZouw7bX5cdx9io0E/JaB8kyQtiAJKJkot91pwiueFwhZWSKwdHy7vrX8gWqaMzOctdrMd0HlE4e6y09kTpRCKP6/ud0EKQW9vawmxvT7Il/dwdpGiVgMggLzNarGzDCjhgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhUjHvNBw7XuFo1HXQr5yASSliUsXOQal37t6tHU7Z8=;
 b=R/sgA3GQonep/Iy1yyD4IgcjyccFB+ugXlQOIjiV1CvXfD/WcXJgqHqQJV90rEUo2vWB7C81l1HeNerAkmQ+W4RrQEgYkHOWKv8yb4Bet7gpjOqbvo1dlX+Hu1AGtyuXoJAKmLOgdC58ra5xmUhsjIdRy/PEKWysIXVYM0emYuWnQdhuZeobjhqfI2zXretA4WybfbFN1ak4FcvFqisBoFefm1bBIkHc6BWYZ6Ue3m6wqqGhhJHNdCXDU7RyRCmLF6OZENrNjZHfHwmNARsDk7ucbuSMsC0HXTAn07d6iB1Pr6+bkmcDQM6U7OK9NQRXJ1BwTssygdr+27LYkVYdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhUjHvNBw7XuFo1HXQr5yASSliUsXOQal37t6tHU7Z8=;
 b=scG2E3TFb4fJx+v0hPvRgYdsIQhizwH8zY2gPUFEnvPClYkX91VbknZg5F/W16bGtCsLHWSruuMcTZHHC6sh8Rlg/Uz4B2kNGp9CNCIlFZ6BMqOdFBF1QgSL1G5VRxXt/vYpYQoAeL5tySr7uAExsG8iRb/xp/2JtA+VRxpspE9tSGGDk/nQFfFe1xVUe4gDKkBsohp2H/4NXMa8gDlmOTW8twIzG/2ABsq3vFuZNC9U7M1qdtLkxoPCnvu1LFYohSFPzmygQBWQkuxmBkTdzMKtwaLa+CX+BBHcr4qMHiQK/BX+CnCbg3v6P3KgezB5BIXKOycHmO6WW2/bOfHIug==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 15:56:46 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 15:56:46 +0000
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
Subject: RE: [PATCH 10/10] hw/pci-host: Emit a _DSM on pxb-cxl to preserve
 firmware PCI config
Thread-Topic: [PATCH 10/10] hw/pci-host: Emit a _DSM on pxb-cxl to preserve
 firmware PCI config
Thread-Index: AQHdKyTPnJ4dcxYKe0O9UM7UCuLZJ7ajmH+AgAOJRbA=
Date: Thu, 20 Aug 2026 15:56:46 +0000
Message-ID: <IA1PR12MB903014202793F105A1C3A5D5BDA42@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813130623.2499506-11-mhonap@nvidia.com>
 <20260818095318.252248-1-junjie.cao@intel.com>
In-Reply-To: <20260818095318.252248-1-junjie.cao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8755:EE_
x-ms-office365-filtering-correlation-id: 9951d650-d0b5-4727-fcd4-08defed3a341
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|22082099003|18002099003|38070700021|5023799004|11063799006|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: TpvxZusZ2QS4iPCYvVuIWIrBDaiMLhjjjjRVoz+oWBz2nSQ7WRI4Ol7wIGfc9cGhVlTYA5CL1CB0iDMKmuj6JUYDF7WNryCmRiTaz6nHRUnu5szzqlQjsM2dGtq41v30JLdJ75uTdlPWC51cOqWpl1Q6I9517E4N8+MXejtu9cCteVzOt0kIwCKouDJeFCdUAbotIsEEaOztOFvUZU3rPzsw3Jajk1fqs5yz8oVx0HWLPNKgKv25GPgd95nHWCHSjfib9K8FewGs6luQVotne10iEH2yvjI8OE6R3/ItJVgJAxFVJQhWQyU6TGHUxx1wJCMtf5Ku1sbzkETuwq+bUhsGf2KGxvyy/uYyRs5yPmBhYLbiCXMhRuxXgF3V05uoxdlmvkoNyiI5Djawv8rDw95mTZPc399d3ixO7m/D+aIXk2jarLF2HyTlq5DZmXN57YB+hadjaNodfQcJaReDBNqOUvJ/SG5jZhlaj3jTxcUDOcDWVGfeP7guhQyoKkkb78hJJJ5xyCFnp3vjKzTRUnhiwKXEaYzkZLHDJtuVTTQ63DFESSvuY1ZGAZmEDZa8hUMBRJJjmk9o2+RpMJWjOsbZPDkta/z66dW38QEZjUaprxpNYIYigKJTipkR+7RKtTgHHXh3vtfi2Gudk4T7vHvwsd2fSWGPch04hT/EUWKGw2oR5sivatwVC8Ltxzk47snbyeZJP8X8ab2tx1JXd/BmJex1RNJf2YDexQW7IFo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9030.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(5023799004)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?abScFNXEs3qqLVhQ6i51CgIIxXwDJun5jirunoXPb5yL9zFYA59vyPiSHlgV?=
 =?us-ascii?Q?2jsyIAlS9C8zuzmVdMquUzIP4h0fQ85Tr24S2+M2iXQtxavi5jiNPl9rnlPa?=
 =?us-ascii?Q?++BKmN2qzabO1Wg6I4bcsWfyHbpjET3SUtZcYfQYikgxmdZADtKBwdns9sK1?=
 =?us-ascii?Q?re5PNkeQCm0mWw04CCBHrZfi9eeVwbvY8itZVf/iPaFTu9sD9UBR6OJ2fEjX?=
 =?us-ascii?Q?S4DImVLvYuORUrE2GkrJAcqffHlZDewvZI7tjuCa3wsPbSK1sQlduEdIqCGe?=
 =?us-ascii?Q?0Kr1IOR6PjjEPF20XZg+QMtgt0pOR/4F3kZcvQxTVqKVAA3wkSVqEe4S0YEM?=
 =?us-ascii?Q?YDJwQDhpM6IpQOLW++WEz303M+n+/9FOiuBpFy5oz+mjJoiq/hL/AXz8IDmP?=
 =?us-ascii?Q?Uc3iBMumEXFNIh3isf09A8YaNwRcyOhrkffL5TxuQRfudpFlzw5r7tbE3h69?=
 =?us-ascii?Q?oGPd5UblbDZBgF3kudzcyCGQgN9Sk7dOXVR2G1SV+U8mkZx33uBinpencOSv?=
 =?us-ascii?Q?GpA9uIjku07eBn+D3hgAttE37k4Z/Kxs5unqJEjEvXeb8iEU/fItAE/lQoym?=
 =?us-ascii?Q?/IBX9CLFnejk5MFhkyA9n9zxC4zAhj4UB3P1f8VXl0mYUeLQC4vAm2FF4ds3?=
 =?us-ascii?Q?iskkw/8w5HaCTC1HxmWqdPCZ3AlBwjR8p7yTYzzeq5NET2sfNsS6xymVhbxi?=
 =?us-ascii?Q?h5b66TpWf8tFh889vBmlwnEdDJ9ms/0VTuUrJZRlj24v6Qbyc3qBeIDT7eMi?=
 =?us-ascii?Q?xs8gQymC2e17+GOsT4bjrP4zCzXj8j6hvvR/epSyIjr9JKDwHYYF7/F6ebG7?=
 =?us-ascii?Q?SjelXBj8rJIyCb2VZ1UoUtMHa3KHG1jVZn+LowIx1DjmryzXPcg7lMH79smQ?=
 =?us-ascii?Q?sbzObK6Fr/WLH7I+4UPnFZ5ecSX3fFiMARSHi16cQvZzEwe54KqNpQ8B9vQs?=
 =?us-ascii?Q?63QCKQY3CoZSgjpMWuV6WCnNzytwC5oeulRHPDmadXvjr1nONwJkraJp8j4f?=
 =?us-ascii?Q?dx4ORBPdHztikYTwVTOYY+CvTZDkB+AwlBFJ6eU6ST2LQ08JDBlTBQzGdq06?=
 =?us-ascii?Q?QGboaf40h+DLjXKCGS3ul4pdsIrPSVoPoV0vuNMIM50EoVLKcRTkiJzC3UH9?=
 =?us-ascii?Q?CUeW6i/TtatJK53Ts2QKR40eUTFGmIZZ5Xk6aADDFktE7r1v7fSZcvla0RwL?=
 =?us-ascii?Q?b3fJ7XYULcQOxZBq2aEP+xHVGzajNPCVIFE+pR6VY0/lfm9bh76IOysJV5N1?=
 =?us-ascii?Q?VUrWvslbRVq1g2ihbcpL++/dEjVA90qapoLi3GtMbhDa8qb5Zy+OzC8DWgTq?=
 =?us-ascii?Q?jpoWx6gVyuJjtN2fkPFdRYMperzYWbDJWGm3hIFVIMZjYNU1KsAnnF9bhill?=
 =?us-ascii?Q?yG/HiixeZKlcOpvUKYdAKRUNctW9GNtZd/vlOH8phawVJyIi7K8RXniHruec?=
 =?us-ascii?Q?XjvxSQed2C397eeMQksDpq2V+GhzohyZQPOk5SPrOhL1rx4PULt6Rw4CHq5b?=
 =?us-ascii?Q?JbnAcFqcYgOhqzh1a37zZDOt/u3v94xx3ePpSCY/cGAYVCgmMrZs5VQmwf4t?=
 =?us-ascii?Q?wfKJHtHoM8Fxr5dpM2XWH7pn2/m6fwDRJuiVXhBHgnw4MEATLnC3Ospj9hrN?=
 =?us-ascii?Q?IdcnXHiB768LrMQyTkx5As+TexPhfdsPHrTi//1g/2Buz/39c1AGroBylKMv?=
 =?us-ascii?Q?vdBu2Ul7Q+5vrnnv3bMAu138BsF07iG+gAkJtOsvDYCxC+8B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9951d650-d0b5-4727-fcd4-08defed3a341
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 15:56:46.3617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IurZrJAweTa8YR4iOUzrGOH9UBp3e3+YeBZcdKzbAwnN66Ccxxb+I5mGZ9baffyEea4t6t+Vpal1VwI9ibMc3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=mhonap@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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
> From: Junjie Cao <junjie.cao@intel.com>
> Sent: 18 August 2026 15:23
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
> Subject: Re: [PATCH 10/10] hw/pci-host: Emit a _DSM on pxb-cxl to
> preserve firmware PCI config
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Hi Manish,
>=20
> On Thu, 13 Aug 2026 18:36:23 +0530, Manish Honap wrote:
> > -void build_cxl_osc_method(Aml *dev)
> > +void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool
> > +preserve_config)
> >  {
> >      aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> >      aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
> >      aml_append(dev, aml_name_decl("SUPC", aml_int(0)));
> >      aml_append(dev, aml_name_decl("CTRC", aml_int(0)));
> >      aml_append(dev, __build_cxl_osc_method());
> > +    aml_append(dev,
> > + build_pci_host_bridge_dsm_method(preserve_config));
>=20
> This is the bios-tables refresh the cover lists as pending:
> /x86_64/acpi/q35/cxl and /x86_64/acpi/q35/acpihmat-genericx both hit the
> all_tables_match assertion with a DSDT mismatch, and the asl diff is
> exactly this _DSM under the pxb-cxl device (12638 -> 12684 bytes on the
> acpihmat-generic-x variant). The g_assert aborts the test binary, so a
> full run only reports the first case.
>=20
> With preserve_config=3Dfalse the method advertises no functions and
> returns a zero buffer for every function, so the x86 half of the change
> is dead AML plus golden-table churn. Append the _DSM only when
> preserve_config is set: the x86 tables stay untouched and the pending
> refresh drops out. Otherwise the usual three-patch bios-tables update
> needs to ride in this series.
>=20
> aarch64/virt has no CXL golden files, so nothing catches the arm side
> either way.

Agreed, I will append the _DSM only when preserve_config is set.

>=20
> Many thanks,
> Junjie

