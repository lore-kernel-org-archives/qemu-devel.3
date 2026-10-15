Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2565CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHSDZ-0004zQ-AQ; Thu, 15 Oct 2026 16:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xHSDW-0004yJ-FM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:38:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xHSDU-0006JR-9b
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:38:22 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FJBxk03076931; Thu, 15 Oct 2026 20:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=1dmkG6ZDizZbkB65Oh7hlkXHQEjdL/qIj3ZTAwUmWIY=; b=
 JO52XaqRlAzLqTl8XZRHg3Jq1uafL8LFUaD4mhjJ7OzgEcLWi50sfHomRtfFOx51
 GkVKT2XUILoyQwwOKU4m7mvKLgkxm4ghUIRAlI1sUH1DWC7l1X5V4TBMyjjyhN+J
 AV41QdqS2deV4KGJ1xaBgLHvrf3cf9u+akdRLuik1Q4vzCPupWNv5ko6BEPG1bSR
 Lzz7w/NkRpw9N0Oc6lLjGAOAZ/9q52udUAZJQ5panN8a1p/hDqeBxxzKH+b5RSli
 kmwtuKmidEfc5im3onnFjdSebUIHrvDJNkHEJsH7ZgD97T/CRrqrOITgoe4iNBR6
 yvgZykT7btL8U+1uy/zRbg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dde10wk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2026 20:38:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69FKaNKU036468; Thu, 15 Oct 2026 20:38:08 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btcn0vg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2026 20:38:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ed+v+mt0/nzkVXKV1BYKJUlyakTTkkVl28uMmvMdrmBl/wl1f1ynQjDFDsG9pXikDW8WQc/VRJB5bKbn04ZuRBN3vFaLGSArtCUgc5vFoRwnAzXNClocxB5QFijof4LfZYfj3GyEOBtaQtb4dD7ZivjLfKBfZO7NCKFOOP574aIkc4LEfma1Abwe2krC8JcxTIisKaElb9S54avD2yYDQejahJrekEu3+As+YAweli0AHVshYcib4SBmN6H3E2Iwr8kiVfgX6laX7pN9U89byQ0pbG86WUKd0c3mD3KllLVzoNEpLAp1GF/HUtFba0Ccw+pw28bRQRAN+jhD5K1+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dmkG6ZDizZbkB65Oh7hlkXHQEjdL/qIj3ZTAwUmWIY=;
 b=ubMgbGULPdLqillhQ5M5EXzhzKvR1IEDy1oY+qv0N36YxuttZZLZI5P0OSgJFDPa1fbpeHuxYVGJJhll9ASevEhoN1vkOraiEi0Z0RBbGd1xXVWM390Bqd+Xujp7QmPXKynAWH0vtZFEon3ctwJAjbl/tOVM+y5t9Rll9WkO7800CRw0IvJlcN+n6T4GPuBdxNjpQXLjb3y+oa8CTOi4K2XcsvFxy19gVu0+RC4UcVErUYFPcfq03NaCqFEHscNG/8Qhp38ytkXh2Fi4UiIoHhvRfVolN/pSHrf+Ra+dtPO5v3NVUqeOfBUwvBYq2wSAI4z1iQs2xjXI9cA4yFWDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dmkG6ZDizZbkB65Oh7hlkXHQEjdL/qIj3ZTAwUmWIY=;
 b=LKvwne4xDemFBiUYB51lHMtaCyWvhyRR5SCaF16LuJPyan+3shJL81lta5pfHUPnA6TNR/S3c4SDlBOahZ/fd2vj/SBbtyTTYBylB3qJz0CX8Ez+XWG1BAs/Xt59ynin4G7xjN3wfAUUU0dG0d1It2v64SSwXs7Ivvhinn8O8vc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB5520.namprd10.prod.outlook.com (2603:10b6:a03:3fe::12)
 by IA0PR10MB7642.namprd10.prod.outlook.com (2603:10b6:208:481::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.9; Thu, 15 Oct
 2026 20:38:00 +0000
Received: from SJ0PR10MB5520.namprd10.prod.outlook.com
 ([fe80::8fba:9b1d:17df:f916]) by SJ0PR10MB5520.namprd10.prod.outlook.com
 ([fe80::8fba:9b1d:17df:f916%5]) with mapi id 15.21.0546.006; Thu, 15 Oct 2026
 20:38:00 +0000
Message-ID: <c00b8d21-ba36-4a2a-ad22-56ec1ffc2250@oracle.com>
Date: Thu, 15 Oct 2026 13:37:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] qapi/migration: add cpr-luo migration mode
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, david@kernel.org, imammedo@redhat.com,
 maciej.szmigiero@oracle.com, peterx@redhat.com, farosas@suse.de,
 mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, alex@shazbot.org, clg@redhat.com,
 yi.l.liu@intel.com, eric.auger@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
 <20261012235727.398133-2-dongli.zhang@oracle.com>
 <878q40eni8.fsf@pond.sub.org>
 <4b7de1ba-f063-43b9-9dd2-64d1187e488f@oracle.com>
 <87qzhrblil.fsf@pond.sub.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <87qzhrblil.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:806:130::16) To SJ0PR10MB5520.namprd10.prod.outlook.com
 (2603:10b6:a03:3fe::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5520:EE_|IA0PR10MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 696a7b8b-0466-4fbe-2ad2-08df2afc33ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|23010399003|56012099006|4143699003|261009223027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: TczFI8R/FXIM7/1SXhfMfzjMqezqOH3E1ob2OWRj4Ms3vEET73KYA+2jcdrAWZ+hkqKFCqZCLwpnMV+DaBQeqL5OOAE6f6rtf21tp2Sp2Ukgf8YqSAeaZLFF+Ozpexc2Gabe5YFKw1V6Uf8I/HdqFsRQF0DrgcyVZQZzKk4VUtQDaTsLIsC9b/YH9wCvivC53CCuA+ep2Ossj2z4n7BdG1skI2irAY9shKEEwVTnVhbVSU9JaK+2/pxjy/I9XuT/mPqWGe2mAR42X7ORTUrBvsOwvtyrEQrXmS++8OZpRtv0w+VHIEwCEVEY05++7XHacDLvMOeG7zke+fMrGVYLd+LFICYF3dIfW8eOLKKGaDdOdJEplMpo+gitHabsrj8VdTd+sYS0TPJ1GX8uS1omiiZ32cesCfFJoKf4iUyYlVF407TP/QWVyLhmxPBA1zbSG5CoFgeA0FwKpoVLZky7+/kD95S1xRgJaRVYRB6tORheMaFymduVe/FxI7tveRi4lPZNXqYABQ8JE8bkjjm+p+o2iKV4nwhNiiSVpNiNlXv8Q3lTNdfGNo67BYFYKxHjSLmOWaa+XhBiREB5J9/+bD8CkGj2Fc8scX6oKud5/fZgu7Ll8QVWNAAN2FCcceoR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5520.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(56012099006)(4143699003)(261009223027099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW05ZlFqRjVmOStvdUl5M2NXVkhYY2JjbHQ2bVpxVUFjWTY5NGVXZ2lFN3ZZ?=
 =?utf-8?B?azBoMk5BQ2tZWUwvZEhKZVNnbFVXZE0ybzNKTFBGVm9aTTZsQjRudGUzeDN4?=
 =?utf-8?B?a3dOcGx0TmF0SlpCWFdLaUo5RWYvZWM1SFNpcVdxQkhtUWRKVTcrTHVaWGVT?=
 =?utf-8?B?blZaZGRFNkdyYmw1cjVDdVRPSnM5S1pobklnMnBzaHlzRVZvS0FTWWM3K0Iz?=
 =?utf-8?B?RFNNbmNjaHBOck5SdlBEemZWbE5kRzFzU1AwbzZLTmdJQkQ3Y0JLakFWTWpj?=
 =?utf-8?B?NVU1SEVldFVtTWlsNEE0bXVXM0Y3M2lNVGhTVnpSekhKWTJrakJLMUtBVEti?=
 =?utf-8?B?NWlmRlFiQkx3ZmhXRmlVQnJYNktRY0c3TFVFUFVaSU10VjlHYlp4VGRGb0ZV?=
 =?utf-8?B?MmFDaVlhQk5xbG8rM2s1QWEyak5EUUIrOXkwSlNHN0ZEUXE4VE00QVN0SW0y?=
 =?utf-8?B?SCtoSkFNZGtBTHRpdVVZTW5QQlo5Mys0aEgwN1JtYU1KQzRxWVFxUUpXcU5v?=
 =?utf-8?B?NDZBcDlwd3J5a1ZESnArMDVIUTk2aWNXYnhKUmVDNmNnVjM5cXZJS3pxeUdK?=
 =?utf-8?B?UXVodDJIZGkyQ1BVK25rdlJWWUhRRWNXT0pENXB6cmU2VmFEK3o5eWpnUVdr?=
 =?utf-8?B?QlNFRkl0di9LRXBtRXJJRlJtWDlKSFQ0VFlYQStjdkJEQU8wUUJheVFPRWRQ?=
 =?utf-8?B?QmozOU1Id1pCU0RvSHhGZDA4ZGNETFI2Tlh6VElhNDRYQjh2Ly9aQkkxcFlB?=
 =?utf-8?B?R2RwU2JUSUptNk4wb0t3NlhsOHpzTGh3UHhZQXFSVHRCcUJkWjZBdHU4cFBz?=
 =?utf-8?B?Y0lMWHg5OER2VE1EMlpmWVZZQ1FrWitFNTVHbnFqRWxBRXhGUWttY2VROHBD?=
 =?utf-8?B?clNIUnEzUkVMR2ZObC8waTY1dURNNDFSOW1wYzlXbHliTFFnamlEYXBtLzFP?=
 =?utf-8?B?NEJzSFpSUGp0WlZvNitlNzFKS3BSWWdPa3hoY0tpQTMzcUQ3RXh6SzhnemtJ?=
 =?utf-8?B?K1FDeUxQVWduc1pFVTdidGVSUGFKWnAzOHRhajU4bkpwYnBLR3VKSy9ZQ0pz?=
 =?utf-8?B?TWRCQ1lCYS9rNGpRV1VmRWFhWG0wMXdha3g3elZJQ3BwZWI2UGkxK1BrbWJT?=
 =?utf-8?B?aEFlSmtwekphZ09WWnQwMGN3UGhVZ2xrVEhRbm53cnRiT1J1WVhSY25wKzBy?=
 =?utf-8?B?dzBvZ1c1YXVIVE0rUGZFK3F1eHA1Zm5uWjlPZENRaXRib3ExTldUbTJySENE?=
 =?utf-8?B?TjUrWHlJdUFTK2M1U2dFMjhPd1FhRWlFQTRvL3AydWpBT05GNWtqb0JCOVhJ?=
 =?utf-8?B?M1RjQjc3WHlaalFvd3JmOVZOTEU0WGVya3VhRjNGVjhjTysrL3Q0YThLVDRq?=
 =?utf-8?B?eHVramk5TTFZUlhwSHpGVzNQeG5FTkk3U0RQdThZZUh0d1lWbEN2cGE2TG9K?=
 =?utf-8?B?MGVmVjQ1YU82OUlUVGxrRkxINUNiNmtnblhKTHVNajVsaG1waFRPQyttOUYz?=
 =?utf-8?B?SFRUNkZJUjJSbzcva0wrV3lGZDk3ckUreG9DZ0Vsb0MzdjFFNnVscEZNQk5P?=
 =?utf-8?B?U3dLMUFyTTZrVmtLeDhXc1lQMFhqYmcrczlYQmxLUUk1OHg1aFBLZDBuWnI1?=
 =?utf-8?B?NUtVZENNRkVWd3BoandnaDBxcTBmT3lyTlNLYldsOTNHUmNlSjNHa08rY2c2?=
 =?utf-8?B?aXN0dE4zSmE0QVZHWllPbXU2cW1McFlqVkh4UUxHRkFoRVRzb1VyZThibXNl?=
 =?utf-8?B?Z1daWERkazdZaS9aMXZueUx6QUVjcVdNNzIzSW9CakZqRithYUI2U3dJRTFD?=
 =?utf-8?B?K0ZxVnB3dk1mT0dpbkNxYU1jdlZqdm03VkRueEVKZ1B2dlBDRUFPeGE5dVg3?=
 =?utf-8?B?aE02aUZTOVBlcklXVkJHajZYQ0x5UXRrVEV2bk1TS1Y3NWVJM3FBTXRnVmZZ?=
 =?utf-8?B?NzBKVHFHank5Q2pqNEtYeGQreW0vOW1UYUdkVkRmcHJzbFdkSUtMU1ZiQTVU?=
 =?utf-8?B?T0pzWGhOdUpianE3bWg3anZWWnRkRS9BWjFWaGFTV1oyaE9hQVdZWFhHanRQ?=
 =?utf-8?B?TWFSL0JaZHVBeUxwSGx2NGc0Sk1uZkxicHU4blB3emRQUVd5TFRlcXk5Wm1Y?=
 =?utf-8?B?Um8rVkpxaWltTXNQVzdQV1k3OVY0Y3J1WUdrK01NRHdNQ2puZ1g2RFBCc3E3?=
 =?utf-8?B?a25rZWRNZi9pTHVsLzljeFU2cVd2dWplTXdldzBsTnN3cHIyUm1GTjhuTm52?=
 =?utf-8?B?Tmx1ZFlYSFlVcTRQNk1pUVBXQjZoc0IzT3Yrd3R2M1BIRW91SHV1M1dhNElN?=
 =?utf-8?B?Z1N4VEhwRDFaOE1WMmljakhCU3AyRTQzZ245U0dtb3FMQy9XSWN5dz09?=
X-Exchange-RoutingPolicyChecked: Gu8YN9QgVdoIJzESIBn52oihuCzmvCO5tvLTvWNa3fNB01NWVOsOjqm4YTRORcryhAIZ87hF8xQqfPfeyn0TpVno+aSgkB6yvfNOiL7iEr0Fkk4lPHIAlCf4P1NfA8MHbplQNB6O5ELS+Ntsbw7IJncDa08ErCN0vzyMLB1mnCz5AmLJGjaVhSK3xIdNGF4otKDPnU+qR3hRpGdm2XnWZ1kVhVsr51ZgZGlbTO2FYYaQMbt4AzvFFmbDfQgjO8+cQxVaAUtTmpQK9igWdI3QBCDfweKWJprPHJz3iBRpJ0gnli2g4C+6NaokgwxbNcx4K/jirrlM4IOk8g+Gzz+KFQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VSD3tBJ1Sz1CcmOT3BF6pHqYEw63dmkTXcIFWvyk1DD+w6L/qtBlk3K6LRMu5RVimAfQ4KV5C1H/HB5ZhYjBQQ/MCQ02GuYq3TivBW/iymBj1Ft0BwiWskEMQgO3uRsvCc4ze3krdq8Au5q/Yd5qfLAfuz66MYaLtXSGihh/eYc6yv/SJTA4Za0VTBZXcnDvHyIpcXDpitMRl2wK3XtGGaloHge/OiacQlNvD4qKOFlWJlAwoEpzJTrmyzXw+f8AjniV/y8EsBjpfvb4zdronikCKlUhDjrKqv/MWb0D5sI0qwGS31q0BhZOveKkEv5un+t7GiTsU/CTsJwUbUB3qfkZUQVmK8BkawQMHZRjPbK4iDeQ6GCeTRGU8+3lDddqPMEU5mCu8kdjrrhkIiSiEWAU3nHJ6qNkIVw6z0y1vfC7ZNEmXIUL4BSzJBnHkRrtnf1c94L+wjojg2AmeuYbOVblr0NQbCBDu7yOEBq0f4pQdUc08WuoFfr8OoFkVb9b6wHoPAYOiBogEi6apeD3In2PQTBXHWw624WoVSeYWeIbY7YnoTvyrD1cl3+NMkJtuhGlWm2oR0ZIhfV1XDGSzk1pjNJocMbpyAUdKODbgvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696a7b8b-0466-4fbe-2ad2-08df2afc33ff
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5520.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 20:38:00.4029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YEB5tSrH1mFYZRNJDdZxy83TVpF0bv9ZcZ/YfzwU1DheineOhfiCc5AVKTsg0lTTuF22MiPznXztUAFgPRPhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610150082
X-Proofpoint-GUID: Oo3DXNKOn9hfPQL52lIQd_aJMs79GIh8
X-Proofpoint-ORIG-GUID: Oo3DXNKOn9hfPQL52lIQd_aJMs79GIh8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4MiBTYWx0ZWRfXxhEkA9rtg2kB
 dMBrlbqrHNVCtrBHG6zkAU3d3cRoEUFtK9cJw3bqtOLuCp508HgvdaNF6cXtp9DXZy8lHyEtcPC
 MB7DHhpj8dYNWXNPt6nD4/Oo03yAyE3SuRfHMfXQG2SLivBtxoC4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4MiBTYWx0ZWRfX1krlJAV5B+tX
 GaWU/0LWxOKeYYPUxSSICruJF4I/iqaW0jk+8VzJLT1bGXUhteVft/8olS5KaLoxib8Jog1IdYD
 yZKktKwe+Mo1/ANEZYnAQmvfvVvFgW+7turC3pNpsQMzaOg0TaZ4Vc/Ijw3yQl3qPHzdawcA476
 WBZF7dXht40LnQeJQw559/9CVtzPD4Cta05Fkg2huSjXwH+vncQnNVIqPwuRuVsu4+GPixdD/rq
 fB6uCx+HOFDTpN4023pmtkxmWbSlG+4HktDtS259dwRu/ItzqnQys1wwQ/xRoi/wwd38BYev+Ns
 j8vhjJ/BV3cVybdwLAEiLMxQfG71qbO5FqZG9Ea/3kz2RZeMxbDWwMuLsvBatjBbTrlSzELxPj2
 Z4mJxaf7rtxtRzUj2uV8mJnJcsc01nDZZE46fouZ0wup8f8MPx47BwGQm2oXZlyWQ5l4V1Ivb1d
 EkW+E70Qnbsx8iUYApg==
X-Authority-Analysis: v=2.4 cv=J/8/fwnS c=1 sm=1 tr=0 ts=6ad139b1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=ID6ng7r3AAAA:8
 a=yPCof4ZbAAAA:8 a=QNUBWj_vd-BzPZbmCEoA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=WmVTiCyuxqgg3mnwYu6p:22 a=AkheI1RvQwOzcTXhi5f4:22
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On Wed, Oct 14, 2026 10:06:26PM -0700, Markus Armbruster wrote:
> Dongli Zhang <dongli.zhang@oracle.com> writes:
> 
>> On Wed, Oct 14, 2026 12:42:55AM -0700, Markus Armbruster wrote:
>>> Dongli Zhang <dongli.zhang@oracle.com> writes:
>>> 
>>>> Add the cpr-luo migration mode for CPR through the Linux Live Update
>>>> Orchestrator (LUO). Subsequent changes preserve CPR state and RAMBlock
>>>> backing file descriptors in an LUO session across a host kernel update.
>>>>
>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>> ---
>>>>  qapi/migration.json | 11 ++++++++++-
>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index 889a9b89c2..ab117c3897 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -712,9 +712,18 @@
>>>>  #     with the '-machine aux-ram-share=on' option.
>>>>  #
>>>>  #     (since 10.2)
>>>> +#
>>>> +# @cpr-luo: A CPR mode that preserves guest RAM backing file
>>>> +#     descriptors and CPR state through the Linux Live Update
>>>> +#     Orchestrator (LUO) across a host kernel update.
>>>> +#
>>>> +#     This mode requires Linux with LUO support.
>>> 
>>> Pardon my ignorant question: host or guest kernel?
>>> 
>> Host KVM kernel.
> 
> Suggest something like "This mode requires Linux with LUO support on the
> host", or "This mode requires the host to run Linux with LUO support".

Thank you very much!

> 
>> cpr-luo is more similar to cpr-exec (assuming VFIO is not involved).
>>
>> cpr-exec (same process across exec):
>>
>> - RAMBlock fds are preserved across exec(). The metadata is transferred to the
>> target via a memfd passed through an environment variable.
>> - The device state (i.e., virtio) is transferred through the main stream (i.e.,
>> a file).
>>
>> cpr-transfer (two processes):
>>
>> - RAMBlock fds are preserved and transferred to the target QEMU via a UNIX
>> domain socket.
>> - The device state (i.e., virtio) is transferred through the main stream (i.e.,
>> local TCP).
>>
>> cpr-reboot (across reboot):
>>
>> - The RAMBlock is always reconstructed. It is just a matter of whether to
>> save/load the memory data, depending on whether x-ignore-shared is enabled.
>> - The vmstate (i.e., virtio) is transferred through the main stream (i.e., a file).
>>
>> New cpr-luo (across kexec/LUO/KHO):
>>
>> - RAMBlock fds are preserved and transferred across kexec to the target QEMU via
>> LUO/KHO, identified by a LUO session and tokens.
>> - The device state (i.e., virtio) is transferred through the main stream (i.e.,
>> a file).
> 
> Is this covered in the documentation?

The existing doc is already in the QEMU source code and explains the usage and
basic mechanism.

https://www.qemu.org/docs/master/devel/migration/CPR.html

I just prefer to summarize it in my own way, as in my previous email, as that
helps me compare different modes. I have added cpr-luo to the doc in patch 0021.

Thank you very much!

Dongli Zhang

