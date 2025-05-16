Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881AFC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 19:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uG0Zc-00083s-JF; Fri, 16 May 2025 15:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uG0Za-00082U-Mr
 for qemu-devel@nongnu.org; Fri, 16 May 2025 15:18:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uG0ZY-0000aH-9f
 for qemu-devel@nongnu.org; Fri, 16 May 2025 15:18:22 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GGfqud021929;
 Fri, 16 May 2025 19:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=NM/wBVeec+EVpRl8LPxeMTt1hODyN2oBcLLj1KbU0DU=; b=
 IfSWdEAq3iArVIGGFHi/S4TL9NO7DfOq5BSHd4rIokW4Wj47rv8ugOE2aQyzR62f
 RcwHzax4xNlGyt/FkEPvbAiwmHW+Xoi/vnakpH4ZIe8VIic9Mo53UdrYLmvecbRI
 zutfgc/DY4Gg1qMlI4UYRppaAi7B0FIkSghuIuJhsVcV90g6WylM2e0vyl2DEOG8
 7wtDBp5udwpCMajsLk+O7UfBWujJLUmoNROg2VL0zOkRLFaNS/WbrfBbL1BaVNML
 xhkCxWS6t4WGj4/t/XI/x6EmDafwhu8Tio5Ls9mhXlbiYNAtBZjWVjeJJgVWu32Y
 Op+43qbPD3u9JYiOsYnRhQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbj222c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 19:18:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54GHs9EM004936; Fri, 16 May 2025 19:18:15 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010005.outbound.protection.outlook.com [40.93.11.5])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46mrmfq883-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 19:18:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqPoJi+ch4haWMTvd+KVQC/4V/m/Y9u+OfqP7GLJjs7Kr6IOcM8ZNWcHvzM5ceOI5bt+VGowSg/PtnyUzse8OzgtB27RRWTeBXjJZHU/+5G+6/Shvvq4jNSloVeoA1hJ/A52+aCWFDeF+5TA5VpUlH4Mz6qD8x5wWe2sZDqpKmwWqUBhsfB5EmDis64Rnr9oxc02VGqjATbW+1pPXIuxYiV+xvIuspuX22/vItFgR/5oql8pbtTlnlQbyoKSAl499168bJIIdlxvZ5GyhZEz/wH49JyPTcB1wmrCIaex2qWjgJFMRpHw52zNZ1JNE0sBeAxl4QYFnoaW0RTSq6qjbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM/wBVeec+EVpRl8LPxeMTt1hODyN2oBcLLj1KbU0DU=;
 b=oPVH7hQtl8kkFqGsaJoZoCRD4akBLmCI0tsmJY8gxu39nm4WVTXeGrmYePksURfiT/ok6u9SiuzCJ6K7INlQCFbBAPmaxTK/1OMCmyRdphAkjZcjR8SHN9s2vs9QfT4HOoWfC1rMUMTwrWoB9X9SKKmPlXzCqaJQvXxBBJgEoKZArr14CfHEph2AN27XKjxtE2fAvsKkV5ZWw/wSGvDnhnr3CNirGb5dQD3ZkwzasgJnQ735FBEhMYEourfab10VK87PfjVJs8xw1Uw68RmicGB4DGocBLD7gwI+9m4gGbJo8g/cYpHlRr/sAF5KJtxjiQDJDoZShZtB4oV+8KcQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM/wBVeec+EVpRl8LPxeMTt1hODyN2oBcLLj1KbU0DU=;
 b=IdQnrpiw9L/9WVwlMiLjDmeEy63xWP1youiT33baife35jSh/RTgRrjZG0l69HPeYpGcR8GFICMsz9xw83UtvHzQdK+pSmiSWlWssH43vIApDELDkmi1+MyI2Gis/Mgr8pajNcKCw7fVvUOfGuBlEiF0Q+axFGcPkMqpYOdYMIk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 19:17:52 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 19:17:52 +0000
Message-ID: <562fd2b5-44dc-4e90-a4cf-b2425baebad7@oracle.com>
Date: Fri, 16 May 2025 15:17:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 24/42] migration: close kvm after cpr
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-25-git-send-email-steven.sistare@oracle.com>
 <9a664228-9a00-4387-b2d0-f7a428b52c75@redhat.com> <aCdyeKdIZaTqaEzY@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aCdyeKdIZaTqaEzY@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH0PR10MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 580ae1d1-f8aa-4b47-00fb-08dd94ae5a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFZMZEE4Y3RuaU1sRk1RazlvVThjTU85cXlUNVRxL3YzbEFoRzFaZmloVEFC?=
 =?utf-8?B?V3dZcndjVWE0MnUvc2o1Rk1qZVVKWjJ3Z0NZTm56djFlQytYTENVRENpeVcv?=
 =?utf-8?B?VjFSR1kva2tnRTVCQzlYR1RUWmtDWFBhbXdqNkQ1T3JQWGczejBEN2RLTkFa?=
 =?utf-8?B?eGs2ZGhTMmpOaC94STJMWGIvblcyOW1kSklZVUNXTXpINVdBTVFzWG80VFhJ?=
 =?utf-8?B?Rzk2K3o2OGw4Mm9FeW1Kem1XODNuWXJDcFVIRzJkQksrZUlrakRlVWo3Sk9W?=
 =?utf-8?B?cmx2S1VnaGtOdjdITnpxUUQ5alpRbmtQSFRUaGo3SG55MDhsc2dCOXNlMGU3?=
 =?utf-8?B?RFRpMW9Kc0VEbnB3emNmVnRlVFJFUzQvb0lpQVBJYkxIMy90RlpkTjdmUUtq?=
 =?utf-8?B?eHppQkhCcVYvU0Q2cEhHclN5aVE3N2dxNitVbDRicUIyT25BTWt3ay8ydmRO?=
 =?utf-8?B?S0YwTjh3WWRYeDZHd240dVJpZ2lCcjRtRTBpemo3Z3V3NFJDbWpBY3R3L245?=
 =?utf-8?B?dkRzODZXZ1lOVU1QSGpIOUwzLzFVMmpjMG52QTgydHViZXhic3FzaW1nZjdp?=
 =?utf-8?B?bDB3UlB4TWUwR1RHZXo1WmtNaWVUNzhod0RVVmFYRVBzd0RBRkVNZktKYU9w?=
 =?utf-8?B?MXBINTFGblpQTng0NUdQc3RKaVNNL0hCK0QzUmZCUDl1dXpSQ3Y5eEhxTDJr?=
 =?utf-8?B?Z2hxREtpYmFCZXEzSnEyYzhMbEVuSG5lRnZRa3BZUWIxMXA3MmU5TGxSZGdi?=
 =?utf-8?B?UUJtL3VLd3BGVnJCVkcyeUx3R0JyQUJQMmZMc1prMDdWOXFOTnN1RjZpNURo?=
 =?utf-8?B?dXg1cXlad0s5UVhPYUhBalRyYWMzMlVlVW1POEdtUWZMM1E5TWh2dEFpVUt4?=
 =?utf-8?B?MTh0SXlVWXJDaWpPeDhjT3lKTWNXdklnT3NDM3YxTlV5RWxSeXFtVUt5SUE2?=
 =?utf-8?B?SGFDM3pwZDlEaVRjejdxUGkySEgxS01PTDVOalZJVEtiRktQNTM1TExDMytO?=
 =?utf-8?B?bEI5UlRHQVJwa0Y3eHVXNkluNFRwR3lxRjFhek1MMDlyTG9GZzZTS0hmT2VG?=
 =?utf-8?B?bzdBSkxDQlNSemYzWnZHajZwckQrQ0tHRFZORVpncjdHdGYweklsOTlsM1l4?=
 =?utf-8?B?TkEybjRwaFJtbk1SV1N2ZFNTVEFKUXFGcFJuNnkwTjM3dEUzNGZGWmFYUngr?=
 =?utf-8?B?TUFNVmcvanF3YkZIK3RmdG5nYlh6NDhIUDErY2lYN0FCR0RkZjYrdVB6ZDVq?=
 =?utf-8?B?c1lxSFlCMy9Eb3VZMW1lRnV3OU93MkU2ZjR3b2VUUGNmNzRSNUx1N3F6Y3dq?=
 =?utf-8?B?clEzK0lkeUY4a3M0dHF6VzAwNGx6RWQwN3ExalV3TFVYWGxJNUdoUEJ4ckQ0?=
 =?utf-8?B?REpFSkVNbDlaNG1kcnppbWJuamVDQnJJSUtyVmp3VUJUZzhaUW5hanR0Vkxi?=
 =?utf-8?B?bllkcDNPaE04WHZDd0NWelJZLzRiTnhzRzAzMnZiVXl6NGIvNlVIWWRqS09K?=
 =?utf-8?B?YWFZOE9qVEZBNE8xQ3pYVThhOGdNRW5ya0tZZkRBM3RPZk92bjk3ZzVUQWhP?=
 =?utf-8?B?bE83NUtHaVVqbGdNeGVGSjN3U2I2R0RnWlViR2tlQ3ltd0I2ejIwNFdjVjdX?=
 =?utf-8?B?VVQyVzVJbTlwaU5NVVhlNURGWG4xalJIelJBNGs2WGR6UHhDWVlBbURKR1gz?=
 =?utf-8?B?L2tSRzh4eHJBTytraDJMdmQvVEdmdVVVa1JNU2J4V01IY0YrOHlVbWNiTkda?=
 =?utf-8?B?SHJUSXpTT09EV29IVVV4OHhrQkZBN0hPenZMUlFGU0RBR3F4djIwdk9oUi9o?=
 =?utf-8?B?TzFuNzFVVVRSZDNxeWFyYTc1ZEc5Y2JMRjlkQ3UwQThxa283MTFZOG9DQlZu?=
 =?utf-8?B?UHlIY0tJNFB0MTF6blNPT3RTWllhSGtRV1VrMGJ1NXdvSFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zzd3WU1SMFBlaHZrbU5wWVEydGQrajBRWW5DemtCcW9oc0hiL0w3WFVNY3dn?=
 =?utf-8?B?SXh3MXVGLzdxYko1Y2RQNUdKTnpiKzdxalRyTEZFczRpRmFtQ0VpQURRUGJJ?=
 =?utf-8?B?Z2NQVzZkbEZkY0pybDBWeTFLdEU0b2QwTmhaRVk2QmY1dzJPYWs3Mmx2LzNE?=
 =?utf-8?B?Ri83akxyNExjS2NHcndHR0hTVEZwRjNWYzV3UDlLZUJKZHh5dTZ0dDFtd04x?=
 =?utf-8?B?UFgvR3ltTzVMRDRrMkE4bEtXVFlIUzlMUXlvRjYxOThxY2xnS28yS0d0RzdN?=
 =?utf-8?B?OVExK3NobnFvQmdMSlQvbmU0eHJ5NTZrVVpTbDMwZUJnS3NMKytXOUtpZ1FJ?=
 =?utf-8?B?UUNoemtoRmV5eFdBMkZUQUJ5WWxkSmZiWWt4VGpSWFQxTVZCMlhOaGxldkVG?=
 =?utf-8?B?Z3VWcGNhK2xlQWd5dW5Rd25TTnppdUNQUis5TEJSa1VOM0h6cWd2WlVDWnE3?=
 =?utf-8?B?YVB6MjZiVGNzdGc2SS81dk15ai9URytPVEZKNi9tRWFGUmxSSWtybzBNdVdI?=
 =?utf-8?B?eEpvNXlZMGUvOVRMeFVPbHNON2xkd09lbzlWTkNNYW5NbTRNYlRoTDA4Wk5i?=
 =?utf-8?B?dzVNYVlYWll4RjBvODV3eEdMQUNFdmxIZURqYjlDWXR1bmtZY1l1MmdCN2Mv?=
 =?utf-8?B?bStCZTdoSngxYmdJYlRYQ05zSUMzcnV1c1A2cTBhcUdBODBKNG9hZHplU3Fy?=
 =?utf-8?B?T1NMZjhkK0tZdVBsTXo3eEROcWQvektLVTRJQm4vanFZMUZkc3REOFp0WldG?=
 =?utf-8?B?MGRwM2pQV05SN0xIS2xEZFBiRmVpUnpBbzluRm9EQzMyZUo2ZmZEcXBCTlQ0?=
 =?utf-8?B?b25DamRsSmVvZmZhRDVVZTNiQzkvS2o4ZFo0ZHJwQi9GSHdsb2ROWUp4Vi9p?=
 =?utf-8?B?M2w2YUVFUGkxb0tIeTVNV1RqdUYyb0tUMklFZG81ODFGYnlIMVFwV3RmL2Vv?=
 =?utf-8?B?VElJUUlJaFVIbnlSa1plNmZFRFpSRXZvM3FzWTcvZVNvK1ZOYk1vMGZTcDZP?=
 =?utf-8?B?SisvMDdSYm9ocTEyWStkNXpSOGdnRHZENVJ4OXJxaUk5NVF2NjlheCs5ekh2?=
 =?utf-8?B?ek9XdGhEbnFZWFBLaFBiQjAzUncyUTlldzVRd1p2c3hsL0JQSFFFcCtPMVIx?=
 =?utf-8?B?ZHVzZVkwb0xuZGdBdnA2SUdXNnllNEd2Z1p5T0dJQUR2VUFCc1NITm9HR3lY?=
 =?utf-8?B?czdSRFpKV3VLRGFnOEZJMG1uNTJ5emtENDRzaUltS2lhaHpYdVhZaEZxa2ox?=
 =?utf-8?B?eEhDUzlkL0NQTzBUZDdLY3A3NWpVMnByZzl6WlI0dVBhS0ExT0ZQclZOUytO?=
 =?utf-8?B?QS9RU0FIdSsrcXNjWFlPeVVjZlVna0RWM0JRKzdFMVdnb0l4bGNUbmZLbHhr?=
 =?utf-8?B?N2ZMS3gxUExxcitISmwrZENBUkloNW9IQlhFeHJtSXdyWEVkL1V1a2h6Y083?=
 =?utf-8?B?TVZ5RE5sVFM0a2o1cnBnbnNKaDR4RDlRQjM0OGRXdWZTTCtSejdjNE55dnVG?=
 =?utf-8?B?akIrM2hHUkZabFc5ZG5UZ2s1cURHVlBWa2ZkNGJsVVFzTUU1U1dNbGw3TDBh?=
 =?utf-8?B?Yk41bHhkQm03N21PMjkwVEdRVk95dnQzbWhiUnUycWpodzU3Y0QzeFgxWXo1?=
 =?utf-8?B?V2hRZjVGTDgrODhyNWs2K2czeDVzaU90YVVqWXFTMGw4R3U5TkVRUVQxTEx6?=
 =?utf-8?B?OHZCY3dHYVlETWV0TThIc0ZNYTBVNjlKK01kZndhOU52NmVVNGc4Wm5PdXBw?=
 =?utf-8?B?Y3JCQjFUREw2ZVFDSHhMMStBS3Yza3VGc2g1VjVwNFNOWTVJWmNLNE1ZalB0?=
 =?utf-8?B?UjlaKytHYWJObGx1N0ExcE9xRDBhSWprZFRVVXptQWpsMHJNdHF0TkZTNm9N?=
 =?utf-8?B?azVlT2F3bUUvbEVkQkNKUDRqWVBWNVRkbGhTTzNMcEdkckhaUVBjaGs3Mzk4?=
 =?utf-8?B?N1Z1YzA1dzhoVlJ3eVdjaVdzMlJCQ3FMOTh4Zk5aTmFGbkNBdUlXRmwyOUxH?=
 =?utf-8?B?Mzlob1NtVk5Md3pCL0Q0K2l0NFlPQy80WlhnWC9YL2YrSHFCVXlkVWh3ZzVp?=
 =?utf-8?B?ZjVNUHZuKzlaY0RaaEtLWGFvWnRiTkFCVlhaTWppTEZwM1VhUSt2YlNTdkdO?=
 =?utf-8?B?WEtrUFpFbE9TRmpsY2xhc0ZrZS9UdmswU0xPMEliVVBUSjRVQ3VTTE4wWVFq?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YQMVcnkA7UipSTuJ9ssIWlLyY1X1knWWlYacxZjAdDySuBKHx3i2K3EkfrqGSzFgIAkZR01RcV1lHr838zDmEsD34Geo++giwEOGjlXb1WsdR8/rmEWDot95+zw6FPWjH96l57Lr+chDmP60cZvgDsOFoIJPVGnCFTSwmIonpcBMcdXXdWGpVxhTtg9ZBcoPaNP4BLLroaFXp4JX90UY2JG9Ji7TebN4m/tEcYhCJoJk0xZmYz/quwh5cUmF6GwkDHW2qDsYXJpr9wNVm+Jzaz2axOXfciI1rTgdW4jut5Y3CpE4mU32OgjWoD3MwCgpuSV7K53dp/2douuoiiEfhxPXqLK/j0y2WtpEpx4JslQ/y9CRmvKJOuhGMfEahYvXLaZet98tn76/7/Y4AKhxGtJBTWpKxfJ+0az+cmCsJ4BF0KUqsnDT9KGsaCsoUliA9yPwf8YA1i3RplfLIaD/WWdtGb+JFQIpP0YVObjy0mQAeB/u70iiJbHpWWbn8CDhURYdS3kEwkvSMB8Is7XjZ8OVmRLMVYd0w9XfYhNjClO92ACyRpo2UkCu3CFXdllfBl6gd/r4lMtnnpQ149om+KFg89qAqXRexvy1Qd4nG+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580ae1d1-f8aa-4b47-00fb-08dd94ae5a92
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 19:17:52.3969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBvtjdUySVoNXNI5ybNbaxbM97wvpqVR2dGA1YmEKgv2y/OTf5cdPu7wO8O/Xp9PKy0cuHR4TDKBY1t7UMbqVuNPwK+jqgD16FO6dSgitI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160190
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE5MCBTYWx0ZWRfX8OgFg4pZlT5F
 j+aH8297b2A3/aMN/SqlNaKnggMSLtTJ9nzt66TGke3uky6GtKz2z/DZDFJexjj4tll58l9wnyT
 ziKPiSN5Q4he2m5xF1uhN7OTQkUnXtCQRefW3LChRSBDJSqWk7ZSue370C2s5KruQwDzu+7flZU
 9yLh694VZ/9eVxWpJ1JMeAvuTJgUKccDUsmvTNFuGqzlrIYCpdY7/ZjqmXVEJIvt/dbMWkM9joJ
 cY3ma/iNP9y5ITA597OqmxCiUb67L+W3SxGQ8ogMvS554BX4ngSjZLVPT1q3LjxdXzAscsXilDG
 B89uLf2tcRp5lYWtbfn4bHw0zE48A5vft9Kxh9i+CHDVvrYYFZso1A2KvoNQuqwnoxAdTxGckdB
 byI+UGzbMFmsLJIP4Ig4eI8MRx5Jo0KpBgvlkkh/rfTBlivgrGT7VnSvF5TobDjqo/oC0ufU
X-Proofpoint-GUID: _bEqdNXimoaI67BC_7fEYTsSaV52vOBG
X-Proofpoint-ORIG-GUID: _bEqdNXimoaI67BC_7fEYTsSaV52vOBG
X-Authority-Analysis: v=2.4 cv=YqwPR5YX c=1 sm=1 tr=0 ts=68278f78 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=20KFwNOVAAAA:8 a=la4O4Dd8vgsyf-5inbIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 5/16/2025 1:14 PM, Peter Xu wrote:
> On Fri, May 16, 2025 at 10:35:44AM +0200, Cédric Le Goater wrote:
>> On 5/12/25 17:32, Steve Sistare wrote:
>>> cpr-transfer breaks vfio network connectivity to and from the guest, and
>>> the host system log shows:
>>>     irq bypass consumer (token 00000000a03c32e5) registration fails: -16
>>> which is EBUSY.  This occurs because KVM descriptors are still open in
>>> the old QEMU process.  Close them.
>>>
> 
> [1]
> 
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>
>> This patch doesn't build.
>>
>> /usr/bin/ld: libcommon.a.p/migration_cpr.c.o: in function `cpr_kvm_close':
>> ./build/../migration/cpr.c:260: undefined reference to `kvm_close'
> 
> And it'll be also good if this patch can keep copying the kvm maintainer
> (Paolo)..  I have Paolo copied.  So this patch is more of a kvm change not
> migration, afaict.  Maybe we should split this into two patches.
> 
> Steve, you could attach a cc line in this patch to make sure it won't be
> forgotten when you repost (at [1] above, I think git-send-email would
> remember that then):
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>

Righto.  My intention was to cc him on this specific patch and not the whole
series, which I did in V2 but forgot in V3.  Thanks for the tip on embedding
cc in the patch.

> Some other questions below.
> 
>>> ---
>>>    accel/kvm/kvm-all.c           | 28 ++++++++++++++++++++++++++++
>>>    hw/vfio/helpers.c             | 10 ++++++++++
>>>    include/hw/vfio/vfio-device.h |  2 ++
>>>    include/migration/cpr.h       |  2 ++
>>>    include/qemu/vfio-helpers.h   |  1 -
>>>    include/system/kvm.h          |  1 +
>>>    migration/cpr-transfer.c      | 18 ++++++++++++++++++
>>>    migration/cpr.c               |  8 ++++++++
>>>    migration/migration.c         |  1 +
>>>    9 files changed, 70 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 278a506..d619448 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -512,16 +512,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>>>            goto err;
>>>        }
>>> +    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
> 
> Are these "reset to NULL" below required or cleanup?  It's not yet clear to
> me when coalesced_mmio_ring isn't owned by the current CPU state.  Maybe
> also better to split this chunk with some commit message?

The pointers are not valid after this point.  Setting to NULL is cleanup, but
a best practice IMO.  The vcpus are paused, so nothing should be touching
coalesced_mmio_ring, and it does not matter in which order we destroy vcpus.

- Steve

>>> +    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
>>> +        s->coalesced_mmio_ring = NULL;
>>> +    }
>>> +
>>>        ret = munmap(cpu->kvm_run, mmap_size);
>>>        if (ret < 0) {
>>>            goto err;
>>>        }
>>> +    cpu->kvm_run = NULL;
>>>        if (cpu->kvm_dirty_gfns) {
>>>            ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
>>>            if (ret < 0) {
>>>                goto err;
>>>            }
>>> +        cpu->kvm_dirty_gfns = NULL;
>>>        }
>>>        kvm_park_vcpu(cpu);
>>> @@ -600,6 +607,27 @@ err:
>>>        return ret;
>>>    }
>>> +void kvm_close(void)
>>> +{
>>> +    CPUState *cpu;
>>> +
>>> +    CPU_FOREACH(cpu) {
>>> +        cpu_remove_sync(cpu);
>>> +        close(cpu->kvm_fd);
>>> +        cpu->kvm_fd = -1;
>>> +        close(cpu->kvm_vcpu_stats_fd);
>>> +        cpu->kvm_vcpu_stats_fd = -1;
>>> +    }
>>> +
>>> +    if (kvm_state && kvm_state->fd != -1) {
>>> +        close(kvm_state->vmfd);
>>> +        kvm_state->vmfd = -1;
>>> +        close(kvm_state->fd);
>>> +        kvm_state->fd = -1;
>>> +    }
>>> +    kvm_state = NULL;
>>> +}
>>> +
>>>    /*
>>>     * dirty pages logging control
>>>     */
>>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>>> index d0dbab1..af1db2f 100644
>>> --- a/hw/vfio/helpers.c
>>> +++ b/hw/vfio/helpers.c
>>> @@ -117,6 +117,16 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>>>    int vfio_kvm_device_fd = -1;
>>>    #endif
>>> +void vfio_kvm_device_close(void)
>>> +{
>>> +#ifdef CONFIG_KVM
>>> +    if (vfio_kvm_device_fd != -1) {
>>> +        close(vfio_kvm_device_fd);
>>> +        vfio_kvm_device_fd = -1;
>>> +    }
>>> +#endif
>>> +}
>>> +
>>>    int vfio_kvm_device_add_fd(int fd, Error **errp)
>>>    {
>>>    #ifdef CONFIG_KVM
>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>>> index 4e4d0b6..6eb6f21 100644
>>> --- a/include/hw/vfio/vfio-device.h
>>> +++ b/include/hw/vfio/vfio-device.h
>>> @@ -231,4 +231,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>>>    void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>>>                          DeviceState *dev, bool ram_discard);
>>>    int vfio_device_get_aw_bits(VFIODevice *vdev);
>>> +
>>> +void vfio_kvm_device_close(void);
>>>    #endif /* HW_VFIO_VFIO_COMMON_H */
>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>> index fc6aa33..5f1ff10 100644
>>> --- a/include/migration/cpr.h
>>> +++ b/include/migration/cpr.h
>>> @@ -31,7 +31,9 @@ void cpr_state_close(void);
>>>    struct QIOChannel *cpr_state_ioc(void);
>>>    bool cpr_needed_for_reuse(void *opaque);
>>> +void cpr_kvm_close(void);
>>> +void cpr_transfer_init(void);
>>>    QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>>    QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>>> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
>>> index bde9495..a029036 100644
>>> --- a/include/qemu/vfio-helpers.h
>>> +++ b/include/qemu/vfio-helpers.h
>>> @@ -28,5 +28,4 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
>>>                                 uint64_t offset, uint64_t size);
>>>    int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>>>                               int irq_type, Error **errp);
>>> -
>>>    #endif
>>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>>> index b690dda..cfaa94c 100644
>>> --- a/include/system/kvm.h
>>> +++ b/include/system/kvm.h
>>> @@ -194,6 +194,7 @@ bool kvm_has_sync_mmu(void);
>>>    int kvm_has_vcpu_events(void);
>>>    int kvm_max_nested_state_length(void);
>>>    int kvm_has_gsi_routing(void);
>>> +void kvm_close(void);
>>>    /**
>>>     * kvm_arm_supports_user_irq
>>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>>> index e1f1403..396558f 100644
>>> --- a/migration/cpr-transfer.c
>>> +++ b/migration/cpr-transfer.c
>>> @@ -17,6 +17,24 @@
>>>    #include "migration/vmstate.h"
>>>    #include "trace.h"
>>> +static int cpr_transfer_notifier(NotifierWithReturn *notifier,
>>> +                                 MigrationEvent *e,
>>> +                                 Error **errp)
>>> +{
>>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>>> +        cpr_kvm_close();
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +void cpr_transfer_init(void)
>>> +{
>>> +    static NotifierWithReturn notifier;
>>> +
>>> +    migration_add_notifier_mode(&notifier, cpr_transfer_notifier,
>>> +                                MIG_MODE_CPR_TRANSFER);
>>> +}
>>> +
>>>    QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>>>    {
>>>        MigrationAddress *addr = channel->addr;
>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>> index 0b01e25..6102d04 100644
>>> --- a/migration/cpr.c
>>> +++ b/migration/cpr.c
>>> @@ -7,12 +7,14 @@
>>>    #include "qemu/osdep.h"
>>>    #include "qapi/error.h"
>>> +#include "hw/vfio/vfio-device.h"
>>>    #include "migration/cpr.h"
>>>    #include "migration/misc.h"
>>>    #include "migration/options.h"
>>>    #include "migration/qemu-file.h"
>>>    #include "migration/savevm.h"
>>>    #include "migration/vmstate.h"
>>> +#include "system/kvm.h"
>>>    #include "system/runstate.h"
>>>    #include "trace.h"
>>> @@ -252,3 +254,9 @@ bool cpr_needed_for_reuse(void *opaque)
>>>        MigMode mode = migrate_mode();
>>>        return mode == MIG_MODE_CPR_TRANSFER;
>>>    }
>>> +
>>> +void cpr_kvm_close(void)
>>> +{
>>> +    kvm_close();
>>> +    vfio_kvm_device_close();
>>> +}
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 4697732..89e2026 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -337,6 +337,7 @@ void migration_object_init(void)
>>>        ram_mig_init();
>>>        dirty_bitmap_mig_init();
>>> +    cpr_transfer_init();
>>>        /* Initialize cpu throttle timers */
>>>        cpu_throttle_init();
>>
> 


