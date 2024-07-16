Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E2DC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeOT-0000JY-8N; Tue, 16 Jul 2024 05:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTeOR-000070-Iv
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:22:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTeOP-0004IR-Mk
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:22:43 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G2tTOx025506;
 Tue, 16 Jul 2024 09:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=eDshltXx3HVGfZbxNZctEd8RmGl2Vdp6g3HGT4KJb6M=; b=
 Af32xpbCxxQv0NJgyz/dvIxG/THAGjcQbCIMR2KvByLkejwG+r5BGfD9lQxiPW3M
 7peoLHEAcnY2ka8OI6fJP++hlHjv1bK9rC+yfd1lDXzWoMu1EvoqBIfaRa31D6Iu
 6L/MT5L8l1UIQ7PAEMimGwJQcU3Mb31oK7pGhtQOgU+yZtCjnM9gt9x4Lh8bQo4/
 9ssyhiBt7KDgEJkVVHzo6x/bQNjLM9krV+6KEe1Xe0gOWvmu9cm31I0Y5NFmGuFi
 X3po5H/rtv0gybVDqaK6xCQAccLNVh0LXLLwrBRnIX0uOhWrIp63ZdC5S7sKHqCu
 8K5Q7CxfjV7WCeU/9xDacQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bhmcn6aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 09:22:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46G91UtE040545; Tue, 16 Jul 2024 09:22:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40bg1935xh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 09:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzkb0htBJKxF2JPuLb2YMET2W61GGLaukCll+OJZ9s51dv8ap/eqzObgdGILApTNq/mfX5FcdiT3FJQ3ru9Hlf6NS5WMDz+3cXK1sySm6z2UH4A33UlpGxCltbZ8eUtMi1a71LqWnYUFw24tIOrr9PUR7RspEMdExeZTps3Gl4pArYiOsthP4LooefyZYna6PrjiLa/9AOu95ICTapeRjxT3ATEZbtHurxEjtGasFLCAHYCnwqMic38dPcmqquazT9aQPl1HIDYpcx8wv0Gj+JsF6dA4f/c1Nkkkg81bSoFZt5YC2DxS46FusskCAJ3Hd7bM2EavIdkvfl2fxE6d0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDshltXx3HVGfZbxNZctEd8RmGl2Vdp6g3HGT4KJb6M=;
 b=aDyFLcLdTdpermQXM1Rc/zgeyzmwYwDX69OkYkKFJDoFPD93eNFQzlkWll8+KvfPmb+shc6fDH6Jus7WkTiGMqWWzIX+ZfwyyxNd+4oDN5O/JEmdzkCFT4pSZr5UEHwzwvVMwtP57iIgBq3U+yTIPFMM3qjeU38E5iLcwV27ADGsrO2ALvjWkrnr2mqg3zZo3V31Elo2AR0qIkvhiqnGrdXB4m/8MKbSd8sSlsl+yAbNEpjYMB+XDn3uGqgooH9uoA6L4U4az/4OcUhgKSCgsc9bJDX6zP8CBG4jOW+csgEF/6RdRf0YcwGaNtjaeZLaAKPIspR9ce3bU8Zrdby+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDshltXx3HVGfZbxNZctEd8RmGl2Vdp6g3HGT4KJb6M=;
 b=KCXGmzmiK86dQcpy79tELqUxkqqBcXbalfhe11JKkqslLGesUF2UHObQvFq7UCZU5XyN9TvuCkTb0+MtFAJ+X23C7Z2Z3xiYVfaNNJYUdOz37yFniFa7h41y4eCjzJpJod2QfXQazmSVp7IpfodQ3ASrFfhRUoI2mDF2lqHV+c4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 09:22:33 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 16 Jul 2024
 09:22:33 +0000
Message-ID: <c7537753-43c2-4bba-a5e8-79975f91bde1@oracle.com>
Date: Tue, 16 Jul 2024 10:22:26 +0100
Subject: Re: [PATCH v4 00/12] hw/iommufd: IOMMUFD Dirty Tracking
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cedric Le Goater <clg@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <SJ0PR11MB6744C37D32B04773DCD00FCF92A22@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744C37D32B04773DCD00FCF92A22@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::17) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CY8PR10MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: c3779e7d-2f49-4390-0dcb-08dca578d30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTdpUENZY2tJYlB5bmxnTWFtd29laGx3NndyWVJIcEtJaHg1Y3diTmtZTjdS?=
 =?utf-8?B?YWZ6MHZDMHZ1YStoY0YwQTUzVmdoSlpjK2UydTlTNXlzVHRIbEZ4SlJCQjhq?=
 =?utf-8?B?WFhVd0k2dkkyTy8vN0F3WXo5eGs3SkZWNlMwaU0zQ2lMNDFuaWpWek5aTWIv?=
 =?utf-8?B?WlBXOG1ZQ2JZMlpFTzZqeHVSeEJiZm5JUkY1ci9Pckk5YUZObmRnQWhOY1FC?=
 =?utf-8?B?eTJUVk54OGhuYUpZamFINnB3MjJ6bitxMW9ZNkp1cW1mRGxPbFVINjM0bHVT?=
 =?utf-8?B?aVdlM2d2N0ZDMUVETllCUnBkdGErWlVSdmJENWw4T3RmV2p1WnpRd0FZSTBY?=
 =?utf-8?B?aW93aE1UNFJIelR6NmNYaEVzSFVuQS8wbWpDV1pzM3VDVUNXUDRERjJXcUh5?=
 =?utf-8?B?SjAraS9iZUU4M3J2SEJ0K1NCWDdKNitVdEZmdGw4WW53VWowMUJHemVUZGVV?=
 =?utf-8?B?YzRZSWE0TkQ2ZzNPL1BwSEhTRUttakNqZkJydDZLc1paU3ZubTlaSTJWRVcy?=
 =?utf-8?B?K1hxNUpKdk96aVNDOHRtM1JuL0J5SGtQb1JuS2FNaThCREw4QklLcVgzK2NJ?=
 =?utf-8?B?SFpYZzFKK3Njb3NtWHk2bmZJRzRMMTk3Y3JpRFU2eUhIN3AwYWR2bHY3Sm1D?=
 =?utf-8?B?cUw4eXRWbWNhdlVia1JUVlJQRjF5SGdpelBMd3E2ekM0YVNudDFMS3F4Rmt4?=
 =?utf-8?B?U25ZYkQxcjdqTjhJUmZMZ05wcEk2MHpnb2swVHAya0hBWEZZZkpLOW1qbXAw?=
 =?utf-8?B?aG93N3pWS2ZwVHNKU0dpQm5wZS9HWmZTMjhYd1B3QTJsc01EUDEyaXFTamhp?=
 =?utf-8?B?aytOcEZuMS9kMVVZTVVVM201c1pRUTl2SGNLKzhUVElVL1N4NnZJelM1MEJa?=
 =?utf-8?B?aUgrTmw2anpuWlljbUhjYkpRMDdWZTZONkZjWkFUeWFKSjJQZFVMTW8yd0lu?=
 =?utf-8?B?b2hSdGZOWjZFbzY4YUs3Wk82OFhjQ3lST3JDNm8yTXZVb1ZydTdFM21sS3JI?=
 =?utf-8?B?RFAzSmQvZXZGdjZRTzZGTWxKTDFibzAySjdrRDFYWDNLTDdNLzZnU3h3QW1I?=
 =?utf-8?B?bUtueEFqZ0hocE0xbVAzOEpUcExjUDZLUXhPYW1HU2hQaWZVNFdtNUVoWWdG?=
 =?utf-8?B?TStvQkFMc05ZSU1JdDBmL2twdTZYUDgxR3FkZEJJUitrb0QySXdlYXBiZWVG?=
 =?utf-8?B?dVpPem1Xd2tCcTNUZ21rTXlFQ1I0bkxsL0lwOWVNbVJ2NXJDYXhpTUUvTnZL?=
 =?utf-8?B?UXV5WnNBM0JFeWtGL3Z4STdCeXhsUFk4N0k0dVlYQkt3MXJhQ3p3bVlOMVJ3?=
 =?utf-8?B?NVFueEU3bUVpektaUUU3bURWZU5wWDRmTDcxdDZYNmlxaHQ0UnVsR1VBMitw?=
 =?utf-8?B?eFd0R3o1Z0themk1MGV5TVRjYWg1WmpTTC9QVWVDaEpvOXhBQzRReDBETmh3?=
 =?utf-8?B?TllHYzRXTUdxYnhlMG1KQVl3U09FYzlLRWRjTVdPcjFTeFdrdVEydlhEYnBU?=
 =?utf-8?B?MXB0UkRMUmJZa25vNThVdVRFS1l4cWNQN25ZNFV5SXhkRXh5dWdsTmxXZERI?=
 =?utf-8?B?Z1N4Mi9oVGNwU1RUYzJqd01JQVoxUytjT05VNCtpZWlqcC9WMGlmclArRDZN?=
 =?utf-8?B?eEhFMGRSbnVGRkxmekxMUy9VVWFmZU1zNkY1WVlzaFdNbVdsVWZTZ1BKSGJ5?=
 =?utf-8?B?MGZGTXpqQUFqdmh6RE11TlpJUnMvQkRhUTZqQVBjaXJ3dldIK1dXTGFJVUIx?=
 =?utf-8?B?OU9mbU4wQis3cVBlMjNhNVBLVndnSG51YXpFMElBWFhlU1BXN3Vnait5eW10?=
 =?utf-8?B?UDBXUEZkNkJ3YVB3YkpOZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amtZeFRHQXV0dGNUMURXMGgyalk1ZUhmQmpjSGIzcWhXM3BNbkZ6Sldjdm9u?=
 =?utf-8?B?TU5ldGh6MGdoN1ZSOGlrSytSd1hqMnh1Y3NDZVJGdW5YOC9WcklVMTYyUUhQ?=
 =?utf-8?B?QmxvMTUvUGMvWllJQTFhNTdzbi9BZ0hmZy9BWWJVQ2ZPYnQ5ZWlnT1l5WTN4?=
 =?utf-8?B?QU9lZjVuZVdYUVA0K3F3eHU5UDFYZnhPOEQzNGtBQ3JSK1lrNDEza2I3MGVJ?=
 =?utf-8?B?SmZzYmxFSDBMWUtYZnhhL0VGM0p6ZVY0QjJ3Um9PTStKRDEzQTJGWGpRazVC?=
 =?utf-8?B?YlUwT3hNZU1mZmx1aHhpNGZQTnoxQm5aanV3cWE2TDIyVjJ1b0k5MTUwblRQ?=
 =?utf-8?B?SGJkcVZuVExXSmpvbmZvSmJxQmdCQm9zV0tuUHloRGJIRDZBeXdiMTRUOUQ2?=
 =?utf-8?B?MEZNcXhQaUdMelNYQXR3SG5neUlmdXlaaVVlTWJxTkRBQzlCL3NVYW00WXpS?=
 =?utf-8?B?dHFJRW96dGhYaGZldXMzS2ZQVzNPbDZVS2ZXVWVhVnVCb3lkSzROOEdJS2JH?=
 =?utf-8?B?QWRCR2ZOM0o1cWUySlFpc2tOSnJWdERsd09zREtVNEFvNFFqbEQxSzdnUW5l?=
 =?utf-8?B?UXpmSlpmVHpZeitNYnpqeHVXZjRQcDZkaUROMmtFa1pteU5rOHBjTkdrSG15?=
 =?utf-8?B?RWZTUnJKMkYzNEEwVnhGcWltNUhqSmY5MTFGcWJBSzFmTDQvMHFXcnc0Y2Fp?=
 =?utf-8?B?TFpwWjFCbjdUVnZPVjh2WCttSjV5Rm00WnBEdUU2N2lZZlJGZ3hZZkp4OUxx?=
 =?utf-8?B?b0FNOUFUa21NWldIRHhmM2FTTUhyZHNBNER1bnJyQ2R5WXovZ002NmZVdzdU?=
 =?utf-8?B?NjduRy9FMHM2SGE3a0pWeVE1VWtVemUxdDVEamJDMmdtT3o5V1hMTndKU1Rv?=
 =?utf-8?B?QlpOREU4VnZualpsZHFKUVduMXd5eEFJOHVYenFmOUdnaSs5ckF2dkM5dzdN?=
 =?utf-8?B?ZnNTYTZSdUdKeGhobFNPR25tcVZMN3VuQUxNbFk0ZWdXTWJHdTZ4TXZRYnh1?=
 =?utf-8?B?OXFxSFc2NjE3em9tRzRGak9FV0FtaUtocXBpUUFrbi83cmFvTXl1eDZDbzFL?=
 =?utf-8?B?L0lWa0VPM0JROE9nU0hDMWcydmxzUEhUOUNGazlVekpld3E0ZmxqRnBqMnM2?=
 =?utf-8?B?a2hVMENYa0FVM3Fvck0vdUV4ajlhenQvcVJ5b0JjeFphbU9Uc1hhSnArQWtJ?=
 =?utf-8?B?ZUN4bHo0K1huOHRSd0RybGJDM1J5R1Fna3lxSlZIVG93cWRsV1d3WlNIdDEw?=
 =?utf-8?B?WHJINUMyTnRlZTN4TmVYMjMxMGoxcDBDKzhWVTdEUXBzTE10V3dBbkhIUzVJ?=
 =?utf-8?B?YUpJS2NzU0p1em94bU9GRjFQZG8wdnVlOUVtS2hsalQ1dVlIVktwQUVzZmtX?=
 =?utf-8?B?Q24yWWdGUEwrMS96TmJGU0tkbkZaM0VHWkNJTEVhaFpQaVEvV1RaVHBVZWYx?=
 =?utf-8?B?WlNVc1FyL2xHQ2NVTWxJcjlNYUQrYkQ2bmc0RWc5Z3V5cVhWa2IxbjFjZDZr?=
 =?utf-8?B?dnpsQ01GaGlndUY5a3c3aExuVEtBWVFCNFJTT1U1cyt2dy9zU2dPY0FKdFh1?=
 =?utf-8?B?LzlVZEUvVFJGTzZGRkVCQlhZcUtWY2MxQXhKS1RaMm9xb2EvcjM3SFNwdEd3?=
 =?utf-8?B?bjRmeTU4N1FOQnVLV3NBSmk1SWM3bnIrSlc1YmVKTysyTHFhWHBKRGxMSThK?=
 =?utf-8?B?Zm04ZTNnbU1qRHZUYStOVDErWVhyU1ZpeFU1SWxWcExWWVBrSXZBdCt4cE11?=
 =?utf-8?B?QjFuTXJEYXY1Z1ZSRWVVcWxkY3JYSTYrbXR0cmdpblRCdThQcWtVUENXbFJB?=
 =?utf-8?B?VGRlVGIyZVJRenZjZUlmM29VVEc5T3RoMGJCL2N3cW1ESCsyaGpjbkF0blh3?=
 =?utf-8?B?ZktDOWlhQ0tHY0xsRXcxbUhBRkhDTmZGRWN2WG5VV3VGaWRFQkVrdWw0UDRD?=
 =?utf-8?B?WDVXdjdua2lJYTFwQy9Yd3RaaTNmblFPSWUvcmNsVlo1RHFmNURsZlFVWmpn?=
 =?utf-8?B?WEFHQ2Q3SjljTXpYdjBXTzRxS0dkOUlQbURzVEp1VVI0VngyWlpRdDdJSEVk?=
 =?utf-8?B?M2YvdnQxWVZLMmM2NU9lTWxHR2NFR1p6aExrZXB2bVM5dXIrcXRBWGhWamZ4?=
 =?utf-8?B?L1lPZlh2UnNGWWcrVm5YUjUxb09RVzNYaTZXL0J6UldCeTR4bXJDTnFtVEkr?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0wKHyAi5Tvzh4Y10gf0Zl+LPZK6w7SCevzJzj2Q2r4k2PKZh1QZi1mvasiljq79fy5vaqSAgXKPZBl9aAwChCDTAP6Q8ZoGEk9ZJXvBf6rZ9z5soum7W+KgZLFFK0AC9khDJd9t2Z2oMuQtjH6+YxSI2+ioRjpmpKCBuU9CKzuXcy5Cal/MWc6rgIlDEJHF8lie4xKVyd/ZnwNqTsUwABAN8NApOAYu0ROnRFecOVRggRJ9Wluawlt4RVO7Z8utIx3cH97tOAYWsLRjD9bFZKl93hnmsTVB3t0CDrC57skNdgI7Czyw6U9ZRP7HLNrvYCtDKO2qmyUupaWh8YeRLVVfp76vi1T6uIL9Gs9vu/WMYm+BqcZJvlq+3XXf2S7x5v0CW10pFSFG64WMS2lUMZ9PxsaWHUtQgkG1/qQ3HqZITc49AWaczAgYUv6MAE6LTlfgP2jkhWHeT6JZaaQ6oOPG5K19ImEcN2IXk3G4uYF17Ui2v408tWMa4wobl2FXOcuP5Jg8xrBRR9on+c968zZdhZP8HTgt7FHCiXNVgKHyenOu2TGorZ1kz20KBQMrMh3SDAtH74buoxj79Rkih1MNLR4zau0HqmZesBHyfxng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3779e7d-2f49-4390-0dcb-08dca578d30e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 09:22:33.7549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cI+8V3XaIMARTqthREV6d21asPn8G/fHku63Yotrg7gTcka6uer3n42LGpYK8NFDz4wYBxgEQF1p7cs7a6GatbSbBHWIKyOg+0z9YNVO7hI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=918 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407160067
X-Proofpoint-GUID: zCHw5MedRRLRYRh-oX532Lnb546uxeE3
X-Proofpoint-ORIG-GUID: zCHw5MedRRLRYRh-oX532Lnb546uxeE3
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16/07/2024 09:20, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v4 00/12] hw/iommufd: IOMMUFD Dirty Tracking
>>
>> This small series adds support for IOMMU dirty tracking support via the
>> IOMMUFD backend. The hardware capability is available on most recent x86
>> hardware. The series is divided organized as follows:
>>
>> * Patch 1-2: Fixes a regression into mdev support with IOMMUFD. This
>>             one is independent of the series but happened to cross it
>>             while testing mdev with this series
> 
> I guess VFIO ap/ccw may need fixes too.
> Will you help on that or I can take it if you want to focus on dirty tracking.
> The fix may be trivial, just assign VFIODevice->mdev = true.
> 

If you have something in mind already by all means go ahead.

But from the code are we sure these are mdev bus devices? Certainly are grepping
with 'mdev' but unclear if that's abbreviation for 'My Device' or actually bus
mdev/mediated-device?



