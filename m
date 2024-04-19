Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B981EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 23:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxxzX-00061S-VL; Fri, 19 Apr 2024 19:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rxxzT-0005zR-44
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 19:50:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rxxzQ-0000TD-GU
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 19:49:58 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43JJEGki003378; Fri, 19 Apr 2024 23:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xGEhevJARge+idDuNs7BBwYJYX4LGld6I6qDM86vpA4=;
 b=kKdOjr26SoJXrJW5MWrEV5vxC1IwFvDIadHQhw/fT3EX39WSE/CZNZVCp6nd+ulje2xd
 7FcouIo6GzsZ8Ww7fQWYbT7OguiJO3DYQURLo/u/R8aZOfpMZ5GMZPXHKkj4qPMy5trG
 hqT79kSG7iFMVabajAh5Q1Pn2xzgmrFMGem1uwv3IJ5E5PeZuXQ7056MkqPgm8CQrWUv
 toDqFN5gWAiFIZ1mtSVMyw5wCdgSLh8yAaxhYCSeldu6Vjwrhq7wJIqc6KEO8jsAeIJv
 Y+x7X//uzVLHw4mzfA7QHu0GI7LmghP4YMxJbDE4iiDyVx6XE0j8yb9wnIhx3Pai4+k1 sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffnu57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Apr 2024 23:49:51 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43JMecwr016928; Fri, 19 Apr 2024 23:49:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xkbjct7mv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Apr 2024 23:49:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIxOO6163lQyMI9qTqt8s0BUOUo1o7hTC8xvp/eaa8WxKFRF7pbzAjhq+EdG/tJZtoGI3eHYWlCizwdFwIT1FGpJUQFfO3ZSTgU4ZjMBV3N8kXR+VPCMQdtLUwHFYbzYVlR8d82NnVzb/bkL/ZhIuz/y8ZGZxzH+ZL/Eya5PIc0kB3fsDTqx/BB6AQEX28owHamymPVhKlyTBRH8kel9WzmmpeFS5qtP/5dcyfswKtmwA31PvVusNRL1zp12cAZgd9r0hqTRe80oBTklHv3P+chVZpLjtFMaT72jsp1BL3IBbqYo6p03w6v4pHYnb0PAUyXXwlky1ao91gRYFxccHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGEhevJARge+idDuNs7BBwYJYX4LGld6I6qDM86vpA4=;
 b=YtwnIRUrNkfRhK/6uAR2Z+1Spkw0mZWgBkSFMeqfLPJdB6U75StO1oMQa65EMH2oHmYyNYs1sdMjzY17js5AF977Vf/wXCcguH2goD32XewEUJTGjW09m2u99xRu52phFwATrjQu7cbV8BI42acolghMuXlbglfbZK5dcXAlKpq7JA/IZfWs6H8AYI4HMv8KeTWVwmb69NdIQgHbwMN4HlTAOkJPtZT4rCedWA7F7hgzoLJ+Om12buz7u7pSsxHRTFRD1+7SOZPLxZGML4qrEgAF8g0lzpVd+lfYtVWd8ptEw1yqCClE1yIi46erX6p3MnvVsLJH4PX6uqnMxJcNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGEhevJARge+idDuNs7BBwYJYX4LGld6I6qDM86vpA4=;
 b=T5YR4JZmuasNl2YC91k10Aj6DQqXpDtfE30A0dSx9eT/WBYS/sP47C6OviEyLvVRxY5ujvWeI3cDewoSeP57fTfMBOvTOzvmDFtd9IftTKMR5BYBly8dF2Z0IBLOTXxIyLQXhvd2O1nCTLLONHaxQps0HIKYiUMSC/uqIhDtAks=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO1PR10MB4786.namprd10.prod.outlook.com (2603:10b6:303:6d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 23:49:49 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74%4]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 23:49:49 +0000
Message-ID: <450d0da1-3d11-428b-bd89-d09a2964cdb1@oracle.com>
Date: Fri, 19 Apr 2024 16:49:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <20240410100345.389462-2-eperezma@redhat.com>
 <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
 <CAJaqyWeE3kfgN5Y0=Kj6oCOFwg0H-gQEr4g3TM+3_+5N7mfd=A@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWeE3kfgN5Y0=Kj6oCOFwg0H-gQEr4g3TM+3_+5N7mfd=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23)
 To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO1PR10MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: 406c915f-13a1-49f3-addc-08dc60cb6676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?allBcG90ZURVZHB1UUdWbE5wVzJBK1hiN3lnMEpHRmhkaEdMVnNVbDRMVlY3?=
 =?utf-8?B?a2p5dVF4VzdnODRtYkt6aWVFWjREd3dkQjl5WUVMZVFuVGhvSkp4WFVGRHJR?=
 =?utf-8?B?QThQVFB5eXk0bmxXdUUvem5oZER3Y1IwbEdaTWFJRytUbEFDUTlYcnk4MDlC?=
 =?utf-8?B?c3BNU3JnRnV0RVllaXMyK0FqV0FDcFdFUXNYQld1SGsyci9JRUgwZE5zL0VV?=
 =?utf-8?B?MytPaWlBeFVPWWZMSWRBajlsZVVMTEMxWUpsSGM3T09ncUhYMFhEN1hKUVpV?=
 =?utf-8?B?VGVrVXZBSm9leW9kSE1CUVczbnRScVhrNS9adDNuL3FlMVZBTVE3NDljMDJv?=
 =?utf-8?B?dFhnRjd3bFpJK0dDR0I3ZHozT1d3cXJIY3haNFptODlwUDc1dFc0SFAreTZ3?=
 =?utf-8?B?UVRVMkllaC9SM3EzdWQ5QjdmMXp4K2YrQkQxYUdMcmJWcmZPMkVoMzNvbWVB?=
 =?utf-8?B?NmY1RlNqL0w5TXRwaVJOdCtrRWFHYVJRcUl0OW05ZElEeHpzYThncEd0Tmp3?=
 =?utf-8?B?UFVZdUR6MjE2aVRocE9UUEtNZ3FBWnlxSTBDWHlwZXhTOW9Fb1FvMU0xa3pl?=
 =?utf-8?B?dC9IOEVZQ1FJNGNFUTQ1QjVXMnM1SDRVMVZDRm5Ob0wyajRmSGtWd3pKeDFv?=
 =?utf-8?B?aFdlNFJQMnd3OWUxQ2RuMUpVdjUzeDB3UDBxbzBUZEl4ZEcvNG5oQkk0aFFG?=
 =?utf-8?B?cmZPSlVGMGcwSHRBNGlrdytTMWgybk43RmJqZ1ZlZmZWK3VFOFB3VkZSRmdR?=
 =?utf-8?B?YU9xRFEyL2dMcG1KRGIyT2J5S0MvbEtlRWc3TVlINFpTQitQZ2dCMVU0eW5y?=
 =?utf-8?B?Z3NaVEFVYk9PWUxQVGxoQk5tK3dzeWM3TzU5c3RISUNOcURWeTRVTFowQWda?=
 =?utf-8?B?SHJ6R1lRYkt2djJUSDh4ZCtQbnhSSjBDMGE1YnZtcWhHK2d4RGFrZDdnbFhl?=
 =?utf-8?B?ZUNrd1dqM1h5b2lVVGxlRjVQNG9xM2hBNVJNMDFMRExSOXROdkdjd3hMbFdH?=
 =?utf-8?B?SFFvUWtiQUI2UGV1dkVjaGRYcmZkcGs0dytRcGQwMGtzMzFXRHV1eUptN1h0?=
 =?utf-8?B?NUNZbUZ5OXM4QmI4UzV6eitwWGZ5Z090OE9kcFdzMjJBM1Y2TUxwQU1YMEVD?=
 =?utf-8?B?a0kwVWRXcTlqUFloLzhBNDM1c09iTTY5dkV6WnVkdlg4bml0U05QK1Q1bXJ2?=
 =?utf-8?B?Qm9GU01mYk9FTHdxaXMrSjNZb1JMK0VMdStYdm15cldLV2tCdGUxb1BYR3lR?=
 =?utf-8?B?ZWFUb2JEd3RXUURjVGNEM0xjMXNtbHpHR04xS29HSWxYYTgvd09OUkFoSVc5?=
 =?utf-8?B?c2IwWnVjeWFIZnV0bGdjL1NyVnVZMGh1bWZFaXc3MGhVRisyQWhrb21GUCtr?=
 =?utf-8?B?d29BZW5ZM25laTJxS0w4dDRjWTVvSktnU1Ayc0JvREYrQVFnaWtDNFcwbzkx?=
 =?utf-8?B?cjBBcnlUL2RDc25KREVRdU10SEIwcllyaTh0T0RFa0daS05jZ2Q3WG5Ycm9L?=
 =?utf-8?B?b1k1bjVNMjBTckdWWWF5cFBTZUNkN2c5NmhtZk9NVHprZ0dabVFWMm5KaVVz?=
 =?utf-8?B?dVIrUzg0YTN1cERGMWVqUmRxeXRZNis4K3JIWEIrY0x1ajBoRzZRSTVSU2JK?=
 =?utf-8?B?RWV0Q2RaNG4zRURpQU5BWE8xdEFranpyN0h1TXBzNXJaYURFYVJXYXplNDNE?=
 =?utf-8?B?cWtMb1NsWWE5ak9vYzJhcGRVZDVQSGY3LzVQbUN5L1M0dElLU0V2cGd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDl4QzFUejZUQXdGb1JBaTRVblBJSXJYS3RqL1VmRTZmV1ZaU3Nyb1dQTGl3?=
 =?utf-8?B?TkRLRWY4anhzdXhRYzNwMHgzdG9POUh4ZG1MSk8xUm1lUEhBTTZKNElvS1F5?=
 =?utf-8?B?b3pCSWhDQ1Rsc0xVZHNWR1duOGxBY0kwM3VVWEJ4RmZTNGZRazBUTmlVMFR5?=
 =?utf-8?B?UVhuM0VjSkxJcHpqbFhPNkdtMG00NXpwNlp6TEZuQVlKbGQ2MWxkM0k1Smwx?=
 =?utf-8?B?VHhXV0VnbENmS29uNzZGdXZ2a0h5VnQ4Ui94S0VLUklJOHNnVTE2am4ySS9E?=
 =?utf-8?B?WjZWWHl4VDVuWExxeWRzQ2tsV2lhWXZHME1tSmRLNFoxYWZCRTFVZjFTdkJa?=
 =?utf-8?B?T3VLNjZOcHFlY01pNWFQVWl6U1prUjVlM3Z0ZmJOK2x6RjZGaVBDZDUyOGwz?=
 =?utf-8?B?VmIwVUNyQjlzVEkyMTdNbFRaZlNXVTFBK3JZNThIVkMyZ21GNTc1ZytrTlZw?=
 =?utf-8?B?L2RNTzZEL3lNVXkrMVhYMVQ2Tm9FQjB6bU1EbFBFalJqNjhxcTQzbnJacW5B?=
 =?utf-8?B?MS9LRGxrbUdGbnpnMmozaldhRUY3bjVGZXV4RXNsMDRSbjE2ZkJtVCs3eFNB?=
 =?utf-8?B?dEN5ZGpaRXVpTHRST1hDK0Rqc3FMMC8vL05aN09ubll5elI5UFlGS3F4YldN?=
 =?utf-8?B?M3BtTWxKd0FyNk5VVkdIMXhKRHZ6OVdHUzZGR1pKMGx4VHR4TnlwMVgyRWxF?=
 =?utf-8?B?Qk9uN1ZaU0J5RDBnUjNWQnRSOEZZUlFsKzU5MTlValVmM2ZUdnNoTzJFcjI5?=
 =?utf-8?B?TzFKMlZhVVpWUllBZ3VoQWtWTTEwOUVPN2UrS3BNcGJUTWxyMnZocE9Mb0lQ?=
 =?utf-8?B?YjY1OXlyNlBpc3lmd0V0OW5LOHRBSkpTQWxFM2EzVS9vcXNneHN3MUM0b1U2?=
 =?utf-8?B?Mys5ajNBRTRncnBvaEd2ejQ5OGE3Nm0weFFRQjh1VkVRaGJlOUFhd3lXMXBS?=
 =?utf-8?B?N1dUbFA0bTlPWHh0VkVtMElwNktqMy9QYzk5WlBSVGthUFA5Z2U0SmFraXBt?=
 =?utf-8?B?eU9YemNobHpZWGtjSVBOdUZ3dFhaQUZZWmQvOUpibVdwOSsvcFRsQit0VGNJ?=
 =?utf-8?B?Wm5KNWhWakdjUnhQUjJQZDRkS1BhYTFCT2hTTVc5UVMzM1hXdWlXZWgxSGt1?=
 =?utf-8?B?QjFGOFV2aTFYS3NxdGJzZFkxOC9zbUJTTU1Jb1I0ZUdUMHRVbHh3cWpHUTlr?=
 =?utf-8?B?eE1CSkR0MWdVMTlFMnpSTjBHaVplUFp5ZG56YVJEb0QyUWNtZktVeFlvbU1i?=
 =?utf-8?B?WUt0Z2loZElRSEE3RXc1dlB0aVZQL1ZEY0NBNnA0YTdnYjhkVDY4MTVyWXR0?=
 =?utf-8?B?T21pc1Vqa1ZPNGZHR2FKWjVOQmNhUHZJNlhRYkdBUHUvNklmUnJsTGZuSVI5?=
 =?utf-8?B?K3hGeUVaY0RUVll0aGZDeGtJdmN1azZzWmJHSW5oazExalVQakpiblZhQjZx?=
 =?utf-8?B?bnh6ZUtvU2hiaVRuc2luQjM0N3lDZ2Vkbks4SVI2a0xjTUtjUVpzTTM4S3hT?=
 =?utf-8?B?clk1eUpkTExOZ05iM1dVRTViTjNFRVFzeldGcDZkQndEblR1aU9PR2pyNkpo?=
 =?utf-8?B?NXpVRmRUNEhTQkVPTTFrS0JReTQ4S3JMYlVtOWNMN1JTREpycWRjNEgwVFpk?=
 =?utf-8?B?aThXNTgvWUVRV3J5RGZIc292Yng5NFNPYTRSSXVscncyWU85Q0twZnBRckxo?=
 =?utf-8?B?QjRjcnNuRDZQclRiOFBYdCs0TE5HM25MaEU5dXRPN1dKSXNCY0NTTmc0eC8r?=
 =?utf-8?B?VHNtMytWYkZsT1J1M3ZVVE16NStUUEtxN1I2VEJCVVY3Mk55MmVzWnZzWWpY?=
 =?utf-8?B?dCtiYlNCVmFoK21WUEhBbDBmdEc1bFY2UjgwY2ZOd2lnOUtjT1ZzTm9NL2xN?=
 =?utf-8?B?cU1LSGhCYWpJRjBQVEQrSUVCVUJielM5anI1SVhkbUlIRnJSY0IrclVjZlpk?=
 =?utf-8?B?ck5UdUhKZlVDRUt3MGlRdVFKby9MOEpOTlJSbmp1bHVZclMvcC8zMndWeEVI?=
 =?utf-8?B?Q0RNVDJTM0RLQi93L0c2RDZ2NFZyNU1kTXAvS2VpckxkejZJSzJpNmpwc2ND?=
 =?utf-8?B?VytTQStmR2RpZWg1dWxxL3hDQ0hEcmJ4WTlSRkRoSW0xT09qckkydnZvelhh?=
 =?utf-8?Q?ztB9SQdtXGqsRNRvYKjevGw7N?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VTYIPTSWO65Um4tuqW07ksjFU/g4lrzIfLJ22OyQTFmVmHKA9gApcbxUFEYF/hRT0WKBzHjMx4jb/MW3yNbg9J/Sc/P2gIqdCJIqckzVbqbbLNjpe7LkAKLtCqi4tBFl6inHgjmz/x+U1xzJumYxYmxJqFPxTuehGj/ftDpdw5ZASmh8wr7LUdII6LAm9WQS4R19Nbob3rbBkUBru16xR2xdE9IXn3GtIjs6RTJKaRIrjLuRBAU/hLeM4Gsjj47QkkWQnVjLIrMS9Su71kk4DuKoopGzqUUifVUKLSLD8GtkOhe7v/K9KhdVvG27nWCP95nMhziTBXODsRMqZRmKM8pyay1IIhV8eYkpEF0WjCorY14g2oh8oNHCCgPI8NolqAP4GRvgcsBxEELg01BYxKuOBqifRH4JIdGQ8ZrXiMwUwOq6lGn1NR83y9fU8LfjQLT/olGzQGi8UKrYCMRUb3HoA7N9taRGrbYpk/bu97x7p+Bak1ozGEcU8DXnLiS9GQS5h7IxQICW6jFJs+JxylK5lNR78odbsGyLuaEe4fPCUgM6P0Rdb1xYpSs/59XXrA3uGRKZWOd4QSVTNWfqpKOrpFQrDce/mLuhm1dIAkY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406c915f-13a1-49f3-addc-08dc60cb6676
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 23:49:49.4811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PU5Y1MVWP8cJ1sLfvAbKypoOcjbZrPLFIIBUpjuHXW3iqIetXTzuXGoozC2147iG9wH8N9APYwTSB0jIitgO+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_16,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404190185
X-Proofpoint-ORIG-GUID: oPH2Pre2LYjLv7SPzJh0nMLjLC-CFk1H
X-Proofpoint-GUID: oPH2Pre2LYjLv7SPzJh0nMLjLC-CFk1H
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



On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
> On Thu, Apr 18, 2024 at 10:46 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 4/10/2024 3:03 AM, Eugenio Pérez wrote:
>>> IOVA tree is also used to track the mappings of virtio-net shadow
>>> virtqueue.  This mappings may not match with the GPA->HVA ones.
>>>
>>> This causes a problem when overlapped regions (different GPA but same
>>> translated HVA) exists in the tree, as looking them by HVA will return
>>> them twice.  To solve this, create an id member so we can assign unique
>>> identifiers (GPA) to the maps.
>>>
>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>> ---
>>>    include/qemu/iova-tree.h | 5 +++--
>>>    util/iova-tree.c         | 3 ++-
>>>    2 files changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
>>> index 2a10a7052e..34ee230e7d 100644
>>> --- a/include/qemu/iova-tree.h
>>> +++ b/include/qemu/iova-tree.h
>>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
>>>        hwaddr iova;
>>>        hwaddr translated_addr;
>>>        hwaddr size;                /* Inclusive */
>>> +    uint64_t id;
>>>        IOMMUAccessFlags perm;
>>>    } QEMU_PACKED DMAMap;
>>>    typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
>>>     * @map: the mapping to search
>>>     *
>>>     * Search for a mapping in the iova tree that translated_addr overlaps with the
>>> - * mapping range specified.  Only the first found mapping will be
>>> - * returned.
>>> + * mapping range specified and map->id is equal.  Only the first found
>>> + * mapping will be returned.
>>>     *
>>>     * Return: DMAMap pointer if found, or NULL if not found.  Note that
>>>     * the returned DMAMap pointer is maintained internally.  User should
>>> diff --git a/util/iova-tree.c b/util/iova-tree.c
>>> index 536789797e..0863e0a3b8 100644
>>> --- a/util/iova-tree.c
>>> +++ b/util/iova-tree.c
>>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(gpointer key, gpointer value,
>>>
>>>        needle = args->needle;
>>>        if (map->translated_addr + map->size < needle->translated_addr ||
>>> -        needle->translated_addr + needle->size < map->translated_addr) {
>>> +        needle->translated_addr + needle->size < map->translated_addr ||
>>> +        needle->id != map->id) {
>> It looks this iterator can also be invoked by SVQ from
>> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest GPA
>> space will be searched on without passing in the ID (GPA), and exact
>> match for the same GPA range is not actually needed unlike the mapping
>> removal case. Could we create an API variant, for the SVQ lookup case
>> specifically? Or alternatively, add a special flag, say skip_id_match to
>> DMAMap, and the id match check may look like below:
>>
>> (!needle->skip_id_match && needle->id != map->id)
>>
>> I think vhost_svq_translate_addr() could just call the API variant or
>> pass DMAmap with skip_id_match set to true to svq_iova_tree_find_iova().
>>
> I think you're totally right. But I'd really like to not complicate
> the API of the iova_tree more.
>
> I think we can look for the hwaddr using memory_region_from_host and
> then get the hwaddr. It is another lookup though...
Yeah, that will be another means of doing translation without having to 
complicate the API around iova_tree. I wonder how the lookup through 
memory_region_from_host() may perform compared to the iova tree one, the 
former looks to be an O(N) linear search on a linked list while the 
latter would be roughly O(log N) on an AVL tree? Of course, 
memory_region_from_host() won't search out of the guest memory space for 
sure. As this could be on the hot data path I have a little bit 
hesitance over the potential cost or performance regression this change 
could bring in, but maybe I'm overthinking it too much...

Thanks,
-Siwei

>
>> Thanks,
>> -Siwei
>>>            return false;
>>>        }
>>>


