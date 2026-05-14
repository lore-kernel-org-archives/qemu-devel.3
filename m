Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3CACD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 14:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNWqn-0004oH-PZ; Thu, 14 May 2026 10:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNWqj-0004nX-Iy; Thu, 14 May 2026 10:15:41 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNWqh-00024A-PZ; Thu, 14 May 2026 10:15:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsP2srp1kRbPsyccLqIzufRMpHTMhehYhIWHrh4WoiO3+YjCCwNSrEbytvUg8nRgA9Z3CZBd1Fo5ZBjU7jdC7K7cOHij8mubUatOTDUH1rse8hHOeuH3QfRunT7OUxxx6Xvnn3D4tAhuKHkiamisURn80Od3fBoD+pQBfFi096zpKLf1KMfKWfDCXds00jrAB/0EKx61CV4SxVJ/+v1NeS+4ym7WE6BhbYKJCLEvrfN4nTC+8WuMO1DNlbduxckWK8ks+DU9MG1pw6LKNopHNjXO/cjial7nth8LBLezeOMmBhspL4vFlgzrXlTWHe06cHuxAGI2+LkLXUeaoCX5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAsCXUnBefqjnhF7zUIYCdub/g8HdoQyxlu1Jdqz1Fw=;
 b=Na0XbjUiR6wN0aRck6rcC4e9a2YiHbisVD5AdoOSnxgIA35XH00DQKonMnVhNSSsS1W2/XzLA/W0/6Ppz0SmyQk18t+GQwqrZA0jD0UAoHhzYas/YlWbbyJqkv11t4zUaoNSeoUSzAv4pUsZRL29w65SbG483JuCg3++y5KEH3HUEMAnAGqWrBx4wMzgQjIMYimBuXOn1DxaPjbGZw4iI1cScY1C25fSpSDHFZm6zrY9LM8cf5fhVZjCmW3X5VnGREHd1oGncFsPJmerS2hplE6rZGcWycjf0ocbWbFmcQKyKtadudDSjs9/Gd+2JxW+EWjlfJTuW3kZH76DUYJzIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAsCXUnBefqjnhF7zUIYCdub/g8HdoQyxlu1Jdqz1Fw=;
 b=eBwX57xpvIj49liklDID5oL4ldnJI6A6l1XV9sqaN6DmYQ/0RyMFg7QjvYg7EHJ2+J3AQMao32wJF1ROtA0WpJZAg4TVQBjijQ03PJcDaOCO35rXIbPxRLbFICZwXRb7OjAhKHUE0DItl1Oo7Zv3v4NkD2P3gH8IhhM4IGrQsXtvfazNMF8thBrIaIE2aZMHcS1+6YzwviPu/uFOzIEOBuQWti3GL12jvdzzKwiJMdRoCw3j5bHpXFrHk7pRSA5b+BsDFpSo4fyq5wr3pgEDcKo5LQsje0ErAVABna1UIkIrKoqp/eMRRRmjx1wcWSbIgpBA9L5Px/FyqM9CMLxyuA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA4PR12MB9811.namprd12.prod.outlook.com (2603:10b6:208:54e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Thu, 14 May
 2026 14:15:29 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 14:15:29 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 3/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ril"
Thread-Topic: [PATCH v3 3/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ril"
Thread-Index: AQHc4kaJ1FE0fBMk10WF7SSfOSN4wrYNk4cw
Date: Thu, 14 May 2026 14:15:29 +0000
Message-ID: <CH3PR12MB75484359FE607CCCF96078FBAB072@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-4-nathanc@nvidia.com>
In-Reply-To: <20260512193520.3109172-4-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA4PR12MB9811:EE_
x-ms-office365-filtering-correlation-id: caee4a20-170b-496b-8cf0-08deb1c340b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003|11063799003|4143699003;
x-microsoft-antispam-message-info: VV+K6lcXfn0sNVVWjUPGzKuq+Gij3F26c3FlNRjaDpdPlEbgbOoEA+EaZqls67MgR5kNugqk/s1KdDFkcHquCK3As5CXN/dzhxpyCcGtxfXVXM15VURocXFSXahml/cBrqJMT1OEz0x8nSRGYjbMdyFV+A1IooeZ3KFDQyebOHcyDy0ulnEnT7bAWsX2RHHIQpjxIFYOEt7TNb4fuiQGzpLt5e9nYo0CoFTIHdDGnbpzG/tCzUPb97894J3Fw96dHXNf2rHxXfQbmqIyigd2l2G3f4YKoQhgiGn5qKSU+Dz/VDGj8/uX32EAuIW02COdxIhJxoSSbqSLj2MV9hhWJaXdQV/IAV+3hByMhfEbJA3pRm1p4iR5cWo/ws12qHGiFEOoQzf9KNgiVMeD9VksVXkUNfaK/EVMpP8ildx2/RcBzk9gbB7VpspiiGnWzFb0sjvN71L9ZgZTyfVveEndBCcGtFquk5SDQmqM776/0IoOzfDg35heDn+UG4Vg1oYTWBxNFMwctwT+BwNHY3y7O4ZOGCXA7wcHym29hHCgNjf149tGe2pCdQgb3Wra0UslQKPeAqjqsxIrlz5zqKmv8neqHb8DZKFv7jmx93IcNucVA/uqFryQZeag+oH/eRfNqPChu0botUwhDO101MchmOGpcYSOv3y3h2z91xkicOJ22jqiCzsJCqaE0MWFGsO9aDCsxxh/Wy25y0Kn+b5N7LlwdwXk4kgBiNH2fAnTyztZba91BQBowJsBZfUh8C/u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H6mupeFKewAD6Q5VyyJBePIaKR2p78eJZYpWVTFwxarGMseByXZnCElJ+f?=
 =?iso-8859-1?Q?K6vPnyBYNhgnZprw/78Cu6QvRydW6t4EDiL7n9wuNUv7iHZiJ8uhHP9JIU?=
 =?iso-8859-1?Q?V1P/yWB9c0tpf6BrzTyO24uKTottcJGNJu6jrI+c3myVj0a1KB5GFeugA4?=
 =?iso-8859-1?Q?JA56MGrS8hmMBbHSb06CQxB+Rgac/t4pklnfISz2kxH0HRykk4vkspfqar?=
 =?iso-8859-1?Q?f4mHSYJ6UeQYxsI0TMwxnG1d7HtLLrX2yCTbdKg15a5k+y0+qwf8bGcW0p?=
 =?iso-8859-1?Q?qCfX3G3k2mjH97saH02yHUyfRFp2rBF4AkjlCi/t7o7JO5XVS0VwyI1hvi?=
 =?iso-8859-1?Q?8DsS4YwGqrAf44jIo7c7tiA1QnSZlbyCNYA3zqqgqOL0adm2lOY5lqBwwT?=
 =?iso-8859-1?Q?2cmyGmJc6CBeSeM/Pe3eQUqCW4B4K7yb9tmPv2k/hrluT8jfoyeacZa8FK?=
 =?iso-8859-1?Q?t4eBwgq0lvGNSI6S9olHAttdH1wWO7T4/jqvLXoo3lfA/7xnMJw85FlKIl?=
 =?iso-8859-1?Q?aGXoAUMY/OSYuejGxSXyhvfQoyrWM+a6+MnMbjy/2kT0icjhE/TueGHNmP?=
 =?iso-8859-1?Q?2amLYAMM7pU/I6V2A8R2BnArc6uzPX9EAGEs7bTMZCOnM/V0kCms7UpYTj?=
 =?iso-8859-1?Q?sUz9D4m/ZUgW3TWY43yg8S8/fRG7kUf3JmcSMRAw3IEoYpPXAfPBmdx01M?=
 =?iso-8859-1?Q?+FYN6DcqeSGLSXOuA6qRxuywCpJ0U1GwVlh+0wdsfSBW7Fvol7RdF92Pid?=
 =?iso-8859-1?Q?sIFHsQEim8qa5uuiRlpnfyV+5xXweQgpgoUIKZMDioawPbr1/mrUQXCmJq?=
 =?iso-8859-1?Q?NKvxK1UityLGsC3xMAbAaN9jJoogsWY1BJ4GSB75ZxPANr++pA707EZN3S?=
 =?iso-8859-1?Q?NY9rI9p0pL1w30tPVPFc/ujJecYAjtXsLWEFQqXTQUoFHILuHW8j2BaZQ4?=
 =?iso-8859-1?Q?CmWM85SSSEpbVi0aY7K9GjPjcw2oKZuK17PJR3ZmSh+5Ag3/TSpsB+ztNI?=
 =?iso-8859-1?Q?6INP9wXbsC2YBbSGdsuZTfUBKCDowLphTtudgX9bP2AYeJTBrnv/H2wwWn?=
 =?iso-8859-1?Q?60kXvQsfbgsOXu0Mdmg8G+Z6a4zXhSskGvLRqtEYw6/MzX9gZTIU4CaA9d?=
 =?iso-8859-1?Q?L/ESJdBNSm7zNOYTSzDpsHR5djljdv7/116jlqArP2+WXdoQ/CKQIcckX8?=
 =?iso-8859-1?Q?ge3mHYOhTPMD03P+Okc8prv3KCcrR+jhdoiGX10nkCqA+W7gE6VlSYmFBo?=
 =?iso-8859-1?Q?78EAwOAypWRCLZd5SCU3MjeSP3YgGm/jrcldP2kHYVI93+w5fxDN/eBYpq?=
 =?iso-8859-1?Q?b6iw/cVCjy/6m8vUN/M3IT0F8kdHSymcnRdFXZDcbKZ84QqGlsSuyq/usb?=
 =?iso-8859-1?Q?j/JAx4wBQ581PJ8fWwPijfHedJ2zOsBkulPaihgrdBuEZ6TyHH1JUkg15s?=
 =?iso-8859-1?Q?gNqBH3GWIwpkU0/CtRBnAF2NnCX0zuienICkBsF0aJeXPOH3E1T6hAGNd2?=
 =?iso-8859-1?Q?JE47rgaY3gLl+w8S6nYMB71/Xe61jBlfQ/N9GpANgxwOrMP3YyW89hoIPL?=
 =?iso-8859-1?Q?z+RNvRYVt2itHiJH2ikh7Q/ElTXtr9IBcFKteujZiyNjxC1fTFJkAipIkG?=
 =?iso-8859-1?Q?M2TQpIMWdBptEKHLnT1WbcrUzmFbnBrwR0LoPH3O50mFgXsEl+GiYcVDJM?=
 =?iso-8859-1?Q?ryC/nUjN4Tpl4mP6gKM88CAZotkt1+6vp4wqr6ishg5/YI+Y1PuECRtHLF?=
 =?iso-8859-1?Q?FvscgZFgjiG4+bxGvaAXaoZa0Q+ML/H5rKJp+jhHJqrkZnyO3w0cyB7c2G?=
 =?iso-8859-1?Q?qn+1OqNpxw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caee4a20-170b-496b-8cf0-08deb1c340b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 14:15:29.4695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loqSq7qGewzS7EBlVX62oLjU/pql03rzM4ut7y89A2a+eMR2tem79Fp3ljLcMUT5ii+AlmryMX8Pcbu27/Gm4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9811
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 12 May 2026 20:35
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
> Zhao Liu <zhao1.liu@intel.com>; Matt Ochs <mochs@nvidia.com>; Nicolin
> Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH v3 3/7] hw/arm/smmuv3-accel: Implement "auto" value for
> "ril"
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Allow accelerated SMMUv3 Range Invalidation support property to be
> derived from host IOMMU capabilities. Derive host values using
> IOMMU_GET_HW_INFO, retrieving RIL capability from IDR3.
>=20
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer


