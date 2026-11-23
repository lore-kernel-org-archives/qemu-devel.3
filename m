Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AF606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e94N7EHb;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=JCH8xs13
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVKaG-0001lo-Rk; Sun, 22 Nov 2026 22:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xVKaD-0001lS-UQ; Sun, 22 Nov 2026 22:19:10 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xVKaB-0005IP-5n; Sun, 22 Nov 2026 22:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795403947; x=1826939947;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xh1Z6dJTJuJ28rx+0DDWqD4vKhCSAFT1zonLkuG7+U4=;
 b=e94N7EHbzNo715vADMbQ/M63exO3GQhYxAt4V0rRLtomNc23dmjp1Hm2
 eR/UeOZx+MjELuQ+8cW76Bz18epyMEBOYKY6qEdNmT/zcIe4dYVoj0LT3
 YmhkmCEM5hLUZe0rjLC7mRYHi34SR5Kijg63eFylYhNQ+fO7DWX4brEGE
 IxdbpLOS5nVV7sW6m6aFAtyyz7QLqPtHHEyvQQMIG8J2KHEJD8I6fiskl
 f3Jn4GFgeVMUwBNh2cuGXngoizrM95vmoZ/BVF2r+98iscUjcqGGPTcp6
 Mi6ACLAClTKwebDDnJNIKZo41/BBuVCwGfc22L8s/CT50eJOhs2KEo9r4 A==;
X-CSE-ConnectionGUID: 3Qo0NAJ3RQGftZmJb4dpZw==
X-CSE-MsgGUID: VREsI8a+Tdaofr4Uv/9IeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4243470"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4243470"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 19:19:02 -0800
X-CSE-ConnectionGUID: bF5O8BQ6QseEhhCLgl0G5w==
X-CSE-MsgGUID: 6Mv5UT7cS3aJOtn8qvSpOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11394790"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 19:19:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 19:19:01 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 22 Nov 2026 19:19:01 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 19:19:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMj9BbYCjGpXw2pJHY6i+Gq5RwOebzojL7C/GenErUhPhETUwfIsfWwnVNWZxzzWfO3sVaA/P03YhQuR3Oipw0Ss95Y5OPIrGN0UzL+AZhWcfsbHNqMUEV3lPMOR2JYwcvThm8mM0OIj/Fdn0WdvWa+OyUEzreiXO+YrFYt16V+QzjB8q1bkwKjpvSowVbDH5bGy38ZM7Vzu6xbDjvJlcMABBUWrh0DMO7KTj4VJjcxNPZsLN5ozmEUhhWLNL2KD5DL9zg7sMkB01w2YGj35AuD6qHXapPV1A63u8C97BEeHrkrQ+cFGUHMw1On0Gpao+u7RVxuYz+4X4I3B1bm2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh1Z6dJTJuJ28rx+0DDWqD4vKhCSAFT1zonLkuG7+U4=;
 b=vznWE/Jeceu3Y4mok5/lKQe8EJxthGZj2mqECnadVGhuGndIOVqyCMd7JSr7II9CfZtRfQzPV83+9ODXPddljmboc4ADBjoOqRs7XuloLdJWctS86IRLULi8OQLlqwx5H45GZkSv8gwTGV8E+RM6LVcl69cXb7L+SjcNV4q4mO1UZOQDWfE8zrd65sgHFrnt2bb4Ljo8fVjSvnMn9f91OdI32VLU7lgMvHz83UIktSZtVSS5HDKMudIUM0I0M2m4kA7rmaf673I485IvZdkF8aDvGJVy5WQRx/jOJ0dXFz/z6uU3ZX2x4iQeDizBqF+MyF20Tan/VCggcq49liFKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh1Z6dJTJuJ28rx+0DDWqD4vKhCSAFT1zonLkuG7+U4=;
 b=JCH8xs13psvHwSAzOFAoOFQsucT7zAP82vudwG6Ol14YZIEygfIySyvJrC6THismurTKyW075PTTK6MXURt63kR+gC6EsKw0Bp6eQGBYKBDcoukVxCIPL0DDxyPl4BD24NYGl2Sl1ACDhoU/pmGw4YJ2QNyx5krqPMq8gLmL3nM=
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA2PR11MB4969.namprd11.prod.outlook.com (2603:10b6:806:111::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 03:18:59 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 03:18:58 +0000
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
Thread-Index: AQHdc4FS3GORE9hAHUCANvwycSy43Lc1aRyAgAWiYeA=
Date: Mon, 23 Nov 2026 03:18:58 +0000
Message-ID: <IA3PR11MB91367BB9464D88D270CCFC2492452@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20261113134335.2451039-1-farman@linux.ibm.com>
 <65204740-1995-4a14-b803-35dad498af97@linux.ibm.com>
In-Reply-To: <65204740-1995-4a14-b803-35dad498af97@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA2PR11MB4969:EE_
x-ms-office365-filtering-correlation-id: 03859f57-d686-4580-a783-08df491083bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|18002099003|22082099003|260925022911599003|260925021911599003|260925021311599003|261009223027099003|261021121427099003|261021123027099003|261021135927099003|261102123227099003|261022075727099003|56012099006|10067099003|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info: mTdrTvsLXacYOS4uFWS8uaHhrEi22hEcTriwiNEBMCEhG8J+GlptmVdj7FolSfIA5BSDANCHau4NtveRVIhyf2Ka+Mxttjc3MPieTkkbJOgNNB/bbTkuJMHiHm+2janS03g9OWMjR4P0zNM9c9WrVrnzos79qZHk2vgCXuhxO6HWXm5cVOFFR1O9BucsC+4xpprz+x0YbJuWdhcpfLbi2jWgYThwRyqeCKkUGFDZoaTyeDF7ddBIgpPQH6w8s7FynR+AhaCxkZABV2GcIPJQs5aUrX4ho95aHCnkwek2uCLJrhE07PUljFj18aPeEzI8vnipsqw2bFCqf+VWV6ZzlDRfCj+/0ww1ydW3ck9iYayHjesJp8CIOQuL7baY2aB/j3mSsjgcnsuftSqksjw6A+lgm6UXMsDHrtA4pPNFcEA/Sb8o3VaOVmBGtOEfOacKxexoSc3f4YtwUtYqvhzM95Rmfc7Mz6b10dAVkJYWvQ7fD1x36sWekeSHQDviMW54EB2hD1dVI/8//RQc1VhGI6aM2JJihDKf8Cakn4Ch2pxDI+duI32JJqqQ08xAhiPwAbleE8FERji/wj1kGAYKYgUrRIYN+RLD4S0h1r/06J02ZGDcXFVysnaPgplQuiF+2DHHka2iPvjVLDGaAWeTcLqEoB3b0DpiCrpU3digyqM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(260925022911599003)(260925021911599003)(260925021311599003)(261009223027099003)(261021121427099003)(261021123027099003)(261021135927099003)(261102123227099003)(261022075727099003)(56012099006)(10067099003)(38070700021)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0dya1k3QVZqVXNScnV4cmJlUHQ3YmsrNGNaUUNnUWRaS1dFRHI3dU1CY3o0?=
 =?utf-8?B?NUY1bEdBRElKL3prVlBiMXhzRklxL3BadzNEWmIyWlFrcC9panRFRGFUT3FF?=
 =?utf-8?B?WVBHMExIdHVRYmI3RDZtUmd2V25lbDcyamozU0V2dkRBVWUrb3hnUUxGNGJF?=
 =?utf-8?B?V0oxRDdGam1vT0dzNE1BajI5Q0MvTU9hcjBNQ2FQZy9oNE8vM1JodVUxR1ZS?=
 =?utf-8?B?QnR2bWx1cVlQRitZZXRNY3FTSXNWYkg5d0trQ3lJZkI0cWVrSE5xQUtnSloz?=
 =?utf-8?B?dklQRnNpSUh0RlJwbks5NnN6RFF4dDZtQ1pBZXdBcHgrY2I4NzJBdmdoS2do?=
 =?utf-8?B?N3JxaVVUUXNLd3ZrU29rM3dwbVp2TDhhcloxRng4L1NRTDkrTjA3WnNEYW41?=
 =?utf-8?B?eGZMcklHOG1NOU1QM1ZEK2RRTzFtR2JDM0hLKzVnMHdNajlqVEZvbzltMEl4?=
 =?utf-8?B?Q2dwOGVtbjJVZzNublhseGg3OVZsdlNZVG1pYUVsVVgxeTRWMmxxMGpjSzE4?=
 =?utf-8?B?SDBQdHJrazUzU0tHSUlRU1hBczBIandHdDlsakhlOEh1Z0lMQ01vNW5TaXZl?=
 =?utf-8?B?WHVIYW50VVBsZncvalhkTGF1R3g4R0RJdTNYTkVWTG1lLzN3bERvandCY3Bl?=
 =?utf-8?B?RjNNVDdaMlk4VjNsYmJLZ3pRa1RZczN2ZS80Ry9YT05wRjBsUDBLd3JCcWI4?=
 =?utf-8?B?R094U3ZaOVFNQk1iQ0JLN2xtZ080MkZMWENpaldoUjhDTWpJTjlia2wyVUJv?=
 =?utf-8?B?c3ExUk50cTgwM242QTh6WkpvMS9hVjlZRGEzSFYreHZhTnVlc0RvbFNzU3hv?=
 =?utf-8?B?VmxYbXhrOWZQb0R4TzYwMEpod2s0MUJOR0xhelFvQjlvWE5YUmMrRGNwa0lR?=
 =?utf-8?B?RG1TVE1iVmxhTTZKQ1lXRWJDcENITmNoTU1NQ0hpakN0clo2ZS91S0ExUkVn?=
 =?utf-8?B?U2l1UHJRQitWd1hySldtbGZDTGtVZkVod05qbWFFaG9SMWFOOVdFQXA1YnJl?=
 =?utf-8?B?TUJRN2hFUXN1QUlVSnZBTWRhcUEzTm81cFU1eXBKeHNYMEVuRnJmYS9melJE?=
 =?utf-8?B?S1dhU1VKczBYVVR6R0xHUFdvS0ZCcEt4SjBKR3gvWHVzMGVzNlVGL0JaQXZM?=
 =?utf-8?B?MG1DdDZvVFNtaytNTURHQnM3alRMdGdiYi9mM00weURyakhSOXBuSGM4VzJC?=
 =?utf-8?B?YTlBWUwyWHdJcldmM0doTmlMOC9icm0zSVpzRGJrYkl3aUdDUEJybCtWdnc5?=
 =?utf-8?B?TmtyTFd5T0g2VFlhVEl4OWMvaFN3TW1rdmR4ZDFWVCtmd1VoNTE1UzVMdUZM?=
 =?utf-8?B?cGIrRDRpaFlHVkNXbzY4SnFQSU5xN0xuT1ZDQkhVKzNjMWc4V1RkYUZwck8v?=
 =?utf-8?B?TWp4MVRwTWJwTjJLS3gyanQrM2wyZ1hRVlhGTG9MQ3NPUVV4bXlEaWc4L2dU?=
 =?utf-8?B?MGxaRmtrYWVTNXRKSjlmSENrQjVNY0tTUGlZbFo5cEdhT2QrZzdJYjVtVHFl?=
 =?utf-8?B?Vi9SeWd0ZGlkYkpFeUV0MTRGSEpmWlgvTzB1YlFEejBCemRWM2JpLy91eExr?=
 =?utf-8?B?Q1NEUENwamNibTVOb2R1cnBxQnNtNTdWY1BUL0dFWXF5YWlOMmlVV080N0Er?=
 =?utf-8?B?eTRSeW9JR0pEbElDZmdYejM3VVRkU2dCSlNlQkpaZ2owdm1qN2ZhQUxYM1BQ?=
 =?utf-8?B?aXVNTWdhQi9JQzFncDl3dk1YdEhmOWRzMFFTbTFYOUI4QktTYytvT1VmNi9M?=
 =?utf-8?B?VVVLUTJraXQyNDVsM0lNbEJEMnZMOUdSRzNrOUhaNjlwYjhSb0VUSHdhU3B0?=
 =?utf-8?B?MmF3UFZUYWRTME5JUXFOcTdRay90YUkxek5YdkhzSm1mNlA1WmpUdmR6QjZo?=
 =?utf-8?B?dnQyOHZRTVpicXZuaDlaLzVhRnZUVENYb01hdzVUSnNlc3hmamZmdmJNMkg4?=
 =?utf-8?B?RnNrZkZyQTJhZFpFbVo2citaYXBUSm1SQTIzKzdMVW1UdzdVTFVWOGdiS3JT?=
 =?utf-8?B?M2NISjY0T0dhL0wzelkzOVN6ZUx6K1crWEZBelRjNDI5YkN2dWpCVVcxcHNn?=
 =?utf-8?B?UnErcTdseFd4bytMMGNxWndyR2gvQjNaZVcycWlQaWVCMU1XV1VFVTlMaUVU?=
 =?utf-8?B?UDNGeVpWajFzOFpRUmQrd1dScktoUmFjSFZmcXVHMGF6L1ZFL3dQb0tRaVpB?=
 =?utf-8?B?YnVMSnJvM2RrbmVhakZ5ZlRleVRXRGE3TDZIcXRLWmI3VWxicEpaeFlQNGNZ?=
 =?utf-8?B?eGV6UVl0N2tUQ2FITnU5cUs2cWFYdGJ5a0dYMG85Zi9sZEVBRVM2cHg3bzFw?=
 =?utf-8?B?c2t3ZUhhYzBZQjNTNHhIWUtjSENtZnNBbldvZHJtTWVXcEJieG9NUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J7s5P9MyiRulgg+cr1AIDdVoOd6gfZxvR0fOl/ap4bAcxN0gTf87JA9TMTr0H9Ppb/25c0bR3FfMV2iPQe22nJlAPJB33YcQTHhL74GOT4My+dR2diQe143HeCJHxj72inaqSD34NKoTrKJpGdtXxgulo+xgummHoBa9xhw6daJqdOoO3zM1QTTZ6S9v6XAhORkGJxZIDTY7qdTiCIeJrW2gmSYwBghssuQUbs6FKFBgmxt/HLvYxn8iQ5QXi9J1664dx25KFLeNRBbtVkfYHhccEHvKhmFh64b0XoT/HqM764IpLMbbDnbU5bW3y6OsxzZZoExPudj0x/CENyT01A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03859f57-d686-4580-a783-08df491083bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 03:18:58.8095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/yu1z30G5KV7XP6Q6dyaqhsGJWz/TfGa1Oqmj0FP1A9bd0OIt/X22HMq0OGW7z2Tbz4W9JJwHEh2wtePavIoVN1c86CrkyvBtddQE6hr8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgRmFybWFuIDxmYXJt
YW5AbGludXguaWJtLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIGZvciAxMS4yXSBiYWNrZW5k
cy9pb21tdWZkOiBEZWxldGUgRkQgZHVyaW5nIGJhY2tlbmQNCj5jbGVhbnVwDQo+DQo+UGluZz8N
Cj4NCj5Xb3VsZCBsaWtlIHRoaXMgdG8gZ2V0IGZpeGVkIGZvciAxMS4yLCBhcyBpdCBmaXhlcyB0
aGUgcmVncmVzc2lvbg0KPm1lbnRpb25lZCBoZXJlOg0KPg0KPmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3FlbXUtZGV2ZWwvMTMzY2NhMzUtN2ZmMS00MDEwLTlhZDktDQo+NGIzZTMyZWQzZTE3QGxp
bnV4LmlibS5jb20vDQoNClRoZSBjb2RlIGNoYW5nZSBsb29rcyBnb29kLg0KDQpGaXhlczogMmEz
ZjBhNTliZDY0ICgidmZpby9pb21tdWZkOiBwcmVzZXJ2ZSBkZXNjcmlwdG9ycyIpDQpMaW5rOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzEzM2NjYTM1LTdmZjEtNDAxMC05YWQ5
LTRiM2UzMmVkM2UxN0BsaW51eC5pYm0uY29tLw0KDQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1
YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0K
Pk9uIDExLzEzLzI2IDg6NDMgQU0sIEVyaWMgRmFybWFuIHdyb3RlOg0KPj4gQ29tbWl0IGRlODAw
MjUzNDg5MiAoIm1pZ3JhdGlvbi9jcHI6IGZvcmJpZCBzYXZpbmcgZHVwbGljYXRlIENwckZkcyBp
bnRvDQo+PiBoYXNoIHRhYmxlIikgYWRkZWQgZW5mb3JjZW1lbnQgdGhhdCB0aGUgaGFzaCBvZiBm
aWxlIGRlc2NyaXB0b3JzIGJlDQo+PiBzdG9yZWQgdW5kZXIgYSB1bmlxdWUga2V5LCBhbmQgd2ls
bCByZWplY3QgZHVwbGljYXRlcyBpbiB0aGUgdGFibGUuDQo+PiBXaGVuIHVzaW5nIGEgZGV2aWNl
IHdpdGggYW4gaW9tbXVmZCBiYWNrZW5kLCBwZXJmb3JtaW5nIGFuIHVucGx1Zw0KPj4gYW5kIHJl
cGx1ZyBwcmVzZW50cyB0aGUgZm9sbG93aW5nIG1lc3NhZ2VzIGFuZCBzdWJzZXF1ZW50IGhhbmcg
YXMNCj4+IHJlcG9ydGVkIGJ5IHRoZSBob3N0IGtlcm5lbDoNCj4+DQo+PiAgICB2aXJ0cWVtdWRb
MTE3Ml06IGludGVybmFsIGVycm9yOiB1bmFibGUgdG8gZXhlY3V0ZSBRRU1VIGNvbW1hbmQNCj4+
ICAgICAgJ29iamVjdC0gYWRkJzogY3ByIGZkICdpb21tdWZkMCcgaWQgMCBpcyBhbHJlYWR5IHJl
Z2lzdGVyZWQNCj4+ICAgIHZpcnRxZW11ZFsxMTcyXTogaW50ZXJuYWwgZXJyb3I6IHVuYWJsZSB0
byBleGVjdXRlIFFFTVUgY29tbWFuZA0KPj4gICAgICAnY2xvc2VmZCc6IEZpbGUgZGVzY3JpcHRv
ciBuYW1lZCAnaW9tbXVmZCcgbm90IGZvdW5kDQo+PiAgICBrZXJuZWw6IG1seDVfdmZpb19wY2kg
MDAwNDowMDowMC4wOiBObyBkZXZpY2UgcmVxdWVzdCBjaGFubmVsDQo+PiAgICAgIHJlZ2lzdGVy
ZWQsIGJsb2NrZWQgdW50aWwgcmVsZWFzZWQgYnkgdXNlcg0KPj4NCj4+IFdoYXQgaXMgbWlzc2lu
ZyBpcyB0aGUgY2xlYW51cCBvZiB0aGUgaW9tbXVmZCBmZCB1cG9uIHRoZSB1bnBsdWcsDQo+PiBz
dWNoIHRoYXQgYSByZS1wbHVnIGlzIGFibGUgdG8gY3JlYXRlIGEgbmV3IGNvbm5lY3Rpb24gd2l0
aCBhIG5ldyBmZC4NCj4+IEFkZCB0aGlzIHRvIHRoZSBpb21tdWZkX2JhY2tlbmRfcHJlcGFyZV9k
ZWxldGUoKSByb3V0aW5lIG9uY2UgdGhlDQo+PiB1c2VyIGNvdW50IGRyb3BzIHRvIHplcm8sIHRv
IGFsbG93IHN1YnNlcXVlbnQgKHJlKXBsdWdzIHRvIHN1Y2NlZWQuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogRXJpYyBGYXJtYW4gPGZhcm1hbkBsaW51eC5pYm0uY29tPg0KPj4gLS0tDQo+PiAgIGJh
Y2tlbmRzL2lvbW11ZmQuYyB8IDMgKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvaW9tbXVmZC5jIGIvYmFja2VuZHMv
aW9tbXVmZC5jDQo+PiBpbmRleCBlY2Y0Y2FlZTFhOC4uYmIzMjE5NzY3ZjAgMTAwNjQ0DQo+PiAt
LS0gYS9iYWNrZW5kcy9pb21tdWZkLmMNCj4+ICsrKyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4g
QEAgLTcyLDYgKzcyLDkgQEAgc3RhdGljIGJvb2wNCj5pb21tdWZkX2JhY2tlbmRfcHJlcGFyZV9k
ZWxldGUoVXNlckNyZWF0YWJsZSAqdWMsIEVycm9yICoqZXJycCkNCj4+ICAgICAgICAgICAgICAg
ICAgICAgIG9iamVjdF9nZXRfY2Fub25pY2FsX3BhdGhfY29tcG9uZW50KE9CSkVDVCh1YykpLCBi
ZS0NCj4+dXNlcnMpOw0KPj4gICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICAgICAgIH0NCj4+
ICsgICAgaWYgKCFiZS0+b3duZWQpIHsNCj4+ICsgICAgICAgIGNwcl9kZWxldGVfZmQoaW9tbXVm
ZF9mZF9uYW1lKGJlKSwgMCk7DQo+PiArICAgIH0NCj4+ICAgICAgIHJldHVybiB0cnVlOw0KPj4g
ICB9DQo+Pg0KDQo=

