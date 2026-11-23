Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F8606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ViTFPtPI;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=i1WM401e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVOSf-0007dr-3k; Mon, 23 Nov 2026 02:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xVOSL-0007dV-J6; Mon, 23 Nov 2026 02:27:18 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xVOSI-0008Vo-L3; Mon, 23 Nov 2026 02:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795418835; x=1826954835;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K3ygJ1+Or2swy0zlGTvXRNJprE5/8SwDPxZeBF+khyg=;
 b=ViTFPtPIH8vRMfkUNw3DXpCTSh1gfGJugtG3prD/zvN3XNDo668DPqhf
 U+ZbMX7rTWd3QyLFRtqmQio4oVzzJqQRZWkjZlWLYJgaRDJuZ9KNe38Zl
 QzhTcl1sfneS6VC3K0h6tffgxL/vyIBzUMwKCxwHLSMHrnyLprOWSYIVi
 bSHWBOjHCOn20Rfnvm8YBwhwqi460G92wemFfIR3CfGXHHU1KA72dOt8H
 g4IPTRFhrrgmgA0bqrXGcqLL4u0uAFm8HZAf70ESbFI1qORmsQtVS9EGw
 V3JucOj82SlZE9RhY0ihuQdMdumV+SsLG/+FRk6UtVb5MruAScdZAaC13 w==;
X-CSE-ConnectionGUID: mXNs0GOvSk6QROd+Hdn2ww==
X-CSE-MsgGUID: IsGwZz3zRvCwSQKRNsfZQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4113807"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4113807"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:27:10 -0800
X-CSE-ConnectionGUID: YkIhrf/ATAWC5eva/hnFYQ==
X-CSE-MsgGUID: FMOFTbUwSf+TySYaOez6eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11213141"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:27:11 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Sun, 22 Nov 2026 23:27:10 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Sun, 22 Nov 2026 23:27:09 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.25)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 23:27:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGQTJopyPhs+yQ/PPPs2g1bJ/gm/t5YG4HC+GnBKKpK1aP3rWtM2VD97+2SSuotBtBhJssLHQgtg0WpWvP5oPKLKcqJDdYsycK+UfScuUkaOPzIW1/0NRxGZbf+cJOVi7e7Tid5nM3DGkdgiVCTtn2aH406viB+RBcIoGDsAEBSaaFLC79lErP+g69UWdZGSzOXjVBsPjU4zc4fKlba0XnCxe8pBGAjQoTu/X91RpDo+DKLZMn13AHvJ7A4AzZsJpjYRJFEvyhZn31b36yhFc9frjxsQKQLk9UzwQjjiD8+ZL/L6OENtJgbQSzeVgVNFcTqpv7oAFv/4Ws/FCaKT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfklC5guoutCcrKgbrBZsos1+oO3vaQ412cCmNVYxvM=;
 b=eyAKZJpT8pRwThQlqyoyPSCmjCR/La33F3+HqNTYk3mrqMeX3pRyIBVZZqDgAfiBnqVA3aR01lJsfy+1HsR1nFAU90OzzDsbhMZJXoW496+FQfSjJOPoXYTnerhKr/+SZzU+cbzTpkeTzEqWuizcoYSu8HUJ6Q5ftlQcJ+ah4MEV1LmrgPa1rsHsDPfE+OkDLP18QJoIhgTpUxYFrGCrS4FMsKdGXBADzWFkD/vMH5/xV0QL61KQihWk4RSzl/jHodwB0B6wp9fm5Y9SU0zoXZeX0AtCviLnDYzfognyGD48IP4wmRYufta46WlNqxpE3Z/dufNwii/iWgXn9MB9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfklC5guoutCcrKgbrBZsos1+oO3vaQ412cCmNVYxvM=;
 b=i1WM401e8LB0VD3ShvQMOazx0d9l8iN0HTbPTNf50sPtaApZpCVdvONqWRoWE6b2WCaPNTgzwLG94pXRO9XMaUkwCV1EaXglnG3MgAFq04XAH9h+yZY4SJ5pl7deII67hxuxykQcoaroiG7uhkhyA/Zvb+8PGFWEnXLjSGgSPAQ=
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by LV1PR11MB183931.namprd11.prod.outlook.com (2603:10b6:408:50b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 07:27:06 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 07:27:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Farman <farman@linux.ibm.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric
 Auger <eric.auger@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-s390x@nongnu.org"
 <qemu-s390x@nongnu.org>, Matthew Rosato <mjrosato@linux.ibm.com>, "Omar
 Elghoul" <oelghoul@linux.ibm.com>
Subject: RE: [PATCH for 11.2] backends/iommufd: Delete FD during backend
 cleanup
Thread-Topic: [PATCH for 11.2] backends/iommufd: Delete FD during backend
 cleanup
Thread-Index: AQHdc4FS3GORE9hAHUCANvwycSy43Lc1aRyAgAWiYeCAAER6QA==
Date: Mon, 23 Nov 2026 07:27:06 +0000
Message-ID: <IA3PR11MB91369A336DD62E830F0B7FF592452@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20261113134335.2451039-1-farman@linux.ibm.com>
 <65204740-1995-4a14-b803-35dad498af97@linux.ibm.com>
 <IA3PR11MB91367BB9464D88D270CCFC2492452@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB91367BB9464D88D270CCFC2492452@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|LV1PR11MB183931:EE_
x-ms-office365-filtering-correlation-id: 0c26f0e8-69d6-47da-f1a7-08df49332d52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|4143699003|11063799006|56012099006|260925022911599003|260925021911599003|260925021311599003|261021121427099003|261021123027099003|261021135927099003|261022075727099003|261009223027099003|261102123227099003|22082099003|18002099003|6133799003|13003099007;
x-microsoft-antispam-message-info: I+kqTrjh7MrTLqCuG4SpcoPxP6pPFaTwFEmt1Nh51fKtEOb8azOv8osK9hU4H3VgkPuQnwBnCDubZTD1C8b18V4CmTA6r+8DvbbN3Ale6E19tTwmrBST35FNzrxWXo2ruOVBx+e/dyeaMyI6rk7xvSZ703dOcYP5TqCgGZ6+aNq1k4+B0TTPWRRuAAC+Us+NQ3f3dSxGuR/gLIjGYEXIN5VK0KoqtZna0JY+pnKA3kr2WDFJZ458lWJmvjsIL+IwC0yMbjQMr0yZPkqgakBiodGrNrpbvUZPqMi0bSmOO+C0uCPK/vP2ApNVz85xll7n/Z1oi0mpU01+8BL9OmAl7xRDvmyI8wrs4nWtn8+rou3tCpNyIjPBOtds5efnzInAW1QCWcRG24j8EBJWM5fgMBKuTFf/QqDB3dk2YmRtXqFmMKB+s6VUs0gH70zAHTkEuAuWrXi2NAsy8fqFob56XbHghAMnJs136EpDT156v8nd0XCVh2bFczVr9I1GnHW4eRTKg0utDde0K7uQU/N0ZpW1vldm1CG7Zm5NRHvyFdM7wshSohxaWJyWRbP/+mAJ/haABVjGubQukURtUnWVBg1smOzuof/x8Ut/JUjehlhgf8t1ToUkVV3SDYYTfnwoeQuPxZuadPCAU0hTslM475SRAK+OlE0R7FxBP/N9Ji4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(261021121427099003)(261021123027099003)(261021135927099003)(261022075727099003)(261009223027099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3U4o/vo6O2thOP11pN/SUVj8t+Vtj+KJrBbyEpp6VFm6Esw53gD1nui2CvY4?=
 =?us-ascii?Q?3XBSxN4zUlTWdX/NdZr56YMDrLzlC3z1Cj8oXrr1/qJqRa0PFRa2O4ykuHBa?=
 =?us-ascii?Q?hwEpeC6lioHtPU0ZJwzPHS+5m7Zq6Zaj7509AJU7RO7kAwWatKli+X4a+Oue?=
 =?us-ascii?Q?dNvV9hROg2WhJN4CSbGpb3Yyx+wWpuuVawUq2uS//+h4N+PaXtDGNISCCmIR?=
 =?us-ascii?Q?l8fWk8MKZOK7VOE/AOsfc7Am6zs2cDQgl2uOeVy72GARMtajbkfFsKWww7IG?=
 =?us-ascii?Q?i6mHG60awUZRvbn0jIRmx1sWUP9IXOz4Vrrus9nQ8VztZc0RbsdA0LaoLbo1?=
 =?us-ascii?Q?sZEA4Pm0OfqCUrMnkyxFZc77jWxEzd3c0vManH+55wvpIMuuHQBT3GGqPxwt?=
 =?us-ascii?Q?ir9uBbuXby+czetMnngxM+xEdWcnubTTkrcmA1iff6QcDttzfbiD/biQEaiZ?=
 =?us-ascii?Q?7xpKMvyq3nCB0XvdFf3HgdSdZZBGk3XbYPoEUqagoYhRunY+XZejNPQOeEy0?=
 =?us-ascii?Q?jL4tbvx1J23Ok8hjZ4LOlf8UW4XNfT3TFx8qfJ5KlM94VpMjZ9KtqmhDYtop?=
 =?us-ascii?Q?yOR3+pR6xUhdWGOD7oA72PjtzApvdni4vutOLnju3bYlTh/BrISovxKw41uK?=
 =?us-ascii?Q?oOxNr362bIaO9q0lbekPYL8hVc/lKeGKzsaQAI5eSTtFdDWZYI0bR2azeYF+?=
 =?us-ascii?Q?bXXrK8Dj94pkaCYTufMnKO1souPbikRBPUQNstemOvHeYja6Mgy0itZwN45p?=
 =?us-ascii?Q?QAUULEq9xacfXim69/p+M4qavJ3s9TICq5taYlxy5g8ZKlcgyXU6PkaNVDsm?=
 =?us-ascii?Q?0Uvexi+9w/O0j2HNvowp3KIJPd+zizeKRq8hELNZHNRDW9qQMVEWLmlmYzp8?=
 =?us-ascii?Q?nbuVRHhXWQ8Fd2tZ1IAU95cAYmKynfE94gWiWuzvyqkxHdjWbqfsQHCxTlIi?=
 =?us-ascii?Q?GTFhlXfw/cfXHIM/y+e1zRCXZDwai/3mPLO1f0z5O43FGYelF87H0JHTknRl?=
 =?us-ascii?Q?8miSJui5FYLvBvLTMwYM/pZ22YjbPh04UM/YZEYkx666pIUX2CMDZnzOibNz?=
 =?us-ascii?Q?2254SFf8iS7sjknzY5Qqm6sQh9lVvqz2aHs28g4HuV3STK6mxqcbg4fWvSpB?=
 =?us-ascii?Q?TokF253uOfh2jgmGalVZghT7e+ABFH+khbt1toryBPQBTkmfw7uVkd+LtbVQ?=
 =?us-ascii?Q?qDJZP4055T6Fp/Mb0L9CPU23GSTfLo1O3DD2dwdzX8Y5gdoN+BqejFGe6Jdv?=
 =?us-ascii?Q?qaerCV9rolnxo9CdH6YWCh7e01NY3X2nk+OfuApK657M3m0cln+q1xLHOQ9q?=
 =?us-ascii?Q?/I9+rZbimeXNRg43QoQ5rRr5zpe4Gzs9eOui0TFt82OadvOkxpRXkpdp+S9s?=
 =?us-ascii?Q?Of4c+IGukeh5x51nO/bzZA6UgZHLBP/tAkqjNwt3ijrpbUQnM9Opg8wMp3bs?=
 =?us-ascii?Q?PkhICOcdQ2mzg05VKBmO5ESEdmOmt9337gb0ZKkAHORYhrj8/UHGO2gX3xnJ?=
 =?us-ascii?Q?i+haJAfuOihmyfvfReY67P5Q8ztRrL/WnYAv1wfHxnqi58YOW6lYSlLR9nvq?=
 =?us-ascii?Q?shAlCCB6eVBF5hqSFsOO81jfedKgj1dw1mke8jqiPFl+orqKOTb5yMuwrryI?=
 =?us-ascii?Q?wc7mNinbwfEvJT121WaF/pC8C3kusYCqsOgbwYS/lHD5qwAqFS2YIloGUElQ?=
 =?us-ascii?Q?OZKkgGnbO+FXVrIUwqRkr/Lh+pfEMI2qY33HkMlItvRdFybpBP3hTmnK3tEh?=
 =?us-ascii?Q?HAwoupfXgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HDShYCQ2yH4Xuv4TDoM36ZRU2qx7SPnCIMGsI1oWmGOOcXxMvvI+ae57IXHnhtOJG+bybHgdNAM3dC3wmrYLbo8ndWqxW+sRMQfCYUJUQHoFPl/c15Rzhktw35xPVmxGWODAiUJwfq+vN1PuSoWZVUjplwqeKTSFG0u6cPDSP8J/VqLZUoMxmaCCgzxWhubmBiMIixygBRaU4E5cEaTdGAcRI/FQ9Y2G+VpKe2gAwcG2I4wmjNffnbnO3WPcMFoplnweNYodfv9kZ1EEzOl2Fh0kdmgvRpWrdO+BXkM8kh99wXHWt5Gq8b1C20msgwyc8gJiE1Jv/Wi/avTd+gTOeA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c26f0e8-69d6-47da-f1a7-08df49332d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 07:27:06.1735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8x7ZKt9seKZGVderr71wOlCbe+mPUiuiSiIzhLayGahfUP0p4sKHavGEyKq79E6aRQ/t0trh3eRHcdhutQO7RXKIqc4MNhSbq+YvxtJCsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB183931
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



>-----Original Message-----
>From: Duan, Zhenzhong
>Subject: RE: [PATCH for 11.2] backends/iommufd: Delete FD during backend
>cleanup
>
>
>
>>-----Original Message-----
>>From: Eric Farman <farman@linux.ibm.com>
>>Subject: Re: [PATCH for 11.2] backends/iommufd: Delete FD during backend
>>cleanup
>>
>>Ping?
>>
>>Would like this to get fixed for 11.2, as it fixes the regression
>>mentioned here:
>>
>>https://lore.kernel.org/qemu-devel/133cca35-7ff1-4010-9ad9-
>>4b3e32ed3e17@linux.ibm.com/
>
>The code change looks good.
>
>Fixes: 2a3f0a59bd64 ("vfio/iommufd: preserve descriptors")
>Link: https://lore.kernel.org/qemu-devel/133cca35-7ff1-4010-9ad9-
>4b3e32ed3e17@linux.ibm.com/
>
>Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>
>Thanks
>Zhenzhong
>
>>
>>On 11/13/26 8:43 AM, Eric Farman wrote:
>>> Commit de8002534892 ("migration/cpr: forbid saving duplicate CprFds int=
o
>>> hash table") added enforcement that the hash of file descriptors be
>>> stored under a unique key, and will reject duplicates in the table.
>>> When using a device with an iommufd backend, performing an unplug
>>> and replug presents the following messages and subsequent hang as
>>> reported by the host kernel:
>>>
>>>    virtqemud[1172]: internal error: unable to execute QEMU command
>>>      'object- add': cpr fd 'iommufd0' id 0 is already registered
>>>    virtqemud[1172]: internal error: unable to execute QEMU command
>>>      'closefd': File descriptor named 'iommufd' not found
>>>    kernel: mlx5_vfio_pci 0004:00:00.0: No device request channel
>>>      registered, blocked until released by user
>>>
>>> What is missing is the cleanup of the iommufd fd upon the unplug,
>>> such that a re-plug is able to create a new connection with a new fd.
>>> Add this to the iommufd_backend_prepare_delete() routine once the
>>> user count drops to zero, to allow subsequent (re)plugs to succeed.
>>>
>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>> ---
>>>   backends/iommufd.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index ecf4caee1a8..bb3219767f0 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -72,6 +72,9 @@ static bool
>>iommufd_backend_prepare_delete(UserCreatable *uc, Error **errp)
>>>                      object_get_canonical_path_component(OBJECT(uc)),
>be-
>>>users);
>>>           return false;
>>>       }
>>> +    if (!be->owned) {
>>> +        cpr_delete_fd(iommufd_fd_name(be), 0);

Oh, I find I missed one thing, if we should delete cpr entry
when not owned, should we also take responsibility to close
iommufd fd when destroy this iommufd instance?


>>> +    }
>>>       return true;
>>>   }
>>>


