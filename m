Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A64FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmdm-00075F-Eu; Wed, 07 Aug 2024 15:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sbmdk-00074A-5I
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 15:48:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sbmdh-0001Mm-0d
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 15:48:07 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477IteBX011708;
 Wed, 7 Aug 2024 19:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=iitJFWZ6Cz1ulRg/QX97n991CUG423qa2rhdAhKsJyI=; b=
 nhuO6SIhD4p6VLdfRlxZz30XQXWCD0HvEvsR3HoP465BwDTmC1TeG2HmuMRIiJRu
 SH71BX3PqgN7n9QY9gTiBl0b9Oxrr1Hn51m7nZWobtb3ogVtahhdNFRbiKwHiHiH
 wW9sJpoY2+AezSDjxb9J/NPOXh0wzpMzLSE4qXzbDAak9LY5kTG/MWwqVQvCqYIx
 rnyng0RUBJQHt3DvUi4nLwhOa12GKxJBmw8zyzBPJ4+SDN9u6+tl8/8WyWaCP5gO
 QaQBTKlN7kbwVME79f75PWFZpWF/BGlmLKHNbsNgXBRqPz19BtrL7+IAmoj2/Br3
 iaAMwFYooM/0B7g8i4LZVQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfarff2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Aug 2024 19:47:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 477J53hq018361; Wed, 7 Aug 2024 19:47:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40sb0adx6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Aug 2024 19:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzO7hJIFL2voQ1/rV53RQuPmwkVymL6Y4v9xO7MnZ4/gpXo5Vn+IhNaDmf+RwC4os7CG/tTdDnWESMPc8d1Cf2F4EFXljzD84t5PgspQ3lWwgWrl6mT9NOz6voBec9NbhwGYIaaIPK3/lFoYmOJsKY05kQr81FIkfL7Pdu9dBT5K/9W91FquZAI4f1i9SeOvn0iAaNbnCzE33S74QSXIa6kbxqO7vV7gpAohJy7MJPfcgKVJzPQB5WSqWsKWYVfOjAT+7LtLzLKP1onWFKDrXeCmzsMKaBOCP3IICzuWjFk+odQeDH3fe9HsCUgBm+0Gy2X/b/F6NtZ8YyzZKmDdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iitJFWZ6Cz1ulRg/QX97n991CUG423qa2rhdAhKsJyI=;
 b=O8MXDBO2qewmhFcGzh3WPig29zFaCEBYTUk3bphk4yN0Rjs5/HCCa/DeN/aUvg7suFCIALxlYGHQZTapjBh42bS9wE/4XfubQRB84HtQSGWzpSymIMO81cwuaCTxF0nfJ0FjgBcjw0jhftuk5JrYvg4Ly/2GwA37G57F6YucmrLbX2NwY92j7/vMqz8MKe7PmnJ14XEOKxIos7lU6UWhOmxJO9xphTQPFyP1ZgmOsXhgXSgfUvdcAzJ+AfZItoki1ejFWByAgcToTYjFj0znLp8WhVAuRjP0A5DVkkq8YgBwMyqFHbBJCqdG0o35piOO9iB4qvaAMyVoYKCNtesGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iitJFWZ6Cz1ulRg/QX97n991CUG423qa2rhdAhKsJyI=;
 b=T4JIXNTyeWVMvNZVKEnrMoHdmuCRSo/dadInyjqvL96uLD1oJ5/NKT+xGAReTToC2uwDSF8XJzaSumwZx4KUoAdWOLCaYDkPrGFsW15RofPePWk4gQ7e2LEpVGzeIaNMFhlYlz0lejUW/ZWlwrHHa7a1jNSrMhRuBpk3yLvjODM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH0PR10MB7533.namprd10.prod.outlook.com (2603:10b6:610:183::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 19:47:53 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 19:47:53 +0000
Message-ID: <ecbee102-262c-47e8-9da6-14e44f85f032@oracle.com>
Date: Wed, 7 Aug 2024 15:47:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n> <4f6200fa-c052-4295-b71a-c6deca11db9f@oracle.com>
 <Zq-oDMMYTktnQUIA@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zq-oDMMYTktnQUIA@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::15) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH0PR10MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 1899f031-863e-4d04-9d39-08dcb719d376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3RZRWJiRUhVWUYzUGlJZjRtWisvbnovaUw2aXVyU29MZGE1WkFvcVY4N2o5?=
 =?utf-8?B?ZGRaMHVDTWN1Q0J1ZW04U3FrQ3dQNDRramh2czJWR1lIT2diU1FwdE1XVHdh?=
 =?utf-8?B?TjJ2UU5ZTXZySllDQkhIVnQwRjdTWXI3OVltZFJwNXNyNHZVbENrMWxuMC9E?=
 =?utf-8?B?R0dOeitKSFQ1UXJSRXUrYThSMUhQdW1mbmYzOElPYTZXSnR2MG9tR0hFOHhT?=
 =?utf-8?B?M1lKcFl4ZWFhYmJUR3ZoQmIrN3JhU2g5OC9zQVF6M0NUNnFWNjRYWWdBUUVi?=
 =?utf-8?B?c20rRlRrcTlHcG9NTXpMZXBFbktHbVJlRWE2cjdBT29pek5WWVBNcXNGSUh4?=
 =?utf-8?B?ekg2QVRsY3gwWEJEU1VmcVZnRDFhUmIvVlAyTlJjdmFDOE1nZ1RYbG5pRyt1?=
 =?utf-8?B?Rm1YaytpUmdDWHVldnhiMDFzRDdYa1VqMkxaTVBzL1o3Und1L3NKOXdSazBJ?=
 =?utf-8?B?eVNoVlQ5SkVYcEZJSllndVhhUnpOS0hBNjZ3R0lwUndsVE16MWxKVXJJQ2JX?=
 =?utf-8?B?bXRBWEMzNVdhMkpQQnc2d2dLTjFXN3ZHY29iTnRUWXpxbmtjU0l6Z3hISUND?=
 =?utf-8?B?Y08zRklha0FuZHVOZlN1RXB6Tll0cVRwYjE2TktsTXQ0NlRFMjhsSE1XdE50?=
 =?utf-8?B?SEZubXpsdTZNQ0JKY2lYbzlZTDJYNiszc0dqMzZQVk8xb0lFTXNPMkZSSGFo?=
 =?utf-8?B?SnRWVXV0UWUwMkFlbVlVRmIyZTNCeWVFbGZVckMvTk9TTjZvM2hNMk0yRG95?=
 =?utf-8?B?U0ROYWlHUWJ1OWdVcDJXallDZmdjRGpBbzJEcTVQK0UyOThBSGVRdEpxcDVy?=
 =?utf-8?B?S3RrYnYzbG1EUlpFTjd2d0M3cE5YMUpmaUtLOTJEN1g2bEZTRTVmUkZJZ3F0?=
 =?utf-8?B?VHpiNXhSNFhCSmxleDZ2RDROWkphZ0d5R2hpNjNPWW5lNUdVZEZSYWJXdFBk?=
 =?utf-8?B?aHlRdktnazNIT1FOamluZlUyL2F1SEMzYzh1ODlQblFmNGxsci9SOGJ1Ky9x?=
 =?utf-8?B?d1JXSGRLWTZrK0kyYmpDa1pvNEVpa0RpU0tPWHBRVHd6YUFrNVNIL29JclNN?=
 =?utf-8?B?Y09RUlNDZ2hEdHRnZW5aVTJrdm8vQkZhSk1LMjlKVHhPcC84R1ZvMUc3UUoz?=
 =?utf-8?B?ZkdEVWkrQkNOUjh3Y29UcE9yZFJ3ekk5ejZ5RS9saGV5K2s2MTN6Y09Wc0sv?=
 =?utf-8?B?Q3cza3h3SEcrM3ZYa09pNUFWNHQ3SWoxZUlFM00vaVhLK2pGeGh3RHFVTzk4?=
 =?utf-8?B?YXBLaVBDV3FCRVRJb296M3JqQzFvUWtDQlVBV0ptcHViZklmS21OTW1JZ1Ni?=
 =?utf-8?B?RkF3UUk5SGZPbFBCc3VybDVIamxWeVBxZzhEdEQzZU1VUEdVTSt4YWpydHlR?=
 =?utf-8?B?clJQNTA2MkRSNjB5bjhCa0owMWpEazNSelZJMjYvYkpEL2hRN2pWSTJvRlFz?=
 =?utf-8?B?L05uN3NtRmdVVHk1S0hNQ2IvSTdVNjhxYjROcEFnSWJheTFFOCtmVy9VNzZL?=
 =?utf-8?B?TnR1OVpYN2ZSbm5NSHlKajFBd0xZR1pBejhYTjloVkxjZVRPektDRW00U2RO?=
 =?utf-8?B?bkJHbWhISzdVY00zTmZFYVZKRTlIZDlYKyt4a3FkMW9vOXg0R2JKTnZiRDhT?=
 =?utf-8?B?SXhlVEZ6cFlGcVVFZ2NvazFrUGFnTjV5dHFXMEt3VGgzQXhwSyt4RXg3TVB4?=
 =?utf-8?B?Q29yMktHMjhQYUZsNnFVWUtvWUIwblpjWU1jdmFSUWFaaDNQRTRzejFxVEdR?=
 =?utf-8?Q?0SJM98ym7LSrxQKG9w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjlYMzNDaFdtZGR2c2tGOFFpaWZsUnpyVTdtZTgvU0tFVG9TR1B3L2FnWkFx?=
 =?utf-8?B?d3dpRkpIdFM4Q0lZRlFqQ3dTUW1HYzlKQzkwNEM2aWpOZHd3MER1WmlkOVhQ?=
 =?utf-8?B?cnlKNHV0eWJDU21CeXBlTEJPdEdtYnYveVZVRmp4QVFBSHpRVEhxUUE2dEly?=
 =?utf-8?B?VVhuVi9mN00ySng3VWVWQUlLVDM0OER3ZXc5dEg3OEhLOS9ZUjEybTJMOVd0?=
 =?utf-8?B?VUFXVlgvTFVOSDRaQzJYRFRickVDRVVBVHhTWkdsdDRubHFSRENxTjgxVjJH?=
 =?utf-8?B?eVc0bnV1MnBaQkkxa25Ecy9raW1BVHdkOXJsaW52NHhOTzI3aFRJNDAvNk9C?=
 =?utf-8?B?WnEydzhvTDhmSjM2UStYbExQeXExczJkSTI1YjJjSTRkN0lQODlyMkNsaTh3?=
 =?utf-8?B?WC9mUUovM2VXZ1RMSGpXUFpvRFVJTzZ3MVNwNnZmS1RCZ0RpTlpDa3lVTU5Z?=
 =?utf-8?B?QnBlY2JLN1JyZlRqeXJsbHlubFBYUGcvNmNSRTR6bWZldUx6dXFUQjFTalFp?=
 =?utf-8?B?QVNESmdhNzc1NUZpM1VwSFRpTnZnUnRjalZpTWdLSWovUkZMcytNNSt1SDVK?=
 =?utf-8?B?dEJHZ3J3VHo2VlhuYnlqNytPNEJ4NTdvWW1TRENPaTV4eEhPcmovM0U4ZjN5?=
 =?utf-8?B?dWg2ejE4NnhycVg0SzBzTVh4cWhiNDNyQlhJODBIa1FJTExEeGFkbmhwTlJ4?=
 =?utf-8?B?T1BRODhOUmRIdjlpd0x4V3VrcWlZQ21kTy9qNjFHTXpYK0U0U3lObDZDc05r?=
 =?utf-8?B?MVBCMU9MMU16ZHBvQWJsN0tsSDhuSlFMU2RJMmJ4TnA4RXZpNkZsVGhMVDAy?=
 =?utf-8?B?d285ZjE3bTN0bXJkRW5YdzIzbkludkVJUk1lTFZNdnM0dENCazVWVEZhV2N4?=
 =?utf-8?B?SlZ6WHk3MXZrb0t5MjlhK0FPcmZScEFad2FoUVZabldLOGdZZ3VmZldlcGZs?=
 =?utf-8?B?QWdpajlxRDdNZFZSaTRFaFNEeldUbGxOWWhjbjNiaDNtS29adnpDeGRmRnRx?=
 =?utf-8?B?OEtyWEt1L0RCTGpsem0yUDFIeGRqRWVKaFZ3MzJNUVh6eFhBUkV3a25BL25x?=
 =?utf-8?B?NmtVdWRrK2czc2MzQ3JFT293a09IY3lVRkNra21lVmJCN0hIcWZpeTVaT2xt?=
 =?utf-8?B?UDg3UFlETmFjaHR6N2I0K2ViWDhUS3lDSm54eG1LWG5Rbnl3UGkwQTY5MHZp?=
 =?utf-8?B?ZE1SejBNaFhoM05hdGRDSmhiRUkrSnFFSi84UjFEVy80aUtUREZ2Uis5ZU9V?=
 =?utf-8?B?STQxSGFqOTZPSThZcW5rTVlqcDE0MVpIY3Z3akpKektPN0xhdjNJVzAvUzhw?=
 =?utf-8?B?TEU1dFZIdXhTSFA1MzFRek4vcmFBK1ZCaHFucjZrWk1JTXFjelJVR21saUdm?=
 =?utf-8?B?QWRiRUlZZnpnYk4xOHJ3YnoxRFo4Sm9ac3pNMmVQeXFXTnRkTENQOWxZU01E?=
 =?utf-8?B?ZW1UTFd5SU93T0tPVit4RnJvT2RGbldJQnBXRnRZRmZaT2RWeGNGUEQzRUxX?=
 =?utf-8?B?aE8wM0xtVWs4bzA2YVFYSEo3SEo5ZStxRmJJYm9jVktWQjA0YkNHaXVMam1l?=
 =?utf-8?B?YVNxV1l4Vjl4bHo2YXMwR3k3TktuQi9jWmdKUXB0czF3anM4eXNBTDMrc1Rm?=
 =?utf-8?B?TmhSUjlkSFhVVUUxV2Y3NFcya2F1UUY3NmdsdHhkd0ZJSmFRaW55Q01xMnZU?=
 =?utf-8?B?OC9jVE1uaEw1WHNvdDhwSE5XeGtUeXBCUnNyZ0NITDJYc1BSK3pGNlVtbTIv?=
 =?utf-8?B?SWpadXdORGhGREhHMW9iK1h3clVWaFI0YXV3SExhMk1GM3QrbldHSEt5Y2di?=
 =?utf-8?B?eDRHZ2pMaTcwSVErZi9rTzUrSktXWDBaWVAzdi91Zm0rcTFCZEo0ZXhEeTRs?=
 =?utf-8?B?UEYyNmdJVTYyNnZMdXpvemJDV3ZLRElvVzRVelFDZEM0dzJBKzhocWdjdkxT?=
 =?utf-8?B?SER6QkVZbmlhd2N3NXBVZmRjdUlaR09oME1ka3R1Z21Od2JPV01NWGVtWklL?=
 =?utf-8?B?TVQ1SkRweXpjQ0d6T0pBOG1XQm1xWnVjVWVLeVJ6VWt6OXVNcTc4ck9iUmc4?=
 =?utf-8?B?aFBwWjUrZlpPL0hNUTFLL3ZOWEhlNjVKS0RhT0pnQXhkMTgxaEhuNnllUzkx?=
 =?utf-8?B?ejdQQm5RbDJLVFVmODFrWDVJeTZiRUpIcFhDMzBJUG1vRlBWdjBoODB0K09T?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SeE0zDfZq7Um9AWVy1RVCCvKCrkY2mATJVSavB4q2ai4Oao5ZxIvi8vW83kbOre0+taTVvv/gv/MNgqhURX3wr6EsfxJsOI39DzTUEcJNbSXE276pwQ1sZ8b23h2ZQdByQg+x+MzpwHDEoEhBr3PU8ZeeoNrMz/zKVbYvSLuFcdF8ziLEKwbffnRt3UGaY//t1swuZJsSD1nHmCNE/IdQZQSlnDkM35UsFajMVELvDZcz9LvwjZ3MGc0x6dHbHp8rtks6I7I39JG7y57sAgJZR2FefoZGAT+/FFp2f7KuiSqyFl8Eymt1OZLrRYCs4z9xgiUk8nG8xySpFVEWfMxZ9TMyGIacBad+CGrl3846Y+wYVaRWh/8kNFZuI5pJdbpnPgryPhOvdTj5gdS7nkminMikfv3UIRJcfxYxRDnuYRJ1KLRNqJ6g5EO9nuy7ckkloLze8BQ1wwQEvNMcjaBV9QBdiDw3cLeGi4JlO9mVu6VW0w7hY4pGqEzX8gKKPx+UK2c8e04UFsMMGS1rG4i3vQnqb5t48Hah1A2mx18jxi0VlE6pOYTG3+Mq6Yz7zz0LeqyMvMQkitYol1lUnezm1zeZjq+yFhVpYz3dEzXTFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1899f031-863e-4d04-9d39-08dcb719d376
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:47:53.1682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qt9j+fVF0l8DcKXGsoaq6w8pjmgIfUxhdkvbUmsVsxEhSFCHM6BcTM4iy+g3t/aZrhB7gWiEuXFJplVCXZXD92YQOeMIbXBjVt/24bUjeKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408070138
X-Proofpoint-GUID: p-_qjcAnaHrUxC_qAt6w1b-xYa36Yn6Y
X-Proofpoint-ORIG-GUID: p-_qjcAnaHrUxC_qAt6w1b-xYa36Yn6Y
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 8/4/2024 12:10 PM, Peter Xu wrote:
> On Sat, Jul 20, 2024 at 05:26:07PM -0400, Steven Sistare wrote:
>> On 7/18/2024 11:56 AM, Peter Xu wrote:
>>> Steve,
>>>
>>> On Sun, Jun 30, 2024 at 12:40:23PM -0700, Steve Sistare wrote:
>>>> What?
>>>
>>> Thanks for trying out with the cpr-transfer series.  I saw that that series
>>> missed most of the cc list here, so I'm attaching the link here:
>>>
>>> https://lore.kernel.org/r/1719776648-435073-1-git-send-email-steven.sistare@oracle.com
>>>
>>> I think most of my previous questions for exec() solution still are there,
>>> I'll try to summarize them all in this reply as much as I can.
>>>
>>>>
>>>> This patch series adds the live migration cpr-exec mode, which allows
>>>> the user to update QEMU with minimal guest pause time, by preserving
>>>> guest RAM in place, albeit with new virtual addresses in new QEMU, and
>>>> by preserving device file descriptors.
>>>>
>>>> The new user-visible interfaces are:
>>>>     * cpr-exec (MigMode migration parameter)
>>>>     * cpr-exec-command (migration parameter)
>>>
>>> I really, really hope we can avoid this..
>>>
>>> It's super cumbersome to pass in a qemu cmdline in a qemu migration
>>> parameter.. if we can do that with generic live migration ways, I hope we
>>> stick with the clean approach.
>>
>> This is no different than live migration, requiring a management agent to
>> launch target qemu with all the arguments use to start source QEMU.  Now that
>> same agent will send the arguments via cpr-exec-command.
> 
> It's still a bit different.
> 
> There we append "-incoming defer" only, which makes sense because we're
> instructing a QEMU to take an incoming stream to load.  Now we append the
> complete qemu cmdline within the QEMU itself, that was booted with exactly
> the same cmdline.. :-( I would at least start to ask why we need to pass
> the same thing twice..

Sometimes one must modify the command line arguments passed to new QEMU.
This interface allows for that possibility.

In an earlier patch series, I proposed a cpr-exec command that took no arguments,
and reused the old QEMU argv, which was remembered in main.  A reviewer pointed out
how inflexible that was.  See my response to Daniel yesterday for more on the value
of this flexibility.

This is not a burden for the mgmt agent.  It already knows the arguments because
it can launch new qemu with the arguments for live migration.  Passing the arguments
to cpr-exec-command is trivial.

> Not saying that this is no-go, but really looks unpretty to me from this
> part.. especially if a cleaner solution seems possible.
> 
>>
>>>>     * anon-alloc (command-line option for -machine)
>>>
>>> Igor questioned this, and I second his opinion..  We can leave the
>>> discussion there for this one.
>>
>> Continued on the other thread.
>>
>>>> The user sets the mode parameter before invoking the migrate command.
>>>> In this mode, the user issues the migrate command to old QEMU, which
>>>> stops the VM and saves state to the migration channels.  Old QEMU then
>>>> exec's new QEMU, replacing the original process while retaining its PID.
>>>> The user specifies the command to exec new QEMU in the migration parameter
>>>> cpr-exec-command.  The command must pass all old QEMU arguments to new
>>>> QEMU, plus the -incoming option.  Execution resumes in new QEMU.
>>>>
>>>> Memory-backend objects must have the share=on attribute, but
>>>> memory-backend-epc is not supported.  The VM must be started
>>>> with the '-machine anon-alloc=memfd' option, which allows anonymous
>>>> memory to be transferred in place to the new process.
>>>>
>>>> Why?
>>>>
>>>> This mode has less impact on the guest than any other method of updating
>>>> in place.
>>>
>>> So I wonder whether there's comparison between exec() and transfer mode
>>> that you recently proposed.
>>
>> Not yet, but I will measure it.
> 
> Thanks.
> 
>>
>>> I'm asking because exec() (besides all the rest of things that I dislike on
>>> it in this approach..) should be simply slower, logically, due to the
>>> serialized operation to (1) tearing down the old mm, (2) reload the new
>>> ELF, then (3) runs through the QEMU init process.
>>>
>>> If with a generic migration solution, the dest QEMU can start running (2+3)
>>> concurrently without even need to run (1).
>>>
>>> In this whole process, I doubt (2) could be relatively fast, (3) I donno,
>>> maybe it could be slow but I never measured; Paolo may have good idea as I
>>> know he used to work on qboot.
>>
>> We'll see, but in any case these take < 100 msec, which is a wonderfully short
> 
> I doubt whether it keeps <100ms when the VM is large.  Note that I think we
> should cover the case where the user does 4k mapping for a large guest.
> 
> So I agree that 4k mapping over e.g. 1T without hugetlb may not be the
> ideal case, but the question is I suspect there're indeed serious users
> using QEMU like that, and if we have most exactly a parallel solution that
> does cover this case, it is definitely preferrable to consider the other
> from this POV, simply because there's nothing to lose there..
> 
>> pause time unless your customer is doing high speed stock trading.  If cpr-transfer
>> is faster still, that's gravy, but cpr-exec is still great.
>>
>>> For (1), I also doubt in your test cases it's fast, but it may not always
>>> be fast.  Consider the guest has a huge TBs of shared mem, even if the
>>> memory will be completely shared between src/dst QEMUs, the pgtable won't!
>>> It means if the TBs are mapped in PAGE_SIZE tearing down the src QEMU
>>> pgtable alone can even take time, and that will be accounted in step (1)
>>> and further in exec() request.
>>
>> Yes, there is an O(n) effect here, but it is a fast O(n) when the memory is
>> backed by huge pages.  In UEK, we make it faster still by unmapping in parallel
>> with multiple threads.  I don't have the data handy but can share after running
>> some experiments.  Regardless, this time is negligible for small and medium
>> size guests, which form the majority of instances in a cloud.
> 
> Possible.  It's just that it sounds like a good idea to avoid having the
> downtime taking any pgtable tearing down into account here for the old mm,
> irrelevant of how much time it'll take.  It's just that I suspect some use
> case can take fair amount of time.

Here is the guest pause time, measured as the interval from the start
of the migrate command to the new QEMU guest reaching the running state.
The average over 10 runs is shown, in msecs.
Huge pages are enabled.
Guest memory is memfd.
The kernel is 6.9.0  (not UEK, so no parallel unmap)
The system is old and slow: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz

         cpr-exec    cpr-transfer
256M    180         148
16G     190         150
128G    250         159
1T      300 ?       159 ?                // extrapolated

At these scales, the difference between exec and transfer is not significant.
A provider would choose one vs the other based on ease of implementation in
their mgmt agent and container environment.

For small pages and large memory, cpr-exec can take multiple seconds, and
the UEK parallel unmap reduces that further.  But, that is the exception,
not the rule.  Providers strive to back huge memories with huge pages.  It
makes no sense to use such a valuable resource in the crappiest way possible
(ie with small pages).

> So I think this is "one point less" for exec() solution, while the issue
> can be big or small on its own.  What matters is IMHO where exec() is
> superior so that we'd like to pay for this.  I'll try to stop saying "let's
> try to avoid using exec() as it sounds risky", but we still need to compare
> with solid pros and cons.
> 
>>
>>> All these fuss will be avoided if you use a generic live migration model
>>> like cpr-transfer you proposed.  That's also cleaner.
>>>
>>>> The pause time is much lower, because devices need not be torn
>>>> down and recreated, DMA does not need to be drained and quiesced, and minimal
>>>> state is copied to new QEMU.  Further, there are no constraints on the guest.
>>>> By contrast, cpr-reboot mode requires the guest to support S3 suspend-to-ram,
>>>> and suspending plus resuming vfio devices adds multiple seconds to the
>>>> guest pause time.  Lastly, there is no loss of connectivity to the guest,
>>>> because chardev descriptors remain open and connected.
>>>
>>> Again, I raised the question on why this would matter, as after all mgmt
>>> app will need to coop with reconnections due to the fact they'll need to
>>> support a generic live migration, in which case reconnection is a must.
>>>
>>> So far it doesn't sound like a performance critical path, for example, to
>>> do the mgmt reconnects on the ports.  So this might be an optimization that
>>> most mgmt apps may not care much?
>>
>> Perhaps.  I view the chardev preservation as nice to have, but not essential.
>> It does not appear in this series, other than in docs.  It's easy to implement
>> given the CPR foundation.  I suggest we continue this discussion when I post
>> the chardev series, so we can focus on the core functionality.
> 
> It's just that it can affect our decision on choosing the way to go.
> 
> For example, do we have someone from Libvirt or any mgmt layer can help
> justify this point?
> 
> As I said, I thought most facilities for reconnection should be ready, but
> I could miss important facts in mgmt layers..

I will more deeply study reconnects in the mgmt layer, run some experiments to
see if it is seamless for the end user, and get back to you, but it will take
some time.
>>>> These benefits all derive from the core design principle of this mode,
>>>> which is preserving open descriptors.  This approach is very general and
>>>> can be used to support a wide variety of devices that do not have hardware
>>>> support for live migration, including but not limited to: vfio, chardev,
>>>> vhost, vdpa, and iommufd.  Some devices need new kernel software interfaces
>>>> to allow a descriptor to be used in a process that did not originally open it.
>>>
>>> Yes, I still think this is a great idea.  It just can also be built on top
>>> of something else than exec().
>>>
>>>>
>>>> In a containerized QEMU environment, cpr-exec reuses an existing QEMU
>>>> container and its assigned resources.  By contrast, consider a design in
>>>> which a new container is created on the same host as the target of the
>>>> CPR operation.  Resources must be reserved for the new container, while
>>>> the old container still reserves resources until the operation completes.
>>>
>>> Note that if we need to share RAM anyway, the resources consumption should
>>> be minimal, as mem should IMHO be the major concern (except CPU, but CPU
>>> isn't a concern in this scenario) in container world and here the shared
>>> guest mem shouldn't be accounted to the dest container.  So IMHO it's about
>>> the metadata QEMU/KVM needs to do the hypervisor work, it seems to me, and
>>> that should be relatively small.
>>>
>>> In that case I don't yet see it a huge improvement, if the dest container
>>> is cheap to initiate.
>>
>> It's about reserving memory and CPUs, and transferring those reservations from
>> the old instance to the new, and fiddling with the OS mechanisms that enforce
>> reservations and limits.  The devil is in the details, and with the exec model,
>> the management agent can ignore all of that.
>>
>> You don't see it as a huge improvement because you don't need to write the
>> management code.  I do!
> 
> Heh, possibly true.
> 
> Could I ask what management code you're working on?  Why that management
> code doesn't need to already work out these problems with reconnections
> (like pre-CPR ways of live upgrade)?

OCI - Oracle Cloud Infrastructure.
Mgmt needs to manage reconnections for live migration, and perhaps I could
leverage that code for live update, but happily I did not need to.  Regardless,
reconnection is the lesser issue.  The bigger issue is resource management and
the container environment.  But I cannot justify that statement in detail without
actually trying to implement cpr-transfer in OCI.

>> Both modes are valid and useful - exec in container, or launch a new container.
>> I have volunteered to implement the cpr-transfer mode for the latter, a mode
>> I do not use.  Please don't reward me by dropping the mode I care about :)
>> Both modes can co-exist.  The presence of the cpr-exec specific code in qemu
>> will not hinder future live migration development.
> 
> I'm trying to remove some of my "prejudices" on exec() :).  Hopefully that
> proved more or less that I simply wanted to be fair on making a design
> decision.  I don't think I have a strong opinion, but it looks to me not
> ideal to merge two solutions if both modes share the use case.
> 
> Or if you think both modes should service different purpose, we might
> consider both, but that needs to be justified - IOW, we shouldn't merge
> anything that will never be used.

The use case is the same for both modes, but they are simply different
transport methods for moving descriptors from old QEMU to new.  The developer
of the mgmt agent should be allowed to choose.

- Steve

>>>> Avoiding over commitment requires extra work in the management layer.
>>>
>>> So it would be nice to know what needs to be overcommitted here.  I confess
>>> I don't know much on containerized VMs, so maybe the page cache can be a
>>> problem even if shared.  But I hope we can spell that out.  Logically IIUC
>>> memcg shouldn't account those page cache if preallocated, because memcg
>>> accounting should be done at folio allocations, at least, where the page
>>> cache should miss first (so not this case..).
>>>
>>>> This is one reason why a cloud provider may prefer cpr-exec.  A second reason
>>>> is that the container may include agents with their own connections to the
>>>> outside world, and such connections remain intact if the container is reused.
>>>>
>>>> How?
>>
>> chardev preservation.  The qemu socket chardevs to these agents are preserved,
>> and the agent connections to the outside world do not change, so no one sees
>> any interruption of traffic.
>>
>>>> All memory that is mapped by the guest is preserved in place.  Indeed,
>>>> it must be, because it may be the target of DMA requests, which are not
>>>> quiesced during cpr-exec.  All such memory must be mmap'able in new QEMU.
>>>> This is easy for named memory-backend objects, as long as they are mapped
>>>> shared, because they are visible in the file system in both old and new QEMU.
>>>> Anonymous memory must be allocated using memfd_create rather than MAP_ANON,
>>>> so the memfd's can be sent to new QEMU.  Pages that were locked in memory
>>>> for DMA in old QEMU remain locked in new QEMU, because the descriptor of
>>>> the device that locked them remains open.
>>>>
>>>> cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
>>>> and by sending the unique name and value of each descriptor to new QEMU
>>>> via CPR state.
>>>>
>>>> For device descriptors, new QEMU reuses the descriptor when creating the
>>>> device, rather than opening it again.  The same holds for chardevs.  For
>>>> memfd descriptors, new QEMU mmap's the preserved memfd when a ramblock
>>>> is created.
>>>>
>>>> CPR state cannot be sent over the normal migration channel, because devices
>>>> and backends are created prior to reading the channel, so this mode sends
>>>> CPR state over a second migration channel that is not visible to the user.
>>>> New QEMU reads the second channel prior to creating devices or backends.
>>>
>>> Oh, maybe this is the reason that cpr-transfer will need a separate uri..
>>
>> Indeed.
>>
>> - Steve
>>
> 

