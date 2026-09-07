Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3FCC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Vym-0007Ra-Ty; Mon, 07 Sep 2026 05:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x3Vyj-0007R5-R7; Mon, 07 Sep 2026 05:49:29 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x3Vyh-0005a3-Jd; Mon, 07 Sep 2026 05:49:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvRsvHo1uiMo6Qjg9fThydo6DVvb0hCdLs4RXXtaoFKgKfQmWbmfHcccNcOhhcqrYWcJrI14QWcnYABPY5Ko2PyLjStxoSf2SsmbeE118OV61bm0KU/mK6w1uTHAqWj0W4K6kOwyqs9Y7gl3z3bry9xiOhMIW+qCQKEwmMgP+RtlPISiEJdO8jzom2UDXIRGmtg0so9m5If0i+RNJwnC/2nvor0uc0t0cHsAk6F7xbh4+pYNQzls7/VAKIwFCp+Uy1ZDqhcMaTJhgUJ/Ac7M5oTYVXHyTvHoPQefj9ctjMtAHn/ql8xfNdqvc18+6P+eUbwGlUjh1+QA7syO+j3rTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+uSjlehMUkJNLjXAwPE/vT+2XqhfnWr8LUYJbxgKBA=;
 b=kd1P2kL4D4LvCjAMyCiGLYkrvucZdkcA3ZSGb5jU25ZGpKqFX7dNnFy4lzDM0/VB9vIdFR/CW3S7deGr/gDbo//7R3/LKHT3smj5kAXSWVQdRJUOpF00Kl6jdg65asB26A8eNW17N41HocGBZ6RyaJpFCMDbwHzTIXa+u5uRj/ogrKCRWWjJLNa3noAPI3GgjMJxpw/zgD0NKY66CktL5DZIfqeEgL4XNv9VF+GuOvMP7eOQ4Fg4mRpXLS2pA/AARbWZGP1/XHyk+I/1wqd065PboIYuUS2ZlZAxzEjw/kmG6tVkkKIYUj8XJWpOSUvycQf9qKbSAZpoJcxHYCS0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+uSjlehMUkJNLjXAwPE/vT+2XqhfnWr8LUYJbxgKBA=;
 b=oxrdDgU+VYbdmYG/Q5VdS3kdiKI+LFXC6COAmdvPGLaFmJjTAFw3I1ZZlxzArkmAm3FbWD7and0nUaRtIHA1TF56j1wN9VXjehbwrKvLABbJMunfuCYCuz9pGGsgXwVyZxoAuqaUPnRn4+IpGAktCjDAdfIrdRWzbWWRZw/nJ5c5tR+0sTwu/HfsJ+3Fh2qnb98cL3uBL06wn5GOZY4UnQl0wRmiWP7+dLde8kiqrN+zghd3e/j4LJ61FsTpeJwSghhZ+1fVFAi/ywjR7lTKj2QPXtYsN/LGKe4rDvbGmN50oAHsoQeU2sJ9L3ntjg/r+BPXccrnoYQ7Bi8qKLszCA==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:49:20 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 09:49:20 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Khushit Shah <khushit.shah@nutanix.com>, Shameer Kolothum
 <shameerkolothum@gmail.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "sebott@redhat.com" <sebott@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "armbru@redhat.com" <armbru@redhat.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, "yangjinqian1@huawei.com"
 <yangjinqian1@huawei.com>, Shaju Abraham <shaju.abraham@nutanix.com>, Sandesh
 Patel <sandesh.patel@nutanix.com>
Subject: RE: [RFC PATCH RESEND 0/4] hw/arm/virt: Add support for Target
 Implementation CPUs
Thread-Topic: [RFC PATCH RESEND 0/4] hw/arm/virt: Add support for Target
 Implementation CPUs
Thread-Index: AQHdPpOoiNyWNqUXZ069kRXcGmJmxLbC3F+Q
Date: Mon, 7 Sep 2026 09:49:20 +0000
Message-ID: <SJ0PR12MB86146924254A85F9E1076BE3ABB22@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20250801074730.28329-1-shameerkolothum@gmail.com>
 <B789DAF5-F8F9-444C-B0FF-4CA0081AFDED@nutanix.com>
In-Reply-To: <B789DAF5-F8F9-444C-B0FF-4CA0081AFDED@nutanix.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|IA1PR12MB8518:EE_
x-ms-office365-filtering-correlation-id: c97714b1-e992-49f0-f31a-08df0cc54a64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|10067099003|56012099006|11063799006|4143699003|6133799003|3023799007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Lnh9RWz2XRGfp+ct0oftiI7Ybj9AHa/G8rU3Mr4Z09gXds0A7YNJLehlqy2vrEJxI+U81YAk7MAwVbMbFtUAy+tJtT903faeqRLI4RwboOteby1+1YjO+fRooVq/fwsVAfkaKBhSr3Fzrz15w7qpwKILmIrr8XEL6YQH8WEFQx5tprh0+8cHpPoFhpSigNuvxaYm21N8xTS+jo5V2cp3lvmiIcQd19IcTGiu0lcCoHo4gGHjRS0j+b2hZ15kWPlUzWeKvJwaiyg3VoTnuAupFozWXKuEfCPbAViYiydTX3RXYDXXpkvN87j99wNwxr5YRnNyKpIG98jG+95eGvzKF9wBsCCK0wevcvIhrrwp2Qr6RI6mh0u8bFD6EBCcXNNEordZNBxEonFlIEhPOgmhngX81ePpUCl8aONp6NyQsuhKxjJ8DSHjdToHlrKFNZsrfMmCyz2HLKIjUPUL5BzE8++7NPmVaxBuD8SMrSievO9q7Oev9pLqC0XXuKNS9FNW2WL7ToNhmXtU+j8ZFUK7523WmCu7BX5BLn+JGbcWzwsvTEicAEEJgQ0axZxiTHFaXnd9+fZQbrLiuOcJk5vLueeNm9Ala3Gg2rIMvXZAsGAZo85biUaxIv1exyPzZZD/Q2cX6Qrfy2JJ1uBPqAc7Pqgbu6Cv94o1hmDlRzgVH9Hs6aLO4R8/c5Gqm+Xm1M+3Ar3b/PzqsRNlbPQcNbtIqa9XRbA7JvymVExN/MANgks=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b29xaGd1V1V1b0diMHlyTGtxd2NBS0VUai9pSTVuYjc5akJVQWY2a1VDL2ZR?=
 =?utf-8?B?QzAyNVdEcFpFVkRlNzlPUUxaT2RsOTh4N2FvWU5VMytpd2lVVWU5eFZOMm9x?=
 =?utf-8?B?RmNYM29WKzhjY0hEMDVrRldyT0QzRStJM1N0UHE5TlpLbTh2TEQzUjNtUEJo?=
 =?utf-8?B?MXRSNFFmTlE3WHJYdk0rb3dnOE9oUGp5OFJjcDUvSFpPTkF1WlI5V2p3Umc3?=
 =?utf-8?B?Z2VBeU9FekJWTzNkekhlajNvMFI1cFdyQ3Q4bU1xTUFyU2k3bzFVNGhPVDVX?=
 =?utf-8?B?K3lqV3ZBcGxMelh5MkVhWGJtQ1BkYkI2QXE2SWxOaXIraFpReU5hMjdyY3E4?=
 =?utf-8?B?cm5vajhZc0xlYU5KT2pkRThRMEpId2NwQ3ErdG55L1RhcTIrSXdzVSthamlE?=
 =?utf-8?B?QTZRbzVQeGgvRE5rOTZLT2p1ZjJZUm5iSjBUVEJMOFRuWUl0YzJhS25RME56?=
 =?utf-8?B?amVreHFiWHdDR2RhQjJEVllTeHJ5UWZraDJVRHQxdnhSVmQ3enJHWWJ1SU9v?=
 =?utf-8?B?bzg2R0FIaWd0bVVWYUZWbTRWVFNWUlhBc3dFaWlFOFE0T01yeDh3Y2ZnUGRD?=
 =?utf-8?B?aEwxMVV2U1d0NFlRcXNacFEyNkZQaERmVUZZKysrTTh3VVhPMFJ6bmNLc2Jx?=
 =?utf-8?B?ckRkRE5sSGtoWnZJa2hqTHFGcmQ1SUQzMExzWklNWHdpK1djdkhPWHBhdHpp?=
 =?utf-8?B?KzIvdHhOVGhLdUZ1cXZVYUV6M2x4cEtPQ2F2UWlncHprSUl2Q3NGMDZYVzBF?=
 =?utf-8?B?WnVFcEtvZ3U1bEdrMTdpNklodi91bmFjS2ZOVUY0QSt3dmdqYUpuUkZmdjNP?=
 =?utf-8?B?SG0yT2FHa0VjSTNGQjUvVk9rYVRaMklSdERGa3gycTJWRHhBNStyRWdRMWh6?=
 =?utf-8?B?blhGbmFFNVVTUTJHY0IxeFMzQzF4enV1UEEwamZQNUpCWHJnR01oY2JRb2RE?=
 =?utf-8?B?OENMNUFVQy9Nc1ZRV2JPSUxKRkN5a1FnRVVTY0NDTHN6dEdDMWdReDh6SUdt?=
 =?utf-8?B?L05EZnBRYmNENERYZXBDWnMxZWx5SnRGNHJJT1IwaVQ4U00rZ0Q3aEhJb3Nw?=
 =?utf-8?B?TExjMHVYSUtmTnpyNkgzMnBUNml2WisvUmNFRDNHVnN6bVNld1NpNDhtdHps?=
 =?utf-8?B?WGw1cFlpYVdMR0kybDIzcDdtb1dqaXE2NjR3Y3NMS1prNjBtbTBHSzZqVzNl?=
 =?utf-8?B?ckdQK3ROcmVQT0ZURTVDQzd4bElKRko0d21ySk9QblROV0dFd3R4UDFOWm82?=
 =?utf-8?B?b09FYXkxVEJOb2ZRRElmaUI1M3dTWEJHdGhWTG45TnJkL1hhamoyQkJTamxT?=
 =?utf-8?B?cUJrR2t0V2pUYTFncTRNRGlycnFPY3ZVZFJRNU9xaXorUTE3TmZ4NXpmVkZP?=
 =?utf-8?B?cWo3M3hDUHBFcmtQR3hpQzdwUTlreXU4MVFvOCtrOE1TcElJUGgrQmQ1MFA2?=
 =?utf-8?B?dnZkUFBzbmJvM2JYdTlKS2tCTDYxWkN4UHJRdFpsOEpMRTdMM24wbmprYnJR?=
 =?utf-8?B?OUxtbGViNjdnc3JTQ2hzemJTbWU5b2x5M0Q2ZllSMDJleXBUa05LQ1NNQTNE?=
 =?utf-8?B?ZXE1R2g1SzJMQk15SWUwdVE4eWxEbXlOY1l0VVBtSThEZkNEUUhZRkxWSXhk?=
 =?utf-8?B?dFRqODVaSDhXU2M3QmJKbjZaZFZKWWlHU1pSejhodWVQeUlUZDd4QmdKaEI4?=
 =?utf-8?B?VjVRK3RuRmZhSUVUYjlFYWVnOGZreTFLaXRXYXcyU01KS24wYUp2cXVsdXZh?=
 =?utf-8?B?NjJnRkNjcTQ4V0RZSUpsNGVLa2FiTVYvYTk4aTcwdEk0Ymp0Y3QvSTlxTHRo?=
 =?utf-8?B?S3podXVlcmxpR1ZjcTEvSUZJMFpqY2V3QnNOT0V0dDV0V21TTFhJaS91NmMv?=
 =?utf-8?B?WkpSZ0ZIYmNKMi9ZLy9kZExqMThpSXlJeWRRaHFHenhVUUlqSExKWWJUR2Zu?=
 =?utf-8?B?eThHQ1Vsd09YYU9SQWdzVEhxNVJLeXBVU1NUaWRHZTlSa2RrcmpIVi9Dd3o2?=
 =?utf-8?B?UDk2NTBjRlp3M1FmZGpzcmpjQWF5akNIV0V6VVVRVjVzYTdGUEdSbm5WUGhK?=
 =?utf-8?B?RkxkRVluNDZKRk5EdS84WUgvK1ZubnJpZjJPZjdpTU1TbHUwTERIdnJFaGcw?=
 =?utf-8?B?OC8zY0VsQkxvR0hrbDFQakJ1K0t0TVlBSWg1VjRVUU80dzF6dHN4eWZaTjVP?=
 =?utf-8?B?ZGRQdlp6cDBsUUFVd29WekZydHg3Yjl3eGlsc3VaTys2RkRkUnVZRzNKRTU0?=
 =?utf-8?B?cDJXdU1xemlKWGRFVVdISFlrUGp4UVpOYmhEOWJ2RlBIQ3dxOGhHZHJmY0or?=
 =?utf-8?B?M2hGQk1nQUhTclZmakt3T1pJVGNqVXA1R0tlVHF1UW9EZFVQUW1Ndz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97714b1-e992-49f0-f31a-08df0cc54a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 09:49:20.5811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3sQoWcmlPnSMhtqGVWBsFUHOOeiPY2cKQgJVs0kfuSFOmloag66vEcTci8ym7xHwOcey3j3Xn1AzoqEi9pq7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcWVtdS1kZXZlbC1ib3Vu
Y2VzK3Nrb2xvdGh1bXRobz1udmlkaWEuY29tQG5vbmdudS5vcmcgPHFlbXUtDQo+IGRldmVsLWJv
dW5jZXMrc2tvbG90aHVtdGhvPW52aWRpYS5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxmIE9mDQo+
IEtodXNoaXQgU2hhaA0KPiBTZW50OiAwNyBTZXB0ZW1iZXIgMjAyNiAwNzo0MA0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSA8c2hhbWVlcmtvbG90aHVtQGdtYWlsLmNvbT4NCj4gQ2M6IHFlbXUtYXJt
QG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gZXJpYy5hdWdlckByZWRoYXQu
Y29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGNvaHVja0ByZWRoYXQuY29tOw0KPiBzZWJv
dHRAcmVkaGF0LmNvbTsgYmVycmFuZ2VAcmVkaGF0LmNvbTsgbWF6QGtlcm5lbC5vcmc7DQo+IG9s
aXZlci51cHRvbkBsaW51eC5kZXY7IGFybWJydUByZWRoYXQuY29tOyBsaW51eGFybUBodWF3ZWku
Y29tOw0KPiB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsgamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsN
Cj4gam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOyBzYWxpbC5tZWh0YUBodWF3ZWkuY29tOw0K
PiB5YW5namlucWlhbjFAaHVhd2VpLmNvbTsgc2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3
ZWkuY29tOyBTaGFqdQ0KPiBBYnJhaGFtIDxzaGFqdS5hYnJhaGFtQG51dGFuaXguY29tPjsgU2Fu
ZGVzaCBQYXRlbA0KPiA8c2FuZGVzaC5wYXRlbEBudXRhbml4LmNvbT4NCj4gU3ViamVjdDogUmU6
IFtSRkMgUEFUQ0ggUkVTRU5EIDAvNF0gaHcvYXJtL3ZpcnQ6IEFkZCBzdXBwb3J0IGZvciBUYXJn
ZXQNCj4gSW1wbGVtZW50YXRpb24gQ1BVcw0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0
aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiA+IE9uIDEgQXVnIDIw
MjUsIGF0IDE6MTfigK9QTSwgU2hhbWVlciBLb2xvdGh1bQ0KPiA8c2hhbWVlcmtvbG90aHVtQGdt
YWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVy
YWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+ID4NCj4gPiAoVGhpcyBpcyBteSB0aGly
ZCBhdHRlbXB0IHRvIHNlbmQgdGhpcyBzZXJpZXMgdG8gcWVtdS1kZXZlbCAvIHFlbXUtYXJtLg0K
PiA+IFByZXZpb3VzIGF0dGVtcHRzIGZhaWxlZCB3aXRoIHRoZSBmb2xsb3dpbmcgZXJyb3JzOg0K
PiA+DQo+ID4gcWVtdS1hcm1Abm9uZ251Lm9yZzogY29ubmVjdCB0byBlZ2dzLmdudS5vcmdbMjA5
LjUxLjE4OC45Ml06MjU6DQo+ID4gQ29ubmVjdGlvbiB0aW1lZCBvdXQNCj4gPiBxZW11LWRldmVs
QG5vbmdudS5vcmc6IGNvbm5lY3QgdG8gZWdncy5nbnUub3JnWzIwOS41MS4xODguOTJdOjI1Og0K
PiA+IENvbm5lY3Rpb24gdGltZWQgb3V0DQo+ID4NCj4gPiBJJ20gbm90IHN1cmUgaWYgdGhlIGlz
c3VlIGlzIHJlbGF0ZWQgdG8gbXkgc2V0dXAsIHNvIEknbSBub3cgdHJ5aW5nIHRvDQo+ID4gc2Vu
ZCB0aGUgcGF0Y2hlcyB2aWEgbXkgR21haWwgYWNjb3VudC4NCj4gPg0KPiA+IEFwb2xvZ2llcyBp
ZiB5b3XigJl2ZSBhbHJlYWR5IHJlY2VpdmVkIHRoaXMgc2VyaWVzIGluZGl2aWR1YWxseSwgYW5k
DQo+ID4gdGhhbmsgeW91IGZvciB5b3VyIHBhdGllbmNlLikNCj4gPg0KPiA+IEhpLA0KPiA+DQo+
ID4gT24gQVJNNjQgcGxhdGZvcm1zLCBtYW55IGVycmF0YSB3b3JrYXJvdW5kcyBhcmUgYmFzZWQg
b24gQ1BVDQo+ID4gaWRlbnRpZmljYXRpb24gcmVnaXN0ZXJzLCBwYXJ0aWN1bGFybHkgTUlEUl9F
TDEgYW5kIFJFVklEUl9FTDEuIFNvbWUNCj4gPiBvZiB0aGVzZSBlcnJhdGEgcmVxdWlyZSBjb3Jy
ZXNwb25kaW5nIGZpeGVzIGluIHRoZSBndWVzdCBrZXJuZWwgYXMNCj4gPiB3ZWxsLiBUaGlzIGJl
Y29tZXMgYSBjaGFsbGVuZ2UgZHVyaW5nIGd1ZXN0IG1pZ3JhdGlvbiBiZXR3ZWVuIGhvc3RzDQo+
ID4gd2l0aCBkaWZmZXJlbnQgTUlEUi9SRVZJRFIgdmFsdWVzLCBldmVuIHdoZW4gdGhlIFZNTSBw
cm92aWRlcyBhDQo+IGNvbW1vbg0KPiA+IGJhc2VsaW5lIGZlYXR1cmUgc2V0IHVzaW5nIHRoZSBy
ZWNlbnRseSBpbnRyb2R1Y2VkIHdyaXRhYmxlIElEIHJlZ2lzdGVyDQo+IHN1cHBvcnQuDQo+ID4N
Cj4gPiBUbyBhZGRyZXNzIHRoaXMsIHRoZSBMaW51eCBrZXJuZWwgbm93IHByb3ZpZGVzOg0KPiA+
DQo+ID4gLUEgbWVjaGFuaXNtIHRvIGV4cG9zZSBpbXBsZW1lbnRhdGlvbiBDUFUgZGF0YSB0byBn
dWVzdHMgdmlhIEtWTQ0KPiA+IGh5cGVyY2FsbHMgWzBdOg0KPiA+DQo+ID4gIEFSTV9TTUNDQ19W
RU5ET1JfSFlQX0tWTV9ESVNDT1ZFUl9JTVBMX1ZFUl9GVU5DX0lEDQo+ID4gIEFSTV9TTUNDQ19W
RU5ET1JfSFlQX0tWTV9ESVNDT1ZFUl9JTVBMX0NQVVNfRlVOQ19JRA0KPiA+DQo+ID4gLUEgd2F5
IHRvIG92ZXJyaWRlIGltcGxlbWVudGF0aW9uIElEIHJlZ2lzdGVycyAoTUlEUiwgUkVWSURSLCBB
SURSKSwNCj4gPiB3aGljaCB3ZXJlIHByZXZpb3VzbHkgdHJlYXRlZCBhcyBpbnZhcmlhbnQgWzFd
Lg0KPiA+DQo+ID4gV2hhdCB0aGlzIFJGQyBkb2VzOg0KPiA+DQo+ID4gVGhpcyBSRkMgZW5hYmxl
cyB0aGUgdmlydCBtYWNoaW5lIHRvIHNwZWNpZnkgVGFyZ2V0IEltcGxlbWVudGF0aW9uDQo+ID4g
Q1BVcyB2aWEgUUVNVSBjb21tYW5kLWxpbmUsIGV4cG9zaW5nIHRoZW0gdG8gdGhlIGd1ZXN0IHZp
YSBLVk0NCj4gaHlwZXJjYWxscy4NCj4gPg0KPiA+IEV4YW1wbGUgdXNlIGNhc2UgKGhvc3RzIHdp
dGggZGlmZmVyaW5nIE1JRFJzKToNCj4gPg0KPiA+IC4vcWVtdS1zeXN0ZW0tYWFyY2g2NCAtbWFj
aGluZSB2aXJ0LGdpYy12ZXJzaW9uPTMgXCAgLWVuYWJsZS1rdm0gXA0KPiA+IC1iaW9zIFFFTVVf
RUZJLmZkIFwgIC1tIDFHIC1zbXAgY3B1cz00LG1heGNwdXM9NCBcICAtY3B1IGhvc3QgXCAgLU0N
Cj4gPiBpbXBsLWNwdS4wLm1pZHI9MHg0ODFmZDAxMCxpbXBsLWNwdS4wLnJldmlkcj0wLGltcGwt
Y3B1LjAuYWlkcj0weDU1MSxcDQo+ID4gICBpbXBsLWNwdS4xLm1pZHI9MHg0ODFmZDAxMSxpbXBs
LWNwdS4xLnJldmlkcj0wLGltcGwtY3B1LjEuYWlkcj0weDU1MQ0KPiA+IFwgIC1rZXJuZWwgSW1h
Z2UtNi4xNi1yYzIgXCAgLWluaXRyZCByb290ZnMtaXBlcmYuY3BpbyBcICAtYXBwZW5kDQo+ID4g
InJkaW5pdD1pbml0IGNvbnNvbGU9dHR5QU1BMCByb290PS9kZXYvdmRhIHJ3IGVhcmx5Y29uPXBs
MDExLDB4OTAwMDAwMA0KPiA+IGtwdGk9b2ZmIiBcICAtbmV0IG5vbmUgXCAgLW5vZ3JhcGhpYw0K
PiA+DQo+ID4gSGlnaGxpZ2h0cyBhbmQgTm90ZXM6DQo+ID4NCj4gPiAtVGhpcyBpcyBiYXNlZCBv
biBDb25uaWXigJlzIHNlcmllc1syXSDigJxrdm0vYXJtOiBJbnRyb2R1Y2UgYQ0KPiA+IGN1c3Rv
bWl6YWJsZQ0KPiA+ICBhYXJjaDY0IEtWTSBob3N0IG1vZGVs4oCdLg0KPiA+DQo+ID4gLUN1cnJl
bnRseSwgbm8gdmFsaWRhdGlvbiBpcyBwZXJmb3JtZWQgb24gdXNlci1zcGVjaWZpZWQNCj4gPiBp
bXBsZW1lbnRhdGlvbiBDUFUgIGRhdGEuIEl04oCZcyBhc3N1bWVkIHRoYXQgb25lIG9mIHRoZSBl
bnRyaWVzIHJlZmxlY3RzIHRoZQ0KPiBhY3R1YWwgaG9zdCBDUFUuDQo+ID4gIElmIG5lZWRlZCwg
YSBjaGVjayBjYW4gYmUgYWRkZWQgdG8gZW5mb3JjZSB0aGlzLiBBbGwgb3RoZXIgdGFyZ2V0IENQ
VQ0KPiA+IGRlZmluaXRpb25zIGFyZSB0cmVhdGVkIGFzIHVzZXItZHJpdmVuIHdpdGggbm8gaW50
ZXJuYWwgdmVyaWZpY2F0aW9uLg0KPiA+DQo+ID4gLUZvciBub3csIG9ubHkgdGhlIERJU0NPVkVS
X0lNUExfKiBoeXBlcmNhbGxzIGFyZSBzdXBwb3J0ZWQgb24gdGhlDQo+IFFFTVUgc2lkZS4NCj4g
PiAgU2VlIHBhdGNoZXMgMSBhbmQgMyBmb3IgaW1wbGVtZW50YXRpb24gZGV0YWlscy4gVGhlc2Ug
YXJlIGxvb3NlbHkNCj4gPiBpbnNwaXJlZCAgYnkgU2FsaWwncyB2Q1BVIGhvdHBsdWcgc2VyaWVz
IHBhdGNoIGhlcmUgWzNdLiBUaGlzIG1heQ0KPiA+IHJlcXVpcmUgYSBtb3JlICBnZW5lcmljIGFw
cHJvYWNoIGlmIHdlIGhhdmUgdG8gc3VwcG9ydCBvdGhlciBTTUNDQyBoeXBlcg0KPiBjYWxscy4N
Cj4gPg0KPiA+IC1UaGlzIHNlcmllcyB1c2VzIG1hY3JvcyBhbmQgZGVmaW5pdGlvbnMgZnJvbSB0
aGUga2VybmVsJ3MNCj4gPiBpbmNsdWRlL2xpbnV4L2FybS1zbWNjYy5oLiBJIGFtIG5vdCBzdXJl
IHdoZXRoZXIgdGhlc2Ugc2hvdWxkIGJlDQo+ID4gZHVwbGljYXRlZCAgaW4gUUVNVSBvciBtb3Zl
ZCB0byBhIFVBUEkgaGVhZGVyIGluIHRoZSBrZXJuZWwuIEZvciBub3cgSQ0KPiA+IGFtIGNhcnJ5
aW5nICBpdCBpbiB0aGUgdGVzdCBicmFuY2ggaGVyZSwNCj4gPg0KPiA+DQo+IGh0dHBzOi8vZ2l0
aHViLmNvbS9oaXNpbGljb24vcWVtdS9jb21taXQvOGY1ODNjNzZhMmE1ZjYwY2YwZjk2MTZkNjFk
DQo+IDA4DQo+ID4gNjNlNTI0ZWYzODgNCj4gPg0KPiA+IFRoaXMgaXMgbGlnaHRseSB0ZXN0ZWQg
b24gSGlTaWxpY29uIEFSTSBwbGF0Zm9ybXMuIEEgY29tcGxldGUgdGVzdA0KPiA+IGJyYW5jaCBj
YW4gYmUgZm91bmQgaGVyZSwNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vaGlzaWxpY29uL3FlbXUv
dHJlZS9hcm0tY3B1LW1vZGVsLXJmY3YzLXRndC1pbXBsLWNwDQo+ID4gdS1yZmN2MQ0KPiA+DQo+
ID4gUGxlYXNlIHRha2UgYSBsb29rIGFuZCBsZXQgbWUga25vdy4NCj4gPg0KPiANCj4gSGkgU2hh
bWVlciwNCg0KSGkgS2h1c2hpdCwNCg0KPiBUaGFua3MgZm9yIHB1dHRpbmcgdGhpcyBzZXJpZXMg
dG9nZXRoZXIuIEkgZ2F2ZSBhIHF1aWNrIGxvb2sgdG8gdGhlIHBhdGNoZXMgYW5kDQo+IHRoZSBv
dmVyYWxsIGFwcHJvYWNoIGxvb2tzIHNvbGlkIHRvIG1lLiBXaGlsZSB0aGlzIHdvcmsgaXMgb3J0
aG9nb25hbCB0byB0aGUNCj4gIm5hbWVkIENQVSBtb2RlbHMgb24gQVJNNjQiIHNlcmllcywgaXQg
aXMgYWJzb2x1dGVseSBlc3NlbnRpYWwgZm9yIHByb3Blcg0KPiBndWVzdCBlcnJhdGEgaGFuZGxp
bmcgZHVyaW5nIG1pZ3JhdGlvbi4NCj4gDQo+IEkgZGlkIG5vdGljZSB0aGF0IHRoZSBwYXRjaGVz
IG5vIGxvbmdlciBhcHBseSBjbGVhbmx5IG9uIHRvcCBvZiBFcmlj4oCZcyB2OC4gU2luY2UNCj4g
SSdtIHZlcnkgaW50ZXJlc3RlZCBpbiBzZWVpbmcgdGhpcyBtb3ZlIGZvcndhcmQsIEkgd291bGQg
YmUgaGFwcHkgdG8gcmViYXNlDQo+IHRoaXMgb24gdG9wIG9mIHY4IGZvciB5b3UgaWYgeW91J3Jl
IGN1cnJlbnRseSB0aWVkIHVwLg0KDQpSaWdodC4gVGhpcyB3YXMgYmFzZWQgb24gYSB2ZXJ5IGVh
cmx5IHZlcnNpb24gb2YgRXJpYydzIHdvcmsgYW5kIGRlZmluaXRlbHkgbmVlZHMNCmEgcmViYXNl
LiANCg0KPiBMZXQgbWUga25vdyBpZiB5b3UnZCBsaWtlIG1lIHRvIHNlbmQgb3V0IGEgcmViYXNl
ZCB2ZXJzaW9uIQ0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5LCBpdCBpcyBjdXJyZW50bHkgb24gbXkg
VG9EbyBsaXN0LiBJIGludGVuZCB0byB0YWtlIGEgbG9vayBhdCBib3RoDQpFcmljJ3MgYW5kIHlv
dXIgbGF0ZXN0IHNlcmllcyBhbmQgd2lsbCByZXNwaW4gdGhpcyBzb29uLiBUaGF0IHdpbGwgYWxz
byBnaXZlIG1lIGFuDQpvcHBvcnR1bml0eSB0byBnbyB0aHJvdWdoIHRob3NlIHNlcmllcyBpbiBk
ZXRhaWwuIA0KDQpJZiBzb21ldGhpbmcgZWxzZSBjb21lcyB1cCBpbiB0aGUgbWVhbnRpbWUgdGhh
dCBjaGFuZ2VzIG15IHByaW9yaXRpZXMsIEkgd2lsbA0KbGV0IHlvdSBrbm93IHNvIHRoYXQgdGhp
cyB3b24ndCBiZWNvbWUgYSBibG9ja2VyLg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

