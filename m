Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D624C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whlEb-0006zz-Ub; Thu, 09 Jul 2026 05:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1whlEa-0006zn-If; Thu, 09 Jul 2026 05:39:56 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1whlEY-0006MQ-JQ; Thu, 09 Jul 2026 05:39:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yamEWbQPcD5tCyLjkML7I5JYYBCUNEMsbmvpOvlN/ojACzAgnG+IgNC1GUgciB/IA017A6nkAJ2xd1zFERT3+7LWAel/Lg694O6W1zBX0g5x6g7pUiKxqQ1onwqOHBd7WDobdhw6JSI45uBQHTbIKaHhF79aYxENjl2Ng38v0kNYE3fWEi7iUvPHOv1Hq3QzdUUkmN4Di/i8nj7kLrNXA8wPzMXwv9vICpbkSD+evFXL+l6O6R1+RK4x/7bT6oFQZN3HmLCiJuYPWRpiYdC0aWx8RVmTeGFbPOP6spBXMEK5jA2tg1BSmuxX5LnSeWR0n2NWaqjtTaRQnkrQ9Q3p/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYJqvJ7kJMJDxqvMHlEsitiduku4ENAIsTtS5eYu9/Q=;
 b=kd5Lv4LRIbNYoBIC8RhIzZ5XwsSQnOKVTg4rIO5NDyp+udcB3R0PrQHjf2lpdYnMc/Kqohor4w7zrWW02QyziTc0yuU9BjXGMkwVdTyFSUOaBY9MD9UnMln3BdPesKmMy94WcIuBm5y66rvWV6EsfP4YNqzmSkXkwKH6G/Q8gaa/pl+2MyLLspMFWXFATos88VnUpVhJS5u0jkDioVdFXdUs9LVZ7+ws8AvgU9Zifj4zDWoLk9jbfjgnNjfHz5dl+zMxlzFM6Ns7ASfeioEzOhkhhgiiDlNsfWX/U9suSnWTAM3S6oXYYA47LW73x0jfg1yxce7vDAYR62dWAHKPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYJqvJ7kJMJDxqvMHlEsitiduku4ENAIsTtS5eYu9/Q=;
 b=WDCbqmC+7gW0Q/48LV6oNF4J109L9M0vfzpIQ/9nG5P6S9N41nFTR/ayzjOu3s74GnObpv6AaCJmuR/tRTFfToMQgFkUvY2X8NPKlIPbddxkfm2Eq9XjsUhL3W9sO53rsh41JAECLc4N8D3uewZrW7lWMSeJ4yTylwSsjeVpDmNQizEGDjRYChzecdRGL8ppKhMC1ZwPkKI8qVhN1GnBCr0d4VocQdhsFUjR8sx74KxjMAmvWAdJj/uVuts7Lupy05Q2laMqJa/pDbsic/AU2IMZwVXbjFpnIxci9bNi/lxnYwNmlJy7SJ2aRY3ICgCt3ccADElYJvp9XYsSLEjT+Q==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 09:39:15 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 09:39:15 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "berrange@redhat.com" <berrange@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>
Subject: RE: [PATCH v3 3/5] hw/arm/smmuv3: Fix possible overflow in
 strtab_base computation
Thread-Topic: [PATCH v3 3/5] hw/arm/smmuv3: Fix possible overflow in
 strtab_base computation
Thread-Index: AQHdDe29oc4vBfoQ1UO2PUdknqTBprZk8anA
Date: Thu, 9 Jul 2026 09:39:14 +0000
Message-ID: <SJ0PR12MB86143FBA92B23AEE25B20FBCABFE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260707085028.165557-1-eric.auger@redhat.com>
 <20260707085028.165557-4-eric.auger@redhat.com>
In-Reply-To: <20260707085028.165557-4-eric.auger@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|IA1PR12MB6020:EE_
x-ms-office365-filtering-correlation-id: e57cdda5-1d2a-48c9-1841-08dedd9df0ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: knMerYS+IiSiEfoIAx5RXjy5a5mIwVxK44b/8PTbuwBDqyMos1DQOygsBFj7+veP0i/oYSdo+Q/VcaWNvAmFgeEfuklva/dGR6FQRHqcICIVXf5sUt+oX+hDHbIly73l8KqGa/aNLjvN1cAPHLs0YiCh+mDkIr8Eb74ZLvz0m7W72q8TWuaLc8nLvRAzIs4it32Oo1JyoPDGj9M5V5YQUzZ1PWSdeKd0wLvFcnOF9/002/S1d+Lm/PY2HMZdvcaKz7ts+5yho9Nm8u2R6zXR6+T6QrbHOrQRKrkHPqYMwpbKWrYWWd6jgL6VnaZt5/XohFrd21kzJg1FwTZVIiIbL6Ib1mnc2hA6YI4Oc9Kms7P7DNOotoyhYRJvhe6ugR5EOXCMrBE2zUAjAAFlCnhOrXz9U1Dyhz1tlYhOFI2iR1DUS+FbIzSVf9Th+QzevS2tpz+Sbd+xy7hJtlQnPwiBNaW7u2Pgc8glyMvTBpdPVhY3Gu8mnMLm/X5eEab3ENDtSJjb4wcZZm073WIznHOgQnlM/fkF3Qum//j8gyNib8ofJpVq55pnv5zVqRMlRrf4xJsaZF5v2gkFGMnKjFI8GTrFb8+imi1vLEOc/c2IdYj73rfPxcx5HnzcLAvremEY3io0KpjQwRdYtzgRLKTlaTSTTa9QMnnwm87KdHVRM4Xw+++LBTgoBvGJnxjnk/X0LPvT3k6zs/jeCDkZ/5RAZY9SSt4yHMgKFY/5neD626k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N3xYyzrbT85jhumhGVUaroa3Ak09A+8OB/S8JNaDdEtHJaFsvKauVBYmb3QN?=
 =?us-ascii?Q?w0rj9iqlz5CAp+wxa4lV8G9hRdnFsmPDqszcU6ahEh6qgjCt90pvVzSR9wVk?=
 =?us-ascii?Q?bU8FsMs2cU9UagPXvv5nof/9s+hpu9XXJetw/rVERdTXyHTHXEfLemYbXh62?=
 =?us-ascii?Q?2YTzujmP31u6GL3RgnLNPOoBJnOS2oy167iej2x847B3+EwXA78lKau8igt7?=
 =?us-ascii?Q?kfDlGYFgydqS8FO2xORspCQEKWFhBMrAP8pvBNFN/N4Gquh+rFwR5CI4VVN8?=
 =?us-ascii?Q?zTIACc8TLyoXTQllsY0TYEIIR7iBNF6pu9gK6yZzzCiDPohYsRVji/n2pTvD?=
 =?us-ascii?Q?WFCvwLNDTwxbwhmba0N4HTJTex6JUOSWDLiuhiy0ehPLDRyYiJ47U2yqVKzX?=
 =?us-ascii?Q?b87pryjrxR/4gwzlEZbUOeEIPoxMchWzS4cXyT/4hXITWr1ygAoAxdFY9VDV?=
 =?us-ascii?Q?jdNQkL70CSrD3rfYu9HIQf6kzdiZW5dOSxbwsei7BMzWT+K7LvxgGmebG1Ff?=
 =?us-ascii?Q?8WjKvowsp9futT9ajBUfqFGjVXyjv/Mc9mVAhaNchypy1MKFETDcBRQtiAKo?=
 =?us-ascii?Q?thyh4XWdHyuuHAirkE1W/qqrRHrWB0MVN7kjlt2YfBiyzjOK6xIa0Zgxutk/?=
 =?us-ascii?Q?Jf2QqZn21V6Of7QlyL1ht81cqkIFBZp9CI7fVzlykfIflkNncILBILUV+4AB?=
 =?us-ascii?Q?5gtT+oMbzjai03d64bUxR6drJ1XuLz0+N8KVJbwdYSXtcM5AxZAwQP2jWHCT?=
 =?us-ascii?Q?a7+QzjYtlmcv3J/GAynjGc4np9gQHP8L+54hTav+2O08XEeQlosMD8+JbLcT?=
 =?us-ascii?Q?SBeVqxS3jqeio6p9d1uOJswprrd1l5srzr4AA4LD92dXnEoBzJYqQ2iE18Mk?=
 =?us-ascii?Q?Gu0TB20sflI2pqPp/bU5I7X13DXbdpKa/bOeSfVetXaZcQOVqHOUgX21ec0E?=
 =?us-ascii?Q?geE1GWrUEmQMiPNH0lJENGQv80tWWty5EvtZFieWVE3kQdM45t6VmYY1FfHQ?=
 =?us-ascii?Q?uQV2S1wfq4v2kicJKogS94AkaG8M+KazZvtqlDiwo9UZyOq2L7NpCGeFlK7n?=
 =?us-ascii?Q?rnGj02hql7MdVkfZKy/GKY4wCeOku9oKdaUoKFwRb44qmEqWwt45TskqRn5v?=
 =?us-ascii?Q?1Dhxd/g6JQt4MiU4fGFsEZwFCxtW/B4ierog0jqTcsbRMCnjY7cPvF358y94?=
 =?us-ascii?Q?LWE+DS+KM9W3wsnosf3d0/DRZzfjMYLd3463L93heYTbACnzKXnazdJfUNve?=
 =?us-ascii?Q?NppU4XRXqmTYwcAbuWNg2KY+Eey9IYhR/zp6lTKIqEX2z6zTV87InmYTVfaj?=
 =?us-ascii?Q?1r94hco8B5/Dzkff7IcfpmcfcGquXjVWDnhyYrhUW5BBrKD4ib6IVx4P1yBT?=
 =?us-ascii?Q?B44BqQvXq3sSoOB2uhWEpayALxLy8005bUBAFiHzuNeLiDQpZqRCYXmAeVA2?=
 =?us-ascii?Q?LPtdSy5BtQHUctgIXV4oLjd2hjipPXSHcheoaLAaXp14T2387kHfm+WKfe+f?=
 =?us-ascii?Q?H3oN844d79wXalXEwlvzn7/B8zcDK3LS5kk2FDtV4gjz8h0jgXdQ2bTYCnzQ?=
 =?us-ascii?Q?tiYXJZ5zcj3nP0pNZcf6kOcdGIbT6w5CqqJjLUglYQjzrwRjy4vveFoyhkgC?=
 =?us-ascii?Q?7NwvuJJwRZOIvfkWqNLVEqu4eBhdm15ET8ua8CWqBaPltgQQlgkt4Ke8VDTO?=
 =?us-ascii?Q?pUsM4bhlCdc2NDqsz624TaO/BUxbmlqu/s6JsHQlLtNB8eyrQLVPKVNsfxDM?=
 =?us-ascii?Q?KDiN542rSw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57cdda5-1d2a-48c9-1841-08dedd9df0ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 09:39:14.9457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JwmWp4gA5wIp62Paqb+052xTF6aU3/LkuF75yCjcLyejyR/mzjlEhrzVd2AsyruwnymAGcmlXGiyBrGvhOmYhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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



> -----Original Message-----
> From: Eric Auger <eric.auger@redhat.com>
> Sent: 07 July 2026 09:50
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> berrange@redhat.com; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan
> Chen <nathanc@nvidia.com>; philmd@oss.qualcomm.com
> Subject: [PATCH v3 3/5] hw/arm/smmuv3: Fix possible overflow in
> strtab_base computation
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> In the linear stream table mode (FMT =3D 0), if the guest programs
> SMMU_STRTAB_BASE_CFG.LOG2SIZE (8 bits) to something bigger than 58,
> MAKE_64BIT_MASK() will overflow. So cap the mask length to 64. We
> still comply with the spec ADDR alignment computation:
>=20
> ADDR[LOG2SIZE + 5:0] =3D 0.
>=20
> In the 2 level stream table mode (FMT =3D 1), we don't have this risk
> anymore since SPLIT is sanitized and equals to 6 at minimum.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3632
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

