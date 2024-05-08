Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1682EC41513
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 00:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4VYG-0002AV-0M; Tue, 07 May 2024 20:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1s4VY7-0001v7-Hk
 for qemu-devel@nongnu.org; Tue, 07 May 2024 20:52:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1s4VY3-00038Y-Qg
 for qemu-devel@nongnu.org; Tue, 07 May 2024 20:52:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4480OCnA023282; Wed, 8 May 2024 00:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=FTMYI4GM4St7Ayp/qvq9tRNg0e9vlecsVUXYPLDa3UE=;
 b=BJGF33uKm/DDnHD+FYhMVvhDPG/atGSz6YSY3IlQWOyqZAxLVPjqCM6hs6uUUVft0Lsy
 CajGklVFDXf05b9ETCw9QnhN0xEFqlAPL0+/3Drf+XeyWqype35B6ntM6Ryb8wBlwzoX
 6AHISatKrP3ByaRqp8Od+jbdKXzq94QSqEMY8pPE6UApx7Fk5PoubCzeV7jPrKop4Ryd
 tIC1nFdLTh4NWTxxc5lZ5xyp2Re6bYYJDPwTpUX53fW1gHJTMke64Ir7M8P6DHWZxPo1
 I+KHkPMk9BayIkNUw4ssFe2LtFiCZVm20IvjAcp5cqkXeqo3OD2i27mPBzqBiWGepZp1 qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfv0khp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 May 2024 00:52:40 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 447MCfVo020104; Wed, 8 May 2024 00:52:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xysfkc7bb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 May 2024 00:52:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdQUxwmwYzMWGTvEAyhAQrJVV/z8eAD6Xl9nwN6Dx0OcS3Lxbu5gfFbmgplDA4CbiEr6KiZSJO03JL+z6VZrpGYgRzNB9H+zmY4kOtyYd3jEknlrS3K9Qtj348h0dcOCp4k7eQFbCswZLFJSdF8W86xpO4sY5gtmviUcBJdpsSRQUFMHT5J6dVjHzEcX35rWfedU1OBVrm4JU6qV4Sv7P5BT7yCa8TLoz+Ejyhr27QtAaxRHBO3Crn2Son2TCTrXvLbUzWMl5tt4Bwbjor5Nzjo+Aa50pdreDDq4bwkpvwSOUpD8Y3tuntzqsOZi126Efgb8fo+FsUuGBI5faOpu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTMYI4GM4St7Ayp/qvq9tRNg0e9vlecsVUXYPLDa3UE=;
 b=S/HRZxjN6hB3WCoNCDKP+DVU/ogHlNkAKk0n4DowFzxZAubcWOi0JTh2jFhwbcU+8sq+sEQv15GzMnCyxvgSodxh9TWijlDOfW0Sls9Wj+adUhklEgPKV3fUVWyvz2pRZo/jaGQYxDvUbloxra7VRusSMS6HfZyAPS5CGxMTWAIoEdd5KYy/FTbkfLzyGq576AsjIDAgYQv1tZhrISHj60IeRwryQV3dRSc5rU9CUfGPSSgByE0ASf2ywin8IF8WOgFtKSc/8Ha/6gS7TXdlt7m3Hxe6qx6lOUv+voq7HPVsTjDUb0f0tXUzQM+HynH1Au0Yb3IOKWK5uarH+IIO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTMYI4GM4St7Ayp/qvq9tRNg0e9vlecsVUXYPLDa3UE=;
 b=h7y21znuo/nAB9igkNo9twOlQc1p0JSdCvvrStOPTW/tooya4/RvZ413zuU9AdGwgmcbFVgRANlOE4V7QoX2eTxMcNAZ2vp6GzXEVbc6141IgbbMriSOZabab+/P8CXFvWQP+OpMr3TxYk6GJ3FLuIlxJRJAkqFRhNSLlyG6JI8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH2PR10MB4232.namprd10.prod.outlook.com (2603:10b6:610:a4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 00:52:37 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 00:52:37 +0000
Message-ID: <6cb3e772-17fc-43c3-99ec-cfd074241112@oracle.com>
Date: Tue, 7 May 2024 17:52:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jason Wang <jasowang@redhat.com>
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
 <f6c63253-57bf-4e7a-8178-667a577784d5@oracle.com>
 <CAJaqyWdheH4MoHMOQjPmbOpODswE53w09LkfeaDNWdys3qUFLw@mail.gmail.com>
 <86670db8-604c-4bad-9022-a59b8363e5ca@oracle.com>
 <CAJaqyWf1iPgKbp8-SfFGeMxJ2E-1y5dLLkOxLLNa6rm4tQgPGA@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWf1iPgKbp8-SfFGeMxJ2E-1y5dLLkOxLLNa6rm4tQgPGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::30) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH2PR10MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: d91387a1-36cc-4b19-7950-08dc6ef92773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUVxR01ZdmNyUXE1YnRvMnMxenRxZzJ6cVRKWXlESXhDNVArUlVoNVZ3S2xk?=
 =?utf-8?B?dmpjSGVBYlNBdXVrbHFUcDZDYnVnR21vYnVIOVd1WnFTRGlqSFk4cVpRdHpG?=
 =?utf-8?B?ZU41MGFpWXFmZlJKOUNVaGd0TXJjU2YrRktSQjVHT09sL2U4eEllSE10K1No?=
 =?utf-8?B?V0JCQ29IMWx2cVBkRDJkSnBxRlB5VFBzWThReGlKVVlWMisyR2dSbmtocW5r?=
 =?utf-8?B?UTFlQmk0R0tDakJBWUMxUUNsdlY1cngzakZNeGFzbGpyYUs3TkxIeGlqakU1?=
 =?utf-8?B?dGtJdHc0UjZNUjNtRTBSK1VKK3o2dXBZa2dZVVdBRUdZSWxKM1VGZFMwdUpW?=
 =?utf-8?B?a3ZCUGdEbkdGYVF2LzlZOWhWQnFSY0FQWjREbWwxRzFLUjJaV1ZDb2R1MGNq?=
 =?utf-8?B?NVorUFcyUVhDQ2xwUkJETjV6SStpOGludjQ4QXdoRkZ3d3J2VlNYYlRMei9Q?=
 =?utf-8?B?cGZaRWxueGE1aWlKaVNvSjhXTEpBeVpqcDJna09nNlRGdGM3TEI5dHhhemtP?=
 =?utf-8?B?RytuUFR4Y3dzMDlTdmVKMVFWYlRDU1VER3N0NWpEajRNMTRCNit2ajNmR2dE?=
 =?utf-8?B?Y2dKNmo4MTdod3BxSDFqSnFEd1BiM0xWRS9ndU1nN2ZOdTFOSVN6UUZ3ekxs?=
 =?utf-8?B?NlE3Rks2RmxiSXRDMFh1R3JoVEhMM1YrUDNIdW1sSURpV3NZeVl2em1Da3FR?=
 =?utf-8?B?ZDVCakNtUU1TMVhoc2RESXRwdldUR1FkQ3U5aWFndFFqcFM4bi9LcGR4enFM?=
 =?utf-8?B?OTZtZy8zMGV2RDZsYjFHOXJpK2NTNE15bll1YUFkTnlKdFJsU3hxSTRoQmpm?=
 =?utf-8?B?UVhSM2tTMHowaitwVDhxcmt5K1FVVENPNmMrM3RLWlNLOWoxSFlVV1ByaTVz?=
 =?utf-8?B?WjI0QVFWd3FHMy9XbEpWRS90dnpsQVhxTUxQWThCTk92MWNtNWlFcGd3dEVL?=
 =?utf-8?B?ZmFER3BGSFhrVC91a0xseWpTemxaalNMTW9UTng1bTFzVXNTaHpkNmJwMFgy?=
 =?utf-8?B?SGxQZjVJYjlBVVZxa0QxQ0YwcnozK2h0TTg1a1R4SFVjbXBORXFKUlFWcnRi?=
 =?utf-8?B?L3l6dG11RmoxN2YxVWpTa2tMeFFxbWJzMTRxK3RPQ1E1RjF5UkRaQm5TZmp4?=
 =?utf-8?B?R2pxeWNtc2J4ckZmT0E3cDF2VTFEWHpzWGo1c1pVQTRPaE9Wc2kvUVAweU0y?=
 =?utf-8?B?NUNOVThqWUZpVkpyWWQxNXkwakhhTkZuV3dkQ3RpVktUMTlKeTFFSWExcUVF?=
 =?utf-8?B?ZWlZZnhXM2twSGR4cEtSeDVRODF4WmZrcVN0OXNrdExrVmVXaUFPeFlmMGJs?=
 =?utf-8?B?QUtlSHN2R3lZTW5uL2dXZUd5SXVPY094UnIwR2dqZ2tBV05MSFRIcHV4WWZF?=
 =?utf-8?B?endDOWpDNUx1bFJwZ0VYNnBYbEJSdURwTmRNOHlRcmsyb1RTdUpHQVhPU3d1?=
 =?utf-8?B?UlliR0VyNE0wYTlYMUpkOFlxM2RjREZjeEErYVRhdGNDVFNHbXNXL1o5dnZZ?=
 =?utf-8?B?UXlRd1Q4NFFicmJDQjBtT3RuN2pNazFXczdsaUpQRW9qcTd4TFlESHFsZkdI?=
 =?utf-8?B?Z2FheGJHaFhHRXBOejZ2NDBzSDVPREtaYWFmT2N3WDV1a1Rxbk8yVkg5ejhC?=
 =?utf-8?Q?w/xiTpOLqk4rnlVKlETK1qm/UFFa7OLClOOXYqi4V0f8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGpyS096S0MwaXBuTVBtZlFSa3B0eWRTVUFEbWNWTldWQm9lSVp3OW9lNGNK?=
 =?utf-8?B?UjZwYlRUWEJiVCtNZVNFNTlFQnRIanlWUmpXbE5WU2NEYjJDQklDY1J4b1M3?=
 =?utf-8?B?dm9MaThTNzV0WmU3SCtubW5EUEk3Mi9iZmRLOHlPVjRSeWZXQ0RjUkRNMlhO?=
 =?utf-8?B?RkxiazVEckpSWnYraWFFSHZLSVNsblJlT05qczV5WDhwVTNGMmI4R0cxNjQx?=
 =?utf-8?B?bXZXWENaZHdHM0VOcEJ3SVd0bzYyVGxIQXV0M2ZGN001MUo5R1lQWDI5NUdQ?=
 =?utf-8?B?NFBaR2t0MDNHV2gyQVQvMFRTMmRxaTBMSE4vLzJQYlJhdytONFRtVzBNbU9x?=
 =?utf-8?B?MVBWZ3VObTlYb1FwN3ZsVTJ6NGp2TW4zaWFYUUdpWE5xM3l3T1hnSkVuVjdX?=
 =?utf-8?B?eWR4L1NtRjBVZ21rWW92a1J0S2ZvaXNSdUIrcDQrbFNHUFgvRW5lOWY5ejdD?=
 =?utf-8?B?SkZLdHIrUXBJbFBVZEc3dHZSZDZyK1hTQVBvMzhQam9PS1hqWDI4bUFOemxI?=
 =?utf-8?B?Y1ZmNkxodnVrK0s3aHpBanUrV0lWdkIwbGJrTWc1aGpTMlN6QU0wNVJNSWdQ?=
 =?utf-8?B?S3pGcm5uT2liZFRtZkFqeTRvYk1lQWx2MkYyb3M0aXlaMmcxYzF5cnAyRE56?=
 =?utf-8?B?RFNuejh0MWpxM3haa1FpQ0J2M2hqRjB2ZktLTUVoQU9qNWpFV3RhR3VDanVh?=
 =?utf-8?B?KzhKaXo2U25ja0VLL2p2ZEhFdEFCYkdVQmM3SXM5T3pLdU1nUHZsdG1pTkRS?=
 =?utf-8?B?RGxzNVlOUHFBaEhGR3B4am9mM3EwQkNGRmMrb01HQmdXNmhPUE15cWxJMlE3?=
 =?utf-8?B?a1U1Y2I1RnJMNFRiZnRUTjVPbXp0SnRNN3FSeHJURnJjRWlKZzhBUFNoaG1s?=
 =?utf-8?B?Z3duSFgwMitpUVA4VnhDR3JLMnBXWHd2N3JrTW9ULzNrRThPYk9WYUI1Rk1h?=
 =?utf-8?B?QWVCZEhxUlA3ZXVGVkVORXl6RlBKK21CbjNkNUptWkJLekxvSTJYcEl3dTU0?=
 =?utf-8?B?dG01MG5ST3A4Mzl6VXo3QW9vNVozREU0YWU0VERRTEFHbTlKcklDbUwyUEsx?=
 =?utf-8?B?eVRyVlkwdzNmcSsxQjVQanc0cUpQQzZjZVdPZ2MwNTdJUXhUaVlCdGRMdGxl?=
 =?utf-8?B?Z1YyOVdPTFJuZDFhcysvSlBRR000TmNHNnlsVWs1Rk5JSDNhZTNCVFFIcU0x?=
 =?utf-8?B?TURKc0JlVU9QNEVSKzhzcEc4TFJaS1FleXc0bHlSMHMyVEhhbjhYak5VUTU0?=
 =?utf-8?B?N3dJS0VKa2xmWW95ZEdYMVIzWG16MWNGTHpZRFV4N3FWcFRtMTlhdXpoaDdi?=
 =?utf-8?B?VFQ1SVk0bUVXSHlYeUpjWFRYZUZEOWFwRTNTbEtkd3ZlaGN2bVR1SWE3TTF0?=
 =?utf-8?B?NVhuYXZQNndhMjVXZ0VWcWg0S2gvd3Q5YzBWTG5QQzF2M3RlOGdTVTY4SVJn?=
 =?utf-8?B?am1hTWNvSWtHaTBmTzhjVFhkMzVWZ3BHaWhHZ1k2VFJ2U0ZNbkVZSDc3bVZF?=
 =?utf-8?B?QnJYaXA2ako4dDFuSlQ1N05WY01NWXc4SDV6MFZmaDRQd21VVkFiV3AySWRm?=
 =?utf-8?B?WjcraC9aaHJlc0lON25ZYmJqY25hQ1NQMWlCTXJwTXhGYkJkNHlPM01CWFlz?=
 =?utf-8?B?eFNzb3I3TnROU1hjSkhIbjNNTVlGQ1pEc05uang0ZytlWlRXU2hORkJxUHBp?=
 =?utf-8?B?YlRScUFwaVlMNDYzYVVwbFZWNVhudkVwY2VydkRzdS9RZWRuNmVkYzdjMXU1?=
 =?utf-8?B?WDZUWmlTMUNPOVhlSFRXNVZsczd6dDlRL0hCUTBWL091MkJ3Zk9LYzJBb2Qx?=
 =?utf-8?B?QUdOaVJwVlRuSlFnYjdvTG10SFZCcjhxYi9lRXA2RzAxb2pLNkdKUTBkWnFx?=
 =?utf-8?B?eG1yM2x5dW45THZFN0NsMjE3bWg1bXVxRmFMQlk4TjVyOUxTa05KaGRzUkNv?=
 =?utf-8?B?bklVTW1EdVhYUW1TU09HR0N4dXRwV1BWaUdCRUp1MG9hWjVERW95SlFvR2hj?=
 =?utf-8?B?eDdaRWFiQjNHdkdhVWdubG0vTUZYY2l5VzY4VXhDZFVVN1JETitkNzg2Ykxw?=
 =?utf-8?B?bkZNd3d5TWwzdDBjcjVOWHZpR0FXRk8rSlQxZGZHUzNvVVozRnhSaEl3eDQz?=
 =?utf-8?Q?kfFWowdpl5Ae7Cef0ck3FYyWH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xVy4tcfpqESVedt9U8JhbOiME4yIPiVpXUpojpiL/aCqfjdOhtxhYDSu+FMUTZ3Vm8Rx6Behuoda+3+J5HdGoC060n2/Ty5uDRADXToYktIpN4VGtaxvOzpCji9PZz1dj/U8efUwxCAQCHaCCCTIBAMZSGPF9We3J765VJ5mrrhsfl27Ke/D1b6knSHTfjF3oEMXZLggZIR+5kM11ZCjwm4JwfM701gOskSZ4m5HN+aKafmmsupvcDGa0TJdIIoev3+eMd+F/P8zuls5ITPd2UCK4Kt6yipltvLJT1ZUV3UaNJN/vMqfNpic7lxXoO94l4gRYagKWofhaPUajji27K8tCxiHX33tWZGHf0q/CGAK8OVNGQ4PeYLrlPYhAkod36ZXtGTaIHyVP7goZ1NL/LlW5VCQrAj9PmV6udwFVnx/j0ekpvLLPkMUbNb8wbqgSwg+KxxF9kFuf5d9J7RVKG1fPVHyCNyNqCdMh95TmCv0J4c/3+nVBrY3zyTHzlrI5NmAbHVRn6Sf9qFQP1o2fVRL+ifID4EUVVkjGsQZI3ld/xUi5cSNKJrG0bgrO3iLW9NFIeHC7bcr3D5XD+1H8ivkB75HictrJjZXcQbFq8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91387a1-36cc-4b19-7950-08dc6ef92773
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 00:52:37.2713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXA63M6Z5OpOXJNxtBTdGha8TmMAzqqLUlNi5T4O9m5Fmh4+zZAeXeV+KrmeUI35jF/Y2dz0o8CwzROF1HkUag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_16,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080004
X-Proofpoint-ORIG-GUID: SaQu6W1lnywiYvBNclVd-CqVlI2z7qLg
X-Proofpoint-GUID: SaQu6W1lnywiYvBNclVd-CqVlI2z7qLg
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



On 5/1/2024 11:44 PM, Eugenio Perez Martin wrote:
> On Thu, May 2, 2024 at 1:16 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 4/30/2024 10:19 AM, Eugenio Perez Martin wrote:
>>> On Tue, Apr 30, 2024 at 7:55 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 4/29/2024 1:14 AM, Eugenio Perez Martin wrote:
>>>>> On Thu, Apr 25, 2024 at 7:44 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
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
>>>>>>>> https://github.com/GNOME/glib/blob/main/glib/gtree.c#L1115
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
>>>> Ouch, thank you for the summary of attempts that were done earlier.
>>>>> The only advance I have is that memory_region_from_host is able to
>>>>> tell if the vaddr is from the guest or not.
>>>> Hmmm, then it won't be too useful without a direct means to identifying
>>>> the exact memory region associated with the iova that is being mapped.
>>>> And, this additional indirection seems introduce a tiny bit of more
>>>> latency in the reverse lookup routine (should not be a scalability issue
>>>> though if it's a linear search)?
>>>>
>>> I didn't measure, but I guess yes it might. OTOH these structs may be
>>> cached because virtqueue_pop just looked for them.
>> Oh, right, that's a good point.
>>>>> So I'm convinced there must be a way to do it with the memory
>>>>> subsystem, but I think the best way to do it ATM is to store a
>>>>> parallel tree with GPA-> SVQ IOVA translations. At removal time, if we
>>>>> find the entry in this new tree, we can directly remove it by GPA. If
>>>>> not, assume it is a host-only address like SVQ vrings, and remove by
>>>>> iterating on vaddr as we do now.
>>>> Yeah, this could work I think. On the other hand, given that we are now
>>>> trying to improve it, I wonder if possible to come up with a fast
>>>> version for the SVQ (host-only address) case without having to look up
>>>> twice? SVQ callers should be able to tell apart from the guest case
>>>> where GPA -> IOVA translation doesn't exist? Or just maintain a parallel
>>>> tree with HVA -> IOVA translations for SVQ reverse lookup only? I feel
>>>> SVQ mappings may be worth a separate fast lookup path - unlike guest
>>>> mappings, the insertion, lookup and removal for SVQ mappings seem
>>>> unavoidable during the migration downtime path.
>>>>
>>> I think the ideal order is the opposite actually. So:
>>> 1) Try for the NIC to support _F_VRING_ASID, no translation needed by QEMU
>> Right, that's the case for _F_VRING_ASID, which is simple and easy to
>> deal with. Though I think this is an edge case across all vendor
>> devices, as most likely only those no-chip IOMMU parents may support it.
>> It's a luxury for normal device to steal another VF for this ASID feature...
>>
>>> 2) Try reverse lookup from HVA to GPA. Since dataplane should fit
>>> this, we should test this first
>> So instead of a direct lookup from HVA to IOVA, the purpose of the extra
>> reverse lookup from HVA to GPA is to verify the validity of GPA (avoid
>> from being mistakenly picked from the overlapped region)? But this would
>> seem require scanning the entire GPA space to identify possible GPA
>> ranges that are potentially overlapped? I wonder if there exists
>> possibility to simplify this assumption, could we go this extra layer of
>> GPA wide scan and validation, *only* when overlap is indeed detected
>> during memory listerner's region_add (say during which we try to insert
>> a duplicate / overlapped HVA into the HVA -> IOVA tree)? Or simply put,
>> the first match on the reverse lookup would mostly suffice, since we
>> know virtio driver can't use guest memory from these overlapped regions?
> The first match should be enough, but maybe we need more than one
> match. Let me put an example:
>
> The buffer is (vaddr = 0x1000, size=0x3000). Now the tree contains two
> overlapped entries: (vaddr=0x1000, size=0x2000), and (vaddr=0x1000,
> size=0x3000).
In this case, assume the overlap can be detected via certain structs, 
for e.g. a HVA->IOVA reverse tree, then a full and slow lookup needs to 
be performed. Here we can try to match using the size, but I feel its 
best to identify the exact IOVA range by the GPA. This can be done 
through a tree storing the GPA->HVA mappings, and the reverse lookup 
from HVA->GPA will help identify if the HVA falls into certain GPA range.

>
> Assuming we go through the reverse IOVA tree, we had bad luck and we
> stored the small entry plus the big entry. The first search returns
> the small entry then, (vaddr=0x1000, size=0x2000),. Calling code must
> detect it, and then look for vaddr = 0x1000 + 0x2000. That gives us
> the next entry.
Is there any reason why the first search can't pass in the GPA to 
further help identify? Suppose it's verified that the specific GPA range 
does exists via the HVA->GPA lookup.
>
> You can see that virtqueue_map_desc translates this way if
> dma_memory_map returns a translation shorter than the length of the
> buffer, for example.
>
>> You may say this assumption is too bold, but do we have other means to
>> guarantee the first match will always hit under SVQ lookup? Given that
>> we don't receive an instance of issue report until we move the memory
>> listener registration upfront to device initialization, I guess there
>> should be some point or under certain condition that the non-overlapped
>> 1:1 translation and lookup can be satisfied. Don't you agree?
>>
> To be able to build the shorter is desirable, yes. Maybe it can be
> done in this series, but I find it hard to solve some situations. For
> example, is it possible to have three overlapping regions (A, B, C)
> where regions A and B do not overlap but C overlaps both of them?
Does C map to a different GPA range than where region A and B reside 
originally? The flatten guest view should guarantee that, right? Then it 
shouldn't be a problem by passing in the GPA as the secondary ID for the 
reverse HVA->IOVA lookup.

Regards,
-Siwei
>
> That's why I think it is better to delay that to a future series, but
> we can do it with one shot if it is simple enough for sure.
>
> Thanks!
>
>> Thanks,
>> -Siwei
>>> 3) Look in SVQ host-only entries (SVQ, current shadow CVQ). It is the
>>> control VQ, speed is not so important.
>>>
>>> Overlapping regions may return the wrong SVQ IOVA though. We should
>>> take extra care to make sure these are correctly handled. I mean,
>>> there are valid translations in the tree unless the driver is buggy,
>>> just may need to span many translations.
>>>
>>>>>     It is guaranteed the guest does not
>>>>> translate to that vaddr and that that vaddr is unique in the tree
>>>>> anyway.
>>>>>
>>>>> Does it sound reasonable? Jonah, would you be interested in moving this forward?
>>>> My thought would be that the reverse IOVA tree stuff can be added as a
>>>> follow-up optimization right after for extended scalability, but for now
>>>> as the interim, we may still need some form of simple fix, so as to
>>>> quickly unblock the other dependent work built on top of this one and
>>>> the early pinning series [1]. With it said, I'm completely fine if
>>>> performing the reverse lookup through linear tree walk e.g.
>>>> g_tree_foreach(), that should suffice small VM configs with just a
>>>> couple of queues and limited number of memory regions. Going forward, to
>>>> address the scalability bottleneck, Jonah could just replace the
>>>> corresponding API call with the one built on top of reverse IOVA tree (I
>>>> presume the use of these iova tree APIs is kind of internal that only
>>>> limits to SVQ and vhost-vdpa subsystems) once he gets there, and then
>>>> eliminate the other API variants that will no longer be in use. What do
>>>> you think about this idea / plan?
>>>>
>>> Yeah it makes sense to me. Hopefully we can even get rid of the id member.
>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.html
>>>>
>>>>> Thanks!
>>>>>
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


