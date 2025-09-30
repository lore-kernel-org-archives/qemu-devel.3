Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819B6CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cIA-0005G1-W0; Tue, 30 Sep 2025 11:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3cI5-0005FI-15
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:29:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3cHw-00088r-QH
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:29:19 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UETg32008169;
 Tue, 30 Sep 2025 15:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=HILdFnqbEjoDl8GX+SEb4fvb5KK9uRlZbXQeutNJgt4=; b=
 sj9dW0ZN9ee0vsqQfAp0SEbVlJ8g8zMR94qBgpFTNKWInA12fHx0j6F2LrtmeEZG
 xdVbseXo9cyWjDHgRVJLcVAuOf/C5NH9p7v61jwSCmWMJOfWOzfg+9u0hy9pblT3
 9Ud/MNqzMBBneWiLMOlDjwNRP4q7SGTJ2oNJ9PuVj5JRF6Hv6SVNJfk/gZI4ejJD
 Tr9PjZ5EFlJkWJsCaOad2DUP1GqRxJpmB5zT0s1/+w4NVfqxyrIBHpyDS8eCHiDv
 oPRWoyxVHLDvg+asfGFGaamnMqZsSiCPbIPuP+6KbfVcKrJu1dHT28GcGlHHpK91
 XrpfwI90zEkedaj2rgP8HA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gh0y065v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 15:29:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58UEgCbF027037; Tue, 30 Sep 2025 15:29:07 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c7ywcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 15:29:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRKNQ0BfZ0lkYqh5i9WADngbP5QY1oMho91hTt8yIy4lHwEH6XCgWEc/Eis9jO1w3f4aN752RR8qKR+GeNatDAHdq9M897sESGER5Orup24ENDZZqDXMvFA6WGuVhwePvaD2SiMSfvbO6Yqes8jMXjL9qUXJVxRIIolz1n4pwKNjJiGGyePO1TO7yI0qkBAsh47JO1Q/X7nGzzi3NHSVO2mFuG8Dl8Ow7SmT4HWL0TXBqgdODvtJEMVJnDi8t31/K1ry8Z/wxjAIcLP7Ne3XH21Dr3M4w7j0/bt7BbH6NNgWsAB/Vye0zmO8T/azACBfg7oA/uo+x3GbkD6CyVRkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HILdFnqbEjoDl8GX+SEb4fvb5KK9uRlZbXQeutNJgt4=;
 b=rHR5DEGBkKhEQTFp5mlTXbGYUmMlKIx5StmYfwK1vJYkLDVkzOEmnTYMz+CbhxGwXAN5rk/HfV/gxE/ex3Sx1r88mpVfeCs0hviMh9oy6PaD26tz6GWmvDi0LoGA+GNMl2GRWGReIWYqaaldPDZmrUtxQuv8VUtJ7U01Cipfs0c4mTCpkPzaTqxujCXgXJNu8tOs6J1rdFN6TqnBxR+oJJ+uwjtV9nQOROr9RvZpUfsQXjCGixe/pZtR/k66kYkCcChUJ1Ncxg2NVeZjlm4fKnzIySVHMJyWKuQNJFZ4P9Tkuq1N7hVlGxzYAfhiQ8cTcSu8Y+z6NSF1hNJ6NzwN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HILdFnqbEjoDl8GX+SEb4fvb5KK9uRlZbXQeutNJgt4=;
 b=ImID9iA6GHIXBOtBC6twtd9PmoS6Z7KiSDkjUkPlr6td/ZQ245Z8WrSH0vTSOypluXDQZ6sCJjt7UVqo5gi+EiHkheQt6x9QzdA6HkCN/JmmzJDDo5JygG0a5Bwdo8p6AwpJS26TQ/WrIxyYS6mxHuzYyBD1dCW5QInls8s0gO4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH0PR10MB4954.namprd10.prod.outlook.com (2603:10b6:610:ca::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 15:29:03 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 15:29:03 +0000
Message-ID: <7bc0e3f9-f4c4-4088-8ade-4c8cd7c0835c@oracle.com>
Date: Tue, 30 Sep 2025 11:28:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/8] Live update: cpr-exec
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH0PR10MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: 1835fb20-f29c-4ca1-d7e5-08de003615f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1JMQ2xjeVlPRmkwVVptd2plT2JSckpEZ0ZwWklEQmtVbWZhZEQvTkt5aFE1?=
 =?utf-8?B?ZHgrUXFPcFNsZ3BLcTBjTGZzT242NTdPaEhMdU8rNGtSWDhzbTM3RG9LcGE2?=
 =?utf-8?B?UlZsOGRwVUcrZVBQelBxZVE4WFMrbVYxUVhNa3dSQi9Sanl2L0NobnpLSm5Y?=
 =?utf-8?B?ZGdRVVJ1eC9kd3g0N0ZzSHo3YmRBMGQydjN5UVJSUGxqOVJMcURabUlYajNL?=
 =?utf-8?B?a25UaDcyUmlHWTQrdnhRL04vOXFsWFUwdU1QK2hRRUIvOHU5NjB5ZzFhYjVZ?=
 =?utf-8?B?QXBuV1hVeFRZTnZhYXVRY0dkWU9BaGovZUN5ZXdlQWRLZGZ3cVdsaUhtZjRE?=
 =?utf-8?B?aWZCNzZac21yQ01ndWdqelArQzBIZGcvMkxDQTBhZnptVk9yMGRWdnNkSkxy?=
 =?utf-8?B?eE9nRnh3R1YweXVlZlMyYWtPR3MyYVhMclJTeWxrM3pacU10R2tCTlhWKzVW?=
 =?utf-8?B?TjFxVkNNSnplUjJMa1Uvck1jKzd1YnNzcFhKTkQwMjV6cHJnMmU3eGRKQzEz?=
 =?utf-8?B?cWpRS05qV0d1MHh6NzlMU1VZYlgvdlRrN1dpTjlsWnVTUFViSGZTRkJYdWFG?=
 =?utf-8?B?SGVYRmZlSm1mVi9kWm15a1J6UTZCUVpPc1J4c2JTZnFRMWh2TG9lRjF5MUJH?=
 =?utf-8?B?TXRKWXk1dXlyZlBnVkhoVG05UkkzV0UxbGVYdm12YXFSdXZ2VFk3K1hrUnFy?=
 =?utf-8?B?NlE0aE8rbkVGdEFQL1o3VlFnTlM3N3R4NWVZYzVlN2l1bC80dzM4bVJtczRt?=
 =?utf-8?B?c2ZvMzNiTGgybWZBNG9kclhKY3cxUDNud2V0V2UxQ2gvUi9tNnd5OTE3YTZn?=
 =?utf-8?B?ZGFWdUtiN3QyRUNTSjBuU1JDOXA5dTAzay92V2g1aVp4U2RBaU9UdWJhNlRC?=
 =?utf-8?B?aUE5OGM4RmFER3c4alczbmpCQjl6MEhraWgwMDVuVnpMVGJXQnB1OXE2dVhK?=
 =?utf-8?B?T21vYmpxcU1xUVZNOC91alphYlVwdVZJNUczekpxZFFPYVRsUXVDbU8yQXIw?=
 =?utf-8?B?WkpyRHNLWTgwSE5WakRsSlBIK25Jc3NsK0FrWklyL1E2bFJHT1lqQ21aTjNa?=
 =?utf-8?B?VytGbFNnZXJiYmo0NkF4LzV5TEJyVVRFTGo0cVY0M1g1cWN1T0hXNHByODdr?=
 =?utf-8?B?cVlvZS9IMjVhYWI0RlFscU56MVVVZDRBU3d3ejBYQ2RzNUs4QWlYcmtUMThZ?=
 =?utf-8?B?c1d3UjVqMTAyVE1zWTdFamRuY2UxQXFuczF4K0ozVnVtK0N0WXkyK2JWNndM?=
 =?utf-8?B?dTZXWTBwd05YSmZNSlU5bnNXS1FmWVN6NlhtOUw0M3FJT3VpbDdwODRJSjdq?=
 =?utf-8?B?VHlxSVdVaGFPZW50SVRqejlKQklYSmlzc1FpcDRWd0k2ZklEMzlFdm9TTSt6?=
 =?utf-8?B?aEtUajlGdEhRUmFtVHhOTnZ1bGZVRGJsZklsaE1jZnY4T3duZklPZTNuVGt1?=
 =?utf-8?B?UFZMT3VuckgrUUpRY0FmQ2VjUGhIblFFS3A5b1cwaWxUNThQL0d4TndoblJX?=
 =?utf-8?B?bnpWRTlsZ2tULzQ0dnZwbDVsVmF3YU5tK1FING4rbndMZmJCQjZnbnpLYlVS?=
 =?utf-8?B?ZlNDZk44cThoSjlxYTM2L1BBNnRGNjNhVjNFOFZ0WkFDVVNJUGZCbUExTFVE?=
 =?utf-8?B?QXc1cytEcmdhTmtOa0xoUDJSaURtVFNTaWgxcDVFVHFBRXh1NGZiaW0yQ25U?=
 =?utf-8?B?T2VuR0dMd1k0VGVJS20rOXROeVZOeVo4YXc2dVN3WHVZN3B0bHJaejlpOFlM?=
 =?utf-8?B?alJFSVpLSitkbWtiWlBybGt3T0lrQWlvM1ZMdm1nSDlBdUR3ZUFmWWNFWTRQ?=
 =?utf-8?B?aERNNWY1ZzBjUVpSSXd0NTdpMVRSKzJJQVVqd05raVUxTDR0cEpaMXFDZmxG?=
 =?utf-8?B?MGlKNlBUK2VoUTBxY0V2cFBpRUhyM2krYXhqc0NYM3RyY0JZNnVHZ2RBZlRH?=
 =?utf-8?Q?Vf29M9JXUee1BS2GTl0g/9Cfvp9klYiU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjdFdldQOUh6cTM5U2prRU1zcXpoUHRGWEp4SGx3WTRKSmEzc01KMWtpZ3k1?=
 =?utf-8?B?TVhQZElZb3VsTXAySlRVZzFIQk5KWlNvY3RZVFNQYW5UaXJsRC9sY3ZVSE5Y?=
 =?utf-8?B?RW1nbE11V1NzVFFpeGpCWU9UYWlTblJzNWlkVmkwck0va29haGw1Q1lUSkgz?=
 =?utf-8?B?d1I5U0Z6dlBoQVpIYUpFeFUyWmdKbTB1Q1p4V2dRQ3lFaUR0blV3bW54bk9W?=
 =?utf-8?B?aEZlODRoTHZnNzB1Yk1ZcHFJZmpnc2NSVk5uS3FBWmc5MWZmK29vb2NKSDZJ?=
 =?utf-8?B?YTFqZEEzYVgvYmtrSjNDaHVRZG1WVXN0ZHhsUjdvUi9Db25jMXJRNEJhS0N1?=
 =?utf-8?B?cEdKYXhNaWpzS3BTMmFxcVJWWjhITFhPK040dk5TdzYrcjEwL2pBdFhaQU5N?=
 =?utf-8?B?Rm5ab2RtdEdyTyswK0FZbkJ0cEUxR1RQZDRkUTc3Skd4YzF0UWlVM2ZNWXA0?=
 =?utf-8?B?M0tQbnA3Wjd4RHdndWM2RWFtMVYyejNpODRkTUNBT1hqc0I0bmVHVm9qVmxh?=
 =?utf-8?B?d24vclpSU05ydEh0dWltTUpQdGpNYTVrcFNlTEdVeDVEdkE0djIyMzV0YW9N?=
 =?utf-8?B?NkpWZFRJOE51aHNKUFRyb0s5ZmlhV0h3U3dhbXBQN3VzaXJXUkwvMHcyOWhS?=
 =?utf-8?B?RUJMZUM1OUd2MzcvZERRRnpGaU9LWmtybTZkS1prQ2VMV3dUMGlxRk5lemd6?=
 =?utf-8?B?eWdpQ0xRMHBZMkFvazZUSlpyTWs4N25sZ2VoWGFXRThLTnFkVlgwU3V2K25O?=
 =?utf-8?B?WCs3VGFudldYYTEvNHZCODVzSUNhQVh1a0N4TVEyWmRpMFZadXc3Q3lPdnln?=
 =?utf-8?B?emF2WVo5b2VTTHh6MmJPT0FmK2ZxZTFsbC90K0JQeVpuaE9kU1pCaDBSb3o4?=
 =?utf-8?B?eC9ZRU1DbGhpUFB3amRxUjFVd0YxT1hCZzFaNnFCY1JjS3M5K1VpVURiRkV3?=
 =?utf-8?B?cWw5ZktTZFhWOE1ZdTg5eGpWY09ESmZmWUV1bHRwT0taNS9rQnQ4SHFpV1hY?=
 =?utf-8?B?R0NLRDlUVUNnZDV1ekNqN3l4MlBEQ3lNQlkyOWY1dmJHL2JtaHRKWWV1TkJK?=
 =?utf-8?B?ZlROYkJtYXFLMituRS9sNndtOHRNZnJjWVJBNDJScG5wK3JLUTRtSlZqQUdy?=
 =?utf-8?B?QVJSRFZJQzdKR0M5cUhvazN1aEdkVzlrYktpVTNtSG1oR3QyOW1TaUQrVXov?=
 =?utf-8?B?NUg3U2tUcnA2WGlGWGRHT2FKZ3UycnFUQmN5RitRUVVpdE5Bdno0dVNEQjk5?=
 =?utf-8?B?b2VpYWh2L0ZrUGdjMnJZZFVTSjRkemwzbTBNRnNrODdnaGNOV0prd2x2SGxq?=
 =?utf-8?B?R2M0OWlrUnpuZjljb0FMTjJaNFUvQXM5SHBjeXpNcjFLV3VkakE3Ujl4U0lu?=
 =?utf-8?B?SUtRR1pOTysxOGlwRlNYTGl6T004NGcxQVdhVWxXL0Y5SVhGZjVWNEF0RnBx?=
 =?utf-8?B?QjJHT2lNVmxwZ2dHTHd1em9rUzJCdjhJSkFPcnE4amJyOWc0aVhudEtEck9Z?=
 =?utf-8?B?aE15ZGxScUlWUkMyQkI5UmdmTDFwYlhUT3NyL0x4M2dEbFAzVXRKODhHbTFr?=
 =?utf-8?B?SSsvdERhQ2J0TUh3V0tCeUhWQ2NCelo4bW03MGVrZlBoc1QvQmUrTmhyS0Vo?=
 =?utf-8?B?Z2Y4TVFBNGJkRGVVbXdtSGxrczI3NzFrV0lRNHRDN3Z3dy9SS0dGSllSTmVM?=
 =?utf-8?B?RWVlTkV0NVhPUzdHSWU0MCtpd0w0bTRnT2dERVVVWjJlcUc2cTZNVGM0b2Rk?=
 =?utf-8?B?VkNXdkdUS2VCVHFYbnNrNERUOERmZVRTSC94dmtOYmw1aWR3QUM2MFQ1R2M5?=
 =?utf-8?B?allNK3BiZGhlaUZQK2R1OGhEUFZvQitHYzdrNXVUT0ZOd0dVMUFOVkxIUFl3?=
 =?utf-8?B?d2MrTlV1aloxWHpXYStwQVUzdU14MmF1cGI1MkxjKzVYVWludTVuUkJPRHB3?=
 =?utf-8?B?anNwZEJHbEdhQ2JpZ0NpNzVYYUIxZXkvYlgrU2Q5ck9PWnZiMnl1aE9CcGNk?=
 =?utf-8?B?YlZDRjJGZkNXUTcrcTlOZ1loZEZYSklucGpjcmFFb202SUVsRlFFRi9QUU9t?=
 =?utf-8?B?OGhESUVVVlZORjBhbjR2R3ByUkwrODlNYlJJRm9idEMyd3plWVcwWHRZMUtD?=
 =?utf-8?B?UUFFcW1ydlgzc1JJaEY2MkRQOGU4RTk5Q0hpVzNibXh1TTdSV01OaFIxc05r?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7eHpt4DLRcBEkUJtk5n/QwxDB/x2jZzRyFWBk3sBFQIua73H9W8MEHM/2OY+NKj7BGo6KyWRqQw10bzXSx7jXeUR5A30q+QNjXhAOZ3JtJAR1xJ7mdxqkRSZicnc5sIfjg9l7qnbQLNukNP6l3df08M9c+aJVK47qCUV6chcWYO7Ft7Tmj0XyUYqx0cXGH0I/Zz0vb/MUSKkquvX/p+E6pIeGtGhL7g7U1U89+P2zJKn57nfWBcKLtCS9KvrZAcIN6WjTdoA/9QheI44FTTWtJfmyOaglnULs6AYqNPzGUJy/V9BKEQTXeQj7e+WlJXnN3oZilF0uwiqCia2cjTCj37E1Rv8L18f+Ll1YVvrNx2SC04U+Q84Vy0QGjgD7rpSrYIxa1TKx0P/8ySrbUM8wAsXqcKsi4pldlnQT+qDGo3JpwxuytSGgDr/Yst4w6+72GxZJKFdfdQiv4KYasicwA0tjjQ30nGuzidDHydlMn0y1jjK8VvR1OqcqGau14LFzTkFIUDlB6Vs4ZVvOJSO6mdcMxksVr0g9j9Ke8NhCmblcPVG2OPGvmEB4bEuKkR0LKYPpCUPt3porosN9loAVY2Q7kUSfX8381topSpD5WE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1835fb20-f29c-4ca1-d7e5-08de003615f0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 15:29:03.2147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gBMuxFC+Kh9t9u/sRHyX+i8aDkdzvBNswHl7+D58mrgE8+qpdNC1QbW2U3q66gYxlrZLlwsP9LnGjB4o2eULnKRp6/GWJ53QMYrwSsNhDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300139
X-Proofpoint-GUID: xTnAgc-gqT6sJ57muK47AhueBW7VSU8w
X-Authority-Analysis: v=2.4 cv=GqdPO01C c=1 sm=1 tr=0 ts=68dbf744 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=zlqD-3bIRykS4wgFEY8A:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: xTnAgc-gqT6sJ57muK47AhueBW7VSU8w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDEzMCBTYWx0ZWRfX9rhZm56K49DR
 jEm/ZSC4e+HINDozcbr34hVI6AbDhIlkT9WV7++RIInHIfbUzxM5ceHb4e/YHhr6ZPja99T0EyS
 W0h+SdpHUh5M783GT7j3kvq3UR2HK/FGnBozMiTzOwVoKu3Vn08aNth2Cd1rhaEaAewLtKuGcka
 auAhd1eEeHrAlFeOU66urKrV6X3oflN+FSCXQpYOEV2dELsIaFyRHro4BWWXWI4GMnkYrlNvVH0
 vMgKDIJqnRjtIrFm/6Rwxlnf50uJ663b+kgvERhYxWZBCtjmguD4yN8uND0XZcWLGvwhclRZ7Ip
 u0Fv6Uau9DfSfSVCJFFT/PMOxNjbjHZSiLaqjigVlHYv/Qk940MwEuV16lKfavWuQsVRujomQ4e
 fCm0awVoIOdUWn3um4cbEKK8WMXvBg==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/22/2025 9:49 AM, Steve Sistare wrote:
> This patch series adds the live migration cpr-exec mode.

I have received Acks or RB's for most of these, thank you all!

Just a reminder, these patches still need review from Peter and/or Fabiano:

   Patch 5/8: migration: cpr-exec save and load
   Patch 6/8: migration: cpr-exec mode

(And many thanks to Fabiano for reviewing the related qtest patches).

- Steve

> The new user-visible interfaces are:
>    * cpr-exec (MigMode migration parameter)
>    * cpr-exec-command (migration parameter)
> 
> cpr-exec mode is similar in most respects to cpr-transfer mode, with the
> primary difference being that old QEMU directly exec's new QEMU.  The user
> specifies the command to exec new QEMU in the migration parameter
> cpr-exec-command.
> 
> Why?
> 
> In a containerized QEMU environment, cpr-exec reuses an existing QEMU
> container and its assigned resources.  By contrast, cpr-transfer mode
> requires a new container to be created on the same host as the target of
> the CPR operation.  Resources must be reserved for the new container, while
> the old container still reserves resources until the operation completes.
> Avoiding over commitment requires extra work in the management layer.
> This is one reason why a cloud provider may prefer cpr-exec.  A second reason
> is that the container may include agents with their own connections to the
> outside world, and such connections remain intact if the container is reused.
> 
> How?
> 
> cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
> and by sending the unique name and value of each descriptor to new QEMU
> via CPR state.
> 
> CPR state cannot be sent over the normal migration channel, because devices
> and backends are created prior to reading the channel, so this mode sends
> CPR state over a second migration channel that is not visible to the user.
> New QEMU reads the second channel prior to creating devices or backends.
> 
> The exec itself is trivial.  After writing to the migration channels, the
> migration code calls a new main-loop hook to perform the exec.
> 
> Example:
> 
> In this example, we simply restart the same version of QEMU, but in
> a real scenario one would use a new QEMU binary path in cpr-exec-command.
> 
>    # qemu-kvm -monitor stdio
>    -object memory-backend-memfd,id=ram0,size=1G
>    -machine memory-backend=ram0 -machine aux-ram-share=on ...
> 
>    QEMU 10.1.50 monitor - type 'help' for more information
>    (qemu) info status
>    VM status: running
>    (qemu) migrate_set_parameter mode cpr-exec
>    (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
>    (qemu) migrate -d file:vm.state
>    (qemu) QEMU 10.1.50 monitor - type 'help' for more information
>    (qemu) info status
>    VM status: running
> 
> Changes in V2:
>    * dropped patch "helper to request exec" and use a BH to exec
>    * used g_shell_parse_argv for cpr-exec-command parameter
>    * fixed check for channel in cpr_state_load
>    * tweaked QAPI docs, developer docs, and code comments
>    * fixed doc: rename cpr-exec-args -> cpr-exec-command
> 
> Steve Sistare (8):
>    migration: multi-mode notifier
>    migration: add cpr_walk_fd
>    oslib: qemu_clear_cloexec
>    migration: cpr-exec-command parameter
>    migration: cpr-exec save and load
>    migration: cpr-exec mode
>    migration: cpr-exec docs
>    vfio: cpr-exec mode
> 
>   docs/devel/migration/CPR.rst   | 106 +++++++++++++++++++++++-
>   qapi/migration.json            |  46 ++++++++++-
>   include/migration/cpr.h        |   9 +++
>   include/migration/misc.h       |  12 +++
>   include/qemu/osdep.h           |   9 +++
>   hw/vfio/container.c            |   3 +-
>   hw/vfio/cpr-iommufd.c          |   3 +-
>   hw/vfio/cpr-legacy.c           |   9 ++-
>   hw/vfio/cpr.c                  |  13 +--
>   migration/cpr-exec.c           | 178 +++++++++++++++++++++++++++++++++++++++++
>   migration/cpr.c                |  41 +++++++++-
>   migration/migration-hmp-cmds.c |  30 +++++++
>   migration/migration.c          |  70 ++++++++++++----
>   migration/options.c            |  14 ++++
>   migration/ram.c                |   1 +
>   migration/vmstate-types.c      |   8 ++
>   system/vl.c                    |   4 +-
>   util/oslib-posix.c             |   9 +++
>   util/oslib-win32.c             |   4 +
>   hmp-commands.hx                |   2 +-
>   migration/meson.build          |   1 +
>   migration/trace-events         |   1 +
>   22 files changed, 538 insertions(+), 35 deletions(-)
>   create mode 100644 migration/cpr-exec.c
> 
> base-commit: e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6



