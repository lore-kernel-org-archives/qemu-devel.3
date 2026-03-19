Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1C4108E1CD
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3AQ5-0003dA-7F; Thu, 19 Mar 2026 06:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w3AQ2-0003cU-ST; Thu, 19 Mar 2026 06:15:58 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w3AQ0-00004s-GS; Thu, 19 Mar 2026 06:15:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTlmnuIzbdRER6QG96j/mtgBKAf1rDMsu+mMVSIDowU+9v37RnjraS4J66PTiaRHq/8fGmC+kSiZt66sycQFlgATol/u70bTN8zDYjyLrHV5RqtUXuCyyZqL5RiIGeOFuWIyFvkVQRG//IuNAM8nyvGkyJLjqWwxX+bEAEizUy361AOaGoWxoTXwe8HKEsr5H4mkIWXrNDAyxouqdR69hiPFPLtR/0euzs8kclYwUla9C8yi1VN48805R0w21WBhJ+QC5l2063Vt65J4lQ58M/g4/HnnckYJRJ7j8TY7i3d/caBfh+oItgz5/WQD0xj+Br7d6EK+5YZRTQPymb538Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv4V/JFDDtRu94U5xUiJYexKb+QgJRdDP25C6IFE39E=;
 b=bOR5SV2OrLQPgaK4pw+ahQcHewtAi3ivvFUsxg8kLaez0uaArAMNEAzNfmJBO10mP+illzEGQ9yhqCvGtphE4N5cyi5Gh8XKIU+zRUOxZ5ovByPOI6H0PVRaIFni6uTF4oXSfHVjhvqssEL24rWd5A76DaHJFK+LCsWgVBHAzW+51IdMafmQj+vAwKwt3Keai7tSHYoxZXiR4oLzdL/fHmDMQn9A+cejg3ZukFS4mhjZ7KAN9E/ER2Z3h/Ir4w3CriBTjYyll1jURVjSMd1ik5uoEtYIw1KVLfAlFHrNwcNTby9gd0qgw7IzhA0raWa0cPkwg6R1lMLJvDI1VCn9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv4V/JFDDtRu94U5xUiJYexKb+QgJRdDP25C6IFE39E=;
 b=nhv2qrha4YK/J/Fbfhsb4Hct0Aeje8IuVl9WdpiPPDeASHABWE7Y7mjvhmT28IjfxFIjZLvZiNNF8V1dfDYrsC959rcsticG1Rh5TVO35hDcBD3UzLe8UZpHq/LPStTxojAZHnvX+d9Pbwlz4AOVaSRuQFyvc6odn3u/DCSsfsvKX4yo3Ko0uqsR3qySslXA4nm/7j7Zlm1sI1nfEy4+LY9/LHiZl/HxgeK1H42FtKQ92iyhd0dLkQybcL2oRoHYBaUY/JEJTwUp5pbBDAqXGYrDDgt6KbirOn5AcevFO50xhT/9la56iQIQgGw9qcQ5J5hnqiin0UYDpf/atfNLUg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 10:15:50 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 10:15:50 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH for-11.0 v4 0/8] hw/arm/smmuv3-accel: Support AUTO
 properties
Thread-Topic: [PATCH for-11.0 v4 0/8] hw/arm/smmuv3-accel: Support AUTO
 properties
Thread-Index: AQHctwfwwEZ79v1Py0KEY8JXNyLLK7W1pCyw
Date: Thu, 19 Mar 2026 10:15:50 +0000
Message-ID: <CH3PR12MB75489FA5FFFA75B7588BD9A8AB4FA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
In-Reply-To: <20260318184907.4060030-1-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY8PR12MB7220:EE_
x-ms-office365-filtering-correlation-id: 53784b8e-61e1-4561-79bd-08de85a07ef0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|56012099003|22082099003|7053199007;
x-microsoft-antispam-message-info: XTo6wGPGnuiM0J0uzcX1eNdmLp2ixQhnsI08C7ya+iVKIyc/gL+ef3XTU0DNYo95mLMC2QNoH8DHWzeW4vAc0aY41cYlEi7msLOP6OSUVARxOjaZguiqWb6r4DosAK9bTny//L4GV/FGU3OtGMja5+aE415N7pG65dIzjAwUviKF2ib6WYhVm25cWs9O33sk5w7mOISwZ+xQx/P+sAIOfDCIC2+wJiOMjhkUcnC1e3CUhF9LzYd9pWHjJ1RpikON/BFUzElqD0jKFlrGQHGDAsqUNFB+335ax3D/uOlV7xcLlXzLPYAxh/Bn+GuhB4WYPVUVS/jjzV8yHyX5Lc3j38uVzn9G68iMe9YbXCMt78QxFpL1DerGhQpJ5n5JPxXynwB0NLTCvkWTal9zUldr4OnrgXkn79WRbqjvZ26nSDlvbpJDligAVkvzlvUldIGFFhs5JGJVDjHZyTJtcLd12DUljr2jZC8uQCJ/IVhIcuyFljXGjwXFh9qokew4tfiqR6Z9zhuMgqfz+T0VNtGZ3JbQb6kZlGZ7zrLPcl6O3nC83BNRCaITvKxZuHvaZl90nG8NTfVHv5i7hcjfzXNpdk+znC10htorLQhMMLaeyTsnYPCNUA0PFLNHeh7pE5NV3tAMgHtlv8TthOrHRksftCjkAlMV+1F8gfgdlt73mo+qM0A3mrIfETLJzetIwvrB+WNYdKW99rt9rzlXVzhq0w7EiOPKhPcHTp6+3d8d2TNJEFeYWo+upGObhp/DLSoHoLnTrjW1K98DSOLvQ07urV0MCZQ2JEEj1HV9fQPxCbo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?++ueTJHD7iC48Vpp44P3hgsgXIMsEQ4tdLGJpWJ84yCCiOTOebhKmO0WEx?=
 =?iso-8859-1?Q?04RfRvWshtJSCrqWCv4Hr94jS8y4sETrZ0ogxJebUxoG379/TPMIKhPqgw?=
 =?iso-8859-1?Q?f3TQ/pxE20tXO0TqPf7zpnVHWmqkAH1hrMULWc7jr/5CRPWlLmJoOqvKXq?=
 =?iso-8859-1?Q?aHj0E8cEAWKGfVDEcCNDuGxktKiJ5lpOtCEDJAqleUU2oRjHbdNAjJU3w0?=
 =?iso-8859-1?Q?PCqWPFurLNKGLnjCWCGsOuo4G2sPpzHlwp1NNOZSsUSkRBBQOnwqQU0m2w?=
 =?iso-8859-1?Q?OhnCeAOXLw+5ly73kU60JUeN3jW2my3jovBEpYU3ERJFaRabhPOKVzigt4?=
 =?iso-8859-1?Q?vSU5WppFAEo91CxZscHFl8ZMbNKsKn5GXIpNi36VUxAJ+PJDton7mi3159?=
 =?iso-8859-1?Q?S6Kmabz9W1ATBoQQ3b7qg5DhU697sY+7w3bY0h3FvA7yS0RoWT0kwJF/xp?=
 =?iso-8859-1?Q?mDBMGZAmORB2vcM/GpGwjpEuZWxe2025bfmaxeNyOCEEpuLol1y3EH04GB?=
 =?iso-8859-1?Q?3btkjG5qMPow/Kz+uU2PPyGhBBT3JlyYrWxKs3YZwNnI9sR2b+xwmPR7ET?=
 =?iso-8859-1?Q?NFlba/pF9sCKrMkXKJ+9+c9DDI6SZEt/2gmD4Oy9qaykJg94CkchUduRfF?=
 =?iso-8859-1?Q?v3/pmZFT8p6ejQwcelyX8uv4kLBARwkOMX6BislvCMRDlBuU51QoaNHbAI?=
 =?iso-8859-1?Q?WO7ldr2QamkDDo/clPsls0947Zhgjc/zv+MTgTrieoJPNGU/30h80LKwl5?=
 =?iso-8859-1?Q?ZX+vQgYfVfJUkzgi4xkAvTEsONI6qw5/dObVBpl58dmzEGz4RHonCigC/E?=
 =?iso-8859-1?Q?zQ9MFqNQjtzhmkuNHbPT2hQQd8MWstMgOXzaWX7vhGqRu0aycUHbEJagXx?=
 =?iso-8859-1?Q?6JJA/47DaWJ51f6L21jBamz/5aT31GLLkOTqh7GiggS0Pm2w68WIl1sFhc?=
 =?iso-8859-1?Q?HOcFZMoKUeMCX1k2zFS9fC6AMWpqbwE1KP2DnzGREFY7hRZc2XDmezmXm1?=
 =?iso-8859-1?Q?BaFcf7lnV0yOztAEMcwZ/H6tqcTHMB4NYRv65vhvebl1xNaZiDdqNbrX5G?=
 =?iso-8859-1?Q?FUeqlkM+LzYRmYk189OyGzJI07SC7+xEKL1nloygGfraUpo6mSQs6MUJ2v?=
 =?iso-8859-1?Q?1Y2roLoB4UjnK4LBvEeiBqLnPTSYegPf+/bN/FbBNFxtDLjRJ0Ut38xmAH?=
 =?iso-8859-1?Q?TmqKCieGEgvRz7UfJPjMHWLEqwH2BCjDbHMtdH1VImDEJad/KaL7u5te4W?=
 =?iso-8859-1?Q?CcMpqtyL6ZJI7NRNYq33uTLaBPhRmutvJR4cOOCrYa7WnhlMTqGaUPk4q3?=
 =?iso-8859-1?Q?h8GGES6nJ5PEfJOKpfluFDajmctZRxJHLQ8LF7l4TBB6HGm9XyEvzOx0MF?=
 =?iso-8859-1?Q?tQ1RhvK/izOtOyYBwNu7KSdE5szuhOdmmUfhdv45druDZAaeiOvCG0enEx?=
 =?iso-8859-1?Q?EeZfu2tlIHDCELySGqcYNnG52hTWodNHC2OFdHz/e+KI7rD73Wfww549ii?=
 =?iso-8859-1?Q?5Djo/CVlq6KmWOxdnepVzDB/Q18y6CgrTC2FhcdtE0pXkZfIcvo8eBpI/Y?=
 =?iso-8859-1?Q?MKb425mieXpQDow1KXAhQpg+SUxc48l0RA/XW8lYNK5ABgsajyFgKq8FQU?=
 =?iso-8859-1?Q?VWME3MCr16x/eqPaQ1K2k6kXuID7K7qo/69zfPoMj1Dj4UAgH+pxpn6Ulg?=
 =?iso-8859-1?Q?qrlSC/h+JWnLzCZ+1Yr2mPUq7trXdbeVoVn2Wf93tKhqtYEGX3O/KAUeWp?=
 =?iso-8859-1?Q?5G6CurlbFG91xR9AvuWwFMqcLGRSDxcsxy6Zvfs0OScWsv5tKFUnio5Q7B?=
 =?iso-8859-1?Q?RGjE9W1CpA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53784b8e-61e1-4561-79bd-08de85a07ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 10:15:50.2916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvuUFKs5k4mLXWO4Mqsqehm+Bi5K5vqh61hs1MUKGYX5cHR8Waxc5r2lmaDz4AmkezMB7YE6rRbWWaMRJihc8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
> Sent: 18 March 2026 18:49
> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Michael S . Tsirkin <mst@redhat.com>; Igor
> Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>;
> Shannon Zhao <shannon.zhaosl@gmail.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Daniel P . Berrang=E9 <berrange@redhat.com>; Eric
> Blake <eblake@redhat.com>; Markus Armbruster <armbru@redhat.com>;
> Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>
> Subject: [PATCH for-11.0 v4 0/8] hw/arm/smmuv3-accel: Support AUTO
> properties
>=20
> Hi,
>=20
> This is a follow-up to the previous series [0] that introduces support fo=
r
> specifying 'auto' for arm-smmuv3 accelerated mode's ATS, RIL, SSIDSIZE, a=
nd
> OAS feature properties.
>=20
> In QEMU 11.0 we introduced new options for vSMMU [1], but feedback
> received when starting the integration of layered products shows the need=
 for
> auto/host-retrieved values. To avoid breaking JSON/QMP compat, we want to
> fix the option types so that they can later support the auto mode. At the
> moment the auto mode is not supported though.
>=20
> A future series will introduce support for resolving the 'auto' values ba=
sed on
> host SMMUv3 IDR values, as well as setting per-device ATS capability.
>=20
> A complete branch can be found here:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> ub.com%2FNathanChenNVIDIA%2Fqemu%2Ftree%2Fsmmuv3-accel-auto-
> v4&data=3D05%7C02%7Cskolothumtho%40nvidia.com%7Ce894f98044b0461
> 9099d08de851f1164%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C
> 0%7C639094565649714469%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU
> 1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIs
> IldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dx4bC1VgRZAfMHWHbJBD7rQ
> 3WNcxNncPk7Py3SmMXg1g%3D&reserved=3D0
>=20
> Please take a look and let me know your feedback.

I tried this on a GB200 system and everything looks good.

Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

