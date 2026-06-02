Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616E9CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUKC1-0003pT-82; Tue, 02 Jun 2026 04:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wUKBv-0003p7-OO; Tue, 02 Jun 2026 04:09:40 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wUKBu-0002Sw-6D; Tue, 02 Jun 2026 04:09:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sX/YFbiogIVewMgV/MHbfTo+NkQaC+Xban4OayoS2itKEY+DCiq1NLT5d+jsoa53TGNel2tH5OE9xxccsMi1o3LH3/cWZDDJhsoPuB2DJ655hpvw5Q46NMpUefNYwx1ZIdUANNFx2kR+t5VrVNpY8mSSmHPeWhNaRARtcPK/5+FLbhMcNnV8xuDM9zmT7KZKAU0DcIeqCIm9YjgguTOeQ38Y/0EubcQdKL8GPJ5q8gVenu2Qo1UU946qe8SnKbOTHoEHSWn59bPa0Wf3OrL1C68UBFY0kLI09j8AbwXpzyN75F/4cBHRVU/b0SA7t9l+zlINv5jIr78fQ279wi5aDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzOY6fotPy+fM1NA27ScOFkqp9SmHJzScM767O8sgFQ=;
 b=NkQXvBN2NKoVWvmwH/TXnSfxSKnB8F6uy+NO2amdYaG5go11h8Hpy0wCoLuaT9PSc8u4RT89RBcz3P5Xgu+LdW7Cq9xP4MSwWxPq7pRJ20Gk7fybPzC7zgfI/hHIODwaBWDkq6dZFDoRnVw4KjxaWw2UOUhLMn/aWAu3b5Yll0HXVJyzUNaJ/d3f2gJJpTDWdsHYSfaqRkYf1WwjWZJehzrzW4bWnvSoasDKPBaojqQ7cMLT6muFWmkDh28wr668AEGhvxd40UVUWXhLgHL7wo8U3c/+Qft3UD8qxsHCEjto7XNhJni4879KDkyB6eDmHseELhkc1xd8JYCRaiM3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzOY6fotPy+fM1NA27ScOFkqp9SmHJzScM767O8sgFQ=;
 b=Pzg5iaZwv2UjjKtaoyyU5GEoR6ieDwIWVjDiAZcBVeBGYs1RP027ycng7BwcBPtdjhTcboKuxlTHdY+3CFZSzojtDaZM2b6jJBJm1onNzqJz3jsjm3waNpHBN+1uphIZf8v8DrKkXwxGsAnK+yPwPwc4jEfbWTV2Q2XZqwQL6BGUx03bjRqKnMoQzxaDgyEkj/O/ByuAMdRrzX7J1NVk7vrXK/sffY93WzetPEm+4M9HQbY//gCKhD+ktYYvhVav/yo2JT/nyjtJEmMh/kcKKcsEZKSczEvBtEUcp15pOg3aeigogXy+yJ8axpjBb8jLe82TC56F1qgDIn3kExSA6A==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH1PPF189669351.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::608) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 08:09:26 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 08:09:26 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v6 19/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Thread-Topic: [PATCH v6 19/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0
 as VCMDQ backing
Thread-Index: AQHc8by4fuaRR8TZcUOzaPeyLp//M7YqQiAAgACklNA=
Date: Tue, 2 Jun 2026 08:09:26 +0000
Message-ID: <CH3PR12MB75482E65685278D467EC6462AB122@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-20-skolothumtho@nvidia.com>
 <ah4CPKqNMnRfuSxT@Asurada-Nvidia>
In-Reply-To: <ah4CPKqNMnRfuSxT@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH1PPF189669351:EE_
x-ms-office365-filtering-correlation-id: 15fd627e-a034-4768-f434-08dec07e434b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|11063799006|22082099003|18002099003|56012099006|4143699003;
x-microsoft-antispam-message-info: 0Ik8bD+psCDtC8VwRlcUf7S/CWcMrF7DuPm8KXSLcmel6jJaR9u0zCM4dOM7PnJot8KBPk5WUZPA52wsEwulYEwf1C6SNDAOerx6hC5NIzKPEjU6gkrNOb8ybAPj0v91EnFHCcFexxbUgzOPjVPoC67vHwuJ6hTKWDpypcdX7oXWWvnYcmpCBcPToVJv64WcgWAcdiS3mA2XX7Nv9RFqwZVfmNl/r7CuMUuUzLho91A3Cqq0Ums3C+v72SVPmLe9OcQ1xEfgN6fAsCJRmvyEfnJnHsEeSfF44l5T55OqTFkgcYqW2QRCjm6CTcmHK2xKoOl4Q5bHLcqGtMCgGlrN7eGenE7nQC0Sx/9Dp9trxJ1MfiuRJYqvK5ZpXLvRSqNpPbvmCjllrCiZCuH46xk+7baIW/1qZzCeGFJhXjpLo30dnEalB+NfsjeoSYYl69uWrnJJa3foSNPbnbi+d2tvCQ6vXMHmV2O2hh5C9IrMBPdHbPmOySBJWzFybjre+yvpfTy7TO7q21VYkT/mBeCfonWExosLAEIJnEvCBDo94KvwgrvbyMMv48OO219JUImyf6ZBz4/9Ho9IaJCtH/Ypt3L/2Rp25EmgAtly0OFgJ+JojuBaOSDBPk2V3KRrDXs2kGJkBTx6epA9VS9zHNfCWBfXVTThy5EqaV1j4V66UsI4H4JojKVVklhArHJd6LJ5ti1aVSUtbiQozWiaSsYuEx9JkH8ZcqacYcs17Ywuv6smgVEK9nNWbdjRKBVA8HTE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3q/j0NIOP9/6juvECXJa18pa/FAYezsSEyInycO/HNdCtrBpoc9VcrQq8sRl?=
 =?us-ascii?Q?Sk4BHyqlymkt9E6OCBUsqqIif0S7NcohofMn8e1z2glwMnJWxcKaHlDbcMKV?=
 =?us-ascii?Q?mcbrNcTI5QzcsTXsmhPrk/xacdkuK5xUCYYLvF2ZsV29Sv6BL6hb0JJ0QkJ3?=
 =?us-ascii?Q?GPa0u2qjT/oteFjOUoiPIOHAq6tnlGGg1ErLPNnfhUIDPK5sImn+c+boMkln?=
 =?us-ascii?Q?Qhcj12407vqkd0YTlFDD5EoklssmTyHwJKHdTCn8jDUPyYz5Omxvn4+8po3Z?=
 =?us-ascii?Q?NJSUSlvnUMNLiqXNIEdlYY2GNw2snxDlHmkzTE2o9aiNlqp5OjHDAdTR3cta?=
 =?us-ascii?Q?J3aF/JEUJ9sulJgCPMaumFWUPHA0RnYrXG6YTa7sTWcGaKRjQI84qukxvhJ7?=
 =?us-ascii?Q?huWKRWtDsjmrKuuVDjBgQAwOp5nN3yVoIFoXTapUr+pFMdAIVOrl6gP9XPnt?=
 =?us-ascii?Q?e0UdWA4fGHM4G+XdYtDj6wZqYW1jkfcIC53GPukudb+CFvQrSL/m4Q64nuBn?=
 =?us-ascii?Q?ltcF1h6ZyUbMvN9gzesAI9HBc9CwYuNNamjZBHBXQNiHMDXT9eHQ2Ta30Mfx?=
 =?us-ascii?Q?jtLXUmcTBRgEbs6oIgsUwK/xFNeM6v8knnYuhdTiQTpKW+jv+emcrD9sflyN?=
 =?us-ascii?Q?n9kN9rvBQ6EXqrIvrbIU0QALRFg19gHRSfw3AIMS9y57FAh92Gz6DnUr/BrJ?=
 =?us-ascii?Q?HFg8zP7fO/S9xrf/Ak94MDMLJCFbK4pXz8a7cSWRk65fYUYh/g8hHbqt+caG?=
 =?us-ascii?Q?uSpjL9/51PF2++A1t4YDbXCpc6lwEtntVT+CTn5LPI4JCtxLNWegD6rW22o/?=
 =?us-ascii?Q?9nuXSkvaTXEoOuDFTyI/MMIUivfyjnKJPbb7BUlfj7FtoTl5JrS52jxmvJz0?=
 =?us-ascii?Q?AwCRNbf0w5bDfsPvOtrI/I9t2U/ApCzuWTM+G7p4r5qPkLmUtOTydIVit6iG?=
 =?us-ascii?Q?MxuaSUrk38hims2awQzxoVQyr0ZIxxBWudaJza8Bb0hdn/gL+sM5Ev1l7px1?=
 =?us-ascii?Q?JzR0M/UPdPyR0xD9O7Bjrru/gpsDo850xKuVTP23eFFV/tzBP5WeYrE09n4e?=
 =?us-ascii?Q?WAEkRjeqw2/cvmn9rDgBQVORDQIR9M0dqA7tIfiHzkPkj+5nKAxzrh1yLBFJ?=
 =?us-ascii?Q?9QunnR7YQdTU0XDlTJZUTuG0ilT0Gxc485wON5uvLzbNtkq+OXwDtxPmfrgy?=
 =?us-ascii?Q?ZK/lSjVFVB86siMn0N6FX/U+Wxolx6GRAMH/sn3KLOqB6up43T312g0MD14p?=
 =?us-ascii?Q?LRCmoXrsoBPEm9co5fJNQtPZYIXsVneJ3QLEDa348GGcO0E0Sr6dr0bnURPX?=
 =?us-ascii?Q?Id1ny1RDoHzyjJGw2QNfGpvD4JTLTmSr4DImo0LAeXxSKC8GwuLKvzfX4n7y?=
 =?us-ascii?Q?nY7+GI8R/rpLoubfhoZ7MaOK2ZfjhW6JHqOW8p4a2nT66JjEF7MUjYlBc+z2?=
 =?us-ascii?Q?YJCYh6Phl+sOiw1fx7SjMGLPzR18SBHVEfMCH1/2W+IQN7bjddo/n2MKt2hr?=
 =?us-ascii?Q?EngGtXqvif6WhxJ07n7mulzsIsLicvl+sql4jY9mRr0vh20x+oY77FmTg7qp?=
 =?us-ascii?Q?xK0uZqYzZldTZkJGOkOslvgI1cnd36F0/T781wAMpACeftVe2stiiDTlztET?=
 =?us-ascii?Q?XDzlpJV9AUqEMdPuwzkEi9oks/3NbmHgHygbT+oPYD/l7IhSgSQnyCYQeqKS?=
 =?us-ascii?Q?pNEKFS9OfdEeafy2I2AGkVVFBskSj4p5kD1aMxiO8eRC7NLLCpQND861FMa0?=
 =?us-ascii?Q?nEmtiHAjHg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fd627e-a034-4768-f434-08dec07e434b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 08:09:26.0231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcAf7kgOdFUlOgdtyHWSEanyGQxJ6XEhb+hMfIQ28/c6AyJZBNRoJ/Ot+99CMMJcTveoOFQnvUeYlDZWTofeHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 01 June 2026 23:06
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>; phrdina@redhat.com
> Subject: Re: [PATCH v6 19/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF
> page0 as VCMDQ backing
>=20
> On Mon, Jun 01, 2026 at 12:42:09PM +0100, Shameer Kolothum wrote:
> > +/*
> > + * Return a pointer into the mmap'd VINTF page0 for the VCMDQ Page 0
> > + * register at @offset0 in VCMDQ slot @index, or NULL when the VCMDQ
> > + * has no hw_queue allocated or the VINTF page0 is not mmap'd.
> > + */
> > +static inline uint32_t *tegra241_cmdqv_vintf_ptr(Tegra241CMDQV
> *cmdqv,
> > +                                                 int index, hwaddr
> > +offset0)
>=20
> I'd do:
>   tegra241_cmdqv_vintf_lvcmdq_ptr()
> or just:
>   tegra241_vintf_lvcmdq_ptr()

Ok. I will go with tegra241_cmdqv_vintf_lvcmdq_ptr()

> >  static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV
> *cmdqv,
> >                                               hwaddr offset0, int index=
,
> >                                               uint32_t value, bool
> > direct)  {
> > +    uint32_t *ptr =3D tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
> > +
> > +    if (ptr) {
> > +        switch (offset0) {
> > +        case A_VCMDQ0_CONS_INDX:
> > +        case A_VCMDQ0_PROD_INDX:
> > +        case A_VCMDQ0_CONFIG:
> > +        case A_VCMDQ0_GERRORN:
> > +            *ptr =3D value;
> > +            goto out;
> > +        default:
> > +            break;
> > +        }
> > +    }
>=20
> Could stuff this into the helper? Return a valid ptr only when the
> offset0 is one of these four registers; otherwise, return NULL.
>=20
> Then, here if would be:
>     if (ptr) {
>         *ptr =3D value;
>         goto out;
>     }

The helper is shared with _read_vcmdq_page0(), where STATUS/
GERROR reads also need to route to the mmap when allocated. Folding
the above would require a separate handling for "write" inside the
helper. Could do. But I think this is more readable...=20

Thanks,
Shameer

