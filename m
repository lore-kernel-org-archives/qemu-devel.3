Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F208C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRf-00080y-1S; Tue, 02 Jul 2024 01:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRb-0007y8-Ay
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:47 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRX-0006Wb-SZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899564; x=1751435564;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UPXNbvJectvGQKlGoawzXgwED5aGbpHuXdk4PTl86rE=;
 b=CeNkmiMVkhtPkR9y+zRbbz7aA6GqU7H/uRupWdSdHDCBqfyFGWddicmL
 wOZx/h49ir8jEmG3oyc1Zdu3JQYVAVsC1U64sVZsl4pLqPUOv0/9A8mJW
 ryzn9ruSP//YMG8MWq2mjCZFtdxlOJTkgO7Ta8XnsesOBxsVS8yvDVSsW
 c8yyl3+sj4OZ3l3ersG1sTZbkiioyjiLyz/BmT4ExwRdgf64/FKOHUcsw
 DjWLNaIgKUX+rDio4b2P1K3xwZKm6k1AmAE+h52e1bKFkTb6eJyHKLtp7
 u3n315ZqwmbUf+cyX/jnG4ASdZ+/hOzFQu2HxGOjpoReoCLuAeyykGhcG g==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15813266"
X-MGA-submission: =?us-ascii?q?MDEz8PKJaPOgY7sLHl2EKbeeinh62r/k2Tacy6?=
 =?us-ascii?q?uTpaf7Q9b0euuXvL9lndXmbu/aeCRh6wPOqFnVAO0Xy3PLEQTkdmdIyC?=
 =?us-ascii?q?9y05jpLLzgn3MmezEuYSKEOxF5d3NbG8a3UQ5EH58fM0aMP2/Prqt0j1?=
 =?us-ascii?q?Zcmt25gj0rDqomocK/nfs7LQ=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:41 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHTn6ytoGboyRMebD6vVnAeLT1nFaBLg6Pa9vNbdIcerhNw6CXdBdKTXp+mAzMJysRusWcxu4eV8ViP6v9R0qTDKC/B0M+FO48cAw6zUj4hCPYUf5wU6sGARk/ckT+Sf9zxvwdcArgAxys2W0nefN4Bh3VpiCtu096fJNznm8DLVwxwwx/sTh4NSlvr6Iy247AD4g0/7r37VOTgrjaZklvg6AS4uhYzoVtalclk3kl3txWgysowvOyf7rlllWgsHn+DS8O8buOewwfv9U3H9zz/OIeovBKO/hp61++8PFUyox44s5z90h41VuT7jjHisngtMmd6FrmEHNpIpmyZsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPXNbvJectvGQKlGoawzXgwED5aGbpHuXdk4PTl86rE=;
 b=eDLZm/9ERuQaF2TSN6c7Kb27CK0BkyZ/+ikDSPgrbBUDY4Wwv+CsinASG1QHXrFbXj+kcho6bfFsPiKaG3O9fPH1QgtEPO6usUTXWuFOyFIkseGFTEjHzrz6AcLP3nGwiDU3lmFx6Sx/Pt3+cnB31L6XRLAs/QnIoRpYId15OvUx+omHIaULPrJjt0JvAUUZV27kWrEkEzmqnCjaaIWp8nPNBvsh5vuSXc2PJadPFUCP5lke8+fchVTWZp9V2UCL0n7mmVLg4Mf//6P02ug4S5/t3rJAhCUUoev6WQiF59xzhYohu+rFNL3UhGRU7qKQgJupKmhnDVOIMb1t+jLSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPXNbvJectvGQKlGoawzXgwED5aGbpHuXdk4PTl86rE=;
 b=EeMIEYPZpz3sIUeStS1kdi599lNClS1EyxyfZ+g1TwkwZRFId2wRiyfWIQorA3NtBre9P0TksCrysC/tWdDTJKbnqDIX32/5qwTHlC81K6yXBqdsI+bxvln6brhObothNa27XrH0/SgStwqlFphsWUd4f/juDiTnPlbutdZ/EcB/wppfDg/vejb87CE9L+ZeGplib5vrEiO1CttMxi+EczAyr3LC6tuQR7QBoNGbAZO7CvvHbHapoNhnEr8EQtUIo9Yc4AskgrKtnsAF/KDLmWL5EHDhhgjcFFLxnbqFZjv979giT/kW1yGiLbJ5Lvyb63uBuj/32f7IX3ZQ35SBsQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:39 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 12/22] pci: add a pci-level initialization function
 for iommu notifiers
Thread-Topic: [PATCH ats_vtd v5 12/22] pci: add a pci-level initialization
 function for iommu notifiers
Thread-Index: AQHazEQMy99nBSA6kkCk1O0SVH9NAQ==
Date: Tue, 2 Jul 2024 05:52:39 +0000
Message-ID: <20240702055221.1337035-13-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: e2bc0892-3e8e-4c26-8fad-08dc9a5b2ec2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SDNnd2JqcTYzVEo2ZnI5aldzZm90WkNrWUw3Q3dpaWJEbmRpQ0pCNFJXejVO?=
 =?utf-8?B?ZFdJUnJMNjFHOG0vcU85aTkxRm9SaXU3dEZPTUEwYzhEVkMraUh6N2NqZzhu?=
 =?utf-8?B?UzE1OTJUeGM4bEluajJsY01SV1dUYmtLaE5wajBZSzd6Y3pRNjdUcCtNYWRL?=
 =?utf-8?B?bHlOU3FvaUVhTlJVV1lXNDg4UFgwM0x4T1p4dlNqR2R5a3Q0eEgwNTYza0N1?=
 =?utf-8?B?ZkdZL1ZKNXA3TWhOS0RXRTBwVmNBOFBxcEc5K0VteTEwYnovdVVkR0o1QUs0?=
 =?utf-8?B?SVpjck10N1lmcjMyUXdUbmY0cU9xVFRqR0dGZC8xUnlBcUhTYkhSNWJFMnFF?=
 =?utf-8?B?VWkrVHpOWU04Z3RYODUvNmlLSXBSSjc1L1pGRWh6cjd6cVlIZnkvR2EvNHFU?=
 =?utf-8?B?eGhIUVBmUkxSZytiSkR1ZFlnQlpkRjZzaWhEaW14QlR5cWZMMWpwbHhGRTFU?=
 =?utf-8?B?TUhNK0hOMi8wOHFVTjd2U1h6OGtVVFROc2lGc3piYVdWV3kwYWZtRFgyN0VB?=
 =?utf-8?B?eEkzK1lrVXUweHhhdjZPUzhmeWpGUVluN2RRai8xeThmT29mc2cyZUliSEZh?=
 =?utf-8?B?SjZkRU05bnFPSWZLdWFuSWJ1OUFsWjdUQ3I0UldpZTZ0bU1OOFVWODBvQ0lY?=
 =?utf-8?B?WGhHWm10WlBWNUxnWWUxTkQ0a3FzTStXdTNDMjc4Vzl0QTFCQzl6cGNyV0pH?=
 =?utf-8?B?UURXTFQvNnE2ZkZPRTVtRmQ2MDg3YzBKVU1DRzBYMTFJY1d2Y0ZKdm9iSCtY?=
 =?utf-8?B?d1JlbnNzbDV1YVgzNTdsYVhlOWVoaHpydkV1aVltMUE1S0l2eUR1c21hWWVk?=
 =?utf-8?B?RWhYKzVxMVRVVEwwU0tNdW1NUWZxMUJqN0F3T0trekpBT1BKWVNtdWJRcHJX?=
 =?utf-8?B?SDhJMUFwMFB4bE9YWDJlSHBLc2oyTkhpUGllRjBmaEZ5VHZ0QlBaOHBMb2hh?=
 =?utf-8?B?YnlVeDQwZEk4Nk9wUzIya1lVekx1KzNVMVJJSXhWNENFcmM5dExMSVlsWU1x?=
 =?utf-8?B?OE0xRklJOXJld1JWWWlzOFBoOU5hU3hQQzdVdWFQS0VmQkZEeU1DR3V2WGZw?=
 =?utf-8?B?WUFsMEpIMjRGZ3ZFUkE1U2hhWGxhaDF6RWZPRXdaZDNoQWt2cVkxWjc1bElK?=
 =?utf-8?B?UDdFdmNaMW9HTkRycEFWVWR0dUtkNFl5QXZzT3lVeVdnR3g3Z2dPTmJYanUz?=
 =?utf-8?B?VncvZHRvbDFBRHQxNmRaYnk2anBpVk5uajRjMW9lVmh4U0VhMm5pc0U2OTkz?=
 =?utf-8?B?bmRTUSt4Nk1reUhyODd4ajlicjhqOUlzM2QyRGZWRkI3ZmtCL2pIelNEQmtj?=
 =?utf-8?B?L0xzT1J0VU1xRUdWc3NiN1ltU3NEM2ptSGtjSmxhUG93ZnZmc2dYdmdoZHdL?=
 =?utf-8?B?MXpsK21vTHYwSEwyMG45c2hrYVpYV1pycnVrOFJQYTlsWlZnOWl3M0QzeHho?=
 =?utf-8?B?RHdFaXJJaEowNnFra0JtTEhidENTRExrWDRhZjJublpmMnRpUFN1VDZBMzFI?=
 =?utf-8?B?d2VrejlUVFFuTUpZbHN2Nit6eVh5RkQ3bndqSXVuWE9HVGx4V25heVJaeHdR?=
 =?utf-8?B?dk45QTB5RkdKSk5kbGowVWNKQWVuUEtidW80MEV6bjREamFVY2c3bTRjL2hN?=
 =?utf-8?B?Z3RJQ01kQmtRdDU2MGlFbFFLVzNrbEtiaEtWa0hmVlNaa1B5S05sUHpMcWlJ?=
 =?utf-8?B?N3E4eE4ra1E2NlhqanVoOTliYnFXSXMranNKNldKcXpOTEJ3VmFCc3VGRnBN?=
 =?utf-8?B?MmE5amU4aTdxQ2w2eU5jMWpCZHFGQnh3cmY2cTFIMllLekJKb01Dd3ZMeisy?=
 =?utf-8?B?YXV6OU5jenBwQWlrWWtNUkZKN1lxbnptSHAwQldQL0NUeGFCejBic0FoZXp5?=
 =?utf-8?B?dTFuNExzdmJaT1haMXBmQ0VlMGNZL3VvS28vNGpHMWU3bHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTZhektVV24xWWVVVVdjQWdvbXhiR082WVV3d0oxY3ZFQytEck12QldyUCsy?=
 =?utf-8?B?NWtOZEpMa1VrSzZuLzYvSmJwVGlKL3g1OWxYLy9FUExHeThxRXBzcnVnSzVQ?=
 =?utf-8?B?UWR6d054MWpqQjZoekM5TnRPWFZvRTZwcXczYTNaVE5SWFBycE1WZnl1c0NZ?=
 =?utf-8?B?TUhuVjNUR1VzQndmZXhuRi9zMVcxRHVUbGh0dmZGWm1jWktRN0pTN3VMRXh1?=
 =?utf-8?B?ZXpjSHhpbS93aHk3ZFVjemlBTk95b2Z0QjZOZUJ4NXIvTmlpMkw0eVdrQXFV?=
 =?utf-8?B?dndlb1ZrQVBCc1pXNnJNMEVRL2ZvRGp1bE9wNmoybHRxKzJRcyswNGw4c3lo?=
 =?utf-8?B?eTNqbndOTm1UcWlTUzJwQ0F5ZDhPUS93WlBkTXZsZXdJOXJkejI0ZHFHNHpv?=
 =?utf-8?B?REQ4UnkvUG93eVdWY2tEeENwZnBYblQ4VUVNMlhmbnpPSnNkcjcwVFU3MWVJ?=
 =?utf-8?B?Y0s0VGtBUmN1S2tVSndSZTA3M0ZmNWYzTE80clZ2N2YzQ3QwaDU1YXNFOXlH?=
 =?utf-8?B?WVBFZXFUK1NjNXZxU3d2YUZHZzM4WDlmb0NJbkpIbmlUMk9GbGFEYUdWMExG?=
 =?utf-8?B?NURmdXFCNEQ2eWVFUEZaS3BBaEI1Rm5GTzlSUzM4ZkpNU2FRYkNXcWRpMDU2?=
 =?utf-8?B?ejR3akNYMDdvTWIzSFN6b3lhc2lkUmsvRzhzRzNURzdEaFVDdFlVYXlHVEtD?=
 =?utf-8?B?cnljb1htOGtqWmdZVzBhenUxSEhHc1kxQTc1ZWUwUTFldjBLbkJhRUVpSlhL?=
 =?utf-8?B?eGZYNHJPNm4rc2tyMkFjWlRnNjRGWjBLNWVka0lLUzY2dm9mWXdId1BmZEtw?=
 =?utf-8?B?UmJqRUo4S2pJMlc0aVVLUjUrWVR2dE9NMzZ4elZwdFZRWkxNSHAvZTFzbHpm?=
 =?utf-8?B?TXBrc0R5S2ozaEhlckN1Tm1kK2M1YlhpdkNMeW45emlqM1VyK3NwOW9za1Qv?=
 =?utf-8?B?T0lGNU95MDl0SE5WRklzNUp0cDNWU2xLd0l0K3NCejBUTVRKQ2tMNWMydFN0?=
 =?utf-8?B?VkkrSDlIbjZ5QjhEc1V4OUY0YTc3MThnbk5vUFV4MWpyalA1TGp0NzcvTUVQ?=
 =?utf-8?B?MEJJK3VKUjA1dTJGZWpudXRaeUlzTVNFVEY4WThveEd2REtJMnNDdVVhQXNS?=
 =?utf-8?B?SnhHM2dxWWUrbitrbXVNUktPdHZzZkhjRlN2SkhYak9ONExDbUZoUld1RHVs?=
 =?utf-8?B?cEhZV003dW1oY0NhMTdYT2VpL3Y1TTZvd0RGSUZ6b2RCKzlRQUdVaDJ5T29u?=
 =?utf-8?B?L3pXSUFiNExqRTFUR1hKa205ZEpvRW1iQ0FUclFpRHNleER5SXJyNjZJL1dQ?=
 =?utf-8?B?Tm1UWjBjV1hpL3dkMm1lV2hhUVFyc21tWnFsMW5NMDFpYVl0OS81NlFCbWgr?=
 =?utf-8?B?NmJOWFBObE8wL2xaR2R4Zy9lLzZQYWIvTE50aFJDc01hc1doaS9NMVNSeXFn?=
 =?utf-8?B?VGl1RXBoWk93NjF1WkNXdG9uY2FqTm9HYTJ3QWJjV0Z3bXBLVDI5d2Nnekxa?=
 =?utf-8?B?ak56dmF5TVJYQ2lVelNUK0FWeUVmRXRDaFhHSjJUbGVOdlNMbVc2eW4wbW9h?=
 =?utf-8?B?aEVPU0drNmVlbzFzSm1xYTErQk1mM2NTWHMrSWNCZllibjh5c2lsVml5SjFY?=
 =?utf-8?B?ZjBvZytxMVdzdHV5Y3U2bEVzT05vMzJySGpGK0dxT2s4djJ4MzJlTXJyeUdr?=
 =?utf-8?B?MVZIS3ZGODJEaXRxcC9KWG94M3lWVWxSamxNeTRQajdUdjA0OGRIR29JZTBW?=
 =?utf-8?B?WjRnd2FnWk9UMnNsQ3RrMmxHMDhWcnNQdE5sc1dhRmlDaW5pQUZTNDlWN3dW?=
 =?utf-8?B?Zi9NenNTNHJEMWpNRDlDTHFYYkNONGoyYXdhamhjZTFkYi9mU21UaXdlRGxu?=
 =?utf-8?B?d0JJZG5BOVlTV3BnTktyUXNzSVNWTm54RGluWnN2OW5SanpjcVo1Rkk3ZFR5?=
 =?utf-8?B?OXNBSDFCTlo0UHFnbjA0dDBTRFRDNmZIRnBLMXk2emZrMnZTcUJEc1RjK0Ru?=
 =?utf-8?B?cFQyYjhwb2hBYjJZWVJvTkZ4dnk5eW5yWG9yUURXYU9CMVdWejhVZVpYYVpS?=
 =?utf-8?B?US9BQkV4dTM4MmVYL0Z2ZGJmS1cyajl5bzlPMjNHeFJ1SFdzWU9VSjAvbDR5?=
 =?utf-8?B?bmJvRFBHc281U2dNMnBiYTZZNzhTeHduOW5xWDcvNVdRUkVZRzdQempKaEJG?=
 =?utf-8?Q?1TIKYM9+rpM24qwUV9iNPt4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BE87F94565FFF49A948C8539823297B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bc0892-3e8e-4c26-8fad-08dc9a5b2ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:39.6479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uhg09Kd2X6ywVl7YoQ+6z71SamWDz3un5KD480oBODLKf7OfwyJFVnGwJ8wwIVHe6E86KfNS25QWkp/rg02OOHi9xQJBbtyWit87lakDFLOebjH2xABw9WecUkocurS6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCldlIGFkZCBhIGNvbnZlbmllbnQgd2F5IHRvIGluaXRpYWxpemUgYW4gZGV2aWNl
LWlvdGxiIG5vdGlmaWVyLg0KVGhpcyBpcyBtZWFudCB0byBiZSB1c2VkIGJ5IEFUUy1jYXBhYmxl
IGRldmljZXMuDQoNCnBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3JlZ2lvbl9wYXNpZCBpcyBpbnRy
b2R1Y2VzIGluIHRoaXMgY29tbWl0IGFuZA0Kd2lsbCBiZSB1c2VkIGluIHNldmVyYWwgb3RoZXIg
U1ZNLXJlbGF0ZWQgZnVuY3Rpb25zIGV4cG9zZWQgaW4NCnRoZSBQQ0kgQVBJLg0KDQpTaWduZWQt
b2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZp
ZGVuLmNvbT4NCi0tLQ0KIGh3L3BjaS9wY2kuYyAgICAgICAgIHwgNDAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvaHcvcGNpL3BjaS5oIHwgMTUgKysr
KysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMNCmluZGV4IDNmZTQ3ZDQwMDIuLjdh
NDgzZGQwNWQgMTAwNjQ0DQotLS0gYS9ody9wY2kvcGNpLmMNCisrKyBiL2h3L3BjaS9wY2kuYw0K
QEAgLTI3NDcsNiArMjc0Nyw0NiBAQCBBZGRyZXNzU3BhY2UgKnBjaV9kZXZpY2VfaW9tbXVfYWRk
cmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldikNCiAgICAgcmV0dXJuICZhZGRyZXNzX3NwYWNlX21l
bW9yeTsNCiB9DQogDQorc3RhdGljIElPTU1VTWVtb3J5UmVnaW9uICpwY2lfZGV2aWNlX2lvbW11
X21lbW9yeV9yZWdpb25fcGFzaWQoUENJRGV2aWNlICpkZXYsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFz
aWQpDQorew0KKyAgICBQQ0lCdXMgKmJ1czsNCisgICAgUENJQnVzICppb21tdV9idXM7DQorICAg
IGludCBkZXZmbjsNCisNCisgICAgLyoNCisgICAgICogVGhpcyBmdW5jdGlvbiBpcyBmb3IgaW50
ZXJuYWwgdXNlIGluIHRoZSBtb2R1bGUsDQorICAgICAqIHdlIGNhbiBjYWxsIGl0IHdpdGggUENJ
X05PX1BBU0lEDQorICAgICAqLw0KKyAgICBpZiAoIWRldi0+aXNfbWFzdGVyIHx8DQorICAgICAg
ICAgICAgKChwYXNpZCAhPSBQQ0lfTk9fUEFTSUQpICYmICFwY2llX3Bhc2lkX2VuYWJsZWQoZGV2
KSkpIHsNCisgICAgICAgIHJldHVybiBOVUxMOw0KKyAgICB9DQorDQorICAgIHBjaV9kZXZpY2Vf
Z2V0X2lvbW11X2J1c19kZXZmbihkZXYsICZidXMsICZpb21tdV9idXMsICZkZXZmbik7DQorICAg
IGlmIChpb21tdV9idXMgJiYgaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdldF9tZW1vcnlfcmVnaW9u
X3Bhc2lkKSB7DQorICAgICAgICByZXR1cm4gaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdldF9tZW1v
cnlfcmVnaW9uX3Bhc2lkKGJ1cywNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
b21tdV9idXMtPmlvbW11X29wYXF1ZSwgZGV2Zm4sIHBhc2lkKTsNCisgICAgfQ0KKyAgICByZXR1
cm4gTlVMTDsNCit9DQorDQorYm9vbCBwY2lfaW9tbXVfaW5pdF9pb3RsYl9ub3RpZmllcihQQ0lE
ZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBJT01NVU5vdGlmaWVyICpuLCBJT01NVU5vdGlmeSBmbiwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKm9wYXF1ZSkNCit7DQorICAgIElPTU1VTWVtb3J5
UmVnaW9uICppb21tdV9tciA9IHBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3JlZ2lvbl9wYXNpZChk
ZXYsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcGFzaWQpOw0KKyAgICBpZiAoIWlvbW11X21yKSB7DQorICAg
ICAgICByZXR1cm4gZmFsc2U7DQorICAgIH0NCisgICAgaW9tbXVfbm90aWZpZXJfaW5pdChuLCBm
biwgSU9NTVVfTk9USUZJRVJfREVWSU9UTEJfRVZFTlRTLCAwLCBIV0FERFJfTUFYLA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgIG1lbW9yeV9yZWdpb25faW9tbXVfYXR0cnNfdG9faW5kZXgoaW9t
bXVfbXIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQpKTsNCisgICAgbi0+b3BhcXVlID0gb3BhcXVl
Ow0KKyAgICByZXR1cm4gdHJ1ZTsNCit9DQorDQogQWRkcmVzc1NwYWNlICpwY2lfZGV2aWNlX2lv
bW11X2FkZHJlc3Nfc3BhY2VfcGFzaWQoUENJRGV2aWNlICpkZXYsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpDQogew0K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgN
CmluZGV4IGFkN2JkMmFkZTUuLmIyYTllZDc3ODIgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3Bj
aS9wY2kuaA0KKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCkBAIC00NTgsNiArNDU4LDIxIEBA
IGJvb2wgcGNpX2RldmljZV9zZXRfaW9tbXVfZGV2aWNlKFBDSURldmljZSAqZGV2LCBIb3N0SU9N
TVVEZXZpY2UgKmhpb2QsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3Ig
KiplcnJwKTsNCiB2b2lkIHBjaV9kZXZpY2VfdW5zZXRfaW9tbXVfZGV2aWNlKFBDSURldmljZSAq
ZGV2KTsNCiANCisvKioNCisgKiBwY2lfaW9tbXVfaW5pdF9pb3RsYl9ub3RpZmllcjogaW5pdGlh
bGl6ZSBhbiBJT01NVSBub3RpZmllcg0KKyAqDQorICogVGhpcyBmdW5jdGlvbiBpcyB1c2VkIGJ5
IGRldmljZXMgYmVmb3JlIHJlZ2lzdGVyaW5nIGFuIElPVExCIG5vdGlmaWVyDQorICoNCisgKiBA
ZGV2OiB0aGUgZGV2aWNlDQorICogQHBhc2lkOiB0aGUgcGFzaWQgb2YgdGhlIGFkZHJlc3Mgc3Bh
Y2UgdG8gd2F0Y2gNCisgKiBAbjogdGhlIG5vdGlmaWVyIHRvIGluaXRpYWxpemUNCisgKiBAZm46
IHRoZSBjYWxsYmFjayB0byBiZSBpbnN0YWxsZWQNCisgKiBAb3BhcXVlOiB1c2VyIHBvaW50ZXIg
dGhhdCBjYW4gYmUgdXNlZCB0byBzdG9yZSBhIHN0YXRlDQorICovDQorYm9vbCBwY2lfaW9tbXVf
aW5pdF9pb3RsYl9ub3RpZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuLCBJT01NVU5v
dGlmeSBmbiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKm9wYXF1
ZSk7DQorDQogLyoqDQogICogcGNpX3NldHVwX2lvbW11OiBJbml0aWFsaXplIHNwZWNpZmljIElP
TU1VIGhhbmRsZXJzIGZvciBhIFBDSUJ1cw0KICAqDQotLSANCjIuNDUuMg==

