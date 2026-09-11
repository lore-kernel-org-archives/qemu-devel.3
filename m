Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2A4C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4wJJ-000375-Vh; Fri, 11 Sep 2026 04:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x4wJH-00036T-9o; Fri, 11 Sep 2026 04:08:35 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x4wJF-0005sd-Bt; Fri, 11 Sep 2026 04:08:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJNRju0sKbs+GF+Og245avGlHCooLWqSOhdi6aa8oRS2QHkbal5dxzXbCPUOd2+20dflH14eXVJNX26ieyrb2TUgprJnLql9B6HJny8VDAAAlrZ2Sq6tEjUf7ugFhcVJgETZfKeLrSg0H3KkindTAecjcyCkaXXMLQarclOocrTA85G2kyt38kiB3EfpfsK3SkJ04NbIq9Y2aKU5ssRcGh9zhXh50eo1YEIRhCL14qYzn7WY+wJ8/Y0Q4yjNg74TVMOHB6tKU8m1bMlQs+MAzgg+nVkvVlG3BGGbVkk36t0sEmAc/r0xt5HVMsfpjZRah1sv2+w0MFCbvzdDndMv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFM8BVmEaWt9NUfXVZMmTEVc3BZO9Z1CUR/ucgfz60c=;
 b=LVlHbT3V55iiCMMudv1IGM5rJDh+vI8OmUpndyZoAB5QKgTU02MkZePSzPBaep5oAZTb01IWNp8GnVf1REK2Blif5IDw4IYx6fTzu1DzoR9yn9Vv4PG8SduMQPxNFCTIZiLZQyxJbaTEQt8RqTRu7Miwsr7S4J7bGldUJiT3jfpwuA2ZE0ewDjPKMD3l9R5CvHVhhBiZjSiv+AxZhuHVlnaslI77DNvfLoQU/egGHOU0OmLcwvQ7cut7aVzBu27I137JUCCpDND9hjJsySx7Bi/aN0y2LRaHDi/hKjWB3hiH2eYIodNY3iIwMc49levSoitz2+52NyXM/XBePXiMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFM8BVmEaWt9NUfXVZMmTEVc3BZO9Z1CUR/ucgfz60c=;
 b=H8rTcHTbt22411iDEuoMDrDg2ZQYEhKDGN6/rQkxhMxzs2KZAcvSF4L5YxIZv5NJPipoA25DFE0zsZQ8/Jdt9rSKKL3kqYfFluo3FRc5XCNhzVJM3pkL3EhgPeFivrqVffGBRI3HsIfzncwpIYADOHZQFMIa7buCRX96G4CeoJyFnSHJ/cKGE8v8tmANMfElYzH7iSiOPbB5Gj8WYKgJ5YmCD80OB/PeohKjtNAJqYi1yNx2OHzMt2NUFVsOpKMcVi2AgSoIVSMsohX97FXcRvHkzHe0KRqajthxmfG+HZDEmfX5xRyVOyIvZrYPwGF2aFsNeKdRC+aYp7dCOLVgCg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by DM4PR12MB9735.namprd12.prod.outlook.com (2603:10b6:8:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:08:24 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 08:08:24 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Matt Ochs <mochs@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: RE: [PATCH] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
Thread-Topic: [PATCH] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
Thread-Index: AQHdO9SohY1X9agYBkGRuAXMJuEbrrbJDJJQ
Date: Fri, 11 Sep 2026 08:08:24 +0000
Message-ID: <SJ0PR12MB86145EFC09640ED159B199F1ABBE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260903184710.2052780-1-mochs@nvidia.com>
In-Reply-To: <20260903184710.2052780-1-mochs@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|DM4PR12MB9735:EE_
x-ms-office365-filtering-correlation-id: 996a2cd4-942f-468a-9e85-08df0fdbda43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: yV1g1JhCUQ5oGIkce/mG/LwVbVfBmHy8BVHtN+UfT6OSLkg0qOOv3aguiQAB75zF+2oEnygF9OPQ1pipBjBP9jTCMGFDgzpPywA8zhdA0E5tJiTYjU/yHsyL4MQmmH6gWLtzat6FMZg+eKdMKcnKXoD4+vTQVV+WmtzetLQ/Qf2JVr48sfa8REbGYqAgm8WjeO89QVYCrmHrpCZsb4EW+toZYdw+NnrCd+sbJpnawARuwbiNxSXlWn5o04duzgdKIdmrpoWVEjVNi1VUm9FXyMW+IKAluJhA6wlBNmgQA50cvL5D/gtSwk+cTH1DH1AvnWcUiADs2jQC79WCHh8sT6p5tJWjdlOGWW72+q4gNY4wJuz1PVaA1g/yCFdT3HPx23NTZj+mwUam/MwOtmEEkBEzsGP+jN1Y9j1NVCOBNiO1PC/zkJ2/zZAoDam2Cx6FDZnyDybfgFlpmpJBLMGiYzKH0I+5KCDaqi4Ef25VrEdTp404KsKthmLpiLvfLJAbPym/rVTKx+zNdsYuXuY48rDdrwzA7F631DOKI9uY1bag517AyFfDEUqNA4lH0yXNpMkPTZ3iVkEG2nBV8dFpO91+EXOCBUP5OXccsb41ho3+iF8KOG1cOHWAnGyfDFfFDZ3uqQjtiYaOuHxi9/aTPuY2reBFDqm5lFgavYl21beAyBAqt1xp+oQ+09pd2p7q0x/dieldYwoiQQXFHHKK3CpB6h7Q0VQNMfMRsLffvLI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9xwdjp6dbXjjn1tNhxkUap5QVY9wF/MUc4fSwqSBHv7pYOqPrP1O0RxOmUd0?=
 =?us-ascii?Q?LJmaLK46FXnhZ6rMJKHPBDzdN0RUrow9gLkyfZgY9OoO5TzwRMI3eggFizMg?=
 =?us-ascii?Q?U8NYZY9K6Lby5eoMczoXbpXVTgtejehkYmEbL6XVTBxSNxSgeLYZVWEPMpU7?=
 =?us-ascii?Q?ANaO59XtQ5YAiVlv8hlkYiSvP9WOtTEkI8Uzwk5g2B+qWkFE6RlUxPEGLedj?=
 =?us-ascii?Q?8m0qpm2N7BzWI528rpYDHeZmu69BZNV3zSBVzWx9YxA6wU8GE6orYn6X7GDu?=
 =?us-ascii?Q?HWqky+u8smquOWFw7uARtdtJkWpHxT0Ubw02ikJOMsXjW0QHc+6ThofrrYqj?=
 =?us-ascii?Q?UnbJTEw6lG8+jPo8VOQPnurs4x4Rv55u64bf9oI9o6NOrkFZqzKU54K/5F4/?=
 =?us-ascii?Q?n9V6DGS4up2xScMbiC2BYsatks0PL2BQMT1vZRg0LvyY/VRop5GOeqsFz/89?=
 =?us-ascii?Q?v8weUypcxgmih8G+gZVKDVaEKBPk0oFOXkEf7XZKq4Y64WqaqdPP7ypc+SXq?=
 =?us-ascii?Q?kuUjJTnYvaFOWjNq7hxoTdDngiv3dQ3JgJsXWhmNFHSEiWDf9yZguarRXxjb?=
 =?us-ascii?Q?BF45yl6b4RXVULV3dqN5WHh7c4+1MIlA+97yHgY98afvphe+mGbyJmh9G/Q5?=
 =?us-ascii?Q?RRbV4YWFqWcvzWYHk1bpf3b97P9nAe9q+7PxXqqiX2Db4zB6NnxzPfFnacn0?=
 =?us-ascii?Q?gyu2AfoRcHSJrPummFPRlUrQjFta0TnxT3Pa8X1Tz2gcsb7NbYxrx+JqpbjO?=
 =?us-ascii?Q?QcuS/5NSLiio9gOovadzzuYrtE/Jqv+m5v8x8xqybqwf/xWrLaKE523WArBI?=
 =?us-ascii?Q?sbZ1CGueSkTqIK48s2vUkBTHZ36sZNlCM/p0cLqpOWV+gI5fcpjp9zX91glH?=
 =?us-ascii?Q?8x/sRhZ67g6oBIRVvUFqBZpMYhF8493juO3ZVsNsP8KViCLQe2x9who6E5K4?=
 =?us-ascii?Q?rCNwI+cqhXc/mxdbuwuk0Pv4SGDkJxuzcPC6r6uysEMUY/LSlCGz1JVFSmfS?=
 =?us-ascii?Q?R4lwVFOkvBYC1rola2hQStoq107qZq3bZz69rwCOZ1vN8K5bd48EToM4f0Hb?=
 =?us-ascii?Q?xujq/4VMJjqlLxqHWIdpXEwYuPltDp6b1fsBfcR3uJY3SVMeSqGGSZNCL9Tx?=
 =?us-ascii?Q?KqPIfnaBNaE76R5RPqEjQoo62BaUu4nC1n/0OV30Nl6LkT6iU9RY/zGeZ7V8?=
 =?us-ascii?Q?dQakYUEdgYr7xyIuektPG0y9O8icfjvzuQvtMSVNxSH/q+HeH4qZrPqRCLFh?=
 =?us-ascii?Q?RGwkw7+qsipyLP8Sry0DGNHdd21qGDP1/hmonLqEouZDYqRRwvWu5wgPBzke?=
 =?us-ascii?Q?OP0R4qHWOwQS8QHoYIpZfJLVBnVJGr6kGTQTcFb2LT/6gdBmSpRqCLpuMGLM?=
 =?us-ascii?Q?14bvjUbhleT5g7h00rkAMqFKroUemBs097PaCL19/VLmC2QcbH3wL7U/UKDC?=
 =?us-ascii?Q?/lryKvOtTNPnY9Mldli6F8MurCcJz7MtwROhJriosSNrt0tMhIj0RoUdb8zL?=
 =?us-ascii?Q?xp7SIU3932OpEeEFNWYzNlsuz2uEVPEta4NOdtM48wZ4nOd9QMDgNoh3CuAF?=
 =?us-ascii?Q?tg7BUtjoJdS6a431zyph/64gwGFBMch6xr9F3RLW1vMLiwNzYegbZKKbAD1M?=
 =?us-ascii?Q?pKCbvR9MVxK3O7vlCD06c4NY2iK/D3vXIBcHcvkAGjHGePCBRnclRWvzeW4y?=
 =?us-ascii?Q?1qALLc/X9vUHogYg4fveZiKRqLA06P1J23WmMknfv9MiLTRdLoEgfvmAyoKJ?=
 =?us-ascii?Q?YAeptzJpIQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996a2cd4-942f-468a-9e85-08df0fdbda43
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 08:08:24.3561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TeUHIp97j1lUrBPylxDfyNjIzyPZXREuiOwV4Fwdn4kYQroQjzQqvfKU82p9uPqXVaq97A2cT+uU7FJZYrgg7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9735
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
> From: Matt Ochs <mochs@nvidia.com>
> Sent: 03 September 2026 19:47
> To: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org; Peter Maydell <peter.maydell@linaro.org>; Eric
> Auger <eric.auger@redhat.com>; Nicolin Chen <nicolinc@nvidia.com>;
> Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> stable@nongnu.org
> Subject: [PATCH] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
>=20
> With CMDQV enabled, resetting a guest after it enables VINTF invokes
> the VINTF page0 unmap path. The resulting crash is intermittent and
> has been observed on the RCU reclaim thread as:
>=20
>   reboot: Restarting system
>   double free or corruption (!prev)
>   ...
>   #5 address_space_dispatch_free
>   #6 flatview_destroy
>   #7 call_rcu_thread
>=20
> FlatViews retain raw MemoryRegion pointers and release their references
> asynchronously through RCU. The VINTF page0 unmap path removes the
> subregion and immediately unparents and frees it. An old FlatView can
> then access the freed region during teardown, resulting in a
> use-after-free and heap corruption.
>=20
> Embed the VINTF page0 MemoryRegion in Tegra241CMDQV and add it only
> once. Use memory_region_set_enabled() as the guest enables and disables
> VINTF. New FlatViews omit the disabled region, while old views continue
> to reference valid storage.
>=20
> Fixes: 5965b81ce283 ("hw/arm/tegra241-cmdqv: Use mmap'd host VINTF
> page0 for virtual VINTF page0")
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> ---
> Reproducer:
>=20
> Start an Arm virt guest with one passed-through device behind an
> accelerated SMMUv3 configured with cmdqv=3Don. Add an HMP monitor
> socket:
>=20
>   -monitor unix:/tmp/qmon.sock,server,nowait
>=20
> The failure can be made reliable without an ASan build by starting QEMU
> with glibc freed-memory poisoning enabled:
>=20
>   GLIBC_TUNABLES=3Dglibc.malloc.tcache_count=3D0 \
>   MALLOC_PERTURB_=3D165 \
>   MALLOC_CHECK_=3D3 \
>   qemu-system-aarch64 <options>
>=20
> Wait until "info mtree" shows the VINTF page0 region, then reset the
> guest through the monitor:
>=20
>   printf 'system_reset\n' | timeout 5 nc -N -U /tmp/qmon.sock
>=20
> With the unpatched binary, QEMU crashed on the first reset with SIGSEGV.
> The core showed object_unref() called from address_space_dispatch_free()
> with the object pointer set to 0xa5a5a5a5a5a5a5a5.
>=20
> Testing:
>=20
>   Unpatched, one CMDQV instance: SIGSEGV on first reset
>   Patched, one CMDQV instance:   100/100 resets completed successfully

Thanks for the test results. The patch looks good to me.
One nit below.

>  hw/arm/tegra241-cmdqv.c | 22 ++++++++++++----------
>  hw/arm/tegra241-cmdqv.h |  3 ++-
>  2 files changed, 14 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 273633e62937..29123f6267fc 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -131,35 +131,37 @@ static void
> tegra241_cmdqv_reset_vcmdq_cache(Tegra241CMDQV *cmdqv, int index)
>=20
>  static void tegra241_cmdqv_guest_unmap_vintf_page0(Tegra241CMDQV
> *cmdqv)
>  {
> -    if (!cmdqv->mr_vintf_page0) {
> +    if (!cmdqv->mr_vintf_page0_initialized) {
>          return;
>      }
>=20
> -    memory_region_del_subregion(&cmdqv->mmio_cmdqv, cmdqv-
> >mr_vintf_page0);
> -    object_unparent(OBJECT(cmdqv->mr_vintf_page0));
> -    g_free(cmdqv->mr_vintf_page0);
> -    cmdqv->mr_vintf_page0 =3D NULL;
> +    /*
> +     * Keep the region parented: old FlatViews can retain a pointer to i=
t
> +     * until their RCU callbacks have run.
> +     */
> +    memory_region_set_enabled(&cmdqv->mr_vintf_page0, false);
>  }
>=20
>  static void tegra241_cmdqv_guest_map_vintf_page0(Tegra241CMDQV
> *cmdqv)
>  {
>      char *name;
>=20
> -    if (cmdqv->mr_vintf_page0) {
> +    if (cmdqv->mr_vintf_page0_initialized) {
> +        memory_region_set_enabled(&cmdqv->mr_vintf_page0, true);
>          return;
>      }
>=20
>      name =3D g_strdup_printf("%s vintf-page0",
>                             memory_region_name(&cmdqv->mmio_cmdqv));
> -    cmdqv->mr_vintf_page0 =3D g_malloc0(sizeof(*cmdqv->mr_vintf_page0));
> -    memory_region_init_ram_device_ptr(cmdqv->mr_vintf_page0,
> +    memory_region_init_ram_device_ptr(&cmdqv->mr_vintf_page0,
>                                        memory_region_owner(&cmdqv->mmio_c=
mdqv),
>                                        name, VINTF_PAGE_SIZE,
>                                        cmdqv->vintf_page0);
> -    memory_region_set_skip_iommu_map(cmdqv->mr_vintf_page0, true);
> +    memory_region_set_skip_iommu_map(&cmdqv->mr_vintf_page0, true);
>      memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
>                                          CMDQV_VINTF_PAGE0_BASE,
> -                                        cmdqv->mr_vintf_page0, 1);
> +                                        &cmdqv->mr_vintf_page0, 1);
> +    cmdqv->mr_vintf_page0_initialized =3D true;

Do we really need the bool mr_vintf_page0_initialized or can use
memory_region_is_mapped() instead?
Since the region stays a subregion while disabled, memory_region_is_mapped(=
)
still returns true, so it should work for the "initialized" check, I think.

Either way,

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer


