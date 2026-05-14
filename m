Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A51FCD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 15:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNXjW-0000Eo-Mz; Thu, 14 May 2026 11:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNXjC-0000Cp-Gi; Thu, 14 May 2026 11:12:00 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNXj9-0002fS-PN; Thu, 14 May 2026 11:11:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl4Vhkb9IFrrwHN5D8QUFbhunmQ9wCi3bxpyLyQbqdY5wlp64Qlozp3E8DLHAqRHob3t3loX/MNz5YLmKAOBoIEU6YilexcOhXUlm+oiVcXvTqMf4ckOHZVrisdHeDhby+sJ7qaiDV4AIfIWQ1GxS4kGZh/p3AxuU49NzwFm23F5qtCtH0hW7dJyapVqywCDT6XpbtvwdknKuBHpxNgIIqXq9QoIqw4ZOmuv5bV/70+45s8sk+tRdGdmL/8l9obzI181tat3IrmxwyDQu3aptB8QGOP026emTjJYZt4WJslOv0JIl0bY+w4XoVALnnWdSuWTVNP2HX/v22cqv7tqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnKmEJOQhNLip9kbY+jfmVSI4uDbs8KqXed0mtXghiE=;
 b=mVCgYCY4n36xfmiV+N68Ndav0v7D3UPZR8T4HwseFmO8bkqDcnUvACD6SiY2HMtwsDZcnBlyhln741yfeIIBhEZfGFvf4tKXGbQ7crTRgHzTqXHG6N+YpUY0XTFAhs+0BTSvINmGs3d90Ek5h0IWDwOM6PV/120MuGrCK/CGqGpX1eEzQhlcwrbWFEaW4fJkikmquxj5jI4xVF6GWDg3lnbhVvjkqlTztj8ynkahfBELHoJ2YJIeoH6Z5SV1XR3HNT4CQYN4bqaFWOQT3yDc9X5eBBL247gOdXxjRQbgXhiP1SGUzc1Vk//I8qHjSqZvx4lOet8jmxqhs3oWg54WLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnKmEJOQhNLip9kbY+jfmVSI4uDbs8KqXed0mtXghiE=;
 b=qF4l+j6mg1pX2qhQeAfmJA/rArNt2PPwYjxVuyB9Q8penou7l1dxFdZnBpmwMU9AqGIgBYq0JF3QOHIBCySprmkCAL54+K5rKUxorPkSJWGuzBYOkmlQ4IsoiRQoS7epHVToS7lxngy/WQbZuIQdJZc09180iOQboVqbylPsHdxj8L52T12XdAcEoMhM+OcyJbwYaTroK8EohzdR5FszAqgI7sPOw5jM1I7K/i7+Nna2tmozfb67vnILCyafFhtbbeEb5mHlWi08igNC3DBWIYwLtCtJG2Sbp3HsL4xXW9O+oXhPYRodheM/ROCxUf4S37Xf8J+lz2tHbRINt0SZGA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 15:11:48 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 15:11:45 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 5/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "oas"
Thread-Topic: [PATCH v3 5/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "oas"
Thread-Index: AQHc4kaMoRQPbkY9V02VwknLLwYKvLYNo0ig
Date: Thu, 14 May 2026 15:11:45 +0000
Message-ID: <CH3PR12MB754815E747B39D3F57054BA0AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-6-nathanc@nvidia.com>
In-Reply-To: <20260512193520.3109172-6-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MW6PR12MB8914:EE_
x-ms-office365-filtering-correlation-id: 0a3317f2-3fb7-4214-9586-08deb1cb1ce4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|11063799003|4143699003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: SHSbRisAGxZbQT3gRvTMNv4luGyecypRX4kJNxOKf8cZvwGfAozWJZN5OHeuEXeKQxn63xDoiSQMBEwTPIQ6wR+dSDSCWR/IrzkA3ycN4H+e+BH8qFWrgrLNlbCsZUKWaFY1e8GbAYw/cSEdw2cCYS45gKkai+8/46S6PSob3jlmDavgYUATO1+esmzGX3MTDEsE9sr3kc8RZvDFlDHY5nEYyhru9tGAE36UEApC+HENZpApfqC6y5Gr+IEi6mTXz9WwWQimwU41Z+IclqTuLfh/RU5dxxAHGwxkfk4xCGxt1QJn51s9LyqyDj31F/ZrkGc9SQvVHw3lqnv624y8RbV2fSDC3cHeL5EYeFxhe4ID4PM7KRS03ZnsXtect/Lk4Wj4c9LfvCdr587oRm3X1JbJl3YgKoNQTLoe8qPm1Y6mVcrAcSaW5TRXSoMlhSdA7bNqBKnCtLpzZj2VmlQIBBOLQL54KJjd+idurienqLo7UEmXdQMKnHMKX9JVre4Ydkle56cQBNfiohwE3wsKyMKwn7y6GNCCOjHeeLm9Yn+oAU4Ds3BylHxkvfP0K3Fz5s8JmnMC6oqOa+vLCpH3LMadw1vqmhUM7t3GVAqeqNEWtV6nQ9zs6f1sCWnvajJrCMf82a8H2EUqBlJyMM2aQ7VbLb7yl0KhdMZ6Xe6o1e05p9Y+irM6SDq9oe80S5UxpLsJNtBBhGMptb9mBNCHnRE83Igx13RDJ8l89FEjcjZGJ6tEech/K1vxOzITeZH7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(11063799003)(4143699003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nvCF5h96324fOImtQ+zQEwrxZPA3h+rE2QkmwNVGZCFCy4/TmXWanfMGh9?=
 =?iso-8859-1?Q?iH+0mEQWyR3Pa9+FZ6eQDueqE8GgrNCIELfjVai7hO9bEIh9ihDsa4y2tY?=
 =?iso-8859-1?Q?MhQW5EFYz+DttgEh9IofASFTIw4KXIUvhUd7Xg0Cp8GtAqAVGRHa/meJuA?=
 =?iso-8859-1?Q?UybsZt/zdFSplbGJL8yQtXTaJQhZRrNtRI1+5yYbrxIV0w4Mv8v30hNR5d?=
 =?iso-8859-1?Q?CJOg8ToijCNp9X5MO7hl/wUzjF4YuP1ULjxMdfmFga8GCyAEU4sWHAIYiF?=
 =?iso-8859-1?Q?1ton+mUUDJ4xDKBgH3V5H1PDcjDYp0VdFjXTJr4Eo4RBNJo3BAxbc634Rz?=
 =?iso-8859-1?Q?ji8IbUGXON0EEEiCDagAdN53R9UUz62c4JO/bVl23YPObbac3Cgn21lsN3?=
 =?iso-8859-1?Q?lsIt+TZR3L1kvt1QjRW7Gl5H1l0LIkwe/7nhVy/INGmIxnQvuOnL3kgHhl?=
 =?iso-8859-1?Q?/C6bylBrF3fxpq+S/hEwB0jm9Mrpps5oJ9Fd55Xapvtyh3nhpC8bf8P4ka?=
 =?iso-8859-1?Q?6ag1yUDNJWfNTmTHX2WJDwsRylLYU812ZQMcRCBazOgXJF/24qJOnNGPq2?=
 =?iso-8859-1?Q?ZdWCr7vO7PEZfTsyamhR+G3Vcf3TN/bBPuE3Rb6IE+uBk0jbya9kx+vheJ?=
 =?iso-8859-1?Q?1GSL/ALEwwasVzGMbaCpdxqUt22jIDCbbNl/ShXdVg2KKimi9I2topcOTf?=
 =?iso-8859-1?Q?RmH/IU2HCJOD0y+7AuOECfpFoRT2FDHTE5YwOKUMfjWF5p9WHlkigMvdB0?=
 =?iso-8859-1?Q?J/uARVSFNuBTRUkR3ZnIUcrAAGl31YPWuG1dp77S9w5BEFWFqgVuFUgktI?=
 =?iso-8859-1?Q?VormhHs90JONSeuj5sKwuRbWeFE0vUvlnMrhIbV1hWXWwQdULexvFK9Ov7?=
 =?iso-8859-1?Q?L3Y2fDPl47hduqyiwRxEZlMTvCSZl3jS1B2J1KTVPJ282XPAoZovwuDL8I?=
 =?iso-8859-1?Q?wyGyZP0fVCxE6mJrCalP4e4krOC1/GxYJuFyIKHS9bxnBbdx42kwuS7C1d?=
 =?iso-8859-1?Q?k1oKOMCejTQyEJ+SWOGxA3YsniGNE0JBr/LHiJ/N3hLc4X/L2QW0c+q+wk?=
 =?iso-8859-1?Q?OBW2NeFZGPrlbuy016XUcwuErwks3toWKCnHwsX7K6lf5uPJrGCRIVKJBR?=
 =?iso-8859-1?Q?Gy0JtzPfOrDsM+McAMMRlF87l+yp3iKQtFTBvsyKngO8I7e6f8N9xc18sJ?=
 =?iso-8859-1?Q?RK3OrQ+VJqyz8Z8gdbUPCSjPwYvnwCnAjFqJaKGDyZaOKIlrBRDSeb9xz2?=
 =?iso-8859-1?Q?kgeyW+J9RJoq8Zqw0Pf7dV6W1aJXK+3jgxoc05tGvefOl5Uq4vepCkeXhH?=
 =?iso-8859-1?Q?WVlDZZuHnxDZzred0nxJFFC5iuqVsFD64FcGwzPGvvGuFm/XMsv82ddoYU?=
 =?iso-8859-1?Q?8uvW7q6CVf3gpx3Xo9oL3A2UFAATYoAt1KgoQZnvtjdSJ64G3sItnk4OQ+?=
 =?iso-8859-1?Q?hjvA+lp3f4gztGR+Rw/YXFdqpHT5WVE0Yp09lXyAwkIuhyQ4RdrOPb3yX6?=
 =?iso-8859-1?Q?SNmdKPd3KQSmpbvEuOcAubNPGnlYNSauvl8DaHKBzQ3vqqJBhKs1klPxqa?=
 =?iso-8859-1?Q?QCEt1Ogsgo1yRBkV89bR/YxzqIoN7VkFpN6QOmbv7tmGxipDqIIJB3jD/c?=
 =?iso-8859-1?Q?XZiuCf9HdELZxGXVPCMAVAMvWp0dSfCgHYlHXq5hSRDVsJKYMSuhY8Z98J?=
 =?iso-8859-1?Q?pVTaEqSw4rDX2AoE8LK3LkiI0ZCUONiF/dOFeStgvCEGSbXdxd8JxYIopt?=
 =?iso-8859-1?Q?yDGnENc8NAW4bCPonpdNWgsj7fqqW8HRF68he58ZRbYgcwzLOz5CqeqY92?=
 =?iso-8859-1?Q?xbu3KGKUDg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3317f2-3fb7-4214-9586-08deb1cb1ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 15:11:45.3924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kJQ5BEApC8kuWgsgDK3oGwP/UHnK4XBhb4Scw7cqOJ8v0ff/T3srju8IYiNqk/stIP4Szxszqssu1ododswFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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
> Subject: [PATCH v3 5/7] hw/arm/smmuv3-accel: Implement "auto" value for
> "oas"
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Allow accelerated SMMUv3 OAS property to be derived from host IOMMU
> capabilities. Derive host values using IOMMU_GET_HW_INFO, retrieving
> OAS from IDR5.
>=20
> This keeps the OAS value advertised by the virtual SMMU compatible with
> the capabilities of the host SMMUv3, so that the intermediate physical
> addresses (IPA) consumed by host SMMU for stage-2 translation do not
> exceed the host's max supported IPA size.
>=20
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer


