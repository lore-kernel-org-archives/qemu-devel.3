Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CBBC3ABDA
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 00:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFMI1-0003ME-Eh; Wed, 14 May 2025 20:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1uFMHz-0003Lo-5O
 for qemu-devel@nongnu.org; Wed, 14 May 2025 20:17:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1uFMHt-0006iP-AB
 for qemu-devel@nongnu.org; Wed, 14 May 2025 20:17:30 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJVSBL010813;
 Thu, 15 May 2025 00:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=nVkD7pHRFaSB8093sI1kytVRBLXwP3NWnoT/KCSEHjw=; b=
 ItRjKRAsn7EA23NsSxMn3QRxd3hU6QGc13I6ZJF9MKj4jE6C7JAbr1JWe4+JEEOh
 BzIuByrPvoIMlh4Ls/6JBHxDAOgcUWPWvfNd3Hd57QXSyoOPLx0sJtzqaqhqXjfN
 LzAPQ9kdOfDdoDLud6O8SH1prkpOVy34m3IwnjbCFC4dlJVJqaJID+fxY/+kzmfb
 rQeOM3nKazuOmYSpErGcnIWcM3p0hgc7cr+OpggdE+rSVuJCp2Swo3EbUDd3Yjwn
 6FQ6DtmIEjGHN6ujlVk3u3AYT9E+MDTNXTkzqBRqmLoxOREv+PEbbAknoMKmzcfk
 PG9a9aihDObjO44tFF11kA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcdu0bd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 00:17:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54ENQLHT033385; Thu, 15 May 2025 00:17:19 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46mbs9xf8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 00:17:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBVWZsIsc+yRSiHlITzkXEni7Old6s+jGBs01hFYJpcbriZF01ky8uQHRKdvFdoWxGk1Q0oxsHoOzz4iqqUpbgMbrDhBVgapNu6tRPXMcA8eUjYpXz8faUQlg+1t2PDOHLo0E3BbPuH1EkNkLV9uKlQvM+lIJUlIccMW1rxOz7bImfHE0qwX8XvXQCYQXqH61FKOUDtGVQz6rjP0VQ5J7ICtUPkhyNJ2pc3YAKthKpJs5iZcU6ifIimdyKENp5DHrWmaoBjSJIm73mrMWpL8b1OexMiOv+SWSi0OvzUORa1MzAmCbwjsQIxBmxCvsrUaWJVRQu+xwImg/OZUa8zACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVkD7pHRFaSB8093sI1kytVRBLXwP3NWnoT/KCSEHjw=;
 b=HNPIYqQk7D+nSRpdm51Rxe137u38XkT62AtX4YZhj1IjNArwg0hrLJ0SyMm/hD/5p6v5zVhI+j7VtgRNtpNnSv1k76Zvaj89RYZ92z0vx1KPjprEPi6Q/33kaMO6+rKyXJ7TTXCDC044utdQU2AC9S54bRMCX74W4Zo8Ht3aqarNokfbL0kjmqe1yCG8RJGJBAI4madWyGo3VjOCP1BBhtutR4LY3rELubamNaT2w3FxvExgRY0+M5jReYJWhe+TA+9OwNzawZKdiYAg/mI7bO2gxBi496+fmNOcPz4FO9qcpz6JsTvcVksU6bU9sgCQi/m/NIdmneXRZaG4737S/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVkD7pHRFaSB8093sI1kytVRBLXwP3NWnoT/KCSEHjw=;
 b=cx1H9SwdTNUM+X5GoxtTOF8ENj3xUX4e+T/A5UdYcBDMfbpPynV3FbMgnDcNLQtzjV3li4ry8vE9rIhFSMC4nyaB5zdE0J4JAShoHc+JwUP3wDWZeXlu4p+41Gb0Pzx7KLk7BC/3kIUkjOE81xSedRap6aHemeo7p1ZBTENUXF8=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by CY5PR10MB6118.namprd10.prod.outlook.com
 (2603:10b6:930:36::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Thu, 15 May
 2025 00:17:18 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::f77e:d409:2c52:ecd]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::f77e:d409:2c52:ecd%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 00:17:18 +0000
Message-ID: <8c465eb3-2db9-47ab-b949-e19a176a5fde@oracle.com>
Date: Wed, 14 May 2025 17:17:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com,
 jasowang@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyang@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CAJaqyWcOaGKaCeT1sifCE_sau1Ac2g=F62TkD=arntQ8ka4aDQ@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWcOaGKaCeT1sifCE_sau1Ac2g=F62TkD=arntQ8ka4aDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:332::27) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|CY5PR10MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 1685602b-4b58-45fb-1a82-08dd9345da1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vnpvc3Z3MFRUWU41V0Q1bGR4cDQxaFFJTlpVMTlFUUVUYlUrYkIvQUdyRDNn?=
 =?utf-8?B?R2tZeEFiK3pYRnYxRTdHVmZUa0FOYWNUbnFZRU4vNWJIT0ZYM0doTCtRL3RK?=
 =?utf-8?B?UnY4ZlhiMmoxWnVOSloxemZ2UGNDcnFJVCtzZ3JnNGFUU0psNzhkbCs3ODJG?=
 =?utf-8?B?alppSXNuaW4zb01RQUlSZWtDdElxajA5Z2xJU3BJZ1VVbHpSODc5V1phdkdo?=
 =?utf-8?B?eFlNSVpoZE5nbHVhRVF0L2N6RHF6VHdrcU9jOVRCMitUUUlnK3ZBQWtwZndZ?=
 =?utf-8?B?dkhCRjhFMTZtalhVM0g4UlhtQ01wRE9seG9FZW9yS01xcUdrN1ZuNEx6SEw5?=
 =?utf-8?B?WVpMKzhzOUV6T2FObXE0eDJyZjR6VWFmSWdPZGtzY1J5a2lmUGJZTE51WG05?=
 =?utf-8?B?Q0w4TWZYalZuTHdFY2lLUnNoeTloemhzZDkwZHlwZHBiM2EvR1M2N3A0bCsy?=
 =?utf-8?B?K091ZDlGTVFHa3NLRFk4Snh1eGRxbThxZ3FzRnlCaE5RYVAwNXJjQWkvTzJm?=
 =?utf-8?B?T0dxaGowMmxDY3RGVlRESDNzNHJhV05xdzdKUFNnc1dxTCtqWWlWZnZLSitw?=
 =?utf-8?B?SkE1MWR5cmZERGJ3ZHhZc2dEN2VTZVZkWmlHaXNxNTMwWFRjbU1BZjFjOW4w?=
 =?utf-8?B?NU1ncFFrT2U1eTRWSkVkWFFSMzZ6TGNnMWh0UFJOUnJVbHQ5dStFUVg4Q0hj?=
 =?utf-8?B?d1VFVzQwSmJVa3U4d0ZsbUJRZVNrN0Uva3FvSUlYRzRFZzJHWlNsNkZSdVNH?=
 =?utf-8?B?aEZKVG5LODFWR2dGQ0RuVTZCOW5pN21BeWlnbDR4cWVXMlU3cExEL0d1QXhs?=
 =?utf-8?B?T1VKNk90ZEQrSFhTRXdFcEpsN3dBN0JTcnZSZ0Y4Q1k1d01zSHdJKzJKVEJq?=
 =?utf-8?B?cmZ1T0xlcXQ1UVhGY0pJRDExK1VYTmhyS0Q3cUlXMFEwYm0rRzNtTFMxUzI3?=
 =?utf-8?B?LzZ4M0s5NzUyV2wxa2ZCNG1Wc2EzV292cUFUc3NPczBKVkRxaVBtbEE0RUE4?=
 =?utf-8?B?OFVVMEU2eVZUYW1LOWt3eENFUWlsUXI4YUhrenFkOHpCR2ZoQ2pMeG5nRXUr?=
 =?utf-8?B?NFBLYzVudEVKeVpacm8rNkRHclpwWkpKSks1VmpiS3luS1ZJdEhDcS9aTkJx?=
 =?utf-8?B?NExPZzRXMEg2RkhrbUVzdkVaTklxNCt5NkFaYXh3VHhBNlI1TEJlT09rZTJp?=
 =?utf-8?B?dTBSMEozdDd2TzZSbHZWaVhZejk3S2tKckVJdU5yVzN4YlVkYnlMdkFvZGxV?=
 =?utf-8?B?Mms5QSsySytZcGw5cy9aMTBuQ1NHYWNpZ2p3aTljcnhHb0ZVSXZBeTM1RjVN?=
 =?utf-8?B?Q3RuaGMrT3k0RmEyN1NzVmE2ck5hT2tSNW43RHhVcG9NMW53UkttTnVVSC8v?=
 =?utf-8?B?Q2NZRTI0R3V0VGx6RkU3c1Z4a0x2cDFUbUM3TU1rb3BrU3E0WHNuVVJ4ekZr?=
 =?utf-8?B?N1F0Mlp4SHZiUEFZR1RZTHUrT0REVmlvc0ZTZk14cXFEbU8zNkdjcGRNWjA2?=
 =?utf-8?B?eXZlbks4ZVRCZWVaUXN2Ym5XRjdOTUc1NTcrTmpyUEErRmU3TFhmdjdvQmlQ?=
 =?utf-8?B?WC8zb2ZKc3JZbFF1UmE1QTcwejhsOUJnWll2ZS9UMnpNOWFRcG8zU00rRjVn?=
 =?utf-8?B?WWpZUUZRSDhqWnhKOTg4UEZkWDdkUUFjWnkrZXkzTkhxQy80dkMySGkyci9O?=
 =?utf-8?B?aHhMTGxwck5Gei95NHRaaGlSanVxRThxWFJ0UkNvelV1Y3JKSUczbXUzNDdY?=
 =?utf-8?B?a2c4ZjZyWFd5dW1vT0dIczRSWXowZWdyRjdKcVlvYnVMa09MYmRHd3R0NW1G?=
 =?utf-8?B?YXpqcW90b0xYMm5rVFMxdUVoUWoydWRPaXRjN1l6N0xSRGZ6V0Vtclh3ejI3?=
 =?utf-8?Q?+oJh0rchTvijf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF18D5A7206.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC9PVm9Pa2FOTkxKRVgxUmpnWElSZ2NwdGE2dnI1OGhWVjF0cnQwMWVIWkFU?=
 =?utf-8?B?NXd5aElRKzU0ckNyKzFOVVRRR09GcTgyOXVHZTNGUWhzWUVEcUg4UEhWZjlZ?=
 =?utf-8?B?T1dPcnJ5QUk3bWh6S0E0dWxzOC9XSVJqczl4TUFuY1dvN1R1L0Z0RzE2R0JL?=
 =?utf-8?B?T1pPbHpHVmpDYVZLR2dXcGxlQ1VnSFpqZWRmTmthTy9OUzJ0V1dMemVpbkU3?=
 =?utf-8?B?YkF4aHo5QkNnUkM5eUsvTnJxUUJocmo5b2F2NEd2NllEZ3ZZUC8wYlpkUmxC?=
 =?utf-8?B?NW8yL1JOYmtBYytjYWtPaTNkSVc4cTRtcVlqMmYwdHBodHpMbHc3QlVtNkV3?=
 =?utf-8?B?T3dPM0doRDFpNllFRUpEWFBRdVkxSUV5Z2s5RFEzVUhIQ3VrRWZIRk1qMWZ3?=
 =?utf-8?B?Tm1UVzhwN1ZFeTNkazJOVXl4MWJpM2tWMGpGbnAvNGd4RndvZGNtbURVa243?=
 =?utf-8?B?TzB1QW1YazNZdFdacVprUVBVbFQ0WVRwbEd6NlpTWkU5SjlwclNFRGZNWFI4?=
 =?utf-8?B?cFozTloxbGF0blp0SWdqK0FuY1BSRWlwb3Naa3IrdVlrZzRBY1E0RS9FbmQ2?=
 =?utf-8?B?WkNBcXk4TGlwY1BGVWYxak1qSW1SR2VGTUNGWkpxdTBXVk5iQjBSYjZhTW4r?=
 =?utf-8?B?ZlBzT0dJOERrQnlDa2ZzSFpEVXFYOG1UaENsWnVOcmNQbWsyRFBoZi9hd2Nk?=
 =?utf-8?B?RnpZclk2MWFzelZIbkFuNTRWeWJvVURYZXV0Z0ZOUzl6M3pHYUE5c3RrMloy?=
 =?utf-8?B?MXAzZDl6WkNnU1RlZS8wYkRnWXJ0RmhVT2RsazAwSTZJQ2t2d2x4ZWhxVTdz?=
 =?utf-8?B?ZlNuS0JaU2xTWG82Sm9wSUpZZlpGZVFEVW1HNFluNGFUUFVjaVRiZTY0VzNI?=
 =?utf-8?B?Y0E1bkJodUNPNlZ3cGVQbkVzVjErQU1ELzZxajE0SEgzdm5LeHZFQWNwcWZk?=
 =?utf-8?B?ZUxOZzFrbEFMQXB4bXdxZ09WVGJkb2phSlZia2szeEhmbTdpSW9meUlVZGty?=
 =?utf-8?B?ZTJ2c1p4eTI5di9GMlVHT0ZHUk82VTh4UDdzSE52TDFIMW9yb0l6aDNQcy9B?=
 =?utf-8?B?ZTRjYlJSYzR3Z3RJZmxvYk9VN3c1eGFLNFEwblQ5YStOckd1VHFUZmdOZ0tp?=
 =?utf-8?B?c1hpUkpWTHp2RHNQdnNoc254S3ZRL1hoYXpjcUVFdTRBTWNWN20vRXpxalVq?=
 =?utf-8?B?OGxrMXMwSERSazcyekR4VmZlcE0wL2w5OVFBRjVpYzdJMmsyMGowbzZnYkpv?=
 =?utf-8?B?SmREU3ZXQzlFcmtSeVhhaXNkdW0rRWY0QnRVOHJJaUNjZThzU24xNDhRcE03?=
 =?utf-8?B?c3FsaVlzM0ZnMjFOZVF6TzUwaEZlNjFucE9hTkREakJKOHlIQXI4U3FKUkg0?=
 =?utf-8?B?Wm5ENmhXeWtlZFBmRlMvRnIyK0laQ2o2dFNPV083cFV6WEtEVDRZa0FCWnlh?=
 =?utf-8?B?Qmhaa3h0MVZOK3ZWTE4zaGk2Z3BjcjBUMURXbGNVWEVjdDFFVHI3MkhqSERQ?=
 =?utf-8?B?WGJqaFpmK283dUpTU1AzcXhPWWN1RnQ5RnFqaG9TMXpRSFRrV2dsdUpwaDRz?=
 =?utf-8?B?K0RxQU5HcUgyRmxKZ0xuZEIzV2RqaWxNRWk5eGZENzJiWjBjMGhjVGVXN1Vi?=
 =?utf-8?B?b1FwZ09teStJUWl0eHdPYy9KZTBDYWRWSHo5Z29RYTBCb0NxVGwzSWVVMHFt?=
 =?utf-8?B?QWh1R09XTE44Umh0L1pkRTZjN2YvakR2cHZTMXNBNjRpY1lGbWFpOFVpZWZE?=
 =?utf-8?B?VzJ1QTlsNVRwVFkrclNMRXlJaXBHZUhteXFaTTZQbDJmNU1yREhqdWpWdjUv?=
 =?utf-8?B?ZjN4OWFZNGVFRE5HWFpoMUNYZEFSTnJrTmFMdkQyL2pUNWc3dVJMV0hTdFBq?=
 =?utf-8?B?OXJFbHQ0ZDQvMExyeTA1eTNyK1BOWGc2bTRnL3ZvLzlJcFB1TXFBVFNuMWpz?=
 =?utf-8?B?Nkc4ZkduVzlvY2JUSVRBQWdDTEJFOTlMdTFvVGRRdVdmSjhaSm9IbzZTcnpV?=
 =?utf-8?B?ZlJRQ1BNME5qUHFDVGdWK0d3K2pSUTJkbW9XYXBnZjRBQUxKWmR4bW0xckdh?=
 =?utf-8?B?RENOMHRQZWxMaU1JYU5WVzdsTVJCQytYQ1dpUDIwSjZHRE1lWEZyS1dXTUd1?=
 =?utf-8?Q?qrlW0kRKYO5z6XUcff80FE6Cc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1+YP46Zi20ccUo0bfCRR8lCRuQue9Trum1Iw04sii2CYps9iEGWvoVOW0prdZXZbax1Yh07Aj8J8sJ6Aj56mmd8YrzaaG5skb+E359/uUyfYprp7nHMsK9jcFjzK/ZpWgHKc+Ttqxr3fr7k8rUFQdamzjVcHb6QNlxijXbmXdqvZ9vGtd3qUUAJkTa9QXtElnwqFsuHiPskKt3y+v4ViB70LdRyZxF/fgZftJWzXsw/YJGroux0RbMXrfO3OIH2yNc+k43M2NsKerz39Fv0qssw7JQfkrTTugUbuzx1DQc1++D4pVt09sAWZlwLMHDl1iZpAIMyViUl33drHmJ/4/6u4e1M5gjO2CRlM/gY+cOFehxI3wc8GWxCEjS2dq60cc+T30iQE1xlEKcmIhrOa8GRVMVE4F+V89C2x4AvFNA97r7BVe0LrXtOmu8egmOLSagYPpbTBDWQxSEiB/ZVyv2LRfJmhHA465oxswt4pbUkMQbpmhDDbPPilA/xDDL6dfHWatMRet0jjspkWWh9UPgMZa5W0yPzSzkbef1eKU1mTCZU6u+bxgQeAGqseHlh+HwD1OvzNUfXVsMtzJ22KfIn2NqfADZPbvFkB/K32u/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1685602b-4b58-45fb-1a82-08dd9345da1a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 00:17:17.9851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhJDZZRT/4/B19KjkVe6IHeqlw77CEY3OII1wjzTg1l53Zy/yNG8onxAyWqmyHnGmHXbqaECe5mOnpX9nG/9uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_05,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505150000
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDAwMSBTYWx0ZWRfX/zdAmmp6Pf2B
 eGpR7aqdi4wiWGQUaUOv5qqCtc2hDAdqlZhjqhiLcl8rIb/GBG3NYK8YQwyVY0t8TyEYT7fwtUt
 4hOVc1npDov0NgCvyOSPuJrUs19m7yS3vNbwxUlgkj2PiKhW5SUNQ9pm1pkUhPVsxC2IGvp5CFc
 r62ZQyK+Eh/wTsqQrqVmqvupZHv+025k3icW4N5RWKlRmdgDKgmNGtedZcfNgwFA4Gk/mbxBcJH
 Jn51Fy0pcuTmp+vS++uCt+EcXB02nOzIDWBDNIzTUY8ubJ/QIqF+9Gzop14t2xIXzOyu3zsVm/O
 MnLdfB6wnrcGDMg3rk6fD7WV/+VDP5o8cbZsDxSgACpmfj5fPV8OtRfrcS+B4zzrYRL0qPYN4XH
 oEJzAHxZ9BoxpF0hQW9755rQN2PbEG838WHcDt5hR4nTrQG5ZbCuPkBGk1ZzGudrsmItUp5P
X-Authority-Analysis: v=2.4 cv=Y8T4sgeN c=1 sm=1 tr=0 ts=68253290 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=NNZK5FaOqi6ydGrsarQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5WABlXvFAscA:10 a=n0c7R5xxTHgA:10 cc=ntf awl=host:13185
X-Proofpoint-GUID: blhRK6ze9xJ1p6moUl4-tE_R_Ew_qNCe
X-Proofpoint-ORIG-GUID: blhRK6ze9xJ1p6moUl4-tE_R_Ew_qNCe
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Eugenio,

On 5/14/2025 8:49 AM, Eugenio Perez Martin wrote:
> On Wed, May 7, 2025 at 8:47 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>> Current memory operations like pinning may take a lot of time at the
>> destination.  Currently they are done after the source of the migration is
>> stopped, and before the workload is resumed at the destination.  This is a
>> period where neigher traffic can flow, nor the VM workload can continue
>> (downtime).
>>
>> We can do better as we know the memory layout of the guest RAM at the
>> destination from the moment that all devices are initializaed.  So
>> moving that operation allows QEMU to communicate the kernel the maps
>> while the workload is still running in the source, so Linux can start
>> mapping them.
>>
>> As a small drawback, there is a time in the initialization where QEMU
>> cannot respond to QMP etc.  By some testing, this time is about
>> 0.2seconds.  This may be further reduced (or increased) depending on the
>> vdpa driver and the platform hardware, and it is dominated by the cost
>> of memory pinning.
>>
>> This matches the time that we move out of the called downtime window.
>> The downtime is measured as checking the trace timestamp from the moment
>> the source suspend the device to the moment the destination starts the
>> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
>> secs to 2.0949.
>>
> Hi Jonah,
>
> Could you update this benchmark? I don't think it changed a lot but
> just to be as updated as possible.
Jonah is off this week and will be back until next Tuesday, but I recall 
he indeed did some downtime test with VM with 128GB memory before taking 
off, which shows obvious improvement from around 10 seconds to 5.8 
seconds after applying this series. Since this is related to update on 
the cover letter, would it be okay for you and Jason to ack now and then 
proceed to Michael for upcoming merge?

>
> I think I cannot ack the series as I sent the first revision. Jason or
> Si-Wei, could you ack it?
Sure, I just give my R-b, this series look good to me. Hopefully Jason 
can ack on his own.

Thanks!
-Siwei

>
> Thanks!
>
>> Future directions on top of this series may include to move more things ahead
>> of the migration time, like set DRIVER_OK or perform actual iterative migration
>> of virtio-net devices.
>>
>> Comments are welcome.
>>
>> This series is a different approach of series [1]. As the title does not
>> reflect the changes anymore, please refer to the previous one to know the
>> series history.
>>
>> This series is based on [2], it must be applied after it.
>>
>> [Jonah Palmer]
>> This series was rebased after [3] was pulled in, as [3] was a prerequisite
>> fix for this series.
>>
>> v4:
>> ---
>> * Add memory listener unregistration to vhost_vdpa_reset_device.
>> * Remove memory listener unregistration from vhost_vdpa_reset_status.
>>
>> v3:
>> ---
>> * Rebase
>>
>> v2:
>> ---
>> * Move the memory listener registration to vhost_vdpa_set_owner function.
>> * Move the iova_tree allocation to net_vhost_vdpa_init.
>>
>> v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html.
>>
>> [1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/
>> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html
>> [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.palmer@oracle.com/
>>
>> Jonah - note: I'll be on vacation from May 10-19. Will respond to
>>                comments when I return.
>>
>> Eugenio Pérez (7):
>>    vdpa: check for iova tree initialized at net_client_start
>>    vdpa: reorder vhost_vdpa_set_backend_cap
>>    vdpa: set backend capabilities at vhost_vdpa_init
>>    vdpa: add listener_registered
>>    vdpa: reorder listener assignment
>>    vdpa: move iova_tree allocation to net_vhost_vdpa_init
>>    vdpa: move memory listener register to vhost_vdpa_init
>>
>>   hw/virtio/vhost-vdpa.c         | 107 +++++++++++++++++++++------------
>>   include/hw/virtio/vhost-vdpa.h |  22 ++++++-
>>   net/vhost-vdpa.c               |  34 +----------
>>   3 files changed, 93 insertions(+), 70 deletions(-)
>>
>> --
>> 2.43.5
>>


