Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C1CCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 23:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMwCa-0001YU-QD; Tue, 12 May 2026 19:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alwilliamson@nvidia.com>)
 id 1wMwBw-0001DR-1d; Tue, 12 May 2026 19:07:15 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alwilliamson@nvidia.com>)
 id 1wMwBq-0003kk-DJ; Tue, 12 May 2026 19:07:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZu3ja1CKVsFkW/r5rdH5X0YcGYJs5raZC+CzD0H1PSwd7x2TqE6x6ojjh9xacWzWUrfTKBCT1uaggmlTKl8y0giAakIMPTvoCtN1WurwqVlahJm7HScnmS/PpFiuIL5hnS7XgtMGQfCocz+6Np+Dxw8JRn/h4CrxBBCjdBD/ktDYtGZhwhcb3hRx2TqRJXlMJwjRHbFMGxYVZtiJDRJ77HGJUqLnDE87NjyzUzYN0lviZjE+b2CxeYN+45gfJqiH2LDmlal0h9hX4aNKEaHuQEDSFI/k6eefNXmNU1zvZ1sven7JH2G3eT3tTebpmeJl1z9ltEXu90re/DJjsi2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AshgZxaBptnP/Qnl8mvTexalD8JocnBb37zZ4B/jExg=;
 b=bZwnD/ftw90Uf3MplbneQ90GqRtKAm+jGonKErhT9dLeRlQ14yz83zpG0VJRsenrN8UPkFCV6hX9cW/oI6V3f6XiXI6S+GBUY4Diys0sQDoDzsP7DC5jwMndmTTOHO5rjmGTfjh67HI/W0hEMGYJd+obB48TQxjnR9o6cQQ9lP+o9GVB6sO3G1nHxSJDC2IIJ84CpYmmQxP0zMPRDUH70fao36nIlDnVTLteVEBrQQFZri23/p6jMgtRYrpI9Koh36ozCTPfAb46RojhRafnVP7xFdXddd82/149JUIe9eo9i1se3/ilb8KFdQ7c8ChOVCKtTVTaomFieNPjONvw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AshgZxaBptnP/Qnl8mvTexalD8JocnBb37zZ4B/jExg=;
 b=lc2q81EG+5bP0hVEOr8eWViO4B419C8coj9yIY50bZNdxVLt1bOJ61OiOuBa35CuAcvCpGx1KzfGsoZ8HJdWT1A42pS2WftK6W6V/5c+WdSsTh+B8IGBK7Yi20nSF9/iX1jdWmCLGZVEasFL7nU6f/Z0xUwz7/e/1e6ZD3sSfLPJfK9/Si+gWWwgeIWTpJjcljuqOW+NW0nuSQGqkS28mbpfCSa8RKJYGKSIr1b/b0E6BvxMMoIvk/TWtQ1MgGVkQBiBoULaK0UKix3QosO4Uf+8AfeDIdNLb36eSge41UPKuP94iYebTeqY6UkaSndy+WGbmhK2VRNYqGqXOgL1Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 23:06:53 +0000
Received: from CH3PR12MB9430.namprd12.prod.outlook.com
 ([fe80::3471:9f3f:761c:841]) by CH3PR12MB9430.namprd12.prod.outlook.com
 ([fe80::3471:9f3f:761c:841%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 23:06:53 +0000
Date: Tue, 12 May 2026 17:06:50 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, "devel@edk2.groups.io"
 <devel@edk2.groups.io>, qemu-devel@nongnu.org, jgg@nvidia.com,
 skolothumtho@nvidia.com, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: Re: [edk2-devel] [RFC PATCH 0/8] hw/arm/virt, hw/pci: PCI
 pre-enumeration and fixed BAR allocation
Message-ID: <20260512170650.4551c9f6@nvidia.com>
In-Reply-To: <db604efd-9c1f-44e0-9921-71e4d97a81b3@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
 <22cf37c2-b2b1-40db-b8b7-393b6c36a921@app.fastmail.com>
 <db604efd-9c1f-44e0-9921-71e4d97a81b3@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CYZPR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:930:8f::22) To CH3PR12MB9430.namprd12.prod.outlook.com
 (2603:10b6:610:1cd::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9430:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 04442df5-d627-4262-c406-08deb07b27d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|11063799003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: 7r7M/2wLBWHjqEbtzL8PmrBORug2tXmOwxTNoSlSwtUkKLb2U52/Zc8Gd+C1M7UExvRJNQI2TMmZmHJ0ex8kySZfVKDS4Eqk5AdGB7+NkL/Je9S6L51mK0suLVXAAO32mjCwhLad7q7MLb5i1TXRJ0IfOf0d9BUiJht2BIaKAOX/yOT2YaAqWBJsm643iYsV5hAgIWh41AAbNJMbAEoQ8tvGLk4zONxPPhae/Iw3cqTgAFPAjGyymnFtQC35n/s+BN0af3nv3TWAyIdEJTiaGxhxe9JhZzXzuasPvOu6PBcrCcLs8+3mtptLivmL0oNZxVAbbq8pNdntGiF+2aORF9jbhOis387fbnzm4TlcakeYEsogsJ7JXAriUONUK9RZMvJECu+CryNQ9Xv9fklTHRMSqEwUQA7f1pf7Sa7uEg6mKJ07SlWdG/VWYx6ZWleYpSstRDiHDFAYvhKPj8zFI67XY1gECATN6jcoiMJd3xAanKRur8GjUAlUl4S5jX/UDAkD/7PPf7YvJnlhMhlO/Na6Sx0IKu+bI26CtBzLc+WzuXwX961B00SpQwhHGaQ9rlzZ03a21eQfyqxMz+XvGRsBAaxK4hTNodEGGDF1FiZx0Rivof5rLWhbkjTLJkmHAyDjgwBfc4++rFLsT0tjz6BjdXa0I4ZTCVBPsphCW4HtLsDfDHdLM3hcrsdGfBY3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2lSOXJRM1hyRnNmVUFaMHR2ZDNYMUQwMHhSSUdyY0xrUHBGL3FFQTVEUUV1?=
 =?utf-8?B?dHJkL3R1Vi9haWxOVEMrejlrTTFxQlR1NWdKRnRqQlZCT0FiTjlkZTdPVSt4?=
 =?utf-8?B?LzFKamhCSVpHM0R6R3doUzUrQzdYakN6UWZzcEszS2pORVZNc2tHY1hpbkNE?=
 =?utf-8?B?TVlYdlkvbEZJb2w3NURkcTNEcGpvdEU3THJqeUpvRmJFZzZ4Q2VRaU5ZVXJF?=
 =?utf-8?B?YVFTd2Z3ZkdQZ0lHcmU1U1JpdWgvTnp6WElpY3VRcVJMUkpXNi9TYldaNGNq?=
 =?utf-8?B?TWNpYTVhS0pQTWxCcTFpTngvOVdmdit2eUtXMzV5UCtkaWZLZlVVN1J4UFVD?=
 =?utf-8?B?K1NrRkxoS1ZndVFZNUxsZ2liUDdMaEZBYUl5NG9KTnB1L3VkMnhIc29zWmFL?=
 =?utf-8?B?ekhidzhWT01yTk55TjBrNEI0cXlUM0pVQ3psUm04K3JURFFRaWgwcEwwS2hx?=
 =?utf-8?B?eFhuMGo1NkVPZC93d2FLWmRna2lEazNCelN0Vklxdk93R3JJL1JoTE9TUDAr?=
 =?utf-8?B?ZnZxa21SSlNyVDNkVGJqRmU2Q0lzdWU5WXVPT1RKRm5CczRDVnMrUlB5cW9R?=
 =?utf-8?B?ekxsOGJ5L0tmb3JmWUdaYXQ0SVFrZFJQZFVFQ1JoQXlhenFJZlNqTEZSK3Z4?=
 =?utf-8?B?NGpqRWZXWkR6UHhkVy9lV0VvVkdIUEdhemhaS3p1VFRXdElnN1J4Zm85OVo3?=
 =?utf-8?B?UlFRbGpTcHZnZHlkalozdk16MjUrOXdzWUVIYmllelN3NmVGVzRnMzhPc2tk?=
 =?utf-8?B?dExIWjBCZWtNSW95R2tWamxvcmZEdVNKS1JFSXRxM0FjcE0xNjlvYndHMmln?=
 =?utf-8?B?NTg5bEF5ak9BTE9QR2RlS1NVQmRvWTYxaUg1R3lJRVIwV2lWOGh6RjVZQTBx?=
 =?utf-8?B?UWsxbmZOUWpMYVhiTG5CeXJRN29LbUhGTXhFajZDSGlmVk9wZmpXNmNmYmNr?=
 =?utf-8?B?UWRiRURnM2ZWOTdNUDhrK0xxaEhIWEd0dERWb242NjRQU3V4a3pQNHVwWWYx?=
 =?utf-8?B?NWh1WDFtdUFEb0NrOWQ4NVl1TVNIWFBVWXJEeVdFZGthbkFVTXJjMUF3RG9I?=
 =?utf-8?B?V1hHSWEydUcyL09XZHhhWFFPRzBJNnBKc2drYnYyQll4STBvY0p3V1F4akRC?=
 =?utf-8?B?VlZiTzZnK1czM0kvVDY4NFZ5VlN3dXZETm4xdG12WTRBVmhocGhVdlowYkEv?=
 =?utf-8?B?Nk12RHFmUlJVZCtHdUJNelBWdXBIZ1VYT2YxTmI5OEpTTmQxN3ZxUmcxTDBs?=
 =?utf-8?B?US9HSHc4OS9OelJoR0xXckNCbU83VGdzMFA3OXI3VisrTy85TmxNOFdwK3Mr?=
 =?utf-8?B?YmJEaTVxUzkwdGJ5ZjhKbkZBZHVHY2xpbWRXSGhuYzN1ZU9IcVlrNGZ4ODcw?=
 =?utf-8?B?T1RRTXEvazBROVFyZGVUWW82WjYvZ0ZCQ2h1d08zNXp0YUpwUWJUNVJsdmhV?=
 =?utf-8?B?aWF4UFl4bG1GSmdENzkveCtqS05JS1BreEtOZ09TdVVwc0YweFBMNHRDa1J1?=
 =?utf-8?B?QjlqWU03ZEdmdG5MZFRzVnV6UWtlNUlIRWFDTElXRlVjdmFLUmp0emIyWllW?=
 =?utf-8?B?MzhZVTBOQmRWRFJoRjZENHlnU2xpUWNrN0lFakhQRWVTZUNlQ01ZY0R0c1dl?=
 =?utf-8?B?WElwOXNQdHE5MnlmTlU2UlZFaWpNM0kyRHQ3MHdCaXpENGJnTmZrUHVld2l1?=
 =?utf-8?B?c1dXMmd2a2NycDFEV1U3aWNyNm9Fek9BdVNRaTEzeE1hR1M4YXhKbjVjZ1ZV?=
 =?utf-8?B?N0xTc2VXdjlUc05MVjBDMjVQczNtN01rbkx4Mk83cU9CYjlIMHpBeUFEOEEy?=
 =?utf-8?B?Tnl1MUk4d0NwZmJnMks0RWNOeEhhTFFhcGRNZi9yWGs3MldCMm5LMmVkdW8v?=
 =?utf-8?B?Snc0ZFZyRjhHd0d4eUNQTkg4bjdpOExzZzFwQktrNkY0NFBJTG9yMHlsV2pk?=
 =?utf-8?B?QU9lYVQxRWd2REdnTEdybUlhcnNtakE4TGlpWFNEbVJCTDB2WDRPUEtHN2xF?=
 =?utf-8?B?NDhFT3J5TWhqN3NOc0R3bS9kYXBod1NMaWhHTjJadVpQdHFPZEFXMHo4aXhM?=
 =?utf-8?B?Z3h6TWhVNWJzOEIybXFyblN6d3lycFZ6d3NibjJBQVI2d3Q0U2diZUo3aFIx?=
 =?utf-8?B?b2tmRUN1QlNuWUlDcG5iM3RkU3JQUlFvcm11WmQ2ejY4elo4Q2pLSWFPY2Ry?=
 =?utf-8?B?M0FSZ2d6TEJvT0lLRTNmYW8rYUViU2thblJtamVuaHZqUGZVM0ZTT0lseFlq?=
 =?utf-8?B?UHAyY3hoY0hkc0ozSXljQmsxNFJVMDVqVDlBRGZwZGFoQVJ6QURZZGxmckJt?=
 =?utf-8?B?SHNoaHZxUVdRYXB3U0YraENSRHgrV3h1QU1Rd2NhZno1bUxIdjlPZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04442df5-d627-4262-c406-08deb07b27d8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 23:06:53.0918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPnepZV6zV/2YW+xpvzSS5rf66zbm2OsB3+q6v7QRBsWKRT9uyHzDRa5PsWa4AmB5TG+KFmB7J5cvuCIXHJ9Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=alwilliamson@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, 12 May 2026 12:25:45 -0500
Tushar Dave <tdave@nvidia.com> wrote:

> On 5/11/2026 6:43 AM, Ard Biesheuvel wrote:
> > Hello Tushar,
> >=20
> > On Fri, 8 May 2026, at 20:37, Tushar Dave via groups.io wrote: =20
> >> This RFC introduces a mechanism to specify Guest Physical Addresses
> >> (GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR
> >> addresses to match host physical addresses for assigned devices.
> >>
> >> On some platforms, P2P DMA is performed between devices within the sam=
e
> >> IOMMU group. The PCI fabric ACS is configured to permit direct P2P
> >> without going through the host bridge in order to achieve the required
> >> performance.
> >>
> >> To support this multi-device IOMMU group P2P scenario in virtualizatio=
n,
> >> the VM may need to use the same MMIO BAR addresses as the host physica=
l
> >> address layout.
> >> =20
> >=20
> > Did you consider implementing this using Enhanced Allocation (EA)? If s=
o,
> > could you explain why it is not suitable here? =20
>=20
> I have not evaluated EA for this design. When I looked at EDK2, I
> chose PcdPciDisableBusEnumeration because it cleanly preserves fixed
> BAR programming established by the hypervisor =E2=80=94 at the cost of QE=
MU
> performing PCI bus number and resource assignment.
>=20
> I did a quick search and do not see EA support in EDK2. Any pointers
> to EA being used in a similar fashion to achieve fixed BAR placement
> would be appreciated.

EA wasn't on my radar either, but I did some research and chatted with
Tushar and I think it could work.  I'll sketch out a rough idea of what
it might looks like.

EA describes BAR equivalents (fixed base address, size, and type) in a
separate capability while the corresponding device BAR registers appear
unimplemented.  Linux already consumes endpoint EA capabilities and
marks the resulting resources IORESOURCE_PCI_FIXED.  EDK2 doesn't know
about EA (cap 0x14 isn't defined anywhere in MdePkg, and PciBusDxe
never consults it afaict), but that turns out to be useful here rather
than a problem.

Starting at the QEMU device, for a vfio-pci device we'd need to
virtualize the real BARs as unimplemented and surface that information
via a synthesized EA capability instead.  It's debatable whether this
is a generic PCI mechanism or vfio-pci specific, whether HPA is
automatically used as the base address for vfio-pci devices or
user-specified, and the capability offset in config space.  None of
those fundamentally change the shape of the flow.

For the absolute bare-minimum level of support (EA device on the root
complex, EA resources don't overlap the VM address space or MMIO range,
EDK2 firmware, Linux guest booted with pci=3Dnocrs) I think this actually
works with just adding the EA capability above.  Let's walk through
those constraints and how we relax them.

At the firmware level we lean on the real BAR registers being
unimplemented for EA devices, so EDK2 allocates no MMIO or IO resources
for them.  Only bus numbers get assigned if the EA device sits in a PCI
hierarchy.  That's exactly what we want, EDK2 doing conventional bus
assignment but staying out of the EA resource flow entirely.

Instead of firmware EA enlightenment we lean on the guest OS.  Linux
reads endpoint EA today, but the bridge aperture sizing path ignores
those fixed resources.  As Tushar's series demonstrates, generically
handling mixed "fixed-BAR" and programmable-BAR devices in one
hierarchy is hard.  An incremental Linux enhancement that greatly
simplifies the problem space would be to program bridge apertures only
for hierarchies consisting entirely of fixed resources.  The math
becomes trivial (window spans min..max of fixed children, aligned to
bridge granularity), and there's no regression risk, these hierarchies
currently fail silently.  The sizer ignores fixed children and the
fixed-claim walk-up finds no containing parent.  This enhancement,
plus the homogeneous-hierarchy constraint, removes the root-complex
constraint and lets us mirror the bare-metal topologies we need.

Resource ranges are a bit messier.  The extent of the EA device ranges
could be determined in QEMU and the VM address map adjusted to prevent
overlap.  Tushar already has a similar user-specified machine option in
this series.  That range also needs to reach the guest as a CRS (to
avoid pci=3Dnocrs) but needs to stay distinct from the DT range passed to
EDK2 for programmable BAR devices so EDK2 won't place a programmable
BAR or bridge window into the EA region.  So long as we keep EA and
programmable devices in separate hierarchies, EDK2 only needs the
programmable range via DT and we can add the EA range as additional CRS
ranges visible only to the guest.

In practice, EDK2 programs all the programmable devices and the EA
devices live entirely in the additional CRS.  A possibly cleaner
alternative is additional PXB host bridges for the EA devices, each
with its own CRS.  That sidesteps the DT/CRS split entirely since the
EA PXB has nothing for EDK2 to allocate anyway.

If we agree that homogeneous hierarchies (no mixing of EA and
programmable BARs) is a reasonable constraint, and possibly extend that
to homogeneous per host bridge to simplify the CRS mapping, we have the
following work items:

 * Extend Linux EA support to program bridge apertures for subordinate
   homogeneous EA hierarchies.

 * Develop options to virtualize programmable BARs as EA for vfio-pci
   devices, if not generically for the benefit of testing.

 * Implement a way to poke holes in the VM address space and plumb
   through to account for addresses used by EA devices.

 * Provide those same ranges to the guest via CRS (but not via DT to
   EDK2), or alternatively expose them through additional PXB host
   bridges.

Does that shape roughly seem accurate?  Are there additional gaps I've
missed?  Thanks,

Alex

