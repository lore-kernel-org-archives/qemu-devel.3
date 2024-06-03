Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C325C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jt-0006s6-FU; Mon, 03 Jun 2024 02:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jl-0006nT-PV
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:05 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jh-00071T-NQ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394402; x=1748930402;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uUNdQjejwD19GDvGqzTWmxMIvWgcJeiOCFc/IfPyiss=;
 b=OmdIp0zVqbNxZ6IcYNenGGrhRbe/FdgV3oTNLHCqpk+xjy+XwmBSD6Lx
 Q6pRrQVScBtB2FRbLE1EmY0UWopn0zOKMLsJOVd/1f8FwLXAuHNII9vTM
 CL9rPSP2j49ksVDym+iVsjLQsIEglptqx1hZJ6Uvap4ER/hzUWfVoA7FZ
 vGadUlDJ7qbGtCWPEUWbZbYuU5Za2ungGBdaEvLLgKXZUyufwVWodhPvB
 MMZYL5Z6FL9lXSKevXqCCBCRQcqFhbvVmuZl0hFdEkyfEW6wNZm+9Ay0e
 ZVsZEfzLPlduD13X7XHiKXJ/1XxWLyr1brNS6H5qOtEJ5t5jVHz4t6wz0 A==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815889"
X-MGA-submission: =?us-ascii?q?MDGKsKxKnEJsFH9MhGljupOGHWmH15QFEyM+F0?=
 =?us-ascii?q?Yv51LXdZ/9zUIZNZUxNEAvKk0cIOnynLg0aZd7fIS/8J16a2Zjiz9kHV?=
 =?us-ascii?q?djZzP4AibrNjUv5BtAVBMxstwqzJPY0mTFuTrpmWnNRho1ncc9GnhM4I?=
 =?us-ascii?q?N+OdzAndV6OXxoSX1u7QVcNw=3D=3D?=
Received: from mail-vi1eur02lp2041.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.41])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:55 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WenOiXZXwxTSFuI+R8QUz2YuFH+2CwuwgnuY4Mrmy1lAR7q+MA3pl2I6H/j6bnNtlcgYji28o1pAUUapBg5LrIMCOF8FG5NFwf38BMSWU6OCm7OzpHu/AL5ZROUPw37I89HR6Cmi+nmy3XYdoHRSr6qhid7GOrk8QZmK5fpoxJzU06p4B+VnZ6y9Id53uA7qz1zpLHWkhLcoB/XkJ2wnsac8rs2RFIqPfNEmGk7haG+RhYH2i1MBawaU9PUuD6J1feikXhrCOCRRPmVr4p7vxUw0y1i4skp64xF8soRD0Uq6s4GPDPt8A1aOO0IgpKfqA+Jo4V32L7XI4ZNzwXYxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUNdQjejwD19GDvGqzTWmxMIvWgcJeiOCFc/IfPyiss=;
 b=dphmP0iGw+zpgoVjxHQnUZOvcivUi2F1GoPP9iWRSNrDZMkUYbwbKUroogJBdrXHRL7eUdmZjm+jEk9GeZbssnuMAnR9fNv9QuO+hupJqXF7850Q52f6AKhbK1F9b5HLp+Xp8wYLWABcvck0Y0gdUJR7PIc26RUiE+7Tw/eOVzzBRp4w0kUnblOactxcVt2QS0xdzPmIbkBApiK/BMTX7MnQ5LcBgkbxoKLnDwDJVDsX6iTJaKb+iYw/cOnJIe2fwEJnXUnVeumN+LDceFSSNrkKg7iGTctt5DqYs6Tj0DYYXnh56Y/8RjbWrh5OPvQ01GE/in789jRJHX1H0Ly9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUNdQjejwD19GDvGqzTWmxMIvWgcJeiOCFc/IfPyiss=;
 b=cgVQ8/VNtfIjJ1ol0kZuq2QZ9Zot24BqEr1eLCuY2ekee60rTBtUlPyHTJhbPFDpqLNJdUdR4mL5MWxyW+pt2IAOeTFWVNFh2NFEROm4HSQQ4qlMHp+UVmOqdi5bFxCO1GIa7RR+nH8g8iev+2vUx2aKvUW9thBQwuyCEL3zSQ51aEud4SYkFkWDMPjXGyiWKrDQ7j24S9T5RQmOTqv6nXZyOPMZbYgWtq4ltu+4+wdJHNoptmvfC98r4T9q/4317pnwYT1P7Unh7Oa0/mjSYgP4qrgChvgXgbiYm7WGlYvE1n+8f8oHYQBizYFU7hsXayVUdWFwtSqIFV1PaDpXKA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8192.eurprd07.prod.outlook.com (2603:10a6:20b:323::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 05:59:53 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:53 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 19/22] memory: add an API for ATS support
Thread-Topic: [PATCH ats_vtd v5 19/22] memory: add an API for ATS support
Thread-Index: AQHatXtACltASpuAL0qCo+7Ga8q92Q==
Date: Mon, 3 Jun 2024 05:59:53 +0000
Message-ID: <20240603055917.18735-20-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8192:EE_
x-ms-office365-filtering-correlation-id: 29129a78-1818-429f-bd51-08dc83926324
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QXo2dU5MbHVVcDUxWWpOMnBxQ0QxdEtBdE11RVhIS2VDd2tqRkxSMUVQWUpw?=
 =?utf-8?B?L3M2MDdRVWV0dEp2c2RNajdTdE5JNzRDc2JFUTdQN0pmSDRtd3JPOXZ0a2tx?=
 =?utf-8?B?RFhOR2J6RHU1eFpNd084WjNhM3ZESXhIcUh2Szd2UjBqeUpUOUVUNnZ1YnF4?=
 =?utf-8?B?MjNySXNqUHBIOWRCVmV3OUdxdUZITEMyUFYwVzQ5MWIwZW1tSGJLdy8wR2hi?=
 =?utf-8?B?V21weW1qNEx1ZXltZWcyU3RQaCtEMVZGcWUyejA1QlVKampXVDlLbmpTMU81?=
 =?utf-8?B?WXJsTUlRTUVSUC9QcjVMa01UM2VDTzIrWlMrby9GYkZtdnpjR0l0TFNHcW5h?=
 =?utf-8?B?d1lOMEtNdXlqNVZNcmd4cFpVSmRKbzBqQUFJZGZ0bFB1bWQrWXBESVpEZW1I?=
 =?utf-8?B?UHhyRTlUN1EvT2pzK0RsUGJPc2tGRjZFTCtsbjRwdVhiQWNTUXk0WDhYK1RU?=
 =?utf-8?B?WkxzUzF6azZxZnI1RGYzejBaZ3cvS3lqaThDb1pFS096NThvYlF5UWc1blpD?=
 =?utf-8?B?NXZrOEpXaE11K25mZS84WHU4UGJTZmZhNVhqRlRIekNaM3JsRUoveWFKajQ5?=
 =?utf-8?B?MFJZemNKKzg4NFlibk9aeHpFWEEwZzNjL3hDWjd6RTAzaVpRbTVmQXRaVzhR?=
 =?utf-8?B?ZkVWZDNmRkttd094Q3lLNGtmVFp3NDRtZ3FjM0kwNzNJQkttTHpkWktaWXBZ?=
 =?utf-8?B?Z0M5LzJabHJUbUd0M1JVWXFJRzhPOTBwV2ZjRnBjM0pWYnFKSFZrcUhHMFpp?=
 =?utf-8?B?RVZrSnVGeWtYMGh4eEwvdXZVK2tLZVhnaFFwbXZ0cEpHZ3FrVHErNkZKc0tm?=
 =?utf-8?B?Uk9HRzVuaXB3THpzcE1XVDgrUXdGTkg4czBZU0hlakY3Tm0waS9Zb0NVZDh4?=
 =?utf-8?B?ZDAyTUl5K2VxajNQSEQ3WTVNeDF6SHZWZURsRlNtblZIRUdzOGlsVXRqWXlO?=
 =?utf-8?B?L1B2RlVtNDBXWXBRTi9BbEREZkM0WmRqQnM3MmkzOXVXSm9UU2ZST3ZCT0xk?=
 =?utf-8?B?Yy9ERkxwdkFxakFIN2VkcloyZS9LOG5WS3pRSStDVFFsYStNL09haVNYODJ3?=
 =?utf-8?B?bmszZ0dWaHBMMjlRelZNZE9xSGJ1UzZ4M0ZCalZBR2ZCeTlGbEpEUWdMNHAz?=
 =?utf-8?B?M0MxVTdwYlQrd0dFNVJ6QklMN0JkZmhLYW1raTlkY3BETzFVcDg0SW5tOUgx?=
 =?utf-8?B?Q1Njdk5IeTZTa2toMUJ2UXlJL1Rzakt4U0hpSnVjYkZGdnZ3Ryt5NWtlK2ZX?=
 =?utf-8?B?NnZvSnNhc3hETzcvTzFlZkUxSWlYSVkvOTB0bkVVRmp6UXJZK1M5NmYvbGJB?=
 =?utf-8?B?V2doUkswSE5laTRCbUdyaC9WY0VLdC9IcTU2a0JlM2FhRzVaSGxBYkpjUFJL?=
 =?utf-8?B?L3p2Z2tWNEkwakFycU9RcW8yS2VBNGwxSDcvMjVGL3FRcUhFaEY2YkJteGJN?=
 =?utf-8?B?RkF2M2tOd2ZkMFhJdVBjUmRIWmNEV3RseUgwc3ErOStUVitzNmVQaGNJeUVw?=
 =?utf-8?B?dDNUcjlJWnpETFhad2V3RzRVS3JmUDJ5aStONkhVaU5WTVRuTWFhZ0RMbzVz?=
 =?utf-8?B?cGl2eEo1QU9uS25oVE1xdDVqb2lMT1ZjSmxzbGFGbWV1Z1d4ekZ2enFjMnM4?=
 =?utf-8?B?ek92cVFLT0E4RDNnZmwzTXEvak93UDZSQ04yWm93ak5ySW0wQWM4aUNHdnIz?=
 =?utf-8?B?S3Rub3lYNHh1aU9GZGlhbmIrQW1aV0hsdGk3c2VDaE1OUm0zZjJvbmJIbDFB?=
 =?utf-8?B?OFU4T1FYN1o5QTFLS0pyVWwzZkJrcWVpS3BSVHVmbmVxOTRCbk1MYnVHM0pr?=
 =?utf-8?B?cHYyZ2FFakt0NUlibEtGUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnRJbmZTSEtIWVE3aVFaQmxRUHh5UTlxbjZBWkl5MXRNT0Q0YlNHRXNnZ1lX?=
 =?utf-8?B?MTVXd0NIM2I0SU10ZDlqRVpvMVIyNC9ReXYxKzJWM1p6M3E2MXFSa3BoNDNH?=
 =?utf-8?B?UTZsTVBvU3p5RGJ6VHVKaGdMYi9mRWU0aDA4aXBIUlBEMmVKdnBSQmhaSkgw?=
 =?utf-8?B?UjlvNDFLaHFXdmRhbjg5N3FtQlNYeDBiOE9nRmZGMW82cmpUTnd5UWhuczlR?=
 =?utf-8?B?UFIyTnpjQ25CODJDWFVsY3dYZEtKSWtsVzgxN21VVG1wWmtHWWw0M0x0bzhM?=
 =?utf-8?B?QU5BYkM5bnZqUTJhejRSNWxkRy9LQjNiMlNyUXBISWh0OWYzZXArVGk5RDVM?=
 =?utf-8?B?N3BWVUJScXhLNHg4R1BidVcxTHNRT3ZGT2doazZ3bXVuM0V0ZHdaVm9wcUpq?=
 =?utf-8?B?Z1o4dmJJYnZvaFVlWHcxSmtCb1JyaVltSm4wZ1NvZ1g4c2tuaXFwY1V2Ulp2?=
 =?utf-8?B?NEpoTFBiMkZFWWM2NU1sUVkzc0VZVCtRSjdPTi91VWxmR0R5bzcrY3hMbmxE?=
 =?utf-8?B?YWVFclllQUZEaVlWNzNLaU13ZVJCWW0yOU9GOUhpaTZGSUNUTzBTNHBHZEdv?=
 =?utf-8?B?cWNLT0ZMRTNBS3l0b2U2d0RUN1FKVXB0SUpKaENzd3gvQ21KTTltOCs0V25v?=
 =?utf-8?B?bTUrMmEvUXNNK3VUNnZrMzBPa3doYWd1L1RjSEkxMUJqSURyZFlVZy9EQU5S?=
 =?utf-8?B?dHA0Tk1vVjNHNVdoYVNnRGd0czE3TTl6Z2JOcWdWOFB1STNKSnVqM0RXRlBo?=
 =?utf-8?B?Q29OaDdXU3BBRWYyUjBzclQzNXQzbDRvRGNyU29zMStuamNlbjZiaEtobFNE?=
 =?utf-8?B?QnBLdkxLZmdMUUNrdVVRUkRQRFVKNlNObi9qSjdkR1JWa0hiaWpPdmVlZUhG?=
 =?utf-8?B?YnlqV0FNUU1RR0lxTnVLOGhxc09YZ3VoN2pHc3JtQ05MUTFoVVhOa0o0Y2tZ?=
 =?utf-8?B?U1k0TDhXRkhFRDRMMzFjQkV4Qm5QcytRcGVtUTM4WHdOcDdDUDZPbGlmcEwz?=
 =?utf-8?B?dEZNSnFzcGNGWHZPbHY3S0wzSkg0OUFHTVErL0xwcDFxZlJFUitPMmtmTUQ5?=
 =?utf-8?B?SzNYVU9jNFhTTXQxeFdCclpvTlI4L0d4SktoMDgzYXdkYkNXem5tdHpiV3FX?=
 =?utf-8?B?TVVXZ2FrMHBRbnpwdmxpSklWcnN6Z3ovenZwd1N1aUxha3pWQUxnaCtSQ1RL?=
 =?utf-8?B?V3QyNGxtRUE0bUlzeHNrWGhleW5kaEduOWhhYmlBaGJaOTRXdlhKV0RXQWtB?=
 =?utf-8?B?a2VmUnJ4REQ1WVFXNElxV1o2VEVpUVdkdi9iUTNFQ1ZQdEFmc1VxS1k5QnhX?=
 =?utf-8?B?NmtkQmE5ZlJrK1B3SDJ4T05BZkMwbm5SSXR5bTQ1UTgrbHhsTlV0ZFlQbUhE?=
 =?utf-8?B?aUhYcElNTUI0MHJ3VC8yU2JTQURUZVRENGpnU2tFem43b1lpTUp0ZFlsdzRW?=
 =?utf-8?B?MVQyYkh4UzNvbGpkcmRJRDlKb3hUMVhrU29OeFdsVnB1KzJoaktlWXpYRnFp?=
 =?utf-8?B?M2ltaHpNM2IrUUFZam1COWFNWnRWcm1kNTk0aUxxeWhCTEZMUmw2RmFyTUMw?=
 =?utf-8?B?aFBscVZYc2JWTUFwOXdSVHE5amR0b2FPZWdYclI4NzhCRVhLSjlMcjJWZjdG?=
 =?utf-8?B?cno3dEttZEhxTlJNWVJCSVM2anpCeE1xdWtNUVpacW9DRXMvd2FBU2NidFN3?=
 =?utf-8?B?dWQrR0FlSmp6elhYdlcxWlJhSldRQXZpQW9HTFB2UWd6RFR6TVFCS2pZN1J5?=
 =?utf-8?B?TG12bkNFMkdRQmNsU05EYXcyQ3VjMXVmcEpaUUNDM1FLT1MvYXlpbWdaY1hS?=
 =?utf-8?B?RzBRTmxER1pGMk5zTlZyUUIyMGVlYmE3MTZSL0cyaG8xa21UYis5enBwVVFJ?=
 =?utf-8?B?bWY5Mll3Y2k2SE91em9zWFYydmtiNGNzZE4rTjB3SlpJWk1CcHRKblNLMS8y?=
 =?utf-8?B?dXVaZTVRREI2cE5TbWlaa21FaXhOKy9jQlgzRVgvdGkxclZIUHlTNHJXV040?=
 =?utf-8?B?WVFRWldFVFRldnQ4aDFKWlFxdzI4dFJ1aFJYUHJLUFR2YkZaOU9oYS92dXRE?=
 =?utf-8?B?TlNRSFlGVEZvTG15a0c3RTNQQ0wyN1ErdjVNbzFUSGdMTDkzWE9XSk9laXhF?=
 =?utf-8?B?NmV2ekxSSUkvRGU3WEJUTHFQYlRicURiSU8wMVZqOFA2ZFRaSFpjMEFadDRG?=
 =?utf-8?Q?PYE5VmDG7pUojKiw9Q5xyQY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63288BA5FA2A9F4DA5AD9E1A135B4E08@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29129a78-1818-429f-bd51-08dc83926324
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:53.1208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4fKFbPblmN1FNJ6P1n16ZzKebr1t6vP8P4ScWmWModbTa0VpTHyAqZn5sdMJLw4Yj9UMcS+sU8I5gycDl1bMcYi4PohCXwfxrueedvwIIpybmi+4r5hm1jQ9h7C69zk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8192
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
bi5jb20+DQoNCklPTU1VIGhhdmUgdG8gaW1wbGVtZW50IGlvbW11X2F0c19yZXF1ZXN0X3RyYW5z
bGF0aW9uIHRvIHN1cHBvcnQgQVRTLg0KDQpEZXZpY2VzIGNhbiB1c2UgSU9NTVVfVExCX0VOVFJZ
X1RSQU5TTEFUSU9OX0VSUk9SIHRvIGNoZWNrIHRoZSB0bGINCmVudHJpZXMgcmV0dXJuZWQgYnkg
YSB0cmFuc2xhdGlvbiByZXF1ZXN0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1
LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGluY2x1ZGUv
ZXhlYy9tZW1vcnkuaCB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQogc3lzdGVtL21l
bW9yeS5jICAgICAgIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQs
IDQ2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaCBi
L2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KaW5kZXggNTZlZjQ4NzgwZi4uMGNlZDdjMzNiMSAxMDA2
NDQNCi0tLSBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KKysrIGIvaW5jbHVkZS9leGVjL21lbW9y
eS5oDQpAQCAtMTQ4LDYgKzE0OCwxMCBAQCBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSB7DQogICAgIHVp
bnQzMl90ICAgICAgICAgcGFzaWQ7DQogfTsNCiANCisvKiBDaGVjayBpZiBhbiBJT01NVSBUTEIg
ZW50cnkgaW5kaWNhdGVzIGEgdHJhbnNsYXRpb24gZXJyb3IgKi8NCisjZGVmaW5lIElPTU1VX1RM
Ql9FTlRSWV9UUkFOU0xBVElPTl9FUlJPUihlbnRyeSkgKCgoKGVudHJ5KS0+cGVybSkgJiBJT01N
VV9SVykgXA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA9PSBJT01NVV9OT05FKQ0KKw0KIC8qDQogICogQml0bWFwIGZvciBkaWZmZXJlbnQgSU9N
TVVOb3RpZmllciBjYXBhYmlsaXRpZXMuIEVhY2ggbm90aWZpZXIgY2FuDQogICogcmVnaXN0ZXIg
d2l0aCBvbmUgb3IgbXVsdGlwbGUgSU9NTVUgTm90aWZpZXIgY2FwYWJpbGl0eSBiaXQocykuDQpA
QCAtNTcxLDYgKzU3NSwyMCBAQCBzdHJ1Y3QgSU9NTVVNZW1vcnlSZWdpb25DbGFzcyB7DQogICAg
ICBpbnQgKCppb21tdV9zZXRfaW92YV9yYW5nZXMpKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0xpc3QgKmlvdmFfcmFuZ2VzLA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KKw0KKyAg
ICAvKioNCisgICAgICogQGlvbW11X2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uOg0KKyAgICAgKiBU
aGlzIG1ldGhvZCBtdXN0IGJlIGltcGxlbWVudGVkIGlmIHRoZSBJT01NVSBoYXMgQVRTIGVuYWJs
ZWQNCisgICAgICoNCisgICAgICogQHNlZSBwY2lfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb25fcGFz
aWQNCisgICAgICovDQorICAgIHNzaXplX3QgKCppb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlv
bikoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wgZXhlY19yZXEsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyIGFkZHIsIHNpemVf
dCBsZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ym9vbCBub193cml0ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3VudCk7DQogfTsN
CiANCiB0eXBlZGVmIHN0cnVjdCBSYW1EaXNjYXJkTGlzdGVuZXIgUmFtRGlzY2FyZExpc3RlbmVy
Ow0KQEAgLTE4ODgsNiArMTkwNiwxNCBAQCB2b2lkIG1lbW9yeV9yZWdpb25faW9tbXVfcmVwbGF5
KElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tciwgSU9NTVVOb3RpZmllciAqbik7DQogdm9pZCBt
ZW1vcnlfcmVnaW9uX3VucmVnaXN0ZXJfaW9tbXVfbm90aWZpZXIoTWVtb3J5UmVnaW9uICptciwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlm
aWVyICpuKTsNCiANCitzc2l6ZV90IG1lbW9yeV9yZWdpb25faW9tbXVfYXRzX3JlcXVlc3RfdHJh
bnNsYXRpb24oSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21yLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wgZXhlY19y
ZXEsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdh
ZGRyIGFkZHIsIHNpemVfdCBsZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYm9vbCBub193cml0ZSwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHJlc3VsdF9s
ZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDMyX3QgKmVycl9jb3VudCk7DQorDQogLyoqDQogICogbWVtb3J5X3JlZ2lvbl9pb21tdV9n
ZXRfYXR0cjogcmV0dXJuIGFuIElPTU1VIGF0dHIgaWYgZ2V0X2F0dHIoKSBpcw0KICAqIGRlZmlu
ZWQgb24gdGhlIElPTU1VLg0KZGlmZiAtLWdpdCBhL3N5c3RlbS9tZW1vcnkuYyBiL3N5c3RlbS9t
ZW1vcnkuYw0KaW5kZXggNDlmMWNiMmMzOC4uZDlkNjZhZTJlMSAxMDA2NDQNCi0tLSBhL3N5c3Rl
bS9tZW1vcnkuYw0KKysrIGIvc3lzdGVtL21lbW9yeS5jDQpAQCAtMjAwNSw2ICsyMDA1LDI2IEBA
IHZvaWQgbWVtb3J5X3JlZ2lvbl91bnJlZ2lzdGVyX2lvbW11X25vdGlmaWVyKE1lbW9yeVJlZ2lv
biAqbXIsDQogICAgIG1lbW9yeV9yZWdpb25fdXBkYXRlX2lvbW11X25vdGlmeV9mbGFncyhpb21t
dV9tciwgTlVMTCk7DQogfQ0KIA0KK3NzaXplX3QgbWVtb3J5X3JlZ2lvbl9pb21tdV9hdHNfcmVx
dWVzdF90cmFuc2xhdGlvbihJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXVfbXIsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEs
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJv
b2wgZXhlY19yZXEsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGh3YWRkciBhZGRyLCBzaXplX3QgbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIG5vX3dyaXRlLA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVu
dHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpemVfdCByZXN1bHRfbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqZXJyX2NvdW50KQ0KK3sNCisg
ICAgSU9NTVVNZW1vcnlSZWdpb25DbGFzcyAqaW1yYyA9IG1lbW9yeV9yZWdpb25fZ2V0X2lvbW11
X2NsYXNzX25vY2hlY2soaW9tbXVfbXIpOw0KKw0KKyAgICBpZiAoIWltcmMtPmlvbW11X2F0c19y
ZXF1ZXN0X3RyYW5zbGF0aW9uKSB7DQorICAgICAgICByZXR1cm4gLUVOT0RFVjsNCisgICAgfQ0K
Kw0KKyAgICByZXR1cm4gaW1yYy0+aW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24oaW9tbXVf
bXIsIHByaXZfcmVxLCBleGVjX3JlcSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFkZHIsIGxlbmd0aCwgbm9fd3JpdGUsIHJlc3VsdCwNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc3VsdF9sZW5ndGgsIGVy
cl9jb3VudCk7DQorfQ0KKw0KIHZvaWQgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXVfb25lKElP
TU1VTm90aWZpZXIgKm5vdGlmaWVyLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIElPTU1VVExCRXZlbnQgKmV2ZW50KQ0KIHsNCi0tIA0KMi40NS4xDQo=

