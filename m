Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1845C10854DB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nRY-0004KC-8v; Wed, 18 Mar 2026 05:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w2nRQ-0004JJ-QR; Wed, 18 Mar 2026 05:43:53 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w2nRO-0007Em-CC; Wed, 18 Mar 2026 05:43:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSIcHEOIOiFKthIT4ia4u943OE2PD4ShhX9frKkBAOXFGTnQ3QDKKkjHRhByWTn4HLx2bRYE9ux0DFkFB1CFX32VRE52r/UFRfy+3Pe/fFfNXvsFxDe93i2nq7jX35vsS9datgMK8Ec+s2z7t/mgBqyFJOQ3zXVAMA/m9HLhpbpCkxqndDKKqnR44HYmbM6e4O+W/dfLE0LccQZpZEtYpzHa51hbiyV/kx+CzX+k4pfse03v27b0eBrnUPcdBECiu2TFq1n2/nfeM6S/OXa3CUqL3iKH55uQfbQ2EMExJNYiXaa5h+7pPgX49R3GzTdfXmyuXg0M4slcAtLRYI40jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxPu9luNRoiTI4abXiTiN6a6nHpUDjF4XhNiVY5AOow=;
 b=c+cHK7OMwXdV3qrZYozglUPaJfpCyMajk0VR2e8ioka6NOhU7qa7Hm75/v37dJBPQr0AzW6QClTeRD2OSp1Y2bgQtC0tU6nZIZHRnm7eAU9+xeSjZhnGqt/1kaYNtSQrABzhjo+CrNhzOe+OmXaJGjdLJlPHXAQQfZI33O0Lr1kZHGOZ6bCq79InEP7Tw/18F3mU1d0jgfLJQFVLFI5i8S0u6hRcoe/GbCMOPQtnixMrtJUHXf89G524lXlypsRHjagbkdtgo2gibViH0E8/slsvqUwsa7niOGk5k1ObSnXGK2dN0QjhQz1H5cQbfh/3ZecHK/cjOQ5TSv2QKI1ZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxPu9luNRoiTI4abXiTiN6a6nHpUDjF4XhNiVY5AOow=;
 b=MA84ZF3JUDdpKWfkn9ONGwacYQ8bWpVUNWj2pEHFBx7Mq+0zhQxHKBi5k4aGbNe3xPwZisp8ZxK7LA+wAU2t3C5CZXKyKBdi7GsydtGvUbWg0tUO91++RYR1eHvi/9J9MwrO3PKUOgfbBW1uVYSnCunsWkXCOhRwJLR3AZwL4s+9QZKoD11R7Z+NYsoahcmit4f5H1ODqJO/GWmHZdrWqC3x5mBM5z/YG+Vcm4AoV1+fGiXWp3xMuVHY70VHmnd8RTmVDH/vju14YRMH1OPvQf/bV6Axcxou2+RgTBjqlYDF7tYMY6nGLyqslBKOR8Hj02EfFzrew6ZylCEbYv9QkQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.12; Wed, 18 Mar
 2026 09:43:43 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 09:43:43 +0000
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
Subject: RE: [PATCH v3 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
Thread-Topic: [PATCH v3 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
Thread-Index: AQHctj1EXBRxWOJF90qSnwk8rr+aiLW0CgSA
Date: Wed, 18 Mar 2026 09:43:43 +0000
Message-ID: <CH3PR12MB7548B578F85AE862E3C0A45FAB4EA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
 <20260317183755.3721625-6-nathanc@nvidia.com>
In-Reply-To: <20260317183755.3721625-6-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ0PR12MB5664:EE_
x-ms-office365-filtering-correlation-id: 1c06656f-8134-4dea-03f7-08de84d2d810
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|22082099003|18002099003|7053199007;
x-microsoft-antispam-message-info: xxs2NGwb/ITnxVVCC6/uGfpnnOZoSu/WBdxM07gZ6FS+/1ULZ2bEKXUVfjRdrxEnZe4tHLtViATocDa0e9J4BHl0LUyA2BdVV1VXwUTdFXCJxZUGwh7TUK3TCOzVxIgQgQH7TymVWF9Xug++3FtcUwS3N/eG8Dh5uaxvxqOj4lvUy/2Q0D7J3eaet7KB5juc0sO55caMGaNVmbT1wbWPbAU/WlJ1+767zyg2qcu0LrO33NDE2zE6dm1HuKuxMJE5snf6EzdcrNgLKE3wFWi05/9MfOiv6oVGODXG04CLx5S1RYoudNM5LX8fX/Okaqzf9z9dkZW4tl1bE7J3nEYelShSYBFFSCGMJXBKZw5siLfkRp7vQRtLZSdY1W2S5LBOdJZDyYZFQaP21tOZ+t+QQxbZolK2h9TY1xDt1CU8To5qD+hKpDQ0ySt0FXlWZn8JmtuiKIpUhWRI45NiYceE9YuiFaYdSiucsVWTDDDyAwrfnsp7JgDZndmhIHpdfyvv1KHOg2uYKzOgvJKKUJinZdbsNEn5BxtR+cEjVjwK+HxovpqDJ7xeuT2Z2nxyTXSkn70li4H4soDl3iikcYXj5YrgsRQIijzVflrq1vb8xIN7spT21ggG4b+I74U4oA/GgV2ZtfLtPC0izYmNR3m9MiConLXo4+6GcH975Rt9kQI0uZ+cxEEeAPdGQ4B8RCuwLdKvS01BE/XpMKrWtNqZxfD9FHUrUgAHlTEGk00xveTsiC6gvduNBdNXAi+ubZQxnO0eTvy6XCw7fQ8NHyLVOeARAyOHGSbNGN88hczyC9k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?s+54rBU2w5uXJVZ8UJ7i8U9NQMUKcIFmtlfgu0kLJHnaNMuzcB7l0tal9a?=
 =?iso-8859-1?Q?RtmUCzE8aaOKrLoEm2S3NypDkSMkzQDsKUoqUSLLrapJh11B/RhBqF8pjc?=
 =?iso-8859-1?Q?diR/e1DdwJXfHolJdjFGFspZHrfvmgCCMkB9C6vSgXoQO5ltHeSyUWC8/H?=
 =?iso-8859-1?Q?IhthQDqCT5MDAapWMEJUpT2sQW3aROIj9xexIN5buJehBT5EkfOURPE1/b?=
 =?iso-8859-1?Q?sfMThYdpPiMCtgWv80/f+5EY6upydsfJh+cqmcvBAeOG+89halySifMp0i?=
 =?iso-8859-1?Q?h046J+StJze96m6paTD8i8sfFbVsGGqGGxH7iY43SBlqEWzTYwxw2pYEPV?=
 =?iso-8859-1?Q?DFgQjHfMgq8YvZLEyCRDfMv5aK6n/rnOpcVe469zcXKo4V1EJB33ZQACdo?=
 =?iso-8859-1?Q?55xkqvirzu9lp7BaG1Vgv6TPHCXWfvLwGU4juscgQY5QVDu3N5m4xnLeK5?=
 =?iso-8859-1?Q?diEFjS97jXjYTuhqvxXgka6kNuNzMvL2fplvtND3IxMKtppJVPelLlQnP3?=
 =?iso-8859-1?Q?YStvQ/0a+stg2/nwzzof82Uv5BjL8FP/lfvNZDHdSTH9sblDCLZotPS9r/?=
 =?iso-8859-1?Q?mmjpEXJOMHYavjX7lhtf9FQkKBT0ee7sYUbHtXMCVXPs4FrlSxH90HCQzQ?=
 =?iso-8859-1?Q?7HXjDUkniypxYYDZvou4DF7VdkVlVo5DSgbyW8xbKVNCs6td+ik250f1Fi?=
 =?iso-8859-1?Q?q0t0yQrRpmXRtm2eucbUAlpCTSqoEWRy1AsJwYvuxz3/fO+P2N2mecc75s?=
 =?iso-8859-1?Q?a9iuDNmWEXKO6DiGcSz7VdfFDs4WVXkgp+A8Gs62+LeOVsABjPPGrZCHtd?=
 =?iso-8859-1?Q?1Kuy8cXn+7JgDdnkSHIckNRkgZFfNgErJa6kSW9kdbTJevz/ARC7uoHwRa?=
 =?iso-8859-1?Q?nUKHiwKlt6fj/Lt+Usx3LYIWLQNL64Hkp72Elz87bQffieaKoNqXvsHC0V?=
 =?iso-8859-1?Q?QOC40x+F4Qi9FQGf+VojNOAxTM+kBh6+QK8hcTiCzgTM05VmARze+8ZS90?=
 =?iso-8859-1?Q?uwqHtYiENb4sHxDVr/vL5goGA9H4NzzlxiJV+3Mohgppg2r6e6gY6JI1NB?=
 =?iso-8859-1?Q?IWrdpZFs2OiPte24J9cPrtF6rT6dDmaLTLwPL6hL19Pyg2//JSX0DTAG6c?=
 =?iso-8859-1?Q?I/8TrqyMsZ/6SyNvoeL6HhDlbkcq/5AMNrVTs823HAp2V4jz9sYbCzA0OH?=
 =?iso-8859-1?Q?2fnHfS02x8y3GK6WZ91Q0Ihn6K3DPNlVTtV1jvj0t1WlUnnBf4xY/xp8zB?=
 =?iso-8859-1?Q?jFZ7C+ojENj3iTUtHn0pcxvbNav6jraXj1khxSLBFqWdLvOeUh6BBwlUpt?=
 =?iso-8859-1?Q?uXgimed6Kvdoq3KIa0++ihxTCrqQ0BuQJ4r4jEpOL5HjZzTkZIKyIAUpgd?=
 =?iso-8859-1?Q?oXe5wjv9fg8+m64tT9V4SbOeH+15Dlu9PYwUJQYhZIw0+jbmsVbyGsj583?=
 =?iso-8859-1?Q?8uiTKgdeiY9GghVBkqZF9d6VswoRESfYKtZyG92gn4QHuhkTPC+G3lyn9e?=
 =?iso-8859-1?Q?CRkn7BEqDcjKvjtMX6cjxfLK4gzPg5XLbGBeeFkkCC+vjfFUJN5NEV9pTH?=
 =?iso-8859-1?Q?nOs1PScv81uUQqENcA7CoJyXeiADTUicqI5j0b9CQRhPQxUNGBTyUUn22p?=
 =?iso-8859-1?Q?pP1FypdTQYio2au0XHGEW3JRL6Qd4NSTd3CKGP3OV5SnAWpxZLE9wBFu3J?=
 =?iso-8859-1?Q?kOuzMxjbc5bPujI+sSNoUcHkFMeyxxrSSvlRJGu8iHHtwn+pYBuDAQvMb0?=
 =?iso-8859-1?Q?yAU5aULDKQ/NGPRoqy9caCVG7CLN6qIwLihgQKIutKkywQ6eR/aXAYNjM5?=
 =?iso-8859-1?Q?oWxUbrtOig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c06656f-8134-4dea-03f7-08de84d2d810
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 09:43:43.5509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3sv/bATITl5npzhfm/eXloPxcflKgEReLhQAqKVAnaLDIl8RJMCpWkJWm+0PJzk0umk3KsZVhXlHDkIQ4ahpow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
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
> Subject: [PATCH v3 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
> SsidSizeMode
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
> The 'auto' value is not implemented, as this commit is meant to set the
> property to the correct type and avoid breaking JSON/QMP when the auto
> mode is introduced. A future patch will implement resolution of 'auto'
> value to match the host SMMUv3 SSIDSIZE value.
>=20
> Fixes: b8c6f8a69d27 ("hw/arm/smmuv3-accel: Make SubstreamID support
> configurable")
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 23 +++++++++++++++++++++--
>  hw/arm/smmuv3.c         | 18 ++++++++++--------
>  include/hw/arm/smmuv3.h |  3 ++-
>  3 files changed, 33 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index ddd927fa80..c90fa9f5bb 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -802,7 +802,7 @@ static uint64_t
> smmuv3_accel_get_viommu_flags(void *opaque)
>      SMMUState *bs =3D opaque;
>      SMMUv3State *s =3D ARM_SMMUV3(bs);
>=20
> -    if (s->ssidsize) {
> +    if (s->ssidsize > SSID_SIZE_MODE_0) {
>          flags |=3D VIOMMU_FLAG_PASID_SUPPORTED;
>      }
>      return flags;
> @@ -817,6 +817,22 @@ static const PCIIOMMUOps smmuv3_accel_ops =3D {
>      .get_msi_direct_gpa =3D smmuv3_accel_get_msi_gpa,
>  };
>=20
> +/*
> + * This returns the value of a SsidSizeMode value offset by 1 to
> + * account for the enum values offset by 1 from actual values.
> + *
> + * SSID_SIZE_MODE_0 =3D 1, SSID_SIZE_MODE_1 =3D 2, etc. so return 0
> + * if SSID_SIZE_MODE_0 is passed as input, return 1 if
> + * SSID_SIZE_MODE_1 is passed as input, etc.
> + */
> +static uint8_t ssidsize_mode_to_value(SsidSizeMode mode)
> +{
> +    if (mode =3D=3D SSID_SIZE_MODE_AUTO) {
> +        return 0;
> +    }
> +    return mode - 1;
> +}
> +
>  void smmuv3_accel_idr_override(SMMUv3State *s)
>  {
>      if (!s->accel) {
> @@ -842,7 +858,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>       * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if
> user
>       * has enabled it.
>       */
> -    s->idr[1] =3D FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
> +    if (s->ssidsize > SSID_SIZE_MODE_0) {
> +        s->idr[1] =3D FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
> +                               ssidsize_mode_to_value(s->ssidsize));
> +    }
>  }
>=20
>  /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding
> HWPT */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 40d6aca83e..e7fec7a69e 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -20,6 +20,7 @@
>  #include "qemu/bitops.h"
>  #include "hw/core/irq.h"
>  #include "hw/core/sysbus.h"
> +#include "hw/core/qdev-properties-system.h"
>  #include "migration/blocker.h"
>  #include "migration/vmstate.h"
>  #include "hw/core/qdev-properties.h"
> @@ -625,7 +626,7 @@ static int decode_ste(SMMUv3State *s,
> SMMUTransCfg *cfg,
>      }
>=20
>      /* Multiple context descriptors require SubstreamID support */
> -    if (!s->ssidsize && STE_S1CDMAX(ste) !=3D 0) {
> +    if (s->ssidsize =3D=3D SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) !=3D 0) =
{
>          qemu_log_mask(LOG_UNIMP,
>                  "SMMUv3: multiple S1 context descriptors require Substre=
amID
> support. "
>                  "Configure ssidsize > 0 (requires accel=3Don)\n");
> @@ -1984,7 +1985,7 @@ static bool
> smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "OAS must be 44 bits when accel=3Doff");
>              return false;
>          }
> -        if (s->ssidsize) {
> +        if (s->ssidsize > SSID_SIZE_MODE_0) {
>              error_setg(errp, "ssidsize can only be set if accel=3Don");
>              return false;
>          }
> @@ -2008,13 +2009,13 @@ static bool
> smmu_validate_property(SMMUv3State *s, Error **errp)
>          return false;
>      }
>=20
> -    if (s->oas !=3D SMMU_OAS_44BIT && s->oas !=3D SMMU_OAS_48BIT) {
> -        error_setg(errp, "OAS can only be set to 44 or 48 bits");
> +    if (s->ssidsize =3D=3D SSID_SIZE_MODE_AUTO) {
> +        error_setg(errp, "ssidsize cannot be set to auto");
>          return false;
>      }
> -    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
> -        error_setg(errp, "ssidsize must be in the range 0 to %d",
> -                   SMMU_SSID_MAX_BITS);

I think we can now get rid of the "#define SMMU_SSID_MAX_BITS"
as I don't think it is used anywhere else and SsidSizeMode won't
accept anything > 20. Right?

Thanks,
Shameer

> +
> +    if (s->oas !=3D SMMU_OAS_44BIT && s->oas !=3D SMMU_OAS_48BIT) {
> +        error_setg(errp, "OAS can only be set to 44 or 48 bits");
>          return false;
>      }
>=20
> @@ -2145,7 +2146,8 @@ static const Property smmuv3_properties[] =3D {
>      DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril,
> ON_OFF_AUTO_ON),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats,
> ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> -    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
> +    DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
> +                              SSID_SIZE_MODE_0),
>  };
>=20
>  static void smmuv3_instance_init(Object *obj)
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index c35e599bbc..ddf472493d 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -21,6 +21,7 @@
>=20
>  #include "hw/arm/smmu-common.h"
>  #include "qom/object.h"
> +#include "qapi/qapi-types-misc-arm.h"
>=20
>  #define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-
> memory-region"
>=20
> @@ -72,7 +73,7 @@ struct SMMUv3State {
>      OnOffAuto ril;
>      OnOffAuto ats;
>      uint8_t oas;
> -    uint8_t ssidsize;
> +    SsidSizeMode ssidsize;
>  };
>=20
>  typedef enum {
> --
> 2.43.0


