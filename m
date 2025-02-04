Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04E7C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMwV-0001o7-Kc; Tue, 04 Feb 2025 12:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfMwT-0001mr-DV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:42:33 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfMwQ-0008SP-QH
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:42:33 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514HBtBb019519;
 Tue, 4 Feb 2025 17:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=lZvaT6xB4NC4K4Jdap6rkCjJcDanw0/QazrnFoXBIgQ=; b=
 lFndxL2yRkhTt6m1RagS4klpO0ZXPHm8fLgxDuPz/ISOgzd2tlB158u6kVqeC8c4
 pt0eifeCHT13mVFlRWhW03LquN7GYDfUyg6P+C6HPRRP5nM8wxX5SAfnMC4NCE22
 /5+7b1tws1Z8c9fiObcrIx7kDHAy7Ouv3Mel3Wa9/tWrW0g1ew8B7EnmUcapxurW
 LVJB4xKnY5WBO8sSIPxuBPiqcUnZVjWyi5ezJwUEK2h2XADmxMezD8Z3zmLQwzoa
 FYzcWQ6ILGMs/Souwuc+18YEoTwb8r4byizd5J3KQc8SJYQ6/aRR/n5hELis0vbE
 0uq2hXLXpPi7I+zjqs374A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhsv5fsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 17:42:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 514GnNYn038921; Tue, 4 Feb 2025 17:42:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8e80u9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 17:42:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrQMAnBg0wLbDTsiKyHlgre9XnFJyXlZAJQRkL6sXq0J7k6y8W+diWW+on39ADYdpYgFHO4xaHh4rR5F/8hJxYiMtBtwx+pQCBHpRL3icHJQuPtxfapdNB8EDvpJtxIm6vG5dtN+J7+Q0cVmh5FTkRS0XnJmvExjCkM5iPUc9WpZeBEonNdRjWT+w0/ClG1+CkUxfM+gfJfOUYQLLVEq++LBZooR+hp72KNtOjaUru+EATDtvvKv9HqEqwk9GA0KdI/COY0QcGnHTBov/lmTOTrJhbz3PwtGnreluUTJWRjs4lRrTbN/ZyUmzFSH1EUxNGruieYE99F6u8neIpyJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZvaT6xB4NC4K4Jdap6rkCjJcDanw0/QazrnFoXBIgQ=;
 b=wT5X2D/aIF+7jgq5PypEaCKv/2ijNyZa+07J3ckqDcPg/qO140yd2gKFth1RIlgzJ98GOI8uQGJtWsZ62nsQV8M7ygRDM+XRQNdv50iUiE/51vNxgWsZZwIxrDd6z+QPzuyE+tleXM7MGyFhCidi2tQAjGYeKSBZIWFyUzwRdCAavT23UaaxXt0NKSJiflWJ7GqctGIiJO+E5Kfl7s3zQcFjJcFmUOJBZQDU7m6Zp/aOZmRWkXvmq4NJ4YbP+ODnWxo080BQ2SWeJlpCWedIX9iZUbeRte0ejIIRgh5U0mGptXCu1hxCQOmcRv98vMj29cWI9rUQnYOrqIA7x0UqeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZvaT6xB4NC4K4Jdap6rkCjJcDanw0/QazrnFoXBIgQ=;
 b=BZxf46+osMRj0GCed4aEvepXNDuk6XQ49rLLn3S1FzaxLGxPjH8Tt94SJAJKFPu93Oo5/ODSjXjfkC8v7xQAePxsqPZBcYPBYsJkM68VAxbHiknaBg0b+mlph20fDnKLVWEAyalX+jnZCnrPu4pOupdL6rJhofJz/xoxExMoEac=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA2PR10MB4474.namprd10.prod.outlook.com (2603:10b6:806:11b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Tue, 4 Feb
 2025 17:42:23 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 17:42:23 +0000
Message-ID: <e961804d-33a9-4243-8ef4-28f717a0d397@oracle.com>
Date: Tue, 4 Feb 2025 12:42:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 16/26] vfio: return mr from vfio_get_xlat_addr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Levon <john.levon@nutanix.com>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-17-git-send-email-steven.sistare@oracle.com>
 <e8e6eb45-a308-479a-bd14-ad9bf4cc509f@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <e8e6eb45-a308-479a-bd14-ad9bf4cc509f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:408:d4::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA2PR10MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d6efb0-c7f7-415b-18a9-08dd454347c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dC9EeUVtVFNtdTVXSkk0WHVlQlJXSHU3WnFlZWNCbm94TEZZV05aampUN0xm?=
 =?utf-8?B?Q0xKOUoyaXVjeEt3c1FhZXczV1RhajJCbU5LcU5yblRNa0FRWVV6MXJYcWhG?=
 =?utf-8?B?Zzc2MFd3c0ZucmQzc05VbWdBNDM3Y1hSKzE5S0N2eWpwVUtSeVlzTmN1RGVj?=
 =?utf-8?B?ZE5wTFFNYmY3VUpMZDVNOWFXT1VTTDhHd09qa3FFaHIyWUt4ZzY1RlAzVm03?=
 =?utf-8?B?eURPU1FEQTJMZjNXdkJJU09mNkx5Z3pFam01MEtVMlFrOWRYZUNYb3I0SFpu?=
 =?utf-8?B?WGJSaGFxYklyWUU1Uk9mRU9FUCs1ZmY0cWN4aXlQZ2p1Umo1OG9nRmRsKzZm?=
 =?utf-8?B?NnRiQnM0WUJlc3V6UmhLNlk0dnpseWllVWt2dTlia29QWEhNUmxjL0NpZHIx?=
 =?utf-8?B?TWhvczBCdEpCOTBNQ0tHVjBZSmxUdGl6dCtFNzUyQ0hoYnBuS1BjbytlNGU5?=
 =?utf-8?B?QVRZdVQyQTJXNjhMc0M4YXZMbEo3dlNjUWdjVjFrbjRKR2RWclR5NkEwVC8y?=
 =?utf-8?B?WTBwK1NFY2tzUzJWSHR0WmdHdnoyeUVCbUhqWFg2aGx1SUxzNzMvMjhXcnQ1?=
 =?utf-8?B?bFgxOGptMTdNUFpVa0pEV3pPWS9uM0FhWTFzL291TW84ZnNURWdhdU45QU5K?=
 =?utf-8?B?alB1Z3hEWjIrQU03dTdMcGh0UVNlQSs5ZG13c2JGUlhmZ3RZejlwc3RxeFBE?=
 =?utf-8?B?d0JuQlZBWnJwbHhobDArOTNtNjJuZHhHd3hJZzlvZVErZTFNbUZyMEcyMmRl?=
 =?utf-8?B?YTlLUk95VkxQbmRkMVNpNy90cnRFbUtuMy9wMnluQW5RNU9zbjFsL2NPY2g4?=
 =?utf-8?B?WnlpaDVIYnBBTSs5UVdHUm9NMms4dTBDQWlFM2psS0JTMGE1V2JYWDRxS01s?=
 =?utf-8?B?RjJveXRvdHlVNkl6Vk5NN242L0tZSFJOZzhCdGtyNGUyQTBBaEttQVVuV0xZ?=
 =?utf-8?B?OThOUmg0TFR4YjdqYSszRGdhYVpnbFhXdXBSdXZQcUdPOWpkUGhiUHR6SUNP?=
 =?utf-8?B?L202K1REM21OdTBFdGd0aHlSZ0pQdy9UT2ZBWGZERTU3SDdFZ0kvM1BhRGp0?=
 =?utf-8?B?VlBqbHh0dVZ6SkdWZTlHNzM4ZU4zQy91NDVvUlBoS0pFOXRPVk9zKzE1MFJp?=
 =?utf-8?B?SmNyNkdKNC85TUVJa01aakFmK0d0cSswOUkvajIvaUkyS25YTmh5NUJnai81?=
 =?utf-8?B?SEoydTlSUGtIby9qc2ZzT0g2cGdVTGgwSEQvYTIxbTdDRUNKNGdkTWY4TlRU?=
 =?utf-8?B?R0NiN0kwQ0FQZXFQb29QNHBENWdTNHNGMXVNNFNVcnN0R212TGF3a1pndzJP?=
 =?utf-8?B?endOaDhOd05Cb0t3dFpTWFdoZUw2elN4d2RBQUZ5YmpDc2hBRk1PQW5MQW9r?=
 =?utf-8?B?TkVSN1dBZCtsenBvT2ZnUlZvVTdTcXlpYmdONHdWTlhCcTNSQUV6dDZLTE44?=
 =?utf-8?B?SmVaS1FpUUJuYS91SFJINC9JUUs4Vm5Pc0JRQVJzS3FtK2E1TUhJNFRNQkFt?=
 =?utf-8?B?d3RObzRxUFc0RmVDTXNvcmlLMTlUTFJhQ0MyUjcyRnBTSmZsWlRONDlYdFFu?=
 =?utf-8?B?TmE2cTdlNkRDemhMVzdybTJlTVBJL2R5ZlhoQThQdDdYdDJ3S3JDejczRlQz?=
 =?utf-8?B?Zm13aWtFcDFOL3VDcnVET1FuTDRFdG9STGVQV1lWR24rZVltRVdwRW9aMFkr?=
 =?utf-8?B?VUYwbGszVGthblllWXlSQ0ZkSEhNeUt4akFBSDdoMTBnL0EwaHUzNXVtSTZF?=
 =?utf-8?B?N1QyOWQzSlJxZjMraTBuOXJmanlKYmFNaWw1Si9vc2ptN0ZVbkp2TXFTYW5E?=
 =?utf-8?B?RURjVFA2eWJhZXZ4V3lZN0Vja1IrbTJNSTBOSXlUMEhjV1BsOCtsd3RBU2tu?=
 =?utf-8?Q?RxoR48MVhyXFD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SURtQUVsSUNMYUNHdjRkZEJHcTFJODRFL3Fmc0FVMjM2Q1BEd0FUVktrMXY1?=
 =?utf-8?B?alQ2QnVNc3BvNEJWMHpOaCtzWTBPeTZIYU5kYUt2MUdOcW1uMHkzNlgvKzNP?=
 =?utf-8?B?WW1VeWd0U3ZmeVF4dmRuUTB1MnNEZU5nYUdZS00xNFVCa1lxdU1ramZkODhE?=
 =?utf-8?B?TTFySVI1Z0hESHM5YmFDRTJuUGtxT0FVa2h1eVVObk8vMEVnL0Vwem5scFpP?=
 =?utf-8?B?OUZ6NGo0eVZqT0o4RVR1LzRxTnVPa21mNm9HcWhkRlY5dW9mM3R0MGg3d1VD?=
 =?utf-8?B?NHpiY2ZGVU1iSUNBaE85V3NyUHNXWC8yUnRJZXYxbE8yU25mS0dFMkx0VU1V?=
 =?utf-8?B?R1BaTFJZNGtsa082YlZPYjNubERFWmRsQjh5MkVwa21aMlZ2MVFtRlJ5UzFP?=
 =?utf-8?B?K3hJNUw3Q0lLM1FtMEw5ZU0xS2FUY09JM05KN0FMYi9YNWIxSTlSdEVFRkYy?=
 =?utf-8?B?ajdrVkJwdVhINGJKYTRJc0gwV0lSaWxuSnFkUndZUmpsMXRKNzlIdnJPV1NI?=
 =?utf-8?B?ZzNsWTI0bkpXN3M2TmNpZnV6eWl2dFcrMk1uVk9ndkJMS3VPNkdYWXUyQXlh?=
 =?utf-8?B?RzRQVk5lRndKU1JHWHRBdjhZcXMzdkVBUmlVeFM3YnR6RnJTc0V1b0lDTzJG?=
 =?utf-8?B?U2drRG1KeHBWM1RHQkQ5RFp3YVJGeWJuNGJaVWE2V3hMMFhmNHY5bHRpaS8w?=
 =?utf-8?B?ZHF3Wk1zZWtIZXgxbEZLL2dJRWJaUVkxSXluckZ5NXV5Q1o4RjJZUEdvcjdD?=
 =?utf-8?B?V0doWEJlTnQrc2pFOVZGMms0QlQ4OGFLUkMzOGd5NFpmZHZjT29RQ1hsL2w2?=
 =?utf-8?B?YTZXUmt1b2RSNC9seGsrYWV0WWlCL2NTbVBBMzBicVZvaFlPendnZGg4TkEv?=
 =?utf-8?B?VWl4WEdRME03S2w4YTJFRUN0QXdFNnZDQkJESHowRjh5UHlnT3ljbm5CUWV6?=
 =?utf-8?B?NUl6UTVtOVBnN0ExUnl4MmNyRzN2cUNweUV6VkNZV1BPaDN6Q1lkOGloclky?=
 =?utf-8?B?RmhDSXZBSHpobWJxNUNwcTk4RW1qT0JCZ2h4M1JIcHRWRHkrUHdIeGwxQ05a?=
 =?utf-8?B?a1piR1NHaTVsazRXRytWMmd2VElQZHcwRHM3ZUxwSjlwMVU3VHFPRXZSNW04?=
 =?utf-8?B?K0NldVZFWU5jRmdhb3hNdVFwcGs3emZxVXBOM1RqU1RXcytRd1JqcldYVzB5?=
 =?utf-8?B?d3V6R1JKZkcyblNqb3hkWmREZUVpYjZab2Z0cktOL05vTTRNbW1CQnI0K09G?=
 =?utf-8?B?VHZId0VLeEo4NmJHT0c3TXVHbC9Lb2ZobkIwWjNETVhQWUZuOE1ycndXYVdY?=
 =?utf-8?B?YUtjUUUzMC8zR0lkNklqS1NBd3N4NE4yNkpEd2EwSW00clo1OEtaKzU3cGdo?=
 =?utf-8?B?dnkrYXNPODlLMStYOGlPazhRb1gvbm01d2RjM3BDbm9XWURCLzlNWlBheXdn?=
 =?utf-8?B?TjhLUlRJR09MYUxNUk9Bd3JMS1d4MG0vUVgwOThrazR4QUJVVmQ5bWpIejNW?=
 =?utf-8?B?YmFHb3lZdWltaWRWbG5YNlRuMDNDWnNnRm1DZVlqWWhldE5TTlFUTGUwaEFR?=
 =?utf-8?B?bU5OeW9TT2N3NFpTU1dXb3U2WjFYT2hKdHhIdzU2bi9hRDRXek8zMENOQXBz?=
 =?utf-8?B?Y3l3a2k4SG50ZUJ0dXVzMjluQ0FScmVqek0xSWpFWXVHV3NEYUE0eTZrTzdN?=
 =?utf-8?B?aHdZWitwWGRIRFh5MmszMGFpamw2cXdNcXE3N1BuUlI5c2tadEl6d0ZGZncx?=
 =?utf-8?B?Y1Jra2tiYTRHSlRlRVRpdFVac3RmYjY0VUs0UkN0NktBclBTS01RVFRHMS9S?=
 =?utf-8?B?TTNWZGM1NkZoeHBsZVp0L3VpODhCcDBkdmVnNVpLQUlmRm4waXBGc0h4OGxS?=
 =?utf-8?B?NnpDeXhEYTZGWHNxR3lsRDJKVVNOWmZGcVc0NmxZU2FZZDdjZzR1Y3c2Yktx?=
 =?utf-8?B?M1BIcTlPTDRyVmpKQUcyQ3dDSzRxY29ZQnp0RUdweW4wS3MwOGpmbUpSQ05S?=
 =?utf-8?B?bTFYSUNmcVJVckdmVXZsa1pTNGVCV0t6Sm9Za0tKVkVTUWYzR1N6OERFSEhv?=
 =?utf-8?B?YW01dkVMV3M5UDJQTWl1TDlldWxlQTJQMnF2WmtEaHJKWWRaa09nTGtvY1Qr?=
 =?utf-8?B?Y1JWejVoUUF0RkhPMUNUcktDeTUxMUl1TE16WWd1MGRweE5xL0dmbkw1K2xW?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pjSE2DzrAgrbeNw+GnvCImqTMZFKQkbnBdqDkygumcBUEmos5z6SVu3Zp7gIAhybK75sxQrlqCFGOe30QOcH2ABp1GGcgjDhwjFLicqDaUFFuKHluG+Y3WD2N3AyvH4Y9rdodOEWoKjxRZ8YVSnTslwzkOJXoYlY4yaT3XZ0EMe6USLu+z0/Nmkr9pep2aFKbxN+d/GlpIIXtKln34lmHdLxa+cSSTVSfzNjbAQyrvhx+iltWhkbwlZhE64dgCpdIJP0w+47RN6RKQzN3LGsKCjIXKyMQHEebPGlOfj7xvPj3qP+HQa35UzVyGgxLZmINZCHWLFeSTfPyzd/y/12b6kQTxraM+U6/Y7+x9wwUN5e2Vli3h3ezGj/cFRDf6mJQga/QA2828Pd2A8GXhDGmAgYg09+pw22gyeAZKp6U4HuvHjsNdN/ocmn7tHtndywYG2pFc6Kf67g3ZVj3YNJgepfz3bh8qrh70PPGdMVmkJQfFDwfk/g7KbZgxNwQt/1KqJb6ZsjWCzZj7wgQyMBMhpANCe3mG7KgOfKoRLWmc3UqOEo+qf9W/6uzQlRzmuKGT+eKlGIXmHtuM9MHksFdHIF3tYTpr9zT9oD88TdSaE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d6efb0-c7f7-415b-18a9-08dd454347c2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:42:22.7017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ig3G8UhE7tY3z6fcqxJ8iZyz4ECiJO9RE9cHhjRltk/RXXWH2PChu+NCB9EOyRuXu1xyBKOhUqUdW92vVWQrn+3H1bH4nwQ8NWoZH2pZIwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4474
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502040135
X-Proofpoint-GUID: U-0-CI_yr9N6IRww5VacNLHnnNYfefZ2
X-Proofpoint-ORIG-GUID: U-0-CI_yr9N6IRww5VacNLHnnNYfefZ2
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

On 2/4/2025 10:47 AM, Cédric Le Goater wrote:
> + John (for vfio-user)
> 
> On 1/29/25 15:43, Steve Sistare wrote:
>> Return the memory region that the translated address is found in, for
>> use in a subsequent patch.  No functional change.
> 
> Keeping a reference on this memory region could be risky. What for ?

The returned mr is briefly used here in later patches:

vfio_iommu_map_notify()
   vfio_get_xlat_addr(&mr)
     vfio_container_dma_map(mr->ram_block)   ******
       if ram_block is right
         vioc->dma_map_file()
       else
         vioc->dma_map()

>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/common.c       | 9 ++++++---
>>   hw/virtio/vhost-vdpa.c | 2 +-
>>   include/exec/memory.h  | 5 ++++-
>>   system/memory.c        | 8 +++++++-
>>   4 files changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index db0498e..4bbc29f 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -248,12 +248,13 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>   /* Called with rcu_read_lock held.  */
>>   static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>                                  ram_addr_t *ram_addr, bool *read_only,
>> +                               MemoryRegion **mr_p,
>>                                  Error **errp)
>>   {
>>       bool ret, mr_has_discard_manager;
>>       ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
>> -                               &mr_has_discard_manager, errp);
>> +                               &mr_has_discard_manager, mr_p, errp);
>>       if (ret && mr_has_discard_manager) {
>>           /*
>>            * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
>> @@ -300,7 +301,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>           bool read_only;
>> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
>> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
>> +                                &local_err)) {
>>               error_report_err(local_err);
>>               goto out;
>>           }
>> @@ -1279,7 +1281,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       }
>>       rcu_read_lock();
>> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
>> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, NULL,
>> +                            &local_err)) {
>>           error_report_err(local_err);
>>           goto out_unlock;
>>       }
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 3cdaa12..a1866bb 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -228,7 +228,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>           bool read_only;
>> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
>> +        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL, NULL,
>>                                     &local_err)) {
>>               error_report_err(local_err);
>>               return;
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index ea5d33a..a2f1229 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -747,13 +747,16 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>>    * @read_only: indicates if writes are allowed
>>    * @mr_has_discard_manager: indicates memory is controlled by a
>>    *                          RamDiscardManager
>> + * @mr_p: return the MemoryRegion containing the @iotlb translated addr
>>    * @errp: pointer to Error*, to store an error if it happens.
>>    *
>>    * Return: true on success, else false setting @errp with error.
>>    */
>>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>                             ram_addr_t *ram_addr, bool *read_only,
>> -                          bool *mr_has_discard_manager, Error **errp);
>> +                          bool *mr_has_discard_manager,
>> +                          MemoryRegion **mr_p,
> 
> There is a risk that the life cycle of the returned MemoryRegion
> doesn't match VFIO expectations.
> 
> Also, it seems that memory_get_xlat_addr() has reached a point
> where the callers need refactoring. 'mr_p' would be the 5th out
> parameter and 3 of these already depend on the MemoryRegion
> returned by flatview_translate().

If we return mr plus xlat, then the caller could trivially derive
vaddr, ram_addr, and read_only.

- Steve

>> +                          Error **errp);
>>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
>> diff --git a/system/memory.c b/system/memory.c
>> index 4c82979..4ec2b8f 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -2185,7 +2185,9 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>>   /* Called with rcu_read_lock held.  */
>>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>                             ram_addr_t *ram_addr, bool *read_only,
>> -                          bool *mr_has_discard_manager, Error **errp)
>> +                          bool *mr_has_discard_manager,
>> +                          MemoryRegion **mr_p,
>> +                          Error **errp)
>>   {
>>       MemoryRegion *mr;
>>       hwaddr xlat;
>> @@ -2250,6 +2252,10 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>           *read_only = !writable || mr->readonly;
>>       }
>> +    if (mr_p) {
>> +        *mr_p = mr;
>> +    }
>> +
>>       return true;
>>   }
> 


