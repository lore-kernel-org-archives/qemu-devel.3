Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0135CC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 19:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6bM2-0000O1-Lp; Mon, 13 May 2024 15:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bLz-0000Mj-Bl
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:28:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bLv-0008MK-MJ
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:28:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44DJBZXQ009886; Mon, 13 May 2024 19:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JsJFCS/g+iMY1/VIKYbbRQ8IYdR14Nwi7q7TOWYWcN4=;
 b=kOGc48IN6dQBurCH2Z9h5dvK140DTJ2H3PLpKkidYAF6SIHTQMdziILkhMWFJyzdPviZ
 HOP60yg84Fou6h/rbrwXY9t4pc5o8jnA+n03xZC+uKEn/3a1SLJkaWwDzwu4jonifjxo
 dXTeewCX1MYvOihelD2HmnyLIbQIvxaMN0k9Ni4s8nkAwSu9CHtBn+z6HETRklQbIrg+
 x3xU1wvJ9+zAeswh8tkWcHPFZsankUXHATArkQVsmHuCQ8WA5Ek91lzlqfxRcnYEHncv
 OoWEck1kYxDZ2t+s3OCRKL8QBI32w94NqbROVZ+Js3xFeXM9B6FYaFSGr5ae22qG4rl/ 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3r5j846s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:28:46 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44DIiSbo038269; Mon, 13 May 2024 19:28:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3y24pv2q0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7gTDGtQtCuTP0R4rHSfHZgb5/yib5iAxl1GOVi68EJHbt9h/2CpA2tVnVgyVj2d0EDoC4okfoJ71qTs5NKMJc1zkd6flccX4njbP461Lg6ge/rDZlFsl+WA7EnYJ2Bq/q56qq9I75J+TecJeXm6KBeTtkUX/0JVY0n17Fm3Qt8Ax0wnmYyMNub6lubITQHf6UMOsJCdKlNUitDQ1AZp3jDBS+JOQ0k/2VjiPHpNriwS5ix7p+gjqyA1e+M7yhvxC8cErrmcWJ5evkLlDRgzx1SLaWY551/ggywESfzhdzz97YIQ7jRr3Ml7G/Rtk5sTl3Va5mpc5TKis8/P3g1pqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsJFCS/g+iMY1/VIKYbbRQ8IYdR14Nwi7q7TOWYWcN4=;
 b=CInmKhmlAEHlizn2WStv6XbTWClkElUWQnsQV2KVV97UTQxLlZAGD7H4UIQQOnronpf/hBJVC3gZQ5nnM2tAVOoEkPVYdbH+9pljq9kfy+N37pEvFq/UP7VutuMIHwcsGamg3qiVrpPVXFmIz0zstqD7v2WqP4y2NY1lRBjd7NCHxK8/BanV/QxUBkyCcd1q4qYrB54thvNshx/zf+0j1Goc7n2G4qWOwaCLG1rQx6x40oZalPZ3UU+hXrXaZTZ5elQM31aniQxDFd1R/1fXBYR7DvEM5AKHLWbQ56TP4HOS5GIAsK25ySY6yqbed1ZhjYIS30dD9Vp0KNrjSIVp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsJFCS/g+iMY1/VIKYbbRQ8IYdR14Nwi7q7TOWYWcN4=;
 b=ZEQmqAhIZTt9G5kCeG150Xn5DgX3tdeCKu1JB/Milsdv5uegmVAet2nCqiH6d5ny0MzeGnaxDxFh7D50EOTeMisV2eYiJutpdoxNGsK6W/9T5zkwtkLIdBCjk1/x0Z1XkZm5pV59B30pX8PvYTmL2p3vIKDo1lj6i47mj9lQ37A=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 19:28:43 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 19:28:42 +0000
Message-ID: <6950e549-4714-44e7-b6ee-641649024215@oracle.com>
Date: Mon, 13 May 2024 15:28:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 06/26] migration: precreate vmstate for exec
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-7-git-send-email-steven.sistare@oracle.com>
 <8734qums4h.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8734qums4h.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0100.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::15) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7d15fe-255e-417c-a2c0-08dc7382e643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVZ6RXVmeVEyUG5VTmsyWUZqdUhoYXJuc3hqbm94NnlFK1dKVHgwMEhaQ3Bn?=
 =?utf-8?B?UEVHZkJ6NWRvVGplM2VOdDZQVmJ3Mit3djd4U1dpb1ZwZS9ERWkyOW5IN2x6?=
 =?utf-8?B?eWU0cmhZQ3VCdHpxUW5uOWhpeTVjRzczc0hXb3RRQVlMM2c0S1lhMm95R0FZ?=
 =?utf-8?B?MmVXQzZGdldmem1Xbm9CYkVIbnh1RHlJOU9PazR4bHBlZWEyVmJWRlU1QmhU?=
 =?utf-8?B?OVZOdDFnTElhYjBwM2xMQ0RJU0Fxd2RudTMyVjBvS3VUWDAzc0NzMDZ6RHdN?=
 =?utf-8?B?ZlNGbVFueWk1TUFmcVI1K0hyeUhvSFp4ZTdhU3hicDNaeU9Wc3k4bWd1WFlH?=
 =?utf-8?B?anZ1dXMrVDhGcUFaRVJGQkp6ZzZnR2lyclV5MFVmRzR2Y2dsSWsxNk5jZmRj?=
 =?utf-8?B?emoxWnNSU09aVmswUVJ2R0drRSt4enN1aWVITEIwRUl2bXM4QUY2RzEzakwx?=
 =?utf-8?B?TTdjRDRpd3I0S1AxYURWZ1YxMlJKWjlRQUVra1hJd2RIRDdxTUxkZzBtM3dy?=
 =?utf-8?B?SFZIYXJLQ1RaVG9LTHJLbVpjV09sY0FsQkVWRG9JR2hFZ3puc3lKYkJwWW50?=
 =?utf-8?B?NkJlYllWblY3TkM0KzdUYkFBeXRiQnlhVEZ2MVhNV052SlgwWWt0bE9nazBu?=
 =?utf-8?B?Tnp4WGlsekNZczBLL0tudFJTcnhMSW1jZ3Z6Zjg5dUNnZlhUNVNNanhFMndD?=
 =?utf-8?B?Y1JFS0JydDF5TVhVdGlFUGhIYzhCclVkTXFZb2RjSlVrWWROemkxSWJvYnlo?=
 =?utf-8?B?MmIvNXpZbGJEcWx4eXBhZEw5eDR1UWMrcVkwVk9XVVNNNnZsMzJYYU5Tc1N0?=
 =?utf-8?B?cHBPK2VzQzROb2w0d3VzVnNIZnU2emk0RC82NGQvNXN4VGJwVmlxMkp6M2pw?=
 =?utf-8?B?WG9IVnY5dkRSZEtQQUpMNG5VOVpudEZCL2tRMWc3VkNYbURJN043YTZzajh1?=
 =?utf-8?B?aitRWXQ3RndMRVRNblFyNnh4cGlRQjV4TWNxVTVxa0JSeHR1bm9CYlpJNFBL?=
 =?utf-8?B?blc1UVZMZmFITFQrcExvUWxhNC9Ucncwc2N5SStPR282dlF3VkpjUzM5THlp?=
 =?utf-8?B?MmVLY1JyeW51eHJvUUR4VDFpYk5uWnR4UDRjOWRIS3JTMUNSMVd4UUo2Y1pZ?=
 =?utf-8?B?dmtYWkFqSFJNWCtrQm5ZMFlxbjVFQVZHQUp5K1d4WTVIeW9UVldJemJoMXhB?=
 =?utf-8?B?cmlOL0ZiSGRVeUk4MitWa2dmbzYvSEJBQm9BT3JhS1p2TG15bElGRFZFd2wr?=
 =?utf-8?B?L29INTN1R2xxUmZkckgwZlVQVlJkdGN4TVhLMWg4R2wrbkJvYnI2b2x5cWJY?=
 =?utf-8?B?RlB5Zkx0N2FuTUtjUDhjNGpSbXJDZDhCVlExazZ6VnVsTVNsdm5WTVE2S1Rh?=
 =?utf-8?B?U0Rpa1czRW9aVzNpVjlFNDJIMDRCSFBlZEpOY0hRSUN2c21vZ2xhMjBxVmNh?=
 =?utf-8?B?RGNDamdjZmtJakEyRUJZaTk1R21Lelc2VmY3YlUzd3dqSTl0cDdOcHZ5bE9S?=
 =?utf-8?B?MytNRGpzZzJjWGcyMmw3ZFd0cThDQ1hwdk45UXNFVXJnR1FFL2Fwb3NsUVA1?=
 =?utf-8?B?SEhiWWVZWEkzSVlQS3YrZ2R0a2FaaHNQeWhBNnBuKzBzbFlxVStvVXQ4aDNH?=
 =?utf-8?B?T0tmZEtDLzVpTVVkM3dNUGpaWndDOWlTUThvcXF4TUxUM0JoZDJLQ1prQm92?=
 =?utf-8?B?MXoxTW5mY1J3WXFCVmhHMU9sdHV1WTYrQVFXRVZhcUppMGhVQklCN1NRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnBVT1VwcU9VYTBQbFUwWjloeFltRkpKRm5FemtPcmVGS0ZjTSswZjB3cDZ3?=
 =?utf-8?B?TWRVWjM5SkhVZDcyZmNMODVDbUdQUlcvUlRwcy8wSUgySTlFVUdkalZBVExU?=
 =?utf-8?B?S2sxKzh0aEJZTjVFZlp0VVBtYkFWeVdLNW5oSFFuNUdYUXN1YTJremZsV1BF?=
 =?utf-8?B?Si8wdDlaeUtQSmJaZzJzT0s5Y0hhaUtGUmpIZUp1MnJZRUx3cWhaUTY4UGZv?=
 =?utf-8?B?dk8vakY0RlJPQW5tN2NCajBKOWRoM0EvSThqZXZPL24rTFlGNU5TeVNVMFdp?=
 =?utf-8?B?d2xXWTFteDZkTHJ1aVhMQXgxYmZORXEzTlMzSnl5YzJQd1hxbERXK2RMNkJo?=
 =?utf-8?B?S2FHWlFwL0RYOFhzTzJ3ckcyeFVwMEhJODFlYm8yb2s5VG9JMDZFYzB5N2hj?=
 =?utf-8?B?dFFRUXNOMFdWWUxpcnR1TndIWXU4SE1PRjZsVXlpVFF1L2Q1bE1oV1pZL0dS?=
 =?utf-8?B?WmNHSG1qRDFGcW9MamRLcWRFTDFuZDNTWWM3N0ZHRldQZ3BnNjVjTFB0Z2Ji?=
 =?utf-8?B?U2lSWHpDWWl1K3FobDRaM1lqVmxxdDZxcnlYanpuSXA5OU5yWXhsaFhhZTZX?=
 =?utf-8?B?c2hqQU5FZE85cTNQVFg4N3dnbUlVQlVvclBta1VQZFFCM09hU2trLzlpeTBo?=
 =?utf-8?B?REpLd3Foc1hHT3Q0RDFZdGo5TTNrUjNPVDY4T0ZmZjNaK3dpUnZWU0xJUUZZ?=
 =?utf-8?B?amg1ME1ISGgrQXo4VkQ3ZjBPQitjUUMzZ3JuVFBEcGZucHRDRjV4QXdFeU9N?=
 =?utf-8?B?SGJXY0F2VHQvZDZ4T1J0cGtxdDhycEFjcElaNDZHOVQ2YWo1aDAwcXE3ZHVt?=
 =?utf-8?B?MjVuOGxMVTRCOW5KMWZFR3hZT3lUV2xaSnNCblI4bTZtWTY3K1JzMlRPODlC?=
 =?utf-8?B?NXI4WWM5VWJySnJiWVd1MFFHbXFPNjd5TnV4WDAwR0hXYUlaRmNXMngxUVc4?=
 =?utf-8?B?Tmc2MU8rbEZ3bWUzUXgzejZCbkZaamI4bkdDUnZuUjl0Tzg5UlN0RFhlc1BR?=
 =?utf-8?B?YWtUNEhmbUFnR2RLNy9tSlVHWG1wR3dFMHpvdThWekMyVnh0NUtFazRtRGZ2?=
 =?utf-8?B?YkNmeDM4ZmJPY0x2dEdleEpKYm9MRmhoZmxFOFFRWldLTWtoTk1CT2NLMHQ2?=
 =?utf-8?B?OEdJakZjUTd5Z0tNeWxsN25JTVM3NXlUUGpoYTdpciszU0ZDSHBmYVlaaWRI?=
 =?utf-8?B?cE9aVERabjhnZ3pXT2dCRGNUMk9ESmNDdmZUOFprQW15UUVkV0FCTXhBelI4?=
 =?utf-8?B?Y29adkNDWkw1UzhUcGdJOW5nWGVjd0F0QjEzVWlKQUFKa1NWdFhaaisvaFBa?=
 =?utf-8?B?c256Z0pXQ2JwbjRyd2ZuSXp2K203V0hReER4dzNEWi9weGtUWXFKMXc1Y2NI?=
 =?utf-8?B?bVpPeGhvUENjUzRQdUZoOS90b3lTSDg3Um5hM0w0UDV6N2ltemVvTGpyNFh2?=
 =?utf-8?B?Q2JCdVg2ZkRQSkg0OWlSaXRrZUV5UzVJY29ZdWFUd2h4OVdwVHhWL1BjclNB?=
 =?utf-8?B?UWVPYjFXVzEvUEk0VVFFeXdCTUFnT0hQVmVtYzF1a05oTkxsTHdOS3ZhOXl6?=
 =?utf-8?B?c2QvaUovRE5hSGMwbHlSZ25nallIVnJlVGE1NEczeEwycmVXTVdrbHBhczJM?=
 =?utf-8?B?WkNKQlV5ZFJMajdaZDlGNStiRDhVQzUxRUw2bUxzUWNaRkNiWXEwMUxJWFFQ?=
 =?utf-8?B?RWFqU3pjdDFVYUg1MlBxRC8waVI2ejV5eFJwa0wrZG5tbHZUSkNWaFhoeG9m?=
 =?utf-8?B?b0ptT2t5Y1h5OGkxTlpCZENpTkF6VHg4M3kyMHB1S0FGbGs3ZmhWTHVJbXBG?=
 =?utf-8?B?TXlaTXVpTGdLR25LakQwNmw1NlFBRGxwRC9iem02L1JLcVY3TC9hWG9FTlNu?=
 =?utf-8?B?Zk00Rzd4SzJWVmdjVEoySzNtZlA1VzF2M2xoWFN0NkhSQnhYZ1FlSVJSaHlB?=
 =?utf-8?B?NHpSK1BzRDVDWHJTWEowa0ZuRWZUUTUxYTVVUjR3WHY3S2ZiZ1YvcTA4MHBh?=
 =?utf-8?B?cEFJUE1XenJ3NG1aT1dFTzZ6WXdHRHRnUDNWbW1aaDFneGdCZTY3NmNVcUxN?=
 =?utf-8?B?dDJsQnFlWXRiRnJ4M2NBZnF2dVpuOTdqaWNhVHNSejVPUjk0UmVFTFBKVWZy?=
 =?utf-8?B?L25WemdSdVY3QnErOEs3K1JSSUkwYUxBZW5OdE1tRk9IQ0lZU0NGeXJvMmtk?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yF6N6enFhD9JYcDwA5jii+jaG5wB4I2aP6Wmnh2M6lLOfD2d7HcBFwBqZ8tZfp1l+GHCGQ2MBUFOi9xfJuqsJ9R44+qUTZujF6npPABd7NA02LotZ2+IE1eUCDQhmrnghsnUbkagclYbxN0acWTdFn1bTuGDE1N90iBX5WO2k8Qa4gyV7r5Sx/L4MMlZiXbENeSSrM8DC/lxRdDX8pCWR4JoVwHjHDlRO2YuOyKT5Q2fqZuB1acxE36z/2Vwzr8LDJgkl745bcyLpW3C3SeKeDpjtsI5P9JkGDS9HdaRWxBqUJSWXH9x1GfdFo6N5YxFmVZEewnMG/PSaX0vTlq23QOW/tBxl5s8Epnk08fl6b9EthMNoEXLcgUxdxMh/bgnp1DEgd7JjfrqxPADen01iAfbySu4lEudn1XXEBkIb2bhYSZvCckgNdFx8cPD47lpbcNTRo9ZgoENOaniAzizk+ASX3O5dp4cemn6vtIKFT4mYq45bYqrSyB2dd9btBiGILM5o3Exj3l0EFEeZ2fMISYKh9K+n8wFxUwJAKdCcNkuTIlmQf66xblygyxU1979eGdz8qDOL0dWDlnRo3ZBxkeGQd45y3Wrsjf5ZzggCZM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7d15fe-255e-417c-a2c0-08dc7382e643
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 19:28:42.6815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnMyW2JJoRRUUBzxlKKRUY4+ZzCuvxZrYIfREQqR0IRtchyiTeHqLiwE5MFHQi0pjWE0htwepqWtOVDrDJXTCkbxWdwNyr1hwvJW54uG0oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405130132
X-Proofpoint-ORIG-GUID: aVu6b5bdbRVKv4-PwB65cv9tdee2shC3
X-Proofpoint-GUID: aVu6b5bdbRVKv4-PwB65cv9tdee2shC3
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 5/6/2024 7:34 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Provide migration_precreate_save for saving precreate vmstate across exec.
>> Create a memfd, save its value in the environment, and serialize state
>> to it.  Reverse the process in migration_precreate_load.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/misc.h |   5 ++
>>   migration/meson.build    |   1 +
>>   migration/precreate.c    | 139 +++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 145 insertions(+)
>>   create mode 100644 migration/precreate.c
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index c9e200f..cf30351 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -56,6 +56,11 @@ AnnounceParameters *migrate_announce_params(void);
>>   
>>   void dump_vmstate_json_to_file(FILE *out_fp);
>>   
>> +/* migration/precreate.c */
>> +int migration_precreate_save(Error **errp);
>> +void migration_precreate_unsave(void);
>> +int migration_precreate_load(Error **errp);
>> +
>>   /* migration/migration.c */
>>   void migration_object_init(void);
>>   void migration_shutdown(void);
>> diff --git a/migration/meson.build b/migration/meson.build
>> index f76b1ba..50e7cb2 100644
>> --- a/migration/meson.build
>> +++ b/migration/meson.build
>> @@ -26,6 +26,7 @@ system_ss.add(files(
>>     'ram-compress.c',
>>     'options.c',
>>     'postcopy-ram.c',
>> +  'precreate.c',
>>     'savevm.c',
>>     'socket.c',
>>     'tls.c',
>> diff --git a/migration/precreate.c b/migration/precreate.c
>> new file mode 100644
>> index 0000000..0bf5e1f
>> --- /dev/null
>> +++ b/migration/precreate.c
>> @@ -0,0 +1,139 @@
>> +/*
>> + * Copyright (c) 2022, 2024 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>> +#include "qemu/memfd.h"
>> +#include "qapi/error.h"
>> +#include "io/channel-file.h"
>> +#include "migration/misc.h"
>> +#include "migration/qemu-file.h"
>> +#include "migration/savevm.h"
>> +
>> +#define PRECREATE_STATE_NAME "QEMU_PRECREATE_STATE"
>> +
>> +static QEMUFile *qemu_file_new_fd_input(int fd, const char *name)
>> +{
>> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
>> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
>> +    qio_channel_set_name(ioc, name);
>> +    return qemu_file_new_input(ioc);
>> +}
>> +
>> +static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
>> +{
>> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
>> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
>> +    qio_channel_set_name(ioc, name);
>> +    return qemu_file_new_output(ioc);
>> +}
>> +
>> +static int memfd_create_named(const char *name, Error **errp)
>> +{
>> +    int mfd;
>> +    char val[16];
>> +
>> +    mfd = memfd_create(name, 0);
>> +    if (mfd < 0) {
>> +        error_setg_errno(errp, errno, "memfd_create failed");
>> +        return -1;
>> +    }
>> +
>> +    /* Remember mfd in environment for post-exec load */
>> +    qemu_clear_cloexec(mfd);
>> +    snprintf(val, sizeof(val), "%d", mfd);
>> +    g_setenv(name, val, 1);
>> +
>> +    return mfd;
>> +}
>> +
>> +static int memfd_find_named(const char *name, int *mfd_p, Error **errp)
>> +{
>> +    const char *val = g_getenv(name);
>> +
>> +    if (!val) {
>> +        *mfd_p = -1;
>> +        return 0;       /* No memfd was created, not an error */
>> +    }
>> +    g_unsetenv(name);
>> +    if (qemu_strtoi(val, NULL, 10, mfd_p)) {
>> +        error_setg(errp, "Bad %s env value %s", PRECREATE_STATE_NAME, val);
>> +        return -1;
>> +    }
>> +    lseek(*mfd_p, 0, SEEK_SET);
>> +    return 0;
>> +}
>> +
>> +static void memfd_delete_named(const char *name)
>> +{
>> +    int mfd;
>> +    const char *val = g_getenv(name);
>> +
>> +    if (val) {
>> +        g_unsetenv(name);
>> +        if (!qemu_strtoi(val, NULL, 10, &mfd)) {
>> +            close(mfd);
>> +        }
>> +    }
>> +}
>> +
>> +static QEMUFile *qemu_file_new_memfd_output(const char *name, Error **errp)
>> +{
>> +    int mfd = memfd_create_named(name, errp);
>> +
>> +    if (mfd < 0) {
>> +        return NULL;
>> +    }
>> +
>> +    return qemu_file_new_fd_output(mfd, name);
>> +}
>> +
>> +static QEMUFile *qemu_file_new_memfd_input(const char *name, Error **errp)
>> +{
>> +    int ret, mfd;
>> +
>> +    ret = memfd_find_named(name, &mfd, errp);
>> +    if (ret || mfd < 0) {
>> +        return NULL;
>> +    }
>> +
>> +    return qemu_file_new_fd_input(mfd, name);
>> +}
>> +
>> +int migration_precreate_save(Error **errp)
>> +{
>> +    QEMUFile *f = qemu_file_new_memfd_output(PRECREATE_STATE_NAME, errp);
>> +
>> +    if (!f) {
>> +        return -1;
>> +    } else if (qemu_savevm_precreate_save(f, errp)) {
>> +        memfd_delete_named(PRECREATE_STATE_NAME);
>> +        return -1;
>> +    } else {
>> +        /* Do not close f, as mfd must remain open. */
>> +        return 0;
>> +    }
>> +}
>> +
>> +void migration_precreate_unsave(void)
>> +{
>> +    memfd_delete_named(PRECREATE_STATE_NAME);
>> +}
>> +
>> +int migration_precreate_load(Error **errp)
>> +{
>> +    int ret;
>> +    QEMUFile *f = qemu_file_new_memfd_input(PRECREATE_STATE_NAME, errp);
> 
> Can we avoid the QEMUFile? I don't see it being exported from this file.

It is not exported, but within this file, it is the basis for all read and
write operations, via the existing functions qemu_file_new_input() and 
qemu_file_new_output()

- Steve

>> +
>> +    if (!f) {
>> +        return -1;
>> +    }
>> +    ret = qemu_savevm_precreate_load(f, errp);
>> +    qemu_fclose(f);
>> +    g_unsetenv(PRECREATE_STATE_NAME);
>> +    return ret;
>> +}

