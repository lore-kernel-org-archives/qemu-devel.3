Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111C710706E8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oGw-0001qU-5m; Wed, 18 Mar 2026 06:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w2oGu-0001p8-BG; Wed, 18 Mar 2026 06:37:04 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w2oGs-0004cc-I1; Wed, 18 Mar 2026 06:37:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiJv+pQeTTjE3gVjzqRpwl1oU4bNnHvIlpVe6c2xsJg+pokef8X0eZOupmATWLAz+AAzyQUzlyuYriY3dIgUR8QgwmvPigbSY5n3ediSQPVf6HsvWwZ/XCMkUYV6dwijQLvsldxp3CNiKLqr5IXuMMl0P7oIvqFvQNnO9mHCYF4YbSuY56VnxQH4Dkj5xgopBk0CJtoRFAV2Jkdusa0R8fFoo3FaFXwE4TLk/VFSgDIlwpWj9UO7eEVBIp3SMYhsHq9M5gBSGRecQHeD7C1W92XLqVjuwVFe/ozF7iSKB0WwOMT1A/clyvtiyrh1ktvxfr3KZJ+NJeJgm8VS43BK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYp+oW+0c1j9aIcSv57W1PiZBzrETLr3lUrT4xDtCsI=;
 b=OOaOJPT0uW0SH6hld+EExgOv70lR+hqZg9d/A10cs894sHubEaRWtHfK1RbcY+6k7Ghe8yGs4j5knBunPoXfdAWkP3SbAu3GV7VFJHNsqZh4VhIZtDbmqF2KpJV6Ny/lScW2WqCMtDis/tmUHD/EdcBjGgAx6KMCzgep1DuKQu4xzs7XKbDDT3XJCyFw6bNmjnR8aefLeusKmZXBnEAxBYvFnLRQPQatFL7zeMrxnBhRpMBW4pmkJbzOiGQhDUW5DVwBJWzbJA7J2gJlZHV7f3V3BekNepvWB9/TvWW+wfFfGPOdmIvBX+EmrHccFoR3Br+ATgMA0E29Dy/5lHDpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYp+oW+0c1j9aIcSv57W1PiZBzrETLr3lUrT4xDtCsI=;
 b=EwS4qlZIEGqRRBxRY4ErJlv4iWmXuOZ7D7+jt18WimdTPs2BUcxZZ2KJMlluL8ngmz2zM/s0X6DS9NzjjKTciNS8q2THQ/KZ24EoxQZjjGh3Gyj5tmlpSAfkASNgejc/9yVV/rBgtIBRfnL7U7gj5oifeXDfhicfNL/CGJF3wYYCq5zAbF7p8ri2eTbUuYbMDaP44iyH2XhPX0fsZBaptev/EQCNTgOydKoi9+q0bdaktd6BrISSXKdm5EgjJfIjwG9oCvqE70d4qFBuAsQbNq7IViBx+s7ZshFy+TICgrElAlU3fXARfGyce8ly+AGp9rms+JT9UzT43Zw6NfQGbQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 10:36:57 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 10:36:57 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 8/8] qemu-options.hx: Document arm-smmuv3 device's
 accel properties
Thread-Topic: [PATCH v3 8/8] qemu-options.hx: Document arm-smmuv3 device's
 accel properties
Thread-Index: AQHctj1I1jYHFFCD0kG26K+T0ZH117W0Fmgg
Date: Wed, 18 Mar 2026 10:36:57 +0000
Message-ID: <CH3PR12MB7548928AA0A42DD675F06708AB4EA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
 <20260317183755.3721625-9-nathanc@nvidia.com>
In-Reply-To: <20260317183755.3721625-9-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MW5PR12MB5621:EE_
x-ms-office365-filtering-correlation-id: b19ddbfc-7d80-4e69-8111-08de84da478c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003|7053199007;
x-microsoft-antispam-message-info: JYd+65rn4PP2x7qy/KUrV+n2wQkUr9l2Rv1lyXhHa/DWxDGCME4lkqHZvREbefPwVsZ7FiUkysJSzeIB0OD3z1h4G+w7bAccqJWceno5L1CPNROn2y/+uPgGMBksAtpsroBDo+wCfESGoPzm0OVz4gy+Zheb39S4I86h0YiXE8FyQ2rF0cGcFL/WmSvWg3m/rmM5vTeZZhbX3q+THOb6cmh1RwPVhYYjD9rteOo46rC68AionEQulkTGiA+ljxjLYx4wqbcylYudBYPPMoZ5H8ztOUiAlkWcMK0uXMVoAwgEW8F4L+XJ4uSoN5TIJ9QCqblH6Pxb1k9gw/Ti8Vdp0Zq3kq/eObQhs8skdqv3De8MgALb5lKuxRHlI6WYsNaL2ssAQYgSM2ND0jJl20gPyPehkqoXzxJgqTQYfIg/t8LJqqMbpQeVkdkOUY0lyDXTrtmOHjhW5qNaEAiA9lnfQBshIseQkS93p0RYnTR8+hVsXkSlz0KFnHHy8WW5u3C5b2sJ6kM9Y5sD1RaSXcJfUX1jV4SG/Mb6lzPE5S0cfmFguuhv7Dk7o6Ms9TBWSL2oNEf+GYz6k18kHwsLwrJx5wQTFMvmKbiGyL1ttFUEqW1EOAHOjgHZmOG9IwvLblyqfmUYTxImqkz2oRVUovNyXD8JD8Ncf0yN9I1SHjGaXGp1c3Du1D95j7B0duaxzlYQnInrGKhWuoz1frhdicErQBMnbFn+9iRLPn18OsE3MQyqXAkAqm6bJ+05WXsorFjTK/LUuvp4bQBFj5hgnTEZuFHJlG4N8HJvJZSYZ8iAATA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KunKiB5XQHAE4qup2eNBCxKZc6ugtWcYBKGUol4+bc5AnHC7yWBmpaaw6p?=
 =?iso-8859-1?Q?ltKbJUty4iCItHcPZNCV+RzHNyc5z3VsyRL5WLGrZZCc0HuHv5KzWWMiku?=
 =?iso-8859-1?Q?iCHsPVCp5bZE2uJVp5hKtsXTIr6P19NiMW87iObv0DMVoP5ll2dLKJLUmb?=
 =?iso-8859-1?Q?ox0IWXxb6aO9URM8x2dYYkuNomXzQ9c9oQerJjiyRTFcd5QZFEeUkk1fk0?=
 =?iso-8859-1?Q?+u6ShQCMvL5ohIhmFx8zfLiSoyCsJpbNr5IPG6MtwGlIRllH1WL0c9z2RD?=
 =?iso-8859-1?Q?agy22kBlIoAihC95jqBWcRkONR+U5vXOGsnUZEUer97QPwjbB+O2WixMK6?=
 =?iso-8859-1?Q?9WCNvE0+0oFqYbD6CU16pBGRL2BwrYyLNeG+FsM+3wSwvYSUUUxnHwgFvc?=
 =?iso-8859-1?Q?ySqOdK6vh14gKZlp4YAX4z/iOIzv2SakPWA1vKpVXxY5Tpw+PL+sj78VSl?=
 =?iso-8859-1?Q?sakp3bus6htl7CoM61avw9sAwaAT6mQRUziDVM3BDwd6KnfrX7WVWmAXqK?=
 =?iso-8859-1?Q?t29fDmKGOKj8eSd6wN0hZ6KYtv0HnA9ufQjXjuQRnHNjrSseqCWnh+RH9i?=
 =?iso-8859-1?Q?klzHph19Ym3z6Klj+pUuIrfvfQ6sphaNrX/O+64bFjQ97mpeWoU3dp4Hwx?=
 =?iso-8859-1?Q?1ZF2GQ4hUvQpkFif8qBAh+MfbwnpVRawvnpxr70tPd/alQh/r7WY1q0a/U?=
 =?iso-8859-1?Q?7CbG2pKFQGHlaN9RTsEOzJaLcnONwRaU0luZiY2V1ZVIPxHrquZG8HZqPE?=
 =?iso-8859-1?Q?ydbNVfIful0sFd62gqNqOa4aGT7GgM9KRYo0QS72zQEWMwG21h5c1rezA9?=
 =?iso-8859-1?Q?51gN7XH+QrhqrjlZp2Asy3S/+w+4Id2BZTOzSxJfDSi/dCd1nlXtCa/Qvh?=
 =?iso-8859-1?Q?4kPxdcifJkHVIgIQFqYU1jizzhs1+oUksojJo0D1vbdnmZbZB/Kkg5+xrz?=
 =?iso-8859-1?Q?9BRsxiAvotlA4x+LxnQb+1WLU3kf2InYH/9b4HrHWJ2u402pU+kbN7b9wg?=
 =?iso-8859-1?Q?OF+nm5AVfPTEMH6lljtQPSIaVa9iywBFo80+e125Vb1FiVwk/3apUEoMkf?=
 =?iso-8859-1?Q?BYlnZfbySd+9KXItK+yBeZQTpRUZj4GF0aYIVUic4RBVEPCxMGgrBErjrO?=
 =?iso-8859-1?Q?tp5i45JXKezJW+RCqNRgiGKykbLvmvDTOhtZTjyPIMEwxqYR8fdg0zKe8h?=
 =?iso-8859-1?Q?rfbDoyCE1h3H5o69E5gJdLAJCfxexParQhoVYQH/S/V2jSzup7t1AwAgVK?=
 =?iso-8859-1?Q?y20yr3MLI9bVk1IVv/54c+COGQ2ePhJxIa1uPCRWVvfhs4Wc87Hym9pRlD?=
 =?iso-8859-1?Q?W6QfGPkfuB/1apcEdLwqf7RZ2fMbAyR3e+oFg6lQnWZYX8FROlLq28zlSd?=
 =?iso-8859-1?Q?NMUrw8QP9aXCzNQHwvyoq+hvjd/7wJkIAl1iNo5sqcXt6isncnxNTBRGXN?=
 =?iso-8859-1?Q?RjkC/Uej+QTRYWL3QbZ9E4lwyi48Y4Pv0ftLsz0Qm6oodKZNhaphgsPO08?=
 =?iso-8859-1?Q?7giWPk/hlFTsg0N7/m/MFbZVJCJiP+uOvgO8Y5/3d4oVh7e1vh/Y8ej3xw?=
 =?iso-8859-1?Q?AWKCgssUSxn3yxCRQ9wH4nAcpxJSy0s33gvVAI3XWRPQtlSk2Crnp+uH0B?=
 =?iso-8859-1?Q?03hQEMgeJHVFghczCsZ370Kz9arJ0vQZNf18lwo2F+44hrJMAJ1sL5/1/r?=
 =?iso-8859-1?Q?heCHCD0gvxvHlP1O/3RwwY1x+esesUhFCCdr297sSQPc3TbMyLVDRuWxig?=
 =?iso-8859-1?Q?8EbfEg1ZI2r1QvwapNLdHi2DZed5z3kN8B3OW/Gewhd4Ps4S3Wxjd2AMEF?=
 =?iso-8859-1?Q?MxRB/sXH5Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19ddbfc-7d80-4e69-8111-08de84da478c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 10:36:57.1270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxJgHKxbO5AuMd/mKK+g2F+TjhuBA4rdZ/JLh/nljuuT/b+j17N+pTl2hB+nxFW5mVcbU3oA2Ng1vFQBRsMxLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 17 March 2026 18:38
> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Shannon Zhao <shannon.zhaosl@gmail.com>;
> Michael S . Tsirkin <mst@redhat.com>; Igor Mammedov
> <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Daniel P . Berrang=E9 <berrange@redhat.com>; Eric
> Blake <eblake@redhat.com>; Markus Armbruster <armbru@redhat.com>;
> Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>
> Subject: [PATCH v3 8/8] qemu-options.hx: Document arm-smmuv3 device's
> accel properties
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Document arm-smmuv3 properties for setting HW-acceleration, Range
> Invalidation, and Address Translation Services support, as well as settin=
g
> Output Address size and Substream ID size.
>=20
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  qemu-options.hx | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx index
> 69e5a874c1..0ba8322695 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1279,13 +1279,46 @@ SRST
>      ``aw-bits=3Dval`` (val between 32 and 64, default depends on machine=
)
>          This decides the address width of the IOVA address space.
>=20
> -``-device arm-smmuv3,primary-bus=3Did``
> +``-device arm-smmuv3,primary-bus=3Did[,option=3D...]``
>      This is only supported by ``-machine virt`` (ARM).
>=20
>      ``primary-bus=3Did``
>          Accepts either the default root complex (pcie.0) or a
>          pxb-pcie based root complex.
>=20
> +    ``accel=3Don|off`` (default: off)
> +        Enables guest to leverage host SMMUv3 features for acceleration.
> +        Enabling accel configures the host SMMUv3 in nested mode to supp=
ort
> +        vfio-pci passthrough.

Nit: Instead of repeating for all options below, may be we can add somethin=
g like
below here:
             The following options are available when accel=3Don.
             Note: 'auto' mode is not currently supported.

> +
> +    ``ril=3Don|off`` (default: on)
> +        Support for Range Invalidation, which allows the SMMUv3 driver t=
o
> +        invalidate TLB entries for a range of IOVAs at once instead of i=
ssuing
> +        separate commands to invalidate each page. Must match with host
> SMMUv3
> +        Range Invalidation support. Only applicable when accel=3Don. Set=
ting
> +        'auto' is currently not supported.
> +
> +    ``ats=3Don|off`` (default: off)
> +        Support for Address Translation Services, which enables PCIe dev=
ices to
> +        cache address translations in their local TLB and reduce latency=
. Host
> +        SMMUv3 must support ATS in order to enable this feature for the
> vIOMMU.
> +        Only applicable when accel=3Don. Setting 'auto' is currently not
> +        supported.
> +
> +    ``oas=3Dval`` (supported values are 44 and 48. default: 44)
> +        Sets the Output Address Size in bits. The value set here must be=
 less
> +        than or equal to the host SMMUv3's supported OAS, so that the
> +        intermediate physical addresses (IPA) consumed by host SMMU for
> stage-2
> +        translation do not exceed the host's max supported IPA size.
> +        Only applicable when accel=3Don. Setting 'auto' is currently not
> +        supported.
> +
> +    ``ssidsize=3Dval`` (val between 0 and 20. default: 0)
> +        Sets the Substream ID size in bits. When set to a non-zero value=
,
> +        PASID capability is advertised to the vIOMMU and accelerated use=
 cases
> +        such as Shared Virtual Addressing (SVA) are supported. Only appl=
icable
> +        when accel=3Don. Setting 'auto' is currently not supported.
> +

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

