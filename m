Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECD3F01804
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPbD-0005NE-2l; Fri, 06 Mar 2026 02:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1vyPbB-0005MV-0b
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:27:49 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1vyPb8-0001d1-Oh
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1772782066; x=1804318066;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3KrbwMGCtVWu+tDb9RcFqGrsygd91YRWOn3OGhmSG60=;
 b=mUCHJSX9fNSHQOQfi5m2tn6+fQC+vhXma+JF1hjkZz9J2qTtGV+0byUD
 6719lTO/VvvFnuuHkC4T6rtNbq7YfKZwRy0Jmbk/+vk5faS3g9oW7IVIT
 a4oW+nQCg5C1gNMb1pduBiSqv5mhNNtAn+Hvs0NDxGT3YY4MJ1s2Y1dTd
 /IFEVKv77GomypOiVo2iyX9sZ4zYObNBUad1Gs2PWkcp6+1jmCXK07a+N
 D7TYdJ4lZHhjUBnWsySEFQOW0mKMqzfrDWIMOKhfU3AT4oQmmcXHF+DLr
 HWYvSpEBu2Qd82F5kt1dzXTs6tfeSajMIRM370pM8sVnBHFoloE4CKbP0 w==;
X-CSE-ConnectionGUID: hHMSIMgkQS2QAhDom+LejA==
X-CSE-MsgGUID: JN6q1f8LTlmGkvQ/GAoVWA==
IronPort-SDR: 69aa81ed_f1HfX1J8+gdn52/tlTxjQvlJBlY/RzNSdOvpqaXg8axa4gb
 a0ruM/VdDUQn9sJM+uNZMLaFN5MrjwkWVqJqacw==
X-IronPort-AV: E=Sophos;i="6.23,104,1770591600"; d="scan'208";a="46854450"
X-MGA-submission: =?us-ascii?q?MDFMLLjxBIoGr50TzwNVTvcu+/Pt1Kvtxy9lq1?=
 =?us-ascii?q?XxYOaR6ZfpFeXTIh8BzixdKEv2POqKk7JaXVxeZRuM6UpDlcEjUqqgOD?=
 =?us-ascii?q?aIPOF4b2G44NyUqXu7/8X+kgMih6qw+vOpFwNwj0sSIXp9yv/hAR2p1G?=
 =?us-ascii?q?wbmfsDLfXi+v7US59/+EMWpg=3D=3D?=
Received: from mail-westeuropeazon11011068.outbound.protection.outlook.com
 (HELO AS8PR04CU009.outbound.protection.outlook.com) ([52.101.70.68])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 06 Mar 2026 08:27:40 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLG2TndEJlKvpdB0F5mHdPCp30wQ57Dbe95Z8odyikQErhRK5RC0qRWw+KglG2JPaYgfGwrXJekWeoEiZg8SJail0jaeoXd7ndi5frweEFSnSshcXzuFwgaS5apLX18MAsVroPmPawXiYhElMU6J7JISm0LzrVqm+UvFr27dpPaTEsFnxZJi9f3AFIRzuKjSTeeBiLaR9tihNAVdUwJ6jDnJssxWsgweTzzNOCQ1JWlDg0LRlv88K0AkY32ilP7fOVhXEAqBHgIxK0Nh8cT8eSw9PmRZGN1DutX+ydOvsTFVCW8DmbV6DYcuPI2pAzbSdOBzvkMPXPDf0YWm2FXdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KrbwMGCtVWu+tDb9RcFqGrsygd91YRWOn3OGhmSG60=;
 b=CrZHdzxJaXjD3ZYn3D+KLL5it1Yi0bGOUz2OlLTHaGLR6+2L3V7nzQtfL0Y6I4dktGL5YYNISSX/YGmRqwJCw8oO2RWuJYkxnFPSb7pDWOw3UaAvVvsy1kGIeb/dNiw73WF78BOrwDzaJZOGAmjhFHJekzXGqdgH8q2GfczHjmgk1L/a5WmBn6PypsnBTDZMmG7gjtrVkwKioO+ILdJ916T8ryDDtjCVTRNOv7vRydPtKzgnl+DN/3TfZQfXhiX0gLiDB5m4y+BHYLjkSGTHCFqIiKWkPVJzCniWcZcm3pokxQr4/QvJYXRRxWnzPzX9MuuK6u/dH2B8xrtPwuwnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB7277.eurprd07.prod.outlook.com (2603:10a6:102:fa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 07:27:37 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 07:27:37 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [PATCH v1 04/13] intel_iommu: Create the nested hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Topic: [PATCH v1 04/13] intel_iommu: Create the nested hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Index: AQHcrRuPZugwfWRSCE6OGf1QpOTthLWhGxIA
Date: Fri, 6 Mar 2026 07:27:37 +0000
Message-ID: <4897796add7a661a156a3e816dda3eb9033a28f8.camel@eviden.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-5-zhenzhong.duan@intel.com>
In-Reply-To: <20260306034409.184873-5-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB7277:EE_
x-ms-office365-filtering-correlation-id: 1980ab75-4116-442d-e060-08de7b51d7ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: lvYe7s8njc+rGdtQHVa1OAq49CwSMgTQ001eebPq3cGZFmufCgaPs7Wh/OxKbHVbjYPqQ+Y3ZIqXLSFax3J8hhuNtsk8YZ4164VJfrVr8nnUwzOfl2qvV11kdU3z60xdmVQDmPLX+K4HgQ+uXurcY/vyRo7oqciVClL6B09IyTHPNAU8huTk1/YBKQvHmUgQejlUCSZp3WQLDaXEWsSt2jhwbVccdk+8GnmlKsbLG2imLuEaRhnN30PiSonNq1BaRTyw7KcSes4lEPM6vz/DxZY/G8Kc8cYw/UbNLcUvMFtjlc7n/4A+wbQzthIPPr4z57hw+g4NuIs8LoHzkw09g0k8Sn3OIw6xKsPVBTRwTVMoniZJ/oekDnKhFjR5BGCTh8577G0cuXLi1GUozQHMkASzsXnMou2VJoh1YNMG6VtVCzFR5UMUrhmCVEbUodY5lOXLu70eLZtz4CPwT9YD6D7AmbxstTCmdlFTFtRJdj1XbkOEgWdCDqpJk+eTX0rzQc+KDTCf+VFXzupA+1X+7AcptmEw/0DYPhnCLGBoC+c5MF9TM4pI9yKGpSkkTpIcESNTS7tLJdnmK/E9FIK9n7oup0onXzcQijenpICZd68Pdr15NEAKPJkX+5cTcFQ+mDFjtxn8cbmFPxv4CvnDMoqU89yDoZiwKV2wOidkISbcH7IElCGFOWQxdNkxyWIW5szy4B0buX2jQyzlMAr7luxGfbhcjsHYyToC2UzclShksu3N80ULe12X+5xzeP3AvR1M3qhHonzHmNymD8c+pkMTw65x5fggHC3cYneAklI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0pYOEh5U21YdmVoQzBoTHhMWlZQOWpYMWtHeW5QWVp3dDBOWFdDRmtjemdF?=
 =?utf-8?B?Vmh1Um1YZDZ6L2xFREdqM3pVSnFOTmRVWm1SNE0vbEVSeTl6M2xVUDU5cjhz?=
 =?utf-8?B?WTZFaDE2SnA2SmM3RE1uT0Z2SnJKUklCaU0xbUhjUEdFenJFL1pxVFgwcEp4?=
 =?utf-8?B?b0dMNmE3OGtnNzNkMnJDUXRIU25Fc000QXg2Ujl1TW44QlBrdGJvKzAxUXZt?=
 =?utf-8?B?M1k2L3RDMjdFMFR3OXRrbENoOEdaSGE2eGMwTjRNSE5yeDN0UFh1VDAzNXlM?=
 =?utf-8?B?b004QjRiT05Sd0VWRWFaVGl6K1VTdXR2R3VwNWYvbGJ3L1o2UVRvQ29rVE5O?=
 =?utf-8?B?RE9QRGZTVUxKaEhrZDVMZk0yaUFZYk1Ob0luMXlPNzNkWjJDNmZIVDczcDJY?=
 =?utf-8?B?cDEvY2pwMnhHU1VwMDdITFpZWDdtRnlvaUpLYnlLMGN3L2M1NmJNZWxQRnRO?=
 =?utf-8?B?SlAwRDZVeHBGaGgvK3lDQ1duajgyZlV3RTFwV015emROeHBBTzdWclVwdjc4?=
 =?utf-8?B?alVkOUU3b1gxN2prQUR0STk0RG1KeTdIdFVvNzRLTi80a0x2Ly81Yi9qRDE1?=
 =?utf-8?B?eEdzNzF1Unk4OWpvM1FZRGs1WW9MVnJtNGhVOEQ4Wkd6TEdOQ1c5TFp2K3pm?=
 =?utf-8?B?ZlpEdFoyVVJuQ04vUHRXWStCZml5b05DSVIyY1E2RW14Sk1acXhhTDBvQW8w?=
 =?utf-8?B?NUIyY1NyYlNmRkI2RU1UeFlETnNlNWhJSlJDVWhFa2hLWURXMmVuSjFvaWNa?=
 =?utf-8?B?YzFiV1FQbkUvZVRpNFY1K3BWMFJRKyttbzhOemRNMm10RUszTWk1TnFqbFZx?=
 =?utf-8?B?K3lUNlN1TTJSR3hUQUJiU2haRU9WajNTOEdqRTRkU1NYbTF2QjBwZ2gyUi9I?=
 =?utf-8?B?cEljLy9aYU96djIvN1V4d0JQczJVcmFLeEJPVVVKSXM0REthNG5FWEx2ell6?=
 =?utf-8?B?OC9xQ0x6eHpkZzhDSCtzNXMrbzdzQ2pha2lOOWt6TC9GS05FelUyRlpicWVT?=
 =?utf-8?B?UGJDVFZVd21YVlFQeDVDYXZSZ0t3ZEdFak1zWDFxTGVDKzFHUUFjYUJnMUFx?=
 =?utf-8?B?VUpvcjZrNWxnbDVNdzJrdU95YU8yRVNuK2JOeTBwV2NMQ1lSUXZlLzZRSm9S?=
 =?utf-8?B?SjlVSFlaZUZCS0lLbmtoS1dmSXpXRzJuNUlPWHN4ak14SE1rSStySGdEVEcz?=
 =?utf-8?B?TFFScnJWK1R6Zm45K3huT0RPRVoyMkxnek9vbml5MUtURDFCOG9lOWxjTkxX?=
 =?utf-8?B?Lys5RlNRU0h4WVNmZjJJdnVIcXN5Tzg3N2NoQWYwaDJNT1BEUXlBdGxJTElw?=
 =?utf-8?B?QW9QUVVoSzcwNnBYcDAwQjhjZGVSWFVoVnc3WThzNWVZeW5DT0YwZmpWNUFx?=
 =?utf-8?B?VjZIMi93SUl6Nk5ET0JlYzNjRmZreEk4eVdOVmhERWVOMk0rdm5VUWlGSVRo?=
 =?utf-8?B?dGo5RmxYdUVSSU1RcTVIVmJDN3lXSzc0WlpBaHlFb2wrb09weHN5dzhMdWxq?=
 =?utf-8?B?cjZocW9kaDdOS2FUekUyTGRsRk5vQ0tpUDk5MWhsNzRQckU1NmJGRmcvWnNh?=
 =?utf-8?B?S05zTTNSUXhibU9xY3VxQVBvOFdlaFlPRWt0VzAvU2QvbWpqWWRGKzlyN3I5?=
 =?utf-8?B?MjdwVnNvSXljUWtHK2hzNWVmb3V0Mi9KQU9iZEhqcmZlYStnSHFwVWVNZS94?=
 =?utf-8?B?eTRjenZJOE5ZRkh5d1lFQllncE85TUd2TFV6Z2lHUVBxNHRZend1WTBoMUhk?=
 =?utf-8?B?cSs3OWZuN2ZYcmdBL2MwblF6d2pjZStmY0R5R3hEK0UyMTdLMU93d1pFTmhW?=
 =?utf-8?B?WjhzTXRjc1FuYU5pbGF1cUpUK3NxSStOSlhUSzdWZ1c5Z1Noem9CUjAyc2pI?=
 =?utf-8?B?UDFGV2pBQ1loR29JSDAzUDhGcU1IUnVQMTFVN1dqRXZWbXBhclA3dDhBZGUy?=
 =?utf-8?B?TklqNVY5enYzcGRLL05pM0Q0WlB5TDY2bEZWN0Q1cXlCK2dvRzJiNEE3TWUr?=
 =?utf-8?B?bDRuTGxmUkJ3Y2NUWFJEMHJ5aGNKazJCcGtUWGhhSElydDJQNllrVkI2OUVI?=
 =?utf-8?B?cU1ZdXVRMFNsM3NPdnJ4WXBQN0ZtZFc4TGNFdW90d1NrMTlhc1lYT0pHaFlO?=
 =?utf-8?B?N0Y4Tk9vZmE3WmV3WmdmM05wa203S3lIWkJzM2k0QUROczl1bnowSkp6VGpX?=
 =?utf-8?B?VGxtUDVhdWVmYVE2NUJPZGZzWHgrQktvaUVOK0p4Nitjc3cwUFpkUXZnWUww?=
 =?utf-8?B?SFR5NHpyQUlxaTJyeEgvVVRXUHNKMk1QNTBmZWcxRUVzQkJKRTNjV3VmRE9U?=
 =?utf-8?B?NlFnQXZYSjFXcUxTRW54ekFIRk9sVHFNYXRoOWErTE1vR2QxU09sM3BYZWZh?=
 =?utf-8?Q?k1y1ESOu06A2mHzg26rFSZi7cCoBMltSKh909?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC81A25443D3244EA0039C55EB1572B5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Da/pQ85QvoVEYvxVrM4eG+HWIl7A2eZ1Giqv05RZnHNyu7HmCvVeY6wG/cch8QVbSbRJgG8v/AzdSFv0pHRebARlEp9w4HYF4Jj86KvpXyH6EbN2u7y6e4xsn3CEkfucb7nnG8RDM+pexSaSCuL0WFJYE7/jRsIrAv0TBZx+SwekkGgCgytAxegr6OWfaIhWVrHidAhXyO3m2zceVS3iq4V023M+VMRyrT6cB8gQj6ykg/JvwAnvwttwo4XyL7MCx1zftP/IECuHiiKqdH+lMLxOxCIFUl3E3ynGa/j8YGNsc4w6c/LsLi8F4dMzXxCyg5k4Th67YEZhMMg1xDQ7jw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1980ab75-4116-442d-e060-08de7b51d7ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 07:27:37.8073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y78a9FPJt80PptBkSBs9Y25JRIRz9fl8jKwmBJewUvODuJ63mI7xzcfUPHdFjKOhtJdeIddNe4AXq9tEOB7xjvS6O9ygeYuYLGTwxB63t/Ewfi2IgmJyQ9TsEOWinAGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7277
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

SGkgWmhlbnpob25nCgpSZXZpZXdlZC1ieTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50
Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20+CgpPbiBUaHUsIDIwMjYtMDMtMDUgYXQgMjI6NDMgLTA1
MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOgo+IFdoZW4gcGFzaWQgaXMgZW5hYmxlZCwgYW55IGh3
cHQgYXR0YWNoZWQgdG8gbm9uLVBBU0lEIG9yIFBBU0lEIHNob3VsZCBiZSAgCj4gSU9NTVVfSFdQ
VF9BTExPQ19QQVNJRCBmbGFnZ2VkLCBvciBlbHNlIGF0dGFjaG1lbnQgZmFpbHMuCj4gCj4gQ2hh
bmdlIHZ0ZF9kZXN0cm95X29sZF9mc19od3B0KCkgdG8gcGFzcyBpbiAnVlRESG9zdElPTU1VRGV2
aWNlIConIGZvciAgCj4gbmFtaW5nIGNvbnNpc3RlbmN5Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDxbemhlbnpob25nLmR1YW5AaW50ZWwuY29tXShtYWlsdG86emhlbnpob25n
LmR1YW5AaW50ZWwuY29tKT4gIAo+IC0tLSAgCj4gwqBody9pMzg2L2ludGVsX2lvbW11X2FjY2Vs
LmMgfCAxOCArKysrKysrKysrKy0tLS0tLS0gIAo+IMKgMSBmaWxlIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxf
aW9tbXVfYWNjZWwuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyAgCj4gaW5kZXggNDVj
MDhjOGY2Zi4uYzI3NTdmM2JjZCAxMDA2NDQgIAo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVf
YWNjZWwuYyAgCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jICAKPiBAQCAtNjks
MTEgKzY5LDEzIEBAIFZUREhvc3RJT01NVURldmljZSAqdnRkX2ZpbmRfaGlvZF9pb21tdWZkKFZU
REFkZHJlc3NTcGFjZSAqYXMpICAKPiDCoMKgwqDCoCByZXR1cm4gTlVMTDsgIAo+IMKgfSAgCj4g
wqAgIAo+IC1zdGF0aWMgYm9vbCB2dGRfY3JlYXRlX2ZzX2h3cHQoSG9zdElPTU1VRGV2aWNlSU9N
TVVGRCAqaWRldiwgIAo+ICtzdGF0aWMgYm9vbCB2dGRfY3JlYXRlX2ZzX2h3cHQoVlRESG9zdElP
TU1VRGV2aWNlICp2dGRfaGlvZCwgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZURFBBU0lERW50cnkgKnBlLCB1aW50MzJf
dCAqZnNfaHdwdF9pZCwgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVycm9yICoqZXJycCkgIAo+IMKgeyAgCj4gK8KgwqDC
oCBIb3N0SU9NTVVEZXZpY2VJT01NVUZEICppZGV2ID0gSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVG
RCh2dGRfaGlvZC0+aGlvZCk7ICAKPiDCoMKgwqDCoCBzdHJ1Y3QgaW9tbXVfaHdwdF92dGRfczEg
dnRkID0ge307ICAKPiArwqDCoMKgIHVpbnQzMl90IGZsYWdzID0gdnRkX2hpb2QtPmlvbW11X3N0
YXRlLT5wYXNpZCA/IElPTU1VX0hXUFRfQUxMT0NfUEFTSUQgOiAwOyAgCj4gwqAgIAo+IMKgwqDC
oMKgIHZ0ZC5mbGFncyA9IChWVERfU01fUEFTSURfRU5UUllfU1JFKHBlKSA/IElPTU1VX1ZURF9T
MV9TUkUgOiAwKSB8ICAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoVlREX1NN
X1BBU0lEX0VOVFJZX1dQRShwZSkgPyBJT01NVV9WVERfUzFfV1BFIDogMCkgfCAgCj4gQEAgLTgy
LDEzICs4NCwxNSBAQCBzdGF0aWMgYm9vbCB2dGRfY3JlYXRlX2ZzX2h3cHQoSG9zdElPTU1VRGV2
aWNlSU9NTVVGRCAqaWRldiwgIAo+IMKgwqDCoMKgIHZ0ZC5wZ3RibF9hZGRyID0gKHVpbnQ2NF90
KXZ0ZF9wZV9nZXRfZnNwdF9iYXNlKHBlKTsgIAo+IMKgICAKPiDCoMKgwqDCoCByZXR1cm4gaW9t
bXVmZF9iYWNrZW5kX2FsbG9jX2h3cHQoaWRldi0+aW9tbXVmZCwgaWRldi0+ZGV2aWQsIGlkZXYt
Pmh3cHRfaWQsICAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCwgSU9NTVVfSFdQVF9EQVRBX1ZURF9T
MSwgc2l6ZW9mKHZ0ZCksICAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnZ0ZCwgZnNfaHdwdF9pZCwg
ZXJycCk7ICAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhZ3MsIElPTU1VX0hXUFRfREFUQV9WVERf
UzEsICAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKHZ0ZCksICZ2dGQsIGZzX2h3cHRfaWQs
IGVycnApOyAgCj4gwqB9ICAKPiDCoCAgCj4gLXN0YXRpYyB2b2lkIHZ0ZF9kZXN0cm95X29sZF9m
c19od3B0KEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXYsICAKPiArc3RhdGljIHZvaWQgdnRk
X2Rlc3Ryb3lfb2xkX2ZzX2h3cHQoVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGlvZCwgIAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcykgIAo+IMKgeyAgCj4gK8KgwqDC
oCBIb3N0SU9NTVVEZXZpY2VJT01NVUZEICppZGV2ID0gSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVG
RCh2dGRfaGlvZC0+aGlvZCk7ICAKPiArICAKPiDCoMKgwqDCoCBpZiAoIXZ0ZF9hcy0+ZnNfaHdw
dF9pZCkgeyAgCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47ICAKPiDCoMKgwqDCoCB9ICAKPiBA
QCAtMTE2LDcgKzEyMCw3IEBAIHN0YXRpYyBib29sIHZ0ZF9kZXZpY2VfYXR0YWNoX2lvbW11ZmQo
VlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGlvZCwgIAo+IMKgwqDCoMKgIH0gIAo+IMKgICAKPiDC
oMKgwqDCoCBpZiAodnRkX3BlX3BndHRfaXNfZnN0KHBlKSkgeyAgCj4gLcKgwqDCoMKgwqDCoMKg
IGlmICghdnRkX2NyZWF0ZV9mc19od3B0KGlkZXYsIHBlLCAmaHdwdF9pZCwgZXJycCkpIHsgIAo+
ICvCoMKgwqDCoMKgwqDCoCBpZiAoIXZ0ZF9jcmVhdGVfZnNfaHdwdCh2dGRfaGlvZCwgcGUsICZo
d3B0X2lkLCBlcnJwKSkgeyAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxz
ZTsgIAo+IMKgwqDCoMKgwqDCoMKgwqAgfSAgCj4gwqDCoMKgwqAgfSAgCj4gQEAgLTEyNiw3ICsx
MzAsNyBAQCBzdGF0aWMgYm9vbCB2dGRfZGV2aWNlX2F0dGFjaF9pb21tdWZkKFZUREhvc3RJT01N
VURldmljZSAqdnRkX2hpb2QsICAKPiDCoMKgwqDCoCB0cmFjZV92dGRfZGV2aWNlX2F0dGFjaF9o
d3B0KGlkZXYtPmRldmlkLCB2dGRfYXMtPnBhc2lkLCBod3B0X2lkLCByZXQpOyAgCj4gwqDCoMKg
wqAgaWYgKHJldCkgeyAgCj4gwqDCoMKgwqDCoMKgwqDCoCAvKiBEZXN0cm95IG9sZCBmc19od3B0
IGlmIGl0J3MgYSByZXBsYWNlbWVudCAqLyAgCj4gLcKgwqDCoMKgwqDCoMKgIHZ0ZF9kZXN0cm95
X29sZF9mc19od3B0KGlkZXYsIHZ0ZF9hcyk7ICAKPiArwqDCoMKgwqDCoMKgwqAgdnRkX2Rlc3Ry
b3lfb2xkX2ZzX2h3cHQodnRkX2hpb2QsIHZ0ZF9hcyk7ICAKPiDCoMKgwqDCoMKgwqDCoMKgIGlm
ICh2dGRfcGVfcGd0dF9pc19mc3QocGUpKSB7ICAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dnRkX2FzLT5mc19od3B0X2lkID0gaHdwdF9pZDsgIAo+IMKgwqDCoMKgwqDCoMKgwqAgfSAgCj4g
QEAgLTE2MSw3ICsxNjUsNyBAQCBzdGF0aWMgYm9vbCB2dGRfZGV2aWNlX2RldGFjaF9pb21tdWZk
KFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2QsICAKPiDCoMKgwqDCoCB9ICAKPiDCoCAgCj4g
wqDCoMKgwqAgaWYgKHJldCkgeyAgCj4gLcKgwqDCoMKgwqDCoMKgIHZ0ZF9kZXN0cm95X29sZF9m
c19od3B0KGlkZXYsIHZ0ZF9hcyk7ICAKPiArwqDCoMKgwqDCoMKgwqAgdnRkX2Rlc3Ryb3lfb2xk
X2ZzX2h3cHQodnRkX2hpb2QsIHZ0ZF9hcyk7ICAKPiDCoMKgwqDCoCB9ICAKPiDCoCAgCj4gwqDC
oMKgwqAgcmV0dXJuIHJldDsK

