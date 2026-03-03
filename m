Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E122E67A96
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 08:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxL20-0006kx-WB; Tue, 03 Mar 2026 03:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vxL1x-0006je-0M; Tue, 03 Mar 2026 03:23:02 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vxL1v-000208-BK; Tue, 03 Mar 2026 03:23:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRemmH4TpnnHDeEPPUjcY4Nm/9sg4ThIBfkpl9HifUpcM1dGyM4iechDmqkI4FCEC8VUjjb29QUtG01TDygUH4J/tolPb8s7B73pJMr6s6dVDTl6E4DHCV9I8ilZx0CYVNhbn600J5ZqZwNfxnSYPIF+k7KJlH6cHGoVSvFPCuNWRWgRRfz0f4rcAIMtKhtHk6w5Gmu6Xj4yiYl/0H2Llzp283GzEFEWNbOOQhd8XL6k+LRtHUlbJZcq1o3fkPxLxdo7I0rV7iG+X1Rp8SYwebe4xLMXRD0hE/1YdYCF8FSeLw2d9/Zl4zAj1qfVwRTjxXJPiHjWxQ0+SiCKdCOXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a11sNlB6F6JYuHI9kEsYPjCQLI3NizDPuLPB8b6eDag=;
 b=BQ3IXOlIcmyjXy4iIv5WFLqQBoNDiIcqupB4R5pscjhOBHUjRj1z2SRd8dHsExg3P3AMMxCFXQ3WBa7kRkAE+FuoX3H173fAN+DC/k+ZA60PvoZPIL/JB03dAsNT0cAlVLfSnDwG6Km0bR+z1YA0VpXJxoOF++GfnDcKJ+zRmCW8j3VUvNImYibLLExG9S0qS7C3UhREjuAq1/3k65ckJBROEEOq6KOgyQv47UxRNRoPHrfv3afCIXy1WcgLc24l9f+ZeqT2ti3ooJxr/5EJmptF3T0Dpms1bDnYB1ZMIiLk1AUly/B6kR2dANz4c9m3iE9aV4Pg6LjQ8mDMko9qOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a11sNlB6F6JYuHI9kEsYPjCQLI3NizDPuLPB8b6eDag=;
 b=ckSpXktlLHiT9KSBnxD9r5CApEeXHPlQ9xoNr7nMQF05j4Gxc+iojh1ufxDaggdyeRyGrTHumqR18ijmWvmCiUn+4aCpjgYIcttCtRAorsvyLp9cxp+sjCBLK3FhA0oE9X23hXRtH+MaNbUYzpaTcyhnid9PdOB0uPCXFldZ3xjVLvABGlBljj/ks50RMuSNWy0kWZJ2lZgbnLmGHPJFSfRO7wwq/vCgLedVp1J3by0Cx6PBFUZpvotifsjLFop5t+XaWELOW1k5yV5hgjoGghmf7E7gTi6Pd6AqWcRijjr3i+h6BQOiQOS0iymEgVp2SU4aTxAMD9srp7LnC7Zk0g==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 08:22:51 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 08:22:51 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "philmd@linaro.org" <philmd@linaro.org>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v8 0/5] vEVENTQ support for accelerated SMMUv3 devices
Thread-Topic: [PATCH v8 0/5] vEVENTQ support for accelerated SMMUv3 devices
Thread-Index: AQHcpvxKhGTEzUemxU+DutzCxafRw7WcfjJg
Date: Tue, 3 Mar 2026 08:22:51 +0000
Message-ID: <CH3PR12MB7548985B33D65D626DFD840BAB7FA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
In-Reply-To: <20260226084456.112142-1-skolothumtho@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA1PR12MB8094:EE_
x-ms-office365-filtering-correlation-id: ed79a484-9078-484d-b782-08de78fe0fad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: PNI3Z9v6apDN5jkeukNRsRA6QMbox3nk5wEXcBD9LKLI9ybstOVEKUSGqCtFCaBcaStbuAOT/g5JhAFH1cyPTOw5g3ham7uP5jujqRVgXaNMSv35KfkgHfINSLGUT5kllssKSvVJg3wqYpQzB34Zo1wy0C/GK3jBGBgS1UyWoAoyabt5E0Uq5S9a8CdWL/NcHpv0mIHpRJ1cfMgj9kNjutmuGe2hJsHCXQGasrzeTDUj202X3CxEwfv2RBHMU9iEBMqtBvx7jdWdNHNuAL7Ml+49vvYFWyEU77BbINkcTGbCczWh00nK8g7u8SelEZ1cMBfmSrTy5/eB7IbpkzHRo6ZJgxmJWoZe0PCJcG4bbnbBL21keliUIRUL/MiUErC1Cu582nDIRQU2ujl1s6EwUthonuQL0k8h6dKFPra0tuLnXkh9HGOq8/qImQaq64SEjuGKN5D4GLzuWIO/9AR2x7DvSEJcoK7bAQgWGDLvesedeRSaDfYRwLgfaGGuFrIMskxR6fd7qMg1EP6sw1Xh1i14mPxWmkFWwMxSLMfIdf90PIabyGQhmsbhExoR/9UOkdnWG747rQK11VhMkZRdwkxengbuycIDVHNa1F/ovd7bbYtDNqsgJ7kQQRBXx7PbUb5sPgmRFP7XegRO5dQ+7l9auxT0VcIIvhve0Tn4ApE8TQEi+fRhSI5yoI+2rP8qPHrtx8CeaH31LHDbA96LQQemCIcfnG/yM7t26JcFRPCxOUR5TUbf1SkWiUT3CVXcjzkmrFm7TL0fZorD6Uy7YWaOoqZywzadYIGQNrA2a2c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9HAOB9arncBoLtwb6Ti9iNeRJ6sAD8bkrkWfOmnDZq/TjI7UoHnjgVf2M4YL?=
 =?us-ascii?Q?5KM092DBEngWjMnO9zXnMr5uzGryyuS1s0tvDq43+QQ/WOwH+2Y74a1h20GK?=
 =?us-ascii?Q?xPaCFiAPKQykKi/EKLepBuYadcxcdYM4BSiaUl4KNGCOa9qse8Gxx6oTMCRg?=
 =?us-ascii?Q?u4ZI3v3xfmJXmjRFSj4c+yfSHRlsxzyEV9AnngMcMvx7ge7k/A+9d2MBbiAD?=
 =?us-ascii?Q?U6ri+Mhc2b4RUwMAZJLHozdywGsX3Hb2Zq9l5/g4L5bveUv5pEXxAeNhD2lc?=
 =?us-ascii?Q?tZXJGoFnMNuAY7jUmxHu98eXaWrVhbpp6Zl4nudVEagmB5dKHdLgbGTpvdNo?=
 =?us-ascii?Q?jDuyEtj7Ot+BeQKFOeovDfnMJOlLbzft2zpUFPOEjKkfNZc8A0M76z4USrM0?=
 =?us-ascii?Q?ik0896VfTWXesz9gu7iSJaVHERzDP6nPS9rBXjHmO/ViexMF2YM9OPZDgaef?=
 =?us-ascii?Q?oqwZxXL04mOzi4GYjZcsCxbHen82m6bF71EINzcQqccLYLjFFXu0UGHEVkxM?=
 =?us-ascii?Q?38KGDbe9uOmlJGQGtIMkQe/whoLqbFo8amRC6rEgU3UVTE26dVRFsrzyMvch?=
 =?us-ascii?Q?E73WW9yhJFjOhkHU2XtybttUkDX9Xfgrrc9JzhmkWSiXZgiIYOxt8EpQJ29b?=
 =?us-ascii?Q?33jnhnG14dum7CLJoJMbFCOqzvRYtNwkGcNI6f2Rn3QjXP25SmER5vj5rEgs?=
 =?us-ascii?Q?O1Zz2HvIfNp5y28EY3pPY5weRVRxI7q+n3zyLEZuri4/uZ00juDo54adD6Zt?=
 =?us-ascii?Q?uN8qqYhmOGdfXw3IEGTJk2g7rvreSAMsbm3SnUOnxwJltbptHhXgMkGh51s4?=
 =?us-ascii?Q?rZgaFBIAle3BE1RegFlLAf0Jgdp2lWAhbAUZQKhkPvdvZ9Nk3a39leJW7giX?=
 =?us-ascii?Q?tyVdaZHEvkh0nFAWdGe3WG8S3MrFCD7pCLxu0PJgQMOgb4U0XtPVWdAH5GOC?=
 =?us-ascii?Q?EP5Nps5pyKkOxG4YFkfg/5ujXkbb3LtiKOE5k0ZVwoTeQK3sGIAqgJmGXdt8?=
 =?us-ascii?Q?pSZPxyJtUISLQOLlhBkh+Tri7RzhhYmr7FDLircnnKMPS3hA1P+SDLqHSPfE?=
 =?us-ascii?Q?A+jZOoyFDWvOjbi5DDaYfoN6fyXJwFODUwOOmedS5b5NZjMH81QxQzIM0end?=
 =?us-ascii?Q?lVz97i9SHDlrywBQfaMAUtQczcKwit/0vxdusEiJ0p5cbOrYGh8VBEPIguZm?=
 =?us-ascii?Q?ppedNaA0cyeHtNerYi43SD8UG/UBD9ZC3sxY0C9UBrv5AjRuQA0yR8xewLwJ?=
 =?us-ascii?Q?rJz5fNOl75hDjUlgr86+gFiNdTwhADehxK8bvTHQC49wcOunj4IJrXMQ93jA?=
 =?us-ascii?Q?kd32PH6zBSpTsYzhf7T1h3jhxI0AaqO4mBMfSEu13uFfBXcyI6S8T54en8DW?=
 =?us-ascii?Q?iAcDEcgDUP2ZjV9aIGrgoRYW286duDUc+70uGU6wgG9/fyv7N2mEG+gKMXE1?=
 =?us-ascii?Q?SFkUOkuASDYVjJdZhMx/Td+C+XYxrIfIeRVSUxDIgiwwRC0rS74Y/mmFRRxl?=
 =?us-ascii?Q?w+3gK1LVpLWONqunQypL8ltmO5lP1IMd4vkX4Syy3EL7L9Zjflp1r+hNNEg3?=
 =?us-ascii?Q?gYE04JvVNLa/PSY2hm4T7o61TNaEAdwTWONJk/9ICyw56roMVsTxxEWshA7x?=
 =?us-ascii?Q?8B2cOtCbOYYIcaRASMzm7jgTP0w+lGcHmuSK/bzIKHA8WZTCsdlEsmwf63L1?=
 =?us-ascii?Q?OI/zxeI9OpjuGYfyIm4QdMQJW5OX0LcYaBu0/xq4YvCYVfBax4BjBeMlLTQE?=
 =?us-ascii?Q?Ggw8D1E9Ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed79a484-9078-484d-b782-08de78fe0fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 08:22:51.3180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7AQgNoBC5tBqFCbm0UwfS82EKr4DojC4qNgKl8JxIQv0B+sVXRvOnKvK8QGdoQDuX4Y+LDNCngx6FMs2QYNZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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


Hi Peter,

> -----Original Message-----
> From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Sent: 26 February 2026 08:45
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; philmd@linaro.org;
> Krishnakant Jaju <kjaju@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>
> Subject: [PATCH v8 0/5] vEVENTQ support for accelerated SMMUv3 devices
>=20
> Hi,
>=20
> Changes from v7:
>  https://lore.kernel.org/qemu-devel/20260219090103.33697-1-
> skolothumtho@nvidia.com/
>=20
>  -Picked up R-by/T-by tags. Thanks!
>  -No code changes. Commit messages updated to improve descriptions
>  (Patch #3)
>=20
> I think this is now ready for 11.0. Please consider.

Just a gentle ping on this.

If there are no further comments, please consider this for 11.0.

Thanks,
Shameer

