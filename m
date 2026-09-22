Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9663C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x91AZ-0005RY-ON; Tue, 22 Sep 2026 10:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1x91AK-0005R3-CY
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 10:08:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1x91AF-0002Ys-E9
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 10:08:10 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MDuTeO4143773; Tue, 22 Sep 2026 14:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=e38E2vhyxAGBXM+UJRFLeIeZPl3NEEWLMwlRDt/FADo=; b=
 B4MrxgQfnY1n776T0kpveB33dSdqWWqsSglptOmfUPdt6qyCqMi/gpMBdnjym5Lk
 0PfKs/17MrXz4S8a+zbtuPsMu4zyzcM2N7U5OZ5sHtykEkKXXD09/HckLiULbGMm
 S5r1ymaEysgh+89E2UnVCzTIC/g6JBxy0VnNywnZyfe6/7MemM7nagNnFPpTjv0B
 eeC0zMdA0X/qo2qXyAIXWulh7kpk72v76vw/xrMoPQl2XmribSItm7o8gQbF+1Uj
 WNouxA2AdmOMdJMPvQIAw1DxPpu5SzDtpf3TpuAqyRAc94fRBUaG5iaGVErHU6gk
 x2CJedlwhZ5lIDhnkhyN2g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0xm34k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 14:08:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 68ME5PfM030133; Tue, 22 Sep 2026 14:08:03 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4guf0xxtnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Sep 2026 14:08:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiQPa1V4mZg3f4ja4Roib3rUgjwVZOD0hDVU33H5RV0YI17loK+wI3REo3EjTc39OgmSTPUA9CBbpwzccOYhzp2Khly0lWM+HdRsGjc/mikYI19mXuKEgnPU16sZAQliMYi1ID3goSoa4sH7O1zSlrEKQqFAiCTIYM0+KNd9TNq5X78TfcHIAxsJxyEd6p28TzXT1qsDZTRmMO7nXakzuDTDX7vPoEk1PJjZaRb4t15LQA6zuaDSB/N5+oJ7/wCFqWr7ijdSB42gwNuYSP90yKWmXZOEHPUNtDod0jwD8M9Aec2+V1eQA6EdayWCTFDoH9F9N87F4+QSV57XInmLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e38E2vhyxAGBXM+UJRFLeIeZPl3NEEWLMwlRDt/FADo=;
 b=TmveK3XzTqGHZUrNbR2IPjbQRIRh78lKiJqa4GMC/REtcZVE9wCvOsXtZVtAA/AgyPzwIh7aJatHl5/ybyg6JxyUMj2AW9QixnqTJ2Lu8OYYZqX47BGRwTMtkP8ks7qpPKM1b0UOz+nkyYLVZfgJcOysNNGF62KC2WwPgFfEzs8IWELi16hZwHSaBg/n47N5nUK4mP4IC+Pces1n5NFi8QPVqYo/n1Ln0KbEKYrS0aJQv7STWnKUoIQZ998Y0I6vLoiGBvRkZLe36zXw0p3hShpdOArYlgzpjrP1iByZCKRZlfbwpEvembYKYvyymzb6spL11KiwTNoWyUS7EV46aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e38E2vhyxAGBXM+UJRFLeIeZPl3NEEWLMwlRDt/FADo=;
 b=vpSOvkivaWC6/J2UtbHOSXKi4ErovBESDL711BSUCnDinlz7LHfCTrJ5Bjh3ie4ymGnzSp2fQo45tsVBvDq3EWs1FG4cISE/hJzD28FFuN0z4RT3Cb5654iJ3W93sOw+gYJ/39ySt0eqlspijgOCEDFLLZFTiBldYsco1YUUYPY=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CYXPR10MB7974.namprd10.prod.outlook.com (2603:10b6:930:da::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 14:07:59 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.21.0451.004; Tue, 22 Sep 2026
 14:07:59 +0000
Message-ID: <f88e2d78-68c3-4c56-9d3b-4deba3c49b20@oracle.com>
Date: Tue, 22 Sep 2026 10:07:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] runstate: make runstate actions private
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260904205749.510493-1-vsementsov@yandex-team.ru>
 <20260904205749.510493-7-vsementsov@yandex-team.ru>
 <2f415ee0-373f-4879-b472-336540b7b7af@rsg.ci.i.u-tokyo.ac.jp>
 <791fcee1-2bdd-4bbe-a5bc-d755b2e457e8@yandex-team.ru>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <791fcee1-2bdd-4bbe-a5bc-d755b2e457e8@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::17) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CYXPR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 807b8680-f675-4481-718a-08df18b2e873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YVOJKsKrKSlziALJmXocezLC3jPWMf6f0CYmv+325XXQrocjDI+4S0F4u5T9duobt9dBukvX4NyIOjbXZVNrww43Juc5+mhkS+7YG+W1yxNR6vqWMxPJJ6d9OEp8mPapxG9rWqadH3K6WtGI7LJ9QHEkZpykQ/BVqusd3Qkez5O0pgJiCzh2vqBGY8s1FxInsL7TLmBaa8EHHqJjv1iDxEWp1DBuj5gERi7m9knVZJ7VJNIgBx/LEs0axU2xqU6kTmp5R1KjNaIABAhPG2CsksauO8aNoYIKO7vAfQZqKYNyyXyC52RKY62ZTG1N87ebZrrquIWpkFiJs8c7PQDU+toZCF60LeGyuWi4hewjVfE44Kd/PRK29s7bdrTnHH4ZagZfneh4F2J0VmHevJGaWthT/SvHN95RPVgKEWdb/WgCezu2nlY3kadSEKFESOpO+GKxxOijc4uEwbn2qnL3hCwQ828rkkkQWPYHPlz7LHmGWTtC+a6ACXSyYmkMJIx1RMs70NwQC/hwp5YvE52DTiEHrQRgKGNcd3oJfeiW0FdeQwdYr5sc9QYeJeefXO/izxskMIv50ZMClFliQ92YoU5yhv+zPGO+/Cc/5eeO8vYqaVBqsw0gQ9QB4U4stC6/fKJQM3o3qZ88GHzyNfP8qdR8KVvNXT8NMuXtfYgfxxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVpjckwwNllPR0NjS21vQkhiZzNNMFZ1Skx0ZHVNWlB3alMxOGhpQStMRlFa?=
 =?utf-8?B?ekc0amtnQk5aVXdqck1qeWFqS0drQllxeWc5UmNuVVpNVThtWkp6ek1lNWI3?=
 =?utf-8?B?V1FTTTVvUGRsQkdqVkNDNkJlZ3NxMThtRGEwWDdhY2hJL2hXUEdhMTBMWHFy?=
 =?utf-8?B?S2tHMWxyT2hqai95c2xEc25HdkJEY3YwQmZyK3kxaERaMGREWTVJU2RjYm5r?=
 =?utf-8?B?RnpRbEFBalRwb1pDUDZLK0NQVXRaSGprUVdPeTh0c2lCcElPSUxtTVhQOE83?=
 =?utf-8?B?SnVUamJyOERKd2NuU1ZZNlZuQlhmaHZTMmlRYmtsbmVob3IwWCtpdDhvNUVt?=
 =?utf-8?B?MXBnemNYQi9mWUlFaVVXMVRlazUzNVhYekdZN3hYUjFwNW1Ga2Zxa2dYM0I1?=
 =?utf-8?B?VFlpMXBLTzZoZk9TUkFUbit1K0o3bExZVE96OGsxekJKWnpCRUY5SlhiVml6?=
 =?utf-8?B?ckVRR25iUTJqMzFaelZZN3V1MTFNcm5tMERmWGRiU2s0VTRmM3FJdXJDVHdn?=
 =?utf-8?B?bHBydkh4eThXUkYvVFArajZHSUU0TDJlNXRHYzV4QTNXLzQvN0FKK0hEbjlE?=
 =?utf-8?B?ZnpLdVdBVXBWckI2dkdZcXhmOS9iMFRJaXY0VlJsdmhodEhTZEJibDhrb1Zq?=
 =?utf-8?B?NXdOVldyUGNOMUZiMG4vc1BJd3ExUGpsK3dEYXVBVjlKSUFKayswSmN1WHlu?=
 =?utf-8?B?R2x1YnVOblVzbko0Nml2UityY1ViZmRhenR1TUdWbDFTdjdJR2xzNVZnWGFh?=
 =?utf-8?B?RHo5dWVMRE1scEdtR2k5TzErWDJBQXZVSDd5aVpvekN1ZjJQODJnMm5KZWdo?=
 =?utf-8?B?V2lsOVczQkJQeXVRbGp3RFdQUHMwcW5GVlo4N2dPcEM4VVUyL1cxT3F4M1Jj?=
 =?utf-8?B?eXh3ODN2dC9QSkFPMXVwVkFQeFo5VUdmQTdWNXEwYnJrNVVpeHVETUd5K0t2?=
 =?utf-8?B?MjRQaXE0cTV3QVZneWVGV1JnNzNyMEFCc2RQbEpyNklEWGFzekNIUkVLMEMz?=
 =?utf-8?B?dnQ4L0tPNGwvRG9ZVVhTN2lUcWF1Wk9QOTZjaWV3T2h1ZXgvTkNnc0VIcEZL?=
 =?utf-8?B?VzNrbnNhaDRZNzBDN0kyTFpkRTlaL3RvNHVtTFVnMGJtMWlxNmlneFNxRzhO?=
 =?utf-8?B?V1RoSm40M3ZGUmwyM1h1ODZQb0hmUWdHcHJQMkwwRm9iWWZmWDhRUk9yRWg2?=
 =?utf-8?B?d3ZWZTJMaGpnWUpZZndlbVNNalQzRTBtSmhGaUkxd1AyMTZRUTVVeUNxUGd4?=
 =?utf-8?B?QnJsSGFRNmw1TEw2TmpBZ1FvRm41dmx6dVZ2U1RySDJLQkJ2VWxSc3pnN3pt?=
 =?utf-8?B?NmFyeG5tYm1PcHA3T1VRTVNQZXFEU1U4UDJ0amJ1eFAvVVZDMlF2SGJyeUpO?=
 =?utf-8?B?b0RDcFJrZ3VPSU5lQ3k1YktnRjRSc0xZcllMZG05U3Z1UXRSbDliMHVrYlpJ?=
 =?utf-8?B?clNhVU5RbTZNRE42TlJyUDJyVjdNQ3Z2dGNhMEEvNlV4cVhhTlYwdGdIMGQ5?=
 =?utf-8?B?UTY0Mmg5TnRNY1dQYjN4YmJ5N01GYTY2V01OWHFYV2xmNFlGR0ZlSU1LY3pn?=
 =?utf-8?B?TGRFNW02UzdpR0tPa0NkNitDdUZha0RDaitzUkFDaSsvT0hMOG1sUTI2ZTNV?=
 =?utf-8?B?djRjUGpDbXk5OWFjSUJxWGUwcUVTOVQ3aHMzZjZBbWg3bVVmYmoyQmNyYTNN?=
 =?utf-8?B?bVB0dkFzaVI3Y25SdGw3QXJmalphRTBXSmNKeVBMQ1JiOHBFeitLZDZpRXVI?=
 =?utf-8?B?dEpnSi8xQ2cxaHlwWmZ1RTZIZ3pKMGlaNlh1OGVOd2NZbWo1Uko1UHN5emNq?=
 =?utf-8?B?bEN4Zm4wbnVmN0ZaVVdVSjhYN1BQazdod25laUNqSXhOVzFFQzRndGg4d2ts?=
 =?utf-8?B?NzYvaFlWY2IvRUhtMm1mQ0w4V29YRngxR0Z1ZmR5UlRuODN0MWNHMlVMQnpN?=
 =?utf-8?B?Z0hIalN5c3BPNFhmVUdlRWdWL1VIT1ZBRWJPeXhyMXlSek4rMUZGMnJzc1dw?=
 =?utf-8?B?dnNuRUxnNm9IMjlyeVVDcTVIUXZucnNBb2h4V0dFZGt6Y2lpSTAySkxpNFFa?=
 =?utf-8?B?STRPd21FaW1IUnd4TWZIdXF2OVc5djQ1d29UZFR1eVZodE9zdUJvQWN6MVdQ?=
 =?utf-8?B?WXMyVjZJZThPVjc1aFFHR2V3d3hRRXB3MW5UNWxEM2ZNRDU5RkJSNlhaWVVp?=
 =?utf-8?B?TlExQ09HV214OGhhM1o4T3FPeXRra1NCRUZMaFE5VkZNS0kwNWNhcHRkUFov?=
 =?utf-8?B?anZGZXdiMzFpakwyRmhIOUNIdTh2OG1MUkk2MHQzT1BOc0t1eEZJVTBTQ2or?=
 =?utf-8?B?cFVlUUFBU1ZaNG53dHRYbVpSWEdIVjh2Q25IMllRa0RzK29EMHJ0Rk1rbkVD?=
 =?utf-8?Q?YPfpEOv2Q0TxDklI=3D?=
X-Exchange-RoutingPolicyChecked: 5lkewL8LfhHw+51BxDqzd//fjTWSx4jj0qdDjwBek7cT5/GeeQlZOutWxIsjWsNLFczzG+w2jWTns0rATGFczVizW4ztBmZyEgfKvOtdc8U3I48Xvep6+F1XfHEAmjSdhPRYPRa0yMfCWxoCPqJWOCAWG0MQxSkFeXOHRl3tpkBE9pEOC53LpaT3flGBBpoZjzWWMTMChG3xk1Co9Ez2UJ4i/fOCb7+zAqwRNugSEmKydlDz9fADCn3C8yQ4km9JKEKbDmgYkhx4b1BkJ6JOdUUDZUNS8VSj8JYOzKcpJeIUD9STl748peDiXXdWgrc95h3ouWWuV8D7Mbd9CpT7Zg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3rwmUV7T3DRZnb6CUgad7hNGu0rk0GeG6K8MtcowjB1z8UUJUlBH6+PdbjvuOqRlgqbP/4QBQDjb08dxB2cQGG31nu0yqK0/jcHTKssr0NcKfrVX6FHbF56jTSJGcVp6/g5xjsedq25ohQ75v50/+Bu9w0oFXbs/sHqTe9SNyvxF4cbkQtSSPZcvbN11jDx3m2rbfWS8WIV+qaVUUtrkeqHY+xm2tA6H9eo2ooLc5OFZcyV3v5cZIXpdtBYavdM7pzIgTpQgQ067eY4ebtRwxjJIVrk0lNpblVaZ72DdYqWF6fdATIcLkNeu7JeOYH4QjHJ+h+gmVd1xfQJxu3uuyYj0X4q7cKg9QyXN9rKAKBs3w8Xch4i9masrYTjDiaspWbFoKV6xFGzWXAA62oNyXM/Pqsw6w544whgajqTz527KI7RIyOeanw4dEI6DX9Hpvg3S81i/8krd9x8Po/WylHe/0y7deTH8vTgyMpsCyH4NK/4ZTxerjl5b8yM1HpiY8nuY03a/h+RLuwaX0e/o1OfJhh90lUQNsXv+b6d8ouCldWBi03yihqqGU14WHB9q4MbBcNtbSaoRapYmwb88T7g39/lG41yIC2w7SorKFV4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807b8680-f675-4481-718a-08df18b2e873
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:07:59.5046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQfAv4lJdBE9mJ+laLvas+D4jRcsVbeGMhfbzoVj2SZHF0QKWJ0j4GQpTAc9grE8c5097BWrMNcKntwtLw08pNhukzzcCUbKkO3DAL9CMVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609220205
X-Authority-Analysis: v=2.4 cv=F/bC5ahN c=1 sm=1 tr=0 ts=6ab28bc3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=6R7veym_AAAA:8
 a=NiWmwrVAIL8ilAF6oM0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12106
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIwNSBTYWx0ZWRfX6VGAO6BnBenQ
 tWQFJA7dqfPfrsxhBjWKSl/uzZOGYwG73djGLAfeevRSZeVE95Qx1CheJJlqiySzKWAsZohvaNK
 6MYRLwonZ2mCsyQDoh9aKTKvUucZJ/eZYEJq0CXoAwW6xmbIVUXz
X-Proofpoint-ORIG-GUID: UIC9lm6EJvcWv3ml4q2RUU1QkWoEtfuk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIwNSBTYWx0ZWRfX7gAeY3UEj9WP
 wkljuZRlCVjzcAFsVJhdrPDtzJh/NI91QVDlxEBFK8g43puOJGvimuhKQT8XFancDcUWvJ7U5Hw
 YRoGivbB/sQMc02s8t5Ek0M2OLK5O/EgjUSSrguWr3pvkvSoXRcLNtY122NNz899Xqu7d3t7zjg
 HzXqO00/kyXzRzi1wcn7awJBzwDHkeLzmQdta7iNBGPY34iEaTMHXMQXpkoqQa9Yni1Nz6CKH8I
 h1v45HUjjV43BY/ShYR9aVVmAek3TiOCogBU03Jfaja94VhWkipPNO3/PJ7UyTFz+MBZZFMvETn
 HDxMo05NYlWR3O1tQNn0VAGY47PCQaNuPHuJzbeDs7SOhsObHHZE3b4XPuF5DsvpYCFhucBb4Mr
 Rjz976idsAzBzv8h0T8w/TYS/POBY67aSwSt4yIOO6Z4YV/Hby02GF5uWf8aYYJz+Gx1bgWsOmn
 3LIjJXIjOzOCRCz50k8coBjXXFZgFT2UiI4EKoZg=
X-Proofpoint-GUID: UIC9lm6EJvcWv3ml4q2RUU1QkWoEtfuk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/11/26 4:18 AM, Vladimir Sementsov-Ogievskiy wrote:
> On 08. 09. 26 10: 28, Akihiko Odaki wrote: > On 2026/09/05 5: 57, Vladimir
> Sementsov-Ogievskiy wrote: >> The action variables are now used only within
> system/runstate. c. >> Move them and qmp_set_action() there, make the variables
> 
> On 08.09.26 10:28, Akihiko Odaki wrote:
>> On 2026/09/05 5:57, Vladimir Sementsov-Ogievskiy wrote:
>>> The action variables are now used only within system/runstate.c.
>>> Move them and qmp_set_action() there, make the variables static,
>>> and remove runstate-action.c and its header.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>   MAINTAINERS                      |  1 -
>>>   include/system/runstate-action.h | 19 -------------
>>>   monitor/qmp-cmds.c               |  1 -
>>>   system/meson.build               |  1 -
>>>   system/runstate-action.c         | 46 --------------------------------
>>>   system/runstate.c                | 34 ++++++++++++++++++++++-
>>>   system/vl.c                      |  2 +-
>>>   ui/cocoa.m                       |  1 -
>>>   ui/sdl2.c                        |  1 -
>>>   9 files changed, 34 insertions(+), 72 deletions(-)
>>>   delete mode 100644 include/system/runstate-action.h
>>>   delete mode 100644 system/runstate-action.c
>>>

[...]

>>> -}
>>> diff --git a/system/runstate.c b/system/runstate.c
>>> index 5d10ff0df99..a5f16da975e 100644
>>> --- a/system/runstate.c
>>> +++ b/system/runstate.c
>>> @@ -2,6 +2,7 @@
>>>    * QEMU main system emulation loop
>>>    *
>>>    * Copyright (c) 2003-2020 QEMU contributors
>>> + * Copyright (c) 2020 Oracle and/or its affiliates.
>> 
>> The deleted runstate-action.c explicitly licensed qmp_set_action() under GPLv2. The move retains only Oracle’s copyright line under the destination’s MIT header. I guess noting that this file is licensed under GPLv2 is the right thing to do here.
> 
> 
> Hmm.. Funny thing.
> 
> To move qmp_set_action() we need an ack from Oracle. Alejandro could you ack it?
> 

Hi Vladimir,

I don't have any objections to the refactoring itself, but I don't have the
authority to act on Oracle's behalf to approve a change in licensing terms
from GPLv2 to MIT.
I have reached out to the appropriate contacts and I am waiting for their
response. Just wanted to let yo know that I am following up on your
request, and will reply as soon as I hear back.

Alejandro

> To move the whole system/runstate.c into GPLv2, we need and ack from "Copyright (c) 2003-2020 QEMU contributors", which is a lot more difficult.
> 
> To be honest, I don't believe, that qmp_set_action() worth worrying. It's a small simple function. I think, we often move functions from one license to another, and don't even look at them. This patch is noticeable because it removes the whole file, and license is visible in the diff.
> 
> Any opinions?
> 
> -- 
> Best regards,
> Vladimir
> 

