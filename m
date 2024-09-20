Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE85CF9C62
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 20:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srkDK-0008WA-4J; Fri, 20 Sep 2024 16:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1srkDF-0008VY-TN
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 16:26:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1srkDE-00047v-5f
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 16:26:45 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KItboQ031982;
 Fri, 20 Sep 2024 20:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=fi3YrfWvI/T7GIjpHAK5gRf5/fSGCZAMiCTPy6CAy14=; b=
 f2Hg4oMT3JjgHgmpHMzQcy8Az313SfaZCwxzEvHqa8UMR8s8lqcaRHYb9UmWTb9/
 xR0isRGWvBQIKN9TvLkq4PCgbGCyhEYHeIMFB+0KhG8FUo/1uBr7T+RovtyZqdGx
 Q4CV8TKHGFtvvZCItjuL9Shu3ZYzZeaLuo1hSfeqIqyEdF3rMPZdnAJJp3TzuyQ3
 TnXEMvE/TlqOTH5iO2a5qra66pTwzl+8DKkZYMTPa2eM3Pf0Iy2GdavfFagnHEHX
 eCcLkxMgTAFjVeu2gWM0meVkZtXPyZDhL7AyQPU64FXPy2vQLl8/9HQqeGRYBxWW
 aWXj5HPkqU8yc+aNRrumuQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3n3qqme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Sep 2024 20:26:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48KIJYaC015059; Fri, 20 Sep 2024 20:26:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41nyg7vye6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Sep 2024 20:26:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwTVtjsEZUyyFxZ8Ak07U7qIAqYmnhDegxhDwW2WkrSwNG6JK4X0KcEzcFZLgZbFoWrjbAwo9j0c0hm/jUI2hlC7DovEitRLih4bj2zWZ7JkF0SFEfpohu5WCPAtzgzVZjBg3kS09iQz4Exyb+vdH1k+XeMFxMQPW7A2Potqi/SxXZzBYqBELkb4VYlUVOgQkjCJWdETyGQBKGHbLGTlYwb/W+HZJhwnZfJuDULIVg5oNd5XPw/p6xWQdaHidOqYJxml/beiBYK2cdr5Ov67b/zlrKthYJEstVD7KgWksbZUDwxQu4S4nMS4WAgcNVjz9jsEyvV8Sv72gwmp9bTFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fi3YrfWvI/T7GIjpHAK5gRf5/fSGCZAMiCTPy6CAy14=;
 b=CGFAdugWk57K5S4QR6pN5HxFiguuIqM4CCrmpEeTx0qC87yh6XWluZHqln1HMiDyRL29dMIdLCAI5ceI4amMy4rSeW5gkuTxnLZQSYnLIZJFKh9bioUin/+gsEy6AomkGNUYDNUT1acIY+23bNZ2J8gG3huhPW7nDu3OsNgjiJxYy9NISektber1t0KkR238Uyi68zQ8F33ExoTP3WWAJ6E8PO236AfR6YxWWUIOpqTpTBQnOTtKI/NLMzLno3jDI0HWWI9UrlvvFT8Cl0cturcd2Eo34hPnTllSqC+bZpv1y4j0LB9XhM6zIjjb4Ln1nZ4mMoIBAKxFyThd8LLA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fi3YrfWvI/T7GIjpHAK5gRf5/fSGCZAMiCTPy6CAy14=;
 b=lMtugGYOUF2wh/N5cyOCfetodMMYM8SrzDbxxVdKOOLhlBl5rfDWLw38pp3m6PQ7aUsduxz1BxNESv7AW4i8luYyUclvDI/965lmVcxdCic2QOFqD31tSgyJs0HhbQ/StJalNEUwE+Uebegn2JZ8tzPuFSGYaE5An8EEb/ATb1Y=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.16; Fri, 20 Sep 2024 20:26:35 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%4]) with mapi id 15.20.8005.008; Fri, 20 Sep 2024
 20:26:35 +0000
Message-ID: <511e4312-2dc5-45b0-ae54-1712b2e599d2@oracle.com>
Date: Fri, 20 Sep 2024 16:26:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] amd_iommu: Send notification when invaldate
 interrupt entry cache
To: Santosh Shukla <santosh.shukla@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, joao.m.martins@oracle.com,
 Suravee.Suthikulpanit@amd.com, vasant.hegde@amd.com,
 mtosatti@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20240916143116.169693-1-santosh.shukla@amd.com>
 <20240916143116.169693-5-santosh.shukla@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20240916143116.169693-5-santosh.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:208:23b::26) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: eabc2525-ab23-4d88-b525-08dcd9b28617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejM5VzhvYytveVlTdFN2a0NjUFY1UTNUeXFqT2wxV1B6cE02R2RsQldtMU4x?=
 =?utf-8?B?MXNidk9WSHoyaFI3emdoVklxbW16T0J3ZXlyRHJrUlRkMGN5czRzaG5wWFBM?=
 =?utf-8?B?dk53RXQrRFhwRUlUY2kvazVtTzZyRGRyQ2JmK3dGS0taRjA2NzRBS2dOQjhX?=
 =?utf-8?B?S0pScEN6Ry9zdFR1VjRWVzFtc2M4cjRDamlTSUJndzJxMGVkYlR0QVN3aW1o?=
 =?utf-8?B?ZGsrNmpjOG80MFVNT2xOd052YlhPZGh5WDF5VURTTGQvc1pxL21qcGU0SG5l?=
 =?utf-8?B?VHozRmhHOTFSdjJNcUUwdzNnRVc1M3kyc1dDZlQrbk0yYWFyQklVTmtSekxi?=
 =?utf-8?B?RjZURCtQb3NZQkpOMHRiajluSmQ3TXd6OHIxN0d0bUxUdUs2elpxSVoyWkN2?=
 =?utf-8?B?UWhHTlhBOVFSNUFjdEswbEJRUkNxY1V1aVJjU0MvMG9jUWlhZjArZXQzSGVU?=
 =?utf-8?B?dTFBSDZGV2RoNGlJUlpLdU41NHEvR1l2elZidUhmWW5uZTVpOTRJSm9CSE12?=
 =?utf-8?B?WXF4aGt2K1lERnhIQU5GVnZ0QngzcW5nUkdGbjFja0M5RVh0ZzV0WlVzZURl?=
 =?utf-8?B?QWFKK3ZlMlVVeExuTTdJa2taNDUzR2NTQ1dYcFZ0bEo0dzFkeWRvSjdXY1FP?=
 =?utf-8?B?Z1pXOWh3bUtTSGNmZHBwYjg5SEJybW9QMUJJMlpydFRqelN4aGJGZFRpWDl4?=
 =?utf-8?B?MXlDeG44NXpncjJHejZWSGpucTlzeCtZTWFZc0lFSUJGVUVUMDAwaGJ6TnpR?=
 =?utf-8?B?UC9BRkpwYWozSzNUUVBmQUsyLzdwSzVEaUJBN1JGQTdEVzVuSXk4L2lBZWVl?=
 =?utf-8?B?L201RVR2L2xEMk10OVBoeTRpb1ROWGZEcWJRRFBnV0VNU3ZzNjd1bG1Bd09P?=
 =?utf-8?B?dUUvVU9zRGVvRTZxYjBOU0thMTJUclVkUy90NnNSU0FWR3pNN05tQlU3dUR1?=
 =?utf-8?B?WjZhcldjVGtMa2JnLzYzYVFURmkySGRyOERCeHF0Nm91NnREZG1FczN0QUpV?=
 =?utf-8?B?b2RJZWJQTXFIcHJSWDlqTkpWRjI0Q2xpcXJ5cWZCTVBSTWpGUnVzVjVycmpt?=
 =?utf-8?B?bVhWT2RQRUtFN0pKRy9XaWt6R20zd0xyWDVMMVJqZ0VhRExOaDVFL296dkNw?=
 =?utf-8?B?MU1UYnJtVDNjSW1nOU5KT29hZzJGN0haSk5nbnVuQjRHWGdYWGF3NktTTmZ4?=
 =?utf-8?B?L1d2a2tvRHU2SWVsNG1kSTkwemVrMjFVSmxESEJKanhXVS82UWJkMUFVcFlo?=
 =?utf-8?B?cEVjWkJJWEFLSERHNjkxN3B1VktiZ3V4eVI1eUlEd1FnMVpxSEJvRTdhUnRJ?=
 =?utf-8?B?R2tCWFZEQ1VTVzd2bkNTbW51Qi9uUmxteDBaSXF3Wm9najBjSzJYMDlXbjRU?=
 =?utf-8?B?SDdZdWdVZEVDOFIzbStGQWt1bGxJamUrYkVwU28wWEdYNENzZ1hTZ1JQY2Za?=
 =?utf-8?B?ejdSTEZldWMzWUpCbGFlYnFlYUl3MGxnWHBKb2ZIMk5Ea3RYWDdRYitPVGNm?=
 =?utf-8?B?N2h5MUZwZVJUNGZZZnNjOW1SUjlhZWlNcVNGNExlSVlhazlYZHpGRWgxOU9N?=
 =?utf-8?B?RW1zQUY3ek9xdmw1ZFl1b0wwQmZ6ZDlUb1dJb1pWZVUwK2J6K0N5WlR5N296?=
 =?utf-8?B?RlZRT3RRaFI1U3d2QkFrMGNMck81RmtJWVl6SDNoKytwaU4xK28wYkQ0NUE4?=
 =?utf-8?B?WXV2SDhlVHIybWRFa3FpVUZYSlZoMjI4SkJNbnJUT0M5YjJjTkx4TkJNSnMr?=
 =?utf-8?B?UUdZUGNtdEljdEV4QTBqMit1Mlg2aWIyQkhDaFJVdGVka254SjUvQWpYdDBP?=
 =?utf-8?B?aS84UTJIdzZkS2FNbTZHQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkQ0RlpzOExBcWhBNmlmdlNQK1h5d3Y0VUwrTXFVajlTRXBLZTdUR2dMNzBJ?=
 =?utf-8?B?YjBzUnk1RU9zKzhLK0JVUUhQcTZpZ3Z4REdLeE50RHNzMkRaOTRkU0xhTnFT?=
 =?utf-8?B?OSt3TjZsblBDTjNvOUJ3OWlHanBRTitSMXFacHFnYU1oZExkRUdUSzVobEtH?=
 =?utf-8?B?YUhqTUlZcWZ3YnBUVEwzRXBjc2JCRlM1STh0MnE0RjFDUG9OUmNsbmp0b1Bo?=
 =?utf-8?B?cEFwcGVmZS9SaDRLaGNaY3NhVTJWbENQN2dpSVloVXV3UWlhRzVJTWI5QlZH?=
 =?utf-8?B?dFhVdGZ6OXJoYmRTdW5FOXZLVjBLd0QrY1RiMmJzRVZGQmRtSFJVV1pKTDNn?=
 =?utf-8?B?REhXRmNBMzZ1eCtmazl6VzJPYzJ4djEwdjNxenZuUHl5azIrVy8wcENJdjd6?=
 =?utf-8?B?YjcwblByZU42TUE4alJ2ZTFFc2YreG5lcXBoMWMzQ2RZQmtwUU5oMm5SZWFj?=
 =?utf-8?B?MFkzVTB0ZHRXWng0ZVNCNnhKNERlUkd3VjdtM0xTQ2hUQ3RFVXFpUkRTN29t?=
 =?utf-8?B?UnZ5R3dSTGM1Q2NjTmtCZTVBVk02QUdkMjBUR1VtVEtPZERCcU1hK2FRRVpy?=
 =?utf-8?B?SkMzZDdxdllmOXBWa1NaeENxeEVNRVoyR3RRREkxZ1RXMUNvWEp4akYwSEpj?=
 =?utf-8?B?ZnFmcHJ0VnJVY2xpYTRoU3FFdFU1ZXVBeDQyd01jYWdiZnlsN2NsNGhDN1lS?=
 =?utf-8?B?RVlqcVYvZzJ0L1EyeVdjREpaVElNSG55SGlVTkorUGR5TFo0T21YSTZsODlU?=
 =?utf-8?B?UFhFRjMwUUdvcmI4T3d2OCt1MUhBVm44THNOT1p2OVlHRElQSFhZbHV1TE0z?=
 =?utf-8?B?RzZHWWcvVWxXclV0dXZGOUdRanlDelJkb3M4bVVHdUQ2SlEyakdVcW05dDBB?=
 =?utf-8?B?OUVXT2E3Zkgxa0hhclp4UFRyM2ZZUGh4cVkydjFpM210VnZiMHA2azYwTW50?=
 =?utf-8?B?ZUxxSVY3WmxlQVRYbzNGRGFiVkFUb08zdjdxMzdOaHJZMUpFaW5yS0hMS1A0?=
 =?utf-8?B?TkRpLzgvL3FQYVJzbHRQNFZHa2FnKzBud0hUcVZqalBIR0c0bkNOclhVMmRw?=
 =?utf-8?B?TEQzeHpwQ0dqQmthNXdJQ2tWKzJuRlQwbnNZcDZONFZHZU9UdGhidXlCNVg0?=
 =?utf-8?B?TGhOUHlIUk1qSlg4aU5lMGpWNWh6V1BKNy9tMk02UHdrMllQTW0zV1Bsd0xq?=
 =?utf-8?B?UTZwZ2ZaOWNKcXhEYW5XT280aDlWd1NkTFFFRG5uTDZTbU9oUEtSUS84NjY2?=
 =?utf-8?B?U3ZZb3FOaUU2MGkrRUxSWTkzck12RmVWUTNxWGZjYnFuMXlzVkJGUmdCMkRQ?=
 =?utf-8?B?QTRSSXQ5c09pMitVeWNoNnFCYWo3RklTR0h0MVJyRGxjZmFIclJacUJiTldv?=
 =?utf-8?B?cVE1bEl6R2plMVRlalYrSHlHc1hia2JBcW1tSzg4MWt4ckFySWJpckdZSDRK?=
 =?utf-8?B?enl2MnBCbUY2d01kYWZuVVIzRm9kSExlbzlZWVZhU2gyVStSaEU5YjlNNjk1?=
 =?utf-8?B?aG1iSGJkWHVJbFFjOFo2VXBqYUxjYUxoSWhSRnphNU52RFhsWm5Mc3R0c05P?=
 =?utf-8?B?VFZ0eWFMU1lvTWd4OTRZMnhjekdXTzRMY2k1SjV4SUptaFFobVRBYVF0QkNV?=
 =?utf-8?B?S1YrbnpLUU9KVjJmVDRDRHg4Q0hpUVZkb2Vad3MzQlIxNUVzcWFvQ0ViYXpk?=
 =?utf-8?B?RjZKTmZEdjYyV0FCWFo3a0hRN2RNcjRYcFFDK1VCeHgvaGJjK28yZFZaL1o1?=
 =?utf-8?B?S1lHT0hNRitiSXNFdFBBUitqYVdmZU1ZaEJ3eGl2VEJaLzZFTjNKejJiNjRK?=
 =?utf-8?B?WlJXbnR4QWlydFoyb2RFMUU3Y3U2YVhObGpqZktmdXM1K3Rwb3RjZE9CRU16?=
 =?utf-8?B?QUI1clQ0K25hYTNleDJRb09nZGQxejFlend2dFZWS2xiOTROVTEvbjhTdHhk?=
 =?utf-8?B?dWxhb1dDeE9YZWwvT0NnNTc2c29yQWRBRUNpMVJRcThiZmd6SFRiTTNkOTJQ?=
 =?utf-8?B?RGNKSzYrS2QyWG85SWFJRis3TDdtaWxhT1dpOHhKbUxWWXY2OVhhYmFGTEZJ?=
 =?utf-8?B?Vi9TWElZa29iN0E3cVMzRDZtcEU1TW5VMzlrQUwzVmFxbWFoaHFHcnE3ZU1W?=
 =?utf-8?B?TXFvMUNpSTVzb0ZxQkd2bjlTRlFtMjFtNkdoNmtycnNhR3lNYWNYejcyNURy?=
 =?utf-8?Q?0icHRKDSaLpBnN1K+gnx0YQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Iil68AJstUyNJD+SXXwwXTO11wN6qbTBQIGtlfqdt4BeidftC7UMTuFOGAJcwhAe1rFs8394H0iW+7DjQfqpgX08vmH8Uo7UtzwXyzuT9p5VN+KSWGn8VEwUKN8KtgZ3Z47trwTGipU4lYXK27v1W5pW+RUAAk1qbuO4CC+xwDqswykkTX8+IcQBFhPrR6n/b6syzOpL0dSQAxCfU0quDSuT+yixp4DtBkEWuuwj95Sd2DJjvJ8xYML+n4DNJTUQIQvTbD5f9It81+qkUeOUqdC160CU8e+CS80hGP/KbO9SuTI4IH87TQiXpO/WUkBt7F7TcqFRAWqm8e6WWDp2/QeYTao36fnEmCbDALnJt3G10ngGfpeG+trWr00S2IGKPY7c5yYcKnGUfgvRkBnbzCmygIwElDjOyvrmqg1nbBV2cHsNA85RYgmxuCLNfyWYi58+nUAtUTACviMBh4XjCHFPaOvBX4evkYaoOfim0iuRgFoqiO8+bf7pBgZdQjQivBEZY8aB5UdA5ZbL25xtqKlMncjnoG2QjLY36rgZgr2zCiqM8nkvuVcCFGO3rNDCN1TXXG4vH4rlOW6YcJ+84tmlYgsMqMoYauVLB7KXWMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabc2525-ab23-4d88-b525-08dcd9b28617
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 20:26:35.7968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qoD81z2BYX1C8TzzDihQ2TCkfjDRY0uiX1r5TxU6LKTTPbP3SnYb5xmudYgomIDDmZ8EZKR9CwAq3inh+6PQZCApMWmc2OU1NAPj2nMQVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_10,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409200147
X-Proofpoint-GUID: R5ry807ULqs_rnNJwL780kFXwl3k8s36
X-Proofpoint-ORIG-GUID: R5ry807ULqs_rnNJwL780kFXwl3k8s36
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In subject:
s/invaldate/invalidate/

On 9/16/24 10:31, Santosh Shukla wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> In order to support AMD IOMMU interrupt remapping emulation with PCI
> pass-through devices, QEMU needs to notify VFIO when guest IOMMU driver
> updates and invalidate the guest interrupt remapping table (IRT), and
> communicate information so that the host IOMMU driver can update
> the shadowed interrupt remapping table in the host IOMMU.
> 
> Therefore, send notification when guet

s/guet/guest

Alejandro

  IOMMU emulates the IRT invalidation
> commands.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> ---
>   hw/i386/amd_iommu.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 24fcd561345c..9095146525e6 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -431,6 +431,12 @@ static void amdvi_complete_ppr(AMDVIState *s, uint64_t *cmd)
>       trace_amdvi_ppr_exec();
>   }
>   
> +static void amdvi_intremap_inval_notify_all(AMDVIState *s, bool global,
> +                               uint32_t index, uint32_t mask)
> +{
> +    x86_iommu_iec_notify_all(X86_IOMMU_DEVICE(s), global, index, mask);
> +}
> +
>   static void amdvi_inval_all(AMDVIState *s, uint64_t *cmd)
>   {
>       if (extract64(cmd[0], 0, 60) || cmd[1]) {
> @@ -438,6 +444,9 @@ static void amdvi_inval_all(AMDVIState *s, uint64_t *cmd)
>                                      s->cmdbuf + s->cmdbuf_head);
>       }
>   
> +    /* Notify global invalidation */
> +    amdvi_intremap_inval_notify_all(s, true, 0, 0);
> +
>       amdvi_iotlb_reset(s);
>       trace_amdvi_all_inval();
>   }
> @@ -486,6 +495,9 @@ static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
>           return;
>       }
>   
> +    /* Notify global invalidation */
> +    amdvi_intremap_inval_notify_all(s, true, 0, 0);
> +
>       trace_amdvi_intr_inval();
>   }
>   

