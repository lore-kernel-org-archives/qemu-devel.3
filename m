Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6070CAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 18:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw2nm-0002P2-Nq; Tue, 09 Sep 2025 14:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uw2nj-0002OQ-6S
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 14:10:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uw2nX-0001V3-18
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 14:10:42 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589FtfPT011860;
 Tue, 9 Sep 2025 18:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=wjb5HQv88J55xfPH2mvvYZSkWo7Tcdh1b7+kaYS2IEg=; b=
 ElzxE6yZK9I6cw5Sc8m5DBO2cemuNVUPDXXR0ZtDJI0ogSopwlpraSfAemNH5CkM
 oo1ofVs7fT3mg5gfHDxCdM2tAI6UsgMebP6tpLVwMCenpy7eSeGpO1ON9bltLKzi
 YBDYE5wCf1BAU1ORQZ10eUKxWiKbRsS/RZ9st4kOVej+9cRNkHaIuOi0QF5fvChw
 ZVrWJUR6WBDq7wlduBCINxX7YD6hP2dLR1A8QmjG1fRTPEIh4lujq5aRwn+GJigk
 ywiveL5+LOnfXKIuRusjEO5e85B0w+nDHmSWnbPGIGVW8rL/jkgBEbLr3QfcQ9vC
 h4y8/sJ6AdSNsdfy0TWK+A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921peanr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Sep 2025 18:10:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 589GPxMh038818; Tue, 9 Sep 2025 18:10:24 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010014.outbound.protection.outlook.com
 [52.101.193.14])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 490bd9yu9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Sep 2025 18:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e66RTM6MDEak7J5amYZfKuNDERRkFZ72HOBzQ8/pYMeHfI3EEuMcEKNyuukTUyaIsihmaxgZXxSJ5+nqdL5chdKMVCRIebMyM43t0FEYwPifaWRQ3biToYbxc0ou8WuwANJmkVwhjcH/AiJcKzlTUmraD9WaLZ2nWQsJV/+IOpfBPSP86xeP8FVx69FxIvNhAnoRLXecTjVoKbS2hiGdkTPJLN7ZNwmuKAIdKcow9auvkG81amnTC31zDTEWkKtp40FrcrSduZVvX7feIWghpZmMLv+WTjHC2dQBJSrNZVDSTyfeNwEG5NvP3J+pOmrchZeMJODaGCqj6uF2OkjXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjb5HQv88J55xfPH2mvvYZSkWo7Tcdh1b7+kaYS2IEg=;
 b=FGfkjR/yOl5aHaIuCHn6PCSqTiRZOvvR1HlPz4+fKVV0v36b/i8l94zDUx4i095VWyEe4vTKpFeq2vO9pp2tyEp+MoCDpjSK8ov3Qa0pmJ6N/CzF1N7t1EQFRYpDcwewh4btKt9xqJ5u99hH3a9QVkCXSHhp5dWG7TZI5Pkt6FY4eC503w7I+oypKikNrxnPK9MzOMCd72nDr/hfjAcHNdvd0hJDV6xqwdEDxVtypTgIav89rm3LzGhLpu41JpNTXNCGObJPLfa0gnTspeTDU3qfuOajmtnoxlSkxk75RZmGtRbNHTJWS+qTKM4lxOxI4HG1rzhkoiVlSbI58/seIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjb5HQv88J55xfPH2mvvYZSkWo7Tcdh1b7+kaYS2IEg=;
 b=gp0XOnr0kIKG7kXrUL7/pfUv3UtECTp0IInI5h3+6CCWbjn+ZhT1VSROicC2F3KURRR6kEbQjpAWvRTlGj+tOcOnOPeLhUHhQGfnQ7NcQbHKmNYyJP2Xv1f6ZGoWikzeZe0V4waWhGiK24KC98O0/HaubsNHJQKIDttIxVBY77Y=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB5971.namprd10.prod.outlook.com (2603:10b6:208:3ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 18:10:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 18:10:19 +0000
Message-ID: <60f44830-d306-4dec-8f0d-65d3b32b3a2e@oracle.com>
Date: Tue, 9 Sep 2025 14:10:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 7/9] migration: cpr-exec mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-8-git-send-email-steven.sistare@oracle.com>
 <aMBWjBGPnmz3rtwh@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aMBWjBGPnmz3rtwh@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: a876c727-6f42-464a-e6c8-08ddefcc222e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3NxakkwUGJQc2diZXlpYlpwUEpCQ0RJSCtjbkcvUXBkMitXY245NG9SaXdw?=
 =?utf-8?B?bDVLYVRFN0ZiR1U5SEJaN25NYm85WDNJSXFPTTNEVjhiNE9JNFE0dmh2Tkxr?=
 =?utf-8?B?ZFd1SG1oWGVUTkhjeCtieE1mQkxuWVE0Y3c1Y0FuTzhwVkhxbTlFVkRKSmZr?=
 =?utf-8?B?Y1IzSDRPYm90QVNoSVZYT25tM2Y3VHR5RTc2OG5HN2Z2VEhtUzJubjAvaUIr?=
 =?utf-8?B?bVRjcXpuQzdNSHJLS3FCc2h4OURXWDlXbzUxQTdHT1BtMUV1a2ZCbHpLcUsz?=
 =?utf-8?B?OThUemhVby80Zm14OExYeHE0aEVKcHhzbWVDUFg4anRxb3VjZHJIUWVJOUV1?=
 =?utf-8?B?eEpNTXE3VVNCcjlIS3hhOTYxbXN6ZGVUWkR1OUNXbjg5TG1RaGVDWGo3Wkpk?=
 =?utf-8?B?WlNzWTYzVFY1ZG5laDBBWXp3elZiNHA4d1d4QWZLeStpcXpkN3h5b2poSGhV?=
 =?utf-8?B?K1FDMmR6RUNkclQ1SENCdDJpdWxnL0dmR0xPYlhpV2NSRmI3LzVlZ01jVDhY?=
 =?utf-8?B?N2tQaS9FOVhzQTlHSWJFb2hHdGdiSE9tdG54Z0pmdU9pNGhQaXAzbGh0V1dO?=
 =?utf-8?B?MHJrZk5XbHpxdUhLZVFJVjFkaCt1cDYzdS9uUkRhbnA5NGxkd1ozSExMV2pw?=
 =?utf-8?B?OVgwODZNU1NxQU5hSmlhWDVlVUtBN21sRDdWTDJUTDRPaEtxY05ONE9ZdFRW?=
 =?utf-8?B?NVArd0VhOXArRklIR0tSNUNHVkJ3eW4rK29vdjdSanFoTjhtZVBVa2MrZW4y?=
 =?utf-8?B?VUtlVmptVS9ZLzhHV2lRREp1K1Y2Y2xtV05BaUg4TzNTMlNSQ2FoRXJRM0NZ?=
 =?utf-8?B?MWtoS1BiYmI3WHJhQklUekcvRTJRTGhQRndHMm4zZjdZcjdISWtEalAzK2hv?=
 =?utf-8?B?WFpZTmtxU2ROSG1oOEhZTDV5a1N1Y09JcUNabUN1cGlVc245VitSdVFqcDFW?=
 =?utf-8?B?MEp5eklOMGRzNEsyZkdUMGFQeG4xN3kwTE1uN3k2Q1VXZEJROXVwc1NGdDhR?=
 =?utf-8?B?Qm9ybkZGeHJJdlZTcnFieGZiY0dDbWdPZnJ1ODAwWG83SkxJQTNIcHp3OHlK?=
 =?utf-8?B?NXExVUxPUE9pL3ZmeEtFTW80UDlVR2w4c1NhWVlXTnM1RGxWdXpJeGJlNkdM?=
 =?utf-8?B?K1I3dWpqNmtTSHRGLzNxdFVHZGx4czBHcHByK3lhRndkU3ZUUjRaOVNlQ0xD?=
 =?utf-8?B?QURFci9URUlrZTFYSVRjNkN3SUpXVjR4UTVjUllMem83bVFkalhlMStJVm5p?=
 =?utf-8?B?cHlGVjl3eDc1eVdHUTlBcGUyTTFLL2t6SnlRVFRSSGpBcmtRRjZyeElTRDRT?=
 =?utf-8?B?R2J0b2xUMnJQZmFJcmVNanlNeXpnVzZBSVBnMDNPdmRvMkFOby9LWEg4S3Fs?=
 =?utf-8?B?SFN0cjhoU245SWdGY2ZvbWx5WkRadHRXY0ExclkrajBIRERrZVBqM3pFcEh6?=
 =?utf-8?B?U2dqN2pXeDh3U1JMZTd0SG9FcGFMK3JWSitKYmlzcjBFTmhvZU1NVWwxUkJF?=
 =?utf-8?B?eVBDV1lSaDhqWDlDRVNKdWYvNkhMd1JITTJmbGd1Y3hqVmhoamR6bTlsVFJB?=
 =?utf-8?B?QzllL3RTbm1nS0pYMWlCdG84OEgzK0pPWkxodFJkKzF5Sm0vRjZoWGFEcnVv?=
 =?utf-8?B?VmVmZThIQmhnL245OXNQMWZ0amdSeU03a1JPSmovYzZVejJ6RThHVWhKQi9H?=
 =?utf-8?B?RDdqZmkvY2tMbzVZMnB6N3NDUjVuK2trdkNiL2xMZTRieWV4S2pyYmxXblZF?=
 =?utf-8?B?TnlxRmhhN2o2OVNmVzBVMTIyQlVzREVpSytRd0M5QWJnbzNpZWRYbzVIbHRP?=
 =?utf-8?B?TlJOUC9FK3QvWXg3aldHU3A5dlhDMFNJZUwzV042UVBLMDhKYmRBSFNYblJU?=
 =?utf-8?B?cEd6ZEtjZHJZQzNSSmdVdGpCNHA1aWk0aFNPYS8vTERLRjV3elJCejBKU1py?=
 =?utf-8?Q?HwBLPvekcJ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3N2VjRxaWk2ZHVobW9vL2NCOThOQi9IRnUxSGxxT0hxck8rV3ZoWEQ2OHpN?=
 =?utf-8?B?Z29lVHQxdDFRN1M2Vms0d2pxcm40UmFjdTRrWlUvaTRXbGdtb2d1QTRLWGU3?=
 =?utf-8?B?aUk0TU4xb09OcUIxdmVwZEVudklhOURmV1JZeFNBQ1ppa1VqT09TS05qbnFJ?=
 =?utf-8?B?M1BKd3p6SUdKbUgvM2QrTmVFRE80UEZkNVl6NFF6Z2ZFUnk2UEZSbUVYMUxo?=
 =?utf-8?B?NFVwSjZ4WGprczlWRjBzanYwU3FDTXNPMVZFS0ZVYzZ5eUY2Q2l4Sno5dVVq?=
 =?utf-8?B?NGlmQVA5Nkg5ZnY1K3JXbkI2Uy9PT1BLcWJBbU9pU2dCV2VsbkN2OTdVdmtI?=
 =?utf-8?B?aGQ4dWJibFg3VE5PbFpTeS9YT0J6OXNBR3lqTGI1N3p2MmpnTmRtZkxuT291?=
 =?utf-8?B?NHloK2RML2lJRXVaMHZvSWw2Uk5udFYyTVg3eEd2WkJNWnp0b0hRMHBHQWpH?=
 =?utf-8?B?TTNNdEJzM0tYUkc4RkdyV2llSjRGQkxDaWVtUFp2aW5NeE51WGN1M1JtZVRq?=
 =?utf-8?B?dG03bGdOTWJYQlBGeW54dzdUZzlqTldjY3FyaGV0Y1ZRNm52a2I0U2lsZ1g2?=
 =?utf-8?B?a1R4Vk1Jb2ZnYUFoV2t4eVZGN05xTEovVnJqNzVoeFhIc0tPc0Jxc2t1dFBK?=
 =?utf-8?B?dC9HeFlRUkZpcmFHcXNyVDY0dGdubi92MlR0Vml5YlpwWEJ2a1lxbGN6WUNn?=
 =?utf-8?B?b3cwS3MyOWFpb2dHbnVSVldaclNYVUlrOC8zR0dYZGJpZ0JXWWxoTFU1VnFP?=
 =?utf-8?B?OGxJTmhOZFBFM2JGUm9YcEJucUFUamVCWExQMitwWnhoWXQ0TDRZblo3VHVa?=
 =?utf-8?B?QXFjNnpXb3V4UDRnWXo4WTZTL2ZtaHpETEtBQ0xEZldvM3ZRMzB2S1ZuLzRU?=
 =?utf-8?B?RkVvaVJ6T29DY0w1ZUN4N0RJckw4amhYTE1qNURLWjArbllDcjN1M3dVUFk1?=
 =?utf-8?B?d3VtRGJ4ZWp3TU9yNkp2NG5OeXNHUWRxcWdmZWI4dHdIL1dMN1RLbkVwOHpq?=
 =?utf-8?B?WE8wUHR1R1MxUUhZTVBjRHdaczc3Ti9IaU9tZWJwazJOUGFacHBSVTlTalZ3?=
 =?utf-8?B?RGdYNk5nNDU5VW14K0hrRnh1OTNlVUxhZG1hSktYVm9lMVllVngrRVNOQmFY?=
 =?utf-8?B?UkhETnNZcm5qN2JNclEydVhYM3YyVzU2TmdBckZMdGJmRFN0VVhKV0RnQnpx?=
 =?utf-8?B?aVhxVTZCRUExNXVoSEQraXdmcU1NTCtOMGJCWEZxNCtpK3lYVG5CZmtrMStl?=
 =?utf-8?B?NjBNdW1BUkE2VTgyOEQ2Ty9RZzQ1dG8xQnFiMFQ4MkpLKzlQZ1hQQzEwWEls?=
 =?utf-8?B?ai9IQ2dDc2hyRGQxVVBpakZWbjJLS3I3Y3pXVEpwbFlzUlY5OWhVcmNrVHli?=
 =?utf-8?B?NUN1blNmRHloUk9HbWY2RlU1Y3ZiQmFDd1pkOFhJVG04bWFrL0JLdk5jaEY1?=
 =?utf-8?B?K21WRSt2UWFRQ2FRN1NpcXdqb0Nndm5qRUhSN3FSbFdYd0c5SURQVjVLdTFj?=
 =?utf-8?B?QTIyYVFwTzlIdTc5SEdSZWxKU1pyV2x1aisrd3NxMlRDS1J4TXJ2dFdEd3hY?=
 =?utf-8?B?bW1PbEh3eFpSK1Qzdm50QXhia3N2L2Zva3dTNnAzcnRVOXhqOWgrKy9RL0Fh?=
 =?utf-8?B?Vng5N210c0VGNXVydVdiY0g0ZFdGQ241UUV4SFVGNGVkSEgrejNCZkk5cmlI?=
 =?utf-8?B?ZnRvT3BCbTc2ZmVKYjZlcHdZOGVycHBZTXBJQ2NjaEovWktIVzhvQXM0ZDM1?=
 =?utf-8?B?NFh1MS9DL3haRXFETGpSQlluY3l0Q1lLZC9EbDVySmlaM1FGV2RaSjBINVhl?=
 =?utf-8?B?NnpJdzlSN3d2MEE0WkxvUWwrNWg1TGJnanJmN3ExSERzbGNyNExyYUQ4UU80?=
 =?utf-8?B?STdUdUhvREk2eVUxVE42T3kvcGU3WkhpRjlKMHNoSUg2NURYZnVab0tHSCtM?=
 =?utf-8?B?TFg3Zmdtb2x6Zkl6dnZuSkNRLzNIa2cxenBVVjIyaGNKZ1YyQUVmOFNOT2VT?=
 =?utf-8?B?VFE2NnlCZmxZdTBmZldiYS9CM3E4cVM5Z2tXTXIzZ0JRUXBjS2VGU09la2hC?=
 =?utf-8?B?Mkk3Tk0zOWp4RU1zZ3hLZk94RlBOQUFBYlBlMkZFbGRQaFRHNG83RGlOTFQ1?=
 =?utf-8?B?L0wrdWR3MmIxc1dHdkRIMGhwaFZueFlJVDl5SHN4NE5lYktkWjJBbFhCT05S?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nKCVKPo0gd1gytqHUZwhLHasC8wbZoKKo6SDQl+3F2xoIDGT17c73Jt6I6LF6dHTRQBiHLby9+/EN8YGpsC7ZQLIWd6N5JEMNNENEjHc+ud/5xMOwci+Mf6+JQba/jV/h8hjc84d6MvTFA/IPNnQskgjlR9FDDRBcDuV3w3+YwPTy/PzjUhTA4oILMbUDtygf2PbLR4iLTKbpQ7UGA/PRIVRdsZHeSOR5SxyBNO3YAAnqX2RddT8ko5OulVxxr9ShH0ldTUW4en20/32OIrUUdJWGqzBZOFveyVcc7ZnMnarpFnCefuRrOzuUogFjvoQfpcBq76os3PfCr7kBx0gN4VdKyMYynMxSo1KvEQDV3muDkEMhF6J0x+eKCM0JANHPJx/hzoo7q1DK1VeIo+6DGohfvjBlAn+AX50rOTpg/3J37ZAx3GVsqdqoXhTiKajsfXYcQ3OmEk3pc3YSnBdoql6I7ehRi21x6BqFQToXBWCkcTsKvsaj0tQIozQK4oPl4L1r9YdvRpqGpQQbytL5Rnxr6VCSh2dO6ZHm/zeV/uaB7/LNgfJrKfDtlX0NkJpGlhTaWz3om9v1Onp7FOAHlWP9GwPyDS4JAbxuTaBHEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a876c727-6f42-464a-e6c8-08ddefcc222e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 18:10:18.9172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvHITct2dmk4fIDEToZ219kCp6dMlBzFXF/fq1nvKoSAL3o3aUK3GTvBw5twqSjDipyH7HcUoWd/kQX4CppQkMBN9nLOA6D6jEGJddXyE+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5971
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090178
X-Proofpoint-GUID: ey_GPx-QH_62_oB8UNo3PQ0zcqc6SDGk
X-Proofpoint-ORIG-GUID: ey_GPx-QH_62_oB8UNo3PQ0zcqc6SDGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX0Ass2pndbZ36
 ngmN6UeQ/+a2HPO37ePy/73QCERz/7TF8mAle7ruDwbss8+gtz1rqNsS2m0lHItEim6jK9LRkBn
 PFl6mOE/GIl/Z42hGCw8cH085gZiSsR+FXfSSMuMtVTxKv9q2Dz9567po4Yvh2pni/hAPqi21Mn
 Jps7NQ2bXm38KYSj9PsYsfRVcF3enbVUXp6CG7ZKmQSxrJ1nuHfnsI/lZS8E2fP+IjZ+j9Jcj1K
 KHqDwOnIUwPttDdvAQwGWEtuvXFQA7x9gIyaYSpwv1n6fMu+plluyOXTyzRCw31VgFtoAOzAuLR
 4f1+03BZR1d+juJzyrvDsFEnm5O/V6IHL/JENituDiNWHdBvwgXAShFnrx0bAl/BeUo3mnRAFjJ
 LunLNslPAKFkk1LGP5tqSd7RmTrWCg==
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c06d91 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=R3XiUvdEschiAbEbK6cA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/9/2025 12:32 PM, Peter Xu wrote:
> On Thu, Aug 14, 2025 at 10:17:21AM -0700, Steve Sistare wrote:
>> Add the cpr-exec migration mode.  Usage:
>>    qemu-system-$arch -machine aux-ram-share=on ...
>>    migrate_set_parameter mode cpr-exec
>>    migrate_set_parameter cpr-exec-command \
>>      <arg1> <arg2> ... -incoming <uri-1> \
>>    migrate -d <uri-1>
>>
>> The migrate command stops the VM, saves state to uri-1,
>> directly exec's a new version of QEMU on the same host,
>> replacing the original process while retaining its PID, and
>> loads state from uri-1.  Guest RAM is preserved in place,
>> albeit with new virtual addresses.
>>
>> The new QEMU process is started by exec'ing the command
>> specified by the @cpr-exec-command parameter.  The first word of
>> the command is the binary, and the remaining words are its
>> arguments.  The command may be a direct invocation of new QEMU,
>> or may be a non-QEMU command that exec's the new QEMU binary.
>>
>> This mode creates a second migration channel that is not visible
>> to the user.  At the start of migration, old QEMU saves CPR state
>> to the second channel, and at the end of migration, it tells the
>> main loop to call cpr_exec.  New QEMU loads CPR state early, before
>> objects are created.
>>
>> Because old QEMU terminates when new QEMU starts, one cannot
>> stream data between the two, so uri-1 must be a type,
>> such as a file, that accepts all data before old QEMU exits.
>> Otherwise, old QEMU may quietly block writing to the channel.
>>
>> Memory-backend objects must have the share=on attribute, but
>> memory-backend-epc is not supported.  The VM must be started with
>> the '-machine aux-ram-share=on' option, which allows anonymous
>> memory to be transferred in place to the new process.  The memfds
>> are kept open across exec by clearing the close-on-exec flag, their
>> values are saved in CPR state, and they are mmap'd in new QEMU.
> 
> Some generic questions around exec..
> 
> How do we know we can already safely kill all threads?
> 
> IIUC vcpu threads must be all stopped.  I wonder if we want to assert that
> in the exec helper below.
> 
> What about rest threads?  RCU threads should be for freeing resources,
> looks ok if to be ignored.  But others?

These threads are dormant, just as they are in the post migration state.
There is no difference.  They can be safely killed, just as they can be
post migration.

> Or would process states still matter in some cases? e.g. when QEMU is
> talking to another vhost-user, or vfio-user, or virtio-fs, or ... whatever
> other process, then suddenly the other process doesn't recognize this QEMU
> anymore?

These cases need more development to work with cpr.  The external process
can be used by new qemu if the socket connection (fd) is preserved in new QEMU.

> What about file locks or similiar shared locks that can be running in an
> iothread?  Is it possible that old QEMU took some shared locks, suddenly
> qemu exec(), then the lock is never released?

Same as the post-migrate state.
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   qapi/migration.json       | 25 +++++++++++++++-
>>   include/migration/cpr.h   |  1 +
>>   migration/cpr-exec.c      | 74 +++++++++++++++++++++++++++++++++++++++++++++++
>>   migration/cpr.c           | 26 ++++++++++++++++-
>>   migration/migration.c     | 10 ++++++-
>>   migration/ram.c           |  1 +
>>   migration/vmstate-types.c |  8 +++++
>>   migration/trace-events    |  1 +
>>   8 files changed, 143 insertions(+), 3 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index ea410fd..cbc90e8 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -694,9 +694,32 @@
>>   #     until you issue the `migrate-incoming` command.
>>   #
>>   #     (since 10.0)
>> +#
>> +# @cpr-exec: The migrate command stops the VM, saves state to the
>> +#     migration channel, directly exec's a new version of QEMU on the
>> +#     same host, replacing the original process while retaining its
>> +#     PID, and loads state from the channel.  Guest RAM is preserved
>> +#     in place.  Devices and their pinned pages are also preserved for
>> +#     VFIO and IOMMUFD.
>> +#
>> +#     Old QEMU starts new QEMU by exec'ing the command specified by
>> +#     the @cpr-exec-command parameter.  The command may be a direct
>> +#     invocation of new QEMU, or may be a non-QEMU command that exec's
>> +#     the new QEMU binary.
>> +#
>> +#     Because old QEMU terminates when new QEMU starts, one cannot
>> +#     stream data between the two, so the channel must be a type,
>> +#     such as a file, that accepts all data before old QEMU exits.
>> +#     Otherwise, old QEMU may quietly block writing to the channel.
> 
> The CPR channel (in case of exec mode) is persisted via env var.  Why not
> do that too for the main migration stream?
> 
> Does it has something to do with the size of the binary chunk to store all
> device states (and some private mem)?  Or other concerns?

It was not necessary to add code for a new way to move migration data for
the main stream when the existing code and interface works just fine.  One
of the design principles pushed on me was to make cpr look as much like live
migration as possible, and cpr-exec does that.  It has no issues juggling
2 streams, and no delayed start of the monitor. cpr-transfer is actually the
oddball.
  > It just feels like it would look cleaner for cpr-exec to not need -incoming
> XXX at all, e.g. if the series already used envvar anyway, we can use that
> too so new QEMU would know it's cpr-exec incoming migration, without
> -incoming parameter at all.
 > >> +#
>> +#     Memory-backend objects must have the share=on attribute, but
>> +#     memory-backend-epc is not supported.  The VM must be started
>> +#     with the '-machine aux-ram-share=on' option.
>> +#
>> +#     (since 10.2)
>>   ##
>>   { 'enum': 'MigMode',
>> -  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
>> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
>>   
>>   ##
>>   # @ZeroPageDetection:
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index aaeec02..e99e48e 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -54,6 +54,7 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index, bool cpr,
>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>>   
>> +void cpr_exec_init(void);
>>   QEMUFile *cpr_exec_output(Error **errp);
>>   QEMUFile *cpr_exec_input(Error **errp);
>>   void cpr_exec_persist_state(QEMUFile *f);
>> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
>> index 2c32e9c..7d0429f 100644
>> --- a/migration/cpr-exec.c
>> +++ b/migration/cpr-exec.c
>> @@ -6,15 +6,20 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qemu/cutils.h"
>> +#include "qemu/error-report.h"
>>   #include "qemu/memfd.h"
>>   #include "qapi/error.h"
>>   #include "io/channel-file.h"
>>   #include "io/channel-socket.h"
>> +#include "block/block-global-state.h"
>> +#include "qemu/main-loop.h"
>>   #include "migration/cpr.h"
>>   #include "migration/qemu-file.h"
>> +#include "migration/migration.h"
>>   #include "migration/misc.h"
>>   #include "migration/vmstate.h"
>>   #include "system/runstate.h"
>> +#include "trace.h"
>>   
>>   #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
>>   
>> @@ -92,3 +97,72 @@ QEMUFile *cpr_exec_input(Error **errp)
>>       lseek(mfd, 0, SEEK_SET);
>>       return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
>>   }
>> +
>> +static bool preserve_fd(int fd)
>> +{
>> +    qemu_clear_cloexec(fd);
>> +    return true;
>> +}
>> +
>> +static bool unpreserve_fd(int fd)
>> +{
>> +    qemu_set_cloexec(fd);
>> +    return true;
>> +}
>> +
>> +static void cpr_exec(char **argv)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +    Error *err = NULL;
>> +
>> +    /*
>> +     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
>> +     * earlier because they should not persist across miscellaneous fork and
>> +     * exec calls that are performed during normal operation.
>> +     */
>> +    cpr_walk_fd(preserve_fd);
>> +
>> +    trace_cpr_exec();
>> +    execvp(argv[0], argv);
>> +
>> +    cpr_walk_fd(unpreserve_fd);
>> +
>> +    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
>> +    error_report_err(error_copy(err));
> 
> Feel free to ignore my question in the other patch, so we dump some errors
> here.. which makes sense.
> 
>> +    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> 
> This is indeed FAILED migration, however it seems to imply it can catch
> whatever possible failures that incoming could have.  Strictly speaking
> this is not migration failure, but exec failure..  Maybe we need a comment
> above this one explaining that we won't be able to capture any migration
> issues, it's too late after exec() succeeded, so there's higher risk of
> crashing the VM.

exec() can fail if the user provided a bogus cpr-exec-command, in which case
recovery is possible.  exec() should never fail for valid exec arguments,
unless the system is very sick and running out of resources, in which case
all bets are off.

> Luckily we still are on the same host, so things like mismatched kernel
> versions at least won't crash this migration.. aka not as easy to fail a
> migration as cross- hosts indeed. But still, I'd say I agree with Vladimir
> that this is a major flaw of the design if so.
> 
>> +    migrate_set_error(s, err);
>> +
>> +    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
>> +
>> +    err = NULL;
>> +    if (!migration_block_activate(&err)) {
>> +        /* error was already reported */
>> +        return;
>> +    }
>> +
>> +    if (runstate_is_live(s->vm_old_state)) {
>> +        vm_start();
>> +    }
>> +}
>> +
>> +static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
>> +                             Error **errp)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +
>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>> +        assert(s->state == MIGRATION_STATUS_COMPLETED);
>> +        qemu_system_exec_request(cpr_exec, s->parameters.cpr_exec_command);
>> +    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
>> +        cpr_exec_unpersist_state();
>> +    }
>> +    return 0;
>> +}
>> +
>> +void cpr_exec_init(void)
>> +{
>> +    static NotifierWithReturn exec_notifier;
>> +
>> +    migration_add_notifier_mode(&exec_notifier, cpr_exec_notifier,
>> +                                MIG_MODE_CPR_EXEC);
> 
> Why using a notifier?  IMHO exec() is something important enough to not be
> hiding in a notifier..  and CPR is already a major part of migration in the
> framework, IMHO it'll be cleaner to invoke any CPR request in the migration
> subsystem.  AFAIU notifiers are normally only for outside migration/ purposes.

This minimizes the number of control flow conditionals in the core migration code.
That's a good thing, and I thought you would like it.

The alternative is to add code right after notifiers are called to check the
mode, and call cpr_exec_notifier.  Seems silly when we have this generic
mechanism to define callouts to occur at well-defined points during execution.

Note that cpr_exec_notifier does not directly call exec.  It posts the exec
request.  It also recovers if cpr failed.

>> +}
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index 021bd6a..2078d05 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -198,6 +198,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>       if (mode == MIG_MODE_CPR_TRANSFER) {
>>           g_assert(channel);
>>           f = cpr_transfer_output(channel, errp);
>> +    } else if (mode == MIG_MODE_CPR_EXEC) {
>> +        f = cpr_exec_output(errp);
>>       } else {
>>           return 0;
>>       }
>> @@ -215,6 +217,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>           return ret;
>>       }
>>   
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        cpr_exec_persist_state(f);
>> +    }
>> +
>>       /*
>>        * Close the socket only partially so we can later detect when the other
>>        * end closes by getting a HUP event.
>> @@ -226,6 +232,12 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>       return 0;
>>   }
>>   
>> +static bool unpreserve_fd(int fd)
>> +{
>> +    qemu_set_cloexec(fd);
>> +    return true;
>> +}
>> +
>>   int cpr_state_load(MigrationChannel *channel, Error **errp)
>>   {
>>       int ret;
>> @@ -237,6 +249,12 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>>           mode = MIG_MODE_CPR_TRANSFER;
>>           cpr_set_incoming_mode(mode);
>>           f = cpr_transfer_input(channel, errp);
>> +    } else if (cpr_exec_has_state()) {
>> +        mode = MIG_MODE_CPR_EXEC;
>> +        f = cpr_exec_input(errp);
>> +        if (channel) {
>> +            warn_report("ignoring cpr channel for migration mode cpr-exec");
> 
> This looks like dead code?  channel can't be set when reaching here, AFAIU..

The user could define a cpr channel in qemu command line arguments, and it would
reach here.  In that case the user is confused, but I warn instead of abort, to
keep new QEMU alive.  I perform this sanity check here, rather than at top level,
because I have localized awareness of cpr_exec state to here.

- Steve
>> +        }
>>       } else {
>>           return 0;
>>       }
>> @@ -245,6 +263,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>>       }
>>   
>>       trace_cpr_state_load(MigMode_str(mode));
>> +    cpr_set_incoming_mode(mode);
>>   
>>       v = qemu_get_be32(f);
>>       if (v != QEMU_CPR_FILE_MAGIC) {
>> @@ -266,6 +285,11 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>>           return ret;
>>       }
>>   
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        /* Set cloexec to prevent fd leaks from fork until the next cpr-exec */
>> +        cpr_walk_fd(unpreserve_fd);
>> +    }
>> +
>>       /*
>>        * Let the caller decide when to close the socket (and generate a HUP event
>>        * for the sending side).
>> @@ -286,7 +310,7 @@ void cpr_state_close(void)
>>   bool cpr_incoming_needed(void *opaque)
>>   {
>>       MigMode mode = migrate_mode();
>> -    return mode == MIG_MODE_CPR_TRANSFER;
>> +    return mode == MIG_MODE_CPR_TRANSFER || mode == MIG_MODE_CPR_EXEC;
>>   }
>>   
>>   /*
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 271c521..d604284 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -333,6 +333,7 @@ void migration_object_init(void)
>>   
>>       ram_mig_init();
>>       dirty_bitmap_mig_init();
>> +    cpr_exec_init();
>>   
>>       /* Initialize cpu throttle timers */
>>       cpu_throttle_init();
>> @@ -1797,7 +1798,8 @@ bool migrate_mode_is_cpr(MigrationState *s)
>>   {
>>       MigMode mode = s->parameters.mode;
>>       return mode == MIG_MODE_CPR_REBOOT ||
>> -           mode == MIG_MODE_CPR_TRANSFER;
>> +           mode == MIG_MODE_CPR_TRANSFER ||
>> +           mode == MIG_MODE_CPR_EXEC;
>>   }
>>   
>>   int migrate_init(MigrationState *s, Error **errp)
>> @@ -2146,6 +2148,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>>           return false;
>>       }
>>   
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC &&
>> +        !s->parameters.has_cpr_exec_command) {
>> +        error_setg(errp, "cpr-exec mode requires setting cpr-exec-command");
>> +        return false;
>> +    }
>> +
>>       if (migration_is_blocked(errp)) {
>>           return false;
>>       }
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 7208bc1..6730a41 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -228,6 +228,7 @@ bool migrate_ram_is_ignored(RAMBlock *block)
>>       MigMode mode = migrate_mode();
>>       return !qemu_ram_is_migratable(block) ||
>>              mode == MIG_MODE_CPR_TRANSFER ||
>> +           mode == MIG_MODE_CPR_EXEC ||
>>              (migrate_ignore_shared() && qemu_ram_is_shared(block)
>>                                       && qemu_ram_is_named_file(block));
>>   }
>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> index 741a588..1aa0573 100644
>> --- a/migration/vmstate-types.c
>> +++ b/migration/vmstate-types.c
>> @@ -321,6 +321,10 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
>>                     const VMStateField *field)
>>   {
>>       int32_t *v = pv;
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        qemu_get_sbe32s(f, v);
>> +        return 0;
>> +    }
>>       *v = qemu_file_get_fd(f);
>>       return 0;
>>   }
>> @@ -329,6 +333,10 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
>>                     const VMStateField *field, JSONWriter *vmdesc)
>>   {
>>       int32_t *v = pv;
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        qemu_put_sbe32s(f, v);
>> +        return 0;
>> +    }
>>       return qemu_file_put_fd(f, *v);
>>   }
>>   
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 706db97..e8edd1f 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -354,6 +354,7 @@ cpr_state_save(const char *mode) "%s mode"
>>   cpr_state_load(const char *mode) "%s mode"
>>   cpr_transfer_input(const char *path) "%s"
>>   cpr_transfer_output(const char *path) "%s"
>> +cpr_exec(void) ""
>>   
>>   # block-dirty-bitmap.c
>>   send_bitmap_header_enter(void) ""
>> -- 
>> 1.8.3.1



