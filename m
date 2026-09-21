Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA034C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8c1X-00016G-QR; Mon, 21 Sep 2026 07:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1x8c1R-00015u-DX; Mon, 21 Sep 2026 07:17:22 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1x8c1P-0002eM-Ua; Mon, 21 Sep 2026 07:17:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drTRD4zU3taPWlptcwbQ+7DVqiBNZsW+lR6IS1Sua+B3J7vnC/O1irWG1qI17t3V9H8p7L8jfEe2Kmy5V4SVIRAEjzAvQnd6Ul3QmNv2P4omD5PvOcQMIB9CL7MhZtHWNTVUFhwXySEkly6Z8j6RxWFv0nrU50+mm6492rTlE+4x2UtpLdxVVS8Gw/TkkzNo2S5CPt3/+lLvB4WA++pnxRTvNFXo2lDewmDRoLjHrfOwHBSmYbU7IZsfehXxCVniyGVdA/Er8xbJgDNfa1ZOcrZuOZV9vrA8LRpsJuoeKU5cLoR0TDdJ8Tf2II86zbQ3j81D2HlpLmgvFDecSCaGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+OOTgnZxkRKMbGwDrTU4afCkPxmZZT2lT1U/IS/BmU=;
 b=jKeZb88oC/UTjYgxL9Cx6b8d/04H/hNSieoaL1Wo6ps57L3CzzIB7JaymBjReF/wfvHOl/fxok0LT+gSuluT2ZhFv2qaZJOO7bIda5/CDpmNG80KqYhBNQxNR9AXKfSaRRirVA0EqStdVqgIY9zi1GCpePuIoahfZTiy1mL93p/d6irWbK1KkvPgcxy2nzcwuniksFCfvCvuLdteeUQTdXjpuChp+UMfHFGI8u5J4goNwpq+CiUr+su9boAP7kc3KEOxg21vW0HJXLhb5WZMYRdOwijCScTtTkhH0H3J5MQW8dUmqf/e52if/9sIQ5JY4e6NJQWPrvAQiF8/DGO0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+OOTgnZxkRKMbGwDrTU4afCkPxmZZT2lT1U/IS/BmU=;
 b=fDkdX1u4bnW3kxaT9dI3WxPAFdHd2JhciF5KampFrRRyaMIwhxfWk2v3W3+ZzmkJuUzJasr974Y8uM8xx8HL6G1RDPtcGl0CF4YW+yvd9ZMNnAV9MUK5cW1vL04bMaDpdfMl7Hj2zF+D4PrChGlKMduRghn1xxg87BHDJZ4xNqHujWOYrQwPEYhomitVJfUSvBe4mkqSD5zuJBV6pNFCb1QKbWKM3b0UHjyCzdvjuq9UL684wTQJrVcPsg5nTOuPWkiibBh3a6SoHy1atmo5+I028a+F03jAzyHfnGO6H1vDW22pjtkAAzsVv1sogFTlvmcrMRLFL7k8jXIPloxcrA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Mon, 21 Sep
 2026 11:17:14 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:17:14 +0000
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
 <qemu-arm@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v2 07/10] hw/vfio/pci: Map the CXL memory on the guest
 decoder commit
Thread-Topic: [PATCH v2 07/10] hw/vfio/pci: Map the CXL memory on the guest
 decoder commit
Thread-Index: AQHdRgud9DJDBk1zoEuzXzQ57TNmmbbXNKqAgAGz7qA=
Date: Mon, 21 Sep 2026 11:17:14 +0000
Message-ID: <IA1PR12MB90301A9A30E7224E9F028B38BD842@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916184412.3825713-8-mhonap@nvidia.com>
 <20260920091403.716987-1-junjie.cao@intel.com>
In-Reply-To: <20260920091403.716987-1-junjie.cao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|SN7PR12MB6715:EE_
x-ms-office365-filtering-correlation-id: e7690df2-9701-4980-21cb-08df17d1e3a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|11063799006|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: hgSiQzmd4Etgd6IJLZnkBrnbPVpElX9F1IvNvVQyHsQLVk1vSl02td84AjhOCt09hNlJRscmDMU6cvEE9j+QbOwP/vyBkQWKqbzzVvAQSd8eA5vlMPFq/dAPbfnCivsXY4XgDdHmEU9YZ3VAhPFFJC4ewPLGqr7O5d6TcwyfT0zlDEGO10xUjCAOW0mUni8RPKTC32AaGWxiuqfkoLcSGdRXCk0Yd3zgSHi3tqEDJwpPTIkw+kARoU23cQZQb3SgN6r4zp/X0haGYA/17Q2yHgc4FHgWno/e19hUVC/jMFAp0NihRj/OZ8F+ZrQiQ+4v38asMXkTWqCqkMn2sLWa1nLOrzBtCOdVNh9U9ReTrFErCw6hG0zR0NCTiWIOtnggwALay1QgnxDLDUqhNFTGl2dntpscJiNf1pqek44Dpi8vbyDyYatytITN/wjt2XaSfq0wM/ZC/D0DGKbtH/2R3P1tvBIq+uo8Oo4kx84d1kKr6sRK24z+Xv7Kb2p5wZ/JdGlXhZI5nEjJ/nVg5NNVFFCgNi0fEX0jokeeGrjKaJPeBccfgJ8yUu0cpWQNfkTIXT+fuUypR/6NxHgwTfQp8v0kBz+OW5kdcNExI+xqHhyeiXVHauUhXHxQKcSOUAdzzlQBaH8WXZ5xKS63TaSZvAgI7mveqhOnrrvuWPXli5L7co3YkxmEaxpNQ7BokcomwBtg8j6yHiAGlqHbTb9HWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9030.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tFaboczRPv41CJGfhDkit9O4TEApHvTW2gvFHmaWgJNmgDVg90m6WF7Hs/z4?=
 =?us-ascii?Q?puj3/JNt7tQkWBAGAQOr7kEl5SeM3OMv3N9jTWNRNBx5lmMF7aFosZ7Khi8b?=
 =?us-ascii?Q?LSMAKDHw71xL+eQfm7moxEW/iEcJgbBDbeUFo5wCuvw50Bdrn3aJd4cy11KN?=
 =?us-ascii?Q?ExKZOFCLWWdZt9JDU03IvCodS4pY3IBTL7iSsKwlV8ZfJOJSBJQkbeivGII/?=
 =?us-ascii?Q?Ac7vCrcq6v9MakM8qbK22iXalU+pArp+DSZ2hifYzti5LepR3hEXDbtNtvSC?=
 =?us-ascii?Q?p3Ocn1ASYkOGrorvI8yi7Vpa25aG6ZpSOkwt9eltlUN3Rl5kWtp7T3ImUK4E?=
 =?us-ascii?Q?juQPJowgbgyveB3Kw0P17byjcuD0/o7v7A/kPV/YnSta8yLWTLfMK4YBB/gw?=
 =?us-ascii?Q?s0GzglFrdUBRmOsjER1cpFIs32sm5/XsTKBtyEWPcvkPyluwgeOlLOCf8FR7?=
 =?us-ascii?Q?LhjhhaaiBGd+lKYEIj/dzbqz2cZ8jgDvhAGhTxa/mzQi962lccRNBWdB0vR9?=
 =?us-ascii?Q?Wu8afQaDDb0KlZos2j2VPpBwmlG+nu7bNhXfqmTDpbe0EDc3b+mjeB/PkK6y?=
 =?us-ascii?Q?d1cZ142y5AUazObHYQxFykidoYs0sxW4dTlqvD3GHxCrKxl4guUSn9ho2sIQ?=
 =?us-ascii?Q?9TcmN1dzVu8vj2jaPpIW9LzzKczluOUzVeGR6qz/r8Rt3Ulg7f8g17h9QBFk?=
 =?us-ascii?Q?Dxe4Ef9caqkEgnHpZ6dqUUqrMMQ2znFh2KrGanNL62uYTlQ8j5FF4HBc1pCp?=
 =?us-ascii?Q?8dJb7WiKkpuSfvonYvwQaMF3dZoOnLxlSL9+e7VPIcDGMunFMVU28jGBp2Fe?=
 =?us-ascii?Q?+U8y9Qhmp31aIUK4se0nMrpryw1yEv+67b66Q07BMF7lSh73VLvAtzM2BGtf?=
 =?us-ascii?Q?Ln44jvrgBRfV/J7Uxx69w5vNjguVqtc1FdDmLV8nEc3RrPpxc1f5w5Qe5Z3t?=
 =?us-ascii?Q?jHB1+jYhV6zhB886fGa5/4hhxMSIHnuWyvVrD8PR5H9jsCqhKmlc+XFbMdUm?=
 =?us-ascii?Q?/y+HzXwwMthGsneouQ9rRArHVgakhpKbZdWgoevNgvZgYBqcvVT7qj7hRsv3?=
 =?us-ascii?Q?aJkLChXG4ToY8GrU9DXHm6cXllehhWGTcQ9H7m8zPEJ4CSGQXHRGMWyqDTgX?=
 =?us-ascii?Q?lryqjMPE0GnUMQ/3SwPyc1nrPS8cY+yrOX3gRGS4gkyrMVmDvAPFQZkoVbId?=
 =?us-ascii?Q?es88U5Qk0j+hWDZo+cqE7w7bqJtrA919CJ0yepjGWnYVtFrs8QSoe+8dRMnn?=
 =?us-ascii?Q?/L+bPViAasUZ1vmtpND56jArNA8fvKhMgsUfyGjPOFIsQKJTryuquQCj8jfa?=
 =?us-ascii?Q?clU8f1m8stuM/31C776Mxu0IWd9JbtE49dBbuGiQ9uMqhiDx75oC02Qksgmy?=
 =?us-ascii?Q?a6oPxdITlcvGr4e0Nk3K6t7Mkm0HorjEXoSJgCzx77P2aPiuFakHlIa/LayF?=
 =?us-ascii?Q?rWDzDrABNYMUXGsFh4GmprqRBtZIE5Q3KY64AFJO8q3qTg47iyjNwlgIl8KL?=
 =?us-ascii?Q?VH/d1maCydbt+WP0N/06WiBw5m9Ci6c/CkX/EnCtiXNmRDJBp75dA5snUOfg?=
 =?us-ascii?Q?EGjeqFtnGpolObgCxUAi2S5NsHF8K7hQU1zTsfZPEC1NZa8EcWnFHCBf3KnS?=
 =?us-ascii?Q?3QQtFDGrQPawYvrA/RNrA2Ur7Hr5UfjtruwxSjVxHqjG3it7WtNYGk7kGWIR?=
 =?us-ascii?Q?pkq6eIncSpGZUspPagFAxol6Ihcqy+l3ua23bYazu+vgqweU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7690df2-9701-4980-21cb-08df17d1e3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 11:17:14.4526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/3B6gnhHUQYv1yzbzAIV19MYKvY/e3IhhOd7g7/5rHuXUTJh8Wg4259Ygubj6BvbmA64D1BLm7AcTRMsZrKHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=mhonap@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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
> From: Junjie Cao <junjie.cao@intel.com>
> Sent: Sunday, September 20, 2026 2:44 PM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org=
;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan
> Madhavan <smadhavan@nvidia.com>; pierrick.bouvier@oss.qualcomm.com;
> mst@redhat.com; imammedo@redhat.com; anisinha@redhat.com;
> pbonzini@redhat.com; eric.auger@redhat.com; peter.maydell@linaro.org;
> richard.henderson@linaro.org; clg@redhat.com; cohuck@redhat.com;
> Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Zh=
i
> Wang <zhiw@nvidia.com>; qemu-devel@nongnu.org; qemu-
> arm@nongnu.org; linux-cxl@vger.kernel.org
> Subject: Re: [PATCH v2 07/10] hw/vfio/pci: Map the CXL memory on the
> guest decoder commit
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:14:09 +0530, Manish Honap wrote:
> > +     * Record the base the guest programs into a decoder so the commit
> handler
> > +     * can reject a base other than the device's CFMWS window. The
> > + base low
> [...]
> > +        vdev->cxl.guest_base_lo =3D (uint32_t)data &
> VFIO_CXL_HDM_BASE_LOW_MASK;
> > +        vdev->cxl.guest_base_written =3D true;
>=20
> This answered my v1 question for the kernel v4 FSM model.  With v5
> (20/27) the kernel gives a live read-only view and leaves any write
> virtualization to the VMM, and what QEMU shows the guest is a committed,
> locked decoder at the window base.  A locked decoder ignores a base write=
,
> but here it is recorded, and if it differs from the window base the next =
rescan
> unmaps while reads still return Committed at the window base.  That is th=
e
> mismatch the check was meant to prevent.  A current Linux guest never wri=
tes
> a locked decoder, so it won't trip this.
>=20
> Is the guest-written base still meant to matter in this model?  If not,
> guest_base_{lo,hi,written} can go.
>=20
> > +     * The kernel runs the lock-on-commit FSM in the write above, so t=
he
> > +     * committed state is settled by now; a control write on any
> > + decoder can
>=20
> Stale now that the kernel no longer acts on the write?

Yes, you are right on both parts. I will drop guest_base_lo, guest_base_hi,
and guest_base_written together with the mismatch check and, reword
the control write comment to correctly match the code.

>=20
> Junjie

