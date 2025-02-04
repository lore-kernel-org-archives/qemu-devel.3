Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59214C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 13:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJ1u-0000sG-Sj; Tue, 04 Feb 2025 08:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfJ1q-0000pw-3k
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:31:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfJ1n-0008Jb-Pz
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:31:49 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514DRoE6001464;
 Tue, 4 Feb 2025 13:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=SJODv9lufgw/J0L5RAcdqhx02Gi7LR8s+NJlzbM8M4s=; b=
 ZcR76AU5UbrSYmbXR4fwOZHEjHFN0tBVBU2UxBwd4LxlQMnCi6y80a8Ke3mB8bs8
 0K+aifsg6fYiF467n0LepVLaImHkDUavVNY9tTNc+bBYG2Xo39zCh+h/MvNL952d
 CLnv/8tCGvCQPBrqF+Ei1tUD4VQnqvnKDDEv2sgA3L+XrJdTRnvify0rQTYumDyz
 Numl0yz6+C0xdx9hmIpjUSfOs5seQuWP78pukfUc79l9W3eIjLuxC9tqIdzxpIuh
 XU3AVOUmC33tHe1kZ7Y0B1fj8OC5lJb0ZAY7fpn1cUowkz6nKNAP7cYEVPMVlBFx
 4eRvITr+JGlf16/bJGZTEw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbtcthp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 13:31:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 514DMIFf004878; Tue, 4 Feb 2025 13:31:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8fp08er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 13:31:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LambKzZmOGQgzmU81TEiuElOHfLg9bCkZV8V9RXOqeVe/HbHYFL3EfZ+yuxLz36UxOusTCs554Bo8nwjPjtiz1YiTLqFYvEBhXfPlx+rQaYa+UEw2b9OSgywxQXpuD9+AhoNm+dz+1ARCkUy53cK3K5D6Bhx8YCyrZHJDA08ad98o6AU1Aan5d2OkkRSY2QhkgU+s1Joi9Z47wdGv4Y+02sA2ZBCYJYT7DomhyUBlAksDw9Q5tIzCz2PajpmVTm24rv8UNlPjSLtAo0liQVuNe2LP3f4hmSG9JwTLKXMVHVH4RO2xMR4sLW3wkHGel2sh+NVkCstlBYeeihzmHQkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJODv9lufgw/J0L5RAcdqhx02Gi7LR8s+NJlzbM8M4s=;
 b=n3I1vrlA/VzzwisEj8DBlc5m5SXTdDjxr+V1y84IBbd+TKB3Hiz55RIEamDiNYjDK6xKoTbAQSPd+LZf5GRuSgyabcCK2f/JAsi3oWWQHccN6/cH9EQl7a7xSNPvcpm2Go9gj6fiRMwNDWXzHP9BeZRIDZ9angZuGCOy8iHRohRMJ3AGKfHATYPwtnprUoDGMlEPzLA3VnvCMF2PHFdG5pnRlT2vCxOXh+07rwpyk4CStKlGtdxH9E1hyO9aHUh+K4H/jKk1v3J7+q9ECKC2xpRz0XTVMK5+Kq7l4kdGxJpclyYzO4Bosr2sRxuPEr1kpHWeDdjAsml0+Bre43L2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJODv9lufgw/J0L5RAcdqhx02Gi7LR8s+NJlzbM8M4s=;
 b=EurkvPFrfx5egl/QfNY3KF04kOkqRtjUOoySDnzxIL1CLhLJ69+estyxNg00m+WH7qodi5XT1w8XAmb1K7p5fqkpy28D5sJ0c5EPN2PCTFuIcf7e7Vce/HRPH95tatOeRU8LkGGrbdCAiObFN+dmqw884IIz7TIWuPdoGgquBrA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB5884.namprd10.prod.outlook.com (2603:10b6:303:180::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 4 Feb
 2025 13:31:40 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 13:31:39 +0000
Message-ID: <8599e016-4ea4-4c1d-b4d2-c583c57a9558@oracle.com>
Date: Tue, 4 Feb 2025 08:31:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINER: Add a maintainer for CPR
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
References: <20250204082859.846886-1-clg@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250204082859.846886-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0022.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 070fe4ba-9b2a-4244-893d-08dd4520414c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWlSeVNudFZwNjRtNHZXNnNyS2g3bW13WVc3ckZ3MUgvSlllU1lvdDBldGEv?=
 =?utf-8?B?U1lKVnkyZUpINXhERXR6K3ZDYksvZUdNcXN3REIzM3hObHFHMldmWUl5ODNo?=
 =?utf-8?B?Q2c4TXZHbHJUelpZNlJCK3NxeW8wMlYzdmpza01Qc3Y1T0ZPeElZM01tZ1Nm?=
 =?utf-8?B?dU5DSU5MSlo4NlN4dUFqQ3BKL2JXR3lzVHlJYTROTlhEYldQUURobFZoaHNM?=
 =?utf-8?B?OXN3S0VCU2dOd2IwYnRBK1pwdFpMTTk3c1Y1SGYxUmVSMEpzVlF4SDEzMFdi?=
 =?utf-8?B?bk9IODNXRDBFaDFiejMvVGxIdkdxcUNPdE5yNlc1T3R1ZXIyd0xKQzMvYzZR?=
 =?utf-8?B?djhyWTF4Ti9oOEJWUzZvbS9iY29Yd1I4ci9uZW5meE80Zm84Y1F2RjNNUEkw?=
 =?utf-8?B?L0ZSTHdGdHJtUzdlTTZOYTRXZ3lZK2VSRmlwbThDdVU2M3FZOTM5VmRSQnhD?=
 =?utf-8?B?a216U1Jvamh5ZnBUcWZBSmVMVlRNbjdkYitBZUVtcFVhN2Z3Y2ova2k5UUF2?=
 =?utf-8?B?ck8rRUVIOXFaTC9JSU1Yb1hwOFFjS2xERU45aFVZNzI0eTJLREE4ekFoSWdw?=
 =?utf-8?B?THNrUWJjV3JpK2g1Nzl6WGVtNGdlN05LUi9MYjNYa2FmOG5FUkp5Vmx1WXAr?=
 =?utf-8?B?UFF4ZUVqcGdTN0JCMDZtM2RQcjJSZk5YSlV1YU44NkMzaXl3QTE5VDc5cUwz?=
 =?utf-8?B?RXdVUzVJN0lEbEpjZldMSncxYnFNQzdnTGpWYWVocFFjTjVrVUI4dG5Rc2hl?=
 =?utf-8?B?R01JZWxuVGlNd0tHSjFVYUtaUUY2V0crb3lpQVFyMmk5S2VjTURSd01NVE54?=
 =?utf-8?B?aThOaGFIMGxuTThEQ0Z4RjFWVXhETlJEdkpqTW9BZXUyb29EUEd1WnBlMWJ5?=
 =?utf-8?B?U1NIeFhsa0ZxbHhLTzBGbE84YXFFZlY5TlRwMDNZcmZsbWp4SjVyQlZsYlo3?=
 =?utf-8?B?UzY3dWh0OWM3TEptcTNyeHlpTVUvR1hhREx6b2R4MkYybmF6Z0xma1c3RnA2?=
 =?utf-8?B?VjRHS2ZmczJmakJNaTRVRytnQ0tHc3JpU1diejVwTjV4cU90TTVYUXRQZlcw?=
 =?utf-8?B?L2pGN080dUxiNkdMVFRhdWl0RXd6clh2L2dTcXJoekRaYjB4NWdPZExCdlRj?=
 =?utf-8?B?b0FXaExoZjg5aE8wejh3bjZWVjhrU216TDRrbE1DK1RGMTRRai9Fb1cyeVdH?=
 =?utf-8?B?c2YxNEkwR1B3eUFDbTkwNncrZDZXb3pXNXFpUDgxdDIzRHdySXI3NTMwdHhn?=
 =?utf-8?B?UnAvRENPMEtXY2VQdnF0T3NtRFUxQlJsVVJaV1hWSGtmWXRuUUQvUGZsZzJ2?=
 =?utf-8?B?eGgzR0JsUE8wc09qOGZ5TDV5dGRVVVJBYTBRTjVab0hhRzNqK0R2MllCRUFI?=
 =?utf-8?B?amo1L05OS1NRSE43R3RYUDNtVVRsQVpGZStoeXFXZzFkTW5QUm5rNy83Sy9F?=
 =?utf-8?B?OTJRcXg4MGJIbHhMczRRY2tqMitMMjlDRlA5U1VTUThMZjlHVkMxQnViYUlJ?=
 =?utf-8?B?T2ZiSURIQ29PS0lVUGtxY0lLdW5UMWIyc1IxSnovY01ZMHM2RE5YV2JTbDcr?=
 =?utf-8?B?cUVEWmd1UXY2L2F6Q3JmamlSR1QyWnh5aUhiTTRlZXJUMjkwckgvVlJteDRs?=
 =?utf-8?B?aUhWYnRZOUlFQVJVSTRKVVNDZFNiRnkrbTcwOWhMTlB2UXU0RVNLandNNFVJ?=
 =?utf-8?B?aWh4cEhsdlFnN041M2dPZW1rS1l5YU9vVGpSSlJGU0w2dVhZZEFUeTFzMDBv?=
 =?utf-8?B?bGZhRGI1MVFWRkZrV21kZVQrUDQrbGpTTjdxYXdFZk5MNWx2RzIwV1pXMW9W?=
 =?utf-8?B?U0hnZHBLSzQ4eCtnOVRNdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEdJalY0R0JwSVVCdmZTUUg3VDZIWnNjV3ZpcUx1QjFPMlpzdU9DUkhlaE9p?=
 =?utf-8?B?a1Y5K2RDK3JxQWQxT3I2Y2NzNDllOTlRZlJyeFhWMnRyS2tZZTJLUkMxSURL?=
 =?utf-8?B?N1dscjVBZmFDVHphTTZSS0l5cnRIZ0w1VlBsZ0h4MGZLUEZwOG5uWWhjZGJl?=
 =?utf-8?B?NmpyNXBNWjkzU1duR0krcGJscFh1YlFJbDFsTjMwaHVYOEN4T3hJUkVDYUQv?=
 =?utf-8?B?WmZpQkRCR1NjUExkVFpvVGViS1dPeFh0UXVoKzNNZGxiODNKS1U0bHdML1V1?=
 =?utf-8?B?OG9yc2gvL2Y0a2YxUzFmdWQzYVEybDhSWDE3N1M4NVNhWGRmSG10T3MyZDZ2?=
 =?utf-8?B?cUlpZE1xaENjekFRMFo0RFFsUDk5WmQ5Y2lUYTRhWE84OEVDclY3QXg0dGRY?=
 =?utf-8?B?VjArZ3l6MmRKY2lGamNDMDF4SDFiQ3JHU2x2WFFMT3RYam9VR2hZSFBiUzJI?=
 =?utf-8?B?ZVpCb211WjR4dTMxU1JZT2tVNjBFOUx0eGxvUUk3bUgydUQ1QVltYnQrY1Na?=
 =?utf-8?B?QUNvb3NBREEzT0pNM3pvYVFRS25Ha1llbGh2RUlXck8vaXdMQSsrUzRZTVow?=
 =?utf-8?B?N1VTRE1rVUgyeEFya3cwTlQrWkt1MzVZazJQaFZrdnpncEdpTEErd2d3ZWph?=
 =?utf-8?B?SXcxOGtHTUhLTENxZlFwTm51M2Mvdk1KVXVrUXdoUGl4WEF2K3FKanVocW1L?=
 =?utf-8?B?VTI4NlgrMHBDTTdPQ1c5SkpxK0RzSnQyMTJXOGRnMjhiMW5RdmFrd3ZyeVpx?=
 =?utf-8?B?aWdEMCsxeGg3T25QOXNvOUhCbzNuaGt1cnhWR2NpRFRPWm1VeHNOVnlLWElT?=
 =?utf-8?B?dkNzaU43UkVncFBtdVNVcUZ0cWZQVzVTYWQ1dHVmT3E3VWltSm5uSjI1WXAz?=
 =?utf-8?B?NVZLL0dGektzR2x3dFBqUHFlREJZck5Teng0QkpQbzJOeUxBMHByVjQ4Yy9F?=
 =?utf-8?B?OFJNWHEzYzBGU3ltNFZ6KzkvdkdyZHNSeVBvWEpaS3pZdVZKZ3czek9Pa2cr?=
 =?utf-8?B?RnZmTStXUWlWUDFyZUNNcTRuamVLL1pqQVVZcjNON0lVQWpoRUw1cUtEM3pS?=
 =?utf-8?B?aFF5U3Z6c0Z0TWpQWTZRYnpsN3VBT0F4aS8zTXNOWUJQaW5IOFZtNXAvbFVt?=
 =?utf-8?B?cmx4ZE1BS1RSSE1HVEFCMnllZDdSTVVFTGovaVlaT2ZkdDZHcU9XUndiTEFF?=
 =?utf-8?B?R05seFI4R1VyOEYrODFGMEVlb015TDgvSHdnSUxvQ2UvUDZDUG1NaG9vaHha?=
 =?utf-8?B?UTFoc2ZnTVY5R1ZwQ1A0S241bU9YU0xNYnNCeExFU3ovTC9DSGpkWXdvaXRq?=
 =?utf-8?B?UVRDWHpnOVZzbUFVWFRWeGVqOW0xVCtIdFhxaEdpOXRPQXd6cG9qN2xNOHRW?=
 =?utf-8?B?bUR1UnBqdVhpNjVPZGVYMlBnanNiVWo4eERSUTBlYUlUMWI3aVI3enp1N1JV?=
 =?utf-8?B?WVM4clMvU3FqWjAwK0tBaDNoL1pLZldPUkFGaDBiR2ZFMUk5SG9LRmtiblY1?=
 =?utf-8?B?TlB2czlON2g5K0ViNm83SElwQm9VeFc5UGVIZERWS0lSaDcvYTQ3V2pmcDJJ?=
 =?utf-8?B?RE9DM2VtQldqZGtib0Y1K2JMb1NjR1pock1qK2N3bW8vb3lNNm1HQ2x1YjRP?=
 =?utf-8?B?UHorOGdqdEJxLytEc2lEQ0daRFR2QXNLYTUwRzFscGpLMkcwR2Qxd3c5R1Jr?=
 =?utf-8?B?T3Y2bGxvdE9PRHU1djdrSDRYWFdaeU0xa1QxQUt6T3hRUjVuL0o5bWtTdDcz?=
 =?utf-8?B?QXplUko0VjR6c0I0akZDSmY0d0x4U00vVzB3Uy8ybTNCN1QxWEdXeGJSUERj?=
 =?utf-8?B?NXBOMVRhLzYwZ2VKbUZxSVpyR282NkFHcGFWRElBRlJGU3ZGcXB3THJ3TkFG?=
 =?utf-8?B?Um9nNVZaWFFCaFhsZC9LL25LOXd2c1UwbmZKU0RqNlIwd3oydU9BVFdPdjRy?=
 =?utf-8?B?WHlJbkdkcDJacHE3VU1XYkFWczRxM2ZUUnhxV09maWZJTnQ0a0hjcURCRVRE?=
 =?utf-8?B?Z3MzTjdSaFpGcFBmSzA0NEtIaXI2djluQWhFS0RLRk1LaktxZzZJYm55dXMz?=
 =?utf-8?B?MjdZTXN1cEdndXJrazgyeVVKOGRuZEI5NGFCM2tkdkZRQVp5UmVBdk1qbTJz?=
 =?utf-8?B?MlZ3RzJ2SUtSWXh1bDFLam94dlVpSDFkT3hqQm1xdkprRTVvSXUvSWVPblJ1?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 50LHCaehPPD8m0k0W4tWYvjeAKm+wAy+u5mocSiM91CrtKKtSpZtax4XbA7lBfjzw0n9Vz9LSlySos2fQBI+HGKhasVWtfwy0O/IJ17qf26ug7DoZfmguH/g91XXPB5vmFHkMWEToPA+qEGjug05Xa6GP7150UnW+riKUhOyltYTABmAx19TSgSXWh1mt+u3TNgr4XGAMd0lnmGlA3DO7oYZFsbtVeoQ8jwwgAj+DCB9xAmdsz+B7t3oq/HyWDos3t/bqXN+5FfGq92FR8H4Vw2ZFZfmJ2wSQjX4JMZazKBVGaxgSGEt+einG8TuyItitIerdRkEYaJPsMYQKNc3nxe1h1m6Q8DwoyqZ/T/ecOja4tWrtxZ5Q2Y/NFdDPCj4fmmocWcExCQfLsnx3OKkvJW8PQIgAp9Y2NUhXps35BC1Pdu6v3RHA9nqp+lfY/9JcmXtimcuFA/4+ispvn3A/KVKgWLppiHlueGt87NidplG5wPap9e5yfBs/P/tDKy15gXJyIpYCScUeUx39CdzSmPZHwrQy3u3yEgizhOxh+ljQv8sHoABkZJ3AYHdkeaiUFkJ6O/5E7iYV17YO0F79rsMN9LH/1jXolXLOkQFuBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070fe4ba-9b2a-4244-893d-08dd4520414c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:31:39.5749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvwDJVTQgvpEEKl66uMhCNFfTRcUk2UCIwpbmodd5KQerh6Ba4ng0KM7zjfS3HmVhxIrvd8YMXZnZl9pso9c7EYzQTxSCNeHQohqCMQgjtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_06,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040107
X-Proofpoint-GUID: Ly-Vf7mZyhvaRxViYZHsTOgI-exr0hWg
X-Proofpoint-ORIG-GUID: Ly-Vf7mZyhvaRxViYZHsTOgI-exr0hWg
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Cedric, CPR is a mode of live migration, integrated so closely that
it makes more sense for the migration maintainers to maintain it, and
consult me if/when necessary.  "migration" appears in 4 of the 5 paths
you list below.

- Steve

On 2/4/2025 3:28 AM, Cédric Le Goater wrote:
> The CPR feature was added in QEMU 9.0 and it lacks a maintainer.
> Propose the main contributor to become one.
> 
> Cc: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index db8c41fbe0f9..efb9da02f142 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2943,6 +2943,15 @@ F: include/qemu/co-shared-resource.h
>   T: git https://gitlab.com/jsnow/qemu.git jobs
>   T: git https://gitlab.com/vsementsov/qemu.git block
>   
> +CheckPoint and Restart (CPR)
> +M: Steve Sistare <steven.sistare@oracle.com>
> +S: Supported
> +F: hw/vfio/cpr*
> +F: include/migration/cpr.h
> +F: migration/cpr*
> +F: tests/qtest/migration/cpr*
> +F: docs/devel/migration/CPR.rst
> +
>   Compute Express Link
>   M: Jonathan Cameron <jonathan.cameron@huawei.com>
>   R: Fan Ni <fan.ni@samsung.com>


