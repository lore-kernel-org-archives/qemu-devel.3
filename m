Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F76ECD6CA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 17:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqDgD-00065e-3H; Wed, 11 Feb 2026 12:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqDfk-0005lO-2P
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:06:41 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqDfg-0003xP-S1
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:06:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxgOqdoOU6uqvHA6Zzj90RA5zcMvNGwS3HsUKfRt6oWNNOkfr9oOBLX3Z76nAAKloiWUZXHaeFS02TihsYoQnhJyhlolKsJM23xwCU8q7uMqvKqLLWadczOC76+BqER6hTOjOI9XgpmqjPvGtT2Q12+qOoDAjWmSNa/lkD5F4Bt1lE2rAeYRFm3CdwZtVo7e9gNYx/CFpCxV4mYjpdV06E++RRzbnT8vXXX83WSUnOM5wOGGGONoGMRRloqEdTqemtloK9IH9v4n20GPd4CCqTB9yuqB0pe7dOgltNhYQxTDmkBd+Pa2zkv+xzsCGhgRTkHGU4uMHQlxvjUn42ctLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xf9Nfgbc02jx0fZyFnCfWId4HQh0S/8oWG2c+ugF70=;
 b=X2/++3Wpf7cmPI3LMa5uR45QgIg8U7eCJi8f2jeUTnAobmhFfiopfYxQtvINqMozsjLE9SgPK8BiOeIEIBxjaQPwp4/K3Y1I5f806i0jWY0wso3sl55iCrr0yn12W38bAeiRXrh3lFNUThbBUiFAKXBGJBaGplABArwYNAFGuvpRffTiYMjUXdoXeWQHj6VzHn9YVgzMVxY15EAGBZ6LNW/IMIWoSepAYh3swAPez0jgk69jmHZaOUEsGDlt3OLAqDoFj0i5QpTxjfoRdzOUgt9/IISj3v0x/GMSx/P1vOxRKzCuCJ39gPq6m3/YLOE9xxnJ0kexfAi2u/9NDQxFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xf9Nfgbc02jx0fZyFnCfWId4HQh0S/8oWG2c+ugF70=;
 b=fJtRwWq9A6WAfldsZHeMShEmhIfgb6L8ro9Oj30eT7dTGSeSmApS0IHy8x+BKTCNvT4OlRt2FxJ6IkddJdKP7N8EKpOQ23cadDca8FuCGsgVURtPV4pxRsP+pqmqMHSHR+I84Ud9kK8fOXMO/zynpMgdFsAnj2kv2eOBqGsGZLFpHmbOlr3HKGRMXyrdn0l07OESy4jd1g3x1tZa/AuYpaS+Jo2OYFHFKxw+R5/2zYZgzoavo3kSz80OK1Q58euGbhgrULK+UJtIDkErDYwQjHsfSN1jvXuAZejoKGXHbkVyEtxLIE7EpcnimvgQ/2gOn5XFEj/SAGA3e/i+6JqAsQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 17:06:31 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 17:06:29 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Ankit Agrawal <ankita@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>, "alex@shazbot.org" <alex@shazbot.org>,
 "clg@redhat.com" <clg@redhat.com>
CC: Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)"
 <targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2 2/2] hw/vfio: align mmap to power-of-2 of region size
 for hugepfnmap
Thread-Topic: [PATCH v2 2/2] hw/vfio: align mmap to power-of-2 of region size
 for hugepfnmap
Thread-Index: AQHcmwNz2LKOdwy/8EiZUvw1bFMZ1LV9uyvA
Date: Wed, 11 Feb 2026 17:06:29 +0000
Message-ID: <CH3PR12MB7548DD0FE9CB75871A70EC8FAB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260211030615.3202-1-ankita@nvidia.com>
 <20260211030615.3202-3-ankita@nvidia.com>
In-Reply-To: <20260211030615.3202-3-ankita@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH2PR12MB4247:EE_
x-ms-office365-filtering-correlation-id: e4ac305d-75c6-4c76-44c0-08de698fe645
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?i8Fo1EmsXbGSG3008S4pNs/uY0utY+zJFoZQdoY79OVOkUPycYRpjwU1sRIf?=
 =?us-ascii?Q?FkXtq1itrux6wH/4rZ4KYnqLwwYNnjUJyX6ToUQKM4i/Ca+c/Fzx58rZlma/?=
 =?us-ascii?Q?iRFqDedmQ9D82ATboQomBN1dv1QksLnWWKDjDCuudrjEp7r7gryS19jgtA+I?=
 =?us-ascii?Q?s1G6FeL7ryLho4yp6h+xnlgknNyeTKsdcbOTv+nirrN8oupeLkZp3aamXyDO?=
 =?us-ascii?Q?VOOmU91BVKqEAuJ3LhSPoPPEAOP3sVMqGBkuTgeCqyYHbUUpbIU21PeCmQTo?=
 =?us-ascii?Q?JEpUgdSsjOpJhnIusEOA8xIW8bkNmkMU36n+HPu+Hk1+mHg3nVSKKei6AlvZ?=
 =?us-ascii?Q?AUYDCWE65SEYt+EHXnILbC7Sh3YSKtZx+mUPQ5658jf/fG/ya9TczUJZlncl?=
 =?us-ascii?Q?7iS3FRcXmrV4h0CMIra5fNYvXLaEKqgxbdTjeL5KO3Gm9t7hjSzVSsMYgQ9V?=
 =?us-ascii?Q?02x1vLSAJAlMwX3lR5wXwXYoYYzDU3tTHDwJT8Ynk3ZcawB5wS6DlbJogD4N?=
 =?us-ascii?Q?Pe+76qZdjjoTg6gWPDqSAeFhekKDj9vbxCmzFy2h7jNQuuvoTVNRVmBLStP8?=
 =?us-ascii?Q?vfArSkwAccOPKS3ii2Cm7DWkGF4HH/0JX67KxMj4VxmgObYtVPBSQawwhLgc?=
 =?us-ascii?Q?imnw1SwYPbRD/KPqyxHT+xhWCYmjgY3jXkrbhzl4KKpQevBrmmpV9aFEudvX?=
 =?us-ascii?Q?phg9ih4CLHxuP5Dz4aS7CPsVfF3ICP3SP2BpaJsoEtul2VNo14qb8J7agC/3?=
 =?us-ascii?Q?Ri+bK/7aYPbRWpbjID8QghtCRWC5GDPXGoPK8ZtPj9qlmNsYY1JT5dxvHj/b?=
 =?us-ascii?Q?EmdPIBOzb7D2BxWPalz4OD15ZlENU/xNIYRUjBKvfuuvJlm6nZ+af1fB6E83?=
 =?us-ascii?Q?LeiNxNkYi2FHiHRX9+RaaVyai0D/DdIOYa6z76m5HLJJuTISXb5LmQIk8qYe?=
 =?us-ascii?Q?ZQGO+X5/cVcVqVDwxAjzEeCt+JA5lEqiU7ycj4BD3UFdMtsqR9wnJRdoOKLf?=
 =?us-ascii?Q?sVlMyMzRnkIWBKoSrC0g5bpGkHVmOM49O/d1vX5MRqb0cxmTh+NQNZaMpMNt?=
 =?us-ascii?Q?WoQyW6wufK5iurv7KPQK7BU6Zst9UhUD++0YyU4nPu/kEV2Vu0ZC2DokfQFE?=
 =?us-ascii?Q?bjjz0bBoEocrIuMviuqPT0awixFfV+f8WRjhePMky4o0N7gAbJa71PBAZTo8?=
 =?us-ascii?Q?eTZPMza53Gei0whkQdCydh49dJvZNt64Ra4ipEniucdJMGMvQ03ZBflhyQ7x?=
 =?us-ascii?Q?FrvNEPFopjtzg1y+QPLTZ/L73eGq12F4ppffbcDHi/HnCagHN9xkrzzXVpGB?=
 =?us-ascii?Q?Tmu0VnGWWx8aDwHfVJiPMUxnDUzMADF0yXJTlqnQ/twi8ncjZRYsRepYYZOs?=
 =?us-ascii?Q?I1w/OEcdsWIphgE4NQN6t2JALxMVx65yQKpmsynmj8O1AGqp+yXyfiT7KzON?=
 =?us-ascii?Q?Z9hhhEtqrGUMbIIapI3F8KxVa60NFVPIgqog2mlvqlkcHg7s6Pv5iMuSrfq8?=
 =?us-ascii?Q?1qOs9Q8FlKXrulOTAaacO6F/Cw1qiMykxR49CeFcnqfFJJCBPNqOfq0kJVCc?=
 =?us-ascii?Q?7ZN3/FguRcAdiat8XKuQWmzilN2Qv2glkeGa1aGe7xALUcB2wuALLeXFAe3Q?=
 =?us-ascii?Q?fZi0YCyHP3e6lJp3hGMaQro=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?chqTkxYZ9Wrg6lc64MskLU/OXPY5gmXfRyoPalYtj421U0wOBXcTE/MmYSKE?=
 =?us-ascii?Q?81b6oWVH/lTHu1BKQotlhmw7mLyQxzBGPOGz+v9xE0q0UVrNeWXhIPTPG3hO?=
 =?us-ascii?Q?0P40oOId5V4MkbaXJFKA1TwBqfcbGlAiRJE66CCMikoka16q7CCAoZXu0tFq?=
 =?us-ascii?Q?9OQpj6OczMRxgbR++/T7Oq9Mobl7QwyhzRL7fNF1BNxZ3pr5XTJYVaOdF/5v?=
 =?us-ascii?Q?ReA19YxLsQ9NktL+YPFFVI0+/5n6KOeMRMXM367b/JUVnhmhVV87ettEiAIL?=
 =?us-ascii?Q?VuVYEYYfUBbBs+vMb8P1u0Yxa4TSeevlAXGwl8YoRcecgiVdBc0RQD8bv2AH?=
 =?us-ascii?Q?Q0qQuQciThKEK8aI8EOc5+5J70tOLubXjV/6zgl8Rm+BEQUYBTXZ/moYWVA1?=
 =?us-ascii?Q?YpAavayCKS3lEsTp13iNVzwxPaSSDF/skrbUmZ0FidLhgIIsVOlYX4H195FA?=
 =?us-ascii?Q?sjNQUvZ8WEPXQzI/iWhg8uuGybI6s1u4zkfmP0j4F7Nb2zq/vt+/D0NHiqLL?=
 =?us-ascii?Q?kitoT3n2zZW7kvw9N54+eT0c30IFJnWlyg7Iq2JlHhGc0KTpQ4d4WCDK6Rij?=
 =?us-ascii?Q?5HNn+fUvxATcCPTDTL3zIFR9aUaC5M3cpM98NVZgxntq/HCIK5ykB4MN1VMW?=
 =?us-ascii?Q?ufbkUNrgsEA6FRHDQywvbmfvzulxq2u1t23a6crzYzKtdi+Ar5jf0oSFyQqR?=
 =?us-ascii?Q?ZZB5WBC3mZFoUEoyeuedPvauRQnBOLZLyYksDKSNGJRWm+ZvSZfmN1I1zDIz?=
 =?us-ascii?Q?NDoEUT57Na6vHwqLsMTfrTMpkXKUFN1o0BYKMGVa3Ce6xALF4ho1wrj27h0X?=
 =?us-ascii?Q?wOpuy3g5hXrzHHEripHETLZseRneQWT6HsjtpexyMfJS5Db5oV4C8O+PVzmP?=
 =?us-ascii?Q?nvQZhSYc/nKGjRPHquUuySniVePEu0yYPog2RMlmo9YIWNNZY3pj5e8+xSEn?=
 =?us-ascii?Q?6TsFptDOTryZHlX1g9RLskCmNNZkG3+fzcMQ8PsFqNkRRIGPr6yh8gz2Vc/6?=
 =?us-ascii?Q?E9rAi45PhoayKGbjeXWwpUKZjk5N+RF5pQivQvwN8YtUjoJA5OkshWam5c4p?=
 =?us-ascii?Q?+0Sol3qhfnmpjfJj7pKEd/CS/vM6bfnoOFHTnJOp4T2bA2q1cwYeQn6M09/c?=
 =?us-ascii?Q?aW6uudKj8H47ogaMkgOMunVYc+c5GAatQ7ntQlkBIw5OhFsMowSBGqW44kr0?=
 =?us-ascii?Q?ExFIediA8WQ0iR0DeeD9PzDECRXRbM0uqELohLCJIJlFVEsjPMd4QhWhzGjr?=
 =?us-ascii?Q?G0ZU+/X2NEZ7karxIlL8YgD+EF9YWOI9GD6yU/JSV7YZ75HhNJMoxbVPk48K?=
 =?us-ascii?Q?N+h2zdEDPreVbUlPWKAX9h2hm061gYKkX7Bs3YBKHB8N8JDr9UD/cf5mLI85?=
 =?us-ascii?Q?rpOz5p19EOmSaGcoVUqLaG0rKO8gIVk7EQ/WfrPoDdgaPcHizJqE8kMrZSJf?=
 =?us-ascii?Q?ok07af2YspRm5A6OQJjra9WaQ/SDpE5eGzEQakT+ul7SFVhoFf9MnoVwRZ/k?=
 =?us-ascii?Q?YWxSZrVkmlPGQkTowNAvPkknGEpqWA7CjV1vH2aXfMttb9bhO/SnESeMw0gN?=
 =?us-ascii?Q?QASLuwCC3idLMDjvZy99NQA+n5fhGVCJIzBvwfWWfi0bxpcRaBIHCDkNeYFs?=
 =?us-ascii?Q?3yqBhXXzkLaaq6WBwdU7c8ibblkH6WPwiEzWL2TgV1dq4lw9MxSKPjDwKTk3?=
 =?us-ascii?Q?9eYXW1VHphaZaoLq9xdLOUEoVritVDHt3vSaK+jHOD3rxdQdy56UWMTZIQkQ?=
 =?us-ascii?Q?EfVNYOXBoA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ac305d-75c6-4c76-44c0-08de698fe645
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 17:06:29.6844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yfxrqp9DL189bsc/ZhDdyurgV2c2H2ZIpNL3re95t8TcdKIrwPCMMYLOU5nQg+RqPgkRN83GM01jlxBckReJAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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
> From: Ankit Agrawal <ankita@nvidia.com>
> Sent: 11 February 2026 03:06
> To: Ankit Agrawal <ankita@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>;
> Jason Gunthorpe <jgg@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; alex@shazbot.org; clg@redhat.com
> Cc: Aniket Agashe <aniketa@nvidia.com>; Neo Jia <cjia@nvidia.com>; Kirti
> Wankhede <kwankhede@nvidia.com>; Tarun Gupta (SW-GPU)
> <targupta@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; qemu-
> devel@nongnu.org
> Subject: [PATCH v2 2/2] hw/vfio: align mmap to power-of-2 of region size =
for
> hugepfnmap
>=20
> From: Ankit Agrawal <ankita@nvidia.com>
>=20
> On Grace-based systems such as GB200, device memory is exposed as a
> BAR but the actual mappable size is not power-of-2 aligned. The
> previous algorithm aligned each sparse mmap area based on its
> individual size using ctz64() which prevented efficient huge page
> usage by the kernel.
>=20
> Adjust VFIO region mapping alignment to use the next power-of-2 of
> the total region size and place the sparse subregions at their
> appropriate offset. This provides better opportunities to get huge
> alignment allowing the kernel to use larger page sizes for the VMA.
>=20
> This enables the use of PMD-level huge pages which can significantly
> improve memory access performance and reduce TLB pressure for large
> device memory regions.
>=20
> With this change:
> - Create a single aligned base mapping for the entire region
> - Change Alignment to be based on pow2ceil(region->size), capped at 1GiB
> - Unmap gaps between sparse regions
> - Use MAP_FIXED to overlay sparse mmap areas at their offsets
>=20
> Example VMA for device memory of size 0x2F00F00000 on GB200:
>=20
> Before (misaligned, no hugepfnmap):
> ff88ff000000-ffb7fff00000 rw-s 400000000000 00:06 727
> /dev/vfio/devices/vfio1
>=20
> After (aligned to 1GiB boundary, hugepfnmap enabled):
> ff8ac0000000-ffb9c0f00000 rw-s 400000000000 00:06 727
> /dev/vfio/devices/vfio1
>=20
> Requires sparse regions to be sorted by offset (done in previous
> patch) to correctly identify and handle gaps.
>=20
> cc: Alex Williamson <alex@shazbot.org>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>

LGTM:
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer
> ---
>  hw/vfio/region.c | 81 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 54 insertions(+), 27 deletions(-)
>=20
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 177494c379..3f2d72dbc5 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -341,8 +341,11 @@ static bool vfio_region_create_dma_buf(VFIORegion
> *region, Error **errp)
>=20
>  int vfio_region_mmap(VFIORegion *region)
>  {
> -    int i, ret, prot =3D 0;
> +    void *map_base, *map_align;
>      Error *local_err =3D NULL;
> +    int i, ret, prot =3D 0;
> +    off_t map_offset =3D 0;
> +    size_t align;
>      char *name;
>      int fd;
>=20
> @@ -353,41 +356,56 @@ int vfio_region_mmap(VFIORegion *region)
>      prot |=3D region->flags & VFIO_REGION_INFO_FLAG_READ ? PROT_READ : 0=
;
>      prot |=3D region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE :
> 0;
>=20
> -    for (i =3D 0; i < region->nr_mmaps; i++) {
> -        size_t align =3D MIN(1ULL << ctz64(region->mmaps[i].size), 1 * G=
iB);
> -        void *map_base, *map_align;
> +    /*
> +     * Align the mmap for more efficient mapping in the kernel. Ideally
> +     * we'd know the PMD and PUD mapping sizes to use as discrete
> alignment
> +     * intervals, but we don't. As of Linux v6.19, the largest PUD size
> +     * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is
> only set
> +     * on x86_64).
> +     *
> +     * Align by power-of-two of the size of the entire region - capped
> +     * by 1G - and place the sparse subregions at their appropriate offs=
et.
> +     * This will get maximum alignment.
> +     *
> +     * NB. qemu_memalign() and friends actually allocate memory, whereas
> +     * the region size here can exceed host memory, therefore we manuall=
y
> +     * create an oversized anonymous mapping and clean it up for alignme=
nt.
> +     */
>=20
> -        /*
> -         * Align the mmap for more efficient mapping in the kernel.  Ide=
ally
> -         * we'd know the PMD and PUD mapping sizes to use as discrete
> alignment
> -         * intervals, but we don't.  As of Linux v6.12, the largest PUD =
size
> -         * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is
> only set
> -         * on x86_64).  Align by power-of-two size, capped at 1GiB.
> -         *
> -         * NB. qemu_memalign() and friends actually allocate memory, whe=
reas
> -         * the region size here can exceed host memory, therefore we man=
ually
> -         * create an oversized anonymous mapping and clean it up for
> alignment.
> -         */
> -        map_base =3D mmap(0, region->mmaps[i].size + align, PROT_NONE,
> -                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -        if (map_base =3D=3D MAP_FAILED) {
> -            ret =3D -errno;
> -            goto no_mmap;
> -        }
> +    align =3D MIN(pow2ceil(region->size), 1 * GiB);
>=20
> -        fd =3D vfio_device_get_region_fd(region->vbasedev, region->nr);
> +    map_base =3D mmap(0, region->size + align, PROT_NONE,
> +                    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    if (map_base =3D=3D MAP_FAILED) {
> +        ret =3D -errno;
> +        trace_vfio_region_mmap_fault(memory_region_name(region->mem), -
> 1,
> +                                     region->fd_offset,
> +                                     region->fd_offset + region->size - =
1, ret);
> +        return ret;
> +    }
> +
> +    fd =3D vfio_device_get_region_fd(region->vbasedev, region->nr);
>=20
> -        map_align =3D (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)a=
lign);
> -        munmap(map_base, map_align - map_base);
> -        munmap(map_align + region->mmaps[i].size,
> -               align - (map_align - map_base));
> +    map_align =3D (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align=
);
> +    munmap(map_base, map_align - map_base);
> +    munmap(map_align + region->size,
> +           align - (map_align - map_base));
>=20
> -        region->mmaps[i].mmap =3D mmap(map_align, region->mmaps[i].size,
> prot,
> +    for (i =3D 0; i < region->nr_mmaps; i++) {
> +        munmap(map_align + map_offset, region->mmaps[i].offset -
> map_offset);
> +        region->mmaps[i].mmap =3D mmap(map_align + region->mmaps[i].offs=
et,
> +                                     region->mmaps[i].size, prot,
>                                       MAP_SHARED | MAP_FIXED, fd,
>                                       region->fd_offset +
>                                       region->mmaps[i].offset);
>          if (region->mmaps[i].mmap =3D=3D MAP_FAILED) {
>              ret =3D -errno;
> +            /*
> +             * Only unmap the rest of the region. Any mmaps that were su=
ccessful
> +             * will be unmapped in no_mmap.
> +             */
> +            munmap(map_align + region->mmaps[i].offset,
> +                   region->size - region->mmaps[i].offset);
>              goto no_mmap;
>          }
>=20
> @@ -405,6 +423,15 @@ int vfio_region_mmap(VFIORegion *region)
>                                 region->mmaps[i].offset,
>                                 region->mmaps[i].offset +
>                                 region->mmaps[i].size - 1);
> +
> +        map_offset =3D region->mmaps[i].offset + region->mmaps[i].size;
> +    }
> +
> +    /*
> +     * Unmap the rest of the region not covered by sparse mmap.
> +     */
> +    if (map_offset < region->size) {
> +        munmap(map_align + map_offset, region->size - map_offset);
>      }
>=20
>      if (!vfio_region_create_dma_buf(region, &local_err)) {
> --
> 2.34.1


