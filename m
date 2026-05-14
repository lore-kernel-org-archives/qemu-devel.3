Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED0ACD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 16:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNYrj-0000N7-Gl; Thu, 14 May 2026 12:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNYrh-0000Mf-H4; Thu, 14 May 2026 12:24:49 -0400
Received: from mail-westus2azon11010057.outbound.protection.outlook.com
 ([52.101.46.57] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNYrf-0001zy-Fs; Thu, 14 May 2026 12:24:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BACSNoiTcsVcElBX3mQndlAAPKIGsgGJFOgA1/T13VekIAnp+bR99mJJpSUpgvFYHw2MG64FuLcTDcQWKcftpxc9KjU2yLB2pg9uG+C9qzdyvbQNMzxl8PG3EAsnz45SqYIb6ZaE/ZM5ILmLQ+a0nJgXEunfvrvlbLb/0EMaIVmWLwqcBVcEj22yf4ASnUB+CA7yHJ9BjxUR1tLaUd792BIWKjgvYmr3UmVn3WNVAyVw4O0VNe4SggyqE/LblyLxpZ8tk6B2JvtU1BAuJRYoWx8pEmn1/mJ3s6rFcrRVIoG3QwSm0b0tNaUyd5/tZRc0TgFso260wZvyYNJcUxC+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0K6muU32rOxEUb7LfCFfNpaEaqzwrF3pYGa+kUQZ9E=;
 b=iiBYcJXK+XHsOYxJIZKyf3J2BIDTxiVAumhjAGqSZ2DT1sLfKsl4ann5j6qysfEoLHZn3eqhbRS1UKDhhJ0My9Rzn8rs/BONA2wdeCt6UFV7oQ/UhQwxB5B6Z5lV4tna+rwMLcsHMcij6aBn7LvvZucpBPYk+R21efZtyQe1GdJBS0A1OU3tbqfssK8Jb5ljHyOmTAaRldjc5o+5rdcfkd0LW1d+A/W+mVcPXsNOuUkxVm3dO3jGczLZ1Uz67uOJ1mrYSklZC63AQ1odnzayTomMVteEXgOJtunVywRqqg4mtpfAHTK5ox2pm7126MIJ98xzoq1SSPletv7PAFkXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0K6muU32rOxEUb7LfCFfNpaEaqzwrF3pYGa+kUQZ9E=;
 b=IVyokkMFnTBU0pbmmMRc9LMsPD1U4RyKUqPV9/wcsoiojHZM10S+RrpYxLQ0hMY/jSmnysu0TmSD/UXwHpFHuls4pMEqMflLBRQUwzRd1sPxFCz7Ee/hlRqfV5LFNFeyiUkbrjDY5/i8d0N/VHl/e9glSiyvesmRgFnbuLI+Dio/LliZSyejzOyqSMncFPbgeF+PBn9VrS8txO8wq9L3a/2QIae05ayqKL0iwRE7ftXXXc5VtsSoC6FIaZIKfeqxJ0gaN51cCYHxV2cenZbVI3oadRzGDp8PhwnZ2XQm5eAExg91reeC5Fq2RXHUbAjmD+e6UPj/zr6nNdxX1Cv0Qw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 16:19:36 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 16:19:35 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Thread-Topic: [PATCH v3 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Thread-Index: AQHc4kaOP3QIQqEFSk63oJO/b3WC8rYNtZFQ
Date: Thu, 14 May 2026 16:19:35 +0000
Message-ID: <CH3PR12MB75489D1484199F9F00620981AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-8-nathanc@nvidia.com>
In-Reply-To: <20260512193520.3109172-8-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV2PR12MB5991:EE_
x-ms-office365-filtering-correlation-id: 298509d2-35aa-4923-0947-08deb1d496f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003|9063799003|3023799003|11063799003|4143699003;
x-microsoft-antispam-message-info: QMarU3h1903gL9JMm4G+ydiOKzZuHpLd6U2Ed17PRxxYlzicxwmwX083KRNMBA9Y1jM2CEo5vLiBqzZIct8ZXmqRshqMmHydlITHlAmvP2VFlVSLBp4SwYHXiXBjpr3PA5O+z7XxYq69IADZPHsBspA67nPJ5Be7NFFzw9Q5d3nxBcE8lRfPg4OcSDzTHDs0eknbtkm7UlaP1540yG007WuxeV1IkBYiFB6Zh1Oo+1Ye0g3AIQ6741nXkLnDCiTcyezqe42iZ4HUrdf7lxPGNnx/bvTNegGVosiR1mTYVlQTd5Qb4SgucQT8hKUXL1xUuNalQbNec7y/HZhcaQ2i2ABFLc4s0cGK72t41C5VuFvWdwOYTqqRsAlSoSWCFC1gtqu9IuipiJrOTiN+UhAXsuIV09Q7KNMcQpdXpCH/OfxUDGTMm0a8B08w7Fb0yLqPqRnzc+nysN0RHWtrMtVpTDDX7rnmR1YTUyNJNvpBG/Fpk/t8sl9OM/i3T/5ao7RmXW/5JFDz7scpj0VxhG2vz3Ol6hazA6zNZFwHRtDY3QluBkELZaG19We/qhnbJv/Qeb0FYFW2Bzl5XseqZ6rQFYdx/v7dG0GE+CRMWJmiqw/IjJgtrbbFozw+k2eTbe8C6oZ2w+gJw2tfJVTww3Kyeyg8691U5JbVXEt8mmFH/hEn20RAPyCThCtNKeKkzX4nUK5z8PzSBWbR8bbd+IRUWmKQz3QWDh1zH873STd35UeSpE93p7IE8Wiqnvsb1Zig
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(9063799003)(3023799003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r8iYjrkpqj+yhT7vQEgx1YqT/iTwxwnedARtwjZhGXkokYOsfcrK/oiu54?=
 =?iso-8859-1?Q?XhMMtmxlgyLzM5CxqSZ4NR+LUBQ3lsSa8wiEKIUDjIJTf/Ec2P4zh5Ktq+?=
 =?iso-8859-1?Q?kooBpfYuzDGC4BCmoK5x8vJ85eS5uzbWMK/VNXwj+wQfFHtlIXaq84fS3f?=
 =?iso-8859-1?Q?TmwRx2C0gjPrlHiKGG578R5dS1XebpCUHnJTRFdIRfcABW1IBuTxYTqFF1?=
 =?iso-8859-1?Q?lvseI2hZUHA1HIlBp8gjNn5kCuNoLKp0sLhZcLmP3LSM5UhlmbY+WXfDYs?=
 =?iso-8859-1?Q?nVxMzA5G0xYxcsqRS4rYlHUO/Mi0zQ9Fiyb20CuNX4pyROlk5BQ/I1lTuj?=
 =?iso-8859-1?Q?JFJbhRO88OhjewKc5tg31s2u8kKOmGDi+uBA/J6a1n0ppTzr5T+/3p0EuV?=
 =?iso-8859-1?Q?4s2ujF/OSq0GTimvrPuaLvmOQKK5EBkqQt1OErvdXEHVFwMm7jxaAj1Vgb?=
 =?iso-8859-1?Q?SvKvCofA2r2aL2UFBXqJ37JhnRy76jXHcYBP7YCl6NYmMl34WD2fpHC9Ez?=
 =?iso-8859-1?Q?/8+wMV+Itly6c28tiU9sK6csyjQq7yjSLZrdm+MViGgxSyQrP00wpRPyVz?=
 =?iso-8859-1?Q?RcuU60MUhUKrEEHJMk3tFke+P6XBQLByk5XQrlyhGVakI6nhyZ8z0hCsKX?=
 =?iso-8859-1?Q?65iaf0r9wGaGGkcWvDtTSJtZMEBHnRJ/abTW3/qIydxSwaG4zkyJ+ZtQk5?=
 =?iso-8859-1?Q?ka5dL/4qnxH6xaOFc09T6LJssemC62awf57JtTvWQ+y/BM8E06d03F4wmu?=
 =?iso-8859-1?Q?R6HPKB029AH3OvahWurAo2bQRdR1OOmHgXz/krlfvVJ5AiqKWx3EReT///?=
 =?iso-8859-1?Q?ZYlw28tViyugcCvM3DbFK+E9TP+gAn2moV8rhvyXoWHTLj6nWDZxzU8QO3?=
 =?iso-8859-1?Q?iKGYyxs2b5a3HV3l4zkRO/GlaHt6dux+Mq7Pvibszm8n0WzuTH/oluzGJr?=
 =?iso-8859-1?Q?SAfSHzt72TDQscWenzj3tmL1UtHCDKNu7sI4AwQw4JSbNbZH5fnJR9/xpo?=
 =?iso-8859-1?Q?BfANGtggPJt+FJcuMkvFYWx2IV1wB1ZJyU3TtL5GhoDv8/cLyEfCLIt6CU?=
 =?iso-8859-1?Q?Gkx9w+QLpANq8aTti8NWCFYZ8/D38cV/v76retlAsEzKh7lVy2koS6QPgu?=
 =?iso-8859-1?Q?YXQl5yE0Y5vqaEj5rlLp+6/Gv4tgFor6rC0fPG5w4OGFA+JQnzEJis5TXj?=
 =?iso-8859-1?Q?4PGXd3WmLRaXVToiTKGc+1BviBb1g7Q0O9ZErG2bmlt/i0gP7fE1oxn6wf?=
 =?iso-8859-1?Q?FZtjKEG78osrjS5l7+RJOvWboxLQgnZuK3ftYwwj9Z4yE9B73xgwg3IlPK?=
 =?iso-8859-1?Q?mW801T88LQJ22R8M2GKG0XZ4yhGJu8Oy8EDrsYXmVl6InkO8iP7eZM0k48?=
 =?iso-8859-1?Q?JOZNv3kYIbqXMH1OJvIZEmCXJrGoQDmKuXZ7RdavP4doKlftA5p7vmjvRz?=
 =?iso-8859-1?Q?w4r2woYBYjKcfzXJodcwtAlwjyLa6xvwbpaa32+gMTz8Q4r9i7+KKX9bAl?=
 =?iso-8859-1?Q?HaiV4qq9wXvZBDQN7X21faGUuDzsFxRCMx2iT3ku9sCME5HYwOjTmLEJFt?=
 =?iso-8859-1?Q?OCbeEnS50r1vwFJWo0ZvYbQNbTblFBTaP2YmtqAA2V8WtW4q+M1N9Z/3cy?=
 =?iso-8859-1?Q?+I86xuz2T6GJAgvJH/vRTurRye1BNqrfsy4oIcwtVxQ8nn9iF/JIZEvVVS?=
 =?iso-8859-1?Q?b1dCJTCNeibI9+0T0ugn2Nzyx3I132eu95HmPeMuWA08XCs5FLqXuir3Xm?=
 =?iso-8859-1?Q?6decQYTj17BGoFzocfG8YRes+OYTiJPNnwUBy9wooxibn6sBQ883VYrhB+?=
 =?iso-8859-1?Q?2ZF1tnipLw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298509d2-35aa-4923-0947-08deb1d496f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 16:19:35.6207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: by3lbou0UKsF9zJzgVA0EQKAfykLCLxP2darmXJXKEPGfw1tFbXU/yqju+jBRXCTZ5n7PzJiXm73rQSmGfx9Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
Received-SPF: permerror client-ip=52.101.46.57;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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
> Sent: 12 May 2026 20:35
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
> Zhao Liu <zhao1.liu@intel.com>; Matt Ochs <mochs@nvidia.com>; Nicolin
> Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH v3 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
> properties
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Update documentation now that "auto" is supported for accelerated
> SMMUv3 properties.
>=20
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  qemu-options.hx | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx index
> 96ae41f787..46b02a1bb3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1291,30 +1291,43 @@ SRST
>          Enabling accel configures the host SMMUv3 in nested mode to supp=
ort
>          vfio-pci passthrough.
>=20
> -     The following options are available when accel=3Don.
> -     Note: 'auto' mode is not currently supported.
> +     The following options will be set to auto by default if not manuall=
y
> +     set. When accel=3Don and these properties are set to auto, the valu=
e is
> +     derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO.
> With
> +     accel=3Don, this requires at least one cold-plugged vfio-pci device=
; if
> +     none is present at machine init, QEMU will abort.
>=20
> -    ``ril=3Don|off`` (default: on)
> +     If accel=3Doff, auto values resolve to the non-accel defaults given=
 below.
> +
> +    ``ril=3Don|off|auto`` (default: auto)
>          Support for Range Invalidation, which allows the SMMUv3 driver t=
o
>          invalidate TLB entries for a range of IOVAs at once instead of i=
ssuing
>          separate commands to invalidate each page. Must match with host
> SMMUv3
>          Range Invalidation support.
> +        - With accel=3Don, auto means the value is automatically derived=
 from the
> host SMMU.
> +        - With accel=3Doff, auto is resolved to 'on'.

If the intention here is to have bullet points for above, you might need a =
blank
line before "-" . Please see how this gets rendered in html format and
adjust.

Same for others below.

Thanks,
Shameer=20
>=20
> -    ``ats=3Don|off`` (default: off)
> +    ``ats=3Don|off|auto`` (default: auto)
>          Support for Address Translation Services, which enables PCIe dev=
ices to
>          cache address translations in their local TLB and reduce latency=
. Host
>          SMMUv3 must support ATS in order to enable this feature for the
> vIOMMU.
> +        - With accel=3Don, auto means the value is automatically derived=
 from the
> host SMMU.
> +        - With accel=3Doff, auto is resolved to 'off'.
>=20
> -    ``oas=3Dval`` (supported values are 44 and 48. default: 44)
> +    ``oas=3Dval|auto`` (supported values are 44 and 48. default: auto)
>          Sets the Output Address Size in bits. The value set here must be=
 less
>          than or equal to the host SMMUv3's supported OAS, so that the
>          intermediate physical addresses (IPA) consumed by host SMMU for
> stage-2
>          translation do not exceed the host's max supported IPA size.
> +        - With accel=3Don, auto means the value is automatically derived=
 from the
> host SMMU.
> +        - With accel=3Doff, auto is resolved to 44.
>=20
> -    ``ssidsize=3Dval`` (val between 0 and 20. default: 0)
> +    ``ssidsize=3Dval|auto`` (val between 0 and 20. default: auto)
>          Sets the Substream ID size in bits. When set to a non-zero value=
,
>          PASID capability is advertised to the vIOMMU and accelerated use=
 cases
>          such as Shared Virtual Addressing (SVA) are supported.
> +        - With accel=3Don, auto means the value is automatically derived=
 from the
> host SMMU.
> +        - With accel=3Doff, auto is resolved to 0.
>=20
>  ``-device amd-iommu[,option=3D...]``
>      Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
> --
> 2.43.0


