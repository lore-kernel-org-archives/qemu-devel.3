Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78980C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOVo-0005wF-Pn; Tue, 23 Apr 2024 18:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rzOVn-0005vy-4q
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:21:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rzOVj-0003Ki-1O
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:21:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43NJdArI025454; Tue, 23 Apr 2024 22:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9/CKNFDknE4cEXLdhLfMqQNeoNQzkzskUxrCsoM4kbg=;
 b=OrDsfhuk2rF6+HJrkxF8iAf93ZCnOIwws4/FSVmqacVMRtrqWgDOOsHmBSbxdzX6GCqj
 +yNhlSNiq0QPpehdIqZEOUs+dtyxJNg+ZxGB2jOefx5lVtG0BK+9RypTCRpU60UsO+jW
 +yIm5Q+1+l8ydv37GwfjcLlcV7f3zjVJmizHqxAKVBzNT0Fs8xb43iR7+pSkDE0IHbaW
 CfZF9QDBfay7wN6rc5uAlvKPANlxSCmjU8OJo1OfwPPycp7SNYfRhXxlxZwPJhVro8wZ
 vCeGxRuhumXQV8+E9sGW6UpprXZEZWN/yyRD0Fb7yxzgVG5PZ+fFyUxuXu9s6fcuvxV/ 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2f7nd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 22:21:06 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43NM7x3J001813; Tue, 23 Apr 2024 22:21:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xm458fae9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 22:21:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVKcFYo55LHrCtCGpQc4aIMSk0AWrOww4A72IuhmBMigBcCTeNck31ftpTG6k7YDcIH9+QozBTqF/2kAXE/ELVQqrf1z98kfAZYZBcUcpwNrz0bAdPFmMyL+xSPZzqusgduIPKwHOqHHO4QWyslHCpyvJzE25rbVl65HmSWSTFSHZDjysdcHVOILh1UVZ78AUlc7kdKbUdtF/DZjnVwdCB8/HnBHLV3PcY7mAwTA/Mz1jTZw54fdc9IFC6o/FyA0UqwZ+W1bBkmNhcsCchGRZhn3yBvy2K2G5aairRa5axUXEDN8A4fEaMJ3vyuJNTktsRBuvhtxYGbNujZKF0MiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/CKNFDknE4cEXLdhLfMqQNeoNQzkzskUxrCsoM4kbg=;
 b=ClccYdbFFeLh8bCKe94rAtYbUxKlYGFx8sspPlQ9Q1xsRmDBWH1RfwgrK1hX6Qih5wV9Le6gQD23W3dxT8sKxXCut8DlLxzlzf8ftMWnuHIcIG+aKLJg+HMtUG1VZLX6nNHihDyNgIs/MlmHiYETmbgH967WuN3V5Z/0HmPBXXW4Ah4YxmWRwNTqhiw0A5Em4EA/waKG2XZTYhHHvpy142XZOxbGTbgtHxe9rTT0GFhqOqSk7VNwnVIDI3FgUBqdqGHjomHfrFAt29JQZ6P1QVDMmmpqMoXUeuK4fe3T9V0nWLU4xKWln21B+dNLQn19ZISGSBp142h1JgdWOrbP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/CKNFDknE4cEXLdhLfMqQNeoNQzkzskUxrCsoM4kbg=;
 b=Iy3DY4DLjQl3njDHw/SBE3Rgy7IvBw1OssBjnlfxQ8XRseCW6aJXhbFJ483tYhHGzd92gM/L5gSyAOUPbTHE0ufwrGqyeYBrKI0M09g7oPq206o10G0TvYhD0dwlC7sbZGRITXjT3HA6196btD6JRoGtcw8qgw6cYDr3zagq9Qg=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA1PR10MB6318.namprd10.prod.outlook.com (2603:10b6:806:251::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 22:21:01 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 22:21:01 +0000
Message-ID: <f2dcbc76-f90f-4abe-b5c3-f159befd07bd@oracle.com>
Date: Tue, 23 Apr 2024 15:20:56 -0700
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
 <450d0da1-3d11-428b-bd89-d09a2964cdb1@oracle.com>
 <CAJaqyWfXNQJQdTcJ9V-mSUrMs9up7rpAMwyK-qB3BuJwbUw+5w@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWfXNQJQdTcJ9V-mSUrMs9up7rpAMwyK-qB3BuJwbUw+5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:208:160::38) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA1PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 214d4f7a-7688-40c2-cf28-08dc63e3a80c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXJKUmN0RzVHeWk5QVRMYUcxYmoxYWhscVljVk5WV3lJWjFITEE4SmY5S0ZC?=
 =?utf-8?B?OTJQWG4vcitaZjhuUlQydVIrRkludWQ2WnMyNWxNV0FTZjV3U2ErMWNZaUUz?=
 =?utf-8?B?SEVGaUg1TURLVUNEVjBFdW9Ua0J6cTFnWXdvQ2cwYXJuc014akE4WmVPbjVJ?=
 =?utf-8?B?UVlFUVpLcjMza3NuWmhybjVHN2owS3ZsbUFNNmNhU2FZRTZ2c1V4cjFLYWU1?=
 =?utf-8?B?RWYyRm10RjlheGFHVS9hU2R0OUFZb0tpZ0Q0SVNtZ05GN1ZxdnFKdDVqcXQv?=
 =?utf-8?B?enpGc3BiQnBkSXh6ZUNSYkxhUlZlbFU2aGlnbEl6YTVyZkVTRnQ5VUhFczRE?=
 =?utf-8?B?Vm84eGsrZVpTZUpPbmU4eU41Q0hWZ3NVNXR6SFRkcXM2bzZ3RW1Ka0t4UjJl?=
 =?utf-8?B?bFNaWlRvMWJtSDVzNlpRMWZaT3p1cTVvb3dML0h2R0ZWQVZUMnVuQ3R1NjRr?=
 =?utf-8?B?ZFNWbFp5NHFTSVlOMWxjNXh4amNrMlQ2RkNVSlFqZzZIWHNEMDlDMDEvYlh3?=
 =?utf-8?B?ZjVyM3BRZURKNHdDeUQzbzFzdGllWi9XV3MzNUszbjFLd1lQa3JaMVlyWS8x?=
 =?utf-8?B?aHZHQmRudjhObkNGYVM0NjRKK1JYaDRTWHZJTkg5WXFuNWQrU01CRnpDYU9Y?=
 =?utf-8?B?d3JKOW5GeFhwNWdYQjJKU2hEbFcwNDRSVDhpL3BqMm9EWXZXZG4yWUZWZENL?=
 =?utf-8?B?R0xPT1RGRTBVZkY1T1V3TmVVcFdwSUVpYTFYbzlOTEkvUmZ6OVJFeS8vSTVB?=
 =?utf-8?B?UkgwM3FZVlp6Q2FVZUZaZUE0REV0S2RtYXJXSkQ5c29relZxUFhSdUp6WHll?=
 =?utf-8?B?VWFTKzhpRWdTS3BxNmswQTlPL1JLU1Nob1F4SkJ0M2luVXlLUDl1dkFiMFF3?=
 =?utf-8?B?ZkJRQUhYbkdWTFdadGhqc2JOeHRxUDlCSUNwOFlDS2hLMDU0S3FzTGJ1TFZQ?=
 =?utf-8?B?UzdKUVFOQ0dqc09vRXRSMmoxNmNnTDVFR3BvUlFMb3JkUVhoNFE5eEVBcmw2?=
 =?utf-8?B?K3BqMjE3R0FvNmhoMG5VM2VyRXBvSjRDZWF5dEF4KzhXb2dndFZTMndxQTQ4?=
 =?utf-8?B?UzZvd2N1ODFESFBhNzJBR2dSK2lEaE1CSXNWRk11SE5sN1dRTThTYXNqSVgx?=
 =?utf-8?B?eVZWME94VFBDc1dUenN5SEJyRGtISHppMXdrNk53T0FoQkV6Q0NTeUJHWk54?=
 =?utf-8?B?S1RyZmc2bVNNRVVpcGQ0QTVJVzduUjFlRXgwRlJsL2J0eWsrNlk5NkRBMVlY?=
 =?utf-8?B?YXBYbWZuSi9veXRYU2VXemVDdzcrZW5zT21yS2VlZzdVcVptT1VkUUF1eUdC?=
 =?utf-8?B?UlN3WWx6SmJtSXZpcC9TNEdHNDhsSDZ3NGEvTlN0dHp0ZmJERElQRk1GQjhM?=
 =?utf-8?B?aWx2ODZWcnhsek9BYXN5RmhDVEFzbkNKK21VVXJlUC8wZlRaZjFaMkdOaVhu?=
 =?utf-8?B?ZHl2NTErR0s0ZXRGZ2Q2bEJGd3dRdlJlSHJDVU53K1l6bFU5dnJac2pHNnZv?=
 =?utf-8?B?MkxDQmN2WldqR0phdFVzT3VMUWhqWkt4ZjNhdEQ2ckc1cFVjTGc3SWxaejNx?=
 =?utf-8?B?RzQrbUlab2ZKSjRIbEFnYW5LbFFxdDNPY2JyakRFMDhVaVY4KzZxUExDRjA1?=
 =?utf-8?Q?mR7YDhytCJTQWbylPk8OV8T4F8ITEs+OSFJSxzb7SzEQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU0yWWdNVnNpc3Y0QnVEQ0UzVVhvL1FZSGR5Z250dGxEdWg4Y0lHWUlpamty?=
 =?utf-8?B?Ym5ZMTBLclRJMVJUbngzUHIzVXhqNzM5YklKYlBHZ3RIOTY3MHdpekxlZXF0?=
 =?utf-8?B?MCt2bzBUMzRsck0yWEt2ZVhTOVN0c0J6cDYrRkxVRldRb1NMWmNGazR1MkI1?=
 =?utf-8?B?cXNKWU9DekRnSVVVbkEvcEh4YzY1NlVtaElDbmtzNVZtdlQyRE56L2Y3eVlN?=
 =?utf-8?B?cStmam1Ccm51aTBmemVvbzNLVkhyUVVxVjdPRW1HUE1VSWY4UWlFeC9sUTQw?=
 =?utf-8?B?eklqNGZoY0VEUWRKeE5udUlST1E1L050UkpRazlZZ04ySzBqK3R5cnY4L1cv?=
 =?utf-8?B?blhud0ZvVytuMng0NEZ1N3Zabm9jcEFNM0loZldwSjBQbTF3QXhvcXdOVTlE?=
 =?utf-8?B?RWcwVGM5d1dZUFdEdXl2VXVUY0dGaHFBNVdsSjZYK0hwV1dWTWJVSHR3TWJW?=
 =?utf-8?B?TmpNejB5K0ZZMzNNSnN4alJycjJFQk1JMU5QQldaVExadHZSdS9Rd1ZtMVYx?=
 =?utf-8?B?SmhwSXZGL0ZiaVBxUGxGZzlIVWFNaXZBc2traDAyNW51bGxmY1lwODhYcmNF?=
 =?utf-8?B?b3NENWdTMVFmb20zZ1FXWiszZUJOTVBvRk5YVWUyUkxuaVN0UVdHTHZqNlhB?=
 =?utf-8?B?SkNrM0NKenVqZERwTW93MU03cmZuQWo0UzJSNXUrNUhwREVhU1U3T2hSUk1F?=
 =?utf-8?B?MzBBdUpFRjZuVEh2cGZsNTk4TUlLeU5QaisvcmNNS2dYU1FnY1N3eXo0NmFU?=
 =?utf-8?B?SFA5RVlIOUxjWUs0N00wN0UrUStaL3c3bjR5VWo0WFNrOHJuSlFCb3dHYzNQ?=
 =?utf-8?B?bmM4eDJub3JtK1V3YzRVMnA4N3lSMHJDU0lRV1dMYk9tclJHbFRBQWpTWE9M?=
 =?utf-8?B?d0hMOWZwMVpEanBDZnY2WnY1UkhTeFZlWUs1RHZWM1V2VjJjNXUrWW9VQUta?=
 =?utf-8?B?WmtSeWY0ZDd3NkE2T0wwbWZpRDBGbXdBWlZsVk1IaHJsUUtpTHFNT3FEQUFr?=
 =?utf-8?B?U3NQTmJacnVTaVlCRU91UjBOWVZUTkNhN2kxa3JPeXlmUkF1QWZrTE1FUkFZ?=
 =?utf-8?B?NWdGS0t3ZVZlY3gzdFlNYjFaaTZWMHF3WjQ4Ny9mS0pFb29hRm9pNmk5cm9n?=
 =?utf-8?B?ekZEUy9tYXZDcERlVWFZMGdqTnlIazlGeW04TVVodDFrbkhtR28ydmg1cVEw?=
 =?utf-8?B?aDRSOVhEeEsyTEpQNDE5UEdDWUZGWVRobnV4KzRPblBCVjVCN2tQMDVtN1Z2?=
 =?utf-8?B?ODVIbDFVeVdoUnYwWlJncFlqak43N24yRUZVR3QwZG0wS2lxVnhpUGVpMnJB?=
 =?utf-8?B?TzlpSzlFMisxOEFqSHpDUnFyTFl1SDIwK1JlejJjak1rL3pMc2o2R01sUGdX?=
 =?utf-8?B?anlaRWx3eG1yd0pBeHZqN0laZXNpdWxOYlNTWTNIZXBOaGVmZC9IZGZaSnlB?=
 =?utf-8?B?K1dIMlZneGVqZXJ3S0JTWklCL0hVYkR3ZHVURU5QMzg2Q2VGK09MeGZZVE45?=
 =?utf-8?B?c3dQSUZpdXEvNnVWcjlZT05oK09ta3pJNGJlTVU3RlhRdWRWWHNTRlFtVDZu?=
 =?utf-8?B?ODI0N3VSRVFibE55RDhlbjc5TCt0bmkyNmFwS3Rzak9hL2xmdFVPS0FFUjcw?=
 =?utf-8?B?K2tyVGl0NzVTNG5NVVFvek5SbEJ6d3BVWDU3KzRnUGlzek5CbXZOV2htSGtM?=
 =?utf-8?B?eC9SZUlHUnB3ZHpudFU4eXFzTC9PNFIzRWZjNzh6Qk1tbis3QW1ZRWRsVzhC?=
 =?utf-8?B?dkRCN1l6M3JSN0ZhVUEyRFZTc0d4b3hDUG9oVXprM2txZitJVWpCQUdESW5H?=
 =?utf-8?B?Nko4MEFXQ0JUaHVTWlF6ckVIcms5UzFNTXg4ZGtnZDBjQ3E1VFRlRklCUjFV?=
 =?utf-8?B?MVhDNnFxb0FWSHQ1emEvVzJ3aU1HTlY2eW9zQlpJL0pUdnY2ZGpBSWo4Q1JS?=
 =?utf-8?B?MkZxTlVpTXlLRCtWSGduVG1lUG9KWDJwdm9yRG4xY1EyVDdqUzV2eEM1dmRI?=
 =?utf-8?B?dDk0Smo2aVlqeUg3VDZTUDFtWmxEQ2xudmw4OFhRbFY0dWJJT0ZYZ3dzK2xl?=
 =?utf-8?B?K1lOUHVFOGlTK0FCS1NUbEdvMnVDZ3JiT2VxdVF1SUNkYmZsTUhiaHhvWGZz?=
 =?utf-8?Q?ZBiYrr9WfJH1wqwMAo+5bq3Qp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WCm/la6xQcEkyNDxQVsg8jS2qLi6Yy25w4JJz2YLnf2m/yb0faeLuBms/6D04i1lDsk+KHY1njaCtevYjDYN2z8p0oY7b3ALyaAtttbyqak6JDwisJj2zCAXxK8dmo7Nbgvh+CEuZIfx+/F5HG5FidxxHX9ArXf6TDQi43SQDlMRgCYYKJZddbfyJmxYqkNzZuiuJfuT/vznQHAqv4vBfT6mhfhK10NHb/otAovgethdAYOco6iPS8t8+MyVHKjRLRj5U2oJhqvJDv8HbYX1U9z9gT2XmxhsqRDynzStiWRb9yglxOHP6qyFjrG0NHhPXHxyWFzl/i7+qLihzRtK/nD+OPyaVoIBm4TrzDdgizxtgZi8yPJagZ6SS9HHaUiQmTFuEHvbOftrsW+NB2zEDUICH2Cx8ck30zC3nrzNLk+x3yEIbyjagNj3TA1H+MuoHLXSXP9zybv1i+fuDTtuDWq18ZusFiiCiuPr4h+uATu7F2Y5qUgahvrL3NIHkqvjpRpjqO56vCMm+gp6Av8MQdjXacEyg1LTi+eudsb8YhzfNJPCnCWfE1yqVoB0wzhORR62LSiA3d8V4OPHoc6sBoSRzwaEZc76wLkY9WjXxeE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214d4f7a-7688-40c2-cf28-08dc63e3a80c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 22:21:00.9696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3xsVL3BrL3OjO9kR0jZKgDa8S2fal7cJQK/dM5CgVsfPmupWI8BBXk43NLbaXgae4LqAOxA54csgkNXwlwRbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_17,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230058
X-Proofpoint-GUID: 6RmERCYTa0df913Lra1aLtsjoN4QiyaI
X-Proofpoint-ORIG-GUID: 6RmERCYTa0df913Lra1aLtsjoN4QiyaI
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 4/22/2024 1:49 AM, Eugenio Perez Martin wrote:
> On Sat, Apr 20, 2024 at 1:50 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
>>> On Thu, Apr 18, 2024 at 10:46 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 4/10/2024 3:03 AM, Eugenio Pérez wrote:
>>>>> IOVA tree is also used to track the mappings of virtio-net shadow
>>>>> virtqueue.  This mappings may not match with the GPA->HVA ones.
>>>>>
>>>>> This causes a problem when overlapped regions (different GPA but same
>>>>> translated HVA) exists in the tree, as looking them by HVA will return
>>>>> them twice.  To solve this, create an id member so we can assign unique
>>>>> identifiers (GPA) to the maps.
>>>>>
>>>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>>>> ---
>>>>>     include/qemu/iova-tree.h | 5 +++--
>>>>>     util/iova-tree.c         | 3 ++-
>>>>>     2 files changed, 5 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
>>>>> index 2a10a7052e..34ee230e7d 100644
>>>>> --- a/include/qemu/iova-tree.h
>>>>> +++ b/include/qemu/iova-tree.h
>>>>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
>>>>>         hwaddr iova;
>>>>>         hwaddr translated_addr;
>>>>>         hwaddr size;                /* Inclusive */
>>>>> +    uint64_t id;
>>>>>         IOMMUAccessFlags perm;
>>>>>     } QEMU_PACKED DMAMap;
>>>>>     typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>>>>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
>>>>>      * @map: the mapping to search
>>>>>      *
>>>>>      * Search for a mapping in the iova tree that translated_addr overlaps with the
>>>>> - * mapping range specified.  Only the first found mapping will be
>>>>> - * returned.
>>>>> + * mapping range specified and map->id is equal.  Only the first found
>>>>> + * mapping will be returned.
>>>>>      *
>>>>>      * Return: DMAMap pointer if found, or NULL if not found.  Note that
>>>>>      * the returned DMAMap pointer is maintained internally.  User should
>>>>> diff --git a/util/iova-tree.c b/util/iova-tree.c
>>>>> index 536789797e..0863e0a3b8 100644
>>>>> --- a/util/iova-tree.c
>>>>> +++ b/util/iova-tree.c
>>>>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(gpointer key, gpointer value,
>>>>>
>>>>>         needle = args->needle;
>>>>>         if (map->translated_addr + map->size < needle->translated_addr ||
>>>>> -        needle->translated_addr + needle->size < map->translated_addr) {
>>>>> +        needle->translated_addr + needle->size < map->translated_addr ||
>>>>> +        needle->id != map->id) {
>>>> It looks this iterator can also be invoked by SVQ from
>>>> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest GPA
>>>> space will be searched on without passing in the ID (GPA), and exact
>>>> match for the same GPA range is not actually needed unlike the mapping
>>>> removal case. Could we create an API variant, for the SVQ lookup case
>>>> specifically? Or alternatively, add a special flag, say skip_id_match to
>>>> DMAMap, and the id match check may look like below:
>>>>
>>>> (!needle->skip_id_match && needle->id != map->id)
>>>>
>>>> I think vhost_svq_translate_addr() could just call the API variant or
>>>> pass DMAmap with skip_id_match set to true to svq_iova_tree_find_iova().
>>>>
>>> I think you're totally right. But I'd really like to not complicate
>>> the API of the iova_tree more.
>>>
>>> I think we can look for the hwaddr using memory_region_from_host and
>>> then get the hwaddr. It is another lookup though...
>> Yeah, that will be another means of doing translation without having to
>> complicate the API around iova_tree. I wonder how the lookup through
>> memory_region_from_host() may perform compared to the iova tree one, the
>> former looks to be an O(N) linear search on a linked list while the
>> latter would be roughly O(log N) on an AVL tree?
> Even worse, as the reverse lookup (from QEMU vaddr to SVQ IOVA) is
> linear too. It is not even ordered.
Oh Sorry, I misread the code and I should look for g_tree_foreach () 
instead of g_tree_search_node(). So the former is indeed linear 
iteration, but it looks to be ordered?

https://github.com/GNOME/glib/blob/main/glib/gtree.c#L1115
>
> But apart from this detail you're right, I have the same concerns with
> this solution too. If we see a hard performance regression we could go
> to more complicated solutions, like maintaining a reverse IOVATree in
> vhost-iova-tree too. First RFCs of SVQ did that actually.
Agreed, yeap we can use memory_region_from_host for now.  Any reason why 
reverse IOVATree was dropped, lack of users? But now we have one!

Thanks,
-Siwei
>
> Thanks!
>
>> Of course,
>> memory_region_from_host() won't search out of the guest memory space for
>> sure. As this could be on the hot data path I have a little bit
>> hesitance over the potential cost or performance regression this change
>> could bring in, but maybe I'm overthinking it too much...
>>
>> Thanks,
>> -Siwei
>>
>>>> Thanks,
>>>> -Siwei
>>>>>             return false;
>>>>>         }
>>>>>


