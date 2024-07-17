Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA1AC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 12:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU3qS-0003Ph-2h; Wed, 17 Jul 2024 08:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU3qQ-0003Jv-E6
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:33:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU3qO-0004hU-3k
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:33:18 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HCPpvD001182;
 Wed, 17 Jul 2024 12:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=jruDgCwEL24dXRcKy8Y/ywIyx2fkRDH6xnzHVhYFkqM=; b=
 kt/qgTaPaV/iGqDYSMO7IItUOWTmcCF6TBzZlRlzCoz4cHvvcYvI2Jhyh7scdyBM
 Xbc3nVcVRW4yjSf/dzFnb93I7pZxDOk8A+L21svZj74rtmkhT6U61iVfadio0EL7
 kh2ZzIGNyJNr7YK7vyWb/FR7vOyr0KX+cnm/3nu8zDWKoZjTrwbiRDSPs8QHX1q1
 d6jDOeJ9aQIHF9k9J69/YJTj6FZn3F5KLtQxQjGAu2BrwRuE6BWk2KFnhA6ijFws
 ZppmQmu47KkzH/ZIZCw/MTiaDC2SiRktNS/R1a3BXCOpf+ExsPUdzQvbY8ZrV12m
 1WlfvmISSbLynOqOWaDQLA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40edxpr0hj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 12:33:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46HCC3Ul003630; Wed, 17 Jul 2024 12:33:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwey0mjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 12:33:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nztD/5WREGKi/EiNGBg5JO0H6XlhM8bTqqc91RDnK/pNKG38lsc4xWluXnDBLcw4fAWDKLODfAxhbtr15ymJMaFwl797Rf4TcocXuKEbFNicVK8YszzciM5atISfi/kA4B1AMH76awRNivOiZku3jZEghZDejoXBdVFA/vGttKRg9eOtZWpztIdACqMmiVes6YpkhiJlQ6QLz/6bnJjNk33nLNiu0BVFbaoPB4/JnphZ920oSV0jjwBs7a86m+2OfgFXqRLcdsM/REip5aYK/KjZ6594sSIAUTTbtMKPEz5rkV9oOUlrz3rOGS52c/CC0tvj/nbHQ97xFAYVvPfVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jruDgCwEL24dXRcKy8Y/ywIyx2fkRDH6xnzHVhYFkqM=;
 b=pV1o4iLuwWUHvcKQPHB4jhLm+N4rj8Na53iRJ/m/ga0RZ5YDW0qLVXBD8mACpHl2CF48Mbvxa7IjnybZGlGxqEI+bKwaHhk+Me6eGc2csJDdymwRXOvITEPOwCjxGSWO1fOnBfhX3+nqCRAnSVTMUX0y+Ci3CqR61KKUogmp8aAaZf03hU5GQ02+yGzHfldc1T18+E3VyWllH3aAlzUPjNGIoBMrqwhcXxo3nWnT3u93eGGO6xFDy5A0wUIrzuEX0yVdL63i8g6c8x15Od1pU1QFImehFF+rHVQoca+7kLn4SVkKkJ4KzH0kUEmng+zrcDbkMbuhi3iBDaxdfTKtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jruDgCwEL24dXRcKy8Y/ywIyx2fkRDH6xnzHVhYFkqM=;
 b=NXB90sRQ2LFLPwJBkDpcA7+U81yW2c4XuHi2RWzGohjEV0e5wpclQVYi6M0DlU+6mqtLyheaOypwsSRqURj0tRrIawodnu05wNPcGSHXDYnPAh35lQm5jMeG3ik2MNd9n0kRn0VBtlRZ4i0o8Sx9uJ+h1r08W2vRas9/PJqvsro=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Wed, 17 Jul
 2024 12:33:08 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 12:33:08 +0000
Message-ID: <5be3fb70-e4bd-420b-b229-d8f8356cc2cd@oracle.com>
Date: Wed, 17 Jul 2024 13:33:02 +0100
Subject: Re: [PATCH v4 07/12] vfio/{iommufd,container}: Initialize
 HostIOMMUDeviceCaps during attach_device()
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-8-joao.m.martins@oracle.com>
 <6b67c303-774a-44cb-bbe0-24df973ab889@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <6b67c303-774a-44cb-bbe0-24df973ab889@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0559.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::15) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 858f4e58-4f77-4e61-b44e-08dca65c9d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzBEdDl3MWVFd0FDUVczT3RtMC9LOE91UTVWcTQ2QXR1Y1dpMFNYVmhDZzhW?=
 =?utf-8?B?Mzh0a3A0a3FqZUttMXhaSDZnYTlIaS9Rb2xHaTdSWVFBcWlMTGI5OEkzRFJO?=
 =?utf-8?B?TWZ1UzhSbTZzZmp4Q2Z5d0RTZWN2NTNWTmxrSGFZRG0yamRKNmg5ak94Tzcr?=
 =?utf-8?B?NmpQV2h4dkI1T0ROYTM0Q3FVL0U3Y2IvSy9tTWtZK0ZIVDJ4UGhGVmxBaEh4?=
 =?utf-8?B?MDVrNUNpdStYYVZubmo1RWlyTU90OFRvL3JocGtoQU1VUDloSWc1b3ExNXFJ?=
 =?utf-8?B?ZDZwamF1OVR5amFVbkt0RVFCaFVRejFNaHdUSHVLTnlTTVF5cGJrVjFZZEhq?=
 =?utf-8?B?ZmNvOWFHaWYreHhxOGdsRzBCazUzQUNDK0V3YTBPNDZiSXNyRWVwUGJqZDJZ?=
 =?utf-8?B?T2JkVXdURDFCK3VobEhjaGFwMjNWd1BEaWVVQmoxbzRnOWFPbVNNemR3V29S?=
 =?utf-8?B?NHFtcG4wUEJJRlBndjRGUGcrSnNEYm9OZUN0SGlqU2ZhRC9BZUk3NGxlb1B5?=
 =?utf-8?B?d2tjSnhyYzN5S2tsYktJYytnNzdKUFpyWUZ6ZkkwbllTaXlVU3NSS3JMcnlw?=
 =?utf-8?B?QnNwd1JxMVphcEZpaHc5UGRpYXcvTVZ5UVJTMS9WbHBzS090Rm1aMlNEMXZB?=
 =?utf-8?B?TVp5MnV3UHBySm1OOTN2ekJ6a0FESzl2QzIvMENSOHV1ZEJrM0d2ZURTYU5W?=
 =?utf-8?B?VklVYWVYS0E2M25URW1vNzlnbFBkRjRMeTZyRytEZW0zbEVXa25IZ0JWNGRU?=
 =?utf-8?B?alNNbDNXbGkxWUZxekdUaVVSZUZLcmZkdWJOOHhJTThTY0c4QVM2M3dGSG5p?=
 =?utf-8?B?NllVek9mYkJDQzBGMXdpNm5IQWFyUEJKOEVmUXVVSTU0TmZvbXd0d01jaS93?=
 =?utf-8?B?cENxcS9mdWtvWXhsdWFOci9HOVZDZFlRN3ozS2hrTmRlRytaTUNCNXQzQ2J5?=
 =?utf-8?B?SFFrQlNpeWw3NXBYWWlVOENNQVZQOXhMY0swY2w1SzFwWHlFYzhBZXZyT1lJ?=
 =?utf-8?B?WjdQelQyL01JVE40cHNuSm51U3kxTWJYYXZMRUxYWlhpenNUUnBSVHFDaTFm?=
 =?utf-8?B?cklMSndRejBpTnBRKzJidGNUQlBZUHBkY3d5aW5PaTVVUG04dVR5azBsTlRr?=
 =?utf-8?B?SzB4dERUU1NJOUhucFRaSGxBaWgxY2N2MkpGM3VuT3pGQ1NHU016VVdlNmtX?=
 =?utf-8?B?ZTBQK0FxMGwrc1lUU0dLNURUVFVFcHF1c3E5Q0ZoZjFMcFlTMGwxNnZwUHRx?=
 =?utf-8?B?cXVsTDd5OC9tcWVXaHFBaUU1TVBiN0NnZS9KWjN5U1FkUkVvaUlxNnRvR3BK?=
 =?utf-8?B?OGFOSjZLWmFScURVZUk0TlI3ZG5aZjhURlh4WGxPZjBRVFI2VFQ3NGhabHN0?=
 =?utf-8?B?ajFpTWVQR09GTFYzK3JyKzlKbFBSS0d4aGF3Q1FCb3lPaVpYSWFwL1RZcENs?=
 =?utf-8?B?eUtva3gvVWFiRUlYWjNwZTlERGdvazZSZjVoampoNERPODRLSHlGclRJNUdN?=
 =?utf-8?B?YitRSEJOaFo2RHRHT3Z4RTVOTDJXeHlSR2p6Q0JBV0psWGt4UnNsWnFYdllY?=
 =?utf-8?B?Wm81dmsvUFppRWRVTFZVb3lvMlZQSkp2clplcnR1cHJHZElwZWZxeGZ6bWhq?=
 =?utf-8?B?VjM1dzh4a21aM3RvMHFXcWxwUk9OQm14UmhlUHBUZnVmbDduRC81ZGQ0UDJB?=
 =?utf-8?B?VlVnYTIyalZ6VzJQL1JXajFydm50MXR0ZHZLQXlNVzBJYys2N1ZyK3NKcjNR?=
 =?utf-8?B?b3A2b1ZibVo2VlRBSC92dGh3ZkxGNmlHZzBTQzFlMDVzT3R6SVhzSTl6bFR4?=
 =?utf-8?B?VmVCa2pOR0pxQ1NMU2RzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzdvdnRnK2wyMThaRWViMzJPL2U4UjRPQVoxZGVXUzVMVUpsb1BlckJ0MTAz?=
 =?utf-8?B?M2VtNmFPY2NleG8yTHNkYWFiR29PdXAzbGVtU3V3SXp1cmJwQzBkcWJLMnFF?=
 =?utf-8?B?dDFnaThDRXRmTmxkK1JvWFd3V3ArZlBLbFlHNFdjZ2hxeFREN3JucVYyOVFV?=
 =?utf-8?B?QkpRWlVpcUJiZ2liK1Jxb2VyN1dhQzlydDI5aEs3cDYzWWEydG5LVW1oZ2x2?=
 =?utf-8?B?YjMyeEdWeklERDhnUU5CTWNPdHNwcXlMZ2dCUEYyaUxoRHBjUzJFWVNrcis5?=
 =?utf-8?B?eThUcERXSmdYYVFFUi9EZWdJWGREcE55WEFnTDhndnExYWZPTXd6d1FZYkJi?=
 =?utf-8?B?enhMbmdMeVhLRG1zbS9EVVNzTG5uVXdMK2dtc1BibVhWWXI0OC93SlpESk9C?=
 =?utf-8?B?bVFOanhuTnB6Z2I1MlI4R3BZcTNmNFlRaUpHM21RSTRsd2JnRWJkTDlNR1Q2?=
 =?utf-8?B?RHB3MFRIZ3FwNHJGbVpBVTFWKzY1am5QbkhqUTRkdWk3UUFuVFl4bmZNQVVv?=
 =?utf-8?B?aDJtdEtpcEFqUFBLVkZ6QUl1UExtbjdOR1RMdjN1WXU0cWtneXVxVm5JZ3I4?=
 =?utf-8?B?NDFtWmJYU1dTWWxTbWRuZFZzNEJWaEc0cmplMHl3NjVmeGpnQlZNbkZILzky?=
 =?utf-8?B?RVNNeDRnMHc0NTUvUUY2dkhiL3NkY3pvNkNPMHVwMStMOFNLdlA0bHV0dW54?=
 =?utf-8?B?SlRWNm1RR2V1STAvMjJDNUptbVAzMGM4aUhCZHpPSTlxeEtoWFcvT3lUTjlz?=
 =?utf-8?B?QXgzT0IrSXZLMjJlZTBWbGZFdUwzQnJoR2QwVlVqSVpBV2hERWo1QkVFelBv?=
 =?utf-8?B?NHh1UGJMekY3aUtlSFlSTGE0dFFnZHpUSTFxUUF6c3UvbWhYSkk3WmdabElJ?=
 =?utf-8?B?Nkw2bFJvcUNMaEJGZk92R1QvSklodk45UDVlbktHWkthRWl1Rm1maVhZU1d5?=
 =?utf-8?B?TStmdCtLMk1YTGVNZGg4bnZNTkpuZ3RPREJmcDdxcDRXc29sSy9IdEhlMkpa?=
 =?utf-8?B?YmxSY0l5Yk9mcE83Y0d3M3BtT1FaQnpTQ0QwRUh1ZWVkdjJ2Qm5DWGJ1SmF3?=
 =?utf-8?B?SDF2L1NtUGZ2dEtjN2JJT0MxZzRONytQSWRpUTlnenl6S1pXY216TVdxQVlZ?=
 =?utf-8?B?OUUxaUpKdFM4OFFxeWpFNVRnTURUZEl3aTZCbExBdVBMblNNcVRwUjNMTXE5?=
 =?utf-8?B?a0dLQjY1MTg0NVQxcDhLQS83aW9yL1h2ckdtWWNLM2M2a2tOK0xFT25YMzZ4?=
 =?utf-8?B?eGo2SytZUWxqdlQ1aG1aeFdvalVnTzl2dFhYbUVGcDNjcnd5Y1Q5NnhqWFFF?=
 =?utf-8?B?Uk4vVEZsYnJyeDVvcWFqUENSMk5SSnpjSmRiVVFxblBlMXhqZ0hGS2ZBYzZC?=
 =?utf-8?B?ZTF0YWNNUHdMVWZMMEZkNDlxclZ1KzVWOUc4MFhEbjlTTHBzRHc1d2M5S2dh?=
 =?utf-8?B?ZzI5MS83L09TYzEzbWJhTkl5TjN1UDdlL0Zxc3dLd1VlREZLVHlMSU5OU0JQ?=
 =?utf-8?B?V2JzY2ZmeFBYcnYvSmt0NnBKV3BtektYdVJINlJpNnhhc1RZM240SXNGdDV3?=
 =?utf-8?B?ZW5NREJZRmYrTktyZ1h0SDMrQnMvaGtKVmZVeXJVeUV0OVkvWC91NVY2Q2NC?=
 =?utf-8?B?Yjk3SHBZUFRsazVtNjAxcWN4bmxSWllhb2VSZThiRU5CQ3J3dllueGFuclR0?=
 =?utf-8?B?MU1OMTQ1aFBJRzI4bUJGakQ3ZGFtbStnN0phamFzQjJYU0VheG1NNmxHWkFT?=
 =?utf-8?B?VFNkc2VSTktWZk0wazMrUmpDWnY3Njk2L1pvTElSNFpQc1J4TDVxT2FjWUhQ?=
 =?utf-8?B?aTE1Zm5wRVdqSXRUb3hRSXk4OUpPd1JxSnpOZHdyNmtnVVNKZ3l6K3U5S3M2?=
 =?utf-8?B?VmFEcTNEUHROVDJNTjUrSEJlNXVFOG1XR1ErV3hLYTBrazBCSUROVVpHVmdk?=
 =?utf-8?B?QmFmVnlNWkdNVkhDdTNwd3FoN2E2OFo4eWduMlg0c1JRRXFyYVRYdFc3eFN1?=
 =?utf-8?B?M0FBYUpzZnJ5TmdieHdVM2RSR2wrNUQrRlV1QytHc2pKRGlpMHNNMnhhVkMy?=
 =?utf-8?B?ZkRtUTBXbUtKN3ZNM1FFdEZrM1hQTmd0S2FzREVjbnYvMDYxSWVQUkZmL0ZP?=
 =?utf-8?B?U0NTbTROWDF6UFIzTFFSOFJsRkVFenNaSExwS0lPK0k0MElRUFA2UTByU0I0?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NZ+GdIXTTTS78rzdRgXN37i8B2z0ZowW6gCUuPLW1SQjF4pAOdCZXVbe6gqYHVOfAR9/a1WrncpUO2mLgp5ixzoTNYO8Qvx6OvTxXrVN7uJJXgmxQxT94ijZXLF/GXx4E/xfki+Mjf3aQCAb+rDEKv5/bl6FyiYYwtofBOGJZp9YLLdAd5mOXs0o2j0ee5j5UK9kGbO+ghb1G4By+s00wsUIJRrvNBVwR2jkPEvcL0+iFztNp25BXJGZVB9TWL0FpujfFa/LSyINVuSWrZcxjN6GcjCrqFOaIGKt+vI8IglsRMq4JtqGGoPRKhz23jfyMxU3/Oi5DQmLskzFLvKKMHJ2AZrADFGzci5+06LabL9HEBGryZ2BNZq6PEaCfewaaO3Hl4oBDOQJhU86WNqWqCl0SZ34yyNzh8RVW4N+9JahlVi8mWnqwcNOvZKJ+djqs/hQO79dUkIDp1nRgKz1+LTcM2tKKY5hpiopnQfjBJ5rBH7X2v/gNXJGpdq5oFVM3VA2D37XQftBSNKhh4UkiXszCR9NMA7vGP3ToNWZW7458SIeRQxIxiNe1S521W2nR+wwNZqStL0lWTGjh80MXnqCYcYJDRqWevkcyWM7BjA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858f4e58-4f77-4e61-b44e-08dca65c9d0c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 12:33:08.4743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I51Ef3u4WUp3yfXqb4/Ve7HCGGKTnXRPfVZi5krnE36EHHeriIYDc9f2Gr9VAPnJCiJvKS7z1IpxFG2or37TSQygehXQi8VLu/yCy2r042c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_08,2024-07-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170096
X-Proofpoint-GUID: XAAItuAoJG0hTt1hYyapfRcJZDlB8Ok-
X-Proofpoint-ORIG-GUID: XAAItuAoJG0hTt1hYyapfRcJZDlB8Ok-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 17/07/2024 13:19, Eric Auger wrote:
> Hi Joao,
> 
> On 7/12/24 13:46, Joao Martins wrote:
>> Fetch IOMMU hw raw caps behind the device and thus move the
> what does mean "Fetch IOMMU hw raw caps behind the device'"

Fetching the out_capabilities field from GET_HW_INFO which essentially tell us
if the IOMMU behind the device supports dirty tracking.

>> HostIOMMUDevice::realize() to be done during the attach of the device. It
>> allows it to cache the information obtained from IOMMU_GET_HW_INFO from
> what do you mean by " It allows it to cache the information obtained
> from IOMMU_GET_HW_INFO from iommufd early on"

/me nods

>> iommufd early on. However, while legacy HostIOMMUDevice caps
> what does mean "legacy HostIOMMUDevice caps always return true"?

That means that it can't fail, and the data in there is synthetic:

    VFIODevice *vdev = opaque;

    hiod->name = g_strdup(vdev->name);
    hiod->agent = opaque;

    return true;

The IOMMUFD one might fail if GET_HW_INFO fails.

>> always return true and doesn't have dependency on other things, the IOMMUFD
>> backend requires the iommufd FD to be connected and having a devid to be
>> able to query capabilities. Hence when exactly is HostIOMMUDevice
>> initialized inside backend ::attach_device() implementation is backend
>> specific.
>>
>> This is in preparation to fetch parse hw capabilities and understand if
> fetch parse?
>> dirty tracking is supported by device backing IOMMU without necessarily
>> duplicating the amount of calls we do to IOMMU_GET_HW_INFO.
> But we move code from generic place to BE specific place?
> 
No because in IOMMUFD needs the backend connected, while the legacy backend
doesn't. Otherwise this patch wouldn't be needed to be backend specific.

> Sorry I feel really hard to understand the commit msg in general
> 

How about this:

    Fetch IOMMU hw raw caps behind the device and thus move the
    HostIOMMUDevice::realize() to be done during the attach of the device.

    This is in preparation to fetch parse hw capabilities and understand if
    dirty tracking is supported by device backing IOMMU without necessarily
    duplicating the amount of calls we do to IOMMU_GET_HW_INFO.

    Note that the HostIOMMUDevice data with legacy backend is synthetic
    and doesn't need any information from the (type1-iommu) backend. While the
    IOMMUFD backend requires the iommufd FD to be connected and having a devid
    to be able to query device capabilities seeded in HostIOMMUDevice. This
    means that HostIOMMUDevice initialization (i.e. ::realized() is invoked) is
    container backend specific.




> Eric
> 
> 
>>
>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  include/sysemu/host_iommu_device.h |  1 +
>>  hw/vfio/common.c                   | 16 ++++++----------
>>  hw/vfio/container.c                |  6 ++++++
>>  hw/vfio/iommufd.c                  |  7 +++++++
>>  4 files changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
>> index 20e77cf54568..b1e5f4b8ac3e 100644
>> --- a/include/sysemu/host_iommu_device.h
>> +++ b/include/sysemu/host_iommu_device.h
>> @@ -24,6 +24,7 @@
>>   */
>>  typedef struct HostIOMMUDeviceCaps {
>>      uint32_t type;
>> +    uint64_t hw_caps;
> please also update the doc comment

OK

>>  } HostIOMMUDeviceCaps;
>>  
>>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index b0beed44116e..cc14f0e3fe24 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1544,7 +1544,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>  {
>>      const VFIOIOMMUClass *ops =
>>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>> -    HostIOMMUDevice *hiod;
>> +    HostIOMMUDevice *hiod = NULL;
>>  
>>      if (vbasedev->iommufd) {
>>          ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>> @@ -1552,21 +1552,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>  
>>      assert(ops);
>>  
>> -    if (!ops->attach_device(name, vbasedev, as, errp)) {
>> -        return false;
>> -    }
>>  
>> -    if (vbasedev->mdev) {
>> -        return true;
>> +    if (!vbasedev->mdev) {
>> +        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>> +        vbasedev->hiod = hiod;
>>      }
>>  
>> -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>          object_unref(hiod);
>> -        ops->detach_device(vbasedev);
>> +        vbasedev->hiod = NULL;
>>          return false;
>>      }
>> -    vbasedev->hiod = hiod;
>>  
>>      return true;
>>  }
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index c27f448ba26e..29da261bbf3e 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -907,6 +907,7 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>>                                        AddressSpace *as, Error **errp)
>>  {
>>      int groupid = vfio_device_groupid(vbasedev, errp);
>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>>      VFIODevice *vbasedev_iter;
>>      VFIOGroup *group;
>>      VFIOContainerBase *bcontainer;
>> @@ -917,6 +918,11 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>>  
>>      trace_vfio_attach_device(vbasedev->name, groupid);
>>  
>> +    if (hiod &&
>> +        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>> +        return false;
>> +    }
>> +
>>      group = vfio_get_group(groupid, as, errp);
>>      if (!group) {
>>          return false;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 873c919e319c..d34dc88231ec 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -384,6 +384,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>      Error *err = NULL;
>>      const VFIOIOMMUClass *iommufd_vioc =
>>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>>  
>>      if (vbasedev->fd < 0) {
>>          devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>> @@ -401,6 +402,11 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>  
>>      space = vfio_get_address_space(as);
>>  
>> +    if (hiod &&
>> +        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>> +        return false;
>> +    }
>> +
>>      /* try to attach to an existing container in this space */
>>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>>          container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> @@ -722,6 +728,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>  
>>      hiod->name = g_strdup(vdev->name);
>>      caps->type = type;
>> +    caps->hw_caps = hw_caps;
>>  
>>      return true;
>>  }
> 


