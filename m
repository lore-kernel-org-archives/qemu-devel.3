Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35AFCD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU34B-0002vB-H2; Mon, 01 Jun 2026 09:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU348-0002uT-3t; Mon, 01 Jun 2026 09:52:28 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU345-0003HK-Jo; Mon, 01 Jun 2026 09:52:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5C7WMdI3gRtNfu3UrRJYmmqMsZP4bqc7F8dqjpRVkRXyGD/9yh6RuZPnPIhC5lZ3kMYDMVlyahwhaU99doTFXcrhKDMuSvpNP0h3irdGrd+ogmADn2hKj+Zet345E/7kPoa9Nr5NxUV/6nVE4MvDyE3efyJ4FyjIVPQQyeoKPfuCkM9a5HZltgYsPAJXNfG5mZPD3XGhfHH9lTZ4KNumtwhattZ6nyRvIMVK7xAIkdup5rtnmbCdrrSfHc1lu/pBiRzl6qkOJjQA3uYNDoCRXmMzv0qYhCLU+ZBgxTrCelvQm5ubUOdDWd5p/nYGThRGufPVyJRC1UCLIfMAZNJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+x6o3K/NIgI5z3dJ7RR2lixYxYsNxxt6Awh+FXg1OJk=;
 b=Lo4Zd/J9iNolbnoXRIl/8/3PcXeFqwwD8SuJaa2F2YxC3jKC4kyXTAOy+XEjKVvVojMamoL3QvH4ZuivpjR4LGQjwPL/ZrNodEItnDydn6yZVu8g0hu6i6Zo9dVtyioYJoEDF9kfm6VWFqUuja43XEtwVNQ/aQwu8PS2773VfxdUy6zOznMInwF2h9EsFCqTIj23m/zrDdi6JpQkC1/XKFain/4/geOfsjsPQ3B7N8ZzXlL56zXck8MUrcDP24Fmr3uFSFtbfPMLU92mMVoj/mrRWUGAMETMgpIvmub/EGx8zF48Ns69CGd5S8w/9bLHtqj8wNNzuZMi66T0rp/nLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x6o3K/NIgI5z3dJ7RR2lixYxYsNxxt6Awh+FXg1OJk=;
 b=GUMe2K2Va3fyzYJJKtmtqu7M5FkmKH49CpYeAaoWpVMFgue+H4cklPnLuONgEZCnm7RGm7DJBujXt7XkiUS838w+BUjETfhjdRih366e49Pam1pwQmMNDTcSyho1/smZs6v3pv/04CZdX2EnyL0cdLjBEG+PuL0wbCE4eOuJkytxrACHrDnOG6P8nwvgPk39HjJfJJmVZ7fF+enxtBxB6LchPK7M6hQmjoIWsfYZjnNx6zjsMALQFtJ8SM86RfcmAdxYgbZ7o2HZnah9gO9w8zF2UqQCUKMxpMOtVw4JKwrX4YUbar0PmsAxlXU4ISb4+N88h/K8vG97xMoDrRBIZw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 13:52:15 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 13:52:15 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 9/9] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Thread-Topic: [PATCH v4 9/9] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Thread-Index: AQHc7iaM1xQt0CoB/kKb8Zh+sEeHC7YpvzXw
Date: Mon, 1 Jun 2026 13:52:15 +0000
Message-ID: <CH3PR12MB75482AC2A81258EF5EE9D3B6AB152@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
 <20260527221631.612026-10-nathanc@nvidia.com>
In-Reply-To: <20260527221631.612026-10-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA1PR12MB6797:EE_
x-ms-office365-filtering-correlation-id: ebad69e5-ca02-496b-96c7-08debfe4fd3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: WoqIuH2B0KoJVP8Y96H3SAm3YzkA3Kj3+1E9owkT6ghY2E/PJMQCd7h9JyfUOqpARpMdPH8n2cKy2mhs8aaskvVxe8myl23mgbHoYSaws3lRoyYB6RIDqyey2p20yIdfBbr2PKrMhl4pcI9qqaeJQ7xSbMtzBcVbRoJ3hnVojcSSo49qmjkVzd5vnfUECnBo/0EcT2gCa5bbuKP2OOFAn6JjPrMtHeW2ac4uAsExwX1T/z3XMWjc1/KtwYXHjLYn4ebRWZbTSIkfjF609UutlamNgHVA9i1i6Bj7VAjeaID2asHBlmQvICjMXOjQdRpQILU0lGUTxre3uUNg1kGra8/YzeVePKYjF4kLQQ/H6+Xd+zs55uVogQDxNN16X3m/tJtk+9O3T13XK9klTTWCBOVEbhy+baUkBeYWaKtr/lIkVG1MOaL06PPkYqsfaubc8J1SDfzDHdhKrU0qcC2l+j3/fMHLUeLQl5oxIZjHLgxb8a7T8z2uXxliaxWu4fiIDKof/SWW8eUl0uMtNKyFXRa5VrOs9AP14DKlP7VftHU2Y00QYGkpmHxXW3TMtKWZ7pjsWSQVHoVigvL1I1/DOLs/uLx4j3nh0tbST5p4u9nNn0hCe6ecYLJqy9kJ8pzeUo2MtyM3C19nlgIlhcYQlNlk9sS6Jg8k6Ozee5JXToQbX8tD4qNhwDHFIpEXZ5pc7eJalIZ52bNqDzcH+CojILPWJxILWh8uCOwmvOH+0BW0Q93fb8rT9iYQczNkC+Ks
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U9/+0MNbD614m4ljkMaBPS64y0i5tZNqPHaIpXJZKBqNgaCb9aXtDASLsh?=
 =?iso-8859-1?Q?c7So5hzkzhzqNbcWt/OCGwRI4kvwlUkaIfnYo2W5H8GY3Dh47gv+yb0Nwp?=
 =?iso-8859-1?Q?TRZnWzC5Ya+YGZWTc/Q3Ggs4AbzqCwOz6WnS/bQ1Mmsh3DrPMMjFAPx7et?=
 =?iso-8859-1?Q?tBSYSTWsutGovNPcUJTwiXFphemzpHX5cURj1/XboKJqor9beVzjbdwNBJ?=
 =?iso-8859-1?Q?wwNuTdkJ9JgeftBxA8ShBRHMg/InsD+zZi89u1NV8LTh9wmnysIxjYluPn?=
 =?iso-8859-1?Q?i2+jJ8Upty2ONsnpXQ0z9qaxlpqS4uH15x0x3y4EbSa4t0AWqR/Fpxgvwb?=
 =?iso-8859-1?Q?8hJIy558vptL4OC9YutjnWXj1sESdBk7trGosmNqdDEJykMBFzPztmxVsD?=
 =?iso-8859-1?Q?I3QLx1aFijMcw3uzFBbLBPQ/uYrLuDtSSbtjqepoKyyP18R+HSXNHHXzzV?=
 =?iso-8859-1?Q?og52qPXgKK9iLBCaAp9h2ZBRGAfdwnk36L01jPzjsyRYGSNca0FbLT1DFZ?=
 =?iso-8859-1?Q?M2A2KN0gT7h3+UdepjUYlME3T7BEBnJxo9irwhcu8eRpRoDwAg4QD5GH/t?=
 =?iso-8859-1?Q?TEhkTkFunm39DNub/Cap5lJZsFzgP4WSiup9xmifM5EVndXyoQ1YUUO8fS?=
 =?iso-8859-1?Q?WicIkAbYMXKY554ZMgGJ4hTsa0iFHoatvXn5cZTsXtZe6MOt3Rspwc+Hj8?=
 =?iso-8859-1?Q?lIt3g/LJJuCEbsM0XpW5n0YK7rmT1qWPf6OZfH0S6yJeDUbyic1vTBpUgn?=
 =?iso-8859-1?Q?pRzdo2PHP2e8SHG4Kt5Kfyo+ASmj8pt9G8OJ7jdG3+DK8OGNvHmAvwUpK2?=
 =?iso-8859-1?Q?P7GD9JPJ7tk0wJw4j7wlW6qJootxJXmxSRakb7j9NS1C4GYi9a6qdBYf+c?=
 =?iso-8859-1?Q?xi0FmgB6d80sDB2k5bnCvUblFLT3W/zWEWL+BDq08e+5/RDTkN3f5SN9km?=
 =?iso-8859-1?Q?qpGoIgp9QYbhRfhprKYYomfIwiR9pc/yBsZR+RJi98EHhPJ22wr9EomT3n?=
 =?iso-8859-1?Q?phG+BrgTwDAj98yishRYD0e3weaWWYiEtUQUVpIbAuN/gtLO0LJ6xJ0F/X?=
 =?iso-8859-1?Q?bMdqYB2j0zGByFxtfs6HNP/Fz8YRXuWssPsmBOqz2jFpnt2ihcUW+1YFx2?=
 =?iso-8859-1?Q?s2MC+u0B/qI5Q8d8GtxKZXDGHePSPaXKdpOqQ39/FfxX9LdCPQYXTvWP/B?=
 =?iso-8859-1?Q?CwraOHar0zdRvSVIFfne4HpwY4qpPVF+4DEwleIPUN/rOLGhCyp0ne8bFt?=
 =?iso-8859-1?Q?IApedReo51c4xaZjav8u5XVQqmYIRifivfBAKfbPRaAbvDR3k5walVsods?=
 =?iso-8859-1?Q?Z4xaGZyVS9R8b8ultQPYARNFZGS7a/7G603/7Gdft7kTbyVLVGxTdDxzsO?=
 =?iso-8859-1?Q?Vk1szJpcmlTDdLXrp/XvshT3ROvb+psVj48vGc9LY7K6ThUKfz0me7Sxtn?=
 =?iso-8859-1?Q?PW+hnF4WyfTkJjcTHiQ/eJDwA06z0pNS25QMRUxD6887JRcateWzERa5qr?=
 =?iso-8859-1?Q?moHR9fapuXUtrNr3AecQtRWlr5/Dst+kPS28jUOMIai2zVMZvouiGhdA5/?=
 =?iso-8859-1?Q?MI9fumsLIg5Q1ewwJY4N0lNNUHoSwtqh4R0cxNRGyQbKEKvZCQc4OeyBTR?=
 =?iso-8859-1?Q?pPIO1gynUiCBK9Tn3OHNWdJl24Ead2enU1u/r7BicQjTcfh1HEKZp996hf?=
 =?iso-8859-1?Q?2jWeNubI/fscy7M24euiW+8rJISakasd6G1qe4MUZbh1f+713B55xUbF3C?=
 =?iso-8859-1?Q?qVfa2GlQv0Lb4WB4o+2xOqiqwg4gnhOhJYJRsKTDxchw9Sucj9qDJJ5vkP?=
 =?iso-8859-1?Q?j5a+yAy97A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebad69e5-ca02-496b-96c7-08debfe4fd3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 13:52:15.5005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMe2hhoRaaEm9Qwv/FE0EWNtHV3tsE9KfVGDD0Hs7Jc69mXT0lFGW/8TOiOXDDopUinerXzpThN1rRbEa/mYZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> Sent: 27 May 2026 23:17
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
> Zhao Liu <zhao1.liu@intel.com>; Matt Ochs <mochs@nvidia.com>; Nicolin
> Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH v4 9/9] qemu-options.hx: Support "auto" for accel SMMUv3
> properties
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Update documentation now that "auto" is supported for accelerated
> SMMUv3
> properties.
>=20
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

