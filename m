Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51521C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0js-0006qz-C1; Mon, 03 Jun 2024 02:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jf-0006in-Si
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:59 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jd-00071T-OS
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394398; x=1748930398;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ey8tYT5sCKUkGtrJEMnAddjrE5No915u2Azs6R/nCDY=;
 b=HsFrMHGgdnvktfB1HLPLErWMFZwvDXsvGfuFfdethNjKnN/9J6tpjXfH
 G8y2yIoLW7+LrMlzqcInX7i5zmFkJUp+DQJyiQqxGvh72tlLppmK7WruS
 RPvqo5+MqscxskVTR+HceHKQgCKkLkERADprSyghfvRdwvnZMS8/9OCNG
 Qy8Q3ZdQBXz3M5CGUo/lo7BkKIErQ8J9JA0Y3b37t31dc5CFOf9X8kmIQ
 UhE0Y0MZzrFUrfHDwBC6pVGuA9DhbyC5j5DLo9CRSNpEYqD37yYbLi8dM
 bDsVKwfNvylpyNlTx4OLiWC2cQ+a6EBS7DhqUpyJfAYyq59mWzyi0zUJz Q==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815877"
X-MGA-submission: =?us-ascii?q?MDHPB3uxTsU0FTN3hc/He/pMVu92DkVcNj7oAl?=
 =?us-ascii?q?90C6y60heWDtd8llBA8wG7IHnJC/tykY1RGLeKF0br0dMny9s0G/hK+D?=
 =?us-ascii?q?FgfeK9I8gN/4/rds6+qrdCTEPgRhCKQN3fsn3flFHD2Pkh2AkBwQ1MsJ?=
 =?us-ascii?q?YA2yhmQjsItIWMjC412BiS9w=3D=3D?=
Received: from mail-he1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.50])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:48 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bmi0sx8CULh6aemUQcQO0ElMtJCUnTzsosJvX2tYlk5CdnxJR0QvsCWuBXw5Cs7JCevpY813M93fvGORi8DmwzORK2zE273Ftzbw1qaSNP9gj90nVaAuNW9EUAM8Zwe86qEKdzBHCkiVXqdWO03R8apqee6hcH56dvQnCIeLaOaXklFdbFAK6pF8QkvyMECXWlNUy6iIyANop2MXjULqGpU4VWhNcaTmDQWpf7G+uk81SPoi1FMDLhasvsOwi6Dfq2ynLjdKrB8PtTHiL2tIG35oeqcbWOwJSykVovA536oy07aKPpZgyxhHjsyyG7WVvsdLRPTZUpC3HR4VH8edgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey8tYT5sCKUkGtrJEMnAddjrE5No915u2Azs6R/nCDY=;
 b=Ntor+Cw/FQT6lKAOps3T8qlrkMQzPVnFULBeIHNIM1h+HZWM6IMh4UFpgOMpy44mltIwcedu/oyxQ7WpgJHHNhBF097f80wifyLxpUCWANRt4Rz4v8sI37fRYOATb6/OzvHoBljbdLp0LSP+8C9NymEtcXMpkjdEzUIkky16sezVNriqRX67i0iosbuqm7cenPd/wuWMMDaDV55J8kY52FWhY3TmXPRYPUhcCjMBxUuKhdSVcX4tKHkIY4eTkttmNxRcriG3G0kqOsJIxyHJp2CyAfCDY3lMh5s+pmITLMr+vaYhqQNLyRELv+frkrmhc/SS8PttuOG6Hlt7r7ixdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ey8tYT5sCKUkGtrJEMnAddjrE5No915u2Azs6R/nCDY=;
 b=qJWAVcpm/lpTNxDTpkoRUlR+f0Xpgkgn9OKsmNt0OxXZ39bohOZNam1ECHTIYPHxMwcFH7H8quqVC+WUFqYT0T1qfWkyYawjQ4Bz+aJplIdXqsY1arC8h+sxpOJQZ9zTs59obhkZI7BxGu9yxeyjuC22b2s650jT4SgJG+4xDWD4knaRtMqjcy1JpVtDOwO+spJX1vf/SUm6yWF1RVu6b0g0jP6LVk3unqpYLLZSUBatouppxT4NrQuEot4eVa8a09hLMXQCw/2zLMPKzRY8isBcTdDOodIdLVQ2wzyGQU0qSfBLdhjnWDzqNn2GyfXobOzVOMrfUQBnL3QYv+8W3w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:44 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:44 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 06/22] pcie: add helper to declare PASID capability
 for a pcie device
Thread-Topic: [PATCH ats_vtd v5 06/22] pcie: add helper to declare PASID
 capability for a pcie device
Thread-Index: AQHatXs7fkIAOjQiy0K665R5BPGZQA==
Date: Mon, 3 Jun 2024 05:59:44 +0000
Message-ID: <20240603055917.18735-7-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: d5d6cd20-3be4-40e5-0487-08dc83925e03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cFFuNU1Hb1BISWJYVDc3bmM4WXZ2bUUyRG1tOExvZ29uWUZOY1BEdkhEZGlS?=
 =?utf-8?B?THRpWE5LNzhiQ3ZtaHRDVDZUd1pEYXpOM0N6a3N2UW5OaXN6VHdONWpKaThF?=
 =?utf-8?B?Y3pxdXVGdUpHZnFETTF1bWhoUEpZbjVIRktsVjIwTk1sazQ0VUhocWZNNkts?=
 =?utf-8?B?Z0RvUGRRcXVWY1g1SVVtVS9Uc2tnUHhkbDFOS21WNU5pS0MxQWZkTDd0dnVV?=
 =?utf-8?B?NHY0ak42RzNEL0FPY2xpKzhhVEFpcGQvMm5mNU9tdi9YTTRRQXFjZG4ydk9I?=
 =?utf-8?B?Mit1SVZUUnR5WkpaN3h6TkVkOTNOOWwvaHRWZ0lhSWs0NUZHcGVVMUNLcFND?=
 =?utf-8?B?ZFRGRzRoWERFSTVIR3JkMjY3aHN6QldkNWlzWmJhdmpKNUtaM092QzB1VDVG?=
 =?utf-8?B?MnVmay84Q1BKMnFSS1pEeFdaWUZCNUUrZmFZczBzRkpqSktsSE1IZFl4Ujdm?=
 =?utf-8?B?RzRScmxGMXB4cFVPYm1VdEdBc0M3VlVGTmxpamk4bkdoNTNsZDlmNXRoYmZD?=
 =?utf-8?B?dWJraHJSWmhXUzlOdXR2Y1lFTXB0Mk90d1RIaGxxVXcrdy9jWlg5V3hxQkdV?=
 =?utf-8?B?bW9TTGJZT1NCTEg4ZW53YnRGYzJFUnRxUWpUczVTSHpsemxpM0U5UVZMeDIz?=
 =?utf-8?B?RHFVZFZaaEpsUFRacElCV0Vkaks3ZHJ3ODFTR0lka1o1N2lrMDR2WEJMY3Np?=
 =?utf-8?B?bXpUTjVCQkVqNjd6QUE0NCtiRkc3bnBTdU5mdVhrMUNGNXAyY29rTXRSYlAx?=
 =?utf-8?B?VGtUQXhnRnpsL3BBVTZSYVNLVDE0YXo2cWFDblZHVU8veldGZlUrdEc0ZEQy?=
 =?utf-8?B?aStSTllocnFiTitpSFBSd2dhUHRmZjRRUzJzRDN6ZXF4TUlXaWpJMjdQVWJv?=
 =?utf-8?B?am90bzI4TUhQN0k4YTliNzdyWnNLb3l0c1ZyQ0txbU0wKy9GUVUxLzFnVkhr?=
 =?utf-8?B?MDg1RWx3MXF6OWNmK2Nab3JsRzlNaERVY0o3eDd6NXVubUlEb1U1OE1GZmRj?=
 =?utf-8?B?alZGYkNVeHA4RkxYb1FnM3VKbnY5WWNQZ1BaNHFQZks5S3hpejhJY25tQk5R?=
 =?utf-8?B?ZGIyRGtXclFDVFhVRnNlUmt0ZTgvdWNVc3BqbnowNWUvdGVTTnN2V0Z2Z1pV?=
 =?utf-8?B?a0w4VGtJUWZ2SlJtdFEwaTlFdDNseUhoaCs1RVp6UG9CcU1qWUFoVUVwSkY4?=
 =?utf-8?B?bTJrSHJIQzRnSlBUckkzckJOdWw3UDhYMXQveVorNTZBYlAxekFyM09TWDVa?=
 =?utf-8?B?OGdtMktCMzFuaHlYTllBc205bkdGMnBaQU5lQ0RJMzlBOExGQ1pLWnc4bERi?=
 =?utf-8?B?YjBxS01VSDVVa2o3dkpRbWtEcmFESi9UY0x1eEQ3UVY2NzlXR0lCV3ZmUjl0?=
 =?utf-8?B?bkx4TmNWWmhkbWZRK256b2U5MWNISzNSNXR0Z3VzQzFZaHZLSjhHVWVZdkUv?=
 =?utf-8?B?U0lMVklWdDJ6Umk1ZkxMQ0NzT2NBeDAyakFUNDdESjQxMjkvMVQ2OS9SSEFG?=
 =?utf-8?B?MHY0N0NvSzJQT2xCSGVqendRTFdjVlBXak9hQnJZK1NYNm51UFB6VThhUVQ5?=
 =?utf-8?B?QWp5V1c2Ym4xV2lac1d0QVMvQUUrUGd3WFE3alBrUDdDOGFYRTA1dERIUFF5?=
 =?utf-8?B?RC9oNm9WUzJOSW9IYlcwL2JBc2dzWU1HajhjMzJkcFFtWmJyVXJZYTgzMGxp?=
 =?utf-8?B?UDdnWXVGc3cyc0pVOWRIeVBYYWpmTUdjWUIzVkNFalcwMUkrNzBnS05PZkxj?=
 =?utf-8?B?V05laHJSWGk0ZUFISGxFN1lDYTBydEtuQUhKTUJGSmR2U1B0azF3SUlLWGg0?=
 =?utf-8?B?czFuNy9pdGxlWG5UdmdYUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnJSWDFiMXZHWWVIRjFCYmJPelN4K2c3NGV5RitYNFB6QmNDRkhBdDJaTGRr?=
 =?utf-8?B?dnlpNFJEV0U0bi9HZ2gyNFNCR2F2V280TlU1TTluVFE3QjhoZU1pYnYrb0lQ?=
 =?utf-8?B?S2t6QkhidWlkS1lQWWZSWEJkMEpURVJFSGdKWUNnR1VDSGw1cHBYNWk0eUZh?=
 =?utf-8?B?Q1Nja3VzOEVrMHVJZ1lkWlFwdHJHeGs2aFdiWHAzUitJMWM4a1pzUVVoT2c0?=
 =?utf-8?B?Vy9BM2N3dU85K05GSzJnSzRFaGlPTjE4MUhNaHVNNk9aUGpVUUNRU2JsVkxv?=
 =?utf-8?B?S2Q1T2hOLzBIQ01ZeWVHS00yY2t1eXoyc2RTQm1ZSEFzL0x2Qkk4VjNDd1VC?=
 =?utf-8?B?UEcwK1ZMNGlXMVI5czU0cmpHay9wSVpMTlZ5ejhWaXFQLzlRRE5EUExpMGF2?=
 =?utf-8?B?L1VPTlR3L1ArWDAyd2Fuc0gwcE9HNTlvbjYvcmtSUkxVeFJ4UWdOMUNXZXd0?=
 =?utf-8?B?bmJiRXZFNzl3clNpWjAvaVJiK09vNnd0MkVlS0o2MmFXOU8vZFhGUjdKeG5Y?=
 =?utf-8?B?NWY1c3NGYy8yN2FoNjc3N21GakdkYVlMbS9xd2U5dG1IVGdTTmVvYjkyZ0pV?=
 =?utf-8?B?YzBoSGV4dUp4WjZiS1p2Y1A0ZHA0UlhWRXV2Q3BBTGRKVXlOWXYzUUdFcGIw?=
 =?utf-8?B?L0l2YWg2dlg3RDhRQlpyTW85RnFFdE56VGNXdDM5NU80cEJRYktpYjIzVWg5?=
 =?utf-8?B?K2d5VEtsSSt2SjFNbW9uMmNKRERPVzNhVVhrNlE0MzRhWmZYbGVZWEtCc0E3?=
 =?utf-8?B?RWMxTTlWZTBsdmQ2Y0V3NSthOGF2VTVFRXpZMEVVTWNJaUxXcC9iZVhnNm9J?=
 =?utf-8?B?NFp5WDRvYzhtSFRocWxPUG05ZUloWUZ5blQrUmRodFNOOTVGbDF0VVhWdkJi?=
 =?utf-8?B?OTUvWXo4Q2JLUkNYWDZSenEwN2hvUjJITGwzU0pKajR0VGR2RTFUYlI3eHB4?=
 =?utf-8?B?UjJqRW1zSTRvVE10emxyeFhjalRmSkp0NFAvODh3WEkzNWhtRVlFb2FFbWtV?=
 =?utf-8?B?aVhmMXJrNHFJb1psQUN0NThNQ1dMdER1Qk1saDlUemhCSS9RNjNHZHY5clpL?=
 =?utf-8?B?bTdTbllkS29DRlN2ZEpoM09TUUFjUVpmZkpuRGFTR3FQYlRvM1JWS1FFdkUz?=
 =?utf-8?B?K21TcmY0NG1NNjZsY1N2QVlPTnFYalRJZE1nUnA5R0RSanBVc1JoZVBNRUtn?=
 =?utf-8?B?NGIrT2VteVk5S1J0TDV2VnJmeU5hb3ljbTVCVUx4NmxNeTEwUGNFaFAwYmdX?=
 =?utf-8?B?cVpVaUhMQ2MwL3lsdmtnMUlxTHc5clI1ZHRHVThBSFEvZXQ2U2ZldjVLR2RO?=
 =?utf-8?B?eGV3S2hYeU5uTS9mTzVLSlRjUmt6VFlwb3ArbTdIWVIwdzhTR1lESzRyRWZF?=
 =?utf-8?B?VGJuZmdJQm9PeklNa0F4SXhCR3c2ZVhoVDF4aDl3aDQ5REpQa3F4QlFpbm9W?=
 =?utf-8?B?Zk1HbEpLU0UwTHlXMHBGU1laeWlsWVVmbDdSY1lNQ0ZUWUdTakpyVGM5YXlo?=
 =?utf-8?B?TnRDVUE2V0hmR1VhSy9YdnRkckxwVTB2NDliOU1kamVwREJLb1grbGo3T2du?=
 =?utf-8?B?WHZHdGhBK2RKUXFtM0JHaTRITjBOMmZLUjQ3VmdDczF1Q0dUVVlsNEFsNkho?=
 =?utf-8?B?VHgyVExvcENpZ3o3dmRRSVdhN3RpWE5OUzN4RmN5SS9tVm44bm5KbDBaVVp2?=
 =?utf-8?B?dzhnQSs0Zk80Rnk1clZGS2dHSS9CbXUzUWk0YnU4eGVZb2ZURHQ5dCtFNGVZ?=
 =?utf-8?B?SXk0cDNVK2lRcUM4bjdCcndMZmw4bnJCSExVTTJRQUovNFVnRXIvTEIvTERH?=
 =?utf-8?B?dlBhR1NPeWdnbUVYZnV4SU84ZTNxb3RZbW5LaEpwUzliM21sdEZIV3doaGs4?=
 =?utf-8?B?ODZDUDJxTnlPZFZBa015cnZ4RVdHNnlheFRWM1dXZS9zWDBsZ0NvWm9oWXFn?=
 =?utf-8?B?OXdyU3hCbDVHOEFmYkNaMFp1VzBoa0locWdoMFVueWhGWThCeitNM3daTStl?=
 =?utf-8?B?enBndnBlbkgyMW5JVVpWTFVwQWRVbFlYVEJaSVZxM3BscGxmajRCd25GQ0Nz?=
 =?utf-8?B?QTloWUhVTUxjZ3JoRWJ4bzNIYS84SmVwT2M3cU5vaGpGYjBJRVBkVmVIRXdE?=
 =?utf-8?B?RXBpTS9OYmxGS3lxaWQ5TXpXeSthdmpwTzF5M1JhQUtaS0lwaG9pZ0xDSkgw?=
 =?utf-8?Q?sKGbEHRgseoIqlzwMH1uL+w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE22EB23BC895A439EF07FD3E9F24DBA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d6cd20-3be4-40e5-0487-08dc83925e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:44.4939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4c8N9YAUsKDQvguNVVBmuJVmF7xsvXWVky5+l+ga3CSdau8zuWz79LxhqLndk0Td/FpyxGCEj5tuOkgETUn9szryxtzBpa+D0qfCVVzTzM4gqKNPnusqptQVNtW8VxK/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvcGNpL3BjaWUuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUv
aHcvcGNpL3BjaWUuaCAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKystDQogaW5jbHVkZS9o
dy9wY2kvcGNpZV9yZWdzLmggICAgICAgICAgICAgICAgfCAgMyArKysNCiBpbmNsdWRlL3N0YW5k
YXJkLWhlYWRlcnMvbGludXgvcGNpX3JlZ3MuaCB8ICAxICsNCiA0IGZpbGVzIGNoYW5nZWQsIDMz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2ll
LmMgYi9ody9wY2kvcGNpZS5jDQppbmRleCA0YjJmMDgwNWM2Li5kNmEwNTJiNjE2IDEwMDY0NA0K
LS0tIGEvaHcvcGNpL3BjaWUuYw0KKysrIGIvaHcvcGNpL3BjaWUuYw0KQEAgLTExNzcsMyArMTE3
NywyNyBAQCB2b2lkIHBjaWVfYWNzX3Jlc2V0KFBDSURldmljZSAqZGV2KQ0KICAgICAgICAgcGNp
X3NldF93b3JkKGRldi0+Y29uZmlnICsgZGV2LT5leHAuYWNzX2NhcCArIFBDSV9BQ1NfQ1RSTCwg
MCk7DQogICAgIH0NCiB9DQorDQorLyogUEFTSUQgKi8NCit2b2lkIHBjaWVfcGFzaWRfaW5pdChQ
Q0lEZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50OF90IHBhc2lkX3dpZHRoLA0KKyAg
ICAgICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBib29sIHByaXZfbW9kKQ0KK3sNCisg
ICAgYXNzZXJ0KHBhc2lkX3dpZHRoIDw9IFBDSV9FWFRfQ0FQX1BBU0lEX01BWF9XSURUSCk7DQor
ICAgIHN0YXRpYyBjb25zdCB1aW50MTZfdCBjb250cm9sX3JlZ19yd19tYXNrID0gMHgwNzsNCisg
ICAgdWludDE2X3QgY2FwYWJpbGl0eV9yZWcgPSBwYXNpZF93aWR0aDsNCisNCisgICAgcGNpZV9h
ZGRfY2FwYWJpbGl0eShkZXYsIFBDSV9FWFRfQ0FQX0lEX1BBU0lELCBQQ0lfUEFTSURfVkVSLCBv
ZmZzZXQsDQorICAgICAgICAgICAgICAgICAgICAgICAgUENJX0VYVF9DQVBfUEFTSURfU0laRU9G
KTsNCisNCisgICAgY2FwYWJpbGl0eV9yZWcgPDw9IFBDSV9QQVNJRF9DQVBfV0lEVEhfU0hJRlQ7
DQorICAgIGNhcGFiaWxpdHlfcmVnIHw9IGV4ZWNfcGVybSA/IFBDSV9QQVNJRF9DQVBfRVhFQyA6
IDA7DQorICAgIGNhcGFiaWxpdHlfcmVnIHw9IHByaXZfbW9kICA/IFBDSV9QQVNJRF9DQVBfUFJJ
ViA6IDA7DQorICAgIHBjaV9zZXRfd29yZChkZXYtPmNvbmZpZyArIG9mZnNldCArIFBDSV9QQVNJ
RF9DQVAsIGNhcGFiaWxpdHlfcmVnKTsNCisNCisgICAgLyogRXZlcnl0aGluZyBpcyBkaXNhYmxl
ZCBieSBkZWZhdWx0ICovDQorICAgIHBjaV9zZXRfd29yZChkZXYtPmNvbmZpZyArIG9mZnNldCAr
IFBDSV9QQVNJRF9DVFJMLCAwKTsNCisNCisgICAgcGNpX3NldF93b3JkKGRldi0+d21hc2sgKyBv
ZmZzZXQgKyBQQ0lfUEFTSURfQ1RSTCwgY29udHJvbF9yZWdfcndfbWFzayk7DQorDQorICAgIGRl
di0+ZXhwLnBhc2lkX2NhcCA9IG9mZnNldDsNCit9DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9w
Y2kvcGNpZS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQppbmRleCA1ZWRkYjkwOTc2Li5iODcw
OTU4Yzk5IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQorKysgYi9pbmNsdWRl
L2h3L3BjaS9wY2llLmgNCkBAIC03Miw4ICs3Miw5IEBAIHN0cnVjdCBQQ0lFeHByZXNzRGV2aWNl
IHsNCiAgICAgdWludDE2X3QgYWVyX2NhcDsNCiAgICAgUENJRUFFUkxvZyBhZXJfbG9nOw0KIA0K
LSAgICAvKiBPZmZzZXQgb2YgQVRTIGNhcGFiaWxpdHkgaW4gY29uZmlnIHNwYWNlICovDQorICAg
IC8qIE9mZnNldCBvZiBBVFMgYW5kIFBBU0lEIGNhcGFiaWxpdGllcyBpbiBjb25maWcgc3BhY2Ug
Ki8NCiAgICAgdWludDE2X3QgYXRzX2NhcDsNCisgICAgdWludDE2X3QgcGFzaWRfY2FwOw0KIA0K
ICAgICAvKiBBQ1MgKi8NCiAgICAgdWludDE2X3QgYWNzX2NhcDsNCkBAIC0xNTAsNCArMTUxLDcg
QEAgdm9pZCBwY2llX2NhcF9zbG90X3VucGx1Z19jYihIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19k
ZXYsIERldmljZVN0YXRlICpkZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJv
ciAqKmVycnApOw0KIHZvaWQgcGNpZV9jYXBfc2xvdF91bnBsdWdfcmVxdWVzdF9jYihIb3RwbHVn
SGFuZGxlciAqaG90cGx1Z19kZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCk7DQorDQordm9pZCBwY2llX3Bhc2lk
X2luaXQoUENJRGV2aWNlICpkZXYsIHVpbnQxNl90IG9mZnNldCwgdWludDhfdCBwYXNpZF93aWR0
aCwNCisgICAgICAgICAgICAgICAgICAgICBib29sIGV4ZWNfcGVybSwgYm9vbCBwcml2X21vZCk7
DQogI2VuZGlmIC8qIFFFTVVfUENJRV9IICovDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kv
cGNpZV9yZWdzLmggYi9pbmNsdWRlL2h3L3BjaS9wY2llX3JlZ3MuaA0KaW5kZXggOWQzYjY4Njhk
Yy4uMGE4NjU5OGY4MCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaWVfcmVncy5oDQor
KysgYi9pbmNsdWRlL2h3L3BjaS9wY2llX3JlZ3MuaA0KQEAgLTg2LDYgKzg2LDkgQEAgdHlwZWRl
ZiBlbnVtIFBDSUV4cExpbmtXaWR0aCB7DQogI2RlZmluZSBQQ0lfQVJJX1ZFUiAgICAgICAgICAg
ICAgICAgICAgIDENCiAjZGVmaW5lIFBDSV9BUklfU0laRU9GICAgICAgICAgICAgICAgICAgOA0K
IA0KKy8qIFBBU0lEICovDQorI2RlZmluZSBQQ0lfUEFTSURfVkVSICAgICAgICAgICAgICAgICAg
IDENCisjZGVmaW5lIFBDSV9FWFRfQ0FQX1BBU0lEX01BWF9XSURUSCAgICAgMjANCiAvKiBBRVIg
Ki8NCiAjZGVmaW5lIFBDSV9FUlJfVkVSICAgICAgICAgICAgICAgICAgICAgMg0KICNkZWZpbmUg
UENJX0VSUl9TSVpFT0YgICAgICAgICAgICAgICAgICAweDQ4DQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3BjaV9yZWdzLmggYi9pbmNsdWRlL3N0YW5kYXJkLWhl
YWRlcnMvbGludXgvcGNpX3JlZ3MuaA0KaW5kZXggYTM5MTkzMjEzZi4uNDA2ZGNlOGU4MiAxMDA2
NDQNCi0tLSBhL2luY2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC9wY2lfcmVncy5oDQorKysg
Yi9pbmNsdWRlL3N0YW5kYXJkLWhlYWRlcnMvbGludXgvcGNpX3JlZ3MuaA0KQEAgLTkzNSw2ICs5
MzUsNyBAQA0KICNkZWZpbmUgIFBDSV9QQVNJRF9DQVBfRVhFQwkweDAwMDIJLyogRXhlYyBwZXJt
aXNzaW9ucyBTdXBwb3J0ZWQgKi8NCiAjZGVmaW5lICBQQ0lfUEFTSURfQ0FQX1BSSVYJMHgwMDA0
CS8qIFByaXZpbGVnZSBNb2RlIFN1cHBvcnRlZCAqLw0KICNkZWZpbmUgIFBDSV9QQVNJRF9DQVBf
V0lEVEgJMHgxZjAwDQorI2RlZmluZSAgUENJX1BBU0lEX0NBUF9XSURUSF9TSElGVCAgOA0KICNk
ZWZpbmUgUENJX1BBU0lEX0NUUkwJCTB4MDYgICAgLyogUEFTSUQgY29udHJvbCByZWdpc3RlciAq
Lw0KICNkZWZpbmUgIFBDSV9QQVNJRF9DVFJMX0VOQUJMRQkweDAwMDEJLyogRW5hYmxlIGJpdCAq
Lw0KICNkZWZpbmUgIFBDSV9QQVNJRF9DVFJMX0VYRUMJMHgwMDAyCS8qIEV4ZWMgcGVybWlzc2lv
bnMgRW5hYmxlICovDQotLSANCjIuNDUuMQ0K

