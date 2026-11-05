Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC77606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nsvDGZxB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2VI-0001fI-VD; Thu, 05 Nov 2026 13:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xP2VH-0001f0-DZ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:48:03 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xP2VF-0002Jy-5K
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793904481; x=1825440481;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fZLstZuBvg9zHS24fQiARprYPJ+SBiwKtg25GEYOWcY=;
 b=nsvDGZxBG/CRu/UZwN5trnkh8QW2VWt5QOgzLP8G8nonHlZ2ijqvxNoM
 D2q0XdRl0tKl24hfeY0ptCPUi+xmBgFHkg7WFHac+6Yw9kBlHmve4MbhM
 2RQDJ60QHs679WtSm6QeIJlpN3TdN+K6syBSZd1B0NzVCUxXa8/0Q4m4p
 UTvj4YabPsrC1X94FpLyPTPDNBEV9fStGoFZaz9wZ4Cq1M7iNBoFX6mjY
 kSsyfVmZbXwaL213L0lpcl9tZkcOPOUvXsbhxcASglLadSL33PBSr+fgL
 jvq793nN6e2BScTyLx9dqni1O2qnpHgXoSsV1ieX1zgtqKfiwv0+din2n A==;
X-CSE-ConnectionGUID: PsjcldP7Sc6nE+rJG80+5w==
X-CSE-MsgGUID: uvTRY1l4SD+v3gPZUCJg8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2798304"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2798304"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 10:47:55 -0800
X-CSE-ConnectionGUID: ob4DkKTRQcC+k5nyl83xmA==
X-CSE-MsgGUID: 5vti5s/hQGiQPiG2fjD3Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6912796"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 10:47:55 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:47:54 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 10:47:54 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.27)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:47:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeoFBeJs92PusqbDeLFSZxxIuFPjEb5AQt0QxlPH0wDprYL9LyF1UdsxEBrBrUipx5QWnHhlGUQzDp0ztgmfTwBw0K8tGjVyjEW7bEGycU/DaAA/1lO1NNb+Z+sN0bCU/1dpfp2t/lc+JcfrZzyUQ/M8qbkaEOzRno0Of+V5baPVGeZTfQ5FC/KIxJ562neKbStmBCP9jFNswfKRedmsfDpTyeJd5z6ncsK1TI2NXk1lfuQ3jsVS4YYjuTMNPG2KuPX48Nrh4XdkysIuiTQcgP7EgRTE1MNtNw11tnlRuxPEZnivgJn4UFsJm8McByRDCGjZosYj0Gh2XrrGU3Rymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZLstZuBvg9zHS24fQiARprYPJ+SBiwKtg25GEYOWcY=;
 b=spJd3b+iJ3FXSCmvUThc0FssQo0WlmDYoWzEnSCKnvNRt8rr/7NIbogdBO5SFSkaNXaMVfzJdadkspq4vB267v5mlExuweh29ijtWSIDHVMEUl44CF2iNpYvmTwMsCFvdbOsPmWdivtaqJgZlB4R7AZFEQxqR49Lgy9aoRX4gi1vY6MXx/957Cr12kOOyMRyLzm6ZnPGiBnKumlJLp+S4MGkNVGYwj+UEgCj/1LztFSaqKIm3JsvvP9CG2FlhQlVSk59IFAlfcTJloB797W+uc0Tefz/Iu+KucBATOVjPw6OhEvVkfgg72Hbd+rAew21SzpPMLCahC9jl0A5AdwdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from AT6PR11MB935162.namprd11.prod.outlook.com
 (2603:10b6:170:113::14) by LV2PR11MB157405.namprd11.prod.outlook.com
 (2603:10b6:408:414::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:47:47 +0000
Received: from AT6PR11MB935162.namprd11.prod.outlook.com
 ([fe80::863b:fd5b:d460:3af1]) by AT6PR11MB935162.namprd11.prod.outlook.com
 ([fe80::863b:fd5b:d460:3af1%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:47:47 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Kim, Dongwon"
 <dongwon.kim@intel.com>
Subject: RE: [PATCH v4 0/3] ui/gtk: Hotkey and fullscreen handling fixes
Thread-Topic: [PATCH v4 0/3] ui/gtk: Hotkey and fullscreen handling fixes
Thread-Index: AQHdZP86+rFyLgST6E6opoV3mZYK2rcf4kCQ
Date: Thu, 5 Nov 2026 18:47:47 +0000
Message-ID: <AT6PR11MB93516244D8881A89A8045F0212FA772@AT6PR11MB935162.namprd11.prod.outlook.com>
References: <20261025-gtk-ui-v4-v4-0-6cf2b6ffeb55@intel.com>
In-Reply-To: <20261025-gtk-ui-v4-v4-0-6cf2b6ffeb55@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AT6PR11MB935162:EE_|LV2PR11MB157405:EE_
x-ms-office365-filtering-correlation-id: 1cd9a07b-a8a2-43ce-b583-08df3b6d493e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|18002099003|22082099003|3023799007|10067099003|38070700021|5023799004|56012099006|11063799006|261028144727099003|261022105027099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003;
x-microsoft-antispam-message-info: jqZSWtn4eeRzwXn0ml18CHEr/onBXnJ21rF1KId6NA1jcL1JLAcnca8alUlRDCOg6Uo1vMrbmSVt4P8is8wZiHce0Gk9jrSjmLpiT3o9RMzbznTQhkEW+XeiKkrb4ztwYhwMKymCA+xkLz1y+1J6Dx/WEoZ+jxblWeQn7+KVAymgmwxDaGxFddHPmx76m+KBQc7iD5Iph5HHDl7KXeFmlU+sKzjdbmGQkBGF9EXK6KdE5ICpQsST+hpJWyAMnRCwqwixnprR3lgC6D5WiiLy3fa3Q16wGa8m7r5rEObRnHHeWGaBH2eNPqMzrGA0MSmxrRm4JLuxut8pOaslKc1KDGE7nofWcCw3WArj4llHYZy3cMcjQ/LGVjqN5GbSHtBjG3clTu/qhA0OyuPHWNUdKWUaOKugUmmaw0BL+XvAlVQ5TYOuP5+qxELhzLFwKZXVzAwKda03es2gPAJa4g6L59viUStfDFrLD9IU5aXcMZXSD0HJHgHN/xDqV9J9gs5Ud8WjG4lg4SPPnbonXtCVdX3qojxTTuPjoQyoSglVb0NblZPzogQM/66UN/MiKsTs6fpwnIdixYG25kyL4fRSLpR+0sO41B6mh1IKmZuFRW/ZRAfhcHyxP23oSTAkeSiRSO1Ndca2SkWKwSTVlmFqdlTqXt7QN3r5Uo0N5DYq7EBkN6CUEClqVZ1NtgaAcwPFlwMhfefnLDTv8k08q4RrH/DHAvPATzONS4HPa1dRwMs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AT6PR11MB935162.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(38070700021)(5023799004)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2pWL0lDbDR3VTE4VVhZMXExK2dSaWFHcVhIbU9hSDlNMVZkaHBROFRsWElZ?=
 =?utf-8?B?eTIzbXZSSEhaMm5BK1VWdk4rcVIraVpLc3JYRFdzVm14YXFBU3orV3ZmSWxm?=
 =?utf-8?B?RGtFNHBtYTJLa3ZrRkluN2xMSEVUZlBlRDBlSjFtM05SRlpjdjJ1SFlnZmEx?=
 =?utf-8?B?UmdxTWlWak5ZaTFRVXgzMnJaN2h3amdOeG5LNisyNldKS3FFNGxIMi84MlJq?=
 =?utf-8?B?cWxUazZiMUxSbDJXN0lTajA1R2tSSzAzaFFYL3VTMlh1NXlvWkdRVUJmdWV3?=
 =?utf-8?B?WGppbi8zK3RTLzQ3QzNvenlFTzJGeDR5WUhTanJ1VVd2QUc5VG9ZVDM4YW9S?=
 =?utf-8?B?RWxtaGwyeC9aNm05ZGlMejhBSUw5VWxMT2NZc3V2OC9oUEE2UnBOZXlOejV6?=
 =?utf-8?B?N29mZUplbUV1QkgwVnYrMWNOem0rL3BXaXAxRHo5MldmSGFQSy83WDNpQTdK?=
 =?utf-8?B?K2x3Y1ptSzRTSmtSRjd4VkQ5b3JwTFpjWnlIWXF3emo2Nm1oL24zWlVubURT?=
 =?utf-8?B?anEwNzdyU3VONjE0enhTcXhNZEJWTW9MRElVQzd6cjN4d2xmRkJVbS9tZGJM?=
 =?utf-8?B?MmRZSDEySG93alVabERISEF4c0hVTHF2cEI0YklNZ0xONUl4c0ppMFRTNGNQ?=
 =?utf-8?B?bHVHb0xack9rdHBtRmovQmFLVTF6Mzd3Z3phZ1ZSdys1LytKZnNwOG1mcGJx?=
 =?utf-8?B?dlJTVUN6WWNNc2xYalFBeU0zaXhBSnNNU3haYjFicEY1S2VGVzBicGFMVE50?=
 =?utf-8?B?UW80MldqS0hvem1ycjQ4dFRwVVlKZDk1OTQ0aGNFRzNJd1NRM3JDb0dwN2lC?=
 =?utf-8?B?bkNhQ0x6dW0zSERjc3NiZzFhRWFNODlLTW5ncUdzUjVkMGNNNU5RU3N6NTJJ?=
 =?utf-8?B?Q0UrdlBRdkxybmIrTUpqU1c3eHUvaWthZlIrUmpMaEExcUZEVHd5VEVOcFVD?=
 =?utf-8?B?aE0wSDZCQ3pscmw2OU5hQkRzb3BVWlU0eTZhTXNCUnoxUDRuWFRXQnE5QnFj?=
 =?utf-8?B?Ri9Ud0F4am14RUcyczQraWVHM2tpZEk2YnBscmZ1YXJHSEU2OU0yTmw5S3FU?=
 =?utf-8?B?N3k5RTd3WWRSam51ZDBWR0wzeHdsWm9QKzhMT2RQbXF0eEE5VTlTTGpLMGRu?=
 =?utf-8?B?UnIvQmZRcmZyYndENGNmYXoyYzRxNUlJODJTWnduV2c3MTBKNkJMd1BpcTJT?=
 =?utf-8?B?WUp2UGc0RHM3ckRQT3N6dEtLUDVWUjBtVjhzZFI4UFlveE5mNEtoS0lDbEVY?=
 =?utf-8?B?elNtckViZXpqTTF5ZnFRTkV4TXJqNXdpM0lQM2VmdlI3Ykh3VUdRT2dyWjhw?=
 =?utf-8?B?ekNuVUVTemJCZ0VwWC8reFFOVTl6SHI2cmdZdFRtYW5KMFo5b3JEcUs1NXYv?=
 =?utf-8?B?OUN5YzA0bUtmVE1TQjFRSWtVVnoySXVsOFlqdHR6OVVucTVxT3MxNXQ1MTZV?=
 =?utf-8?B?MlVnTDc3MFJyVnVKRjMrRGovbzRKaHA4dlBiK0h3NVlSM3k0Y3ZSbjNiVXZi?=
 =?utf-8?B?VUhMdnhwc1FZWE9CYWpFMTc1cnI3MUlNQUtENktjeGMrNjhQWXRsMjNZMHV2?=
 =?utf-8?B?SE5lK0NMNGlyL2lTL2M1V043MjE4RDlqYnJJVUtic0NUTElwVGNSQ1g4V0Vq?=
 =?utf-8?B?Z1NhTXVQbWZlQXZzWUtJUVNDbjF6cTFKTllSUWx0b2crY08rU2J3bWlYaGpl?=
 =?utf-8?B?UGE3MVM0aUhia1orbVNUS3ppdlplMnc4ZWhXVjJEYkplM0ZWazgwclhMT1cr?=
 =?utf-8?B?OEZDNUlLZlFYS2hwZ25FQWVFVHhOMnkwOGNBRmwxSTBHM0l4OHNXNFg1SEhr?=
 =?utf-8?B?RDY3Y29TU2J2M0dkZldYK0lCaDNXcW9CSlYrRG9mQ2JHOXplWDVheVoraGla?=
 =?utf-8?B?WnF3Tnl2VU1QRHRhR0pmd0hjL2xVRG9CRjVvek5NeU1FTW1waWJCSWlqZmRD?=
 =?utf-8?B?cVVVSjE2eDVJZ1Y5TjFkRFdvdHhMS0cxcjllTjV4cEx6bzhvZk1yWnJodmNw?=
 =?utf-8?B?QmIrQ0NvZ3hHMXVoU1NqUk9PZTk5bmUzZzJRcFU5VWNYT1ltdmZ4M2hWK0cz?=
 =?utf-8?B?aWpYQ2IvYlhKeldxVHYxcFJFMDgrOENPWFVXU0V4ejZ6RWZpQnRMRjZ0V3Fx?=
 =?utf-8?B?bU1acHUyaXI3NG9ySlNHUm1MejIwUWt4VEd6OHczdXEvNjZzVmkvWVd4Mlo1?=
 =?utf-8?B?M1pZdjR5VFIzT2drYnd4eGpUREQ1a3I2SktTM01jRkR3aEdFbzhKWGY2NU1V?=
 =?utf-8?B?cy8vSFNpMGZQMDZXWXlvZDdjZWpPcTFkek5lVE5MbmpuWjNDclJnaVRaVDRO?=
 =?utf-8?Q?ESo3YaYNJVRgWwDYaz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5lGsQYRCxAorYpyselnfm/9wAMufQAOcCx67MwBnwzm00qRHvwcA2NjJVu7Z9DhULm2jGUJzgY7QPBkb+81KPLaTulfdHrxk4U47uk+dT3u5JIKEXjwH7/OvN1b89TvIyf3TrPrHBVUFmYq7xRRllClYIhvahcvEw1wS5ornAVV+6Y+tbb2ZAyi6m2o/dQlZOAl2U/TOega8j/4unfGUFTCuDXn1SC8j47A1rdnl+O2/TbpTUJFaYhKcOAHsYkXJNG/ICpLIrqb6MswLliQEwtCzKjJs0FKyqVAskjifpQv7eU5Ms8n6wVMlSYvqQwsdz8dcy4EcO2BQ9yybnOSmrg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AT6PR11MB935162.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd9a07b-a8a2-43ce-b583-08df3b6d493e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 18:47:47.6080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mec8Wb9B5z+TSePoorWBFw3bOa78inKot4SIfNFS6vjXC5BlL3Usr1UoL2xqm7WqprkUaZfu66IJl+khb+JekQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB157405
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
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

SGkgTWFyYy1BbmRyw6ksDQoNCkp1c3QgYSBmcmllbmRseSBwaW5nIG9uIHRoaXMgc2VyaWVzIHdo
ZW5ldmVyIHlvdSBnZXQgYSBjaGFuY2UgdG8gdGFrZSBhIGxvb2suDQoNClRoYW5rcyENCkRXDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcWVtdS1kZXZlbC1ib3VuY2Vz
K3FlbXUtZGV2ZWw9YXJjaGl2ZXIua2VybmVsLm9yZ0Bub25nbnUub3JnDQo+IDxxZW11LWRldmVs
LWJvdW5jZXMrcWVtdS1kZXZlbD1hcmNoaXZlci5rZXJuZWwub3JnQG5vbmdudS5vcmc+IE9uDQo+
IEJlaGFsZiBPZiBEb25nd29uIEtpbQ0KPiBTZW50OiBTdW5kYXksIE9jdG9iZXIgMjUsIDIwMjYg
OTowNSBQTQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBNYXJjLUFuZHLDqSBM
dXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT47IERvbmd3b24gS2ltDQo+IDxkb25n
d29uLmtpbUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2NCAwLzNdIHVpL2d0azogSG90
a2V5IGFuZCBmdWxsc2NyZWVuIGhhbmRsaW5nIGZpeGVzDQo+IA0KPiBUaGlzIHNlcmllcyByZXNv
bHZlcyBzZXZlcmFsIGlzc3VlcyByZWdhcmRpbmcga2V5Ym9hcmQgc2hvcnRjdXRzIGFuZCBmdWxs
c2NyZWVuDQo+IGJlaGF2aW9yIGluIHRoZSBRRU1VIEdUSyBVSS4NCj4gDQo+ICAxLiBEZXRhY2hl
ZCAodW50YWJpZmllZCkgd2luZG93cyBwcm9wZXJseSBzdXBwb3J0IGZ1bGxzY3JlZW4gYW5kIHpv
b20NCj4gICAgIGFjY2VsZXJhdG9ycy4NCj4gIDIuIFRoZSAiR3JhYiBJbnB1dCIgYWNjZWxlcmF0
b3IgcmVtYWlucyBmdW5jdGlvbmFsIGluIGZ1bGxzY3JlZW4gbW9kZSB3aGVuDQo+ICAgICB0aGUg
bWVudWJhciBpcyBoaWRkZW4uDQo+ICAzLiBJbml0aWFsIGZ1bGxzY3JlZW4gc2V0dXAgaXMgZGVm
ZXJyZWQgdW50aWwgdGhlIHdpbmRvdyBpcyBwcm9wZXJseQ0KPiAgICAgcmVhbGl6ZWQgdG8gYXZv
aWQgZGlzcGxheSBjb25maWd1cmF0aW9uIHJhY2UgY29uZGl0aW9ucy4NCj4gDQo+IHYyOg0KPiAg
LSBSZXR1cm4gVFJVRSBpbiBhY2NlbGVyYXRvciBjYWxsYmFja3MgKGdkX2FjY2VsX2dyYWJfaW5w
dXQsIGdkX3dpbl8qKSB0bw0KPiAgICBjb21wbHkgd2l0aCB0aGUgR3RrQWNjZWxHcm91cEFjdGl2
YXRlIHByb3RvdHlwZS4NCj4gIC0gUmVzdG9yZSBzY2FsZSB0byBwcmVmZXJyZWRfc2NhbGUgYW5k
IHRyaWdnZXIgZ2RfdXBkYXRlX2N1cnNvcigpIG9uDQo+ICAgIGZ1bGxzY3JlZW4gZXhpdC4NCj4g
IC0gRGVkdXBsaWNhdGUgem9vbSBoYW5kbGluZyBieSBzaGFyaW5nIGdkX3dpbl96b29tXyogYWNy
b3NzIG1lbnUNCj4gYWN0aW9ucy4NCj4gIC0gR3VhcmQgem9vbSBoZWxwZXJzIGFnYWluc3QgTlVM
TCAvIG5vbi1HRlggY29uc29sZXMuDQo+ICAtIFJlbW92ZSBsZWZ0b3ZlciBkZWJ1ZyBmcHJpbnRm
IGluIGdkX3dpbl9ncmFiLg0KPiANCj4gdjM6DQo+ICAtIEFkZCBnZF9pc19mdWxsX3NjcmVlbigp
IHRvIHF1ZXJ5IEdka1dpbmRvd1N0YXRlIGRpcmVjdGx5IGFuZCByZXBsYWNlDQo+ICAgIHMtPmZ1
bGxfc2NyZWVuIGNoZWNrcyBhY3Jvc3MgYXR0YWNoZWQgYW5kIGRldGFjaGVkIGNvbnNvbGVzDQo+
ICAtIEtlZXAgem9vbV9maXRfaXRlbSBkZWFjdGl2YXRpb24gaW4gZ2RfbWVudV96b29tXyogd2hp
bGUga2VlcGluZw0KPiAgICBnZF93aW5fem9vbV8qIGZvY3VzZWQgb24gcGVyLVZDIHNjYWxpbmcN
Cj4gIC0gUmVzdHJpY3QgZ2xvYmFsIGZyZWVfc2NhbGUgaGFuZGxpbmcgdG8gYXR0YWNoZWQgY29u
c29sZXMgc28gZGV0YWNoZWQNCj4gICAgd2luZG93IGdlb21ldHJ5IGlzIG5vdCBvdmVycmlkZGVu
DQo+ICAtIFVzZSBnZF9pc19mdWxsX3NjcmVlbiBmb3IgZnVsbF9zY3JlZW4gY2hlY2sgaW4gZ2Rf
d2luZG93X21hcF9ldmVudA0KPiANCj4gdjQ6IFJlc2VuZCBmdWxsIHNlcmllcyB3aXRoIGNvbnNp
c3RlbnQgcGF0Y2ggdmVyc2lvbmluZyB0YWdzDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEb25nd29u
IEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiAtLS0NCj4gRG9uZ3dvbiBLaW0gKDMpOg0K
PiAgICAgICB1aS9ndGs6IEVuYWJsZSBmdWxsc2NyZWVuIGFuZCB6b29tIGhvdGtleXMgZm9yIGRl
dGFjaGVkIHdpbmRvd3MNCj4gICAgICAgdWkvZ3RrOiBSZWdpc3RlciAiR3JhYiBJbnB1dCIgc2hv
cnRjdXQgdG8gYWNjZWxfZ3JvdXANCj4gICAgICAgdWkvZ3RrOiBEZWZlciBpbml0aWFsIGZ1bGxz
Y3JlZW4gYWN0aXZhdGlvbiB1bnRpbCB3aW5kb3cgaXMgbWFwcGVkDQo+IA0KPiAgaW5jbHVkZS91
aS9ndGsuaCB8ICAgMiAtDQo+ICB1aS9ndGsuYyAgICAgICAgIHwgMjIzICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gLS0tDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDE3MCBpbnNlcnRpb25zKCspLCA1NSBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJh
c2UtY29tbWl0OiBkNzMxNDkyODMyMDU2NDU2MjViZmE5ZmUwMjljZmI2OGU0YzRhOWFlDQo+IGNo
YW5nZS1pZDogMjAyNjEwMjUtZ3RrLXVpLXY0LTBmYzMyODk5NmYxOA0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiAtLQ0KPiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiANCj4g
DQoNCg==

