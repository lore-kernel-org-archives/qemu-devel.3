Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5304C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI6Tr-0006dl-HF; Thu, 22 May 2025 10:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uI6Ti-0006cz-CH
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:01:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uI6Tg-0004Sy-0J
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:00:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MDq404023166;
 Thu, 22 May 2025 14:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=IzkpLgLhghu16bHZyyzrnTKH4eMAvd0hI2sSf10CeOA=; b=
 DPuXIpNltlqrlctJviCCTkPo8rWKcqv2q1HdljkOrKZ0vRUXpcv9FLMuOCkFLy1O
 +9to3ffSwxgjONesUldQAyYwYjdbXWbl5wD2AAobVa85q5KPcU96AKwbKbCzrXIz
 hzXxo9CPBXzY1l2KHe0HoFtZD/zNnRUvUu6NsEPZYHUXSJkWhqffhgwWCEVBkfhK
 a1vyXYPrnvBhDMFDZ/um+OYEouV3fSgK8hAIU7bfvna/DpIq44tJb2b9Fh8/XCyA
 z6i8TuKtKsQivryynH4nnh8Q+p3pQlXrVPdu1pK5XRmdZkFw/c/BG1g5JXTlPOBU
 cV3h/tM8SoCye4cLBDujhw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t56d00p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:00:50 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54MCYTgB033534; Thu, 22 May 2025 14:00:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rweppwaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk4r5NO9+EXvT4vHGWXyqzKAwbxyCJKNqs7ukTdzrdrYkTFzCTB/IMfuwss7CEV9Jzfa7m79t1T3bNDCH1zBFfprpBSz2SqiGCpYcqhGOHYET/6bcW6EuF1wcxw1tTC0xRvNPf/Q4900p/vr57HBt91UIpLfRYIZeAnpTttB1hud4idA6jF0KZb1use/ys75aip41dVEqDwvXii3gEZYBydJhQKfBwQs2r8TiOqoqD042o3g6FnQsmJ0xVqUzH95yArk8iBascyPQBoJj9hGJmYY1HbksoT2BsM/YmewVINXecDLS2Td2xRzlpit7j7PE/yxk+H5crZbn+OtecPkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzkpLgLhghu16bHZyyzrnTKH4eMAvd0hI2sSf10CeOA=;
 b=CXpP0WY9SUDCwV+taHS6LDzCwqiwqWuQ7aETyP6jJ2bgVJ7u2rTBLR0xkrb6hejpnn50BdCxbJtUCQstpK5spEv+8t5AKXy8MgE0LsvECi2u1BqB/OH8GPu8imv4g6hfk0ohJ0Vmoq5YwAAiKiS7iB8iqZn3UVTM+2qyBB1XG6pgkkiB0uyVdDnue8+2JOJqOsRlT0CVTpIHH+sjWkxgh+/dYffaKUvBzbtcJrHwfAYP5nwpJKAJTCP72nOkh0Hb/UfgY5jDNtVtHpHP4rxWpjzsAMk9xykI61pbSllo4oYkc4lCchZHaXJMkxQs9E2jyCjlgGU4ZumFOi7pWUkZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzkpLgLhghu16bHZyyzrnTKH4eMAvd0hI2sSf10CeOA=;
 b=Hlwynsw3+6VEWnrtnDJe3MC20rBSVVcRY2x/zeKiRC/DjoIgyK02JWFZ3mIKe96h5fz23WxVbaSVjejpwOaMucGA6yPU278nqtgsQEH86aYH28j7QNV/BoAck0Gxe9w9tcaoYmv0PJDnqQYqoxBVXFkewrbShZoadmRY2QAfuJ4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA2PR10MB4428.namprd10.prod.outlook.com (2603:10b6:806:fa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.34; Thu, 22 May
 2025 14:00:45 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Thu, 22 May 2025
 14:00:45 +0000
Message-ID: <49029a24-e4e5-475a-abb1-bc0d373f11b5@oracle.com>
Date: Thu, 22 May 2025 10:00:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/42] vfio/container: restore DMA vaddr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-11-git-send-email-steven.sistare@oracle.com>
 <b6ef4b4b-6f10-4640-8668-77976ed0076e@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <b6ef4b4b-6f10-4640-8668-77976ed0076e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA2PR10MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af3e20d-5a70-4ecb-9d6f-08dd99390c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eStFRjJ2OHFJNEZ6a3E3NHoyaEk2Rmd4bEZsb3dvUFdHbHlFbzNjWkpnanZR?=
 =?utf-8?B?UGRQNnpNeU8wK0NhZFpqRVgwd3cyWXRBbFRqbzJNZk9qQy9zT0p6bStLWElx?=
 =?utf-8?B?T1hHclhCOWpCaW5zT1B0UWxaVEYzVUR5OFRxZzZEYkxPeVZiNkZZNUlpeGFv?=
 =?utf-8?B?MklxTDRtM3VOUzZxNlltUldvVXZ0R2ppN1c3MnJkRjFCSkhtMHlCNEZZeWh6?=
 =?utf-8?B?RVNoWXY4WDJBQUFkSDUycWp4YjZyWGNLZDVpc0lzOUhaaHZHUDRuRHZianpq?=
 =?utf-8?B?TEtyTFFjTEJtbllBMWtDUCtYV1A5TGM3RnVpc1JDd1ZLWVBPV29RQVZkdlI3?=
 =?utf-8?B?MEIwa1g2S2ZvaThNT1lvZHRmRmJtSVkxS3MzMmZIU3I4ZG1tdEl4TkRDUHB3?=
 =?utf-8?B?S3Rka0w1WFNjcFpYY2k5dytUNkE3bnh6ai93TTd2cllZNldMaVRtVi9vTGtX?=
 =?utf-8?B?OVZYUmg1dmJVSkpOcmJRcm5acDhrWnZsTnRQNXFESjNBY2JBSlFCNGpENGlm?=
 =?utf-8?B?MDZyUVNSRG0vSXZFYmNoODdmWGcrdEFZamVIOW5BeDdRUTM1OTR2SXphQm1r?=
 =?utf-8?B?dWVMaGx3YlAxMFNES0F4NmpNaU5yUUlBdFBZd2xob1BPMUpwdjhyUnVZM2lT?=
 =?utf-8?B?bDdhN1VTZDBQeWVmclZtTmNFTmVqMjZmc0dlZHl0LzFkZ0RnOC94VVlNZGJz?=
 =?utf-8?B?YWZtT3pVY3ZUdDNqMldLVkl6RUhuSFZwWXZqMWd5YVJKNnVsalRGTS9BdmFV?=
 =?utf-8?B?T3JUd3MxYmZDKzl0OVRwRVJXKzJ0YUtqck5lbll4TDdQQ3crV0J3VytsNjhO?=
 =?utf-8?B?YjhXWi84QmVZWWMyZnVCb3hGcytDWGd0b0w1WTd0Wi9NQkNRS2tQU0U3VWYw?=
 =?utf-8?B?ZkpVQ1BWUlFjdWNpTlVRbE1pd3lIbHhIV1VNN1N5TktaVEVhSXlyOHVTSmg4?=
 =?utf-8?B?WHM1b1h3N2VUSXJ0NEFpRWVzaUl5ak1YMWdSdVJyeHBHbUV1WFhEU0RTZTBB?=
 =?utf-8?B?OHpCbFUwek9FVC9Ib0FUUDFveUtNRFViNU9jZE5YM3IrS0JybklLV09UQXlk?=
 =?utf-8?B?R0Q5b3JwNUluUEkrckswVTZRZ3k0aTVTVi9jZ3RsNTJjK1FJbHJjUEY2dlEx?=
 =?utf-8?B?NlZobjVoa0ovTjg5bTFCczA5R3QzeDZuZytRWWhqZm91a0ZIRlRkcWIxSmd5?=
 =?utf-8?B?WUtINUtxM0hEa0ozTUt1VUlPejAybzZSZzlaZDBYY1Q1VEhmcC9WanpIQ0Y3?=
 =?utf-8?B?Ym1rdjJrRDdNaURRSE8wMFVCdGI2SW1rSVVGWVNXNzV5RUdLNThzV1NweVdV?=
 =?utf-8?B?QzhOa0I3VmRXc3liRVZ1QWx2ZEVjZGNjM2NhVkFMVlBrNWZ5RDFNcTBYMTd5?=
 =?utf-8?B?clgzQ2xYdG1FczlpMU9tRDRuV2xXaTZwL3N0MmczcEE2ZTBLaE9oNGwxUmZK?=
 =?utf-8?B?ME1RRkNDYURRZFJJZnZqa3hpcEttd0VuQlJhTXc4dThpKzAzQ0dTU21BRXVn?=
 =?utf-8?B?NW05bUZXWUdqYnRlSEx4dU42alZwK1V1TTEwNDE1aDJGa1hlWENtUStpcDd3?=
 =?utf-8?B?ZmRXSmg3RTlKWFdObyttZm5lYWRHbkRKZk1DdkJYR0ZJRlVxYVlXVHQwczJK?=
 =?utf-8?B?RDFETUwzcUZTS0hTdnJtSWxUZHY4bkFuWmRlMmh1WWY5eUJJUnUxOXNXdTlV?=
 =?utf-8?B?NlJpRDBLR0g3aXZSKy9ZOG1EVmxNbkZCMUFjVWpNcUU3Z052UjRtWHNKekVR?=
 =?utf-8?B?Y09Zc3VUZHo5b252SEllM0xNZ09ESHRtU1l4QlVYZmE3cUROOUg2OEVJSWVk?=
 =?utf-8?B?TnBxMVkzWmg0QW9zNlRhdVFHd3VQZElaaVFsUklwWEhjMW5USmFENlkrNFQ4?=
 =?utf-8?B?MVJLQUdMN05PQ1ZXT1ZsYTF4MTZEcndtaUdFQUJaTmFxdXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c21UYXhicy9FZGt0T3U0QWloaFhOSG52TUVsYkQvN0xYOEQ5akc5ODExRzBL?=
 =?utf-8?B?MVFnUWp0U1JqZXVxdmZOL2ZCK2llYWh5M0xCRjFraE1xaS9rRmwyeWQyRG1K?=
 =?utf-8?B?aG5ZWVdIZXVxd2J5NitPUEVqTTd3djl5U0NUM1JpOUdVaWRDTXowS1YwRjVT?=
 =?utf-8?B?ZHZBSDZMTGRmM2pWbFV0N0hsclU2bVVEQXdNdFZpMWt1ekYzbjM0WVZvd2hz?=
 =?utf-8?B?MGM4RlBIOW1ycTA4dWxBQ01VZExHUVhmNmU4OGFQYXF6R0hRQjdaYWdSTTNt?=
 =?utf-8?B?enBtVlhKemNHWk8xaXdtYmN2ZWoxT2FFc0diT29WM1l1OG1PeWVRZVRiYWlG?=
 =?utf-8?B?aDF0NFM2NjlhQzBCZnNmbVlmcGd4b2ZzWC9CRkp2V0FYd3FwdzlBYlRrcWlB?=
 =?utf-8?B?K3dEVWVPcHE1Qkk3RzJCaWdzZmNCSUZlblU5aFhXaVlzNnVuNXhHUTlZQjJB?=
 =?utf-8?B?WXVKWGhHSC9CS2JzWTltaTlXNE01YXdoSlF5SXE0cVNyM0NtM2U4TDNUWUhQ?=
 =?utf-8?B?RW14a3Y1RSt4TnpzejhRWjg2Zk1QOVhqWXhiQW8xOGNmbitySWNZT2QvZ2xp?=
 =?utf-8?B?SHNlR0htY1hGN2M0NUFuV1d3ZFNNbHJNUmluUjlyWnNCWmdoanNMZk5WOWpq?=
 =?utf-8?B?YzBiWnRRRFBWdHg4MHdSKytvZm9LR3gxSnIvMmwrU3RoOXBCcVNiajlwQkRE?=
 =?utf-8?B?RU8xY2hZV29kbk9qVlZOV0VYZGc5VkRQVHpEUS82SGZaeWVKeUFPQUs3VXkv?=
 =?utf-8?B?MkZBUDZWc1p4VHF3K3d1TDB4TmZmaHFDQllqaS9VSWp1OGw0SURadEl6MElC?=
 =?utf-8?B?dEE3cWJXWllZSlFvQlNRbUNFSEtNSC9zZWNPRGI3em4xc0p3VkFTMERZRUIw?=
 =?utf-8?B?VkxvRVlnUXBhN05ycVFLN1BWVUlJaG1BcW5vc0Fwbm9tUE9OUTJ4bldHY2h2?=
 =?utf-8?B?MFBuYm4rc2I1aW9PSmhNRGJwTk5NWTlDOHlmVjliK1MycThsOXBFYTRFT09H?=
 =?utf-8?B?aXVlcVJiOS95WnJsUFg0aDhHM0pPWjhNMm9CNEZ1b3h1NVRidHdvTzlseHl2?=
 =?utf-8?B?Yi9FUUhtSGR4NFVKOU5KQTdSd1hQSThXTHZJa0dhaHk2K1dRN2sxS0syWmo5?=
 =?utf-8?B?TTgvakNZUjhEOXNZNzNWTTVxQkFPbFRqNWtnM2dyMXhRd3RTTEYzbTZZTlVl?=
 =?utf-8?B?cldVMFZqNzdzWW96OVJUblFpYTFqdS9HemNRSHlwUUZaUW5iTFpUL2JZRzNx?=
 =?utf-8?B?QnpTTEpGQXhsaU1Xd3RZaWxhS2dJRU51c05VUlJ2cXhvZEVzN1pUWW1KQUpw?=
 =?utf-8?B?YVpaWGQvb0lCc2o5cHQxcWdJanhWMThlU3Q2THNrR0hQUE5GZ0RqK2VEZXcr?=
 =?utf-8?B?UU1tMHBBallaQ0R2SkhxaytuKzQrZjQzRUhBaUJzWWN2SjZKWjBnd1pvZ2kw?=
 =?utf-8?B?eWlaUmNGdXlqSURDdm5HNEVWZUNIYlIzQlZ3N21IMk92QW1kNTY1OEZwNlVU?=
 =?utf-8?B?Qy9NOVhJU082d3BEZjdmVy90TU10b1ZqeWdoQ0kzaGE3d1hHbWw4V0JYTzYy?=
 =?utf-8?B?MmpDd1FGbGdrVzZQL0JWT0hVVHo4TzBYZjVwMzZIUjJHQmZqTU40OTU1TmNn?=
 =?utf-8?B?dktQdEF2eDVFL1FiWExtc3JrNXdncHlIa3MyZ2ZJdnk2K0ZSQW00L08zMzZZ?=
 =?utf-8?B?VE5aWUFTVHpadmdOU3VqRG8zakNsb2FmYk5vSWhvYk1SWFRHdjBKd1NBK2Zh?=
 =?utf-8?B?R2tPbVdlaTBXZlNYU0dwK2NDek5nd3J4TFo0QzhtNkNnMzNkK1pVNnA4UGRW?=
 =?utf-8?B?UklFQU9GVmZ6MG1hV204VzNlRVUreitKVGUwUDBJSUZrRFAwZURGY2E0c29U?=
 =?utf-8?B?dkh1VCtVSkI0cWJHclVTMlVBY3ZiTS9EVFBVSjJjMzNEaFhVdnVTcVRRV3Zx?=
 =?utf-8?B?cHd1S2k3Qk41NC82cWlJVjdPZ000VkVKNThlUGdCZXJkS2psSllhQ0RhcDE4?=
 =?utf-8?B?ODROVGFPVVVtSmdYRGVBREhiejEyVG5pR3NyNytsTUtnT2ZxYnY4b1dzNHJl?=
 =?utf-8?B?NC91VUtkVHJXTU9IMXFKM0RDVXBEZUp0RUtGWFNQY2UvYzZZMEtucFd6djNh?=
 =?utf-8?B?d0lSaDQvTHZwSlY1dWNwdjRVMTR5aHdmOFRNamdqenUwSHh1Z05TNml3dC9X?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uSPrf37lk+PgaPscUO/XHA+kQEv02DDuOWnd1Uh8/q2zLXjfk5XnUdL9y7WtCR2KerBYjFt8oM530Va3+JlYjIwK1oV+drmXZQ55Kx5oYSrlaMGQtUtbSB353yVETOb2LNgOeCCLUXE3zhyqbuSiJvatlbZ8gCl8QOA44RNCpTGr5I0wvz5QOku2W9bh21EMMJ3L9jDHaW2JFdSgnZUw41t0MkglVncyLI4pWAKutv20X+UZyeLOuSO6Qsi2zSqcddyJ2CyOfpEtZ+qSKJYpsfewVzr+c5Rk6pqxcHLT7tkfkScHimLSnP980NOLLiP1LfL5MOTtt3FkPgFojEhKzxUvL0VOXvI2wukt2BaErQAvLJVh5RkapuDvpDyibamIf7Y06u7aj8ONJRotB0YixKW8jtaxZIuQr8yC9C83dhjO/MhmAsbCFSRnpvsFY5RWfh+h13U9kFhSlGI/F7yl7dJzeEQSG14QVTYXaaUsWKXyZsTO8FZGYUNhI4XW7+TLcdy/RFSkrGZMZwl5dbtUeGy1P6qzHZRi+iHI5M1UmzgHXvSFUWvObCGxpwchA2dainxTuLnf1JPIkY4quayJxSdGRUn2bx+0yrIqI+XovaE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af3e20d-5a70-4ecb-9d6f-08dd99390c21
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 14:00:45.3871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IAFkcSOfzsGUjrHE+4AgUEOVK7tlGcR+6rxTDUj6dNGaTzOcC0TenEf1XZ3IRbCp/TeYD9gFKG2C6qVouYjhWfqkDOXZq/NOhIjl8rO+OM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE0MiBTYWx0ZWRfX3000Jvv41+Kt
 S/FznE+MkoqO79E+N4W9AUB2SPu/MLmTxH2HLTZwwlGQcijEDPROqv4UUtb0PADRVyzW9jV6Yf3
 mDmUDW2mznYovsLxMAA40O5b4h4Et52kA04fjB9QUHJsaGqqKgagoiTl7lwaXhA1nRD+ewSvP1A
 RwUoygqADsBXTAV1yzbdr7Amk3st/sBfG2x5OAG66MaWG9nNTFPaJsPzfOJmI8++Gqp249w/vdj
 u0/N+ekJk9vpEzN28RowbltS2SF5+HstNMXih3mE6HOhmR3DzZYsfbjElRSGS6VVequf+JLw91o
 VH6RjrKzk/KSB6Kahyfz9OT7sWmqsm2XgCHx9MbIf9GhavDyZvpr2dqSe3K5w/qK9Qs1+1vYOWU
 K0N0XVmIIYXNTUzukTvdk5AMpruhLFORmZYHNQwG4pdw+TqjZyYTZNZs0np78r3EV0rkM9xD
X-Proofpoint-GUID: m6-mN6F7VvpdVSNqYrRbbKujKdBBXRta
X-Proofpoint-ORIG-GUID: m6-mN6F7VvpdVSNqYrRbbKujKdBBXRta
X-Authority-Analysis: v=2.4 cv=WvkrMcfv c=1 sm=1 tr=0 ts=682f2e12 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=pfo2m88UJNmgxuZIXMkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/22/2025 2:37 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> In new QEMU, do not register the memory listener at device creation time.
>> Register it later, in the container post_load handler, after all vmstate
>> that may affect regions and mapping boundaries has been loaded.  The
>> post_load registration will cause the listener to invoke its callback on
>> each flat section, and the calls will match the mappings remembered by the
>> kernel.
>>
>> The listener calls a special dma_map handler that passes the new VA of each
>> section to the kernel using VFIO_DMA_MAP_FLAG_VADDR.  Restore the normal
>> handler at the end.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/container.c  | 15 +++++++++++++--
>>   hw/vfio/cpr-legacy.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 61 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index a554683..0e02726 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -137,6 +137,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
>>       int ret;
>>       Error *local_err = NULL;
>> +    assert(!container->cpr.reused);
> 
> assert -> g_assert

will do.

> this can be called at runtime, which would mean crashing QEMU in case
> of error. Doing an error_report() call is more friendly.

It is an internal error if this assertion is hit, so the state of the system
cannot be trusted.  Hence assert rather than error_report and attempt to recover.

- Steve

>> +
>>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>               bcontainer->dirty_pages_supported) {
>> @@ -691,8 +693,17 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>       }
>>       group_was_added = true;
>> -    if (!vfio_listener_register(bcontainer, errp)) {
>> -        goto fail;
>> +    /*
>> +     * If reused, register the listener later, after all state that may
>> +     * affect regions and mapping boundaries has been cpr load'ed.  Later,
>> +     * the listener will invoke its callback on each flat section and call
>> +     * dma_map to supply the new vaddr, and the calls will match the mappings
>> +     * remembered by the kernel.
>> +     */
>> +    if (!cpr_reused) {
>> +        if (!vfio_listener_register(bcontainer, errp)) {
>> +            goto fail;
>> +        }
>>       }
>>       bcontainer->initialized = true;
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index 519d772..bbcf71e 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -11,11 +11,13 @@
>>   #include "hw/vfio/vfio-container.h"
>>   #include "hw/vfio/vfio-cpr.h"
>>   #include "hw/vfio/vfio-device.h"
>> +#include "hw/vfio/vfio-listener.h"
>>   #include "migration/blocker.h"
>>   #include "migration/cpr.h"
>>   #include "migration/migration.h"
>>   #include "migration/vmstate.h"
>>   #include "qapi/error.h"
>> +#include "qemu/error-report.h"
>>   static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>>   {
>> @@ -32,6 +34,34 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>>       return true;
>>   }
>> +/*
>> + * Set the new @vaddr for any mappings registered during cpr load.
>> + * Reused is cleared thereafter.
>> + */
>> +static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
>> +                                   hwaddr iova, ram_addr_t size, void *vaddr,
>> +                                   bool readonly)
>> +{
>> +    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>> +                                                  bcontainer);
>> +    struct vfio_iommu_type1_dma_map map = {
>> +        .argsz = sizeof(map),
>> +        .flags = VFIO_DMA_MAP_FLAG_VADDR,
>> +        .vaddr = (__u64)(uintptr_t)vaddr,
>> +        .iova = iova,
>> +        .size = size,
>> +    };
>> +
>> +    assert(container->cpr.reused);
>> +> +    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
>> +        error_report("vfio_legacy_cpr_dma_map (iova %lu, size %ld, va %p): %s",
>> +                     iova, size, vaddr, strerror(errno));
>> +        return -errno;
>> +    }
>> +
>> +    return 0;
>> +}
>>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>   {
>> @@ -63,12 +93,24 @@ static int vfio_container_pre_save(void *opaque)
>>   static int vfio_container_post_load(void *opaque, int version_id)
>>   {
>>       VFIOContainer *container = opaque;
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>>       VFIOGroup *group;
>>       VFIODevice *vbasedev;
>> +    Error *err = NULL;
>> +
>> +    if (!vfio_listener_register(bcontainer, &err)) {
>> +        error_report_err(err);
>> +        return -1;
>> +    }
>>       container->cpr.reused = false;
>>       QLIST_FOREACH(group, &container->group_list, container_next) {
>> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>> +
>> +        /* Restore original dma_map function */
>> +        vioc->dma_map = vfio_legacy_dma_map;
>> +
>>           QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>               vbasedev->cpr.reused = false;
>>           }
>> @@ -80,6 +122,7 @@ static const VMStateDescription vfio_container_vmstate = {
>>       .name = "vfio-container",
>>       .version_id = 0,
>>       .minimum_version_id = 0,
>> +    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
>>       .pre_save = vfio_container_pre_save,
>>       .post_load = vfio_container_post_load,
>>       .needed = cpr_needed_for_reuse,
>> @@ -104,6 +147,11 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>> +    /* During incoming CPR, divert calls to dma_map. */
>> +    if (container->cpr.reused) {
>> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>> +        vioc->dma_map = vfio_legacy_cpr_dma_map;
>> +    }
>>       return true;
>>   }
> 


