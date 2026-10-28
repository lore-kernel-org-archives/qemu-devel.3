Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D06606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bull.com header.i=@bull.com header.a=rsa-sha256 header.s=mail header.b=pnV82hNh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4uz-0005Uo-3a; Wed, 28 Oct 2026 10:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xM4uv-0005Tk-U8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:46:18 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xM4ut-0005vc-RI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1793198775; x=1824734775;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FhfddoL2Whjvpkc+yn1rV8umHGeSgCdmEMw9lGxR06A=;
 b=pnV82hNhIIbXOqSOy/lE1vfx0sIOGzhUhlMuvcUXiz81yQIWdhfV+/v2
 KnurSXfdh2L7znUupnLRnD+6O/RtgzrYfkDqQvNwVd8buu7eFf4KWh5i0
 B7M/+szkzTKBttzf6McksIiX2QCGiOdCNvlw9vTMK6OfAXtwNAXKt1L0k
 lXfT26RFguIPYu3+guwvb46BH+jZjhunVb6lQHKD//09K/Rty5TF4ZYBP
 e1S4wJL/JZeoTnWvhtKpraPO528Ey23TSnRPjOibbB9w+zr+TBvbuIQjJ
 S+zqgKeB6EDoD6KQKKPz7N6HcFb8W3rOzBr/I7GLJ0FdY8tAWg1qX1M4a A==;
X-CSE-ConnectionGUID: 9LlPXVniTuK+q8ksg7Yfrg==
X-CSE-MsgGUID: VkBWFGhfT6Ox5BMxpMQLeQ==
IronPort-SDR: 6ae20ab3_SiUPqCq3olDD/jX3kM76izof1u93nfj1uqsk4LY5FmCJDba
 wAEsqGy3YecirMlY+M6acZKXrwcl3WXd7bcy3aQ==
X-IronPort-AV: E=Sophos;i="6.27,182,1787004000"; d="scan'208";a="49049394"
X-MGA-submission: =?us-ascii?q?MDEgiuglTQJtFObP2hDr1uu6O8VI1MHKQ2f6HO?=
 =?us-ascii?q?IQEub6r+++4eoLBAkOQAYT15F8mGBpNrgZuFM2CDbVlRzdNfyAFxsdho?=
 =?us-ascii?q?TjPPbn5xYX0kCc7SgOiKobm7aPw8z288TNPiNzGL0uhQgjC+u11H6p6v?=
 =?us-ascii?q?4EQw0dLeMsjnVX8A3+qF8Cxw=3D=3D?=
Received: from mail-northeuropeazon11012044.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.44])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Oct 2026 15:46:11 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feHNCuYiTW8iHtDsv13HWB/kXBrB0/qFq3DlkFVUvQQisdvhuhoypIBNu3b/NJjv27YoA8hSnbt+Fypas/f8mhri+p4nlqIep2KQzKRmwcRMtWRmWo7J09j18qnAy1XeuwteAGJcjdvDTuCYklHL8bO3/GoaMYQqEQ3ia0PzqvxNAv+0DMfIfYQoJGKFXqBypKn9yEMKHVJQupvMJzv9Pb88S3x2+22LRJHTldUfImHwhhG+vCwGIYHYap1lPgYExJKYN6gNrl4FMohpfArsCx5/YmDvCqOscZ6tSp/2Oz64CjNyr93h1Pjzg+wBcTuBnPULZrWN/n8xSF61mOD7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhfddoL2Whjvpkc+yn1rV8umHGeSgCdmEMw9lGxR06A=;
 b=FRhPnut1MsiYoGn3hlhdrHapFbmHb2cXu5GORnyOARpC3vEj5Kg5UPUX6+7XtJ+401aHX0gwfyrRvG3Jy5/P2zOtA2V6z3OBghARx/bXAYzeV3Kiy5/XMTd3gD3Y3YHuT9KWObh5IYl3zWshOMfZ798oRdyWkYHFevBwqNUzJc/x5a9t2TIvQJ48q8hd+5h+fWOVmk2msXQiJsWavNq8O0KKTB44x5XzOmEb7CVRK2l4gqcmT2kY3Z1QplkOl5mH1XqBGMXjfkWcI+lMyaV+VXE2xo20y5XJqxbK8E95kF7tvehGLLST883pKpXZc7IStUvuAanikZszG5fpF70B0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8681.eurprd07.prod.outlook.com (2603:10a6:20b:4cf::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:46:09 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:46:09 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "odaki@rsg.ci.i.u-tokyo.ac.jp" <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "mst@redhat.com" <mst@redhat.com>,
 =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?= <clement.mathieu--drif@bull.com>
Subject: [PATCH 2/2] pcie_sriov: Adapt bar type array size to the number of
 regions
Thread-Topic: [PATCH 2/2] pcie_sriov: Adapt bar type array size to the number
 of regions
Thread-Index: AQHdZusSvRBfyfRBi0yfueD2fVv9gA==
Date: Wed, 28 Oct 2026 14:46:09 +0000
Message-ID: <20261028144539.691098-2-clement.mathieu--drif@bull.com>
References: <20261028144539.691098-1-clement.mathieu--drif@bull.com>
In-Reply-To: <20261028144539.691098-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8681:EE_
x-ms-office365-filtering-correlation-id: 048c07f2-fd69-4dc6-5006-08df35023498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|38070700021|11063799006|56012099006|261021123027099003|261009223027099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: F2lpOXgnTNLqLsr51BltlWUEoriJYhM+hKbRYWAAgmxnODb4iKXKkuj3dsRx00qaBTXe70Vlno7zBE+4pUjNQ9cAh9jrFmgyMqQNlJYGNItZ4yHxL6sgaVf3SrKRTe0PX+EkPjfv88V8XeU6n9GSicR7WcJbpaEOeSDhpaVWGV+zeDGmhh87ShK26onaG6KQbtXn7cqHyAy294QsO2fhE7LH6OStgkRQcrxbpDMIrOrwRqVTq52mg8BGuzpzv0rmCTDQCPpRRvSsrIFX9Fu3Fam/Q4OS6WYvfsFj+5K4obMHJOQVDFqxYwyH/au1eOod6Vz264gJkD9lhcHuuxvBl3m7uDlfs2WcRD1GZYNAYWcWNDkpL72yYMy4Q8/v7Q/WCr9iFwdqL4rd5CfmQ6hn5nA0lsJ3RXUqLsep1GZ4+FZ8XHT2DOZQLK+zpW1iIcEIXSP//azFB4MfYkagRlA51TtpnkTCTcnbveRrztfOQNaTBjrwjMosDsXLu46UpZ/PruEx8jNRbn3vb5BCjAKS9bVQcY8YpblbBE2QNHd338HYR/ixx/Ywt6JEJZ+c/+jWIEUYgoyc4Pg+JVt39jhYMi3fSGO0h+oa60Jm4OQE6kJaF6QD/lAyj3a/nW2qz1L8QTi5yv4k0kiJSMdkgSJ0oeOkXdruldsE6GHXjzoz+1CnEveFEDc0qV9WlxUXIhCzF2IfxCSn2/Rf2f25pL2q6K9TD/1ZBuq/bO8v9eHC/XQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHppbDQ5Z3d3NW0rSkVRZ2c2Wnp0K3VXL2ZVNWN6RWhERmNWS0FMUlJyRkFm?=
 =?utf-8?B?Rm1ycFNydXFCaGZydUVHeDZWWW45NXBjUFh0bE42M285eVlwdytVS2ZGdWRt?=
 =?utf-8?B?dWxEcDJrMzYwMjRwWi9Md09kaDVWTmhRU2dXYnVNbUxtekMvbjQ1NFJoamFi?=
 =?utf-8?B?TzNKWEdHZ21LWkVpV00vZkVWeW1mcUt6dmFYVjlFNXFZUlRoMkhmQnN3SGk0?=
 =?utf-8?B?L083Y1ozYWlEUVo2UEoxQVl2VG43U1dSWS9JYzV5TnU4M1VWcVQwRmJ4QnVq?=
 =?utf-8?B?bTUxSHllTDEweG1nTGc0eUZkOVFhNDhtSUw1V0FZZ1ZueFQxT0ttbWpoV1c4?=
 =?utf-8?B?OGQ2TWZIRzFRYnRxVi9OSjd4R0V4cjBEZ29UYStkeCtUendLTGVPenpYSHFq?=
 =?utf-8?B?cWhnWDM5MmVkSVZOOVlsS0tPdWxUQ3FxMFY3M1JkOFVrSjFvc0xsK1hCUDhw?=
 =?utf-8?B?UlJqRzZYZkJSYmgrZTRUZis5M3F1VGcvd0dpUW93VnJQWTBQUDh6aUNTWWk0?=
 =?utf-8?B?M3N5enY1U3FpaDY1UFJsQWFWdXUvMnA5emdMTEFoMEcybUU4M1F3YzRjR2RV?=
 =?utf-8?B?RXFrbER3T1pwMnlnVm1McEkwQXNVZHNNWmJURjRVcCtUbzVDZDdBcTFuVE51?=
 =?utf-8?B?L0pHUG5ua2NhUm81OVRYUkdTa3poT2pGNzUzMmhkOXo2V1VWV1k3UDhLb2R4?=
 =?utf-8?B?amNLNXovMHlDcXVoUENSRW5WOTl2VVBld0tIai9MQmZHSEZta3pYUUtOMmVN?=
 =?utf-8?B?U0dSZ0cxR1E4VFFZNUxTYmgxcUJJNGFsWS9YbTZnZzhLekpwdVFabFpnMGVB?=
 =?utf-8?B?ZDFpdnhEOUE4RWZ6RGtxTTU4RnhhVktIOFBIa2RaTGZpalJtK0ZLdlpMSEdm?=
 =?utf-8?B?THh5REdsbkhEcXlMSDAyS0tJWW5IdW44Y1A5NTI1VVgwZHVjM1pMUUJ0SWxq?=
 =?utf-8?B?ZUcxSDl4SEp3ajhTNk1sTERxbWJMY240UHdlY3VnSXFFcHJrdGFVOVhzNnFS?=
 =?utf-8?B?eDEwQm1UTlF6RDRrZkZOWEZTUHdkUGEwbkpoSGRud2FQR0lXRlNLdnRmdmxX?=
 =?utf-8?B?VHFEU3RJNEZHcFo5NjE3OWlGSHNyTnRUekZNSkhRQkUxNHc1VUZtaFRHTTJJ?=
 =?utf-8?B?bVh2N2Ewc2tTQWxwVVFUYTNOM0tPSUdjZzZtaFhxQW5GRU5yN1NDRVF6bUxY?=
 =?utf-8?B?cDVmVDBlb2wycXVEM3dmd2ZvVDBPdnROWmtEZi9mZmpPdkVDZTg1YWJCMFRa?=
 =?utf-8?B?ZnpFRjJJWThVenEwNEtQYW9qMGZDRVZKTVZ1Y0FGUFZkaDlQNEhGY0RacFpD?=
 =?utf-8?B?Uk9QSWtqN1BNUTBOamxndDExSnE5a3E0d29VUXduQkpQdUl2a0tLbnJsZHU2?=
 =?utf-8?B?UGd1TktSRjhNWUpiTFdjYS8vQ2FadStzcHNnZTBaMHg2cUFhVlpzT1IvUEhS?=
 =?utf-8?B?c21RNGdhMmFLdkwxdnI3aG1tTnk1NVN2STlWNGd2MVpyMUxXU2Y0S1QyOXc1?=
 =?utf-8?B?TW1adGQ3QmNvLzd5RURxeTFQWlZ3cmJxemMrN0t2QytCZUlHeEY4d2NMVmdI?=
 =?utf-8?B?bWVmSXJnblVYeFVXYWlaUytoRXZRU1pzcklQS09YcXc1bCt0NkIyU0twVDhh?=
 =?utf-8?B?TmNmWVhuSmtoc20rYXNMQ2wrSEllSEFnditneVpNdWdmS1I1cm4ybWtRQmtI?=
 =?utf-8?B?ME0zTlFKWjh5OCtOMCtQeVdtRUpMY20wZWlMTHRHNXdQYUF0RkpucWtxNC8z?=
 =?utf-8?B?d2phd0NwbTFYN1lsUU96bUlaVHNEbkxIZWFOSUhZTVZrQkpVcGJOYWZxTU8w?=
 =?utf-8?B?cFEzK3FjNGZ6ZEgzNndjK25kbTNIVjREZGtIbDNYZmlDL2lqbTJmYnFOQTc4?=
 =?utf-8?B?WmV3ajlIM0FwSEFIYWx3R3ZVQmVmZGFWOTAxMCtlcVVsYzAyelBXRkJJS2hF?=
 =?utf-8?B?ZjRjVHo3dWZST3Fib3h4cFJubVhRb0ZEMXpaWEw2Z3ZKNnZHUkI1Y3JkNmd1?=
 =?utf-8?B?eDNSUDRJRXNybWNSTjdrWWdLU1pYdHVLR1ZIdjlFUmRRNHA1VHVmQ1BVVjlS?=
 =?utf-8?B?bGJ4UWo5Y0Nzdm1TSEM3cHdENklxY1gvTjJGZ01UaTByVXRVRnZZOGpvNDRP?=
 =?utf-8?B?UEVIOGwxbm5lbHlIelhXRE9HWkRGeVlEMUNzUThiME56Tnp5UDBmYmN6Y2Nl?=
 =?utf-8?B?dWNmVkpBaks4SnVKOE1oalVhVWF1S1J5azFuTlBhQUJtTmJzUXdoU1RSRUp3?=
 =?utf-8?B?RCtHQnJkMEhtVVowMURKNTZXOEFpMTBCY2RCZmh2VThSVWpLVTFIM2ZTYXVp?=
 =?utf-8?B?YVV6R2NkWm04MFNsN1ZzWFNzdkVuczFHSmlQdFFMOFBIODNRZ3IrdytUdito?=
 =?utf-8?Q?ac22nj58aDgpq7uI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vnmfWn0Pc7wAk37QYNpQW1w/rDJ3IoW2i7v491HMsCfuTx5573m5Z5YbAsYSooaEFNDCYZ+Fk+x+C+OngmeFRwf8vYGJ4mF7S+ZFJd+RPIfgxWEysb19uDgnLmU58hdKcZEHCHElXl8aX0JeoxmmUSAyInW/KwyUU55HtWc+JIGdatbzBds23Sh3OWytLkafBFc/JGS+fPjx9wDyJj7SXYsWuLqP1StuWoRd3edeIxYvxmakyliauL9v18OLzR+xyF7dn2Jy02msdk20hRgd+H8MJUmRBkwho3o5+fqD/IvBCHHBe4gLon8gLpP0nlDZifYxTuqGLS6Xlg0591PpSw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048c07f2-fd69-4dc6-5006-08df35023498
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 14:46:09.8073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdSyokT77SFAL06NO3gYwPKeStbNsI7mxz6T3KPzflunfMg+nWSab7VCMcAvhIXiBYXd0jk43JFjygKwJohNMbQCMnt120a+8jeM9aIEX1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8681
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U2lnbmVkLW9mZi1ieTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRy
aWZAYnVsbC5jb20+DQotLS0NCiBpbmNsdWRlL2h3L3BjaS9wY2llX3NyaW92LmggfCAyICstDQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L3BjaS9wY2llX3NyaW92LmggYi9pbmNsdWRlL2h3L3BjaS9wY2llX3Ny
aW92LmgNCmluZGV4IGIwZWE2YTYyYzcuLjVmODFlM2IxYmIgMTAwNjQ0DQotLS0gYS9pbmNsdWRl
L2h3L3BjaS9wY2llX3NyaW92LmgNCisrKyBiL2luY2x1ZGUvaHcvcGNpL3BjaWVfc3Jpb3YuaA0K
QEAgLTE2LDcgKzE2LDcgQEANCiAjaW5jbHVkZSAiaHcvcGNpL3BjaS5oIg0KIA0KIHR5cGVkZWYg
c3RydWN0IFBDSUVTcmlvdlBGIHsNCi0gICAgdWludDhfdCB2Zl9iYXJfdHlwZVtQQ0lfTlVNX1JF
R0lPTlNdOyAgIC8qIFN0b3JlIHR5cGUgZm9yIGVhY2ggVkYgYmFyICovDQorICAgIHVpbnQ4X3Qg
dmZfYmFyX3R5cGVbUENJX1NSSU9WX05VTV9CQVJTXTsgICAvKiBTdG9yZSB0eXBlIGZvciBlYWNo
IFZGIGJhciAqLw0KICAgICBQQ0lEZXZpY2UgKip2ZjsgICAgIC8qIFBvaW50ZXIgdG8gYW4gYXJy
YXkgb2YgbnVtX3ZmcyBWRiBkZXZpY2VzICovDQogICAgIGJvb2wgdmZfdXNlcl9jcmVhdGVkOyAv
KiBJZiBWRnMgYXJlIGNyZWF0ZWQgYnkgdXNlciAqLw0KIH0gUENJRVNyaW92UEY7DQotLSANCjIu
NTYuMA0K

