Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3840AE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 19:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTQlS-0004sg-7n; Thu, 02 Jan 2025 14:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTQlI-0004qr-57
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 14:21:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTQlF-0007kz-NY
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 14:21:39 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502ItqPL008416;
 Thu, 2 Jan 2025 19:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Cahw8neDLMPSemIrs6GQD6wmM50VQZ/y1MXj6qxBzM4=; b=
 RBD1oZAlHPyiSTUQciERtVgH2nli9tlINb6pp6lqcbVnKRxGS56bX5Cy6jTPc8FE
 p1qx0qvp58Rd5MavPrEVQaDgv4+eC6tX6GRzX5nqU6dKEX1SnWrRdbaKAqIBlcKt
 FnjaKixFrUb/7zTGJUiEUTGZdOSdlEXhgXJZM9dk77iXaOded5d3xVhKNrdoDWHZ
 3de/AgRg/vodokJ8p8NAf+vsZe8EKV1FYINsLS2uydb0rZizbZDDiawVRJNshHiZ
 U/IT8afUQ6J/e0L5KYKYw5pnCJIIPmiaLJamw5bFV8qtEg06Rzir+zMaH6QcUjUu
 TodQNmoKF1bbmR7J9OdGXg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43wrb89p7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 19:21:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 502IXcjZ011741; Thu, 2 Jan 2025 19:21:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43t7s900mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 19:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ7WO/gYjj4D6kdY+A+qzkpQv6Gyq6WJh/JCthwn6xHBfWI/oYy4VHuDtdfnNqsvR1bWmiQBUaAeu3CY9QLUipI0Kqklsrph+mvR4FdXw5XAReGgUS7xjVtTYcVV4jGgS7kcswG/rC7vE85rENbezgtFVH/oT2EPRrPpL0+Qj0CYc4Hg2/Y2nOdkO8v/IS0HbcfXFtDh/h37NubpV8eisb+we9TLsmq9MSs4Tmamis4R5Eurad9YJf9xHlRntoUsDC2LoVfyUS2OWOzgBjAtg8TmLySZiAWHN8LXHSycmm3uvr1zcPC+wYD5kCQTH0yVUCEVv96G9AE5DLfaEBGlpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cahw8neDLMPSemIrs6GQD6wmM50VQZ/y1MXj6qxBzM4=;
 b=BiQz4TQ6PET4YBycZ1Xqp6Btzw9+CAqvE9RNqEQMpQc0O6ZMbs3S5079zyXrtT1UaWmM0mrdpmRuzHd89eqjxCCHD6f2UMHKFTS8G3MUJxZ8f1JPcx4S2OLf7z6BKr6osRZ+MLp9clj0Q/XJWwkfmSnmdKvIoz8KridZqMPud1x8kpY2nRmb+/zfYCSy59MbTlQRPp3uEBdHvcKVQLhEDC9zEU+l/5igkL3y/8tHxYTSZvPXs8O070esSO95A+736RhzlBBNeLAYYJ528wjLOXGTtnPr1AKwfMGKEEv1oc9j4vo3Ba2ODGX7nUkzHzow20GDYWKfUqfuiuMdDZmErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cahw8neDLMPSemIrs6GQD6wmM50VQZ/y1MXj6qxBzM4=;
 b=FMGtmis/EvBazcbiyyI80eKWwjP0kNz4U9oNVJrJv4Y1A6TL5rH8oolhVe8uCLLcvBBotkFIBDEze14gsi46HGBNzh4RPjDxr1S6gbH1cH6cZFXIllJZtoWifXe2OGiUxkpdEQDeIuH3gd9uA580tIAJTx7dimqO81Ov52kYd/I=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6311.namprd10.prod.outlook.com (2603:10b6:510:1b2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 2 Jan
 2025 19:21:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 19:21:19 +0000
Message-ID: <72eaea07-ccfc-4134-84c5-1bc044f7ddae@oracle.com>
Date: Thu, 2 Jan 2025 14:21:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 15/23] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
 <Z2sKXAgsUW3A8ajg@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2sKXAgsUW3A8ajg@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: a8bb5bd8-2708-4059-1716-08dd2b62a2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anh5Vmtla0NXNUNxSm5Ma0o5U3BNYkNWL1loYnJ1WHNTUmhOTFNNOU55Z1lx?=
 =?utf-8?B?OXEzYmd3Nnl5Z2hPUjVSLzE1QnV5TldHNGg1QVE0ak96MnA4bCtuVUp3Slc2?=
 =?utf-8?B?RUJZQmNaVThKWUpiQVBWVkxFbExYb21yQmxMRDRidFhhbWl1WmVTajFFR0lP?=
 =?utf-8?B?Wm5lTVNMODc2SlI0bnBBQWpBYzJwSERPZ09SVDN1anZkQTBqS1BXZklscHBQ?=
 =?utf-8?B?dUZWZ1FPQWhtMXpkY0NsWjhvOGE5Vno0bE95V0o2T2ZFNlRFR0lKeGFxM3dy?=
 =?utf-8?B?NlhCSUJRUUFqN2FBUy9KalAzSUQ0cmlFTU5hS0h5NHYvZS9ScDJWNmRYVTd2?=
 =?utf-8?B?MUlGTU1YL0k2NGErSlJ3NWVHUTV1QmZsTmhaUUJxcjZ0SXlnSWxOd2lFdzRQ?=
 =?utf-8?B?RGtrYnlIdGlDUlNzNEg1UTFOMmppTXFESHhGK3QvQlFQcXpPZHQ3c0FrSmlP?=
 =?utf-8?B?LzVqWSt4UGdOZ2JRS3NsTlNDZndaTkhlQU5vY1V5aWhMU0wzcmIxdDJNYlVS?=
 =?utf-8?B?Q2pmYWV2ZlBjak5NRmJIbVdTWUFSaFFNV2s3eEp2S1E2Y0pVT0loRGNaUXUx?=
 =?utf-8?B?UzVDVnh0TGFrTXcwRXA0ajM4cGwyWXBiNE04SnVza3lDT1NJTnROR3hxRnpo?=
 =?utf-8?B?SFZ6eGNidVN0Rno5a1VBaHl0aGFkRHRvaWlIMU9kK3pXaU9hVEJ6ZTB2ekY5?=
 =?utf-8?B?bWhSaHhYdjFBTnZ4cjZ6dmVBSFUyNmxjNDl0M2pCT2pqRWNab2wxSzh5cGxZ?=
 =?utf-8?B?NWU0MjhLNFVodjROV21rMFBVUlJiVU5UTC9xcEx1d0tZL1RDWW52ZFRPb09G?=
 =?utf-8?B?TEl3M2lVNytnd1NTYUJqMXNjaHEzL1dSM01vNFdwOEhXWjRWTFBCR2h4MFNF?=
 =?utf-8?B?UGovVGdJTkhXTGVkTHFiRUtteUVZTFhwN1lvOWp5KzRQemdGekZuQTM1bTdy?=
 =?utf-8?B?ZDFsbUVEK3M1NXY1WENsT1Zxa2NrYkU0ZnQycjh3STI1dnA5c3l6Qlh5ZG9v?=
 =?utf-8?B?L2s0Mk1lM053U1N3NWh4blhjTExjMjRDeUVnbjBIejFoSzZ5WGNyUGRMZkxM?=
 =?utf-8?B?L3I5UG1CSFlBbldWeDZqZkhYN2dMN2U5V2VOVk5wTjVlTDJEY2pmZExFYWNO?=
 =?utf-8?B?L0RVSmQ5b0ZJZzZzVzFSZE9aRmgrbVdnZS9sVzRNWmphOGkrS0RSbGVJeXRo?=
 =?utf-8?B?SzlrL0sweC9lTWhmU2IyaTV0NGFiT0RYbEt5eFJsYTFidGhyWm9UWlNBbTcv?=
 =?utf-8?B?dDd2Y2pCRXNudC8yRURvSk9NRDdyMytEWW1rTFVzaCtBQmFkdjFqVFY3Smtk?=
 =?utf-8?B?NVFvMnR0aVhNazlmMjZ3dEJ0aTNuN3gxMkhhV2x6ZWlJN1YzMmIxV2U2R1ZI?=
 =?utf-8?B?ZEppOVNoWmpQeWg5bDltd0lzVXdPVHVuNjhud1hSTFF6cklKNzFCUFcxS1Nz?=
 =?utf-8?B?TEl6WUJGaklxZFhHNGU5Wm5wbWJOWkpUOHdqc3JRTkxiUU9CdmN0M3M0RUZ5?=
 =?utf-8?B?aTNycGYzdGhTWDY5endlWDkxWUhLK01UWnVXWG1BTTBHTHVzRkZzUlRiTlR3?=
 =?utf-8?B?d2JjM0V2TWRYMzZuS3NPaEpkN1llSUg4OEZhK1lNcHRpdTVxM1g4WU1JOGRF?=
 =?utf-8?B?WnZCUk5TWUhSVE8rN05qR1VpNWRQdHdJKzBQbWh0UUFHWVAxN1FJYm56MEpt?=
 =?utf-8?B?aElGNnlrNFhpaHR1eTFFcXp0MHByQjgzN0g1OUpvRFNlN3pWRGxSbm04cWZK?=
 =?utf-8?B?R3hVaklmblRLTDJ4UER0RTlWK0h4U0Rza01uQWh1bHpOVzhJeG5NbzkvZ0cz?=
 =?utf-8?B?WGVsWlN1bS9xUEx5dTBYejBpN2RKZkZpemdDMGUzWVpnQnZzaEZhU1RXVmtQ?=
 =?utf-8?Q?n0G0zcbQ2zjMA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFdPS1JtSklnZGJRcjhUM0lOR3p0bkZwM04xVDNTZUtkL25MTE9Ld0RUeW1O?=
 =?utf-8?B?cS9kdXlqekM5dFFxUnlIVk1LaGtqc2R1VHdkRC9wTllGbE9RUyt2dE9kakl4?=
 =?utf-8?B?RnNrUWJQODlVVnIrU29ka3RPMFp0UEJUc2hMZzBxVFZiUVU3bVRYMk1XRWF4?=
 =?utf-8?B?VFBkTWJvRlZLUk16Tk5hdm55Z0dFN3Q0TzQrdEh6VFhZaHVURHIyb0N3d3ZW?=
 =?utf-8?B?VUplTnduUTJhU09LcEhpWVc0V0R5V3poOGtIS0JPeXBldzEvczBOaFkzbzR3?=
 =?utf-8?B?d1FLQ2lNcjFxN2dSLzdZSDd2d2V1SVJralFGT3FZeHNPRWE5NFBBRlI4Y0R2?=
 =?utf-8?B?Ulp0QytqOUNHK0duSW10QmRwZTFsQkZKV0ZaS0ljTUZxYUxPT3lsTk55S056?=
 =?utf-8?B?ZHQxSTBOekNCcjFqWmVFaHhOVGpGaTFHK3BZdUtkb3pTRVVGTm9GUTBUcXpU?=
 =?utf-8?B?SDJndTVIVGtlQllxb1lEaEI4N1ZKcEszU2swTkluUVBwYVNPS3IvL3RoOGlk?=
 =?utf-8?B?YnV2SnE4TWgycWwrVlRNcW14TU5tU2ZhRis5MUYvZGVsZG1FaDJ2S01nOHJF?=
 =?utf-8?B?TkhvVDFzeFNPaUNCZG54SkhwT1lsdHRCdm9CanhQeitzMUpVaHBCOEVnK21v?=
 =?utf-8?B?TEZKazZCRERoMDNtdzVkK0dOdkJvN2NWc0JyUmkrR1Bzb1YrYXAwWFpUMmYy?=
 =?utf-8?B?S3JveVNQTUxlNURaRXJPZ0JKTlJ3d3RDOTNNYlFNN3Y5UTVUUnlrQlJYdDVM?=
 =?utf-8?B?M05TQTl0VHdTVC9ocnl2VzBXOElIL3hpNTFwQzJMQUJmSTAwSjBNMklpWmxP?=
 =?utf-8?B?NUE3T01hZmgvaDA5TEtvbmYzUEwxYTFLME82NWpBUXVCVU10a2lTaXphNXVH?=
 =?utf-8?B?S0JSZ3hMUjYvaGwwQng4cGlIOE5raVZMdGxUTVNaRWpoTDNtc1pTZklJdXI4?=
 =?utf-8?B?VXhjMGEyTHFiVTVDSVRGdlh2QXkxUysvZkxBakR6S0swd2NhbWdycTBvM0tN?=
 =?utf-8?B?b2lBb3RNQ3drNDM3d3N0MWJTTUdWOG1uTmdtVUtQN09BcmRVa29YdncvblRP?=
 =?utf-8?B?cnc0ZnNWbEgybEFBemIxaHNPMlgvSTd5UnRJa3JqMityak5hUTFrNlBLdFdC?=
 =?utf-8?B?dVRBWC9tZTg3cWhVTlhVZm5xNHZ5OEFwZ0d5NUxQbXNMbWdJb2wvYWVHbHN2?=
 =?utf-8?B?NThxbWxPTWFSWmZGbjQ0N0tiM2NiaUJPVWl3RDl1cUp1eUJEL3hRaWt3ckFN?=
 =?utf-8?B?SGFMMXp6RnlucWRTbXVNTU5GMDBRYkxvTXdRMmd6QmJ4QXB2Z3IxTERwYjcv?=
 =?utf-8?B?V1JPa0xsY1hRckdQOXFvQnhqTi9tUC9lZ3FaZTcrMkJuczVySS9xdSs1cVhi?=
 =?utf-8?B?b2owNStjVGloNDBWTUUxL1pBb2hWODhsUlZHUUlZWUE5dlRIRXJTcHlLNU1k?=
 =?utf-8?B?Tm9BNTFmTjl0bUJ2YmJ1ckNQUGp0eldZbWtxb09BKzRwSmcrSGtQbXY5ZTE0?=
 =?utf-8?B?S1Q3alJzVG0xUW9zUnVZeGw3WTNscXJ3b2VUYjFGbEJIUWJic1dsUzBtSWdK?=
 =?utf-8?B?VnBIL1J0WkVDTHg5cDNFTi8zSlZYTjJaTDVkeFBmNnZ0emFUdjVaMmlrWXI1?=
 =?utf-8?B?dEw3RkFJTDhlWURvaURlWEM3eTNpUEdzMWhrV2t1SVMyL1RISHRDS1VRVmRP?=
 =?utf-8?B?OXJCenZFUVAvcWQ0Y1Nub0ZXYktaSmxRMW1YVXRhTWd4NDVXaitjMEpxUEt5?=
 =?utf-8?B?dURlelBGREdjMWo1dStQZmovS2RhbDVTTmNoUzFHWW11alM5Y0JzRlFZeHZE?=
 =?utf-8?B?VlVEVEd2WU1vYUpESlZ4MUg2NFVLd2UyRW0yK09PSFpXSGtPckhBTTJtZDFn?=
 =?utf-8?B?L0d0Sk8wcElxd2RhNExWMjFvZEVwQWFNb1lTVUwvTTNkYThVU3JxaXMzMkk2?=
 =?utf-8?B?RjJDQ0RTNExsTEVka3pJYUhkRmMzb29KcDBCZ1dBSXRRZFhnbmNFLzNmb1Rk?=
 =?utf-8?B?N1o1S0YwUVFvUHhjUnoxUmM4WDQ5TGNvVmxlamVMZENPaHNRa1JYaU1mbUty?=
 =?utf-8?B?S3hORk15OW9kRmlpMkdqYW1MN2VLYUNOWkEyaFdKRTBIQmgreHpWaFZDckRx?=
 =?utf-8?B?cGEzTVUyemJvUDV5bDNZWlZFTUNJY3c5MUdTWVZsZzIyTnVTUE5HUkRXbGJs?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ezt7htLN5PwGyPAfn0CTgldcxxomdSPtV032yBXcVswpVrSmbsAtS1Aa2fMRYuOUdfTEekYIYR0OgIsJ0mXcSSc7WrftVAjNFAaowxTwlGZKDO6gIHQsGR+R9wNBX+45cmPf1N3WX9DnOdLTsll7m0+83sf+PqwlXNmt91bg0GAjTfl2gWUP3GkGFyMG0v4GXmr5cMVd1r7ktWU28CCUYJbLINSgZtttV7UQf/aGudtk6Jglm7d8udQtuaZRCIFJX46/r+9mnWd9p5YbApW2uLr3fpLzUYTHMcQHKp4lbNQFUfYBhLbPlpzYfEdBQF8akNEylGhPYEe04NppxeC/cC2Eq4DRBCrqcAXqs1SqMa5KXin4RRLRAFGVBma1RMetuatqHpJbFH4yfzXzSwzhbfTxzIL5tDSEiim3MMglF4ZlcWjukTt1uIb5G0rVInAr39E0J98Ch8d9A9UOo1AkjMOWuqKjsQssBCht+FQwPWvQOroF5a7l2nNE6Uoi36Gvi363oHjUexPZIktyR0f43R8Yj5WGM6nW6B0rDsCuNQxpxPyfyCLP8/eBHbN/FxQFkYN8DLf7/bFd8CjysMZ8wvGnHeRK7thTvPQb6xnpoks=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bb5bd8-2708-4059-1716-08dd2b62a2b3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 19:21:19.5137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbDH9lBi1cV5MiRF8ctkuAJz+gPSwnc+gemcOSkD3SpKfC/I5vlI+szxZr/JQPg6wPo7reaiQ72qPToPdYnZcVYQokCUXyI9UIstJXhw4oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020169
X-Proofpoint-GUID: T8ccRozxHSSMXaP2DRhnzWn2bx3eekmv
X-Proofpoint-ORIG-GUID: T8ccRozxHSSMXaP2DRhnzWn2bx3eekmv
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/24/2024 2:24 PM, Peter Xu wrote:
> On Tue, Dec 24, 2024 at 08:17:00AM -0800, Steve Sistare wrote:
>> Add the cpr-transfer migration mode, which allows the user to transfer
>> a guest to a new QEMU instance on the same host with minimal guest pause
>> time, by preserving guest RAM in place, albeit with new virtual addresses
>> in new QEMU, and by preserving device file descriptors.  Pages that were
>> locked in memory for DMA in old QEMU remain locked in new QEMU, because the
>> descriptor of the device that locked them remains open.
>>
>> cpr-transfer preserves memory and devices descriptors by sending them to
>> new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
>> be sent over the normal migration channel, because devices and backends
>> are created prior to reading the channel, so this mode sends CPR state
>> over a second "cpr" migration channel.  New QEMU reads the cpr channel
>> prior to creating devices or backends.  The user specifies the cpr channel
>> in the channel arguments on the outgoing side, and in a second -incoming
>> command-line parameter on the incoming side.
>>
>> The user must start old QEMU with the the '-machine aux-ram-share=on' option,
>> which allows anonymous memory to be transferred in place to the new process
>> by transferring a memory descriptor for each ram block.  Memory-backend
>> objects must have the share=on attribute, but memory-backend-epc is not
>> supported.
>>
>> The user starts new QEMU on the same host as old QEMU, with command-line
>> arguments to create the same machine, plus the -incoming option for the
>> main migration channel, like normal live migration.  In addition, the user
>> adds a second -incoming option with channel type "cpr".  The CPR channel
>> address must be a type, such as unix socket, that supports SCM_RIGHTS.
>>
>> To initiate CPR, the user issues a migrate command to old QEMU, adding
>> a second migration channel of type "cpr" in the channels argument.
>> Old QEMU stops the VM, saves state to the migration channels, and enters
>> the postmigrate state.  New QEMU mmap's memory descriptors, and execution
>> resumes.
>>
>> The implementation splits qmp_migrate into start and finish functions.
>> Start sends CPR state to new QEMU, which responds by closing the CPR
>> channel.  Old QEMU detects the HUP then calls finish, which connects the
>> main migration channel.
>>
>> In summary, the usage is:
>>
>>    qemu-system-$arch -machine aux-ram-share=on ...
>>
>>    start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
>>
>>    Issue commands to old QEMU:
>>      migrate_set_parameter mode cpr-transfer
>>
>>      {"execute": "migrate", ...
>>          {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Feel free to take:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> I still have a few trivial comments.
> 
> [...]
> 
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index 87bcfdb..584b0b9 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -45,7 +45,7 @@ static const VMStateDescription vmstate_cpr_fd = {
>>           VMSTATE_UINT32(namelen, CprFd),
>>           VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
>>           VMSTATE_INT32(id, CprFd),
> 
> Could you remind me again on when id!=0 will start to be used?

Each of vfio, iommufd, chardev, and tap will use id != 0.

>> -        VMSTATE_INT32(fd, CprFd),
>> +        VMSTATE_FD(fd, CprFd),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
> 
> [...]
> 
>> @@ -320,6 +328,7 @@ void migration_cancel(const Error *error)
>>           qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
>>       }
>>       migrate_fd_cancel(current_migration);
>> +    migrate_hup_delete(current_migration);
> 
> migrate_fd_cancel() has one of such, not sure whether it's needed here.

Agreed, I will delete it here.

- Steve


