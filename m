Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21648CCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 10:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGEI1-0005Zy-Fb; Tue, 04 Nov 2025 05:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGEHz-0005Zj-Gd
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:29:23 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGEHx-0002iC-BS
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:29:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez6C06sxJF+P6IMOlqKSkqMZ+1QB026r/DhFDuhudHvd2Smj1nJKdwGZuAlBxEo2vStVQfVsjeY7wC3IEta9fEnDSuJgOgq3nz8rOIXVMZrhXSrddechChAt1wpRBvyPNLBUXu7NAm4L1VbQ5z7oAePL8VeWcVw4XX0aXd1miGa+fh+rJ+K3Jhjwx06kTR1xbQjuRr3Ef+wWG1oDs3m48il7xjPzBJ8KFY92AznInRMRkPyJvBCAi9OMD6P/5UNpLWAZM/0jI0FN3Li3+guadmNk4fEpLvC05aXY7hpuGleZ1wGw4Y1oVv50/TAy9cFOs+mrv8xE9xSKIhyH74HEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEz/uNDOY+rnC3ZW6FbB0+k54NjKsMrmVM3N0WJLPho=;
 b=txsZxAI4QG1r0LN7lERCYdW/KA2fKImCROOWevJzlxl+TtOKzhvfA1XmlpAJ3dIIh2wHLU8YBnrgp0rFekPozA9rdQ0HoydTycHA3zrNlZs47QMrryY4lid6t9DREvcGWh0tVbpWHoCdkLBesDuBEmA1+/LKEhZXaJe365WcBDgcfwvPCqjTsCU9lKT+6ceQjuz7JtjOICuFixakrgPMAYempKTZ7AuNKfizxNK2FJZhYLy1litq0gNfhjpny/IqeKo2b2r5qXa2G827AUl1uPdBHSaSJ3ashtNEhCz+pcwPINYKFl6BSgTXfblNyrgXJjjYS8cedBTbOhN8MHgbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEz/uNDOY+rnC3ZW6FbB0+k54NjKsMrmVM3N0WJLPho=;
 b=cE+OVQ+myeKlA/sFq1YUnS2GL/Err9zl8FkkoyEFfJFEE+54uh9e3gouR8hDAKuvX41NtJ32TuaZpq20EhdH8tkRaE9S3SEFAd/+dIYrdfnBPybphUBeF/9j5o+dLVY8CUqFFNauRJV9y3rQekMzELfIg4SO3fSS9d3cUwZvj9WVKlTi1vmBhyD2uzTUYNkD+4y1ZDfReVUiS6Sz15YP4zfQJ9q4ZMvIMuqg2xZzfqKu3u45rSHSugufvBtqRakhz23A+UgqHeSvv/I8Y4d70WIfHgWZXoTe2VYCSea58+l9APH5S3PhffhgAcMlYM64gi36FxwSbTdV9x11L5aLdg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 10:29:16 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 10:29:16 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [PATCH 0/3] hw/pci-host/gpex-acpi: Fix _DSM function 0 support
 and update BIOS table tests
Thread-Topic: [PATCH 0/3] hw/pci-host/gpex-acpi: Fix _DSM function 0 support
 and update BIOS table tests
Thread-Index: AQHcQzF4ors4lUr8ukCb112zgtUmjLTiZHcw
Date: Tue, 4 Nov 2025 10:29:16 +0000
Message-ID: <CH3PR12MB7548E8963F1F91B0B456F04AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251022080639.243965-1-skolothumtho@nvidia.com>
 <20251022095416.00003545@huawei.com>
In-Reply-To: <20251022095416.00003545@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM3PR12MB9390:EE_
x-ms-office365-filtering-correlation-id: 15164268-41aa-40f9-b9d0-08de1b8d0167
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ti+g855coAPOrv6UXTJ7QJDLtnqrGM2YLRzshvcInI68XqzC3Q3QS3ob33DM?=
 =?us-ascii?Q?9xHe7KRqFUJY8eQmjEDPoj9MxI0jmGYo5ilCe+L7pu866yWdwyDurYVQglrO?=
 =?us-ascii?Q?raWPzig3Sj7WrwE2LfX974uW54iJ1IlIL9rng4tqUhNYNhRpkAeKQJnhJuJY?=
 =?us-ascii?Q?2Msjv5VZQNCLH8xmfXtJj3sJRF6h/gTSYpn6s21ithYs04TIrUw6QBTmc/FV?=
 =?us-ascii?Q?2x9SqWiPJVWop/MLGvuCkM4vYVeF0DKv4R+OEjrrawX/vfMVgRjcX2TMWfJW?=
 =?us-ascii?Q?4wulNwT5cyBjai5MPXcTzHIUcF1d5GTe92c3S8MPW4C4aG7bX0BoBDuUwnN4?=
 =?us-ascii?Q?OezWb8nJAWxmcuB2rHV1reEMdLCfe7gJYsOuIucMEwKG9m00RGCp9uaemTtR?=
 =?us-ascii?Q?WTRgDZ3tljCJGeNZILbUgoVtDfqhqp/3YKX5sbliwFas+Mp4DmbF1/oDIXUv?=
 =?us-ascii?Q?EvGpBKciUmpofoeXDLPHl7BD9xdxP3OzQHOXqCMFRaG7l2y+d+JQXG/Q1j/N?=
 =?us-ascii?Q?1qH81JPYwfHj8P7azhqh/FeEek0bxN8DuLOFWu7oz4l770bKnXskLkV6m3My?=
 =?us-ascii?Q?KDq0ew2jj73uHuiAeWcpk4QDtJDyFGYlK55btbk9hNA3so57mBfRfwDPb8ew?=
 =?us-ascii?Q?IEHN2Gu6jLXYAdjOnW8BUajfGdrzWoiybaxqpAzBvP4KZEzCjKgb/6vW9SrA?=
 =?us-ascii?Q?5QBktiaGXQMC+d9ENMWbYyer6qENrnZAtOobgjwJTU3rCXTT/QZidqQTrJsB?=
 =?us-ascii?Q?Fft+VE2zdAvNLgXqJx0Ty/r3dDZhzYvLS5FxiaRCIQMjsW/wyrpTmUSYicLo?=
 =?us-ascii?Q?K97OtUqulrzGUr8VEWVMTLO+MIkqOEFO8hT8YGzHknpYrACF/g7/a8faakC9?=
 =?us-ascii?Q?h3G2/Ac4hqWjBh4jgxmkySiX4iYwUlHj2lHpBQ2XCPKFqWkvgul2jsHZtrvi?=
 =?us-ascii?Q?ZEtP6k5oh1JBLrQUeHV6soczIiebiUW0TC8B8rU4YvAQ9V9hvYHbD59FOopi?=
 =?us-ascii?Q?I1OYrGzoRmXBwPcxyXR14Pj23VVm7x8mQARuSvwRjbuvRd/i1NY8f32Qw6fG?=
 =?us-ascii?Q?zU669brX5bKysPJCcIVhdsqKGC7FX3jJtkPug3sIodVuivME4vWFrvn2xvqj?=
 =?us-ascii?Q?Hm1r50lomoMWeRHiDRQc4LEaVdlM+ZPzusfxdbrY/kWzB/Y2WbYBA+Qv8Ios?=
 =?us-ascii?Q?szbviNvjTLSpzB57VpZ8NBnIni9FzMBHIGhwXGJWQ0munJ51l/f+r/1S6Uwj?=
 =?us-ascii?Q?MqfL8KNPvj4wVwXINGcBdCCN4+COmqHg7u1HmvAHo2Nr2BFLisnzWZRqyRQO?=
 =?us-ascii?Q?+dlf/DiPllcP3FRom8YhU0qMwx8Kv0c4t3xAonqZoZg5C/beWl6aH6Nsg8bN?=
 =?us-ascii?Q?o2d87I8WMAUB43e1l9yBpLU/d+ZZ41VPT4xcu2NZDgQFkgKOQ3HmKetBW5o8?=
 =?us-ascii?Q?73OH2FZw4ss29saFe0TTpRhfMrrrHxbQTyqzSMhX6k6GFs+Ma3KpGw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mIAicI1T3VBlVEiNeCT/kyGGgfArSNrF1jf4jnV6iMuFcZjUArt7dHrYODwv?=
 =?us-ascii?Q?lf3Xl4hGzCdgx24yeQ8lS/msv0gfPkQIElHt2YPwj/Uxa7OxfjukMGRXZlmw?=
 =?us-ascii?Q?DKgQWu8HrxDH9KJir7kSWOXYKrO4sbNmrfpGpc4rzDlI5Keson+OTDK7wOUs?=
 =?us-ascii?Q?C44TbHe3WzMFkEjE4hhMGhETbwVX7RbgGrid9ycU0bcrYSm/QsOfQNB72F5S?=
 =?us-ascii?Q?a1mcgKVntX9W82S4fYcy0KiEy8EVbm/w+FaFILNEKSEly8mlvoxh4PAf0A2U?=
 =?us-ascii?Q?stmDpOn7r2b6m56u2zecRQ20mJpzXehN9Ee/J8EE2jpj3xKSuKhA1elh27xX?=
 =?us-ascii?Q?aneoL7IN2rIAA6SN1pSzZNprdNler4oZKafXbdzFuVx2ljYazUL1nZt9lN8E?=
 =?us-ascii?Q?e099crBLKdMrAy8Q5zLj7CHLzIyWg1wym9Qxcxb6F2q3IRCTJ3Age2S9USgo?=
 =?us-ascii?Q?6LWndebriHfnEUzQSI5gpesYEPRNJRn+pNK+/vG47EnXAgXDlXQq+M26KAi3?=
 =?us-ascii?Q?Z61MbBLWCzRdOkckaZLT+Xzr70Ie+xufwMAgOl18L3+9DjAajv8b2rKm+KBi?=
 =?us-ascii?Q?x01h8i6iuaFc7moDRbtGwEmVpaRIQpn0lfyY9n1rEdCLdWAHQd6FhaEqr0Vn?=
 =?us-ascii?Q?O7grnxAQ8IO7kAPXCBS7KeLbkeRl7/F873oYJq7gEJHoIHdSP5G0L1uQrl6E?=
 =?us-ascii?Q?SNeaawXfugiCwkpWy/DsQUy/qahDuIVOX+Jh6h0QJkWxAXTaW3PDbiz/w/dk?=
 =?us-ascii?Q?oM0qtBEyKqVSpPFlDhuNtrfz0vTWFfC7MU2sF3jno3pbfYB+vwk+A4r7uMIH?=
 =?us-ascii?Q?5pcOxoEPQhgVg/cGhDV5gYCY5fPW8h7iJ8z6Fy71HpUJ6jYF3Ew/HkRkVvhj?=
 =?us-ascii?Q?4YUgoH6quHp/2bdb3Y6u8OJw/LEL3ohhcoHgLCHIWTv6rAItO9qcBvqk30eO?=
 =?us-ascii?Q?ffanmqI4MQcSG0/Q/hVItrNBQlYNX8LoFICXjOZY8/trvvNt855qhky01UNh?=
 =?us-ascii?Q?synajv4yM77u71TV6dOrHBX56G90s0wiDpR+zL9hYSPYWS/INbCwix6WTEc8?=
 =?us-ascii?Q?F0aweH0otfHY4hy4CZM1mEADdOTWmu8qDyPslM/4yaYyKdp6hNQrAZFUMyUD?=
 =?us-ascii?Q?5LAu7YxuKxOLOIDDIbrphSCOIhIE3ZSZKngcogZkORm8+AEmxTzpP06OmXnR?=
 =?us-ascii?Q?B1ddxV1X+UhlXgW2574W4O3f3bsAiPNSsBFPjqh4Cz48KbfJj6PyeUfWMW4x?=
 =?us-ascii?Q?CZ5qifP/CGBT8JRoPZc7HjD9dCr9NHJd7oa6Rv0NUbY6Gb08Wn2ActSVwzbM?=
 =?us-ascii?Q?7A2/Mvo2bv3g+zpJASH2J3H6UNjiCKJsNtAGWn08tWZ/g29cd6anz1J1OYwt?=
 =?us-ascii?Q?NjRIJLZfGLyVl5GnFOfrF+e8zXVwe6CP/QBhkFKRgi9cGy50xJCiFiEagOqy?=
 =?us-ascii?Q?6m9QleU+vvzkSXF+sluv3/tn6KCLCwTbUuvwBmHxKjcshMsUcngpAPVmTQ22?=
 =?us-ascii?Q?1ytdBdN1CQo2cfkuzfBCY/BCThEPhdiehv8r5OVzXnTjwNF+/6e2g3z9/9/W?=
 =?us-ascii?Q?Jhe8Kg4ba2zgXYtWSSCuwZRtXpAQTH60vvYKghBz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15164268-41aa-40f9-b9d0-08de1b8d0167
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 10:29:16.0572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LMAJD7fn7aLf1AuPrUfg45i1UxB7Xfjv830E3b6rX1rLQdsIc90VpExEXjh3qW5fk6YCgOgiJku3/Wcmyz/hWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

Hi,

A gentle ping on this. Hopefully, this can make into 10.2.

Thanks,
Shameer

> -----Original Message-----
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 22 October 2025 09:54
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-devel@nongnu.org; mst@redhat.com; imammedo@redhat.com;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; zhangfei.gao@linaro.org
> Subject: Re: [PATCH 0/3] hw/pci-host/gpex-acpi: Fix _DSM function 0 suppo=
rt
> and update BIOS table tests
>
> External email: Use caution opening links or attachments
>
>
> On Wed, 22 Oct 2025 09:06:36 +0100
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
> > Hi,
> >
> > This small series fixes a compliance issue in the _DSM (Device Specific
> > Method) implementation for the GPEX host bridge ACPI tables and updates
> > the corresponding BIOS-table test refrence blobs.
> >
> > This patch was originally part of the "Add support for user-creatable
> > accelerated SMMUv3" series [0]. Based on feedback received and as it is=
 a
> > common standalone fix, it is now being sent as a separate series.
> >
> > Please take a look.
> >
> > Thanks,
> > Shameer
> > [0]
> https://lore.k/
> ernel.org%2Fqemu-devel%2F20250929133643.38961-16-
> skolothumtho%40nvidia.com%2F&data=3D05%7C02%7Cskolothumtho%40nvidi
> a.com%7C93a6046e6a9c48d8202c08de11489732%7C43083d15727340c1b7d
> b39efd9ccc17a%7C0%7C0%7C638967200675701216%7CUnknown%7CTWFpb
> GZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zM
> iIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DNDhk5%2F
> OIqFfYuM9OwVNAKc1coQr5rdB4jyy%2FnXVP4dE%3D&reserved=3D0
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> (mostly in the earlier thread - but that didn't have the test tables upda=
tes
> which
> are now here).
>
> >
> > Eric Auger (1):
> >   hw/pci-host/gpex-acpi: Fix _DSM function 0 support return value
> >
> > Shameer Kolothum (2):
> >   tests/qtest/bios-tables-test: Prepare for _DSM change in the DSDT
> >     table
> >   tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _DSM chang=
e
> >
> >  hw/pci-host/gpex-acpi.c                       |   2 +-
> >  tests/data/acpi/aarch64/virt/DSDT             | Bin 5337 -> 5337 bytes
> >  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5423 -> 5423 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 6246 -> 6246 bytes
> >  .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 5391 -> 5391 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6698 -> 6698 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7812 -> 7812 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev  | Bin 10274 -> 10274 byt=
es
> >  .../data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 10274 -> 10274 byt=
es
> >  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5539 -> 5539 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 5354 -> 5354 bytes
> >  tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4603 bytes
> >  tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5824 bytes
> >  tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4609 bytes
> >  .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4905 bytes
> >  tests/data/acpi/riscv64/virt/DSDT             | Bin 3538 -> 3538 bytes
> >  tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2985 bytes
> >  17 files changed, 1 insertion(+), 1 deletion(-)
> >


