Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9783AEE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqY21-00026Q-Ew; Thu, 12 Feb 2026 09:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqY1z-00025T-Et; Thu, 12 Feb 2026 09:50:59 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqY1x-0000IG-HK; Thu, 12 Feb 2026 09:50:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1iSEooNKroZIwmx++GZatE5XFqUUPxgjveBHibEwEXAeQqCBVuwpYeng+925ruXFBxG7A+IfAOiL9h2Xeba0E+u4XrUhcfqx4Wg4reeF+kdWc03XT4YYf4FsdaIK6WkbLmspm2TNCKaRAlzwlWRgvoi2mlfx+RgRR/KtcNT3BBk3XomjwjTTfSw3o32171WzB1wRiSX56ZD3DPh1DbB7Q2GOvRqzRR8P/yp49VognNGNfftngL7aKlohWkBTqcK/INmYUhfYk/4L0ADjDEUdK+QjA93WDqxnjkwD8188NJwCrabxInm9lLwCGwXw0S/cC2ye9PESvFfsl25PPes7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bs8K9V5ze+op3AJsDSGSKG8BUfuW/hF8VlJJAolBz7k=;
 b=Cq7wIn5mTQnsx247Cz4gPrM2Obbvr/4sq491zzotUWZlWqMjbIrW0ch3J2/ZLQpk8q7VXIuiQHA5ntfrbUmVUMDAl+7TMMNkkrDouQAIT+E2twGc6Oiy/zoihvsDf3v1kQXDQcLse8O1ESa0efaqWRuwnHJb8U07HFc7Pa/AdM7NUlDnnGUc6b7kGnVY8+8EmkYTQnx2dPauQg3x8g++rBTfBw9KwoWneb0Ge4p+S7Q+XII95O6sR72OAdVhRNvFlpR/FDsADK5IU1FM5oZHnGR9wXu1FJGV+p67vzj2GUZ1rY0YqXHTyNOqAOmqjmVlWsKXonhySvbqqeqaDlbdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs8K9V5ze+op3AJsDSGSKG8BUfuW/hF8VlJJAolBz7k=;
 b=p66aYCtfOKly8duXL0iiJX244EtFxbz4FkEqTW9buFAg9INqd8Q1zAKyJqLflzuIzc0ttyKdddbB9RaFvo5whM7hZhcjuVfrNbo4WbgdWF9meSmi7iHKAUCnpxNlbBy46chVeIstHSPVXNrK6v4krIC7Aiw5460+iHEfIkeu3GKK9LewSAX8Ux8if2YTgEcl6lohyp18jOy5m5pb4Zsuakgz+MD7tyDfaJ56H2xt7CZAJQUa4SdqgwDHkeCxGsBQnf1QBio+3WvQjRLMAbHrqEfWy61C3gJv+VpFRe9tMq9OeKIGPif/oqrLBpaoAFO/qi9LvSvM6MlfXj9C5jEk1Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 14:50:49 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 14:50:49 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Thread-Topic: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Thread-Index: AQHcl3fclJVY+/1eUEyrJW1egg4NVbV6yXyAgADQx/CAA5IqgIAAAY3g
Date: Thu, 12 Feb 2026 14:50:49 +0000
Message-ID: <CH3PR12MB7548F06A2BB9C009FD2043F2AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
 <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
 <CH3PR12MB75483C2BA4EDC24CA0F78A4CAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <46d3b859-6e05-4c03-8e77-0aa76629f772@redhat.com>
In-Reply-To: <46d3b859-6e05-4c03-8e77-0aa76629f772@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BN7PPFEE0F400A9:EE_
x-ms-office365-filtering-correlation-id: 56553eeb-027b-4968-990e-08de6a461c86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jwdhDxSh5O9jTMza5LX1nCr8OV0ntypXwu5GSrizOZdxNUtxiibcecUDnFLi?=
 =?us-ascii?Q?+DH9rpOq9aukNpi1gmfs2IhALjmhirqlY4W1BXMwNkY3/q1QuXo7+Xeskuyv?=
 =?us-ascii?Q?Ev3bl4fFDB1itWwk79KF8jjJ4i7z2Oh4sWp3G9mkHaCQsCRiijsrE1Dh5YXj?=
 =?us-ascii?Q?m7iCRiEpzDv6Dog8Ke5V+lHxNzbwAB23Pms+/ala35NEeTtWPAVZl2qAjCtP?=
 =?us-ascii?Q?27nAEGDGpEWa6YUwDlEx5/Zgjv1sEs87o9aDNQfx8CIVY+ZezJedQjFHJ3DB?=
 =?us-ascii?Q?rAE+ITaiD7mAxiE48t+ryYdf+PdPgMnQMXpSYVpDrIMx3JTEqd8BqNu4HXUc?=
 =?us-ascii?Q?qoACVN9Gcthvs0Qga/N91DqqgoGuon4hv3DpUfw7/pTttpoBganQCSBRkDwp?=
 =?us-ascii?Q?jdj28wPZ4psI9UoF4g5EtTj6meabc20yHUlybd+8z3hDMlc0VzXhDwFvSeeV?=
 =?us-ascii?Q?xsvWaahjrKXsrM2yZhWNR+yUFZkgQ1TZMUNMnTWAZyscRlEJUh1KvY+/VBXg?=
 =?us-ascii?Q?Z5i0h4TMlrEOfV+89wTR9R78BroD9RlsyOmYDc97yYENVd80Fnv1tENyyDOS?=
 =?us-ascii?Q?PF02Sj1IT7pxtdj3q88/KeUZuBq0+l1SGiJasKnf1a3jx0UPf6njlV19U4In?=
 =?us-ascii?Q?L9+QXrYJoSM5j6JZqduq1SRmhYcZqnEZcH6UieoyTFPDP6/0NokVmjigaF29?=
 =?us-ascii?Q?dV3zX6kvgc6H7BHOgzW/TiF/CVGahP93aZZ5h+T4FefsdohGXWb2juBJl+Su?=
 =?us-ascii?Q?EEj+4LEKbSjcbDgqrSO7sqRV0SNZNZuoHTy1FP5eoc86XYYhJ9qpPY0R1/iP?=
 =?us-ascii?Q?KBx8bd+jPSV+vaNkbsSXDiSFhF2WaoNV2B9Ae9riEX+Uw7E02TYi9lWGuDYA?=
 =?us-ascii?Q?J4AfxEVT6ThagyFqMxoEE+FHRX7KqEMo7Quix6/Wm4yihKr6mpbWl+nTZdS9?=
 =?us-ascii?Q?UNGDAQ+nyuf31XQdQCDaqGJU/nmPbu6we3Yhr51O4t/LMM+4pgJuZGBtPF7r?=
 =?us-ascii?Q?6Qw0vtgTVD57/kuIVHlv8LTMDhQ6J+iJTHP/sbjP1FQkJ69DpHLnO6vLqgQ2?=
 =?us-ascii?Q?WA0HadNEgyx0R7IQXmCfBsv3DBoMFt4ElbmoZtcdtuvYYgr539Pk2cpvavue?=
 =?us-ascii?Q?Zvj5lv9aIjVqTuMHTdGWz5y7YfBcQDMb1xmHnaVD+QewzHBr3NYO3qcSATYs?=
 =?us-ascii?Q?95B6egsjVZhCtXTk7I1FoZ4YcY0rFhS4r9KgC0Zcn26+d7gpwu5I7gx1NwC9?=
 =?us-ascii?Q?pthf9G1S6qMXbKRXX2zxsL6eS0vl+XCHwAZE/fhk+hSSUmuvDRo74+vMDgOy?=
 =?us-ascii?Q?XdTefiPDLBfLlw6a40cQB8lYOhh5mcwIXpPpUgEfvpM1MPO5Ch5jy83Zo1M4?=
 =?us-ascii?Q?YUzi5Q991JDWKz+81Giq1fbOW1jwrs2L4ilL3FQXC44KD7djSfHMWaHy7nie?=
 =?us-ascii?Q?MIjvQXYehKDCfMa/KDtJseZbh8JPtCN5Etmj0WmDi5NTWUW9KaVscqAcCMdc?=
 =?us-ascii?Q?Tlsbeae+bhr+QXfRh2p8m6JvQkZTmU9nCRODv1XMnzdAqq5Q2CcRstoG7Zsl?=
 =?us-ascii?Q?6bVdHL4fJ6F55SprFOmkuT8H3vmTlvR709QTUDkfN9VyfUOFrBNMw+VP5s3M?=
 =?us-ascii?Q?j2eWz1gtlLx4auPKle0YmT0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PAtQPGGqeo5ZANwFeFwYODdN938c19KZLV6yfGgxJvD8ojFkujudqrZ35JUS?=
 =?us-ascii?Q?XMgf1ufl2Z0aLr+lKqwUoHiz8iTligfbgogYrQyednsJL9BemdetIROrfIY9?=
 =?us-ascii?Q?4/frf27R7Qtz2hs4FasMykO3OSdZZOwVzzCQuX5/quD/DWhQZJ75+8KBkv1R?=
 =?us-ascii?Q?VRQx+hnK7Q2e42Am4xV8nBMSvFHkfKo0Mh3zxlxYQ+usnwv4fyonX2Ka4cEe?=
 =?us-ascii?Q?AnFH8UziyHcL8D6Qf+Zu10rIWGdyS4ieQqEPOmbaqgh5yuk5KD6xHuwTxX20?=
 =?us-ascii?Q?1BoQnJ0yo1iTnkyp0W2KpjBXDa4p+b+FaVpLfSBJ7Y8wQm2Q81ZGQWWdf5KZ?=
 =?us-ascii?Q?9tsusgHmB67gmDcGeNU63ogcLqXuqdRQ6uD4Ss4VYpAx1IVduKJaReWdM8O1?=
 =?us-ascii?Q?JOb5ocQAzphhXMDEk+McnoiTZp+Zna44Q9C3JfJRAJHsTZ7d8QKx5yCWbzpw?=
 =?us-ascii?Q?eGaAlBSEgudRdg6U7AabEaJA1OuKl667DG8IhWuJ/dD6kco6hmdvRip8Yo0L?=
 =?us-ascii?Q?WLHM7HmJfqH1acOCo5qQn6pb7ShvB6pK87p7s2X3o+qVgfrfRFh4Q40y7bwu?=
 =?us-ascii?Q?LlBveStF2JCtW9dAQyIGEO0cGu9B5ayW7Y0LIoQ57x3EFUnHzB01p5RK1zCp?=
 =?us-ascii?Q?PMfq+KKbaOXgl/3PZC8HD5F/QRf5vFYv/L99/5vROavrB8kJqRA8tCC4gTiq?=
 =?us-ascii?Q?cOWfBr8b2UKykh5lVW0X4rYYQZy38jULz2xCbeHU3bPzcdwkGzk39BiV4dUr?=
 =?us-ascii?Q?+UYj2OhHt+sShPT0AmDqJqpU+FJnU8c2ZeHtNK+Cn4K3f/kM97NFu5TpEd3T?=
 =?us-ascii?Q?pTELzTHeGHCNr7Mt7wn87nqAtMYGrkl9L3pPCue02fZP1OsQuMh3NyPF9VGI?=
 =?us-ascii?Q?b1oDWYI+XyL1IcL2eu4WJzZ6yt43eyNa5Ti4MHcYQmKPUy4pYoxAawHCPfV8?=
 =?us-ascii?Q?xH2emETbK498DvGWg7osRs7aNA1+eF11lW6svqt8YaQu5Phgx9uDGytgNOpg?=
 =?us-ascii?Q?bg0e8wb+z+v0epOx341evhIkZoJLu/1v9l75t1qH3xiWo8Fl6E+YatL7tw5Q?=
 =?us-ascii?Q?Jju3mPL6XJ3Ht+BgBAqYDw3TZzadYSg7VZSODX3RMURPuKpMCKXEbxWLTT6E?=
 =?us-ascii?Q?v5MMR7zL8v3qxSaUflaLpb1iTaTpwAZf5/kraU87G1diCXY2+cYAJUP0FsV7?=
 =?us-ascii?Q?q3s/i65vy+E1lCcjQuRFFWtqq1Um7vpUsqHsS5GrynRtxQRf9pLEKqO2joix?=
 =?us-ascii?Q?rrOUzRKaztrXnijJFUhGqie5af1XX9Cc4P40KAnPxeGRtExeGpsP9j15Ugy0?=
 =?us-ascii?Q?UAHn8muOhgoHpmLBdbPlPMVEADIDlGbTljCRyyQ3uQWrnkwXHG1crg1TB3/n?=
 =?us-ascii?Q?oy7pzMrWAcLFAsAl0QwO3FfMamL3hvuzylHXd2atgzSsK0QABgCKB4AcGoRh?=
 =?us-ascii?Q?UX6nNzm5LINoDpERPUDx3xVn0XKJzqaid5xA+EJM4818r5bYCaoQApjoiURT?=
 =?us-ascii?Q?yEy9gNt5Ni0RWGNI0VRwZ3EpJKvQ6hTtquo9okBvhU5qRkyjhqB6S1G6V+dL?=
 =?us-ascii?Q?ueKvRaZtyfHMT7CBDSJK655wNN3hzMai4x17m3BIr4muiWYK+sf7aNR6zz3w?=
 =?us-ascii?Q?aU0NIt4c6y5Cn0QLBxB/U+mpTdN+TxSdJQIRlaiFleGCwHVk9cAX3DaNh6hY?=
 =?us-ascii?Q?JDgu1nD7j5UVe7QD6yNB6ZbSoCuBWKfe9A7RtVq35I4JbW1ClLwtjnSp5DFY?=
 =?us-ascii?Q?Hl+XGXTamQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56553eeb-027b-4968-990e-08de6a461c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 14:50:49.1928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNUm4KnhxeprWgaqqpXypihIE2ex4fdw8iz+Ui8RqcMvEg9mD996dNBnAa4tCc1dPd9qOquoiUjti2pqDnTLcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Hi Eric,

> -----Original Message-----
> From: Eric Auger <eric.auger@redhat.com>
> Sent: 12 February 2026 14:42
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Nicolin Chen
> <nicolinc@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jiandi An
> <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
> interface
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On 2/10/26 9:46 AM, Shameer Kolothum Thodi wrote:
> >
> >> -----Original Message-----
> >> From: Nicolin Chen <nicolinc@nvidia.com>
> >> Sent: 09 February 2026 19:42
> >> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> >> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> >> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> >> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> >> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> >> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> >> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> >> <kjaju@nvidia.com>
> >> Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV
> ops
> >> interface
> >>
> >> On Fri, Feb 06, 2026 at 02:48:04PM +0000, Shameer Kolothum wrote:
> >>> CMDQ-Virtualization (CMDQV) is a hardware extension to SMMUv3 that
> >> enables
> >>> virtualization of multiple command queues (VCMDQs).
> >> Let's mention "NVIDIA", noting it's a non-standard extension.
> > The idea of this ops based callback is to make it more generic and not
> > NVIDIA specific to start with. This leaves room in case ARM introduces
> > a standardised version of something similar in the future, or if anothe=
r
> > vendor provides a similar extension.
> >
> >>> CMDQV support is a specialization of the IOMMUFD backed accelerated
> >>> SMMUv3 path. Introduce an ops interface to factor CMDQV specific
> >>> initialization and CMDQV vIOMMU/vEVENTQ allocation behavior out of
> >>> the base implementation. The ops pointer and associated state are
> >>> stored in the accelerated SMMUv3 state.
> >>>
> >>> No functional change
> >>>
> >>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> >>> ---
> >>>  hw/arm/smmuv3-accel.h | 19 +++++++++++++++++++
> >>>  1 file changed, 19 insertions(+)
> >>>
> >>> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> >>> index c9c10e55c3..ca087240e5 100644
> >>> --- a/hw/arm/smmuv3-accel.h
> >>> +++ b/hw/arm/smmuv3-accel.h
> >>> @@ -16,6 +16,23 @@
> >>>  #endif
> >>>  #include CONFIG_DEVICES
> >>>
> >>> +/*
> >>> + * CMDQ-Virtualization (CMDQV) hardware support, extends the
> SMMUv3
> >> to
> >>> + * support multiple VCMDQs with virtualization capabilities.
> >> Ditto
> >>
> >>> + * CMDQV specific behavior is factored behind this ops interface.
> >>> + */
> >>> +typedef struct SMMUv3AccelCmdqvOps {
> >>> +    bool (*init)(SMMUv3State *s, Error **errp);
> >>> +    bool (*alloc_viommu)(SMMUv3State *s,
> >>> +                         HostIOMMUDeviceIOMMUFD *idev,
> >>> +                         uint32_t *out_viommu_id,
> >>> +                         Error **errp);
> >>> +    void (*free_viommu)(SMMUv3State *s);
> >> I don't see much value of having alloc/free_viommu..
> >>
> >> Type and data structure are the only difference from the standard
> >> viommu routine, and both are already in the uAPI header.
> > That is right. But again, this is mainly to keep the interface generic.
> > IIUC, Eric had suggested, using an ops or object style abstraction
> > to separate extension specific behaviour from the core code.
>=20
> My initial thought was callbacks to specialize implementation for accel
> smmu without vcmdq versus accel smmu with vcmdqs. Effectively we could
> later imagine to have other implementations with vcmdqs but it is
> difficult to guess the specialization needs at that stage. I think in
> the original series you already add the first kind of differentiation.
>=20
> At least reset and init need to be specialized.
>=20
> Maybe alloc_viommu does not need to because the differentiation only
> happens on the type arg. But originally you where also turning off
>=20
> s->tegra241_cmdqv if IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV failed so
> I had
> the impression you reverted to a fallback impl. If there is
> specialization, I still think ops are relevant. Eric

There is no fallback implementation. So just to confirm, you are suggesting
to remove the ops completely or just keep the ops for reset/init only?

Thanks,
Shameer


