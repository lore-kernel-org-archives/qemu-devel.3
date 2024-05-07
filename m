Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6447FC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GsP-0001HH-EI; Tue, 07 May 2024 05:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1s4GsI-0001Ec-FM
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:12:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1s4GsD-0000XM-LZ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:12:36 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4479442Y008189; Tue, 7 May 2024 09:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/7jPnsM/tsNco0r2jUm7MXTYHr/StFi/xgbUxkWJJtE=;
 b=bf/V5gCjfnjfIIrI97I1eOrH5Ujko1HRCNZt/LUlbhpVN7tP4DrIVUGdQZIie0AIfjZl
 PT2sdjhR48c97pjzCFOdvwTqJtDrzpIUSYPr448oboVkyoPWqoyms3aZ9Z9HB+tk78Y6
 /SmNHeYX3h1un5WEKB4aUnLb+V+j3fAGzatBH9SDztRqCbitvgQ6KcoSJGca4XXRRc/c
 gsugygAfIar/vRPZEzn7gSw5RLSZZ2X/HqH4dKR8dvS0EhTU2UiqDL0N5mJ2uS0Hj7O0
 PTlhrTU4CDycZiROhzex+2FNRH63P+1FhBWBm7h3IwVt6Wtr3zzzkdIiaVAIMK7NVP2n nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbeevfvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 May 2024 09:12:28 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4477W1kM006878; Tue, 7 May 2024 09:12:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xwbf7rje5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 May 2024 09:12:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdXnqH4gHBWoEN/0gTciufzFeCr7AigzM8LaV4D9+yzIe6mozy5grjbTJ+lkKAn54AFWp/3MIZGSrhCdPKBdvor94/ZedD/HkuxzINEbWelxPi5NLmh3wT7/UizQFutDFbXsTdqqfvaFKLpbzYDqgjRIMKfawD1h42DAq3CJPsm8ba4AGPWfWIzToQyX57wGsXKe2YS68J2vEY3sR1XJqzyIquC5FftPdU5CViKskKnXtbCyO0JT9AdN4Hd5SrjuR68SPTWqL5HUjhgUYrjd0oKGCp5HJxKNrnNy2S+AEMd/kTic8w5YVKIR8fdmPZeOMCf9dkjAH1IBpRKigZX1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7jPnsM/tsNco0r2jUm7MXTYHr/StFi/xgbUxkWJJtE=;
 b=U5tPgPflK6ZMZMqJXnPG8TfQsqg0HoMSd5zcrl2XLzlWenmSqtFNu1gHnLfHnCc5WNthFu2EQ6MklVWj92dcZegSnWwy0l32yPZexeRS0vAFKPqNUTyaC7PQZZHtGwftk6AciNAtssUPnjUmfCqA+UnSgVgNXoHov66WA+eJOuN6Q/5ubLkY5DHBmM+PD0QXSImhHjATAUq2IiSxtApTFAIuiA55hyeuv99ffJYg3+A+vGEw5U2+nILsDls8XJrALfFz9Io702mscxleAzwUTep7esDsFgc6vl4Dglj7NNtiJ1/6HgE8VBAuwmMpX0RPRQD/Z+7/A7tFnByACDOACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7jPnsM/tsNco0r2jUm7MXTYHr/StFi/xgbUxkWJJtE=;
 b=I/IDCPKgAayEEDy6RbwcOwOtrKpdz8YyUeKqTTwJ77tBpSmJqkevrk5cnSwEgmXfrjY6S6UD6P2jzxtTIbrYY9M9P9sPpnMJNNyfkF/Xijq0FwJ1T1o2nPdUYd+4xqkDESvSgGp+m3HFtU9Mdt+aB7yfKXGJKTFhDTt+JMh8SVA=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.43; Tue, 7 May 2024 09:12:24 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 09:12:24 +0000
Message-ID: <33056041-8640-491f-952b-a03d33c49e81@oracle.com>
Date: Tue, 7 May 2024 02:12:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jason Wang <jasowang@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <20240410100345.389462-2-eperezma@redhat.com>
 <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
 <CAJaqyWeE3kfgN5Y0=Kj6oCOFwg0H-gQEr4g3TM+3_+5N7mfd=A@mail.gmail.com>
 <450d0da1-3d11-428b-bd89-d09a2964cdb1@oracle.com>
 <CAJaqyWfXNQJQdTcJ9V-mSUrMs9up7rpAMwyK-qB3BuJwbUw+5w@mail.gmail.com>
 <f2dcbc76-f90f-4abe-b5c3-f159befd07bd@oracle.com>
 <CAJaqyWeSrwVt6imakpccieqN_3C85JcOZuj=FR+Xnmr7FKFaAw@mail.gmail.com>
 <9f347cd6-8c18-4253-8a5f-efae08230a62@oracle.com>
 <CAJaqyWeyfPp5bh9iZrkwZshoStEHZ85P6t4TcEdmR5sDYhG4ug@mail.gmail.com>
 <1e1cbe99-65e8-4292-b19b-8e054f5b1fca@oracle.com>
 <CAJaqyWeGUM+HZM1-SdQfXmw_xw_tVq9Nns+EH_M8jbOQatXWTw@mail.gmail.com>
 <d708a088-6d20-4dd3-8167-fda21b2551ff@oracle.com>
 <CAJaqyWfVidfDgPZw45EpE43C+H16TEyXmQ6NAB-bSVNmXKyCpA@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWfVidfDgPZw45EpE43C+H16TEyXmQ6NAB-bSVNmXKyCpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::21) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS0PR10MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 7053dd80-a85e-429c-9f88-08dc6e75cf2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUMvWmE2dzQ5UW5ldko0SmFyZzVPLzFrZ2dsb2hIUzl4aFZPV29mNmswQWV5?=
 =?utf-8?B?anJRclZwdDZKcFNDQWpqa2hMelkvRGhwS0p0d1pyVnErd2Z6VXRYUXUzSkNr?=
 =?utf-8?B?UGRyc2NnU0l5MHlaTFdCUDNvcHY3dHNUQnBkcHYrc0hCamN6Y0FUbFlNMkIv?=
 =?utf-8?B?dThxbVZ0NkJuS1BFWExmNHBsTitlQUo5NGhvRkpOZEdnNjlsVnQ3Z3Bmc3ZR?=
 =?utf-8?B?NWlnNHpaU2hQMVMrakNIemliTkhjbkM4QWFkTi9KL0VGSzBpeG5rK1dmcEcw?=
 =?utf-8?B?VmZQSUVhSUNBMWVHWVBPdDVBb3hJU09hTnI2QmlkYTdCWFdBWGFnMnVQOHhs?=
 =?utf-8?B?MW1mRXFiZm52Q3RDRVNac1pFN2YySGo2RXlJYzJlU1Z5L3FtRzJMcUlxUmR4?=
 =?utf-8?B?QVNJTWNZZW16dGV0aVh3OEZhVmlaT1p0SkVVYWJ0SXZmQjNybzNNUzhXdTly?=
 =?utf-8?B?c04rZFpvQlFLQmVRdDUyQUtIYzA3Qmxxb1RySjlqUlc5bVlTRTh3cm9kZ0tE?=
 =?utf-8?B?Zjg0M2txZ05UNW01b2R2TmhMUUU4eE9aSE83b2FGVGNxa2hUSTZYVks3ekkz?=
 =?utf-8?B?TEdtaGZrK2gveE1rNUZ1bXAzQW81citvK3JNMGxFUGs2SVIwSTlwM0s3SU9O?=
 =?utf-8?B?MzM5T2NoY0tUV3Y5dTIxcEpqNG00K3dzWFBJZkE0UndxYk5jWkdMN044RlRy?=
 =?utf-8?B?czNyUGhxUm95ZzIydzJoYWpZMzByNTdwdTZRYWRCQXRxWENIcnhTaVptWmov?=
 =?utf-8?B?TklFYmdZOVJJSG14VEcvQU56NmYzWFJiVWFmTUEzVjd2N0ZOS0s3V09CdXph?=
 =?utf-8?B?RGJSdGp5TWZuaXFIMGMxM3kzdWluZEFIVldLNEVmTElzeUNWdnlYUUZzYVA3?=
 =?utf-8?B?SHNBczRXRkIrUzlPbnVuV2FrR0p2ZFJSZ3ptVzJMRzc0dG45ZEtock9vbjQ0?=
 =?utf-8?B?dFRLVGwvU3cxYmZjbVNLY2ZvOHZtU3BSRExkMll1bzZDaVY0WktpeDU1YVAv?=
 =?utf-8?B?ajUzb1c2VC9xQVFNdmp3N3FiTCtsN2JXZ0tnTDN5cHUvT1hsSWRCRU0rWFZR?=
 =?utf-8?B?bndYNExoMW9SYzQ5WjgyRm1zV2h1ZzcrbjdtT25SM202Y2VrTFZZbWd5b0xn?=
 =?utf-8?B?amVObUJ2YTMzRXNnZ2pOMnlPdE04UHduS05YL1ByQ2k0Q29WYlVHaXZxNFI3?=
 =?utf-8?B?QXJNQkVEb2sya2t1bVZnaFpERUs3TENiby9wOHl3ZU5qTXY1QmwvOVFqejVS?=
 =?utf-8?B?T280eHlGNi9lQ01WTHJPUzA1czFvZmh2Ym5KV1BBbFdxL0VSVTFjRmFYNUx4?=
 =?utf-8?B?b09BbWFoeDFzUlpOTUhHc2d2cmNGRFVHWDk5TEEzRUh5WXpJY3pRNEVYSnoy?=
 =?utf-8?B?bDRweHVZdUtxOW1lc3lmVVQrRkgxMXNFdEhLbkRaQXN3RUMrMnBkYVFPd3lo?=
 =?utf-8?B?UkgzbjhidGxWV2l3Nm1YKzAwNW40V0FRMEtmTStKbklGeTVMWHV0L1RadjVm?=
 =?utf-8?B?ZkxFeXg5cmFUV2t3aUhpYlJvODlXQmFwdFJwWFVrMHc1SHFDTitiU3M5SDVu?=
 =?utf-8?B?N1hkcFdtK3UwdnB1alMvRDlGYitPUE1seXc5SDNud3JnQjdEdldPVTlxSjVU?=
 =?utf-8?Q?FVyFtDogfWNZp/GaV6xNfPLDUGMlLX/0dHew4DzsXA/k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3J4VENOb0ZGNUJGL0ZBYWNsWXMvL1pRa2p2ek1Yd0pQYkRMVUdYTU8waXd0?=
 =?utf-8?B?SXljUDFLM1BuQmdva0FJK3JyQ21hZDhXV0QzQmRJTXBxRXdsMzRJemg4akEw?=
 =?utf-8?B?dENZZE1ZNE5VQktwSE5wMEdpUWxnbmpGUU54SnIwVnVEbGduS3ljWVNUNmlL?=
 =?utf-8?B?QWlHbGh0UGFZUTYvWnRvdGNPRWtjd3VqMi9MMXp0S3FDWXhtNnRPRU1KaXBM?=
 =?utf-8?B?YU14dk4rb3R6Y2ZZRk5GOGxNSXVJVzlyRmNIRzhqczZ6V1FwbGJEOVpqaWxr?=
 =?utf-8?B?TEJpd1NlVjZEVlJsOWNHTWlhUm8xclUvWFdyMUZMOHhqSXVqYnJ6dm5uQU5P?=
 =?utf-8?B?dkQwWVd5OVdTQ1dLdnZyMUJYWi9IRm43TUU0cUpCZlRNUmU2T1ZINjNzUmI4?=
 =?utf-8?B?ak1aSkc4ZmdSd0h6elBOK1ZSS0QxUzBPZW4zUzVkdUdYT2ZNemdBQlhtMXVm?=
 =?utf-8?B?N1JXVkt1NUhNUk5EUWFoU00zR3paMW9NdWJTR0l6eFRyRlBIMVQ5Y0NYdUdB?=
 =?utf-8?B?SjNKSndTaUhGSjhpN0V3MGdCL1dSc0VUMFZMaEVIYy9UMlJwVkNuc1NTbWpT?=
 =?utf-8?B?QWtqVVJXNkU4QjBqKzZsRVZkMFNKQzZYZDhtSXh1MU5jeXNOYVBrMEhNeUt4?=
 =?utf-8?B?NXdlWHdmZC9POHFaTWhZaW1TR0Z6NXNqMWpBSlh1WWdxbm5NUUExdmsxT3ZP?=
 =?utf-8?B?S01ac3o5TG9SSVBlMmM0V2kvRW5WSmF2YkVFRGdnb0o1aGFiYWxRVE1ucUgv?=
 =?utf-8?B?UFVUQjM1NjExMjRjQVRMVURGWEMxSzRLZ0syNDByN0lpM0haOE1GWEhlTTZR?=
 =?utf-8?B?a1FzRm1aeE5VQjFpSDJJRlVZeUhwQU9abmQ0VUhyS3VZQTd6QjBlNXdzbGNo?=
 =?utf-8?B?aTN4bUhJSGs2OVRKYThYZ1o4V3A2amZUU1FKSnlUVE5VTWNnbTBpUlVHb3ZG?=
 =?utf-8?B?RHhqS3RJN08zSVV3aE84d3VnT2xxU2VXdUgwTGZyb2VIc2JPa1ZEeHZkTTRv?=
 =?utf-8?B?MnFDYWNNRVJralVxQWdDZWR5dmxyK1p4bXU5ZDdMUkJmVnJFOVJZNTJZcHNh?=
 =?utf-8?B?eVdEd3NCUFliREZjN2JSeFlQZ2xkU090VDBoRkVpREo0UkNLM0lnOXBPSHkx?=
 =?utf-8?B?OVdRL01YRmpKeDRvWVNUNVU0UW15RTdNblkrUzdqYWZOTUhjdDdjbHhSeVNk?=
 =?utf-8?B?NmdpbTNSMWVvWDFhSm1Dc2VLWDFWTzdKUWpYcS9jelJBd0NJVHNYOFpVckc3?=
 =?utf-8?B?YXBBQU1TWGVnNzJtZ2FBalpYSmNOYXV6aTBYbm5yOFNaRHFsR0xnbmduV2pQ?=
 =?utf-8?B?RHIxYkpzS3FxZU1FN1ZSZHFHMDFJR1hucVVYdDBKY25ZMTRDN3Q2OFlmdGVs?=
 =?utf-8?B?V1JoSzdMZUw1WCtuWnRsYUpzTEpCalBFbVVKbklLWTBKcWUwTDNZZFRYTlV1?=
 =?utf-8?B?VmNTM2tQcUJsSVBibUI1K2YvOEljYnR4eTQxUmwvK2QvZXlUWFMwK2ppQ2hE?=
 =?utf-8?B?a0VsM0VlZHRCZS9BbnlpaHFUT3ZNdmVQVjhCdGk0WUt4Rk1HcGJ3NHZIWDBu?=
 =?utf-8?B?eWRlSklmbFVNWjdaMjRtcFRqNVVQcVNwMXgvTlhZQ0tJQkYzTC9MQUQ1aWpp?=
 =?utf-8?B?NFdsMmtnQTBvVUxEeEVZaU9ob3JzYS9icEZTdVkvdk4rcUZRNW5vV0cvaFda?=
 =?utf-8?B?dTNnZDF6RlhLM2xmT3JjWU1NeHZVc2E0VW5wRVMxTDF1Z1lxUkxQTzRTbmxB?=
 =?utf-8?B?b1N4ZHBSQkgyZkRyWmZrekpkaERhZTFaU0JYRDJMUzBnSUtkYzI4UFdiUmw0?=
 =?utf-8?B?Z20vdExNUXhXQWV4T3VhUG9RVmZ5TS9aeEpQeFlmWndZSytxVUxldm1Jb0gv?=
 =?utf-8?B?cFFkR2lSU0plQ3AzZDVvR2JYWDNLNDNtV05EV0VvenJkL3ducnhwamliUk1X?=
 =?utf-8?B?U3BaVHpWRWc4eDZNMHY5RDVvd0hSUmdVZUpOL1FFdFhoUWRLOXBtampaNXJW?=
 =?utf-8?B?eVR5VGVWQUhQV21aelNyVW9ocGVuK1U0dUxGYjMvcnhPRFhpZHFUWkxEbWE4?=
 =?utf-8?B?M2xIVFdUSnI4b09SbTV3a2tSdVcwV1VsMWRtaWY2S2dLTE0ySW02cVcwS0dB?=
 =?utf-8?Q?f/SqfGQm3al5Q2lySJeaSP+3P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jnWsE+uSQwfm7h1jUOALSovO5JAKfRw1sLNhwf3iDosqQIAX88VvQJ7eZZNblyRMD/GQeqkimysOJtnN6o7VFxcNghHErafkJQsDxoydbDmTih/XWFaXo7Cc53dayu0W38UU/9zvCCTkPbSgNySiKkG3rHFkpIRZkDX75I6R9VDH+AoyYjwYxQmzAlKFNbsCNB8yIqr1uasCU7Ufd2b6zNbWW8o+IpYz829SNU2HFRI1GPL4w/gT3bhVdDI1TWAaQNAiJJcVyzf9iiNLsZLRJEE99Y1Aiwzhl24Y8Detov3t4kMDDWTSJnHh8FDC1WtDXdHoKDuEydofTfpieBxPjXwJiz9d05IEY4eSP/1oGBjYEHCdtYjKf2hcI/22O34/DZXF54cwq3+AubN+0poIw3pTNdNGJHsSsiG5UXu6nh4hcIXBft9NOt0Zv9bKP/oqI/gmQY7JwPihG2YOkAOrtjmOBZCDkWowtyfnmqyT/dMviVz9aKaS3Pr8F/eMn4ALphDWyZeE+zbRab6fQ0+I0qJsAfw76r22vSLit83eE/7jWEPzE1WOWKt4SO+bYDxBOepX8c6NlqoUQtcImFa5Kvtim75UZhg4b/JogAcjfAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7053dd80-a85e-429c-9f88-08dc6e75cf2f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 09:12:24.7710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+iHMqb7r8nESNdyIcvi0i+MgF6ptZNTerazF0cuL36agx3FZH8bRktU5zSFwRy5hiOrcQI42i2bfGFVG1YELg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_03,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070063
X-Proofpoint-GUID: 3Yu3vD-KxoRw16CYFKeDvutytFTkKbJX
X-Proofpoint-ORIG-GUID: 3Yu3vD-KxoRw16CYFKeDvutytFTkKbJX
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/1/2024 11:18 PM, Eugenio Perez Martin wrote:
> On Thu, May 2, 2024 at 12:09 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 4/30/2024 11:11 AM, Eugenio Perez Martin wrote:
>>> On Mon, Apr 29, 2024 at 1:19 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>> On 4/29/24 4:14 AM, Eugenio Perez Martin wrote:
>>>>> On Thu, Apr 25, 2024 at 7:44 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>
>>>>>> On 4/24/2024 12:33 AM, Eugenio Perez Martin wrote:
>>>>>>> On Wed, Apr 24, 2024 at 12:21 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>> On 4/22/2024 1:49 AM, Eugenio Perez Martin wrote:
>>>>>>>>> On Sat, Apr 20, 2024 at 1:50 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>>> On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
>>>>>>>>>>> On Thu, Apr 18, 2024 at 10:46 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>>>>> On 4/10/2024 3:03 AM, Eugenio Pérez wrote:
>>>>>>>>>>>>> IOVA tree is also used to track the mappings of virtio-net shadow
>>>>>>>>>>>>> virtqueue.  This mappings may not match with the GPA->HVA ones.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This causes a problem when overlapped regions (different GPA but same
>>>>>>>>>>>>> translated HVA) exists in the tree, as looking them by HVA will return
>>>>>>>>>>>>> them twice.  To solve this, create an id member so we can assign unique
>>>>>>>>>>>>> identifiers (GPA) to the maps.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>         include/qemu/iova-tree.h | 5 +++--
>>>>>>>>>>>>>         util/iova-tree.c         | 3 ++-
>>>>>>>>>>>>>         2 files changed, 5 insertions(+), 3 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
>>>>>>>>>>>>> index 2a10a7052e..34ee230e7d 100644
>>>>>>>>>>>>> --- a/include/qemu/iova-tree.h
>>>>>>>>>>>>> +++ b/include/qemu/iova-tree.h
>>>>>>>>>>>>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
>>>>>>>>>>>>>             hwaddr iova;
>>>>>>>>>>>>>             hwaddr translated_addr;
>>>>>>>>>>>>>             hwaddr size;                /* Inclusive */
>>>>>>>>>>>>> +    uint64_t id;
>>>>>>>>>>>>>             IOMMUAccessFlags perm;
>>>>>>>>>>>>>         } QEMU_PACKED DMAMap;
>>>>>>>>>>>>>         typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>>>>>>>>>>>>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
>>>>>>>>>>>>>          * @map: the mapping to search
>>>>>>>>>>>>>          *
>>>>>>>>>>>>>          * Search for a mapping in the iova tree that translated_addr overlaps with the
>>>>>>>>>>>>> - * mapping range specified.  Only the first found mapping will be
>>>>>>>>>>>>> - * returned.
>>>>>>>>>>>>> + * mapping range specified and map->id is equal.  Only the first found
>>>>>>>>>>>>> + * mapping will be returned.
>>>>>>>>>>>>>          *
>>>>>>>>>>>>>          * Return: DMAMap pointer if found, or NULL if not found.  Note that
>>>>>>>>>>>>>          * the returned DMAMap pointer is maintained internally.  User should
>>>>>>>>>>>>> diff --git a/util/iova-tree.c b/util/iova-tree.c
>>>>>>>>>>>>> index 536789797e..0863e0a3b8 100644
>>>>>>>>>>>>> --- a/util/iova-tree.c
>>>>>>>>>>>>> +++ b/util/iova-tree.c
>>>>>>>>>>>>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(gpointer key, gpointer value,
>>>>>>>>>>>>>
>>>>>>>>>>>>>             needle = args->needle;
>>>>>>>>>>>>>             if (map->translated_addr + map->size < needle->translated_addr ||
>>>>>>>>>>>>> -        needle->translated_addr + needle->size < map->translated_addr) {
>>>>>>>>>>>>> +        needle->translated_addr + needle->size < map->translated_addr ||
>>>>>>>>>>>>> +        needle->id != map->id) {
>>>>>>>>>>>> It looks this iterator can also be invoked by SVQ from
>>>>>>>>>>>> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest GPA
>>>>>>>>>>>> space will be searched on without passing in the ID (GPA), and exact
>>>>>>>>>>>> match for the same GPA range is not actually needed unlike the mapping
>>>>>>>>>>>> removal case. Could we create an API variant, for the SVQ lookup case
>>>>>>>>>>>> specifically? Or alternatively, add a special flag, say skip_id_match to
>>>>>>>>>>>> DMAMap, and the id match check may look like below:
>>>>>>>>>>>>
>>>>>>>>>>>> (!needle->skip_id_match && needle->id != map->id)
>>>>>>>>>>>>
>>>>>>>>>>>> I think vhost_svq_translate_addr() could just call the API variant or
>>>>>>>>>>>> pass DMAmap with skip_id_match set to true to svq_iova_tree_find_iova().
>>>>>>>>>>>>
>>>>>>>>>>> I think you're totally right. But I'd really like to not complicate
>>>>>>>>>>> the API of the iova_tree more.
>>>>>>>>>>>
>>>>>>>>>>> I think we can look for the hwaddr using memory_region_from_host and
>>>>>>>>>>> then get the hwaddr. It is another lookup though...
>>>>>>>>>> Yeah, that will be another means of doing translation without having to
>>>>>>>>>> complicate the API around iova_tree. I wonder how the lookup through
>>>>>>>>>> memory_region_from_host() may perform compared to the iova tree one, the
>>>>>>>>>> former looks to be an O(N) linear search on a linked list while the
>>>>>>>>>> latter would be roughly O(log N) on an AVL tree?
>>>>>>>>> Even worse, as the reverse lookup (from QEMU vaddr to SVQ IOVA) is
>>>>>>>>> linear too. It is not even ordered.
>>>>>>>> Oh Sorry, I misread the code and I should look for g_tree_foreach ()
>>>>>>>> instead of g_tree_search_node(). So the former is indeed linear
>>>>>>>> iteration, but it looks to be ordered?
>>>>>>>>
>>>>>>>> https://urldefense.com/v3/__https://github.com/GNOME/glib/blob/main/glib/gtree.c*L1115__;Iw!!ACWV5N9M2RV99hQ!Ng2rLfRd9tLyNTNocW50Mf5AcxSt0uF0wOdv120djff-z_iAdbujYK-jMi5UC1DZLxb1yLUv2vV0j3wJo8o$
>>>>>>> The GPA / IOVA are ordered but we're looking by QEMU's vaddr.
>>>>>>>
>>>>>>> If we have these translations:
>>>>>>> [0x1000, 0x2000] -> [0x10000, 0x11000]
>>>>>>> [0x2000, 0x3000] -> [0x6000, 0x7000]
>>>>>>>
>>>>>>> We will see them in this order, so we cannot stop the search at the first node.
>>>>>> Yeah, reverse lookup is unordered indeed, anyway.
>>>>>>
>>>>>>>>> But apart from this detail you're right, I have the same concerns with
>>>>>>>>> this solution too. If we see a hard performance regression we could go
>>>>>>>>> to more complicated solutions, like maintaining a reverse IOVATree in
>>>>>>>>> vhost-iova-tree too. First RFCs of SVQ did that actually.
>>>>>>>> Agreed, yeap we can use memory_region_from_host for now.  Any reason why
>>>>>>>> reverse IOVATree was dropped, lack of users? But now we have one!
>>>>>>>>
>>>>>>> No, it is just simplicity. We already have an user in the hot patch in
>>>>>>> the master branch, vhost_svq_vring_write_descs. But I never profiled
>>>>>>> enough to find if it is a bottleneck or not to be honest.
>>>>>> Right, without vIOMMU or a lot of virtqueues / mappings, it's hard to
>>>>>> profile and see the difference.
>>>>>>> I'll send the new series by today, thank you for finding these issues!
>>>>>> Thanks! In case you don't have bandwidth to add back reverse IOVA tree,
>>>>>> Jonah (cc'ed) may have interest in looking into it.
>>>>>>
>>>>> Actually, yes. I've tried to solve it using:
>>>>> memory_region_get_ram_ptr -> It's hard to get this pointer to work
>>>>> without messing a lot with IOVATree.
>>>>> memory_region_find -> I'm totally unable to make it return sections
>>>>> that make sense
>>>>> flatview_for_each_range -> It does not return the same
>>>>> MemoryRegionsection as the listener, not sure why.
>>>>>
>>>>> The only advance I have is that memory_region_from_host is able to
>>>>> tell if the vaddr is from the guest or not.
>>>>>
>>>>> So I'm convinced there must be a way to do it with the memory
>>>>> subsystem, but I think the best way to do it ATM is to store a
>>>>> parallel tree with GPA-> SVQ IOVA translations. At removal time, if we
>>>>> find the entry in this new tree, we can directly remove it by GPA. If
>>>>> not, assume it is a host-only address like SVQ vrings, and remove by
>>>>> iterating on vaddr as we do now. It is guaranteed the guest does not
>>>>> translate to that vaddr and that that vaddr is unique in the tree
>>>>> anyway.
>>>>>
>>>>> Does it sound reasonable? Jonah, would you be interested in moving this forward?
>>>>>
>>>>> Thanks!
>>>>>
>>>> Sure, I'd be more than happy to work on this stuff! I can probably get
>>>> started on this either today or tomorrow.
>>>>
>>>> Si-Wei mentioned something about these "reverse IOVATree" patches that
>>>> were dropped;
>>> The patches implementing the reverse IOVA tree were never created /
>>> posted, just in case you try to look for them.
>>>
>>>
>>>> is this relevant to what you're asking here? Is it
>>>> something I should base my work off of?
>>>>
>>> So these patches work ok for adding and removing maps. We assign ids,
>>> which is the gpa of the memory region that the listener receives. The
>>> bad news is that SVQ also needs this id to look for the right
>>> translation at vhost_svq_translate_addr, so this series is not
>>> complete.
>> I have a fundamental question to ask here. Are we sure SVQ really needs
>> this id (GPA) to identify the right translation? Or we're just
>> concerning much about the aliased map where there could be one single
>> HVA mapped to multiple IOVAs / GPAs, which (the overlapped) is almost
>> transient mapping that usually goes away very soon after guest memory
>> layout is stabilized?
> Are we sure all of the overlaps go away after the memory layout is
> stabilized in all conditions?
In all of the scenarios in concern or I've tried so far it's the case 
actually, but on the other hand I do understand this is rather a bold 
assumption that might not be future proof or even safe for now. Put it 
the other way, if there's a case that makes overlap ever occur after 
memory layout is stabilized, then we probably should have gotten such 
bug report way earlier with the current upstream QEMU, without this 
series of change of moving page pinning to device initialization, right. 
Otherwise it's also considered a bug in upstream SVQ code base, 
but practically I have no reproducer that triggers the problematic code 
with overlapped / aliasing.

>   I think it is worth not making two
> different ways to ask the tree depending on what part of QEMU we are.
Yes, ideally we shouldn't do that. Just wondered if there's sort of a 
simple way to tackle the problem and make it work with certain limited 
scenario (e.g. virtio-net doesn't use overlapped region, or we don't 
enable SVQ until memory is stabilized). Given that we haven't heard of 
issue before due to the overlap case not being unhanded, just saying 
maybe there's possibility to keep that assumption (overlaps are 
transient only) around for a short while, until a full blown fix can be 
landed?

Regards,
-Siwei
>
>> For what I can tell, the caller in SVQ datapath
>> code (vhost_svq_vring_write_descs) just calls into
>> vhost_iova_tree_find_iova to look for IOVA translation rather than
>> identify a specific section on the memory region, the latter of which
>> would need the id (GPA) to perform an exact match. The removal case
>> would definitely need perfect match on GPA with the additional id, but I
>> don't find it necessary for the vhost_svq_vring_write_descs code to pass
>> in the id / GPA? Do I miss something?
>>
> Expanding on the other thread, as there are more concrete points
> there. Please let me know if I missed something.
>
>> Thanks,
>> -Siwei
>>
>>> You can find the
>>> vhost_iova_tree_find_iova()->iova_tree_find_iova() call there.
>>>
>>> The easiest solution is the reverse IOVA tree of HVA -> SVQ IOVA. It
>>> is also the less elegant and (potentially) the less performant, as it
>>> includes duplicating information that QEMU already has, and a
>>> potentially linear search.
>>>
>>> David Hildenbrand (CCed) proposed to try iterating through RAMBlocks.
>>> I guess qemu_ram_block_from_host() could return a block where
>>> block->offset is the id of the map?
>>>
>>> It would be great to try this approach. If you don't have the bandwith
>>> for this, going directly for the reverse iova tree is also a valid
>>> solution.
>>>
>>> Thanks!
>>>
>>>> If there's any other relevant information about this issue that you
>>>> think I should know, let me know. I'll start digging into this ASAP and
>>>> will reach out if I need any guidance. :)
>>>>
>>>> Jonah
>>>>
>>>>>> -Siwei
>>>>>>
>>>>>>
>>>>>>>> Thanks,
>>>>>>>> -Siwei
>>>>>>>>> Thanks!
>>>>>>>>>
>>>>>>>>>> Of course,
>>>>>>>>>> memory_region_from_host() won't search out of the guest memory space for
>>>>>>>>>> sure. As this could be on the hot data path I have a little bit
>>>>>>>>>> hesitance over the potential cost or performance regression this change
>>>>>>>>>> could bring in, but maybe I'm overthinking it too much...
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> -Siwei
>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> -Siwei
>>>>>>>>>>>>>                 return false;
>>>>>>>>>>>>>             }
>>>>>>>>>>>>>


