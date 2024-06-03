Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C7AC27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jz-0006v8-2i; Mon, 03 Jun 2024 02:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jx-0006uI-MH
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:17 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jt-00070x-Ss
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394414; x=1748930414;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=13GG35/z+g2/tSV3v8gmuukZxQXF5OOXbQi15tZoJ9g=;
 b=tuP/ANJDo2OvMnNRNz6N+9RNwECzEo3QOE0XaaE07Riw+WoaS7xTRTIl
 MG0HsTJeWyannTxbgy6C9n5WBdUcc5liT6GDripeusRhIRTjdJ2vqU9w7
 D6gTsIM/oix9E8sU0wPPFWZl9FXul6U9cA0wkpqXMRvo+DENgFR6EhqI0
 e2UZlialFuSsYxE0qWojlb367VpUiSyT6Ml9PUeSEEamnb0aI/IwF6MDC
 y4cwsNTD1tAYbeC8ufWw50W2OJSgWzzOqWK/mi6aWhvhkqZ4niq972byD
 9UJpSoCzhXvxE3T+Xwb157QTpQ0BzRwVfhimg4MKmeqFl9eqLRmmFlwJv Q==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815891"
X-MGA-submission: =?us-ascii?q?MDHyzdw5o6BKIpHUr10JNFBkkkSXiJ0e8seXGH?=
 =?us-ascii?q?55dTtPCVuTCef4FjXtrMW+lEZ3a579Il/V+aPmZmycfeJiPs+blvEocV?=
 =?us-ascii?q?f2FrTpKPFLaiR/anZMcV7a9hyYNwqxzoPt0e2OJ9dCfw5seKcju1Rg3u?=
 =?us-ascii?q?e032zZUMHJufrg6EorRCgguw=3D=3D?=
Received: from mail-vi1eur02lp2041.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.41])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcPo2qQHQKFm6FBZ6Fa6gt9bs9bodcV/PP0vImgG6KqcO00L+f/gRa4ADNdhz0c1bTzi64M/DctfTJIwdbTTVF7Rr2nDTgsENGH4wWOjck8sw5wAdvsVmGFTWIN6fG1xmYHh5YCnJPhsErVMWM7vYSBJ/V8vmEnP39eU2vbw5/jSitb9R53U90Fb3VBMXP6FlXtysXUp5K+5rkIDz8VUNCnBTl2evtXfKxHlVPFy2J8n1NntVskFrUF2WZHLS5i9ZFLeV1pvqf4HoExKBS5jMfvMRdxDZsJ6K7ag1tfxBcF0dhLZi/uxtXwFJKrPBcDRLg0Meqk8neRDoOQs1HY51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13GG35/z+g2/tSV3v8gmuukZxQXF5OOXbQi15tZoJ9g=;
 b=hIhb9qGVt9/X7ZYkZ/gjlGB8qv54HF87zfRA+2acl9OpplpvtnBxUl6Dy0tnjR6JUt+ox2CTXntJKj8TW4JOPswRsXMYs9p99AgtS0U94nrv+d1HFDOzu7NqnuxBm0G6jgrjPHJzKA48fzG/Es5trq1KvsowNXZApCH7IUQBLB/FrF94XzwDe++IfSuMxPtf30p3r3ObJtYLy8fbIvfcD3vFV9Y73swGaQnvn0gtCuXkca9nkA2hpIHx8exF/O26TeaNvQc+EGSM/xiSKI0FA4XLWbzcdIpnuVFOFY1j6wgi6zaccd+fmVvZTDdHe7iXlzw1SDDM9JVmgTsm8GvKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13GG35/z+g2/tSV3v8gmuukZxQXF5OOXbQi15tZoJ9g=;
 b=TJ2pv8gtPTY7v0M1dfMBA9ZHm3rpnxcSELXrymP2T0vrmcRVbRi5VSKl9SCXI+B2mo5lJu+OPVVsidWbNW4nxWivItlb78Yslsmxtv0Clv3XMqSwBF1VaEWAyOFWF81znIDyl7rMaqK1gV7kA2FVfGBi7tg6V0OwSs9bGK+0N3e2e6Cdcfxw0/arN9YRg4IwZUNq7nusIQZiGxeYE+tOQA6ewBwMTTDpO7+GWktD1Yr4+/Kkc+9QwheX57B4r2CRE2OokrkTlA6C5PS83xv1dlmq4yvsFFp8aQZZtdHVZNpUE3q+S+DGNeWD4nrj+/teCIFvvnXAL6FEgqSUftxQ/A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8192.eurprd07.prod.outlook.com (2603:10a6:20b:323::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 05:59:54 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:54 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 21/22] intel_iommu: set the address mask even when
 a translation fails
Thread-Topic: [PATCH ats_vtd v5 21/22] intel_iommu: set the address mask even
 when a translation fails
Thread-Index: AQHatXtBNNesc+UKhU+lHqhLQmHLjA==
Date: Mon, 3 Jun 2024 05:59:54 +0000
Message-ID: <20240603055917.18735-22-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 8d04933a-0418-44d9-9c37-08dc839263f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?R09SUVFIbExicGdnRExYeldHVnRJOWVhU3dnbm8ySW1qNE1PK1laa3ZUM2s1?=
 =?utf-8?B?NkdVaHZhTkduOUcxbmhNclNVYU1tRWgrbU9rZ0oxeEt4RWtpZkFkNThrSTEz?=
 =?utf-8?B?ZW1pVHhVZXN0Q0RtUkxOdlZLZDd2VlRnMXVZRytFVTNHRmEvT0xXQVJNRVZy?=
 =?utf-8?B?cHJzNlQ4Vy9kSzVBblFwcVMwRFV1QnZmV0k2Z3hrMVFWdVNsNFRSVUplbWE2?=
 =?utf-8?B?Mk1CTmpueHpTM1A0NHVKUmpHalcwc25xRndKekdrYVgvWGxaMy9vR1FIR1RV?=
 =?utf-8?B?dnlVT3REWTNYZCtNNUdEaDlzM1hDMXBSN2ZmeUdLejYwRlNIUUU0S3JwMkVw?=
 =?utf-8?B?dFhYVGJzTGNGVGlCQVA2VGp1ZTAwbkZSS3ZqWUEyV0IxUEVHTDdUaURtL1Ir?=
 =?utf-8?B?bytUTm10YW80eUlLUjVnaWpXNTViMEtkbUwxUWM4UlhlTEp3S2RQS3RFVW1t?=
 =?utf-8?B?ekg2OS92cVhZUGxORWFGQlBxT0tPR0tuaytUaTh2YUdmZk56SC9mU0FaRm40?=
 =?utf-8?B?RFM5ZkdhV0JMVVRiYkZBWVE0NWZwZ0RONEhld1REN2F4ajhveGJUSDB6bDlH?=
 =?utf-8?B?RitoVkphdDcwS0ZiNkhWTmxtemk5MDN4czM4YnZicXFYZXJpTTUweW84VVBv?=
 =?utf-8?B?RkFVUWp6Wm9XNStWWGNua09aUXNkQmFSY0JBbEdhZFExejQwWlZqTXdZbzNw?=
 =?utf-8?B?V253NTRuRkE3RnA5eTQ1U0krNW45ai9CU3M5cjRLWVhUelJLRFRYWUIwTGRS?=
 =?utf-8?B?Z2ZCTS9pbC9nRU1Ickx3ZzJCR0cxem51NWFrK1lnakJZWDVMNGJGcUJvbFJ6?=
 =?utf-8?B?MngyYisrb0FzSm1YL21PN1l3ZFpSbm1WWmVvSFZDWTNpcW1tNlpPSFJoTzBD?=
 =?utf-8?B?aDh1cWZ4cWJFYW5sYithT0o1NVoyUDA4L1RLNDI2UHpaRmtIa0tBTFFzN0lk?=
 =?utf-8?B?N2VyUjY5Vm9QOTBLVkRpNFVnVHFmNjF5ZnlGTzQ4MStjNHlQODdETXNiR2pQ?=
 =?utf-8?B?TWVTdlltU3VzeHpSYUpGV2FzajVSRzNDZXRzdWk1Z3FOU2kycndLY25FbDcv?=
 =?utf-8?B?UVdXR1o1N0hZYkp0MVl2NmdpVkRpeXhpSTRoU09OY1VOTm9jU1J1cFR6T081?=
 =?utf-8?B?ZzY2ajVFUm45Ty8zdVdzMVNKenhCL3NvRWR5V0hKVFlLWmpqWHdVQlRlUUU2?=
 =?utf-8?B?dGl6cElaam9TVFpWaG1BNkNST3hIQngxQjJsSkJPZ1habzdjWkJwMmV5Rmlm?=
 =?utf-8?B?WlB3a2Y4eWFBMmY4TTRUK1RieWtZenYxRUhTTVg1T0d5c2N5dTVXL3k1TDVW?=
 =?utf-8?B?WWVid3JzVGxCMHJzR21MaVBrelQ1bnBPejdzTnhkRHBaTUk3TEVTRGduWmp4?=
 =?utf-8?B?MTRiclM4K2tCMDZqem1Jck4wSEdqaEoyRVF2RnEzVjdmUlRORkxSbmZIY2ZN?=
 =?utf-8?B?Nlc4YUFNa3lTbFNiNG8yNUxvM3h4NE1BUzhxVE5ldHlZOXRhakl2YmxoaHgy?=
 =?utf-8?B?d0drT0xNUFJhT01tUnpGelU4aE4vSndKU00ySFRCSWg0NGVTalY5NURWVHdS?=
 =?utf-8?B?UThKUDRlSWJCaTRkNHFMNHZWRnBUdWp6aDd6VFc3cWNvVlNLY1F6eGZRejBP?=
 =?utf-8?B?MVZGYmhDbVRLUTZzM0lIMWxxaGxCeFhuYTE5eFMyOE1NOTI4T2tBMHlOaWEx?=
 =?utf-8?B?ODRvNFVrYnR4Nkt2SUFWbkdERktWeDlrQzJxcHFhM255U2dZejV3aHVCMEUw?=
 =?utf-8?B?T1JyL3JyUzFIQm83TGMvcVlCdEZsUmNTcnJEMFJ2d0xJejAyUWQ1OGxpaGtY?=
 =?utf-8?B?NW9RTTNwS0NadWxId0lDdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXNKVVNOV0pKWTlMYTNCT3FqelBhcHUrRFdWTGpUNnlRRnBDam0yTndVTEZu?=
 =?utf-8?B?SEJybGZoOEZkRFhUUWU1eHlBTHp5QmtSY1FSb1VUelBnTVhSZ1VEMnRrL25r?=
 =?utf-8?B?eW9hdGJ1bmJZTkttbTNDVFk3T0hQbG1CbnYweW5TREdOWXNWdHoxcHY1WG1V?=
 =?utf-8?B?Z2xNTWtSQnMxeUxOTWRwWmh1dko1VkY2VGljM2ZxZmZUL3VIbzM4K1F1akpV?=
 =?utf-8?B?aE9ZSHlXUzhUOHA5UXZ5SlVVUzMrWXg5R1Rqbmk1ZTBJVFZhT21JdW16bVMr?=
 =?utf-8?B?ODh2WGR6a2YwUDRTbkhvdWxGSUtyaEdlZEVGaDR0Q0ZzWEt5Rmgxa1RLbWFJ?=
 =?utf-8?B?TVJ6VFFWWEFTVW9iQktGY1B6NGpWWnQzMFluY0kvN2IyMFhUTm9OYlNVN3pt?=
 =?utf-8?B?dVAyWjZyUndVOG45Sk11amRRSWhFUTNsV09xUDYyTnNzcmdMN3FTUlFGc2Zz?=
 =?utf-8?B?emFPRDZ3YjVOVFZLY1BGSEJZdmhIVWdIV05JcE1QSEVxazYxbWVTcnlFUUlQ?=
 =?utf-8?B?MmFEY0VtdXpkUm41Z0pRNGNjZ2IyT05rQ2JINzF0cmpIUzQ0ZXVtakVJWFdY?=
 =?utf-8?B?Q0JyeWw5MGhUVXJscFkxVTZtYUd0MXgrTy9BT0trY0UxaFRoUytzWm5rQjFH?=
 =?utf-8?B?cCt2MTdMOHQ5anJ4SEt4U3hIUWtGWllPc0NSQ3k0VVZjeEkyQzNhK2RTL2N5?=
 =?utf-8?B?dzFaKzkvdXEvdm5Gbms4Q1B0ak5SRHlXYU5XVUtMOWNJd1l5VkVud3FydHho?=
 =?utf-8?B?Wi80MjJoRk5lUVRpODRPeGVrZ2ZSZFBsblJzelRYdTBYWjJlQW9aeHBaSE5n?=
 =?utf-8?B?NDhZYmp1MVpWSHVkcVlCbUJqdThpd245RzJtRjdpT3FlU21ScjRaMXN6NjFG?=
 =?utf-8?B?QTUvTlI3ZFo4MVppMVpJQVRuVkhwV0JjWUJZYWhkQWxoMHVHWWxiVmlFMExW?=
 =?utf-8?B?R1lJV01ndGRiZFQvdDdVZnJjRWJxRjR2QytjUnFkMThWVitpcnR4alpJTG5D?=
 =?utf-8?B?enI2V25HUnNGM1I3emlteFZJdTdQcWxGSnNORnhRWXU5QW1wUXRSU3VyKzQ5?=
 =?utf-8?B?ZmlrYUFsRnJtUHhtMkpaTXFIWGVxd3crbFN0TFBnZFBkRVRDd1FXcnNRSkUw?=
 =?utf-8?B?bXhkYko5YzIxemgrclFHbGx4aWpXQng4ekwrRjFteCthNDFBMi9Uekcyb0d5?=
 =?utf-8?B?WXplUXZkWFBSOHFDZWU1c2crTWlqNS8wN2JmSE1KNEtjTGM0OUxBdVBWT0tJ?=
 =?utf-8?B?ZDA2UjBZWExIZ3FrdUpLME13M2RHcDF1bHpsN2I3Z1ppcGR1d0xXakoralpn?=
 =?utf-8?B?VXZ4UDBIYjJuR1pSbnBHN29Lbjhod3lpKy9RZWZKcEM4cUtjS0dFNk01cXNU?=
 =?utf-8?B?K0VqSmJGQnZPMFg1U3JWQ0ZXYnVVWFlqYTVkZUc5QVd2ZXEwZzE2S3o4UmJL?=
 =?utf-8?B?a2FQOEwrVzJrR3EwSTlibFlvQjMzSjlMVjRjVEpOQ0cxeTUxdi9HTFZqTUpC?=
 =?utf-8?B?Ui9mSjNCMGFUVzd0K2JsQS8yeWwyVGkxMDF2ZDYzRStLZEtjQ0JGbGpHbUoz?=
 =?utf-8?B?S0ZsbEJUaFRCN3dSMkdmWklYK2RWNTZTWktSMVd4KzZTTURmWXNIY0tkcnc0?=
 =?utf-8?B?cEcyR2pYdUtrWVIySkpPWDJWRWpWaXRmNE5odEJXVnlyNnVncmpKTkNvK3Bx?=
 =?utf-8?B?T0xaeEdkbmJXRUJkK3dUc09Nd3IxR1hXZVFGTFF2VTloNktWY2cweWJ6L1R0?=
 =?utf-8?B?QWtDVitwcmEwMEdqOFQrSTA0WkJxNjcwUXg0UzNBTFBZeTFqdHh0QTM3amxW?=
 =?utf-8?B?Znc3RGxnRElUSTBoelp3S0lCdDB1Zy9hZjF0ZE1vbVVRRFE0c0RhbmQrTjd4?=
 =?utf-8?B?SDlweXJZYUtFT0hDSzhTdEhXOXRNN3BNeVJQWm05WFpoNDRvbzh5bFgxUFMr?=
 =?utf-8?B?ZE82Q2RFbzZIUXRQV01FNHFZSSttMGtFZm0vQ2xkZUo3OWtTYTdDZGJNR3Fi?=
 =?utf-8?B?cUJWMmE5QkNHeFdwcGxLT0k4SDA4S3d0alkrNjg0dTRENVRocXBhUUdRUmFQ?=
 =?utf-8?B?Uy92MkRtZnpKdDhTZWd4TlJFKzRmbmxGUTJwNXI0ZmdTZXBBZUdzazN4aUlr?=
 =?utf-8?B?bEthbCtKMXpOUHhVdzdnQ0pPeGFka1dyOS95a2lyVlBaZlRqSU0vb3RXZStk?=
 =?utf-8?Q?zDJAaPI3wDAUrZXT8N/oigk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <004ADB066C57CA4993F77BA78EC6E000@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d04933a-0418-44d9-9c37-08dc839263f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:54.4871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktrGHM2nKjhCJa2F3S2gq9NNAhU0bpnFFhW1sfVviDwjT79bjUnLNICVaozwidC+VqhPextJ6xf/kMR7CXySSw87dnhwucky7/1ApQ1892+s3q5kJjAG7Giwjlip2FUM
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
bi5jb20+DQoNCkltcGxlbWVudHMgdGhlIGJlaGF2aW9yIGRlZmluZWQgaW4gc2VjdGlvbiAxMC4y
LjMuNSBvZiBQQ0llIHNwZWMgcmV2IDUuDQpUaGlzIGlzIG5lZWRlZCBieSBkZXZpY2VzIHRoYXQg
c3VwcG9ydCBBVFMuDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNs
ZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21t
dS5jIHwgMTAgKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCmluZGV4IDBmM2JkNTk3OGUuLjFiYTQzZjU5YjUgMTAwNjQ0DQot
LS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
QEAgLTIxNjksNyArMjE2OSw4IEBAIHN0YXRpYyBib29sIHZ0ZF9kb19pb21tdV90cmFuc2xhdGUo
VlREQWRkcmVzc1NwYWNlICp2dGRfYXMsIFBDSUJ1cyAqYnVzLA0KICAgICB1aW50OF90IGJ1c19u
dW0gPSBwY2lfYnVzX251bShidXMpOw0KICAgICBWVERDb250ZXh0Q2FjaGVFbnRyeSAqY2NfZW50
cnk7DQogICAgIHVpbnQ2NF90IHB0ZSwgcGFnZV9tYXNrOw0KLSAgICB1aW50MzJfdCBsZXZlbCwg
cGFzaWQgPSB2dGRfYXMtPnBhc2lkOw0KKyAgICB1aW50MzJfdCBsZXZlbCA9IFVJTlQzMl9NQVg7
DQorICAgIHVpbnQzMl90IHBhc2lkID0gdnRkX2FzLT5wYXNpZDsNCiAgICAgdWludDE2X3Qgc291
cmNlX2lkID0gUENJX0JVSUxEX0JERihidXNfbnVtLCBkZXZmbik7DQogICAgIGludCByZXRfZnI7
DQogICAgIGJvb2wgaXNfZnBkX3NldCA9IGZhbHNlOw0KQEAgLTIzMTQsNyArMjMxNSwxMiBAQCBl
cnJvcjoNCiAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCiAgICAgZW50cnktPmlvdmEgPSAwOw0K
ICAgICBlbnRyeS0+dHJhbnNsYXRlZF9hZGRyID0gMDsNCi0gICAgZW50cnktPmFkZHJfbWFzayA9
IDA7DQorICAgIC8qDQorICAgICAqIFNldCB0aGUgbWFzayBmb3IgQVRTICh0aGUgcmFuZ2UgbXVz
dCBiZSBwcmVzZW50IGV2ZW4gd2hlbiB0aGUNCisgICAgICogdHJhbnNsYXRpb24gZmFpbHMgOiBQ
Q0llIHJldiA1IDEwLjIuMy41KQ0KKyAgICAgKi8NCisgICAgZW50cnktPmFkZHJfbWFzayA9IChs
ZXZlbCAhPSBVSU5UMzJfTUFYKSA/DQorICAgICAgICAgICAgICAgICAgICAgICAofnZ0ZF9zbHB0
X2xldmVsX3BhZ2VfbWFzayhsZXZlbCkpIDogKH5WVERfUEFHRV9NQVNLXzRLKTsNCiAgICAgZW50
cnktPnBlcm0gPSBJT01NVV9OT05FOw0KICAgICBlbnRyeS0+cGFzaWQgPSBQQ0lfTk9fUEFTSUQ7
DQogICAgIHJldHVybiBmYWxzZTsNCi0tIA0KMi40NS4xDQo=

