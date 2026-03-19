Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B1D1075275
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38Sp-00025i-D3; Thu, 19 Mar 2026 04:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w38Sm-00024J-Kl; Thu, 19 Mar 2026 04:10:41 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w38Sj-0003hV-Ba; Thu, 19 Mar 2026 04:10:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYYr3JHDuuIExNQxiNcBSFVOGSVUbJhNQ3eb7pge1pu/oMi5MtUD3J97XQBHp68vmTbh7vPacVUm9QWMql7mW1QSGKPblYbcWnmKM4TInRGznUcvNpy2GAR14Xvz+P+u/bKlvMwpoN0rhHOAOq4lyW6nOC2LSside665jQaGcrU3lO4WXk6IYdQj0362yQPI7T6FkcGAifc2QYDDVYgxJoarHzU606GV60gZIotMaDzE+ZgRtkRlQDuflicmkuWVo11Nprb8mLxr/ABlMYl+nB1RudnWry3eM/i4IzZ7hcw25ti/dYViNz99WWKd3rsYh9D3NIOPOirrxGmaA8nWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URwv8pLrNxHlJZV2W5iS9+EpCmeXyvdsOB/Kr5jk/iM=;
 b=F80tu461Vt366KumfGpyiolNYSV50LkCPFZdPpqyS1N9UcIb5GsCrmx6SkxWu8k9n6MLfsjunU2uF0cBUKurhnz4VvBn6A/33fgGoJbitItSD9b5RRKNgrPMFm/HOiIqXoq8DQ0BOgPZzKxcNZQcpNbrzaXFDYm4XPy7ZOrBLjXL2GOZoWE6Dp3Tp1ahAYCWGlJviR2jpbhotzucPDPd5wO95obzL9lRfe/9VA/JVCj1einklNu2McUXMG3JiQL2twZNcAs2iSlK6r7+AIEsvE3HqTWKFiB5HuBPV/mijsfsN2rxAbCKzogMhUb/iy3tNSmmWIZfMTBFkiiP0YVWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URwv8pLrNxHlJZV2W5iS9+EpCmeXyvdsOB/Kr5jk/iM=;
 b=PfUEk+uLzycbWlvplYsnP6doQ9D5NOx/YU5/HqQNlYikSXMmVABLR+iILaLG4KmnzB2bjjOdmRNmka2gcAWTJUgAz5ACZ24EPJsWq0M7QEMQ5g7+S2w7tPN+RfDTPiuQpTisNfHASttwb+7++lI8n1PaCsFYdJzMbRICFQ4UJaKnZaBewvo6w/JP8ax4mkB19N+/JK6pW9nsU+l4GJPw7K+30EKJFzhV3DMRxv0kHvdHUBv7kVrMbN/BxTgIp3JvEkh+3X4gFS7RY0mJGKlv+tr2Kt1a+snMtrwQdJ74c7E1ZOUR//quu33gI+Y1VJsPXZe+5NTzGQOETqWseAnYeA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Thu, 19 Mar
 2026 08:10:30 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 08:10:30 +0000
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
Subject: RE: [PATCH v4 2/8] hw/arm/smmuv3-accel: Change ATS property to
 OnOffAuto
Thread-Topic: [PATCH v4 2/8] hw/arm/smmuv3-accel: Change ATS property to
 OnOffAuto
Thread-Index: AQHctwf2leCqk4HXPUOmC3izx3KiQrW1gYwg
Date: Thu, 19 Mar 2026 08:10:29 +0000
Message-ID: <CH3PR12MB7548E06D36F03769CE082292AB4FA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-3-nathanc@nvidia.com>
In-Reply-To: <20260318184907.4060030-3-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH2PR12MB4069:EE_
x-ms-office365-filtering-correlation-id: 172f86e6-78c5-4abd-5de7-08de858efc73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|7053199007|56012099003;
x-microsoft-antispam-message-info: Gakx2knAgr5ASN9TMbtfiqjHccsCsyf8L0+pucE7msjQvgPDznnRe99N/q0IyvrlKD6j4YvV3TRtRwYW9qWEEbzkk2R/apYjZyvl33qS924kgthh87DZsVlIbUQdHFn6utLwb7/lWysG1WtlZSnstubM6PfTJ8Rk2Qr8aANHjhJ01r+aiehKszk/KgL5XbiKg3nxnhxb2QEaKmkFBHhNvNvxSBKnNn1Y9Y6goSr1aiKl+6m2s6HYOmKp8xCoxKwgLrSP5q5tzxemNu+pXauRzj91alg9XoWHfF3EiInWp8DJyax8Q7b6i+TJNT5lxdqsDe2Mxh81ILCUm6JpfJBWNT6yU++jbAywmJvCllOjEmQSS8KYy7/gb5JAZhsumRclWwXVTIaupSV5R2ur8ul4c7hsqfB3g5DQwWFRekKpKJV5u0JAg8eGbmp1OLpwClAnmQYAL79WqnGTcb+sL2wfm0GU1d4zqrygArMaDK18el963LY78aS8xX/HGuuu9qYf6L1RbwPOUOfiOmXH0bYQL6T9pkxyZDUzI3hqdlHm+kwARHH62Kexgs/pI0nLAwqrAO1cigTy5HBI+8k1rw6uAxRmGjDwDVMukqqyHcIirRnbcPkN+VqJaVrv4mJWW1+q1Lm0OokPTQWNyyled1Ai4wcMOBzfuwcaz2bM4HPhfGuUPAfZiWy9Shyv0o4E+0j4k5D7RI31J8Wah8ZZvbAEHiTWKTmS93ufsGSA3SCJbLUD1FhpbaqF+bn751T1rpYlLfc7haKVCdzhXCtpSlxoymvkyXbOJ5zralmHAjhjFEc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(7053199007)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9SVEVBiW7lsgARHCBpotZRwmp1v081WFUd35t7n3RhCMqwpTChAy8kWY7v?=
 =?iso-8859-1?Q?/R3rIaqdhTDcLH+P/m64i39Qtj3lbfsvc0PC/Hiigy4xEYtI7FoCwMPPvL?=
 =?iso-8859-1?Q?b0xXVKdYSn5kBhgUh354qne+NzaZ5DXdWk0ISZ6wWZXqO07iI4Rz0hkTEV?=
 =?iso-8859-1?Q?Jr/V6w/esyWedyj5n2ycZvys8G9cRu/GiRd/Corhu/LTk6jrUCgNhqX3jm?=
 =?iso-8859-1?Q?R/W/3FCFWhIASFWpy0sd3LlrMCyzhx0OZasLXP09zNt/IgTQfhqZ8ldvt5?=
 =?iso-8859-1?Q?ERr4TspU1/FDRVPJq6KKlUB4pEt9Aob0Proz5cZt08cM0xg5FtQGKG2vxS?=
 =?iso-8859-1?Q?rHA+j9lLQVHWS1t6358Nz1DS099j5oqavICw9ZHIpZ/xw409TO2IFeFleD?=
 =?iso-8859-1?Q?bIBsmFefjfYrkG9joLc5UlAe9cRqwhk4gp8nxeGLB8ogLkPC3SIZIFbQA5?=
 =?iso-8859-1?Q?lZhpYz5mwDJwnzpnBZzhmUy0MOhb3/YovD6U7jHwLrN3wU0XNmCF10wgTJ?=
 =?iso-8859-1?Q?hOq+MvaGK1OaIYpZ0/mFczEFyEUmGwAFl117uA7gRLbaEw1JygIfJqHAJT?=
 =?iso-8859-1?Q?n148irms4cr8Ik7rvusOLSXb4eWfno410yuk9fSQGKAjvXMXdLvaTTVh0h?=
 =?iso-8859-1?Q?KWPF2tCNlbm4aCac2iHBabqOKBUnaFW9dhPRNDd8S2Y3nNED+1FavviNtw?=
 =?iso-8859-1?Q?X+n9E/rWQiywhP5hC+4Ggnv0CJMvYIFptdiBagOWTFWcvEHVsiYNfGFTsl?=
 =?iso-8859-1?Q?lzBvh9+OdP4dC66eVW9UqkB2UrQwNCaPkaUkFQl6YJh5vQQSknGAjaRiSo?=
 =?iso-8859-1?Q?6Eq7D9A1PyIq0QppSJMAIt0pihnU1FZEKQERUkNhrDhfHDTXTYfZ8Vgsm8?=
 =?iso-8859-1?Q?sA0Cnh8FwoSpsr0E+CGkaiuu8IhGLyE50LwGHzaFNtMgxy52E4flulQOHm?=
 =?iso-8859-1?Q?nAuR9DuGuvAJ6G3ukhUFl9Y8x9trNSMCGAkctIv79GvWlsKuLrFOP1AHF1?=
 =?iso-8859-1?Q?1zVAaTaup7/wxL2n21wsDfGncr/BatpYjxeBvBq22YShq2p9NWup5YbpZx?=
 =?iso-8859-1?Q?B9uHoeXTw20p++b0hWDMLae/S+848pCoFp0kr8CpSEoj9grSQXNfpyWyBD?=
 =?iso-8859-1?Q?S9Vu2d6SSzzgaGwS+2auEfPnypGAY3JmxVviJN3chG5+QqTHBYbvMicY14?=
 =?iso-8859-1?Q?ZUoypN/AHzVHTQ9lBwlHJW0SWqpRXREeVd86OZItxU+C9pQk7zeUZYYwjb?=
 =?iso-8859-1?Q?nAwwMp5+ah8AJ+dEggsNJp7TMS5iFrVUQMB4NB23C0RayaCFphTKYe8dFZ?=
 =?iso-8859-1?Q?zGQ5C2L9T1TRqvTAVQsuy9ddSW2ROWmbf+wFxqkdSfmvZP2x7yIhrMDg68?=
 =?iso-8859-1?Q?ODrzUURzVJEFRoej6Pu2ggNZgHXxhp1FVmtnyMikgU4HrITKExmJoRuhU/?=
 =?iso-8859-1?Q?U9ld2e5pfBzjRAQQCEGWH9yqD4ZRrRdNgRAW/9n0npKFI02Mh+CeGsRRWv?=
 =?iso-8859-1?Q?rdQvpMDCrndFZwPCYcnHWT0T2f/kO0B4pOdww2e7qWO6+9Zc1dhRXN1Alx?=
 =?iso-8859-1?Q?WHmfRN3t3izdDyJWHWke/WL4ZvnHFQGc12+KwcEZDWVADsUM/UkwgUiDXM?=
 =?iso-8859-1?Q?Iwi9LWQ571aOO3dKv2ZQ3SYjYhlTh6LyTM8iuIyTDDJh8pTS9EAQFhVKyJ?=
 =?iso-8859-1?Q?m7qMDG/FLZw+o3SGE1SZQ7lu9L1K8rZ9FgjhREzlBSxzApttolrKGdV6/f?=
 =?iso-8859-1?Q?FaLJaPBy+pFLsGv+C8SbezIvMDuAloEiy8rZOjKOFGqtcundHWXEsbxLqt?=
 =?iso-8859-1?Q?ulfIkFylUw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172f86e6-78c5-4abd-5de7-08de858efc73
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 08:10:30.0063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wo2MPBbtLLGHihWIzHZ8+PNdfRjVRyWl9D2fLl1cIRQPJoweUtaGYRiwmDiveOuJ7e8rC/+8jXsJiUiKXaBGDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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
> Subject: [PATCH v4 2/8] hw/arm/smmuv3-accel: Change ATS property to
> OnOffAuto
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Change accel SMMUv3 ATS property from bool to OnOffAuto. The 'auto'
> value is not implemented, as this commit is meant to set the property
> to the correct type and avoid breaking JSON/QMP when the auto mode is
> introduced. A future patch will implement resolution of the 'auto'
> value to match the host SMMUv3 ATS support.
>=20
> Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

