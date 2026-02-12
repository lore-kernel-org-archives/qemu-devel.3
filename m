Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000AAEE3695
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZZ0-0002FP-Dd; Thu, 12 Feb 2026 11:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqZYj-0001rC-NI; Thu, 12 Feb 2026 11:28:56 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqZYi-0007og-2N; Thu, 12 Feb 2026 11:28:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIje0LMztF1CRlVhG8jDTe9LhAVJ6yvC4h6HcNGnhTsFSErsL+2Nsw2gZBZUWVYvlmHpsBLtc+52ean6ucup8e01uprX7XsNimsdNmmkXoxMZLs9N4oTyfnhD15i2Y/D6FFkPJgHQ3Ono/AIEQC18Z/RTL1Lgcb/sRV2F63/qO5cFIhMBgVQouqCnn3mcdz2ewIYO1dYRhD1F2R/xnJGzvIXzP0DVn/PMvhjjSMrZ9UoD6ySE3C+XCI8tKVD/mTPunjMyWTqOOlhSyIGehEJyyaIiA8jpweFttptSmqYoo6tyWGeJcWD9p/9eAVmDx7TKpGfXImF+d8f4Jfw1mnhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2T8twujZmcilYQTCHpimowCOTICNltKSi4yCmZretk=;
 b=EF0l8R1+ZUnaqcEhPDN20lFH7hlS32P/FkP0glXWMJ3If/a8SXPqFnsFlfFqpEZ1N0Pl6SVbdkPiuhRUr6YRtTTr5pjnWK7/ie/O1qqvVrsydmomezDN7cbyz2l5MKCtWTmeFLJXnCtBb5drhdPNWyx+TUY85EP4bdUT+btmvN3v5Y5ZE7tWYUpda6bF9uY0Phm+YpEw9PWJ6oD69D4ZyrVJz38dzyND0V3OjDtsTTsXGcnWZQYYRPRo/P0hRDp/2I+V8X8npRJtytTq4QjUtsG8w+w60cqAxpPBtluYACbr9bhdjr/Jj99m/5hfL1I1Wv8ZTeVhKnkXmsbOfpdurw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2T8twujZmcilYQTCHpimowCOTICNltKSi4yCmZretk=;
 b=VOl7+qXvkm0qwbovnvIsrtLwtZxF4X5pdQaaUf8IT5j0tYlrr/S2q4T6GmQJJl9I2ytZYBf5sgcuRX/8GNcvKsZmq6DrKTVGF5kOQu+BhoxyWZ8qFjED97gcjfmFMvb5JD5Gpym1wjO723AXBIP6q3/jJMZQJuKWOlXSCn8cG7FOKXwbTtIr0d7H0FckYs4FmF/F5Y+0ipKzCd7X/NGAP7P8BtnC5k4qj9oP4YQacnXcjRbK2keUUoq8CsJLmVERi8EFyhjmvHbAQH22vOZeVcNGL62OwGm0CVvUiHeekMYDKcd4PRwlb1RIdnN/BAwevaHK7mNGQOOEvyBBwlyG6Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 16:28:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 16:28:44 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Topic: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Index: AQHcmzFk1Etk+2u8DkWzxKPQ5vkZXLV9zEoAgAAB5gCAAALtAIAAA6kQgAAIBQCAAMFggIAAA8GAgACf5JA=
Date: Thu, 12 Feb 2026 16:28:44 +0000
Message-ID: <CH3PR12MB75482F20A549CD3D480226E4AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-4-skolothumtho@nvidia.com>
 <aYzFeMh1szhJlJJk@Asurada-Nvidia>
 <e66e82d6-0953-49f0-9d84-bf2776e8f3ce@redhat.com>
 <aYzJhEFg/zxtrJ8z@Asurada-Nvidia>
 <CH3PR12MB754855AE35A087B900B0C311AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aYzTUDmTzIZZCwnW@Asurada-Nvidia>
 <39acf072-3227-442b-acfe-658829071917@redhat.com>
 <aY14rcVQuLs3ugll@Asurada-Nvidia>
In-Reply-To: <aY14rcVQuLs3ugll@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB8874:EE_
x-ms-office365-filtering-correlation-id: c89c3afc-6d72-4e1b-5301-08de6a53ca59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Rviqi/nCWA2h6ovcz7hvrl+gjDwy/+Ls9oYBYcCN4CBJS8GVtP9TPaJkszle?=
 =?us-ascii?Q?pFC1MjzRXXmcGjIUtS+j7hL2v8V9n2hxjtRWr8c3lcJ1ALYYeR8plJ2GNbvv?=
 =?us-ascii?Q?UrnQ3FGJPdBDPrehnJRq7SYrdckCn8PK9OQHOhn6oMDQB8j5v05GlAhEwx6O?=
 =?us-ascii?Q?M1FALKZCQ+GUfweRdFpBmWsg8pk5fhWf1Z9B/MiQ8pMtsFnNgioQ/8Yzypu7?=
 =?us-ascii?Q?CvVmdkiiBuLC0wGbk++i0XqxPAz8tn1cLfzHYWYvYBOsptm6dveNpf3CAn99?=
 =?us-ascii?Q?RkXZx68YCPj3SYEOfoya4VesMsRZSboim3Nqxf7LuevSECnEbDmEztpd7xWc?=
 =?us-ascii?Q?lFo35pIUPYM8GOT8M0kqBA4fNYuiYMNsX3fcwAU1buRtbzhIH3UNPZl2dQ1b?=
 =?us-ascii?Q?tQ2e7ie9GhyUIft3BVPl2Pub5ZDPm4gwD/4RInFUZ16WVU6v9W53dOgrWD/E?=
 =?us-ascii?Q?zDcl/wr7EieapoXSlv08FZWIn22hroGha3HIzVPnCjTwAQ8/VqVy7t4xWdkr?=
 =?us-ascii?Q?LWDgXCi2dLs2/QSjrLHUg3hrg5qJVzvLuZOFxLl3BKxwSTK53vKDbUs35r6s?=
 =?us-ascii?Q?wYNgNKnsXROE/iWDuygInGc0GOyWrgyVShFNLa+EyzsBN0dPeBQwhqJ0TGng?=
 =?us-ascii?Q?2y+8dBX2KM90Ek4CEb5tGzNuZE4oBlXgeqPBsW9/pLT2F+2g5AOAXBzcmlWq?=
 =?us-ascii?Q?G+oWAG75pLjqbANupfqYgxKB3wUnUaqGeaio9fejq3RFO+A2cWUakhNK/elV?=
 =?us-ascii?Q?8FPXzAby88QjTMbaVYF2SOiL1AvkuNXQTDwurVV48sERqOAybywA2G2J5Udr?=
 =?us-ascii?Q?6n62qw+URrEwdEk58llLqPez2a+bOEhAA3GjhV9BvxUpFF8LDZKz5DFspcw6?=
 =?us-ascii?Q?SUQ1/WeZX13eK1yfRQTi5HZXIUqhcQyFx+thoCiwFRiB1N/eqUIESg1gwnN9?=
 =?us-ascii?Q?xe9/GsaNFuzniZTAR7+tl2y7cNYnUYOzMgTrD8QYsrIYLpLlgxDAYJF2aPvO?=
 =?us-ascii?Q?Dd744h3hxkVVKhtVUwJu49i25YqKAafPVVPBUU7eY3QbA+GHiqUehJGZesk6?=
 =?us-ascii?Q?1vd5Q/VVKEiViL245pptdhLFlRBDfCVa3eGyM70db7aELFtjp+AYXibTA2uP?=
 =?us-ascii?Q?tpsHo8x9mYclDRZtRVv+EONlFnYWv+vPCWseTzqVI03XOprD/7ekaLMW6811?=
 =?us-ascii?Q?AIfdwgz44GWakjsGEBkzWa88fY+eHi1/0YEFMDAunVmAUwCG6o2A6TMj/QLv?=
 =?us-ascii?Q?7xk8VMZZuUObTVO0ipRGqfLFhyiDiEBioKbER/PkaWJP6JKDLoPTXrpLnOFi?=
 =?us-ascii?Q?zfnF2dhOQL1uUEOHW1xBKjQz/3WPUVL0Y74v1AWh4r4kBGD7J+EejSGeJSfg?=
 =?us-ascii?Q?70lj5Noy26ccf51/kzHc2oRVQ+4sd/MtyhxNQAhJ4yGxojO8jM1i5NQlb/OP?=
 =?us-ascii?Q?f4qXiZjE2z/IlNVeTopbXD0a0nEcxWDi7+8hVpSJ1+1tAqhSXFAIStNL0fZr?=
 =?us-ascii?Q?jHTgcvURTxJNiKWxAJGYb6YF/WR1lBcvYbYLZzpSwxKNdT/E+wOQ6MKCwQrt?=
 =?us-ascii?Q?agQUdSaIwbkkgSo6ehsm4/YvT4UKE6UMIIxNHi/KrYewC/qd6g0Nv13Ja1aJ?=
 =?us-ascii?Q?GbEZLiweqxAk9Jn99lWVtcI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YBXkBOJZOsPSpZjN4b5o6e/P/QB5swTdy/mU/SNpvDx3xtD7gIKTum3px9aC?=
 =?us-ascii?Q?B+qp6qkImjeKHAovTXojlDcCqEqUS66UmovONk4llDWsWLliM5RmmEl/YfXc?=
 =?us-ascii?Q?LG4ealBf3l9quyqNgTqVa6ULI11mosbZrZ5K3WFK/Pm9ukavzQmREMg9XMGY?=
 =?us-ascii?Q?ZQvK6SVOK3Df/j0cmfxh1g0N9juP2kNYsefoJFx6j/gjpfB+vuatwO2Rud24?=
 =?us-ascii?Q?4ZQT/Ef8MJCH4+TMqohw5qJjOx8+efI1bcrc3HfejllfF5033+H4CpM1Yzq1?=
 =?us-ascii?Q?buUsIa1Wi9OlY2MiOUSQx4i540ufcMyb96IokiF1t7a/F6jivIjVvZy4kUue?=
 =?us-ascii?Q?VQcYpMZ56C7HxruRmLHEMZTDz3J447QB9O8+SWEljVelP7ctcSA7LnutxfDH?=
 =?us-ascii?Q?2TYAAmZ0w13GC7Y8JQiurN7VB5FCq4/VT6+cGFof2p5jZNLjONckjj5E8cRg?=
 =?us-ascii?Q?Hp7yKuvLp5p9YheMQU8RZ2bV8Y9OFcQUSPLl46Cm1ZuSFHFRwpxuht5ovvPn?=
 =?us-ascii?Q?n4KO8MVyUlUdhNi3J49lAWx82VijtTshqfKEU0OxgWSNErOVxVuHweXM5t+S?=
 =?us-ascii?Q?RgCg0ZiwixOklHxMxqxxS0TSIaUqdGP08feGKoMWDX0+DT1zE+VQjeMZTQXD?=
 =?us-ascii?Q?dJa8JqqXIspGxgSniuZkWXM3/g4c1SfN1Mgfbj58xIsBn7anmngkMKX7bs2E?=
 =?us-ascii?Q?uyVRrqFnS6kKnFEv3IiTreMzw37s87eDfBNhWJeVT6Pm417eWukz7/kB1Pg9?=
 =?us-ascii?Q?/GnXjN1mdJatp9LcILNww4gCrHR9FQ8zu8zKV7XhIMxabHqd7vgou3OrKrp0?=
 =?us-ascii?Q?rrq92qM7xnyy3hAR8q28rHMTQuexioRbhZXtwsmQROYVNNtg7IWBlVp9IbsC?=
 =?us-ascii?Q?0DuOIO67zwjjm88kt7WShZIuKLHqqUey5IQwiLvon1MJaIy9b3LZi5zkq2z0?=
 =?us-ascii?Q?SxW5kuuuRKP+Wr+cI7Vne16EXBEcoHUS1F7KsxuXI0tyqXRZjMpjAmDTp5YP?=
 =?us-ascii?Q?J1wgMQ4eLiN7Et6O9UAKQDzlLQhaW9iaeoL4UxLH/ibgwcwov2vZY0Y892ZU?=
 =?us-ascii?Q?ifFvbYSj54ifDDBRZpjRBe7GeiKPExSjdZN8MK51SYk6gALK5bXcaF59uZkD?=
 =?us-ascii?Q?PeVeIiwZMrp2HUJv5O+OMWLDwOoqOH78zOaFda3qTJ2woONN7YwBLJD9xwFi?=
 =?us-ascii?Q?2+mdBhl/+yvos+eEwoWb/1G0o+d6ckFLXN69QIFTSD/ACi6U3HKDt/XI2Dsh?=
 =?us-ascii?Q?wcRLPn+6xGi7dnA87NcBVpnBdzy/NpSnKNIRllRNk7b/qPQe0kDvMu7eAWwo?=
 =?us-ascii?Q?cZckXdIgy4PTcNlMF6aWewq9i/91mwvfvLoct3dLmyUHH8h8xftnH5qUBUh9?=
 =?us-ascii?Q?h8zhRQ6g2/a7eQZ4zmCrFJ6ew87For/MuG6Cd240PGuFYJ7K1Y0rhzyZ2p7q?=
 =?us-ascii?Q?BP+4moFZutgE0rPVyPAfaEuPo9ByjSkp+Ljj55yYHxwKYJkXPtNCJnOHV6Gr?=
 =?us-ascii?Q?hPgokS9wtrSZ8qqmCDL74w4cCM1q/GQBglcJQFzFWbsigHI7zaJEMBmv3Yq5?=
 =?us-ascii?Q?5ZIFuVKace7159ST0Ge3SnHalKmpKGrGgG0c9THmtjoIIabNb/taQEjcT5Wv?=
 =?us-ascii?Q?15omj7iz35xZby0/TVEJXX+mnNlToVkKoSfbxDFi4X8cJtHQBYGGFIepXlcr?=
 =?us-ascii?Q?mAzhO8ZLe31Srv7viRtSb5s2qiEley9HJHjsU9BRfOD+/zl3IOiS8cjugyMR?=
 =?us-ascii?Q?2fyJWWZ+GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89c3afc-6d72-4e1b-5301-08de6a53ca59
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 16:28:44.2432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hMn56a7nvZGBfHV2lhq4baMW8Hh2WDW6rTRKsN3jq8IPnkq2gytSBvTCz9IqTsJacx6UBfI9TUmmZrKx9LhFXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 12 February 2026 06:52
> To: Eric Auger <eric.auger@redhat.com>
> Cc: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org; peter.maydell@linaro.org;
> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> Jiandi An <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
> accelerated SMMUv3 devices
>=20
...
> > Usually error_append_hint() is used to append a user friendly msg that
> > helps the user to fix the problem.
> > In qapi/error.h there is an example that relates to "Receive and
> > accumulate multiple errors (first one wins):" by using
> > error_propagate()
>=20
> I didn't look very closely but just run a grep for "append" :)
>=20
> Yea, I think error_propagate() should work better.

I am not sure error_propagate makes things better though.

If I am not wrong, this is how the change will look like,

static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
                                uint64_t data, MemTxAttrs attrs)
 {
+    Error *err =3D NULL;
     Error *local_err =3D NULL;

     switch (offset) {
@@ -1614,9 +1616,15 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwadd=
r offset,
         s->cr0ack =3D data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
         smmuv3_cmdq_consume(s, &local_err);
+        if (local_err) {
+            error_propagate(&err, local_err);
+            local_err =3D NULL;
+        }
         /* Allocate vEVENTQ if EventQ is enabled and a vIOMMU is available=
 */
-        if (local_err =3D=3D NULL) {
-            smmuv3_accel_alloc_veventq(s, &local_err);
+        smmuv3_accel_alloc_veventq(s, &local_err);
+        if (local_err) {
+            error_propagate(&err, local_err);
+            local_err =3D NULL;
         }
         break;
     case A_CR1:
@@ -1724,8 +1732,8 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr=
 offset,
         break;
     }

-    if (local_err) {
-        error_report_err(local_err);
+    if (err) {
+        error_report_err(err);
     }
     return MEMTX_OK;
 }

And error_propagate() only will keep the first error.

Instead, if we do below:

@@ -1614,10 +1615,12 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwad=
dr offset,
         s->cr0ack =3D data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
         smmuv3_cmdq_consume(s, &local_err);
-        /* Allocate vEVENTQ if EventQ is enabled and a vIOMMU is available=
 */
-        if (local_err =3D=3D NULL) {
-            smmuv3_accel_alloc_veventq(s, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            local_err =3D NULL;
         }
+        /* Allocate vEVENTQ if EventQ is enabled and a vIOMMU is available=
 */
+        smmuv3_accel_alloc_veventq(s, &local_err);
         break;

This will report errors from both paths.

Please let me know if there is a better way.

Thanks,
Shameer

