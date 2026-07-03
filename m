Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDDFC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfaLV-0008Ov-C2; Fri, 03 Jul 2026 05:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wfaLT-0008OW-TH; Fri, 03 Jul 2026 05:38:03 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wfaLS-00058v-Cm; Fri, 03 Jul 2026 05:38:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaz+o1bfhCAS6fFZ+boiwoWv4Hy1PA2XCx0wkdK4PFxLP4nHqsqS/dO5tovtNhpWjtCrNZh1bSa35nkqwsOfbvlJY3C1Um1037qSYwe9UR1qm0gSJLP3s5g1Tb2u36RiXT/55gJIBCYkukdrgkoXyoERSy/9YKqZEAcATVH9UdxVBv3xJfQCFIWGZ/CzjSHotz4iyKFfoYX8LBiWtFIMBd4aTV8DsNtSJUDBMjhmUr1pUu5KODb7yXil5M8gCNf0nJPqtQuQOg00R/yDTgDZ4dapj1c4/KSbjfNHBPCUideyR4L0bOYXleehTdrTR/mWILuNUqsPbaV+3kjgEnFfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vs86aFFrWBBuzxawuVWmzMD7XvkPkPNXvjuXcfQO+A=;
 b=aDXHIj8Q7T1EWzYafA5/hKsVSzM75xt30VM7HqDs0wZXUV7vLfxGXf85KOQZCtNC1WxY9Abcj23p7xTlTvY0iycfIj2qZEQxMgX9rU6zXEq0Qh1GEsLfVfkU3BBlPhCx1RW1gCnOWn+Wd7nGhM+21dT9tj26zKzIFzTZOFVuIe6K+ibTpEBbLMyWCyxBMp1aDQc0OQcSNxwMKgDlAW7XyvfScEXYggmixmcTPWSYnTzbjtgU7CYE+cYfIFLPBLfBGEILQrLEYaMUV87wZw1ZNurH4+qO8TjoZ5ES30ezl6IYcSRtDV0Z/vzx/CiQwYBWCVl06kJB9oHXzDxbRZVtkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vs86aFFrWBBuzxawuVWmzMD7XvkPkPNXvjuXcfQO+A=;
 b=UzQF+pBjmFqhZR60TcCh1SSd2VVSgQLpOwRFZbXa7Qvs4LyUYvGELOPhWifcXCj1tQRmrZQ6DEsQCNNE9LUij+1A9spozEIdeGJWD82cIfbRaqwTM+IL/QfJ9CGuQJ0J72rUI+fnBtyQlqt0/Qo0s03yzu2JI/zdmbfQeeuKyimb4LlJFg91kM1JyJ/LdCy4vZNVPKp8EBKxKfoISwXq2FRy9++LrjHToEfHf+gLUYP0uCl1sLbFQYcu1cp4ztuCUdn0j1yPW7Z9CaainqrFHKvCNVgzi+TWWneE1O9p4yG4vrljQ+hjox614eot0aAMSJFPGtoFPVNTgp8cQIpRMw==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 09:37:55 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 09:37:55 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "berrange@redhat.com" <berrange@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: RE: [PATCH v2 5/5] hw/arm/smmuv3: Enforce alignment of L2Ptr
 according to the span
Thread-Topic: [PATCH v2 5/5] hw/arm/smmuv3: Enforce alignment of L2Ptr
 according to the span
Thread-Index: AQHdCTnFQjgYzPXkkUuRTyYodqpLzLZbjKag
Date: Fri, 3 Jul 2026 09:37:55 +0000
Message-ID: <SJ0PR12MB86149DC172C5F4F34DEAA1C5ABF42@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260701091209.2860306-1-eric.auger@redhat.com>
 <20260701091209.2860306-6-eric.auger@redhat.com>
In-Reply-To: <20260701091209.2860306-6-eric.auger@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|LV2PR12MB5725:EE_
x-ms-office365-filtering-correlation-id: ececa953-d773-46d2-0d23-08ded8e6c2d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: etw7Bvh9/5lbvBTOf91aIEppxaOqGu9x/10v2Hw745nEM1/qgZ9lTJCgP2eS92EgPAuj4arrdxdW2lVFkWR3Hhx5CS4lxuA4J1YP6etKWe0umZidYHDAiGnZQLQS1c3wJgtcZIK91qgJXkleEURude05sx3r0Awh08w/iCvvSqlhbDXTtQaeVkpTVAIQ3Cfy4KVepGRBlPxYozrSK8gaTvyhmRq5MK5qstIpBe7C/38FlB5DRW3anLCM/zsAAmermpdCQKgntYEvtzmxgjlZM6zSj1VkqOHdDw/owWM3nyXt+WrX0/3J9KWdD8MJ+x1Psh5XRIFRcTmXphH70Cz6ZkGnv0GRxObwMprZ0n1Ow0ao5yW70JyKr9Nz80qBo6vWpkJw3GyEIDTW3N4iMjEnINOKFEURd8fuh78fM58a+yjGFwQgb+i1j7F3OX3OOBFReqw+NGmGM0GaIBOvAgwf4G6joVChZunyM+BgKC5hIq4ci1t/s9J6Zd4MHCfR3+dMJPK/RFRsuaUCbwLUIBa51vuyNXG/9DXcy0oPewRp+GTUi9lw/IRMEC7r6oCr37WFJiHItNi1flraaPQ9npsF0ZspcVAaBa5dpacWGqOfj4f/FVOebb4Vp/SfKv+Qm4UCgBcV4jrMo7I8O/5qpnYBPPG4HDtfWlcUAy9dwosijmHL0GkHisj3eXqeUMbkjFE0jl3RcnFGJfjz7jkZ/zC90C3g7W6OhfLpjoFkSMn0q4g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ThYBZSbld6NNs/vkuqTmmRlG8x9TBR0MPPUHOv4eUucHCwpt+Q9/2VoA9hOp?=
 =?us-ascii?Q?1z/wxQs1sknyY75Nuzup7yZbRNBvdJeQQtn/e+rRyfJWQAfQZr/Jfd4PIANb?=
 =?us-ascii?Q?V083iZOuB6QJ2/pd4sGD3csKqr7GTggBvvK47o0eUrIkiq+Ifj/ZvipNOwhS?=
 =?us-ascii?Q?hdkqgoSn+6T333DOPPsUugsRObaeulEOdz1IcDYCQCdTtIe3bFxdWp6eNShA?=
 =?us-ascii?Q?wCl9Fn0qaBDvHQc5MuP4/NdDOMY9gk4lKkWL/CSet7+YrdlXBaf03Jfk5Zmg?=
 =?us-ascii?Q?EklOT3oUFV3WTqK+yQvEeoNjwxMiKM2im+BkLHiBUpVUHLdsB37rGpaMFpqG?=
 =?us-ascii?Q?oZAWd+5f9Iqge5AhG3OKAigALbOziVnVul+OraQEbg0tEqqTEKgWKkbLmf5+?=
 =?us-ascii?Q?w9/BCSFfgxvQzjSfszaNRCHCBdM9Hmqnoq3e5NjmByT7PBBaE4H0z/bYXOED?=
 =?us-ascii?Q?JBMO/EsZ/xGglw0QkYqZL4rrcghBEb3+7cX16ZVbnfAknReHZgocWvW7JSlE?=
 =?us-ascii?Q?3+nCdRBL/JAONOm7ScpnWdkWaD/K09rSmkdywJc7J3GXlSCHd4Hr8FPhZTW0?=
 =?us-ascii?Q?/8VooS5JyZBEffZJVYdK4QeTn/QlSOsm+VqWUy/jCxXP+i0bJJeJHm6Bf6f8?=
 =?us-ascii?Q?StcwCsKl4SHehUyulqF/QzmJV6JOf207ld6OxOnWkl7mwDKKcwoKLS7JyX8b?=
 =?us-ascii?Q?t5ANTysOF0mpNiALxcWDijqZzfGygZtFd6aW/MxhxWMT0K/xpsZnmyevO4IN?=
 =?us-ascii?Q?d/X70ZXIyTzJ+j5uPpNkHBdllVTobx9hiu08cxiXvV6iWMYRRp8PV7JusyYz?=
 =?us-ascii?Q?WCFLOLk7El93XVpFoA/J3Aqz5hVlIv/8A8vZcSl/xMPw0LtA3rjow46TY+pC?=
 =?us-ascii?Q?/dfCw2lzfghsTqUJ6QEpGV8HMgd7ar9hvbeUuvCbJkFf9RvSx1nlDAbsNshi?=
 =?us-ascii?Q?Z6lZwE6UblppJ+tNYD1KVbyVEDjDOaiG4N5A885W4ynwph8psSP24B7C4sgA?=
 =?us-ascii?Q?EaQbWI7VjG3Wmn0xGUQVE0fSBTPOkzYcdeTil+htA0JUJONEf+AODr6Xn9Wn?=
 =?us-ascii?Q?wLJvwflspQ/L2xezWwrBKwrAZxfjzM7EVJCi5qlM1bgjV1hG11BUEJCXXtxi?=
 =?us-ascii?Q?mtLCCIOabCYxlsD32U6SFurUtxiyuKICjAzJtJTg8dZXliDxhx+JNxDu948G?=
 =?us-ascii?Q?fDOhQ4lvc0xZjiXB5L8CruMYxrmZYvADXIvl+oBi08wxZyxIvQd+7rmjgnCf?=
 =?us-ascii?Q?YQpJF3mUDq2chdcrR3NGB3meG89nPpMEZlHvzScGIUVTgA2nuxveqYvebfkH?=
 =?us-ascii?Q?d2KQ7nAxc3IjIsJ21wVkSadPCJU996Jb7JIQe4S+YMEMtADxJb7LHeyiP9Ir?=
 =?us-ascii?Q?gob3cAqf1T4aFckS5bygA2n4S29fjJgew9FZaN6/bSccb0BUV6lZ5yEBPKvJ?=
 =?us-ascii?Q?E6p/ddCV652GAJU0EdcxmEVieAJBaJNt7r0uhkOnUHPjRa6yD/V7KE7OsfyU?=
 =?us-ascii?Q?dgPQimQpShyoJB/KOosYgPLZrd8KpDRbBaFDIZbRWEOVLwETZpEOl0dWSn5H?=
 =?us-ascii?Q?ECiNdjOzFgTGsQUGrtzeQBAqGi+rCKfBn210EprBytyhtCUZWzjDaMwRoK2j?=
 =?us-ascii?Q?vjavwDaVnIsIth4c8b+PNIxVo6Sg/JvfV5Pgk3db3p8cMaR8bVqy0ICZNKVi?=
 =?us-ascii?Q?bB5ni/3CD7HDarYtcqfLBbIHvt11Bc8G91xd8gT2vvTQrFcC0uknOwGNWwkd?=
 =?us-ascii?Q?9YSxTKa2hA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ececa953-d773-46d2-0d23-08ded8e6c2d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 09:37:55.5841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hv4/21hzEJfTDOSY1pgKB6YGb8TTH51jTINdoxjQrC1MmHBQHFcYyBkft1FmEAIuB9g7lyAklg/qtPgcoNgPGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
> Sent: 01 July 2026 10:12
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> berrange@redhat.com; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan
> Chen <nathanc@nvidia.com>
> Subject: [PATCH v2 5/5] hw/arm/smmuv3: Enforce alignment of L2Ptr
> according to the span
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Spec says: Bits L2Ptr[N:0] are treated as 0 by the SMMU, where N =3D=3D 5=
 + (Span
> - 1).
>=20
> Let's enforce this alignment.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

> ---
>  hw/arm/smmuv3.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c index
> f694f832598..7eb2c59d9eb 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -728,6 +728,8 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid,
> STE *ste, SMMUEventInfo *event)
>=20
>          max_l2_ste =3D (1 << span) - 1;
>          l2ptr =3D l1std_l2ptr(&l1std);
> +
> +        l2ptr &=3D ~MAKE_64BIT_MASK(0, 6 + (span - 1));
>          trace_smmuv3_find_ste_2lvl(s->strtab_base, l1ptr, l1_ste_offset,
>                                     l2ptr, l2_ste_offset, max_l2_ste);
>          if (l2_ste_offset > max_l2_ste) {
> --
> 2.53.0


