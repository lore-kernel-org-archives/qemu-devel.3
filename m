Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E49C5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 06:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhNqJ-0004NL-UZ; Tue, 05 Mar 2024 00:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhNqG-0004N2-8Y; Tue, 05 Mar 2024 00:59:56 -0500
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2418::601]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhNqD-0005KW-QE; Tue, 05 Mar 2024 00:59:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgM9C/dU6LQFVYHqQBjweCfxiOhLxqKyLbXBNoOhXY8XnXsmXF6njgz4oOna95eeUfIwAEedbVVhmz5ysztMUKCwbl96Fv4/RZG0VTin5NsP8qe4utSamskGzgbvYP0dJ1k8CyGK46of1hcIDrX5kwnw7nQ9E3VDW06lb4ZrP5QcFEac+8CxQyo6xkNseRDQdL3G6rYtOihyectIbLWa1G5yPn31zh76zx8NSff3k9/WTBn7BzRntO1yb1r8PBRG2Edk+W27CcrfNVTim/WQPnS8yjurV4lzjo6syIAaZ/4e86fa5jpLr2tTleMRozZZFpOiJL41nwRbwHVAgyG13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDRusCOvjTlvcmR/WYktZRD1EXrx9Z9M0gspirzV40w=;
 b=jIqCig5Ui3VLE1aM5bAtzlwG+KeMkhsWNCGv5NfgJC48j0BsorWu0qXTSPI6lyJGtH8OfbKe7WKEG0xINl3FfQ3GkKKBDXBEXuDOj+qARV/LajMpPKp1Jx/RtyggPkEayCPyjHVrD25eIOL6lAcXXnVhUH/r1CvqYHBEjgEiaJXP2r56hssDeCzxnTdFI5SSToEA5KvNLQ8Wxr18F0Fyacj9m0dqC4EM0bqeBaw8g7ow/BU5T2NYHqeGgN7lSwLtEeCgBuPgnhNnc2hlAMozlH9omFNstbu/ipbfOZTgtBsEzOT8tELl3dEjfR89Tk1X0hydbc41Wb5qSODdNwdwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDRusCOvjTlvcmR/WYktZRD1EXrx9Z9M0gspirzV40w=;
 b=kDKq6j+HmhyRoGXdG3l4ipM6FPrt0xlDxduacKCeEwumZ8yTe/7+VHl9/c3jIlArMHOvCoP/yHkCEITUjDcnbeb6I9APeVS/VSb9eI2WhtG4lMhXKvUDd3mXmF7kiUspol98BDXiyxGcM9K0tKaQtPpq7dZYHbJ86fAd3flplc2pb7zUWc0qEz0Hrps4Q/7swx7GYg9RqjCky3dbDp17xMDZsUzXwq3MRdql/LfF6TWYB5JX+MsrGDU+rZk4RZ9LBP4lJV0lHNSa15mvj0xos/hm7a7BqmRcM1pKSf01/6yH1eGcKnOwfpOBgGeQy8V6CF0UiXX722VOEYVya3ZSCA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 05:59:46 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Tue, 5 Mar 2024
 05:59:46 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Topic: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Index: AQHaZlXRPSA0zxYvqU+8THPBcca33bEc2OaAgAvebIE=
Date: Tue, 5 Mar 2024 05:59:46 +0000
Message-ID: <SA1PR12MB71995AAADE78D3D0052FAC01B0222@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com>
In-Reply-To: <20240226164229.00001536@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|LV3PR12MB9259:EE_
x-ms-office365-filtering-correlation-id: 5c8c24fe-dd74-41a6-08cd-08dc3cd975e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5hQc0gpMu92SumwOLdP1quwQ+y5qTkmkUP0t4hXo7ImsVQ2qMuzRwobD64/Dzgtx6O8PRJyVrdrbiK8rGDEImd2UKoZAnQYFDkYhmTRYCTrHNii3aq2MbWECxDZCqH6iQuNWak7rUwzQsin8bhda/BM6J/AqBny4rdbq24JFQSfp8WPJ/sDsK7dIOBkHBlMoypVQRTYKItNunnTotapsNzic8hOZSYZJs4wJvGGF2uUYMYRYs60U3HRSDIFBA311mdnf1KkrPx5HZSkN739KTxjkjdCYk39vfJUJpXfC689xHwavaClrNaOas3CnyW1JMFZYr2BJi3HCTJEBiHwPy7NVg/ntofRLHAFvLo1oWDlhULq7YE06HDN/HxccGQ6erWJBkr0WD5VPaUmOpvsBJXk8VQkI4a+4hpteBTgp9Ps2GQgAOso+qGpBUaF9z9R3+jUA2qph52VOUVb/wGq+2kI0uyRMhRYoDXzRdfcTzhGH+ITyhip//dEvBpFR3wNC/0XIw+TiNg6ofF+Q7H9ncAF1GQduc0Xg0fCZWXpZaKozo3H0JUlBWTCYn+sHm5ZXreVvIx3rjkTT2fYjwQylykNPgLWW3ZOUQzsCLnpi3SQyoFekBg83ldsJcyHX70vpZW+PiNOoPXS2WkrvC4V1r7vKQ1quwFVEEgik8bOh9Er+1YpfMsod79cquXrsdkPDn5RiKOTbAiIZ3p8GPjc0o0fMTTw+6xByKJQK7mzrhAM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dq8l2kQ0wtMuaDMG/0pCwQq3SAZPm+cGjb5P7xJbQYbls76xr5pKB/G31o?=
 =?iso-8859-1?Q?1gYRMQTi6ZSUBg1mGI7/BKITklnD2FiviR0TzWLXrHdtTDPjqioLPjjAJf?=
 =?iso-8859-1?Q?u6d7kHTAWhUgkxaBX9LnUCXazGYO/5QmpDAYo9sIj9OQoZ3kS7UZfivb2d?=
 =?iso-8859-1?Q?CFcj1ehQTsgmF6V8uRMZkgzPWbtlxc/89STQ7zHymAhGzQ4yLD2f6REXGc?=
 =?iso-8859-1?Q?TUXBQGBMvoJvvAAzPZ+cSHhJ2phauFPa4x3itoEOxcboDC3ENb6Yp6tRKj?=
 =?iso-8859-1?Q?bxgyCDEl6LbgnqRApofQCSoV5+aTPU4uosaOB2tbWKGQ5gotzYGqsWe7Nn?=
 =?iso-8859-1?Q?ucwYjouUQhIQXxcrseJnnv7Og0fWeN3o3DCLSWavJRKZskZZtc9piyl3S3?=
 =?iso-8859-1?Q?elIpiJE6Maxi/VeV+zL1zs3LQlwaY4vN3eE101g5tg1oo+Z5P3MGmYTh2T?=
 =?iso-8859-1?Q?qQDHkbJqX7cc8nzLsummXbNz4sXDqc0F6zgaBLHzxaB8zaBrR5A/+o3NXL?=
 =?iso-8859-1?Q?Bv3USXqzoUjfGnwcBbamTfSSAzVcKCCm6E7EI0G3k8r+HQe+1tnLuLAQcF?=
 =?iso-8859-1?Q?DtYko6ky5b9jz/jvkXD6kWZG6pVB4wScCZYuwEWtTJMhM5HoRh7FDTvvMY?=
 =?iso-8859-1?Q?LECpQy7c7zQY1obyfRzs84hAp1/j4NMxyEb+8Gfg8KLkTFzKEFCd22IJR4?=
 =?iso-8859-1?Q?MA574z39N6Z7PnhbYxuD7cuGaHXEWcw4VokMYnr8AC7e03wFqXA2oBw9cd?=
 =?iso-8859-1?Q?+7Bu2GPqUDKEWeWtEnY/zUjK1CuikxoAIeW7rNDrkPH6yw4NadM2HHchp6?=
 =?iso-8859-1?Q?yoF6rd1CDJxies1X6uUCrG6XErf2LJu0UR1cUBnOi3KyaS8losQq4OtzJi?=
 =?iso-8859-1?Q?1WHkfB2oJEGTBFt44R5HK//buGIyVPojRdj8EESHolgyEqyNr+HPDaYbQa?=
 =?iso-8859-1?Q?N9q0FMBMwaZZukBVpZ1QR8EwymVpZqm8yMWsHrZvtolhIGfsVB4B9Vggg4?=
 =?iso-8859-1?Q?da+s1qpQuCIyj28ev5rkpHTwDWoHTFfMViJi/g3U39nOtWnpahzPkGAn/U?=
 =?iso-8859-1?Q?T9CkE0H8sqt8OU9dSsVHCdrnvZcirl46AMnB7qWGKDNA7HnK+kRmXERGm+?=
 =?iso-8859-1?Q?sIdcjTv7fu7RCuihD7q4JatnfQUMVh+8EUPrRzqDMuDsg0/O811LA9JsHd?=
 =?iso-8859-1?Q?MVwD6kxC2KXc6f2BQr9ahWz0NaVMY40W5fzs2ip+EvESUUEyQR4kkMNlFZ?=
 =?iso-8859-1?Q?c9tSWuJZUNGrjIVvHs23A8EGiIEWNWu5ew8H7rJ5ByD1ec2ezuzaSM2n43?=
 =?iso-8859-1?Q?C4IsgyxNm+CoCZM1WArpi4f/bFCz2lWlmTBBhbVsekKyAK3FURvxUlm+dL?=
 =?iso-8859-1?Q?vlXaZ3bik+7YHVT6pU1Acj61SMswGU+i3DAZSQ5cBOERdTT/rDAr+4fI4T?=
 =?iso-8859-1?Q?2ES+wy4Pq7PYR60eWFmGCWf0o/onKNtdmUgHrHE/VeYccX391Jib5xhVMO?=
 =?iso-8859-1?Q?rivNRz+ZRwyWNbA5XnBtfAb+35s7tMilkdAi/84VUTA3MgiOkVDE+89PhZ?=
 =?iso-8859-1?Q?XEtnU9fPFvi/T6jjqTRhDqoh1//+6DVLxnjYGBbXqMjhV+NpVVLF2nxGi1?=
 =?iso-8859-1?Q?TWu66gRWqb9dA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8c24fe-dd74-41a6-08cd-08dc3cd975e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 05:59:46.3265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rl3xv+5LgB+iKlpQlXLrFlqt+1/u1M86JV69OeD0+Yac0dFzHxQ1sKSns+kX7qHYhZR6VF7QKsaQeLmYtwYKgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259
Received-SPF: softfail client-ip=2a01:111:f403:2418::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> One thing I forgot.=0A=
>=0A=
> Please add a test.=A0 tests/qtest/bios-tables-test.c=0A=
> + relevant table dumps.=0A=
=0A=
Here I need to add a test that creates a vfio-pci device and numa=0A=
nodes and link using the acpi-generic-initiator object. One thing=0A=
here is that the -device vfio-pci needs a host=3D<bdf> argument. I=0A=
probably cannot provide the device bdf from my local setup. So=0A=
I am not sure how can I add this test to tests/qtest/bios-tables-test.c.=0A=
FYI, the following is a sample args we use for the=0A=
acpi-generic-initiator object.=0A=
=0A=
       -numa node,nodeid=3D2=0A=
       -device vfio-pci-nohotplug,bus=3Dpcie.0,addr=3D04.0,rombar=3D0,id=3D=
dev0 \=0A=
       -object acpi-generic-initiator,id=3Dgi0,pci-dev=3Ddev0,node=3D2 \=0A=
=0A=
Moreover based on a quick grep, I don't see any other test that=0A=
have -device vfio-pci argument.=0A=
=0A=
Jonathan, Alex, do you know how we may add tests that is dependent=0A=
on the vfio-pci device?=

