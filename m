Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01517606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fNu9ZXNG;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=QcVgh8fG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjyJ-00084y-UL; Tue, 24 Nov 2026 01:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xVjyE-00081m-Kk
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 01:25:39 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xVjyB-0006wn-OG
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 01:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501536; x=1827037536;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XSs6znTiX52bMNlU7uSSGLGd5Mz5cfBFS+0Y+xpeFpQ=;
 b=fNu9ZXNGF/DCC3vQalidkmL5UMw83NpnoSttRcJ8BHfabnbbPP/5O/Y+
 2M6cesc2sosH4UppBn+iWj/t6s9+mbmucGcpNZ/Nu4yWF7F5lQ1HgORMS
 P0Aab8WOUe7bgd5eEfg8k1rjiq6Y9a8IAG6UoyJsCUsclael7xRJ/tzTF
 HD9tv7lux9K1YtjL52+uBzX0HLgmcfabsG6NgpXYzjnbC8kbE9ii1PIXf
 2P9QRu0mlkhbXoovxqJac0Owk4zG3RWikpM7WV7zdyvSjhpIBKaC7Hwjl
 /pzk+66X0VunsQBj4w3vW6Xkwj0Vaib7PMlmAIxiPDy8K7XqxS5Xot3v5 g==;
X-CSE-ConnectionGUID: JKuu8ronQNeTIsNySfJPDQ==
X-CSE-MsgGUID: EZ9j1E9NQc+nA2uBxG9rqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4364793"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4364793"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:23:23 -0800
X-CSE-ConnectionGUID: vhwtRsJLQv697uJ1llOopQ==
X-CSE-MsgGUID: phhIkuDwRmW0vbqnomwnGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11906669"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:23:23 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 22:23:22 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 22:23:22 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 22:23:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3rkajPfoQgmjROcNedS5WWVSavq2G9mz1w8Eyr8KdukkaX5geW7HCD9oniYxVxr6iXmpvqIeQr62G4PgXTwmyBM8czVEoeRZrI8XUrjxwFzoMVDuZSxmlEcQ7/xtBbbawprhr91FdJt1k7J9RNqLJiPM99O5LDw/mhfSdVV6luRqx8MFHt8A4MrMfMvNzPYT32Oq0MBi8tF5AsYeuejr6lugxln+fuO9+J2zcD9NbE6ZL7eRaNwvdg/b/dX5MMT2qenvRDPWEPXguDiv7ipiaCBaNN7WyJlFdW9qW+v0MNjIZX7xjO/YtLWGJ5hhjKnea7tOpsf+aJ9rXG9mb3gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSs6znTiX52bMNlU7uSSGLGd5Mz5cfBFS+0Y+xpeFpQ=;
 b=cjiy2/ZrBHTVg1n3wc0JkjmUGVSHVJtwnJIf7jG26/lHQ4qAduNruuWGdu5cClqMaQ7YlvFi6y2//Qpn1lNTDyQwzUxavU3iRXfXb1lUJJPjuEJZxBFjfx7hnnF+3tsylycTVmV9fFSZSykbqPx2H16mVbrhKFXl4cCfvpp30X1eUK6JjrKQ9s7tqInhZSoLBsytidkDmHH5MLtVTD/jK9E/UKJjU9Y2o35UBSpY+jw00blnFpmM/hbilRXtQkEVq8KtwNL4kky1EMRLf8WFtlNx7qurseQ4JGyLpd8zM5of6aNYWmhUQyNCqKXgI2YJcmXzdtmWGnCD0FL3ZomGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSs6znTiX52bMNlU7uSSGLGd5Mz5cfBFS+0Y+xpeFpQ=;
 b=QcVgh8fGhDSf2XaVF8plcrJBdzE4y4/aojNEGabYrT827byuUIsaLKLYMdBtWOg3XOnKm4/XVLSGmNneXyIYAsyw7MWTlTqDhG7Kl570q0i9MFWUYwDLRMFRKusxdrSESUbMxM278S8ONbIMKjIc/R+0hICy+CJEvLGE5r631Sg=
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH8PR11MB9748.namprd11.prod.outlook.com (2603:10b6:510:3a2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 06:23:14 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 06:23:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [PATCH] git: Fix broken relative symlinks for Claude and Gemini
 skills
Thread-Topic: [PATCH] git: Fix broken relative symlinks for Claude and Gemini
 skills
Thread-Index: AQHdey0GHci1DCn7VU6vUbqyUsMeaLc7argAgAA7eICAAAJAAIABEzbA
Date: Tue, 24 Nov 2026 06:23:13 +0000
Message-ID: <IA3PR11MB91366BFAD05ABBB6FE0413CF92442@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20261123092817.1237214-1-zhenzhong.duan@intel.com>
 <awQNLBquRToihQJV@redhat.com>
 <47428c0f-34a5-4cb4-991a-e1d5d8bbdfd1@oss.qualcomm.com>
 <awRA8q1X-GmogMQf@redhat.com>
In-Reply-To: <awRA8q1X-GmogMQf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH8PR11MB9748:EE_
x-ms-office365-filtering-correlation-id: c2250c8a-bf5a-47cb-91f8-08df49f36b68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261026140227099003|261022075727099003|261026121527099003|261028144727099003|56012099006|4143699003|10067099003|38070700021|11063799006;
x-microsoft-antispam-message-info: qw8VgrHJQAQkW/2slkKwNUWEONP55vYpc0B5KpwyqbA88PRyoXZ6cwKLGTQkOPyzqL5ygB0qf5xdxtWD0GNLUKXZkM5/xPU40NGctAtHjOki1KuTOJvhsucuspLZtT0F772Avwi35sbr4tXi4JFpx30Sx0krnZiOPkndN2rFDTemUwLmPYRSCqNPsNoL8r9+dDzn6Mdg/LdCenjhLOegsthYMf65rebClO9928lM4cQUalTrB0772G2CpR57OE58B+wIrYPEnFynExfa+9VRptY+r1plmwnSjg0R+i/H1oZfQJr4thGEDKtkvdYcd7C/vcEUfcSYodZ5r8Yq3MG85+B2g4qrI9BaK3X4gbMQxeou6i9GkCVwRytEdsEYhJAe/uJDsTFFL7gGKpDVPGiE8G0QkIfT5TPCri1sNbRmtYaHE0G06ReuATEf05WAc/oVCNZhZccL5HiS9hhLTNQ1eKNqHweP/jTRJaWIvnEye3Rnsq/xwvTuVTodIo4u7cQ0B3qOSlL4GOWDeC118X92IanOqRVECGsMrgl5iMZygVf5tpj5ky3+dZ/DgiU1dYgHshyutpmz6H1bqE7+vrPdRZNg31cy0FBYklY5aE7uulUwKkopL1zfHpYuvzSdDNEcr5cNTJ8SRxZ4ia/lzjA8nuQj3OxcHvMwgO40/gV/vHo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026140227099003)(261022075727099003)(261026121527099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVo2ejRqMjdiTElVeFVhYjJ0WWk0bStsWFlkRFd2L0MvbnMyamlwWDdla2dQ?=
 =?utf-8?B?andtNWJPNGQvNVJpSmhuS1ZUYzdKTkhOSTJLd2VwTDFNVnpKLzZ2UTRNY00v?=
 =?utf-8?B?UlVoMzYvN1dPUnAvbDIvekRnMHIwUFRwWGxTdVBGNWFMdXd6SldRRTMrM2xy?=
 =?utf-8?B?OVRSekx5Y1NJNXFEMWVJRFFZbTFsdm5jQ2U1MDBUcDJaWE9vc1FRRWQ3TTcz?=
 =?utf-8?B?MkEwVnp2cHRkQnZpUVZaTXptZ0tJaUVGcWdjOGZBNUhKZEMzY1ZSdXBSbDFm?=
 =?utf-8?B?RmhsUFlEbWlJZnFNQkZtVkRYWW5SNE11TFZIT1NzRVl5TlpYTnNUWW5lRyti?=
 =?utf-8?B?SStxM0xlTStIcHo3V3VETS8rcHFFSWZpbnBzMmNwUlBELzdWSGtTYnFZcCtX?=
 =?utf-8?B?a0o4S0VQcmUzOTN4VEFwbFp5V1l5SzJjRUNnTkJaL1FoaW41OWFMNGhISWtT?=
 =?utf-8?B?ZHN5TVlOQXlKLy85TmlicExZMGt4ZEFLa001MENYK1hkTWZLdFUycGttODhn?=
 =?utf-8?B?VitBWTlYQWlZT240WC85dG9iak5raUhRKzM0bVhzcUtpdk5XREd0ci8yQk9G?=
 =?utf-8?B?dEVXeTZxUnRiellXR0hOY0Q1QkFSRFB2WFY1QVorNXZUWHRMbERod3VRT1Ju?=
 =?utf-8?B?aTgzVSsxcjRTZVQyUHdVMGcrYWM2aStROEx1Wk9HanY5YUxWS3AvdHd6M3Ez?=
 =?utf-8?B?TkgyaXdmUTRTVFhDMkd3L1pmdG9IZDFUUEIybmxWUURXUlRpeUxwSmVZUG9k?=
 =?utf-8?B?NzlJeXRra2FoQm1jb3hTdEJVMS9xZVllbTNVeXJpeUNxZFlBVGFPMWQvTlZ5?=
 =?utf-8?B?OWxuZnFRTTh1UGRHVWxSTWFCbDBCSXUycUptU0RoaHBmUmxKWmNOVURRRkFO?=
 =?utf-8?B?VzlYZHBTV1FyWm5zMFpZZ0ZNZG9QTjZjYnF6Sm9RU1g2dUN0YjI0VEFOZ0Zj?=
 =?utf-8?B?MmVqOUgrRXpKUUMrYTA3a0FiTmNSL3h5OEVwaXN2VW9qQ21NTWFXVmxSaGsw?=
 =?utf-8?B?UkFVWFdlbFF4K2NiOVE1ek9kYUFobVhPUFpoK0Z0Um1JTUFyS0c2NCs2QXcy?=
 =?utf-8?B?YWIvSGZpOStBdStpbUhqVjFZVXFwU3NDUFJBcEk1V1V5dWdnTGcxVzd2Qjli?=
 =?utf-8?B?eUNoRHJZK05NK1E2ZFdTTFdBNzUrcUFIV2QyVm96azE2bjRzZmc4ZlU1Ui85?=
 =?utf-8?B?R3U4VENEbE9sRlZZVnhESS9TYytaZ1l6Wm92Y0xvR1NPTWV5WlpqTlRmUWZI?=
 =?utf-8?B?RWxJaDNtMTBlQ21UU0RGOUxlcDVoNFZjcmQxU2lvb0dvUGVVRkxVVCtUaUVj?=
 =?utf-8?B?WlBZb0dlUmFIK3hJbU1nd0oxNzFRMUJ4cWlXNDhNdmJlaytGRDZyb0FzaVoy?=
 =?utf-8?B?TlVtQ2c2UTI4NWZCdUJXUVpDdnNka2NKRFNxczFqWnYvOFJETmtYRUt1cGt3?=
 =?utf-8?B?QVc3K0dlM0xpWjdTbjhac3lqY0ZqZCtXRFAwdnhRZWtPTE1PNTdNVklBald5?=
 =?utf-8?B?ZW9QMWxFTEVjOTRuaU9OcTc2MWRQMWpRYTRaYkx2R1hyakFvMnZBdXlzR1Fo?=
 =?utf-8?B?TGM3cVRzd1hJQ09FbWlJNGtPVGEyU2RVd0hHYWhzbjkyVnVyYUY3TCtRcXhB?=
 =?utf-8?B?QVoxcEl4S3lsWU5XUHA1ZnFqd2hXWGkzcHRMREJoRFFlUmRyL0EvOHF3aU9u?=
 =?utf-8?B?SWJRVWV2RC9mcVdKR2RBancrOTNqc21ZZTcxZXJzVGdwTTU4ZFhMdmtoUXFa?=
 =?utf-8?B?ekUrQ01jQUxPR2pEUDAyTTkxWm81dTZlc2VDQ09id1pSYkZ4WnFGbUdWVnU5?=
 =?utf-8?B?dTJoRG13TU9SK0dtdklIN3d1dkhNbHdSU2xCTmV4N1FwUmFoaTFpajVWL0hu?=
 =?utf-8?B?N3o5aTF1bHJ3RVprSzZSdUdIcTBJcjN1dk16NXY4ZDlpaDFwbGk1b1l0cG5H?=
 =?utf-8?B?VUdENjFiaWNlTlZxZVJISzI3RXNMeUJIcG0rZi9aeENEdGdtZHNDMXZUeitq?=
 =?utf-8?B?dTZqYnZjRWlJbDMrQ0lRSFpvbXJleVRXVGNJOWZzZFJ2Z3l5eGdPclQyRVZE?=
 =?utf-8?B?cktMNWpGb09kNlByTHg1eTdjbllMTFl1MXlodUhhQXJqUXo1ekRhdW1iU3hT?=
 =?utf-8?B?N1gwR0duTDA2ZFNwbTFVYzZXUUIvck9IODBHVTBnNlVoU3NrVU51YzBCRStk?=
 =?utf-8?B?aWVsY3FocW1OMW4rZVBOVzZobmphMy9MYzdwdGZURHg0cE5XU29BeUpRL0gr?=
 =?utf-8?B?a0VlNDdLUGx6V0c5cHhkM211WmIrT3BJN2RSM0VnVG85VnNEMEswbU1pTWRV?=
 =?utf-8?B?R2ZUTjBSYUl0YThqSEVQOGpreDBKdTdzUmQ5M1VZV0lkOVg1K0t0UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IQMMCSkrAyvnNEIwOa/BBYqaJsANiNv1n0GxfyUz3x5Lc/zBC9GBy7IGBMiiTG9YrTph362vZ32ZwnOMEA4IadSCxPT3XHo5pm2LYDGFa6HkxIUg4SBfoZfK74Hab5LhdZfhqMsbNwrHaK7VMQN5dczH8yH8u/bISUAvKPnf3ZE+qmewjhoBGlwwgP1+jT0E6JzTSCjJ86wWRHXOKV+VoTRbTqEp2neyT3qo6+fImCFqNsJ50UqGUkwpM7RtJcepsUoRTm/djhV9THR6oOAg5vWYPL8sTxHMXgNw5+lSJowWCjLV95L8+s1T4XIGLCVHZhZs3y+YCs8C84iCMbVLmA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2250c8a-bf5a-47cb-91f8-08df49f36b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 06:23:13.7694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HkYfPJ7sg1bzskTs9ilz/Y3t6XAiPMR0dlE9RzM0ReSgPthkrJGX+TJhUIANvXtARQwN4fZlT8ivlpsL/QnjggctWZKvwhtCdrwtwJKlE1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9748
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhbmllbCBQLiBCZXJyYW5n
w6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZ2l0OiBGaXgg
YnJva2VuIHJlbGF0aXZlIHN5bWxpbmtzIGZvciBDbGF1ZGUgYW5kDQo+R2VtaW5pIHNraWxscw0K
Pg0KPk9uIE1vbiwgTm92IDIzLCAyMDI2IGF0IDAyOjI2OjM5UE0gKzAxMDAsIFBoaWxpcHBlIE1h
dGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4gT24gMjMvMTEvMjYgMTA6NTMsIERhbmllbCBQLiBCZXJy
YW5nw4PCqSB3cm90ZToNCj4+ID4gT24gTW9uLCBOb3YgMjMsIDIwMjYgYXQgMDU6Mjg6MTdQTSAr
MDgwMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiA+ID4gVXBkYXRlIHRoZSByZWxhdGl2ZSBz
eW1saW5rIHRhcmdldHMgZm9yIGJvdGggIi5jbGF1ZGUvc2tpbGxzIiBhbmQNCj4+ID4gPiAiLmdl
bWluaS9za2lsbHMiIGZyb20gIi5hZ2VudHMvc2tpbGxzLyIgdG8gIi4uLy5hZ2VudHMvc2tpbGxz
Ii4NCj4+ID4gPg0KPj4gPiA+IEZpeGVzOiAzZTlmZTA1N2FlMGIgKCJhZ2VudHM6IEFkZCBhIHNr
aWxsIGZvciBmaW5kaW5nIHlvdXIgd2F5IGFyb3VuZA0KPlFFTVUiKQ0KPj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiA+ID4g
LS0tDQo+PiA+ID4gICAuY2xhdWRlL3NraWxscyB8IDIgKy0NCj4+ID4gPiAgIC5nZW1pbmkvc2tp
bGxzIHwgMiArLQ0KPj4gPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+PiA+DQo+PiA+IEZZSSwgSSd2ZSBhbHNvIHNlbnQgdGhlIHNhbWUgZml4
IHNldmVyYWwgd2Vla3MgYWdvDQo+PiA+DQo+PiA+IGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNo
aXZlL2h0bWwvcWVtdS1kZXZlbC8yMDI2LTExL21zZzAyODAyLmh0bWwNCg0KT2gsIGdvb2QgdG8g
c2VlLCBJJ2xsIGRyb3AgbXkgcGF0Y2ggaW4gZmF2b3Igb2YgeW91cnMuDQoNCj4+DQo+PiBDYW4n
dCB3ZSBqdXN0IHJlbW92ZSB0aGVzZSBhbmQgbGV0IHRoZSBnZW5lcmljIC5hZ2VudHMvIHBhdGg/
DQo+DQo+SXQgc2VlbXMgbGlrZSBib3RoIGNsYXVkZSBhbmQgZ2VtaW5pIGhvbm91ciB0aGUgYWdl
bnQgc2tpbGxzDQo+c3RhbmRhcmQsIHNvIHllcywgLmFnZW50cyBvdWdodCB0byBiZSBhbGwgd2Ug
bmVlZCBBRkFJQ1QuDQoNCkkgYXNrZWQgQUksIGl0IHNheXM6DQoNCkV2ZW4gb24gdGhlIG5ld2Vz
dCBDbGF1ZGUgQ29kZSAobm93IDIuMS4zMzEpLCBDbGF1ZGUgQ29kZSBkb2Vzbid0IGxvYWQgc2tp
bGxzIGZyb20gLmFnZW50cy9za2lsbHMuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

