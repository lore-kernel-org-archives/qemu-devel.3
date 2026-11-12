Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FE606B24C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JESdgKLQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRQWH-0004pb-23; Thu, 12 Nov 2026 03:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xRQWE-0004op-Ag
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 03:50:54 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xRQWB-00010z-18
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 03:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794473451; x=1826009451;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rq0H/2TyOrdVrkerSN40/iH8rvEzFRqTaxmlPuc0wfE=;
 b=JESdgKLQwWMarfZ5knzaH40+bUqq1DfxsDhs0ATZ+X/rB2NTNFqiy967
 GCDMZhpHhwAdsqCjtSm7+enZ5OtLGGuqTErbFt+mK+CB/HyRtnK+kPlmS
 sikV90QlfR9mCXPmGVSToaUpaqCnBR5cLQpQU16ayxsDmM5unKIInorm3
 sx+sacw563gbFAAdbXyiY6tGYWuC3c4/JC/tteG65cwW2Mh1fi+JG2w9I
 HA+fop/HhqQBWdl6ZfBnyVv7X65yBMIQjig0MlxSThE2s3nuSmgu9prwc
 QiZO9SJZyVaGf8a8tiX+raqL9jvqkLMCncj/TkyuDrKigZzrGcbMMsfa9 w==;
X-CSE-ConnectionGUID: of39Gnz1Sy2kALuq8Lnigg==
X-CSE-MsgGUID: mgI2fSGBSw2Ym9YIZ6znVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3296722"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3296722"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 00:50:28 -0800
X-CSE-ConnectionGUID: vUOCDO9nTWGWBBIhszfrMg==
X-CSE-MsgGUID: HzOyFmcYRVSzkA+MPjFJKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8607916"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 00:50:28 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 00:50:27 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 00:50:27 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 00:50:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CH/rq5b2wfDHAbaHQ1APi47Z77KNKnvwGLWBMMT/FploB4iD6sEV6pfO05GHSnJeMYuZTKZMd2m2NPNZb/vgTw4TG768CJGTUuv+vK7cSLV+4mS0P33NK0fX35M9oI7iYP2N6o14wa4HjxQPxWs8x0irR0z8Hl1ueMwjcNzAWXIZTOkIxiIHsTd4Z5zH2hP1oUjtHp2UI/OpQTTdDbdjMaMqyVz/MyhXLbef0WAvpUnNAKrl9AzSYsmkLP3Bz8IatXcocf8A3gbR1nkfhzxw+8ugnqYjHyxp5+aeyHsZHlv0rcEzNy3PuGVnw5pzitpw4/PaMEZ94+8XaOyAGRN8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9OT5UYMEhVVzjSz7vApk7oAT1nd10i/DnDSEgntBvI=;
 b=EeVueTPQ8GjKJA51j5L2oFFWU5bsJMOn5rfd5u7axfWd81I3zxF5+KRlnqFsh17lBj1oe9bx2eR8d+H9tuP5snkMoVykf31tIGynoH0UsavsFSA0GjynVDl2cMcc4Op7xG1OgSu74Gm1aVh21WxHpzNY4PBtdnzgqw8vIy5x5ribL67E7ILnXPCu+OxQ/tD4MRKCfMzTCwli5IrzaKtMgDwOxqiBgldOwnY3bGbCIfFT+CtyVb31mFfXmRYg/QtdGj9GNE7paAb/QZiDj5/2HjOMF6jVP1r9i3MmU+Ldt9hRjeEGhg2xGitdFOU+6PLLWs1sW6vpDOJpNbpz3kt8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22)
 by DS0PR11MB8136.namprd11.prod.outlook.com (2603:10b6:8:159::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 08:50:18 +0000
Received: from DM6PR11MB4516.namprd11.prod.outlook.com
 ([fe80::8026:e12a:4db1:b672]) by DM6PR11MB4516.namprd11.prod.outlook.com
 ([fe80::8026:e12a:4db1:b672%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 08:50:18 +0000
Message-ID: <15c2a971-97fb-4d69-85cd-24f3251588d2@intel.com>
Date: Thu, 12 Nov 2026 16:58:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/22] migration/cpr: forbid saving duplicate CprFds
 into hash table
To: Eric Farman <farman@linux.ibm.com>, Omar Elghoul <oelghoul@linux.ibm.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, <qemu-devel@nongnu.org>
CC: <odaki@rsg.ci.i.u-tokyo.ac.jp>, <bchaney@akamai.com>, <mst@redhat.com>,
 <maciej.szmigiero@oracle.com>, <sgarzare@redhat.com>,
 <mark.kanda@oracle.com>, <vsementsov@yandex-team.ru>, <clg@redhat.com>,
 <den@openvz.org>, <dongli.zhang@oracle.com>, <farosas@suse.de>,
 <peterx@redhat.com>, <dwmw2@infradead.org>, <philmd@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <20261012-up-vsock-vhost-v5-v16-1-36c38bd15ffc@virtuozzo.com>
 <5b08d2f3-7edc-4525-95e4-ee6719acaf5b@linux.ibm.com>
 <c9d80c86-e9e3-4b9c-8d8e-5f4e0ed603a9@linux.ibm.com>
 <df977bf7-c951-49b2-a44e-7954373a0a93@linux.ibm.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <df977bf7-c951-49b2-a44e-7954373a0a93@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To DM6PR11MB4516.namprd11.prod.outlook.com
 (2603:10b6:5:2a5::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4516:EE_|DS0PR11MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 971a02a5-a873-4ff7-1fab-08df4099f9fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|6133799003|11063799006|4143699003|10067099003|261026140227099003|261028144727099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|56012099006|261009223027099003|261026121527099003|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: rOnsXL5iYZZrhTLagNT/0apFRuLWlE2GwgTG62LjhtoE3g1uQk+t5ksecEQ/X7AO80YySpRyb0VQEefXif6SAIyxeKUQI+7LxXm1S1ad9OLJbLLS4CSCyzeoGdzbYCzqPOllwyzOWcwTGL9iUcNn9G72M2dphP3D1sHqVHDUR2pALxBnV+6x8AcSXPHcP59T+vG08l3vYXaGM4yBGYSZV8+n3ovs9BRhB4pHSKJuxKU7873ouX6pBtnl0/a9pWcMpCuYODutoIMaZpDu85XYJuEDaKu60lrCRhMIb3bipAqJMhzWq5JXkMkQ7GsOVjkpV7EkbEqQ0A9lxcVgci/lEHURDkidAiYVlIhkFz/oSlfRb4h4p66Pisc/PFojnWB2qvSg6Fk57FZXuedkBeQbunfplOSFPzi/nIs6h11zsThD3elpT40IwTjghJj3aQXljf2mFVfyme1u2XuJLkxVYojMxKQGBtJ/0xDQDcJFU1+50TJOJ4Yzfmggs7lHFxGgaeDyRXvTHdr5rhKSjSYhg4HGuSCZHiz6Q3vrUNdNGC7umpwCXDKqDJNraQ0QHL1TAwQYViEITqvPTIKUCZFaCln/H0tyosVwfqB0OUalANaq8AvcOa9vfebIkU3wzrYw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB4516.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(10067099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(56012099006)(261009223027099003)(261026121527099003)(260925022911599003)(260925021311599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1hYSGVGZ0pTYkdSckIrVzBSQUZjSWdxT0ZxYjV5RnlyM0FPaE9JdDdQeVJZ?=
 =?utf-8?B?L25WOS9rN1BDYy9BWmRiY3lxRWdMTEFLZGU4QitNWWZyMG05cDMzREhaK013?=
 =?utf-8?B?UDF6OWowTmFrdHV6dUw0dS9oQlRqTndpYk5pbFlwamZGZXF2UkcwTi9WZFRE?=
 =?utf-8?B?SEo1ak9NY2dyVERoWjFaWkU4c2t1S0JSSEFZVnBLWmpxY3BmYWpySFNkRURp?=
 =?utf-8?B?NDk4OW5SWnk1VGlaTU52aytFOWExeVc4dUNiNWdtQll3V3VOc2IrVUhBcGJM?=
 =?utf-8?B?V1Z4N1JSb2FWQ0dyRVVJdGlrUXBacS8vQjcwRmh3TGlHcWlEbDNLNGVkREZj?=
 =?utf-8?B?LzFaZXJReE41ejl0VVNOdDJ4VE9mSGlYK2N1QTMzbUwzOFJYdzVWK3V3cmUv?=
 =?utf-8?B?T2pTMnN5STBxZStpWUhkNG9SclVaTDduTXBCOXVOZnNEU1hIMGE5cTk2K2E3?=
 =?utf-8?B?WkJNLzFidkRHd3dMR0ZUQmlldkwrc28xK2s2eUdnRy9tOHhNUWpUSUo1ekt5?=
 =?utf-8?B?YlB3NGliWHg0bXhORFBJVjByMzRnMDNMamdJRzJUd2k2Zmg5dzJCYzVBMVNr?=
 =?utf-8?B?UGMrTGNQOHdqUENSbXUzWWQ2MElNSTdnbDBCRXdiRFlWTStzeGxSOXpnRDkz?=
 =?utf-8?B?MHRyUkZDRDVCRFI0WHJXWUpKdkJkazZpWVFtZGRYZGNyMUpoRHl5R2pKTkNS?=
 =?utf-8?B?eHgwV0cxZDQxMVB5cjBBUjRGSVB6OFRkYllNK1E0VnpqUzUzNjd1NE5UcFRD?=
 =?utf-8?B?U0R6M3dCaTNCMHJ5UHZHMWVNTUtVLzB5ZGs0TWdRNUFDaUdWWnczMkVuc1ZE?=
 =?utf-8?B?TnhVTExFMGV5WDFSeVd1TVZpbEZVRFd4ZGxYeE9RelY0U3gxVkh4bGdQNE5Y?=
 =?utf-8?B?eE5aV09NWktEODh5MS9mREZKYndsa2ZuTFkrVDRFVlZweHBtNnFGR1E0ck1s?=
 =?utf-8?B?ZktRYlh3YzNnaWpVdXpuZWUzVk16M0Y5a3BSOE5Gdzhmdmh1KzNwS01MdWtW?=
 =?utf-8?B?QzZJOFV3YkZacW9hd09xSnNUSzNBOS9Yd0NnTlp0Nk5qMjhML0U3eXFVbGg3?=
 =?utf-8?B?Rkl6NlBReDdGU1ZORGNxbWVCaTFkZ0tTMjVrQVFjdFA4aVREYU9lVlhOb0Iv?=
 =?utf-8?B?dHp4UzRnaGtrNWkzYWMvZ01wYVZHemU5dHBJWndIOFFMbElsZzRnSXUzRGo4?=
 =?utf-8?B?eXNSdEE0cGpmOWJ0dzhyazhYVWxJMU5TMVR1TS8wSlQ0eU53ZU83Y0gzblhH?=
 =?utf-8?B?blFkOXg1blRQT3l3bDhiZVBiQzFkS2xnTkVnZDFObW12TnlOT1BNbXRSK2tz?=
 =?utf-8?B?TXVkczJLdGJOMXZ6TWpNYXpEZWFWWHltNnp0NVpSR09sZGp4bEF4VGwxZE9D?=
 =?utf-8?B?aUsvaUM3S1diWUdVOVhnZ3g1RExJZXY3TUNQT0QzTzFNNW5OK2ZPM09OMVVj?=
 =?utf-8?B?SjhhRGF4WklnZHJBM3V0U3Q2b3lFdm16Q1BTRmRMWkNhRkkwS0x0TlVZOURN?=
 =?utf-8?B?R2xuNHErUHhnd0V1ZXE5T21Ud3RzWHNMeUtjQzBuTHZnMzNGMVF2YzFTaW1q?=
 =?utf-8?B?RWQ5cnNHbWtTYktEbmxpdWI5NFQzUGw2c2k2SnF4QWFtamtpQTVNMUJBaGpF?=
 =?utf-8?B?UU5BR0VZRUlETmRuOW1kNE9OQU9ha1JXQm5zaTloT24yVEJJL2Y3MXdXdUdB?=
 =?utf-8?B?cWQ0dUFHZ2N0d0VyNkE4TG5XdDZSTEExeTBkbTFEK2x6Tk50NWhJaWQ4WDgx?=
 =?utf-8?B?SDZHNGFzNHJZUHV5Q3lqd0Vxa3NTMWVJVXpYbXNlVDR6TVNEdk13ZzZrZWZj?=
 =?utf-8?B?Rmo1OURIYlhFaklMMmxOOVVlbGpDc041WmtOUHpONy9lbTZndTVqOEJLUXpu?=
 =?utf-8?B?RkhDaDdNS3lvcTZMK1o1dng3WUhDWllQZUpqOUdCYTdkNTMvM01KTzJnV3dq?=
 =?utf-8?B?eXRJQVlnOG9PZUhhRWlheEozdlJMQTlYaTNvMGpvVDE5Z3Ryb0tEdkpsUEJx?=
 =?utf-8?B?ekcxMzgraFJNczFZZHpqWDN3dVVtRkZqVWlDT2dUNDd1bTViOEhQczJxUm9n?=
 =?utf-8?B?aFcwNnpOaE10cjZqU0drRUNIcjNYMzlYUktZRWVUNTF3YXNnRDJSanFkSTVP?=
 =?utf-8?B?NXJveG5zZnp6Vi94L2p5KzFjNWVJdVVPaVpycFJINzZKTFBYZXpHY0Y5dkla?=
 =?utf-8?B?YW94WDFmdnZDTFdMRkxLTDZLQVRwaWFVNW5xdlNUdzF2TjVhRUlJVlErMzA2?=
 =?utf-8?B?UjFTUlBOY053VTFoNm12cDd6TWt2d1ZESWlobzVDVEowMlFQVktzellNYlZQ?=
 =?utf-8?B?THBnR0tzTklmNTFBaVlqMk81Y0ljTXdoQWZsbm1PQWpLRXF0NVVsdz09?=
X-Exchange-RoutingPolicyChecked: 43n5aZtifpxxbiSuSpxw6IUKxcYQ6Vzg+fvqspbGag09K3W2a0Xi+CiUhC0ejQlEcPdK1ik/nhy13p3xjdOUbrCLiVobqGDI7HNvJZDjGKAzn9XDMPNdRrPvUXHs+jLb74T1hDLLSjFnpw7ky5I9NgSZyvDipA2yJZgfj4N13tnteh4SUl/F5MWXbVNnqLdIbRcCrD5SUiBZGEvUpJWAffustTr+fo84jLROXz6umNimmJAso81FIaMrR+InFodJoltgPfhnmhUTD70uIsqC85NgIuKEN6FdYS68c5orF0zWApICstwDf+OmIHV+Lf6P5lFjw/OzsGbdW7lemYKiPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 971a02a5-a873-4ff7-1fab-08df4099f9fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4516.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:50:18.1354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bapq7pAIcsgmacjdX+uDZO3zB/sAgvzsu0/gBT0RW+rzmPaP68ws6OhrMldC1PaxdWPREGwEuMzKCeOKJnP/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8136
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 13:04, Eric Farman wrote:
> 
> +cc iommufd maintainers
> 
> On 11/11/26 11:52 PM, Eric Farman wrote:
>>
>>
>> On 11/10/26 3:51 PM, Omar Elghoul wrote:
>>> On 10/12/26 6:28 AM, Andrey Drobyshev wrote:
>>>> In its current form, the mechanism for saving CPR FDs into hash table
>>>> has flaws.
>>>>
>>>> The CPR fd hash table uses the same CprFd for both key and value, and
>>>> is created with a key destroy function.  Inserting a second element
>>>> with the same (name, id) key leads to a use after free.  According to
>>>> GLib docs [1], g_hash_table_insert() keeps the old key, replaces the
>>>> value with the new element, and destroys the new key.  Thus when
>>>> inserting 2 CprFd elements fd1 and fd2 with equal keys we get:
>>>>
>>>>    g_hash_table_insert(table, fd1, fd1);  /* table has fd1 -> fd1 */
>>>>    g_hash_table_insert(table, fd2, fd2);  /* table has fd1 -> fd2, 
>>>> fd2 freed */
>>>>
>>>> Any subsequent cpr_find_fd() for that key then returns freed memory.
>>>>
>>>> This is reachable whenever two CPR-aware objects register fds under the
>>>> same name, and it happens long before an actual CPR, since 
>>>> cpr_save_fd()
>>>> is typically called from .realize(), i.e. at boot time.
>>>>
>>>> Apart from the UAF itself, when the user decides to perform CPR 
>>>> migration,
>>>> on CPR target we'd get corrupted FD from the hash table and fail 
>>>> somewhere
>>>> in .realize() for affected devices.
>>>>
>>>> As a solution, let's altogether prohibit adding CprFds with duplicate
>>>> keys.  Since FDs are being registered for a subsequent CPR right at the
>>>> startup in .realize(), that'll allow us to error out and exit QEMU (or
>>>> fail a device hotplug op) gracefully instead of delaying potential
>>>> problems for later.  To do so, let's make cpr_save_fd() return 'bool'
>>>> instead of 'void' and provide an 'errp' argument to it.  That way 
>>>> caller
>>>> becomes responsible for checking the return value and propagating the
>>>> error.
>>>>
>>>> Also update all the callers to use the adjusted interface to keep 
>>>> things
>>>> compilable and bisectable.
>>>>
>>>> [1] https://docs.gtk.org/glib/type_func.HashTable.insert.html
>>>>
>>>> Fixes: a181df93bb3 ("migration/cpr: use hashtable for cpr fds")
>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>
>>> Hi everyone, FYI we've recently run into a regression on s390x where if
>>> we have a KVM guest with a PCI passthrough device using iommufd and we
>>> hot-unplug the device, the guest becomes fully unresponsive. In the host
>>> dmesg, we can see this message right when the hang begins:
>>>
>>> [ 1618.849602] vfio-pci 0001:00:00.0: No device request channel
>>> registered, blocked until released by user
>>
>> It's worth pointing out that the new error message in this commit does 
>> indeed show up in the logs, and points to the problematic device fd:
>>
>> virtqemud[1172]: internal error: unable to execute QEMU command 
>> 'object- add': cpr fd 'iommufd0' id 0 is already registered
>> virtqemud[1172]: internal error: unable to execute QEMU command 
>> 'closefd': File descriptor named 'iommufd' not found
>> kernel: mlx5_vfio_pci 0004:00:00.0: No device request channel 
>> registered, blocked until released by user
>>
>>
>>>
>>> Bisecting qemu leads us to this patch:
>>>
>>> de80025348925ba9f56070ce4ec0a5a0c512d450 is the first 'bad' commit
>>> commit de80025348925ba9f56070ce4ec0a5a0c512d450
>>> Author: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> Date:   Mon Oct 12 13:28:09 2026 +0300
>>>
>>>      migration/cpr: forbid saving duplicate CprFds into hash table
>>>
>>> We tried to revert the commit to confirm the root cause, but then the
>>> master branch no longer compiles, so unfortunately we were not able to
>>> confirm that, at least without making many changes.
>>>
>>> We're wondering if you might have any ideas what's going on there, or
>>> what we could do to try and resolve this issue. Any thoughts would be
>>> much appreciated and I'd be happy to share more info if needed.
>>
>>
>> Since the routine that unregisters such an fd is cpr_delete_fd(), but 
>> that gets skipped as soon as we go through the _set_fd() path, I 
>> wonder if the solution starts as something like the following?
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index ecf4caee1a..d708948357 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -161,8 +161,8 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
>>       be->users--;
>>       if (!be->users) {
>>           vfio_iommufd_cpr_unregister_iommufd(be);
>> +        cpr_delete_fd(iommufd_fd_name(be), 0);
>>           if (be->owned) {
>> -            cpr_delete_fd(iommufd_fd_name(be), 0);
>>               close(be->fd);
>>               be->fd = -1;
>>           }
>>
>> What that means for the prepare_delete/finalize paths and/or the 
>> failure path in _connect is something else to ponder... Neither of 
>> those call cpr_delete_fd() themselves despite closing the fd if it 
>> owns the thing.

Hi Eric,

Agreed the iommufd0 duplicate-key error is real and your analysis is
self-consistent. One thought on the fix placement though:

iommufd_backend_disconnect()'s existing if (be->owned) guard around
cpr_delete_fd() mirrors the save side in connect() (be->owned && 
!be->users), both tied to be->users - that pairing is fine as-is. The actual
asymmetry is that for !be->owned backends, the save happens
unconditionally in complete(). So the matching delete seems like it
should go in finalize()/prepare_delete() instead.

The below hunk of commit de8002534892 indeed can result in req_trigger
being null. But I haven't yet figured out how the error path would be
triggered in that case.

--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -76,7 +76,10 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, 
EventNotifier *e,
      }

      fd = event_notifier_get_fd(e);
-    vfio_cpr_save_vector_fd(vdev, name, nr, fd);
+    if (!vfio_cpr_save_vector_fd(vdev, name, nr, fd, errp)) {
+        event_notifier_cleanup(e);
+        return false;
+    }
      return true;
  }


Regards,
Yi Liu



