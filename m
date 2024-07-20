Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DD5C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 20:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVGoQ-0004fK-LQ; Sat, 20 Jul 2024 16:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVGoO-0004ef-OG
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 16:36:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVGoL-00076Q-DS
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 16:36:12 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KKUvc8027565;
 Sat, 20 Jul 2024 20:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=dFRvah2xAyU+NRHCFUf5VDcxNtjlQ+7VfWFClWri14o=; b=
 dCa74IVh+VSn+wbEpppONomcxaCh+jko+xj9ovI8vxfmYB/7bWdFswMFJKNey+7m
 HlQmB8SxJAi3mfg82kGpQJnTP/zy8L/oibSZjAZ7+S0VmYvJe7mcVC2kEMgKl6n2
 TLXFI5uLxIz/WX80W0WwwcgIHJ6dX5Syj55ZlJY5GA91m6zLt1PpsBxoW8KKpF7y
 lFdkDYv94iTjsu3oC9PA0faSkVL+V0VJNpt8/v4CVZs4RemoJR6jy/vhcCs9vEAn
 1yDgB635LJXMJT8p/EO5xTuCz6ALeZObov05SJsN2IsUScQbefXuwPh6H4QCYzPz
 ljGu+nyuH9Awc9bNVc+FRw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gmb3004s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 20:36:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KHKZog035013; Sat, 20 Jul 2024 20:36:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3pbqvx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 20:36:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGHkF26/amgg84F3Na7pCyC68gLCQMyHWjCX3aXt7KX4O42JPYQmza871D652LRXSu9YvBA/cna9bYmbSmN2Zu+7BCM+RRCO9BA6kY2PToIeUx9zabFsyuDjxqnq2N1VA3fyPBSMlsHq1NQKxIQH3dT7YTK1ok4WhPw0aIeGH1Ja46t280NkyCDdqDfvLj2jGKw86g0HOy7fgmzy21ois1Pj2xhELCgmn9zmLRsrcskCk52TjDzH5miM5Fdw2mrg0oMxzQKtvk0LkYolKRm9lCMJtHg6ovOS/dQiOEuM9IR3W/D3V8VxCC8VoDNz5kzim1z3mS+w7At2jZX5U65uiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFRvah2xAyU+NRHCFUf5VDcxNtjlQ+7VfWFClWri14o=;
 b=FYPR0drsb5yF6Ht3Vhtj7HnEFG27ntX1EIrqgcF7T0C/KjhIExqR+l2FSik7REvwGeUvZQdjy3CDvbrPR2qWq+ODbIXUjrJHwBjTlg85gIvj3SuuODWidd8q0nIJgs/vyw4sH9pLq/dJdfYK/u8fQWwtTNCyTivjjho4f5oxb1XWc4yEAXklbMATW6oiSuaU5jmUQJhiKavXQN58QoAICKy5N7j9grInRS+TioMOFbQeIXnG7EbkApD45CXTVvpV+HItCwh7pG5jfueyytL3H49pPrLDnsDVJQUQvvcwUHaACY1Vg02ooRhQmgs88eqrt7811BT+rp3KX2HXKTZ6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFRvah2xAyU+NRHCFUf5VDcxNtjlQ+7VfWFClWri14o=;
 b=vfHf3KHNx1M7uwsBHs9pjY2eo+XtISeDooQs0rC6nKFR+lCV8Hhj69Wj+mAkrFkJY65uNmR7Am9O1C4ChXMlV1NLVCOKFXpErFqaDGgyiGut763CYzLRfEriWYOwPdWeDqIRXypgk0Gyew6zmNlBs4/SE5Ju1JMN6yrJTyaAz70=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB6583.namprd10.prod.outlook.com (2603:10b6:303:228::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Sat, 20 Jul
 2024 20:36:00 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 20:35:59 +0000
Message-ID: <c6695695-5a2a-4522-8fed-79b33af62892@oracle.com>
Date: Sat, 20 Jul 2024 16:35:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
To: Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <ZpgaZPxKzwcVAYZn@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZpgaZPxKzwcVAYZn@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF0001640F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c63964-e8df-4b87-ab02-08dca8fb9095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0tQM01WdHMwdThJTlBZZk9vZXhSemo5TllCa2dMR1hWbUs3bSs4N05IdndP?=
 =?utf-8?B?ZmY4RWw1ZTF0dHNzZm84RldLOWtOeGwzT1JqMW5DYTN2Rm9NVnlNTWtJVFU2?=
 =?utf-8?B?UFVSallPOVpQMk1tU0xLN2NDaVlTelFEK2hJZFVvRkZ0SG0yU0xWeHAxOW42?=
 =?utf-8?B?L0FYaW5nVnI5M2IzYmg4V0N1YWkxR2Mvb0ordmVVRjNCZGZyNXZBOVV3WEJB?=
 =?utf-8?B?Mys2RjNzSlczOTlDSGZhSkF2b0pVanI2V2dkaFdxMWlmbnRyM0ZJYmkrUzdK?=
 =?utf-8?B?NlpFcFBDZUhSSGlFL2lJN0VNOEdaK1IxMFVHbXV0UUVVcXk3L1F0ampHVnM4?=
 =?utf-8?B?VHI4Sk5TUzJqMGIzRU1ENEFxbUxFRjViYWZxblU1dTU4akJGZ1JIcGpjS3Av?=
 =?utf-8?B?VWJCbEhIYXYvamI5NGJHc2xDd1Y1WGRkTGVmNlp2aWgzUXhvVTdTeEpJYWsr?=
 =?utf-8?B?NDFvYzZBVG5qNnlOcXBZUVkzL3FhUm5IRFY5RnViVUFJSXNGZUtCZjBtb2F4?=
 =?utf-8?B?RVdGMTI2Qi95V2htMVhaaHMySmFmRDREQkJhSzhabnVuRXRkS2hMNEVxUXFO?=
 =?utf-8?B?b3lDcHd3MzVzQ3cwNmhiNENLbkVhZDhxWjBOcFNwcFZ3MnFGdGhOQmZ0cWlE?=
 =?utf-8?B?UTNPcnZPcWIyRVZGclBKNVBpS1NpWlgvbEYzWkoyektlZjBZaWxQb0p2L3lQ?=
 =?utf-8?B?SzlGcXFCanlqa2hyVUpxMDErZzNacm8zV2gzelNPbjZIcE5ady9XZmJjd04v?=
 =?utf-8?B?VjY3aTRnbzVzUHJ3LzdQR0tPemxjOHpDb2txKzg4cDIvZk9mOVBTQlJsMnZ4?=
 =?utf-8?B?SGtqY0NmN28wTmREeWROYVJ3WDBCOXJrYURkWHczMmxxK0lqcmhmckxvbWt6?=
 =?utf-8?B?L1pDMUVvTnBBRmtXZWR3dExtZGRhR1loRzI0UEFqWXlaSWFLVjN1QUEzUVEr?=
 =?utf-8?B?UUgvNklienJwN3Z4dHQ2UGNHVnlZVm92VDBmdzBvS0YrekE2U3E2VlBCTXBt?=
 =?utf-8?B?RkE4aTRmM0JWOGRQM1g4a1RHVUZHRWhMSjE3R2JBREhodmRpVFh4MnFja1I5?=
 =?utf-8?B?bHl2clVsSXpWUktESjlwTytyOUFnTzAya0t3S2F6YWRDTHZadFh4MVlCRUZr?=
 =?utf-8?B?S0hUeklna2hvejZLVERlNUwxRVgvMGJzTGdiczM0cndtYlZkRGFEQ2kzaWJV?=
 =?utf-8?B?QmZUdGN0T3V3dzJ0Tm9zblE1bStVdXp4dXBQNENsWUpyZGJNbTRDdTkwUHM0?=
 =?utf-8?B?UmRyUHMxUDlodWpiSXhmV09IVHpSNU5HVlZUWFcxUnhPcG5hMmhmcC85WUZz?=
 =?utf-8?B?QVMwYnNCdGJ4dHNFb3ZCaGlOeFkyWWRENVdVK2xxYlYzQVdSUGRjV2ZiQ3hF?=
 =?utf-8?B?UzBJNGd5bXY0aC9jTy9DR2FkS0FvOHM5Ui9wWTFqVWE3MDBQZU5TOEU2dGFa?=
 =?utf-8?B?RzJoQUNyZkNJeVhuTXR1T1I5d1pSbTRJSEtKODJNOWRFVEdGU3dWcEpVeXhN?=
 =?utf-8?B?OFNjK1BVaFFYbmxpcElzZWZtTkJMVXRWZ3ZlNVlPa2R5bzEvOHJZYkxRSVcx?=
 =?utf-8?B?VEtCVWs3T1BRSFFxc3VNVmQ4eUNuMUpPRVZmWXhDUXk2ak5xcGZCREJpRWJz?=
 =?utf-8?B?Y05WdmJ0cENScXlIZTc2bEFZcTVQTThqTTg4RURLUkpCZWYyeFg3RUx1QVBl?=
 =?utf-8?B?UC9jdHgzQ0NPV0NscER5UWFqL04rUjkyaEtGZkhINDdmSDNtZmtLUEJLeU5G?=
 =?utf-8?B?QUZhclBoNnF2bTY4bmlwbUFuM3lhT2x3ekk0Q2Y4L3l5Q2VEUGZZZHF4c01D?=
 =?utf-8?B?NmE4QmJPTDA5bzdlaGY0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2d5a1dQbHlEcmNGMzNTVm0zY1k1dkFTMVVYTjNyRVFuRmdGZWlZdk0xOWYz?=
 =?utf-8?B?K1hjaE5LVlRhWnVZbXNxS3NpNDFDQmNOMXdCaHZ4QzFmNHphdnd0b2MyeWIv?=
 =?utf-8?B?a1ozQmNON1l6UlhlREwwUW1FblhmbGlGQUZsL3hpM283WlRXaWRuWmR4UHVp?=
 =?utf-8?B?SEZiTkZZdm5tYlRkTTMrbnlrQjJHOFlldytnbi85UHVEMVExKytzbTJGWkcv?=
 =?utf-8?B?RW5IUGlpakNyNlpDK1g5Z0dQdHBxZE1Odzg3VHB4K3FSSGtmK2pGYkxSVkxK?=
 =?utf-8?B?L3ZMQldOakdNNzgvL3JGTHorK0xYdE1JYkN2cHpJYUx3SDVMWEV6QjJjYzl1?=
 =?utf-8?B?MFp5L2t6bFFSY1duQkY5UE5CRSs0cjdYQ1FaZHBLTlk0d0JuV0V6cWpvUkUw?=
 =?utf-8?B?TytFSzBmb1RtSzJTWXpQalN5UzlKS1hOWEd3c1M3SGxkQ08zejVzRFY3ZGdT?=
 =?utf-8?B?TVdOdFVJaHR1ckhrMFF1TDJvMEFWMWtUckJMMzlrTWNwdy9STWRpSFRrK1Bh?=
 =?utf-8?B?QVFrME9RWU1YOUJMYmRkU2RnMkFSczhtMmk3ZFhxdmRqMjd5YnJnRzkxVUI1?=
 =?utf-8?B?SnpURXdFb3lEYVhzNzB5dCtSQW1pK3dDT0Zka1FZZHJUczFvQmpvS2NTay81?=
 =?utf-8?B?Y2JtVjlaNDVhNldlSGNScGVjMWJtanFYUWxqWDlualhRUlpPTDN4TU0zWHRk?=
 =?utf-8?B?amNmMjUzLy82WEJBSzdyemFyL05ZTFRPQjF5anJHaDVqTmhuSVR6Y2kra05H?=
 =?utf-8?B?akF0eHBHa0Y3KzBkL1FzU3hYZmtwUGRHNHpNK0txaHMzd0M3SHMvcEp1S2dz?=
 =?utf-8?B?NFgrb1RwbGZlcjJzQmROU2wvVVZsZDROdHlSL3JqcTZIZnJQRWhFOUNLQVpL?=
 =?utf-8?B?cnZKT0g2cjFycURuUnFQdVFjVG1PWHo0cm1hM1FIZ0V0SnljcHNHRkliMlRG?=
 =?utf-8?B?Sy9weTNGSkhOSUJ1ZGYvNHdHNmN0MEdOQ2paTktUQlBGQUZQdkd4NVlza3Nr?=
 =?utf-8?B?WWg1YzYzYTE0NjliQzhHaWRSZDJPY2dDRWdFU0J0T29kdVNOR29RUlk2ckRz?=
 =?utf-8?B?a1JJeFlaZXZkZko4b25KdVoycFVFcDRod0VURFNibjFyTzcrNE9iWUkrTm1O?=
 =?utf-8?B?N0hLYTBWWkFyaU04dXJVN1c2U2liUUs3N0xBb3VMTkpmQVRuUC9TUGJSOTdr?=
 =?utf-8?B?Y0hEaTg3WWcwUUdWUFhmSnZyU1lCZzVDcGM4TDkyMWE5RHpGZW04b0FHUXNn?=
 =?utf-8?B?M2gwdzF4VVNtMXB6d3JaU0grSWRIZEhqVHBJbG55NjlWL2ZVeUNTYVVTMkJL?=
 =?utf-8?B?allyQnJtUThTaTkyTzJPbG1qTENvMDYxc3VVMGQveXhkNUpLalVLZHlrOStu?=
 =?utf-8?B?RFh5ckM0dFNQbHVOZkx4UytzaFZ3Q2RabkRXc01IeUFnTVRjSEJheVMrWU1w?=
 =?utf-8?B?YTZXSjBDVTNnZTVGa3hyTzIzaE8wRGsrMlhRaEJSSU5EQjNKVEpZTVVvTXhO?=
 =?utf-8?B?MHhWR0FudXdMRVpOSFpSZFJZdmNpM2YrRDAySTF6Qkh5YlJtS2lDbWJhSkgw?=
 =?utf-8?B?alBaZEFkTTBINHpRQitZeHdlbXYyeUFCZ3p6cTBIbm1qazBCdmkyL3VWK29C?=
 =?utf-8?B?UEhKOFV4azFtSUg2WXdnTGRnRXNhcmpuSFN2RGovb05CN0RNQ3NhbUVWLzV1?=
 =?utf-8?B?ZGw1U09FNVVVQWJBMGo1N3pUNDI3a3QrTXZVYmZwNFBXSE1iaGRpbG4wOUlK?=
 =?utf-8?B?Z0g1blE1aTJONjNMU1dVeTg4UlM4RllqZWI4S01RME1YcGZsYllZT2hISUVx?=
 =?utf-8?B?OUhMQnRpaDUyWk05ZHJmWnNmN0g5Q2NQTDVQcjFrcHBUMTdJRFgwWkFHZU82?=
 =?utf-8?B?RFR3RkdqMGw1Q0RyMVkwczVTcmV3bXdYREtGaTQ1NWdxUWljY3Q4RGl0VWRE?=
 =?utf-8?B?ZzcwdE1TQmxoSXRYdWdXVUxxM3VrcDN6SFZxcUJLTzJ6ZFBEdU54Z2lKd2to?=
 =?utf-8?B?VWNXMDgvNEFMOHJPMm9PSlZnZGdYVlRUREQ4alR0VWVXOGhIR0xqRHZjZHVJ?=
 =?utf-8?B?dzZtVUk1Rm40My9XR2ZmMzIybGd3TktTakwzTmFJNEhzQWNkbzN3R1d4NzA1?=
 =?utf-8?B?QVlOaGd2b3RWSHFqM1pydEFrZktCVEVVcTU4NmpuN0tPakFMdU01bzN6clBZ?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ws6v8wrVz/jHSxxKyT1CMqtv+ciKqqivQs5tqxpHCjxB77XR5cuYwjjafe70msv5nK9ojuk4Mi9Fi8tKN7H2ZM3xA2npyq7d7yto1GY6yc1X0aUrZlQt3nqfyQt8ku0UVgR2vF+xbH66r/YX6D8WMZz4kk7xBNVNJPh5RMhN79mTm/DkGAROlBmSJW/LiZwdL5+pOReOhZHULYVKlr4K/xYdd7vnyvsDBWX604fK89DMkVxHhQrJJhEcabiWLjfsNtoR8R+vMRcfzp7JICD96bPAIopqzu3Ykl6/MVvT/uqDkN0zTWAtjlk7/8c1YqypDiLK7i56EcK9HucezC5Rjp7GXagHACZyVCBZRscp0M5ccimIJr+cKsGJNWRZEQc+Z0pMzrg7G24Dhm9aJzbhdQtAPIZkNH9gzWSi8BTsWKWuoODo59e088HUATtWBUsSnqeUg1ltfNQbc/qSOBRD+FJjQGrfMVwkeswjh0pzpBo1BYXhVXX8OZI4CT7mV9F9ScsmIGmihPytR4UTwZhJaAzuzuK0QcgwWUoTU5lAER5ZLbCQ1MiGSBNDd3qF/GHsYqHzrVCNpBMtFlWyVwoGkB2DbiiItTtHjNLRd+MLCQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c63964-e8df-4b87-ab02-08dca8fb9095
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 20:35:59.6627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MWDWctAPZJ4EtLdOO+KGJAc6V3hA+mvv2uVIgNX8+47Yd8NTHjsVZpNkD6WJnq34Ww3/QUhBRKFWtuj/1x0jtmCOljb1RJdSSrJ4Q3n/4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_19,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200150
X-Proofpoint-ORIG-GUID: GpSJBvb1pzrCG7RJwy0l_J9EiZ-AVbpL
X-Proofpoint-GUID: GpSJBvb1pzrCG7RJwy0l_J9EiZ-AVbpL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 7/17/2024 3:24 PM, Peter Xu wrote:
> On Tue, Jul 16, 2024 at 11:19:55AM +0200, Igor Mammedov wrote:
>> On Sun, 30 Jun 2024 12:40:24 -0700
>> Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>> on the value of the anon-alloc machine property.  This affects
>>> memory-backend-ram objects, guest RAM created with the global -m option
>>> but without an associated memory-backend object and without the -mem-path
>>> option
>> nowadays, all machines were converted to use memory backend for VM RAM.
>> so -m option implicitly creates memory-backend object,
>> which will be either MEMORY_BACKEND_FILE if -mem-path present
>> or MEMORY_BACKEND_RAM otherwise.
>>
>>
>>> To access the same memory in the old and new QEMU processes, the memory
>>> must be mapped shared.  Therefore, the implementation always sets
>>
>>> RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
>>> user must explicitly specify the share option.  In lieu of defining a new
>> so statement at the top that memory-backend-ram is affected is not
>> really valid?
>>
>>> RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
>>> as the condition for calling memfd_create.
>>
>> In general I do dislike adding yet another option that will affect
>> guest RAM allocation (memory-backends  should be sufficient).
> 
> I shared the same concern when reviewing the previous version, and I keep
> having so.
> 
>>
>> However I do see that you need memfd for device memory (vram, roms, ...).
>> Can we just use memfd/shared unconditionally for those and
>> avoid introducing a new confusing option?
> 
> ROMs should be fine IIUC, as they shouldn't be large, and they can be
> migrated normally (because they're not DMA target from VFIO assigned
> devices).  IOW, per my understanding what must be shared via memfd is
> writable memories that can be DMAed from a VFIO device.
> 
> I raised such question on whether / why vram can be a DMA target, but I
> didn't get a response.  So I would like to redo this comment: I think we
> should figure out what is missing when we switch all backends to use
> -object, rather than adding this flag easily.  When added, we should be
> crystal clear on which RAM region will be applicable by this flag.

All RAM regions that are mapped by the guest are registered for vfio DMA by
a memory listener and could potentially be DMA'd, either read or written.
That is defined by the architecture.  We are not allowed to make value
judgements and decide to not support the architecture for some segments
such as ROM.

Alex Williamson, any comment here?

- Steve

