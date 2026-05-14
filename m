Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5A2CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 16:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNZ4O-0003Ri-Ay; Thu, 14 May 2026 12:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNZ4C-0003R4-0P; Thu, 14 May 2026 12:37:49 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNZ49-0006wI-9V; Thu, 14 May 2026 12:37:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BovAp2w/oRTKvUAo/ykqBBLlN2Vu9LvGFsenO1X0DoY2eqtRVja005GpjjpmPIwJLKbdDRhy00WNkhii/63/v6uhX2z/U0okIYB7oRHv8aVd3VryDl4JHn8mmYV83iryCvxnvjjUIP9YenR2CrfjZbpTYXffKopRZnPKopIveyX/49VcO+5AkrRSYW6FrSMl5nQ8/5YjBGDOVkV+SbtMCoOT8hQN3/zJdAs5+b7fdjLIdaOEo5GvhmUc4bSuJuKvfTdyCJj45TkLMUSkYTRQ0628Gnn3HfTFdlJCkCNzEJTWEFjOd0zSVXbV1t0WeKSyCK6Bby6HYy8sQe/wi9hnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCw/OWpnmhULyjzTPixvz6VraWWmx0h8dX+fmlv3cPw=;
 b=y9BrHPAJSUL4hwDfirITf/zBQY0ul2eqY1tdVNux10a7/PXVprVr+vb0PVR5PGBxMAf3E3I0JabsZbaep6s4wzF0dfQ5QSumzr6T5z2uC+Qx4jukFZvqHFy2aKN0LhYvNiqWUx4lZtN6CivVSnxPSPXGg4zbgy/6q1vLm+0+VYCmwKCByGSiQglRAp/Un8IVQXs9JbAjIhT93LkNmlyoTKCp+QzF2RXEvn7+een8PKZMokSNHaB4FPmbV2+EsyL+3RSwP86ZmSS6vHmv301TpadDZ8IKaUMQw4xF+AjSXWhXriFjZo0rkRDQdPcVp6f31+T3KioyT6y26iI+4fvDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCw/OWpnmhULyjzTPixvz6VraWWmx0h8dX+fmlv3cPw=;
 b=rST4icEVFMscMi+JB2uaT8kuP5t1FUQJer1NW814THqXi1GGM6J7rI3NNMgHXbe80GUaUVCXbniS3G/3clhTV4pIgs7jPYLyBDD4A199r8B4QqoLTLprJxlAiyD2oPWos58psB22cXFQSKCOJH0W+hubuuf056SUcv1vq7LoZpFM588Dk8HOdhmfBpbJ5dIIuxsNK0n2FF/DrBpqrDvT86I3KK5/0GdNdvSRDhe63AHKZvEc1Sx5RnA3WYvyGs4wL3HTbCUs2Iu2ziqT82NGdFG8CFpDTZouGOa3nvxFQVcGw0lIPwxXjjAJP4W85bOaI90wfWaD/xbsuC1siny2GQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 16:37:35 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 16:37:35 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 0/7] hw/arm/smmuv3-accel: Resolve AUTO properties
Thread-Topic: [PATCH v3 0/7] hw/arm/smmuv3-accel: Resolve AUTO properties
Thread-Index: AQHc4kaHanyj9u5+E0WrM+HwzMuhgLYNubqA
Date: Thu, 14 May 2026 16:37:34 +0000
Message-ID: <CH3PR12MB7548F7B7FE3A5FEAB2F4A836AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
In-Reply-To: <20260512193520.3109172-1-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB8110:EE_
x-ms-office365-filtering-correlation-id: 0a5c91b9-729d-461a-53b2-08deb1d71a46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021|11063799003;
x-microsoft-antispam-message-info: zbzahVT9mDFPx08bugGuCTmhPhsPAII8ldelhZ8H5aCjRmwKKFRuI4SxGTftj8v6jJt9jPHfTkDSKLogMSw9aXruKdcMnS5/JCpnfW2PNGDWmp34YeHY/aJN+ilxkvcUqiGhA5FMQNGAwDthnhquBUEIhcZ12LSVmqu0YL4KpYC7R+6Q76RuK5a0pkcAA0RSHAxPQaRQlBiIqTFnF8oqAi+flEx+NieJxVDZ+LOqd/bSMftJycacGFzxL2scG4Clq43sZrlIChyIoX4Z0PXXci81W16rJDWFliRJvdXd36RD3LWKWbXNCQhzC513JbR8qRWFj4c6FUVyCEdfEOHPoqk/s6XAKsRzURBZs9nvGEjfRfLerxSlvv0V5nNZdfEmMIXvrhZs0ikeKbJpqCf3ZQJEJXJTp55L3P8EbgFVHUyN0vQmee22ZRK0czWvdazmOK5dG89yVcREeguYd0/4w4i6WXmOBdIQKGHqMhzmASJfqWe1+IdpL+CbrsllghFLp1QW1hOZCNr3xSYwNsNUxgZCO6evzMtVyuhkRCq/NhKuvfdcrpA35iyi88DHz7cR/VgCNbMBzaWXTiFZmevPdBE3sYnjGGCIMO1WWqme9CSqpkJ8lfDpQ2bm6D9knagrQ7Rq7j0N+EUNEF6ZOUjWZI78aclawuF90D/nEpGIV/Sg45zM9sHRSMlj0+Nm1rdGWZTRRl1PITz2yLjU9ck9QpYvAU8j6IURGVGQu1sOzjJFlqaz83/JhaXRMGbgkT75
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LNySR+z5EVeDyCvYaQZ4AH4lnqDRiemN5aQ6qvigbbi85MPDWu2J37n+Ts?=
 =?iso-8859-1?Q?wE8Qy0M5lmqvK/9v/AfjZZ1faig9KmBdnnmmmFtc7dWapdMIA83R5yfDRj?=
 =?iso-8859-1?Q?NGw2XdPiqWtI69RAkokVPKeQBEDh2C/hbFH5x5gX22JxA8gUXIxAXjNMjV?=
 =?iso-8859-1?Q?2Rhmqenok46fGvvgUy+qORCzQxJlZTT/Y9O2lc3ZyqY3Cj5H9CkfvYEHCd?=
 =?iso-8859-1?Q?OjZwuSO9WvmW9l7fKGVcu807ur0XyB7MTL6td3b0742ibYrLc4BOBqx0P5?=
 =?iso-8859-1?Q?p1wNyZgmJ6T7D+XlWSZ9YxYFZn8/ZadbTjAy8BfrQTuaBClXm4Ms24O3TW?=
 =?iso-8859-1?Q?Y4qwUCKnWSw+eAaUPYw+F/TsdIvOLsqIeYruQKffRibsfngiPu/djbX9X5?=
 =?iso-8859-1?Q?2x9JjwcGglYORJEGKM6Q8rL1qtZrtmPiRlafBvXWxF5tGpJXoch5MBTcwU?=
 =?iso-8859-1?Q?fAYb2PrAKFfsQ6ygCSfbIB8E/dU2FxzUrOgegkXZcADY75kSZ5os8ykT4+?=
 =?iso-8859-1?Q?f7JOrrLwtffeYJL31dOX3Z3pE5JE7hbMk1J0z1TcHBif+5j/9Q/z0gxHh/?=
 =?iso-8859-1?Q?enE0xaTrrG+RntC+bJmHOIM86wx/pwPkJ3aePetlh78Uy9OVkUtlK2Po5s?=
 =?iso-8859-1?Q?X4i2ESP54IqtMhMLA1soLtXQeRgrBKhWLV8iBhQPoKpdhgjiWXDH/RJLX/?=
 =?iso-8859-1?Q?fHycXiHzwoNQJ4SKrKZj8TGr7znM773RvoeG/hdtqJXxgWQgbjQq4i5t5/?=
 =?iso-8859-1?Q?vEoIUfYnEpA1Umllg244tj28Lvwq3nXmnAFgSntVQRMTI/agN6fcmFkuGR?=
 =?iso-8859-1?Q?lHVTNGEbgVjyLSipGkYMuYCbbOYrFr5m+EiLbSaBDxNmd8pFFo8yBJBKU0?=
 =?iso-8859-1?Q?bpaOwfLdLPdTEep2g2O1zjJ4XRX1yKbXL8VQy6Ywo3CljYl+hTM2Zm/qRl?=
 =?iso-8859-1?Q?ewuAB3e6+V+cJtnzkfM2ndL8vbuyu6FYdd8/QLkd7Iv1Z/aT8AWbkWXMty?=
 =?iso-8859-1?Q?QlCrduJFLSubfw7kyRiVLMcNSop/k9bwFqZ/eUGhV5wdpo6iSN0uAXukMh?=
 =?iso-8859-1?Q?V8FNsPoWoJ6INrNJYhKY6m0/wGli7qwV01RJAVY4TIGvc2wl2I6nsbFd82?=
 =?iso-8859-1?Q?Q5QXa3Ys5gY+BVqYWoYMG84YfVAWbUpeePyiW1q/fkdKTU5D+spC7aJ11u?=
 =?iso-8859-1?Q?G48oMYsCIh0Et0DWIavt37zWJD13O4x7GQy7q3l41V13kfbi9kTEfEehf8?=
 =?iso-8859-1?Q?DGq3i5cizcvxn/U/kQCWhcVtDF8B6/Fjp/oDDfEGb6Nz8fWuGDgeP9f/75?=
 =?iso-8859-1?Q?RKbkYIQrYlDX/4HuijZNyJsjUwDF32dJbq6wNX6/duyUM+Hh6mygZRWa9m?=
 =?iso-8859-1?Q?aEWkmK6SdrCyinDU+f5IHPaAFl/T+vYbaQgxPTEcA9xfR2JTJLMMRmu6YD?=
 =?iso-8859-1?Q?2Xr8VoZ3yKoRyS1TpnGIPkIKhN5EAUG8QhRyqHDpIGfnLmQ8KyP3Wm9Ccq?=
 =?iso-8859-1?Q?xk+Ob4VWht2OL40DVUhOY0QEZQURuSLv9tyM2lpmPt5XeJs2a2e3wTEOsD?=
 =?iso-8859-1?Q?vZVc/qaqJeMUTuFiCW30Dey30KRKDG05Ez2fDgHDsQhi/DTJkq13/5ucLQ?=
 =?iso-8859-1?Q?6cMF10gNvITIJDx9sL9I3V+s4R4hsQ7AayJ/H1PcmScJklkkSYklbA8yGd?=
 =?iso-8859-1?Q?QQUZiUy9e/O/pVxswJZwmlJLFNB8cZ5rIc1a8IBNudXBTGxu1xbp9Ytuun?=
 =?iso-8859-1?Q?8JKQxASYHifIXn06w1Xp9P6b7ANSvXRb1HGbMzD1wbeOcpfL43lw1piTpC?=
 =?iso-8859-1?Q?Q1yRzkhJvA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5c91b9-729d-461a-53b2-08deb1d71a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 16:37:34.9581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cb71u1fjcoaf15QJua8el+X5NeeXU3ieoTBScowiBSrseX33YJd7lnLG/EwBJF8zd8qNGEOcnyaWh66Ghp4ypg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110
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

Hi Nathan,

> -----Original Message-----
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 12 May 2026 20:35
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
> Zhao Liu <zhao1.liu@intel.com>; Matt Ochs <mochs@nvidia.com>; Nicolin
> Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH v3 0/7] hw/arm/smmuv3-accel: Resolve AUTO properties
>=20

[..]

> Changes from v2:
> - Added R-by tags, thanks Eric, Shameer, C=E9dric for the feedback!
> - Re-worded descriptions in qemu-options.hx and smmu_validate_property()
> - Emphasize accel=3Doff auto behavior in a comment for smmuv3_properties[=
]

Just in case you missed it, there was a query regarding the corresponding V=
FIO
ATS support patch here:
https://lore.kernel.org/qemu-devel/ad0dac7a-cd60-4735-8ece-23fe526ca883@red=
hat.com/

Thanks,
Shameer

