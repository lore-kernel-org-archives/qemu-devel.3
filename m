Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B2BC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNDK-0000bn-MA; Thu, 18 Jul 2024 05:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUNDG-0000Jx-Hh
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:14:10 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUNDD-0006kv-57
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721294047; x=1752830047;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FTCMWGArFrETVEZ7yU3ZkCBk/+pk8GMIL4lWkYJ8aB8=;
 b=a+MlWFBmMCq6pvZQhOVBYboyiFvj5g9M7sLjDoKuV+xmdshZeUV37ne8
 zhQUcx1eThwo9xkl3xODf58jCXmEbfo3h0ot06opbYcvSmMztaoXBOT7P
 2iU7jAzjbq2njy7b9ojUAilyRNvhHViaFqYOpjDjL6W1h1W8a7U1EWOyF
 6NHUpmPag4I5ANMmeKYcwC1vzVmVAy6psyCArsjqKQJP05hxaxqh39dAV
 VB1QlEY8QyIkY3HK6/E1zVpFb84RxiqzG+LqUa6jgSnpawjYr/CSpEtip
 Ux9G2YfU4IGvkCeZ4dh3jXNnfwIpoONvkM0owhmNdclm96CVBo9sgEcU0 Q==;
X-IronPort-AV: E=Sophos;i="6.09,217,1716242400"; d="scan'208";a="16734303"
X-MGA-submission: =?us-ascii?q?MDHcZIDaXy1VXky6ksVmLl+fpS4GP8o2NBtCUM?=
 =?us-ascii?q?cl//TdH9+JSEK+l6rJpR9O/MY7BYEEYTPIzE5XfJi8JooOx1Iu4zzeyy?=
 =?us-ascii?q?uh03LruUEk03K9+4QdOrS9yBS6sfrJTjlCnfdCpHVe3l/QIayMe3511p?=
 =?us-ascii?q?X8S/ii03ld4bxOaRtKrjJeiQ=3D=3D?=
Received: from mail-am7eur03lp2232.outbound.protection.outlook.com (HELO
 EUR03-AM7-obe.outbound.protection.outlook.com) ([104.47.51.232])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 11:14:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3v5zs4CWSG/icyu/t33eQ9/69Dj6X9bhDs5O3/eEwmPAIUPE8EqKUARWggrOwdgsbMrPcZiu9RkI3sgXgGOYpTTsg2PCSpNThVZoKHhVpiHC//IjmiRJxpHRmI4FXu5264Um2qDdTCzFWX8OYPZ6jolws80Vfj/yEvpm8kaK8V2S6AqWYBwr3v5SCiRcxz6xnpTQhHr1QAjmgJfPIJo7DmEZWQRpdlorSbzomnRo3rOks5+Yl+BWO9l4o2DpW6B+W/HXCEAP0VXK8P3ql/jWbs346Tn/OozvIF1f8SPw4BNUYZzMwTrx+v09vfpriPvw+Rb+SJeOV8W8+3ZR2wlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTCMWGArFrETVEZ7yU3ZkCBk/+pk8GMIL4lWkYJ8aB8=;
 b=PL6EPbXtAnvyjSp4fG2qX1YG1YLmuD0cymgEgMwnLAKeTLjXrIVJASZcpe94jAKc6b0FjiGd/AyGxfA6Bix4fP1eC0OUGIrSBXThYyEKqNZf6ptOsNvoblKHXzVHh+VvhB9uGidbKSWEB/QKo8vrn+ZGvQZ/GlRWxGGd8p2zFh2ZOoHsQRdNSnEWojYPGyKD+/jqT5PvXLOJSfYiflVr9DV11BZrfImXb2woqhwvA+UZv7pT/mE3k1r9m6gECPWnAYIRGfR4WXq7XHIkPpUNZWAU5x/7V213uOXE8+JnNg/MfuNCYvVXN5P5Nf09ow3dhfbNvad+VYWlIYQaJL9zWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTCMWGArFrETVEZ7yU3ZkCBk/+pk8GMIL4lWkYJ8aB8=;
 b=q1mEy5Yj7vTJ5Il9OUB8/8xxFqic6lIY9bVLiyyIBv+vdHj0YrM9ukx78c0sVY6TSw8aLr7mzxyBfLYTTZFOnFLwoaqLhZ3y6Pogi0iDlZXUrK+16HkrRsxtotFty36Xq54PxXSHs0r9+P3stofwjvFcCOpnhkRQB4BxrJr7krXyPNf1l7WNJr6X6if9P8UTYMpSXvNOtSdNBM3O8ZHqCI+QRGdskjKLVdgDd8rdoEqq6J+e8OrwCr21iqAiPRfpUARWktt0h6lUGH1LsG/UqqSHglELZwUgH0VitFmOQhQZMa4W/n/1yPFHhk7nwSHT+liQPOsMUKf87itFInnVdg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7461.eurprd07.prod.outlook.com (2603:10a6:20b:2af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 09:14:02 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 09:14:02 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 15/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Thread-Topic: [PATCH v1 15/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Thread-Index: AQHa2Ota5MSRxKWD2kaD4H5A3X8u0LH8M9IA
Date: Thu, 18 Jul 2024 09:14:02 +0000
Message-ID: <ffe85ee7-2664-4551-b83b-b99ecb4bafd1@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-16-zhenzhong.duan@intel.com>
In-Reply-To: <20240718081636.879544-16-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7461:EE_
x-ms-office365-filtering-correlation-id: aacc5c1b-e906-409d-8305-08dca709f771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cUtmdkJXaHJTdENyNUxrczlOeFVtbDEzSmVhVHNxNGMzcStuYlBoMVo1Zm80?=
 =?utf-8?B?VnovN3JNY0VXY0pUWHdYWG96cys4aGNKakJmd3l0aGE0Y0VDOUdlQ2NpL1E3?=
 =?utf-8?B?WTVaMUVOK2E5Y29oVTBobnZXMWVwZGpnd2VGSmxIRzk2V1JXNUJzWERtSFQw?=
 =?utf-8?B?MjY3S2NVam0rV3RRMnBkQXRzR2VuWm1UeHB4ck5tUlpVa2FIeTRKT080a1B6?=
 =?utf-8?B?cGN2blhMaDFEbEFUMi9NQ1hRYWhmWC8ybzFGdmhjaGpIZkNaNFQweDJ2d1B1?=
 =?utf-8?B?TWdpOXNYMmJPdDh5eENJSWthWUVaaUlpTmU2aURVU0RVYTBFSGFnQkJRSmUx?=
 =?utf-8?B?ZlFQZnV2QXJ3Q1M5OHpNZ2JPQ0tRWXlsQ1NPVG9RN09GdTR6eXoweGxlOW9x?=
 =?utf-8?B?b3cxb29ENWZrRzByYU80VnhDUmFUZDRIbEdjZW8yWDVOSWtHbktpZEpHdFFD?=
 =?utf-8?B?bldPeGFsMmJqQzY3N0xqUGZyR3F0N2xBMGxMU2RhUWtNOFhoZDdJZkZGZXNs?=
 =?utf-8?B?blpWSFh1QngrVE9EeXRMS2ZxeXc5QlE3Y203bGxBb08ycVMvandodVZUNGwz?=
 =?utf-8?B?KzVoellwMVAvTUhNbzV3QjAwL3Qra1ZKdjNxYjU2VE1HNVo5NkNrd3BmWGRL?=
 =?utf-8?B?SnJxNDNjQWo0QTRyOTh3VnFDa0VEd0JZclpscnNBK2o3TC9oaTlHY0RqMktP?=
 =?utf-8?B?SWRpbzFkSkdNZjRHVjJZdjlZeWJiTE9uZkg0OEQ4ZjduSG5qV05XNVJZbVBi?=
 =?utf-8?B?bzFPTHgycnFFM0E4c1hnU3d6Yk43bkpSQW5YYlRleWwxZGp0ZS9VWUtTelZj?=
 =?utf-8?B?SzFjWWFKVU1scDYyZXkxUElVbEJubE4xQ3NmMEdBTFBSNzBlbGtVOFBxaHNZ?=
 =?utf-8?B?UCtRamRtZVZOREJTdEVmSWhpS1hobmJiUGt2WFhIUmRWZHV6ZnNyRkgyVGsw?=
 =?utf-8?B?UUh4eW5FRTNwK1huTEExWFBkcmY4YTdTcWdtRjNFa09YU3puWVVOSE1PMDd4?=
 =?utf-8?B?WXE1bXlGNVRrZ0JGWi9vckhUU081ZzM2VE1va2F6YkpCUmZjcjk4SHg1bDdr?=
 =?utf-8?B?TGlNTlpPSHVRNHhhOFE0TlhZWWttY1JrUnJnYVhVZ1h1QlQvZXh1KzFmcmcx?=
 =?utf-8?B?c3czbTF3dTVOdU1HWXo5Zjh0VDVnSjNYaHNjYjZXV3FOOXU3c0NNejhnS2hK?=
 =?utf-8?B?S250dys5RGNCTlZlaTVCT0l2eGZzUjllZG5LYUZjc2U5NVpadjdkQ1EwdDhL?=
 =?utf-8?B?dVpTTWUzbm04bGhhdzdaQlVRT2JNSDFheU15Z2VtMUZLRW5CN2ljQkNjV2V6?=
 =?utf-8?B?dE5RTnJzaExCTFZzL3EvMlUrMVFGbHMrZi9sWkZEWEt5RitnVG9YZEt5Qk55?=
 =?utf-8?B?SEVPTmRtUmpabXVtamNsNUFQaHhQeWhhaDF1cVErSnptRzI1U0hzcUtGN2FJ?=
 =?utf-8?B?U2hROVM1M0ZvaTVYRkVvcHhOdjgrNUFlR3BnU0c3QnZEcXB0L0o2NzluWE5D?=
 =?utf-8?B?aWVPZDE2VzhSNWljUTR4R1lDYWZnSmpjdytpYUVRYUxDS1poYzU1ZmZCTkVE?=
 =?utf-8?B?NkNoZm9TZXRrMjFQWjJRek5VQUJ3ZFpROE44NjRkVFhiZDBtZVdiMkR6NzRq?=
 =?utf-8?B?NFg0c1lNSW5vTE9Sb010KzkvVDgxaVAxUWlDMXdzdmlKSFJHNE5NcENRcERN?=
 =?utf-8?B?YW02Vnl0bmMrRGRuOXgzRlZjWXRvRjRLSHhsMGRyYWVwdzF3QlQzK1hjNVFs?=
 =?utf-8?B?bkVVRURlU1VqMHYrWE5lbU9CRDdjQUhtUHFTRE13NmZXVVRxVzg1L2p0U3I3?=
 =?utf-8?B?RFpZd3lBbnEwUWRIS0VwaXZVdkZkdklkSWVHaFo0TTlLMTZKbjRPTFdPZ2ts?=
 =?utf-8?B?SzJBa0FSSFNkam1tUTAxNGk4cFQ3ZWd1d3Y0WUZzaXBaZlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGpHdy9Ya2V2TnNFMWF4ZWxaTjBjSTFKeFh3SGhkbFJqb3pvU3hkRUpPV0Za?=
 =?utf-8?B?MjdENyt6K2I1NzRHUy9FeXo3QklVU1BGSjJhajBBZHhQcklWbTVRdG9TVzBn?=
 =?utf-8?B?WXdaY3JKeVJYekR3SDNWdWdvNXJGZjl5SWZqZW5hTVdTU2Jud3ZVOElta2Zt?=
 =?utf-8?B?MmtSYjdiREJ1dE9nMDI0dWlvQUZ0UEhFbGRNNDdqZVUzY0plVERoZkhHb2dV?=
 =?utf-8?B?MVNKODExcWxlcnVhb2dPendLcDFOSlhKVUZhK0tpSmJWZUJoUWxsWW9LM0NK?=
 =?utf-8?B?U1ZsWmJGYm9HWm01Zi95WHlvckRkOExBQlVQVktjV283S0hvMWlnSE5ncmk0?=
 =?utf-8?B?V0VRYys2RDE5WUJGUXNsNkdUZnZndzVHdXliVXdybHArT0xNRjJrS0gxSjJK?=
 =?utf-8?B?NVh0eTd1WnNaK0RrdmV0Z3h0b2FtY2xyNTFMY3Y2M1lVOEtQQ1djeVdwdjdX?=
 =?utf-8?B?c0p2akJ6MGhoeFNqYk16Z09WU05WaU9ENml2VTJtd0JXdDlWMWc2djVuZ2k2?=
 =?utf-8?B?MzVmMG9BK3pJZWhIMitOd2d4dU5QcFVDUjFsbnZEVkZjU0ZIMFdoZHpuYnRI?=
 =?utf-8?B?RTlPN3FoYjhDaGMvQi9ZWmxqMEh3dDdLd2hUajY0UjEreGVOekg0aE5XNjla?=
 =?utf-8?B?ZWVIR3U4Q3ZCcXpzYmZQTDhmZEpyNnM0VWRuVTJXRTJmWVVBaURyd3RTTzl5?=
 =?utf-8?B?OVVIZnh0YUNxZFdXZ2djZ0dGa1JyemxrSWpRRlpQRUNWVTM2SFVhd1o4eFEr?=
 =?utf-8?B?RUJrcjEwdytTK0loYXdxTVlRSTVWcGxxdHJJNVFvaWdnck43ZjlWMWNZYldJ?=
 =?utf-8?B?Um5UUTJTNEJDNzdCSEo3LzhIQW1pQ1JDRGpNd1VSM0JnMzZzWkRWRjBWSVN2?=
 =?utf-8?B?U20rdG91RUxRWncxWVg5MzhONGpyeEloTGoyQ0ZhcGM2M01QOUROZHdjQ3VB?=
 =?utf-8?B?Nm9BTi91VGVoWjJPc29nUlVidmVMVEtZbUVEaHZtb3FTdUxKT1ZobjVXR1k0?=
 =?utf-8?B?VXhEZElzb0gwcnRGM3d3WHNrbDdQVWEvUnpnbjZIQVNxZFRrem8xWTc4cDJ1?=
 =?utf-8?B?TWdPY1pBMFhSWTBBeFFiYXpETmhpWlhDRm91MjRlL0dhdERCN2pRaG8yZU04?=
 =?utf-8?B?Szl0YWlkT2tzTFJLL1RCZjJKRldWZUtOQ1ZRRVJlZ0Q2bHF2L2ViZzBkaU0w?=
 =?utf-8?B?b054bWVseHZFUXBoYkpOWjZPN0U4R2I3b2F0Z2Irc2l4c1lpWFJiVHJoQjAr?=
 =?utf-8?B?RkRGSitGWno5djVNZi9lNEE5SlJuQ2ZXSkpvNFJFeEx1eXl5SVhzRXowY1NF?=
 =?utf-8?B?ZTNPc2wyaW9yQ004dTdtcUNrZWdOQVVMQjJrL29mYlR0U2MwY2dIMjEwdnJu?=
 =?utf-8?B?aTZNbHVIditySi9NTEtYaUJqbWZTbnhhM3hGM092TnNwVERsdlRWb251NUdy?=
 =?utf-8?B?QXRQTUZadHFaNjRmTTZFVHdvWWVxQ3I3M0U2UU1PbVFHWEo2YTBhRzV0YW9M?=
 =?utf-8?B?T0pZS3VkWXFiQUEvZlJDWjIrcUZrMmRTalc2TGVicHF0eXhrM0VVSkNDWlE4?=
 =?utf-8?B?VnNXQyt0QU5JTzVzMjdNbkdINEVXR1JydGdiYi9RVjEyOWVCWU5mTWxaUHVJ?=
 =?utf-8?B?N2ZadklWQU94am9aNUJzRmNsSitzMjVvNjcza2k3SW9FRGg1QVlkalNlalQr?=
 =?utf-8?B?S1dmNXRlYjFRUWJORU15YUkwU2N0K3NmRVNOODhDK2tYdy9OckpZN0dVOStQ?=
 =?utf-8?B?UE1Md1o5aEl0aXJkQXhxOHdHYURXK2hNQmdkdUhiNVhiOVYwem1NbFdORjJD?=
 =?utf-8?B?TkhVMmZYU0h0akdDT2FEd0xhcHdZeTNtajNnMUFKZVQvd3IrQzcxdU84NGFV?=
 =?utf-8?B?RlVjT3NjMldTUVpwNnI1Y0VNdk9zditmOGlqUHpkSlBsUCsvckVlU2E0ajJ6?=
 =?utf-8?B?YldyamFwcmV2WEsrWDcvQllDOEhPS2pSZGNCR1dEcGFwSTBMQyt4RkNLY0NG?=
 =?utf-8?B?aFBsOStFYzlsYjZ4azFZdUVxVEtqK2EwcGVFeFBvWWorQkhQRDd1WTdFaE52?=
 =?utf-8?B?ZWlNcVFZQy9yb3p0MHlJYlRFcm10MTI4bjQ5bFJKd1ZZb2FZM1pMRjJvSURH?=
 =?utf-8?B?VytqdTdrUG4reWd3SGpqeFdzRkVnOE9pQmFWcnlDUnhJYWxMOVpwZ3Z4enhV?=
 =?utf-8?Q?R/+GhlY+X/+HhI4vh7ZayOw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C1B74702196F44C88EC1981614322C7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacc5c1b-e906-409d-8305-08dca709f771
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 09:14:02.7615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVrZStYxDXP6xf3jktjXM8CicfiId/FKhr90UeJmYjFm3m2O+mbAABF1tczU/rffiwT72goNtbmcY9Ftn+XELn9qrENO5feuN9lGQhjhDM7JOOkh/GFcngVqwhtlM5Zt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7461
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNCg0KDQpPbiAxOC8wNy8yMDI0IDEwOjE2LCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRz
IG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2Vu
ZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBBY2NvcmRpbmcg
dG8gVlREIHNwZWMsIHN0YWdlLTEgcGFnZSB0YWJsZSBjb3VsZCBzdXBwb3J0IDQtbGV2ZWwgYW5k
DQo+IDUtbGV2ZWwgcGFnaW5nLg0KPg0KPiBIb3dldmVyLCA1LWxldmVsIHBhZ2luZyB0cmFuc2xh
dGlvbiBlbXVsYXRpb24gaXMgdW5zdXBwb3J0ZWQgeWV0Lg0KPiBUaGF0IG1lYW5zIHRoZSBvbmx5
IHN1cHBvcnRlZCB2YWx1ZSBmb3IgYXdfYml0cyBpcyA0OC4NCj4NCj4gU28gZGVmYXVsdCBhd19i
aXRzIHRvIDQ4IGluIHNjYWxhYmxlIG1vZGVybiBtb2RlLiBJbiBvdGhlciBjYXNlcywNCj4gaXQg
aXMgc3RpbGwgZGVmYXVsdCB0byAzOSBmb3IgY29tcGF0aWJpbGl0eS4NCj4NCj4gQWRkIGEgY2hl
Y2sgdG8gZW5zdXJlIHVzZXIgc3BlY2lmaWVkIHZhbHVlIGlzIDQ4IGluIG1vZGVybiBtb2RlDQo+
IGZvciBub3cuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5o
IHwgIDIgKy0NCj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICB8IDE2ICsrKysrKysr
KysrKysrKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCBi
L2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+IGluZGV4IGI4NDNkMDY5Y2MuLjQ4MTM0
YmRhMTEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+ICsr
KyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+IEBAIC00NSw3ICs0NSw3IEBAIE9C
SkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEludGVsSU9NTVVTdGF0ZSwgSU5URUxfSU9NTVVfREVW
SUNFKQ0KPiAgICNkZWZpbmUgRE1BUl9SRUdfU0laRSAgICAgICAgICAgICAgIDB4MjMwDQo+ICAg
I2RlZmluZSBWVERfSE9TVF9BV18zOUJJVCAgICAgICAgICAgMzkNCj4gICAjZGVmaW5lIFZURF9I
T1NUX0FXXzQ4QklUICAgICAgICAgICA0OA0KPiAtI2RlZmluZSBWVERfSE9TVF9BRERSRVNTX1dJ
RFRIICAgICAgVlREX0hPU1RfQVdfMzlCSVQNCj4gKyNkZWZpbmUgVlREX0hPU1RfQVdfQVVUTyAg
ICAgICAgICAgIDB4ZmYNCj4gICAjZGVmaW5lIFZURF9IQVdfTUFTSyhhdykgICAgICAgICAgICAo
KDFVTEwgPDwgKGF3KSkgLSAxKQ0KPg0KPiAgICNkZWZpbmUgRE1BUl9SRVBPUlRfRl9JTlRSICAg
ICAgICAgICgxKQ0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jDQo+IGluZGV4IGMwMTE2NDk3YjEuLjI4MDRjMzYyOGEgMTAwNjQ0DQo+
IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11
LmMNCj4gQEAgLTM3NjgsNyArMzc2OCw3IEBAIHN0YXRpYyBQcm9wZXJ0eSB2dGRfcHJvcGVydGll
c1tdID0gew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPTl9PRkZfQVVUT19BVVRP
KSwNCj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgieC1idWdneS1laW0iLCBJbnRlbElPTU1VU3Rh
dGUsIGJ1Z2d5X2VpbSwgZmFsc2UpLA0KPiAgICAgICBERUZJTkVfUFJPUF9VSU5UOCgiYXctYml0
cyIsIEludGVsSU9NTVVTdGF0ZSwgYXdfYml0cywNCj4gLSAgICAgICAgICAgICAgICAgICAgICBW
VERfSE9TVF9BRERSRVNTX1dJRFRIKSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICBWVERfSE9T
VF9BV19BVVRPKSwNCj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgiY2FjaGluZy1tb2RlIiwgSW50
ZWxJT01NVVN0YXRlLCBjYWNoaW5nX21vZGUsIEZBTFNFKSwNCj4gICAgICAgREVGSU5FX1BST1Bf
Qk9PTCgieC1zY2FsYWJsZS1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBzY2FsYWJsZV9tb2RlLCBG
QUxTRSksDQo+ICAgICAgIERFRklORV9QUk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRlbElP
TU1VU3RhdGUsIHNub29wX2NvbnRyb2wsIGZhbHNlKSwNCj4gQEAgLTQ2ODYsNiArNDY4NiwxNCBA
QCBzdGF0aWMgYm9vbCB2dGRfZGVjaWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUgKnMsIEVycm9y
ICoqZXJycCkNCj4gICAgICAgICAgIH0NCj4gICAgICAgfQ0KPg0KPiArICAgIGlmIChzLT5hd19i
aXRzID09IFZURF9IT1NUX0FXX0FVVE8pIHsNCj4gKyAgICAgICAgaWYgKHMtPnNjYWxhYmxlX21v
ZGVybikgew0KPiArICAgICAgICAgICAgcy0+YXdfYml0cyA9IFZURF9IT1NUX0FXXzQ4QklUOw0K
PiArICAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgcy0+YXdfYml0cyA9IFZURF9IT1NU
X0FXXzM5QklUOw0KPiArICAgICAgICB9DQo+ICsgICAgfQ0KPiArDQo+ICAgICAgIGlmICgocy0+
YXdfYml0cyAhPSBWVERfSE9TVF9BV18zOUJJVCkgJiYNCj4gICAgICAgICAgIChzLT5hd19iaXRz
ICE9IFZURF9IT1NUX0FXXzQ4QklUKSAmJg0KPiAgICAgICAgICAgIXMtPnNjYWxhYmxlX21vZGVy
bikgew0KPiBAQCAtNDY5NCw2ICs0NzAyLDEyIEBAIHN0YXRpYyBib29sIHZ0ZF9kZWNpZGVfY29u
ZmlnKEludGVsSU9NTVVTdGF0ZSAqcywgRXJyb3IgKiplcnJwKQ0KPiAgICAgICAgICAgcmV0dXJu
IGZhbHNlOw0KPiAgICAgICB9DQo+DQo+ICsgICAgaWYgKChzLT5hd19iaXRzICE9IFZURF9IT1NU
X0FXXzQ4QklUKSAmJiBzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4gKyAgICAgICAgZXJyb3Jfc2V0
ZyhlcnJwLCAiU3VwcG9ydGVkIHZhbHVlcyBmb3IgYXctYml0cyBhcmU6ICVkIiwNCj4gKyAgICAg
ICAgICAgICAgICAgICBWVERfSE9TVF9BV180OEJJVCk7DQo+ICsgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4gKyAgICB9DQo+ICsNCj4gICAgICAgaWYgKHMtPnNjYWxhYmxlX21vZGUgJiYgIXMtPmRt
YV9kcmFpbikgew0KPiAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiTmVlZCB0byBzZXQgZG1h
X2RyYWluIGZvciBzY2FsYWJsZSBtb2RlIik7DQo+ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+
IC0tDQo+IDIuMzQuMQ0KPg0K

